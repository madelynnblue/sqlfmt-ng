(((SELECT a FROM t ORDER BY a DESC LIMIT 4)))

-- sqlfmt-corpus-separator --

(((SELECT a FROM t))) ORDER BY a DESC LIMIT 4

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

SELECT
    c_id,
    EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id)
    OR NOT EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id)
FROM c
ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT
    pk, pk2, a, b, crdb_region
FROM
    regional_by_row_table
LIMIT
    1

-- sqlfmt-corpus-separator --

SELECT
    pk, pk2, a, b, crdb_region
FROM
    regional_by_row_table
LIMIT
    1
OFFSET
    4

-- sqlfmt-corpus-separator --

SELECT
    relname,
    relkind,
    relnatts
FROM
    pg_catalog.pg_class
WHERE
    relname = 'u';

-- sqlfmt-corpus-separator --

SELECT
    trigger_catalog,
    trigger_schema,
    trigger_name,
    event_manipulation,
    event_object_schema,
    event_object_table,
    action_order,
    action_orientation,
    action_timing,
    action_reference_old_table,
    action_reference_new_table,
    created
FROM information_schema.triggers
WHERE event_object_table = 'test_triggers'
ORDER BY trigger_name;

-- sqlfmt-corpus-separator --

SELECT
    trigger_name,
    action_condition,
    action_statement
FROM information_schema.triggers
WHERE trigger_name = 'before_update_row';

-- sqlfmt-corpus-separator --

SELECT
    trigger_name,
    action_orientation,
    action_reference_old_table,
    action_reference_new_table,
    action_reference_old_row
FROM information_schema.triggers
WHERE trigger_name = 'after_update_transition';

-- sqlfmt-corpus-separator --

SELECT
    trigger_name,
    event_manipulation,
    action_timing
FROM information_schema.triggers
WHERE trigger_name = 'multi_event_trigger'
ORDER BY event_manipulation;

-- sqlfmt-corpus-separator --

SELECT
  (SELECT id FROM a)
 ,(SELECT id FROM b)
 ,(SELECT id FROM c)
 ,(SELECT id FROM d)
;

-- sqlfmt-corpus-separator --

SELECT
  (SELECT id FROM a)
 ,(SELECT id FROM b1)
 ,(SELECT id FROM b2)
 ,(SELECT id FROM c1)
 ,(SELECT id FROM c2)
;

-- sqlfmt-corpus-separator --

SELECT
  (SELECT id FROM loop_a)
 ,(SELECT id FROM loop_b)
;

-- sqlfmt-corpus-separator --

SELECT
  DISTINCT ON ("genre") genre
FROM
  "public"."author"
ORDER BY
  "genre" ASC NULLS LAST

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
  column_name, column_type
FROM
  crdb_internal.table_columns
WHERE
  descriptor_name = 'enum_array' AND column_name = 'x'

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
  database_name, parent_id, schema_name, parent_schema_id, name, table_id
FROM crdb_internal.tables
WHERE database_name = 'test'

-- sqlfmt-corpus-separator --

SELECT
  elem,
  elem = 'a'
FROM enum_table
ORDER BY id

-- sqlfmt-corpus-separator --

SELECT
  elems,
  elems = '{a}'
FROM enum_array_table
ORDER BY id

-- sqlfmt-corpus-separator --

SELECT
  indexrelid, indrelid, indkey, indclass, indoption, indcollation
FROM pg_index
WHERE indrelid = (SELECT oid FROM pg_class WHERE relname = 't')
ORDER BY 1,2,3

-- sqlfmt-corpus-separator --

SELECT
  table_id,
  parent_id,
  name,
  database_name,
  version,
  format_version,
  state,
  sc_lease_node_id,
  sc_lease_expiration_time,
  drop_time,
  audit_mode,
  schema_name,
  parent_schema_id
FROM crdb_internal.tables WHERE NAME = 'descriptor'

-- sqlfmt-corpus-separator --

SELECT
  tablename, indexname, indexdef
FROM pg_indexes
WHERE tablename = 'sharded_primary'
ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT
  tablename, indexname, indexdef
FROM pg_indexes
WHERE tablename = 't'
ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT
  typname,
  typnamespace,
  typtype,
  typcategory,
  typnotnull,
  typelem,
  typlen,
  typbasetype,
  typtypmod,
  typdefaultbin
FROM pg_type WHERE typname = 'regression_66576'

-- sqlfmt-corpus-separator --

SELECT  * FROM crdb_internal.cluster_transactions WHERE node_id < 0

-- sqlfmt-corpus-separator --

SELECT  * FROM crdb_internal.leases;

-- sqlfmt-corpus-separator --

SELECT  * FROM crdb_internal.node_transactions WHERE node_id < 0

-- sqlfmt-corpus-separator --

SELECT  option, value FROM system.role_options WHERE username = 'repluser'

-- sqlfmt-corpus-separator --

SELECT "X" FROM foo

-- sqlfmt-corpus-separator --

SELECT "foo"."v" FROM kv AS foo WHERE foo.k = 'a'

-- sqlfmt-corpus-separator --

SELECT "hashedPassword" FROM system.users LIMIT 1

-- sqlfmt-corpus-separator --

SELECT "name", "partialPredicate" FROM system.table_statistics WHERE name='abcd_a_partial';

-- sqlfmt-corpus-separator --

SELECT "name", "partialPredicate" FROM system.table_statistics WHERE name='abcd_c_partial';

-- sqlfmt-corpus-separator --

SELECT "name", "partialPredicate" FROM system.table_statistics WHERE name='xy_x_partial';

-- sqlfmt-corpus-separator --

SELECT "reportingID" FROM system.eventlog
WHERE "eventType" = 'reverse_schema_change'

-- sqlfmt-corpus-separator --

SELECT '', 'NULL', 'Null', 'null', NULL, '"', e'\''

-- sqlfmt-corpus-separator --

SELECT 'FOO' % 'foo', 'foobar' % 'foo', 'foobar' % 'barfoo', 'blorp' % 'z'

-- sqlfmt-corpus-separator --

SELECT 'bats fats' @@ 'fat bat cat'

-- sqlfmt-corpus-separator --

SELECT 'fat bat cat' @@ 'bats fats'

-- sqlfmt-corpus-separator --

SELECT 'fat cats ate fat bats' @@ a FROM ab

-- sqlfmt-corpus-separator --

SELECT 'fat rats' @@ b FROM ab

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL AS t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL AS tx

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL tx

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", t1.a, t2.e FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e) WHERE t1.a = t2.d

-- sqlfmt-corpus-separator --

SELECT '{"foo": "bar"}' - s AS a, '{"bar": "foo"}' - s AS b FROM t57165 ORDER BY rowid

-- sqlfmt-corpus-separator --

SELECT (SELECT * FROM abc)

-- sqlfmt-corpus-separator --

SELECT (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT (SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT (SELECT 1, 2, 3) = (SELECT 1, 2, 3)

-- sqlfmt-corpus-separator --

SELECT (SELECT DISTINCT ON (a) a FROM abc ORDER BY a, b||'foo') || 'bar';

-- sqlfmt-corpus-separator --

SELECT (SELECT a FROM abc WHERE false)

-- sqlfmt-corpus-separator --

SELECT (SELECT a FROM abc)

-- sqlfmt-corpus-separator --

SELECT (SELECT a FROM t86075) FROM t86075

-- sqlfmt-corpus-separator --

SELECT (SELECT c FROM t86075) FROM t86075

-- sqlfmt-corpus-separator --

SELECT (SELECT r FROM t128294) FROM t128294;

-- sqlfmt-corpus-separator --

SELECT (SELECT tableoid FROM pg_class LIMIT 1) != (SELECT tableoid FROM pg_namespace LIMIT 1)

-- sqlfmt-corpus-separator --

SELECT (t2 - t1) FROM t

-- sqlfmt-corpus-separator --

SELECT (test_json->>'field3') FROM test_jsonb WHERE json_type = 'object';

-- sqlfmt-corpus-separator --

SELECT *

-- sqlfmt-corpus-separator --

SELECT *
FROM c
WHERE
    EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id)
    OR NOT EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT *
FROM c
WHERE (SELECT o_id FROM o WHERE o.c_id=c.c_id AND ship='WY')=4;

-- sqlfmt-corpus-separator --

SELECT *
FROM information_schema.check_constraints
ORDER BY CONSTRAINT_CATALOG, CONSTRAINT_NAME

-- sqlfmt-corpus-separator --

SELECT *
FROM information_schema.constraint_column_usage
WHERE constraint_catalog = 'constraint_db'
ORDER BY TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME

-- sqlfmt-corpus-separator --

SELECT *
FROM information_schema.table_constraints
ORDER BY TABLE_NAME, CONSTRAINT_TYPE, CONSTRAINT_NAME

-- sqlfmt-corpus-separator --

SELECT *
FROM pg_catalog.pg_am

-- sqlfmt-corpus-separator --

SELECT *
FROM pg_catalog.pg_index
ORDER BY indexrelid

-- sqlfmt-corpus-separator --

SELECT *
FROM system.information_schema.character_sets

-- sqlfmt-corpus-separator --

SELECT *
FROM system.information_schema.check_constraints
ORDER BY CONSTRAINT_CATALOG, CONSTRAINT_NAME

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

SELECT * FROM  itemColors

-- sqlfmt-corpus-separator --

SELECT * FROM "A"

-- sqlfmt-corpus-separator --

SELECT * FROM "Another-Schema"."MixedTable"

-- sqlfmt-corpus-separator --

SELECT * FROM "B"

-- sqlfmt-corpus-separator --

SELECT * FROM "MixedCase"."MixedTable"

-- sqlfmt-corpus-separator --

SELECT * FROM "MixedTable"

-- sqlfmt-corpus-separator --

SELECT * FROM B

-- sqlfmt-corpus-separator --

SELECT * FROM INFormaTION_SCHEMa.schemata

-- sqlfmt-corpus-separator --

SELECT * FROM PG_CATALOG.PG_DEFAULT_ACL

-- sqlfmt-corpus-separator --

SELECT * FROM PG_CATALOG.PG_DEFAULT_ACL WHERE defaclnamespace != 0

-- sqlfmt-corpus-separator --

SELECT * FROM SYSTEM.COMMENTS;

-- sqlfmt-corpus-separator --

SELECT * FROM a

-- sqlfmt-corpus-separator --

SELECT * FROM a ORDER BY 1, 2 LIMIT 10

-- sqlfmt-corpus-separator --

SELECT * FROM a ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM a ORDER BY a LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT * FROM a ORDER BY b

-- sqlfmt-corpus-separator --

SELECT * FROM a ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE EXISTS (SELECT * FROM b WHERE a1 = b1 OR a2 = b2 OR a3 = b3 OR a4 = b4)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE EXISTS (SELECT * FROM c WHERE a1 = c1 OR a2 = c2 OR a3 = c3 OR a4 = c4)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE EXISTS (SELECT * FROM c WHERE a1 = c2 OR a2 = c1 OR a3 = c4 OR a3 = c4)

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE EXISTS (SELECT 1 FROM c, d WHERE c1 = d2 or c2 = d1)

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

SELECT * FROM a WHERE a = 4 AND b = 1

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE a = 4 AND b = 2

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE a = 5 AND b = 2 AND c = 'foo'

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE x > 1

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE x > 1 AND x < 3

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE x > 1 AND y < 30

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE y > 1

-- sqlfmt-corpus-separator --

SELECT * FROM a t1, a t2 WHERE (t1.a2 = t2.a2 OR t1.a3 = t2.a3) AND (t1.a1 = t2.a1 OR t1.a4 = t2.a4)

-- sqlfmt-corpus-separator --

SELECT * FROM a, b WHERE (a2 = b2 OR a3 = b3) AND (a1 = b1 OR a4 = b4)

-- sqlfmt-corpus-separator --

SELECT * FROM a, c WHERE (a1 = c1 OR a2 = c2 OR a3 = c3 OR a4 = c4)

-- sqlfmt-corpus-separator --

SELECT * FROM a, c WHERE (a1 = c2 OR a2 = c1 OR a3 = c4 OR a3 = c4)

-- sqlfmt-corpus-separator --

SELECT * FROM a, d WHERE (a1 = d2 AND a2 = d1) OR (a3 = d4 AND a4 = d3)

-- sqlfmt-corpus-separator --

SELECT * FROM a.b;

-- sqlfmt-corpus-separator --

SELECT * FROM a;

-- sqlfmt-corpus-separator --

SELECT * FROM ab

-- sqlfmt-corpus-separator --

SELECT * FROM ab AS foo (foo1, foo2)

-- sqlfmt-corpus-separator --

SELECT * FROM ab AS foo (foo1, foo2, foo3)

-- sqlfmt-corpus-separator --

SELECT * FROM ab;

-- sqlfmt-corpus-separator --

SELECT * FROM abc

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo

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

SELECT * FROM abc WHERE 'hello'

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

SELECT * FROM abc WHERE NULL

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = 11

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = 6

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = 7

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = NULL

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a > 4

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a > 5 AND a < 5

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a > 5 AND a < 5 AND b>=100

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE b = 7

-- sqlfmt-corpus-separator --

SELECT * FROM abc where c = 4

-- sqlfmt-corpus-separator --

SELECT * FROM abcd

-- sqlfmt-corpus-separator --

SELECT * FROM abcd WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT * FROM abcd WHERE a = 2

-- sqlfmt-corpus-separator --

SELECT * FROM abcd WHERE a >= 20 AND a <= 30

-- sqlfmt-corpus-separator --

SELECT * FROM accounts;

-- sqlfmt-corpus-separator --

SELECT * FROM acl_mid_upgrade

-- sqlfmt-corpus-separator --

SELECT * FROM acl_test

-- sqlfmt-corpus-separator --

SELECT * FROM aclitem_test

-- sqlfmt-corpus-separator --

SELECT * FROM add_default

-- sqlfmt-corpus-separator --

SELECT * FROM all_types ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM alter_test_view

-- sqlfmt-corpus-separator --

SELECT * FROM anon_args

-- sqlfmt-corpus-separator --

SELECT * FROM app_stmts_view ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT * FROM arbiter_index

-- sqlfmt-corpus-separator --

SELECT * FROM arr_composite_tab

-- sqlfmt-corpus-separator --

SELECT * FROM arr_t

-- sqlfmt-corpus-separator --

SELECT * FROM arr_t2

-- sqlfmt-corpus-separator --

SELECT * FROM arr_t3

-- sqlfmt-corpus-separator --

SELECT * FROM array_tab WHERE b @> '{1}' AND a % 2 = 0 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM array_tab WHERE b @> '{1}' OR a = 1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM arrays

-- sqlfmt-corpus-separator --

SELECT * FROM assn_cast_c

-- sqlfmt-corpus-separator --

SELECT * FROM assn_cast_char_default

-- sqlfmt-corpus-separator --

SELECT * FROM assn_cast_dec_default

-- sqlfmt-corpus-separator --

SELECT * FROM assn_cast_do_nothing

-- sqlfmt-corpus-separator --

SELECT * FROM assn_cast_do_update

-- sqlfmt-corpus-separator --

SELECT * FROM assn_cast_on_update

-- sqlfmt-corpus-separator --

SELECT * FROM atyp

-- sqlfmt-corpus-separator --

SELECT * FROM audit_log ORDER BY op;

-- sqlfmt-corpus-separator --

SELECT * FROM audit_log;

-- sqlfmt-corpus-separator --

SELECT * FROM b

-- sqlfmt-corpus-separator --

SELECT * FROM b ORDER BY v

-- sqlfmt-corpus-separator --

SELECT * FROM b ORDER BY x, y;

-- sqlfmt-corpus-separator --

SELECT * FROM b WHERE a = 'foobar 367'

-- sqlfmt-corpus-separator --

SELECT * FROM b, d WHERE (b1 = 0 OR b1 = d1)   AND
                         (b1 = 0 OR b2 = 5)    AND
                         (b2 = d1 OR b1 = d1)  AND
                         (b2 = d1 OR b2 = 5)

-- sqlfmt-corpus-separator --

SELECT * FROM b, d WHERE (b1 = b2 OR b3 = d3 OR b4 = d4 OR d1 = d2)

-- sqlfmt-corpus-separator --

SELECT * FROM b, d WHERE (b1 = b2 OR b3 = d3)

-- sqlfmt-corpus-separator --

SELECT * FROM b.a

-- sqlfmt-corpus-separator --

SELECT * FROM b1;

-- sqlfmt-corpus-separator --

SELECT * FROM b2;

-- sqlfmt-corpus-separator --

SELECT * FROM b;

-- sqlfmt-corpus-separator --

SELECT * FROM bar

-- sqlfmt-corpus-separator --

SELECT * FROM bar ORDER BY baz, id

-- sqlfmt-corpus-separator --

SELECT * FROM baz

-- sqlfmt-corpus-separator --

SELECT * FROM bcd WHERE b < 8

-- sqlfmt-corpus-separator --

SELECT * FROM big WHERE a > 100

-- sqlfmt-corpus-separator --

SELECT * FROM big WHERE a > 100 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM bools WHERE b

-- sqlfmt-corpus-separator --

SELECT * FROM box2d_encoding_test ORDER BY id ASC

-- sqlfmt-corpus-separator --

SELECT * FROM bypassrls ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM c

-- sqlfmt-corpus-separator --

SELECT * FROM c ORDER BY q

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id AND c.bill='TX');

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE NOT EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE c_id=(SELECT c_id FROM o WHERE ship='CA' AND c.c_id<>2)

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE c_id=(SELECT c_id FROM o WHERE ship='CA' AND c_id<>1 AND bill='TX')

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE c_id=(SELECT c_id FROM o WHERE ship='WA' AND bill='FL')

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE foo @> '{1, 2}' ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE foo @> 0

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE str >= 'moo'

-- sqlfmt-corpus-separator --

SELECT * FROM c, d WHERE (c1 = d1 AND c2 = d2) OR c3 = d3

-- sqlfmt-corpus-separator --

SELECT * FROM c1;

-- sqlfmt-corpus-separator --

SELECT * FROM c2;

-- sqlfmt-corpus-separator --

SELECT * FROM c_delete_cascade

-- sqlfmt-corpus-separator --

SELECT * FROM c_delete_set

-- sqlfmt-corpus-separator --

SELECT * FROM c_update

-- sqlfmt-corpus-separator --

SELECT * FROM cc_udf_array_t

-- sqlfmt-corpus-separator --

SELECT * FROM cc_udf_builtins_t

-- sqlfmt-corpus-separator --

SELECT * FROM cc_udf_case_t

-- sqlfmt-corpus-separator --

SELECT * FROM cc_udf_casts_t

-- sqlfmt-corpus-separator --

SELECT * FROM cc_udf_coalesce_t

-- sqlfmt-corpus-separator --

SELECT * FROM cc_udf_mixed_t

-- sqlfmt-corpus-separator --

SELECT * FROM cc_udf_multi_t

-- sqlfmt-corpus-separator --

SELECT * FROM cc_udf_multi_unnamed_t

-- sqlfmt-corpus-separator --

SELECT * FROM cc_udf_ordinal_t

-- sqlfmt-corpus-separator --

SELECT * FROM cc_udf_param_t

-- sqlfmt-corpus-separator --

SELECT * FROM cc_udf_strict_t

-- sqlfmt-corpus-separator --

SELECT * FROM cc_udf_t

-- sqlfmt-corpus-separator --

SELECT * FROM cd_v3;

-- sqlfmt-corpus-separator --

SELECT * FROM chgme ORDER BY C1;

-- sqlfmt-corpus-separator --

SELECT * FROM child

-- sqlfmt-corpus-separator --

SELECT * FROM child WHERE NOT EXISTS (SELECT * FROM parent WHERE p_id = c_p_id) AND c_id = 10

-- sqlfmt-corpus-separator --

SELECT * FROM child2;

-- sqlfmt-corpus-separator --

SELECT * FROM child;

-- sqlfmt-corpus-separator --

SELECT * FROM child_150282;

-- sqlfmt-corpus-separator --

SELECT * FROM child_151663 ORDER BY c

-- sqlfmt-corpus-separator --

SELECT * FROM child_cascade

-- sqlfmt-corpus-separator --

SELECT * FROM child_cascade;

-- sqlfmt-corpus-separator --

SELECT * FROM children

-- sqlfmt-corpus-separator --

SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

SELECT * FROM column_add

-- sqlfmt-corpus-separator --

SELECT * FROM computed;

-- sqlfmt-corpus-separator --

SELECT * FROM constraint_db.pg_catalog.pg_tables WHERE schemaname = 'public'

-- sqlfmt-corpus-separator --

SELECT * FROM constraint_db.t1

-- sqlfmt-corpus-separator --

SELECT * FROM corrupt_backref_fk

-- sqlfmt-corpus-separator --

SELECT * FROM corrupt_backref_view

-- sqlfmt-corpus-separator --

SELECT * FROM corruptdesc;

-- sqlfmt-corpus-separator --

SELECT * FROM cpk

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.backward_dependencies WHERE descriptor_name = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.builtin_functions WHERE function = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_contention_events

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_contention_events WHERE table_id < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_database_privileges

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_database_privileges ORDER BY 1,2,3

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_execution_insights WHERE query = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_inflight_traces

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_inflight_traces WHERE trace_id=123

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_locks

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_queries

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_queries WHERE node_id < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_sessions

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_sessions WHERE node_id < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_settings WHERE variable = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_settings;

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.cluster_txn_execution_insights WHERE query = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.create_statements WHERE database_name = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.create_statements WHERE descriptor_name = 'show_create_test'

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.create_type_statements ORDER BY descriptor_id

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.create_type_statements WHERE descriptor_name = 'enum1'

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.default_privileges

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.default_privileges WHERE grantee = 'roach_a'
ORDER BY role;

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.default_privileges WHERE grantee='foo' OR grantee='bar'

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.default_privileges WHERE role='foo' OR role='bar'

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.feature_usage WHERE feature_name = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.forward_dependencies WHERE descriptor_name = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.index_columns WHERE descriptor_name = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.index_columns WHERE descriptor_name = 't_parent'

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.index_columns WHERE descriptor_name = 't_test_hsi_change_locality'

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.invalid_objects

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.invalid_objects ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.kv_node_status

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.kv_store_status

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.leases WHERE node_id < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.lost_descriptors_with_data;

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_build_info

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_contention_events

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_contention_events WHERE table_id < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_execution_insights WHERE query = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_inflight_trace_spans WHERE span_id < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_queries

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_queries WHERE node_id < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_sessions

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_sessions WHERE node_id < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_statement_statistics WHERE node_id < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_statement_statistics;

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_tenant_capabilities_cache

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_tenant_capabilities_cache WHERE capability_name = 'can_view_node_info'

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_transaction_statistics WHERE node_id < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_transactions

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.node_txn_execution_insights WHERE query = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.partitions

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.partitions ORDER BY table_id, index_id, name

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.pg_catalog_table_is_implemented

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.ranges WHERE range_id < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.ranges_no_leases WHERE range_id < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.regions ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.schema_changes

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.schema_changes WHERE table_id < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.session_trace WHERE span_idx < 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.session_variables WHERE variable = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.session_variables;

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.table_columns WHERE descriptor_name = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.table_indexes WHERE descriptor_name = ''

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.tables

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.tables;

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.transaction_contention_events

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.zones WHERE false

