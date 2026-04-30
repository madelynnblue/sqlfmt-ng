use sqlfmt_core::SqlfmtError;
use sqlfmt_ir::{Clause, Node};
use sqlparser::ast::{
    Expr, GroupByExpr, Ident, LimitClause, OrderByKind, Query, Select, SelectItem, SetExpr,
    SetOperator, Statement, TableAlias, TableFactor, TableWithJoins,
};

pub fn convert_statements(stmts: &[Statement]) -> Result<Node, SqlfmtError> {
    if stmts.is_empty() {
        return Err(SqlfmtError::Parse("empty statement list".into()));
    }
    let nodes: Vec<Node> = stmts.iter().map(statement_to_node).collect();
    if nodes.len() == 1 {
        Ok(nodes.into_iter().next().unwrap())
    } else {
        Ok(Node::Statements { items: nodes })
    }
}

fn statement_to_node(stmt: &Statement) -> Node {
    match stmt {
        Statement::Query(q) => query_to_node(q),
        _ => Node::Unformatted {
            value: format!("{stmt}"),
        },
    }
}

fn query_to_node(query: &Query) -> Node {
    let body = set_expr_to_node(&query.body);

    let mut clauses = match body {
        Node::Clauses { items } => items,
        _ => {
            let mut items = Vec::new();
            if let Some(order_by) = &query.order_by {
                if let Some(order_clause) = order_by_clause(order_by) {
                    items.push(order_clause);
                }
            }
            if items.is_empty() {
                return body;
            }
            items.insert(
                0,
                Clause {
                    keyword: String::new(),
                    body: Some(Box::new(body)),
                },
            );
            return Node::Clauses { items };
        }
    };

    // WITH (CTEs)
    if let Some(w) = &query.with {
        let cte_items: Vec<Node> = w.cte_tables.iter().map(cte_to_node).collect();
        clauses.insert(
            0,
            Clause {
                keyword: "WITH".into(),
                body: Some(Box::new(Node::List {
                    items: cte_items,
                    separator: None,
                })),
            },
        );
    }

    // ORDER BY
    if let Some(order_by) = &query.order_by {
        if let Some(order_clause) = order_by_clause(order_by) {
            clauses.push(order_clause);
        }
    }

    // LIMIT / OFFSET
    match &query.limit_clause {
        Some(LimitClause::LimitOffset { limit, offset, .. }) => {
            if let Some(limit_expr) = limit {
                clauses.push(Clause {
                    keyword: "LIMIT".into(),
                    body: Some(Box::new(expr_to_node(limit_expr))),
                });
            }
            if let Some(offset) = offset {
                clauses.push(Clause {
                    keyword: "OFFSET".into(),
                    body: Some(Box::new(expr_to_node(&offset.value))),
                });
            }
        }
        Some(LimitClause::OffsetCommaLimit { offset, limit }) => {
            clauses.push(Clause {
                keyword: "LIMIT".into(),
                body: Some(Box::new(Node::Concat {
                    items: vec![
                        expr_to_node(offset),
                        Node::Text { value: ", ".into() },
                        expr_to_node(limit),
                    ],
                })),
            });
        }
        None => {}
    }

    // FETCH
    if let Some(fetch) = &query.fetch {
        clauses.push(Clause {
            keyword: "FETCH".into(),
            body: Some(Box::new(Node::Text {
                value: format!("{fetch}"),
            })),
        });
    }

    Node::Clauses { items: clauses }
}

fn order_by_clause(order_by: &sqlparser::ast::OrderBy) -> Option<Clause> {
    match &order_by.kind {
        OrderByKind::Expressions(exprs) if !exprs.is_empty() => {
            let order_items: Vec<Node> = exprs.iter().map(order_by_expr_to_node).collect();
            Some(Clause {
                keyword: "ORDER BY".into(),
                body: Some(Box::new(Node::List {
                    items: order_items,
                    separator: None,
                })),
            })
        }
        _ => None,
    }
}

