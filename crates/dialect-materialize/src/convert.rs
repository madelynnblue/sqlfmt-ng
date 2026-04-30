use mz_sql_parser::ast::{
    display::AstDisplay, AsOf, Cte, CteBlock, Distinct, Expr, Function, FunctionArgs, Ident, Join,
    JoinConstraint, JoinOperator, OrderByExpr, Query, Raw, Select, SelectItem, SelectStatement,
    SetExpr, SetOperator, Statement, TableAlias, TableFactor, TableWithJoins, Value, Values,
};
use sqlfmt_ir::{Clause, Node};

pub fn statement_to_node(stmt: &Statement<Raw>) -> Node {
    match stmt {
        Statement::Select(s) => select_stmt_to_node(s),
        _ => Node::Text {
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
    // WITH MUTUALLY RECURSIVE is complex; fall back to text.
    if matches!(query.ctes, CteBlock::MutuallyRecursive(_)) {
        return Node::Text {
            value: format!("{query}"),
        };
    }

    let body_node = set_expr_to_node(&query.body);
    let body_node = apply_order_by_limit(body_node, query);

    // Prepend simple CTEs if present.
    match &query.ctes {
        CteBlock::Simple(ctes) if !ctes.is_empty() => {
            let cte_nodes: Vec<Node> = ctes.iter().map(cte_to_node).collect();
            let cte_clause = Clause {
                keyword: "WITH".into(),
                body: Some(Box::new(Node::List {
                    items: cte_nodes,
                    separator: None,
                })),
            };
            match body_node {
                Node::Clauses { mut items } => {
                    items.insert(0, cte_clause);
                    Node::Clauses { items }
                }
                _ => Node::Text {
                    value: format!("{query}"),
                }
            }
        }
        _ => body_node,
    }
}

fn cte_to_node(cte: &Cte<Raw>) -> Node {
    let Cte { alias, id: _, query } = cte;
    // Render the alias (name + optional column list), then AS (...query...).
    let mut items = vec![
        Node::Text {
            value: format!("{alias}"),
        },
        Node::Text { value: " ".into() },
        Node::Keyword { value: "AS".into() },
        Node::Text { value: " ".into() },
    ];
    items.push(Node::Wrap {
        keyword: None,
        open: "(".into(),
        content: Box::new(query_to_node(query)),
        close: ")".into(),
    });
    Node::Concat { items }
}

fn set_expr_to_node(set_expr: &SetExpr<Raw>) -> Node {
    match set_expr {
        SetExpr::Select(select) => select_to_node(select),
        SetExpr::Query(q) => Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(query_to_node(q)),
            close: ")".into(),
        },
        SetExpr::SetOperation {
            op,
            all,
            left,
            right,
        } => {
            let op_str = match (op, all) {
                (SetOperator::Union, true) => "UNION ALL",
                (SetOperator::Union, false) => "UNION",
                (SetOperator::Except, true) => "EXCEPT ALL",
                (SetOperator::Except, false) => "EXCEPT",
                (SetOperator::Intersect, true) => "INTERSECT ALL",
                (SetOperator::Intersect, false) => "INTERSECT",
            };
            Node::Infix {
                op: op_str.into(),
                items: vec![
                    set_expr_to_node(left),
                    set_expr_to_node(right),
                ],
            }
        }
        SetExpr::Values(v) => values_to_node(v),
        // SHOW, TABLE: fall back to Display text.
        _ => Node::Text {
            value: format!("{set_expr}"),
        },
    }
}

fn values_to_node(v: &Values<Raw>) -> Node {
    let row_nodes: Vec<Node> = v
        .0
        .iter()
        .map(|row| {
            let exprs: Vec<Node> = row.iter().map(expr_to_node).collect();
            Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(Node::List {
                    items: exprs,
                    separator: None,
                }),
                close: ")".into(),
            }
        })
        .collect();
    Node::Concat {
        items: vec![
            Node::Keyword {
                value: "VALUES".into(),
            },
            Node::Text { value: " ".into() },
            Node::List {
                items: row_nodes,
                separator: None,
            },
        ],
    }
}

/// Appends ORDER BY, LIMIT, and OFFSET clauses from `query` to `body_node`.
/// If `body_node` is `Node::Clauses`, the clauses are appended directly.
/// Otherwise, falls back to `Node::Text` for the full query display.
fn apply_order_by_limit(body_node: Node, query: &Query<Raw>) -> Node {
    if query.order_by.is_empty() && query.limit.is_none() && query.offset.is_none() {
        return body_node;
    }

    let mut clauses: Vec<Clause> = Vec::new();

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

    match body_node {
        Node::Clauses { mut items } => {
            items.extend(clauses);
            Node::Clauses { items }
        }
        _ => {
            // For non-Clauses bodies (SetOperation, etc.), fall back to text.
            Node::Text {
                value: format!("{query}"),
            }
        }
    }
}

