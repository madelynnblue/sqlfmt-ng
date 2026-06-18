pub use sqlfmt_error::SqlfmtError;
use sqlfmt_ir::Node;
use sqlfmt_render::RenderOpts;

mod preprocess;
use preprocess::{preprocess, DEFAULT_PREPROCESSORS};

/// Apply preprocessing (base64, gzip) to raw input before parsing.
/// Returns the decoded text. If no preprocessor matches, the input
/// passes through unchanged.
pub fn preprocess_sql(input: &str) -> String {
    preprocess(input.as_bytes(), DEFAULT_PREPROCESSORS).0
}

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

/// Render an IR node to a formatted string, applying dialect-specific
/// option overrides (e.g. keyword case). Callers that bypass [`format_sql`]
/// can use this to stay consistent with the full pipeline.
pub fn render_node(
    dialect: &dyn Dialect,
    node: &Node,
    user_opts: &RenderOpts,
) -> Result<String, SqlfmtError> {
    let opts = dialect.apply_render_opts(user_opts);
    opts.render(node)
}

pub fn format_sql(
    dialect: &dyn Dialect,
    sql: &str,
    opts: &RenderOpts,
) -> Result<String, SqlfmtError> {
    // Transparently decode base64 / gzip before parsing. If no preprocessor
    // matches, the input passes through unchanged.
    let sql = preprocess_sql(sql);
    let node = dialect.parse(&sql)?;
    let rendered = render_node(dialect, &node, opts)?;

    // Round-trip test to make sure we didn't drop any AST nodes during convert.
    dialect.ast_equal(&sql, &rendered)?;
    Ok(rendered)
}
