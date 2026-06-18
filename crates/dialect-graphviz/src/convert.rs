//! Conversion from dot_parser::ast types to sqlfmt_ir::Node.

use dot_parser::ast::either::Either;
use dot_parser::ast::{AttrList, AttrStmt, CompassPt, EdgeRHS, EdgeStmt, NodeID, NodeStmt, Port,
                      Stmt, StmtList, Subgraph};
use sqlfmt_ir::Node;

/// Convert a dot_parser attribute list to an IR node.
/// An attribute list is `[...]` containing comma-separated key=value pairs.
/// Uses Wrap with List — the List's Group controls flat vs. multiline.
/// Multiple AList groups (e.g. `[a=1][b=2]`) are preserved as separate
/// `[...]` blocks to maintain round-trip AST fidelity.
pub fn attr_list_to_node(attrs: &AttrList<(String, String)>) -> Option<Node> {
    if attrs.elems.is_empty() {
        return None;
    }
    // Preserve each AList as a separate [...] block for round-trip correctness.
    let groups: Vec<Node> = attrs
        .elems
        .iter()
        .filter_map(|alist| {
            if alist.elems.is_empty() {
                return None;
            }
            let items: Vec<Node> = alist
                .elems
                .iter()
                .map(|(k, v)| attr_pair_to_node(k, v))
                .collect();
            Some(Node::Wrap {
                keyword: None,
                open: "[".into(),
                content: Box::new(Node::Group {
                    content: Box::new(Node::List {
                        items,
                        separator: Some(",".into()),
                    }),
                }),
                close: "]".into(),
            })
        })
        .collect();
    if groups.is_empty() {
        return None;
    }
    if groups.len() == 1 {
        Some(groups.into_iter().next().unwrap())
    } else {
        Some(Node::Group {
            content: Box::new(Node::Concat { items: groups }),
        })
    }
}

/// Convert a single key=value attribute pair to IR.
/// No spaces around `=` (Graphviz convention).
fn attr_pair_to_node(key: &str, value: &str) -> Node {
    let quote = if needs_quoting(value) {
        Some("\"".into())
    } else {
        None
    };
    Node::Concat {
        items: vec![
            Node::Identifier {
                value: key.into(),
                quote: None,
            },
            Node::Text { value: "=".into() },
            Node::Identifier {
                value: value.into(),
                quote,
            },
        ],
    }
}

/// Heuristic for whether a DOT attribute value needs double-quote wrapping.
/// The dot-parser strips quotes during parsing, so we must re-add them for
/// values that would be invalid as bare identifiers.
fn needs_quoting(s: &str) -> bool {
    s.is_empty()
        || s.starts_with('<')
        || s.contains(' ')
        || s.contains('"')
        || s.contains('\t')
        || s.contains('\n')
}

/// Convert a NodeID (with optional port/compass) to IR.
fn node_id_to_node(node_id: &NodeID) -> Node {
    let id_node = Node::Identifier {
        value: node_id.id.clone(),
        quote: None,
    };
    match &node_id.port {
        None => id_node,
        Some(port) => {
            let port_node = match port {
                Port::ID(p, compass) => {
                    let mut items = vec![Node::Text { value: ":".into() }, Node::Identifier {
                        value: p.clone(),
                        quote: None,
                    }];
                    if let Some(c) = compass {
                        items.push(Node::Text { value: ":".into() });
                        items.push(Node::Identifier {
                            value: compass_pt_to_str(c).into(),
                            quote: None,
                        });
                    }
                    Node::Concat { items }
                }
                Port::Compass(c) => Node::Concat {
                    items: vec![
                        Node::Text { value: ":".into() },
                        Node::Identifier {
                            value: compass_pt_to_str(c).into(),
                            quote: None,
                        },
                    ],
                },
            };
            Node::Concat {
                items: vec![id_node, port_node],
            }
        }
    }
}

fn compass_pt_to_str(c: &CompassPt) -> &'static str {
    match c {
        CompassPt::N => "n",
        CompassPt::NE => "ne",
        CompassPt::E => "e",
        CompassPt::SE => "se",
        CompassPt::S => "s",
        CompassPt::SW => "sw",
        CompassPt::W => "w",
        CompassPt::NW => "nw",
        CompassPt::C => "c",
        CompassPt::Underscore => "_",
    }
}

// ── Statement conversion ──────────────────────────────────────────────────

/// Convert a single DOT statement to IR, using the given edge operator.
pub(crate) fn stmt_to_node_with_op(stmt: &Stmt<(String, String)>, edge_op: &str) -> Node {
    match stmt {
        Stmt::NodeStmt(ns) => node_stmt_to_node(ns),
        Stmt::EdgeStmt(es) => edge_stmt_to_node_with_op(es, edge_op),
        Stmt::AttrStmt(as_) => attr_stmt_to_node(as_),
        Stmt::IDEq(lhs, rhs) => id_eq_to_node(lhs, rhs),
        Stmt::Subgraph(sg) => subgraph_to_node(sg, edge_op),
    }
}

fn node_stmt_to_node(stmt: &NodeStmt<(String, String)>) -> Node {
    let mut items = vec![node_id_to_node(&stmt.node)];
    if let Some(attr_node) = stmt.attr.as_ref().and_then(|a| attr_list_to_node(a)) {
        items.push(Node::Text { value: " ".into() });
        items.push(attr_node);
    }
    items.push(Node::Text { value: ";".into() });
    Node::Concat { items }
}

