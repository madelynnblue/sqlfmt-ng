(VALUES (
  1 < ALL(SELECT * FROM (VALUES (1)) WHERE false),
  1 < ALL(VALUES (0)),
  1 < ALL(VALUES (1)),
  1 < ALL(VALUES (2)),
  1 < ALL(VALUES (0), (NULL)),
  1 < ALL(VALUES (1), (NULL)),
  1 < ALL(VALUES (2), (NULL)),
  NULL < ALL(SELECT * FROM (VALUES (1)) WHERE false),
  NULL < ALL(VALUES (0)),
  NULL < ALL(VALUES (1)),
  NULL < ALL(VALUES (2)),
  NULL < ALL(VALUES (NULL)),
  NULL < ALL(VALUES (0), (NULL)),
  NULL < ALL(VALUES (1), (NULL)),
  NULL < ALL(VALUES (2), (NULL))
))

-- sqlfmt-corpus-separator --

(VALUES (
  1 < ANY(SELECT * FROM (VALUES (1)) WHERE false),
  1 < ANY(VALUES (0)),
  1 < ANY(VALUES (1)),
  1 < ANY(VALUES (2)),
  1 < ANY(VALUES (0), (NULL)),
  1 < ANY(VALUES (1), (NULL)),
  1 < ANY(VALUES (2), (NULL)),
  NULL < ANY(SELECT * FROM (VALUES (1)) WHERE false),
  NULL < ANY(VALUES (0)),
  NULL < ANY(VALUES (1)),
  NULL < ANY(VALUES (2)),
  NULL < ANY(VALUES (NULL)),
  NULL < ANY(VALUES (0), (NULL)),
  NULL < ANY(VALUES (1), (NULL)),
  NULL < ANY(VALUES (2), (NULL))
))

-- sqlfmt-corpus-separator --

SELECT
   ~1 & 0  as def_and, ~(1 & 0)  as l_prec_and, (~1) & 0  as h_prec_and,
   ~0 | 1  as def_or , ~(0 | 1)  as l_prec_or , (~0) | 1  as h_prec_or

-- sqlfmt-corpus-separator --

SELECT
   ~1 + 1  as def_add, ~(1 + 1)  as l_prec_add, (~1) + 1  as h_prec_add,
   ~1 - 2  as def_sub, ~(1 - 2)  as l_prec_sub, (~1) - 2  as h_prec_sub

-- sqlfmt-corpus-separator --

