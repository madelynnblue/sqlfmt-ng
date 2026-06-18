use crate::sources::all_sources;
use sqlfmt_core::{Dialect, SqlfmtError, format_sql};
use sqlfmt_render::{CaseMode, RenderOpts};
use std::collections::{HashMap, HashSet};
use std::fs;
use std::path::{Path, PathBuf};

pub(crate) const SEPARATOR: &str = "\n\n-- sqlfmt-corpus-separator --\n\n";

/// Returns the path to the shared corpus cache directory inside this crate's testdata.
pub fn corpus_cache_dir() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("testdata/corpus-cache")
}

pub fn default_opts() -> RenderOpts {
    RenderOpts {
        line_width: 1000,
        use_tabs: false,
        tab_width: 4,
        case: CaseMode::Upper,
        error_on_unformatted: true,
    }
}

/// Read all statements from a subdirectory of testdata. Returns map of source_name → statements.
/// Files are expected to be named `{source}.sql`.
fn read_corpus_dir(dir: &Path, subdir: &str) -> HashMap<String, Vec<String>> {
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
        let source_name = match path.file_stem().and_then(|s| s.to_str()) {
            Some(s) => s.to_owned(),
            None => continue,
        };

        let content = fs::read_to_string(&path).unwrap_or_default();
        let stmts: Vec<String> = content
            .split(SEPARATOR)
            .map(|s| s.trim().to_owned())
            .filter(|s| !s.is_empty())
            .collect();

        if !stmts.is_empty() {
            result.insert(source_name, stmts);
        }
    }

    result
}

fn write_corpus_file(dir: &Path, subdir: &str, source: &str, stmts: &[String]) {
    if stmts.is_empty() {
        return;
    }
    let subdir_path = dir.join(subdir);
    fs::create_dir_all(&subdir_path).expect("failed to create corpus subdir");
    let file_path = subdir_path.join(format!("{source}.sql"));
    let content = stmts.join(SEPARATOR);
    fs::write(&file_path, content).expect("failed to write corpus file");
}

fn remove_corpus_file_if_empty(dir: &Path, subdir: &str, source: &str) {
    let file_path = dir.join(subdir).join(format!("{source}.sql"));
    if file_path.exists() {
        let content = fs::read_to_string(&file_path).unwrap_or_default();
        let has_content = content.split(SEPARATOR).any(|s| !s.trim().is_empty());
        if !has_content {
            let _ = fs::remove_file(&file_path);
        }
    }
}

