mod convert;

use sqlfmt_core::{Dialect, SqlfmtError};
use sqlfmt_ir::Node;

pub struct PostgresDialect;

impl Dialect for PostgresDialect {
    fn parse(&self, sql: &str) -> Result<Node, SqlfmtError> {
        let result = pg_query::parse(sql).map_err(|e| SqlfmtError::Parse(e.to_string()))?;
        let stmts = &result.protobuf.stmts;
        if stmts.is_empty() {
            return Err(SqlfmtError::Parse("empty statement list".into()));
        }
        // Convert each top-level statement, then join as clauses.
        let mut clauses = Vec::new();
        for raw in stmts {
            if let Some(node) = convert::raw_stmt_to_node(raw) {
                match node {
                    Node::Clauses { items } => clauses.extend(items),
                    other => clauses.push(sqlfmt_ir::Clause {
                        keyword: String::new(),
                        body: Some(Box::new(other)),
                    }),
                }
            } else {
                return Err(SqlfmtError::Parse(
                    "unsupported or empty statement".into(),
                ));
            }
        }
        Ok(Node::Clauses { items: clauses })
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use sqlfmt_core::{format_sql, Dialect};
    use sqlfmt_render::RenderOpts;

    #[test]
    fn test_parse_simple_select() {
        let d = PostgresDialect;
        let result = d.parse("SELECT 1");
        assert!(result.is_ok(), "parse failed: {:?}", result);
        assert!(matches!(result.unwrap(), Node::Clauses { .. }));
    }

    #[test]
    fn test_parse_error() {
        let d = PostgresDialect;
        assert!(d.parse("NOT VALID SQL @@@@").is_err());
    }

    #[test]
    fn test_format_select_where() {
        let d = PostgresDialect;
        let opts = RenderOpts { line_width: 1000, ..Default::default() };
        let result = format_sql(&d, "SELECT a, b FROM t WHERE x = 1", &opts).unwrap();
        assert!(result.contains("SELECT"), "got: {result}");
        assert!(result.contains("FROM"), "got: {result}");
        assert!(result.contains("WHERE"), "got: {result}");
    }
}
