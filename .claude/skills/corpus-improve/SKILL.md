---
name: corpus-improve
description: Use when asked to improve corpus test coverage for a dialect, run corpus tests, or fix round-trip failures. Accepts a dialect name argument (postgres, materialize, cockroachdb) and drives the loop of running tests, diagnosing failures, fixing IR conversion code, and updating testdata.
---

# corpus-improve

Iteratively improve a dialect's round-trip correctness by running the external corpus, diagnosing failures, fixing the IR converter, and committing known failures to testdata.

## Dialect → Corpus → Converter mapping

| Dialect | Corpus source repo | Test files | Converter |
|---|---|---|---|
| `postgres` | `postgres/postgres` `src/test/regress/sql/*.sql` | raw SQL | `crates/dialect-postgres-convert/src/json_convert.rs` |
| `materialize` | `MaterializeInc/materialize` `test/sqllogictest/*.slt` | sqllogictest | `crates/dialect-materialize/src/convert.rs` |
| `cockroachdb` | `cockroachdb/cockroach` `pkg/sql/logictest/testdata/logic_test/*` | sqllogictest | *(stub — not yet implemented)* |

## Workflow

### 1. Set up

```sh
# Avoid GitHub rate limits (60 req/hr anon vs 5000 auth)
export GITHUB_TOKEN=<token>   # if available
```

### 2. Run the external corpus test

Run the corpus focused on the target dialect's own source repo first — those statements are most likely to exercise real-world patterns for that dialect.

```sh
# Full external corpus run (downloads and caches in target/sqlfmt-corpus-cache/)
cargo test -p sqlfmt-corpus-tests -- --ignored 2>&1 | tee /tmp/corpus-out.txt

# Check what failures were recorded
ls crates/sqlfmt-corpus-tests/testdata/failing/
ls crates/sqlfmt-corpus-tests/testdata/success/
```

Round-trip failures are written to `testdata/failing/{corpus}-{dialect}.sql`, and successful statements to `testdata/success/{corpus}-{dialect}.sql`. All statements are separated by `\n\n-- sqlfmt-corpus-separator --\n\n`. The test panics if **new** failures or regressions appear.

### 3. Triage failures

For each failure in `testdata/failing/{corpus}-{dialect}.sql`:

```sh
# Format one failing statement to see the error
cargo run -- --dialect <dialect> --stmt "<paste stmt here>"
# or
echo "<stmt>" | cargo run -- --dialect <dialect>
```

The error will be one of:
- `SqlfmtError::Roundtrip` — IR conversion is lossy; something dropped from the AST
- `SqlfmtError::Parse` — foreign-dialect SQL; skip (this is expected)

### 4. Diagnose a round-trip failure

A `Roundtrip` error means the rendered SQL re-parses to a different AST than the original. Find what's being lost:

1. Look up the relevant AST node in the parser's JSON output (postgres: use `pg_query::parse_to_json(stmt)`)
2. Search `json_convert.rs` (postgres) or `convert.rs` (materialize) for the node type
3. Check whether any fields are missing from the IR construction — common causes:
   - A `TODO` comment returning `Node::Text` instead of a real conversion
   - A match arm that ignores fields (e.g., `OrderByClause` missing `NULLS FIRST/LAST`)
   - A new AST node variant added upstream that has no arm

### 5. Fix the converter

Edit the appropriate converter file and add or complete the conversion for the failing node. After fixing:

```sh
# Verify the specific statement now passes
cargo run -- --dialect <dialect> --stmt "<stmt>"

# Run the rewriter to move now-passing statements from failing/ to success/
cargo test -p sqlfmt-corpus-tests test_rewrite_corpus

# Run permanent corpus test (fast, no network) to verify both dirs
cargo test -p sqlfmt-corpus-tests test_permanent_corpus
```

### 6. Move fixed statements to success/

After fixing a class of failures, run `test_rewrite_corpus` to automatically move all now-passing statements from `testdata/failing/` to `testdata/success/`. The test panics when statements are moved, signaling you to commit the updated testdata.

The `test_permanent_corpus` test then ensures:
- `success/` statements remain passing (regression prevention)
- `failing/` statements still produce round-trip errors (still need fixing)

If a statement still fails and the fix is complex, leave it in `testdata/failing/` as a known failure and move to the next one.

### 7. Iterate

Repeat steps 2–6. Focus on fixing the most common failure patterns first (group similar errors before fixing).

```sh
# Re-run external corpus to discover any remaining new failures
cargo test -p sqlfmt-corpus-tests -- --ignored
```

Stop when the external corpus produces zero new failures for the target dialect.

## Corpus cache

Files are cached in `target/sqlfmt-corpus-cache/`. Delete this directory to force a fresh download.

## Running a single corpus test quickly

To diagnose a specific failing statement without re-running the full corpus:

```sh
cargo run -- --dialect postgres --stmt "SELECT a AT TIME ZONE 'UTC' FROM t"
```

## Testdata directory structure

```
testdata/
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

| Test | Command | What it does |
|---|---|---|
| `test_external_corpus` | `cargo test -p sqlfmt-corpus-tests -- --ignored` | Fetches live SQL from upstream repos, writes new failures to `failing/` and successes to `success/` |
| `test_rewrite_corpus` | `cargo test -p sqlfmt-corpus-tests test_rewrite_corpus` | Scans `failing/`, moves passing statements to `success/`, panics on changes |
| `test_permanent_corpus` | `cargo test -p sqlfmt-corpus-tests test_permanent_corpus` | Verifies `success/` stays passing and `failing/` still fails |
