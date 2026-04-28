/* End test case for bug #16242 */

/* Test case for bug #17409 */

create table attbl (p1 int constraint pk_attbl primary key)

-- sqlfmt-corpus-separator --

CREATE TABLE ATACC1 (TEST INT
	CHECK (TEST > 0) NO INHERIT)

-- sqlfmt-corpus-separator --

CREATE TABLE ATACC1 (TEST INT, TEST2 INT
	CHECK (TEST > 0), CHECK (TEST2 > 10) NO INHERIT)

-- sqlfmt-corpus-separator --

CREATE TABLE CHECK2_TBL (x int, y text, z int,
	CONSTRAINT SEQUENCE_CON
	CHECK (x > 3 and y <> 'check failed' and z < 8))

-- sqlfmt-corpus-separator --

CREATE TABLE CHECK_TBL (x int,
	CONSTRAINT CHECK_CON CHECK (x > 3))

-- sqlfmt-corpus-separator --

CREATE TABLE COPY_TBL (x INT, y TEXT, z INT,
	CONSTRAINT COPY_CON
	CHECK (x > 3 AND y <> 'check failed' AND x < 7 ))

-- sqlfmt-corpus-separator --

CREATE TABLE FKTABLE ( ftest1 int REFERENCES PKTABLE MATCH FULL, ftest2 int )

-- sqlfmt-corpus-separator --

CREATE TABLE UNIQUE_TBL (i int UNIQUE NULLS NOT DISTINCT, t text)

-- sqlfmt-corpus-separator --

CREATE TABLE addr_nsp.gentable (
    a serial primary key CONSTRAINT a_chk CHECK (a > 0),
    b text DEFAULT 'hello'
)

-- sqlfmt-corpus-separator --

CREATE TABLE am_partitioned(x INT, y INT) PARTITION BY hash (x) USING heap2

-- sqlfmt-corpus-separator --

CREATE TABLE badcompresstbl (a text COMPRESSION I_Do_Not_Exist_Compression)

-- sqlfmt-corpus-separator --

CREATE TABLE clstr_expression(id serial primary key, a int, b text COLLATE "C")

-- sqlfmt-corpus-separator --

CREATE TABLE cmdata(f1 text COMPRESSION pglz)

-- sqlfmt-corpus-separator --

CREATE TABLE cmdata2 (f1 TEXT COMPRESSION pglz, f2 TEXT COMPRESSION lz4)

-- sqlfmt-corpus-separator --

CREATE TABLE cmdata2 (f1 int COMPRESSION pglz)

-- sqlfmt-corpus-separator --

CREATE TABLE cmdata2 (f1 text COMPRESSION lz4)

-- sqlfmt-corpus-separator --

CREATE TABLE cmdata2 (f1 text COMPRESSION pglz)

-- sqlfmt-corpus-separator --

CREATE TABLE cmdata_pglz(f1 text COMPRESSION pglz)

-- sqlfmt-corpus-separator --

CREATE TABLE cmmove2(f1 text COMPRESSION pglz)

-- sqlfmt-corpus-separator --

CREATE TABLE cmmove3(f1 text COMPRESSION pglz)

-- sqlfmt-corpus-separator --

CREATE TABLE cmpart(f1 text COMPRESSION lz4) PARTITION BY HASH(f1)

-- sqlfmt-corpus-separator --

