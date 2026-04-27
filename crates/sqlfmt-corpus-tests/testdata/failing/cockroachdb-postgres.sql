((SELECT 1 FOR UPDATE SKIP LOCKED))

-- sqlfmt-corpus-separator --

((SELECT 1 FOR UPDATE)) FOR UPDATE

-- sqlfmt-corpus-separator --

((SELECT 1) FOR UPDATE SKIP LOCKED)

-- sqlfmt-corpus-separator --

((SELECT 1) FOR UPDATE) FOR UPDATE

-- sqlfmt-corpus-separator --

((SELECT 1)) FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

((WITH lim(x) AS (SELECT 1) SELECT 123)
 LIMIT (
    SELECT x FROM lim -- intuitively this should refer to the real table lim defined above
                      -- and use LIMIT 0;
                      -- however, postgres flattens the inner WITH and outer LIMIT
                      -- at the same scope so the limit becomes 1.
 ))

-- sqlfmt-corpus-separator --

((WITH lim(x) AS (SELECT 1) SELECT 123) LIMIT (SELECT x FROM lim))

-- sqlfmt-corpus-separator --

(SELECT * FROM foo WHERE x = 2) FOR UPDATE

-- sqlfmt-corpus-separator --

(SELECT * FROM foo) FOR UPDATE

-- sqlfmt-corpus-separator --

(SELECT * FROM t1) UNION (SELECT * FROM t2)

-- sqlfmt-corpus-separator --

(SELECT 1 FOR UPDATE) FOR UPDATE

-- sqlfmt-corpus-separator --

(SELECT NULL FROM t34524) EXCEPT (VALUES((SELECT 1 FROM t34524 LIMIT 1)), (1))

-- sqlfmt-corpus-separator --

(SELECT a FROM t1) UNION (SELECT b FROM t2)

-- sqlfmt-corpus-separator --

(SELECT j FROM t1) UNION (SELECT j FROM t2)

-- sqlfmt-corpus-separator --

(SELECT v FROM uniontest WHERE k = 1 UNION ALL SELECT v FROM uniontest WHERE k = 2) ORDER BY 1 DESC LIMIT 2

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

(SELECT x FROM xyz WHERE x < 2) EXCEPT (SELECT x FROM xyz WHERE x >= 2) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz WHERE x < 2) EXCEPT ALL (SELECT x FROM xyz WHERE x >= 2) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz WHERE x < 2) INTERSECT (SELECT x FROM xyz WHERE x >= 2) ORDER BY x

-- sqlfmt-corpus-separator --

(SELECT x FROM xyz WHERE x < 2) INTERSECT ALL (SELECT x FROM xyz WHERE x >= 2) ORDER BY x

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

(SELECT y FROM xyz WHERE x < 3) INTERSECT (SELECT y FROM xyz WHERE x >= 1) ORDER BY y

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz WHERE x < 3) INTERSECT ALL (SELECT y FROM xyz WHERE x >= 1) ORDER BY y

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz WHERE x >= 1) EXCEPT (SELECT y FROM xyz WHERE x < 3) ORDER BY y

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz WHERE x >= 1) EXCEPT ALL (SELECT y FROM xyz WHERE x < 3) ORDER BY y

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz) EXCEPT (SELECT x AS y FROM xyz) ORDER BY y

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz) EXCEPT ALL (SELECT x AS y FROM xyz) ORDER BY y

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz) INTERSECT (SELECT y FROM xyz) ORDER BY y

-- sqlfmt-corpus-separator --

(SELECT y FROM xyz) INTERSECT ALL (SELECT y FROM xyz) ORDER BY y

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
    count(*)
FROM
    pg_type AS t
WHERE
    t.typrelid = 0
    AND EXISTS(SELECT 1 FROM pg_type AS el WHERE el.oid = t.typelem AND el.typarray = t.oid)
    AND t.typname LIKE 'myt%';

-- sqlfmt-corpus-separator --

SELECT
    count(*)
FROM
    pg_type AS t
WHERE
    t.typrelid = 0
    AND NOT EXISTS(SELECT 1 FROM pg_type AS el WHERE el.oid = t.typelem AND el.typarray = t.oid)
    AND t.typname LIKE 'myt%';

-- sqlfmt-corpus-separator --

SELECT
    pk, pk2, a, b
FROM
    regional_by_row_table AS a
WHERE
    pk
    IN (SELECT pk FROM regional_by_row_table AS b LIMIT 3)

-- sqlfmt-corpus-separator --

SELECT
    tgname,
    (tgtype::INT & 1) > 0 AS is_row_level,
    (tgtype::INT & 2) > 0 AS is_before,
    (tgtype::INT & 4) > 0 AS has_insert,
    (tgtype::INT & 8) > 0 AS has_delete,
    (tgtype::INT & 16) > 0 AS has_update,
    (tgtype::INT & 32) > 0 AS has_instead,
    (tgtype::INT & 64) > 0 AS has_truncate
FROM pg_catalog.pg_trigger
WHERE tgrelid = 'test_triggers'::regclass
ORDER BY tgname;

-- sqlfmt-corpus-separator --

SELECT
  (a + b + a) * (a + 3 + 7) * (b + 11 + 17),
  mult(add(a, b, a), add(a, 3, 7), add(b, 11, 17))
FROM ab

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
  c_id,
  ARRAY(SELECT o_id FROM o WHERE o.c_id = c.c_id ORDER BY o_id)
FROM c ORDER BY c_id

-- sqlfmt-corpus-separator --

SELECT
  c_id,
  ARRAY(SELECT o_id FROM o WHERE o.c_id = c.c_id ORDER BY o_id),
  ARRAY(SELECT o_id FROM o WHERE o.ship = c.bill ORDER BY o_id)
FROM c ORDER BY c_id

-- sqlfmt-corpus-separator --

SELECT
  column_name, column_default
FROM
  information_schema.columns
WHERE
  table_name='enum_default' AND (column_name = 'y' OR column_name = 'z')
ORDER BY
  column_name

-- sqlfmt-corpus-separator --

SELECT
  column_name, default_expr
FROM
  crdb_internal.table_columns
WHERE
  descriptor_name='enum_default' AND (column_name = 'y' OR column_name = 'z')
ORDER BY
  column_name

-- sqlfmt-corpus-separator --

SELECT
  column_name, generation_expression
FROM
  information_schema.columns
WHERE
  table_name='enum_computed' AND (column_name = 'y' OR column_name = 'z')
ORDER BY
  column_name

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

SELECT
  percentile_cont(0.05) WITHIN GROUP (ORDER BY f),
  percentile_cont(0.05) WITHIN GROUP (ORDER BY f DESC),
  percentile_cont(0.05) WITHIN GROUP (ORDER BY i),
  percentile_cont(0.05) WITHIN GROUP (ORDER BY i DESC)
FROM osagg

-- sqlfmt-corpus-separator --

SELECT
  percentile_cont(0.25) WITHIN GROUP (ORDER BY f),
  percentile_cont(0.5) WITHIN GROUP (ORDER BY f),
  percentile_cont(0.75) WITHIN GROUP (ORDER BY f)
FROM osagg

-- sqlfmt-corpus-separator --

SELECT
  percentile_cont(0.95) WITHIN GROUP (ORDER BY f),
  percentile_cont(0.95) WITHIN GROUP (ORDER BY f DESC),
  percentile_cont(0.95) WITHIN GROUP (ORDER BY i)
FROM osagg

-- sqlfmt-corpus-separator --

SELECT
  percentile_disc(0.00) WITHIN GROUP (ORDER BY s),
  percentile_disc(0.1) WITHIN GROUP (ORDER BY f),
  percentile_disc(0.15) WITHIN GROUP (ORDER BY f)
FROM osagg

-- sqlfmt-corpus-separator --

SELECT
  percentile_disc(0.25) WITHIN GROUP (ORDER BY f),
  percentile_disc(0.5) WITHIN GROUP (ORDER BY f),
  percentile_disc(0.75) WITHIN GROUP (ORDER BY f)
FROM osagg

-- sqlfmt-corpus-separator --

SELECT
  percentile_disc(0.95) WITHIN GROUP (ORDER BY f)
FROM osagg

-- sqlfmt-corpus-separator --

SELECT
  percentile_disc(0.95) WITHIN GROUP (ORDER BY f),
  percentile_disc(0.95) WITHIN GROUP (ORDER BY s)
FROM osagg

-- sqlfmt-corpus-separator --

SELECT
(DATE '2000-01-01',
DATE '2000-01-02')
OVERLAPS
(DATE '2000-01-03',
DATE '2000-01-04');

-- sqlfmt-corpus-separator --

SELECT
(DATE '2000-01-01',
DATE '2000-01-03')
OVERLAPS
(DATE '2000-01-02',
DATE '2000-01-04');

-- sqlfmt-corpus-separator --

SELECT
(DATE '2000-01-01',
DATE '2000-01-03')
OVERLAPS
(DATE '2000-01-03',
DATE '2000-01-04');

-- sqlfmt-corpus-separator --

SELECT
(DATE '2000-01-01',
INTERVAL '1 day')
OVERLAPS
(DATE '2000-01-02',
INTERVAL '2 days');

-- sqlfmt-corpus-separator --

SELECT
(DATE '2000-01-01',
INTERVAL '2 days')
OVERLAPS
(DATE '2000-01-02',
INTERVAL '2 days');

-- sqlfmt-corpus-separator --

SELECT
(DATE '2000-01-01',
INTERVAL '3 hours')
OVERLAPS
(DATE '2000-01-02',
INTERVAL '2 days');

-- sqlfmt-corpus-separator --

SELECT
(DATE '2000-01-03',
DATE '2000-01-01')
OVERLAPS
(DATE '2000-01-02',
DATE '2000-01-04');

-- sqlfmt-corpus-separator --

SELECT
(DATE '2000-01-03',
DATE '2000-01-03')
OVERLAPS
(DATE '2000-01-03',
DATE '2000-01-04');

-- sqlfmt-corpus-separator --