-- sqlfmt-corpus-separator --

SELECT * FROM ctas1 ORDER BY ID;

-- sqlfmt-corpus-separator --

SELECT * FROM customers

-- sqlfmt-corpus-separator --

SELECT * FROM cutlery

-- sqlfmt-corpus-separator --

SELECT * FROM d

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b = NULL;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '"a"' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '1' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '1.23' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '["a"]' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '["d", {"a": {"b": [1]}}]'

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '["d", {"a": {"b": [[2]]}}]'

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '[1, 2]' ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '[[1, 2]]' ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '[[[["a"]]]]' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '[[]]' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '[]' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '[{"a": "a"}]' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '[{"a": {"b": [[2]]}}, "d"]'

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '[{}]' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> 'false' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> 'null' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> 'true' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"a": "b", "c": "e"}'

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"a": "e", "c": "d"}'

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"a": 123.123000}' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"a": 123.123}' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"a": []}' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"a": [{}]}' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"a": {"b": "c", "d": "e"}, "f": "g"}'

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"a": {"b": "c"}, "f": "g"}'

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"a": {"b": [1]}}' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"a": {"b": [[2]]}}' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"a": {"b": true}}' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"a": {}}' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"c": "d", "a": "b", "f": "g"}'

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{"c": "d", "a": "b"}'

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> '{}' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> NULL ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @> NULL;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @>'[1]' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @>'[{"a": {"b": [1]}}]' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b @>'{"a": "b"}' ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM d WHERE b->'a' = '"b"'

-- sqlfmt-corpus-separator --

SELECT * FROM d.xy;

-- sqlfmt-corpus-separator --

SELECT * FROM d1.v2

-- sqlfmt-corpus-separator --

SELECT * FROM d1.xy;

-- sqlfmt-corpus-separator --

SELECT * FROM d2.v1

-- sqlfmt-corpus-separator --

SELECT * FROM d2.v2

-- sqlfmt-corpus-separator --

SELECT * FROM d2.v3

-- sqlfmt-corpus-separator --

SELECT * FROM d2.v4

-- sqlfmt-corpus-separator --

SELECT * FROM db2.foo

-- sqlfmt-corpus-separator --

SELECT * FROM db2.t

-- sqlfmt-corpus-separator --

SELECT * FROM default_view;

-- sqlfmt-corpus-separator --

SELECT * FROM del_cascade_test ORDER BY delete_cascade;

-- sqlfmt-corpus-separator --

SELECT * FROM documents ORDER BY ID;

-- sqlfmt-corpus-separator --

SELECT * FROM drop_primary_regions_db.primary

-- sqlfmt-corpus-separator --

SELECT * FROM dt

-- sqlfmt-corpus-separator --

SELECT * FROM dt2

-- sqlfmt-corpus-separator --

SELECT * FROM e

-- sqlfmt-corpus-separator --

SELECT * FROM employees

-- sqlfmt-corpus-separator --

SELECT * FROM employees ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM enum_array

-- sqlfmt-corpus-separator --

SELECT * FROM enum_computed

-- sqlfmt-corpus-separator --

SELECT * FROM enum_ctas

-- sqlfmt-corpus-separator --

SELECT * FROM enum_data_type

-- sqlfmt-corpus-separator --

SELECT * FROM enum_default

-- sqlfmt-corpus-separator --

SELECT * FROM enum_table

-- sqlfmt-corpus-separator --

SELECT * FROM ex33313 ORDER BY foo

-- sqlfmt-corpus-separator --

SELECT * FROM example;

-- sqlfmt-corpus-separator --

SELECT * FROM f

-- sqlfmt-corpus-separator --

SELECT * FROM fake7

-- sqlfmt-corpus-separator --

SELECT * FROM foo

-- sqlfmt-corpus-separator --

SELECT * FROM foo, bar WHERE foo.a = bar.a AND foo.b = bar.b

-- sqlfmt-corpus-separator --

SELECT * FROM foo, bar WHERE foo.b = bar.b

-- sqlfmt-corpus-separator --

SELECT * FROM foo3 ORDER BY x

-- sqlfmt-corpus-separator --

SELECT * FROM foo4

-- sqlfmt-corpus-separator --

SELECT * FROM foo41004

-- sqlfmt-corpus-separator --

SELECT * FROM force_sd_view ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM force_si_view ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM force_t ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM forcedeletemydata ORDER BY v ASC

-- sqlfmt-corpus-separator --

SELECT * FROM gen_as_id_seqopt ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM generated_as_id_t ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM generated_as_id_t ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM geo_array_table

-- sqlfmt-corpus-separator --

SELECT * FROM geo_table

-- sqlfmt-corpus-separator --

SELECT * FROM geography_columns WHERE f_table_name = 'pg_extension_test'

-- sqlfmt-corpus-separator --

SELECT * FROM geometry_columns WHERE f_table_name = 'pg_extension_test'

-- sqlfmt-corpus-separator --

SELECT * FROM good_users ORDER BY id ASC

-- sqlfmt-corpus-separator --

SELECT * FROM grandchild

-- sqlfmt-corpus-separator --

SELECT * FROM grandchild;

-- sqlfmt-corpus-separator --

SELECT * FROM grandchild_cascade

-- sqlfmt-corpus-separator --

SELECT * FROM grandchild_cascade;

-- sqlfmt-corpus-separator --

SELECT * FROM greeting_table

-- sqlfmt-corpus-separator --

SELECT * FROM guardrails

-- sqlfmt-corpus-separator --

SELECT * FROM guardrails LIMIT 50

-- sqlfmt-corpus-separator --

SELECT * FROM guardrails WHERE i = 1

-- sqlfmt-corpus-separator --

SELECT * FROM guardrails WHERE i > 0 AND i <= 10

-- sqlfmt-corpus-separator --

SELECT * FROM guardrails2

-- sqlfmt-corpus-separator --

SELECT * FROM hood

-- sqlfmt-corpus-separator --

SELECT * FROM i

-- sqlfmt-corpus-separator --

SELECT * FROM i WHERE f = 0

-- sqlfmt-corpus-separator --

SELECT * FROM implicit_types;

-- sqlfmt-corpus-separator --

SELECT * FROM indexed

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.administrable_role_authorizations

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.applicable_roles

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.applicable_roles ORDER BY role_name;

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.applicable_roles;

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.attributes WHERE udt_name = 'u'

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.collation_character_set_applicability

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.collations ORDER BY collation_name

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.column_udt_usage

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.enabled_roles

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.key_column_usage WHERE constraint_schema = 'public' ORDER BY TABLE_NAME, CONSTRAINT_NAME, ORDINAL_POSITION

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.referential_constraints WHERE constraint_schema = 'public' ORDER BY TABLE_NAME, CONSTRAINT_NAME

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.role_table_grants WHERE TABLE_SCHEMA = 'public'

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.routines WHERE routine_name = 'pg_get_functiondef'

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.schema_privileges

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.schemata

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.sequences

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.sequences ORDER BY sequence_name

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.sequences WHERE sequence_name = 'alter_opts_generated_as_identity_a_seq'

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.table_privileges WHERE TABLE_SCHEMA = 'public'

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.table_privileges WHERE grantee = 'mix_u';

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.table_privileges WHERE grantee = 'readwrite';

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.user_defined_types WHERE user_defined_type_name = 'dne'

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.user_defined_types WHERE user_defined_type_name = 'u'

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.user_privileges ORDER BY grantee,privilege_type

-- sqlfmt-corpus-separator --

SELECT * FROM insert_t

-- sqlfmt-corpus-separator --

SELECT * FROM issue_13962

-- sqlfmt-corpus-separator --

SELECT * FROM issue_14052_2;

-- sqlfmt-corpus-separator --

SELECT * FROM issue_17339 ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM itemTypes

-- sqlfmt-corpus-separator --

SELECT * FROM json_tab WHERE b @> '1' ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM json_tab WHERE b @> '[1]' AND a % 2 = 0 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM json_tab WHERE b @> '[1]' OR a = 44 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM json_tab WHERE b @> '{"a": []}' ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM json_tab WHERE b @> '{"a": {}}' ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM kv

-- sqlfmt-corpus-separator --

SELECT * FROM kv LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM kv ORDER BY k

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE False

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE True

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE k > v

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE nonexistent = 1

-- sqlfmt-corpus-separator --

SELECT * FROM kv2

-- sqlfmt-corpus-separator --

SELECT * FROM kv3

-- sqlfmt-corpus-separator --

SELECT * FROM kv;

-- sqlfmt-corpus-separator --

SELECT * FROM kv; COMMIT; BEGIN; UPDATE kv SET v = 'd' WHERE k in ('a')

-- sqlfmt-corpus-separator --

SELECT * FROM kv; UPDATE kv SET v = 'c' WHERE k in ('a'); COMMIT

-- sqlfmt-corpus-separator --

SELECT * FROM kview

-- sqlfmt-corpus-separator --

SELECT * FROM l ORDER BY lt;

-- sqlfmt-corpus-separator --

SELECT * FROM l WHERE EXISTS(SELECT * FROM r WHERE r.a=l.a)

-- sqlfmt-corpus-separator --

SELECT * FROM la ORDER BY lta;

-- sqlfmt-corpus-separator --

SELECT * FROM last_inspect_errors

-- sqlfmt-corpus-separator --

SELECT * FROM last_inspect_job

-- sqlfmt-corpus-separator --

SELECT * FROM last_inspect_job;

-- sqlfmt-corpus-separator --

SELECT * FROM local_table

-- sqlfmt-corpus-separator --

SELECT * FROM log2;

-- sqlfmt-corpus-separator --

SELECT * FROM lots

-- sqlfmt-corpus-separator --

SELECT * FROM messages

-- sqlfmt-corpus-separator --

SELECT * FROM messages WHERE account_id = 1 AND account_id = 2

-- sqlfmt-corpus-separator --

SELECT * FROM messages_rbr rbr, messages_rbt rbt WHERE rbr.account_id = rbt.account_id LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM mno ORDER BY m

-- sqlfmt-corpus-separator --

SELECT * FROM mqt_doc ORDER BY ID;

-- sqlfmt-corpus-separator --

SELECT * FROM multi_sd ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM multi_si ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM multipleinstmt ORDER BY key ASC;

-- sqlfmt-corpus-separator --

SELECT * FROM mutation

-- sqlfmt-corpus-separator --

SELECT * FROM mv ORDER BY x, y;

-- sqlfmt-corpus-separator --

SELECT * FROM mv1

-- sqlfmt-corpus-separator --

SELECT * FROM mv2

-- sqlfmt-corpus-separator --

SELECT * FROM mv;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_bob_view ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_bob_view2 ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_forced_view ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_owned_view ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM myschema.tb

-- sqlfmt-corpus-separator --

SELECT * FROM myschema.tb2

-- sqlfmt-corpus-separator --

SELECT * FROM myschema.v

-- sqlfmt-corpus-separator --

SELECT * FROM myschema3.tb2

-- sqlfmt-corpus-separator --

SELECT * FROM new_enum_values

-- sqlfmt-corpus-separator --

SELECT * FROM new_kv

-- sqlfmt-corpus-separator --

SELECT * FROM new_v

-- sqlfmt-corpus-separator --

SELECT * FROM no_default_table

-- sqlfmt-corpus-separator --

SELECT * FROM no_default_table_on_update

-- sqlfmt-corpus-separator --

SELECT * FROM no_priv_t

-- sqlfmt-corpus-separator --

SELECT * FROM non_multiregion_test_db.messages, multi_region_test_db.messages_global

-- sqlfmt-corpus-separator --

SELECT * FROM non_rls;

-- sqlfmt-corpus-separator --

SELECT * FROM noncover WHERE b = 2

-- sqlfmt-corpus-separator --

SELECT * FROM noncover WHERE b = 5 AND b <> 5

-- sqlfmt-corpus-separator --

SELECT * FROM noncover WHERE b = 5 AND b <> 5 AND d>100

-- sqlfmt-corpus-separator --

SELECT * FROM noncover WHERE c = 7

-- sqlfmt-corpus-separator --

SELECT * FROM noncover WHERE c > 0 AND d = 8

-- sqlfmt-corpus-separator --

SELECT * FROM noncover WHERE c > 0 ORDER BY c DESC

-- sqlfmt-corpus-separator --

SELECT * FROM num_ref

-- sqlfmt-corpus-separator --

SELECT * FROM num_ref_view

-- sqlfmt-corpus-separator --

SELECT * FROM o WHERE a < 3

-- sqlfmt-corpus-separator --

SELECT * FROM o WHERE a <= 4

-- sqlfmt-corpus-separator --

SELECT * FROM obits ORDER BY x

-- sqlfmt-corpus-separator --

SELECT * FROM obitsa

-- sqlfmt-corpus-separator --

SELECT * FROM onecolumn AS a, onecolumn AS b ORDER BY x

-- sqlfmt-corpus-separator --

SELECT * FROM other_db.information_schema.role_table_grants WHERE TABLE_SCHEMA = 'public'

-- sqlfmt-corpus-separator --

SELECT * FROM other_db.information_schema.statistics WHERE table_schema='public' AND table_name='teststatics' ORDER BY INDEX_SCHEMA,INDEX_NAME,SEQ_IN_INDEX

-- sqlfmt-corpus-separator --

SELECT * FROM other_db.information_schema.table_privileges WHERE TABLE_SCHEMA = 'public'

-- sqlfmt-corpus-separator --

SELECT * FROM other_db.information_schema.tables
WHERE table_catalog = 'other_db' AND table_schema = 'public'
ORDER BY table_name

-- sqlfmt-corpus-separator --

SELECT * FROM other_db.information_schema.tables WHERE table_catalog = 'other_db' AND table_schema = 'public' ORDER BY 1, 3

-- sqlfmt-corpus-separator --

SELECT * FROM other_log;

-- sqlfmt-corpus-separator --

SELECT * FROM other_table

-- sqlfmt-corpus-separator --

SELECT * FROM othertable

-- sqlfmt-corpus-separator --

SELECT * FROM outer_sd ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM outer_sd_sd;

-- sqlfmt-corpus-separator --

SELECT * FROM outer_sd_si;

-- sqlfmt-corpus-separator --

SELECT * FROM outer_si ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM outer_si_sd;

-- sqlfmt-corpus-separator --

SELECT * FROM outer_si_si;

-- sqlfmt-corpus-separator --

SELECT * FROM overwrite ORDER BY pk

-- sqlfmt-corpus-separator --

SELECT * FROM p WHERE f = 'NaN'

-- sqlfmt-corpus-separator --

SELECT * FROM pairs, square WHERE pairs.a + pairs.b = square.sq

-- sqlfmt-corpus-separator --

SELECT * FROM pairs, square WHERE pairs.b = square.n

-- sqlfmt-corpus-separator --

SELECT * FROM parent

-- sqlfmt-corpus-separator --

SELECT * FROM parent LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM parent p, child c WHERE c_id = 10 AND p_id = c_p_id

-- sqlfmt-corpus-separator --

SELECT * FROM parent p, child c WHERE p_id = c_p_id AND
p.crdb_region = c.crdb_region LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM parent p, child c WHERE p_id = c_p_id AND c_id = 10 LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM parent p, child c WHERE p_id = c_p_id AND c_id = 11 LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM parent p, child c WHERE p_id = c_p_id LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM parent p, child c WHERE p_id = c_p_id LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT * FROM parent p, child c WHERE p_id = c_p_id LIMIT 2;

-- sqlfmt-corpus-separator --

SELECT * FROM parent_150282;

-- sqlfmt-corpus-separator --

SELECT * FROM parent_151663 ORDER BY p

-- sqlfmt-corpus-separator --

SELECT * FROM parent_cascade;

-- sqlfmt-corpus-separator --

SELECT * FROM parent_multi

-- sqlfmt-corpus-separator --

SELECT * FROM perm_table ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM pg_cast
ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_attrdef WHERE (adnum = 1 AND adrelid = 1) OR (adbin = 'foo' AND adrelid = 2)

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_attribute;

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_cursors

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_event_trigger

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_extension

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_matviews

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_prepared_xacts

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_sequence

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_stat_activity

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_views

-- sqlfmt-corpus-separator --

SELECT * FROM pg_class

-- sqlfmt-corpus-separator --

SELECT * FROM pg_collation
WHERE collname='en-US'

-- sqlfmt-corpus-separator --

SELECT * FROM pg_enum

-- sqlfmt-corpus-separator --

SELECT * FROM pg_extension.geography_columns WHERE f_table_name = 'pg_extension_test'

-- sqlfmt-corpus-separator --

SELECT * FROM pg_extension.geometry_columns WHERE f_table_name = 'pg_extension_test'

-- sqlfmt-corpus-separator --

SELECT * FROM pg_language ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT * FROM pg_lsn_table ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM pg_lsn_table WHERE id = '10/10' ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM pg_lsn_table WHERE val = 'A01/A1000' ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM pg_seclabel

-- sqlfmt-corpus-separator --

SELECT * FROM pg_sequences WHERE sequencename = 'serial'

-- sqlfmt-corpus-separator --

SELECT * FROM pg_shadow ORDER BY usename;

-- sqlfmt-corpus-separator --

SELECT * FROM pg_temp.t

-- sqlfmt-corpus-separator --

SELECT * FROM pg_temp.table_a ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM pg_temp.temp_view

-- sqlfmt-corpus-separator --

SELECT * FROM pindex;

-- sqlfmt-corpus-separator --

SELECT * FROM pks

-- sqlfmt-corpus-separator --

SELECT * FROM policy_table;

-- sqlfmt-corpus-separator --

SELECT * FROM priv_t

-- sqlfmt-corpus-separator --

SELECT * FROM priv_test

-- sqlfmt-corpus-separator --

SELECT * FROM priv_v

-- sqlfmt-corpus-separator --

SELECT * FROM priv_v_definer ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM privatedb.privatetable

-- sqlfmt-corpus-separator --

SELECT * FROM privatedb.publictable

-- sqlfmt-corpus-separator --

SELECT * FROM privs.usage_tbl

-- sqlfmt-corpus-separator --

SELECT * FROM public.t

-- sqlfmt-corpus-separator --

SELECT * FROM public.table_a ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM public.test_table

-- sqlfmt-corpus-separator --

SELECT * FROM public_table

-- sqlfmt-corpus-separator --

SELECT * FROM publicdb.privatetable

-- sqlfmt-corpus-separator --

SELECT * FROM publicdb.publictable

-- sqlfmt-corpus-separator --

SELECT * FROM r1;

-- sqlfmt-corpus-separator --

SELECT * FROM regional_by_row_table ORDER BY pk

-- sqlfmt-corpus-separator --

SELECT * FROM regional_by_row_table;

-- sqlfmt-corpus-separator --

SELECT * FROM regional_by_row_table_as ORDER BY pk

-- sqlfmt-corpus-separator --

SELECT * FROM regression_46973 WHERE a != '23:59:59.999999'

-- sqlfmt-corpus-separator --

SELECT * FROM regression_46973 WHERE a != '24:00'

-- sqlfmt-corpus-separator --

SELECT * FROM regression_47030

-- sqlfmt-corpus-separator --

SELECT * FROM regression_71444 WHERE col = '{"a"}'

-- sqlfmt-corpus-separator --

SELECT * FROM replace

-- sqlfmt-corpus-separator --

SELECT * FROM restrict_sd ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM restrict_si ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM rls_cache_test ORDER BY c1;

-- sqlfmt-corpus-separator --

SELECT * FROM rls_default_view ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM rls_docs ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM rls_forced ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM rls_owned ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM rls_sd_view ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM rls_si_view ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM root_table

-- sqlfmt-corpus-separator --

SELECT * FROM runningOut

-- sqlfmt-corpus-separator --

SELECT * FROM s WHERE d = 'NaN'

-- sqlfmt-corpus-separator --

SELECT * FROM s WHERE d = 0

-- sqlfmt-corpus-separator --

SELECT * FROM s.q;

-- sqlfmt-corpus-separator --

SELECT * FROM s1.s

-- sqlfmt-corpus-separator --

SELECT * FROM s1.t

-- sqlfmt-corpus-separator --

SELECT * FROM s1.t2

-- sqlfmt-corpus-separator --

SELECT * FROM s1.t4

-- sqlfmt-corpus-separator --

SELECT * FROM s1.vx

-- sqlfmt-corpus-separator --

SELECT * FROM s2.s

-- sqlfmt-corpus-separator --

SELECT * FROM s2.t2

-- sqlfmt-corpus-separator --

SELECT * FROM s2.t3

-- sqlfmt-corpus-separator --

SELECT * FROM s2.t4

-- sqlfmt-corpus-separator --

SELECT * FROM s2.vx

-- sqlfmt-corpus-separator --

SELECT * FROM sc

-- sqlfmt-corpus-separator --

SELECT * FROM sc.xy;

-- sqlfmt-corpus-separator --

SELECT * FROM sc1.v_seq

-- sqlfmt-corpus-separator --

SELECT * FROM sc1.v_type

-- sqlfmt-corpus-separator --

SELECT * FROM sc1.xy;

-- sqlfmt-corpus-separator --

SELECT * FROM sc1_new.v_seq

-- sqlfmt-corpus-separator --

SELECT * FROM sc1_new.v_type

-- sqlfmt-corpus-separator --

SELECT * FROM sc2.v_seq

-- sqlfmt-corpus-separator --

SELECT * FROM sc2.v_type

-- sqlfmt-corpus-separator --

SELECT * FROM sd_view;

-- sqlfmt-corpus-separator --

SELECT * FROM select_test

-- sqlfmt-corpus-separator --

SELECT * FROM self

-- sqlfmt-corpus-separator --

SELECT * FROM self;

-- sqlfmt-corpus-separator --

SELECT * FROM self_ref_fk

-- sqlfmt-corpus-separator --

SELECT * FROM self_ref_fk;

-- sqlfmt-corpus-separator --

SELECT * FROM self_x2

-- sqlfmt-corpus-separator --

SELECT * FROM selfref;

-- sqlfmt-corpus-separator --

SELECT * FROM sensitive_data_table;

