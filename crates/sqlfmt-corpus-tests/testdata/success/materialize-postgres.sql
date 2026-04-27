SELECT
    '1971-03-18'::DATE + 300866802885581286

-- sqlfmt-corpus-separator --

SELECT
    NULL::jsonb::text,
    NULL::jsonb::int4,
    NULL::jsonb::int8,
    NULL::jsonb::float4,
    NULL::jsonb::float8,
    NULL::jsonb::decimal,
    NULL::jsonb::bool

-- sqlfmt-corpus-separator --

SELECT
  *,
  first_value(
    lag(x*x,y,1111) OVER (PARTITION BY x ORDER BY y)
  ) OVER (PARTITION BY x ORDER BY y),
  x*y,
  last_value(
    lag(x*x,y,2222) OVER (PARTITION BY x ORDER BY y)
  ) OVER (PARTITION BY x ORDER BY y+y),
  last_value(x+y) OVER (PARTITION BY x ORDER BY y+y),
  lag(y)          OVER (ORDER BY x),
  x+y
FROM t7
ORDER BY x,y;

-- sqlfmt-corpus-separator --

SELECT
  *,
  lag(x)          OVER (ORDER BY x),
  first_value(x)  OVER (ORDER BY x),
  last_value(x)   OVER (ORDER BY x),
  x*y,
  lag(y)          OVER (ORDER BY x),
  lag(x+x,1,null) OVER (PARTITION BY x ORDER BY y),
  lead(x,2,null)  OVER (PARTITION BY x ORDER BY -y NULLS FIRST),
  lead(x,2,null)  OVER (PARTITION BY x ORDER BY -y NULLS LAST),
  x+y,
  lag(x+x,2,null) OVER (PARTITION BY x ORDER BY y),
  sum(x)          OVER (ORDER BY x),
  min(x)          OVER (ORDER BY x),
  max(x)          OVER (ORDER BY y)
FROM t7
ORDER BY x,y;

-- sqlfmt-corpus-separator --

SELECT
  a,
  3 + lag(a) OVER (ORDER BY a),
  3 + lag(a) OVER (ORDER BY a),
  lag(a) OVER (ORDER BY a),
  lead(a) OVER (ORDER BY a),
  5 + lag(a) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT
  array_agg(y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  avg(y+y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  count(*) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  count(min(x)) OVER ()
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  count(y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  killmail::int4,
  ship::int4,
  cost::int8,
  solarsystem::int4,
  hi::jsonb,
  med::jsonb,
  low::jsonb,
  rig::jsonb,
  sub::jsonb,
  items::jsonb
FROM t

-- sqlfmt-corpus-separator --

SELECT
  lag(x,y,100) OVER (PARTITION BY x ORDER BY y+y)
FROM t9;

-- sqlfmt-corpus-separator --

SELECT
  lead(x,y-2,120) OVER (PARTITION BY x ORDER BY x)
FROM t9;

-- sqlfmt-corpus-separator --

SELECT
  length(s),
  count(DISTINCT s),
  count(DISTINCT length(s))
FROM kv GROUP BY length(s) HAVING count(DISTINCT s) > 1

-- sqlfmt-corpus-separator --

SELECT
  min(count(x)) OVER ()
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  min(y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  name,
  type,
  interval,
  now() - aligned_to < INTERVAL '30 minutes',
  now() - at < INTERVAL '30 minutes'
FROM mz_internal.mz_materialized_view_refresh_strategies mvrs, mz_catalog.mz_materialized_views mv
WHERE mv.id LIKE 'u%' AND mv.id = mvrs.materialized_view_id
ORDER BY name;

-- sqlfmt-corpus-separator --

SELECT
  sum(sum(x)) OVER ()
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  lag(x,y,100)    OVER (PARTITION BY x ORDER BY y+y),
  lag(x,y,110)    OVER (PARTITION BY x ORDER BY y+y),
  lag(x,y,100)    OVER (PARTITION BY x ORDER BY y+y),
  first_value(y)  OVER (PARTITION BY x ORDER BY y+y),
  last_value(y)   OVER (PARTITION BY x ORDER BY y+y),
  lead(x,y-2,120) OVER (PARTITION BY x ORDER BY y+y)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(y) OVER (PARTITION BY x-y+x/10),
  max(y) OVER (PARTITION BY x-y+x/10),
  min(y) OVER (PARTITION BY x-y+x/10),
  array_agg(y) OVER (PARTITION BY x-y+x/10)
FROM t7
ORDER BY x-y+x/10;

-- sqlfmt-corpus-separator --

SELECT
 CAST(f1 AS BYTEA),
 SHA512(CAST(f1 AS BYTEA))
FROM t_using_dataflow_rendering;

-- sqlfmt-corpus-separator --

SELECT
 CAST(f1 AS BYTEA),
 SHA512(CAST(f1 AS BYTEA))
FROM v_using_constant_folding;

-- sqlfmt-corpus-separator --

SELECT
 quote_literal('1d'::interval),	quote_nullable('1d'::interval),
 quote_literal('2018-06-11 12:13:14'::timestamp), quote_nullable('2018-06-11 12:13:14'::timestamp),
 quote_literal('2018-06-11'::date), quote_nullable('2018-06-11'::date)

-- sqlfmt-corpus-separator --

SELECT
 quote_literal(123::string), quote_nullable(123::string),
 quote_literal(123), quote_nullable(123),
 quote_literal(true), quote_nullable(true),
 quote_literal(123.3), quote_nullable(123.3)

-- sqlfmt-corpus-separator --

SELECT  ABS('-2147483648'::int4)

-- sqlfmt-corpus-separator --

SELECT  ABS('-32768'::int2)

-- sqlfmt-corpus-separator --

SELECT  ABS('-9223372036854775808'::int8)

-- sqlfmt-corpus-separator --

SELECT '          -INFINiTY   '::float4::text

-- sqlfmt-corpus-separator --

SELECT '          -INFINiTY   '::float8::text

-- sqlfmt-corpus-separator --

SELECT '       '::float4

-- sqlfmt-corpus-separator --

SELECT '     '::float8

-- sqlfmt-corpus-separator --

SELECT '     - 3.0'::float4

-- sqlfmt-corpus-separator --

SELECT '    - 3'::float8

-- sqlfmt-corpus-separator --

SELECT '    1.2'::numeric

-- sqlfmt-corpus-separator --

SELECT '   NAN  '::float4::text

-- sqlfmt-corpus-separator --

SELECT '   NAN  '::float8::text

-- sqlfmt-corpus-separator --

SELECT ' '::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' INFINITY    x'::float4

-- sqlfmt-corpus-separator --

SELECT ' INFINITY    x'::float8

-- sqlfmt-corpus-separator --

SELECT '!1'::numeric

-- sqlfmt-corpus-separator --

SELECT '"2"'::regclass != 2

-- sqlfmt-corpus-separator --

SELECT '"2"'::regclass::text

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56#"'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56#+00"'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '"2020-03-17 ~02:36:56~"'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '"2x"'::regclass::text

-- sqlfmt-corpus-separator --

SELECT '"abc\n123"'::JSON

-- sqlfmt-corpus-separator --

SELECT '"foo"'::jsonb -> 'z';

-- sqlfmt-corpus-separator --

SELECT '"foo"'::jsonb -> 1;

-- sqlfmt-corpus-separator --

SELECT '"foo"'::jsonb ->> 'z';

-- sqlfmt-corpus-separator --

SELECT '"foo"'::jsonb ->> 1;

-- sqlfmt-corpus-separator --

SELECT '"hello"'::JSON

-- sqlfmt-corpus-separator --

SELECT '"hello"'::JSON = '"hello"'::JSON,'"hello"'::JSON = '"goodbye"'::JSON

-- sqlfmt-corpus-separator --

SELECT '%' LIKE '\%'

-- sqlfmt-corpus-separator --

SELECT '' ILIKE ''

-- sqlfmt-corpus-separator --

SELECT '' LIKE '%'

-- sqlfmt-corpus-separator --

SELECT '' LIKE '%_'

-- sqlfmt-corpus-separator --

SELECT '' LIKE '%a'

-- sqlfmt-corpus-separator --

SELECT '' LIKE ''

-- sqlfmt-corpus-separator --

SELECT '' LIKE 'TEST'

-- sqlfmt-corpus-separator --

SELECT '' LIKE '_%'

-- sqlfmt-corpus-separator --

SELECT '' LIKE '_'

-- sqlfmt-corpus-separator --

SELECT '' LIKE '__'

-- sqlfmt-corpus-separator --

SELECT '' LIKE 'f%'

-- sqlfmt-corpus-separator --

SELECT '' LIKE 'f%d'

-- sqlfmt-corpus-separator --

SELECT '' LIKE 'foo'

-- sqlfmt-corpus-separator --

SELECT ''::VARCHAR(0)

-- sqlfmt-corpus-separator --

SELECT ''::VARCHAR(10485761)

-- sqlfmt-corpus-separator --

SELECT ''::float4

-- sqlfmt-corpus-separator --

SELECT ''::float8

-- sqlfmt-corpus-separator --

SELECT ''::int4range;

-- sqlfmt-corpus-separator --

SELECT ''::int8range;

-- sqlfmt-corpus-separator --

SELECT ''::numrange;

-- sqlfmt-corpus-separator --

SELECT ''::pg_catalog.VARCHAR(0)

-- sqlfmt-corpus-separator --

SELECT ''::pg_catalog.VARCHAR(10485761)

-- sqlfmt-corpus-separator --

SELECT ''::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::tsrange;

-- sqlfmt-corpus-separator --

SELECT ''::tstzrange;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT '(  ,  )'::int4range

-- sqlfmt-corpus-separator --

SELECT '(  ,  )'::int8range

-- sqlfmt-corpus-separator --

SELECT '(  ,  )'::numrange

-- sqlfmt-corpus-separator --

SELECT '(  ,  )'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(  ,  )'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(  ,1)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(  ,1)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(  ,1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(  ,1970-01-01 00:00:01)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(  ,1970-01-01 00:00:01)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '('::int4range;

-- sqlfmt-corpus-separator --

SELECT '('::int8range;

-- sqlfmt-corpus-separator --

SELECT '('::numrange;

-- sqlfmt-corpus-separator --

SELECT '('::tsrange;

-- sqlfmt-corpus-separator --

SELECT '('::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(,)'::daterange * '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,)'::daterange * '[1969-12-30,1970-01-03)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,)'::daterange * '[1970-01-02,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,)'::daterange * 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,)'::daterange + '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,)'::daterange + '[1969-12-30,1970-01-03)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,)'::daterange + '[1970-01-02,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,)'::daterange + 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,)'::daterange - '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,)'::daterange - '[1969-12-30,1970-01-03)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,)'::daterange - '[1970-01-02,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,)'::daterange - 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(,)'::int4range * '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int4range * '[-2,2)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int4range * '[1,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int4range * 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int4range + '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int4range + '[-2,2)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int4range + '[1,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int4range + 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int4range - '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int4range - '[-2,2)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int4range - '[1,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int4range - 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(,)'::int8range * '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int8range * '[-2,2)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int8range * '[1,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int8range * 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int8range + '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int8range + '[-2,2)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int8range + '[1,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int8range + 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int8range - '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int8range - '[-2,2)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int8range - '[1,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int8range - 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange * '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange * '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange * '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange * '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange * '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange * '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange * 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange + '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange + '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange + '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange + '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange + '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange + '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange + 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange - '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange - '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange - '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange - '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange - '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange - '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange - 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange * '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange * '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange * '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange * '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange * 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange + '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange + '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange + '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange + '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange + 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange - '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange - '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange - '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange - '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange - 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange * '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange * '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange * '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange * '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange * 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange + '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange + '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange + '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange + '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange + 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange - '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange - '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange - '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange - '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange - 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range * '(,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range * '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range * '[-2,2)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range * '[1,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range * 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range + '(,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range + '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range + '[-2,2)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range + '[1,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range + 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range - '(,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range - '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range - '[-2,2)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range - '[1,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range - 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range * '(,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range * '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range * '[-2,2)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range * '[1,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range * 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range + '(,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range + '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range + '[-2,2)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range + '[1,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range + 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range - '(,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range - '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range - '[-2,2)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range - '[1,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range - 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange * '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange * '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange * '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange * '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange * '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange * '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange * 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange + '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange + '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange + '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange + '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange + '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange + '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange + 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange - '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange - '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange - '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange - '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange - '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange - '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange - 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange * '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange * '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange * '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange * '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange * '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange * '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange * '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange * 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange + '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange + '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange + '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange + '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange + '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange + '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange + '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange + 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange - '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange - '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange - '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange - '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange - '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange - '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange - '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange - 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(,-1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(,0)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(,0)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(,0)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(,0]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(,0]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(,0]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(,1)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(,1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(,1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange * '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange * '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange * '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange * '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange * 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange + '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange + '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange + '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange + '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange + 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange - '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange - '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange - '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange - '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange - 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange * '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange * '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange * '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange * '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange * 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange + '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange + '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange + '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange + '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange + 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange - '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange - '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange - '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange - '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange - 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange * '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange * '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange * '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange * '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange * '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange * 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange + '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange + '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange + '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange + '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange + '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange + 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange - '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange - '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange - '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange - '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange - '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange - 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange * '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange * '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange * '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange * '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange * '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange * 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange + '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange + '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange + '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange + '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange + '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange + 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange - '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange - '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange - '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange - '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange - '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange - 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31 11:59:59]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange * '(,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange * '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange * '[1969-12-30,1970-01-03)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange * '[1970-01-02,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange * 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange + '(,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange + '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange + '[1969-12-30,1970-01-03)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange + '[1970-01-02,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange + 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange - '(,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange - '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange - '[1969-12-30,1970-01-03)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange - '[1970-01-02,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange - 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(,1969-12-31]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(,1970-01-01 00:00:00)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(,1970-01-01 00:00:00)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(,1970-01-01 00:00:00]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(,1970-01-01 00:00:00]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(,1970-01-01 00:00:01)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(,1970-01-01 00:00:01)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(,1970-01-01 00:00:01]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(,1970-01-01 00:00:01]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(,1970-01-01)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(,1970-01-01]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(,1970-01-02)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(,1970-01-02]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(,1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(,1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(,1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(,]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(,]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(,]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(,]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(,]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(,]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(-1,)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(-1,)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(-1,)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(-1,-1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(-1,-1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(-1,-1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(-1,-1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(-1,-1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(-1,-1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(-1,0)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(-1,0)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(-1,0)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(-1,0]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(-1,0]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(-1,0]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(-1,1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(-1,1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(-1,1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(-1,1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(-1,1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(-1,1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(-1,]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(-1,]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(-1,]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange * '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange * '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange * '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange * '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange * '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange * '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange * 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange + '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange + '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange + '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange + '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange + '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange + '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange + 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange - '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange - '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange - '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange - '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange - '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange - '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(-2,2)'::numrange - 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(0,)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(0,)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(0,)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(0,-1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(0,-1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(0,-1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(0,-1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(0,-1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(0,-1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(0,0)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(0,0)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(0,0)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(0,0]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(0,0]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(0,0]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(0,1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(0,1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(0,1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(0,1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(0,1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(0,1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(0,]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(0,]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(0,]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1,'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1,'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1,'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1,)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1,)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange * '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange * '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange * '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange * '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange * '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange * '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange * 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange + '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange + '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange + '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange + '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange + '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange + '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange + 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange - '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange - '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange - '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange - '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange - '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange - '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange - 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '(1,)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1,-1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1,-1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1,-1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1,-1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1,-1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1,-1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1,0)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1,0)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1,0)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1,0]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1,0]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1,0]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1,1'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1,1'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1,1'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1,1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1,1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1,1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1,1]  ]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1,1]  ]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1,1]  ]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1,1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1,1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1,1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1,1]1'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1,1]1'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1,1]1'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1,1]]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1,1]]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1,1]]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1,]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(1,]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '(1,]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange * '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange * '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange * '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange * '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange * '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange * 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange + '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange + '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange + '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange + '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange + '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange + 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange - '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange - '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange - '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange - '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange - '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange - 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange * '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange * '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange * '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange * '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange * '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange * 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange + '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange + '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange + '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange + '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange + '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange + 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange - '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange - '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange - '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange - '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange - '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange - 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,1969-12-31 11:59:59)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,1969-12-31 11:59:59)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,1969-12-31 11:59:59]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,1969-12-31 11:59:59]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,1970-01-01 00:00:00)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,1970-01-01 00:00:00)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,1970-01-01 00:00:00]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,1970-01-01 00:00:00]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,1970-01-01 00:00:01)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,1970-01-01 00:00:01)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,1970-01-01 00:00:01]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,1970-01-01 00:00:01]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31 11:59:59,]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31,)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31,1969-12-31)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31,1969-12-31]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31,1970-01-01)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31,1970-01-01]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31,1970-01-02)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31,1970-01-02]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1969-12-31,]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,1969-12-31 11:59:59)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,1969-12-31 11:59:59)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,1969-12-31 11:59:59]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,1969-12-31 11:59:59]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,1970-01-01 00:00:00)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,1970-01-01 00:00:00)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,1970-01-01 00:00:00]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,1970-01-01 00:00:00]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,1970-01-01 00:00:01)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,1970-01-01 00:00:01)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,1970-01-01 00:00:01]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,1970-01-01 00:00:01]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:00,]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange * '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange * '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange * '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange * '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange * 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange + '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange + '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange + '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange + '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange + 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange - '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange - '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange - '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange - '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange - 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange * '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange * '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange * '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange * '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange * 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange + '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange + '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange + '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange + '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange + 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange - '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange - '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange - '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange - '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange - 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,1'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,1'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,1969-12-31 11:59:59)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,1969-12-31 11:59:59)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,1969-12-31 11:59:59]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,1969-12-31 11:59:59]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,1970-01-01 00:00:00)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,1970-01-01 00:00:00)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,1970-01-01 00:00:00]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,1970-01-01 00:00:00]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01,]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01.1, 1970-01-01 00:00:01.1]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01.1, 1970-01-01 00:00:01.1]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01.1,1970-01-01 00:00:01.1)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01.1,1970-01-01 00:00:01.1)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01970-01-01 00:00:01.1]  ]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01970-01-01 00:00:01.1]  ]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01970-01-01 00:00:01.1]1'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01970-01-01 00:00:01.1]1'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01970-01-01 00:00:01.1]]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01 00:00:01970-01-01 00:00:01.1]]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01,)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01,1969-12-31)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01,1969-12-31]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01,1970-01-01)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01,1970-01-01]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01,1970-01-02)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01,1970-01-02]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-01,]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-02,)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-02,1969-12-31)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-02,1969-12-31]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-02,1970-01-01)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-02,1970-01-01]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-02,1970-01-02)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-02,1970-01-02]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(1970-01-02,]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '(2147483647,2147483647]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '(9223372036854775807,9223372036854775807]'::int8range;

-- sqlfmt-corpus-separator --

SELECT ')'::int4range;

-- sqlfmt-corpus-separator --

SELECT ')'::int8range;

-- sqlfmt-corpus-separator --

SELECT ')'::numrange;

-- sqlfmt-corpus-separator --

SELECT ')'::tsrange;

-- sqlfmt-corpus-separator --

SELECT ')'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT ','::int4range;

-- sqlfmt-corpus-separator --

SELECT ','::int8range;

-- sqlfmt-corpus-separator --

SELECT ','::numrange;

-- sqlfmt-corpus-separator --

SELECT ','::tsrange;

-- sqlfmt-corpus-separator --

SELECT ','::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '--1'::numeric

-- sqlfmt-corpus-separator --

SELECT '-0.0'::numeric

-- sqlfmt-corpus-separator --

SELECT '-0.000000000000000000000000000000000000001'::numeric

-- sqlfmt-corpus-separator --

SELECT '-0.0000001'::numeric(10,2)

-- sqlfmt-corpus-separator --

SELECT '-0.2'::numeric

-- sqlfmt-corpus-separator --

SELECT '-1-'::numeric

-- sqlfmt-corpus-separator --

SELECT '-1-2 3 -4:5:6.7'::interval;

-- sqlfmt-corpus-separator --

SELECT '-1.2e20'::numeric

-- sqlfmt-corpus-separator --

SELECT '-1.2e40'::numeric

-- sqlfmt-corpus-separator --

SELECT '-1.7976931348623157E+308'::float8::numeric

-- sqlfmt-corpus-separator --

SELECT '-10e-400'::float4

-- sqlfmt-corpus-separator --

SELECT '-10e-400'::float8

-- sqlfmt-corpus-separator --

SELECT '-10e-70'::float4

-- sqlfmt-corpus-separator --

SELECT '-10e-70'::float8::float4

-- sqlfmt-corpus-separator --

SELECT '-10e400'::float4

-- sqlfmt-corpus-separator --

SELECT '-10e400'::float8

-- sqlfmt-corpus-separator --

SELECT '-10e70'::float4

-- sqlfmt-corpus-separator --

SELECT '-10e70'::float8::float4

-- sqlfmt-corpus-separator --

SELECT '-123456789012345678.901234567890123456789'::numeric

-- sqlfmt-corpus-separator --

SELECT '-123456789012345678.901234567890123456789123'::numeric

-- sqlfmt-corpus-separator --

SELECT '-123456789012345678901234567890123456789123'::numeric

-- sqlfmt-corpus-separator --

SELECT '-123abc456'::numeric

-- sqlfmt-corpus-separator --

SELECT '-123abc456'::numeric;

-- sqlfmt-corpus-separator --

SELECT '-2'::numeric

-- sqlfmt-corpus-separator --

SELECT '-20'::numeric

-- sqlfmt-corpus-separator --

SELECT '-2147483648'::int4 % '-1'::int4

-- sqlfmt-corpus-separator --

SELECT '-2147483648'::int4 / '-1'::int4

-- sqlfmt-corpus-separator --

SELECT '-2147483648.4'::float8::int4

-- sqlfmt-corpus-separator --

SELECT '-2147483648.5'::float4::int4

-- sqlfmt-corpus-separator --

SELECT '-2147483648.6'::float8::int4

-- sqlfmt-corpus-separator --

SELECT '-2147483649'::numeric::int4

-- sqlfmt-corpus-separator --

SELECT '-2147483900'::float4::int4

-- sqlfmt-corpus-separator --

SELECT '-32768'::int2 % '-1'::int2

-- sqlfmt-corpus-separator --

SELECT '-32768'::int2 / '-1'::int2

-- sqlfmt-corpus-separator --

SELECT '-32768.4'::float4::int2;

-- sqlfmt-corpus-separator --

SELECT '-32768.4'::float8::int2;

-- sqlfmt-corpus-separator --

SELECT '-32768.6'::float4::int2;

-- sqlfmt-corpus-separator --

SELECT '-32768.6'::float8::int2;

-- sqlfmt-corpus-separator --

SELECT '-3e38'::float4 - '3e38'::float4

-- sqlfmt-corpus-separator --

SELECT '-44'::uint2

-- sqlfmt-corpus-separator --

SELECT '-44'::uint4

-- sqlfmt-corpus-separator --

SELECT '-44'::uint8

-- sqlfmt-corpus-separator --

SELECT '-5-12-26'::DATE

-- sqlfmt-corpus-separator --

SELECT '-56-12-26'::DATE

-- sqlfmt-corpus-separator --

SELECT '-563-12-26'::DATE

-- sqlfmt-corpus-separator --

SELECT '-5632-12-26'::DATE

-- sqlfmt-corpus-separator --

SELECT '-56325279622-12-26'::DATE

-- sqlfmt-corpus-separator --

SELECT '-9223372036854775808'::int8 % '-1'::int8

-- sqlfmt-corpus-separator --

SELECT '-9223372036854775808'::int8 / '-1'::int8

-- sqlfmt-corpus-separator --

SELECT '-9223372036854775808.5'::float4::int8;

-- sqlfmt-corpus-separator --

SELECT '-9223372036854775808.5'::float8::int8

-- sqlfmt-corpus-separator --

SELECT '-9223372036854775809'::numeric::int4

-- sqlfmt-corpus-separator --

SELECT '-9223372036854780000'::float8::int8

-- sqlfmt-corpus-separator --

SELECT '-9223380000000000000'::float4::int8

-- sqlfmt-corpus-separator --

SELECT '-Infinity'::numeric

-- sqlfmt-corpus-separator --

SELECT '-NaN'::numeric

-- sqlfmt-corpus-separator --

SELECT '.' LIKE '.'

-- sqlfmt-corpus-separator --

SELECT '.' LIKE '\.'

-- sqlfmt-corpus-separator --

SELECT '.*B' LIKE '.*B'

-- sqlfmt-corpus-separator --

SELECT '..1'::numeric

-- sqlfmt-corpus-separator --

SELECT '.A' LIKE '._'

-- sqlfmt-corpus-separator --

SELECT '0.0'::float4 * '1e-20'::float4

-- sqlfmt-corpus-separator --

SELECT '0.0'::float4 / 'Inf'::float4

-- sqlfmt-corpus-separator --

SELECT '0.2'::numeric

-- sqlfmt-corpus-separator --

SELECT '0000-01-01'::date

-- sqlfmt-corpus-separator --

SELECT '0001-12-31 19:03:58 AD '::timestamp;

-- sqlfmt-corpus-separator --

SELECT '0001-12-31 19:03:58 AD'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '0001-12-31 19:03:58 BC '::timestamp;

-- sqlfmt-corpus-separator --

SELECT '0001-12-31 19:03:58 BC'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '0001-12-31 19:03:58 EST AD'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '0001-12-31 19:03:58 EST BC'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '0001-12-31 19:03:58 ad'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '0001-12-31 19:03:58 bc'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '0001-12-31 19:03:58AD '::timestamp;

-- sqlfmt-corpus-separator --

SELECT '0001-12-31 19:03:58BC '::timestamp;

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::text::time

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::date

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::double

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::interval;

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::jsonb

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::numeric

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::text;

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::time;

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::timestamp

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::timestamptz

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::varchar;

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::varchar::time

-- sqlfmt-corpus-separator --

SELECT '01:23:45'::pg_catalog.time

-- sqlfmt-corpus-separator --

SELECT '01:23:45'::time

-- sqlfmt-corpus-separator --

SELECT '01:23:45'::time;

-- sqlfmt-corpus-separator --

SELECT '1 2 3'::int2vector::int2[]::text

-- sqlfmt-corpus-separator --

SELECT '1 2 3'::int2vector::text

-- sqlfmt-corpus-separator --

SELECT '1'::JSON = '1'

-- sqlfmt-corpus-separator --

SELECT '1'::JSON = '1'::JSON

-- sqlfmt-corpus-separator --

SELECT '1'::JSON = '2'::JSON

-- sqlfmt-corpus-separator --

SELECT '1'::JSONB

-- sqlfmt-corpus-separator --

SELECT '1'::JSONB, '2'::JSON

-- sqlfmt-corpus-separator --

SELECT '1'::dec(38,0)

-- sqlfmt-corpus-separator --

SELECT '1'::decimal(38,0)

-- sqlfmt-corpus-separator --

SELECT '1'::int2

-- sqlfmt-corpus-separator --

SELECT '1'::int2vector::text

-- sqlfmt-corpus-separator --

SELECT '1'::int4

-- sqlfmt-corpus-separator --

SELECT '1'::int4range;

-- sqlfmt-corpus-separator --

SELECT '1'::int8

-- sqlfmt-corpus-separator --

SELECT '1'::int8range;

-- sqlfmt-corpus-separator --

SELECT '1'::interval::date

-- sqlfmt-corpus-separator --

SELECT '1'::interval::double

-- sqlfmt-corpus-separator --

SELECT '1'::interval::interval;

-- sqlfmt-corpus-separator --

SELECT '1'::interval::jsonb

-- sqlfmt-corpus-separator --

SELECT '1'::interval::numeric

-- sqlfmt-corpus-separator --

SELECT '1'::interval::text;

-- sqlfmt-corpus-separator --

SELECT '1'::interval::time;

-- sqlfmt-corpus-separator --

SELECT '1'::interval::timestamp

-- sqlfmt-corpus-separator --

SELECT '1'::interval::timestamptz

-- sqlfmt-corpus-separator --

SELECT '1'::interval::varchar;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::double;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::jsonb;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::numeric;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::text;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::varchar;

-- sqlfmt-corpus-separator --

SELECT '1'::numeric(38,0)

-- sqlfmt-corpus-separator --

SELECT '1'::numrange;

-- sqlfmt-corpus-separator --

SELECT '1'::oid

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.numeric(38,0)

-- sqlfmt-corpus-separator --

SELECT '1'::regclass

-- sqlfmt-corpus-separator --

SELECT '1'::regclass::text

-- sqlfmt-corpus-separator --

SELECT '1'::regproc

-- sqlfmt-corpus-separator --

SELECT '1'::regproc::text

-- sqlfmt-corpus-separator --

SELECT '1'::regtype

-- sqlfmt-corpus-separator --

SELECT '1'::regtype::text

-- sqlfmt-corpus-separator --

SELECT '1'::text::double

-- sqlfmt-corpus-separator --

SELECT '1'::text::int2vector::text

-- sqlfmt-corpus-separator --

SELECT '1'::text::interval

-- sqlfmt-corpus-separator --

SELECT '1'::text::numeric

-- sqlfmt-corpus-separator --

SELECT '1'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '1'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::double

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::interval

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::numeric

-- sqlfmt-corpus-separator --

SELECT '1-'::numeric

-- sqlfmt-corpus-separator --

SELECT '1-2 3 4:5:6.7'::interval

-- sqlfmt-corpus-separator --

SELECT '1-2 3 4:5:6.7'::pg_catalog.interval

-- sqlfmt-corpus-separator --

SELECT '1.   2'::numeric

-- sqlfmt-corpus-separator --

SELECT '1..1'::numeric

-- sqlfmt-corpus-separator --

SELECT '1.00'::JSON

-- sqlfmt-corpus-separator --

