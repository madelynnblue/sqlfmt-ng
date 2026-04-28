use sqlfmt_ir::Node;
use sqlfmt_render::{RenderOpts, render};
use thiserror::Error;

#[derive(Debug, Error)]
pub enum SqlfmtError {
    #[error("parse error: {0}")]
    Parse(String),
    #[error("roundtrip error:\nInput:\n{input}\nRendered:\n{output}")]
    Roundtrip { input: String, output: String },
}

pub trait Dialect {
    fn parse(&self, sql: &str) -> Result<Node, SqlfmtError>;
    /// Returns an error if the ASTs of sql and rendered are not equal.
    /// Implemented per-dialect since only the dialect crate has raw AST access.
    fn ast_equal(&self, sql: &str, rendered: &str) -> Result<(), SqlfmtError>;
}

pub fn format_sql(
    dialect: &dyn Dialect,
    sql: &str,
    opts: &RenderOpts,
) -> Result<String, SqlfmtError> {
    let node = dialect.parse(sql)?;
    let rendered = render(&node, opts);

    // Round-trip test to make sure we didn't drop any AST nodes during convert.
    dialect.ast_equal(sql, &rendered)?;
    Ok(rendered)
}
