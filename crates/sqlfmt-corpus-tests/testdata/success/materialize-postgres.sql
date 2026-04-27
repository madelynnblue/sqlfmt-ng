(((SELECT q1 FROM int8_tbl INTERSECT SELECT q2 FROM int8_tbl ORDER BY 1))) UNION ALL SELECT q2 FROM int8_tbl

-- sqlfmt-corpus-separator --

(((SELECT q1 FROM int8_tbl UNION ALL SELECT q2 FROM int8_tbl))) EXCEPT SELECT q1 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

((SELECT 2)) UNION SELECT 2

-- sqlfmt-corpus-separator --

(SELECT * FROM mvi1)
UNION ALL
(SELECT * FROM t3);

-- sqlfmt-corpus-separator --

(SELECT * FROM mvi2)
UNION ALL
(SELECT * FROM t3);

-- sqlfmt-corpus-separator --

(SELECT * FROM mvi3)
UNION ALL
(SELECT * FROM t3);

-- sqlfmt-corpus-separator --

(SELECT * FROM t1 UNION ALL SELECT * FROM t1) EXCEPT ALL (SELECT * FROM t2 UNION ALL SELECT * FROM t2);

-- sqlfmt-corpus-separator --

(SELECT * FROM t1 UNION ALL SELECT * FROM t1) UNION ALL (SELECT * FROM t2 UNION ALL SELECT * FROM t2);

-- sqlfmt-corpus-separator --

(SELECT * FROM t1) UNION ALL (SELECT * FROM t2);

-- sqlfmt-corpus-separator --

(SELECT * FROM t1) UNION ALL (SELECT * FROM t3);

-- sqlfmt-corpus-separator --

(SELECT * FROM t2) UNION ALL (SELECT * FROM t1);

-- sqlfmt-corpus-separator --

(SELECT * FROM t3) UNION (SELECT * FROM t4);

-- sqlfmt-corpus-separator --

(SELECT 1,2,3 UNION SELECT 4,5,6 ORDER BY 1,2) EXCEPT SELECT 4,5,6

-- sqlfmt-corpus-separator --

(SELECT 1,2,3 UNION SELECT 4,5,6 ORDER BY 1,2) INTERSECT SELECT 4,5,6

-- sqlfmt-corpus-separator --

(SELECT 1,2,3 UNION SELECT 4,5,6) EXCEPT SELECT 4,5,6

-- sqlfmt-corpus-separator --

(SELECT 1,2,3 UNION SELECT 4,5,6) INTERSECT SELECT 4,5,6

-- sqlfmt-corpus-separator --

(SELECT 2) UNION SELECT 2

-- sqlfmt-corpus-separator --

(SELECT a FROM foo)
UNION
(SELECT a FROM foo)
ORDER BY a;

-- sqlfmt-corpus-separator --

(SELECT a FROM foo)
UNION
(SELECT a+1 FROM foo)
ORDER BY a IN (SELECT length(b)-1 FROM foo), -a;

-- sqlfmt-corpus-separator --

(SELECT a FROM foo)
UNION
(SELECT a-3 FROM foo)
ORDER BY -2*a+3;

-- sqlfmt-corpus-separator --

(SELECT a FROM foo)
UNION
(SELECT a-3 FROM foo)
ORDER BY a;

-- sqlfmt-corpus-separator --

(SELECT a FROM foo)
UNION
(SELECT a-3 FROM foo)
ORDER BY lag(a) OVER ();

-- sqlfmt-corpus-separator --

(SELECT a FROM foo)
UNION
(SELECT a-3 FROM foo)
ORDER BY sum(a);

-- sqlfmt-corpus-separator --

(SELECT a FROM foo) UNION (SELECT a FROM foo) ORDER BY b

-- sqlfmt-corpus-separator --

(SELECT a-3 FROM foo)
UNION
(SELECT a FROM foo)
ORDER BY a;

-- sqlfmt-corpus-separator --

(SELECT v FROM uniontest WHERE k = 1 UNION ALL SELECT v FROM uniontest WHERE k = 2) ORDER BY 1 DESC LIMIT 2

-- sqlfmt-corpus-separator --

SELECT
    '1971-03-18'::DATE + 300866802885581286

-- sqlfmt-corpus-separator --

SELECT
    5 << 1  & 12  as implicit_l,
   (5 << 1) & 12  as explicit_l,
    5 << (1 & 12) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
    5 << 1  >> 3  as implicit_l,
   (5 << 1) >> 3  as explicit_l,
    5 << (1 >> 3) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
    5 >> 1  & 12  as implicit_l,
   (5 >> 1) & 12  as explicit_l,
    5 >> (1 & 12) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
    5 >> 1  << 3  as implicit_l,
   (5 >> 1) << 3  as explicit_l,
    5 >> (1 << 3) as explicit_r

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
    c_id,
    'CA' IN (SELECT ship FROM o WHERE o.c_id=c.c_id)
    AND 'TX' NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id)
FROM c
ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT
    c_id,
    'WY' IN (SELECT ship FROM o WHERE o.c_id=c.c_id)
    OR 'WA' IN (SELECT ship FROM o WHERE o.c_id=c.c_id)
FROM c
ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT
    c_id,
    (SELECT min(ship) FROM o WHERE o.c_id=c.c_id) IN (SELECT ship FROM o WHERE o.c_id=c.c_id)
FROM c
ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT
    c_id,
    EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id)
    OR NOT EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id)
FROM c
ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT
    c_id,
    bill = ALL(SELECT ship FROM o WHERE o.c_id=c.c_id)
    AND EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id)
FROM c
ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT
    c_id,
    bill = ALL(SELECT ship FROM o WHERE o.c_id=c.c_id)
    OR EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id AND ship='WY')
FROM c
ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT
    liker,
    likee,
    likee IN (SELECT other FROM favorites WHERE peep = liker) AS is_favorite
FROM likes

-- sqlfmt-corpus-separator --

SELECT
    liker,
    likee,
    likee NOT IN (SELECT other FROM favorites WHERE peep = liker) AS is_favorite
FROM likes

-- sqlfmt-corpus-separator --

