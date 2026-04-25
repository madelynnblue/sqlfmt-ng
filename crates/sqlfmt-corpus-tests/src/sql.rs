pub fn parse_sql(content: &str) -> Vec<String> {
    content
        .split(';')
        .filter_map(|chunk| {
            let filtered: String = chunk
                .lines()
                .filter(|line| !line.trim_start().starts_with("--"))
                .collect::<Vec<_>>()
                .join("\n");
            let trimmed = filtered.trim().to_string();
            if trimmed.is_empty() {
                None
            } else {
                Some(trimmed)
            }
        })
        .collect()
}
