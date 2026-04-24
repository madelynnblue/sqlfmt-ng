use crate::protobuf::{
    a_const, node::Node as NodeEnum, AConst, AExpr, BoolExpr, BoolExprType, ColumnRef, FuncCall,
    Node as PbNode, RangeVar, RawStmt, ResTarget, SelectStmt, SortBy,
};
use sqlfmt_ir::{Clause, Node};

fn pg_needs_quoting(s: &str) -> bool {
    if s.is_empty() {
        return true;
    }
    let mut chars = s.chars();
    let first_ok = chars.next().map(|c| matches!(c, 'a'..='z' | '_')).unwrap_or(false);
    !first_ok || !chars.all(|c| matches!(c, 'a'..='z' | '0'..='9' | '_' | '$'))
}

fn ident_node(s: &str) -> Node {
    Node::Identifier {
        value: s.to_string(),
        quote: if pg_needs_quoting(s) { Some("\"".to_string()) } else { None },
    }
}

fn qualified_ident_node(parts: &[&str]) -> Node {
    if parts.is_empty() {
        return Node::Text { value: String::new() };
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

pub fn raw_stmt_to_node(raw: &RawStmt) -> Option<Node> {
    match raw.stmt.as_ref()?.node.as_ref()? {
        NodeEnum::SelectStmt(s) => Some(select_stmt_to_node(s)),
        _ => None,
    }
}

fn pb_node_to_node(pb: &PbNode) -> Node {
    match pb.node.as_ref() {
        Some(inner) => node_enum_to_node(inner),
        None => Node::Text { value: String::new() },
    }
}

fn node_enum_to_node(node: &NodeEnum) -> Node {
    match node {
        NodeEnum::SelectStmt(s) => select_stmt_to_node(s),
        NodeEnum::ResTarget(rt) => res_target_to_node(rt),
        NodeEnum::ColumnRef(cr) => column_ref_to_node(cr),
        NodeEnum::AConst(c) => a_const_to_node(c),
        NodeEnum::RangeVar(rv) => range_var_to_node(rv),
        NodeEnum::AExpr(e) => a_expr_to_node(e),
        NodeEnum::BoolExpr(b) => bool_expr_to_node(b),
        NodeEnum::FuncCall(f) => func_call_to_node(f),
        NodeEnum::String(s) => ident_node(&s.sval),
        NodeEnum::Integer(i) => Node::Literal { value: i.ival.to_string() },
        NodeEnum::Float(f) => Node::Literal { value: f.fval.clone() },
        NodeEnum::Boolean(b) => Node::Literal {
            value: if b.boolval { "TRUE".into() } else { "FALSE".into() },
        },
        NodeEnum::AStar(_) => Node::Text { value: "*".into() },
        NodeEnum::SortBy(sb) => sort_by_to_node(sb),
        other => Node::Text { value: format!("{other:?}") },
    }
}

fn select_stmt_to_node(s: &SelectStmt) -> Node {
    let mut clauses: Vec<Clause> = Vec::new();

    if !s.target_list.is_empty() {
        let items: Vec<Node> = s.target_list.iter().map(pb_node_to_node).collect();
        clauses.push(Clause {
            keyword: "SELECT".into(),
            body: Some(Box::new(Node::List { items, separator: None })),
        });
    } else {
        clauses.push(Clause { keyword: "SELECT".into(), body: None });
    }

    if !s.from_clause.is_empty() {
        let items: Vec<Node> = s.from_clause.iter().map(pb_node_to_node).collect();
        let body = if items.len() == 1 {
            items.into_iter().next().unwrap()
        } else {
            Node::List { items, separator: None }
        };
        clauses.push(Clause { keyword: "FROM".into(), body: Some(Box::new(body)) });
    }

    if let Some(w) = &s.where_clause {
        clauses.push(Clause { keyword: "WHERE".into(), body: Some(Box::new(pb_node_to_node(w))) });
    }

    if !s.group_clause.is_empty() {
        let items: Vec<Node> = s.group_clause.iter().map(pb_node_to_node).collect();
        clauses.push(Clause {
            keyword: "GROUP BY".into(),
            body: Some(Box::new(Node::List { items, separator: None })),
        });
    }

    if let Some(h) = &s.having_clause {
        clauses.push(Clause { keyword: "HAVING".into(), body: Some(Box::new(pb_node_to_node(h))) });
    }

    if !s.sort_clause.is_empty() {
        let items: Vec<Node> = s.sort_clause.iter().map(pb_node_to_node).collect();
        clauses.push(Clause {
            keyword: "ORDER BY".into(),
            body: Some(Box::new(Node::List { items, separator: None })),
        });
    }

    if let Some(l) = &s.limit_count {
        clauses.push(Clause { keyword: "LIMIT".into(), body: Some(Box::new(pb_node_to_node(l))) });
    }

    if let Some(o) = &s.limit_offset {
        clauses.push(Clause { keyword: "OFFSET".into(), body: Some(Box::new(pb_node_to_node(o))) });
    }

    Node::Clauses { items: clauses }
}

fn res_target_to_node(rt: &ResTarget) -> Node {
    let val = rt.val.as_ref().map(|v| pb_node_to_node(v))
        .unwrap_or_else(|| Node::Text { value: String::new() });
    if rt.name.is_empty() {
        val
    } else {
        Node::Concat {
            items: vec![
                val,
                Node::Text { value: " AS ".into() },
                Node::Identifier { value: rt.name.clone(), quote: None },
            ],
        }
    }
}

fn column_ref_to_node(cr: &ColumnRef) -> Node {
    let parts: Vec<&str> = cr.fields.iter().map(|n| match n.node.as_ref() {
        Some(NodeEnum::String(s)) => s.sval.as_str(),
        Some(NodeEnum::AStar(_)) => "*",
        _ => "",
    }).collect();
    qualified_ident_node(&parts)
}

fn a_const_to_node(c: &AConst) -> Node {
    if c.isnull {
        return Node::Literal { value: "NULL".into() };
    }
    match &c.val {
        Some(a_const::Val::Ival(i)) => Node::Literal { value: i.ival.to_string() },
        Some(a_const::Val::Fval(f)) => Node::Literal { value: f.fval.clone() },
        Some(a_const::Val::Boolval(b)) => Node::Literal {
            value: if b.boolval { "TRUE".into() } else { "FALSE".into() },
        },
        Some(a_const::Val::Sval(s)) => Node::Literal {
            value: format!("'{}'", s.sval.replace('\'', "''")),
        },
        Some(a_const::Val::Bsval(b)) => Node::Literal { value: b.bsval.clone() },
        None => Node::Literal { value: "NULL".into() },
    }
}

fn range_var_to_node(rv: &RangeVar) -> Node {
    let mut parts: Vec<&str> = Vec::new();
    if !rv.catalogname.is_empty() { parts.push(&rv.catalogname); }
    if !rv.schemaname.is_empty() { parts.push(&rv.schemaname); }
    parts.push(&rv.relname);
    let ident = qualified_ident_node(&parts);
    if let Some(alias) = &rv.alias {
        Node::Concat {
            items: vec![
                ident,
                Node::Text { value: " AS ".into() },
                ident_node(&alias.aliasname),
            ],
        }
    } else {
        ident
    }
}

fn a_expr_to_node(e: &AExpr) -> Node {
    let op = e.name.first()
        .and_then(|n| n.node.as_ref())
        .and_then(|n| if let NodeEnum::String(s) = n { Some(s.sval.clone()) } else { None })
        .unwrap_or_else(|| "?".into());

    let lexpr = e.lexpr.as_deref().map(pb_node_to_node);
    let rexpr = e.rexpr.as_deref().map(pb_node_to_node);

    match (lexpr, rexpr) {
        (Some(l), Some(r)) => Node::Infix { op, items: vec![l, r] },
        (Some(l), None) => Node::Concat {
            items: vec![l, Node::Text { value: " ".into() }, Node::Text { value: op }],
        },
        (None, Some(r)) => Node::Concat {
            items: vec![Node::Text { value: op }, Node::Text { value: " ".into() }, r],
        },
        (None, None) => Node::Text { value: op },
    }
}

fn bool_expr_to_node(b: &BoolExpr) -> Node {
    let args: Vec<Node> = b.args.iter().map(pb_node_to_node).collect();
    let boolop = BoolExprType::from_i32(b.boolop).unwrap_or(BoolExprType::Undefined);
    match boolop {
        BoolExprType::AndExpr => Node::Infix { op: "AND".into(), items: args },
        BoolExprType::OrExpr => Node::Infix { op: "OR".into(), items: args },
        BoolExprType::NotExpr => {
            let inner = args.into_iter().next().unwrap_or(Node::Text { value: String::new() });
            Node::Concat {
                items: vec![Node::Keyword { value: "NOT".into() }, Node::Text { value: " ".into() }, inner],
            }
        }
        BoolExprType::Undefined => Node::Text { value: format!("{b:?}") },
    }
}

fn func_call_to_node(f: &FuncCall) -> Node {
    let name = f.funcname.iter()
        .filter_map(|n| n.node.as_ref())
        .filter_map(|n| if let NodeEnum::String(s) = n { Some(s.sval.clone()) } else { None })
        .collect::<Vec<_>>()
        .join(".");

    let content = if f.agg_star {
        Node::Text { value: "*".into() }
    } else if f.args.is_empty() {
        Node::Text { value: String::new() }
    } else {
        Node::List { items: f.args.iter().map(pb_node_to_node).collect(), separator: None }
    };

    Node::Wrap { keyword: Some(name), open: "(".into(), content: Box::new(content), close: ")".into() }
}

fn sort_by_to_node(sb: &SortBy) -> Node {
    let inner = match &sb.node {
        Some(n) => pb_node_to_node(n),
        None => Node::Text { value: String::new() },
    };
    match sb.sortby_dir {
        1 => Node::Concat { items: vec![inner, Node::Text { value: " ASC".into() }] },
        2 => Node::Concat { items: vec![inner, Node::Text { value: " DESC".into() }] },
        _ => inner,
    }
}
