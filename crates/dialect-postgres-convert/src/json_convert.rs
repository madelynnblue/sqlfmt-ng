use serde_json::Value;
use sqlfmt_core::SqlfmtError;
use sqlfmt_ir::{Clause, Node};

// PostgreSQL reserved keywords that need quoting when used as identifiers.
// Kept minimal — only add words that appear in actual corpus failures.
const PG_RESERVED_TYPE_KEYWORDS: &[&str] = &[
    "char",              // pseudo-type "char" vs the SQL char/character(1) type
    "current_user",      // SQLValueFunction keyword
    "current_date",      // SQLValueFunction keyword
    "current_time",      // SQLValueFunction keyword
    "current_timestamp", // SQLValueFunction keyword
    "current_role",      // SQLValueFunction keyword
    "current_schema",    // SQLValueFunction keyword
    "current_catalog",   // SQLValueFunction keyword
    "session_user",      // SQLValueFunction keyword
    "user",              // SQLValueFunction keyword
    "localtime",         // SQLValueFunction keyword
    "localtimestamp",    // SQLValueFunction keyword
    "default",           // reserved keyword
];

fn pg_needs_quoting(s: &str) -> bool {
    if s.is_empty() {
        return true;
    }
    if PG_RESERVED_TYPE_KEYWORDS.contains(&s) {
        return true;
    }
    let mut chars = s.chars();
    let first_ok = chars
        .next()
        .map(|c| matches!(c, 'a'..='z' | '_'))
        .unwrap_or(false);
    !first_ok || !chars.all(|c| matches!(c, 'a'..='z' | '0'..='9' | '_' | '$'))
}

fn ident_node(s: &str) -> Node {
    Node::Identifier {
        value: s.to_string(),
        quote: if pg_needs_quoting(s) {
            Some("\"".to_string())
        } else {
            None
        },
    }
}

fn qualified_ident_node(parts: &[&str]) -> Node {
    if parts.is_empty() {
        return Node::Text {
            value: String::new(),
        };
    }
    if parts.len() == 1 {
        return if parts[0] == "*" {
            Node::Text { value: "*".into() }
        } else {
            ident_node(parts[0])
        };
    }
    let mut items: Vec<Node> = Vec::new();
    for (i, part) in parts.iter().enumerate() {
        if i > 0 {
            items.push(Node::Text { value: ".".into() });
        }
        if *part == "*" {
            items.push(Node::Text { value: "*".into() });
        } else {
            items.push(ident_node(part));
        }
    }
    Node::Concat { items }
}

/// Convert a pg-query-emscripten JSON parse tree into a sqlfmt IR Node.
///
/// `json_str` should be `JSON.stringify(result.parse_tree)` from `pg-query-emscripten`'s
/// `parse()` call. Handles both the newer `{"stmts": [...]}` top-level format and the older
/// `[{RawStmt: {...}}, ...]` array format.
pub fn convert_pg_query_json(json_str: &str) -> Result<Node, SqlfmtError> {
    let v: Value = serde_json::from_str(json_str)
        .map_err(|e| SqlfmtError::Parse(format!("JSON parse error: {e}")))?;

    // Top-level is either {"version": N, "stmts": [...]} or [{RawStmt: {...}}, ...]
    let stmts: Vec<&Value> = if let Some(arr) = v["stmts"].as_array() {
        arr.iter().collect()
    } else if let Some(arr) = v.as_array() {
        arr.iter().collect()
    } else {
        return Err(SqlfmtError::Parse(
            "unexpected top-level JSON format".into(),
        ));
    };

    if stmts.is_empty() {
        return Err(SqlfmtError::Parse("empty statement list".into()));
    }

    let mut nodes: Vec<Node> = Vec::new();
    for raw in stmts {
        // Each element is either {"stmt": {NodeType: {...}}, ...} or {"RawStmt": {"stmt": {...}}}
        let stmt = if let Some(inner) = raw.get("stmt") {
            inner
        } else if let Some(raw_stmt) = raw.get("RawStmt") {
            &raw_stmt["stmt"]
        } else {
            return Err(SqlfmtError::Parse(format!(
                "unexpected stmt wrapper: {raw}"
            )));
        };

        match stmt_to_node(stmt) {
            Some(node) => nodes.push(node),
            None => {
                return Err(SqlfmtError::Parse(format!(
                    "unsupported statement type: {stmt}"
                )));
            }
        }
    }

    // Single statement: return it directly (handles UNION/INTERSECT/EXCEPT which are not Clauses).
    if nodes.len() == 1 {
        return Ok(nodes.remove(0));
    }

    // Multiple statements: merge Clauses, wrap non-Clauses nodes into empty keyword clauses.
    let mut clauses = Vec::new();
    for node in nodes {
        match node {
            Node::Clauses { items } => clauses.extend(items),
            other => clauses.push(Clause {
                keyword: String::new(),
                body: Some(Box::new(other)),
            }),
        }
    }
    Ok(Node::Clauses { items: clauses })
}

fn stmt_to_node(stmt: &Value) -> Option<Node> {
    let obj = stmt.as_object()?;
    if let Some(inner) = obj.get("SelectStmt") {
        Some(select_stmt_to_node(inner))
    } else if let Some(inner) = obj.get("InsertStmt") {
        Some(insert_stmt_to_node(inner))
    } else if let Some(inner) = obj.get("UpdateStmt") {
        Some(update_stmt_to_node(inner))
    } else if let Some(inner) = obj.get("DeleteStmt") {
        Some(delete_stmt_to_node(inner))
    } else if let Some(inner) = obj.get("MergeStmt") {
        Some(merge_stmt_to_node(inner))
    } else if let Some(inner) = obj.get("CreateStmt") {
        Some(create_stmt_to_node(inner))
    } else if let Some(inner) = obj.get("CreateTableAsStmt") {
        Some(create_table_as_stmt_to_node(inner))
    } else if let Some(inner) = obj.get("DropStmt") {
        Some(drop_stmt_to_node(inner))
    } else if let Some(inner) = obj.get("ViewStmt") {
        Some(view_stmt_to_node(inner))
    } else if let Some(inner) = obj.get("IndexStmt") {
        Some(index_stmt_to_node(inner))
    } else {
        None
    }
}

fn node_value_to_node(v: &Value) -> Node {
    let Some(obj) = v.as_object() else {
        return Node::Unformatted {
            value: v.to_string(),
        };
    };

    if let Some(inner) = obj.get("SelectStmt") {
        select_stmt_to_node(inner)
    } else if let Some(inner) = obj.get("InsertStmt") {
        insert_stmt_to_node(inner)
    } else if let Some(inner) = obj.get("UpdateStmt") {
        update_stmt_to_node(inner)
    } else if let Some(inner) = obj.get("DeleteStmt") {
        delete_stmt_to_node(inner)
    } else if let Some(inner) = obj.get("MergeStmt") {
        merge_stmt_to_node(inner)
    } else if let Some(inner) = obj.get("ResTarget") {
        res_target_to_node(inner)
    } else if let Some(inner) = obj.get("ColumnRef") {
        column_ref_to_node(inner)
    } else if let Some(inner) = obj.get("A_Const") {
        a_const_to_node(inner)
    } else if let Some(inner) = obj.get("RangeVar") {
        range_var_to_node(inner)
    } else if let Some(inner) = obj.get("RangeFunction") {
        range_function_to_node(inner)
    } else if let Some(inner) = obj.get("RangeSubselect") {
        range_subselect_to_node(inner)
    } else if let Some(inner) = obj.get("JoinExpr") {
        join_expr_to_node(inner)
    } else if let Some(inner) = obj.get("A_Expr") {
        a_expr_to_node(inner)
    } else if let Some(inner) = obj.get("BoolExpr") {
        bool_expr_to_node(inner)
    } else if let Some(inner) = obj.get("CaseExpr") {
        case_expr_to_node(inner)
    } else if let Some(inner) = obj.get("CoalesceExpr") {
        coalesce_expr_to_node(inner)
    } else if let Some(inner) = obj.get("CollateClause") {
        collate_clause_to_node(inner)
    } else if let Some(inner) = obj.get("RowExpr") {
        row_expr_to_node(inner)
    } else if let Some(inner) = obj.get("SQLValueFunction") {
        sql_value_function_to_node(inner)
    } else if let Some(inner) = obj.get("A_ArrayExpr") {
        array_expr_to_node(inner)
    } else if let Some(inner) = obj.get("FuncCall") {
        func_call_to_node(inner)
    } else if let Some(inner) = obj.get("SortBy") {
        sort_by_to_node(inner)
    } else if let Some(inner) = obj.get("TypeCast") {
        type_cast_to_node(inner)
    } else if let Some(inner) = obj.get("SubLink") {
        sub_link_to_node(inner)
    } else if let Some(inner) = obj.get("NullTest") {
        null_test_to_node(inner)
    } else if let Some(inner) = obj.get("IndexElem") {
        index_elem_to_node(inner)
    } else if let Some(inner) = obj.get("PartitionElem") {
        partition_elem_to_node(inner)
    } else if let Some(inner) = obj.get("Integer") {
        let ival = inner["ival"].as_i64().unwrap_or(0);
        Node::Literal {
            value: ival.to_string(),
        }
    } else if let Some(inner) = obj.get("Float") {
        let fval = inner["fval"].as_str().unwrap_or("0").to_string();
        Node::Literal { value: fval }
    } else if let Some(inner) = obj.get("Boolean") {
        let bval = inner["boolval"].as_bool().unwrap_or(false);
        Node::Literal {
            value: if bval { "TRUE".into() } else { "FALSE".into() },
        }
    } else if let Some(inner) = obj.get("String") {
        ident_node(string_val(inner))
    } else if obj.contains_key("A_Star") {
        Node::Text { value: "*".into() }
    } else {
        Node::Unformatted {
            value: format!("{v}"),
        }
    }
}

// Handle both `sval` (pg_query v5+) and `str` (older versions).
fn string_val(v: &Value) -> &str {
    v["sval"]
        .as_str()
        .or_else(|| v["str"].as_str())
        .unwrap_or("")
}

/// Extract the strength keyword, wait keyword, and optional locked relations
/// from a LockingClause JSON value. Shared between set-op and select locking paths.
fn locking_clause_parts(lc: &Value) -> (&'static str, &'static str, Option<Vec<Node>>) {
    let lc_inner = lc.get("LockingClause").unwrap_or(lc);
    let base_kw = match lc_inner["strength"].as_str().unwrap_or("LCS_FORUPDATE") {
        "LCS_FORKEYSHARE" => "FOR KEY SHARE",
        "LCS_FORSHARE" => "FOR SHARE",
        "LCS_FORNOKEYUPDATE" => "FOR NO KEY UPDATE",
        _ => "FOR UPDATE",
    };
    let wait_kw = match lc_inner["waitPolicy"].as_str().unwrap_or("") {
        "LockWaitError" => " NOWAIT",
        "LockWaitSkip" => " SKIP LOCKED",
        _ => "",
    };
    let rel_nodes = lc_inner["lockedRels"].as_array().map(|rels| {
        rels.iter()
            .map(|r| {
                let rv = r.get("RangeVar").unwrap_or(r);
                range_var_to_node(rv)
            })
            .collect()
    });
    (base_kw, wait_kw, rel_nodes)
}

fn insert_stmt_to_node(stmt: &Value) -> Node {
    let mut clauses: Vec<Clause> = Vec::new();

    if let Some(with_clause) = build_with_clause(stmt) {
        clauses.push(with_clause);
    }

    let relation = range_var_to_node(&stmt["relation"]);
    let insert_into_body = if let Some(cols) = stmt["cols"].as_array().filter(|a| !a.is_empty()) {
        let col_nodes: Vec<Node> = cols
            .iter()
            .map(|c| {
                let rv = c.get("ResTarget").unwrap_or(c);
                let name = rv["name"].as_str().unwrap_or("");
                let mut items = vec![ident_node(name)];
                append_indirection(&mut items, &rv["indirection"]);
                if items.len() == 1 {
                    items.remove(0)
                } else {
                    Node::Concat { items }
                }
            })
            .collect();
        Node::Concat {
            items: vec![
                relation,
                Node::Text { value: " ".into() },
                Node::Wrap {
                    keyword: None,
                    open: "(".into(),
                    content: Box::new(Node::List {
                        items: col_nodes,
                        separator: None,
                    }),
                    close: ")".into(),
                },
            ],
        }
    } else {
        relation
    };
    clauses.push(Clause {
        keyword: "INSERT INTO".into(),
        body: Some(Box::new(insert_into_body)),
    });

    match stmt["override"].as_str().unwrap_or("") {
        "OVERRIDING_SYSTEM_VALUE" => {
            clauses.push(Clause {
                keyword: "OVERRIDING SYSTEM VALUE".into(),
                body: None,
            });
        }
        "OVERRIDING_USER_VALUE" => {
            clauses.push(Clause {
                keyword: "OVERRIDING USER VALUE".into(),
                body: None,
            });
        }
        _ => {}
    }

    // Source: VALUES, DEFAULT VALUES, or subquery
    if !stmt["selectStmt"].is_null() {
        let source = node_value_to_node(&stmt["selectStmt"]);
        if let Node::Clauses { items } = source {
            clauses.extend(items);
        } else {
            // Set-operation sources (UNION/INTERSECT/EXCEPT) return Concat, not Clauses.
            clauses.push(Clause {
                keyword: String::new(),
                body: Some(Box::new(source)),
            });
        }
    } else {
        clauses.push(Clause {
            keyword: "DEFAULT VALUES".into(),
            body: None,
        });
    }

    // ON CONFLICT clause
    if stmt["onConflictClause"]
        .get("OnConflictClause")
        .or_else(|| {
            stmt["onConflictClause"]
                .as_object()
                .filter(|o| !o.is_empty())
                .map(|_| &stmt["onConflictClause"])
        })
        .is_some()
    {
        let oc = stmt["onConflictClause"]
            .get("OnConflictClause")
            .unwrap_or(&stmt["onConflictClause"]);
        let action = match oc["action"].as_str().unwrap_or("") {
            "ONCONFLICT_NOTHING" => "DO NOTHING",
            _ => "DO UPDATE",
        };
        let mut conflict_body_items: Vec<Node> = Vec::new();

        // Inference: (col1, col2) or ON CONSTRAINT name
        if let Some(infer) = oc.get("infer").filter(|i| !i.is_null()) {
            let infer = infer.get("InferClause").unwrap_or(infer);
            if let Some(con) = infer["conname"].as_str().filter(|s| !s.is_empty()) {
                conflict_body_items.push(Node::Text {
                    value: format!("ON CONSTRAINT {con}"),
                });
            } else if let Some(elems) = infer["indexElems"].as_array().filter(|a| !a.is_empty()) {
                let elem_nodes: Vec<Node> = elems.iter().map(node_value_to_node).collect();
                conflict_body_items.push(Node::Wrap {
                    keyword: None,
                    open: "(".into(),
                    content: Box::new(Node::List {
                        items: elem_nodes,
                        separator: None,
                    }),
                    close: ")".into(),
                });
            }
            if !infer["whereClause"].is_null() {
                conflict_body_items.push(Node::Concat {
                    items: vec![
                        Node::Text {
                            value: " WHERE ".into(),
                        },
                        node_value_to_node(&infer["whereClause"]),
                    ],
                });
            }
        }

        conflict_body_items.push(Node::Concat {
            items: vec![
                Node::Text { value: " ".into() },
                Node::Keyword {
                    value: action.into(),
                },
            ],
        });

        // For DO UPDATE SET assignments
        if action == "DO UPDATE" {
            if let Some(targets) = oc["targetList"].as_array() {
                if !targets.is_empty() {
                    let set_items: Vec<Node> = targets
                        .iter()
                        .map(|t| set_target_to_node(t.get("ResTarget").unwrap_or(t)))
                        .collect();
                    conflict_body_items.push(Node::Concat {
                        items: vec![
                            Node::Text {
                                value: " SET ".into(),
                            },
                            Node::List {
                                items: set_items,
                                separator: None,
                            },
                        ],
                    });
                }
            }
            if !oc["whereClause"].is_null() {
                conflict_body_items.push(Node::Concat {
                    items: vec![
                        Node::Text {
                            value: " WHERE ".into(),
                        },
                        node_value_to_node(&oc["whereClause"]),
                    ],
                });
            }
        }

        clauses.push(Clause {
            keyword: "ON CONFLICT".into(),
            body: Some(Box::new(Node::Concat {
                items: conflict_body_items,
            })),
        });
    }

    if let Some(ret) = stmt["returningList"].as_array() {
        if !ret.is_empty() {
            let items: Vec<Node> = ret.iter().map(node_value_to_node).collect();
            clauses.push(Clause {
                keyword: "RETURNING".into(),
                body: Some(Box::new(Node::List {
                    items,
                    separator: None,
                })),
            });
        }
    }

    Node::Clauses { items: clauses }
}

fn update_stmt_to_node(stmt: &Value) -> Node {
    let mut clauses: Vec<Clause> = Vec::new();

    if let Some(with_clause) = build_with_clause(stmt) {
        clauses.push(with_clause);
    }

    let relation = range_var_to_node(&stmt["relation"]);
    clauses.push(Clause {
        keyword: "UPDATE".into(),
        body: Some(Box::new(relation)),
    });

    if let Some(targets) = stmt["targetList"].as_array() {
        if !targets.is_empty() {
            let set_items: Vec<Node> = targets
                .iter()
                .map(|t| set_target_to_node(t.get("ResTarget").unwrap_or(t)))
                .collect();
            clauses.push(Clause {
                keyword: "SET".into(),
                body: Some(Box::new(Node::List {
                    items: set_items,
                    separator: None,
                })),
            });
        }
    }

    if let Some(from) = stmt["fromClause"].as_array() {
        if !from.is_empty() {
            let items: Vec<Node> = from.iter().map(node_value_to_node).collect();
            let body = if items.len() == 1 {
                items.into_iter().next().unwrap()
            } else {
                Node::List {
                    items,
                    separator: None,
                }
            };
            clauses.push(Clause {
                keyword: "FROM".into(),
                body: Some(Box::new(body)),
            });
        }
    }

    if !stmt["whereClause"].is_null() {
        clauses.push(Clause {
            keyword: "WHERE".into(),
            body: Some(Box::new(node_value_to_node(&stmt["whereClause"]))),
        });
    }

    if let Some(ret) = stmt["returningList"].as_array() {
        if !ret.is_empty() {
            let items: Vec<Node> = ret.iter().map(node_value_to_node).collect();
            clauses.push(Clause {
                keyword: "RETURNING".into(),
                body: Some(Box::new(Node::List {
                    items,
                    separator: None,
                })),
            });
        }
    }

    Node::Clauses { items: clauses }
}

