DECLARE c CURSOR FOR
SELECT ctid, * FROM tidscan WHERE ctid = ANY(ARRAY['(0,1)', '(0,2)']::tid[])

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT * from hash_split_heap WHERE keycol = 1

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT ctid,cmin,* FROM combocidtest

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT f1,count(*) FROM uctest GROUP BY f1

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT unique2/0 FROM tenk1 ORDER BY unique2

-- sqlfmt-corpus-separator --

DECLARE c1 CURSOR FOR SELECT * FROM uctest a, uctest b WHERE a.f1 = b.f1 + 5

-- sqlfmt-corpus-separator --

PREPARE data_sel AS SELECT generate_series(1,3)

-- sqlfmt-corpus-separator --

PREPARE foo AS
  SELECT id, keywords, title, body, created
  FROM articles
  GROUP BY id

-- sqlfmt-corpus-separator --

PREPARE p1 AS SELECT $0_1

-- sqlfmt-corpus-separator --

PREPARE p1 AS SELECT $1a

-- sqlfmt-corpus-separator --

PREPARE select1 AS SELECT 1 as a

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