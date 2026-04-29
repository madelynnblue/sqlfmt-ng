use sqlfmt_core::{SqlfmtError, format_sql};
use sqlfmt_corpus_tests::CorpusSource;
use sqlfmt_corpus_tests::sources::{CockroachDbCorpus, MaterializeCorpus, PostgresCorpus};
use sqlfmt_render::{CaseMode, RenderOpts};
use std::collections::{HashMap, HashSet};
use std::fs;
use std::path::Path;

const SEPARATOR: &str = "\n\n-- sqlfmt-corpus-separator --\n\n";
const FAILING: &str = "failing";
const SUCCESS: &str = "success";

fn default_opts() -> RenderOpts {
    RenderOpts {
        line_width: 1000,
        use_tabs: false,
        tab_width: 4,
        case: CaseMode::Upper,
        error_on_unformatted: true,
    }
}

fn all_sources() -> Vec<Box<dyn CorpusSource>> {
    vec![
        Box::new(MaterializeCorpus),
        Box::new(PostgresCorpus),
        Box::new(CockroachDbCorpus),
    ]
}

fn dialects() -> &'static [(&'static str, &'static (dyn sqlfmt_core::Dialect + Sync))] {
    &[
        ("materialize", &dialect_materialize::MaterializeDialect),
        ("postgres", &dialect_postgres::PostgresDialect),
    ]
}

fn get_dialect(name: &str) -> Option<Box<dyn sqlfmt_core::Dialect>> {
    match name {
        "materialize" => Some(Box::new(dialect_materialize::MaterializeDialect)),
        "postgres" => Some(Box::new(dialect_postgres::PostgresDialect)),
        _ => None,
    }
}

/// Read all statements from a subdirectory of testdata. Returns map of
/// (source_name, dialect_name) → statements.
fn read_corpus_dir(dir: &Path, subdir: &str) -> HashMap<(String, String), Vec<String>> {
    let subdir_path = dir.join(subdir);
    let mut result = HashMap::new();

    if !subdir_path.exists() {
        return result;
    }

    let entries = match fs::read_dir(&subdir_path) {
        Ok(e) => e,
        Err(_) => return result,
    };

    for entry in entries.filter_map(|e| e.ok()) {
        let path = entry.path();
        if path.extension().and_then(|s| s.to_str()) != Some("sql") {
            continue;
        }
        let stem = match path.file_stem().and_then(|s| s.to_str()) {
            Some(s) => s,
            None => continue,
        };
        let dialect_name = match stem.rfind('-') {
            Some(pos) => stem[pos + 1..].to_owned(),
            None => continue,
        };
        // source name is everything before the last `-`
        let source_name = stem[..stem.rfind('-').unwrap()].to_owned();

        let content = fs::read_to_string(&path).unwrap_or_default();
        let stmts: Vec<String> = content
            .split(SEPARATOR)
            .map(|s| s.trim().to_owned())
            .filter(|s| !s.is_empty())
            .collect();

        if !stmts.is_empty() {
            result.insert((source_name, dialect_name), stmts);
        }
    }

    result
}

/// Write a corpus file, creating directories as needed.
fn write_corpus_file(dir: &Path, subdir: &str, source: &str, dialect: &str, stmts: &[String]) {
    if stmts.is_empty() {
        return;
    }
    let subdir_path = dir.join(subdir);
    fs::create_dir_all(&subdir_path).expect("failed to create corpus subdir");
    let file_path = subdir_path.join(format!("{source}-{dialect}.sql"));
    let content = stmts.join(SEPARATOR);
    fs::write(&file_path, content).expect("failed to write corpus file");
}

/// Delete a corpus file if it exists (because all its statements were moved).
fn remove_corpus_file_if_empty(dir: &Path, subdir: &str, source: &str, dialect: &str) {
    let file_path = dir.join(subdir).join(format!("{source}-{dialect}.sql"));
    if file_path.exists() {
        let content = fs::read_to_string(&file_path).unwrap_or_default();
        let has_content = content.split(SEPARATOR).any(|s| !s.trim().is_empty());
        if !has_content {
            let _ = fs::remove_file(&file_path);
        }
    }
}