SELECT '1.00'::JSON = '1'::JSON

-- sqlfmt-corpus-separator --

SELECT '1.1'::numeric

-- sqlfmt-corpus-separator --

SELECT '1.1.1'::numeric

-- sqlfmt-corpus-separator --

SELECT '1.2    '::numeric

-- sqlfmt-corpus-separator --

SELECT '1.2'::double

-- sqlfmt-corpus-separator --

SELECT '1.2'::float4

-- sqlfmt-corpus-separator --

SELECT '1.2'::float8

-- sqlfmt-corpus-separator --

SELECT '1.2e-20'::numeric

-- sqlfmt-corpus-separator --

SELECT '1.2e-40'::numeric

-- sqlfmt-corpus-separator --

SELECT '1.5'::numeric

-- sqlfmt-corpus-separator --

SELECT '1.7976931348623157E+308'::float8::numeric

-- sqlfmt-corpus-separator --

SELECT '1.9'::numeric

-- sqlfmt-corpus-separator --

SELECT '1000000000000000000000000000000000000000'::jsonb

-- sqlfmt-corpus-separator --

SELECT '1082'::regtype::text;

-- sqlfmt-corpus-separator --

SELECT '1082'::text::regtype;

-- sqlfmt-corpus-separator --

SELECT '10e-400'::float4

-- sqlfmt-corpus-separator --

SELECT '10e-400'::float8

-- sqlfmt-corpus-separator --

SELECT '10e-70'::float4

-- sqlfmt-corpus-separator --

SELECT '10e-70'::float8::float4

-- sqlfmt-corpus-separator --

SELECT '10e400'::float4

-- sqlfmt-corpus-separator --

SELECT '10e400'::float8

-- sqlfmt-corpus-separator --

SELECT '10e70'::float4

-- sqlfmt-corpus-separator --

SELECT '10e70'::float8::float4

-- sqlfmt-corpus-separator --

SELECT '1178'::regproc::text;

-- sqlfmt-corpus-separator --

SELECT '12.34'::float4::numeric(39,38);

-- sqlfmt-corpus-separator --

SELECT '12.34'::float8::numeric(39,38);

-- sqlfmt-corpus-separator --

SELECT '123            5'::float4

-- sqlfmt-corpus-separator --

SELECT '123           5'::float8

-- sqlfmt-corpus-separator --

SELECT '124:00'::TIME;

-- sqlfmt-corpus-separator --

SELECT '12:00:00'::TIME;

-- sqlfmt-corpus-separator --

SELECT '1614259308542846100'::jsonb

-- sqlfmt-corpus-separator --

SELECT '18446744073709551616'::uint8

-- sqlfmt-corpus-separator --

SELECT '1960-01-01 11:00'::mz_timestamp;

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.123456789'::timestamp(6) - '1970-01-01T00:00:00.123456789'::timestamp(3);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.123456789'::timestamptz(6) - '1970-01-01T00:00:00.123456789'::timestamptz(3);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666'::timestamp(7);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::date::timestamp(3);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::date::timestamptz(3);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamp(0);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamp(1);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamp(2);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamp(3);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamp(4);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamp(5);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamp(6);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamp::timestamp(3);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamp::timestamptz(3);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamptz(0);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamptz(1);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamptz(2);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamptz(3);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamptz(4);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamptz(5);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamptz(6);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamptz::timestamp(3);

-- sqlfmt-corpus-separator --

SELECT '1970-01-01T00:00:00.666666666'::timestamptz::timestamptz(3);

-- sqlfmt-corpus-separator --

SELECT '1970-01-02'::date::mz_timestamp

-- sqlfmt-corpus-separator --

SELECT '1990-01'::mz_timestamp;

-- sqlfmt-corpus-separator --

SELECT '1e'::numeric

-- sqlfmt-corpus-separator --

SELECT '1e-30'::float4 * '0.0'::float4

-- sqlfmt-corpus-separator --

SELECT '1e-30'::float4 * '1e-20'::float4

-- sqlfmt-corpus-separator --

SELECT '1e-30'::float4 / '0.0'::float4

-- sqlfmt-corpus-separator --

SELECT '1e-30'::float4 / '1e20'::float4

-- sqlfmt-corpus-separator --

SELECT '1e-30'::float4 / 'Inf'::float4

-- sqlfmt-corpus-separator --

SELECT '1e-307'::float8::numeric

-- sqlfmt-corpus-separator --

SELECT '1e30'::float4 * '-Inf'::float4

-- sqlfmt-corpus-separator --

SELECT '1e30'::float4 * '1e10'::float4

-- sqlfmt-corpus-separator --

SELECT '1e30'::float4 / '1e-20'::float4

-- sqlfmt-corpus-separator --

SELECT '1x25'::numeric

-- sqlfmt-corpus-separator --

SELECT '2'::JSONB->'b','[1,2,3]'::JSONB->'0'

-- sqlfmt-corpus-separator --

SELECT '2'::JSONB->>'b','[1,2,3]'::JSONB->>'0'

-- sqlfmt-corpus-separator --

SELECT '2'::numeric

-- sqlfmt-corpus-separator --

SELECT '2'::regclass

-- sqlfmt-corpus-separator --

SELECT '2'::text::regclass

-- sqlfmt-corpus-separator --

SELECT '20'::numeric

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::date;

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::double

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::interval

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::jsonb

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::numeric

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::text;

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::time

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::timestamp;

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::timestamptz;

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::varchar;

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::text::date

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::text::timestamp

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::text::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::varchar::date

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::varchar::timestamp

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::varchar::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2002 03-04 05:06:07'::timestamp::time

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::date;

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::double

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::interval

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::jsonb

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::numeric

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::text;

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::time

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::timestamp;

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::timestamptz;

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::varchar;

-- sqlfmt-corpus-separator --

SELECT '2003 04-05 06:07:08+00'::timestamptz::time

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::date;

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::double

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::interval

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::jsonb

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::numeric

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::text;

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::time

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::timestamp;

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::timestamptz;

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::varchar;

-- sqlfmt-corpus-separator --

SELECT '2007-02-01 15:04:05'::pg_catalog.timestamp

-- sqlfmt-corpus-separator --

SELECT '2007-02-01 15:04:05'::timestamp

-- sqlfmt-corpus-separator --

SELECT '2007-02-01 15:04:05'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '2007-02-01 15:04:05'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2007-02-01 15:04:05+06'::timestamptz;

-- sqlfmt-corpus-separator --

SELECT '2007-02-01'::date

-- sqlfmt-corpus-separator --

SELECT '2015-08-24 21:45:45.53453 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2015-08-24 21:45:45.53453'::timestamp

-- sqlfmt-corpus-separator --

SELECT '2015-08-24 21:45:45.53453'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2015-08-24 23:45:45.534 -02:00'::timestamp

-- sqlfmt-corpus-separator --

SELECT '2015-08-24 23:45:45.534 -02:00'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2015-08-24 23:45:45.53453 UTC'::timestamp

-- sqlfmt-corpus-separator --

SELECT '2015-08-24 23:45:45.53453 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2015-08-24 23:45:45.53453'::timestamp

-- sqlfmt-corpus-separator --

SELECT '2015-08-24 23:45:45.53453'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2015-08-24 23:45:45.53453-02:00'::timestamp

-- sqlfmt-corpus-separator --

SELECT '2015-08-24 23:45:45.53453-02:00'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2015-08-24 23:45:45.53453-05:00'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2015-08-25 04:45:45.53453'::timestamp

-- sqlfmt-corpus-separator --

SELECT '2015-08-25 05:45:45-01:00'::timestamp

-- sqlfmt-corpus-separator --

SELECT '2015-08-25 05:45:45-01:00'::timestamp::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2015-08-25 05:45:45-01:00'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2015-08-25 05:45:45-01:00'::timestamptz::timestamp

-- sqlfmt-corpus-separator --

SELECT '2015-08-25 05:45:45.53453 CET'::timestamptz WHERE false

-- sqlfmt-corpus-separator --

SELECT '2015-08-25 05:45:45.53453'::timestamp

-- sqlfmt-corpus-separator --

SELECT '2015-08-25 05:45:45.53453'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2020-12-21 18:53:49 Asia/Baghdad'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '2025-01-01 00:00:00ı AD'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '2147483520'::float4::int4;

-- sqlfmt-corpus-separator --

SELECT '2147483647'::float4::int4

-- sqlfmt-corpus-separator --

SELECT '2147483647.4'::float8::int4;

-- sqlfmt-corpus-separator --

SELECT '2147483647.6'::float8::int4

-- sqlfmt-corpus-separator --

SELECT '2147483648'::numeric::int4

-- sqlfmt-corpus-separator --

SELECT '24:00:00.001'::TIME;

-- sqlfmt-corpus-separator --

SELECT '24:00:01'::TIME;

-- sqlfmt-corpus-separator --

SELECT '2e40'::float8

-- sqlfmt-corpus-separator --

SELECT '2e40'::float8::float4

-- sqlfmt-corpus-separator --

SELECT '3'::JSONB - 'b'

-- sqlfmt-corpus-separator --

SELECT '3.40282347E+38'::float4::numeric, '-3.40282347E+38'::float4::numeric

-- sqlfmt-corpus-separator --

SELECT '3.40282347E+38'::float8::numeric, '-3.40282347E+38'::float8::numeric

-- sqlfmt-corpus-separator --

SELECT '32767.4'::float4::int2;

-- sqlfmt-corpus-separator --

SELECT '32767.4'::float8::int2;

-- sqlfmt-corpus-separator --

SELECT '32767.6'::float4::int2;

-- sqlfmt-corpus-separator --

SELECT '32767.6'::float8::int2;

-- sqlfmt-corpus-separator --

SELECT '36854775807.0'::float4::int8::text

-- sqlfmt-corpus-separator --

SELECT '3e38'::float4

-- sqlfmt-corpus-separator --

SELECT '3e38'::float4 + '-Inf'::float4

-- sqlfmt-corpus-separator --

SELECT '3e38'::float4 + '3e38'::float4

-- sqlfmt-corpus-separator --

SELECT '3e38'::float4 - '-Inf'::float4

-- sqlfmt-corpus-separator --

SELECT '42'::float8 / 'Infinity'::float8

-- sqlfmt-corpus-separator --

SELECT '4294967296'::uint4

-- sqlfmt-corpus-separator --

SELECT '44'::uint2

-- sqlfmt-corpus-separator --

SELECT '44'::uint4

-- sqlfmt-corpus-separator --

SELECT '44'::uint8

-- sqlfmt-corpus-separator --

SELECT '4714-11-23 23:59:59 BC'::timestamp  -- out of range

-- sqlfmt-corpus-separator --

SELECT '4714-11-24 00:00:00 BC'::timestamp

-- sqlfmt-corpus-separator --

SELECT '4714-11-24 BC'::date - 1

-- sqlfmt-corpus-separator --

SELECT '4714-11-24 BC'::date, '5874897-12-31'::date, '2000-01-01'::date, '0001-01-01'::date, '0001-12-13 BC'::date

-- sqlfmt-corpus-separator --

SELECT '4714-11-24 BC'::date::string, '5874897-12-31'::date::string, '2000-01-01'::date::string, '0001-01-01'::date::string, '0001-12-13 BC'::date::string

-- sqlfmt-corpus-separator --

SELECT '5 . 0'::float4

-- sqlfmt-corpus-separator --

SELECT '5 . 0'::float8

-- sqlfmt-corpus-separator --

SELECT '5'::JSONB @> '5'

-- sqlfmt-corpus-separator --

SELECT '5'::JSONB @> '[5]'

-- sqlfmt-corpus-separator --

SELECT '5.   0'::float4

-- sqlfmt-corpus-separator --

SELECT '5.   0'::float8

-- sqlfmt-corpus-separator --

SELECT '5.0.0'::float4

-- sqlfmt-corpus-separator --

SELECT '5.0.0'::float8

-- sqlfmt-corpus-separator --

SELECT '5874897-12-31'::date + 1

-- sqlfmt-corpus-separator --

SELECT '5874897-12-31'::date - '4714-11-24 BC'::date

-- sqlfmt-corpus-separator --

SELECT '63616665-6630-3064-6465-616462656568'::text::uuid

-- sqlfmt-corpus-separator --

SELECT '63616665-6630-3064-6465-616462656568'::uuid

-- sqlfmt-corpus-separator --

SELECT '63616665-6630-3064-6465-616462656568'::uuid < '86565626-4616-5646-4603-036656661636'::uuid;

-- sqlfmt-corpus-separator --

SELECT '63616665-6630-3064-6465-616462656568'::uuid <= '86565626-4616-5646-4603-036656661636'::uuid;

-- sqlfmt-corpus-separator --

SELECT '63616665-6630-3064-6465-616462656568'::uuid <> '86565626-4616-5646-4603-036656661636'::uuid;

-- sqlfmt-corpus-separator --

SELECT '63616665-6630-3064-6465-616462656568'::uuid = '63616665-6630-3064-6465-616462656568'::uuid;

-- sqlfmt-corpus-separator --

SELECT '63616665-6630-3064-6465-616462656568'::uuid = '86565626-4616-5646-4603-036656661636'::uuid;

-- sqlfmt-corpus-separator --

SELECT '63616665-6630-3064-6465-616462656568'::uuid > '86565626-4616-5646-4603-036656661636'::uuid;

-- sqlfmt-corpus-separator --

SELECT '63616665-6630-3064-6465-616462656568'::uuid >= '86565626-4616-5646-4603-036656661636'::uuid;

-- sqlfmt-corpus-separator --

SELECT '63616665-6630-3064-6465-616462656568'::uuid::bytes

-- sqlfmt-corpus-separator --

SELECT '63616665-6630-3064-6465-616462656568'::uuid::text

-- sqlfmt-corpus-separator --

SELECT '65536'::uint2

-- sqlfmt-corpus-separator --

SELECT '9223369837831520256'::float4::int8

-- sqlfmt-corpus-separator --

SELECT '9223372036854773760'::float8::int8

-- sqlfmt-corpus-separator --

SELECT '9223372036854775807'::float4::int8;

-- sqlfmt-corpus-separator --

SELECT '9223372036854775807'::float8::int8

-- sqlfmt-corpus-separator --

SELECT '9223372036854775807'::jsonb

-- sqlfmt-corpus-separator --

SELECT '922337203685477580700.0'::float8::int8

-- sqlfmt-corpus-separator --

SELECT '9223372036854775808'::numeric::int4

-- sqlfmt-corpus-separator --

SELECT '99999-01-01'::TIMESTAMP + '162143 y';

-- sqlfmt-corpus-separator --

SELECT '99999-01-01'::TIMESTAMP + '162144 y';

-- sqlfmt-corpus-separator --

SELECT '999999999999999999999999999999999999999'::jsonb

-- sqlfmt-corpus-separator --

SELECT 'A' LIKE 'T_'

-- sqlfmt-corpus-separator --

SELECT 'A' LIKE '\\A'

-- sqlfmt-corpus-separator --

SELECT 'A' LIKE '_T'

-- sqlfmt-corpus-separator --

SELECT 'AAA' LIKE '%AA%A'

-- sqlfmt-corpus-separator --

SELECT 'AB' LIKE '.*B'

-- sqlfmt-corpus-separator --

SELECT 'AB' LIKE '._'

-- sqlfmt-corpus-separator --

SELECT 'ABC' LIKE '%B\C'

-- sqlfmt-corpus-separator --

SELECT 'ABC' LIKE '\AB%'

-- sqlfmt-corpus-separator --

SELECT 'ABC' LIKE '\AB_'

-- sqlfmt-corpus-separator --

SELECT 'ABC' LIKE '_B\C'

-- sqlfmt-corpus-separator --

SELECT 'A\' LIKE '_\\'

-- sqlfmt-corpus-separator --

SELECT 'A\A' LIKE '_\\_'

-- sqlfmt-corpus-separator --

SELECT 'Inf'::float4 * '1e10'::float4

-- sqlfmt-corpus-separator --

SELECT 'Inf'::float4 + '3e38'::float4

-- sqlfmt-corpus-separator --

SELECT 'Inf'::float4 - '3e38'::float4

-- sqlfmt-corpus-separator --

SELECT 'Inf'::float4 / '1e-20'::float4

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::numeric

-- sqlfmt-corpus-separator --

SELECT 'N A N'::float4

-- sqlfmt-corpus-separator --

SELECT 'N A N'::float8::text

-- sqlfmt-corpus-separator --

SELECT 'NaN x'::float4;

-- sqlfmt-corpus-separator --

SELECT 'NaN x'::float8;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::decimal, '-NaN'::decimal, 'sNaN'::decimal, '-sNaN'::decimal

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float4::numeric, '-NaN'::float4::numeric;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float4::text

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float8::numeric, '-NaN'::float8::numeric;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float8::text

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric % -4.1

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric * 2::numeric

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric + 2::numeric

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric - 2::numeric

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric / 2::numeric

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric < 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric <= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric <> 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric = 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric > 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric > 9e38;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric >= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric(39,1);

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric::float4

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric::float8

-- sqlfmt-corpus-separator --

SELECT 'T' ILIKE '_'

-- sqlfmt-corpus-separator --

SELECT 'T' LIKE '%_'

-- sqlfmt-corpus-separator --

SELECT 'T' LIKE 'TEST'

-- sqlfmt-corpus-separator --

SELECT 'T' LIKE '\%'

-- sqlfmt-corpus-separator --

SELECT 'T' LIKE '\_'

-- sqlfmt-corpus-separator --

SELECT 'T' LIKE '_%'

-- sqlfmt-corpus-separator --

SELECT 'T' LIKE '_'

-- sqlfmt-corpus-separator --

SELECT 'TE' ILIKE '_'

-- sqlfmt-corpus-separator --

SELECT 'TE' LIKE '%_'

-- sqlfmt-corpus-separator --

SELECT 'TE' LIKE '_%'

-- sqlfmt-corpus-separator --

SELECT 'TE' LIKE '_'

-- sqlfmt-corpus-separator --

SELECT 'TES%' LIKE '%S\%'

-- sqlfmt-corpus-separator --

SELECT 'TES%' LIKE '_ES\%'

-- sqlfmt-corpus-separator --

SELECT 'TES%T' LIKE 'TES\%T'

-- sqlfmt-corpus-separator --

SELECT 'TEST' ILIKE '%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' ILIKE '%E%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' ILIKE '%R'

-- sqlfmt-corpus-separator --

SELECT 'TEST' ILIKE '%e%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' ILIKE ''

-- sqlfmt-corpus-separator --

SELECT 'TEST' ILIKE 'TE%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' ILIKE 'TEST'

-- sqlfmt-corpus-separator --

SELECT 'TEST' ILIKE 'TESTER'

-- sqlfmt-corpus-separator --

SELECT 'TEST' ILIKE 'TES_'

-- sqlfmt-corpus-separator --

SELECT 'TEST' ILIKE 'TE_%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' ILIKE 'TE_'

-- sqlfmt-corpus-separator --

SELECT 'TEST' ILIKE 'test'

-- sqlfmt-corpus-separator --

SELECT 'TEST' ILIKE 'tester'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE '%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE '%E%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE '%R'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE '%S\_'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE '%S_'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE '%e%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE ''

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE 'TE%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE 'TEST'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE 'TESTER'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE 'TES_'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE 'TE\ST'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE 'TE_%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE 'TE_'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE '_E%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE '_ES_'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE '_E\%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE 'test'

-- sqlfmt-corpus-separator --

SELECT 'TEST' LIKE 'ΜΆΪΟΣ'

-- sqlfmt-corpus-separator --

SELECT 'TEST' NOT ILIKE '%E%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' NOT ILIKE 'TES_'

-- sqlfmt-corpus-separator --

SELECT 'TEST' NOT ILIKE 'TE_'

-- sqlfmt-corpus-separator --

SELECT 'TEST' NOT ILIKE 'TeS_'

-- sqlfmt-corpus-separator --

SELECT 'TEST' NOT LIKE '%E%'

-- sqlfmt-corpus-separator --

SELECT 'TEST' NOT LIKE 'TES_'

-- sqlfmt-corpus-separator --

SELECT 'TEST' NOT LIKE 'TE_'

-- sqlfmt-corpus-separator --

SELECT 'TEST' NOT LIKE 'TeS_'

-- sqlfmt-corpus-separator --

SELECT 'TESTESTEST' LIKE 'TEST'

-- sqlfmt-corpus-separator --

SELECT 'TESTS' LIKE 'TEST'

-- sqlfmt-corpus-separator --

SELECT 'TES\AT' LIKE 'TES\%T'

-- sqlfmt-corpus-separator --

SELECT 'TES_' LIKE '%S\_'

-- sqlfmt-corpus-separator --

SELECT 'TES_' LIKE '_ES\_'

-- sqlfmt-corpus-separator --

SELECT 'TE\AT' LIKE 'TE\_T'

-- sqlfmt-corpus-separator --

SELECT 'TE_T' LIKE 'TE\_T'

-- sqlfmt-corpus-separator --

SELECT 'Z3616665-6630-3064-6465-616462656568'::uuid

-- sqlfmt-corpus-separator --

SELECT '["1","2","1","2","3"]'::JSONB - '2'

-- sqlfmt-corpus-separator --

SELECT '["1","2","3"]'::JSONB - ''

-- sqlfmt-corpus-separator --

SELECT '["1","2","3"]'::JSONB - '1'

-- sqlfmt-corpus-separator --

SELECT '["1","2","3"]'::JSONB - '4'

-- sqlfmt-corpus-separator --

SELECT '["2024-02-13 17:01:58.37848+00",)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '["9", ["7", "3"], 1]'::JSONB @> '["9", ["7", "3"], 1]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '["9", ["7", "3"], ["1"]]'::JSONB @> '["9", ["7", "3"], ["1"]]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '["?!?2024-02-13 17:01:58.37848+00!?!",)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '["foo","bar","baz"]'::JSONB ? 'baz'

-- sqlfmt-corpus-separator --

SELECT '["foo","bar","baz"]'::JSONB ? 'foo'

-- sqlfmt-corpus-separator --

SELECT '["foo","bar","baz"]'::JSONB ? 'gup'

-- sqlfmt-corpus-separator --

SELECT '[' LIKE '['

-- sqlfmt-corpus-separator --

SELECT '[' LIKE '\['

-- sqlfmt-corpus-separator --

SELECT '['::int4range;

-- sqlfmt-corpus-separator --

SELECT '['::int8range;

-- sqlfmt-corpus-separator --

SELECT '['::numrange;

-- sqlfmt-corpus-separator --

SELECT '['::tsrange;

-- sqlfmt-corpus-separator --

