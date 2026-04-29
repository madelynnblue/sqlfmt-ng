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

CREATE TABLE assn_cast (
  c CHAR,
  vc VARCHAR(1),
  qc "char",
  b BIT,
  i INT,
  i2 INT2,
  f4 FLOAT4,
  t timestamp,
  d DECIMAL(10, 0),
  a DECIMAL(10, 0)[],
  s STRING,
  ca CHAR[],
  vba VARBIT(1)[]
)

-- sqlfmt-corpus-separator --

CREATE TABLE assn_cast_char_default (
  c CHAR DEFAULT 'foo'::TEXT,
  c2 CHAR(2) DEFAULT 'bar',
  qc "char" DEFAULT 'baz'
)

-- sqlfmt-corpus-separator --

CREATE TABLE assn_cast_upsert (
  k INT PRIMARY KEY,
  c CHAR,
  qc "char",
  i2 INT2,
  d DECIMAL(10, 0),
  a DECIMAL(10, 0)[]
)

-- sqlfmt-corpus-separator --

CREATE TABLE t65631(a "char", b "char" COLLATE en)

-- sqlfmt-corpus-separator --

SELECT
  COALESCE(g.rolname, 'PUBLIC') AS grantor,
  COALESCE(e.rolname, 'PUBLIC') AS grantee,
  a.privilege_type,
  a.is_grantable
FROM aclexplode(acldefault('d'::"char", 'root'::regrole)) a
LEFT JOIN pg_roles g ON g.oid = a.grantor
LEFT JOIN pg_roles e ON e.oid = a.grantee
ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT
  COALESCE(g.rolname, 'PUBLIC') AS grantor,
  COALESCE(e.rolname, 'PUBLIC') AS grantee,
  a.privilege_type,
  a.is_grantable
FROM aclexplode(acldefault('l'::"char", 'root'::regrole)) a
LEFT JOIN pg_roles g ON g.oid = a.grantor
LEFT JOIN pg_roles e ON e.oid = a.grantee
ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT
  COALESCE(g.rolname, 'PUBLIC') AS grantor,
  COALESCE(e.rolname, 'PUBLIC') AS grantee,
  a.privilege_type,
  a.is_grantable
FROM aclexplode(acldefault('p'::"char", 'root'::regrole)) a
LEFT JOIN pg_roles g ON g.oid = a.grantor
LEFT JOIN pg_roles e ON e.oid = a.grantee
ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT
  COALESCE(g.rolname, 'PUBLIC') AS grantor,
  COALESCE(e.rolname, 'PUBLIC') AS grantee,
  a.privilege_type,
  a.is_grantable
FROM aclexplode(acldefault('r'::"char", 'root'::regrole)) a
LEFT JOIN pg_roles g ON g.oid = a.grantor
LEFT JOIN pg_roles e ON e.oid = a.grantee
ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT 'a'::"char" FROM t47131_0

-- sqlfmt-corpus-separator --

SELECT (-129)::"char";

-- sqlfmt-corpus-separator --

SELECT 128::"char";

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

SELECT i, i::"char"::bytea, length(i::"char")
FROM (VALUES (32), (97), (127), (0), (-1), (-127), (-128)) v(i);

-- sqlfmt-corpus-separator --

WITH
    foo(f) AS (SELECT array_agg(x) FROM generate_series(1, 3) g(x)),
    bar(b) AS (SELECT array_agg(f) FROM foo, generate_series(1, 3)),
    baz(z) AS (SELECT array_agg(b) FROM bar, generate_series(1, 3))
SELECT z FROM baz;

-- sqlfmt-corpus-separator --

WITH
    one AS (SELECT a AS u FROM x2),
    two AS (SELECT b AS v FROM (SELECT b FROM y2 UNION ALL SELECT u FROM one))
SELECT
    *
FROM
    one JOIN two ON u = v

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
  with2
    AS (
      SELECT
        tq.trid, tq.dec1
      FROM
        trrec AS r INNER JOIN trtab4 AS tq ON r.id = tq.trid AND r.str16 = '12345'
    )
