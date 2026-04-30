ABORT

-- sqlfmt-corpus-separator --

ABORT AND CHAIN

-- sqlfmt-corpus-separator --

ABORT;

-- sqlfmt-corpus-separator --

ABORT;
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
DECLARE dup CURSOR FOR SELECT 0;

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
DECLARE foo CURSOR FOR SELECT '101';

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
DECLARE foo CURSOR FOR SELECT 'abc'::STRING, 'a'::CHAR, True, 1.1::FLOAT, 1.1::DECIMAL, NULL::BIT;

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
DECLARE foo CURSOR FOR SELECT 'abc';

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
DECLARE foo CURSOR FOR SELECT * FROM (VALUES ('abc'), ('100'), ('1.01'), ('1.01'), ('t'), ('1'), ('a'));

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
DECLARE foo CURSOR FOR SELECT * FROM xy ORDER BY x DESC;

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
DECLARE foo CURSOR FOR SELECT 10000000;

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
DECLARE foo CURSOR FOR SELECT 5.0101::DECIMAL FROM generate_series(1, 5);

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
DECLARE foo CURSOR FOR SELECT 5.0101::FLOAT FROM generate_series(1, 5);

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
DECLARE foo CURSOR FOR SELECT generate_series(0, 10);

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
INSERT INTO xy VALUES (7, 8), (9, 10), (11, 12), (13, 14), (15, 16);
DECLARE foo CURSOR FOR SELECT * FROM xy ORDER BY x DESC;

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
SELECT f(0, 3);

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
SELECT f(1);

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
SELECT f(1, 3);

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
SELECT f(2);

-- sqlfmt-corpus-separator --

ABORT;
BEGIN;
SELECT f(2, 3);

-- sqlfmt-corpus-separator --

ABORT;
DELETE FROM xy WHERE x >= 100;
INSERT INTO xy VALUES (5, 6);

-- sqlfmt-corpus-separator --

ABORT; BEGIN TRANSACTION

-- sqlfmt-corpus-separator --

ALTER DATABASE atest OWNER TO u;
  ALTER SCHEMA atest.sc OWNER TO u;
  ALTER TABLE atest.sc.t OWNER TO u;
  ALTER TYPE atest.sc.ty OWNER TO u

-- sqlfmt-corpus-separator --

ALTER DATABASE d OWNER TO b

-- sqlfmt-corpus-separator --

ALTER DATABASE d OWNER TO fake_user

-- sqlfmt-corpus-separator --

ALTER DATABASE d OWNER TO root

-- sqlfmt-corpus-separator --

ALTER DATABASE d OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER DATABASE d OWNER TO testuser2

-- sqlfmt-corpus-separator --

ALTER DATABASE owner_grant_option OWNER TO other_owner

-- sqlfmt-corpus-separator --

ALTER DATABASE test OWNER TO root

-- sqlfmt-corpus-separator --

ALTER DATABASE test_db OWNER TO testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES GRANT ALL ON TABLES TO testuser, testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES GRANT CREATE ON TABLES TO testuser

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES GRANT CREATE ON TABLES TO testuser, testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES GRANT SELECT ON TABLES TO foo;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES GRANT SELECT ON TABLES TO roach_a;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES GRANT SELECT ON TABLES TO testuser

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES GRANT SELECT ON TABLES TO testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES IN SCHEMA public GRANT SELECT ON TABLES TO test2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES IN SCHEMA public REVOKE SELECT ON TABLES FROM test2;
ALTER DEFAULT PRIVILEGES FOR ALL ROLES IN SCHEMA public GRANT USAGE ON TYPES TO test2;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES IN SCHEMA s GRANT SELECT ON TABLES TO test4

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES IN SCHEMA s REVOKE SELECT ON TABLES FROM test4;
ALTER DEFAULT PRIVILEGES FOR ALL ROLES IN SCHEMA s GRANT USAGE ON TYPES TO test4;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES REVOKE SELECT ON TABLES FROM testuser

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES REVOKE SELECT ON TABLES FROM testuser2;
ALTER DEFAULT PRIVILEGES FOR ALL ROLES GRANT USAGE ON SCHEMAS TO testuser2;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES REVOKE USAGE ON SCHEMAS FROM testuser2;
ALTER DEFAULT PRIVILEGES FOR ALL ROLES GRANT USAGE ON TYPES TO testuser2;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE bar GRANT ALL ON SCHEMAS TO bar;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE bar GRANT ALL ON TABLES TO bar;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE bar GRANT ALL ON TYPES TO bar;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE default_priv_user GRANT USAGE ON TYPES TO public

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE default_priv_user REVOKE ALL ON SCHEMAS FROM public

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE default_priv_user REVOKE ALL ON TABLES FROM public

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE default_priv_user REVOKE USAGE ON TYPES FROM public

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE default_priv_user2 GRANT ALL ON SCHEMAS TO public

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE default_priv_user2 GRANT ALL ON TABLES TO public

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE default_priv_user2 REVOKE ALL ON SCHEMAS FROM public

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE default_priv_user2 REVOKE ALL ON TABLES FROM public

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE foo GRANT ALL ON SCHEMAS TO foo;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE foo GRANT ALL ON TABLES TO foo;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE foo GRANT ALL ON TYPES TO foo;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE foo GRANT SELECT ON TABLES TO foo;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE foo REVOKE SELECT ON TABLES FROM foo;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE foo, bar REVOKE ALL ON SCHEMAS FROM foo, bar;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE foo, bar REVOKE ALL ON TABLES FROM foo, bar;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE foo, bar REVOKE ALL ON TYPES FROM foo, bar;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE public REVOKE SELECT ON TABLES FROM testuser2, testuser3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE roach_b GRANT SELECT ON TABLES TO roach_a;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE roach_c GRANT SELECT ON TABLES TO roach_d;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE roach_d GRANT SELECT ON TABLES TO roach_b;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE root GRANT SELECT ON TABLES TO testuser

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE root GRANT SELECT ON TABLES TO testuser;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE root, testuser GRANT SELECT ON TABLES TO testuser2, testuser3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE root, testuser REVOKE ALL ON TABLES FROM testuser, testuser2, testuser3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE root, testuser REVOKE SELECT ON TABLES FROM testuser2, testuser3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE self_referencing_role GRANT INSERT ON TABLES TO self_referencing_role

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE test1 IN SCHEMA public GRANT SELECT ON TABLES TO test2;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE test3 IN SCHEMA s GRANT SELECT ON TABLES TO test4;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser GRANT ALL ON TABLES TO testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser GRANT INSERT ON TABLES TO testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser GRANT SELECT ON TABLES to testuser, testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser GRANT SELECT ON TABLES to testuser, who

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser GRANT SELECT ON TABLES to who

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser IN SCHEMA public GRANT SELECT ON TABLES TO testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser IN SCHEMA s, public GRANT ALL ON TABLES TO testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser IN SCHEMA s, public REVOKE ALL ON TABLES FROM testuser2;
ALTER DEFAULT PRIVILEGES FOR ALL ROLES IN SCHEMA s, public GRANT SELECT ON TABLES TO testuser2;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser REVOKE ALL ON SCHEMAS FROM testuser, testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser REVOKE ALL ON TABLES FROM testuser

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser REVOKE ALL ON TABLES FROM testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser REVOKE ALL ON TABLES FROM testuser;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser REVOKE ALL ON TABLES FROM testuser;
ALTER DEFAULT PRIVILEGES FOR ROLE testuser REVOKE ALL ON TABLES FROM testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser REVOKE ALL ON TYPES FROM testuser, testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser REVOKE SELECT ON TABLES FROM testuser, testuser2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser1 GRANT SELECT ON TABLES TO testuser2;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser1 REVOKE SELECT ON TABLES FROM testuser2;
ALTER DEFAULT PRIVILEGES FOR ROLE testuser1 GRANT USAGE ON SCHEMAS TO testuser2;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE testuser1 REVOKE USAGE ON SCHEMAS FROM testuser2;
ALTER DEFAULT PRIVILEGES FOR ROLE testuser1 GRANT USAGE ON TYPES TO testuser2;

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE who GRANT SELECT ON TABLES to testuser

-- sqlfmt-corpus-separator --

ALTER INDEX IF EXISTS ffo RENAME TO ufo

-- sqlfmt-corpus-separator --

ALTER INDEX IF EXISTS foo RENAME TO ufo

-- sqlfmt-corpus-separator --

ALTER INDEX IF EXISTS nonexistent RENAME TO foo

-- sqlfmt-corpus-separator --

ALTER INDEX IF EXISTS ufooo RENAME TO ufoo

-- sqlfmt-corpus-separator --

ALTER INDEX a_pk3 RENAME TO a_pk4

-- sqlfmt-corpus-separator --

ALTER INDEX a_pkey RENAME TO a_pk

-- sqlfmt-corpus-separator --

ALTER INDEX ffo RENAME TO ufo

-- sqlfmt-corpus-separator --

ALTER INDEX foo RENAME TO ufo

-- sqlfmt-corpus-separator --

ALTER INDEX i1 RENAME TO i2;

-- sqlfmt-corpus-separator --

ALTER INDEX idx2 RENAME TO idx

-- sqlfmt-corpus-separator --

ALTER INDEX public.a_pk RENAME TO a_pk2

-- sqlfmt-corpus-separator --

ALTER INDEX public.a_pk3 RENAME TO a_pk4

-- sqlfmt-corpus-separator --

ALTER INDEX public.public.t_pkey RENAME TO t_pk

-- sqlfmt-corpus-separator --

ALTER INDEX public.t_pkey RENAME TO t_pk

-- sqlfmt-corpus-separator --

ALTER INDEX test.a_pk2 RENAME TO a_pk3

-- sqlfmt-corpus-separator --

ALTER INDEX ufoo RENAME TO ufo

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mvx OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mvx OWNER TO testuser2

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW normal_view RENAME TO newname

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW vx OWNER TO testuser;

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW with_options OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER ROLE ALL RESET ALL

-- sqlfmt-corpus-separator --

ALTER ROLE ALL SET application_name = 'abc'

-- sqlfmt-corpus-separator --

ALTER ROLE ALL SET application_name = 'c'

-- sqlfmt-corpus-separator --

ALTER ROLE ALL SET tracing = 'off'

-- sqlfmt-corpus-separator --

ALTER ROLE admin SET application_name = 'g'

-- sqlfmt-corpus-separator --

ALTER ROLE admin with NOCREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE fake_role SET application_name = 'e';

-- sqlfmt-corpus-separator --

ALTER ROLE other_admin NOCREATEDB

-- sqlfmt-corpus-separator --

ALTER ROLE other_admin SET application_name = 'abc'

-- sqlfmt-corpus-separator --

ALTER ROLE otherrole LOGIN

-- sqlfmt-corpus-separator --

ALTER ROLE otherrole NOLOGIN

-- sqlfmt-corpus-separator --

ALTER ROLE public SET application_name = 'g'

-- sqlfmt-corpus-separator --

ALTER ROLE roach RESET search_path

-- sqlfmt-corpus-separator --

ALTER ROLE roach SET application_name = 'e'

-- sqlfmt-corpus-separator --

ALTER ROLE roach SET statement_timeout = '10s'

-- sqlfmt-corpus-separator --

ALTER ROLE roach SET timezone = 'America/New_York'

-- sqlfmt-corpus-separator --

ALTER ROLE roach SET use_declarative_schema_changer = 'off'

-- sqlfmt-corpus-separator --

ALTER ROLE roleg WITH NOCREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE roleg with NOCREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE rolek CREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE rolewithcreate WITH NOCREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE root SET application_name = 'g'

-- sqlfmt-corpus-separator --

ALTER ROLE test_set_role RESET application_name

-- sqlfmt-corpus-separator --

ALTER ROLE test_set_role RESET potato;
ALTER ROLE test_set_role SET potato TO DEFAULT;

-- sqlfmt-corpus-separator --

ALTER ROLE test_set_role SET application_name = 'f'

-- sqlfmt-corpus-separator --

ALTER ROLE test_set_role SET backslash_quote = 'off'

-- sqlfmt-corpus-separator --

ALTER ROLE test_set_role SET backslash_quote = 'safe_encoding'

-- sqlfmt-corpus-separator --

ALTER ROLE test_set_role SET database = 'd'

-- sqlfmt-corpus-separator --

ALTER ROLE test_set_role SET integer_datetimes = 'on'

-- sqlfmt-corpus-separator --

ALTER ROLE test_set_role SET potato = 'potato'

-- sqlfmt-corpus-separator --

ALTER ROLE test_set_role SET role = 'd'

-- sqlfmt-corpus-separator --

ALTER ROLE test_set_role SET serial_normalization = 'potato'

-- sqlfmt-corpus-separator --

ALTER ROLE test_set_role SET serial_normalization = 'sql_sequence';
ALTER ROLE test_set_role RESET application_name

-- sqlfmt-corpus-separator --

ALTER ROLE test_set_role SET transaction_isolation = 'serializable'

-- sqlfmt-corpus-separator --

ALTER ROLE testrole CREATEROLE NOCREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE testrole WITH CREATEROLE CREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE testrole WITH CREATEROLE NOCREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE testrole WITH NOCREATEROLE NOCREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE testuser CREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE testuser NOCREATEDB

-- sqlfmt-corpus-separator --

ALTER ROLE testuser NOCREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE testuser RESET application_name

-- sqlfmt-corpus-separator --

ALTER ROLE testuser SET default_int_size = 4

-- sqlfmt-corpus-separator --

ALTER ROLE testuser WITH CREATEDB;

-- sqlfmt-corpus-separator --

ALTER ROLE testuser WITH CREATEROLE

-- sqlfmt-corpus-separator --

ALTER SCHEMA another_schema RENAME TO another_one

-- sqlfmt-corpus-separator --

ALTER SCHEMA myschema RENAME TO myschema2

-- sqlfmt-corpus-separator --

ALTER SCHEMA myschema RENAME TO pg_temp_not_temp

-- sqlfmt-corpus-separator --

ALTER SCHEMA myschema RENAME TO public

-- sqlfmt-corpus-separator --

ALTER SCHEMA myschema RENAME TO yourschema

-- sqlfmt-corpus-separator --

ALTER SCHEMA myschema2 RENAME TO another_schema

-- sqlfmt-corpus-separator --

ALTER SCHEMA myschema2 RENAME TO myschema3

-- sqlfmt-corpus-separator --

ALTER SCHEMA owner_grant_option OWNER TO other_owner

-- sqlfmt-corpus-separator --

ALTER SCHEMA pg_catalog OWNER TO root

-- sqlfmt-corpus-separator --

ALTER SCHEMA pg_catalog RENAME TO mysql_catalog

-- sqlfmt-corpus-separator --

ALTER SCHEMA privs RENAME TO denied

-- sqlfmt-corpus-separator --

ALTER SCHEMA public OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER SCHEMA public RENAME TO private

-- sqlfmt-corpus-separator --

ALTER SCHEMA s OWNER TO CURRENT_USER

-- sqlfmt-corpus-separator --

ALTER SCHEMA s OWNER TO SESSION_USER

-- sqlfmt-corpus-separator --

ALTER SCHEMA s OWNER TO root

-- sqlfmt-corpus-separator --

ALTER SCHEMA s OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER SCHEMA s OWNER TO testuser2

-- sqlfmt-corpus-separator --

ALTER SCHEMA s RENAME TO foo

-- sqlfmt-corpus-separator --

ALTER SCHEMA s RENAME TO r

-- sqlfmt-corpus-separator --

ALTER SCHEMA s1 OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER SCHEMA sc RENAME TO sc1;

-- sqlfmt-corpus-separator --

ALTER SCHEMA sc RENAME TO sc_new;

-- sqlfmt-corpus-separator --

ALTER SCHEMA sc1 RENAME TO sc1_new

-- sqlfmt-corpus-separator --

ALTER SCHEMA sc_new RENAME TO sc;
SELECT * FROM v;

-- sqlfmt-corpus-separator --

ALTER SCHEMA sc_new RENAME TO sc;
SELECT f()

-- sqlfmt-corpus-separator --

ALTER SCHEMA test_schema RENAME to new_test_schema

-- sqlfmt-corpus-separator --

ALTER SCHEMA u RENAME TO t

-- sqlfmt-corpus-separator --

ALTER SCHEMA with_alter_schema.altered_schema OWNER TO root;

-- sqlfmt-corpus-separator --

ALTER SCHEMA with_alter_schema.schema_to_alter RENAME TO altered_schema;

-- sqlfmt-corpus-separator --

ALTER TABLE IF EXISTS does_not_exist OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER TABLE IF EXISTS foo RENAME TO bar

-- sqlfmt-corpus-separator --

ALTER TABLE a ADD COLUMN c INT

-- sqlfmt-corpus-separator --

ALTER TABLE a RENAME TO b

-- sqlfmt-corpus-separator --

ALTER TABLE abcd ADD COLUMN f DECIMAL

-- sqlfmt-corpus-separator --

ALTER TABLE accounts OWNER TO alice;

-- sqlfmt-corpus-separator --

ALTER TABLE alter_policy_table OWNER TO alter_policy_role;

-- sqlfmt-corpus-separator --

ALTER TABLE audit ADD COLUMN y INT

-- sqlfmt-corpus-separator --

ALTER TABLE backfill_c ADD COLUMN s STRING

-- sqlfmt-corpus-separator --

ALTER TABLE bar ADD COLUMN b INT

-- sqlfmt-corpus-separator --

ALTER TABLE base_t OWNER TO table_owner;

-- sqlfmt-corpus-separator --

ALTER TABLE baz OWNER TO bar_role;

-- sqlfmt-corpus-separator --

ALTER TABLE baz OWNER TO foo_role;

-- sqlfmt-corpus-separator --

ALTER TABLE child OWNER TO fk_user;

-- sqlfmt-corpus-separator --

ALTER TABLE cnt OWNER TO r1_user;

-- sqlfmt-corpus-separator --

ALTER TABLE created_as_global ADD COLUMN crdb_region INT;

-- sqlfmt-corpus-separator --

ALTER TABLE cross_error ADD COLUMN y other.t

-- sqlfmt-corpus-separator --

ALTER TABLE dontwant RENAME TO want

-- sqlfmt-corpus-separator --

ALTER TABLE foo ADD COLUMN a INT

-- sqlfmt-corpus-separator --

ALTER TABLE foo ADD COLUMN j INT

-- sqlfmt-corpus-separator --

ALTER TABLE foo ADD COLUMN k INT

-- sqlfmt-corpus-separator --

ALTER TABLE foo ADD COLUMN k SERIAL

-- sqlfmt-corpus-separator --

ALTER TABLE foo RENAME TO bar

-- sqlfmt-corpus-separator --

ALTER TABLE fooev ADD COLUMN j INT

-- sqlfmt-corpus-separator --

ALTER TABLE force_check OWNER TO forcer;

-- sqlfmt-corpus-separator --

ALTER TABLE force_check OWNER TO root;

-- sqlfmt-corpus-separator --

ALTER TABLE force_t OWNER TO table_owner;

-- sqlfmt-corpus-separator --

ALTER TABLE information_schema.tables ADD COLUMN x DECIMAL

-- sqlfmt-corpus-separator --

ALTER TABLE ins OWNER TO ins;

-- sqlfmt-corpus-separator --

ALTER TABLE kv RENAME TO kv

-- sqlfmt-corpus-separator --

ALTER TABLE kv RENAME TO new_kv

-- sqlfmt-corpus-separator --

ALTER TABLE mc OWNER TO mc;

-- sqlfmt-corpus-separator --

ALTER TABLE mno ADD COLUMN p INT

-- sqlfmt-corpus-separator --

ALTER TABLE mqt_doc OWNER TO bob;

-- sqlfmt-corpus-separator --

ALTER TABLE mvx OWNER TO root

-- sqlfmt-corpus-separator --

ALTER TABLE mvx OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER TABLE new_kv RENAME TO new_kv

-- sqlfmt-corpus-separator --

ALTER TABLE new_table ADD COLUMN c timetz(4)

-- sqlfmt-corpus-separator --

ALTER TABLE other_db.xyz ADD COLUMN j INT

-- sqlfmt-corpus-separator --

ALTER TABLE othertable ADD COLUMN b INT;

-- sqlfmt-corpus-separator --

ALTER TABLE owner_grant_option OWNER TO other_owner

-- sqlfmt-corpus-separator --

ALTER TABLE parent OWNER TO fk_user;

-- sqlfmt-corpus-separator --

ALTER TABLE pg_catalog.pg_tables ADD COLUMN x DECIMAL

-- sqlfmt-corpus-separator --

ALTER TABLE regression_48233 RENAME TO reg_48233

-- sqlfmt-corpus-separator --

ALTER TABLE renamed_public_table RENAME TO public_table_exists;

-- sqlfmt-corpus-separator --

ALTER TABLE rgb_only OWNER TO rgb_only_user;

-- sqlfmt-corpus-separator --

ALTER TABLE s.t OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER TABLE s.t OWNER TO testuser;
ALTER TABLE t OWNER TO root;
ALTER TABLE s.t OWNER TO root

-- sqlfmt-corpus-separator --

ALTER TABLE sch.table_to_rename RENAME TO renamed_table;

-- sqlfmt-corpus-separator --

ALTER TABLE second_db.pg_temp.a OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER TABLE secret_data OWNER TO testuser;

-- sqlfmt-corpus-separator --

ALTER TABLE seq OWNER TO root

-- sqlfmt-corpus-separator --

ALTER TABLE sharded_secondary ADD COLUMN b INT

-- sqlfmt-corpus-separator --

ALTER TABLE shop RENAME TO ship

-- sqlfmt-corpus-separator --

ALTER TABLE smtng.something ADD COLUMN IF NOT EXISTS MODEL_ID INT

-- sqlfmt-corpus-separator --

ALTER TABLE smtng.something ADD COLUMN IF NOT EXISTS NAME STRING

-- sqlfmt-corpus-separator --

ALTER TABLE smtng.something ADD COLUMN IF NOT EXISTS OWNER_ID INT

-- sqlfmt-corpus-separator --

ALTER TABLE stmt_ctrl ADD COLUMN fallback_works BOOL

-- sqlfmt-corpus-separator --

ALTER TABLE stmt_ctrl_sub ADD COLUMN another_to_drop BOOL

-- sqlfmt-corpus-separator --

ALTER TABLE stmt_ctrl_sub ADD COLUMN to_drop BOOL

-- sqlfmt-corpus-separator --

ALTER TABLE supermarket ADD COLUMN age INT

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN c INT

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN crdb_internal_idx_expr INT

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN crdb_internal_idx_expr_2 INT

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN crdb_internal_mvcc_timestamp INT

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN e INT

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN e INT; ALTER TABLE t ADD COLUMN d INT

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN e string;

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN f INT

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN g INT

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN x DECIMAL

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN y INT

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN y INT;

-- sqlfmt-corpus-separator --

ALTER TABLE t ADD COLUMN z INT

-- sqlfmt-corpus-separator --

ALTER TABLE t OWNER TO fake_user

-- sqlfmt-corpus-separator --

ALTER TABLE t OWNER TO old_role

-- sqlfmt-corpus-separator --

ALTER TABLE t OWNER TO root

-- sqlfmt-corpus-separator --

ALTER TABLE t OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER TABLE t OWNER TO testuser2

-- sqlfmt-corpus-separator --

ALTER TABLE t OWNER TO testuser;

-- sqlfmt-corpus-separator --

ALTER TABLE t RENAME TO new_kv

-- sqlfmt-corpus-separator --

ALTER TABLE t RENAME TO r

-- sqlfmt-corpus-separator --

ALTER TABLE t RENAME TO t2;

-- sqlfmt-corpus-separator --

ALTER TABLE t RENAME TO t_renamed

-- sqlfmt-corpus-separator --

ALTER TABLE t RENAME to t2

-- sqlfmt-corpus-separator --

ALTER TABLE t1 ADD COLUMN a STRING

-- sqlfmt-corpus-separator --

ALTER TABLE t1 ADD COLUMN x STRING;

-- sqlfmt-corpus-separator --

ALTER TABLE t1 ADD COLUMN x t[]

-- sqlfmt-corpus-separator --

ALTER TABLE t1 ADD COLUMN y t

-- sqlfmt-corpus-separator --

ALTER TABLE t158154 OWNER TO user_158154;

-- sqlfmt-corpus-separator --

ALTER TABLE t1_add ADD COLUMN c1 BIGINT;

-- sqlfmt-corpus-separator --

ALTER TABLE t2 RENAME to t

-- sqlfmt-corpus-separator --

ALTER TABLE t4 ADD COLUMN j typ4

-- sqlfmt-corpus-separator --

ALTER TABLE t6 RENAME TO t7

-- sqlfmt-corpus-separator --

ALTER TABLE t61762 ADD COLUMN v INT2VECTOR

-- sqlfmt-corpus-separator --

ALTER TABLE t61762 ADD COLUMN v OIDVECTOR

-- sqlfmt-corpus-separator --

ALTER TABLE t8 ADD COLUMN y typ8

-- sqlfmt-corpus-separator --

ALTER TABLE t97551 ADD COLUMN e enum97551;

-- sqlfmt-corpus-separator --

ALTER TABLE t_96727_2 ADD COLUMN j INT;

-- sqlfmt-corpus-separator --

ALTER TABLE t_alter ADD COLUMN c INT;

-- sqlfmt-corpus-separator --

ALTER TABLE t_alter ADD COLUMN d INT;

-- sqlfmt-corpus-separator --

ALTER TABLE t_auto_unlock ADD COLUMN k INT

-- sqlfmt-corpus-separator --

ALTER TABLE t_auto_unlock ADD COLUMN l INT

-- sqlfmt-corpus-separator --

ALTER TABLE t_conditional_bump_udt_version ADD COLUMN e1_col e1;

-- sqlfmt-corpus-separator --

ALTER TABLE t_conditional_bump_udt_version ADD COLUMN i_col INT;

-- sqlfmt-corpus-separator --

ALTER TABLE t_schema ADD COLUMN path LTREE

-- sqlfmt-corpus-separator --

ALTER TABLE t_ttl_w_expire_at ADD COLUMN new_expire_at TIMESTAMPTZ;

-- sqlfmt-corpus-separator --

ALTER TABLE t_twocol RENAME TO t_twocol_prime;

-- sqlfmt-corpus-separator --

ALTER TABLE tab2 ADD COLUMN j INT

-- sqlfmt-corpus-separator --

ALTER TABLE table_owner_test OWNER TO tab_owner;

-- sqlfmt-corpus-separator --

ALTER TABLE target OWNER TO john;

-- sqlfmt-corpus-separator --

ALTER TABLE tbl2 ADD COLUMN b typ

-- sqlfmt-corpus-separator --

ALTER TABLE tbl_rename RENAME TO tbl_renamed

-- sqlfmt-corpus-separator --

ALTER TABLE tbl_rename_legacy_label RENAME TO tbl_renamed2

-- sqlfmt-corpus-separator --

ALTER TABLE test.t RENAME TO t2

-- sqlfmt-corpus-separator --

ALTER TABLE test_serial ADD COLUMN b SERIAL;

-- sqlfmt-corpus-separator --

ALTER TABLE testowner_table OWNER TO testowner

-- sqlfmt-corpus-separator --

ALTER TABLE to_drop ADD COLUMN foo int;

-- sqlfmt-corpus-separator --

ALTER TABLE toberenamed RENAME TO renamedtable;

-- sqlfmt-corpus-separator --

ALTER TABLE torename RENAME TO t

-- sqlfmt-corpus-separator --

ALTER TABLE uniq OWNER TO uniq_user;

-- sqlfmt-corpus-separator --

ALTER TABLE ups OWNER TO ups;

-- sqlfmt-corpus-separator --

ALTER TABLE v RENAME TO new_v

-- sqlfmt-corpus-separator --

ALTER TABLE v2 RENAME to v

-- sqlfmt-corpus-separator --

ALTER TABLE vals ADD COLUMN y int;

-- sqlfmt-corpus-separator --

ALTER TABLE vx OWNER TO root

-- sqlfmt-corpus-separator --

ALTER TABLE want RENAME TO forlater

-- sqlfmt-corpus-separator --

ALTER TABLE xy ADD COLUMN curs REFCURSOR;

-- sqlfmt-corpus-separator --

ALTER TABLE xy ADD COLUMN y INT;

