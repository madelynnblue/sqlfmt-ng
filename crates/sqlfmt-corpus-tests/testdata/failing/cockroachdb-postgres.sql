((SELECT 1 FOR UPDATE SKIP LOCKED))

-- sqlfmt-corpus-separator --

((SELECT 1) FOR UPDATE SKIP LOCKED)

-- sqlfmt-corpus-separator --

((SELECT 1)) FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

(SELECT NULL FROM t34524) EXCEPT (VALUES((SELECT 1 FROM t34524 LIMIT 1)), (1))

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz ORDER BY y) EXCEPT (SELECT x FROM xyz ORDER BY y, z) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz ORDER BY y) EXCEPT (SELECT y AS x FROM xyz ORDER BY z) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz ORDER BY y) EXCEPT ALL (SELECT x FROM xyz ORDER BY y, z) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz ORDER BY y) EXCEPT ALL (SELECT y AS x FROM xyz ORDER BY z) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz ORDER BY y) INTERSECT (SELECT x FROM xyz ORDER BY y, z) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz ORDER BY y) INTERSECT (SELECT x FROM xyz ORDER BY z) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz ORDER BY y) INTERSECT ALL (SELECT x FROM xyz ORDER BY y, z) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz ORDER BY y) INTERSECT ALL (SELECT x FROM xyz ORDER BY z) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz ORDER BY y) UNION (SELECT x FROM xyz ORDER BY z) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz ORDER BY y) UNION ALL (SELECT x FROM xyz ORDER BY y, z) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz ORDER BY y) UNION ALL (SELECT x FROM xyz ORDER BY z) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz ORDER BY y) EXCEPT (SELECT y FROM xyz ORDER BY y)

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz ORDER BY y) EXCEPT ALL (SELECT y FROM xyz ORDER BY y)

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz ORDER BY y) INTERSECT (SELECT y FROM xyz ORDER BY y)

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz ORDER BY y) INTERSECT ALL (SELECT y FROM xyz ORDER BY y)

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz ORDER BY z) EXCEPT (SELECT y FROM xyz ORDER BY z)

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz ORDER BY z) EXCEPT ALL (SELECT y FROM xyz ORDER BY z)

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz ORDER BY z) INTERSECT (SELECT y FROM xyz ORDER BY z)

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz ORDER BY z) INTERSECT ALL (SELECT y FROM xyz ORDER BY z)

-- sqlfmt-corpus-separator --

(VALUES (1)) FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT
	first_value(product_name) OVER (
		w RANGE UNBOUNDED PRECEDING EXCLUDE CURRENT ROW
	),
	first_value(product_name) OVER (
		w RANGE UNBOUNDED PRECEDING EXCLUDE GROUP
	),
	first_value(product_name) OVER (
		w RANGE UNBOUNDED PRECEDING EXCLUDE TIES
	),
	first_value(product_name) OVER (
		w RANGE UNBOUNDED PRECEDING EXCLUDE NO OTHERS
	)
FROM
	products
WINDOW
	w AS (ORDER BY group_id)
ORDER BY
	group_id

-- sqlfmt-corpus-separator --

SELECT
	last_value(product_name) OVER (
		w RANGE UNBOUNDED PRECEDING EXCLUDE CURRENT ROW
	),
	last_value(product_name) OVER (
		w RANGE UNBOUNDED PRECEDING EXCLUDE GROUP
	),
	last_value(product_name) OVER (
		w RANGE UNBOUNDED PRECEDING EXCLUDE TIES
	),
	last_value(product_name) OVER (
		w RANGE UNBOUNDED PRECEDING EXCLUDE NO OTHERS
	)
FROM
	products
WINDOW
	w AS (ORDER BY group_id)
ORDER BY
	group_id

-- sqlfmt-corpus-separator --

SELECT
	nth_value(product_name, 2) OVER (
		w RANGE UNBOUNDED PRECEDING EXCLUDE CURRENT ROW
	),
	nth_value(product_name, 3) OVER (
		w RANGE UNBOUNDED PRECEDING EXCLUDE GROUP
	),
	nth_value(product_name, 4) OVER (
		w RANGE UNBOUNDED PRECEDING EXCLUDE TIES
	),
	nth_value(product_name, 5) OVER (
		w RANGE UNBOUNDED PRECEDING EXCLUDE NO OTHERS
	)
FROM
	products
WINDOW
	w AS (ORDER BY group_id)
ORDER BY
	group_id

-- sqlfmt-corpus-separator --

SELECT
	price, array_agg(price) OVER w, avg(price) OVER w
FROM
	products
WINDOW
	w AS (
		ORDER BY
			price
		RANGE
			UNBOUNDED PRECEDING EXCLUDE NO OTHERS
	)
ORDER BY
	price

-- sqlfmt-corpus-separator --

SELECT
	price, array_agg(price) OVER w, avg(price) OVER w
FROM
	products
WINDOW
	w AS (
		ORDER BY
			price
		RANGE
			UNBOUNDED PRECEDING EXCLUDE TIES
	)
ORDER BY
	price

-- sqlfmt-corpus-separator --

SELECT
	price, array_agg(price) OVER w, max(price) OVER w
FROM
	products
WINDOW
	w AS (
		ORDER BY
			price
		RANGE
			UNBOUNDED PRECEDING EXCLUDE GROUP
	)
ORDER BY
	price

-- sqlfmt-corpus-separator --

SELECT
	price, array_agg(price) OVER w, sum(price) OVER w
FROM
	products
WINDOW
	w AS (
		ORDER BY
			price
		RANGE
			UNBOUNDED PRECEDING EXCLUDE CURRENT ROW
	)
ORDER BY
	price

-- sqlfmt-corpus-separator --

SELECT
  *,
  array_agg(v) OVER (wv RANGE BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING),
  array_agg(v) OVER (wv RANGE BETWEEN 0 PRECEDING AND 1 PRECEDING),
  array_agg(f) OVER (wf RANGE BETWEEN UNBOUNDED PRECEDING AND -0.0 PRECEDING),
  array_agg(f) OVER (wf RANGE BETWEEN 0.0 PRECEDING AND 1.0 PRECEDING),
  array_agg(d) OVER (wd RANGE BETWEEN 0.0 FOLLOWING AND 0.0 FOLLOWING),
  array_agg(d) OVER (wd RANGE BETWEEN 1.0 FOLLOWING AND UNBOUNDED FOLLOWING),
  array_agg(i) OVER (wi RANGE BETWEEN '1s'::INTERVAL PRECEDING AND '0s'::INTERVAL PRECEDING),
  array_agg(i) OVER (wi RANGE BETWEEN '1s'::INTERVAL FOLLOWING AND '1s'::INTERVAL FOLLOWING)
FROM
  kv
WINDOW
  wv AS (ORDER BY v DESC),
  wf AS (ORDER BY f),
  wd AS (ORDER BY d DESC),
  wi AS (ORDER BY i)
ORDER BY
  k

-- sqlfmt-corpus-separator --

SELECT
  *,
  array_agg(v) OVER (wv RANGE BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING),
  array_agg(v) OVER (wv RANGE BETWEEN 0 PRECEDING AND 1 PRECEDING),
  array_agg(f) OVER (wf RANGE BETWEEN UNBOUNDED PRECEDING AND -0.0 PRECEDING),
  array_agg(f) OVER (wf RANGE BETWEEN 0.0 PRECEDING AND 1.0 PRECEDING),
  array_agg(d) OVER (wd RANGE BETWEEN 0.0 FOLLOWING AND 0.0 FOLLOWING),
  array_agg(d) OVER (wd RANGE BETWEEN 1.0 FOLLOWING AND UNBOUNDED FOLLOWING),
  array_agg(i) OVER (wi RANGE BETWEEN '1s'::INTERVAL PRECEDING AND '0s'::INTERVAL PRECEDING),
  array_agg(i) OVER (wi RANGE BETWEEN '1s'::INTERVAL FOLLOWING AND '1s'::INTERVAL FOLLOWING)
FROM
  kv
WINDOW
  wv AS (PARTITION BY v ORDER BY v),
  wf AS (PARTITION BY f ORDER BY f DESC),
  wd AS (PARTITION BY d ORDER BY d),
  wi AS (PARTITION BY i ORDER BY i DESC)
ORDER BY
  k

-- sqlfmt-corpus-separator --

SELECT
  a.elems,
  b.elems,
  a.elems = b.elems,
  a.elems < b.elems,
  a.elems <= b.elems,
  a.elems IS NOT DISTINCT FROM b.elems
FROM enum_array_table a, enum_array_table b
ORDER BY a.id, b.id

-- sqlfmt-corpus-separator --