fn delete_stmt_to_node(stmt: &Value) -> Node {
    let mut clauses: Vec<Clause> = Vec::new();

    if let Some(with_clause) = build_with_clause(stmt) {
        clauses.push(with_clause);
    }

    let relation = range_var_to_node(&stmt["relation"]);
    clauses.push(Clause {
        keyword: "DELETE FROM".into(),
        body: Some(Box::new(relation)),
    });

    if let Some(using) = stmt["usingClause"].as_array() {
        if !using.is_empty() {
            let items: Vec<Node> = using.iter().map(node_value_to_node).collect();
            let body = if items.len() == 1 {
                items.into_iter().next().unwrap()
            } else {
                Node::List {
                    items,
                    separator: None,
                }
            };
            clauses.push(Clause {
                keyword: "USING".into(),
                body: Some(Box::new(body)),
            });
        }
    }

    if !stmt["whereClause"].is_null() {
        clauses.push(Clause {
            keyword: "WHERE".into(),
            body: Some(Box::new(node_value_to_node(&stmt["whereClause"]))),
        });
    }

    if let Some(ret) = stmt["returningList"].as_array() {
        if !ret.is_empty() {
            let items: Vec<Node> = ret.iter().map(node_value_to_node).collect();
            clauses.push(Clause {
                keyword: "RETURNING".into(),
                body: Some(Box::new(Node::List {
                    items,
                    separator: None,
                })),
            });
        }
    }

    Node::Clauses { items: clauses }
}

fn merge_stmt_to_node(stmt: &Value) -> Node {
    let mut clauses: Vec<Clause> = Vec::new();

    if let Some(with_clause) = build_with_clause(stmt) {
        clauses.push(with_clause);
    }

    let relation = range_var_to_node(&stmt["relation"]);
    clauses.push(Clause {
        keyword: "MERGE INTO".into(),
        body: Some(Box::new(relation)),
    });

    // Source relation
    if !stmt["sourceRelation"].is_null() {
        let source = node_value_to_node(&stmt["sourceRelation"]);
        clauses.push(Clause {
            keyword: "USING".into(),
            body: Some(Box::new(source)),
        });
    }

    if !stmt["joinCondition"].is_null() {
        clauses.push(Clause {
            keyword: "ON".into(),
            body: Some(Box::new(node_value_to_node(&stmt["joinCondition"]))),
        });
    }

    if let Some(when_clauses) = stmt["mergeWhenClauses"].as_array() {
        for wc in when_clauses {
            let mwc = wc.get("MergeWhenClause").unwrap_or(wc);
            let matched = mwc["matched"].as_bool().unwrap_or(false);
            let cmd_type = mwc["commandType"].as_str().unwrap_or("");
            let when_kw = if matched {
                "WHEN MATCHED"
            } else {
                "WHEN NOT MATCHED"
            };
            let action_kw = match cmd_type {
                "CMD_INSERT" => "INSERT",
                "CMD_UPDATE" => "UPDATE",
                "CMD_DELETE" => "DELETE",
                _ => "DO NOTHING",
            };

            // Build body items: [AND <condition>] THEN <action>
            let mut body_items: Vec<Node> = Vec::new();

            if !mwc["condition"].is_null() {
                body_items.push(Node::Concat {
                    items: vec![
                        Node::Keyword {
                            value: "AND".into(),
                        },
                        Node::Text { value: " ".into() },
                        node_value_to_node(&mwc["condition"]),
                        Node::Text { value: " ".into() },
                    ],
                });
            }

            body_items.push(Node::Keyword {
                value: "THEN".into(),
            });

            body_items.push(Node::Text { value: " ".into() });

            body_items.push(Node::Keyword {
                value: action_kw.into(),
            });

            if cmd_type == "CMD_UPDATE" {
                if let Some(targets) = mwc["targetList"].as_array() {
                    if !targets.is_empty() {
                        let set_items: Vec<Node> = targets
                            .iter()
                            .map(|t| set_target_to_node(t.get("ResTarget").unwrap_or(t)))
                            .collect();
                        body_items.push(Node::Concat {
                            items: vec![
                                Node::Text {
                                    value: " SET ".into(),
                                },
                                Node::List {
                                    items: set_items,
                                    separator: None,
                                },
                            ],
                        });
                    }
                }
            } else if cmd_type == "CMD_INSERT" {
                // Column list (e.g., INSERT (tid, balance))
                if let Some(targets) = mwc["targetList"].as_array() {
                    if !targets.is_empty() {
                        let col_items: Vec<Node> = targets
                            .iter()
                            .map(|t| {
                                let rt = t.get("ResTarget").unwrap_or(t);
                                let name = rt["name"].as_str().unwrap_or("");
                                let mut items = vec![ident_node(name)];
                                append_indirection(&mut items, &rt["indirection"]);
                                if items.len() == 1 {
                                    items.remove(0)
                                } else {
                                    Node::Concat { items }
                                }
                            })
                            .collect();
                        body_items.push(Node::Concat {
                            items: vec![
                                Node::Text { value: " ".into() },
                                Node::Wrap {
                                    keyword: None,
                                    open: "(".into(),
                                    content: Box::new(Node::List {
                                        items: col_items,
                                        separator: None,
                                    }),
                                    close: ")".into(),
                                },
                            ],
                        });
                    }
                }
                // OVERRIDING clause
                match mwc["override"].as_str().unwrap_or("") {
                    "OVERRIDING_SYSTEM_VALUE" => {
                        body_items.push(Node::Text {
                            value: " OVERRIDING SYSTEM VALUE".into(),
                        });
                    }
                    "OVERRIDING_USER_VALUE" => {
                        body_items.push(Node::Text {
                            value: " OVERRIDING USER VALUE".into(),
                        });
                    }
                    _ => {}
                }
                if let Some(vals) = mwc["values"].as_array() {
                    if !vals.is_empty() {
                        let val_items: Vec<Node> = vals.iter().map(node_value_to_node).collect();
                        body_items.push(Node::Concat {
                            items: vec![
                                Node::Text {
                                    value: " VALUES ".into(),
                                },
                                Node::Wrap {
                                    keyword: None,
                                    open: "(".into(),
                                    content: Box::new(Node::List {
                                        items: val_items,
                                        separator: None,
                                    }),
                                    close: ")".into(),
                                },
                            ],
                        });
                    }
                }
            }

            clauses.push(Clause {
                keyword: when_kw.into(),
                body: Some(Box::new(Node::Concat { items: body_items })),
            });
        }
    }

    Node::Clauses { items: clauses }
}

fn create_table_as_stmt_to_node(stmt: &Value) -> Node {
    let into = &stmt["into"];
    let rel = range_var_to_node(&into["rel"]);

    let objtype = stmt["objtype"].as_str().unwrap_or("OBJECT_TABLE");
    let (base_kw, is_matview) = match objtype {
        "OBJECT_MATVIEW" => ("CREATE MATERIALIZED VIEW", true),
        _ => ("CREATE TABLE", false),
    };

    let relpersistence = into["rel"]["relpersistence"].as_str().unwrap_or("");
    let create_kw = if is_matview {
        base_kw.to_string()
    } else {
        match relpersistence {
            "t" => "CREATE TEMP TABLE",
            "u" => "CREATE UNLOGGED TABLE",
            _ => "CREATE TABLE",
        }
        .to_string()
    };

    // Build the CREATE TABLE ... AS body.
    let mut body_items: Vec<Node> = Vec::new();

    if stmt["if_not_exists"].as_bool().unwrap_or(false) {
        body_items.push(Node::Keyword {
            value: "IF NOT EXISTS".into(),
        });
        body_items.push(Node::Text { value: " ".into() });
    }
    body_items.push(rel);

    // Column names: (a, b)
    if let Some(cols) = into["colNames"].as_array().filter(|a| !a.is_empty()) {
        let col_nodes: Vec<Node> = cols
            .iter()
            .map(|c| {
                let s = c.get("String").map(string_val).unwrap_or("");
                ident_node(s)
            })
            .collect();
        body_items.push(Node::Wrap {
            keyword: None,
            open: " (".into(),
            content: Box::new(Node::List {
                items: col_nodes,
                separator: None,
            }),
            close: ")".into(),
        });
    }

    // WITH options
    if let Some(opts) = into["options"].as_array().filter(|a| !a.is_empty()) {
        let opt_nodes: Vec<Node> = opts.iter().map(def_elem_to_node).collect();
        body_items.push(Node::Text { value: " ".into() });
        body_items.push(Node::Wrap {
            keyword: Some("WITH".into()),
            open: " (".into(),
            content: Box::new(Node::List {
                items: opt_nodes,
                separator: None,
            }),
            close: ")".into(),
        });
    }

    let query_node = node_value_to_node(&stmt["query"]);
    let mut items = vec![
        Clause {
            keyword: create_kw.into(),
            body: Some(Box::new(Node::Concat {
                items: body_items,
            })),
        },
        Clause {
            keyword: "AS".into(),
            body: Some(Box::new(query_node)),
        },
    ];

    // WITH NO DATA
    if into["skipData"].as_bool().unwrap_or(false) {
        items.push(Clause {
            keyword: "WITH NO DATA".into(),
            body: None,
        });
    }

    // ON COMMIT (for temp tables)
    let on_commit = into["onCommit"].as_str().unwrap_or("");
    match on_commit {
        "ONCOMMIT_DELETE_ROWS" => {
            items.push(Clause {
                keyword: "ON COMMIT DELETE ROWS".into(),
                body: None,
            });
        }
        "ONCOMMIT_PRESERVE_ROWS" => {
            items.push(Clause {
                keyword: "ON COMMIT PRESERVE ROWS".into(),
                body: None,
            });
        }
        "ONCOMMIT_DROP" => {
            items.push(Clause {
                keyword: "ON COMMIT DROP".into(),
                body: None,
            });
        }
        _ => {}
    }

    Node::Clauses { items }
}

fn parens_block(elts: Vec<Node>) -> Node {
    Node::Concat {
        items: vec![
            Node::Text { value: " (".into() },
            Node::Group {
                content: Box::new(Node::Nest {
                    content: Box::new(Node::Concat {
                        items: vec![
                            Node::Softline,
                            Node::List {
                                items: elts,
                                separator: None,
                            },
                            Node::Softline,
                        ],
                    }),
                }),
            },
            Node::Text { value: ")".into() },
        ],
    }
}

fn drop_stmt_to_node(stmt: &Value) -> Node {
    let remove_type = stmt["removeType"].as_str().unwrap_or("OBJECT_TABLE");
    let obj_kw = match remove_type {
        "OBJECT_TABLE" => "TABLE",
        "OBJECT_INDEX" => "INDEX",
        "OBJECT_SCHEMA" => "SCHEMA",
        "OBJECT_VIEW" => "VIEW",
        "OBJECT_SEQUENCE" => "SEQUENCE",
        "OBJECT_TYPE" => "TYPE",
        "OBJECT_FUNCTION" => "FUNCTION",
        "OBJECT_ROUTINE" => "ROUTINE",
        "OBJECT_FOREIGN_TABLE" => "FOREIGN TABLE",
        "OBJECT_MATVIEW" => "MATERIALIZED VIEW",
        "OBJECT_STATISTIC_EXT" => "STATISTICS",
        "OBJECT_TABLESPACE" => "TABLESPACE",
        "OBJECT_EXTENSION" => "EXTENSION",
        "OBJECT_EVENT_TRIGGER" => "EVENT TRIGGER",
        "OBJECT_POLICY" => "POLICY",
        "OBJECT_TRANSFORM" => "TRANSFORM",
        "OBJECT_ACCESS_METHOD" => "ACCESS METHOD",
        "OBJECT_OPCLASS" => "OPERATOR CLASS",
        "OBJECT_OPFAMILY" => "OPERATOR FAMILY",
        "OBJECT_COLLATION" => "COLLATION",
        "OBJECT_CONVERSION" => "CONVERSION",
        "OBJECT_DOMAIN" => "DOMAIN",
        "OBJECT_LANGUAGE" => "LANGUAGE",
        "OBJECT_LARGEOBJECT" => "LARGE OBJECT",
        "OBJECT_OPERATOR" => "OPERATOR",
        "OBJECT_AGGREGATE" => "AGGREGATE",
        "OBJECT_CAST" => "CAST",
        "OBJECT_RULE" => "RULE",
        "OBJECT_TRIGGER" => "TRIGGER",
        "OBJECT_PUBLICATION" => "PUBLICATION",
        "OBJECT_SUBSCRIPTION" => "SUBSCRIPTION",
        _ => "TABLE",
    };

    // Objects can be List (qualified names) or bare String (unqualified).
    let objects: Vec<Node> = stmt["objects"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .map(|obj| {
                    if let Some(list) = obj.get("List") {
                        let items: Vec<Node> = list["items"]
                            .as_array()
                            .map(|a| {
                                a.iter()
                                    .map(|item| {
                                        let s = item
                                            .get("String")
                                            .and_then(|v| v.get("sval"))
                                            .and_then(|v| v.as_str())
                                            .unwrap_or("");
                                        ident_node(s)
                                    })
                                    .collect()
                            })
                            .unwrap_or_default();
                        Node::Concat {
                            items: items
                                .into_iter()
                                .fold(Vec::new(), |mut acc, n| {
                                    if !acc.is_empty() {
                                        acc.push(Node::Text {
                                            value: ".".into(),
                                        });
                                    }
                                    acc.push(n);
                                    acc
                                }),
                        }
                    } else {
                        let s = obj
                            .get("String")
                            .and_then(|v| v.get("sval"))
                            .and_then(|v| v.as_str())
                            .unwrap_or("");
                        ident_node(s)
                    }
                })
                .collect()
        })
        .unwrap_or_default();

    // Build DROP keyword parts.
    let mut drop_keyword = String::from("DROP ");
    drop_keyword.push_str(obj_kw);

    let mut items: Vec<Node> = Vec::new();
    items.push(Node::Keyword {
        value: drop_keyword,
    });
    items.push(Node::Text { value: " ".into() });

    // IF EXISTS
    if stmt["missing_ok"].as_bool().unwrap_or(false) {
        items.push(Node::Keyword {
            value: "IF EXISTS".into(),
        });
        items.push(Node::Text { value: " ".into() });
    }

    // CONCURRENTLY (for indexes)
    if stmt["concurrent"].as_bool().unwrap_or(false) {
        items.push(Node::Keyword {
            value: "CONCURRENTLY".into(),
        });
        items.push(Node::Text { value: " ".into() });
    }

    // Object names
    let obj_list = Node::List {
        items: objects,
        separator: Some(",".into()),
    };
    items.push(obj_list);

    // CASCADE / RESTRICT
    let behavior = stmt["behavior"].as_str().unwrap_or("DROP_RESTRICT");
    if behavior == "DROP_CASCADE" {
        items.push(Node::Text { value: " ".into() });
        items.push(Node::Keyword {
            value: "CASCADE".into(),
        });
    } else if behavior == "DROP_RESTRICT" {
        items.push(Node::Text { value: " ".into() });
        items.push(Node::Keyword {
            value: "RESTRICT".into(),
        });
    }

    Node::Group {
        content: Box::new(Node::Concat { items }),
    }
}

fn view_stmt_to_node(stmt: &Value) -> Node {
    let view = range_var_to_node(&stmt["view"]);

    let relpersistence = stmt["view"]["relpersistence"]
        .as_str()
        .unwrap_or("p");

    let mut kw = String::from("CREATE");
    if relpersistence == "t" {
        kw.push_str(" TEMP");
    }
    if stmt["replace"].as_bool().unwrap_or(false) {
        kw.push_str(" OR REPLACE");
    }
    kw.push_str(" VIEW");

    // Column aliases.
    let aliases: Vec<Node> = stmt["aliases"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .map(|a| {
                    let s = a.get("String").map(string_val).unwrap_or("");
                    ident_node(s)
                })
                .collect()
        })
        .unwrap_or_default();

    // Build the CREATE VIEW part as a Clause with keyword and body.
    // Body is: [IF NOT EXISTS] viewName [(colNames)] AS query [WITH CHECK OPTION]
    let query = select_stmt_to_node(&stmt["query"]["SelectStmt"]);

    let check_option = stmt["withCheckOption"]
        .as_str()
        .unwrap_or("NO_CHECK_OPTION");

    let mut body_items: Vec<Node> = Vec::new();

    // View name + optional column list
    body_items.push(view);
    if !aliases.is_empty() {
        body_items.push(Node::Text { value: " ".into() });
        body_items.push(Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(Node::List {
                items: aliases,
                separator: None,
            }),
            close: ")".into(),
        });
    }

    // AS + query
    body_items.push(Node::Text { value: " ".into() });
    body_items.push(Node::Keyword {
        value: "AS".into(),
    });
    body_items.push(Node::Text { value: " ".into() });
    body_items.push(query);

    // WITH CHECK OPTION
    if check_option != "NO_CHECK_OPTION" {
        body_items.push(Node::Text { value: " ".into() });
        let ck = if check_option == "CASCADED_CHECK_OPTION" {
            "CASCADED"
        } else {
            "LOCAL"
        };
        body_items.push(Node::Keyword {
            value: format!("WITH {ck} CHECK OPTION"),
        });
    }

    let mut clauses: Vec<Clause> = Vec::new();

    // WITH clause (CTE) — can appear before CREATE VIEW.
    if let Some(with_clause) = build_with_clause(stmt) {
        clauses.push(with_clause);
    }

    clauses.push(Clause {
        keyword: kw,
        body: Some(Box::new(Node::Concat {
            items: body_items,
        })),
    });

    Node::Clauses { items: clauses }
}

