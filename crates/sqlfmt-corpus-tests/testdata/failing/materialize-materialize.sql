EXPLAIN RAW PLAN FOR
    SELECT 'a'::"char" < 'a'::char;

-- sqlfmt-corpus-separator --

EXPLAIN RAW PLAN FOR
    SELECT 'a'::"char" < 'a'::varchar;

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::char;

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::varchar;

-- sqlfmt-corpus-separator --

SELECT 'a'::character = 'a'::"char";

-- sqlfmt-corpus-separator --

SELECT 'abc'::char::"char";

-- sqlfmt-corpus-separator --

SELECT 'abc'::text::"char";

-- sqlfmt-corpus-separator --

SELECT 'abc'::varchar::"char";

-- sqlfmt-corpus-separator --

SELECT COALESCE('a'::"char", 'a'::char);

-- sqlfmt-corpus-separator --

SELECT COALESCE('a'::"char", 'a'::varchar);

-- sqlfmt-corpus-separator --

SELECT COALESCE('a'::char, 'a'::"char");

-- sqlfmt-corpus-separator --

SELECT COALESCE('a'::varchar, 'a'::"char");

-- sqlfmt-corpus-separator --

SELECT pg_typeof('a'::"char"::char);

-- sqlfmt-corpus-separator --

SELECT pg_typeof('a'::"char"::text);

-- sqlfmt-corpus-separator --

SELECT pg_typeof('a'::"char"::varchar);

-- sqlfmt-corpus-separator --

SELECT pg_typeof('abc'::char::"char");

-- sqlfmt-corpus-separator --

SELECT pg_typeof('abc'::text::"char");

-- sqlfmt-corpus-separator --

SELECT pg_typeof('abc'::varchar::"char");

-- sqlfmt-corpus-separator --

SELECT pg_typeof(coalesce('1'::"char", '1'::char));