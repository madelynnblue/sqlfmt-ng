use dialect_graphviz::GraphvizDialect;
use dialect_json::JsonDialect;
use dialect_materialize::MaterializeDialect;
use dialect_postgres_convert::{convert_pg_query_json, json_ast_equal};
use sqlfmt_core::{format_sql, preprocess_sql, render_node, Dialect};
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

fn resolve_dialect(dialect: &str) -> Option<&'static dyn Dialect> {
    match dialect {
        "graphviz" => Some(&GraphvizDialect),
        "json" => Some(&JsonDialect),
        "materialize" | "" => Some(&MaterializeDialect),
        _ => None,
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
    let d = resolve_dialect(dialect)
        .ok_or_else(|| JsValue::from_str(&format!("unknown dialect: {dialect}")))?;
    format_sql(d, sql, &opts).map_err(|e| JsValue::from_str(&e.to_string()))
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
    dialect: &str,
    width: usize,
    tab_width: usize,
    use_tabs: bool,
    case: &str,
) -> Result<String, JsValue> {
    let node: sqlfmt_ir::Node = serde_json::from_str(ir_json)
        .map_err(|e| JsValue::from_str(&format!("invalid IR JSON: {e}")))?;
    let user_opts = parse_opts(width, tab_width, use_tabs, case);
    let d = resolve_dialect(dialect)
        .ok_or_else(|| JsValue::from_str(&format!("unknown dialect: {dialect}")))?;
    render_node(d, &node, &user_opts)
        .map_err(|err| JsValue::from_str(&err.to_string()))
}

/// Parse SQL/JSON into a sqlfmt IR node and return it as a JSON string.
/// Used for validating input and caching the parse result so that option
/// changes (width, tabs, case) can re-render without re-parsing.
#[wasm_bindgen]
pub fn parse_to_ir(sql: &str, dialect: &str) -> Result<String, JsValue> {
    // Apply preprocessing (base64, gzip) transparently before parsing.
    let sql = preprocess_sql(sql);
    let d = resolve_dialect(dialect)
        .ok_or_else(|| JsValue::from_str(&format!("unknown dialect: {dialect}")))?;
    let node = d.parse(&sql).map_err(|e| JsValue::from_str(&e.to_string()))?;
    serde_json::to_string(&node).map_err(|e| JsValue::from_str(&e.to_string()))
}

/// Check that formatting produced a semantically equivalent AST.
/// Only needed after text changes; option re-renders skip this.
#[wasm_bindgen]
pub fn check_roundtrip(original: &str, rendered: &str, dialect: &str) -> Result<(), JsValue> {
    // Preprocess the original before comparing ASTs — the parsed IR was
    // created from the preprocessed text, so the roundtrip check must
    // use the same decoded input.
    let original = preprocess_sql(original);
    let d = resolve_dialect(dialect)
        .ok_or_else(|| JsValue::from_str(&format!("unknown dialect: {dialect}")))?;
    d.ast_equal(&original, rendered)
        .map_err(|e| JsValue::from_str(&e.to_string()))
}
