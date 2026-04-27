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

SELECT '          '::int[];

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

SELECT ' '::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::text > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ' '::varchar(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT '"'::int[];

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56# # +   00 ?  '::timestamp with time zone;

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56# # +   00 ?#'::timestamp with time zone;

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56# +   00   '::timestamp with time zone;

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56# +   00 ?  '::timestamp with time zone;

-- sqlfmt-corpus-separator --

SELECT '"2020!03-17 #?~T~02:36:56#+00~"'::timestamp with time zone;

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

SELECT ''''::int[];

-- sqlfmt-corpus-separator --

SELECT ''::CHAR(0)

-- sqlfmt-corpus-separator --

SELECT ''::CHAR(10485761)

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

SELECT ''::float::text

-- sqlfmt-corpus-separator --

SELECT ''::int[]

-- sqlfmt-corpus-separator --

SELECT ''::int[];

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

SELECT ''::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::text > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT ''::varchar(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT '++0'::float::text

-- sqlfmt-corpus-separator --

SELECT '+.0'::float::text

-- sqlfmt-corpus-separator --

SELECT '+0'::float::text

-- sqlfmt-corpus-separator --

SELECT '+0.'::float::text

-- sqlfmt-corpus-separator --

SELECT ','::int[];

-- sqlfmt-corpus-separator --

SELECT '--0'::float::text

-- sqlfmt-corpus-separator --

SELECT '-.0'::float::text

-- sqlfmt-corpus-separator --

SELECT '-0'::float::text

-- sqlfmt-corpus-separator --

SELECT '-0.'::float::text

-- sqlfmt-corpus-separator --

SELECT '-1e308'::float - '1e308'::float

-- sqlfmt-corpus-separator --

SELECT '-2147483648'::float4::int

-- sqlfmt-corpus-separator --

SELECT '-2147483777'::float4::int;

-- sqlfmt-corpus-separator --

SELECT '-Inf'::double precision::text, '-Infinity'::double precision::text, '-inFinIty'::double precision::text

-- sqlfmt-corpus-separator --

SELECT '-Inf'::float::text, '-Infinity'::float::text, '-inFinIty'::float::text

-- sqlfmt-corpus-separator --

SELECT '.0'::float::text

-- sqlfmt-corpus-separator --

SELECT '0.'::float::text

-- sqlfmt-corpus-separator --

SELECT '0.0'::float * '1e-200'::float

-- sqlfmt-corpus-separator --

SELECT '0.0'::float / 'Inf'::float

-- sqlfmt-corpus-separator --

SELECT '0.0e10'::float::text

-- sqlfmt-corpus-separator --

SELECT '000000.00000'::float::text

-- sqlfmt-corpus-separator --

SELECT '0001-01-01 12:00:00 +6'::TIMESTAMPTZ AT TIME ZONE '+5';

-- sqlfmt-corpus-separator --

SELECT '0001-01-01 12:00:00 -6'::TIMESTAMPTZ AT TIME ZONE '-5';

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::char(9)::time

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::bigint

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::boolean

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::integer

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::real

-- sqlfmt-corpus-separator --

SELECT '01:02:03'::time::smallint

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

SELECT '1'::int

-- sqlfmt-corpus-separator --

SELECT '1'::integer

-- sqlfmt-corpus-separator --

SELECT '1'::interval::bigint

-- sqlfmt-corpus-separator --

SELECT '1'::interval::boolean

-- sqlfmt-corpus-separator --

SELECT '1'::interval::integer

-- sqlfmt-corpus-separator --

SELECT '1'::interval::real

-- sqlfmt-corpus-separator --

SELECT '1'::interval::smallint

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::bigint;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::boolean;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::integer;

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb::smallint;

-- sqlfmt-corpus-separator --

SELECT '1'::materialize.pg_catalog.int4

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

SELECT '1'::smallint

-- sqlfmt-corpus-separator --

SELECT '1'::text::bigint

-- sqlfmt-corpus-separator --

SELECT '1'::text::integer

-- sqlfmt-corpus-separator --

SELECT '1'::text::real

-- sqlfmt-corpus-separator --

SELECT '1'::text::smallint

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::bigint

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::integer

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::real

-- sqlfmt-corpus-separator --

SELECT '1'::varchar::smallint

-- sqlfmt-corpus-separator --

SELECT '1.2'::float(1)

-- sqlfmt-corpus-separator --

SELECT '1.2'::float(53)

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

SELECT '1e200'::float * '-Inf'::float

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

SELECT '2'::jsonb::real;

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

SELECT '2001 02-03'::date::integer

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::real

-- sqlfmt-corpus-separator --

SELECT '2001 02-03'::date::smallint

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::bigint

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::boolean

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::integer

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::real

-- sqlfmt-corpus-separator --

SELECT '2002 03-04'::timestamp::smallint

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::bigint

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::boolean

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::integer

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::real

-- sqlfmt-corpus-separator --

SELECT '2003 04-05'::timestamptz::smallint

-- sqlfmt-corpus-separator --

SELECT '2007-02-01 15:04:05'::pg_catalog.timestamptz

-- sqlfmt-corpus-separator --

SELECT '2007-02-01'::pg_catalog.date

-- sqlfmt-corpus-separator --

SELECT '2147483583'::float4::int;

-- sqlfmt-corpus-separator --

SELECT '2147483648'::float4::int

-- sqlfmt-corpus-separator --

SELECT '3.4'::numeric UNION SELECT 'foo'

-- sqlfmt-corpus-separator --

SELECT '63616665-6630-3064-6465-616462656568'::pg_catalog.uuid

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

SELECT 'Inf'::float::text, 'Infinity'::float::text, 'inFinIty'::float::text, '+inf'::float::text, '+infinity'::float::text

-- sqlfmt-corpus-separator --

SELECT 'NaN'::FLOAT::DECIMAL, 'NaN'::DECIMAL

-- sqlfmt-corpus-separator --

SELECT 'NaN'::double precision::text, 'nan'::double precision::text, 'nAN'::double precision::text

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float::text, 'nan'::float::text, 'nAN'::float::text

-- sqlfmt-corpus-separator --

SELECT '[1:2]={1,2}'::int[]

-- sqlfmt-corpus-separator --

SELECT '\"\"2024-02-13 17:01:58.37848+00\"\"\"'::timestamp with time zone;

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

SELECT 'a '::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::text > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a '::varchar(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a' LIKE 'a' ESCAPE 'foo'

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::char;

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::varchar;

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

SELECT 'a'::int[];

-- sqlfmt-corpus-separator --

SELECT 'a'::pg_catalog.bytea

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::text > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'a'::varchar(30) > 'aaaaaa'::char(30);

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

SELECT 'aaaaa '::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::text > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa '::varchar(30) > 'aaaaaa'::char(30);

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

SELECT 'aaaaa'::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::text > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaa'::varchar(30) > 'aaaaaa'::char(30);

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

SELECT 'aaaaaa'::text < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::text > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(3) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) < 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) = 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ' '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ' '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ''::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > ''::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'a'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa '::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa '::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaaa'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'aaaaaa'::varchar(30) > 'aaaaaa'::char(30);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) !~ 'Abc'::char(4);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) !~~* 'Abc'::char(4);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) NOT ILIKE 'Abc'::char(4);

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

SELECT 'abc'::char::"char";

-- sqlfmt-corpus-separator --

SELECT 'abc'::text::"char";

-- sqlfmt-corpus-separator --

SELECT 'abc'::varchar::"char";

-- sqlfmt-corpus-separator --

SELECT 'ba%a!' LIKE 'ban%na!' ESCAPE 'n'

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

SELECT 'e'::float::text

-- sqlfmt-corpus-separator --

SELECT 'e10'::float::text

-- sqlfmt-corpus-separator --

SELECT 'foo'::text < 5::int;

-- sqlfmt-corpus-separator --

SELECT 'm'::regclass::oid::int

-- sqlfmt-corpus-separator --

SELECT 'materialize.public.t'::regclass::oid::int

-- sqlfmt-corpus-separator --

SELECT 'not test' = ANY (current_schemas(true))

-- sqlfmt-corpus-separator --

SELECT 'public' = ANY (current_schemas(true))

-- sqlfmt-corpus-separator --

SELECT 'result' || chr(10) || 'with' || chr(10) || 'newline', 'no newline in this one, but there are spaces'
UNION
SELECT 'one' || chr(10) || 'more' || chr(10) || 'row (with spaces)', 'easy'

-- sqlfmt-corpus-separator --

SELECT 's.m'::regclass::oid::int

-- sqlfmt-corpus-separator --

SELECT 's.t'::regclass::oid::int

-- sqlfmt-corpus-separator --

SELECT 's.t'::regtype::oid::int

-- sqlfmt-corpus-separator --

SELECT 't'::regclass::oid::int

-- sqlfmt-corpus-separator --

SELECT 't'::regtype::oid::int

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

SELECT 'x' AS "xxx", * FROM J1_TBL AS t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", t1.a, t2.e FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e) WHERE t1.a = t2.d

-- sqlfmt-corpus-separator --

SELECT '{  1,   2  , 3 }'::int[]

-- sqlfmt-corpus-separator --

SELECT '{  a}}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{  {a}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{" ",}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{"1":2,"3":4}'::pg_catalog.json

-- sqlfmt-corpus-separator --

SELECT '{"1":2,"3":4}'::pg_catalog.jsonb

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> null::int;

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> null::int;

-- sqlfmt-corpus-separator --

SELECT '{'',}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{'::int[];

-- sqlfmt-corpus-separator --

SELECT '{," "}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{,''}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{,1}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{,}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{1, 2, 3, null, NULL, nULL}'::int[]

-- sqlfmt-corpus-separator --

SELECT '{1, 2, 3} 4'::int[]

-- sqlfmt-corpus-separator --

SELECT '{1,2}'::public.bool::text;

-- sqlfmt-corpus-separator --

SELECT '{1,}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{a=>1}'::public.bool::text;

-- sqlfmt-corpus-separator --

SELECT '{a}}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{{  }'::int[];

-- sqlfmt-corpus-separator --

SELECT '{{1}, {2}}'::int[]

-- sqlfmt-corpus-separator --

SELECT '{{a}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{{{{{{{7}}}}}}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{{{{{{{7}}}}}}}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{{}'::int[];

-- sqlfmt-corpus-separator --

SELECT '{}  }'::int[];

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::bigint;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::boolean;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::integer;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::real;

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb::smallint;

-- sqlfmt-corpus-separator --

SELECT '{}}'::int[];

-- sqlfmt-corpus-separator --

SELECT '}'::int[];

-- sqlfmt-corpus-separator --

SELECT ('"-Infinity"'::jsonb)::float;

-- sqlfmt-corpus-separator --

SELECT ('"1"'::jsonb)::float;

-- sqlfmt-corpus-separator --

SELECT ('"Infinity"'::jsonb)::float;

-- sqlfmt-corpus-separator --

SELECT ('"NaN"'::jsonb)::float;

-- sqlfmt-corpus-separator --

SELECT ('1 2'::int2vector || '{3}'::int2[])::text;

-- sqlfmt-corpus-separator --

SELECT ('1'::jsonb)::float;

-- sqlfmt-corpus-separator --

SELECT ('1'::jsonb)::int;

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

SELECT ('[1]'::jsonb)::float;

-- sqlfmt-corpus-separator --

SELECT ('[1]'::jsonb)::int;

-- sqlfmt-corpus-separator --

SELECT ('nan'::float4 / '0'::float4)::text

-- sqlfmt-corpus-separator --

SELECT ('nan'::float4 / 'nan'::float4)::text

-- sqlfmt-corpus-separator --

SELECT ('nan'::float8 / '0'::float8)::text

-- sqlfmt-corpus-separator --

SELECT ('nan'::float8 / 'nan'::float8)::text

-- sqlfmt-corpus-separator --

SELECT ('{1,2}'::int2[] || '3'::int2vector)::text;

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

SELECT (1234567890123456789.012345 * 1234567890123456789.012345)::numeric(39,3);

-- sqlfmt-corpus-separator --

SELECT (12345678901234567890::numeric(39,3) * 12345678901234567890::numeric(39,3))::numeric(39,3);

-- sqlfmt-corpus-separator --

SELECT (5 + 3)::text;

-- sqlfmt-corpus-separator --

SELECT (999999999999999999999999999999999999.123 + 1::numeric)::numeric(39,3);

-- sqlfmt-corpus-separator --

SELECT (CAST(-6734743351254754 AS bigint) * CAST(-99783359317598 AS bigint))

-- sqlfmt-corpus-separator --

SELECT (INTERVAL '1-3' YEAR TO MONTH)::text

-- sqlfmt-corpus-separator --

SELECT (SELECT 1) IN (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT (SELECT 123 AS a),
       (VALUES (cos(1)::INT)),
       (SELECT cos(0)::INT)

-- sqlfmt-corpus-separator --

SELECT (SELECT 123 IN (VALUES (1), (2)))

-- sqlfmt-corpus-separator --

SELECT (avg(k) * 2.0 + max(v)::DECIMAL)::FLOAT FROM kv

-- sqlfmt-corpus-separator --

SELECT (avg(k) * 2.0 + max(v)::DECIMAL)::FLOAT FROM kv WHERE w*2 = k

-- sqlfmt-corpus-separator --

SELECT (interval '-1' day + interval '1' day) = (interval '1' day + interval '-1' day)

-- sqlfmt-corpus-separator --

SELECT (list_agg(a ORDER BY a) FILTER (WHERE b > '2050-01-01'))::text FROM t2

-- sqlfmt-corpus-separator --

SELECT (list_agg(a ORDER BY a) FILTER (WHERE b IS NOT NULL))::text FROM t2

-- sqlfmt-corpus-separator --

SELECT (list_agg(a) FILTER (WHERE a IS NOT NULL))::text FROM t1

-- sqlfmt-corpus-separator --

SELECT (list_agg(a) FILTER (WHERE a IS NULL))::text FROM t1

-- sqlfmt-corpus-separator --

SELECT (list_append(NULL, NULL::INT))::text

-- sqlfmt-corpus-separator --

SELECT (map_agg(a::TEXT, a) FILTER (WHERE a = 1))::TEXT FROM t1

-- sqlfmt-corpus-separator --

SELECT (map_agg(a::TEXT, a) FILTER (WHERE a IS NOT NULL))::TEXT FROM t1

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

SELECT * FROM abc WHERE a < ALL(SELECT a FROM abc WHERE a >= 2)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a < ALL(SELECT a FROM abc)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a < ANY(SELECT a FROM abc WHERE b = 30) ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = ANY(SELECT a FROM abc WHERE b = 10)

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

SELECT * FROM c WHERE bill = ANY(SELECT ship FROM o);

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

SELECT * FROM int WHERE a IS DISTINCT FROM 2

-- sqlfmt-corpus-separator --

SELECT * FROM int WHERE a IS NOT DISTINCT FROM 2

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE (k,v) IN (SELECT * FROM kv)

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE k IN (SELECT k FROM kv)

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

SELECT * FROM t3 WHERE NOT ((t3.c0 != 0.6) AND (t3.c0 != -0.1) AND (t3.c0 != 0.1) AND (-0.1 != t3.c0));

-- sqlfmt-corpus-separator --

SELECT * FROM t3 WHERE t3.c0 = 0.8::INT OR t3.c0 = -0.1;

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

SELECT -(.1 * 2.2)

-- sqlfmt-corpus-separator --

SELECT -(0.1 - 0.10);

-- sqlfmt-corpus-separator --

SELECT -(1.23 - 2.34)

-- sqlfmt-corpus-separator --

SELECT -12.0::float::uint2

-- sqlfmt-corpus-separator --

SELECT -12.0::float::uint4

-- sqlfmt-corpus-separator --

SELECT -12.0::float::uint8

-- sqlfmt-corpus-separator --

SELECT -7::numeric::int, -7.3::int, -7.5::int

-- sqlfmt-corpus-separator --

SELECT 0, -0, 0::int, -0::int, '0'::int, '-0'::int

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

SELECT 0::bigint::bool

-- sqlfmt-corpus-separator --

SELECT 0::int::bool

-- sqlfmt-corpus-separator --

SELECT 0::numeric::int, '-0'::numeric::int

-- sqlfmt-corpus-separator --

SELECT 1 % CAST (0.0 AS float)

-- sqlfmt-corpus-separator --

SELECT 1 + CAST ('5' AS double precision)

-- sqlfmt-corpus-separator --

SELECT 1 / CAST (0.0 AS float)

-- sqlfmt-corpus-separator --

SELECT 1 < ALL(SELECT * FROM nullary)

-- sqlfmt-corpus-separator --

SELECT 1 < ALL(SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT 1 < ALL(VALUES(NULL))

-- sqlfmt-corpus-separator --

SELECT 1 = ALL(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 = ANY(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 = SOME(SELECT 1)

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

SELECT 1.1::numeric::integer;

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::real;

-- sqlfmt-corpus-separator --

SELECT 1.1::numeric::smallint;

-- sqlfmt-corpus-separator --

SELECT 1.1::text, 1.1::float::text, 1.1::double::text

-- sqlfmt-corpus-separator --

SELECT 1.234567890123456789::float, round(1.234567890123456789::float, 15), round(1.234567890123456789::float, 16), round(1.234567890123456789::float, 17)

-- sqlfmt-corpus-separator --

SELECT 1.2::double::bigint;

-- sqlfmt-corpus-separator --

SELECT 1.2::double::boolean

-- sqlfmt-corpus-separator --

SELECT 1.2::double::integer;

-- sqlfmt-corpus-separator --

SELECT 1.2::double::real;

-- sqlfmt-corpus-separator --

SELECT 1.2::double::smallint;

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

SELECT 12.0::float::uint2

-- sqlfmt-corpus-separator --

SELECT 12.0::float::uint4

-- sqlfmt-corpus-separator --

SELECT 12.0::float::uint8

-- sqlfmt-corpus-separator --

SELECT 12.4::float::uint2

-- sqlfmt-corpus-separator --

SELECT 12.4::float::uint4

-- sqlfmt-corpus-separator --

SELECT 12.4::float::uint8

-- sqlfmt-corpus-separator --

SELECT 12.6::float::uint2

-- sqlfmt-corpus-separator --

SELECT 12.6::float::uint4

-- sqlfmt-corpus-separator --

SELECT 12.6::float::uint8

-- sqlfmt-corpus-separator --

SELECT 120129019392::bigint::oid;

-- sqlfmt-corpus-separator --

SELECT 124::uint2::real

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

SELECT 15445::uint8::real

-- sqlfmt-corpus-separator --

SELECT 18446744073709551615::uint8 / 9223372036854775807::bigint;

-- sqlfmt-corpus-separator --

SELECT 18446744073709553664.0::float::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709553664.5::float::uint8

-- sqlfmt-corpus-separator --

SELECT 18446744073709553665::float::uint8

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

SELECT 1::int

-- sqlfmt-corpus-separator --

SELECT 1::int4 IS DISTINCT FROM 1::int8

-- sqlfmt-corpus-separator --

SELECT 1::int4 IS DISTINCT FROM 2::int8

-- sqlfmt-corpus-separator --

SELECT 1::int4 IS NOT DISTINCT FROM 1::int8

-- sqlfmt-corpus-separator --

SELECT 1::mz_catalog.mz_timestamp

-- sqlfmt-corpus-separator --

SELECT 1::numeric / (-1::numeric + 1.0);

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

SELECT 2 OPERATOR(*) 2 + 2, 2 * 2 + 2

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

SELECT 3 IN (SELECT c FROM t ORDER BY 1 ASC) AS r

-- sqlfmt-corpus-separator --

SELECT 3::OID::INT::OID

-- sqlfmt-corpus-separator --

SELECT 3::decimal IN (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 3::decimal IN (SELECT 1::int)

-- sqlfmt-corpus-separator --

SELECT 4 IN (SELECT c FROM t ORDER BY 1 DESC) AS r

-- sqlfmt-corpus-separator --

SELECT 4294967295.4::float::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967295.5::float::uint4

-- sqlfmt-corpus-separator --

SELECT 4294967296.0::float::uint8

-- sqlfmt-corpus-separator --

SELECT 4294967296::float::uint4

-- sqlfmt-corpus-separator --

SELECT 65535.4::float::uint2

-- sqlfmt-corpus-separator --

SELECT 65535.5::float::uint2

-- sqlfmt-corpus-separator --

SELECT 65536.0::float::uint2

-- sqlfmt-corpus-separator --

SELECT 65536.0::float::uint4

-- sqlfmt-corpus-separator --

SELECT 65536.0::float::uint8

-- sqlfmt-corpus-separator --

SELECT 6789::uint4::real

-- sqlfmt-corpus-separator --

SELECT 7::numeric::int, 7.3::int, 7.5::int

-- sqlfmt-corpus-separator --

SELECT 9223372036854775806::bigint+1::bigint

-- sqlfmt-corpus-separator --

SELECT 9223372036854775807::bigint / 18446744073709551615::uint8;

-- sqlfmt-corpus-separator --

SELECT 9223372036854775807::bigint+1::bigint

-- sqlfmt-corpus-separator --

SELECT 9223372036854775807::bigint-(-1)::bigint

-- sqlfmt-corpus-separator --

SELECT 99::bigint::bool

-- sqlfmt-corpus-separator --

SELECT 99::int::bool

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

SELECT ARRAY[1] UNION ALL SELECT ARRAY['foo']

-- sqlfmt-corpus-separator --

SELECT CAST ('+Inf' AS double precision), CAST ('inf' AS double precision)

-- sqlfmt-corpus-separator --

SELECT CAST (CAST (1 as int) AS text)

-- sqlfmt-corpus-separator --

SELECT CAST (CAST (1.1 AS double precision) AS text)

-- sqlfmt-corpus-separator --

SELECT CAST(5 + 3 AS text);

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

SELECT DATE '2000-01-01' + INTERVAL '4' HOUR

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + INTERVAL '7 5:4:3.2' DAY TO SECOND

-- sqlfmt-corpus-separator --

SELECT DATE '2000-01-01' + INTERVAL '7' DAY

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

SELECT DATE '2001-01-01' + INTERVAL '3' YEAR

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(((x)), (x, y)) x, y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz ORDER BY row_number() OVER(ORDER BY (pk1, pk2)) DESC

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

SELECT INTERVAL '-1.2345649' SECOND(5);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1.23456789' SECOND(2);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1.23456789' SECOND(5);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483647' MONTH * 1.01

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2562047788:00:54.775808' SECOND(2);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.00000001 min 0.0006 millisecond 3.5 microsecond' SECOND(5);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:02:03' MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 2-3 4:5' DAY

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 day 2-3 4' SECOND(7);

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

SELECT INTERVAL '1-2 3' HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3' MONTH;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-3' YEAR TO MONTH

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.2345649' SECOND(5);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.23456789' SECOND

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.23456789' SECOND(2);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.23456789' SECOND(5);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5555 month 2 3:4:5.6' DAY TO HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5555 month 2 3:4:5.6' HOUR;

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

SELECT INTERVAL '1:2:3.4 5-6 7' DAY;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:3.4 5-6 7' YEAR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:31.23456789' MINUTE TO SECOND(2);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2' HOUR - TIMESTAMPTZ '2000-01-01 00:00:00-04'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647' MONTH / 0.99

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2562047788:00:54.775807' SECOND(2);

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

SELECT INTERVAL '6' HOUR + TIMESTAMPTZ '2000-01-01 00:00:00-04'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '7' DAY + DATE '2000-01-01'

-- sqlfmt-corpus-separator --

SELECT NOT 0::bigint::bool

-- sqlfmt-corpus-separator --

SELECT NOT 0::int::bool

-- sqlfmt-corpus-separator --

SELECT NULL IS DISTINCT FROM 1

-- sqlfmt-corpus-separator --

SELECT NULL IS DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT NULL IS NOT DISTINCT FROM 1

-- sqlfmt-corpus-separator --

SELECT NULL IS NOT DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT NULL::INT[] || NULL::INT[]

-- sqlfmt-corpus-separator --

SELECT NULLIF(1, 2), NULLIF(2, 2), NULLIF(NULL, NULL)

-- sqlfmt-corpus-separator --

SELECT OVERLAY(nonexistent.* PLACING 'string' FROM 'string')

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2000-01-01 00:00:00' + INTERVAL '1' YEAR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2000-01-01 00:00:00' + INTERVAL '7' HOUR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2000-01-01 00:00:00' - INTERVAL '1' YEAR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2020-12-21 18:53:49' AT TIME ZONE 'America/New_York'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2020-12-21 18:53:49' AT TIME ZONE 'PST'

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-04' * INTERVAL '2' HOUR

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-04' + INTERVAL '3' MINUTE

-- sqlfmt-corpus-separator --

SELECT TIMESTAMPTZ '2000-01-01 00:00:00-04' + INTERVAL '7' HOUR

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

SELECT a FROM a WHERE a > 2 UNION ALL (SELECT a FROM c WHERE b > 2) LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT a FROM fizz WHERE a < ALL(SELECT val1 FROM baz ORDER BY val1 DESC limit 5)

-- sqlfmt-corpus-separator --

SELECT a FROM fizz WHERE a > ANY(SELECT val1 FROM baz ORDER BY val1 offset 3 ROWS)

-- sqlfmt-corpus-separator --

SELECT a FROM fizz WHERE a IN (SELECT val1 FROM baz ORDER BY val1 offset 0 rows)

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

SELECT a, array_agg(b), string_agg(c, ',' ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT a, b FROM foo
ORDER BY a IN (SELECT length(b)-1 FROM foo), -a;

-- sqlfmt-corpus-separator --

SELECT a.f1 FROM (SELECT 'test' AS f1 FROM varchar_tbl) a
UNION
SELECT b.f1 FROM (SELECT f1 FROM varchar_tbl) b
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT a::string[]::int[]::text[]::float8[] FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT abc.b FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT abc.foo1 FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT abs(-1.2::float), abs(1.2::float), abs(-0.0::float), abs(0), abs(1), abs(-1.2121::decimal)

-- sqlfmt-corpus-separator --

SELECT abs(1) FILTER (WHERE false)

-- sqlfmt-corpus-separator --

SELECT array_agg('a'::char(2))

-- sqlfmt-corpus-separator --

SELECT array_agg('a'::char)

-- sqlfmt-corpus-separator --

SELECT array_agg(a) FILTER (WHERE a IS NOT NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT array_agg(a) FILTER (WHERE a IS NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT array_cat(ARRAY(SELECT x FROM xs), ARRAY(SELECT y FROM ys ORDER BY y DESC))::text

-- sqlfmt-corpus-separator --

SELECT array_cat(ARRAY(SELECT x FROM xs), ARRAY(SELECT y FROM ys))::text

-- sqlfmt-corpus-separator --

SELECT array_cat(NULL::INT[], NULL::INT[])

-- sqlfmt-corpus-separator --

SELECT array_fill(null::int, null);

-- sqlfmt-corpus-separator --

SELECT array_remove(NULL::INT[], 1)

-- sqlfmt-corpus-separator --

SELECT array_remove(NULL::INT[], NULL::INT)

-- sqlfmt-corpus-separator --

SELECT array_to_json('{1,2,3}'::INT[])

-- sqlfmt-corpus-separator --

SELECT avg(1::int)::float, avg(2::float)::float, avg(3::decimal)::float

-- sqlfmt-corpus-separator --

SELECT avg(k)::FLOAT, avg(v)::FLOAT, sum(k)::FLOAT, sum(v)::FLOAT FROM kv

-- sqlfmt-corpus-separator --

SELECT b != ALL(SELECT a FROM x) FROM y

-- sqlfmt-corpus-separator --

SELECT b::int[] FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c != TIMESTAMP '2008-12-01 09:09:09.9' + INTERVAL '1' MONTH

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c != TIMESTAMP '2008-12-31 09:09:09.9' + INTERVAL '1' DAY

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c < TIMESTAMP '2008-12-31 09:09:09.9' + INTERVAL '2' MONTH

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c = TIMESTAMP '2008-12-01 09:09:09.9' + INTERVAL '1' MONTH

-- sqlfmt-corpus-separator --

SELECT c FROM timestamp_compares WHERE c = TIMESTAMP '2008-12-31 09:09:09.9' + INTERVAL '1' DAY

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

SELECT ceil(CAST (1.1 AS double precision))

-- sqlfmt-corpus-separator --

SELECT ceil(CAST (1.1 AS float))

-- sqlfmt-corpus-separator --

SELECT ceil(cast(1 AS bigint))

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

SELECT concat_ws(null, interval '1d', null, 1.23::numeric, null, 4.57::float, null);

-- sqlfmt-corpus-separator --

SELECT count(*) FROM fizz WHERE exists(SELECT val1 FROM baz ORDER BY val1 limit 0)

-- sqlfmt-corpus-separator --

SELECT count(*), v/(k+v) FROM kv GROUP BY k+v

-- sqlfmt-corpus-separator --

SELECT count(2::int), count(3::float), count(4::decimal)

-- sqlfmt-corpus-separator --

SELECT d::text[][1][1] FROM array_t2;

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

SELECT date_trunc('century', TIMESTAMP '0001-01-01 00:00:00.000000' - INTERVAL '1'SECOND)

-- sqlfmt-corpus-separator --

SELECT date_trunc('decade', TIMESTAMP '0001-01-01 00:00:00.000000' - INTERVAL '2'YEAR)

-- sqlfmt-corpus-separator --

SELECT date_trunc('millennium', TIMESTAMP '0001-01-01 00:00:00.000000' - INTERVAL '1'SECOND)

-- sqlfmt-corpus-separator --

SELECT daterange(('0001-01-01'::date + '262141years 11months 30days'::interval)::date, null, '()');

-- sqlfmt-corpus-separator --

SELECT div(-1.0::float, 2.0), div(1.0::float, 2.0), div(9.0::float, 4.0), div(-9.0::float, 4.0), div(1.0::float, 0.0), div(1111.0::decimal, 9.44)

-- sqlfmt-corpus-separator --

SELECT div(-1::int, 2::int), div(1::int, 2::int), div(9::int, 4::int), div(-9::int, 4::int)

-- sqlfmt-corpus-separator --

SELECT div(-9.0::float, -2.0) * -2.0 + mod(-9.0::float, -2.0)

-- sqlfmt-corpus-separator --

SELECT div(-9.0::float, 2.0) * 2.0 + mod(-9.0::float, 2.0)

-- sqlfmt-corpus-separator --

SELECT div(1::int, 0::int)

-- sqlfmt-corpus-separator --

SELECT div(9.0::float, -2.0) * -2.0 + mod(9.0::float, -2.0)

-- sqlfmt-corpus-separator --

SELECT div(9.0::float, 2.0) * 2.0 + mod(9.0::float, 2.0)

-- sqlfmt-corpus-separator --

SELECT exp(-1.0::float), round(exp(1.0::float), 13), exp(2.0::decimal)

-- sqlfmt-corpus-separator --

SELECT exp(-10000::float)

-- sqlfmt-corpus-separator --

SELECT exp(10000::float)

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

SELECT f1 AS eight FROM VARCHAR_TBL
UNION ALL
SELECT f1 FROM CHAR_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 AS five FROM FLOAT8_TBL
  WHERE f1 BETWEEN -1e6 AND 1e6
UNION
SELECT f1 FROM INT4_TBL
  WHERE f1 BETWEEN 0 AND 1000000
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

SELECT f1, f2, f3, lag(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
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

SELECT f1, f2, f3, lead(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
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

SELECT false::int

-- sqlfmt-corpus-separator --

SELECT floor(-1.5::float), floor(1.5::float), floor(9.123456789::decimal)

-- sqlfmt-corpus-separator --

SELECT floor(CAST (1.1 AS double precision))

-- sqlfmt-corpus-separator --

SELECT floor(CAST (1.1 AS float))

-- sqlfmt-corpus-separator --

SELECT floor(cast(1 AS bigint))

-- sqlfmt-corpus-separator --

SELECT foo.a FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT foo1, foo.foo1, b, foo.c FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('[2:4]={1,2,3,4}'::int[], 1) AS s;

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

SELECT id, normalize(text, NFKC) FROM test_normalize ORDER BY id

-- sqlfmt-corpus-separator --

SELECT int4range(-1,1) @> 0.1::float;

-- sqlfmt-corpus-separator --

SELECT int8range(-1,1) @> 0.1::float;

-- sqlfmt-corpus-separator --

SELECT json_build_object('{1,2,3}'::int[],3)

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(a) FILTER (WHERE a IS NOT NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object('a',1,'b',1.2::float,'c',true,'d',null,'e','{"x":3,"y":[1,2,3]}'::JSONB)

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg(a, a) FILTER (WHERE a IS NOT NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT k, abs(k) FILTER (WHERE k=1) FROM kv

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v SIMILAR TO 'ABC_*'

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

SELECT length(normalize('한글', NFC))

-- sqlfmt-corpus-separator --

SELECT length(normalize('한글', NFD))

-- sqlfmt-corpus-separator --

SELECT list_agg('a'::char(2))::text

-- sqlfmt-corpus-separator --

SELECT list_agg('a'::char)::text

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

SELECT ln(-2.0::float), ln(2.0::float), ln(2.5::decimal)

-- sqlfmt-corpus-separator --

SELECT log(10.0::float), log(100.000::decimal)

-- sqlfmt-corpus-separator --

SELECT makeaclitem((SELECT oid FROM mz_roles WHERE name = 'materialize'), (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'CREATE, USAGE', false)::mz_catalog.mz_aclitem = mz_internal.make_mz_aclitem('u1', 'u2', 'CREATE, USAGE')

-- sqlfmt-corpus-separator --

SELECT makeaclitem((SELECT oid FROM mz_roles WHERE name = 'materialize'), 87398, 'CREATE', false)::mz_catalog.mz_aclitem

-- sqlfmt-corpus-separator --

SELECT makeaclitem(0, (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'CREATE, USAGE', false)::mz_catalog.mz_aclitem = mz_internal.make_mz_aclitem('p', 'u2', 'CREATE, USAGE')

-- sqlfmt-corpus-separator --

SELECT makeaclitem(3251, 345, 'CREATE', false)::mz_catalog.mz_aclitem

-- sqlfmt-corpus-separator --

SELECT makeaclitem(99991, (SELECT oid FROM mz_roles WHERE name = 'test_role'), 'CREATE', false)::mz_catalog.mz_aclitem

-- sqlfmt-corpus-separator --

SELECT min(1), count(1), max(1), avg(1)::float, sum(1), stddev(1), variance(1)

-- sqlfmt-corpus-separator --

SELECT min(1), count(1), max(1), avg(1)::float, sum(1), stddev(1)::float, variance(1)::float FROM kv

-- sqlfmt-corpus-separator --

SELECT min(oid::int)::regproc::text FROM mz_objects WHERE name = 'max';

-- sqlfmt-corpus-separator --

SELECT mod(5.0::float, 2.0), mod(1.0::float, 0.0), mod(5, 2), mod(19.3::decimal, 2)

-- sqlfmt-corpus-separator --

SELECT normalize('', NFKC)

-- sqlfmt-corpus-separator --

SELECT normalize('hello world', NFD)

-- sqlfmt-corpus-separator --

SELECT normalize('x²', NFC)

-- sqlfmt-corpus-separator --

SELECT normalize('x²', NFKC)

-- sqlfmt-corpus-separator --

SELECT normalize('Å', NFD) = E'A\u030A'

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

SELECT normalize(NULL, NFC)

-- sqlfmt-corpus-separator --

SELECT now() + INTERVAL '100' HOUR > now()

-- sqlfmt-corpus-separator --

SELECT numrange(-1.0,1.0) @> 0.1::float;

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

SELECT pg_has_role('materialize', ((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT pg_has_role(((SELECT MAX(oid::int8) FROM mz_roles) + 1)::text::oid, 'materialize', 'MEMBER')

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1'::bigint)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1'::int)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1'::integer)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1'::smallint)

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

SELECT pg_typeof('true'::boolean)

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

SELECT pg_typeof(a::string[]::int[]) FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT pg_typeof(a::string[]::int[]::text[]::float8[]) FROM array_t2;

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

SELECT pow(-2::int, 3::int), pow(2::int, 3::int)

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

SELECT pow(2::int, -3::int)

-- sqlfmt-corpus-separator --

SELECT pow(3::float, -10000)

-- sqlfmt-corpus-separator --

SELECT pow(3::float, 10000)

-- sqlfmt-corpus-separator --

SELECT pow(9::float, 0.5);

-- sqlfmt-corpus-separator --

SELECT power(-2.0::float, 1.5)

-- sqlfmt-corpus-separator --

SELECT power(0::float, -1);

-- sqlfmt-corpus-separator --

SELECT power(9::float, 0.5);

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT (((SELECT q2 FROM int8_tbl ORDER BY q2 LIMIT 1))) ORDER BY 1

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

SELECT repeat('1234567890'::string, 6978072892806141784::int)

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

SELECT round(123.456::float, -1), round(123.456::float, -2), round(123.456::float, -3)

-- sqlfmt-corpus-separator --

SELECT round(123.456::float, -2438602134409251682)

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

SELECT round(ln(13::float)::decimal(15, 5), 3)

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

SELECT sqrt(-1.0::float)

-- sqlfmt-corpus-separator --

SELECT sqrt(-1::double precision)

-- sqlfmt-corpus-separator --

SELECT sqrt(-1::float)

-- sqlfmt-corpus-separator --

SELECT sqrt(1.23783::float)

-- sqlfmt-corpus-separator --

SELECT sqrt(4.0::float), sqrt(9.0::decimal)

-- sqlfmt-corpus-separator --

SELECT stddev(1::int), stddev(1::float), stddev(1::decimal)

-- sqlfmt-corpus-separator --

SELECT stddev(x)::FLOAT, stddev(y::decimal)::FLOAT, stddev(z)::DECIMAL(38, 14) FROM xyz

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

SELECT t FROM timestamptzish WHERE t > TIMESTAMPTZ '1999-12-31 9:46:01-04' - INTERVAL '12' HOUR

-- sqlfmt-corpus-separator --

SELECT t0.c1 FROM t0 WHERE (CASE t0.c1 WHEN 'bZkESziLfXXL3G3YWk3j3FGvDHCwEkrTmYd9ANGvVBoF0J4Dpim3YrnbiF38bQo5HA3kxP4kz1F1V6DIgKdfsbDT' THEN t0.c0 ELSE t0.c1 END ) UNION ALL SELECT t0.c1 FROM t0 WHERE (NOT (CASE t0.c1 WHEN 'bZkESziLfXXL3G3YWk3j3FGvDHCwEkrTmYd9ANGvVBoF0J4Dpim3YrnbiF38bQo5HA3kxP4kz1F1V6DIgKdfsbDT' THEN t0.c0 ELSE t0.c1 END )) UNION ALL SELECT t0.c1 FROM t0 WHERE (((CASE t0.c1 WHEN 'bZkESziLfXXL3G3YWk3j3FGvDHCwEkrTmYd9ANGvVBoF0J4Dpim3YrnbiF38bQo5HA3kxP4kz1F1V6DIgKdfsbDT' THEN t0.c0 ELSE t0.c1 END )) IS NULL)

-- sqlfmt-corpus-separator --

SELECT timestamp(0) with time zone '95143-12-31 23:59:59.123456789';

-- sqlfmt-corpus-separator --

SELECT timezone(INTERVAL '+11'HOUR, TIME '18:53:49')::time

-- sqlfmt-corpus-separator --

SELECT timezone(INTERVAL '+11'MONTH, TIME '18:53:49')

-- sqlfmt-corpus-separator --

SELECT to_json(1.234::FLOAT)

-- sqlfmt-corpus-separator --

SELECT to_json(123::INT)

-- sqlfmt-corpus-separator --

SELECT to_json(3::OID::INT::OID)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('a'::char(10))

-- sqlfmt-corpus-separator --

SELECT to_jsonb(1.234::FLOAT)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(123::INT)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(3::OID::INT::OID)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(null::int)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(null::int[])

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

SELECT true::int

-- sqlfmt-corpus-separator --

SELECT trunc('NaN'::decimal), trunc('Inf'::float), trunc(0), trunc(-0)

-- sqlfmt-corpus-separator --

SELECT trunc(CAST (-1.4678 AS double precision))

-- sqlfmt-corpus-separator --

SELECT trunc(CAST (-1.4678 AS float))

-- sqlfmt-corpus-separator --

SELECT trunc(CAST (1.5678 AS double precision))

-- sqlfmt-corpus-separator --

SELECT trunc(CAST (1.5678 AS float))

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

TABLE t UNION ALL TABLE t ORDER BY a LIMIT 5

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
    t AS (SELECT true),
    t AS (SELECT false)
SELECT * FROM t

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

WITH a(x) AS (SELECT 'a') SELECT generate_series(1, 2), * FROM a ORDER BY generate_series

-- sqlfmt-corpus-separator --

WITH c AS (SELECT a + 1 FROM x) SELECT (SELECT * FROM c);

-- sqlfmt-corpus-separator --

WITH count AS (VALUES (9)) SELECT count(*) FROM count;

-- sqlfmt-corpus-separator --

WITH cte1 AS (SELECT 1 AS a, 2 AS a) SELECT * FROM cte1 WHERE cte1.a = 1

-- sqlfmt-corpus-separator --

WITH foo AS (SELECT 1)
  (SELECT * FROM foo
    UNION ALL
  (WITH foo AS (SELECT 2) SELECT * FROM foo)
    UNION ALL
  (SELECT * FROM foo))

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

select * from int4_tbl where
  (case when f1 in (select unique1 from tenk1 a) then f1 else null end) in
  (select ten from tenk1 b)

-- sqlfmt-corpus-separator --

select * from notinouter where a not in (select b from notininner)

-- sqlfmt-corpus-separator --

select * from outer_7597 where (f1, f2) not in (select * from inner_7597)

-- sqlfmt-corpus-separator --

select 1 < 2.0::float, 1.0::float < 2, 2.0::float < 1, 2 < 1.0::float

-- sqlfmt-corpus-separator --

select 1 <= 1.0::float, 1.0::float <= 1, 2.0::float <= 1, 2 <= 1.0::float

-- sqlfmt-corpus-separator --

select 1 = 1.0::float, 1.0::float = 1, 1 = 2.0::float, 2.0::float = 1

-- sqlfmt-corpus-separator --

select 1 = all (select (select 1))

-- sqlfmt-corpus-separator --

select 1 >= 1.0::float, 1.0::float >= 1, 1.0::float >= 2, 1 >= 2.0::float

-- sqlfmt-corpus-separator --

select 2 > 1.0::float, 2.0::float > 1, 1 > 2.0::float, 1.0::float > 2

-- sqlfmt-corpus-separator --

select 2 OPERATOR(*) 2 + 2;

-- sqlfmt-corpus-separator --

select a.thousand from tenk1 a, tenk1 b
where a.thousand = b.thousand
  and exists ( select 1 from tenk1 c where b.hundred = c.hundred
                   and not exists ( select 1 from tenk1 d
                                    where a.thousand = d.thousand ) )

-- sqlfmt-corpus-separator --

select exists(select * from nocolumns)

-- sqlfmt-corpus-separator --

select position(strcol1 IN strcol2) from positiontest;

-- sqlfmt-corpus-separator --

select unique1 from tenk1 except select unique2 from tenk1 where unique2 != 10

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

with q as (select max(f1) from int4_tbl group by f1 order by f1)
  select q from q;

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

-- sqlfmt-corpus-separator --

with v as (select mz_now() < '3000-01-01') select * from v;