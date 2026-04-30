/*
 * This test is intended to pass on all platforms supported by Postgres.
 * We can therefore only assume that the default, C, and POSIX collations
 * are available --- and since the regression tests are often run in a
 * C-locale database, these may well all have the same behavior.  But
 * fortunately, the system doesn't know that and will treat them as
 * incompatible collations.  It is therefore at least possible to test
 * parser behaviors such as collation conflict resolution.  This test will,
 * however, be more revealing when run in a database with non-C locale,
 * since any departure from C sorting behavior will show as a failure.
 */

CREATE SCHEMA collate_tests

-- sqlfmt-corpus-separator --

/* If objects exist, return oids */

CREATE ROLE regress_regrole_test

-- sqlfmt-corpus-separator --

ABORT

-- sqlfmt-corpus-separator --

ALTER DATABASE regression_utf8 OWNER TO regress_datdba_before

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE pg_read_all_settings
	REVOKE USAGE ON TYPES FROM pg_read_all_settings

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE pg_signal_backend
	REVOKE USAGE ON TYPES FROM pg_signal_backend

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE regress_addr_user IN SCHEMA public GRANT ALL ON TABLES TO regress_addr_user

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE regress_addr_user REVOKE DELETE ON TABLES FROM regress_addr_user

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE regress_dep_user1 IN SCHEMA deptest
  GRANT ALL ON TABLES TO regress_dep_user2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE regress_matview_user
  GRANT INSERT ON TABLES TO regress_matview_user

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE regress_matview_user
  REVOKE INSERT ON TABLES FROM regress_matview_user

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE regress_priv_user1 REVOKE USAGE ON TYPES FROM public

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE regress_selinto_user
	  GRANT INSERT ON TABLES TO regress_selinto_user

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE regress_selinto_user
	  REVOKE INSERT ON TABLES FROM regress_selinto_user

-- sqlfmt-corpus-separator --

ALTER INDEX IF EXISTS __attmp_onek_unique1 RENAME TO onek_unique1

-- sqlfmt-corpus-separator --

ALTER INDEX IF EXISTS __onek_unique1 RENAME TO attmp_onek_unique1

-- sqlfmt-corpus-separator --

ALTER INDEX alter_idx_rename_test RENAME TO alter_idx_rename_test_2

-- sqlfmt-corpus-separator --

ALTER INDEX alter_idx_rename_test_idx RENAME TO alter_idx_rename_test_idx_2

-- sqlfmt-corpus-separator --

ALTER INDEX alter_idx_rename_test_parted RENAME TO alter_idx_rename_test_parted_2

-- sqlfmt-corpus-separator --

ALTER INDEX alter_idx_rename_test_parted_idx RENAME TO alter_idx_rename_test_parted_idx_2

-- sqlfmt-corpus-separator --

ALTER INDEX attmp_onek_unique1 RENAME TO onek_unique1

-- sqlfmt-corpus-separator --

ALTER INDEX onek_unique1 RENAME TO attmp_onek_unique1

-- sqlfmt-corpus-separator --

ALTER INDEX onek_unique1 RENAME TO fail

-- sqlfmt-corpus-separator --

ALTER INDEX onek_unique1_constraint RENAME TO onek_unique1_constraint_foo

-- sqlfmt-corpus-separator --

ALTER INDEX part_attmp1_index RENAME TO fail

-- sqlfmt-corpus-separator --

ALTER INDEX part_attmp1_pkey RENAME TO part_attmp1_index

-- sqlfmt-corpus-separator --

ALTER INDEX part_attmp_index RENAME TO fail

-- sqlfmt-corpus-separator --

ALTER INDEX part_attmp_pkey RENAME TO part_attmp_index

-- sqlfmt-corpus-separator --

ALTER ROLE  regress_passwd4 PASSWORD 'foo'

-- sqlfmt-corpus-separator --

ALTER ROLE regress_createdb CREATEDB

-- sqlfmt-corpus-separator --

ALTER ROLE regress_createdb NOCREATEDB

-- sqlfmt-corpus-separator --

ALTER ROLE regress_createdb NOSUPERUSER

-- sqlfmt-corpus-separator --

ALTER ROLE regress_createdb SUPERUSER

-- sqlfmt-corpus-separator --

ALTER ROLE regress_passwd1 PASSWORD 'md5cd3578025fe2c3d7ed1b9a9b26238b70'

-- sqlfmt-corpus-separator --

ALTER ROLE regress_passwd1 PASSWORD 'role_pwd1'

-- sqlfmt-corpus-separator --

ALTER ROLE regress_passwd2 PASSWORD 'foo'

-- sqlfmt-corpus-separator --

ALTER ROLE regress_passwd2 PASSWORD 'role_pwd2'

-- sqlfmt-corpus-separator --

ALTER ROLE regress_passwd3 PASSWORD 'SCRAM-SHA-256$4096:VLK4RMaQLCvNtQ==$6YtlR4t69SguDiwFvbVgVZtuz6gpJQQqUMZ7IQJK5yI=:ps75jrHeYU4lXCcXI4O8oIdJ3eO8o2jirjruw9phBTo='

-- sqlfmt-corpus-separator --

ALTER ROLE regress_passwd9 PASSWORD 'SCRAM-SHA-256$000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004096:wNFxNSk1hAXBkgub8py3bg==$65zC6E+R0U7tiYTC9+Wtq4Thw6gUDj3eDCINij8TflU=:rC1I7tcVugrHEY2DT0iPjGyjM4aJxkMM9n8WBxtUtHU='

-- sqlfmt-corpus-separator --

ALTER ROLE regress_passwd_empty PASSWORD 'SCRAM-SHA-256$4096:hpFyHTUsSWcR7O9P$LgZFIt6Oqdo27ZFKbZ2nV+vtnYM995pDh9ca6WSi120=:qVV5NeluNfUPkwm7Vqat25RjSPLkGeoZBQs6wVv+um4='

-- sqlfmt-corpus-separator --

ALTER ROLE regress_passwd_empty PASSWORD 'md585939a5ce845f1a1b620742e3c659e0a'

-- sqlfmt-corpus-separator --

ALTER ROLE regress_priv_user1 NOINHERIT

-- sqlfmt-corpus-separator --

ALTER ROLE regress_rol_lock1 SET search_path = lock_schema1

-- sqlfmt-corpus-separator --

ALTER ROLE regress_role_limited CREATEDB

-- sqlfmt-corpus-separator --

ALTER ROLE regress_role_limited SUPERUSER

-- sqlfmt-corpus-separator --

ALTER ROLE regress_test_createdb WITH CREATEDB

-- sqlfmt-corpus-separator --

ALTER ROLE regress_test_createdb WITH NOCREATEDB

-- sqlfmt-corpus-separator --

ALTER ROLE regress_test_createrole WITH CREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE regress_test_createrole WITH NOCREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE regress_test_inherit WITH INHERIT

-- sqlfmt-corpus-separator --

ALTER ROLE regress_test_inherit WITH NOINHERIT

-- sqlfmt-corpus-separator --

ALTER ROLE regress_test_role_canlogin WITH LOGIN

-- sqlfmt-corpus-separator --

ALTER ROLE regress_test_role_canlogin WITH NOLOGIN

-- sqlfmt-corpus-separator --

ALTER ROLE regress_test_role_super NOSUPERUSER

-- sqlfmt-corpus-separator --

ALTER ROLE regress_test_superuser WITH NOSUPERUSER

-- sqlfmt-corpus-separator --

ALTER ROLE regress_test_superuser WITH SUPERUSER

-- sqlfmt-corpus-separator --

ALTER SCHEMA regress_tenant2_schema OWNER TO regress_createrole

-- sqlfmt-corpus-separator --

ALTER SCHEMA regress_tenant2_schema OWNER TO regress_tenant2

-- sqlfmt-corpus-separator --

ALTER SCHEMA tableam_display OWNER TO regress_display_role

-- sqlfmt-corpus-separator --

ALTER SCHEMA test_ns_schema_1 RENAME TO test_ns_schema_renamed

-- sqlfmt-corpus-separator --

ALTER SCHEMA testns OWNER TO regress_schemauser2

-- sqlfmt-corpus-separator --

ALTER TABLE IF EXISTS tt8 ADD COLUMN f int

-- sqlfmt-corpus-separator --

ALTER TABLE PKTABLE OWNER to regress_foreign_key_user

-- sqlfmt-corpus-separator --

ALTER TABLE alter_idx_rename_test_idx_2 RENAME TO alter_idx_rename_test_idx_3

-- sqlfmt-corpus-separator --

ALTER TABLE alter_idx_rename_test_parted_idx_2 RENAME TO alter_idx_rename_test_parted_idx_3

-- sqlfmt-corpus-separator --

ALTER TABLE atest6 ADD COLUMN three integer

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN a int4

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN b name

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN c text

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN d float8

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN e float4

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN f int2

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN g polygon

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN i char

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN k int4

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN l tid

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN m xid

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN n oidvector

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN p boolean

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN q point

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN r lseg

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN s path

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN t box

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN v timestamp

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN w interval

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN x float8[]

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN xmin integer

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN y float4[]

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ADD COLUMN z int2[]

-- sqlfmt-corpus-separator --

ALTER TABLE attmp RENAME TO attmp_new

-- sqlfmt-corpus-separator --

ALTER TABLE attmp RENAME TO attmp_new2

-- sqlfmt-corpus-separator --

ALTER TABLE attmp_array RENAME TO _attmp_array

-- sqlfmt-corpus-separator --

ALTER TABLE attmp_array2 RENAME TO _attmp_array

-- sqlfmt-corpus-separator --

ALTER TABLE attmp_view RENAME TO attmp_view_new

-- sqlfmt-corpus-separator --

ALTER TABLE clstr_1 OWNER TO regress_clstr_user

-- sqlfmt-corpus-separator --

ALTER TABLE clstr_3 OWNER TO regress_clstr_user

-- sqlfmt-corpus-separator --

ALTER TABLE concur_reindex_tab ADD COLUMN c2 text

-- sqlfmt-corpus-separator --

ALTER TABLE datdba_only OWNER TO pg_database_owner

-- sqlfmt-corpus-separator --

ALTER TABLE f_star ADD COLUMN f int4

-- sqlfmt-corpus-separator --

ALTER TABLE fd_pt1 ADD COLUMN c6 integer

-- sqlfmt-corpus-separator --

ALTER TABLE fd_pt1 ADD COLUMN c8 integer

-- sqlfmt-corpus-separator --

ALTER TABLE foo_seq RENAME TO foo_seq_new

-- sqlfmt-corpus-separator --

ALTER TABLE itest8
  ADD COLUMN f4 int

-- sqlfmt-corpus-separator --

ALTER TABLE new_system_table RENAME TO old_system_table

-- sqlfmt-corpus-separator --

ALTER TABLE not_owned_by_me OWNER TO regress_test_not_me

-- sqlfmt-corpus-separator --

ALTER TABLE part_2 ADD COLUMN c text

-- sqlfmt-corpus-separator --

ALTER TABLE part_at2tmp RENAME TO fail

-- sqlfmt-corpus-separator --

ALTER TABLE part_at2tmp1 RENAME TO fail

-- sqlfmt-corpus-separator --

ALTER TABLE part_attmp RENAME TO part_at2tmp

-- sqlfmt-corpus-separator --

ALTER TABLE part_attmp1 RENAME TO part_at2tmp1

-- sqlfmt-corpus-separator --

ALTER TABLE part_c_100_200 ADD COLUMN b bigint

-- sqlfmt-corpus-separator --

ALTER TABLE pcachetest ADD COLUMN q3 bigint

-- sqlfmt-corpus-separator --

ALTER TABLE persons ADD COLUMN comment text

-- sqlfmt-corpus-separator --

ALTER TABLE ptnowner OWNER TO regress_ptnowner

-- sqlfmt-corpus-separator --

ALTER TABLE ptnowner1 OWNER TO regress_ptnowner

-- sqlfmt-corpus-separator --

ALTER TABLE regress_roleoption.t1 OWNER TO regress_roleoption_donor

-- sqlfmt-corpus-separator --

ALTER TABLE regress_roleoption.t2 OWNER TO regress_roleoption_recipient

-- sqlfmt-corpus-separator --

ALTER TABLE regress_roleoption.t3 OWNER TO regress_roleoption_protagonist

-- sqlfmt-corpus-separator --

ALTER TABLE regress_roleoption.t4 OWNER TO regress_roleoption_protagonist

-- sqlfmt-corpus-separator --

ALTER TABLE ruletest_t1 OWNER TO regress_rule_user1

-- sqlfmt-corpus-separator --

ALTER TABLE seclabel_tbl1 OWNER TO regress_seclabel_user1

-- sqlfmt-corpus-separator --

ALTER TABLE seclabel_tbl2 OWNER TO regress_seclabel_user2

-- sqlfmt-corpus-separator --

ALTER TABLE serialtest1_f2_seq RENAME TO serialtest1_f2_foo

-- sqlfmt-corpus-separator --

ALTER TABLE sl ADD COLUMN bool_col boolean

-- sqlfmt-corpus-separator --

ALTER TABLE source OWNER TO regress_merge_privs

-- sqlfmt-corpus-separator --

ALTER TABLE source2 OWNER TO regress_merge_no_privs

-- sqlfmt-corpus-separator --

ALTER TABLE sro_part OWNER TO regress_sro_user

-- sqlfmt-corpus-separator --

ALTER TABLE sro_ptab OWNER TO regress_sro_user

-- sqlfmt-corpus-separator --

ALTER TABLE sro_tab OWNER TO regress_sro_user

-- sqlfmt-corpus-separator --

ALTER TABLE stats_ext_tbl OWNER TO regress_stats_user1

-- sqlfmt-corpus-separator --

ALTER TABLE sts_sch1.tbl OWNER TO regress_stats_user1

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN x int

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN y int

-- sqlfmt-corpus-separator --

ALTER TABLE t OWNER TO regress_partition_merge_bob

-- sqlfmt-corpus-separator --

ALTER TABLE t OWNER TO regress_partition_split_bob

-- sqlfmt-corpus-separator --

ALTER TABLE t1 ADD COLUMN c text

-- sqlfmt-corpus-separator --

ALTER TABLE t1 OWNER TO regress_rls_alice

-- sqlfmt-corpus-separator --

ALTER TABLE t2 ADD COLUMN d domain4

-- sqlfmt-corpus-separator --

ALTER TABLE t2 ADD COLUMN e domain2

-- sqlfmt-corpus-separator --

ALTER TABLE target OWNER TO regress_merge_privs

-- sqlfmt-corpus-separator --

ALTER TABLE target2 OWNER TO regress_merge_no_privs

-- sqlfmt-corpus-separator --

ALTER TABLE tenant2_table OWNER TO regress_createrole

-- sqlfmt-corpus-separator --

ALTER TABLE tenant2_table OWNER TO regress_tenant2

-- sqlfmt-corpus-separator --

ALTER TABLE tenant_table ADD COLUMN t text

-- sqlfmt-corpus-separator --

ALTER TABLE test9a ADD COLUMN c priv_testdomain1

-- sqlfmt-corpus-separator --

ALTER TABLE test9b ADD COLUMN c priv_testdomain1

-- sqlfmt-corpus-separator --

ALTER TABLE test_add_domain_col ADD COLUMN a1 domain5

-- sqlfmt-corpus-separator --

ALTER TABLE test_add_domain_col ADD COLUMN b domain5

-- sqlfmt-corpus-separator --

ALTER TABLE test_add_domain_col ADD COLUMN b domain8

-- sqlfmt-corpus-separator --

ALTER TABLE test_add_domain_col ADD COLUMN d domain6

-- sqlfmt-corpus-separator --

ALTER TABLE test_add_domain_col ADD COLUMN f domain7

-- sqlfmt-corpus-separator --

ALTER TABLE test_tsquery ADD COLUMN sample tsquery

-- sqlfmt-corpus-separator --

ALTER TABLE test_type_diff ADD COLUMN f2 int

-- sqlfmt-corpus-separator --

ALTER TABLE testschema.tablespace_acl OWNER TO regress_tablespace_user2

-- sqlfmt-corpus-separator --

ALTER TABLE tmp1 RENAME TO tx1

-- sqlfmt-corpus-separator --