SELECT
  avg(a) OVER            (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(a) OVER (ORDER BY a RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(a) OVER (ORDER BY b RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(a) OVER (ORDER BY c RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(b) OVER            (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(b) OVER (ORDER BY a RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(b) OVER (ORDER BY b RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(b) OVER (ORDER BY c RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(c) OVER            (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(c) OVER (ORDER BY a RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(c) OVER (ORDER BY b RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(c) OVER (ORDER BY c RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM abc

-- sqlfmt-corpus-separator --

SELECT
  id,
  row_number() OVER (ORDER BY id NULLS LAST) AS row_num_using_nulls_last,
  row_number() OVER (ORDER BY COALESCE(id, 999)) AS row_num_using_coalesce
FROM
  nulls_last_test
ORDER BY
  id NULLS LAST

-- sqlfmt-corpus-separator --

SELECT
  id,
  row_number() OVER (ORDER BY id) AS row_num_using_nulls_last,
  row_number() OVER (ORDER BY COALESCE(id, 999)) AS row_num_using_coalesce
FROM
  nulls_last_test
ORDER BY
  id

-- sqlfmt-corpus-separator --

SELECT
  lag(_int2, _int4, _int2) OVER w,
  lead(_int4, _int2, _int4) OVER w,
  first_value(_int2) OVER w,
  last_value(_int4) OVER w,
  nth_value(_int2, _int4) OVER w,
  min(_int4) OVER w,
  row_number() OVER w,
  rank() OVER w,
  dense_rank() OVER w,
  percent_rank() OVER w,
  cume_dist() OVER w,
  ntile(_int2) OVER w
FROM t74087 WINDOW w AS (ORDER BY _int4);

-- sqlfmt-corpus-separator --

SELECT
  max(k) OVER (w GROUPS BETWEEN 9223372036854775807 FOLLOWING AND UNBOUNDED FOLLOWING),
  max(k) OVER (w GROUPS BETWEEN UNBOUNDED PRECEDING AND 9223372036854775807 FOLLOWING)
FROM kv WINDOW w AS (PARTITION BY b ORDER BY v)

-- sqlfmt-corpus-separator --

SELECT "LOWERCASE_HINT_ERROR_IMPLICIT_SCHEMA_FN"();

-- sqlfmt-corpus-separator --

SELECT "PG_TYPEOF"(123)

-- sqlfmt-corpus-separator --

SELECT '$'::JSONPATH IS DISTINCT FROM '$'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT '$'::JSONPATH IS DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT '$'::JSONPATH IS NOT DISTINCT FROM '$'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT '$'::JSONPATH IS NOT DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT '%A' SIMILAR TO '%A' ESCAPE '%'

-- sqlfmt-corpus-separator --

SELECT '%A' SIMILAR TO '_A' ESCAPE '%'

-- sqlfmt-corpus-separator --

SELECT ''::VOID IS DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT ''::VOID IS DISTINCT FROM NULL::UNKNOWN

-- sqlfmt-corpus-separator --

SELECT '123A_' SIMILAR TO '%A_' ESCAPE '_'

-- sqlfmt-corpus-separator --

SELECT '123A_' SIMILAR TO '%A__' ESCAPE '_'

-- sqlfmt-corpus-separator --

SELECT 'A' SIMILAR TO 'AA' ESCAPE 'AA'

-- sqlfmt-corpus-separator --

SELECT 'A' SIMILAR TO '\A' ESCAPE '\'

-- sqlfmt-corpus-separator --

SELECT 'POINT(1.0 2.0)'::geometry::geography(geometry, 4004)

-- sqlfmt-corpus-separator --

SELECT 'SRID=4004;POINT(2.0 3.0)'::geography::geography(linestring)

-- sqlfmt-corpus-separator --

SELECT 'SRID=4004;POINT(2.0 3.0)'::geography::geometry(linestring)

-- sqlfmt-corpus-separator --

SELECT 'SRID=4004;POINT(2.0 3.0)'::geography::geometry(point, 4326)

-- sqlfmt-corpus-separator --

SELECT 'SRID=4004;POINT(2.0 3.0)'::geometry::geography(linestring)

-- sqlfmt-corpus-separator --

SELECT 'SRID=4004;POINT(2.0 3.0)'::geometry::geography(point, 4326)

-- sqlfmt-corpus-separator --

SELECT 'SRID=4004;POINT(2.0 3.0)'::geometry::geometry(linestring)

-- sqlfmt-corpus-separator --

SELECT 'SRID=4004;POINT(2.0 3.0)'::geometry::geometry(point, 4326)

-- sqlfmt-corpus-separator --

SELECT 'SRID=4326;POINT(2.0 3.0)'::geography::geography(point, 4004)

-- sqlfmt-corpus-separator --

SELECT 'SRID=4326;POINT(2.0 3.0)'::geometry::geography(point, 4004)

-- sqlfmt-corpus-separator --

SELECT '\A' SIMILAR TO '\A' ESCAPE ''

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR IS DISTINCT FROM 'foo'::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR IS DISTINCT FROM 'foo'::TEXT;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR IS DISTINCT FROM (NULL::REFCURSOR);

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR IS DISTINCT FROM NULL;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR IS DISTINCT FROM l FROM implicit_types;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR IS NOT DISTINCT FROM 'foo'::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR IS NOT DISTINCT FROM 'foo'::TEXT;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR IS NOT DISTINCT FROM (NULL::REFCURSOR);

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR IS NOT DISTINCT FROM NULL;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR IS NOT DISTINCT FROM l FROM implicit_types;

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL AS t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", t1.a, t2.e FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e) WHERE t1.a = t2.d

-- sqlfmt-corpus-separator --

SELECT '春A' SIMILAR TO '春春_' ESCAPE '春'

-- sqlfmt-corpus-separator --

SELECT '春A' SIMILAR TO '春春_' ESCAPE '春春'

-- sqlfmt-corpus-separator --

SELECT '春A_春春' SIMILAR TO '%_春_%' ESCAPE '春'

-- sqlfmt-corpus-separator --

SELECT ((-1.234E+401)::DECIMAL * '-53 years -10 mons -377 days -08:33:40.519057'::INTERVAL::INTERVAL)::INTERVAL FROM many_types

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

SELECT (1::INT2, NULL)
UNION
SELECT (1::INT, NULL)

-- sqlfmt-corpus-separator --

SELECT (2, 2) IN (SELECT x+1, y+1 FROM xy)

-- sqlfmt-corpus-separator --

SELECT (SELECT (1, 2)) IN (SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT (SELECT (2, 2), (3, 3)) IN (SELECT x+1, y+1 FROM xy)

-- sqlfmt-corpus-separator --

SELECT (SELECT 123 AS a),
       (VALUES (cos(1)::INT)),
       (SELECT cos(0)::INT)

-- sqlfmt-corpus-separator --

SELECT (SELECT 123 IN (VALUES (1), (2)))

-- sqlfmt-corpus-separator --

SELECT (VALUES (1)) FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT (WITH foo AS (INSERT INTO y VALUES (1) RETURNING *) SELECT * FROM foo)

-- sqlfmt-corpus-separator --

SELECT (rank() OVER wind + lead(k, 3, v) OVER wind + lag(w, 1, 2) OVER wind), (row_number() OVER wind + dense_rank() OVER wind) FROM kv WINDOW wind as (PARTITION BY v ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT (round(avg(k) OVER w1 + sum(w) OVER w2) + row_number() OVER w2 + d + min(d) OVER w3 + f::DECIMAL) AS big_sum, v + w AS v_plus_w, (rank() OVER w3 + first_value(d) OVER w1 + nth_value(k, 2) OVER w1) AS small_sum FROM kv WINDOW w1 AS (PARTITION BY b ORDER BY k), w2 AS (PARTITION BY w ORDER BY k), w3 AS (PARTITION BY v ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT *
FROM system.information_schema.constraint_column_usage
WHERE NOT (table_catalog = 'system' AND table_schema = 'public' AND table_name <> 'locations')
ORDER BY TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME

-- sqlfmt-corpus-separator --

SELECT *
FROM system.information_schema.table_constraints
WHERE NOT (table_catalog = 'system' AND table_schema = 'public' AND table_name <> 'locations')
ORDER BY TABLE_NAME, CONSTRAINT_TYPE, CONSTRAINT_NAME

-- sqlfmt-corpus-separator --

SELECT *
FROM t_48638
WHERE key IN (
  WITH v AS (
    SELECT
      level1.value AS value, level1.key AS level1, level2.key AS level2, level3.key AS level3
    FROM
      t_48638 AS level2
      RIGHT JOIN (SELECT * FROM t_48638 WHERE value = 4) AS level1 ON level1.value = level2.key
      LEFT JOIN (SELECT * FROM t_48638) AS level3 ON level3.key = level2.value
  )
  SELECT v.level1 FROM v WHERE v.level1 IS NOT NULL
  UNION ALL SELECT v.level2 FROM v WHERE v.level2 IS NOT NULL
  UNION ALL SELECT v.level3 FROM v WHERE v.level3 IS NOT NULL
)

-- sqlfmt-corpus-separator --

SELECT * FROM (SELECT message FROM messages_rbr LIMIT 1) UNION ALL SELECT message FROM messages_rbt

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE (a1, a2) IN (SELECT c1, d1 FROM c, d WHERE c3 = d3 or c2 = d2 EXCEPT ALL
                                   SELECT c1, d1 FROM c, d WHERE c3 = d3 or c2 = d2)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE (a1, a2) IN (SELECT c1, d1 FROM c, d WHERE c3 = d3 or c3 = d4)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE (a1, a2) NOT IN (SELECT c1, d1 FROM c, d WHERE c3 = d3 or c2 = d2 EXCEPT ALL
                                       SELECT c1, d1 FROM c, d WHERE c3 = d3 or c2 = d2)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE (a1, a2) NOT IN (SELECT c1, d1 FROM c, d WHERE c3 = d3 or c3 = d4)

-- sqlfmt-corpus-separator --

SELECT * FROM ab AS foo (foo1, foo2)

-- sqlfmt-corpus-separator --

SELECT * FROM ab AS foo (foo1, foo2, foo3)

-- sqlfmt-corpus-separator --

SELECT * FROM ab WHERE (a, b) IN (SELECT x+1, y+1 FROM xy);

-- sqlfmt-corpus-separator --

SELECT * FROM ab WHERE ROW(ROW(a, b)) IN (SELECT x+1 FROM xy);

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

SELECT * FROM f_insert_select(5,6) AS t1(a INT, b INT) UNION ALL SELECT * FROM f_insert_select(7,8) AS t2(a INT, b INT)

-- sqlfmt-corpus-separator --

SELECT * FROM foo FOR SHARE OF foo SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * FROM int WHERE a IS DISTINCT FROM 2

-- sqlfmt-corpus-separator --

SELECT * FROM int WHERE a IS NOT DISTINCT FROM 2

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE (k,v) IN (SELECT * FROM kv)

-- sqlfmt-corpus-separator --

SELECT * FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY avg(k) OVER w DESC, k

-- sqlfmt-corpus-separator --

SELECT * FROM regression_46973 WHERE (-9223372036854775808)::TIMESTAMP!=regression_46973.c0

-- sqlfmt-corpus-separator --

SELECT * FROM regression_46973 WHERE (-9223372036854775808)::TIMESTAMPTZ!=regression_46973.c1

-- sqlfmt-corpus-separator --

SELECT * FROM system.information_schema.role_table_grants
WHERE
(table_schema <> 'crdb_internal' OR table_name = 'node_build_info')
AND NOT (table_schema = 'public' AND table_name <> 'locations');

-- sqlfmt-corpus-separator --

SELECT * FROM system.information_schema.table_privileges
WHERE
  (table_schema <> 'crdb_internal' OR table_name = 'node_build_info') AND
  NOT (table_catalog = 'system' AND table_schema = 'public' AND 'table_name' <> 'locations')
ORDER BY table_schema, table_name, table_schema, grantee, privilege_type

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR SHARE FOR UPDATE OF t NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR SHARE NOWAIT FOR UPDATE OF t

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR SHARE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE k = 1 FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE k = 2 FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE v = 9 FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM t1 WHERE (t1.c0 COLLATE en) > ('_' COLLATE en)
UNION
SELECT * FROM t1 WHERE NOT ((t1.c0 COLLATE en) > ('_' COLLATE en))
UNION
SELECT * FROM t1 WHERE ((t1.c0 COLLATE en) > ('_' COLLATE en)) IS NULL

-- sqlfmt-corpus-separator --

SELECT * FROM t1 WHERE (t1.c0 COLLATE en) > ('b' COLLATE en)
UNION
SELECT * FROM t1 WHERE NOT ((t1.c0 COLLATE en) > ('b' COLLATE en))
UNION
SELECT * FROM t1 WHERE ((t1.c0 COLLATE en) > ('b' COLLATE en)) IS NULL

-- sqlfmt-corpus-separator --

SELECT * FROM t1 WHERE (t1.c0 COLLATE en) > ('c' COLLATE en)
UNION
SELECT * FROM t1 WHERE NOT ((t1.c0 COLLATE en) > ('c' COLLATE en))
UNION
SELECT * FROM t1 WHERE ((t1.c0 COLLATE en) > ('c' COLLATE en)) IS NULL

-- sqlfmt-corpus-separator --

SELECT * FROM t129145 WHERE b = 1 FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM t129145 WHERE b = 1 FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * FROM t3 WHERE u = 2 FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * FROM t3 WHERE u = 2 LIMIT 1 FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * FROM xyz WHERE z = 100 ORDER BY x FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM xyz WHERE z = 100 ORDER BY x FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * from t7 FOR UPDATE SKIP LOCKED;

-- sqlfmt-corpus-separator --

SELECT *, avg(k) OVER (w ORDER BY w) FROM kv WINDOW w AS (PARTITION BY v) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT *, avg(k) OVER w FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY avg(k) OVER w, k

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

SELECT 1 = ANY(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 = SOME(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 FOR KEY SHARE NOWAIT

-- sqlfmt-corpus-separator --

SELECT 1 FOR KEY SHARE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT 1 FOR NO KEY UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT 1 FOR NO KEY UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT 1 FOR SHARE NOWAIT

-- sqlfmt-corpus-separator --

SELECT 1 FOR SHARE OF a, b

-- sqlfmt-corpus-separator --

SELECT 1 FOR SHARE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE OF a

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE OF a FOR SHARE OF b, c FOR NO KEY UPDATE OF d FOR KEY SHARE OF e, f

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE OF a NOWAIT

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE OF a NOWAIT FOR NO KEY UPDATE OF b NOWAIT

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE OF a NOWAIT FOR SHARE OF b, c NOWAIT FOR NO KEY UPDATE OF d NOWAIT FOR KEY SHARE OF e, f NOWAIT

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE OF a SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE OF a SKIP LOCKED FOR NO KEY UPDATE OF b NOWAIT

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE OF a SKIP LOCKED FOR NO KEY UPDATE OF b SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE OF a SKIP LOCKED FOR SHARE OF b, c SKIP LOCKED FOR NO KEY UPDATE OF d SKIP LOCKED FOR KEY SHARE OF e, f SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE OF db.public.a

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE OF public.a

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT 1 UNION SELECT 1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT ARRAY(VALUES ('a'),('b'),('c'))

-- sqlfmt-corpus-separator --

SELECT ARRAY(VALUES (1),(2),(1))

-- sqlfmt-corpus-separator --

SELECT ARRAY(VALUES (ARRAY[1]))

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(((x)), (x, y)) x, y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz ORDER BY row_number() OVER(ORDER BY (pk1, pk2)) DESC

-- sqlfmt-corpus-separator --

SELECT a, b FROM nulls WHERE a IS DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT a, b FROM nulls WHERE a IS NOT DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT a, b, avg(b) OVER (ROWS 0 PRECEDING) FROM t ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b, c, first_value(a) OVER w, last_value(a) OVER w, nth_value(a, b) OVER w
FROM t WINDOW w AS (ORDER BY c, b GROUPS BETWEEN 5 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT a, b, c, first_value(a) OVER w, last_value(a) OVER w, nth_value(a, b) OVER w
FROM t WINDOW w AS (ORDER BY c, b ROWS BETWEEN 5 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT a, b, c, first_value(a) OVER w, last_value(a) OVER w, nth_value(a, b) OVER w
FROM t WINDOW w AS (ORDER BY c, b)

-- sqlfmt-corpus-separator --

SELECT a, b, c, first_value(a) OVER w, last_value(a) OVER w, nth_value(a, b) OVER w
FROM t WINDOW w AS (PARTITION BY a ORDER BY c)

-- sqlfmt-corpus-separator --

SELECT a, b, c, lag(a, b) OVER w, lead(a, b) OVER w FROM t WINDOW w AS (PARTITION BY a ORDER BY c)

-- sqlfmt-corpus-separator --

SELECT a, b, c, sum_int(a) OVER w, sum(a) OVER w, count(*) OVER w, count(a) OVER w, avg(a) OVER w,
       max(a) OVER w, min(a) OVER w, bool_and(d) OVER w, bool_or(d) OVER w, concat_agg(e) OVER w
FROM t WINDOW w AS (ORDER BY c RANGE BETWEEN 5 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT a, b, c, sum_int(a) OVER w, sum(a) OVER w, count(*) OVER w, count(a) OVER w, avg(a) OVER w,
       max(a) OVER w, min(a) OVER w, bool_and(d) OVER w, bool_or(d) OVER w, concat_agg(e) OVER w
FROM t WINDOW w AS (ORDER BY c, b GROUPS BETWEEN 5 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT a, b, c, sum_int(a) OVER w, sum(a) OVER w, count(*) OVER w, count(a) OVER w, avg(a) OVER w,
       max(a) OVER w, min(a) OVER w, bool_and(d) OVER w, bool_or(d) OVER w, concat_agg(e) OVER w
FROM t WINDOW w AS (ORDER BY c, b ROWS BETWEEN 5 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT a, b, c, sum_int(a) OVER w, sum(a) OVER w, count(*) OVER w, count(a) OVER w, avg(a) OVER w,
       max(a) OVER w, min(a) OVER w, bool_and(d) OVER w, bool_or(d) OVER w, concat_agg(e) OVER w
FROM t WINDOW w AS (ORDER BY c, b)

-- sqlfmt-corpus-separator --

SELECT a, b, c, sum_int(a) OVER w, sum(a) OVER w, count(*) OVER w, count(a) OVER w, avg(a) OVER w,
       max(a) OVER w, min(a) OVER w, bool_and(d) OVER w, bool_or(d) OVER w, concat_agg(e) OVER w
FROM t WINDOW w AS (PARTITION BY a ORDER BY c)

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a, b) OVER w, lead(a, b) OVER w FROM t WINDOW w AS (ORDER BY a, b)

-- sqlfmt-corpus-separator --

SELECT a, b, rank() OVER w, dense_rank() OVER w, percent_rank() OVER w, cume_dist() OVER w FROM t WINDOW w AS ()

-- sqlfmt-corpus-separator --

SELECT a, b, rank() OVER w, dense_rank() OVER w, percent_rank() OVER w, cume_dist() OVER w FROM t WINDOW w AS (ORDER BY a)

-- sqlfmt-corpus-separator --

SELECT a, b, rank() OVER w, dense_rank() OVER w, percent_rank() OVER w, cume_dist() OVER w FROM t WINDOW w AS (PARTITION BY a ORDER BY b)

-- sqlfmt-corpus-separator --

SELECT a, b, rank() OVER w, dense_rank() OVER w, percent_rank() OVER w, cume_dist() OVER w FROM t WINDOW w AS (PARTITION BY a)

-- sqlfmt-corpus-separator --

SELECT a, b, rowid FROM ab UNION VALUES (1, 2, 3);

-- sqlfmt-corpus-separator --

SELECT a, b, sum(b) OVER (ROWS 0 PRECEDING) FROM t ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, max(a) OVER w, min(a) OVER w FROM t
WINDOW w AS (ORDER BY a DESC RANGE BETWEEN 10 PRECEDING AND UNBOUNDED FOLLOWING);

-- sqlfmt-corpus-separator --

SELECT ab.rowid FROM ab AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT abc.b FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT abc.foo1 FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT array_agg(a) OVER (ORDER BY a ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) FROM t38901 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT array_agg(a) OVER (w GROUPS 1 PRECEDING) FROM x WINDOW w AS (PARTITION BY a ORDER BY a DESC) ORDER BY a

-- sqlfmt-corpus-separator --

SELECT array_agg(a) OVER (w GROUPS 1 PRECEDING) FROM x WINDOW w AS (PARTITION BY a)

-- sqlfmt-corpus-separator --

SELECT array_agg(a) OVER (w RANGE 1 PRECEDING) FROM x WINDOW w AS (ORDER BY a DESC) ORDER BY a

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (w ORDER BY v) FROM kv WINDOW w AS (ORDER BY v)

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (w ORDER BY w) FROM kv WINDOW w AS (PARTITION BY v) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (w PARTITION BY v) FROM kv WINDOW w AS ()

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (w PARTITION BY v) FROM kv WINDOW w AS (PARTITION BY v)

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (w) FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (x) FROM kv WINDOW w AS ()

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER w FROM kv WINDOW w AS (), w AS ()

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER w FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER w, avg(k) OVER w + 1 FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER x FROM kv WINDOW w AS ()

-- sqlfmt-corpus-separator --

SELECT avg(price) FILTER (WHERE price > 300) OVER w1, sum(price) FILTER (WHERE group_name = 'Smartphone') OVER w2, avg(price) FILTER (WHERE price = 200 OR price = 700) OVER w1, avg(price) FILTER (WHERE price < 900) OVER w2 FROM products WINDOW w1 AS (ORDER BY group_id), w2 AS (PARTITION BY group_name ORDER BY price, group_id) ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (GROUPS 1 PRECEDING) FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (GROUPS group_id PRECEDING) FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (ORDER BY group_id GROUPS BETWEEN 1 PRECEDING AND NULL FOLLOWING) FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (ORDER BY group_id GROUPS BETWEEN NULL PRECEDING AND 1 FOLLOWING) FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (ORDER BY group_id GROUPS NULL PRECEDING) FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (PARTITION BY group_name ORDER BY group_id GROUPS 1.5 PRECEDING) AS avg_price FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (PARTITION BY group_name ORDER BY group_id GROUPS BETWEEN 1.5 PRECEDING AND UNBOUNDED FOLLOWING) AS avg_price FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (PARTITION BY group_name ORDER BY group_id GROUPS BETWEEN UNBOUNDED PRECEDING AND 1.5 FOLLOWING) AS avg_price FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (PARTITION BY group_name ROWS 1.5 PRECEDING) AS avg_price FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (PARTITION BY group_name ROWS BETWEEN 1.5 PRECEDING AND UNBOUNDED FOLLOWING) AS avg_price FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (PARTITION BY group_name ROWS BETWEEN UNBOUNDED PRECEDING AND 1.5 FOLLOWING) AS avg_price FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (ROWS BETWEEN 1 PRECEDING AND NULL FOLLOWING) FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (ROWS BETWEEN NULL PRECEDING AND 1 FOLLOWING) FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (ROWS NULL PRECEDING) FROM products

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (w ORDER BY price) FROM products WINDOW w AS (ROWS 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (w) FROM products WINDOW w AS (ROWS 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER w AS avg_price FROM products WINDOW w AS (PARTITION BY group_name ORDER BY group_id GROUPS 1.5 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER w AS avg_price FROM products WINDOW w AS (PARTITION BY group_name ORDER BY group_id GROUPS BETWEEN 1.5 PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER w AS avg_price FROM products WINDOW w AS (PARTITION BY group_name ORDER BY group_id GROUPS BETWEEN UNBOUNDED PRECEDING AND 1.5 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER w AS avg_price FROM products WINDOW w AS (PARTITION BY group_name ROWS 1.5 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER w AS avg_price FROM products WINDOW w AS (PARTITION BY group_name ROWS BETWEEN 1.5 PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER w AS avg_price FROM products WINDOW w AS (PARTITION BY group_name ROWS BETWEEN UNBOUNDED PRECEDING AND 1.5 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER w1, avg(price) OVER w2, avg(price) OVER w1 FROM products WINDOW w1 AS (PARTITION BY group_name ORDER BY group_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), w2 AS (ORDER BY group_id ROWS 1 PRECEDING) ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT c, first_value(c) OVER w, last_value(c) OVER w, nth_value(c, 2) OVER w
FROM t WINDOW w AS (ORDER BY c RANGE BETWEEN 5 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT c0 FROM t103755 WHERE c0 < 0 OR c0 IN (VALUES (2)) ORDER BY c0;

-- sqlfmt-corpus-separator --

SELECT count(a) OVER (ROWS 1 PRECEDING) FROM t

-- sqlfmt-corpus-separator --

SELECT d3,d1,d2 FROM d WHERE (d1,d3) NOT IN (SELECT b1,b2 FROM b WHERE EXISTS (SELECT 1 FROM c WHERE c2=b2 OR c2=b3))

-- sqlfmt-corpus-separator --

SELECT f::DECIMAL + round(max(k) * w * avg(d) OVER wind) + (lead(f, 2, 17::FLOAT) OVER wind::DECIMAL / d * row_number() OVER wind) FROM kv GROUP BY k, w, f, d WINDOW wind AS (ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT first_value(x) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND '0 YEAR'::INTERVAL FOLLOWING) FROM t;

-- sqlfmt-corpus-separator --

SELECT foo.a FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT foo1, foo.foo1, b, foo.c FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT group_name, price, sum(price) OVER (PARTITION BY group_name ORDER BY price DESC RANGE BETWEEN 49.999 FOLLOWING AND 300.001 FOLLOWING) FROM products ORDER BY group_name, price DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, price, sum(price) OVER (PARTITION BY group_name ORDER BY price RANGE BETWEEN 49.999 FOLLOWING AND 300.001 FOLLOWING) FROM products ORDER BY group_name, price, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, price, sum(pricefloat) OVER (PARTITION BY group_name ORDER BY pricefloat DESC RANGE BETWEEN 50 FOLLOWING AND 300 FOLLOWING) FROM products ORDER BY group_name, price DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, price, sum(pricefloat) OVER (PARTITION BY group_name ORDER BY pricefloat RANGE BETWEEN 50 FOLLOWING AND 300 FOLLOWING) FROM products ORDER BY group_name, price, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, pdate, price, sum(price) OVER (ORDER BY pdate DESC RANGE '1 days' PRECEDING) FROM products ORDER BY pdate DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, pdate, price, sum(price) OVER (ORDER BY pdate RANGE '1 days' PRECEDING) FROM products ORDER BY pdate, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, array_agg(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING) AS array_agg_price FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, array_agg(price) OVER (w ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), array_agg(price) OVER (w ROWS BETWEEN UNBOUNDED PRECEDING AND 3 FOLLOWING), array_agg(price) OVER (w GROUPS BETWEEN 3 PRECEDING AND UNBOUNDED FOLLOWING), array_agg(price) OVER (w RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) FROM products WINDOW w AS (PARTITION BY group_name ORDER BY group_id DESC) ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, avg(price) OVER (ORDER BY group_id GROUPS BETWEEN 1 PRECEDING AND 2 PRECEDING), avg(price) OVER (ORDER BY price GROUPS BETWEEN CURRENT ROW AND CURRENT ROW) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, avg(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS (SELECT count(*) FROM PRODUCTS WHERE price = 200) PRECEDING) AS running_avg_of_three FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, avg(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING) AS running_avg FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, avg(price) OVER (PARTITION BY group_name ORDER BY price GROUPS BETWEEN CURRENT ROW AND 3 FOLLOWING), avg(price) OVER (ORDER BY price GROUPS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, avg(price) OVER (PARTITION BY group_name RANGE UNBOUNDED PRECEDING) AS avg_price FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, min(price) OVER (PARTITION BY group_name ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING) AS min_over_empty_frame FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, min(price) OVER (PARTITION BY group_name ROWS CURRENT ROW) AS min_over_single_row FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, nth_value(pricefloat, 2) OVER (PARTITION BY group_name ORDER BY pricefloat DESC RANGE BETWEEN 1.23 FOLLOWING AND 500.23 FOLLOWING) FROM products ORDER BY group_name, pricefloat DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, nth_value(pricefloat, 2) OVER (PARTITION BY group_name ORDER BY pricefloat RANGE BETWEEN 1.23 FOLLOWING AND 500.23 FOLLOWING) FROM products ORDER BY group_name, pricefloat, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS 2 PRECEDING) AS running_sum FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (PARTITION BY group_name ORDER BY price DESC RANGE 200.002 PRECEDING) FROM products ORDER BY group_name, price DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (PARTITION BY group_name ORDER BY price DESC RANGE BETWEEN 99.99 PRECEDING AND 100.00 PRECEDING) FROM products ORDER BY group_name, priceint DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (PARTITION BY group_name ORDER BY price RANGE 200.002 PRECEDING) FROM products ORDER BY group_name, price, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (PARTITION BY group_name ORDER BY price RANGE BETWEEN 99.99 PRECEDING AND 100.00 PRECEDING) FROM products ORDER BY group_name, priceint, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (RANGE BETWEEN CURRENT ROW AND CURRENT ROW) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (RANGE CURRENT ROW) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(pricefloat) OVER (PARTITION BY group_name ORDER BY pricefloat DESC RANGE BETWEEN 200.01 PRECEDING AND 99.99 FOLLOWING) FROM products ORDER BY group_name, priceint DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(pricefloat) OVER (PARTITION BY group_name ORDER BY pricefloat RANGE BETWEEN 200.01 PRECEDING AND 99.99 FOLLOWING) FROM products ORDER BY group_name, priceint, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(priceint) OVER (PARTITION BY group_name ORDER BY priceint DESC RANGE 200 PRECEDING) FROM products ORDER BY group_name, priceint DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(priceint) OVER (PARTITION BY group_name ORDER BY priceint DESC RANGE BETWEEN 300 PRECEDING AND 50 PRECEDING) FROM products ORDER BY group_name, priceint DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(priceint) OVER (PARTITION BY group_name ORDER BY priceint DESC RANGE BETWEEN 50 FOLLOWING AND 300 FOLLOWING) FROM products ORDER BY group_name, priceint DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(priceint) OVER (PARTITION BY group_name ORDER BY priceint RANGE 200 PRECEDING) FROM products ORDER BY group_name, priceint, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(priceint) OVER (PARTITION BY group_name ORDER BY priceint RANGE BETWEEN 300 PRECEDING AND 50 PRECEDING) FROM products ORDER BY group_name, priceint, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(priceint) OVER (PARTITION BY group_name ORDER BY priceint RANGE BETWEEN 50 FOLLOWING AND 300 FOLLOWING) FROM products ORDER BY group_name, priceint, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, ptime, price, min(price) OVER (PARTITION BY group_name ORDER BY ptime DESC RANGE BETWEEN '1 hours' FOLLOWING AND UNBOUNDED FOLLOWING) FROM products ORDER BY group_name, ptime DESC

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, ptime, price, min(price) OVER (PARTITION BY group_name ORDER BY ptime RANGE BETWEEN '1 hours' FOLLOWING AND UNBOUNDED FOLLOWING) FROM products ORDER BY group_name, ptime

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, ptimestamp, price, first_value(price) OVER (PARTITION BY group_name ORDER BY ptimestamp DESC RANGE BETWEEN '12 hours' PRECEDING AND '6 hours' FOLLOWING) FROM products ORDER BY group_name, ptimestamp DESC

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, ptimestamp, price, first_value(price) OVER (PARTITION BY group_name ORDER BY ptimestamp RANGE BETWEEN '12 hours' PRECEDING AND '6 hours' FOLLOWING) FROM products ORDER BY group_name, ptimestamp

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, ptimestamptz, price, avg(price) OVER (PARTITION BY group_name ORDER BY ptimestamptz DESC RANGE BETWEEN '1 days 12 hours' PRECEDING AND CURRENT ROW) FROM products ORDER BY group_name, ptimestamptz DESC

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, ptimestamptz, price, avg(price) OVER (PARTITION BY group_name ORDER BY ptimestamptz RANGE BETWEEN '1 days 12 hours' PRECEDING AND CURRENT ROW) FROM products ORDER BY group_name, ptimestamptz

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(a) OVER (ORDER BY a GROUPS BETWEEN 5 FOLLOWING AND UNBOUNDED FOLLOWING) FROM x

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg(s, s) OVER (ORDER BY s RANGE UNBOUNDED PRECEDING) FROM t54604

-- sqlfmt-corpus-separator --

SELECT k, (avg(w) OVER w + rank() OVER w), k FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, (lag(k, 5, w) OVER w + lead(k, 3, v) OVER w) FROM kv WINDOW w AS (ORDER BY k) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, (rank() OVER w + avg(w) OVER w), k FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, (rank() OVER wind + avg(w) OVER wind), w, (v + row_number() OVER wind), v FROM kv WINDOW wind AS (ORDER BY k) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, avg(d) OVER w1, avg(d) OVER w2, row_number() OVER w2, sum(f) OVER w1, row_number() OVER w1, sum(f) OVER w2 FROM kv WINDOW w1 AS (ORDER BY k), w2 AS (ORDER BY w, k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k, first_value(k) OVER (ORDER BY v GROUPS BETWEEN 0 PRECEDING AND 2 PRECEDING) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, stddev(d) OVER w FROM kv WINDOW w as (PARTITION BY v) ORDER BY variance(d) OVER w, k

-- sqlfmt-corpus-separator --

SELECT k, u FROM t3 WHERE u = 2 FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT k, v + w, round(rank() OVER wind + lead(k, 3, v) OVER wind + lag(w, 1, 2) OVER wind + f::DECIMAL + avg(d) OVER wind)::INT, round(row_number() OVER wind::FLOAT + round(f) + dense_rank() OVER wind::FLOAT)::INT FROM kv WINDOW wind as (PARTITION BY v ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT l IS DISTINCT FROM NULL FROM implicit_types;

-- sqlfmt-corpus-separator --

SELECT l IS NOT DISTINCT FROM NULL FROM implicit_types;

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER w, lead(x) OVER w, first_value(x) OVER w, last_value(x) OVER w FROM t WINDOW w AS (ORDER BY x);

-- sqlfmt-corpus-separator --

SELECT lag(y) OVER w, lead(y) OVER w, first_value(y) OVER w, last_value(y) OVER w FROM t WINDOW w AS ();

-- sqlfmt-corpus-separator --

SELECT max(c) OVER (ORDER BY c ROWS BETWEEN UNBOUNDED PRECEDING AND 9223372036854775807::INT8 FOLLOWING) FROM t65978

-- sqlfmt-corpus-separator --

SELECT max(c) OVER (ORDER BY c ROWS BETWEEN UNBOUNDED PRECEDING AND 9223372036854775807::INT8 PRECEDING) FROM t65978

-- sqlfmt-corpus-separator --

SELECT max(c) OVER (ROWS BETWEEN 9223372036854775807::INT8 FOLLOWING AND UNBOUNDED FOLLOWING) FROM t65978

-- sqlfmt-corpus-separator --

SELECT max(c) OVER (ROWS BETWEEN 9223372036854775807::INT8 PRECEDING AND UNBOUNDED FOLLOWING) FROM t65978

-- sqlfmt-corpus-separator --

SELECT oid(3), oid(0), (-1)::oid, (-2147483648)::oid, (4294967295)::oid

-- sqlfmt-corpus-separator --

SELECT price, avg(price) OVER (PARTITION BY price ORDER BY group_id GROUPS -1 PRECEDING) AS avg_price FROM products

-- sqlfmt-corpus-separator --

SELECT price, avg(price) OVER (PARTITION BY price ORDER BY group_id GROUPS BETWEEN 1 FOLLOWING AND -1 FOLLOWING) AS avg_price FROM products

-- sqlfmt-corpus-separator --

SELECT price, avg(price) OVER (PARTITION BY price ROWS -1 PRECEDING) AS avg_price FROM products

-- sqlfmt-corpus-separator --

SELECT price, avg(price) OVER (PARTITION BY price ROWS BETWEEN 1 FOLLOWING AND -1 FOLLOWING) AS avg_price FROM products

-- sqlfmt-corpus-separator --

SELECT price, avg(price) OVER w AS avg_price FROM products WINDOW w AS (PARTITION BY price ORDER BY group_id GROUPS -1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT price, avg(price) OVER w AS avg_price FROM products WINDOW w AS (PARTITION BY price ORDER BY group_id GROUPS BETWEEN 1 FOLLOWING AND -1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT price, avg(price) OVER w AS avg_price FROM products WINDOW w AS (PARTITION BY price ROWS -1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT price, avg(price) OVER w AS avg_price FROM products WINDOW w AS (PARTITION BY price ROWS BETWEEN 1 FOLLOWING AND -1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT price, dense_rank() OVER w, avg(price) OVER (w GROUPS BETWEEN 0 PRECEDING AND 0 PRECEDING), avg(price) OVER (w GROUPS BETWEEN 0 PRECEDING AND CURRENT ROW), avg(price) OVER (w GROUPS BETWEEN 0 PRECEDING AND 0 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN CURRENT ROW AND CURRENT ROW), avg(price) OVER (w GROUPS BETWEEN CURRENT ROW AND 2 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN CURRENT ROW AND 100 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) FROM products WINDOW w AS (ORDER BY price) ORDER BY price

-- sqlfmt-corpus-separator --

SELECT price, dense_rank() OVER w, avg(price) OVER (w GROUPS BETWEEN 3 FOLLOWING AND 100 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 3 FOLLOWING AND 1 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 2 FOLLOWING AND 6 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 3 FOLLOWING AND 3 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 0 FOLLOWING AND 4 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 5 FOLLOWING AND UNBOUNDED FOLLOWING) FROM products WINDOW w AS (ORDER BY price) ORDER BY price

-- sqlfmt-corpus-separator --

SELECT price, dense_rank() OVER w, avg(price) OVER (w GROUPS BETWEEN 4 PRECEDING AND 100 PRECEDING), avg(price) OVER (w GROUPS BETWEEN 3 PRECEDING AND 2 PRECEDING), avg(price) OVER (w GROUPS BETWEEN 2 PRECEDING AND CURRENT ROW), avg(price) OVER (w GROUPS BETWEEN 1 PRECEDING AND 2 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 1 PRECEDING AND 100 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING) FROM products WINDOW w AS (ORDER BY price) ORDER BY price

-- sqlfmt-corpus-separator --

SELECT price, dense_rank() OVER w, avg(price) OVER (w GROUPS BETWEEN UNBOUNDED PRECEDING AND 100 PRECEDING), avg(price) OVER (w GROUPS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING), avg(price) OVER (w GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), avg(price) OVER (w GROUPS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN UNBOUNDED PRECEDING AND 100 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) FROM products WINDOW w AS (ORDER BY price) ORDER BY price

-- sqlfmt-corpus-separator --

SELECT price, sum(price) OVER (ORDER BY price GROUPS UNBOUNDED PRECEDING), sum(price) OVER (ORDER BY price GROUPS 100 PRECEDING), sum(price) OVER (ORDER BY price GROUPS 1 PRECEDING), sum(price) OVER (ORDER BY group_name GROUPS CURRENT ROW) FROM products ORDER BY price, group_id

-- sqlfmt-corpus-separator --

SELECT product_name, group_name, price, avg(price) OVER (PARTITION BY group_name ORDER BY price, product_name ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS avg_of_three FROM products ORDER BY group_name, price, product_name

-- sqlfmt-corpus-separator --

SELECT product_name, group_name, price, avg(priceFloat) OVER (PARTITION BY group_name ORDER BY price, product_name ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS avg_of_three_floats FROM products ORDER BY group_name, price, product_name

-- sqlfmt-corpus-separator --

SELECT product_name, group_name, price, avg(priceInt) OVER (PARTITION BY group_name ORDER BY price, product_name ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS avg_of_three_ints FROM products ORDER BY group_name, price, product_name

-- sqlfmt-corpus-separator --

SELECT product_name, pinterval, price, avg(price) OVER (ORDER BY pinterval DESC RANGE BETWEEN '2 hours 34 minutes 56 seconds' PRECEDING AND '3 months' FOLLOWING) FROM products ORDER BY pinterval DESC, group_id

-- sqlfmt-corpus-separator --

SELECT product_name, pinterval, price, avg(price) OVER (ORDER BY pinterval RANGE BETWEEN '2 hours 34 minutes 56 seconds' PRECEDING AND '3 months' FOLLOWING) FROM products ORDER BY pinterval, group_id

-- sqlfmt-corpus-separator --

SELECT product_name, price, first_value(product_name) OVER w AS first FROM products WHERE price = 200 OR price = 700 WINDOW w as (PARTITION BY price ORDER BY product_name RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) ORDER BY price, product_name

-- sqlfmt-corpus-separator --

SELECT product_name, price, last_value(product_name) OVER w AS last FROM products WHERE price = 200 OR price = 700 WINDOW w as (PARTITION BY price ORDER BY product_name RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) ORDER BY price, product_name

-- sqlfmt-corpus-separator --

SELECT product_name, price, min(price) OVER (PARTITION BY group_name ORDER BY group_id GROUPS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS min_over_three, max(price) OVER (PARTITION BY group_name ORDER BY group_id GROUPS BETWEEN UNBOUNDED PRECEDING AND -1 FOLLOWING) AS max_over_partition FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT product_name, price, min(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS min_over_three, max(price) OVER (PARTITION BY group_name ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_over_partition FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT product_name, price, min(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS UNBOUNDED PRECEDING), max(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING), sum(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING), avg(price) OVER (PARTITION BY group_name ROWS CURRENT ROW) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT product_name, price, min(price) OVER (PARTITION BY group_name ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS min_over_three, max(price) OVER (PARTITION BY group_name ROWS BETWEEN UNBOUNDED PRECEDING AND -1 FOLLOWING) AS max_over_partition FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT product_name, price, nth_value(product_name, 2) OVER w AS second FROM products WHERE price = 200 OR price = 700 WINDOW w as (PARTITION BY price ORDER BY product_name RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) ORDER BY price, product_name

-- sqlfmt-corpus-separator --

SELECT product_name, ptime, price, avg(price) OVER (ORDER BY ptime DESC RANGE BETWEEN '1 hours 15 minutes' PRECEDING AND '1 hours 15 minutes' FOLLOWING) FROM products ORDER BY ptime DESC, group_id

-- sqlfmt-corpus-separator --

SELECT product_name, ptime, price, avg(price) OVER (ORDER BY ptime RANGE BETWEEN '1 hours 15 minutes' PRECEDING AND '1 hours 15 minutes' FOLLOWING) FROM products ORDER BY ptime, group_id

-- sqlfmt-corpus-separator --

SELECT public."LOWERCASE_HINT_ERROR_EXPLICIT_SCHEMA_FN"();

-- sqlfmt-corpus-separator --

SELECT round((avg(d) OVER wind) * max(k) + (lag(d, 1, 42.0) OVER wind) * max(d)) FROM kv GROUP BY d, k WINDOW wind AS (ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT round(max(w) * w * avg(w) OVER wind) + (lead(w, 2, 17) OVER wind::DECIMAL / w * row_number() OVER wind) FROM kv GROUP BY w WINDOW wind AS (PARTITION BY w) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT round(row_number() OVER w1 + lead(k, v, w) OVER w2 + avg(k) OVER w1), (lag(k, 1) OVER w1 + v + rank() OVER w2 + min(k) OVER w1) FROM kv WINDOW w1 AS (PARTITION BY w ORDER BY k), w2 AS (PARTITION BY b ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT rowid, foo.rowid FROM ab AS foo (foo1, foo2)

-- sqlfmt-corpus-separator --

SELECT s, w + k, (sum(w) OVER wind + avg(d) OVER wind), (min(w) OVER wind + d), v FROM kv WINDOW wind AS (ORDER BY w, k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT sum(price) OVER (ORDER BY pdate RANGE '-1 days' PRECEDING) FROM products

-- sqlfmt-corpus-separator --

SELECT sum(price) OVER (ORDER BY price RANGE BETWEEN 123.4 PRECEDING AND '1 days' FOLLOWING) FROM products

-- sqlfmt-corpus-separator --

SELECT sum(price) OVER (ORDER BY price, priceint RANGE 100 PRECEDING) FROM products

-- sqlfmt-corpus-separator --

SELECT sum(price) OVER (ORDER BY product_name RANGE 'foo' PRECEDING) FROM products

-- sqlfmt-corpus-separator --

SELECT sum(price) OVER (ORDER BY ptime RANGE BETWEEN '-1 hours' PRECEDING AND '1 hours' FOLLOWING) FROM products

-- sqlfmt-corpus-separator --

SELECT sum(price) OVER (ORDER BY ptime RANGE BETWEEN '1 hours' PRECEDING AND '-1 hours' FOLLOWING) FROM products

-- sqlfmt-corpus-separator --

SELECT sum(price) OVER (ORDER BY ptimestamp RANGE 123.4 PRECEDING) FROM products

-- sqlfmt-corpus-separator --

SELECT sum(price) OVER (ORDER BY ptimestamptz RANGE BETWEEN 123 PRECEDING AND CURRENT ROW) FROM products

-- sqlfmt-corpus-separator --

SELECT sum(price) OVER (RANGE 100 PRECEDING) FROM products

-- sqlfmt-corpus-separator --

SELECT table_catalog, table_schema, table_name, table_type, is_insertable_into
FROM system.information_schema.tables
WHERE
(table_schema <> 'crdb_internal' OR table_name = 'node_build_info')
AND NOT (table_schema = 'public' AND table_name <> 'locations')
ORDER BY table_name, table_schema

-- sqlfmt-corpus-separator --

SELECT x, y, first_value(y) OVER (PARTITION BY x ROWS BETWEEN CURRENT ROW AND CURRENT ROW) FROM t;

-- sqlfmt-corpus-separator --

SELECT y.a, (
  WITH foo AS MATERIALIZED (SELECT x.a FROM x WHERE x.a = y.a)
  SELECT * FROM foo
) FROM y

-- sqlfmt-corpus-separator --

SELECT |/ -1.0::float

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

VALUES ('pg_constraint'::REGCLASS, 'pg_catalog.pg_constraint'::REGCLASS)

-- sqlfmt-corpus-separator --

VALUES ((SELECT 1)), ((SELECT 2))

-- sqlfmt-corpus-separator --

VALUES (1) EXCEPT VALUES (NULL) ORDER BY 1

-- sqlfmt-corpus-separator --

VALUES (1) FOR UPDATE

-- sqlfmt-corpus-separator --

VALUES (1) INTERSECT VALUES (NULL) ORDER BY 1

-- sqlfmt-corpus-separator --

VALUES (1) UNION ALL VALUES (NULL) ORDER BY 1

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

VALUES (1), (2) UNION VALUES (2), (3)

-- sqlfmt-corpus-separator --

VALUES (1), (2, 3)

-- sqlfmt-corpus-separator --

VALUES (1, (SELECT (2)))

-- sqlfmt-corpus-separator --

VALUES (1, 10), (2, NULL), (3, 30), (NULL, 40)
ORDER BY (SELECT count(*) FROM t_lookup WHERE k = column1) NULLS LAST, column1 NULLS FIRST

-- sqlfmt-corpus-separator --

VALUES (1, 2), (1, 1), (1, 2), (2, 1), (2, 1) UNION VALUES (1, 3), (3, 4), (1, 1)

-- sqlfmt-corpus-separator --

VALUES (1, 2, 1.0, 'string1'), (4, 3, 2.3, 'string2')

-- sqlfmt-corpus-separator --

VALUES (1, 2, 3), (4, 5, 6)

-- sqlfmt-corpus-separator --

VALUES (@485)

-- sqlfmt-corpus-separator --

VALUES (NULL) EXCEPT VALUES (1) ORDER BY 1

-- sqlfmt-corpus-separator --

VALUES (NULL) EXCEPT VALUES (NULL)

-- sqlfmt-corpus-separator --

VALUES (NULL) INTERSECT VALUES (1) ORDER BY 1

-- sqlfmt-corpus-separator --

VALUES (NULL) INTERSECT VALUES (NULL)

-- sqlfmt-corpus-separator --

VALUES (NULL) UNION ALL VALUES (1) ORDER BY 1

-- sqlfmt-corpus-separator --

VALUES (NULL) UNION ALL VALUES (NULL)

-- sqlfmt-corpus-separator --

VALUES (NULL, 1), (2, NULL), (NULL, 'a')

-- sqlfmt-corpus-separator --

VALUES (format_type('anyelement'::regtype, -1)),
       (format_type('bit'::regtype, -1)),
       (format_type('bool'::regtype, -1)),
       (format_type('bytea'::regtype, -1)),
       (format_type('char'::regtype, -1)),
       (format_type('"char"'::regtype, -1)),
       (format_type('date'::regtype, -1)),
       (format_type('decimal'::regtype, -1)),
       (format_type('float'::regtype, -1)),
       (format_type('float4'::regtype, -1)),
       (format_type('interval'::regtype, -1)),
       (format_type('numeric'::regtype, -1)),
       (format_type('oid'::regtype, -1)),
       (format_type('oidvector'::regtype, -1)),
       (format_type('inet'::regtype, -1)),
       (format_type('int'::regtype, -1)),
       (format_type('int4'::regtype, -1)),
       (format_type('int2'::regtype, -1)),
       (format_type('int2vector'::regtype, -1)),
       (format_type('interval'::regtype, -1)),
       (format_type('json'::regtype, -1)),
       (format_type('name'::regtype, -1)),
       (format_type('regclass'::regtype, -1)),
       (format_type('regnamespace'::regtype, -1)),
       (format_type('regproc'::regtype, -1)),
       (format_type('regprocedure'::regtype, -1)),
       (format_type('regrole'::regtype, -1)),
       (format_type('regtype'::regtype, -1)),
       (format_type('string'::regtype, -1)),
       (format_type('time'::regtype, -1)),
       (format_type('timestamp'::regtype, -1)),
       (format_type('timestamptz'::regtype, -1)),
       (format_type('record'::regtype, -1)),
       (format_type('uuid'::regtype, -1)),
       (format_type('unknown'::regtype, -1)),
       (format_type('varbit'::regtype, -1)),
       (format_type('varchar'::regtype, -1)),
       (format_type('void'::regtype, -1)),
       (format_type('int[]'::regtype, -1)),
       (format_type('int2[]'::regtype, -1)),
       (format_type('string[]'::regtype, -1)),
       (format_type('varchar[]'::regtype, -1)),
       (format_type('pg_catalog.int4'::regtype, -1)),
       (format_type('pg_catalog.int2'::regtype, -1))

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

VALUES (generate_series(1,3))

-- sqlfmt-corpus-separator --

VALUES (length('a')), (1 + length('a')), (length('abc')), (length('ab') * 2)

-- sqlfmt-corpus-separator --

WITH
    a AS (INSERT INTO y VALUES (1) RETURNING 1), b AS (DELETE FROM x WHERE true RETURNING 1)
SELECT
    *
FROM
    a

-- sqlfmt-corpus-separator --

WITH
    foo(f) AS (SELECT array_agg(x) FROM generate_series(1, 3) g(x)),
    bar(b) AS (SELECT array_agg(f) FROM foo, generate_series(1, 3)),
    baz(z) AS (SELECT array_agg(b) FROM bar, generate_series(1, 3))
SELECT z FROM baz;

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
  a AS (SELECT crdb_internal.create_session_revival_token() AS token),
  b AS (
    SELECT
      crdb_internal.pb_to_json(
        'cockroach.sql.sessiondatapb.SessionRevivalToken',
        a.token
      ) AS json_token
    FROM a
  ),
  c AS (
    SELECT
      (json_populate_record(
        NULL::token_payload,
        crdb_internal.pb_to_json(
          'cockroach.sql.sessiondatapb.SessionRevivalToken.Payload',
          decode(b.json_token->>'payload', 'base64'),
          true
        )
      )).*
    FROM b
  )
SELECT
  algorithm,
  "user",
  "expiresAt" > now(),
  "expiresAt" < (now() + INTERVAL '11 minutes'),
  "expiresAt" > "issuedAt",
  crdb_internal.validate_session_revival_token(a.token)
FROM
  c, a

-- sqlfmt-corpus-separator --

WITH
  cte1 AS (SELECT b FROM ab ORDER BY a),
  cte2 AS (SELECT y FROM xy ORDER BY x, y)
SELECT * FROM cte1 UNION ALL SELECT * FROM cte2

-- sqlfmt-corpus-separator --

WITH
  cte1 AS (SELECT b FROM ab ORDER BY a+b),
  cte2 AS (SELECT DISTINCT ON (x) y FROM xy ORDER BY x, y)
SELECT * FROM cte1 UNION ALL SELECT * FROM cte2

-- sqlfmt-corpus-separator --

WITH
  t AS (DELETE FROM r WHERE i IN (SELECT i FROM s) RETURNING i),
  u AS (DELETE FROM s WHERE i IN (SELECT i FROM t) RETURNING i)
SELECT i FROM r WHERE i IN (SELECT i FROM s)

-- sqlfmt-corpus-separator --

WITH
  t AS (INSERT INTO r SELECT i FROM s ON CONFLICT (i) DO UPDATE SET i = r.i + 2 RETURNING r.i),
  u AS (INSERT INTO s SELECT i FROM t ON CONFLICT (i) DO UPDATE SET i = s.i - 2 RETURNING s.i)
SELECT * FROM r, u

-- sqlfmt-corpus-separator --

WITH
  t AS (INSERT INTO r VALUES (1) RETURNING i),
  u AS (INSERT INTO s SELECT * FROM r RETURNING i)
SELECT i FROM s

-- sqlfmt-corpus-separator --

WITH
  t AS (UPDATE r SET i = i + 2 RETURNING i),
  u AS (UPDATE s SET i = -r.i FROM r WHERE s.i < r.i RETURNING s.i)
SELECT i FROM u

-- sqlfmt-corpus-separator --

WITH
  u1 AS (UPDATE t SET j = j - 40 WHERE i < 20 RETURNING *),
  u2 AS (UPDATE t SET j = j + 40 WHERE i >= 20 RETURNING *)
TABLE u1 UNION ALL TABLE u2

-- sqlfmt-corpus-separator --

WITH
  v AS (UPDATE u SET j = 3 WHERE i = 0 RETURNING *),
  w AS (UPDATE u SET j = 4 WHERE i = 0 RETURNING *)
SELECT * FROM u

-- sqlfmt-corpus-separator --

WITH
  v AS (UPDATE u SET j = 5 WHERE i = 0 RETURNING *),
  w AS (UPDATE u SET j = v.j + 1 FROM v WHERE u.i = v.i RETURNING *)
SELECT * FROM w

-- sqlfmt-corpus-separator --

WITH RECURSIVE cte(a, b) AS (
    VALUES (1, 1), (1, 2), (2, 2)
  UNION
    SELECT (a+i) % 4, (b+1-i) % 4 FROM cte, (VALUES (0), (1)) AS v(i)
) SELECT * FROM cte;

-- sqlfmt-corpus-separator --

WITH RECURSIVE cte(a, b) AS (
    VALUES (1, 1), (1, 2), (2, 2)
  UNION
    SELECT 4-a, 4-a FROM cte
) SELECT * FROM cte;

-- sqlfmt-corpus-separator --

WITH RECURSIVE cte(a, b) AS (
    VALUES (2, 2), (1, 1), (1, 2), (1, 1), (1, 3), (1, 2), (2, 2)
  UNION
    SELECT a+10, b+10 FROM cte WHERE a < 20
) SELECT * FROM cte;

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(i) AS
    (SELECT i FROM (VALUES(1),(2)) t(i)
    UNION ALL
    SELECT (i+1)::numeric(10,0) FROM foo WHERE i < 10)
SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE nodes AS (
  SELECT 'A' AS id
  UNION ALL
  SELECT graph_node.id FROM graph_node JOIN nodes ON graph_node.parent = nodes.id
)
SELECT * FROM nodes

-- sqlfmt-corpus-separator --

WITH RECURSIVE points AS (
  SELECT i::float * 0.05 AS r, j::float * 0.05 AS c
  FROM generate_series(-20, 20) AS a (i), generate_series(-30, 30) AS b (j)
), iterations AS (
   SELECT r, c, c::float AS zr, r::float AS zc, 0 AS iteration FROM points
   UNION ALL
   SELECT r, c, zr*zr - zc*zc + 1 - 1.61803398875 AS zr, 2*zr*zc AS zc, iteration+1 AS iteration
   FROM iterations WHERE zr*zr + zc*zc < 4 AND iteration < 20
), final_iteration AS (
  SELECT * FROM iterations WHERE iteration = 20
), marked_points AS (
   SELECT r, c, (CASE WHEN EXISTS (SELECT 1 FROM final_iteration i WHERE p.r = i.r AND p.c = i.c)
                  THEN 'oo'
                  ELSE '··'
                  END) AS marker
   FROM points p
), rows AS (
   SELECT r, string_agg(marker, '' ORDER BY c ASC) AS r_text
   FROM marked_points
   GROUP BY r
) SELECT string_agg(r_text, E'\n' ORDER BY r DESC) FROM rows

-- sqlfmt-corpus-separator --

WITH RECURSIVE points AS (
  SELECT i::float * 0.05 AS r, j::float * 0.05 AS c
  FROM generate_series(-20, 20) AS a (i), generate_series(-40, 20) AS b (j)
), iterations AS (
     SELECT r,
            c,
            0.0::float AS zr,
            0.0::float AS zc,
            0 AS iteration
     FROM points
   UNION ALL
     SELECT r,
            c,
            zr*zr - zc*zc + c AS zr,
            2*zr*zc + r AS zc,
            iteration+1 AS iteration
     FROM iterations WHERE zr*zr + zc*zc < 4 AND iteration < 20
), final_iteration AS (
  SELECT * FROM iterations WHERE iteration = 20
), marked_points AS (
   SELECT r,
          c,
          (CASE WHEN EXISTS (SELECT 1 FROM final_iteration i WHERE p.r = i.r AND p.c = i.c)
                THEN 'oo' ELSE '··' END) AS marker FROM points p
), lines AS (
   SELECT r, string_agg(marker, '' ORDER BY c ASC) AS r_text
   FROM marked_points
   GROUP BY r
) SELECT string_agg(r_text, E'\n' ORDER BY r DESC) FROM lines

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    VALUES (1)
  UNION
    SELECT n+y FROM t, (VALUES (1), (2)) AS v(y) WHERE n < 99
)
SELECT sum(n) FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    VALUES (1)
  UNION ALL
    SELECT n+1 FROM t WHERE n < 100
)
SELECT sum(n) FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE temp (i) AS (
  (SELECT n FROM ints ORDER BY n ASC LIMIT 1)
UNION ALL (
  SELECT n FROM temp,
    LATERAL (
      SELECT n
      FROM ints
      WHERE n > i
      ORDER BY n ASC
      LIMIT 1
    ) sub
  )
)
SELECT * FROM temp;

-- sqlfmt-corpus-separator --

WITH RECURSIVE temp (i) AS (
  (SELECT n FROM ints ORDER BY n ASC LIMIT 1)
UNION ALL (
  SELECT n FROM temp,
    LATERAL (
      SELECT n
      FROM ints
      WHERE n > i
      ORDER BY n ASC
      LIMIT 1
    ) sub
  )
)
SELECT count(*) FROM temp;

-- sqlfmt-corpus-separator --

WITH RECURSIVE temp (i) AS (
  (SELECT n FROM ints ORDER BY n ASC LIMIT 1)
UNION ALL (
  SELECT n FROM temp,
    LATERAL (
      SELECT n
      FROM ints
      WHERE n > i
      ORDER BY n ASC
      LIMIT 1
    ) sub LIMIT 1
  )
)
SELECT * FROM temp;

-- sqlfmt-corpus-separator --

WITH RECURSIVE temp (i) AS (
  (SELECT n FROM ints ORDER BY n ASC LIMIT 1)
UNION ALL (
  SELECT n FROM temp,
    LATERAL (
      SELECT n
      FROM ints
      WHERE n > i
      ORDER BY n ASC
      LIMIT 1
    ) sub LIMIT 1
  )
)
SELECT count(*) FROM temp;

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(a) AS (
    VALUES ('a'), ('b')
  UNION ALL
    (WITH z AS (SELECT * FROM x)
      SELECT z.a || z1.a AS a FROM z CROSS JOIN z AS z1 WHERE length(z.a) < 3
    )
)
SELECT * FROM x

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

WITH a(a) AS ( VALUES
  ('2010-11-06 23:59:00'::timestamptz + '24 hours'::interval), -- no offset specified
  ('2010-11-06 23:59:00'::timestamptz + '1 day'::interval),
  ('2010-11-06 23:59:00'::timestamptz + '1 month'::interval),
  ('2010-11-07 23:59:00'::timestamptz - '24 hours'::interval),
  ('2010-11-07 23:59:00'::timestamptz - '1 day'::interval),
  ('2010-11-07 23:59:00'::timestamptz - '1 month'::interval),
  ('2010-11-06 23:59:00-05'::timestamptz + '24 hours'::interval), -- offset at time zone
  ('2010-11-06 23:59:00-05'::timestamptz + '1 day'::interval),
  ('2010-11-06 23:59:00-05'::timestamptz + '1 month'::interval),
  ('2010-11-07 23:59:00-06'::timestamptz - '24 hours'::interval),
  ('2010-11-07 23:59:00-06'::timestamptz - '1 day'::interval),
  ('2010-11-07 23:59:00-06'::timestamptz - '1 month'::interval),
  ('2010-11-06 23:59:00-04'::timestamptz + '24 hours'::interval), -- different offset
  ('2010-11-06 23:59:00-04'::timestamptz + '1 day'::interval),
  ('2010-11-06 23:59:00-04'::timestamptz + '1 month'::interval),
  ('2010-11-07 23:59:00-04'::timestamptz - '24 hours'::interval),
  ('2010-11-07 23:59:00-04'::timestamptz - '1 day'::interval),
  ('2010-11-07 23:59:00-04'::timestamptz - '1 month'::interval)
) select * from a;

-- sqlfmt-corpus-separator --

WITH cte (x, a, b) AS (SELECT x, random(), random() FROM (VALUES (1), (2), (3)) AS v(x))
SELECT count(*) FROM cte WHERE a = b

-- sqlfmt-corpus-separator --

WITH cte(col) AS (
  VALUES
    ('false'::JSONB),
    (jsonb_object(ARRAY['0', '', e'\x14', '']::TEXT[]))
  )
SELECT jsonb_object_agg('k', 'v') OVER (PARTITION BY cte.col) FROM cte;

-- sqlfmt-corpus-separator --

WITH foo AS (DELETE FROM z RETURNING 1) SELECT 4

-- sqlfmt-corpus-separator --

WITH foo AS (INSERT INTO t1 VALUES (1, 2) RETURNING a) SELECT insert_t1();

-- sqlfmt-corpus-separator --

WITH foo AS (INSERT INTO t2 VALUES (1, 1) RETURNING a) SELECT insert_t1();

-- sqlfmt-corpus-separator --

WITH foo AS (INSERT INTO z VALUES (10) RETURNING 1) SELECT 2

-- sqlfmt-corpus-separator --

WITH foo AS (UPDATE t2 SET b = 1 WHERE a = 1 RETURNING a) SELECT insert_t1();

-- sqlfmt-corpus-separator --

WITH foo AS (UPDATE z SET c = 20 RETURNING 1) SELECT 3

-- sqlfmt-corpus-separator --

WITH indexes AS (
    SELECT json_array_elements(crdb_internal.pb_to_json('cockroach.sql.sqlbase.Descriptor', descriptor)->'table'->'indexes') AS idx
    FROM system.descriptor AS d
    JOIN system.namespace AS n
    ON d.id = n.id
    WHERE n.name = 'a'
)
SELECT idx->>'name', idx->>'id' FROM indexes

-- sqlfmt-corpus-separator --

WITH payloads AS (
  SELECT *
  FROM crdb_internal.payloads_for_trace(crdb_internal.trace_id())
) SELECT count(*) > 0
  FROM payloads
  WHERE payload_type = 'roachpb.ContentionEvent'
  AND crdb_internal.pretty_key(decode(payload_jsonb->>'key', 'base64'), 1) LIKE '/1/"k"/%'

-- sqlfmt-corpus-separator --

WITH payloads AS (
  SELECT *
  FROM crdb_internal.payloads_for_trace(crdb_internal.trace_id())
) SELECT count(*) > 0
  FROM payloads
  WHERE payload_type = 'roachpb.ContentionEvent'
  AND crdb_internal.pretty_key(decode(payload_jsonb->>'key', 'base64'), 1) LIKE '/1/"k"/%'
  AND (payload_jsonb->'txnMeta'->>'coordinatorNodeId')::INTEGER = 4

-- sqlfmt-corpus-separator --

WITH q (x, y) AS (
  SELECT * FROM (VALUES ('a', 'a'), ('b', 'b'), ('c', 'c'))
  UNION ALL
  SELECT * FROM (VALUES ('d', 'd'))
)
SELECT 'e', y FROM q
ORDER BY x

-- sqlfmt-corpus-separator --

WITH spans AS (
  SELECT span_id
  FROM crdb_internal.node_inflight_trace_spans
  WHERE trace_id = crdb_internal.trace_id()
), payloads AS (
  SELECT *
  FROM spans, LATERAL crdb_internal.payloads_for_span(spans.span_id)
) SELECT count(*) > 0
  FROM payloads
  WHERE payload_type = 'roachpb.ContentionEvent'
  AND crdb_internal.pretty_key(decode(payload_jsonb->>'key', 'base64'), 1) LIKE '/1/"k"/%'

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (
  VALUES
    ((1, 1), 1),
    ((NULL::RECORD), 2),
    ((1, NULL::INT), 3),
    ((NULL::INT, NULL::INT), 4)
)
SELECT *
FROM t
ORDER BY x;

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (
  VALUES
    ((1, 1), 1),
    ((NULL::RECORD), 2),
    ((1, NULL::INT), 3),
    ((NULL::INT, NULL::INT), 4)
)
SELECT array_agg(x ORDER BY x NULLS FIRST)
FROM t;

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (
  VALUES
    ((1, 1), 1),
    ((NULL::RECORD), 2),
    ((1, NULL::INT), 3),
    ((NULL::INT, NULL::INT), 4)
)
SELECT array_agg(x ORDER BY x)
FROM t;

-- sqlfmt-corpus-separator --

WITH t AS (
    DELETE FROM x RETURNING a
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
    INSERT INTO x(a) VALUES(0)
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
    UPDATE x SET a = a * 100 RETURNING a
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t3(c1, c2) AS (
  SELECT t2.b AS c1, t2.k AS c2 FROM t100561a t1 FULL OUTER JOIN t100561b t2 ON true
)
SELECT t3.c2, t3.c1 FROM t3, t100561b t2
WHERE t3.c2 = t2.k

-- sqlfmt-corpus-separator --

WITH tmp AS (SELECT * FROM generate_series(1, 10) i ORDER BY i % 5 ASC, i ASC)
SELECT * FROM tmp ORDER BY i DESC;

-- sqlfmt-corpus-separator --

WITH tmp AS (SELECT * FROM generate_series(1, 10) i ORDER BY i % 5 ASC, i ASC) SELECT * FROM tmp;

-- sqlfmt-corpus-separator --

WITH tmp(a, b, c) AS MATERIALIZED (VALUES (1, 'foo', true))
SELECT strict_fn(a, b, c) FROM tmp

-- sqlfmt-corpus-separator --

WITH u AS (
  UPDATE kv SET v = v + 10 RETURNING k
)
SELECT
get_l(k) l1, get_l(int_identity_v(k)) l2,
get_i(k) i1, get_i(int_identity_v(k)) i2,
get_s(k) s1, get_s(int_identity_v(k)) s2,
get_v(k) v1, get_v(int_identity_v(k)) v2
FROM u;

-- sqlfmt-corpus-separator --

WITH v(id, x) AS (VALUES (1, '0'::numeric), (2, '1'::numeric), (3, '-1'::numeric),
  (4, '4.2'::numeric), (5, 'inf'::numeric), (6, '-inf'::numeric), (7, 'nan'::numeric)
)
SELECT x1, x2,
  x1 / x2 AS quot,
  x1 % x2 AS mod,
  div(x1, x2) AS div
FROM v AS v1(id1, x1), v AS v2(id2, x2) WHERE x2 != 0
ORDER BY id1, id2

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'::numeric),('-1'::numeric),('4.2'::numeric),
    ('-7.777'::numeric),('9127.777'::numeric),('inf'::numeric),('-inf'::numeric),('nan'::numeric))
SELECT x, trunc(x), trunc(x,1), trunc(x,2), trunc(x,0), trunc(x,-1), trunc(x,-2)
FROM v

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'::numeric),('-1'::numeric),('4.2'::numeric),('inf'::numeric),('-inf'::numeric),('nan'::numeric))
SELECT x1, x2,
  x1 + x2 AS sum,
  x1 - x2 AS diff,
  x1 * x2 AS prod
FROM v AS v1(x1), v AS v2(x2)

-- sqlfmt-corpus-separator --

WITH v(x) AS
(VALUES (' inf '), (' +inf '), (' -inf '), (' Infinity '), (' +inFinity '), (' -INFINITY '))
SELECT x1::decimal
FROM v AS v1(x1)

-- sqlfmt-corpus-separator --

WITH w(i) AS MATERIALIZED (
  (VALUES (1))
)
SELECT k, i,
  CASE WHEN k > 0 THEN (
    WITH w(i) AS MATERIALIZED (
      (VALUES (2))
    )
    SELECT * FROM w UNION ALL SELECT i+corr.i FROM corr tmp LIMIT 1
  ) END w
FROM corr
UNION ALL
SELECT NULL, NULL, i FROM w

-- sqlfmt-corpus-separator --

WITH x AS (INSERT INTO parent VALUES (2) RETURNING p) SELECT f_fk_c(101, 2);

-- sqlfmt-corpus-separator --

WITH x AS (SELECT f(0) AS j), y AS (UPDATE child SET j = 2 WHERE i = 0 RETURNING j) SELECT * FROM x;

-- sqlfmt-corpus-separator --

WITH x AS (SELECT f(0) AS j), y AS (UPDATE child SET j = 2, k = 2 WHERE i = 0 RETURNING j) SELECT * FROM x;

-- sqlfmt-corpus-separator --

WITH x AS (SELECT f(0) AS j), y AS (UPDATE grandchild SET j = 2 WHERE i = 0 RETURNING j) SELECT * FROM x;