fn index_stmt_to_node(stmt: &Value) -> Node {
    let mut kw = String::from("CREATE");
    if stmt["unique"].as_bool().unwrap_or(false) {
        kw.push_str(" UNIQUE");
    }
    kw.push_str(" INDEX");

    if stmt["concurrent"].as_bool().unwrap_or(false) {
        kw.push_str(" CONCURRENTLY");
    }

    // Build body: [IF NOT EXISTS] name ON relation [USING method] (indexParams) [WHERE whereClause]
    let mut body_items: Vec<Node> = Vec::new();

    if stmt["if_not_exists"].as_bool().unwrap_or(false) {
        body_items.push(Node::Keyword {
            value: "IF NOT EXISTS".into(),
        });
        body_items.push(Node::Text { value: " ".into() });
    }

    // Index name
    let idxname = stmt["idxname"]
        .as_str()
        .map(|s| ident_node(s))
        .unwrap_or(Node::Unformatted {
            value: "UNKNOWN_INDEX".into(),
        });
    body_items.push(idxname);
    body_items.push(Node::Text { value: " ".into() });

    // ON
    body_items.push(Node::Keyword {
        value: "ON".into(),
    });
    body_items.push(Node::Text { value: " ".into() });
    body_items.push(range_var_to_node(&stmt["relation"]));

    // USING method (skip if default btree — but easier to preserve reparse)
    let am = stmt["accessMethod"].as_str().unwrap_or("");
    if !am.is_empty() {
        body_items.push(Node::Text { value: " ".into() });
        body_items.push(Node::Keyword {
            value: "USING".into(),
        });
        body_items.push(Node::Text { value: " ".into() });
        body_items.push(ident_node(am));
    }

    // Column/expression list
    let index_params: Vec<Node> = stmt["indexParams"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .map(|p| {
                    p.get("IndexElem")
                        .map(index_elem_to_node)
                        .unwrap_or(Node::Unformatted {
                            value: format!("{p}"),
                        })
                })
                .collect()
        })
        .unwrap_or_default();

    body_items.push(Node::Text { value: " ".into() });
    body_items.push(Node::Wrap {
        keyword: None,
        open: "(".into(),
        content: Box::new(Node::List {
            items: index_params,
            separator: None,
        }),
        close: ")".into(),
    });

    // WHERE clause
    if !stmt["whereClause"].is_null() {
        body_items.push(Node::Text { value: " ".into() });
        body_items.push(Node::Keyword {
            value: "WHERE".into(),
        });
        body_items.push(Node::Text { value: " ".into() });
        body_items.push(node_value_to_node(&stmt["whereClause"]));
    }

    Node::Clauses {
        items: vec![Clause {
            keyword: kw,
            body: Some(Box::new(Node::Concat {
                items: body_items,
            })),
        }],
    }
}

fn create_stmt_to_node(stmt: &Value) -> Node {
    // Table name.
    let relation = range_var_to_node(&stmt["relation"]);

    // OF type_name (typed tables).
    let is_of_type = !stmt["ofTypename"].is_null();

    // Table elements: columns and constraints.
    let elts_result: Vec<Node> = stmt["tableElts"]
        .as_array()
        .map(|arr| arr.iter().map(table_elt_to_node).collect())
        .unwrap_or_default();

    let body_content = if is_of_type {
        let of_type_str = type_name_str(&stmt["ofTypename"]);
        let of_body = Node::Concat {
            items: vec![
                Node::Keyword { value: "OF".into() },
                Node::Text { value: " ".into() },
                Node::Text { value: of_type_str },
            ],
        };
        if elts_result.is_empty() {
            of_body
        } else {
            Node::Concat {
                items: vec![
                    of_body,
                    Node::Text { value: " ".into() },
                    parens_block(elts_result),
                ],
            }
        }
    } else {
        parens_block(elts_result)
    };

    // CREATE TABLE [IF NOT EXISTS] tablename ...
    let create_kw = match stmt["relation"]["relpersistence"]
        .as_str()
        .unwrap_or("")
    {
        "t" => "CREATE TEMP TABLE",
        "u" => "CREATE UNLOGGED TABLE",
        _ => "CREATE TABLE",
    };

    let mut header_items: Vec<Node> = Vec::new();
    header_items.push(Node::Keyword {
        value: create_kw.into(),
    });
    header_items.push(Node::Text { value: " ".into() });
    if stmt["if_not_exists"].as_bool().unwrap_or(false) {
        header_items.push(Node::Keyword {
            value: "IF NOT EXISTS".into(),
        });
        header_items.push(Node::Text { value: " ".into() });
    }
    header_items.push(relation);
    if is_of_type {
        header_items.push(Node::Text { value: " ".into() });
    }
    header_items.push(body_content);

    let main_part = Node::Group {
        content: Box::new(Node::Concat {
            items: header_items,
        }),
    };

    // Collect additional clauses.
    let mut additional_clauses: Vec<Clause> = Vec::new();

    // INHERITS.
    if let Some(inh) = stmt["inhRelations"].as_array() {
        if !inh.is_empty() {
            let inh_rels: Vec<Node> = inh.iter().map(range_var_to_node).collect();
            additional_clauses.push(Clause {
                keyword: "INHERITS".into(),
                body: Some(Box::new(Node::Wrap {
                    keyword: None,
                    open: "(".into(),
                    content: Box::new(Node::List {
                        items: inh_rels,
                        separator: None,
                    }),
                    close: ")".into(),
                })),
            });
        }
    }

    // PARTITION BY.
    if let Some(part) = stmt["partspec"].as_object() {
        let kw = part["strategy"]
            .as_str()
            .unwrap_or("PARTITION_STRATEGY_LIST");
        let strat = match kw {
            "PARTITION_STRATEGY_HASH" => "HASH",
            "PARTITION_STRATEGY_RANGE" => "RANGE",
            _ => "LIST",
        };
        let part_exprs: Vec<Node> = part["partParams"]
            .as_array()
            .map(|arr| arr.iter().map(node_value_to_node).collect())
            .unwrap_or_default();
        additional_clauses.push(Clause {
            keyword: "PARTITION BY".into(),
            body: Some(Box::new(Node::Concat {
                items: vec![
                    Node::Keyword {
                        value: strat.into(),
                    },
                    Node::Text { value: " ".into() },
                    Node::Wrap {
                        keyword: None,
                        open: "(".into(),
                        content: Box::new(Node::List {
                            items: part_exprs,
                            separator: None,
                        }),
                        close: ")".into(),
                    },
                ],
            })),
        });
    }

    // USING.
    if let Some(am) = stmt["accessMethod"].as_str().filter(|s| !s.is_empty()) {
        additional_clauses.push(Clause {
            keyword: "USING".into(),
            body: Some(Box::new(ident_node(am))),
        });
    }

    // WITH options (storage parameters).
    if let Some(opts) = stmt["options"].as_array().filter(|a| !a.is_empty()) {
        let opt_items: Vec<Node> = opts.iter().map(|o| def_elem_to_node(o)).collect();
        additional_clauses.push(Clause {
            keyword: "WITH".into(),
            body: Some(Box::new(Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(Node::List {
                    items: opt_items,
                    separator: None,
                }),
                close: ")".into(),
            })),
        });
    }

    // ON COMMIT.
    let oncommit = stmt["oncommit"].as_str().unwrap_or("ONCOMMIT_NOOP");
    if oncommit != "ONCOMMIT_NOOP" {
        let kw = match oncommit {
            "ONCOMMIT_PRESERVE_ROWS" => "ON COMMIT PRESERVE ROWS",
            "ONCOMMIT_DELETE_ROWS" => "ON COMMIT DELETE ROWS",
            "ONCOMMIT_DROP" => "ON COMMIT DROP",
            _ => "",
        };
        if !kw.is_empty() {
            additional_clauses.push(Clause {
                keyword: kw.into(),
                body: None,
            });
        }
    }

    // TABLESPACE.
    if !stmt["tablespacename"].is_null() {
        let ts = stmt["tablespacename"].as_str().unwrap_or("");
        if !ts.is_empty() {
            additional_clauses.push(Clause {
                keyword: "TABLESPACE".into(),
                body: Some(Box::new(ident_node(ts))),
            });
        }
    }

    // Build final output.
    let mut items: Vec<Node> = Vec::new();

    // WITH clause (CTE) can appear before CREATE TABLE.
    if let Some(with_clause) = build_with_clause(stmt) {
        items.push(Node::Clauses {
            items: vec![with_clause],
        });
        items.push(Node::Line);
    }

    items.push(main_part);

    if !additional_clauses.is_empty() {
        items.push(Node::Line);
        items.push(Node::Clauses {
            items: additional_clauses,
        });
    }

    Node::Concat { items }
}

fn table_elt_to_node(elt: &Value) -> Node {
    let obj = match elt.as_object() {
        Some(o) => o,
        None => return Node::Unformatted { value: format!("{elt}") },
    };

    if let Some(col) = obj.get("ColumnDef") {
        column_def_to_node(col)
    } else if let Some(c) = obj.get("Constraint") {
        constraint_to_node(c)
    } else {
        Node::Unformatted { value: format!("{elt}") }
    }
}

fn column_def_to_node(col: &Value) -> Node {
    let colname = col["colname"].as_str().unwrap_or("");

    let mut items: Vec<Node> = vec![ident_node(colname)];

    // Omit the type for typed tables (OF type_name) where the column inherits
    // the type from the parent type and has no typeName of its own.
    let type_str = type_name_str(&col["typeName"]);
    let has_type = col["typeName"]["names"].as_array().map(|a| !a.is_empty()).unwrap_or(false);
    if has_type {
        items.push(Node::Text { value: " ".into() });
        items.push(Node::Text { value: type_str });
    }

    // ARRAY[N] dimension suffix on the type (e.g. integer ARRAY[4]).
    // Only present in CREATE TABLE type declarations, not in type casts.
    // type_name_str already handles empty arrayBounds for [] suffix;
    // here we handle non-empty arrayBounds entries as ARRAY[N].
    if let Some(bounds) = col["typeName"]["arrayBounds"].as_array() {
        for b in bounds {
            if let Some(int_obj) = b["Integer"].as_object().filter(|o| !o.is_empty()) {
                let ival = int_obj.get("ival");
                let n = ival
                    .and_then(|v| v.as_i64().or_else(|| v["ival"].as_i64()))
                    .unwrap_or(0);
                items.push(Node::Text {
                    value: format!(" ARRAY[{n}]"),
                });
            }
        }
    }

    // COLLATE clause.
    if let Some(coll_vals) = col["collClause"]["collname"].as_array().filter(|a| !a.is_empty()) {
        let coll_parts: Vec<&str> = coll_vals
            .iter()
            .filter_map(|n| {
                n["String"]["sval"]
                    .as_str()
                    .or_else(|| n["String"]["str"].as_str())
            })
            .collect();
        if !coll_parts.is_empty() {
            let c_str = coll_parts.join(".");
            items.push(Node::Text { value: " ".into() });
            items.push(Node::Keyword {
                value: "COLLATE".into(),
            });
            items.push(Node::Text { value: " ".into() });
            items.push(ident_node(&c_str));
        }
    }

    // STORAGE clause (e.g. STORAGE EXTERNAL).
    let storage = col["storage_name"].as_str().unwrap_or("");
    if !storage.is_empty() {
        items.push(Node::Text { value: " ".into() });
        items.push(Node::Keyword {
            value: "STORAGE".into(),
        });
        items.push(Node::Text { value: " ".into() });
        items.push(Node::Keyword {
            value: storage.to_uppercase(),
        });
    }

    // COMPRESSION clause.
    if let Some(comp) = col["compression"].as_str().filter(|s| !s.is_empty()) {
        items.push(Node::Text {
            value: " ".into(),
        });
        items.push(Node::Keyword {
            value: "COMPRESSION".into(),
        });
        items.push(Node::Text { value: " ".into() });
        items.push(ident_node(comp));
    }

    if let Some(constraints) = col["constraints"].as_array() {
        for c in constraints {
            items.push(Node::Text { value: " ".into() });
            items.push(constraint_to_node(
                &c["Constraint"],
            ));
        }
    }

    Node::Concat { items }
}

fn constraint_to_node(c: &Value) -> Node {
    let contype = c["contype"].as_str().unwrap_or("");

    let body = match contype {
        "CONSTR_NOTNULL" => Node::Keyword {
            value: "NOT NULL".into(),
        },
        "CONSTR_NULL" => Node::Keyword {
            value: "NULL".into(),
        },
        "CONSTR_PRIMARY" => {
            let base = Node::Keyword {
                value: "PRIMARY KEY".into(),
            };
            indexspace_suffix(c, base)
        }
        "CONSTR_UNIQUE" => {
            let nulls_not_distinct = c["nulls_not_distinct"].as_bool().unwrap_or(false);
            let base = if nulls_not_distinct {
                Node::Keyword {
                    value: "UNIQUE NULLS NOT DISTINCT".into(),
                }
            } else {
                Node::Keyword {
                    value: "UNIQUE".into(),
                }
            };
            indexspace_suffix(c, base)
        }
        "CONSTR_DEFAULT" => {
            let expr = node_value_to_node(&c["raw_expr"]);
            Node::Concat {
                items: vec![
                    Node::Keyword {
                        value: "DEFAULT".into(),
                    },
                    Node::Text { value: " ".into() },
                    expr,
                ],
            }
        }
        "CONSTR_CHECK" => {
            let expr = node_value_to_node(&c["raw_expr"]);
            let mut items = vec![
                Node::Keyword {
                    value: "CHECK".into(),
                },
                Node::Text { value: " ".into() },
                Node::Wrap {
                    keyword: None,
                    open: "(".into(),
                    content: Box::new(expr),
                    close: ")".into(),
                },
            ];
            if c["is_no_inherit"].as_bool().unwrap_or(false) {
                items.push(Node::Text {
                    value: " NO INHERIT".into(),
                });
            }
            if c["skip_validation"].as_bool().unwrap_or(false) {
                items.push(Node::Text {
                    value: " NOT VALID".into(),
                });
            }
            Node::Concat { items }
        }
        "CONSTR_FOREIGN" => {
            let pktable = range_var_to_node(&c["pktable"]);
            let mut items = vec![
                Node::Keyword {
                    value: "REFERENCES".into(),
                },
                Node::Text { value: " ".into() },
                pktable,
            ];
            if let Some(fk_cols) = c["pk_attrs"].as_array().filter(|a| !a.is_empty()) {
                let col_nodes: Vec<Node> = fk_cols
                    .iter()
                    .map(|a| {
                        let s = a["String"]
                            .get("sval")
                            .or_else(|| a["String"].get("str"))
                            .and_then(|v| v.as_str())
                            .unwrap_or("");
                        ident_node(s)
                    })
                    .collect();
                items.push(Node::Wrap {
                    keyword: None,
                    open: "(".into(),
                    content: Box::new(Node::List {
                        items: col_nodes,
                        separator: None,
                    }),
                    close: ")".into(),
                });
            }
            // Foreign key match type.
            match c["fk_matchtype"].as_str().unwrap_or("") {
                "f" => {
                    items.push(Node::Text {
                        value: " MATCH FULL".into(),
                    });
                }
                "p" => {
                    items.push(Node::Text {
                        value: " MATCH PARTIAL".into(),
                    });
                }
                _ => {} // MATCH SIMPLE is the default, skip it
            }
            // FK actions: ON DELETE/UPDATE.
            let del_action = fk_action_str(c["fk_del_action"].as_str().unwrap_or(""));
            if !del_action.is_empty() {
                items.push(Node::Text {
                    value: format!(" ON DELETE {del_action}"),
                });
            }
            let upd_action = fk_action_str(c["fk_upd_action"].as_str().unwrap_or(""));
            if !upd_action.is_empty() {
                items.push(Node::Text {
                    value: format!(" ON UPDATE {upd_action}"),
                });
            }
            Node::Concat { items }
        }
        "CONSTR_IDENTITY" => {
            let ident_items = constraint_generated_identity(c);
            Node::Concat { items: ident_items }
        }
        "CONSTR_GENERATED" => {
            let gen_items = constraint_generated_identity(c);
            Node::Concat { items: gen_items }
        }
        _ => {
            // Unrecognized constraint — fall back to raw text.
            Node::Unformatted {
                value: format!("{c}"),
            }
        }
    };

    // Wrap with CONSTRAINT <name> if named.
    let conname = c["conname"].as_str().unwrap_or("");
    let result = if !conname.is_empty() {
        Node::Concat {
            items: vec![
                Node::Keyword {
                    value: "CONSTRAINT".into(),
                },
                Node::Text { value: " ".into() },
                ident_node(conname),
                Node::Text { value: " ".into() },
                body,
            ],
        }
    } else {
        body
    };

    result
}

/// Append USING INDEX TABLESPACE if the constraint specifies one.
fn indexspace_suffix(c: &Value, base: Node) -> Node {
    let indexspace = c["indexspace"].as_str().unwrap_or("");
    if indexspace.is_empty() {
        base
    } else {
        Node::Concat {
            items: vec![
                base,
                Node::Text {
                    value: format!(" USING INDEX TABLESPACE {indexspace}"),
                },
            ],
        }
    }
}