fn select_to_node(select: &Select<Raw>) -> Node {
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

    // OPTIONS (Materialize query hint extension, follows QUALIFY in mz SELECT display)
    if !select.options.is_empty() {
        let opts_str = select
            .options
            .iter()
            .map(|o| o.to_ast_string_simple())
            .collect::<Vec<_>>()
            .join(", ");
        clauses.push(Clause {
            keyword: "OPTIONS".into(),
            body: Some(Box::new(Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(Node::Text { value: opts_str }),
                close: ")".into(),
            })),
        });
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
    let mut items = vec![table_factor_to_node(&twj.relation)];
    for join in &twj.joins {
        items.push(join_to_node(join));
    }
    if items.len() == 1 {
        items.pop().unwrap()
    } else {
        Node::Concat { items }
    }
}

fn join_to_node(join: &Join<Raw>) -> Node {
    let Join {
        relation,
        join_operator,
    } = join;

    let (constraint, keyword) = match join_operator {
        JoinOperator::Inner(c) => (c, "JOIN"),
        JoinOperator::LeftOuter(c) => (c, "LEFT JOIN"),
        JoinOperator::RightOuter(c) => (c, "RIGHT JOIN"),
        JoinOperator::FullOuter(c) => (c, "FULL JOIN"),
        JoinOperator::CrossJoin => {
            return Node::Concat {
                items: vec![
                    Node::Text { value: " ".into() },
                    Node::Keyword {
                        value: "CROSS JOIN".into(),
                    },
                    Node::Text { value: " ".into() },
                    table_factor_to_node(relation),
                ],
            };
        }
    };

    // Check for NATURAL prefix.
    let keyword = if matches!(constraint, JoinConstraint::Natural) {
        format!("NATURAL {keyword}")
    } else {
        keyword.to_string()
    };

    let mut items = vec![
        Node::Text { value: " ".into() },
        Node::Keyword {
            value: keyword,
        },
        Node::Text { value: " ".into() },
        table_factor_to_node(relation),
    ];

    // Append constraint suffix (ON, USING). Non-natural constraints follow after the join.
    match constraint {
        JoinConstraint::On(expr) => {
            items.push(Node::Text { value: " ON ".into() });
            items.push(expr_to_node(expr));
        }
        JoinConstraint::Using {
            columns,
            alias: using_alias,
        } => {
            let col_nodes: Vec<Node> = columns.iter().map(ident_to_node).collect();
            items.push(Node::Text { value: " USING ".into() });
            items.push(Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(Node::List {
                    items: col_nodes,
                    separator: None,
                }),
                close: ")".into(),
            });
            if let Some(a) = using_alias {
                items.push(Node::Text { value: " AS ".into() });
                items.push(ident_to_node(a));
            }
        }
        JoinConstraint::Natural => {
            // NATURAL prefix already prepended to keyword; no suffix needed.
        }
    }

    Node::Concat { items }
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
            let inner = table_with_joins_to_node(join);
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
        TableFactor::Derived {
            lateral,
            subquery,
            alias,
        } => {
            let prefix = if *lateral { "LATERAL (" } else { "(" };
            let mut node = Node::Wrap {
                keyword: None,
                open: prefix.into(),
                content: Box::new(query_to_node(subquery)),
                close: ")".into(),
            };
            if let Some(a) = alias {
                node = with_alias(node, a);
            }
            node
        }
        TableFactor::Function {
            function,
            alias,
            with_ordinality,
        } => {
            let mut items = vec![function_to_node(function)];
            if *with_ordinality {
                items.push(Node::Text {
                    value: " WITH ORDINALITY".into(),
                });
            }
            if let Some(a) = alias {
                items.push(Node::Text { value: " AS ".into() });
                items.push(ident_to_node(&a.name));
                items.push(column_list_node(&a.columns));
            }
            Node::Concat { items }
        }
        TableFactor::RowsFrom {
            functions,
            alias,
            with_ordinality,
        } => {
            let func_nodes: Vec<Node> = functions.iter().map(function_to_node).collect();
            let mut items = vec![Node::Concat {
                items: vec![
                    Node::Keyword {
                        value: "ROWS FROM".into(),
                    },
                    Node::Wrap {
                        keyword: None,
                        open: " (".into(),
                        content: Box::new(Node::List {
                            items: func_nodes,
                            separator: None,
                        }),
                        close: ")".into(),
                    },
                ],
            }];
            if *with_ordinality {
                items.push(Node::Text {
                    value: " WITH ORDINALITY".into(),
                });
            }
            if let Some(a) = alias {
                items.push(Node::Text { value: " ".into() });
                items.push(Node::Keyword { value: "AS".into() });
                items.push(Node::Text { value: " ".into() });
                items.push(ident_to_node(&a.name));
                items.push(column_list_node(&a.columns));
            }
            Node::Concat { items }
        }
    }
}