#[test]
#[ignore]
fn test_external_corpus() {
    let cache_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../target/sqlfmt-corpus-cache");
    let testdata_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("testdata");

    let opts = default_opts();
    let sources = all_sources();

    // 1. Fetch all external statements and format them.
    let mut failures: Vec<(String, String, String)> = Vec::new();
    let mut successes: Vec<(String, String, String)> = Vec::new();

    for source in &sources {
        let stmts = match source.fetch(&cache_dir) {
            Ok(s) => s,
            Err(e) => {
                eprintln!("Skipping {}: {}", source.name(), e);
                continue;
            }
        };

        for stmt in &stmts {
            for (dialect_name, dialect) in dialects() {
                match format_sql(*dialect, stmt, &opts) {
                    Ok(_) => {
                        successes.push((
                            source.name().to_owned(),
                            dialect_name.to_string(),
                            stmt.clone(),
                        ));
                    }
                    Err(SqlfmtError::Parse(_)) => {}
                    Err(SqlfmtError::Roundtrip { .. } | SqlfmtError::Unformatted) => {
                        failures.push((
                            source.name().to_owned(),
                            dialect_name.to_string(),
                            stmt.clone(),
                        ));
                    }
                }
            }
        }
    }

    // 2. Read existing statements from both dirs so we can detect moves and avoid
    //    re-adding duplicates.
    let existing_failing = read_corpus_dir(&testdata_dir, FAILING);
    let existing_success = read_corpus_dir(&testdata_dir, SUCCESS);

    // Build lookup sets keyed by (source, dialect) → set of statements.
    let mut failing_sets: HashMap<(String, String), HashSet<String>> = HashMap::new();
    let mut success_sets: HashMap<(String, String), HashSet<String>> = HashMap::new();

    for ((source, dialect), stmts) in &existing_failing {
        failing_sets.insert(
            (source.clone(), dialect.clone()),
            stmts.iter().cloned().collect(),
        );
    }
    for ((source, dialect), stmts) in &existing_success {
        success_sets.insert(
            (source.clone(), dialect.clone()),
            stmts.iter().cloned().collect(),
        );
    }

    let mut new_failures = 0usize;
    let mut new_successes = 0usize;
    let mut regressions = 0usize; // previously-successful statements that now fail

    // 3. Process failures: add to failing/ if not already there.
    //    If the statement is in success/, move it out (regression).
    let mut failing_updates: HashMap<(String, String), Vec<String>> = HashMap::new();
    let mut success_updates: HashMap<(String, String), Vec<String>> = HashMap::new();

    for (source, dialect, stmt) in &failures {
        let key = (source.clone(), dialect.clone());
        let trimmed = stmt.trim().to_owned();

        let in_failing = failing_sets
            .get(&key)
            .map(|s| s.contains(&trimmed))
            .unwrap_or(false);
        let in_success = success_sets
            .get(&key)
            .map(|s| s.contains(&trimmed))
            .unwrap_or(false);

        if in_success {
            // Regression — was passing, now failing.
            success_sets.get_mut(&key).unwrap().remove(&trimmed);
            regressions += 1;
        }

        if !in_failing {
            failing_updates.entry(key).or_default().push(trimmed);
            new_failures += 1;
        }
    }

    // 4. Process successes: add to success/ if not already there.
    //    If the statement is in failing/, move it out (improvement).
    let mut improved = 0usize;

    for (source, dialect, stmt) in &successes {
        let key = (source.clone(), dialect.clone());
        let trimmed = stmt.trim().to_owned();

        let in_failing = failing_sets
            .get(&key)
            .map(|s| s.contains(&trimmed))
            .unwrap_or(false);
        let in_success = success_sets
            .get(&key)
            .map(|s| s.contains(&trimmed))
            .unwrap_or(false);

        if in_failing {
            // Improvement — was failing, now passing.
            failing_sets.get_mut(&key).unwrap().remove(&trimmed);
            improved += 1;
        }

        if !in_success {
            success_updates.entry(key).or_default().push(trimmed);
            new_successes += 1;
        }
    }

    // 5. Write updated files.
    // Rebuild failing files from the modified sets.
    for ((source, dialect), stmts) in &failing_updates {
        let mut all = failing_sets
            .get(&(source.clone(), dialect.clone()))
            .cloned()
            .unwrap_or_default();
        for s in stmts {
            all.insert(s.clone());
        }
        let sorted: Vec<String> = {
            let mut v: Vec<String> = all.into_iter().collect();
            v.sort();
            v
        };
        write_corpus_file(&testdata_dir, FAILING, source, dialect, &sorted);
    }

    for ((source, dialect), stmts) in &success_updates {
        let mut all = success_sets
            .get(&(source.clone(), dialect.clone()))
            .cloned()
            .unwrap_or_default();
        for s in stmts {
            all.insert(s.clone());
        }
        let sorted: Vec<String> = {
            let mut v: Vec<String> = all.into_iter().collect();
            v.sort();
            v
        };
        write_corpus_file(&testdata_dir, SUCCESS, source, dialect, &sorted);
    }

    // Also rewrite any failing/success files where statements were removed
    // (cross-directory moves) but no new statements were added.
    for ((source, dialect), stmts) in &existing_failing {
        let key = (source.clone(), dialect.clone());
        if failing_updates.contains_key(&key) {
            continue; // already handled above
        }
        // Check if any were removed (moved to success).
        let current = failing_sets.get(&key).cloned().unwrap_or_default();
        let original: HashSet<String> = stmts.iter().cloned().collect();
        if current != original {
            let sorted: Vec<String> = {
                let mut v: Vec<String> = current.into_iter().collect();
                v.sort();
                v
            };
            if sorted.is_empty() {
                remove_corpus_file_if_empty(&testdata_dir, FAILING, source, dialect);
            } else {
                write_corpus_file(&testdata_dir, FAILING, source, dialect, &sorted);
            }
        }
    }

    for ((source, dialect), stmts) in &existing_success {
        let key = (source.clone(), dialect.clone());
        if success_updates.contains_key(&key) {
            continue; // already handled above
        }
        let current = success_sets.get(&key).cloned().unwrap_or_default();
        let original: HashSet<String> = stmts.iter().cloned().collect();
        if current != original {
            let sorted: Vec<String> = {
                let mut v: Vec<String> = current.into_iter().collect();
                v.sort();
                v
            };
            if sorted.is_empty() {
                remove_corpus_file_if_empty(&testdata_dir, SUCCESS, source, dialect);
            } else {
                write_corpus_file(&testdata_dir, SUCCESS, source, dialect, &sorted);
            }
        }
    }

    // 6. Report.
    if improved > 0 {
        println!("{improved} statements improved (moved from failing/ to success/)");
    }
    if regressions > 0 {
        println!("{regressions} regressions (moved from success/ to failing/)");
    }

    if new_failures > 0 || regressions > 0 || improved > 0 || new_successes > 0 {
        println!(
            "Corpus changes: {new_failures} new failures, {new_successes} new successes, \
             {improved} improved, {regressions} regressions"
        );
    }

    if new_failures > 0 || regressions > 0 {
        panic!("{new_failures} new roundtrip failures, {regressions} regressions");
    }
}

