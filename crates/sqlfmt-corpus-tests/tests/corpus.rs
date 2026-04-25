use std::fs;
use std::path::Path;
use sqlfmt_corpus_tests::sources::{CockroachDbCorpus, MaterializeCorpus, PostgresCorpus};
use sqlfmt_corpus_tests::CorpusSource;
use sqlfmt_core::{format_sql, SqlfmtError};
use sqlfmt_render::{CaseMode, RenderOpts};

const SEPARATOR: &str = "\n\n-- sqlfmt-corpus-separator --\n\n";

fn default_opts() -> RenderOpts {
    RenderOpts {
        line_width: 1000,
        use_tabs: false,
        tab_width: 4,
        case: CaseMode::Upper,
    }
}

fn all_sources() -> Vec<Box<dyn CorpusSource>> {
    vec![
        Box::new(MaterializeCorpus),
        Box::new(PostgresCorpus),
        Box::new(CockroachDbCorpus),
    ]
}

fn get_dialect(name: &str) -> Option<Box<dyn sqlfmt_core::Dialect>> {
    match name {
        "materialize" => Some(Box::new(dialect_materialize::MaterializeDialect)),
        "postgres" => Some(Box::new(dialect_postgres::PostgresDialect)),
        _ => None,
    }
}

#[test]
#[ignore]
fn test_external_corpus() {
    let cache_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../target/sqlfmt-corpus-cache");
    let testdata_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("testdata");

    let opts = default_opts();

    let sources = all_sources();
    let dialects: &[(&str, &dyn sqlfmt_core::Dialect)] = &[
        ("materialize", &dialect_materialize::MaterializeDialect),
        ("postgres", &dialect_postgres::PostgresDialect),
    ];

    let mut failures: Vec<(String, String, String)> = Vec::new();

    for source in &sources {
        let stmts = match source.fetch(&cache_dir) {
            Ok(s) => s,
            Err(e) => {
                eprintln!("Skipping {}: {}", source.name(), e);
                continue;
            }
        };

        for stmt in &stmts {
            for (dialect_name, dialect) in dialects {
                match format_sql(*dialect, stmt, &opts) {
                    Ok(_) => {}
                    Err(SqlfmtError::Parse(_)) => {}
                    Err(SqlfmtError::Roundtrip { .. }) => {
                        failures.push((source.name().to_owned(), dialect_name.to_string(), stmt.clone()));
                    }
                }
            }
        }
    }

    fs::create_dir_all(&testdata_dir).expect("failed to create testdata dir");

    let mut new_failures = 0usize;

    let mut grouped: std::collections::HashMap<(String, String), Vec<String>> = std::collections::HashMap::new();
    for (source_name, dialect_name, stmt) in failures {
        grouped.entry((source_name, dialect_name)).or_default().push(stmt);
    }

    for ((source_name, dialect_name), stmts) in &grouped {
        let file_path = testdata_dir.join(format!("{source_name}-{dialect_name}.sql"));

        let existing = if file_path.exists() {
            fs::read_to_string(&file_path).unwrap_or_default()
        } else {
            String::new()
        };

        let mut seen: std::collections::HashSet<String> =
            existing.split(SEPARATOR).map(|s| s.trim().to_owned()).collect();

        let mut content = existing.clone();
        for stmt in stmts {
            let key = stmt.trim().to_owned();
            if seen.contains(&key) {
                continue;
            }
            seen.insert(key);
            if content.is_empty() {
                content.push_str(stmt);
            } else {
                content.push_str(SEPARATOR);
                content.push_str(stmt);
            }
            new_failures += 1;
        }

        if content != existing {
            fs::write(&file_path, &content).expect("failed to write testdata file");
        }
    }

    if new_failures > 0 {
        println!("Roundtrip failures found: {new_failures}. Saved to testdata/.");
        panic!("{new_failures} roundtrip failures — see testdata/ for details");
    }
}

#[test]
fn test_permanent_corpus() {
    let testdata_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("testdata");

    if !testdata_dir.exists() {
        return;
    }

    let sql_files: Vec<_> = fs::read_dir(&testdata_dir)
        .expect("failed to read testdata dir")
        .filter_map(|e| e.ok())
        .filter(|e| e.path().extension().and_then(|s| s.to_str()) == Some("sql"))
        .collect();

    if sql_files.is_empty() {
        return;
    }

    let opts = default_opts();
    let mut test_failures: Vec<String> = Vec::new();

    for entry in sql_files {
        let path = entry.path();
        let filename = path.file_name().and_then(|s| s.to_str()).unwrap_or("");
        let stem = path.file_stem().and_then(|s| s.to_str()).unwrap_or("");

        let dialect_name = match stem.rfind('-') {
            Some(pos) => &stem[pos + 1..],
            None => {
                eprintln!("skipping {filename}: no dialect suffix in filename");
                continue;
            }
        };

        let dialect = match get_dialect(dialect_name) {
            Some(d) => d,
            None => {
                eprintln!("skipping {filename}: unknown dialect '{dialect_name}'");
                continue;
            }
        };

        let content = match fs::read_to_string(&path) {
            Ok(c) => c,
            Err(e) => {
                test_failures.push(format!("[{filename}]: failed to read: {e}"));
                continue;
            }
        };

        for stmt in content.split(SEPARATOR) {
            let stmt = stmt.trim();
            if stmt.is_empty() {
                continue;
            }
            match format_sql(&*dialect, stmt, &opts) {
                Ok(_) => {}
                Err(SqlfmtError::Parse(_)) => {}
                Err(e) => {
                    test_failures.push(format!("[{filename}/{stmt}]: {e}"));
                }
            }
        }
    }

    if !test_failures.is_empty() {
        let n = test_failures.len();
        for f in &test_failures {
            eprintln!("{f}");
        }
        panic!("{n} permanent corpus statements failed roundtrip");
    }
}
