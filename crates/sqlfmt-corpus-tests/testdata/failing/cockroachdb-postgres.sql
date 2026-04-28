INSERT
INTO
    regional_by_row_table_as4
SELECT
    g, g
FROM
    ROWS FROM (generate_series(1, 1000)) AS g (g)

-- sqlfmt-corpus-separator --

INSERT INTO kv (k.*) VALUES ('hello')

-- sqlfmt-corpus-separator --

INSERT INTO kv (k.v) VALUES ('hello')

-- sqlfmt-corpus-separator --

INSERT INTO kv (kv.k) VALUES ('hello')

-- sqlfmt-corpus-separator --

SELECT
  c.relname AS index_name,
  k.ord AS seq,
  a.attname AS column_name,
  ic.implicit
FROM pg_index i
JOIN pg_class c ON c.oid = i.indexrelid
JOIN pg_class t ON t.oid = i.indrelid
CROSS JOIN LATERAL unnest(i.indkey) WITH ORDINALITY AS k(attnum, ord)
JOIN pg_attribute a ON a.attrelid = i.indrelid AND a.attnum = k.attnum
JOIN crdb_internal.index_columns ic
  ON ic.descriptor_name = t.relname
  AND ic.index_name = c.relname
  AND ic.column_name = a.attname
WHERE t.relname = 't1' AND ic.column_type = 'key'
ORDER BY index_name, seq

-- sqlfmt-corpus-separator --

SELECT
  c.relname AS index_name,
  k.ord AS seq,
  a.attname AS column_name,
  ic.implicit
FROM pg_index i
JOIN pg_class c ON c.oid = i.indexrelid
JOIN pg_class t ON t.oid = i.indrelid
CROSS JOIN LATERAL unnest(i.indkey) WITH ORDINALITY AS k(attnum, ord)
JOIN pg_attribute a ON a.attrelid = i.indrelid AND a.attnum = k.attnum
JOIN crdb_internal.index_columns ic
  ON ic.descriptor_name = t.relname
  AND ic.index_name = c.relname
  AND ic.column_name = a.attname
WHERE t.relname = 't10' AND ic.column_type = 'key'
ORDER BY index_name, seq

-- sqlfmt-corpus-separator --

SELECT
  c.relname AS index_name,
  k.ord AS seq,
  a.attname AS column_name,
  ic.implicit
FROM pg_index i
JOIN pg_class c ON c.oid = i.indexrelid
JOIN pg_class t ON t.oid = i.indrelid
CROSS JOIN LATERAL unnest(i.indkey) WITH ORDINALITY AS k(attnum, ord)
JOIN pg_attribute a ON a.attrelid = i.indrelid AND a.attnum = k.attnum
JOIN crdb_internal.index_columns ic
  ON ic.descriptor_name = t.relname
  AND ic.index_name = c.relname
  AND ic.column_name = a.attname
WHERE t.relname = 't11' AND ic.column_type = 'key'
ORDER BY index_name, seq

-- sqlfmt-corpus-separator --

SELECT
  c.relname AS index_name,
  k.ord AS seq,
  a.attname AS column_name,
  ic.implicit
FROM pg_index i
JOIN pg_class c ON c.oid = i.indexrelid
JOIN pg_class t ON t.oid = i.indrelid
CROSS JOIN LATERAL unnest(i.indkey) WITH ORDINALITY AS k(attnum, ord)
JOIN pg_attribute a ON a.attrelid = i.indrelid AND a.attnum = k.attnum
JOIN crdb_internal.index_columns ic
  ON ic.descriptor_name = t.relname
  AND ic.index_name = c.relname
  AND ic.column_name = a.attname
WHERE t.relname = 't12' AND ic.column_type = 'key'
ORDER BY index_name, seq

-- sqlfmt-corpus-separator --

SELECT
  c.relname AS index_name,
  k.ord AS seq,
  a.attname AS column_name,
  ic.implicit
FROM pg_index i
JOIN pg_class c ON c.oid = i.indexrelid
JOIN pg_class t ON t.oid = i.indrelid
CROSS JOIN LATERAL unnest(i.indkey) WITH ORDINALITY AS k(attnum, ord)
JOIN pg_attribute a ON a.attrelid = i.indrelid AND a.attnum = k.attnum
JOIN crdb_internal.index_columns ic
  ON ic.descriptor_name = t.relname
  AND ic.index_name = c.relname
  AND ic.column_name = a.attname
WHERE t.relname = 't2' AND ic.column_type = 'key'
ORDER BY index_name, seq

-- sqlfmt-corpus-separator --

SELECT
  c.relname AS index_name,
  k.ord AS seq,
  a.attname AS column_name,
  ic.implicit
