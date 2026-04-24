mod json_convert;

pub use json_convert::{convert_pg_query_json, json_ast_equal};

#[cfg(test)]
mod tests {
    // Force pg_query to be linked so libpg_query.a is available for the FFI calls below.
    extern crate pg_query as _;

    use super::*;
    use sqlfmt_ir::Node;

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
        let json = unsafe { CStr::from_ptr(result.parse_tree) }
            .to_string_lossy()
            .to_string();
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
        use sqlfmt_render::{RenderOpts, render};
        let json = parse_to_json_c("SELECT a, b FROM t WHERE x = 1");
        let node = convert_pg_query_json(&json).unwrap();
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
    fn test_json_order_by() {
        use sqlfmt_render::{RenderOpts, render};
        let json = parse_to_json_c("SELECT a FROM t ORDER BY a DESC");
        let node = convert_pg_query_json(&json).unwrap();
        let opts = RenderOpts {
            line_width: 1000,
            ..Default::default()
        };
        let out = render(&node, &opts);
        assert!(out.contains("ORDER BY"), "got: {out}");
        assert!(out.contains("DESC"), "got: {out}");
    }

    #[test]
    fn test_json_invalid() {
        assert!(convert_pg_query_json("not json at all").is_err());
    }
}
