SELECT
	degrees(ST_Azimuth(ST_Point(25, 45)::geography, ST_Point(75, 90)::geography)) AS degA_B,
	degrees(ST_Azimuth(ST_Point(75, 90)::geography, ST_Point(25, 45)::geography)) AS degB_A

-- sqlfmt-corpus-separator --

SELECT
	src_p.proname as from, dst_p.proname as to
FROM
	pg_depend AS d, pg_proc AS src_p, pg_proc AS dst_p
WHERE
	d.classid = 'pg_catalog.pg_proc'::REGCLASS::INT8
	AND d.refclassid = 'pg_catalog.pg_proc'::REGCLASS::INT8
	AND d.objid = src_p.oid
	AND d.refobjid = dst_p.oid;

-- sqlfmt-corpus-separator --

SELECT
        _float8,
        var_pop(_float8::FLOAT8)::FLOAT8,
        count(*)
FROM
        t109334
GROUP BY
        _float8;

-- sqlfmt-corpus-separator --

SELECT
        var_pop(_float8::FLOAT8)::FLOAT8,
        count(*)
FROM
        t109334
GROUP BY
        grouping_col;

-- sqlfmt-corpus-separator --

SELECT
    '1971-03-18'::DATE + 300866802885581286

-- sqlfmt-corpus-separator --

SELECT
    ST_AsText(ST_Rotate(a.geom, pi(), 'POINT (6 3)'::geometry)) as t
FROM geom_operators_test a
ORDER BY t;

-- sqlfmt-corpus-separator --

SELECT
    attname,
    attlen,
    attnum
FROM
    pg_catalog.pg_attribute
WHERE
    attrelid = 'u'::regtype::oid;

-- sqlfmt-corpus-separator --

SELECT
    relname,
    relkind,
    relnatts
FROM
    pg_catalog.pg_class
WHERE
    oid = 'u'::regtype::oid;

-- sqlfmt-corpus-separator --

SELECT
    tgname,
    tgnargs,
    encode(tgargs, 'escape') AS tgargs,
    tgattr
FROM pg_catalog.pg_trigger
WHERE tgrelid = 'test_triggers'::regclass
ORDER BY tgname;

-- sqlfmt-corpus-separator --

SELECT
    tgname,
    tgrelid::regclass::text AS table_name,
    tgfoid::regproc::text AS trigger_func_name
FROM pg_catalog.pg_trigger
WHERE tgrelid = 'other_schema.test_table'::regclass;

-- sqlfmt-corpus-separator --

SELECT
    tgname,
    tgtype,
    tgfoid > 0 AS has_func_oid,
    tgnargs,
    tgenabled,
    tgoldtable,
    tgnewtable
FROM pg_catalog.pg_trigger
WHERE tgrelid = 'test_triggers'::regclass
ORDER BY tgname;

-- sqlfmt-corpus-separator --

SELECT
  '12345'::regclass::string,
  '12345'::regtype::string,
  '12345'::oid::string,
  '12345'::regproc::string,
  '12345'::regprocedure::string

-- sqlfmt-corpus-separator --

SELECT
  DISTINCT ON ("genre") genre
FROM
  "public"."author"
ORDER BY
  "genre" ASC NULLS LAST

-- sqlfmt-corpus-separator --

SELECT
  ST_PointFromText('POINT(1.0 1.0)'),
  ST_PointFromText('POINT(1.0 1.0)', 4326),
  ST_PointFromText('LINESTRING(1.0 1.0, 2.0 2.0)'),
  ST_PointFromText('LINESTRING(1.0 1.0, 2.0 2.0)', 4326),
  ST_PointFromWKB(ST_AsBinary('POINT(1.0 1.0)'::geometry)),
  ST_PointFromWKB(ST_AsBinary('POINT(1.0 1.0)'::geometry), 4326),
  ST_PointFromWKB(ST_AsBinary('LINESTRING(1.0 1.0, 2.0 2.0)'::geometry)),
  ST_PointFromWKB(ST_AsBinary('LINESTRING(1.0 1.0, 2.0 2.0)'::geometry), 4326)

-- sqlfmt-corpus-separator --

SELECT
  a + '24 hours'::interval, a + '1 day'::interval, a + '1 month'::interval,
  a - '24 hours'::interval, a - '1 day'::interval, a - '1 month'::interval,
  a - '2010-11-06 23:59:00'::timestamptz,
  a - '2010-11-07 23:59:00'::timestamptz,
  a::string
FROM example
ORDER BY a

-- sqlfmt-corpus-separator --

SELECT
  a.dsc,
  ST_AsEWKT(ST_Envelope(a.geom)),
  ST_AsEWKT(ST_Envelope(a.geom::box2d))
FROM geom_operators_test a
ORDER BY a.dsc

-- sqlfmt-corpus-separator --

SELECT
  avg(a) OVER (),
  avg(a) OVER (ORDER BY a),
  avg(a) OVER (ORDER BY b),
  avg(a) OVER (ORDER BY c),
  avg(b) OVER (),
  avg(b) OVER (ORDER BY a),
  avg(b) OVER (ORDER BY b),
  avg(b) OVER (ORDER BY c),
  avg(c) OVER (),
  avg(c) OVER (ORDER BY a),
  avg(c) OVER (ORDER BY b),
  avg(c) OVER (ORDER BY c)
FROM abc

-- sqlfmt-corpus-separator --

SELECT
  b1, t - '5 hrs'::INTERVAL < '23:00:00'::TIME AS expected_b1,
  b2, t + '5 hrs'::INTERVAL > '01:00:00'::TIME AS expected_b2
FROM t88128

-- sqlfmt-corpus-separator --

SELECT
  crdb_internal.pb_to_json('cockroach.sql.sqlbase.Descriptor', descriptor)->'table'->'indexes'->0->'partitioning'
FROM system.descriptor
WHERE id = 't1'::regclass

-- sqlfmt-corpus-separator --

SELECT
  crdb_internal.pb_to_json('cockroach.sql.sqlbase.Descriptor', descriptor)->'table'->'indexes'->0->'partitioning'->'numImplicitColumns'
FROM system.descriptor
WHERE id = 't3'::regclass

-- sqlfmt-corpus-separator --

SELECT
  crdb_internal.pb_to_json('cockroach.sql.sqlbase.Descriptor', descriptor)->'table'->'primaryIndex'->'partitioning'
FROM system.descriptor
WHERE id = 't1'::regclass

-- sqlfmt-corpus-separator --

SELECT
  experimental_strftime('0001-01-01 00:00:00'::timestamp, '%C%y-%m-%d'),
  experimental_strftime('0099-01-01 00:00:00'::timestamp, '%C%y-%m-%d'),
  experimental_strftime('2024-01-02 00:00:00'::timestamp, '%C%y-%m-%d')

-- sqlfmt-corpus-separator --

SELECT
  experimental_strftime('0001-01-01 00:00:00'::timestamp, '%Y-%m-%d'),
  experimental_strftime('0099-06-15 00:00:00'::timestamp, '%Y-%m-%d'),
  experimental_strftime('0999-12-31 00:00:00'::timestamp, '%Y-%m-%d'),
  experimental_strftime('2024-01-02 00:00:00'::timestamp, '%Y-%m-%d'),
  experimental_strftime('10001-01-01 00:00:00'::timestamp, '%Y-%m-%d')

-- sqlfmt-corpus-separator --

SELECT
  experimental_strftime('0001-01-01 00:00:00'::timestamp, '%y'),
  experimental_strftime('0099-01-01 00:00:00'::timestamp, '%y'),
  experimental_strftime('2024-01-01 00:00:00'::timestamp, '%y')

-- sqlfmt-corpus-separator --

SELECT
  geog::bytea,
  geog::jsonb,
  geog::string
FROM parse_test ORDER BY id ASC

-- sqlfmt-corpus-separator --

SELECT
  geog::bytea::geography,
  geog::jsonb::geography,
  geog::string::geography
FROM parse_test ORDER BY id ASC

-- sqlfmt-corpus-separator --

SELECT
  geom::bytea,
  geom::jsonb,
  geom::string
FROM parse_test ORDER BY id ASC

-- sqlfmt-corpus-separator --

SELECT
  geom::bytea::geometry,
  geom::jsonb::geometry,
  geom::string::geometry
FROM parse_test ORDER BY id ASC

-- sqlfmt-corpus-separator --

SELECT
  grantee,
  table_catalog,
  IF(table_schema LIKE 'pg_temp%', 'pg_temp', table_schema) AS table_schema,
  privilege_type,
  is_grantable
FROM information_schema.schema_privileges

-- sqlfmt-corpus-separator --

SELECT
  to_char('2020-01-02 01:02:03'::date),
  to_char('2020-01-02'::date, 'YYYY-MM-DD HH24:MI:SS.FF6'),
  to_char_with_style('2020-01-02 01:02:03'::date, 'DMY')

-- sqlfmt-corpus-separator --

SELECT
  to_char('2020-01-02 01:02:03'::timestamp),
  to_char_with_style('2020-01-02 01:02:03'::timestamp, 'DMY')

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

SELECT
DISTINCT ON (t2.id)
t2.*
FROM t1, t2
ORDER BY t2.id ASC NULLS LAST

-- sqlfmt-corpus-separator --

SELECT
DISTINCT ON (t2.id)
t2.*
FROM t1, t2
ORDER BY t2.id DESC NULLS FIRST

-- sqlfmt-corpus-separator --

SELECT
ST_AsEWKT(
  ST_SubDivide('SRID=4326;POLYGON((132 10,119 23,85 35,68 29,66 28,49 42,32 56,22 64,32 110,40 119,36 150,
                          57 158,75 171,92 182,114 184,132 186,146 178,176 184,179 162,184 141,190 122,
                          190 100,185 79,186 56,186 52,178 34,168 18,147 13,132 10))'::geometry,10)
)

-- sqlfmt-corpus-separator --

SELECT
g,
0 / '-Infinity'::DECIMAL,
0 / 'Infinity'::DECIMAL,
1 / '-Infinity'::DECIMAL,
1 / 'Infinity'::DECIMAL
FROM regression_40929

-- sqlfmt-corpus-separator --

SELECT "reportingID",
       info::JSONB->>'StatementFingerprint',
       info::JSONB->>'DonorSQL'
FROM system.eventlog
WHERE "eventType" = 'rewrite_inline_hints'
ORDER BY "timestamp"

-- sqlfmt-corpus-separator --

SELECT "reportingID",
       info::JSONB->>'StatementFingerprint',
       info::JSONB->>'VariableName'
FROM system.eventlog
WHERE "eventType" = 'set_session_variable_hint'
ORDER BY "timestamp"

-- sqlfmt-corpus-separator --

SELECT "reportingID", "eventType", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
  FROM system.eventlog
 WHERE "eventType" = 'create_type' AND info::JSONB->>'TypeName' LIKE '%eventlog'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", "eventType", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
  FROM system.eventlog
 WHERE "eventType" = 'drop_type' AND info::JSONB->>'TypeName' LIKE '%eventlog%'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", "eventType", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
  FROM system.eventlog
 WHERE "eventType" = 'drop_type' AND info::JSONB->>'TypeName' LIKE '%eventlog%'
ORDER BY info::JSONB ->> 'TxnReadTimestamp', info::JSONB ->> 'TypeName'

-- sqlfmt-corpus-separator --

SELECT "reportingID", "eventType", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
  FROM system.eventlog
 WHERE "eventType" LIKE '%_owner'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", "eventType", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
  FROM system.eventlog
 WHERE "eventType" LIKE '%_owner' AND info::JSONB->>'Owner' = 'v'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", "eventType", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" LIKE '%_role' AND info LIKE '%invisible%'

-- sqlfmt-corpus-separator --

SELECT "reportingID", "info"::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'remove_zone_config'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", "info"::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'set_cluster_setting'
AND info NOT LIKE '%version%'
AND info NOT LIKE '%cluster.secret%'
AND info NOT LIKE '%sql.defaults%'
AND info NOT LIKE '%sql.distsql%'
AND info NOT LIKE '%sql.testing%'
AND info NOT LIKE '%sql.stats%'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", "info"::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'set_zone_config'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", "info"::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp', "eventType"
FROM system.eventlog
WHERE "eventType" LIKE 'change_%_privilege'
ORDER BY info::JSONB ->> 'TxnReadTimestamp', info::JSONB ->> 'Grantee', info::JSONB ->> 'TableName'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
  FROM system.eventlog
 WHERE "eventType" = 'create_table'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'alter_database_drop_region'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'alter_table'
ORDER BY "timestamp" DESC, info
LIMIT 1

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'comment_on_column'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'comment_on_index'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'comment_on_schema'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'comment_on_table'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'create_database'
  AND info::JSONB->>'Statement' LIKE 'CREATE DATABASE IF NOT EXISTS othereventlogtest%'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'create_database'
  AND info::JSONB->>'Statement' LIKE 'CREATE DATABASE eventlogtest%'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'create_schema'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'create_table'
  AND info::JSONB->>'Statement' LIKE 'CREATE TABLE IF NOT EXISTS test.public.b%'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'create_table'
  AND info::JSONB->>'Statement' LIKE 'CREATE TABLE test.public.a%'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'drop_database'
  AND info::JSONB->>'Statement' LIKE 'DROP DATABASE IF EXISTS othereventlogtest%'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'drop_index'
ORDER BY "timestamp" DESC, info
LIMIT 1

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'drop_schema'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'drop_table'
  AND info::JSONB->>'Statement' LIKE 'DROP TABLE IF EXISTS test.public.b%'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'drop_table'
  AND info::JSONB->>'Statement' LIKE 'DROP TABLE test.public.a%'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'drop_table'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'rename_database'
  AND info::JSONB->>'Statement' LIKE 'ALTER DATABASE %eventlogtorename% RENAME TO %eventlogtonewname%'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'rename_schema'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'rename_table'
  AND info::JSONB->>'Statement' LIKE 'ALTER TABLE %toberenamed% RENAME TO %renamedtable%'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'set_cluster_setting'
AND info NOT LIKE '%version%'
AND info NOT LIKE '%cluster.secret%'
AND info NOT LIKE '%sql.defaults%'
AND info NOT LIKE '%sql.distsql%'
AND info NOT LIKE '%sql.testing%'
AND info NOT LIKE '%sql.stats%'
AND info NOT LIKE '%sql.catalog.allow_leased_descriptor%'
AND info NOT LIKE '%sql.catalog.descriptor_lease.use_locked_timestamps.enabled%'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'set_schema'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp'
FROM system.eventlog
WHERE "eventType" = 'truncate_table'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' - 'CascadedDroppedViews'
FROM system.eventlog
WHERE "eventType" = 'drop_table'
ORDER BY "timestamp" DESC, info
LIMIT 1

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' - 'Error' - 'LatencyNanos'
  FROM system.eventlog
WHERE "eventType" = 'reverse_schema_change'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' - 'LatencyNanos'
FROM system.eventlog
ORDER BY "timestamp", info DESC

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' - 'LatencyNanos'
FROM system.eventlog
ORDER BY timestamp, info DESC;

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' - 'LatencyNanos'  FROM system.eventlog
WHERE "eventType" = 'finish_schema_change'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' - 'LatencyNanos' FROM system.eventlog
WHERE "eventType" = 'finish_schema_change'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' - 'LatencyNanos' FROM system.eventlog
WHERE "eventType" = 'finish_schema_change'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' - 'LatencyNanos' FROM system.eventlog
WHERE "eventType" = 'finish_schema_change_rollback'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' - 'Statement'
FROM system.eventlog
WHERE "eventType" = 'remove_zone_config'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' - 'Statement'
FROM system.eventlog
WHERE "eventType" = 'set_zone_config'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' FROM system.eventlog
WHERE "eventType" = 'alter_table'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' FROM system.eventlog
WHERE "eventType" = 'alter_table'
  AND info::JSONB->>'Statement' LIKE 'ALTER TABLE test.public.a%'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' FROM system.eventlog
WHERE "eventType" = 'alter_table'
AND info::JSONB->>'Statement' LIKE 'ALTER TABLE t1%'
ORDER BY "timestamp" DESC, info

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' FROM system.eventlog
WHERE "eventType" = 'alter_table'
ORDER BY "timestamp", info

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' FROM system.eventlog
WHERE "eventType" = 'create_index'
  AND info::JSONB->>'Statement' LIKE 'CREATE INDEX %a_foo%'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' FROM system.eventlog
WHERE "eventType" = 'create_index'
  AND info::JSONB->>'Statement' LIKE 'CREATE INDEX ON%'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp' FROM system.eventlog
WHERE "eventType" = 'drop_index'
  AND info::JSONB->>'Statement' LIKE 'DROP INDEX%a_foo'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp', "eventType"
FROM system.eventlog
WHERE "eventType" LIKE 'change_%_privilege'
ORDER BY info::JSONB ->> 'TxnReadTimestamp', info::JSONB ->> 'Grantee', info::JSONB ->> 'TableName'

-- sqlfmt-corpus-separator --

SELECT "reportingID", info::JSONB - 'Timestamp' - 'TxnReadTimestamp' - 'HintID'
FROM system.eventlog
WHERE "eventType" = 'rewrite_inline_hints'
  AND info::JSONB->>'StatementFingerprint' = 'SELECT * FROM xy INNER JOIN ab ON xy.x = ab.b'

-- sqlfmt-corpus-separator --

SELECT ' blah ( ignored , ignored ) '::REGPROC

-- sqlfmt-corpus-separator --

SELECT '"abc\n123"'::JSON

-- sqlfmt-corpus-separator --

SELECT '"char"'::REGTYPE, 'pg_catalog.int4'::REGTYPE

-- sqlfmt-corpus-separator --

SELECT '"foo"'::jsonb -> 'z';

-- sqlfmt-corpus-separator --

SELECT '"foo"'::jsonb -> 1;

-- sqlfmt-corpus-separator --

SELECT '"foo"'::jsonb ->> 'z';

-- sqlfmt-corpus-separator --

SELECT '"foo"'::jsonb ->> 1;

-- sqlfmt-corpus-separator --

SELECT '"foo"'::jsonb->-2, '"foo"'::jsonb->-1, '"foo"'::jsonb->0, '"foo"'::jsonb->1

-- sqlfmt-corpus-separator --

SELECT '"foo"'::jsonb->>-2, '"foo"'::jsonb->>-1, '"foo"'::jsonb->>0, '"foo"'::jsonb->>1

-- sqlfmt-corpus-separator --

SELECT '"hello"'::JSON

-- sqlfmt-corpus-separator --

SELECT '"hello"'::JSON = '"hello"'::JSON, '"hello"'::JSON = '"goodbye"'::JSON

-- sqlfmt-corpus-separator --

SELECT '"pg_constraint"'::REGCLASS, '  "pg_constraint" '::REGCLASS

-- sqlfmt-corpus-separator --

SELECT '"unterminated=r/'::aclitem

-- sqlfmt-corpus-separator --

SELECT '"user with spaces"=r/'::aclitem

-- sqlfmt-corpus-separator --

SELECT '#4314', ST_AsMVTGeom(
	'SRID=3857;MULTIPOLYGON(((-8230700.44460474 4970098.60762691,-8230694.76395068 4970080.40480045,-8230692.98226063 4970074.69572152,-8230702.2389602 4970071.78449542,-8230709.99536139 4970096.63875167,-8230700.73864062 4970099.5499925,-8230700.44460474 4970098.60762691)))'::geometry,
	ST_MakeBox2D(ST_Point(-8257645.03970416, 4970241.3272153), ST_Point(-8218509.28122215, 5009377.08569731)),
	2048,
	8,
	true);

-- sqlfmt-corpus-separator --

SELECT '$  .  a  ?  (  @  .  b  ==  1  )  .  c  ?  (  @  .  d  ==  2  )  '::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$ ? (@ like_regex "(invalid pattern")'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT '$'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT '$'::JSONPATH AS col ORDER BY col DESC NULLS FIRST;

-- sqlfmt-corpus-separator --

SELECT '$'::JSONPATH ORDER BY 1 ASC;

-- sqlfmt-corpus-separator --

SELECT '$.*'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT '$.**'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.1a[*]'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT '$.ABC[*].DEF.GHI[*]'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT '$.a ? ($.b == 1)'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.a ? (@.b == 1).c ? (@.d == 2)'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.a'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT '$.a1[*]'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT '$.a?(@.b==1).c?(@.d==2)'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.a[*] ? (@.b != 1)'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.a[*] ? (@.b < 1)'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.a[*] ? (@.b <= 1)'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.a[*] ? (@.b == 1 && @.c != 1)'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.a[*] ? (@.b > 1)'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.a[*] ? (@.b >= 1)'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.abc[*].DEF.ghi[*]'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT '$.bigint()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.boolean()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.date()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.datetime()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.decimal()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.double()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.integer()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.keyvalue()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.number()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.string()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.time()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.time_tz()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.timestamp()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT '$.timestamp_tz()'::JSONPATH;

-- sqlfmt-corpus-separator --

SELECT ''::JSONPATH

-- sqlfmt-corpus-separator --

SELECT ''::LTREE

-- sqlfmt-corpus-separator --

SELECT ''::LTREE::TEXT

-- sqlfmt-corpus-separator --

SELECT ''::LTREE::TEXT::LTREE = ''::LTREE

-- sqlfmt-corpus-separator --

SELECT ''::PG_LSN;

-- sqlfmt-corpus-separator --

SELECT '()'::a

-- sqlfmt-corpus-separator --

SELECT '()'::record

-- sqlfmt-corpus-separator --

SELECT '(1 , 2)'::a

-- sqlfmt-corpus-separator --

SELECT '(1,4)'::record

-- sqlfmt-corpus-separator --

SELECT '-'::oid

-- sqlfmt-corpus-separator --

SELECT '-'::regclass, '-'::regclass::oid,
  '-'::regproc, '-'::regproc::oid,
  '-'::regprocedure, '-'::regprocedure::oid,
  '-'::regnamespace, '-'::regnamespace::oid,
  '-'::regtype, '-'::regtype::oid,
  '-'::regrole, '-'::regrole::oid

-- sqlfmt-corpus-separator --

SELECT '-2 years 11 months 1 day 01:02:03'::interval

-- sqlfmt-corpus-separator --

SELECT '-563-12-26'::DATE

-- sqlfmt-corpus-separator --

SELECT '-5632-12-26'::DATE

-- sqlfmt-corpus-separator --

SELECT '-56325279622-12-26'::DATE

-- sqlfmt-corpus-separator --

SELECT '-Infinity'::float8::numeric

-- sqlfmt-corpus-separator --

SELECT '-Infinity'::numeric::float8

-- sqlfmt-corpus-separator --

SELECT '-Infinity'::numeric::int8

-- sqlfmt-corpus-separator --

SELECT '-inf'::numeric / '0'

-- sqlfmt-corpus-separator --

SELECT '-infinity'::timestamp + '1 second'::interval, '-infinity'::timestamp - '1 second'::interval;

-- sqlfmt-corpus-separator --

SELECT '-infinity'::timestamp < '4714-11-24 00:00:00+00 BC'::timestamp;

-- sqlfmt-corpus-separator --

SELECT '.-400000000000000000000000000000000000000'::DECIMAL;

-- sqlfmt-corpus-separator --

SELECT '.leading.dot'::LTREE

-- sqlfmt-corpus-separator --

SELECT '.starts.with.dot'::LTREE

-- sqlfmt-corpus-separator --

SELECT '0'::decimal(19,9)

-- sqlfmt-corpus-separator --

SELECT '0/0'::pg_lsn + 'Inf'

-- sqlfmt-corpus-separator --

SELECT '0/0'::pg_lsn + 'NaN'

-- sqlfmt-corpus-separator --

SELECT '0/0'::pg_lsn - 'NaN'::numeric

-- sqlfmt-corpus-separator --

SELECT '0/0'::pg_lsn - 50

-- sqlfmt-corpus-separator --

SELECT '0000-01-01 24:00:00'::time::string

-- sqlfmt-corpus-separator --

SELECT '0000-01-01 24:00:00'::timetz::string

-- sqlfmt-corpus-separator --

SELECT '0000-01-01 BC'::date

-- sqlfmt-corpus-separator --

SELECT '05-07-2020'::date

-- sqlfmt-corpus-separator --

SELECT '0G'::pg_lsn

-- sqlfmt-corpus-separator --

SELECT '1'::JSON = '1'

-- sqlfmt-corpus-separator --

SELECT '1'::JSON = '1'::JSON

-- sqlfmt-corpus-separator --

SELECT '1'::JSON = '2'::JSON

-- sqlfmt-corpus-separator --

SELECT '1'::JSONB, '2'::JSON

-- sqlfmt-corpus-separator --

SELECT '1'::PG_LSN;

-- sqlfmt-corpus-separator --

SELECT '1.0'::REFCURSOR::DECIMAL;

-- sqlfmt-corpus-separator --

SELECT '1.00'::JSON

-- sqlfmt-corpus-separator --

SELECT '1.00'::JSON = '1'::JSON

-- sqlfmt-corpus-separator --

SELECT '100126'::REGPROC;

-- sqlfmt-corpus-separator --

SELECT '10101011'::STRING::BIT(8)

-- sqlfmt-corpus-separator --

SELECT '11:00'::time::timetz

-- sqlfmt-corpus-separator --

SELECT '11:00+03:00'::timetz::time

-- sqlfmt-corpus-separator --

SELECT '11:00+5'::timetz = '11:00+5'::timetz

-- sqlfmt-corpus-separator --

SELECT '11:00-2'::timetz < '11:00'::time

-- sqlfmt-corpus-separator --

SELECT '11:00-3'::timetz = '11:00'::time

-- sqlfmt-corpus-separator --

SELECT '123'::jsonb->-2, '123'::jsonb->-1, '123'::jsonb->0, '123'::jsonb->1

-- sqlfmt-corpus-separator --

SELECT '123'::jsonb->>-2, '123'::jsonb->>-1, '123'::jsonb->>0, '123'::jsonb->>1

-- sqlfmt-corpus-separator --

SELECT '124:00'::TIME;

-- sqlfmt-corpus-separator --

SELECT '127.001.002.003'::INET, '127.001.002.003/016'::INET, '010.001.002.003'::INET

-- sqlfmt-corpus-separator --

SELECT '12:00:00'::TIME;

-- sqlfmt-corpus-separator --

SELECT '12:00:00-07'::TIMETZ;

-- sqlfmt-corpus-separator --

SELECT '1882-05-23T00:00:00-05:51'::timestamptz::text

-- sqlfmt-corpus-separator --

SELECT '192.168.0.0'::INET > '192.168.0.1/0'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.0.1'::INET = '192.168.0.1'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.0.1'::INET::TEXT

-- sqlfmt-corpus-separator --

SELECT '192.168.0.1/0'::INET = '192.168.0.1'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.0.1/0'::INET = '192.168.0.1/0'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.0.1/0'::INET > '192.168.0.1/0'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.0.1/16'::INET::TEXT

-- sqlfmt-corpus-separator --

SELECT '192.168.0.2/24'::INET < '192.168.0.1/25'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.1.2/24'::INET;

-- sqlfmt-corpus-separator --

SELECT '192.168.2.1/8'::INET && '2001:0db8:0500:0000:0500:5000:0000:0001/50'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.2.1/8'::INET << '2001:0db8:0500:0000:0500:5000:0000:0001/50'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.2.1/8'::INET <<= '2001:0db8:0500:0000:0500:5000:0000:0001/50'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.2.1/8'::INET >> '2001:0db8:0500:0000:0500:5000:0000:0001/50'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.2.1/8'::INET >>= '2001:0db8:0500:0000:0500:5000:0000:0001/50'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.200.95'::INET << '192.168.2.1/8'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.200.95'::INET <<= '192.168.2.1/8'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.200.95/16'::INET && '192.168.2.1/24'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.200.95/17'::INET && '192.168.2.1/24'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.200.95/17'::INET >> '192.168.162.1'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.200.95/17'::INET >>= '192.168.2.1/24'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.200.95/8'::INET << '192.168.2.1/8'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.200.95/8'::INET <<= '192.168.2.1/8'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.200.95/8'::INET >> '192.168.2.1/8'::INET

-- sqlfmt-corpus-separator --

SELECT '192.168.200.95/8'::INET >>= '192.168.2.1/8'::INET

-- sqlfmt-corpus-separator --

SELECT '2'::JSONB->'b', '[1,2,3]'::JSONB->'0'

-- sqlfmt-corpus-separator --

SELECT '2'::JSONB->>'b', '[1,2,3]'::JSONB->>'0'

-- sqlfmt-corpus-separator --

SELECT '2001-01-01 00:00:00'::TIMESTAMP::TIMESTAMPTZ

-- sqlfmt-corpus-separator --

SELECT '2001-01-01 00:00:00'::timestamp = '2001-01-01 01:00:00-4'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2001-01-01 01:24:00'::time

-- sqlfmt-corpus-separator --

