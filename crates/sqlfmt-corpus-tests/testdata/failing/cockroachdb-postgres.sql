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

SELECT * FROM kv WHERE (k,v) IN (SELECT * FROM kv)

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

SELECT 1 = ANY(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 = SOME(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT ARRAY(VALUES (ARRAY[1]))

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(((x)), (x, y)) x, y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz ORDER BY row_number() OVER(ORDER BY (pk1, pk2)) DESC

-- sqlfmt-corpus-separator --

SELECT d3,d1,d2 FROM d WHERE (d1,d3) NOT IN (SELECT b1,b2 FROM b WHERE EXISTS (SELECT 1 FROM c WHERE c2=b2 OR c2=b3))

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