/// Build the GENERATED / IDENTITY constraint suffix.
fn constraint_generated_identity(c: &Value) -> Vec<Node> {
    let mut items: Vec<Node> = Vec::new();

    let contype = c["contype"].as_str().unwrap_or("");
    // generated_when can be 'a' (always) or 'd' (by default) in pg_query.
    let gen_when = c["generated_when"].as_str().unwrap_or("d");
    let is_always = gen_when == "a" || gen_when == "ATTRIBUTE_IDENTITY_ALWAYS";
    match contype {
        "CONSTR_IDENTITY" => {
            items.push(Node::Keyword {
                value: "GENERATED".into(),
            });
            items.push(Node::Text { value: " ".into() });
            items.push(Node::Keyword {
                value: if is_always { "ALWAYS" } else { "BY DEFAULT" }.into(),
            });
            items.push(Node::Text { value: " ".into() });
            items.push(Node::Keyword {
                value: "AS IDENTITY".into(),
            });
        }
        "CONSTR_GENERATED" => {
            items.push(Node::Keyword {
                value: "GENERATED".into(),
            });
            items.push(Node::Text { value: " ".into() });
            items.push(Node::Keyword {
                value: if is_always { "ALWAYS" } else { "BY DEFAULT" }.into(),
            });
            items.push(Node::Text { value: " ".into() });
            items.push(Node::Keyword {
                value: "AS".into(),
            });
            items.push(Node::Text { value: " ".into() });
            items.push(Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(node_value_to_node(&c["raw_expr"])),
                close: ")".into(),
            });
        }
        _ => {}
    }

    // Sequence options for IDENTITY columns.
    if let Some(opts) = c["options"].as_array().filter(|a| !a.is_empty()) {
        let opt_strs: Vec<String> = opts
            .iter()
            .map(|o| format!("{o}"))
            .collect();
        let opt_text = opt_strs.join(" ");
        if !opt_text.is_empty() {
            items.push(Node::Text {
                value: format!(" ({opt_text})"),
            });
        }
    }

    items
}

fn def_elem_to_node(e: &Value) -> Node {
    let obj = match e.as_object().and_then(|o| o.get("DefElem")) {
        Some(o) => o,
        None => return Node::Unformatted { value: format!("{e}") },
    };
    let name = obj["defname"].as_str().unwrap_or("");
    let namespace = obj["defnamespace"].as_str().unwrap_or("");
    let full_name = if !namespace.is_empty() {
        format!("{namespace}.{name}")
    } else {
        name.to_string()
    };
    // Storage parameter names are not SQL identifiers — emit as Text.
    let name_node = Node::Text { value: full_name };
    if let Some(arg) = obj.get("arg") {
        let arg_node = if let Some(s) = arg.get("String").filter(|v| v.is_object()) {
            let sval = string_val(s);
            Node::Literal {
                value: format!("'{sval}'"),
            }
        } else {
            node_value_to_node(arg)
        };
        Node::Infix {
            op: "=".into(),
            items: vec![name_node, arg_node],
        }
    } else {
        name_node
    }
}

/// Convert FK action code to SQL keyword.
fn fk_action_str(action: &str) -> &'static str {
    match action {
        "a" => "", // FKCONSTR_ACTION_NOACTION — implicit, don't emit
        "r" => "RESTRICT",
        "c" => "CASCADE",
        "n" => "SET NULL",
        "d" => "SET DEFAULT",
        _ => "",
    }
}

fn set_op_to_node(s: &Value) -> Node {
    let op_kw = match s["op"].as_str().unwrap_or("SETOP_NONE") {
        "SETOP_UNION" if s["all"].as_bool().unwrap_or(false) => "UNION ALL",
        "SETOP_INTERSECT" => {
            if s["all"].as_bool().unwrap_or(false) {
                "INTERSECT ALL"
            } else {
                "INTERSECT"
            }
        }
        "SETOP_EXCEPT" => {
            if s["all"].as_bool().unwrap_or(false) {
                "EXCEPT ALL"
            } else {
                "EXCEPT"
            }
        }
        _ => "UNION",
    };

    let larg = &s["larg"];
    let rarg = &s["rarg"];

    // Render one side of the set op; wrap nested set-ops in parens to preserve precedence.
    let render_side = |side: &Value| -> Node {
        let side_op = side["op"].as_str().unwrap_or("SETOP_NONE");
        let side_has_with = side.get("withClause").filter(|w| !w.is_null()).is_some();
        // A non-setop arm with its own ORDER BY / LIMIT / OFFSET needs parens
        // because pg_query rejects bare `SELECT ... ORDER BY y EXCEPT SELECT ...`.
        let side_has_order_limit = side["sortClause"]
            .as_array()
            .map(|a| !a.is_empty())
            .unwrap_or(false)
            || !side["limitCount"].is_null()
            || !side["limitOffset"].is_null();
        let inner = select_stmt_to_node(side);
        if side_op != "SETOP_NONE" || side_has_with || side_has_order_limit {
            Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(inner),
                close: ")".into(),
            }
        } else {
            inner
        }
    };

    let lnode = render_side(larg);
    let rnode = render_side(rarg);

    // Build: larg \n op_kw \n rarg with hard line breaks between sections.
    let mut concat_items: Vec<Node> = vec![
        lnode,
        Node::Line,
        Node::Keyword {
            value: op_kw.into(),
        },
        Node::Line,
        rnode,
    ];

    // Top-level ORDER BY / LIMIT / OFFSET apply to the whole set expression.
    if let Some(sort) = s["sortClause"].as_array() {
        if !sort.is_empty() {
            let sort_items: Vec<Node> = sort.iter().map(node_value_to_node).collect();
            concat_items.push(Node::Line);
            concat_items.push(Node::Keyword {
                value: "ORDER BY".into(),
            });
            concat_items.push(Node::Text { value: " ".into() });
            concat_items.push(Node::List {
                items: sort_items,
                separator: None,
            });
        }
    }
    if !s["limitCount"].is_null() {
        concat_items.push(Node::Line);
        if s["limitOption"].as_str() == Some("LIMIT_OPTION_WITH_TIES") {
            concat_items.push(Node::Keyword {
                value: "FETCH FIRST".into(),
            });
            concat_items.push(Node::Text { value: " ".into() });
            concat_items.push(node_value_to_node(&s["limitCount"]));
            concat_items.push(Node::Text { value: " ".into() });
            concat_items.push(Node::Keyword {
                value: "ROWS WITH TIES".into(),
            });
        } else {
            concat_items.push(Node::Keyword {
                value: "LIMIT".into(),
            });
            concat_items.push(Node::Text { value: " ".into() });
            concat_items.push(node_value_to_node(&s["limitCount"]));
        }
    }
    if !s["limitOffset"].is_null() {
        concat_items.push(Node::Line);
        concat_items.push(Node::Keyword {
            value: "OFFSET".into(),
        });
        concat_items.push(Node::Text { value: " ".into() });
        concat_items.push(node_value_to_node(&s["limitOffset"]));
    }

    // FOR UPDATE / FOR SHARE on set operations.
    if let Some(locking) = s["lockingClause"].as_array() {
        for lc in locking {
            let (base_kw, wait_kw, rel_nodes) = locking_clause_parts(lc);
            concat_items.push(Node::Line);
            if let Some(rels) = rel_nodes {
                concat_items.push(Node::Keyword {
                    value: format!("{base_kw} OF"),
                });
                concat_items.push(Node::Text { value: " ".into() });
                concat_items.push(Node::List {
                    items: rels,
                    separator: None,
                });
                if !wait_kw.is_empty() {
                    concat_items.push(Node::Text {
                        value: wait_kw.into(),
                    });
                }
            } else {
                concat_items.push(Node::Keyword {
                    value: if wait_kw.is_empty() {
                        base_kw.to_string()
                    } else {
                        format!("{base_kw}{wait_kw}")
                    },
                });
            }
        }
    }

    Node::Concat {
        items: concat_items,
    }
}

fn common_table_expr_to_node(cte: &Value) -> Node {
    let ctename = cte["ctename"].as_str().unwrap_or("");
    let ctequery = node_value_to_node(&cte["ctequery"]);

    // Column aliases: CTE name(col1, col2, ...) AS (query)
    let col_aliases = cte["aliascolnames"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect::<Vec<_>>()
        })
        .unwrap_or_default();

    // Materialization: AS MATERIALIZED / AS NOT MATERIALIZED / AS
    let ctematerialized = cte["ctematerialized"].as_str().unwrap_or("");
    let as_keyword = match ctematerialized {
        "CTEMaterializeAlways" => " AS MATERIALIZED ",
        "CTEMaterializeNever" => " AS NOT MATERIALIZED ",
        _ => " AS ",
    };

    let header = if col_aliases.is_empty() {
        Node::Concat {
            items: vec![
                ident_node(ctename),
                Node::Text {
                    value: as_keyword.into(),
                },
            ],
        }
    } else {
        let aliases: Vec<Node> = col_aliases.iter().map(|&a| ident_node(a)).collect();
        Node::Concat {
            items: vec![
                ident_node(ctename),
                Node::Wrap {
                    keyword: None,
                    open: "(".into(),
                    content: Box::new(Node::List {
                        items: aliases,
                        separator: None,
                    }),
                    close: ")".into(),
                },
                Node::Text {
                    value: as_keyword.into(),
                },
            ],
        }
    };

    let body = Node::Wrap {
        keyword: None,
        open: "(".into(),
        content: Box::new(ctequery),
        close: ")".into(),
    };

    // Search and cycle clauses for recursive CTEs.
    // pg_query uses search_clause / cycle_clause (newer) or searchclause / cycleclause (older).
    let mut cte_items = vec![header, body];
    let search = cte.get("search_clause").or_else(|| cte.get("searchclause"));
    if let Some(search) = search.filter(|s| !s.is_null()) {
        cte_items.push(Node::Text { value: " ".into() });
        let search_col = search["search_seq_column"]
            .as_str()
            .or_else(|| search["search_col_name"].as_str())
            .unwrap_or("");
        let search_cols: Vec<Node> = search["search_col_list"]
            .as_array()
            .or_else(|| search["search_cols"].as_array())
            .map(|arr| arr.iter().map(node_value_to_node).collect())
            .unwrap_or_default();
        let breadth = search["search_breadth_first"].as_bool().unwrap_or(false);
        let direction = if breadth {
            "SEARCH BREADTH FIRST BY "
        } else {
            "SEARCH DEPTH FIRST BY "
        };
        let search_body = Node::Concat {
            items: vec![
                Node::Text {
                    value: direction.into(),
                },
                Node::List {
                    items: search_cols,
                    separator: None,
                },
                Node::Text {
                    value: format!(" SET {search_col}"),
                },
            ],
        };
        cte_items.push(search_body);
    }
    let cycle = cte.get("cycle_clause").or_else(|| cte.get("cycleclause"));
    if let Some(cycle) = cycle.filter(|c| !c.is_null()) {
        cte_items.push(Node::Text { value: " ".into() });
        let cycle_cols: Vec<Node> = cycle["cycle_col_list"]
            .as_array()
            .or_else(|| cycle["cycle_cols"].as_array())
            .map(|arr| arr.iter().map(node_value_to_node).collect())
            .unwrap_or_default();
        let cycle_mark = cycle["cycle_mark_column"].as_str().unwrap_or("");
        let cycle_mark_value = a_const_value_str(&cycle["cycle_mark_value"]).unwrap_or_default();
        let cycle_mark_default =
            a_const_value_str(&cycle["cycle_mark_default"]).unwrap_or_default();
        let cycle_path = cycle["cycle_path_column"].as_str().unwrap_or("");
        let using = if cycle_path.is_empty() {
            String::new()
        } else {
            format!(" USING {cycle_path}")
        };
        let cycle_body = Node::Concat {
            items: vec![
                Node::Text {
                    value: "CYCLE ".into(),
                },
                Node::List {
                    items: cycle_cols,
                    separator: None,
                },
                Node::Text {
                    value: format!(
                        " SET {cycle_mark} TO {cycle_mark_value} DEFAULT {cycle_mark_default}{using}"
                    ),
                },
            ],
        };
        cte_items.push(cycle_body);
    }

    Node::Concat { items: cte_items }
}

fn build_with_clause(s: &Value) -> Option<Clause> {
    let with = s.get("withClause").filter(|w| !w.is_null())?;
    let recursive = with["recursive"].as_bool().unwrap_or(false);
    let kw = if recursive { "WITH RECURSIVE" } else { "WITH" };
    let ctes = with["ctes"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .map(|c| {
                    c.get("CommonTableExpr")
                        .map(common_table_expr_to_node)
                        .unwrap_or(Node::Unformatted {
                            value: format!("{c}"),
                        })
                })
                .collect::<Vec<_>>()
        })
        .unwrap_or_default();
    Some(Clause {
        keyword: kw.into(),
        body: Some(Box::new(Node::List {
            items: ctes,
            separator: Some(",".into()),
        })),
    })
}

fn select_stmt_to_node(s: &Value) -> Node {
    // UNION / INTERSECT / EXCEPT: delegate to set-op handling.
    let op = s["op"].as_str().unwrap_or("SETOP_NONE");
    if op != "SETOP_NONE" {
        let set_op = set_op_to_node(s);
        // If there's a WITH clause, prepend it.
        if let Some(with_clause) = build_with_clause(s) {
            return Node::Concat {
                items: vec![
                    Node::Clauses {
                        items: vec![with_clause],
                    },
                    Node::Line,
                    set_op,
                ],
            };
        }
        return set_op;
    }

    let mut clauses: Vec<Clause> = Vec::new();

    // WITH clause (CTEs).
    if let Some(with_clause) = build_with_clause(s) {
        clauses.push(with_clause);
    }

    // DISTINCT / DISTINCT ON
    // pg_query represents SELECT DISTINCT as distinctClause: [{}] (NIL sentinel),
    // and SELECT DISTINCT ON (exprs) as distinctClause: [{expr}, ...].
    // VALUES clause: represented as valuesLists with no targetList.
    if let Some(values_lists) = s["valuesLists"].as_array() {
        if !values_lists.is_empty() {
            let rows: Vec<Node> = values_lists
                .iter()
                .map(|row| {
                    let items: Vec<Node> = row
                        .as_array()
                        .or_else(|| row["List"]["items"].as_array())
                        .unwrap_or(&vec![])
                        .iter()
                        .map(node_value_to_node)
                        .collect();
                    Node::Wrap {
                        keyword: None,
                        open: "(".into(),
                        content: Box::new(Node::List {
                            items,
                            separator: None,
                        }),
                        close: ")".into(),
                    }
                })
                .collect();
            clauses.push(Clause {
                keyword: "VALUES".into(),
                body: Some(Box::new(Node::List {
                    items: rows,
                    separator: None,
                })),
            });
        }
        return finish_select(s, clauses);
    }

    let distinct = s["distinctClause"].as_array();
    let is_nil = |v: &serde_json::Value| v.as_object().is_some_and(|o| o.is_empty()) || v.is_null();
    let select_keyword = if let Some(dc) = distinct {
        let has_real_exprs = dc.iter().any(|v| !is_nil(v));
        if !has_real_exprs {
            // Empty array or [NIL] — plain SELECT DISTINCT
            "SELECT DISTINCT".to_string()
        } else {
            // Non-nil elements — SELECT DISTINCT ON (exprs)
            "SELECT DISTINCT ON".to_string()
        }
    } else {
        "SELECT".to_string()
    };

    if let Some(items) = s["targetList"].as_array() {
        if !items.is_empty() {
            let nodes: Vec<Node> = items.iter().map(node_value_to_node).collect();

            // For DISTINCT ON, we need to include the ON (...) part in the keyword
            let keyword = if select_keyword == "SELECT DISTINCT ON" {
                if let Some(dc) = s["distinctClause"].as_array() {
                    let on_items: Vec<Node> = dc.iter().map(node_value_to_node).collect();
                    // Build: SELECT DISTINCT ON (expr, ...) col, ...
                    // We embed DISTINCT ON (...) into the clause body as a concat
                    let on_part = Node::Wrap {
                        keyword: None,
                        open: "(".into(),
                        content: Box::new(Node::List {
                            items: on_items,
                            separator: None,
                        }),
                        close: ")".into(),
                    };
                    let body = Node::Concat {
                        items: vec![
                            on_part,
                            Node::Text { value: " ".into() },
                            Node::List {
                                items: nodes,
                                separator: None,
                            },
                        ],
                    };
                    clauses.push(Clause {
                        keyword: "SELECT DISTINCT ON".into(),
                        body: Some(Box::new(body)),
                    });
                    return finish_select(s, clauses);
                }
                "SELECT".to_string()
            } else {
                select_keyword
            };

            clauses.push(Clause {
                keyword,
                body: Some(Box::new(Node::List {
                    items: nodes,
                    separator: None,
                })),
            });
        } else {
            clauses.push(Clause {
                keyword: select_keyword,
                body: None,
            });
        }
    } else {
        clauses.push(Clause {
            keyword: select_keyword,
            body: None,
        });
    }

    finish_select(s, clauses)
}

