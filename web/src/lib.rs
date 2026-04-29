use dialect_materialize::MaterializeDialect;
use dialect_postgres_convert::{convert_pg_query_json, json_ast_equal};
use sqlfmt_core::format_sql;
use sqlfmt_render::{CaseMode, RenderOpts};
use wasm_bindgen::prelude::*;

fn parse_opts(width: usize, tab_width: usize, use_tabs: bool, case: &str) -> RenderOpts {
    RenderOpts {
        line_width: width,
        use_tabs,
        tab_width,
        case: match case {
            "lower" => CaseMode::Lower,
            "title" => CaseMode::Title,
            _ => CaseMode::Upper,
        },
        error_on_unformatted: false,
    }
}

/// Format SQL using a native dialect parser.
/// dialect: "materialize".
#[wasm_bindgen]
pub fn fmt(
    sql: &str,
    dialect: &str,
    width: usize,
    tab_width: usize,
    use_tabs: bool,
    case: &str,
) -> Result<String, JsValue> {
    let opts = parse_opts(width, tab_width, use_tabs, case);
    match dialect {
        "materialize" | "" => format_sql(&MaterializeDialect, sql, &opts)
            .map_err(|e| JsValue::from_str(&e.to_string())),
        other => Err(JsValue::from_str(&format!(
            "dialect '{other}' requires a JS-side parser"
        ))),
    }
}

/// Format a Postgres query from a pg-query-emscripten JSON parse tree.
/// Pass `JSON.stringify(result.parse_tree)` from `pg-query-emscripten`'s `parse()`.
#[wasm_bindgen]
pub fn fmt_postgres_json(
    parse_tree_json: &str,
    width: usize,
    tab_width: usize,
    use_tabs: bool,
    case: &str,
) -> Result<String, JsValue> {
    let node =
        convert_pg_query_json(parse_tree_json).map_err(|e| JsValue::from_str(&e.to_string()))?;
    let opts = parse_opts(width, tab_width, use_tabs, case);
    opts.render(&node)
        .map_err(|err| JsValue::from_str(&err.to_string()))
}

/// Compare two pg-query JSON parse trees for AST equality, ignoring location fields.
/// Pass `JSON.stringify(result.parse_tree)` for both arguments.
/// Returns true if the ASTs are structurally identical (modulo byte offsets).
#[wasm_bindgen]
pub fn pg_json_ast_equal(json1: &str, json2: &str) -> bool {
    json_ast_equal(json1, json2)
}

/// Render pre-parsed SQL from a sqlfmt IR JSON string.
/// For dialects whose JS parsers produce sqlfmt IR directly rather than pg_query protobuf.
#[wasm_bindgen]
pub fn fmt_from_ir(
    ir_json: &str,
    width: usize,
    tab_width: usize,
    use_tabs: bool,
    case: &str,
) -> Result<String, JsValue> {
    let node: sqlfmt_ir::Node = serde_json::from_str(ir_json)
        .map_err(|e| JsValue::from_str(&format!("invalid IR JSON: {e}")))?;
    let opts = parse_opts(width, tab_width, use_tabs, case);
    opts.render(&node)
        .map_err(|err| JsValue::from_str(&err.to_string()))
}