/// Rewriter: scans the failing/ directory and moves any statement that now
/// formats successfully into success/. Panics if any statements were moved so
/// you know to commit the changes.
/// Parse errors are acceptable — they result from cross-dialect SQL or parser
/// changes and the statement stays in failing/.
#[test]
#[ignore]
fn test_rewrite_corpus() {
    let testdata_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("testdata");
    let opts = default_opts();

    let failing_entries = read_corpus_dir(&testdata_dir, FAILING);
    if failing_entries.is_empty() {
        return;
    }

    let mut moved = 0usize;

    for ((source, dialect), stmts) in &failing_entries {
        let dialect_inst = match get_dialect(dialect) {
            Some(d) => d,
            None => continue,
        };

        let mut still_failing: Vec<String> = Vec::new();
        let mut now_passing: Vec<String> = Vec::new();

        for stmt in stmts {
            match format_sql(&*dialect_inst, stmt, &opts) {
                Ok(_) => {
                    now_passing.push(stmt.clone());
                }
                Err(SqlfmtError::Parse(_)) => {
                    // Parse errors are expected for cross-dialect statements.
                    // Leave in failing/.
                    still_failing.push(stmt.clone());
                }
                Err(SqlfmtError::Roundtrip { .. } | SqlfmtError::Unformatted) => {
                    still_failing.push(stmt.clone());
                }
            }
        }

        if !now_passing.is_empty() {
            // Add to success/.
            let success_entries = read_corpus_dir(&testdata_dir, SUCCESS);
            let mut success_stmts: HashSet<String> = success_entries
                .get(&(source.clone(), dialect.clone()))
                .cloned()
                .unwrap_or_default()
                .into_iter()
                .collect();

            for s in &now_passing {
                if success_stmts.insert(s.clone()) {
                    moved += 1;
                }
            }
            let mut sorted: Vec<String> = success_stmts.into_iter().collect();
            sorted.sort();
            write_corpus_file(&testdata_dir, SUCCESS, source, dialect, &sorted);
        }

        // Rewrite failing/ with only the still-failing statements.
        // Always run this when anything moved — the entire file may have passed.
        let mut sorted: Vec<String> = still_failing.into_iter().collect();
        sorted.sort();
        if sorted.is_empty() {
            let file_path = testdata_dir
                .join(FAILING)
                .join(format!("{source}-{dialect}.sql"));
            let _ = fs::remove_file(&file_path);
        } else {
            write_corpus_file(&testdata_dir, FAILING, source, dialect, &sorted);
        }
    }

    if moved > 0 {
        panic!(
            "{moved} statement(s) moved from failing/ to success/ — \
             commit the updated testdata"
        );
    }
}