fn set_expr_to_node(expr: &SetExpr) -> Node {
    match expr {
        SetExpr::Select(s) => select_to_node(s),
        SetExpr::Query(q) => Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(query_to_node(q)),
            close: ")".into(),
        },
        SetExpr::SetOperation {
            op,
            set_quantifier,
            left,
            right,
        } => {
            let op_str = match op {
                SetOperator::Union => match set_quantifier {
                    sqlparser::ast::SetQuantifier::All => "UNION ALL",
                    _ => "UNION",
                },
                SetOperator::Except => match set_quantifier {
                    sqlparser::ast::SetQuantifier::All => "EXCEPT ALL",
                    _ => "EXCEPT",
                },
                SetOperator::Intersect => match set_quantifier {
                    sqlparser::ast::SetQuantifier::All => "INTERSECT ALL",
                    _ => "INTERSECT",
                },
                SetOperator::Minus => "MINUS",
            };
            Node::Infix {
                op: op_str.into(),
                items: vec![set_expr_to_node(left), set_expr_to_node(right)],
            }
        }
        _ => Node::Unformatted {
            value: format!("{expr}"),
        },
    }
}

fn select_to_node(select: &Select) -> Node {
    let mut clauses: Vec<Clause> = Vec::new();

    // SELECT [DISTINCT] projection
    let select_kw = if select.distinct.is_some() {
        "SELECT DISTINCT"
    } else {
        "SELECT"
    };
    let cols: Vec<Node> = select.projection.iter().map(select_item_to_node).collect();
    clauses.push(Clause {
        keyword: select_kw.into(),
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
    match &select.group_by {
        GroupByExpr::Expressions(exprs, _) if !exprs.is_empty() => {
            let group_items: Vec<Node> = exprs.iter().map(expr_to_node).collect();
            clauses.push(Clause {
                keyword: "GROUP BY".into(),
                body: Some(Box::new(Node::List {
                    items: group_items,
                    separator: None,
                })),
            });
        }
        _ => {}
    }

    // HAVING
    if let Some(having) = &select.having {
        clauses.push(Clause {
            keyword: "HAVING".into(),
            body: Some(Box::new(expr_to_node(having))),
        });
    }

    Node::Clauses { items: clauses }
}

fn select_item_to_node(item: &SelectItem) -> Node {
    match item {
        SelectItem::UnnamedExpr(expr) => expr_to_node(expr),
        SelectItem::ExprWithAlias { expr, alias } => {
            let expr_node = expr_to_node(expr);
            Node::Concat {
                items: vec![
                    expr_node,
                    Node::Text { value: " ".into() },
                    Node::Keyword { value: "AS".into() },
                    Node::Text { value: " ".into() },
                    ident_to_node(alias),
                ],
            }
        }
        SelectItem::Wildcard(_) => Node::Text { value: "*".into() },
        SelectItem::QualifiedWildcard(qw, _) => Node::Unformatted {
            value: format!("{qw}"),
        },
    }
}

fn table_with_joins_to_node(twj: &TableWithJoins) -> Node {
    if twj.joins.is_empty() {
        table_factor_to_node(&twj.relation)
    } else {
        Node::Unformatted {
            value: format!("{twj}"),
        }
    }
}

fn table_factor_to_node(tf: &TableFactor) -> Node {
    match tf {
        TableFactor::Table { name, alias, .. } => {
            let name_node = Node::Identifier {
                value: name.to_string(),
                quote: None,
            };
            match alias {
                Some(a) => alias_node(name_node, a),
                None => name_node,
            }
        }
        TableFactor::Derived {
            subquery, alias, ..
        } => {
            let content = query_to_node(subquery);
            let wrap = Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(content),
                close: ")".into(),
            };
            match alias {
                Some(a) => alias_node(wrap, a),
                None => wrap,
            }
        }
        _ => Node::Unformatted {
            value: format!("{tf}"),
        },
    }
}

fn alias_node(node: Node, alias: &TableAlias) -> Node {
    Node::Concat {
        items: vec![
            node,
            Node::Text { value: " ".into() },
            Node::Keyword { value: "AS".into() },
            Node::Text { value: " ".into() },
            ident_to_node(&alias.name),
        ],
    }
}

fn order_by_expr_to_node(obe: &sqlparser::ast::OrderByExpr) -> Node {
    let expr_node = expr_to_node(&obe.expr);

    // Handle WITH FILL (ClickHouse extension) by falling back to Unformatted
    if obe.with_fill.is_some() {
        return Node::Unformatted {
            value: format!("{obe}"),
        };
    }

    // Handle NULLS FIRST/LAST by falling back to formatted text
    if obe.options.nulls_first.is_some() {
        return Node::Unformatted {
            value: format!("{obe}"),
        };
    }

    match obe.options.asc {
        Some(true) => Node::Concat {
            items: vec![
                expr_node,
                Node::Text { value: " ".into() },
                Node::Keyword { value: "ASC".into() },
            ],
        },
        Some(false) => Node::Concat {
            items: vec![
                expr_node,
                Node::Text { value: " ".into() },
                Node::Keyword { value: "DESC".into() },
            ],
        },
        None => expr_node,
    }
}

fn cte_to_node(cte: &sqlparser::ast::Cte) -> Node {
    let alias_str = format!("{}", cte.alias);
    let query_node = query_to_node(&cte.query);
    Node::Concat {
        items: vec![
            Node::Text {
                value: alias_str,
            },
            Node::Text { value: " ".into() },
            Node::Keyword { value: "AS".into() },
            Node::Text { value: " ".into() },
            Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(query_node),
                close: ")".into(),
            },
        ],
    }
}