SELECT '2001-01-01 01:24:00+3'::timetz

-- sqlfmt-corpus-separator --

SELECT '2001-01-01 11:00+04:00'::timestamptz::timetz

-- sqlfmt-corpus-separator --

SELECT '2001-01-01'::date = '2001-01-01 00:00:00'::timestamp

-- sqlfmt-corpus-separator --

SELECT '2001-01-01'::date = '2001-01-01 00:00:00-5'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0000:0000:0500:5000:0000:0001/50'::INET && '2001:0db8:0000:0000:0000:0000:0000:0001/100'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0000:0000:0500:5000:0000:0001/50'::INET << '2001:0db8:0000:0000:0000:0000:0000:0001/100'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0000:0000:0500:5000:0000:0001/50'::INET << '2001:0db8:0000:0000:0500:5000:0000:0001/50'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0000:0000:0500:5000:0000:0001/50'::INET <<= '2001:0db8:0000:0000:0000:0000:0000:0001/100'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0000:0000:0500:5000:0000:0001/50'::INET <<= '2001:0db8:0000:0000:0500:5000:0000:0001/50'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0000:0000:0500:5000:0000:0001/50'::INET >> '2001:0db8:0000:0000:0500:5000:0000:0001/50'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0000:0000:0500:5000:0000:0001/50'::INET >>= '2001:0db8:0000:0000:0500:5000:0000:0001/50'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0500:0000:0500:5000:0000:0001/50'::INET && '192.168.2.1/8'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0500:0000:0500:5000:0000:0001/50'::INET && '2001:0db8:0000:0000:0000:0000:0000:0001/100'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0500:0000:0500:5000:0000:0001/50'::INET << '192.168.2.1/8'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0500:0000:0500:5000:0000:0001/50'::INET <<= '192.168.2.1/8'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0500:0000:0500:5000:0000:0001/50'::INET >> '192.168.2.1/8'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0500:0000:0500:5000:0000:0001/50'::INET >> '2001:0db8:0000:0000:0000:0000:0000:0001/100'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0500:0000:0500:5000:0000:0001/50'::INET >>= '192.168.2.1/8'::INET

-- sqlfmt-corpus-separator --

SELECT '2001:0db8:0500:0000:0500:5000:0000:0001/50'::INET >>= '2001:0db8:0000:0000:0000:0000:0000:0001/100'::INET

-- sqlfmt-corpus-separator --

SELECT '2011-03-13'::date = '2011-03-13'::timestamp

-- sqlfmt-corpus-separator --

SELECT '2011-03-13'::date = '2011-03-13'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-13'::timestamp = '2011-03-13'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-14'::date = '2011-03-14'::timestamp

-- sqlfmt-corpus-separator --

SELECT '2011-03-14'::date = '2011-03-14'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-14'::timestamp = '2011-03-14'::timestamptz

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

SELECT '2015-08-30 03:34:45.34567'::REFCURSOR::TIMESTAMP;

-- sqlfmt-corpus-separator --

SELECT '2015-08-30 03:34:45.34567'::TIMESTAMP::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT '2015-08-30'::DATE::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT '2015-08-30'::REFCURSOR::DATE;

-- sqlfmt-corpus-separator --

SELECT '24:00:00-1559'::timetz > '23:59:59-1559'::timetz;

-- sqlfmt-corpus-separator --

SELECT '24:00:00.001'::TIME;

-- sqlfmt-corpus-separator --

SELECT '24:00:01'::TIME;

-- sqlfmt-corpus-separator --

SELECT '294276-12-31 23:59:59.999999'::TIMESTAMP(0)

-- sqlfmt-corpus-separator --

SELECT '3'::JSONB - 'b'

-- sqlfmt-corpus-separator --

SELECT '34h2s'::INTERVAL::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT '34h2s'::REFCURSOR::INTERVAL;

-- sqlfmt-corpus-separator --

SELECT '4714-11-24 BC'::date - 1

-- sqlfmt-corpus-separator --

SELECT '4714-11-24 BC'::date, '5874897-12-31'::date, '2000-01-01'::date, '0001-01-01'::date, '0001-12-13 BC'::date

-- sqlfmt-corpus-separator --

SELECT '4714-11-24 BC'::date::string, '5874897-12-31'::date::string, '2000-01-01'::date::string, '0001-01-01'::date::string, '0001-12-13 BC'::date::string

-- sqlfmt-corpus-separator --

SELECT '5'::JSONB @> '5'

-- sqlfmt-corpus-separator --

SELECT '5'::JSONB @> '[5]'

-- sqlfmt-corpus-separator --

SELECT '5-12-26 BC'::DATE

-- sqlfmt-corpus-separator --

SELECT '5874897-12-31'::date + 1

-- sqlfmt-corpus-separator --

SELECT '5874897-12-31'::date - '4714-11-24 BC'::date

-- sqlfmt-corpus-separator --

SELECT '6-12-26 BC'::DATE

-- sqlfmt-corpus-separator --

SELECT '::/0'::inet::text::inet;

-- sqlfmt-corpus-separator --

SELECT '::ffff:192.168.0.1'::INET = '192.168.0.1'::INET

-- sqlfmt-corpus-separator --

SELECT '::ffff:192.168.0.1'::INET = '::ffff:192.168.0.1'::INET

-- sqlfmt-corpus-separator --

SELECT '::ffff:192.168.0.1/24'::INET = '::ffff:192.168.0.1'::INET

-- sqlfmt-corpus-separator --

SELECT '::ffff:192.168.0.1/24'::INET = '::ffff:192.168.0.1/24'::INET

-- sqlfmt-corpus-separator --

SELECT '::ffff:192.168.0.1/24'::INET = '::ffff:192.168.0.1/25'::INET

-- sqlfmt-corpus-separator --

SELECT '=r/'::aclitem

-- sqlfmt-corpus-separator --

SELECT '@'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT 'A'::CITEXT < 'a'::CITEXT;

-- sqlfmt-corpus-separator --

SELECT 'A.B'::LTREE != 'A.B'

-- sqlfmt-corpus-separator --

SELECT 'A.B'::LTREE != NULL::LTREE

-- sqlfmt-corpus-separator --

SELECT 'A.B'::LTREE < 'A.B.C'

-- sqlfmt-corpus-separator --

SELECT 'A.B'::LTREE <= 'A.B'

-- sqlfmt-corpus-separator --

SELECT 'A.B'::LTREE <= 'A.B.C'

-- sqlfmt-corpus-separator --

SELECT 'A.B'::LTREE > 'A.B'

-- sqlfmt-corpus-separator --

SELECT 'A.B'::LTREE > 'A.B.C'

-- sqlfmt-corpus-separator --

SELECT 'A.B'::LTREE >= 'A.B'

-- sqlfmt-corpus-separator --

SELECT 'A.B'::LTREE >= 'A.B.C'

-- sqlfmt-corpus-separator --

SELECT 'A.B'::LTREE || ''::LTREE = 'A.B'

-- sqlfmt-corpus-separator --

SELECT 'A.B'::LTREE || 'C'::LTREE = 'A.B.C'

-- sqlfmt-corpus-separator --

SELECT 'A.B'::LTREE || NULL::LTREE = 'A.B'

-- sqlfmt-corpus-separator --

SELECT 'A.B.C'::LTREE != 'A.B'

-- sqlfmt-corpus-separator --

SELECT 'A.B.C'::LTREE < 'A.B'

-- sqlfmt-corpus-separator --

SELECT 'A.B.C'::LTREE <= 'A.B'

-- sqlfmt-corpus-separator --

SELECT 'A.B.C'::LTREE = 'A.B'

-- sqlfmt-corpus-separator --

SELECT 'A.B.C'::LTREE = 'A.B.C'

-- sqlfmt-corpus-separator --

SELECT 'A.B.C'::LTREE > 'A.B'

-- sqlfmt-corpus-separator --

SELECT 'A.B.C'::LTREE >= 'A.B'

-- sqlfmt-corpus-separator --

SELECT 'A/G'::pg_lsn

-- sqlfmt-corpus-separator --

SELECT 'A01F0/1AAA'::pg_lsn

-- sqlfmt-corpus-separator --

SELECT 'AAA'::text ~ similar_escape('(ACTIVE|CLOSED|PENDING)'::text, NULL::text)

-- sqlfmt-corpus-separator --

SELECT 'AAA'::text ~ similar_to_escape('(ACTIVE|CLOSED|PENDING)'::text)

-- sqlfmt-corpus-separator --

SELECT 'AAA'::text ~ similar_to_escape('(ACTIVE|CLOSED|PENDING)'::text, NULL::text)

-- sqlfmt-corpus-separator --

SELECT 'AB'::BIT(8)

-- sqlfmt-corpus-separator --

SELECT 'ACTIVE'::text ~ similar_escape('(ACTIVE|CLOSED|PENDING)'::text, NULL::text)

-- sqlfmt-corpus-separator --

SELECT 'ACTIVE'::text ~ similar_escape(NULL::text, NULL::text)

-- sqlfmt-corpus-separator --

SELECT 'ACTIVE'::text ~ similar_to_escape('(ACTIVE|CLOSED|PENDING)'::text)

-- sqlfmt-corpus-separator --

SELECT 'ACTIVE'::text ~ similar_to_escape('(ACTIVE|CLOSED|PENDING)'::text, NULL::text)

-- sqlfmt-corpus-separator --

SELECT 'ACTIVE'::text ~ similar_to_escape(NULL::text)

-- sqlfmt-corpus-separator --

SELECT 'FFFFFFFF/FFFFFFFF'::pg_lsn + 50

-- sqlfmt-corpus-separator --

SELECT 'False'::REFCURSOR::BOOL;

-- sqlfmt-corpus-separator --

SELECT 'Foo'::CITEXT

-- sqlfmt-corpus-separator --

SELECT 'HELLO'::t;

-- sqlfmt-corpus-separator --

SELECT 'I'::CITEXT = 'ı'::CITEXT;

-- sqlfmt-corpus-separator --

SELECT 'I4', ST_AsMVTGeom(ST_Point(1, 2), ST_MakeEnvelope(10, 10, 20, 20)::box2d, -10)

-- sqlfmt-corpus-separator --

SELECT 'I5', ST_AsMVTGeom(ST_Point(1, 2), ST_MakeEnvelope(10, 10, 20, 20)::box2d, 0)

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::float8::numeric

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::numeric::float8

-- sqlfmt-corpus-separator --

SELECT 'LaX $'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT 'NaN'::DECIMAL / 0::DECIMAL;

-- sqlfmt-corpus-separator --

SELECT 'NaN'::decimal, '-NaN'::decimal, 'sNaN'::decimal, '-sNaN'::decimal

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric::float8

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric::int2

-- sqlfmt-corpus-separator --

SELECT 'PG10', ST_AsText(ST_AsMVTGeom(
	'POINT EMPTY'::geometry,
	'BOX(0 0,2 2)'::box2d));

-- sqlfmt-corpus-separator --

SELECT 'PG44', ST_AsEWKT(ST_AsMVTGeom(
	'SRID=3857;MULTIPOLYGON(((-8238038.43842083 4974073.00356281,-8238058.59985694 4974035.91194892,-8238046.74211362 4974077.68076013,-8238038.43842083 4974073.00356281)))'::geometry,
	ST_MakeBox2D(ST_Point(-8242969.13027341, 4970241.3272153), ST_Point(-8238077.16046316, 4975133.29702555)),
	4096,
	16,
	true));

-- sqlfmt-corpus-separator --

SELECT 'PG46', ST_AsEWKT(ST_AsMVTGeom(
	'SRID=3857;MULTIPOLYGON(((-8230285.21085987 4984959.60349704,-8230324.85567616 4984496.35685962,-8230307.1114228 4984654.46474466,-8230285.21085987 4984959.60349704)),((-8230327.54013683 4984444.33052449,-8230327.23971431 4984450.39401942,-8230327.26833036 4984449.87731981,-8230327.54013683 4984444.33052449)))'::geometry,
	ST_MakeBox2D(ST_Point(-8238077.16046316, 4980025.2668358), ST_Point(-8228293.22084265, 4989809.20645631)),
	4096,
	16,
	true));

-- sqlfmt-corpus-separator --

SELECT 'SRID=3857;POINT(1.0 2.0)'::geography

-- sqlfmt-corpus-separator --

SELECT 'SRID=404;POINT(1.0 2.0)'::geography

-- sqlfmt-corpus-separator --

SELECT 'SRID=404;POINT(1.0 2.0)'::geometry

-- sqlfmt-corpus-separator --

SELECT '["1", "2", "1", "2", "3"]'::JSONB - '2'

-- sqlfmt-corpus-separator --

SELECT '["1", "2", "3"]'::JSONB - ''

-- sqlfmt-corpus-separator --

SELECT '["1", "2", "3"]'::JSONB - '1'

-- sqlfmt-corpus-separator --

SELECT '["1", "2", "3"]'::JSONB - '4'

-- sqlfmt-corpus-separator --

SELECT '["9", ["7", "3"], 1]'::JSONB @> '["9", ["7", "3"], 1]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '["9", ["7", "3"], ["1"]]'::JSONB @> '["9", ["7", "3"], ["1"]]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '["a", {"b":1}]'::jsonb #- '{1,b}'

-- sqlfmt-corpus-separator --

SELECT '["foo", "bar", "baz"]'::JSONB ? 'baz'

-- sqlfmt-corpus-separator --

SELECT '["foo", "bar", "baz"]'::JSONB ? 'foo'

-- sqlfmt-corpus-separator --

SELECT '["foo", "bar", "baz"]'::JSONB ? 'gup'

-- sqlfmt-corpus-separator --

SELECT '[0]'::VECTOR::TEXT[];

-- sqlfmt-corpus-separator --

SELECT '[1, "1", 1.0]'::JSONB - '1'

-- sqlfmt-corpus-separator --

SELECT '[1, "hello", [[[true, false]]]]'::JSON

-- sqlfmt-corpus-separator --

SELECT '[1, "hello", {"a": ["foo", {"b": 3}]}]'::JSON

-- sqlfmt-corpus-separator --

SELECT '[1, 2, 3]'::JSON

-- sqlfmt-corpus-separator --

SELECT '[1, 2, 3]'::JSONB <@ '[1, 2]'::JSONB

-- sqlfmt-corpus-separator --

SELECT '[1, 2, 3]'::JSONB ? '0'

-- sqlfmt-corpus-separator --

SELECT '[1, 2, 3]'::JSONB @> '[1, 2]'::JSONB

-- sqlfmt-corpus-separator --

SELECT '[1, 2, 3]'::JSONB->0

-- sqlfmt-corpus-separator --

SELECT '[1, 2, 3]'::JSONB->3

-- sqlfmt-corpus-separator --

SELECT '[1, 2, 3]'::JSONB->>0

-- sqlfmt-corpus-separator --

SELECT '[1, 2, 3]'::JSONB->>3

-- sqlfmt-corpus-separator --

SELECT '[1, 2]'::JSONB <@ '[1, 2, 3]'::JSONB

-- sqlfmt-corpus-separator --

SELECT '[1, 2]'::JSONB @> '[1, 2, 3]'::JSONB

-- sqlfmt-corpus-separator --

SELECT '[1,1,2]'::JSONB @> '[1,2,2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,2,2]'::JSONB <@ '[1,1,2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,2,2]'::JSONB <@ '[1,2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSON || '[4,5,6]'::JSON

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSONB - 0

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::JSONB - 1

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::VECTOR::FLOAT4[];

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::VECTOR::FLOAT8[];

-- sqlfmt-corpus-separator --

SELECT '[1,2,3]'::vector <-> '[4,5,6]'::vector

-- sqlfmt-corpus-separator --

SELECT '[1,2]'::JSONB @> '[1,2,2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[2, "hi", {"b": ["bar", {"c": 4}]}]'::jsonb -> _int FROM many_types

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

SELECT '\"regression_53686\"'::regclass

-- sqlfmt-corpus-separator --

SELECT '\400'::bytea

-- sqlfmt-corpus-separator --

SELECT 'a'::CITEXT < 'A'::CITEXT;

-- sqlfmt-corpus-separator --

SELECT 'a'::ab_58710

-- sqlfmt-corpus-separator --

SELECT 'a'::corrupt_backref_typ

-- sqlfmt-corpus-separator --

SELECT 'a'::regclass

-- sqlfmt-corpus-separator --

SELECT 'a.b.c'::LTREE::TEXT

-- sqlfmt-corpus-separator --

SELECT 'a.b.c'::LTREE::TEXT::LTREE = 'a.b.c'::LTREE

-- sqlfmt-corpus-separator --

SELECT 'ab'::PG_LSN;

-- sqlfmt-corpus-separator --

SELECT 'array_in'::REGPROC, 'pg_catalog.array_in'::REGPROC

-- sqlfmt-corpus-separator --

SELECT 'array_in(int)'::REGPROCEDURE, 'pg_catalog.array_in(int)'::REGPROCEDURE

-- sqlfmt-corpus-separator --

SELECT 'blah ()'::REGPROC

-- sqlfmt-corpus-separator --

SELECT 'blah'::REGCLASS

-- sqlfmt-corpus-separator --

SELECT 'blah'::REGNAMESPACE

-- sqlfmt-corpus-separator --

SELECT 'blah'::REGPROC

-- sqlfmt-corpus-separator --

SELECT 'blah'::REGROLE

-- sqlfmt-corpus-separator --

SELECT 'blah'::REGTYPE

-- sqlfmt-corpus-separator --

SELECT 'blah( )'::REGPROC

-- sqlfmt-corpus-separator --

SELECT 'blah()'::REGPROCEDURE

-- sqlfmt-corpus-separator --

SELECT 'blah(, )'::REGPROC

-- sqlfmt-corpus-separator --

SELECT 'blah(ignored)'::REGPROC

-- sqlfmt-corpus-separator --

SELECT 'blah(int, int)'::REGPROCEDURE

-- sqlfmt-corpus-separator --

SELECT 'bool'::REGTYPE, 'bool'::REGTYPE::OID

-- sqlfmt-corpus-separator --

SELECT 'box(0 0,1 1)'::box2d && 'box(1 1,2 2)'::box2d

-- sqlfmt-corpus-separator --

SELECT 'c'::ab_58710

-- sqlfmt-corpus-separator --

SELECT 'character varying'::regtype::oid

-- sqlfmt-corpus-separator --

SELECT 'clock'::cache

-- sqlfmt-corpus-separator --

SELECT 'decimal(18,2)'::regtype::oid

-- sqlfmt-corpus-separator --

SELECT 'ends.with.dot.'::LTREE

-- sqlfmt-corpus-separator --

SELECT 'epoch'::date, 'infinity'::date, '-infinity'::date

-- sqlfmt-corpus-separator --

SELECT 'false'::jsonb->-2, 'false'::jsonb->-1, 'false'::jsonb->0, 'false'::jsonb->1

-- sqlfmt-corpus-separator --

SELECT 'false'::jsonb->>-2, 'false'::jsonb->>-1, 'false'::jsonb->>0, 'false'::jsonb->>1

-- sqlfmt-corpus-separator --

SELECT 'fat cats chased fat, out of shape rats' @@ 'fat rats'::tsvector

-- sqlfmt-corpus-separator --

SELECT 'fat rats'::tsvector @@ 'fat cats chased fat, out of shape rats'

-- sqlfmt-corpus-separator --

SELECT 'fat rats'::tsvector @@ 'fat'

-- sqlfmt-corpus-separator --

SELECT 'fat' @@ 'fat rats'::tsvector

-- sqlfmt-corpus-separator --

SELECT 'folder/subfolder'::LTREE

-- sqlfmt-corpus-separator --

SELECT 'foo <23842937> bar'::tsquery

-- sqlfmt-corpus-separator --

SELECT 'foo'::BPCHAR

-- sqlfmt-corpus-separator --

SELECT 'foo'::BPCHAR != 'foo   '

-- sqlfmt-corpus-separator --

SELECT 'foo'::BPCHAR < 'foo   '

-- sqlfmt-corpus-separator --

SELECT 'foo'::BPCHAR <= 'foo   '

-- sqlfmt-corpus-separator --

SELECT 'foo'::BPCHAR = 'foo   '

-- sqlfmt-corpus-separator --

SELECT 'foo'::BPCHAR > 'foo   '

-- sqlfmt-corpus-separator --

SELECT 'foo'::BPCHAR >= 'foo   '

-- sqlfmt-corpus-separator --

SELECT 'foo'::BPCHAR LIKE 'foo   '

-- sqlfmt-corpus-separator --

SELECT 'foo'::BPCHAR ~ 'foo   '

-- sqlfmt-corpus-separator --

SELECT 'foo'::NAME::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR < 'foo'::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR < 'foo'::TEXT;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR < NULL;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR <= 'foo'::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR <= 'foo'::TEXT;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR <= NULL;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR = 'foo'::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR = 'foo'::TEXT;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR = NULL;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR > 'foo'::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR > 'foo'::TEXT;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR > NULL;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR >= 'foo'::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR >= 'foo'::TEXT;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR >= NULL;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR(2);

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR::NAME;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR::TEXT;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR::VARCHAR;

-- sqlfmt-corpus-separator --

SELECT 'foo'::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 'foo'::TEXT::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 'foo'::VARCHAR::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 'foo'::myenum::blob;

-- sqlfmt-corpus-separator --

SELECT 'foo'::myenum::bytea;

-- sqlfmt-corpus-separator --

SELECT 'foo'::myenum::bytes;

-- sqlfmt-corpus-separator --

SELECT 'foo.'::REGTYPE

-- sqlfmt-corpus-separator --

SELECT 'foo.bar'::VARCHAR::LTREE

-- sqlfmt-corpus-separator --

SELECT 'foo.pg_constraint'::REGCLASS

-- sqlfmt-corpus-separator --

SELECT 'foo:1,2 bar:3'::tsvector @@ 'foo <-> bar'::tsquery, 'foo <-> bar'::tsquery @@ 'foo:1,2 bar:3'::tsvector

-- sqlfmt-corpus-separator --

SELECT 'foo:1,2 bar:4B'::tsvector @@ 'foo <2> bar'::tsquery, 'foo:1,2 bar:4B' @@ 'foo <-> bar'::tsquery

-- sqlfmt-corpus-separator --

SELECT 'foo:293847298347'::tsvector

-- sqlfmt-corpus-separator --

SELECT 'goodbye'::greeting

-- sqlfmt-corpus-separator --

SELECT 'has spaces'::LTREE

-- sqlfmt-corpus-separator --

SELECT 'has@symbol'::LTREE

-- sqlfmt-corpus-separator --

SELECT 'hello world'::d_char5

-- sqlfmt-corpus-separator --

SELECT 'hello world'::d_vc5

-- sqlfmt-corpus-separator --

SELECT 'hello' LIKE v FROM kvString WHERE k LIKE 'like%' ORDER BY k

-- sqlfmt-corpus-separator --

SELECT 'hello'::greeting != 'howdy', 'hi' > 'hello'::greeting

-- sqlfmt-corpus-separator --

SELECT 'hello'::greeting < 'bye'::farewell

-- sqlfmt-corpus-separator --

SELECT 'hello'::greeting <= 'bye'::farewell

-- sqlfmt-corpus-separator --

SELECT 'hello'::greeting = 'bye'::farewell

-- sqlfmt-corpus-separator --

SELECT 'hello'::greeting = 'notagreeting'

-- sqlfmt-corpus-separator --

SELECT 'hello'::greeting, 'howdy'::greeting, 'hi'::greeting

-- sqlfmt-corpus-separator --

SELECT 'hello'::greeting, x1 FROM greeting_table

-- sqlfmt-corpus-separator --

SELECT 'hello'::greeting::greeting

-- sqlfmt-corpus-separator --

SELECT 'hello'::greeting::greeting2

-- sqlfmt-corpus-separator --

SELECT 'hello'::greeting::string

-- sqlfmt-corpus-separator --

SELECT 'hello'::greetings

-- sqlfmt-corpus-separator --

SELECT 'hello'::t

-- sqlfmt-corpus-separator --

SELECT 'hello'::test

-- sqlfmt-corpus-separator --

SELECT 'hello'::typ

-- sqlfmt-corpus-separator --

SELECT 'hi'::d_char5

-- sqlfmt-corpus-separator --

SELECT 'hi'::d_vc5

-- sqlfmt-corpus-separator --

SELECT 'hi'::greetings

-- sqlfmt-corpus-separator --

SELECT 'hi'::new__name

-- sqlfmt-corpus-separator --

SELECT 'hi'::new_name

-- sqlfmt-corpus-separator --

SELECT 'hi'::newname

-- sqlfmt-corpus-separator --

SELECT 'hi'::renameagain

-- sqlfmt-corpus-separator --

SELECT 'howdy'::greetings

-- sqlfmt-corpus-separator --

SELECT 'inf'::decimal + '-inf'::decimal

-- sqlfmt-corpus-separator --

SELECT 'inf'::numeric / '0'

-- sqlfmt-corpus-separator --

SELECT 'infinity'::date + 1, 'infinity'::date - 1, '-infinity'::date + 1, '-infinity'::date - 1

-- sqlfmt-corpus-separator --

SELECT 'infinity'::date - 'infinity'::date

-- sqlfmt-corpus-separator --

SELECT 'infinity'::timestamp + '1 second'::interval, 'infinity'::timestamp - '1 second'::interval;

-- sqlfmt-corpus-separator --

SELECT 'infinity'::timestamp = 'infinity'::timestamp, '-infinity'::timestamp = '-infinity'::timestamp;

-- sqlfmt-corpus-separator --

SELECT 'infinity'::timestamp > '294276-12-31 23:59:59.999999'::timestamp;

-- sqlfmt-corpus-separator --

SELECT 'infinity'::timestamp, '-infinity'::timestamptz

-- sqlfmt-corpus-separator --

SELECT 'invalid..path'::LTREE

-- sqlfmt-corpus-separator --

SELECT 'invalid.more.pg_catalog.upper'::REGPROCEDURE

-- sqlfmt-corpus-separator --

SELECT 'james'::names

-- sqlfmt-corpus-separator --

SELECT 'jimmy'::names

-- sqlfmt-corpus-separator --

SELECT 'johnny'::names

-- sqlfmt-corpus-separator --

SELECT 'last'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT 'lax $'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT 'lru'::cache

-- sqlfmt-corpus-separator --

SELECT 'lru'::store

-- sqlfmt-corpus-separator --

SELECT 'no_such_func'::REGPROC;

-- sqlfmt-corpus-separator --

SELECT 'null'::jsonb->-2, 'null'::jsonb->-1, 'null'::jsonb->0, 'null'::jsonb->1

-- sqlfmt-corpus-separator --

SELECT 'null'::jsonb->>-2, 'null'::jsonb->>-1, 'null'::jsonb->>0, 'null'::jsonb->>1

-- sqlfmt-corpus-separator --

SELECT 'numeric(10,3)'::REGTYPE, 'numeric( 10, 3 )'::REGTYPE

-- sqlfmt-corpus-separator --

SELECT 'path.to.item#1'::LTREE

-- sqlfmt-corpus-separator --

SELECT 'pg_catalog."radians"""'::regproc

-- sqlfmt-corpus-separator --

SELECT 'pg_catalog."radians"'::regproc

-- sqlfmt-corpus-separator --

SELECT 'pg_catalog."radians"("float4")'::regprocedure

-- sqlfmt-corpus-separator --

SELECT 'pg_catalog.int'::REGTYPE

-- sqlfmt-corpus-separator --

SELECT 'pg_class'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT 'pg_constraint '::REGCLASS, '  pg_constraint '::REGCLASS

-- sqlfmt-corpus-separator --

SELECT 'pg_constraint'::REGCLASS, 'pg_catalog.pg_constraint'::REGCLASS

-- sqlfmt-corpus-separator --

SELECT 'pg_namespace'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT 'pg_proc'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT 'pg_type'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT 'proc_f'::REGPROC;

-- sqlfmt-corpus-separator --

SELECT 'public'::REGNAMESPACE, 'public'::REGNAMESPACE::OID

-- sqlfmt-corpus-separator --

SELECT 'public.regression_53686"'::regclass

-- sqlfmt-corpus-separator --

SELECT 'regression_53686"'::regclass

-- sqlfmt-corpus-separator --

SELECT 'regression_69907'::oid

-- sqlfmt-corpus-separator --

SELECT 'root'::REGROLE, 'root'::REGROLE::OID

-- sqlfmt-corpus-separator --

SELECT 'root=rw*/admin'::aclitem

-- sqlfmt-corpus-separator --

SELECT 'sTrict $'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT 'sc.proc_f_2'::REGPROC;

-- sqlfmt-corpus-separator --

SELECT 'sqrt'::REGPROC

-- sqlfmt-corpus-separator --

SELECT 'strIct $.STRIcT'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT 'strict $'::JSONPATH

-- sqlfmt-corpus-separator --

SELECT 'test' = 'TEST'::CITEXT;

-- sqlfmt-corpus-separator --

