/// Parse a .dot file into individual graph statements.
/// DOT files can contain comments (// and /* */) and multiple graphs
/// separated by blank lines.
pub fn parse_dot(content: &str) -> Vec<String> {
    let mut statements = Vec::new();
    let blocks: Vec<&str> = content.split("\n\n").collect();

    for block in blocks {
        let trimmed = block.trim();
        if !trimmed.is_empty() && !trimmed.starts_with("//") && !trimmed.starts_with("/*") {
            if let Some(_start) = trimmed.find('{') {
                if let Some(_end) = trimmed.rfind('}') {
                    statements.push(trimmed.to_string());
                }
            }
        }
    }
    statements
}
