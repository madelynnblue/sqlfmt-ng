use serde_json::Value;
use sqlfmt_core::SqlfmtError;
use sqlfmt_ir::{Clause, Node};

// PostgreSQL reserved keywords that need quoting when used as identifiers.
// Kept minimal — only add words that appear in actual corpus failures.
const PG_RESERVED_TYPE_KEYWORDS: &[&str] = &[
    "char", // pseudo-type "char" vs the SQL char/character(1) type
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

fn set_op_to_node(s: &Value) -> Node {
    let op_kw = match s["op"].as_str().unwrap_or("SETOP_NONE") {
        "SETOP_UNION" => {
            if s["all"].as_bool().unwrap_or(false) {
                "UNION ALL"
            } else {
                "UNION"
            }
        }
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
        let inner = select_stmt_to_node(side);
        if side_op != "SETOP_NONE" {
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
        Node::Hardline,
        Node::Keyword {
            value: op_kw.into(),
        },
        Node::Hardline,
        rnode,
    ];

    // Top-level ORDER BY / LIMIT / OFFSET apply to the whole set expression.
    if let Some(sort) = s["sortClause"].as_array() {
        if !sort.is_empty() {
            let sort_items: Vec<Node> = sort.iter().map(node_value_to_node).collect();
            concat_items.push(Node::Hardline);
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
        concat_items.push(Node::Hardline);
        concat_items.push(Node::Keyword {
            value: "LIMIT".into(),
        });
        concat_items.push(Node::Text { value: " ".into() });
        concat_items.push(node_value_to_node(&s["limitCount"]));
    }
    if !s["limitOffset"].is_null() {
        concat_items.push(Node::Hardline);
        concat_items.push(Node::Keyword {
            value: "OFFSET".into(),
        });
        concat_items.push(Node::Text { value: " ".into() });
        concat_items.push(node_value_to_node(&s["limitOffset"]));
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

    let header = if col_aliases.is_empty() {
        Node::Concat {
            items: vec![
                ident_node(ctename),
                Node::Text {
                    value: " AS ".into(),
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
                    value: " AS ".into(),
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
    let mut cte_items = vec![header, body];
    if let Some(search) = cte.get("searchclause").filter(|s| !s.is_null()) {
        let search_col = search["search_col_name"].as_str().unwrap_or("");
        let search_cols: Vec<Node> = search["search_cols"]
            .as_array()
            .map(|arr| arr.iter().map(node_value_to_node).collect())
            .unwrap_or_default();
        let search_body = Node::Concat {
            items: vec![
                Node::Text {
                    value: "SEARCH BREADTH FIRST BY ".into(),
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
    if let Some(cycle) = cte.get("cycleclause").filter(|c| !c.is_null()) {
        let cycle_cols: Vec<Node> = cycle["cycle_cols"]
            .as_array()
            .map(|arr| arr.iter().map(node_value_to_node).collect())
            .unwrap_or_default();
        let cycle_mark = cycle["cycle_mark_column"].as_str().unwrap_or("");
        let cycle_mark_value = a_const_value_str(&cycle["cycle_mark_value"]).unwrap_or_default();
        let cycle_mark_default =
            a_const_value_str(&cycle["cycle_mark_default"]).unwrap_or_default();
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
                        " SET {cycle_mark} TO {cycle_mark_value} DEFAULT {cycle_mark_default}"
                    ),
                },
            ],
        };
        cte_items.push(cycle_body);
    }

    Node::Concat { items: cte_items }
}

fn select_stmt_to_node(s: &Value) -> Node {
    // UNION / INTERSECT / EXCEPT: delegate to set-op handling.
    let op = s["op"].as_str().unwrap_or("SETOP_NONE");
    if op != "SETOP_NONE" {
        return set_op_to_node(s);
    }

    let mut clauses: Vec<Clause> = Vec::new();

    // WITH clause (CTEs).
    if let Some(with) = s.get("withClause").filter(|w| !w.is_null()) {
        let recursive = with["recursive"].as_bool().unwrap_or(false);
        let kw = if recursive { "WITH RECURSIVE" } else { "WITH" };
        let ctes = with["ctes"]
            .as_array()
            .map(|arr| {
                arr.iter()
                    .map(|c| {
                        c.get("CommonTableExpr")
                            .map(common_table_expr_to_node)
                            .unwrap_or(Node::Text {
                                value: format!("{c}"),
                            })
                    })
                    .collect::<Vec<_>>()
            })
            .unwrap_or_default();
        clauses.push(Clause {
            keyword: kw.into(),
            body: Some(Box::new(Node::List {
                items: ctes,
                separator: Some(",".into()),
            })),
        });
    }

    // DISTINCT / DISTINCT ON
    // pg_query represents SELECT DISTINCT as distinctClause: [{}] (NIL sentinel),
    // and SELECT DISTINCT ON (exprs) as distinctClause: [{expr}, ...].
    let distinct = s["distinctClause"].as_array();
    let is_nil =
        |v: &serde_json::Value| v.as_object().map_or(false, |o| o.is_empty()) || v.is_null();
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

    // FOR UPDATE / FOR SHARE locking clauses.
    if let Some(locking) = s["lockingClause"].as_array() {
        for lc in locking {
            let lc_inner = lc.get("LockingClause").unwrap_or(lc);
            let strength = lc_inner["strength"].as_str().unwrap_or("LCS_FORUPDATE");
            let kw = match strength {
                "LCS_FORKEYSHARE" => "FOR KEY SHARE",
                "LCS_FORSHARE" => "FOR SHARE",
                "LCS_FORNOKEYUPDATE" => "FOR NO KEY UPDATE",
                _ => "FOR UPDATE",
            };
            clauses.push(Clause {
                keyword: kw.into(),
                body: None,
            });
        }
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
                ident_node(name),
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

    // NULLIF(a, b)
    if kind == "AEXPR_NULLIF" {
        if has_lexpr && has_rexpr {
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
    }

    // SIMILAR TO / NOT SIMILAR TO: rexpr is pg_catalog.similar_to_escape(pattern[, escape]).
    // Extract the pattern from the FuncCall args and render as `lexpr SIMILAR TO pattern`.
    if kind == "AEXPR_SIMILAR" {
        let similar_kw = if op_raw == "~" {
            "SIMILAR TO"
        } else {
            "NOT SIMILAR TO"
        };
        if has_lexpr && has_rexpr {
            let pattern = e["rexpr"]["FuncCall"]["args"]
                .as_array()
                .and_then(|args| args.first())
                .map(node_value_to_node)
                .unwrap_or(node_value_to_node(&e["rexpr"]));
            return Node::Infix {
                op: similar_kw.to_string(),
                items: vec![
                    wrap_infix_in_parens(node_value_to_node(&e["lexpr"])),
                    pattern,
                ],
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

    match (has_lexpr, has_rexpr) {
        (true, true) => Node::Infix {
            op,
            items: vec![
                wrap_infix_in_parens(node_value_to_node(&e["lexpr"])),
                wrap_infix_in_parens(node_value_to_node(&e["rexpr"])),
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
            items: vec![Node::Text { value: op }, node_value_to_node(&e["rexpr"])],
        },
        (false, false) => Node::Text { value: op },
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

fn is_or_expr(v: &Value) -> bool {
    if let Some(be) = v.get("BoolExpr") {
        let boolop_str = be["boolop"].as_str().unwrap_or("");
        let boolop_num = be["boolop"].as_u64();
        boolop_str == "OR_EXPR" || boolop_num == Some(1)
    } else {
        false
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
        // Wrap any OR sub-expressions in parens to preserve precedence.
        let args: Vec<Node> = raw_args
            .iter()
            .map(|arg| {
                let node = node_value_to_node(arg);
                if is_or_expr(arg) {
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
        let args: Vec<Node> = raw_args.iter().map(node_value_to_node).collect();
        Node::Infix {
            op: "OR".into(),
            items: args,
        }
    } else if is_not {
        let args: Vec<Node> = raw_args.iter().map(node_value_to_node).collect();
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

    let name = all_name_parts.join(".");

    // C struct field is agg_star (snake_case).
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
            let arg_nodes: Vec<Node> = args.iter().map(node_value_to_node).collect();
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

    let base = Node::Wrap {
        keyword: Some(name),
        open: "(".into(),
        content: Box::new(content),
        close: ")".into(),
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
                format!("{m}")
            })
            .collect();
        format!("{base_type}({})", mod_strs.join(", "))
    } else {
        base_type.to_string()
    };

    // Array bounds: integer[], text[][], etc.
    let array_dims = tn["arrayBounds"].as_array().map(|a| a.len()).unwrap_or(0);
    let array_suffix = "[]".repeat(array_dims);

    format!("{with_mods}{array_suffix}")
}

fn type_cast_to_node(tc: &Value) -> Node {
    let arg = wrap_infix_in_parens(node_value_to_node(&tc["arg"]));
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
            // testexpr op ANY (subselect), or testexpr IN (subselect) when op is "=".
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
                if op_name == "=" {
                    Node::Infix {
                        op: "IN".into(),
                        items: vec![test, wrapped],
                    }
                } else {
                    let rhs = Node::Wrap {
                        keyword: Some("ANY".into()),
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