SELECT '['::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[,)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[,)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[,)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[,)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[,)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[,)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[,-1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[,-1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[,-1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[,-1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[,-1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[,-1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[,0)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[,0)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[,0)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[,0]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[,0]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[,0]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[,1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[,1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[,1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[,1969-12-31 11:59:59)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[,1969-12-31 11:59:59)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[,1969-12-31 11:59:59]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[,1969-12-31 11:59:59]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[,1969-12-31)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[,1969-12-31]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[,1970-01-01 00:00:00)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[,1970-01-01 00:00:00)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[,1970-01-01 00:00:00]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[,1970-01-01 00:00:00]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[,1970-01-01 00:00:01)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[,1970-01-01 00:00:01)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[,1970-01-01 00:00:01]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[,1970-01-01 00:00:01]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[,1970-01-01)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[,1970-01-01]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[,1970-01-02)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[,1970-01-02]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[,1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[,1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[,1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[,]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[,]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[,]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[,]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[,]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[,]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[-1,)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[-1,)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[-1,)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[-1,-1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[-1,-1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[-1,-1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[-1,-1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[-1,-1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[-1,-1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[-1,0)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[-1,0)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[-1,0)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[-1,0]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[-1,0]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[-1,0]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[-1,1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[-1,1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[-1,1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[-1,1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[-1,1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[-1,1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[-1,]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[-1,]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[-1,]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int4range * '(,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int4range * '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int4range * '[1,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int4range * 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int4range + '(,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int4range + '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int4range + '[1,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int4range + 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int4range - '(,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int4range - '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int4range - '[1,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int4range - 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int8range * '(,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int8range * '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int8range * '[1,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int8range * 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int8range + '(,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int8range + '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int8range + '[1,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int8range + 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int8range - '(,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int8range - '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int8range - '[1,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[-2,2)'::int8range - 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange * '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange * '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange * '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange * '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange * '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange * '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange * 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange + '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange + '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange + '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange + '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange + '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange + '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange + 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange - '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange - '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange - '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange - '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange - '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange - '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[-2,2]'::numrange - 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '[0,)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[0,)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[0,)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[0,-1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[0,-1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[0,-1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[0,-1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[0,-1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[0,-1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[0,0)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[0,0)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[0,0)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[0,0]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[0,0]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[0,0]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[0,1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[0,1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[0,1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[0,1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[0,1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[0,1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[0,]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[0,]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[0,]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1,  )'::int4range

-- sqlfmt-corpus-separator --

SELECT '[1,  )'::int8range

-- sqlfmt-corpus-separator --

SELECT '[1,  )'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,"1",1.0]'::JSONB - '1'

-- sqlfmt-corpus-separator --

SELECT '[1,"hello",[[[true,false]]]]'::JSON

-- sqlfmt-corpus-separator --

SELECT '[1,"hello",{"a": ["foo",{"b": 3}]}]'::JSON

-- sqlfmt-corpus-separator --

SELECT '[1,'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[1,'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[1,'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int4range * '(,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int4range * '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int4range * '[-2,2)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int4range * 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int4range + '(,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int4range + '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int4range + '[-2,2)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int4range + 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int4range - '(,)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int4range - '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int4range - '[-2,2)'::int4range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int4range - 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int8range * '(,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int8range * '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int8range * '[-2,2)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int8range * 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int8range + '(,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int8range + '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int8range + '[-2,2)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int8range + 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int8range - '(,)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int8range - '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int8range - '[-2,2)'::int8range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int8range - 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT '[1,)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange * '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange * '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange * '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange * '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange * '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange * '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange * 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange + '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange + '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange + '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange + '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange + '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange + '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange + 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange - '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange - '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange - '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange - '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange - '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange - '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange - 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT '[1,)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1,-1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[1,-1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[1,-1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1,-1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[1,-1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[1,-1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1,0)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[1,0)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[1,0)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1,0]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[1,0]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[1,0]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1,1'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[1,1'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[1,1'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1,1)'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[1,1)'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[1,1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1,1,2]'::JSONB @> '[1,2,2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,1]  }'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[1,1]  }'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[1,1]  }'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1,1]a'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[1,1]a'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[1,1]a'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1,1]}'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[1,1]}'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[1,1]}'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1,2,2]'::JSONB <@ '[1,1,2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,2,2]'::JSONB <@ '[1,2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSON

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSON || '[4,5,6]'::JSON

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSONB - 0

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSONB - 1

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSONB <@ '[1,2]'::JSONB

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSONB ? '0'

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSONB @> '[1,2]'::JSONB

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSONB || '[4,5,6]'::JSONB

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSONB->0

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSONB->3

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSONB->>0

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSONB->>3

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::jsonb || '[4,5,6]'

-- sqlfmt-corpus-separator --

SELECT '[1,2]'::JSONB <@ '[1,2,3]'::JSONB

-- sqlfmt-corpus-separator --

SELECT '[1,2]'::JSONB @> '[1,2,2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,2]'::JSONB @> '[1,2,3]'::JSONB

-- sqlfmt-corpus-separator --

SELECT '[1,]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[1,]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[1,]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1.1,1.1)'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1.1,1.1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1.1,1.2]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-30,1970-01-03)'::daterange * '(,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-30,1970-01-03)'::daterange * '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-30,1970-01-03)'::daterange * '[1970-01-02,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-30,1970-01-03)'::daterange * 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-30,1970-01-03)'::daterange + '(,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-30,1970-01-03)'::daterange + '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-30,1970-01-03)'::daterange + '[1970-01-02,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-30,1970-01-03)'::daterange + 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-30,1970-01-03)'::daterange - '(,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-30,1970-01-03)'::daterange - '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-30,1970-01-03)'::daterange - '[1970-01-02,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-30,1970-01-03)'::daterange - 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange * '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange * '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange * '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange * '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange * '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange * 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange + '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange + '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange + '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange + '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange + '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange + 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange - '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange - '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange - '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange - '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange - '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange - 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange * '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange * '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange * '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange * '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange * '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange * 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange + '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange + '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange + '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange + '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange + '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange + 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange - '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange - '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange - '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange - '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange - '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange - 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,1969-12-31 11:59:59)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,1969-12-31 11:59:59)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,1969-12-31 11:59:59]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,1969-12-31 11:59:59]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,1970-01-01 00:00:00)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,1970-01-01 00:00:00)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,1970-01-01 00:00:00]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,1970-01-01 00:00:00]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,1970-01-01 00:00:01)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,1970-01-01 00:00:01)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,1970-01-01 00:00:01]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,1970-01-01 00:00:01]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31 11:59:59,]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31,)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31,1969-12-31)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31,1969-12-31]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31,1970-01-01)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31,1970-01-01]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31,1970-01-02)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31,1970-01-02]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1969-12-31,]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,1969-12-31 11:59:59)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,1969-12-31 11:59:59)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,1969-12-31 11:59:59]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,1969-12-31 11:59:59]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,1970-01-01 00:00:00)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,1970-01-01 00:00:00)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,1970-01-01 00:00:00]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,1970-01-01 00:00:00]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,1970-01-01 00:00:01)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,1970-01-01 00:00:01)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,1970-01-01 00:00:01]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,1970-01-01 00:00:01]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:00,]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,  )'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,  )'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange * '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange * '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange * '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange * '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange * 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange + '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange + '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange + '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange + '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange + 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange - '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange - '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange - '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange - '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange - 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange * '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange * '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange * '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange * '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange * 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange + '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange + '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange + '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange + '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange + 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange - '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange - '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange - '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange - '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange - 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,1'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,1'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,1969-12-31 11:59:59)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,1969-12-31 11:59:59)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,1969-12-31 11:59:59]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,1969-12-31 11:59:59]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,1970-01-01 00:00:00)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,1970-01-01 00:00:00)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,1970-01-01 00:00:00]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,1970-01-01 00:00:00]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01,]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01.1, 1970-01-01 00:00:01.1)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01.1, 1970-01-01 00:00:01.1)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01.1,1970-01-01 00:00:01.1)'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01.1,1970-01-01 00:00:01.1)'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01.1,1970-01-01 00:00:01.1]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01.1,1970-01-01 00:00:01.1]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01.1,1970-01-01 00:00:02]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01.1,1970-01-01 00:00:02]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01970-01-01 00:00:01.1]  }'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01970-01-01 00:00:01.1]  }'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01970-01-01 00:00:01.1]a'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01970-01-01 00:00:01.1]a'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01970-01-01 00:00:01.1]}'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01970-01-01 00:00:01.1]}'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01]'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01 00:00:01]'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01,)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01,1969-12-31)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01,1969-12-31]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01,1970-01-01)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01,1970-01-01]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01,1970-01-02)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01,1970-01-02]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-01,]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,)'::daterange * '(,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,)'::daterange * '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,)'::daterange * '[1969-12-30,1970-01-03)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,)'::daterange * 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,)'::daterange + '(,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,)'::daterange + '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,)'::daterange + '[1969-12-30,1970-01-03)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,)'::daterange + 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,)'::daterange - '(,)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,)'::daterange - '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,)'::daterange - '[1969-12-30,1970-01-03)'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,)'::daterange - 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,1969-12-31)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,1969-12-31]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,1970-01-01)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,1970-01-01]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,1970-01-02)'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,1970-01-02]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1970-01-02,]'::daterange;

-- sqlfmt-corpus-separator --

SELECT '[1]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[1]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[1]'::numrange;

-- sqlfmt-corpus-separator --

SELECT '[2,2147483647]'::int4range;

-- sqlfmt-corpus-separator --

SELECT '[2,9223372036854775807]'::int8range;

-- sqlfmt-corpus-separator --

SELECT '[5]'::JSONB @> '5'

-- sqlfmt-corpus-separator --

SELECT '[5]'::JSONB @> '[5]'

-- sqlfmt-corpus-separator --

SELECT '[[1,2,2]]'::JSONB <@ '[[1,2]]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[[1,2]]'::JSONB @> '[[1,2,2]]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[]'::JSON

-- sqlfmt-corpus-separator --

SELECT '[]'::JSONB - '1'

-- sqlfmt-corpus-separator --

SELECT '[null]'::JSONB->>0

-- sqlfmt-corpus-separator --

SELECT '[{"b": "c"}, {"b": "cc"}]'::jsonb -> 'z';

-- sqlfmt-corpus-separator --

SELECT '[{"b": "c"}, {"b": "cc"}]'::jsonb -> 1;

-- sqlfmt-corpus-separator --

SELECT '[{"b": "c"}, {"b": "cc"}]'::jsonb -> 3;

-- sqlfmt-corpus-separator --

SELECT '[{"b": "c"}, {"b": "cc"}]'::jsonb ->> 'z';

-- sqlfmt-corpus-separator --

SELECT '[{"b": "c"}, {"b": "cc"}]'::jsonb ->> 1;

-- sqlfmt-corpus-separator --

SELECT '[{"b": "c"}, {"b": "cc"}]'::jsonb ->> 3;

-- sqlfmt-corpus-separator --

SELECT '\%' LIKE '\\\%'

-- sqlfmt-corpus-separator --

SELECT '\' LIKE '%\\%'

-- sqlfmt-corpus-separator --

SELECT '\' LIKE '%\\'

-- sqlfmt-corpus-separator --

SELECT '\' LIKE '\\%'

-- sqlfmt-corpus-separator --

SELECT '\' LIKE '\\'

-- sqlfmt-corpus-separator --

SELECT '\.*' LIKE '\\.*'

-- sqlfmt-corpus-separator --

SELECT '\.*' LIKE '\\.\*'

-- sqlfmt-corpus-separator --

SELECT '\.*' LIKE '\\\.\*'

-- sqlfmt-corpus-separator --

SELECT '\400'::bytea

-- sqlfmt-corpus-separator --

SELECT '\A' LIKE '\\A'

-- sqlfmt-corpus-separator --

SELECT '\\' LIKE '\\'

-- sqlfmt-corpus-separator --

SELECT '\\' LIKE '\\_'

-- sqlfmt-corpus-separator --

SELECT '\\' LIKE '_\\'

-- sqlfmt-corpus-separator --

SELECT '\\.' LIKE '\\.'

-- sqlfmt-corpus-separator --

SELECT '\\.' LIKE '\\\\.'

-- sqlfmt-corpus-separator --

SELECT '\\.' LIKE '\\\\\.'

-- sqlfmt-corpus-separator --

SELECT '\_' LIKE '\\\_'

-- sqlfmt-corpus-separator --

SELECT '_' LIKE '\_'

-- sqlfmt-corpus-separator --

SELECT '__' LIKE '_\\_'

-- sqlfmt-corpus-separator --

SELECT '_漢' LIKE '\_\漢'

-- sqlfmt-corpus-separator --

SELECT '_漢' LIKE '\__'

-- sqlfmt-corpus-separator --

SELECT 'a
b' ILIKE '%'

-- sqlfmt-corpus-separator --

SELECT 'a
b' LIKE '%'

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a' LIKE '%%%%a'

-- sqlfmt-corpus-separator --

SELECT 'a' LIKE '%a'

-- sqlfmt-corpus-separator --

SELECT 'a' LIKE '\'

-- sqlfmt-corpus-separator --

SELECT 'a' LIKE '_'

-- sqlfmt-corpus-separator --

SELECT 'a' LIKE 'a_'

-- sqlfmt-corpus-separator --

SELECT 'a'::bytea

-- sqlfmt-corpus-separator --

SELECT 'a'::bytes

-- sqlfmt-corpus-separator --

SELECT 'a'::int2vector::text

-- sqlfmt-corpus-separator --

SELECT 'a'::name < 'a'::name

-- sqlfmt-corpus-separator --

SELECT 'a'::name < 'b'::name

-- sqlfmt-corpus-separator --

SELECT 'a'::name <= 'a'::name

-- sqlfmt-corpus-separator --

SELECT 'a'::name <= 'b'::name

-- sqlfmt-corpus-separator --

SELECT 'a'::name <> 'a'::name

-- sqlfmt-corpus-separator --

SELECT 'a'::name <> 'b'::name

-- sqlfmt-corpus-separator --

SELECT 'a'::name = 'a'::name

-- sqlfmt-corpus-separator --

SELECT 'a'::name = 'b'::name

-- sqlfmt-corpus-separator --

SELECT 'a'::name > 'a'::name

-- sqlfmt-corpus-separator --

SELECT 'a'::name > 'b'::name

-- sqlfmt-corpus-separator --

SELECT 'a'::name >= 'a'::name

-- sqlfmt-corpus-separator --

SELECT 'a'::name >= 'b'::name

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a\'::text::bytea

-- sqlfmt-corpus-separator --

SELECT 'a\01'::text::bytea

-- sqlfmt-corpus-separator --

SELECT 'a\\b'::text::bytea

-- sqlfmt-corpus-separator --

SELECT 'a\bcde'::text::bytea

-- sqlfmt-corpus-separator --

SELECT 'aa' LIKE '_'

-- sqlfmt-corpus-separator --

SELECT 'aa' LIKE 'a_'

-- sqlfmt-corpus-separator --

SELECT 'aaa' LIKE '%a'

-- sqlfmt-corpus-separator --

SELECT 'aaa' LIKE '%aa_'

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'abs'::regclass

-- sqlfmt-corpus-separator --

SELECT 'array_in'::regproc

-- sqlfmt-corpus-separator --

SELECT 'array_length'::regclass::text;

-- sqlfmt-corpus-separator --

SELECT 'array_length'::regproc::text;

-- sqlfmt-corpus-separator --

SELECT 'array_length'::regtype::text;

-- sqlfmt-corpus-separator --

SELECT 'b' LIKE '%a'

-- sqlfmt-corpus-separator --

SELECT 'b' LIKE 'b_t'

-- sqlfmt-corpus-separator --

SELECT 'b'::name < 'a'::name

-- sqlfmt-corpus-separator --

SELECT 'b'::name <= 'a'::name

-- sqlfmt-corpus-separator --

SELECT 'b'::name <> 'a'::name

-- sqlfmt-corpus-separator --

SELECT 'b'::name = 'a'::name

-- sqlfmt-corpus-separator --

SELECT 'b'::name > 'a'::name

-- sqlfmt-corpus-separator --

SELECT 'b'::name >= 'a'::name

-- sqlfmt-corpus-separator --

SELECT 'baaa' LIKE '%%%%a'

-- sqlfmt-corpus-separator --

SELECT 'baaa' LIKE '%a'

-- sqlfmt-corpus-separator --

SELECT 'bad' LIKE '%a'

-- sqlfmt-corpus-separator --

SELECT 'bar' LIKE 'f%'

-- sqlfmt-corpus-separator --

SELECT 'bar' LIKE 'f%d'

-- sqlfmt-corpus-separator --

SELECT 'bar' LIKE 'foo'

-- sqlfmt-corpus-separator --

SELECT 'blah'::bool

-- sqlfmt-corpus-separator --

SELECT 'boot' LIKE 'b__t'

-- sqlfmt-corpus-separator --

SELECT 'bt' LIKE 'b_t'

-- sqlfmt-corpus-separator --

SELECT 'but' LIKE 'b_t'

-- sqlfmt-corpus-separator --

SELECT 'butt' LIKE 'b_t'

-- sqlfmt-corpus-separator --

SELECT 'd'::int4range;

-- sqlfmt-corpus-separator --

SELECT 'd'::int8range;

-- sqlfmt-corpus-separator --

SELECT 'd'::numrange;

-- sqlfmt-corpus-separator --

SELECT 'd'::tsrange;

-- sqlfmt-corpus-separator --

SELECT 'd'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT 'd.public.t'::regclass::text;

-- sqlfmt-corpus-separator --

SELECT 'd.public.t'::regtype::text;

-- sqlfmt-corpus-separator --

SELECT 'date'::regproc::text;

-- sqlfmt-corpus-separator --

SELECT 'date'::regtype

-- sqlfmt-corpus-separator --

SELECT 'date'::regtype::oid

-- sqlfmt-corpus-separator --

SELECT 'date'::regtype::oid::text;

-- sqlfmt-corpus-separator --

SELECT 'date'::regtype::text

-- sqlfmt-corpus-separator --

SELECT 'date'::regtype::text;

-- sqlfmt-corpus-separator --

SELECT 'dne'::regclass

-- sqlfmt-corpus-separator --

SELECT 'dne'::regclass;

-- sqlfmt-corpus-separator --

SELECT 'dne'::regproc

-- sqlfmt-corpus-separator --

SELECT 'dne'::regtype

-- sqlfmt-corpus-separator --

SELECT 'dog'::pg_catalog.varchar(10)

-- sqlfmt-corpus-separator --

SELECT 'dog'::text

-- sqlfmt-corpus-separator --

SELECT 'dog'::text::text;

-- sqlfmt-corpus-separator --

SELECT 'dog'::text::varchar;

-- sqlfmt-corpus-separator --

SELECT 'dog'::varchar(10)

-- sqlfmt-corpus-separator --

SELECT 'dog'::varchar::text;

-- sqlfmt-corpus-separator --

SELECT 'dog'::varchar::varchar;

-- sqlfmt-corpus-separator --

SELECT 'e25'::numeric

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange * '(,)'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange * '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange * '[1969-12-30,1970-01-03)'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange * '[1970-01-02,)'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange * 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange + '(,)'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange + '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange + '[1969-12-30,1970-01-03)'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange + '[1970-01-02,)'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange + 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange - '(,)'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange - '(,1969-12-31)'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange - '[1969-12-30,1970-01-03)'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange - '[1970-01-02,)'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::daterange - 'empty'::daterange

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range * '(,)'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range * '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range * '[-2,2)'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range * '[1,)'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range * 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range + '(,)'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range + '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range + '[-2,2)'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range + '[1,)'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range + 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range - '(,)'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range - '(,-1)'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range - '[-2,2)'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range - '[1,)'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int4range - 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range * '(,)'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range * '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range * '[-2,2)'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range * '[1,)'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range * 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range + '(,)'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range + '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range + '[-2,2)'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range + '[1,)'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range + 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range - '(,)'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range - '(,-1)'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range - '[-2,2)'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range - '[1,)'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::int8range - 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange * '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange * '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange * '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange * '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange * '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange * '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange * '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange * 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange + '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange + '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange + '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange + '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange + '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange + '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange + '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange + 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange - '(,)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange - '(,-1)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange - '(,-1]'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange - '(-2,2)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange - '(1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange - '[-2,2]'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange - '[1,)'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange - 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange * '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange * '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange * '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange * '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange * '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange * 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange + '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange + '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange + '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange + '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange + '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange + 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange - '(,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange - '(,1969-12-31 11:59:59)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange - '(,1969-12-31 11:59:59]'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange - '(1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange - '[1970-01-01 00:00:01,)'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tsrange - 'empty'::tsrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange * '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange * '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange * '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange * '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange * '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange * '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange * '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange * 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange + '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange + '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange + '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange + '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange + '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange + '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange + '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange + 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange - '(,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange - '(,1969-12-31 11:59:59)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange - '(,1969-12-31 11:59:59]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange - '(1969-12-31 11:59:58,1970-01-01 00:00:02)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange - '(1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange - '[1969-12-31 11:59:58,1970-01-01 00:00:02]'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange - '[1970-01-01 00:00:01,)'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'empty'::tstzrange - 'empty'::tstzrange

-- sqlfmt-corpus-separator --

SELECT 'emptyy'::int4range;

-- sqlfmt-corpus-separator --

SELECT 'emptyy'::int8range;

-- sqlfmt-corpus-separator --

SELECT 'emptyy'::numrange;

-- sqlfmt-corpus-separator --

SELECT 'emptyy'::tsrange;

-- sqlfmt-corpus-separator --

SELECT 'emptyy'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT 'epoch'::date

-- sqlfmt-corpus-separator --

SELECT 'epoch'::date, 'infinity'::date, '-infinity'::date

-- sqlfmt-corpus-separator --

SELECT 'epoch'::timestamp

-- sqlfmt-corpus-separator --

SELECT 'epoch'::timestamptz

-- sqlfmt-corpus-separator --

SELECT 'f' LIKE 'f%%%'

-- sqlfmt-corpus-separator --

SELECT 'f' LIKE 'f%'

-- sqlfmt-corpus-separator --

SELECT 'f' LIKE 'f___'

-- sqlfmt-corpus-separator --

SELECT 'fa' LIKE 'f%d'

-- sqlfmt-corpus-separator --

SELECT 'fad' LIKE 'f%%d'

-- sqlfmt-corpus-separator --

SELECT 'fad' LIKE 'f%d'

-- sqlfmt-corpus-separator --

SELECT 'fd' LIKE 'f%_d'

-- sqlfmt-corpus-separator --

SELECT 'fd' LIKE 'f%d'

-- sqlfmt-corpus-separator --

SELECT 'fd' LIKE 'f_%d'

-- sqlfmt-corpus-separator --

SELECT 'fed' LIKE 'f%_d'

-- sqlfmt-corpus-separator --

SELECT 'fed' LIKE 'f_%d'

-- sqlfmt-corpus-separator --

SELECT 'fi' LIKE 'f%'

-- sqlfmt-corpus-separator --

SELECT 'foo' LIKE 'b_t'

-- sqlfmt-corpus-separator --

SELECT 'foo' LIKE 'f%%%'

-- sqlfmt-corpus-separator --

SELECT 'foo' LIKE 'f%'

-- sqlfmt-corpus-separator --

SELECT 'foo' LIKE 'f___'

-- sqlfmt-corpus-separator --

SELECT 'foo' LIKE 'foo'

-- sqlfmt-corpus-separator --

SELECT 'foo' LIKE 'food'

-- sqlfmt-corpus-separator --

SELECT 'food' LIKE 'f%%d'

-- sqlfmt-corpus-separator --

SELECT 'food' LIKE 'f%_d'

-- sqlfmt-corpus-separator --

SELECT 'food' LIKE 'f%d%e'

-- sqlfmt-corpus-separator --

SELECT 'food' LIKE 'f%d'

-- sqlfmt-corpus-separator --

SELECT 'food' LIKE 'f_%d'

-- sqlfmt-corpus-separator --

SELECT 'food' LIKE 'f___'

-- sqlfmt-corpus-separator --

SELECT 'foodie' LIKE 'f%d%e'

-- sqlfmt-corpus-separator --

SELECT 'foods' LIKE 'f%%d'

-- sqlfmt-corpus-separator --

SELECT 'foods' LIKE 'f%d'

-- sqlfmt-corpus-separator --

SELECT 'foods' LIKE 'f___'

-- sqlfmt-corpus-separator --

SELECT 'fooooooooooooood' LIKE 'f%d'

-- sqlfmt-corpus-separator --

SELECT 'hello world'::name

-- sqlfmt-corpus-separator --

SELECT 'hello world'::name::text

-- sqlfmt-corpus-separator --

SELECT 'hello' LIKE v FROM kvString WHERE k LIKE 'like%' ORDER BY k

-- sqlfmt-corpus-separator --

SELECT 'hello'::bytea::text

-- sqlfmt-corpus-separator --

SELECT 'ii' LIKE '_i_i'

-- sqlfmt-corpus-separator --

SELECT 'iii' LIKE '_i_i'

-- sqlfmt-corpus-separator --

SELECT 'inf'::decimal + '-inf'::decimal

-- sqlfmt-corpus-separator --

SELECT 'infinity'::date + 1, 'infinity'::date - 1, '-infinity'::date + 1, '-infinity'::date - 1

-- sqlfmt-corpus-separator --

SELECT 'infinity'::date - 'infinity'::date

-- sqlfmt-corpus-separator --

SELECT 'infinity'::float4::numeric

-- sqlfmt-corpus-separator --

SELECT 'infinity'::float4::text

-- sqlfmt-corpus-separator --

SELECT 'infinity'::float8::numeric

-- sqlfmt-corpus-separator --

SELECT 'infinity'::float8::text

-- sqlfmt-corpus-separator --

SELECT 'int4'::regclass::oid = 'int4'::regtype::oid;

-- sqlfmt-corpus-separator --

SELECT 'int4'::regclass::text;

-- sqlfmt-corpus-separator --

SELECT 'int4'::regtype::text;

-- sqlfmt-corpus-separator --

SELECT 'm'::regclass = 's.m'::regclass

-- sqlfmt-corpus-separator --

SELECT 'max'::regproc

-- sqlfmt-corpus-separator --

SELECT 'mz_internal.mz_recent_activity_log'::regclass = (SELECT oid FROM mz_objects WHERE name = 'mz_recent_activity_log')

-- sqlfmt-corpus-separator --

SELECT 'mz_tables'::regclass = (SELECT oid FROM mz_objects WHERE name = 'mz_tables')

-- sqlfmt-corpus-separator --

SELECT 'mz_tables'::regclass::oid = (SELECT oid FROM mz_objects WHERE name = 'mz_tables')

-- sqlfmt-corpus-separator --

SELECT 'mz_tables'::regclass::text

-- sqlfmt-corpus-separator --

SELECT 'nan'::float4::text

-- sqlfmt-corpus-separator --

SELECT 'nan'::float8::text

-- sqlfmt-corpus-separator --

SELECT 'non-escaped-string'::bytea::text

-- sqlfmt-corpus-separator --

SELECT 'nonexistent'::regclass

-- sqlfmt-corpus-separator --

SELECT 'now'::regproc

-- sqlfmt-corpus-separator --

SELECT 'now'::regproc::oid

-- sqlfmt-corpus-separator --

SELECT 'now'::regproc::text

-- sqlfmt-corpus-separator --

SELECT 'public.t'::regclass::text;

-- sqlfmt-corpus-separator --

SELECT 'public.t'::regtype::text;

-- sqlfmt-corpus-separator --

SELECT 'quote_ident'::regclass::text;

-- sqlfmt-corpus-separator --

SELECT 'quote_ident'::regproc::text;

-- sqlfmt-corpus-separator --

SELECT 's.t'::regclass::text;

-- sqlfmt-corpus-separator --

SELECT 's.t'::regtype::text;

-- sqlfmt-corpus-separator --

SELECT 'sNaN'::numeric

-- sqlfmt-corpus-separator --

SELECT 't' LIKE '_o'

-- sqlfmt-corpus-separator --

SELECT 't'::regclass = 's.t'::regclass

-- sqlfmt-corpus-separator --

SELECT 't'::regclass::text;

-- sqlfmt-corpus-separator --

SELECT 't'::regtype = 's.t'::regtype

-- sqlfmt-corpus-separator --

SELECT 't'::regtype::text;

-- sqlfmt-corpus-separator --

SELECT 'to' LIKE '__o'

-- sqlfmt-corpus-separator --

SELECT 'to' LIKE '_o'

-- sqlfmt-corpus-separator --

SELECT 'too' LIKE '__o'

-- sqlfmt-corpus-separator --

SELECT 'too' LIKE '_o'

-- sqlfmt-corpus-separator --

SELECT 'tool' LIKE '__o'

-- sqlfmt-corpus-separator --

SELECT 'true'::JSON, 'false'::JSON, 'null'::JSON

-- sqlfmt-corpus-separator --

SELECT 'true'::bool

-- sqlfmt-corpus-separator --

SELECT 'wifi!' LIKE '_i_i'

-- sqlfmt-corpus-separator --

SELECT 'wifi' LIKE '_i_i'

-- sqlfmt-corpus-separator --

SELECT 'x' LIKE repeat('x', 367416)

-- sqlfmt-corpus-separator --

SELECT 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'::name;

-- sqlfmt-corpus-separator --

SELECT 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'::name;

-- sqlfmt-corpus-separator --

SELECT 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxא'::name;

-- sqlfmt-corpus-separator --

SELECT 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxא'::name;

-- sqlfmt-corpus-separator --

SELECT 'xyz'::float4

-- sqlfmt-corpus-separator --

SELECT 'xyz'::float8

-- sqlfmt-corpus-separator --

SELECT '{ "name": "Bob", "tags": [ "enim", "qui"]}'::JSONB @> '{"tags":["qu"]}'

-- sqlfmt-corpus-separator --

SELECT '{"(,)","empty","[-1,1]"}'::_int4range;

-- sqlfmt-corpus-separator --

SELECT '{"(,)","empty","[-1,1]"}'::_int8range;

-- sqlfmt-corpus-separator --

SELECT '{"(,)","empty","[-1,1]"}'::_numrange;

-- sqlfmt-corpus-separator --

SELECT '{"(,)","empty","[1969-12-31 11:59:59,1970-01-01 00:00:01]"}'::_tsrange;

-- sqlfmt-corpus-separator --

SELECT '{"(,)","empty","[1969-12-31 11:59:59,1970-01-01 00:00:01]"}'::_tstzrange;

-- sqlfmt-corpus-separator --

SELECT '{"(,)","empty","[1970-01-01,1970-01-03]"}'::_daterange;

-- sqlfmt-corpus-separator --

SELECT '{"1":2,"3":4}'::json

-- sqlfmt-corpus-separator --

SELECT '{"1":2,"3":4}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"a": "c", "b": null}'::jsonb -> 'b';

-- sqlfmt-corpus-separator --

SELECT '{"a": "c", "b": null}'::jsonb ->> 'b';

-- sqlfmt-corpus-separator --

SELECT '{"a": 1, "a": 2, "a": 3}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"a": [1]}'::jsonb #>> '{a,1}';

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> '';

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> 'z';

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> 1;

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> null::text;

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> '';

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> 'z';

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> 1;

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> null::text;

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "b":1, "c":null}'::JSONB @> '{"a":"b", "c":"q"}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "b":1, "c":null}'::JSONB @> '{"a":"b", "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "b":1, "c":null}'::JSONB @> '{"a":"b", "g":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "b":1, "c":null}'::JSONB @> '{"a":"b"}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "b":1, "c":null}'::JSONB @> '{"a":"c"}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "b":1, "c":null}'::JSONB @> '{"g":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "c":"q"}'::JSONB <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "c":null}'::JSONB <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "g":null}'::JSONB <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b","c":"d"}'::JSON

-- sqlfmt-corpus-separator --

SELECT '{"a":"b"}'::JSONB <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b"}'::JSONB->>'a'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b"}'::JSONB::STRING

-- sqlfmt-corpus-separator --

SELECT '{"a":"c"}'::JSONB <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":1,"a":2}'::JSON

-- sqlfmt-corpus-separator --

SELECT '{"a":1,"b":1}'::JSONB ? 'a','{"a":1,"b":1}'::JSONB ? 'b'

-- sqlfmt-corpus-separator --

SELECT '{"a":1,"b":2}'::JSON || '"c"'

-- sqlfmt-corpus-separator --

SELECT '{"a":1,"b":2}'::JSON || '{"b":3,"c":4}'

-- sqlfmt-corpus-separator --

SELECT '{"a":1,"b":2}'::JSONB || '"c"'::JSONB

-- sqlfmt-corpus-separator --

SELECT '{"a":1,"b":2}'::JSONB || '{"b":3,"c":4}'::JSONB

-- sqlfmt-corpus-separator --

SELECT '{"a":1,"b":2}'::JSONB->'b'

-- sqlfmt-corpus-separator --

SELECT '{"a":1,"b":2}'::JSONB->'c','{"c":1}'::JSONB->'a'

-- sqlfmt-corpus-separator --

SELECT '{"a":1,"b":2}'::JSONB->>'b'

-- sqlfmt-corpus-separator --

SELECT '{"a":1,"b":2}'::JSONB->>'c','{"c":1}'::JSONB->>'a'

-- sqlfmt-corpus-separator --

SELECT '{"a":1,"b":{"c":3}}'::JSONB->'b'->'c'

-- sqlfmt-corpus-separator --

SELECT '{"a":1,"c":{"foo":"bar"}}'::JSON

-- sqlfmt-corpus-separator --

SELECT '{"a":1}'::JSONB - 'a'

-- sqlfmt-corpus-separator --

SELECT '{"a":1}'::JSONB - 'b'

-- sqlfmt-corpus-separator --

SELECT '{"a":1}'::JSONB ? 'a','{"a":1}'::JSONB ? 'b'

-- sqlfmt-corpus-separator --

SELECT '{"a":1}'::JSONB#>'{a}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a":1}'::JSONB#>>'{a}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a":1}'::JSONB->'a'

-- sqlfmt-corpus-separator --

SELECT '{"a":["b"]}'::JSONB#>'{a,0}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a":["b"]}'::JSONB#>'{a,b}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a":["b"]}'::JSONB#>>'{a,0}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a":["b"]}'::JSONB#>>'{a,b}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a":[1,2,3]}'::JSONB->'a' @> '2'::JSONB

-- sqlfmt-corpus-separator --

SELECT '{"a":[null]}'::JSONB#>>'{a,0}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a":null}'::JSONB->>'a'

-- sqlfmt-corpus-separator --

SELECT '{"a":{"b":"c"}}'::JSONB#>'{a,b}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a":{"b":"c"}}'::JSONB#>>'{a,b}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"g":null}'::JSONB <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"x":"y"}'::jsonb <> '{"x":"y"}'::jsonb;

-- sqlfmt-corpus-separator --

SELECT '{"x":"y"}'::jsonb <> '{"x":"z"}'::jsonb;

-- sqlfmt-corpus-separator --

SELECT '{"x":"y"}'::jsonb = '{"x":"y"}'::jsonb;

-- sqlfmt-corpus-separator --

SELECT '{"x":"y"}'::jsonb = '{"x":"z"}'::jsonb;

-- sqlfmt-corpus-separator --

SELECT '{''2001-02-03 04:05:06.123456789'', ''2001-02-03 04:05:06.987'', ''2001-02-03 04:05:06.5''}'::y2::text

-- sqlfmt-corpus-separator --

SELECT '{'::JSON

-- sqlfmt-corpus-separator --

SELECT '{'::JSONB

-- sqlfmt-corpus-separator --

SELECT '{'::int4range;

-- sqlfmt-corpus-separator --

SELECT '{'::int8range;

-- sqlfmt-corpus-separator --

SELECT '{'::numrange;

-- sqlfmt-corpus-separator --

SELECT '{'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '{'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '{1, 2, 3, NULL}'::numeric[] @> '{1, NULL}'::numeric[];

-- sqlfmt-corpus-separator --

SELECT '{1,2,3}'::int2[]::int2vector::text

-- sqlfmt-corpus-separator --

SELECT '{1,2}'::bool;

-- sqlfmt-corpus-separator --

SELECT '{1,2}'::int4_list_c::text

-- sqlfmt-corpus-separator --

SELECT '{1,2}'::int4_list_c::text;

-- sqlfmt-corpus-separator --

SELECT '{1,2}'::int8_list_c::text

-- sqlfmt-corpus-separator --

SELECT '{1,2}'::numeric[] @> '{}'::numeric[];

-- sqlfmt-corpus-separator --

SELECT '{1.2,2.3}'::float4_list_c::text

-- sqlfmt-corpus-separator --

SELECT '{1.2,2.3}'::float8_list_c::text

-- sqlfmt-corpus-separator --

SELECT '{1.23,2.34}'::numeric_list_c::text

-- sqlfmt-corpus-separator --

SELECT '{12:34:56}'::time_list_c::text

-- sqlfmt-corpus-separator --

SELECT '{1y 2d 3h 4m}'::interval_list_c::text

-- sqlfmt-corpus-separator --

SELECT '{1}'::int4_list || '{2}'::int4_list_too;

-- sqlfmt-corpus-separator --

SELECT '{1}'::int4_list_too || '{{2}}'::int4_list_list

-- sqlfmt-corpus-separator --

SELECT '{1}'::numeric[] @> '{1, NULL}'::numeric[];

-- sqlfmt-corpus-separator --

SELECT '{1}{1}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{2001-01-01 12:34:56}'::timestamp_list_c::text

-- sqlfmt-corpus-separator --

SELECT '{2001-01-01 12:34:56}'::timestamptz_list_c::text

-- sqlfmt-corpus-separator --

SELECT '{2001-01-01}'::date_list_c::text

-- sqlfmt-corpus-separator --

SELECT '{NULL, 1}'::numeric[] @> '{1}'::numeric[];

-- sqlfmt-corpus-separator --

SELECT '{NULL}'::numeric[] @> '{NULL}'::numeric[];

-- sqlfmt-corpus-separator --

SELECT '{\{\"1\":2\}}'::jsonb_list_c::text;

-- sqlfmt-corpus-separator --

SELECT '{\}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{a,b}'::text_list_c::text

-- sqlfmt-corpus-separator --

SELECT '{a=>1,b=>2}'::int4_map::text;

-- sqlfmt-corpus-separator --

SELECT '{a=>1.23}'::numeric_map_c::text

-- sqlfmt-corpus-separator --

SELECT '{a=>1.2}'::float4_map_c::text

-- sqlfmt-corpus-separator --

SELECT '{a=>1.2}'::float8_map_c::text

-- sqlfmt-corpus-separator --

SELECT '{a=>12:34:56}'::time_map_c::text

-- sqlfmt-corpus-separator --

SELECT '{a=>1y 2d 3h 4m}'::interval_map_c::text

-- sqlfmt-corpus-separator --

SELECT '{a=>1}'::bool;

-- sqlfmt-corpus-separator --

SELECT '{a=>1}'::int4_map_c::text

-- sqlfmt-corpus-separator --

SELECT '{a=>1}'::int8_map_c::text

-- sqlfmt-corpus-separator --

SELECT '{a=>2001-01-01 12:34:56}'::timestamp_map_c::text

-- sqlfmt-corpus-separator --

SELECT '{a=>2001-01-01 12:34:56}'::timestamptz_map_c::text

-- sqlfmt-corpus-separator --

SELECT '{a=>2001-01-01}'::date_map_c::text

-- sqlfmt-corpus-separator --

SELECT '{a=>\{\"1\":2\}}'::jsonb_map_c::text;

-- sqlfmt-corpus-separator --

SELECT '{a=>a}'::text_map_c::text

-- sqlfmt-corpus-separator --

SELECT '{a=>true}'::bool_map_c::text

-- sqlfmt-corpus-separator --

SELECT '{a=>{b=>1.2,c=>5.6789}}'::y4::text

-- sqlfmt-corpus-separator --

SELECT '{null, {1}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{o, oOOo, "oOOo", "}"}'::text[]

-- sqlfmt-corpus-separator --

SELECT '{true}'::bool_list_c::text

-- sqlfmt-corpus-separator --

SELECT '{{"1 2" x},{3}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{1,2},{1}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{1,2}}'::int4_list_list_c::text;

-- sqlfmt-corpus-separator --

SELECT '{{1,{2}},{2,3}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{1}, null}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{1},{{2}}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{1},{}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{1}{1}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{1}}'::int4_list_list || '{2}'::int4_list_too;

-- sqlfmt-corpus-separator --

SELECT '{{1}}'::int4_list_list || '{{2}}'::int4_list list

-- sqlfmt-corpus-separator --

SELECT '{{1}}'::int4_list_list || '{{2}}'::int4_list_list_too;

-- sqlfmt-corpus-separator --

SELECT '{{{1}},{2}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{{null}},{{}}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{{}},{}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{},{1}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{},{{}}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{}{}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{}'::JSON

-- sqlfmt-corpus-separator --

SELECT '{}'::JSONB #> '{-9223372036854775808}';

-- sqlfmt-corpus-separator --

SELECT '{}'::JSONB - -9223372036854775808;

-- sqlfmt-corpus-separator --

SELECT '{}'::JSONB - 1

-- sqlfmt-corpus-separator --

SELECT '{}'::JSONB ->> -9223372036854775808;

-- sqlfmt-corpus-separator --

SELECT '{}'::JSONB[]

-- sqlfmt-corpus-separator --

SELECT '{}'::TEXT[][] @> '{{a, b}, {a, A}}'::TEXT[][];

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::date

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::double;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::interval

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::jsonb;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::numeric;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::text;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::time

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::timestamp

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::timestamptz

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::varchar;

-- sqlfmt-corpus-separator --

SELECT '{}'::numeric[] @> '{1,2}'::numeric[];

-- sqlfmt-corpus-separator --

SELECT '{}'::numeric[] @> '{}'::numeric[];

-- sqlfmt-corpus-separator --

SELECT '{}{}'::text[];

-- sqlfmt-corpus-separator --

SELECT 'ΜΆΪΟΣ' LIKE 'ΜΆΪΟΣ'

-- sqlfmt-corpus-separator --

SELECT 'Μάϊος' ILIKE 'ΜΆΪΟΣ'

-- sqlfmt-corpus-separator --

SELECT 'Μάϊος' LIKE 'ΜΆΪΟΣ'

-- sqlfmt-corpus-separator --

SELECT '日本語'::text::bytea::text

-- sqlfmt-corpus-separator --

SELECT '漢漢' LIKE '_漢'

-- sqlfmt-corpus-separator --

SELECT '漢漢' LIKE '漢\漢'

-- sqlfmt-corpus-separator --

SELECT '漢漢' LIKE '漢_'

-- sqlfmt-corpus-separator --

SELECT ('"-Infinity"'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('"1"'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('"1-2 3 4:5:6.7"'::jsonb)::interval;

-- sqlfmt-corpus-separator --

SELECT ('"1969-06-01 10:10:10.410"'::jsonb)::timestamp;

-- sqlfmt-corpus-separator --

SELECT ('"Infinity"'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('"NaN"'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('1'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('1.2'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('24:00:00'::TIME)::STRING

-- sqlfmt-corpus-separator --

SELECT ('["2019-12-31"]'::jsonb)::date;

-- sqlfmt-corpus-separator --

SELECT ('[1]'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('null'::jsonb)->>0;

-- sqlfmt-corpus-separator --

SELECT ('null'::jsonb)::text;

-- sqlfmt-corpus-separator --

SELECT ('{1.2,2.3}'::numeric_list_c)::text;

-- sqlfmt-corpus-separator --

SELECT (-1)::int8::oid

-- sqlfmt-corpus-separator --

SELECT (-1)::oid

-- sqlfmt-corpus-separator --

SELECT (-1)::oid < 2::oid

-- sqlfmt-corpus-separator --

SELECT (1.4238790346995263e-40::DECIMAL / 6.011482313728436e+41::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT (1/0 > 0) AND (32768::int2 > 0);

-- sqlfmt-corpus-separator --

SELECT (1/0 > 0) OR (32768::int2 > 0);

-- sqlfmt-corpus-separator --

SELECT (32768::int2 > 0) AND (1/0 > 0);

-- sqlfmt-corpus-separator --

SELECT (32768::int2 > 0) OR (1/0 > 0);

-- sqlfmt-corpus-separator --

SELECT (DATE '2000-01-01')::text

-- sqlfmt-corpus-separator --

SELECT (SELECT DISTINCT ON (a) a FROM abc ORDER BY a, b||'foo') || 'bar';

-- sqlfmt-corpus-separator --

SELECT (TIMESTAMP '2000-01-01 00:00:00')::text

-- sqlfmt-corpus-separator --

SELECT (TIMESTAMPTZ '2000-01-01 00:00:00-6')::text

-- sqlfmt-corpus-separator --

SELECT (date '2007-02-01')::text

-- sqlfmt-corpus-separator --

SELECT (interval '-1-2 3 -4:5:6.7')::text;

-- sqlfmt-corpus-separator --

SELECT (list_append(NULL, 1))::text

-- sqlfmt-corpus-separator --

SELECT (null::jsonb)->>0;

-- sqlfmt-corpus-separator --

SELECT (null::jsonb)::text;

-- sqlfmt-corpus-separator --

SELECT (time '01:23:45')::text;

-- sqlfmt-corpus-separator --

SELECT (timestamp '2007-02-01 15:04:05')::text;

-- sqlfmt-corpus-separator --

SELECT (timestamp '2016-02-10 19:46:33.306157519')::string

-- sqlfmt-corpus-separator --

SELECT (timestamptz '2007-02-01 15:04:05+06')::text;

-- sqlfmt-corpus-separator --

SELECT (timestamptz '2016-02-10 19:46:33.306157519')::string

-- sqlfmt-corpus-separator --

SELECT * FROM kv GROUP BY v, count(DISTINCT w)

-- sqlfmt-corpus-separator --

SELECT * FROM not_allowed_tests GROUP BY v, count(w) OVER ();

-- sqlfmt-corpus-separator --

SELECT * FROM s WHERE d = 'inf'::decimal

-- sqlfmt-corpus-separator --

SELECT * FROM t
WHERE row_number() over () > 1;

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE a = '2015-08-25 04:45:45.53453+01:00'::timestamp

-- sqlfmt-corpus-separator --

SELECT * FROM t1, t2 WHERE a = b AND age(b, TIMESTAMPTZ '2017-01-01') > INTERVAL '1 day'

-- sqlfmt-corpus-separator --

SELECT * FROM t_data
WHERE f1 ILIKE '%bCd%'
ORDER BY f1;

-- sqlfmt-corpus-separator --

SELECT * FROM t_data
WHERE f1 ILIKE (SELECT op_val FROM t_operator)
ORDER BY f1;

-- sqlfmt-corpus-separator --

SELECT - '-2147483648'::int4

-- sqlfmt-corpus-separator --

SELECT - '-32768'::int2

-- sqlfmt-corpus-separator --

SELECT - '-9223372036854775808'::int8

-- sqlfmt-corpus-separator --

SELECT - -0.00::decimal, - - -0.00::decimal, - - -0.00, - -0.00

-- sqlfmt-corpus-separator --

SELECT - INTERVAL '-1 year -2 months -3 days -04:05:06.7';

-- sqlfmt-corpus-separator --

SELECT - INTERVAL '-1 year -2 months 3 days 04:05:06.7';

-- sqlfmt-corpus-separator --

SELECT - INTERVAL '1 year 2 months -3 days -04:05:06.7';

-- sqlfmt-corpus-separator --

SELECT - INTERVAL '1-2 3 4:5:6.7';

-- sqlfmt-corpus-separator --

SELECT -'0.2'::numeric

-- sqlfmt-corpus-separator --

SELECT -'2'::numeric

-- sqlfmt-corpus-separator --

SELECT -'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT -0.0 - 1::numeric  * '-0.0 '::numeric;

-- sqlfmt-corpus-separator --

SELECT -0::numeric;

-- sqlfmt-corpus-separator --

SELECT -1.00 < 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT -1.00 <= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT -1.00 <> 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT -1.00 = 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT -1.00 > 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT -1.00 >= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT -12.0::double::uint2

-- sqlfmt-corpus-separator --

SELECT -12.0::double::uint4

-- sqlfmt-corpus-separator --

SELECT -12.0::double::uint8

-- sqlfmt-corpus-separator --

SELECT -12.0::numeric::uint2

-- sqlfmt-corpus-separator --

SELECT -12.0::numeric::uint4

-- sqlfmt-corpus-separator --

SELECT -12.0::numeric::uint8

-- sqlfmt-corpus-separator --

SELECT -20.1 % 'NaN'::numeric

-- sqlfmt-corpus-separator --

SELECT -21::int2::uint2

-- sqlfmt-corpus-separator --

SELECT -21::int4::uint2

-- sqlfmt-corpus-separator --

SELECT -21::int8::uint2

-- sqlfmt-corpus-separator --

SELECT -3402823669209384634633746074317682 - 3402823669209384634633746074317682::numeric

-- sqlfmt-corpus-separator --

SELECT -47::int2::uint4

-- sqlfmt-corpus-separator --

SELECT -47::int4::uint4

-- sqlfmt-corpus-separator --

SELECT -47::int8::uint4

-- sqlfmt-corpus-separator --

SELECT -666::uint2

-- sqlfmt-corpus-separator --

SELECT -666::uint4

-- sqlfmt-corpus-separator --

SELECT -666::uint8

-- sqlfmt-corpus-separator --

SELECT -790123449679012344967901234496790123392 - 790123449679012344967901234496790123392::numeric

-- sqlfmt-corpus-separator --

SELECT -7::numeric::int8, -7.3::int8, -7.5::int8

-- sqlfmt-corpus-separator --

SELECT -99::int2::uint8

-- sqlfmt-corpus-separator --

SELECT -99::int4::uint8

-- sqlfmt-corpus-separator --

SELECT -99::int8::uint8

-- sqlfmt-corpus-separator --

SELECT -INTERVAL '-2147483648 days -2562047787 hours -59 minutes -59.999999 seconds';

-- sqlfmt-corpus-separator --

SELECT -INTERVAL '-2147483648 days';

-- sqlfmt-corpus-separator --

SELECT -INTERVAL '-2147483648 months';

-- sqlfmt-corpus-separator --

SELECT -INTERVAL '-9223372036854775808 microseconds';

-- sqlfmt-corpus-separator --

SELECT .123456789012345678901234567890123456789 / 10::numeric

-- sqlfmt-corpus-separator --

SELECT 0.00 < 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 0.00 < 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 0.00 <= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 0.00 <= 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 0.00 <> 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 0.00 <> 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 0.00 = 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 0.00 = 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 0.00 > 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 0.00 > 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 0.00 >= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 0.00 >= 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 0.000::float4, 3.40282347E+38::float4, -3.40282347E+38::float4

-- sqlfmt-corpus-separator --

SELECT 0.000::float8, 3.40282347E+38::float8, -3.40282347E+38::float8

-- sqlfmt-corpus-separator --

SELECT 0.002::numeric(39,1);

-- sqlfmt-corpus-separator --

SELECT 0.12::numeric(39,1) * 0.2::numeric(39,2);

-- sqlfmt-corpus-separator --

SELECT 0.12::numeric(39,1) + 0.2::numeric(39,2);

-- sqlfmt-corpus-separator --

SELECT 0.12::numeric(39,2) * 0.2::numeric(39,1);

-- sqlfmt-corpus-separator --

SELECT 0.12::numeric(39,2) + 0.2::numeric(39,1);

-- sqlfmt-corpus-separator --

SELECT 0.2::numeric(1,39);

-- sqlfmt-corpus-separator --

SELECT 0.2::numeric(39,1);

-- sqlfmt-corpus-separator --

SELECT 0.2::numeric(39,3);

-- sqlfmt-corpus-separator --

SELECT 0.2::numeric(39,40);

-- sqlfmt-corpus-separator --

SELECT 0.2::numeric(40,1);

-- sqlfmt-corpus-separator --

SELECT 0::mz_timestamp <= mz_now()

-- sqlfmt-corpus-separator --

SELECT 0::numeric * -1::numeric

-- sqlfmt-corpus-separator --

SELECT 0::numeric / -1::numeric

-- sqlfmt-corpus-separator --

SELECT 0::numeric / 0::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric < 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric < -1.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric < 0.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric < 0::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric < 1.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric < 1.2;

-- sqlfmt-corpus-separator --

SELECT 0::numeric < 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <= -1.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <= 0.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <= 0::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <= 1.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <= 1.2;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <= 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <> 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <> -1.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <> 0.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <> 0::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <> 1.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <> 1.2;

-- sqlfmt-corpus-separator --

SELECT 0::numeric <> 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric = 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric = -1.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric = 0.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric = 0::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric = 1.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric = 1.2;

-- sqlfmt-corpus-separator --

SELECT 0::numeric = 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric > 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric > -1.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric > 0.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric > 0::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric > 1.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric > 1.2;

-- sqlfmt-corpus-separator --

SELECT 0::numeric > 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric >= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric >= -1.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric >= 0.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric >= 0::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric >= 1.00;

-- sqlfmt-corpus-separator --

SELECT 0::numeric >= 1.2;

-- sqlfmt-corpus-separator --

SELECT 0::numeric >= 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 0::numeric::int8, -0::numeric::int8

-- sqlfmt-corpus-separator --

SELECT 0::oid < 4294967295::oid

-- sqlfmt-corpus-separator --

SELECT 1 + lag(a, 1, 0) OVER (ORDER BY a), *
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a), a ASC;

-- sqlfmt-corpus-separator --

SELECT 1 + lag(a, 1, 0) OVER (ORDER BY a), *
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT 1 + lag(a, 1, 0) OVER (ORDER BY a), lead(a) OVER (ORDER BY b) AS o, a, b
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a), o DESC;

-- sqlfmt-corpus-separator --

SELECT 1 <= 2::oid

-- sqlfmt-corpus-separator --

SELECT 1 FROM kv GROUP BY v, w::DECIMAL HAVING w::DECIMAL > 1

-- sqlfmt-corpus-separator --

SELECT 1 FROM not_allowed_tests GROUP BY 1 HAVING sum(1) OVER (PARTITION BY 1) > 1;

-- sqlfmt-corpus-separator --

SELECT 1, jsonb_object_keys('{"1":2,"3":4}'::JSONB), jsonb_object_keys('{"1":2,"3":4,"5":6}'::JSONB) ORDER BY 3

-- sqlfmt-corpus-separator --

SELECT 1.00 < 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.00 <= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.00 <> 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.00 = 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.00 > 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.00 >= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.00123::numeric(39,2) = 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.00::decimal(6,4)

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::date

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::double;

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::interval

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::jsonb

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::text;

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::time

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::timestamp

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::timestamptz

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::varchar;

-- sqlfmt-corpus-separator --

SELECT 1.2 < 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.2 <= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.2 <> 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.2 = 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.2 > 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.2 >= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.23456789::numeric(39,2) < 1.23456789::numeric(39,3);

-- sqlfmt-corpus-separator --

SELECT 1.23456789::numeric(39,5) < 1.23456789::numeric(39,4);

-- sqlfmt-corpus-separator --

SELECT 1.234::float4, 1234.567891234567::float4, 0.000000000000000123456789123456789012345::float4, -0.000000000000000123456789123456789012345::float4

-- sqlfmt-corpus-separator --

SELECT 1.234::float8, 1234.567891234567::float8, 0.000000000000000123456789123456789012345::float8, -0.000000000000000123456789123456789012345::float8

-- sqlfmt-corpus-separator --

SELECT 1.23::float4::numeric, -1.23::float4::numeric, 1.23::float4::numeric(38,1)

-- sqlfmt-corpus-separator --

SELECT 1.23::float8::numeric, -1.23::float8::numeric, 1.23::float8::numeric(38,1)

-- sqlfmt-corpus-separator --

SELECT 1.2::double::date

-- sqlfmt-corpus-separator --

SELECT 1.2::double::double;

-- sqlfmt-corpus-separator --

SELECT 1.2::double::interval

-- sqlfmt-corpus-separator --

SELECT 1.2::double::jsonb;

-- sqlfmt-corpus-separator --

SELECT 1.2::double::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.2::double::text;

-- sqlfmt-corpus-separator --

SELECT 1.2::double::time

-- sqlfmt-corpus-separator --

SELECT 1.2::double::timestamp

-- sqlfmt-corpus-separator --

SELECT 1.2::double::timestamptz

-- sqlfmt-corpus-separator --

SELECT 1.2::double::varchar;

-- sqlfmt-corpus-separator --

SELECT 1.2::float8::float4

-- sqlfmt-corpus-separator --

SELECT 10-sum(a), lag(sum(a)) OVER (ORDER BY sum(a))
FROM foo
GROUP BY b
ORDER BY 2;

-- sqlfmt-corpus-separator --

SELECT 10-sum(a), lag(sum(a)) OVER (ORDER BY sum(a))
FROM foo
GROUP BY b
ORDER BY 3;

-- sqlfmt-corpus-separator --

SELECT 101.00::decimal(4,6)

-- sqlfmt-corpus-separator --

SELECT 101.00::decimal(6,4)

-- sqlfmt-corpus-separator --

SELECT 1082 = 'date'::regtype

-- sqlfmt-corpus-separator --

SELECT 1082::regtype::text

-- sqlfmt-corpus-separator --

SELECT 10::uint2 * 3::uint2

-- sqlfmt-corpus-separator --

SELECT 10::uint2 + 3::uint2

-- sqlfmt-corpus-separator --

SELECT 10::uint4 * 3::uint4

-- sqlfmt-corpus-separator --

SELECT 10::uint4 + 3::uint4

-- sqlfmt-corpus-separator --

SELECT 10::uint8 * 3::uint8

-- sqlfmt-corpus-separator --

SELECT 10::uint8 + 3::uint8

-- sqlfmt-corpus-separator --

SELECT 12.0::double::uint2

-- sqlfmt-corpus-separator --

SELECT 12.0::double::uint4

-- sqlfmt-corpus-separator --

SELECT 12.0::double::uint8

-- sqlfmt-corpus-separator --

SELECT 12.0::numeric::uint2

-- sqlfmt-corpus-separator --

SELECT 12.0::numeric::uint4

-- sqlfmt-corpus-separator --

SELECT 12.0::numeric::uint8

-- sqlfmt-corpus-separator --

SELECT 12.4::double::uint2

-- sqlfmt-corpus-separator --

SELECT 12.4::double::uint4

-- sqlfmt-corpus-separator --

SELECT 12.4::double::uint8

-- sqlfmt-corpus-separator --

SELECT 12.4::numeric::uint2

-- sqlfmt-corpus-separator --

SELECT 12.4::numeric::uint4

-- sqlfmt-corpus-separator --

SELECT 12.4::numeric::uint8

-- sqlfmt-corpus-separator --

SELECT 12.6::double::uint2

-- sqlfmt-corpus-separator --

SELECT 12.6::double::uint4

-- sqlfmt-corpus-separator --

SELECT 12.6::double::uint8

-- sqlfmt-corpus-separator --

SELECT 12.6::numeric::uint2

-- sqlfmt-corpus-separator --

SELECT 12.6::numeric::uint4

-- sqlfmt-corpus-separator --

SELECT 12.6::numeric::uint8

-- sqlfmt-corpus-separator --

SELECT 123456789012345678901234567890123456789 * 10::numeric

-- sqlfmt-corpus-separator --

SELECT 124::uint2::double

-- sqlfmt-corpus-separator --

SELECT 124::uint2::int4

-- sqlfmt-corpus-separator --

SELECT 124::uint2::int8

-- sqlfmt-corpus-separator --

SELECT 124::uint2::numeric

-- sqlfmt-corpus-separator --

SELECT 124::uint2::text

-- sqlfmt-corpus-separator --

SELECT 124::uint2::uint4

-- sqlfmt-corpus-separator --

SELECT 124::uint2::uint8

-- sqlfmt-corpus-separator --

SELECT 12::int8::numeric(39,38)

-- sqlfmt-corpus-separator --

SELECT 12::numeric(39,38)

-- sqlfmt-corpus-separator --

SELECT 13::uint2 % 5::uint2

-- sqlfmt-corpus-separator --

SELECT 13::uint4 % 5::uint4

-- sqlfmt-corpus-separator --

SELECT 13::uint8 % 5::uint8

-- sqlfmt-corpus-separator --

SELECT 15445::uint8::double

-- sqlfmt-corpus-separator --

SELECT 15445::uint8::int4

-- sqlfmt-corpus-separator --

SELECT 15445::uint8::int8

-- sqlfmt-corpus-separator --

SELECT 15445::uint8::numeric

-- sqlfmt-corpus-separator --

SELECT 15445::uint8::text

-- sqlfmt-corpus-separator --

SELECT 15445::uint8::uint2

-- sqlfmt-corpus-separator --

SELECT 15445::uint8::uint4

-- sqlfmt-corpus-separator --

SELECT 17.8 % 4::numeric

-- sqlfmt-corpus-separator --

SELECT 18446744073709551615.4::numeric::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709551615.5::numeric::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709551615::mz_timestamp::timestamp

-- sqlfmt-corpus-separator --

SELECT 18446744073709551615::uint8 * 2::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709551615::uint8 + 1::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709551616::numeric::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709551616::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709553664.0::double::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709553664.5::double::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709553665::double::uint8

-- sqlfmt-corpus-separator --

SELECT 18::uint2 <> 18::uint2

-- sqlfmt-corpus-separator --

SELECT 18::uint2 <> 36::uint2

-- sqlfmt-corpus-separator --

SELECT 18::uint2 = 18::uint2

-- sqlfmt-corpus-separator --

SELECT 18::uint2 = 36::uint2

-- sqlfmt-corpus-separator --

SELECT 18::uint4 <> 18::uint4

-- sqlfmt-corpus-separator --

SELECT 18::uint4 = 18::uint4

-- sqlfmt-corpus-separator --

SELECT 18::uint8 <> 18::uint8

-- sqlfmt-corpus-separator --

SELECT 18::uint8 <> 36::uint8

-- sqlfmt-corpus-separator --

SELECT 18::uint8 = 18::uint8

-- sqlfmt-corpus-separator --

SELECT 18::uint8 = 36::uint8

-- sqlfmt-corpus-separator --

SELECT 1::decimal(2, 2)

-- sqlfmt-corpus-separator --

SELECT 1::int4::oid

-- sqlfmt-corpus-separator --

SELECT 1::int4::oid::int4

-- sqlfmt-corpus-separator --

SELECT 1::int4::regclass

-- sqlfmt-corpus-separator --

SELECT 1::int4::regproc

-- sqlfmt-corpus-separator --

SELECT 1::int4::regtype

-- sqlfmt-corpus-separator --

SELECT 1::numeric + 2::numeric

-- sqlfmt-corpus-separator --

SELECT 1::numeric - 2::numeric

-- sqlfmt-corpus-separator --

SELECT 1::numeric / 0.000000000000000000000000000000000000001;

-- sqlfmt-corpus-separator --

SELECT 1::numeric / 0.0;

-- sqlfmt-corpus-separator --

SELECT 1::numeric / 0::numeric

-- sqlfmt-corpus-separator --

SELECT 1::numeric / 11;

-- sqlfmt-corpus-separator --

SELECT 1::numeric / 2::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::numeric < 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::numeric < -1.00;

-- sqlfmt-corpus-separator --

SELECT 1::numeric < 1.00;

-- sqlfmt-corpus-separator --

SELECT 1::numeric < 1.2;

-- sqlfmt-corpus-separator --

SELECT 1::numeric < 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::numeric <= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::numeric <= -1.00;

-- sqlfmt-corpus-separator --

SELECT 1::numeric <= 1.00;

-- sqlfmt-corpus-separator --

SELECT 1::numeric <= 1.2;

-- sqlfmt-corpus-separator --

SELECT 1::numeric <= 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::numeric <> 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::numeric <> -1.00;

-- sqlfmt-corpus-separator --

SELECT 1::numeric <> 1.00;

-- sqlfmt-corpus-separator --

SELECT 1::numeric <> 1.2;

-- sqlfmt-corpus-separator --

SELECT 1::numeric <> 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::numeric = 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::numeric = -1.00;

-- sqlfmt-corpus-separator --

SELECT 1::numeric = 1.00;

-- sqlfmt-corpus-separator --

SELECT 1::numeric = 1.2;

-- sqlfmt-corpus-separator --

SELECT 1::numeric = 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::numeric > 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::numeric > -1.00;

-- sqlfmt-corpus-separator --

SELECT 1::numeric > 1.00;

-- sqlfmt-corpus-separator --

SELECT 1::numeric > 1.2;

-- sqlfmt-corpus-separator --

SELECT 1::numeric > 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::numeric >= 'NaN'::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::numeric >= -1.00;

-- sqlfmt-corpus-separator --

SELECT 1::numeric >= 1.00;

-- sqlfmt-corpus-separator --

SELECT 1::numeric >= 1.2;

-- sqlfmt-corpus-separator --

SELECT 1::numeric >= 1::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::numeric(39,39)

-- sqlfmt-corpus-separator --

SELECT 1::oid

-- sqlfmt-corpus-separator --

SELECT 1::oid != 2::oid

-- sqlfmt-corpus-separator --

SELECT 1::oid < 2::oid

-- sqlfmt-corpus-separator --

SELECT 1::oid = 2::oid

-- sqlfmt-corpus-separator --

SELECT 1::oid > 2

-- sqlfmt-corpus-separator --

SELECT 1::oid >= 2

-- sqlfmt-corpus-separator --

SELECT 1::oid::regclass

-- sqlfmt-corpus-separator --

SELECT 1::oid::regclass::oid

-- sqlfmt-corpus-separator --

SELECT 1::oid::regproc

-- sqlfmt-corpus-separator --

SELECT 1::oid::regproc::oid

-- sqlfmt-corpus-separator --

SELECT 1::oid::regtype

-- sqlfmt-corpus-separator --

SELECT 1::oid::regtype::oid

-- sqlfmt-corpus-separator --

SELECT 1::oid::text

-- sqlfmt-corpus-separator --

SELECT 1::regclass

-- sqlfmt-corpus-separator --

SELECT 1::regproc

-- sqlfmt-corpus-separator --

SELECT 1::regtype

-- sqlfmt-corpus-separator --

SELECT 1::uint2 < 2::uint2

-- sqlfmt-corpus-separator --

SELECT 1::uint2 <= 2::uint2

-- sqlfmt-corpus-separator --

SELECT 1::uint2 > 2::uint2

-- sqlfmt-corpus-separator --

SELECT 1::uint2 >= 2::uint2

-- sqlfmt-corpus-separator --

SELECT 1::uint4 < 2::uint4

-- sqlfmt-corpus-separator --

SELECT 1::uint4 <= 2::uint4

-- sqlfmt-corpus-separator --

SELECT 1::uint4 > 2::uint4

-- sqlfmt-corpus-separator --

SELECT 1::uint4 >= 2::uint4

-- sqlfmt-corpus-separator --

SELECT 1::uint8 < 2::uint8

-- sqlfmt-corpus-separator --

SELECT 1::uint8 <= 2::uint8

-- sqlfmt-corpus-separator --

SELECT 1::uint8 > 2::uint8

-- sqlfmt-corpus-separator --

SELECT 1::uint8 >= 2::uint8

-- sqlfmt-corpus-separator --

SELECT 1E-39 / 10::numeric

-- sqlfmt-corpus-separator --

SELECT 1e-16::DECIMAL / 2, 1e-16::DECIMAL / 3, 1e-16::DECIMAL / 2 * 2

-- sqlfmt-corpus-separator --

SELECT 20::uint2 / 0::uint2

-- sqlfmt-corpus-separator --

SELECT 20::uint2 / 2::uint2

-- sqlfmt-corpus-separator --

SELECT 20::uint4 / 0::uint4

-- sqlfmt-corpus-separator --

SELECT 20::uint4 / 2::uint4

-- sqlfmt-corpus-separator --

SELECT 20::uint8 / 0::uint8

-- sqlfmt-corpus-separator --

SELECT 20::uint8 / 2::uint8

-- sqlfmt-corpus-separator --

SELECT 2147483647::numeric, -2147483648::numeric

-- sqlfmt-corpus-separator --

SELECT 2147483648::uint4

-- sqlfmt-corpus-separator --

SELECT 2147483648::uint4::int4

-- sqlfmt-corpus-separator --

SELECT 2147483648::uint8::int4

-- sqlfmt-corpus-separator --

SELECT 21::int2::uint2

-- sqlfmt-corpus-separator --

SELECT 21::int4::uint2

-- sqlfmt-corpus-separator --

SELECT 21::int8::uint2

-- sqlfmt-corpus-separator --

SELECT 23 % 4::numeric

-- sqlfmt-corpus-separator --

SELECT 23::uint2 <= 23::uint2

-- sqlfmt-corpus-separator --

SELECT 23::uint2 >= 23::uint2

-- sqlfmt-corpus-separator --

SELECT 23::uint4 <= 23::uint4

-- sqlfmt-corpus-separator --

SELECT 23::uint4 >= 23::uint4

-- sqlfmt-corpus-separator --

SELECT 23::uint8 <= 23::uint8

-- sqlfmt-corpus-separator --

SELECT 23::uint8 >= 23::uint8

-- sqlfmt-corpus-separator --

SELECT 2::numeric % 0::numeric

-- sqlfmt-corpus-separator --

SELECT 2::numeric / 'NaN'::numeric

-- sqlfmt-corpus-separator --

SELECT 2::regclass

-- sqlfmt-corpus-separator --

SELECT 32767::uint4 * 2::uint4

-- sqlfmt-corpus-separator --

SELECT 32767::uint4 + 1::uint4

-- sqlfmt-corpus-separator --

SELECT 32767::uint8 * 2::uint8

-- sqlfmt-corpus-separator --

SELECT 32767::uint8 + 1::uint8

-- sqlfmt-corpus-separator --

SELECT 32768::uint2

-- sqlfmt-corpus-separator --

SELECT 3402823669209384.634633746074317682 + 3402823669209384.634633746074317682::numeric

-- sqlfmt-corpus-separator --

SELECT 3402823669209384634633746074317682 + 3402823669209384634633746074317682::numeric

-- sqlfmt-corpus-separator --

SELECT 3::OID, '3'::OID

-- sqlfmt-corpus-separator --

SELECT 3::numeric % 2::numeric

-- sqlfmt-corpus-separator --

SELECT 4294967295.4::double::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967295.4::numeric::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967295.5::double::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967295.5::numeric::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967295::uint4 * 2::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967295::uint4 + 1::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967295::uint8 * 2::uint8

-- sqlfmt-corpus-separator --

SELECT 4294967295::uint8 + 1::uint8

-- sqlfmt-corpus-separator --

SELECT 4294967296.0::double::uint8

-- sqlfmt-corpus-separator --

SELECT 4294967296.0::numeric::uint8

-- sqlfmt-corpus-separator --

SELECT 4294967296::double::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967296::int8::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967296::int8::uint8

-- sqlfmt-corpus-separator --

SELECT 4294967296::numeric::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967296::oid

-- sqlfmt-corpus-separator --

SELECT 4294967296::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967296::uint8

-- sqlfmt-corpus-separator --

SELECT 4294967296::uint8::uint4

-- sqlfmt-corpus-separator --

SELECT 42::uint2

-- sqlfmt-corpus-separator --

SELECT 42::uint4

-- sqlfmt-corpus-separator --

SELECT 42::uint8

-- sqlfmt-corpus-separator --

SELECT 4567890123456789::int8::float8::text

-- sqlfmt-corpus-separator --

SELECT 45::uint2 - 3::uint2

-- sqlfmt-corpus-separator --

SELECT 45::uint2 - 50::uint2

-- sqlfmt-corpus-separator --

SELECT 45::uint4 - 3::uint4

-- sqlfmt-corpus-separator --

SELECT 45::uint4 - 50::uint4

-- sqlfmt-corpus-separator --

SELECT 45::uint8 - 3::uint8

-- sqlfmt-corpus-separator --

SELECT 45::uint8 - 50::uint8

-- sqlfmt-corpus-separator --

SELECT 47::int2::uint4

-- sqlfmt-corpus-separator --

SELECT 47::int4::uint4

-- sqlfmt-corpus-separator --

SELECT 47::int8::uint4

-- sqlfmt-corpus-separator --

SELECT 4::numeric % 2::numeric

-- sqlfmt-corpus-separator --

SELECT 4::uint2 # 5::uint2

-- sqlfmt-corpus-separator --

SELECT 4::uint2 & 5::uint2

-- sqlfmt-corpus-separator --

SELECT 4::uint2 | 5::uint2

-- sqlfmt-corpus-separator --

SELECT 4::uint4 # 5::uint4

-- sqlfmt-corpus-separator --

SELECT 4::uint4 & 5::uint4

-- sqlfmt-corpus-separator --

SELECT 4::uint4 | 5::uint4

-- sqlfmt-corpus-separator --

SELECT 4::uint8 # 5::uint8

-- sqlfmt-corpus-separator --

SELECT 4::uint8 & 5::uint8

-- sqlfmt-corpus-separator --

SELECT 4::uint8 | 5::uint8

-- sqlfmt-corpus-separator --

SELECT 5 + 3::text;

-- sqlfmt-corpus-separator --

SELECT 5::uint2 < 2::uint2

-- sqlfmt-corpus-separator --

SELECT 5::uint2 <= 2::uint2

-- sqlfmt-corpus-separator --

SELECT 5::uint2 > 2::uint2

-- sqlfmt-corpus-separator --

SELECT 5::uint2 >= 2::uint2

-- sqlfmt-corpus-separator --

SELECT 5::uint4 < 2::uint4

-- sqlfmt-corpus-separator --

SELECT 5::uint4 <= 2::uint4

-- sqlfmt-corpus-separator --

SELECT 5::uint4 > 2::uint4

-- sqlfmt-corpus-separator --

SELECT 5::uint4 >= 2::uint4

-- sqlfmt-corpus-separator --

SELECT 5::uint8 < 2::uint8

-- sqlfmt-corpus-separator --

SELECT 5::uint8 <= 2::uint8

-- sqlfmt-corpus-separator --

SELECT 5::uint8 > 2::uint8

-- sqlfmt-corpus-separator --

SELECT 5::uint8 >= 2::uint8

-- sqlfmt-corpus-separator --

SELECT 64::uint2 << 1::uint4

-- sqlfmt-corpus-separator --

SELECT 64::uint2 >> 1::uint4

-- sqlfmt-corpus-separator --

SELECT 64::uint4 << 1::uint4

-- sqlfmt-corpus-separator --

SELECT 64::uint4 >> 1::uint4

-- sqlfmt-corpus-separator --

SELECT 64::uint8 << 1::uint4

-- sqlfmt-corpus-separator --

SELECT 64::uint8 >> 1::uint4

-- sqlfmt-corpus-separator --

SELECT 65535.4::double::uint2

-- sqlfmt-corpus-separator --

SELECT 65535.4::numeric::uint2

-- sqlfmt-corpus-separator --

SELECT 65535.5::double::uint2

-- sqlfmt-corpus-separator --

SELECT 65535.5::numeric::uint2

-- sqlfmt-corpus-separator --

SELECT 65535::uint2 * 2::uint2

-- sqlfmt-corpus-separator --

SELECT 65535::uint2 + 1::uint2

-- sqlfmt-corpus-separator --

SELECT 65536.0::double::uint2

-- sqlfmt-corpus-separator --

SELECT 65536.0::double::uint4

-- sqlfmt-corpus-separator --

SELECT 65536.0::double::uint8

-- sqlfmt-corpus-separator --

SELECT 65536.0::numeric::uint2

-- sqlfmt-corpus-separator --

SELECT 65536.0::numeric::uint4

-- sqlfmt-corpus-separator --

SELECT 65536.0::numeric::uint8

-- sqlfmt-corpus-separator --

SELECT 65536::int4::uint2

-- sqlfmt-corpus-separator --

SELECT 65536::int4::uint4

-- sqlfmt-corpus-separator --

SELECT 65536::int4::uint8

-- sqlfmt-corpus-separator --

SELECT 65536::int8::uint2

-- sqlfmt-corpus-separator --

SELECT 65536::int8::uint4

-- sqlfmt-corpus-separator --

SELECT 65536::int8::uint8

-- sqlfmt-corpus-separator --

SELECT 65536::uint2

-- sqlfmt-corpus-separator --

SELECT 65536::uint4

-- sqlfmt-corpus-separator --

SELECT 65536::uint4::uint2

-- sqlfmt-corpus-separator --

SELECT 65536::uint8

-- sqlfmt-corpus-separator --

SELECT 65536::uint8::uint2

-- sqlfmt-corpus-separator --

SELECT 66::uint2 % 0::uint2

-- sqlfmt-corpus-separator --

SELECT 66::uint4 % 0::uint4

-- sqlfmt-corpus-separator --

SELECT 66::uint8 % 0::uint8

-- sqlfmt-corpus-separator --

SELECT 6789::uint4::double

-- sqlfmt-corpus-separator --

SELECT 6789::uint4::int4

-- sqlfmt-corpus-separator --

SELECT 6789::uint4::int8

-- sqlfmt-corpus-separator --

SELECT 6789::uint4::numeric

-- sqlfmt-corpus-separator --

SELECT 6789::uint4::text

-- sqlfmt-corpus-separator --

SELECT 6789::uint4::uint2

-- sqlfmt-corpus-separator --

SELECT 6789::uint4::uint8

-- sqlfmt-corpus-separator --

SELECT 7133080445639580613::INT8 + '1977-11-03'::DATE

-- sqlfmt-corpus-separator --

SELECT 750 = 'array_in'::regproc

-- sqlfmt-corpus-separator --

SELECT 790123449679012344967901234496790123392 + 790123449679012344967901234496790123392::numeric

-- sqlfmt-corpus-separator --

SELECT 7::int8::numeric(39,3), -7::int8::numeric(39,3), 0::int8::numeric(39,3)

-- sqlfmt-corpus-separator --

SELECT 7::int8::numeric, -7::int8::numeric, 0::int8::numeric

-- sqlfmt-corpus-separator --

SELECT 7::numeric(39,3), -7::numeric(39,3), 0::numeric(39,3)

-- sqlfmt-corpus-separator --

SELECT 7::numeric, -7::numeric, 0::numeric

-- sqlfmt-corpus-separator --

SELECT 7::numeric::int8, 7.3::int8, 7.5::int8

-- sqlfmt-corpus-separator --

SELECT 8210266815600000::mz_timestamp::timestamptz

-- sqlfmt-corpus-separator --

SELECT 8210266898400000::mz_timestamp::timestamp

-- sqlfmt-corpus-separator --

SELECT 8210266898400000::mz_timestamp::timestamptz

-- sqlfmt-corpus-separator --

SELECT 9223372036854775807::numeric, -9223372036854775808::numeric

-- sqlfmt-corpus-separator --

SELECT 9223372036854775808::uint8

-- sqlfmt-corpus-separator --

SELECT 9223372036854775808::uint8::int8

-- sqlfmt-corpus-separator --

SELECT 98765432109876543210987654321098765432.109::numeric(39,3)

-- sqlfmt-corpus-separator --

SELECT 999999999999999999999999999999999999.123 + 1::numeric

-- sqlfmt-corpus-separator --

SELECT 999999999999999999999999999999999999999 + 1::numeric

-- sqlfmt-corpus-separator --

SELECT 99::int2::uint8

-- sqlfmt-corpus-separator --

SELECT 99::int4::uint8

-- sqlfmt-corpus-separator --

SELECT 99::int8::uint8

-- sqlfmt-corpus-separator --

SELECT 9::numeric(39,5) = 9::numeric(39,10);

-- sqlfmt-corpus-separator --

SELECT 9::numeric(39,5) = 9::numeric;

-- sqlfmt-corpus-separator --

SELECT 9E+38::float4

-- sqlfmt-corpus-separator --

SELECT 9E-39::float4;

-- sqlfmt-corpus-separator --

SELECT 9E-39::float8, 9E+38::float8;

-- sqlfmt-corpus-separator --

SELECT CAST('2020-01-01' AS date), CAST('2020-01-01'::timestamp as date), CAST('2020-01-01'::timestamptz as date)

-- sqlfmt-corpus-separator --

SELECT CAST('{"a":"b"}'::JSONB AS STRING)

-- sqlfmt-corpus-separator --

SELECT CAST(a as text[]) FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT COUNT(*) FROM mz_cluster_replicas WHERE cluster_id = (SELECT id FROM mz_clusters WHERE name = 'mz_system') AND id LIKE 's%';

-- sqlfmt-corpus-separator --

SELECT COUNT(*) FROM mz_cluster_replicas WHERE cluster_id = (SELECT id FROM mz_clusters WHERE name = 'mz_system') AND id LIKE 'u%';

-- sqlfmt-corpus-separator --

SELECT COUNT(name) FROM mz_indexes WHERE cluster_id <> 'u1' AND cluster_id NOT LIKE 's%';

-- sqlfmt-corpus-separator --

SELECT DATE '-2000-01 1:2:3';

-- sqlfmt-corpus-separator --

SELECT DATE '-2000-01-01';

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-01' + INTERVAL '4 minutes'

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-01' - INTERVAL '4 minutes'

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-01' = TIMESTAMP '1999-01-01'

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-02' < TIMESTAMP '1999-01-01'

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-02' < TIMESTAMPTZ '1999-01-01'

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-02' <= TIMESTAMP '1999-01-01'

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-02' <= TIMESTAMP '1999-01-02'

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-02' <= TIMESTAMPTZ '1999-01-01'

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-02' <= TIMESTAMPTZ '1999-01-02'

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-02' = TIMESTAMPTZ '1999-01-01'

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-02' > TIMESTAMP '1999-01-01'

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-02' > TIMESTAMPTZ '1999-01-01'

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-02' >= TIMESTAMP '1999-01-01'

-- sqlfmt-corpus-separator --

SELECT DATE '1999-01-02' >= TIMESTAMPTZ '1999-01-01'

-- sqlfmt-corpus-separator --

SELECT DATE '2000 01 01'

-- sqlfmt-corpus-separator --

SELECT DATE '2000 01-01'

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01 01'

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01'

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + INTERVAL '4 HR'

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + TIME '01:02:03'

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01', DATE '2000-12-31', DATE '1993-05-16'

-- sqlfmt-corpus-separator --

SELECT DATE '20000101'

-- sqlfmt-corpus-separator --

SELECT DATE '2001-01-01' > TIMESTAMPTZ '2000-01-01 00:00:00+4'

-- sqlfmt-corpus-separator --

SELECT DATE '2007-02-01   T  15:04:05+00'

-- sqlfmt-corpus-separator --

SELECT DATE '2007-02-01  T  T  15:04:05'

-- sqlfmt-corpus-separator --

SELECT DATE '2007-02-01  T '

-- sqlfmt-corpus-separator --

SELECT DATE '2007-02-01 T 15:04:05+00'

-- sqlfmt-corpus-separator --

SELECT DATE '2007-02-01T15:04:05+00'

-- sqlfmt-corpus-separator --

SELECT DATE '2007-02-01TT15:04:05'

-- sqlfmt-corpus-separator --

SELECT DATE '2007-02-01X15:04:05'

-- sqlfmt-corpus-separator --

SELECT DATE '2019-02-03' - DATE '2019-01-01';

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (1) x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (1,2,3) x, y, z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (2) x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a) a, b, c FROM abc ORDER BY a, b, c

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a) a, c FROM abc ORDER BY a, c DESC, b

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a, c) a, b FROM abc ORDER BY a, c, b

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (b) a FROM t GROUP BY a ORDER BY b

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (b) b FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (b, c, a) a FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (b, c, a) a, c, b FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (c) a FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (c, a) b, c, a FROM abc ORDER BY c, a, b DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (c, a, b) b FROM abc ORDER BY b

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (max(x)) min(y) FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (min(x)) max(y) FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (row_number() OVER ()) *
FROM t
ORDER BY row_number() OVER ()

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) min(x) FROM xyz GROUP BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) x FROM xyz ORDER BY x DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) x, y FROM xyz WHERE x = 1 ORDER BY x, y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) x, y, z FROM xyz ORDER BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) y, z, x FROM xyz ORDER BY x ASC, z DESC, y DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, y) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, y) y, x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, y, z) x, y, z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y) x, y, z FROM xyz ORDER BY x, y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x) x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x, z) x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, z) x, y, z FROM xyz ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (z, y, x) z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(1 + lag(a, 1, 0) OVER (ORDER BY a)) *
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a), a ASC;

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(1 + lag(a, 1, 0) OVER (ORDER BY a)) *
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(1 + lag(a, 1, 0) OVER (ORDER BY a)) *
FROM foo
ORDER BY lag(a, 1, 0) OVER (ORDER BY a), a DESC;

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(1 + lag(a, 1, 0) OVER (ORDER BY a)) lead(a) OVER (ORDER BY b) AS o, a, b
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a), o DESC;

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(max(x)) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(max(x), z) min(y) FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(min(a), max(b), min(c)) max(c) FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(min(x)) min(x) FROM xyz GROUP BY y HAVING min(x) = 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(pk1, pk2, x, y) x, y, z FROM xyz ORDER BY x, y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(x) x AS y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(y) min(x) FROM xyz GROUP BY y

-- sqlfmt-corpus-separator --

SELECT E'test line 1\ntest line 2' LIKE '%1%2%';

-- sqlfmt-corpus-separator --

SELECT E'{{1,2},\\{2,3}}'::text[];

-- sqlfmt-corpus-separator --

SELECT FALSE::text, TRUE::text

-- sqlfmt-corpus-separator --

SELECT INTERVAL '+1 year +2 days +3:4:5.6';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.01 months -9223372036854775808 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.1 centuries -2147483648 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.1 days -9223372036854775808 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.1 decades -2147483648 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.1 millennium -2147483648 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.1 months -2147483648 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.1 yrs -2147483648 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 -:.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 ::.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 century -2147483648 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 day 0.27 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 day' - INTERVAL '-2147483648 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 day' < INTERVAL '-9999999 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 decade -2147483648 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 hour -2 minutes -3.45 seconds'::time;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 hours' + INTERVAL '-2562047788 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 millennium -2147483648 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 month' < INTERVAL '-9999999 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 month' < INTERVAL '-999999999 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 months' - INTERVAL '-2147483648 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1-2 -3 -4:5:6.7' * 999

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1-2 -3 -4:5:6.7' + INTERVAL '1-2 3 4:5:6.7'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1-2 -3 -4:5:6.7';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1-2 -3 -4::.5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1-2 -3 4::.5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1-2 3 -4:5:6.7';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1.555555555 years 2.555555555 months -3.555555555 days 4.555555555 hours -5.555555555 minutes 6.555555555 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-13 years -10 months +14 days +07:59:59.73';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-13 years -10 months -15 days -16:00:00.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-13-10 -15 -16::.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-13-10 15 -16::.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-153722867280.912930133 minutes';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-153722867281 minutes';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 centuries';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -0.1 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047786 hours -59 minutes -59.999999 seconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047787 hours -59 minutes -59.999999 seconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047788 hours -54 seconds' - INTERVAL '1'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047788 hours -54.775808 seconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047788 hours -59 min -60 sec'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047788 hours -60 min'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047789 hours'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 decades';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 millennium';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 months -0.1 centuries';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 months -0.1 decades';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 months -0.1 millennium';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 months -0.1 yrs';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 months -2147483648 days -9223372036854775808 us'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 years -1 century';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 years -1 decade';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 years -1 millennium';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483649 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483649 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483649 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2562047788.01521550222 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2562047788.0152155023 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2562047789 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-6.7 seconds 5 minutes -3 days 4 hours -1 year 2 month';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-6.7 seconds 5.6 minutes -3.4 days 4.5 hours -1.2 year 2.3 month';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-86400000001 us'::time;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854.775808 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775.808 milliseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775808 microseconds -0.01 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775808 microseconds -0.1 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775808 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775808 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775808 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775809 microsecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854777 millisecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036855 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-::1.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-:::::1.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '.001 second';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '.33333 minute .1 second';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0 foo';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0 year 0 month 0 day 0 hour 0 minute 0.0 second';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0-0 0 0:0:0.0';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.00000001 min 0.0006 millisecond 3.5 microsecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.01 months 9223372036854775807 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 2562047788:0:54.775807';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 centuries 2147483647 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 days 9223372036854775807 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 decades 2147483647 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 millennium 2147483647 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 months 2147483647 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 yrs 2147483647 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.4 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.5 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.6 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.999999999 months 0.999999999 days 0.999999999 hours 0.999999999 minutes 0.999999999 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:00:01.00000009';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:00:01.0000004';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:00:01.0000009';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:02:03minute hour day year';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:02:03minute';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 0:.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 2:';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 MIN'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 MINS'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 SEC'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 SECS'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 century 2147483647 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 day -0.27 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 day'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 day' > INTERVAL '9999999 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 decade 2147483647 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 hour 2 minutes 3.45 seconds'::time;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 millennium 2147483647 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 millennium'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 millenniums 2 centuries 3 decades 4 years'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 milliseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 month' > INTERVAL '9999999 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 month' > INTERVAL '999999999 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 nanosecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 ns';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 second 42 milliseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 year 2 month 3 day 4 hour 5 minute 6.7 second';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 year 2 years'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 years 2 months 3 days 4 hours 5 minutes 6.7 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1+2:3.4';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1- 2 3:';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' + - INTERVAL '7-6 5 4:3:2.1';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' + INTERVAL '-1-2 -3 -4:5:6.7'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' + INTERVAL '-7-6 -5 -4:3:2.1';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' + INTERVAL '1-2 3 4:5:6.7';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' - INTERVAL '-7-6 -5 -4:3:2.1';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' - INTERVAL '1-2 3 4:5:6.7'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' - INTERVAL '7-6 5 4:3:2.1';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4::.5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 year'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3-4'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3:4 5 day';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3:4 5 second';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3:4 5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3:4';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 5 second 3:4';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.0 second 42 milliseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.4 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5 second 42 milliseconds 43 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5 second 42 milliseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5 second 43 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5555 month 2 3:4:5.6';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5555555 day';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5555555 minute';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5555555 month';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.999999999999999999 days'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.999999999999999999days'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '10 years' *  9999999999.999999999;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '10 years' / 0.000000000000000001;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '10.333 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '10.333' years;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '100-11 366 250:59:61';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '100-11 366 250:61';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '100-13';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1002 milliseconds 1 second'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1002 milliseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '106751991167300 days .1 month';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '106751991167300.9 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '106751991167301 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '153722867280.912930117 minutes';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '153722867281 minutes';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:3.4 5-6';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:3.4.5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1x2:3.4';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1y 2.3mon 4.5d';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1y 2mon 3d 4h 5m 6.7s';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1year 2months 3.4days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2 YR 5 DAYS'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2 YRS 5 DAYS'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2 century'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 centuries';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 days 0.1 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 days 2562047787 hours 59 minutes 59.999999 seconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 days 2562047788 hours 54 seconds' + INTERVAL '1'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 days 2562047788 hours 54.775807 seconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 days 2562047789 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 decades';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 millennium';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 months 0.1 centuries';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 months 0.1 decades';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 months 0.1 millennium';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 months 0.1 yrs';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 months 2147483647 days 9223372036854775807 us'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 years 1 century';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 years 1 decade';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 years 1 millennium';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483648 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483648 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483648 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2562047788.01521550194 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2562047788.015215502 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2562047789 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '27 second 24 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '27.0 second 24 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '27.0 second 46 milliseconds 24 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '3 decade'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '4 minutes' + DATE '1999-01-01'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '4 year'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5 day 3:4 1-2';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5000006 microseconds 1 second'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5000006 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '6 days'::time;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '6.7 seconds 5 minutes 3 days 4 hours 1 year 2 month';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '7 months'::time;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '768614336404564650.7 year';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '768614336404564651 year';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854.775807 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854771807 seconds 1.9 hour';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775.807 milliseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775707 seconds 1.9 minute';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775807 microseconds 0.01 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775807 microseconds 0.1 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775807 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775807 seconds 1 hour';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775807 seconds 1 minute';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775808 microsecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775808 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775808 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854777 millisecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036855 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL ':::1- ::2 ::::3:';

-- sqlfmt-corpus-separator --

SELECT INTERVAL ':::::1.27';

-- sqlfmt-corpus-separator --

SELECT MOD(13::uint2, 5::uint2)

-- sqlfmt-corpus-separator --

SELECT MOD(13::uint4, 5::uint4)

-- sqlfmt-corpus-separator --

SELECT MOD(13::uint8, 5::uint8)

-- sqlfmt-corpus-separator --

SELECT MOD(66::uint2, 0::uint2)

-- sqlfmt-corpus-separator --

SELECT MOD(66::uint4, 0::uint4)

-- sqlfmt-corpus-separator --

SELECT MOD(66::uint8, 0::uint8)

-- sqlfmt-corpus-separator --

SELECT NOT (NULL::jsonb ? 'key');

-- sqlfmt-corpus-separator --

SELECT NULL -> 'hello'::text

-- sqlfmt-corpus-separator --

SELECT NULL AS "a", CAST(NULL AS int2vector) AS "b";

-- sqlfmt-corpus-separator --

SELECT NULL AS "a", CAST(NULL AS int4range) AS "b";

-- sqlfmt-corpus-separator --

SELECT NULL, NULL::t;

-- sqlfmt-corpus-separator --

SELECT NULL::JSON

-- sqlfmt-corpus-separator --

SELECT NULL::jsonb #> '{a}'

-- sqlfmt-corpus-separator --

SELECT NULL::jsonb #>> '{a}'

-- sqlfmt-corpus-separator --

SELECT NULL::jsonb - 'key'

-- sqlfmt-corpus-separator --

SELECT NULL::jsonb - 1

-- sqlfmt-corpus-separator --

SELECT NULL::jsonb -> 'key'

-- sqlfmt-corpus-separator --

SELECT NULL::jsonb ->> 'key'

-- sqlfmt-corpus-separator --

SELECT NULL::jsonb <@ '{}'

-- sqlfmt-corpus-separator --

SELECT NULL::jsonb ? 'key'

-- sqlfmt-corpus-separator --

SELECT NULL::jsonb @> '{"a":1}'

-- sqlfmt-corpus-separator --

SELECT NULL::jsonb || '{}'::jsonb

-- sqlfmt-corpus-separator --

SELECT NULL::regclass::text

-- sqlfmt-corpus-separator --

SELECT NULL::regproc::text

-- sqlfmt-corpus-separator --

SELECT NULL::regtype::text

-- sqlfmt-corpus-separator --

SELECT TIME '01:02:03' + INTERVAL '04:05:06'

-- sqlfmt-corpus-separator --

SELECT TIME '01:02:03' - INTERVAL '-04:05:06'

-- sqlfmt-corpus-separator --

SELECT TIME '01:02:03' - INTERVAL '04:05:06'

-- sqlfmt-corpus-separator --

SELECT TIME '01:02:03' - TIME '04:05:06'

-- sqlfmt-corpus-separator --

SELECT TIME '04:05:06' + INTERVAL '-01:02:03'

-- sqlfmt-corpus-separator --

SELECT TIME '04:05:06' - INTERVAL '01:02:03'

-- sqlfmt-corpus-separator --

SELECT TIME '04:05:06' - TIME '01:02:03'

-- sqlfmt-corpus-separator --

SELECT TIME '12:00:00';

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '-2000-01 1:2:3';

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '-2000-01-01 1:2:3';

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2000 01 01 01:02:03'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2000 01-01 01:02:03'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2000-01 01 01:02:03'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2000-01-01 00:00:00' > DATE '2000-01-01'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2000-01-01 00:00:00' > TIMESTAMPTZ '2000-01-01 01:00:00+04'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2000-01-01 01:02:03'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2000-05-05 10:00:00'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2000-05-05 10:00:00' FROM a

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '20010101 01:02:03';

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2007-02-01T15:04:05'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00+01' < TIMESTAMPTZ '2000-01-01 00:00:00-04'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00+01' <= TIMESTAMPTZ '2000-01-01 00:00:00-04'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00+01' > TIMESTAMPTZ '2000-01-01 00:00:00-04'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00+01' >= TIMESTAMPTZ '2000-01-01 00:00:00-04'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00+4' > DATE '2000-01-01'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00+4' > TIMESTAMP '2000-01-01 01:00:00'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-04' + TIMESTAMP '1999-01-01 00:00:00'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-04' + TIMESTAMPTZ '1999-01-01 00:00:00z'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 02:00:00+01' != TIMESTAMPTZ '2000-01-01 01:00:00z'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 02:00:00+01' <= TIMESTAMPTZ '2000-01-01 01:00:00z'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 02:00:00+01' = TIMESTAMPTZ '2000-01-01 01:00:00z'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 02:00:00+01' >= TIMESTAMPTZ '2000-01-01 01:00:00z'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2007-02-01 00:00:00+5:30:16';

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2007-02-01T15:04:05+00'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '20070201 T 15:04:05+00';

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '20070201T15:04:05+00';

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2020-01-01 00:00:00+16:60'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2020-03-08 02:59:59 America/New_York'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2020-03-08 03:00:00 America/New_York'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2020-11-01 00:59:59 America/New_York'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2020-11-01 01:00:00 America/New_York'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2020-12-21 18:53:49 America/New_York'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2020-12-21 18:53:49 PST'

-- sqlfmt-corpus-separator --

SELECT a FROM foo
ORDER BY lag(a) OVER (ORDER BY -a NULLS FIRST) DESC NULLS LAST;

-- sqlfmt-corpus-separator --

SELECT a FROM foo
ORDER BY lag(a) OVER (ORDER BY a) NULLS LAST;

-- sqlfmt-corpus-separator --

SELECT a FROM t WHERE a != timestamp without time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT a FROM t WHERE a < timestamp without time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT a FROM t WHERE a <= timestamp without time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT a FROM t WHERE a = timestamp without time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT a FROM t WHERE a > timestamp without time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT a FROM t WHERE a >= timestamp without time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT a FROM tz WHERE b = c::timestamp

-- sqlfmt-corpus-separator --

SELECT a FROM tz WHERE c = d::timestamp

-- sqlfmt-corpus-separator --

SELECT a, 2*a as d
FROM foo
ORDER BY lag(d) OVER (ORDER BY d);

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b), array_agg(sha256(b::BYTEA)) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY a) + lag(a) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY a) + lead(a) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY a), lag(lag(a) OVER (ORDER BY a)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY lag(a) OVER (ORDER BY a))
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY lag(a) OVER (ORDER BY a)), lag(a) OVER (ORDER BY a)
FROM foo
ORDER BY lag(a) OVER (ORDER BY a);

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (PARTITION BY lag(length(b)) OVER (ORDER BY a) ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (PARTITION BY lag(length(b)) OVER (ORDER BY a) ORDER BY a), lag(length(b)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(lag(a) OVER (ORDER BY a)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(lag(a) OVER (ORDER BY a)) OVER (ORDER BY a), lag(a) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(lag(a) OVER (PARTITION BY length(b) ORDER BY a)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lead(lag(a) OVER (PARTITION BY lag(length(b)) OVER (ORDER BY a) ORDER BY a), 1, -5) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, row_number() OVER (PARTITION BY lag(length(b)) OVER (ORDER BY a) ORDER BY a), lag(length(b)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, dense_rank() OVER (ORDER BY a), array_agg(b) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT a, lag(a) OVER (ORDER BY a) as d
FROM foo
ORDER BY -d;

-- sqlfmt-corpus-separator --

SELECT a, lag(a) OVER (ORDER BY a) as d
FROM foo
ORDER BY d;

-- sqlfmt-corpus-separator --

SELECT a::date[] FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT a::regproc FROM text_to_regproc ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a::regtype FROM text_to_regtype ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a::text from t

-- sqlfmt-corpus-separator --

SELECT abs('NaN'::numeric);

-- sqlfmt-corpus-separator --

SELECT abs(-1::numeric);

-- sqlfmt-corpus-separator --

SELECT abs(1::numeric - 1e38);

-- sqlfmt-corpus-separator --

SELECT acos('-inf'::double)

-- sqlfmt-corpus-separator --

SELECT acos('NaN'::double)

-- sqlfmt-corpus-separator --

SELECT acos('inf'::double)

-- sqlfmt-corpus-separator --

SELECT acos(0::double)

-- sqlfmt-corpus-separator --

SELECT acos(1::double)

-- sqlfmt-corpus-separator --

SELECT acosh('-inf'::double)

-- sqlfmt-corpus-separator --

SELECT acosh('NaN'::double)

-- sqlfmt-corpus-separator --

SELECT acosh('inf'::double)

-- sqlfmt-corpus-separator --

SELECT acosh(0::double)

-- sqlfmt-corpus-separator --

SELECT acosh(1::double)

-- sqlfmt-corpus-separator --

SELECT age('0001-06-01 08:10:56.555'::timestamp, '9999-12-10 04:05:01.550'::timestamp);

-- sqlfmt-corpus-separator --

SELECT age('1957-06-13') - age(now(), '1957-06-13') = interval '0s'

-- sqlfmt-corpus-separator --

SELECT age('1970-01-01T00:00:00.123456789'::timestamp(6), '1970-01-01T00:00:00.123456789'::timestamp(3));

-- sqlfmt-corpus-separator --

SELECT age('1970-01-01T00:00:00.123456789'::timestamptz(3), '1970-01-01T00:00:00.123456789'::timestamptz(0));

-- sqlfmt-corpus-separator --

SELECT age('2017-12-10 04:05:01.555'::timestamp, '2017-12-10 04:05:01.550'::timestamp);

-- sqlfmt-corpus-separator --

SELECT age('2017-12-10'::timestamptz, '2017-12-01'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT age('2020-04-05'::date + '03:00'::time, '2020-04-05'::date + '02:00'::time) = '1 hour'::interval;

-- sqlfmt-corpus-separator --

SELECT array_agg(NULL::TEXT)

-- sqlfmt-corpus-separator --

SELECT array_agg(a::text) FROM t1

-- sqlfmt-corpus-separator --

SELECT array_cat('1 2'::int2vector, '{3}'::int2[])::text;

-- sqlfmt-corpus-separator --

SELECT array_cat('{1,2}'::int2[], '3'::int2vector)::text;

-- sqlfmt-corpus-separator --

SELECT array_length('1 2'::int2vector, 1);

-- sqlfmt-corpus-separator --

SELECT array_length('{1,2}'::int2[], 1);

-- sqlfmt-corpus-separator --

SELECT array_position(null::text[], 'abc')

-- sqlfmt-corpus-separator --

SELECT array_position(null::text[], 'abc', null)

-- sqlfmt-corpus-separator --

SELECT array_to_json('{"a","b","c"}'::STRING[])

-- sqlfmt-corpus-separator --

SELECT array_to_json('{1.0,2.0,3.0}'::DECIMAL[])

-- sqlfmt-corpus-separator --

SELECT array_to_string('{}'::text[], '')

-- sqlfmt-corpus-separator --

SELECT array_to_string(NULL::text[], ','), array_to_string(NULL::text[], 'foo', 'zerp')

-- sqlfmt-corpus-separator --

SELECT array_upper(NULL::text[], 1)

-- sqlfmt-corpus-separator --

SELECT asin('-inf'::double)

-- sqlfmt-corpus-separator --

SELECT asin('NaN'::double)

-- sqlfmt-corpus-separator --

SELECT asin('inf'::double)

-- sqlfmt-corpus-separator --

SELECT asin(0::double)

-- sqlfmt-corpus-separator --

SELECT asin(1::double)

-- sqlfmt-corpus-separator --

SELECT asinh('-inf'::double)

-- sqlfmt-corpus-separator --

SELECT asinh('NaN'::double)

-- sqlfmt-corpus-separator --

SELECT asinh('inf'::double)

-- sqlfmt-corpus-separator --

SELECT asinh(0::double)

-- sqlfmt-corpus-separator --

SELECT asinh(1::double)

-- sqlfmt-corpus-separator --

SELECT atan('-inf'::double)

-- sqlfmt-corpus-separator --

SELECT atan('NaN'::double)

-- sqlfmt-corpus-separator --

SELECT atan('inf'::double)

-- sqlfmt-corpus-separator --

SELECT atan(0::double)

-- sqlfmt-corpus-separator --

SELECT atan(1::double)

-- sqlfmt-corpus-separator --

SELECT atanh('-inf'::double)

-- sqlfmt-corpus-separator --

SELECT atanh('NaN'::double)

-- sqlfmt-corpus-separator --

SELECT atanh('inf'::double)

-- sqlfmt-corpus-separator --

SELECT atanh(0::double)

-- sqlfmt-corpus-separator --

SELECT atanh(1::double)

-- sqlfmt-corpus-separator --

SELECT b + interval '1m', interval '1m' + b, c + interval '1m', interval '1m' + c FROM tz WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b, b::date, c, c::date FROM u WHERE a = 123

-- sqlfmt-corpus-separator --

SELECT b, b::text FROM t

-- sqlfmt-corpus-separator --

SELECT b::text[] FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT bar FROM foo WHERE bar->'a' = '"b"'::JSON

-- sqlfmt-corpus-separator --

SELECT bit_count('\x00'::bytea);

-- sqlfmt-corpus-separator --

SELECT bit_count('\x0F'::bytea);

-- sqlfmt-corpus-separator --

SELECT bit_count('\x1234567890'::bytea);

-- sqlfmt-corpus-separator --

SELECT bit_count('\xF0FF'::bytea);

-- sqlfmt-corpus-separator --

SELECT bit_count('\xFF'::bytea);

-- sqlfmt-corpus-separator --

SELECT bit_length('DEADBEEF'::bytea)

-- sqlfmt-corpus-separator --

SELECT bit_length('DEADBEEF'::text);

-- sqlfmt-corpus-separator --

SELECT bit_length('Hello'), bit_length('世界'), bit_length(b'世界')

-- sqlfmt-corpus-separator --

SELECT bit_length('\xDEADBEEF'::bytea)

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c != TIMESTAMP '2009-01-01 09:09:09.9'

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c = TIMESTAMP '2009-01-01 09:09:09.9'

-- sqlfmt-corpus-separator --

SELECT cbrt(-8::double)::float4

-- sqlfmt-corpus-separator --

SELECT cbrt(1.23783::decimal(15,5))::float4

-- sqlfmt-corpus-separator --

SELECT cbrt(1.23783::double)::float4

-- sqlfmt-corpus-separator --

SELECT ceil(1.234), ceil(-1.234), ceil('NaN'::numeric)

-- sqlfmt-corpus-separator --

SELECT clock_timestamp() - statement_timestamp() < interval '10s'

-- sqlfmt-corpus-separator --

SELECT col_description('pg_class'::regclass::oid, 2),
       shobj_description('pg_class'::regclass::oid, 'pg_class')

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(DISTINCT employee, ',')
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL, NULL::BYTEA)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL, NULL::TEXT)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::BYTEA, ',')
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::BYTEA, NULL)
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::BYTEA, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::BYTEA, employee::BYTEA)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::TEXT, ',')
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::TEXT, NULL)
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::TEXT, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::TEXT, employee)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee)
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, '')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, ',')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, employee, employee)
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, lower(employee))
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTEA, NULL)
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTEA, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTEA, b'')
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTEA, b'')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(lower(employee), employee)
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT concat(3.32::decimal, 3)

