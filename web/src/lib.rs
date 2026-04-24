use dialect_materialize::MaterializeDialect;
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
/// dialect: "materialize" (postgres and others are not available natively in WASM;
///          use fmt_from_ir with a JS-side parser instead).
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
            "dialect '{other}' requires a JS-side parser; use fmt_from_ir instead"
        ))),
    }
}

/// Render pre-parsed SQL from a sqlfmt IR JSON string.
/// Use this for dialects whose parsers are not compiled into this WASM module
/// (e.g. Postgres via pg_query.js): parse in JS, convert to IR JSON, call this.
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