-- sqlfmt-corpus-separator --

ALTER TABLE xy ADD COLUMN z INT;

-- sqlfmt-corpus-separator --

ALTER TYPE db1.sc1.typ OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER TYPE owner_grant_option OWNER TO other_owner

-- sqlfmt-corpus-separator --

ALTER TYPE s.typ OWNER TO fake_user

-- sqlfmt-corpus-separator --

ALTER TYPE s.typ OWNER TO root

-- sqlfmt-corpus-separator --

ALTER TYPE s.typ OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER TYPE s.typ OWNER TO testuser2

-- sqlfmt-corpus-separator --

ALTER TYPE s2.typ OWNER TO root

-- sqlfmt-corpus-separator --

ALTER USER CURRENT_USER PASSWORD '123'

-- sqlfmt-corpus-separator --

ALTER USER foo WITH PASSWORD 'somepass'

-- sqlfmt-corpus-separator --

ALTER USER hash8 WITH PASSWORD 'hai'

-- sqlfmt-corpus-separator --

ALTER USER hash8 WITH PASSWORD 'hello universe'

-- sqlfmt-corpus-separator --

ALTER USER testuser CREATEDB

-- sqlfmt-corpus-separator --

ALTER USER testuser CREATEDB;

-- sqlfmt-corpus-separator --

ALTER USER testuser CREATEROLE

-- sqlfmt-corpus-separator --

ALTER USER testuser CREATEROLE;
  DROP USER testuser2;
  DROP USER testuser3;

-- sqlfmt-corpus-separator --

ALTER USER testuser NOCREATEDB

-- sqlfmt-corpus-separator --

ALTER USER testuser NOCREATEROLE

-- sqlfmt-corpus-separator --

ALTER USER testuser PASSWORD 'cat'

-- sqlfmt-corpus-separator --

ALTER USER testuser PASSWORD 'xyz'

-- sqlfmt-corpus-separator --

ALTER USER testuser PASSWORD NULL

-- sqlfmt-corpus-separator --

ALTER USER testuser WITH NOCREATEROLE

-- sqlfmt-corpus-separator --

ALTER USER testuser WITH PASSWORD 'abc'

-- sqlfmt-corpus-separator --

ALTER USER testuser WITH createdb

-- sqlfmt-corpus-separator --

ALTER USER testuser2 LOGIN

-- sqlfmt-corpus-separator --

ALTER USER testuser2 NOLOGIN

-- sqlfmt-corpus-separator --

ALTER USER testuser2 WITH CREATEDB

-- sqlfmt-corpus-separator --

ALTER USER testuser2 WITH PASSWORD 'abc'

-- sqlfmt-corpus-separator --

ALTER USER testuser3 LOGIN

-- sqlfmt-corpus-separator --

ALTER USER testuser3 NOLOGIN

-- sqlfmt-corpus-separator --

ALTER USER testuser3 WITH PASSWORD 'ilov3beefjerky'

-- sqlfmt-corpus-separator --

ALTER USER testuser3 WITH PASSWORD 'xyz'

-- sqlfmt-corpus-separator --

ALTER USER userlongpassword WITH PASSWORD '987654321021'

-- sqlfmt-corpus-separator --

ALTER VIEW IF EXISTS does_not_exist OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER VIEW IF EXISTS foo RENAME TO bar

-- sqlfmt-corpus-separator --

ALTER VIEW foo RENAME TO bar

-- sqlfmt-corpus-separator --

ALTER VIEW kv RENAME TO new_kv

-- sqlfmt-corpus-separator --

ALTER VIEW materialized_view RENAME TO newname

-- sqlfmt-corpus-separator --

ALTER VIEW mvx OWNER TO testuser;

-- sqlfmt-corpus-separator --

ALTER VIEW new_v RENAME TO new_v

-- sqlfmt-corpus-separator --

ALTER VIEW otherview RENAME TO otherview2

-- sqlfmt-corpus-separator --

ALTER VIEW s.vx OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER VIEW seq OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER VIEW test.v RENAME TO v2

-- sqlfmt-corpus-separator --

ALTER VIEW test.v2 RENAME TO v4

-- sqlfmt-corpus-separator --

ALTER VIEW test.v2 RENAME TO v5

-- sqlfmt-corpus-separator --

ALTER VIEW v RENAME TO new_v

-- sqlfmt-corpus-separator --

ALTER VIEW v RENAME to v2

-- sqlfmt-corpus-separator --

ALTER VIEW v3 RENAME TO v4

-- sqlfmt-corpus-separator --

ALTER VIEW vx OWNER TO fake_user

-- sqlfmt-corpus-separator --

ALTER VIEW vx OWNER TO testuser

-- sqlfmt-corpus-separator --

ALTER VIEW vx OWNER TO testuser2

-- sqlfmt-corpus-separator --

ALTER VIEW vx OWNER TO testuser;
ALTER MATERIALIZED VIEW mvx OWNER TO testuser;
ALTER VIEW s.vx OWNER TO testuser;
ALTER VIEW vx OWNER TO root;
ALTER MATERIALIZED VIEW mvx OWNER TO root;
ALTER VIEW s.vx OWNER TO root;

-- sqlfmt-corpus-separator --

ALTER table tt ADD COLUMN r DECIMAL

-- sqlfmt-corpus-separator --

BEGIN

-- sqlfmt-corpus-separator --

BEGIN ISOLATION LEVEL READ COMMITTED

-- sqlfmt-corpus-separator --

BEGIN ISOLATION LEVEL READ COMMITTED;

-- sqlfmt-corpus-separator --

BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT * FROM abc;
COMMIT;

-- sqlfmt-corpus-separator --

BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT * FROM bcd;
COMMIT;

-- sqlfmt-corpus-separator --

BEGIN ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

BEGIN ISOLATION LEVEL SERIALIZABLE, ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

BEGIN READ ONLY

-- sqlfmt-corpus-separator --

BEGIN READ WRITE

-- sqlfmt-corpus-separator --

BEGIN READ WRITE, READ ONLY

-- sqlfmt-corpus-separator --

BEGIN READ WRITE; COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
ALTER TABLE single_stmt_explicit ADD COLUMN b TEXT;
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
CREATE DATABASE foo;
CREATE TABLE t (a INT);

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
CREATE TABLE single_stmt_explicit (a INT PRIMARY KEY);
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT 1;
ALTER SCHEMA s RENAME TO foo;

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT 1;
ALTER TABLE supermarket ADD COLUMN age INT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT 1;
CREATE INDEX foo ON supermarket(ends_with, starts_with)

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT 1;
CREATE TABLE foo(a INT)

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT 1;
DROP TABLE supermarket

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT 1;
DROP USER testuser

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT 1;
GRANT SELECT ON supermarket TO testuser

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT 1;
GRANT USAGE ON SCHEMA public TO testuser

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT 1;
GRANT USAGE ON TYPE typ TO testuser

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT 1;
GRANT admin TO testuser

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ; COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE READ WRITE;

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
ALTER SCHEMA sc RENAME TO sc_old;
ALTER SCHEMA sc_new RENAME TO sc

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
ALTER SCHEMA sc RENAME TO sc_old;
ALTER SCHEMA sc_new RENAME TO sc;
CREATE VIEW sc.v AS SELECT 1;
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
ALTER SCHEMA sc RENAME TO sc_old;
CREATE SCHEMA sc;
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
ALTER VIEW v RENAME TO v_old;
ALTER VIEW v_new RENAME TO v

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
ALTER VIEW v RENAME TO v_old;
CREATE VIEW v AS SELECT 1;
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
CREATE SCHEMA sc;
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
CREATE TABLE src(x VARCHAR PRIMARY KEY);
CREATE TABLE dst(x VARCHAR REFERENCES src(x));
INSERT INTO src(x) VALUES ('example');
INSERT INTO dst(x) VALUES ('example');
COMMIT;

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
DECLARE dup CURSOR FOR SELECT 0;

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
DROP DATABASE db;
CREATE DATABASE db;
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
DROP SCHEMA sc CASCADE;
ALTER SCHEMA sc_old RENAME TO sc;
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
DROP SCHEMA sc;
CREATE SCHEMA sc;
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
DROP TYPE t;

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
DROP VIEW v;
ALTER VIEW v_old RENAME TO v

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
DROP VIEW v;
CREATE VIEW v AS SELECT 1;
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
INSERT INTO kv (k,v) VALUES (1, cluster_logical_timestamp());
SELECT * FROM kv

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES (3, cluster_logical_timestamp());
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT cluster_logical_timestamp();

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET LOCAL autocommit_before_ddl = false;

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET LOCAL autocommit_before_ddl = false;
CREATE TABLE enum_checks (x greeting);
INSERT INTO enum_checks VALUES ('hi'), ('howdy');

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET LOCAL autocommit_before_ddl = false;
CREATE TABLE sc (x greeting NOT NULL, y int NOT NULL);
INSERT INTO sc VALUES ('hello', 0), ('howdy', 1), ('hi', 2);
CREATE INDEX i1 ON sc (x);
CREATE INDEX i2 ON sc (y);
CREATE INDEX i3 ON sc (x, y)

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET LOCAL autocommit_before_ddl = false;
CREATE TABLE t45985 (a INT);
ALTER TABLE t45985 ADD COLUMN b INT;
COMMIT;

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET LOCAL autocommit_before_ddl=off;
ALTER TABLE t35611 ADD COLUMN b INT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET LOCAL autocommit_before_ddl=off;
CREATE INDEX t_a_times_three_idx ON t ((a * 3));
SELECT crdb_internal.force_retry('10ms');
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET LOCAL autocommit_before_ddl=off;
CREATE TEMP TABLE tbl (a int primary key);
INSERT INTO tbl VALUES (1);
SELECT crdb_internal.force_retry('1s');
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET default_int_size = 4;
CREATE TABLE t44904(c0 INT);
INSERT INTO t44904 VALUES(0);
COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET default_int_size=4;
CREATE TABLE late4 (a INT);
COMMIT;

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SHOW TABLES FROM sc93002;
CREATE TABLE sc93002.t(a INT);
DROP SCHEMA sc93002 CASCADE;
COMMIT;

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE; COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION;

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION; SELECT * FROM system.t; INSERT INTO t(a) VALUES (1)

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION; SELECT 1; COMMIT TRANSACTION

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION; SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION; SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; COMMIT

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION; UPDATE kv SET v = 'b' WHERE k in ('a')

-- sqlfmt-corpus-separator --

BEGIN;

-- sqlfmt-corpus-separator --

BEGIN;
  SELECT nextval('sv'); -- acquire the lease, so that doesn't go to the KV trace
  SET tracing = on; SELECT nextval('sv'); SET tracing = off;
  COMMIT

-- sqlfmt-corpus-separator --

BEGIN;
CLOSE foo

-- sqlfmt-corpus-separator --

BEGIN;
CREATE TABLE table_a (a int); CREATE TEMP TABLE table_a (a int);
INSERT INTO table_a VALUES (1); INSERT INTO pg_temp.table_a VALUES (2); INSERT INTO public.table_a VALUES (3);
COMMIT

-- sqlfmt-corpus-separator --

BEGIN;
DECLARE "<unnamed portal 3>" CURSOR FOR SELECT 1;

-- sqlfmt-corpus-separator --

BEGIN;
DECLARE foo CURSOR FOR SELECT * FROM a ORDER BY a

-- sqlfmt-corpus-separator --

BEGIN;
DECLARE foo CURSOR FOR SELECT * FROM xy ORDER BY x DESC;

-- sqlfmt-corpus-separator --

BEGIN;
DECLARE foo CURSOR FOR SELECT * FROM xy ORDER BY x;

-- sqlfmt-corpus-separator --

BEGIN;
DECLARE foo CURSOR FOR SELECT generate_series(1, 5);

-- sqlfmt-corpus-separator --

BEGIN;
DROP SCHEMA sc1 CASCADE;
ROLLBACK;

-- sqlfmt-corpus-separator --

BEGIN;
DROP TABLE tt;
DROP TYPE t;
COMMIT

-- sqlfmt-corpus-separator --

BEGIN;
INSERT INTO big VALUES(100,'blargh');
DECLARE foo CURSOR FOR SELECT * FROM big ORDER BY a;
INSERT INTO big VALUES(101,'argh')

-- sqlfmt-corpus-separator --

BEGIN;
INSERT INTO kv (k,v) VALUES ('a', transaction_timestamp());
SELECT * FROM kv

-- sqlfmt-corpus-separator --

BEGIN;
INSERT INTO kv (k,v) VALUES ('b', transaction_timestamp());
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES ('c', transaction_timestamp());
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES ('d', current_timestamp());
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES ('e', current_timestamp());
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES ('f', now());
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES ('g', now());
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES ('h', statement_timestamp());
SELECT * FROM kv;
COMMIT;
SELECT * FROM kv;
BEGIN;
SELECT * FROM KV;
INSERT INTO kv (k,v) VALUES ('i', transaction_timestamp());
COMMIT

-- sqlfmt-corpus-separator --

BEGIN;
INSERT INTO prep_stmts SELECT 1, name FROM pg_catalog.pg_prepared_statements;
PREPARE pscs18 AS SELECT $1::inet, 18;
EXECUTE pscs11(11);
PREPARE pscs19 AS SELECT $1::string, 19;
INSERT INTO prep_stmts SELECT 2, name FROM pg_catalog.pg_prepared_statements;
SELECT IF(nextval('s') <= 3, crdb_internal.force_retry('1 hour'), 0);
COMMIT

-- sqlfmt-corpus-separator --

BEGIN;
INSERT INTO rewind_session_test VALUES ('1 day 01:02:03'::interval::string);
SET LOCAL intervalstyle = 'iso_8601';
INSERT INTO rewind_session_test VALUES ('1 day 01:02:04'::interval::string);
SELECT crdb_internal.force_retry('10ms');
COMMIT

-- sqlfmt-corpus-separator --

BEGIN;
INSERT INTO rewind_session_test VALUES ('1 day 01:02:03'::interval::string);
SET intervalstyle = 'iso_8601';
INSERT INTO rewind_session_test VALUES ('1 day 01:02:04'::interval::string);
SELECT crdb_internal.force_retry('10ms');
COMMIT

-- sqlfmt-corpus-separator --

BEGIN;
INSERT INTO uvw SELECT u, v, w FROM
  generate_series(0, 3) AS u,
  generate_series(0, 3) AS v,
  generate_series(0, 3) AS w;

-- sqlfmt-corpus-separator --

BEGIN;
INSERT INTO uvw SELECT u, v, w FROM
  generate_series(0, 3) AS u,
  generate_series(0, 3) AS v,
  generate_series(0, 3) AS w;
UPDATE uvw SET u = NULL WHERE u = 0;
UPDATE uvw SET v = NULL WHERE v = 0;
UPDATE uvw SET w = NULL WHERE w = 0

-- sqlfmt-corpus-separator --

BEGIN;
SELECT * FROM KV;
INSERT INTO kv (k,v) VALUES ('c', transaction_timestamp());
COMMIT

-- sqlfmt-corpus-separator --

BEGIN;
SELECT 1;

-- sqlfmt-corpus-separator --

BEGIN;
SELECT crdb_internal.show_create_all_tables('test_schema');

-- sqlfmt-corpus-separator --

BEGIN;
SELECT f(0);

-- sqlfmt-corpus-separator --

BEGIN;
SELECT f(0, 0);

-- sqlfmt-corpus-separator --

BEGIN;
SELECT f(0, 3);

-- sqlfmt-corpus-separator --

BEGIN;
SELECT x, z FROM test;
SELECT x FROM test where y=1;
COMMIT;

-- sqlfmt-corpus-separator --

BEGIN;
SET LOCAL IntervalStyle = 'sql_standard'

-- sqlfmt-corpus-separator --

BEGIN;
SET LOCAL TIME ZONE 'America/Los_Angeles';
SET IntervalStyle = 'iso_8601'

-- sqlfmt-corpus-separator --

BEGIN;
SET LOCAL TIME ZONE -10

-- sqlfmt-corpus-separator --

BEGIN;
SET LOCAL application_name = 'my name is sasha fierce'

-- sqlfmt-corpus-separator --

BEGIN;
SET LOCAL database = 'alt_db'

-- sqlfmt-corpus-separator --

BEGIN;
SET enable_shared_locking_for_serializable = true

-- sqlfmt-corpus-separator --

BEGIN;
declare a cursor for select * from crdb_internal.gossip_network;
FETCH 1 FROM a;
COMMIT

-- sqlfmt-corpus-separator --

BEGIN; COMMIT

-- sqlfmt-corpus-separator --

BEGIN; CREATE DATABASE IF NOT EXISTS d2

-- sqlfmt-corpus-separator --

BEGIN; CREATE DATABASE IF NOT EXISTS d2; COMMIT

-- sqlfmt-corpus-separator --

BEGIN; DECLARE bar CURSOR FOR SELECT 1,2,3

-- sqlfmt-corpus-separator --

BEGIN; DECLARE foo CURSOR FOR SELECT * FROM a ORDER BY a;

-- sqlfmt-corpus-separator --

BEGIN; SELECT * FROM system.namespace LIMIT 1;

-- sqlfmt-corpus-separator --

BEGIN; SELECT * FROM t

-- sqlfmt-corpus-separator --

BEGIN; SELECT * FROM t; COMMIT

-- sqlfmt-corpus-separator --

BEGIN; SELECT * FROM t_53504; COMMIT;

-- sqlfmt-corpus-separator --

BEGIN; SELECT * FROM t_53504; SELECT * FROM t_53504; COMMIT;

-- sqlfmt-corpus-separator --

BEGIN; SELECT * FROM t_53504; SELECT * FROM t_53504; SELECT * FROM t_53504; COMMIT;

-- sqlfmt-corpus-separator --

BEGIN; SELECT 1

-- sqlfmt-corpus-separator --

BEGIN; SELECT 1/0

-- sqlfmt-corpus-separator --

BEGIN; SELECT 1; SELECT 1, 2; SELECT 1, 2, 3; COMMIT

-- sqlfmt-corpus-separator --

BEGIN; SELECT 1; SELECT 1, 3; SELECT 1, 2, 3, 4; COMMIT

-- sqlfmt-corpus-separator --

BEGIN; SELECT 1; SELECT 1, 3; SELECT 1, 2, 3; COMMIT

-- sqlfmt-corpus-separator --

BEGIN; SELECT count(1) AS wombat1; COMMIT

-- sqlfmt-corpus-separator --

BEGIN; SELECT count(1) AS wombat2; COMMIT

-- sqlfmt-corpus-separator --

BEGIN; SELECT x FROM test where y=1; COMMIT;

-- sqlfmt-corpus-separator --

BEGIN; UPDATE parent_lt SET p = 1 WHERE p = 1

-- sqlfmt-corpus-separator --

BEGIN; UPDATE t SET v = 2 WHERE k = 1

-- sqlfmt-corpus-separator --

BEGIN; UPDATE t SET v = 3 WHERE k = 2; UPDATE t3 SET v = 3 WHERE k = 2

-- sqlfmt-corpus-separator --

CLOSE "<unnamed portal 2>";
CLOSE "<unnamed portal 1>";

-- sqlfmt-corpus-separator --

CLOSE "<unnamed portal 3>";

-- sqlfmt-corpus-separator --

CLOSE "a b";
DECLARE "a\b" CURSOR FOR SELECT 3;

-- sqlfmt-corpus-separator --

CLOSE "a"" b'c";
DECLARE "a b" CURSOR FOR SELECT 2;

-- sqlfmt-corpus-separator --

CLOSE "a\b";

-- sqlfmt-corpus-separator --

CLOSE ALL

-- sqlfmt-corpus-separator --

CLOSE ALL;

-- sqlfmt-corpus-separator --

CLOSE bar

-- sqlfmt-corpus-separator --

CLOSE curs;

-- sqlfmt-corpus-separator --

CLOSE foo

-- sqlfmt-corpus-separator --

CLOSE foo;

-- sqlfmt-corpus-separator --

CLOSE foo;
DECLARE foo CURSOR FOR SELECT * FROM a ORDER BY a

-- sqlfmt-corpus-separator --

COMMIT

-- sqlfmt-corpus-separator --

COMMIT AND CHAIN

-- sqlfmt-corpus-separator --

COMMIT AND NO CHAIN

-- sqlfmt-corpus-separator --

COMMIT TRANSACTION

-- sqlfmt-corpus-separator --

COMMIT WORK AND CHAIN

-- sqlfmt-corpus-separator --

COMMIT;

-- sqlfmt-corpus-separator --

COMMIT;
BEGIN;
DECLARE foo CURSOR FOR SELECT * FROM a ORDER BY a

-- sqlfmt-corpus-separator --

COMMIT;
BEGIN;
SELECT * FROM sc1.t;
SELECT crdb_internal.show_create_all_tables('test_schema');

-- sqlfmt-corpus-separator --

COMMIT;
INSERT INTO a SELECT g,g+1 FROM generate_series(4, 100) g(g);
BEGIN;
DECLARE foo CURSOR FOR SELECT * FROM a ORDER BY a

-- sqlfmt-corpus-separator --

COMMIT;
INSERT INTO kv VALUES('x', 'y')

-- sqlfmt-corpus-separator --

COMMIT; DROP TABLE table_with_not_null_enum; DROP TYPE enum_with_vals;

-- sqlfmt-corpus-separator --

CREATE DATABASE """"

-- sqlfmt-corpus-separator --

CREATE DATABASE """test_escaping""""''b""";

-- sqlfmt-corpus-separator --

CREATE DATABASE "$peci@l";

-- sqlfmt-corpus-separator --

CREATE DATABASE "'db1-a'";

-- sqlfmt-corpus-separator --

CREATE DATABASE "Do you like this for a database name?";
SET database = "Do you like this for a database name?";
CREATE SCHEMA sc;
CREATE TABLE sc.foo (i INT8);
CREATE TABLE foo (i INT8);

-- sqlfmt-corpus-separator --

CREATE DATABASE "E"

-- sqlfmt-corpus-separator --

CREATE DATABASE "MixedCaseDB"

-- sqlfmt-corpus-separator --

CREATE DATABASE "defaults-to-system";

-- sqlfmt-corpus-separator --

CREATE DATABASE "foo bar"

-- sqlfmt-corpus-separator --

CREATE DATABASE "foo-bar"

-- sqlfmt-corpus-separator --

CREATE DATABASE "my database";

-- sqlfmt-corpus-separator --

CREATE DATABASE "non-mr-system-database"

-- sqlfmt-corpus-separator --

CREATE DATABASE "order";
ALTER DATABASE "order" OWNER TO testuser

-- sqlfmt-corpus-separator --

CREATE DATABASE "rEgReSsIoN 105906"

-- sqlfmt-corpus-separator --

CREATE DATABASE "show partitions"

-- sqlfmt-corpus-separator --

CREATE DATABASE "show ranges"

-- sqlfmt-corpus-separator --

CREATE DATABASE "testDatabase"

-- sqlfmt-corpus-separator --

CREATE DATABASE "user content"

-- sqlfmt-corpus-separator --

CREATE DATABASE "with-primary-setting"

-- sqlfmt-corpus-separator --

CREATE DATABASE D

-- sqlfmt-corpus-separator --

CREATE DATABASE IF NOT EXISTS a

-- sqlfmt-corpus-separator --

CREATE DATABASE IF NOT EXISTS d2

-- sqlfmt-corpus-separator --

CREATE DATABASE IF NOT EXISTS db1;

-- sqlfmt-corpus-separator --

CREATE DATABASE IF NOT EXISTS db2;

-- sqlfmt-corpus-separator --

CREATE DATABASE IF NOT EXISTS othereventlogtest

-- sqlfmt-corpus-separator --

CREATE DATABASE IF NOT EXISTS smtng

-- sqlfmt-corpus-separator --

CREATE DATABASE a

-- sqlfmt-corpus-separator --

CREATE DATABASE a; CREATE TABLE a.c(d INT); INSERT INTO a.public.c(d) VALUES (1)

-- sqlfmt-corpus-separator --

CREATE DATABASE alt_db

-- sqlfmt-corpus-separator --

CREATE DATABASE alter_primary_region_db

-- sqlfmt-corpus-separator --

CREATE DATABASE another_db

-- sqlfmt-corpus-separator --

CREATE DATABASE another_db;

-- sqlfmt-corpus-separator --

CREATE DATABASE atest;

-- sqlfmt-corpus-separator --

CREATE DATABASE auth;

-- sqlfmt-corpus-separator --

CREATE DATABASE auth_check_db;

-- sqlfmt-corpus-separator --

CREATE DATABASE b

-- sqlfmt-corpus-separator --

CREATE DATABASE bar

-- sqlfmt-corpus-separator --

CREATE DATABASE base; CREATE TABLE base.t(x NUMERIC); CREATE TABLE base.u(y STRING);
CREATE DATABASE newdb; SET database = newdb

-- sqlfmt-corpus-separator --

CREATE DATABASE c

-- sqlfmt-corpus-separator --

CREATE DATABASE comment_db

-- sqlfmt-corpus-separator --

CREATE DATABASE constraint_column

-- sqlfmt-corpus-separator --

CREATE DATABASE constraint_db

-- sqlfmt-corpus-separator --

CREATE DATABASE create_schemas;

-- sqlfmt-corpus-separator --

CREATE DATABASE d

-- sqlfmt-corpus-separator --

CREATE DATABASE d1

-- sqlfmt-corpus-separator --

CREATE DATABASE d1;
CREATE TABLE d1.t();
CREATE DATABASE d2;

-- sqlfmt-corpus-separator --

CREATE DATABASE d2

-- sqlfmt-corpus-separator --

CREATE DATABASE d3

-- sqlfmt-corpus-separator --

CREATE DATABASE d34856

-- sqlfmt-corpus-separator --

CREATE DATABASE d34862; SET database=d34862

-- sqlfmt-corpus-separator --

CREATE DATABASE d35145

-- sqlfmt-corpus-separator --

CREATE DATABASE d35145; SET database = d35145;

-- sqlfmt-corpus-separator --

CREATE DATABASE d35145_2; SET database = d35145_2; DROP DATABASE d35145_2

-- sqlfmt-corpus-separator --

CREATE DATABASE d4

-- sqlfmt-corpus-separator --

CREATE DATABASE d;

-- sqlfmt-corpus-separator --

CREATE DATABASE d;
ALTER DATABASE d OWNER TO testuser

-- sqlfmt-corpus-separator --

CREATE DATABASE d;
CREATE TABLE d.public.t50069_a (x INT);

-- sqlfmt-corpus-separator --

CREATE DATABASE d;
CREATE TABLE d.t (x int)

-- sqlfmt-corpus-separator --

CREATE DATABASE d;
GRANT CREATE ON DATABASE d TO testuser

-- sqlfmt-corpus-separator --

CREATE DATABASE d;
GRANT CREATE ON DATABASE d TO testuser;

-- sqlfmt-corpus-separator --

CREATE DATABASE d; CREATE TABLE d.kv (k CHAR PRIMARY KEY, v CHAR);

-- sqlfmt-corpus-separator --

CREATE DATABASE d_drop_db_test

-- sqlfmt-corpus-separator --

CREATE DATABASE d_show_partitions

-- sqlfmt-corpus-separator --

CREATE DATABASE database_108751

-- sqlfmt-corpus-separator --

CREATE DATABASE database_142780

-- sqlfmt-corpus-separator --

CREATE DATABASE database_142783

-- sqlfmt-corpus-separator --

CREATE DATABASE database_145438

-- sqlfmt-corpus-separator --

CREATE DATABASE db

-- sqlfmt-corpus-separator --

CREATE DATABASE db1

-- sqlfmt-corpus-separator --

CREATE DATABASE db106602a

-- sqlfmt-corpus-separator --

CREATE DATABASE db106602b

-- sqlfmt-corpus-separator --

CREATE DATABASE db1;

-- sqlfmt-corpus-separator --

CREATE DATABASE db1;
ALTER DATABASE db1 OWNER TO testuser;
CREATE SCHEMA db1.sc1;
ALTER SCHEMA db1.sc1 OWNER TO testuser;
CREATE TABLE db1.sc1.table(n int);
ALTER TABLE db1.sc1.table OWNER TO testuser;

-- sqlfmt-corpus-separator --

CREATE DATABASE db2

-- sqlfmt-corpus-separator --

CREATE DATABASE db2;

-- sqlfmt-corpus-separator --