ALTER TABLE toast_3b_utf8 RENAME TO toast_4b_utf8

-- sqlfmt-corpus-separator --

ALTER TABLE tp_0_1 OWNER TO regress_partition_merge_alice

-- sqlfmt-corpus-separator --

ALTER TABLE tp_0_1 OWNER TO regress_partition_merge_bob

-- sqlfmt-corpus-separator --

ALTER TABLE tp_0_2 OWNER TO regress_partition_split_bob

-- sqlfmt-corpus-separator --

ALTER TABLE tp_1_2 OWNER TO regress_partition_merge_bob

-- sqlfmt-corpus-separator --

ALTER TABLE vacowned_part1 OWNER TO CURRENT_USER

-- sqlfmt-corpus-separator --

ALTER TABLE vacowned_part1 OWNER TO regress_vacuum

-- sqlfmt-corpus-separator --

ALTER TABLE vacowned_parted OWNER TO CURRENT_USER

-- sqlfmt-corpus-separator --

ALTER TABLE vacowned_parted OWNER TO regress_vacuum

-- sqlfmt-corpus-separator --

ALTER USER regress_priv_user2 PASSWORD 'verysecret'

-- sqlfmt-corpus-separator --

ALTER USER regress_test_user_canlogin WITH LOGIN

-- sqlfmt-corpus-separator --

ALTER USER regress_test_user_canlogin WITH NOLOGIN

-- sqlfmt-corpus-separator --

ALTER VIEW attmp_view_new RENAME TO fail

-- sqlfmt-corpus-separator --

ALTER VIEW rls_view OWNER TO regress_rls_bob

-- sqlfmt-corpus-separator --

ALTER VIEW tenant_view OWNER TO regress_role_admin

-- sqlfmt-corpus-separator --

BEGIN

-- sqlfmt-corpus-separator --

BEGIN ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

CLOSE ALL

-- sqlfmt-corpus-separator --

CLOSE c

-- sqlfmt-corpus-separator --

CLOSE foo1

-- sqlfmt-corpus-separator --

CLOSE foo10

-- sqlfmt-corpus-separator --

CLOSE foo11

-- sqlfmt-corpus-separator --

CLOSE foo12

-- sqlfmt-corpus-separator --

CLOSE foo13

-- sqlfmt-corpus-separator --

CLOSE foo14

-- sqlfmt-corpus-separator --

CLOSE foo15

-- sqlfmt-corpus-separator --

CLOSE foo16

-- sqlfmt-corpus-separator --

CLOSE foo17

-- sqlfmt-corpus-separator --

CLOSE foo18

-- sqlfmt-corpus-separator --

CLOSE foo19

-- sqlfmt-corpus-separator --

CLOSE foo2

-- sqlfmt-corpus-separator --

CLOSE foo20

-- sqlfmt-corpus-separator --

CLOSE foo21

-- sqlfmt-corpus-separator --

CLOSE foo22

-- sqlfmt-corpus-separator --

CLOSE foo23

-- sqlfmt-corpus-separator --

CLOSE foo24

-- sqlfmt-corpus-separator --

CLOSE foo25

-- sqlfmt-corpus-separator --

CLOSE foo25ns

-- sqlfmt-corpus-separator --

CLOSE foo3

-- sqlfmt-corpus-separator --

CLOSE foo4

-- sqlfmt-corpus-separator --

CLOSE foo5

-- sqlfmt-corpus-separator --

CLOSE foo6

-- sqlfmt-corpus-separator --

CLOSE foo7

-- sqlfmt-corpus-separator --

CLOSE foo8

-- sqlfmt-corpus-separator --

CLOSE foo9

-- sqlfmt-corpus-separator --

CLOSE tablesample_cur

-- sqlfmt-corpus-separator --

COMMIT

-- sqlfmt-corpus-separator --

COMMIT AND CHAIN

-- sqlfmt-corpus-separator --

COMMIT TRANSACTION

-- sqlfmt-corpus-separator --

COPY (SELECT 'bar1') TO STDOUT

-- sqlfmt-corpus-separator --

COPY INTERVAL_MULDIV_TBL FROM STDIN

-- sqlfmt-corpus-separator --

COPY atest2 FROM stdin

-- sqlfmt-corpus-separator --

COPY atest5 (one) TO stdout

-- sqlfmt-corpus-separator --

COPY atest5 (one,two) TO stdout

-- sqlfmt-corpus-separator --

COPY atest5 (two) FROM stdin

-- sqlfmt-corpus-separator --

COPY atest5 (two) TO stdout

-- sqlfmt-corpus-separator --

COPY atest5 FROM stdin

-- sqlfmt-corpus-separator --

COPY atest6 TO stdout

-- sqlfmt-corpus-separator --

COPY basictest (testvarchar) FROM stdin

-- sqlfmt-corpus-separator --

COPY bit_table FROM stdin

-- sqlfmt-corpus-separator --

COPY copy_t FROM STDIN

-- sqlfmt-corpus-separator --

COPY copytest_mv(id) TO stdout WITH (header)

-- sqlfmt-corpus-separator --

COPY defaulttest(col5) FROM stdin

-- sqlfmt-corpus-separator --

COPY domarrtest FROM stdin

-- sqlfmt-corpus-separator --

COPY enumtest FROM stdin

-- sqlfmt-corpus-separator --

COPY gtest1 (a, b) TO stdout

-- sqlfmt-corpus-separator --

COPY gtest1 FROM stdin

-- sqlfmt-corpus-separator --

COPY gtest1 TO stdout

-- sqlfmt-corpus-separator --

COPY gtest1 TO stdout WITH (FORMAT json)

-- sqlfmt-corpus-separator --

COPY gtest3 (a, b) TO stdout

-- sqlfmt-corpus-separator --

COPY gtest3 FROM stdin

-- sqlfmt-corpus-separator --

COPY gtest3 TO stdout

-- sqlfmt-corpus-separator --

COPY instead_of_insert_tbl_view FROM stdin

-- sqlfmt-corpus-separator --

COPY instead_of_insert_tbl_view_2 FROM stdin

-- sqlfmt-corpus-separator --

COPY itest9 FROM stdin

-- sqlfmt-corpus-separator --

COPY main_table (a, b) FROM stdin

-- sqlfmt-corpus-separator --

COPY main_table (a,b) FROM stdin

-- sqlfmt-corpus-separator --

COPY main_table FROM stdin

-- sqlfmt-corpus-separator --

COPY myshop TO stdout

-- sqlfmt-corpus-separator --

COPY nulltest FROM stdin

-- sqlfmt-corpus-separator --

COPY part_document TO stdout WITH (DELIMITER ',')

-- sqlfmt-corpus-separator --

COPY pp TO stdout(header)

-- sqlfmt-corpus-separator --

COPY rls_t1 (a) TO stdout

-- sqlfmt-corpus-separator --

COPY rls_t1 (a, b) TO stdout

-- sqlfmt-corpus-separator --

COPY rls_t1 (a, b, c) TO stdout

-- sqlfmt-corpus-separator --

COPY rls_t1 (a, b, c) from stdin

-- sqlfmt-corpus-separator --

COPY rls_t1 (b, a) TO stdout

-- sqlfmt-corpus-separator --

COPY rls_t1 (c) TO stdout

-- sqlfmt-corpus-separator --

COPY rls_t1 TO stdout

-- sqlfmt-corpus-separator --

COPY rls_test_src TO stdout

-- sqlfmt-corpus-separator --

COPY t2 FROM stdin

-- sqlfmt-corpus-separator --

COPY t3(id, a,b,c) FROM stdin

-- sqlfmt-corpus-separator --

COPY varbit_table FROM stdin

-- sqlfmt-corpus-separator --

COPY viewtest_tbl FROM stdin

-- sqlfmt-corpus-separator --

COPY width_bucket_test (operand_num) FROM stdin

-- sqlfmt-corpus-separator --

COPY x (a, b, c, d, e) from stdin

-- sqlfmt-corpus-separator --

COPY x (a, b, c, d, e, d, c) from stdin

-- sqlfmt-corpus-separator --

COPY x (c, e) TO stdout

-- sqlfmt-corpus-separator --

COPY x TO stdout

-- sqlfmt-corpus-separator --

COPY x from stdin

-- sqlfmt-corpus-separator --

COPY x from stdin (delimiter ',', delimiter ',')

-- sqlfmt-corpus-separator --

COPY x from stdin (escape ':', escape ':')

-- sqlfmt-corpus-separator --

COPY x from stdin (format BINARY, delimiter ',')

-- sqlfmt-corpus-separator --

COPY x from stdin (format BINARY, null 'x')

-- sqlfmt-corpus-separator --

COPY x from stdin (format CSV, FORMAT CSV)

-- sqlfmt-corpus-separator --

COPY x from stdin (header off, header on)

-- sqlfmt-corpus-separator --

COPY x from stdin (null ' ', null ' ')

-- sqlfmt-corpus-separator --

COPY x from stdin (quote ':', quote ':')

-- sqlfmt-corpus-separator --

COPY x from stdin with (header '2.5')

-- sqlfmt-corpus-separator --

COPY x from stdin with (header -1)

-- sqlfmt-corpus-separator --

COPY x from stdin with (header 2.5)

-- sqlfmt-corpus-separator --

COPY x to stdout with (header '-1')

-- sqlfmt-corpus-separator --

COPY x to stdout with (header '2')

-- sqlfmt-corpus-separator --

COPY x to stdout with (header 2)

-- sqlfmt-corpus-separator --

COPY y TO stdout (FORMAT CSV)

-- sqlfmt-corpus-separator --