SELECT 'test'::CITEXT = 'TEST'::CITEXT;

-- sqlfmt-corpus-separator --

SELECT 'test'::CITEXT = 'TEST';

-- sqlfmt-corpus-separator --

SELECT 'test'::CITEXT = 'TESTER';

-- sqlfmt-corpus-separator --

SELECT 'test'::CITEXT ILIKE 'TEST'::CITEXT;

-- sqlfmt-corpus-separator --

SELECT 'test'::CITEXT LIKE 'TEST';

-- sqlfmt-corpus-separator --

SELECT 'test..double.dot'::LTREE

-- sqlfmt-corpus-separator --

SELECT 'test.label with space'::LTREE

-- sqlfmt-corpus-separator --

SELECT 'test.label$var'::LTREE

-- sqlfmt-corpus-separator --

SELECT 'test.label@domain'::LTREE

-- sqlfmt-corpus-separator --

SELECT 'testuser=r/root'::aclitem

-- sqlfmt-corpus-separator --

SELECT 'this will be ignored'::void

-- sqlfmt-corpus-separator --

SELECT 'trailing.dot.'::LTREE

-- sqlfmt-corpus-separator --

SELECT 'true'::JSON, 'false'::JSON, 'null'::JSON

-- sqlfmt-corpus-separator --

SELECT 'true'::jsonb->-2, 'true'::jsonb->-1, 'true'::jsonb->0, 'true'::jsonb->1

-- sqlfmt-corpus-separator --

SELECT 'true'::jsonb->>-2, 'true'::jsonb->>-1, 'true'::jsonb->>0, 'true'::jsonb->>1

-- sqlfmt-corpus-separator --

SELECT 'typ'::regtype

-- sqlfmt-corpus-separator --

SELECT 'upper'::REGPROC, 'upper(string)'::REGPROCEDURE, 'pg_catalog.upper(string)'::REGPROCEDURE, 'upper'::REGPROC::OID

-- sqlfmt-corpus-separator --

SELECT 'upper'::REGPROC, 'upper(string)'::REGPROCEDURE, 'upper'::REGPROC::OID

-- sqlfmt-corpus-separator --

SELECT 'upper'::REGPROCEDURE

-- sqlfmt-corpus-separator --

SELECT 'upper(int)'::REGPROCEDURE

-- sqlfmt-corpus-separator --

SELECT 'upper(string)'::REGPROC

-- sqlfmt-corpus-separator --

SELECT 'user1=*r/'::aclitem

-- sqlfmt-corpus-separator --

SELECT 'user1=/'::aclitem

-- sqlfmt-corpus-separator --

SELECT 'user1=arwdDxtXUCTcsAm/'::aclitem

-- sqlfmt-corpus-separator --

SELECT 'user1=r'::aclitem

-- sqlfmt-corpus-separator --

SELECT 'user1=r*w/'::aclitem

-- sqlfmt-corpus-separator --

SELECT 'user1=r/"unterminated'::aclitem

-- sqlfmt-corpus-separator --

SELECT 'user1=r/grantor extra'::aclitem

-- sqlfmt-corpus-separator --

SELECT 'user1=r/grantor1'::aclitem

-- sqlfmt-corpus-separator --

SELECT 'user1=z/'::aclitem

-- sqlfmt-corpus-separator --

SELECT 'user1rw/'::aclitem

-- sqlfmt-corpus-separator --

SELECT 'x.y.z'::LTREE::STRING

-- sqlfmt-corpus-separator --

SELECT 'xAb'::STRING::BIT(8), 'XaB'::STRING::BIT(8)

-- sqlfmt-corpus-separator --

SELECT 'xZZ'::BIT(8)

-- sqlfmt-corpus-separator --

SELECT 'yo'::greetings

-- sqlfmt-corpus-separator --

SELECT '{ "name": "Bob", "tags": [ "enim", "qui"]}'::JSONB @> '{"tags":["qu"]}'

-- sqlfmt-corpus-separator --

SELECT '{"(1, 3)", "(1, 2)"}'::a[]

-- sqlfmt-corpus-separator --

SELECT '{"a": "b", "c": "d"}'::JSON

-- sqlfmt-corpus-separator --

SELECT '{"a": "b"}'::JSONB->>'a'

-- sqlfmt-corpus-separator --

SELECT '{"a": "b"}'::JSONB::STRING

-- sqlfmt-corpus-separator --

SELECT '{"a": "c", "b": null}'::jsonb -> 'b';

-- sqlfmt-corpus-separator --

SELECT '{"a": "c", "b": null}'::jsonb ->> 'b';

-- sqlfmt-corpus-separator --

SELECT '{"a": 1, "a": 2}'::JSON

-- sqlfmt-corpus-separator --

SELECT '{"a": 1, "b": 1}'::JSONB ? 'a', '{"a": 1, "b": 1}'::JSONB ? 'b'

-- sqlfmt-corpus-separator --

SELECT '{"a": 1, "b": 2}'::JSON || '"c"'

-- sqlfmt-corpus-separator --

SELECT '{"a": 1, "b": 2}'::JSON || '{"b": 3, "c": 4}'

-- sqlfmt-corpus-separator --

SELECT '{"a": 1, "b": 2}'::JSONB->'b'

-- sqlfmt-corpus-separator --

SELECT '{"a": 1, "b": 2}'::JSONB->'c', '{"c": 1}'::JSONB->'a'

-- sqlfmt-corpus-separator --

SELECT '{"a": 1, "b": 2}'::JSONB->>'b'

-- sqlfmt-corpus-separator --

SELECT '{"a": 1, "b": 2}'::JSONB->>'c', '{"c": 1}'::JSONB->>'a'

-- sqlfmt-corpus-separator --

SELECT '{"a": 1, "b": {"c": 3}}'::JSONB->'b'->'c'

-- sqlfmt-corpus-separator --

SELECT '{"a": 1, "c": {"foo": "bar"}}'::JSON

-- sqlfmt-corpus-separator --

SELECT '{"a": 1}'::JSONB - 'a'

-- sqlfmt-corpus-separator --

SELECT '{"a": 1}'::JSONB - 'b'

-- sqlfmt-corpus-separator --

SELECT '{"a": 1}'::JSONB ? 'a', '{"a": 1}'::JSONB ? 'b'

-- sqlfmt-corpus-separator --

SELECT '{"a": 1}'::JSONB#>'{a}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a": 1}'::JSONB#>>'{a}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a": 1}'::JSONB->'a'

-- sqlfmt-corpus-separator --

SELECT '{"a": ["b"]}'::JSONB#>'{a,0}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a": ["b"]}'::JSONB#>'{a,b}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a": ["b"]}'::JSONB#>>'{a,0}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a": ["b"]}'::JSONB#>>'{a,b}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a": [1, 2, 3]}'::JSONB->'a' @> '2'::JSONB

-- sqlfmt-corpus-separator --

SELECT '{"a": [null]}'::JSONB#>>'{a,0}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> '';

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> 'z';

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> 1;

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> null::text;

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> '';

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> 'z';

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> 1;

-- sqlfmt-corpus-separator --

SELECT '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> null::text;

-- sqlfmt-corpus-separator --

SELECT '{"a": {"b": "c"}}'::JSONB#>'{a,b}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{"a": {"b": "c"}}'::JSONB#>>'{a,b}'::STRING[]

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

SELECT '{"a":"b"}'::JSONB <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"c"}'::JSONB <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":null}'::JSONB->>'a'

-- sqlfmt-corpus-separator --

SELECT '{"abc\nxyz"}'::STRING[]

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

SELECT '{'::JSON

-- sqlfmt-corpus-separator --

SELECT '{0101000020e6100000cdcccccccc4c1b40cdcccccccc8c4740:0101000020e6100000333333333333fd3fcdcccccccc0c4640}'::geography[];

-- sqlfmt-corpus-separator --

SELECT '{0101000020e6100000cdcccccccc4c1b40cdcccccccc8c4740:0101000020e6100000333333333333fd3fcdcccccccc0c4640}'::geometry[];

-- sqlfmt-corpus-separator --

SELECT '{a,b}'::enum_test[] = '{a,b}'

-- sqlfmt-corpus-separator --

SELECT '{hello, a🐛b🏠c}'::VARCHAR(2)[]

-- sqlfmt-corpus-separator --

SELECT '{hello,"hello"}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT '{hello}'::VARCHAR(2)[]

-- sqlfmt-corpus-separator --

SELECT '{}'::JSON

-- sqlfmt-corpus-separator --

SELECT '{}'::JSONB - 1

-- sqlfmt-corpus-separator --

SELECT '{}'::JSONB[]

-- sqlfmt-corpus-separator --

SELECT '|' || to_char(-0.0001022871::numeric, ',9GPRD') || '|'

-- sqlfmt-corpus-separator --

SELECT '|' || to_char(-861.564442::numeric, 'B9D,') || '|'

-- sqlfmt-corpus-separator --

SELECT '|' || to_char(0::numeric, ',RND,') || '|'

-- sqlfmt-corpus-separator --

SELECT '|' || to_char(0::numeric, 'RN9') || '|'

-- sqlfmt-corpus-separator --

SELECT '|' || to_char(156::numeric, 'RNPL9MI') || '|'

-- sqlfmt-corpus-separator --

SELECT '|' || to_char(26.565898::numeric, 'S9D,') || '|'

-- sqlfmt-corpus-separator --

SELECT '|' || to_char(986.214295::numeric, 'RN9MIVTH') || '|'

-- sqlfmt-corpus-separator --

SELECT 'ß'::CITEXT = 'SS'::CITEXT;

-- sqlfmt-corpus-separator --

SELECT ('24:00:00'::TIME)::STRING

-- sqlfmt-corpus-separator --

SELECT ('gone'::void)::text

-- sqlfmt-corpus-separator --

SELECT ('this will disappear too'::text)::void

-- sqlfmt-corpus-separator --

SELECT (-1)::OID

-- sqlfmt-corpus-separator --

SELECT (-1)::REGCLASS

-- sqlfmt-corpus-separator --

SELECT (-1)::REGPROC

-- sqlfmt-corpus-separator --

SELECT (-1)::d_myint

-- sqlfmt-corpus-separator --

SELECT (-1)::d_recreate

-- sqlfmt-corpus-separator --

SELECT (1.4238790346995263e-40::DECIMAL / 6.011482313728436e+41::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT (SELECT DISTINCT ON (a) a FROM abc ORDER BY a, b||'foo') || 'bar';

-- sqlfmt-corpus-separator --

SELECT (avg(d) OVER (PARTITION BY v ORDER BY w) + avg(d) OVER (PARTITION BY v ORDER BY w)) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT (avg(d) OVER (PARTITION BY v ORDER BY w) + avg(d) OVER (PARTITION BY w ORDER BY v)) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT (timestamp '2016-02-10 19:46:33.306157519')::string

-- sqlfmt-corpus-separator --

SELECT (timestamptz '2016-02-10 19:46:33.306157519')::string

-- sqlfmt-corpus-separator --

SELECT * FROM b WHERE a LIKE '%foo%'

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.backward_dependencies WHERE descriptor_name LIKE 'blog_posts'

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.backward_dependencies WHERE descriptor_name LIKE 'moretest_%' ORDER BY descriptor_id, index_id, dependson_type, dependson_id, dependson_index_id

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.backward_dependencies WHERE descriptor_name LIKE 'test_%' ORDER BY descriptor_id, index_id, dependson_type, dependson_id, dependson_index_id

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.create_type_statements WHERE descriptor_id = 'foo'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.forward_dependencies WHERE descriptor_name LIKE 'blog_posts%'

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.forward_dependencies WHERE descriptor_name LIKE 'moretest_%' ORDER BY descriptor_id, index_id, dependedonby_type, dependedonby_id, dependedonby_index_id

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.forward_dependencies WHERE descriptor_name LIKE 'test_%' ORDER BY descriptor_id, index_id, dependedonby_type, dependedonby_id, dependedonby_index_id

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.index_columns WHERE descriptor_name LIKE 'test_%' ORDER BY descriptor_id, index_id, column_type, column_id

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.table_columns WHERE descriptor_name LIKE 'test_%' ORDER BY descriptor_id, column_id

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> (NULL::JSONB) ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM e WHERE x LIKE '%' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM e WHERE x LIKE '%b%'

-- sqlfmt-corpus-separator --

SELECT * FROM e WHERE x LIKE '%bc'

-- sqlfmt-corpus-separator --

SELECT * FROM e WHERE x LIKE ''

-- sqlfmt-corpus-separator --

SELECT * FROM e WHERE x LIKE 'a%c'

-- sqlfmt-corpus-separator --

SELECT * FROM e WHERE x LIKE 'ab%'

-- sqlfmt-corpus-separator --

SELECT * FROM e WHERE x NOT LIKE '%'

-- sqlfmt-corpus-separator --

SELECT * FROM e WHERE x NOT LIKE '%b%'

-- sqlfmt-corpus-separator --

SELECT * FROM e WHERE x NOT LIKE '%bc'

-- sqlfmt-corpus-separator --

SELECT * FROM e WHERE x NOT LIKE '' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM e WHERE x NOT LIKE 'a%c'

-- sqlfmt-corpus-separator --

SELECT * FROM e WHERE x NOT LIKE 'ab%'

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.parameters WHERE specific_name LIKE 'get_byte%' ORDER BY specific_name, ordinal_position

-- sqlfmt-corpus-separator --

SELECT * FROM json_tab WHERE b @> '[1]' OR sqrt(a::decimal) = 2 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM kv GROUP BY v, count(DISTINCT w)

-- sqlfmt-corpus-separator --

SELECT * FROM kv GROUP BY v, count(w) OVER ()

-- sqlfmt-corpus-separator --

SELECT * FROM l WHERE lt <@ 'A.B'::LTREE ORDER BY lt;

-- sqlfmt-corpus-separator --

SELECT * FROM l WHERE lt @> 'A.B'::LTREE ORDER BY lt;

-- sqlfmt-corpus-separator --

SELECT * FROM la WHERE lta <@ 'A.B'::LTREE ORDER BY lta;

-- sqlfmt-corpus-separator --

SELECT * FROM la WHERE lta @> 'A.B'::LTREE ORDER BY lta;

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_description WHERE objoid = 't'::regclass::OID;

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_operator where oprname='+' and oprleft='float8'::regtype

-- sqlfmt-corpus-separator --

SELECT * FROM s WHERE d = 'inf'::decimal

-- sqlfmt-corpus-separator --

SELECT * FROM system.namespace WHERE name LIKE '%48233'

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE a = '2015-08-25 04:45:45.53453+01:00'::timestamp

-- sqlfmt-corpus-separator --

SELECT * FROM t1, t2 WHERE a = b AND age(b, TIMESTAMPTZ '2017-01-01') > INTERVAL '1 day'

-- sqlfmt-corpus-separator --

SELECT * FROM t147559 WHERE b LIKE 'abc%';

-- sqlfmt-corpus-separator --

SELECT * FROM t47131_0 WHERE (t47131_0.c0 + t47131_0.c0::INT4) = 0

-- sqlfmt-corpus-separator --

SELECT * FROM u WHERE token < '63616665-6630-3064-6465-616462656564'::uuid

-- sqlfmt-corpus-separator --

SELECT * FROM u WHERE token <= '63616665-6630-3064-6465-616462656564'::uuid ORDER BY token

-- sqlfmt-corpus-separator --

SELECT * from pg_timezone_names WHERE name LIKE 'Pacific/Honolulu%'

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY w LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY w, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY y, w LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY w, z ORDER BY y) FROM wxyz ORDER BY w, z, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY w, z ORDER BY y) FROM wxyz ORDER BY z, w, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY z ORDER BY y) FROM wxyz ORDER BY y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY w LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY w, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY y, w LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY w, z ORDER BY y) FROM wxyz ORDER BY w, z, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY w, z ORDER BY y) FROM wxyz ORDER BY z, w, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY z ORDER BY y) FROM wxyz ORDER BY y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY w LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY w, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY y, w LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY w, z ORDER BY y) FROM wxyz ORDER BY w, z, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY w, z ORDER BY y) FROM wxyz ORDER BY z, w, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY z ORDER BY y) FROM wxyz ORDER BY y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT - -0.00::decimal, - - -0.00::decimal, - - -0.00, - -0.00

-- sqlfmt-corpus-separator --

SELECT 0::DECIMAL / 'infinity'::DECIMAL;

-- sqlfmt-corpus-separator --

SELECT 0::REGROLE, 0::REGROLE::TEXT;

-- sqlfmt-corpus-separator --

SELECT 1 FROM kv GROUP BY 1 HAVING sum(1) OVER (PARTITION BY 1) > 1

-- sqlfmt-corpus-separator --

SELECT 1 FROM kv GROUP BY v, w::DECIMAL HAVING w::DECIMAL > 1

-- sqlfmt-corpus-separator --

SELECT 1.00::decimal(6,4)

-- sqlfmt-corpus-separator --

SELECT 1.0::DECIMAL::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT 100126::regproc;

-- sqlfmt-corpus-separator --

SELECT 101.00::decimal(4,6)

-- sqlfmt-corpus-separator --

SELECT 101.00::decimal(6,4)

-- sqlfmt-corpus-separator --

SELECT 123.45::d_dec

-- sqlfmt-corpus-separator --

SELECT 1::OID, 1::REGCLASS, 1::REGNAMESPACE, 1::REGPROC, 1::REGPROCEDURE, 1::REGROLE, 1::REGTYPE

-- sqlfmt-corpus-separator --

SELECT 1::OID::REGCLASS, 1::OID::REGNAMESPACE, 1::OID::REGPROC, 1::OID::REGPROCEDURE, 1::OID::REGROLE, 1::OID::REGTYPE

-- sqlfmt-corpus-separator --

SELECT 1::OID::TEXT, quote_literal(1::OID)

-- sqlfmt-corpus-separator --

SELECT 1::TRIGGER;

-- sqlfmt-corpus-separator --

SELECT 1::decimal(2, 2)

-- sqlfmt-corpus-separator --

SELECT 1e-16::DECIMAL / 2, 1e-16::DECIMAL / 3, 1e-16::DECIMAL / 2 * 2

-- sqlfmt-corpus-separator --

SELECT 23414123414::int2

-- sqlfmt-corpus-separator --

SELECT 3::OID, '3'::OID

-- sqlfmt-corpus-separator --

SELECT 4061301040::REGCLASS

-- sqlfmt-corpus-separator --

SELECT 42::d_myint

-- sqlfmt-corpus-separator --

SELECT 5::d_recreate

-- sqlfmt-corpus-separator --

SELECT 7133080445639580613::INT8 + '1977-11-03'::DATE

-- sqlfmt-corpus-separator --

SELECT 999999::regproc;

-- sqlfmt-corpus-separator --

SELECT B'1000101'::BIT(4)::STRING,
       B'1000101'::BIT(4),
       B'1000101'

-- sqlfmt-corpus-separator --

SELECT B'11' >= _varbit FROM many_types

-- sqlfmt-corpus-separator --

SELECT B'AB'::BIT(8)

-- sqlfmt-corpus-separator --

SELECT BIT(4) '1101', BIT(1) '1010'

-- sqlfmt-corpus-separator --

SELECT CAST ('pg_constraint' AS REGCLASS)

-- sqlfmt-corpus-separator --

SELECT CAST('' AS d_nonempty_text)

-- sqlfmt-corpus-separator --

SELECT CAST('hello' AS d_nonempty_text)

-- sqlfmt-corpus-separator --

SELECT CAST('{"a": "b"}'::JSONB AS STRING)

-- sqlfmt-corpus-separator --

SELECT CAST(-1 AS d_pos_int)

-- sqlfmt-corpus-separator --

SELECT CAST(-1 AS d_pos_nn)

-- sqlfmt-corpus-separator --

SELECT CAST(-5 AS d_bounded)

-- sqlfmt-corpus-separator --

SELECT CAST(0 AS d_pos_int)

-- sqlfmt-corpus-separator --

SELECT CAST(1 AS d_pos_int)

-- sqlfmt-corpus-separator --

SELECT CAST(100 AS d_pos_int)

-- sqlfmt-corpus-separator --

SELECT CAST(200 AS d_bounded)

-- sqlfmt-corpus-separator --

SELECT CAST(42 AS d_nn_int)

-- sqlfmt-corpus-separator --

SELECT CAST(5 AS d_pos_nn)

-- sqlfmt-corpus-separator --

SELECT CAST(50 AS d_bounded)

-- sqlfmt-corpus-separator --

SELECT CAST(NULL AS LTREE)

-- sqlfmt-corpus-separator --

SELECT CAST(NULL AS d_nn_int)

-- sqlfmt-corpus-separator --

SELECT CAST(NULL AS d_nonempty_text)

-- sqlfmt-corpus-separator --

SELECT CAST(NULL AS d_pos_int)

-- sqlfmt-corpus-separator --

SELECT CAST(NULL AS d_pos_nn)

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

SELECT DATE '2000-01-01', DATE '2000-12-31', DATE '1993-05-16'

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

SELECT DISTINCT ON (a, b) a, b FROM abc ORDER BY a, b, c

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a, c) a, b FROM abc ORDER BY a, c, b

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a,b,c) a, b, c FROM abc

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

SELECT DISTINCT ON (x,y,z) x, y, z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x,y,z) x, y, z FROM xyz ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y) x, y FROM xyz ORDER BY y, x

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

SELECT False::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT IF(nextval('s')<3, crdb_internal.force_retry('1h'::INTERVAL), 0);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 nanosecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 ns';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '10000000000000000000000000000000000 year'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '4 minutes' + DATE '1999-01-01'

-- sqlfmt-corpus-separator --

SELECT NOT (prorettype::regtype::text = 'foo') AND proretset FROM pg_proc WHERE proretset=false LIMIT 1

-- sqlfmt-corpus-separator --

SELECT NULL::JSON

-- sqlfmt-corpus-separator --

SELECT NULL::LTREE

-- sqlfmt-corpus-separator --

SELECT NULL::LTREE::TEXT

-- sqlfmt-corpus-separator --

SELECT NULL::REFCURSOR;

-- sqlfmt-corpus-separator --

SELECT NULL::TRIGGER;

-- sqlfmt-corpus-separator --

SELECT NULL::TRIGGER[];

-- sqlfmt-corpus-separator --

SELECT NULL::geometry, NULL::geography

-- sqlfmt-corpus-separator --

SELECT ST_AsEWKT(ST_MakeEnvelope(5.0::FLOAT8, 4.0::FLOAT8, 8.0::FLOAT8, 2.0::FLOAT8)::GEOMETRY);

-- sqlfmt-corpus-separator --

SELECT ST_AsEWKT(ST_MakeEnvelope(8.0::FLOAT8, 2.0::FLOAT8, 5.0::FLOAT8, 4.0::FLOAT8)::GEOMETRY);

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_GeneratePoints('POLYGON((0 0, 1 1, 1 1, 0 0))'::geometry, 4, 1))

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_GeneratePoints('POLYGON((0 0,2 5,2.5 4,3 5,3 1,0 0))'::geometry, 5, 0))

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_GeneratePoints('POLYGON((0 0,2 5,2.5 4,3 5,3 1,0 0))'::geometry, 5, 1996)::geometry, 5)

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_Project('POINT(0 0)'::geography, 100000, radians(45.0)))

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_Segmentize('MULTIPOINT (0 0, 1 1)'::geography, -1))

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_Segmentize('MULTIPOINT (0 0, 1 1)'::geometry, -1))

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_Subdivide('POLYGON((-1 -1,-1 -0.5, -1 0, 1 0.5, 1 -1,-1 -1))'::geometry))

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_Subdivide('SRID=4269;LINESTRING(0 0, 10 15, 0 0, 10 15, 10 0, 10 15)'::geometry, 5))

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_VoronoiLines(ST_GeomFromText('MULTIPOINT(50 30, 60 30, 100 100,10 150, 110 120)'))::geometry, 5)

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_VoronoiPolygons(ST_GeomFromText('MULTIPOINT(50 30, 60 30, 100 100,10 150, 110 120)'))::geometry, 1)

-- sqlfmt-corpus-separator --

SELECT ST_Azimuth('POLYGON((0 0, 0 0, 0 0, 0 0))'::geometry, 'POLYGON((0 0, 0 0, 0 0, 0 0))'::geometry)

-- sqlfmt-corpus-separator --

SELECT ST_Azimuth(ST_Point(0, 0)::geography, ST_Point(0, 0)::geography)

-- sqlfmt-corpus-separator --

SELECT ST_Box2DFromGeoHash('F'::TEXT::TEXT::TEXT, NULL::INT4::INT4)::BOX2D;

-- sqlfmt-corpus-separator --

SELECT ST_Box2DFromGeoHash('KKQNPKUE9KTBPE5', NULL)::BOX2D;

-- sqlfmt-corpus-separator --

SELECT ST_Box2DFromGeoHash('kKqNpKuE9KtBpE5', NULL)::BOX2D;

-- sqlfmt-corpus-separator --

SELECT ST_Box2DFromGeoHash('kkqnpkue9ktbpe5', NULL)::BOX2D;

-- sqlfmt-corpus-separator --

SELECT ST_Box2DFromGeoHash(NULL)::BOX2D;

-- sqlfmt-corpus-separator --

SELECT ST_Box2DFromGeoHash(NULL, NULL)::BOX2D;

-- sqlfmt-corpus-separator --

SELECT ST_Centroid('GEOMETRYCOLLECTION(POINT(0 0), LINESTRING EMPTY)'::geography, true)

-- sqlfmt-corpus-separator --

SELECT ST_Extent(ST_GeomFromGeoHash('C'::TEXT, NULL::INT4)::GEOMETRY);

-- sqlfmt-corpus-separator --

SELECT ST_Extent(ST_GeomFromGeoHash(NULL::TEXT, 1::INT4)::GEOMETRY);

-- sqlfmt-corpus-separator --

SELECT ST_Extent(ST_PointFromGeoHash('C'::TEXT, NULL::INT4)::GEOMETRY);

-- sqlfmt-corpus-separator --

SELECT ST_Extent(ST_PointFromGeoHash(NULL::TEXT, 1::INT4)::GEOMETRY);

-- sqlfmt-corpus-separator --

SELECT ST_Intersects('POINT(1 0)'::string, 'abc'::string)

-- sqlfmt-corpus-separator --

SELECT ST_Intersects('abc'::string, 'POINT(1 0)'::string)

-- sqlfmt-corpus-separator --

SELECT ST_LineInterpolatePoint('LINESTRING (0 0, 1 1)'::geometry, -1)

-- sqlfmt-corpus-separator --

SELECT ST_LineInterpolatePoint('MULTILINESTRING ((0 0, 1 1), (1 1, 0 0))'::geometry, 0.2)

-- sqlfmt-corpus-separator --

SELECT ST_LineInterpolatePoint('POINT (0 0)'::geometry, 0.2)

-- sqlfmt-corpus-separator --

SELECT ST_LineInterpolatePoint('POLYGON((-1.0 0.0, 0.0 0.0, 0.0 1.0, -1.0 1.0, -1.0 0.0))'::geometry, 0.2)

-- sqlfmt-corpus-separator --

SELECT ST_LineInterpolatePoints('LINESTRING (0 0, 1 1)'::geometry, -1, false)

-- sqlfmt-corpus-separator --

SELECT ST_LineInterpolatePoints('MULTILINESTRING ((0 0, 1 1), (1 1, 0 0))'::geometry, 0.2, false)

-- sqlfmt-corpus-separator --

SELECT ST_LineInterpolatePoints('POINT (0 0)'::geometry, 0.2, false)

-- sqlfmt-corpus-separator --

SELECT ST_LineInterpolatePoints('POLYGON((-1.0 0.0, 0.0 0.0, 0.0 1.0, -1.0 1.0, -1.0 0.0))'::geometry, 0.2, false)

-- sqlfmt-corpus-separator --

SELECT ST_MakePolygon('LINESTRING EMPTY'::geometry)

-- sqlfmt-corpus-separator --

SELECT ST_Segmentize('POLYGON ((0.0 0.0, 1.0 0.0, 1.0 1.0, 0.0 1.0, 0.0 0.0))'::geometry, -1)

-- sqlfmt-corpus-separator --

SELECT ST_Segmentize('POLYGON((0.0 0.0, 1.0 0.0, 1.0 1.0, 0.0 1.0, 0.0 0.0))'::geography, 0)

-- sqlfmt-corpus-separator --

SELECT ST_Summary('GEOMETRYCOLLECTION(MULTILINESTRING((0 0, 1 0),(2 0, 4 4)),MULTIPOINT(0 0))'::geography)

-- sqlfmt-corpus-separator --

SELECT ST_Summary('GEOMETRYCOLLECTION(MULTILINESTRING((0 0, 1 0),(2 0, 4 4)),MULTIPOINT(0 0))'::geometry)

-- sqlfmt-corpus-separator --

