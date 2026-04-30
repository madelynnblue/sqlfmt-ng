# JSON Dialect Design

**Date:** 2026-04-29

## Overview

Add a `dialect-json` crate that teaches sqlfmt to format JSON using the same Wadler-Lindig pretty-printing pipeline as the SQL dialects. JSON maps naturally onto the existing IR: scalars become `Literal` nodes, arrays and objects become `Wrap`+`List` nodes. Object keys are sorted alphabetically. `case` mode is ignored (JSON is case-sensitive; no `Keyword`/`Identifier` nodes are produced).

---

## Architecture

### New crate: `crates/dialect-json/`

Single file `src/lib.rs` — the conversion logic is simple enough that no `convert.rs` sub-module is needed.

**Dependencies:**
```toml
[dependencies]
sqlfmt-ir  = { path = "../sqlfmt-ir" }
sqlfmt-core = { path = "../sqlfmt-core" }
serde_json = "1"
```

`serde_json` is already in the workspace (used by `dialect-postgres-convert` and `sqlfmt-corpus-tests`).

---

## `Value` → `Node` Mapping

| JSON value | Node |
|---|---|
| `null` | `Literal { value: "null" }` |
| `true` / `false` | `Literal { value: "true" / "false" }` |
| number | `Literal { value: n.to_string() }` |
| string | `Literal { value: serde_json::to_string(&Value::String(s)) }` — uses serde_json for correct escape handling and quoting |
| array | `Wrap { keyword: None, open: "[", content: List { items: [...], separator: Some(",") }, close: "]" }` |
| object | `Wrap { keyword: None, open: "{", content: List { sorted_pairs, separator: Some(",") }, close: "}" }` |
| object key-value pair | `Concat { items: [key_literal, Text { value: ": " }, value_node] }` |

Object keys are sorted alphabetically before building nodes. The `Wrap`+`List` combination produces flat output when the content fits within `line_width`, or one-item-per-indented-line when it does not — the standard Wadler-Lindig behavior provided for free by the existing renderer.

---

## Trait Implementation

### `parse(input: &str) -> Result<Node, SqlfmtError>`

1. `serde_json::from_str(input)` — map parse error to `SqlfmtError::Parse`
2. Recursively convert `serde_json::Value` → `sqlfmt_ir::Node` via `value_to_node()`

### `ast_equal(original: &str, rendered: &str) -> Result<(), SqlfmtError>`

Parse both strings with `serde_json::from_str`. Compare the resulting `Value`s with `==`. `serde_json::Value` object equality is order-independent, so key sorting in the output does not cause false failures.

---

## CLI Registration (`src/main.rs`)

Add `Json` to the `DialectArg` enum and a corresponding match arm:

```rust
DialectArg::Json => format_sql(&dialect_json::JsonDialect, &sql, &opts),
```

Add `dialect-json` to the workspace `Cargo.toml` members list and as a dependency in `src/Cargo.toml` (or the root `Cargo.toml`).

---

## Corpus Tests

No corpus tests — there is no meaningful SQL corpus for JSON and round-trip correctness is fully exercised by `ast_equal` on every format call.

---

## Example Output

Input: `{"z":1,"a":{"d":2,"b":3},"e":[10,20,30]}`

Formatted (line_width=40):
```json
{
    "a": {
        "b": 3,
        "d": 2
    },
    "e": [
        10,
        20,
        30
    ],
    "z": 1
}
```

Formatted (line_width=1000):
```json
{"a": {"b": 3, "d": 2}, "e": [10, 20, 30], "z": 1}
```
