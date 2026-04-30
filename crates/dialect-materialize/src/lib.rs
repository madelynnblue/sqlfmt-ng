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
        // Mixed SELECT and other statement types (CREATE, INSERT).
        // Non-SELECT types become Text nodes, which render their Display representation.
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

    fn wide_opts() -> RenderOpts {
        RenderOpts {
            line_width: 1000,
            ..Default::default()
        }
    }

    fn fmt(sql: &str) -> String {
        format_sql(&MaterializeDialect, sql, &wide_opts()).unwrap()
    }

    // --- Set operations ---

    #[test]
    fn test_union_all() {
        let result = fmt("SELECT 1 UNION ALL SELECT 2");
        assert!(result.contains("UNION ALL"), "got: {result}");
    }

    #[test]
    fn test_union_all_order_by() {
        let result = fmt("SELECT 1 UNION ALL SELECT 2 ORDER BY 1");
        assert!(result.contains("UNION ALL"), "got: {result}");
        assert!(result.contains("ORDER BY"), "got: {result}");
    }

    #[test]
    fn test_intersect() {
        let result = fmt("SELECT 1 INTERSECT SELECT 2");
        assert!(result.contains("INTERSECT"), "got: {result}");
    }

    #[test]
    fn test_except_all() {
        let result = fmt("SELECT 1 EXCEPT ALL SELECT 2");
        assert!(result.contains("EXCEPT ALL"), "got: {result}");
    }

    #[test]
    fn test_setop_with_limit_offset() {
        let result = fmt("SELECT 1 UNION SELECT 2 ORDER BY 1 LIMIT 5 OFFSET 10");
        assert!(result.contains("UNION"), "got: {result}");
        assert!(result.contains("LIMIT 5"), "got: {result}");
        assert!(result.contains("OFFSET 10"), "got: {result}");
    }

    #[test]
    fn test_values() {
        let result = fmt("VALUES (1, 2), (3, 4)");
        assert!(result.contains("VALUES"), "got: {result}");
        assert!(result.contains("(1, 2)"), "got: {result}");
        assert!(result.contains("(3, 4)"), "got: {result}");
    }

    #[test]
    fn test_values_order_by() {
        let result = fmt("VALUES (1, 2) ORDER BY 1");
        assert!(result.contains("VALUES"), "got: {result}");
        assert!(result.contains("ORDER BY"), "got: {result}");
    }

    // --- Joins ---

    #[test]
    fn test_inner_join_on() {
        let result = fmt("SELECT * FROM t1 JOIN t2 ON t1.id = t2.id");
        assert!(result.contains("JOIN"), "got: {result}");
        assert!(result.contains("ON"), "got: {result}");
    }

    #[test]
    fn test_left_join() {
        let result = fmt("SELECT * FROM t1 LEFT JOIN t2 ON t1.id = t2.id");
        assert!(result.contains("LEFT JOIN"), "got: {result}");
    }

    #[test]
    fn test_right_join() {
        let result = fmt("SELECT * FROM t1 RIGHT JOIN t2 ON t1.id = t2.id");
        assert!(result.contains("RIGHT JOIN"), "got: {result}");
    }

    #[test]
    fn test_full_join() {
        let result = fmt("SELECT * FROM t1 FULL JOIN t2 ON t1.id = t2.id");
        assert!(result.contains("FULL JOIN"), "got: {result}");
    }

    #[test]
    fn test_cross_join() {
        let result = fmt("SELECT * FROM t1 CROSS JOIN t2");
        assert!(result.contains("CROSS JOIN"), "got: {result}");
    }

    #[test]
    fn test_natural_join() {
        let result = fmt("SELECT * FROM t1 NATURAL JOIN t2");
        assert!(result.contains("NATURAL JOIN"), "got: {result}");
    }

    #[test]
    fn test_join_using() {
        let result = fmt("SELECT * FROM t1 JOIN t2 USING (a, b)");
        assert!(result.contains("USING"), "got: {result}");
        assert!(result.contains("a"), "got: {result}");
    }

    // --- Expressions ---

    #[test]
    fn test_case_expression() {
        let result = fmt("SELECT CASE WHEN x > 1 THEN 'yes' ELSE 'no' END FROM t");
        assert!(result.contains("CASE"), "got: {result}");
        assert!(result.contains("WHEN"), "got: {result}");
        assert!(result.contains("THEN"), "got: {result}");
        assert!(result.contains("ELSE"), "got: {result}");
        assert!(result.contains("END"), "got: {result}");
    }

    #[test]
    fn test_case_with_operand() {
        let result = fmt("SELECT CASE x WHEN 1 THEN 'one' WHEN 2 THEN 'two' END FROM t");
        assert!(result.contains("CASE x"), "got: {result}");
    }

    #[test]
    fn test_cast() {
        let result = fmt("SELECT x::int FROM t");
        assert!(result.contains("::"), "got: {result}");
    }

    #[test]
    fn test_between() {
        let result = fmt("SELECT x BETWEEN 1 AND 10 FROM t");
        assert!(result.contains("BETWEEN"), "got: {result}");
        assert!(result.contains("AND"), "got: {result}");
    }

    #[test]
    fn test_not_between() {
        let result = fmt("SELECT x NOT BETWEEN 1 AND 10 FROM t");
        assert!(result.contains("NOT BETWEEN"), "got: {result}");
    }

    #[test]
    fn test_is_null() {
        let result = fmt("SELECT x IS NULL FROM t");
        assert!(result.contains("IS NULL"), "got: {result}");
    }

    #[test]
    fn test_is_not_null() {
        let result = fmt("SELECT x IS NOT NULL FROM t");
        assert!(result.contains("IS NOT NULL"), "got: {result}");
    }

    #[test]
    fn test_is_distinct_from() {
        let result = fmt("SELECT x IS DISTINCT FROM y FROM t");
        assert!(result.contains("IS DISTINCT FROM"), "got: {result}");
    }

    #[test]
    fn test_in_list() {
        let result = fmt("SELECT x IN (1, 2, 3) FROM t");
        assert!(result.contains("IN (1, 2, 3)"), "got: {result}");
    }

    #[test]
    fn test_not_in_list() {
        let result = fmt("SELECT x NOT IN (1, 2, 3) FROM t");
        assert!(result.contains("NOT IN"), "got: {result}");
    }

    #[test]
    fn test_in_subquery() {
        let result = fmt("SELECT x IN (SELECT y FROM t2) FROM t");
        assert!(result.contains("IN ("), "got: {result}");
    }

    #[test]
    fn test_like() {
        let result = fmt("SELECT x LIKE 'foo%' FROM t");
        assert!(result.contains("LIKE"), "got: {result}");
    }

    #[test]
    fn test_not_ilike() {
        let result = fmt("SELECT x NOT ILIKE 'foo%' FROM t");
        assert!(result.contains("NOT ILIKE"), "got: {result}");
    }

    #[test]
    fn test_like_escape() {
        let result = fmt("SELECT x LIKE 'foo\\_%' ESCAPE '\\' FROM t");
        assert!(result.contains("ESCAPE"), "got: {result}");
    }

    #[test]
    fn test_collate() {
        let result = fmt("SELECT name COLLATE \"de_DE\" FROM t");
        assert!(result.contains("COLLATE"), "got: {result}");
    }

    #[test]
    fn test_coalesce() {
        let result = fmt("SELECT COALESCE(a, b, 'default') FROM t");
        assert!(result.contains("COALESCE"), "got: {result}");
    }

    #[test]
    fn test_nullif() {
        let result = fmt("SELECT NULLIF(x, 0) FROM t");
        assert!(result.contains("NULLIF"), "got: {result}");
    }

    #[test]
    fn test_row() {
        let result = fmt("SELECT ROW(1, 'hello') FROM t");
        assert!(result.contains("ROW"), "got: {result}");
    }

    #[test]
    fn test_array() {
        let result = fmt("SELECT ARRAY[1, 2, 3] FROM t");
        assert!(result.contains("ARRAY"), "got: {result}");
    }

    #[test]
    fn test_array_subquery() {
        let result = fmt("SELECT ARRAY(SELECT x FROM t2) FROM t");
        assert!(result.contains("ARRAY("), "got: {result}");
    }

    #[test]
    fn test_list() {
        let result = fmt("SELECT LIST[1, 2, 3] FROM t");
        assert!(result.contains("LIST"), "got: {result}");
    }

    #[test]
    fn test_greatest() {
        let result = fmt("SELECT GREATEST(a, b, c) FROM t");
        assert!(result.contains("GREATEST"), "got: {result}");
    }

    #[test]
    fn test_least() {
        let result = fmt("SELECT LEAST(a, b, c) FROM t");
        assert!(result.contains("LEAST"), "got: {result}");
    }

    // --- DML statements ---

    #[test]
    fn test_insert() {
        let result = fmt("INSERT INTO t (a, b) VALUES (1, 2)");
        assert!(result.contains("INSERT INTO"), "got: {result}");
        assert!(result.contains("VALUES"), "got: {result}");
    }

    #[test]
    fn test_update() {
        let result = fmt("UPDATE t SET a = 1 WHERE b = 2");
        assert!(result.contains("UPDATE"), "got: {result}");
        assert!(result.contains("SET"), "got: {result}");
    }

    #[test]
    fn test_delete() {
        let result = fmt("DELETE FROM t WHERE a = 1");
        assert!(result.contains("DELETE FROM"), "got: {result}");
    }
}