fn finish_select(s: &Value, mut clauses: Vec<Clause>) -> Node {
    // SELECT INTO: INTO clause comes before FROM in PostgreSQL syntax.
    if !s["intoClause"].is_null() {
        let rel = s["intoClause"]["IntoClause"]["rel"]
            .as_object()
            .map(|o| serde_json::Value::Object(o.clone()))
            .or_else(|| {
                s["intoClause"]["rel"]
                    .as_object()
                    .map(|o| serde_json::Value::Object(o.clone()))
            });
        if let Some(rel_val) = rel {
            let dest = range_var_to_node(&rel_val);
            clauses.push(Clause {
                keyword: "INTO".into(),
                body: Some(Box::new(dest)),
            });
        }
    }

    if let Some(from) = s["fromClause"].as_array() {
        if !from.is_empty() {
            let items: Vec<Node> = from.iter().map(node_value_to_node).collect();
            let body = if items.len() == 1 {
                items.into_iter().next().unwrap()
            } else {
                Node::List {
                    items,
                    separator: None,
                }
            };
            clauses.push(Clause {
                keyword: "FROM".into(),
                body: Some(Box::new(body)),
            });
        }
    }

    if !s["whereClause"].is_null() {
        clauses.push(Clause {
            keyword: "WHERE".into(),
            body: Some(Box::new(node_value_to_node(&s["whereClause"]))),
        });
    }

    if let Some(group) = s["groupClause"].as_array() {
        if !group.is_empty() {
            let items: Vec<Node> = group.iter().map(node_value_to_node).collect();
            clauses.push(Clause {
                keyword: "GROUP BY".into(),
                body: Some(Box::new(Node::List {
                    items,
                    separator: None,
                })),
            });
        }
    }

    if !s["havingClause"].is_null() {
        clauses.push(Clause {
            keyword: "HAVING".into(),
            body: Some(Box::new(node_value_to_node(&s["havingClause"]))),
        });
    }

    // WINDOW clause: WINDOW name AS (definition), ...
    if let Some(windows) = s["windowClause"].as_array() {
        if !windows.is_empty() {
            let items: Vec<Node> = windows
                .iter()
                .map(|w| {
                    let wd = w.get("WindowDef").unwrap_or(w);
                    let name = wd["name"].as_str().unwrap_or("");
                    let mut wd_clauses: Vec<Clause> = Vec::new();
                    if let Some(partition) = wd["partitionClause"].as_array() {
                        if !partition.is_empty() {
                            let parts: Vec<Node> =
                                partition.iter().map(node_value_to_node).collect();
                            wd_clauses.push(Clause {
                                keyword: "PARTITION BY".into(),
                                body: Some(Box::new(Node::List {
                                    items: parts,
                                    separator: None,
                                })),
                            });
                        }
                    }
                    if let Some(order) = wd["orderClause"].as_array() {
                        if !order.is_empty() {
                            let ords: Vec<Node> = order.iter().map(node_value_to_node).collect();
                            wd_clauses.push(Clause {
                                keyword: "ORDER BY".into(),
                                body: Some(Box::new(Node::List {
                                    items: ords,
                                    separator: None,
                                })),
                            });
                        }
                    }
                    if let Some(frame_clause) = window_frame_clause(wd) {
                        wd_clauses.push(frame_clause);
                    }
                    let body = if wd_clauses.is_empty() {
                        Node::Text {
                            value: String::new(),
                        }
                    } else {
                        Node::Clauses { items: wd_clauses }
                    };
                    Node::Concat {
                        items: vec![
                            ident_node(name),
                            Node::Text {
                                value: " AS ".into(),
                            },
                            Node::Wrap {
                                keyword: None,
                                open: "(".into(),
                                content: Box::new(body),
                                close: ")".into(),
                            },
                        ],
                    }
                })
                .collect();
            clauses.push(Clause {
                keyword: "WINDOW".into(),
                body: Some(Box::new(Node::List {
                    items,
                    separator: None,
                })),
            });
        }
    }

    if let Some(sort) = s["sortClause"].as_array() {
        if !sort.is_empty() {
            let items: Vec<Node> = sort.iter().map(node_value_to_node).collect();
            clauses.push(Clause {
                keyword: "ORDER BY".into(),
                body: Some(Box::new(Node::List {
                    items,
                    separator: None,
                })),
            });
        }
    }

    if !s["limitCount"].is_null() {
        if s["limitOption"].as_str() == Some("LIMIT_OPTION_WITH_TIES") {
            clauses.push(Clause {
                keyword: "FETCH FIRST".into(),
                body: Some(Box::new(Node::Concat {
                    items: vec![
                        node_value_to_node(&s["limitCount"]),
                        Node::Text { value: " ".into() },
                        Node::Keyword {
                            value: "ROWS WITH TIES".into(),
                        },
                    ],
                })),
            });
        } else {
            clauses.push(Clause {
                keyword: "LIMIT".into(),
                body: Some(Box::new(node_value_to_node(&s["limitCount"]))),
            });
        }
    }

    if !s["limitOffset"].is_null() {
        clauses.push(Clause {
            keyword: "OFFSET".into(),
            body: Some(Box::new(node_value_to_node(&s["limitOffset"]))),
        });
    }

    // FOR UPDATE / FOR SHARE locking clauses.
    if let Some(locking) = s["lockingClause"].as_array() {
        for lc in locking {
            let (base_kw, wait_kw, rel_nodes) = locking_clause_parts(lc);
            let (keyword, body) = if let Some(rels) = rel_nodes {
                let mut body_items: Vec<Node> = vec![Node::List {
                    items: rels,
                    separator: None,
                }];
                if !wait_kw.is_empty() {
                    body_items.push(Node::Text {
                        value: wait_kw.into(),
                    });
                }
                (
                    format!("{base_kw} OF"),
                    Some(Box::new(Node::Concat { items: body_items })),
                )
            } else {
                (
                    if wait_kw.is_empty() {
                        base_kw.to_string()
                    } else {
                        format!("{base_kw}{wait_kw}")
                    },
                    None,
                )
            };
            clauses.push(Clause { keyword, body });
        }
    }

    Node::Clauses { items: clauses }
}

fn set_target_to_node(rt: &Value) -> Node {
    // For SET clauses (UPDATE SET, ON CONFLICT DO UPDATE SET):
    // renders as "colname = value" instead of "value AS colname".
    let val = if rt["val"].is_null() {
        Node::Text {
            value: String::new(),
        }
    } else {
        node_value_to_node(&rt["val"])
    };
    let name = rt["name"].as_str().unwrap_or("");
    if name.is_empty() {
        val
    } else {
        // Include any indirection (array subscripts) on the column name.
        let mut name_items = vec![ident_node(name)];
        append_indirection(&mut name_items, &rt["indirection"]);
        let name_node = if name_items.len() == 1 {
            name_items.remove(0)
        } else {
            Node::Concat { items: name_items }
        };
        Node::Concat {
            items: vec![
                name_node,
                Node::Text {
                    value: " = ".into(),
                },
                val,
            ],
        }
    }
}

fn res_target_to_node(rt: &Value) -> Node {
    let val = if rt["val"].is_null() {
        Node::Text {
            value: String::new(),
        }
    } else {
        node_value_to_node(&rt["val"])
    };
    let name = rt["name"].as_str().unwrap_or("");
    if name.is_empty() {
        val
    } else {
        // Append any indirection (array subscripts like [1:2]) to the column name.
        let mut name_items = vec![ident_node(name)];
        append_indirection(&mut name_items, &rt["indirection"]);
        let name_node = if name_items.len() == 1 {
            name_items.remove(0)
        } else {
            Node::Concat { items: name_items }
        };
        Node::Concat {
            items: vec![
                val,
                Node::Text {
                    value: " AS ".into(),
                },
                name_node,
            ],
        }
    }
}

/// Append array subscript nodes for indirection (A_Indices) entries.
fn append_indirection(items: &mut Vec<Node>, indirection: &Value) {
    let arr = indirection.as_array();
    if arr.is_none() {
        return;
    }
    for elem in arr.unwrap() {
        if let Some(ai) = elem.get("A_Indices") {
            let lidx = ai.get("lidx");
            let uidx = ai.get("uidx");
            let is_slice = ai["is_slice"].as_bool().unwrap_or(false);
            let open = "[".to_string();
            let close = "]".to_string();
            let content: Node = match (lidx, uidx) {
                (Some(l), Some(u)) if is_slice => Node::Concat {
                    items: vec![
                        node_value_to_node(l),
                        Node::Text { value: ":".into() },
                        node_value_to_node(u),
                    ],
                },
                (Some(l), None) if is_slice => Node::Concat {
                    items: vec![node_value_to_node(l), Node::Text { value: ":".into() }],
                },
                (None, Some(u)) if is_slice => Node::Concat {
                    items: vec![Node::Text { value: ":".into() }, node_value_to_node(u)],
                },
                (None, None) if is_slice => Node::Text { value: ":".into() },
                (Some(_l), Some(u)) => node_value_to_node(u),
                (None, Some(u)) => node_value_to_node(u),
                _ => continue,
            };
            items.push(Node::Wrap {
                keyword: None,
                open,
                content: Box::new(content),
                close,
            });
        } else if let Some(field) = elem.get("String") {
            // Field selection: .fieldname
            let name = field["sval"]
                .as_str()
                .or_else(|| field["str"].as_str())
                .unwrap_or("");
            items.push(Node::Text {
                value: format!(".{name}"),
            });
        }
    }
}

fn column_ref_to_node(cr: &Value) -> Node {
    let empty = vec![];
    let fields = cr["fields"].as_array().unwrap_or(&empty);
    let parts: Vec<String> = fields
        .iter()
        .map(|n| {
            if let Some(obj) = n.as_object() {
                if let Some(s) = obj.get("String") {
                    string_val(s).to_string()
                } else if obj.contains_key("A_Star") {
                    "*".to_string()
                } else {
                    String::new()
                }
            } else {
                String::new()
            }
        })
        .collect();
    let refs: Vec<&str> = parts.iter().map(String::as_str).collect();
    qualified_ident_node(&refs)
}

fn index_elem_to_node(ie: &Value) -> Node {
    // Simple column name
    if let Some(name) = ie["name"].as_str().filter(|s| !s.is_empty()) {
        let mut items = vec![ident_node(name)];
        match ie["ordering"].as_str().unwrap_or("SORTBY_DEFAULT") {
            "SORTBY_ASC" => {
                items.push(Node::Text {
                    value: " ASC".into(),
                });
            }
            "SORTBY_DESC" => {
                items.push(Node::Text {
                    value: " DESC".into(),
                });
            }
            _ => {}
        }
        match ie["nulls_ordering"]
            .as_str()
            .unwrap_or("SORTBY_NULLS_DEFAULT")
        {
            "SORTBY_NULLS_FIRST" => {
                items.push(Node::Text {
                    value: " NULLS FIRST".into(),
                });
            }
            "SORTBY_NULLS_LAST" => {
                items.push(Node::Text {
                    value: " NULLS LAST".into(),
                });
            }
            _ => {}
        }
        if items.len() == 1 {
            return items.remove(0);
        }
        return Node::Concat { items };
    }
    // Expression-based index element: e.g., (expr COLLATE coll) or function
    if let Some(expr) = ie.get("expr").filter(|e| !e.is_null()) {
        let mut items = vec![node_value_to_node(expr)];
        if let Some(coll) = ie["collation"].as_array().filter(|a| !a.is_empty()) {
            let coll_parts: Vec<&str> = coll
                .iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect();
            items.push(Node::Text {
                value: " COLLATE ".into(),
            });
            items.push(qualified_ident_node(&coll_parts));
        }
        if let Some(opclass) = ie["opclass"].as_array().filter(|a| !a.is_empty()) {
            let oc_parts: Vec<&str> = opclass
                .iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect();
            items.push(Node::Text { value: " ".into() });
            items.push(qualified_ident_node(&oc_parts));
        }
        // Ordering / nulls ordering
        match ie["ordering"].as_str().unwrap_or("SORTBY_DEFAULT") {
            "SORTBY_ASC" => {
                items.push(Node::Text {
                    value: " ASC".into(),
                });
            }
            "SORTBY_DESC" => {
                items.push(Node::Text {
                    value: " DESC".into(),
                });
            }
            _ => {}
        }
        match ie["nulls_ordering"]
            .as_str()
            .unwrap_or("SORTBY_NULLS_DEFAULT")
        {
            "SORTBY_NULLS_FIRST" => {
                items.push(Node::Text {
                    value: " NULLS FIRST".into(),
                });
            }
            "SORTBY_NULLS_LAST" => {
                items.push(Node::Text {
                    value: " NULLS LAST".into(),
                });
            }
            _ => {}
        }
        return Node::Concat { items };
    }
    Node::Text {
        value: String::new(),
    }
}

fn partition_elem_to_node(pe: &Value) -> Node {
    if let Some(name) = pe["name"].as_str().filter(|s| !s.is_empty()) {
        let mut items = vec![ident_node(name)];
        // COLLATE clause on partition element.
        if let Some(coll_vals) = pe["collation"].as_array().filter(|a| !a.is_empty()) {
            let coll_parts: Vec<&str> = coll_vals
                .iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect();
            if !coll_parts.is_empty() {
                items.push(Node::Text { value: " ".into() });
                items.push(Node::Keyword { value: "COLLATE".into() });
                items.push(Node::Text { value: " ".into() });
                items.push(ident_node(&coll_parts.join(".")));
            }
        }
        // Operator class for the partition column.
        if let Some(opclass) = pe["opclass"].as_array().filter(|a| !a.is_empty()) {
            let opc_parts: Vec<&str> = opclass
                .iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect();
            if !opc_parts.is_empty() {
                items.push(Node::Text { value: " ".into() });
                items.push(ident_node(&opc_parts.join(".")));
            }
        }
        if items.len() == 1 {
            items.remove(0)
        } else {
            Node::Concat { items }
        }
    } else if let Some(expr) = pe.get("expr").filter(|e| !e.is_null()) {
        let mut content = node_value_to_node(expr);
        // COLLATE clause on expression-based partition elements.
        if let Some(coll_vals) = pe["collation"].as_array().filter(|a| !a.is_empty()) {
            let coll_parts: Vec<&str> = coll_vals
                .iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect();
            if !coll_parts.is_empty() {
                content = Node::Concat {
                    items: vec![
                        content,
                        Node::Text { value: " ".into() },
                        Node::Keyword {
                            value: "COLLATE".into(),
                        },
                        Node::Text { value: " ".into() },
                        ident_node(&coll_parts.join(".")),
                    ],
                };
            }
        }
        Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(content),
            close: ")".into(),
        }
    } else {
        Node::Text {
            value: String::new(),
        }
    }
}

fn a_const_to_node(c: &Value) -> Node {
    if c["isnull"].as_bool().unwrap_or(false) {
        return Node::Literal {
            value: "NULL".into(),
        };
    }
    // Handle both flat {"ival": N} and nested {"ival": {"ival": N}} formats.
    if let Some(ival) = c.get("ival") {
        let n = ival.as_i64().or_else(|| ival["ival"].as_i64()).unwrap_or(0);
        return Node::Literal {
            value: n.to_string(),
        };
    }
    if let Some(fval) = c.get("fval") {
        let f = fval
            .as_str()
            .or_else(|| fval["fval"].as_str())
            .unwrap_or("0");
        return Node::Literal {
            value: f.to_string(),
        };
    }
    if let Some(bval) = c.get("boolval") {
        let b = bval
            .as_bool()
            .or_else(|| bval["boolval"].as_bool())
            .unwrap_or(false);
        return Node::Literal {
            value: if b { "TRUE".into() } else { "FALSE".into() },
        };
    }
    if let Some(sval) = c.get("sval") {
        let s = sval.as_str().unwrap_or_else(|| string_val(sval));
        return Node::Literal {
            value: format!("'{}'", s.replace('\'', "''")),
        };
    }
    // Bit string and hex string constants: bsval contains prefix + value, e.g. "b101" or "x1F".
    // Render as B'101' (binary) or x'1F' (hex).
    if let Some(bsval) = c.get("bsval") {
        let s = bsval
            .as_str()
            .or_else(|| bsval["bsval"].as_str())
            .unwrap_or("");
        let rendered = if let Some(bits) = s.strip_prefix(['b', 'B']) {
            format!("B'{bits}'")
        } else if let Some(hex) = s.strip_prefix(['x', 'X']) {
            format!("x'{hex}'")
        } else {
            s.to_string()
        };
        return Node::Literal { value: rendered };
    }
    Node::Literal {
        value: "NULL".into(),
    }
}

fn range_function_to_node(rf: &Value) -> Node {
    // RangeFunction represents a function call in FROM, e.g. generate_series(1,5) s
    // functions: array of List items (for ROWS FROM syntax)
    let funcs: Vec<Node> = rf["functions"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .filter_map(|item| {
                    // Each item is {"List": {"items": [...]}} — extract the FuncCall from items
                    let items = item["List"]["items"].as_array()?;
                    let nodes: Vec<Node> = items
                        .iter()
                        .filter_map(|f| {
                            if f.as_object().is_some_and(|o| o.is_empty()) {
                                None // skip empty separator objects
                            } else {
                                Some(node_value_to_node(f))
                            }
                        })
                        .collect();
                    if nodes.is_empty() {
                        None
                    } else {
                        Some(Node::List {
                            items: nodes,
                            separator: None,
                        })
                    }
                })
                .collect()
        })
        .unwrap_or_default();

    let is_rowsfrom = rf["is_rowsfrom"].as_bool().unwrap_or(false);
    let funcs_node = if is_rowsfrom && funcs.len() > 1 {
        Node::Wrap {
            keyword: Some("ROWS FROM".into()),
            open: "(".into(),
            content: Box::new(Node::List {
                items: funcs,
                separator: None,
            }),
            close: ")".into(),
        }
    } else if funcs.len() == 1 {
        funcs.into_iter().next().unwrap()
    } else {
        Node::Text {
            value: String::new(),
        }
    };

    // Alias
    let alias_name = rf["alias"]["aliasname"]
        .as_str()
        .or_else(|| rf["alias"]["Alias"]["aliasname"].as_str())
        .unwrap_or("");
    let colnames: Vec<&str> = rf["alias"]["colnames"]
        .as_array()
        .or_else(|| rf["alias"]["Alias"]["colnames"].as_array())
        .map(|arr| {
            arr.iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect()
        })
        .unwrap_or_default();

    // Build column definition list: (colname type, colname type, ...)
    let coldeflist_items: Vec<Node> = rf["coldeflist"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .map(|cd| {
                    let coldef = cd.get("ColumnDef").unwrap_or(cd);
                    let name = coldef["colname"].as_str().unwrap_or("");
                    let type_name = type_name_str(&coldef["typeName"]);
                    Node::Concat {
                        items: vec![
                            ident_node(name),
                            Node::Text { value: " ".into() },
                            Node::Text { value: type_name },
                        ],
                    }
                })
                .collect()
        })
        .unwrap_or_default();

    let is_lateral = rf["lateral"].as_bool().unwrap_or(false);
    let funcs_node = if is_lateral {
        Node::Concat {
            items: vec![
                Node::Keyword {
                    value: "LATERAL".into(),
                },
                Node::Text { value: " ".into() },
                funcs_node,
            ],
        }
    } else {
        funcs_node
    };

    let ordinality = rf["ordinality"].as_bool().unwrap_or(false);

    if alias_name.is_empty() && colnames.is_empty() && coldeflist_items.is_empty() && !ordinality {
        return funcs_node;
    }

    let mut items = vec![funcs_node];
    if ordinality {
        items.push(Node::Text { value: " ".into() });
        items.push(Node::Keyword {
            value: "WITH ORDINALITY".into(),
        });
    }
    if !alias_name.is_empty() {
        items.push(Node::Text { value: " ".into() });
        items.push(Node::Keyword { value: "AS".into() });
        items.push(Node::Text { value: " ".into() });
        items.push(ident_node(alias_name));
    }
    if !coldeflist_items.is_empty() {
        items.push(Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(Node::List {
                items: coldeflist_items,
                separator: None,
            }),
            close: ")".into(),
        });
    } else if !colnames.is_empty() {
        let col_nodes: Vec<Node> = colnames.iter().map(|&c| ident_node(c)).collect();
        items.push(Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(Node::List {
                items: col_nodes,
                separator: None,
            }),
            close: ")".into(),
        });
    }
    Node::Concat { items }
}