-- sqlfmt-corpus-separator --

SELECT * FROM ship

-- sqlfmt-corpus-separator --

SELECT * FROM shop

-- sqlfmt-corpus-separator --

SELECT * FROM shopping

-- sqlfmt-corpus-separator --

SELECT * FROM si_view;

-- sqlfmt-corpus-separator --

SELECT * FROM smtng.something ORDER BY 1 LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM smtng.something;

-- sqlfmt-corpus-separator --

SELECT * FROM something LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM st_scan_4 ORDER BY key

-- sqlfmt-corpus-separator --

SELECT * FROM st_test_merge_join_2 ORDER BY k

-- sqlfmt-corpus-separator --

SELECT * FROM stock

-- sqlfmt-corpus-separator --

SELECT * FROM store ORDER BY baz, extra

-- sqlfmt-corpus-separator --

SELECT * FROM stored1 ORDER BY A;

-- sqlfmt-corpus-separator --

SELECT * FROM student

-- sqlfmt-corpus-separator --

SELECT * FROM sums

-- sqlfmt-corpus-separator --

SELECT * FROM system.descriptor;

-- sqlfmt-corpus-separator --

SELECT * FROM system.information_schema.column_privileges WHERE table_name = 'eventlog'

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

SELECT * FROM system.namespace LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM system.prepared_transactions

-- sqlfmt-corpus-separator --

SELECT * FROM system.role_members

-- sqlfmt-corpus-separator --

SELECT * FROM system.users WHERE username = 'testuser'

-- sqlfmt-corpus-separator --

SELECT * FROM t

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY 'a'

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY 0

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY 2.5

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY a, b, c

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY d

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY foo

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY k;

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY pk

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY true

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY v, w LIMIT 3;

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY x

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE (d = d) OR (d = d)

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE EXISTS(SELECT * FROM xy WHERE x=t.k)

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE crdb_internal_idx_expr > 0

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE k < 10 OR (k > 20 AND k < 29) OR k > 40

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE k = 1

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE k = 2

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE k >= 1 LIMIT 10

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE k >= 3 AND k < 5

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE t.crdb_internal_idx_expr > 0

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE v = 9

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE v > -20 AND w > 30 ORDER BY v LIMIT 2

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE y < z

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE y = 20 AND 'a' ~ '(';

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE y = 20 AND y/0 = 0;

-- sqlfmt-corpus-separator --

SELECT * FROM t0 WHERE t0.c0 AND (c1 OR (c0 > false AND c0 < false))

-- sqlfmt-corpus-separator --

SELECT * FROM t1

-- sqlfmt-corpus-separator --

SELECT * FROM t1 ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM t1 WHERE a=1;

-- sqlfmt-corpus-separator --

SELECT * FROM t1 WHERE a=2;

-- sqlfmt-corpus-separator --

SELECT * FROM t1 WHERE a=3;

-- sqlfmt-corpus-separator --

SELECT * FROM t101356 WHERE i1 = 1

-- sqlfmt-corpus-separator --

SELECT * FROM t114826;

-- sqlfmt-corpus-separator --

SELECT * FROM t118273;

-- sqlfmt-corpus-separator --

SELECT * FROM t122278;

-- sqlfmt-corpus-separator --

SELECT * FROM t133146

-- sqlfmt-corpus-separator --

SELECT * FROM t133146b

-- sqlfmt-corpus-separator --

SELECT * FROM t145232 WHERE k = 2

-- sqlfmt-corpus-separator --

SELECT * FROM t146637 WHERE (a = 0 OR a = 100) AND b = 'foo' ORDER BY a DESC LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT * FROM t154461 WHERE a != 'g' ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM t158154

-- sqlfmt-corpus-separator --

SELECT * FROM t1;

-- sqlfmt-corpus-separator --

SELECT * FROM t1_with_composite ORDER BY i ASC;

-- sqlfmt-corpus-separator --

SELECT * FROM t2

-- sqlfmt-corpus-separator --

SELECT * FROM t2 ORDER BY d

-- sqlfmt-corpus-separator --

SELECT * FROM t2 WHERE d = '-Infinity' and v = '-Infinity'

-- sqlfmt-corpus-separator --

SELECT * FROM t2 WHERE d = 'Infinity' and v = 'Infinity'

-- sqlfmt-corpus-separator --

SELECT * FROM t2;

-- sqlfmt-corpus-separator --

SELECT * FROM t3 ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM t32054

-- sqlfmt-corpus-separator --

SELECT * FROM t34901

-- sqlfmt-corpus-separator --

SELECT * FROM t35364

-- sqlfmt-corpus-separator --

SELECT * FROM t38753 ORDER BY y;

-- sqlfmt-corpus-separator --

SELECT * FROM t38754

-- sqlfmt-corpus-separator --

SELECT * FROM t38878 WHERE (k1 = 'd' AND k2 = 'x') OR k1 = 'b' OR (k1 > 'b' AND k1 < 'd')

-- sqlfmt-corpus-separator --

SELECT * FROM t38878 WHERE k1 = 'b' OR (k1 > 'b' AND k1 < 'd')

-- sqlfmt-corpus-separator --

SELECT * FROM t4

-- sqlfmt-corpus-separator --

SELECT * FROM t44132 WHERE c0

-- sqlfmt-corpus-separator --

SELECT * FROM t44797_2 WHERE EXISTS (SELECT * FROM t44797_2 AS l, t44797_3 AS r WHERE l.a = r.b)

-- sqlfmt-corpus-separator --

SELECT * FROM t46714_0 ORDER BY c0 + c0

-- sqlfmt-corpus-separator --

SELECT * FROM t5

-- sqlfmt-corpus-separator --

SELECT * FROM t5 ORDER BY x

-- sqlfmt-corpus-separator --

SELECT * FROM t52318 WHERE b > 5

-- sqlfmt-corpus-separator --

SELECT * FROM t55837 -- make sure that the range cache is populated

-- sqlfmt-corpus-separator --

SELECT * FROM t57108_v

-- sqlfmt-corpus-separator --

SELECT * FROM t65171 WHERE x = 1 OFFSET 1 LIMIT 9223372036854775807

-- sqlfmt-corpus-separator --

SELECT * FROM t65171 WHERE x = 1 OR x = 2 ORDER BY y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT * FROM t69327

-- sqlfmt-corpus-separator --

SELECT * FROM t71553

-- sqlfmt-corpus-separator --

SELECT * FROM t73024

-- sqlfmt-corpus-separator --

SELECT * FROM t73372

-- sqlfmt-corpus-separator --

SELECT * FROM t81315 WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT * FROM t88047
WHERE json_col->'loc' @> '{"state":"NY"}'
ORDER BY 2
LIMIT 2

-- sqlfmt-corpus-separator --

SELECT * FROM t91817a

-- sqlfmt-corpus-separator --

SELECT * FROM t95360

-- sqlfmt-corpus-separator --

SELECT * FROM t97090 WHERE l = 1 AND r = -1

-- sqlfmt-corpus-separator --

SELECT * FROM t;

-- sqlfmt-corpus-separator --

SELECT * FROM t_42816 ORDER BY a OFFSET 1020 LIMIT 10

-- sqlfmt-corpus-separator --

SELECT * FROM t_53504

-- sqlfmt-corpus-separator --

SELECT * FROM t_65915;

-- sqlfmt-corpus-separator --

SELECT * FROM t_93398;

-- sqlfmt-corpus-separator --

SELECT * FROM t_99035

-- sqlfmt-corpus-separator --

SELECT * FROM t_add_generated ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM t_alter;

-- sqlfmt-corpus-separator --

SELECT * FROM t_alter_invalid

-- sqlfmt-corpus-separator --

SELECT * FROM t_alter_type

-- sqlfmt-corpus-separator --

SELECT * FROM t_autocommit_rb;

-- sqlfmt-corpus-separator --

SELECT * FROM t_autocommit_rb_tbl;

-- sqlfmt-corpus-separator --

SELECT * FROM t_autocommit_test;

-- sqlfmt-corpus-separator --

SELECT * FROM t_bytes ORDER BY c1;

-- sqlfmt-corpus-separator --

SELECT * FROM t_case_null WHERE NULL AND NULL

-- sqlfmt-corpus-separator --

SELECT * FROM t_case_null WHERE NULL AND x = 0

-- sqlfmt-corpus-separator --

SELECT * FROM t_case_null WHERE x = 0 AND NULL

-- sqlfmt-corpus-separator --

SELECT * FROM t_check

-- sqlfmt-corpus-separator --

SELECT * FROM t_committed;

-- sqlfmt-corpus-separator --

SELECT * FROM t_computed;

-- sqlfmt-corpus-separator --

SELECT * FROM t_decimal ORDER BY c1;

-- sqlfmt-corpus-separator --

SELECT * FROM t_defaults

-- sqlfmt-corpus-separator --

SELECT * FROM t_disallow_scans

-- sqlfmt-corpus-separator --

SELECT * FROM t_divzero_virtual

-- sqlfmt-corpus-separator --

SELECT * FROM t_dml_ddl_new;

-- sqlfmt-corpus-separator --

SELECT * FROM t_dml_rollback_check;

-- sqlfmt-corpus-separator --

SELECT * FROM t_ephemeral;

-- sqlfmt-corpus-separator --

SELECT * FROM t_error_test;

-- sqlfmt-corpus-separator --

SELECT * FROM t_idempotent;

-- sqlfmt-corpus-separator --

SELECT * FROM t_idx

-- sqlfmt-corpus-separator --

SELECT * FROM t_in_exc_block;

-- sqlfmt-corpus-separator --

SELECT * FROM t_index WHERE path <@ 'a.b' ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM t_many;

-- sqlfmt-corpus-separator --

SELECT * FROM t_multi_fn ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT * FROM t_nested_inner;

-- sqlfmt-corpus-separator --

SELECT * FROM t_ocdn

-- sqlfmt-corpus-separator --

SELECT * FROM t_ocdn;

-- sqlfmt-corpus-separator --

SELECT * FROM t_overflow_virtual

-- sqlfmt-corpus-separator --

SELECT * FROM t_pre_commit;

-- sqlfmt-corpus-separator --

SELECT * FROM t_pre_rollback;

-- sqlfmt-corpus-separator --

SELECT * FROM t_proc_created;

-- sqlfmt-corpus-separator --

SELECT * FROM t_rc_explicit;

-- sqlfmt-corpus-separator --

SELECT * FROM t_rename_computed;

-- sqlfmt-corpus-separator --

SELECT * FROM t_rollback_test;

-- sqlfmt-corpus-separator --

SELECT * FROM t_rr_rb;

-- sqlfmt-corpus-separator --

SELECT * FROM t_schema

-- sqlfmt-corpus-separator --

SELECT * FROM t_set_generated ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM t_txn_rollback;

-- sqlfmt-corpus-separator --

SELECT * FROM t_udf_enum_virtual

-- sqlfmt-corpus-separator --

SELECT * FROM t_udf_virtual

-- sqlfmt-corpus-separator --

SELECT * FROM t_udf_virtual WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT * FROM t_udf_virtual WHERE v = 40

-- sqlfmt-corpus-separator --

SELECT * FROM t_uncommitted_ddl;

-- sqlfmt-corpus-separator --

SELECT * FROM t_upsert

-- sqlfmt-corpus-separator --

SELECT * FROM t_with_default ORDER BY c1

-- sqlfmt-corpus-separator --

SELECT * FROM t_with_hidden ORDER BY vis1

-- sqlfmt-corpus-separator --

SELECT * FROM target

-- sqlfmt-corpus-separator --

SELECT * FROM tb

-- sqlfmt-corpus-separator --

SELECT * FROM tb2

-- sqlfmt-corpus-separator --

SELECT * FROM tbl

-- sqlfmt-corpus-separator --

SELECT * FROM tbl_in_txn

-- sqlfmt-corpus-separator --

SELECT * FROM tbl_with_dft_column_family ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM tdup

-- sqlfmt-corpus-separator --

SELECT * FROM team ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM temp;

-- sqlfmt-corpus-separator --

SELECT * FROM test.cutlery

-- sqlfmt-corpus-separator --

SELECT * FROM test.empty

-- sqlfmt-corpus-separator --

SELECT * FROM test.test_retry

-- sqlfmt-corpus-separator --

SELECT * FROM test.v

-- sqlfmt-corpus-separator --

SELECT * FROM test.v1

-- sqlfmt-corpus-separator --

SELECT * FROM test.v2

-- sqlfmt-corpus-separator --

SELECT * FROM test.v6

-- sqlfmt-corpus-separator --

SELECT * FROM test.v7

-- sqlfmt-corpus-separator --

SELECT * FROM test.v7 ORDER BY x LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM test1;

-- sqlfmt-corpus-separator --

SELECT * FROM test2.information_schema.columns

-- sqlfmt-corpus-separator --

SELECT * FROM test2.v1

-- sqlfmt-corpus-separator --

SELECT * FROM test_49144 WHERE ("test_49144"."value" -> 'c') > '2' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM test_49144 WHERE ("test_49144"."value" -> 'c') > '2.33' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM test_backfill ORDER BY x

-- sqlfmt-corpus-separator --

SELECT * FROM test_table

-- sqlfmt-corpus-separator --

SELECT * FROM test_table
ORDER BY col1

-- sqlfmt-corpus-separator --

SELECT * FROM testdb.foo

-- sqlfmt-corpus-separator --

SELECT * FROM testing

-- sqlfmt-corpus-separator --

SELECT * FROM testuser.test_table

-- sqlfmt-corpus-separator --

SELECT * FROM testuser_table

-- sqlfmt-corpus-separator --

SELECT * FROM time_precision_test ORDER BY id ASC

-- sqlfmt-corpus-separator --

SELECT * FROM times ORDER BY t

-- sqlfmt-corpus-separator --

SELECT * FROM timestamp_test ORDER BY id ASC

-- sqlfmt-corpus-separator --

SELECT * FROM timestamps ORDER BY s

-- sqlfmt-corpus-separator --

SELECT * FROM timetz_precision_test ORDER BY id ASC

-- sqlfmt-corpus-separator --

SELECT * FROM timetzs ORDER BY t

-- sqlfmt-corpus-separator --

SELECT * FROM toggle_view ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM top_secret_data;

-- sqlfmt-corpus-separator --

SELECT * FROM trigger_rls_table ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM trigger_rls_table WHERE id = 10;

-- sqlfmt-corpus-separator --

SELECT * FROM trigger_rls_table WHERE owner = 'alice' ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM tt

-- sqlfmt-corpus-separator --

SELECT * FROM tu

-- sqlfmt-corpus-separator --

SELECT * FROM tview

-- sqlfmt-corpus-separator --

SELECT * FROM txn_fingerprint_view ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM txn_test

-- sqlfmt-corpus-separator --

SELECT * FROM tzarrays

-- sqlfmt-corpus-separator --

SELECT * FROM u

-- sqlfmt-corpus-separator --

SELECT * FROM u ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM u ORDER BY ip

-- sqlfmt-corpus-separator --

SELECT * FROM u ORDER BY token

-- sqlfmt-corpus-separator --

SELECT * FROM u_a

-- sqlfmt-corpus-separator --

SELECT * FROM u_a;

-- sqlfmt-corpus-separator --

SELECT * FROM u_b;

-- sqlfmt-corpus-separator --

SELECT * FROM u_c;

-- sqlfmt-corpus-separator --

SELECT * FROM ud_sd_view ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM ud_si_view ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT * FROM unindexed

-- sqlfmt-corpus-separator --

SELECT * FROM unindexed;

-- sqlfmt-corpus-separator --

SELECT * FROM unionstock

-- sqlfmt-corpus-separator --

SELECT * FROM unionstock ORDER BY quantity

-- sqlfmt-corpus-separator --

SELECT * FROM unionstock ORDER BY quantity LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM uniq

-- sqlfmt-corpus-separator --

SELECT * FROM uniq_computed_pk

-- sqlfmt-corpus-separator --

SELECT * FROM uniq_enum

-- sqlfmt-corpus-separator --

SELECT * FROM uniq_fk_child

-- sqlfmt-corpus-separator --

SELECT * FROM uniq_hidden_pk

-- sqlfmt-corpus-separator --

SELECT * FROM uniq_no_index

-- sqlfmt-corpus-separator --

SELECT * FROM uniq_overlaps_pk

-- sqlfmt-corpus-separator --

SELECT * FROM uniq_partial

-- sqlfmt-corpus-separator --

SELECT * FROM uniq_partial_index_and_constraint

-- sqlfmt-corpus-separator --

SELECT * FROM uniq_partial_pk

-- sqlfmt-corpus-separator --

SELECT * FROM uniq_simple

-- sqlfmt-corpus-separator --

SELECT * FROM unknown_table;

-- sqlfmt-corpus-separator --

SELECT * FROM unrelated

-- sqlfmt-corpus-separator --

SELECT * FROM unsorted_colids

-- sqlfmt-corpus-separator --

SELECT * FROM untyped

-- sqlfmt-corpus-separator --

SELECT * FROM update_cascade_test ORDER BY update_cascade;

-- sqlfmt-corpus-separator --

SELECT * FROM update_test WHERE j @> '"shortValue"';

-- sqlfmt-corpus-separator --

SELECT * FROM update_test WHERE j @> '0';

-- sqlfmt-corpus-separator --

SELECT * FROM update_test WHERE j @> '["a"]' ORDER BY i;

-- sqlfmt-corpus-separator --

SELECT * FROM update_test WHERE j @> '["b"]' ORDER BY i;

-- sqlfmt-corpus-separator --

SELECT * FROM update_test WHERE j @> '["c"]' ORDER BY i;

-- sqlfmt-corpus-separator --

SELECT * FROM update_test WHERE j @> '{"a":"b"}';

-- sqlfmt-corpus-separator --

SELECT * FROM update_test WHERE j @> '{"longKey1":"longValue1"}';

-- sqlfmt-corpus-separator --

SELECT * FROM update_test WHERE j @> '{"longKey2":"longValue2"}';

-- sqlfmt-corpus-separator --

SELECT * FROM users

-- sqlfmt-corpus-separator --

SELECT * FROM users ORDER BY id ASC

-- sqlfmt-corpus-separator --

SELECT * FROM uvw ORDER BY u, v, w

-- sqlfmt-corpus-separator --

SELECT * FROM v

-- sqlfmt-corpus-separator --

SELECT * FROM v ORDER BY x, y;

-- sqlfmt-corpus-separator --

SELECT * FROM v WHERE v = '[1,2]'

-- sqlfmt-corpus-separator --

SELECT * FROM v0 ORDER BY c0;

-- sqlfmt-corpus-separator --

SELECT * FROM v0;

-- sqlfmt-corpus-separator --

SELECT * FROM v1

-- sqlfmt-corpus-separator --

SELECT * FROM v10

-- sqlfmt-corpus-separator --

SELECT * FROM v104927

-- sqlfmt-corpus-separator --

SELECT * FROM v11

-- sqlfmt-corpus-separator --

SELECT * FROM v12

-- sqlfmt-corpus-separator --

SELECT * FROM v13 ORDER BY k

-- sqlfmt-corpus-separator --

SELECT * FROM v14

-- sqlfmt-corpus-separator --

SELECT * FROM v15

-- sqlfmt-corpus-separator --

SELECT * FROM v1Dep;

-- sqlfmt-corpus-separator --

SELECT * FROM v2

-- sqlfmt-corpus-separator --

SELECT * FROM v2 ORDER BY x DESC LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM v2 WHERE v = '[1,2]'

-- sqlfmt-corpus-separator --

SELECT * FROM v2Dep;

-- sqlfmt-corpus-separator --

SELECT * FROM v3 ORDER BY nextval

-- sqlfmt-corpus-separator --

SELECT * FROM v3Dep;

-- sqlfmt-corpus-separator --

SELECT * FROM v46981_0 WHERE '' !~ '+'

-- sqlfmt-corpus-separator --

SELECT * FROM v47704

-- sqlfmt-corpus-separator --

SELECT * FROM v4Dep;

-- sqlfmt-corpus-separator --

SELECT * FROM v6

-- sqlfmt-corpus-separator --

SELECT * FROM v7

-- sqlfmt-corpus-separator --

SELECT * FROM v7 ORDER BY x LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM v;

-- sqlfmt-corpus-separator --

SELECT * FROM v_builtin ORDER BY 1;

-- sqlfmt-corpus-separator --

SELECT * FROM v_engineering

-- sqlfmt-corpus-separator --

SELECT * FROM v_nested_1_1

-- sqlfmt-corpus-separator --

SELECT * FROM v_nested_1_1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM v_nested_1_2

-- sqlfmt-corpus-separator --

SELECT * FROM v_nested_1_2 ORDER BY x

-- sqlfmt-corpus-separator --

SELECT * FROM v_nested_2_1

-- sqlfmt-corpus-separator --

SELECT * FROM v_nested_2_1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM v_nested_2_2

-- sqlfmt-corpus-separator --

SELECT * FROM v_nested_2_2 ORDER BY x

-- sqlfmt-corpus-separator --

SELECT * FROM v_seq_rewrite

-- sqlfmt-corpus-separator --

SELECT * FROM v_seq_rewrite_quoted

-- sqlfmt-corpus-separator --

SELECT * FROM v_top_level

-- sqlfmt-corpus-separator --

SELECT * FROM v_vop

-- sqlfmt-corpus-separator --

SELECT * FROM v_vop ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM v_vop;

-- sqlfmt-corpus-separator --

SELECT * FROM v_vop_nested

-- sqlfmt-corpus-separator --

SELECT * FROM v_vop_nested ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM v_with_functions

-- sqlfmt-corpus-separator --

SELECT * FROM view_from_seq

-- sqlfmt-corpus-separator --

SELECT * FROM view_rls_t;

-- sqlfmt-corpus-separator --

SELECT * FROM view_rls_v;

-- sqlfmt-corpus-separator --

SELECT * FROM virt2 ORDER BY c1;

-- sqlfmt-corpus-separator --

SELECT * FROM virt3 ORDER BY c1;

-- sqlfmt-corpus-separator --

SELECT * FROM vo_sd_view;

-- sqlfmt-corpus-separator --

SELECT * FROM vo_si_view;

-- sqlfmt-corpus-separator --

SELECT * FROM voyage ORDER BY hero, crew, quest

-- sqlfmt-corpus-separator --

SELECT * FROM vregclass

-- sqlfmt-corpus-separator --

SELECT * FROM want

-- sqlfmt-corpus-separator --

SELECT * FROM wide

-- sqlfmt-corpus-separator --

SELECT * FROM with_options

-- sqlfmt-corpus-separator --

SELECT * FROM x

-- sqlfmt-corpus-separator --

