use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct Clause {
    pub keyword: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub body: Option<Box<Node>>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
#[serde(tag = "type", rename_all = "snake_case")]
pub enum Node {
    // Sugar nodes
    Clauses {
        items: Vec<Clause>,
    },
    List {
        items: Vec<Node>,
        #[serde(skip_serializing_if = "Option::is_none")]
        separator: Option<String>,
    },
    Wrap {
        #[serde(skip_serializing_if = "Option::is_none")]
        keyword: Option<String>,
        open: String,
        content: Box<Node>,
        close: String,
    },
    Infix {
        op: String,
        items: Vec<Node>,
    },
    Keyword {
        value: String,
    },
    Identifier {
        value: String,
        #[serde(skip_serializing_if = "Option::is_none")]
        quote: Option<String>,
    },
    Literal {
        value: String,
    },
    // Primitives
    Text {
        value: String,
    },
    Unformatted {
        value: String,
    },
    Concat {
        items: Vec<Node>,
    },
    Group {
        content: Box<Node>,
    },
    Nest {
        content: Box<Node>,
    },
    Line,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_keyword_roundtrip() {
        let node = Node::Keyword {
            value: "select".into(),
        };
        let json = serde_json::to_string(&node).unwrap();
        assert_eq!(json, r#"{"type":"keyword","value":"select"}"#);
        let back: Node = serde_json::from_str(&json).unwrap();
        assert!(matches!(back, Node::Keyword { .. }));
    }

    #[test]
    fn test_clause_with_body() {
        let node = Node::Clauses {
            items: vec![Clause {
                keyword: "SELECT".into(),
                body: Some(Box::new(Node::Identifier {
                    value: "a".into(),
                    quote: None,
                })),
            }],
        };
        let json = serde_json::to_string(&node).unwrap();
        let back: Node = serde_json::from_str(&json).unwrap();
        assert!(matches!(back, Node::Clauses { .. }));
    }

    #[test]
    fn test_line_roundtrip() {
        let line = Node::Line;
        let json = serde_json::to_string(&line).unwrap();
        assert_eq!(json, r#"{"type":"line"}"#);
        let back: Node = serde_json::from_str(&json).unwrap();
        assert!(matches!(back, Node::Line));
    }

    #[test]
    fn test_wrap_roundtrip() {
        let node = Node::Wrap {
            keyword: Some("COUNT".into()),
            open: "(".into(),
            content: Box::new(Node::Identifier {
                value: "x".into(),
                quote: None,
            }),
            close: ")".into(),
        };
        let json = serde_json::to_string(&node).unwrap();
        let back: Node = serde_json::from_str(&json).unwrap();
        assert!(matches!(back, Node::Wrap { .. }));
    }
}