#[test]
fn test_permanent_corpus() {
    let testdata_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("testdata");
    if !testdata_dir.exists() {
        return;
    }

    let opts = default_opts();
    let mut test_failures: Vec<String> = Vec::new();

    // Check success/ — every statement must format without error.
    let success_entries = read_corpus_dir(&testdata_dir, SUCCESS);
    for ((source, dialect), stmts) in &success_entries {
        let dialect_inst = match get_dialect(dialect) {
            Some(d) => d,
            None => continue,
        };
        for stmt in stmts {
            match format_sql(&*dialect_inst, stmt, &opts) {
                Ok(_) => {}
                Err(e) => {
                    test_failures.push(format!("[success/{source}-{dialect}]: {e}: {stmt}"));
                }
            }
        }
    }

    // Check failing/ — every statement must still produce a Roundtrip error
    // (or a Parse error, which is acceptable for cross-dialect SQL).
    let failing_entries = read_corpus_dir(&testdata_dir, FAILING);
    for ((source, dialect), stmts) in &failing_entries {
        let dialect_inst = match get_dialect(dialect) {
            Some(d) => d,
            None => continue,
        };
        for stmt in stmts {
            match format_sql(&*dialect_inst, stmt, &opts) {
                Ok(_) => {
                    test_failures.push(format!(
                        "[failing/{source}-{dialect}]: now passes — run test_rewrite_corpus to move it to success/: \
                         {stmt}"
                    ));
                }
                Err(SqlfmtError::Parse(_)) => {
                    // Acceptable — cross-dialect statements or parser changes.
                }
                Err(SqlfmtError::Roundtrip { .. } | SqlfmtError::Unformatted) => {
                    // Expected — still a round-trip or unformatted failure.
                }
            }
        }
    }

    if !test_failures.is_empty() {
        let n = test_failures.len();
        for f in &test_failures {
            eprintln!("{f}");
        }
        panic!("{n} permanent corpus check(s) failed");
    }
}