fn expr_to_node(expr: &Expr) -> Node {
    match expr {
        Expr::Identifier(ident) => ident_to_node(ident),
        Expr::CompoundIdentifier(idents) => {
            let mut parts: Vec<Node> = Vec::new();
            for (i, ident) in idents.iter().enumerate() {
                if i > 0 {
                    parts.push(Node::Text { value: ".".into() });
                }
                parts.push(ident_to_node(ident));
            }
            Node::Concat { items: parts }
        }
        Expr::Value(v) => value_to_node(&v.value),
        Expr::BinaryOp { left, op, right } => {
            let op_str = op.to_string();
            Node::Infix {
                op: op_str.to_uppercase(),
                items: vec![expr_to_node(left), expr_to_node(right)],
            }
        }
        Expr::UnaryOp { op, expr } => {
            let op_str = op.to_string();
            Node::Concat {
                items: vec![
                    Node::Keyword {
                        value: op_str.to_uppercase(),
                    },
                    Node::Text { value: " ".into() },
                    expr_to_node(expr),
                ],
            }
        }
        Expr::Nested(e) => Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(expr_to_node(e)),
            close: ")".into(),
        },
        Expr::Subquery(q) => Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(query_to_node(q)),
            close: ")".into(),
        },
        Expr::Function(fn_call) => {
            let fn_name = fn_call.name.to_string();
            let args_str = format!("{}", fn_call.args);
            // FunctionArguments Display includes surrounding parentheses,
            // so just concatenate name + args.
            Node::Concat {
                items: vec![
                    Node::Keyword {
                        value: fn_name.to_uppercase(),
                    },
                    Node::Text { value: args_str },
                ],
            }
        }
        Expr::IsNull(e) => Node::Concat {
            items: vec![
                expr_to_node(e),
                Node::Text { value: " ".into() },
                Node::Keyword {
                    value: "IS NULL".into(),
                },
            ],
        },
        Expr::IsNotNull(e) => Node::Concat {
            items: vec![
                expr_to_node(e),
                Node::Text { value: " ".into() },
                Node::Keyword {
                    value: "IS NOT NULL".into(),
                },
            ],
        },
        Expr::IsTrue(e) => Node::Concat {
            items: vec![
                expr_to_node(e),
                Node::Text { value: " ".into() },
                Node::Keyword {
                    value: "IS TRUE".into(),
                },
            ],
        },
        Expr::IsFalse(e) => Node::Concat {
            items: vec![
                expr_to_node(e),
                Node::Text { value: " ".into() },
                Node::Keyword {
                    value: "IS FALSE".into(),
                },
            ],
        },
        Expr::InList {
            expr,
            list,
            negated,
        } => {
            let list_items: Vec<Node> = list.iter().map(expr_to_node).collect();
            let in_node = Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(Node::List {
                    items: list_items,
                    separator: None,
                }),
                close: ")".into(),
            };
            let op = if *negated { "NOT IN" } else { "IN" };
            Node::Infix {
                op: op.into(),
                items: vec![expr_to_node(expr), in_node],
            }
        }
        Expr::InSubquery {
            expr,
            subquery,
            negated,
        } => {
            let sub_node = Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(query_to_node(subquery)),
                close: ")".into(),
            };
            let op = if *negated { "NOT IN" } else { "IN" };
            Node::Infix {
                op: op.into(),
                items: vec![expr_to_node(expr), sub_node],
            }
        }
        Expr::Between {
            expr,
            negated,
            low,
            high,
        } => {
            let op = if *negated {
                "NOT BETWEEN"
            } else {
                "BETWEEN"
            };
            Node::Infix {
                op: op.into(),
                items: vec![
                    expr_to_node(expr),
                    Node::Concat {
                        items: vec![
                            expr_to_node(low),
                            Node::Text { value: " ".into() },
                            Node::Keyword { value: "AND".into() },
                            Node::Text { value: " ".into() },
                            expr_to_node(high),
                        ],
                    },
                ],
            }
        }
        Expr::Like {
            expr,
            negated,
            pattern,
            ..
        } => {
            let op = if *negated { "NOT LIKE" } else { "LIKE" };
            Node::Infix {
                op: op.into(),
                items: vec![expr_to_node(expr), expr_to_node(pattern)],
            }
        }
        Expr::Cast {
            expr,
            data_type,
            kind,
            ..
        } => {
            let kw = match kind {
                sqlparser::ast::CastKind::Cast => "CAST",
                sqlparser::ast::CastKind::TryCast => "TRY_CAST",
                sqlparser::ast::CastKind::SafeCast => "SAFE_CAST",
                sqlparser::ast::CastKind::DoubleColon => "CAST",
            };
            let items = vec![
                expr_to_node(expr),
                Node::Text { value: " ".into() },
                Node::Keyword { value: "AS".into() },
                Node::Text { value: " ".into() },
                Node::Text {
                    value: format!("{data_type}"),
                },
            ];
            Node::Wrap {
                keyword: Some(kw.into()),
                open: "(".into(),
                content: Box::new(Node::Concat { items }),
                close: ")".into(),
            }
        }
        _ => Node::Unformatted {
            value: format!("{expr}"),
        },
    }
}