CREATE DATABASE db2;
CREATE TABLE db2.t (i INT PRIMARY KEY);

-- sqlfmt-corpus-separator --

CREATE DATABASE db2; CREATE TABLE db2.tbl (a int DEFAULT nextval('db1.seq'))

-- sqlfmt-corpus-separator --

CREATE DATABASE db3;

-- sqlfmt-corpus-separator --

CREATE DATABASE db4;

-- sqlfmt-corpus-separator --

CREATE DATABASE db50997

-- sqlfmt-corpus-separator --

CREATE DATABASE db69713;

-- sqlfmt-corpus-separator --

CREATE DATABASE db;

-- sqlfmt-corpus-separator --

CREATE DATABASE db;
CREATE DATABASE db_new

-- sqlfmt-corpus-separator --

CREATE DATABASE db_121808

-- sqlfmt-corpus-separator --

CREATE DATABASE db_50712

-- sqlfmt-corpus-separator --

CREATE DATABASE db_51782

-- sqlfmt-corpus-separator --

CREATE DATABASE db_73323

-- sqlfmt-corpus-separator --

CREATE DATABASE db_87672;

-- sqlfmt-corpus-separator --

CREATE DATABASE db_95364;

-- sqlfmt-corpus-separator --

CREATE DATABASE db_create_db_priv

-- sqlfmt-corpus-separator --

CREATE DATABASE db_enum_name_clash;

-- sqlfmt-corpus-separator --

CREATE DATABASE db_type_test

-- sqlfmt-corpus-separator --

CREATE DATABASE dbt

-- sqlfmt-corpus-separator --

CREATE DATABASE dd; CREATE TABLE dd.kv (k CHAR PRIMARY KEY, v CHAR)

-- sqlfmt-corpus-separator --

CREATE DATABASE defaultdb;

-- sqlfmt-corpus-separator --

CREATE DATABASE deleted_database;

-- sqlfmt-corpus-separator --

CREATE DATABASE dfk; SET database=dfk

-- sqlfmt-corpus-separator --

CREATE DATABASE diff_db

-- sqlfmt-corpus-separator --

CREATE DATABASE drop_me

-- sqlfmt-corpus-separator --

CREATE DATABASE e

-- sqlfmt-corpus-separator --

CREATE DATABASE empty

-- sqlfmt-corpus-separator --

CREATE DATABASE eventlogtest

-- sqlfmt-corpus-separator --

CREATE DATABASE eventlogtorename

-- sqlfmt-corpus-separator --

CREATE DATABASE foo

-- sqlfmt-corpus-separator --

CREATE DATABASE foo; CREATE TABLE foo.bar(x INT);

-- sqlfmt-corpus-separator --

CREATE DATABASE foo; SET database = foo; SELECT typname FROM pg_type WHERE typname = 'date'

-- sqlfmt-corpus-separator --

CREATE DATABASE for_show;

-- sqlfmt-corpus-separator --

CREATE DATABASE gc_ttl_predefined_db

-- sqlfmt-corpus-separator --

CREATE DATABASE information_schema

-- sqlfmt-corpus-separator --

CREATE DATABASE initial_multiregion_db;

-- sqlfmt-corpus-separator --

CREATE DATABASE namespace_test;
CREATE DATABASE namespace_test2;

-- sqlfmt-corpus-separator --

CREATE DATABASE new_db

-- sqlfmt-corpus-separator --

CREATE DATABASE newdb

-- sqlfmt-corpus-separator --

CREATE DATABASE newdb2; SET database = newdb2

-- sqlfmt-corpus-separator --

CREATE DATABASE newdb;

-- sqlfmt-corpus-separator --

CREATE DATABASE no_region_placement

-- sqlfmt-corpus-separator --

CREATE DATABASE non_mr;

-- sqlfmt-corpus-separator --

CREATE DATABASE non_mr_backup;

-- sqlfmt-corpus-separator --

CREATE DATABASE non_multi_region_db

-- sqlfmt-corpus-separator --

CREATE DATABASE non_multiregion_test_db;

-- sqlfmt-corpus-separator --

CREATE DATABASE not_multi_region;

-- sqlfmt-corpus-separator --

CREATE DATABASE olddb

-- sqlfmt-corpus-separator --

CREATE DATABASE other;
SET DATABASE = 'other'

-- sqlfmt-corpus-separator --

CREATE DATABASE other_db

-- sqlfmt-corpus-separator --

CREATE DATABASE other_db; SET DATABASE = other_db

-- sqlfmt-corpus-separator --

CREATE DATABASE otherdb

-- sqlfmt-corpus-separator --

CREATE DATABASE otherdb;
CREATE SCHEMA otherdb.privs;
CREATE DATABASE otherdb2;
CREATE SCHEMA otherdb2.privs;

-- sqlfmt-corpus-separator --

CREATE DATABASE owner_grant_option

-- sqlfmt-corpus-separator --

CREATE DATABASE partitioning

-- sqlfmt-corpus-separator --

CREATE DATABASE perms

-- sqlfmt-corpus-separator --

CREATE DATABASE pg_catalog

-- sqlfmt-corpus-separator --

CREATE DATABASE postgres

-- sqlfmt-corpus-separator --

CREATE DATABASE privs

-- sqlfmt-corpus-separator --

CREATE DATABASE public; CREATE TABLE public.public.t(a INT)

-- sqlfmt-corpus-separator --

CREATE DATABASE publicdb

-- sqlfmt-corpus-separator --

CREATE DATABASE regression_105906

-- sqlfmt-corpus-separator --

CREATE DATABASE relkinds

-- sqlfmt-corpus-separator --

CREATE DATABASE rename_db1;
SET DATABASE = rename_db1;

-- sqlfmt-corpus-separator --

CREATE DATABASE rename_sc1;
SET DATABASE = rename_sc1;

-- sqlfmt-corpus-separator --

CREATE DATABASE roachdb

-- sqlfmt-corpus-separator --

CREATE DATABASE rootonly;
CREATE TABLE rootonly.foo(x int);
CREATE TABLE rootonly.bar(x int)

-- sqlfmt-corpus-separator --

CREATE DATABASE rowtest

-- sqlfmt-corpus-separator --

CREATE DATABASE samename

-- sqlfmt-corpus-separator --

CREATE DATABASE scdrop4_db;

-- sqlfmt-corpus-separator --

CREATE DATABASE scdrop6_db;

-- sqlfmt-corpus-separator --

CREATE DATABASE second_db

-- sqlfmt-corpus-separator --

CREATE DATABASE seq

-- sqlfmt-corpus-separator --

CREATE DATABASE sequence_test

-- sqlfmt-corpus-separator --

CREATE DATABASE should_have_create

-- sqlfmt-corpus-separator --

CREATE DATABASE should_not_have_create

-- sqlfmt-corpus-separator --

CREATE DATABASE showdbindexestest;

-- sqlfmt-corpus-separator --

CREATE DATABASE sidb;

-- sqlfmt-corpus-separator --

CREATE DATABASE single_region

-- sqlfmt-corpus-separator --

CREATE DATABASE smtng

-- sqlfmt-corpus-separator --

CREATE DATABASE start_off_non_multi_region;

-- sqlfmt-corpus-separator --

CREATE DATABASE t

-- sqlfmt-corpus-separator --

CREATE DATABASE t1

-- sqlfmt-corpus-separator --

CREATE DATABASE t2

-- sqlfmt-corpus-separator --

CREATE DATABASE tdb_seq_select;
SET DATABASE = tdb_seq_select;

-- sqlfmt-corpus-separator --

CREATE DATABASE temp_priv_db

-- sqlfmt-corpus-separator --

CREATE DATABASE temp_test

-- sqlfmt-corpus-separator --

CREATE DATABASE test2

-- sqlfmt-corpus-separator --

CREATE DATABASE test_cycle;

-- sqlfmt-corpus-separator --

CREATE DATABASE test_db

-- sqlfmt-corpus-separator --

CREATE DATABASE test_db2

-- sqlfmt-corpus-separator --

CREATE DATABASE test_escaping;

-- sqlfmt-corpus-separator --

CREATE DATABASE test_identity

-- sqlfmt-corpus-separator --

CREATE DATABASE test_local_db

-- sqlfmt-corpus-separator --

CREATE DATABASE test_primary_key;

-- sqlfmt-corpus-separator --

CREATE DATABASE testdb; CREATE TABLE testdb.foo(x INT)

-- sqlfmt-corpus-separator --

CREATE DATABASE testuserdb

-- sqlfmt-corpus-separator --

CREATE DATABASE thirddb

-- sqlfmt-corpus-separator --

CREATE DATABASE tmpdb

-- sqlfmt-corpus-separator --

CREATE DATABASE to_drop

-- sqlfmt-corpus-separator --

CREATE DATABASE to_drop;
ALTER DATABASE to_drop OWNER TO testuser;

-- sqlfmt-corpus-separator --

CREATE DATABASE view_test

-- sqlfmt-corpus-separator --

CREATE INDEX cc_udf_idx ON cc_udf_t (cc_udf_const());

-- sqlfmt-corpus-separator --

CREATE INDEX err ON t ((a + random()::INT))

-- sqlfmt-corpus-separator --

CREATE INDEX t_idx ON test_tbl_t((2 + test_tbl_f()));

-- sqlfmt-corpus-separator --

CREATE INDEX t_idx3 ON test_tbl_t((b + test_tbl_f()));

-- sqlfmt-corpus-separator --

CREATE INDEX t_idx4 ON test_tbl_t(test_tbl_f(), b, (test_tbl_f() + 1));

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv AS SELECT x, y, f_scalar() FROM f_setof();

-- sqlfmt-corpus-separator --

CREATE ROLE "none"

-- sqlfmt-corpus-separator --

CREATE ROLE CURRENT_USER

-- sqlfmt-corpus-separator --

CREATE ROLE SESSION_USER

-- sqlfmt-corpus-separator --

CREATE ROLE a;
CREATE ROLE b;
GRANT a, b TO testuser;
ALTER DATABASE d OWNER TO a

-- sqlfmt-corpus-separator --

CREATE ROLE admin

-- sqlfmt-corpus-separator --

CREATE ROLE alice LOGIN;

-- sqlfmt-corpus-separator --

CREATE ROLE alice;

-- sqlfmt-corpus-separator --

CREATE ROLE alter_policy_role;

-- sqlfmt-corpus-separator --

CREATE ROLE anotherrolewithcreate CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE auth_check_role;

-- sqlfmt-corpus-separator --

CREATE ROLE aux1;

-- sqlfmt-corpus-separator --

CREATE ROLE bob LOGIN;

-- sqlfmt-corpus-separator --

CREATE ROLE bob;

-- sqlfmt-corpus-separator --

CREATE ROLE can_bypassrls_global;

-- sqlfmt-corpus-separator --

CREATE ROLE can_createdb WITH CREATEDB;

-- sqlfmt-corpus-separator --

CREATE ROLE can_createdb_global;

-- sqlfmt-corpus-separator --

CREATE ROLE can_createrole WITH CREATEROLE;

-- sqlfmt-corpus-separator --

CREATE ROLE can_createrole_global;

-- sqlfmt-corpus-separator --

CREATE ROLE cannot_bypassrls;

-- sqlfmt-corpus-separator --

CREATE ROLE cannot_createdb;

-- sqlfmt-corpus-separator --

CREATE ROLE cannot_createrole;

-- sqlfmt-corpus-separator --

CREATE ROLE child

-- sqlfmt-corpus-separator --

CREATE ROLE child_role

-- sqlfmt-corpus-separator --

CREATE ROLE child_role;

-- sqlfmt-corpus-separator --

CREATE ROLE crdb_internal_otan

-- sqlfmt-corpus-separator --

CREATE ROLE creator_of_databases

-- sqlfmt-corpus-separator --

CREATE ROLE creator_of_logins

-- sqlfmt-corpus-separator --

CREATE ROLE db_owner_role;

-- sqlfmt-corpus-separator --

CREATE ROLE foo☂

-- sqlfmt-corpus-separator --

CREATE ROLE granter

-- sqlfmt-corpus-separator --

CREATE ROLE greeter

-- sqlfmt-corpus-separator --

CREATE ROLE invalidate;

-- sqlfmt-corpus-separator --

CREATE ROLE invoker_user;

-- sqlfmt-corpus-separator --

CREATE ROLE jobcontroller

-- sqlfmt-corpus-separator --

CREATE ROLE jobviewer

-- sqlfmt-corpus-separator --

CREATE ROLE mc;

-- sqlfmt-corpus-separator --

CREATE ROLE meeter

-- sqlfmt-corpus-separator --

CREATE ROLE mix_u

-- sqlfmt-corpus-separator --

CREATE ROLE mv_alice LOGIN;

-- sqlfmt-corpus-separator --

CREATE ROLE mv_bob LOGIN;

-- sqlfmt-corpus-separator --

CREATE ROLE mv_forcedowner LOGIN;

-- sqlfmt-corpus-separator --

CREATE ROLE mv_forcehelper LOGIN;

-- sqlfmt-corpus-separator --

CREATE ROLE mv_helper LOGIN;

-- sqlfmt-corpus-separator --

CREATE ROLE mv_tblowner LOGIN;

-- sqlfmt-corpus-separator --

CREATE ROLE my_role;

-- sqlfmt-corpus-separator --

CREATE ROLE my_user

-- sqlfmt-corpus-separator --

CREATE ROLE myrole

-- sqlfmt-corpus-separator --

CREATE ROLE new_role

-- sqlfmt-corpus-separator --

CREATE ROLE new_role;

-- sqlfmt-corpus-separator --

CREATE ROLE newgroup

-- sqlfmt-corpus-separator --

CREATE ROLE newrole LOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE node

-- sqlfmt-corpus-separator --

CREATE ROLE old_role;

-- sqlfmt-corpus-separator --

CREATE ROLE other_admin;
GRANT admin TO other_admin;
ALTER ROLE other_admin CREATEDB

-- sqlfmt-corpus-separator --

CREATE ROLE other_admin;
GRANT admin TO other_admin;
ALTER ROLE other_admin SET application_name = 'g';
ALTER ROLE other_admin RESET application_name

-- sqlfmt-corpus-separator --

CREATE ROLE other_owner

-- sqlfmt-corpus-separator --

CREATE ROLE otherrole

-- sqlfmt-corpus-separator --

CREATE ROLE otherrole2 LOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE otherrole4 LOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE owner1;

-- sqlfmt-corpus-separator --

CREATE ROLE owner2;

-- sqlfmt-corpus-separator --

CREATE ROLE owner;
CREATE ROLE invoker;

-- sqlfmt-corpus-separator --

CREATE ROLE parent

-- sqlfmt-corpus-separator --

CREATE ROLE parent1;
CREATE ROLE child1;
GRANT parent1 TO child1

-- sqlfmt-corpus-separator --

CREATE ROLE parent3;
CREATE ROLE child3

-- sqlfmt-corpus-separator --

CREATE ROLE parent_role

-- sqlfmt-corpus-separator --

CREATE ROLE parent_with_createrole

-- sqlfmt-corpus-separator --

CREATE ROLE parentrole WITH CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE pat LOGIN;

-- sqlfmt-corpus-separator --

CREATE ROLE pg_otan

-- sqlfmt-corpus-separator --

CREATE ROLE public

-- sqlfmt-corpus-separator --

CREATE ROLE r

-- sqlfmt-corpus-separator --

CREATE ROLE r1

-- sqlfmt-corpus-separator --

CREATE ROLE r102962

-- sqlfmt-corpus-separator --

CREATE ROLE r2

-- sqlfmt-corpus-separator --

CREATE ROLE rinvisible

-- sqlfmt-corpus-separator --

CREATE ROLE rls_invoker LOGIN;

-- sqlfmt-corpus-separator --

CREATE ROLE rls_view_owner LOGIN;

-- sqlfmt-corpus-separator --

CREATE ROLE role10;

-- sqlfmt-corpus-separator --

CREATE ROLE role11;

-- sqlfmt-corpus-separator --

CREATE ROLE role1;

-- sqlfmt-corpus-separator --

CREATE ROLE role2;

-- sqlfmt-corpus-separator --

CREATE ROLE role3;

-- sqlfmt-corpus-separator --

CREATE ROLE role4;

-- sqlfmt-corpus-separator --

CREATE ROLE role5;

-- sqlfmt-corpus-separator --

CREATE ROLE role6;

-- sqlfmt-corpus-separator --

CREATE ROLE role7;

-- sqlfmt-corpus-separator --

CREATE ROLE role8;

-- sqlfmt-corpus-separator --

CREATE ROLE role9;

-- sqlfmt-corpus-separator --

CREATE ROLE role_bar;

-- sqlfmt-corpus-separator --

CREATE ROLE role_foo;

-- sqlfmt-corpus-separator --

CREATE ROLE role_test_login with LOGIN;
CREATE ROLE role_test_nologin;

-- sqlfmt-corpus-separator --

CREATE ROLE rolea

-- sqlfmt-corpus-separator --

CREATE ROLE roleb

-- sqlfmt-corpus-separator --

CREATE ROLE rolec

-- sqlfmt-corpus-separator --

CREATE ROLE roled

-- sqlfmt-corpus-separator --

CREATE ROLE rolee

-- sqlfmt-corpus-separator --

CREATE ROLE rolef

-- sqlfmt-corpus-separator --

CREATE ROLE roleg WITH CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE roleh WITH CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE rolej

-- sqlfmt-corpus-separator --

CREATE ROLE rolewithcreate NOCREATEROLE CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE rolewithcreate WITH CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE rolewithcreate WITH CREATEROLE CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE rolewithcreate WITH NOCREATEROLE CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE rolewithcreate WITH NOCREATEROLE NOCREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE rolewithcreate3 WITH CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE rolewithlogin LOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE rolewithnologin NOLOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE rolewithoutcreate WITH NOCREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE root

-- sqlfmt-corpus-separator --

CREATE ROLE schema_owner

-- sqlfmt-corpus-separator --

CREATE ROLE self_referencing_role

-- sqlfmt-corpus-separator --

CREATE ROLE some_users

-- sqlfmt-corpus-separator --

CREATE ROLE table_owner;

-- sqlfmt-corpus-separator --

CREATE ROLE test1;
CREATE ROLE test2;
GRANT test1, test2 TO root;

-- sqlfmt-corpus-separator --

CREATE ROLE test3;
CREATE ROLE test4;
GRANT test3, test4 TO root;

-- sqlfmt-corpus-separator --

CREATE ROLE test_role LOGIN;

-- sqlfmt-corpus-separator --

CREATE ROLE test_role1;

-- sqlfmt-corpus-separator --

CREATE ROLE test_role2;

-- sqlfmt-corpus-separator --

CREATE ROLE test_set_role;

-- sqlfmt-corpus-separator --

CREATE ROLE test_set_role;
CREATE DATABASE test_set_db

-- sqlfmt-corpus-separator --

CREATE ROLE testrole

-- sqlfmt-corpus-separator --

CREATE ROLE testrole3 LOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE testrole;
REVOKE admin FROM testuser2;
GRANT testuser TO testuser2

-- sqlfmt-corpus-separator --

CREATE ROLE testuser

-- sqlfmt-corpus-separator --

CREATE ROLE testuser2

-- sqlfmt-corpus-separator --

CREATE ROLE testuser2 WITH LOGIN;

-- sqlfmt-corpus-separator --

CREATE ROLE testuser2;
GRANT CREATE ON DATABASE test TO testuser2

-- sqlfmt-corpus-separator --

CREATE ROLE testuser4

-- sqlfmt-corpus-separator --

CREATE ROLE testuser4;
GRANT testuser4 TO root;

-- sqlfmt-corpus-separator --

CREATE ROLE testuser6

-- sqlfmt-corpus-separator --

CREATE ROLE testuser;

-- sqlfmt-corpus-separator --

CREATE ROLE testuser;
GRANT CREATE ON DATABASE test TO testuser;

-- sqlfmt-corpus-separator --

CREATE ROLE thisshouldntwork LOGIN LOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE thisshouldntwork LOGIN NOLOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE tmp;

-- sqlfmt-corpus-separator --

CREATE ROLE u_create_role_priv

-- sqlfmt-corpus-separator --

CREATE ROLE user1

-- sqlfmt-corpus-separator --

CREATE ROLE user2

-- sqlfmt-corpus-separator --

CREATE ROLE user4 CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE user_158154

-- sqlfmt-corpus-separator --

CREATE ROLE view_owner;

-- sqlfmt-corpus-separator --

CREATE SCHEMA "'db1-a'".sc1;

-- sqlfmt-corpus-separator --

CREATE SCHEMA "'db1-a'".sc2;

-- sqlfmt-corpus-separator --

CREATE SCHEMA "Another-Schema"

-- sqlfmt-corpus-separator --

CREATE SCHEMA "MixedCase"

-- sqlfmt-corpus-separator --

CREATE SCHEMA "MixedCaseDB"."MixedCaseSchema"

-- sqlfmt-corpus-separator --

CREATE SCHEMA "rEgReSsIoN 105906"

-- sqlfmt-corpus-separator --

CREATE SCHEMA "testSchema"

-- sqlfmt-corpus-separator --

CREATE SCHEMA "➖➖"

-- sqlfmt-corpus-separator --

CREATE SCHEMA IF NOT EXISTS crdb_internal

-- sqlfmt-corpus-separator --

CREATE SCHEMA IF NOT EXISTS create_schemas.schema1;

-- sqlfmt-corpus-separator --

CREATE SCHEMA IF NOT EXISTS derp

-- sqlfmt-corpus-separator --

CREATE SCHEMA IF NOT EXISTS information_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA IF NOT EXISTS pg_catalog

-- sqlfmt-corpus-separator --

CREATE SCHEMA IF NOT EXISTS public

-- sqlfmt-corpus-separator --

CREATE SCHEMA SC1;

-- sqlfmt-corpus-separator --

CREATE SCHEMA SC2;

-- sqlfmt-corpus-separator --

CREATE SCHEMA a.s

-- sqlfmt-corpus-separator --

CREATE SCHEMA acl_test_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA another_db.seq_schema_allow;
CREATE SCHEMA another_db.seq_schema_deny;

-- sqlfmt-corpus-separator --

CREATE SCHEMA comment_db.foo

-- sqlfmt-corpus-separator --

CREATE SCHEMA concurrent_drop_sc;

-- sqlfmt-corpus-separator --

CREATE SCHEMA crdb_internal

-- sqlfmt-corpus-separator --

CREATE SCHEMA create_schemas.schema1;

-- sqlfmt-corpus-separator --

CREATE SCHEMA d1.s1

-- sqlfmt-corpus-separator --

CREATE SCHEMA d1.s2

-- sqlfmt-corpus-separator --

CREATE SCHEMA d1.s3

-- sqlfmt-corpus-separator --

CREATE SCHEMA d1.s4

-- sqlfmt-corpus-separator --

CREATE SCHEMA d2.s1

-- sqlfmt-corpus-separator --

CREATE SCHEMA d2.s2

-- sqlfmt-corpus-separator --

CREATE SCHEMA db.schema1

-- sqlfmt-corpus-separator --

CREATE SCHEMA db1.sc1

-- sqlfmt-corpus-separator --

CREATE SCHEMA db2.s1;

-- sqlfmt-corpus-separator --

CREATE SCHEMA db2.sc3;

-- sqlfmt-corpus-separator --

CREATE SCHEMA db_new.sc

-- sqlfmt-corpus-separator --

CREATE SCHEMA derp

-- sqlfmt-corpus-separator --

CREATE SCHEMA drop_me

-- sqlfmt-corpus-separator --

CREATE SCHEMA drop_schema_with_triggers;

-- sqlfmt-corpus-separator --

CREATE SCHEMA dropped

-- sqlfmt-corpus-separator --

CREATE SCHEMA droptest;

-- sqlfmt-corpus-separator --

CREATE SCHEMA empty;
DROP SCHEMA empty

-- sqlfmt-corpus-separator --

CREATE SCHEMA foo

-- sqlfmt-corpus-separator --

CREATE SCHEMA foo;
CREATE SCHEMA bar

-- sqlfmt-corpus-separator --

CREATE SCHEMA information_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA my_pg_temp_123_123;

-- sqlfmt-corpus-separator --

CREATE SCHEMA myschema

-- sqlfmt-corpus-separator --

CREATE SCHEMA myschema2

-- sqlfmt-corpus-separator --

CREATE SCHEMA myschema2;
CREATE TABLE myschema2.tb2 (a INT PRIMARY KEY);

-- sqlfmt-corpus-separator --

CREATE SCHEMA myschema;
CREATE TABLE myschema.abc();
CREATE TABLE abc();
SELECT table_schema, table_name FROM information_schema.tables WHERE table_name = 'abc';

-- sqlfmt-corpus-separator --

CREATE SCHEMA new_db.s1

-- sqlfmt-corpus-separator --

CREATE SCHEMA newsc

-- sqlfmt-corpus-separator --

CREATE SCHEMA oldsc

-- sqlfmt-corpus-separator --

CREATE SCHEMA other_sc

-- sqlfmt-corpus-separator --

CREATE SCHEMA other_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA other_schema;

-- sqlfmt-corpus-separator --

CREATE SCHEMA otherschema;
SET search_path=invalidschema,otherschema,public

-- sqlfmt-corpus-separator --

CREATE SCHEMA owner_grant_option

-- sqlfmt-corpus-separator --

CREATE SCHEMA pg_catalog

-- sqlfmt-corpus-separator --

CREATE SCHEMA pg_temp

-- sqlfmt-corpus-separator --

CREATE SCHEMA privs

-- sqlfmt-corpus-separator --

CREATE SCHEMA public

-- sqlfmt-corpus-separator --

CREATE SCHEMA regression_105906

-- sqlfmt-corpus-separator --

CREATE SCHEMA roach_prod;
CREATE SCHEMA roach_dev;

-- sqlfmt-corpus-separator --

CREATE SCHEMA roachema;
GRANT USAGE ON SCHEMA roachema TO public;

-- sqlfmt-corpus-separator --

CREATE SCHEMA root;
CREATE TABLE root.root_table ();
CREATE SCHEMA testuser;
GRANT ALL ON SCHEMA testuser TO testuser;
CREATE TABLE testuser.testuser_table ();
GRANT ALL ON TABLE testuser.testuser_table TO testuser

-- sqlfmt-corpus-separator --

CREATE SCHEMA s

-- sqlfmt-corpus-separator --

CREATE SCHEMA s1

-- sqlfmt-corpus-separator --

CREATE SCHEMA s1;

-- sqlfmt-corpus-separator --

CREATE SCHEMA s2

-- sqlfmt-corpus-separator --

CREATE SCHEMA s3

-- sqlfmt-corpus-separator --

CREATE SCHEMA s4

-- sqlfmt-corpus-separator --

CREATE SCHEMA s5

-- sqlfmt-corpus-separator --

CREATE SCHEMA s;

-- sqlfmt-corpus-separator --

CREATE SCHEMA s;
ALTER SCHEMA s OWNER TO testuser

-- sqlfmt-corpus-separator --

CREATE SCHEMA s;
CREATE SCHEMA s2;

-- sqlfmt-corpus-separator --

CREATE SCHEMA s;
CREATE TABLE s.t()

-- sqlfmt-corpus-separator --

CREATE SCHEMA s;
GRANT CREATE ON SCHEMA s TO testuser2

-- sqlfmt-corpus-separator --

CREATE SCHEMA s_72322

-- sqlfmt-corpus-separator --

CREATE SCHEMA s_seqname

-- sqlfmt-corpus-separator --

CREATE SCHEMA samename

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc1

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc102962

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc1;

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc2

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc2;

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc64398;

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc93002

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc;

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc;
COMMENT ON SCHEMA defaultdb.sc IS 'This is a schema';

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc;
CREATE SCHEMA sc_new

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc;
CREATE TABLE sc.xy (x INT, y INT);
INSERT INTO sc.xy VALUES (1, 1);

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc_95364;

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc_rls_dep;

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc_test_priv;

-- sqlfmt-corpus-separator --

CREATE SCHEMA sc_tr_dep;

-- sqlfmt-corpus-separator --

CREATE SCHEMA scdrop1;
CREATE SCHEMA scdrop2;
CREATE SCHEMA scdrop3;
CREATE TABLE scdrop1.scdrop1_t1 (x INT);
CREATE TABLE scdrop1.scdrop1_t2 (x INT);
CREATE TABLE scdrop2.scdrop2_t1 (x INT);
CREATE VIEW scdrop2.scdrop2_v1 AS SELECT x FROM scdrop1.scdrop1_t1;
CREATE VIEW scdrop3.scdrop3_v1 AS SELECT x FROM scdrop2.scdrop2_v1;

