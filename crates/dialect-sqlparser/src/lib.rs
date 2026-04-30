mod convert;

use sqlfmt_core::{Dialect, SqlfmtError};
use sqlfmt_ir::Node;

pub struct SqlparserDialect {
    inner: Box<dyn sqlparser::dialect::Dialect>,
}

impl SqlparserDialect {
    pub fn from_name(name: &str) -> Option<Self> {
        let inner = sqlparser::dialect::dialect_from_str(name)?;
        Some(Self { inner })
    }
}

impl Dialect for SqlparserDialect {
    fn parse(&self, sql: &str) -> Result<Node, SqlfmtError> {
        let stmts =
            sqlparser::parser::Parser::parse_sql(&*self.inner, sql)
                .map_err(|e| SqlfmtError::Parse(e.to_string()))?;
        convert::convert_statements(&stmts)
    }

    fn ast_equal(&self, sql: &str, rendered: &str) -> Result<(), SqlfmtError> {
        let sql_stmts =
            sqlparser::parser::Parser::parse_sql(&*self.inner, sql)
                .map_err(|e| SqlfmtError::Parse(e.to_string()))?;
        let rendered_stmts =
            sqlparser::parser::Parser::parse_sql(&*self.inner, rendered)
                .map_err(|e| SqlfmtError::Parse(e.to_string()))?;

        if sql_stmts != rendered_stmts {
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
    use sqlfmt_core::format_sql;
    use sqlfmt_render::RenderOpts;

    fn generic() -> SqlparserDialect {
        SqlparserDialect::from_name("generic").unwrap()
    }

    fn opts() -> RenderOpts {
        RenderOpts::default()
    }

    #[test]
    fn test_parse_simple_select() {
        let d = generic();
        let node = d.parse("SELECT 1").unwrap();
        assert!(matches!(node, Node::Clauses { .. }));
    }

    #[test]
    fn test_parse_error() {
        let d = generic();
        let result = d.parse("NOT VALID SQL !!!");
        assert!(result.is_err());
    }

    #[test]
    fn test_select_roundtrip() {
        let d = generic();
        let result = format_sql(&d, "SELECT a, b FROM t WHERE x = 1", &opts());
        assert!(result.is_ok());
    }

    #[test]
    fn test_select_with_alias() {
        let d = generic();
        let result = format_sql(
            &d,
            "SELECT a AS col_a, b AS col_b FROM t",
            &opts(),
        );
        assert!(result.is_ok());
    }

    #[test]
    fn test_function_roundtrip() {
        let d = generic();
        let result = format_sql(&d, "SELECT COUNT(a) FROM t", &opts());
        assert!(result.is_ok());
    }

    #[test]
    fn test_subquery_roundtrip() {
        let d = generic();
        let result = format_sql(
            &d,
            "SELECT * FROM t WHERE x IN (SELECT y FROM u)",
            &opts(),
        );
        assert!(result.is_ok());
    }

    #[test]
    fn test_union_roundtrip() {
        let d = generic();
        let result = format_sql(&d, "SELECT a FROM t UNION SELECT b FROM u", &opts());
        assert!(result.is_ok());
    }

    #[test]
    fn test_cte_roundtrip() {
        let d = generic();
        let result = format_sql(
            &d,
            "WITH cte AS (SELECT a FROM foo) SELECT * FROM cte",
            &opts(),
        );
        assert!(result.is_ok());
    }

    #[test]
    fn test_multi_statement() {
        let d = generic();
        let result = format_sql(&d, "SELECT 1; SELECT 2", &opts());
        assert!(result.is_ok());
        let formatted = result.unwrap();
        // Should contain a blank line between statements
        assert!(formatted.contains("\n\n"));
    }

    #[test]
    fn test_unformatted_fallback() {
        let d = generic();
        // CREATE TABLE is not implemented yet, falls to Unformatted
        let result = format_sql(&d, "CREATE TABLE foo (a INT)", &opts());
        assert!(result.is_ok());
    }

    #[test]
    fn test_postgresql_dialect() {
        let d = SqlparserDialect::from_name("postgresql").unwrap();
        let result = format_sql(&d, "SELECT * FROM t", &opts());
        assert!(result.is_ok());
    }

    #[test]
    fn test_mysql_dialect() {
        let d = SqlparserDialect::from_name("mysql").unwrap();
        let result = format_sql(&d, "SELECT * FROM t", &opts());
        assert!(result.is_ok());
    }

    #[test]
    fn test_sqlite_dialect() {
        let d = SqlparserDialect::from_name("sqlite").unwrap();
        let result = format_sql(&d, "SELECT * FROM t", &opts());
        assert!(result.is_ok());
    }

    #[test]
    fn test_from_name_invalid() {
        assert!(SqlparserDialect::from_name("nonexistent").is_none());
    }

    #[test]
    fn test_roundtrip_detects_diff() {
        let d = generic();
        // Re-parse "SELECT 1" vs "SELECT 2" — these differ semantically
        let err = d
            .ast_equal("SELECT 1", "SELECT 2")
            .expect_err("should detect AST difference");
        assert!(matches!(err, SqlfmtError::Roundtrip { .. }));
    }
}
