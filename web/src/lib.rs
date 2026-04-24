use dialect_materialize::MaterializeDialect;
use dialect_postgres_convert::convert_protobuf_bytes;
use sqlfmt_core::format_sql;
use sqlfmt_render::{render, CaseMode, RenderOpts};
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
    }
}

/// Format SQL using a native dialect parser.
/// dialect: "materialize" (postgres uses fmt_postgres_protobuf instead).
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
            "dialect '{other}' requires a JS-side parser; use fmt_postgres_protobuf instead"
        ))),
    }
}

/// Format a Postgres query from raw pg_query protobuf bytes.
/// Call pg_query.js in JavaScript to get the bytes, then pass them here.
/// The bytes must be the raw protobuf-encoded ParseResult from libpg_query.
#[wasm_bindgen]
pub fn fmt_postgres_protobuf(
    protobuf_bytes: &[u8],
    width: usize,
    tab_width: usize,
    use_tabs: bool,
    case: &str,
) -> Result<String, JsValue> {
    let node = convert_protobuf_bytes(protobuf_bytes)
        .map_err(|e| JsValue::from_str(&e.to_string()))?;
    let opts = parse_opts(width, tab_width, use_tabs, case);
    Ok(render(&node, &opts))
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
    Ok(render(&node, &opts))
}
