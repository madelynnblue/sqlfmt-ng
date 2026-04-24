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

    if let Some(items) = s["targetList"].as_array() {
        if !items.is_empty() {
            let nodes: Vec<Node> = items.iter().map(node_value_to_node).collect();
            clauses.push(Clause {
                keyword: "SELECT".into(),
                body: Some(Box::new(Node::List {
                    items: nodes,
                    separator: None,
                })),
            });
        } else {
            clauses.push(Clause {
                keyword: "SELECT".into(),
                body: None,
            });
        }
    } else {
        clauses.push(Clause {
            keyword: "SELECT".into(),
            body: None,
        });
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
    if let Some(bsval) = c.get("bsval") {
        let s = bsval
            .as_str()
            .or_else(|| bsval["bsval"].as_str())
            .unwrap_or("");
        return Node::Literal {
            value: s.to_string(),
        };
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
        ident
    } else {
        Node::Concat {
            items: vec![
                ident,
                Node::Text {
                    value: " AS ".into(),
                },
                ident_node(alias_name),
            ],
        }
    }
}

fn a_expr_to_node(e: &Value) -> Node {
    let op = e["name"]
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
    let name = f["funcname"]
        .as_array()
        .map(|arr| {
            arr.iter()
                .filter_map(|n| {
                    n["String"]["sval"]
                        .as_str()
                        .or_else(|| n["String"]["str"].as_str())
                })
                .collect::<Vec<_>>()
                .join(".")
        })
        .unwrap_or_default();

    // C struct field is agg_star (snake_case).
    let agg_star = f["agg_star"].as_bool().unwrap_or(false);

    let content = if agg_star {
        Node::Text { value: "*".into() }
    } else if let Some(args) = f["args"].as_array() {
        if args.is_empty() {
            Node::Text {
                value: String::new(),
            }
        } else {
            Node::List {
                items: args.iter().map(node_value_to_node).collect(),
                separator: None,
            }
        }
    } else {
        Node::Text {
            value: String::new(),
        }
    };

    Node::Wrap {
        keyword: Some(name),
        open: "(".into(),
        content: Box::new(content),
        close: ")".into(),
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

    if dir_str == "SORTBY_ASC" || dir_num == 1 {
        Node::Concat {
            items: vec![
                inner,
                Node::Text {
                    value: " ASC".into(),
                },
            ],
        }
    } else if dir_str == "SORTBY_DESC" || dir_num == 2 {
        Node::Concat {
            items: vec![
                inner,
                Node::Text {
                    value: " DESC".into(),
                },
            ],
        }
    } else {
        inner
    }
}

fn type_cast_to_node(tc: &Value) -> Node {
    let arg = node_value_to_node(&tc["arg"]);
    let type_name = tc["typeName"]["TypeName"]["names"]
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
    Node::Concat {
        items: vec![
            arg,
            Node::Text {
                value: format!("::{type_name}"),
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
