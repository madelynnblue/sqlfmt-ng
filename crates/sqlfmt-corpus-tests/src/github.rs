use std::fs;
use std::path::{Path, PathBuf};

pub enum CorpusFormat {
    Slt,
    Sql,
}

pub struct GithubFetcher {
    pub owner: &'static str,
    pub repo: &'static str,
    pub git_ref: &'static str,
    pub path_prefix: &'static str,
    pub extension: &'static str,
    pub format: CorpusFormat,
}

#[derive(serde::Deserialize)]
struct TreeResponse {
    tree: Vec<TreeEntry>,
    truncated: bool,
}

#[derive(serde::Deserialize)]
struct TreeEntry {
    path: String,
    #[serde(rename = "type")]
    entry_type: String,
}

fn github_token() -> Option<String> {
    std::env::var("GITHUB_TOKEN").ok()
}

fn authed_get(url: &str) -> ureq::Request {
    let req = ureq::get(url).set("User-Agent", "sqlfmt-corpus-tests");
    match github_token() {
        Some(token) => req.set("Authorization", &format!("Bearer {token}")),
        None => req,
    }
}

impl GithubFetcher {
    pub fn list_files(&self) -> Result<Vec<String>, Box<dyn std::error::Error>> {
        let url = format!(
            "https://api.github.com/repos/{}/{}/git/trees/{}?recursive=1",
            self.owner, self.repo, self.git_ref
        );
        let response = authed_get(&url)
            .set("Accept", "application/vnd.github+json")
            .call()?;
        let body = response.into_string()?;
        let parsed: TreeResponse = serde_json::from_str(&body)?;
        if parsed.truncated {
            return Err("GitHub tree response was truncated; set GITHUB_TOKEN env var and delete target/sqlfmt-corpus-cache/ to retry".into());
        }
        let paths = parsed
            .tree
            .into_iter()
            .filter(|e| {
                e.entry_type == "blob"
                    && e.path.starts_with(self.path_prefix)
                    && (self.extension.is_empty() || e.path.ends_with(self.extension))
            })
            .map(|e| e.path)
            .collect();
        Ok(paths)
    }

    pub fn download_file(&self, path: &str) -> Result<String, Box<dyn std::error::Error>> {
        let url = format!(
            "https://raw.githubusercontent.com/{}/{}/{}/{}",
            self.owner, self.repo, self.git_ref, path
        );
        let response = authed_get(&url).call()?;
        let body = response.into_string()?;
        Ok(body)
    }

    pub fn fetch(
        &self,
        source_name: &str,
        cache_dir: &Path,
    ) -> Result<Vec<String>, Box<dyn std::error::Error>> {
        let source_cache_dir = cache_dir.join(source_name);
        fs::create_dir_all(&source_cache_dir)?;

        let paths = self.list_files()?;
        let mut statements = Vec::new();

        for path in &paths {
            let sanitized = path.replace('/', "_");
            let cache_file: PathBuf = source_cache_dir.join(&sanitized);

            let content = if cache_file.exists() {
                fs::read_to_string(&cache_file)?
            } else {
                let downloaded = self.download_file(path)?;
                fs::write(&cache_file, &downloaded)?;
                downloaded
            };

            let stmts = match self.format {
                CorpusFormat::Slt => crate::slt::parse_slt(&content),
                CorpusFormat::Sql => crate::sql::parse_sql(&content),
            };
            statements.extend(stmts);
        }

        Ok(statements)
    }
}