-- sqlfmt-corpus-separator --

CREATE SCHEMA scdrop4_db.scdrop4;

-- sqlfmt-corpus-separator --

CREATE SCHEMA scdrop4_db.scdrop4;
CREATE SCHEMA scdrop5;
CREATE SCHEMA scdrop6_db.scdrop6;
CREATE TABLE scdrop4_db.scdrop4.scdrop4_t1 (x INT);
CREATE TABLE scdrop5.scdrop5_t1 (x INT);
CREATE TABLE scdrop6_db.scdrop6.scdrop6_t1 (x INT);
CREATE VIEW scdrop4_db.scdrop4.scdrop4_v1 AS SELECT x FROM scdrop4_db.scdrop4.scdrop4_t1;
CREATE VIEW scdrop5.scdrop5_v1 AS SELECT x FROM scdrop5.scdrop5_t1;
CREATE VIEW scdrop6_db.scdrop6.scdrop6_v1 AS SELECT x FROM scdrop6_db.scdrop6.scdrop6_t1;

-- sqlfmt-corpus-separator --

CREATE SCHEMA scdrop5;

-- sqlfmt-corpus-separator --

CREATE SCHEMA scdrop6_db.scdrop6;

-- sqlfmt-corpus-separator --

CREATE SCHEMA sch;
CREATE TABLE sch.table_to_rename();
CREATE TABLE sch.table_exists();
CREATE TABLE public_table_to_rename();
CREATE TABLE public_table_exists();

-- sqlfmt-corpus-separator --