SELECT * FROM x ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM xy ORDER BY x

-- sqlfmt-corpus-separator --

SELECT * FROM xy WHERE x > y

-- sqlfmt-corpus-separator --

SELECT * FROM xy;

-- sqlfmt-corpus-separator --

SELECT * FROM xy_158154;

-- sqlfmt-corpus-separator --

SELECT * FROM xyz

-- sqlfmt-corpus-separator --

SELECT * FROM xyz ORDER BY x

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT -100

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT 0

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT 3.3

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT 9223372036854775808

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT x

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw OFFSET -100

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw OFFSET 1 + y

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw OFFSET 1.5

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw OFFSET 9223372036854775808

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY 1 LIMIT '1'

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY x LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY x LIMIT 1 OFFSET 1

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY x OFFSET 1 + 0.0

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY y OFFSET 1

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY y OFFSET 1 LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM z

-- sqlfmt-corpus-separator --

SELECT * from a;

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

SELECT * from abcd WHERE a > 1

-- sqlfmt-corpus-separator --

SELECT * from add_default WHERE a=5

-- sqlfmt-corpus-separator --

SELECT * from arr_t4

-- sqlfmt-corpus-separator --

SELECT * from arr_t5

-- sqlfmt-corpus-separator --

SELECT * from c;

-- sqlfmt-corpus-separator --

SELECT * from d where b @> '["d", {"a": {"b": [1]}}]'

-- sqlfmt-corpus-separator --

SELECT * from d where b @> '["d", {"a": {"b": [[2]]}}]'

-- sqlfmt-corpus-separator --

SELECT * from d where b @> '[{"a": {"b": [[2]]}}, "d"]'

-- sqlfmt-corpus-separator --

SELECT * from d where b @> '{"a": "b", "c": "e"}'

-- sqlfmt-corpus-separator --

SELECT * from d where b @> '{"a": "e", "c": "d"}'

-- sqlfmt-corpus-separator --

SELECT * from d where b @> '{"a": {"b": "c", "d": "e"}, "f": "g"}'

-- sqlfmt-corpus-separator --

SELECT * from d where b @> '{"a": {"b": "c"}, "f": "g"}'

-- sqlfmt-corpus-separator --

SELECT * from d where b @> '{"c": "d", "a": "b", "f": "g"}'

-- sqlfmt-corpus-separator --

SELECT * from d where b @> '{"c": "d", "a": "b"}'

-- sqlfmt-corpus-separator --

SELECT * from db1.sc1.sq1

-- sqlfmt-corpus-separator --

SELECT * from db1.sc1.t1

-- sqlfmt-corpus-separator --

SELECT * from db1.sc1.v1

-- sqlfmt-corpus-separator --

SELECT * from def_assn_cast

-- sqlfmt-corpus-separator --

SELECT * from default_err_test ORDER BY foo

-- sqlfmt-corpus-separator --

SELECT * from enum_ctas

-- sqlfmt-corpus-separator --

SELECT * from ex ORDER BY foo

-- sqlfmt-corpus-separator --

SELECT * from fam

-- sqlfmt-corpus-separator --

SELECT * from foo where bar->'x' = '[1]'

-- sqlfmt-corpus-separator --

SELECT * from foo where bar->'x' = '{}'

-- sqlfmt-corpus-separator --

SELECT * from kv4

-- sqlfmt-corpus-separator --

SELECT * from kv; ROLLBACK

-- sqlfmt-corpus-separator --

SELECT * from mv2

-- sqlfmt-corpus-separator --

SELECT * from no_unique ORDER BY a, b

-- sqlfmt-corpus-separator --

SELECT * from pg_catalog.pg_range

-- sqlfmt-corpus-separator --

SELECT * from pg_temp.upgrade_temp_view

-- sqlfmt-corpus-separator --

SELECT * from pg_temp.view_on_permanent

-- sqlfmt-corpus-separator --

SELECT * from pg_temp.view_on_temp

-- sqlfmt-corpus-separator --

SELECT * from pg_timezone_names WHERE name = 'DoesNotExist'

-- sqlfmt-corpus-separator --

SELECT * from pg_timezone_names WHERE name = 'Pacific/Honolulu'

-- sqlfmt-corpus-separator --

SELECT * from system.role_members

-- sqlfmt-corpus-separator --

SELECT * from t

-- sqlfmt-corpus-separator --

SELECT * from t ORDER BY b DESC

-- sqlfmt-corpus-separator --

SELECT * from t3

-- sqlfmt-corpus-separator --

SELECT * from table38627

-- sqlfmt-corpus-separator --

SELECT * from upd_assn_cast

-- sqlfmt-corpus-separator --

SELECT * from v

-- sqlfmt-corpus-separator --

SELECT * from virt1 ORDER BY c1;

-- sqlfmt-corpus-separator --

SELECT * from x

-- sqlfmt-corpus-separator --

SELECT * from xyz

-- sqlfmt-corpus-separator --

SELECT *, "from", kw."from" FROM kw

-- sqlfmt-corpus-separator --

SELECT *, bar FROM nullable;

-- sqlfmt-corpus-separator --

SELECT *,* FROM abc

-- sqlfmt-corpus-separator --

SELECT -0.1234567890123456, 123456789012345.6, 1234567.890123456

-- sqlfmt-corpus-separator --

SELECT 0

-- sqlfmt-corpus-separator --

SELECT 0 * b, b % 1, 0 % b from abc

-- sqlfmt-corpus-separator --

SELECT 0, 1 + 2, 3 * 4 FROM a HAVING true

-- sqlfmt-corpus-separator --

SELECT 1

-- sqlfmt-corpus-separator --

SELECT 1 + (SELECT 1 AS a, 2 AS b)

-- sqlfmt-corpus-separator --

SELECT 1 + (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 + 2

-- sqlfmt-corpus-separator --

SELECT 1 << -1

-- sqlfmt-corpus-separator --

SELECT 1 << 63 >> 63, 1 << 62 >> 62

-- sqlfmt-corpus-separator --

SELECT 1 << 64

-- sqlfmt-corpus-separator --

SELECT 1 >> -1

-- sqlfmt-corpus-separator --

SELECT 1 >> 64

-- sqlfmt-corpus-separator --

SELECT 1 FROM kv GROUP BY v

-- sqlfmt-corpus-separator --

SELECT 1 FROM parent WHERE key = 3;

-- sqlfmt-corpus-separator --

SELECT 1 FROM t46714_0, t46714_1 GROUP BY t46714_0.c0 * t46714_1.c0

-- sqlfmt-corpus-separator --

SELECT 1 GROUP BY 'a'

-- sqlfmt-corpus-separator --

SELECT 1+1 AS two, 2+2 AS four

-- sqlfmt-corpus-separator --

SELECT 1, * FROM nocols

-- sqlfmt-corpus-separator --

SELECT 1,2

-- sqlfmt-corpus-separator --

SELECT 1.0 / 'Infinity' + 2 FROM a;

-- sqlfmt-corpus-separator --

SELECT 1/0

-- sqlfmt-corpus-separator --

SELECT 123, '123', 123.0, TRUE, FALSE, NULL

-- sqlfmt-corpus-separator --

SELECT 1;

-- sqlfmt-corpus-separator --

SELECT 1; DECLARE foo CURSOR FOR SELECT * FROM a

-- sqlfmt-corpus-separator --

SELECT 2

-- sqlfmt-corpus-separator --

SELECT 2 + _inet FROM many_types

-- sqlfmt-corpus-separator --

SELECT 2.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

-- sqlfmt-corpus-separator --

SELECT 2/0;

-- sqlfmt-corpus-separator --

SELECT 3 FROM kv GROUP BY k HAVING v > 2

-- sqlfmt-corpus-separator --

SELECT 3 FROM kv GROUP BY v HAVING k > 5

-- sqlfmt-corpus-separator --

SELECT 3 FROM kv HAVING TRUE

-- sqlfmt-corpus-separator --

SELECT 42, * FROM kv

-- sqlfmt-corpus-separator --

SELECT 42, * FROM t

-- sqlfmt-corpus-separator --

SELECT 42, x FROM t

-- sqlfmt-corpus-separator --

SELECT 5 - a FROM a ORDER BY 1 DESC LIMIT 3

-- sqlfmt-corpus-separator --

SELECT 5, 2 + y, * FROM NumToStr WHERE y % 1000 = 0 ORDER BY str

-- sqlfmt-corpus-separator --

SELECT 5, 2+y, * FROM NumToStr WHERE y <= 10 ORDER BY str

-- sqlfmt-corpus-separator --

SELECT 5, a FROM a ORDER BY 2 LIMIT 3

-- sqlfmt-corpus-separator --

SELECT COMMENT FROM system.comments WHERE type = 4;

-- sqlfmt-corpus-separator --

SELECT DISTINCT (a) FROM data

-- sqlfmt-corpus-separator --

SELECT DISTINCT (x) FROM t

-- sqlfmt-corpus-separator --

SELECT DISTINCT * FROM t44079

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

SELECT DISTINCT ON(((x)), (x, y)) x, y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(max(x)) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(pk1, pk2, x, y) x, y, z FROM xyz ORDER BY x, y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(x) x AS y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT _int FROM t88110 WHERE NOT _bool;

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

SELECT FOO.k FROM kv AS foo WHERE foo.k = 'a'

-- sqlfmt-corpus-separator --

SELECT FROM abc

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 nanosecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 ns';

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

SELECT INTERVAL '10000000000000000000000000000000000 year'

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

SELECT IS_UPDATABLE, IS_INSERTABLE_INTO, IS_TRIGGER_UPDATABLE, IS_TRIGGER_DELETABLE, IS_TRIGGER_INSERTABLE_INTO
FROM other_db.information_schema.views
WHERE TABLE_NAME='v_xyz'

-- sqlfmt-corpus-separator --

SELECT NAME from crdb_internal.tables WHERE DATABASE_NAME = 'testdb'

-- sqlfmt-corpus-separator --

SELECT NULL

-- sqlfmt-corpus-separator --

SELECT NULL AS z, * FROM abc

-- sqlfmt-corpus-separator --

SELECT NULL || 'asdf', 'asdf' || NULL

-- sqlfmt-corpus-separator --

SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, VIEW_DEFINITION, CHECK_OPTION
FROM other_db.information_schema.views
WHERE TABLE_NAME='v_xyz'

-- sqlfmt-corpus-separator --

SELECT Y FROM foo

-- sqlfmt-corpus-separator --

SELECT _bytes || _bytes FROM many_types

-- sqlfmt-corpus-separator --

SELECT _date + 1 FROM t WHERE key = 'max'

-- sqlfmt-corpus-separator --

SELECT _date - 1 FROM t WHERE key = 'min'

-- sqlfmt-corpus-separator --

SELECT _date, _date + 1 FROM t WHERE key = 'min'

-- sqlfmt-corpus-separator --

SELECT _date, _date + 1, _date - 1 FROM t WHERE key = '+inf'

-- sqlfmt-corpus-separator --

SELECT _date, _date + 1, _date - 1 FROM t WHERE key = '-inf'

-- sqlfmt-corpus-separator --

SELECT _date, _date - 1 FROM t WHERE key = 'max'

-- sqlfmt-corpus-separator --

SELECT _float8 + 1e300 FROM t WHERE key = 'max'

-- sqlfmt-corpus-separator --

SELECT _float8 - 1e300 FROM t WHERE key = 'min'

-- sqlfmt-corpus-separator --

SELECT _float^_float FROM many_types

-- sqlfmt-corpus-separator --

SELECT _inet & _inet FROM many_types

-- sqlfmt-corpus-separator --

SELECT _inet - 1 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _inet - _int2 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _int << -10 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _int << 64 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _int >> 63 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _int, _int2, _int // _int2 FROM many_types WHERE _int2 <> 0

-- sqlfmt-corpus-separator --

SELECT _int2 * _int2 FROM ints WHERE _int4 + _int4 = _int8 + 2

-- sqlfmt-corpus-separator --

SELECT _int2 >> 1 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _int2^_int FROM many_types WHERE _int2 < 10 AND _int < 10

-- sqlfmt-corpus-separator --

SELECT _int2^_int2 FROM many_types WHERE _int2 < 10

-- sqlfmt-corpus-separator --

SELECT _int2^_int4 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _int4 + _inet FROM many_types

-- sqlfmt-corpus-separator --

SELECT _int4 >> 3 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _int^_decimal FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json #> '{2,a}' #>> _stringarray, _json #> '{2,a}' #>> '{1,b}' FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json #> '{c}' #>> '{d}' FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json #> '{}' FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json #> _stringarray #> '{1,b}', _json #> '{2,a}' #> '{1,b}' FROM many_types ORDER BY _int

-- sqlfmt-corpus-separator --

SELECT _json #> _stringarray #> '{d}', _json #> '{c}' #> '{d}' FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json #> _stringarray, _json #> '{2,a}' FROM many_types ORDER BY _int

-- sqlfmt-corpus-separator --

SELECT _json #>> '{}' FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json #>> _stringarray, _json #>> '{2,a}' FROM many_types ORDER BY _int

-- sqlfmt-corpus-separator --

SELECT _json - _int FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json -> 2 -> 'a' FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json -> 2 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json -> 5  = '1' FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json -> _int -> 'a' = '["foo", {"b": 3}]' FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json -> _int FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json -> _int2 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json -> _int4 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _json || _json FROM many_types

-- sqlfmt-corpus-separator --

SELECT _string || _string FROM many_types

-- sqlfmt-corpus-separator --

SELECT _time + _interval FROM many_types

-- sqlfmt-corpus-separator --

SELECT _varbit << 1 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _varbit << 3 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _varbit >> 1 FROM many_types

-- sqlfmt-corpus-separator --

SELECT _varbit || _varbit FROM many_types

-- sqlfmt-corpus-separator --

SELECT a <> 2 AND 3 / b = 1 FROM t ORDER BY k

-- sqlfmt-corpus-separator --

SELECT a = '1234' FROM t_oid_cmp

-- sqlfmt-corpus-separator --

SELECT a = '{0}' FROM t_oidarr

-- sqlfmt-corpus-separator --

SELECT a = 2 OR 3 / b = 1 FROM t ORDER BY k

-- sqlfmt-corpus-separator --

SELECT a @@ 'fat cats ate fat bats' FROM ab

-- sqlfmt-corpus-separator --

SELECT a @@ b FROM ab

-- sqlfmt-corpus-separator --

SELECT a AS "foo.bar", b FROM t ORDER BY "foo.bar" DESC

-- sqlfmt-corpus-separator --

SELECT a AS foo, (a) AS foo FROM t ORDER BY foo LIMIT 1

-- sqlfmt-corpus-separator --

SELECT a AS foo, b AS foo FROM t ORDER BY foo

-- sqlfmt-corpus-separator --

SELECT a AS foo, b FROM t ORDER BY a DESC

-- sqlfmt-corpus-separator --

SELECT a AS foo, b FROM t ORDER BY foo DESC

-- sqlfmt-corpus-separator --

SELECT a FROM MaxIntTest WHERE a = 9223372036854775807

-- sqlfmt-corpus-separator --

SELECT a FROM abc ORDER BY a DESC

-- sqlfmt-corpus-separator --

SELECT a FROM abc ORDER BY a DESC LIMIT 1

-- sqlfmt-corpus-separator --

SELECT a FROM abc ORDER BY a DESC OFFSET 1

-- sqlfmt-corpus-separator --

SELECT a FROM assn_cast

-- sqlfmt-corpus-separator --

SELECT a FROM assn_cast_upsert

-- sqlfmt-corpus-separator --

SELECT a FROM c1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM c2 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM d WHERE b @> '[1]' AND b @> '[2]' ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM exec_test ORDER BY vec1 <-> '[1]' LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT a FROM foo

-- sqlfmt-corpus-separator --

SELECT a FROM json_tab WHERE b @> '1' ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM json_tab WHERE b @> '[1, 2]' OR b @> '[3, 4]' ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM json_tab WHERE b @> '[[1, 2]]' OR b @> '[[3, 4]]' ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM json_tab WHERE b @> '{"a": []}' ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM json_tab WHERE b @> '{"a": {}}' ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM mat_view_as_of ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM mat_view_as_of_no_data ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM multiple

-- sqlfmt-corpus-separator --

SELECT a FROM noncover WHERE b=2 ORDER BY c DESC

-- sqlfmt-corpus-separator --

SELECT a FROM nulls WHERE a < 2

-- sqlfmt-corpus-separator --

SELECT a FROM p ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'large') OFFSET (SELECT v FROM vals WHERE k = 'large');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'large') OFFSET (SELECT v FROM vals WHERE k = 'maxint64');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'large') OFFSET (SELECT v FROM vals WHERE k = 'one');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'large') OFFSET (SELECT v FROM vals WHERE k = 'zero');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'large');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'maxint64') OFFSET (SELECT v FROM vals WHERE k = 'large');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'maxint64') OFFSET (SELECT v FROM vals WHERE k = 'maxint64');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'maxint64') OFFSET (SELECT v FROM vals WHERE k = 'one');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'maxint64') OFFSET (SELECT v FROM vals WHERE k = 'zero');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'maxint64');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'one') OFFSET (SELECT v FROM vals WHERE k = 'large');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'one') OFFSET (SELECT v FROM vals WHERE k = 'maxint64');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'one') OFFSET (SELECT v FROM vals WHERE k = 'one');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'one') OFFSET (SELECT v FROM vals WHERE k = 'zero');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'one');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'zero') OFFSET (SELECT v FROM vals WHERE k = 'large');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'zero') OFFSET (SELECT v FROM vals WHERE k = 'maxint64');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'zero') OFFSET (SELECT v FROM vals WHERE k = 'one');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'zero') OFFSET (SELECT v FROM vals WHERE k = 'zero');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a LIMIT (SELECT v FROM vals WHERE k = 'zero');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a OFFSET (SELECT v FROM vals WHERE k = 'large');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a OFFSET (SELECT v FROM vals WHERE k = 'maxint64');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a OFFSET (SELECT v FROM vals WHERE k = 'one');

-- sqlfmt-corpus-separator --

SELECT a FROM probe ORDER BY a OFFSET (SELECT v FROM vals WHERE k = 'zero');

-- sqlfmt-corpus-separator --

SELECT a FROM regression_44774 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM sc WHERE v>20 AND v<40

-- sqlfmt-corpus-separator --

SELECT a FROM t ORDER BY (((a)))

-- sqlfmt-corpus-separator --

SELECT a FROM t ORDER BY 1 DESC

-- sqlfmt-corpus-separator --

SELECT a FROM t ORDER BY a+b DESC, a

-- sqlfmt-corpus-separator --

SELECT a FROM t ORDER BY a.b

-- sqlfmt-corpus-separator --

SELECT a FROM t ORDER BY t.a

-- sqlfmt-corpus-separator --

SELECT a FROM t WHERE a < 4.0

-- sqlfmt-corpus-separator --

SELECT a FROM t WHERE a <> 2 AND 3 / b = 1 ORDER BY k

-- sqlfmt-corpus-separator --

SELECT a FROM t WHERE a = 2 OR 3 / b = 1 ORDER BY k

-- sqlfmt-corpus-separator --

SELECT a FROM t.b

-- sqlfmt-corpus-separator --

SELECT a FROM t1 WHERE a = 10

-- sqlfmt-corpus-separator --

SELECT a FROM t1 WHERE b = 20

-- sqlfmt-corpus-separator --

SELECT a FROM t14601 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM t2 WHERE a = 10

-- sqlfmt-corpus-separator --

SELECT a FROM t;

-- sqlfmt-corpus-separator --

SELECT a FROM t_39827 ORDER BY a LIMIT 2

-- sqlfmt-corpus-separator --

SELECT a FROM t_col_def

-- sqlfmt-corpus-separator --

SELECT a FROM t_def

-- sqlfmt-corpus-separator --

SELECT a FROM t_def_nn

-- sqlfmt-corpus-separator --

SELECT a FROM t_idx WHERE a+b=10

-- sqlfmt-corpus-separator --

SELECT a FROM t_idx WHERE v=10

-- sqlfmt-corpus-separator --

SELECT a FROM t_idx WHERE v=3

-- sqlfmt-corpus-separator --

SELECT a FROM t_idx WHERE v=4

-- sqlfmt-corpus-separator --

SELECT a FROM t_idx WHERE w=2

-- sqlfmt-corpus-separator --

SELECT a FROM t_idx WHERE w=3

-- sqlfmt-corpus-separator --

SELECT a FROM t_nn

-- sqlfmt-corpus-separator --

SELECT a FROM t_pos

-- sqlfmt-corpus-separator --

SELECT a FROM t_pos_nn

-- sqlfmt-corpus-separator --

SELECT a FROM tbl_owned_by_parent LIMIT 1

-- sqlfmt-corpus-separator --

SELECT a FROM tbl_owned_by_root LIMIT 1

-- sqlfmt-corpus-separator --

SELECT a FROM test_144621;

-- sqlfmt-corpus-separator --

SELECT a FROM tnull WHERE (a<=b OR a>=b)

-- sqlfmt-corpus-separator --

SELECT a FROM tz WHERE c < d

-- sqlfmt-corpus-separator --

SELECT a FROM tz WHERE c <= d

-- sqlfmt-corpus-separator --

SELECT a FROM tz WHERE c = d

-- sqlfmt-corpus-separator --

SELECT a FROM uniq_hidden_pk GROUP BY b

-- sqlfmt-corpus-separator --

SELECT a FROM uniq_hidden_pk GROUP BY b, c

-- sqlfmt-corpus-separator --

SELECT a*b FROM decimals

-- sqlfmt-corpus-separator --

SELECT a*b, a*c, b*c, b*d, c*d FROM intdecfloat

-- sqlfmt-corpus-separator --

SELECT a+b FROM decimals

-- sqlfmt-corpus-separator --

SELECT a+b+c AS foo FROM abc

-- sqlfmt-corpus-separator --

SELECT a+b, a+c, b+c, b+d, c+d FROM intdecfloat

-- sqlfmt-corpus-separator --

SELECT a, (SELECT a FROM y) FROM x

-- sqlfmt-corpus-separator --

SELECT a, b FROM TRUNC ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b FROM a WHERE a * 2 < b ORDER BY 1, 2 LIMIT 5

-- sqlfmt-corpus-separator --

SELECT a, b FROM aliases ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM array_single_family ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM intdecfloat WHERE a < b;

-- sqlfmt-corpus-separator --

SELECT a, b FROM json_family ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM noncover WHERE b=2 AND d>3 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a, b FROM nulls WHERE a <= b

-- sqlfmt-corpus-separator --

SELECT a, b FROM regression_44774 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM t

-- sqlfmt-corpus-separator --

