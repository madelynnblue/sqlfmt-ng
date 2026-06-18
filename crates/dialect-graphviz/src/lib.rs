use sqlfmt_core::{Dialect, SqlfmtError};
use sqlfmt_ir::Node;
use sqlfmt_render::RenderOpts;

mod convert;

pub struct GraphvizDialect;

impl Dialect for GraphvizDialect {
    fn default_render_opts(&self) -> RenderOpts {
        RenderOpts {
            line_width: 60,
            use_tabs: false,
            tab_width: 4,
            case: sqlfmt_render::CaseMode::Lower,
            error_on_unformatted: true,
        }
    }

    fn parse(&self, sql: &str) -> Result<Node, SqlfmtError> {
        use dot_parser::ast::Graph;

        // Graph::try_from(&str) returns Graph<(ID, ID)> where ID borrows from
        // the input. We convert to Graph<(String, String)> which is what the
        // convert module expects.
        let borrowed = Graph::try_from(sql)
            .map_err(|e| SqlfmtError::Parse(e.to_string()))?;
        let owned = borrowed.filter_map(&|(k, v)| Some((k.into(), v.into())));

        Ok(convert::graph_to_node(&owned))
    }

    fn ast_equal(&self, sql: &str, rendered: &str) -> Result<(), SqlfmtError> {
        use dot_parser::ast::Graph;

        let original: Graph<(String, String)> = {
            let g = Graph::try_from(sql)
                .map_err(|e| SqlfmtError::Parse(format!("original: {e}")))?;
            g.filter_map(&|(k, v)| Some((k.into(), v.into())))
        };

        let formatted: Graph<(String, String)> = {
            let g = Graph::try_from(rendered)
                .map_err(|e| SqlfmtError::Parse(format!("rendered: {e}")))?;
            g.filter_map(&|(k, v)| Some((k.into(), v.into())))
        };

        if original == formatted {
            Ok(())
        } else {
            Err(SqlfmtError::Roundtrip {
                input: sql.to_owned(),
                output: rendered.to_owned(),
            })
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use sqlfmt_render::RenderOpts;

    #[test]
    fn test_parse_simple_digraph() {
        let dialect = GraphvizDialect;
        let node = dialect.parse("digraph G { a -> b; }").unwrap();
        // Should produce a Node that can be rendered
        let opts = RenderOpts {
            line_width: 60,
            case: sqlfmt_render::CaseMode::Lower,
            ..Default::default()
        };
        let rendered = opts.render(&node).unwrap();
        assert!(rendered.contains("digraph"));
        assert!(rendered.contains("a"));
        assert!(rendered.contains("b"));
        assert!(rendered.contains("->"));
    }

    #[test]
    fn test_parse_simple_graph() {
        let dialect = GraphvizDialect;
        let node = dialect.parse("graph G { a -- b; }").unwrap();
        let opts = RenderOpts {
            line_width: 60,
            case: sqlfmt_render::CaseMode::Lower,
            ..Default::default()
        };
        let rendered = opts.render(&node).unwrap();
        assert!(rendered.contains("graph"));
        assert!(rendered.contains("--"));
    }

    #[test]
    fn test_parse_with_attributes() {
        let dialect = GraphvizDialect;
        let node = dialect.parse(r#"digraph { a [label="hello"]; }"#).unwrap();
        let opts = RenderOpts {
            line_width: 60,
            case: sqlfmt_render::CaseMode::Lower,
            ..Default::default()
        };
        let rendered = opts.render(&node).unwrap();
        assert!(rendered.contains("label"));
        assert!(rendered.contains("hello"));
    }

    #[test]
    fn test_parse_invalid_syntax() {
        let dialect = GraphvizDialect;
        let result = dialect.parse("not valid dot at all");
        assert!(result.is_err());
    }

    #[test]
    fn test_ast_equal_matches() {
        let dialect = GraphvizDialect;
        // ast_equal should be OK when ASTs are the same
        let result = dialect.ast_equal("digraph { a -> b; }", "digraph { a -> b; }");
        assert!(result.is_ok());
    }

    #[test]
    fn test_ast_equal_differs() {
        let dialect = GraphvizDialect;
        // ast_equal should fail when ASTs differ
        let result = dialect.ast_equal("digraph { a -> b; }", "digraph { a -> c; }");
        assert!(result.is_err());
    }

    #[test]
    fn test_roundtrip_via_format_sql() {
        use sqlfmt_core::format_sql;
        let dialect = GraphvizDialect;
        let opts = RenderOpts {
            line_width: 60,
            case: sqlfmt_render::CaseMode::Lower,
            ..Default::default()
        };
        let result = format_sql(&dialect, "digraph G { a -> b; }", &opts);
        assert!(result.is_ok(), "format_sql failed: {:?}", result.err());
        let output = result.unwrap();
        assert!(output.contains("digraph"));
        assert!(output.contains("a"));
        assert!(output.contains("b"));
        assert!(output.contains("->"));
    }

    #[test]
    fn test_roundtrip_multi_stmt() {
        use sqlfmt_core::format_sql;
        let dialect = GraphvizDialect;
        let opts = RenderOpts {
            line_width: 60,
            case: sqlfmt_render::CaseMode::Lower,
            ..Default::default()
        };
        let result = format_sql(&dialect, "digraph { a -> b; c -> d; }", &opts);
        assert!(result.is_ok(), "format_sql multi_stmt failed: {:?}", result.err());
    }

    #[test]
    fn test_roundtrip_with_attrs() {
        use sqlfmt_core::format_sql;
        let dialect = GraphvizDialect;
        let opts = RenderOpts {
            line_width: 60,
            case: sqlfmt_render::CaseMode::Lower,
            ..Default::default()
        };
        let result = format_sql(
            &dialect,
            r#"digraph { a [label="hello"]; b [color=red]; }"#,
            &opts,
        );
        assert!(result.is_ok(), "format_sql with attrs failed: {:?}", result.err());
    }

    #[test]
    fn test_roundtrip_strict() {
        use sqlfmt_core::format_sql;
        let dialect = GraphvizDialect;
        let opts = RenderOpts {
            line_width: 60,
            case: sqlfmt_render::CaseMode::Lower,
            ..Default::default()
        };
        let result = format_sql(&dialect, "strict digraph G { a -> b; }", &opts);
        assert!(result.is_ok(), "format_sql strict failed: {:?}", result.err());
    }

    #[test]
    fn test_roundtrip_undirected() {
        use sqlfmt_core::format_sql;
        let dialect = GraphvizDialect;
        let opts = RenderOpts {
            line_width: 60,
            case: sqlfmt_render::CaseMode::Lower,
            ..Default::default()
        };
        let result = format_sql(&dialect, "graph G { a -- b; }", &opts);
        assert!(result.is_ok(), "format_sql undirected failed: {:?}", result.err());
    }

    #[test]
    fn test_roundtrip_edge_chain() {
        use sqlfmt_core::format_sql;
        let dialect = GraphvizDialect;
        let opts = RenderOpts {
            line_width: 60,
            case: sqlfmt_render::CaseMode::Lower,
            ..Default::default()
        };
        let result = format_sql(&dialect, "digraph { a -> b -> c; }", &opts);
        assert!(result.is_ok(), "format_sql edge chain failed: {:?}", result.err());
    }

    #[test]
    fn test_roundtrip_attr_stmt() {
        use sqlfmt_core::format_sql;
        let dialect = GraphvizDialect;
        let opts = RenderOpts {
            line_width: 60,
            case: sqlfmt_render::CaseMode::Lower,
            ..Default::default()
        };
        let result = format_sql(&dialect, "digraph { graph [rankdir=LR]; a -> b; }", &opts);
        assert!(result.is_ok(), "format_sql attr stmt failed: {:?}", result.err());
    }

    #[test]
    fn test_roundtrip_empty_body() {
        use sqlfmt_core::format_sql;
        let dialect = GraphvizDialect;
        let opts = RenderOpts {
            line_width: 60,
            case: sqlfmt_render::CaseMode::Lower,
            ..Default::default()
        };
        let result = format_sql(&dialect, "digraph G {}", &opts);
        assert!(result.is_ok(), "format_sql empty body failed: {:?}", result.err());
    }

}