CREATE SCHEMA schema; CREATE TABLE schema.bar (y INT PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE SCHEMA schema_123539;

-- sqlfmt-corpus-separator --

CREATE SCHEMA schema_a

-- sqlfmt-corpus-separator --

CREATE SCHEMA schema_to_drop;

-- sqlfmt-corpus-separator --

CREATE SCHEMA system.schema3;

-- sqlfmt-corpus-separator --

CREATE SCHEMA system;
CREATE TABLE system.comments (i INT)

-- sqlfmt-corpus-separator --

CREATE SCHEMA test

-- sqlfmt-corpus-separator --

CREATE SCHEMA test2

-- sqlfmt-corpus-separator --

CREATE SCHEMA test;

-- sqlfmt-corpus-separator --

CREATE SCHEMA test_sc

-- sqlfmt-corpus-separator --

CREATE SCHEMA test_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA test_schema;
CREATE TABLE test_schema.test (
  a INT PRIMARY KEY,
  b INT
);
CREATE index on test_schema.test(b)

-- sqlfmt-corpus-separator --

CREATE SCHEMA testing

-- sqlfmt-corpus-separator --

CREATE SCHEMA testuser

-- sqlfmt-corpus-separator --

CREATE SCHEMA testuser_s2;

-- sqlfmt-corpus-separator --

CREATE SCHEMA testuser_s;

-- sqlfmt-corpus-separator --

CREATE SCHEMA the_schema

-- sqlfmt-corpus-separator --

CREATE SCHEMA yourschema

-- sqlfmt-corpus-separator --

CREATE TABLE d.t2();
ALTER TABLE d.t2 OWNER TO testuser

-- sqlfmt-corpus-separator --

CREATE TABLE invalid_table(id UUID PRIMARY KEY, s STRING);
INSERT INTO invalid_table SELECT gen_random_uuid(), '{';

-- sqlfmt-corpus-separator --

CREATE TABLE s.t();
ALTER TABLE s.t OWNER TO testuser

-- sqlfmt-corpus-separator --

CREATE TABLE show_test (x INT PRIMARY KEY);
SHOW INDEXES FROM show_test

-- sqlfmt-corpus-separator --

CREATE TABLE t (
    i2    INT2,
    i4    INT4,
    i8    INT8,
    f4    FLOAT4,
    f8    FLOAT8,
    s     STRING,
    c     CHAR,
    b     BYTES,
    dc    DECIMAL,
    ival  INTERVAL,
    oid   OID,
    tstz  TIMESTAMPTZ,
    ts    TIMESTAMP,
    da    DATE,
    inet  INET,
    vb    VARBIT(2)
);
INSERT
  INTO t
SELECT i::INT2,
       i::INT4,
       i::INT8,
       i::FLOAT4,
       i::FLOAT8,
       i::STRING,
       i::CHAR,
       i::STRING::BYTES,
       i::DECIMAL,
       i::INTERVAL,
       i::OID,
       i::TIMESTAMPTZ,
       i::TIMESTAMP,
       i::DATE,
       ('127.0.0.' || i::STRING)::INET,
       i::VARBIT(2)
  FROM (
         SELECT i FROM generate_series(1, 2) as t(i)
         UNION ALL SELECT NULL
       );
SELECT *
  FROM (
        SELECT a.i2,
               b.i4,
               c.i8,
               d.f4,
               e.f8,
               f.s,
               g.c,
               h.b,
               i.dc,
               j.ival,
               k.oid,
               l.tstz,
               m.ts,
               n.da,
               o.inet,
               p.vb,
               random() AS r
          FROM t AS a,
               t AS b,
               t AS c,
               t AS d,
               t AS e,
               t AS f,
               t AS g,
               t AS h,
               t AS i,
               t AS j,
               t AS k,
               t AS l,
               t AS m,
               t AS n,
               t AS o,
               t AS p
       )
 WHERE r < .01
 LIMIT 1

-- sqlfmt-corpus-separator --

CREATE TABLE t1();
ALTER TABLE t1 OWNER TO testuser

-- sqlfmt-corpus-separator --

CREATE TABLE t1(a INT PRIMARY KEY, b BOOLEAN);
CREATE DATABASE other_db;
SET DATABASE = other_db;
CREATE TABLE t2(c STRING PRIMARY KEY, d DECIMAL);

-- sqlfmt-corpus-separator --

CREATE TABLE t46981_0(c0 INT);
CREATE VIEW v46981_0(c0) AS SELECT count_rows() FROM t46981_0

-- sqlfmt-corpus-separator --

CREATE TABLE t81315 (a DECIMAL NOT NULL PRIMARY KEY, b INT);
PREPARE q81315 AS SELECT * FROM t81315 WHERE a = $1::INT8;
INSERT INTO t81315 VALUES (1, 100), (2, 200)

-- sqlfmt-corpus-separator --

CREATE TABLE t81315_2 (
  k INT PRIMARY KEY,
  a INT
);
PREPARE q81315_2 AS SELECT * FROM t81315_2 WHERE k = $1;
INSERT INTO t81315_2 VALUES (1, 1)

-- sqlfmt-corpus-separator --

CREATE TYPE SC1.COMP1 AS (A INT, B TEXT);

-- sqlfmt-corpus-separator --

CREATE TYPE SC2.COMP1 AS (C SMALLINT, D BOOL);

-- sqlfmt-corpus-separator --

CREATE TYPE address AS (
        street STRING,
        city STRING,
        state STRING,
        zipcode STRING
    );

-- sqlfmt-corpus-separator --

CREATE TYPE amount AS ("value" INT, "currency" STRING, "minor_units" INT)

-- sqlfmt-corpus-separator --

CREATE TYPE arr_composite AS (a INT[], b TEXT[])

-- sqlfmt-corpus-separator --

CREATE TYPE comp1 AS (foo INT, bar INT);

-- sqlfmt-corpus-separator --

CREATE TYPE comp2 AS ("FOO" INT, "BAR" INT);

-- sqlfmt-corpus-separator --

CREATE TYPE comp3 AS (foo INT, "BAR" INT);

-- sqlfmt-corpus-separator --

CREATE TYPE composite_coord AS (x INT, y INT);

-- sqlfmt-corpus-separator --

CREATE TYPE foo_typ AS (x INT, y INT);
CREATE TYPE bar_typ AS (x INT, y INT);

-- sqlfmt-corpus-separator --

CREATE TYPE my_tuple AS (a INT, b INT)

-- sqlfmt-corpus-separator --

CREATE TYPE one_typ AS (x INT);
CREATE TYPE foo_typ AS (x INT, y INT);
CREATE TYPE bar_typ AS (x INT, y INT);

-- sqlfmt-corpus-separator --

CREATE TYPE one_typ AS (x INT);
CREATE TYPE two_typ AS (x INT, y INT);

-- sqlfmt-corpus-separator --

CREATE TYPE pg_temp.temp_type AS (a int, b int);

-- sqlfmt-corpus-separator --

CREATE TYPE s.typ AS (x INT, y INT);

-- sqlfmt-corpus-separator --

CREATE TYPE t AS (a INT)

-- sqlfmt-corpus-separator --

CREATE TYPE t AS (a INT, b INT)

-- sqlfmt-corpus-separator --

CREATE TYPE t AS (a INT, b TEXT)

-- sqlfmt-corpus-separator --

CREATE TYPE t AS (a pg_catalog.pg_class)

-- sqlfmt-corpus-separator --

CREATE TYPE t AS (a tab)

-- sqlfmt-corpus-separator --

CREATE TYPE t AS (e e)

-- sqlfmt-corpus-separator --

CREATE TYPE t114677 AS (x INT, y INT);

-- sqlfmt-corpus-separator --

CREATE TYPE t114677 AS (x INT, y INT);
CREATE TYPE t114677_2 AS (a INT, b INT);

-- sqlfmt-corpus-separator --

CREATE TYPE t2 AS (t1 t, t2 t)

-- sqlfmt-corpus-separator --

CREATE TYPE typ AS (a INT);

-- sqlfmt-corpus-separator --

CREATE TYPE typ AS (a INT, b INT);

-- sqlfmt-corpus-separator --

CREATE TYPE typ AS (j JSONPATH);

-- sqlfmt-corpus-separator --

CREATE TYPE typ AS (x INT, y INT);

-- sqlfmt-corpus-separator --

CREATE TYPE typ AS (x INT, y REFCURSOR);

-- sqlfmt-corpus-separator --

CREATE TYPE u AS (ufoo char, ubar int);

-- sqlfmt-corpus-separator --

CREATE TYPE u AS (ufoo int, ubar int);

-- sqlfmt-corpus-separator --

CREATE TYPE udt AS (x INT, y TRIGGER, z TEXT);

-- sqlfmt-corpus-separator --

CREATE TYPE udt AS (x INT, y TRIGGER[], z TEXT);

-- sqlfmt-corpus-separator --

CREATE TYPE user_profile AS (name STRING, age INT);

-- sqlfmt-corpus-separator --

CREATE VIEW priv_v AS SELECT * FROM priv_f();

-- sqlfmt-corpus-separator --

CREATE VIEW star6 AS TABLE t

-- sqlfmt-corpus-separator --

CREATE VIEW v AS SELECT x, y, f_scalar() FROM f_setof();

-- sqlfmt-corpus-separator --

CREATE VIEW v128535 AS SELECT json_to_tsvector()

-- sqlfmt-corpus-separator --

DEALLOCATE ALL

-- sqlfmt-corpus-separator --

DEALLOCATE a

-- sqlfmt-corpus-separator --

DEALLOCATE a1

-- sqlfmt-corpus-separator --

DEALLOCATE b

-- sqlfmt-corpus-separator --

DEALLOCATE insert_returning

-- sqlfmt-corpus-separator --

DEALLOCATE p

-- sqlfmt-corpus-separator --

DEALLOCATE p0

-- sqlfmt-corpus-separator --

DEALLOCATE p1

-- sqlfmt-corpus-separator --

DEALLOCATE p152664

-- sqlfmt-corpus-separator --

DEALLOCATE p159043

-- sqlfmt-corpus-separator --

DEALLOCATE p161993

-- sqlfmt-corpus-separator --

DEALLOCATE p2

-- sqlfmt-corpus-separator --

DEALLOCATE p3

-- sqlfmt-corpus-separator --

DEALLOCATE p4

-- sqlfmt-corpus-separator --

DEALLOCATE p5

-- sqlfmt-corpus-separator --

DEALLOCATE p;

-- sqlfmt-corpus-separator --

DEALLOCATE p;
PREPARE p AS SELECT 'foo'::BPCHAR = $1

-- sqlfmt-corpus-separator --

DEALLOCATE p;
PREPARE p AS SELECT bp, length(bp) FROM chars WHERE bp = $1

-- sqlfmt-corpus-separator --

DEALLOCATE p;
PREPARE p AS SELECT c, length(c) FROM chars WHERE c = $1

-- sqlfmt-corpus-separator --

DEALLOCATE psa

-- sqlfmt-corpus-separator --

DEALLOCATE pscs10

-- sqlfmt-corpus-separator --

DEALLOCATE test_oid_param

-- sqlfmt-corpus-separator --

DECLARE "<unnamed portal 7>" CURSOR FOR SELECT 1;
DECLARE "<unnamed portal 8>" CURSOR FOR SELECT 1;

-- sqlfmt-corpus-separator --

DECLARE "a"" b'c" CURSOR FOR SELECT 1;

-- sqlfmt-corpus-separator --

DECLARE "a"" b'c" CURSOR FOR TABLE t;
DECLARE "a b" CURSOR FOR TABLE t;
DECLARE "a\b" CURSOR FOR TABLE t;

-- sqlfmt-corpus-separator --

DECLARE bar CURSOR FOR SELECT 1,2,3;

-- sqlfmt-corpus-separator --

DECLARE foo CURSOR FOR SELECT * FROM a

-- sqlfmt-corpus-separator --

DECLARE foo CURSOR FOR SELECT * FROM a ORDER BY a

-- sqlfmt-corpus-separator --

DECLARE foo CURSOR FOR SELECT 1

-- sqlfmt-corpus-separator --

DECLARE foo CURSOR FOR SELECT 100;

-- sqlfmt-corpus-separator --

DECLARE foo CURSOR FOR SELECT 1;

-- sqlfmt-corpus-separator --

DECLARE foo CURSOR FOR SELECT 1;
DECLARE bar CURSOR FOR SELECT 2;

-- sqlfmt-corpus-separator --

DECLARE foo CURSOR FOR SELECT teeth FROM a

-- sqlfmt-corpus-separator --

DISCARD ALL

-- sqlfmt-corpus-separator --

DISCARD ALL;

-- sqlfmt-corpus-separator --

DISCARD SEQUENCES

-- sqlfmt-corpus-separator --

DISCARD TEMP

-- sqlfmt-corpus-separator --

DISCARD TEMP;

-- sqlfmt-corpus-separator --

DROP DATABASE IF EXISTS my_db;
CREATE DATABASE my_db;

-- sqlfmt-corpus-separator --

DROP OWNED BY admin

-- sqlfmt-corpus-separator --

DROP OWNED BY r1, r2

-- sqlfmt-corpus-separator --

DROP OWNED BY root

-- sqlfmt-corpus-separator --

DROP OWNED BY testuser

-- sqlfmt-corpus-separator --

DROP OWNED BY testuser RESTRICT

-- sqlfmt-corpus-separator --

DROP OWNED BY testuser, testuser2

-- sqlfmt-corpus-separator --

DROP OWNED BY testuser2

-- sqlfmt-corpus-separator --

DROP OWNED BY testuser2 CASCADE

-- sqlfmt-corpus-separator --

DROP OWNED BY u_drop_udf;

-- sqlfmt-corpus-separator --

DROP TABLE a;
DROP TYPE t;
CREATE TYPE t AS (a INT, b TEXT);
CREATE TABLE a (a INT CHECK (a > (((1, 'hi')::t).a)))

-- sqlfmt-corpus-separator --

DROP owned by public;

-- sqlfmt-corpus-separator --

EXECUTE a

-- sqlfmt-corpus-separator --

EXECUTE a('foo', 1)

-- sqlfmt-corpus-separator --

EXECUTE a((SELECT 3), 1)

-- sqlfmt-corpus-separator --

EXECUTE a(1)

-- sqlfmt-corpus-separator --

EXECUTE a(1, 1, 1)

-- sqlfmt-corpus-separator --

EXECUTE a(2)

-- sqlfmt-corpus-separator --

EXECUTE a(3, 1)

-- sqlfmt-corpus-separator --

EXECUTE a(3.5, 1)

-- sqlfmt-corpus-separator --

EXECUTE a(max(3), 1)

-- sqlfmt-corpus-separator --

EXECUTE a(rank() over (partition by 3), 1)

-- sqlfmt-corpus-separator --

EXECUTE a1

-- sqlfmt-corpus-separator --

EXECUTE aggprep(10)

-- sqlfmt-corpus-separator --

EXECUTE aggprep(20)

-- sqlfmt-corpus-separator --

EXECUTE allTypes(0, 0.0, 'foo', 'bar', '2017-08-08', '2015-08-30 03:34:45.34567', '2015-08-30 03:34:45.34567', true, 3.4)

-- sqlfmt-corpus-separator --

EXECUTE args_deduce_type(1,2,3,4);
EXECUTE args_deduce_type('1','2',3,'4');

-- sqlfmt-corpus-separator --

EXECUTE args_deduce_type_1(1,10,100);

-- sqlfmt-corpus-separator --

EXECUTE args_test_few(1)

-- sqlfmt-corpus-separator --

EXECUTE args_test_few(1, 2)

-- sqlfmt-corpus-separator --

EXECUTE args_test_many(1)

-- sqlfmt-corpus-separator --

EXECUTE args_test_many(1, 2)

-- sqlfmt-corpus-separator --

EXECUTE b

-- sqlfmt-corpus-separator --

EXECUTE b('foo')

-- sqlfmt-corpus-separator --

EXECUTE b(3)

-- sqlfmt-corpus-separator --

EXECUTE bad_max_staleness_stmt

-- sqlfmt-corpus-separator --

EXECUTE bad_min_timestamp_stmt

-- sqlfmt-corpus-separator --

EXECUTE bar;

-- sqlfmt-corpus-separator --

EXECUTE c

-- sqlfmt-corpus-separator --

EXECUTE change_db

-- sqlfmt-corpus-separator --

EXECUTE change_db_2

-- sqlfmt-corpus-separator --

EXECUTE change_db_3

-- sqlfmt-corpus-separator --

EXECUTE change_drop

-- sqlfmt-corpus-separator --

EXECUTE change_loc

-- sqlfmt-corpus-separator --

EXECUTE change_placeholders(1)

-- sqlfmt-corpus-separator --

EXECUTE change_privileges

-- sqlfmt-corpus-separator --

EXECUTE change_rename

-- sqlfmt-corpus-separator --

EXECUTE change_rename_2

-- sqlfmt-corpus-separator --

EXECUTE change_schema_uncommitted

-- sqlfmt-corpus-separator --

EXECUTE change_search_path

-- sqlfmt-corpus-separator --

EXECUTE change_view

-- sqlfmt-corpus-separator --

EXECUTE check_custom

-- sqlfmt-corpus-separator --

EXECUTE concat_stmt(':')

-- sqlfmt-corpus-separator --

EXECUTE concat_stmt2(':')

-- sqlfmt-corpus-separator --

EXECUTE corr_s1(1)

-- sqlfmt-corpus-separator --

EXECUTE ctestmt (10)

-- sqlfmt-corpus-separator --

EXECUTE d

-- sqlfmt-corpus-separator --

EXECUTE del (1)

-- sqlfmt-corpus-separator --

EXECUTE display_appname

-- sqlfmt-corpus-separator --

EXECUTE do_math(3, 7, 11, 17)

-- sqlfmt-corpus-separator --

EXECUTE e

-- sqlfmt-corpus-separator --

EXECUTE e1 ('Bill Roacher', 'bill@cockroachlabs.com', 'Jo Roacher', 'jo@cockroachlabs.com')

-- sqlfmt-corpus-separator --

EXECUTE enum_drop

-- sqlfmt-corpus-separator --

EXECUTE enum_query

-- sqlfmt-corpus-separator --

EXECUTE f

-- sqlfmt-corpus-separator --

EXECUTE foo (100);

-- sqlfmt-corpus-separator --

EXECUTE foo;

-- sqlfmt-corpus-separator --

EXECUTE foobar(NULL, NULL)

-- sqlfmt-corpus-separator --

EXECUTE format_stmt(-10, 'foo')

-- sqlfmt-corpus-separator --

EXECUTE format_stmt(10, 'foo')

-- sqlfmt-corpus-separator --

EXECUTE groupbyhaving(1)

-- sqlfmt-corpus-separator --

EXECUTE i('foo')

-- sqlfmt-corpus-separator --

EXECUTE i(1)

-- sqlfmt-corpus-separator --

EXECUTE i(2)

-- sqlfmt-corpus-separator --

EXECUTE i(3.3)

-- sqlfmt-corpus-separator --

EXECUTE i(4.3::int)

-- sqlfmt-corpus-separator --

EXECUTE insert_a(ARRAY[7.77, 8.88::DECIMAL(10, 2)])

-- sqlfmt-corpus-separator --

EXECUTE insert_a2(20.2)

-- sqlfmt-corpus-separator --

EXECUTE insert_a3(30.9)

-- sqlfmt-corpus-separator --

EXECUTE insert_c(' ')

-- sqlfmt-corpus-separator --

EXECUTE insert_c(' '::STRING)

-- sqlfmt-corpus-separator --

EXECUTE insert_c('foo')

-- sqlfmt-corpus-separator --

EXECUTE insert_c('foo'::STRING)

-- sqlfmt-corpus-separator --

EXECUTE insert_ca(ARRAY['a', 'foo'])

-- sqlfmt-corpus-separator --

EXECUTE insert_d(123.45)

-- sqlfmt-corpus-separator --

EXECUTE insert_d2(67.89)

-- sqlfmt-corpus-separator --

EXECUTE insert_do_nothing_d(1, 2, 'a')

-- sqlfmt-corpus-separator --

EXECUTE insert_do_nothing_d(1, 2.0, 'a')

-- sqlfmt-corpus-separator --

EXECUTE insert_do_nothing_d(1, 2.45, 'a')

-- sqlfmt-corpus-separator --

EXECUTE insert_do_nothing_d(1, 2.45::DECIMAL(10, 2), 'a')

-- sqlfmt-corpus-separator --

EXECUTE insert_do_nothing_d(1, 2.56, 'a')

-- sqlfmt-corpus-separator --

EXECUTE insert_do_nothing_d2(1, 2, 'a')

-- sqlfmt-corpus-separator --

EXECUTE insert_do_nothing_d2(1, 2.0, 'a')

-- sqlfmt-corpus-separator --

EXECUTE insert_do_nothing_d2(1, 2.45, 'a')

-- sqlfmt-corpus-separator --

EXECUTE insert_do_nothing_d2(1, 2.45::DECIMAL(10, 2), 'a')

-- sqlfmt-corpus-separator --

EXECUTE insert_do_nothing_d2(1, 2.56, 'a')

-- sqlfmt-corpus-separator --

EXECUTE insert_do_update_c('b', 'abc')

-- sqlfmt-corpus-separator --

EXECUTE insert_do_update_c('b', 'abc'::STRING)

-- sqlfmt-corpus-separator --

EXECUTE insert_do_update_c('b', 'c')

-- sqlfmt-corpus-separator --

EXECUTE insert_do_update_c('c', 'abc')

-- sqlfmt-corpus-separator --

EXECUTE insert_f4(18754999.99)

-- sqlfmt-corpus-separator --

EXECUTE insert_i('1')

-- sqlfmt-corpus-separator --

EXECUTE insert_i2(99999999)

-- sqlfmt-corpus-separator --

EXECUTE insert_qc('foo')

-- sqlfmt-corpus-separator --

EXECUTE insert_qc('foo'::STRING)

-- sqlfmt-corpus-separator --

EXECUTE insert_s(2)

-- sqlfmt-corpus-separator --

EXECUTE insert_vba(ARRAY[B'1', B'11'])

-- sqlfmt-corpus-separator --

EXECUTE jba_stmt(':');

-- sqlfmt-corpus-separator --

EXECUTE jbo_stmt(':');

-- sqlfmt-corpus-separator --

EXECUTE loc_dependent_operator

-- sqlfmt-corpus-separator --

EXECUTE new_table_in_search_path

-- sqlfmt-corpus-separator --

EXECUTE new_table_in_search_path_2

-- sqlfmt-corpus-separator --

EXECUTE nn_stmt('foo')

-- sqlfmt-corpus-separator --

EXECUTE nn_stmt(NULL)

-- sqlfmt-corpus-separator --

EXECUTE nn_stmt3('foo')

-- sqlfmt-corpus-separator --

EXECUTE nn_stmt3(42)

-- sqlfmt-corpus-separator --

EXECUTE p

-- sqlfmt-corpus-separator --

EXECUTE p ('foo', 'bar')

-- sqlfmt-corpus-separator --

EXECUTE p (33, 44)

-- sqlfmt-corpus-separator --

EXECUTE p (33, 44, 55, 66)

-- sqlfmt-corpus-separator --

EXECUTE p('bar   ')

-- sqlfmt-corpus-separator --

EXECUTE p('foo   ')

-- sqlfmt-corpus-separator --

EXECUTE p(1);

-- sqlfmt-corpus-separator --

EXECUTE p(1);
EXECUTE p(10);
EXECUTE p(100);
EXECUTE p(1000);
EXECUTE p(10000);

-- sqlfmt-corpus-separator --

EXECUTE p(1, 10, 100);
EXECUTE p(1, 10, 100);
EXECUTE p(1, 10, 100);
EXECUTE p(1, 10, 100);
EXECUTE p(1, 10, 100);

-- sqlfmt-corpus-separator --

EXECUTE p(1, 2);
EXECUTE p(10, 20);
EXECUTE p(100, 200);
EXECUTE p(1000, 2000);

-- sqlfmt-corpus-separator --

EXECUTE p(1, 2);
EXECUTE p(10, 20);
EXECUTE p(100, 200);
EXECUTE p(1000, 2000);
EXECUTE p(10000, 20000);

-- sqlfmt-corpus-separator --

EXECUTE p(10)

-- sqlfmt-corpus-separator --

EXECUTE p(120)

-- sqlfmt-corpus-separator --

EXECUTE p(2);

-- sqlfmt-corpus-separator --

EXECUTE p(NULL, 3, 33, NULL)

-- sqlfmt-corpus-separator --

EXECUTE p(f())

-- sqlfmt-corpus-separator --

EXECUTE p0(0, 0, 0, 0)

-- sqlfmt-corpus-separator --

EXECUTE p1 ('Bill Roacher', 'bill@cockroachlabs.com', 'Jo Roacher', 'jo@cockroachlabs.com')

-- sqlfmt-corpus-separator --

EXECUTE p1(1, 1, 1, 1)

-- sqlfmt-corpus-separator --

EXECUTE p1(1, 2)

-- sqlfmt-corpus-separator --

EXECUTE p1(123)

-- sqlfmt-corpus-separator --

EXECUTE p152664(false, NULL, 4)

-- sqlfmt-corpus-separator --

EXECUTE p152664(true, 4, NULL)

-- sqlfmt-corpus-separator --

EXECUTE p158945a(NULL)

-- sqlfmt-corpus-separator --

EXECUTE p158945b(NULL)

-- sqlfmt-corpus-separator --

EXECUTE p159043(-1)

-- sqlfmt-corpus-separator --

EXECUTE p159043(10)

-- sqlfmt-corpus-separator --

EXECUTE p159124

-- sqlfmt-corpus-separator --

EXECUTE p161993 ('{}')

-- sqlfmt-corpus-separator --

EXECUTE p2(123)

-- sqlfmt-corpus-separator --

EXECUTE p2(2, 2, 2, 2)

-- sqlfmt-corpus-separator --

EXECUTE p3(124)

-- sqlfmt-corpus-separator --

EXECUTE p3(3, 3, 3, 3)

-- sqlfmt-corpus-separator --

EXECUTE p4(123)

-- sqlfmt-corpus-separator --

EXECUTE p4(4, 4, 4, 4)

-- sqlfmt-corpus-separator --

EXECUTE p5(123)

-- sqlfmt-corpus-separator --

EXECUTE p5(5, 5, NULL, 5)

-- sqlfmt-corpus-separator --

EXECUTE p6(123)

-- sqlfmt-corpus-separator --

EXECUTE pg_catalog_query

-- sqlfmt-corpus-separator --

EXECUTE psa('matilda')

-- sqlfmt-corpus-separator --

EXECUTE pscs01(1)

-- sqlfmt-corpus-separator --

EXECUTE pscs02(2)

-- sqlfmt-corpus-separator --

EXECUTE pscs03(3)

-- sqlfmt-corpus-separator --

EXECUTE pscs04(4)

-- sqlfmt-corpus-separator --

EXECUTE pscs05(5)

-- sqlfmt-corpus-separator --

EXECUTE pscs06(6)

-- sqlfmt-corpus-separator --

EXECUTE pscs11(11)

-- sqlfmt-corpus-separator --

EXECUTE q('c')

-- sqlfmt-corpus-separator --

EXECUTE q64765(1, 1)

-- sqlfmt-corpus-separator --

EXECUTE q81315 (1)

-- sqlfmt-corpus-separator --

EXECUTE q81315_2(1::DECIMAL)

-- sqlfmt-corpus-separator --

EXECUTE query ('a', '"b"')

-- sqlfmt-corpus-separator --

EXECUTE r1('abc')

-- sqlfmt-corpus-separator --

EXECUTE rcc('t')

-- sqlfmt-corpus-separator --

EXECUTE regression_71394(71394)

-- sqlfmt-corpus-separator --

EXECUTE right_no_cols

-- sqlfmt-corpus-separator --

EXECUTE s

-- sqlfmt-corpus-separator --

EXECUTE s('ap-southeast-2')

-- sqlfmt-corpus-separator --

EXECUTE s('us-east-1')

-- sqlfmt-corpus-separator --

EXECUTE s1 (1, 1, 1, -5)

-- sqlfmt-corpus-separator --

EXECUTE s1('2')

-- sqlfmt-corpus-separator --

EXECUTE s2 (6, 7, 8, -5)

-- sqlfmt-corpus-separator --

EXECUTE s3 (7, 7, 7, 7, 6, 7, 8, -5)

-- sqlfmt-corpus-separator --

EXECUTE s4 (7, 7, 7, 7, 6, 7, 8, -5)

-- sqlfmt-corpus-separator --

EXECUTE s73450_a(999999)

-- sqlfmt-corpus-separator --

EXECUTE s73450_b('foo')

-- sqlfmt-corpus-separator --

EXECUTE s73450_c('foo')

-- sqlfmt-corpus-separator --

EXECUTE s_114867('red')

-- sqlfmt-corpus-separator --

EXECUTE selectin(5, 1)

-- sqlfmt-corpus-separator --

EXECUTE selectin2(1, 5, 1)

-- sqlfmt-corpus-separator --

EXECUTE seqsel

-- sqlfmt-corpus-separator --

EXECUTE set_setting('some string')

-- sqlfmt-corpus-separator --

EXECUTE setp('hello'); SHOW application_name

-- sqlfmt-corpus-separator --

EXECUTE sets('hello')

-- sqlfmt-corpus-separator --

EXECUTE showOwners('atest')

-- sqlfmt-corpus-separator --

EXECUTE show_hints_stmt('SELECT * FROM ab WHERE a = 1')

-- sqlfmt-corpus-separator --

EXECUTE subqueryprep(4)

-- sqlfmt-corpus-separator --

EXECUTE subqueryprep(5)

-- sqlfmt-corpus-separator --

EXECUTE subqueryprep(6)

-- sqlfmt-corpus-separator --

EXECUTE test_oid_param('1234')

-- sqlfmt-corpus-separator --

EXECUTE tview_prep

-- sqlfmt-corpus-separator --

EXECUTE update_a(ARRAY[7.77, 8.88::DECIMAL(10, 2)])

-- sqlfmt-corpus-separator --

EXECUTE update_a2(20.2)

-- sqlfmt-corpus-separator --

EXECUTE update_a3(30.9)

-- sqlfmt-corpus-separator --

EXECUTE update_c(' ')

-- sqlfmt-corpus-separator --

EXECUTE update_c(' '::STRING)

-- sqlfmt-corpus-separator --

EXECUTE update_c('foo')

-- sqlfmt-corpus-separator --

EXECUTE update_c('foo'::STRING)

-- sqlfmt-corpus-separator --

EXECUTE update_d(123.45)

-- sqlfmt-corpus-separator --

EXECUTE update_d2(67.89)

-- sqlfmt-corpus-separator --

EXECUTE update_i('1')

-- sqlfmt-corpus-separator --

EXECUTE update_i2(99999999)

-- sqlfmt-corpus-separator --

EXECUTE update_privileges(5)

-- sqlfmt-corpus-separator --

EXECUTE update_qc('foo')

-- sqlfmt-corpus-separator --

EXECUTE update_qc('foo'::STRING)

-- sqlfmt-corpus-separator --

EXECUTE upsert_a(1, ARRAY[7.77, 8.88::DECIMAL(10, 2)])

-- sqlfmt-corpus-separator --

EXECUTE upsert_a2(1, 20.2)

-- sqlfmt-corpus-separator --

EXECUTE upsert_a3(1, 30.9)

-- sqlfmt-corpus-separator --

EXECUTE upsert_c(1, ' ')

-- sqlfmt-corpus-separator --

EXECUTE upsert_c(1, ' '::STRING)

-- sqlfmt-corpus-separator --

EXECUTE upsert_c(1, 'foo')

-- sqlfmt-corpus-separator --

EXECUTE upsert_c(1, 'foo'::STRING)

-- sqlfmt-corpus-separator --

EXECUTE upsert_c(2, ' ')

-- sqlfmt-corpus-separator --

EXECUTE upsert_c(2, 'foo')

-- sqlfmt-corpus-separator --

EXECUTE upsert_c(3, ' '::STRING)

-- sqlfmt-corpus-separator --

EXECUTE upsert_d(1, 123.45)

-- sqlfmt-corpus-separator --

EXECUTE upsert_d2(67.89)

-- sqlfmt-corpus-separator --

EXECUTE upsert_i2(1, 99999999)

-- sqlfmt-corpus-separator --

EXECUTE upsert_qc(1, 'bar'::STRING)

-- sqlfmt-corpus-separator --

EXECUTE upsert_qc(1, 'foo')

-- sqlfmt-corpus-separator --

EXECUTE with_max_staleness_prep

-- sqlfmt-corpus-separator --

EXECUTE with_min_timestamp_prep

-- sqlfmt-corpus-separator --

EXECUTE wrongTypeImpossibleCast('crabgas')

-- sqlfmt-corpus-separator --

EXECUTE x

-- sqlfmt-corpus-separator --

EXECUTE x (1, 'fo', 2, 'bar')

-- sqlfmt-corpus-separator --

EXECUTE x((1,2))

-- sqlfmt-corpus-separator --

EXECUTE x((1,2,3))

-- sqlfmt-corpus-separator --

EXECUTE x(1, 2)

-- sqlfmt-corpus-separator --

EXECUTE x(2, 3)

-- sqlfmt-corpus-separator --

EXECUTE x(3, 4)

-- sqlfmt-corpus-separator --

EXECUTE x(NULL)

-- sqlfmt-corpus-separator --

EXECUTE x21701a(NULL)

-- sqlfmt-corpus-separator --

EXECUTE x21701b(NULL)

-- sqlfmt-corpus-separator --

EXECUTE x21701c(NULL)

-- sqlfmt-corpus-separator --

EXECUTE y

-- sqlfmt-corpus-separator --

EXECUTE y (3, 4)

-- sqlfmt-corpus-separator --

EXECUTE y((1,2))

-- sqlfmt-corpus-separator --

EXECUTE z(1)

-- sqlfmt-corpus-separator --

EXECUTE z(2)

-- sqlfmt-corpus-separator --

EXECUTE z(3)

-- sqlfmt-corpus-separator --

EXECUTE z2(1)

-- sqlfmt-corpus-separator --

EXECUTE z3(3)

-- sqlfmt-corpus-separator --

EXECUTE z4(3)

-- sqlfmt-corpus-separator --

EXECUTE z5(3, 5)

-- sqlfmt-corpus-separator --

EXECUTE z6(3)

-- sqlfmt-corpus-separator --

FETCH 0 foo

-- sqlfmt-corpus-separator --

FETCH 1 "a b";

-- sqlfmt-corpus-separator --

FETCH 1 "a"" b'c";

-- sqlfmt-corpus-separator --

FETCH 1 "a\b";

-- sqlfmt-corpus-separator --

FETCH 1 FROM a

-- sqlfmt-corpus-separator --

FETCH 1 bar

-- sqlfmt-corpus-separator --

FETCH 1 curs

-- sqlfmt-corpus-separator --

FETCH 1 foo

-- sqlfmt-corpus-separator --

FETCH 1 foo;

-- sqlfmt-corpus-separator --

FETCH 2 foo

-- sqlfmt-corpus-separator --

FETCH 3 FROM dup;

-- sqlfmt-corpus-separator --

FETCH 3 FROM foo;

-- sqlfmt-corpus-separator --

FETCH 3 bar

-- sqlfmt-corpus-separator --

FETCH 3 foo

-- sqlfmt-corpus-separator --

FETCH ALL foo

-- sqlfmt-corpus-separator --

FETCH FORWARD 1 FROM foo;

-- sqlfmt-corpus-separator --

FETCH FORWARD 10 FROM foo;

-- sqlfmt-corpus-separator --

FETCH FORWARD 2 FROM foo;

-- sqlfmt-corpus-separator --

FETCH FORWARD 3 FROM "<unnamed portal 10>";

-- sqlfmt-corpus-separator --

FETCH FORWARD 3 FROM "<unnamed portal 11>";

-- sqlfmt-corpus-separator --

FETCH FORWARD 3 FROM "<unnamed portal 1>";

-- sqlfmt-corpus-separator --

FETCH FORWARD 3 FROM "<unnamed portal 2>";

-- sqlfmt-corpus-separator --

FETCH FORWARD 3 FROM "<unnamed portal 3>";

-- sqlfmt-corpus-separator --

FETCH FORWARD 3 FROM bar;

-- sqlfmt-corpus-separator --

FETCH FORWARD 3 FROM baz;

-- sqlfmt-corpus-separator --

FETCH FORWARD 3 FROM foo;

-- sqlfmt-corpus-separator --

FETCH FORWARD 3 foo

-- sqlfmt-corpus-separator --

FETCH FORWARD 5 FROM foo;

-- sqlfmt-corpus-separator --

FETCH FORWARD ALL foo

-- sqlfmt-corpus-separator --

FETCH FORWARD foo

-- sqlfmt-corpus-separator --

FETCH FROM bar;

-- sqlfmt-corpus-separator --

FETCH FROM foo;

-- sqlfmt-corpus-separator --

FETCH foo0;

-- sqlfmt-corpus-separator --

FETCH foo1;

-- sqlfmt-corpus-separator --

FETCH foo;

-- sqlfmt-corpus-separator --

GRANT ALL ON DATABASE multi_region_test_db TO testuser;
ALTER TYPE multi_region_test_db.public.crdb_internal_region OWNER TO testuser

-- sqlfmt-corpus-separator --

GRANT CREATE ON DATABASE alter_db to testuser;
ALTER TABLE alter_db.t OWNER TO testuser

-- sqlfmt-corpus-separator --

INSERT
INTO
  hash_sharded_rbr_computed (region_id, my_uuid, my_uuid2, another_id, row_ts)
VALUES
  ('ap1234', gen_random_uuid(), gen_random_uuid(), 1, TIMESTAMP '2016-01-25 10:10:10.555555')

-- sqlfmt-corpus-separator --

INSERT
INTO
  hash_sharded_rbr_computed (region_id, my_uuid, my_uuid2, another_id, row_ts)
VALUES
  ('east1234', gen_random_uuid(), gen_random_uuid(), 1, TIMESTAMP '2016-01-25 10:10:10.555555')

-- sqlfmt-corpus-separator --

INSERT INTO a VALUES (ARRAY[now()])

-- sqlfmt-corpus-separator --

INSERT INTO a VALUES (ARRAY[uuid_v4()::uuid])

-- sqlfmt-corpus-separator --

INSERT INTO employees (
  crdb_region,
  emp_no,
  birth_date,
  first_name,
  last_name,
  gender,
  hire_date,
  email,
  zip_code
)
  SELECT
    CASE trunc(random() * 10) % 3 WHEN 0 THEN 'ap-southeast-2' WHEN 1 THEN 'ca-central-1' ELSE 'us-east-1' END,
    generate_series(0, 100),
    (now() - trunc(random() * 365)::int * '1 day'::interval - 20 * '1 year'::interval - trunc(random() * 60)::int * '1 year'::interval)::date,
    f_random_text(10),
    f_random_text(10),
    f_random_gender(),
    (now() - trunc(random() * 365)::int * '1 day'::interval - trunc(random() * 10)::int * '1 year'::interval)::date,
    f_random_text(10) || '@cockroachlabs.com',
    f_random_zip_code();

-- sqlfmt-corpus-separator --

INSERT INTO insert_t TABLE select_t ORDER BY v DESC LIMIT 3 RETURNING x, v

-- sqlfmt-corpus-separator --

INSERT INTO kab VALUES (1, gen_random_uuid(), gen_random_uuid())

-- sqlfmt-corpus-separator --

INSERT INTO kab VALUES (2, gen_random_uuid(), gen_random_uuid())

-- sqlfmt-corpus-separator --

INSERT INTO kab VALUES (3, gen_random_uuid(), gen_random_uuid()),
                       (4, gen_random_uuid(), gen_random_uuid()),
                       (5, gen_random_uuid(), gen_random_uuid()),
                       (6, gen_random_uuid(), gen_random_uuid())

-- sqlfmt-corpus-separator --

INSERT INTO kabc VALUES (1, uuid_generate_v4(), uuid_generate_v4())

-- sqlfmt-corpus-separator --

INSERT INTO kabc VALUES (2, uuid_generate_v4(), uuid_generate_v4())

-- sqlfmt-corpus-separator --

INSERT INTO kabc VALUES (3, uuid_generate_v4(), uuid_generate_v4()),
                       (4, uuid_generate_v4(), uuid_generate_v4()),
                       (5, uuid_generate_v4(), uuid_generate_v4()),
                       (6, uuid_generate_v4(), uuid_generate_v4())

-- sqlfmt-corpus-separator --

INSERT INTO kabcd VALUES (1, gen_random_uuid(), uuid_generate_v4())

-- sqlfmt-corpus-separator --

INSERT INTO kabcd VALUES (2, gen_random_uuid(), uuid_generate_v4())

-- sqlfmt-corpus-separator --

INSERT INTO kabcd VALUES (3, gen_random_uuid(), uuid_generate_v4()),
                         (4, gen_random_uuid(), uuid_generate_v4()),
                         (5, gen_random_uuid(), uuid_generate_v4()),
                         (6, gen_random_uuid(), uuid_generate_v4())

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES ('a', transaction_timestamp())

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES ('b', transaction_timestamp());
SELECT * FROM kv;
COMMIT

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (1, cluster_logical_timestamp()-(select mints from m));
SELECT * FROM kv

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (2, cluster_logical_timestamp());
SELECT * FROM kv;
COMMIT

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (2, cluster_logical_timestamp()-(select mints from m));
SELECT * FROM kv

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (3, cluster_logical_timestamp()-(select mints from m));
SELECT * FROM kv

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (4, cluster_logical_timestamp()-(select mints from m));
SELECT * FROM kv

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (5, cluster_logical_timestamp()-(select mints from m));
SELECT * FROM kv

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (6, cluster_logical_timestamp()-(select mints from m));
SELECT * FROM kv

-- sqlfmt-corpus-separator --

INSERT INTO kv VALUES('k', 'v');
COMMIT

-- sqlfmt-corpus-separator --

INSERT INTO kv VALUES('unique_key', 'some value');
INSERT INTO kv VALUES('a', 'c');
INSERT INTO kv VALUES('unique_key2', 'some value');
COMMIT

-- sqlfmt-corpus-separator --

INSERT INTO m VALUES (cluster_logical_timestamp())

-- sqlfmt-corpus-separator --

INSERT INTO orders ("customer_id", "total", "balance", "dispatch_ts", "delivery_ts") VALUES
  ('bdeb232e-12e9-4a33-9dd5-7bb9b694291a', 100, 100, NULL, NULL),
  ('0dc59725-d20b-4370-a05d-11db025a0064', 200, 0, NULL, NULL),
  ('d53d4021-9390-4b3a-9e5a-4bf1ff3e5a4c', 300, 0, now(), NULL),
  ('d53d4021-9390-4b3a-9e5a-4bf1ff3e5a4c', 400, 0, now(), now())

-- sqlfmt-corpus-separator --

INSERT INTO regional_by_row_table (crdb_region, pk, pk2, a, b) VALUES
(gateway_region()::crdb_internal_region, 23, 23, 24, 25)
RETURNING crdb_region, pk

-- sqlfmt-corpus-separator --

INSERT INTO return VALUES (default) RETURNING rowid != unique_rowid()

-- sqlfmt-corpus-separator --

INSERT INTO system.jobs (id, owner, status, job_type)
VALUES (999, 'testuser', 'succeeded', 'INSPECT');
INSERT INTO system.job_info (job_id, info_key, value)
VALUES (
  999,
  'legacy_payload',
  crdb_internal.json_to_pb(
    'cockroach.sql.jobs.jobspb.Payload',
    json_build_object(
      'inspectDetails', json_build_object(
        'checks', json_build_array()
      )
    )
  )
);

-- sqlfmt-corpus-separator --

INSERT INTO t1 SELECT gen_random_uuid(), 'test' FROM generate_series(1, 10)

-- sqlfmt-corpus-separator --

INSERT INTO t2 SELECT gen_random_uuid(), 'test' FROM generate_series(1, 10)

-- sqlfmt-corpus-separator --

INSERT INTO t42992 VALUES (now(), NULL, 2)

-- sqlfmt-corpus-separator --

INSERT INTO t55672_a (a, t) VALUES (2, now())

-- sqlfmt-corpus-separator --

INSERT INTO u VALUES (uuid_v4())

-- sqlfmt-corpus-separator --

INSERT INTO u VALUES (uuid_v4()::uuid)

-- sqlfmt-corpus-separator --

INSERT INTO uniq_uuid (id1, id2) SELECT gen_random_uuid(), '8597b0eb-7b89-4857-858a-fabf86f6a3ac'

-- sqlfmt-corpus-separator --

INSERT INTO uniq_uuid (id1, id2) SELECT gen_random_uuid(), u FROM other

-- sqlfmt-corpus-separator --

INSERT INTO xy VALUES (7, 8), (9, 10);
DECLARE foo CURSOR FOR SELECT * FROM xy ORDER BY x DESC;

-- sqlfmt-corpus-separator --

PREPARE a AS SELECT $1

-- sqlfmt-corpus-separator --

PREPARE a AS SELECT 1

-- sqlfmt-corpus-separator --

PREPARE change_db AS SELECT current_database()

-- sqlfmt-corpus-separator --

PREPARE change_db_2 AS SELECT * FROM othertable

-- sqlfmt-corpus-separator --

PREPARE change_db_3 AS SELECT * from othertable AS t1, test.othertable AS t2

-- sqlfmt-corpus-separator --

PREPARE change_drop AS SELECT * FROM othertable WHERE b=10

-- sqlfmt-corpus-separator --

PREPARE change_loc AS SELECT '2000-01-01 18:05:10.123'::timestamptz

-- sqlfmt-corpus-separator --

PREPARE change_placeholders AS SELECT * FROM othertable WHERE a=$1

-- sqlfmt-corpus-separator --

PREPARE change_privileges AS SELECT * FROM othertable

-- sqlfmt-corpus-separator --

PREPARE change_rename AS SELECT * FROM othertable

-- sqlfmt-corpus-separator --

PREPARE change_schema_uncommitted AS SELECT * FROM othertable

-- sqlfmt-corpus-separator --

PREPARE change_search_path AS SELECT * FROM othertable

-- sqlfmt-corpus-separator --

PREPARE change_view AS SELECT * FROM otherview

-- sqlfmt-corpus-separator --

PREPARE check_custom AS SELECT current_setting('my.custom', true)

-- sqlfmt-corpus-separator --

PREPARE concat_stmt AS SELECT concat("foo"."a", $1::STRING) FROM foo

-- sqlfmt-corpus-separator --

PREPARE concat_stmt2 AS SELECT concat("foo"."a", $1) FROM foo

-- sqlfmt-corpus-separator --

PREPARE concat_stmt3 AS SELECT concat("foo"."a", $1) FROM foo

-- sqlfmt-corpus-separator --

PREPARE del AS DELETE FROM parent WHERE a = $1

-- sqlfmt-corpus-separator --

PREPARE display_appname AS SELECT setting FROM pg_settings WHERE name = 'application_name'

-- sqlfmt-corpus-separator --

PREPARE enum_query AS SELECT x, y FROM greeting_table WHERE y = 2

-- sqlfmt-corpus-separator --

PREPARE fail AS SELECT array_length($1, 1)

-- sqlfmt-corpus-separator --

PREPARE foo AS SELECT $1::INT, f144020();

-- sqlfmt-corpus-separator --

PREPARE forbar AS insert into bar (id) VALUES (1)

-- sqlfmt-corpus-separator --

PREPARE insert_a AS INSERT INTO assn_cast(a) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_a2 AS INSERT INTO assn_cast(a) VALUES (ARRAY[$1])

-- sqlfmt-corpus-separator --

PREPARE insert_a3 AS INSERT INTO assn_cast(a) VALUES (ARRAY[30.12, $1, 32.1])

-- sqlfmt-corpus-separator --

PREPARE insert_c AS INSERT INTO assn_cast(c) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_ca AS INSERT INTO assn_cast(ca) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_d AS INSERT INTO assn_cast(d) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_d2 AS INSERT INTO assn_cast(d) SELECT * FROM (VALUES ($1::DECIMAL(10, 2)))

-- sqlfmt-corpus-separator --

PREPARE insert_f4 AS INSERT INTO assn_cast(f4) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_i AS INSERT INTO assn_cast(i) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_i2 AS INSERT INTO assn_cast(i2) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_qc AS INSERT INTO assn_cast(qc) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_s AS INSERT INTO assn_cast(s) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_vba AS INSERT INTO assn_cast(vba) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE jba_stmt AS SELECT json_build_array(a, $1::STRING) FROM foo;

-- sqlfmt-corpus-separator --

PREPARE jbo_stmt AS SELECT json_build_object('a', a, 'b', $1::STRING) FROM foo;

-- sqlfmt-corpus-separator --

PREPARE loc_dependent_operator AS
SELECT
  extract(EPOCH FROM TIMESTAMP WITH TIME ZONE '2010-11-06 23:59:00-05:00'),
  extract(EPOCH FROM TIMESTAMP WITH TIME ZONE '2010-11-06 23:59:00-05:00' + INTERVAL '1 day')

-- sqlfmt-corpus-separator --

PREPARE new_table_in_search_path AS SELECT typname FROM pg_type

-- sqlfmt-corpus-separator --

PREPARE new_table_in_search_path_2 AS
  SELECT a.typname, b.typname FROM pg_type AS a, pg_catalog.pg_type AS b ORDER BY a.typname, b.typname LIMIT 1

-- sqlfmt-corpus-separator --

PREPARE nn_stmt AS SELECT num_nulls(42, $1::STRING, a, b),
                          num_nulls(b, $1, 42, a),
                          num_nulls(a, b, $1, 42),
                          num_nulls($1, a, b, 42),
                          num_nonnulls(42, $1, a, b),
                          num_nonnulls(b, $1, 42, a),
                          num_nonnulls(a, b, $1, 42),
                          num_nonnulls($1, a, b, 42)
                     FROM nulls_test

-- sqlfmt-corpus-separator --

PREPARE nn_stmt2 AS SELECT num_nulls(42, $1, a, b) FROM nulls_test

-- sqlfmt-corpus-separator --

PREPARE nn_stmt3 AS SELECT num_nulls(42, $1::INT, a) FROM nulls_test

-- sqlfmt-corpus-separator --

PREPARE nn_stmt4 AS SELECT num_nulls(42, $1, a) FROM nulls_test

-- sqlfmt-corpus-separator --

PREPARE p AS
SELECT * FROM (
  SELECT id FROM t155159 WHERE a = $1 AND b >= $2
  ORDER BY b, id
  LIMIT 250
)
UNION
SELECT * FROM (
  SELECT id FROM t155159 WHERE a = $3 AND b >= $4
)

-- sqlfmt-corpus-separator --

PREPARE p AS
SELECT * FROM g
UNION ALL
SELECT * FROM g WHERE a IN ($1, $2) AND b > $3

-- sqlfmt-corpus-separator --

PREPARE p AS
SELECT * FROM g WHERE a = $1 ORDER BY b LIMIT 10

-- sqlfmt-corpus-separator --

PREPARE p AS
SELECT * FROM g WHERE a IN ($1, $2) AND b > $3

-- sqlfmt-corpus-separator --

PREPARE p AS
SELECT t.k, c.k, g.k FROM t
JOIN c ON t.k = c.a
JOIN g ON c.k = g.a
WHERE t.a = $1 AND t.c = $2

-- sqlfmt-corpus-separator --

PREPARE p AS
UPDATE t SET b = 0 WHERE a IN ($1, $2) AND b > $3

-- sqlfmt-corpus-separator --

PREPARE p AS INSERT INTO t147186 (a) VALUES ($1);

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT $1::INT

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT 'foo'::BPCHAR = $1

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT * FROM t WHERE a = $1 AND c = $2

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT * FROM t WHERE a = 1 AND b = 2 AND c = 3

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT * FROM t WHERE k = $1

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT * FROM t WHERE t = now()

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT * FROM xy WHERE x > y

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT * FROM xy WHERE y = $1;

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT f($1::REGCLASS::INT)

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT id FROM t155159 WHERE a = $1 AND b >= $2 ORDER BY b, id LIMIT 250

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT k FROM t WHERE c = $1

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT k FROM t WHERE s LIKE $1

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT k FROM t135151 WHERE a = $1 AND b = $2;

-- sqlfmt-corpus-separator --

PREPARE p0 AS INSERT INTO abcd VALUES ($1, $2, $3, $4)

-- sqlfmt-corpus-separator --

PREPARE p1 AS INSERT INTO abcd VALUES ($1, $2, $3, $4)

-- sqlfmt-corpus-separator --

PREPARE p1 AS INSERT INTO multiple_uniq
VALUES ($1, $1, $1, $1), ($2, $2, $2, $2)

-- sqlfmt-corpus-separator --

PREPARE p1 AS INSERT INTO users2 (name, email)
VALUES ($1, $2), ($3, $4)

-- sqlfmt-corpus-separator --

PREPARE p158945a AS SELECT k FROM t158945 WHERE a = $1

-- sqlfmt-corpus-separator --

PREPARE p158945b AS SELECT k FROM t158945 WHERE a = $1

-- sqlfmt-corpus-separator --

PREPARE p159043 AS
SELECT 1 FROM t159043b CROSS JOIN (SELECT min(1) FROM t159043a LIMIT $1) GROUP BY b

-- sqlfmt-corpus-separator --

PREPARE p159043 AS
SELECT 1 FROM t159043b CROSS JOIN (SELECT min(1) FROM t159043a OFFSET $1) GROUP BY b

-- sqlfmt-corpus-separator --

PREPARE p159124 AS SELECT k FROM t159124 WHERE s = current_user()

-- sqlfmt-corpus-separator --

PREPARE p161993 AS SELECT f161993($1)

-- sqlfmt-corpus-separator --

PREPARE p2 AS INSERT INTO abcd VALUES ($1, $2, $3, $4)

-- sqlfmt-corpus-separator --

PREPARE p3 AS INSERT INTO abcd VALUES ($1, $2, $3, $4)

-- sqlfmt-corpus-separator --

PREPARE p4 AS INSERT INTO abcd VALUES ($1, $2, $3, $4)

-- sqlfmt-corpus-separator --

PREPARE p5 AS INSERT INTO abcd VALUES ($1, $2, $3, $4)

-- sqlfmt-corpus-separator --

PREPARE pg_catalog_query AS SELECT * FROM pg_catalog.pg_sequence

-- sqlfmt-corpus-separator --

PREPARE pscs01 AS SELECT $1::bool, 1

-- sqlfmt-corpus-separator --

PREPARE pscs02 AS SELECT $1::float, 2

-- sqlfmt-corpus-separator --

PREPARE pscs03 AS SELECT $1::decimal, 3

-- sqlfmt-corpus-separator --

PREPARE pscs04 AS SELECT $1::string, 4

-- sqlfmt-corpus-separator --

PREPARE pscs05 AS SELECT $1::json, 5

-- sqlfmt-corpus-separator --

PREPARE pscs06 AS SELECT $1::int, 6

-- sqlfmt-corpus-separator --

PREPARE pscs07 AS SELECT $1::date, 7

-- sqlfmt-corpus-separator --

PREPARE pscs08 AS SELECT $1::timestamp, 8

-- sqlfmt-corpus-separator --

PREPARE pscs09 AS SELECT $1::bool, 9

-- sqlfmt-corpus-separator --

PREPARE pscs10 AS SELECT $1::bytes, 10

-- sqlfmt-corpus-separator --

PREPARE pscs11 AS SELECT $1::smallint, 11

-- sqlfmt-corpus-separator --

PREPARE pscs12 AS SELECT $1::time, 12

-- sqlfmt-corpus-separator --

PREPARE pscs13 AS SELECT $1::bigint, 13

-- sqlfmt-corpus-separator --

PREPARE pscs14 AS SELECT $1::int, 14

-- sqlfmt-corpus-separator --

PREPARE pscs15 AS SELECT $1::timetz, 15

-- sqlfmt-corpus-separator --

PREPARE pscs16 AS SELECT $1::float, 16

-- sqlfmt-corpus-separator --

PREPARE pscs17 AS SELECT $1::interval, 17

-- sqlfmt-corpus-separator --

PREPARE q64765 as SELECT * FROM t64765 WHERE x = $1 AND y = $2

-- sqlfmt-corpus-separator --

PREPARE regression_56193 AS SELECT $1::regclass;
EXECUTE regression_56193('regression_53686"'::regclass)

-- sqlfmt-corpus-separator --

PREPARE regression_71394 AS SELECT ARRAY[$1]::int[];

-- sqlfmt-corpus-separator --

PREPARE s1 AS SELECT * FROM t1 WHERE a=$1

-- sqlfmt-corpus-separator --

PREPARE s2 AS INSERT INTO regional_by_row_table (pk, pk2, a, b) VALUES ($1, $2, $3, $4);

-- sqlfmt-corpus-separator --

PREPARE s4 AS INSERT INTO regional_by_row_table (pk, pk2, a, b) VALUES ($1, $2, $3, $4), ($5, $6, $7, $8);

-- sqlfmt-corpus-separator --

PREPARE s73450_a AS SELECT $1::INT2

-- sqlfmt-corpus-separator --

PREPARE s73450_b AS SELECT $1::CHAR

-- sqlfmt-corpus-separator --

PREPARE s73450_c AS SELECT * FROM t73450 WHERE c = $1::CHAR

-- sqlfmt-corpus-separator --

PREPARE s_114867 AS INSERT INTO test_114867(colors) VALUES (ARRAY[$1::text]::color[]);
EXECUTE s_114867('red')

-- sqlfmt-corpus-separator --

PREPARE selectin AS SELECT 1 in ($1, $2)

-- sqlfmt-corpus-separator --

PREPARE selectin2 AS SELECT $1::int in ($2, $3)

-- sqlfmt-corpus-separator --

PREPARE seqsel AS SELECT * FROM seq

-- sqlfmt-corpus-separator --

PREPARE showOwners AS
  WITH db_id AS (
                SELECT id
                  FROM system.namespace
                 WHERE "parentID" = 0
                   AND "parentSchemaID" = 0
                   AND name = $1
             ),
       entities AS (
                    SELECT ns.id
                      FROM system.namespace AS ns
                      JOIN db_id ON (ns."parentID" = db_id.id)
                ),
      descs AS (
         SELECT crdb_internal.pb_to_json('cockroach.sql.sqlbase.Descriptor', descriptor) AS jdesc
           FROM system.descriptor AS sd
           JOIN entities ON (entities.id = sd.id)
      )
SELECT jdesc->'schema'->>'name' AS schema, jdesc->'schema'->'privileges'->>'ownerProto' AS owner,
       jdesc->'type'->>'name' AS type, jdesc->'type'->'privileges'->>'ownerProto' AS owner,
       jdesc->'table'->>'name' AS object, jdesc->'table'->'privileges'->>'ownerProto' AS owner
       FROM descs
ORDER BY 1,2,3,4,5,6

-- sqlfmt-corpus-separator --

PREPARE subqueryprep AS SELECT * FROM abc WHERE EXISTS(SELECT * FROM xyz WHERE y IN ($1 + 1))

-- sqlfmt-corpus-separator --

PREPARE test_select_statement AS SELECT * FROM types

-- sqlfmt-corpus-separator --

PREPARE tview_prep AS SELECT * FROM tview

-- sqlfmt-corpus-separator --

PREPARE update_a AS UPDATE assn_cast SET a = $1

-- sqlfmt-corpus-separator --

PREPARE update_a2 AS UPDATE assn_cast SET a = ARRAY[$1]

-- sqlfmt-corpus-separator --

PREPARE update_a3 AS UPDATE assn_cast SET a = ARRAY[30.12, $1, 32.1]

-- sqlfmt-corpus-separator --

PREPARE update_c AS UPDATE assn_cast SET c = $1

-- sqlfmt-corpus-separator --

PREPARE update_d AS UPDATE assn_cast SET d = $1

-- sqlfmt-corpus-separator --

PREPARE update_d2 AS UPDATE assn_cast SET d = (SELECT * FROM (VALUES ($1::DECIMAL(10, 2))))

-- sqlfmt-corpus-separator --

PREPARE update_i AS UPDATE assn_cast SET i = $1

-- sqlfmt-corpus-separator --

PREPARE update_i2 AS UPDATE assn_cast SET i2 = $1

-- sqlfmt-corpus-separator --

PREPARE update_privileges AS UPDATE othertable SET b=$1

-- sqlfmt-corpus-separator --

PREPARE update_qc AS UPDATE assn_cast SET qc = $1

-- sqlfmt-corpus-separator --

PREPARE x AS INSERT INTO foo VALUES ($1 COLLATE en_u_ks_level2) RETURNING a

-- sqlfmt-corpus-separator --

PREPARE x AS INSERT INTO kv VALUES ($1, $2) RETURNING NOTHING

-- sqlfmt-corpus-separator --

PREPARE x AS SELECT $1 = (1,2) AS r FROM tb

-- sqlfmt-corpus-separator --

PREPARE x19597 AS SELECT $1 IN ($2, null);

-- sqlfmt-corpus-separator --

PREPARE x21701a AS SELECT * FROM kv WHERE k = $1

-- sqlfmt-corpus-separator --

PREPARE x21701b AS SELECT * FROM kv WHERE k IS DISTINCT FROM $1

-- sqlfmt-corpus-separator --

PREPARE x21701c AS SELECT * FROM kv WHERE k IS NOT DISTINCT FROM $1

-- sqlfmt-corpus-separator --

PREPARE y AS SELECT (1,2) = $1 AS r FROM tb

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY fake_old_role TO new_role

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY old_role TO fake_new_role

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY old_role TO new_role

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY old_role TO testuser

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY old_role, testuser TO new_role

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY root TO testuser

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY testuser TO testuser2

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY testuser TO testuser2;

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY testuser TO v

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY testuser, old_role TO testuser

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY testuser, root TO testuser2

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY testuser2 TO root

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY u TO root

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY u TO testuser

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY u_test_owner TO root;

-- sqlfmt-corpus-separator --

RESET close_cursors_at_commit;
CLOSE ALL;

-- sqlfmt-corpus-separator --

RESET timezone;
-- Check of, tzh, tzm with various zone offsets.
SET timezone = '00:00';
SELECT to_char(now(), 'of') as of_t, to_char(now(), 'tzh:tzm') as "tzh:tzm";

-- sqlfmt-corpus-separator --

RESET timezone; SHOW TIMEZONE

-- sqlfmt-corpus-separator --

REVOKE ALL ON TABLE t FROM testuser;
ALTER TABLE t OWNER TO testuser;

-- sqlfmt-corpus-separator --

REVOKE ALL ON t FROM testuser;
ALTER TABLE t OWNER TO testuser;

-- sqlfmt-corpus-separator --

REVOKE CREATE ON TABLE db.t FROM testuser;
ALTER TABLE db.t OWNER TO testuser

-- sqlfmt-corpus-separator --

REVOKE root FROM testuser;
ALTER DATABASE alter_mr_db OWNER TO testuser

-- sqlfmt-corpus-separator --

REVOKE root FROM testuser;
ALTER TABLE repartition_privs.rbr OWNER TO testuser

-- sqlfmt-corpus-separator --

ROLLBACK

-- sqlfmt-corpus-separator --

ROLLBACK AND CHAIN

-- sqlfmt-corpus-separator --

ROLLBACK TRANSACTION

-- sqlfmt-corpus-separator --

ROLLBACK WORK AND CHAIN

-- sqlfmt-corpus-separator --

ROLLBACK;

-- sqlfmt-corpus-separator --

ROLLBACK;
BEGIN

-- sqlfmt-corpus-separator --

ROLLBACK;
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
DECLARE foo CURSOR FOR SELECT 1;
CLOSE foo

-- sqlfmt-corpus-separator --

ROLLBACK;
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
DECLARE foo CURSOR FOR SELECT 1;
FETCH foo

-- sqlfmt-corpus-separator --

ROLLBACK;
BEGIN;

-- sqlfmt-corpus-separator --

ROLLBACK;
BEGIN;
DECLARE foo CURSOR FOR SELECT * FROM a ORDER BY a

-- sqlfmt-corpus-separator --

ROLLBACK;
BEGIN;
DECLARE foo CURSOR FOR SELECT * FROM doesntexist

-- sqlfmt-corpus-separator --

ROLLBACK; BEGIN

-- sqlfmt-corpus-separator --

ROLLBACK; DROP TABLE table_with_not_null_enum_no_vals; DROP TYPE enum_with_no_vals;

-- sqlfmt-corpus-separator --

SELECT
	*
FROM
	(VALUES (f_102718())) AS t1 (a),
	(VALUES ('foo'), ('bar')) AS t2 (b)
ORDER BY
	t1.a DESC NULLS FIRST;

-- sqlfmt-corpus-separator --

SELECT
	array_agg(t_pk.table_name ORDER BY t_pk.table_name)
FROM
	information_schema.statistics AS i
	LEFT JOIN (
			SELECT
				array_agg(c.column_name) AS table_primary_key_columns,
				c.table_name
			FROM
				information_schema.columns AS c
			GROUP BY
				c.table_name
		)
			AS t_pk ON i.table_name = t_pk.table_name
GROUP BY
	t_pk.table_primary_key_columns

-- sqlfmt-corpus-separator --

SELECT
    *
FROM
    (
        SELECT
            count(1) AS count_1,
            count(lower(col3)) AS count_lower,
            count(upper(col3)) AS count_upper,
            concat_agg(col3 ORDER BY col1) AS concat
        FROM
            tab
        GROUP BY
            upper(col3)
    )
ORDER BY
    concat

-- sqlfmt-corpus-separator --

SELECT
    *
FROM
    (SELECT bill FROM c),
    LATERAL (SELECT row_number() OVER (PARTITION BY bill) AS rownum FROM o WHERE ship = bill)
ORDER BY bill, rownum

-- sqlfmt-corpus-separator --

SELECT
    *
FROM
    (SELECT c_id AS c_c_id, bill FROM c),
    LATERAL (SELECT row_number() OVER () AS rownum FROM o WHERE c_id = c_c_id)
ORDER BY c_c_id, bill, rownum

-- sqlfmt-corpus-separator --

SELECT
    ST_AsText(ST_Rotate(a.geom, pi(), 'POINT (6 3)'::geometry)) as t
FROM geom_operators_test a
ORDER BY t;

-- sqlfmt-corpus-separator --

SELECT
    ST_AsText(a.geom) d,
    ST_AsText(ST_Rotate(a.geom, pi(),4,7))
FROM geom_operators_test a
ORDER BY d;

-- sqlfmt-corpus-separator --

SELECT
    indexname, array_agg(attname ORDER BY rnum), indisunique, indisprimary,
    array_agg(ordering ORDER BY rnum), amname, exprdef, s2.attoptions
FROM (
    SELECT
        c2.relname as indexname, idx.*, attr.attname, am.amname,
        CASE
            WHEN idx.indexprs IS NOT NULL THEN
                pg_get_indexdef(idx.indexrelid)
        END AS exprdef,
        CASE am.amname
            WHEN 'prefix' THEN
                CASE (option & 1)
                    WHEN 1 THEN 'DESC' ELSE 'ASC'
                END
        END as ordering,
        c2.reloptions as attoptions
    FROM (
        SELECT
            row_number() OVER () as rnum, *,
            unnest(i.indkey) as key, unnest(i.indoption) as option
        FROM pg_index i
    ) idx
    LEFT JOIN pg_class c ON idx.indrelid = c.oid
    LEFT JOIN pg_class c2 ON idx.indexrelid = c2.oid
    LEFT JOIN pg_am am ON c2.relam = am.oid
    LEFT JOIN pg_attribute attr ON attr.attrelid = c.oid AND attr.attnum = idx.key
    WHERE c.relname = 'indexes_table'
) s2
GROUP BY indexname, indisunique, indisprimary, amname, exprdef, attoptions
ORDER BY indexname

-- sqlfmt-corpus-separator --

SELECT
    row_number() OVER (PARTITION BY s)
FROM
    (SELECT sum(a) AS s FROM (SELECT a FROM x UNION ALL SELECT a FROM x) GROUP BY a)

-- sqlfmt-corpus-separator --

SELECT
  *
FROM
(
  VALUES
    (
     (('aloha'::TEXT,
     (44)::INT8), NULL)
    ),
    (COALESCE(f117101(), NULL))
);

-- sqlfmt-corpus-separator --

SELECT
  ST_AsText(a.geom) d,
  ST_AsText(ST_Rotate(a.geom, pi())),
  regexp_replace(ST_AsText(ST_Rotate(a.geom, pi()/4)), 'POINT \(0.000000000000001 7.071067811865476\)', 'POINT (0 7.071067811865476)', 'g')
FROM geom_operators_test a
ORDER BY d ASC

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

SELECT
  s_p.nspname AS parentschema,
  t_p.relname AS parenttable,
  unnest(
    (
      SELECT
        array_agg(attname ORDER BY i)
      FROM
        (
          SELECT
            unnest(confkey) AS attnum,
            generate_subscripts(confkey, 1) AS i
        )
          AS x
        JOIN pg_catalog.pg_attribute AS c USING (attnum)
      WHERE
        c.attrelid = fk.confrelid
    )
  )
    AS parentcolumn,
  s_c.nspname AS childschema,
  t_c.relname AS childtable,
  unnest(
    (
      SELECT
        array_agg(attname ORDER BY i)
      FROM
        (
          SELECT
            unnest(conkey) AS attnum,
            generate_subscripts(conkey, 1) AS i
        )
          AS x
        JOIN pg_catalog.pg_attribute AS c USING (attnum)
      WHERE
        c.attrelid = fk.conrelid
    )
  )
    AS childcolumn
FROM
  pg_catalog.pg_constraint AS fk
  JOIN pg_catalog.pg_class AS t_p ON t_p.oid = fk.confrelid
  JOIN pg_catalog.pg_namespace AS s_p ON
      s_p.oid = t_p.relnamespace
  JOIN pg_catalog.pg_class AS t_c ON t_c.oid = fk.conrelid
  JOIN pg_catalog.pg_namespace AS s_c ON
      s_c.oid = t_c.relnamespace
WHERE
  fk.contype = 'f';

-- sqlfmt-corpus-separator --

SELECT "LOWERCASE_HINT_ERROR_IMPLICIT_SCHEMA_FN"();

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

SELECT 'a' AS a, crdb_internal.unary_table() AS b, 'c' AS c LIMIT 1

-- sqlfmt-corpus-separator --

SELECT 'a' AS a, pg_get_keywords() AS b, 'c' AS c LIMIT 1

-- sqlfmt-corpus-separator --

SELECT 'a' AS a, pg_get_keywords(), 'c' AS c LIMIT 1

-- sqlfmt-corpus-separator --

SELECT ('{"a": 1}'::jsonb)[now()]

-- sqlfmt-corpus-separator --

SELECT (1/j) * max(i) * (row_number() OVER (ORDER BY max(i))) FROM (SELECT 1 AS i, 2 AS j) GROUP BY j

-- sqlfmt-corpus-separator --

SELECT (array_agg(i ORDER BY pk))::string FROM intervals

-- sqlfmt-corpus-separator --

SELECT (now(), 2) = (now() :: timestamp, 2) AS r
  FROM tb

-- sqlfmt-corpus-separator --

SELECT (pg_get_keywords()).word FROM t

-- sqlfmt-corpus-separator --

SELECT *
FROM t_48638
WHERE key IN (
  WITH v AS (
    SELECT
      level1.value AS value, level1.key AS level1, level2.key AS level2, level3.key AS level3
    FROM
      t_48638 AS level2
      RIGHT JOIN (SELECT * FROM t_48638 WHERE value = 4) AS level1 ON level1.value = level2.key
      LEFT JOIN (SELECT * FROM t_48638) AS level3 ON level3.key = level2.value
  )
  SELECT v.level1 FROM v WHERE v.level1 IS NOT NULL
  UNION ALL SELECT v.level2 FROM v WHERE v.level2 IS NOT NULL
  UNION ALL SELECT v.level3 FROM v WHERE v.level3 IS NOT NULL
)

-- sqlfmt-corpus-separator --

SELECT * FROM  f_called_by_b2();

-- sqlfmt-corpus-separator --

SELECT * FROM (SELECT n.nspname, c.relname, a.attname, a.atttypid, a.attnotnull OR ((t.typtype = 'd') AND t.typnotnull) AS attnotnull, a.atttypmod, a.attlen, row_number() OVER (PARTITION BY a.attrelid ORDER BY a.attnum) AS attnum, pg_get_expr(def.adbin, def.adrelid) AS adsrc, dsc.description, t.typbasetype, t.typtype FROM pg_catalog.pg_namespace AS n JOIN pg_catalog.pg_class AS c ON (c.relnamespace = n.oid) JOIN pg_catalog.pg_attribute AS a ON (a.attrelid = c.oid) JOIN pg_catalog.pg_type AS t ON (a.atttypid = t.oid) LEFT JOIN pg_catalog.pg_attrdef AS def ON ((a.attrelid = def.adrelid) AND (a.attnum = def.adnum)) LEFT JOIN pg_catalog.pg_description AS dsc ON ((c.oid = dsc.objoid) AND (a.attnum = dsc.objsubid)) LEFT JOIN pg_catalog.pg_class AS dc ON ((dc.oid = dsc.classoid) AND (dc.relname = 'pg_class')) LEFT JOIN pg_catalog.pg_namespace AS dn ON ((dc.relnamespace = dn.oid) AND (dn.nspname = 'pg_catalog')) WHERE (((c.relkind IN ('r', 'v', 'f', 'm')) AND (a.attnum > 0)) AND (NOT a.attisdropped)) AND (n.nspname LIKE 'public')) AS c;

-- sqlfmt-corpus-separator --

SELECT * FROM (SELECT now())

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1), (2)) v(i) JOIN (VALUES (2), (3)) w(j) ON i = p()

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1), (2), (3)) LIMIT p()

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1), (2), (3)) ORDER BY p()

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1), (2), (3)) v(i) GROUP BY i HAVING i > p()

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1), (2), (3)) v(i) WHERE i = p()

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (f_col())) as foo;

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM(generate_series(length((pg_get_keywords()).word),10));

