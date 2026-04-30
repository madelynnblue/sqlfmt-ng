---
name: corpus-improve
description: Use when asked to improve corpus test coverage for a dialect, run corpus tests, or fix round-trip failures. Accepts a dialect name argument (postgres, materialize, cockroachdb) and drives the loop of running tests, diagnosing failures, fixing IR conversion code, and updating testdata.
---

# corpus-improve

Iteratively improve a dialect's round-trip correctness by running the external corpus, diagnosing failures, fixing the IR converter, and committing known failures to testdata.

## Dialect → Corpus → Converter mapping

| Dialect       | Corpus source repo                                                | Test files   | Converter                                             |
| ------------- | ----------------------------------------------------------------- | ------------ | ----------------------------------------------------- |
| `postgres`    | `postgres/postgres` `src/test/regress/sql/*.sql`                  | raw SQL      | `crates/dialect-postgres-convert/src/json_convert.rs` |
| `materialize` | `MaterializeInc/materialize` `test/sqllogictest/*.slt`            | sqllogictest | `crates/dialect-materialize/src/convert.rs`           |
| `cockroachdb` | `cockroachdb/cockroach` `pkg/sql/logictest/testdata/logic_test/*` | sqllogictest | _(stub — not yet implemented)_                        |

## Workflow

### 1. Triage failures

Choose the first failure in `crates/sqlfmt-corpus-tests/testdata/failing/{corpus}-{dialect}.sql`, then:

```sh
# Format one failing statement to see the error
cargo run -- --dialect <dialect> --stmt "<paste stmt here>"
# or
echo "<stmt>" | cargo run -- --dialect <dialect>
```

The error should be:

- `SqlfmtError::Roundtrip` — IR conversion is lossy; something dropped from the AST
- `SqlfmtError::Unformatted` — this AST node isn't converted to structured IR yet (missing match arm or intentional fallback)

Find another statement if not and restart.

### 2. Diagnose a round-trip failure

A `Roundtrip` error means the rendered SQL re-parses to a different AST than the original. Find what's being lost:

1. Look up the relevant AST node in the parser's JSON output (postgres: use `pg_query::parse_to_json(stmt)`)
2. Search `json_convert.rs` (postgres) or `convert.rs` (materialize) for the node type
3. Check whether any fields are missing from the IR construction — common causes:
   - A `format!("...")` fallback producing `Node::Unformatted` — search the converter for `Unformatted` to find unconverted AST nodes
   - A match arm that ignores fields (e.g., `OrderByClause` missing `NULLS FIRST/LAST`)
   - A new AST node variant added upstream that has no arm

### 3. `Node::Unformatted` vs `Node::Text` — critical convention

**Every AST node that is not yet converted to structured IR MUST produce `Node::Unformatted`, NOT `Node::Text`.** This is the mechanism that drives the entire corpus-improve workflow:

| Node variant       | Meaning                                                                    | Corpus test behavior (`error_on_unformatted: true`)       |
| ------------------ | -------------------------------------------------------------------------- | --------------------------------------------------------- |
| `Node::Text`       | Intentional structural text (whitespace, punctuation, case-preserved name) | Passes — statement goes to `success/`                     |
| `Node::Unformatted` | Unconverted AST node (catch-all fallback, complex edge case)             | Fails with `SqlfmtError::Unformatted` — goes to `failing/` |

**Why this matters:** The corpus tests set `error_on_unformatted: true`. When you use `Node::Unformatted` for fallbacks, the corpus test automatically knows which statements are unconverted. When you later add structured IR for that node, `test_rewrite_corpus` moves those statements from `failing/` to `success/`, making progress visible.

**Rules for choosing:**
- Catch-all match arms (`_ =>`), fallback paths for complex/unsupported variants → `Node::Unformatted`
- Intentional whitespace (`" "`), punctuation (`"."`, `":"`, `"["`), wildcards (`"*"`), inline SQL fragments (`" IGNORE NULLS"`, `" WITH ORDINALITY"`) → `Node::Text`
- Parser Display passthrough (`format!("{node}")`) in a fallback path → `Node::Unformatted`
- Case-preserved names (`format!("{}", f.name)`) used as structural elements → `Node::Text`

**Before starting any conversion work**, search the converter for `Node::Unformatted` to find all unconverted code paths. Each one represents a class of statements in `failing/` that need structured IR.

### 4. Fix the converter

#### Materialize: use `doc.rs` as a formatting template

For the Materialize dialect, the upstream repo already has a reference pretty-printer at
`src/sql-pretty/src/doc.rs` in `MaterializeInc/materialize`. Before writing any IR
conversion code, check that file to see exactly how each statement and expression type
is formatted — which clauses appear, in what order, what keywords prefix each, how
options are bracketed, etc. The `doc.rs` code is authoritative ground truth for the
expected output structure.