/// Reads cached corpus files, formats each statement with the given dialect, and updates
/// `testdata/failing/` and `testdata/success/` accordingly. New failures and regressions
/// cause a panic.
pub fn run_external_corpus(dialect: &dyn Dialect, testdata_dir: &Path, cache_dir: &Path) {
    const FAILING: &str = "failing";
    const SUCCESS: &str = "success";

    let opts = dialect.default_render_opts();
    let sources = all_sources();

    let mut failures: Vec<(String, String)> = Vec::new();
    let mut successes: Vec<(String, String)> = Vec::new();

    for source in &sources {
        let stmts = match source.fetch(cache_dir) {
            Ok(s) => s,
            Err(e) => {
                eprintln!("Skipping {}: {}", source.name(), e);
                continue;
            }
        };

        for stmt in &stmts {
            match format_sql(dialect, stmt, &opts) {
                Ok(_) => {
                    successes.push((source.name().to_owned(), stmt.clone()));
                }
                Err(SqlfmtError::Parse(_)) => {}
                Err(SqlfmtError::Roundtrip { .. } | SqlfmtError::Unformatted) => {
                    failures.push((source.name().to_owned(), stmt.clone()));
                }
            }
        }
    }

    let existing_failing = read_corpus_dir(testdata_dir, FAILING);
    let existing_success = read_corpus_dir(testdata_dir, SUCCESS);

    let mut failing_sets: HashMap<String, HashSet<String>> = HashMap::new();
    let mut success_sets: HashMap<String, HashSet<String>> = HashMap::new();

    for (source, stmts) in &existing_failing {
        failing_sets.insert(source.clone(), stmts.iter().cloned().collect());
    }
    for (source, stmts) in &existing_success {
        success_sets.insert(source.clone(), stmts.iter().cloned().collect());
    }

    let mut new_failures = 0usize;
    let mut new_successes = 0usize;
    let mut regressions = 0usize;

    let mut failing_updates: HashMap<String, Vec<String>> = HashMap::new();
    let mut success_updates: HashMap<String, Vec<String>> = HashMap::new();

    for (source, stmt) in &failures {
        let trimmed = stmt.trim().to_owned();

        let in_failing = failing_sets.get(source).map(|s| s.contains(&trimmed)).unwrap_or(false);
        let in_success = success_sets.get(source).map(|s| s.contains(&trimmed)).unwrap_or(false);

        if in_success {
            success_sets.get_mut(source).unwrap().remove(&trimmed);
            regressions += 1;
        }

        if !in_failing {
            failing_updates.entry(source.clone()).or_default().push(trimmed);
            new_failures += 1;
        }
    }

    let mut improved = 0usize;

    for (source, stmt) in &successes {
        let trimmed = stmt.trim().to_owned();

        let in_failing = failing_sets.get(source).map(|s| s.contains(&trimmed)).unwrap_or(false);
        let in_success = success_sets.get(source).map(|s| s.contains(&trimmed)).unwrap_or(false);

        if in_failing {
            failing_sets.get_mut(source).unwrap().remove(&trimmed);
            improved += 1;
        }

        if !in_success {
            success_updates.entry(source.clone()).or_default().push(trimmed);
            new_successes += 1;
        }
    }

    for (source, stmts) in &failing_updates {
        let mut all = failing_sets.get(source).cloned().unwrap_or_default();
        for s in stmts {
            all.insert(s.clone());
        }
        let mut sorted: Vec<String> = all.into_iter().collect();
        sorted.sort();
        write_corpus_file(testdata_dir, FAILING, source, &sorted);
    }

    for (source, stmts) in &success_updates {
        let mut all = success_sets.get(source).cloned().unwrap_or_default();
        for s in stmts {
            all.insert(s.clone());
        }
        let mut sorted: Vec<String> = all.into_iter().collect();
        sorted.sort();
        write_corpus_file(testdata_dir, SUCCESS, source, &sorted);
    }

    for (source, stmts) in &existing_failing {
        if failing_updates.contains_key(source) {
            continue;
        }
        let current = failing_sets.get(source).cloned().unwrap_or_default();
        let original: HashSet<String> = stmts.iter().cloned().collect();
        if current != original {
            let mut sorted: Vec<String> = current.into_iter().collect();
            sorted.sort();
            if sorted.is_empty() {
                remove_corpus_file_if_empty(testdata_dir, FAILING, source);
            } else {
                write_corpus_file(testdata_dir, FAILING, source, &sorted);
            }
        }
    }

    for (source, stmts) in &existing_success {
        if success_updates.contains_key(source) {
            continue;
        }
        let current = success_sets.get(source).cloned().unwrap_or_default();
        let original: HashSet<String> = stmts.iter().cloned().collect();
        if current != original {
            let mut sorted: Vec<String> = current.into_iter().collect();
            sorted.sort();
            if sorted.is_empty() {
                remove_corpus_file_if_empty(testdata_dir, SUCCESS, source);
            } else {
                write_corpus_file(testdata_dir, SUCCESS, source, &sorted);
            }
        }
    }

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

/// Scans `failing/` and moves any statement that now formats successfully into `success/`.
/// Panics if any statements were moved so you know to commit the changes.
/// Parse errors are acceptable — they result from cross-dialect SQL or parser changes.
pub fn run_rewrite_corpus(dialect: &dyn Dialect, testdata_dir: &Path) {
    const FAILING: &str = "failing";
    const SUCCESS: &str = "success";

    let opts = dialect.default_render_opts();
    let failing_entries = read_corpus_dir(testdata_dir, FAILING);
    if failing_entries.is_empty() {
        return;
    }

    // Read success entries once up front and keep them as mutable in-memory sets so later
    // iterations see writes from earlier ones without re-reading from disk.
    let mut success_sets: HashMap<String, HashSet<String>> = read_corpus_dir(testdata_dir, SUCCESS)
        .into_iter()
        .map(|(src, stmts)| (src, stmts.into_iter().collect()))
        .collect();

    let mut moved = 0usize;

    for (source, stmts) in &failing_entries {
        let mut still_failing: Vec<String> = Vec::new();
        let mut now_passing: Vec<String> = Vec::new();

        for stmt in stmts {
            match format_sql(dialect, stmt, &opts) {
                Ok(_) => {
                    now_passing.push(stmt.clone());
                }
                Err(SqlfmtError::Parse(_)) => {
                    still_failing.push(stmt.clone());
                }
                Err(SqlfmtError::Roundtrip { .. } | SqlfmtError::Unformatted) => {
                    still_failing.push(stmt.clone());
                }
            }
        }

        if !now_passing.is_empty() {
            let success_stmts = success_sets.entry(source.clone()).or_default();
            for s in &now_passing {
                if success_stmts.insert(s.clone()) {
                    moved += 1;
                }
            }
            let mut sorted: Vec<String> = success_stmts.iter().cloned().collect();
            sorted.sort();
            write_corpus_file(testdata_dir, SUCCESS, source, &sorted);
        }

        let mut sorted: Vec<String> = still_failing.into_iter().collect();
        sorted.sort();
        if sorted.is_empty() {
            let file_path = testdata_dir.join(FAILING).join(format!("{source}.sql"));
            let _ = fs::remove_file(&file_path);
        } else {
            write_corpus_file(testdata_dir, FAILING, source, &sorted);
        }
    }

    if moved > 0 {
        panic!(
            "{moved} statement(s) moved from failing/ to success/ — \
             commit the updated testdata"
        );
    }
}

/// Validates that all statements in `success/` format without error, and all statements in
/// `failing/` still produce a Roundtrip or Parse error. Panics on any violation.
pub fn run_permanent_corpus(dialect: &dyn Dialect, testdata_dir: &Path) {
    const FAILING: &str = "failing";
    const SUCCESS: &str = "success";

    if !testdata_dir.exists() {
        return;
    }

    let opts = dialect.default_render_opts();
    let mut test_failures: Vec<String> = Vec::new();

    let success_entries = read_corpus_dir(testdata_dir, SUCCESS);
    for (source, stmts) in &success_entries {
        for stmt in stmts {
            match format_sql(dialect, stmt, &opts) {
                Ok(_) => {}
                Err(e) => {
                    test_failures.push(format!("[success/{source}]: {e}: {stmt}"));
                }
            }
        }
    }

    let failing_entries = read_corpus_dir(testdata_dir, FAILING);
    for (source, stmts) in &failing_entries {
        for stmt in stmts {
            match format_sql(dialect, stmt, &opts) {
                Ok(_) => {
                    test_failures.push(format!(
                        "[failing/{source}]: now passes — run test_rewrite_corpus to move it to success/: \
                         {stmt}"
                    ));
                }
                Err(SqlfmtError::Parse(_)) => {}
                Err(SqlfmtError::Roundtrip { .. } | SqlfmtError::Unformatted) => {}
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