SELECT tr.id, tr.trid, val3.ts12
FROM
  trrec AS tr
  INNER JOIN LATERAL (
      SELECT  q.dec1 FROM with2 AS q WHERE tr.id = q.trid
    ) AS q ON true
  INNER JOIN LATERAL (
      SELECT
        m.ts12
      FROM trm AS m WHERE tr.id = m.trid
      ORDER BY m.ts12 ASC
      LIMIT 1
    ) AS val3 ON true
WHERE
  tr.str16 = '12345'
ORDER BY 1 DESC
;

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

-- sqlfmt-corpus-separator --

WITH a (colA) AS (
	VALUES ('row-1'), ('row-2')
),
b (colB) AS (
	VALUES ('row-1'), ('row-2')
)
SELECT a.colA, l.colB, l.colB_agg, l.count
FROM a
LEFT JOIN LATERAL (
	SELECT colB, array_agg(colB) AS colB_agg, count(*) AS count
	FROM b
	WHERE colB = a.colA
	GROUP BY colB
) l ON true
  -- redundant filter
	AND l.colB = a.colA;

-- sqlfmt-corpus-separator --

WITH a (colA) AS (
	VALUES ('row-1'), ('row-2')
),
b (colB) AS (
	VALUES ('row-1'), ('row-2')
)
SELECT a.colA, l.colB, l.colB_agg, l.count
FROM a
LEFT JOIN LATERAL (
	SELECT colB, array_agg(colB) AS colB_agg, count(*) AS count
	FROM b
	WHERE colB = a.colA
	GROUP BY colB
) l ON true;

-- sqlfmt-corpus-separator --

WITH a AS (
  SELECT extract(YEAR FROM "lastUpdated") AS year
  FROM system.settings WHERE name = 'version'
) SELECT year > 2020 AND year < 2100 FROM a

-- sqlfmt-corpus-separator --

WITH a AS (SELECT a FROM ab ORDER BY b) SELECT * FROM a

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

WITH cte(col) AS (SELECT random()) SELECT col, random() FROM cte

-- sqlfmt-corpus-separator --

WITH cte(s) AS (SELECT NULL::TSQUERY) SELECT a FROM a, cte WHERE a @@ s;

-- sqlfmt-corpus-separator --

WITH foo AS (SELECT 2) SELECT f(), * FROM foo;

-- sqlfmt-corpus-separator --

WITH foo AS (SELECT insert_t1()) SELECT insert_t1();

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

WITH grants AS (SHOW GRANTS) SELECT * FROM grants
 WHERE schema_name NOT IN ('crdb_internal', 'pg_catalog', 'information_schema') 
  AND (database_name <> 'system' OR object_name = 'role_options') ORDER BY database_name, schema_name, object_name,
  object_type, grantee, privilege_type, is_grantable

-- sqlfmt-corpus-separator --

WITH grants AS (SHOW GRANTS) SELECT * FROM grants WHERE 
  (schema_name <> 'crdb_internal' OR object_name = 'session_variables') ORDER BY database_name, schema_name, object_name,
   object_type, grantee, privilege_type, is_grantable

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

WITH r AS (
  SELECT oid, c FROM (SELECT oid, count(*) as c FROM pg_catalog.pg_proc GROUP BY oid) WHERE c > 1
)
SELECT proname, l.oid::int AS id
FROM pg_catalog.pg_proc l
JOIN r on l.oid = r.oid
ORDER BY id

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

WITH t AS (SELECT * FROM y WHERE a < 3)
  SELECT * FROM x NATURAL JOIN t

-- sqlfmt-corpus-separator --

WITH t AS (SELECT 1) SELECT 2

-- sqlfmt-corpus-separator --

WITH t AS (SELECT a FROM x) SELECT a, x.t FROM t

-- sqlfmt-corpus-separator --

WITH t AS (SELECT a FROM y WHERE a < 3)
  SELECT * FROM x NATURAL JOIN t

-- sqlfmt-corpus-separator --

WITH t AS (SELECT b FROM y2) SELECT * FROM t JOIN t AS q ON true

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

WITH tables AS (SHOW TABLES FROM crdb_internal) SELECT * FROM tables 
  WHERE table_name IN ('node_build_info', 'ranges', 'ranges_no_leases')

-- sqlfmt-corpus-separator --

WITH tables AS (SHOW TABLES FROM crdb_internal) SELECT * FROM tables 
WHERE table_name IN ('node_build_info', 'ranges_no_leases', 'ranges')

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