COPY y TO stdout (FORMAT CSV, QUOTE '''', DELIMITER '|')

-- sqlfmt-corpus-separator --

CREATE DATABASE regress_nosuch_db

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW drop_idx_matview AS
  SELECT 1 as i WHERE mvtest_drop_the_index()

-- sqlfmt-corpus-separator --

CREATE ROLE "regress_""quoted"

-- sqlfmt-corpus-separator --

CREATE ROLE regress_alice

-- sqlfmt-corpus-separator --

CREATE ROLE regress_alter_generic_user5 NOSUPERUSER

-- sqlfmt-corpus-separator --

CREATE ROLE regress_alter_generic_user6

-- sqlfmt-corpus-separator --

CREATE ROLE regress_constraint_comments

-- sqlfmt-corpus-separator --

CREATE ROLE regress_constraint_comments_noaccess

-- sqlfmt-corpus-separator --

CREATE ROLE regress_create_schema_role SUPERUSER

-- sqlfmt-corpus-separator --

CREATE ROLE regress_createdb CREATEDB

-- sqlfmt-corpus-separator --

CREATE ROLE regress_createrole CREATEROLE NOINHERIT

-- sqlfmt-corpus-separator --

CREATE ROLE regress_current_logfile

-- sqlfmt-corpus-separator --

CREATE ROLE regress_datdba_after

-- sqlfmt-corpus-separator --

CREATE ROLE regress_datdba_before

-- sqlfmt-corpus-separator --

CREATE ROLE regress_display_role

-- sqlfmt-corpus-separator --

CREATE ROLE regress_du_admin

-- sqlfmt-corpus-separator --

CREATE ROLE regress_du_role1

-- sqlfmt-corpus-separator --

CREATE ROLE regress_du_role2

-- sqlfmt-corpus-separator --

CREATE ROLE regress_foreign_data_user LOGIN SUPERUSER

-- sqlfmt-corpus-separator --

CREATE ROLE regress_grantor1

-- sqlfmt-corpus-separator --

CREATE ROLE regress_grantor3

-- sqlfmt-corpus-separator --

CREATE ROLE regress_grantor5

-- sqlfmt-corpus-separator --

CREATE ROLE regress_graph_rls_group1 NOLOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE regress_graph_rls_group2 NOLOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE regress_graph_user1

-- sqlfmt-corpus-separator --

CREATE ROLE regress_graph_user2

-- sqlfmt-corpus-separator --

CREATE ROLE regress_group

-- sqlfmt-corpus-separator --

CREATE ROLE regress_group_direct_manager

-- sqlfmt-corpus-separator --

CREATE ROLE regress_group_indirect_manager

-- sqlfmt-corpus-separator --

CREATE ROLE regress_group_member

-- sqlfmt-corpus-separator --

CREATE ROLE regress_guc_user

-- sqlfmt-corpus-separator --

CREATE ROLE regress_inherit INHERIT

-- sqlfmt-corpus-separator --

CREATE ROLE regress_lo_user

-- sqlfmt-corpus-separator --

CREATE ROLE regress_log_memory

-- sqlfmt-corpus-separator --

CREATE ROLE regress_login LOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE regress_maintain

-- sqlfmt-corpus-separator --

CREATE ROLE regress_multixact_funcs

-- sqlfmt-corpus-separator --

CREATE ROLE regress_no_maintain

-- sqlfmt-corpus-separator --

CREATE ROLE regress_nosuch_createdb CREATEDB

-- sqlfmt-corpus-separator --

CREATE ROLE regress_nosuch_superuser SUPERUSER

-- sqlfmt-corpus-separator --

CREATE ROLE regress_partition_merge_alice

-- sqlfmt-corpus-separator --

CREATE ROLE regress_partition_merge_bob

-- sqlfmt-corpus-separator --

CREATE ROLE regress_partition_split_alice

-- sqlfmt-corpus-separator --

CREATE ROLE regress_partition_split_bob

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd1

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd10 PASSWORD 'SCRAM-SHA-256$000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004096:wNFxNSk1hAXBkgub8py3bg==$65zC6E+R0U7tiYTC9+Wtq4Thw6gUDj3eDCINij8TflU=:rC1I7tcVugrHEY2DT0iPjGyjM4aJxkMM9n8WBxtUtHU='

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd2

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd3 PASSWORD 'role_pwd3'

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd4 PASSWORD NULL

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd5 PASSWORD 'md5e73a4b11df52a6068f8b39f90be36023'

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd6 PASSWORD 'SCRAM-SHA-256$1234'

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd7 PASSWORD 'md5012345678901234567890123456789zz'

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd8 PASSWORD 'md501234567890123456789012345678901zz'

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd9 PASSWORD 'alterediterationcount'

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd_empty PASSWORD ''

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd_sha_len0 PASSWORD 'SCRAM-SHA-256$4096:A6xHKoH/494E941doaPOYg==$Ky+A30sewHIH3VHQLRN9vYsuzlgNyGNKCh37dy96Rqw=:COPdlNiIkrsacU5QoxydEuOH6e/KfiipeETb/bPw8ZI='

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd_sha_len1 PASSWORD 'SCRAM-SHA-256$4096:A6xHKoH/494E941doaPOYg==$Ky+A30sewHIH3VHQLRN9vYsuzlgNyGNKCh37dy96RqwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=:COPdlNiIkrsacU5QoxydEuOH6e/KfiipeETb/bPw8ZI='

-- sqlfmt-corpus-separator --

CREATE ROLE regress_passwd_sha_len2 PASSWORD 'SCRAM-SHA-256$4096:A6xHKoH/494E941doaPOYg==$Ky+A30sewHIH3VHQLRN9vYsuzlgNyGNKCh37dy96Rqw=:COPdlNiIkrsacU5QoxydEuOH6e/KfiipeETb/bPw8ZIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA='

-- sqlfmt-corpus-separator --

CREATE ROLE regress_password_null PASSWORD NULL

-- sqlfmt-corpus-separator --

CREATE ROLE regress_plainrole

-- sqlfmt-corpus-separator --

CREATE ROLE regress_priv_role

-- sqlfmt-corpus-separator --

CREATE ROLE regress_ptnowner

-- sqlfmt-corpus-separator --

CREATE ROLE regress_publication_user LOGIN SUPERUSER

-- sqlfmt-corpus-separator --

CREATE ROLE regress_publication_user2

-- sqlfmt-corpus-separator --

CREATE ROLE regress_publication_user3

-- sqlfmt-corpus-separator --

CREATE ROLE regress_publication_user_dummy LOGIN NOSUPERUSER

-- sqlfmt-corpus-separator --

CREATE ROLE regress_reindexuser NOLOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rls_copy_user

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rls_copy_user_colperms

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rls_dob_role1

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rls_dob_role2

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rls_eve

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rls_frank

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rls_group1 NOLOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rls_group2 NOLOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rol_lock1

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rol_op1

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rol_op3

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rol_op4

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rol_op5

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rol_op6

-- sqlfmt-corpus-separator --

CREATE ROLE regress_role_limited

-- sqlfmt-corpus-separator --

CREATE ROLE regress_role_limited_admin CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE regress_role_normal

-- sqlfmt-corpus-separator --

CREATE ROLE regress_role_super SUPERUSER

-- sqlfmt-corpus-separator --

CREATE ROLE regress_rolecreator CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE regress_roleoption_donor

-- sqlfmt-corpus-separator --

CREATE ROLE regress_roleoption_protagonist

-- sqlfmt-corpus-separator --

CREATE ROLE regress_roleoption_recipient

-- sqlfmt-corpus-separator --

CREATE ROLE regress_schemauser2 superuser login

-- sqlfmt-corpus-separator --

CREATE ROLE regress_slot_dir_funcs

-- sqlfmt-corpus-separator --

CREATE ROLE regress_stats_ext

-- sqlfmt-corpus-separator --

CREATE ROLE regress_subscription_user LOGIN SUPERUSER

-- sqlfmt-corpus-separator --

CREATE ROLE regress_subscription_user2

-- sqlfmt-corpus-separator --

CREATE ROLE regress_subscription_user_dummy LOGIN NOSUPERUSER

-- sqlfmt-corpus-separator --

CREATE ROLE regress_tablespace_user1 login

-- sqlfmt-corpus-separator --

CREATE ROLE regress_tablespace_user2 login

-- sqlfmt-corpus-separator --

CREATE ROLE regress_tenant2

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_createdb WITH CREATEDB

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_createrole WITH CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_def_bypassrls

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_def_createdb

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_def_createrole

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_def_inherit

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_def_replication

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_def_role_canlogin

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_def_superuser

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_extstat_clear

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_extstat_restore

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_indirect

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_inherit WITH NOINHERIT

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_me

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_not_me

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_r1

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_role

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_role2

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_role_canlogin WITH LOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_role_super SUPERUSER

-- sqlfmt-corpus-separator --

CREATE ROLE regress_test_superuser WITH SUPERUSER

-- sqlfmt-corpus-separator --

CREATE ROLE regress_unprivileged_role

-- sqlfmt-corpus-separator --

CREATE ROLE regress_user_mvtest

-- sqlfmt-corpus-separator --

CREATE ROLE regress_vacuum

-- sqlfmt-corpus-separator --

CREATE ROLE regress_zeropriv_owner

-- sqlfmt-corpus-separator --

CREATE SCHEMA "CURRENT_SCHEMA"

-- sqlfmt-corpus-separator --

CREATE SCHEMA IF NOT EXISTS test_ns_schema_renamed

-- sqlfmt-corpus-separator --

CREATE SCHEMA addr_nsp

-- sqlfmt-corpus-separator --

CREATE SCHEMA alt_nsp1

-- sqlfmt-corpus-separator --

CREATE SCHEMA alt_nsp2

-- sqlfmt-corpus-separator --

CREATE SCHEMA alt_nsp6

-- sqlfmt-corpus-separator --

CREATE SCHEMA alter2

-- sqlfmt-corpus-separator --

CREATE SCHEMA collate_tests

-- sqlfmt-corpus-separator --

CREATE SCHEMA concur_reindex_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA create_property_graph_tests

-- sqlfmt-corpus-separator --

CREATE SCHEMA create_property_graph_tests_2

-- sqlfmt-corpus-separator --

CREATE SCHEMA ctl_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA deptest

-- sqlfmt-corpus-separator --

CREATE SCHEMA fast_default

-- sqlfmt-corpus-separator --

CREATE SCHEMA fkpart13

-- sqlfmt-corpus-separator --

CREATE SCHEMA fkpart3

-- sqlfmt-corpus-separator --

CREATE SCHEMA fkpart4

-- sqlfmt-corpus-separator --

CREATE SCHEMA fkpart5

-- sqlfmt-corpus-separator --

CREATE SCHEMA fkpart6

-- sqlfmt-corpus-separator --

CREATE SCHEMA fkpart9

-- sqlfmt-corpus-separator --

CREATE SCHEMA generated_stored_tests

-- sqlfmt-corpus-separator --

CREATE SCHEMA generated_virtual_tests

-- sqlfmt-corpus-separator --

CREATE SCHEMA gpt_test_sch

-- sqlfmt-corpus-separator --

CREATE SCHEMA graph_rls_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA graph_table_tests

-- sqlfmt-corpus-separator --

CREATE SCHEMA matview_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA partition_split_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA partition_split_schema2

-- sqlfmt-corpus-separator --

CREATE SCHEMA partitions_merge_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA partitions_merge_schema2

-- sqlfmt-corpus-separator --

CREATE SCHEMA pglz

-- sqlfmt-corpus-separator --

CREATE SCHEMA pub_test2

-- sqlfmt-corpus-separator --

CREATE SCHEMA pub_test3

-- sqlfmt-corpus-separator --

CREATE SCHEMA pub_testpart1

-- sqlfmt-corpus-separator --

CREATE SCHEMA pub_testpart2

-- sqlfmt-corpus-separator --

CREATE SCHEMA regress_rls_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA regress_roleoption

-- sqlfmt-corpus-separator --

CREATE SCHEMA regress_schema_2

-- sqlfmt-corpus-separator --

CREATE SCHEMA reindex_test

-- sqlfmt-corpus-separator --

CREATE SCHEMA sch1

-- sqlfmt-corpus-separator --

CREATE SCHEMA sch2

-- sqlfmt-corpus-separator --

CREATE SCHEMA schema_op1

-- sqlfmt-corpus-separator --

CREATE SCHEMA schema_to_reindex

-- sqlfmt-corpus-separator --

CREATE SCHEMA selinto_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA stats_import

-- sqlfmt-corpus-separator --

CREATE SCHEMA sts_sch2

-- sqlfmt-corpus-separator --

CREATE SCHEMA temp_func_test

-- sqlfmt-corpus-separator --

CREATE SCHEMA test_maint_search_path

-- sqlfmt-corpus-separator --

CREATE SCHEMA test_ns_schema_renamed

-- sqlfmt-corpus-separator --

CREATE SCHEMA test_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA test_schema_exists

-- sqlfmt-corpus-separator --

CREATE SCHEMA testns

-- sqlfmt-corpus-separator --

CREATE SCHEMA testns2

-- sqlfmt-corpus-separator --

CREATE SCHEMA testns3

-- sqlfmt-corpus-separator --

CREATE SCHEMA testns4

-- sqlfmt-corpus-separator --

CREATE SCHEMA testns5

-- sqlfmt-corpus-separator --

CREATE SCHEMA testpub_rf_schema1

-- sqlfmt-corpus-separator --

CREATE SCHEMA testpub_rf_schema2

-- sqlfmt-corpus-separator --

CREATE SCHEMA testschema

-- sqlfmt-corpus-separator --

CREATE SCHEMA testviewschm2

-- sqlfmt-corpus-separator --

CREATE SCHEMA testxmlschema

-- sqlfmt-corpus-separator --

CREATE SCHEMA tststats

-- sqlfmt-corpus-separator --

CREATE TYPE addr_nsp.gencomptype AS (a int)

-- sqlfmt-corpus-separator --

CREATE TYPE comp_abc AS (a text, b int, c timestamp)

-- sqlfmt-corpus-separator --

CREATE TYPE ctlty1 AS (a int, b text)

-- sqlfmt-corpus-separator --

CREATE TYPE default_test_row AS (f1 text_w_default, f2 int42)

-- sqlfmt-corpus-separator --

CREATE TYPE deptest_t AS (a int)

-- sqlfmt-corpus-separator --

CREATE TYPE dist_row_t AS (a int, b int)

-- sqlfmt-corpus-separator --

CREATE TYPE double_int as (a int, b int)

-- sqlfmt-corpus-separator --

CREATE TYPE foo_t AS (f1 int, f2 text, f3 int, f4 int8)

-- sqlfmt-corpus-separator --

CREATE TYPE gtest_type AS (f1 integer, f2 text, f3 bigint)

-- sqlfmt-corpus-separator --

CREATE TYPE hash_test_t1 AS (a int, b text)

-- sqlfmt-corpus-separator --

CREATE TYPE hash_test_t2 AS (a varbit, b text)

-- sqlfmt-corpus-separator --

CREATE TYPE itest_type AS (f1 integer, f2 text, f3 bigint)

-- sqlfmt-corpus-separator --

CREATE TYPE jbpop AS (a text, b int, c timestamp)

-- sqlfmt-corpus-separator --

CREATE TYPE jsbrec AS (
	i	int,
	ia	_int4,
	ia1	int[],
	ia2	int[][],
	ia3	int[][][],
	ia1d	jsb_int_array_1d,
	ia2d	jsb_int_array_2d,
	t	text,
	ta	text[],
	c	char(10),
	ca	char(10)[],
	ts	timestamp,
	js	json,
	jsb	jsonb,
	jsa	json[],
	rec	jbpop,
	reca	jbpop[]
)

-- sqlfmt-corpus-separator --

CREATE TYPE jsbrec_i_not_null AS (
	i	jsb_int_not_null
)

-- sqlfmt-corpus-separator --

CREATE TYPE jsrec AS (
	i	int,
	ia	_int4,
	ia1	int[],
	ia2	int[][],
	ia3	int[][][],
	ia1d	js_int_array_1d,
	ia2d	js_int_array_2d,
	t	text,
	ta	text[],
	c	char(10),
	ca	char(10)[],
	ts	timestamp,
	js	json,
	jsb	jsonb,
	jsa	json[],
	rec	jpop,
	reca	jpop[]
)

-- sqlfmt-corpus-separator --

CREATE TYPE jsrec_i_not_null AS (
	i	js_int_not_null
)

-- sqlfmt-corpus-separator --

CREATE TYPE mytype AS (a int)

-- sqlfmt-corpus-separator --

CREATE TYPE person_type AS (id int, name text)

-- sqlfmt-corpus-separator --

CREATE TYPE price_input AS (
    id INTEGER,
    price NUMERIC
)

-- sqlfmt-corpus-separator --

CREATE TYPE price_key AS (
    id INTEGER
)

-- sqlfmt-corpus-separator --

CREATE TYPE rngfunc_rescan_t AS (i integer, s bigint)

-- sqlfmt-corpus-separator --

CREATE TYPE sqljsonb_rec AS (a int, t text, js json, jb jsonb, jsa json[])

-- sqlfmt-corpus-separator --

CREATE TYPE sqljsonb_reca AS (reca sqljsonb_rec[])

-- sqlfmt-corpus-separator --

CREATE TYPE stats_import.complex_type AS (
    a integer,
    b real,
    c text,
    d date,
    e jsonb)

-- sqlfmt-corpus-separator --

CREATE TYPE test7a AS (a int, b priv_testdomain1)

-- sqlfmt-corpus-separator --

CREATE TYPE test7b AS (a int, b priv_testdomain1)

-- sqlfmt-corpus-separator --

CREATE TYPE test8a AS (a int, b int)

-- sqlfmt-corpus-separator --

CREATE TYPE test8b AS (a int, b int)

-- sqlfmt-corpus-separator --

CREATE TYPE test_type AS (a int)

-- sqlfmt-corpus-separator --

CREATE TYPE test_type1 AS (a int, b text)

-- sqlfmt-corpus-separator --

CREATE TYPE test_type2 AS (a int, b text)

-- sqlfmt-corpus-separator --

CREATE TYPE test_type3 AS (a int)

-- sqlfmt-corpus-separator --

CREATE TYPE test_typex AS (a int, b text)

-- sqlfmt-corpus-separator --

CREATE TYPE tststats.ty AS (a int, b int, c text)

-- sqlfmt-corpus-separator --

CREATE TYPE tt_t0 AS (z inet, x int, y numeric(8,2))

-- sqlfmt-corpus-separator --

CREATE TYPE tt_t1 AS (x int, y numeric(8,2))

-- sqlfmt-corpus-separator --

CREATE TYPE unknown_comptype AS (
	u unknown    -- fail
)

-- sqlfmt-corpus-separator --

CREATE VIEW ro_view5 AS SELECT a, rank() OVER() FROM base_tbl

-- sqlfmt-corpus-separator --

CREATE schema tststats

-- sqlfmt-corpus-separator --

CREATE type test_type_exists as (a int, b text)

-- sqlfmt-corpus-separator --

DEALLOCATE ALL

-- sqlfmt-corpus-separator --

DEALLOCATE PREPARE ins

-- sqlfmt-corpus-separator --

DEALLOCATE PREPARE q1

-- sqlfmt-corpus-separator --

DEALLOCATE PREPARE q2

-- sqlfmt-corpus-separator --

DEALLOCATE data_sel

-- sqlfmt-corpus-separator --

DEALLOCATE get_nnconstraint_info

-- sqlfmt-corpus-separator --

DEALLOCATE get_partition_info

-- sqlfmt-corpus-separator --

DEALLOCATE graph_rls_query

-- sqlfmt-corpus-separator --

DEALLOCATE pstmt

-- sqlfmt-corpus-separator --

DEALLOCATE q1

-- sqlfmt-corpus-separator --

DEALLOCATE select1

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR
SELECT ctid, * FROM tidscan WHERE ctid = ANY(ARRAY['(0,1)', '(0,2)']::tid[])

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT * FROM tenk1 JOIN tenk2 USING (unique1)

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT * FROM tenk2

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT * from hash_split_heap WHERE keycol = 1

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT ctid, * FROM tidscan

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT ctid,cmin,* FROM combocidtest

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT f1,count(*) FROM uctest GROUP BY f1

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT unique2 FROM tenk1 ORDER BY unique2

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT unique2/0 FROM tenk1 ORDER BY unique2

-- sqlfmt-corpus-separator --

DECLARE c1 CURSOR FOR SELECT * FROM uctest

-- sqlfmt-corpus-separator --

DECLARE c1 CURSOR FOR SELECT * FROM uctest a, uctest b WHERE a.f1 = b.f1 + 5

-- sqlfmt-corpus-separator --

DECLARE c1 CURSOR FOR SELECT * FROM ucview

-- sqlfmt-corpus-separator --

DECLARE c1 CURSOR FOR SELECT stringu1 FROM onek WHERE stringu1 = 'DZAAAA'

-- sqlfmt-corpus-separator --

DECLARE ctt CURSOR FOR SELECT create_temp_tab()

-- sqlfmt-corpus-separator --

DECLARE current_check_cursor CURSOR FOR SELECT * FROM current_check_2

-- sqlfmt-corpus-separator --

DECLARE foo CURSOR FOR SELECT * FROM pxtest4

-- sqlfmt-corpus-separator --

DECLARE foo13 CURSOR FOR
   SELECT * FROM onek WHERE unique1 = 50

-- sqlfmt-corpus-separator --

DECLARE foo14 CURSOR FOR
   SELECT * FROM onek WHERE unique1 = 51

-- sqlfmt-corpus-separator --

DECLARE foo15 CURSOR FOR
   SELECT * FROM onek WHERE unique1 = 52

-- sqlfmt-corpus-separator --

DECLARE foo16 CURSOR FOR
   SELECT * FROM onek WHERE unique1 = 53

-- sqlfmt-corpus-separator --

DECLARE foo17 CURSOR FOR
   SELECT * FROM onek WHERE unique1 = 54

-- sqlfmt-corpus-separator --

DECLARE foo18 CURSOR FOR
   SELECT * FROM onek WHERE unique1 = 55

-- sqlfmt-corpus-separator --

DECLARE foo19 CURSOR FOR
   SELECT * FROM onek WHERE unique1 = 56

-- sqlfmt-corpus-separator --

DECLARE foo2 CURSOR WITHOUT HOLD FOR SELECT 1

-- sqlfmt-corpus-separator --

DECLARE foo20 CURSOR FOR
   SELECT * FROM onek WHERE unique1 = 57

-- sqlfmt-corpus-separator --

DECLARE foo21 CURSOR FOR
   SELECT * FROM onek WHERE unique1 = 58

-- sqlfmt-corpus-separator --

DECLARE foo22 CURSOR FOR
   SELECT * FROM onek WHERE unique1 = 59

-- sqlfmt-corpus-separator --

DECLARE foo23 CURSOR FOR
   SELECT * FROM onek WHERE unique1 = 60

-- sqlfmt-corpus-separator --

DECLARE foo24 CURSOR FOR
   SELECT * FROM onek2 WHERE unique1 = 50

-- sqlfmt-corpus-separator --

DECLARE foo25 CURSOR FOR
   SELECT * FROM onek2 WHERE unique1 = 60

-- sqlfmt-corpus-separator --

DECLARE ok CURSOR FOR SELECT * FROM int8_tbl

-- sqlfmt-corpus-separator --

DELETE FROM empsalary WHERE (rank() OVER (ORDER BY random())) > 10

-- sqlfmt-corpus-separator --

DISCARD ALL

-- sqlfmt-corpus-separator --

DISCARD SEQUENCES

-- sqlfmt-corpus-separator --

DISCARD TEMP

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_addr_user

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_dep_user0

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_dep_user0, regress_dep_user2

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_dep_user1

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_dep_user2, regress_dep_user0

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_evt_user

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_priv_user1

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_priv_user2

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_priv_user2, regress_priv_user2

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_rls_dob_role1

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_sro_user

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_test_role2

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_test_role2 CASCADE

-- sqlfmt-corpus-separator --

DROP OWNED BY regress_user_mvtest CASCADE

-- sqlfmt-corpus-separator --

EXECUTE cprep

-- sqlfmt-corpus-separator --

EXECUTE cyclestmt

-- sqlfmt-corpus-separator --

EXECUTE foo

-- sqlfmt-corpus-separator --

EXECUTE foo ('<bar/>')

-- sqlfmt-corpus-separator --

EXECUTE foo ('bad')

-- sqlfmt-corpus-separator --

EXECUTE foo ('good')

-- sqlfmt-corpus-separator --

EXECUTE get_nnconstraint_info('{constr_parent, constr_child}')

-- sqlfmt-corpus-separator --

EXECUTE get_nnconstraint_info('{constr_parent2, constr_child2}')

-- sqlfmt-corpus-separator --

EXECUTE get_nnconstraint_info('{constr_parent3, constr_child3}')

-- sqlfmt-corpus-separator --

EXECUTE get_nnconstraint_info('{notnull_inhparent, notnull_inhchild, notnull_inhgrand}')

-- sqlfmt-corpus-separator --

EXECUTE get_nnconstraint_info('{notnull_part1_upg, notnull_part1_1_upg, notnull_part1_2_upg, notnull_part1_3_upg}')

-- sqlfmt-corpus-separator --

EXECUTE get_nnconstraint_info('{notnull_tbl1, notnull_chld0}')

-- sqlfmt-corpus-separator --

EXECUTE get_nnconstraint_info('{notnull_tbl1, notnull_tbl1_1, notnull_tbl1_2, notnull_tbl1_3}')

-- sqlfmt-corpus-separator --

EXECUTE get_nnconstraint_info('{notnull_tbl1_child, notnull_tbl1}')

-- sqlfmt-corpus-separator --

EXECUTE get_nnconstraint_info('{notnull_tbl1_child2}')

-- sqlfmt-corpus-separator --

EXECUTE get_nnconstraint_info('{notnull_tbl1_copy}')

-- sqlfmt-corpus-separator --

EXECUTE get_nnconstraint_info('{notnull_tbl1}')

-- sqlfmt-corpus-separator --

EXECUTE get_partition_info('{sales_list}')

-- sqlfmt-corpus-separator --

EXECUTE get_partition_info('{sales_range}')

-- sqlfmt-corpus-separator --

EXECUTE get_partition_info('{t}')

-- sqlfmt-corpus-separator --

EXECUTE graph_rls_query

-- sqlfmt-corpus-separator --

EXECUTE ins(10, ARRAY[4,5])

-- sqlfmt-corpus-separator --

EXECUTE ins(2, ARRAY[1,2,3])

-- sqlfmt-corpus-separator --

EXECUTE loopstmt

-- sqlfmt-corpus-separator --

EXECUTE p1

-- sqlfmt-corpus-separator --

EXECUTE p1(2)

-- sqlfmt-corpus-separator --

EXECUTE p2

-- sqlfmt-corpus-separator --

EXECUTE p2(2)

-- sqlfmt-corpus-separator --

EXECUTE p_ddl

-- sqlfmt-corpus-separator --

EXECUTE pp

-- sqlfmt-corpus-separator --

EXECUTE prepstmt

-- sqlfmt-corpus-separator --

EXECUTE prepstmt2(123)

-- sqlfmt-corpus-separator --

EXECUTE pstmt('1', make_some_array(1,2))

-- sqlfmt-corpus-separator --

EXECUTE q1

-- sqlfmt-corpus-separator --

EXECUTE q2('postgres')

-- sqlfmt-corpus-separator --

EXECUTE q3('AAAAxx', 5::smallint, 10.5::float, false, 4::bigint)

-- sqlfmt-corpus-separator --

EXECUTE q3('bool')

-- sqlfmt-corpus-separator --

EXECUTE q3('bytea', 5::smallint, 10.5::float, false, 4::bigint, true)

-- sqlfmt-corpus-separator --

EXECUTE q3(5::smallint, 10.5::float, false, 4::bigint, 'bytea')

-- sqlfmt-corpus-separator --

EXECUTE query

-- sqlfmt-corpus-separator --

EXECUTE test

-- sqlfmt-corpus-separator --

EXECUTE vprep

-- sqlfmt-corpus-separator --

EXPLAIN SELECT * FROM ft1

-- sqlfmt-corpus-separator --

FETCH 1 FROM c1

-- sqlfmt-corpus-separator --

FETCH 1 FROM foo

-- sqlfmt-corpus-separator --

FETCH 1 FROM foo24

-- sqlfmt-corpus-separator --

FETCH 10 FROM c

-- sqlfmt-corpus-separator --

FETCH 2 FROM c1

-- sqlfmt-corpus-separator --

FETCH ALL FROM c

-- sqlfmt-corpus-separator --

FETCH ALL FROM c1

-- sqlfmt-corpus-separator --

FETCH FROM c1

-- sqlfmt-corpus-separator --

FETCH FROM current_check_cursor

-- sqlfmt-corpus-separator --

FETCH FROM foo25

-- sqlfmt-corpus-separator --

FETCH FROM foo25ns

-- sqlfmt-corpus-separator --

FETCH FROM foo26

-- sqlfmt-corpus-separator --

FETCH c1

-- sqlfmt-corpus-separator --

FETCH ctt

-- sqlfmt-corpus-separator --

FETCH ok

-- sqlfmt-corpus-separator --

INSERT INTO brin_test_multi_2
SELECT v::uuid FROM (SELECT row_number() OVER (ORDER BY v) c, v FROM (SELECT fipshash((i/13)::text) AS v FROM generate_series(1,1000) s(i)) foo) bar ORDER BY c + 25 * random()

-- sqlfmt-corpus-separator --

INSERT INTO cmdata2 SELECT large_val() || repeat('a', 4000)

-- sqlfmt-corpus-separator --

INSERT INTO cmdata2 SELECT large_val_lz4() || repeat('a', 4000)

-- sqlfmt-corpus-separator --

INSERT INTO cmdata2 VALUES((SELECT array_agg(fipshash(g::TEXT))::TEXT FROM
generate_series(1, 50) g), VERSION())

-- sqlfmt-corpus-separator --

INSERT INTO expr_key (x, t)
SELECT d1::numeric, d1::text FROM (
    SELECT round((d / pi())::numeric, 7) AS d1 FROM generate_series(1, 20) AS d
) t

-- sqlfmt-corpus-separator --

INSERT INTO guid1 (guid_field) VALUES (gen_random_uuid())

-- sqlfmt-corpus-separator --

INSERT INTO guid1 (guid_field) VALUES (uuidv4())

-- sqlfmt-corpus-separator --

INSERT INTO guid1 (guid_field) VALUES (uuidv7())

-- sqlfmt-corpus-separator --

INSERT INTO guid3 (guid_field) SELECT uuidv7() FROM generate_series(1, 10)

-- sqlfmt-corpus-separator --

INSERT INTO nummultirange_test VALUES(nummultirange())

-- sqlfmt-corpus-separator --

INSERT INTO regress_tblspace_test_tbl (num1, num2, t)
  SELECT round(random()*100), random(), 'text'
  FROM generate_series(1, 10) s(i)

-- sqlfmt-corpus-separator --

INSERT INTO salespeople10_40 VALUES
  ('dummy value 1', 19, 100, now(), 'Ivanov'),
  ('dummy value 2', 20, 101, now(), 'Smirnoff')

-- sqlfmt-corpus-separator --

INSERT INTO salespeople30_40 VALUES (31, now(), 'Popov')

-- sqlfmt-corpus-separator --

PREPARE cprep AS
  SELECT name, statement, is_holdable, is_binary, is_scrollable FROM pg_cursors

-- sqlfmt-corpus-separator --

PREPARE ctas_ine_query AS SELECT 1 / 0

-- sqlfmt-corpus-separator --

PREPARE data_sel AS SELECT generate_series(1,3)

-- sqlfmt-corpus-separator --

PREPARE foo AS
  SELECT id, keywords, title, body, created
  FROM articles
  GROUP BY id

-- sqlfmt-corpus-separator --

PREPARE foo AS SELECT 1

-- sqlfmt-corpus-separator --

PREPARE p1 AS SELECT $0_1

-- sqlfmt-corpus-separator --

PREPARE p1 AS SELECT $1a

-- sqlfmt-corpus-separator --

PREPARE p1 AS SELECT $2147483648

-- sqlfmt-corpus-separator --

PREPARE p1 AS SELECT * FROM my_property_normal WHERE f_leak(passwd)

-- sqlfmt-corpus-separator --

PREPARE p2 AS SELECT * FROM my_property_secure WHERE f_leak(passwd)

-- sqlfmt-corpus-separator --

PREPARE plancache_test AS SELECT * FROM z1 WHERE f_leak(b)

-- sqlfmt-corpus-separator --

PREPARE prepstmt AS SELECT * FROM pcachetest

-- sqlfmt-corpus-separator --

PREPARE q1 AS SELECT 1 AS a

-- sqlfmt-corpus-separator --

PREPARE q1 AS SELECT 2

-- sqlfmt-corpus-separator --

PREPARE q2 AS SELECT 2 AS b

-- sqlfmt-corpus-separator --

PREPARE q6 AS
    SELECT * FROM tenk1 WHERE unique1 = $1 AND stringu1 = $2

-- sqlfmt-corpus-separator --

PREPARE q8 AS
    UPDATE tenk1 SET stringu1 = $2 WHERE unique1 = $1

-- sqlfmt-corpus-separator --

PREPARE role_inval AS SELECT * FROM t1

-- sqlfmt-corpus-separator --

PREPARE select1 AS SELECT 1 as a

-- sqlfmt-corpus-separator --

PREPARE test AS UPDATE writetest SET a = 0

-- sqlfmt-corpus-separator --

PREPARE vprep AS SELECT * FROM pcacheview

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY regress_datdba_before TO regress_datdba_after

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY regress_dep_user0 TO regress_dep_user1

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY regress_dep_user1 TO regress_dep_user0

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY regress_dep_user1 TO regress_dep_user2

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY regress_graph_rls_alice TO current_user

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY regress_priv_user2 TO regress_priv_user4

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY regress_tenant TO regress_createrole

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY regress_test_role TO regress_test_role2

-- sqlfmt-corpus-separator --

ROLLBACK

-- sqlfmt-corpus-separator --

ROLLBACK AND CHAIN

-- sqlfmt-corpus-separator --

SELECT
    empno,
    depname,
    row_number() OVER (PARTITION BY depname ORDER BY enroll_date) rn,
    rank() OVER (PARTITION BY depname ORDER BY enroll_date ROWS BETWEEN
                 UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) rnk,
    count(*) OVER (PARTITION BY depname ORDER BY enroll_date RANGE BETWEEN
                   CURRENT ROW AND CURRENT ROW) cnt
FROM empsalary

-- sqlfmt-corpus-separator --

SELECT "normalize"('abc', 'def')

-- sqlfmt-corpus-separator --

SELECT '7' AS "None",
   CASE WHEN random() < 0 THEN 1
   END AS "NULL on no matches"

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange && nummultirange()

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange &< nummultirange()

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange &> nummultirange()

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange -|- nummultirange()

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange <@ nummultirange()

-- sqlfmt-corpus-separator --

SELECT (current_schemas(true))[1] = ('pg_temp_' || beid::text) AS match
FROM pg_stat_get_backend_idset() beid
WHERE pg_stat_get_backend_pid(beid) = pg_backend_pid()

-- sqlfmt-corpus-separator --

SELECT (now())[1]

-- sqlfmt-corpus-separator --

SELECT * FROM
  (SELECT *,
          count(salary) OVER (PARTITION BY depname || '') c1, -- w1
          row_number() OVER (PARTITION BY depname) rn, -- w2
          count(*) OVER (PARTITION BY depname) c2, -- w2
          count(*) OVER (PARTITION BY '' || depname) c3, -- w3
          ntile(2) OVER (PARTITION BY depname) nt -- w2
   FROM empsalary
) e WHERE rn <= 1 AND c1 <= 3 AND nt < 2

-- sqlfmt-corpus-separator --

SELECT * FROM
  (SELECT 1 AS t, (random()*3)::int AS x
   UNION
   SELECT 2 AS t, 4 AS x) ss
WHERE x > 3
ORDER BY x

-- sqlfmt-corpus-separator --

SELECT * FROM
  (SELECT depname,
          empno,
          salary,
          enroll_date,
          row_number() OVER (PARTITION BY depname ORDER BY enroll_date) AS first_emp,
          row_number() OVER (PARTITION BY depname ORDER BY enroll_date DESC) AS last_emp
   FROM empsalary) emp
WHERE first_emp = 1 OR last_emp = 1

-- sqlfmt-corpus-separator --

SELECT * FROM
  (SELECT empno,
          depname,
          row_number() OVER (PARTITION BY depname ORDER BY empno) rn
   FROM empsalary) emp
WHERE rn < 3

-- sqlfmt-corpus-separator --

SELECT * FROM
  (SELECT empno,
          row_number() OVER (ORDER BY empno) rn
   FROM empsalary) emp
WHERE 2 >= rn

-- sqlfmt-corpus-separator --

SELECT * FROM
  (SELECT empno,
          row_number() OVER (ORDER BY empno) rn
   FROM empsalary) emp
WHERE 3 > rn

-- sqlfmt-corpus-separator --

SELECT * FROM
  (SELECT empno,
          row_number() OVER (ORDER BY empno) rn
   FROM empsalary) emp
WHERE rn < 3

-- sqlfmt-corpus-separator --

SELECT * FROM
  (SELECT empno,
          salary,
          dense_rank() OVER (ORDER BY salary DESC) dr
   FROM empsalary) emp
WHERE dr = 1

-- sqlfmt-corpus-separator --

SELECT * FROM
  (SELECT empno,
          salary,
          rank() OVER (ORDER BY salary DESC) r
   FROM empsalary) emp
WHERE r <= 3

-- sqlfmt-corpus-separator --

SELECT * FROM
  (SELECT row_number() OVER (PARTITION BY salary) AS rn,
          lead(depname) OVER (PARTITION BY salary) || ' Department' AS n_dep
   FROM empsalary) emp
WHERE rn < 1

-- sqlfmt-corpus-separator --

SELECT * FROM (TABLE int2_tbl) AS s (a, b)

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM(generate_series(10,11), get_users()) WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM(get_users(), generate_series(10,11)) WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT * FROM empsalary INNER JOIN tenk1 ON row_number() OVER (ORDER BY salary) < 10

-- sqlfmt-corpus-separator --

SELECT * FROM empsalary WHERE row_number() OVER (ORDER BY salary) < 10

-- sqlfmt-corpus-separator --

SELECT * FROM functest_sri1()

-- sqlfmt-corpus-separator --

SELECT * FROM functest_sri2()

-- sqlfmt-corpus-separator --

SELECT * FROM get_all_persons()

-- sqlfmt-corpus-separator --

SELECT * FROM get_default_test()

-- sqlfmt-corpus-separator --

SELECT * FROM get_first_user()

-- sqlfmt-corpus-separator --

SELECT * FROM get_users()

-- sqlfmt-corpus-separator --

SELECT * FROM get_users() WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT * FROM list_partitioned_table() AS t

-- sqlfmt-corpus-separator --

SELECT * FROM merge_sq_source_into_sq_target()

-- sqlfmt-corpus-separator --

SELECT * FROM rngfunc()

-- sqlfmt-corpus-separator --

SELECT * FROM rngfunc() GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND (j1.a*j1.a) = (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int
  AND (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int = (j2.a*j2.a)

-- sqlfmt-corpus-separator --

SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND (j1.a*j1.c/3) = (random()/3 + 3)::int
  AND (random()/3 + 3)::int = (j2.a*j2.c/3)

-- sqlfmt-corpus-separator --

SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND j1.a = (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int
  AND (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int = j2.a

-- sqlfmt-corpus-separator --

SELECT * FROM tp_chk_data()

-- sqlfmt-corpus-separator --

SELECT * FROM unnest((SELECT array_agg(b ORDER BY b) FROM collate_test1)) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM unnest((SELECT array_agg(b ORDER BY b) FROM collate_test2)) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM unnest((SELECT array_agg(b ORDER BY b) FROM collate_test3)) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT -f1,
    EXTRACT(MICROSECOND FROM -f1) AS MICROSECOND,
    EXTRACT(MILLISECOND FROM -f1) AS MILLISECOND,
    EXTRACT(SECOND FROM -f1) AS SECOND,
    EXTRACT(MINUTE FROM -f1) AS MINUTE,
    EXTRACT(HOUR FROM -f1) AS HOUR,
    EXTRACT(DAY FROM -f1) AS DAY,
    EXTRACT(WEEK FROM -f1) AS WEEK,
    EXTRACT(MONTH FROM -f1) AS MONTH,
    EXTRACT(QUARTER FROM -f1) AS QUARTER,
    EXTRACT(YEAR FROM -f1) AS YEAR,
    EXTRACT(DECADE FROM -f1) AS DECADE,
    EXTRACT(CENTURY FROM -f1) AS CENTURY,
    EXTRACT(MILLENNIUM FROM -f1) AS MILLENNIUM,
    EXTRACT(EPOCH FROM -f1) AS EPOCH
    FROM INTERVAL_TBL

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY       FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY    FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM CURRENT_DATE)>=21 AS True

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '0001-01-01 AD')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '0001-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '0001-12-31 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '0100-12-31 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '0101-12-31 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '1900-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '1901-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '2001-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM INTERVAL '-100 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM INTERVAL '-99 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM INTERVAL '100 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM INTERVAL '99 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY           FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY           FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY         FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY         FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY FROM DATE '-infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE        FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE     FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '0001-01-01 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '0002-12-31 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '0009-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '0010-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '0011-01-01 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '0012-12-31 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '1994-12-25')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM INTERVAL '-100 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM INTERVAL '-99 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM INTERVAL '100 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM INTERVAL '99 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOW           FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOW           FROM DATE '2020-08-16')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOW           FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOY           FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOY           FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH         FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH       FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH       FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH      FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH FROM DATE        '1970-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH FROM DATE '-infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(FORTNIGHT   FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(FORTNIGHT   FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(FORTNIGHT FROM INTERVAL '2 days')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(HOUR          FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(HOUR        FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(HOUR        FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISODOW        FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISODOW        FROM DATE '2020-08-16')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISODOW        FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISOYEAR       FROM DATE '2020-08-11 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISOYEAR       FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISOYEAR    FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(JULIAN        FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(JULIAN     FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MICROSEC  FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MICROSECOND FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MICROSECOND FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MICROSECONDS  FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM    FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '0001-01-01 AD')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '0001-12-31 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '1000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '1001-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '2001-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLISECOND FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLISECOND FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLISECONDS  FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MINUTE        FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MINUTE      FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MINUTE      FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MONTH         FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MONTH         FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(QUARTER       FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(QUARTER       FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(SECOND        FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(SECOND      FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(SECOND      FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE      FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE    FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE    FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04:30')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE FROM INTERVAL '2 days')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE_H    FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE_HOUR   FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04:30')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE_M    FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE_MINUTE FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04:30')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(WEEK          FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(WEEK          FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(YEAR          FROM DATE '2020-08-11 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(YEAR          FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(YEAR       FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT FROM test_enc_setup()

-- sqlfmt-corpus-separator --

SELECT JSON()

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY()

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAYAGG(i ORDER BY i DESC)
FROM generate_series(1, 5) i

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT()

-- sqlfmt-corpus-separator --

SELECT JSON_SCALAR()

-- sqlfmt-corpus-separator --

SELECT JSON_SERIALIZE()

-- sqlfmt-corpus-separator --

SELECT POSITION(''::bytea IN '\x1122'::bytea) = 1 AS "1"

-- sqlfmt-corpus-separator --

SELECT POSITION('5' IN '1234567890') = '5' AS "5"

-- sqlfmt-corpus-separator --

SELECT POSITION('\x11'::bytea IN ''::bytea) = 0 AS "0"

-- sqlfmt-corpus-separator --

SELECT POSITION('\x22'::bytea IN '\x1122'::bytea) = 2 AS "2"

-- sqlfmt-corpus-separator --

SELECT POSITION('\x33'::bytea IN '\x1122'::bytea) = 0 AS "0"

-- sqlfmt-corpus-separator --

SELECT POSITION('\x5678'::bytea IN '\x1234567890'::bytea) = 3 AS "3"

-- sqlfmt-corpus-separator --

SELECT POSITION(B'' IN B'')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'' IN B'00001010')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'0' IN B'')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'0000000000011101011111010110' IN B'000000000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'000000000011101011111010110' IN B'000000000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'00000000011101011111010110' IN B'000000000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1010' IN B'00000101')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1010' IN B'000001010')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1010' IN B'0000101')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1010' IN B'00001010')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'101101' IN B'001011011011011000')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'10110110' IN B'001011011011010')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1011011011011' IN B'00001011011011011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1011011011011' IN B'001011011011011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1101' IN b),
       POSITION(B'11011' IN b),
       b
       FROM BIT_SHIFT_TABLE

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1101' IN v),
       POSITION(B'11011' IN v),
       v
       FROM VARBIT_SHIFT_TABLE

-- sqlfmt-corpus-separator --

SELECT POSITION(B'11101011' IN B'0000011101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'11101011' IN B'00011101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'11101011' IN B'011101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'11101011' IN B'11101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'00000000001110101111101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'000000000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'000000001110101111101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'0000000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'0000001110101111101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'00000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'0000011101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'00000111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'000001110101111101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'0000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'00011101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'000111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'011101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'0111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'11101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'111010110')

-- sqlfmt-corpus-separator --

SELECT a[:], b[:] FROM arrtest_s

-- sqlfmt-corpus-separator --

SELECT alter_and_insert()

-- sqlfmt-corpus-separator --

SELECT array_agg(a ORDER BY x COLLATE "C", y COLLATE "POSIX") FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT array_agg(a ORDER BY x||y) FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b) FROM collate_test1

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b) FROM collate_test2

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b) FROM collate_test3

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY guid_encoded COLLATE "C") FROM guid3

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY guid_field) FROM guid3

-- sqlfmt-corpus-separator --

SELECT array_agg(x COLLATE "C" ORDER BY y COLLATE "POSIX") FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT avg(c1.f ORDER BY c1.x, c1.y)
FROM group_agg_pk c1 JOIN group_agg_pk c2 ON c1.x = c2.x
GROUP BY c1.w, c1.z

-- sqlfmt-corpus-separator --

SELECT comp()

-- sqlfmt-corpus-separator --

SELECT count() OVER () FROM tenk1

-- sqlfmt-corpus-separator --

SELECT count(*) > 0 AS ok FROM pg_control_checkpoint()

-- sqlfmt-corpus-separator --

SELECT count(*) > 0 AS ok FROM pg_control_init()

-- sqlfmt-corpus-separator --

SELECT count(*) > 0 AS ok FROM pg_control_recovery()

-- sqlfmt-corpus-separator --

SELECT count(*) > 0 AS ok FROM pg_control_system()

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE r < 0 OR r >= 1) AS out_of_range,
       (count(*) FILTER (WHERE r < 0.01)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 0.99)) > 0 AS has_large
FROM (SELECT random() r FROM generate_series(1, 2000)) ss

-- sqlfmt-corpus-separator --

SELECT count(*) FROM (
  WITH q1(x) AS (SELECT random() FROM generate_series(1, 5))
    SELECT * FROM q1
  UNION
    SELECT * FROM q1
) ss

-- sqlfmt-corpus-separator --

SELECT create_and_insert()

-- sqlfmt-corpus-separator --

SELECT cume_dist() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT cume_dist() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT cume_dist() OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT cume_dist() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT current_catalog = current_database()

-- sqlfmt-corpus-separator --

SELECT current_schema() ~ 'pg_temp' AS is_temp_schema

-- sqlfmt-corpus-separator --

SELECT current_timestamp = NOW()

-- sqlfmt-corpus-separator --

SELECT d1 as "timestamp",
   extract(microseconds from d1) AS microseconds,
   extract(milliseconds from d1) AS milliseconds,
   extract(seconds from d1) AS seconds,
   round(extract(julian from d1)) AS julian,
   extract(epoch from d1) AS epoch
   FROM TIMESTAMPTZ_TBL

-- sqlfmt-corpus-separator --

SELECT d1 as "timestamp",
   extract(microseconds from d1) AS microseconds,
   extract(milliseconds from d1) AS milliseconds,
   extract(seconds from d1) AS seconds,
   round(extract(julian from d1)) AS julian,
   extract(epoch from d1) AS epoch
   FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT date(now())::text = current_date::text

-- sqlfmt-corpus-separator --

SELECT dense_rank() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT dense_rank() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT depname, empno, salary, rank() OVER (PARTITION BY depname ORDER BY salary) FROM empsalary

-- sqlfmt-corpus-separator --

SELECT dogrant_ok()

-- sqlfmt-corpus-separator --

SELECT empno, depname, salary, bonus, depadj, MIN(bonus) OVER (ORDER BY empno), MAX(depadj) OVER () FROM(
	SELECT *,
		CASE WHEN enroll_date < '2008-01-01' THEN 2008 - extract(YEAR FROM enroll_date) END * 500 AS bonus,
		CASE WHEN
			AVG(salary) OVER (PARTITION BY depname) < salary
		THEN 200 END AS depadj FROM empsalary
)s

-- sqlfmt-corpus-separator --

SELECT extract(epoch from '294270-01-01 00:00:00'::timestamp)

-- sqlfmt-corpus-separator --

SELECT extract(epoch from '294270-01-01 00:00:00+00'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(epoch from '5000-01-01 00:00:00'::timestamp)

-- sqlfmt-corpus-separator --

SELECT extract(epoch from '5000-01-01 00:00:00+00'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(epoch from interval '1000000000 days')

-- sqlfmt-corpus-separator --

SELECT f1,
    EXTRACT(MICROSECOND FROM f1) AS MICROSECOND,
    EXTRACT(MILLISECOND FROM f1) AS MILLISECOND,
    EXTRACT(SECOND FROM f1) AS SECOND,
    EXTRACT(MINUTE FROM f1) AS MINUTE,
    EXTRACT(HOUR FROM f1) AS HOUR,
    EXTRACT(DAY FROM f1) AS DAY,
    EXTRACT(WEEK FROM f1) AS WEEK,
    EXTRACT(MONTH FROM f1) AS MONTH,
    EXTRACT(QUARTER FROM f1) AS QUARTER,
    EXTRACT(YEAR FROM f1) AS YEAR,
    EXTRACT(DECADE FROM f1) AS DECADE,
    EXTRACT(CENTURY FROM f1) AS CENTURY,
    EXTRACT(MILLENNIUM FROM f1) AS MILLENNIUM,
    EXTRACT(EPOCH FROM f1) AS EPOCH
    FROM INTERVAL_TBL

-- sqlfmt-corpus-separator --

SELECT f1[:] FROM POINT_TBL

-- sqlfmt-corpus-separator --

SELECT func()

-- sqlfmt-corpus-separator --

SELECT functest_A_3()

-- sqlfmt-corpus-separator --

SELECT functest_S_13()

-- sqlfmt-corpus-separator --

SELECT functest_S_14()

-- sqlfmt-corpus-separator --

SELECT functest_S_3()

-- sqlfmt-corpus-separator --

SELECT functest_srf0() LIMIT 5

-- sqlfmt-corpus-separator --

SELECT get_first_user()

-- sqlfmt-corpus-separator --

SELECT get_users()

-- sqlfmt-corpus-separator --

SELECT json_agg(q ORDER BY x NULLS FIRST, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT json_agg(q ORDER BY x, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT json_build_array()

-- sqlfmt-corpus-separator --

SELECT json_build_object()

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(q ORDER BY x NULLS FIRST, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(q ORDER BY x, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array()

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object()

-- sqlfmt-corpus-separator --

SELECT ks_test_normal_random() OR
       ks_test_normal_random() OR
       ks_test_normal_random() AS standard_normal

-- sqlfmt-corpus-separator --

SELECT ks_test_uniform_random() OR
       ks_test_uniform_random() OR
       ks_test_uniform_random() AS uniform

-- sqlfmt-corpus-separator --

SELECT ks_test_uniform_random_bigint_in_range() OR
       ks_test_uniform_random_bigint_in_range() OR
       ks_test_uniform_random_bigint_in_range() AS uniform_bigint

-- sqlfmt-corpus-separator --

SELECT ks_test_uniform_random_int_in_range() OR
       ks_test_uniform_random_int_in_range() OR
       ks_test_uniform_random_int_in_range() AS uniform_int

-- sqlfmt-corpus-separator --

SELECT ks_test_uniform_random_numeric_in_range() OR
       ks_test_uniform_random_numeric_in_range() OR
       ks_test_uniform_random_numeric_in_range() AS uniform_numeric

-- sqlfmt-corpus-separator --

SELECT last_value, is_called, page_lsn <= pg_current_wal_lsn() as lsn FROM pg_get_sequence_data('test_seq1')

-- sqlfmt-corpus-separator --

SELECT lastval()

-- sqlfmt-corpus-separator --

SELECT locktype, mode FROM pg_locks WHERE pid = pg_backend_pid() AND mode = 'SIReadLock'

-- sqlfmt-corpus-separator --

SELECT make_table()

-- sqlfmt-corpus-separator --

SELECT merge_action() FROM sq_target

-- sqlfmt-corpus-separator --

SELECT merge_func()

-- sqlfmt-corpus-separator --

SELECT min(x ORDER BY y) FROM (VALUES(1, 2)) AS d(x,y)

-- sqlfmt-corpus-separator --

SELECT min(x ORDER BY y) FROM (VALUES(1, NULL)) AS d(x,y)

-- sqlfmt-corpus-separator --

SELECT mode FROM pg_locks
WHERE relation = 'stats_import.part_parent'::regclass AND
      pid = pg_backend_pid() AND granted

-- sqlfmt-corpus-separator --

SELECT mode FROM pg_locks
WHERE relation = 'stats_import.part_parent_i'::regclass AND
      pid = pg_backend_pid() AND granted

-- sqlfmt-corpus-separator --

SELECT mode FROM pg_locks
WHERE relation = 'stats_import.test'::regclass AND
      pid = pg_backend_pid() AND granted

-- sqlfmt-corpus-separator --

SELECT mode FROM pg_locks
WHERE relation = 'stats_import.test_i'::regclass AND
      pid = pg_backend_pid() AND granted

-- sqlfmt-corpus-separator --

SELECT mode FROM pg_locks WHERE locktype = 'relation' AND
  relation = 'stats_import.test'::regclass AND
  pid = pg_backend_pid()

-- sqlfmt-corpus-separator --

SELECT mode FROM pg_locks WHERE locktype = 'relation' AND
  relation = 'stats_import.test_clone'::regclass AND
  pid = pg_backend_pid()

-- sqlfmt-corpus-separator --

SELECT multirange_minus_multi(nummultirange(), nummultirange())

-- sqlfmt-corpus-separator --

SELECT multirange_minus_multi(nummultirange(), nummultirange(numrange(1,2)))

-- sqlfmt-corpus-separator --

SELECT multirange_minus_multi(nummultirange(numrange(1,2)), nummultirange())

-- sqlfmt-corpus-separator --

SELECT multirange_minus_multi(nummultirange(numrange(1,2), numrange(3,4)), nummultirange())

-- sqlfmt-corpus-separator --

SELECT mvtest_func()

-- sqlfmt-corpus-separator --

SELECT nonsimple_expr_test()

-- sqlfmt-corpus-separator --

SELECT normalize('')

-- sqlfmt-corpus-separator --

SELECT normalize(U&'\0061\0308\24D1c') = U&'\00E4\24D1c' COLLATE "C" AS test_default

-- sqlfmt-corpus-separator --

SELECT normalize(U&'\0061\0308\24D1c', NFC) = U&'\00E4\24D1c' COLLATE "C" AS test_nfc

-- sqlfmt-corpus-separator --

SELECT normalize(U&'\0061\0308\24D1c', NFKC) = U&'\00E4bc' COLLATE "C" AS test_nfkc

-- sqlfmt-corpus-separator --

SELECT normalize(U&'\00E4\24D1c', NFD) = U&'\0061\0308\24D1c' COLLATE "C" AS test_nfd

-- sqlfmt-corpus-separator --

SELECT normalize(U&'\00E4\24D1c', NFKD) = U&'\0061\0308bc' COLLATE "C" AS test_nfkd

-- sqlfmt-corpus-separator --

SELECT normalize(U&'\00E4bc', NFC) = U&'\00E4bc' COLLATE "C" AS test_nfc_idem

-- sqlfmt-corpus-separator --

SELECT now()::time::text = localtime::text

-- sqlfmt-corpus-separator --

SELECT now()::timestamp::text = localtimestamp::text

-- sqlfmt-corpus-separator --

SELECT now()::timetz(4)::text = current_time(4)::text

-- sqlfmt-corpus-separator --

SELECT now()::timetz::text = current_time::text

-- sqlfmt-corpus-separator --

SELECT num_nonnulls()

-- sqlfmt-corpus-separator --

SELECT num_nulls()

-- sqlfmt-corpus-separator --

SELECT nummultirange() && 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT nummultirange() && nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange() && nummultirange(numrange(1,2))

-- sqlfmt-corpus-separator --

SELECT nummultirange() &< 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT nummultirange() &< nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange() &< nummultirange(numrange(1,2))

-- sqlfmt-corpus-separator --

SELECT nummultirange() &> 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT nummultirange() &> nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange() &> nummultirange(numrange(1,2))

-- sqlfmt-corpus-separator --

SELECT nummultirange() * nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange() * nummultirange(numrange(1,2))

-- sqlfmt-corpus-separator --

SELECT nummultirange() + nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange() + nummultirange(numrange(1,2))

-- sqlfmt-corpus-separator --

SELECT nummultirange() - nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange() - nummultirange(numrange(1,2))

-- sqlfmt-corpus-separator --

SELECT nummultirange() -|- 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT nummultirange() -|- nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange() -|- nummultirange(numrange(1,2))

-- sqlfmt-corpus-separator --

SELECT nummultirange() <@ nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange() @> 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT nummultirange() @> nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange(numrange(1,2)) && nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange(numrange(1,2)) &< nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange(numrange(1,2)) &> nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange(numrange(1,2)) * nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange(numrange(1,2)) + nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange(numrange(1,2)) - nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange(numrange(1,2)) -|- nummultirange()

-- sqlfmt-corpus-separator --

SELECT nummultirange(numrange(1,2), numrange(3,4)) - nummultirange()

-- sqlfmt-corpus-separator --

SELECT oldest_multixact IS NULL AS null_result FROM pg_get_multixact_stats()

-- sqlfmt-corpus-separator --

SELECT percent_rank() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT percent_rank() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT percent_rank() OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT percent_rank() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT perform_test_func()

-- sqlfmt-corpus-separator --

SELECT pg_advisory_unlock_all()

-- sqlfmt-corpus-separator --

SELECT pg_current_xact_id_if_assigned() IS NULL

-- sqlfmt-corpus-separator --

SELECT pg_listening_channels()

-- sqlfmt-corpus-separator --

SELECT pg_log_backend_memory_contexts(pg_backend_pid())

-- sqlfmt-corpus-separator --

SELECT pg_notification_queue_usage()

-- sqlfmt-corpus-separator --

SELECT pg_stat_clear_snapshot()

-- sqlfmt-corpus-separator --

SELECT pg_stat_force_next_flush()

-- sqlfmt-corpus-separator --

SELECT pg_stat_get_snapshot_timestamp()

-- sqlfmt-corpus-separator --

SELECT pg_stat_get_snapshot_timestamp() >= NOW()

-- sqlfmt-corpus-separator --

SELECT pg_stat_get_snapshot_timestamp() IS NOT NULL AS snapshot_ok

-- sqlfmt-corpus-separator --

SELECT pg_stat_reset()

-- sqlfmt-corpus-separator --

SELECT pg_stat_reset_backend_stats(pg_backend_pid())

-- sqlfmt-corpus-separator --

SELECT pr.snap_ts < pg_stat_get_snapshot_timestamp() as snapshot_newer
FROM prevstats AS pr

-- sqlfmt-corpus-separator --

SELECT query_id IS NOT NULL AS qid_set FROM pg_stat_activity
  WHERE pid = pg_backend_pid()

-- sqlfmt-corpus-separator --

SELECT r, count(*)
FROM (SELECT random() r FROM generate_series(1, 1000)) ss
GROUP BY r HAVING count(*) > 1

-- sqlfmt-corpus-separator --

SELECT r, count(*)
FROM (SELECT random_normal() r FROM generate_series(1, 1000)) ss
GROUP BY r HAVING count(*) > 1

-- sqlfmt-corpus-separator --

SELECT random() FROM generate_series(1, 10)

-- sqlfmt-corpus-separator --

SELECT random_normal() FROM generate_series(1, 10)

-- sqlfmt-corpus-separator --

SELECT range_merge(nummultirange())

-- sqlfmt-corpus-separator --

SELECT rank() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT rank() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY 1), count(*) FROM empsalary GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY length('abc'))

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY rank() OVER (ORDER BY random()))

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY four ORDER BY ten) AS rank_1, ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT rank() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT relation::regclass, mode FROM pg_locks
WHERE pid = pg_backend_pid() AND locktype = 'relation'
  AND relation::regclass::text LIKE 'alter\_idx%'
ORDER BY relation::regclass::text COLLATE "C"

-- sqlfmt-corpus-separator --

SELECT reraise_test()

-- sqlfmt-corpus-separator --

SELECT row_number() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT row_number() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY unique2) FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT row_number() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT stats_test_func1()

-- sqlfmt-corpus-separator --

SELECT stats_test_func2()

-- sqlfmt-corpus-separator --

SELECT sum(salary),
	row_number() OVER (ORDER BY depname),
	sum(sum(salary)) OVER (ORDER BY depname DESC)
FROM empsalary GROUP BY depname

-- sqlfmt-corpus-separator --

SELECT sum(salary), row_number() OVER (ORDER BY depname), sum(
    sum(salary) FILTER (WHERE enroll_date > '2007-01-01')
) FILTER (WHERE depname <> 'sales') OVER (ORDER BY depname DESC) AS "filtered_sum",
    depname
FROM empsalary GROUP BY depname

-- sqlfmt-corpus-separator --

SELECT test_atomic_ops()

-- sqlfmt-corpus-separator --

SELECT test_event_trigger()

-- sqlfmt-corpus-separator --

SELECT test_instr_time()

-- sqlfmt-corpus-separator --

SELECT test_relpath()

-- sqlfmt-corpus-separator --

SELECT test_translation()

-- sqlfmt-corpus-separator --

SELECT to_char(now(), 'OF') as "OF", to_char(now(), 'TZH:TZM') as "TZH:TZM"

-- sqlfmt-corpus-separator --

SELECT to_char(now(), 'of') as "Of", to_char(now(), 'tzh:tzm') as "tzh:tzm"

-- sqlfmt-corpus-separator --

SELECT to_char(now(), 'of') as "of", to_char(now(), 'tzh:tzm') as "tzh:tzm"

-- sqlfmt-corpus-separator --

SELECT tp_ins_data()

-- sqlfmt-corpus-separator --

SELECT truncate_in_subxact()

-- sqlfmt-corpus-separator --

SELECT txid_current_if_assigned() IS NULL

-- sqlfmt-corpus-separator --

SELECT unicode_version() IS NOT NULL

-- sqlfmt-corpus-separator --

SELECT uuid_extract_timestamp(gen_random_uuid())

-- sqlfmt-corpus-separator --

SELECT uuid_extract_version(gen_random_uuid())

-- sqlfmt-corpus-separator --

SELECT uuid_extract_version(uuidv4())

-- sqlfmt-corpus-separator --

SELECT uuid_extract_version(uuidv7())

-- sqlfmt-corpus-separator --

SELECT v = v::bytea::uuid as matched FROM gen_random_uuid() v

-- sqlfmt-corpus-separator --

SELECT v, EXTRACT(year FROM d), count(*)
 FROM ctv_data
 GROUP BY 1, 2
 ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT width_bucket(now(),
                    array['yesterday', 'today', 'tomorrow']::timestamptz[])

-- sqlfmt-corpus-separator --

SELECT x, avg(x) OVER(ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM (VALUES (NULL::interval),
               ('3 days'::interval),
               ('infinity'::timestamptz - now()),
               ('6 days'::interval),
               ('-infinity'::interval)) v(x)

-- sqlfmt-corpus-separator --

SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3bpci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3ci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3cs ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x, sum(x) OVER(ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM (VALUES (NULL::interval),
               ('3 days'::interval),
               ('infinity'::timestamptz - now()),
               ('6 days'::interval),
               ('-infinity'::interval)) v(x)

-- sqlfmt-corpus-separator --

SET SESSION CHARACTERISTICS AS TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

SET SESSION CHARACTERISTICS AS TRANSACTION READ WRITE

-- sqlfmt-corpus-separator --

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

SET TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

SET TRANSACTION READ WRITE

-- sqlfmt-corpus-separator --

SHOW DateStyle

-- sqlfmt-corpus-separator --

SHOW TIME ZONE

-- sqlfmt-corpus-separator --

SHOW TimeZone

-- sqlfmt-corpus-separator --

SHOW allow_system_table_mods

-- sqlfmt-corpus-separator --

SHOW datestyle

-- sqlfmt-corpus-separator --

SHOW log_min_messages

-- sqlfmt-corpus-separator --

SHOW search_path

-- sqlfmt-corpus-separator --

SHOW track_counts

-- sqlfmt-corpus-separator --

SHOW transaction_deferrable

-- sqlfmt-corpus-separator --

SHOW transaction_isolation

-- sqlfmt-corpus-separator --

SHOW transaction_read_only

-- sqlfmt-corpus-separator --

SHOW vacuum_cost_delay

-- sqlfmt-corpus-separator --

START TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

START TRANSACTION READ WRITE

-- sqlfmt-corpus-separator --

TABLE bit_defaults

-- sqlfmt-corpus-separator --

TABLE city

-- sqlfmt-corpus-separator --

TABLE ddl_test

-- sqlfmt-corpus-separator --

TABLE gtestc

-- sqlfmt-corpus-separator --

TABLE information_schema.applicable_roles ORDER BY role_name COLLATE "C"

-- sqlfmt-corpus-separator --

TABLE information_schema.enabled_roles

-- sqlfmt-corpus-separator --

TABLE information_schema.enabled_roles ORDER BY role_name COLLATE "C"

-- sqlfmt-corpus-separator --

TABLE itest8

-- sqlfmt-corpus-separator --

TABLE mytab

-- sqlfmt-corpus-separator --

TABLE pa_target

-- sqlfmt-corpus-separator --

TABLE r1

-- sqlfmt-corpus-separator --

TABLE r2

-- sqlfmt-corpus-separator --

TABLE rls_test_src

-- sqlfmt-corpus-separator --

TABLE sometable

-- sqlfmt-corpus-separator --

TABLE t1

-- sqlfmt-corpus-separator --

TABLE timetz_local_view

-- sqlfmt-corpus-separator --

UPDATE test4nfd SET b = normalize(b, nfd)

-- sqlfmt-corpus-separator --

VALUES (1,2), (3,4+4), (7,77.7)
UNION ALL
SELECT 2+2, 57
UNION ALL
TABLE int8_tbl

-- sqlfmt-corpus-separator --

WITH outermost(x) AS (
  SELECT 1
  UNION (WITH innermost as (SELECT 2)
         SELECT * FROM innermost
         UNION SELECT 3)
)
SELECT * FROM outermost ORDER BY 1

-- sqlfmt-corpus-separator --

WITH outermost(x) AS (
  SELECT 1
  UNION (WITH innermost as (SELECT 2)
         SELECT * FROM outermost  -- fail
         UNION SELECT * FROM innermost)
)
SELECT * FROM outermost ORDER BY 1

-- sqlfmt-corpus-separator --

WITH uuidts AS (
    SELECT y, ts as ts, lag(ts) OVER (ORDER BY y) AS prev_ts
    FROM (SELECT y, uuid_extract_timestamp(uuidv7((y || ' years')::interval)) AS ts
        FROM generate_series(1970 - extract(year from now())::int, 10888 - extract(year from now())::int) y)
)
SELECT y, ts, prev_ts FROM uuidts WHERE ts < prev_ts

-- sqlfmt-corpus-separator --

abort

-- sqlfmt-corpus-separator --

alter default privileges for role regress_evt_user
 revoke delete on tables from regress_evt_user

-- sqlfmt-corpus-separator --

alter role regress_evt_user superuser

-- sqlfmt-corpus-separator --

alter schema testpart owner to regress_partitioning_role

-- sqlfmt-corpus-separator --

alter table domain_test add column c str_domain

-- sqlfmt-corpus-separator --

alter table domain_test add column d str_domain2

-- sqlfmt-corpus-separator --

alter table fullname add column longname text

-- sqlfmt-corpus-separator --

alter table header_copytest add column c text

-- sqlfmt-corpus-separator --

alter table nonesuch rename to newnonesuch

-- sqlfmt-corpus-separator --

alter table nonesuch rename to stud_emp

-- sqlfmt-corpus-separator --

alter table p1 add column f2 text

-- sqlfmt-corpus-separator --

alter table pg_toast_stud_emp rename to stud_emp

-- sqlfmt-corpus-separator --

alter table recur1 add column f2 array_of_recur1

-- sqlfmt-corpus-separator --

alter table recur1 add column f2 int

-- sqlfmt-corpus-separator --

alter table recur1 add column f2 recur1

-- sqlfmt-corpus-separator --

alter table recur1 add column f2 recur1[]

-- sqlfmt-corpus-separator --

alter table recur1 add column f2 recur2

-- sqlfmt-corpus-separator --

alter table renameColumn add column w int

-- sqlfmt-corpus-separator --

alter table s1.abc add column f2 float8

-- sqlfmt-corpus-separator --

alter table stud_emp rename to pg_toast_stud_emp

-- sqlfmt-corpus-separator --

alter table stud_emp rename to stud_emp

-- sqlfmt-corpus-separator --

alter table stud_emp rename to student

-- sqlfmt-corpus-separator --

alter table tabwithcols add column d int

-- sqlfmt-corpus-separator --

alter table tt11 add column z int

-- sqlfmt-corpus-separator --

alter table tt2 add column d int

-- sqlfmt-corpus-separator --

alter table tt2 add column e int

-- sqlfmt-corpus-separator --

alter table tt3 add column c int

-- sqlfmt-corpus-separator --

alter table tt3 add column e int

-- sqlfmt-corpus-separator --

alter table tt5 add column c int

-- sqlfmt-corpus-separator --

alter table tt5 add column cc int

-- sqlfmt-corpus-separator --

alter table tt7 add column z int

-- sqlfmt-corpus-separator --

alter table tt7 add column zz int

-- sqlfmt-corpus-separator --

alter table tt8 add column z2 int

-- sqlfmt-corpus-separator --

alter table users add column junk text

-- sqlfmt-corpus-separator --

alter type multitextrange1 owner to regress_multirange_owner

-- sqlfmt-corpus-separator --

alter type textrange1 owner to regress_multirange_owner

-- sqlfmt-corpus-separator --

begin

-- sqlfmt-corpus-separator --

begin transaction isolation level read committed

-- sqlfmt-corpus-separator --

begin transaction isolation level repeatable read

-- sqlfmt-corpus-separator --

begin transaction isolation level serializable

-- sqlfmt-corpus-separator --

begin work

-- sqlfmt-corpus-separator --

close c

-- sqlfmt-corpus-separator --

close c1

-- sqlfmt-corpus-separator --

commit

-- sqlfmt-corpus-separator --

copy (select * from (select t from test1 where id = 1 UNION select * from v_test1 ORDER BY 1) t1) to stdout

-- sqlfmt-corpus-separator --

copy (select * from copytest) to stdout (format json)

-- sqlfmt-corpus-separator --

copy (select * from test1 join test2 using (id)) to stdout

-- sqlfmt-corpus-separator --

copy (select 1 as foo union all select 2) to stdout with (format json)

-- sqlfmt-corpus-separator --

copy (select 1 union all select 2) to stdout with (format json)

-- sqlfmt-corpus-separator --

copy (select 1) to stdout

-- sqlfmt-corpus-separator --

copy (select t from test1 where id = 1 UNION select * from v_test1 ORDER BY 1) to stdout

-- sqlfmt-corpus-separator --

copy (select t from test1 where id=1) to stdout

-- sqlfmt-corpus-separator --

copy (values (1), (2)) TO stdout with (format json)

-- sqlfmt-corpus-separator --

copy attest from stdin

-- sqlfmt-corpus-separator --

copy attest to stdout

-- sqlfmt-corpus-separator --

copy attest("........pg.dropped.1........") from stdin

-- sqlfmt-corpus-separator --

copy attest("........pg.dropped.1........") to stdout

-- sqlfmt-corpus-separator --

copy attest(a) from stdin

-- sqlfmt-corpus-separator --

copy attest(a) to stdout

-- sqlfmt-corpus-separator --

copy attest(b,c) from stdin

-- sqlfmt-corpus-separator --

copy copy_default from stdin

-- sqlfmt-corpus-separator --

copy copy_default from stdin with (format csv)

-- sqlfmt-corpus-separator --

copy copyjsontest_types (id, arr, n, b) to stdout (format json)

-- sqlfmt-corpus-separator --

copy copyjsontest_types (id, js, jsb) to stdout (format json)

-- sqlfmt-corpus-separator --

copy copyjsontest_types (id, ts) to stdout (format json)

-- sqlfmt-corpus-separator --

copy copyjsontest_types (js) to stdout (format json)

-- sqlfmt-corpus-separator --

copy copyjsontest_types (jsb) to stdout (format json)

-- sqlfmt-corpus-separator --

copy copyjsontest_types (jsb, t) to stdout (format json)

-- sqlfmt-corpus-separator --

copy copyjsontest_types to stdout (format json)

-- sqlfmt-corpus-separator --

copy copytest (style, test, filler) to stdout (format json)

-- sqlfmt-corpus-separator --

copy copytest from stdin(format json)

-- sqlfmt-corpus-separator --

copy copytest to stdout (format json)

-- sqlfmt-corpus-separator --

copy copytest to stdout (format json, delimiter '|')

-- sqlfmt-corpus-separator --

copy copytest to stdout (format json, escape '"')

-- sqlfmt-corpus-separator --

copy copytest to stdout (format json, header 1)

-- sqlfmt-corpus-separator --

copy copytest to stdout (format json, header)

-- sqlfmt-corpus-separator --

copy copytest to stdout (format json, null '\N')

-- sqlfmt-corpus-separator --

copy copytest to stdout (format json, quote '"')

-- sqlfmt-corpus-separator --

copy copytest2(test) from stdin

-- sqlfmt-corpus-separator --

copy copytest4 from stdin (header)

-- sqlfmt-corpus-separator --

copy copytest5 from stdin (format csv, header '0')

-- sqlfmt-corpus-separator --

copy copytest5 from stdin (format csv, header '1')

-- sqlfmt-corpus-separator --

copy copytest5 from stdin (format csv, header 2)

-- sqlfmt-corpus-separator --

copy copytest5 from stdin (format csv, header 4)

-- sqlfmt-corpus-separator --

copy copytest5 from stdin (format csv, header 5)

-- sqlfmt-corpus-separator --

copy donothingbrtrig_test from stdout

-- sqlfmt-corpus-separator --

copy gstest2 from stdin

-- sqlfmt-corpus-separator --

copy gstest3 from stdin

-- sqlfmt-corpus-separator --

copy header_copytest (c, a) from stdin with (header match)

-- sqlfmt-corpus-separator --

copy header_copytest from stdin with (header match)

-- sqlfmt-corpus-separator --

copy header_copytest from stdin with (header wrong_choice)

-- sqlfmt-corpus-separator --

copy header_copytest to stdout with (header match)

-- sqlfmt-corpus-separator --

copy oversized_column_default from stdin

-- sqlfmt-corpus-separator --

copy parent (a, b) from stdin

-- sqlfmt-corpus-separator --

copy parted_copytest from stdin

-- sqlfmt-corpus-separator --

copy parted_stmt_trig(a) from stdin

-- sqlfmt-corpus-separator --

copy rc_test from stdin

-- sqlfmt-corpus-separator --

copy tab_progress_reporting from stdin

-- sqlfmt-corpus-separator --

copy test1 to stdout

-- sqlfmt-corpus-separator --

copy v_test1 to stdout

-- sqlfmt-corpus-separator --

create or replace view agg_view1 as
  select aggfns(a,a,c order by b)
    from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c)

-- sqlfmt-corpus-separator --

create or replace view agg_view1 as
  select aggfns(a,b,c order by b+1)
    from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c)

-- sqlfmt-corpus-separator --

create or replace view agg_view1 as
  select aggfns(distinct a,b,c order by b)
    from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
         generate_series(1,3) i

-- sqlfmt-corpus-separator --

create or replace view my_locks as
select case when c.relname like 'pg_toast%' then 'pg_toast' else c.relname end, max(mode::lockmodes) as max_lockmode
from pg_locks l join pg_class c on l.relation = c.oid
where virtualtransaction = (
        select virtualtransaction
        from pg_locks
        where transactionid = pg_current_xact_id()::xid)
and locktype = 'relation'
and relnamespace != (select oid from pg_namespace where nspname = 'pg_catalog')
and c.relname != 'my_locks'
group by c.relname

-- sqlfmt-corpus-separator --

create or replace view my_locks as
select case when c.relname like 'pg_toast%' then 'pg_toast' else c.relname end, max(mode::lockmodes) as max_lockmode
from pg_locks l join pg_class c on l.relation = c.oid
where virtualtransaction = (
        select virtualtransaction
        from pg_locks
        where transactionid = pg_current_xact_id()::xid)
and locktype = 'relation'
and relnamespace != (select oid from pg_namespace where nspname = 'pg_catalog')
and c.relname = 'my_locks'
group by c.relname

-- sqlfmt-corpus-separator --

create role regress_alice

-- sqlfmt-corpus-separator --

create role regress_bob

-- sqlfmt-corpus-separator --

create role regress_caller

-- sqlfmt-corpus-separator --

create role regress_coldesc_role

-- sqlfmt-corpus-separator --

create role regress_evt_user

-- sqlfmt-corpus-separator --

create role regress_fn_owner

-- sqlfmt-corpus-separator --

create role regress_multirange_owner

-- sqlfmt-corpus-separator --

create role regress_no_child_access

-- sqlfmt-corpus-separator --

create role regress_other_partitioned_fk_owner

-- sqlfmt-corpus-separator --

create role regress_parallel_worker

-- sqlfmt-corpus-separator --

create role regress_partitioning_role

-- sqlfmt-corpus-separator --

create schema alter1

-- sqlfmt-corpus-separator --

create schema alter2

-- sqlfmt-corpus-separator --

create schema not_there_initially

-- sqlfmt-corpus-separator --

create schema stts_s1

-- sqlfmt-corpus-separator --

create schema stts_s2

-- sqlfmt-corpus-separator --

create temp view usersview as
SELECT * FROM ROWS FROM(get_users(), generate_series(10,11)) WITH ORDINALITY

-- sqlfmt-corpus-separator --

create type aggtype as (a integer, b integer, c text)

-- sqlfmt-corpus-separator --

create type alter1.ctype as (f1 int, f2 text)

-- sqlfmt-corpus-separator --

create type avg_state as (total bigint, count bigint)

-- sqlfmt-corpus-separator --

create type cantcompare as (p point, r float8)

-- sqlfmt-corpus-separator --

create type comp as (a int, b int)

-- sqlfmt-corpus-separator --

create type comp1 as (a int, b date)

-- sqlfmt-corpus-separator --

create type comp3 as (a int, b mydomainrange)

-- sqlfmt-corpus-separator --

create type complex as (r float8, i float8)

-- sqlfmt-corpus-separator --

create type compostype as (x int, y varchar)

-- sqlfmt-corpus-separator --

create type comptype as (cf1 int, cf2 int)

-- sqlfmt-corpus-separator --

create type comptype as (f1 int, f2 text, f3 int[])

-- sqlfmt-corpus-separator --

create type comptype as (r float8, i float8)

-- sqlfmt-corpus-separator --

create type ct1 as (f1 varbit)

-- sqlfmt-corpus-separator --

create type ddtest1 as (f1 posint)

-- sqlfmt-corpus-separator --

create type eitype as (i integer, y integer)

-- sqlfmt-corpus-separator --

create type insert_test_type as (if1 int, if2 text[])

-- sqlfmt-corpus-separator --

create type intmultirange as (x int, y int)

-- sqlfmt-corpus-separator --

create type intr_multirange as (x int, y int)

-- sqlfmt-corpus-separator --

create type j_unordered_pair as (x int, y int)

-- sqlfmt-corpus-separator --

create type jb_unordered_pair as (x int, y int)

-- sqlfmt-corpus-separator --

create type jpop as (a text, b int, c timestamp)

-- sqlfmt-corpus-separator --

create type jpop2 as (a int, b json, c int, d int)

-- sqlfmt-corpus-separator --

create type jsb_char2 as (a char(2))

-- sqlfmt-corpus-separator --

create type jsb_i_gt_1_rec as (a jsb_i_gt_1)

-- sqlfmt-corpus-separator --

create type jsb_i_not_null_rec as (a jsb_i_not_null)

-- sqlfmt-corpus-separator --

create type jsb_ia as (a int[])

-- sqlfmt-corpus-separator --

create type jsb_ia2 as (a int[][])

-- sqlfmt-corpus-separator --

create type mycomptype as (id int, v bigint)

-- sqlfmt-corpus-separator --

create type nestedcomposite as (x int8_tbl)

-- sqlfmt-corpus-separator --

create type pg_temp.twophase_type as (a int)

-- sqlfmt-corpus-separator --

create type pp_rectype as (a int, b int)

-- sqlfmt-corpus-separator --

create type quad as (c1 complex, c2 complex)

-- sqlfmt-corpus-separator --

create type record_type as (x text, y int, z boolean)

-- sqlfmt-corpus-separator --

create type rewritetype as (a int)

-- sqlfmt-corpus-separator --

create type rngfunc2 as (a integer, b text)

-- sqlfmt-corpus-separator --

create type rngfunc_type as (f1 numeric(35,6), f2 numeric(35,2))

-- sqlfmt-corpus-separator --

create type testtype1 as (a int, b int)

-- sqlfmt-corpus-separator --

create type testtype2 as (a smallint, b bool)

-- sqlfmt-corpus-separator --

create type testtype3 as (a int, b text)

-- sqlfmt-corpus-separator --

create type testtype4 as (a int, b point)

-- sqlfmt-corpus-separator --

create type testtype5 as (a int)

-- sqlfmt-corpus-separator --

create type testtype6 as (a int, b point)

-- sqlfmt-corpus-separator --

create type textandtext as (c1 text, c2 text)

-- sqlfmt-corpus-separator --

create type two_ints as (a int, b int)

-- sqlfmt-corpus-separator --

create type xy_tuple AS (x int, y int)

-- sqlfmt-corpus-separator --

create view tt14v as select t.* from tt14f() t

-- sqlfmt-corpus-separator --

create view tt14v as select t.f1, t.f4 from tt14f() t

-- sqlfmt-corpus-separator --

create view vv2a as
select * from (values(now(),2,3,now(),5)) v(a,b,c,d,e)
union all
select * from tt7a left join tt8a using (x), tt8a tt8ax

-- sqlfmt-corpus-separator --

deallocate ab_q1

-- sqlfmt-corpus-separator --

deallocate ab_q2

-- sqlfmt-corpus-separator --

deallocate ab_q3

-- sqlfmt-corpus-separator --

deallocate ab_q4

-- sqlfmt-corpus-separator --

deallocate ab_q5

-- sqlfmt-corpus-separator --

deallocate ab_q6

-- sqlfmt-corpus-separator --

deallocate hp_q1

-- sqlfmt-corpus-separator --

deallocate mt_q1

-- sqlfmt-corpus-separator --

deallocate mt_q2

-- sqlfmt-corpus-separator --

deallocate part_abc_q1

-- sqlfmt-corpus-separator --

deallocate ps1

-- sqlfmt-corpus-separator --

deallocate ps2

-- sqlfmt-corpus-separator --

deallocate pstmt_def_insert

-- sqlfmt-corpus-separator --

deallocate q

-- sqlfmt-corpus-separator --

deallocate q1

-- sqlfmt-corpus-separator --

deallocate tenk1_count

-- sqlfmt-corpus-separator --

deallocate update_part_abc_view

-- sqlfmt-corpus-separator --

declare c cursor for select * from int8_tbl limit nochange(3)

-- sqlfmt-corpus-separator --

declare c1 cursor for select * from int8_tbl limit 10

-- sqlfmt-corpus-separator --

declare c1 cursor for select count_tt1_v(), count_tt1_s()

-- sqlfmt-corpus-separator --

declare c2 cursor for select * from int8_tbl limit 3

-- sqlfmt-corpus-separator --

declare c3 cursor for select * from int8_tbl offset 3

-- sqlfmt-corpus-separator --

declare c4 cursor for select * from int8_tbl offset 10

-- sqlfmt-corpus-separator --

declare c5 cursor for select * from int8_tbl order by q1 fetch first 2 rows with ties

-- sqlfmt-corpus-separator --

declare cur cursor for select left(a,10), b
  from (values(repeat('a', 512 * 1024),1),(repeat('b', 512),2)) v(a,b)
  order by v.a desc

-- sqlfmt-corpus-separator --

declare foo cursor for select * from trans_abc

-- sqlfmt-corpus-separator --

declare local_portal cursor for select * from toasted_data

-- sqlfmt-corpus-separator --

execute ab_q6(100)

-- sqlfmt-corpus-separator --

execute foo(false)

-- sqlfmt-corpus-separator --

execute foo(true)

-- sqlfmt-corpus-separator --

execute foom

-- sqlfmt-corpus-separator --

execute foom2 (1, 1)

-- sqlfmt-corpus-separator --

execute mt_q1(15)

-- sqlfmt-corpus-separator --

execute mt_q1(25)

-- sqlfmt-corpus-separator --

execute mt_q1(35)

-- sqlfmt-corpus-separator --

execute p1

-- sqlfmt-corpus-separator --

execute p2

-- sqlfmt-corpus-separator --

execute pstmt_def_insert(1)

-- sqlfmt-corpus-separator --

execute pstmt_def_insert(2)

-- sqlfmt-corpus-separator --

execute pstmt_def_insert(null)

-- sqlfmt-corpus-separator --

execute q

-- sqlfmt-corpus-separator --

execute q (1, 1)

-- sqlfmt-corpus-separator --

execute r

-- sqlfmt-corpus-separator --

execute s

-- sqlfmt-corpus-separator --

execute s1(0)

-- sqlfmt-corpus-separator --

execute s1(10)

-- sqlfmt-corpus-separator --

execute s1(NULL)

-- sqlfmt-corpus-separator --

execute t

-- sqlfmt-corpus-separator --

execute tenk1_count(1)

-- sqlfmt-corpus-separator --

execute test_mode_pp(1)

-- sqlfmt-corpus-separator --

execute u

-- sqlfmt-corpus-separator --

execute update_part_abc_view (1, 'd')

-- sqlfmt-corpus-separator --

execute update_part_abc_view (2, 'a')

-- sqlfmt-corpus-separator --

execute update_part_abc_view (3, 'a')

-- sqlfmt-corpus-separator --

execute v

-- sqlfmt-corpus-separator --

fetch 1 from cur

-- sqlfmt-corpus-separator --

fetch 1 from curs

-- sqlfmt-corpus-separator --

fetch all from c

-- sqlfmt-corpus-separator --

fetch all from c1

-- sqlfmt-corpus-separator --

fetch all from c2

-- sqlfmt-corpus-separator --

fetch all from rf_cur

-- sqlfmt-corpus-separator --

fetch all from test2

-- sqlfmt-corpus-separator --

fetch from foo

-- sqlfmt-corpus-separator --

insert into src
  select string_agg(random()::text,'') from generate_series(1,10000)

-- sqlfmt-corpus-separator --

insert into utrtest values (1, 'foo')
  returning *, tableoid::regclass, xmin = pg_current_xact_id()::xid as xmin_ok

-- sqlfmt-corpus-separator --

insert into utrtest values (2, 'bar')
  returning *, tableoid::regclass, xmin = pg_current_xact_id()::xid as xmin_ok

-- sqlfmt-corpus-separator --

prepare ab_q6 as
select * from (
	select tableoid::regclass,a,b from ab
union all
	select tableoid::regclass,x,y from xy_1
union all
	select tableoid::regclass,a,b from ab
) ab where a = $1 and b = (select -10)

-- sqlfmt-corpus-separator --

prepare int8_query as select * from int8_tbl i8

-- sqlfmt-corpus-separator --

prepare p1 as select f1 from abc

-- sqlfmt-corpus-separator --

prepare p2 as select nextval('seq')

-- sqlfmt-corpus-separator --

prepare prep_stmt as select length(stringu1) from tenk1 group by length(stringu1)

-- sqlfmt-corpus-separator --

prepare ps1 as
  select * from mc3p where a = $1 and abs(b) < (select 3)

-- sqlfmt-corpus-separator --

prepare ps2 as
  select * from mc3p where a <= $1 and abs(b) < (select 3)

-- sqlfmt-corpus-separator --

prepare q as select array_to_string(array_agg(repeat('x',2*n)),E'\n') as "ab

c", array_to_string(array_agg(repeat('y',20-2*n)),E'\n') as "a
bc" from generate_series(1,10) as n(n) group by n>1 order by n>1

-- sqlfmt-corpus-separator --

prepare q as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare q as select repeat('x',2*n) as "0123456789abcdef", repeat('y',20-2*n) as "0123456789" from generate_series(1,10) as n

-- sqlfmt-corpus-separator --

prepare r as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare s as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare s1 as select $1::pos_int = 10 as "is_ten"

-- sqlfmt-corpus-separator --

prepare t as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare u as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare v as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

rollback

-- sqlfmt-corpus-separator --

select 'empty'::numrange << nummultirange()

-- sqlfmt-corpus-separator --

select 'empty'::numrange >> nummultirange()

-- sqlfmt-corpus-separator --

select ( with cte(foo) as ( values(f1) )
          values((select foo from cte)) )
from int4_tbl

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[:]

-- sqlfmt-corpus-separator --

select (dfunc()).*

-- sqlfmt-corpus-separator --

select * from
    int4_tbl i4,
    lateral (
        select i4.f1 > 1 as b, 1 as id
        from (select random() order by 1) as t1
      union all
        select true as b, 2 as id
    ) as t2
where b and f1 >= 0

-- sqlfmt-corpus-separator --

select * from
  ((select a.q1 as x, random() from int8_tbl a where q1 > 0)
   union all
   (select b.q2 as x, random() from int8_tbl b where q2 > 0)) ss
where x < 0

-- sqlfmt-corpus-separator --

select * from (select (pg_timezone_names()).name) ptn where name='UTC' limit 1

-- sqlfmt-corpus-separator --

select * from (values (0), (1)) v(id),
lateral (select * from int8_tbl t1,
         lateral (select * from
                    (select * from int8_tbl t2
                     where (q1, random() > 0) = any (select q2, random() > 0 from int8_tbl t3
                                     where q2 = (select greatest(t1.q1,t2.q2))
                                       and (select v.id=0)) offset 0) ss2) ss
         where t1.q1 = ss.q2) ss0

-- sqlfmt-corpus-separator --

select * from compos()

-- sqlfmt-corpus-separator --

select * from conflict_test()

-- sqlfmt-corpus-separator --

select * from dfunc()

-- sqlfmt-corpus-separator --

select * from explain_parallel_sort_stats()

-- sqlfmt-corpus-separator --

select * from explain_sq_limit()

-- sqlfmt-corpus-separator --

select * from int8_tbl limit (case when random() < 0.5 then null::bigint end)

-- sqlfmt-corpus-separator --

select * from int8_tbl offset (case when random() < 0.5 then null::bigint end)

-- sqlfmt-corpus-separator --

select * from pg_ls_waldir() limit 0

-- sqlfmt-corpus-separator --

select * from ret_query1()

-- sqlfmt-corpus-separator --

select * from return_dquery()

-- sqlfmt-corpus-separator --

select * from returnqueryf()

-- sqlfmt-corpus-separator --

select * from rngfuncbar()

-- sqlfmt-corpus-separator --

select * from rttest()

-- sqlfmt-corpus-separator --

select * from sc_test()

-- sqlfmt-corpus-separator --

select * from test_table_func_rec()

-- sqlfmt-corpus-separator --

select * from test_table_func_row()

-- sqlfmt-corpus-separator --

select * from testrngfunc()

-- sqlfmt-corpus-separator --

select * from tp_chk_data()

-- sqlfmt-corpus-separator --

select a.unique1, b.unique2
  from onek a left join onek b on a.unique1 = b.unique2
  where (b.unique2, random() > 0) = any (select q1, random() > 0 from int8_tbl c where c.q1 < b.unique1)

-- sqlfmt-corpus-separator --

select aggfns(distinct a,a,c order by a)
  from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
       generate_series(1,2) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,a,c order by a,b)
  from (values (1,1,'foo')) v(a,b,c), generate_series(1,2) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c order by a,b+1)
  from (values (1,1,'foo')) v(a,b,c), generate_series(1,2) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c order by a,b,i,c)
  from (values (1,1,'foo')) v(a,b,c), generate_series(1,2) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c order by b)
  from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
       generate_series(1,3) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c order by i)
  from (values (1,1,'foo')) v(a,b,c), generate_series(1,2) i

-- sqlfmt-corpus-separator --

select aggfstr(distinct a,b,c order by b)
  from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
       generate_series(1,3) i

-- sqlfmt-corpus-separator --

select array_agg(a order by a desc)
  from (values (1,4),(2,3),(3,1),(4,2)) v(a,b)

-- sqlfmt-corpus-separator --

select array_agg(a order by a)
  from (values (1,4),(2,3),(3,1),(4,2)) v(a,b)

-- sqlfmt-corpus-separator --

select array_agg(a order by b)
  from (values (1,4),(2,3),(3,1),(4,2)) v(a,b)

-- sqlfmt-corpus-separator --

select array_agg(b order by a desc)
  from (values (1,4),(2,3),(3,1),(4,2)) v(a,b)

-- sqlfmt-corpus-separator --

select array_agg(distinct a order by a desc nulls last)
  from (values (1),(2),(1),(3),(null),(2)) v(a)

-- sqlfmt-corpus-separator --

select array_agg(distinct a order by a desc)
  from (values (1),(2),(1),(3),(null),(2)) v(a)

-- sqlfmt-corpus-separator --

select array_agg(distinct a order by a)
  from (values (1),(2),(1),(3),(null),(2)) v(a)

-- sqlfmt-corpus-separator --

select array_agg(distinct ar order by ar desc)
  from (select array[i / 2] from generate_series(1,10) a(i)) b(ar)

-- sqlfmt-corpus-separator --

select arrayassign1()

-- sqlfmt-corpus-separator --

select attname, to_json(histogram_bounds) histogram_bounds
from pg_stats
where tablename = 'rows' and
      schemaname = pg_my_temp_schema()::regnamespace::text
order by 1

-- sqlfmt-corpus-separator --

select attname, to_jsonb(histogram_bounds) histogram_bounds
from pg_stats
where tablename = 'rows' and
      schemaname = pg_my_temp_schema()::regnamespace::text
order by 1

-- sqlfmt-corpus-separator --

select avg((select avg(a1.col1 order by (select avg(a2.col2) from tenk1 a3))
            from tenk1 a1(col1)))
from tenk1 a2(col2)

-- sqlfmt-corpus-separator --

select cache_test_2()

-- sqlfmt-corpus-separator --

select cachebug()

-- sqlfmt-corpus-separator --

select compos()

-- sqlfmt-corpus-separator --

select composrec()

-- sqlfmt-corpus-separator --

select constant_refcursor()

-- sqlfmt-corpus-separator --

select count(*) > 0 as ok from (select * from pg_ls_waldir() limit 1) ss

-- sqlfmt-corpus-separator --

select count(*) > 0 as ok from (select pg_ls_waldir()) ss

-- sqlfmt-corpus-separator --

select count(*) >= 0 as ok from pg_ls_archive_statusdir()

-- sqlfmt-corpus-separator --

select count(*) >= 0 as ok from pg_ls_summariesdir()

-- sqlfmt-corpus-separator --

select dfunc()

-- sqlfmt-corpus-separator --

select distinct on (1) floor(random()) as r, f1 from int4_tbl order by 1,2

-- sqlfmt-corpus-separator --

select error_trap_test()

-- sqlfmt-corpus-separator --

select excpt_test1()

-- sqlfmt-corpus-separator --

select excpt_test2()

-- sqlfmt-corpus-separator --

select excpt_test3()

-- sqlfmt-corpus-separator --

select excpt_test4()

-- sqlfmt-corpus-separator --

select extract(epoch from '256 microseconds'::interval * (2^55)::float8)

-- sqlfmt-corpus-separator --

select f1()

-- sqlfmt-corpus-separator --

select fail()

-- sqlfmt-corpus-separator --

select forc01()

-- sqlfmt-corpus-separator --

select func_with_bad_set()

-- sqlfmt-corpus-separator --

select generate_series(0,2) as s1, generate_series((random()*.1)::int,2) as s2

-- sqlfmt-corpus-separator --

select generate_series(0,2) as s1, generate_series((random()*.1)::int,2) as s2
order by s2 desc

-- sqlfmt-corpus-separator --

select missing_return_expr()

-- sqlfmt-corpus-separator --

select myleast()

-- sqlfmt-corpus-separator --

select namedparmcursor_test7()

-- sqlfmt-corpus-separator --

select namedparmcursor_test8()

-- sqlfmt-corpus-separator --

select nummultirange() << 'empty'::numrange

-- sqlfmt-corpus-separator --

select nummultirange() << nummultirange()

-- sqlfmt-corpus-separator --

select nummultirange() << nummultirange(numrange(1,2))

-- sqlfmt-corpus-separator --

select nummultirange() << numrange(1,2)

-- sqlfmt-corpus-separator --

select nummultirange() >> 'empty'::numrange

-- sqlfmt-corpus-separator --

select nummultirange() >> nummultirange()

-- sqlfmt-corpus-separator --

select nummultirange() >> nummultirange(numrange(1,2))

-- sqlfmt-corpus-separator --

select nummultirange() >> numrange(1,2)

-- sqlfmt-corpus-separator --

select nummultirange(numrange(1,2)) << nummultirange()

-- sqlfmt-corpus-separator --

select nummultirange(numrange(1,2)) >> nummultirange()

-- sqlfmt-corpus-separator --

select numrange(1,2) << nummultirange()

-- sqlfmt-corpus-separator --

select numrange(1,2) >> nummultirange()

-- sqlfmt-corpus-separator --

select pg_current_xact_id() >= pg_snapshot_xmin(pg_current_snapshot())

-- sqlfmt-corpus-separator --

select pg_event_trigger_table_rewrite_oid()

-- sqlfmt-corpus-separator --

select pg_stat_force_next_flush()

-- sqlfmt-corpus-separator --

select pg_temp.whoami()

-- sqlfmt-corpus-separator --

select pg_trigger_depth()

-- sqlfmt-corpus-separator --

select pg_visible_in_snapshot(pg_current_xact_id(), pg_current_snapshot())

-- sqlfmt-corpus-separator --

select raise_exprs()

-- sqlfmt-corpus-separator --

select raise_test()

-- sqlfmt-corpus-separator --

select rngfuncbar()

-- sqlfmt-corpus-separator --

select rngfunct.rngfuncid, rngfunct.f2 from rngfunct(sin(pi()/2)::int) ORDER BY 1,2

-- sqlfmt-corpus-separator --

select set_and_report_role()

-- sqlfmt-corpus-separator --

select sp_test_func() order by 1

-- sqlfmt-corpus-separator --

select stacked_diagnostics_test()

-- sqlfmt-corpus-separator --

select stricttest()

-- sqlfmt-corpus-separator --

select string_agg(distinct f1, ',' order by f1) from varchar_tbl

-- sqlfmt-corpus-separator --

select string_agg(distinct f1, ',' order by f1::text) from varchar_tbl

-- sqlfmt-corpus-separator --

select string_agg(distinct f1::text, ',' order by f1) from varchar_tbl

-- sqlfmt-corpus-separator --

select string_agg(distinct f1::text, ',' order by f1::text) from varchar_tbl

-- sqlfmt-corpus-separator --

select strtest()

-- sqlfmt-corpus-separator --

select sum(ss.tst::int) from
  onek o cross join lateral (
  select i.ten in (select f1 from int4_tbl where f1 <= o.hundred) as tst,
         random() as r
  from onek i where i.unique1 = o.unique1 ) ss
where o.ten = 0

-- sqlfmt-corpus-separator --

select sum(tenthous) as s1, sum(tenthous) + random()*0 as s2
  from tenk1 group by thousand order by thousand limit 3

-- sqlfmt-corpus-separator --

select ten,
  sum(unique1) + sum(unique2) as res,
  rank() over (order by sum(unique1) + sum(unique2)) as rank
from tenk1
group by ten order by ten

-- sqlfmt-corpus-separator --

select test_found()

-- sqlfmt-corpus-separator --

select testrngfunc()

-- sqlfmt-corpus-separator --

select textmultirange()

-- sqlfmt-corpus-separator --

select tp_ins_data()

-- sqlfmt-corpus-separator --

select txid_current() >= txid_snapshot_xmin(txid_current_snapshot())

-- sqlfmt-corpus-separator --

select txid_visible_in_snapshot(txid_current(), txid_current_snapshot())

-- sqlfmt-corpus-separator --

select unreserved_test()

-- sqlfmt-corpus-separator --

select use_refcursor(return_unnamed_refcursor())

-- sqlfmt-corpus-separator --

select void_return_expr()

-- sqlfmt-corpus-separator --

select whoami()

-- sqlfmt-corpus-separator --

table ab

-- sqlfmt-corpus-separator --

table dcomptable

-- sqlfmt-corpus-separator --

table has_fast_default

-- sqlfmt-corpus-separator --

table my_table

-- sqlfmt-corpus-separator --

table part_abc_log

-- sqlfmt-corpus-separator --

table part_abc_view

-- sqlfmt-corpus-separator --

table partitioned

-- sqlfmt-corpus-separator --

table some_tab

-- sqlfmt-corpus-separator --

update xacttest set a = max_xacttest() + 10 where a > 0

-- sqlfmt-corpus-separator --

with
A as ( select q2 as id, (select q1) as x from int8_tbl ),
B as ( select id, row_number() over (partition by id) as r from A ),
C as ( select A.id, array(select B.id from B where B.id = A.id) from A )
select * from C

-- sqlfmt-corpus-separator --

with cte(foo) as ( values(42) ) values((select foo from cte))