FROM pg_index i
JOIN pg_class c ON c.oid = i.indexrelid
JOIN pg_class t ON t.oid = i.indrelid
CROSS JOIN LATERAL unnest(i.indkey) WITH ORDINALITY AS k(attnum, ord)
JOIN pg_attribute a ON a.attrelid = i.indrelid AND a.attnum = k.attnum
JOIN crdb_internal.index_columns ic
  ON ic.descriptor_name = t.relname
  AND ic.index_name = c.relname
  AND ic.column_name = a.attname
WHERE t.relname = 't3' AND ic.column_type = 'key'
ORDER BY index_name, seq

-- sqlfmt-corpus-separator --

SELECT
  c.relname AS index_name,
  k.ord AS seq,
  a.attname AS column_name,
  ic.implicit
FROM pg_index i
JOIN pg_class c ON c.oid = i.indexrelid
JOIN pg_class t ON t.oid = i.indrelid
CROSS JOIN LATERAL unnest(i.indkey) WITH ORDINALITY AS k(attnum, ord)
JOIN pg_attribute a ON a.attrelid = i.indrelid AND a.attnum = k.attnum
JOIN crdb_internal.index_columns ic
  ON ic.descriptor_name = t.relname
  AND ic.index_name = c.relname
  AND ic.column_name = a.attname
WHERE t.relname = 't4' AND ic.column_type = 'key'
ORDER BY index_name, seq

-- sqlfmt-corpus-separator --

SELECT
  c.relname AS index_name,
  k.ord AS seq,
  a.attname AS column_name,
  ic.implicit
FROM pg_index i
JOIN pg_class c ON c.oid = i.indexrelid
JOIN pg_class t ON t.oid = i.indrelid
CROSS JOIN LATERAL unnest(i.indkey) WITH ORDINALITY AS k(attnum, ord)
JOIN pg_attribute a ON a.attrelid = i.indrelid AND a.attnum = k.attnum
JOIN crdb_internal.index_columns ic
  ON ic.descriptor_name = t.relname
  AND ic.index_name = c.relname
  AND ic.column_name = a.attname
WHERE t.relname = 't5' AND ic.column_type = 'key'
ORDER BY index_name, seq

-- sqlfmt-corpus-separator --

SELECT
  c.relname AS index_name,
  k.ord AS seq,
  a.attname AS column_name,
  ic.implicit
FROM pg_index i
JOIN pg_class c ON c.oid = i.indexrelid
JOIN pg_class t ON t.oid = i.indrelid
CROSS JOIN LATERAL unnest(i.indkey) WITH ORDINALITY AS k(attnum, ord)
JOIN pg_attribute a ON a.attrelid = i.indrelid AND a.attnum = k.attnum
JOIN crdb_internal.index_columns ic
  ON ic.descriptor_name = t.relname
  AND ic.index_name = c.relname
  AND ic.column_name = a.attname
WHERE t.relname = 't6' AND ic.column_type = 'key'
ORDER BY index_name, seq

-- sqlfmt-corpus-separator --

SELECT
  c.relname AS index_name,
  k.ord AS seq,
  a.attname AS column_name,
  ic.implicit
FROM pg_index i
JOIN pg_class c ON c.oid = i.indexrelid
JOIN pg_class t ON t.oid = i.indrelid
CROSS JOIN LATERAL unnest(i.indkey) WITH ORDINALITY AS k(attnum, ord)
JOIN pg_attribute a ON a.attrelid = i.indrelid AND a.attnum = k.attnum
JOIN crdb_internal.index_columns ic
  ON ic.descriptor_name = t.relname
  AND ic.index_name = c.relname
  AND ic.column_name = a.attname
WHERE t.relname = 't7' AND ic.column_type = 'key'
ORDER BY index_name, seq

-- sqlfmt-corpus-separator --

SELECT
  c.relname AS index_name,
  k.ord AS seq,
  a.attname AS column_name,
  ic.implicit
FROM pg_index i
JOIN pg_class c ON c.oid = i.indexrelid
JOIN pg_class t ON t.oid = i.indrelid
CROSS JOIN LATERAL unnest(i.indkey) WITH ORDINALITY AS k(attnum, ord)
JOIN pg_attribute a ON a.attrelid = i.indrelid AND a.attnum = k.attnum
JOIN crdb_internal.index_columns ic
  ON ic.descriptor_name = t.relname
  AND ic.index_name = c.relname
  AND ic.column_name = a.attname
WHERE t.relname = 't9' AND ic.column_type = 'key'
ORDER BY index_name, seq

-- sqlfmt-corpus-separator --

