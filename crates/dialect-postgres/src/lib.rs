// Force the pg_query crate to be linked so libpg_query.a is available for the
// extern "C" symbols below.
extern crate pg_query as _;

use std::ffi::{CStr, CString};
use std::os::raw::c_char;

use dialect_postgres_convert::convert_pg_query_json;
use sqlfmt_core::{Dialect, SqlfmtError};
use sqlfmt_ir::Node;

pub struct PostgresDialect;

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

fn pg_query_parse_json(sql: &str) -> Result<String, SqlfmtError> {
    let input = CString::new(sql).map_err(|e| SqlfmtError::Parse(e.to_string()))?;
    let result = unsafe { pg_query_parse(input.as_ptr()) };
    if !result.error.is_null() {
        let msg = unsafe { CStr::from_ptr((*result.error).message) }
            .to_string_lossy()
            .to_string();
        unsafe { pg_query_free_parse_result(result) };
        return Err(SqlfmtError::Parse(msg));
    }
    let json = unsafe { CStr::from_ptr(result.parse_tree) }
        .to_string_lossy()
        .to_string();
    unsafe { pg_query_free_parse_result(result) };
    Ok(json)
}

impl Dialect for PostgresDialect {
    fn parse(&self, sql: &str) -> Result<Node, SqlfmtError> {
        let json = pg_query_parse_json(sql)?;
        convert_pg_query_json(&json)
    }

    fn ast_equal(&self, sql: &str, rendered: &str) -> Result<(), SqlfmtError> {
        let sql_json = pg_query_parse_json(sql)?;
        let rendered_json = pg_query_parse_json(rendered)?;
        if !dialect_postgres_convert::json_ast_equal(&sql_json, &rendered_json) {
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
    fn test_roundtrip_dml_in_cte() {
        let d = PostgresDialect;
        let opts = RenderOpts {
            line_width: 1000,
            ..Default::default()
        };
        let result = format_sql(
            &d,
            "SELECT (WITH foo AS (INSERT INTO y VALUES (1) RETURNING *) SELECT * FROM foo)",
            &opts,
        );
        assert!(result.is_ok(), "roundtrip failed: {:?}", result);
    }

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
    fn test_format_roundtrip() {
        let d = PostgresDialect;
        let opts = RenderOpts {
            line_width: 1000,
            ..Default::default()
        };
        let result = format_sql(&d, "SELECT a, b FROM t WHERE x = 1 ORDER BY a DESC", &opts);
        assert!(result.is_ok(), "roundtrip failed: {:?}", result);
    }

    #[test]
    fn test_format_select_where() {
        let d = PostgresDialect;
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
