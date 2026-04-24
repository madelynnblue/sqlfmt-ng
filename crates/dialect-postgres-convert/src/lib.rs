mod convert;
mod json_convert;

pub use json_convert::convert_pg_query_json;

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

    // Call the C library's pg_query_parse which returns the JSON parse tree.
    // This is the same function used by pg-query-emscripten, so the format matches.
    fn parse_to_json_c(sql: &str) -> String {
        use std::ffi::{CStr, CString};
        use std::os::raw::c_char;

        #[repr(C)]
        struct PgQueryError {
            message: *mut c_char,
            _funcname: *mut c_char,
            _filename: *mut c_char,
            _lineno: i32,
            _cursorpos: i32,
            _context: *mut c_char,
        }

        #[repr(C)]
        struct PgQueryParseResult {
            parse_tree: *mut c_char,
            _stderr_buffer: *mut c_char,
            error: *mut PgQueryError,
        }

        unsafe extern "C" {
            fn pg_query_parse(input: *const c_char) -> PgQueryParseResult;
            fn pg_query_free_parse_result(result: PgQueryParseResult);
        }

        let input = CString::new(sql).unwrap();
        let result = unsafe { pg_query_parse(input.as_ptr()) };
        assert!(result.error.is_null(), "pg_query_parse returned error");
        let json = unsafe { CStr::from_ptr(result.parse_tree) }.to_string_lossy().to_string();
        unsafe { pg_query_free_parse_result(result) };
        json
    }

    #[test]
    fn test_json_simple_select() {
        let json = parse_to_json_c("SELECT 1");
        let node = convert_pg_query_json(&json).unwrap();
        assert!(matches!(node, Node::Clauses { .. }));
    }

    #[test]
    fn test_json_select_with_where() {
        use sqlfmt_render::{render, RenderOpts};
        let json = parse_to_json_c("SELECT a, b FROM t WHERE x = 1");
        let node = convert_pg_query_json(&json).unwrap();
        let opts = RenderOpts { line_width: 1000, ..Default::default() };
        let out = render(&node, &opts);
        assert!(out.contains("SELECT"), "got: {out}");
        assert!(out.contains("FROM"), "got: {out}");
        assert!(out.contains("WHERE"), "got: {out}");
    }

    #[test]
    fn test_json_order_by() {
        use sqlfmt_render::{render, RenderOpts};
        let json = parse_to_json_c("SELECT a FROM t ORDER BY a DESC");
        let node = convert_pg_query_json(&json).unwrap();
        let opts = RenderOpts { line_width: 1000, ..Default::default() };
        let out = render(&node, &opts);
        assert!(out.contains("ORDER BY"), "got: {out}");
        assert!(out.contains("DESC"), "got: {out}");
    }

    #[test]
    fn test_json_invalid() {
        assert!(convert_pg_query_json("not json at all").is_err());
    }
}
