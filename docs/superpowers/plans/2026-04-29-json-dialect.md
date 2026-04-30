# JSON Dialect Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a `dialect-json` crate that formats JSON through the existing sqlfmt IR pipeline.

**Architecture:** Parse JSON with `serde_json`, recursively convert `Value` to `Node` using `Group`+`Nest`+`Softline`+`List` for correct indentation behavior, and validate round-trips by comparing parsed `serde_json::Value`s. `Node::Wrap` is intentionally not used for the brackets — it lacks soft-line/nest behavior, so we compose the primitives directly.

**Tech Stack:** Rust, `serde_json = "1"`, `sqlfmt-ir`, `sqlfmt-core`, `sqlfmt-render` (dev), `clap` (existing CLI)

---

### Task 1: Create the crate skeleton

**Files:**
- Create: `crates/dialect-json/Cargo.toml`
- Create: `crates/dialect-json/src/lib.rs`
- Modify: `Cargo.toml` (workspace members + root binary dependency)

- [ ] **Step 1: Create `crates/dialect-json/Cargo.toml`**

```toml
[package]
name = "dialect-json"
version.workspace = true
edition.workspace = true
rust-version.workspace = true

[dependencies]
sqlfmt-ir = { path = "../sqlfmt-ir" }
sqlfmt-core = { path = "../sqlfmt-core" }
serde_json = "1"

[dev-dependencies]
sqlfmt-render = { path = "../sqlfmt-render" }
```

- [ ] **Step 2: Create `crates/dialect-json/src/lib.rs` with a stub**

```rust
use sqlfmt_core::{Dialect, SqlfmtError};
use sqlfmt_ir::Node;

pub struct JsonDialect;

impl Dialect for JsonDialect {
    fn parse(&self, _input: &str) -> Result<Node, SqlfmtError> {
        todo!()
    }

    fn ast_equal(&self, _original: &str, _rendered: &str) -> Result<(), SqlfmtError> {
        todo!()
    }
}
```

- [ ] **Step 3: Add `dialect-json` to workspace `Cargo.toml`**

Add `"crates/dialect-json"` to the `members` array and add the crate as a dependency:

```toml
[workspace]
members = [
    ".",
    "crates/dialect-cockroachdb",
    "crates/dialect-googlesql",
    "crates/dialect-json",
    "crates/dialect-materialize",
    "crates/dialect-postgres-convert",
    "crates/dialect-postgres",
    "crates/sqlfmt-corpus-tests",
    "crates/sqlfmt-core",
    "crates/sqlfmt-error",
    "crates/sqlfmt-ir",
    "crates/sqlfmt-render",
    "web",
]
```

And in `[dependencies]`:
```toml
dialect-json = { path = "crates/dialect-json" }
```

- [ ] **Step 4: Verify compilation**

Run: `cargo build -p dialect-json`

Expected: compiles (panics are fine — `todo!()` is not called at build time).

- [ ] **Step 5: Commit**

```
jj describe -m "dialect-json: add crate skeleton"
jj new
```

---

### Task 2: Implement `value_to_node` and `JsonDialect::parse`

**Files:**
- Modify: `crates/dialect-json/src/lib.rs`

The IR structure for containers uses primitives directly instead of `Node::Wrap`, because `Wrap` just concatenates open+content+close with no soft-lines or nesting. The correct pattern is:

```
Group {
  Concat([
    Text("["),
    Nest { Concat([Softline, List { items, separator: "," }]) },
    Softline,
    Text("]"),
  ])
}
```

- In flat mode: `Softline` → `""`, so output is `[item1, item2]`
- In break mode: `Softline` → `"\n"` and `Nest` adds 4-space indent, so:
  ```
  [
      item1,
      item2
  ]
  ```

- [ ] **Step 1: Write failing tests**

Add to `crates/dialect-json/src/lib.rs`:

```rust
#[cfg(test)]
mod tests {
    use super::*;
    use sqlfmt_core::format_sql;
    use sqlfmt_render::{CaseMode, RenderOpts};

    fn opts(line_width: usize) -> RenderOpts {
        RenderOpts {
            line_width,
            use_tabs: false,
            tab_width: 4,
            case: CaseMode::Upper,
            error_on_unformatted: true,
        }
    }

    #[test]
    fn test_null() {
        assert_eq!(format_sql(&JsonDialect, "null", &opts(80)).unwrap(), "null");
    }

    #[test]
    fn test_bool() {
        assert_eq!(format_sql(&JsonDialect, "true", &opts(80)).unwrap(), "true");
        assert_eq!(format_sql(&JsonDialect, "false", &opts(80)).unwrap(), "false");
    }

    #[test]
    fn test_number_integer() {
        assert_eq!(format_sql(&JsonDialect, "42", &opts(80)).unwrap(), "42");
    }

    #[test]
    fn test_number_float() {
        assert_eq!(format_sql(&JsonDialect, "3.14", &opts(80)).unwrap(), "3.14");
    }

    #[test]
    fn test_string() {
        assert_eq!(
            format_sql(&JsonDialect, r#""hello""#, &opts(80)).unwrap(),
            r#""hello""#
        );
    }

    #[test]
    fn test_string_with_escapes() {
        assert_eq!(
            format_sql(&JsonDialect, r#""a\"b""#, &opts(80)).unwrap(),
            r#""a\"b""#
        );
    }

    #[test]
    fn test_empty_array() {
        assert_eq!(format_sql(&JsonDialect, "[]", &opts(80)).unwrap(), "[]");
    }

    #[test]
    fn test_array_flat() {
        assert_eq!(
            format_sql(&JsonDialect, "[1,2,3]", &opts(80)).unwrap(),
            "[1, 2, 3]"
        );
    }

    #[test]
    fn test_array_expanded() {
        assert_eq!(
            format_sql(&JsonDialect, "[1,2,3]", &opts(5)).unwrap(),
            "[\n    1,\n    2,\n    3\n]"
        );
    }

    #[test]
    fn test_empty_object() {
        assert_eq!(format_sql(&JsonDialect, "{}", &opts(80)).unwrap(), "{}");
    }

    #[test]
    fn test_object_flat() {
        assert_eq!(
            format_sql(&JsonDialect, r#"{"z":1,"a":2}"#, &opts(80)).unwrap(),
            r#"{"a": 2, "z": 1}"#
        );
    }

    #[test]
    fn test_object_sorts_keys() {
        // Keys must be sorted regardless of input order.
        let result = format_sql(&JsonDialect, r#"{"z":1,"m":2,"a":3}"#, &opts(80)).unwrap();
        assert_eq!(result, r#"{"a": 3, "m": 2, "z": 1}"#);
    }

    #[test]
    fn test_object_expanded() {
        let result = format_sql(&JsonDialect, r#"{"z":1,"a":2}"#, &opts(10)).unwrap();
        assert_eq!(result, "{\n    \"a\": 2,\n    \"z\": 1\n}");
    }

    #[test]
    fn test_nested() {
        let input = r#"{"b":[1,2],"a":{"x":true}}"#;
        let result = format_sql(&JsonDialect, input, &opts(80)).unwrap();
        assert_eq!(result, r#"{"a": {"x": true}, "b": [1, 2]}"#);
    }

    #[test]
    fn test_parse_error() {
        assert!(matches!(
            format_sql(&JsonDialect, "not json", &opts(80)),
            Err(SqlfmtError::Parse(_))
        ));
    }
}
```

- [ ] **Step 2: Run tests to confirm they fail**

Run: `cargo test -p dialect-json 2>&1 | head -20`

Expected: compile error or panics from `todo!()`.

- [ ] **Step 3: Implement `value_to_node` and `parse`**

Replace the stub in `crates/dialect-json/src/lib.rs` with the full implementation:

