//! Conversion from dot_parser::ast types to sqlfmt_ir::Node.

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