fn value_to_node(value: &sqlparser::ast::Value) -> Node {
    match value {
        sqlparser::ast::Value::Number(n, _) => Node::Literal {
            value: n.to_string(),
        },
        sqlparser::ast::Value::SingleQuotedString(s)
        | sqlparser::ast::Value::TripleSingleQuotedString(s) => Node::Literal {
            value: format!("'{s}'"),
        },
        sqlparser::ast::Value::DoubleQuotedString(s)
        | sqlparser::ast::Value::TripleDoubleQuotedString(s) => Node::Literal {
            value: format!("\"{s}\""),
        },
        sqlparser::ast::Value::Boolean(b) => Node::Keyword {
            value: if *b {
                "TRUE".into()
            } else {
                "FALSE".into()
            },
        },
        sqlparser::ast::Value::Null => Node::Keyword {
            value: "NULL".into(),
        },
        _ => Node::Unformatted {
            value: format!("{value}"),
        },
    }
}

fn ident_to_node(ident: &Ident) -> Node {
    match ident.quote_style {
        Some('\"') => Node::Identifier {
            value: ident.value.clone(),
            quote: Some("\"".into()),
        },
        Some('`') => Node::Identifier {
            value: ident.value.clone(),
            quote: Some("`".into()),
        },
        Some('[') => Node::Identifier {
            value: ident.value.clone(),
            quote: Some("[".into()),
        },
        _ => Node::Identifier {
            value: ident.value.clone(),
            quote: None,
        },
    }
}