-- sqlfmt-corpus-separator --

SELECT * FROM ab WHERE b = one() + 1

-- sqlfmt-corpus-separator --

SELECT * FROM all_a()

-- sqlfmt-corpus-separator --

SELECT * FROM all_ab()

-- sqlfmt-corpus-separator --

SELECT * FROM all_ab_tuple()

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.tenant_span_stats() LIMIT 0

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.trace_id()

-- sqlfmt-corpus-separator --

SELECT * FROM crdb_internal.validate_multi_region_zone_configs()

-- sqlfmt-corpus-separator --

SELECT * FROM current_schema() WITH ORDINALITY AS a(b)

-- sqlfmt-corpus-separator --

SELECT * FROM display_child() ORDER BY k, child_region

-- sqlfmt-corpus-separator --

SELECT * FROM display_child() ORDER BY k, v, child_region

-- sqlfmt-corpus-separator --

SELECT * FROM display_child() ORDER BY k1, k2, v, child_region

-- sqlfmt-corpus-separator --

SELECT * FROM display_child() ORDER BY v

-- sqlfmt-corpus-separator --

SELECT * FROM display_child() ORDER BY x, y, child_region

-- sqlfmt-corpus-separator --

SELECT * FROM display_child() ORDER BY x, y, z, child_region

-- sqlfmt-corpus-separator --

SELECT * FROM empty()

-- sqlfmt-corpus-separator --

SELECT * FROM f() AS g(bar, baz);

-- sqlfmt-corpus-separator --

SELECT * FROM f() AS g(foo, bar);

-- sqlfmt-corpus-separator --

SELECT * FROM f(), f();

-- sqlfmt-corpus-separator --

SELECT * FROM f();

-- sqlfmt-corpus-separator --

SELECT * FROM f128403();

-- sqlfmt-corpus-separator --

SELECT * FROM f_enum()

-- sqlfmt-corpus-separator --

SELECT * FROM f_imp();

-- sqlfmt-corpus-separator --

SELECT * FROM f_one();

-- sqlfmt-corpus-separator --

SELECT * FROM f_out_asc();

-- sqlfmt-corpus-separator --

SELECT * FROM f_out_desc();

-- sqlfmt-corpus-separator --

SELECT * FROM f_out_int();

-- sqlfmt-corpus-separator --

SELECT * FROM f_setof_imp()

-- sqlfmt-corpus-separator --

SELECT * FROM f_table1();

-- sqlfmt-corpus-separator --

SELECT * FROM f_tup();

-- sqlfmt-corpus-separator --

SELECT * FROM f_udt()

-- sqlfmt-corpus-separator --

SELECT * FROM f_udt();

-- sqlfmt-corpus-separator --

SELECT * FROM fetch_one_then_two()

-- sqlfmt-corpus-separator --

SELECT * FROM generate_series(1, p())

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema._pg_expandarray()

-- sqlfmt-corpus-separator --

SELECT * FROM kv; COMMIT; BEGIN; UPDATE kv SET v = 'd' WHERE k in ('a')

-- sqlfmt-corpus-separator --

SELECT * FROM kv; UPDATE kv SET v = 'c' WHERE k in ('a'); COMMIT

-- sqlfmt-corpus-separator --

SELECT * FROM mixed_type_a AS a JOIN mixed_type_b AS b ON a.a = b.a AND a.b < (now() - b.b)

-- sqlfmt-corpus-separator --

SELECT * FROM one()

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_class c WHERE nonexistent_function()

-- sqlfmt-corpus-separator --

SELECT * FROM pg_get_keywords() WHERE word IN ('alter', 'and', 'between', 'cross') ORDER BY word

-- sqlfmt-corpus-separator --

SELECT * FROM priv_f()

-- sqlfmt-corpus-separator --

SELECT * FROM priv_f_definer() ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE y = 10 AND divbyzero() = 1;

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE y = 20 AND divbyzero() = 1;

-- sqlfmt-corpus-separator --

SELECT * FROM t44726 WHERE 0 > (CASE WHEN nullif(NULL, ilike_escape('', current_user(), '')) THEN 0 ELSE t44726.c0 END)

-- sqlfmt-corpus-separator --

SELECT * FROM t95615, LATERAL ROWS FROM (f95615(), f95615()) WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT * FROM v44203 WHERE current_user() != ''

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT (random() * 0.0)::int OFFSET (random() * 0.0)::int

-- sqlfmt-corpus-separator --

SELECT * from kv; ROLLBACK

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

SELECT *, one() FROM ab WHERE a = one()

-- sqlfmt-corpus-separator --

SELECT *, one() FROM ab WHERE b = one()

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

SELECT 1 IN (all_a())

-- sqlfmt-corpus-separator --

SELECT 1; DECLARE foo CURSOR FOR SELECT * FROM a

-- sqlfmt-corpus-separator --

SELECT ARRAY['a', 'b', 'c'][:]

-- sqlfmt-corpus-separator --

SELECT ARRAY[rbr(),rbr()]

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz ORDER BY row_number() OVER(ORDER BY (pk1, pk2)) DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT(database_id) FROM crdb_internal.tenant_span_stats()

-- sqlfmt-corpus-separator --

SELECT EXTRACT(YEAR FROM x) FROM extract_test

-- sqlfmt-corpus-separator --

SELECT PostGIS_Extensions_Upgrade()

-- sqlfmt-corpus-separator --

SELECT PostGIS_Full_Version()

-- sqlfmt-corpus-separator --

SELECT PostGIS_GEOS_Version()

-- sqlfmt-corpus-separator --

SELECT PostGIS_LibXML_Version()

-- sqlfmt-corpus-separator --

SELECT PostGIS_Lib_Build_Date()

-- sqlfmt-corpus-separator --

SELECT PostGIS_Lib_Version()

-- sqlfmt-corpus-separator --

SELECT PostGIS_Liblwgeom_Version()

-- sqlfmt-corpus-separator --

SELECT PostGIS_PROJ_Version()

-- sqlfmt-corpus-separator --

SELECT PostGIS_Scripts_Build_Date()

-- sqlfmt-corpus-separator --

SELECT PostGIS_Scripts_Installed()

-- sqlfmt-corpus-separator --

SELECT PostGIS_Scripts_Released()

-- sqlfmt-corpus-separator --

SELECT PostGIS_Version()

-- sqlfmt-corpus-separator --

SELECT PostGIS_Wagyu_Version()

-- sqlfmt-corpus-separator --

SELECT ST_AsEWKT(ST_Affine(the_geom, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, pi()/2, pi()), 3)
	FROM (SELECT ST_GeomFromEWKT('LINESTRING(1 2 3, 4 5 6, 7 8 9)') AS the_geom) AS _;

-- sqlfmt-corpus-separator --

SELECT ST_AsEWKT(ST_RotateX(ST_GeomFromEWKT('LINESTRING(1 2 3, 1 1 1)'), pi()/2));

-- sqlfmt-corpus-separator --

SELECT ST_AsEWKT(ST_RotateY(ST_GeomFromEWKT('LINESTRING(1 2 3, 1 1 1)'), pi()/2));

-- sqlfmt-corpus-separator --

SELECT ST_AsEWKT(ST_RotateZ(ST_GeomFromEWKT('LINESTRING(1 2 3, 1 1 1)'), pi()/2));

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_Collect(geom ORDER BY geom)) FROM geo_table

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_MakeLine(geom ORDER BY geom)) FROM geo_table

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_MemCollect(geom ORDER BY geom)) FROM geo_table

-- sqlfmt-corpus-separator --

SELECT a FROM f_udt()

-- sqlfmt-corpus-separator --

SELECT a FROM sub_all WHERE sub_max_odd() = (SELECT max(a) FROM sub_odd)

-- sqlfmt-corpus-separator --

SELECT a, b <= now(), c = -1.0, d <= now() FROM t WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT a, b <= now(), c >= 0.0, d <= now() FROM t

-- sqlfmt-corpus-separator --

SELECT a, b <= now(), c >= 0.0, d <= now() FROM t WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT a, b <= now(), c >= 0.0, d <= now() FROM t WHERE a = 2

-- sqlfmt-corpus-separator --

SELECT a, b, c, cume_dist() OVER (PARTITION BY a ORDER BY c) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, c, dense_rank() OVER (PARTITION BY a ORDER BY c) FROM t

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

SELECT a, count(*) AS cnt FROM smalldata GROUP BY a HAVING crdb_internal.reset_sql_stats() ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, sub_max_odd() FROM sub_all WHERE a = sub_max_odd()

-- sqlfmt-corpus-separator --

SELECT a, sub_two() FROM sub_all

-- sqlfmt-corpus-separator --

SELECT a,b FROM add_default WHERE current_timestamp > c AND current_timestamp() - c < interval '20s'

-- sqlfmt-corpus-separator --

SELECT a.*, b.*, c.* FROM generate_series(1,1) a, unnest(ARRAY[1]) b, pg_get_keywords() c LIMIT 0

-- sqlfmt-corpus-separator --

SELECT abs(p())

-- sqlfmt-corpus-separator --

SELECT abs(sin(pi())) < 1e-12