CREATE TABLE cmpart2(f1 text COMPRESSION pglz)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_dep_test1 (a int, b text COLLATE test0)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test1 (
    a int,
    b text COLLATE "C" NOT NULL
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test1 (
    a int,
    b text COLLATE "en-x-icu" NOT NULL
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test1 (
    a int,
    b text COLLATE "en_US" NOT NULL
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test10 (
    a int,
    x text COLLATE "C",
    y text COLLATE "POSIX"
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test10 (
    a int,
    x text COLLATE "en-x-icu",
    y text COLLATE "tr-x-icu"
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test10 (
    a int,
    x text COLLATE "en_US",
    y text COLLATE "tr_TR"
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test20 (f1 text COLLATE "C" PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test21 (f2 text COLLATE "POSIX" REFERENCES collate_test20)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test22 (f2 text COLLATE "POSIX")

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test23 (f1 text collate mycoll2)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test3 (
    a int,
    b text COLLATE "C"
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test5 (
    a int,
    b testdomain_p COLLATE "C"
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test5 (
    a int,
    b testdomain_sv COLLATE "en-x-icu"
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test5 (
    a int,
    b testdomain_sv COLLATE "en_US"
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test6 (
    a int,
    b text COLLATE "en-x-icu"
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test6 (
    a int,
    b text COLLATE "en_US"
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test_fail (
    a int COLLATE "en-x-icu",
    b text
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test_fail (
    a int COLLATE "en_US",
    b text
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test_fail (
    a int,
    b text COLLATE "foo"
)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test_fail (
    a int,
    b text COLLATE "foo-x-icu"
)

-- sqlfmt-corpus-separator --

CREATE TABLE comment_test_child (
  id text CONSTRAINT comment_test_child_fk REFERENCES comment_test)

-- sqlfmt-corpus-separator --

CREATE TABLE constraint_comments_tbl (a int CONSTRAINT the_constraint CHECK (a > 0))

-- sqlfmt-corpus-separator --

CREATE TABLE constraint_rename_test (a int CONSTRAINT con1 CHECK (a > 0), b int, c int)

-- sqlfmt-corpus-separator --

CREATE TABLE eager_agg_t1 (id int, val text COLLATE case_insensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE eager_agg_t2 (val text COLLATE case_insensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE ec2 (ek1 int, ek2 int, eb text COLLATE "POSIX")

-- sqlfmt-corpus-separator --

CREATE TABLE errtst_child_fastdef (
    partid int not null,
    shdata int not null,
    CONSTRAINT shdata_small CHECK(shdata < 3)
)

-- sqlfmt-corpus-separator --

CREATE TABLE errtst_child_plaindef (
    partid int not null,
    shdata int not null,
    data int NOT NULL DEFAULT 0,
    CONSTRAINT shdata_small CHECK(shdata < 3),
    CHECK(data < 10)
)

-- sqlfmt-corpus-separator --

CREATE TABLE errtst_child_reorder (
    data int NOT NULL DEFAULT 0,
    shdata int not null,
    partid int not null,
    CONSTRAINT shdata_small CHECK(shdata < 3),
    CHECK(data < 10)
)

-- sqlfmt-corpus-separator --

CREATE TABLE errtst_parent (
    partid int not null,
    shdata int not null,
    data int NOT NULL DEFAULT 0,
    CONSTRAINT shdata_small CHECK(shdata < 3)
) PARTITION BY RANGE (partid)

-- sqlfmt-corpus-separator --

CREATE TABLE fail_part (
	b char(2) COLLATE "C",
	a int NOT NULL
)

-- sqlfmt-corpus-separator --

CREATE TABLE follower (a int REFERENCES leader ON DELETE CASCADE, b int)

-- sqlfmt-corpus-separator --

CREATE TABLE gtest_child3 (f1 date NOT NULL, f2 bigint, f3 bigint GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TABLE hash_parted (
	a int,
	b int
) PARTITION BY HASH (a part_test_int4_ops)

-- sqlfmt-corpus-separator --

CREATE TABLE i_am_a_failure() USING "I do not exist AM"

-- sqlfmt-corpus-separator --

CREATE TABLE i_am_a_failure() USING "btree"

-- sqlfmt-corpus-separator --

CREATE TABLE i_am_a_failure() USING i_do_not_exist_am

-- sqlfmt-corpus-separator --

CREATE TABLE identity_dump_logged (a INT GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TABLE itest11 (a int generated always as identity, b text)

-- sqlfmt-corpus-separator --

CREATE TABLE itest12 OF itest_type (f1 WITH OPTIONS GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TABLE itest15 (a int GENERATED ALWAYS AS IDENTITY, b text)

-- sqlfmt-corpus-separator --

CREATE TABLE itest15 (id integer GENERATED ALWAYS AS IDENTITY NOT NULL)

-- sqlfmt-corpus-separator --

CREATE TABLE itest15 (id integer GENERATED ALWAYS AS IDENTITY NULL)

-- sqlfmt-corpus-separator --

CREATE TABLE itest15 (id integer NOT NULL GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TABLE itest15 (id integer NULL GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TABLE itest2 (a bigint generated always as identity, b text)

-- sqlfmt-corpus-separator --

CREATE TABLE itest5 (a int generated always as identity, b text)

-- sqlfmt-corpus-separator --

CREATE TABLE itest7 (a int GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TABLE itest8 (a int GENERATED ALWAYS AS IDENTITY, b text)

-- sqlfmt-corpus-separator --

CREATE TABLE itest9 (a int GENERATED ALWAYS AS IDENTITY, b text, c bigint)

-- sqlfmt-corpus-separator --

CREATE TABLE itest_err_2 (a int generated always as identity generated by default as identity)

-- sqlfmt-corpus-separator --

CREATE TABLE list_parted (
	a int NOT NULL,
	b char(2) COLLATE "C",
	CONSTRAINT check_a CHECK (a > 0)
) PARTITION BY LIST (a)

-- sqlfmt-corpus-separator --

CREATE TABLE mchash (a int, b text, c jsonb)
  PARTITION BY HASH (a part_test_int4_ops, b part_test_text_ops)

-- sqlfmt-corpus-separator --

CREATE TABLE mcinthash (a int, b int, c jsonb)
  PARTITION BY HASH (a part_test_int4_ops, b part_test_int4_ops)

-- sqlfmt-corpus-separator --

CREATE TABLE notnull_tbl2 (a INTEGER CONSTRAINT blah NOT NULL, b INTEGER CONSTRAINT blah NOT NULL)

-- sqlfmt-corpus-separator --

CREATE TABLE pagg_tab3 (a text, c text collate case_insensitive) PARTITION BY LIST(c collate "C")

-- sqlfmt-corpus-separator --

CREATE TABLE pagg_tab4 (c text collate case_insensitive, b text collate case_insensitive) PARTITION BY LIST (b collate "C")

-- sqlfmt-corpus-separator --

CREATE TABLE pagg_tab5 (c text collate case_insensitive, b text collate case_insensitive) PARTITION BY LIST (c collate case_insensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE pagg_tab6 (c text collate case_insensitive, b text collate case_insensitive) PARTITION BY LIST (b collate case_insensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE pagg_tab_m (a int, b int, c int) PARTITION BY RANGE(a, ((a+b)/2))

-- sqlfmt-corpus-separator --

CREATE TABLE part_1 (
	a int NOT NULL,
	b char(2) COLLATE "C",
	CONSTRAINT check_a CHECK (a > 0)
)

-- sqlfmt-corpus-separator --

CREATE TABLE parted (
	a text,
	b int NOT NULL DEFAULT 0,
	CONSTRAINT check_a CHECK (length(a) > 0)
) PARTITION BY LIST (a)

-- sqlfmt-corpus-separator --

CREATE TABLE parted_col_comment (a int, b text) PARTITION BY LIST (a) WITH (fillfactor=100)

-- sqlfmt-corpus-separator --

CREATE TABLE parted_si (
  id int not null,
  data text not null,
  rand float8 not null default random()
)
PARTITION BY LIST((id % 2))

-- sqlfmt-corpus-separator --

CREATE TABLE partitioned (
	a int
) PARTITION BY LIST ((a LIKE (SELECT 1)))

-- sqlfmt-corpus-separator --

CREATE TABLE partitioned (
	a int
) PARTITION BY RANGE ((42))

-- sqlfmt-corpus-separator --

CREATE TABLE partitioned (
	a int,
	CONSTRAINT check_a CHECK (a > 0) NO INHERIT
) PARTITION BY RANGE (a)

-- sqlfmt-corpus-separator --

CREATE TABLE partitioned (
	a int,
	b int
) PARTITION BY RANGE (((a, b)))

-- sqlfmt-corpus-separator --

CREATE TABLE partitioned (
	a int,
	b int
) PARTITION BY RANGE ((avg(a) OVER (PARTITION BY b)))

-- sqlfmt-corpus-separator --

CREATE TABLE partitioned (
	a int,
	b int
) PARTITION BY RANGE (a, ('unknown'))

-- sqlfmt-corpus-separator --

CREATE TABLE partitioned (
	a int,
	b int,
	c text,
	d text
) PARTITION BY RANGE (a oid_ops, plusone(b), c collate "default", d collate "C")

-- sqlfmt-corpus-separator --

CREATE TABLE partitioned (
	a point
) PARTITION BY LIST (a point_ops)

-- sqlfmt-corpus-separator --

CREATE TABLE partitioned (
	a point
) PARTITION BY RANGE (a point_ops)

-- sqlfmt-corpus-separator --

CREATE TABLE partitioned2 (
	a int,
	b text
) PARTITION BY RANGE ((a+1), substr(b, 1, 5))

-- sqlfmt-corpus-separator --

CREATE TABLE partkey_t (a int4) PARTITION BY RANGE (a test_int4_ops)

-- sqlfmt-corpus-separator --

CREATE TABLE personsx OF person_type (myname WITH OPTIONS NOT NULL)

-- sqlfmt-corpus-separator --

CREATE TABLE pitest1 (f1 date NOT NULL, f2 text, f3 bigint generated always as identity) PARTITION BY RANGE (f1)

-- sqlfmt-corpus-separator --

CREATE TABLE pitest1_pfail (f1 date NOT NULL, f2 text, f3 bigint GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TABLE pred_tab1 (a int NOT NULL, b int,
	CONSTRAINT check_tab1 CHECK (a IS NULL OR b > 2))

-- sqlfmt-corpus-separator --

CREATE TABLE pred_tab2 (a int, b int,
	CONSTRAINT check_a CHECK (a IS NOT NULL))

-- sqlfmt-corpus-separator --

CREATE TABLE prt1_e (a int, b int, c int) PARTITION BY RANGE(((a + b)/2))

-- sqlfmt-corpus-separator --

CREATE TABLE prt1_m (a int, b int, c int) PARTITION BY RANGE(a, ((a + b)/2))

-- sqlfmt-corpus-separator --

CREATE TABLE prt2_e (a int, b int, c int) PARTITION BY RANGE(((b + a)/2))

-- sqlfmt-corpus-separator --

CREATE TABLE prt2_m (a int, b int, c int) PARTITION BY RANGE(((b + a)/2), b)

-- sqlfmt-corpus-separator --

CREATE TABLE pt(i int) PARTITION BY hash (i part_test_int4_ops_bad)

-- sqlfmt-corpus-separator --

CREATE TABLE r2 (a int REFERENCES r1 ON DELETE CASCADE)

-- sqlfmt-corpus-separator --

CREATE TABLE r2 (a int REFERENCES r1 ON UPDATE CASCADE)

-- sqlfmt-corpus-separator --

CREATE TABLE range_parted3 (
	a int,
	b int
) PARTITION BY RANGE (a, (b+1))

-- sqlfmt-corpus-separator --

CREATE TABLE ref_b (
    b INT PRIMARY KEY,
    a INT REFERENCES trunc_a(a) ON DELETE CASCADE
)

-- sqlfmt-corpus-separator --

CREATE TABLE ref_c (
    c INT PRIMARY KEY,
    a INT REFERENCES trunc_a(a) ON DELETE CASCADE
) PARTITION BY RANGE (c)

-- sqlfmt-corpus-separator --

CREATE TABLE reloptions_test (s VARCHAR)
	WITH (toast.autovacuum_vacuum_cost_delay = 23)

-- sqlfmt-corpus-separator --

CREATE TABLE reloptions_test (s VARCHAR) WITH
	(toast.autovacuum_vacuum_cost_delay = 23,
	autovacuum_vacuum_cost_delay = 24, fillfactor = 40)

-- sqlfmt-corpus-separator --

CREATE TABLE reloptions_test2 (i int) WITH (toast.not_existing_option = 42)

-- sqlfmt-corpus-separator --

CREATE TABLE reloptions_test2(i INT) WITH (autovacuum_analyze_scale_factor='string')

-- sqlfmt-corpus-separator --

CREATE TABLE reloptions_test2(i INT) WITH (autovacuum_enabled='string')

-- sqlfmt-corpus-separator --

CREATE TABLE reloptions_test2(i INT) WITH (fillfactor='string')

-- sqlfmt-corpus-separator --

CREATE TABLE reloptions_test2(i INT) WITH (not_existing_namespace.fillfactor=2)

-- sqlfmt-corpus-separator --

CREATE TABLE sales_list
(salesperson_id INT GENERATED ALWAYS AS IDENTITY,
 salesperson_name VARCHAR(30),
 sales_state VARCHAR(20),
 sales_amount INT,
 sales_date DATE)
PARTITION BY LIST (sales_state)

-- sqlfmt-corpus-separator --

CREATE TABLE salespeople(salesperson_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, salesperson_name VARCHAR(30)) PARTITION BY RANGE (salesperson_id)

-- sqlfmt-corpus-separator --

CREATE TABLE t (i int PRIMARY KEY USING INDEX TABLESPACE regress_tblspace)
  PARTITION BY RANGE (i) TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

CREATE TABLE t (i int) PARTITION BY RANGE (i) USING partition_split_heap

-- sqlfmt-corpus-separator --

CREATE TABLE t (i int) PARTITION BY RANGE (i) USING partitions_merge_heap

-- sqlfmt-corpus-separator --

CREATE TABLE tableam_parted_heap2 (a text, b int) PARTITION BY list (a) USING heap2

-- sqlfmt-corpus-separator --

CREATE TABLE tableam_tbl_heap2(f1 int) USING heap2

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_heap(f1 int, f2 char(100)) using heap

-- sqlfmt-corpus-separator --

CREATE TABLE tbl_heap_psql(f1 int, f2 char(100)) using heap_psql

-- sqlfmt-corpus-separator --

CREATE TABLE tc3 (a int, b text COLLATE "C")

-- sqlfmt-corpus-separator --

CREATE TABLE test10fk (x text COLLATE case_insensitive REFERENCES test10pk (x) ON UPDATE CASCADE ON DELETE CASCADE)

-- sqlfmt-corpus-separator --

CREATE TABLE test10pk (x text COLLATE case_sensitive PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TABLE test11fk (x text COLLATE case_sensitive REFERENCES test11pk (x) ON UPDATE CASCADE ON DELETE CASCADE)

-- sqlfmt-corpus-separator --

CREATE TABLE test11pk (x text COLLATE case_insensitive PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TABLE test12fk (a int, b text COLLATE case_insensitive REFERENCES test12pk (x) ON UPDATE CASCADE)

-- sqlfmt-corpus-separator --

CREATE TABLE test12fk (a int, b text COLLATE case_insensitive REFERENCES test12pk (x) ON UPDATE NO ACTION)

-- sqlfmt-corpus-separator --

CREATE TABLE test12fk (a int, b text COLLATE case_insensitive REFERENCES test12pk (x) ON UPDATE RESTRICT)

-- sqlfmt-corpus-separator --

CREATE TABLE test12pk (x text COLLATE case_insensitive PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TABLE test1bpci (x char(3) COLLATE case_insensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE test1ci (x text COLLATE case_insensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE test1cs (x text COLLATE case_sensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE test20 (a int, b text COLLATE case_insensitive) PARTITION BY LIST (b)

-- sqlfmt-corpus-separator --

CREATE TABLE test21 (a int, b text COLLATE case_insensitive) PARTITION BY RANGE (b)

-- sqlfmt-corpus-separator --

CREATE TABLE test22 (a int, b text COLLATE case_sensitive) PARTITION BY HASH (b)

-- sqlfmt-corpus-separator --

CREATE TABLE test22a (a int, b text[] COLLATE case_sensitive) PARTITION BY HASH (b)

-- sqlfmt-corpus-separator --

CREATE TABLE test23 (a int, b text COLLATE case_insensitive) PARTITION BY HASH (b)

-- sqlfmt-corpus-separator --

CREATE TABLE test23a (a int, b text[] COLLATE case_insensitive) PARTITION BY HASH (b)

-- sqlfmt-corpus-separator --

CREATE TABLE test2bpci (x char(3) COLLATE case_insensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE test2ci (x text COLLATE case_insensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE test2cs (x text COLLATE case_sensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE test30 (a int, b char(3) COLLATE case_insensitive) PARTITION BY LIST (b)

-- sqlfmt-corpus-separator --

CREATE TABLE test31 (a int, b char(3) COLLATE case_insensitive) PARTITION BY RANGE (b)

-- sqlfmt-corpus-separator --

CREATE TABLE test32 (a int, b char(3) COLLATE case_sensitive) PARTITION BY HASH (b)

-- sqlfmt-corpus-separator --

CREATE TABLE test33 (a int, b char(3) COLLATE case_insensitive) PARTITION BY HASH (b)

-- sqlfmt-corpus-separator --

CREATE TABLE test3bpci (x char(3) COLLATE case_insensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE test3ci (x text COLLATE case_insensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE test3cs (x text COLLATE case_sensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE test4c (x text COLLATE case_insensitive)

-- sqlfmt-corpus-separator --

CREATE TABLE test_chunk_id (a TEXT, b TEXT STORAGE EXTERNAL)

-- sqlfmt-corpus-separator --

CREATE TABLE test_like_id_1 (a bigint GENERATED ALWAYS AS IDENTITY, b text)

-- sqlfmt-corpus-separator --

CREATE TABLE test_pg_c_utf8 (
  t TEXT COLLATE PG_C_UTF8
)

-- sqlfmt-corpus-separator --

CREATE TABLE test_pg_unicode_fast (
  t TEXT COLLATE PG_UNICODE_FAST
)

-- sqlfmt-corpus-separator --

CREATE TABLE testschema.dflt (a int PRIMARY KEY USING INDEX TABLESPACE pg_default) PARTITION BY LIST (a)

-- sqlfmt-corpus-separator --

CREATE TABLE testschema.dflt (a int PRIMARY KEY USING INDEX TABLESPACE regress_tblspace) PARTITION BY LIST (a)

-- sqlfmt-corpus-separator --

CREATE TABLE testschema.dflt (a int PRIMARY KEY USING INDEX TABLESPACE regress_tblspace) PARTITION BY LIST (a) TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

CREATE TABLE testschema.dflt (a int PRIMARY KEY) PARTITION BY LIST (a) TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

CREATE TABLE testschema.test_default_tab_p(id bigint, val bigint)
    PARTITION BY LIST (id) TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

CREATE TABLE two_not_null_constraints (
   col integer NOT NULL,
   CONSTRAINT two_not_null_constraints_col_not_null CHECK (col IS NOT NULL)
)

-- sqlfmt-corpus-separator --

CREATE TABLE vac_rewrite_toast (id int, f1 TEXT STORAGE plain)

-- sqlfmt-corpus-separator --

CREATE TABLE viewtest_tbl (a int, b int, c numeric(10,1), d text COLLATE "C")

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE CHAR_TBL(f1 char)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE FKTABLE (ftest1 cidr, ftest2 timestamp)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE FKTABLE (ftest1 inet)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE FKTABLE (ftest1 int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE FKTABLE (ftest1 int, ftest2 inet)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE FKTABLE (ftest1 int8)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE FKTABLE (ftest1 numeric)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE FLOAT8_TBL(f1 float8)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE INTERVAL_TBL_OF (f1 interval)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE PKTABLE (ptest1 int primary key)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE PKTABLE (ptest1 numeric PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE VARCHAR_TBL(f1 varchar(1))

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE a (id int PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE a (id int PRIMARY KEY, b_id int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE a_temp_tbl ()

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE a_temp_tbl (f1 int primary key, f2 int default 42)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE abbrev_abort_uuids (
    id serial not null,
    abort_increasing uuid,
    abort_decreasing uuid,
    noabort_increasing uuid,
    noabort_decreasing uuid)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE arraggtest ( f1 INT[], f2 TEXT[][], f3 FLOAT[])

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE arrtest1 (i int[], t text[])

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE arrtest2 (i integer ARRAY[4], f float8[], n numeric[], t text[], d timestamp[])

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE arrtest_f (f0 int, f1 text, f2 float8)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE arrtest_i (f0 int, f1 text, f2 int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE arrtest_s (
  a       int2[],
  b       int2[][]
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE articles (
    id int CONSTRAINT articles_pkey PRIMARY KEY,
    keywords text,
    title text UNIQUE NOT NULL,
    body text UNIQUE,
    created date
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE attmp (attmptable int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE b (id int PRIMARY KEY, a_id int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE b (id int PRIMARY KEY, c_id int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE bar (id1 integer, id2 integer)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE bug6051_2 (i int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE c (id int PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE combocidtest (foobar int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE concur_temp (f1 int, f2 text)
  ON COMMIT DELETE ROWS

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE concur_temp (f1 int, f2 text)
  ON COMMIT DROP

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE concur_temp_tab_1 (c1 int, c2 text)
  ON COMMIT PRESERVE ROWS

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE concur_temp_tab_2 (c1 int, c2 text)
  ON COMMIT DELETE ROWS

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE concur_temp_tab_3 (c1 int, c2 text)
  ON COMMIT PRESERVE ROWS

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE d (a int, b int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE department (
	id INTEGER PRIMARY KEY,  -- department ID
	parent_department INTEGER REFERENCES department, -- upper department ID
	name TEXT -- department name
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE disttable (f1 integer)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE duplicates (a INT NOT NULL)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE explicitly_temp (a int primary key)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE fktable (
        x1      INT4 REFERENCES pktable(id1),
        x2      VARCHAR(4) REFERENCES pktable(id2),
        x3      REAL REFERENCES pktable(id3),
        x4      TEXT,
        x5      INT2
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE foo (f1 int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE foo (f1 int, f2 int, f3 int, f4 int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE foo (f1 serial, f2 text, f3 int default 42)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE foo (id integer)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE foo (serial_num int, name text, type text)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE forcetest (
    a INT NOT NULL,
    b TEXT NOT NULL,
    c TEXT,
    d TEXT,
    e TEXT
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE hash_temp_heap (x int, y int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE id_alw1 (i int GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE id_alw2 (i int GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE id_alw3 (i int GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE id_alw4 (i int GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE inner_text (c1 text COLLATE case_insensitive, c2 text)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE joinme (f2j text, other int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE jsbpoptest (js jsonb)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE jsonb_table_test (js jsonb)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE jspoptest (js json)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE mvtest_temp_t (id int NOT NULL, type text NOT NULL, amt numeric NOT NULL)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE mytab (foo widget(42,13))

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE mytab (foo widget(42,13,7))

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE nocols()

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE not_null_tab (id int NOT NULL, val int NOT NULL)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE notnull_notvalid_tab (id int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE null_tab (id int, val int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE outer_text (f1 text COLLATE case_insensitive, f2 text)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE parent ( id int, val text )

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE parted_b (id int PRIMARY KEY) partition by range(id)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE past_inh_db_other ()

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE past_inh_db_parent () ON COMMIT DELETE ROWS

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE pg_temp.doubly_temp (a int primary key)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE pktable (
    id int primary key,
    other int
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE point_gist_tbl(f1 point)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE products (product_id int, name text, price numeric)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE public.temp_to_perm (a int primary key)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE relation_filenode_check(c1 int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE reloptions_test(i INT NOT NULL, j text)
	WITH (vacuum_truncate=false,
	toast.vacuum_truncate=false,
	autovacuum_enabled=false)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE rescan_bhs (a INT)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE reset_test ( data text ) ON COMMIT DELETE ROWS

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE ret_nn (a int NOT NULL)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE sales (product_id int, units int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE skip_fetch (a INT, b INT) WITH (fillfactor=10)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE sometable(f1 int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE stats_temp(i int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t (a int) PARTITION BY RANGE (a)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t (a integer) PARTITION BY LIST (a)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t (a integer, b integer) PARTITION BY HASH (a, b)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t (i int) PARTITION BY RANGE (i)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t (i int) PARTITION BY RANGE (i) ON COMMIT DROP

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t1 (
  a int,
  b int,
  c int
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t1 (
  f1 serial,
  f2 int DEFAULT nextval('myseq2'),
  f3 int DEFAULT nextval('myseq3'::text)
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t1 (a int, b int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t1 (a text, b text)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t1c (b text, a text)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t2 (a int, b int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t2 (ab text primary key)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE t3 (x int, y int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE tasks (
  id INT PRIMARY KEY,
  owner INT REFERENCES users ON UPDATE CASCADE ON DELETE SET NULL,
  worker INT REFERENCES users ON UPDATE CASCADE ON DELETE SET NULL,
  checked_by INT REFERENCES users ON UPDATE CASCADE ON DELETE SET NULL
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temp_parted (
	a int
) PARTITION BY LIST (a)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temp_parted (a int) PARTITION BY LIST (a)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temptest(col int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temptest(col int) ON COMMIT DELETE ROWS

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temptest(col int) ON COMMIT DROP

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temptest(tcol float)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temptest(tcol int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temptest1(col int PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temptest2(col int REFERENCES temptest1)
  ON COMMIT DELETE ROWS

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temptest3(col int PRIMARY KEY) ON COMMIT DELETE ROWS

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE temptest4(col int REFERENCES temptest3)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE test_json (
       json_type text,
       test_json json
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE test_jsonb (
       json_type text,
       test_json jsonb
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE test_mark_restore(col1 int, col2 int, col12 int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE testnull(a int, b text)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE tmp (xd INT, yd TEXT, zd INT)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE tmp_foo (data text) ON COMMIT DELETE ROWS

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE tmptbl (i int, j int)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE tp (a integer PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE tt (num2 int, value text)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE tt1 ( tt1_id int4, joincol int4 )

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE tt2 ( tt2_id int4, joincol int4 )

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE uctest(f1 int, f2 text)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE users (
  id INT PRIMARY KEY,
  name VARCHAR NOT NULL
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE vac_truncate_test(i INT NOT NULL, j text)
	WITH (vacuum_truncate=true, autovacuum_enabled=false)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE vctable (f1 varchar(25))

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE withoutoid() WITH (oids = false)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE withoutoid() WITHOUT OIDS

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE x (
	a serial,
	b int,
	c text not null default 'stuff',
	d text,
	e text
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE y (
	col1 text,
	col2 text
)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE bitwise_test(
  i2 INT2,
  i4 INT4,
  i8 INT8,
  i INTEGER,
  x INT2,
  y BIT(4)
)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE bool_test(
  b1 BOOL,
  b2 BOOL,
  b3 BOOL,
  b4 BOOL)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE box_temp (f1 box)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE empsalary (
    depname varchar,
    empno bigint,
    salary int,
    enroll_date date
)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE planets (
    name text,
    distance text,
    orbit integer
)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE temp_table (a int, id int)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE temptest (a int)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE test_io_local(a int, b TEXT)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE test_last_scan(idx_col int primary key, noidx_col int)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE test_temp(a int not null unique, b TEXT not null, cnt int not null)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE testpub_temptbl(a int)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE tmp (a int PRIMARY KEY)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE tree(
    id INTEGER PRIMARY KEY,
    parent_id INTEGER REFERENCES tree(id)
)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE unlogged2 (a int primary key)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE x (n integer)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE y (a INTEGER)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE yy (a INTEGER)

-- sqlfmt-corpus-separator --

CREATE UNLOGGED TABLE brintest_unlogged (n numrange)

-- sqlfmt-corpus-separator --

CREATE UNLOGGED TABLE for_portion_of_test (
  id int4range,
  valid_at daterange,
  name text
)

-- sqlfmt-corpus-separator --

CREATE UNLOGGED TABLE identity_dump_unlogged (a INT GENERATED ALWAYS AS IDENTITY)

-- sqlfmt-corpus-separator --

CREATE UNLOGGED TABLE itest17 (a int NOT NULL, b text)

-- sqlfmt-corpus-separator --

CREATE UNLOGGED TABLE pg_temp.unlogged3 (a int primary key)

-- sqlfmt-corpus-separator --

CREATE UNLOGGED TABLE public.unlogged2 (a int primary key)

-- sqlfmt-corpus-separator --

CREATE UNLOGGED TABLE testpub_unloggedtbl(a int)

-- sqlfmt-corpus-separator --

CREATE UNLOGGED TABLE unlogged1 (a int primary key)

-- sqlfmt-corpus-separator --

CREATE UNLOGGED TABLE unlogged1 (a int) PARTITION BY RANGE (a)

-- sqlfmt-corpus-separator --

CREATE UNLOGGED TABLE unlogged1(f1 SERIAL PRIMARY KEY, f2 TEXT)

-- sqlfmt-corpus-separator --

CREATE UNLOGGED TABLE unlogged2(f1 SERIAL PRIMARY KEY, f2 INTEGER REFERENCES unlogged1)

-- sqlfmt-corpus-separator --

CREATE UNLOGGED TABLE unlogged3(f1 SERIAL PRIMARY KEY, f2 INTEGER REFERENCES unlogged3)

-- sqlfmt-corpus-separator --

SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND (j1.a*j1.a) = (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int
  AND (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int = (j2.a*j2.a)

-- sqlfmt-corpus-separator --

SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND j1.a = (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int
  AND (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int = j2.a

-- sqlfmt-corpus-separator --

SELECT length(current_timestamp::text) >= length(current_timestamp(0)::text)

-- sqlfmt-corpus-separator --

SELECT p1.oid, p1.proname
FROM pg_proc AS p1
WHERE (pronargdefaults <> 0) != (proargdefaults IS NOT NULL)

-- sqlfmt-corpus-separator --

SELECT t.oid, t.typname, t.typanalyze
FROM pg_type t LEFT JOIN pg_range r on t.oid = r.rngtypid
WHERE t.typbasetype = 0 AND
    (t.typanalyze = 'range_typanalyze'::regproc) != (r.rngtypid IS NOT NULL)

-- sqlfmt-corpus-separator --

WITH
   x AS (SELECT proname, proowner, procost::numeric, pronargs,
                array_to_string(proargnames,',') as proargnames,
                case when proargtypes <> '' then array_to_string(proargtypes::oid[],',') end as proargtypes
           FROM pg_proc WHERE proname = 'f_leak'),
   y AS (SELECT xmlelement(name proc,
                           xmlforest(proname, proowner,
                                     procost, pronargs,
                                     proargnames, proargtypes)) as proc
           FROM x),
   z AS (SELECT xmltable.*
           FROM y,
                LATERAL xmltable('/proc' PASSING proc
                                 COLUMNS proname name,
                                         proowner oid,
                                         procost float,
                                         pronargs int,
                                         proargnames text,
                                         proargtypes text))
   SELECT * FROM z
   EXCEPT SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH
   x AS (SELECT proname, proowner, procost::numeric, pronargs,
                array_to_string(proargnames,',') as proargnames,
                case when proargtypes <> '' then array_to_string(proargtypes::oid[],',') end as proargtypes
           FROM pg_proc),
   y AS (SELECT xmlelement(name data,
                           xmlagg(xmlelement(name proc,
                                             xmlforest(proname, proowner, procost,
                                                       pronargs, proargnames, proargtypes)))) as doc
           FROM x),
   z AS (SELECT xmltable.*
           FROM y,
                LATERAL xmltable('/data/proc' PASSING doc
                                 COLUMNS proname name,
                                         proowner oid,
                                         procost float,
                                         pronargs int,
                                         proargnames text,
                                         proargtypes text))
   SELECT * FROM z
   EXCEPT SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE
  tab(id_key,link) AS (VALUES (1,17), (2,17), (3,17), (4,17), (6,17), (5,17)),
  iter (id_key, row_type, link) AS (
      SELECT 0, 'base', 17
    UNION (
      WITH remaining(id_key, row_type, link, min) AS (
        SELECT tab.id_key, 'true'::text, iter.link, MIN(tab.id_key) OVER ()
        FROM tab INNER JOIN iter USING (link)
        WHERE tab.id_key > iter.id_key
      ),
      first_remaining AS (
        SELECT id_key, row_type, link
        FROM remaining
        WHERE id_key=min
      ),
      effect AS (
        SELECT tab.id_key, 'new'::text, tab.link
        FROM first_remaining e INNER JOIN tab ON e.id_key=tab.id_key
        WHERE e.row_type = 'false'
      )
      SELECT * FROM first_remaining
      UNION ALL SELECT * FROM effect
    )
  )
SELECT * FROM iter

-- sqlfmt-corpus-separator --

WITH RECURSIVE
  tab(id_key,link) AS (VALUES (1,17), (2,17), (3,17), (4,17), (6,17), (5,17)),
  iter (id_key, row_type, link) AS (
      SELECT 0, 'base', 17
    UNION ALL (
      WITH remaining(id_key, row_type, link, min) AS (
        SELECT tab.id_key, 'true'::text, iter.link, MIN(tab.id_key) OVER ()
        FROM tab INNER JOIN iter USING (link)
        WHERE tab.id_key > iter.id_key
      ),
      first_remaining AS (
        SELECT id_key, row_type, link
        FROM remaining
        WHERE id_key=min
      ),
      effect AS (
        SELECT tab.id_key, 'new'::text, tab.link
        FROM first_remaining e INNER JOIN tab ON e.id_key=tab.id_key
        WHERE e.row_type = 'false'
      )
      SELECT * FROM first_remaining
      UNION ALL SELECT * FROM effect
    )
  )
SELECT * FROM iter

-- sqlfmt-corpus-separator --

WITH rand_value AS (SELECT string_agg(fipshash((-i)::text),'') AS val FROM generate_series(1,60) s(i))
INSERT INTO brintest_3
SELECT val, val, val, val FROM rand_value

-- sqlfmt-corpus-separator --

create TEMP TABLE test_jsonb_subscript (
       id int,
       test_json jsonb
)

-- sqlfmt-corpus-separator --

create table ac (a int constraint check_a check (a <> 0))

-- sqlfmt-corpus-separator --

create table anothertab (atcol1 serial8, atcol2 boolean,
	constraint anothertab_chk check (atcol1 <= 3))

-- sqlfmt-corpus-separator --

create table at_test_sql_partop (a int) partition by range (a at_test_sql_partop)

-- sqlfmt-corpus-separator --

create table attbl (p1 int constraint pk_attbl primary key)

-- sqlfmt-corpus-separator --

create table bc (b int constraint check_b check (b <> 0))

-- sqlfmt-corpus-separator --

create table coll_pruning (a text collate "C") partition by list (a)

-- sqlfmt-corpus-separator --

create table coll_pruning_multi (a text) partition by range (substr(a, 1) collate "POSIX", substr(a, 1) collate "C")

-- sqlfmt-corpus-separator --

create table hash_parted (
	a int
) partition by hash (a part_test_int4_ops)

-- sqlfmt-corpus-separator --

create table hash_parted (
	a int,
	b int
) partition by hash (a custom_opclass, b custom_opclass)

-- sqlfmt-corpus-separator --

create table hp (a int, b text, c int)
  partition by hash (a part_test_int4_ops, b part_test_text_ops)

-- sqlfmt-corpus-separator --

create table hp_contradict_test (a int, b int) partition by hash (a part_test_int4_ops2, b part_test_int4_ops2)

-- sqlfmt-corpus-separator --

create table hp_prefix_test (a int, b int, c int, d int)
  partition by hash (a part_test_int4_ops, b part_test_int4_ops, c part_test_int4_ops, d part_test_int4_ops)

-- sqlfmt-corpus-separator --

create table iboolpart (a bool) partition by list ((not a))

-- sqlfmt-corpus-separator --

create table idxpart (a int primary key, b int) partition by range ((b + a))

-- sqlfmt-corpus-separator --

create table idxpart (a int unique, b int) partition by range ((b + a))

-- sqlfmt-corpus-separator --

create table inh_fk_2 (x int primary key, y int references inh_fk_1 on delete cascade)

-- sqlfmt-corpus-separator --

create table inh_parent1(a int constraint nn not null)

-- sqlfmt-corpus-separator --

create table inh_parent2(b int constraint nn not null)

-- sqlfmt-corpus-separator --

create table key_desc (a int, b int) partition by list ((a+0))

-- sqlfmt-corpus-separator --

create table mlparted1 (b int not null, a int not null) partition by range ((b+0))

-- sqlfmt-corpus-separator --

create table notnull_tbl1 (a int primary key constraint foo not null)

-- sqlfmt-corpus-separator --

create table notnull_tbl_fail (a serial constraint foo not null constraint bar not null)

-- sqlfmt-corpus-separator --

create table nv_parent (d date, check (false) no inherit not valid)

-- sqlfmt-corpus-separator --

create table p1(f1 int constraint f1_pos CHECK (f1 > 0))

-- sqlfmt-corpus-separator --

create table p2(f1 int constraint f1_pos CHECK (f1 > 0))

-- sqlfmt-corpus-separator --

create table parent (a float8, b numeric(10,4), c text collate "C")

-- sqlfmt-corpus-separator --

create table parted (a int, b int, c text) partition by list ((a + b))

-- sqlfmt-corpus-separator --

create table parted_collate_must_match (a text collate "C", b text collate "C")
  partition by range (a)

-- sqlfmt-corpus-separator --

create table partitioned (a int, b int)
  partition by list ((partitioned))

-- sqlfmt-corpus-separator --

create table partitioned (a int, b int)
  partition by list ((row(a, b)::partitioned))

-- sqlfmt-corpus-separator --

create table range_parted (
	a text,
	b int
) partition by range (a, (b+0))

-- sqlfmt-corpus-separator --

create table rlp3 (b varchar, a int) partition by list (b varchar_ops)

-- sqlfmt-corpus-separator --

create table self_ref (a int primary key,
                       b int references self_ref(a) on delete cascade)

-- sqlfmt-corpus-separator --

create table some_tab (f1 int, f2 int, f3 int, check (f1 < 10) no inherit)

-- sqlfmt-corpus-separator --

create table test_part_coll_posix (a text) partition by range (a collate "POSIX")

-- sqlfmt-corpus-separator --

create table test_storage (a text, c text storage plain)

-- sqlfmt-corpus-separator --

create table test_storage_failed (a text, b int storage extended)

-- sqlfmt-corpus-separator --

create table trigtest2 (i int references trigtest(i) on delete cascade)

-- sqlfmt-corpus-separator --

create temp table a (i integer)

-- sqlfmt-corpus-separator --

create temp table arr_pk_tbl (pk int4 primary key, f1 int[])

-- sqlfmt-corpus-separator --

create temp table arr_tbl (f1 int[] unique)

-- sqlfmt-corpus-separator --

create temp table b (x integer, y integer)

-- sqlfmt-corpus-separator --

create temp table bar(f1 int, f2 int)

-- sqlfmt-corpus-separator --

create temp table btree_bpchar (f1 text collate "C")

-- sqlfmt-corpus-separator --

create temp table cc (f1 cantcompare)

-- sqlfmt-corpus-separator --

create temp table cc (f1 int references pp on update no action on delete no action)

-- sqlfmt-corpus-separator --

create temp table cc (f1 int references pp on update restrict on delete restrict)

-- sqlfmt-corpus-separator --

create temp table child (
    bid int not null primary key,
    aid int not null,
    val1 text)

-- sqlfmt-corpus-separator --

create temp table child (k int unique, cd int)

-- sqlfmt-corpus-separator --

create temp table clstr_temp (col1 int primary key, col2 text)

-- sqlfmt-corpus-separator --

create temp table compos (f1 int, f2 text)

-- sqlfmt-corpus-separator --

create temp table copy_default (
	id integer primary key,
	text_value text not null default 'test',
	ts_value timestamp without time zone not null default '2022-07-05'
)

-- sqlfmt-corpus-separator --

create temp table copyjsontest (
    id bigserial,
    f1 text,
    f2 timestamptz)

-- sqlfmt-corpus-separator --

create temp table copyjsontest_types (
    id int,
    js json,
    jsb jsonb,
    arr int[],
    n numeric(10,2),
    b boolean,
    ts timestamp,
    t text)

-- sqlfmt-corpus-separator --

create temp table copytest4 (
	c1 int,
	"colname with tab: 	" text)

-- sqlfmt-corpus-separator --

create temp table copytest5 (c1 int)

-- sqlfmt-corpus-separator --

create temp table datetimes(
    id int,
    f_time time,
    f_timetz timetz,
    f_interval interval,
    f_timestamptz timestamptz,
    f_timestamp timestamp
)

-- sqlfmt-corpus-separator --

create temp table defc (f1 int default 0
                        references defp on delete set default)

-- sqlfmt-corpus-separator --

create temp table defp (f1 int primary key)

-- sqlfmt-corpus-separator --

create temp table dest (f1 textandtext[])

-- sqlfmt-corpus-separator --

create temp table dtest(f1 dtop)

-- sqlfmt-corpus-separator --

create temp table exists_tbl (c1 int, c2 int, c3 int) partition by list (c1)

-- sqlfmt-corpus-separator --

create temp table float_table (float_col float8)

-- sqlfmt-corpus-separator --

create temp table foo (f1 int, f2 int)

-- sqlfmt-corpus-separator --

create temp table foo (f1 text, f2 mytype, f3 text)

-- sqlfmt-corpus-separator --

create temp table foo(f1 int, f2 int)

-- sqlfmt-corpus-separator --

create temp table fullname (first text, last text)

-- sqlfmt-corpus-separator --

create temp table graph( f int, t int, label text )

-- sqlfmt-corpus-separator --

create temp table graph0( f int, t int, label text )

-- sqlfmt-corpus-separator --

create temp table gstest2 (a integer, b integer, c integer, d integer,
                           e integer, f integer, g integer, h integer)

-- sqlfmt-corpus-separator --

create temp table gstest4(id integer, v integer,
                          unhashable_col bit(4), unsortable_col xid)

-- sqlfmt-corpus-separator --

create temp table gstest5(id integer primary key, v integer)

-- sqlfmt-corpus-separator --

create temp table gstest_empty (a integer, b integer, v integer)

-- sqlfmt-corpus-separator --

create temp table i_table (f1 int)

-- sqlfmt-corpus-separator --

create temp table idxpart_temp (a int) partition by range (a)

-- sqlfmt-corpus-separator --

create temp table inh_temp_parent (a1 int)

-- sqlfmt-corpus-separator --

create temp table inner_7597(c1 int8, c2 int8)

-- sqlfmt-corpus-separator --

create temp table inner_text (c1 text, c2 text)

-- sqlfmt-corpus-separator --

create temp table innertab (id int8 primary key, dat1 int8)

-- sqlfmt-corpus-separator --

create temp table json_tab (a int)

-- sqlfmt-corpus-separator --

create temp table log (q1 int8, q2 int8)

-- sqlfmt-corpus-separator --

create temp table mytable(f1 int, f2 int, f3 int)

-- sqlfmt-corpus-separator --

create temp table nestjsonb (j jsonb)

-- sqlfmt-corpus-separator --

create temp table nocolumns()

-- sqlfmt-corpus-separator --

create temp table notininner (b int not null)

-- sqlfmt-corpus-separator --

create temp table notinouter (a int)

-- sqlfmt-corpus-separator --

create temp table nt1 (
  id int primary key,
  a1 boolean,
  a2 boolean
)

-- sqlfmt-corpus-separator --

create temp table numeric_table (num_col numeric)

-- sqlfmt-corpus-separator --

create temp table numerics(
    id int,
    f_float4 float4,
    f_float8 float8,
    f_numeric numeric
)

-- sqlfmt-corpus-separator --

create temp table onerow()

-- sqlfmt-corpus-separator --

create temp table op (f1 orderedpair)

-- sqlfmt-corpus-separator --

create temp table outer_7597 (f1 int4, f2 int4)

-- sqlfmt-corpus-separator --

create temp table outer_text (f1 text, f2 text)

-- sqlfmt-corpus-separator --

create temp table oversized_column_default (
    col1 varchar(5) DEFAULT 'more than 5 chars',
    col2 varchar(5))

-- sqlfmt-corpus-separator --

create temp table p (a int, b int) partition by range (a)

-- sqlfmt-corpus-separator --

create temp table p (a int, b int, c int) partition by list (a)

-- sqlfmt-corpus-separator --

create temp table parent (
    aid int not null primary key,
    val1 text,
    val2 text,
    val3 text,
    val4 text,
    bcnt int not null default 0)

-- sqlfmt-corpus-separator --

create temp table parent (k int primary key, pd int)

-- sqlfmt-corpus-separator --

create temp table parent2(f1 int, f3 bigint)

-- sqlfmt-corpus-separator --

create temp table parts (
    partnum     text,
    cost        float8
)

-- sqlfmt-corpus-separator --

create temp table parttbl (a integer primary key) partition by range (a)

-- sqlfmt-corpus-separator --

create temp table pendtest (ts tsvector)

-- sqlfmt-corpus-separator --

create temp table people (fn fullname, bd date)

-- sqlfmt-corpus-separator --

create temp table phrase_index_test(fts tsvector)

-- sqlfmt-corpus-separator --

create temp table pp (f1 int primary key)

-- sqlfmt-corpus-separator --

create temp table pp (f1 text)

-- sqlfmt-corpus-separator --

create temp table pp_temp_parent (a int) partition by list (a)

-- sqlfmt-corpus-separator --

create temp table prtx1 (a integer, b integer, c integer)
  partition by range (a)

-- sqlfmt-corpus-separator --

create temp table prtx2 (a integer, b integer, c integer)
  partition by range (a)

-- sqlfmt-corpus-separator --

create temp table q (a int, b int, c int) partition by list (a)

-- sqlfmt-corpus-separator --

create temp table quadtable(f1 int, q quad)

-- sqlfmt-corpus-separator --

create temp table recur1 (f1 int)

-- sqlfmt-corpus-separator --

create temp table recur2 (f1 int, f2 recur1)

-- sqlfmt-corpus-separator --

create temp table rngfunc(f1 int8, f2 int8)

-- sqlfmt-corpus-separator --

create temp table rtype (id int, ar text[])

-- sqlfmt-corpus-separator --

create temp table self_ref_trigger (
    id int primary key,
    parent int references self_ref_trigger,
    data text,
    nchildren int not null default 0
)

-- sqlfmt-corpus-separator --

create temp table shipped (
    ttype       char(2),
    ordnum      int4,
    partnum     text,
    value       float8
)

-- sqlfmt-corpus-separator --

create temp table skewedtable (val int not null, filt int not null)

-- sqlfmt-corpus-separator --

create temp table snapshot_test (
	nr	integer,
	snap	pg_snapshot
)

-- sqlfmt-corpus-separator --

create temp table snapshot_test (
	nr	integer,
	snap	txid_snapshot
)

-- sqlfmt-corpus-separator --

create temp table src (f1 text)

-- sqlfmt-corpus-separator --

create temp table t (a int unique)

-- sqlfmt-corpus-separator --

create temp table t (a int unique, b int)

-- sqlfmt-corpus-separator --

create temp table t (a int, b int)

-- sqlfmt-corpus-separator --

create temp table t(f1 int, f2 int[], f3 text)

-- sqlfmt-corpus-separator --

create temp table t(i int primary key)

-- sqlfmt-corpus-separator --

create temp table t1 (a integer primary key)

-- sqlfmt-corpus-separator --

create temp table t1 (a integer primary key, b text)

-- sqlfmt-corpus-separator --

create temp table t1 (f1 int, f2 int8)

-- sqlfmt-corpus-separator --

create temp table t1 (f1 int8_tbl[])

-- sqlfmt-corpus-separator --

create temp table t1 (f1 numeric(14,0), f2 varchar(30))

-- sqlfmt-corpus-separator --

create temp table t1(f1 float8)

-- sqlfmt-corpus-separator --

create temp table t1(f1 int, f2 int)

-- sqlfmt-corpus-separator --

create temp table t2 (a integer primary key, b integer references t1)

-- sqlfmt-corpus-separator --

create temp table t2(f1 bigint, f2 oid)

-- sqlfmt-corpus-separator --

create temp table t_append (a int not null, b int)

-- sqlfmt-corpus-separator --

create temp table t_gin_test_tbl(i int4[], j int4[])

-- sqlfmt-corpus-separator --

create temp table ta (id int primary key, val int)

-- sqlfmt-corpus-separator --

create temp table table_a(id integer)

-- sqlfmt-corpus-separator --

create temp table tb (id int primary key, aval int)

-- sqlfmt-corpus-separator --

create temp table tbl_anti(a int not null, b int, c int)

-- sqlfmt-corpus-separator --

create temp table tbl_ra(a int unique, b int)

-- sqlfmt-corpus-separator --

create temp table tbl_rs(a int, b int)

-- sqlfmt-corpus-separator --

create temp table tc (id int primary key, aid int)

-- sqlfmt-corpus-separator --

create temp table temp_inh_oncommit_test (a int) on commit delete rows

-- sqlfmt-corpus-separator --

create temp table temp_inh_oncommit_test (a int) on commit drop

-- sqlfmt-corpus-separator --

create temp table temp_part_child (a int)

-- sqlfmt-corpus-separator --

create temp table temp_part_parent (a int) partition by list (a)

-- sqlfmt-corpus-separator --

create temp table temp_parted_oncommit (a int)
  partition by list (a) on commit delete rows

-- sqlfmt-corpus-separator --

create temp table temp_parted_oncommit_test (a int)
  partition by list (a) on commit delete rows

-- sqlfmt-corpus-separator --

create temp table temp_parted_oncommit_test (a int)
  partition by list (a) on commit drop

-- sqlfmt-corpus-separator --

create temp table test2(f1 multitextrange1[])

-- sqlfmt-corpus-separator --

create temp table test_jsonb_subscript (
       id text,
       test_json jsonb
)

-- sqlfmt-corpus-separator --

create temp table test_table (a text, b text)

-- sqlfmt-corpus-separator --

create temp table text_support_test (t text collate "C")

-- sqlfmt-corpus-separator --

create temp table tidv (idv mycomptype)

-- sqlfmt-corpus-separator --

create temp table tmptz (f1 timestamptz primary key)

-- sqlfmt-corpus-separator --

create temp table tt(f1 serial, data text)

-- sqlfmt-corpus-separator --

create temp table tt1(f1 int)

-- sqlfmt-corpus-separator --

create temp table tt3(f1 int, f2 text)

-- sqlfmt-corpus-separator --

create temp table tt4(f1 int)

-- sqlfmt-corpus-separator --

create temp table tt4x(c1 int, c2 int, c3 int)

-- sqlfmt-corpus-separator --

create temp table tt5(f1 int, f2 int)

-- sqlfmt-corpus-separator --

create temp table tt6(f1 int, f2 int)

-- sqlfmt-corpus-separator --

create temp table tt_log(f1 int, data text)

-- sqlfmt-corpus-separator --

create temp table twophase_tab (a int)

-- sqlfmt-corpus-separator --

create temp table undername (f1 name, f2 int)

-- sqlfmt-corpus-separator --

create temp table uniquetbl (f1 text unique)

-- sqlfmt-corpus-separator --

create temp table upsert(key int4 primary key, val text)

-- sqlfmt-corpus-separator --

create temp table users (userid text, seq int, email text, todrop bool, moredrop int, enabled bool)

-- sqlfmt-corpus-separator --

create temp table users(login text, id serial)

-- sqlfmt-corpus-separator --

create temp table whereami (f1 text)

-- sqlfmt-corpus-separator --

create temp table with_test (i int)

-- sqlfmt-corpus-separator --

create temp table x (x1 int, x2 int)

-- sqlfmt-corpus-separator --

create temp table xx (pkxx int)

-- sqlfmt-corpus-separator --

create temp table y (y1 int, y2 int)

-- sqlfmt-corpus-separator --

create temp table yy (pkyy int, pkxx int)

-- sqlfmt-corpus-separator --

create temp table zt1 (f1 int primary key)

-- sqlfmt-corpus-separator --

create temp table zt2 (f2 int primary key)

-- sqlfmt-corpus-separator --

create temp table zt3 (f3 int primary key)

-- sqlfmt-corpus-separator --

create temporary table gexec_test(a int, b text, c date, d float)

-- sqlfmt-corpus-separator --

create temporary table temp_parted (a int) partition by list (a)

-- sqlfmt-corpus-separator --

create unlogged table gist_tbl (b box)

-- sqlfmt-corpus-separator --

create unlogged table spgist_unlogged_tbl(id serial, b box)

-- sqlfmt-corpus-separator --

create unlogged table t_gin_test_tbl(i int4[], j int4[])

-- sqlfmt-corpus-separator --

insert into insertconflicttest values (1) on conflict (key int4_ops (fillfactor=10)) do nothing

-- sqlfmt-corpus-separator --

select * from
  int8_tbl x cross join (int4_tbl x cross join lateral (select x.f1) ss)

-- sqlfmt-corpus-separator --

select * from rows from(unnest(array[10,20],array['foo','bar'],array[1.0])) with ordinality as z(a,b,c,ord)

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set is_cycle to point '(1,1)' default point '(0,0)' using path
select * from search_graph