SELECT "reportingID",
       (info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp')
       || (
			SELECT json_build_object(
					'CascadeDroppedViews',
					json_agg(value ORDER BY value)
			       )
			  FROM ROWS FROM (
					json_array_elements((info::JSONB)->'CascadeDroppedViews')
			       )
		)
  FROM system.eventlog
 WHERE "eventType" IN ('drop_view', 'drop_table')
 ORDER BY "timestamp" DESC
 LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT "reportingID",
       (info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp')
       || (
			SELECT json_build_object(
					'DroppedSchemaObjects',
					json_agg(value ORDER BY value)
			       )
			  FROM ROWS FROM (
					json_array_elements((info::JSONB)->'DroppedSchemaObjects')
			       )
		)
  FROM system.eventlog
 WHERE "eventType" = 'drop_database'
       AND info::JSONB->>'Statement' LIKE 'DROP DATABASE eventlogtest%'
 ORDER BY "timestamp";

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", ii, tt, kk FROM (J1_TBL CROSS JOIN J2_TBL) AS tx (ii, jj, tt, ii2, kk)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", tx.ii, tx.jj, tx.kk FROM (J1_TBL t1 (a, b, c) CROSS JOIN J2_TBL t2 (d, e)) AS tx (ii, jj, tt, ii2, kk)

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE (NULL::text NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id)) IS NOT NULL;

-- sqlfmt-corpus-separator --

SELECT * FROM current_schema() WITH ORDINALITY AS a(b)

-- sqlfmt-corpus-separator --

SELECT * FROM generate_series(1, 1) WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT * FROM generate_series(1, 1) WITH ORDINALITY AS c(x, y)

-- sqlfmt-corpus-separator --

SELECT * FROM t95615, LATERAL ROWS FROM (f95615(), f95615()) WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT * FROM t95615, LATERAL ROWS FROM (hostmask(c1), hostmask(c1)) WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT c_id, (NULL::text NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id)) IS NOT NULL
FROM c
ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT crdb_internal.range_stats(k)
  FROM (
          SELECT *
            FROM (
                     SELECT start_key AS k, random() AS r FROM crdb_internal.ranges_no_leases
                     UNION ALL SELECT NULL, random() FROM ROWS FROM (generate_series(1, 100))
                 )
        ORDER BY r DESC
       );

-- sqlfmt-corpus-separator --

SELECT i, random() FROM ROWS FROM (generate_series(1, 5)) AS i ORDER by i

-- sqlfmt-corpus-separator --

UPDATE kv SET k.* = 9

-- sqlfmt-corpus-separator --

UPDATE kv SET k.v = 9

-- sqlfmt-corpus-separator --

UPDATE kv SET kv.k = 9

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
pks_uniques_cols AS (
  SELECT
    connamespace,
    conrelid,
    jsonb_agg(column_info.cols) as cols
  FROM pg_constraint
  JOIN lateral (
    SELECT array_agg(cols.attname order by cols.attnum) as cols
    FROM ( select unnest(conkey) as col) _
    JOIN pg_attribute cols on cols.attrelid = conrelid and cols.attnum = col
  ) column_info ON TRUE
  WHERE
    contype IN ('p', 'u') and
    connamespace::regnamespace::text <> 'pg_catalog'
  GROUP BY connamespace, conrelid
)
SELECT
  ns1.nspname AS table_schema,
  tab.relname AS table_name,
  ns2.nspname AS foreign_table_schema,
  other.relname AS foreign_table_name,
  (ns1.nspname, tab.relname) = (ns2.nspname, other.relname) AS is_self,
  traint.conname  AS constraint_name,
  column_info.cols_and_fcols,
  (column_info.cols IN (SELECT * FROM jsonb_array_elements(pks_uqs.cols))) AS one_to_one
FROM pg_constraint traint
JOIN LATERAL (
  SELECT
    array_agg(row(cols.attname, refs.attname) order by ord) AS cols_and_fcols,
    jsonb_agg(cols.attname order by ord) AS cols
  FROM unnest(traint.conkey, traint.confkey) WITH ORDINALITY AS _(col, ref, ord)
  JOIN pg_attribute cols ON cols.attrelid = traint.conrelid AND cols.attnum = col
  JOIN pg_attribute refs ON refs.attrelid = traint.confrelid AND refs.attnum = ref
) AS column_info ON TRUE
JOIN pg_namespace ns1 ON ns1.oid = traint.connamespace
JOIN pg_class tab ON tab.oid = traint.conrelid
JOIN pg_class other ON other.oid = traint.confrelid
JOIN pg_namespace ns2 ON ns2.oid = other.relnamespace
LEFT JOIN pks_uniques_cols pks_uqs ON pks_uqs.connamespace = traint.connamespace AND pks_uqs.conrelid = traint.conrelid
WHERE traint.contype = 'f'
and traint.conparentid = 0 ORDER BY traint.conrelid, traint.conname