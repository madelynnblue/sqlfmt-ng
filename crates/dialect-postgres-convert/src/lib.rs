mod convert;

pub mod protobuf {
    include!(concat!(env!("OUT_DIR"), "/pg_query.rs"));
}

use prost::Message;
use sqlfmt_core::SqlfmtError;
use sqlfmt_ir::Node;

/// Convert raw pg_query protobuf bytes into a sqlfmt IR Node.
/// The bytes must be the protobuf-encoded ParseResult that libpg_query / pg_query.js produces.
pub fn convert_protobuf_bytes(bytes: &[u8]) -> Result<Node, SqlfmtError> {
    let parse_result = protobuf::ParseResult::decode(bytes)
        .map_err(|e| SqlfmtError::Parse(format!("protobuf decode error: {e}")))?;
    let stmts = &parse_result.stmts;
    if stmts.is_empty() {
        return Err(SqlfmtError::Parse("empty statement list".into()));
    }

    let mut clauses = Vec::new();
    for raw in stmts {
        match convert::raw_stmt_to_node(raw) {
            Some(Node::Clauses { items }) => clauses.extend(items),
            Some(_) => {
                return Err(SqlfmtError::Parse(
                    "unexpected non-clauses top-level node".into(),
                ));
            }
            None => return Err(SqlfmtError::Parse("unsupported statement type".into())),
        }
    }
    Ok(Node::Clauses { items: clauses })
}

#[cfg(test)]
mod tests {
    use super::*;

    fn parse_bytes(sql: &str) -> Vec<u8> {
        // Use pg_query (available as a dev-dep or in tests via the native build).
        // We encode the parsed protobuf back to bytes to exercise convert_protobuf_bytes.
        // This is only used in tests; the runtime path comes from pg_query.js or dialect-postgres.
        use prost::Message;
        let parsed = pg_query::parse(sql).expect("pg_query parse failed");
        parsed.protobuf.encode_to_vec()
    }

    #[test]
    fn test_simple_select() {
        let bytes = parse_bytes("SELECT 1");
        let node = convert_protobuf_bytes(&bytes).unwrap();
        assert!(matches!(node, Node::Clauses { .. }));
    }

    #[test]
    fn test_select_with_where() {
        use sqlfmt_render::RenderOpts;
        use sqlfmt_render::render;
        let bytes = parse_bytes("SELECT a, b FROM t WHERE x = 1");
        let node = convert_protobuf_bytes(&bytes).unwrap();
        let opts = RenderOpts {
            line_width: 1000,
            ..Default::default()
        };
        let out = render(&node, &opts);
        assert!(out.contains("SELECT"), "got: {out}");
        assert!(out.contains("FROM"), "got: {out}");
        assert!(out.contains("WHERE"), "got: {out}");
    }

    #[test]
    fn test_invalid_bytes() {
        assert!(convert_protobuf_bytes(b"not valid protobuf").is_err());
    }
}
