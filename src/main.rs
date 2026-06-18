use clap::{Parser, ValueEnum};
use sqlfmt_core::format_sql;
use sqlfmt_render::{CaseMode, RenderOpts};
use std::io::{self, Read};

#[derive(Debug, Clone, Copy, ValueEnum)]
enum CaseArg {
    Upper,
    Lower,
    Title,
}

#[derive(Parser, Debug)]
#[command(name = "sqlfmt", about = "SQL formatter")]
struct Args {
    /// SQL dialect: graphviz, json, materialize, postgres, or sqlparser:<name>
    /// (sqlparser dialects: generic, postgresql, mysql, sqlite, bigquery,
    ///  clickhouse, databricks, duckdb, hive, mssql, oracle, redshift,
    ///  snowflake, ansi)
    #[arg(long, default_value = "materialize")]
    dialect: String,

    /// Target line width
    #[arg(long, default_value_t = 60)]
    width: usize,

    /// Spaces per indent level
    #[arg(long, default_value_t = 4)]
    tab_width: usize,

    /// Use tab characters instead of spaces
    #[arg(long)]
    use_tabs: bool,

    /// Keyword case transformation
    #[arg(long, default_value = "upper")]
    case: CaseArg,

    /// SQL statement (reads from stdin if omitted)
    #[arg(long)]
    stmt: Option<String>,
}

fn main() {
    let args = Args::parse();

    let sql = match &args.stmt {
        Some(s) => s.clone(),
        None => {
            let mut buf = String::new();
            io::stdin()
                .read_to_string(&mut buf)
                .expect("failed to read stdin");
            buf
        }
    };

    let opts = RenderOpts {
        line_width: args.width,
        use_tabs: args.use_tabs,
        tab_width: args.tab_width,
        case: match args.case {
            CaseArg::Upper => CaseMode::Upper,
            CaseArg::Lower => CaseMode::Lower,
            CaseArg::Title => CaseMode::Title,
        },
        error_on_unformatted: false,
    };

    let result = match args.dialect.as_str() {
        "graphviz" => {
            let opts = RenderOpts {
                case: CaseMode::Lower,
                ..opts
            };
            format_sql(&dialect_graphviz::GraphvizDialect, &sql, &opts)
        },
        "json" => format_sql(&dialect_json::JsonDialect, &sql, &opts),
        "materialize" => format_sql(&dialect_materialize::MaterializeDialect, &sql, &opts),
        "postgres" => format_sql(&dialect_postgres::PostgresDialect, &sql, &opts),
        other => {
            if let Some(name) = other.strip_prefix("sqlparser:") {
                let d = match dialect_sqlparser::SqlparserDialect::from_name(name) {
                    Some(d) => d,
                    None => {
                        eprintln!("error: unknown sqlparser dialect: {name}");
                        std::process::exit(1);
                    }
                };
                format_sql(&d, &sql, &opts)
            } else {
                eprintln!("error: unknown dialect: {other}");
                eprintln!("  supported: graphviz, json, materialize, postgres, sqlparser:<name>");
                std::process::exit(1);
            }
        }
    };

    match result {
        Ok(formatted) => println!("{formatted}"),
        Err(e) => {
            eprintln!("error: {e}");
            std::process::exit(1);
        }
    }
}
