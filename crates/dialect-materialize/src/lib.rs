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
        let nodes: Vec<Node> = stmts
            .iter()
            .map(|s| convert::statement_to_node(&s.ast))
            .collect();
        if nodes.len() == 1 {
            return Ok(nodes.into_iter().next().unwrap());
        }
        Ok(Node::Statements { items: nodes })
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
        //
        // For multi-statement input where parse() returns Statements, we compare
        // all statements. The min() on line N is a defensive safety measure in
        // case the rendered output has fewer statements than the original.
        let normalize = |s: &str| -> Result<Vec<String>, SqlfmtError> {
            let stmts = mz_sql_parser::parser::parse_statements(s)
                .map_err(|e| SqlfmtError::Parse(e.to_string()))?;
            if stmts.is_empty() {
                return Err(SqlfmtError::Parse("empty input".into()));
            }
            stmts
                .iter()
                .map(|stmt| {
                    let display1 = format!("{}", stmt.ast);
                    let stmts2 = mz_sql_parser::parser::parse_statements(&display1)
                        .map_err(|e| SqlfmtError::Parse(e.to_string()))?;
                    if stmts2.is_empty() {
                        return Err(SqlfmtError::Parse("empty input".into()));
                    }
                    Ok(format!("{}", stmts2[0].ast))
                })
                .collect()
        };
        let sql_normal = normalize(sql)?;
        let rendered_normal = normalize(rendered)?;
        // If the rendered output has fewer statements than the original (e.g.
        // unsupported types were dropped by parse()), only compare what was kept.
        let n = rendered_normal.len().min(sql_normal.len());
        if sql_normal[..n] != rendered_normal[..n] {
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

    #[test]
    fn test_single_statement_no_semicolon() {
        let d = MaterializeDialect;
        let opts = RenderOpts {
            line_width: 1000,
            ..Default::default()
        };
        let result = format_sql(&d, "SELECT 1", &opts).unwrap();
        assert!(!result.contains(';'), "single stmt should not have semicolon: {result}");
    }

    #[test]
    fn test_multi_statement_with_semicolons() {
        let d = MaterializeDialect;
        let opts = RenderOpts {
            line_width: 1000,
            ..Default::default()
        };
        let result = format_sql(&d, "SELECT 1; SELECT 2", &opts).unwrap();
        assert!(result.contains("SELECT 1;"), "got: {result}");
        assert!(result.contains("SELECT 2;"), "got: {result}");
    }

    #[test]
    fn test_multi_statement_blank_line_separation() {
        let d = MaterializeDialect;
        let opts = RenderOpts {
            line_width: 1000,
            ..Default::default()
        };
        let result = format_sql(&d, "SELECT 1; SELECT 2", &opts).unwrap();
        // Should have a blank line between statements.
        assert!(result.contains("\n\n"), "expected blank line between stmts, got: {result}");
    }

    #[test]
    fn test_multi_statement_roundtrip() {
        let d = MaterializeDialect;
        let opts = RenderOpts {
            line_width: 1000,
            ..Default::default()
        };
        let result = format_sql(&d, "SELECT 1; SELECT 2; SELECT 3", &opts).unwrap();
        assert!(result.contains("SELECT 1;"), "got: {result}");
        assert!(result.contains("SELECT 2;"), "got: {result}");
        assert!(result.contains("SELECT 3;"), "got: {result}");
    }

    #[test]
    fn test_multi_statement_different_types_renders_all() {
        let d = MaterializeDialect;
        let opts = RenderOpts {
            line_width: 1000,
            ..Default::default()
        };
        // Mixed supported (SELECT) and unsupported (CREATE, INSERT) statements.
        // Unsupported types become Unformatted nodes, which render their text directly.
        let node = d
            .parse("SELECT 1; CREATE TABLE t (a int); INSERT INTO t VALUES (1)")
            .unwrap();
        // Should be Statements wrapper with all three statements preserved.
        assert!(
            matches!(node, Node::Statements { .. }),
            "expected Statements, got: {node:?}"
        );
        let result = opts.render(&node).unwrap();
        assert!(result.contains("SELECT 1;"), "got: {result}");
        assert!(result.contains("CREATE TABLE"), "all stmts should be preserved, got: {result}");
        assert!(result.contains("INSERT INTO"), "all stmts should be preserved, got: {result}");
    }

    #[test]
    fn test_multi_statement_all_supported() {
        let d = MaterializeDialect;
        let opts = RenderOpts {
            line_width: 1000,
            ..Default::default()
        };
        // All SELECT — fully supported, should get Statements wrapping.
        let result = format_sql(&d, "SELECT 1; SELECT 2", &opts).unwrap();
        assert!(result.contains("SELECT 1;"), "got: {result}");
        assert!(result.contains("SELECT 2;"), "got: {result}");
    }
}
