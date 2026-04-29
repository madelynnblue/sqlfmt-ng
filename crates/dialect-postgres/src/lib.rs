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
    fn test_any_subquery_roundtrip() {
        // = ANY(subquery) should render as = ANY(subquery), not be rewritten to IN.
        let d = PostgresDialect;
        let opts = RenderOpts {
            line_width: 1000,
            ..Default::default()
        };
        let result = format_sql(&d, "SELECT 1 = ANY(SELECT 1)", &opts);
        assert!(result.is_ok(), "roundtrip failed: {:?}", result);
        assert!(
            result.unwrap().contains("= ANY"),
            "should preserve = ANY, not convert to IN"
        );
    }

    #[test]
    fn test_diag_json() {
        let cases = [
            // Column operations
            "ALTER TABLE t ADD COLUMN x int",
            "ALTER TABLE t DROP COLUMN x",
            "ALTER TABLE t DROP COLUMN IF EXISTS x",
            "ALTER TABLE t ALTER COLUMN x SET NOT NULL",
            "ALTER TABLE t ALTER COLUMN x DROP NOT NULL",
            "ALTER TABLE t ALTER COLUMN x SET DEFAULT 42",
            "ALTER TABLE t ALTER COLUMN x DROP DEFAULT",
            "ALTER TABLE t ALTER COLUMN x TYPE text",
            // Constraint operations
            "ALTER TABLE t ADD CONSTRAINT pk PRIMARY KEY (a)",
            "ALTER TABLE t ADD CONSTRAINT uniq UNIQUE (a, b)",
            "ALTER TABLE t ADD CONSTRAINT fk FOREIGN KEY (a) REFERENCES other (id)",
            "ALTER TABLE t DROP CONSTRAINT pk",
            "ALTER TABLE t DROP CONSTRAINT IF EXISTS pk",
            // Tblspc / owner etc
            "ALTER TABLE t SET TABLESPACE myspace",
            "ALTER TABLE t OWNER TO newuser",
            // SET without / with OIDS
            "ALTER TABLE t SET WITHOUT OIDS",
            "ALTER TABLE t SET (autovacuum_enabled = true)",
            "ALTER TABLE t RESET (autovacuum_enabled)",
            // INHERIT
            "ALTER TABLE t INHERIT parent",
            "ALTER TABLE t NO INHERIT parent",
            // RENAME
            "ALTER TABLE t RENAME COLUMN a TO b",
        ];
        for sql in &cases {
            println!("\n=== {} ===", sql);
            match pg_query_parse_json(sql) {
                Ok(j) => println!("{}", j),
                Err(e) => println!("ERROR: {}", e),
            }
        }
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
