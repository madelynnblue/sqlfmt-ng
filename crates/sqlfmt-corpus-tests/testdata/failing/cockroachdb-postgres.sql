CREATE TABLE "Table-Name" (id INT PRIMARY KEY) WITH (ttl_expire_after = '10 hours')

-- sqlfmt-corpus-separator --

CREATE TABLE T_TTL_W_DEFAULT (C1 INT PRIMARY KEY) WITH (ttl_expire_after='10 minutes');

-- sqlfmt-corpus-separator --

CREATE TABLE a (b INT) WITH (autovacuum_enabled='11')

-- sqlfmt-corpus-separator --

CREATE TABLE alter_column_crdb_internal_expiration() WITH (ttl_expire_after='10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE alter_column_crdb_internal_expiration_rename() WITH (ttl_expire_after='10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE alter_table_crdb_internal_expiration_incorrect_explicit_default() WITH (ttl_expire_after='10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE alter_table_crdb_internal_expiration_incorrect_explicit_on_update() WITH (ttl_expire_after='10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE boundedtable (b INT[10], c INT ARRAY[10])

-- sqlfmt-corpus-separator --

CREATE TABLE crdb_internal_functions_tbl (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE create_table_ttl_expire_after_and_ttl_expiration_expression (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes', ttl_expiration_expression = 'crdb_internal_expiration')

-- sqlfmt-corpus-separator --

CREATE TABLE drop_column_crdb_internal_expiration() WITH (ttl_expire_after='10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE nocase_strings (s STRING COLLATE "en-US-u-ks-le""vel2");

-- sqlfmt-corpus-separator --

CREATE TABLE t (a INT PRIMARY KEY, b INT) WITH (sql_stats_canary_window = '15s')

-- sqlfmt-corpus-separator --

CREATE TABLE t4 (
  a INT, b INT DEFAULT 5, c INT, d INT,
  CHECK (a < b),
  CONSTRAINT "all" CHECK (a+b+c+d < 20),
  FAMILY f1 (a, b, c, d)
)

-- sqlfmt-corpus-separator --

CREATE TABLE t54989(
  no_collation_str text,
  no_collation_str_array text[],
  collated_str text COLLATE en,
  default_collation text COLLATE "default"
)

-- sqlfmt-corpus-separator --

CREATE TABLE t_bad_param (
  a INT PRIMARY KEY WITH (bucket_count=5)
);

-- sqlfmt-corpus-separator --

CREATE TABLE t_bad_param (
  a INT PRIMARY KEY WITH (s2_max_level=20)
);

-- sqlfmt-corpus-separator --

CREATE TABLE t_notice (a INT PRIMARY KEY) WITH (sql_stats_canary_window = '15s')

-- sqlfmt-corpus-separator --

CREATE TABLE t_pk_inline (a INT PRIMARY KEY WITH (skip_unique_checks = true))

-- sqlfmt-corpus-separator --

CREATE TABLE t_ttl_w_expire_at (c1 int, expire_at TIMESTAMPTZ) WITH (ttl_expiration_expression = 'expire_at');

-- sqlfmt-corpus-separator --

CREATE TABLE t_unique_column (
  a INT PRIMARY KEY,
  b INT UNIQUE WITH (skip_unique_checks = true)
)

-- sqlfmt-corpus-separator --

CREATE TABLE tbl (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl (
  id INT PRIMARY KEY,
  crdb_internal_expiration INTERVAL
) WITH (ttl_expire_after = '10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl (
  id INT PRIMARY KEY,
  crdb_internal_expiration TIMESTAMPTZ
) WITH (ttl_expire_after = '10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl () WITH (ttl_expire_after = '10 seconds', ttl_job_cron = 'bad expr')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl (id INT PRIMARY KEY) WITH (ttl_expiration_expression = '; DROP DATABASE defaultdb')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl (id INT PRIMARY KEY) WITH (ttl_expiration_expression = 'id')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl (id INT PRIMARY KEY) WITH (ttl_expiration_expression = 'now(), now()')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl (id INT PRIMARY KEY) WITH (ttl_expire_after = ' xx invalid interval xx')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl (id INT PRIMARY KEY) WITH (ttl_expire_after = '-10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_create_ttl_job_cron (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes', ttl_job_cron = '@daily')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_drop_table (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_execute_schedule (
  id INT PRIMARY KEY,
  expire_at TIMESTAMPTZ NOT NULL DEFAULT now() - '1 day'
) WITH (ttl_expiration_expression = 'expire_at', ttl_job_cron = '@daily')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_execute_schedule_2 (
  id INT PRIMARY KEY,
  expire_at TIMESTAMPTZ NOT NULL DEFAULT now() - '1 day'
) WITH (ttl_expiration_expression = 'expire_at', ttl_job_cron = '@daily')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_existing_ttl_concurrent_schema_change (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes', schema_locked=false)

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_reloptions (
  id INT PRIMARY KEY
) WITH (
  ttl_expire_after = '10 minutes',
  ttl_select_batch_size = 10,
  ttl_delete_batch_size = 20,
  ttl_select_rate_limit = 30,
  ttl_delete_rate_limit = 40,
  ttl_pause = true,
  ttl_row_stats_poll_interval = '1 minute',
  ttl_label_metrics = true,
  ttl_disable_changefeed_replication = true
)

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_rename (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_rename_legacy_label (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_reset_ttl (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_reset_ttl_job_cron (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes', ttl_job_cron = '@daily')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_schedules (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_set_ttl_job_cron (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes', ttl_job_cron = '@daily')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_set_ttl_params (
  id INT PRIMARY KEY
) WITH (
  ttl_expire_after = '10 minutes',
  ttl_select_batch_size = 10,
  ttl_delete_batch_size = 20,
  ttl_select_rate_limit = 30,
  ttl_delete_rate_limit = 40,
  ttl_pause = true,
  ttl_row_stats_poll_interval = '1 minute',
  ttl_label_metrics = true,
  ttl_disable_changefeed_replication = true
)

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_ttl_expiration_expression_renamed (
  id INT PRIMARY KEY,
  expires_at TIMESTAMPTZ,
  FAMILY fam (id, expires_at)
) WITH (ttl_expiration_expression = 'expires_at')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_ttl_expiration_expression_volatility_stable (
  id INT PRIMARY KEY,
  expire_at timestamptz
) WITH (ttl_expiration_expression = $$expire_at + '10 minutes'$$)

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_ttl_on_noop (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_ttl_params_non_negative (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE ttl_expiration_expression_required(expire_at TIMESTAMPTZ) WITH (ttl_expiration_expression='expire_at')

-- sqlfmt-corpus-separator --

CREATE TABLE ttl_expire_after_required() WITH (ttl_expire_after='10 minutes')

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE a (a int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE a(a INT)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE a_temp(a INT PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE myschema.tmp (x int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE ref_temp_table (a SERIAL)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE regression_48233(a int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t(a INT)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t_102964 (i INT PRIMARY KEY);

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t_tmp(X int);

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE tbl (a int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temp1 (a int);

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temp2 (a int);

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temp_priv_t (a INT PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temp_priv_t2 (a INT PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temp_table_142780 (a int primary key, b int);

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temp_table_142783 (a int primary key);

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temp_table_ref (a timetz PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temp_table_test (a timetz PRIMARY KEY) ON COMMIT PRESERVE ROWS

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE tempy (a int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE tempy (a int);

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE test (a int);

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE test2 (a uuid);

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE users (userid INT PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE from_other_session(i INT PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE root_temp (i INT PRIMARY KEY);

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE t (i INT PRIMARY KEY);

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE t()

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE temp()

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE temp1()

-- sqlfmt-corpus-separator --

CREATE UNLOGGED TABLE unlogged_tbl (col int PRIMARY KEY)

-- sqlfmt-corpus-separator --

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

SELECT * FROM c WHERE (NULL::text NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id)) IS NOT NULL;

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

create temporary table tmp_table (id int primary key);