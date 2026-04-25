pub fn parse_slt(content: &str) -> Vec<String> {
    enum State {
        Idle,
        CollectingSql(Vec<String>),
    }

    fn finish(lines: Vec<String>, results: &mut Vec<String>) {
        let sql = lines.join("\n");
        let sql = sql.trim().to_string();
        if !sql.is_empty() {
            results.push(sql);
        }
    }

    let mut results = Vec::new();
    let mut state = State::Idle;
    let mut halted = false;

    for line in content.lines() {
        if line.starts_with('#') {
            continue;
        }
        if line.trim() == "halt" {
            halted = true;
            break;
        }
        match state {
            State::Idle => {
                if line.starts_with("statement ") || line.starts_with("query ") {
                    state = State::CollectingSql(Vec::new());
                }
            }
            State::CollectingSql(ref mut lines) => {
                if line.trim().is_empty() || line.trim() == "----" {
                    let collected = std::mem::take(lines);
                    finish(collected, &mut results);
                    state = State::Idle;
                } else if line.starts_with("statement ") || line.starts_with("query ") {
                    let collected = std::mem::take(lines);
                    finish(collected, &mut results);
                    state = State::CollectingSql(Vec::new());
                } else {
                    lines.push(line.to_string());
                }
            }
        }
    }

    if !halted {
        if let State::CollectingSql(lines) = state {
            finish(lines, &mut results);
        }
    }

    results
}