SELECT ST_Summary('MULTIPOINT(0 0)'::geography)

-- sqlfmt-corpus-separator --

SELECT ST_Summary('MULTIPOINT(0 0)'::geometry)

-- sqlfmt-corpus-separator --

SELECT ST_Summary('POINT(0 0)'::geography)

-- sqlfmt-corpus-separator --

SELECT ST_Summary('POINT(0 0)'::geometry)

-- sqlfmt-corpus-separator --

SELECT ST_Summary('SRID=4326;GEOMETRYCOLLECTION(MULTILINESTRING((0 0, 1 0),(2 0, 4 4)),MULTIPOINT(0 0))'::geography)

-- sqlfmt-corpus-separator --

SELECT ST_Summary('SRID=4326;GEOMETRYCOLLECTION(MULTILINESTRING((0 0, 1 0),(2 0, 4 4)),MULTIPOINT(0 0))'::geometry)

-- sqlfmt-corpus-separator --

SELECT ST_Summary('SRID=4326;MULTIPOINT(0 0)'::geography)

-- sqlfmt-corpus-separator --

SELECT ST_Summary('SRID=4326;MULTIPOINT(0 0)'::geometry)

-- sqlfmt-corpus-separator --

SELECT ST_Summary('SRID=4326;POINT(0 0)'::geography)

-- sqlfmt-corpus-separator --

SELECT ST_Summary('SRID=4326;POINT(0 0)'::geometry)

-- sqlfmt-corpus-separator --

SELECT TIME '05:40:00'::TIMETZ

-- sqlfmt-corpus-separator --

SELECT TIME '12:00:00';

-- sqlfmt-corpus-separator --

SELECT TIMETZ '12:00:00-07';

-- sqlfmt-corpus-separator --

SELECT VARBIT(4) '1101', VARBIT(2) '1001'

-- sqlfmt-corpus-separator --

SELECT _float4::FLOAT8, _float8::FLOAT4 FROM t67793

-- sqlfmt-corpus-separator --

SELECT _int4::INT2 FROM t64429

-- sqlfmt-corpus-separator --

SELECT _int8::INT2 FROM t64429

-- sqlfmt-corpus-separator --

SELECT _int8::INT4 FROM t64429

-- sqlfmt-corpus-separator --

SELECT a = '{0}'::oid[] FROM t_oidarr

-- sqlfmt-corpus-separator --

SELECT a FROM tz WHERE b = c::timestamp

-- sqlfmt-corpus-separator --

SELECT a FROM tz WHERE c = d::timestamp

-- sqlfmt-corpus-separator --

SELECT a, b - lag(b, 1) OVER (ORDER BY a) FROM t ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, avg(b) OVER () FROM t ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM abc_decimal, def_decimal WHERE a::string=d::string or a::string=e::string

-- sqlfmt-corpus-separator --

SELECT a, b, c, cume_dist() OVER (PARTITION BY a ORDER BY c) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, c, dense_rank() OVER (PARTITION BY a ORDER BY c) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, c, ntile(2) OVER (PARTITION BY a ORDER BY c) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, c, percent_rank() OVER (PARTITION BY a ORDER BY c) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, c, rank() OVER (PARTITION BY a ORDER BY c) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, cume_dist() OVER () FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, cume_dist() OVER (ORDER BY a) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, dense_rank() OVER () FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, dense_rank() OVER (ORDER BY a) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, ntile(2) OVER (ORDER BY a, b) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, percent_rank() OVER () FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, percent_rank() OVER (ORDER BY a) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, rank() OVER () FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, rank() OVER (ORDER BY a) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, row_number() OVER (ORDER BY a, b) FROM t ORDER BY a, b

-- sqlfmt-corpus-separator --

SELECT a, b, row_number() OVER (PARTITION BY a ORDER BY b) FROM t ORDER BY a, b

-- sqlfmt-corpus-separator --

SELECT a, b, row_number() OVER (PARTITION BY a, b) FROM t ORDER BY a, b

-- sqlfmt-corpus-separator --

SELECT a, json_agg(a) OVER (ORDER BY a) FROM x ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, length(a::STRING) an,
       b, length(b::STRING) bn,
       c, length(c::STRING) cn,
       d, length(d::STRING) dn
  FROM bits
ORDER BY 1,2,3,4,5,6,7,8

-- sqlfmt-corpus-separator --

SELECT a, q FROM c WHERE q = 'bar'::tsquery

-- sqlfmt-corpus-separator --

SELECT a, q FROM c WHERE q > 'abc'::tsquery

-- sqlfmt-corpus-separator --

SELECT a, v FROM b WHERE v = 'bar:2'::tsvector

-- sqlfmt-corpus-separator --

SELECT a, v FROM b WHERE v > 'bar:2'::tsvector

-- sqlfmt-corpus-separator --

SELECT a,b FROM add_default WHERE d > c AND d - c < interval '20s'

-- sqlfmt-corpus-separator --

SELECT a,b FROM add_default WHERE e > d AND e - d < interval '20s'

-- sqlfmt-corpus-separator --

SELECT a::TIME FROM django_37

-- sqlfmt-corpus-separator --

SELECT a::string, b::string, c FROM timetz_test ORDER BY a DESC, c ASC

-- sqlfmt-corpus-separator --

SELECT a::string, b::string, c FROM timetz_test ORDER BY a, c ASC

-- sqlfmt-corpus-separator --

SELECT a::string, b::string, c FROM timetz_test WHERE a = b ORDER BY c

-- sqlfmt-corpus-separator --

SELECT a::string, b::string, c FROM timetz_test WHERE a > b ORDER BY c

-- sqlfmt-corpus-separator --

SELECT a::tsvector @@ b FROM ab

-- sqlfmt-corpus-separator --

SELECT abbrev('10.0/16'::INET)

-- sqlfmt-corpus-separator --

SELECT abbrev('10.1.0.0/16'::INET)

-- sqlfmt-corpus-separator --

SELECT abbrev('192.168.0.1'::INET)

-- sqlfmt-corpus-separator --

SELECT abbrev('192.168.0.1/16'::INET)

-- sqlfmt-corpus-separator --

SELECT abbrev('192.168.0.1/32'::INET)

-- sqlfmt-corpus-separator --

SELECT abbrev('::ffff:192.168.0.1'::INET)

-- sqlfmt-corpus-separator --

SELECT abbrev('::ffff:192.168.0.1/24'::INET)

-- sqlfmt-corpus-separator --

SELECT aclexplode(NULL::text[])

-- sqlfmt-corpus-separator --

SELECT adnum FROM pg_attrdef WHERE adrelid = 't46799'::REGCLASS

-- sqlfmt-corpus-separator --

SELECT age('1957-06-13') - age(now(), '1957-06-13') = interval '0s'

-- sqlfmt-corpus-separator --

SELECT application_name FROM crdb_internal.node_sessions
WHERE active_queries LIKE 'SELECT application_name%'

-- sqlfmt-corpus-separator --

SELECT array_agg('a'::letter)

-- sqlfmt-corpus-separator --

SELECT array_agg(NULL::TEXT)

-- sqlfmt-corpus-separator --

SELECT array_agg(a) OVER () FROM l LIMIT 1

-- sqlfmt-corpus-separator --

SELECT array_append(NULL::letter[], NULL::letter)

-- sqlfmt-corpus-separator --

SELECT array_append(NULL::letter[], v) FROM kv_enum

-- sqlfmt-corpus-separator --

SELECT array_append(NULL::record[], NULL::record)

-- sqlfmt-corpus-separator --

SELECT array_length('{}'::text[], 1);

-- sqlfmt-corpus-separator --

SELECT array_position('1,wed', 'wed'::text)

-- sqlfmt-corpus-separator --

SELECT array_position('1,wed', 'wed'::text, 1)

-- sqlfmt-corpus-separator --

SELECT array_position('{sun,mon,tue,wed,thu,fri,sat,mon}', 'mon'::TEXT, 2)

-- sqlfmt-corpus-separator --

SELECT array_position(2, 'wed'::text)

-- sqlfmt-corpus-separator --

SELECT array_position(2, 'wed'::text, 2)

-- sqlfmt-corpus-separator --

SELECT array_position(NULL::STRING[], 'abc')

-- sqlfmt-corpus-separator --

SELECT array_position(NULL::STRING[], 'abc', 1)

-- sqlfmt-corpus-separator --

SELECT array_position(NULL::letter[], 'a'::letter)

-- sqlfmt-corpus-separator --

SELECT array_positions(NULL::STRING[], 'A')

-- sqlfmt-corpus-separator --

SELECT array_positions(NULL::letter[], 'b'::letter)

-- sqlfmt-corpus-separator --

SELECT array_prepend('a'::letter, NULL::letter[])

-- sqlfmt-corpus-separator --

SELECT array_prepend(NULL::letter, NULL::letter[])

-- sqlfmt-corpus-separator --

SELECT array_prepend(NULL::record, NULL::record[])

-- sqlfmt-corpus-separator --

SELECT array_remove(NULL::letter[], NULL::letter)

-- sqlfmt-corpus-separator --

SELECT array_remove(NULL::record[], NULL::record)

-- sqlfmt-corpus-separator --

SELECT array_to_json('{"a", "b", "c"}'::STRING[])

-- sqlfmt-corpus-separator --

SELECT array_to_json('{1.0, 2.0, 3.0}'::DECIMAL[])

-- sqlfmt-corpus-separator --

SELECT attname, attishidden
FROM pg_attribute
WHERE attrelid = 't_indkey_not_visible'::regclass::oid
ORDER BY attname

-- sqlfmt-corpus-separator --

SELECT attname, attnum FROM pg_attribute WHERE attrelid = 'hcp_test'::REGCLASS

-- sqlfmt-corpus-separator --

SELECT attname, atttypmod FROM pg_attribute WHERE attrelid = 't71926'::regclass::oid AND atttypid = 'decimal'::regtype::oid

-- sqlfmt-corpus-separator --

SELECT avg(DISTINCT k), avg(DISTINCT v), sum(DISTINCT k), sum(DISTINCT v) FROM kv

-- sqlfmt-corpus-separator --

SELECT avg(avg(k) OVER ()) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(avg(k) OVER ()) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(avg(k)) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(d) OVER (PARTITION BY v) FROM kv WHERE FALSE ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(d) OVER (PARTITION BY v, v, v, v, v, v, v, v, v, v) FROM kv WHERE FALSE ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(d) OVER (PARTITION BY v, v, v, v, v, v, v, v, v, v) FROM kv WHERE k = 3 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(d) OVER (PARTITION BY w ORDER BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(f) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) * 2.0 + max(v)::DECIMAL FROM kv

-- sqlfmt-corpus-separator --

SELECT avg(k) * 2.0 + max(v)::DECIMAL FROM kv WHERE w*2 = k

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (), avg(v) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY 1-w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY a) FROM kv

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY b) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY kv.*) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY w DESC) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY w, b) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY a) FROM kv

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY b) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY kv.*) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY w, b) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k), max(v), min(w), 2 + row_number() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k::decimal), avg(v::decimal), sum(k::decimal), sum(v::decimal) FROM kv

-- sqlfmt-corpus-separator --

SELECT b + interval '1m', interval '1m' + b, c + interval '1m', interval '1m' + c FROM tz WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b > now() - interval '1 day'  FROM mixed_type_a

-- sqlfmt-corpus-separator --

SELECT b @@ a::tsvector FROM ab

-- sqlfmt-corpus-separator --

SELECT b, b::STRING FROM t

-- sqlfmt-corpus-separator --

SELECT b, b::date, c, c::date FROM u WHERE a = 123

-- sqlfmt-corpus-separator --

SELECT bar FROM foo WHERE bar->'a' = '"b"'::JSON

-- sqlfmt-corpus-separator --

SELECT bit_and('1'::varbit), bit_and('1000'::bit(4)), bit_and('1010'::varbit)

-- sqlfmt-corpus-separator --

SELECT bit_and('1000'::varbit) FROM vals

-- sqlfmt-corpus-separator --

SELECT bit_and(NULL::varbit)

-- sqlfmt-corpus-separator --

SELECT bit_length('Hello'), bit_length('世界'), bit_length(b'世界')

-- sqlfmt-corpus-separator --

SELECT bit_or('1'::varbit), bit_or('1000'::bit(4)), bit_or('1010'::varbit)

-- sqlfmt-corpus-separator --

SELECT bit_or('1000'::varbit) FROM vals

-- sqlfmt-corpus-separator --

SELECT bit_or(NULL::varbit)

-- sqlfmt-corpus-separator --

SELECT bitmask_and('101'::STRING, B'001'::VARBIT);

-- sqlfmt-corpus-separator --

SELECT bitmask_and('1010010', '0101'::bit(4));

-- sqlfmt-corpus-separator --

SELECT bitmask_and('1010010'::bit(7), '0101');

-- sqlfmt-corpus-separator --

SELECT bitmask_and('1010010'::bit(7), '0101'::bit(4));

-- sqlfmt-corpus-separator --

SELECT bitmask_and('1010010'::varbit, '0101'::varbit);

-- sqlfmt-corpus-separator --

SELECT bitmask_and(B'001'::VARBIT, '101'::STRING);

-- sqlfmt-corpus-separator --

SELECT bitmask_or('101'::STRING, B'001'::VARBIT);

-- sqlfmt-corpus-separator --

SELECT bitmask_or('1010010', '0101'::bit(4));

-- sqlfmt-corpus-separator --

SELECT bitmask_or('1010010'::bit(7), '0101');

-- sqlfmt-corpus-separator --

SELECT bitmask_or('1010010'::bit(7), '0101'::bit(4));

-- sqlfmt-corpus-separator --

SELECT bitmask_or('1010010'::varbit, '0101'::varbit);

-- sqlfmt-corpus-separator --

SELECT bitmask_or(B'001'::VARBIT, '101'::STRING);

-- sqlfmt-corpus-separator --

SELECT bitmask_xor('101'::STRING, B'001'::VARBIT);

-- sqlfmt-corpus-separator --

SELECT bitmask_xor('1010010', '0101'::bit(4));

-- sqlfmt-corpus-separator --

SELECT bitmask_xor('1010010'::bit(7), '0101');

-- sqlfmt-corpus-separator --

SELECT bitmask_xor('1010010'::bit(7), '0101'::bit(4));

-- sqlfmt-corpus-separator --

SELECT bitmask_xor('1010010'::varbit, '0101'::varbit);

-- sqlfmt-corpus-separator --

SELECT bitmask_xor(B'001'::VARBIT, '101'::STRING);

-- sqlfmt-corpus-separator --

SELECT broadcast('10.1.0.0/16'::INET)

-- sqlfmt-corpus-separator --

SELECT broadcast('192.168.0.1'::INET)

-- sqlfmt-corpus-separator --

SELECT broadcast('192.168.0.1/16'::INET)

-- sqlfmt-corpus-separator --

SELECT broadcast('192.168.0.1/32'::INET)

-- sqlfmt-corpus-separator --

SELECT broadcast('2001:4f8:3:ba::/64'::INET)

-- sqlfmt-corpus-separator --

SELECT broadcast('::ffff:1.2.3.1/20'::INET)

-- sqlfmt-corpus-separator --

SELECT broadcast('::ffff:192.168.0.1'::INET)

-- sqlfmt-corpus-separator --

SELECT c FROM t68040 WHERE c LIKE '%\\%'

-- sqlfmt-corpus-separator --

SELECT cast('test'::TEXT AS CITEXT);

-- sqlfmt-corpus-separator --

SELECT clock_timestamp() - statement_timestamp() < interval '10s'

-- sqlfmt-corpus-separator --

SELECT col_description('pg_class'::regclass::oid, 2),
       shobj_description('pg_class'::regclass::oid, 'pg_class')

-- sqlfmt-corpus-separator --

SELECT col_description(attrelid, attnum)
  FROM pg_attribute
 WHERE attrelid = 't45707'::regclass AND attname = 'x'

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

SELECT company_id, string_agg(NULL, NULL::BYTES)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL, NULL::STRING)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::BYTES, NULL)
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::BYTES, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::BYTES, employee::BYTES)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::STRING, ',')
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::STRING, NULL)
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::STRING, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::STRING, employee)
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

SELECT company_id, string_agg(employee, 'foo', employee, 'bar')
OVER (PARTITION BY company_id)
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

SELECT company_id, string_agg(employee::BYTES, NULL)
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTES, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTES, b'')
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTES, b'')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(lower(employee), employee)
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT concat_ws(NULL::STRING, 'a', 'b')

-- sqlfmt-corpus-separator --

SELECT conname, convalidated, conenforced
FROM pg_catalog.pg_constraint
WHERE conrelid = 'constraint_db.t3'::regclass AND conname = 'check_not_valid'

-- sqlfmt-corpus-separator --

SELECT corr(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT corr(DISTINCT y, x), count(DISTINCT y) FROM t55776

-- sqlfmt-corpus-separator --

SELECT corr(DISTINCT y, x), count(y) FROM t55837

-- sqlfmt-corpus-separator --

SELECT corr(y, x)::decimal, covar_pop(y, x)::decimal, covar_samp(y, x)::decimal FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT corr(y::string, x::string) FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT count(*)
  FROM information_schema.tables
 WHERE table_schema = 'public'
   AND table_name LIKE '%typ%';

-- sqlfmt-corpus-separator --

SELECT count(*)
FROM system.eventlog
WHERE "eventType" = 'create_table'
  AND info LIKE '%CREATE TABLE badtable%'

-- sqlfmt-corpus-separator --

SELECT count(*) > 0 FROM crdb_internal.jobs WHERE job_type like '%SCHEMA CHANGE%';

-- sqlfmt-corpus-separator --

SELECT count(*) > 0 FROM crdb_internal.node_memory_monitors WHERE name LIKE '%flow%'

-- sqlfmt-corpus-separator --

SELECT count(*) >= 26 FROM crdb_internal.feature_usage WHERE feature_name LIKE 'sql.plan.window_function%' AND usage_count > 0

-- sqlfmt-corpus-separator --

SELECT count(*) FROM NumToStr WHERE str LIKE '%five%'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM system.lease WHERE desc_id = 'system.role_members'::REGCLASS::OID GROUP BY desc_id, version;

-- sqlfmt-corpus-separator --

SELECT count(*) FROM system.namespace WHERE name LIKE 'seq50997'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM system.namespace WHERE name LIKE 'seq_50712'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM system.namespace WHERE name LIKE 'v_51782'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM system.namespace WHERE name LIKE 'w_51782'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM t125620 WHERE ts < '2020-04-01'::TIMESTAMP

-- sqlfmt-corpus-separator --

SELECT count(1) FROM pg_namespace WHERE nspname LIKE 'pg_temp_%'

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT (v)) FROM kv

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT a), count(DISTINCT b), count(DISTINCT c) FROM serial

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT a), count(DISTINCT b), count(DISTINCT c) FROM serials

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT a), count(DISTINCT b), count(DISTINCT c) FROM smallbig

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT a.*) FROM kv a, kv b

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT g) FROM t111556_res

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT group_name) OVER (), count(DISTINCT product_name) OVER () FROM products

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT k), count(DISTINCT v), count(DISTINCT (v)) FROM kv

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT ts) FROM txn_timestamps;

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT w) FROM kv GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT x) FROM svals

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT(1)) FROM pg_attrdef

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT(1)) FROM pg_attribute

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT(1)) FROM pg_class

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT(1)) FROM pg_namespace

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT(1)) FROM pg_tables

-- sqlfmt-corpus-separator --

SELECT count(distinct a) FROM impure

-- sqlfmt-corpus-separator --

SELECT count(distinct(node_id)), count(*)  FROM crdb_internal.node_runtime_info

-- sqlfmt-corpus-separator --

SELECT count(w) OVER () FROM kv GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT covar_pop(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT covar_pop(y::string, x::string) FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT covar_samp(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT covar_samp(y::string, x::string) FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT crdb_internal.create_regtype(10, 'foo')::oid,
       crdb_internal.create_regclass(10, 'foo')::oid,
       crdb_internal.create_regproc(10, 'foo')::oid,
       crdb_internal.create_regprocedure(10, 'foo')::oid,
       crdb_internal.create_regnamespace(10, 'foo')::oid,
       crdb_internal.create_regrole(10, 'foo')::oid

-- sqlfmt-corpus-separator --

SELECT crdb_internal.create_tenant('{"id":10, "if_not_exists": true}'::JSONB)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.create_tenant('{"id":10}'::JSONB)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.create_tenant('{"id":18446744073709551615}'::jsonb)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.create_tenant('{"name":"tenant-number-ten", "if_not_exists": true}'::JSONB)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.create_tenant('{"name":"tenant-number-ten"}'::JSONB)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.datums_to_bytes('[1.0, 2.0]'::VECTOR(2));

-- sqlfmt-corpus-separator --

SELECT crdb_internal.datums_to_bytes('search'::TSQUERY);

-- sqlfmt-corpus-separator --

SELECT crdb_internal.datums_to_bytes('word1 word2'::TSVECTOR);

-- sqlfmt-corpus-separator --

SELECT crdb_internal.decode_key('\x00'::BYTES)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"names":"\"z#y\".b.c","counts":[2,2,2],"seed":123,"name_gen":{"noise":false}}'::jsonb)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"names":"a.b.c","counts":[0,0,100000000]}'::jsonb)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"names":"a.b.c","counts":[0,100000000,0]}'::jsonb)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"names":"a.b.c","counts":[10000000,10000000,10000000]}'::jsonb)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"names":"a.b.c","counts":[100000000,0,0]}'::jsonb)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"names":"dba.bar.baz", "counts":[2,0,10], "name_gen":{"noise":false}}'::JSONB)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"names":"dbb.bar.baz", "counts":[1,1,0], "name_gen":{"noise":false}}'::JSONB)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"names":"dbfoo.baz", "counts":[1,0,2], "name_gen":{"noise":false}}'::JSONB)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"names":"foo", "counts":[2], "name_gen":{"noise":false}}'::JSONB)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"names":"myschema.foo", "counts":[2], "name_gen":{"noise":false}}'::JSONB)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"names":"pg_temp.foo", "counts":[3], "name_gen":{"noise":false}}'::JSONB)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"names":"scgen.foo", "counts":[2,0], "name_gen":{"noise":false}}'::JSONB)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"names":"zz.b.c","counts":[2,2,2],"seed":123}'::jsonb)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"seed":123,"counts":[10],"table_templates":["base.*"]}'::JSONB)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"seed":123,"names":"dbt._","counts":[3,0,3],"table_templates":["system.*"]}'::JSONB)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"seed":123,"randomize_columns":true,"counts":[3]}'::jsonb)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"seed":1234,"counts":[10],"table_templates":["system.*"]}'::JSONB)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"seed":1234,"counts":[1],"table_templates":["system.statement_statistics"]}'::JSONB)->'generated_counts'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"table_templates":["rootonly.*"]}'::jsonb)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.generate_test_objects('{"table_templates":["rootonly.foo"]}'::jsonb)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.get_zone_config(-1)::string

-- sqlfmt-corpus-separator --

SELECT crdb_internal.get_zone_config(crdb_internal.get_namespace_id(0, 'root_test'))::string

-- sqlfmt-corpus-separator --

SELECT crdb_internal.get_zone_config(crdb_internal.get_namespace_id(crdb_internal.get_namespace_id(0, 'root_test'), 't'))::string

-- sqlfmt-corpus-separator --

SELECT crdb_internal.num_inverted_index_entries(NULL::STRING, 0)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.num_inverted_index_entries(NULL::TSVECTOR, NULL::INT8)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.pb_to_json('desc', descriptor) #> '{table,mutations}'
FROM system.descriptor
WHERE id = 't_120017'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT crdb_internal.pb_to_json('desc', descriptor)->'table'->'columns' FROM system.descriptor WHERE id = 'sq_119108'::REGCLASS::OID;

-- sqlfmt-corpus-separator --

SELECT crdb_internal.pb_to_json('desc', descriptor)->'table'->'columns'->0->>'defaultExpr'
FROM system.descriptor
WHERE id = 't_serial_identity_no_sequence'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT crdb_internal.pb_to_json('desc', descriptor)->'table'->'columns'->0->>'generatedAsIdentityType'
FROM system.descriptor
WHERE id = 't_serial_identity_no_sequence'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT crdb_internal.pb_to_json('desc', descriptor)->'table'->'columns'->0->>'generatedAsIdentityType'
FROM system.descriptor
WHERE id = 't_serial_identity_with_sequence'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT crdb_internal.pb_to_json('desc', descriptor)->'table'->'columns'->1->>'defaultExpr'
FROM system.descriptor
WHERE id = 't'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT crdb_internal.pb_to_json('desc', descriptor)->'table'->'columns'->1->>'generatedAsIdentityType'
FROM system.descriptor
WHERE id = 't'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT crdb_internal.probe_ranges(INTERVAL '1000ms', 'write')

-- sqlfmt-corpus-separator --

SELECT crdb_internal.repair_ttl_table_scheduled_job('crdb_internal_functions_tbl'::regclass::oid)

-- sqlfmt-corpus-separator --

SELECT create_statement FROM crdb_internal.create_statements WHERE descriptor_name like 't1_serial_columns%' ORDER BY descriptor_name;

-- sqlfmt-corpus-separator --

SELECT current_schemas(NULL::bool)

-- sqlfmt-corpus-separator --

SELECT currval(12345::regclass) # Bogus ID

-- sqlfmt-corpus-separator --

SELECT d FROM s ORDER BY d, d::TEXT

-- sqlfmt-corpus-separator --

SELECT d::decimal(10,1) FROM t45837

-- sqlfmt-corpus-separator --

SELECT d::timestamp FROM u WHERE a = 123

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, table_name, lock_key_pretty, lock_strength, durability, isolation_level, granted, contended FROM crdb_internal.cluster_locks WHERE contended=false AND lock_key_pretty LIKE '/Table/106%'

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, table_name, lock_key_pretty, lock_strength, durability, isolation_level, granted, contended FROM crdb_internal.cluster_locks WHERE contended=true AND lock_key_pretty LIKE '/Table/106%'

-- sqlfmt-corpus-separator --

SELECT database_name, super_region_name, regions::STRING, survival_goal
  FROM crdb_internal.super_regions
 WHERE database_name = 'srsg'

-- sqlfmt-corpus-separator --

SELECT date_part('minute', interval '10:55:01.456')

-- sqlfmt-corpus-separator --

SELECT date_trunc('centuries', '2016-02-10 19:46:33.306157519-04'::timestamptz)::string

-- sqlfmt-corpus-separator --

SELECT date_trunc('day', '0-02-16 20:38:40+00'::timestamptz, 'Australia/Sydney');

-- sqlfmt-corpus-separator --

SELECT date_trunc('day', '2001-02-16 20:38:40+00'::timestamptz, 'Australia/Sydney')

-- sqlfmt-corpus-separator --

SELECT date_trunc('day', '4-02-16 20:38:40+00'::timestamptz, 'No');

-- sqlfmt-corpus-separator --

SELECT date_trunc('day', time '12:01:02.345')

-- sqlfmt-corpus-separator --

SELECT date_trunc('decades', '2016-02-10 19:46:33.306157519-04'::timestamptz)::string

-- sqlfmt-corpus-separator --

SELECT date_trunc('hour', '2016-02-10 19:46:33.306157519-04'::timestamptz)::string

-- sqlfmt-corpus-separator --

