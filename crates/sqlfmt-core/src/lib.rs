pub use sqlfmt_error::SqlfmtError;
use sqlfmt_ir::Node;
use sqlfmt_render::RenderOpts;

mod preprocess;
use preprocess::{preprocess, DEFAULT_PREPROCESSORS};

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
    // Transparently decode base64 / gzip before parsing. If no preprocessor
    // matches, the input passes through unchanged.
    let (sql, _steps) = preprocess(sql.as_bytes(), DEFAULT_PREPROCESSORS);
    let node = dialect.parse(&sql)?;
    let rendered = opts.render(&node)?;

    // Round-trip test to make sure we didn't drop any AST nodes during convert.
    dialect.ast_equal(&sql, &rendered)?;
    Ok(rendered)
}
