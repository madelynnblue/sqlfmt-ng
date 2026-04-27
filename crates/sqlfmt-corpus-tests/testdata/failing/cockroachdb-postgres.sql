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

SELECT "LOWERCASE_HINT_ERROR_IMPLICIT_SCHEMA_FN"();

-- sqlfmt-corpus-separator --

SELECT "PG_TYPEOF"(123)

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

SELECT (WITH foo AS (INSERT INTO y VALUES (1) RETURNING *) SELECT * FROM foo)

-- sqlfmt-corpus-separator --

SELECT (rank() OVER wind + lead(k, 3, v) OVER wind + lag(w, 1, 2) OVER wind), (row_number() OVER wind + dense_rank() OVER wind) FROM kv WINDOW wind as (PARTITION BY v ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT (round(avg(k) OVER w1 + sum(w) OVER w2) + row_number() OVER w2 + d + min(d) OVER w3 + f::DECIMAL) AS big_sum, v + w AS v_plus_w, (rank() OVER w3 + first_value(d) OVER w1 + nth_value(k, 2) OVER w1) AS small_sum FROM kv WINDOW w1 AS (PARTITION BY b ORDER BY k), w2 AS (PARTITION BY w ORDER BY k), w3 AS (PARTITION BY v ORDER BY k) ORDER BY k

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

SELECT * FROM ab WHERE (a, b) IN (SELECT x+1, y+1 FROM xy);

-- sqlfmt-corpus-separator --

SELECT * FROM ab WHERE ROW(ROW(a, b)) IN (SELECT x+1 FROM xy);

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = ANY(SELECT a FROM abc WHERE b = 10)

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE bill = ANY(SELECT ship FROM o);

-- sqlfmt-corpus-separator --

SELECT * FROM f_insert_select(5,6) AS t1(a INT, b INT) UNION ALL SELECT * FROM f_insert_select(7,8) AS t2(a INT, b INT)

-- sqlfmt-corpus-separator --

SELECT * FROM foo FOR SHARE OF foo SKIP LOCKED

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE (k,v) IN (SELECT * FROM kv)

-- sqlfmt-corpus-separator --

SELECT * FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY avg(k) OVER w DESC, k

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR SHARE FOR UPDATE OF t NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM t FOR SHARE NOWAIT FOR UPDATE OF t

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

SELECT *, avg(k) OVER (w ORDER BY w) FROM kv WINDOW w AS (PARTITION BY v) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT *, avg(k) OVER w FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY avg(k) OVER w, k

-- sqlfmt-corpus-separator --

SELECT 1 = ANY(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 = SOME(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 FOR SHARE OF a, b

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

SELECT ARRAY(VALUES (ARRAY[1]))

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(((x)), (x, y)) x, y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz ORDER BY row_number() OVER(ORDER BY (pk1, pk2)) DESC

-- sqlfmt-corpus-separator --

SELECT array_agg(a) OVER (w GROUPS 1 PRECEDING) FROM x WINDOW w AS (PARTITION BY a ORDER BY a DESC) ORDER BY a

-- sqlfmt-corpus-separator --

SELECT array_agg(a) OVER (w RANGE 1 PRECEDING) FROM x WINDOW w AS (ORDER BY a DESC) ORDER BY a

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (w ORDER BY w) FROM kv WINDOW w AS (PARTITION BY v) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (w) FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (x) FROM kv WINDOW w AS ()

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER w FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER w, avg(k) OVER w + 1 FROM kv WINDOW w AS (PARTITION BY v ORDER BY w) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT avg(price) FILTER (WHERE price > 300) OVER w1, sum(price) FILTER (WHERE group_name = 'Smartphone') OVER w2, avg(price) FILTER (WHERE price = 200 OR price = 700) OVER w1, avg(price) FILTER (WHERE price < 900) OVER w2 FROM products WINDOW w1 AS (ORDER BY group_id), w2 AS (PARTITION BY group_name ORDER BY price, group_id) ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (w) FROM products WINDOW w AS (ROWS 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER w1, avg(price) OVER w2, avg(price) OVER w1 FROM products WINDOW w1 AS (PARTITION BY group_name ORDER BY group_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), w2 AS (ORDER BY group_id ROWS 1 PRECEDING) ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT d3,d1,d2 FROM d WHERE (d1,d3) NOT IN (SELECT b1,b2 FROM b WHERE EXISTS (SELECT 1 FROM c WHERE c2=b2 OR c2=b3))

-- sqlfmt-corpus-separator --

SELECT f::DECIMAL + round(max(k) * w * avg(d) OVER wind) + (lead(f, 2, 17::FLOAT) OVER wind::DECIMAL / d * row_number() OVER wind) FROM kv GROUP BY k, w, f, d WINDOW wind AS (ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, array_agg(price) OVER (w ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), array_agg(price) OVER (w ROWS BETWEEN UNBOUNDED PRECEDING AND 3 FOLLOWING), array_agg(price) OVER (w GROUPS BETWEEN 3 PRECEDING AND UNBOUNDED FOLLOWING), array_agg(price) OVER (w RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) FROM products WINDOW w AS (PARTITION BY group_name ORDER BY group_id DESC) ORDER BY group_id

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

SELECT k, stddev(d) OVER w FROM kv WINDOW w as (PARTITION BY v) ORDER BY variance(d) OVER w, k

-- sqlfmt-corpus-separator --

SELECT k, v + w, round(rank() OVER wind + lead(k, 3, v) OVER wind + lag(w, 1, 2) OVER wind + f::DECIMAL + avg(d) OVER wind)::INT, round(row_number() OVER wind::FLOAT + round(f) + dense_rank() OVER wind::FLOAT)::INT FROM kv WINDOW wind as (PARTITION BY v ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT price, dense_rank() OVER w, avg(price) OVER (w GROUPS BETWEEN 0 PRECEDING AND 0 PRECEDING), avg(price) OVER (w GROUPS BETWEEN 0 PRECEDING AND CURRENT ROW), avg(price) OVER (w GROUPS BETWEEN 0 PRECEDING AND 0 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN CURRENT ROW AND CURRENT ROW), avg(price) OVER (w GROUPS BETWEEN CURRENT ROW AND 2 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN CURRENT ROW AND 100 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) FROM products WINDOW w AS (ORDER BY price) ORDER BY price

-- sqlfmt-corpus-separator --

SELECT price, dense_rank() OVER w, avg(price) OVER (w GROUPS BETWEEN 3 FOLLOWING AND 100 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 3 FOLLOWING AND 1 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 2 FOLLOWING AND 6 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 3 FOLLOWING AND 3 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 0 FOLLOWING AND 4 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 5 FOLLOWING AND UNBOUNDED FOLLOWING) FROM products WINDOW w AS (ORDER BY price) ORDER BY price

-- sqlfmt-corpus-separator --

SELECT price, dense_rank() OVER w, avg(price) OVER (w GROUPS BETWEEN 4 PRECEDING AND 100 PRECEDING), avg(price) OVER (w GROUPS BETWEEN 3 PRECEDING AND 2 PRECEDING), avg(price) OVER (w GROUPS BETWEEN 2 PRECEDING AND CURRENT ROW), avg(price) OVER (w GROUPS BETWEEN 1 PRECEDING AND 2 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 1 PRECEDING AND 100 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING) FROM products WINDOW w AS (ORDER BY price) ORDER BY price

-- sqlfmt-corpus-separator --

SELECT price, dense_rank() OVER w, avg(price) OVER (w GROUPS BETWEEN UNBOUNDED PRECEDING AND 100 PRECEDING), avg(price) OVER (w GROUPS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING), avg(price) OVER (w GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), avg(price) OVER (w GROUPS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN UNBOUNDED PRECEDING AND 100 FOLLOWING), avg(price) OVER (w GROUPS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) FROM products WINDOW w AS (ORDER BY price) ORDER BY price

-- sqlfmt-corpus-separator --

SELECT product_name, price, first_value(product_name) OVER w AS first FROM products WHERE price = 200 OR price = 700 WINDOW w as (PARTITION BY price ORDER BY product_name RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) ORDER BY price, product_name

-- sqlfmt-corpus-separator --

SELECT product_name, price, last_value(product_name) OVER w AS last FROM products WHERE price = 200 OR price = 700 WINDOW w as (PARTITION BY price ORDER BY product_name RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) ORDER BY price, product_name

-- sqlfmt-corpus-separator --

SELECT product_name, price, nth_value(product_name, 2) OVER w AS second FROM products WHERE price = 200 OR price = 700 WINDOW w as (PARTITION BY price ORDER BY product_name RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) ORDER BY price, product_name

-- sqlfmt-corpus-separator --

SELECT public."LOWERCASE_HINT_ERROR_EXPLICIT_SCHEMA_FN"();

-- sqlfmt-corpus-separator --

SELECT round((avg(d) OVER wind) * max(k) + (lag(d, 1, 42.0) OVER wind) * max(d)) FROM kv GROUP BY d, k WINDOW wind AS (ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT round(max(w) * w * avg(w) OVER wind) + (lead(w, 2, 17) OVER wind::DECIMAL / w * row_number() OVER wind) FROM kv GROUP BY w WINDOW wind AS (PARTITION BY w) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT round(row_number() OVER w1 + lead(k, v, w) OVER w2 + avg(k) OVER w1), (lag(k, 1) OVER w1 + v + rank() OVER w2 + min(k) OVER w1) FROM kv WINDOW w1 AS (PARTITION BY w ORDER BY k), w2 AS (PARTITION BY b ORDER BY k) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT s, w + k, (sum(w) OVER wind + avg(d) OVER wind), (min(w) OVER wind + d), v FROM kv WINDOW wind AS (ORDER BY w, k) ORDER BY k

-- sqlfmt-corpus-separator --

WITH
    a AS (INSERT INTO y VALUES (1) RETURNING 1), b AS (DELETE FROM x WHERE true RETURNING 1)
SELECT
    *
FROM
    a

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

WITH a AS (DELETE FROM a WHERE b IN (4,5) RETURNING a,b)
SELECT * FROM a LIMIT 0

-- sqlfmt-corpus-separator --

WITH a AS (INSERT INTO a VALUES (2,3), (3,4) RETURNING a,b)
SELECT * FROM a LIMIT 0

-- sqlfmt-corpus-separator --

WITH a AS (UPDATE a SET a = -a WHERE b % 2 = 1 RETURNING a,b)
SELECT * FROM a LIMIT 0

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