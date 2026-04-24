use sqlfmt_ir::Node;
use sqlfmt_render::{RenderOpts, render};
use thiserror::Error;

#[derive(Debug, Error)]
pub enum SqlfmtError {
    #[error("parse error: {0}")]
    Parse(String),
}

pub trait Dialect {
    fn parse(&self, sql: &str) -> Result<Node, SqlfmtError>;
}

pub fn format_sql(
    dialect: &dyn Dialect,
    sql: &str,
    opts: &RenderOpts,
) -> Result<String, SqlfmtError> {
    let node = dialect.parse(sql)?;
    let rendered = render(&node, opts);

    // Round-trip to make sure our conversion didn't drop any AST nodes.
    let reparsed = dialect.parse(&rendered)?;
    if node != reparsed {
        return Err(SqlfmtError::Parse(format!(
            "non-idempotent formatting detected. Input:\n{sql}\nFormatted:\n{rendered}"
        )));
    }

    Ok(rendered)
}

#[cfg(test)]
mod tests {
    use super::*;
    use sqlfmt_ir::{Clause, Node};

    struct EchoDialect;
    impl Dialect for EchoDialect {
        fn parse(&self, _sql: &str) -> Result<Node, SqlfmtError> {
            Ok(Node::Clauses {
                items: vec![Clause {
                    keyword: "SELECT".into(),
                    body: Some(Box::new(Node::Literal { value: "1".into() })),
                }],
            })
        }
    }

    #[test]
    fn test_format_uses_dialect_and_opts() {
        let opts = sqlfmt_render::RenderOpts {
            case: sqlfmt_render::CaseMode::Lower,
            line_width: 1, // Force a break
            ..Default::default()
        };
        let result = format_sql(&EchoDialect, "anything", &opts).unwrap();
        assert_eq!(result.trim(), "select\n    1");
    }
}
