use clap::{Parser, ValueEnum};
use sqlfmt_core::format_sql;
use sqlfmt_render::{CaseMode, RenderOpts};
use std::io::{self, Read};

#[derive(Debug, Clone, Copy, ValueEnum)]
enum DialectArg {
    Materialize,
    Postgres,
}

#[derive(Debug, Clone, Copy, ValueEnum)]
enum CaseArg {
    Upper,
    Lower,
    Title,
}

#[derive(Parser, Debug)]
#[command(name = "sqlfmt", about = "SQL formatter")]
struct Args {
    /// SQL dialect
    #[arg(long, default_value = "materialize")]
    dialect: DialectArg,

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
    };

    let result = match args.dialect {
        DialectArg::Materialize => {
            format_sql(&dialect_materialize::MaterializeDialect, &sql, &opts)
        }
        DialectArg::Postgres => format_sql(&dialect_postgres::PostgresDialect, &sql, &opts),
    };

    match result {
        Ok(formatted) => println!("{formatted}"),
        Err(e) => {
            eprintln!("error: {e}");
            std::process::exit(1);
        }
    }
}
