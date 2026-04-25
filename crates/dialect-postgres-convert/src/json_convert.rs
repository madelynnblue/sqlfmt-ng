use serde_json::Value;
use sqlfmt_core::SqlfmtError;
use sqlfmt_ir::{Clause, Node};

fn pg_needs_quoting(s: &str) -> bool {
    if s.is_empty() {
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

    let mut clauses = Vec::new();
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
            Some(Node::Clauses { items }) => clauses.extend(items),
            Some(_) => {
                return Err(SqlfmtError::Parse(
                    "unexpected non-clauses top-level node".into(),
                ));
            }
            None => {
                return Err(SqlfmtError::Parse(format!(
                    "unsupported statement type: {stmt}"
                )));
            }
        }
    }

    Ok(Node::Clauses { items: clauses })
}

fn stmt_to_node(stmt: &Value) -> Option<Node> {
    let obj = stmt.as_object()?;
    obj.get("SelectStmt").map(select_stmt_to_node)
}

fn node_value_to_node(v: &Value) -> Node {
    let Some(obj) = v.as_object() else {
        return Node::Text {
            value: v.to_string(),
        };
    };

    if let Some(inner) = obj.get("SelectStmt") {
        select_stmt_to_node(inner)
    } else if let Some(inner) = obj.get("ResTarget") {
        res_target_to_node(inner)
    } else if let Some(inner) = obj.get("ColumnRef") {
        column_ref_to_node(inner)
    } else if let Some(inner) = obj.get("A_Const") {
        a_const_to_node(inner)
    } else if let Some(inner) = obj.get("RangeVar") {
        range_var_to_node(inner)
    } else if let Some(inner) = obj.get("A_Expr") {
        a_expr_to_node(inner)
    } else if let Some(inner) = obj.get("BoolExpr") {
        bool_expr_to_node(inner)
    } else if let Some(inner) = obj.get("FuncCall") {
        func_call_to_node(inner)
    } else if let Some(inner) = obj.get("SortBy") {
        sort_by_to_node(inner)
    } else if let Some(inner) = obj.get("TypeCast") {
        type_cast_to_node(inner)
    } else if let Some(inner) = obj.get("SubLink") {
        sub_link_to_node(inner)
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
        Node::Text {
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

fn select_stmt_to_node(s: &Value) -> Node {
    let mut clauses: Vec<Clause> = Vec::new();

    // DISTINCT / DISTINCT ON
    let distinct = s["distinctClause"].as_array();
    let select_keyword = if let Some(dc) = distinct {
        if dc.is_empty() {
            // distinctClause: [] means SELECT DISTINCT
            "SELECT DISTINCT".to_string()
        } else {
            // distinctClause: [{...}, ...] means SELECT DISTINCT ON (exprs)
            let items: Vec<Node> = dc.iter().map(node_value_to_node).collect();
            let on_list = Node::Wrap {
                keyword: None,
                open: "(".into(),
                content: Box::new(Node::List {
                    items,
                    separator: None,
                }),
                close: ")".into(),
            };
            // We'll handle DISTINCT ON as a keyword for now; the body will follow
            // by constructing the clause manually below.
            let _ = on_list; // handled inline in clause push
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
        clauses.push(Clause {
            keyword: "LIMIT".into(),
            body: Some(Box::new(node_value_to_node(&s["limitCount"]))),
        });
    }

    if !s["limitOffset"].is_null() {
        clauses.push(Clause {
            keyword: "OFFSET".into(),
            body: Some(Box::new(node_value_to_node(&s["limitOffset"]))),
        });
    }

    Node::Clauses { items: clauses }
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
        Node::Concat {
            items: vec![
                val,
                Node::Text {
                    value: " AS ".into(),
                },
                Node::Identifier {
                    value: name.to_string(),
                    quote: None,
                },
            ],
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
                Node::Keyword { value: "ONLY".into() },
                Node::Text { value: " ".into() },
                ident,
            ],
        }
    } else {
        ident
    };

    // Alias can be {"Alias": {"aliasname": "t"}} or {"aliasname": "t"}.
    let alias_name = rv
        .get("alias")
        .filter(|a| !a.is_null())
        .and_then(|a| {
            a["Alias"]["aliasname"]
                .as_str()
                .or_else(|| a["aliasname"].as_str())
        })
        .unwrap_or("");

    if alias_name.is_empty() {
        base
    } else {
        Node::Concat {
            items: vec![
                base,
                Node::Text {
                    value: " AS ".into(),
                },
                ident_node(alias_name),
            ],
        }
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

    // Map internal pg operator names to SQL keywords for LIKE/ILIKE variants.
    let op = match op_raw.as_str() {
        "~~" => "LIKE".to_string(),
        "!~~" => "NOT LIKE".to_string(),
        "~~*" => "ILIKE".to_string(),
        "!~~*" => "NOT ILIKE".to_string(),
        other => other.to_string(),
    };

    let has_lexpr = !e["lexpr"].is_null();
    let has_rexpr = !e["rexpr"].is_null();

    // AEXPR_IN: lexpr IN (rexpr_list) or lexpr NOT IN (rexpr_list)
    if kind == "AEXPR_IN" {
        let in_kw = if op_raw == "<>" { "NOT IN" } else { "IN" };
        if has_lexpr && has_rexpr {
            let rexpr_items = e["rexpr"]
                .as_array()
                .map(|arr| arr.iter().map(node_value_to_node).collect::<Vec<_>>())
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
                items: vec![node_value_to_node(&e["lexpr"]), list],
            };
        }
    }

    // BETWEEN variants
    if matches!(
        kind,
        "AEXPR_BETWEEN"
            | "AEXPR_NOT_BETWEEN"
            | "AEXPR_BETWEEN_SYM"
            | "AEXPR_NOT_BETWEEN_SYM"
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
                .unwrap_or_default();
            if bounds.len() == 2 {
                let range = Node::Infix {
                    op: "AND".into(),
                    items: bounds,
                };
                return Node::Infix {
                    op: kw.to_string(),
                    items: vec![node_value_to_node(&e["lexpr"]), range],
                };
            }
        }
    }

    match (has_lexpr, has_rexpr) {
        (true, true) => Node::Infix {
            op,
            items: vec![
                node_value_to_node(&e["lexpr"]),
                node_value_to_node(&e["rexpr"]),
            ],
        },
        (true, false) => Node::Concat {
            items: vec![
                node_value_to_node(&e["lexpr"]),
                Node::Text { value: " ".into() },
                Node::Text { value: op },
            ],
        },
        (false, true) => Node::Concat {
            items: vec![
                Node::Text { value: op },
                Node::Text { value: " ".into() },
                node_value_to_node(&e["rexpr"]),
            ],
        },
        (false, false) => Node::Text { value: op },
    }
}

fn bool_expr_to_node(b: &Value) -> Node {
    let args: Vec<Node> = b["args"]
        .as_array()
        .map(|arr| arr.iter().map(node_value_to_node).collect())
        .unwrap_or_default();

    // boolop may be a string enum name or an integer value.
    let boolop_str = b["boolop"].as_str().unwrap_or("");
    let boolop_num = b["boolop"].as_u64();

    let is_and = boolop_str == "AND_EXPR" || boolop_num == Some(0);
    let is_or = boolop_str == "OR_EXPR" || boolop_num == Some(1);
    let is_not = boolop_str == "NOT_EXPR" || boolop_num == Some(2);

    if is_and {
        Node::Infix {
            op: "AND".into(),
            items: args,
        }
    } else if is_or {
        Node::Infix {
            op: "OR".into(),
            items: args,
        }
    } else if is_not {
        let inner = args.into_iter().next().unwrap_or(Node::Text {
            value: String::new(),
        });
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
        Node::Text {
            value: format!("{b}"),
        }
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

    // Strip pg_catalog schema prefix — it's an implementation detail that doesn't
    // affect semantics and causes case-mismatch round-trip failures.
    let name_parts: Vec<&str> = if all_name_parts.first() == Some(&"pg_catalog") {
        all_name_parts[1..].to_vec()
    } else {
        all_name_parts
    };
    let name = name_parts.join(".");

    // C struct field is agg_star (snake_case).
    let agg_star = f["agg_star"].as_bool().unwrap_or(false);
    let agg_distinct = f["agg_distinct"].as_bool().unwrap_or(false);

    let content = if agg_star {
        Node::Text { value: "*".into() }
    } else if let Some(args) = f["args"].as_array() {
        if args.is_empty() {
            Node::Text {
                value: String::new(),
            }
        } else {
            let arg_nodes: Vec<Node> = args.iter().map(node_value_to_node).collect();
            let list = Node::List {
                items: arg_nodes,
                separator: None,
            };
            if agg_distinct {
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
            }
        }
    } else {
        Node::Text {
            value: String::new(),
        }
    };

    let base = Node::Wrap {
        keyword: Some(name),
        open: "(".into(),
        content: Box::new(content),
        close: ")".into(),
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

    let over_content: Node = if over_clauses.is_empty() {
        Node::Text {
            value: String::new(),
        }
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
    let base_type = tn["names"]
        .as_array()
        .and_then(|arr| {
            arr.iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .find(|s| *s != "pg_catalog")
        })
        .unwrap_or("unknown");

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
                format!("{m}")
            })
            .collect();
        format!("{base_type}({})", mod_strs.join(", "))
    } else {
        base_type.to_string()
    };

    // Array bounds: integer[], text[][], etc.
    let array_dims = tn["arrayBounds"]
        .as_array()
        .map(|a| a.len())
        .unwrap_or(0);
    let array_suffix = "[]".repeat(array_dims);

    format!("{with_mods}{array_suffix}")
}

fn type_cast_to_node(tc: &Value) -> Node {
    let arg = node_value_to_node(&tc["arg"]);
    let type_str = type_name_str(&tc["typeName"]);
    Node::Concat {
        items: vec![
            arg,
            Node::Text {
                value: format!("::{type_str}"),
            },
        ],
    }
}

fn sub_link_to_node(sl: &Value) -> Node {
    let inner = node_value_to_node(&sl["subselect"]);
    Node::Wrap {
        keyword: None,
        open: "(".into(),
        content: Box::new(inner),
        close: ")".into(),
    }
}

pub fn json_ast_equal(json1: &str, json2: &str) -> bool {
    let Ok(v1) = serde_json::from_str::<Value>(json1) else {
        return false;
    };
    let Ok(v2) = serde_json::from_str::<Value>(json2) else {
        return false;
    };
    strip_locations(v1) == strip_locations(v2)
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
