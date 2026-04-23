use pretty::RcDoc;
use sqlfmt_ir::{Clause, Node};

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum CaseMode {
    Upper,
    Lower,
    Title,
}

#[derive(Debug, Clone)]
pub struct RenderOpts {
    pub line_width: usize,
    pub use_tabs: bool,
    pub tab_width: usize,
    pub case: CaseMode,
}

impl Default for RenderOpts {
    fn default() -> Self {
        Self {
            line_width: 60,
            use_tabs: false,
            tab_width: 4,
            case: CaseMode::Upper,
        }
    }
}

fn apply_case(s: &str, mode: CaseMode) -> String {
    match mode {
        CaseMode::Upper => s.to_uppercase(),
        CaseMode::Lower => s.to_lowercase(),
        CaseMode::Title => {
            let lower = s.to_lowercase();
            let mut chars = lower.chars();
            match chars.next() {
                None => String::new(),
                Some(c) => c.to_uppercase().collect::<String>() + chars.as_str(),
            }
        }
    }
}

pub fn render(node: &Node, opts: &RenderOpts) -> String {
    let doc = to_rdoc(node, opts);
    let mut w = Vec::new();
    doc.render(opts.line_width, &mut w).unwrap();
    let s = String::from_utf8(w).unwrap();
    if opts.use_tabs {
        // Replace each leading run of `tab_width` spaces on every line with a tab.
        // This is a post-processing step because the `pretty` crate always emits spaces.
        let indent = " ".repeat(opts.tab_width.max(1));
        s.lines()
            .map(|line| {
                let mut rest = line;
                let mut tabs = 0usize;
                while let Some(stripped) = rest.strip_prefix(indent.as_str()) {
                    tabs += 1;
                    rest = stripped;
                }
                format!("{}{}", "\t".repeat(tabs), rest)
            })
            .collect::<Vec<_>>()
            .join("\n")
    } else {
        s
    }
}

fn to_rdoc<'a>(node: &Node, opts: &RenderOpts) -> RcDoc<'a> {
    match node {
        Node::Clauses { items } => {
            let docs: Vec<RcDoc> = items.iter().map(|c| clause_to_rdoc(c, opts)).collect();
            RcDoc::intersperse(docs, RcDoc::hardline())
        }
        Node::List { items, separator } => {
            let sep_str = separator.as_deref().unwrap_or(",");
            let sep = RcDoc::text(sep_str.to_owned()).append(RcDoc::line());
            let docs: Vec<RcDoc> = items.iter().map(|n| to_rdoc(n, opts)).collect();
            RcDoc::intersperse(docs, sep).group()
        }
        Node::Wrap {
            keyword,
            open,
            content,
            close,
        } => {
            let prefix: RcDoc = if let Some(kw) = keyword {
                RcDoc::text(apply_case(kw, opts.case)).append(RcDoc::text(open.clone()))
            } else {
                RcDoc::text(open.clone())
            };
            prefix
                .append(to_rdoc(content, opts))
                .append(RcDoc::text(close.clone()))
        }
        Node::Infix { op, items } => {
            let sep = RcDoc::line()
                .append(RcDoc::text(op.clone()))
                .append(RcDoc::space());
            let docs: Vec<RcDoc> = items.iter().map(|n| to_rdoc(n, opts)).collect();
            RcDoc::intersperse(docs, sep).group()
        }
        Node::Keyword { value } => RcDoc::text(apply_case(value, opts.case)),
        Node::Identifier { value, quote } => match quote {
            Some(q) => RcDoc::text(format!("{q}{value}{q}")),
            None => RcDoc::text(value.clone()),
        },
        Node::Literal { value } => RcDoc::text(value.clone()),
        Node::Text { value } => RcDoc::text(value.clone()),
        Node::Concat { items } => {
            let docs: Vec<RcDoc> = items.iter().map(|n| to_rdoc(n, opts)).collect();
            RcDoc::concat(docs)
        }
        Node::Group { content } => to_rdoc(content, opts).group(),
        Node::Nest { content } => {
            to_rdoc(content, opts).nest(opts.tab_width as isize)
        }
        Node::Line => RcDoc::line(),
        Node::Hardline => RcDoc::hardline(),
    }
}