fn range_subselect_to_node(rs: &Value) -> Node {
    // RangeSubselect is a subquery in FROM: (SELECT ...) alias
    let subquery = rs["subquery"].as_object().map(|o| {
        let v = serde_json::Value::Object(o.clone());
        node_value_to_node(&v)
    });
    let subquery = subquery.unwrap_or_else(|| Node::Text {
        value: String::new(),
    });
    let alias_name = rs["alias"]["aliasname"]
        .as_str()
        .or_else(|| rs["alias"]["Alias"]["aliasname"].as_str())
        .unwrap_or("");
    let colnames: Vec<&str> = rs["alias"]["colnames"]
        .as_array()
        .or_else(|| rs["alias"]["Alias"]["colnames"].as_array())
        .map(|arr| {
            arr.iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect()
        })
        .unwrap_or_default();

    let is_lateral = rs["lateral"].as_bool().unwrap_or(false);
    let mut items = Vec::new();
    if is_lateral {
        items.push(Node::Keyword {
            value: "LATERAL".into(),
        });
        items.push(Node::Text { value: " ".into() });
    }
    items.push(Node::Wrap {
        keyword: None,
        open: "(".into(),
        content: Box::new(subquery),
        close: ")".into(),
    });
    if !alias_name.is_empty() {
        items.push(Node::Text { value: " ".into() });
        items.push(ident_node(alias_name));
    }
    if !colnames.is_empty() {
        let col_nodes: Vec<Node> = colnames.iter().map(|&c| ident_node(c)).collect();
        items.push(Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(Node::List {
                items: col_nodes,
                separator: None,
            }),
            close: ")".into(),
        });
    }
    Node::Concat { items }
}

fn join_expr_to_node(je: &Value) -> Node {
    let larg = node_value_to_node(&je["larg"]);
    let rarg = node_value_to_node(&je["rarg"]);
    let is_natural = je["isNatural"].as_bool().unwrap_or(false);
    let jointype_str = je["jointype"].as_str().unwrap_or("JOIN_INNER");

    let join_kw = match jointype_str {
        "JOIN_INNER" if is_natural => "NATURAL JOIN",
        "JOIN_INNER" => {
            if !je["quals"].is_null() {
                "JOIN"
            } else {
                "CROSS JOIN"
            }
        }
        "JOIN_LEFT" => {
            if is_natural {
                "NATURAL LEFT JOIN"
            } else {
                "LEFT JOIN"
            }
        }
        "JOIN_RIGHT" => {
            if is_natural {
                "NATURAL RIGHT JOIN"
            } else {
                "RIGHT JOIN"
            }
        }
        "JOIN_FULL" => {
            if is_natural {
                "NATURAL FULL JOIN"
            } else {
                "FULL JOIN"
            }
        }
        "JOIN_ANTI" => "ANTI JOIN",
        "JOIN_SEMI" => "SEMI JOIN",
        _ => "JOIN",
    };

    let mut items = vec![larg, Node::Text { value: " ".into() }];
    items.push(Node::Keyword {
        value: join_kw.into(),
    });
    items.push(Node::Text { value: " ".into() });
    items.push(rarg);

    // ON clause
    if !je["quals"].is_null() {
        items.push(Node::Text {
            value: " ON ".into(),
        });
        items.push(node_value_to_node(&je["quals"]));
    }

    // USING clause
    if let Some(using) = je["usingClause"].as_array() {
        if !using.is_empty() {
            items.push(Node::Text {
                value: " USING ".into(),
            });
            items.push(Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(Node::List {
                    items: using.iter().map(node_value_to_node).collect(),
                    separator: None,
                }),
                close: ")".into(),
            });
        }
    }

    // Alias and column names (for subquery-in-FROM wrappers like (... JOIN ...) alias(cols))
    let alias_name = je["alias"]["aliasname"]
        .as_str()
        .or_else(|| je["alias"]["Alias"]["aliasname"].as_str())
        .unwrap_or("");
    let colnames: Vec<&str> = je["alias"]["colnames"]
        .as_array()
        .or_else(|| je["alias"]["Alias"]["colnames"].as_array())
        .map(|arr| {
            arr.iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect()
        })
        .unwrap_or_default();

    let has_alias = !alias_name.is_empty() || !colnames.is_empty();
    let join_node = if has_alias {
        Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(Node::Concat { items }),
            close: ")".into(),
        }
    } else {
        Node::Concat { items }
    };

    if has_alias {
        let mut alias_items = vec![join_node];
        if !alias_name.is_empty() {
            alias_items.push(Node::Text { value: " ".into() });
            alias_items.push(Node::Keyword { value: "AS".into() });
            alias_items.push(Node::Text { value: " ".into() });
            alias_items.push(ident_node(alias_name));
        }
        if !colnames.is_empty() {
            let col_nodes: Vec<Node> = colnames.iter().map(|&c| ident_node(c)).collect();
            alias_items.push(Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(Node::List {
                    items: col_nodes,
                    separator: None,
                }),
                close: ")".into(),
            });
        }
        Node::Concat { items: alias_items }
    } else {
        join_node
    }
}

fn range_var_to_node(rv: &Value) -> Node {
    let catalogname = rv["catalogname"].as_str().unwrap_or("");
    let schemaname = rv["schemaname"].as_str().unwrap_or("");
    let relname = rv["relname"].as_str().unwrap_or("");
    let mut parts: Vec<&str> = Vec::new();
    if !catalogname.is_empty() {
        parts.push(catalogname);
    }
    if !schemaname.is_empty() {
        parts.push(schemaname);
    }
    if !relname.is_empty() {
        parts.push(relname);
    }
    let ident = qualified_ident_node(&parts);

    // inh absent in JSON means ONLY (no inheritance); inh: true means normal.
    let only = rv.get("inh").is_none();
    let base = if only {
        Node::Concat {
            items: vec![
                Node::Keyword {
                    value: "ONLY".into(),
                },
                Node::Text { value: " ".into() },
                ident,
            ],
        }
    } else {
        ident
    };

    // Alias can be {"Alias": {"aliasname": "t"}} or {"aliasname": "t"}.
    let alias_val = rv.get("alias").filter(|a| !a.is_null());
    let alias_name = alias_val
        .and_then(|a| {
            a["Alias"]["aliasname"]
                .as_str()
                .or_else(|| a["aliasname"].as_str())
        })
        .unwrap_or("");

    // Extract colnames from alias, e.g., t1(a, b, c).
    let colnames: Vec<&str> = alias_val
        .and_then(|a| {
            a["Alias"]["colnames"]
                .as_array()
                .or_else(|| a["colnames"].as_array())
        })
        .map(|arr| {
            arr.iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect()
        })
        .unwrap_or_default();

    if alias_name.is_empty() {
        base
    } else {
        let mut items = vec![
            base,
            Node::Text {
                value: " AS ".into(),
            },
            ident_node(alias_name),
        ];
        if !colnames.is_empty() {
            let cols: Vec<Node> = colnames.iter().map(|&c| ident_node(c)).collect();
            items.push(Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(Node::List {
                    items: cols,
                    separator: None,
                }),
                close: ")".into(),
            });
        }
        Node::Concat { items }
    }
}

fn null_test_to_node(nt: &Value) -> Node {
    let nulltesttype = nt["nulltesttype"].as_str().unwrap_or("");
    let kw = match nulltesttype {
        "IS_NULL" => "IS NULL",
        "IS_NOT_NULL" => "IS NOT NULL",
        "IS_TRUE" => "IS TRUE",
        "IS_NOT_TRUE" => "IS NOT TRUE",
        "IS_FALSE" => "IS FALSE",
        "IS_NOT_FALSE" => "IS NOT FALSE",
        "IS_UNKNOWN" => "IS UNKNOWN",
        "IS_NOT_UNKNOWN" => "IS NOT UNKNOWN",
        _ => "IS NULL",
    };
    let arg = wrap_infix_in_parens(node_value_to_node(&nt["arg"]));
    Node::Concat {
        items: vec![
            arg,
            Node::Text {
                value: format!(" {kw}"),
            },
        ],
    }
}

fn a_expr_to_node(e: &Value) -> Node {
    let kind = e["kind"].as_str().unwrap_or("AEXPR_OP");

    let op_raw = e["name"]
        .as_array()
        .and_then(|arr| arr.first())
        .and_then(|n| {
            n["String"]["sval"]
                .as_str()
                .or_else(|| n["String"]["str"].as_str())
        })
        .unwrap_or("?")
        .to_string();

    let has_lexpr = !e["lexpr"].is_null();
    let has_rexpr = !e["rexpr"].is_null();

    // NULLIF(a, b)
    if kind == "AEXPR_NULLIF" && has_lexpr && has_rexpr {
        return Node::Wrap {
            keyword: Some("NULLIF".into()),
            open: "(".into(),
            content: Box::new(Node::List {
                items: vec![
                    node_value_to_node(&e["lexpr"]),
                    node_value_to_node(&e["rexpr"]),
                ],
                separator: None,
            }),
            close: ")".into(),
        };
    }

    // LIKE / NOT LIKE / ILIKE / NOT ILIKE:
    // pg_query uses AEXPR_LIKE / AEXPR_ILIKE when the keyword form is used,
    // and AEXPR_OP with the internal operator name (~~, !~~, etc.) when the
    // symbolic form is used. Translate to keywords for the keyword forms;
    // preserve the raw operator for AEXPR_OP.
    if (kind == "AEXPR_LIKE" || kind == "AEXPR_ILIKE") && has_lexpr && has_rexpr {
        let kw = match (kind, op_raw.as_str()) {
            ("AEXPR_LIKE", "~~") => "LIKE",
            ("AEXPR_LIKE", _) => "NOT LIKE",
            ("AEXPR_ILIKE", "~~*") => "ILIKE",
            ("AEXPR_ILIKE", _) => "NOT ILIKE",
            _ => unreachable!(),
        };
        return Node::Infix {
            op: kw.to_string(),
            items: vec![
                wrap_infix_in_parens(node_value_to_node(&e["lexpr"])),
                node_value_to_node(&e["rexpr"]),
            ],
        };
    }

    // SIMILAR TO / NOT SIMILAR TO: rexpr is pg_catalog.similar_to_escape(pattern[, escape]).
    // When ESCAPE is specified, similar_to_escape has two args: (pattern, escape).
    if kind == "AEXPR_SIMILAR" {
        let similar_kw = if op_raw == "~" {
            "SIMILAR TO"
        } else {
            "NOT SIMILAR TO"
        };
        if has_lexpr && has_rexpr {
            let args = e["rexpr"]["FuncCall"]["args"].as_array();
            let pattern = args
                .and_then(|a| a.first())
                .map(node_value_to_node)
                .unwrap_or(node_value_to_node(&e["rexpr"]));
            let rhs = if let Some(escape_node) = args.and_then(|a| a.get(1)) {
                Node::Concat {
                    items: vec![
                        pattern,
                        Node::Text {
                            value: " ESCAPE ".into(),
                        },
                        node_value_to_node(escape_node),
                    ],
                }
            } else {
                pattern
            };
            return Node::Infix {
                op: similar_kw.to_string(),
                items: vec![wrap_infix_in_parens(node_value_to_node(&e["lexpr"])), rhs],
            };
        }
    }

    // lexpr op ANY(rexpr) / lexpr op ALL(rexpr)
    if kind == "AEXPR_OP_ANY" || kind == "AEXPR_OP_ALL" {
        let quantifier = if kind == "AEXPR_OP_ANY" { "ANY" } else { "ALL" };
        if has_lexpr && has_rexpr {
            let rhs = Node::Wrap {
                keyword: Some(quantifier.into()),
                open: "(".into(),
                content: Box::new(node_value_to_node(&e["rexpr"])),
                close: ")".into(),
            };
            return Node::Infix {
                op: op_raw,
                items: vec![wrap_infix_in_parens(node_value_to_node(&e["lexpr"])), rhs],
            };
        }
    }

    // AEXPR_IN: lexpr IN (rexpr_list) or lexpr NOT IN (rexpr_list)
    if kind == "AEXPR_IN" {
        let in_kw = if op_raw == "<>" { "NOT IN" } else { "IN" };
        if has_lexpr && has_rexpr {
            let rexpr_items = e["rexpr"]
                .as_array()
                .map(|arr| arr.iter().map(node_value_to_node).collect::<Vec<_>>())
                .or_else(|| {
                    e["rexpr"]["List"]["items"]
                        .as_array()
                        .map(|arr| arr.iter().map(node_value_to_node).collect::<Vec<_>>())
                })
                .unwrap_or_default();
            let list = Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(Node::List {
                    items: rexpr_items,
                    separator: None,
                }),
                close: ")".into(),
            };
            return Node::Infix {
                op: in_kw.to_string(),
                items: vec![wrap_infix_in_parens(node_value_to_node(&e["lexpr"])), list],
            };
        }
    }

    // AEXPR_DISTINCT: lexpr IS DISTINCT FROM rexpr
    // AEXPR_NOT_DISTINCT: lexpr IS NOT DISTINCT FROM rexpr
    if kind == "AEXPR_DISTINCT" || kind == "AEXPR_NOT_DISTINCT" {
        let kw = if kind == "AEXPR_DISTINCT" {
            "IS DISTINCT FROM"
        } else {
            "IS NOT DISTINCT FROM"
        };
        if has_lexpr && has_rexpr {
            return Node::Infix {
                op: kw.to_string(),
                items: vec![
                    wrap_infix_in_parens(node_value_to_node(&e["lexpr"])),
                    wrap_infix_in_parens(node_value_to_node(&e["rexpr"])),
                ],
            };
        }
    }

    // BETWEEN variants
    if matches!(
        kind,
        "AEXPR_BETWEEN" | "AEXPR_NOT_BETWEEN" | "AEXPR_BETWEEN_SYM" | "AEXPR_NOT_BETWEEN_SYM"
    ) {
        let kw = match kind {
            "AEXPR_BETWEEN" => "BETWEEN",
            "AEXPR_NOT_BETWEEN" => "NOT BETWEEN",
            "AEXPR_BETWEEN_SYM" => "BETWEEN SYMMETRIC",
            "AEXPR_NOT_BETWEEN_SYM" => "NOT BETWEEN SYMMETRIC",
            _ => "BETWEEN",
        };
        if has_lexpr && has_rexpr {
            let bounds = e["rexpr"]
                .as_array()
                .map(|arr| arr.iter().map(node_value_to_node).collect::<Vec<_>>())
                .or_else(|| {
                    e["rexpr"]["List"]["items"]
                        .as_array()
                        .map(|arr| arr.iter().map(node_value_to_node).collect::<Vec<_>>())
                })
                .unwrap_or_default();
            if bounds.len() == 2 {
                let range = Node::Infix {
                    op: "AND".into(),
                    items: bounds,
                };
                return Node::Infix {
                    op: kw.to_string(),
                    items: vec![wrap_infix_in_parens(node_value_to_node(&e["lexpr"])), range],
                };
            }
        }
    }

    // Check if a value is a prefix-unary A_Expr (only has rexpr, no lexpr) that would
    // need parens when used as a side of an infix operator: ~ 1 + 1 means (~1) + 1,
    // but pg_query parses it as ~(1 + 1).
    let is_prefix_unary = |v: &Value| -> bool {
        v.get("A_Expr")
            .map(|ae| ae["lexpr"].is_null() && !ae["rexpr"].is_null())
            .unwrap_or(false)
    };

    match (has_lexpr, has_rexpr) {
        (true, true) => {
            let wrap_side = |side: &Value| -> Node {
                let node = node_value_to_node(side);
                if is_prefix_unary(side) {
                    Node::Wrap {
                        keyword: None,
                        open: "(".into(),
                        content: Box::new(node),
                        close: ")".into(),
                    }
                } else {
                    wrap_infix_in_parens(node)
                }
            };
            Node::Infix {
                op: op_raw,
                items: vec![wrap_side(&e["lexpr"]), wrap_side(&e["rexpr"])],
            }
        }
        (true, false) => Node::Concat {
            items: vec![
                node_value_to_node(&e["lexpr"]),
                Node::Text { value: " ".into() },
                Node::Text { value: op_raw },
            ],
        },
        (false, true) => {
            // Space after unary operator prevents `--rhs` from being parsed as a SQL comment.
            let rhs = node_value_to_node(&e["rexpr"]);
            // Wrap argument in parens if it's a complex expression that would bind
            // differently without them, e.g. ~(1 & 0) vs ~ 1 & 0.
            let needs_parens = e["rexpr"]
                .get("BoolExpr")
                .or_else(|| e["rexpr"].get("A_Expr"))
                .or_else(|| e["rexpr"].get("SubLink"))
                .is_some();
            let rhs = if needs_parens {
                Node::Wrap {
                    keyword: None,
                    open: "(".into(),
                    content: Box::new(rhs),
                    close: ")".into(),
                }
            } else {
                rhs
            };
            Node::Concat {
                items: vec![
                    Node::Text {
                        value: format!("{op_raw}"),
                    },
                    rhs,
                ],
            }
        }
        (false, false) => Node::Text { value: op_raw },
    }
}