SELECT
  array_agg(y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  avg(y+y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  count(y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  count(y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING),
  sum(y)   OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  o1,
  o2,
  v,
  sum(v) OVER (ORDER BY o1, o2),
  max(v) OVER (ORDER BY o1, o2),
  min(v) OVER (ORDER BY o1, o2),
  array_agg(v) OVER (ORDER BY o1, o2 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t8
ORDER BY o1, o2;

-- sqlfmt-corpus-separator --

SELECT
  o1,
  o2,
  v,
  sum(v) OVER (PARTITION BY o1 ORDER BY o2),
  max(v) OVER (PARTITION BY o1 ORDER BY o2),
  min(v) OVER (PARTITION BY o1 ORDER BY o2),
  array_agg(v) OVER (PARTITION BY o1 ORDER BY o2 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t8
ORDER BY o1, o2;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (ORDER BY x ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (ORDER BY x ROWS BETWEEN 3 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  max(x+x) OVER (PARTITION BY x-y ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  min(x+x) OVER (PARTITION BY x-y ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-y ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x-y, x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  max(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  min(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x-y, x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(y) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  max(y) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  min(y) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(y) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(y) OVER (ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
  max(y) OVER (ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
  min(y) OVER (ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
  jsonb_agg(y) OVER (ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t7
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(y) OVER (ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  max(y) OVER (ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  min(y) OVER (ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(y) OVER (ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
  max(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
  min(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
  array_agg(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t7
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x-row_number() OVER (ORDER BY x+y),
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  max(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  min(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t7
ORDER BY x-row_number() OVER (ORDER BY x+y), x;

-- sqlfmt-corpus-separator --

SELECT
  x-row_number() OVER (ORDER BY x+y),
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN row_number() OVER (ORDER BY x+y) PRECEDING AND 0 FOLLOWING),
  max(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN row_number() OVER (ORDER BY x+y) PRECEDING AND 0 FOLLOWING),
  min(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN row_number() OVER (ORDER BY x+y) PRECEDING AND 0 FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN row_number() OVER (ORDER BY x+y) PRECEDING AND 0 FOLLOWING)
FROM t7
ORDER BY x-row_number() OVER (ORDER BY x+y), x;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  max(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  min(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t7
ORDER BY x-y+x/10, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1000000 PRECEDING AND 1000000 FOLLOWING),
  max(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1000000 PRECEDING AND 1000000 FOLLOWING),
  min(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1000000 PRECEDING AND 1000000 FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1000000 PRECEDING AND 1000000 FOLLOWING)
FROM t7
ORDER BY x-y+x/10, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
  max(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
  min(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
  array_agg(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t7
ORDER BY x-y+x/10, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING),
  max(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING),
  min(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t7
ORDER BY x-y+x/10, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND CURRENT ROW),
  max(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND CURRENT ROW),
  min(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND CURRENT ROW),
  array_agg(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t7
ORDER BY x-y+x/10, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(y) OVER (PARTITION BY x-y+x/10 ROWS BETWEEN 200 PRECEDING AND 100 PRECEDING),
  count(y) OVER (PARTITION BY x-y+x/10 ROWS BETWEEN 200 PRECEDING AND 100 PRECEDING),
  array_agg(y) OVER (PARTITION BY x-y+x/10 ROWS BETWEEN 200 PRECEDING AND 100 PRECEDING),
  avg(y) OVER (PARTITION BY x-y+x/10 ROWS BETWEEN 200 PRECEDING AND 100 PRECEDING)
FROM t7
ORDER BY x, y;

-- sqlfmt-corpus-separator --

SELECT
  x-y,
  x,
  y,
  array_agg(x/10) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  count(DISTINCT x/10) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x-y, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y,
  x,
  y,
  jsonb_agg(2*x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  avg(x+y) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  variance(x+y) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  var_pop(x+y) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  stddev(x+y) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  stddev_pop(x+y) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x-y, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y,
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  max(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  min(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x-y, x;

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) !~~* 'Abc'::char(4);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) ~~ 'abc ';

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) ~~ 'abc'::char(4);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) ~~ 'abc';

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(4) ~~ 'abc ';

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(4) ~~ 'abc'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(4) ~~ 'abc'::char(4);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(4) ~~ 'abc';

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL AS t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", t1.a, t2.e FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e) WHERE t1.a = t2.d

-- sqlfmt-corpus-separator --

SELECT (-1)::smallint::text, (-1)::bigint::text, (-1.0)::text, (-1.0)::float::text, (-1.0)::double::text

-- sqlfmt-corpus-separator --

SELECT (-6734743351254754)::bigint * (-99783359317598)::bigint

-- sqlfmt-corpus-separator --

SELECT (1, 2) = ALL(SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT (1, 2) = ANY(SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT (1, 2) = SOME(SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT (1, 2) IN (SELECT * FROM abc)

-- sqlfmt-corpus-separator --

SELECT (1, 2) IN (SELECT 1 AS a)

-- sqlfmt-corpus-separator --

SELECT (1, 2) IN (SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT (1, 2) IN (SELECT a, b FROM abc WHERE false)

-- sqlfmt-corpus-separator --

SELECT (1, 2) IN (SELECT a, b FROM abc)

-- sqlfmt-corpus-separator --

SELECT (1, 2) IN (SELECT a, b FROM t ORDER BY 1 ASC, 2 ASC) AS r

-- sqlfmt-corpus-separator --

SELECT (1, 2) IN (SELECT a, b FROM t ORDER BY 1 DESC, 2 DESC) AS r

-- sqlfmt-corpus-separator --

SELECT (1, 2, 3) IN (SELECT 1, 2, 3)

-- sqlfmt-corpus-separator --

SELECT (CAST(-6734743351254754 AS bigint) * CAST(-99783359317598 AS bigint))

-- sqlfmt-corpus-separator --

SELECT (SELECT 123 AS a),
       (VALUES (cos(1)::INT)),
       (SELECT cos(0)::INT)

-- sqlfmt-corpus-separator --

SELECT (SELECT 123 IN (VALUES (1), (2)))

-- sqlfmt-corpus-separator --

SELECT (list_agg(a ORDER BY a) FILTER (WHERE b IS NOT NULL))::text FROM t2

-- sqlfmt-corpus-separator --

SELECT (list_agg(a) FILTER (WHERE a IS NOT NULL))::text FROM t1

-- sqlfmt-corpus-separator --

SELECT (list_agg(a) FILTER (WHERE a IS NULL))::text FROM t1

-- sqlfmt-corpus-separator --

SELECT (map_agg(a::TEXT, a) FILTER (WHERE a IS NOT NULL))::TEXT FROM t1

-- sqlfmt-corpus-separator --

SELECT * FROM ab AS foo (foo1, foo2)

-- sqlfmt-corpus-separator --

SELECT * FROM ab AS foo (foo1, foo2, foo3)

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2)

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2) WHERE foo.c = 6

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2) WHERE foo.foo1 = 1

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2) WHERE foo.foo2 = 2

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2, foo3)

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2, foo3, foo4)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = ANY(SELECT a FROM abc WHERE b = 10)

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE bill = ANY(SELECT ship FROM o);

-- sqlfmt-corpus-separator --

SELECT * FROM int WHERE a IS DISTINCT FROM 2

-- sqlfmt-corpus-separator --

SELECT * FROM int WHERE a IS NOT DISTINCT FROM 2

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE (k,v) IN (SELECT * FROM kv)

-- sqlfmt-corpus-separator --

SELECT * FROM t3 WHERE NOT ((t3.c0 != 0.6) AND (t3.c0 != -0.1) AND (t3.c0 != 0.1) AND (-0.1 != t3.c0));

-- sqlfmt-corpus-separator --

SELECT -(.1 * 2.2)

-- sqlfmt-corpus-separator --

SELECT -(0.1 - 0.10);

-- sqlfmt-corpus-separator --

SELECT -(1.23 - 2.34)

-- sqlfmt-corpus-separator --

SELECT 0.0::decimal as a,
      -0.0::decimal as b,
      0.00::decimal as c,
     -0.00::decimal as d,
  (-0.000)::decimal as e,
         0::decimal as f,
        -0::decimal as g,
  '0.0000'::decimal as h,
 '-0.0000'::decimal as i

-- sqlfmt-corpus-separator --

SELECT 0.0::float as a,
      -0.0::float as b,
      0.00::float as c,
     -0.00::float as d,
  (-0.000)::float as e,
                0 as f,
               -0 as g,
         0::float as h,
        -0::float as i,
  '0.0000'::float as j,
 '-0.0000'::float as k

-- sqlfmt-corpus-separator --

SELECT 1 < ALL(VALUES(NULL))

-- sqlfmt-corpus-separator --

SELECT 1 = ANY(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 = SOME(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 IS DISTINCT FROM 'hello'

-- sqlfmt-corpus-separator --

SELECT 1 IS DISTINCT FROM 1

-- sqlfmt-corpus-separator --

SELECT 1 IS DISTINCT FROM 1.0

-- sqlfmt-corpus-separator --

SELECT 1 IS DISTINCT FROM 2

-- sqlfmt-corpus-separator --

SELECT 1 IS DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT 1 IS NOT DISTINCT FROM 'hello'

-- sqlfmt-corpus-separator --

SELECT 1 IS NOT DISTINCT FROM 1

-- sqlfmt-corpus-separator --

SELECT 1 IS NOT DISTINCT FROM 1.0

-- sqlfmt-corpus-separator --

SELECT 1 IS NOT DISTINCT FROM 2

-- sqlfmt-corpus-separator --

SELECT 1 IS NOT DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT 1::int4 IS DISTINCT FROM 1::int8

-- sqlfmt-corpus-separator --

SELECT 1::int4 IS DISTINCT FROM 2::int8

-- sqlfmt-corpus-separator --

SELECT 1::int4 IS NOT DISTINCT FROM 1::int8

-- sqlfmt-corpus-separator --

SELECT ARRAY[1] UNION ALL SELECT ARRAY['foo']

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(((x)), (x, y)) x, y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz ORDER BY row_number() OVER(ORDER BY (pk1, pk2)) DESC

-- sqlfmt-corpus-separator --

SELECT NULL IS DISTINCT FROM 1

-- sqlfmt-corpus-separator --

SELECT NULL IS DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT NULL IS NOT DISTINCT FROM 1

-- sqlfmt-corpus-separator --

SELECT NULL IS NOT DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT a AS t FROM daterange_values EXCEPT SELECT column1 FROM (VALUES
    (daterange(null,'1970-01-01')),
    (daterange(null,'1970-01-01', '[]')),
    (daterange(null,null)),
    (daterange(null,null, '[]')),
    (daterange(null,'1970-01-01', '()')),
    (daterange(null,'1970-01-01', '(]')),
    (daterange(null,null, '()')),
    (daterange(null,null,'(]')),
    (daterange('1969-12-31','1970-01-01')),
    (daterange('1969-12-31','1970-01-01', '[]')),
    (daterange('1969-12-31','1970-01-01', '()')),
    (daterange('1969-12-31','1970-01-01','(]')),
    (daterange('1970-01-01',null)),
    (daterange('1970-01-01',null, '[]')),
    (daterange('1970-01-01',null,'()')),
    (daterange('1970-01-01',null,'(]'))
) t;

-- sqlfmt-corpus-separator --

SELECT a AS t FROM int4range_values EXCEPT SELECT column1 FROM (VALUES
    (int4range(null,1)),
    (int4range(null,1, '[]')),
    (int4range(null,null)),
    (int4range(null,null, '[]')),
    (int4range(null,1, '()')),
    (int4range(null,1, '(]')),
    (int4range(null,null, '()')),
    (int4range(null,null,'(]')),
    (int4range(-1,1)),
    (int4range(-1,1, '[]')),
    (int4range(-1,1, '()')),
    (int4range(-1,1,'(]')),
    (int4range(0,0)),
    (int4range(0,0, '[]')),
    (int4range(0,0,'()')),
    (int4range(0,0,'(]')),
    (int4range(1,null)),
    (int4range(1,null, '[]')),
    (int4range(1,null,'()')),
    (int4range(1,null,'(]'))
) t;

-- sqlfmt-corpus-separator --

SELECT a AS t FROM int8range_values EXCEPT SELECT column1 FROM (VALUES
    (int8range(null,1)),
    (int8range(null,1, '[]')),
    (int8range(null,null)),
    (int8range(null,null, '[]')),
    (int8range(null,1, '()')),
    (int8range(null,1, '(]')),
    (int8range(null,null, '()')),
    (int8range(null,null,'(]')),
    (int8range(-1,1)),
    (int8range(-1,1, '[]')),
    (int8range(-1,1, '()')),
    (int8range(-1,1,'(]')),
    (int8range(0,0)),
    (int8range(0,0, '[]')),
    (int8range(0,0,'()')),
    (int8range(0,0,'(]')),
    (int8range(1,null)),
    (int8range(1,null, '[]')),
    (int8range(1,null,'()')),
    (int8range(1,null,'(]'))
) t;

-- sqlfmt-corpus-separator --

SELECT a AS t FROM numrange_values EXCEPT SELECT column1 FROM (VALUES
    (numrange(null,1)),
    (numrange(null,1, '[]')),
    (numrange(null,null)),
    (numrange(null,null, '[]')),
    (numrange(null,1, '()')),
    (numrange(null,1, '(]')),
    (numrange(null,null, '()')),
    (numrange(null,null,'(]')),
    (numrange(-1,1)),
    (numrange(-1,1, '[]')),
    (numrange(-1,1, '()')),
    (numrange(-1,1,'(]')),
    (numrange(0,0)),
    (numrange(0,0, '[]')),
    (numrange(0,0,'()')),
    (numrange(0,0,'(]')),
    (numrange(1,null)),
    (numrange(1,null, '[]')),
    (numrange(1,null,'()')),
    (numrange(1,null,'(]'))
) t;

-- sqlfmt-corpus-separator --

SELECT a AS t FROM tsrange_values EXCEPT SELECT column1 FROM (VALUES
    (tsrange(null,'1970-01-01 00:00:01')),
    (tsrange(null,'1970-01-01 00:00:01', '[]')),
    (tsrange(null,null)),
    (tsrange(null,null, '[]')),
    (tsrange(null,'1970-01-01 00:00:01', '()')),
    (tsrange(null,'1970-01-01 00:00:01', '(]')),
    (tsrange(null,null, '()')),
    (tsrange(null,null,'(]')),
    (tsrange('1969-12-31 11:59:59','1970-01-01 00:00:01')),
    (tsrange('1969-12-31 11:59:59','1970-01-01 00:00:01', '[]')),
    (tsrange('1969-12-31 11:59:59','1970-01-01 00:00:01', '()')),
    (tsrange('1969-12-31 11:59:59','1970-01-01 00:00:01','(]')),
    (tsrange('1970-01-01 00:00:00','1970-01-01 00:00:00')),
    (tsrange('1970-01-01 00:00:00','1970-01-01 00:00:00', '[]')),
    (tsrange('1970-01-01 00:00:00','1970-01-01 00:00:00','()')),
    (tsrange('1970-01-01 00:00:00','1970-01-01 00:00:00','(]')),
    (tsrange('1970-01-01 00:00:01',null)),
    (tsrange('1970-01-01 00:00:01',null, '[]')),
    (tsrange('1970-01-01 00:00:01',null,'()')),
    (tsrange('1970-01-01 00:00:01',null,'(]'))
) t;

-- sqlfmt-corpus-separator --

SELECT a AS t FROM tstzrange_values EXCEPT SELECT column1 FROM (VALUES
    (tstzrange(null,'1970-01-01 00:00:01')),
    (tstzrange(null,'1970-01-01 00:00:01', '[]')),
    (tstzrange(null,null)),
    (tstzrange(null,null, '[]')),
    (tstzrange(null,'1970-01-01 00:00:01', '()')),
    (tstzrange(null,'1970-01-01 00:00:01', '(]')),
    (tstzrange(null,null, '()')),
    (tstzrange(null,null,'(]')),
    (tstzrange('1969-12-31 11:59:59','1970-01-01 00:00:01')),
    (tstzrange('1969-12-31 11:59:59','1970-01-01 00:00:01', '[]')),
    (tstzrange('1969-12-31 11:59:59','1970-01-01 00:00:01', '()')),
    (tstzrange('1969-12-31 11:59:59','1970-01-01 00:00:01','(]')),
    (tstzrange('1970-01-01 00:00:00','1970-01-01 00:00:00')),
    (tstzrange('1970-01-01 00:00:00','1970-01-01 00:00:00', '[]')),
    (tstzrange('1970-01-01 00:00:00','1970-01-01 00:00:00','()')),
    (tstzrange('1970-01-01 00:00:00','1970-01-01 00:00:00','(]')),
    (tstzrange('1970-01-01 00:00:01',null)),
    (tstzrange('1970-01-01 00:00:01',null, '[]')),
    (tstzrange('1970-01-01 00:00:01',null,'()')),
    (tstzrange('1970-01-01 00:00:01',null,'(]'))
) t;

-- sqlfmt-corpus-separator --

SELECT a.f1 FROM (SELECT 'test' AS f1 FROM varchar_tbl) a
UNION
SELECT b.f1 FROM (SELECT f1 FROM varchar_tbl) b
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT abc.b FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT abc.foo1 FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT array_agg(a) FILTER (WHERE a IS NOT NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT array_agg(a) FILTER (WHERE a IS NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT d::text[][1][1] FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT f1 AS five FROM FLOAT8_TBL
  WHERE f1 BETWEEN -1e6 AND 1e6
UNION
SELECT f1 FROM INT4_TBL
  WHERE f1 BETWEEN 0 AND 1000000
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 100 FOLLOWING AND 1000001 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1000 PRECEDING AND 1000 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1000 PRECEDING AND 999 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551614 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551614 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551615 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND -1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1000 FOLLOWING AND 1000 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1000 FOLLOWING AND 1001 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1000001 PRECEDING AND 100 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551614 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551615 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT foo.a FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT foo1, foo.foo1, b, foo.c FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(a) FILTER (WHERE a IS NOT NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg(a, a) FILTER (WHERE a IS NOT NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT (((SELECT q2 FROM int8_tbl ORDER BY q2 LIMIT 1))) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT round(CAST (-1.4678 AS double precision))

-- sqlfmt-corpus-separator --

SELECT round(CAST (-1.4678 AS float))

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN CURRENT ROW AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN CURRENT ROW AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 FOLLOWING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN CURRENT ROW AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN CURRENT ROW AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE UNBOUNDED PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS -1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT t0.c1 FROM t0 WHERE (CASE t0.c1 WHEN 'bZkESziLfXXL3G3YWk3j3FGvDHCwEkrTmYd9ANGvVBoF0J4Dpim3YrnbiF38bQo5HA3kxP4kz1F1V6DIgKdfsbDT' THEN t0.c0 ELSE t0.c1 END ) UNION ALL SELECT t0.c1 FROM t0 WHERE (NOT (CASE t0.c1 WHEN 'bZkESziLfXXL3G3YWk3j3FGvDHCwEkrTmYd9ANGvVBoF0J4Dpim3YrnbiF38bQo5HA3kxP4kz1F1V6DIgKdfsbDT' THEN t0.c0 ELSE t0.c1 END )) UNION ALL SELECT t0.c1 FROM t0 WHERE (((CASE t0.c1 WHEN 'bZkESziLfXXL3G3YWk3j3FGvDHCwEkrTmYd9ANGvVBoF0J4Dpim3YrnbiF38bQo5HA3kxP4kz1F1V6DIgKdfsbDT' THEN t0.c0 ELSE t0.c1 END )) IS NULL)

-- sqlfmt-corpus-separator --

SELECT trunc(CAST (-1.4678 AS double precision))

-- sqlfmt-corpus-separator --

SELECT trunc(CAST (-1.4678 AS float))

-- sqlfmt-corpus-separator --

VALUES (
  '"hello"'::JSONB   ? 'hello',
  '"hello"'::JSONB   ? 'goodbye',
  '"hello"'::JSONB   ? 'ello',
  '"hello"'::JSONB   ? 'h',
  'true'::JSONB      ? 'true',
  '1'::JSONB         ? '1',
  'null'::JSONB      ? 'null'
)

-- sqlfmt-corpus-separator --

VALUES ((SELECT 1)), ((SELECT 2))

-- sqlfmt-corpus-separator --

VALUES (1), (1), (1), (2), (2) EXCEPT ALL VALUES (1), (3), (1)

-- sqlfmt-corpus-separator --

VALUES (1), (1), (1), (2), (2) EXCEPT VALUES (1), (3), (1)

-- sqlfmt-corpus-separator --

VALUES (1), (1), (1), (2), (2) INTERSECT ALL VALUES (1), (3), (1)

-- sqlfmt-corpus-separator --

VALUES (1), (1), (1), (2), (2) INTERSECT VALUES (1), (3), (1)

-- sqlfmt-corpus-separator --

VALUES (1), (1), (1), (2), (2) UNION ALL VALUES (1), (3), (1)

-- sqlfmt-corpus-separator --

VALUES (1), (1), (1), (2), (2) UNION ALL VALUES (1), (3), (1) ORDER BY 1 DESC LIMIT 2

-- sqlfmt-corpus-separator --

VALUES (1), (1), (1), (2), (2) UNION VALUES (1), (3), (1)

-- sqlfmt-corpus-separator --

VALUES (1), (1), (2), (3) ORDER BY 1 DESC LIMIT 3

-- sqlfmt-corpus-separator --

VALUES (1), (1), (2), (3) ORDER BY z

-- sqlfmt-corpus-separator --

VALUES (1), (2, 3)

-- sqlfmt-corpus-separator --

VALUES (1, (SELECT (2)))

-- sqlfmt-corpus-separator --

VALUES (1, 2), (1, 1), (1, 2), (2, 1), (2, 1) UNION VALUES (1, 3), (3, 4), (1, 1)

-- sqlfmt-corpus-separator --

VALUES (1, 2, 3), (4, 5, 6)

-- sqlfmt-corpus-separator --

VALUES (NULL, 1), (2, NULL), (NULL, 'a')

-- sqlfmt-corpus-separator --

VALUES (format_type('anyelement'::regtype, NULL)),
       (format_type('bool'::regtype, NULL)),
       (format_type('bytea'::regtype, NULL)),
       (format_type('date'::regtype, NULL)),
       (format_type('numeric'::regtype, NULL)),
       (format_type('interval'::regtype, NULL)),
       (format_type('timestamp'::regtype, NULL)),
       (format_type('timestamptz'::regtype, NULL)),
       (format_type('record'::regtype, NULL))

-- sqlfmt-corpus-separator --

VALUES (length('a')), (1 + length('a')), (length('abc')), (length('ab') * 2)

-- sqlfmt-corpus-separator --

WITH
    lines AS (
        SELECT regexp_split_to_table(input, '\n') AS line
        FROM aoc_1201
    ),
    slices AS (
        SELECT line, index, substring(line, index, width) AS slice
        FROM
            lines,
            generate_series(1, length(line)) AS index,
            generate_series(1, 5) AS width
    ),
    numbers (t, n) AS (
        VALUES ('0', 0), ('1', 1), ('2', 2), ('3', 3), ('4', 4), ('5', 5), ('6', 6), ('7', 7), ('8', 8), ('9', 9),
               ('zero', 0), ('one', 1), ('two', 2), ('three', 3), ('four', 4), ('five', 5), ('six', 6), ('seven', 7), ('eight', 8), ('nine', 9)
    ),
    findings AS (
        SELECT line, index, n AS number
        FROM slices, numbers
        WHERE slices.slice = numbers.t
    ),
    first AS ( SELECT DISTINCT ON (line) line, number AS f FROM findings ORDER BY line, index ),
    last AS ( SELECT DISTINCT ON (line) line, number AS l FROM findings ORDER BY line, index DESC )
SELECT SUM(f * 10 + l)
FROM first, last
WHERE first.line = last.line

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2)
        )
SELECT
    jsonb_agg(a ORDER BY a DESC)::text AS a_desc,
    jsonb_agg(a ORDER BY b)::text AS b,
    jsonb_agg(a ORDER BY b, a ASC)::text AS b_a_asc,
    jsonb_agg(a ORDER BY b, a DESC)::text AS b_a_desc
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2)
        )
SELECT
    jsonb_object_agg(b, a ORDER BY a DESC)::text AS a_desc,
    jsonb_object_agg(b, a ORDER BY b)::text AS b,
    jsonb_object_agg(b, a ORDER BY b, a ASC)::text AS b_a_asc,
    jsonb_object_agg(b, a ORDER BY b, a DESC)::text AS b_a_desc
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2)
        )
SELECT
    list_agg(a ORDER BY a DESC)::text AS a_desc,
    list_agg(a ORDER BY b)::text AS b,
    list_agg(a ORDER BY b, a ASC)::text AS b_a_asc,
    list_agg(a ORDER BY b, a DESC)::text AS b_a_desc
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2)
        )
SELECT
    string_agg(a, '-' ORDER BY a DESC)::text AS a_desc,
    string_agg(a, '-' ORDER BY b)::text AS b,
    string_agg(a, '-' ORDER BY b, a ASC)::text AS b_a_asc,
    string_agg(a, '-' ORDER BY b, a DESC)::text AS b_a_desc
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2),
                ('e', NULL)
        )
SELECT
    array_agg(a ORDER BY a DESC)::text AS a_desc,
    array_agg(a ORDER BY b)::text AS b,
    array_agg(a ORDER BY b, a ASC)::text AS b_a_asc,
    array_agg(a ORDER BY b, a DESC)::text AS b_a_desc,
    array_agg(a ORDER BY b NULLS FIRST, a DESC)::text AS b_a_desc_nulls_first
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    w (c) AS (VALUES (NULL), (NULL))
SELECT
    '1971-03-18'::DATE + 300866802885581286
FROM
    w
ORDER BY
    c

-- sqlfmt-corpus-separator --

WITH
  simple AS (
    SELECT
      x%5 AS x5_simple,
      avg(y) OVER (PARTITION BY x%5) AS avg_simple
    FROM t7
  ),
  complicated AS ( -- array_agg, then do an unnest and global agg in a subquery in a SELECT
    WITH
      array_agg AS (
        SELECT
          x%5 AS x5,
          array_agg(y) OVER (PARTITION BY x%5) AS l
        FROM t7
      )
    SELECT
      x5 AS x5_complicated,
      (
        SELECT avg(uy)
        FROM unnest(l) AS uy
      ) AS avg_complicated
    FROM array_agg
  )
SELECT DISTINCT
  x5_simple,
  avg_simple,
  avg_complicated,
  avg_simple = avg_complicated
FROM simple, complicated
WHERE x5_simple = x5_complicated
ORDER BY x5_simple;

-- sqlfmt-corpus-separator --

WITH a AS (DELETE FROM a WHERE b IN (4,5) RETURNING a,b)
SELECT * FROM a LIMIT 0

-- sqlfmt-corpus-separator --

WITH a AS (INSERT INTO a VALUES (2,3), (3,4) RETURNING a,b)
SELECT * FROM a LIMIT 0

-- sqlfmt-corpus-separator --

WITH a AS (UPDATE a SET a = -a WHERE b % 2 = 1 RETURNING a,b)
SELECT * FROM a LIMIT 0

-- sqlfmt-corpus-separator --

WITH count AS (VALUES (9)) SELECT count(*) FROM count;

-- sqlfmt-corpus-separator --

WITH foo AS (SELECT 1)
  (SELECT * FROM foo
    UNION ALL
  (WITH foo AS (SELECT 2) SELECT * FROM foo)
    UNION ALL
  (SELECT * FROM foo))

-- sqlfmt-corpus-separator --

WITH outermost(x) AS (
  SELECT 1
  UNION (WITH innermost as (SELECT 2)
         SELECT * FROM innermost
         UNION SELECT 3)
)
SELECT * FROM outermost ORDER BY 1;

-- sqlfmt-corpus-separator --

WITH outermost(x) AS (
  SELECT 1
  UNION (WITH innermost as (SELECT 2)
         SELECT * FROM outermost  -- fail
         UNION SELECT * FROM innermost)
)
SELECT * FROM outermost ORDER BY 1;

-- sqlfmt-corpus-separator --

WITH parsed AS (
  SELECT regexp_split_to_table(input, '\n') AS line FROM aoc_1204
),
numbers AS (
  SELECT split_part(line,':',1) AS card_id,
         replace(split_part(line,':',2),'|','') AS nrs
  FROM parsed
),
arr AS (
  SELECT card_id,
         nrs,
         regexp_split_to_array(ltrim(rtrim(nrs)),'\s') AS nrs_arr
  FROM numbers
),
winning AS (
  SELECT card_id,
         unnest(array_remove(nrs_arr,'')) nr,
         ROW_NUMBER() OVER (PARTITION BY card_id) AS row_num
  FROM arr
  GROUP BY card_id, nr HAVING COUNT(*)>1
  ORDER BY card_id
),
winning_points AS (
  SELECT ROUND(EXP(SUM(LN(CASE WHEN row_num = 1 THEN row_num ELSE 2 END)))) AS points
  FROM winning
  GROUP BY card_id
)
SELECT SUM(points)
FROM winning_points;

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT
  sum(f1)   OVER (ORDER BY f2) s,
  max(f1)   OVER (ORDER BY f2) m,
  count(f1) OVER (ORDER BY f3) c
FROM t
ORDER BY s, m, c;

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551614 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551614 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551615 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551614 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551615 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551614 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551615 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f3) OVER (PARTITION BY f2 ORDER BY f1)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, -2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, 10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, -10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 1, f3) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, NULL, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, f1 - 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, nullif(f1, 1)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(nullif(f1, 4)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, -2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, 10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, -10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 1, f3) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, NULL, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, f1 - 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, nullif(f1, 1)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(nullif(f1, 4)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1::uint8, 'a', 1.0))
SELECT lag(f1, 1::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1::uint8, 'a', 1.0))
SELECT lag(f1, 1::int, 0::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1::uint8, 'a', 1.0))
SELECT pg_typeof(lag(f1, 1::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1))
FROM t

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1::uint8, 'a', 1.0))
SELECT pg_typeof(lag(f1, 1::int, 0::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1))
FROM t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'))
SELECT dense_rank() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'))
SELECT row_number() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'))
SELECT row_number() OVER (), row_number() OVER () from t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT lag(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT lag(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT lead(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT lead(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT lag(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT lag(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT lead(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT lead(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT * FROM t
WHERE row_number() over () > 1;

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT DISTINCT ON (row_number() OVER ()) *
FROM t
ORDER BY row_number() OVER ()

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT lag(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT lag(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT lead(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT lead(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT row_number() FROM t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x DESC), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), (NULL), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x NULLS FIRST), x FROM t;

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), (NULL), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x NULLS LAST), x FROM t;

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT dense_rank() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT dense_rank() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lag(a1.x) OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lag(x) OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lag(x) OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lead(a1.x) OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lead(x) OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lead(x) OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT row_number() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT row_number() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT row_number() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT lag(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT lead(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT row_number() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98), ('a', 98), ('a', 99))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98), ('a', 98), ('a', 99))
SELECT lag(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98), ('a', 98), ('a', 99))
SELECT lead(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x, y, z) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC, z), x, y, z
FROM t
ORDER BY y, x DESC, z

-- sqlfmt-corpus-separator --

WITH t (x, y, z) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY z DESC), x, y, z
FROM t
ORDER BY y, z DESC, x

-- sqlfmt-corpus-separator --

WITH t (x, y, z) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0))
SELECT rank() OVER (PARTITION BY y ORDER BY z DESC), dense_rank() OVER (PARTITION BY y ORDER BY z DESC), x, y, z
FROM t;

-- sqlfmt-corpus-separator --

select 'apple' !~~ any (VALUES('a%'), ('b%'));

-- sqlfmt-corpus-separator --

select 'apple' ilike all (VALUES('A%'), ('B%'));

-- sqlfmt-corpus-separator --

select 'apple' ilike any (VALUES('A%'), ('B%'));

-- sqlfmt-corpus-separator --

select 'apple' like all (VALUES('A%'), ('B%'));

-- sqlfmt-corpus-separator --

select 'apple' like all (VALUES('a%'), ('appl%'));

-- sqlfmt-corpus-separator --

select 'apple' like all (VALUES('a%'), ('b%'));

-- sqlfmt-corpus-separator --

select 'apple' like any (VALUES('A%'), ('B%'));

-- sqlfmt-corpus-separator --

select 'apple' like any (VALUES('a%'), ('b%'));

-- sqlfmt-corpus-separator --

select 'apple' not like all (VALUES('a%'), ('b%'));

-- sqlfmt-corpus-separator --

select 'apple' not like any (VALUES('a%'), ('b%'));

-- sqlfmt-corpus-separator --

select 'apple' ~~ any (VALUES('a%'), ('b%'));

-- sqlfmt-corpus-separator --

select 'apple' ~~* any (VALUES('A%'), ('B%'));

-- sqlfmt-corpus-separator --

select * from int4_tbl where
  (case when f1 in (select unique1 from tenk1 a) then f1 else null end) in
  (select ten from tenk1 b)

-- sqlfmt-corpus-separator --

select * from outer_7597 where (f1, f2) not in (select * from inner_7597)

-- sqlfmt-corpus-separator --

select unique1, unique2 from tenk1
where (unique1, unique2) < any (select ten, ten from tenk1 where hundred < 3)
      and unique1 <= 20
order by 1;

-- sqlfmt-corpus-separator --

select x from (values (array[1, 2]), (array[1, 3])) _(x) except select x from (values (array[1, 2]), (array[1, 4])) _(x)

-- sqlfmt-corpus-separator --

select x from (values (array[1, 2]), (array[1, 3])) _(x) intersect select x from (values (array[1, 2]), (array[1, 4])) _(x)

-- sqlfmt-corpus-separator --

select x from (values (array[1, 2]), (array[1, 3])) _(x) union select x from (values (array[1, 2]), (array[1, 4])) _(x)

-- sqlfmt-corpus-separator --

select x from (values (row(1, 2)), (row(1, 3))) _(x) except select x from (values (row(1, 2)), (row(1, 4))) _(x)

-- sqlfmt-corpus-separator --

select x from (values (row(1, 2)), (row(1, 3))) _(x) intersect select x from (values (row(1, 2)), (row(1, 4))) _(x)

-- sqlfmt-corpus-separator --

select x from (values (row(1, 2)), (row(1, 3))) _(x) union select x from (values (row(1, 2)), (row(1, 4))) _(x)

-- sqlfmt-corpus-separator --

values ('2023-01-01T00:00:00.666'::timestamp(6)) union all values ('2023-01-01T00:00:00.666666'::timestamptz(3));

-- sqlfmt-corpus-separator --

with
  v1 as (
    WITH
            creates AS
            (
                SELECT
                    details ->> 'logical_size' AS size,
                    details ->> 'replica_id' AS replica_id,
                    occurred_at
                FROM mz_catalog.mz_audit_events
                WHERE
                    object_type = 'cluster-replica' AND event_type = 'create'
            )
        SELECT
            mz_unsafe.mz_error_if_null(
                    mz_cluster_replica_sizes.credits_per_hour, 'Replica of unknown size'
                )
                AS credits_per_hour
        FROM
            creates
                LEFT JOIN
                    mz_catalog.mz_cluster_replica_sizes
                    ON mz_cluster_replica_sizes.size = creates.size
  )
select * from v1
WHERE credits_per_hour > credits_per_hour;

-- sqlfmt-corpus-separator --

with table_privileges as (
 select
   NULL as role,
   t.schemaname as schema,
   t.objectname as table,
   pg_catalog.has_table_privilege(current_user, '"' || t.schemaname || '"' || '.' || '"' || t.objectname || '"',  'UPDATE') as update,
   pg_catalog.has_table_privilege(current_user, '"' || t.schemaname || '"' || '.' || '"' || t.objectname || '"',  'SELECT') as select,
   pg_catalog.has_table_privilege(current_user, '"' || t.schemaname || '"' || '.' || '"' || t.objectname || '"',  'INSERT') as insert,
   pg_catalog.has_table_privilege(current_user, '"' || t.schemaname || '"' || '.' || '"' || t.objectname || '"',  'DELETE') as delete
 from (
   select schemaname, tablename as objectname from pg_catalog.pg_tables
   union
   select schemaname, viewname as objectname from pg_catalog.pg_views
   union
   select schemaname, matviewname as objectname from pg_catalog.pg_matviews
 ) t
 where t.schemaname !~ '^pg_'
   and t.schemaname <> 'information_schema'
   and pg_catalog.has_schema_privilege(current_user, t.schemaname, 'USAGE')
)
select t.*
from table_privileges t