-- sqlfmt-corpus-separator --

SELECT concat_ws(NULL::STRING, 'a', 'b')

-- sqlfmt-corpus-separator --

SELECT cos('-inf'::double)

-- sqlfmt-corpus-separator --

SELECT cos('NaN'::double)

-- sqlfmt-corpus-separator --

SELECT cos('inf'::double)

-- sqlfmt-corpus-separator --

SELECT cos(0::double)

-- sqlfmt-corpus-separator --

SELECT cos(1::double)

-- sqlfmt-corpus-separator --

SELECT cosh('-inf'::double)

-- sqlfmt-corpus-separator --

SELECT cosh('NaN'::double)

-- sqlfmt-corpus-separator --

SELECT cosh('inf'::double)

-- sqlfmt-corpus-separator --

SELECT cosh(0::double)

-- sqlfmt-corpus-separator --

SELECT cosh(1::double)

-- sqlfmt-corpus-separator --

SELECT cot('-inf'::double)

-- sqlfmt-corpus-separator --

SELECT cot('NaN'::double)

-- sqlfmt-corpus-separator --

SELECT cot('inf'::double)

-- sqlfmt-corpus-separator --

SELECT cot(-0::double)

-- sqlfmt-corpus-separator --

SELECT cot(0::double)

-- sqlfmt-corpus-separator --