fn a_const_value_str(v: &Value) -> Option<String> {
    let ac = v.get("A_Const")?;
    if ac["isnull"].as_bool().unwrap_or(false) {
        return Some("NULL".into());
    }
    if let Some(ival) = ac.get("ival") {
        let n = ival.as_i64().or_else(|| ival["ival"].as_i64())?;
        return Some(n.to_string());
    }
    if let Some(sval) = ac.get("sval") {
        return sval
            .as_str()
            .or_else(|| sval["sval"].as_str())
            .map(|s| format!("'{s}'"));
    }
    if let Some(bval) = ac.get("boolval") {
        let b = bval["boolval"].as_bool().unwrap_or(false);
        return Some(if b { "true".into() } else { "false".into() });
    }
    None
}

fn wrap_infix_in_parens(node: Node) -> Node {
    if matches!(node, Node::Infix { .. }) {
        Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(node),
            close: ")".into(),
        }
    } else {
        node
    }
}

fn bool_expr_to_node(b: &Value) -> Node {
    let raw_args = b["args"].as_array().map(|a| a.as_slice()).unwrap_or(&[]);

    // boolop may be a string enum name or an integer value.
    let boolop_str = b["boolop"].as_str().unwrap_or("");
    let boolop_num = b["boolop"].as_u64();

    let is_and = boolop_str == "AND_EXPR" || boolop_num == Some(0);
    let is_or = boolop_str == "OR_EXPR" || boolop_num == Some(1);
    let is_not = boolop_str == "NOT_EXPR" || boolop_num == Some(2);

    if is_and {
        // Wrap any BoolExpr sub-expressions in parens to preserve grouping from the
        // original input — pg_query represents explicit parens as nested BoolExpr nodes.
        let args: Vec<Node> = raw_args
            .iter()
            .map(|arg| {
                let node = node_value_to_node(arg);
                if arg.get("BoolExpr").is_some() {
                    Node::Wrap {
                        keyword: None,
                        open: "(".into(),
                        content: Box::new(node),
                        close: ")".into(),
                    }
                } else {
                    node
                }
            })
            .collect();
        Node::Infix {
            op: "AND".into(),
            items: args,
        }
    } else if is_or {
        // Wrap any BoolExpr sub-expressions in parens to preserve grouping.
        let args: Vec<Node> = raw_args
            .iter()
            .map(|arg| {
                let node = node_value_to_node(arg);
                if arg.get("BoolExpr").is_some() {
                    Node::Wrap {
                        keyword: None,
                        open: "(".into(),
                        content: Box::new(node),
                        close: ")".into(),
                    }
                } else {
                    node
                }
            })
            .collect();
        Node::Infix {
            op: "OR".into(),
            items: args,
        }
    } else if is_not {
        let args: Vec<Node> = raw_args.iter().map(node_value_to_node).collect();
        let inner = args.into_iter().next().unwrap_or(Node::Text {
            value: String::new(),
        });
        // NOT has higher precedence than AND/OR, and interacts with comparisons
        // (NOT a = b means (NOT a) = b, not NOT (a = b)). Wrap anything that
        // could cause a precedence change: BoolExpr, A_Expr, SubLink, TypeCast,
        // NullTest, or any operator expression.
        let needs_parens = raw_args
            .first()
            .map(|a| {
                a.get("BoolExpr").is_some()
                    || a.get("A_Expr").is_some()
                    || a.get("SubLink").is_some()
                    || a.get("NullTest").is_some()
            })
            .unwrap_or(false);
        let inner = if needs_parens {
            Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(inner),
                close: ")".into(),
            }
        } else {
            inner
        };
        Node::Concat {
            items: vec![
                Node::Keyword {
                    value: "NOT".into(),
                },
                Node::Text { value: " ".into() },
                inner,
            ],
        }
    } else {
        Node::Unformatted {
            value: format!("{b}"),
        }
    }
}

fn coalesce_expr_to_node(ce: &Value) -> Node {
    let args: Vec<Node> = ce["args"]
        .as_array()
        .map(|arr| arr.iter().map(node_value_to_node).collect())
        .unwrap_or_default();
    let items: Vec<Node> = args.into_iter().fold(Vec::new(), |mut acc, a| {
        if !acc.is_empty() {
            acc.push(Node::Text { value: ", ".into() });
        }
        acc.push(a);
        acc
    });
    Node::Wrap {
        keyword: Some("COALESCE".into()),
        open: "(".into(),
        content: Box::new(Node::Concat { items }),
        close: ")".into(),
    }
}

fn collate_clause_to_node(cc: &Value) -> Node {
    let arg_node = node_value_to_node(&cc["arg"]);
    // Wrap compound expressions in parens so COLLATE binds correctly.
    // Without parens, `x || 'c' COLLATE "POSIX"` parses as
    // `x || ('c' COLLATE "POSIX")` because COLLATE has higher precedence than ||.
    let arg = if needs_collate_parens(&cc["arg"]) {
        Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(arg_node),
            close: ")".into(),
        }
    } else {
        arg_node
    };
    let coll_names: Vec<&str> = cc["collname"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect()
        })
        .unwrap_or_default();
    let coll_ident = qualified_ident_node(&coll_names);
    Node::Concat {
        items: vec![
            arg,
            Node::Text {
                value: " COLLATE ".into(),
            },
            coll_ident,
        ],
    }
}

fn needs_collate_parens(arg: &Value) -> bool {
    // These nodes are "atomic" — they don't need parens around them.
    // Everything else (A_Expr, SubLink, etc.) needs parens to ensure
    // COLLATE binds to the whole expression.
    let key = arg
        .as_object()
        .and_then(|o| o.keys().next())
        .map(String::as_str);
    !matches!(
        key,
        Some("A_Const")
            | Some("ColumnRef")
            | Some("FuncCall")
            | Some("CaseExpr")
            | Some("CoalesceExpr")
            | Some("RowExpr")
            | Some("CollateClause")
    )
}

fn sql_value_function_to_node(svf: &Value) -> Node {
    let op = svf["op"].as_str().unwrap_or("");
    let is_n_variant = matches!(
        op,
        "SVFOP_CURRENT_TIME_N"
            | "SVFOP_CURRENT_TIMESTAMP_N"
            | "SVFOP_LOCALTIME_N"
            | "SVFOP_LOCALTIMESTAMP_N"
    );
    let kw = match op {
        "SVFOP_CURRENT_DATE" => "CURRENT_DATE",
        "SVFOP_CURRENT_TIME" | "SVFOP_CURRENT_TIME_N" => "CURRENT_TIME",
        "SVFOP_CURRENT_TIMESTAMP" | "SVFOP_CURRENT_TIMESTAMP_N" => "CURRENT_TIMESTAMP",
        "SVFOP_LOCALTIME" | "SVFOP_LOCALTIME_N" => "LOCALTIME",
        "SVFOP_LOCALTIMESTAMP" | "SVFOP_LOCALTIMESTAMP_N" => "LOCALTIMESTAMP",
        "SVFOP_CURRENT_ROLE" => "CURRENT_ROLE",
        "SVFOP_CURRENT_USER" => "CURRENT_USER",
        "SVFOP_USER" => "USER",
        "SVFOP_SESSION_USER" => "SESSION_USER",
        "SVFOP_CURRENT_CATALOG" => "CURRENT_CATALOG",
        "SVFOP_CURRENT_SCHEMA" => "CURRENT_SCHEMA",
        _ => op,
    };
    if is_n_variant {
        let typmod = svf["typmod"].as_i64().unwrap_or(-1);
        if typmod >= 0 {
            return Node::Concat {
                items: vec![
                    Node::Keyword {
                        value: kw.to_string(),
                    },
                    Node::Wrap {
                        keyword: None,
                        open: "(".into(),
                        content: Box::new(Node::Literal {
                            value: typmod.to_string(),
                        }),
                        close: ")".into(),
                    },
                ],
            };
        }
    }
    Node::Keyword {
        value: kw.to_string(),
    }
}

fn array_expr_to_node(ae: &Value) -> Node {
    let items: Vec<Node> = ae["elements"]
        .as_array()
        .map(|arr| arr.iter().map(node_value_to_node).collect())
        .unwrap_or_default();
    let mut concat_items: Vec<Node> = Vec::new();
    for (i, item) in items.into_iter().enumerate() {
        if i > 0 {
            concat_items.push(Node::Text { value: ", ".into() });
        }
        concat_items.push(item);
    }
    Node::Wrap {
        keyword: Some("ARRAY".into()),
        open: "[".into(),
        content: Box::new(Node::Concat {
            items: concat_items,
        }),
        close: "]".into(),
    }
}

fn row_expr_to_node(re: &Value) -> Node {
    let items: Vec<Node> = re["args"]
        .as_array()
        .map(|arr| arr.iter().map(node_value_to_node).collect())
        .unwrap_or_default();
    let mut concat_items: Vec<Node> = Vec::new();
    for (i, item) in items.into_iter().enumerate() {
        if i > 0 {
            concat_items.push(Node::Text { value: ", ".into() });
        }
        concat_items.push(item);
    }
    let is_explicit = re["row_format"].as_str() == Some("COERCE_EXPLICIT_CALL");
    Node::Wrap {
        keyword: if is_explicit {
            Some("ROW".into())
        } else {
            None
        },
        open: "(".into(),
        content: Box::new(Node::Concat {
            items: concat_items,
        }),
        close: ")".into(),
    }
}

fn case_expr_to_node(ce: &Value) -> Node {
    let when_clauses: Vec<Node> = ce["args"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .map(|w| {
                    let cw = w.get("CaseWhen").unwrap_or(w);
                    case_when_to_node(cw)
                })
                .collect()
        })
        .unwrap_or_default();

    let mut items: Vec<Node> = Vec::new();

    // CASE expr WHEN ... form vs CASE WHEN ... form
    if !ce["arg"].is_null() {
        items.push(Node::Keyword {
            value: "CASE".into(),
        });
        items.push(Node::Text { value: " ".into() });
        items.push(node_value_to_node(&ce["arg"]));
        for cw in when_clauses {
            items.push(Node::Line);
            items.push(cw);
        }
    } else {
        items.push(Node::Keyword {
            value: "CASE".into(),
        });
        for cw in when_clauses {
            items.push(Node::Line);
            items.push(cw);
        }
    }

    if !ce["defresult"].is_null() {
        items.push(Node::Line);
        items.push(Node::Clauses {
            items: vec![Clause {
                keyword: "ELSE".into(),
                body: Some(Box::new(node_value_to_node(&ce["defresult"]))),
            }],
        });
    }

    items.push(Node::Line);
    items.push(Node::Keyword {
        value: "END".into(),
    });

    Node::Group {
        content: Box::new(Node::Concat { items }),
    }
}

fn case_when_to_node(cw: &Value) -> Node {
    Node::Clauses {
        items: vec![
            Clause {
                keyword: "WHEN".into(),
                body: Some(Box::new(node_value_to_node(&cw["expr"]))),
            },
            Clause {
                keyword: "THEN".into(),
                body: Some(Box::new(node_value_to_node(&cw["result"]))),
            },
        ],
    }
}

fn func_call_to_node(f: &Value) -> Node {
    let all_name_parts: Vec<&str> = f["funcname"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect()
        })
        .unwrap_or_default();

    let agg_star = f["agg_star"].as_bool().unwrap_or(false);
    let agg_distinct = f["agg_distinct"].as_bool().unwrap_or(false);

    let agg_within_group = f["agg_within_group"].as_bool().unwrap_or(false);
    let agg_order = f["agg_order"].as_array();

    let content = if agg_star {
        Node::Text { value: "*".into() }
    } else if let Some(args) = f["args"].as_array() {
        if args.is_empty() {
            Node::Text {
                value: String::new(),
            }
        } else {
            let mut arg_nodes: Vec<Node> = args.iter().map(node_value_to_node).collect();
            let is_variadic = f["func_variadic"].as_bool().unwrap_or(false);
            if is_variadic {
                if let Some(last) = arg_nodes.pop() {
                    arg_nodes.push(Node::Concat {
                        items: vec![
                            Node::Keyword {
                                value: "VARIADIC".into(),
                            },
                            Node::Text { value: " ".into() },
                            last,
                        ],
                    });
                }
            }
            let list = Node::List {
                items: arg_nodes,
                separator: None,
            };
            let with_distinct = if agg_distinct {
                Node::Concat {
                    items: vec![
                        Node::Keyword {
                            value: "DISTINCT".into(),
                        },
                        Node::Text { value: " ".into() },
                        list,
                    ],
                }
            } else {
                list
            };
            // Aggregate ORDER BY inside parens (not WITHIN GROUP): func(args ORDER BY ...)
            if !agg_within_group {
                if let Some(order) = agg_order.filter(|o| !o.is_empty()) {
                    let order_items: Vec<Node> = order.iter().map(node_value_to_node).collect();
                    Node::Concat {
                        items: vec![
                            with_distinct,
                            Node::Text { value: " ".into() },
                            Node::Keyword {
                                value: "ORDER BY".into(),
                            },
                            Node::Text { value: " ".into() },
                            Node::List {
                                items: order_items,
                                separator: None,
                            },
                        ],
                    }
                } else {
                    with_distinct
                }
            } else {
                with_distinct
            }
        }
    } else {
        Node::Text {
            value: String::new(),
        }
    };

    let name_node = if all_name_parts.len() == 1 {
        ident_node(all_name_parts[0])
    } else {
        qualified_ident_node(&all_name_parts)
    };
    let base = Node::Concat {
        items: vec![
            name_node,
            Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(content),
                close: ")".into(),
            },
        ],
    };

    // WITHIN GROUP (ORDER BY ...) — ordered-set aggregates like percentile_cont.
    let base = if agg_within_group {
        if let Some(order) = agg_order.filter(|o| !o.is_empty()) {
            let order_items: Vec<Node> = order.iter().map(node_value_to_node).collect();
            let within_clause = Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(Node::Clauses {
                    items: vec![Clause {
                        keyword: "ORDER BY".into(),
                        body: Some(Box::new(Node::List {
                            items: order_items,
                            separator: None,
                        })),
                    }],
                }),
                close: ")".into(),
            };
            Node::Concat {
                items: vec![
                    base,
                    Node::Text {
                        value: " WITHIN GROUP ".into(),
                    },
                    within_clause,
                ],
            }
        } else {
            base
        }
    } else {
        base
    };

    // FILTER (WHERE ...) clause.
    let base = if !f["agg_filter"].is_null() {
        let filter_expr = node_value_to_node(&f["agg_filter"]);
        Node::Concat {
            items: vec![
                base,
                Node::Text {
                    value: " FILTER ".into(),
                },
                Node::Wrap {
                    keyword: None,
                    open: "(".into(),
                    content: Box::new(Node::Concat {
                        items: vec![
                            Node::Keyword {
                                value: "WHERE".into(),
                            },
                            Node::Text { value: " ".into() },
                            filter_expr,
                        ],
                    }),
                    close: ")".into(),
                },
            ],
        }
    } else {
        base
    };

    // Handle OVER clause for window functions.
    if f["over"].is_null() || f.get("over").is_none() {
        return base;
    }

    let over = &f["over"];
    let mut over_clauses: Vec<Clause> = Vec::new();

    if let Some(partition) = over["partitionClause"].as_array() {
        if !partition.is_empty() {
            let items: Vec<Node> = partition.iter().map(node_value_to_node).collect();
            over_clauses.push(Clause {
                keyword: "PARTITION BY".into(),
                body: Some(Box::new(Node::List {
                    items,
                    separator: None,
                })),
            });
        }
    }

    if let Some(order) = over["orderClause"].as_array() {
        if !order.is_empty() {
            let items: Vec<Node> = order.iter().map(node_value_to_node).collect();
            over_clauses.push(Clause {
                keyword: "ORDER BY".into(),
                body: Some(Box::new(Node::List {
                    items,
                    separator: None,
                })),
            });
        }
    }

    if let Some(frame_clause) = window_frame_clause(over) {
        over_clauses.push(frame_clause);
    }

    let over_name = over["refname"]
        .as_str()
        .or_else(|| over["name"].as_str())
        .unwrap_or("");

    // Named window reference without any clauses.
    // pg_query uses `name` for bare OVER name, `refname` for OVER (name).
    // Preserve the distinction so the round-trip AST matches.
    let is_parenthesized_ref = over["refname"].as_str().is_some();
    if !over_name.is_empty() && over_clauses.is_empty() {
        if is_parenthesized_ref {
            return Node::Concat {
                items: vec![
                    base,
                    Node::Text {
                        value: " OVER ".into(),
                    },
                    Node::Wrap {
                        keyword: None,
                        open: "(".into(),
                        content: Box::new(ident_node(over_name)),
                        close: ")".into(),
                    },
                ],
            };
        }
        return Node::Concat {
            items: vec![
                base,
                Node::Text {
                    value: " OVER ".into(),
                },
                ident_node(over_name),
            ],
        };
    }

    // Build the content inside OVER (...) — may include a named window reference
    // before the clauses, e.g. OVER (w RANGE BETWEEN ...).
    let over_content: Node = if over_clauses.is_empty() {
        Node::Text {
            value: String::new(),
        }
    } else if !over_name.is_empty() {
        // Named window with frame/order/partition override: OVER (w RANGE ...)
        let mut items = vec![ident_node(over_name)];
        items.push(Node::Text { value: " ".into() });
        items.push(Node::Clauses {
            items: over_clauses,
        });
        Node::Concat { items }
    } else {
        Node::Clauses {
            items: over_clauses,
        }
    };

    Node::Concat {
        items: vec![
            base,
            Node::Text {
                value: " OVER ".into(),
            },
            Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(over_content),
                close: ")".into(),
            },
        ],
    }
}