fn column_list_node(columns: &[Ident]) -> Node {
    if columns.is_empty() {
        return Node::Text { value: "".into() };
    }
    Node::Wrap {
        keyword: None,
        open: " (".into(),
        content: Box::new(Node::List {
            items: columns.iter().map(ident_to_node).collect(),
            separator: None,
        }),
        close: ")".into(),
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
    items.push(column_list_node(columns));
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
        Expr::Function(f) => function_to_node(f),
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
        Expr::Cast { expr, data_type } => Node::Concat {
            items: vec![
                expr_to_node(expr),
                Node::Text {
                    value: format!("::{data_type}"),
                },
            ],
        },
        Expr::Case {
            operand,
            conditions,
            results,
            else_result,
        } => {
            let mut items = vec![Node::Keyword { value: "CASE".into() }];
            if let Some(op) = operand {
                items.push(Node::Text { value: " ".into() });
                items.push(expr_to_node(op));
            }
            for (c, r) in conditions.iter().zip(results.iter()) {
                items.push(Node::Text { value: " WHEN ".into() });
                items.push(expr_to_node(c));
                items.push(Node::Text { value: " THEN ".into() });
                items.push(expr_to_node(r));
            }
            if let Some(else_r) = else_result {
                items.push(Node::Text { value: " ELSE ".into() });
                items.push(expr_to_node(else_r));
            }
            items.push(Node::Text { value: " ".into() });
            items.push(Node::Keyword { value: "END".into() });
            Node::Concat { items }
        }
        Expr::Between {
            expr,
            negated,
            low,
            high,
        } => {
            let mut items = vec![expr_to_node(expr), Node::Text { value: " ".into() }];
            if *negated {
                items.push(Node::Keyword { value: "NOT".into() });
                items.push(Node::Text { value: " ".into() });
            }
            items.push(Node::Keyword {
                value: "BETWEEN".into(),
            });
            items.push(Node::Text { value: " ".into() });
            items.push(expr_to_node(low));
            items.push(Node::Text { value: " ".into() });
            items.push(Node::Keyword { value: "AND".into() });
            items.push(Node::Text { value: " ".into() });
            items.push(expr_to_node(high));
            Node::Concat { items }
        }
        Expr::IsExpr {
            expr,
            negated,
            construct,
        } => {
            let mut items = vec![
                expr_to_node(expr),
                Node::Text { value: " ".into() },
                Node::Keyword { value: "IS".into() },
            ];
            if *negated {
                items.push(Node::Text { value: " ".into() });
                items.push(Node::Keyword { value: "NOT".into() });
            }
            items.push(Node::Text { value: " ".into() });
            items.push(Node::Text {
                value: format!("{construct}"),
            });
            Node::Concat { items }
        }
        Expr::InList {
            expr,
            list,
            negated,
        } => {
            let list_items: Vec<Node> = list.iter().map(expr_to_node).collect();
            let in_keyword = if *negated { "NOT IN" } else { "IN" };
            Node::Concat {
                items: vec![
                    expr_to_node(expr),
                    Node::Text { value: " ".into() },
                    Node::Keyword {
                        value: in_keyword.into(),
                    },
                    Node::Wrap {
                        keyword: None,
                        open: " (".into(),
                        content: Box::new(Node::List {
                            items: list_items,
                            separator: None,
                        }),
                        close: ")".into(),
                    },
                ],
            }
        }
        Expr::InSubquery {
            expr,
            subquery,
            negated,
        } => {
            let in_keyword = if *negated { "NOT IN" } else { "IN" };
            Node::Concat {
                items: vec![
                    expr_to_node(expr),
                    Node::Text { value: " ".into() },
                    Node::Keyword {
                        value: in_keyword.into(),
                    },
                    Node::Wrap {
                        keyword: None,
                        open: " (".into(),
                        content: Box::new(query_to_node(subquery)),
                        close: ")".into(),
                    },
                ],
            }
        }
        Expr::Like {
            expr,
            pattern,
            escape,
            case_insensitive,
            negated,
        } => {
            let mut items = vec![
                expr_to_node(expr),
                Node::Text { value: " ".into() },
            ];
            if *negated {
                items.push(Node::Keyword { value: "NOT".into() });
                items.push(Node::Text { value: " ".into() });
            }
            items.push(Node::Keyword {
                value: if *case_insensitive {
                    "ILIKE".into()
                } else {
                    "LIKE".into()
                },
            });
            items.push(Node::Text { value: " ".into() });
            items.push(expr_to_node(pattern));
            if let Some(esc) = escape {
                items.push(Node::Text { value: " ".into() });
                items.push(Node::Keyword { value: "ESCAPE".into() });
                items.push(Node::Text { value: " ".into() });
                items.push(expr_to_node(esc));
            }
            Node::Concat { items }
        }
        Expr::Collate { expr, collation } => Node::Concat {
            items: vec![
                expr_to_node(expr),
                Node::Text { value: " ".into() },
                Node::Keyword {
                    value: "COLLATE".into(),
                },
                Node::Text { value: " ".into() },
                Node::Text {
                    value: format!("{collation}"),
                },
            ],
        },
        Expr::HomogenizingFunction { function, exprs } => {
            let items: Vec<Node> = exprs.iter().map(expr_to_node).collect();
            Node::Wrap {
                keyword: Some(format!("{function}")),
                open: "(".into(),
                content: Box::new(Node::List {
                    items,
                    separator: None,
                }),
                close: ")".into(),
            }
        }
        Expr::NullIf { l_expr, r_expr } => Node::Wrap {
            keyword: Some("NULLIF".into()),
            open: "(".into(),
            content: Box::new(Node::List {
                items: vec![expr_to_node(l_expr), expr_to_node(r_expr)],
                separator: None,
            }),
            close: ")".into(),
        },
        Expr::Row { exprs } => {
            let items: Vec<Node> = exprs.iter().map(expr_to_node).collect();
            Node::Wrap {
                keyword: Some("ROW".into()),
                open: "(".into(),
                content: Box::new(Node::List {
                    items,
                    separator: None,
                }),
                close: ")".into(),
            }
        }
        Expr::Array(exprs) => {
            let items: Vec<Node> = exprs.iter().map(expr_to_node).collect();
            Node::Wrap {
                keyword: Some("ARRAY".into()),
                open: "[".into(),
                content: Box::new(Node::List {
                    items,
                    separator: None,
                }),
                close: "]".into(),
            }
        }
        Expr::ArraySubquery(s) => Node::Wrap {
            keyword: Some("ARRAY".into()),
            open: "(".into(),
            content: Box::new(query_to_node(s)),
            close: ")".into(),
        },
        Expr::List(exprs) => {
            let items: Vec<Node> = exprs.iter().map(expr_to_node).collect();
            Node::Wrap {
                keyword: Some("LIST".into()),
                open: "[".into(),
                content: Box::new(Node::List {
                    items,
                    separator: None,
                }),
                close: "]".into(),
            }
        }
        Expr::ListSubquery(s) => Node::Wrap {
            keyword: Some("LIST".into()),
            open: "(".into(),
            content: Box::new(query_to_node(s)),
            close: ")".into(),
        },
        _ => Node::Text {
            value: format!("{expr}"),
        },
    }
}

