CREATE TABLE "Table-Name" (id INT PRIMARY KEY) WITH (ttl_expire_after = '10 hours')

-- sqlfmt-corpus-separator --

CREATE TABLE IF NOT EXISTS example (
  a INT UNIQUE,
  b INT REFERENCES example (a) ON DELETE CASCADE ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE T_TTL_W_DEFAULT (C1 INT PRIMARY KEY) WITH (ttl_expire_after='10 minutes');

-- sqlfmt-corpus-separator --

CREATE TABLE a (b INT) WITH (autovacuum_enabled='11')

-- sqlfmt-corpus-separator --

CREATE TABLE alter_column_crdb_internal_expiration() WITH (ttl_expire_after='10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE alter_column_crdb_internal_expiration_rename() WITH (ttl_expire_after='10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE alter_fk (p STRING PRIMARY KEY, j STRING REFERENCES test_fk_base (j) ON UPDATE CASCADE)

-- sqlfmt-corpus-separator --

CREATE TABLE alter_table_crdb_internal_expiration_incorrect_explicit_default() WITH (ttl_expire_after='10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE alter_table_crdb_internal_expiration_incorrect_explicit_on_update() WITH (ttl_expire_after='10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE assn_cast_c (c INT PRIMARY KEY, d DECIMAL(10, 0) DEFAULT 3.1 REFERENCES assn_cast_p(d) ON UPDATE SET DEFAULT);

-- sqlfmt-corpus-separator --

CREATE TABLE assn_cast_c (c INT PRIMARY KEY, d DECIMAL(10, 0) REFERENCES assn_cast_p(d) ON UPDATE CASCADE);

-- sqlfmt-corpus-separator --

CREATE TABLE assn_cast_c (c INT PRIMARY KEY, p DECIMAL(10, 0) DEFAULT 3.1 REFERENCES assn_cast_p(p) ON UPDATE SET DEFAULT);

-- sqlfmt-corpus-separator --

CREATE TABLE assn_cast_c (c INT PRIMARY KEY, p DECIMAL(10, 0) REFERENCES assn_cast_p(p) ON UPDATE CASCADE);

-- sqlfmt-corpus-separator --

CREATE TABLE b (
  delete_no_action INT NOT NULL REFERENCES a ON DELETE NO ACTION
 ,update_no_action INT NOT NULL REFERENCES a ON UPDATE NO ACTION
 ,delete_restrict INT NOT NULL REFERENCES a ON DELETE RESTRICT
 ,update_restrict INT NOT NULL REFERENCES a ON UPDATE RESTRICT
 ,delete_cascade INT NOT NULL REFERENCES a ON DELETE CASCADE
 ,update_cascade INT NOT NULL REFERENCES a ON UPDATE CASCADE
 ,delete_null INT REFERENCES a ON DELETE SET NULL
 ,update_null INT REFERENCES a ON UPDATE SET NULL
 ,delete_default INT DEFAULT 109 REFERENCES a ON DELETE SET DEFAULT
 ,update_default INT DEFAULT 110 REFERENCES a ON UPDATE SET DEFAULT
);

-- sqlfmt-corpus-separator --

CREATE TABLE b (
  id STRING PRIMARY KEY
 ,a_id STRING REFERENCES a ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE b (
  id STRING PRIMARY KEY REFERENCES a ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE b1 (
  id STRING PRIMARY KEY
 ,delete_cascade STRING NOT NULL REFERENCES a ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE b1 (
  id STRING PRIMARY KEY
 ,update_cascade STRING NOT NULL UNIQUE REFERENCES a ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE b1 (
  id STRING PRIMARY KEY REFERENCES a ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE b1 (
  id STRING PRIMARY KEY REFERENCES a ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE b2 (
  id STRING PRIMARY KEY
 ,delete_cascade STRING NOT NULL REFERENCES a ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE b2 (
  id STRING PRIMARY KEY
 ,update_cascade STRING NOT NULL UNIQUE REFERENCES a ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE b2 (
  id STRING PRIMARY KEY REFERENCES a ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE b2 (
  id STRING PRIMARY KEY REFERENCES a ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE boundedtable (b INT[10], c INT ARRAY[10])

-- sqlfmt-corpus-separator --

CREATE TABLE c (
  id STRING PRIMARY KEY
 ,a_id STRING REFERENCES a ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE c (
  id STRING PRIMARY KEY REFERENCES a ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE c1 (
  id STRING PRIMARY KEY
 ,delete_cascade STRING NOT NULL REFERENCES b1 ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE c1 (
  id STRING PRIMARY KEY
 ,update_cascade STRING NOT NULL REFERENCES b1 (update_cascade) ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE c1 (
  id STRING PRIMARY KEY REFERENCES b1 ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE c1 (
  id STRING PRIMARY KEY REFERENCES b1 ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE c2 (
  id STRING PRIMARY KEY
 ,delete_cascade STRING NOT NULL REFERENCES b1 ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE c2 (
  id STRING PRIMARY KEY
 ,update_cascade STRING NOT NULL REFERENCES b1 (update_cascade) ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE c2 (
  id STRING PRIMARY KEY
 ,update_cascade STRING NOT NULL UNIQUE REFERENCES b1 (update_cascade) ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE c2 (
  id STRING PRIMARY KEY REFERENCES b1 ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE c2 (
  id STRING PRIMARY KEY REFERENCES b1 ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE c3 (
  id STRING PRIMARY KEY REFERENCES b2 ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE c3 (
  id STRING PRIMARY KEY REFERENCES b2(update_cascade) ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE child (
  c INT PRIMARY KEY,
  p INT NOT NULL REFERENCES parent(p) ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE child (pk INT PRIMARY KEY, p INT DEFAULT 1 REFERENCES parent(p) ON UPDATE SET DEFAULT)

-- sqlfmt-corpus-separator --

CREATE TABLE child (pk INT PRIMARY KEY, p INT REFERENCES parent(p) ON UPDATE CASCADE)

-- sqlfmt-corpus-separator --

CREATE TABLE child (pk INT PRIMARY KEY, p INT REFERENCES parent(p) ON UPDATE SET NULL)

-- sqlfmt-corpus-separator --

CREATE TABLE child146889 (ref INT REFERENCES parent146889(k) ON DELETE CASCADE)

-- sqlfmt-corpus-separator --

CREATE TABLE child_cascade (
  c INT PRIMARY KEY,
  p INT NOT NULL REFERENCES parent_cascade(p) ON DELETE CASCADE ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE child_cascade (
  c INT PRIMARY KEY,
  p INT REFERENCES parent_cascade(p) ON DELETE SET NULL ON UPDATE SET NULL
);

-- sqlfmt-corpus-separator --

CREATE TABLE child_cascade (
  c INT PRIMARY KEY,
  p INT UNIQUE NOT NULL REFERENCES parent_cascade(p) ON DELETE CASCADE ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE crdb_internal_functions_tbl (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE create_table_ttl_expire_after_and_ttl_expiration_expression (
  id INT PRIMARY KEY
) WITH (ttl_expire_after = '10 minutes', ttl_expiration_expression = 'crdb_internal_expiration')

-- sqlfmt-corpus-separator --

CREATE TABLE d (
  id STRING PRIMARY KEY
 ,c_id STRING REFERENCES c ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE d (
  id STRING PRIMARY KEY
 ,delete_restrict STRING NOT NULL REFERENCES c2 ON DELETE RESTRICT
);

-- sqlfmt-corpus-separator --

CREATE TABLE d (
  id STRING PRIMARY KEY REFERENCES b ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE d (
  id STRING PRIMARY KEY REFERENCES c ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE d.b (
  id STRING PRIMARY KEY
 ,a_id STRING REFERENCES d.a ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE d1 (
  id STRING PRIMARY KEY
 ,update_restrict STRING NOT NULL REFERENCES c2 (update_cascade) ON UPDATE RESTRICT
);

-- sqlfmt-corpus-separator --

CREATE TABLE d2 (
  id STRING PRIMARY KEY REFERENCES c3 ON UPDATE RESTRICT
);

-- sqlfmt-corpus-separator --

CREATE TABLE del_cascade_test (
  delete_cascade INT NOT NULL REFERENCES update_test ON DELETE CASCADE
 ,j JSONB
 ,INVERTED INDEX(j)
);

-- sqlfmt-corpus-separator --

CREATE TABLE delete_no_default_table (
  id INT PRIMARY KEY
 ,delete_no_default INT REFERENCES a ON DELETE SET DEFAULT
);

-- sqlfmt-corpus-separator --

CREATE TABLE drop_column_crdb_internal_expiration() WITH (ttl_expire_after='10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE e (
  b_id STRING PRIMARY KEY REFERENCES b ON UPDATE CASCADE
 ,d_id STRING UNIQUE REFERENCES d ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE e (
  d_id STRING PRIMARY KEY REFERENCES d ON UPDATE CASCADE
 ,c_id STRING UNIQUE REFERENCES c ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE e (
  id STRING PRIMARY KEY
 ,b_id STRING REFERENCES b ON DELETE CASCADE
 ,d_id STRING REFERENCES d ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE f (
  a INT REFERENCES a (a) ON UPDATE CASCADE,
  b INT REFERENCES b (b),
  c INT REFERENCES c (c),
  d INT REFERENCES d (d),
  e INT REFERENCES e (e),
  f INT PRIMARY KEY
)

-- sqlfmt-corpus-separator --

CREATE TABLE f (
  e_b_id STRING PRIMARY KEY REFERENCES e (b_id) ON UPDATE CASCADE
 ,e_d_id STRING REFERENCES e (d_id) ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE f (
  e_d_id STRING PRIMARY KEY REFERENCES e (d_id) ON UPDATE CASCADE
 ,e_c_id STRING REFERENCES e (c_id) ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE generated_always_t (
  a INT UNIQUE,
  b INT GENERATED ALWAYS AS IDENTITY,
  FAMILY f1 (a, b)
)

-- sqlfmt-corpus-separator --

CREATE TABLE generated_always_t_notnull (a INT UNIQUE, b INT NOT NULL GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TABLE generated_as_id_t (
  a INT UNIQUE,
  b INT GENERATED ALWAYS AS IDENTITY,
  c INT GENERATED BY DEFAULT AS IDENTITY
)

-- sqlfmt-corpus-separator --

CREATE TABLE generated_as_id_t (
  a INT UNIQUE,
  b INT GENERATED ALWAYS AS IDENTITY,
  c INT GENERATED BY DEFAULT AS IDENTITY
);

-- sqlfmt-corpus-separator --

CREATE TABLE generated_as_identity (
  a INT,
  b INT GENERATED ALWAYS AS IDENTITY,
  c INT GENERATED BY DEFAULT AS IDENTITY
)

-- sqlfmt-corpus-separator --

CREATE TABLE good_users (
  id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
  id2 INTEGER UNIQUE
)

-- sqlfmt-corpus-separator --

CREATE TABLE grandchild (
  g INT PRIMARY KEY,
  c INT REFERENCES child(c) ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE grandchild (
  k INT PRIMARY KEY,
  v INT REFERENCES child(v) ON UPDATE CASCADE ON DELETE CASCADE,
  v2 INT REFERENCES child2(v) ON UPDATE CASCADE ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE grandchild80828 (parent_id INT NOT NULL REFERENCES child80828(pid) ON DELETE CASCADE);

-- sqlfmt-corpus-separator --

CREATE TABLE grandchild_cascade (
  c INT PRIMARY KEY,
  p INT NOT NULL REFERENCES child_cascade(p) ON DELETE CASCADE ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE loop_b (
  id INT PRIMARY KEY,
  a_id INT REFERENCES loop_a ON DELETE CASCADE,
  FAMILY f1 (id, a_id)
);

-- sqlfmt-corpus-separator --

CREATE TABLE loop_b (
  id STRING PRIMARY KEY
 ,cascade_delete STRING REFERENCES loop_a ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE loop_b (
  id STRING PRIMARY KEY REFERENCES loop_a ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE messages (
  message_id INT PRIMARY KEY DEFAULT nextval('message_seq'),
  user_id_1 integer REFERENCES good_users(id) ON DELETE CASCADE ON UPDATE CASCADE,
  user_id_2 integer REFERENCES good_users(id) ON DELETE CASCADE ON UPDATE CASCADE, -- this is recursive through good_users
  text string
)

-- sqlfmt-corpus-separator --

CREATE TABLE nocase_strings (s STRING COLLATE "en-US-u-ks-le""vel2");

-- sqlfmt-corpus-separator --

CREATE TABLE not_null_table (
  id INT PRIMARY KEY
 ,delete_not_nullable INT NOT NULL REFERENCES a ON DELETE SET NULL
);

-- sqlfmt-corpus-separator --

CREATE TABLE not_null_table (
  id INT PRIMARY KEY
 ,update_not_nullable INT NOT NULL REFERENCES a ON UPDATE SET NULL
);

-- sqlfmt-corpus-separator --

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(id) ON UPDATE CASCADE ON DELETE SET NULL
);

-- sqlfmt-corpus-separator --

CREATE TABLE pkref_b (b INT PRIMARY KEY REFERENCES pkref_a ON UPDATE NO ACTION ON DELETE RESTRICT)

-- sqlfmt-corpus-separator --

CREATE TABLE primary_key_table (
  id INT PRIMARY KEY REFERENCES a ON DELETE SET NULL
);

-- sqlfmt-corpus-separator --

CREATE TABLE primary_key_table (
  id INT PRIMARY KEY REFERENCES a ON UPDATE SET DEFAULT
);

-- sqlfmt-corpus-separator --

CREATE TABLE primary_key_table (
  id INT PRIMARY KEY REFERENCES a ON UPDATE SET NULL
);

-- sqlfmt-corpus-separator --

CREATE TABLE primary_key_table_set_default (
  id INT PRIMARY KEY REFERENCES a ON DELETE SET DEFAULT
);

-- sqlfmt-corpus-separator --

CREATE TABLE regression_72804 (
  a INT,
  b regression_72804_enum GENERATED ALWAYS AS IDENTITY
)

-- sqlfmt-corpus-separator --

CREATE TABLE self (
  id INT PRIMARY KEY
 ,other_id INT REFERENCES self ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE self (
  id INT PRIMARY KEY
 ,other_id INT REFERENCES self ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE self (a INT PRIMARY KEY, b INT REFERENCES self(a) ON DELETE CASCADE)

-- sqlfmt-corpus-separator --

CREATE TABLE self_x2 (
  x STRING PRIMARY KEY
 ,y STRING UNIQUE REFERENCES self_x2(x) ON DELETE CASCADE
 ,z STRING REFERENCES self_x2(y) ON DELETE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE self_x2 (
  x STRING PRIMARY KEY
 ,y STRING UNIQUE REFERENCES self_x2(x) ON UPDATE CASCADE
 ,z STRING REFERENCES self_x2(y) ON UPDATE CASCADE
);

-- sqlfmt-corpus-separator --

CREATE TABLE selfref (a INT PRIMARY KEY, b INT NOT NULL REFERENCES selfref(a) ON UPDATE CASCADE)

-- sqlfmt-corpus-separator --

CREATE TABLE t (a INT PRIMARY KEY, b INT) WITH (sql_stats_canary_window = '15s')

-- sqlfmt-corpus-separator --

CREATE TABLE t2(x INT REFERENCES t(x) ON DELETE CASCADE);

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

CREATE TABLE t_alter_identity (id SERIAL PRIMARY KEY, a int GENERATED ALWAYS AS IDENTITY, b int GENERATED ALWAYS AS IDENTITY, z int);

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

CREATE TABLE t_serial_identity_no_sequence(a SERIAL PRIMARY KEY GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TABLE t_serial_identity_with_sequence(a SERIAL PRIMARY KEY GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TABLE t_ttl_w_expire_at (c1 int, expire_at TIMESTAMPTZ) WITH (ttl_expiration_expression = 'expire_at');

-- sqlfmt-corpus-separator --

CREATE TABLE t_unique_column (
  a INT PRIMARY KEY,
  b INT UNIQUE WITH (skip_unique_checks = true)
)

-- sqlfmt-corpus-separator --

CREATE TABLE t_with_pk_seq (a INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, b INT);

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

CREATE TABLE tbl_with_dep(
  id1 INT PRIMARY KEY,
  id INT REFERENCES tbl_with_ttl(id) ON DELETE CASCADE
)

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_with_fk(
  id1 INT PRIMARY KEY,
  name STRING,
  id INT REFERENCES tbl_to_add_ttl(id) ON DELETE CASCADE
)

-- sqlfmt-corpus-separator --

CREATE TABLE test_52552_asc (c1 int GENERATED ALWAYS AS IDENTITY);

-- sqlfmt-corpus-separator --

CREATE TABLE test_52552_desc (c1 int GENERATED ALWAYS AS IDENTITY);

-- sqlfmt-corpus-separator --

CREATE TABLE test_52552_start (c1 int GENERATED ALWAYS AS IDENTITY);

-- sqlfmt-corpus-separator --

CREATE TABLE ttl_expiration_expression_required(expire_at TIMESTAMPTZ) WITH (ttl_expiration_expression='expire_at')

-- sqlfmt-corpus-separator --

CREATE TABLE ttl_expire_after_required() WITH (ttl_expire_after='10 minutes')

-- sqlfmt-corpus-separator --

CREATE TABLE update_cascade_test (
 update_cascade INT NOT NULL REFERENCES update_test ON UPDATE CASCADE
 ,j JSONB
 ,INVERTED INDEX(j)
);

-- sqlfmt-corpus-separator --

CREATE TABLE update_no_default_table (
  id INT PRIMARY KEY
 ,update_no_default INT NOT NULL REFERENCES a ON UPDATE SET DEFAULT
);

-- sqlfmt-corpus-separator --

CREATE TABLE y (
    y INT PRIMARY KEY,
    b INT NULL REFERENCES x(k),
    c INT NULL REFERENCES x(k) ON DELETE CASCADE
)

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