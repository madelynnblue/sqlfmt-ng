use mz_sql_parser::ast::{
    display::AstDisplay, Assignment, AsOf, CreateMaterializedViewStatement,
    CreateIndexStatement, CreateTableStatement, CreateViewStatement, Cte, CteBlock,
    DeleteStatement, Distinct, DropObjectsStatement, ResetVariableStatement,
    Expr, Function,
    FunctionArgs, Ident, IfExistsBehavior, InsertSource, InsertStatement, Join,
    JoinConstraint, JoinOperator, MapEntry, ObjectType, OrderByExpr, Query, Raw, Select, SelectItem,
    SelectStatement, SetExpr, SetOperator, SetVariableStatement, Statement,
    SubscriptPosition, TableAlias,
    TableFactor, TableWithJoins, UpdateStatement, Value, Values,
    WindowSpec,
};
use sqlfmt_ir::{Clause, Node};

pub fn statement_to_node(stmt: &Statement<Raw>) -> Node {
    match stmt {
        Statement::Select(s) => select_stmt_to_node(s),
        Statement::Insert(ins) => insert_stmt_to_node(ins),
        Statement::Update(upd) => update_stmt_to_node(upd),
        Statement::Delete(del) => delete_stmt_to_node(del),
        Statement::CreateTable(ct) => create_table_to_node(ct),
        Statement::CreateMaterializedView(mv) => create_materialized_view_to_node(mv),
        Statement::CreateView(cv) => create_view_to_node(cv),
        Statement::CreateIndex(ci) => create_index_to_node(ci),
        Statement::DropObjects(drop) => drop_objects_to_node(drop),
        Statement::SetVariable(sv) => set_variable_to_node(sv),
        Statement::ResetVariable(rv) => reset_variable_to_node(rv),
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
        other => {
            // Wrap non-Clauses body (SetOperation, Values, etc.) as the first
            // clause item so ORDER BY/LIMIT/OFFSET receive structured rendering.
            let mut all = vec![Clause {
                keyword: "".into(),
                body: Some(Box::new(other)),
            }];
            all.extend(clauses);
            Node::Clauses { items: all }
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
        Expr::Map(entries) => {
            let items: Vec<Node> = entries
                .iter()
                .map(entry_to_node)
                .collect();
            Node::Wrap {
                keyword: Some("MAP".into()),
                open: "[".into(),
                content: Box::new(Node::List {
                    items,
                    separator: None,
                }),
                close: "]".into(),
            }
        }
        Expr::MapSubquery(s) => Node::Wrap {
            keyword: Some("MAP".into()),
            open: "(".into(),
            content: Box::new(query_to_node(s)),
            close: ")".into(),
        },
        Expr::QualifiedWildcard(idents) => {
            let items: Vec<Node> = idents
                .iter()
                .enumerate()
                .flat_map(|(i, ident)| {
                    if i == 0 {
                        vec![ident_to_node(ident)]
                    } else {
                        vec![Node::Text { value: ".".into() }, ident_to_node(ident)]
                    }
                })
                .chain(std::iter::once(Node::Text { value: ".*".into() }))
                .collect();
            Node::Concat { items }
        }
        Expr::FieldAccess { expr, field } => Node::Concat {
            items: vec![
                expr_to_node(expr),
                Node::Text { value: ".".into() },
                ident_to_node(field),
            ],
        },
        Expr::WildcardAccess(expr) => Node::Concat {
            items: vec![
                expr_to_node(expr),
                Node::Text { value: ".*".into() },
            ],
        },
        Expr::Parameter(n) => Node::Text {
            value: format!("${n}"),
        },
        Expr::AnySubquery { left, op, right } => Node::Concat {
            items: vec![
                expr_to_node(left),
                Node::Text { value: " ".into() },
                Node::Text {
                    value: op.to_string(),
                },
                Node::Text { value: " ".into() },
                Node::Wrap {
                    keyword: Some("ANY".into()),
                    open: " (".into(),
                    content: Box::new(query_to_node(right)),
                    close: ")".into(),
                },
            ],
        },
        Expr::AnyExpr { left, op, right } => Node::Concat {
            items: vec![
                expr_to_node(left),
                Node::Text { value: " ".into() },
                Node::Text {
                    value: op.to_string(),
                },
                Node::Text { value: " ".into() },
                Node::Wrap {
                    keyword: Some("ANY".into()),
                    open: " (".into(),
                    content: Box::new(expr_to_node(right)),
                    close: ")".into(),
                },
            ],
        },
        Expr::AllSubquery { left, op, right } => Node::Concat {
            items: vec![
                expr_to_node(left),
                Node::Text { value: " ".into() },
                Node::Text {
                    value: op.to_string(),
                },
                Node::Text { value: " ".into() },
                Node::Wrap {
                    keyword: Some("ALL".into()),
                    open: " (".into(),
                    content: Box::new(query_to_node(right)),
                    close: ")".into(),
                },
            ],
        },
        Expr::AllExpr { left, op, right } => Node::Concat {
            items: vec![
                expr_to_node(left),
                Node::Text { value: " ".into() },
                Node::Text {
                    value: op.to_string(),
                },
                Node::Text { value: " ".into() },
                Node::Wrap {
                    keyword: Some("ALL".into()),
                    open: " (".into(),
                    content: Box::new(expr_to_node(right)),
                    close: ")".into(),
                },
            ],
        },
        Expr::Subscript { expr, positions } => {
            let mut node = expr_to_node(expr);
            for pos in positions {
                let inner = subscript_position_to_node(pos);
                node = Node::Concat {
                    items: vec![
                        node,
                        Node::Text { value: "[".into() },
                        inner,
                        Node::Text { value: "]".into() },
                    ],
                };
            }
            node
        }
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

    // ORDER BY within function args is complex and requires fallback to
    // the parser's own Display. We also can't handle the combination of
    // both ORDER BY in args and OVER in the same call.
    let has_complex = match &f.args {
        FunctionArgs::Args { order_by, .. } => !order_by.is_empty(),
        FunctionArgs::Star => false,
    };
    if has_complex {
        return Node::Text { value: format!("{f}") };
    }

    let mut items = match &f.args {
        FunctionArgs::Star => {
            let items = vec![
                Node::Text {
                    value: format!("{}", f.name),
                },
                Node::Wrap {
                    keyword: None,
                    open: "(".into(),
                    content: Box::new(Node::Text { value: "*".into() }),
                    close: ")".into(),
                },
            ];
            items
        }
        FunctionArgs::Args { args, order_by: _ } => {
            if args.is_empty() {
                return Node::Text { value: format!("{f}") };
            }
            let arg_nodes: Vec<Node> = args.iter().map(expr_to_node).collect();
            let mut body = Node::List {
                items: arg_nodes,
                separator: None,
            };
            if f.distinct {
                body = Node::Concat {
                    items: vec![
                        Node::Keyword {
                            value: "DISTINCT".into(),
                        },
                        Node::Text { value: " ".into() },
                        body,
                    ],
                };
            }
            let items = vec![
                Node::Text {
                    value: format!("{}", f.name),
                },
                Node::Wrap {
                    keyword: None,
                    open: "(".into(),
                    content: Box::new(body),
                    close: ")".into(),
                },
            ];
            items
        }
    };

    append_function_filter(f, &mut items);

    if let Some(ws) = &f.over {
        items.push(window_spec_to_node(ws));
    }

    Node::Concat { items }
}

fn append_function_filter(f: &Function<Raw>, items: &mut Vec<Node>) {
    if let Some(filter) = &f.filter {
        items.push(Node::Text { value: " ".into() });
        items.push(Node::Keyword {
            value: "FILTER".into(),
        });
        items.push(Node::Wrap {
            keyword: None,
            open: " (WHERE ".into(),
            content: Box::new(expr_to_node(filter)),
            close: ")".into(),
        });
    }
}

fn window_spec_to_node(ws: &WindowSpec<Raw>) -> Node {
    let WindowSpec {
        partition_by,
        order_by,
        window_frame,
        ignore_nulls,
        respect_nulls,
    } = ws;

    let mut items: Vec<Node> = Vec::new();

    // IGNORE NULLS / RESPECT NULLS come before OVER (per AstDisplay order)
    if *ignore_nulls {
        items.push(Node::Text {
            value: " IGNORE NULLS".into(),
        });
    }
    if *respect_nulls {
        items.push(Node::Text {
            value: " RESPECT NULLS".into(),
        });
    }

    items.push(Node::Text {
        value: " OVER (".into(),
    });

    // Build the inside of OVER (...)
    if !partition_by.is_empty() {
        let part_items: Vec<Node> = partition_by.iter().map(expr_to_node).collect();
        items.push(Node::Keyword {
            value: "PARTITION BY".into(),
        });
        items.push(Node::Text { value: " ".into() });
        items.push(Node::List {
            items: part_items,
            separator: None,
        });
    }

    if !order_by.is_empty() {
        if !partition_by.is_empty() {
            items.push(Node::Text { value: " ".into() });
        }
        let order_items: Vec<Node> = order_by.iter().map(order_by_expr_to_node).collect();
        items.push(Node::Keyword {
            value: "ORDER BY".into(),
        });
        items.push(Node::Text { value: " ".into() });
        items.push(Node::List {
            items: order_items,
            separator: None,
        });
    }

    if let Some(frame) = window_frame {
        if !partition_by.is_empty() || !order_by.is_empty() {
            items.push(Node::Text { value: " ".into() });
        }
        items.push(Node::Keyword {
            value: format!("{}", frame.units),
        });
        items.push(Node::Text { value: " ".into() });
        if let Some(end_bound) = &frame.end_bound {
            items.push(Node::Keyword {
                value: "BETWEEN".into(),
            });
            items.push(Node::Text { value: " ".into() });
            items.push(Node::Text {
                value: format!("{}", frame.start_bound),
            });
            items.push(Node::Text { value: " ".into() });
            items.push(Node::Keyword { value: "AND".into() });
            items.push(Node::Text { value: " ".into() });
            items.push(Node::Text {
                value: format!("{end_bound}"),
            });
        } else {
            items.push(Node::Text {
                value: format!("{}", frame.start_bound),
            });
        }
    }

    items.push(Node::Text { value: ")".into() });

    Node::Concat { items }
}

fn insert_stmt_to_node(ins: &InsertStatement<Raw>) -> Node {
    let InsertStatement {
        table_name,
        columns,
        source,
        returning,
    } = ins;

    let mut clauses = vec![Clause {
        keyword: "INSERT INTO".into(),
        body: Some(Box::new(table_name_to_node(table_name))),
    }];

    if !columns.is_empty() {
        let col_items: Vec<Node> = columns.iter().map(ident_to_node).collect();
        clauses.push(Clause {
            keyword: "".into(),
            body: Some(Box::new(Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(Node::List {
                    items: col_items,
                    separator: None,
                }),
                close: ")".into(),
            })),
        });
    }

    match source {
        InsertSource::Query(q) => {
            clauses.push(Clause {
                keyword: "".into(),
                body: Some(Box::new(query_to_node(q))),
            });
        }
        InsertSource::DefaultValues => {
            clauses.push(Clause {
                keyword: "".into(),
                body: Some(Box::new(Node::Text {
                    value: "DEFAULT VALUES".into(),
                })),
            });
        }
    }

    if !returning.is_empty() {
        let ret_items: Vec<Node> = returning.iter().map(select_item_to_node).collect();
        clauses.push(Clause {
            keyword: "RETURNING".into(),
            body: Some(Box::new(Node::List {
                items: ret_items,
                separator: None,
            })),
        });
    }

    Node::Clauses { items: clauses }
}

fn update_stmt_to_node(upd: &UpdateStatement<Raw>) -> Node {
    let UpdateStatement {
        table_name,
        alias,
        assignments,
        selection,
    } = upd;

    let mut table_node = table_name_to_node(table_name);
    if let Some(a) = alias {
        table_node = table_alias_node(table_node, a);
    }

    let mut clauses = vec![Clause {
        keyword: "UPDATE".into(),
        body: Some(Box::new(table_node)),
    }];

    if !assignments.is_empty() {
        let assign_items: Vec<Node> = assignments
            .iter()
            .map(|a| assignment_to_node(a))
            .collect();
        clauses.push(Clause {
            keyword: "SET".into(),
            body: Some(Box::new(Node::List {
                items: assign_items,
                separator: None,
            })),
        });
    }

    if let Some(sel) = selection {
        clauses.push(Clause {
            keyword: "WHERE".into(),
            body: Some(Box::new(expr_to_node(sel))),
        });
    }

    Node::Clauses { items: clauses }
}

fn delete_stmt_to_node(del: &DeleteStatement<Raw>) -> Node {
    let DeleteStatement {
        table_name,
        alias,
        using,
        selection,
    } = del;

    let mut table_node = table_name_to_node(table_name);
    if let Some(a) = alias {
        table_node = table_alias_node(table_node, a);
    }

    let mut clauses = vec![Clause {
        keyword: "DELETE FROM".into(),
        body: Some(Box::new(table_node)),
    }];

    if !using.is_empty() {
        let using_items: Vec<Node> = using.iter().map(table_with_joins_to_node).collect();
        clauses.push(Clause {
            keyword: "USING".into(),
            body: Some(Box::new(Node::List {
                items: using_items,
                separator: None,
            })),
        });
    }

    if let Some(sel) = selection {
        clauses.push(Clause {
            keyword: "WHERE".into(),
            body: Some(Box::new(expr_to_node(sel))),
        });
    }

    Node::Clauses { items: clauses }
}

fn create_table_to_node(ct: &CreateTableStatement<Raw>) -> Node {
    let CreateTableStatement {
        name,
        columns,
        constraints,
        if_not_exists,
        temporary,
        with_options,
    } = ct;

    let mut title = "CREATE".to_string();
    if *temporary {
        title.push_str(" TEMPORARY");
    }
    title.push_str(" TABLE");
    if *if_not_exists {
        title.push_str(" IF NOT EXISTS");
    }

    let mut body_parts: Vec<String> = columns.iter().map(|c| format!("{c}")).collect();
    body_parts.extend(constraints.iter().map(|c| format!("{c}")));
    let body_str = body_parts.join(", ");

    let table_def = Node::Concat {
        items: vec![
            table_name_to_node(name),
            Node::Wrap {
                keyword: None,
                open: " (".into(),
                content: Box::new(Node::Text {
                    value: body_str,
                }),
                close: ")".into(),
            },
        ],
    };

    let mut clauses = vec![Clause {
        keyword: title,
        body: Some(Box::new(table_def)),
    }];

    if !with_options.is_empty() {
        let opts_str = with_options
            .iter()
            .map(|o| o.to_ast_string_simple())
            .collect::<Vec<_>>()
            .join(", ");
        clauses.push(Clause {
            keyword: "WITH".into(),
            body: Some(Box::new(Node::Wrap {
                keyword: None,
                open: " (".into(),
                content: Box::new(Node::Text { value: opts_str }),
                close: ")".into(),
            })),
        });
    }

    Node::Clauses { items: clauses }
}

fn set_variable_to_node(sv: &SetVariableStatement) -> Node {
    let mut title = "SET".to_string();
    if sv.local {
        title.push_str(" LOCAL");
    }
    Node::Clauses {
        items: vec![Clause {
            keyword: title,
            body: Some(Box::new(Node::Infix {
                op: "=".into(),
                items: vec![
                    ident_to_node(&sv.variable),
                    Node::Text {
                        value: format!("{}", sv.to),
                    },
                ],
            })),
        }],
    }
}

fn reset_variable_to_node(rv: &ResetVariableStatement) -> Node {
    Node::Clauses {
        items: vec![Clause {
            keyword: "RESET".into(),
            body: Some(Box::new(ident_to_node(&rv.variable))),
        }],
    }
}

fn drop_objects_to_node(drop: &DropObjectsStatement) -> Node {
    let DropObjectsStatement {
        object_type,
        if_exists,
        names,
        cascade,
    } = drop;

    let mut title = format!("DROP {object_type}");
    if *if_exists {
        title.push_str(" IF EXISTS");
    }

    let name_nodes: Vec<Node> = names
        .iter()
        .map(|n| Node::Identifier {
            value: format!("{n}"),
            quote: None,
        })
        .collect();
    let body = if name_nodes.len() == 1 {
        name_nodes.into_iter().next().unwrap()
    } else {
        Node::List {
            items: name_nodes,
            separator: None,
        }
    };

    let mut body_items = vec![body];
    if *cascade {
        body_items.push(Node::Text {
            value: " CASCADE".into(),
        });
    } else if *object_type == ObjectType::Database {
        body_items.push(Node::Text {
            value: " RESTRICT".into(),
        });
    }

    Node::Clauses {
        items: vec![Clause {
            keyword: title,
            body: Some(Box::new(if body_items.len() == 1 {
                body_items.pop().unwrap()
            } else {
                Node::Concat { items: body_items }
            })),
        }],
    }
}

fn create_index_to_node(ci: &CreateIndexStatement<Raw>) -> Node {
    let CreateIndexStatement {
        name,
        in_cluster,
        on_name,
        key_parts,
        with_options,
        if_not_exists,
    } = ci;

    let mut title = "CREATE ".to_string();
    if key_parts.is_none() {
        title.push_str("DEFAULT ");
    }
    title.push_str("INDEX");
    if *if_not_exists {
        title.push_str(" IF NOT EXISTS");
    }

    let mut body_items = Vec::new();
    if let Some(n) = name {
        body_items.push(ident_to_node(n));
    }
    if let Some(cluster) = in_cluster {
        if !body_items.is_empty() {
            body_items.push(Node::Text { value: " ".into() });
        }
        body_items.push(Node::Text {
            value: format!("IN CLUSTER {cluster}"),
        });
    }
    if !body_items.is_empty() {
        body_items.push(Node::Text { value: " ".into() });
    }
    body_items.push(Node::Keyword { value: "ON".into() });
    body_items.push(Node::Text { value: " ".into() });
    body_items.push(table_name_to_node(on_name));
    if let Some(kp) = key_parts {
        let kp_nodes: Vec<Node> = kp.iter().map(expr_to_node).collect();
        body_items.push(Node::Wrap {
            keyword: None,
            open: " (".into(),
            content: Box::new(Node::List {
                items: kp_nodes,
                separator: None,
            }),
            close: ")".into(),
        });
    }

    let mut clauses = vec![Clause {
        keyword: title,
        body: Some(Box::new(if body_items.len() == 1 {
            body_items.pop().unwrap()
        } else {
            Node::Concat { items: body_items }
        })),
    }];

    if !with_options.is_empty() {
        let opts_str = with_options
            .iter()
            .map(|o| o.to_ast_string_simple())
            .collect::<Vec<_>>()
            .join(", ");
        clauses.push(Clause {
            keyword: "WITH".into(),
            body: Some(Box::new(Node::Wrap {
                keyword: None,
                open: " (".into(),
                content: Box::new(Node::Text { value: opts_str }),
                close: ")".into(),
            })),
        });
    }

    Node::Clauses { items: clauses }
}

fn create_view_to_node(cv: &CreateViewStatement<Raw>) -> Node {
    let CreateViewStatement {
        if_exists,
        temporary,
        definition,
    } = cv;

    let mut title = "CREATE".to_string();
    if *if_exists == IfExistsBehavior::Replace {
        title.push_str(" OR REPLACE");
    }
    if *temporary {
        title.push_str(" TEMPORARY");
    }
    title.push_str(" VIEW");
    if *if_exists == IfExistsBehavior::Skip {
        title.push_str(" IF NOT EXISTS");
    }

    let mut name_items = vec![table_name_to_node(&definition.name)];
    if !definition.columns.is_empty() {
        let col_nodes: Vec<Node> = definition.columns.iter().map(ident_to_node).collect();
        name_items.push(Node::Wrap {
            keyword: None,
            open: " (".into(),
            content: Box::new(Node::List {
                items: col_nodes,
                separator: None,
            }),
            close: ")".into(),
        });
    }
    let name_body = if name_items.len() == 1 {
        name_items.pop().unwrap()
    } else {
        Node::Concat { items: name_items }
    };

    let clauses = vec![
        Clause {
            keyword: title,
            body: Some(Box::new(name_body)),
        },
        Clause {
            keyword: "AS".into(),
            body: Some(Box::new(query_to_node(&definition.query))),
        },
    ];

    Node::Clauses { items: clauses }
}

fn create_materialized_view_to_node(mv: &CreateMaterializedViewStatement<Raw>) -> Node {
    let CreateMaterializedViewStatement {
        if_exists,
        name,
        columns,
        replacement_for,
        in_cluster,
        in_cluster_replica,
        query,
        as_of,
        with_options,
    } = mv;

    let mut title = "CREATE".to_string();
    if *if_exists == IfExistsBehavior::Replace {
        title.push_str(" OR REPLACE");
    }
    if replacement_for.is_some() {
        title.push_str(" REPLACEMENT");
    }
    title.push_str(" MATERIALIZED VIEW");
    if *if_exists == IfExistsBehavior::Skip {
        title.push_str(" IF NOT EXISTS");
    }

    // Name + optional columns + optional FOR
    let mut name_items = vec![table_name_to_node(name)];
    if !columns.is_empty() {
        let col_nodes: Vec<Node> = columns.iter().map(ident_to_node).collect();
        name_items.push(Node::Wrap {
            keyword: None,
            open: " (".into(),
            content: Box::new(Node::List {
                items: col_nodes,
                separator: None,
            }),
            close: ")".into(),
        });
    }
    if let Some(target) = replacement_for {
        name_items.push(Node::Text { value: " FOR ".into() });
        name_items.push(Node::Identifier {
            value: format!("{target}"),
            quote: None,
        });
    }
    let mut name_body = if name_items.len() == 1 {
        name_items.pop().unwrap()
    } else {
        Node::Concat { items: name_items }
    };

    // IN CLUSTER / REPLICA
    match (in_cluster, in_cluster_replica) {
        (Some(cluster), Some(replica)) => {
            name_body = Node::Concat {
                items: vec![
                    name_body,
                    Node::Text {
                        value: format!(" IN CLUSTER {cluster} REPLICA {replica}"),
                    },
                ],
            };
        }
        (Some(cluster), None) => {
            name_body = Node::Concat {
                items: vec![
                    name_body,
                    Node::Text {
                        value: format!(" IN CLUSTER {cluster}"),
                    },
                ],
            };
        }
        (None, Some(replica)) => {
            name_body = Node::Concat {
                items: vec![
                    name_body,
                    Node::Text {
                        value: format!(" IN REPLICA {replica}"),
                    },
                ],
            };
        }
        (None, None) => {}
    }

    let mut clauses = vec![Clause {
        keyword: title,
        body: Some(Box::new(name_body)),
    }];

    if !with_options.is_empty() {
        let opts_str = with_options
            .iter()
            .map(|o| o.to_ast_string_simple())
            .collect::<Vec<_>>()
            .join(", ");
        clauses.push(Clause {
            keyword: "WITH".into(),
            body: Some(Box::new(Node::Wrap {
                keyword: None,
                open: " (".into(),
                content: Box::new(Node::Text { value: opts_str }),
                close: ")".into(),
            })),
        });
    }

    clauses.push(Clause {
        keyword: "AS".into(),
        body: Some(Box::new(query_to_node(query))),
    });

    if let Some(at) = as_of {
        clauses.push(Clause {
            keyword: "AS OF".into(),
            body: Some(Box::new(Node::Text {
                value: format!("{at}"),
            })),
        });
    }

    Node::Clauses { items: clauses }
}

fn table_name_to_node(name: &impl std::fmt::Display) -> Node {
    Node::Identifier {
        value: name.to_string(),
        quote: None,
    }
}

fn table_alias_node(node: Node, alias: &TableAlias) -> Node {
    let mut items = vec![
        node,
        Node::Text { value: " ".into() },
        Node::Keyword { value: "AS".into() },
        Node::Text { value: " ".into() },
        ident_to_node(&alias.name),
    ];
    items.push(column_list_node(&alias.columns));
    Node::Concat { items }
}

fn assignment_to_node(a: &Assignment<Raw>) -> Node {
    Node::Infix {
        op: "=".into(),
        items: vec![ident_to_node(&a.id), expr_to_node(&a.value)],
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

fn entry_to_node(entry: &MapEntry<Raw>) -> Node {
    Node::Concat {
        items: vec![
            expr_to_node(&entry.key),
            Node::Text { value: " => ".into() },
            expr_to_node(&entry.value),
        ],
    }
}

fn subscript_position_to_node(pos: &SubscriptPosition<Raw>) -> Node {
    match (&pos.start, &pos.end, pos.explicit_slice) {
        (Some(start), Some(end), true) => Node::Concat {
            items: vec![
                expr_to_node(start),
                Node::Text { value: ":".into() },
                expr_to_node(end),
            ],
        },
        (Some(start), None, true) => Node::Concat {
            items: vec![
                expr_to_node(start),
                Node::Text { value: ":".into() },
            ],
        },
        (None, Some(end), true) => Node::Concat {
            items: vec![
                Node::Text { value: ":".into() },
                expr_to_node(end),
            ],
        },
        (Some(start), None, false) => expr_to_node(start),
        _ => Node::Text {
            value: format!("{pos}"),
        },
    }
}