```rust
use sqlfmt_core::{Dialect, SqlfmtError};
use sqlfmt_ir::Node;

pub struct JsonDialect;

impl Dialect for JsonDialect {
    fn parse(&self, input: &str) -> Result<Node, SqlfmtError> {
        let value: serde_json::Value =
            serde_json::from_str(input).map_err(|e| SqlfmtError::Parse(e.to_string()))?;
        Ok(value_to_node(&value))
    }

    fn ast_equal(&self, original: &str, rendered: &str) -> Result<(), SqlfmtError> {
        todo!()
    }
}

fn value_to_node(value: &serde_json::Value) -> Node {
    match value {
        serde_json::Value::Null => Node::Literal { value: "null".into() },
        serde_json::Value::Bool(b) => Node::Literal { value: b.to_string() },
        serde_json::Value::Number(n) => Node::Literal { value: n.to_string() },
        serde_json::Value::String(_) => Node::Literal {
            value: serde_json::to_string(value).expect("string serialization is infallible"),
        },
        serde_json::Value::Array(items) => bracketed(
            "[",
            Node::List {
                items: items.iter().map(value_to_node).collect(),
                separator: Some(",".into()),
            },
            "]",
        ),
        serde_json::Value::Object(map) => {
            let mut pairs: Vec<(&String, &serde_json::Value)> = map.iter().collect();
            pairs.sort_by_key(|(k, _)| k.as_str());
            bracketed(
                "{",
                Node::List {
                    items: pairs
                        .into_iter()
                        .map(|(k, v)| Node::Concat {
                            items: vec![
                                Node::Literal {
                                    value: serde_json::to_string(k)
                                        .expect("string serialization is infallible"),
                                },
                                Node::Text { value: ": ".into() },
                                value_to_node(v),
                            ],
                        })
                        .collect(),
                    separator: Some(",".into()),
                },
                "}",
            )
        }
    }
}

/// Wraps `content` in `open`/`close` brackets with soft-line breaks and nesting,
/// so the result is flat when it fits and expanded (one item per indented line) when it doesn't.
fn bracketed(open: &str, content: Node, close: &str) -> Node {
    Node::Group {
        content: Box::new(Node::Concat {
            items: vec![
                Node::Text { value: open.into() },
                Node::Nest {
                    content: Box::new(Node::Concat {
                        items: vec![Node::Softline, content],
                    }),
                },
                Node::Softline,
                Node::Text { value: close.into() },
            ],
        }),
    }
}
```

- [ ] **Step 4: Run the parse-related tests (skip `ast_equal` tests for now)**

Run: `cargo test -p dialect-json test_parse_error 2>&1`

Expected: PASS

- [ ] **Step 5: Commit**

```
jj describe -m "dialect-json: implement value_to_node and parse"
jj new
```

---

### Task 3: Implement `ast_equal` and make all tests pass

**Files:**
- Modify: `crates/dialect-json/src/lib.rs`

`ast_equal` parses both strings with `serde_json` and compares the resulting `Value`s. `serde_json::Value`'s `PartialEq` implementation compares objects by their key-value pairs regardless of order, so key sorting in the rendered output does not cause false failures.

- [ ] **Step 1: Replace `todo!()` in `ast_equal`**

```rust
fn ast_equal(&self, original: &str, rendered: &str) -> Result<(), SqlfmtError> {
    let orig: serde_json::Value = serde_json::from_str(original)
        .map_err(|e| SqlfmtError::Parse(e.to_string()))?;
    let rend: serde_json::Value = serde_json::from_str(rendered)
        .map_err(|e| SqlfmtError::Parse(e.to_string()))?;
    if orig == rend {
        Ok(())
    } else {
        Err(SqlfmtError::Roundtrip {
            input: original.to_string(),
            output: rendered.to_string(),
        })
    }
}
```

- [ ] **Step 2: Run all tests**

Run: `cargo test -p dialect-json 2>&1`

Expected: all tests pass. If any expected-string assertions fail due to different whitespace from the pretty-printer, update the expected strings to match the actual output — do not change the implementation to force a specific format.

- [ ] **Step 3: Commit**

```
jj describe -m "dialect-json: implement ast_equal, all tests pass"
jj new
```

---

### Task 4: Wire up the CLI

**Files:**
- Modify: `src/main.rs`

- [ ] **Step 1: Add `Json` to the `DialectArg` enum and match arm**

In `src/main.rs`, change:

```rust
#[derive(Debug, Clone, Copy, ValueEnum)]
enum DialectArg {
    Json,
    Materialize,
    Postgres,
}
```

And add the match arm:

```rust
let result = match args.dialect {
    DialectArg::Json => format_sql(&dialect_json::JsonDialect, &sql, &opts),
    DialectArg::Materialize => {
        format_sql(&dialect_materialize::MaterializeDialect, &sql, &opts)
    }
    DialectArg::Postgres => format_sql(&dialect_postgres::PostgresDialect, &sql, &opts),
};
```

- [ ] **Step 2: Verify the CLI works**

Run: `cargo run -- --dialect json --stmt '{"z":1,"a":2}'`

Expected output:
```
{"a": 2, "z": 1}
```

Run with a narrow width:
`cargo run -- --dialect json --width 5 --stmt '[1,2,3]'`

Expected output:
```
[
    1,
    2,
    3
]
```

- [ ] **Step 3: Commit**

```
jj describe -m "dialect-json: wire up CLI"
jj new
```

---

### Task 5: Final verification

- [ ] **Step 1: Run full test suite**

Run: `cargo test 2>&1 | tail -20`

Expected: no regressions in other crates.

- [ ] **Step 2: Commit**

If no changes needed:
```
jj describe -m "dialect-json: complete implementation"
```