-- sqlfmt-corpus-separator --

SELECT age('1957-06-13') - age(now(), '1957-06-13') = interval '0s'

-- sqlfmt-corpus-separator --

SELECT all_a_lt(all_a())

-- sqlfmt-corpus-separator --

SELECT array_agg((k, v) ORDER BY (k+1, v||'foo') NULLS FIRST) FROM nulls_last_test;

-- sqlfmt-corpus-separator --

SELECT array_agg((k, v) ORDER BY (k+1, v||'foo') NULLS LAST) FROM nulls_last_test;

-- sqlfmt-corpus-separator --

SELECT array_agg((k, v) ORDER BY (k+1, v||'foo')) FROM nulls_last_test;

-- sqlfmt-corpus-separator --

SELECT array_agg((k, v) ORDER BY (k, v) NULLS FIRST) FROM nulls_last_test

-- sqlfmt-corpus-separator --

SELECT array_agg((k, v) ORDER BY (k, v) NULLS LAST) FROM nulls_last_test

-- sqlfmt-corpus-separator --

SELECT array_agg((k, v) ORDER BY (k, v)) FROM nulls_last_test

-- sqlfmt-corpus-separator --

SELECT array_agg(ROW(k,v) ORDER BY k) FROM kv

-- sqlfmt-corpus-separator --

SELECT array_agg(a) FROM all_a_desc() g(a)

-- sqlfmt-corpus-separator --

SELECT array_agg(bar ORDER BY pk) FROM foo

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1), array_agg(col1 ORDER BY col1) FILTER (WHERE col1 < 0) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1), array_agg(col1 ORDER BY col2, col1), array_agg(col1 ORDER BY col3, col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1), array_agg(col1 ORDER BY col2, col1), col3 FROM tab GROUP BY col3 ORDER BY col3

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1), array_agg(col1 ORDER BY col2, col1), count(col3), count(*) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col2) FROM TAB

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col2*100+col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col3, col1) FILTER (WHERE col1 < 0), array_agg(col1 ORDER BY col3, col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(f) FROM f_agg() AS f;

-- sqlfmt-corpus-separator --

SELECT array_agg(f) FROM f_out_for_agg() AS f;

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY id NULLS LAST) FROM nulls_last_test

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY id) FROM nulls_last_test

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY id)::STRING, st_asmvt(NULL, NULL)::STRING FROM mvt_win_test

-- sqlfmt-corpus-separator --

SELECT array_agg(v ORDER BY k) FROM kv_enum

-- sqlfmt-corpus-separator --

SELECT array_agg(x ORDER BY x) FROM t;

-- sqlfmt-corpus-separator --

SELECT array_agg(y ORDER BY y) FROM t;

-- sqlfmt-corpus-separator --