fn edge_stmt_to_node_with_op(stmt: &EdgeStmt<(String, String)>, edge_op: &str) -> Node {
    let mut chain_items: Vec<Node> = vec![edge_endpoint_to_node(&stmt.from, edge_op)];
    let mut next: Option<&EdgeRHS<(String, String)>> = Some(&stmt.next);
    while let Some(rhs) = next {
        chain_items.push(edge_endpoint_to_node(&rhs.to, edge_op));
        next = rhs.next.as_ref().map(|b| b.as_ref());
    }
    let chain_node = if chain_items.len() == 1 {
        chain_items.into_iter().next().unwrap()
    } else {
        Node::Group {
            content: Box::new(Node::Infix {
                op: edge_op.into(),
                items: chain_items,
            }),
        }
    };
    let mut items = vec![chain_node];
    if let Some(attr_node) = stmt.attr.as_ref().and_then(|a| attr_list_to_node(a)) {
        items.push(Node::Text { value: " ".into() });
        items.push(attr_node);
    }
    items.push(Node::Text { value: ";".into() });
    Node::Concat { items }
}

fn edge_endpoint_to_node(
    endpoint: &Either<NodeID, Subgraph<(String, String)>>,
    edge_op: &str,
) -> Node {
    match endpoint {
        Either::Left(node_id) => node_id_to_node(node_id),
        Either::Right(subgraph) => subgraph_to_node(subgraph, edge_op),
    }
}

fn attr_stmt_to_node(stmt: &AttrStmt<(String, String)>) -> Node {
    let keyword = match stmt {
        AttrStmt::Graph(_) => "graph",
        AttrStmt::Node(_) => "node",
        AttrStmt::Edge(_) => "edge",
    };
    let attrs = match stmt {
        AttrStmt::Graph(a) | AttrStmt::Node(a) | AttrStmt::Edge(a) => a,
    };
    let mut items = vec![Node::Keyword { value: keyword.into() }];
    if let Some(attr_node) = attr_list_to_node(attrs) {
        items.push(Node::Text { value: " ".into() });
        items.push(attr_node);
    }
    items.push(Node::Text { value: ";".into() });
    Node::Concat { items }
}

fn id_eq_to_node(lhs: &str, rhs: &str) -> Node {
    Node::Concat {
        items: vec![
            Node::Identifier {
                value: lhs.into(),
                quote: None,
            },
            Node::Text { value: " = ".into() },
            Node::Identifier {
                value: rhs.into(),
                quote: None,
            },
            Node::Text { value: ";".into() },
        ],
    }
}

// ── Subgraph and graph conversion ─────────────────────────────────────────

fn subgraph_to_node(subgraph: &Subgraph<(String, String)>, edge_op: &str) -> Node {
    let mut header_items = vec![Node::Keyword {
        value: "subgraph".into(),
    }];
    if let Some(ref name) = subgraph.id {
        header_items.push(Node::Text { value: " ".into() });
        header_items.push(Node::Identifier {
            value: name.clone(),
            quote: None,
        });
    }
    header_items.push(Node::Text { value: " {".into() });
    let body_items = stmt_list_to_body_nodes_with_op(&subgraph.stmts, edge_op);
    let mut all_items: Vec<Node> = vec![Node::Concat {
        items: header_items,
    }];
    if !body_items.is_empty() {
        let mut nested_content = vec![Node::Line];
        nested_content.extend(body_items);
        all_items.push(Node::Nest {
            content: Box::new(Node::Concat {
                items: nested_content,
            }),
        });
        all_items.push(Node::Line);
    }
    all_items.push(Node::Text { value: "}".into() });
    Node::Group {
        content: Box::new(Node::Concat { items: all_items }),
    }
}

/// Convert a complete DOT Graph to IR.
pub fn graph_to_node(graph: &dot_parser::ast::Graph<(String, String)>) -> Node {
    let edge_op = if graph.is_digraph { "->" } else { "--" };
    let mut header_items = Vec::new();
    if graph.strict {
        header_items.push(Node::Keyword {
            value: "strict".into(),
        });
        header_items.push(Node::Text { value: " ".into() });
    }
    header_items.push(Node::Keyword {
        value: if graph.is_digraph {
            "digraph"
        } else {
            "graph"
        }
        .into(),
    });
    if let Some(ref name) = graph.name {
        header_items.push(Node::Text { value: " ".into() });
        header_items.push(Node::Identifier {
            value: name.clone(),
            quote: None,
        });
    }
    header_items.push(Node::Text { value: " {".into() });
    let body_items = stmt_list_to_body_nodes_with_op(&graph.stmts, edge_op);
    let mut all_items: Vec<Node> = vec![Node::Concat {
        items: header_items,
    }];
    if !body_items.is_empty() {
        let mut nested_content = vec![Node::Line];
        nested_content.extend(body_items);
        all_items.push(Node::Nest {
            content: Box::new(Node::Concat {
                items: nested_content,
            }),
        });
        all_items.push(Node::Line);
    }
    all_items.push(Node::Text { value: "}".into() });
    all_items.push(Node::Line);
    Node::Group {
        content: Box::new(Node::Concat { items: all_items }),
    }
}

fn stmt_list_to_body_nodes_with_op(
    stmts: &StmtList<(String, String)>,
    edge_op: &str,
) -> Vec<Node> {
    let mut nodes = Vec::new();
    for (i, stmt) in stmts.stmts.iter().enumerate() {
        if i > 0 {
            nodes.push(Node::Line);
        }
        nodes.push(stmt_to_node_with_op(stmt, edge_op));
    }
    nodes
}