fn clause_to_rdoc<'a>(clause: &Clause, opts: &RenderOpts) -> RcDoc<'a> {
    let kw = RcDoc::text(apply_case(&clause.keyword, opts.case));
    match &clause.body {
        None => kw,
        Some(body) => {
            let body_doc = to_rdoc(body, opts);
            // Nest the line break + body together so that when broken, the body
            // is indented by tab_width relative to the clause keyword.
            kw.append(
                RcDoc::line()
                    .append(body_doc)
                    .nest(opts.tab_width as isize),
            )
            .group()
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use sqlfmt_ir::{Clause, Node};

    fn opts() -> RenderOpts {
        RenderOpts::default()
    }

    #[test]
    fn test_keyword_upper() {
        let node = Node::Keyword { value: "select".into() };
        assert_eq!(render(&node, &opts()), "SELECT");
    }

    #[test]
    fn test_keyword_lower() {
        let node = Node::Keyword { value: "SELECT".into() };
        let o = RenderOpts { case: CaseMode::Lower, ..RenderOpts::default() };
        assert_eq!(render(&node, &o), "select");
    }

    #[test]
    fn test_literal() {
        let node = Node::Literal { value: "42".into() };
        assert_eq!(render(&node, &opts()), "42");
    }

    #[test]
    fn test_identifier_unquoted() {
        let node = Node::Identifier { value: "my_table".into(), quote: None };
        assert_eq!(render(&node, &opts()), "my_table");
    }

    #[test]
    fn test_identifier_quoted() {
        let node = Node::Identifier {
            value: "my table".into(),
            quote: Some("\"".into()),
        };
        assert_eq!(render(&node, &opts()), "\"my table\"");
    }

    #[test]
    fn test_wrap_no_keyword() {
        let node = Node::Wrap {
            keyword: None,
            open: "(".into(),
            content: Box::new(Node::Literal { value: "1".into() }),
            close: ")".into(),
        };
        assert_eq!(render(&node, &opts()), "(1)");
    }

    #[test]
    fn test_wrap_with_keyword() {
        let node = Node::Wrap {
            keyword: Some("count".into()),
            open: "(".into(),
            content: Box::new(Node::Identifier { value: "x".into(), quote: None }),
            close: ")".into(),
        };
        assert_eq!(render(&node, &opts()), "COUNT(x)");
    }

    #[test]
    fn test_select_fits_one_line() {
        let node = Node::Clauses {
            items: vec![
                Clause {
                    keyword: "SELECT".into(),
                    body: Some(Box::new(Node::List {
                        items: vec![
                            Node::Identifier { value: "a".into(), quote: None },
                            Node::Identifier { value: "b".into(), quote: None },
                        ],
                        separator: None,
                    })),
                },
                Clause {
                    keyword: "FROM".into(),
                    body: Some(Box::new(Node::Identifier {
                        value: "t".into(),
                        quote: None,
                    })),
                },
            ],
        };
        let wide = RenderOpts { line_width: 1000, ..RenderOpts::default() };
        let result = render(&node, &wide);
        assert_eq!(result, "SELECT a, b\nFROM t");
    }

    #[test]
    fn test_infix_and() {
        let node = Node::Infix {
            op: "AND".into(),
            items: vec![
                Node::Literal { value: "a".into() },
                Node::Literal { value: "b".into() },
            ],
        };
        let wide = RenderOpts { line_width: 1000, ..RenderOpts::default() };
        let result = render(&node, &wide);
        assert_eq!(result, "a AND b");
    }

    #[test]
    fn test_keyword_title() {
        let node = Node::Keyword { value: "select".into() };
        let o = RenderOpts { case: CaseMode::Title, ..RenderOpts::default() };
        assert_eq!(render(&node, &o), "Select");
    }

    #[test]
    fn test_use_tabs_indentation() {
        // A clause with body rendered narrow so body is on its own indented line.
        let node = Node::Clauses {
            items: vec![Clause {
                keyword: "SELECT".into(),
                body: Some(Box::new(Node::Identifier { value: "my_col".into(), quote: None })),
            }],
        };
        // Force break by using a very narrow line width (1 char).
        let tab_opts = RenderOpts { line_width: 1, use_tabs: true, tab_width: 4, case: CaseMode::Upper };
        let result = render(&node, &tab_opts);
        // The body should be indented with a tab, not spaces.
        assert!(result.contains("\tmy_col"), "expected tab indent, got: {:?}", result);
        assert!(!result.contains("    my_col"), "should not have space indent, got: {:?}", result);
    }
}