SELECT cot(1.01::double)

-- sqlfmt-corpus-separator --

SELECT count(*) FROM md5_test WHERE md5(t) <> md5(t::bytea)

-- sqlfmt-corpus-separator --

SELECT count(*) FROM mz_materialized_views WHERE id LIKE 'u%'

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT (v)) FROM kv

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT a.*) FROM kv a, kv b

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT id) FROM mz_objects WHERE name LIKE 'id_pool_%'

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT k), count(DISTINCT v), count(DISTINCT (v)) FROM kv

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT w) FROM kv GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT count(w) OVER () FROM not_allowed_tests GROUP BY 1;

-- sqlfmt-corpus-separator --

SELECT crc32('\x666f6f626172'::bytea)

-- sqlfmt-corpus-separator --

SELECT current_schemas(NULL::bool)

-- sqlfmt-corpus-separator --

SELECT d FROM s ORDER BY d, d::TEXT

-- sqlfmt-corpus-separator --

SELECT d::timestamp FROM u WHERE a = 123

-- sqlfmt-corpus-separator --

SELECT database_id, name FROM mz_schemas WHERE id LIKE 'u%';

-- sqlfmt-corpus-separator --

SELECT date('2020-01-01'), date('2020-01-01'::timestamp), date('2020-01-01'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT date_bin('-2 days'::interval, timestamp '1970-01-01 01:00:00' , timestamp '1970-01-01 00:00:00');

-- sqlfmt-corpus-separator --

SELECT date_bin('-2 days'::interval, timestamptz '1970-01-01 01:00:00+00' , timestamptz '1970-01-01 00:00:00+00');

-- sqlfmt-corpus-separator --

SELECT date_bin('0 days'::interval, timestamp '1970-01-01 01:00:00' , timestamp '1970-01-01 00:00:00');

-- sqlfmt-corpus-separator --

SELECT date_bin('0 days'::interval, timestamptz '1970-01-01 01:00:00+00' , timestamptz '1970-01-01 00:00:00+00');

-- sqlfmt-corpus-separator --

SELECT date_bin('1m', timestamp '2262-04-11 23:47:17');

-- sqlfmt-corpus-separator --

SELECT date_bin('1m', timestamptz '2262-04-11 23:47:17+00');

-- sqlfmt-corpus-separator --

SELECT date_bin('5 microseconds'::interval, '1970-01-01T00:00:00.123456789'::timestamp(6), '1970-01-01T00:00:00.123456789'::timestamp(3));

-- sqlfmt-corpus-separator --

SELECT date_bin('5 milliseconds'::interval, '1970-01-01T00:00:00.123456789'::timestamptz(6), '1970-01-01T00:00:00.123456789'::timestamptz(3));

-- sqlfmt-corpus-separator --

SELECT date_bin('5 min'::interval, timestamp '2020-02-01 01:01:01', timestamp '2020-02-01 00:02:30');

-- sqlfmt-corpus-separator --

SELECT date_bin('5 min'::interval, timestamptz '2020-02-01 01:01:01+00', timestamptz '2020-02-01 00:02:30+00');

-- sqlfmt-corpus-separator --

SELECT date_bin('5 months'::interval, timestamp '2020-02-01 01:01:01', timestamp '2001-01-01');

-- sqlfmt-corpus-separator --

SELECT date_bin('5 months'::interval, timestamptz '2020-02-01 01:01:01+00', timestamptz '2001-01-01');

-- sqlfmt-corpus-separator --

SELECT date_bin('5 years'::interval,  timestamp '2020-02-01 01:01:01', timestamp '2001-01-01');

-- sqlfmt-corpus-separator --

SELECT date_bin('5 years'::interval,  timestamptz '2020-02-01 01:01:01+00', timestamptz '2001-01-01');

-- sqlfmt-corpus-separator --

SELECT date_bin('9223372037 s'::interval, timestamp '2020-02-01 01:01:01', timestamp '2020-02-01 00:02:30');

-- sqlfmt-corpus-separator --

SELECT date_bin('9223372037 s'::interval, timestamptz '2020-02-01 01:01:01+00', timestamptz '2020-02-01 00:02:30+00');

-- sqlfmt-corpus-separator --

SELECT date_part('EPOCH', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('MILLENNIUM', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('CENTURY', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('DECADE', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('YEAR', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('QUARTER', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('WEEK', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('MONTH', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('HOUR', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('DAY', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('DOW', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('DOY', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('ISODOW', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('MINUTE', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('SECOND', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('MS', TIMESTAMP '2019-11-26 15:56:46.241150'),
    date_part('US', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_part('HOUR', DATE '2000-12-31'),
    date_part('SECOND', DATE '2000-12-31'),
    date_part('MILLISECOND', DATE '2000-12-31'),
    date_part('MICROSECOND', DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT date_part('HOUR', TIME '11:12:42.666'),
    date_part('MINUTE', TIME '11:12:42.666'),
    date_part('SECOND', TIME '11:12:42.666'),
    date_part('MILLISECONDS', TIME '11:12:42.666'),
    date_part('MICROSECONDS', TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT date_part('MONTH', TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT date_trunc('bad', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('bad', TIMESTAMPTZ '1999-12-31 16:16:01+02:30')

-- sqlfmt-corpus-separator --

SELECT date_trunc('century', TIMESTAMP '2000-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('century', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('day', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('day', TIMESTAMPTZ '1999-12-31 16:16:01+02:30')

-- sqlfmt-corpus-separator --

SELECT date_trunc('day', time '12:01:02.345')

-- sqlfmt-corpus-separator --

SELECT date_trunc('days',  INTERVAL '1234 years 11 months 23 days 23:59:12.123456789') AS t;

-- sqlfmt-corpus-separator --

SELECT date_trunc('decade',  INTERVAL '1234 years 11 months 23 days 23:59:12.123456789') AS t;

-- sqlfmt-corpus-separator --

SELECT date_trunc('decade', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('hour', '2016-02-10 19:46:33.306157519-04'::timestamptz)::string

-- sqlfmt-corpus-separator --

SELECT date_trunc('hour', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('hour', time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT date_trunc('hours',  INTERVAL '1234 years 11 months 23 days 23:59:12.123456789') AS t;

-- sqlfmt-corpus-separator --

SELECT date_trunc('hours', '2016-02-10 19:46:33.306157519-04'::timestamptz)::string

-- sqlfmt-corpus-separator --

SELECT date_trunc('microsecond', time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT date_trunc('microseconds',  INTERVAL '1234 years 11 months 23 days 23:59:12.123456789') AS t;

-- sqlfmt-corpus-separator --

SELECT date_trunc('microseconds', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('millennium',  INTERVAL '1234 years 11 months 23 days 23:59:12.123456789') AS t;

-- sqlfmt-corpus-separator --

SELECT date_trunc('millennium', TIMESTAMP '2000-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('millennium', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('millisecond', time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT date_trunc('milliseconds',  INTERVAL '1234 years 11 months 23 days 23:59:12.123456789') AS t;

-- sqlfmt-corpus-separator --

SELECT date_trunc('milliseconds', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('minute', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('minute', TIMESTAMPTZ '1999-12-31 16:16:01+02:30')

-- sqlfmt-corpus-separator --

SELECT date_trunc('minute', time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT date_trunc('minutes',  INTERVAL '1234 years 11 months 23 days 23:59:12.123456789') AS t;

-- sqlfmt-corpus-separator --

SELECT date_trunc('month', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('months',  INTERVAL '1234 years 11 months 23 days 23:59:12.123456789') AS t;

-- sqlfmt-corpus-separator --

SELECT date_trunc('quarter', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('second', '-2562047788:00:54.775807'::INTERVAL) AS t;

-- sqlfmt-corpus-separator --

SELECT date_trunc('second', '2562047788:00:54.775807'::INTERVAL) AS t;

-- sqlfmt-corpus-separator --

SELECT date_trunc('second', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('second', time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT date_trunc('seconds',  INTERVAL '1234 years 11 months 23 days 23:59:12.123456789') AS t;

-- sqlfmt-corpus-separator --

SELECT date_trunc('week', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('week', TIMESTAMP '2020-08-02 00:00:00')

-- sqlfmt-corpus-separator --

SELECT date_trunc('week', timestamp '2004-02-29 15:44:17.71393') AS week_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc('weeks',  INTERVAL '1234 years 11 months 23 days 23:59:12.123456789') AS t;

-- sqlfmt-corpus-separator --

SELECT date_trunc('year', TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT date_trunc('years',  INTERVAL '1234 years 11 months 23 days 23:59:12.123456789') AS t;

-- sqlfmt-corpus-separator --

SELECT date_trunc(field, TIMESTAMP '2019-11-26 15:56:46.241150') FROM date_trunc_fields

-- sqlfmt-corpus-separator --

SELECT decode('123\000456', 'escape')::STRING

-- sqlfmt-corpus-separator --

SELECT decode('padded1=', 'base64')::STRING

-- sqlfmt-corpus-separator --

SELECT decode('padded==', 'base64')::STRING

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY dense_rank, x;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY dense_rank, x;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC, z), x, y, z
FROM t
ORDER BY y, x DESC, z;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY dense_rank, x;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY z DESC), x, y, z
FROM t
ORDER BY y, z DESC, x;

-- sqlfmt-corpus-separator --

SELECT digest('', 'md5')::text

-- sqlfmt-corpus-separator --

SELECT digest('', 'sha1')::text

-- sqlfmt-corpus-separator --

SELECT digest('', 'sha224')::text

-- sqlfmt-corpus-separator --

SELECT digest('', 'sha256')::text

-- sqlfmt-corpus-separator --

SELECT digest('', 'sha384')::text

-- sqlfmt-corpus-separator --

SELECT digest('', 'sha512')::text

-- sqlfmt-corpus-separator --

SELECT digest(''::bytea, 'md5')::text

-- sqlfmt-corpus-separator --

SELECT digest('12345678901234567890123456789012345678901234567890123456789012345678901234567890', 'md5')::text

-- sqlfmt-corpus-separator --

SELECT digest('12345678901234567890123456789012345678901234567890123456789012345678901234567890', 'sha1')::text

-- sqlfmt-corpus-separator --

SELECT digest('12345678901234567890123456789012345678901234567890123456789012345678901234567890', 'sha224')::text

-- sqlfmt-corpus-separator --

SELECT digest('12345678901234567890123456789012345678901234567890123456789012345678901234567890', 'sha256')::text

-- sqlfmt-corpus-separator --

SELECT digest('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789', 'md5')::text

-- sqlfmt-corpus-separator --

SELECT digest('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789', 'sha1')::text

-- sqlfmt-corpus-separator --

SELECT digest('a', 'md5')::text

-- sqlfmt-corpus-separator --

SELECT digest('a', 'sha1')::text

-- sqlfmt-corpus-separator --

SELECT digest('a', 'sha224')::text

-- sqlfmt-corpus-separator --

SELECT digest('a', 'sha256')::text

-- sqlfmt-corpus-separator --

SELECT digest('a', 'sha384')::text

-- sqlfmt-corpus-separator --

SELECT digest('a', 'sha512')::text

-- sqlfmt-corpus-separator --

SELECT digest('abc', 'md5')::text

-- sqlfmt-corpus-separator --

SELECT digest('abc', 'sha1')::text

-- sqlfmt-corpus-separator --

SELECT digest('abc', 'sha224')::text

-- sqlfmt-corpus-separator --

SELECT digest('abc', 'sha256')::text

-- sqlfmt-corpus-separator --

SELECT digest('abc', 'sha384')::text

-- sqlfmt-corpus-separator --

SELECT digest('abc', 'sha512')::text

-- sqlfmt-corpus-separator --

SELECT digest('abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq', 'sha224')::text

-- sqlfmt-corpus-separator --

SELECT digest('abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq', 'sha256')::text

-- sqlfmt-corpus-separator --

SELECT digest('abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq', 'sha384')::text

-- sqlfmt-corpus-separator --

SELECT digest('abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq', 'sha512')::text

-- sqlfmt-corpus-separator --

SELECT digest('abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu', 'sha384')::text

-- sqlfmt-corpus-separator --

SELECT digest('abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmnhijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu', 'sha512')::text

-- sqlfmt-corpus-separator --

SELECT digest('abcdefghijklmnopqrstuvwxyz', 'md5')::text

-- sqlfmt-corpus-separator --

SELECT digest('abcdefghijklmnopqrstuvwxyz', 'sha1')::text

-- sqlfmt-corpus-separator --

SELECT digest('abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz', 'sha384')::text

-- sqlfmt-corpus-separator --

SELECT digest('abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz', 'sha512')::text

-- sqlfmt-corpus-separator --

SELECT digest('message digest', 'md5')::text

-- sqlfmt-corpus-separator --

SELECT digest('message digest', 'sha1')::text

-- sqlfmt-corpus-separator --

SELECT div(1.0::decimal, 0.0::decimal)

-- sqlfmt-corpus-separator --

SELECT exp('.5'::numeric)

-- sqlfmt-corpus-separator --

SELECT exp('NaN'::numeric)

-- sqlfmt-corpus-separator --

SELECT exp(-1::numeric)

-- sqlfmt-corpus-separator --

SELECT exp(-50000::numeric)

-- sqlfmt-corpus-separator --

SELECT exp(1::numeric)

-- sqlfmt-corpus-separator --

SELECT exp(1e2000::decimal)

-- sqlfmt-corpus-separator --

SELECT exp(2::numeric)

-- sqlfmt-corpus-separator --

SELECT exp(50000::numeric)

-- sqlfmt-corpus-separator --

SELECT exp(ln(2::decimal(15, 5)))

-- sqlfmt-corpus-separator --

SELECT f, f::string FROM vals

-- sqlfmt-corpus-separator --

SELECT f.f1::text FROM float8_tbl f WHERE  f.f1 < '1004.3'

-- sqlfmt-corpus-separator --

SELECT f.f1::text FROM float8_tbl f WHERE  f.f1 <= '1004.3'

-- sqlfmt-corpus-separator --

SELECT f.f1::text FROM float8_tbl f WHERE '1004.3' > f.f1

-- sqlfmt-corpus-separator --

SELECT f.f1::text FROM float8_tbl f WHERE '1004.3' >= f.f1

-- sqlfmt-corpus-separator --

SELECT f.f1::text FROM float8_tbl f WHERE f.f1 <> '1004.3'

-- sqlfmt-corpus-separator --

SELECT f.f1::text FROM float8_tbl f WHERE f.f1 = '1004.3'

-- sqlfmt-corpus-separator --

SELECT f.f1::text, round(f.f1)::text AS round_f1 FROM float8_tbl f

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, -2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, 10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, -10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 1, f3) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, NULL, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, f1 - 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f3) OVER (PARTITION BY f2 ORDER BY f1)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, -2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, 10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, -10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 1, f3) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, NULL, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, f1 - 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, lag(0, f1 , 0) OVER (PARTITION BY f1 ORDER BY f1) FROM t3 GROUP BY f1 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, lead(0, f1 , 0) OVER (PARTITION BY f1 ORDER BY f1) FROM t4 GROUP BY f1 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1::text FROM float4_tbl

-- sqlfmt-corpus-separator --

SELECT f1::text FROM float4_tbl WHERE  f1 < '1004.3'

-- sqlfmt-corpus-separator --

SELECT f1::text FROM float4_tbl WHERE  f1 <= '1004.3'

-- sqlfmt-corpus-separator --

SELECT f1::text FROM float4_tbl WHERE '1004.3' > f1

-- sqlfmt-corpus-separator --

SELECT f1::text FROM float4_tbl WHERE '1004.3' >= f1

-- sqlfmt-corpus-separator --

SELECT f1::text FROM float4_tbl WHERE f1 <> '1004.3'

-- sqlfmt-corpus-separator --

SELECT f1::text FROM float4_tbl WHERE f1 = '1004.3'

-- sqlfmt-corpus-separator --

SELECT f1::text FROM float8_tbl

-- sqlfmt-corpus-separator --

SELECT floor(1.234), floor(-1.234), floor('NaN'::numeric)

-- sqlfmt-corpus-separator --

SELECT fnv32(NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT from_ip(b'')

-- sqlfmt-corpus-separator --

SELECT from_uuid(b'f00d')

-- sqlfmt-corpus-separator --

SELECT generate_series(DISTINCT 1, 1)

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('{1,2,3,4}'::TEXT[], 1) AS s;

-- sqlfmt-corpus-separator --

SELECT get_bit('\x1234567890'::bytea, 30);

-- sqlfmt-corpus-separator --

SELECT get_bit('\xF00a'::bytea, 13);

-- sqlfmt-corpus-separator --

SELECT get_bit('\xF00a'::bytea, 16);

-- sqlfmt-corpus-separator --

SELECT get_bit('\xF00a'::bytea, 5);

-- sqlfmt-corpus-separator --

SELECT get_byte('\x'::bytea, 0)

-- sqlfmt-corpus-separator --

SELECT get_byte('\x1234567890'::bytea, 4);

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test Using Larger Than Block-Size Key - Hash Key First',
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'md5'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test Using Larger Than Block-Size Key - Hash Key First',
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha1'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test Using Larger Than Block-Size Key - Hash Key First',
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha224'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test Using Larger Than Block-Size Key - Hash Key First',
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha256'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test Using Larger Than Block-Size Key - Hash Key First',
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha384'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test Using Larger Than Block-Size Key - Hash Key First',
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha512'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test Using Larger Than Block-Size Key and Larger Than One Block-Size Data aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha384'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test Using Larger Than Block-Size Key and Larger Than One Block-Size Data aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha512'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test Using Larger Than Block-Size Key and Larger Than One Block-Size Data',
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'md5'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test Using Larger Than Block-Size Key and Larger Than One Block-Size Data',
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha1'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test Using Larger Than Block-Size Key and Larger Than One Block-Size Data',
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha224'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test Using Larger Than Block-Size Key and Larger Than One Block-Size Data',
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha256'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test With Truncation',
  '\x0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c'::bytea,
  'md5'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test With Truncation',
  '\x0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c'::bytea,
  'sha1'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test With Truncation',
  '\x0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c'::bytea,
  'sha224'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test With Truncation',
  '\x0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c'::bytea,
  'sha256'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test With Truncation',
  '\x0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c'::bytea,
  'sha384'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  'Test With Truncation',
  '\x0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c'::bytea,
  'sha512'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  '\xcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd'::bytea,
  '\x0102030405060708090a0b0c0d0e0f10111213141516171819',
  'md5'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  '\xcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd'::bytea,
  '\x0102030405060708090a0b0c0d0e0f10111213141516171819',
  'sha1'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  '\xcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd'::bytea,
  '\x0102030405060708090a0b0c0d0e0f10111213141516171819',
  'sha224'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  '\xcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd'::bytea,
  '\x0102030405060708090a0b0c0d0e0f10111213141516171819',
  'sha256'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  '\xcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd'::bytea,
  '\x0102030405060708090a0b0c0d0e0f10111213141516171819',
  'sha384'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  '\xcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd'::bytea,
  '\x0102030405060708090a0b0c0d0e0f10111213141516171819',
  'sha512'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  '\xdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd'::bytea,
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'md5'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  '\xdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd'::bytea,
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha1'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  '\xdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd'::bytea,
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha224'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  '\xdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd'::bytea,
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha256'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  '\xdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd'::bytea,
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha384'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac(
  '\xdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd'::bytea,
  '\xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'::bytea,
  'sha512'
)::text

-- sqlfmt-corpus-separator --

SELECT hmac('Hi There', '\x0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b'::bytea, 'md5')::text

-- sqlfmt-corpus-separator --

SELECT hmac('Hi There', '\x0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b'::bytea, 'sha1')::text

-- sqlfmt-corpus-separator --

SELECT hmac('Hi There', '\x0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b'::bytea, 'sha224')::text

-- sqlfmt-corpus-separator --

SELECT hmac('Hi There', '\x0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b'::bytea, 'sha256')::text

-- sqlfmt-corpus-separator --

SELECT hmac('Hi There', '\x0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b'::bytea, 'sha384')::text

-- sqlfmt-corpus-separator --

SELECT hmac('Hi There', '\x0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b'::bytea, 'sha512')::text

-- sqlfmt-corpus-separator --

SELECT hmac('Jefe', 'what do ya want for nothing?', 'md5')::text

-- sqlfmt-corpus-separator --

SELECT hmac('Jefe', 'what do ya want for nothing?', 'sha1')::text

-- sqlfmt-corpus-separator --

SELECT hmac('Jefe', 'what do ya want for nothing?', 'sha224')::text

-- sqlfmt-corpus-separator --

SELECT hmac('Jefe', 'what do ya want for nothing?', 'sha256')::text

-- sqlfmt-corpus-separator --

SELECT hmac('Jefe', 'what do ya want for nothing?', 'sha384')::text

-- sqlfmt-corpus-separator --

SELECT hmac('Jefe', 'what do ya want for nothing?', 'sha512')::text

-- sqlfmt-corpus-separator --

SELECT id, cluster_id, object_type, created_at, dropped_at FROM mz_internal.mz_object_history WHERE id LIKE 'u%';

-- sqlfmt-corpus-separator --

SELECT id, name FROM mz_materialized_views
WHERE id LIKE 'u%'

-- sqlfmt-corpus-separator --

SELECT id, name FROM mz_tables WHERE id LIKE 'u%';

-- sqlfmt-corpus-separator --

SELECT id, name, inherit FROM mz_roles WHERE id LIKE 's%' OR id LIKE 'g%'

-- sqlfmt-corpus-separator --

SELECT id, name, managed, replication_factor, size FROM mz_clusters WHERE name LIKE 'foo'

-- sqlfmt-corpus-separator --

SELECT id, normalize(text) FROM test_normalize ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, schema_id, name, type, connection_id, size FROM mz_sources WHERE id LIKE 'u%'

-- sqlfmt-corpus-separator --

SELECT int8range(1, 1, '') OVER (PARTITION BY 1 ORDER BY 1);

-- sqlfmt-corpus-separator --

SELECT interval '-01:02:03.04'::time;

-- sqlfmt-corpus-separator --

SELECT interval '-3 days -2 hours'::time;

-- sqlfmt-corpus-separator --

SELECT interval '01:02:03.04'::time;

-- sqlfmt-corpus-separator --

SELECT interval '02!01!1~01:02:03';

-- sqlfmt-corpus-separator --

SELECT interval '02-01!1~01:02:03';

-- sqlfmt-corpus-separator --

SELECT interval '1! hour';

-- sqlfmt-corpus-separator --

SELECT interval '1-2 3 4:5:6.7'

-- sqlfmt-corpus-separator --

SELECT json_array_elements('[1,2,3]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_array_elements('[1,true,null,"text",-1.234,{"2":3,"4":"5"},[1,2,3]]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_array_elements('[]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_array_elements('{"1":2}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_array_elements_text('[1,2,3]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_array_elements_text('[1,true,null,"text",-1.234,{"2":3,"4":"5"},[1,2,3]]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_array_elements_text('{"1":2}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_build_array('\x0001'::BYTEA)

-- sqlfmt-corpus-separator --

SELECT json_build_object('a','0100110'::varbit)

-- sqlfmt-corpus-separator --

SELECT json_build_object('a',1,'b',1.2,'c',true,'d',null,'e','{"x":3,"y":[1,2,3]}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_build_object('{"a":1,"b":2}'::JSON,3)

-- sqlfmt-corpus-separator --

SELECT json_build_object(json_object_keys('{"x":3,"y":4}'::JSON),2)

-- sqlfmt-corpus-separator --

SELECT json_each('[1]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_each('null'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_each_text('[1]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_each_text('null'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_object('{NULL,a}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{a,1,b,2,3,NULL,"d e f","a b c"}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{a,b,"","d e f"}'::TEXT[],'{1,2,3,"a b c"}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{a,b,NULL,"d e f"}'::TEXT[],'{1,2,3,"a b c"}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{a,b,c,"d e f",g}'::TEXT[],'{1,2,3,"a b c"}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{a,b,c,"d e f"}'::TEXT[],'{1,2,3,"a b c",g}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{a,b,c,"d e f"}'::TEXT[],'{1,2,3,"a b c"}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{a,b,c}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{b,3,a,1,b,4,a,2}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{b,b,a,a}'::TEXT[],'{1,2,3,4}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{}'::TEXT[],'{}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object_keys('[1,2,3]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_object_keys('null'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_object_keys('{"1":2,"3":4}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_object_keys('{"\"1\"":2}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_object_keys('{"a":1,"1":2,"3":{"4":5,"6":7}}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_object_keys('{}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_set('{"a":1}','{a}'::STRING[],'2')

-- sqlfmt-corpus-separator --

SELECT json_typeof('"-123.4"'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_typeof('-123.4'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_typeof('[1, 2, [3]]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_typeof('false'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_typeof('null'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_typeof('true'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_typeof('{"1":{"2":3}}'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(a::text::jsonb) FROM t1

-- sqlfmt-corpus-separator --

SELECT jsonb_array_elements('[1,2,3]'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_array_elements('{"1":2}'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_array_elements_text('{"1":2}'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_array_length('4'::JSONB)

-- sqlfmt-corpus-separator --

SELECT jsonb_array_length('[1,2,3,{"f1":1,"f2":[5,6]},4]'::JSONB)

-- sqlfmt-corpus-separator --

SELECT jsonb_array_length('[]'::JSONB)

-- sqlfmt-corpus-separator --

SELECT jsonb_array_length('{"f1":1,"f2":[5,6]}'::JSONB)

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array('+Inf'::FLOAT8,'NaN'::FLOAT8)::STRING::JSONB

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array('\x0001'::BYTEA)

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(true,'val',1,0,1.3,2,date '2019-02-03' - date '2019-01-01',4)

-- sqlfmt-corpus-separator --

SELECT jsonb_each('[1]'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_each('null'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_each('{"3":4,"1":2}'::JSONB) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT jsonb_each_text('[1]'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_each_text('null'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('1','{a}'::STRING[],'10',true)

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('[0,1,2,3]','{3}'::STRING[],'10',true)

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('[0,1,2,{"a":["a","b","d"]},4]','{3,a,2}'::STRING[],'"c"')

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a":"foo"}','{a,0}'::STRING[],'"new_value"',false)

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a":"foo"}','{a}'::STRING[],'"new_value"',false)

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a":"foo"}','{b}'::STRING[],'"bar"')

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a":[0,1,2],"b":"hello","c":"world"}','{NULL,a,0}'::STRING[],'"new_val"')

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a":[0,1,2],"b":"hello","c":"world"}','{a,NULL,0}'::STRING[],'"new_val"')

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a":[0,1,2]}','{a,-1}'::STRING[],'"new_value"',true)

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a":[0,1,2]}','{a,1}'::STRING[],'"new_value"');

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a":[0,1,2]}','{a,1}'::STRING[],'"new_value"',true)

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{NULL,a}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{a,1,b,2,3,NULL,"d e f","a b c"}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{a,b,"","d e f"}'::TEXT[],'{1,2,3,"a b c"}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{a,b,NULL,"d e f"}'::TEXT[],'{1,2,3,"a b c"}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{a,b,c,"d e f",g}'::TEXT[],'{1,2,3,"a b c"}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{a,b,c,"d e f"}'::TEXT[],'{1,2,3,"a b c",g}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{a,b,c,"d e f"}'::TEXT[],'{1,2,3,"a b c"}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{a,b,c}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{b,3,a,1,b,4,a,2}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{b,b,a,a}'::TEXT[],'{1,2,3,4}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{}'::TEXT[],'{}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object_keys('{"1":2,"3":4}'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_set('[{"f1":1,"f2":null},2,null,3]','{0,f1}'::STRING[],'[2,3,4]',false)

-- sqlfmt-corpus-separator --

SELECT jsonb_set('[{"f1":1,"f2":null},2]','{0,f3}'::STRING[],'[2,3,4]')

-- sqlfmt-corpus-separator --

SELECT jsonb_set('{"a":1}','{b}'::STRING[],'2')

-- sqlfmt-corpus-separator --

SELECT jsonb_set('{"a":1}','{b}'::STRING[],'2',false)

-- sqlfmt-corpus-separator --

SELECT jsonb_set('{"a":1}','{b}'::STRING[],'2',true)

-- sqlfmt-corpus-separator --

SELECT jsonb_set('{"a":1}','{foo,null}'::STRING[],'2',true)

-- sqlfmt-corpus-separator --

SELECT jsonb_set('{"a":1}','{null,foo}'::STRING[],'2',true)

-- sqlfmt-corpus-separator --

SELECT jsonb_strip_nulls('"a string"'::JSONB)

-- sqlfmt-corpus-separator --

SELECT jsonb_strip_nulls('1'::JSONB)

-- sqlfmt-corpus-separator --

SELECT jsonb_strip_nulls('[1,2,null,3,4]'::JSONB)

-- sqlfmt-corpus-separator --

SELECT jsonb_strip_nulls('[1,{"a":1,"b":null,"c":2},3]'::JSONB)

-- sqlfmt-corpus-separator --

SELECT jsonb_strip_nulls('null'::JSONB)

-- sqlfmt-corpus-separator --

SELECT jsonb_strip_nulls('{"a":1,"b":null,"c":[2,null,3],"d":{"e":4,"f":null}}'::JSONB)

-- sqlfmt-corpus-separator --

SELECT jsonb_strip_nulls('{"a":{"b":null,"c":null},"d":{}}'::JSONB)

-- sqlfmt-corpus-separator --

SELECT jsonb_typeof('"-123.4"'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_typeof('-123'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_typeof('-123.4'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_typeof('[1, 2, [3]]'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_typeof('false'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_typeof('null'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_typeof('true'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_typeof('{"1":{"2":3}}'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_typeof(to_jsonb('NaN'::numeric))

-- sqlfmt-corpus-separator --

SELECT justify_days(interval '2147483647 months 30 days');

-- sqlfmt-corpus-separator --

SELECT justify_days(interval '35 days');

-- sqlfmt-corpus-separator --

SELECT justify_days(interval '6 months 36 days 5 hours 4 minutes 3 seconds');

-- sqlfmt-corpus-separator --

SELECT justify_hours(interval '2147483647 days 24 hrs');

-- sqlfmt-corpus-separator --

SELECT justify_hours(interval '27 hours');

-- sqlfmt-corpus-separator --

SELECT justify_hours(interval '6 months 3 days 52 hours 3 minutes 2 seconds');

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '-2147483648 days -24 hrs');

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '-2147483648 months -30 days 24 hrs');

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '-2147483648 months -30 days');

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '-2147483648 months 30 days -1440 hrs');

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '1 month -1 hour');

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '2147483647 days 24 hrs');

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '2147483647 months -30 days 1440 hrs');

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '2147483647 months 30 days -24 hrs');

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '2147483647 months 30 days');

-- sqlfmt-corpus-separator --

SELECT k FROM not_allowed_tests WHERE avg(k) OVER () > 1;

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v LIKE 'ABC%'

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v LIKE 'ABC%Z'

-- sqlfmt-corpus-separator --

SELECT kafka_murmur2('\x666f6f626172'::bytea)

-- sqlfmt-corpus-separator --

SELECT lag(a1.x) OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lead(a1.x) OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT left('💩abcde'::bytes, 2)

-- sqlfmt-corpus-separator --

SELECT length('DEADBEEF'::bytea)

-- sqlfmt-corpus-separator --

SELECT length('Hello, 世界'), length(b'Hello, 世界'),
       char_length('Hello, 世界'), char_length(b'Hello, 世界'),
       character_length('Hello, 世界'), character_length(b'Hello, 世界')

-- sqlfmt-corpus-separator --

SELECT length('\xDEADBEEF'::bytea)

-- sqlfmt-corpus-separator --

SELECT length('a\\b'::text::bytea)

-- sqlfmt-corpus-separator --

SELECT length('deadbeef'::text, 'utf-8')

-- sqlfmt-corpus-separator --

SELECT length('roach7'), length(b'roach77')

-- sqlfmt-corpus-separator --

SELECT length(b), sum(a), lag(sum(a)) OVER (ORDER BY length(b))
FROM foo
GROUP BY length(b)
ORDER BY length(b);

-- sqlfmt-corpus-separator --

SELECT length(b), sum(a), lag(sum(a)) OVER (ORDER BY sum(a))
FROM foo
GROUP BY length(b)
ORDER BY sum(a), length(b);

-- sqlfmt-corpus-separator --

SELECT length(gen_random_uuid()::BYTES), gen_random_uuid() = gen_random_uuid()

-- sqlfmt-corpus-separator --

SELECT length(s), count(DISTINCT k), count(DISTINCT v), count(DISTINCT (v)) FROM kv GROUP BY length(s)

-- sqlfmt-corpus-separator --

SELECT length(x), encode(x::bytes, 'escape') from s

-- sqlfmt-corpus-separator --

SELECT list_agg(1)::text

-- sqlfmt-corpus-separator --

SELECT list_agg(a)::text FROM t1

-- sqlfmt-corpus-separator --

SELECT list_agg(a::text)::text FROM t1

-- sqlfmt-corpus-separator --

SELECT list_append(NULL, NULL)::text

-- sqlfmt-corpus-separator --

SELECT ln(-100.000::decimal)

-- sqlfmt-corpus-separator --

SELECT ln(0::decimal)

-- sqlfmt-corpus-separator --

SELECT ln(0::numeric)

-- sqlfmt-corpus-separator --

SELECT ln(13.0000::decimal(15, 5))

-- sqlfmt-corpus-separator --

SELECT ln(2.0), ln(2.5), ln(5000::numeric)

-- sqlfmt-corpus-separator --

SELECT ln(7.682705743584112e-48::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT ln(exp(2::numeric))

-- sqlfmt-corpus-separator --

SELECT log(-100.000::decimal)

-- sqlfmt-corpus-separator --

SELECT log(-1::numeric, 2::numeric)

-- sqlfmt-corpus-separator --

SELECT log(0::decimal)

-- sqlfmt-corpus-separator --

SELECT log(0::numeric)

-- sqlfmt-corpus-separator --

SELECT log(0::numeric, 2::numeric)

-- sqlfmt-corpus-separator --

SELECT log(10.0), log(100.000), log(5000::numeric)

-- sqlfmt-corpus-separator --

SELECT log(10.0::decimal(15, 5))

-- sqlfmt-corpus-separator --

SELECT log(128, -1::numeric)

-- sqlfmt-corpus-separator --

SELECT log(128, 0::numeric)

-- sqlfmt-corpus-separator --

SELECT log(128, 2::numeric)

-- sqlfmt-corpus-separator --

SELECT log(2::numeric, 128)

-- sqlfmt-corpus-separator --

SELECT log(2::numeric, 64)

-- sqlfmt-corpus-separator --

SELECT log(4::numeric, 4096);

-- sqlfmt-corpus-separator --

SELECT log(6::numeric, 1679616);

-- sqlfmt-corpus-separator --

SELECT log(6::numeric, 279936);

-- sqlfmt-corpus-separator --

SELECT log(8::numeric, 134217728);

-- sqlfmt-corpus-separator --

SELECT log(8::numeric, 16777216);

-- sqlfmt-corpus-separator --

SELECT log10(+0.0::double)

-- sqlfmt-corpus-separator --

SELECT log10(-1.0::double)

-- sqlfmt-corpus-separator --

SELECT log10(0.0::double)

-- sqlfmt-corpus-separator --

SELECT log10(10.0::double)

-- sqlfmt-corpus-separator --

SELECT log10(10::decimal(15, 5))

-- sqlfmt-corpus-separator --

SELECT lower('1ms'::interval)

-- sqlfmt-corpus-separator --

SELECT makeaclitem((SELECT oid FROM mz_roles WHERE name = 'materialize'), (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'CREATE', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem((SELECT oid FROM mz_roles WHERE name = 'materialize'), (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'CREATE, USAGE', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem((SELECT oid FROM mz_roles WHERE name = 'materialize'), 87398, 'CREATE', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem(0, (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'INSERT, SELECT', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem(0, (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'SELECT', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem(0, 2, 'CREATE', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem(0, 2, 'CREATE, USAGE', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem(1, 1, 'asdfa ljefioj', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem(1, 2, 'CREATE', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem(1, 2, 'CREATE', true)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem(1, 2, 'CREATE, USAGE', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem(3251, 345, 'CREATE', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem(99991, (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'CREATE', false)::text

-- sqlfmt-corpus-separator --

SELECT map_agg('one', 2)::TEXT

-- sqlfmt-corpus-separator --

SELECT map_agg(a::TEXT, a)::TEXT FROM t1

-- sqlfmt-corpus-separator --

SELECT map_agg(null, 1)::TEXT

-- sqlfmt-corpus-separator --

SELECT map_agg(null, null)::TEXT

-- sqlfmt-corpus-separator --

SELECT map_build(1)::TEXT;

-- sqlfmt-corpus-separator --

SELECT map_build(NULL)::TEXT;

-- sqlfmt-corpus-separator --

SELECT max(a)::text FROM char_col

-- sqlfmt-corpus-separator --

SELECT md5(NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT md5(NULL::STRING, NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT mod(5::decimal, 0::decimal)

-- sqlfmt-corpus-separator --

SELECT mz_internal.make_mz_aclitem('p', 'u2', 'CREATE, USAGE')::aclitem = makeaclitem(0, (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'CREATE, USAGE', false)

-- sqlfmt-corpus-separator --

SELECT mz_internal.make_mz_aclitem('p', 'u2', 'INSERT, SELECT')::text

-- sqlfmt-corpus-separator --

SELECT mz_internal.make_mz_aclitem('p', 'u2', 'SELECT')::text

-- sqlfmt-corpus-separator --

SELECT mz_internal.make_mz_aclitem('u1', 'u2', 'CREATE')::text

-- sqlfmt-corpus-separator --

SELECT mz_internal.make_mz_aclitem('u1', 'u2', 'CREATE, USAGE')::aclitem = makeaclitem((SELECT oid FROM mz_roles WHERE name = 'materialize'), (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'CREATE, USAGE', false)

-- sqlfmt-corpus-separator --

SELECT mz_internal.make_mz_aclitem('u1', 'u2', 'CREATE, USAGE')::text

-- sqlfmt-corpus-separator --

SELECT mz_internal.make_mz_aclitem('u1', 'u87398', 'CREATE')::aclitem::text

-- sqlfmt-corpus-separator --

SELECT mz_internal.make_mz_aclitem('u1', 'u87398', 'CREATE')::text

-- sqlfmt-corpus-separator --

SELECT mz_internal.make_mz_aclitem('u3251', 's345', 'CREATE')::aclitem::text

-- sqlfmt-corpus-separator --

SELECT mz_internal.make_mz_aclitem('u3251', 's345', 'CREATE')::text

-- sqlfmt-corpus-separator --

SELECT mz_internal.make_mz_aclitem('u99991', 'u2', 'CREATE')::aclitem::text

-- sqlfmt-corpus-separator --

SELECT mz_internal.make_mz_aclitem('u99991', 'u2', 'CREATE')::text

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_normalize_object_name('"Dbz"."SchemaX"."TableY"')::text;

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_normalize_object_name('"Dbz"."SchemaX"."TableY".Cola')::text;

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_normalize_object_name('"SchemaX"."TableY"')::text;

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_normalize_object_name('Dbz.Schemax.Tabley')::text;

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_normalize_object_name('Dbz.Schemax.Tabley.Cola')::text;

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_normalize_object_name('Schemax.Tabley')::text;

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_normalize_schema_name('"Dbz"."SchemaX"')::text;

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_normalize_schema_name('"Dbz"."SchemaX"."TableY"')::text;

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_normalize_schema_name('"SchemaX"')::text;

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_normalize_schema_name('Dbz.Schemax')::text;

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_normalize_schema_name('Dbz.Schemax.Tabley')::text;

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_normalize_schema_name('Schemax')::text;

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_type_name(18::oid)

-- sqlfmt-corpus-separator --

SELECT name FROM mz_indexes WHERE name LIKE 'enemy%';

-- sqlfmt-corpus-separator --

SELECT name FROM mz_indexes WHERE name NOT LIKE 'mz_%' AND name NOT LIKE 'pg_%';

-- sqlfmt-corpus-separator --

SELECT name, cs.type, cs.refresh_hydration_time_estimate
FROM mz_internal.mz_cluster_schedules cs, mz_catalog.mz_clusters c
WHERE c.id = cs.cluster_id
AND name LIKE 'c_schedule_%'
ORDER BY name;

-- sqlfmt-corpus-separator --

SELECT name, definition FROM mz_materialized_views WHERE id LIKE 'u%'

-- sqlfmt-corpus-separator --

SELECT name, id FROM mz_clusters WHERE id LIKE 'u%' AND name != 'quickstart' ORDER BY name;

-- sqlfmt-corpus-separator --

SELECT name, id FROM mz_schemas WHERE id LIKE 'u%' ORDER BY name;

-- sqlfmt-corpus-separator --

SELECT name, inherit FROM mz_roles WHERE id LIKE 'u%'

-- sqlfmt-corpus-separator --

SELECT name, unnest(privileges)::text FROM mz_clusters WHERE name = 'c'

-- sqlfmt-corpus-separator --

SELECT name, unnest(privileges)::text FROM mz_connections WHERE name = 'a'

-- sqlfmt-corpus-separator --

SELECT name, unnest(privileges)::text FROM mz_connections WHERE name = 'c'

-- sqlfmt-corpus-separator --

SELECT name, unnest(privileges)::text FROM mz_databases WHERE name = 'd'

-- sqlfmt-corpus-separator --

SELECT name, unnest(privileges)::text FROM mz_materialized_views WHERE name = 'mv'

-- sqlfmt-corpus-separator --

SELECT name, unnest(privileges)::text FROM mz_schemas WHERE name = 'sch'

-- sqlfmt-corpus-separator --

SELECT name, unnest(privileges)::text FROM mz_secrets WHERE name = 'se'

-- sqlfmt-corpus-separator --

SELECT name, unnest(privileges)::text FROM mz_sources WHERE name = 's'

-- sqlfmt-corpus-separator --

SELECT name, unnest(privileges)::text FROM mz_tables WHERE name = 't'

-- sqlfmt-corpus-separator --

SELECT name, unnest(privileges)::text FROM mz_types WHERE name = 'ty'

-- sqlfmt-corpus-separator --

SELECT name, unnest(privileges)::text FROM mz_views WHERE name = 'v'

-- sqlfmt-corpus-separator --

SELECT normalize('')

-- sqlfmt-corpus-separator --

SELECT normalize('hello world')

-- sqlfmt-corpus-separator --

SELECT normalize('Å')

-- sqlfmt-corpus-separator --

SELECT normalize('é')

-- sqlfmt-corpus-separator --

SELECT normalize(NULL)

-- sqlfmt-corpus-separator --

SELECT now() + '1m'::interval > now(), now() + '1m'::interval >= now()

-- sqlfmt-corpus-separator --

SELECT now() - (SELECT * from start_time) >= INTERVAL '3 sec';

-- sqlfmt-corpus-separator --

SELECT now() - (SELECT * from start_time) >= INTERVAL '5 sec';

-- sqlfmt-corpus-separator --

SELECT now() - statement_timestamp() < interval '10s'

-- sqlfmt-corpus-separator --

SELECT now() - timestamp '2015-06-13' > interval '100h'

-- sqlfmt-corpus-separator --

SELECT now() - transaction_timestamp() = interval '0s'

-- sqlfmt-corpus-separator --

SELECT now() < now() + '1m'::interval, now() <= now() + '1m'::interval

-- sqlfmt-corpus-separator --

SELECT now() = now()::timestamp, now()::timestamp = now()

-- sqlfmt-corpus-separator --

SELECT now() > timestamp '2015-06-13 00:00:00'

-- sqlfmt-corpus-separator --

SELECT now()::timestamp - now(), now() - now()::timestamp

-- sqlfmt-corpus-separator --

SELECT now()::timestamp < now(), now() < now()::timestamp

-- sqlfmt-corpus-separator --

SELECT now()::timestamp <= now(), now() <= now()::timestamp

-- sqlfmt-corpus-separator --

SELECT null * 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT null * 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT null + 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT null + 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT null - 'empty'::int4range

-- sqlfmt-corpus-separator --

SELECT null - 'empty'::int8range

-- sqlfmt-corpus-separator --

SELECT null::int2vector::int2[]::text

-- sqlfmt-corpus-separator --

SELECT null::int2vector::text

-- sqlfmt-corpus-separator --

SELECT numrange(-1.1::numeric(38,0),1.2::numeric(38,10));

-- sqlfmt-corpus-separator --

SELECT numrange(-1.1::numeric(38,10),1.2::numeric(38,0));

-- sqlfmt-corpus-separator --

SELECT numrange(1.1::numeric(38,1),1.2::numeric(38,2));

-- sqlfmt-corpus-separator --

SELECT numrange(1.1::numeric(38,2),1.2::numeric(38,0));

-- sqlfmt-corpus-separator --

SELECT numrange(1.1::numeric(38,2),1.2::numeric(38,1));

-- sqlfmt-corpus-separator --

SELECT obj_description('t'::regclass::oid),
       obj_description('t'::regclass::oid, 'pg_class'),
       obj_description('t'::regclass::oid, 'notexist'),
       col_description('t'::regclass, 1)

-- sqlfmt-corpus-separator --

SELECT object_sub_id, comment
FROM mz_internal.mz_comments
WHERE id LIKE 'u%' AND object_type = 'materialized-view'

-- sqlfmt-corpus-separator --

SELECT object_type, object_sub_id, comment FROM mz_internal.mz_comments WHERE id NOT LIKE 's%';

-- sqlfmt-corpus-separator --

SELECT occurred_at::text = '1970-01-01 00:00:00.666+00' FROM mz_audit_events ORDER BY id DESC LIMIT 1

-- sqlfmt-corpus-separator --

SELECT octet_length('DEADBEEF'::bytea)

-- sqlfmt-corpus-separator --

SELECT octet_length('DEADBEEF'::text);

-- sqlfmt-corpus-separator --

SELECT octet_length('Hello'), octet_length('世界'), octet_length(b'世界')

-- sqlfmt-corpus-separator --

SELECT octet_length('\xDEADBEEF'::bytea)

-- sqlfmt-corpus-separator --

SELECT oid, name FROM mz_objects WHERE id LIKE 's%' AND oid < 20000 ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT oid, name FROM mz_roles WHERE id LIKE 's%' OR id LIKE 'g%' ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT oid, name FROM mz_schemas WHERE id LIKE 's%' ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT ord, b::text FROM test

-- sqlfmt-corpus-separator --

SELECT parse_ident(' first . "  second  " ."   third   ". "  ' || repeat('x',66) || '"')::text;

-- sqlfmt-corpus-separator --

SELECT parse_ident('"SchemaX"."TableY"')::text;

-- sqlfmt-corpus-separator --

SELECT parse_ident('Schemax.Tabley')::text;

-- sqlfmt-corpus-separator --

SELECT parse_ident('foo.boo')::text;

-- sqlfmt-corpus-separator --

SELECT parse_ident('foo.boo[]', false)::text;

-- sqlfmt-corpus-separator --

SELECT pg_catalog.interval '1-2 3 4:5:6.7'

-- sqlfmt-corpus-separator --

SELECT pg_column_size(1::int4), pg_column_size(2::int8), pg_column_size('a'), pg_column_size('ab')

-- sqlfmt-corpus-separator --

SELECT pg_get_viewdef('t_view'::regclass::oid)

-- sqlfmt-corpus-separator --

SELECT pg_get_viewdef('t_view'::regclass::oid, 80)

-- sqlfmt-corpus-separator --

SELECT pg_get_viewdef('t_view'::regclass::oid, false)

-- sqlfmt-corpus-separator --

SELECT pg_get_viewdef('t_view'::regclass::oid, true)

-- sqlfmt-corpus-separator --

SELECT pg_relation_size('pg_views'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_relation_size('pg_views'::regclass, 'main')

-- sqlfmt-corpus-separator --

SELECT pg_relation_size('pg_views'::regclass::oid)

-- sqlfmt-corpus-separator --

SELECT pg_relation_size('pg_views'::regclass::oid, 'main')

-- sqlfmt-corpus-separator --

SELECT pg_stat_get_numscans('pg_views'::regclass::oid)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1'::JSONB)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1.2'::double)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('joe'::name);

-- sqlfmt-corpus-separator --

SELECT pg_typeof('{"a":1}'::JSONB->'a')

-- sqlfmt-corpus-separator --

SELECT pg_typeof('{"a":1}'::JSONB->>'a')

-- sqlfmt-corpus-separator --

SELECT pg_typeof('{1}'::int4_list)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('{1}'::int4_list_list::int4_list_list_too)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('{1}'::int4_list_list_too::int4_list_list)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('{{1}}'::int4_list_list)

-- sqlfmt-corpus-separator --

SELECT pg_typeof(42::uint2)

-- sqlfmt-corpus-separator --

SELECT pg_typeof(42::uint4)

-- sqlfmt-corpus-separator --

SELECT pg_typeof(42::uint8)

-- sqlfmt-corpus-separator --

SELECT pg_typeof(JSON '1')

-- sqlfmt-corpus-separator --

SELECT pg_typeof(JSONB '1')

-- sqlfmt-corpus-separator --

SELECT pg_typeof(NULL::int4_list_c);

-- sqlfmt-corpus-separator --

SELECT pg_typeof(NULL::int4_map);

-- sqlfmt-corpus-separator --

SELECT pg_typeof(a::string[]) FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT pg_typeof(mz_now()), pg_typeof(1::mz_timestamp)

-- sqlfmt-corpus-separator --

SELECT pg_typeof(text '1')

-- sqlfmt-corpus-separator --

SELECT pow('NaN'::numeric, -2.5), pow(-2.5, 'NaN'::numeric);

-- sqlfmt-corpus-separator --

SELECT pow(-1::numeric, '-.1'::numeric)

-- sqlfmt-corpus-separator --

SELECT pow(-2::numeric, -2111176704::numeric)::text;

-- sqlfmt-corpus-separator --

SELECT pow(-2::numeric, 2111176704::numeric)::text;

-- sqlfmt-corpus-separator --

SELECT pow(0::numeric, -1::numeric)

-- sqlfmt-corpus-separator --

SELECT pow(0::numeric, 0::numeric), pow(0.00, -0.000)

-- sqlfmt-corpus-separator --

SELECT pow(1::numeric, 9e-39), pow(9e-39, 1::numeric)

-- sqlfmt-corpus-separator --

SELECT pow(1::numeric, 9e38), pow(9e38, 1::numeric)

-- sqlfmt-corpus-separator --

SELECT pow(1e-10::DECIMAL, 2)

-- sqlfmt-corpus-separator --

SELECT pow(1e-4::DECIMAL, 2), pow(1e-5::DECIMAL, 2), pow(1e-8::DECIMAL, 2), pow(1e-9::DECIMAL, 2)

-- sqlfmt-corpus-separator --

SELECT pow(2::numeric, 3::numeric), pow(2.5, -3.5)

-- sqlfmt-corpus-separator --

SELECT pow(4.727998800941528e-14::DECIMAL, 0.06081860494226844::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT pow(999::numeric, -9999::numeric);

-- sqlfmt-corpus-separator --

SELECT pow(999::numeric, 9999::numeric);

-- sqlfmt-corpus-separator --

SELECT pow(9::decimal(15, 5), 0.5::decimal(15, 5));

-- sqlfmt-corpus-separator --

SELECT pow(CAST (pi() AS DECIMAL), DECIMAL '2.0')

-- sqlfmt-corpus-separator --

SELECT pow(sqrt(1e-10::DECIMAL), 2), sqrt(pow(1e-5::DECIMAL, 2))

-- sqlfmt-corpus-separator --

SELECT power(0::decimal, -1)

-- sqlfmt-corpus-separator --

SELECT power(9::decimal(15, 5), 0.5::decimal(15, 5));

-- sqlfmt-corpus-separator --

SELECT privileges::text FROM mz_system_privileges

-- sqlfmt-corpus-separator --

SELECT privileges::text[] FROM mz_views;

-- sqlfmt-corpus-separator --

SELECT quote_literal(b'abc'), quote_nullable(b'abc')

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY x DESC), dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY x), dense_rank() OVER (ORDER BY x), x FROM t

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY NULL ORDER BY 10000), dense_rank() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY NULL), dense_rank() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY x ORDER BY x), dense_rank() OVER (PARTITION BY x ORDER BY x), x FROM t;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY y ORDER BY x DESC), dense_rank() OVER (PARTITION BY y ORDER BY x DESC), x FROM t;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY y ORDER BY x DESC, z), dense_rank() OVER (PARTITION BY y ORDER BY x DESC, z), x, y, z
FROM t;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY y ORDER BY x), dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t;

-- sqlfmt-corpus-separator --

SELECT rank(x) OVER (ORDER BY x), dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank;

-- sqlfmt-corpus-separator --

SELECT regexp_replace(id::text, 'u.*', 'u%') FROM mz_internal.mz_internal_cluster_replicas WHERE id LIKE 'u%'

-- sqlfmt-corpus-separator --

SELECT regexp_replace(obj_description('pg_class'::regclass::oid), e' .*', '') AS comment1,
       regexp_replace(obj_description('pg_class'::regclass::oid, 'pg_class'), e' .*', '') AS comment2

-- sqlfmt-corpus-separator --

SELECT replace(b, ' ', 'x'), b::bool FROM bools_text

-- sqlfmt-corpus-separator --

SELECT replace(s, E'\n', '<newline>'), regex_pat, replace(regexp_match(s, regex_pat)::text, E'\n', '<newline>') FROM t;

-- sqlfmt-corpus-separator --

SELECT replace(s, E'\n', '<newline>'), regex_pat, replace(regexp_match(s, regex_pat, 'ci')::text, E'\n', '<newline>') FROM t;

-- sqlfmt-corpus-separator --

SELECT replace(s, E'\n', '<newline>'), regex_pat, replace(regexp_match(s, regex_pat, 'i')::text, E'\n', '<newline>') FROM t;

-- sqlfmt-corpus-separator --

SELECT replace(s, E'\n', '<newline>'), regex_pat, replace(regexp_match(s, regex_pat, 'ic')::text, E'\n', '<newline>') FROM t;

-- sqlfmt-corpus-separator --

SELECT right('abcde💩'::bytes, 2)

-- sqlfmt-corpus-separator --

SELECT round('5.6e10'::numeric, -10);

-- sqlfmt-corpus-separator --

SELECT round('5.6e10'::numeric, 10);

-- sqlfmt-corpus-separator --

SELECT round('9.876e38'::numeric, -37);

-- sqlfmt-corpus-separator --

SELECT round('9.876e38'::numeric, -38);

-- sqlfmt-corpus-separator --

SELECT round('NaN'::numeric)

-- sqlfmt-corpus-separator --

SELECT round('inf'::decimal)

-- sqlfmt-corpus-separator --

SELECT round(-2.5::decimal), round(-1.5::decimal), round(0.0::decimal), round(1.5::decimal), round(2.5::decimal)

-- sqlfmt-corpus-separator --

SELECT round(-2.5::decimal, 0), round(-1.5::decimal, 0), round(1.5::decimal, 0), round(2.5::decimal, 0)

-- sqlfmt-corpus-separator --

SELECT round(-2.5::decimal, 3), round(-1.5::decimal, 3), round(0.0::decimal, 3), round(1.5::decimal, 3), round(2.5::decimal, 3)

-- sqlfmt-corpus-separator --

SELECT round(123.456::decimal, -1), round(123.456::decimal, -2), round(123.456::decimal, -3), round(123.456::decimal, -200)

-- sqlfmt-corpus-separator --

SELECT round(1::decimal, 3000)

-- sqlfmt-corpus-separator --

SELECT round(CAST (515 AS decimal), -3), round(515, -3), round(CAST (515 AS decimal(4, 0)), -3)

-- sqlfmt-corpus-separator --

SELECT round(DISTINCT 1)

-- sqlfmt-corpus-separator --

SELECT round(NULL::decimal, 2)

-- sqlfmt-corpus-separator --

SELECT round(NULL::decimal, NULL)

-- sqlfmt-corpus-separator --

SELECT round(exp(2)::decimal(15, 5), 3)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER ()

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (), row_number() OVER ()

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (), row_number() OVER () from t

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x DESC), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x NULLS FIRST), x FROM t;

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x NULLS LAST), x FROM t;

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

SELECT s FROM t WHERE s ILIKE 'a%';

-- sqlfmt-corpus-separator --

SELECT s FROM t WHERE s ILIKE like_pat;

-- sqlfmt-corpus-separator --

SELECT s FROM t WHERE s LIKE 'a%';

-- sqlfmt-corpus-separator --

SELECT s FROM t WHERE s LIKE like_pat;

-- sqlfmt-corpus-separator --

SELECT s FROM t WHERE s NOT ILIKE 'a%';

-- sqlfmt-corpus-separator --

SELECT schemaname, matviewname, definition FROM pg_catalog.pg_matviews WHERE matviewname LIKE 'test_%'

-- sqlfmt-corpus-separator --

SELECT schemaname, viewname, definition FROM pg_catalog.pg_views WHERE viewname LIKE 'test_%'

-- sqlfmt-corpus-separator --

SELECT seahash('\x666f6f626172'::bytea);

-- sqlfmt-corpus-separator --

SELECT sha1(NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT sha224('')::text

-- sqlfmt-corpus-separator --

SELECT sha224('The quick brown fox jumps over the lazy dog.')::text

-- sqlfmt-corpus-separator --

SELECT sha256('')::text

-- sqlfmt-corpus-separator --

SELECT sha256('The quick brown fox jumps over the lazy dog.')::text

-- sqlfmt-corpus-separator --

SELECT sha256(NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT sha384('')::text

-- sqlfmt-corpus-separator --

SELECT sha384('The quick brown fox jumps over the lazy dog.')::text

-- sqlfmt-corpus-separator --

SELECT sha512('')::text

-- sqlfmt-corpus-separator --

SELECT sha512('The quick brown fox jumps over the lazy dog.')::text

-- sqlfmt-corpus-separator --

SELECT sha512(NULL::STRING, NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT shobj_description('t'::regclass::oid, 'pg_class'),
       obj_description((select oid from pg_database where datname = 'test')::oid, 'pg_database')

-- sqlfmt-corpus-separator --

SELECT shobj_description((select oid from pg_database where datname = 'materialize')::oid, 'pg_database'),
       shobj_description((select oid from pg_database where datname = 'test')::oid, 'pg_database'),
       shobj_description((select oid from pg_database where datname = 'notexist')::oid, 'pg_database'),
       shobj_description((select oid from pg_database where datname = 'test')::oid, 'notexist')

-- sqlfmt-corpus-separator --

SELECT sin('-inf'::double)

-- sqlfmt-corpus-separator --

SELECT sin('NaN'::double)

-- sqlfmt-corpus-separator --

SELECT sin('inf'::double)

-- sqlfmt-corpus-separator --

SELECT sin(0::double)

-- sqlfmt-corpus-separator --

SELECT sin(1::double)

-- sqlfmt-corpus-separator --

SELECT sinh('-inf'::double)

-- sqlfmt-corpus-separator --

SELECT sinh('NaN'::double)

-- sqlfmt-corpus-separator --

SELECT sinh('inf'::double)

-- sqlfmt-corpus-separator --

SELECT sinh(0::double)

-- sqlfmt-corpus-separator --

SELECT sinh(1::double)

-- sqlfmt-corpus-separator --

SELECT sqrt('.98765432109876543210'::numeric)

-- sqlfmt-corpus-separator --

SELECT sqrt(-1.0::decimal)

-- sqlfmt-corpus-separator --

SELECT sqrt(-1::decimal(15, 2))

-- sqlfmt-corpus-separator --

SELECT sqrt(-2::numeric)

-- sqlfmt-corpus-separator --

SELECT sqrt(1.23783::decimal(15, 5))

-- sqlfmt-corpus-separator --

SELECT sqrt(1.23783::double)

-- sqlfmt-corpus-separator --

SELECT sqrt(2::numeric), sqrt(3::numeric), sqrt(0::numeric)

-- sqlfmt-corpus-separator --

SELECT sqrt(9.789765531128956e-34::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT string_agg('foo', CAST ((SELECT NULL) AS BYTEA)) OVER ();

-- sqlfmt-corpus-separator --

SELECT sum(sum(x) OVER ()) FROM t7;

-- sqlfmt-corpus-separator --

SELECT sum(sum(x) OVER ()) OVER () FROM t7;

-- sqlfmt-corpus-separator --

SELECT sum(sum(x)) OVER (ORDER BY y) FROM t7 GROUP BY y;

-- sqlfmt-corpus-separator --

SELECT sum(v) FROM not_allowed_tests GROUP BY k LIMIT 1 OFFSET sum(v) OVER ();

-- sqlfmt-corpus-separator --

SELECT sum(v) FROM not_allowed_tests GROUP BY k LIMIT sum(v) OVER ();

-- sqlfmt-corpus-separator --

SELECT t FROM timestamptzish WHERE t < TIMESTAMPTZ '1999-12-31 9:46:01-04'

-- sqlfmt-corpus-separator --

SELECT t FROM timestamptzish WHERE t <= TIMESTAMPTZ '1999-12-31 9:46:01-04'

-- sqlfmt-corpus-separator --

SELECT t FROM timestamptzish WHERE t = TIMESTAMP '1999-12-31 13:46:01'

-- sqlfmt-corpus-separator --

SELECT t FROM timestamptzish WHERE t = TIMESTAMPTZ '1999-12-31 13:46:01z'

-- sqlfmt-corpus-separator --

SELECT t FROM timestamptzish WHERE t = TIMESTAMPTZ '1999-12-31 9:46:01-04'

-- sqlfmt-corpus-separator --

SELECT t FROM timestamptzish WHERE t > TIMESTAMPTZ '1999-12-31 9:46:01-04'

-- sqlfmt-corpus-separator --

SELECT t FROM timestamptzish WHERE t >= TIMESTAMPTZ '1999-12-31 9:46:01-04'

-- sqlfmt-corpus-separator --

SELECT tan('-inf'::double)

-- sqlfmt-corpus-separator --

SELECT tan('NaN'::double)

-- sqlfmt-corpus-separator --

SELECT tan('inf'::double)

-- sqlfmt-corpus-separator --

SELECT tan(0::double)

-- sqlfmt-corpus-separator --

SELECT tan(1.01::double)

-- sqlfmt-corpus-separator --

SELECT tanh('-inf'::double)

-- sqlfmt-corpus-separator --

SELECT tanh('NaN'::double)

-- sqlfmt-corpus-separator --

SELECT tanh('inf'::double)

-- sqlfmt-corpus-separator --

SELECT tanh(0::double)

-- sqlfmt-corpus-separator --

SELECT tanh(1::double)

-- sqlfmt-corpus-separator --

SELECT text_val LIKE '%1%2%' FROM t2;

-- sqlfmt-corpus-separator --

SELECT text_val NOT ILIKE '%A%' FROM t2;

-- sqlfmt-corpus-separator --

SELECT time '01:02:03.04'::interval;

-- sqlfmt-corpus-separator --

SELECT timestamp '95143-12-31 17:59:59.123456789+00' = timestamp(6) '95143-12-31 17:59:59.123456789+00';

-- sqlfmt-corpus-separator --

SELECT timestamp '95143-12-31 23:59:59.123456789+06';

-- sqlfmt-corpus-separator --

SELECT timestamp(0) '95143-12-31 17:59:59.123+00' = timestamp(0) '95143-12-31 17:59:59.123456789+00';

-- sqlfmt-corpus-separator --

SELECT timestamp(0) '95143-12-31 23:59:59.123456789+06';

-- sqlfmt-corpus-separator --

SELECT timestamp(0) without time zone '95143-12-31 23:59:59.123456789+06';

-- sqlfmt-corpus-separator --

SELECT timestamp(5) '95143-12-31 17:59:59.1235+00' = timestamp(4) '95143-12-31 17:59:59.123456789+00';

-- sqlfmt-corpus-separator --

SELECT timestamp::timestamp from t ORDER BY t.timestamp;

-- sqlfmt-corpus-separator --

SELECT timestamptz '95141-12-31 23:59:59.123456789+06';

-- sqlfmt-corpus-separator --

SELECT timestamptz '95143-12-31 23:59:59.123456789+06' = timestamptz(6) '95143-12-31 23:59:59.123456789+06';

-- sqlfmt-corpus-separator --

SELECT timestamptz(-1) '95143-12-31 23:59:59.123456789+06';

-- sqlfmt-corpus-separator --

SELECT timestamptz(0) '95143-12-31 23:59:59+06' = timestamptz(0) '95143-12-31 23:59:59.123456789+06';

-- sqlfmt-corpus-separator --

SELECT timestamptz(0) '95143-12-31 23:59:59.123456789+06';

-- sqlfmt-corpus-separator --

SELECT timestamptz(10000000000000000000) '95143-12-31 23:59:59.123456789+06';

-- sqlfmt-corpus-separator --

SELECT timezone('+5', '0001-01-01 12:00:00 +6'::TIMESTAMPTZ);

-- sqlfmt-corpus-separator --

SELECT timezone('-5', '0001-01-01 12:00:00 -6'::TIMESTAMPTZ);

-- sqlfmt-corpus-separator --

SELECT timezone('America/New_York', TIMESTAMP '2020-12-21 18:53:49')

-- sqlfmt-corpus-separator --

SELECT timezone('PST', TIMESTAMP '2020-12-21 18:53:49')

-- sqlfmt-corpus-separator --

SELECT to_char(TIMESTAMP '2000-01-01', 'no patterns at all')

-- sqlfmt-corpus-separator --

SELECT to_char(TIMESTAMPTZ '1997-02-03 11:12:59.7777', 'YYYY-MM-DD HH24:MI:SS.MS TZ')

-- sqlfmt-corpus-separator --

SELECT to_char(TIMESTAMPTZ '1997-02-03 11:12:59.9', 'YYYY-MM-DD HH24:MI:SS.MS TZ')

-- sqlfmt-corpus-separator --

SELECT to_json('"a"'::JSON)

-- sqlfmt-corpus-separator --

SELECT to_json('00:00:00'::TIME)

-- sqlfmt-corpus-separator --

SELECT to_json('10.1.0.0/16'::INET)

-- sqlfmt-corpus-separator --

SELECT to_json('2014-05-28 12:22:35.614298'::TIMESTAMP)

-- sqlfmt-corpus-separator --

SELECT to_json('2014-05-28 12:22:35.614298-04'::TIMESTAMP)

-- sqlfmt-corpus-separator --

SELECT to_json('2014-05-28 12:22:35.614298-04'::TIMESTAMPTZ)

-- sqlfmt-corpus-separator --

SELECT to_json('2014-05-28'::DATE)

-- sqlfmt-corpus-separator --

SELECT to_json('2h45m2s234ms'::INTERVAL)

-- sqlfmt-corpus-separator --

SELECT to_json('\a'::TEXT)

-- sqlfmt-corpus-separator --

SELECT to_json('\x0001'::BYTEA)

-- sqlfmt-corpus-separator --

SELECT to_json('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'::UUID);

-- sqlfmt-corpus-separator --

SELECT to_json(1.234::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT to_json(false::BOOL)

-- sqlfmt-corpus-separator --

SELECT to_json(true::BOOL)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('"a"'::JSON)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('00:00:00'::TIME)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('02:45:02.234'::INTERVAL)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('10.1.0.0/16'::INET)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('2014-05-28 12:22:35.614298'::TIMESTAMP)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('2014-05-28 12:22:35.614298-04'::TIMESTAMP)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('2014-05-28 12:22:35.614298-04'::TIMESTAMPTZ)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('2014-05-28'::DATE)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('2h45m2s234ms'::INTERVAL)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('\a'::TEXT)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('\x0001'::BYTEA)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'::UUID);

-- sqlfmt-corpus-separator --

SELECT to_jsonb(1.234::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(DATE '2019-12-31');

-- sqlfmt-corpus-separator --

SELECT to_jsonb(TIMESTAMP '1969-06-01 10:10:10.41');

-- sqlfmt-corpus-separator --

SELECT to_jsonb(false::BOOL)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(true::BOOL)

-- sqlfmt-corpus-separator --

SELECT to_timestamp('inf'::double)

-- sqlfmt-corpus-separator --

SELECT to_timestamp('nan'::double)

-- sqlfmt-corpus-separator --

SELECT to_timestamp(-0.1::float8);

-- sqlfmt-corpus-separator --

SELECT to_timestamp(-9223372036854775809::float8);

-- sqlfmt-corpus-separator --

SELECT to_timestamp(9223372036854775808::float8);

-- sqlfmt-corpus-separator --

SELECT to_uuid('63616665-6630-3064-6465-616462656566'),
       to_uuid('{63616665-6630-3064-6465-616462656566}'),
       to_uuid('urn:uuid:63616665-6630-3064-6465-616462656566'),
       from_uuid(b'cafef00ddeadbeef'),
       to_uuid(from_uuid(b'cafef00ddeadbeef')),
       from_uuid(to_uuid('63616665-6630-3064-6465-616462656566'))

-- sqlfmt-corpus-separator --

SELECT translate('[1]', '[]', '')::numeric

-- sqlfmt-corpus-separator --

SELECT true FROM x WHERE j->'a' @> '2'::JSONB

-- sqlfmt-corpus-separator --

SELECT true::string;

-- sqlfmt-corpus-separator --

SELECT trunc(-0.0), trunc(0.0), trunc(1.9), trunc(19.5678::decimal)

-- sqlfmt-corpus-separator --

SELECT trunc(1.234), trunc(-1.234), trunc('NaN'::numeric)

-- sqlfmt-corpus-separator --

SELECT trunc(NULL::decimal)

-- sqlfmt-corpus-separator --

SELECT ts > TIMESTAMP '2016-06-13 00:00:00' FROM now_view

-- sqlfmt-corpus-separator --

SELECT unnest(privileges)::text FROM mz_types WHERE name = 'ty'

-- sqlfmt-corpus-separator --

SELECT usename, useconfig::text FROM pg_user;

-- sqlfmt-corpus-separator --

SELECT x::text FROM t ORDER BY x::text DESC;

-- sqlfmt-corpus-separator --

SELECT x::text FROM t;

-- sqlfmt-corpus-separator --

SELECT ~42::uint2

-- sqlfmt-corpus-separator --

SELECT ~42::uint4

-- sqlfmt-corpus-separator --

SELECT ~42::uint8

-- sqlfmt-corpus-separator --

select '(,)'::daterange != 'empty'::daterange;

-- sqlfmt-corpus-separator --

select '(,)'::daterange < 'empty'::daterange;

-- sqlfmt-corpus-separator --

select '(,)'::daterange <= 'empty'::daterange;

-- sqlfmt-corpus-separator --

select '(,)'::daterange = '(,)'::daterange;

-- sqlfmt-corpus-separator --

select '(,)'::daterange > 'empty'::daterange;

-- sqlfmt-corpus-separator --

select '(,)'::daterange >= 'empty'::daterange;

-- sqlfmt-corpus-separator --

select '(,)'::int4range != 'empty'::int4range;

-- sqlfmt-corpus-separator --

select '(,)'::int4range < 'empty'::int4range;

-- sqlfmt-corpus-separator --

select '(,)'::int4range <= 'empty'::int4range;

-- sqlfmt-corpus-separator --

select '(,)'::int4range = '(,)'::int4range;

-- sqlfmt-corpus-separator --

select '(,)'::int4range > 'empty'::int4range;

-- sqlfmt-corpus-separator --

select '(,)'::int4range >= 'empty'::int4range;

-- sqlfmt-corpus-separator --

select '(,)'::int8range != 'empty'::int8range;

-- sqlfmt-corpus-separator --

select '(,)'::int8range < 'empty'::int8range;

-- sqlfmt-corpus-separator --

select '(,)'::int8range <= 'empty'::int8range;

-- sqlfmt-corpus-separator --

select '(,)'::int8range = '(,)'::int8range;

-- sqlfmt-corpus-separator --

select '(,)'::int8range > 'empty'::int8range;

-- sqlfmt-corpus-separator --

select '(,)'::int8range >= 'empty'::int8range;

-- sqlfmt-corpus-separator --

select '(,)'::numrange != 'empty'::numrange;

-- sqlfmt-corpus-separator --

select '(,)'::numrange < 'empty'::numrange;

-- sqlfmt-corpus-separator --

select '(,)'::numrange <= 'empty'::numrange;

-- sqlfmt-corpus-separator --

select '(,)'::numrange = '(,)'::numrange;

-- sqlfmt-corpus-separator --

select '(,)'::numrange > 'empty'::numrange;

-- sqlfmt-corpus-separator --

select '(,)'::numrange >= 'empty'::numrange;

-- sqlfmt-corpus-separator --

select '(,)'::tsrange != 'empty'::tsrange;

-- sqlfmt-corpus-separator --

select '(,)'::tsrange < 'empty'::tsrange;

-- sqlfmt-corpus-separator --

select '(,)'::tsrange <= 'empty'::tsrange;

-- sqlfmt-corpus-separator --

select '(,)'::tsrange = '(,)'::tsrange;

-- sqlfmt-corpus-separator --

select '(,)'::tsrange > 'empty'::tsrange;

-- sqlfmt-corpus-separator --

select '(,)'::tsrange >= 'empty'::tsrange;

-- sqlfmt-corpus-separator --

select '(,)'::tstzrange != 'empty'::tstzrange;

-- sqlfmt-corpus-separator --

select '(,)'::tstzrange < 'empty'::tstzrange;

-- sqlfmt-corpus-separator --

select '(,)'::tstzrange <= 'empty'::tstzrange;

-- sqlfmt-corpus-separator --

select '(,)'::tstzrange = '(,)'::tstzrange;

-- sqlfmt-corpus-separator --

select '(,)'::tstzrange > 'empty'::tstzrange;

-- sqlfmt-corpus-separator --

select '(,)'::tstzrange >= 'empty'::tstzrange;

-- sqlfmt-corpus-separator --

select '(1,2)'::numrange < '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(1,2)'::numrange <= '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(1,2)'::numrange = '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(1,2)'::numrange > '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(1,2)'::numrange >= '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(3,4)'::numrange < '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(3,4)'::numrange <= '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(3,4)'::numrange = '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(3,4)'::numrange > '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(3,4)'::numrange >= '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(5,6)'::numrange < '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(5,6)'::numrange <= '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(5,6)'::numrange = '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(5,6)'::numrange > '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '(5,6)'::numrange >= '(3,4)'::numrange;

-- sqlfmt-corpus-separator --

select '0001-02-24 03:04:05'::timestamp - interval '1 YEAR'

-- sqlfmt-corpus-separator --

select '0001-02-24 03:04:05.6789 +00:00'::timestamptz - interval '-2147483648 MONTHS'

-- sqlfmt-corpus-separator --

select '0001-02-24 03:04:05.6789 +00:00'::timestamptz - interval '1 YEAR'

-- sqlfmt-corpus-separator --

select '0001-02-24 03:04:05.6789'::timestamp - interval '-2147483648 MONTHS'

-- sqlfmt-corpus-separator --

select '0001-02-24 03:04:05.6789'::timestamp - interval '1 YEAR'

-- sqlfmt-corpus-separator --

select '0001-02-24'::date - interval '-2147483648 MONTHS'

-- sqlfmt-corpus-separator --

select '0001-02-24'::date - interval '1 YEAR'

-- sqlfmt-corpus-separator --

select '9::59.999999999'::time

-- sqlfmt-corpus-separator --

select '9::60'::time, '9:59:60'::time, '9::59.999999'::time

-- sqlfmt-corpus-separator --

select '9::60.1'::time

-- sqlfmt-corpus-separator --

select '[0,100)'::int4range;

-- sqlfmt-corpus-separator --

select '[0,100)'::int8range;

-- sqlfmt-corpus-separator --

select '[0,100)'::numrange;

-- sqlfmt-corpus-separator --

select '[1970-01-01 00:00:00,1971-01-01 00:00:00)'::tsrange;

-- sqlfmt-corpus-separator --

select '[1970-01-01 00:00:00,1971-01-01 00:00:00)'::tstzrange;

-- sqlfmt-corpus-separator --

select '[1970-01-01,62143-12-30)'::daterange;

-- sqlfmt-corpus-separator --

select 'date'::regtype::oid::text::regtype

-- sqlfmt-corpus-separator --

select 'empty'::daterange;

-- sqlfmt-corpus-separator --

select 'empty'::int4range;

-- sqlfmt-corpus-separator --

select 'empty'::int8range;

-- sqlfmt-corpus-separator --

select 'empty'::numrange;

-- sqlfmt-corpus-separator --

select 'empty'::tsrange;

-- sqlfmt-corpus-separator --

select 'empty'::tstzrange;

-- sqlfmt-corpus-separator --

select 'infinity'::date

-- sqlfmt-corpus-separator --

select 'now'::regproc::oid::regproc

-- sqlfmt-corpus-separator --

select '栬艷^Ằ['::int4range

-- sqlfmt-corpus-separator --

select ('24:00'::TIME)::STRING

-- sqlfmt-corpus-separator --

select (select (a.*)::text) from view_a a

-- sqlfmt-corpus-separator --

select 1 < 2.0::decimal, 1.0::decimal < 2, 2.0::decimal < 1, 2 < 1.0::decimal

-- sqlfmt-corpus-separator --

select 1 <= 1.0::decimal, 1.0::decimal <= 1, 2.0::decimal <= 1, 2 <= 1.0::decimal

-- sqlfmt-corpus-separator --

select 1 = 1.0::decimal, 1.0::decimal = 1, 1 = 2.0::decimal, 2.0::decimal = 1

-- sqlfmt-corpus-separator --

select 1 >= 1.0::decimal, 1.0::decimal >= 1, 1.0::decimal >= 2, 1 >= 2.0::decimal

-- sqlfmt-corpus-separator --

select 1::decimal < 2.0, 1.0 < 2::decimal, 2.0 < 1::decimal, 2::decimal < 1.0

-- sqlfmt-corpus-separator --

select 1::decimal <= 1.0, 1.0 <= 1::decimal, 2.0 <= 1::decimal, 2::decimal <= 1.0

-- sqlfmt-corpus-separator --

select 1::decimal = 1.0, 1.0 = 1::decimal, 1::decimal = 2.0, 2.0 = 1::decimal

-- sqlfmt-corpus-separator --

select 1::decimal >= 1.0, 1.0 >= 1::decimal, 1.0 >= 2::decimal, 1::decimal >= 2.0

-- sqlfmt-corpus-separator --

select 2 > 1.0::decimal, 2.0::decimal > 1, 1 > 2.0::decimal, 1.0::decimal > 2

-- sqlfmt-corpus-separator --

select 2::decimal > 1.0, 2.0 > 1::decimal, 1::decimal > 2.0, 1.0 > 2::decimal

-- sqlfmt-corpus-separator --

select TIMESTAMP '"2020-03-17 ~02:36:~56~"';

-- sqlfmt-corpus-separator --

select ceil(f1)::text as ceil_f1 from float8_tbl f

-- sqlfmt-corpus-separator --

select ceiling(f1)::text as ceiling_f1 from float8_tbl f;

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_abbrevs

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_names

-- sqlfmt-corpus-separator --

select floor(f1)::text as floor_f1 from float8_tbl f

-- sqlfmt-corpus-separator --

select ln(4.0786335175292462e+34::decimal)

-- sqlfmt-corpus-separator --

select log(1::numeric, 2::numeric);

-- sqlfmt-corpus-separator --

select null::daterange

-- sqlfmt-corpus-separator --

select null::int4range

-- sqlfmt-corpus-separator --

select null::int8range

-- sqlfmt-corpus-separator --

select null::numrange

-- sqlfmt-corpus-separator --

select null::tsrange

-- sqlfmt-corpus-separator --

select null::tstzrange

-- sqlfmt-corpus-separator --

select pg_typeof('[0,100)'::int4range);

-- sqlfmt-corpus-separator --

select pg_typeof('[0,100)'::int8range);

-- sqlfmt-corpus-separator --

select pg_typeof('[0,100)'::numrange);

-- sqlfmt-corpus-separator --

select pg_typeof('[1970-01-01 00:00:00,1971-01-01 00:00:00)'::tsrange);

-- sqlfmt-corpus-separator --

select pg_typeof('[1970-01-01 00:00:00,1971-01-01 00:00:00)'::tstzrange);

-- sqlfmt-corpus-separator --

select pg_typeof('[1970-01-01,62143-12-30)'::daterange);

-- sqlfmt-corpus-separator --

select pg_typeof('empty'::daterange);

-- sqlfmt-corpus-separator --

select pg_typeof('empty'::int4range);

-- sqlfmt-corpus-separator --

select pg_typeof('empty'::int8range);

-- sqlfmt-corpus-separator --

select pg_typeof('empty'::numrange);

-- sqlfmt-corpus-separator --

select pg_typeof('empty'::tsrange);

-- sqlfmt-corpus-separator --

select pg_typeof('empty'::tstzrange);

-- sqlfmt-corpus-separator --

select q1, count(*)::float8 / (select count(*) from int8_tbl)
from int8_tbl group by q1 order by q1

-- sqlfmt-corpus-separator --

select timezone('1 day'::interval, '1-12-31'::timestamptz+'262141 years'::interval)