SELECT
   0  &  0  #  1  as implicit_l,
  (0  &  0) #  1  as explicit_l,
   0  & (0  #  1) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
   0  &  0  |  1  as implicit_l,
  (0  &  0) |  1  as explicit_l,
   0  & (0  |  1) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
   1  #  0  &  0  as implicit_l,
  (1  #  0) &  0  as explicit_l,
   1  # (0  &  0) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
   1  #  0  |  1  as implicit_l,
  (1  #  0) |  1  as explicit_l,
   1  # (0  |  1) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
   1  |  0  #  1  as implicit_l,
  (1  |  0) #  1  as explicit_l,
   1  | (0  #  1) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
   1  |  0  &  0  as implicit_l,
  (1  |  0) &  0  as explicit_l,
   1  | (0  &  0) as explicit_r

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
  array_agg(y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  array_agg(y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  avg(DISTINCT k)::FLOAT,
  avg(DISTINCT v)::FLOAT,
  sum(DISTINCT k)::FLOAT,
  sum(DISTINCT v)::FLOAT
FROM kv

-- sqlfmt-corpus-separator --

SELECT
  avg(k::decimal)::float,
  avg(v::decimal)::float,
  sum(k::decimal)::float,
  sum(v::decimal)::float
FROM kv

-- sqlfmt-corpus-separator --

SELECT
  avg(y+y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
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
  sum(sum(x)) OVER ()
FROM t7;

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
  sum(y) OVER (),
  max(y) OVER (),
  min(y) OVER (),
  array_agg(y ORDER BY y) OVER (),
  array_agg(y ORDER BY y NULLS LAST) OVER (),
  array_agg(y ORDER BY y NULLS FIRST) OVER (),
  bool_and(x%3 != 0) OVER ()
FROM t7
ORDER BY x;

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

SELECT
 (tint1 + tint2) / tint2
FROM t_using_dataflow_rendering;

-- sqlfmt-corpus-separator --

SELECT
 (tint1 + tint2) / tint2
FROM v_using_constant_folding;

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
 f1 || f4,
 UPPER(f1), LOWER(f1),
 SUBSTRING(f1, 1),
 REPLACE(f1, f2, f3),
 POSITION(f2 IN f1),
 SPLIT_PART(f1, f2, 1),
 TRANSLATE(f1, 'C', 'Z'),
 BTRIM(f1ls), LTRIM(f1ls),
 BTRIM(f1rs), RTRIM(f1rs),
 LPAD(f1, 1),
 LPAD(f1, 10),
 LPAD(f1, 10, f2),
 REGEXP_MATCH(f1, f2),
 REGEXP_MATCH(f1, f3, 'i') AS case_insensitive
FROM t_using_dataflow_rendering;

-- sqlfmt-corpus-separator --

SELECT
 f1 || f4,
 UPPER(f1), LOWER(f1),
 SUBSTRING(f1, 1),
 REPLACE(f1, f2, f3),
 POSITION(f2 IN f1),
 SPLIT_PART(f1, f2, 1),
 TRANSLATE(f1, 'C', 'Z'),
 BTRIM(f1ls), LTRIM(f1ls),
 BTRIM(f1rs), RTRIM(f1rs),
 LPAD(f1, 1),
 LPAD(f1, 10),
 LPAD(f1, 10, f2),
 REGEXP_MATCH(f1, f2),
 REGEXP_MATCH(f1, f3, 'i') AS case_insensitive
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

SELECT '          '::int[];

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

SELECT ' '::char(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::char(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaaa'::char(30);

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

SELECT '"'::int[];

-- sqlfmt-corpus-separator --

SELECT '"2"'::regclass != 2

-- sqlfmt-corpus-separator --

SELECT '"2"'::regclass::text

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56# # +   00 ?  '::timestamp with time zone;

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56# # +   00 ?#'::timestamp with time zone;

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56# +   00   '::timestamp with time zone;

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56# +   00 ?  '::timestamp with time zone;

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56#"'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56#+00"'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56#+00~"'::timestamp with time zone;

-- sqlfmt-corpus-separator --

SELECT '"2020-03-17 ~02:36:56~"'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '"2x"'::regclass::text

-- sqlfmt-corpus-separator --

SELECT '"?!?2024-02-13 17:01:58.37848 ?+  00  + '::timestamp with time zone;

-- sqlfmt-corpus-separator --

SELECT '"?!?2024-02-13 17:01:58.37848 ?+  00  - '::timestamp with time zone;

-- sqlfmt-corpus-separator --

SELECT '"?!?2024-02-13 17:01:58.37848 ?+  00  : '::timestamp with time zone;

-- sqlfmt-corpus-separator --

SELECT '"?!?2024-02-13 17:01:58.37848+  0 0'::timestamp with time zone;

-- sqlfmt-corpus-separator --

SELECT '"?!?2024-02-13 17:01:58.37848+ ? 00'::timestamp with time zone;

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

SELECT ''''::int[];

-- sqlfmt-corpus-separator --

SELECT ''::CHAR(0)

-- sqlfmt-corpus-separator --

SELECT ''::CHAR(10485761)

-- sqlfmt-corpus-separator --

SELECT ''::VARCHAR(0)

-- sqlfmt-corpus-separator --

SELECT ''::VARCHAR(10485761)

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::char(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::float4

-- sqlfmt-corpus-separator --

SELECT ''::float8

-- sqlfmt-corpus-separator --

SELECT ''::float::text

-- sqlfmt-corpus-separator --

SELECT ''::int4range;

-- sqlfmt-corpus-separator --

SELECT ''::int8range;

-- sqlfmt-corpus-separator --

SELECT ''::int[]

-- sqlfmt-corpus-separator --

SELECT ''::int[];

-- sqlfmt-corpus-separator --

SELECT ''::numrange;

-- sqlfmt-corpus-separator --

SELECT ''::pg_catalog.VARCHAR(0)

-- sqlfmt-corpus-separator --

SELECT ''::pg_catalog.VARCHAR(10485761)

-- sqlfmt-corpus-separator --

SELECT ''::pg_catalog.bpchar(0)

-- sqlfmt-corpus-separator --

SELECT ''::pg_catalog.bpchar(10485761)

-- sqlfmt-corpus-separator --

SELECT ''::pg_catalog.bytes

-- sqlfmt-corpus-separator --

SELECT ''::pg_catalog.int2vector::text

-- sqlfmt-corpus-separator --

SELECT ''::text < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaaa'::char(30);

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

SELECT ''::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaaa'::char(30);

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

SELECT '++0'::float::text

-- sqlfmt-corpus-separator --

SELECT '+.0'::float::text

-- sqlfmt-corpus-separator --

SELECT '+0'::float::text

-- sqlfmt-corpus-separator --

SELECT '+0.'::float::text

-- sqlfmt-corpus-separator --

SELECT ','::int4range;

-- sqlfmt-corpus-separator --

SELECT ','::int8range;

-- sqlfmt-corpus-separator --

SELECT ','::int[];

-- sqlfmt-corpus-separator --

SELECT ','::numrange;

-- sqlfmt-corpus-separator --

SELECT ','::tsrange;

-- sqlfmt-corpus-separator --

SELECT ','::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '--0'::float::text

-- sqlfmt-corpus-separator --

SELECT '--1'::numeric

-- sqlfmt-corpus-separator --

SELECT '-.0'::float::text

-- sqlfmt-corpus-separator --

SELECT '-0'::float::text

-- sqlfmt-corpus-separator --

SELECT '-0.'::float::text

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

SELECT '-1e308'::float - '1e308'::float

-- sqlfmt-corpus-separator --

SELECT '-2'::numeric

-- sqlfmt-corpus-separator --

SELECT '-20'::numeric

-- sqlfmt-corpus-separator --

SELECT '-2147483648'::float4::int

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

SELECT '-2147483777'::float4::int;

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

SELECT '-Inf'::double precision::text, '-Infinity'::double precision::text, '-inFinIty'::double precision::text

-- sqlfmt-corpus-separator --

SELECT '-Inf'::float::text, '-Infinity'::float::text, '-inFinIty'::float::text

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

SELECT '.0'::float::text

-- sqlfmt-corpus-separator --

SELECT '.A' LIKE '._'

-- sqlfmt-corpus-separator --

SELECT '0.'::float::text

-- sqlfmt-corpus-separator --

SELECT '0.0'::float * '1e-200'::float

-- sqlfmt-corpus-separator --

SELECT '0.0'::float / 'Inf'::float

-- sqlfmt-corpus-separator --

SELECT '0.0'::float4 * '1e-20'::float4

-- sqlfmt-corpus-separator --

SELECT '0.0'::float4 / 'Inf'::float4

-- sqlfmt-corpus-separator --

SELECT '0.0e10'::float::text

-- sqlfmt-corpus-separator --

SELECT '0.2'::numeric

-- sqlfmt-corpus-separator --

SELECT '0000-01-01'::date

-- sqlfmt-corpus-separator --

SELECT '000000.00000'::float::text

-- sqlfmt-corpus-separator --

SELECT '0001-01-01 12:00:00 +6'::TIMESTAMPTZ AT TIME ZONE '+5';

-- sqlfmt-corpus-separator --

SELECT '0001-01-01 12:00:00 -6'::TIMESTAMPTZ AT TIME ZONE '-5';

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

SELECT '01:02:03'::char(9)::time

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::text::time

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::bigint

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::boolean

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::date

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::double

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::integer

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::interval;

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::jsonb

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::numeric

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::real

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::smallint

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

SELECT '1'::bigint

-- sqlfmt-corpus-separator --

SELECT '1'::char::bigint

-- sqlfmt-corpus-separator --

SELECT '1'::char::double

-- sqlfmt-corpus-separator --

SELECT '1'::char::integer

-- sqlfmt-corpus-separator --

SELECT '1'::char::interval

-- sqlfmt-corpus-separator --

SELECT '1'::char::numeric

-- sqlfmt-corpus-separator --

SELECT '1'::char::real

-- sqlfmt-corpus-separator --

SELECT '1'::char::smallint

-- sqlfmt-corpus-separator --

SELECT '1'::dec(38,0)

-- sqlfmt-corpus-separator --

SELECT '1'::decimal(38,0)

-- sqlfmt-corpus-separator --

SELECT '1'::int

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

SELECT '1'::integer

-- sqlfmt-corpus-separator --

SELECT '1'::interval::bigint

-- sqlfmt-corpus-separator --

SELECT '1'::interval::boolean

-- sqlfmt-corpus-separator --

SELECT '1'::interval::date

-- sqlfmt-corpus-separator --

SELECT '1'::interval::double

-- sqlfmt-corpus-separator --

SELECT '1'::interval::integer

-- sqlfmt-corpus-separator --

SELECT '1'::interval::interval;

-- sqlfmt-corpus-separator --

SELECT '1'::interval::jsonb

-- sqlfmt-corpus-separator --

SELECT '1'::interval::numeric

-- sqlfmt-corpus-separator --

SELECT '1'::interval::real

-- sqlfmt-corpus-separator --

SELECT '1'::interval::smallint

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

SELECT '1'::jsonb::bigint;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::boolean;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::double;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::integer;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::jsonb;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::numeric;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::smallint;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::text;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::varchar;

-- sqlfmt-corpus-separator --

SELECT '1'::materialize.pg_catalog.int4

-- sqlfmt-corpus-separator --

SELECT '1'::numeric(38,0)

-- sqlfmt-corpus-separator --

SELECT '1'::numrange;

-- sqlfmt-corpus-separator --

SELECT '1'::oid

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.bigint

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.dec(38,0)

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.decimal(38,0)

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.int

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.int2

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.int2vector::text

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.int4

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.int8

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.integer

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.numeric(38,0)

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.oid

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.pg_enum

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.regclass

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.regproc

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.regtype

-- sqlfmt-corpus-separator --

SELECT '1'::pg_catalog.smallint

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

SELECT '1'::smallint

-- sqlfmt-corpus-separator --

SELECT '1'::text::bigint

-- sqlfmt-corpus-separator --

SELECT '1'::text::double

-- sqlfmt-corpus-separator --

SELECT '1'::text::int2vector::text

-- sqlfmt-corpus-separator --

SELECT '1'::text::integer

-- sqlfmt-corpus-separator --

SELECT '1'::text::interval

-- sqlfmt-corpus-separator --

SELECT '1'::text::numeric

-- sqlfmt-corpus-separator --

SELECT '1'::text::real

-- sqlfmt-corpus-separator --

SELECT '1'::text::smallint

-- sqlfmt-corpus-separator --

SELECT '1'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '1'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::bigint

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::double

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::integer

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::interval

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::numeric

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::real

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::smallint

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

SELECT '1.2'::float(1)

-- sqlfmt-corpus-separator --

SELECT '1.2'::float(53)

-- sqlfmt-corpus-separator --

SELECT '1.2'::float4

-- sqlfmt-corpus-separator --

SELECT '1.2'::float8

-- sqlfmt-corpus-separator --

SELECT '1.2'::pg_catalog.double

-- sqlfmt-corpus-separator --

SELECT '1.2'::pg_catalog.float(1)

-- sqlfmt-corpus-separator --

SELECT '1.2'::pg_catalog.float(53)

-- sqlfmt-corpus-separator --

SELECT '1.2'::pg_catalog.float4

-- sqlfmt-corpus-separator --

SELECT '1.2'::pg_catalog.float8

-- sqlfmt-corpus-separator --

SELECT '1.2'::pg_catalog.real

-- sqlfmt-corpus-separator --

SELECT '1.2'::real

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

SELECT '1e-300'::float * '0.0'::float

-- sqlfmt-corpus-separator --

SELECT '1e-300'::float * '1e-200'::float

-- sqlfmt-corpus-separator --

SELECT '1e-300'::float / '0.0'::float

-- sqlfmt-corpus-separator --

SELECT '1e-300'::float / '1e30'::float

-- sqlfmt-corpus-separator --

SELECT '1e-300'::float / 'Inf'::float

-- sqlfmt-corpus-separator --

SELECT '1e-307'::float8::numeric

-- sqlfmt-corpus-separator --

SELECT '1e200'::float * '-Inf'::float

-- sqlfmt-corpus-separator --

SELECT '1e30'::float4 * '-Inf'::float4

-- sqlfmt-corpus-separator --

SELECT '1e30'::float4 * '1e10'::float4

-- sqlfmt-corpus-separator --

SELECT '1e30'::float4 / '1e-20'::float4

-- sqlfmt-corpus-separator --

SELECT '1e300'::float

-- sqlfmt-corpus-separator --

SELECT '1e300'::float * '1e200'::float

-- sqlfmt-corpus-separator --

SELECT '1e300'::float / '1e-30'::float

-- sqlfmt-corpus-separator --

SELECT '1e308'::float + '-Inf'::float

-- sqlfmt-corpus-separator --

SELECT '1e308'::float + '1e308'::float

-- sqlfmt-corpus-separator --

SELECT '1e308'::float - '-Inf'::float

-- sqlfmt-corpus-separator --

SELECT '1x25'::numeric

-- sqlfmt-corpus-separator --

SELECT '2'::JSONB->'b','[1,2,3]'::JSONB->'0'

-- sqlfmt-corpus-separator --

SELECT '2'::JSONB->>'b','[1,2,3]'::JSONB->>'0'

-- sqlfmt-corpus-separator --

SELECT '2'::jsonb::real;

-- sqlfmt-corpus-separator --

SELECT '2'::numeric

-- sqlfmt-corpus-separator --

SELECT '2'::regclass

-- sqlfmt-corpus-separator --

SELECT '2'::text::regclass

-- sqlfmt-corpus-separator --

SELECT '20'::numeric

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::char(10)::timestamp

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::char(10)::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::char(11)::date

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::bigint

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::boolean

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::date;

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::double

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::integer

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::interval

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::jsonb

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::numeric

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::real

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::smallint

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

SELECT '2002 03-04'::timestamp::bigint

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::boolean

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::date;

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::double

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::integer

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::interval

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::jsonb

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::numeric

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::real

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::smallint

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

SELECT '2003 04-05'::timestamptz::bigint

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::boolean

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::date;

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::double

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::integer

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::interval

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::jsonb

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::numeric

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::real

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::smallint

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

SELECT '2007-02-01 15:04:05'::pg_catalog.timestamptz

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

SELECT '2007-02-01'::pg_catalog.date

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

SELECT '2147483583'::float4::int;

-- sqlfmt-corpus-separator --

SELECT '2147483647'::float4::int4

-- sqlfmt-corpus-separator --

SELECT '2147483647.4'::float8::int4;

-- sqlfmt-corpus-separator --

SELECT '2147483647.6'::float8::int4

-- sqlfmt-corpus-separator --

SELECT '2147483648'::float4::int

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

SELECT '3.4'::numeric UNION SELECT 'foo'

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

SELECT '63616665-6630-3064-6465-616462656568'::pg_catalog.uuid

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

SELECT 'Inf'::double precision::text, 'Infinity'::double precision::text, 'inFinIty'::double precision::text, '+inf'::double precision::text, '+infinity'::double precision::text

-- sqlfmt-corpus-separator --

SELECT 'Inf'::float * '1e200'::float

-- sqlfmt-corpus-separator --

SELECT 'Inf'::float + '1e308'::float

-- sqlfmt-corpus-separator --

SELECT 'Inf'::float - '1e308'::float

-- sqlfmt-corpus-separator --

SELECT 'Inf'::float / '1e-30'::float

-- sqlfmt-corpus-separator --

SELECT 'Inf'::float4 * '1e10'::float4

-- sqlfmt-corpus-separator --

SELECT 'Inf'::float4 + '3e38'::float4

-- sqlfmt-corpus-separator --

SELECT 'Inf'::float4 - '3e38'::float4

-- sqlfmt-corpus-separator --

SELECT 'Inf'::float4 / '1e-20'::float4

-- sqlfmt-corpus-separator --

SELECT 'Inf'::float::text, 'Infinity'::float::text, 'inFinIty'::float::text, '+inf'::float::text, '+infinity'::float::text

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

SELECT 'NaN'::FLOAT::DECIMAL, 'NaN'::DECIMAL

-- sqlfmt-corpus-separator --

SELECT 'NaN'::decimal, '-NaN'::decimal, 'sNaN'::decimal, '-sNaN'::decimal

-- sqlfmt-corpus-separator --

SELECT 'NaN'::double precision::text, 'nan'::double precision::text, 'nAN'::double precision::text

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float4::numeric, '-NaN'::float4::numeric;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float4::text

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float8::numeric, '-NaN'::float8::numeric;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float8::text

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float::text, 'nan'::float::text, 'nAN'::float::text

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

SELECT '[1:2]={1,2}'::int[]

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

SELECT '\"\"2024-02-13 17:01:58.37848+00\"\"\"'::timestamp with time zone;

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

SELECT 'a '::char(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::char(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaaa'::char(30);

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

SELECT 'a' LIKE 'a' ESCAPE 'foo'

-- sqlfmt-corpus-separator --

SELECT 'a' LIKE 'a_'

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::char;

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::varchar;

-- sqlfmt-corpus-separator --

SELECT 'a'::bytea

-- sqlfmt-corpus-separator --

SELECT 'a'::bytes

-- sqlfmt-corpus-separator --

SELECT 'a'::char(10) ILIKE 'a'

-- sqlfmt-corpus-separator --

SELECT 'a'::char(10) LIKE 'a'

-- sqlfmt-corpus-separator --

SELECT 'a'::char(10) NOT ILIKE 'a'

-- sqlfmt-corpus-separator --

SELECT 'a'::char(10) NOT LIKE 'a'

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::char(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::character = 'a'::"char";

-- sqlfmt-corpus-separator --

SELECT 'a'::int2vector::text

-- sqlfmt-corpus-separator --

SELECT 'a'::int[];

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

SELECT 'a'::pg_catalog.bytea

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaaa'::char(30);

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

SELECT 'aaaaa '::char(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::char(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::char(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::char(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ' '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ' '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ' '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ''::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ''::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ''::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa '::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa '::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa '::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaaa'::text;

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaaa'::varchar(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaaa'::varchar(30);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) !~ 'Abc'::char(4);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) NOT ILIKE 'Abc'::char(4);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char::"char";

-- sqlfmt-corpus-separator --

SELECT 'abc'::text::"char";

-- sqlfmt-corpus-separator --

SELECT 'abc'::varchar::"char";

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

SELECT 'ba%a!' LIKE 'ban%na!' ESCAPE 'n'

-- sqlfmt-corpus-separator --

SELECT 'baaa' LIKE '%%%%a'

-- sqlfmt-corpus-separator --

SELECT 'baaa' LIKE '%a'

-- sqlfmt-corpus-separator --

SELECT 'bad' LIKE '%a'

-- sqlfmt-corpus-separator --

SELECT 'ban%na!' LIKE 'ban%%%na!' ESCAPE '%'

-- sqlfmt-corpus-separator --

SELECT 'ban\ana!' LIKE 'ban\ana!' ESCAPE ''

-- sqlfmt-corpus-separator --

SELECT 'banana!' LIKE 'ba\n%na!' ESCAPE '\'

-- sqlfmt-corpus-separator --

SELECT 'banana!' LIKE 'ban%%%na!' ESCAPE '%'

-- sqlfmt-corpus-separator --

SELECT 'banana!' LIKE 'ban%na!' ESCAPE 'n'

-- sqlfmt-corpus-separator --

SELECT 'banana!' LIKE 'ban\ana!' ESCAPE ''

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

SELECT 'dog'::char(3)

-- sqlfmt-corpus-separator --

SELECT 'dog'::char(3)::text;

-- sqlfmt-corpus-separator --

SELECT 'dog'::char(3)::varchar;

-- sqlfmt-corpus-separator --

SELECT 'dog'::pg_catalog.bpchar(3)

-- sqlfmt-corpus-separator --

SELECT 'dog'::pg_catalog.char(3)

-- sqlfmt-corpus-separator --

SELECT 'dog'::pg_catalog.text

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

SELECT 'e'::float::text

-- sqlfmt-corpus-separator --

SELECT 'e10'::float::text

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

SELECT 'foo'::text < 5::int;

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

SELECT 'm'::regclass::oid::int

-- sqlfmt-corpus-separator --

SELECT 'materialize.public.t'::regclass::oid::int

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

SELECT 'not test' = ANY (current_schemas(true))

-- sqlfmt-corpus-separator --

SELECT 'now'::regproc

-- sqlfmt-corpus-separator --

SELECT 'now'::regproc::oid

-- sqlfmt-corpus-separator --

SELECT 'now'::regproc::text

-- sqlfmt-corpus-separator --

SELECT 'public' = ANY (current_schemas(true))

-- sqlfmt-corpus-separator --

SELECT 'public.t'::regclass::text;

-- sqlfmt-corpus-separator --

SELECT 'public.t'::regtype::text;

-- sqlfmt-corpus-separator --

SELECT 'quote_ident'::regclass::text;

-- sqlfmt-corpus-separator --

SELECT 'quote_ident'::regproc::text;

-- sqlfmt-corpus-separator --

SELECT 'result' || chr(10) || 'with' || chr(10) || 'newline', 'no newline in this one, but there are spaces'
UNION
SELECT 'one' || chr(10) || 'more' || chr(10) || 'row (with spaces)', 'easy'

-- sqlfmt-corpus-separator --

SELECT 's.m'::regclass::oid::int

-- sqlfmt-corpus-separator --

SELECT 's.t'::regclass::oid::int

-- sqlfmt-corpus-separator --

SELECT 's.t'::regclass::text;

-- sqlfmt-corpus-separator --

SELECT 's.t'::regtype::oid::int

-- sqlfmt-corpus-separator --

SELECT 's.t'::regtype::text;

-- sqlfmt-corpus-separator --

SELECT 'sNaN'::numeric

-- sqlfmt-corpus-separator --

SELECT 't' LIKE '_o'

-- sqlfmt-corpus-separator --

SELECT 't'::regclass = 's.t'::regclass

-- sqlfmt-corpus-separator --

SELECT 't'::regclass::oid::int

-- sqlfmt-corpus-separator --

SELECT 't'::regclass::text;

-- sqlfmt-corpus-separator --

SELECT 't'::regtype = 's.t'::regtype

-- sqlfmt-corpus-separator --

SELECT 't'::regtype::oid::int

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

SELECT 'true'::boolean

-- sqlfmt-corpus-separator --

SELECT 'true'::char(4)::boolean

-- sqlfmt-corpus-separator --

SELECT 'true'::pg_catalog.bool

-- sqlfmt-corpus-separator --

SELECT 'true'::pg_catalog.boolean

-- sqlfmt-corpus-separator --

SELECT 'true'::text::boolean

-- sqlfmt-corpus-separator --

SELECT 'true'::universe.database.schema.bool

-- sqlfmt-corpus-separator --

SELECT 'true'::varchar::boolean

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

SELECT '{  1,   2  , 3 }'::int[]

-- sqlfmt-corpus-separator --

SELECT '{  a}}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{  {a}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{ "name": "Bob", "tags": [ "enim", "qui"]}'::JSONB @> '{"tags":["qu"]}'

-- sqlfmt-corpus-separator --

SELECT '{" ",}'::int[];

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

SELECT '{"1":2,"3":4}'::pg_catalog.json

-- sqlfmt-corpus-separator --

SELECT '{"1":2,"3":4}'::pg_catalog.jsonb

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

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> null::int;

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> null::text;

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> '';

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> 'z';

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> 1;

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> null::int;

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

SELECT '{'',}'::int[];

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

SELECT '{'::int[];

-- sqlfmt-corpus-separator --

SELECT '{'::numrange;

-- sqlfmt-corpus-separator --

SELECT '{'::tsrange;

-- sqlfmt-corpus-separator --

SELECT '{'::tstzrange;

-- sqlfmt-corpus-separator --

SELECT '{," "}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{,''}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{,1}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{,}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{1, 2, 3, NULL}'::numeric[] @> '{1, NULL}'::numeric[];

-- sqlfmt-corpus-separator --

SELECT '{1, 2, 3, null, NULL, nULL}'::int[]

-- sqlfmt-corpus-separator --

SELECT '{1, 2, 3} 4'::int[]

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

SELECT '{1,2}'::public.bool::text;

-- sqlfmt-corpus-separator --

SELECT '{1,}'::int[];

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

SELECT '{a=>1}'::public.bool::text;

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

SELECT '{a}}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{null, {1}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{o, oOOo, "oOOo", "}"}'::text[]

-- sqlfmt-corpus-separator --

SELECT '{true}'::bool_list_c::text

-- sqlfmt-corpus-separator --

SELECT '{{  }'::int[];

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

SELECT '{{1}, {2}}'::int[]

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

SELECT '{{a}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{{{1}},{2}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{{null}},{{}}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{{{{{{7}}}}}}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{{{{{{{7}}}}}}}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{{{}},{}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{{},{1}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{},{{}}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{{}{}}'::text[];

-- sqlfmt-corpus-separator --

SELECT '{}  }'::int[];

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

SELECT '{}'::jsonb::bigint;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::boolean;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::date

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::double;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::integer;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::interval

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::jsonb;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::numeric;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::real;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::smallint;

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

SELECT '{}}'::int[];

-- sqlfmt-corpus-separator --

SELECT '}'::int[];

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

SELECT ('"-Infinity"'::jsonb)::float;

-- sqlfmt-corpus-separator --

SELECT ('"-Infinity"'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('"1"'::jsonb)::float;

-- sqlfmt-corpus-separator --

SELECT ('"1"'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('"1-2 3 4:5:6.7"'::jsonb)::interval;

-- sqlfmt-corpus-separator --

SELECT ('"1969-06-01 10:10:10.410"'::jsonb)::timestamp;

-- sqlfmt-corpus-separator --

SELECT ('"Infinity"'::jsonb)::float;

-- sqlfmt-corpus-separator --

SELECT ('"Infinity"'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('"NaN"'::jsonb)::float;

-- sqlfmt-corpus-separator --

SELECT ('"NaN"'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('1 2'::int2vector || '{3}'::int2[])::text;

-- sqlfmt-corpus-separator --

SELECT ('1'::jsonb)::float;

-- sqlfmt-corpus-separator --

SELECT ('1'::jsonb)::int;

-- sqlfmt-corpus-separator --

SELECT ('1'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('1.2'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('24:00:00'::TIME)::STRING

-- sqlfmt-corpus-separator --

SELECT ('42'::float4 / 'Infinity'::float4)::text

-- sqlfmt-corpus-separator --

SELECT ('4714-11-24 BC'::date + 1)::string, ('5874897-12-31'::date - 1)::string

-- sqlfmt-corpus-separator --

SELECT ('9999999999999999999'::jsonb)::int;

-- sqlfmt-corpus-separator --

SELECT ('Infinity'::float4 + 100.0)::text

-- sqlfmt-corpus-separator --

SELECT ('Infinity'::float4 / 'Infinity'::float4)::text

-- sqlfmt-corpus-separator --

SELECT ('Infinity'::float8 + 100.0)::text

-- sqlfmt-corpus-separator --

SELECT ('Infinity'::float8 / 'Infinity'::float8)::text

-- sqlfmt-corpus-separator --

SELECT ('["2019-12-31"]'::jsonb)::date;

-- sqlfmt-corpus-separator --

SELECT ('[1]'::jsonb)::float;

-- sqlfmt-corpus-separator --

SELECT ('[1]'::jsonb)::int;

-- sqlfmt-corpus-separator --

SELECT ('[1]'::jsonb)::numeric;

-- sqlfmt-corpus-separator --

SELECT ('nan'::float4 / '0'::float4)::text

-- sqlfmt-corpus-separator --

SELECT ('nan'::float4 / 'nan'::float4)::text

-- sqlfmt-corpus-separator --

SELECT ('nan'::float8 / '0'::float8)::text

-- sqlfmt-corpus-separator --

SELECT ('nan'::float8 / 'nan'::float8)::text

-- sqlfmt-corpus-separator --

SELECT ('null'::jsonb)->>0;

-- sqlfmt-corpus-separator --

SELECT ('null'::jsonb)::text;

-- sqlfmt-corpus-separator --

SELECT ('{1,2}'::int2[] || '3'::int2vector)::text;

-- sqlfmt-corpus-separator --

SELECT ('{1.2,2.3}'::numeric_list_c)::text;

-- sqlfmt-corpus-separator --

SELECT ('{1}'::int4_list || 2)::text;

-- sqlfmt-corpus-separator --

SELECT ('{1}'::int4_list_c || 2)::text;

-- sqlfmt-corpus-separator --

SELECT ('{1}'::int4_list_too || '{2}'::int4_list::int4_list_too)::text;

-- sqlfmt-corpus-separator --

SELECT ('{{1}}'::int4_list_list || '{2}'::int4_list)::text;

-- sqlfmt-corpus-separator --

SELECT ('{{1}}'::int4_list_list_too || '{{2}}'::int4_list_list::int4_list_list_too)::text;

-- sqlfmt-corpus-separator --

SELECT (((SELECT 2)) UNION SELECT 2);

-- sqlfmt-corpus-separator --

SELECT ((SELECT 2) UNION SELECT 2)

-- sqlfmt-corpus-separator --

SELECT (-1)::int8::oid

-- sqlfmt-corpus-separator --

SELECT (-1)::oid

-- sqlfmt-corpus-separator --

SELECT (-1)::oid < 2::oid

-- sqlfmt-corpus-separator --

SELECT (-1)::smallint::text, (-1)::bigint::text, (-1.0)::text, (-1.0)::float::text, (-1.0)::double::text

-- sqlfmt-corpus-separator --

SELECT (-6734743351254754)::bigint * (-99783359317598)::bigint

-- sqlfmt-corpus-separator --

SELECT (0.12 * 0.2)::numeric(39,1);

-- sqlfmt-corpus-separator --

SELECT (0.12 * 0.2)::numeric(39,3);

-- sqlfmt-corpus-separator --

SELECT (0.12 + 0.2)::numeric(39,1);

-- sqlfmt-corpus-separator --

SELECT (0.12 + 0.2)::numeric(39,3);

-- sqlfmt-corpus-separator --

SELECT (0.14 * 0.2)::numeric(39,2);

-- sqlfmt-corpus-separator --

SELECT (1 || '{2}'::int4_list_c)::text;

-- sqlfmt-corpus-separator --

SELECT (1.4238790346995263e-40::DECIMAL / 6.011482313728436e+41::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT (1/0 > 0) AND (32768::int2 > 0);

-- sqlfmt-corpus-separator --

SELECT (1/0 > 0) OR (32768::int2 > 0);

-- sqlfmt-corpus-separator --

SELECT (1234567890123456789.012345 * 1234567890123456789.012345)::numeric(39,3);

-- sqlfmt-corpus-separator --

SELECT (12345678901234567890::numeric(39,3) * 12345678901234567890::numeric(39,3))::numeric(39,3);

-- sqlfmt-corpus-separator --

SELECT (32768::int2 > 0) AND (1/0 > 0);

-- sqlfmt-corpus-separator --

SELECT (32768::int2 > 0) OR (1/0 > 0);

-- sqlfmt-corpus-separator --

SELECT (5 + 3)::text;

-- sqlfmt-corpus-separator --

SELECT (999999999999999999999999999999999999.123 + 1::numeric)::numeric(39,3);

-- sqlfmt-corpus-separator --

SELECT (CAST(-6734743351254754 AS bigint) * CAST(-99783359317598 AS bigint))

-- sqlfmt-corpus-separator --

SELECT (DATE '2000-01-01')::text

-- sqlfmt-corpus-separator --

SELECT (INTERVAL '1-3' YEAR TO MONTH)::text

-- sqlfmt-corpus-separator --

SELECT (SELECT 1) IN (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT (SELECT DISTINCT ON (a) a FROM abc ORDER BY a, b||'foo') || 'bar';

-- sqlfmt-corpus-separator --

SELECT (TIMESTAMP '2000-01-01 00:00:00')::text

-- sqlfmt-corpus-separator --

SELECT (TIMESTAMPTZ '2000-01-01 00:00:00-6')::text

-- sqlfmt-corpus-separator --

SELECT (avg(k) * 2.0 + max(v)::DECIMAL)::FLOAT FROM kv

-- sqlfmt-corpus-separator --

SELECT (avg(k) * 2.0 + max(v)::DECIMAL)::FLOAT FROM kv WHERE w*2 = k

-- sqlfmt-corpus-separator --

SELECT (date '2007-02-01')::text

-- sqlfmt-corpus-separator --

SELECT (interval '-1' day + interval '1' day) = (interval '1' day + interval '-1' day)

-- sqlfmt-corpus-separator --

SELECT (interval '-1-2 3 -4:5:6.7')::text;

-- sqlfmt-corpus-separator --

SELECT (list_agg(a ORDER BY a) FILTER (WHERE b > '2050-01-01'))::text FROM t2

-- sqlfmt-corpus-separator --

SELECT (list_append(NULL, 1))::text

-- sqlfmt-corpus-separator --

SELECT (list_append(NULL, NULL::INT))::text

-- sqlfmt-corpus-separator --

SELECT (map_agg(a::TEXT, a) FILTER (WHERE a = 1))::TEXT FROM t1

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

SELECT *
FROM c
WHERE
    'CA' IN (SELECT ship FROM o WHERE o.c_id=c.c_id)
    AND 'TX' NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT *
FROM c
WHERE
    'WY' IN (SELECT ship FROM o WHERE o.c_id=c.c_id)
    OR 'WA' IN (SELECT ship FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT *
FROM c
WHERE
    EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id)
    OR NOT EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT *
FROM c
WHERE
    bill = ALL(SELECT ship FROM o WHERE o.c_id=c.c_id)
    AND EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT *
FROM c
WHERE
    bill = ALL(SELECT ship FROM o WHERE o.c_id=c.c_id)
    OR EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id AND ship='WY');

-- sqlfmt-corpus-separator --

SELECT *
FROM c
WHERE (SELECT min(ship) FROM o WHERE o.c_id=c.c_id) IN (SELECT ship FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT * FROM a UNION ALL SELECT * FROM b

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a < ALL(SELECT a FROM abc WHERE a >= 2)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a < ALL(SELECT a FROM abc)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a < ANY(SELECT a FROM abc WHERE b = 30) ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a > ANY(SELECT a FROM abc WHERE b = 30)

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE 'WY' IN (SELECT ship FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id AND c.bill='TX');

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE NOT EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE bill < ANY(SELECT ship FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE bill = ALL(SELECT ship FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE bill > ANY(SELECT ship FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE bill IN (SELECT ship FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE bill NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT * FROM dateish WHERE a != DATE '1999-12-31' + INTERVAL '1' DAY

-- sqlfmt-corpus-separator --

SELECT * FROM dateish WHERE a != DATE '1999-12-31' + INTERVAL '2' DAY

-- sqlfmt-corpus-separator --

SELECT * FROM dateish WHERE a < DATE '1999-01-01' + INTERVAL '2' YEAR

-- sqlfmt-corpus-separator --

SELECT * FROM dateish WHERE a <= DATE '1999-01-01' + INTERVAL '2' YEAR

-- sqlfmt-corpus-separator --

SELECT * FROM dateish WHERE a <= DATE '1999-12-31' + INTERVAL '2' DAY

-- sqlfmt-corpus-separator --

SELECT * FROM dateish WHERE a = DATE '1999-12-31' + INTERVAL '1' DAY

-- sqlfmt-corpus-separator --

SELECT * FROM dateish WHERE a > DATE '1999-01-01' + INTERVAL '2' YEAR

-- sqlfmt-corpus-separator --

SELECT * FROM dateish WHERE a >= DATE '1999-01-01' + INTERVAL '2' YEAR

-- sqlfmt-corpus-separator --

SELECT * FROM dateish WHERE a >= DATE '1999-12-31' + INTERVAL '2' DAY

-- sqlfmt-corpus-separator --

SELECT * FROM kv GROUP BY v, count(DISTINCT w)

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE k IN (SELECT k FROM kv)

-- sqlfmt-corpus-separator --

SELECT * FROM not_allowed_tests GROUP BY v, count(w) OVER ();

-- sqlfmt-corpus-separator --

SELECT * FROM s WHERE d = 'inf'::decimal

-- sqlfmt-corpus-separator --

SELECT * FROM squares
WHERE x IN (
    SELECT y FROM roots
    WHERE y IN (
        SELECT squares.y
    )
);

-- sqlfmt-corpus-separator --

SELECT * FROM squares
WHERE x IN (
    WITH squares_y AS (
        SELECT squares.y
    )
    SELECT y FROM roots
    WHERE y IN (
        SELECT y FROM squares_y
    )
);

-- sqlfmt-corpus-separator --

SELECT * FROM t
WHERE row_number() over () > 1;

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE a = '2015-08-25 04:45:45.53453+01:00'::timestamp

-- sqlfmt-corpus-separator --

SELECT * FROM t1
WHERE ((b = 'l1' AND a = 1) OR (a = 2 AND b = 'l2')) AND (b like 'nonono' OR (b like 'l%' AND a < 10))

-- sqlfmt-corpus-separator --

SELECT * FROM t1 EXCEPT ALL SELECT * FROM t1

-- sqlfmt-corpus-separator --

SELECT * FROM t1 EXCEPT ALL SELECT * FROM t1 UNION ALL SELECT * FROM t1

-- sqlfmt-corpus-separator --

SELECT * FROM t1 UNION ALL SELECT * FROM t1 EXCEPT ALL SELECT * FROM t1

-- sqlfmt-corpus-separator --

SELECT * FROM t1 UNION ALL SELECT * FROM t2 EXCEPT ALL SELECT * FROM t1

-- sqlfmt-corpus-separator --

SELECT * FROM t1 WHERE f1 = 0 and (f1 = 0 or f1 = 1)

-- sqlfmt-corpus-separator --

SELECT * FROM t1, t2 WHERE a = b AND age(b, TIMESTAMPTZ '2017-01-01') > INTERVAL '1 day'

-- sqlfmt-corpus-separator --

SELECT * FROM t2  EXCEPT ALL SELECT * FROM t1 INTERSECT ALL SELECT * FROM t3;

-- sqlfmt-corpus-separator --

SELECT * FROM t2 EXCEPT ALL (SELECT * FROM t1 INTERSECT ALL SELECT f1, null::int FROM t3);

-- sqlfmt-corpus-separator --

SELECT * FROM t2 EXCEPT ALL SELECT * FROM t1 UNION ALL SELECT * FROM t1

-- sqlfmt-corpus-separator --

SELECT * FROM t2 UNION ALL SELECT * FROM t1 EXCEPT ALL SELECT * FROM t1

-- sqlfmt-corpus-separator --

SELECT * FROM t3 WHERE NOT (((t3.c0)::INT != 0));

-- sqlfmt-corpus-separator --

SELECT * FROM t3 WHERE t3.c0 = 0.8::INT OR t3.c0 = -0.1;

-- sqlfmt-corpus-separator --

SELECT * FROM t_data
WHERE f1 ILIKE '%bCd%'
ORDER BY f1;

-- sqlfmt-corpus-separator --

SELECT * FROM t_data
WHERE f1 ILIKE (SELECT op_val FROM t_operator)
ORDER BY f1;

-- sqlfmt-corpus-separator --

SELECT * FROM t_using_dataflow_rendering
UNION ALL
SELECT SUM(real1), SUM(double1), SUM(numeric1)
FROM t_using_dataflow_rendering;

-- sqlfmt-corpus-separator --

SELECT * FROM v_using_constant_folding
UNION ALL
SELECT SUM(real1), SUM(double1), SUM(numeric1)
FROM v_using_constant_folding;

-- sqlfmt-corpus-separator --

SELECT * FROM x WHERE a IN
  (WITH t AS (SELECT * FROM y WHERE a < 3) SELECT * FROM t)

-- sqlfmt-corpus-separator --

SELECT * FROM x WHERE a IN
  (WITH t AS (SELECT * FROM y WHERE y.a = x.a) SELECT * FROM t);

-- sqlfmt-corpus-separator --

SELECT * FROM xyz WHERE x = (SELECT max(x) FROM xyz WHERE EXISTS(SELECT * FROM xyz WHERE z=x+3))

-- sqlfmt-corpus-separator --

SELECT * FROM xyz WHERE x IN (SELECT crdb_internal.force_error('', 'subqueryfail'))

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT (random() * 0.0)::int OFFSET (random() * 0.0)::int

-- sqlfmt-corpus-separator --

SELECT *, 'fy2023' AS origin FROM dev_fy2023.count_by_day
UNION ALL
SELECT *, 'warm' AS origin FROM dev_warm.count_by_day
ORDER BY day DESC;

-- sqlfmt-corpus-separator --

SELECT *, EXISTS(
  SELECT * FROM likes WHERE likee = likes.liker
) FROM likes

-- sqlfmt-corpus-separator --

SELECT *, EXISTS(
  SELECT * FROM likes as likes2 WHERE likee = likes2.liker
) FROM likes

-- sqlfmt-corpus-separator --

SELECT *, EXISTS(
  SELECT * FROM likes as likes2 WHERE likes.likee = likes2.liker
) FROM likes

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

SELECT -12.0::float::uint2

-- sqlfmt-corpus-separator --

SELECT -12.0::float::uint4

-- sqlfmt-corpus-separator --

SELECT -12.0::float::uint8

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

SELECT -7::numeric::int, -7.3::int, -7.5::int

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

SELECT 0, -0, 0::int, -0::int, '0'::int, '-0'::int

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

SELECT 0::bigint::bool

-- sqlfmt-corpus-separator --

SELECT 0::int::bool

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

SELECT 0::numeric::int, '-0'::numeric::int

-- sqlfmt-corpus-separator --

SELECT 0::numeric::int8, -0::numeric::int8

-- sqlfmt-corpus-separator --

SELECT 0::oid < 4294967295::oid

-- sqlfmt-corpus-separator --

SELECT 1 % CAST (0.0 AS float)

-- sqlfmt-corpus-separator --

SELECT 1 + CAST ('5' AS double precision)

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

SELECT 1 / CAST (0.0 AS float)

-- sqlfmt-corpus-separator --

SELECT 1 < ALL(SELECT * FROM nullary)

-- sqlfmt-corpus-separator --

SELECT 1 < ALL(SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT 1 <= 2::oid

-- sqlfmt-corpus-separator --

SELECT 1 = ALL(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 AS one UNION SELECT 1 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS one UNION SELECT 1.0::float8 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS one WHERE 1 IN (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 AS three UNION SELECT 2 UNION ALL SELECT 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS three UNION SELECT 2 UNION SELECT 3 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS two UNION ALL SELECT 1

-- sqlfmt-corpus-separator --

SELECT 1 AS two UNION ALL SELECT 2

-- sqlfmt-corpus-separator --

SELECT 1 AS two UNION SELECT 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS two UNION SELECT 2 UNION SELECT 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS two UNION SELECT 2.2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS zero WHERE 1 IN (SELECT 2)

-- sqlfmt-corpus-separator --

SELECT 1 AS zero WHERE 1 NOT IN (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 EXCEPT SELECT '3'

-- sqlfmt-corpus-separator --

SELECT 1 FROM kv GROUP BY v, w::DECIMAL HAVING w::DECIMAL > 1

-- sqlfmt-corpus-separator --

SELECT 1 FROM not_allowed_tests GROUP BY 1 HAVING sum(1) OVER (PARTITION BY 1) > 1;

-- sqlfmt-corpus-separator --

SELECT 1 IN ((((SELECT 1))))

-- sqlfmt-corpus-separator --

SELECT 1 IN (SELECT '1');

-- sqlfmt-corpus-separator --

SELECT 1 IN (SELECT 'a')

-- sqlfmt-corpus-separator --

SELECT 1 IN (SELECT * FROM tb LIMIT 0)

-- sqlfmt-corpus-separator --

SELECT 1 IN (SELECT 1 AS a, 2 AS b)

-- sqlfmt-corpus-separator --

SELECT 1 IN (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 IN (SELECT x FROM xyz ORDER BY x DESC)

-- sqlfmt-corpus-separator --

SELECT 1 INTERSECT SELECT '3'

-- sqlfmt-corpus-separator --

SELECT 1 UNION SELECT '3'

-- sqlfmt-corpus-separator --

SELECT 1 UNION SELECT 3 ORDER BY z

-- sqlfmt-corpus-separator --

SELECT 1 in (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1, 2 EXCEPT SELECT 3

-- sqlfmt-corpus-separator --

SELECT 1, 2 INTERSECT SELECT 3

-- sqlfmt-corpus-separator --

SELECT 1, 2 UNION SELECT 3

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

SELECT 1.0::float8 AS two UNION ALL SELECT 1 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1 AS three UNION SELECT 2 UNION ALL SELECT 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1 AS three UNION SELECT 2 UNION SELECT 3 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1 AS two UNION (SELECT 2 UNION ALL SELECT 2) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1 AS two UNION ALL SELECT 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1 AS two UNION SELECT 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1 AS two UNION SELECT 2.2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1::float8 AS two UNION SELECT 2 UNION SELECT 2.0::float8 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::bigint;

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::boolean

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::date

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::double;

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::integer;

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::interval

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::jsonb

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::real;

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::smallint;

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

SELECT 1.1::text, 1.1::float::text, 1.1::double::text

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

SELECT 1.234567890123456789::float, round(1.234567890123456789::float, 15), round(1.234567890123456789::float, 16), round(1.234567890123456789::float, 17)

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

SELECT 1.2::double::bigint;

-- sqlfmt-corpus-separator --

SELECT 1.2::double::boolean

-- sqlfmt-corpus-separator --

SELECT 1.2::double::date

-- sqlfmt-corpus-separator --

SELECT 1.2::double::double;

-- sqlfmt-corpus-separator --

SELECT 1.2::double::integer;

-- sqlfmt-corpus-separator --

SELECT 1.2::double::interval

-- sqlfmt-corpus-separator --

SELECT 1.2::double::jsonb;

-- sqlfmt-corpus-separator --

SELECT 1.2::double::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.2::double::real;

-- sqlfmt-corpus-separator --

SELECT 1.2::double::smallint;

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

SELECT 1.3::real::bigint;

-- sqlfmt-corpus-separator --

SELECT 1.3::real::boolean

-- sqlfmt-corpus-separator --

SELECT 1.3::real::date

-- sqlfmt-corpus-separator --

SELECT 1.3::real::double;

-- sqlfmt-corpus-separator --

SELECT 1.3::real::integer;

-- sqlfmt-corpus-separator --

SELECT 1.3::real::interval

-- sqlfmt-corpus-separator --

SELECT 1.3::real::numeric;

-- sqlfmt-corpus-separator --

SELECT 1.3::real::real;

-- sqlfmt-corpus-separator --

SELECT 1.3::real::smallint;

-- sqlfmt-corpus-separator --

SELECT 1.3::real::text;

-- sqlfmt-corpus-separator --

SELECT 1.3::real::time

-- sqlfmt-corpus-separator --

SELECT 1.3::real::timestamp

-- sqlfmt-corpus-separator --

SELECT 1.3::real::timestamptz

-- sqlfmt-corpus-separator --

SELECT 1.3::real::varchar;

-- sqlfmt-corpus-separator --

SELECT 1.4::bigint

-- sqlfmt-corpus-separator --

SELECT 1.4::float::bigint

-- sqlfmt-corpus-separator --

SELECT 1.4::float::int

-- sqlfmt-corpus-separator --

SELECT 1.4::int

-- sqlfmt-corpus-separator --

SELECT 1.4::real::bigint

-- sqlfmt-corpus-separator --

SELECT 1.4::real::int

-- sqlfmt-corpus-separator --

SELECT 1.5::bigint

-- sqlfmt-corpus-separator --

SELECT 1.5::float::bigint

-- sqlfmt-corpus-separator --

SELECT 1.5::float::int

-- sqlfmt-corpus-separator --

SELECT 1.5::int

-- sqlfmt-corpus-separator --

SELECT 1.5::real::bigint

-- sqlfmt-corpus-separator --

SELECT 1.5::real::int

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

SELECT 12.0::float::uint2

-- sqlfmt-corpus-separator --

SELECT 12.0::float::uint4

-- sqlfmt-corpus-separator --

SELECT 12.0::float::uint8

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

SELECT 12.4::float::uint2

-- sqlfmt-corpus-separator --

SELECT 12.4::float::uint4

-- sqlfmt-corpus-separator --

SELECT 12.4::float::uint8

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

SELECT 12.6::float::uint2

-- sqlfmt-corpus-separator --

SELECT 12.6::float::uint4

-- sqlfmt-corpus-separator --

SELECT 12.6::float::uint8

-- sqlfmt-corpus-separator --

SELECT 12.6::numeric::uint2

-- sqlfmt-corpus-separator --

SELECT 12.6::numeric::uint4

-- sqlfmt-corpus-separator --

SELECT 12.6::numeric::uint8

-- sqlfmt-corpus-separator --

SELECT 120129019392::bigint::oid;

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

SELECT 124::uint2::real

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

SELECT 14::bigint::oid;

-- sqlfmt-corpus-separator --

SELECT 14::oid = 14::bigint;

-- sqlfmt-corpus-separator --

SELECT 14::oid = 14::smallint;

-- sqlfmt-corpus-separator --

SELECT 14::oid::bigint;

-- sqlfmt-corpus-separator --

SELECT 14::smallint::oid;

-- sqlfmt-corpus-separator --

SELECT 15445::uint8::double

-- sqlfmt-corpus-separator --

SELECT 15445::uint8::int4

-- sqlfmt-corpus-separator --

SELECT 15445::uint8::int8

-- sqlfmt-corpus-separator --

SELECT 15445::uint8::numeric

-- sqlfmt-corpus-separator --

SELECT 15445::uint8::real

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

SELECT 18446744073709551615::uint8 / 9223372036854775807::bigint;

-- sqlfmt-corpus-separator --

SELECT 18446744073709551616::numeric::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709551616::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709553664.0::double::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709553664.0::float::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709553664.5::double::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709553664.5::float::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709553665::double::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709553665::float::uint8

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

SELECT 1::bigint::bigint;

-- sqlfmt-corpus-separator --

SELECT 1::bigint::boolean;

-- sqlfmt-corpus-separator --

SELECT 1::bigint::date

-- sqlfmt-corpus-separator --

SELECT 1::bigint::double;

-- sqlfmt-corpus-separator --

SELECT 1::bigint::integer;

-- sqlfmt-corpus-separator --

SELECT 1::bigint::interval

-- sqlfmt-corpus-separator --

SELECT 1::bigint::jsonb

-- sqlfmt-corpus-separator --

SELECT 1::bigint::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::bigint::real;

-- sqlfmt-corpus-separator --

SELECT 1::bigint::smallint;

-- sqlfmt-corpus-separator --

SELECT 1::bigint::text;

-- sqlfmt-corpus-separator --

SELECT 1::bigint::time

-- sqlfmt-corpus-separator --

SELECT 1::bigint::timestamp

-- sqlfmt-corpus-separator --

SELECT 1::bigint::timestamptz

-- sqlfmt-corpus-separator --

SELECT 1::bigint::varchar;

-- sqlfmt-corpus-separator --

SELECT 1::decimal(2, 2)

-- sqlfmt-corpus-separator --

SELECT 1::int

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

SELECT 1::mz_catalog.mz_timestamp

-- sqlfmt-corpus-separator --

SELECT 1::numeric + 2::numeric

-- sqlfmt-corpus-separator --

SELECT 1::numeric - 2::numeric

-- sqlfmt-corpus-separator --

SELECT 1::numeric / (-1::numeric + 1.0);

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

SELECT 1::smallint::bigint;

-- sqlfmt-corpus-separator --

SELECT 1::smallint::boolean;

-- sqlfmt-corpus-separator --

SELECT 1::smallint::date

-- sqlfmt-corpus-separator --

SELECT 1::smallint::double;

-- sqlfmt-corpus-separator --

SELECT 1::smallint::integer;

-- sqlfmt-corpus-separator --

SELECT 1::smallint::interval

-- sqlfmt-corpus-separator --

SELECT 1::smallint::jsonb

-- sqlfmt-corpus-separator --

SELECT 1::smallint::numeric;

-- sqlfmt-corpus-separator --

SELECT 1::smallint::real;

-- sqlfmt-corpus-separator --

SELECT 1::smallint::smallint;

-- sqlfmt-corpus-separator --

SELECT 1::smallint::text, 1::bigint::text, 1.0::text, 1.0::float::text, 1.0::double::text

-- sqlfmt-corpus-separator --

SELECT 1::smallint::text;

-- sqlfmt-corpus-separator --

SELECT 1::smallint::time

-- sqlfmt-corpus-separator --

SELECT 1::smallint::timestamp

-- sqlfmt-corpus-separator --

SELECT 1::smallint::timestamptz

-- sqlfmt-corpus-separator --

SELECT 1::smallint::varchar;

-- sqlfmt-corpus-separator --

SELECT 1::text::int

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

SELECT 2 OPERATOR(*) 2 + 2, 2 * 2 + 2

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

SELECT 2::int::bigint;

-- sqlfmt-corpus-separator --

SELECT 2::int::boolean;

-- sqlfmt-corpus-separator --

SELECT 2::int::date

-- sqlfmt-corpus-separator --

SELECT 2::int::double;

-- sqlfmt-corpus-separator --

SELECT 2::int::integer;

-- sqlfmt-corpus-separator --

SELECT 2::int::interval

-- sqlfmt-corpus-separator --

SELECT 2::int::jsonb;

-- sqlfmt-corpus-separator --

SELECT 2::int::numeric;

-- sqlfmt-corpus-separator --

SELECT 2::int::real;

-- sqlfmt-corpus-separator --

SELECT 2::int::smallint;

-- sqlfmt-corpus-separator --

SELECT 2::int::text;

-- sqlfmt-corpus-separator --

SELECT 2::int::time

-- sqlfmt-corpus-separator --

SELECT 2::int::timestamp

-- sqlfmt-corpus-separator --

SELECT 2::int::timestamptz

-- sqlfmt-corpus-separator --

SELECT 2::int::varchar;

-- sqlfmt-corpus-separator --

SELECT 2::numeric % 0::numeric

-- sqlfmt-corpus-separator --

SELECT 2::numeric / 'NaN'::numeric

-- sqlfmt-corpus-separator --

SELECT 2::regclass

-- sqlfmt-corpus-separator --

SELECT 3 IN (SELECT c FROM t ORDER BY 1 ASC) AS r

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

SELECT 3::OID::INT::OID

-- sqlfmt-corpus-separator --

SELECT 3::decimal IN (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 3::decimal IN (SELECT 1::int)

-- sqlfmt-corpus-separator --

SELECT 3::numeric % 2::numeric

-- sqlfmt-corpus-separator --

SELECT 4 IN (SELECT c FROM t ORDER BY 1 DESC) AS r

-- sqlfmt-corpus-separator --

SELECT 4294967295.4::double::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967295.4::float::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967295.4::numeric::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967295.5::double::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967295.5::float::uint4

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

SELECT 4294967296.0::float::uint8

-- sqlfmt-corpus-separator --

SELECT 4294967296.0::numeric::uint8

-- sqlfmt-corpus-separator --

SELECT 4294967296::double::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967296::float::uint4

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

SELECT 65535.4::float::uint2

-- sqlfmt-corpus-separator --

SELECT 65535.4::numeric::uint2

-- sqlfmt-corpus-separator --

SELECT 65535.5::double::uint2

-- sqlfmt-corpus-separator --

SELECT 65535.5::float::uint2

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

SELECT 65536.0::float::uint2

-- sqlfmt-corpus-separator --

SELECT 65536.0::float::uint4

-- sqlfmt-corpus-separator --

SELECT 65536.0::float::uint8

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

SELECT 6789::uint4::real

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

SELECT 7::numeric::int, 7.3::int, 7.5::int

-- sqlfmt-corpus-separator --

SELECT 7::numeric::int8, 7.3::int8, 7.5::int8

-- sqlfmt-corpus-separator --

SELECT 8210266815600000::mz_timestamp::timestamptz

-- sqlfmt-corpus-separator --

SELECT 8210266898400000::mz_timestamp::timestamp

-- sqlfmt-corpus-separator --

SELECT 8210266898400000::mz_timestamp::timestamptz

-- sqlfmt-corpus-separator --

SELECT 9223372036854775806::bigint+1::bigint

-- sqlfmt-corpus-separator --

SELECT 9223372036854775807::bigint / 18446744073709551615::uint8;

-- sqlfmt-corpus-separator --

SELECT 9223372036854775807::bigint+1::bigint

-- sqlfmt-corpus-separator --

SELECT 9223372036854775807::bigint-(-1)::bigint

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

SELECT 99::bigint::bool

-- sqlfmt-corpus-separator --

SELECT 99::int2::uint8

-- sqlfmt-corpus-separator --

SELECT 99::int4::uint8

-- sqlfmt-corpus-separator --

SELECT 99::int8::uint8

-- sqlfmt-corpus-separator --

SELECT 99::int::bool

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

SELECT ALL 56 * 97 - SUM ( - 51 ) + NULLIF ( + - 36, + + CAST ( NULL AS INTEGER ) ) * + - 91 / - 0 * - 45 * - 10 * - CAST ( NULL AS INTEGER ) * - - 85

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT 1 WHERE FALSE)::text

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT AVG(0) FROM zs)::text;

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT first_name, last_name FROM customer)::text

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT id FROM customer)::text

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT other_field FROM users ORDER BY id ASC)::text

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT x FROM xs LIMIT 2)::text

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT x FROM xs ORDER BY x DESC LIMIT 1)::text

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT x FROM xs ORDER BY x DESC LIMIT 2)::text

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT x FROM xs ORDER BY x DESC)::text

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT x FROM xs WHERE x > 1)::text

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT x FROM xs)::text

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT z FROM zs)::text;

-- sqlfmt-corpus-separator --

SELECT ARRAY(WITH usps AS (SELECT 42) SELECT * FROM usps)

-- sqlfmt-corpus-separator --

SELECT ARRAY(WITH usps AS (SELECT 42) SELECT customer.first_name FROM customer)

-- sqlfmt-corpus-separator --

SELECT CAST ('+Inf' AS double precision), CAST ('inf' AS double precision)

-- sqlfmt-corpus-separator --

SELECT CAST (CAST (1 as int) AS text)

-- sqlfmt-corpus-separator --

SELECT CAST (CAST (1.1 AS double precision) AS text)

-- sqlfmt-corpus-separator --

SELECT CAST('2020-01-01' AS date), CAST('2020-01-01'::timestamp as date), CAST('2020-01-01'::timestamptz as date)

-- sqlfmt-corpus-separator --

SELECT CAST('{"a":"b"}'::JSONB AS STRING)

-- sqlfmt-corpus-separator --

SELECT CAST(5 + 3 AS text);

-- sqlfmt-corpus-separator --

SELECT CAST(a as text[]) FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT CAST(f1 AS char(4)) AS three FROM VARCHAR_TBL
UNION
SELECT f1 FROM CHAR_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT CONCAT('a'::char(3), 'b'::text, 'c');

-- sqlfmt-corpus-separator --

SELECT CONCAT('a'::text, 'b'::char(3), 'c');

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

SELECT DATE '2000-01-01' + INTERVAL '-1' MONTH

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + INTERVAL '1' MONTH

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + INTERVAL '1' YEAR

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + INTERVAL '22' SECOND

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + INTERVAL '22.0044' SECOND

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + INTERVAL '3' MINUTE

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + INTERVAL '4 HR'

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + INTERVAL '4' HOUR

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + INTERVAL '7 5:4:3.2' DAY TO SECOND

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + INTERVAL '7' DAY

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + TIME '01:02:03'

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' - INTERVAL '-1' MONTH

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' - INTERVAL '1' MONTH

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' - INTERVAL '1' YEAR

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' - INTERVAL '22' DAY

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' - INTERVAL '22' SECOND

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' < DATE '1999-01-01' + INTERVAL '2' YEAR

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' <= DATE '1999-01-01' + INTERVAL '2' YEAR

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' > DATE '1999-01-01' + INTERVAL '2' YEAR

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' >= DATE '1999-01-01' + INTERVAL '2' YEAR

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01', DATE '2000-12-31', DATE '1993-05-16'

-- sqlfmt-corpus-separator --

SELECT DATE '20000101'

-- sqlfmt-corpus-separator --

SELECT DATE '2001-01-01' + INTERVAL '3' YEAR

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

SELECT DISTINCT a FROM daterange_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM foo ORDER BY a + 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM foo ORDER BY b

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM int4range_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM int8range_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM numrange_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM tsrange_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM tstzrange_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT authors.name FROM books AS b1, books2 as b2, authors WHERE b1.title = b2.title AND authors.book = b1.title AND b1.shelf <> b2.shelf

-- sqlfmt-corpus-separator --

SELECT DISTINCT b, a FROM foo ORDER BY b

-- sqlfmt-corpus-separator --

SELECT DISTINCT c, b FROM t ORDER BY b DESC LIMIT 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT lower(a), upper(a) FROM daterange_values;

-- sqlfmt-corpus-separator --

SELECT DISTINCT lower(a), upper(a) FROM int4range_values
ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

SELECT DISTINCT lower(a), upper(a) FROM int8range_values
ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

SELECT DISTINCT lower(a), upper(a) FROM numrange_values;

-- sqlfmt-corpus-separator --

SELECT DISTINCT lower(a), upper(a) FROM tsrange_values ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

SELECT DISTINCT lower(a), upper(a) FROM tstzrange_values ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

SELECT DISTINCT name, create_sql
FROM mz_indexes
WHERE cluster_id =
  (SELECT id FROM mz_clusters WHERE name = 'mz_catalog_server')
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT octet_length(a) FROM bpchar_t;

-- sqlfmt-corpus-separator --

SELECT DISTINCT(attgenerated = '') FROM pg_attribute

-- sqlfmt-corpus-separator --

SELECT DISTINCT(privilege) FROM item_privileges WHERE type = 'table'

-- sqlfmt-corpus-separator --

SELECT DISTINCT(privilege) FROM item_privileges WHERE type = 'type'

-- sqlfmt-corpus-separator --

SELECT DISTINCT(privilege) FROM item_privileges WHERE type = 'view' OR type = 'materialized view' OR type = 'source'

-- sqlfmt-corpus-separator --

SELECT E'test line 1\ntest line 2' LIKE '%1%2%';

-- sqlfmt-corpus-separator --

SELECT E'{{1,2},\\{2,3}}'::text[];

-- sqlfmt-corpus-separator --

SELECT EXISTS (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT EXISTS(SELECT * FROM t)

-- sqlfmt-corpus-separator --

SELECT EXISTS(SELECT 1 FROM kv AS x WHERE x.k = 1)

-- sqlfmt-corpus-separator --

SELECT EXISTS(SELECT 1 FROM kv WHERE k = 2)

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '2001-01-01'),
    EXTRACT(CENTURY FROM DATE '2000-01-01'),
    EXTRACT(CENTURY FROM DATE '1999-01-01'),
    EXTRACT(CENTURY FROM DATE '1001-01-01'),
    EXTRACT(CENTURY FROM DATE '1000-01-01'),
    EXTRACT(CENTURY FROM DATE '0001-01-01'),
    EXTRACT(CENTURY FROM DATE '0001-01-01' - INTERVAL '1'SECOND),
    EXTRACT(CENTURY FROM DATE '0001-01-01' - INTERVAL '100 YEAR 1 SECOND')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '2001-01-01'),
    EXTRACT(DECADE FROM DATE '2000-01-01'),
    EXTRACT(DECADE FROM DATE '1999-01-01'),
    EXTRACT(DECADE FROM DATE '0001-01-01'),
    EXTRACT(DECADE FROM DATE '0001-01-01' - INTERVAL '1'SECOND),
    EXTRACT(DECADE FROM DATE '0001-01-01' - INTERVAL '1 YEAR 1 SECOND'),
    EXTRACT(DECADE FROM DATE '0001-01-01' - INTERVAL '10 YEAR 1 SECOND'),
    EXTRACT(DECADE FROM DATE '0001-01-01' - INTERVAL '11 YEAR 1 SECOND')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE from INTERVAL '39'YEAR),
    EXTRACT(CENTURY from INTERVAL '399'YEAR),
    EXTRACT(MILLENNIUM from INTERVAL '3999'YEAR)

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOW FROM TIMESTAMP '1999-12-26 00:00:00'), EXTRACT(DOW FROM TIMESTAMP '2000-01-01 00:00:00')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOW from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOY FROM DATE '2000-01-01'), EXTRACT(DOY FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOY from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(MILLENNIUM FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(CENTURY FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(DECADE FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(YEAR FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(QUARTER FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(WEEK FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(MONTH FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(HOUR FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(DAY FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(DOW FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(DOY FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(ISODOW FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(MINUTE FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(SECOND FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(MS FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(US FROM TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH from INTERVAL '-1' MINUTE), EXTRACT(MINUTE from INTERVAL '-1' MINUTE)

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH from INTERVAL '1' YEAR), EXTRACT(EPOCH from INTERVAL '1' MONTH) * 12

-- sqlfmt-corpus-separator --

SELECT EXTRACT(HOUR FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(HOUR from TIME '11:12:42.666'),
    EXTRACT(MINUTE from TIME '11:12:42.666'),
    EXTRACT(SECOND from TIME '11:12:42.666'),
    EXTRACT(MILLISECONDS from TIME '11:12:42.666'),
    EXTRACT(MICROSECONDS from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISODOW FROM TIMESTAMP '1999-12-26 00:00:00'), EXTRACT(ISODOW FROM TIMESTAMP '2000-01-01 00:00:00')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISODOW from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISODOY from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MICROSECOND FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '2001-01-01'),
    EXTRACT(MILLENNIUM FROM DATE '2000-01-01'),
    EXTRACT(MILLENNIUM FROM DATE '1999-01-01'),
    EXTRACT(MILLENNIUM FROM DATE '1001-01-01'),
    EXTRACT(MILLENNIUM FROM DATE '1000-01-01'),
    EXTRACT(MILLENNIUM FROM DATE '0001-01-01'),
    EXTRACT(MILLENNIUM FROM DATE '0001-01-01' - INTERVAL '1'SECOND),
    EXTRACT(MILLENNIUM FROM DATE '0001-01-01' - INTERVAL '1000 YEAR 1 SECOND')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLISECOND FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLISECOND from INTERVAL '72.345678'SECOND), EXTRACT(MICROSECOND from INTERVAL '72.345678'SECOND)

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MONTH from INTERVAL '-13'MONTH), EXTRACT(MONTH from INTERVAL '15'MONTH)

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MONTH from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(QUARTER FROM DATE '2000-01-01'),
    EXTRACT(QUARTER FROM DATE '2000-02-03'),
    EXTRACT(QUARTER FROM DATE '2000-03-05'),
    EXTRACT(QUARTER FROM DATE '2000-04-07'),
    EXTRACT(QUARTER FROM DATE '2000-05-09'),
    EXTRACT(QUARTER FROM DATE '2000-06-11'),
    EXTRACT(QUARTER FROM DATE '2000-07-13'),
    EXTRACT(QUARTER FROM DATE '2000-08-15'),
    EXTRACT(QUARTER FROM DATE '2000-09-17'),
    EXTRACT(QUARTER FROM DATE '2000-10-19'),
    EXTRACT(QUARTER FROM DATE '2000-11-21'),
    EXTRACT(QUARTER FROM DATE '2000-12-24')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(QUARTER from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(SECOND FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(WEEK FROM DATE '2000-01-01'), EXTRACT(WEEK FROM DATE '2000-01-08')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(WEEK from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(YEAR from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(epoch FROM INTERVAL '-2147483648 months -2147483648 days -2147483648 hours -59 minutes -59.999999 seconds');

-- sqlfmt-corpus-separator --

SELECT EXTRACT(epoch FROM INTERVAL '2147483647 months 2147483647 days 2147483647 hours 59 minutes 59.999999 seconds');

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

SELECT INTERVAL '-1.2345649' SECOND(5);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1.23456789' SECOND(2);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1.23456789' SECOND(5);

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

SELECT INTERVAL '-2147483647' MONTH * 1.01

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

SELECT INTERVAL '-2562047788:00:54.775808' SECOND(2);

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

SELECT INTERVAL '0.00000001 min 0.0006 millisecond 3.5 microsecond' SECOND(5);

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

SELECT INTERVAL '01:02:03' MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:02:03minute hour day year';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:02:03minute';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 0:.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 2-3 4:5' DAY

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

SELECT INTERVAL '1 day 2-3 4' SECOND(7);

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

SELECT INTERVAL '1' MINUTE

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' MONTH

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' MONTH * 0.5, 0.5 * INTERVAL '1' MONTH

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' MONTH + DATE '2000-01-01'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' MONTH / 30

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' YEAR

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' YEAR * 0.9999999

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' YEAR * 13/12

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' YEAR - DATE '2000-01-01'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' YEAR - TIMESTAMP '2000-01-01 00:00:00'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' YEAR - TIMESTAMPTZ '2000-01-01 00:00:00-4:00'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' YEAR / 0

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' YEAR / 360

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

SELECT INTERVAL '1-2 3 4:5:6' DAY;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6' HOUR, INTERVAL '1-2 3 4:5:6' DAY TO HOUR

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6' MINUTE, INTERVAL '1-2 3 4:5:6' HOUR TO MINUTE, INTERVAL '1-2 3 4:5:6' DAY TO MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6' MONTH, INTERVAL '1-2 3 4:5:6' YEAR TO MONTH;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6' SECOND, INTERVAL '1-2 3 4:5:6' MINUTE TO SECOND, INTERVAL '1-2 3 4:5:6' HOUR TO SECOND, INTERVAL '1-2 3 4:5:6' DAY TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6' YEAR

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

SELECT INTERVAL '1-2 3 4:5:6.7' DAY TO HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' DAY;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' MONTH;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' YEAR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4::.5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 year'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3' HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3' MONTH;

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

SELECT INTERVAL '1-3' YEAR TO MONTH

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.0 second 42 milliseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.2345649' SECOND(5);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.23456789' SECOND

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.23456789' SECOND(2);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.23456789' SECOND(5);

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

SELECT INTERVAL '1.5555 month 2 3:4:5.6' DAY TO HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5555 month 2 3:4:5.6' HOUR;

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

SELECT INTERVAL '12:34' DAY TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' HOUR TO MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' HOUR TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' MINUTE TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56' HOUR TO MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56' HOUR TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56' HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56' MINUTE TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56' MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56' SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '153722867280.912930117 minutes';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '153722867281 minutes';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:3.4 5-6 7' DAY;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:3.4 5-6 7' YEAR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:3.4 5-6';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:3.4.5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:31.23456789' MINUTE TO SECOND(2);

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

SELECT INTERVAL '2' HOUR - TIMESTAMPTZ '2000-01-01 00:00:00-04'

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

SELECT INTERVAL '2147483647' MONTH / 0.99

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

SELECT INTERVAL '2562047788:00:54.775807' SECOND(2);

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

SELECT INTERVAL '5' DAY;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5' HOUR, INTERVAL '5' DAY TO HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5' MINUTE, INTERVAL '5' HOUR TO MINUTE, INTERVAL '5' DAY TO MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5' MONTH, INTERVAL '5' YEAR TO MONTH;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5' YEAR

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5', INTERVAL '5' SECOND, INTERVAL '5' MINUTE TO SECOND, INTERVAL '5' HOUR TO SECOND, INTERVAL '5' DAY TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5000006 microseconds 1 second'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5000006 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '6 days'::time;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '6' HOUR + TIMESTAMPTZ '2000-01-01 00:00:00-04'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '6.7 seconds 5 minutes 3 days 4 hours 1 year 2 month';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '7 months'::time;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '7' DAY + DATE '2000-01-01'

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

SELECT NOT 0::bigint::bool

-- sqlfmt-corpus-separator --

SELECT NOT 0::int::bool

-- sqlfmt-corpus-separator --

SELECT NULL -> 'hello'::text

-- sqlfmt-corpus-separator --

SELECT NULL AS "a", CAST(NULL AS int2vector) AS "b";

-- sqlfmt-corpus-separator --

SELECT NULL AS "a", CAST(NULL AS int4range) AS "b";

-- sqlfmt-corpus-separator --

SELECT NULL, NULL::t;

-- sqlfmt-corpus-separator --

SELECT NULL::INT[] || NULL::INT[]

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

SELECT NULLIF(1, 2), NULLIF(2, 2), NULLIF(NULL, NULL)

-- sqlfmt-corpus-separator --

SELECT OVERLAY(nonexistent.* PLACING 'string' FROM 'string')

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

SELECT TIMESTAMP '2000-01-01 00:00:00' + INTERVAL '1' YEAR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2000-01-01 00:00:00' + INTERVAL '7' HOUR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2000-01-01 00:00:00' - INTERVAL '1' YEAR

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

SELECT TIMESTAMP '2020-12-21 18:53:49' AT TIME ZONE 'America/New_York'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2020-12-21 18:53:49' AT TIME ZONE 'PST'

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

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-04' * INTERVAL '2' HOUR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-04' + INTERVAL '3' MINUTE

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-04' + INTERVAL '7' HOUR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-04' + TIMESTAMP '1999-01-01 00:00:00'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-04' + TIMESTAMPTZ '1999-01-01 00:00:00z'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-04' - INTERVAL '2' HOUR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-04' / INTERVAL '2' HOUR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-6' + INTERVAL '1' YEAR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-6' + INTERVAL '3' MONTH

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-7' - INTERVAL '1' YEAR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-7' - INTERVAL '4' MONTH

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 01:00:00+01' + INTERVAL '1' MINUTE != TIMESTAMPTZ '2000-01-01 00:01:00+01' + INTERVAL '1' HOUR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 01:00:00+01' + INTERVAL '3' HOUR > TIMESTAMPTZ '2000-01-01 00:01:00z' + INTERVAL '1' HOUR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 01:00:00+01' < TIMESTAMPTZ '2000-01-01 00:01:00z' + INTERVAL '1' HOUR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 01:00:00+01' <= TIMESTAMPTZ '2000-01-01 00:01:00z' + INTERVAL '1' HOUR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 01:00:00+01' > TIMESTAMPTZ '2000-01-01 00:01:00z' + INTERVAL '1' HOUR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 01:00:00+01' >= TIMESTAMPTZ '2000-01-01 00:01:00z' + INTERVAL '1' HOUR

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

SELECT TIMESTAMPTZ '2020-12-21 18:53:49 Pacific/Auckland' AT TIME ZONE 'Turkey'

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::bigint

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::boolean;

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::date

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::double

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::interval

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::jsonb;

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::numeric

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::real

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::smallint

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::text;

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::time

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::timestamp

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::timestamptz

-- sqlfmt-corpus-separator --

SELECT TRUE::boolean::varchar;

-- sqlfmt-corpus-separator --

SELECT a FROM a WHERE a > 2 UNION ALL (SELECT a FROM c WHERE b > 2) LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT a FROM fizz WHERE a < ALL(SELECT val1 FROM baz ORDER BY val1 DESC limit 5)

-- sqlfmt-corpus-separator --

SELECT a FROM fizz WHERE a > ANY(SELECT val1 FROM baz ORDER BY val1 offset 3 ROWS)

-- sqlfmt-corpus-separator --

SELECT a FROM fizz WHERE a IN (SELECT val1 FROM baz ORDER BY val1 offset 0 rows)

-- sqlfmt-corpus-separator --

SELECT a FROM foo
ORDER BY lag(a) OVER (ORDER BY -a NULLS FIRST) DESC NULLS LAST;

-- sqlfmt-corpus-separator --

SELECT a FROM foo
ORDER BY lag(a) OVER (ORDER BY a) NULLS LAST;

-- sqlfmt-corpus-separator --

SELECT a FROM foo
WHERE (a = 0 AND a = 2::SMALLINT) OR a = 3;

-- sqlfmt-corpus-separator --

SELECT a FROM foo
WHERE a = 0 AND a = 0::SMALLINT;

-- sqlfmt-corpus-separator --

SELECT a FROM foo
WHERE a = 3::SMALLINT;

-- sqlfmt-corpus-separator --

SELECT a FROM foo ORDER BY exists (SELECT * FROM bar WHERE bar.a = foo.a), a

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

SELECT a FROM t1
WHERE (
    (a = 1 AND b like 'nope') OR
    (a = 2) OR
    (a = 1 AND a = 2)
) AND
(b like 'l%' OR b like 'aaa')

-- sqlfmt-corpus-separator --

SELECT a FROM t1 WHERE EXISTS (SELECT 1 FROM t2 WHERE EXISTS (SELECT 1 FROM t3 WHERE t1.a = t3.a AND t2.b = t3.b))

-- sqlfmt-corpus-separator --

SELECT a FROM tz WHERE b = c::timestamp

-- sqlfmt-corpus-separator --

SELECT a FROM tz WHERE c = d::timestamp

-- sqlfmt-corpus-separator --

SELECT a, 2*a as d
FROM foo
ORDER BY lag(d) OVER (ORDER BY d);

-- sqlfmt-corpus-separator --

SELECT a, MAX(b) + 1
FROM t
GROUP BY a
HAVING ((MAX(b) + 1) - a) > 2 AND (MAX(b) + 1) / (1 + a) >= 1;

-- sqlfmt-corpus-separator --

SELECT a, NULLIF(a, 2), IF(a = 2, NULL, a) FROM t ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b ORDER BY b ASC), array_agg(b ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b ORDER BY b) FROM t GROUP BY a HAVING array_agg(b ORDER BY b) = array_agg(b ORDER BY b DESC);

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b), array_agg(sha256(b::BYTEA)) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b), string_agg(c, ',' ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT a, b FROM foo
ORDER BY a IN (SELECT length(b)-1 FROM foo), -a;

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

SELECT a::string[]::int[]::text[]::float8[] FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT a::text from t

-- sqlfmt-corpus-separator --

SELECT abs('NaN'::numeric);

-- sqlfmt-corpus-separator --

SELECT abs(-1.2::float), abs(1.2::float), abs(-0.0::float), abs(0), abs(1), abs(-1.2121::decimal)

-- sqlfmt-corpus-separator --

SELECT abs(-1::numeric);

-- sqlfmt-corpus-separator --

SELECT abs(1) FILTER (WHERE false)

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

SELECT array_agg('a'::char(2))

-- sqlfmt-corpus-separator --

SELECT array_agg('a'::char)

-- sqlfmt-corpus-separator --

SELECT array_agg(NULL::TEXT)

-- sqlfmt-corpus-separator --

SELECT array_agg(a::text) FROM t1

-- sqlfmt-corpus-separator --

SELECT array_cat('1 2'::int2vector, '{3}'::int2[])::text;

-- sqlfmt-corpus-separator --

SELECT array_cat('{1,2}'::int2[], '3'::int2vector)::text;

-- sqlfmt-corpus-separator --

SELECT array_cat(ARRAY(SELECT x FROM xs), ARRAY(SELECT y FROM ys ORDER BY y DESC))::text

-- sqlfmt-corpus-separator --

SELECT array_cat(ARRAY(SELECT x FROM xs), ARRAY(SELECT y FROM ys))::text

-- sqlfmt-corpus-separator --

SELECT array_cat(NULL::INT[], NULL::INT[])

-- sqlfmt-corpus-separator --

SELECT array_fill(null::int, null);

-- sqlfmt-corpus-separator --

SELECT array_length('1 2'::int2vector, 1);

-- sqlfmt-corpus-separator --

SELECT array_length('{1,2}'::int2[], 1);

-- sqlfmt-corpus-separator --

SELECT array_position(null::text[], 'abc')

-- sqlfmt-corpus-separator --

SELECT array_position(null::text[], 'abc', null)

-- sqlfmt-corpus-separator --

SELECT array_remove(NULL::INT[], 1)

-- sqlfmt-corpus-separator --

SELECT array_remove(NULL::INT[], NULL::INT)

-- sqlfmt-corpus-separator --

SELECT array_to_json('{"a","b","c"}'::STRING[])

-- sqlfmt-corpus-separator --

SELECT array_to_json('{1,2,3}'::INT[])

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

SELECT avg(1::int)::float, avg(2::float)::float, avg(3::decimal)::float

-- sqlfmt-corpus-separator --

SELECT avg(k)::FLOAT, avg(v)::FLOAT, sum(k)::FLOAT, sum(v)::FLOAT FROM kv

-- sqlfmt-corpus-separator --

SELECT b != ALL(SELECT a FROM x) FROM y

-- sqlfmt-corpus-separator --

SELECT b + interval '1m', interval '1m' + b, c + interval '1m', interval '1m' + c FROM tz WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b, b::date, c, c::date FROM u WHERE a = 123

-- sqlfmt-corpus-separator --

SELECT b, b::text FROM t

-- sqlfmt-corpus-separator --

SELECT b::int[] FROM array_t2;

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

SELECT c FROM timestamp_compares WHERE c != TIMESTAMP '2008-12-01 09:09:09.9' + INTERVAL '1' MONTH

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c != TIMESTAMP '2008-12-31 09:09:09.9' + INTERVAL '1' DAY

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c != TIMESTAMP '2009-01-01 09:09:09.9'

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c < TIMESTAMP '2008-12-31 09:09:09.9' + INTERVAL '2' MONTH

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c = TIMESTAMP '2008-12-01 09:09:09.9' + INTERVAL '1' MONTH

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c = TIMESTAMP '2008-12-31 09:09:09.9' + INTERVAL '1' DAY

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c = TIMESTAMP '2009-01-01 09:09:09.9'

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c > TIMESTAMP '2008-12-31 09:09:09.9' + INTERVAL '2' MONTH

-- sqlfmt-corpus-separator --

SELECT c::int[] FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT c_id, 'WY' IN (SELECT ship FROM o WHERE o.c_id=c.c_id) FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT c_id, EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id AND c.bill='TX') FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT c_id, EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id) FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT c_id, NOT EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id) FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT c_id, bill
FROM c AS c2
WHERE EXISTS
(
    SELECT * FROM c WHERE bill=(SELECT max(ship) FROM o WHERE c_id=c2.c_id AND c_id=c.c_id)
)

-- sqlfmt-corpus-separator --

SELECT c_id, bill < ANY(SELECT ship FROM o WHERE o.c_id=c.c_id) FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT c_id, bill = ALL(SELECT ship FROM o WHERE o.c_id=c.c_id) FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT c_id, bill > ANY(SELECT ship FROM o WHERE o.c_id=c.c_id) FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT c_id, bill IN (SELECT ship FROM o WHERE o.c_id=c.c_id) FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT c_id, bill NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id) FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT cbrt(-1.0::float), round(cbrt(27.0::float), 15), cbrt(19.3::decimal)

-- sqlfmt-corpus-separator --

SELECT cbrt(-8::double)::float4

-- sqlfmt-corpus-separator --

SELECT cbrt(1.23783::decimal(15,5))::float4

-- sqlfmt-corpus-separator --

SELECT cbrt(1.23783::double)::float4

-- sqlfmt-corpus-separator --

SELECT cbrt(1.23783::float)::float4

-- sqlfmt-corpus-separator --

SELECT cbrt(27::int)::float4

-- sqlfmt-corpus-separator --

SELECT cbrt(3::int)::float4

-- sqlfmt-corpus-separator --

SELECT ceil(-0.5::float), ceil(0.5::float), ceiling(0.5::float), ceil(0.1::decimal), ceiling (-0.9::decimal)

-- sqlfmt-corpus-separator --

SELECT ceil(-0.5::float), ceil(0.5::float), ceiling(0.5::float), ceil(0.1::decimal), ceiling(-0.9::decimal)

-- sqlfmt-corpus-separator --

SELECT ceil(1.234), ceil(-1.234), ceil('NaN'::numeric)

-- sqlfmt-corpus-separator --

SELECT ceil(CAST (1.1 AS double precision))

-- sqlfmt-corpus-separator --

SELECT ceil(CAST (1.1 AS float))

-- sqlfmt-corpus-separator --

SELECT ceil(cast(1 AS bigint))

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

SELECT concat(3.32::double precision)

-- sqlfmt-corpus-separator --

SELECT concat(3.32::float)

-- sqlfmt-corpus-separator --

SELECT concat(3.32::float, '3')

-- sqlfmt-corpus-separator --

SELECT concat(3.32::float, 3)

-- sqlfmt-corpus-separator --

SELECT concat(3.32::int)

-- sqlfmt-corpus-separator --

SELECT concat_ws(', ', interval '1d', 1.23::numeric, 4.56::float);

-- sqlfmt-corpus-separator --

SELECT concat_ws(', ', interval '1d', null, 1.23::numeric, null, 4.57::float);

-- sqlfmt-corpus-separator --

SELECT concat_ws(', ', interval '1d', null, 1.23::numeric, null, 4.57::float, null);

-- sqlfmt-corpus-separator --

SELECT concat_ws(NULL::STRING, 'a', 'b')

-- sqlfmt-corpus-separator --

SELECT concat_ws(null, interval '1d', null, 1.23::numeric, null, 4.57::float, null);

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

SELECT count(*) FROM fizz WHERE exists(SELECT val1 FROM baz ORDER BY val1 limit 0)

-- sqlfmt-corpus-separator --

SELECT count(*) FROM md5_test WHERE md5(t) <> md5(t::bytea)

-- sqlfmt-corpus-separator --

SELECT count(*) FROM mz_materialized_views WHERE id LIKE 'u%'

-- sqlfmt-corpus-separator --

SELECT count(*), v/(k+v) FROM kv GROUP BY k+v

-- sqlfmt-corpus-separator --

SELECT count(2::int), count(3::float), count(4::decimal)

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

SELECT date_part('EPOCH', INTERVAL '-1' MINUTE),
    date_part('MINUTE', INTERVAL '-1' MINUTE),
    date_part('EPOCH', INTERVAL '1' YEAR),
    date_part('EPOCH', INTERVAL '1' MONTH) * 12,
    date_part('MILLISECOND', INTERVAL '72.345678'SECOND),
    date_part('MICROSECOND', INTERVAL '72.345678'SECOND),
    date_part('DECADE', INTERVAL '39'YEAR),
    date_part('CENTURY', INTERVAL '399'YEAR),
    date_part('MILLENNIUM', INTERVAL '3999'YEAR),
    date_part('MONTH', INTERVAL '-13'MONTH),
    date_part('MONTH', INTERVAL '15'MONTH)

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

SELECT date_trunc('century', TIMESTAMP '0001-01-01 00:00:00.000000' - INTERVAL '1'SECOND)

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

SELECT date_trunc('decade', TIMESTAMP '0001-01-01 00:00:00.000000' - INTERVAL '2'YEAR)

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

SELECT date_trunc('millennium', TIMESTAMP '0001-01-01 00:00:00.000000' - INTERVAL '1'SECOND)

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

SELECT daterange(('0001-01-01'::date + '262141years 11months 30days'::interval)::date, null, '()');

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

SELECT div(-1.0::float, 2.0), div(1.0::float, 2.0), div(9.0::float, 4.0), div(-9.0::float, 4.0), div(1.0::float, 0.0), div(1111.0::decimal, 9.44)

-- sqlfmt-corpus-separator --

SELECT div(-1::int, 2::int), div(1::int, 2::int), div(9::int, 4::int), div(-9::int, 4::int)

-- sqlfmt-corpus-separator --

SELECT div(-9.0::float, -2.0) * -2.0 + mod(-9.0::float, -2.0)

-- sqlfmt-corpus-separator --

SELECT div(-9.0::float, 2.0) * 2.0 + mod(-9.0::float, 2.0)

-- sqlfmt-corpus-separator --

SELECT div(1.0::decimal, 0.0::decimal)

-- sqlfmt-corpus-separator --

SELECT div(1::int, 0::int)

-- sqlfmt-corpus-separator --

SELECT div(9.0::float, -2.0) * -2.0 + mod(9.0::float, -2.0)

-- sqlfmt-corpus-separator --

SELECT div(9.0::float, 2.0) * 2.0 + mod(9.0::float, 2.0)

-- sqlfmt-corpus-separator --

SELECT exp('.5'::numeric)

-- sqlfmt-corpus-separator --

SELECT exp('NaN'::numeric)

-- sqlfmt-corpus-separator --

SELECT exp(-1.0::float), round(exp(1.0::float), 13), exp(2.0::decimal)

-- sqlfmt-corpus-separator --

SELECT exp(-10000::float)

-- sqlfmt-corpus-separator --

SELECT exp(-1::numeric)

-- sqlfmt-corpus-separator --

SELECT exp(-50000::numeric)

-- sqlfmt-corpus-separator --

SELECT exp(10000::float)

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

SELECT extract(day FROM DATE '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(day FROM TIMESTAMP '2010-09-28 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(day from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract(dayofweek FROM DATE '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(dayofweek FROM TIMESTAMP '2010-09-28 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(dayofyear FROM DATE '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(dayofyear FROM TIMESTAMP '2010-09-28 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(epoch FROM INTERVAL '10:20.30' MINUTE TO SECOND)

-- sqlfmt-corpus-separator --

SELECT extract(epoch FROM TIMESTAMP '2010-01-10 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(epoch from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract(hour FROM '123m')

-- sqlfmt-corpus-separator --

SELECT extract(hour FROM INTERVAL '123' MINUTE)

-- sqlfmt-corpus-separator --

SELECT extract(hour FROM TIME '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract(hour FROM TIMESTAMP '2010-01-10 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(hour from '2016-02-10 19:46:33.306157519-04'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(hour from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(hours from '2016-02-10 19:46:33.306157519-04'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(microsecond FROM TIME '12:00:00.123456')

-- sqlfmt-corpus-separator --

SELECT extract(microsecond FROM TIMESTAMP '2010-01-10 12:13:14.123456')

-- sqlfmt-corpus-separator --

SELECT extract(microsecond from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(millisecond FROM INTERVAL '20.3040' SECOND)

-- sqlfmt-corpus-separator --

SELECT extract(millisecond FROM TIME '12:00:00.123456')

-- sqlfmt-corpus-separator --

SELECT extract(millisecond FROM TIMESTAMP '2010-01-10 12:13:14.123456')

-- sqlfmt-corpus-separator --

SELECT extract(millisecond from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(minute FROM INTERVAL '23:10' MINUTE TO SECOND)

-- sqlfmt-corpus-separator --

SELECT extract(minute FROM TIME '12:30:00')

-- sqlfmt-corpus-separator --

SELECT extract(minute FROM TIMESTAMP '2010-01-10 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(minute from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(month FROM DATE '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(month FROM TIMESTAMP '2010-09-28 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(nansecond from '2001-04-10 12:04:59.34565423'::timestamp)

-- sqlfmt-corpus-separator --

SELECT extract(nansecond from '2001-04-10 12:04:59.34565423'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(quarter FROM DATE '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(quarter FROM TIMESTAMP '2010-09-28 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(second FROM INTERVAL '10:20.30' MINUTE TO SECOND)

-- sqlfmt-corpus-separator --

SELECT extract(second FROM TIME '12:00:30')

-- sqlfmt-corpus-separator --

SELECT extract(second FROM TIMESTAMP '2010-01-10 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(second from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(week FROM DATE '2010-01-14')

-- sqlfmt-corpus-separator --

SELECT extract(week FROM TIMESTAMP '2010-01-14 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(year FROM '2010-09-28 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(year FROM '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(year FROM DATE '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(year FROM TIMESTAMP '2010-09-28 12:13:14.1')

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

SELECT f.f1::text, (f.f1 * '-10')::text AS x FROM float4_tbl f
WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1::text, (f.f1 * '-10')::text AS x FROM float8_tbl f WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1::text, (f.f1 + '-10')::text AS x FROM float4_tbl f
WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1::text, (f.f1 + '-10')::text AS x FROM float8_tbl f WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1::text, (f.f1 - '-10')::text AS x FROM float4_tbl f
WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1::text, (f.f1 - '-10')::text AS x FROM float8_tbl f WHERE f.f1 > '0.0';

-- sqlfmt-corpus-separator --

SELECT f.f1::text, (f.f1 / '-10')::text AS x FROM float4_tbl f
WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1::text, (f.f1 / '-10')::text AS x FROM float8_tbl f WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1::text, round(f.f1)::text AS round_f1 FROM float8_tbl f

-- sqlfmt-corpus-separator --

SELECT f1 AS eight FROM VARCHAR_TBL
UNION ALL
SELECT f1 FROM CHAR_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 AS five FROM FLOAT8_TBL
UNION
SELECT f1 FROM FLOAT8_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 AS five FROM TEXT_TBL
UNION
SELECT f1 FROM VARCHAR_TBL
UNION
SELECT TRIM(TRAILING FROM f1) FROM CHAR_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 AS nine FROM FLOAT8_TBL
UNION
SELECT f1 FROM INT4_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 AS ten FROM FLOAT8_TBL
UNION ALL
SELECT f1 FROM FLOAT8_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 AS ten FROM FLOAT8_TBL
UNION ALL
SELECT f1 FROM INT4_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 AS three FROM VARCHAR_TBL
UNION
SELECT CAST(f1 AS varchar) FROM CHAR_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 FROM float8_tbl EXCEPT SELECT f1 FROM int4_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 FROM float8_tbl INTERSECT SELECT f1 FROM int4_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 FROM t1
WHERE f1 IN (SELECT ROW_NUMBER() OVER () FROM t2);

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

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

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

SELECT f1, f2, f3, lag(f1, nullif(f1, 1)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(nullif(f1, 4)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

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

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f3) OVER (PARTITION BY f2 ORDER BY f1)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

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

SELECT f1, f2, f3, lead(f1, nullif(f1, 1)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(nullif(f1, 4)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

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

SELECT f1, first_value(f1) OVER (PARTITION BY f1)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, lag(0, f1 , 0) OVER (PARTITION BY f1 ORDER BY f1) FROM t3 GROUP BY f1 ORDER BY 1

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

SELECT false::int

-- sqlfmt-corpus-separator --

SELECT floor(-1.5::float), floor(1.5::float), floor(9.123456789::decimal)

-- sqlfmt-corpus-separator --

SELECT floor(1.234), floor(-1.234), floor('NaN'::numeric)

-- sqlfmt-corpus-separator --

SELECT floor(CAST (1.1 AS double precision))

-- sqlfmt-corpus-separator --

SELECT floor(CAST (1.1 AS float))

-- sqlfmt-corpus-separator --

SELECT floor(cast(1 AS bigint))

-- sqlfmt-corpus-separator --

SELECT fnv32(NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT from_ip(b'')

-- sqlfmt-corpus-separator --

SELECT from_uuid(b'f00d')

-- sqlfmt-corpus-separator --

SELECT generate_series(DISTINCT 1, 1)

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('[2:4]={1,2,3,4}'::int[], 1) AS s;

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('{1,2,3,4}'::TEXT[], 1) AS s;

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('{1,2,3,4}'::int[], -1) AS s;

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('{1,2,3,4}'::int[], 0) AS s;

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('{1,2,3,4}'::int[], 1) AS s;

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('{1,2,3,4}'::int[], 1), repeat_row(generate_series(1, 1)) AS s

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('{1,2,3,4}'::int[], 12345) AS s;

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('{1,2,3,4}'::int[], 2) AS s;

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('{1,NULL,3,NULL}'::int[], 1) AS s;

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('{{1,2,3,4}, {5,6,7,8}}'::int[], 1) AS s;

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('{{1,2,3,4}, {5,6,7,8}}'::int[], 2) AS s;

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

SELECT has_cluster_privilege(((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 'c', 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_connection_privilege('joe', ((SELECT MAX(oid::int8) FROM mz_objects) + 1)::text::oid, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_connection_privilege(((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 'conn', 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_database_privilege('joe', ((SELECT MAX(oid::int8) FROM mz_objects) + 1)::text::oid, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_database_privilege(((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 'd', 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_role('materialize', ((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_role(((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 'materialize', 'MEMBER')

-- sqlfmt-corpus-separator --

SELECT has_schema_privilege('joe', ((SELECT MAX(oid::int8) FROM mz_objects) + 1)::text::oid, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_schema_privilege(((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 'sch', 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_secret_privilege('joe', ((SELECT MAX(oid::int8) FROM mz_objects) + 1)::text::oid, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_secret_privilege(((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 'se', 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_system_privilege(((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 'CREATECLUSTER')

-- sqlfmt-corpus-separator --

SELECT has_table_privilege('joe', ((SELECT MAX(oid::int8) FROM mz_objects) + 1)::text::oid, 'SELECT')

-- sqlfmt-corpus-separator --

SELECT has_table_privilege(((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 't', 'SELECT')

-- sqlfmt-corpus-separator --

SELECT has_type_privilege('joe', ((SELECT MAX(oid::int8) FROM mz_objects) + 1)::text::oid, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_type_privilege(((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 'ty', 'USAGE')

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

SELECT id, normalize(text, NFKC) FROM test_normalize ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, schema_id, name, type, connection_id, size FROM mz_sources WHERE id LIKE 'u%'

-- sqlfmt-corpus-separator --

SELECT int4range(-1,1) @> 0.1::float;

-- sqlfmt-corpus-separator --

SELECT int8range(-1,1) @> 0.1::float;

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

SELECT json_build_object('{1,2,3}'::int[],3)

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

SELECT jsonb_build_object('a',1,'b',1.2::float,'c',true,'d',null,'e','{"x":3,"y":[1,2,3]}'::JSONB)

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

SELECT k, abs(k) FILTER (WHERE k=1) FROM kv

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v LIKE 'ABC%'

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v LIKE 'ABC%Z'

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v SIMILAR TO 'ABC_*'

-- sqlfmt-corpus-separator --

SELECT kafka_murmur2('\x666f6f626172'::bytea)

-- sqlfmt-corpus-separator --

SELECT l1.la, l1.lb
FROM l as l1
WHERE l1.la IN (
    SELECT l2.la + 1
    FROM l AS l2
    WHERE l2.la IN (
        SELECT l3.la + 1
        FROM l as l3
    )
)

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

SELECT length(normalize('한글', NFC))

-- sqlfmt-corpus-separator --

SELECT length(normalize('한글', NFD))

-- sqlfmt-corpus-separator --

SELECT length(s), count(DISTINCT k), count(DISTINCT v), count(DISTINCT (v)) FROM kv GROUP BY length(s)

-- sqlfmt-corpus-separator --

SELECT length(x), encode(x::bytes, 'escape') from s

-- sqlfmt-corpus-separator --

SELECT list_agg('a'::char(2))::text

-- sqlfmt-corpus-separator --

SELECT list_agg('a'::char)::text

-- sqlfmt-corpus-separator --

SELECT list_agg(1)::text

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY (SELECT 'a' FROM t2))::text FROM t2;

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY (SELECT * FROM t2)) FROM t2

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY a DESC)::text FROM t2

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY a)::text FROM t2

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY b)::text FROM t2

-- sqlfmt-corpus-separator --

SELECT list_agg(a)::text FROM t1

-- sqlfmt-corpus-separator --

SELECT list_agg(a::text)::text FROM t1

-- sqlfmt-corpus-separator --

SELECT list_append(NULL, NULL)::text

-- sqlfmt-corpus-separator --

SELECT ln(-100.000::decimal)

-- sqlfmt-corpus-separator --

SELECT ln(-2.0::float), ln(2.0::float), ln(2.5::decimal)

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

SELECT log(10.0::float), log(100.000::decimal)

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

SELECT makeaclitem((SELECT oid FROM mz_roles WHERE name = 'materialize'), (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'CREATE, USAGE', false)::mz_catalog.mz_aclitem = mz_internal.make_mz_aclitem('u1', 'u2', 'CREATE, USAGE')

-- sqlfmt-corpus-separator --

SELECT makeaclitem((SELECT oid FROM mz_roles WHERE name = 'materialize'), (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'CREATE, USAGE', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem((SELECT oid FROM mz_roles WHERE name = 'materialize'), 87398, 'CREATE', false)::mz_catalog.mz_aclitem

-- sqlfmt-corpus-separator --

SELECT makeaclitem((SELECT oid FROM mz_roles WHERE name = 'materialize'), 87398, 'CREATE', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem(0, (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'CREATE, USAGE', false)::mz_catalog.mz_aclitem = mz_internal.make_mz_aclitem('p', 'u2', 'CREATE, USAGE')

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

SELECT makeaclitem(3251, 345, 'CREATE', false)::mz_catalog.mz_aclitem

-- sqlfmt-corpus-separator --

SELECT makeaclitem(3251, 345, 'CREATE', false)::text

-- sqlfmt-corpus-separator --

SELECT makeaclitem(99991, (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'CREATE', false)::mz_catalog.mz_aclitem

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

SELECT min(1), count(1), max(1), avg(1)::float, sum(1), stddev(1), variance(1)

-- sqlfmt-corpus-separator --

SELECT min(1), count(1), max(1), avg(1)::float, sum(1), stddev(1)::float, variance(1)::float FROM kv

-- sqlfmt-corpus-separator --

SELECT min(oid::int)::regproc::text FROM mz_objects WHERE name = 'max';

-- sqlfmt-corpus-separator --

SELECT mod(5.0::float, 2.0), mod(1.0::float, 0.0), mod(5, 2), mod(19.3::decimal, 2)

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

SELECT normalize('', NFKC)

-- sqlfmt-corpus-separator --

SELECT normalize('hello world')

-- sqlfmt-corpus-separator --

SELECT normalize('hello world', NFD)

-- sqlfmt-corpus-separator --

SELECT normalize('x²', NFC)

-- sqlfmt-corpus-separator --

SELECT normalize('x²', NFKC)

-- sqlfmt-corpus-separator --

SELECT normalize('Å')

-- sqlfmt-corpus-separator --

SELECT normalize('Å', NFD) = E'A\u030A'

-- sqlfmt-corpus-separator --

SELECT normalize('é')

-- sqlfmt-corpus-separator --

SELECT normalize('é', NFC)

-- sqlfmt-corpus-separator --

SELECT normalize('é', NFD) = E'e\u0301'

-- sqlfmt-corpus-separator --

SELECT normalize('é', Nfd) = E'e\u0301'

-- sqlfmt-corpus-separator --

SELECT normalize('é', nfc)

-- sqlfmt-corpus-separator --

SELECT normalize('Ⅻ', NFC)  -- Roman numeral XII (U+216B)

-- sqlfmt-corpus-separator --

SELECT normalize('Ⅻ', NFKC)

-- sqlfmt-corpus-separator --

SELECT normalize('한글', NFC)

-- sqlfmt-corpus-separator --

SELECT normalize('한글', NFC) = normalize('한글', NFD)

-- sqlfmt-corpus-separator --

SELECT normalize('ﬀ', NFKC)

-- sqlfmt-corpus-separator --

SELECT normalize('ﬁ', NFKC)

-- sqlfmt-corpus-separator --

SELECT normalize('ﬁ', NFKD)

-- sqlfmt-corpus-separator --

SELECT normalize('Ａ', NFC)  -- Full-width A (U+FF21)

-- sqlfmt-corpus-separator --

SELECT normalize('Ａ', NFKC)  -- Should become regular A

-- sqlfmt-corpus-separator --

SELECT normalize(NULL)

-- sqlfmt-corpus-separator --

SELECT normalize(NULL, NFC)

-- sqlfmt-corpus-separator --

SELECT now() + '1m'::interval > now(), now() + '1m'::interval >= now()

-- sqlfmt-corpus-separator --

SELECT now() + INTERVAL '100' HOUR > now()

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

SELECT numrange(-1.0,1.0) @> 0.1::float;

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

SELECT overlay('123456789' placing 'xxxx' from -1 for 6)

-- sqlfmt-corpus-separator --

SELECT overlay('123456789' placing 'xxxx' from 15 for 6)

-- sqlfmt-corpus-separator --

SELECT overlay('123456789' placing 'xxxx' from 3 for -1)

-- sqlfmt-corpus-separator --

SELECT overlay('123456789' placing 'xxxx' from 3 for -8)

-- sqlfmt-corpus-separator --

SELECT overlay('123456789' placing 'xxxx' from 3 for 10)

-- sqlfmt-corpus-separator --

SELECT overlay('123456789' placing 'xxxx' from 3 for 2)

-- sqlfmt-corpus-separator --

SELECT overlay('123456789' placing 'xxxx' from 3 for 6)

-- sqlfmt-corpus-separator --

SELECT overlay('123456789' placing 'xxxx' from 3)

-- sqlfmt-corpus-separator --

SELECT overlay('💩123456789' placing 'xxxxÂ' from 3 for 3)

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

SELECT peep, EXISTS(
  SELECT * FROM likes WHERE peep = liker
) FROM peeps

-- sqlfmt-corpus-separator --

SELECT peeps.peep, age < ALL (
  SELECT age FROM likes, age WHERE peeps.peep = liker AND likee = age.peep
) FROM peeps, age
WHERE peeps.peep = age.peep

-- sqlfmt-corpus-separator --

SELECT peeps.peep, age < ANY (
  SELECT age FROM likes, age WHERE peeps.peep = liker AND likee = age.peep
) FROM peeps, age
WHERE peeps.peep = age.peep

-- sqlfmt-corpus-separator --

SELECT pg_catalog.interval '1-2 3 4:5:6.7'

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_get_constraintdef(oid)
FROM pg_catalog.pg_constraint
WHERE conrelid='pg_constraintdef_test'::regclass

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_get_viewdef('pg_viewdef_view'::regclass::oid)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_get_viewdef('pg_viewdef_view'::regclass::oid, false)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_get_viewdef('pg_viewdef_view'::regclass::oid, true)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_table_is_visible('foo'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.timezone('JAPAN', TIMESTAMPTZ '95143-12-31 23:59:59+06' + INTERVAL '167 MILLENNIUM')

-- sqlfmt-corpus-separator --

SELECT pg_catalog.timezone(-INTERVAL '1' MINUTE, TIMESTAMP '95143-12-31 23:59:59' + INTERVAL '167 MILLENNIUM')

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

SELECT pg_has_role('materialize', ((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT pg_has_role(((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 'materialize', 'MEMBER')

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

SELECT pg_typeof('1'::bigint)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1'::int)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1'::integer)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1'::smallint)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1.2'::double)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1.2'::float(1))

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1.2'::float(53))

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1.2'::real)

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

SELECT pg_typeof('joe'::name);

-- sqlfmt-corpus-separator --

SELECT pg_typeof('true'::boolean)

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

SELECT pg_typeof(1::bigint + 1::uint2), 1::bigint + 1::uint2;

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::bigint + 1::uint4), 1::bigint + 1::uint4;

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::bigint + 1::uint8), 1::bigint + 1::uint8;

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::float(1))

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::float(53))

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::float)

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::integer + 1::uint2), 1::integer + 1::uint2;

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::integer + 1::uint4), 1::integer + 1::uint4;

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::integer + 1::uint8), 1::integer + 1::uint8;

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::smallint + 1::uint2), 1::smallint + 1::uint2;

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::smallint + 1::uint4), 1::smallint + 1::uint4;

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::smallint + 1::uint8), 1::smallint + 1::uint8;

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

SELECT pg_typeof(a::string[]::int[]) FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT pg_typeof(a::string[]::int[]::text[]::float8[]) FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT pg_typeof(mz_now()), pg_typeof(1::mz_timestamp)

-- sqlfmt-corpus-separator --

SELECT pg_typeof(text '1')

-- sqlfmt-corpus-separator --

SELECT pk FROM tab0 WHERE
(
  (
    col0 IN (
      SELECT col3 FROM tab0 WHERE col3 IN (
        SELECT col0 FROM tab0
      )
    )
  )
)

-- sqlfmt-corpus-separator --

SELECT pk FROM tab0 WHERE
(
  col3 IN (
    SELECT col0 FROM tab0
  )
  OR
  (
    col0 IN (
      SELECT col3 FROM tab0 WHERE col3 IN (
        SELECT col0 FROM tab0
      )
    )
  )
)

-- sqlfmt-corpus-separator --

SELECT pk FROM tab0 WHERE
(
  col3 IN (
    SELECT col0 FROM tab0
  )
)

-- sqlfmt-corpus-separator --

SELECT position('a' in 'high')

-- sqlfmt-corpus-separator --

SELECT position('ig' in 'high')

-- sqlfmt-corpus-separator --

SELECT position('str' IN 42)

-- sqlfmt-corpus-separator --

SELECT position('str' IN NULL)

-- sqlfmt-corpus-separator --

SELECT position('ः॑' IN 'रः॑')

-- sqlfmt-corpus-separator --

SELECT position(42 IN 'str')

-- sqlfmt-corpus-separator --

SELECT position(NULL IN 'str')

-- sqlfmt-corpus-separator --

SELECT position(e'\u0903\u0951' IN e'\u0930\u0903\u0951')

-- sqlfmt-corpus-separator --

SELECT position(vccol1 IN vccol2) FROM positiontest

-- sqlfmt-corpus-separator --

SELECT pow('NaN'::numeric, -2.5), pow(-2.5, 'NaN'::numeric);

-- sqlfmt-corpus-separator --

SELECT pow(-1::numeric, '-.1'::numeric)

-- sqlfmt-corpus-separator --

SELECT pow(-2::int, 3::int), pow(2::int, 3::int)

-- sqlfmt-corpus-separator --

SELECT pow(-2::numeric, -2111176704::numeric)::text;

-- sqlfmt-corpus-separator --

SELECT pow(-2::numeric, 2111176704::numeric)::text;

-- sqlfmt-corpus-separator --

SELECT pow(-3.0::float, 2.0), power(3.0::float, 2.0), pow(5.0::decimal, 2.0)

-- sqlfmt-corpus-separator --

SELECT pow(0::float, 10000)

-- sqlfmt-corpus-separator --

SELECT pow(0::int, -3::int)

-- sqlfmt-corpus-separator --

SELECT pow(0::int, 0::int)

-- sqlfmt-corpus-separator --

SELECT pow(0::int, 3::int), pow(3::int, 0::int), pow(-3::int, 0::int)

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

SELECT pow(2::int, -3::int)

-- sqlfmt-corpus-separator --

SELECT pow(2::numeric, 3::numeric), pow(2.5, -3.5)

-- sqlfmt-corpus-separator --

SELECT pow(3::float, -10000)

-- sqlfmt-corpus-separator --

SELECT pow(3::float, 10000)

-- sqlfmt-corpus-separator --

SELECT pow(4.727998800941528e-14::DECIMAL, 0.06081860494226844::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT pow(999::numeric, -9999::numeric);

-- sqlfmt-corpus-separator --

SELECT pow(999::numeric, 9999::numeric);

-- sqlfmt-corpus-separator --

SELECT pow(9::decimal(15, 5), 0.5::decimal(15, 5));

-- sqlfmt-corpus-separator --

SELECT pow(9::float, 0.5);

-- sqlfmt-corpus-separator --

SELECT pow(CAST (pi() AS DECIMAL), DECIMAL '2.0')

-- sqlfmt-corpus-separator --

SELECT pow(sqrt(1e-10::DECIMAL), 2), sqrt(pow(1e-5::DECIMAL, 2))

-- sqlfmt-corpus-separator --

SELECT power(-2.0::float, 1.5)

-- sqlfmt-corpus-separator --

SELECT power(0::decimal, -1)

-- sqlfmt-corpus-separator --

SELECT power(0::float, -1);

-- sqlfmt-corpus-separator --

SELECT power(9::decimal(15, 5), 0.5::decimal(15, 5));

-- sqlfmt-corpus-separator --

SELECT power(9::float, 0.5);

-- sqlfmt-corpus-separator --

SELECT privileges::text FROM mz_system_privileges

-- sqlfmt-corpus-separator --

SELECT privileges::text[] FROM mz_views;

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT ALL SELECT DISTINCT q2 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT ALL SELECT q2 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT SELECT q2 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT SELECT q2 FROM int8_tbl ORDER BY q2 LIMIT 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl INTERSECT (((SELECT q2 FROM int8_tbl UNION ALL SELECT q2 FROM int8_tbl))) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl INTERSECT SELECT q2 FROM int8_tbl UNION ALL SELECT q2 FROM int8_tbl  ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl UNION ALL (((SELECT q2 FROM int8_tbl EXCEPT SELECT q1 FROM int8_tbl ORDER BY 1)))

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl UNION ALL SELECT q2 FROM int8_tbl EXCEPT SELECT q1 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1,q2 FROM int8_tbl EXCEPT SELECT q2,q1 FROM int8_tbl
ORDER BY q2,q1

-- sqlfmt-corpus-separator --

SELECT q2 FROM int8_tbl EXCEPT ALL SELECT DISTINCT q1 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q2 FROM int8_tbl EXCEPT ALL SELECT q1 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q2 FROM int8_tbl EXCEPT SELECT q1 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q2 FROM int8_tbl INTERSECT ALL SELECT q1 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q2 FROM int8_tbl INTERSECT SELECT q1 FROM int8_tbl ORDER BY 1

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

SELECT repeat('1234567890'::string, 6978072892806141784::int)

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

SELECT round('inf'::float), round('inf'::float, 1), round('-inf'::float), round('-inf'::float, 1)

-- sqlfmt-corpus-separator --

SELECT round('nan'::decimal), round('nan'::decimal, 1), round('nan'::float), round('nan'::float, 1)

-- sqlfmt-corpus-separator --

SELECT round(-1.23456789e+308::float, -308), round(1.23456789e+308::float, -308)

-- sqlfmt-corpus-separator --

SELECT round(-1.7976931348623157e+308::float, -303), round(1.7976931348623157e+308::float, -303)

-- sqlfmt-corpus-separator --

SELECT round(-1.7976931348623157e+308::float, 1), round(1.7976931348623157e+308::float, 1)

-- sqlfmt-corpus-separator --

SELECT round(-1.7976931348623157e-308::float, 1), round(1.7976931348623157e-308::float, 1)

-- sqlfmt-corpus-separator --

SELECT round(-2.5::decimal), round(-1.5::decimal), round(0.0::decimal), round(1.5::decimal), round(2.5::decimal)

-- sqlfmt-corpus-separator --

SELECT round(-2.5::decimal, 0), round(-1.5::decimal, 0), round(1.5::decimal, 0), round(2.5::decimal, 0)

-- sqlfmt-corpus-separator --

SELECT round(-2.5::decimal, 3), round(-1.5::decimal, 3), round(0.0::decimal, 3), round(1.5::decimal, 3), round(2.5::decimal, 3)

-- sqlfmt-corpus-separator --

SELECT round(-2.5::float), round(-1.5::float), round(-0.0::float), round(0.0::float), round(1.5::float), round(2.5::float)

-- sqlfmt-corpus-separator --

SELECT round(-2.5::float, 0), round(-1.5::float, 0), round(1.5::float, 0), round(2.5::float, 0)

-- sqlfmt-corpus-separator --

SELECT round(1.23::float, 1);

-- sqlfmt-corpus-separator --

SELECT round(1.390671161567e-309::float), round(0.49999999999999994::float), round(0.5000000000000001::float), round(2251799813685249.5::float), round(2251799813685250.5::float), round(4503599627370495.5::float), round(4503599627370497::float)

-- sqlfmt-corpus-separator --

SELECT round(1.5678, CAST ((SELECT n FROM nums) AS integer))

-- sqlfmt-corpus-separator --

SELECT round(123.456::decimal, -1), round(123.456::decimal, -2), round(123.456::decimal, -3), round(123.456::decimal, -200)

-- sqlfmt-corpus-separator --

SELECT round(123.456::float, -1), round(123.456::float, -2), round(123.456::float, -3)

-- sqlfmt-corpus-separator --

SELECT round(123.456::float, -2438602134409251682)

-- sqlfmt-corpus-separator --

SELECT round(1::decimal, 3000)

-- sqlfmt-corpus-separator --

SELECT round(1e-308::float, 324)

-- sqlfmt-corpus-separator --

SELECT round(4.2::float, 0), round(4.2::float, 10), round(4.22222222::decimal, 3)

-- sqlfmt-corpus-separator --

SELECT round(5.0, CAST ((SELECT * FROM nums) AS integer))

-- sqlfmt-corpus-separator --

SELECT round(CAST (-1.4678 AS double precision))

-- sqlfmt-corpus-separator --

SELECT round(CAST (-1.4678 AS float))

-- sqlfmt-corpus-separator --

SELECT round(CAST (1.5678 AS double precision))

-- sqlfmt-corpus-separator --

SELECT round(CAST (1.5678 AS float))

-- sqlfmt-corpus-separator --

SELECT round(CAST (5.0 AS double precision), 3)

-- sqlfmt-corpus-separator --

SELECT round(CAST (5.0 AS float), 3)

-- sqlfmt-corpus-separator --

SELECT round(CAST (5.0 AS float), 3.0)

-- sqlfmt-corpus-separator --

SELECT round(CAST (5.0 AS float), CAST (3.0 AS float))

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

SELECT round(ln(13::float)::decimal(15, 5), 3)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER ()

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (), row_number() OVER ()

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (), row_number() OVER () from t

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

SELECT sqrt(-1.0::float)

-- sqlfmt-corpus-separator --

SELECT sqrt(-1::decimal(15, 2))

-- sqlfmt-corpus-separator --

SELECT sqrt(-1::double precision)

-- sqlfmt-corpus-separator --

SELECT sqrt(-1::float)

-- sqlfmt-corpus-separator --

SELECT sqrt(-2::numeric)

-- sqlfmt-corpus-separator --

SELECT sqrt(1.23783::decimal(15, 5))

-- sqlfmt-corpus-separator --

SELECT sqrt(1.23783::double)

-- sqlfmt-corpus-separator --

SELECT sqrt(1.23783::float)

-- sqlfmt-corpus-separator --

SELECT sqrt(2::numeric), sqrt(3::numeric), sqrt(0::numeric)

-- sqlfmt-corpus-separator --

SELECT sqrt(4.0::float), sqrt(9.0::decimal)

-- sqlfmt-corpus-separator --

SELECT sqrt(9.789765531128956e-34::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT stddev(1::int), stddev(1::float), stddev(1::decimal)

-- sqlfmt-corpus-separator --

SELECT stddev(x)::FLOAT, stddev(y::decimal)::FLOAT, stddev(z)::DECIMAL(38, 14) FROM xyz

-- sqlfmt-corpus-separator --

SELECT string_agg('foo', CAST ((SELECT NULL) AS BYTEA)) OVER ();

-- sqlfmt-corpus-separator --

SELECT strpos('hello world', 'world') = position('world' IN 'hello world')

-- sqlfmt-corpus-separator --

SELECT substring('12345' for 3)

-- sqlfmt-corpus-separator --

SELECT substring('RoacH' for 3 from 2)

-- sqlfmt-corpus-separator --

SELECT substring('RoacH' from 2 for 3)

-- sqlfmt-corpus-separator --

SELECT substring('RoacH' from 2)

-- sqlfmt-corpus-separator --

SELECT substring('abcdef' for -1)

-- sqlfmt-corpus-separator --

SELECT substring('abcdef' for 2147483647);

-- sqlfmt-corpus-separator --

SELECT substring('abcdef' for 3)

-- sqlfmt-corpus-separator --

SELECT substring('abcdef' from -1 for 3);

-- sqlfmt-corpus-separator --

SELECT substring('abcdef' from -1);

-- sqlfmt-corpus-separator --

SELECT substring('abcdef' from 2 for 2147483647);

-- sqlfmt-corpus-separator --

SELECT substring('abcdef' from 2)

-- sqlfmt-corpus-separator --

SELECT substring('abcdef' from 2147483647 for 2);

-- sqlfmt-corpus-separator --

SELECT substring('abcdef' from 2147483647 for 2147483647);

-- sqlfmt-corpus-separator --

SELECT substring('abcdef' from 3 for 3);

-- sqlfmt-corpus-separator --

SELECT substring('f(oabaroob' from '+(o(.)b' for '+')

-- sqlfmt-corpus-separator --

SELECT substring('f(oabaroob' from '\(o(.)b' for '+')

-- sqlfmt-corpus-separator --

SELECT substring('f(oabaroob' from '\(o(.)b')

-- sqlfmt-corpus-separator --

SELECT substring('foobar' from 'o.b')

-- sqlfmt-corpus-separator --

SELECT sum(1::int), sum(2::float), sum(3::decimal)

-- sqlfmt-corpus-separator --

SELECT sum(a ORDER BY b) FROM t2

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

SELECT t FROM timestamptzish WHERE t > TIMESTAMPTZ '1999-12-31 9:46:01-04' - INTERVAL '12' HOUR

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

SELECT timestamp(0) with time zone '95143-12-31 23:59:59.123456789';

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

SELECT timezone(INTERVAL '+11'HOUR, TIME '18:53:49')::time

-- sqlfmt-corpus-separator --

SELECT timezone(INTERVAL '+11'MONTH, TIME '18:53:49')

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

SELECT to_json(1.234::FLOAT)

-- sqlfmt-corpus-separator --

SELECT to_json(123::INT)

-- sqlfmt-corpus-separator --

SELECT to_json(3::OID::INT::OID)

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

SELECT to_jsonb('a'::char(10))

-- sqlfmt-corpus-separator --

SELECT to_jsonb('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'::UUID);

-- sqlfmt-corpus-separator --

SELECT to_jsonb(1.234::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(1.234::FLOAT)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(123::INT)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(3::OID::INT::OID)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(DATE '2019-12-31');

-- sqlfmt-corpus-separator --

SELECT to_jsonb(TIMESTAMP '1969-06-01 10:10:10.41');

-- sqlfmt-corpus-separator --

SELECT to_jsonb(false::BOOL)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(null::int)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(null::int[])

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

SELECT trim('   yxytrimyxy  ');

-- sqlfmt-corpus-separator --

SELECT trim('xy' FROM 'yxytrimyxy');

-- sqlfmt-corpus-separator --

SELECT trim('xy' from 'xyxtrimyyx')

-- sqlfmt-corpus-separator --

SELECT trim(BOTH '   yxytrimyxy  ');

-- sqlfmt-corpus-separator --

SELECT trim(BOTH 'xy' FROM 'yxytrimyxy');

-- sqlfmt-corpus-separator --

SELECT trim(BOTH FROM '  yxytrimyxy  ');

-- sqlfmt-corpus-separator --

SELECT trim(FROM '  yxytrimyxy  ');

-- sqlfmt-corpus-separator --

SELECT trim(LEADING '   yxytrimyxy');

-- sqlfmt-corpus-separator --

SELECT trim(LEADING 'xy' FROM 'yxytrimyxy');

-- sqlfmt-corpus-separator --

SELECT trim(TRAILING FROM 'yxytrimyxy  ');

-- sqlfmt-corpus-separator --

SELECT trim(both 'xy' from 'xyxtrimyyx')

-- sqlfmt-corpus-separator --

SELECT trim(leading '   trimxyz')

-- sqlfmt-corpus-separator --

SELECT trim(leading 'xyz' from 'zzzytrimxyz')

-- sqlfmt-corpus-separator --

SELECT trim(leading from '   trimxyz')

-- sqlfmt-corpus-separator --

SELECT trim(trailing 'xyz' from 'xyzzzzytrimxyz')

-- sqlfmt-corpus-separator --

SELECT trim(trailing from '01:02:03'::time::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from '1'::interval::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from '1'::jsonb::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from '2001 02-03'::date::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from '2002 03-04'::timestamp::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from '2003 04-05'::timestamptz::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from 'dog'::char(3)::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from 'dog'::text::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from 'dog'::varchar::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from '{}'::jsonb::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from 1.1::numeric::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from 1.2::double::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from 1.3::real::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from 1::bigint::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from 2::int::char(20));

-- sqlfmt-corpus-separator --

SELECT trim(trailing from TRUE::boolean::char(20));

-- sqlfmt-corpus-separator --

SELECT true FROM s1 WHERE EXISTS (SELECT true FROM s2 WHERE EXISTS (SELECT true FROM s3 WHERE a = s3.b))

-- sqlfmt-corpus-separator --

SELECT true FROM x WHERE j->'a' @> '2'::JSONB

-- sqlfmt-corpus-separator --

SELECT true::int

-- sqlfmt-corpus-separator --

SELECT true::string;

-- sqlfmt-corpus-separator --

SELECT trunc('NaN'::decimal), trunc('Inf'::float), trunc(0), trunc(-0)

-- sqlfmt-corpus-separator --

SELECT trunc(-0.0), trunc(0.0), trunc(1.9), trunc(19.5678::decimal)

-- sqlfmt-corpus-separator --

SELECT trunc(1.234), trunc(-1.234), trunc('NaN'::numeric)

-- sqlfmt-corpus-separator --

SELECT trunc(CAST (-1.4678 AS double precision))

-- sqlfmt-corpus-separator --

SELECT trunc(CAST (-1.4678 AS float))

-- sqlfmt-corpus-separator --

SELECT trunc(CAST (1.5678 AS double precision))

-- sqlfmt-corpus-separator --

SELECT trunc(CAST (1.5678 AS float))

-- sqlfmt-corpus-separator --

SELECT trunc(NULL::decimal)

-- sqlfmt-corpus-separator --

SELECT ts > TIMESTAMP '2016-06-13 00:00:00' FROM now_view

-- sqlfmt-corpus-separator --

SELECT unnest(privileges)::text FROM mz_types WHERE name = 'ty'

-- sqlfmt-corpus-separator --

SELECT usename, useconfig::text FROM pg_user;

-- sqlfmt-corpus-separator --

SELECT v FROM uniontest WHERE k = 1 EXCEPT ALL SELECT v FROM uniontest WHERE k = 2

-- sqlfmt-corpus-separator --

SELECT v FROM uniontest WHERE k = 1 EXCEPT SELECT v FROM uniontest WHERE k = 2

-- sqlfmt-corpus-separator --

SELECT v FROM uniontest WHERE k = 1 INTERSECT ALL SELECT v FROM uniontest WHERE k = 2

-- sqlfmt-corpus-separator --

SELECT v FROM uniontest WHERE k = 1 INTERSECT SELECT v FROM uniontest WHERE k = 2

-- sqlfmt-corpus-separator --

SELECT v FROM uniontest WHERE k = 1 UNION ALL SELECT v FROM uniontest WHERE k = 2

-- sqlfmt-corpus-separator --

SELECT v FROM uniontest WHERE k = 1 UNION ALL SELECT v FROM uniontest WHERE k = 2 ORDER BY 1 DESC LIMIT 2

-- sqlfmt-corpus-separator --

SELECT v FROM uniontest WHERE k = 1 UNION SELECT v FROM uniontest WHERE k = 2

-- sqlfmt-corpus-separator --

SELECT v, avg(k) FILTER (WHERE k > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, count(*) FILTER (WHERE count(*) > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, count(*) FILTER (WHERE count(1) > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, count(*) FILTER (WHERE k > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, mark, count(*) FILTER (WHERE k > 5), count(*), max(k) FILTER (WHERE k < 8) FROM filter_test GROUP BY v, mark

-- sqlfmt-corpus-separator --

SELECT v, variance(k) FILTER (WHERE k > 5), stddev(k) FILTER (WHERE k > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT variance(1::int), variance(1::float), variance(1::decimal)

-- sqlfmt-corpus-separator --

SELECT variance(x)::FLOAT, variance(y::decimal)::FLOAT, variance(z)::DECIMAL(38, 14) FROM xyz

-- sqlfmt-corpus-separator --

SELECT x FROM xyz WHERE x IN (SELECT x FROM xyz WHERE x = 7)

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

TABLE t UNION ALL TABLE t ORDER BY a LIMIT 5

-- sqlfmt-corpus-separator --

WITH
    t AS (SELECT true),
    t AS (SELECT false)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH a(x) AS (SELECT 'a') SELECT generate_series(1, 2), * FROM a ORDER BY generate_series

-- sqlfmt-corpus-separator --

WITH c AS (SELECT a + 1 FROM x) SELECT (SELECT * FROM c);

-- sqlfmt-corpus-separator --

WITH cte1 AS (SELECT 1 AS a, 2 AS a) SELECT * FROM cte1 WHERE cte1.a = 1

-- sqlfmt-corpus-separator --

WITH game_cnt AS (
SELECT split_part(game_id,' ', 2)::int AS game_id,
       COUNT(set_id) AS total_set_cnt,
       COUNT(set_id) FILTER (WHERE (green_cnt <= 13) AND (red_cnt <= 12) AND (blue_cnt <= 14)) AS possible_set_cnt
FROM aoc_1202
GROUP BY game_id
)
SELECT SUM(game_id) FROM game_cnt WHERE total_set_cnt = possible_set_cnt;

-- sqlfmt-corpus-separator --

WITH game_min AS (
SELECT split_part(game_id,' ', 2)::int AS game_id,
       MAX(green_cnt) AS green_min,
       MAX(red_cnt) AS red_min,
       MAX(blue_cnt) AS blue_min
FROM aoc_1202
GROUP BY split_part(game_id,' ', 2)::int
)
SELECT SUM(green_min*red_min*blue_min) FROM game_min;

-- sqlfmt-corpus-separator --

WITH options AS
(
	SELECT
	  (floor((time - sqrt(time * time - 4 * distance)) / 2) + 1)::int low,
	  (ceil((time + sqrt(time * time - 4 * distance)) / 2) - 1)::int hi
	FROM input
)
SELECT exp(sum(ln(hi - low + 1)))::int
FROM options;

-- sqlfmt-corpus-separator --

WITH q AS (SELECT 'foo' AS x)
SELECT x, pg_typeof(x)  FROM q;

-- sqlfmt-corpus-separator --

WITH squares_y AS (
    SELECT y FROM squares
  )
SELECT * FROM squares_y WHERE y IN (
  SELECT y * y FROM squares_y
)

-- sqlfmt-corpus-separator --

WITH t AS (SELECT a FROM x) SELECT a, x.t FROM t

-- sqlfmt-corpus-separator --

WITH t(a, b) AS (SELECT true a, false b)
  SELECT a, b FROM t

-- sqlfmt-corpus-separator --

WITH t(b) AS (SELECT a FROM x) SELECT b, t.b FROM t

-- sqlfmt-corpus-separator --

WITH t(b, a) AS (SELECT true a, false b)
  SELECT a, b FROM t

-- sqlfmt-corpus-separator --

WITH t(b, c) AS (SELECT a FROM x) SELECT b, t.b FROM t

-- sqlfmt-corpus-separator --

WITH t(x) AS (SELECT * FROM y WHERE a < 3)
  SELECT * FROM x WHERE a IN (
    SELECT a FROM t WHERE x.a = t.x
  )

-- sqlfmt-corpus-separator --

WITH t(x) AS (SELECT a FROM x)
  SELECT * FROM y WHERE a IN (SELECT x FROM t)

-- sqlfmt-corpus-separator --

WITH t(x) AS (WITH t(x) AS (SELECT 1) SELECT x * 10 FROM t) SELECT x + 2 FROM t

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

select ('0001-01-01'::date + '262141years 11months 30days')::date + '1day'

-- sqlfmt-corpus-separator --

select ('0001-01-01'::date + '262141years 11months 30days'::interval)::date

-- sqlfmt-corpus-separator --

select ('0001-01-01'::date - '1721389days'::interval)::date

-- sqlfmt-corpus-separator --

select ('0001-01-01'::date - '1721389days'::interval)::date - ('0001-01-01'::date + '262141years 11months 30days'::interval)::date, ('0001-01-01'::date + '262141years 11months 30days'::interval)::date - ('0001-01-01'::date - '1721389days'::interval)::date

-- sqlfmt-corpus-separator --

select ('0001-01-01'::date - '4713years 1months 8days')::date

-- sqlfmt-corpus-separator --

select ('0001-01-01'::date - interval '1 DAY')::date

-- sqlfmt-corpus-separator --

select ('0001-02-24'::date - interval '1 YEAR')::date

-- sqlfmt-corpus-separator --

select ('24:00'::TIME)::STRING

-- sqlfmt-corpus-separator --

select (select (a.*)::text) from view_a a

-- sqlfmt-corpus-separator --

select * from notinouter where a not in (select b from notininner)

-- sqlfmt-corpus-separator --

select 1 < 2.0::decimal, 1.0::decimal < 2, 2.0::decimal < 1, 2 < 1.0::decimal

-- sqlfmt-corpus-separator --

select 1 < 2.0::float, 1.0::float < 2, 2.0::float < 1, 2 < 1.0::float

-- sqlfmt-corpus-separator --

select 1 <= 1.0::decimal, 1.0::decimal <= 1, 2.0::decimal <= 1, 2 <= 1.0::decimal

-- sqlfmt-corpus-separator --

select 1 <= 1.0::float, 1.0::float <= 1, 2.0::float <= 1, 2 <= 1.0::float

-- sqlfmt-corpus-separator --

select 1 = 1.0::decimal, 1.0::decimal = 1, 1 = 2.0::decimal, 2.0::decimal = 1

-- sqlfmt-corpus-separator --

select 1 = 1.0::float, 1.0::float = 1, 1 = 2.0::float, 2.0::float = 1

-- sqlfmt-corpus-separator --

select 1 = all (select (select 1))

-- sqlfmt-corpus-separator --

select 1 >= 1.0::decimal, 1.0::decimal >= 1, 1.0::decimal >= 2, 1 >= 2.0::decimal

-- sqlfmt-corpus-separator --

select 1 >= 1.0::float, 1.0::float >= 1, 1.0::float >= 2, 1 >= 2.0::float

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

select 2 > 1.0::float, 2.0::float > 1, 1 > 2.0::float, 1.0::float > 2

-- sqlfmt-corpus-separator --

select 2 OPERATOR(*) 2 + 2;

-- sqlfmt-corpus-separator --

select 2::decimal > 1.0, 2.0 > 1::decimal, 1::decimal > 2.0, 1.0 > 2::decimal

-- sqlfmt-corpus-separator --

select TIMESTAMP '"2020-03-17 ~02:36:~56~"';

-- sqlfmt-corpus-separator --

select a.thousand from tenk1 a, tenk1 b
where a.thousand = b.thousand
  and exists ( select 1 from tenk1 c where b.hundred = c.hundred
                   and not exists ( select 1 from tenk1 d
                                    where a.thousand = d.thousand ) )

-- sqlfmt-corpus-separator --

select ceil(f1)::text as ceil_f1 from float8_tbl f

-- sqlfmt-corpus-separator --

select ceiling(f1)::text as ceiling_f1 from float8_tbl f;

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_abbrevs

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_names

-- sqlfmt-corpus-separator --

select exists(select * from nocolumns)

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

select position(strcol1 IN strcol2) from positiontest;

-- sqlfmt-corpus-separator --

select q1, count(*)::float8 / (select count(*) from int8_tbl)
from int8_tbl group by q1 order by q1

-- sqlfmt-corpus-separator --

select timezone('1 day'::interval, '1-12-31'::timestamptz+'262141 years'::interval)

-- sqlfmt-corpus-separator --

select unique1 from tenk1 except select unique2 from tenk1 where unique2 != 10

-- sqlfmt-corpus-separator --

with q as (select max(f1) from int4_tbl group by f1 order by f1)
  select q from q;

-- sqlfmt-corpus-separator --

with v as (select mz_now() < '3000-01-01') select * from v;