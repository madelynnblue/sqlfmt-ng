CREATE TABLE pagg_tab_m (a int, b int, c int) PARTITION BY RANGE(a, ((a+b)/2))

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

CREATE TABLE partitioned2 (
	a int,
	b text
) PARTITION BY RANGE ((a+1), substr(b, 1, 5))

-- sqlfmt-corpus-separator --

CREATE TABLE prt1_e (a int, b int, c int) PARTITION BY RANGE(((a + b)/2))

-- sqlfmt-corpus-separator --

CREATE TABLE prt1_m (a int, b int, c int) PARTITION BY RANGE(a, ((a + b)/2))

-- sqlfmt-corpus-separator --

CREATE TABLE prt2_e (a int, b int, c int) PARTITION BY RANGE(((b + a)/2))

-- sqlfmt-corpus-separator --

CREATE TABLE prt2_m (a int, b int, c int) PARTITION BY RANGE(((b + a)/2), b)

-- sqlfmt-corpus-separator --

CREATE TABLE range_parted3 (
	a int,
	b int
) PARTITION BY RANGE (a, (b+1))

-- sqlfmt-corpus-separator --

CREATE TABLE t (i int PRIMARY KEY USING INDEX TABLESPACE regress_tblspace)
  PARTITION BY RANGE (i) TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

CREATE TABLE test_chunk_id (a TEXT, b TEXT STORAGE EXTERNAL)

-- sqlfmt-corpus-separator --

CREATE TABLE testschema.dflt (a int PRIMARY KEY USING INDEX TABLESPACE pg_default) PARTITION BY LIST (a)

-- sqlfmt-corpus-separator --

CREATE TABLE testschema.dflt (a int PRIMARY KEY USING INDEX TABLESPACE regress_tblspace) PARTITION BY LIST (a)

-- sqlfmt-corpus-separator --

CREATE TABLE testschema.dflt (a int PRIMARY KEY USING INDEX TABLESPACE regress_tblspace) PARTITION BY LIST (a) TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

CREATE TABLE vac_rewrite_toast (id int, f1 TEXT STORAGE plain)

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

create table coll_pruning_multi (a text) partition by range (substr(a, 1) collate "POSIX", substr(a, 1) collate "C")

-- sqlfmt-corpus-separator --

create table iboolpart (a bool) partition by list ((not a))

-- sqlfmt-corpus-separator --

create table idxpart (a int primary key, b int) partition by range ((b + a))

-- sqlfmt-corpus-separator --

create table idxpart (a int unique, b int) partition by range ((b + a))

-- sqlfmt-corpus-separator --

create table key_desc (a int, b int) partition by list ((a+0))

-- sqlfmt-corpus-separator --

create table mlparted1 (b int not null, a int not null) partition by range ((b+0))

-- sqlfmt-corpus-separator --

create table nv_parent (d date, check (false) no inherit not valid)

-- sqlfmt-corpus-separator --

create table parted (a int, b int, c text) partition by list ((a + b))

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

create table test_storage (a text, c text storage plain)

-- sqlfmt-corpus-separator --

create table test_storage_failed (a text, b int storage extended)

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