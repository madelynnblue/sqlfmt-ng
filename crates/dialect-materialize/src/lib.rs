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
        // Compare canonical Display output rather than structural PartialEq.
        // DeclareStatement and PrepareStatement store the original raw SQL in a
        // `sql: String` field included in their PartialEq, so whitespace-only
        // reformatting (e.g. `1/a` → `1 / a`) would cause spurious failures.
        // Display ignores that field and writes only the semantic AST.
        //
        // We also apply a second parse+display cycle before comparing. The mz
        // parser has a non-idempotent Display for the `"char"` type: `"char"`
        // displays as `char`, but `char` re-parses as `bpchar`. The double cycle
        // stabilizes both sides to the fully-normalized form, preventing false
        // round-trip failures caused by this parser bug.
        let normalize = |s: &str| -> Result<String, SqlfmtError> {
            let stmts = mz_sql_parser::parser::parse_statements(s)
                .map_err(|e| SqlfmtError::Parse(e.to_string()))?;
            if stmts.is_empty() {
                return Err(SqlfmtError::Parse("empty input".into()));
            }
            let display1 = format!("{}", stmts[0].ast);
            let stmts2 = mz_sql_parser::parser::parse_statements(&display1)
                .map_err(|e| SqlfmtError::Parse(e.to_string()))?;
            if stmts2.is_empty() {
                return Err(SqlfmtError::Parse("empty input".into()));
            }
            Ok(format!("{}", stmts2[0].ast))
        };
        let sql_normal = normalize(sql)?;
        let rendered_normal = normalize(rendered)?;
        if sql_normal != rendered_normal {
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