SELECT a, b FROM t ORDER BY a, b

-- sqlfmt-corpus-separator --

SELECT a, b FROM t ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a, b FROM t ORDER BY b DESC

-- sqlfmt-corpus-separator --

SELECT a, b FROM t ORDER BY b DESC LIMIT 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM t ORDER BY b, a DESC

-- sqlfmt-corpus-separator --

SELECT a, b FROM t WHERE b = 7 ORDER BY b, a

-- sqlfmt-corpus-separator --

SELECT a, b FROM t1 WHERE a = 10

-- sqlfmt-corpus-separator --

SELECT a, b FROM t14601a ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM t147186;

-- sqlfmt-corpus-separator --

SELECT a, b FROM t2 WHERE a = 10

-- sqlfmt-corpus-separator --

SELECT a, b FROM t65631

-- sqlfmt-corpus-separator --

SELECT a, b FROM t_with_on_update

-- sqlfmt-corpus-separator --

SELECT a, b FROM t_with_on_update ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM trunc ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b from issue_6710

-- sqlfmt-corpus-separator --

SELECT a, b, (a + 1) * (b + 2) FROM a WHERE a < 3

-- sqlfmt-corpus-separator --

SELECT a, b, a + b FROM nulls

-- sqlfmt-corpus-separator --

SELECT a, b, a < 2 AND b > 0 AND a * b != 3, a < 2 AND b < 2 FROM a WHERE a < 2 AND b > 0 AND a * b != 3

-- sqlfmt-corpus-separator --

SELECT a, b, a < b AND NULL, a > b AND NULL, NULL OR a < b, NULL OR a > b, NULL AND NULL, NULL OR NULL FROM a WHERE a = 0

-- sqlfmt-corpus-separator --

SELECT a, b, a+b AS ab FROM t WHERE b = 7 ORDER BY ab DESC, a

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM abc WHERE EXISTS (SELECT * FROM def WHERE a=d OR a=e)

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM abc WHERE NOT EXISTS (SELECT * FROM def WHERE a=d OR a=e)

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM abc, def WHERE a=d OR a=e

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM tz ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM x

-- sqlfmt-corpus-separator --

SELECT a, b, c, d FROM x

-- sqlfmt-corpus-separator --

SELECT a, b, c, rowid FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, d FROM noncover WHERE b=2 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a, b, def FROM t

-- sqlfmt-corpus-separator --

SELECT a, d FROM noncover WHERE b=2

-- sqlfmt-corpus-separator --

SELECT a, v FROM t_enum_expr

-- sqlfmt-corpus-separator --

SELECT a, v FROM t_enum_virtual

-- sqlfmt-corpus-separator --

SELECT a,a,a,a FROM abc

-- sqlfmt-corpus-separator --

SELECT a,b FROM add_default WHERE d > c AND d - c < interval '20s'

-- sqlfmt-corpus-separator --

SELECT a,b FROM add_default WHERE e > d AND e - d < interval '20s'

-- sqlfmt-corpus-separator --

SELECT a,b from small WHERE EXISTS (SELECT a FROM data WHERE small.a=data.a) ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a,b from small WHERE a+b<20 AND EXISTS (SELECT a FROM data WHERE small.a=data.a AND small.b+data.c>15) ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a,b,c FROM child_multi_1

-- sqlfmt-corpus-separator --

SELECT a,b,c FROM child_multi_2

-- sqlfmt-corpus-separator --

SELECT a,b,f FROM add_default

-- sqlfmt-corpus-separator --

SELECT a,c FROM abc

-- sqlfmt-corpus-separator --

SELECT a,computed_col from y;

-- sqlfmt-corpus-separator --

SELECT a,d FROM uniq_hidden_pk GROUP BY b, c

-- sqlfmt-corpus-separator --

SELECT a-b FROM decimals

-- sqlfmt-corpus-separator --

SELECT a-b, a-c, b-c, b-d, c-d FROM intdecfloat

-- sqlfmt-corpus-separator --

SELECT a.public.c.d FROM a.public.c

-- sqlfmt-corpus-separator --

SELECT a/b FROM a WHERE b = 2

-- sqlfmt-corpus-separator --

SELECT a/b FROM decimals

-- sqlfmt-corpus-separator --

SELECT a/b, a/c, b/c, b/d, c/d FROM intdecfloat

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

SELECT account_id, deletion_request_id FROM t74795

-- sqlfmt-corpus-separator --

SELECT b + '6 month' from t order by a desc

-- sqlfmt-corpus-separator --

SELECT b + 1 FROM a WHERE b < 3

-- sqlfmt-corpus-separator --

SELECT b + 1 FROM nulls

-- sqlfmt-corpus-separator --

SELECT b + interval '1m', interval '1m' + b, c + interval '1m', interval '1m' + c FROM tz WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b > a, e < b FROM intdecfloat

-- sqlfmt-corpus-separator --

SELECT b @@ 'fat rats' FROM ab

-- sqlfmt-corpus-separator --

SELECT b @@ a FROM ab

-- sqlfmt-corpus-separator --

SELECT b FROM a

-- sqlfmt-corpus-separator --

SELECT b FROM a WHERE b < 0.5

-- sqlfmt-corpus-separator --

SELECT b FROM a WHERE b < 3

-- sqlfmt-corpus-separator --

SELECT b FROM a WHERE b = 0 OR 1/b = 1

-- sqlfmt-corpus-separator --

SELECT b FROM a WHERE b = 0 OR b = 2

-- sqlfmt-corpus-separator --

SELECT b FROM ab GROUP BY a

-- sqlfmt-corpus-separator --

SELECT b FROM abcde WHERE a = 85

-- sqlfmt-corpus-separator --

SELECT b FROM c1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT b FROM c2 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT b FROM multiple

-- sqlfmt-corpus-separator --

SELECT b FROM t ORDER BY a DESC

-- sqlfmt-corpus-separator --

SELECT b FROM t ORDER BY b

-- sqlfmt-corpus-separator --

SELECT b FROM t WHERE c > 4.0 AND a < 4

-- sqlfmt-corpus-separator --

SELECT b FROM t1 WHERE a = 10

-- sqlfmt-corpus-separator --

SELECT b FROM uniq_hidden_pk GROUP BY a

-- sqlfmt-corpus-separator --

SELECT b FROM upsert_returning WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b from t_alter_identity ORDER BY b;

-- sqlfmt-corpus-separator --

SELECT b || 'cat' FROM aliases ORDER BY a

-- sqlfmt-corpus-separator --

SELECT b || NULL FROM t_bool;

-- sqlfmt-corpus-separator --

SELECT b, a FROM foo ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT b, a FROM t ORDER BY b, a

-- sqlfmt-corpus-separator --

SELECT b, b = 0 OR b = 2 FROM a WHERE b < 4

-- sqlfmt-corpus-separator --

SELECT b, d FROM t1 WHERE a = 10

-- sqlfmt-corpus-separator --

SELECT b_old, b, a FROM rename_add_alter_pk_tbl;

-- sqlfmt-corpus-separator --

SELECT b_old, b_orig, a, b FROM rename_add_alter_pk_tbl;

-- sqlfmt-corpus-separator --

SELECT bar FROM foo

-- sqlfmt-corpus-separator --

SELECT bar FROM foo ORDER BY bar

-- sqlfmt-corpus-separator --

SELECT bar FROM foo WHERE bar ? 'a'

-- sqlfmt-corpus-separator --

SELECT bar FROM foo WHERE bar ? 'goodbye'

-- sqlfmt-corpus-separator --

SELECT bar FROM foo WHERE bar ? 'hello'

-- sqlfmt-corpus-separator --

SELECT bar FROM foo WHERE bar->>'a' = 'b'

-- sqlfmt-corpus-separator --

SELECT bar->'a' FROM foo

-- sqlfmt-corpus-separator --

SELECT bar->'a'->'c', bar->'a'->>'c' FROM foo

-- sqlfmt-corpus-separator --

SELECT c FROM abc WHERE EXISTS (SELECT * FROM def WHERE a=d OR a=e)

-- sqlfmt-corpus-separator --

SELECT c FROM abc WHERE NOT EXISTS (SELECT * FROM def WHERE a=d OR a=e)

-- sqlfmt-corpus-separator --

SELECT c FROM abc, def WHERE a=d OR a=e

-- sqlfmt-corpus-separator --

SELECT c FROM abcd WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT c FROM t

-- sqlfmt-corpus-separator --

SELECT c FROM t ORDER BY c

-- sqlfmt-corpus-separator --

SELECT c FROM t ORDER BY c DESC

-- sqlfmt-corpus-separator --

SELECT c FROM t WHERE c = 'tEsT';

-- sqlfmt-corpus-separator --

SELECT c FROM t1 WHERE a = 10

-- sqlfmt-corpus-separator --

SELECT c FROM with_no_column_refs

-- sqlfmt-corpus-separator --

SELECT c, c = c FROM t63792

-- sqlfmt-corpus-separator --

SELECT c, c > 1 FROM a LIMIT 3

-- sqlfmt-corpus-separator --

SELECT c, d FROM abcd WHERE c >= 20 AND c < 40

-- sqlfmt-corpus-separator --

SELECT c, d FROM x

-- sqlfmt-corpus-separator --

SELECT c, e FROM abcde WHERE a = 5 AND b = 6

-- sqlfmt-corpus-separator --

SELECT c0 FROM t47715 ORDER by c1

-- sqlfmt-corpus-separator --

SELECT c1 FROM alter_policy_table ORDER BY c1;

-- sqlfmt-corpus-separator --

SELECT c1 FROM importer ORDER BY c1;

-- sqlfmt-corpus-separator --

SELECT c1 FROM t1_add

-- sqlfmt-corpus-separator --

SELECT c1 FROM t_bytes ORDER BY c1;

-- sqlfmt-corpus-separator --

SELECT c1 FROM t_int ORDER BY pk;

-- sqlfmt-corpus-separator --

SELECT c1 FROM t_many;

-- sqlfmt-corpus-separator --

SELECT c1 FROM test_52552_asc;

-- sqlfmt-corpus-separator --

SELECT c1 FROM test_52552_desc;

-- sqlfmt-corpus-separator --

SELECT c1 FROM test_52552_start;

-- sqlfmt-corpus-separator --

SELECT c1, c2 FROM force_check ORDER BY c1;

-- sqlfmt-corpus-separator --

SELECT c1, c2 FROM force_check WHERE c1 > 0 ORDER BY c1;

-- sqlfmt-corpus-separator --

SELECT c1, c3 FROM t_93398;

-- sqlfmt-corpus-separator --

SELECT c1,c2,c3,c4,c5 FROM t_bit_string ORDER BY pk;

-- sqlfmt-corpus-separator --

SELECT c2 FROM t76289_1 WHERE pk2 = 0;

-- sqlfmt-corpus-separator --

SELECT c2, c1, c0 FROM rename_column

-- sqlfmt-corpus-separator --

SELECT c2, c3 FROM t_bytes ORDER BY c1;

-- sqlfmt-corpus-separator --

SELECT c2,c3 FROM t_bytes ORDER BY c1;

-- sqlfmt-corpus-separator --

SELECT c3, c2, c1 FROM rename_column

-- sqlfmt-corpus-separator --

SELECT c_id, EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id AND c.bill='TX') FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT c_id, EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id) FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT c_id, NOT EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id) FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT cached from serial ORDER BY cached;

-- sqlfmt-corpus-separator --

SELECT cached from serial;

-- sqlfmt-corpus-separator --

SELECT catalog_name FROM create_schemas.information_schema.schemata WHERE schema_name = 'schema1';

-- sqlfmt-corpus-separator --

SELECT catalog_name FROM create_schemas.information_schema.schemata WHERE schema_name = 'schema2';

-- sqlfmt-corpus-separator --

SELECT classid, objid, objsubid, refclassid, refobjid, refobjsubid, deptype
FROM pg_catalog.pg_depend
ORDER BY objid, refobjid, refobjsubid

-- sqlfmt-corpus-separator --

SELECT classoid, description FROM pg_description
WHERE description = 'test comment'

-- sqlfmt-corpus-separator --

SELECT col FROM rgb_only ORDER BY col;

-- sqlfmt-corpus-separator --

SELECT col1, col2 FROM test_table
ORDER BY col1

-- sqlfmt-corpus-separator --

SELECT col2 FROM test_table
ORDER BY col1

-- sqlfmt-corpus-separator --

SELECT col2, col1, col3 FROM test_table
ORDER BY col1

-- sqlfmt-corpus-separator --

SELECT colors FROM test_114867

-- sqlfmt-corpus-separator --

SELECT column_name FROM information_schema.columns WHERE table_name = 't70505'

-- sqlfmt-corpus-separator --

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'crdb_internal' AND table_name = 'cluster_inspect_errors'
ORDER BY ordinal_position

-- sqlfmt-corpus-separator --

SELECT column_name, is_generated FROM information_schema.columns WHERE table_name = 't';

-- sqlfmt-corpus-separator --

SELECT column_name, is_generated, generation_expression, is_updatable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'computed'
ORDER BY column_name

-- sqlfmt-corpus-separator --

SELECT column_name, is_identity, identity_generation, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'generated_as_identity'
ORDER BY column_name

-- sqlfmt-corpus-separator --

SELECT column_name, is_identity, identity_generation, is_nullable, column_default, identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'add_generated_as_identity'
ORDER BY column_name

-- sqlfmt-corpus-separator --

SELECT column_name, is_identity, identity_generation, is_nullable, column_default, identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'drop_generated_as_identity'
ORDER BY column_name

-- sqlfmt-corpus-separator --

SELECT column_name, is_identity, identity_generation, is_nullable, column_default, identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'set_generated_as_identity'
ORDER BY column_name

-- sqlfmt-corpus-separator --

SELECT column_name, is_identity, identity_generation, is_nullable, column_default, identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle
FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'alter_opts_generated_as_identity' AND column_name = 'a'

-- sqlfmt-corpus-separator --

SELECT comment FROM system.comments LIMIT 1

-- sqlfmt-corpus-separator --

SELECT comment FROM system.comments ORDER BY comment ASC

-- sqlfmt-corpus-separator --

SELECT comment FROM ups WHERE pk = 10;

-- sqlfmt-corpus-separator --

SELECT comment FROM ups WHERE pk = 11;

-- sqlfmt-corpus-separator --

SELECT comment FROM ups WHERE pk = 12;

-- sqlfmt-corpus-separator --

SELECT comment FROM ups WHERE pk = 1;

-- sqlfmt-corpus-separator --

SELECT comment FROM ups WHERE pk = 2;

-- sqlfmt-corpus-separator --

SELECT comment FROM ups WHERE pk = 3;

-- sqlfmt-corpus-separator --

SELECT comment FROM ups WHERE pk = 4;

-- sqlfmt-corpus-separator --

SELECT comment FROM ups WHERE pk = 5;

-- sqlfmt-corpus-separator --

SELECT comment FROM ups WHERE pk = 6;

-- sqlfmt-corpus-separator --

SELECT comment FROM ups WHERE pk = 7;

-- sqlfmt-corpus-separator --

SELECT comment FROM ups WHERE pk = 8;

-- sqlfmt-corpus-separator --

SELECT comment FROM ups WHERE pk = 9;

-- sqlfmt-corpus-separator --

SELECT comment, c FROM ups WHERE pk = 1;

-- sqlfmt-corpus-separator --

SELECT comment, c FROM ups WHERE pk = 2;

-- sqlfmt-corpus-separator --

SELECT comment, c FROM ups WHERE pk = 3;

-- sqlfmt-corpus-separator --

SELECT comment, c FROM ups WHERE pk = 4;

-- sqlfmt-corpus-separator --

SELECT conkey FROM pg_catalog.pg_constraint GROUP BY conkey

-- sqlfmt-corpus-separator --

SELECT conkey, confkey FROM pg_catalog.pg_constraint WHERE conname = 'my_fkey'

-- sqlfmt-corpus-separator --

SELECT conname, confmatchtype FROM pg_constraint ORDER BY conname

-- sqlfmt-corpus-separator --

SELECT conname, confupdtype, confdeltype FROM pg_constraint ORDER BY conname

-- sqlfmt-corpus-separator --

SELECT conname, contype FROM pg_catalog.pg_constraint ORDER BY conname

-- sqlfmt-corpus-separator --

SELECT connection_name, connection_type FROM system.external_connections

-- sqlfmt-corpus-separator --

SELECT constraint_catalog, constraint_schema, constraint_name, unique_constraint_catalog, unique_constraint_schema, unique_constraint_name
FROM  information_schema.referential_constraints WHERE unique_constraint_schema='sc1';

-- sqlfmt-corpus-separator --

SELECT constraint_name, table_name, referenced_table_name, match_option
  FROM information_schema.referential_constraints

-- sqlfmt-corpus-separator --

SELECT counter FROM cnt;

-- sqlfmt-corpus-separator --

SELECT crdb_internal_a_b_shard_4, a, b, c FROM shard_columns_rename ORDER BY a

-- sqlfmt-corpus-separator --

SELECT crdb_internal_a_shard_3 FROM sharded_secondary

-- sqlfmt-corpus-separator --

SELECT crdb_internal_b_x_shard_4, x, b, c FROM shard_columns_rename ORDER BY x

-- sqlfmt-corpus-separator --

SELECT crdb_internal_idx_expr FROM t

-- sqlfmt-corpus-separator --

SELECT crdb_internal_mvcc_timestamp FROM kv;

-- sqlfmt-corpus-separator --

SELECT crdb_oid, schemaname, tablename, indexname, tablespace
FROM pg_catalog.pg_indexes
WHERE schemaname = 'public'

-- sqlfmt-corpus-separator --

SELECT crdb_oid, tablename, indexname, indexdef
FROM pg_catalog.pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname

-- sqlfmt-corpus-separator --

SELECT crdb_region, * FROM rbr WHERE p = 1

-- sqlfmt-corpus-separator --

SELECT crdb_region, * FROM t

-- sqlfmt-corpus-separator --

SELECT crdb_region, * FROM user_settings

-- sqlfmt-corpus-separator --

SELECT crdb_region, * FROM users

-- sqlfmt-corpus-separator --

SELECT crdb_region, crdb_internal_a_shard_16, a, b
FROM t_test_hsi_change_locality
ORDER BY crdb_region, crdb_internal_a_shard_16, a, b;

-- sqlfmt-corpus-separator --

SELECT crdb_region, crdb_internal_id_shard_16, id, id2
FROM t_parent
ORDER BY crdb_region, crdb_internal_id_shard_16, id, id2;

-- sqlfmt-corpus-separator --

SELECT crdb_region, i FROM t_as

-- sqlfmt-corpus-separator --

SELECT crdb_region, pk FROM created_as_global ORDER BY pk ASC

-- sqlfmt-corpus-separator --

SELECT crdb_region, pk FROM t ORDER BY pk

-- sqlfmt-corpus-separator --

SELECT crdb_region, pk, pk2, a, b FROM regional_by_row_table
ORDER BY pk

-- sqlfmt-corpus-separator --

SELECT create_statement FROM crdb_internal.create_statements WHERE descriptor_name = 't1'

-- sqlfmt-corpus-separator --

SELECT create_statement FROM crdb_internal.create_type_statements WHERE descriptor_name = 'd_show'

-- sqlfmt-corpus-separator --

SELECT current_schema

-- sqlfmt-corpus-separator --

SELECT current_user, session_user

-- sqlfmt-corpus-separator --

SELECT d FROM abcde WHERE a = 45

-- sqlfmt-corpus-separator --

SELECT d FROM assn_cast

-- sqlfmt-corpus-separator --

SELECT d FROM assn_cast_upsert

-- sqlfmt-corpus-separator --

SELECT d FROM t71271 WHERE c = 3 AND d = 4

-- sqlfmt-corpus-separator --

SELECT d FROM td

-- sqlfmt-corpus-separator --

SELECT d FROM x

-- sqlfmt-corpus-separator --

SELECT d12_3 FROM t59489

-- sqlfmt-corpus-separator --

SELECT data->>'name' FROM x WHERE k = 2

-- sqlfmt-corpus-separator --

SELECT data->>'name' FROM x WHERE k = 5

-- sqlfmt-corpus-separator --

SELECT database_id, role_name, settings FROM system.database_role_settings

-- sqlfmt-corpus-separator --

SELECT database_id, role_name, settings FROM system.database_role_settings ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT database_name FROM CRDB_INTERNAL."ranges"

-- sqlfmt-corpus-separator --

SELECT database_name FROM crdb_internal.node_statement_statistics limit 1

-- sqlfmt-corpus-separator --

SELECT database_name FROM crdb_internal.ranges

-- sqlfmt-corpus-separator --

SELECT database_name FROM crdb_internal.ranges_no_leases

-- sqlfmt-corpus-separator --

SELECT database_name, descriptor_name, descriptor_id from test.crdb_internal.create_statements where descriptor_name = 'pg_views'

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, descriptor_name, create_statement
FROM crdb_internal.create_type_statements WHERE descriptor_name = 'arr_composite'

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, descriptor_name, create_statement FROM crdb_internal.create_type_statements

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, obj_name, error FROM crdb_internal.invalid_objects
ORDER BY schema_name;

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, obj_name, error FROM crdb_internal.invalid_objects;

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, table_name, lock_key_pretty, lock_strength, durability, granted, contended FROM crdb_internal.cluster_locks WHERE table_name = 't'

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, table_name, lock_key_pretty, lock_strength, durability, isolation_level, granted, contended
FROM crdb_internal.cluster_locks WHERE table_name='t' AND txn_id='$txn1'

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, table_name, lock_key_pretty, lock_strength, durability, isolation_level, granted, contended
FROM crdb_internal.cluster_locks WHERE table_name='t' AND txn_id='$txn2'

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, table_name, lock_key_pretty, lock_strength, durability, isolation_level, granted, contended FROM crdb_internal.cluster_locks

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, table_name, lock_key_pretty, lock_strength, durability, isolation_level, granted, contended FROM crdb_internal.cluster_locks WHERE database_name='test'

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, table_name, lock_key_pretty, lock_strength, durability, isolation_level, granted, contended FROM crdb_internal.cluster_locks WHERE table_name='t' AND txn_id='$txn3'

-- sqlfmt-corpus-separator --

SELECT database_name, schema_name, table_name, lock_key_pretty, lock_strength, durability, isolation_level, granted, contended FROM crdb_internal.cluster_locks WHERE table_name='t' AND txn_id='$txn4'

-- sqlfmt-corpus-separator --

SELECT datacl FROM pg_database WHERE datname = 'defaultdb'

-- sqlfmt-corpus-separator --

SELECT definition FROM pg_catalog.pg_matviews WHERE matviewname = 'mv1'