// Frame option bit flags matching PostgreSQL's gram.y FRAMEOPTION_* constants.
const FRAMEOPTION_NONDEFAULT: u64 = 0x00001;
const FRAMEOPTION_RANGE: u64 = 0x00002;
const FRAMEOPTION_ROWS: u64 = 0x00004;
const FRAMEOPTION_GROUPS: u64 = 0x00008;
const FRAMEOPTION_BETWEEN: u64 = 0x00010;
const FRAMEOPTION_START_UNBOUNDED_PRECEDING: u64 = 0x00020;
const FRAMEOPTION_END_UNBOUNDED_PRECEDING: u64 = 0x00040;
const FRAMEOPTION_START_UNBOUNDED_FOLLOWING: u64 = 0x00080;
const FRAMEOPTION_END_UNBOUNDED_FOLLOWING: u64 = 0x00100;
const FRAMEOPTION_START_CURRENT_ROW: u64 = 0x00200;
const FRAMEOPTION_END_CURRENT_ROW: u64 = 0x00400;
const FRAMEOPTION_START_OFFSET_PRECEDING: u64 = 0x00800;
const FRAMEOPTION_END_OFFSET_PRECEDING: u64 = 0x01000;
const FRAMEOPTION_START_OFFSET_FOLLOWING: u64 = 0x02000;
const FRAMEOPTION_END_OFFSET_FOLLOWING: u64 = 0x04000;
const FRAMEOPTION_EXCLUDE_CURRENT_ROW: u64 = 0x08000;
const FRAMEOPTION_EXCLUDE_GROUP: u64 = 0x10000;
const FRAMEOPTION_EXCLUDE_TIES: u64 = 0x20000;

fn frame_bound_str(
    opts: u64,
    preceding_flag: u64,
    following_flag: u64,
    current_row_flag: u64,
    offset_preceding_flag: u64,
    offset_following_flag: u64,
    offset: &Value,
) -> Node {
    if opts & preceding_flag != 0 {
        Node::Keyword {
            value: "UNBOUNDED PRECEDING".into(),
        }
    } else if opts & following_flag != 0 {
        Node::Keyword {
            value: "UNBOUNDED FOLLOWING".into(),
        }
    } else if opts & current_row_flag != 0 {
        Node::Keyword {
            value: "CURRENT ROW".into(),
        }
    } else if opts & offset_preceding_flag != 0 {
        Node::Concat {
            items: vec![
                node_value_to_node(offset),
                Node::Text { value: " ".into() },
                Node::Keyword {
                    value: "PRECEDING".into(),
                },
            ],
        }
    } else if opts & offset_following_flag != 0 {
        Node::Concat {
            items: vec![
                node_value_to_node(offset),
                Node::Text { value: " ".into() },
                Node::Keyword {
                    value: "FOLLOWING".into(),
                },
            ],
        }
    } else {
        Node::Keyword {
            value: "CURRENT ROW".into(),
        }
    }
}

fn window_frame_clause(over: &Value) -> Option<Clause> {
    let opts = over["frameOptions"].as_u64()?;
    if opts & FRAMEOPTION_NONDEFAULT == 0 {
        return None;
    }

    let frame_type = if opts & FRAMEOPTION_ROWS != 0 {
        "ROWS"
    } else if opts & FRAMEOPTION_GROUPS != 0 {
        "GROUPS"
    } else if opts & FRAMEOPTION_RANGE != 0 {
        "RANGE"
    } else {
        "RANGE"
    };

    let start_offset = &over["startOffset"];
    let end_offset = &over["endOffset"];

    let start_bound = frame_bound_str(
        opts,
        FRAMEOPTION_START_UNBOUNDED_PRECEDING,
        FRAMEOPTION_START_UNBOUNDED_FOLLOWING,
        FRAMEOPTION_START_CURRENT_ROW,
        FRAMEOPTION_START_OFFSET_PRECEDING,
        FRAMEOPTION_START_OFFSET_FOLLOWING,
        start_offset,
    );

    let exclude = if opts & FRAMEOPTION_EXCLUDE_CURRENT_ROW != 0 {
        Some("EXCLUDE CURRENT ROW")
    } else if opts & FRAMEOPTION_EXCLUDE_GROUP != 0 {
        Some("EXCLUDE GROUP")
    } else if opts & FRAMEOPTION_EXCLUDE_TIES != 0 {
        Some("EXCLUDE TIES")
    } else {
        None
    };

    if opts & FRAMEOPTION_BETWEEN != 0 {
        let end_bound = frame_bound_str(
            opts,
            FRAMEOPTION_END_UNBOUNDED_PRECEDING,
            FRAMEOPTION_END_UNBOUNDED_FOLLOWING,
            FRAMEOPTION_END_CURRENT_ROW,
            FRAMEOPTION_END_OFFSET_PRECEDING,
            FRAMEOPTION_END_OFFSET_FOLLOWING,
            end_offset,
        );
        let mut between_items = vec![
            start_bound,
            Node::Text { value: " ".into() },
            Node::Keyword {
                value: "AND".into(),
            },
            Node::Text { value: " ".into() },
            end_bound,
        ];
        if let Some(ex) = exclude {
            between_items.push(Node::Text {
                value: format!(" {ex}"),
            });
        }
        Some(Clause {
            keyword: format!("{frame_type} BETWEEN"),
            body: Some(Box::new(Node::Concat {
                items: between_items,
            })),
        })
    } else {
        let body = if let Some(ex) = exclude {
            Node::Concat {
                items: vec![
                    start_bound,
                    Node::Text {
                        value: format!(" {ex}"),
                    },
                ],
            }
        } else {
            start_bound
        };
        Some(Clause {
            keyword: frame_type.into(),
            body: Some(Box::new(body)),
        })
    }
}

fn sort_by_to_node(sb: &Value) -> Node {
    let inner = if sb["node"].is_null() {
        Node::Text {
            value: String::new(),
        }
    } else {
        node_value_to_node(&sb["node"])
    };

    // The JSON field name mirrors the C struct field: sortby_dir (snake_case).
    // String values follow the C enum names: SORTBY_ASC, SORTBY_DESC, SORTBY_USING.
    let dir_str = sb["sortby_dir"].as_str().unwrap_or("");
    let dir_num = sb["sortby_dir"].as_u64().unwrap_or(0);

    // NULLS FIRST / NULLS LAST
    let nulls_str = sb["sortby_nulls"].as_str().unwrap_or("");
    let nulls_num = sb["sortby_nulls"].as_u64().unwrap_or(0);
    let nulls_suffix = if nulls_str == "SORTBY_NULLS_FIRST" || nulls_num == 1 {
        " NULLS FIRST"
    } else if nulls_str == "SORTBY_NULLS_LAST" || nulls_num == 2 {
        " NULLS LAST"
    } else {
        ""
    };

    // SORTBY_USING: ORDER BY expr USING operator
    let use_op = sb["useOp"]
        .as_array()
        .and_then(|arr| arr.first())
        .and_then(|n| {
            n["String"]["sval"]
                .as_str()
                .or_else(|| n["String"]["str"].as_str())
        })
        .unwrap_or("");

    if dir_str == "SORTBY_USING" {
        let mut items = vec![inner];
        if !use_op.is_empty() {
            items.push(Node::Text {
                value: format!(" USING {use_op}"),
            });
        }
        if !nulls_suffix.is_empty() {
            items.push(Node::Text {
                value: nulls_suffix.to_string(),
            });
        }
        return Node::Concat { items };
    }

    if dir_str == "SORTBY_ASC" || dir_num == 1 {
        Node::Concat {
            items: vec![
                inner,
                Node::Text {
                    value: format!(" ASC{nulls_suffix}"),
                },
            ],
        }
    } else if dir_str == "SORTBY_DESC" || dir_num == 2 {
        Node::Concat {
            items: vec![
                inner,
                Node::Text {
                    value: format!(" DESC{nulls_suffix}"),
                },
            ],
        }
    } else if !nulls_suffix.is_empty() {
        Node::Concat {
            items: vec![
                inner,
                Node::Text {
                    value: nulls_suffix.to_string(),
                },
            ],
        }
    } else {
        inner
    }
}

fn type_name_str(tn: &Value) -> String {
    // In pg_query JSON, the TypeName fields are inline under "typeName" (no extra wrapper).
    // We preserve all name parts (including "pg_catalog") to ensure round-trip fidelity:
    // NULL::int parses to names=["pg_catalog","int4"]; stripping pg_catalog gives "int4" which
    // re-parses as names=["int4"] (no prefix) — a different AST.
    let name_parts: Vec<&str> = tn["names"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect()
        })
        .unwrap_or_default();

    let base_type = if name_parts.is_empty() {
        "unknown".to_string()
    } else {
        name_parts
            .iter()
            .map(|&part| {
                if pg_needs_quoting(part) {
                    format!("\"{part}\"")
                } else {
                    part.to_string()
                }
            })
            .collect::<Vec<_>>()
            .join(".")
    };

    // Typmods: numeric(10,3), varchar(255), char(1), etc.
    let typmods = tn["typmods"].as_array();
    let with_mods = if let Some(mods) = typmods.filter(|m| !m.is_empty()) {
        let mod_strs: Vec<String> = mods
            .iter()
            .map(|m| {
                if let Some(ac) = m.get("A_Const") {
                    if let Some(ival) = ac.get("ival") {
                        let n = ival.as_i64().or_else(|| ival["ival"].as_i64()).unwrap_or(0);
                        return n.to_string();
                    }
                    if let Some(fval) = ac.get("fval") {
                        let f = fval
                            .as_str()
                            .or_else(|| fval["fval"].as_str())
                            .unwrap_or("0");
                        return f.to_string();
                    }
                    if let Some(sval) = ac.get("sval") {
                        let s = sval
                            .as_str()
                            .unwrap_or_else(|| sval["sval"].as_str().unwrap_or(""));
                        return format!("'{s}'");
                    }
                }
                // Integer node directly (e.g., interval precision stored as Integer)
                if let Some(iv) = m.get("Integer") {
                    let n = iv["ival"].as_i64().unwrap_or(0);
                    return n.to_string();
                }
                // ColumnRef in typmods, e.g. geography(geometry, 4004)
                if let Some(colref) = m.get("ColumnRef") {
                    let fields: Vec<&str> = colref["fields"]
                        .as_array()
                        .map(|arr| {
                            arr.iter()
                                .filter_map(|f| {
                                    f["String"]["sval"]
                                        .as_str()
                                        .or_else(|| f["String"]["str"].as_str())
                                })
                                .collect()
                        })
                        .unwrap_or_default();
                    return fields.join(".");
                }
                format!("{m}")
            })
            .collect();
        format!("{base_type}({})", mod_strs.join(", "))
    } else {
        base_type.to_string()
    };

    // Array bounds: integer[], text[][], etc.
    // Non-empty Integer entries are subscripts (e.g., text[][1][1]) — not array dims.
    let dims = tn["arrayBounds"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .filter(|b| b["Integer"].as_object().is_some_and(|o| o.is_empty()))
                .count()
        })
        .unwrap_or(0);
    let array_suffix = "[]".repeat(dims);

    format!("{with_mods}{array_suffix}")
}

fn type_cast_to_node(tc: &Value) -> Node {
    let arg_node = node_value_to_node(&tc["arg"]);
    // Negative literal values (e.g. "-2147483648" stored as fval) must be wrapped in
    // parentheses so the typecast applies to the value, not to the cast result.
    // Without parens, "-2147483648::int4" parses as "-(2147483648::int4)".
    let arg = match &arg_node {
        Node::Literal { value } if value.starts_with('-') => Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(arg_node),
            close: ")".into(),
        },
        Node::Infix { .. } => Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(arg_node),
            close: ")".into(),
        },
        _ => arg_node,
    };
    let type_str = type_name_str(&tc["typeName"]);

    // Non-empty arrayBounds are subscripts, e.g. text[][1][1] — the [1][1] are indices.
    let subscripts: Vec<Node> = tc["typeName"]["arrayBounds"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .filter_map(|b| {
                    let iv = b["Integer"]["ival"].as_i64()?;
                    Some(Node::Wrap {
                        keyword: None,
                        open: "[".into(),
                        content: Box::new(Node::Text {
                            value: iv.to_string(),
                        }),
                        close: "]".into(),
                    })
                })
                .collect()
        })
        .unwrap_or_default();

    let mut items = vec![
        arg,
        Node::Text {
            value: format!("::{type_str}"),
        },
    ];
    items.extend(subscripts);
    Node::Concat { items }
}

fn sub_link_to_node(sl: &Value) -> Node {
    let sub_link_type = sl["subLinkType"].as_str().unwrap_or("EXPR_SUBLINK");
    let inner = node_value_to_node(&sl["subselect"]);
    let wrapped = Node::Wrap {
        keyword: None,
        open: "(".into(),
        content: Box::new(inner),
        close: ")".into(),
    };
    match sub_link_type {
        "EXISTS_SUBLINK" => Node::Concat {
            items: vec![
                Node::Keyword {
                    value: "EXISTS".into(),
                },
                wrapped,
            ],
        },
        "ARRAY_SUBLINK" => Node::Wrap {
            keyword: Some("ARRAY".into()),
            open: "(".into(),
            content: Box::new(node_value_to_node(&sl["subselect"])),
            close: ")".into(),
        },
        "ANY_SUBLINK" => {
            // When operName is present the user wrote "op ANY(subquery)".
            // When absent the user wrote "IN (subquery)" — pg_query represents both
            // as ANY_SUBLINK. Preserve whichever form was used.
            let op_name = sl["operName"]
                .as_array()
                .and_then(|arr| arr.first())
                .and_then(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                });
            if sl["testexpr"].is_null() {
                wrapped
            } else {
                let test = node_value_to_node(&sl["testexpr"]);
                if let Some(op) = op_name {
                    let rhs = Node::Wrap {
                        keyword: Some("ANY".into()),
                        open: "(".into(),
                        content: Box::new(node_value_to_node(&sl["subselect"])),
                        close: ")".into(),
                    };
                    Node::Infix {
                        op: op.to_string(),
                        items: vec![test, rhs],
                    }
                } else {
                    Node::Infix {
                        op: "IN".into(),
                        items: vec![test, wrapped],
                    }
                }
            }
        }
        "ALL_SUBLINK" => {
            let op_name = sl["operName"]
                .as_array()
                .and_then(|arr| arr.first())
                .and_then(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .unwrap_or("=");
            if sl["testexpr"].is_null() {
                wrapped
            } else {
                let test = node_value_to_node(&sl["testexpr"]);
                let rhs = Node::Wrap {
                    keyword: Some("ALL".into()),
                    open: "(".into(),
                    content: Box::new(node_value_to_node(&sl["subselect"])),
                    close: ")".into(),
                };
                Node::Infix {
                    op: op_name.to_string(),
                    items: vec![test, rhs],
                }
            }
        }
        _ => wrapped,
    }
}

pub fn json_ast_equal(json1: &str, json2: &str) -> bool {
    let Ok(v1) = serde_json::from_str::<Value>(json1) else {
        return false;
    };
    let Ok(v2) = serde_json::from_str::<Value>(json2) else {
        return false;
    };
    normalize_ast(strip_locations(v1)) == normalize_ast(strip_locations(v2))
}

fn strip_locations(v: Value) -> Value {
    match v {
        Value::Object(map) => Value::Object(
            map.into_iter()
                .filter(|(k, _)| {
                    !matches!(
                        k.as_str(),
                        // Parser-location metadata
                        "location" | "stmt_location" | "stmt_len"
                        // How a function call was written (COERCE_EXPLICIT_CALL vs COERCE_SQL_SYNTAX);
                        // the formatter normalizes all calls to explicit syntax which is semantically
                        // equivalent but has a different funcformat in the re-parsed AST.
                        | "funcformat"
                    )
                })
                .map(|(k, v)| (k, strip_locations(v)))
                .collect(),
        ),
        Value::Array(arr) => Value::Array(arr.into_iter().map(strip_locations).collect()),
        other => other,
    }
}

/// Normalize PartitionElem: when collation is on the PartitionElem directly,
/// wrap the expression in a CollateClause to match the re-parsed structure.
fn normalize_ast(v: Value) -> Value {
    match v {
        Value::Object(mut map) => {
            // Normalize PartitionElem: move collation into expr as CollateClause.
            if map.contains_key("PartitionElem") {
                if let Some(pe) = map.get_mut("PartitionElem")
                    .and_then(|v| v.as_object_mut())
                {
                    if let Some(coll_vals) = pe.get("collation").filter(|c| !c.is_null()) {
                        let coll_val = normalize_ast(coll_vals.clone());
                        let expr = pe
                            .get("expr")
                            .filter(|e| !e.is_null())
                            .cloned()
                            .unwrap_or(Value::Null);
                        let expr_norm = normalize_ast(expr);
                        let mut collate = serde_json::Map::new();
                        collate.insert("arg".to_string(), expr_norm);
                        collate.insert(
                            "collname".to_string(),
                            coll_val,
                        );
                        let mut inner = serde_json::Map::new();
                        inner.insert(
                            "CollateClause".to_string(),
                            Value::Object(collate),
                        );
                        pe.insert("expr".to_string(), Value::Object(inner));
                        pe.remove("collation");
                    }
                }
            }
            Value::Object(
                map.into_iter()
                    .map(|(k, v)| (k, normalize_ast(v)))
                    .collect(),
            )
        }
        Value::Array(arr) => Value::Array(arr.into_iter().map(normalize_ast).collect()),
        other => other,
    }
}
