SELECT (1, 2) = ANY(SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT (1, 2) = SOME(SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = ANY(SELECT a FROM abc WHERE b = 10)

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE bill = ANY(SELECT ship FROM o);

-- sqlfmt-corpus-separator --

SELECT 1 = ANY(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 = SOME(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT ARRAY(VALUES (ARRAY[1]))

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

WITH cte(col) AS (
  VALUES
    ('false'::JSONB),
    (jsonb_object(ARRAY['0', '', e'\x14', '']::TEXT[]))
  )
SELECT jsonb_object_agg('k', 'v') OVER (PARTITION BY cte.col) FROM cte;

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