-- sqlfmt-corpus-separator --

SELECT definition FROM pg_catalog.pg_views WHERE viewname = 'v1'

-- sqlfmt-corpus-separator --

SELECT description FROM crdb_internal.jobs ORDER BY created DESC LIMIT 2;

-- sqlfmt-corpus-separator --

SELECT description FROM crdb_internal.jobs WHERE job_type = 'SCHEMA CHANGE GC'

-- sqlfmt-corpus-separator --

SELECT descriptor_id, descriptor_name, index_id, index_name, index_type, is_unique, is_inverted, is_sharded, shard_bucket_count
  FROM crdb_internal.table_indexes
 WHERE descriptor_name = 'poor_t'

-- sqlfmt-corpus-separator --

SELECT descriptor_name, dependedonby_type, dependedonby_details
FROM crdb_internal.forward_dependencies
WHERE descriptor_name = 'trigger_dep_single_t2'
ORDER BY dependedonby_details

-- sqlfmt-corpus-separator --

SELECT descriptor_name, dependedonby_type, dependedonby_details
FROM crdb_internal.forward_dependencies
WHERE descriptor_name = 'trigger_dep_t2'
ORDER BY dependedonby_details

-- sqlfmt-corpus-separator --

SELECT distinct is_identity FROM information_schema.columns

-- sqlfmt-corpus-separator --

SELECT distinct(a) FROM t53922

-- sqlfmt-corpus-separator --

SELECT e FROM ef WHERE f > 0 AND f < 2 ORDER BY f

-- sqlfmt-corpus-separator --

SELECT estimated_row_count FROM crdb_internal.table_row_statistics WHERE table_name = 't'

-- sqlfmt-corpus-separator --

SELECT f, d, j, s FROM tbl_with_dft_column_family ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f_table_name FROM pg_extension.geometry_columns

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name = 'sql.schema.change_in_explicit_txn'

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name = 'sql.schema.secondary_index_column_families' AND usage_count >= 2

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name = 'sql.schema.set_audit_mode.off'

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name = 'sql.schema.set_audit_mode.read_write'

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name='sql.exec.query.is-distributed' AND usage_count > 0

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name='sql.exec.query.is-vectorized' AND usage_count > 0

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name='sql.partitioning.alter-all-partitions' AND usage_count > 0

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name='sql.partitioning.partition-constrained-scan' AND usage_count > 0

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name='sql.show.constraints' AND usage_count > 0

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name='sql.show.create' AND usage_count > 0

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name='sql.show.indexes' AND usage_count > 0

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name='sql.show.jobs' AND usage_count > 0

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name='sql.show.locality' AND usage_count > 0

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name='sql.show.partitions' AND usage_count > 0

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name='sql.show.queries' AND usage_count > 0

-- sqlfmt-corpus-separator --

SELECT feature_name FROM crdb_internal.feature_usage WHERE feature_name='sql.show.ranges' AND usage_count > 0

-- sqlfmt-corpus-separator --

SELECT field FROM crdb_internal.node_build_info

-- sqlfmt-corpus-separator --

SELECT foo from select_test

-- sqlfmt-corpus-separator --

SELECT foo.a FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT foo1, foo.foo1, b, foo.c FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT generation_expression FROM information_schema.columns
WHERE table_name = 'x' and column_name = 'b'

-- sqlfmt-corpus-separator --

SELECT global_id FROM system.prepared_transactions

-- sqlfmt-corpus-separator --

SELECT global_id, owner, database FROM system.prepared_transactions

-- sqlfmt-corpus-separator --

SELECT hash, row_id, fingerprint, hint, created_at, hint_type, hint_name, enabled, database
FROM system.statement_hints ORDER BY row_id

-- sqlfmt-corpus-separator --

SELECT i + (-1000) < 9223372036854775800 FROM t88128

-- sqlfmt-corpus-separator --

SELECT i + 1000 > -9223372036854775800 FROM t88128

-- sqlfmt-corpus-separator --

SELECT i + d FROM t64676

-- sqlfmt-corpus-separator --

SELECT i - (-1000) > -9223372036854775800 FROM t88128

-- sqlfmt-corpus-separator --

SELECT i - 1000 < 9223372036854775800 FROM t88128

-- sqlfmt-corpus-separator --

SELECT i << -1 FROM t

-- sqlfmt-corpus-separator --

SELECT i << 63 >> 63, i << 62 >> 62 FROM t

-- sqlfmt-corpus-separator --

SELECT i << 64 FROM t

-- sqlfmt-corpus-separator --

SELECT i >> -1 FROM t

-- sqlfmt-corpus-separator --

SELECT i >> 64 FROM t

-- sqlfmt-corpus-separator --

SELECT i FROM intervals ORDER BY pk

-- sqlfmt-corpus-separator --

SELECT i FROM r

-- sqlfmt-corpus-separator --

SELECT i FROM s

-- sqlfmt-corpus-separator --

SELECT i FROM t54649_a WHERE (NULL OR b) OR b

-- sqlfmt-corpus-separator --

SELECT i FROM t54649_b WHERE c

-- sqlfmt-corpus-separator --

SELECT i, j FROM new_other_db.t ORDER BY i, j

-- sqlfmt-corpus-separator --

SELECT i, j, k FROM bar ORDER BY i, j, k

-- sqlfmt-corpus-separator --

SELECT i, j, k FROM new_test_schema.foo ORDER BY i, j, k

-- sqlfmt-corpus-separator --

SELECT i, j, k FROM tb ORDER BY i, j, k

-- sqlfmt-corpus-separator --

SELECT id FROM a;

-- sqlfmt-corpus-separator --

SELECT id FROM blog_posts ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id FROM system.descriptor WHERE id=1

-- sqlfmt-corpus-separator --

SELECT id FROM system.namespace WHERE name = 'd_t' or name = '_d_t'

-- sqlfmt-corpus-separator --

SELECT id FROM system.namespace WHERE name = 'myschema2'

-- sqlfmt-corpus-separator --

SELECT id FROM system.namespace WHERE name='t';

-- sqlfmt-corpus-separator --

SELECT id FROM t

-- sqlfmt-corpus-separator --

SELECT id FROM t_seqname_create

-- sqlfmt-corpus-separator --

SELECT id FROM test_collate WHERE "string_field" = 'sTR_cOLLATE_1'

-- sqlfmt-corpus-separator --

SELECT id, a, b FROM t123103;

-- sqlfmt-corpus-separator --

SELECT id, a, b FROM tab_141810 ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, a_id FROM b;

-- sqlfmt-corpus-separator --

SELECT id, active, name
FROM system.tenants
ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, active, name
FROM system.tenants WHERE name = 'four'
ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, active, name FROM system.tenants ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, col_to_drop, computed_col FROM test_table

-- sqlfmt-corpus-separator --

SELECT id, customer_id FROM orders

-- sqlfmt-corpus-separator --

SELECT id, customer_id FROM orders ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, database_name, super_region_name, regions FROM crdb_internal.super_regions

-- sqlfmt-corpus-separator --

SELECT id, name FROM t_pk

-- sqlfmt-corpus-separator --

SELECT id, name FROM t_pk WHERE id = 1

-- sqlfmt-corpus-separator --

SELECT id, name, data_state FROM system.tenants ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, path, depth, parent_path FROM t_computed

-- sqlfmt-corpus-separator --

SELECT id, path, depth, parent_path FROM t_computed WHERE id = 1

-- sqlfmt-corpus-separator --

SELECT id, path, depth, parent_path FROM t_computed WHERE id = 4

-- sqlfmt-corpus-separator --

SELECT id, region, city FROM data_test WHERE region = 'east' AND city = 'boston'

-- sqlfmt-corpus-separator --

SELECT id, region, city, population FROM data_test WHERE region = 'west'

-- sqlfmt-corpus-separator --

SELECT id, username FROM alter_test_view ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, val FROM t_atom

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

SELECT id, val FROM t_upd

-- sqlfmt-corpus-separator --

SELECT id, val FROM t_upd_nn

-- sqlfmt-corpus-separator --

SELECT id, val, (SELECT v FROM t_lookup WHERE k = id) AS lookup_val
FROM t_sub
ORDER BY (SELECT v FROM t_lookup WHERE k = id) NULLS LAST

-- sqlfmt-corpus-separator --

SELECT index_id, index_name FROM crdb_internal.table_indexes WHERE descriptor_name = 't' ORDER BY index_id

-- sqlfmt-corpus-separator --

SELECT index_id, index_name FROM crdb_internal.table_indexes WHERE descriptor_name = 't' ORDER BY index_name

-- sqlfmt-corpus-separator --

SELECT index_name FROM crdb_internal.ranges

-- sqlfmt-corpus-separator --

SELECT index_name, column_name, implicit FROM crdb_internal.index_columns
WHERE descriptor_name = 'regional_by_row_table' AND column_type = 'key'
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT index_name, column_name, implicit FROM crdb_internal.index_columns
WHERE descriptor_name = 'sharded_primary' AND column_type = 'key'
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT index_name, column_name, implicit FROM crdb_internal.index_columns
WHERE descriptor_name = 't' AND column_type = 'key'
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT index_name, column_name, implicit FROM crdb_internal.index_columns
WHERE descriptor_name = 't8' AND column_type = 'key'
ORDER BY index_name, column_id

-- sqlfmt-corpus-separator --

SELECT index_name, column_name, implicit FROM crdb_internal.index_columns
WHERE descriptor_name = 't9' AND column_type = 'storing'
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT indexname, indexdef
FROM pg_catalog.pg_indexes
WHERE tablename = 'geospatial_table'
ORDER BY indexname

-- sqlfmt-corpus-separator --

SELECT indexname, indexdef
FROM pg_catalog.pg_indexes
WHERE tablename = 'partial_index_table'
ORDER BY indexname

-- sqlfmt-corpus-separator --

SELECT indexname, indexdef
FROM pg_catalog.pg_indexes
WHERE tablename = 'vector_table'
ORDER BY indexname

-- sqlfmt-corpus-separator --

SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'intervalstyle_in_index'
AND indexname = 'idx'

-- sqlfmt-corpus-separator --

SELECT indkey FROM pg_index WHERE indrelid = (SELECT oid FROM pg_class WHERE relname = 'k') ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT interval ' 5  ' year

-- sqlfmt-corpus-separator --

SELECT interval '-1:02.123456'

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

SELECT interval '123 11'

-- sqlfmt-corpus-separator --

SELECT interval '123 11' day

-- sqlfmt-corpus-separator --

SELECT interval '123 11' day to hour

-- sqlfmt-corpus-separator --

SELECT interval '123 2:03 -2:04'

-- sqlfmt-corpus-separator --

SELECT interval '12:34.5678' minute to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1:02.123456'

-- sqlfmt-corpus-separator --

SELECT interval '2' month

-- sqlfmt-corpus-separator --

SELECT interval '2.1 00:'

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

SELECT invalid_path FROM t_computed_invalid_virtual WHERE id = 1

-- sqlfmt-corpus-separator --

SELECT is_temporary FROM crdb_internal.create_statements WHERE descriptor_name = 'normal_table'

-- sqlfmt-corpus-separator --

SELECT is_temporary FROM crdb_internal.create_statements WHERE descriptor_name = 'temp'

-- sqlfmt-corpus-separator --

SELECT is_virtual FROM crdb_internal.create_statements WHERE descriptor_name = 'normal_table'

-- sqlfmt-corpus-separator --

SELECT is_virtual FROM crdb_internal.create_statements WHERE descriptor_name = 'pg_views'

-- sqlfmt-corpus-separator --

SELECT item, quantity FROM stockafterschemachange

-- sqlfmt-corpus-separator --

SELECT item, quantity FROM stockcopy

-- sqlfmt-corpus-separator --

SELECT item, quantity FROM stocknospoons WHERE item = 'spoons'

-- sqlfmt-corpus-separator --

SELECT item, quantity FROM stockwithspoons WHERE item = 'spoons'

-- sqlfmt-corpus-separator --

SELECT item, quantity, newcol FROM stockbeforedrop

-- sqlfmt-corpus-separator --

SELECT j - 'foo' AS a, j - 'bar' AS b FROM t57165 ORDER BY rowid

-- sqlfmt-corpus-separator --

SELECT j - s FROM t57165

-- sqlfmt-corpus-separator --

SELECT j FROM t49143 WHERE NOT (j -> 'b' @> '[1]') ORDER BY k

-- sqlfmt-corpus-separator --

SELECT j FROM t49143 WHERE NOT (j -> 0 @> '[1]') ORDER BY k

-- sqlfmt-corpus-separator --

SELECT j FROM t49143 WHERE NOT (j->'b' = '1') ORDER BY k

-- sqlfmt-corpus-separator --

SELECT j FROM t49143 WHERE NOT (j->0 = '2') ORDER BY k

-- sqlfmt-corpus-separator --

SELECT j, c, j->'b' = '1' AS expected_c FROM t75907

-- sqlfmt-corpus-separator --

SELECT j, j ? 'a', j-1, (j-1) ? 'a' FROM t81647

-- sqlfmt-corpus-separator --

SELECT j, k FROM foo;

-- sqlfmt-corpus-separator --

SELECT job_type, description, user_name FROM crdb_internal.jobs

-- sqlfmt-corpus-separator --

SELECT job_type, description, user_name FROM crdb_internal.jobs ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT job_type, description, user_name FROM crdb_internal.jobs WHERE job_type = 'SCHEMA CHANGE GC' ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT job_type, description, user_name, status, fraction_completed, error
FROM crdb_internal.jobs
WHERE job_type = 'NEW SCHEMA CHANGE' OR job_type = 'SCHEMA CHANGE GC'
ORDER BY created DESC
LIMIT 2

-- sqlfmt-corpus-separator --

SELECT job_type, description, user_name, status, fraction_completed, error
FROM crdb_internal.jobs
WHERE job_type = 'SCHEMA CHANGE' OR job_type = 'SCHEMA CHANGE GC'
ORDER BY created DESC
LIMIT 2

-- sqlfmt-corpus-separator --

SELECT k FROM kv

-- sqlfmt-corpus-separator --

SELECT k FROM kv HAVING k > 7

-- sqlfmt-corpus-separator --

SELECT k FROM kv ORDER BY v

-- sqlfmt-corpus-separator --

SELECT k FROM large ORDER BY k DESC;

-- sqlfmt-corpus-separator --

SELECT k FROM large ORDER BY k;

-- sqlfmt-corpus-separator --

SELECT k FROM t55387 WHERE a > 1 AND b > 3

-- sqlfmt-corpus-separator --

SELECT k FROM t71655 WHERE a = 10 AND b = 20

-- sqlfmt-corpus-separator --

SELECT k FROM t86075 WHERE c = (SELECT c FROM t86075 LIMIT 1)

-- sqlfmt-corpus-separator --

SELECT k, a FROM t;

-- sqlfmt-corpus-separator --

SELECT k, b FROM x ORDER BY b

-- sqlfmt-corpus-separator --

SELECT k, crdb_internal_origin_id FROM t4

-- sqlfmt-corpus-separator --

SELECT k, crdb_internal_origin_id FROM t4 ORDER BY k DESC

-- sqlfmt-corpus-separator --

SELECT k, crdb_internal_origin_id FROM t4 WHERE k = 1

-- sqlfmt-corpus-separator --

SELECT k, d, d_comp, d2, d2_comp FROM assn_cast_comp

-- sqlfmt-corpus-separator --

SELECT k, v FROM kv ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY k LIMIT 5

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY k OFFSET 5

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY v DESC LIMIT (1+4) OFFSET 1

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY v LIMIT (1+4) OFFSET 1

-- sqlfmt-corpus-separator --

SELECT k, v FROM unindexed

-- sqlfmt-corpus-separator --

SELECT k, v FROM v127043_3 WHERE k = 1 LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT k, v FROM v127043_3_idx WHERE k = 1 LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT k, v, k + v FROM kv

-- sqlfmt-corpus-separator --

SELECT k,v FROM kv

-- sqlfmt-corpus-separator --

SELECT key FROM child ORDER BY key;

-- sqlfmt-corpus-separator --

SELECT key FROM test.crdb_internal.node_statement_statistics

-- sqlfmt-corpus-separator --

SELECT key,
       service_lat_avg > 0 and service_lat_avg < 10 as svc_ok,
       parse_lat_avg > 0   and parse_lat_avg < 11   as parse_ok,
       plan_lat_avg > 0    and plan_lat_avg < 10    as plan_ok,
       run_lat_avg > 0     and run_lat_avg < 10     as run_ok,
                           overhead_lat_avg < 10    as ovh_ok
  FROM crdb_internal.node_statement_statistics
 WHERE key = 'SELECT _'

-- sqlfmt-corpus-separator --

SELECT key, max_retries, failure_count
  FROM crdb_internal.node_statement_statistics
 WHERE application_name = 'test_max_retry'
ORDER BY key

-- sqlfmt-corpus-separator --

SELECT key,flags
FROM test.crdb_internal.node_statement_statistics
WHERE application_name = 'valuetest' ORDER BY key, flags

-- sqlfmt-corpus-separator --

SELECT kv.K,KV.v FROM kv

-- sqlfmt-corpus-separator --

SELECT kv.k FROM kv, kw WHERE kv.k = kw.k ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT kv.k, v FROM kv, kw WHERE v = w

-- sqlfmt-corpus-separator --

SELECT last_value FROM cache_test

-- sqlfmt-corpus-separator --

SELECT last_value FROM cached_lower_bound_test;

-- sqlfmt-corpus-separator --

SELECT last_value FROM cached_lower_bound_test_2;

-- sqlfmt-corpus-separator --

SELECT last_value FROM cached_upper_bound_test;

-- sqlfmt-corpus-separator --

SELECT last_value FROM myschema.s

-- sqlfmt-corpus-separator --

SELECT last_value FROM pg_sequences WHERE sequencename = 'serial'

-- sqlfmt-corpus-separator --

SELECT last_value FROM priv_test

-- sqlfmt-corpus-separator --

SELECT last_value FROM select_test

-- sqlfmt-corpus-separator --

SELECT last_value FROM system.tenant_id_seq

-- sqlfmt-corpus-separator --

SELECT last_value from public.serial_cached512_seq;

-- sqlfmt-corpus-separator --

SELECT last_value from public.serial_cached_seq;

-- sqlfmt-corpus-separator --

SELECT lta ?<@ 'A.B' FROM la ORDER BY lta;

-- sqlfmt-corpus-separator --

SELECT lta ?@> 'A.B' FROM la ORDER BY lta;

-- sqlfmt-corpus-separator --

SELECT n FROM a WHERE b = 1 AND (((a < 1) AND (a > 1)) OR (a >= 2 AND a <= 2))

-- sqlfmt-corpus-separator --

SELECT n,a,b FROM a WHERE a = 4 AND b = 1

-- sqlfmt-corpus-separator --

SELECT n,a,b FROM a WHERE a = 4 AND b = 1;

-- sqlfmt-corpus-separator --

SELECT n,a,b FROM a WHERE a = 5 AND b = 2

-- sqlfmt-corpus-separator --

SELECT name FROM pg_catalog.pg_prepared_statements ORDER BY name

-- sqlfmt-corpus-separator --

SELECT name FROM pg_cursors

-- sqlfmt-corpus-separator --

SELECT name FROM pg_cursors;

-- sqlfmt-corpus-separator --

SELECT name, age FROM t_person

-- sqlfmt-corpus-separator --

SELECT name, corruption FROM crdb_internal.kv_repairable_catalog_corruptions
ORDER BY name;

-- sqlfmt-corpus-separator --

SELECT name, database_name, state FROM crdb_internal.tables WHERE name = 't'

-- sqlfmt-corpus-separator --

SELECT name, mascot, postal_code FROM university ORDER BY name

-- sqlfmt-corpus-separator --

SELECT name, nickname, state_or_province FROM city ORDER BY name

-- sqlfmt-corpus-separator --

SELECT name, origin, location FROM volcano ORDER BY name

-- sqlfmt-corpus-separator --

SELECT name, parameter_types, result_types FROM pg_prepared_statements WHERE name = 'insert_returning'

-- sqlfmt-corpus-separator --

SELECT name, source, min_val, max_val, sourcefile, sourceline FROM pg_catalog.pg_settings ORDER BY name

-- sqlfmt-corpus-separator --

SELECT name, statement, is_holdable, is_binary, is_scrollable FROM pg_catalog.pg_cursors ORDER BY name;

-- sqlfmt-corpus-separator --

SELECT name, statement, is_scrollable, is_holdable, is_binary FROM pg_catalog.pg_cursors

-- sqlfmt-corpus-separator --

SELECT name, ttl FROM crdb_internal.kv_dropped_relations ORDER BY name;

-- sqlfmt-corpus-separator --

SELECT name, value FROM system.settings WHERE name = 'sql.defaults.vectorize'

-- sqlfmt-corpus-separator --

SELECT name, value FROM system.settings WHERE name = 'testing.str'

-- sqlfmt-corpus-separator --

SELECT newcol FROM stockafterschemachange

-- sqlfmt-corpus-separator --

SELECT nextval >= 2 FROM tab_from_seq

-- sqlfmt-corpus-separator --

SELECT node_id FROM crdb_internal.gossip_liveness WHERE node_id = 1

-- sqlfmt-corpus-separator --

SELECT node_id FROM crdb_internal.gossip_nodes WHERE node_id = 1

-- sqlfmt-corpus-separator --

SELECT node_id FROM crdb_internal.kv_node_status WHERE node_id = 1

-- sqlfmt-corpus-separator --

SELECT node_id FROM crdb_internal.kv_store_status WHERE node_id = 1

-- sqlfmt-corpus-separator --

SELECT node_id, application_name, key, statement_ids, count FROM crdb_internal.node_transaction_statistics where application_name = 'test_txn_statistics'

-- sqlfmt-corpus-separator --

SELECT node_id, application_name, key, statement_ids, count FROM crdb_internal.node_transaction_statistics where application_name = 'test_txn_statistics' ORDER BY key

-- sqlfmt-corpus-separator --

SELECT node_id, store_id, attrs, used
FROM crdb_internal.kv_store_status WHERE node_id = 1

-- sqlfmt-corpus-separator --

SELECT nspacl FROM pg_namespace WHERE nspname = 'acl_test_schema'

-- sqlfmt-corpus-separator --

SELECT nspacl FROM pg_namespace WHERE nspname = 'pg_catalog'

-- sqlfmt-corpus-separator --

SELECT nspacl FROM pg_namespace WHERE nspname = 'public'

-- sqlfmt-corpus-separator --

SELECT nspacl FROM pg_namespace WHERE nspname = 'testowner_schema'

-- sqlfmt-corpus-separator --