SELECT
(TIME '2000-01-01 00:00:00',
INTERVAL '100 days')
OVERLAPS
(TIME '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT
(TIME '2000-01-01 00:00:00',
INTERVAL '100 s')
OVERLAPS
(TIME '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT
(TIME '2000-01-01 00:00:00',
INTERVAL '30 minutes')
OVERLAPS
(TIME '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT
(TIME '2000-01-01 00:00:00',
TIME '2000-01-01 00:15:00')
OVERLAPS
(TIME '2000-01-01 00:30:00',
TIME '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIME '2000-01-01 00:00:00',
TIME '2000-01-01 00:30:00')
OVERLAPS
(TIME '2000-01-01 00:30:00',
TIME '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIME '2000-01-01 00:00:00',
TIME '2000-01-01 01:00:00')
OVERLAPS
(TIME '2000-01-01 00:30:00',
TIME '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIME '2000-01-01 00:30:00',
TIME '2000-01-01 00:30:00')
OVERLAPS
(TIME '2000-01-01 00:30:00',
TIME '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIME '2000-01-01 01:00:00',
TIME '2000-01-01 00:00:00')
OVERLAPS
(TIME '2000-01-01 00:30:00',
TIME '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMP '2000-01-01 00:00:00',
INTERVAL '100 days')
OVERLAPS
(TIMESTAMP '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMP '2000-01-01 00:00:00',
INTERVAL '100 s')
OVERLAPS
(TIMESTAMP '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMP '2000-01-01 00:00:00',
INTERVAL '30 minutes')
OVERLAPS
(TIMESTAMP '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMP '2000-01-01 00:00:00',
TIME '2000-01-01 01:00:00')
OVERLAPS
(TIME '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMP '2000-01-01 00:00:00',
TIMESTAMP '2000-01-01 00:15:00')
OVERLAPS
(TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMP '2000-01-01 00:00:00',
TIMESTAMP '2000-01-01 00:30:00')
OVERLAPS
(TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMP '2000-01-01 00:00:00',
TIMESTAMP '2000-01-01 01:00:00')
OVERLAPS
(TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 00:30:00')
OVERLAPS
(TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMP '2000-01-01 01:00:00',
TIMESTAMP '2000-01-01 00:00:00')
OVERLAPS
(TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMPTZ '2000-01-01 00:00:00',
INTERVAL '100 days')
OVERLAPS
(TIMESTAMPTZ '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMPTZ '2000-01-01 00:00:00',
INTERVAL '100 s')
OVERLAPS
(TIMESTAMPTZ '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMPTZ '2000-01-01 00:00:00',
INTERVAL '30 minutes')
OVERLAPS
(TIMESTAMPTZ '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMPTZ '2000-01-01 00:00:00',
TIMESTAMPTZ '2000-01-01 00:15:00')
OVERLAPS
(TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMPTZ '2000-01-01 00:00:00',
TIMESTAMPTZ '2000-01-01 00:30:00')
OVERLAPS
(TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMPTZ '2000-01-01 00:00:00',
TIMESTAMPTZ '2000-01-01 01:00:00')
OVERLAPS
(TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 00:30:00')
OVERLAPS
(TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMESTAMPTZ '2000-01-01 01:00:00',
TIMESTAMPTZ '2000-01-01 00:00:00')
OVERLAPS
(TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMETZ '00:00:00',
INTERVAL '100 s')
OVERLAPS
(TIMETZ '00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT
(TIMETZ '00:00:00',
INTERVAL '3 hours')
OVERLAPS
(TIMETZ '00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT
(TIMETZ '00:00:00',
INTERVAL '30 minutes')
OVERLAPS
(TIMETZ '00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT
(TIMETZ '2000-01-01 00:00:00',
TIMETZ '2000-01-01 00:15:00')
OVERLAPS
(TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMETZ '2000-01-01 00:00:00',
TIMETZ '2000-01-01 00:30:00')
OVERLAPS
(TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMETZ '2000-01-01 00:00:00',
TIMETZ '2000-01-01 01:00:00')
OVERLAPS
(TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 00:30:00')
OVERLAPS
(TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT
(TIMETZ '2000-01-01 01:00:00',
TIMETZ '2000-01-01 00:00:00')
OVERLAPS
(TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT "LOWERCASE_HINT_ERROR_IMPLICIT_SCHEMA_FN"();

-- sqlfmt-corpus-separator --

SELECT "PG_TYPEOF"(123)

-- sqlfmt-corpus-separator --

SELECT "reportingID", "eventType", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
  FROM system.eventlog
 WHERE ("eventType" = 'alter_type' OR "eventType" = 'rename_type') AND info::JSONB->>'TypeName' LIKE '%eventlog%'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", "info"::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' - 'ApplicationName'
FROM system.eventlog
WHERE "eventType" = 'create_statistics' AND ("info"::JSONB ->> 'DescriptorID')::INT = 106
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT ' 1 '::int, ' 1.2 '::float, ' 2.3 '::decimal, ' true '::bool

-- sqlfmt-corpus-separator --

SELECT '$'::JSONPATH IS DISTINCT FROM '$'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT '$'::JSONPATH IS DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT '$'::JSONPATH IS NOT DISTINCT FROM '$'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT '$'::JSONPATH IS NOT DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT '%A' LIKE '%%A' ESCAPE '%'

-- sqlfmt-corpus-separator --

SELECT '%A' LIKE '%A' ESCAPE '%'

-- sqlfmt-corpus-separator --

SELECT '%A' LIKE '_A' ESCAPE '%'

-- sqlfmt-corpus-separator --

SELECT '%A' SIMILAR TO '%A' ESCAPE '%'

-- sqlfmt-corpus-separator --

SELECT '%A' SIMILAR TO '_A' ESCAPE '%'

-- sqlfmt-corpus-separator --

SELECT ''::VOID IS DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT ''::VOID IS DISTINCT FROM NULL::UNKNOWN

-- sqlfmt-corpus-separator --

SELECT '1'::REFCURSOR::INT;

-- sqlfmt-corpus-separator --

SELECT '1.0'::REFCURSOR::FLOAT;

-- sqlfmt-corpus-separator --

SELECT '123A_' SIMILAR TO '%A_' ESCAPE '_'

-- sqlfmt-corpus-separator --

SELECT '123A_' SIMILAR TO '%A__' ESCAPE '_'

-- sqlfmt-corpus-separator --

SELECT 'A' LIKE 'AA' ESCAPE 'AA'

-- sqlfmt-corpus-separator --

SELECT 'A' LIKE '\A' ESCAPE ''

-- sqlfmt-corpus-separator --

SELECT 'A' LIKE '\A' ESCAPE '\'

-- sqlfmt-corpus-separator --

SELECT 'A' SIMILAR TO 'AA' ESCAPE 'AA'

-- sqlfmt-corpus-separator --

SELECT 'A' SIMILAR TO '\A' ESCAPE '\'

-- sqlfmt-corpus-separator --

SELECT 'HELLO'::d.t;

-- sqlfmt-corpus-separator --

SELECT 'HELLO'::d1.t;

-- sqlfmt-corpus-separator --

SELECT 'HELLO'::sc.t;

-- sqlfmt-corpus-separator --

SELECT 'HELLO'::sc1.t;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::FLOAT::DECIMAL, 'NaN'::DECIMAL

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

SELECT 'Z'::int

-- sqlfmt-corpus-separator --

SELECT 'Z'::public.int

-- sqlfmt-corpus-separator --

SELECT '\A' SIMILAR TO '\A' ESCAPE ''

-- sqlfmt-corpus-separator --

SELECT 'a'::"char" FROM t47131_0

-- sqlfmt-corpus-separator --

SELECT 'a'::CHAR::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 'a'::INTERVAL(123)

-- sqlfmt-corpus-separator --

SELECT 'a'::REFCURSOR::CHAR;

-- sqlfmt-corpus-separator --

SELECT 'a'::REGTYPE, 'a'::REGTYPE::INT = 'a'::REGCLASS::INT + 100000

-- sqlfmt-corpus-separator --

SELECT 'a'::db1.sc1.typ::string

-- sqlfmt-corpus-separator --

SELECT 'ap-southeast-2'::multi_region_test_db.public.crdb_internal_region

-- sqlfmt-corpus-separator --

SELECT 'ap-southeast-2'::region_test_db.public.crdb_internal_region

-- sqlfmt-corpus-separator --

SELECT 'ca-central-1'::multi_region_test_db.public.crdb_internal_region

-- sqlfmt-corpus-separator --

SELECT 'ca-central-1'::region_test_db.public.crdb_internal_region

-- sqlfmt-corpus-separator --

SELECT 'foo'::CHAR = 'f  '

-- sqlfmt-corpus-separator --

SELECT 'foo'::CHAR = 'foo  '

-- sqlfmt-corpus-separator --

SELECT 'foo'::CHAR = 'foo'

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

SELECT 'hello' SIMILAR TO v FROM kvString WHERE k SIMILAR TO 'like[1-2]' ORDER BY k

-- sqlfmt-corpus-separator --

SELECT 'hello'::pg_catalog.greeting

-- sqlfmt-corpus-separator --

SELECT 'hello'::public.greeting

-- sqlfmt-corpus-separator --

SELECT 'hello'::public.typ

-- sqlfmt-corpus-separator --

SELECT 'hello'::s1.typ

-- sqlfmt-corpus-separator --

SELECT 'hello'::s1.typ2

-- sqlfmt-corpus-separator --

SELECT 'hello'::s1.typ3

-- sqlfmt-corpus-separator --

SELECT 'hello'::s1.typ4

-- sqlfmt-corpus-separator --

SELECT 'hello'::s2.typ2

-- sqlfmt-corpus-separator --

SELECT 'hello'::s2.typ3

-- sqlfmt-corpus-separator --

SELECT 'hello'::s2.typ4

-- sqlfmt-corpus-separator --

SELECT 'not test' = ANY (current_schemas(true))

-- sqlfmt-corpus-separator --

SELECT 'pg_constraint '::REGCLASS, ('"pg_constraint"'::REGCLASS::OID::INT-'"pg_constraint"'::REGCLASS::OID::INT)::OID

-- sqlfmt-corpus-separator --

SELECT 'public' = ANY (current_schemas(true))

-- sqlfmt-corpus-separator --

SELECT 'sc.proc_f_2'::REGPROC::INT;

-- sqlfmt-corpus-separator --

SELECT 'trigger'::REGTYPE::INT

-- sqlfmt-corpus-separator --

SELECT 'usage'::privs.usage_typ

-- sqlfmt-corpus-separator --

SELECT 'value'::"Another-Schema"."MyType"

-- sqlfmt-corpus-separator --

SELECT 'value'::"MixedCase"."MyType"

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL AS t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", t1.a, t2.e FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e) WHERE t1.a = t2.d

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> null::int;

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> null::int;

-- sqlfmt-corpus-separator --

SELECT '{-Infinity}'::real[]::vector

-- sqlfmt-corpus-separator --

SELECT '{1,2,3}'::INT[]

-- sqlfmt-corpus-separator --

SELECT '{4e38,-4e38}'::double precision[]::vector

-- sqlfmt-corpus-separator --

SELECT '{Infinity}'::real[]::vector

-- sqlfmt-corpus-separator --

SELECT '{NaN}'::real[]::vector

-- sqlfmt-corpus-separator --

SELECT '{}'::real[]::vector

-- sqlfmt-corpus-separator --

SELECT '春A' LIKE '春春_' ESCAPE '春'

-- sqlfmt-corpus-separator --

SELECT '春A' LIKE '春春_' ESCAPE '春春'

-- sqlfmt-corpus-separator --

SELECT '春A' SIMILAR TO '春春_' ESCAPE '春'

-- sqlfmt-corpus-separator --

SELECT '春A' SIMILAR TO '春春_' ESCAPE '春春'

-- sqlfmt-corpus-separator --

SELECT '春A_春春' SIMILAR TO '%_春_%' ESCAPE '春'

-- sqlfmt-corpus-separator --

SELECT (
  SELECT count(t2.rowid) FROM t105882 t2
  WHERE ((t1.rowid) IN (SELECT max(t3.rowid) FROM t105882 t3))
)
FROM t105882 t1;

-- sqlfmt-corpus-separator --

SELECT ('4714-11-24 BC'::date + 1)::string, ('5874897-12-31'::date - 1)::string

-- sqlfmt-corpus-separator --

SELECT ('pg_constraint')::REGCLASS, (('pg_constraint')::REGCLASS::OID::INT-('pg_constraint')::REGCLASS::OID::INT)::OID

-- sqlfmt-corpus-separator --

SELECT ((-1.234E+401)::DECIMAL * '-53 years -10 mons -377 days -08:33:40.519057'::INTERVAL::INTERVAL)::INTERVAL FROM many_types

-- sqlfmt-corpus-separator --

SELECT (-1)::myschema.d_schema

-- sqlfmt-corpus-separator --

SELECT (-1/3.0)::float4::text, (1/3.0)::float8::text

-- sqlfmt-corpus-separator --

SELECT (-129)::"char";

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

SELECT (1/3.0)::float4::text, (-1/3.0)::float8::text

-- sqlfmt-corpus-separator --

SELECT (1::INT2, NULL)
UNION
SELECT (1::INT, NULL)

-- sqlfmt-corpus-separator --

SELECT (2, 2) IN (SELECT x+1, y+1 FROM xy)

-- sqlfmt-corpus-separator --

SELECT (DATE '2000-01-01', INTERVAL '1 day') overlaps (NULL, NULL);

-- sqlfmt-corpus-separator --

SELECT (DATE '2000-01-01', NULL) overlaps (DATE '2000-01-01', DATE '2000-01-02');

-- sqlfmt-corpus-separator --

SELECT (NULL, INTERVAL '1 day') overlaps (NULL, NULL);

-- sqlfmt-corpus-separator --

SELECT (NULL, NULL) overlaps (NULL, NULL);

-- sqlfmt-corpus-separator --

SELECT (SELECT (1, 2)) IN (SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT (SELECT (2, 2), (3, 3)) IN (SELECT x+1, y+1 FROM xy)

-- sqlfmt-corpus-separator --

SELECT (SELECT 1 FOR UPDATE) FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT (SELECT 1) IN (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT (SELECT 1, 2) IN (SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT (SELECT 123 AS a),
       (VALUES (cos(1)::INT)),
       (SELECT cos(0)::INT)

-- sqlfmt-corpus-separator --

SELECT (SELECT 123 IN (VALUES (1), (2)))

-- sqlfmt-corpus-separator --

SELECT (SELECT 2, 2) IN (SELECT x+1 FROM xy)

-- sqlfmt-corpus-separator --

SELECT (SELECT 2, 2) IN (SELECT x+1, y+1 FROM xy)

-- sqlfmt-corpus-separator --

SELECT (SELECT 2, 2) IN (SELECT x+1, y+1, x+y FROM xy)

-- sqlfmt-corpus-separator --

SELECT (VALUES (1)) FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT (WITH foo AS (INSERT INTO y VALUES (1) RETURNING *) SELECT * FROM foo)

-- sqlfmt-corpus-separator --

SELECT (a * (a + b)) - b, sub(mult(a, add(a, b)), b) FROM ab

-- sqlfmt-corpus-separator --

SELECT (a + 1.0::DECIMAL)::INT FROM a LIMIT 1

-- sqlfmt-corpus-separator --

SELECT (a + b)::INT FROM intdecfloat

-- sqlfmt-corpus-separator --

SELECT (array_agg(i ORDER BY pk))::string FROM intervals

-- sqlfmt-corpus-separator --

SELECT (count(1) = 0) AS PASSED
FROM pg_shadow
WHERE EXISTS (
  SELECT 1 FROM pg_authid WHERE oid = usesysid AND NOT rolcanlogin
)

-- sqlfmt-corpus-separator --

SELECT (crdb_internal.pb_to_json('desc', descriptor)->'table'->>'version')::INT8
  FROM system.descriptor
 WHERE id = 'db.t'::regclass;

-- sqlfmt-corpus-separator --

SELECT (oid::int-oid::int)::oid, oid::regclass, (oid::regclass::int-oid::regclass::int), oid::regclass::int::regclass, oid::regclass::text
FROM pg_class
WHERE relname = 'pg_constraint'

-- sqlfmt-corpus-separator --

SELECT (rank() OVER wind + lead(k, 3, v) OVER wind + lag(w, 1, 2) OVER wind), (row_number() OVER wind + dense_rank() OVER wind) FROM kv WINDOW wind as (PARTITION BY v ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT (round(avg(k) OVER w1 + sum(w) OVER w2) + row_number() OVER w2 + d + min(d) OVER w3 + f::DECIMAL) AS big_sum, v + w AS v_plus_w, (rank() OVER w3 + first_value(d) OVER w1 + nth_value(k, 2) OVER w1) AS small_sum FROM kv WINDOW w1 AS (PARTITION BY b ORDER BY k), w2 AS (PARTITION BY w ORDER BY k), w3 AS (PARTITION BY v ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT (x / 1)::DECIMAL FROM t86790

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

SELECT *
FROM documents
WHERE '3ae3560e-d771-4b63-affb-47e8d7853680'::UUID = ANY (documents.shared_users);

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

SELECT * FROM a UNION ALL SELECT * FROM b

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

SELECT * FROM a WHERE EXISTS (SELECT * FROM b WHERE a1 = b1 OR a2 = b2 OR a3 = b3 OR a4 = b4)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE EXISTS (SELECT * FROM c WHERE a1 = c1 OR a2 = c2 OR a3 = c3 OR a4 = c4)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE EXISTS (SELECT * FROM c WHERE a1 = c2 OR a2 = c1 OR a3 = c4 OR a3 = c4)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE EXISTS (SELECT 1 FROM c, d WHERE c1 = d2 or c2 = d1)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE EXISTS (SELECT 1 FROM c, d WHERE d1 = 4 OR c2 = 50 HAVING sum(d4) > 40)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE EXISTS (SELECT 1 FROM d WHERE d1 = 4 OR d2 = 50)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE NOT EXISTS (SELECT * FROM b WHERE a1 = b1 OR a2 = b2 OR a3 = b3 OR a4 = b4)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE NOT EXISTS (SELECT * FROM c WHERE a1 = c1 OR a2 = c2 OR a3 = c3 OR a4 = c4)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE NOT EXISTS (SELECT * FROM c WHERE a1 = c2 OR a2 = c1 OR a3 = c4 OR a3 = c4)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE NOT EXISTS (SELECT 1 FROM b WHERE b1 = 4 OR b2 = 50)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE NOT EXISTS (SELECT 1 FROM c, d WHERE c3 = d4 or c4 = d3)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE NOT EXISTS (SELECT 1 FROM c, d WHERE d1 = 4 OR c2 = 50 or d2+c3 > 5)

-- sqlfmt-corpus-separator --

SELECT * FROM a t1, a t2 WHERE (t1.a2 = t2.a2 OR t1.a3 = t2.a3) AND (t1.a1 = t2.a1 OR t1.a4 = t2.a4)

-- sqlfmt-corpus-separator --

SELECT * FROM a, b WHERE (a2 = b2 OR a3 = b3) AND (a1 = b1 OR a4 = b4)

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

SELECT * FROM abc WHERE EXISTS (SELECT * FROM xyz WHERE (abc.a = xyz.x OR abc.b = xyz.y) AND (abc.a = xyz.y OR abc.b = xyz.y))

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE EXISTS (SELECT * FROM xyz WHERE (abc.a = xyz.x OR abc.b = xyz.y)and abc.a > 3 AND xyz.z > 10)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE EXISTS (SELECT * FROM xyz WHERE (abc.a = xyz.y OR abc.b = xyz.x) AND abc.a > 3 AND xyz.z > 10)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE EXISTS (SELECT * FROM xyz WHERE abc.a = xyz.x OR abc.b = xyz.y)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE EXISTS (SELECT * FROM xyz WHERE abc.a = xyz.y OR abc.b = xyz.x)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE NOT EXISTS (SELECT * FROM xyz WHERE (abc.a = xyz.x OR abc.b = xyz.y) AND (abc.a = xyz.y OR abc.b = xyz.y))

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE NOT EXISTS (SELECT * FROM xyz WHERE (abc.a = xyz.x OR abc.b = xyz.y)and abc.a > 3 AND xyz.z > 10)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE NOT EXISTS (SELECT * FROM xyz WHERE (abc.a = xyz.y OR abc.b = xyz.x) AND abc.a > 3 AND xyz.z > 10)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE NOT EXISTS (SELECT * FROM xyz WHERE abc.a = xyz.x OR abc.b = xyz.y)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE NOT EXISTS (SELECT * FROM xyz WHERE abc.a = xyz.y OR abc.b = xyz.x)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a != 3 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a < ALL(SELECT a FROM abc WHERE a >= 2)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a < ALL(SELECT a FROM abc)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a < ANY(SELECT a FROM abc WHERE b = 30) ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = 6 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = ANY(SELECT a FROM abc WHERE b = 10)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a > ANY(SELECT a FROM abc WHERE b = 30)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE b = 7 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM b, d WHERE (b1 = 0 OR b1 = d1)   AND
                         (b1 = 0 OR b2 = 5)    AND
                         (b2 = d1 OR b1 = d1)  AND
                         (b2 = d1 OR b2 = 5)

-- sqlfmt-corpus-separator --

SELECT * FROM bcd ORDER BY c DESC LIMIT 2 FOR SHARE

-- sqlfmt-corpus-separator --

SELECT * FROM bcd WHERE b = 7 FOR UPDATE

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

SELECT * FROM child WHERE NOT EXISTS (SELECT * FROM parent WHERE p_id = c_p_id) AND c_id = 10

-- sqlfmt-corpus-separator --

SELECT * FROM cnt FOR SHARE;

-- sqlfmt-corpus-separator --

SELECT * FROM cnt FOR UPDATE;

-- sqlfmt-corpus-separator --

SELECT * FROM comp WHERE v IN (SELECT v FROM comp);

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.create_type_statements WHERE descriptor_id = (('enum1'::regtype::oid::int) - 100000)::oid

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.create_type_statements WHERE descriptor_id = (('other_db.public.enum1'::regtype::int) - 100000)

-- sqlfmt-corpus-separator --

SELECT * FROM f_insert_select(5,6) AS t1(a INT, b INT) UNION ALL SELECT * FROM f_insert_select(7,8) AS t2(a INT, b INT)

-- sqlfmt-corpus-separator --

SELECT * FROM foo FOR SHARE OF foo SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * FROM foo FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM foo ORDER BY x LIMIT 1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM foo WHERE x = 2 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.role_routine_grants
WHERE reverse(split_part(reverse(specific_name), '_', 1))::INT < 50
ORDER BY specific_name, grantee;

-- sqlfmt-corpus-separator --

SELECT * FROM int WHERE a IS DISTINCT FROM 2

-- sqlfmt-corpus-separator --

SELECT * FROM int WHERE a IS NOT DISTINCT FROM 2

-- sqlfmt-corpus-separator --

SELECT * FROM json_tab
WHERE (b @> '[1]'::json OR b @> '[2]'::json) AND (b @> '3'::json OR b @> '"bar"'::json)
ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM kv FOR SHARE

-- sqlfmt-corpus-separator --

SELECT * FROM kv FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE (k,v) IN (SELECT * FROM kv)

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE k = 5 FOR UPDATE;

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE k IN (SELECT k FROM kv)

-- sqlfmt-corpus-separator --

SELECT * FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY avg(k) OVER w DESC, k

-- sqlfmt-corpus-separator --

SELECT * FROM l WHERE EXISTS(SELECT * FROM r WHERE r.a=l.a)

-- sqlfmt-corpus-separator --

SELECT * FROM messages_rbr UNION ALL SELECT * FROM messages_rbt

-- sqlfmt-corpus-separator --

SELECT * FROM parent_151663 WHERE p = 3 FOR UPDATE

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

SELECT * FROM t  WHERE a = 1 FOR SHARE;

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR KEY SHARE

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR NO KEY UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR SHARE

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR SHARE FOR UPDATE OF t NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR SHARE NOWAIT FOR UPDATE OF t

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR SHARE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE EXISTS(SELECT * FROM xy WHERE x=t.k)

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE a = 1 FOR SHARE;

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE a = 2 FOR SHARE

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE k = 'a' FOR SHARE;

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE k = 'a' FOR UPDATE;

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE k = 1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE k = 1 FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE k = 2 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE k = 2 FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE v = 9 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE v = 9 FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM t0 WHERE t0.c0 AND (c1 OR (c0 > false AND c0 < false))

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

SELECT * FROM t130661 WHERE id = 1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM t146637 WHERE (a = 0 OR a = 100) AND b = 'foo' ORDER BY a DESC LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT * FROM t2 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM t3 WHERE u = 2 FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * FROM t3 WHERE u = 2 LIMIT 1 FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * FROM t44797_2 WHERE EXISTS (SELECT * FROM t44797_2 AS l, t44797_3 AS r WHERE l.a = r.b)

-- sqlfmt-corpus-separator --

SELECT * FROM t51474 INTERSECT ALL SELECT * FROM t51474

-- sqlfmt-corpus-separator --

SELECT * FROM t73450 WHERE c = 'foo'::CHAR

-- sqlfmt-corpus-separator --

SELECT * FROM t94290 WHERE b = 2 FOR UPDATE;

-- sqlfmt-corpus-separator --

SELECT * FROM v WHERE y = ARRAY(SELECT x FROM u ORDER BY x);

-- sqlfmt-corpus-separator --

SELECT * FROM x WHERE a IN
  (WITH t AS (SELECT * FROM y WHERE a < 3) SELECT * FROM t)

-- sqlfmt-corpus-separator --

SELECT * FROM xyz WHERE x = (SELECT max(x) FROM xyz WHERE EXISTS(SELECT * FROM xyz WHERE z=x+3))

-- sqlfmt-corpus-separator --

SELECT * FROM xyz WHERE x = 1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM xyz WHERE x IN (SELECT crdb_internal.force_error('', 'subqueryfail'))

-- sqlfmt-corpus-separator --

SELECT * FROM xyz WHERE z = 100 ORDER BY x FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM xyz WHERE z = 100 ORDER BY x FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT (random() * 0.0)::int OFFSET (random() * 0.0)::int

-- sqlfmt-corpus-separator --

SELECT * from abc WHERE EXISTS (SELECT * FROM def WHERE a=d AND c=e)

-- sqlfmt-corpus-separator --

SELECT * from abc WHERE EXISTS (SELECT * FROM def WHERE a=d)

-- sqlfmt-corpus-separator --

SELECT * from abc WHERE EXISTS (SELECT * FROM def WHERE a=f AND c=e)

-- sqlfmt-corpus-separator --

SELECT * from abc WHERE EXISTS (SELECT * FROM def WHERE a=f AND d+b>1)

-- sqlfmt-corpus-separator --

SELECT * from abc WHERE EXISTS (SELECT * FROM def WHERE a=f)

-- sqlfmt-corpus-separator --

SELECT * from abc WHERE NOT EXISTS (SELECT * FROM def WHERE a=f AND c=e)

-- sqlfmt-corpus-separator --

SELECT * from abc WHERE NOT EXISTS (SELECT * FROM def WHERE a=f AND d+b>1)

-- sqlfmt-corpus-separator --

SELECT * from abc WHERE NOT EXISTS (SELECT * FROM def WHERE a=f)

-- sqlfmt-corpus-separator --

SELECT * from t7 FOR UPDATE SKIP LOCKED;

-- sqlfmt-corpus-separator --

SELECT *, avg(k) OVER (w ORDER BY w) FROM kv WINDOW w AS (PARTITION BY v) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT *, avg(k) OVER w FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY avg(k) OVER w, k

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

SELECT 1 << 63 >> 63, 1::INT << 63 >> 63

-- sqlfmt-corpus-separator --

SELECT 1 = ALL(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 = ANY(NULL::INT[])

-- sqlfmt-corpus-separator --

SELECT 1 = ANY(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 = SOME(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 FOR KEY SHARE

-- sqlfmt-corpus-separator --

SELECT 1 FOR KEY SHARE NOWAIT

-- sqlfmt-corpus-separator --

SELECT 1 FOR KEY SHARE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT 1 FOR NO KEY UPDATE

-- sqlfmt-corpus-separator --

SELECT 1 FOR NO KEY UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT 1 FOR NO KEY UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT 1 FOR SHARE

-- sqlfmt-corpus-separator --

SELECT 1 FOR SHARE NOWAIT

-- sqlfmt-corpus-separator --

SELECT 1 FOR SHARE OF a, b

-- sqlfmt-corpus-separator --

SELECT 1 FOR SHARE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT 1 FOR UPDATE FOR SHARE FOR NO KEY UPDATE FOR KEY SHARE

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

SELECT 1 GROUP BY 1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT 1 HAVING TRUE FOR UPDATE

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

SELECT 1 UNION SELECT 1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT 1 UNION SELECT 3 ORDER BY z

-- sqlfmt-corpus-separator --

SELECT 1 WHERE 1 > ALL (SELECT max(account_id) FROM messages_rbr)

-- sqlfmt-corpus-separator --

SELECT 1 WHERE 1 > ANY (SELECT max(account_id) FROM messages_rbr)

-- sqlfmt-corpus-separator --

SELECT 1 in (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1, 2 EXCEPT SELECT 3

-- sqlfmt-corpus-separator --

SELECT 1, 2 INTERSECT SELECT 3

-- sqlfmt-corpus-separator --

SELECT 1, 2 UNION SELECT 3

-- sqlfmt-corpus-separator --

SELECT 1.0::FLOAT::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 1.234567890123456789::float, round(1.234567890123456789::float, 15), round(1.234567890123456789::float, 16), round(1.234567890123456789::float, 17)

-- sqlfmt-corpus-separator --

SELECT 100117::regproc::INT;

-- sqlfmt-corpus-separator --

SELECT 128::"char";

-- sqlfmt-corpus-separator --

SELECT 1::INT::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 1::crdb_internal.mytype

-- sqlfmt-corpus-separator --

SELECT 1::pg_catalog.int4, 1::pg_catalog.int8, 'aa'::pg_catalog.text, 4.2::pg_catalog.float4

-- sqlfmt-corpus-separator --

SELECT 1::pg_catalog.special_int

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

SELECT 4 || NULL::INT[]

-- sqlfmt-corpus-separator --

SELECT 5::myschema.d_schema

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT 1) FROM a LIMIT 1

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT 3 WHERE false)

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT 3 WHERE false) FROM k

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT 3)

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT a FROM ab ORDER BY b)

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT generate_series(1,10) ORDER BY 1 DESC)

-- sqlfmt-corpus-separator --

SELECT ARRAY(SELECT x FROM z ORDER BY y)

-- sqlfmt-corpus-separator --

SELECT ARRAY(VALUES ('a'),('b'),('c'))

-- sqlfmt-corpus-separator --

SELECT ARRAY(VALUES (1),(2),(1))

-- sqlfmt-corpus-separator --

SELECT ARRAY(VALUES (ARRAY[1]))

-- sqlfmt-corpus-separator --

SELECT CAST(corr(DISTINCT y, x) FILTER (WHERE x > 3 AND y < 30) AS decimal)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT CAST(covar_pop(DISTINCT y, x) FILTER (WHERE x > 3 AND y < 100) AS decimal)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT CAST(covar_samp(DISTINCT y, x) FILTER (WHERE x > 3 AND y < 100) AS decimal)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT CAST(regr_avgx(DISTINCT y, x) FILTER (WHERE x > 3 AND y < 30) AS decimal)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT CAST(regr_avgy(DISTINCT y, x) FILTER (WHERE x > 3 AND y < 100) AS decimal)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT CAST(regr_intercept(DISTINCT y, x) FILTER (WHERE x > 3 AND y < 100) AS decimal)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT CAST(regr_r2(DISTINCT y, x) FILTER (WHERE x > 3 AND y < 100) AS decimal)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT CAST(regr_slope(DISTINCT y, x) FILTER (WHERE x > 3 AND y < 100) AS decimal)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT CAST(regr_sxx(DISTINCT y, x) FILTER (WHERE x > 3 AND y < 100) AS decimal)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT CAST(regr_sxy(DISTINCT y, x) FILTER (WHERE x > 3 AND y < 100) AS decimal)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT CAST(regr_syy(DISTINCT y, x) FILTER (WHERE x > 3 AND y < 100) AS decimal)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT COLLATION FOR ('foo')

-- sqlfmt-corpus-separator --

SELECT COLLATION FOR (1);

-- sqlfmt-corpus-separator --

SELECT DISTINCT (a) FROM data

-- sqlfmt-corpus-separator --

SELECT DISTINCT (x) FROM t

-- sqlfmt-corpus-separator --

SELECT DISTINCT * FROM t44079

-- sqlfmt-corpus-separator --

SELECT DISTINCT 1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(((x)), (x, y)) x, y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz ORDER BY row_number() OVER(ORDER BY (pk1, pk2)) DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT _int FROM t88110 WHERE NOT _bool;

-- sqlfmt-corpus-separator --

SELECT DISTINCT a, b FROM data WHERE (a + b + c::INT) = 27 ORDER BY a,b

-- sqlfmt-corpus-separator --

SELECT DISTINCT a, b FROM data WHERE (a + b + c::INT) = 27 ORDER BY b,a

-- sqlfmt-corpus-separator --

SELECT DISTINCT authors.name FROM books AS b1, books2 as b2, authors WHERE b1.title = b2.title AND authors.book = b1.title AND b1.shelf <> b2.shelf

-- sqlfmt-corpus-separator --

SELECT DISTINCT c, b FROM t ORDER BY b DESC LIMIT 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT classid, refclassid FROM pg_shdepend
WHERE classid != 0
LIMIT 5

-- sqlfmt-corpus-separator --

SELECT DISTINCT s FROM t1

-- sqlfmt-corpus-separator --

SELECT DISTINCT s FROM t2

-- sqlfmt-corpus-separator --

SELECT DISTINCT tableoid FROM pg_attribute LIMIT 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT tableoid FROM pg_class LIMIT 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT tableoid FROM pg_index LIMIT 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT tableoid FROM pg_namespace LIMIT 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT tableoid FROM pg_proc LIMIT 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT tableoid FROM pg_type LIMIT 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT v FROM kv

-- sqlfmt-corpus-separator --

SELECT DISTINCT x FROM t2

-- sqlfmt-corpus-separator --

SELECT DISTINCT x FROM t2 ORDER BY x DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT y + z FROM xyz ORDER by (y + z)

-- sqlfmt-corpus-separator --

SELECT DISTINCT y AS w FROM xyz ORDER by y

-- sqlfmt-corpus-separator --

SELECT DISTINCT y AS w, z FROM xyz ORDER by z, w

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, z FROM xyz ORDER BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, z FROM xyz ORDER BY y, z

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, z FROM xyz ORDER BY z

-- sqlfmt-corpus-separator --

SELECT DISTINCT y,z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT(a), b FROM a ORDER BY 1, 2 LIMIT 10

-- sqlfmt-corpus-separator --

SELECT EXISTS(SELECT * FROM kv WHERE k > 2)

-- sqlfmt-corpus-separator --

SELECT EXISTS(SELECT * FROM t)

-- sqlfmt-corpus-separator --

SELECT EXISTS(SELECT 1 FROM kv AS x WHERE x.k = 1)

-- sqlfmt-corpus-separator --

SELECT EXISTS(SELECT 1 FROM kv WHERE k = 2)

-- sqlfmt-corpus-separator --

SELECT EXTRACT(YEAR FROM x) FROM extract_test

-- sqlfmt-corpus-separator --

SELECT IF(false, 'foo'::CHAR, 'bar'::CHAR(2))

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

SELECT NULL
FROM t89601 t1, t89601 t2
WHERE EXISTS(
  SELECT NULL
  FROM t89601 t3, t89601 t4
  WHERE t3.i IN (
     WITH w AS (SELECT NULL)
     SELECT t4.i::INT8 FROM w
  )
)

-- sqlfmt-corpus-separator --

SELECT NULL = ALL(NULL::INTEGER[]);

-- sqlfmt-corpus-separator --

SELECT NULL = ANY(NULL::INTEGER[]);

-- sqlfmt-corpus-separator --

SELECT NULL = SOME(NULL::INTEGER[]);

-- sqlfmt-corpus-separator --

SELECT NULL::INT || NULL::INT[], NULL::INT[] || NULL::INT

-- sqlfmt-corpus-separator --

SELECT NULL::INT[]

-- sqlfmt-corpus-separator --

SELECT NULL::INT[] || 4

-- sqlfmt-corpus-separator --

SELECT NULL::INT[] || NULL::INT

-- sqlfmt-corpus-separator --

SELECT NULL::INT[] || NULL::INT[]

-- sqlfmt-corpus-separator --

SELECT NULLIF('foo'::REFCURSOR, 'bar'::REFCURSOR);

-- sqlfmt-corpus-separator --

SELECT NULLIF('foo'::REFCURSOR, NULL);

-- sqlfmt-corpus-separator --

SELECT NULLIF(1, 2), NULLIF(2, 2), NULLIF(NULL, NULL)

-- sqlfmt-corpus-separator --

SELECT NULLIF(generate_series(1, x), generate_series(1, 3)) from xy;

-- sqlfmt-corpus-separator --

SELECT OVERLAY(nonexistent.* PLACING 'string' FROM 'string')

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_Collect(geom ORDER BY geom)) FROM geo_table

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_MakeLine(geom ORDER BY geom)) FROM geo_table

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_MemCollect(geom ORDER BY geom)) FROM geo_table

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP '2001-02-16 20:38:40' AT TIME ZONE 'MST', timezone('MST', TIMESTAMP '2001-02-16 20:38:40')

-- sqlfmt-corpus-separator --

SELECT TIMESTAMP WITH TIME ZONE '2001-02-16 20:38:40-05' AT TIME ZONE 'MST', timezone('MST', TIMESTAMP WITH TIME ZONE '2001-02-16 20:38:40-05')

-- sqlfmt-corpus-separator --

SELECT VARCHAR(4) 'foo', CHAR(2) 'bar', STRING(1) 'cat'

-- sqlfmt-corpus-separator --

SELECT a * (3 + b - a) + a * b * a, add(mult(a, add(3, sub(b, a))), mult(a, mult(b, a))) FROM ab

-- sqlfmt-corpus-separator --

SELECT a FROM a WHERE a > 2 UNION ALL (SELECT a FROM c WHERE b > 2) LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT a FROM ab UNION ALL SELECT x AS a FROM xy

-- sqlfmt-corpus-separator --

SELECT a FROM ab UNION ALL SELECT x AS a FROM xy ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM ab UNION SELECT b FROM ab

-- sqlfmt-corpus-separator --

SELECT a, NULLIF(a, 2), IF(a = 2, NULL, a) FROM t ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b AS b1, b AS b2 FROM abc EXCEPT SELECT a, b, c FROM abc ORDER by a, b1

-- sqlfmt-corpus-separator --

SELECT a, b AS b1, b AS b2 FROM abc INTERSECT SELECT a, c, b FROM abc ORDER by a, b2

-- sqlfmt-corpus-separator --

SELECT a, b FROM ab EXCEPT ALL SELECT x, y FROM xy ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM ab EXCEPT SELECT x, y FROM xy ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM ab INTERSECT ALL SELECT x, y FROM xy ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM ab INTERSECT SELECT x AS a, y AS b FROM xy

-- sqlfmt-corpus-separator --

SELECT a, b FROM ab INTERSECT SELECT x AS a, y AS b FROM xy ORDER BY b, a

-- sqlfmt-corpus-separator --

SELECT a, b FROM ab INTERSECT SELECT x, y FROM xy ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM ab UNION ALL SELECT x, y FROM xy ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM ab UNION SELECT x AS a, y AS b FROM xy

-- sqlfmt-corpus-separator --

SELECT a, b FROM ab UNION SELECT x AS a, y AS b FROM xy ORDER BY b, a

-- sqlfmt-corpus-separator --

SELECT a, b FROM ab UNION SELECT x, y FROM xy ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM nulls WHERE a IS DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT a, b FROM nulls WHERE a IS NOT DISTINCT FROM NULL

-- sqlfmt-corpus-separator --

SELECT a, b, (a + 1) * (b + 2) FROM a WHERE a < 3

-- sqlfmt-corpus-separator --

SELECT a, b, avg(b) OVER (ROWS 0 PRECEDING) FROM t ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM abc WHERE EXISTS (SELECT * FROM def WHERE a=d OR a=e)

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM abc WHERE NOT EXISTS (SELECT * FROM def WHERE a=d OR a=e)

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM abc_decimal WHERE EXISTS (SELECT * FROM def_decimal WHERE a::string=d::string or a::string=e::string)

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM abc_decimal WHERE EXISTS (SELECT * FROM def_decimal WHERE a::string=d::string)

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM abc_decimal WHERE NOT EXISTS (SELECT * FROM def_decimal WHERE a::string=d::string or a::string=e::string)

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

SELECT a,b from small WHERE EXISTS (SELECT a FROM data WHERE small.a=data.a) ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a,b from small WHERE a+b<20 AND EXISTS (SELECT a FROM data WHERE small.a=data.a AND small.b+data.c>15) ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a1,a2,a3 FROM a WHERE EXISTS (SELECT * FROM b WHERE a1 = b1 OR a1 = b2)

-- sqlfmt-corpus-separator --

SELECT a1,a2,a3 FROM a WHERE EXISTS (SELECT * FROM b WHERE a2 = b2 OR a3 = b3)

-- sqlfmt-corpus-separator --

SELECT a1,a2,a3 FROM a WHERE NOT EXISTS (SELECT * FROM b WHERE a1 = b1 OR a1 = b2)

-- sqlfmt-corpus-separator --

SELECT a1,a2,a3 FROM a WHERE NOT EXISTS (SELECT * FROM b WHERE a2 = b2 OR a3 = b3)

-- sqlfmt-corpus-separator --

SELECT a1,a2,a3 FROM a,b WHERE (a1=b1 AND a2=b2 AND (a1=1 OR b1=1)) OR (a3=b3 AND a4=b4)

-- sqlfmt-corpus-separator --

SELECT a1,a2,a3 FROM a,b WHERE a1=1 AND (a2=b2 OR a3=b3)

-- sqlfmt-corpus-separator --

SELECT a1,a2,a3,c.* FROM a,c
       WHERE a2 = c2 AND EXISTS (SELECT * FROM b WHERE (a1 = b1 OR a1 = a2) AND (a1 = c1 OR c1 = c2))

-- sqlfmt-corpus-separator --

SELECT a1,a2,a3,c.* FROM a,c
       WHERE a2 = c2 AND EXISTS (SELECT * FROM b WHERE (a1 = b1 OR a1 = b2) AND (c1 = b1 OR c1 = b2))

-- sqlfmt-corpus-separator --

SELECT a1,a2,a3,c.* FROM a,c
       WHERE a2 = c2 AND EXISTS (SELECT * FROM b WHERE (a1 = b1 OR a1 = b3) AND (a1 = c1 OR a1 = c3))

-- sqlfmt-corpus-separator --

SELECT a2,a4 FROM a WHERE EXISTS(SELECT * FROM b WHERE (a1=b1 OR a1=b2) AND EXISTS(SELECT 1 FROM c WHERE b1=c1))

-- sqlfmt-corpus-separator --

SELECT a2,a4 FROM a WHERE EXISTS(SELECT * FROM b WHERE a1=b1 OR a1=b2 OR a1=b3 OR a1=b4) AND
                          EXISTS(SELECT * FROM c WHERE a1=c1 OR a1=c2 OR a1=c3 OR a1=c4)

-- sqlfmt-corpus-separator --

SELECT a2,a4 FROM a WHERE EXISTS(SELECT * FROM b WHERE a1=b1 OR a1=b2) AND
                          EXISTS(SELECT * FROM c WHERE a1=c1 OR a1=c2)

-- sqlfmt-corpus-separator --

SELECT a2,a4 FROM a WHERE NOT EXISTS(SELECT * FROM b WHERE (a1=b1 OR a1=b2) AND NOT EXISTS(SELECT 1 FROM c WHERE b1=c1))

-- sqlfmt-corpus-separator --

SELECT a2,a4 FROM a WHERE NOT EXISTS(SELECT * FROM b WHERE a1=b1 OR a1=b2) AND
                          NOT EXISTS(SELECT * FROM c WHERE a1=c1 OR a1=c2)

-- sqlfmt-corpus-separator --

SELECT ab.rowid FROM ab AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT abc.b FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT abc.foo1 FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT abs(-1.2::float), abs(1.2::float), abs(-0.0::float), abs(0), abs(1), abs(-1.2121::decimal)

-- sqlfmt-corpus-separator --

SELECT acldefault('T'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('Z'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('c'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('d'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('f'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('l'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('n'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('p'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('r'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT aisle FROM supermarket WHERE person = 'gideon' FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT aisle FROM supermarket WHERE person = 'matilda' FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT all_fn(1), all_fn(2), all_fn(NULL::INT)

-- sqlfmt-corpus-separator --

SELECT any_fn(1), any_fn(4), any_fn(NULL::INT)

-- sqlfmt-corpus-separator --

SELECT any_fn_lt(1), any_fn_lt(4), any_fn_lt(NULL::INT)

-- sqlfmt-corpus-separator --

SELECT any_fn_tuple(1, 10), any_fn_tuple(1, 20), any_fn_tuple(NULL::INT, NULL::INT)

-- sqlfmt-corpus-separator --

SELECT array_agg(a) OVER (ORDER BY a ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) FROM t38901 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT array_agg(a) OVER (w GROUPS 1 PRECEDING) FROM x WINDOW w AS (PARTITION BY a ORDER BY a DESC) ORDER BY a

-- sqlfmt-corpus-separator --

SELECT array_agg(a) OVER (w GROUPS 1 PRECEDING) FROM x WINDOW w AS (PARTITION BY a)

-- sqlfmt-corpus-separator --

SELECT array_agg(a) OVER (w RANGE 1 PRECEDING) FROM x WINDOW w AS (ORDER BY a DESC) ORDER BY a

-- sqlfmt-corpus-separator --

SELECT array_agg(bar ORDER BY pk) FROM foo

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1), array_agg(col1 ORDER BY col1) FILTER (WHERE col1 < 0) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1), array_agg(col1 ORDER BY col2, col1), array_agg(col1 ORDER BY col3, col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1), array_agg(col1 ORDER BY col2, col1), col3 FROM tab GROUP BY col3 ORDER BY col3

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1), array_agg(col1 ORDER BY col2, col1), count(col3), count(*) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col2) FROM TAB

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col2*100+col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col3, col1) FILTER (WHERE col1 < 0), array_agg(col1 ORDER BY col3, col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY id NULLS LAST) FROM nulls_last_test

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY id) FROM nulls_last_test

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY id)::STRING, st_asmvt(NULL, NULL)::STRING FROM mvt_win_test

-- sqlfmt-corpus-separator --

SELECT array_agg(v ORDER BY k) FROM kv_enum

-- sqlfmt-corpus-separator --

SELECT array_agg(x ORDER BY x) FROM t;

-- sqlfmt-corpus-separator --

SELECT array_agg(y ORDER BY y) FROM t;

-- sqlfmt-corpus-separator --

SELECT array_append(NULL::INT[], 4), array_append(NULL::INT[], NULL::INT)

-- sqlfmt-corpus-separator --

SELECT array_cat_agg('{1, 2}'::INT[]) FROM kv

-- sqlfmt-corpus-separator --

SELECT array_cat_agg('{1}'::INT[])

-- sqlfmt-corpus-separator --

SELECT array_cat_agg('{1}'::INT[]) FROM kv

-- sqlfmt-corpus-separator --

SELECT array_cat_agg(arr ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_cat_agg(arr ORDER BY col2*100+col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_prepend(4, NULL::INT[]), array_prepend(NULL::INT, NULL::INT[])

-- sqlfmt-corpus-separator --

SELECT array_remove(NULL::INT[], NULL::INT)

-- sqlfmt-corpus-separator --

SELECT array_to_json('{1, 2, 3}'::INT[])

-- sqlfmt-corpus-separator --

SELECT array_to_string(array_agg(i ORDER BY pk), ' ') FROM intervals

-- sqlfmt-corpus-separator --

SELECT avg(1::int)::float, avg(2::float)::float, avg(3::decimal)::float

-- sqlfmt-corpus-separator --

SELECT avg(a+b+c::INT+d) FROM data

-- sqlfmt-corpus-separator --

SELECT avg(c), sum(c), sum_int(c::INT), avg(d), sum(d) FROM data

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

SELECT b FROM ab EXCEPT ALL SELECT y AS b FROM xy

-- sqlfmt-corpus-separator --

SELECT b FROM ab EXCEPT ALL SELECT y AS b FROM xy ORDER BY b

-- sqlfmt-corpus-separator --

SELECT b FROM ab INTERSECT ALL SELECT y AS b FROM xy

-- sqlfmt-corpus-separator --

SELECT b FROM ab INTERSECT ALL SELECT y AS b FROM xy ORDER BY b

-- sqlfmt-corpus-separator --

SELECT b FROM ab UNION SELECT a FROM ab

-- sqlfmt-corpus-separator --

SELECT b FROM abcde WHERE a = 85 AND b = 86 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT b, a FROM ab EXCEPT SELECT y AS b, x AS a FROM xy

-- sqlfmt-corpus-separator --

SELECT b, a FROM ab EXCEPT SELECT y AS b, x AS a FROM xy ORDER BY b, a

-- sqlfmt-corpus-separator --

SELECT c FROM abc WHERE EXISTS (SELECT * FROM def WHERE a=d OR a=e)

-- sqlfmt-corpus-separator --

SELECT c FROM abc WHERE NOT EXISTS (SELECT * FROM def WHERE a=d OR a=e)

-- sqlfmt-corpus-separator --

SELECT c, d, sum(a+c::INT) + avg(b+d), sum_int(a+c::INT) + avg(b+d)::INT FROM data GROUP BY c, d ORDER BY c, d

-- sqlfmt-corpus-separator --

SELECT c, first_value(c) OVER w, last_value(c) OVER w, nth_value(c, 2) OVER w
FROM t WINDOW w AS (ORDER BY c RANGE BETWEEN 5 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT c0 FROM t103755 WHERE c0 < 0 OR c0 IN (VALUES (2)) ORDER BY c0;

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

SELECT ceil(-0.5::float), ceil(0.5::float), ceiling(0.5::float), ceil(0.1::decimal), ceiling (-0.9::decimal)

-- sqlfmt-corpus-separator --

SELECT ceil(-0.5::float), ceil(0.5::float), ceiling(0.5::float), ceil(0.1::decimal), ceiling(-0.9::decimal)

-- sqlfmt-corpus-separator --

SELECT concat('foo'::concat_enum, ' ', 64.532, ' ', 'baz'::concat_enum, ' ', 42, ' ', 1 = 0, ' ', '{"foo": "bar"}'::json, ' ', '{1, 2, 3}'::int[])

-- sqlfmt-corpus-separator --

SELECT concat_agg(col3 ORDER BY col1 DESC) FROM tab

-- sqlfmt-corpus-separator --

SELECT concat_agg(col3 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT count(*) = 0
  FROM crdb_internal.node_txn_stats
 WHERE application_name = 'test'
   AND (
        txn_time_avg_sec < 0
        OR txn_time_avg_sec > 1
       )

-- sqlfmt-corpus-separator --

SELECT count(*) > 0 FROM crdb_internal.cluster_contention_events WHERE table_id = 'kv'::REGCLASS::INT

-- sqlfmt-corpus-separator --

SELECT count(*) > 0 FROM crdb_internal.node_contention_events WHERE table_id = 'kv'::REGCLASS::INT

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE 1) OVER () FROM products

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE count(*) > 5) OVER () FROM products

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE count(*) OVER () > 5) OVER () FROM products

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE true) OVER (), count(*) FILTER (WHERE false) OVER () FROM products

-- sqlfmt-corpus-separator --

SELECT count(*) FROM bbox_units
WHERE 'BOX(-10 -10,10 10)'::BOX2D IN (
  SELECT st_expand('BOX(1 -1, 1 -1)'::BOX2D, t2.f) FROM bbox_units t2
);

-- sqlfmt-corpus-separator --

SELECT count(*), v/(k+v) FROM kv GROUP BY k+v

-- sqlfmt-corpus-separator --

SELECT count(1) FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT count(1) OVER () FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT count(1), concat_agg(col3 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT count(2::int), count(3::float), count(4::decimal)

-- sqlfmt-corpus-separator --

SELECT count(a) OVER (ROWS 1 PRECEDING) FROM t

-- sqlfmt-corpus-separator --

SELECT crdb_internal.check_password_hash_format(('CRDB-BCRYPT$'||'2a$'||'01$'||'vcmoIBvgeHjgScVHWRMWI.Z3v03WMixAw2bBS6qZihljSUuwi88Yq')::bytes)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.check_password_hash_format(('CRDB-BCRYPT$'||'2a$'||'10$'||'vcmoIBvgeHjgScVHWRMWI.Z3v0')::bytes)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.check_password_hash_format(('CRDB-BCRYPT$'||'2a$'||'10$'||'vcmoIBvgeHjgScVHWRMWI.Z3v03WMixAw2bBS6qZihljSUuwi88Yq')::bytes)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.check_password_hash_format(('CRDB-BCRYPT$'||'3a$'||'10$'||'vcmoIBvgeHjgScVHWRMWI.Z3v03WMixAw2bBS6qZihljSUuwi88Yq')::bytes)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.check_password_hash_format(('SCRAM-SHA-256$'||'4096:B5VaTCvCLDzZxSYL829oVA==$'||'3Ako3mNxNtdsaSOJl0Av3i6vyV2OiSP9Ly7famdFSbw=:d7BfSmrtjwbF74mSoOhQiDSpoIvlakXKdpBNb3Meunc=')::bytes)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.unsafe_upsert_namespace_entry(104,105,'dangling',12345,true)
UNION ALL
SELECT crdb_internal.unsafe_upsert_namespace_entry(104,105,'dangling2',12345,true)

-- sqlfmt-corpus-separator --

SELECT d FROM abcde WHERE a = 45 AND b = 46 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT d, e, f FROM def EXCEPT SELECT a, b, c FROM abc ORDER by d, e

-- sqlfmt-corpus-separator --

SELECT d3,d1,d2 FROM d WHERE (d1,d3) NOT IN (SELECT b1,b2 FROM b WHERE EXISTS (SELECT 1 FROM c WHERE c2=b2 OR c2=b3))

-- sqlfmt-corpus-separator --

SELECT d3,d1,d2 FROM d WHERE d1 NOT IN (SELECT b1 FROM b WHERE EXISTS (SELECT 1 FROM c WHERE c2=b2 OR c2=b3))

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, table_name, lock_key_pretty, lock_strength, durability, isolation_level, granted, contended FROM crdb_internal.cluster_locks WHERE table_id='t'::regclass::oid::int

-- sqlfmt-corpus-separator --

SELECT distinct is_identity FROM information_schema.columns

-- sqlfmt-corpus-separator --

SELECT distinct(a) FROM t53922

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

SELECT e FROM abcde WHERE a = 5 AND b = 6 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT e, f, g, h FROM efgh EXCEPT SELECT a, b, c, d FROM abcd ORDER by e, f

-- sqlfmt-corpus-separator --

SELECT erf(0::float), erfc(0::float)

-- sqlfmt-corpus-separator --

SELECT exp(-1.0::float), round(exp(1.0::float), 13), exp(2.0::decimal)

-- sqlfmt-corpus-separator --

SELECT extract('DAY' from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract('EPOCH' from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract('day' from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract('microsecond' from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(day from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract(epoch from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract(epoch from timetz '12:00:00+04')

-- sqlfmt-corpus-separator --

SELECT extract(hour FROM '2001-01-01 13:00:00'::timestamp)

-- sqlfmt-corpus-separator --

SELECT extract(hour FROM '2001-01-01 13:00:00+01'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(hour from '2016-02-10 19:46:33.306157519-04'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(hour from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(hour from timetz '12:01:02.345678-07')

-- sqlfmt-corpus-separator --

SELECT extract(hours from '2016-02-10 19:46:33.306157519-04'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(microsecond from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(microsecond from timetz '12:01:02.345678-05')

-- sqlfmt-corpus-separator --

SELECT extract(millisecond from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(millisecond from timetz '12:01:02.345678+00')

-- sqlfmt-corpus-separator --

SELECT extract(minute from interval '10:55:01.456')

-- sqlfmt-corpus-separator --

SELECT extract(minute from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(minute from timetz '12:01:02.345678+03')

-- sqlfmt-corpus-separator --

SELECT extract(nansecond from '2001-04-10 12:04:59.34565423'::timestamp)

-- sqlfmt-corpus-separator --

SELECT extract(nansecond from '2001-04-10 12:04:59.34565423'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(second from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(second from timetz '12:01:02.345678-06')

-- sqlfmt-corpus-separator --

SELECT extract(timezone FROM '2001-01-01 13:00:00+01:15'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT f(1), f(2), f(NULL::INT);

-- sqlfmt-corpus-separator --

SELECT f1 + time with time zone '00:01' AS "Illegal" FROM TIMETZ_TBL ORDER BY id

-- sqlfmt-corpus-separator --

SELECT f1::string AS "None" FROM TIMETZ_TBL WHERE f1 < '00:00-07' ORDER BY id

-- sqlfmt-corpus-separator --

SELECT f1::string AS "Seven" FROM TIMETZ_TBL WHERE f1 > '05:06:07-07' ORDER BY id

-- sqlfmt-corpus-separator --

SELECT f1::string AS "Ten" FROM TIMETZ_TBL WHERE f1 >= '00:00-07' ORDER BY id

-- sqlfmt-corpus-separator --

SELECT f1::string AS "Three" FROM TIMETZ_TBL WHERE f1 < '05:06:07-07' ORDER BY id

-- sqlfmt-corpus-separator --

SELECT f::DECIMAL + round(max(k) * w * avg(d) OVER wind) + (lead(f, 2, 17::FLOAT) OVER wind::DECIMAL / d * row_number() OVER wind) FROM kv GROUP BY k, w, f, d WINDOW wind AS (ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT f::INT FROM t112515

-- sqlfmt-corpus-separator --

SELECT f::int FROM t2

-- sqlfmt-corpus-separator --

SELECT first_value(x) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND '0 YEAR'::INTERVAL FOLLOWING) FROM t;

-- sqlfmt-corpus-separator --

SELECT floor(-1.5::float), floor(1.5::float), floor(9.123456789::decimal)

-- sqlfmt-corpus-separator --

SELECT foo.a FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT foo1, foo.foo1, b, foo.c FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT generate_series(1, 2) FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT generate_series(9223372036854775807::int, -9223372036854775807::int, -9223372036854775807::int)

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('{NULL,1,NULL,2}'::int[], 1) AS s

-- sqlfmt-corpus-separator --

SELECT generate_subscripts('{NULL,1,NULL,2}'::int[], 1, true) AS s

-- sqlfmt-corpus-separator --

SELECT get_bit('000000'::varbit, 5) UNION SELECT get_bit('1111111'::varbit, 5)

-- sqlfmt-corpus-separator --

SELECT get_bit(B'100101110101', 3) UNION SELECT get_bit(B'100101110101', 2)

-- sqlfmt-corpus-separator --

SELECT get_secret_data()
UNION
SELECT id FROM secret_data;

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

SELECT i.relname AS name,
       ix.indisprimary AS PRIMARY,
       ix.indisunique AS UNIQUE,
       ix.indkey AS indkey,
       array_agg(a.attnum ORDER BY a.attnum) AS column_indexes,
       array_agg(a.attname ORDER BY a.attnum) AS column_names,
       pg_get_indexdef(ix.indexrelid) AS definition
FROM pg_class t,
     pg_class i,
     pg_index ix,
     pg_attribute a
WHERE t.oid = ix.indrelid
AND   i.oid = ix.indexrelid
AND   a.attrelid = t.oid
AND   t.relkind = 'r'
AND   t.relname = 'customers' -- this query is run once for each table
GROUP BY i.relname,
         ix.indexrelid,
         ix.indisprimary,
         ix.indisunique,
         ix.indkey
ORDER BY i.relname

-- sqlfmt-corpus-separator --

SELECT id FROM current_time_test WHERE
  ('1970-01-01 ' || b::string)::timestamp -
  ('1970-01-01 ' || a::string)::timestamp
> '1ms'::interval ORDER BY id ASC

-- sqlfmt-corpus-separator --

SELECT id, 'empty' FROM a
UNION ALL
  SELECT id, delete_cascade FROM b1
UNION ALL
  SELECT id, delete_cascade FROM b2
UNION ALL
  SELECT id, delete_set_default FROM c1
UNION ALL
  SELECT id, delete_set_default FROM c2
UNION ALL
  SELECT id, delete_set_default FROM c3
;

-- sqlfmt-corpus-separator --

SELECT id, 'empty' FROM a
UNION ALL
  SELECT id, delete_cascade FROM b1
UNION ALL
  SELECT id, delete_cascade FROM b2
UNION ALL
  SELECT id, delete_set_null FROM c1
UNION ALL
  SELECT id, delete_set_null FROM c2
UNION ALL
  SELECT id, delete_set_null FROM c3
;

-- sqlfmt-corpus-separator --

SELECT id, a_id FROM b
UNION ALL
  SELECT id, b_a_id FROM c

-- sqlfmt-corpus-separator --

SELECT id, a_id FROM b
UNION ALL
  SELECT id, b_a_id FROM c
;

-- sqlfmt-corpus-separator --

SELECT id, delete_set_default FROM b1
UNION ALL
  SELECT id, delete_set_default FROM b2
UNION ALL
  SELECT id, delete_set_default FROM b3
UNION ALL
  SELECT id, delete_set_default FROM b4
;

-- sqlfmt-corpus-separator --

SELECT id, delete_set_null FROM b1
UNION ALL
  SELECT id, delete_set_null FROM b2
UNION ALL
  SELECT id, delete_set_null FROM b3
UNION ALL
  SELECT id, delete_set_null FROM b4
;

-- sqlfmt-corpus-separator --

SELECT id, update_cascade FROM b1
UNION ALL
  SELECT id, update_cascade FROM b2
UNION ALL
  SELECT id, update_set_null FROM c1
UNION ALL
  SELECT id, update_set_null FROM c2
UNION ALL
  SELECT id, update_set_null FROM c3
;

-- sqlfmt-corpus-separator --

SELECT id, update_set_null FROM b1
UNION ALL
  SELECT id, update_set_null FROM b2
UNION ALL
  SELECT id, update_set_null FROM b3
UNION ALL
  SELECT id, update_set_null FROM b4
;

-- sqlfmt-corpus-separator --

SELECT indoption
FROM pg_catalog.pg_index
WHERE indexrelid IN (SELECT crdb_oid FROM pg_catalog.pg_indexes WHERE indexname = 't_hash_a_idx')

-- sqlfmt-corpus-separator --

SELECT int_identity((1/0)::INT)

-- sqlfmt-corpus-separator --

SELECT interval ' 5  ' year

-- sqlfmt-corpus-separator --

SELECT interval '1 +2:03' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 +2:03:04' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 -2:03' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 -2:03:04' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2' day to hour

-- sqlfmt-corpus-separator --

SELECT interval '1 2' day to minute

-- sqlfmt-corpus-separator --

SELECT interval '1 2' day to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2' hour to minute

-- sqlfmt-corpus-separator --

SELECT interval '1 2' hour to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2.345' day to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2.345' hour to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2.3456' minute to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' day to hour

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' day to minute

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' day to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' day to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' hour to minute

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' hour to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03.4567' day to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03.45678' hour to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03.5678' minute to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04' day to hour

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04' day to minute

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04' day to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04' hour to minute

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04' hour to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04.5678' day to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04.5678' hour to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04.5678' minute to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1' year

-- sqlfmt-corpus-separator --

SELECT interval '1' year to month

-- sqlfmt-corpus-separator --

SELECT interval '1-2 3' day

-- sqlfmt-corpus-separator --

SELECT interval '1-2 3' year

-- sqlfmt-corpus-separator --

SELECT interval '1-2' year to month

-- sqlfmt-corpus-separator --

SELECT interval '1.234' second

-- sqlfmt-corpus-separator --

SELECT interval '1.234' second(2)

-- sqlfmt-corpus-separator --

SELECT interval '123 11' day

-- sqlfmt-corpus-separator --

SELECT interval '123 11' day to hour

-- sqlfmt-corpus-separator --

SELECT interval '12:34.5678' minute to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '2' month

-- sqlfmt-corpus-separator --

SELECT interval '3' day

-- sqlfmt-corpus-separator --

SELECT interval '4' hour

-- sqlfmt-corpus-separator --

SELECT interval '5' minute

-- sqlfmt-corpus-separator --

SELECT interval '6' second

-- sqlfmt-corpus-separator --

SELECT interval '999' day

-- sqlfmt-corpus-separator --

SELECT interval '999' hour

-- sqlfmt-corpus-separator --

SELECT interval '999' minute

-- sqlfmt-corpus-separator --

SELECT interval '999' month

-- sqlfmt-corpus-separator --

SELECT interval '999' second

-- sqlfmt-corpus-separator --

SELECT interval(0) '1 day 01:23:45.6789'

-- sqlfmt-corpus-separator --

SELECT interval(2) '1 day 01:23:45.6789'

-- sqlfmt-corpus-separator --

SELECT json_agg(col1 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT json_agg(v ORDER BY v) FROM t115054_1

-- sqlfmt-corpus-separator --

SELECT json_agg(v ORDER BY v) FROM t115054_2

-- sqlfmt-corpus-separator --

SELECT json_build_object('{1,2,3}'::int[], 3)

-- sqlfmt-corpus-separator --

SELECT json_build_object(b.name, json_object_agg(p.property_name, p.property_value ORDER BY p.property_value))
FROM blog b, blog_properties p WHERE b.id = p.blog_id
GROUP BY b.name

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(a) OVER (ORDER BY a GROUPS BETWEEN 5 FOLLOWING AND UNBOUNDED FOLLOWING) FROM x

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(col1 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(col1 ORDER BY col2, col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg(s, s) OVER (ORDER BY s RANGE UNBOUNDED PRECEDING) FROM t54604

-- sqlfmt-corpus-separator --

SELECT jsonb_pretty(crdb_internal.pb_to_json(
  'cockroach.sql.sqlbase.Descriptor',
  descriptor
)->'table'->'dependedOnBy')
FROM system.descriptor
WHERE id = 'trigger_dep_t2'::REGCLASS::OID::INT

-- sqlfmt-corpus-separator --

SELECT jsonb_pretty(crdb_internal.pb_to_json('descriptor', descriptor)->'function'->'dependedOnBy') as dependedOnBy
FROM system.descriptor
WHERE id = (select 'f'::REGPROC::INT - 100000);

-- sqlfmt-corpus-separator --

SELECT k, (avg(w) OVER w + rank() OVER w), k FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, (lag(k, 5, w) OVER w + lead(k, 3, v) OVER w) FROM kv WINDOW w AS (ORDER BY k) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, (rank() OVER w + avg(w) OVER w), k FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, (rank() OVER wind + avg(w) OVER wind), w, (v + row_number() OVER wind), v FROM kv WINDOW wind AS (ORDER BY k) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, abs(k) FILTER (WHERE k=1) FROM kv

-- sqlfmt-corpus-separator --

SELECT k, avg(d) OVER w1, avg(d) OVER w2, row_number() OVER w2, sum(f) OVER w1, row_number() OVER w1, sum(f) OVER w2 FROM kv WINDOW w1 AS (ORDER BY k), w2 AS (ORDER BY w, k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k, first_value(NULL::INT) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, first_value(k) OVER (ORDER BY v GROUPS BETWEEN 0 PRECEDING AND 2 PRECEDING) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, NULL::INT) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, last_value(NULL::INT) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, NULL::INT) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(NULL::INT, 5) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(NULL::INT) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, rank() FILTER (WHERE k=1) OVER () FROM kv

-- sqlfmt-corpus-separator --

SELECT k, stddev(d) OVER w FROM kv WINDOW w as (PARTITION BY v) ORDER BY variance(d) OVER w, k

-- sqlfmt-corpus-separator --

SELECT k, u FROM t3 WHERE u = 2 FOR UPDATE SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT k, v + w, round(rank() OVER wind + lead(k, 3, v) OVER wind + lag(w, 1, 2) OVER wind + f::DECIMAL + avg(d) OVER wind)::INT, round(row_number() OVER wind::FLOAT + round(f) + dense_rank() OVER wind::FLOAT)::INT FROM kv WINDOW wind as (PARTITION BY v ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v SIMILAR TO 'ABC_*'

-- sqlfmt-corpus-separator --

SELECT l IS DISTINCT FROM NULL FROM implicit_types;

-- sqlfmt-corpus-separator --

SELECT l IS NOT DISTINCT FROM NULL FROM implicit_types;

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER w, lead(x) OVER w, first_value(x) OVER w, last_value(x) OVER w FROM t WINDOW w AS (ORDER BY x);

-- sqlfmt-corpus-separator --

SELECT lag(y) OVER w, lead(y) OVER w, first_value(y) OVER w, last_value(y) OVER w FROM t WINDOW w AS ();

-- sqlfmt-corpus-separator --

SELECT length(descriptor) * (id - 1) FROM system.descriptor WHERE id = 1

-- sqlfmt-corpus-separator --

SELECT lk FROM ltable WHERE EXISTS (SELECT * FROM rtable WHERE ST_Intersects(ltable.geom2, rtable.geom))
ORDER BY lk

-- sqlfmt-corpus-separator --

SELECT ln(-2.0::float), ln(2.0::float), ln(2.5::decimal)

-- sqlfmt-corpus-separator --

SELECT log(10.0::float), log(100.000::decimal)

-- sqlfmt-corpus-separator --

SELECT log(2.0::float, -10.0::float)

-- sqlfmt-corpus-separator --

SELECT log(2.0::float, 0.0::float)

-- sqlfmt-corpus-separator --

SELECT log(2.0::float, 4.0::float)

-- sqlfmt-corpus-separator --

SELECT log10(1000::float), log10(1000::decimal)

-- sqlfmt-corpus-separator --

SELECT max(c) OVER (ORDER BY c ROWS BETWEEN UNBOUNDED PRECEDING AND 9223372036854775807::INT8 FOLLOWING) FROM t65978

-- sqlfmt-corpus-separator --

SELECT max(c) OVER (ORDER BY c ROWS BETWEEN UNBOUNDED PRECEDING AND 9223372036854775807::INT8 PRECEDING) FROM t65978

-- sqlfmt-corpus-separator --

SELECT max(c) OVER (ROWS BETWEEN 9223372036854775807::INT8 FOLLOWING AND UNBOUNDED FOLLOWING) FROM t65978

-- sqlfmt-corpus-separator --

SELECT max(c) OVER (ROWS BETWEEN 9223372036854775807::INT8 PRECEDING AND UNBOUNDED FOLLOWING) FROM t65978

-- sqlfmt-corpus-separator --

SELECT mod(5.0::float, 2.0), mod(1.0::float, 0.0), mod(5, 2), mod(19.3::decimal, 2)

-- sqlfmt-corpus-separator --

SELECT n FROM a WHERE b = 1 AND (((a < 1) AND (a > 1)) OR (a >= 2 AND a <= 2))

-- sqlfmt-corpus-separator --

SELECT oid(3), oid(0), (-1)::oid, (-2147483648)::oid, (4294967295)::oid

-- sqlfmt-corpus-separator --

SELECT oid::INT, typname FROM pg_type ORDER BY oid LIMIT 3

-- sqlfmt-corpus-separator --

SELECT oid::REGPROC FROM pg_proc WHERE prokind = 'a' EXCEPT SELECT aggfnoid FROM pg_aggregate

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

SELECT percentile_disc(0.95) WITHIN GROUP (ORDER BY '33'::INT) FROM osagg

-- sqlfmt-corpus-separator --

SELECT percentile_disc(0.95) WITHIN GROUP (ORDER BY 'foo') FROM osagg

-- sqlfmt-corpus-separator --

SELECT percentile_disc(0.95) WITHIN GROUP (ORDER BY 33) FROM osagg

-- sqlfmt-corpus-separator --

SELECT percentile_disc(0.95) WITHIN GROUP (ORDER BY 33.0) FROM osagg

-- sqlfmt-corpus-separator --

SELECT percentile_disc(0.95) WITHIN GROUP (ORDER BY 33::INT) FROM osagg

-- sqlfmt-corpus-separator --

SELECT percentile_disc(0.95) WITHIN GROUP (ORDER BY current_database()) FROM osagg

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_function_is_visible((select 'pg_table_is_visible'::regproc))

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_get_constraintdef(oid)
FROM pg_catalog.pg_constraint
WHERE conrelid='pg_constraintdef_test'::regclass

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_get_expr('1', 0), pg_catalog.pg_get_expr('1', 0::OID)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_get_viewdef('pg_viewdef_mview'::regclass::oid)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_get_viewdef('pg_viewdef_view'::regclass::oid)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_get_viewdef('pg_viewdef_view'::regclass::oid, false)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_get_viewdef('pg_viewdef_view'::regclass::oid, true)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_table_is_visible('foo'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_column_size(1::float)

-- sqlfmt-corpus-separator --

SELECT pg_column_size(1::int)

-- sqlfmt-corpus-separator --

SELECT pg_column_size(NULL::int)

-- sqlfmt-corpus-separator --

SELECT pk FROM t40574 WHERE (col0 > 9 AND (col1 <= 6.38 OR col0 =5) AND (col0 = 7 OR col4 = 7))

-- sqlfmt-corpus-separator --

SELECT position('\x616263'::bytea in 'abc'::bytea)

-- sqlfmt-corpus-separator --

SELECT position('a' in 'high')

-- sqlfmt-corpus-separator --

SELECT position('ig' in 'high')

-- sqlfmt-corpus-separator --

SELECT position(B'100' in B'100101')

-- sqlfmt-corpus-separator --

SELECT pow(-2::int, 3::int), pow(2::int, 3::int)

-- sqlfmt-corpus-separator --

SELECT pow(-3.0::float, 2.0), power(3.0::float, 2.0), pow(5.0::decimal, 2.0)

-- sqlfmt-corpus-separator --

SELECT pow(0::int, -3::int)

-- sqlfmt-corpus-separator --

SELECT pow(0::int, 0::int)

-- sqlfmt-corpus-separator --

SELECT pow(0::int, 3::int), pow(3::int, 0::int), pow(-3::int, 0::int)

-- sqlfmt-corpus-separator --

SELECT pow(2::int, -3::int)

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

SELECT regr_count(DISTINCT y, x) FILTER (WHERE x > 3 AND y < 100)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT repeat('1234567890'::string, 6978072892806141784::int)

-- sqlfmt-corpus-separator --

SELECT rk FROM rtable WHERE EXISTS (SELECT * FROM ltable WHERE ST_Intersects(ltable.geom2, rtable.geom))
ORDER BY rk

-- sqlfmt-corpus-separator --

SELECT rk FROM rtable WHERE NOT EXISTS (SELECT * FROM ltable WHERE ST_Intersects(ltable.geom2, rtable.geom))
ORDER BY rk

-- sqlfmt-corpus-separator --

SELECT rolname
FROM pg_authid WHERE oid IN (
  SELECT refobjid FROM pg_shdepend WHERE deptype = 'p'
) ORDER BY rolname

-- sqlfmt-corpus-separator --

SELECT round('inf'::float), round('inf'::float, 1), round('-inf'::float), round('-inf'::float, 1)

-- sqlfmt-corpus-separator --

SELECT round('nan'::decimal), round('nan'::decimal, 1), round('nan'::float), round('nan'::float, 1)

-- sqlfmt-corpus-separator --

SELECT round((avg(d) OVER wind) * max(k) + (lag(d, 1, 42.0) OVER wind) * max(d)) FROM kv GROUP BY d, k WINDOW wind AS (ORDER BY k) ORDER BY k

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

SELECT round(1.390671161567e-309::float), round(0.49999999999999994::float), round(0.5000000000000001::float), round(2251799813685249.5::float), round(2251799813685250.5::float), round(4503599627370495.5::float), round(4503599627370497::float)

-- sqlfmt-corpus-separator --

SELECT round(123.456::float, -1), round(123.456::float, -2), round(123.456::float, -3)

-- sqlfmt-corpus-separator --

SELECT round(123.456::float, -2438602134409251682)

-- sqlfmt-corpus-separator --

SELECT round(1e-308::float, 324)

-- sqlfmt-corpus-separator --

SELECT round(4.2::float, 0), round(4.2::float, 10), round(4.22222222::decimal, 3)

-- sqlfmt-corpus-separator --

SELECT round(max(w) * w * avg(w) OVER wind) + (lead(w, 2, 17) OVER wind::DECIMAL / w * row_number() OVER wind) FROM kv GROUP BY w WINDOW wind AS (PARTITION BY w) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT round(row_number() OVER w1 + lead(k, v, w) OVER w2 + avg(k) OVER w1), (lag(k, 1) OVER w1 + v + rank() OVER w2 + min(k) OVER w1) FROM kv WINDOW w1 AS (PARTITION BY w ORDER BY k), w2 AS (PARTITION BY b ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT rowid, foo.rowid FROM ab AS foo (foo1, foo2)

-- sqlfmt-corpus-separator --

SELECT s, w + k, (sum(w) OVER wind + avg(d) OVER wind), (min(w) OVER wind + d), v FROM kv WINDOW wind AS (ORDER BY w, k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT set_bit('000000'::varbit, 5, 1) UNION SELECT set_bit('111111'::varbit, 5, 0)

-- sqlfmt-corpus-separator --

SELECT set_bit(B'1101010', 0, 0) UNION SELECT set_bit(B'1101010', 2, 1)

-- sqlfmt-corpus-separator --

SELECT small.c FROM small WHERE EXISTS(SELECT 1 FROM large WHERE small.c = large.b AND large.d < 30)

-- sqlfmt-corpus-separator --

SELECT small.c FROM small WHERE NOT EXISTS(SELECT 1 FROM large WHERE small.c = large.b AND large.d < 30)

-- sqlfmt-corpus-separator --

SELECT sqrt(-1.0::float)

-- sqlfmt-corpus-separator --

SELECT sqrt(4.0::float), sqrt(9.0::decimal)

-- sqlfmt-corpus-separator --

SELECT st_asmvt(NULL, NULL), array_agg(a ORDER BY a) FROM mvt_null_test

-- sqlfmt-corpus-separator --

SELECT stddev(1::int), stddev_samp(1::float), stddev(1::decimal)

-- sqlfmt-corpus-separator --

SELECT stddev(a+b+c::INT+d), stddev_pop(a+b+c::INT+d) FROM data

-- sqlfmt-corpus-separator --

SELECT stddev_pop(1::int), stddev_pop(1::float), stddev_pop(1::decimal)

-- sqlfmt-corpus-separator --

SELECT string_agg(col3, ', ' ORDER BY col3 DESC) FROM tab

-- sqlfmt-corpus-separator --

SELECT string_agg(col3, ', ' ORDER BY col3) FROM tab

-- sqlfmt-corpus-separator --

SELECT substring('12345' for 3)

-- sqlfmt-corpus-separator --

SELECT substring('RoacH' for 3 from 2)

-- sqlfmt-corpus-separator --

SELECT substring('RoacH' from 2 for 3)

-- sqlfmt-corpus-separator --

SELECT substring('RoacH' from 2)

-- sqlfmt-corpus-separator --

SELECT substring('f(oabaroob' from '+(o(.)b' for '+')

-- sqlfmt-corpus-separator --

SELECT substring('f(oabaroob' from '\(o(.)b' for '+')

-- sqlfmt-corpus-separator --

SELECT substring('f(oabaroob' from '\(o(.)b')

-- sqlfmt-corpus-separator --

SELECT substring('foobar' from 'o.b')

-- sqlfmt-corpus-separator --

SELECT substring(B'10001000' FOR 4 FROM 0), substring(B'10001000' FROM 0 FOR 4), substring(B'10001000' FOR 4)

-- sqlfmt-corpus-separator --

SELECT substring(b'abc' FOR 3 FROM 1), substring(b'abc' FROM 1 FOR 3), substring(b'abc' FOR 3)

-- sqlfmt-corpus-separator --

SELECT substring(crdb_internal.pb_to_json('desc', descriptor)->'table'->'columns'->0->>'defaultExpr' FOR 7)
FROM system.descriptor
WHERE id = 't_serial_identity_with_sequence'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT sum((a-1)*1000 + (b-1)*100 + (c::INT-1)*10 + (d-1)) FROM data

-- sqlfmt-corpus-separator --

SELECT sum((a-1)*1000) + sum((b-1)*100) + sum((c::INT-1)*10) + sum(d-1) FROM data

-- sqlfmt-corpus-separator --

SELECT sum(1::int), sum(2::float), sum(3::decimal)

-- sqlfmt-corpus-separator --

SELECT sum(a) OVER (PARTITION BY (SELECT count(*) FROM x GROUP BY a LIMIT 1))::INT FROM x

-- sqlfmt-corpus-separator --

SELECT sum(a), avg(DISTINCT a), variance(a) FILTER (WHERE a > 0) FROM data

-- sqlfmt-corpus-separator --

SELECT sum(a), min(b), max(c), count(d), avg(a+b+c::INT+d), stddev(a+b), stddev_pop(a+b), variance(c::INT+d), var_pop(c::INT+d) FROM data

-- sqlfmt-corpus-separator --

SELECT sum(a), stddev(a), stddev_pop(a), avg(a) FILTER (WHERE a > 5), count(b), avg(b), variance(b), var_pop(b) FILTER (WHERE b < 8), sum(b) FILTER (WHERE b < 8), stddev(b) FILTER (WHERE b > 2) FROM data

-- sqlfmt-corpus-separator --

SELECT sum(a), sum_int(a), avg(b), sum(c), avg(d), stddev(a), stddev_pop(a), variance(b), var_pop(b), sum(a+b+c::INT+d) FROM data

-- sqlfmt-corpus-separator --

SELECT sum(a+b), sum(a+b) FILTER (WHERE a < d), sum_int(a+b) FILTER (WHERE a < d), sum(a+b) FILTER (WHERE a = c) FROM data GROUP BY d

-- sqlfmt-corpus-separator --

SELECT sum(a+b), sum(a+b) FILTER (WHERE a < d), sum_int(a+b) FILTER (WHERE a < d), sum(a+b) FILTER (WHERE a = c) FROM data WHERE a = 1 GROUP BY d

-- sqlfmt-corpus-separator --

SELECT sum(l_extendedprice) FROM lineitem WHERE l_shipdate >= DATE '1994-01-01' AND l_shipdate < DATE '1994-01-01' + INTERVAL '1' YEAR AND l_extendedprice < 100

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

SELECT sum_int((a-1)*1000 + (b-1)*100 + (c::INT-1)*10 + (d::INT-1)) FROM data

-- sqlfmt-corpus-separator --

SELECT sum_int((a-1)*1000) + sum_int((b-1)*100) + sum_int((c::INT-1)*10) + sum_int(d::INT-1) FROM data

-- sqlfmt-corpus-separator --

SELECT table_catalog, table_schema, table_name, table_type, is_insertable_into
FROM system.information_schema.tables
WHERE
(table_schema <> 'crdb_internal' OR table_name = 'node_build_info')
AND NOT (table_schema = 'public' AND table_name <> 'locations')
ORDER BY table_name, table_schema

-- sqlfmt-corpus-separator --

SELECT to_char(-1::int, '9')

-- sqlfmt-corpus-separator --

SELECT to_char(-485::int, '999MI')

-- sqlfmt-corpus-separator --

SELECT to_char(-485::int, '999PR')

-- sqlfmt-corpus-separator --

SELECT to_char(-485::int, '999S')

-- sqlfmt-corpus-separator --

SELECT to_char(-485::int, 'S999')

-- sqlfmt-corpus-separator --

SELECT to_char(-485::int, 'SG999')

-- sqlfmt-corpus-separator --

SELECT to_char(0::int, '9')

-- sqlfmt-corpus-separator --

SELECT to_char(0::int, '99')

-- sqlfmt-corpus-separator --

SELECT to_char(0::int, 'B9')

-- sqlfmt-corpus-separator --

SELECT to_char(100::int, '99')

-- sqlfmt-corpus-separator --

SELECT to_char(11::int, '99th')

-- sqlfmt-corpus-separator --

SELECT to_char(1234567::int, '9,999,999')

-- sqlfmt-corpus-separator --

SELECT to_char(123::int, '999')

-- sqlfmt-corpus-separator --

SELECT to_char(12::int, '99')

-- sqlfmt-corpus-separator --

SELECT to_char(12::int, '99th')

-- sqlfmt-corpus-separator --

SELECT to_char(12::int, 'FMRN')

-- sqlfmt-corpus-separator --

SELECT to_char(12::int, 'L99')

-- sqlfmt-corpus-separator --

SELECT to_char(12::int, 'RN')

-- sqlfmt-corpus-separator --

SELECT to_char(1485::int, '9,999')

-- sqlfmt-corpus-separator --

SELECT to_char(1485::int, '9G999')

-- sqlfmt-corpus-separator --

SELECT to_char(1::int, '009')

-- sqlfmt-corpus-separator --

SELECT to_char(1::int, '09')

-- sqlfmt-corpus-separator --

SELECT to_char(1::int, '9')

-- sqlfmt-corpus-separator --

SELECT to_char(1::int, '9.999EEEE')

-- sqlfmt-corpus-separator --

SELECT to_char(1::int, '9TH')

-- sqlfmt-corpus-separator --

SELECT to_char(1::int, '9th')

-- sqlfmt-corpus-separator --

SELECT to_char(1::int, 'B9')

-- sqlfmt-corpus-separator --

SELECT to_char(21::int, '99th')

-- sqlfmt-corpus-separator --

SELECT to_char(2345::int, 'RN')

-- sqlfmt-corpus-separator --

SELECT to_char(2::int, '9th')

-- sqlfmt-corpus-separator --

SELECT to_char(3::int, '9th')

-- sqlfmt-corpus-separator --

SELECT to_char(485::int, '0999')

-- sqlfmt-corpus-separator --

SELECT to_char(485::int, '999')

-- sqlfmt-corpus-separator --

SELECT to_char(485::int, '999MI')

-- sqlfmt-corpus-separator --

SELECT to_char(485::int, '999PR')

-- sqlfmt-corpus-separator --

SELECT to_char(485::int, '999S')

-- sqlfmt-corpus-separator --

SELECT to_char(485::int, 'FM0999')

-- sqlfmt-corpus-separator --

SELECT to_char(485::int, 'FM999')

-- sqlfmt-corpus-separator --

SELECT to_char(485::int, 'S999')

-- sqlfmt-corpus-separator --

SELECT to_char(485::int, 'SG999')

-- sqlfmt-corpus-separator --

SELECT to_char(4::int, '9th')

-- sqlfmt-corpus-separator --

SELECT to_json(1.234::FLOAT)

-- sqlfmt-corpus-separator --

SELECT to_json(123::INT)

-- sqlfmt-corpus-separator --

SELECT to_json(3::OID::INT::OID)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(1.234::FLOAT)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(123::INT)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(3::OID::INT::OID)

-- sqlfmt-corpus-separator --

SELECT token::int FROM u

-- sqlfmt-corpus-separator --

SELECT trim('xy' from 'xyxtrimyyx')

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

SELECT unnest('{1}', '{2}', '{3}'::int[]);

-- sqlfmt-corpus-separator --

SELECT unnest('{1}'::int[], '{2}', '{3}');

-- sqlfmt-corpus-separator --

SELECT unnest('{1}'::int[], '{}', '{}');

-- sqlfmt-corpus-separator --

SELECT unnest('{}', '{}', '{3}'::int[]);

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

SELECT v, count(*) FILTER (WHERE count(*) > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, count(*) FILTER (WHERE k > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, mark, count(*) FILTER (WHERE k > 5), count(*), max(k) FILTER (WHERE k < 8) FROM filter_test GROUP BY v, mark

-- sqlfmt-corpus-separator --

SELECT var_pop(1::int), var_pop(1::float), var_pop(1::decimal)

-- sqlfmt-corpus-separator --

SELECT variance(1::int), variance(1::float), variance(1::decimal)

-- sqlfmt-corpus-separator --

SELECT variance(a+b+c::INT+d), var_pop(a+b+c::INT+d) FROM data

-- sqlfmt-corpus-separator --

SELECT x FROM xyz UNION ALL SELECT x FROM xyz ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM xyz UNION SELECT x FROM xyz ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM xyz WHERE x < 3 UNION SELECT x FROM xyz WHERE x >= 3 ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM xyz WHERE x <= 4 UNION SELECT x FROM xyz WHERE x > 1 ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM xyz WHERE x IN (SELECT x FROM xyz WHERE x = 7)

-- sqlfmt-corpus-separator --

SELECT x, y FROM xyz EXCEPT ALL SELECT y, x from xyz

-- sqlfmt-corpus-separator --

SELECT x, y FROM xyz EXCEPT SELECT y, x from xyz

-- sqlfmt-corpus-separator --

SELECT x, y FROM xyz INTERSECT ALL SELECT y, x from xyz

-- sqlfmt-corpus-separator --

SELECT x, y FROM xyz INTERSECT SELECT y, x from xyz

-- sqlfmt-corpus-separator --

SELECT x, y FROM xyz UNION ALL SELECT y, x from xyz

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

TABLE t130591_1 EXCEPT DISTINCT TABLE t130591_1;

-- sqlfmt-corpus-separator --

TABLE t130591_1 EXCEPT DISTINCT TABLE t130591_2;

-- sqlfmt-corpus-separator --

TABLE t130591_1 EXCEPT TABLE t130591_1;

-- sqlfmt-corpus-separator --

TABLE t130591_1 INTERSECT DISTINCT TABLE t130591_1;

-- sqlfmt-corpus-separator --

TABLE t130591_1 INTERSECT DISTINCT TABLE t130591_2;

-- sqlfmt-corpus-separator --

TABLE t130591_1 INTERSECT TABLE t130591_1;

-- sqlfmt-corpus-separator --

TABLE t130591_1 UNION DISTINCT TABLE t130591_1;

-- sqlfmt-corpus-separator --

TABLE t130591_1 UNION DISTINCT TABLE t130591_2;

-- sqlfmt-corpus-separator --

TABLE t130591_1 UNION TABLE t130591_1;

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
    t AS (SELECT true),
    t AS (SELECT false)
SELECT * FROM t

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

WITH RECURSIVE
   x(id) AS
     (SELECT 1 UNION ALL SELECT id+1 FROM x WHERE id < 3 ),
   y(id) AS
     (SELECT * FROM x UNION ALL SELECT * FROM x)
 SELECT * FROM y

-- sqlfmt-corpus-separator --

WITH RECURSIVE
   y(id) AS (SELECT * FROM t93370 UNION ALL SELECT * FROM t93370)
 SELECT * FROM y

-- sqlfmt-corpus-separator --

WITH RECURSIVE cte(a, b) AS (
    SELECT 0, 0
  UNION ALL
    SELECT a+1, b+10 FROM cte WHERE a < 5
) SELECT * FROM cte;

-- sqlfmt-corpus-separator --

WITH RECURSIVE cte(a, b) AS (
    SELECT 0, 1
  UNION ALL
    SELECT a+1, a+1 FROM cte WHERE a < 5
) SELECT * FROM cte;

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

WITH a AS (
  SELECT extract(YEAR FROM "lastUpdated") AS year
  FROM system.settings WHERE name = 'version'
) SELECT year > 2020 AND year < 2100 FROM a

-- sqlfmt-corpus-separator --

WITH a AS (DELETE FROM a WHERE b IN (4,5) RETURNING a,b)
SELECT * FROM a LIMIT 0

-- sqlfmt-corpus-separator --

WITH a AS (INSERT INTO a VALUES (2,3), (3,4) RETURNING a,b)
SELECT * FROM a LIMIT 0

-- sqlfmt-corpus-separator --

WITH a AS (SELECT a FROM ab ORDER BY b) SELECT * FROM a

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

WITH bar AS (SELECT 2) SELECT f(), * FROM bar;

-- sqlfmt-corpus-separator --

WITH cte (a, b) AS (SELECT random(), random())
SELECT count(*) FROM cte WHERE a = b

-- sqlfmt-corpus-separator --

WITH cte (x, a, b) AS (SELECT x, random(), random() FROM (VALUES (1), (2), (3)) AS v(x))
SELECT count(*) FROM cte WHERE a = b

-- sqlfmt-corpus-separator --

WITH cte AS (
  SELECT job_type, description
  FROM crdb_internal.jobs
  WHERE (job_type = 'NEW SCHEMA CHANGE' OR job_type = 'SCHEMA CHANGE GC')
  AND (status = 'succeeded' OR status = 'running')
  AND (description LIKE '%DROP%')
  ORDER BY created DESC
) SELECT * FROM cte ORDER BY job_type, description

-- sqlfmt-corpus-separator --

WITH cte AS (SELECT x*10+y FROM xy ORDER BY x+y LIMIT 3) SELECT * FROM cte

-- sqlfmt-corpus-separator --

WITH cte(col) AS (
  VALUES
    ('false'::JSONB),
    (jsonb_object(ARRAY['0', '', e'\x14', '']::TEXT[]))
  )
SELECT jsonb_object_agg('k', 'v') OVER (PARTITION BY cte.col) FROM cte;

-- sqlfmt-corpus-separator --

WITH cte(col) AS (SELECT random()) SELECT col, random() FROM cte

-- sqlfmt-corpus-separator --

WITH cte(s) AS (SELECT NULL::TSQUERY) SELECT a FROM a, cte WHERE a @@ s;

-- sqlfmt-corpus-separator --

WITH foo AS (DELETE FROM z RETURNING 1) SELECT 4

-- sqlfmt-corpus-separator --

WITH foo AS (INSERT INTO t1 VALUES (1, 2) RETURNING a) SELECT insert_t1();

-- sqlfmt-corpus-separator --

WITH foo AS (INSERT INTO t2 VALUES (1, 1) RETURNING a) SELECT insert_t1();

-- sqlfmt-corpus-separator --

WITH foo AS (INSERT INTO z VALUES (10) RETURNING 1) SELECT 2

-- sqlfmt-corpus-separator --

WITH foo AS (SELECT 2) SELECT f(), * FROM foo;

-- sqlfmt-corpus-separator --

WITH foo AS (SELECT insert_t1()) SELECT insert_t1();

-- sqlfmt-corpus-separator --

WITH foo AS (UPDATE t2 SET b = 1 WHERE a = 1 RETURNING a) SELECT insert_t1();

-- sqlfmt-corpus-separator --

WITH foo AS (UPDATE z SET c = 20 RETURNING 1) SELECT 3

-- sqlfmt-corpus-separator --

WITH geometry AS
(
	SELECT ST_AsMVTGeom(
		ST_GeomFromText('POLYGON((5 0, 0 5, 0 0, 5 5, 5 0))'),
		ST_MakeBox2D(ST_Point(0, 0), ST_Point(5, 5)),
		5, 0, true) as g
)
SELECT  'PG9.1', ST_NumGeometries(g), ST_Area(g), ST_AsText(g) LIKE '%2.5%'as fvalue FROM geometry;

-- sqlfmt-corpus-separator --

WITH geometry AS
(
    SELECT ST_AsText(ST_AsMVTGeom(
	ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(10 10, 20 20), POLYGON((110 90, 110 110, 90 110, 90 90, 110 90)), LINESTRING(20 20, 15 15))'),
	ST_MakeBox2D(ST_Point(0, 0), ST_Point(100, 100)),
	100, 0, true)) as g
)
SELECT 'PG63',
        ST_Area(g),
        g = 'POLYGON ((90 10, 90 0, 100 0, 100 10, 90 10))' OR g = 'POLYGON ((90 0, 100 0, 100 10, 90 10, 90 0))'
FROM geometry;

-- sqlfmt-corpus-separator --

WITH geometry AS
(
    SELECT ST_AsText(ST_Normalize(ST_AsMVTGeom(
	ST_GeomFromText('POLYGON((0 0, 0 99, 1 101, 100 100, 100 0, 0 0))'),
	ST_MakeBox2D(ST_Point(0, 0), ST_Point(100, 100)),
	100, 0, true))) as g
)
SELECT 'PG57',
        g = 'POLYGON ((0 1, 0 100, 100 100, 100 0, 1 0, 0 1))'
        OR g = 'POLYGON ((0 0, 0 1, 0 100, 100 100, 100 0, 0 0))'
        OR g = 'POLYGON ((0 0, 0 100, 100 100, 100 0, 0 0))'
FROM geometry;

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

WITH s AS
  (SELECT aisle FROM supermarket WHERE person = 'matilda' FOR UPDATE)
SELECT aisle + 1 FROM s

-- sqlfmt-corpus-separator --

WITH schema_names(schema_name) AS (
   SELECT n.nspname AS schema_name
     FROM pg_catalog.pg_namespace n
) SELECT IF(schema_name LIKE 'pg_temp%', 'pg_temp', schema_name) AS schema_name,
  pg_catalog.has_schema_privilege('testuser2', schema_name, 'CREATE') AS has_create,
  pg_catalog.has_schema_privilege('testuser2', schema_name, 'USAGE') AS has_usage
FROM schema_names

-- sqlfmt-corpus-separator --

WITH settings AS (
    SELECT
      (crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'numReplicas') AS replicas,
      ((crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'gc') ->> 'ttlSeconds')::INT AS ttl
    FROM system.zones
    -- 16 is the ID for the meta range
    WHERE id = 16
)
SELECT *
FROM settings;

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

WITH subzone_spans AS (
    SELECT json_array_elements(crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'subzoneSpans') ->> 'key' AS key
    FROM system.zones
    WHERE id = 'bar'::REGCLASS::OID
)
SELECT crdb_internal.pretty_key(decode(key, 'base64'), 0) AS pretty_key
FROM subzone_spans;

-- sqlfmt-corpus-separator --

WITH subzone_spans AS (
    SELECT json_array_elements(crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'subzoneSpans') ->> 'key' AS key
    FROM system.zones
    WHERE id = 'foo'::REGCLASS::OID
)
SELECT crdb_internal.pretty_key(decode(key, 'base64'), 0)
FROM subzone_spans
ORDER BY 1

-- sqlfmt-corpus-separator --

WITH subzone_spans AS (
    SELECT json_array_elements(crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'subzoneSpans') ->> 'key' AS key
    FROM system.zones
    WHERE id = 'regional_by_row_add_drop_col'::REGCLASS::OID
),
primary_index AS (
    SELECT
        (crdb_internal.pb_to_json(
            'cockroach.sql.sqlbase.Descriptor',
            descriptor
        )->'table'->'primaryIndex'->>'id')::INT AS primaryID
    FROM system.descriptor
    WHERE id = 'regional_by_row_add_drop_col'::regclass::oid
)
SELECT
  crdb_internal.pretty_key(decode(key, 'base64'), 0) AS subzone_span
FROM subzone_spans, primary_index
WHERE crdb_internal.pretty_key(decode(key, 'base64'), 0) LIKE ('/' || primaryID::STRING || '/%')
ORDER By subzone_span;

-- sqlfmt-corpus-separator --

WITH subzone_spans AS (
    SELECT json_array_elements(crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'subzoneSpans') ->> 'key' AS key
    FROM system.zones
    WHERE id = 'regional_by_row_add_drop_col'::REGCLASS::OID
),
secondary_indexes AS (
    SELECT
        json_array_elements(crdb_internal.pb_to_json(
            'cockroach.sql.sqlbase.Descriptor',
            descriptor
        )->'table'->'indexes') AS secondary_index
    FROM system.descriptor
    WHERE id = 'regional_by_row_add_drop_col'::regclass::oid
)
SELECT
  crdb_internal.pretty_key(decode(key, 'base64'), 0) AS subzone_span
FROM subzone_spans, secondary_indexes
WHERE crdb_internal.pretty_key(decode(key, 'base64'), 0) LIKE ('/' || (secondary_index->'id')::STRING || '/%')
ORDER By subzone_span;

-- sqlfmt-corpus-separator --

WITH subzones AS (
    SELECT
        json_array_elements(
            crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'subzones'
        ) AS config
    FROM system.zones
    WHERE id = 'foo'::REGCLASS::OID
),
subzone_indexes AS (
    SELECT
        (config -> 'indexId')::INT AS indexID
    FROM subzones
)
SELECT indexID
FROM subzone_indexes
ORDER BY indexID;

-- sqlfmt-corpus-separator --

WITH subzones AS (
    SELECT
        json_array_elements(
            crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'subzones'
        ) AS config
    FROM system.zones
    WHERE id = 'foo'::REGCLASS::OID
),
subzone_indexes AS (
    SELECT
        (config -> 'indexId')::INT AS indexID
    FROM subzones
),
primary_index AS (
    SELECT
        (crdb_internal.pb_to_json(
            'cockroach.sql.sqlbase.Descriptor',
            descriptor
        )->'table'->'primaryIndex'->>'id')::INT AS primaryID
    FROM system.descriptor
    WHERE id = 'foo'::regclass::oid
),
index_ids_match AS (
  SELECT EXISTS (
      SELECT 1
      FROM primary_index, subzone_indexes
      WHERE primaryID = indexID
  ) AS match_found
)
SELECT crdb_internal.force_error('', 'expected IDs to match')
FROM index_ids_match WHERE match_found = false;

-- sqlfmt-corpus-separator --

WITH subzones AS (
    SELECT
        json_array_elements(
            crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'subzones'
        ) AS config
    FROM system.zones
    WHERE id = 'person'::REGCLASS::OID
),
subzone_configs AS (
    SELECT
        config ->> 'partitionName' AS name,
        (config -> 'config' -> 'gc' ->> 'ttlSeconds')::INT AS ttl
    FROM subzones
)
SELECT *
FROM subzone_configs
ORDER BY name;

-- sqlfmt-corpus-separator --

WITH subzones AS (
    SELECT
        json_array_elements(
            crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'subzones'
        ) AS config
    FROM system.zones
    WHERE id = 'regional_by_row_add_drop_col'::REGCLASS::OID
),
subzone_indexes AS (
    SELECT
        (config -> 'indexId')::INT AS indexID
    FROM subzones
),
primary_index AS (
    SELECT
        (crdb_internal.pb_to_json(
            'cockroach.sql.sqlbase.Descriptor',
            descriptor
        )->'table'->'primaryIndex'->>'id')::INT AS primaryID
    FROM system.descriptor
    WHERE id = 'regional_by_row_add_drop_col'::regclass::oid
),
primary_idx_matches_subzone_idx AS (
  SELECT EXISTS (
      SELECT 1
      FROM primary_index, subzone_indexes
      WHERE primaryID = indexID
  ) AS match_found
)
SELECT crdb_internal.force_error('', 'expected IDs to match')
FROM primary_idx_matches_subzone_idx WHERE match_found = false;

-- sqlfmt-corpus-separator --

WITH subzones AS (
    SELECT
        json_array_elements(
            crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'subzones'
        ) AS config
    FROM system.zones
    WHERE id = 'regional_by_row_add_drop_col'::REGCLASS::OID
),
subzone_indexes AS (
    SELECT
        (config -> 'indexId')::INT AS index_id,
        (config -> 'partitionName')::STRING AS partition_name
    FROM subzones
)
SELECT index_id, partition_name FROM subzone_indexes ORDER BY index_id, partition_name;

-- sqlfmt-corpus-separator --

WITH subzones AS (
    SELECT
        json_array_elements(
            crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'subzones'
        ) AS config
    FROM system.zones
    WHERE id = 't'::REGCLASS::OID
),
subzone_configs AS (
    SELECT
        (config -> 'config' ->> 'numReplicas')::INT AS replicas
    FROM subzones
)
SELECT *
FROM subzone_configs

-- sqlfmt-corpus-separator --

WITH subzones AS (
    SELECT
        json_array_elements(
            crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'subzones'
        ) AS config
    FROM system.zones
    WHERE id = 't'::REGCLASS::OID
),
subzone_indexes AS (
    SELECT
        (config -> 'indexId')::INT AS indexID
    FROM subzones
),
primary_index AS (
    SELECT
        (crdb_internal.pb_to_json(
            'cockroach.sql.sqlbase.Descriptor',
            descriptor
        )->'table'->'primaryIndex'->>'id')::INT AS primaryID
    FROM system.descriptor
    WHERE id = 't'::regclass::oid
)
SELECT
    (primaryID = indexID) AS match_found
FROM primary_index, subzone_indexes;

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

WITH t AS (
   SELECT json_array_elements(crdb_internal.pb_to_json('cockroach.sql.sqlbase.Descriptor', descriptor)
     -> 'database'
     -> 'defaultPrivileges'
     -> 'defaultPrivilegesPerRole') AS default_privs_per_role
   FROM system.descriptor
   WHERE id = (SELECT oid FROM pg_database WHERE datname = 'test2')
) SELECT
  default_privs_per_role->'defaultPrivilegesPerObject'->'1'->'users' AS grantees,
  default_privs_per_role->'explicitRole'->'userProto' AS role
 FROM t
ORDER BY role;

-- sqlfmt-corpus-separator --

WITH t AS (SELECT 1) SELECT 2

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

WITH t(x) AS (SELECT a FROM x)
  SELECT * FROM y WHERE a IN (SELECT x FROM t)

-- sqlfmt-corpus-separator --

WITH t(x) AS (WITH t(x) AS (SELECT 1) SELECT x * 10 FROM t) SELECT x + 2 FROM t

-- sqlfmt-corpus-separator --

WITH t3(c1, c2) AS (
  SELECT t2.b AS c1, t2.k AS c2 FROM t100561a t1 FULL OUTER JOIN t100561b t2 ON true
)
SELECT t3.c2, t3.c1 FROM t3, t100561b t2
WHERE t3.c2 = t2.k

-- sqlfmt-corpus-separator --

WITH tbl(pk, i, pg, iso, sql_std, default_style) AS (
  SELECT
    pk,
    i,
    to_char_with_style(i, 'postgres') AS pg,
    to_char_with_style(i, 'iso_8601') AS iso,
    to_char_with_style(i, 'sql_standard') AS sql_std,
    to_char(i) AS default_style
  FROM intervals
)
SELECT
  pg,
  iso,
  sql_std,
  default_style,
  i = parse_interval(pg, 'postgres'),
  i = parse_interval(iso, 'iso_8601'),
  i = parse_interval(sql_std, 'sql_standard'),
  i = parse_interval(default_style) AND pg = default_style
FROM tbl
ORDER BY pk

-- sqlfmt-corpus-separator --

WITH tmp AS (
  SELECT "eventType" AS etype, info::JSONB AS info_json
  FROM system.eventlog
  WHERE "eventType" = 'alter_function_options'
)
SELECT etype, info_json->'DescriptorID', info_json->'FunctionName', info_json->'Statement' FROM tmp;

-- sqlfmt-corpus-separator --

WITH tmp AS (
  SELECT "eventType" AS etype, info::JSONB AS info_json
  FROM system.eventlog
  WHERE "eventType" = 'alter_function_owner'
)
SELECT etype, info_json->'DescriptorID', info_json->'FunctionName', info_json->'Owner', info_json->'Statement' FROM tmp;

-- sqlfmt-corpus-separator --

WITH tmp AS (
  SELECT "eventType" AS etype, info::JSONB AS info_json
  FROM system.eventlog
  WHERE "eventType" = 'create_function'
)
SELECT etype, info_json->'DescriptorID', info_json->'FunctionName', info_json->'Statement'
FROM tmp
ORDER BY 4

-- sqlfmt-corpus-separator --

WITH tmp AS (
  SELECT "eventType" AS etype, info::JSONB AS info_json
  FROM system.eventlog
  WHERE "eventType" = 'create_function'
)
SELECT etype, info_json->'DescriptorID', info_json->'FunctionName', info_json->'Statement' FROM tmp;

-- sqlfmt-corpus-separator --

WITH tmp AS (
  SELECT "eventType" AS etype, info::JSONB AS info_json
  FROM system.eventlog
  WHERE "eventType" = 'drop_function'
)
SELECT etype, info_json->'DescriptorID', info_json->'FunctionName', info_json->'Statement' FROM tmp;

-- sqlfmt-corpus-separator --

WITH tmp AS (
  SELECT "eventType" AS etype, info::JSONB AS info_json
  FROM system.eventlog
  WHERE "eventType" = 'rename_function'
)
SELECT etype, info_json->'DescriptorID', info_json->'FunctionName', info_json->'NewFunctionName', info_json->'Statement' FROM tmp;

-- sqlfmt-corpus-separator --

WITH tmp AS (
  SELECT "eventType" AS etype, info::JSONB AS info_json
  FROM system.eventlog
  WHERE "eventType" = 'set_schema'
)
SELECT etype, info_json->'DescriptorID', info_json->'DescriptorName', info_json->'NewDescriptorName', info_json->'Statement' FROM tmp;

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

-- sqlfmt-corpus-separator --

select
  extract('hour' from '11:12+03:01'::timetz)::string || ':' ||
  extract('minute' from '11:12+03:01'::timetz)::string || 'Z' ||
  extract('timezone_hour' from '11:12+03:01'::timetz)::string || ':' ||
  extract('timezone_minute' from '11:12+03:01'::timetz)::string

-- sqlfmt-corpus-separator --

select
  extract('hour' from '11:12-03:01'::timetz)::string || ':' ||
  extract('minute' from '11:12-03:01'::timetz)::string || 'Z' ||
  extract('timezone_hour' from '11:12-03:01'::timetz)::string || ':' ||
  extract('timezone_minute' from '11:12-03:01'::timetz)::string

-- sqlfmt-corpus-separator --

select 1 < 2.0::float, 1.0::float < 2, 2.0::float < 1, 2 < 1.0::float

-- sqlfmt-corpus-separator --

select 1 <= 1.0::float, 1.0::float <= 1, 2.0::float <= 1, 2 <= 1.0::float

-- sqlfmt-corpus-separator --

select 1 = 1.0::float, 1.0::float = 1, 1 = 2.0::float, 2.0::float = 1

-- sqlfmt-corpus-separator --

select 1 >= 1.0::float, 1.0::float >= 1, 1.0::float >= 2, 1 >= 2.0::float

-- sqlfmt-corpus-separator --

select 2 > 1.0::float, 2.0::float > 1, 1 > 2.0::float, 1.0::float > 2

-- sqlfmt-corpus-separator --

select extract(day from '2019-01-15'::date) as final

-- sqlfmt-corpus-separator --

select oid::INT, polname, polrelid::INT, polcmd, polpermissive, polroles::string, polqual, polwithcheck from pg_catalog.pg_policy

-- sqlfmt-corpus-separator --

select oid::INT, polname, polrelid::INT, polcmd, polpermissive, polroles::string, polqual, polwithcheck from pg_catalog.pg_policy WHERE polrelid = 'multi_pol_tab2'::regclass

-- sqlfmt-corpus-separator --

select oid::INT, polname, polrelid::INT, polcmd, polpermissive, polroles::string, polqual, polwithcheck from pg_catalog.pg_policy WHERE polrelid = 'multi_pol_tab3'::regclass