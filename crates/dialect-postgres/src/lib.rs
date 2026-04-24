use dialect_postgres_convert::convert_protobuf_bytes;
use prost::Message;
use sqlfmt_core::{Dialect, SqlfmtError};
use sqlfmt_ir::Node;

pub struct PostgresDialect;

impl Dialect for PostgresDialect {
    fn parse(&self, sql: &str) -> Result<Node, SqlfmtError> {
        let result = pg_query::parse(sql).map_err(|e| SqlfmtError::Parse(e.to_string()))?;
        let bytes = result.protobuf.encode_to_vec();
        convert_protobuf_bytes(&bytes)
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
