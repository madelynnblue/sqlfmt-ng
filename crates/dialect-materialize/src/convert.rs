use mz_sql_parser::ast::{
    AsOf, Distinct, Expr, Ident, OrderByExpr, Query, Raw, Select, SelectItem, SelectStatement,
    SetExpr, Statement, TableAlias, TableFactor, TableWithJoins, Value,
};
use sqlfmt_ir::{Clause, Node};

pub fn statement_to_node(stmt: &Statement<Raw>) -> Node {
    match stmt {
        Statement::Select(s) => select_stmt_to_node(s),
        _ => Node::Unformatted {
            value: format!("{stmt}"),
        },
    }
}

fn select_stmt_to_node(s: &SelectStatement<Raw>) -> Node {
    let SelectStatement { query, as_of } = s;
    match as_of {
        None => query_to_node(query),
        Some(as_of) => {
            let mut node = query_to_node(query);
            // Append AS OF clause to the structured clauses node if possible.
            if let Node::Clauses { items } = &mut node {
                let (kw, expr) = match as_of {
                    AsOf::At(expr) => ("AS OF", expr),
                    AsOf::AtLeast(expr) => ("AS OF AT LEAST", expr),
                };
                items.push(Clause {
                    keyword: kw.into(),
                    body: Some(Box::new(expr_to_node(expr))),
                });
            }
            node
        }
    }
}

fn query_to_node(query: &Query<Raw>) -> Node {
    match &query.body {
        SetExpr::Select(select) => select_to_node(select, query),
        _ => Node::Unformatted {
            value: format!("{query}"),
        },
    }
}

fn select_to_node(select: &Select<Raw>, query: &Query<Raw>) -> Node {
    let mut clauses = Vec::new();

    // SELECT [DISTINCT | DISTINCT ON (...)] cols
    let select_keyword = match &select.distinct {
        None => "SELECT".into(),
        Some(Distinct::EntireRow) => "SELECT DISTINCT".into(),
        Some(d @ Distinct::On(_)) => format!("SELECT {d}"),
    };
    let cols: Vec<Node> = select.projection.iter().map(select_item_to_node).collect();
    clauses.push(Clause {
        keyword: select_keyword,
        body: Some(Box::new(Node::List {
            items: cols,
            separator: None,
        })),
    });

    // FROM
    if !select.from.is_empty() {
        let from_items: Vec<Node> = select.from.iter().map(table_with_joins_to_node).collect();
        clauses.push(Clause {
            keyword: "FROM".into(),
            body: Some(Box::new(Node::List {
                items: from_items,
                separator: None,
            })),
        });
    }

    // WHERE
    if let Some(selection) = &select.selection {
        clauses.push(Clause {
            keyword: "WHERE".into(),
            body: Some(Box::new(expr_to_node(selection))),
        });
    }

    // GROUP BY
    if !select.group_by.is_empty() {
        let group_items: Vec<Node> = select.group_by.iter().map(expr_to_node).collect();
        clauses.push(Clause {
            keyword: "GROUP BY".into(),
            body: Some(Box::new(Node::List {
                items: group_items,
                separator: None,
            })),
        });
    }

    // HAVING
    if let Some(having) = &select.having {
        clauses.push(Clause {
            keyword: "HAVING".into(),
            body: Some(Box::new(expr_to_node(having))),
        });
    }

    // QUALIFY (Materialize extension)
    if let Some(qualify) = &select.qualify {
        clauses.push(Clause {
            keyword: "QUALIFY".into(),
            body: Some(Box::new(expr_to_node(qualify))),
        });
    }

    // ORDER BY (lives on Query, not Select)
    if !query.order_by.is_empty() {
        let order_items: Vec<Node> = query.order_by.iter().map(order_by_expr_to_node).collect();
        clauses.push(Clause {
            keyword: "ORDER BY".into(),
            body: Some(Box::new(Node::List {
                items: order_items,
                separator: None,
            })),
        });
    }

    // LIMIT / FETCH FIRST / OFFSET
    // The ordering follows the Materialize AST Display:
    //   - non-WITH TIES: LIMIT n [OFFSET m]
    //   - WITH TIES:     [OFFSET m] FETCH FIRST n ROWS WITH TIES
    match (&query.limit, &query.offset) {
        (None, None) => {}
        (None, Some(offset)) => {
            clauses.push(Clause {
                keyword: "OFFSET".into(),
                body: Some(Box::new(expr_to_node(offset))),
            });
        }
        (Some(limit), offset) if limit.with_ties => {
            if let Some(off) = offset {
                clauses.push(Clause {
                    keyword: "OFFSET".into(),
                    body: Some(Box::new(expr_to_node(off))),
                });
            }
            clauses.push(Clause {
                keyword: "FETCH FIRST".into(),
                body: Some(Box::new(Node::Concat {
                    items: vec![
                        expr_to_node(&limit.quantity),
                        Node::Text { value: " ".into() },
                        Node::Keyword {
                            value: "ROWS WITH TIES".into(),
                        },
                    ],
                })),
            });
        }
        (Some(limit), offset) => {
            clauses.push(Clause {
                keyword: "LIMIT".into(),
                body: Some(Box::new(expr_to_node(&limit.quantity))),
            });
            if let Some(off) = offset {
                clauses.push(Clause {
                    keyword: "OFFSET".into(),
                    body: Some(Box::new(expr_to_node(off))),
                });
            }
        }
    }

    Node::Clauses { items: clauses }
}