The patterns in `doc.rs` translate directly to IR nodes:
- `nest_title("FROM", ...)` → `Node::Keyword("FROM")` wrapping the inner node
- `bracket("(", ..., ")")` → `Node::Wrap { open: "(", close: ")" }`
- `comma_separate(...)` → `Node::List { .. }`
- `RcDoc::intersperse(docs, Doc::line())` → `Node::Clauses(docs)`
- `intersperse_line_nest(...)` → nested `Node::Clauses`

Use `doc.rs` to understand the expected shape *before* writing the converter, so the
IR you produce will round-trip correctly on the first attempt.

#### Rust parsers: always destructure all fields — never use `..`

For Rust-based parsers (Materialize, CockroachDB), always destructure AST structs and
enum variants with every field named explicitly. Never use `..` to ignore the rest:

```rust
// BAD — silently drops new fields added upstream
let MyStmt { name, query, .. } = v;

// GOOD — compile error if upstream adds a field you haven't handled
let MyStmt { name, query, options, if_not_exists } = v;
```

This turns "silently dropped field → round-trip failure" into a compile error caught
before any test runs. If a field is intentionally unused (e.g., a span/location with
no semantic content), bind it to `_`:

```rust
let MyStmt { name, query, span: _ } = v;
```

Apply this to every struct conversion and every enum variant match arm.

Edit the appropriate converter file and add or complete the conversion for the failing node. After fixing:

```sh
# Verify the specific statement now passes
cargo run -- --dialect <dialect> --stmt "<stmt>"

# Run the rewriter to move now-passing statements from failing/ to success/
# (uses -- --ignored because the test is #[ignore]d — it mutates testdata files)
cargo test -p sqlfmt-corpus-tests test_rewrite_corpus -- --ignored

# Run permanent corpus test (fast, no network) to verify both dirs
cargo test -p sqlfmt-corpus-tests test_permanent_corpus
```

### 5. Move fixed statements to success/

After fixing a class of failures, run `test_rewrite_corpus` to automatically move all now-passing statements from `crates/sqlfmt-corpus-tests/testdata/failing/` to `crates/sqlfmt-corpus-tests/testdata/success/`. The test panics when statements are moved, signaling you to commit the updated testdata.

The `test_permanent_corpus` test then ensures:

- `crates/sqlfmt-corpus-tests/testdata/success/` statements remain passing (regression prevention)
- `crates/sqlfmt-corpus-tests/testdata/failing/` statements still produce round-trip errors (still need fixing)

If a statement still fails and the fix is complex, leave it in `crates/sqlfmt-corpus-tests/testdata/failing/` as a known failure and move to the next one.

After the statement (and possibly others) have been moved to success, commit the changes and start a new change. Try to keep it to one change per commit. Sometimes multiple fixes will be required for a single statement to move to succes if that statement has multiple broken things; that's ok.

### 6. Commit

After the permanent corpus test passes, set a jj commit description summarizing the converter fixes. Then start a new change with `jj new`.

## Running a single corpus test quickly

To diagnose a specific failing statement without re-running the full corpus:

```sh
cargo run -- --dialect postgres --stmt "SELECT a AT TIME ZONE 'UTC' FROM t"
```

## Testdata directory structure

```
crates/sqlfmt-corpus-tests/testdata/
  failing/
    {corpus}-{dialect}.sql    — known round-trip failures
  success/
    {corpus}-{dialect}.sql    — verified passing statements (regression suite)
```

### Testdata file format

```sql
SELECT a FROM t

-- sqlfmt-corpus-separator --

SELECT b, c FROM t WHERE x > 1
```

Statements are separated by `\n\n-- sqlfmt-corpus-separator --\n\n`. Each statement is trimmed before comparison, so whitespace-only differences don't create duplicates.

### Three test tiers

| Test                    | Command                                                              | What it does                                                                                        |
| ----------------------- | -------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `test_external_corpus`  | `cargo test -p sqlfmt-corpus-tests -- --ignored`                     | Fetches live SQL from upstream repos, writes new failures to `failing/` and successes to `success/` |
| `test_rewrite_corpus`   | `cargo test -p sqlfmt-corpus-tests test_rewrite_corpus -- --ignored` | Scans `failing/`, moves passing statements to `success/`, panics on changes                         |
| `test_permanent_corpus` | `cargo test -p sqlfmt-corpus-tests test_permanent_corpus`            | Verifies `success/` stays passing and `failing/` still fails                                        |