SELECT nspname, nspowner, nspacl FROM pg_catalog.pg_namespace

-- sqlfmt-corpus-separator --

SELECT objoid, classoid, description FROM pg_catalog.pg_shdescription

-- sqlfmt-corpus-separator --

SELECT objoid, classoid, objsubid, provider, label FROM pg_catalog.pg_seclabel

-- sqlfmt-corpus-separator --

SELECT objoid, classoid, provider, label FROM pg_catalog.pg_shseclabel

-- sqlfmt-corpus-separator --

SELECT oid, amname FROM pg_catalog.pg_am

-- sqlfmt-corpus-separator --

SELECT oid, collname FROM pg_collation
WHERE collname='en-US'

-- sqlfmt-corpus-separator --

SELECT oid, datname, datconnlimit, datfrozenxid, datminmxid, dattablespace, datlocprovider, datacl
FROM pg_catalog.pg_database
ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT oid, datname, datconnlimit, datfrozenxid, datminmxid, dattablespace, datlocprovider, datacl
FROM pg_catalog.pg_database
ORDER BY oid LIMIT 1

-- sqlfmt-corpus-separator --

SELECT oid, datname, datdba, encoding, datcollate, datctype, datistemplate, datallowconn
FROM pg_catalog.pg_database
ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT oid, roleid, member, grantor, admin_option, inherit_option, set_option
FROM pg_catalog.pg_auth_members

-- sqlfmt-corpus-separator --

SELECT oid, rolname, rolconnlimit, rolpassword, rolvaliduntil, rolbypassrls, rolconfig
FROM pg_catalog.pg_roles
ORDER BY rolname

-- sqlfmt-corpus-separator --

SELECT oid, rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcatupdate, rolcanlogin, rolreplication
FROM pg_catalog.pg_roles
ORDER BY rolname

-- sqlfmt-corpus-separator --

SELECT oid, spcname, spcowner, spcacl, spcoptions FROM pg_tablespace

-- sqlfmt-corpus-separator --

SELECT oid, typname, typalign, typstorage, typnotnull, typbasetype, typtypmod
FROM pg_catalog.pg_type
WHERE oid < 4194967002 -- exclude implicit types for virtual tables
ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT oid, typname, typcategory, typispreferred, typisdefined, typdelim, typrelid, typelem, typarray
FROM pg_catalog.pg_type
WHERE oid < 4194967002 -- exclude implicit types for virtual tables
ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT oid, typname, typinput, typoutput, typreceive, typsend, typmodin, typmodout, typanalyze
FROM pg_catalog.pg_type
WHERE oid < 4194967002 -- exclude implicit types for virtual tables
ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT oid, typname, typnamespace, typowner, typlen, typbyval, typtype
FROM pg_catalog.pg_type
WHERE oid < 4194967002 -- exclude implicit types for virtual tables
ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT oid, typname, typnamespace, typowner, typlen, typbyval, typtype
FROM pg_catalog.pg_type
WHERE oid = 1

-- sqlfmt-corpus-separator --

SELECT oid, typname, typnamespace, typowner, typlen, typbyval, typtype
FROM pg_catalog.pg_type
WHERE oid = 1000

-- sqlfmt-corpus-separator --

SELECT oid, typname, typnamespace, typowner, typlen, typbyval, typtype
FROM pg_catalog.pg_type
WHERE oid = 9999999

-- sqlfmt-corpus-separator --

SELECT oid, typname, typnamespace, typowner, typlen, typbyval, typtype
FROM pg_catalog.pg_type
WHERE typname = 'newtype1'

-- sqlfmt-corpus-separator --

SELECT oid, typname, typnamespace, typowner, typlen, typbyval, typtype
FROM pg_catalog.pg_type
WHERE typname = 'source_table'

-- sqlfmt-corpus-separator --

SELECT oid, typname, typndims, typcollation, typdefaultbin, typdefault, typacl
FROM pg_catalog.pg_type
WHERE oid < 4194967002 -- exclude implicit types for virtual tables
ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT oid, typname, typowner, typlen, typbyval, typtype
FROM pg_catalog.pg_type WHERE typname = 'uuid'
ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT option, value FROM system.role_options WHERE username = 'repluser'

-- sqlfmt-corpus-separator --

SELECT orphan FROM geo_table

-- sqlfmt-corpus-separator --

SELECT p, j FROM test_fk_base ORDER BY p

-- sqlfmt-corpus-separator --

SELECT p, j, k FROM test_fk_ref ORDER BY p

-- sqlfmt-corpus-separator --

SELECT p, j, k FROM test_upsert

-- sqlfmt-corpus-separator --

SELECT p, j, k FROM test_upsert ORDER BY p

-- sqlfmt-corpus-separator --

SELECT p, k FROM test_alter

-- sqlfmt-corpus-separator --

SELECT p, k FROM test_simple

-- sqlfmt-corpus-separator --

SELECT p, k FROM test_table_enum

-- sqlfmt-corpus-separator --

SELECT p, k FROM test_table_enum ORDER BY p

-- sqlfmt-corpus-separator --

SELECT p, k FROM test_table_seq

-- sqlfmt-corpus-separator --

SELECT p, k FROM test_table_seq ORDER BY p

-- sqlfmt-corpus-separator --

SELECT p, k FROM test_with_default

-- sqlfmt-corpus-separator --

SELECT parent_path FROM t32786 ORDER BY id

-- sqlfmt-corpus-separator --

SELECT pk FROM regional_by_row_table_virt GROUP BY (a+10);

-- sqlfmt-corpus-separator --

SELECT pk FROM regional_by_row_table_virt GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT pk FROM regional_by_row_table_virt GROUP BY v;

-- sqlfmt-corpus-separator --

SELECT pk FROM t40574 WHERE (col0 > 9 AND (col1 <= 6.38 OR col0 =5) AND (col0 = 7 OR col4 = 7))

-- sqlfmt-corpus-separator --

SELECT pk, a, b FROM regional_by_row_table_virt GROUP BY v;

-- sqlfmt-corpus-separator --

SELECT pk, a, b FROM tab0 WHERE a < 10 AND b = 2 ORDER BY a DESC, pk;

-- sqlfmt-corpus-separator --

SELECT pk, a, b, crdb_region_col, crdb_region_col1 FROM regional_by_row_table_as1 LIMIT 3

-- sqlfmt-corpus-separator --

SELECT pk,v FROM t5 WHERE pk = 1

-- sqlfmt-corpus-separator --

SELECT pk,v FROM t7 WHERE pk = 3

-- sqlfmt-corpus-separator --

SELECT pk,v FROM t7 WHERE pk = 4

-- sqlfmt-corpus-separator --

SELECT polname FROM pg_policy WHERE polname = 'check_access';

-- sqlfmt-corpus-separator --

SELECT primes FROM cb WHERE primes && numbers ORDER BY primes

-- sqlfmt-corpus-separator --

SELECT proacl FROM pg_proc WHERE proname = 'acl_test_fn'

-- sqlfmt-corpus-separator --

SELECT proacl FROM pg_proc WHERE proname = 'substring' LIMIT 1

-- sqlfmt-corpus-separator --

SELECT proname FROM pg_catalog.pg_proc WHERE oid = 0

-- sqlfmt-corpus-separator --

SELECT proname, proisstrict, proretset, provolatile, proparallel
FROM pg_catalog.pg_proc
WHERE proname='substring'

-- sqlfmt-corpus-separator --

SELECT proname, prokind, prosecdef, proleakproof
FROM pg_catalog.pg_proc
WHERE proname='substring'

-- sqlfmt-corpus-separator --

SELECT proname, pronargs, pronargdefaults, proargtypes, proallargtypes, proargmodes, proargnames, proargdefaults
FROM pg_catalog.pg_proc WHERE proname = 'f_3_in_2_out';

-- sqlfmt-corpus-separator --

SELECT proname, pronargs, pronargdefaults, proargtypes, proallargtypes, proargmodes, proargnames, proargdefaults
FROM pg_catalog.pg_proc WHERE proname = 'f_default_names';

-- sqlfmt-corpus-separator --

SELECT proname, pronargs, pronargdefaults, proargtypes, proallargtypes, proargmodes, proargnames, proargdefaults
FROM pg_catalog.pg_proc WHERE proname = 'my_sum';

-- sqlfmt-corpus-separator --

SELECT proname, pronargs, pronargdefaults, prorettype, proargtypes, proallargtypes, proargmodes, proargdefaults
FROM pg_catalog.pg_proc
WHERE proname='substring'
ORDER BY proargtypes

-- sqlfmt-corpus-separator --

SELECT proname, protrftypes, prosrc, probin, proconfig, proacl
FROM pg_catalog.pg_proc
WHERE proname='substring'

-- sqlfmt-corpus-separator --

SELECT proname, provariadic, pronargs, prorettype, proargtypes, proargmodes
FROM pg_catalog.pg_proc
WHERE proname='json_extract_path'

-- sqlfmt-corpus-separator --

SELECT proname, provariadic, pronargs, prorettype, proargtypes, proargmodes, proisstrict
FROM pg_catalog.pg_proc
WHERE proname='json_extract_path'

-- sqlfmt-corpus-separator --

SELECT proname, provariadic, pronargs, prorettype, proargtypes, proargmodes, proisstrict
FROM pg_catalog.pg_proc
WHERE proname='json_extract_path_text'

-- sqlfmt-corpus-separator --

SELECT proname, provariadic, pronargs, prorettype, proargtypes, proargmodes, proisstrict
FROM pg_catalog.pg_proc
WHERE proname='least'

-- sqlfmt-corpus-separator --

SELECT qc FROM assn_cast

-- sqlfmt-corpus-separator --

SELECT qc FROM assn_cast_upsert

-- sqlfmt-corpus-separator --

SELECT r FROM t

-- sqlfmt-corpus-separator --

SELECT r, i FROM uniq_enum GROUP BY i

-- sqlfmt-corpus-separator --

SELECT raw_config_sql FROM crdb_internal.zones WHERE zone_id = 0

-- sqlfmt-corpus-separator --

SELECT rbr.message FROM messages_rbr rbr, messages_rbt rbt WHERE rbr.account_id = rbt.account_id LIMIT 4

-- sqlfmt-corpus-separator --

SELECT region, name, outlet FROM river ORDER BY region, name

-- sqlfmt-corpus-separator --

SELECT relacl FROM pg_class WHERE relname = 'pg_class'

-- sqlfmt-corpus-separator --

SELECT relacl FROM pg_class WHERE relname = 't1'

-- sqlfmt-corpus-separator --

SELECT relacl FROM pg_class WHERE relname = 'testowner_table'

-- sqlfmt-corpus-separator --

SELECT relname FROM pg_class WHERE relname = 'my_seq_a' AND relkind = 'S'

-- sqlfmt-corpus-separator --

SELECT relname, indkey FROM indexes ORDER BY relname DESC

-- sqlfmt-corpus-separator --

SELECT relname, reloptions FROM pg_catalog.pg_class
WHERE relname = 'mat_view';

-- sqlfmt-corpus-separator --

SELECT relname, reloptions FROM pg_catalog.pg_class
WHERE relname = 'sd_view';

-- sqlfmt-corpus-separator --

SELECT relname, reloptions FROM pg_catalog.pg_class
WHERE relname = 'si_view';

-- sqlfmt-corpus-separator --

SELECT relname, relrowsecurity, relforcerowsecurity FROM pg_class WHERE relname = 'policy_table';

-- sqlfmt-corpus-separator --

SELECT reltype FROM pg_class WHERE relname = 'regression_65576'

-- sqlfmt-corpus-separator --

SELECT rolbypassrls FROM pg_authid WHERE rolname = 'can_bypassrls' OR rolname = 'can_bypassrls_global';

-- sqlfmt-corpus-separator --

SELECT rolbypassrls FROM pg_authid WHERE rolname = 'cannot_bypassrls';

-- sqlfmt-corpus-separator --

SELECT rolbypassrls FROM pg_roles WHERE rolname = 'can_bypassrls' OR rolname = 'can_bypassrls_global';

-- sqlfmt-corpus-separator --

SELECT rolbypassrls FROM pg_roles WHERE rolname = 'cannot_bypassrls';

-- sqlfmt-corpus-separator --

SELECT rolcanlogin FROM pg_roles WHERE rolname = 'role_test_login';

-- sqlfmt-corpus-separator --

SELECT rolcanlogin FROM pg_roles WHERE rolname = 'role_test_nologin';

-- sqlfmt-corpus-separator --

SELECT rolcreatedb FROM pg_authid WHERE rolname = 'can_createdb' OR rolname = 'can_createdb_global';

-- sqlfmt-corpus-separator --

SELECT rolcreatedb FROM pg_authid WHERE rolname = 'cannot_createdb';

-- sqlfmt-corpus-separator --

SELECT rolcreatedb FROM pg_roles WHERE rolname = 'can_createdb' OR rolname = 'can_createdb_global';

-- sqlfmt-corpus-separator --

SELECT rolcreatedb FROM pg_roles WHERE rolname = 'cannot_createdb';

-- sqlfmt-corpus-separator --

SELECT rolcreaterole FROM pg_authid WHERE rolname = 'can_createrole' OR rolname = 'can_createrole_global';

-- sqlfmt-corpus-separator --

SELECT rolcreaterole FROM pg_authid WHERE rolname = 'cannot_createrole';

-- sqlfmt-corpus-separator --

SELECT rolcreaterole FROM pg_roles WHERE rolname = 'can_createrole' OR rolname = 'can_createrole_global';

-- sqlfmt-corpus-separator --

SELECT rolcreaterole FROM pg_roles WHERE rolname = 'cannot_createrole';

-- sqlfmt-corpus-separator --

SELECT role, inheriting_member, member_is_explicit
FROM crdb_internal.kv_inherited_role_members
WHERE inheriting_member = 'root'
ORDER BY role

-- sqlfmt-corpus-separator --

SELECT role, inheriting_member, member_is_explicit, member_is_admin
FROM crdb_internal.kv_inherited_role_members
ORDER BY role, inheriting_member

-- sqlfmt-corpus-separator --

SELECT role, member, "isAdmin" FROM system.role_members

-- sqlfmt-corpus-separator --

SELECT rolname
FROM pg_catalog.pg_roles
ORDER BY rolname

-- sqlfmt-corpus-separator --

SELECT rolname, rolreplication FROM pg_catalog.pg_authid
ORDER BY rolname

-- sqlfmt-corpus-separator --

SELECT rolname, rolreplication FROM pg_catalog.pg_roles
ORDER BY rolname

-- sqlfmt-corpus-separator --

SELECT rolvaliduntil FROM pg_authid WHERE rolname = 'role_test_nodate';

-- sqlfmt-corpus-separator --

SELECT rolvaliduntil FROM pg_authid WHERE rolname = 'role_test_with_date';

-- sqlfmt-corpus-separator --

SELECT rolvaliduntil FROM pg_authid WHERE rolname = 'role_test_with_date_timezone';

-- sqlfmt-corpus-separator --

SELECT rolvaliduntil FROM pg_roles WHERE rolname = 'role_test_nodate';

-- sqlfmt-corpus-separator --

SELECT rolvaliduntil FROM pg_roles WHERE rolname = 'role_test_with_date';

-- sqlfmt-corpus-separator --

SELECT rolvaliduntil FROM pg_roles WHERE rolname = 'role_test_with_date_timezone';

-- sqlfmt-corpus-separator --

SELECT row_id, fingerprint, hint, created_at FROM system.statement_hints WHERE fingerprint = 'baz' ORDER BY row_id

-- sqlfmt-corpus-separator --

SELECT row_id, fingerprint, hint, created_at, hint_type, hint_name, enabled, database
FROM system.statement_hints ORDER BY row_id

-- sqlfmt-corpus-separator --

SELECT row_id, fingerprint, hint, created_at, hint_type, hint_name, enabled, database
FROM system.statement_hints WHERE fingerprint = 'bar' ORDER BY row_id

-- sqlfmt-corpus-separator --

SELECT row_id, fingerprint, hint, created_at, hint_type, hint_name, enabled, database
FROM system.statement_hints WHERE fingerprint = 'foo' ORDER BY row_id

-- sqlfmt-corpus-separator --

SELECT rowid FROM t WHERE a = 10

-- sqlfmt-corpus-separator --

SELECT rowid, foo.rowid FROM ab AS foo (foo1, foo2)

-- sqlfmt-corpus-separator --

SELECT s FROM rewind_session_test ORDER BY s

-- sqlfmt-corpus-separator --

SELECT schema_name FROM crdb_internal.ranges

-- sqlfmt-corpus-separator --

SELECT schema_name FROM information_schema.schemata WHERE crdb_is_user_defined = 'YES'

-- sqlfmt-corpus-separator --

SELECT schema_name FROM scdrop4_db.information_schema.schemata WHERE schema_name = 'scdrop4_db';

-- sqlfmt-corpus-separator --

SELECT schemaname, tablename, indexname, indexdef
FROM pg_indexes WHERE schemaname='test_schema' and tablename='test'
ORDER BY indexname

-- sqlfmt-corpus-separator --

SELECT schemaname, tablename, tableowner FROM pg_catalog.pg_tables WHERE tablename = 'a'

-- sqlfmt-corpus-separator --

SELECT sequenceowner, cache_size FROM pg_sequences WHERE sequencename = 'serial'

-- sqlfmt-corpus-separator --

SELECT settings FROM system.database_role_settings
WHERE database_id = 0 AND role_name = 'test_set_role'

-- sqlfmt-corpus-separator --

SELECT small.c FROM small WHERE EXISTS(SELECT 1 FROM large WHERE small.c = large.b AND large.d < 30)

-- sqlfmt-corpus-separator --

SELECT small.c FROM small WHERE NOT EXISTS(SELECT 1 FROM large WHERE small.c = large.b AND large.d < 30)

-- sqlfmt-corpus-separator --

SELECT start_pretty, end_pretty FROM crdb_internal.ranges_no_leases

-- sqlfmt-corpus-separator --

SELECT start_pretty, end_pretty, lease_holder FROM crdb_internal.ranges

-- sqlfmt-corpus-separator --

SELECT statement FROM pg_catalog.pg_cursors

-- sqlfmt-corpus-separator --

SELECT statement_id, txn_fingerprint_id, key, implicit_txn
  FROM crdb_internal.node_statement_statistics
 WHERE application_name = 'implicit_txn_test'
ORDER BY statement_id, key, implicit_txn;

-- sqlfmt-corpus-separator --

SELECT statement_id, txn_fingerprint_id, key, implicit_txn FROM crdb_internal.node_statement_statistics WHERE application_name = 'multi_stmts_test' ORDER BY key, txn_fingerprint_id

-- sqlfmt-corpus-separator --

SELECT status FROM last_inspect_job

-- sqlfmt-corpus-separator --

SELECT status, job_type FROM crdb_internal.jobs WHERE status='pending'

-- sqlfmt-corpus-separator --

SELECT string_field FROM test_collate WHERE string_field < 'baz' ORDER BY id

-- sqlfmt-corpus-separator --

SELECT string_field FROM test_collate WHERE string_field <= 'baz' ORDER BY id

-- sqlfmt-corpus-separator --

SELECT string_field FROM test_collate WHERE string_field > 'baz' ORDER BY id

-- sqlfmt-corpus-separator --

SELECT string_field FROM test_collate WHERE string_field >= 'baz' ORDER BY id

-- sqlfmt-corpus-separator --

SELECT t FROM t

-- sqlfmt-corpus-separator --

SELECT t.crdb_internal_idx_expr FROM t

-- sqlfmt-corpus-separator --

SELECT t.tableoid, t.nspname FROM pg_namespace t WHERE t.nspname = 'pg_catalog'

-- sqlfmt-corpus-separator --

SELECT t1._float8, t2._float4 FROM t67793 AS t1, t67793 AS t2 WHERE t1._float4 = t2._float8

-- sqlfmt-corpus-separator --

SELECT t1.k FROM t86075 AS t1, t86075_2 AS t2 WHERE t1.a = t2.a

-- sqlfmt-corpus-separator --

SELECT t1.k FROM t86075 AS t1, t86075_2 AS t2 WHERE t1.c = t2.c

-- sqlfmt-corpus-separator --

SELECT table_catalog, table_schema, table_name FROM information_schema.tables WHERE table_name = 'a'

-- sqlfmt-corpus-separator --

SELECT table_catalog, table_schema, table_name, column_name, column_comment
FROM information_schema.columns
WHERE table_name = 't1'

-- sqlfmt-corpus-separator --

SELECT table_catalog, table_schema, table_name, column_name, column_comment
FROM information_schema.columns
WHERE table_name = 't1' AND column_comment != ''

-- sqlfmt-corpus-separator --

SELECT table_catalog, table_schema, table_name, table_type, is_insertable_into
FROM system.information_schema.tables
WHERE
(table_schema <> 'crdb_internal' OR table_name = 'node_build_info')
AND NOT (table_schema = 'public' AND table_name <> 'locations')
ORDER BY table_name, table_schema

-- sqlfmt-corpus-separator --

SELECT table_id FROM crdb_internal.ranges

-- sqlfmt-corpus-separator --

SELECT table_name FROM crdb_internal.ranges

-- sqlfmt-corpus-separator --

SELECT table_name FROM information_schema.tables WHERE table_catalog = 'other_db'

-- sqlfmt-corpus-separator --

SELECT table_name FROM other_db.information_schema.tables WHERE table_catalog = 'other_db' AND table_schema = 'public'

-- sqlfmt-corpus-separator --

SELECT table_name FROM other_db.information_schema.tables WHERE table_name > 't'  ORDER BY 1 DESC

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, character_maximum_length, character_octet_length
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'char_len'

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, column_default
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'with_defaults'

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, data_type, crdb_sql_type, udt_catalog, udt_schema, udt_name, collation_catalog, collation_schema, collation_name
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'data_types'
ORDER BY column_name

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'nullability'

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, numeric_precision, numeric_precision_radix, numeric_scale, datetime_precision
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'num_prec'

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, numeric_precision, numeric_precision_radix, numeric_scale, datetime_precision
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'time_prec'

-- sqlfmt-corpus-separator --

SELECT table_name, index_name, full_config_sql FROM crdb_internal.zones WHERE
table_name='t38074'
ORDER BY index_name

-- sqlfmt-corpus-separator --

SELECT table_name, index_name, partition_name, raw_config_sql FROM crdb_internal.zones
WHERE table_name = 'copy_from_parent' AND index_name = 'primary' AND partition_name = 'p1'

-- sqlfmt-corpus-separator --

SELECT table_name, index_name, raw_config_sql FROM crdb_internal.zones
WHERE table_name = 'parent_modify' AND index_name = 'idx'

-- sqlfmt-corpus-separator --