fn function_to_node(f: &Function<Raw>) -> Node {
    // Special functions (extract, position) use keyword argument syntax;
    // their Display output differs from standard function call formatting.
    if matches!(
        f.name.to_ast_string_stable().as_str(),
        "\"extract\"" | "\"position\""
    ) && f.args.len() == Some(2)
    {
        return Node::Text { value: format!("{f}") };
    }

    let args_list = match &f.args {
        FunctionArgs::Star => return Node::Text { value: format!("{f}") },
        FunctionArgs::Args { args, order_by } => {
            if args.is_empty()
                || f.filter.is_some()
                || f.over.is_some()
                || !order_by.is_empty()
                || f.distinct
            {
                return Node::Text { value: format!("{f}") };
            }
            args
        }
    };

    let arg_nodes: Vec<Node> = args_list.iter().map(expr_to_node).collect();
    // Use the Display form of the name. For simple names this matches what
    // the parser's AstDisplay produces (including quoting reserved words).
    // The renderer's Node::Text preserves this without case transformation,
    // avoiding the issue where `Wrap::keyword` would up-case `left` to `LEFT`.
    Node::Concat {
        items: vec![
            Node::Text {
                value: format!("{}", f.name),
            },
            Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(Node::List {
                    items: arg_nodes,
                    separator: None,
                }),
                close: ")".into(),
            },
        ],
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
