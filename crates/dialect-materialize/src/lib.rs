mod convert;

use sqlfmt_core::{Dialect, SqlfmtError};
use sqlfmt_ir::Node;

pub struct MaterializeDialect;

impl Dialect for MaterializeDialect {
    fn parse(&self, sql: &str) -> Result<Node, SqlfmtError> {
        let stmts = mz_sql_parser::parser::parse_statements(sql)
            .map_err(|e| SqlfmtError::Parse(e.to_string()))?;
        if stmts.is_empty() {
            return Err(SqlfmtError::Parse("empty input".into()));
        }
        Ok(convert::statement_to_node(&stmts[0].ast))
    }

    fn ast_equal(&self, sql: &str, rendered: &str) -> Result<(), SqlfmtError> {
        let sql_stmts = mz_sql_parser::parser::parse_statements(sql)
            .map_err(|e| SqlfmtError::Parse(e.to_string()))?;
        let rendered_stmts = mz_sql_parser::parser::parse_statements(rendered)
            .map_err(|e| SqlfmtError::Parse(e.to_string()))?;
        if sql_stmts.is_empty() || rendered_stmts.is_empty() {
            return Err(SqlfmtError::Parse("empty input".into()));
        }
        // Compare canonical Display output rather than structural PartialEq.
        // DeclareStatement and PrepareStatement store the original raw SQL in a
        // `sql: String` field included in their PartialEq, so whitespace-only
        // reformatting (e.g. `1/a` → `1 / a`) would cause spurious failures.
        // Display ignores that field and writes only the semantic AST.
        let sql_display = format!("{}", sql_stmts[0].ast);
        let rendered_display = format!("{}", rendered_stmts[0].ast);
        if sql_display != rendered_display {
            return Err(SqlfmtError::Roundtrip {
                input: sql.to_owned(),
                output: rendered.to_owned(),
            });
        }
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use sqlfmt_core::{Dialect, format_sql};
    use sqlfmt_render::RenderOpts;

    #[test]
    fn test_parse_simple_select() {
        let d = MaterializeDialect;
        let result = d.parse("SELECT 1");
        assert!(result.is_ok(), "parse failed: {:?}", result);
        assert!(matches!(result.unwrap(), sqlfmt_ir::Node::Clauses { .. }));
    }

    #[test]
    fn test_parse_error_returns_err() {
        let d = MaterializeDialect;
        assert!(d.parse("NOT VALID SQL @@@@").is_err());
    }

    #[test]
    fn test_format_select_with_where() {
        let d = MaterializeDialect;
        let opts = RenderOpts {
            line_width: 1000,
            ..Default::default()
        };
        let result = format_sql(&d, "SELECT a, b FROM t WHERE x = 1", &opts).unwrap();
        assert!(result.contains("SELECT"), "got: {result}");
        assert!(result.contains("FROM"), "got: {result}");
        assert!(result.contains("WHERE"), "got: {result}");
    }
}
