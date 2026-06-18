use crate::CorpusSource;
use crate::github::{CorpusFormat, GithubFetcher};
use std::path::Path;

pub fn all_sources() -> Vec<Box<dyn CorpusSource>> {
    vec![
        Box::new(MaterializeCorpus),
        Box::new(PostgresCorpus),
        Box::new(CockroachDbCorpus),
        Box::new(GraphvizCorpus),
    ]
}

pub struct MaterializeCorpus;
pub struct PostgresCorpus;
pub struct CockroachDbCorpus;
pub struct GraphvizCorpus;

impl CorpusSource for MaterializeCorpus {
    fn name(&self) -> &str {
        "materialize"
    }

    fn fetch(&self, cache_dir: &Path) -> Result<Vec<String>, Box<dyn std::error::Error>> {
        GithubFetcher {
            owner: "MaterializeInc",
            repo: "materialize",
            git_ref: "main",
            path_prefix: "test/sqllogictest/",
            extension: ".slt",
            format: CorpusFormat::Slt,
        }
        .fetch("materialize", cache_dir)
    }
}

impl CorpusSource for PostgresCorpus {
    fn name(&self) -> &str {
        "postgres"
    }

    fn fetch(&self, cache_dir: &Path) -> Result<Vec<String>, Box<dyn std::error::Error>> {
        GithubFetcher {
            owner: "postgres",
            repo: "postgres",
            git_ref: "master",
            path_prefix: "src/test/regress/sql/",
            extension: ".sql",
            format: CorpusFormat::Sql,
        }
        .fetch("postgres", cache_dir)
    }
}

impl CorpusSource for CockroachDbCorpus {
    fn name(&self) -> &str {
        "cockroachdb"
    }

    fn fetch(&self, cache_dir: &Path) -> Result<Vec<String>, Box<dyn std::error::Error>> {
        GithubFetcher {
            owner: "cockroachdb",
            repo: "cockroach",
            git_ref: "master",
            path_prefix: "pkg/sql/logictest/testdata/logic_test/",
            extension: "",
            format: CorpusFormat::Slt,
        }
        .fetch("cockroachdb", cache_dir)
    }
}

impl CorpusSource for GraphvizCorpus {
    fn name(&self) -> &str {
        "graphviz"
    }

    fn fetch(&self, cache_dir: &Path) -> Result<Vec<String>, Box<dyn std::error::Error>> {
        GithubFetcher {
            owner: "graphviz",
            repo: "graphviz",
            git_ref: "main",
            path_prefix: "",
            extension: ".dot",
            format: CorpusFormat::Graphviz,
        }
        .fetch("graphviz", cache_dir)
    }
}
