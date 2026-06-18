pub use sqlfmt_error::SqlfmtError;
use sqlfmt_ir::Node;
use sqlfmt_render::RenderOpts;

pub mod preprocess;
pub use preprocess::{preprocess, DEFAULT_PREPROCESSORS};

pub trait Dialect {
    fn parse(&self, sql: &str) -> Result<Node, SqlfmtError>;
    /// Returns an error if the ASTs of sql and rendered are not equal.
    /// Implemented per-dialect since only the dialect crate has raw AST access.
    fn ast_equal(&self, sql: &str, rendered: &str) -> Result<(), SqlfmtError>;

    /// Returns default render options for corpus tests and other automated
    /// formatting. Override to set dialect-appropriate defaults (e.g., keyword
    /// case mode). The base implementation uses `CaseMode::Upper`.
    fn default_render_opts(&self) -> RenderOpts {
        RenderOpts {
            line_width: 60,
            use_tabs: false,
            tab_width: 4,
            case: sqlfmt_render::CaseMode::Upper,
            error_on_unformatted: true,
        }
    }
    /// Apply dialect-specific overrides to user-supplied render options.
    /// Called by `format_sql` before rendering. Override to enforce
    /// dialect-required settings (e.g., DOT must use lowercase keywords).
    /// The default implementation passes `user_opts` through unchanged.
    fn apply_render_opts(&self, user_opts: &RenderOpts) -> RenderOpts {
        user_opts.clone()
    }
}

pub fn format_sql(
    dialect: &dyn Dialect,
    sql: &str,
    opts: &RenderOpts,
) -> Result<String, SqlfmtError> {
    // Let the dialect enforce any required render options (e.g., keyword case).
    let opts = dialect.apply_render_opts(opts);

    // Transparently decode base64 / gzip before parsing. If no preprocessor
    // matches, the input passes through unchanged.
    let (sql, _steps) = preprocess(sql.as_bytes(), DEFAULT_PREPROCESSORS);
    let node = dialect.parse(&sql)?;
    let rendered = opts.render(&node)?;

    // Round-trip test to make sure we didn't drop any AST nodes during convert.
    dialect.ast_equal(&sql, &rendered)?;
    Ok(rendered)
}
