//! Conversion from dot_parser::ast types to sqlfmt_ir::Node.

use dot_parser::ast::{CompassPt, NodeID, Port};
use sqlfmt_ir::Node;

/// Convert a dot_parser attribute list to an IR node.
/// An attribute list is `[...]` containing comma-separated key=value pairs.
/// Uses Wrap with List — the List's Group controls flat vs. multiline.
pub fn attr_list_to_node(attrs: &dot_parser::ast::AttrList<(String, String)>) -> Option<Node> {
    if attrs.elems.is_empty() {
        return None;
    }
    // Each AList contains a Vec of (String, String) pairs
    let items: Vec<Node> = attrs
        .elems
        .iter()
        .flat_map(|alist| alist.elems.iter().map(|(k, v)| attr_pair_to_node(k, v)))
        .collect();
    if items.is_empty() {
        return None;
    }
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
}

/// Convert a single key=value attribute pair to IR.
/// No spaces around `=` (Graphviz convention).
fn attr_pair_to_node(key: &str, value: &str) -> Node {
    Node::Concat {
        items: vec![
            Node::Identifier {
                value: key.into(),
                quote: None,
            },
            Node::Text { value: "=".into() },
            Node::Identifier {
                value: value.into(),
                quote: None,
            },
        ],
    }
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