SELECT date_trunc('hour', time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT date_trunc('hours', '2016-02-10 19:46:33.306157519-04'::timestamptz)::string

-- sqlfmt-corpus-separator --

SELECT date_trunc('invalid', interval '1 month')

-- sqlfmt-corpus-separator --

SELECT date_trunc('microsecond', time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT date_trunc('millennia', '2000-02-10 19:46:33.306157519-04'::timestamptz)::string

-- sqlfmt-corpus-separator --

SELECT date_trunc('millisecond', time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT date_trunc('minute', time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT date_trunc('second', time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT date_trunc('week', interval '1 month')

-- sqlfmt-corpus-separator --

SELECT date_trunc('weeks', interval '1 month')

-- sqlfmt-corpus-separator --

SELECT decode('123\000456', 'escape')::STRING

-- sqlfmt-corpus-separator --

SELECT decode('padded1=', 'base64')::STRING

-- sqlfmt-corpus-separator --

SELECT decode('padded==', 'base64')::STRING

-- sqlfmt-corpus-separator --

SELECT descriptor FROM redacted_descriptors WHERE id = 'foo'::REGCLASS;

-- sqlfmt-corpus-separator --

SELECT descriptor from redacted_descriptors where id = 'collate_partition'::REGCLASS;

-- sqlfmt-corpus-separator --

SELECT descriptor from redacted_descriptors where id = 'subpartition'::REGCLASS;

-- sqlfmt-corpus-separator --

SELECT descriptor_id, descriptor_name, index_id, index_name, index_type, is_unique, is_inverted, is_sharded, shard_bucket_count
    FROM crdb_internal.table_indexes
   WHERE descriptor_name LIKE 'test_%'
ORDER BY descriptor_id, index_id

-- sqlfmt-corpus-separator --

SELECT descriptor_name, create_statement FROM crdb_internal.create_statements WHERE descriptor_name LIKE 'star%' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT div(1.0::decimal, 0.0::decimal)

-- sqlfmt-corpus-separator --

SELECT e'\u0065\u0301'::CITEXT = e'\u0045\u0301'::CITEXT;

-- sqlfmt-corpus-separator --

SELECT e'\u00C9'::CITEXT = e'\u0065\u0301'::CITEXT;

-- sqlfmt-corpus-separator --

SELECT e'\u00E9'::CITEXT = e'\u0065\u0301'::CITEXT;

-- sqlfmt-corpus-separator --

SELECT e'\u00E9'::CITEXT = e'\u00C9'::CITEXT;

-- sqlfmt-corpus-separator --

SELECT e'\u00E9'::CITEXT = e'\u00E8'::CITEXT;

-- sqlfmt-corpus-separator --

SELECT e'\u047D'::CITEXT = e'\u047C'::CITEXT;

-- sqlfmt-corpus-separator --

SELECT e'\x5c\x78'::STRING

-- sqlfmt-corpus-separator --

SELECT e'a\\01'::STRING::BYTEA

-- sqlfmt-corpus-separator --

SELECT e'a\\134b\nc\'e'::STRING::BYTES::STRING

-- sqlfmt-corpus-separator --

SELECT e'a\\\\b'::STRING::BYTEA

-- sqlfmt-corpus-separator --

SELECT e'a\\bcde'::STRING::BYTEA

-- sqlfmt-corpus-separator --

SELECT e'{he\\\\llo}'::STRING[]

-- sqlfmt-corpus-separator --

SELECT encrypt('16byte_long_data', 'key', 'aes/pad:none')::STRING

-- sqlfmt-corpus-separator --

SELECT encrypt('abc', '16_byte_long_key', 'aes')::STRING

-- sqlfmt-corpus-separator --

SELECT encrypt('abc', '24_byte_looooooooong_key', 'aes')::STRING

-- sqlfmt-corpus-separator --

SELECT encrypt('abc', '32_byte_looooooooooooooooong_key', 'aes')::STRING

-- sqlfmt-corpus-separator --

SELECT encrypt('abcdefghijklmnopqrstuvwxyz', 'key', 'aes')::STRING

-- sqlfmt-corpus-separator --

SELECT encrypt_iv('abc', 'key', '123', 'aes')::STRING

-- sqlfmt-corpus-separator --

SELECT enum_first('c'::build)

-- sqlfmt-corpus-separator --

SELECT enum_first('mysql'::dbs), enum_last('spanner'::dbs)

-- sqlfmt-corpus-separator --

SELECT enum_first(null::dbs)

-- sqlfmt-corpus-separator --

SELECT enum_last('c'::build)

-- sqlfmt-corpus-separator --

SELECT enum_range('c'::build)

-- sqlfmt-corpus-separator --

SELECT enum_range('cockroach'::dbs)

-- sqlfmt-corpus-separator --

SELECT enum_range('cockroach'::dbs, 'cockroach'::dbs)

-- sqlfmt-corpus-separator --

SELECT enum_range('cockroach'::dbs, 'hello'::greeting)

-- sqlfmt-corpus-separator --

SELECT enum_range('cockroach'::dbs, 'spanner'::dbs)

-- sqlfmt-corpus-separator --

SELECT enum_range('jim'::names);

-- sqlfmt-corpus-separator --

SELECT enum_range('jimmy'::names);

-- sqlfmt-corpus-separator --

SELECT enum_range('postgres'::dbs, 'spanner'::dbs), enum_range('spanner'::dbs, 'cockroach'::dbs)

-- sqlfmt-corpus-separator --

SELECT enum_range(NULL, 'mysql'::dbs), enum_range('spanner'::dbs, NULL)

-- sqlfmt-corpus-separator --

SELECT enum_range(NULL::dbs, NULL::dbs)

-- sqlfmt-corpus-separator --

SELECT exp(1e2000::decimal)

-- sqlfmt-corpus-separator --

SELECT f('foo'::TEXT);

-- sqlfmt-corpus-separator --

SELECT f('hi'::greetings);

-- sqlfmt-corpus-separator --

SELECT f('hi'::greetings, 'hello');

-- sqlfmt-corpus-separator --

SELECT f('hi'::greetings, 'hello'::greetings);

-- sqlfmt-corpus-separator --

SELECT f(), f(True), f('foo'::TEXT);

-- sqlfmt-corpus-separator --

SELECT f(1), f(1, 2), f('foo'::TEXT, 'bar'::TEXT), f(True, False);

-- sqlfmt-corpus-separator --

SELECT f, f::string FROM vals

-- sqlfmt-corpus-separator --

SELECT f_103869('sq_103869'::REGCLASS);

-- sqlfmt-corpus-separator --

SELECT f_94146(1::INT2)

-- sqlfmt-corpus-separator --

SELECT f_94146(1::INT4)

-- sqlfmt-corpus-separator --

SELECT f_94146(1::INT8)

-- sqlfmt-corpus-separator --

SELECT family('10.1.0.0/16'::INET)

-- sqlfmt-corpus-separator --

SELECT family('192.168.0.1'::INET)

-- sqlfmt-corpus-separator --

SELECT family('192.168.0.1/16'::INET)

-- sqlfmt-corpus-separator --

SELECT family('2001:4f8:3:ba::/64'::INET)

-- sqlfmt-corpus-separator --

SELECT family('::ffff:1.2.3.1/20'::INET)

-- sqlfmt-corpus-separator --

SELECT family('::ffff:192.168.0.1'::INET)

-- sqlfmt-corpus-separator --

SELECT feature_name
  FROM crdb_internal.feature_usage
 WHERE feature_name LIKE '%errorcodes.42601%'

-- sqlfmt-corpus-separator --

SELECT field, value FROM crdb_internal.node_build_info WHERE field ILIKE 'name'

-- sqlfmt-corpus-separator --

SELECT final_variance(1.2, 1.2, 123) OVER (PARTITION BY k) FROM kv

-- sqlfmt-corpus-separator --

SELECT fnv32(NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT from_ip(b'')

-- sqlfmt-corpus-separator --

SELECT from_uuid(b'f00d')

-- sqlfmt-corpus-separator --

SELECT get_bit(B'', 0);

-- sqlfmt-corpus-separator --

SELECT get_bit(B'10110', 10)

-- sqlfmt-corpus-separator --

SELECT get_bit(b'', 0)

-- sqlfmt-corpus-separator --

SELECT get_byte('Th\000omas'::BYTEA, 4)

-- sqlfmt-corpus-separator --

SELECT get_byte('abc'::BYTEA, -10)

-- sqlfmt-corpus-separator --

SELECT get_byte('abc'::BYTEA, 10)

-- sqlfmt-corpus-separator --

SELECT group_name, price, product_name, array_agg(product_name) OVER (PARTITION BY group_name ORDER BY price, group_id) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT has_any_column_privilege('t'::Name, 'SELECT'),
       has_any_column_privilege('t'::Name, 'INSERT'),
       has_any_column_privilege('t'::Name, 'UPDATE'),
       has_any_column_privilege('t'::Name, 'REFERENCES'),
       has_any_column_privilege('t'::Name, 'SELECT, INSERT, UPDATE')

-- sqlfmt-corpus-separator --

SELECT has_any_column_privilege(12345::OID::REGCLASS, 'SELECT'),
       has_any_column_privilege(12345::OID::REGCLASS, 'INSERT'),
       has_any_column_privilege(12345::OID::REGCLASS, 'UPDATE'),
       has_any_column_privilege(12345::OID::REGCLASS, 'REFERENCES')

-- sqlfmt-corpus-separator --

SELECT has_column_privilege('hcp_test'::REGCLASS, 1, 'SELECT')

-- sqlfmt-corpus-separator --

SELECT has_column_privilege('hcp_test'::REGCLASS, 2, 'SELECT')

-- sqlfmt-corpus-separator --

SELECT has_column_privilege('hcp_test'::REGCLASS, 3, 'SELECT')

-- sqlfmt-corpus-separator --

SELECT has_column_privilege('hcp_test'::REGCLASS, 4, 'SELECT')

-- sqlfmt-corpus-separator --

SELECT has_column_privilege('pg_type'::regclass, 'does not exist', 'SELECT')

-- sqlfmt-corpus-separator --

SELECT has_column_privilege('pg_type'::regclass, 100, 'SELECT')

-- sqlfmt-corpus-separator --

SELECT has_column_privilege('t'::Name, 'a'::Name, 'SELECT WITH GRANT OPTION'),
       has_column_privilege('t'::Name, 'a'::Name, 'INSERT WITH GRANT OPTION'),
       has_column_privilege('t'::Name, 'a'::Name, 'UPDATE WITH GRANT OPTION'),
       has_column_privilege('t'::Name, 'a'::Name, 'REFERENCES WITH GRANT OPTION'),
       has_column_privilege('t'::Name, 'a'::Name, 'SELECT WITH GRANT OPTION, INSERT WITH GRANT OPTION, UPDATE WITH GRANT OPTION')

-- sqlfmt-corpus-separator --

SELECT has_database_privilege('test'::Name, 'CREATE'),
       has_database_privilege('test'::Name, 'CONNECT'),
       has_database_privilege('test'::Name, 'TEMPORARY'),
       has_database_privilege('test'::Name, 'TEMP'),
       has_database_privilege('test'::Name, 'CREATE, CONNECT')

-- sqlfmt-corpus-separator --

SELECT has_foreign_data_wrapper_privilege('does_not_exist'::Name, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_function_privilege('bar', 'current_date'::REGPROC, 'EXECUTE')

-- sqlfmt-corpus-separator --

SELECT has_function_privilege('bar', 'current_date'::REGPROC::OID, 'EXECUTE')

-- sqlfmt-corpus-separator --

SELECT has_function_privilege('version()'::Name, 'EXECUTE')

-- sqlfmt-corpus-separator --

SELECT has_language_privilege('does_not_exist'::Name, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_schema_privilege('public'::Name, 'CREATE'),
       has_schema_privilege('public'::Name, 'USAGE'),
       has_schema_privilege('public'::Name, 'CREATE, USAGE')

-- sqlfmt-corpus-separator --

SELECT has_sequence_privilege('seq'::Name, 'USAGE'),
       has_sequence_privilege('seq'::Name, 'SELECT'),
       has_sequence_privilege('seq'::Name, 'UPDATE')

-- sqlfmt-corpus-separator --

SELECT has_server_privilege('does_not_exist'::Name, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_system_privilege(99999::OID, 'BACKUP')

-- sqlfmt-corpus-separator --

SELECT has_table_privilege('root'::NAME, 0, 'select')

-- sqlfmt-corpus-separator --

SELECT has_table_privilege('t'::Name, 'SELECT'),
       has_table_privilege('t'::Name, 'INSERT'),
       has_table_privilege('t'::Name, 'UPDATE'),
       has_table_privilege('t'::Name, 'DELETE'),
       has_table_privilege('t'::Name, 'TRUNCATE'),
       has_table_privilege('t'::Name, 'REFERENCES'),
       has_table_privilege('t'::Name, 'TRIGGER'),
       has_table_privilege('t'::Name, 'SELECT, INSERT, UPDATE'),
       has_table_privilege('t'::Name, 'SELECT, TRUNCATE'),
       has_table_privilege('t'::Name, 'RULE')

-- sqlfmt-corpus-separator --

SELECT has_tablespace_privilege('pg_default'::Name, 'CREATE')

-- sqlfmt-corpus-separator --

SELECT has_type_privilege('bar', 'text'::REGTYPE, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_type_privilege('bar', 'text'::REGTYPE::OID, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT has_type_privilege('int'::Name, 'USAGE')

-- sqlfmt-corpus-separator --

SELECT host('10.1.0.0/16'::INET)

-- sqlfmt-corpus-separator --

SELECT host('192.168.0.1'::INET)

-- sqlfmt-corpus-separator --

SELECT host('192.168.0.1/16'::INET)

-- sqlfmt-corpus-separator --

SELECT host('192.168.0.1/32'::INET)

-- sqlfmt-corpus-separator --

SELECT host('::ffff:192.168.0.1'::INET)

-- sqlfmt-corpus-separator --

SELECT host('::ffff:192.168.0.1/24'::INET)

-- sqlfmt-corpus-separator --

SELECT hostmask('192.168.1.2'::INET)

-- sqlfmt-corpus-separator --

SELECT hostmask('192.168.1.2/10'::INET)

-- sqlfmt-corpus-separator --

SELECT hostmask('192.168.1.2/16'::INET)

-- sqlfmt-corpus-separator --

SELECT hostmask('2001:4f8:3:ba::/64'::INET)

-- sqlfmt-corpus-separator --

SELECT i, avg(i) OVER (ORDER BY i) FROM kv ORDER BY i

-- sqlfmt-corpus-separator --

SELECT i, i::INTERVAL FROM interval_parsing ORDER BY pk

-- sqlfmt-corpus-separator --

SELECT i::string FROM intervals ORDER BY pk

-- sqlfmt-corpus-separator --

SELECT id FROM system.namespace WHERE name LIKE 'd_type%'

-- sqlfmt-corpus-separator --

SELECT id FROM system.namespace WHERE name LIKE 'dropschema%'

-- sqlfmt-corpus-separator --

SELECT id FROM t_sub ORDER BY tracked_add(id) NULLS LAST

-- sqlfmt-corpus-separator --

SELECT id, a, length(a), b, length(b::string) FROM t50015 ORDER BY id ASC

-- sqlfmt-corpus-separator --

SELECT id, sum(val) FROM t_sub
GROUP BY id
ORDER BY (SELECT sum(amount) FROM t_orders WHERE customer_id = id) NULLS LAST

-- sqlfmt-corpus-separator --

SELECT id, t::timestamp(0), t::timestamp(3), ttz::timestamptz(0), ttz::timestamptz(3) FROM timestamp_test ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, val FROM t_sub ORDER BY (SELECT v FROM t_lookup WHERE k = id) DESC NULLS FIRST

-- sqlfmt-corpus-separator --

SELECT id, val FROM t_sub ORDER BY (SELECT v FROM t_lookup WHERE k = id) DESC NULLS LAST

-- sqlfmt-corpus-separator --

SELECT id, val FROM t_sub ORDER BY (SELECT v FROM t_lookup WHERE k = id) NULLS FIRST

-- sqlfmt-corpus-separator --

SELECT id, val FROM t_sub ORDER BY (SELECT v FROM t_lookup WHERE k = id) NULLS LAST

-- sqlfmt-corpus-separator --

SELECT id, val FROM t_sub ORDER BY id NULLS LAST, (SELECT v FROM t_lookup WHERE k = id) NULLS LAST

-- sqlfmt-corpus-separator --

SELECT id, val, (SELECT v FROM t_lookup WHERE k = id) AS lookup_val
FROM t_sub
ORDER BY (SELECT v FROM t_lookup WHERE k = id) NULLS LAST

-- sqlfmt-corpus-separator --

SELECT index('A.B.B.C.B.C'::LTREE, 'A.B.C');

-- sqlfmt-corpus-separator --

SELECT index('A.B.B.C.B.C'::LTREE, 'B.C');

-- sqlfmt-corpus-separator --

SELECT index('A.B.B.C.B.C'::LTREE, 'B.C', -2);

-- sqlfmt-corpus-separator --

SELECT index('A.B.B.C.B.C'::LTREE, 'B.C', 3);

-- sqlfmt-corpus-separator --

SELECT index('A.B.B.C.B.C'::LTREE, 'B.C'::LTREE, -99);

-- sqlfmt-corpus-separator --

SELECT index('A.B.C'::LTREE, NULL::LTREE);

-- sqlfmt-corpus-separator --

SELECT indexname, indexdef FROM pg_indexes
WHERE tablename = 'shard_columns_test' AND indexname LIKE 'idx%'
ORDER BY indexname

-- sqlfmt-corpus-separator --

SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'legacy_test' AND indexname LIKE 'idx%' ORDER BY indexname

-- sqlfmt-corpus-separator --

SELECT info::JSONB->>'StatementFingerprint',
       info::JSONB->>'DonorSql'
FROM system.eventlog
WHERE "eventType" = 'delete_rewrite_inline_hints'
ORDER BY "timestamp" DESC
LIMIT 1

-- sqlfmt-corpus-separator --

SELECT interval '-1:02.123456'

-- sqlfmt-corpus-separator --

SELECT interval '123 11'

-- sqlfmt-corpus-separator --

SELECT interval '123 2:03 -2:04'

-- sqlfmt-corpus-separator --

SELECT interval '1:02.123456'

-- sqlfmt-corpus-separator --

SELECT interval '2.1 00:'

-- sqlfmt-corpus-separator --

SELECT job_type, description, user_name FROM crdb_internal.jobs WHERE user_name = 'node'
AND job_type LIKE 'AUTO SPAN%'

-- sqlfmt-corpus-separator --

SELECT job_type, description, user_name FROM crdb_internal.jobs WHERE user_name = 'root'
AND job_type LIKE 'SCHEMA CHANGE%' ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT json_array_elements('[1, 2, 3]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_array_elements('[1, true, null, "text", -1.234, {"2": 3, "4": "5"}, [1, 2, 3]]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_array_elements('[]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_array_elements('{"1": 2}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_array_elements_text('[1, 2, 3]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_array_elements_text('[1, true, null, "text", -1.234, {"2": 3, "4": "5"}, [1, 2, 3]]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_array_elements_text('{"1": 2}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_array_length(crdb_internal.pb_to_json('cockroach.config.zonepb.ZoneConfig', config) -> 'subzoneSpans')
FROM system.zones
WHERE id = 'person'::REGCLASS::OID

-- sqlfmt-corpus-separator --

SELECT json_build_array('\x0001'::BYTEA)

-- sqlfmt-corpus-separator --

SELECT json_build_object('$'::JSONPATH, 1)

-- sqlfmt-corpus-separator --

SELECT json_build_object(''::void, 1)

-- sqlfmt-corpus-separator --

SELECT json_build_object('a', '0100110'::varbit)

-- sqlfmt-corpus-separator --

SELECT json_build_object('a',1,'b',1.2,'c',true,'d',null,'e','{"x": 3, "y": [1,2,3]}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_build_object('a'::tsvector, 1, 'b'::tsquery, 2)

-- sqlfmt-corpus-separator --

SELECT json_build_object('e'::e, 1)

-- sqlfmt-corpus-separator --

SELECT json_build_object('foo'::LTREE, 2)

-- sqlfmt-corpus-separator --

SELECT json_build_object('{"a":1,"b":2}'::JSON, 3)

-- sqlfmt-corpus-separator --

SELECT json_build_object(json_object_keys('{"x":3, "y":4}'::JSON), 2)

-- sqlfmt-corpus-separator --

SELECT json_each('[1]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_each('null'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_each_text('[1]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_each_text('null'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_object('{NULL, a}'::TEXT[])

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

SELECT json_object('{b, 3, a, 1, b, 4, a, 2}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{b, b, a, a}'::TEXT[], '{1, 2, 3, 4}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object('{}'::TEXT[], '{}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT json_object_agg(s, s) OVER (ORDER BY s DESC) FROM t54604

-- sqlfmt-corpus-separator --

SELECT json_object_keys('[1, 2, 3]'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_object_keys('null'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_object_keys('{"1": 2, "3": 4}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_object_keys('{"\"1\"": 2}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_object_keys('{"a": 1, "1": 2, "3": {"4": 5, "6": 7}}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_object_keys('{}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_populate_record(NULL::testtab, '{"i": 3, "ia": [1,2,3], "t": "foo", "ta": ["a", "b"], "ts": "2017-01-01 00:00", "j": {"a": "b", "c": 3, "d": [1,false,true,null,{"1":"2"}]}}'::JSON)

-- sqlfmt-corpus-separator --

SELECT json_set('{"a":1}', '{a}'::STRING[], '2')

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

SELECT json_typeof('{"1": {"2": 3}}'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_array_elements('[1, 2, 3]'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_array_elements('{"1": 2}'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_array_elements_text('{"1": 2}'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array('+Inf'::FLOAT8, 'NaN'::FLOAT8)::STRING::JSONB

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array('\x0001'::BYTEA)

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(true,'val',1, 0, 1.3, 2, date '2019-02-03' - date '2019-01-01', 4, '2001-01-01 11:00+3'::timestamptz, '11:00+3'::timetz)

-- sqlfmt-corpus-separator --

SELECT jsonb_each('[1]'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_each('null'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_each_text('[1]'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_each_text('null'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('1', '{a}'::STRING[], '10', true)

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('[0, 1, 2, 3]', '{3}'::STRING[], '10', true)

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('[0, 1, 2, {"a": ["a", "b", "d"]}, 4]', '{3, a, 2}'::STRING[], '"c"')

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a": "foo"}', '{a, 0}'::STRING[], '"new_value"', false)

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a": "foo"}', '{a}'::STRING[], '"new_value"', false)

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a": "foo"}', '{b}'::STRING[], '"bar"')

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a": [0, 1, 2], "b": "hello", "c": "world"}', '{NULL, a, 0}'::STRING[], '"new_val"')

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a": [0, 1, 2], "b": "hello", "c": "world"}', '{a, NULL, 0}'::STRING[], '"new_val"')

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a": [0, 1, 2]}', '{a, -1}'::STRING[], '"new_value"', true)

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a": [0, 1, 2]}', '{a, 1}'::STRING[], '"new_value"');

-- sqlfmt-corpus-separator --

SELECT jsonb_insert('{"a": [0, 1, 2]}', '{a, 1}'::STRING[], '"new_value"', true)

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{NULL, a}'::TEXT[])

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

SELECT jsonb_object('{b, 3, a, 1, b, 4, a, 2}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{b, b, a, a}'::TEXT[], '{1, 2, 3, 4}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object('{}'::TEXT[], '{}'::TEXT[])

-- sqlfmt-corpus-separator --

SELECT jsonb_object_keys('{"1": 2, "3": 4}'::JSON)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{"LIKE_REGEX": 1}'::JSONB, '$.LIKE_REGEX'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{"LIKE_REGEx": 1}'::JSONB, '$.LIKE_REGEX'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{"LIKE_REGEx": 1}'::JSONB, '$.LIKE_REGEx'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{"STRICT": 1}'::JSONB, 'lax $.STRICT'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{"STRICT": 1}'::JSONB, 'lax $.strict'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{"STRICT": 1}'::JSONB, 'strIct $.STRICT'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{"STRICt": 1}'::JSONB, '$.STRICT'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{"STRICt": 1}'::JSONB, '$.STRICt'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{"strict": 1}'::JSONB, '$.STRICT'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{"strict": 1}'::JSONB, '$.STRICt'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{"strict": 1}'::JSONB, '$.strict'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{"strict": 1}'::JSONB, 'lax $.STRICT'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{"strict": 1}'::JSONB, 'lax $.STRICt'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{}', '@'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{}', 'last'::JSONPATH);

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query('{}'::jsonb, '8.73'::jsonpath);

-- sqlfmt-corpus-separator --

SELECT jsonb_set('[{"f1":1,"f2":null},2,null,3]', '{0,f1}'::STRING[], '[2,3,4]', false)

-- sqlfmt-corpus-separator --

SELECT jsonb_set('[{"f1":1,"f2":null},2]', '{0,f3}'::STRING[], '[2,3,4]')

-- sqlfmt-corpus-separator --

SELECT jsonb_set('{"a":1}', '{b}'::STRING[], '2')

-- sqlfmt-corpus-separator --

SELECT jsonb_set('{"a":1}', '{b}'::STRING[], '2', false)

-- sqlfmt-corpus-separator --

SELECT jsonb_set('{"a":1}', '{b}'::STRING[], '2', true)

-- sqlfmt-corpus-separator --

SELECT jsonb_set('{"a":1}', '{foo,null}'::STRING[], '2', true)

-- sqlfmt-corpus-separator --

SELECT jsonb_set('{"a":1}', '{null,foo}'::STRING[], '2', true)

-- sqlfmt-corpus-separator --

SELECT jsonb_typeof('"-123.4"'::JSON)

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

SELECT jsonb_typeof('{"1": {"2": 3}}'::JSON)

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table WHERE 'LINESTRING(1.0 1.0, 5.0 5.0)'::geometry ~ geom ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table WHERE 'LINESTRING(1.0 1.0, 5.0 5.0)'::geometry::box2d ~ geom ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table WHERE 'POINT(3.0 3.0)'::geometry && geom ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table WHERE 'POINT(3.0 3.0)'::geometry::box2d && geom ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table WHERE ST_CoveredBy('POINT(4.0 4.5)'::geometry, geom) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table WHERE ST_Covers('LINESTRING(1.0 1.0, 5.0 5.0)'::geometry, geom) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table WHERE ST_DWithin('POINT(2.5 2.5)'::geometry, geom, 1) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table WHERE ST_Intersects('POINT(2.5 2.5)'::geometry, geom) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table WHERE ST_Intersects('POINT(3.0 3.0)'::geometry, geom) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table WHERE ST_Intersects('POINT(4.5 4.5)'::geometry, geom) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table WHERE ST_Intersects('SRID=26918;POINT(400003 4000003)'::geometry, geom) ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table WHERE geom ~ 'LINESTRING(1.0 1.0, 5.0 5.0)'::geometry ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table WHERE geom ~ 'LINESTRING(1.0 1.0, 5.0 5.0)'::geometry::box2d ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k FROM geo_table2 WHERE ST_Intersects('POINT(3.0 3.0)'::geometry, geom)

-- sqlfmt-corpus-separator --

SELECT k FROM kv WHERE avg(k) OVER () > 1

-- sqlfmt-corpus-separator --

SELECT k, bool_and(b) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, bool_or(b) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, concat_agg(s) OVER (PARTITION BY k ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, concat_agg(s) OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, count(*) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, count(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, cume_dist() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, dense_rank() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, first_value(1) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, first_value(199.9 * 23.3) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, first_value(v) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, first_value(v) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, k_plus_one FROM geo_table2 WHERE ST_Intersects('POINT(3.0 3.0)'::geometry, geom)

-- sqlfmt-corpus-separator --

SELECT k, k_plus_one, geom FROM geo_table2 WHERE ST_Intersects('POINT(3.0 3.0)'::geometry, geom)

-- sqlfmt-corpus-separator --

SELECT k, lag(9) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k) OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, -5) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, -5) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 0) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 0) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 1, 'FOO') OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 1, s) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 3) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 3) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 3, -99) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 3, -99) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 3, v) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 3, v) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, w - w) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, w) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, w) OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, last_value(1) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, last_value(199.9 * 23.3) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, last_value(v) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, last_value(v) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(9) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k) OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, -5) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, -5) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 0) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 0) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 1, 'FOO') OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 1, s) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 3) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 3) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 3, -99) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 3, -99) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 3, v) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 3, v) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, w - w) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, w) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, w) OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, max(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, max(d) OVER (PARTITION BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, min(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(1, 3) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(1, 33) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(199.9 * 23.3, 7) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, 'FOO') OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, -99) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, 0) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, 1) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, 8) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, k) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, v) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, v) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, v) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(-10) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(0) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(1) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(1::INT4) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(20) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(4) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, percent_rank() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, pow(max(d) OVER (PARTITION BY v), k::DECIMAL) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, rank() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, row_number() OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, row_number() OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, stddev(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, sum(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v LIKE 'ABC%'

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v LIKE 'ABC%Z'

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v LIKE 'ABC\'

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v LIKE 'A\%'

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v LIKE 'CAB.*'

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v LIKE '\ABC%'

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v LIKE '\ABCDE_'

-- sqlfmt-corpus-separator --

SELECT k, v FROM str WHERE v LIKE '\\CBA%'

-- sqlfmt-corpus-separator --

SELECT k, v, cume_dist() OVER (PARTITION BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, dense_rank() OVER (PARTITION BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, ntile(3) OVER (PARTITION BY v ORDER BY k) FROM kv ORDER BY v, k

-- sqlfmt-corpus-separator --

SELECT k, v, ntile(3) OVER (PARTITION BY v, k) FROM kv ORDER BY v, k

-- sqlfmt-corpus-separator --

SELECT k, v, ntile(3::INT2) OVER (PARTITION BY v ORDER BY k) FROM kv ORDER BY v, k

-- sqlfmt-corpus-separator --

SELECT k, v, ntile(3::INT4) OVER (PARTITION BY v ORDER BY k) FROM kv ORDER BY v, k

-- sqlfmt-corpus-separator --

SELECT k, v, ntile(v) OVER (ORDER BY v, k) FROM kv ORDER BY v, k

-- sqlfmt-corpus-separator --

SELECT k, v, percent_rank() OVER (PARTITION BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, rank() OVER (PARTITION BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, row_number() OVER (PARTITION BY v ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, cume_dist() OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, dense_rank() OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, first_value(w) OVER (PARTITION BY v ORDER BY w DESC) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, first_value(w) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, last_value(w) OVER (PARTITION BY v ORDER BY w DESC) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, last_value(w) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, nth_value(w, 2) OVER (PARTITION BY v ORDER BY w DESC) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, nth_value(w, 2) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, ntile(6) OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY v, w, k

-- sqlfmt-corpus-separator --

SELECT k, v, w, ntile(6) OVER (PARTITION BY v, k ORDER BY w) FROM kv ORDER BY v, k, w

-- sqlfmt-corpus-separator --

SELECT k, v, w, ntile(v) OVER (PARTITION BY w ORDER BY v, k) FROM kv ORDER BY w, v, k

-- sqlfmt-corpus-separator --

SELECT k, v, w, percent_rank() OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, rank() OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, row_number() OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, v - w + 2 + row_number() OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, v - w + 2 + row_number() OVER (PARTITION BY v, k ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, variance(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, w, ntile(w) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, w, ntile(w) OVER (PARTITION BY k) FROM kv ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k, w, ntile(w::INT4) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT key, count >= 1 FROM crdb_internal.node_statement_statistics WHERE application_name = 'hello' AND key LIKE 'SELECT%' ORDER BY key

-- sqlfmt-corpus-separator --

SELECT key, count FROM crdb_internal.node_statement_statistics
WHERE application_name = 'throttle_test' AND key LIKE 'SELECT%' ORDER BY key

-- sqlfmt-corpus-separator --

SELECT key::STRING FROM crdb_internal.node_contention_events LIMIT 1

-- sqlfmt-corpus-separator --

SELECT lag(b, 0) OVER (ORDER BY b DESC) FROM t64793 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT last_error_code, last_error   FROM crdb_internal.node_statement_statistics WHERE last_error_code!='NULL' AND application_name NOT LIKE '$ %' ORDER BY last_error_code ASC;

-- sqlfmt-corpus-separator --

SELECT last_error_code, last_error FROM crdb_internal.node_statement_statistics WHERE last_error_code!='NULL' AND application_name NOT LIKE '$ %' ORDER BY last_error_code ASC;

-- sqlfmt-corpus-separator --

SELECT lca(''::LTREE, 'A.B.C'::LTREE)

-- sqlfmt-corpus-separator --

SELECT lca('A'::LTREE, 'A'::LTREE)

-- sqlfmt-corpus-separator --

SELECT lca('A'::LTREE, 'A'::LTREE, NULL::LTREE);

-- sqlfmt-corpus-separator --

SELECT lca('A.B'::LTREE, 'A.B'::LTREE)

-- sqlfmt-corpus-separator --

SELECT lca('A.B'::LTREE, 'C.D'::LTREE)

-- sqlfmt-corpus-separator --

SELECT lca('A.B.C'::LTREE, 'A.B.C.D'::LTREE, 'A.B.C.E'::LTREE);

-- sqlfmt-corpus-separator --

SELECT lca('A.B.C'::LTREE, 'A.B.X'::LTREE)

-- sqlfmt-corpus-separator --

SELECT lca('A.B.C.D.E'::LTREE, 'A.B.X.Y.Z'::LTREE)

-- sqlfmt-corpus-separator --

SELECT lcm(1e2000::decimal, 3::decimal)

-- sqlfmt-corpus-separator --

SELECT left('💩abcde'::bytes, 2)

-- sqlfmt-corpus-separator --

SELECT length('Hello, 世界'), length(b'Hello, 世界'),
       char_length('Hello, 世界'), char_length(b'Hello, 世界'),
       character_length('Hello, 世界'), character_length(b'Hello, 世界')

-- sqlfmt-corpus-separator --

SELECT length('roach7'), length(b'roach77')

-- sqlfmt-corpus-separator --

SELECT length(b::BYTES) FROM aliases ORDER BY a

-- sqlfmt-corpus-separator --

SELECT length(e'a\\\\b'::STRING::BYTEA)

-- sqlfmt-corpus-separator --

SELECT length(gen_random_ulid()::BYTES), gen_random_ulid() = gen_random_ulid()

-- sqlfmt-corpus-separator --

SELECT length(gen_random_uuid()::BYTES), gen_random_uuid() = gen_random_uuid()

-- sqlfmt-corpus-separator --

SELECT length(x), encode(x::bytes, 'escape') from s

-- sqlfmt-corpus-separator --

SELECT ln(-100.000::decimal)

-- sqlfmt-corpus-separator --

SELECT ln(0::decimal)

-- sqlfmt-corpus-separator --

SELECT ln(7.682705743584112e-48::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT log(-100.000::decimal)

-- sqlfmt-corpus-separator --

SELECT log(0::decimal)

-- sqlfmt-corpus-separator --

SELECT log(2.0::decimal, -10.0::decimal)

-- sqlfmt-corpus-separator --

SELECT log(2.0::decimal, 0.0::decimal)

-- sqlfmt-corpus-separator --

SELECT log(2.0::decimal, 4.0::decimal)

-- sqlfmt-corpus-separator --

SELECT log10(-1::decimal)

-- sqlfmt-corpus-separator --

SELECT log10(0::decimal)

-- sqlfmt-corpus-separator --

SELECT make_date(2013, 7, 15)::string

-- sqlfmt-corpus-separator --

SELECT make_timestamp(2013, 7, 15, 8, 15, 23.5)::string

-- sqlfmt-corpus-separator --

SELECT make_timestamp(2013, 7, 15, 8, 15, 23.5231231244234)::string

-- sqlfmt-corpus-separator --

SELECT makeaclitem('root'::regrole, 'admin'::regrole, 'BOGUS', false)

-- sqlfmt-corpus-separator --

SELECT makeaclitem('root'::regrole, 'admin'::regrole, 'SELECT', false)

-- sqlfmt-corpus-separator --

SELECT makeaclitem('root'::regrole, 'admin'::regrole, 'SELECT,INSERT', true)

-- sqlfmt-corpus-separator --

SELECT makeaclitem('root'::regrole, 'admin'::regrole, 'SELECT,INSERT,UPDATE', false)

-- sqlfmt-corpus-separator --

SELECT makeaclitem(0::oid, 'root'::regrole, 'ALTER SYSTEM', false)

-- sqlfmt-corpus-separator --

SELECT makeaclitem(0::oid, 'root'::regrole, 'EXECUTE', false)

-- sqlfmt-corpus-separator --

SELECT makeaclitem(0::oid, 'root'::regrole, 'SET', false)

-- sqlfmt-corpus-separator --

SELECT masklen('192.168.1.2'::INET)

-- sqlfmt-corpus-separator --

SELECT masklen('192.168.1.2/10'::INET)

-- sqlfmt-corpus-separator --

SELECT masklen('192.168.1.2/16'::INET)

-- sqlfmt-corpus-separator --

SELECT masklen('2001:4f8:3:ba::'::INET)

-- sqlfmt-corpus-separator --

SELECT masklen('2001:4f8:3:ba::/64'::INET)

-- sqlfmt-corpus-separator --

SELECT md5(NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT md5(NULL::STRING, NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT min(b) OVER () FROM t

-- sqlfmt-corpus-separator --

SELECT min(v), max(v), count(v), sum_int(1), avg(v), sum(v), stddev(v), stddev_pop(v), variance(v), var_pop(v), var_samp(v),
bool_and(v = 1), bool_and(v = 1), xor_agg(s::bytes), corr(v,k), sqrdiff(v), covar_pop(v, k), covar_samp(v, k),
regr_intercept(v, k), regr_r2(v, k), regr_slope(v, k), regr_sxx(v, k), regr_sxy(v, k), regr_syy(v, k), regr_count(v, k),
regr_avgx(v, k), regr_avgy(v, k)
FROM kv

-- sqlfmt-corpus-separator --

SELECT mod(5::decimal, 0::decimal)

-- sqlfmt-corpus-separator --

SELECT name
FROM system.settings
WHERE name NOT LIKE 'sql.defaults%'
AND name NOT LIKE 'sql.distsql%'
AND name NOT LIKE 'sql.testing%'
AND name NOT LIKE 'sql.stats%'
AND name NOT LIKE 'sql.txn.%_isolation.enabled'
AND name != 'kv.range_merge.queue_enabled'
ORDER BY name

-- sqlfmt-corpus-separator --

SELECT name
FROM system.settings
WHERE name NOT LIKE 'sql.defaults%'
AND name NOT LIKE 'sql.distsql%'
AND name NOT LIKE 'sql.testing%'
AND name NOT LIKE 'sql.stats%'
AND name NOT LIKE 'sql.txn.%_isolation.enabled'
ORDER BY name

-- sqlfmt-corpus-separator --

SELECT name FROM pg_catalog.pg_settings WHERE name LIKE 'custom_option.%'

-- sqlfmt-corpus-separator --

SELECT name, state
     FROM crdb_internal.tables
    WHERE schema_name = 'public'
      AND name LIKE '%typ%'
 ORDER BY name;

-- sqlfmt-corpus-separator --

SELECT name, statement, is_scrollable, is_holdable, is_binary, now() - creation_time < '1 second'::interval FROM pg_catalog.pg_cursors

-- sqlfmt-corpus-separator --

SELECT name, statement, parameter_types, from_sql FROM pg_prepared_statements WHERE name LIKE 'args_%' ORDER BY 1,2

-- sqlfmt-corpus-separator --

SELECT netmask('192.168.1.2'::INET)

-- sqlfmt-corpus-separator --

SELECT netmask('192.168.1.2/0'::INET)

-- sqlfmt-corpus-separator --

SELECT netmask('192.168.1.2/10'::INET)

-- sqlfmt-corpus-separator --

SELECT netmask('192.168.1.2/16'::INET)

-- sqlfmt-corpus-separator --

SELECT netmask('2001:4f8:3:ba:2e0:81ff:fe22:d1f1/128'::INET)

-- sqlfmt-corpus-separator --

SELECT netmask('2001:4f8:3:ba::/0'::INET)

-- sqlfmt-corpus-separator --

SELECT netmask('2001:4f8:3:ba::/64'::INET)

-- sqlfmt-corpus-separator --

SELECT netmask('::ffff:1.2.3.1/120'::INET)

-- sqlfmt-corpus-separator --

SELECT netmask('::ffff:1.2.3.1/20'::INET)

-- sqlfmt-corpus-separator --

SELECT nextval(12345::regclass) # Bogus ID

-- sqlfmt-corpus-separator --

SELECT nlevel(''::LTREE);

-- sqlfmt-corpus-separator --

SELECT nlevel('Top.Child1.Child2'::LTREE);

-- sqlfmt-corpus-separator --

SELECT nlevel(NULL::LTREE);

-- sqlfmt-corpus-separator --

SELECT node_id, regexp_replace(epoch::string, '^\d+$', '<epoch>') as epoch, regexp_replace(expiration, '^(\d+\.)?\d+,\d+$', '<timestamp>') as expiration, draining, decommissioning, membership FROM crdb_internal.gossip_liveness WHERE node_id = 1

-- sqlfmt-corpus-separator --

SELECT now() + '1m'::interval > now(), now() + '1m'::interval >= now()

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

SELECT now() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT now()::timestamp - now(), now() - now()::timestamp

-- sqlfmt-corpus-separator --

SELECT now()::timestamp < now(), now() < now()::timestamp

-- sqlfmt-corpus-separator --

SELECT now()::timestamp <= now(), now() <= now()::timestamp

-- sqlfmt-corpus-separator --

SELECT obj_description('t'::regclass::oid),
       obj_description('t'::regclass::oid, 'pg_class'),
       obj_description('t'::regclass::oid, 'notexist'),
       col_description('t'::regclass, 1)

-- sqlfmt-corpus-separator --

SELECT obj_description('t45707'::REGCLASS)

-- sqlfmt-corpus-separator --

SELECT obj_description(indexrelid)
  FROM pg_index
 WHERE indrelid = 't45707'::REGCLASS
   AND indisprimary

-- sqlfmt-corpus-separator --

SELECT obj_description(oid) FROM pg_constraint WHERE conrelid = 't_constraints'::regclass AND contype = 'p';

-- sqlfmt-corpus-separator --

SELECT octet_length('Hello'), octet_length('世界'), octet_length(b'世界')

-- sqlfmt-corpus-separator --

SELECT oid, proname FROM pg_proc WHERE oid = 'sc.proc_f_2'::regproc

-- sqlfmt-corpus-separator --

SELECT oid, proname, prosrc
FROM pg_catalog.pg_proc WHERE proname LIKE 'f\_%' ORDER BY oid;

-- sqlfmt-corpus-separator --

SELECT overlaps
(DATE '2000-01-03',
DATE '2000-02-03',
DATE '2000-03-03',
DATE '2000-01-03',
DATE '2000-01-04');

-- sqlfmt-corpus-separator --

SELECT overlaps(
DATE '2000-01-01',
DATE '2000-01-02',
DATE '2000-01-03',
DATE '2000-01-04');

-- sqlfmt-corpus-separator --

SELECT overlaps(
DATE '2000-01-01',
DATE '2000-01-03',
DATE '2000-01-02',
DATE '2000-01-04');

-- sqlfmt-corpus-separator --

SELECT overlaps(
DATE '2000-01-01',
DATE '2000-01-03',
DATE '2000-01-03',
DATE '2000-01-04');

-- sqlfmt-corpus-separator --

SELECT overlaps(
DATE '2000-01-01',
INTERVAL '1 day',
DATE '2000-01-02',
INTERVAL '2 days');

-- sqlfmt-corpus-separator --

SELECT overlaps(
DATE '2000-01-01',
INTERVAL '2 days',
DATE '2000-01-02',
INTERVAL '2 days');

-- sqlfmt-corpus-separator --

SELECT overlaps(
DATE '2000-01-01',
INTERVAL '3 hours',
DATE '2000-01-02',
INTERVAL '2 days');

-- sqlfmt-corpus-separator --

SELECT overlaps(
DATE '2000-01-03',
DATE '2000-01-01',
DATE '2000-01-02',
DATE '2000-01-04');

-- sqlfmt-corpus-separator --

SELECT overlaps(
DATE '2000-01-03',
DATE '2000-01-03',
DATE '2000-01-03',
DATE '2000-01-04');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIME '2000-01-01 00:00:00',
INTERVAL '100 s',
TIME '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIME '2000-01-01 00:00:00',
INTERVAL '2 hours',
TIME '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIME '2000-01-01 00:00:00',
INTERVAL '30 minutes',
TIME '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIME '2000-01-01 00:00:00',
TIME '2000-01-01 00:15:00',
TIME '2000-01-01 00:30:00',
TIME '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIME '2000-01-01 00:00:00',
TIME '2000-01-01 00:30:00',
TIME '2000-01-01 00:30:00',
TIME '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIME '2000-01-01 00:00:00',
TIME '2000-01-01 01:00:00',
TIME '2000-01-01 00:30:00',
TIME '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIME '2000-01-01 00:30:00',
TIME '2000-01-01 00:30:00',
TIME '2000-01-01 00:30:00',
TIME '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIME '2000-01-01 01:00:00',
TIME '2000-01-01 00:00:00',
TIME '2000-01-01 00:30:00',
TIME '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMP '2000-01-01 00:00:00',
INTERVAL '100 days',
TIMESTAMP '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMP '2000-01-01 00:00:00',
INTERVAL '100 s',
TIMESTAMP '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMP '2000-01-01 00:00:00',
INTERVAL '2 days',
DATE '2000-01-01',
TIMESTAMPTZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMP '2000-01-01 00:00:00',
INTERVAL '30 minutes',
TIMESTAMP '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMP '2000-01-01 00:00:00',
TIME '2000-01-01 01:00:00',
TIME '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMP '2000-01-01 00:00:00',
TIMESTAMP '2000-01-01 00:15:00',
TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMP '2000-01-01 00:00:00',
TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMP '2000-01-01 00:00:00',
TIMESTAMP '2000-01-01 01:00:00',
TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMP '2000-01-01 01:00:00',
TIMESTAMP '2000-01-01 00:00:00',
TIMESTAMP '2000-01-01 00:30:00',
TIMESTAMP '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMPTZ '2000-01-01 00:00:00',
INTERVAL '100 days',
TIMESTAMPTZ '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMPTZ '2000-01-01 00:00:00',
INTERVAL '100 s',
TIMESTAMPTZ '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMPTZ '2000-01-01 00:00:00',
INTERVAL '30 minutes',
TIMESTAMPTZ '2000-01-01 00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMPTZ '2000-01-01 00:00:00',
TIMESTAMPTZ '2000-01-01 00:15:00',
TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMPTZ '2000-01-01 00:00:00',
TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMPTZ '2000-01-01 00:00:00',
TIMESTAMPTZ '2000-01-01 01:00:00',
TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMESTAMPTZ '2000-01-01 01:00:00',
TIMESTAMPTZ '2000-01-01 00:00:00',
TIMESTAMPTZ '2000-01-01 00:30:00',
TIMESTAMPTZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMETZ '00:00:00',
INTERVAL '100 s',
TIMETZ '00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMETZ '00:00:00',
INTERVAL '3 hours',
TIMETZ '00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMETZ '00:00:00',
INTERVAL '30 minutes',
TIMETZ '00:30:00',
INTERVAL '30 minutes');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMETZ '2000-01-01 00:00:00',
TIMETZ '2000-01-01 00:15:00',
TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMETZ '2000-01-01 00:00:00',
TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMETZ '2000-01-01 00:00:00',
TIMETZ '2000-01-01 01:00:00',
TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(
TIMETZ '2000-01-01 01:00:00',
TIMETZ '2000-01-01 00:00:00',
TIMETZ '2000-01-01 00:30:00',
TIMETZ '2000-01-01 01:30:00');

-- sqlfmt-corpus-separator --

SELECT overlaps(DATE '2000-01-01', INTERVAL '1 day', NULL, NULL);

-- sqlfmt-corpus-separator --

SELECT overlaps(DATE '2000-01-01', NULL, DATE '2000-01-01', DATE '2000-01-02');

-- sqlfmt-corpus-separator --

SELECT overlaps(NULL, INTERVAL '1 day', NULL, NULL);

-- sqlfmt-corpus-separator --

SELECT pg_advisory_xact_lock(0::INT4, -1::INT4)

-- sqlfmt-corpus-separator --

SELECT pg_advisory_xact_lock(1::INT4, 2::INT4)

-- sqlfmt-corpus-separator --

SELECT pg_advisory_xact_lock(3::INT4, 4::INT4)

-- sqlfmt-corpus-separator --

SELECT pg_advisory_xact_lock(7::INT4, 8::INT4)

-- sqlfmt-corpus-separator --

SELECT pg_advisory_xact_lock_shared(1::INT4, 2::INT4)

-- sqlfmt-corpus-separator --

SELECT pg_advisory_xact_lock_shared(2::INT4, 3::INT4)

-- sqlfmt-corpus-separator --

SELECT pg_collation_for('foo'::CITEXT);

-- sqlfmt-corpus-separator --

SELECT pg_column_size('{}'::json)

-- sqlfmt-corpus-separator --

SELECT pg_get_function_arguments('array_length'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_function_arguments('convert_from'::regproc::oid)

-- sqlfmt-corpus-separator --

SELECT pg_get_function_arguments('version'::regproc::oid)

-- sqlfmt-corpus-separator --

SELECT pg_get_function_identity_arguments('array_length'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_function_identity_arguments('convert_from'::regproc::oid)

-- sqlfmt-corpus-separator --

SELECT pg_get_function_identity_arguments('version'::regproc::oid)

-- sqlfmt-corpus-separator --

SELECT pg_get_function_result('array_length'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_function_result('pg_sleep'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_function_result('unnest'::regproc);

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('get_l'::regproc::oid)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('soundex'::regproc::oid)

-- sqlfmt-corpus-separator --

SELECT pg_get_indexdef('expr_idx'::regclass::oid)

-- sqlfmt-corpus-separator --

SELECT pg_my_temp_schema()::TEXT LIKE 'pg_temp_%'

-- sqlfmt-corpus-separator --

SELECT pg_sequence_last_value('multiple_seq_test_tbl'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_sequence_last_value('seq_test_last_value'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_sequence_last_value('seq_test_last_value_cached'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_sequence_parameters('bar'::regclass::oid)

-- sqlfmt-corpus-separator --

SELECT pg_sequence_parameters('baz'::regclass::oid)

-- sqlfmt-corpus-separator --

SELECT pg_sequence_parameters('down_test'::regclass::oid)

-- sqlfmt-corpus-separator --

SELECT pg_sequence_parameters('foo'::regclass::oid)

-- sqlfmt-corpus-separator --

SELECT pg_try_advisory_xact_lock(0::INT4, -1::INT4)

-- sqlfmt-corpus-separator --

SELECT pg_try_advisory_xact_lock(1::INT4, 2::INT4)

-- sqlfmt-corpus-separator --

SELECT pg_try_advisory_xact_lock(3::INT4, 4::INT4)

-- sqlfmt-corpus-separator --

SELECT pg_try_advisory_xact_lock_shared(2::INT4, 3::INT4)

-- sqlfmt-corpus-separator --

SELECT pg_try_advisory_xact_lock_shared(3::INT4, 4::INT4)

-- sqlfmt-corpus-separator --

SELECT pg_type_is_visible('int'::regtype), pg_type_is_visible(NULL), pg_type_is_visible(99999)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('1'::OID), pg_typeof('pg_constraint'::REGCLASS), pg_typeof('public'::REGNAMESPACE)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('Foo'::CITEXT)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('Foo'::CITEXT::TEXT::CITEXT)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('root'::REGROLE), pg_typeof('bool'::REGTYPE)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('testuser=r/root'::aclitem)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('upper'::REGPROC), pg_typeof('upper(string)'::REGPROCEDURE)

-- sqlfmt-corpus-separator --

SELECT pg_typeof('{"a": 1}'::JSONB->'a')

-- sqlfmt-corpus-separator --

SELECT pg_typeof('{"a": 1}'::JSONB->>'a')

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::OID), pg_typeof(1::REGCLASS), pg_typeof(1::REGNAMESPACE)

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::REGPROC), pg_typeof(1::REGPROCEDURE), pg_typeof(1::REGROLE), pg_typeof(1::REGTYPE)

-- sqlfmt-corpus-separator --

SELECT pg_typeof(CITEXT 'Foo')

-- sqlfmt-corpus-separator --

SELECT pg_typeof(JSON '1')

-- sqlfmt-corpus-separator --

SELECT pg_typeof(JSONB '1')

-- sqlfmt-corpus-separator --

SELECT pg_typeof(JSONPATH '$.a')

-- sqlfmt-corpus-separator --

SELECT pg_typeof(acldefault('r', 0::oid))

-- sqlfmt-corpus-separator --

SELECT pow(1e-10::DECIMAL, 2)

-- sqlfmt-corpus-separator --

SELECT pow(1e-4::DECIMAL, 2), pow(1e-5::DECIMAL, 2), pow(1e-8::DECIMAL, 2), pow(1e-9::DECIMAL, 2)

-- sqlfmt-corpus-separator --

SELECT pow(4.727998800941528e-14::DECIMAL, 0.06081860494226844::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT pow(CAST (pi() AS DECIMAL), DECIMAL '2.0')

-- sqlfmt-corpus-separator --

SELECT pow(sqrt(1e-10::DECIMAL), 2), sqrt(pow(1e-5::DECIMAL, 2))

-- sqlfmt-corpus-separator --

SELECT power(0::decimal, -1)

-- sqlfmt-corpus-separator --

SELECT proargtypes::REGTYPE[] FROM pg_proc WHERE proname = 'obj_description'

-- sqlfmt-corpus-separator --

SELECT product_name, array_agg(product_name) OVER (ORDER BY group_id) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT public.ST_AsText('POINT(10.5 20.25)'::geometry)

-- sqlfmt-corpus-separator --

SELECT quote_ident(descriptor_name), quote_ident(column_name) FROM crdb_internal.table_columns
WHERE descriptor_name ILIKE '%t%e%s%t%'
ORDER BY descriptor_name, column_name

-- sqlfmt-corpus-separator --

SELECT quote_literal(b'abc'), quote_nullable(b'abc')

-- sqlfmt-corpus-separator --

SELECT regexp_replace(
            json_array_elements_text(
                (info::JSONB)->'DroppedSchemaObjects'
            ),
            'pg_temp_[^.]+.',
            'pg_temp.'
         ) AS name
    FROM system.eventlog
   WHERE "timestamp" > '$before_drop'
ORDER BY name DESC;

-- sqlfmt-corpus-separator --

SELECT regexp_replace(obj_description('pg_class'::regclass::oid), e' .*', '') AS comment1,
       regexp_replace(obj_description('pg_class'::regclass::oid, 'pg_class'), e' .*', '') AS comment2

-- sqlfmt-corpus-separator --

SELECT regr_avgx(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_avgx(y, x)::decimal, regr_avgx(int_y, int_x)::decimal, regr_avgx(y, int_x)::decimal,
regr_avgx(int_y, x)::decimal
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_avgx(y::string, x::string) FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_avgy(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_avgy(y::string, x::string) FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_count(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_count(y::string, x::string) FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_intercept(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_intercept(y::string, x::string) FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_r2(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_r2(y::string, x::string) FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_slope(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_slope(y::string, x::string) FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_sxx(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_sxx(y::string, x::string) FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_sxy(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_sxy(y::string, x::string) FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_syy(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_syy(y::string, x::string) FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT relname from pg_class where oid='"quotedCase"'::regclass

-- sqlfmt-corpus-separator --

SELECT relname from pg_class where oid='a'::regclass

-- sqlfmt-corpus-separator --

SELECT relname from pg_class where oid='hasCase'::regclass

-- sqlfmt-corpus-separator --

SELECT relname from pg_class where oid='quotedCase'::regclass

-- sqlfmt-corpus-separator --

SELECT relname, oid::regclass::string from pg_class where oid='my_b_index'::regclass

-- sqlfmt-corpus-separator --

SELECT relname, oid::regclass::string from pg_class where oid='table_with_indexes_pkey'::regclass

-- sqlfmt-corpus-separator --

SELECT relname, relnatts FROM pg_class WHERE oid='a'::regclass

-- sqlfmt-corpus-separator --

SELECT repeat('a', 1<<20)::tsquery

-- sqlfmt-corpus-separator --

SELECT repeat('a', 1<<20)::tsvector

-- sqlfmt-corpus-separator --

SELECT repeat('a', 2047)::tsquery

-- sqlfmt-corpus-separator --

SELECT repeat('a', 2047)::tsvector

-- sqlfmt-corpus-separator --

SELECT right('abcde💩'::bytes, 2)

-- sqlfmt-corpus-separator --

SELECT round('inf'::decimal)

-- sqlfmt-corpus-separator --

SELECT round(-2.5::decimal), round(-1.5::decimal), round(0.0::decimal), round(1.5::decimal), round(2.5::decimal)

-- sqlfmt-corpus-separator --

SELECT round(-2.5::decimal, 0), round(-1.5::decimal, 0), round(1.5::decimal, 0), round(2.5::decimal, 0)

-- sqlfmt-corpus-separator --

SELECT round(-2.5::decimal, 3), round(-1.5::decimal, 3), round(0.0::decimal, 3), round(1.5::decimal, 3), round(2.5::decimal, 3)

-- sqlfmt-corpus-separator --

SELECT round(123.456::decimal, -1), round(123.456::decimal, -2), round(123.456::decimal, -3), round(123.456::decimal, -200), round(-0.1::decimal)

-- sqlfmt-corpus-separator --

SELECT round(1::decimal, 3000)

-- sqlfmt-corpus-separator --

SELECT round(avg(k) OVER ()) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT round(avg(k) OVER (PARTITION BY v ORDER BY w)) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT round(erf(1)::numeric, 4), round(erfc(1)::numeric, 4)

-- sqlfmt-corpus-separator --

SELECT s, s::a FROM strings ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT s, s::record FROM strings ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT s::VARCHAR(2)[] FROM hello

-- sqlfmt-corpus-separator --

SELECT scale('NaN'::decimal), min_scale('Infinity'::decimal)

-- sqlfmt-corpus-separator --

SELECT set_bit(B'', 0, 1)

-- sqlfmt-corpus-separator --

SELECT set_bit(B'1001010', 0, 2)

-- sqlfmt-corpus-separator --

SELECT set_bit(B'1101010', 10, 1)

-- sqlfmt-corpus-separator --

SELECT set_bit(b'', 0, 1)

-- sqlfmt-corpus-separator --

SELECT set_bit(b'ac', 16, 0)

-- sqlfmt-corpus-separator --

SELECT set_byte('Th\000omas'::BYTEA, 2, 16448)

-- sqlfmt-corpus-separator --

SELECT set_byte('Th\000omas'::BYTEA, 2, 64)

-- sqlfmt-corpus-separator --

SELECT set_byte('abc'::BYTEA, -10, 123)

-- sqlfmt-corpus-separator --

SELECT set_byte('abc'::BYTEA, 10, 123)

-- sqlfmt-corpus-separator --

SELECT set_masklen('10.1.0.0/16'::INET, 10)

-- sqlfmt-corpus-separator --

SELECT set_masklen('192.168.0.1'::INET, -1)

-- sqlfmt-corpus-separator --

SELECT set_masklen('192.168.0.1'::INET, 0)

-- sqlfmt-corpus-separator --

SELECT set_masklen('192.168.0.1'::INET, 100)

-- sqlfmt-corpus-separator --

SELECT set_masklen('192.168.0.1'::INET, 33)

-- sqlfmt-corpus-separator --

SELECT set_masklen('192.168.0.1/16'::INET, 32)

-- sqlfmt-corpus-separator --

SELECT set_masklen('::ffff:192.168.0.1'::INET, -1)

-- sqlfmt-corpus-separator --

SELECT set_masklen('::ffff:192.168.0.1'::INET, 100)

-- sqlfmt-corpus-separator --

SELECT set_masklen('::ffff:192.168.0.1'::INET, 129)

-- sqlfmt-corpus-separator --

SELECT set_masklen('::ffff:192.168.0.1/24'::INET, 0)

-- sqlfmt-corpus-separator --

SELECT setval('seq71135'::regclass::oid, 500)

-- sqlfmt-corpus-separator --

SELECT setval(12345::regclass, 30, false) # Bogus ID

-- sqlfmt-corpus-separator --

SELECT sha1(NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT sha224(NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT sha256(NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT sha384(NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT sha512(NULL::STRING, NULL::STRING)

-- sqlfmt-corpus-separator --

SELECT shobj_description('t'::regclass::oid, 'pg_class'),
       obj_description((select oid from pg_database where datname = 'test')::oid, 'pg_database')

-- sqlfmt-corpus-separator --

SELECT shobj_description((select oid from pg_database where datname = 'defaultdb')::oid, 'pg_database'),
       shobj_description((select oid from pg_database where datname = 'test')::oid, 'pg_database'),
       shobj_description((select oid from pg_database where datname = 'notexist')::oid, 'pg_database'),
       shobj_description((select oid from pg_database where datname = 'test')::oid, 'notexist')

-- sqlfmt-corpus-separator --

SELECT sqrt(-1.0::decimal)

-- sqlfmt-corpus-separator --

SELECT sqrt(9.789765531128956e-34::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT st_asencodedpolyline(geomfromewkb(('01070000A0E61000000300000001060000A0E6100000040000000103000080010000000B0000006F9AF3F7D81863C057397A0B3ACD42C006ED79D13D2DF24130E1CBF62A4A45C01B6DC0D279F452C022F8C672D2C1F9C140DB9D23050141C0B53FBA6E396656C0C0A1842E2B53EC413A8DC94C568D61401BEF0352091651C05C681DE175D2FD41A048C859DF7C5440C00E327AC97FF63F68BBA8144D0EF8416E6042F340DD6040805791CE56602740DC6C3922676401C29C6D4009B1334E40625E855D7A7E5140D4241F7D86D2D5C14B1E4BCA077A58C07806BF9D4D084D4074E74BE4DCAA00C2C11D020045A051C0D81F8E3DD0AE3740B8315FF7F63AF4C1BAD97494BA9860C07411EFAF0A6C3D4038E26DE7A194F4C16F9AF3F7D81863C057397A0B3ACD42C006ED79D13D2DF2410103000080010000000B000000610D90AE22A55FC0B8265672F7562940CE3E91EB7A320042CC96C05617B649C085229B1A09E153C0D84FA7998764EB4190FEB5A7C71B2DC03EBBCB6B588F4DC02891E1ED4A7DE6417C0F7BBC14C75840E08D4D210E2F21C04180E453EDEDFFC112E57185B2435240F0D20FC2D7C11640F8BF2E3AB98DD2C1D0A9A94D6EA14140FCABD1E5BF074B400010C2F75AA16F4166BC301BE6FB55C002F9F182DE3D53400038B551BC0495C199463681FA6E5CC0184D3E0AE179554030323F0F2525F4415791FBE04FEA61C0361E8733C77A5240C84AEBEAD466EEC1D5012A75E04F63C0A8BF403F623D4240182CFEFA9071E0C1610D90AE22A55FC0B8265672F7562940CE3E91EB7A3200420103000080010000000C000000004CADA6B302E0BF3EE5FA281ACE3BC0E051ABD6580901429B65A22CCBDC53C003DEBC27260E4AC07E45691D3E7AF541408E6FAB9A1008C016E33E2631FD40C0EEF80F0FF3E8F341A8C5EAA8B0C836409E85B8193CE952C0F4448FFF9B31F24190F9A9FCD2AC604004F99C51ED4356C0903A1F652902D4C1C01B737BD389554080315427550738C05C51AE075475F64124F6F92382235C40148AB5FED33D38C048960D3AC6D7E8412C2E310EABA5514058EA10C427562EC0A82D4D1A69D7FE41621FC77070C26540FE84B78FE5BE51400962385E53FAFEC1483899F770B14DC020BD4BBBAB604D401C08306EA143E84140337962764325C0002F089A1DF3F83FAC9B66F32C2BE841004CADA6B302E0BF3EE5FA281ACE3BC0E051ABD65809014201030000800100000006000000D03FF366A2C95C40E59BFCECDD7553C0D028B038BB63D041A40AEF5CB0195840006FB928107F084020CA0A39A4AED34100F09D4126336140E8AC65DAC4954C4024406D4040D1EE41F04B3F3DA6C75740106594C0ADCE4440A498B6372039FD4155D08A1E777452C084CC004170E949409C87DF53EB9AFDC1D03FF366A2C95C40E59BFCECDD7553C0D028B038BB63D04101020000A0E61000000200000074F55D784E5F50408F7DE14351CD41C0FCCCE7B1B166F541583C392FCD7554409022EAF3EFCC39C03CDE1C0E29A7EB4101040000A0E6100000060000000101000080E8801DFC8A2130C04401B4AE182F50C0BC13340EB7E2E1C1010100008010DC3F808D824D406C9927CDAE5144409A464D93BBD7F94101010000806F0682A50FE253C030E1964D47F74BC00E752ECB60B0F441010100008014F5242FC2C444C01257DB8E51FA51404449E2FB7D2AFFC1010100008069945BA1FD2E50C0501CA74B7A661C40CB83CB9A4894F1C10101000080C0BBBC345A4B51C0E08F6EBB2F250E400681A78F4FFCF741'::GEOGRAPHY)::BYTEA)::GEOMETRY);

-- sqlfmt-corpus-separator --

SELECT st_asewkt(st_rotate('LINESTRING (1 5, 5 1)'::geometry,pi()/4,'POINT EMPTY'::geometry))

-- sqlfmt-corpus-separator --

SELECT st_asmvtgeom(
  '0103000000010000000500000000000000000000000000000000000000000000000000F03F0000000000000000000000000000F03F000000000000F03F0000000000000000000000000000F03F00000000000000000000000000000000'::GEOMETRY,
  'BOX(-0.7283491852530968 -1.8211168776573217,0.5639272771291987 1.4483176236186077)'::BOX2D,
  1,
  34268045,
  true
) AS regression_109113

-- sqlfmt-corpus-separator --

SELECT st_astext(st_addmeasure('POINT(0 0)'::geometry, 0, 1))

-- sqlfmt-corpus-separator --

SELECT st_snap('01010000C0000000000000F87F000000000000F87F000000000000F87F000000000000F87F'::GEOMETRY, '01010000C0000000000000F87F000000000000F87F000000000000F87F000000000000F87F'::GEOMETRY, 0.5::FLOAT8);

-- sqlfmt-corpus-separator --

SELECT st_snaptogrid('POINT(0 0 0)'::geometry, 'LINESTRING(0 0 0, 1 1 1)'::geometry, 1, 1, 1, 1)

-- sqlfmt-corpus-separator --

SELECT stddev_pop('inf'::numeric), stddev_samp('inf'::numeric)

-- sqlfmt-corpus-separator --

SELECT stddev_pop(x), stddev_pop(y::decimal), round(stddev_pop(z), 14) FROM xyz

-- sqlfmt-corpus-separator --

SELECT stddev_samp(x), stddev(y::decimal), round(stddev_samp(z), 14) FROM xyz

-- sqlfmt-corpus-separator --

SELECT str FROM NumToStr WHERE y % 1000 = 0 AND str LIKE '%i%' ORDER BY y

-- sqlfmt-corpus-separator --

SELECT str FROM NumToStr WHERE y < 10 AND str LIKE '%e%' ORDER BY y

-- sqlfmt-corpus-separator --

SELECT string_agg('foo', CAST ((SELECT NULL) AS BYTES)) OVER ();

-- sqlfmt-corpus-separator --

SELECT strpos('000001'::varbit, '1'::varbit)

-- sqlfmt-corpus-separator --

SELECT strpos(B'00001111', B'1111'), strpos(B'', B''), strpos(B'0000111', B'1111')

-- sqlfmt-corpus-separator --

SELECT subltree('Top.Child1.Child2'::LTREE, -1, 2);

-- sqlfmt-corpus-separator --

SELECT subltree('Top.Child1.Child2'::LTREE, 0, -1);

-- sqlfmt-corpus-separator --

SELECT subltree('Top.Child1.Child2'::LTREE, 0, 99);

-- sqlfmt-corpus-separator --

SELECT subltree('Top.Child1.Child2'::LTREE, 1, 2);

-- sqlfmt-corpus-separator --

SELECT subltree('Top.Child1.Child2'::LTREE, 3, 2);

-- sqlfmt-corpus-separator --

SELECT subltree(NULL::LTREE, 99, 99);

-- sqlfmt-corpus-separator --

SELECT subpath(''::LTREE, -1);

-- sqlfmt-corpus-separator --

SELECT subpath(''::LTREE, 0);

-- sqlfmt-corpus-separator --

SELECT subpath('A.B.C'::LTREE, 1, 9223372036854775807::INT8)

-- sqlfmt-corpus-separator --

SELECT subpath('Top.Child1.Child2'::LTREE, -1, -2);

-- sqlfmt-corpus-separator --

SELECT subpath('Top.Child1.Child2'::LTREE, -2);

-- sqlfmt-corpus-separator --

SELECT subpath('Top.Child1.Child2'::LTREE, -3, -2);

-- sqlfmt-corpus-separator --

SELECT subpath('Top.Child1.Child2'::LTREE, -4);

-- sqlfmt-corpus-separator --

SELECT subpath('Top.Child1.Child2'::LTREE, 0, -1);

-- sqlfmt-corpus-separator --

SELECT subpath('Top.Child1.Child2'::LTREE, 0, -3);

-- sqlfmt-corpus-separator --

SELECT subpath('Top.Child1.Child2'::LTREE, 0, -4);

-- sqlfmt-corpus-separator --

SELECT subpath('Top.Child1.Child2'::LTREE, 1);

-- sqlfmt-corpus-separator --

SELECT subpath('Top.Child1.Child2'::LTREE, 1, 1);

-- sqlfmt-corpus-separator --

SELECT subpath('Top.Child1.Child2'::LTREE, 1, 99);

-- sqlfmt-corpus-separator --

SELECT subpath('Top.Child1.Child2'::LTREE, 3);

-- sqlfmt-corpus-separator --

SELECT subpath(NULL::LTREE, 99, 99);

-- sqlfmt-corpus-separator --

SELECT substr(uuid_generate_v1()::TEXT, 24) = substr(uuid_generate_v1()::TEXT, 24)

-- sqlfmt-corpus-separator --

SELECT substr(uuid_generate_v1mc()::TEXT, 24) = substr(uuid_generate_v1mc()::TEXT, 24)

-- sqlfmt-corpus-separator --

SELECT substring('11100011'::bit(10), 4, -1)

-- sqlfmt-corpus-separator --

SELECT substring('11100011'::bit(10), 4, 10), substring('11100011'::bit(8), 1, 8)

-- sqlfmt-corpus-separator --

SELECT substring('11100011'::bit(8), 4), substring('11100011'::bit(6), 4), substring(B'', 0, 1)

-- sqlfmt-corpus-separator --

SELECT substring('11100011'::bytea, 4, -1)

-- sqlfmt-corpus-separator --

SELECT substring('abc'::bytea, 0)

-- sqlfmt-corpus-separator --

SELECT substring('abc'::bytea, 0, 4)

-- sqlfmt-corpus-separator --

SELECT substring(B'11110000', 0), substring(B'11110000', -1), substring(B'11110000', 5)

-- sqlfmt-corpus-separator --

SELECT substring(B'11110000', 0, 4), substring(B'11110000', -1, 4), substring(B'11110000', 5, 10)

-- sqlfmt-corpus-separator --

SELECT substring(B'11110000', 8), substring(B'11110000', 10), substring(B'', 0)

-- sqlfmt-corpus-separator --

SELECT substring(B'11110000', 8, 1), substring(B'11110000', 8, 0), substring(B'11110000', 10, 5)

-- sqlfmt-corpus-separator --

SELECT substring(b'abc', 3), substring(b'abc', 5)

-- sqlfmt-corpus-separator --

SELECT substring(b'abc', 3, 1), substring(b'abc', 3, 0), substring(b'abc', 4, 3)

-- sqlfmt-corpus-separator --

SELECT substring(x, -1::INT2, 3::INT4) FROM builtin_test

-- sqlfmt-corpus-separator --

SELECT sum(DISTINCT a), sum_int(DISTINCT a) FROM data

-- sqlfmt-corpus-separator --

SELECT sum(DISTINCT a), sum_int(DISTINCT a), sum(DISTINCT b), sum_int(DISTINCT b) from data

-- sqlfmt-corpus-separator --

SELECT sum(a) OVER (ORDER BY count(a) OVER () + 1) FROM x

-- sqlfmt-corpus-separator --

SELECT sum(a) OVER (ORDER BY count(a) OVER ()) FROM x

-- sqlfmt-corpus-separator --

SELECT sum(a) OVER (PARTITION BY count(a) OVER () + 1) FROM x

-- sqlfmt-corpus-separator --

SELECT sum(a) OVER (PARTITION BY count(a) OVER ()) FROM x

-- sqlfmt-corpus-separator --

SELECT sum(v) FROM kv GROUP BY k LIMIT 1 OFFSET sum(v) OVER ()

-- sqlfmt-corpus-separator --

SELECT sum(v) FROM kv GROUP BY k LIMIT sum(v) OVER ()

-- sqlfmt-corpus-separator --

SELECT t + '-18:00:00'::INTERVAL < '07:00:00'::TIME FROM t88128

-- sqlfmt-corpus-separator --

SELECT t + '02:00:00'::INTERVAL > '01:00:00'::TIME FROM t88128

-- sqlfmt-corpus-separator --

SELECT t - '-2:00:00'::INTERVAL > '01:00:00'::TIME FROM t88128

-- sqlfmt-corpus-separator --

SELECT t - '05:00:00'::INTERVAL < '23:59:00'::TIME FROM t88128

-- sqlfmt-corpus-separator --

SELECT t - (SELECT '0001-01-01 00:00:00'::TIMESTAMP - a::INTERVAL FROM ts ORDER BY a LIMIT 1) FROM ts

-- sqlfmt-corpus-separator --

SELECT t126773::t126773 FROM t126773;

-- sqlfmt-corpus-separator --

SELECT table_id, name, state
FROM crdb_internal.tables WHERE name
LIKE 'ref_temp_table%' AND state = 'PUBLIC'

-- sqlfmt-corpus-separator --

SELECT table_name, table_type FROM information_schema.tables WHERE table_name = 'temp_table_test' AND table_schema LIKE 'pg_temp_%'

-- sqlfmt-corpus-separator --

SELECT tablename, hasindexes FROM pg_catalog.pg_tables WHERE schemaname = 'information_schema' AND tablename LIKE '%table%'

-- sqlfmt-corpus-separator --

SELECT tag FROM t103616
WHERE
    0 <= st_distance(geog, 'POINT(0 0)'::GEOGRAPHY);

-- sqlfmt-corpus-separator --

SELECT tag FROM t103616
WHERE
    0 <= st_maxdistance(geom, 'POINT(0 0)'::GEOMETRY);

-- sqlfmt-corpus-separator --

SELECT tag FROM t103616
WHERE
    1.2345678901234566e-43 < st_distance(geog, 'POINT(0 0)'::GEOGRAPHY);

-- sqlfmt-corpus-separator --

SELECT tag FROM t103616
WHERE
    1.2345678901234566e-43 < st_maxdistance(geom, 'POINT(0 0)'::GEOMETRY);

-- sqlfmt-corpus-separator --

SELECT tag FROM t103616
WHERE
    NOT 1.2345678901234566e-43 > st_distance(geog, 'POINT(0 0)'::GEOGRAPHY);

-- sqlfmt-corpus-separator --

SELECT tag FROM t103616
WHERE
    NOT 1.2345678901234566e-43 > st_maxdistance(geom, 'POINT(0 0)'::GEOMETRY);

-- sqlfmt-corpus-separator --

SELECT text('10.1.0.0/16'::INET)

-- sqlfmt-corpus-separator --

SELECT text('192.168.0.1'::INET)

-- sqlfmt-corpus-separator --

SELECT text('192.168.0.1/16'::INET)

-- sqlfmt-corpus-separator --

SELECT text('192.168.0.1/32'::INET)

-- sqlfmt-corpus-separator --

SELECT text('::ffff:192.168.0.1'::INET)

-- sqlfmt-corpus-separator --

SELECT text('::ffff:192.168.0.1/24'::INET)

-- sqlfmt-corpus-separator --

SELECT tgname, tgenabled FROM pg_trigger WHERE tgrelid = 'enable_disable_t'::regclass ORDER BY tgname;

-- sqlfmt-corpus-separator --

SELECT timezone('UTC+6', '1970-01-01 01:00'::time)

-- sqlfmt-corpus-separator --

SELECT timezone('UTC+6', '1970-01-01 01:00'::timestamp)

-- sqlfmt-corpus-separator --

SELECT timezone('UTC+6', '1970-01-01 01:00'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT timezone('UTC+6', '1970-01-01 01:00'::timetz)

-- sqlfmt-corpus-separator --

SELECT to_char('-1 month 1 day'::interval, 'FMRM')

-- sqlfmt-corpus-separator --

SELECT to_char('-28 years 1 months'::interval, 'RM')

-- sqlfmt-corpus-separator --

SELECT to_char('-45 years 8 months'::interval, 'RM')

-- sqlfmt-corpus-separator --

SELECT to_char('-Infinity'::float8, '9.999')

-- sqlfmt-corpus-separator --

SELECT to_char('-Infinity'::float8, '9.999EEEE')

-- sqlfmt-corpus-separator --

SELECT to_char('-Infinity'::float8, '9999999999')

-- sqlfmt-corpus-separator --

SELECT to_char('12345678901'::float8, 'FM9999999999D9999900000000000000000')

-- sqlfmt-corpus-separator --

SELECT to_char('Infinity'::float8, '9.999')

-- sqlfmt-corpus-separator --

SELECT to_char('Infinity'::float8, '9.999EEEE')

-- sqlfmt-corpus-separator --

SELECT to_char('Infinity'::float8, '9999999999')

-- sqlfmt-corpus-separator --

SELECT to_char('NaN'::float8, '9.999')

-- sqlfmt-corpus-separator --

SELECT to_char('NaN'::numeric, '9.999')

-- sqlfmt-corpus-separator --

SELECT to_char('NaN'::numeric, '9.999EEEE')

-- sqlfmt-corpus-separator --

SELECT to_char('NaN'::numeric, '99')

-- sqlfmt-corpus-separator --

SELECT to_char('NaN'::numeric, '999.9')

-- sqlfmt-corpus-separator --

SELECT to_char('NaN'::numeric, '9999')

-- sqlfmt-corpus-separator --

SELECT to_char(-0.0000732454::numeric, 'D,')

-- sqlfmt-corpus-separator --

SELECT to_char(-0.0000993392::numeric, 'PLSG')

-- sqlfmt-corpus-separator --

SELECT to_char(-0.0001868529::numeric, '9PRB')

-- sqlfmt-corpus-separator --

SELECT to_char(-0.0003899093::numeric, 'PL')

-- sqlfmt-corpus-separator --

SELECT to_char(-0.0004161297::numeric, 'PL')

-- sqlfmt-corpus-separator --

SELECT to_char(-0.0004957701::numeric, '.')

-- sqlfmt-corpus-separator --

SELECT to_char(-0.0012345::numeric, '9.999EEEE')

-- sqlfmt-corpus-separator --

SELECT to_char(-0.0::numeric, '9.999EEEE')

-- sqlfmt-corpus-separator --

SELECT to_char(-1.705744::numeric, '9SDTHL')

-- sqlfmt-corpus-separator --

SELECT to_char(-12.34::numeric, '99V99')

-- sqlfmt-corpus-separator --

SELECT to_char(-123.456::float8, '999.99')

-- sqlfmt-corpus-separator --

SELECT to_char(-253449736220.25::numeric, '.')

-- sqlfmt-corpus-separator --

SELECT to_char(-305545638960.34::numeric, 'RNSPR')

-- sqlfmt-corpus-separator --

SELECT to_char(-341::numeric, 'RNPLG,')

-- sqlfmt-corpus-separator --

SELECT to_char(-536.393433::numeric, 'D')

-- sqlfmt-corpus-separator --

SELECT to_char(-620::numeric, 'FMPRPRD')

-- sqlfmt-corpus-separator --

SELECT to_char(0.000000001::numeric, '9.999EEEE')

-- sqlfmt-corpus-separator --

SELECT to_char(0.0012345::numeric, '9.999EEEE')

-- sqlfmt-corpus-separator --

SELECT to_char(0.001::numeric, '0.000000')

-- sqlfmt-corpus-separator --

SELECT to_char(0.0055::numeric, '9.99')

-- sqlfmt-corpus-separator --

SELECT to_char(0.1::numeric, '9.9')

-- sqlfmt-corpus-separator --

SELECT to_char(0::numeric, '.')

-- sqlfmt-corpus-separator --

SELECT to_char(0::numeric, '0BB.,')

-- sqlfmt-corpus-separator --

SELECT to_char(0::numeric, '0PR.PL')

-- sqlfmt-corpus-separator --

SELECT to_char(0::numeric, '9.999EEEE')

-- sqlfmt-corpus-separator --

SELECT to_char(0::numeric, '99V99')

-- sqlfmt-corpus-separator --

SELECT to_char(0::numeric, 'D')

-- sqlfmt-corpus-separator --

SELECT to_char(0::numeric, 'FM.')

-- sqlfmt-corpus-separator --

SELECT to_char(0::numeric, 'FMS9999999999999999.999999999999999')

-- sqlfmt-corpus-separator --

SELECT to_char(0::numeric, 'GRNSG')

-- sqlfmt-corpus-separator --

SELECT to_char(0::numeric, 'RNRNMI')

-- sqlfmt-corpus-separator --

SELECT to_char(0::numeric, 'SDFMFM')

-- sqlfmt-corpus-separator --

SELECT to_char(0::numeric, 'THB')

-- sqlfmt-corpus-separator --

SELECT to_char(1.2::numeric, '9V999')

-- sqlfmt-corpus-separator --

SELECT to_char(1.5::numeric, '9.9')

-- sqlfmt-corpus-separator --

SELECT to_char(100::numeric, 'FM999')

-- sqlfmt-corpus-separator --

SELECT to_char(100::numeric, 'FM999.')

-- sqlfmt-corpus-separator --

SELECT to_char(100::numeric, 'FM999.9')

-- sqlfmt-corpus-separator --

SELECT to_char(100::numeric, 'f"ool"999')

-- sqlfmt-corpus-separator --

SELECT to_char(100::numeric, 'foo999')

-- sqlfmt-corpus-separator --

SELECT to_char(115194410895.02::numeric, 'RN')

-- sqlfmt-corpus-separator --

SELECT to_char(12.45::numeric, '99V99')

-- sqlfmt-corpus-separator --

SELECT to_char(12.4::numeric, '99V9')

-- sqlfmt-corpus-separator --

SELECT to_char(12262::numeric, 'LRNL')

-- sqlfmt-corpus-separator --

SELECT to_char(123.456::float8, '999.99')

-- sqlfmt-corpus-separator --

SELECT to_char(123.45::numeric, '9.999EEEE')

-- sqlfmt-corpus-separator --

SELECT to_char(123.45::numeric, 'FM9.999EEEE')

-- sqlfmt-corpus-separator --

SELECT to_char(219433129409.03::numeric, 'LLTH')

-- sqlfmt-corpus-separator --

SELECT to_char(485::numeric, '999.99')

-- sqlfmt-corpus-separator --

SELECT to_char(485::numeric, 'FM999.90')

-- sqlfmt-corpus-separator --

SELECT to_char(485::numeric, 'FM999.99')

-- sqlfmt-corpus-separator --

SELECT to_char(522::numeric, 'RNLTHPL')

-- sqlfmt-corpus-separator --

SELECT to_char(855::numeric, '.')

-- sqlfmt-corpus-separator --

SELECT to_char(8672097::numeric, 'FMDS')

-- sqlfmt-corpus-separator --

SELECT to_char(8700679::numeric, 'TH')

-- sqlfmt-corpus-separator --

SELECT to_char(9.995::numeric, '99.99')

-- sqlfmt-corpus-separator --

SELECT to_char(99.999::numeric, '99.99')

-- sqlfmt-corpus-separator --

SELECT to_char(9999999::numeric, '9.999EEEE')

-- sqlfmt-corpus-separator --

SELECT to_char(d1::timestamp, 'FMY,YYY FMYYYY FMYYY FMYY FMY FMCC FMQ FMMM FMWW FMDDD FMDD FMD FMJ')
   FROM TIMESTAMPTZ_TBL ORDER BY id

-- sqlfmt-corpus-separator --

SELECT to_char_with_style(now()::date, 'postgres')

-- sqlfmt-corpus-separator --

SELECT to_char_with_style(now()::timestamp, 'postgres')

-- sqlfmt-corpus-separator --

SELECT to_date('0,562107', 'Y,YYYDDD')::text

-- sqlfmt-corpus-separator --

SELECT to_date('0001 AD', 'YYYY AD')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('0044 BC', 'YYYY BC')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('0100 BC', 'YYYY BC')::string

-- sqlfmt-corpus-separator --

SELECT to_date('1,999 12 31', 'Y,YYY MM DD')::string

-- sqlfmt-corpus-separator --

SELECT to_date('15 FEBRUARY 2023', 'DD MONTH YYYY')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('15 January 2023', 'DD MONTH YYYY')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('15 march 2023', 'DD MONTH YYYY')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('15-DEC-2023', 'DD-MON-YYYY')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('15-Jan-2023', 'DD-Mon-YYYY')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('15-jAnUaRy-2023', 'DD-MONTH-YYYY')::string

-- sqlfmt-corpus-separator --

SELECT to_date('2,023 03 15', 'Y,YYY MM DD')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('2023  03  15', 'YYYY MM DD')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('2023 001', 'YYYY DDD')::string

-- sqlfmt-corpus-separator --

SELECT to_date('2023 03 15', 'YYYY MM DD')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('2023 074', 'YYYY DDD')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('2023 11 3', 'IYYY IW ID')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('2023 365', 'YYYY DDD')::string

-- sqlfmt-corpus-separator --

SELECT to_date('2023 I 01', 'YYYY RM DD')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('2023 III 15', 'YYYY RM DD')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('2023 IX 01', 'YYYY RM DD')::string

-- sqlfmt-corpus-separator --

SELECT to_date('2023 XII 25', 'YYYY RM DD')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('2023 iv 15', 'YYYY RM DD')::string

-- sqlfmt-corpus-separator --

SELECT to_date('2023', 'YYYY')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('2023-03-15', 'FXYYYY-MM-DD')::string

-- sqlfmt-corpus-separator --

SELECT to_date('2023-03-15', 'YYYY-MM-DD')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('2023-03-15', 'yyyy-mm-dd')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('20230315', 'YYYYMMDD')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('2024 01 1', 'YYYY MM W')::string

-- sqlfmt-corpus-separator --

SELECT to_date('2024 01', 'YYYY WW')::string

-- sqlfmt-corpus-separator --

SELECT to_date('2024 03 3', 'YYYY MM W')::string

-- sqlfmt-corpus-separator --

SELECT to_date('2024 06 4', 'YYYY MM W')::string

-- sqlfmt-corpus-separator --

SELECT to_date('2024 060', 'YYYY DDD')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('2024 10', 'YYYY WW')::string

-- sqlfmt-corpus-separator --

SELECT to_date('2024 366', 'YYYY DDD')::string

-- sqlfmt-corpus-separator --

SELECT to_date('2024 52', 'YYYY WW')::string

-- sqlfmt-corpus-separator --

SELECT to_date('202400-DD.3', 'FMIYYYHH24-"DD".W')::text

-- sqlfmt-corpus-separator --

SELECT to_date('21 23', 'CC YY')::string

-- sqlfmt-corpus-separator --

SELECT to_date('21', 'CC')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('2115-2460477', 'FMCCDD-J')::text

-- sqlfmt-corpus-separator --

SELECT to_date('23 03 15', 'YY MM DD')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('23-06-01', 'YY-MM-DD')::string

-- sqlfmt-corpus-separator --

SELECT to_date('2460019', 'J')::string;

-- sqlfmt-corpus-separator --

SELECT to_date('99-03-15', 'YY-MM-DD')::string

-- sqlfmt-corpus-separator --

SELECT to_date('Mon 2023-03-20', 'DY YYYY-MM-DD')::string

-- sqlfmt-corpus-separator --

SELECT to_date('Monday 2023-03-20', 'DAY YYYY-MM-DD')::string

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

SELECT to_json('hello'::greeting)

-- sqlfmt-corpus-separator --

SELECT to_json(1.234::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT to_json(false::BOOL)

-- sqlfmt-corpus-separator --

SELECT to_json(true::BOOL)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('"a"'::JSON)

-- sqlfmt-corpus-separator --

SELECT to_jsonb('00:00:00'::TIME)

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

SELECT to_jsonb('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'::UUID);

-- sqlfmt-corpus-separator --

SELECT to_jsonb(1.234::DECIMAL)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(false::BOOL)

-- sqlfmt-corpus-separator --

SELECT to_jsonb(true::BOOL)

-- sqlfmt-corpus-separator --

SELECT to_number('0', '9V')::text

-- sqlfmt-corpus-separator --

SELECT to_number('0', 'V9')::text

-- sqlfmt-corpus-separator --

SELECT to_number('0', 'V99')::text

-- sqlfmt-corpus-separator --

SELECT to_number('12', '9V9')::text

-- sqlfmt-corpus-separator --

SELECT to_number('123', '9V99')::numeric(10,2)::text

-- sqlfmt-corpus-separator --

SELECT to_number('12345', '999V99')::numeric(10,2)::text

-- sqlfmt-corpus-separator --

SELECT to_number('5', 'V9')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('00 20113', 'FF2 FMYYYDD')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('00', 'SS')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('00-0900 TUE.0', 'MI-IWMI DY.FF1')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('000-AD', 'MS-BC')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('000.FF6.ADTHURSDAY -970', 'MS."FF6".ADDAY-YYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('0000', 'FF2FF2')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('000000', 'FF3FF3')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('000000', 'FF4FF2')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('00000000-00000', 'FMFF6SS-FF5')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('0000000000', 'FF5FF5')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('000000000000', 'FMUSUS')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('0000001970', 'FMFF6IYYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('0000002 AD', 'FMFF6Y FMBC')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('000000DECEMBER -WED:08/342', 'FF6MONTH-DY:DD/DDD')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('000000JANUARY  -MON.53', 'USMONTH-DY.YY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('0000034', 'FMFF5WW')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('000525161-2', 'MSFMCCIYYY-D')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('00:I   -AD', 'FF2:RM-AD')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('012:0/4', 'FMMIHH24:FF1/Q')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('02 29', 'MM DD')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('03:VIII-216', 'HH24:RM-FMCCFF1')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('06', 'MM')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('06419JUN.064', 'FMFF3MIMON.MS')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('1,970-1,9701', 'Y,YYY-Y,YYYW')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('100-00000', 'FMQHH24-FF2FF3')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('1011', 'HHFF2')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('11', 'HH12')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('11.THURSDAY -SEPTEMBER', 'YY.DAY-MONTH')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('12 12', 'HH HH24')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('12', 'HH12')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('1212', 'HH12HH24')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('1212', 'HHHH12')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('12440588', 'FMIWJ')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('12MONDAY    TH JAN', 'HH12DAY TH MON')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('13', 'HH12')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('130FF11302', 'FF3"FF1"MSW')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('13500/135', 'FF5/MS')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('1378', 'FF1MS')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('15 0822', 'WW YYYY')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('154.AD4', 'FMYYQ.ADQ')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('16231623', 'YYYYYYYY')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('180', 'FMIWFF1')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('19203', 'FMIYYYQ')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('197000', 'FMIYYYHH24')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2,00852', 'Y,YYYFF2')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2,0102455280', 'Y,YYYJ')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2,0242', 'Y,YYYQ')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2,024:2024', 'Y,YYY:YYYY')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2-AD:3 2024', 'Q-BC:FMW YYYY')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('200623276', 'YYYYFF5')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2012MONNOVEMBER -08', 'YYYY"MON"MONTH-HH12')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023', 'YYYY')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-01-01 12:00:00 AM', 'YYYY-MM-DD HH12:MI:SS AM')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-01-01 12:00:00 PM', 'YYYY-MM-DD HH12:MI:SS AM')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03 14:30:45.1-15', 'YYYY-MM HH24:MI:SS.MS-DD')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 0', 'YYYY-MM-DD SSSS')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 02:30:45 AM', 'YYYY-MM-DD HH12:MI:SS AM')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 02:30:45 PM', 'YYYY-MM-DD HH12:MI:SS AM')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45 +00:00', 'YYYY-MM-DD HH24:MI:SS TZH:TZM')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45 +05:30', 'YYYY-MM-DD HH24:MI:SS TZH:TZM')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45 -08:00', 'YYYY-MM-DD HH24:MI:SS TZH:TZM')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45', 'YYYY-MM-DD HH24:MI:SS')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45', 'yyyy-mm-dd hh24:mi:ss')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45.1', 'YYYY-MM-DD HH24:MI:SS.FF1')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45.12', 'YYYY-MM-DD HH24:MI:SS.FF2')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45.123', 'YYYY-MM-DD HH24:MI:SS.FF3')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45.123', 'YYYY-MM-DD HH24:MI:SS.MS')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45.1234', 'YYYY-MM-DD HH24:MI:SS.FF4')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45.12345', 'YYYY-MM-DD HH24:MI:SS.FF5')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45.123456', 'YYYY-MM-DD HH24:MI:SS.FF6')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45.123456', 'YYYY-MM-DD HH24:MI:SS.US')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45.999', 'YYYY-MM-DD HH24:MI:SS.MS')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 14:30:45.999999', 'YYYY-MM-DD HH24:MI:SS.US')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 52245', 'YYYY-MM-DD SSSS')::string;

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2023-03-15 86399', 'YYYY-MM-DD SSSS')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('20232024', 'YYYYYYYY')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2024024', 'YYYYYYY')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('202424', 'FMYYYYIY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2108', 'FMCCYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('216093', 'CCFF4')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('21:424', 'FMCC:FMYIY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('21AUGUST   .HH12D.44', 'CCMONTH."HH12""D".SS')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('238', 'FMDIW')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('24', 'WW')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2401', 'FMYYYHH')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2440588000', 'JFF3')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('244058801', 'JDD')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('2440588112', 'JFMWWHH12')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('24528607331', 'JFF4')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('245328205208', 'JFF5')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('24604773', 'JW')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('25 MONDAY   AUGUST   -33', 'YY DAYMONTH-WW')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('28 4', 'CC Y')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('3-292121AUG', 'Q-FMYYYYYYMON')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('3/DECEMBER ', 'W/MONTH')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('313106', 'FF2FF2HH')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('32756364256', 'JIYYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('35642425046', 'JYYYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('3783', 'MSFF1')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('39 02395', 'FF2 HHMS')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('3AUGUST    DDD-AUGUST    06', 'QMONTH "DDD"-MONTH CC')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('4 5.APRIL    .TH/04', 'W D.MONTH.TH/HH24')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('4.425JUN', 'FF1.MSMON')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('4154000', 'YFF6')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('4422', 'FMFF1FF3')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('465-4', 'MS-FF1')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('49 06 12:12.00', 'WW DD HH:MM.FF2')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('49491', 'FF2MS')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('4TH 508', 'QTH YYY')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('53:30200-JUNE     -SAT', 'SS:FF5-MONTH-DY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('584001-58', 'SSFMQYYY-SS')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('59590', 'FF2MS')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('633.6', 'MS.FF1')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('70-2440588000000', 'YY-JFF6')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('7017-000 12', 'FMYDDD-FF3 HH12')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('72-3-2460389-FF1', 'FF2-W-J-"FF1"')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('8498', 'MSFF1')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('912:00', 'FMYHH24:FF2')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('AD AD', 'AD BC')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('AD/42', 'BC/FMDQ')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('AD24405881970', 'ADJYYYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('ADSATURDAY -12:1,309', 'BCDAY-HH24:Y,YYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('ADVI  ', 'ADRM')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('APRIL    -2612', 'MONTH-DDHH24')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('AUGUST   -05-11.AD', 'MONTH-HH-MI.BC')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('DECEMBER -02 4323', 'MONTH-YY QMS')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('DECEMBER FF6 0000', 'MONTH"FF6" FF4')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('DECEMBER MONTH12', 'MONTH"MONTH"HH24')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('FEBFEBRUARY .02.12', 'MONMONTH.MM.HH12')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('FRIDAY   6214920144', 'DAYFF5FMYYYYQ')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('I   -0,210J', 'RM-Y,YYY"J"')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('I   -01:JAN', 'RM-DD:MON')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('I   -12', 'RM-HH24')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('I   MM1', 'RM"MM"Q')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('II  -FEB', 'RM-MON')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('II  MI4', 'RM"MI"W')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('IV  -85272006', 'RM-FF4YYYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('IX  -6', 'RM-FF1')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('J1XI  -AD', '"J"WRM-BC')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JANUARY  -0', 'MONTH-Y')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JANUARY  HH12:24', 'MONTH"HH12":YY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JULY     BC4820', 'MONTH"BC"YYYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JUNE     -0/0000', 'MONTH-FF1/FF4')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JUNE     -024.AD', 'MONTH-YYY.AD')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JUNE     -07:221', 'MONTH-HH24:QCC')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JUNE     -2,024 15', 'MONTH-Y,YYY DD')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JUNE     -792000', 'MONTH-US')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JUNE     -JUNE     ', 'MONTH-MONTH')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JUNE     -VI  ', 'MONTH-RM')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JUNE     .TH.167:9850', 'MONTH.TH.DDD:FF4')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JUNE     :SS:39', 'MONTH:"SS":FF2')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JUNE     :YYY.604', 'MONTH:"YYY".MS')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JUNE     MM37', 'MONTH"MM"FF2')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('JUNE     SATURDAY .TH8190', 'MONTHDAY.THFF4')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('MARCH    -SUN030:AD 43', 'MONTH-DYFF3:AD SS')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('MONDAY   -0,086', 'DAY-Y,YYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('MONDAY   -MAR1', 'DAY-MONQ')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('MONDAY   01000012', 'DAYMMFMFF4HH24')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('MONDAYHH24021', 'DAY"HH24"YYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('NOVEMBER -1200:12', 'MONTH-HHSS:HH12')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('OCTOBER  -6024', 'MONTH-YYYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('OCTOBER  -SATURDAY 12594', 'MONTH-DAYHH24YYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('OCTOBER  SS.12/00-50', 'MONTH"SS".HH24/MI-YY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SAT 7', 'DY D')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SATURDAY -01', 'DAY-HH24')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SATURDAY -2024', 'DAY-IYYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SATURDAY -21-2', 'DAY-CC-Q')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SATURDAY -AD:844000', 'DAY-AD:FF6')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SATURDAY -ADRM:12HH', 'DAY-AD"RM":HH24"HH"')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SATURDAY -JULY     ', 'DAY-MONTH')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SATURDAY .SS24', 'DAY."SS"IW')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SATURDAY /DD24', 'DAY/"DD"WW')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SATURDAY HH24021', 'DAY"HH24"YYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SATURDAY HH24521', 'DAY"HH24"YYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SATURDAY MI:4', 'DAY"MI":Y')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SEP', 'MON')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SUNDAY   -08', 'DAY-IW')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SUNDAY   -1,378', 'DAY-Y,YYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('SUNDAY   -10', 'DAY-HH')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('TH', 'TH')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('THURSDAY -1970', 'DAY-IYYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('THURSDAY -55202415612', 'DAY-SSYYYYMSHH')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('THURSDAY /YYY01', 'DAY/"YYY"WW')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('THURSDAY 244058801', 'DAYJDD')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('THURSDAY Q:70J', 'DAY"Q":YY"J"')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('TUESDAY  -DEC:AD', 'DAY-MON:AD')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('VI  -00', 'RM-FF2')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('VI  -15', 'RM-HH24')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('VI  -2', 'RM-Q')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('VI  -2', 'RM-W')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('VI  -2,024', 'RM-Y,YYY')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('VI  CC 06', 'RM"CC" MM')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('VII CC 9', 'RM"CC" FF1')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('VIII:08AUG', 'RM:YYMON')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('WEDNESDAY-FEBRUARY /FEB WED', 'DAY-MONTH/MON DY')::string

-- sqlfmt-corpus-separator --

SELECT to_timestamp('XI  -NOVEMBER ', 'RM-MONTH')::text

-- sqlfmt-corpus-separator --

SELECT to_timestamp('YYYYIX  -AD', '"YYYY"RM-AD')::text

-- sqlfmt-corpus-separator --

SELECT to_uuid('63616665-6630-3064-6465-616462656566'),
       to_uuid('{63616665-6630-3064-6465-616462656566}'),
       to_uuid('urn:uuid:63616665-6630-3064-6465-616462656566'),
       from_uuid(b'cafef00ddeadbeef'),
       to_uuid(from_uuid(b'cafef00ddeadbeef')),
       from_uuid(to_uuid('63616665-6630-3064-6465-616462656566'))

-- sqlfmt-corpus-separator --

SELECT token FROM u WHERE token='63616665-6630-3064-6465-616462656562'::string

-- sqlfmt-corpus-separator --

SELECT token FROM u WHERE token='63616665-6630-3064-6465-616462656562'::uuid

-- sqlfmt-corpus-separator --

SELECT token FROM u WHERE token=b'cafef00ddeadbeef'

-- sqlfmt-corpus-separator --

SELECT token FROM u WHERE token=b'cafef00ddeadbeef'::bytes

-- sqlfmt-corpus-separator --

SELECT token::bytes FROM u WHERE token=b'cafef00ddeadbeef'

-- sqlfmt-corpus-separator --

SELECT token::string FROM u WHERE token=b'cafef00ddeadbeef'

-- sqlfmt-corpus-separator --

SELECT token::uuid FROM u WHERE token=b'cafef00ddeadbeef'

-- sqlfmt-corpus-separator --

SELECT trim_scale('NaN'::decimal), trim_scale('Infinity'::decimal)

-- sqlfmt-corpus-separator --

SELECT true FROM x WHERE j->'a' @> '2'::JSONB

-- sqlfmt-corpus-separator --

SELECT trunc(-0.0), trunc(0.0), trunc(1.9), trunc(19.5678::decimal)

-- sqlfmt-corpus-separator --

SELECT typname from pg_type where oid='"typQuotedCase"'::regtype

-- sqlfmt-corpus-separator --

SELECT typname from pg_type where oid='typ'::regtype

-- sqlfmt-corpus-separator --

SELECT typname from pg_type where oid='typHasCase'::regtype

-- sqlfmt-corpus-separator --

SELECT typname from pg_type where oid='typQuotedCase'::regtype

-- sqlfmt-corpus-separator --

SELECT typname, typrelid FROM pg_catalog.pg_type WHERE typrelid = 'u'::regtype::oid;

-- sqlfmt-corpus-separator --

SELECT typname, typrelid, typarray FROM pg_catalog.pg_type WHERE oid = 'u[]'::regtype::oid;

-- sqlfmt-corpus-separator --

SELECT u.key, t.str FROM t, u WHERE t.k = u.key AND u.val LIKE 't%'

-- sqlfmt-corpus-separator --

SELECT upper(s), count(DISTINCT k), count(DISTINCT v), count(DISTINCT (v)) FROM kv GROUP BY upper(s)

-- sqlfmt-corpus-separator --

SELECT upper(s), count(DISTINCT s), count(DISTINCT upper(s)) FROM kv GROUP BY upper(s) HAVING count(DISTINCT s) > 1

-- sqlfmt-corpus-separator --

SELECT usage_count, feature_name
  FROM crdb_internal.feature_usage
 WHERE feature_name LIKE 'auditing.%abled'
ORDER BY 2,1

-- sqlfmt-corpus-separator --

SELECT user_name FROM crdb_internal.node_sessions
WHERE active_queries LIKE 'SELECT user_name%'

-- sqlfmt-corpus-separator --

SELECT username, substr("hashedPassword", 1, 7), 'CRDB-BCRYPT'||"hashedPassword" = '$bcrypt_pw' FROM system.users WHERE username LIKE 'hash%' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT v @@ 'foo <2> bar'::tsquery, v @@ 'foo <-> bar'::tsquery FROM a

-- sqlfmt-corpus-separator --

SELECT var_pop('inf'::numeric), var_samp('inf'::numeric)

-- sqlfmt-corpus-separator --

SELECT var_pop(v::INT8) OVER ()
FROM t91817b
GROUP BY k, v
HAVING every(true)

-- sqlfmt-corpus-separator --

SELECT var_pop(x), var_pop(y::decimal), round(var_pop(z), 14) FROM xyz

-- sqlfmt-corpus-separator --

SELECT var_samp(x), variance(y::decimal), round(var_samp(z), 14) FROM xyz

-- sqlfmt-corpus-separator --

SELECT width_bucket('-Infinity'::numeric, 1, 10, 10);

-- sqlfmt-corpus-separator --

SELECT width_bucket('Infinity'::numeric, 1, 10, 10);

-- sqlfmt-corpus-separator --

SELECT width_bucket(true, '{}'::BOOL[]);

-- sqlfmt-corpus-separator --

SELECT with_max_staleness('10s') = statement_timestamp() - '10s'::interval

-- sqlfmt-corpus-separator --

SELECT with_min_timestamp(statement_timestamp() + '5s'::interval) = statement_timestamp()

-- sqlfmt-corpus-separator --

SELECT with_min_timestamp(statement_timestamp() - '5s'::interval) = statement_timestamp() - '5s'::interval

-- sqlfmt-corpus-separator --

SELECT x,
       sqrdiff(x) OVER (ORDER BY x) as sqrdiff,
       var_pop(x) OVER (ORDER BY x) as var_pop,
       var_samp(x) OVER (ORDER BY x) as var_samp,
       stddev_pop(x) OVER (ORDER BY x) as stddev_pop,
       stddev_samp(x) OVER (ORDER BY x) as stddev_samp
FROM t55944
ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x, x LIKE '%', x NOT LIKE '%', x LIKE 'ab%', x NOT LIKE 'ab%', x LIKE '%bc', x NOT LIKE '%bc', x LIKE '%b%', x NOT LIKE '%b%', x LIKE 'a%c', x NOT LIKE 'a%c' FROM e ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x, y FROM xy ORDER BY x NULLS FIRST, y DESC

-- sqlfmt-corpus-separator --

SELECT x, y FROM xy ORDER BY x NULLS FIRST, y DESC NULLS FIRST

-- sqlfmt-corpus-separator --

SELECT x, y FROM xy ORDER BY x NULLS FIRST, y DESC NULLS LAST

-- sqlfmt-corpus-separator --

SELECT x, y FROM xy ORDER BY x NULLS FIRST, y NULLS LAST

-- sqlfmt-corpus-separator --

SELECT x, y FROM xy ORDER BY x NULLS LAST, y DESC NULLS FIRST

-- sqlfmt-corpus-separator --

SELECT x, y FROM xy ORDER BY x, y DESC NULLS FIRST

-- sqlfmt-corpus-separator --

SELECT x, y FROM xy ORDER BY y DESC NULLS FIRST

-- sqlfmt-corpus-separator --

SELECT x, y FROM xy ORDER BY y DESC NULLS LAST

-- sqlfmt-corpus-separator --

SELECT x, y FROM xy ORDER BY y NULLS FIRST

-- sqlfmt-corpus-separator --

SELECT x, y FROM xy ORDER BY y NULLS LAST

-- sqlfmt-corpus-separator --

SELECT |/ -1.0::decimal

-- sqlfmt-corpus-separator --

SELECT ~B'0';

-- sqlfmt-corpus-separator --

SELECT ~B'1';

-- sqlfmt-corpus-separator --

SELECT ~B'2';

-- sqlfmt-corpus-separator --

select '11:00:00-07:00'::TIMETZ::TIME;

-- sqlfmt-corpus-separator --

select '11:00:00-07:00'::TIMETZ::TIMETZ;

-- sqlfmt-corpus-separator --

select '12:00:00-07:00'::TIMETZ::STRING;

-- sqlfmt-corpus-separator --

select '2019-01-01 00:00:00'::timestamp = '2019-01-01'::date

-- sqlfmt-corpus-separator --

select '2019-01-01 00:00:00+00'::timestamptz < '2019-01-01'::date

-- sqlfmt-corpus-separator --

select '2019-01-01'::date = '2019-01-01 00:00:00'::timestamp

-- sqlfmt-corpus-separator --

select '2019-01-01'::date = '2019-01-01'::date

-- sqlfmt-corpus-separator --

select '2019-01-01'::date > '2019-01-01 00:00:00+00'::timestamptz

-- sqlfmt-corpus-separator --

select 'I1', ST_AsMVTGeom(NULL::geometry, ST_MakeEnvelope(10, 10, 20, 20)::box2d, 4096);

-- sqlfmt-corpus-separator --

select 'I2', ST_AsMVTGeom(ST_Point(1, 2), NULL::box2d, 4096);

-- sqlfmt-corpus-separator --

select '[3,-Inf]'::vector

-- sqlfmt-corpus-separator --

select '[3,1]'::vector(1)

-- sqlfmt-corpus-separator --

select '[3,Inf]'::vector

-- sqlfmt-corpus-separator --

select '[3,NaN]'::vector

-- sqlfmt-corpus-separator --

select ('1 hour'::interval + '2019-01-15'::date), pg_typeof('1 hour'::interval + '2019-01-15'::date)

-- sqlfmt-corpus-separator --

select ('16:17:18'::time + '2019-01-15'::date), pg_typeof(('16:17:18'::time + '2019-01-15'::date))

-- sqlfmt-corpus-separator --

select ('2019-01-15'::date + '1 hour'::interval), pg_typeof('2019-01-15'::date + '1 hour'::interval)

-- sqlfmt-corpus-separator --

select ('2019-01-15'::date + '16:17:18'::time), pg_typeof('2019-01-15'::date + '16:17:18'::time)

-- sqlfmt-corpus-separator --

select ('2019-01-15'::date - '1 hour'::interval), pg_typeof('2019-01-15'::date - '1 hour'::interval)

-- sqlfmt-corpus-separator --

select ('2019-01-15'::date - '16:17:18'::time), pg_typeof('2019-01-15'::date - '16:17:18'::time)

-- sqlfmt-corpus-separator --

select ('24:00'::TIME)::STRING

-- sqlfmt-corpus-separator --

select * from current_timestamp_test WHERE a - interval '3h' <> b

-- sqlfmt-corpus-separator --

select 1 < 2.0::decimal, 1.0::decimal < 2, 2.0::decimal < 1, 2 < 1.0::decimal

-- sqlfmt-corpus-separator --

select 1 <= 1.0::decimal, 1.0::decimal <= 1, 2.0::decimal <= 1, 2 <= 1.0::decimal

-- sqlfmt-corpus-separator --

select 1 = 1.0::decimal, 1.0::decimal = 1, 1 = 2.0::decimal, 2.0::decimal = 1

-- sqlfmt-corpus-separator --

select 1 >= 1.0::decimal, 1.0::decimal >= 1, 1.0::decimal >= 2, 1 >= 2.0::decimal

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

select 2::decimal > 1.0, 2.0 > 1::decimal, 1::decimal > 2.0, 1.0 > 2::decimal

-- sqlfmt-corpus-separator --

select adnum from pg_attrdef WHERE adrelid = 't46799'::REGCLASS

-- sqlfmt-corpus-separator --

select age('2017-12-10'::timestamptz, '2017-12-01'::timestamptz)

-- sqlfmt-corpus-separator --

select count(1) from date_test where '2019-01-15 00:00:00'::timestamp = date_test.date_val

-- sqlfmt-corpus-separator --

select count(1) from date_test where '2019-01-15 00:00:00+00'::timestamptz < date_test.date_val

-- sqlfmt-corpus-separator --

select count(1) from date_test where '2019-01-15 00:00:00+00'::timestamptz > date_test.date_val

-- sqlfmt-corpus-separator --

select count(1) from date_test where date_test.date_val < '2019-01-15 00:00:00+00'::timestamptz

-- sqlfmt-corpus-separator --

select count(1) from date_test where date_test.date_val = '2019-01-15 00:00:00'::timestamp

-- sqlfmt-corpus-separator --

select count(1) from date_test where date_test.date_val = '2019-01-15'::date

-- sqlfmt-corpus-separator --

select count(1) from date_test where date_test.date_val > '2019-01-15 00:00:00+00'::timestamptz

-- sqlfmt-corpus-separator --

select crdb_internal.force_retry(interval '0s')

-- sqlfmt-corpus-separator --

select crdb_internal.job_payload_type('invalid'::BYTES);

-- sqlfmt-corpus-separator --

select crdb_internal.protect_mvcc_history(1709131929793796000.0000000000, '10ms'::interval, 'molt fetch');

-- sqlfmt-corpus-separator --

select crdb_internal.protect_mvcc_history(1709131929793796000.0000000000, '24 hours'::interval, 'molt fetch');

-- sqlfmt-corpus-separator --

select crdb_internal.sql_liveness_is_alive(x'1f915e98f96145a5baa9f3a42c378eb6');

-- sqlfmt-corpus-separator --

select crdb_internal.sql_liveness_is_alive(x'deadbeef');

-- sqlfmt-corpus-separator --

select date_trunc('day', '2011-01-01 22:30:00'::date)

-- sqlfmt-corpus-separator --

select date_trunc('day', '2011-01-01 22:30:00'::date);

-- sqlfmt-corpus-separator --

select date_trunc('day', '2011-01-01 22:30:00+01:00'::timestamptz)

-- sqlfmt-corpus-separator --

select date_trunc('day', '2011-01-01 22:30:00+01:00'::timestamptz);

-- sqlfmt-corpus-separator --

select date_trunc('day', '2011-01-02 01:30:00'::date), pg_typeof(date_trunc('day', '2011-01-02 01:30:00'::date))

-- sqlfmt-corpus-separator --

select date_trunc('day', '2011-01-02 01:30:00'::timestamp)

-- sqlfmt-corpus-separator --

select date_trunc('day', '2011-01-02 01:30:00'::timestamp), pg_typeof(date_trunc('day', '2011-01-02 01:30:00'::timestamp))

-- sqlfmt-corpus-separator --

select date_trunc('day', '2011-01-02 01:30:00+00:00'::timestamptz), pg_typeof(date_trunc('day', '2011-01-02 01:30:00+00:00'::timestamptz))

-- sqlfmt-corpus-separator --

select exp('nan'::numeric), exp('inf'::numeric), exp('-inf'::numeric)

-- sqlfmt-corpus-separator --

select format_type('pg_namespace'::regtype, null);

-- sqlfmt-corpus-separator --

select generate_series('2020-10-25 00:00'::TIMESTAMPTZ, '2020-10-25 23:00'::TIMESTAMPTZ, '1 hour');

-- sqlfmt-corpus-separator --

select generate_series('2021-07-05'::timestamptz, '2021-07-06'::timestamptz, '1day'::interval)

-- sqlfmt-corpus-separator --

select ln(4.0786335175292462e+34::decimal)

-- sqlfmt-corpus-separator --

select st_astext(st_linesubstring('LINESTRING(0 0, 0 5, 5 5,10 3)'::geometry,0,1.4));

-- sqlfmt-corpus-separator --

select st_astext(st_linesubstring('LINESTRING(0 0, 0 5, 5 5,10 3)'::geometry,0.5,0.4))

-- sqlfmt-corpus-separator --

select st_astext(st_linesubstring('POINT(0 0)'::geometry,0.5,0.4));

-- sqlfmt-corpus-separator --

select st_linemerge('01020000C003000000000000000000F0FF000000000000F8FF60DB272315DEBAC13CDE36003499DEC1000000000000F0FF000000000000F8FF9CDB5D9AA401E1C1D0C80253A5F1C4C1000000000000F0FF000000000000F8FF003E39CD6CDDD2C1A6909F31D737F4C1'::geometry);

-- sqlfmt-corpus-separator --

select to_hex(-2147483649), to_hex(-2147483648::int8), to_hex(-1::int8), to_hex(0), to_hex(1), to_hex(2147483647), to_hex(2147483648)

-- sqlfmt-corpus-separator --

select to_hex(E'\\047\\134'::bytea)