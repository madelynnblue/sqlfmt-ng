use sqlfmt_core::{Dialect, SqlfmtError};
use sqlfmt_ir::Node;

pub struct JsonDialect;

impl Dialect for JsonDialect {
    fn parse(&self, input: &str) -> Result<Node, SqlfmtError> {
        let value: serde_json::Value =
            serde_json::from_str(input).map_err(|e| SqlfmtError::Parse(e.to_string()))?;
        Ok(value_to_node(&value))
    }

    fn ast_equal(&self, _original: &str, _rendered: &str) -> Result<(), SqlfmtError> {
        todo!()
    }
}

fn value_to_node(value: &serde_json::Value) -> Node {
    match value {
        serde_json::Value::Null => Node::Literal { value: "null".into() },
        serde_json::Value::Bool(b) => Node::Literal { value: b.to_string() },
        serde_json::Value::Number(n) => Node::Literal { value: n.to_string() },
        serde_json::Value::String(_) => Node::Literal {
            value: serde_json::to_string(value).expect("string serialization is infallible"),
        },
        serde_json::Value::Array(items) => bracketed(
            "[",
            Node::List {
                items: items.iter().map(value_to_node).collect(),
                separator: Some(",".into()),
            },
            "]",
        ),
        serde_json::Value::Object(map) => {
            let mut pairs: Vec<(&String, &serde_json::Value)> = map.iter().collect();
            pairs.sort_by_key(|(k, _)| k.as_str());
            bracketed(
                "{",
                Node::List {
                    items: pairs
                        .into_iter()
                        .map(|(k, v)| Node::Concat {
                            items: vec![
                                Node::Literal {
                                    value: serde_json::to_string(k)
                                        .expect("string serialization is infallible"),
                                },
                                Node::Text { value: ": ".into() },
                                value_to_node(v),
                            ],
                        })
                        .collect(),
                    separator: Some(",".into()),
                },
                "}",
            )
        }
    }
}

/// Wraps `content` in `open`/`close` brackets with soft-line breaks and nesting,
/// so the result is flat when it fits and expanded (one item per indented line) when it doesn't.
fn bracketed(open: &str, content: Node, close: &str) -> Node {
    Node::Group {
        content: Box::new(Node::Concat {
            items: vec![
                Node::Text { value: open.into() },
                Node::Nest {
                    content: Box::new(Node::Concat {
                        items: vec![Node::Softline, content],
                    }),
                },
                Node::Softline,
                Node::Text { value: close.into() },
            ],
        }),
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use sqlfmt_core::format_sql;
    use sqlfmt_render::{CaseMode, RenderOpts};

    fn opts(line_width: usize) -> RenderOpts {
        RenderOpts {
            line_width,
            use_tabs: false,
            tab_width: 4,
            case: CaseMode::Upper,
            error_on_unformatted: true,
        }
    }

    #[test]
    fn test_null() {
        assert_eq!(format_sql(&JsonDialect, "null", &opts(80)).unwrap(), "null");
    }

    #[test]
    fn test_bool() {
        assert_eq!(format_sql(&JsonDialect, "true", &opts(80)).unwrap(), "true");
        assert_eq!(format_sql(&JsonDialect, "false", &opts(80)).unwrap(), "false");
    }

    #[test]
    fn test_number_integer() {
        assert_eq!(format_sql(&JsonDialect, "42", &opts(80)).unwrap(), "42");
    }

    #[test]
    fn test_number_float() {
        assert_eq!(format_sql(&JsonDialect, "3.14", &opts(80)).unwrap(), "3.14");
    }

    #[test]
    fn test_string() {
        assert_eq!(
            format_sql(&JsonDialect, r#""hello""#, &opts(80)).unwrap(),
            r#""hello""#
        );
    }

    #[test]
    fn test_string_with_escapes() {
        assert_eq!(
            format_sql(&JsonDialect, r#""a\"b""#, &opts(80)).unwrap(),
            r#""a\"b""#
        );
    }

    #[test]
    fn test_empty_array() {
        assert_eq!(format_sql(&JsonDialect, "[]", &opts(80)).unwrap(), "[]");
    }

    #[test]
    fn test_array_flat() {
        assert_eq!(
            format_sql(&JsonDialect, "[1,2,3]", &opts(80)).unwrap(),
            "[1, 2, 3]"
        );
    }

    #[test]
    fn test_array_expanded() {
        assert_eq!(
            format_sql(&JsonDialect, "[1,2,3]", &opts(5)).unwrap(),
            "[\n    1,\n    2,\n    3\n]"
        );
    }

    #[test]
    fn test_empty_object() {
        assert_eq!(format_sql(&JsonDialect, "{}", &opts(80)).unwrap(), "{}");
    }

    #[test]
    fn test_object_flat() {
        assert_eq!(
            format_sql(&JsonDialect, r#"{"z":1,"a":2}"#, &opts(80)).unwrap(),
            r#"{"a": 2, "z": 1}"#
        );
    }

    #[test]
    fn test_object_sorts_keys() {
        let result = format_sql(&JsonDialect, r#"{"z":1,"m":2,"a":3}"#, &opts(80)).unwrap();
        assert_eq!(result, r#"{"a": 3, "m": 2, "z": 1}"#);
    }

    #[test]
    fn test_object_expanded() {
        let result = format_sql(&JsonDialect, r#"{"z":1,"a":2}"#, &opts(10)).unwrap();
        assert_eq!(result, "{\n    \"a\": 2,\n    \"z\": 1\n}");
    }

    #[test]
    fn test_nested() {
        let input = r#"{"b":[1,2],"a":{"x":true}}"#;
        let result = format_sql(&JsonDialect, input, &opts(80)).unwrap();
        assert_eq!(result, r#"{"a": {"x": true}, "b": [1, 2]}"#);
    }

    #[test]
    fn test_parse_error() {
        assert!(matches!(
            format_sql(&JsonDialect, "not json", &opts(80)),
            Err(SqlfmtError::Parse(_))
        ));
    }
}