fn select_item_to_node(item: &SelectItem<Raw>) -> Node {
    match item {
        SelectItem::Expr { expr, alias } => {
            let expr_node = expr_to_node(expr);
            match alias {
                None => expr_node,
                Some(alias) => Node::Concat {
                    items: vec![
                        expr_node,
                        Node::Text { value: " ".into() },
                        Node::Keyword { value: "AS".into() },
                        Node::Text { value: " ".into() },
                        ident_to_node(alias),
                    ],
                },
            }
        }
        SelectItem::Wildcard => Node::Text { value: "*".into() },
    }
}

fn table_with_joins_to_node(twj: &TableWithJoins<Raw>) -> Node {
    if twj.joins.is_empty() {
        table_factor_to_node(&twj.relation)
    } else {
        // Joins: fall back to text formatting for now.
        Node::Unformatted {
            value: format!("{twj}"),
        }
    }
}

fn table_factor_to_node(factor: &TableFactor<Raw>) -> Node {
    match factor {
        TableFactor::Table { name, alias } => {
            let name_node = Node::Identifier {
                value: name.to_string(),
                quote: None,
            };
            match alias {
                None => name_node,
                Some(a) => with_alias(name_node, a),
            }
        }
        TableFactor::NestedJoin { join, alias } => {
            let inner = Node::Unformatted {
                value: format!("{join}"),
            };
            let wrapped = Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(inner),
                close: ")".into(),
            };
            match alias {
                None => wrapped,
                Some(a) => with_alias(wrapped, a),
            }
        }
        _ => Node::Unformatted {
            value: format!("{factor}"),
        },
    }
}

fn with_alias(node: Node, alias: &TableAlias) -> Node {
    let TableAlias { name, columns, strict: _ } = alias;
    let mut items = vec![
        node,
        Node::Text { value: " ".into() },
        Node::Keyword { value: "AS".into() },
        Node::Text { value: " ".into() },
        ident_to_node(name),
    ];
    if !columns.is_empty() {
        let col_nodes: Vec<Node> = columns.iter().map(ident_to_node).collect();
        items.push(Node::Wrap {
            keyword: None,
            open: " (".into(),
            content: Box::new(Node::List {
                items: col_nodes,
                separator: None,
            }),
            close: ")".into(),
        });
    }
    Node::Concat { items }
}

fn expr_to_node(expr: &Expr<Raw>) -> Node {
    match expr {
        Expr::Identifier(names) => {
            if names.len() == 1 {
                ident_to_node(&names[0])
            } else {
                Node::Concat {
                    items: names
                        .iter()
                        .enumerate()
                        .flat_map(|(i, ident)| {
                            let node = ident_to_node(ident);
                            if i == 0 {
                                vec![node]
                            } else {
                                vec![Node::Text { value: ".".into() }, node]
                            }
                        })
                        .collect(),
                }
            }
        }
        Expr::Value(v) => Node::Literal {
            value: value_to_string(v),
        },
        Expr::And { left, right } => Node::Infix {
            op: "AND".into(),
            items: vec![expr_to_node(left), expr_to_node(right)],
        },
        Expr::Or { left, right } => Node::Infix {
            op: "OR".into(),
            items: vec![expr_to_node(left), expr_to_node(right)],
        },
        Expr::Not { expr } => Node::Concat {
            items: vec![
                Node::Keyword {
                    value: "NOT".into(),
                },
                Node::Text { value: " ".into() },
                expr_to_node(expr),
            ],
        },
        Expr::Op { op, expr1, expr2 } => match expr2 {
            Some(right) => Node::Infix {
                op: op.to_string(),
                items: vec![expr_to_node(expr1), expr_to_node(right)],
            },
            None => Node::Concat {
                items: vec![
                    Node::Text {
                        value: op.to_string(),
                    },
                    Node::Text { value: " ".into() },
                    expr_to_node(expr1),
                ],
            },
        },
        Expr::Nested(e) => Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(expr_to_node(e)),
            close: ")".into(),
        },
        // Use Unformatted for functions: Node::Wrap applies case transformation to
        // the keyword slot, which corrupts function names that are SQL reserved words
        // (e.g. `left` → `LEFT` then re-parses as a different quoted identifier).
        Expr::Function(f) => Node::Unformatted {
            value: format!("{f}"),
        },
        Expr::Subquery(q) => Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(query_to_node(q)),
            close: ")".into(),
        },
        Expr::Exists(q) => Node::Concat {
            items: vec![
                Node::Keyword {
                    value: "EXISTS".into(),
                },
                Node::Wrap {
                    keyword: None,
                    open: "(".into(),
                    content: Box::new(query_to_node(q)),
                    close: ")".into(),
                },
            ],
        },
        _ => Node::Unformatted {
            value: format!("{expr}"),
        },
    }
}



fn order_by_expr_to_node(o: &OrderByExpr<Raw>) -> Node {
    let mut items = vec![expr_to_node(&o.expr)];
    if let Some(asc) = o.asc {
        items.push(Node::Text { value: " ".into() });
        items.push(Node::Keyword {
            value: if asc { "ASC".into() } else { "DESC".into() },
        });
    }
    if let Some(nulls_last) = o.nulls_last {
        items.push(Node::Text { value: " ".into() });
        items.push(Node::Keyword {
            value: if nulls_last {
                "NULLS LAST".into()
            } else {
                "NULLS FIRST".into()
            },
        });
    }
    if items.len() == 1 {
        items.pop().unwrap()
    } else {
        Node::Concat { items }
    }
}


fn ident_to_node(ident: &Ident) -> Node {
    Node::Identifier {
        value: ident.as_str().to_string(),
        quote: if ident.can_be_printed_bare() {
            None
        } else {
            Some("\"".to_string())
        },
    }
}

fn value_to_string(v: &Value) -> String {
    // `Value` implements Display via impl_display!, which produces SQL-literal form
    // (e.g. `1`, `'foo'`, `TRUE`, `NULL`).
    format!("{v}")
}