SELECT table_name, raw_config_sql FROM crdb_internal.zones WHERE table_name = 'copy_from_parent'

-- sqlfmt-corpus-separator --

SELECT tablename FROM d34856.pg_catalog.pg_tables WHERE schemaname = 'public'

-- sqlfmt-corpus-separator --

SELECT tablename FROM pg_catalog.pg_tables

-- sqlfmt-corpus-separator --

SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname='public' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT tablename FROM pg_tables WHERE tablename = 'policy_table';

-- sqlfmt-corpus-separator --

SELECT tablename, indexdef FROM pg_indexes
WHERE tablename = 'MixedCase' AND indexname = 'IdX'

-- sqlfmt-corpus-separator --

SELECT tablename, indexname, indexdef
FROM pg_indexes
WHERE tablename = 'store_columns_test' AND indexname = 'idx1'

-- sqlfmt-corpus-separator --

SELECT tablename, tableowner FROM pg_tables WHERE tablename='t'

-- sqlfmt-corpus-separator --

SELECT tablename, tableowner FROM pg_tables WHERE tablename='t1'

-- sqlfmt-corpus-separator --

SELECT tablename, tableowner FROM pg_tables WHERE tablename='t2'

-- sqlfmt-corpus-separator --

SELECT tableoid, x FROM tab1

-- sqlfmt-corpus-separator --

SELECT tableoid, x FROM tab2

-- sqlfmt-corpus-separator --

SELECT tableowner FROM pg_tables WHERE schemaname = 'public' AND tablename = 't'

-- sqlfmt-corpus-separator --

SELECT target, range_name, database_name, table_name, index_name, partition_name
FROM crdb_internal.zones
ORDER BY target

-- sqlfmt-corpus-separator --

SELECT test_json -> 'field2' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json -> 'x' FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json -> 'x' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json -> 'x' FROM test_jsonb WHERE json_type = 'scalar'

-- sqlfmt-corpus-separator --

SELECT test_json -> 2 FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json -> 2 FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json -> 2 FROM test_jsonb WHERE json_type = 'scalar'

-- sqlfmt-corpus-separator --

SELECT test_json -> 9 FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field2' FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field2' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field2' FROM test_jsonb WHERE json_type = 'scalar'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field4' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field5' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field6' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 2 FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 2 FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 2 FROM test_jsonb WHERE json_type = 'scalar'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 6 FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 7 FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT tgenabled FROM pg_trigger WHERE tgname = 'insert_trigger';

-- sqlfmt-corpus-separator --

SELECT tgname, tgoldtable, tgnewtable
FROM pg_catalog.pg_trigger
WHERE tgname = 'after_update_transition';

-- sqlfmt-corpus-separator --

SELECT title FROM users

-- sqlfmt-corpus-separator --

SELECT token FROM u WHERE token='urn:uuid:63616665-6630-3064-6465-616462656562'

-- sqlfmt-corpus-separator --

SELECT token2 FROM u WHERE token2='63616665-6630-3064-6465-616462656563'

-- sqlfmt-corpus-separator --

SELECT transaction, gid, owner, database FROM pg_catalog.pg_prepared_xacts

-- sqlfmt-corpus-separator --

SELECT trigger_name, op FROM trigger_audit ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT trigger_name, op, new_a FROM trigger_audit ORDER BY id;

-- sqlfmt-corpus-separator --

SELECT true FROM t87619 GROUP BY b HAVING b

-- sqlfmt-corpus-separator --

SELECT ts FROM untyped WHERE ts != '2015-09-18 00:00:00'

-- sqlfmt-corpus-separator --

SELECT txn_count - committed_count = 0
  FROM crdb_internal.node_txn_stats
 WHERE application_name = 'test'

-- sqlfmt-corpus-separator --

SELECT txn_count - implicit_count = 1
  FROM crdb_internal.node_txn_stats
 WHERE application_name = 'test'

-- sqlfmt-corpus-separator --

SELECT txn_count = implicit_count
  FROM crdb_internal.node_txn_stats
 WHERE application_name = 'test'

-- sqlfmt-corpus-separator --

SELECT typacl FROM pg_type WHERE typname = 'acl_test_type'

-- sqlfmt-corpus-separator --

SELECT typacl FROM pg_type WHERE typname = 'int4'

-- sqlfmt-corpus-separator --

SELECT typname FROM pg_type WHERE typname = 'd_int'

-- sqlfmt-corpus-separator --

SELECT typname FROM pg_type WHERE typname = 'date'

-- sqlfmt-corpus-separator --

SELECT u || 'foo' FROM t83093

-- sqlfmt-corpus-separator --

SELECT u.key, t.str FROM t, u WHERE t.k = u.key AND t.k >= 3

-- sqlfmt-corpus-separator --

SELECT usage_count
FROM crdb_internal.feature_usage
WHERE feature_name = 'sql.session.statement-hints'

-- sqlfmt-corpus-separator --

SELECT usage_count > 0 FROM crdb_internal.feature_usage WHERE feature_name = 'sql.plan.opt.node.sort'

-- sqlfmt-corpus-separator --

SELECT used > 0, reserved_used > 0, used < reserved_used, stopped FROM crdb_internal.node_memory_monitors WHERE name = 'root'

-- sqlfmt-corpus-separator --

SELECT used > 0, stopped FROM crdb_internal.node_memory_monitors WHERE name = 'sql'

-- sqlfmt-corpus-separator --

SELECT usename, usesysid, usecreatedb, usesuper, userepl, usebypassrls, passwd, valuntil, useconfig
FROM pg_catalog.pg_user
ORDER BY usename

-- sqlfmt-corpus-separator --

SELECT usename, valuntil
FROM pg_user
WHERE usename = 'regression_70180'

-- sqlfmt-corpus-separator --

SELECT user_id_1, user_id_2, text FROM messages ORDER BY message_id ASC

-- sqlfmt-corpus-separator --

SELECT user_name, query, phase FROM crdb_internal.cluster_queries WHERE txn_id='$txn2'

-- sqlfmt-corpus-separator --

SELECT user_name, query, phase FROM crdb_internal.cluster_queries WHERE txn_id='$txn4'

-- sqlfmt-corpus-separator --

SELECT user_profile FROM users WHERE user_profile @> '{"first_name":"Ernie"}';

-- sqlfmt-corpus-separator --

SELECT user_profile FROM users WHERE user_profile @> '{"first_name":"Lola"}';

-- sqlfmt-corpus-separator --

SELECT username FROM system.users WHERE username = 'root'

-- sqlfmt-corpus-separator --

SELECT username, "hashedPassword" FROM system.users WHERE username = 'testuser'

-- sqlfmt-corpus-separator --

SELECT username, option, value FROM system.role_options

-- sqlfmt-corpus-separator --

SELECT username, option, value FROM system.role_options ORDER BY username

-- sqlfmt-corpus-separator --

SELECT username, path, privileges, grant_options  FROM system.privileges ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT username, path, privileges, grant_options FROM system.privileges

-- sqlfmt-corpus-separator --

SELECT username, path, privileges, grant_options FROM system.privileges
WHERE username = 'testuser' AND path = '/global/'

-- sqlfmt-corpus-separator --

SELECT username, path, privileges, grant_options FROM system.privileges ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT username, path, privileges, grant_options FROM system.privileges ORDER BY username

-- sqlfmt-corpus-separator --

SELECT username, path, privileges, grant_options FROM system.privileges ORDER by username

-- sqlfmt-corpus-separator --

SELECT v @@ q FROM a

-- sqlfmt-corpus-separator --

SELECT v FROM kv

-- sqlfmt-corpus-separator --

SELECT v FROM kv ORDER BY k

-- sqlfmt-corpus-separator --

SELECT v FROM kv ORDER BY v DESC

-- sqlfmt-corpus-separator --

SELECT v, k FROM kv

-- sqlfmt-corpus-separator --

SELECT v, k, k, v FROM kv

-- sqlfmt-corpus-separator --

SELECT v, w FROM t WHERE k = 23

-- sqlfmt-corpus-separator --

SELECT v1<->v2, v1<#>v2, v1<=>v2, v1+v2, v1-v2, v1*v2 FROM v3

-- sqlfmt-corpus-separator --

SELECT val FROM t_vc

-- sqlfmt-corpus-separator --

SELECT value FROM boolean_table

-- sqlfmt-corpus-separator --

SELECT value FROM system.role_options
WHERE username = 'role_with_provisioning'
AND option = 'PROVISIONSRC'

-- sqlfmt-corpus-separator --

SELECT value FROM system.role_options
WHERE username = 'role_with_provisioning_2'
AND option = 'PROVISIONSRC'

-- sqlfmt-corpus-separator --

SELECT value FROM system.role_options
WHERE username = 'role_with_provisioning_3'
AND option = 'PROVISIONSRC'

-- sqlfmt-corpus-separator --

SELECT value FROM system.role_options
WHERE username = 'role_with_subject'
AND option = 'SUBJECT'

-- sqlfmt-corpus-separator --

SELECT viewname FROM pg_catalog.pg_views WHERE schemaname='public' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT viewowner FROM pg_views WHERE schemaname = 'public' AND viewname = 'vx'

-- sqlfmt-corpus-separator --

SELECT vis1, hid1 FROM t_with_hidden ORDER BY vis1

-- sqlfmt-corpus-separator --

SELECT v||'foo' FROM kv

-- sqlfmt-corpus-separator --

SELECT w FROM t ORDER BY k LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT w FROM t3 WHERE v > 0 AND v < 100 ORDER BY v

-- sqlfmt-corpus-separator --

SELECT which, name FROM prep_stmts ORDER BY which, name

-- sqlfmt-corpus-separator --

SELECT x + 1 FROM a

-- sqlfmt-corpus-separator --

SELECT x + 1, x + y FROM a WHERE x + y > 20

-- sqlfmt-corpus-separator --

SELECT x FROM b WHERE b.rowid > 0

-- sqlfmt-corpus-separator --

SELECT x FROM b WHERE rowid > 0

-- sqlfmt-corpus-separator --

SELECT x FROM enum_data_type

-- sqlfmt-corpus-separator --

SELECT x FROM greeting_stats

-- sqlfmt-corpus-separator --

SELECT x FROM kv;

-- sqlfmt-corpus-separator --

SELECT x FROM nan ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM onecolumn AS a, onecolumn AS b

-- sqlfmt-corpus-separator --

SELECT x FROM pg_type

-- sqlfmt-corpus-separator --

SELECT x FROM t

-- sqlfmt-corpus-separator --

SELECT x FROM t GROUP BY x

-- sqlfmt-corpus-separator --

SELECT x FROM t ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM t ORDER BY x DESC

-- sqlfmt-corpus-separator --

SELECT x FROM t1 ORDER BY x ASC

-- sqlfmt-corpus-separator --

SELECT x FROM t1 ORDER BY x ASC LIMIT 3

-- sqlfmt-corpus-separator --

SELECT x FROM t1 ORDER BY x DESC

-- sqlfmt-corpus-separator --

SELECT x FROM t1 ORDER BY x DESC LIMIT 3

-- sqlfmt-corpus-separator --

SELECT x FROM t16 ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM t2 WHERE x > (SELECT x FROM t1 ORDER BY x LIMIT 1)

-- sqlfmt-corpus-separator --

SELECT x FROM t23 ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM t28 ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM t29 ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM t35364

-- sqlfmt-corpus-separator --

SELECT x FROM tarray ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM test WHERE y = 1/z

-- sqlfmt-corpus-separator --

SELECT x FROM test where y=1;

-- sqlfmt-corpus-separator --

SELECT x FROM tjson ORDER BY x, rowid

-- sqlfmt-corpus-separator --

SELECT x FROM uniq GROUP BY v

-- sqlfmt-corpus-separator --

SELECT x FROM uniq GROUP BY v ORDER BY v

-- sqlfmt-corpus-separator --

SELECT x FROM v2

-- sqlfmt-corpus-separator --

SELECT x FROM v7

-- sqlfmt-corpus-separator --

SELECT x FROM v7 ORDER BY x LIMIT 1

-- sqlfmt-corpus-separator --

SELECT x FROM xyz ORDER BY x OFFSET (SELECT x FROM xyz WHERE x = 1)

-- sqlfmt-corpus-separator --

SELECT x FROM xyz WHERE x = 7 LIMIT (SELECT x FROM xyz WHERE x = 1)

-- sqlfmt-corpus-separator --

SELECT x FROM y ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x || x FROM t;

-- sqlfmt-corpus-separator --

SELECT x, X, "Y" FROM foo

-- sqlfmt-corpus-separator --

SELECT x, crdb_internal_origin_id FROM origin_id_tab

-- sqlfmt-corpus-separator --

SELECT x, crdb_internal_origin_timestamp FROM origin_id_tab

-- sqlfmt-corpus-separator --

SELECT x, x + 1, y, y + 1, x + y FROM a

-- sqlfmt-corpus-separator --

SELECT x, x, y, x FROM a

-- sqlfmt-corpus-separator --

SELECT x, y FROM t ORDER BY x, y

-- sqlfmt-corpus-separator --

SELECT x, y FROM t WHERE x < y

-- sqlfmt-corpus-separator --

SELECT x, y FROM t WHERE x > y

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

SELECT x, y FROM xy ORDER BY x, y

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

SELECT x, y, z FROM family

-- sqlfmt-corpus-separator --

SELECT x.c AS v1, y.c AS v2,
       x.c & y.c AS "and",
       x.c | y.c AS "or",
       x.c # y.c AS "xor"
FROM bits x, bits y

-- sqlfmt-corpus-separator --

SELECT x.c, ~x.c AS comp FROM bits x

-- sqlfmt-corpus-separator --

SELECT x.tableoid, x.extname FROM pg_extension x

-- sqlfmt-corpus-separator --

SELECT x1, x1 < 'hello' FROM greeting_table

-- sqlfmt-corpus-separator --

SELECT y FROM NumToStr ORDER BY str LIMIT 5

-- sqlfmt-corpus-separator --

SELECT y FROM NumToStr ORDER BY y LIMIT 0

-- sqlfmt-corpus-separator --

SELECT y FROM NumToStr ORDER BY y LIMIT 5

-- sqlfmt-corpus-separator --

SELECT y FROM NumToStr ORDER BY y OFFSET 5 LIMIT 2

-- sqlfmt-corpus-separator --

SELECT y FROM NumToStr WHERE y < 1000 OR y > 9000 ORDER BY y DESC LIMIT 5

-- sqlfmt-corpus-separator --

SELECT y FROM v WHERE y > 4

-- sqlfmt-corpus-separator --

SELECT y FROM v2

-- sqlfmt-corpus-separator --

SELECT y FROM v7

-- sqlfmt-corpus-separator --

SELECT y FROM v7 ORDER BY x LIMIT 1

-- sqlfmt-corpus-separator --

SELECT y, z FROM t WHERE x = 2

-- sqlfmt-corpus-separator --

SELECT y, z FROM t_rename_computed;

-- sqlfmt-corpus-separator --

SELECT y, z FROM xyz

-- sqlfmt-corpus-separator --

SELECT z FROM test where y=2;

-- sqlfmt-corpus-separator --

SELECT z FROM xyz WHERE y = 1

-- sqlfmt-corpus-separator --

SELECT zone_id, target FROM crdb_internal.zones ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT ~'0';

-- sqlfmt-corpus-separator --

SELECT ~'1';

-- sqlfmt-corpus-separator --

SELECT ~0;

-- sqlfmt-corpus-separator --

SELECT ~1;

-- sqlfmt-corpus-separator --

SELECT ~2;

-- sqlfmt-corpus-separator --

WITH
    t AS (SELECT true),
    t AS (SELECT false)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH a AS (SELECT a FROM ab ORDER BY b) SELECT * FROM a

-- sqlfmt-corpus-separator --

WITH cte AS (SELECT x*10+y FROM xy ORDER BY x+y LIMIT 3) SELECT * FROM cte

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

WITH t(x) AS (WITH t(x) AS (SELECT 1) SELECT x * 10 FROM t) SELECT x + 2 FROM t

-- sqlfmt-corpus-separator --

select "eventType" from system.eventlog WHERE "eventType" <> 'finish_schema_change' order by timestamp desc limit 1;

-- sqlfmt-corpus-separator --

select "eventType" from system.eventlog order by timestamp desc limit 1;

-- sqlfmt-corpus-separator --

select (x/1) from t39417

-- sqlfmt-corpus-separator --

select * FROM d ORDER BY i

-- sqlfmt-corpus-separator --

select * FROM f ORDER BY i

-- sqlfmt-corpus-separator --

select * FROM i ORDER BY i

-- sqlfmt-corpus-separator --

select * FROM multip ORDER BY key, value;

-- sqlfmt-corpus-separator --

select * from baz;

-- sqlfmt-corpus-separator --

select * from crdb_internal.gossip_alerts

-- sqlfmt-corpus-separator --

select * from crdb_internal.gossip_liveness

-- sqlfmt-corpus-separator --

select * from crdb_internal.gossip_nodes

-- sqlfmt-corpus-separator --

select * from crdb_internal.kv_node_status

-- sqlfmt-corpus-separator --

select * from crdb_internal.kv_store_status

-- sqlfmt-corpus-separator --

select * from crdb_internal.leases;

-- sqlfmt-corpus-separator --

select * from crdb_internal.node_inflight_trace_spans

-- sqlfmt-corpus-separator --

select * from crdb_internal.node_metrics

-- sqlfmt-corpus-separator --

select * from crdb_internal.node_runtime_info

-- sqlfmt-corpus-separator --

select * from crdb_internal.ranges

-- sqlfmt-corpus-separator --

select * from current_timestamp_test WHERE a - interval '3h' <> b

-- sqlfmt-corpus-separator --

select * from d46224.t;

-- sqlfmt-corpus-separator --

select * from foo

-- sqlfmt-corpus-separator --

select * from interval_duration_type order by id asc

-- sqlfmt-corpus-separator --

select * from multip ORDER BY key, value;

-- sqlfmt-corpus-separator --

select * from multip where key >= 0 ORDER BY key, value;

-- sqlfmt-corpus-separator --

select * from pg_catalog.pg_attrdef;

-- sqlfmt-corpus-separator --

select * from sbv1

-- sqlfmt-corpus-separator --

select * from t

-- sqlfmt-corpus-separator --

select * from t;

-- sqlfmt-corpus-separator --

select * from t_multi_alter order by c1;

-- sqlfmt-corpus-separator --

select * from td3

-- sqlfmt-corpus-separator --

select 1, 2; select 1, 2, 3; select 'ok'

-- sqlfmt-corpus-separator --

select 1; BEGIN; select 1; select 1; COMMIT

-- sqlfmt-corpus-separator --

select a, b from decomputed_column order by a

-- sqlfmt-corpus-separator --

select c1 from rlsInsert ORDER BY c1;

-- sqlfmt-corpus-separator --

select counter from cnt;

-- sqlfmt-corpus-separator --

select create_statement from crdb_internal.create_statements where descriptor_name='flying_roaches'

-- sqlfmt-corpus-separator --

select create_statement from crdb_internal.create_statements where descriptor_name='roaches'

-- sqlfmt-corpus-separator --

select data_type, column_default from information_schema.columns where table_name = 't2' and column_name = 'a';

-- sqlfmt-corpus-separator --

select fk_statements from crdb_internal.create_statements where descriptor_name='flying_roaches'

-- sqlfmt-corpus-separator --

select fk_statements from crdb_internal.create_statements where descriptor_name='roaches'

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id1';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id10';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id11';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id12';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id13';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id14';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id15';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id16';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id17';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id18';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id19';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id2';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id20';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id21';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id22';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id23';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id24';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id25';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id26';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id27';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id28';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id3';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id4';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id5';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id6';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id7';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id8';

-- sqlfmt-corpus-separator --

select identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle from information_schema.columns where table_name = 't' and column_name='id9';

-- sqlfmt-corpus-separator --

select indexdef from pg_indexes where indexname = 'regression_46450_idx'

-- sqlfmt-corpus-separator --

select name from system.settings

-- sqlfmt-corpus-separator --

select name, statement, parameter_types, result_types, from_sql from pg_prepared_statements ORDER BY 1, 2

-- sqlfmt-corpus-separator --

select polqual from pg_catalog.pg_policy

-- sqlfmt-corpus-separator --

select polwithcheck from pg_catalog.pg_policy

-- sqlfmt-corpus-separator --

select qual, with_check from pg_catalog.pg_policies where tablename = 'funcref'

-- sqlfmt-corpus-separator --

select relname, relrowsecurity, relforcerowsecurity from pg_class where relname = 'roaches';

-- sqlfmt-corpus-separator --

select rls_col, uniq_col FROM uniq ORDER BY uniq_col;

-- sqlfmt-corpus-separator --

select rls_statements from crdb_internal.create_statements where descriptor_name='flying_roaches'

-- sqlfmt-corpus-separator --

select rls_statements from crdb_internal.create_statements where descriptor_name='roaches'

-- sqlfmt-corpus-separator --

select rls_statements, fk_statements, create_nofks from crdb_internal.create_statements where descriptor_name='roaches'

-- sqlfmt-corpus-separator --

select schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check from pg_catalog.pg_policies

-- sqlfmt-corpus-separator --

select schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check from pg_catalog.pg_policies where tablename = 'multi_pol_tab2'

-- sqlfmt-corpus-separator --

select schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check from pg_catalog.pg_policies where tablename = 'multi_pol_tab3'

-- sqlfmt-corpus-separator --

select table_name, estimated_row_count from crdb_internal.table_row_statistics
  WHERE table_id < 1000 OR table_name = 'table_row_statistics';

-- sqlfmt-corpus-separator --

select table_schema, table_name FROM information_schema.tables
WHERE (table_schema <> 'crdb_internal' OR table_name = 'node_build_info');

-- sqlfmt-corpus-separator --

select team, league from bbteams order by league, team;

-- sqlfmt-corpus-separator --

select team, league from bbteams where team != 'astros' order by league, team;

-- sqlfmt-corpus-separator --

select team, league from bbteams where team != 'cardinals' order by league, team;

-- sqlfmt-corpus-separator --

select team, league from bbteams where team != 'jays' order by league, team;

-- sqlfmt-corpus-separator --

select team, league from bbteams where team != 'mariners' order by league, team;

-- sqlfmt-corpus-separator --

select team, league from bbteams where team != 'pirates' order by league, team;

-- sqlfmt-corpus-separator --

select team, league, wins from bbteams order by team;

-- sqlfmt-corpus-separator --

select udt_schema, udt_name, data_type
from information_schema.columns
where table_name = 't'
ORDER BY udt_name

-- sqlfmt-corpus-separator --

select x, y FROM td2

-- sqlfmt-corpus-separator --

select x/1 from t39417