SELECT array_cat_agg(arr ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_cat_agg(arr ORDER BY col2*100+col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_cat_agg(arr ORDER BY k), array_cat_agg(NULL::INT[]), array_cat_agg('{NULL, NULL}'::INT[]) FROM kv WHERE arr IS NOT NULL

-- sqlfmt-corpus-separator --

SELECT array_to_string(array_agg(i ORDER BY pk), ' ') FROM intervals

-- sqlfmt-corpus-separator --

SELECT avg(k), max(v), min(w), 2 + row_number() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT b > now() - interval '1 day'  FROM mixed_type_a

-- sqlfmt-corpus-separator --

SELECT b FROM f_udt()

-- sqlfmt-corpus-separator --

SELECT b, empty() FROM ab

-- sqlfmt-corpus-separator --

SELECT c, lastval() FROM t

-- sqlfmt-corpus-separator --

SELECT c, lastval() from t

-- sqlfmt-corpus-separator --

SELECT cast_to_enum()

-- sqlfmt-corpus-separator --

SELECT clock_timestamp() - statement_timestamp() < interval '10s'

-- sqlfmt-corpus-separator --

SELECT cluster_logical_timestamp();

-- sqlfmt-corpus-separator --

SELECT cluster_logical_timestamp(); INSERT INTO test_retry VALUES (1);

-- sqlfmt-corpus-separator --

SELECT concat() || 'empty'

-- sqlfmt-corpus-separator --

SELECT concat_agg(col3 ORDER BY col1 DESC) FROM tab

-- sqlfmt-corpus-separator --

SELECT concat_agg(col3 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT concat_ws()

-- sqlfmt-corpus-separator --

SELECT count(*) = 1 FROM crdb_internal.trace_id()

-- sqlfmt-corpus-separator --

SELECT count(*) FROM system.comments WHERE type = 5 AND object_id = (
  SELECT table_id FROM crdb_internal.tables
  WHERE name = 't_constraints' AND schema_name = 'public' AND database_name = current_database()
);

-- sqlfmt-corpus-separator --

SELECT count(1), concat_agg(col3 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT count_rows() FROM generate_series(1,100)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.active_version()->'internal'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.approximate_timestamp(crdb_internal_mvcc_timestamp) < now() FROM t

-- sqlfmt-corpus-separator --

SELECT crdb_internal.await_statement_hints_cache()

-- sqlfmt-corpus-separator --

SELECT crdb_internal.check_consistency(true, '\x00', crdb_internal.tenant_span()[2])

-- sqlfmt-corpus-separator --

SELECT crdb_internal.check_consistency(true, crdb_internal.tenant_span()[1], '\xffff00')

-- sqlfmt-corpus-separator --

SELECT crdb_internal.check_consistency(true, crdb_internal.tenant_span()[2], crdb_internal.tenant_span()[2])

-- sqlfmt-corpus-separator --

SELECT crdb_internal.clear_query_plan_cache();

-- sqlfmt-corpus-separator --

SELECT crdb_internal.clear_statement_hints_cache()

-- sqlfmt-corpus-separator --

SELECT crdb_internal.clear_table_stats_cache();

-- sqlfmt-corpus-separator --

SELECT crdb_internal.fingerprint(ARRAY['\\x8989', NULL]::BYTES[], now(), false);

-- sqlfmt-corpus-separator --

SELECT crdb_internal.fingerprint(ARRAY[NULL, NULL]::BYTES[], now(), false);

-- sqlfmt-corpus-separator --

SELECT crdb_internal.fips_ready()

-- sqlfmt-corpus-separator --

SELECT crdb_internal.node_id()

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

SELECT crdb_internal.release_series(crdb_internal.node_executable_version())

-- sqlfmt-corpus-separator --

SELECT crdb_internal.release_series(crdb_internal.node_executable_version()) = '$origver'

-- sqlfmt-corpus-separator --

SELECT crdb_internal.revalidate_unique_constraints_in_all_tables()

-- sqlfmt-corpus-separator --

SELECT crdb_internal.tenant_span()

-- sqlfmt-corpus-separator --

SELECT crdb_internal.update_tenant_resource_limits(13, 1000, 100, 0, now(), 0)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.update_tenant_resource_limits(5, 1000, 100, 0, now(), 0)

-- sqlfmt-corpus-separator --

SELECT crdb_internal.validate_multi_region_zone_configs()

-- sqlfmt-corpus-separator --

SELECT crdb_internal.validate_ttl_scheduled_jobs()

-- sqlfmt-corpus-separator --

SELECT crdb_internal.void_func()

-- sqlfmt-corpus-separator --

SELECT current_date - current_date() = 0

-- sqlfmt-corpus-separator --

SELECT current_schema()

-- sqlfmt-corpus-separator --

SELECT current_schemas()

-- sqlfmt-corpus-separator --

SELECT current_user()

-- sqlfmt-corpus-separator --

SELECT current_user(), current_user, session_user(), session_user

-- sqlfmt-corpus-separator --

SELECT current_user, current_user(), session_user, session_user(), user

-- sqlfmt-corpus-separator --

SELECT default_to_database_primary_region(gateway_region())

-- sqlfmt-corpus-separator --

SELECT defaults()

-- sqlfmt-corpus-separator --

SELECT del()

-- sqlfmt-corpus-separator --

SELECT empty_result()

-- sqlfmt-corpus-separator --

SELECT extract('DAY' from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract('EPOCH' from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract('day' from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract('microsecond' from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(day from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract(epoch from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract(epoch from timetz '12:00:00+04')

-- sqlfmt-corpus-separator --

SELECT extract(hour FROM '2001-01-01 13:00:00'::timestamp)

-- sqlfmt-corpus-separator --

SELECT extract(hour FROM '2001-01-01 13:00:00+01'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(hour from '2016-02-10 19:46:33.306157519-04'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(hour from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(hour from timetz '12:01:02.345678-07')

-- sqlfmt-corpus-separator --

SELECT extract(hours from '2016-02-10 19:46:33.306157519-04'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(microsecond from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(microsecond from timetz '12:01:02.345678-05')

-- sqlfmt-corpus-separator --

SELECT extract(millisecond from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(millisecond from timetz '12:01:02.345678+00')

-- sqlfmt-corpus-separator --

SELECT extract(minute from interval '10:55:01.456')

-- sqlfmt-corpus-separator --

SELECT extract(minute from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(minute from timetz '12:01:02.345678+03')

-- sqlfmt-corpus-separator --

SELECT extract(nansecond from '2001-04-10 12:04:59.34565423'::timestamp)

-- sqlfmt-corpus-separator --

SELECT extract(nansecond from '2001-04-10 12:04:59.34565423'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(second from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(second from timetz '12:01:02.345678-06')

-- sqlfmt-corpus-separator --

SELECT extract(timezone FROM '2001-01-01 13:00:00+01:15'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT f()

-- sqlfmt-corpus-separator --

SELECT f(), f(True), f('foo'::TEXT);

-- sqlfmt-corpus-separator --

SELECT f();

-- sqlfmt-corpus-separator --

SELECT f();
SELECT f(1);
SELECT f(1, ARRAY[100]);
SELECT f(True, ARRAY[False]);

-- sqlfmt-corpus-separator --

SELECT f1();

-- sqlfmt-corpus-separator --

SELECT f100923() FROM (VALUES (10), (20)) v(i)

-- sqlfmt-corpus-separator --

SELECT f104927()

-- sqlfmt-corpus-separator --

SELECT f108297()

-- sqlfmt-corpus-separator --

SELECT f114826();

-- sqlfmt-corpus-separator --

SELECT f131354();

-- sqlfmt-corpus-separator --

SELECT f138273_2();

-- sqlfmt-corpus-separator --

SELECT f144321();

-- sqlfmt-corpus-separator --

SELECT f145098();

-- sqlfmt-corpus-separator --

SELECT f146414()

-- sqlfmt-corpus-separator --

SELECT f2();

-- sqlfmt-corpus-separator --

SELECT f93083()

-- sqlfmt-corpus-separator --

SELECT f96326();

-- sqlfmt-corpus-separator --

SELECT f_93314();

-- sqlfmt-corpus-separator --

SELECT f_93314_alias();

-- sqlfmt-corpus-separator --

SELECT f_93314_comp()

-- sqlfmt-corpus-separator --

SELECT f_93314_comp_t()

-- sqlfmt-corpus-separator --

SELECT f_97130();

-- sqlfmt-corpus-separator --

SELECT f_allcolsel()

-- sqlfmt-corpus-separator --

SELECT f_allcolsel_alias()

-- sqlfmt-corpus-separator --

SELECT f_arr();

-- sqlfmt-corpus-separator --

SELECT f_check_colerr_len()

-- sqlfmt-corpus-separator --

SELECT f_check_colerr_null();

-- sqlfmt-corpus-separator --

SELECT f_check_len()

-- sqlfmt-corpus-separator --

SELECT f_check_null();

-- sqlfmt-corpus-separator --

SELECT f_checkb();

-- sqlfmt-corpus-separator --

SELECT f_col();

-- sqlfmt-corpus-separator --

SELECT f_const();

-- sqlfmt-corpus-separator --

SELECT f_cursor()

-- sqlfmt-corpus-separator --

SELECT f_delete();

-- sqlfmt-corpus-separator --

SELECT f_empty()

-- sqlfmt-corpus-separator --

SELECT f_exprstar()

-- sqlfmt-corpus-separator --

SELECT f_insert();

-- sqlfmt-corpus-separator --

SELECT f_kv_predicate()

-- sqlfmt-corpus-separator --

SELECT f_multitable();

-- sqlfmt-corpus-separator --

SELECT f_multituple();

-- sqlfmt-corpus-separator --

SELECT f_one();

-- sqlfmt-corpus-separator --

SELECT f_out_asc();

-- sqlfmt-corpus-separator --

SELECT f_out_desc();

-- sqlfmt-corpus-separator --

SELECT f_out_int();

-- sqlfmt-corpus-separator --

SELECT f_row();

-- sqlfmt-corpus-separator --

SELECT f_rtbl();

-- sqlfmt-corpus-separator --

SELECT f_scalar();

-- sqlfmt-corpus-separator --

SELECT f_select();

-- sqlfmt-corpus-separator --

SELECT f_seq_qualified_name()

-- sqlfmt-corpus-separator --

SELECT f_seq_qualified_name_quoted()

-- sqlfmt-corpus-separator --

SELECT f_setof();

-- sqlfmt-corpus-separator --

SELECT f_subquery()

-- sqlfmt-corpus-separator --

SELECT f_table();

-- sqlfmt-corpus-separator --

SELECT f_tup();

-- sqlfmt-corpus-separator --

SELECT f_tuple();

-- sqlfmt-corpus-separator --

SELECT f_udt()

-- sqlfmt-corpus-separator --

SELECT f_udt_rewrite()

-- sqlfmt-corpus-separator --

SELECT f_unindexed_predicate()

-- sqlfmt-corpus-separator --

SELECT f_unnamed();

-- sqlfmt-corpus-separator --

SELECT f_unqualified_onecol()

-- sqlfmt-corpus-separator --

SELECT f_unqualified_twocol()

-- sqlfmt-corpus-separator --

SELECT f_update();

-- sqlfmt-corpus-separator --

SELECT f_using_multi();

-- sqlfmt-corpus-separator --

SELECT f_using_self_join();

-- sqlfmt-corpus-separator --

SELECT f_using_udf()

-- sqlfmt-corpus-separator --

SELECT f_using_udf_2();

-- sqlfmt-corpus-separator --

SELECT f_void();

-- sqlfmt-corpus-separator --

SELECT foo.bar()

-- sqlfmt-corpus-separator --

SELECT format();

-- sqlfmt-corpus-separator --

SELECT g();

-- sqlfmt-corpus-separator --

SELECT gateway_region()

-- sqlfmt-corpus-separator --

SELECT gateway_region();

-- sqlfmt-corpus-separator --

SELECT get_db_survival_goal()

-- sqlfmt-corpus-separator --

SELECT get_min_t0();

-- sqlfmt-corpus-separator --

SELECT get_secret_data()
UNION
SELECT id FROM secret_data;

-- sqlfmt-corpus-separator --

SELECT get_secret_data();

-- sqlfmt-corpus-separator --

SELECT get_t();

-- sqlfmt-corpus-separator --

SELECT get_t_nested();

-- sqlfmt-corpus-separator --

SELECT get_top_secret_data();

-- sqlfmt-corpus-separator --

SELECT getdatabaseencoding()

-- sqlfmt-corpus-separator --

SELECT i, fetch_one_then_two()
FROM (VALUES (1), (2), (3)) AS v(i)
WHERE i = fetch_one_then_two()

-- sqlfmt-corpus-separator --

SELECT i, random() FROM ROWS FROM (generate_series(1, 5)) AS i ORDER by i

-- sqlfmt-corpus-separator --

SELECT i.relname AS name,
       ix.indisprimary AS PRIMARY,
       ix.indisunique AS UNIQUE,
       ix.indkey AS indkey,
       array_agg(a.attnum ORDER BY a.attnum) AS column_indexes,
       array_agg(a.attname ORDER BY a.attnum) AS column_names,
       pg_get_indexdef(ix.indexrelid) AS definition
FROM pg_class t,
     pg_class i,
     pg_index ix,
     pg_attribute a
WHERE t.oid = ix.indrelid
AND   i.oid = ix.indexrelid
AND   a.attrelid = t.oid
AND   t.relkind = 'r'
AND   t.relname = 'customers' -- this query is run once for each table
GROUP BY i.relname,
         ix.indexrelid,
         ix.indisprimary,
         ix.indisunique,
         ix.indkey
ORDER BY i.relname

-- sqlfmt-corpus-separator --

SELECT imp(), (1,2,'a')::imp = imp()

-- sqlfmt-corpus-separator --

SELECT imp_cast(), (1,2,'3') = imp_cast(), pg_typeof(imp_cast())

-- sqlfmt-corpus-separator --

SELECT imp_const(), (11,22,'b')::imp = imp_const(), pg_typeof(imp_const())

-- sqlfmt-corpus-separator --

SELECT imp_const_cast(), (11,22,'b')::imp = imp_const_cast(), pg_typeof(imp_const_cast())

-- sqlfmt-corpus-separator --

SELECT imp_const_tup(), (11,22,'b')::imp = imp_const_tup(), pg_typeof(imp_const_tup())

-- sqlfmt-corpus-separator --

SELECT imp_const_unnamed(), (11,22,'b')::imp = imp_const_unnamed(), pg_typeof(imp_const_unnamed())

-- sqlfmt-corpus-separator --

SELECT imp_ordered(), (100,200,'z')::imp = imp_ordered()

-- sqlfmt-corpus-separator --

SELECT imp_star(), (1,2,'a')::imp = imp_star()

-- sqlfmt-corpus-separator --

SELECT imp_tup(), (1,2,'a')::imp = imp_tup()

-- sqlfmt-corpus-separator --

SELECT imp_tup_ordered(), (100,200,'z')::imp = imp_tup_ordered()

-- sqlfmt-corpus-separator --

SELECT index_rec, (
    SELECT array_agg(n ORDER BY n)
    FROM unnest(fingerprint_ids) AS n
  ) AS sorted_fp
FROM workload_index_recs('2023-07-05 15:10:10+00:00'::TIMESTAMPTZ - '2 weeks'::interval) order by index_rec;

-- sqlfmt-corpus-separator --

SELECT index_rec, (
    SELECT array_agg(n ORDER BY n)
    FROM unnest(fingerprint_ids) AS n
  ) AS sorted_fp
FROM workload_index_recs() order by index_rec;

-- sqlfmt-corpus-separator --

SELECT information_schema._pg_expandarray()

-- sqlfmt-corpus-separator --

SELECT ins()

-- sqlfmt-corpus-separator --

SELECT ins2()

-- sqlfmt-corpus-separator --

SELECT json_agg(col1 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT json_agg(v ORDER BY v) FROM t115054_1

-- sqlfmt-corpus-separator --

SELECT json_agg(v ORDER BY v) FROM t115054_2

-- sqlfmt-corpus-separator --

SELECT json_build_array()

-- sqlfmt-corpus-separator --

SELECT json_build_object()

-- sqlfmt-corpus-separator --

SELECT json_build_object(b.name, json_object_agg(p.property_name, p.property_value ORDER BY p.property_value))
FROM blog b, blog_properties p WHERE b.id = p.blog_id
GROUP BY b.name

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(col1 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(col1 ORDER BY col2, col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array()

-- sqlfmt-corpus-separator --

SELECT k FROM kv where v = transaction_timestamp()

-- sqlfmt-corpus-separator --

SELECT k, cume_dist() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, dense_rank() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, percent_rank() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, rank() FILTER (WHERE k=1) OVER () FROM kv

-- sqlfmt-corpus-separator --

SELECT k, rank() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, row_number() OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, row_number() OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, cume_dist() OVER (PARTITION BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, dense_rank() OVER (PARTITION BY v) FROM kv ORDER BY 1

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

SELECT lastval()

-- sqlfmt-corpus-separator --

SELECT lastval();

-- sqlfmt-corpus-separator --

SELECT length(crdb_internal.cluster_name()) > 0

-- sqlfmt-corpus-separator --

SELECT length(gen_random_ulid()::BYTES), gen_random_ulid() = gen_random_ulid()

-- sqlfmt-corpus-separator --

SELECT length(gen_random_uuid()::BYTES), gen_random_uuid() = gen_random_uuid()

-- sqlfmt-corpus-separator --

SELECT max(i) * (1/j) * (row_number() OVER (ORDER BY max(i))) FROM (SELECT 1 AS i, 2 AS j) GROUP BY j

-- sqlfmt-corpus-separator --

SELECT max(i) * (row_number() OVER (ORDER BY max(i))) FROM (SELECT 1 AS i, 2 AS j) GROUP BY j

-- sqlfmt-corpus-separator --

SELECT max_in_values()

-- sqlfmt-corpus-separator --

SELECT my_non_sec_definer_reader_function()

-- sqlfmt-corpus-separator --

SELECT my_non_sec_definer_reader_function();
-----

-- sqlfmt-corpus-separator --

SELECT my_sec_definer_reader_function();

-- sqlfmt-corpus-separator --

SELECT my_sum();

-- sqlfmt-corpus-separator --

SELECT name, statement, is_scrollable, is_holdable, is_binary, now() - creation_time < '1 second'::interval FROM pg_catalog.pg_cursors

-- sqlfmt-corpus-separator --

SELECT now()

-- sqlfmt-corpus-separator --

SELECT now() + '1m'::interval > now(), now() + '1m'::interval >= now()

-- sqlfmt-corpus-separator --

SELECT now() - current_date()::timestamptz < interval '24h10s'

-- sqlfmt-corpus-separator --

SELECT now() - current_timestamp = interval '0s'

-- sqlfmt-corpus-separator --

SELECT now() - current_timestamp() = interval '0s'

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

SELECT now() > '2024-06-21 19:04:25.625514+00'

-- sqlfmt-corpus-separator --

SELECT now() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT now()::timestamp - now(), now() - now()::timestamp

-- sqlfmt-corpus-separator --

SELECT now()::timestamp < now(), now() < now()::timestamp

-- sqlfmt-corpus-separator --

SELECT now()::timestamp <= now(), now() <= now()::timestamp

-- sqlfmt-corpus-separator --

SELECT nth_value(1, i) OVER (ORDER BY p()) FROM (VALUES (1), (2)) v(i)

-- sqlfmt-corpus-separator --

SELECT nth_value(1, p()) OVER () FROM (VALUES (1), (2))

-- sqlfmt-corpus-separator --

SELECT one()

-- sqlfmt-corpus-separator --

SELECT p()

-- sqlfmt-corpus-separator --

SELECT pg_catalog.defaults()

-- sqlfmt-corpus-separator --

SELECT pg_catalog.inet_client_addr(), pg_catalog.inet_client_port(), pg_catalog.inet_server_addr(), pg_catalog.inet_server_port()
FROM pg_class
WHERE relname = 'pg_constraint'

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_client_encoding()

-- sqlfmt-corpus-separator --

SELECT pg_is_in_recovery()

-- sqlfmt-corpus-separator --

SELECT pg_is_xlog_replay_paused()

-- sqlfmt-corpus-separator --

SELECT pg_my_temp_schema()

-- sqlfmt-corpus-separator --

SELECT pg_my_temp_schema()::TEXT LIKE 'pg_temp_%'

-- sqlfmt-corpus-separator --

SELECT pg_trigger_depth();

-- sqlfmt-corpus-separator --

SELECT pi()

-- sqlfmt-corpus-separator --

SELECT position('\x616263'::bytea in 'abc'::bytea)

-- sqlfmt-corpus-separator --

SELECT position('a' in 'high')

-- sqlfmt-corpus-separator --

SELECT position('ig' in 'high')

-- sqlfmt-corpus-separator --

SELECT position(B'100' in B'100101')

-- sqlfmt-corpus-separator --

SELECT pow(CAST (pi() AS DECIMAL), DECIMAL '2.0')

-- sqlfmt-corpus-separator --

SELECT public."LOWERCASE_HINT_ERROR_EXPLICIT_SCHEMA_FN"();

-- sqlfmt-corpus-separator --

SELECT public.now()

-- sqlfmt-corpus-separator --

SELECT qux();

-- sqlfmt-corpus-separator --

SELECT rand_v(), rand_v() FROM generate_series(1, 3)

-- sqlfmt-corpus-separator --

SELECT random() * 0.0

-- sqlfmt-corpus-separator --

SELECT random() from t51841

-- sqlfmt-corpus-separator --

SELECT random_normal() IS NOT NULL, random_normal(0, 1) IS NOT NULL

-- sqlfmt-corpus-separator --

SELECT rank() FROM kv

-- sqlfmt-corpus-separator --

SELECT rbr()

-- sqlfmt-corpus-separator --

SELECT sc1.f_seq()

-- sqlfmt-corpus-separator --

SELECT sc1.f_type()

-- sqlfmt-corpus-separator --

SELECT sc1_new.f_seq()

-- sqlfmt-corpus-separator --

SELECT sc1_new.f_type()

-- sqlfmt-corpus-separator --

SELECT sc2.f_seq()

-- sqlfmt-corpus-separator --

SELECT sc2.f_type()

-- sqlfmt-corpus-separator --

SELECT sel()

-- sqlfmt-corpus-separator --

SELECT somefunc();

-- sqlfmt-corpus-separator --

SELECT st_asewkt(st_rotate('LINESTRING (1 5, 5 1)'::geometry,pi()/4,'POINT EMPTY'::geometry))

-- sqlfmt-corpus-separator --

SELECT st_asmvt(NULL, NULL), array_agg(a ORDER BY a) FROM mvt_null_test

-- sqlfmt-corpus-separator --

SELECT status, regexp_replace(detail, '[0-9-]+', '', 'g')
FROM crdb_internal.check_consistency(true, crdb_internal.tenant_span()[1], crdb_internal.tenant_span()[2])
ORDER BY range_id
LIMIT 1

-- sqlfmt-corpus-separator --

SELECT string_agg(col3, ', ' ORDER BY col3 DESC) FROM tab

-- sqlfmt-corpus-separator --

SELECT string_agg(col3, ', ' ORDER BY col3) FROM tab

-- sqlfmt-corpus-separator --

SELECT strpos(version(), 'CockroachDB')

-- sqlfmt-corpus-separator --

SELECT sub_first(), a FROM sub_all

-- sqlfmt-corpus-separator --

SELECT sub_max_odd_with_order_by()

-- sqlfmt-corpus-separator --

SELECT substr(uuid_generate_v1()::TEXT, 24) = substr(uuid_generate_v1()::TEXT, 24)

-- sqlfmt-corpus-separator --

SELECT substr(uuid_generate_v1mc()::TEXT, 24) = substr(uuid_generate_v1mc()::TEXT, 24)

-- sqlfmt-corpus-separator --

SELECT t.typname enum_name, array_agg(e.enumlabel ORDER BY enumsortorder) enum_value
    FROM pg_type t
    JOIN pg_enum e ON t.oid = e.enumtypid
    JOIN pg_catalog.pg_namespace n ON n.oid = t.typnamespace
    WHERE n.nspname = 'public'
    GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT t_update()

-- sqlfmt-corpus-separator --

SELECT to_char_with_style(now()::date, 'postgres')

-- sqlfmt-corpus-separator --

SELECT to_char_with_style(now()::timestamp, 'postgres')

-- sqlfmt-corpus-separator --

SELECT to_ip()

-- sqlfmt-corpus-separator --

SELECT unique_rowid() < unique_rowid()

-- sqlfmt-corpus-separator --

SELECT up()

-- sqlfmt-corpus-separator --

SELECT upper_hello(), nested_udf_for_from(), lower_hello(), concat_hello()

-- sqlfmt-corpus-separator --

SELECT ups()

-- sqlfmt-corpus-separator --

SELECT ups2()

-- sqlfmt-corpus-separator --

SELECT uuid_generate_v1() = uuid_generate_v1()

-- sqlfmt-corpus-separator --

SELECT uuid_generate_v1mc() = uuid_generate_v1mc()

-- sqlfmt-corpus-separator --

SELECT uuid_generate_v3(uuid_ns_x500(), 'cat')

-- sqlfmt-corpus-separator --

SELECT uuid_generate_v5(uuid_ns_oid(), 'dog')

-- sqlfmt-corpus-separator --

SELECT uuid_nil()

-- sqlfmt-corpus-separator --

SELECT uuid_ns_dns()

-- sqlfmt-corpus-separator --

SELECT uuid_ns_oid()

-- sqlfmt-corpus-separator --

SELECT uuid_ns_url()

-- sqlfmt-corpus-separator --

SELECT uuid_ns_x500()

-- sqlfmt-corpus-separator --

SELECT uuid_v4() != uuid_v4(), length(uuid_v4())

-- sqlfmt-corpus-separator --

SELECT width_bucket(now(), array['yesterday', 'today', 'tomorrow']::timestamptz[])

-- sqlfmt-corpus-separator --

SELECT with_max_staleness('10s') = statement_timestamp() - '10s'::interval

-- sqlfmt-corpus-separator --

SELECT with_min_timestamp(statement_timestamp() + '5s'::interval) = statement_timestamp()

-- sqlfmt-corpus-separator --

SELECT with_min_timestamp(statement_timestamp() - '5s'::interval) = statement_timestamp() - '5s'::interval

-- sqlfmt-corpus-separator --

SELECT with_min_timestamp(statement_timestamp()) = statement_timestamp()

-- sqlfmt-corpus-separator --

SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL READ COMMITTED

-- sqlfmt-corpus-separator --

SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

-- sqlfmt-corpus-separator --

SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL REPEATABLE READ

-- sqlfmt-corpus-separator --

SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

SET SESSION CHARACTERISTICS AS TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

SET SESSION CHARACTERISTICS AS TRANSACTION READ WRITE

-- sqlfmt-corpus-separator --

SET TIME ZONE 'Europe/Amsterdam'; SHOW TIME ZONE

-- sqlfmt-corpus-separator --

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

-- sqlfmt-corpus-separator --

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- sqlfmt-corpus-separator --

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

-- sqlfmt-corpus-separator --

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

SET TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

SET TRANSACTION READ ONLY, READ WRITE

-- sqlfmt-corpus-separator --

SET TRANSACTION READ WRITE

-- sqlfmt-corpus-separator --

SET application_name = 'foo'; SHOW application_name

-- sqlfmt-corpus-separator --

SET declare_cursor_statement_timeout_enabled = false;
BEGIN;
SET statement_timeout = '1s';
DECLARE a CURSOR FOR SELECT * FROM ( VALUES (1), (2) ) t(id);

-- sqlfmt-corpus-separator --

SET search_path = bar, public; SHOW search_path

-- sqlfmt-corpus-separator --

SET serial_normalization = sql_sequence_cached;
alter table t1_serial_columns add column i_cache serial;

-- sqlfmt-corpus-separator --

SET serial_normalization = sql_sequence_cached_node;
alter table t1_serial_columns add column i_node_cache serial;

-- sqlfmt-corpus-separator --

SET serial_normalization = unordered_rowid;
alter table t1_serial_columns add column i_unordered_rowid serial;

-- sqlfmt-corpus-separator --

SET serial_normalization = virtual_sequence;
alter table t1_serial_columns add column i_virtual serial;

-- sqlfmt-corpus-separator --

SET statement_timeout = 0;
COMMIT

-- sqlfmt-corpus-separator --

SET time zone 'Europe/Amsterdam'; SHOW TIME ZONE

-- sqlfmt-corpus-separator --

SET timezone = '+02:00';
SELECT to_char(now(), 'OF') as of_t, to_char(now(), 'TZH:TZM') as "TZH:TZM";

-- sqlfmt-corpus-separator --

SET timezone = '+02:00';
SELECT to_char(now(), 'of') as of_t, to_char(now(), 'tzh:tzm') as "tzh:tzm";

-- sqlfmt-corpus-separator --

SET timezone = '-00:30';
SELECT to_char(now(), 'OF') as of_t, to_char(now(), 'TZH:TZM') as "TZH:TZM";

-- sqlfmt-corpus-separator --

SET timezone = '-00:30';
SELECT to_char(now(), 'of') as of_t, to_char(now(), 'tzh:tzm') as "tzh:tzm";

-- sqlfmt-corpus-separator --

SET timezone = '-04:15';
SELECT to_char(now(), 'OF') as of_t, to_char(now(), 'TZH:TZM') as "TZH:TZM";

-- sqlfmt-corpus-separator --

SET timezone = '-04:15';
SELECT to_char(now(), 'of') as of_t, to_char(now(), 'tzh:tzm') as "tzh:tzm";

-- sqlfmt-corpus-separator --

SET timezone = '-04:30';
SELECT to_char(now(), 'OF') as of_t, to_char(now(), 'TZH:TZM') as "TZH:TZM";

-- sqlfmt-corpus-separator --

SET timezone = '-04:30';
SELECT to_char(now(), 'of') as of_t, to_char(now(), 'tzh:tzm') as "tzh:tzm";

-- sqlfmt-corpus-separator --

SET timezone = '-13:00';
SELECT to_char(now(), 'OF') as of_t, to_char(now(), 'TZH:TZM') as "TZH:TZM";

-- sqlfmt-corpus-separator --

SET timezone = '-13:00';
SELECT to_char(now(), 'of') as of_t, to_char(now(), 'tzh:tzm') as "tzh:tzm";

-- sqlfmt-corpus-separator --

SET timezone = '00:00';
SELECT to_char(now(), 'OF') as of_t, to_char(now(), 'TZH:TZM') as "TZH:TZM";

-- sqlfmt-corpus-separator --

SET timezone = '00:30';
SELECT to_char(now(), 'OF') as of_t, to_char(now(), 'TZH:TZM') as "TZH:TZM";

-- sqlfmt-corpus-separator --

SET timezone = '00:30';
SELECT to_char(now(), 'of') as of_t, to_char(now(), 'tzh:tzm') as "tzh:tzm";

-- sqlfmt-corpus-separator --

SET timezone = '04:15';
SELECT to_char(now(), 'OF') as of_t, to_char(now(), 'TZH:TZM') as "TZH:TZM";

-- sqlfmt-corpus-separator --

SET timezone = '04:15';
SELECT to_char(now(), 'of') as of_t, to_char(now(), 'tzh:tzm') as "tzh:tzm";

-- sqlfmt-corpus-separator --

SET timezone = '04:30';
SELECT to_char(now(), 'OF') as of_t, to_char(now(), 'TZH:TZM') as "TZH:TZM";

-- sqlfmt-corpus-separator --

SET timezone = '04:30';
SELECT to_char(now(), 'of') as of_t, to_char(now(), 'tzh:tzm') as "tzh:tzm";

-- sqlfmt-corpus-separator --

SET timezone = 'Europe/Amsterdam'; SHOW TIMEZONE

-- sqlfmt-corpus-separator --

SET timezone = 'Europe/Amsterdam'; SHOW timezone

-- sqlfmt-corpus-separator --

SET timezone = 'utc'; SHOW timezone

-- sqlfmt-corpus-separator --

SHOW "TIMEZONE"

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM "A"

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM "B"

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM B

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM a

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM add_default

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM alltypes

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM check_table

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM customers

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM d

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM e

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM f

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM fake5

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM geo_table

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM information_schema.attributes

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM information_schema.column_privileges

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM information_schema.parameters

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM information_schema.routines

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM information_schema.tables

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM information_schema.user_defined_types

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM materialized_view_with_null

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM pg_catalog.pg_namespace

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM pg_catalog.pg_stat_activity

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM privs

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM system.descriptor

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM system.eventlog

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM system.jobs

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM system.lease

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM system.namespace

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM system.rangelog

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM system.role_members

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM system.settings

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM system.ui

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM system.users

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM system.zones

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM t

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM t2

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM t21

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM t22

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM t3

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM t6

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM t_bit_string;

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM t_bytes;

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM t_decimal;

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM t_int;

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM t_many;

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM test.users

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM tt

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM tz

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM users

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM v

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM view_with_null

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ";--dontask"

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ";--notbetter"

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE "A"

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE "B"

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE "a.b"

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE "g.h"

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE "serial_MixedCase"

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE B

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE a

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE abcd

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE aliases

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE alt_syntax

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE alter_policy_table;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE alter_policy_table_locked;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE alter_test

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE alternative_schema.same_table_name

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE arr_t6

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE assign_at_create

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE atyp

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE b

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE bar

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE bar;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE bbteams

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE bits

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE c

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE collation_name_case

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE column_used_on_unsharded

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE column_used_on_unsharded_create_table

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE composite_pk;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE create_index_concurrently_tbl

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE created_as_global

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE db.rbr

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE db.rbr_altered

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE delivery

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE employee;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE enum_table_show

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE extra_parens

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE f1

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE flying_roaches

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE foo

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE foo10

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE foo11

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE foo12

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE foo13

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE foo5

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE foo6

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE foo8

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE foo9

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE gen_always_as_id_seqopt

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE gen_always_as_id_seqopt_cache

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE gen_by_default_as_id_seqopt

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE gen_by_default_as_id_seqopt_cache

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE generated_always_t

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE generated_by_default_t

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE global_table

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE i4

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE i4_rowid

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE i4_sql_sequence

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE i4_virtual_sequence

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE i8

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE i8_rowid

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE i8_sql_sequence

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE i8_virtual_sequence

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE indexes

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE information_schema.tables

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE inverted

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE late4

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE like_all

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE like_constraints

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE like_defaults

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE like_generated

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE like_hash

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE like_indexes

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE like_mixed

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE like_more_specifiers

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE like_no_pk_rowid_hidden

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE like_none

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE multi_pol_tab1

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE multiple_indexes

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE new_other_db.t

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE new_test_schema.foo

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE non_mr_table

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ok1

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ok10

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ok11

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ok12

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ok2

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ok3

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ok4

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ok5

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ok6

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ok7

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ok8

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE ok9

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE operator_class

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE p

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE pg_catalog.pg_namespace

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE pkref_b

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE prefix_cols

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE quoted_coll

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE r

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE refers

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE refpairs

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE regional_by_row

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE regional_by_row_as

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE regional_by_row_as_to_regional_by_row

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE regional_by_row_fk

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE regional_by_row_like

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE regional_by_row_table

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE regional_by_row_to_regional_by_row_as

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE regional_by_row_unique_in_column

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE regional_by_table_in_ca_central_1

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE regional_by_table_in_primary_region

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE regional_by_table_in_us_east

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE regional_by_table_no_region

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE regression_67196_like

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE rename_col

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE rename_column

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE rlsInsert

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE roaches

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE same_table_name

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE sanity1;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE serial

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE serials

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE sharded_primary

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE sharded_secondary

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE show_test

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE simple

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE smallbig

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE specific_family

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE storage_params

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE stored1;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t1

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t10

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t168748

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t168748_composite

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t1_add

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t2

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t2_fk

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t3

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t4

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t40417

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t6

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t7

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t72012

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t8

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t_150484

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t_96727_1

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t_96727_2

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t_96730

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t_droppedcol;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t_rename_computed;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t_sl

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t_unbounded_string

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t_unbounded_varbit

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t_with_default

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t_with_hidden

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t_with_on_update

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE tab1;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE table_with_virtual_cols

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE target

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE tb

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE tbl

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE tbl_with_collate

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE team

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE test.named_constraints

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE test.null_default

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE test.users

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE test_show_default

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE test_show_fk

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE trunc;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE unlogged_tbl

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE vec

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE vector

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE virt1;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE virt2;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE virt3;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE visible_table

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE weird_names

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE with_no_column_refs

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE x

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW ";--alsoconcerning"

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW "XV"

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW "YV"

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW YV

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW alter_test_view;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW default_view;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW dt

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW dt2

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW li

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW sd_view;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW si_view;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW si_view_default;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW t1

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW t2

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW test2.v1

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v1

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v10

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v11

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v12

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v13

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v14

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v15

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v2

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v3

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v4

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v5

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v6

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v7

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v8

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v9

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW xv

-- sqlfmt-corpus-separator --

SHOW DATABASE

-- sqlfmt-corpus-separator --

SHOW DATABASES

-- sqlfmt-corpus-separator --

SHOW DEFAULT PRIVILEGES

-- sqlfmt-corpus-separator --

SHOW DEFAULT_TRANSACTION_ISOLATION

-- sqlfmt-corpus-separator --

SHOW DEFAULT_TRANSACTION_PRIORITY

-- sqlfmt-corpus-separator --

SHOW DEFAULT_TRANSACTION_USE_FOLLOWER_READS

-- sqlfmt-corpus-separator --

SHOW ENUMS

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM "A"

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM "B"

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM B

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM a

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM c

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM information_schema.tables

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM o

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM pg_catalog.pg_namespace

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM privs

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM refpairs

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM refpairs_c_between

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM refpairs_wrong_order

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM rename_add_alter_pk_tbl;

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM t

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM tIndex

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM tIndx

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM t_rbr

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM test.users

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM unindexed

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM users

-- sqlfmt-corpus-separator --

SHOW INDEXES FROM users_dupe

-- sqlfmt-corpus-separator --

SHOW INDEXES from t2

-- sqlfmt-corpus-separator --

SHOW INTERVALSTYLE

-- sqlfmt-corpus-separator --

SHOW JOBS

-- sqlfmt-corpus-separator --

SHOW LC_COLLATE

-- sqlfmt-corpus-separator --

SHOW LC_CTYPE

-- sqlfmt-corpus-separator --

SHOW LC_MESSAGES

-- sqlfmt-corpus-separator --

SHOW LC_MONETARY

-- sqlfmt-corpus-separator --

SHOW LC_NUMERIC

-- sqlfmt-corpus-separator --

SHOW LC_TIME

-- sqlfmt-corpus-separator --

SHOW LOCALITY

-- sqlfmt-corpus-separator --

SHOW QUERIES

-- sqlfmt-corpus-separator --

SHOW RANGES

-- sqlfmt-corpus-separator --

SHOW REGIONS

-- sqlfmt-corpus-separator --

SHOW ROLES

-- sqlfmt-corpus-separator --

SHOW SCHEMAS

-- sqlfmt-corpus-separator --

SHOW SCHEMAS FROM a

-- sqlfmt-corpus-separator --

SHOW SCHEMAS FROM d1

-- sqlfmt-corpus-separator --

SHOW SCHEMAS FROM d2

-- sqlfmt-corpus-separator --

SHOW SCHEMAS FROM regression_105906

-- sqlfmt-corpus-separator --

SHOW SEARCH_PATH

-- sqlfmt-corpus-separator --

SHOW SEQUENCES

-- sqlfmt-corpus-separator --

SHOW SESSIONS

-- sqlfmt-corpus-separator --

SHOW TABLES

-- sqlfmt-corpus-separator --

SHOW TABLES FROM "D"

-- sqlfmt-corpus-separator --

SHOW TABLES FROM "Do you like this for a database name?".sc

-- sqlfmt-corpus-separator --

SHOW TABLES FROM "E"

-- sqlfmt-corpus-separator --

SHOW TABLES FROM "This is a fun name, no?"."A delightful name for a schema!"

-- sqlfmt-corpus-separator --

SHOW TABLES FROM d

-- sqlfmt-corpus-separator --

SHOW TABLES FROM d1

-- sqlfmt-corpus-separator --

SHOW TABLES FROM d2

-- sqlfmt-corpus-separator --

SHOW TABLES FROM e

-- sqlfmt-corpus-separator --

SHOW TABLES FROM foo

-- sqlfmt-corpus-separator --

SHOW TABLES FROM information_schema

-- sqlfmt-corpus-separator --

SHOW TABLES FROM pg_catalog

-- sqlfmt-corpus-separator --

SHOW TABLES FROM privatedb

-- sqlfmt-corpus-separator --

SHOW TABLES FROM public

-- sqlfmt-corpus-separator --

SHOW TABLES FROM public.public

-- sqlfmt-corpus-separator --

SHOW TABLES FROM publicdb

-- sqlfmt-corpus-separator --

SHOW TABLES FROM s

-- sqlfmt-corpus-separator --

SHOW TABLES FROM test

-- sqlfmt-corpus-separator --

SHOW TABLES FROM test.information_schema

-- sqlfmt-corpus-separator --

SHOW TABLES FROM test.pg_catalog

-- sqlfmt-corpus-separator --

SHOW TABLES FROM test2

-- sqlfmt-corpus-separator --

SHOW TABLES FROM u

-- sqlfmt-corpus-separator --

SHOW TABLES from foo

-- sqlfmt-corpus-separator --

SHOW TENANTS

-- sqlfmt-corpus-separator --

SHOW TIME ZONE

-- sqlfmt-corpus-separator --

SHOW TIMEZONE

-- sqlfmt-corpus-separator --

SHOW TRANSACTION ISOLATION LEVEL

-- sqlfmt-corpus-separator --

SHOW TRANSACTION ISOLATION LEVEL;

-- sqlfmt-corpus-separator --

SHOW TYPES

-- sqlfmt-corpus-separator --

SHOW USERS

-- sqlfmt-corpus-separator --

SHOW application_name

-- sqlfmt-corpus-separator --

SHOW authentication_method

-- sqlfmt-corpus-separator --

SHOW bytea_output

-- sqlfmt-corpus-separator --

SHOW check_function_bodies

-- sqlfmt-corpus-separator --

SHOW database

-- sqlfmt-corpus-separator --

SHOW datestyle

-- sqlfmt-corpus-separator --

SHOW deadlock_timeout

-- sqlfmt-corpus-separator --

SHOW default_int_size

-- sqlfmt-corpus-separator --

SHOW default_table_access_method

-- sqlfmt-corpus-separator --

SHOW default_text_search_config

-- sqlfmt-corpus-separator --

SHOW default_transaction_isolation

-- sqlfmt-corpus-separator --

SHOW default_transaction_quality_of_service

-- sqlfmt-corpus-separator --

SHOW default_transaction_read_only

-- sqlfmt-corpus-separator --

SHOW default_transaction_use_follower_reads

-- sqlfmt-corpus-separator --

SHOW default_with_oids

-- sqlfmt-corpus-separator --

SHOW disable_changefeed_replication

-- sqlfmt-corpus-separator --

SHOW distsql

-- sqlfmt-corpus-separator --

SHOW distsql_workmem

-- sqlfmt-corpus-separator --

SHOW enable_auto_rehoming

-- sqlfmt-corpus-separator --

SHOW enable_seqscan

-- sqlfmt-corpus-separator --

SHOW experimental_enable_auto_rehoming

-- sqlfmt-corpus-separator --

SHOW foo

-- sqlfmt-corpus-separator --

SHOW idle_in_session_timeout

-- sqlfmt-corpus-separator --

SHOW idle_in_transaction_session_timeout

-- sqlfmt-corpus-separator --

SHOW idle_session_timeout

-- sqlfmt-corpus-separator --

SHOW intervalstyle

-- sqlfmt-corpus-separator --

SHOW is_superuser

-- sqlfmt-corpus-separator --

SHOW lock_timeout

-- sqlfmt-corpus-separator --

SHOW log_timezone

-- sqlfmt-corpus-separator --

SHOW max_connections;

-- sqlfmt-corpus-separator --

SHOW max_prepared_transactions

-- sqlfmt-corpus-separator --

SHOW max_retries_for_read_committed

-- sqlfmt-corpus-separator --

SHOW opt_split_scan_limit

-- sqlfmt-corpus-separator --

SHOW pg_dump_compatibility

-- sqlfmt-corpus-separator --

SHOW search_path

-- sqlfmt-corpus-separator --

SHOW search_path;

-- sqlfmt-corpus-separator --

SHOW server_version

-- sqlfmt-corpus-separator --

SHOW server_version_num

-- sqlfmt-corpus-separator --

SHOW session_user

-- sqlfmt-corpus-separator --

SHOW ssl

-- sqlfmt-corpus-separator --

SHOW statement_timeout

-- sqlfmt-corpus-separator --

SHOW synchronous_commit

-- sqlfmt-corpus-separator --

SHOW tcp_keepalives_count

-- sqlfmt-corpus-separator --

SHOW tcp_keepalives_idle

-- sqlfmt-corpus-separator --

SHOW tcp_keepalives_interval

-- sqlfmt-corpus-separator --

SHOW tcp_user_timeout

-- sqlfmt-corpus-separator --

SHOW timezone

-- sqlfmt-corpus-separator --

SHOW tracing

-- sqlfmt-corpus-separator --

SHOW transaction_isolation

-- sqlfmt-corpus-separator --

SHOW transaction_priority

-- sqlfmt-corpus-separator --

SHOW transaction_read_only

-- sqlfmt-corpus-separator --

SHOW transaction_read_only;

-- sqlfmt-corpus-separator --

SHOW transaction_status

-- sqlfmt-corpus-separator --

SHOW vector_search_beam_size;

-- sqlfmt-corpus-separator --

SHOW vector_search_rerank_multiplier;

-- sqlfmt-corpus-separator --

SHOW vectorize

-- sqlfmt-corpus-separator --

SHOW xmloption

-- sqlfmt-corpus-separator --

TABLE abc

-- sqlfmt-corpus-separator --

TABLE t130591_1 EXCEPT DISTINCT TABLE t130591_1;

-- sqlfmt-corpus-separator --

TABLE t130591_1 EXCEPT DISTINCT TABLE t130591_2;

-- sqlfmt-corpus-separator --

TABLE t130591_1 EXCEPT TABLE t130591_1;

-- sqlfmt-corpus-separator --

TABLE t130591_1 INTERSECT DISTINCT TABLE t130591_1;

-- sqlfmt-corpus-separator --

TABLE t130591_1 INTERSECT DISTINCT TABLE t130591_2;

-- sqlfmt-corpus-separator --

TABLE t130591_1 INTERSECT TABLE t130591_1;

-- sqlfmt-corpus-separator --

TABLE t130591_1 UNION DISTINCT TABLE t130591_1;

-- sqlfmt-corpus-separator --

TABLE t130591_1 UNION DISTINCT TABLE t130591_2;

-- sqlfmt-corpus-separator --

TABLE t130591_1 UNION TABLE t130591_1;

-- sqlfmt-corpus-separator --

UPDATE t32477 SET x = rank() OVER ()

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
  cte1 AS (SELECT b FROM ab ORDER BY a),
  cte2 AS (SELECT y FROM xy ORDER BY x, y)
SELECT * FROM cte1 UNION ALL SELECT * FROM cte2

-- sqlfmt-corpus-separator --

WITH
  cte1 AS (SELECT b FROM ab ORDER BY a+b),
  cte2 AS (SELECT DISTINCT ON (x) y FROM xy ORDER BY x, y)
SELECT * FROM cte1 UNION ALL SELECT * FROM cte2

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

WITH a AS (
  SELECT extract(YEAR FROM "lastUpdated") AS year
  FROM system.settings WHERE name = 'version'
) SELECT year > 2020 AND year < 2100 FROM a

-- sqlfmt-corpus-separator --

WITH bar AS (SELECT 2) SELECT f(), * FROM bar;

-- sqlfmt-corpus-separator --

WITH cte (a, b) AS (SELECT random(), random())
SELECT count(*) FROM cte WHERE a = b

-- sqlfmt-corpus-separator --

WITH cte (x, a, b) AS (SELECT x, random(), random() FROM (VALUES (1), (2), (3)) AS v(x))
SELECT count(*) FROM cte WHERE a = b

-- sqlfmt-corpus-separator --

WITH cte(col) AS (SELECT random()) SELECT col, random() FROM cte

-- sqlfmt-corpus-separator --

WITH foo AS (SELECT 2) SELECT f(), * FROM foo;

-- sqlfmt-corpus-separator --

WITH foo AS (SELECT insert_t1()) SELECT insert_t1();

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

WITH tables AS (SHOW TABLES FROM crdb_internal) SELECT * FROM tables 
  WHERE table_name IN ('node_build_info', 'ranges', 'ranges_no_leases')

-- sqlfmt-corpus-separator --

WITH tables AS (SHOW TABLES FROM crdb_internal) SELECT * FROM tables 
WHERE table_name IN ('node_build_info', 'ranges_no_leases', 'ranges')

-- sqlfmt-corpus-separator --

alter table roach add column serial_id SERIAL;

-- sqlfmt-corpus-separator --

alter table roach add column serial_id2 SERIAL

-- sqlfmt-corpus-separator --

begin;

-- sqlfmt-corpus-separator --

begin;
insert into foo values (1)

-- sqlfmt-corpus-separator --

begin;
insert into foo values (1), (3);

-- sqlfmt-corpus-separator --

begin;
insert into foo values (2), (4);

-- sqlfmt-corpus-separator --

begin;
rollback

-- sqlfmt-corpus-separator --

begin;
select 1/0;

-- sqlfmt-corpus-separator --

commit

-- sqlfmt-corpus-separator --

commit;

-- sqlfmt-corpus-separator --

create ROLE bar_role;

-- sqlfmt-corpus-separator --

create ROLE foo_role;

-- sqlfmt-corpus-separator --

create database alter_survive_db

-- sqlfmt-corpus-separator --

create database bar;

-- sqlfmt-corpus-separator --

create database foo;

-- sqlfmt-corpus-separator --

create database test2

-- sqlfmt-corpus-separator --

create schema "schema-hyphen"

-- sqlfmt-corpus-separator --

create schema empty.sc

-- sqlfmt-corpus-separator --

create schema sc1;
create schema sc2;
create table sc1.parent (p int primary key);
create table sc2.child(p int primary key, r int REFERENCES sc1.parent (p));

-- sqlfmt-corpus-separator --

create table flying_roaches (check ('flying'::roach_type = 'crawling'::roach_type))

-- sqlfmt-corpus-separator --

rollback

-- sqlfmt-corpus-separator --

rollback;

-- sqlfmt-corpus-separator --

rollback;
drop table foo

-- sqlfmt-corpus-separator --

select
  extract('hour' from '11:12+03:01'::timetz)::string || ':' ||
  extract('minute' from '11:12+03:01'::timetz)::string || 'Z' ||
  extract('timezone_hour' from '11:12+03:01'::timetz)::string || ':' ||
  extract('timezone_minute' from '11:12+03:01'::timetz)::string

-- sqlfmt-corpus-separator --

select
  extract('hour' from '11:12-03:01'::timetz)::string || ':' ||
  extract('minute' from '11:12-03:01'::timetz)::string || 'Z' ||
  extract('timezone_hour' from '11:12-03:01'::timetz)::string || ':' ||
  extract('timezone_minute' from '11:12-03:01'::timetz)::string

-- sqlfmt-corpus-separator --

select * from access_large_c2_as_forcer();

-- sqlfmt-corpus-separator --

select * from access_large_c2_as_session_user();

-- sqlfmt-corpus-separator --

select 1; BEGIN; select 1; select 1; COMMIT

-- sqlfmt-corpus-separator --

select b, all_a() from ab

-- sqlfmt-corpus-separator --

select b, all_a(), some_a() from ab

-- sqlfmt-corpus-separator --

select crdb_internal.cluster_id() != '00000000-0000-0000-0000-000000000000' FROM foo

-- sqlfmt-corpus-separator --

select crdb_internal.create_session_revival_token()

-- sqlfmt-corpus-separator --

select crdb_internal.get_vmodule()

-- sqlfmt-corpus-separator --

select crdb_internal.validate_multi_region_zone_configs();

-- sqlfmt-corpus-separator --

select current_time() + current_timestamp()::date = current_timestamp()

-- sqlfmt-corpus-separator --

select extract(day from '2019-01-15'::date) as final

-- sqlfmt-corpus-separator --

select f128403();

-- sqlfmt-corpus-separator --

select f_delete();

-- sqlfmt-corpus-separator --

select f_insert();

-- sqlfmt-corpus-separator --

select f_select();

-- sqlfmt-corpus-separator --

select f_table1();

-- sqlfmt-corpus-separator --

select f_table2();

-- sqlfmt-corpus-separator --

select f_update();

-- sqlfmt-corpus-separator --

set time zone 'Europe/Berlin'; select extract(epoch from TIMESTAMP WITH TIME ZONE '2010-11-06 23:59:00-05:00')

-- sqlfmt-corpus-separator --

set time zone 'UTC'; select extract(epoch from TIMESTAMP WITH TIME ZONE '2010-11-06 23:59:00-05:00')

-- sqlfmt-corpus-separator --

show columns from roach;

-- sqlfmt-corpus-separator --

show create table decomputed_column

-- sqlfmt-corpus-separator --

show create table t

-- sqlfmt-corpus-separator --

show create table t17

-- sqlfmt-corpus-separator --

show create table t24

-- sqlfmt-corpus-separator --

show create table t3

-- sqlfmt-corpus-separator --

show create table t_128420

-- sqlfmt-corpus-separator --

show create table t_147993

-- sqlfmt-corpus-separator --

show create table t_99281

-- sqlfmt-corpus-separator --

show create table t_99764

-- sqlfmt-corpus-separator --

show create table t_bytes

-- sqlfmt-corpus-separator --

show create table t_decimal

-- sqlfmt-corpus-separator --

show create table t_multi_alter