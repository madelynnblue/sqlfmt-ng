use dialect_materialize::MaterializeDialect;
use sqlfmt_core::format_sql;
use sqlfmt_render::{CaseMode, RenderOpts};
use wasm_bindgen::prelude::*;

/// Format SQL and return the formatted result.
///
/// - `dialect`: "materialize" (postgres requires C FFI, unsupported in WASM)
/// - `case`: "upper" | "lower" | "title"
#[wasm_bindgen]
pub fn fmt(
    sql: &str,
    dialect: &str,
    width: usize,
    tab_width: usize,
    use_tabs: bool,
    case: &str,
) -> Result<String, JsValue> {
    let opts = RenderOpts {
        line_width: width,
        use_tabs,
        tab_width,
        case: match case {
            "lower" => CaseMode::Lower,
            "title" => CaseMode::Title,
            _ => CaseMode::Upper,
        },
    };

    match dialect {
        "materialize" | "" => format_sql(&MaterializeDialect, sql, &opts)
            .map_err(|e| JsValue::from_str(&e.to_string())),
        other => Err(JsValue::from_str(&format!(
            "dialect '{other}' is not supported in the browser WASM build"
        ))),
    }
}
