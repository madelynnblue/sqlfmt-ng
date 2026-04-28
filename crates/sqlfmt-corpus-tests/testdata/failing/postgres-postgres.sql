MERGE INTO document d
USING (SELECT 4 as sdid) s
ON did = s.sdid
WHEN MATCHED AND dnotes <> '' THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge '
WHEN MATCHED THEN
	DELETE

-- sqlfmt-corpus-separator --

MERGE INTO document d
USING (SELECT 4 as sdid) s
ON did = s.sdid
WHEN MATCHED AND dnotes <> '' THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge '
WHEN MATCHED THEN
	DO NOTHING

-- sqlfmt-corpus-separator --

MERGE INTO document d
USING (SELECT 4 as sdid) s
ON did = s.sdid
WHEN MATCHED AND dnotes = '' THEN
	UPDATE SET dnotes = dnotes || ' notes added by merge '
WHEN MATCHED THEN
	DELETE

-- sqlfmt-corpus-separator --

MERGE INTO itest15 t
USING (SELECT 20 AS s_a, 'inserted by merge' AS s_b) s
ON t.a = s.s_a
WHEN NOT MATCHED THEN
	INSERT (a, b) OVERRIDING USER VALUE VALUES (s.s_a, s.s_b)

-- sqlfmt-corpus-separator --

MERGE INTO itest15 t
USING (SELECT 30 AS s_a, 'inserted by merge' AS s_b) s
ON t.a = s.s_a
WHEN NOT MATCHED THEN
	INSERT (a, b) OVERRIDING SYSTEM VALUE VALUES (s.s_a, s.s_b)

-- sqlfmt-corpus-separator --

MERGE INTO itest16 t
USING (SELECT 20 AS s_a, 'inserted by merge' AS s_b) s
ON t.a = s.s_a
WHEN NOT MATCHED THEN
	INSERT (a, b) OVERRIDING USER VALUE VALUES (s.s_a, s.s_b)

-- sqlfmt-corpus-separator --

MERGE INTO itest16 t
USING (SELECT 30 AS s_a, 'inserted by merge' AS s_b) s
ON t.a = s.s_a
WHEN NOT MATCHED THEN
	INSERT (a, b) OVERRIDING SYSTEM VALUE VALUES (s.s_a, s.s_b)

-- sqlfmt-corpus-separator --

MERGE INTO mtarget t USING msource s ON t.a = s.a
WHEN MATCHED AND s.b = 'x' THEN
	UPDATE SET b = 'x'
WHEN NOT MATCHED THEN
	INSERT VALUES (a, NULL)

-- sqlfmt-corpus-separator --

MERGE INTO mtarget t USING msource s ON t.a = s.a
WHEN MATCHED AND t.b IS NOT NULL THEN
	UPDATE SET b = s.b
WHEN NOT MATCHED THEN
	INSERT VALUES (a, b)

-- sqlfmt-corpus-separator --

MERGE INTO rw_view1 t
  USING (VALUES ('Tom'), ('Dick'), ('Harry')) AS v(person) ON t.person = v.person
  WHEN MATCHED AND snoop(t.person) THEN UPDATE SET person = v.person

-- sqlfmt-corpus-separator --

MERGE INTO rw_view2 t
  USING (VALUES ('Tom'), ('Dick'), ('Harry')) AS v(person) ON t.person = v.person
  WHEN MATCHED AND snoop(t.person) THEN UPDATE SET person = v.person

-- sqlfmt-corpus-separator --

MERGE INTO sq_target t
USING (SELECT * FROM sq_source) s
ON tid = sid
WHEN MATCHED AND t.balance > delta THEN
	UPDATE SET balance = t.balance + delta

-- sqlfmt-corpus-separator --

MERGE INTO sq_target t
USING v
ON tid = sid
WHEN MATCHED AND (SELECT count(*) > 0 FROM sq_target) THEN
    UPDATE SET balance = 42

-- sqlfmt-corpus-separator --

MERGE INTO target t
USING source AS s
ON t.tid = s.sid
WHEN MATCHED AND t.balance > s.delta THEN
	UPDATE SET balance = t.balance - s.delta
WHEN MATCHED THEN
	DELETE
WHEN NOT MATCHED THEN
	INSERT VALUES (s.sid, s.delta)

-- sqlfmt-corpus-separator --

MERGE INTO testpub_merge_pk USING testpub_merge_no_ri s ON s.a >= 1
 WHEN MATCHED AND s.a > 0 THEN UPDATE SET b = s.b
 WHEN MATCHED THEN DELETE

-- sqlfmt-corpus-separator --

MERGE INTO wq_target t
USING wq_source s ON (t.tid = s.sid)
WHEN matched and t = s or t.tid = s.sid THEN
	UPDATE SET balance = t.balance + s.balance

-- sqlfmt-corpus-separator --

MERGE INTO wq_target t
USING wq_source s ON t.tid = s.sid
WHEN MATCHED AND s.balance = 100 THEN
	UPDATE SET balance = t.balance + s.balance

-- sqlfmt-corpus-separator --

MERGE INTO wq_target t
USING wq_source s ON t.tid = s.sid
WHEN MATCHED AND t.balance = 100 THEN
	UPDATE SET balance = t.balance + s.balance

-- sqlfmt-corpus-separator --

MERGE INTO wq_target t
USING wq_source s ON t.tid = s.sid
WHEN MATCHED AND t.balance = 199 OR s.balance > 100 THEN
	UPDATE SET balance = t.balance + s.balance

-- sqlfmt-corpus-separator --

MERGE INTO wq_target t
USING wq_source s ON t.tid = s.sid
WHEN MATCHED AND t.balance = 99 AND s.balance = 100 THEN
	UPDATE SET balance = t.balance + s.balance

-- sqlfmt-corpus-separator --

MERGE INTO wq_target t
USING wq_source s ON t.tid = s.sid
WHEN MATCHED AND t.balance = 99 AND s.balance > 100 THEN
	UPDATE SET balance = t.balance + s.balance

-- sqlfmt-corpus-separator --

MERGE INTO wq_target t
USING wq_source s ON t.tid = s.sid
WHEN MATCHED AND t.balance = 99 OR s.balance > 100 THEN
	UPDATE SET balance = t.balance + s.balance

-- sqlfmt-corpus-separator --

MERGE INTO wq_target t
USING wq_source s ON t.tid = s.sid
WHEN MATCHED AND t.balance > (SELECT max(balance) FROM target) THEN
	UPDATE SET balance = t.balance + s.balance

-- sqlfmt-corpus-separator --

MERGE INTO wq_target t
USING wq_source s ON t.tid = s.sid
WHEN MATCHED AND t.tableoid >= 0 THEN
	UPDATE SET balance = t.balance + s.balance

-- sqlfmt-corpus-separator --

MERGE INTO wq_target t
USING wq_source s ON t.tid = s.sid
WHEN MATCHED AND t.xmin = t.xmax THEN
	UPDATE SET balance = t.balance + s.balance

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1),(2),(3)) v(r) LEFT JOIN ROWS FROM( rngfunc_sql(11,13), rngfunc_mat(11,13) ) WITH ORDINALITY AS f(i1,s1,i2,s2,o) ON (r+i1+i2)<100

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1),(2),(3)) v(r) LEFT JOIN generate_series(11,13) WITH ORDINALITY AS f(i,o) ON (r+i)<100

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1),(2),(3)) v(r) LEFT JOIN rngfunc_mat(11,13) WITH ORDINALITY AS f(i,s,o) ON (r+i)<100

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1),(2),(3)) v(r) LEFT JOIN rngfunc_sql(11,13) WITH ORDINALITY AS f(i,s,o) ON (r+i)<100

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1),(2),(3)) v(r) LEFT JOIN unnest(array[10,20,30]) WITH ORDINALITY AS f(i,o) ON (r+i)<100

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1),(2),(3)) v(r), generate_series(10+r,20-r) WITH ORDINALITY AS f(i,o)

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1),(2),(3)) v(r), rngfunc_mat(10+r,13) WITH ORDINALITY AS f(i,s,o)

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1),(2),(3)) v(r), rngfunc_mat(11,10+r) WITH ORDINALITY AS f(i,s,o)

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1),(2),(3)) v(r), rngfunc_sql(10+r,13) WITH ORDINALITY AS f(i,s,o)

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1),(2),(3)) v(r), rngfunc_sql(11,10+r) WITH ORDINALITY AS f(i,s,o)

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (1),(2),(3)) v(r), unnest(array[r*10,r*20,r*30]) WITH ORDINALITY AS f(i,o)

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (11,12),(13,15),(16,20)) v(r1,r2), rngfunc_mat(r1,r2) WITH ORDINALITY AS f(i,s,o)

-- sqlfmt-corpus-separator --

SELECT * FROM (VALUES (11,12),(13,15),(16,20)) v(r1,r2), rngfunc_sql(r1,r2) WITH ORDINALITY AS f(i,s,o)

-- sqlfmt-corpus-separator --

SELECT * FROM (int8_tbl i cross join int4_tbl j) ss(a,b,c,d)

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM(generate_series(10,11), get_users()) WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM(get_users(), generate_series(10,11)) WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT * FROM get_users() WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT * FROM getrngfunc1(1) WITH ORDINALITY AS t1(v,o)

-- sqlfmt-corpus-separator --

SELECT * FROM getrngfunc2(1) WITH ORDINALITY AS t1(v,o)

-- sqlfmt-corpus-separator --

SELECT * FROM getrngfunc3(1) WITH ORDINALITY AS t1(v,o)

-- sqlfmt-corpus-separator --

SELECT * FROM getrngfunc4(1) WITH ORDINALITY AS t1(a,b,c,o)

-- sqlfmt-corpus-separator --

SELECT * FROM getrngfunc5(1) WITH ORDINALITY AS t1(a,b,c,o)

-- sqlfmt-corpus-separator --

SELECT * FROM getrngfunc8(1) WITH ORDINALITY AS t1(v,o)

-- sqlfmt-corpus-separator --

SELECT * FROM getrngfunc9(1) WITH ORDINALITY AS t1(a,b,c,o)

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

SELECT ii, tt, kk
  FROM (J1_TBL CROSS JOIN J2_TBL)
    AS tx (ii, jj, tt, ii2, kk)

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

SELECT tx.ii, tx.jj, tx.kk
  FROM (J1_TBL t1 (a, b, c) CROSS JOIN J2_TBL t2 (d, e))
    AS tx (ii, jj, tt, ii2, kk)

-- sqlfmt-corpus-separator --

UPDATE arrtest_s SET a[:3] = '{11, 12, 13}', b[:2][:2] = '{{11,12}, {14,15}}'
  WHERE array_lower(a,1) = 1

-- sqlfmt-corpus-separator --

UPDATE arrtest_s SET a[:] = '{11, 12, 13, 14, 15}'

-- sqlfmt-corpus-separator --

UPDATE arrtest_s SET a[:] = '{23, 24, 25}'

-- sqlfmt-corpus-separator --

UPDATE update_test t SET t.b = t.b + 10 WHERE t.a = 10

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

insert into dcomptable (d1.r) values(11)

-- sqlfmt-corpus-separator --

insert into dcomptable (d1.r) values(99)

-- sqlfmt-corpus-separator --

insert into dcomptable (d1.r, d1.i) values(100, 99)

-- sqlfmt-corpus-separator --

insert into dcomptable (d1.r, d1.i) values(99, 100)

-- sqlfmt-corpus-separator --

insert into dcomptable (d1[1].r) values(11)

-- sqlfmt-corpus-separator --

insert into dcomptable (d1[1].r) values(99)

-- sqlfmt-corpus-separator --

insert into dcomptable (d1[1].r, d1[1].i) values(100, 99)

-- sqlfmt-corpus-separator --

insert into dcomptable (d1[1].r, d1[1].i) values(99, 100)

-- sqlfmt-corpus-separator --

insert into insertconflicttest values (1) on conflict (key asc) do nothing

-- sqlfmt-corpus-separator --

insert into insertconflicttest values (1) on conflict (key int4_ops (fillfactor=10)) do nothing

-- sqlfmt-corpus-separator --

insert into insertconflicttest values (1) on conflict (key nulls last) do nothing

-- sqlfmt-corpus-separator --

insert into insertconflicttest values (3, 'Kiwi') on conflict (key, fruit) do update set insertconflicttest.fruit = 'Mango'

-- sqlfmt-corpus-separator --

insert into inserttest (f3.if1, f3.if2) select 3, '{baz,quux}'

-- sqlfmt-corpus-separator --

insert into inserttest (f3.if1, f3.if2) values (1,'{foo}'), (2,'{bar}')

-- sqlfmt-corpus-separator --

insert into inserttest (f3.if1, f3.if2) values (1,array['foo'])

-- sqlfmt-corpus-separator --

insert into inserttest (f3.if2[1], f3.if2[2]) select 'bear', 'beer'

-- sqlfmt-corpus-separator --

insert into inserttest (f3.if2[1], f3.if2[2]) values ('foo', 'bar')

-- sqlfmt-corpus-separator --

insert into inserttest (f3.if2[1], f3.if2[2]) values ('foo', 'bar'), ('baz', 'quux')

-- sqlfmt-corpus-separator --

insert into inserttest (f4[1].if2[1], f4[1].if2[2]) select 'bear', 'beer'

-- sqlfmt-corpus-separator --

insert into inserttest (f4[1].if2[1], f4[1].if2[2]) values ('foo', 'bar')

-- sqlfmt-corpus-separator --

insert into inserttest (f4[1].if2[1], f4[1].if2[2]) values ('foo', 'bar'), ('baz', 'quux')

-- sqlfmt-corpus-separator --

insert into inserttestb (f1.if1) values (1)

-- sqlfmt-corpus-separator --

insert into inserttestb (f1.if1, f1.if2) values (1, '{foo}')

-- sqlfmt-corpus-separator --

insert into inserttestb (f3, f4[1].if2[1], f4[1].if2[2]) select row(1,'{x}')::insert_test_domain, 'bear', 'beer'

-- sqlfmt-corpus-separator --

insert into inserttestb (f3, f4[1].if2[1], f4[1].if2[2]) values (row(1,'{x}'), 'foo', 'bar')

-- sqlfmt-corpus-separator --

insert into inserttestb (f3, f4[1].if2[1], f4[1].if2[2]) values (row(1,'{x}'), 'foo', 'bar'), (row(2,'{y}'), 'baz', 'quux')

-- sqlfmt-corpus-separator --

insert into inserttestb (f3.if1, f3.if2) select 3, '{baz,quux}'

-- sqlfmt-corpus-separator --

insert into inserttestb (f3.if1, f3.if2) select 3, '{null,quux}'

-- sqlfmt-corpus-separator --

insert into inserttestb (f3.if1, f3.if2) values (1,'{foo}'), (2,'{bar}')

-- sqlfmt-corpus-separator --

insert into inserttestb (f3.if1, f3.if2) values (1,'{null}'), (2,'{bar}')

-- sqlfmt-corpus-separator --

insert into inserttestb (f3.if1, f3.if2) values (1,array['foo'])

-- sqlfmt-corpus-separator --

insert into inserttestb (f3.if1, f3.if2) values (1,array[null])

-- sqlfmt-corpus-separator --

insert into inserttestb (f3.if2[1], f3.if2[2]) select 'bear', 'beer'

-- sqlfmt-corpus-separator --

insert into inserttestb (f3.if2[1], f3.if2[2]) values ('foo', 'bar')

-- sqlfmt-corpus-separator --

insert into inserttestb (f3.if2[1], f3.if2[2]) values ('foo', 'bar'), ('baz', 'quux')

-- sqlfmt-corpus-separator --

insert into quadtable (f1, q.c1.r, q.c2.i) values(44,55,66)

-- sqlfmt-corpus-separator --

insert into t1 (f1[5].q1) values(42)

-- sqlfmt-corpus-separator --

merge into parted_trig using (select 1) as ss on true
  when matched and a = 2 then update set a = 1

-- sqlfmt-corpus-separator --

select * from
  int8_tbl x cross join (int4_tbl x cross join lateral (select x.f1) ss)

-- sqlfmt-corpus-separator --

select * from
  int8_tbl x join (int4_tbl x cross join int4_tbl y(ff)) j on q1 = f1

-- sqlfmt-corpus-separator --

select * from
  int8_tbl x join (int4_tbl x cross join int4_tbl y) j on q1 = f1

-- sqlfmt-corpus-separator --

select * from
  int8_tbl x join (int4_tbl x cross join int4_tbl y) j on q1 = y.f1

-- sqlfmt-corpus-separator --

select * from
int4_tbl i0 left join
( (select *, 123 as x from int4_tbl i1) ss1
  left join
  (select *, q2 as x from int8_tbl i2) ss2
  using (x)
) ss0
on (i0.f1 = ss0.f1)
order by i0.f1, x

-- sqlfmt-corpus-separator --

select * from ((select f1/2 as x from int4_tbl) ss1 join int4_tbl i4 on x = f1) j,
  lateral (select x) ss2(y)

-- sqlfmt-corpus-separator --

select * from rngfunc2, rngfunct(rngfunc2.rngfuncid) with ordinality as z(rngfuncid,f2,ord) where rngfunc2.f2 = z.f2

-- sqlfmt-corpus-separator --

select * from rngfunct(1) with ordinality as z(a,b,ord)

-- sqlfmt-corpus-separator --

select * from rngfunct(1) with ordinality as z(a,b,ord) where b > 100

-- sqlfmt-corpus-separator --

select * from rows from(rngfunct(1),rngfunct(2)) with ordinality as z(a,b,c,d,ord)

-- sqlfmt-corpus-separator --

select * from rows from(unnest(array[10,20],array['foo','bar']), generate_series(101,102)) with ordinality as z(a,b,c,ord)

-- sqlfmt-corpus-separator --

select * from rows from(unnest(array[10,20],array['foo','bar'],array[1.0])) with ordinality as z(a,b,c,ord)

-- sqlfmt-corpus-separator --

select * from unnest(array['a','b']) with ordinality as z(a,ord)

-- sqlfmt-corpus-separator --

select * from unnest(array[1.0::float8]) with ordinality as z(a,ord)

-- sqlfmt-corpus-separator --

select * from unnest(array[10,20],array['foo','bar'],array[1.0]) with ordinality as z(a,b,c,ord)

-- sqlfmt-corpus-separator --

select a,b,ord from rngfunct(1) with ordinality as z(a,b,ord)

-- sqlfmt-corpus-separator --

select a,ord from unnest(array['a','b']) with ordinality as z(a,ord)

-- sqlfmt-corpus-separator --

select a,ord from unnest(array[1.0::float8]) with ordinality as z(a,ord)

-- sqlfmt-corpus-separator --

select amname, prop, pg_indexam_has_property(a.oid, prop) as p
  from pg_am a,
       unnest(array['can_order', 'can_unique', 'can_multi_col',
                    'can_exclude', 'can_include', 'bogus']::text[])
         with ordinality as u(prop,ord)
 where amtype = 'i'
 order by amname, ord

-- sqlfmt-corpus-separator --

select prop,
       pg_index_column_has_property('onek_hundred'::regclass, 1, prop) as btree,
       pg_index_column_has_property('hash_i4_index'::regclass, 1, prop) as hash,
       pg_index_column_has_property('gcircleind'::regclass, 1, prop) as gist,
       pg_index_column_has_property('sp_radix_ind'::regclass, 1, prop) as spgist_radix,
       pg_index_column_has_property('sp_quad_ind'::regclass, 1, prop) as spgist_quad,
       pg_index_column_has_property('botharrayidx'::regclass, 1, prop) as gin,
       pg_index_column_has_property('brinidx'::regclass, 1, prop) as brin
  from unnest(array['asc', 'desc', 'nulls_first', 'nulls_last',
                    'orderable', 'distance_orderable', 'returnable',
                    'search_array', 'search_nulls',
                    'bogus']::text[])
         with ordinality as u(prop,ord)
 order by ord

-- sqlfmt-corpus-separator --

select prop,
       pg_index_has_property('onek_hundred'::regclass, prop) as btree,
       pg_index_has_property('hash_i4_index'::regclass, prop) as hash,
       pg_index_has_property('gcircleind'::regclass, prop) as gist,
       pg_index_has_property('sp_radix_ind'::regclass, prop) as spgist,
       pg_index_has_property('botharrayidx'::regclass, prop) as gin,
       pg_index_has_property('brinidx'::regclass, prop) as brin
  from unnest(array['clusterable', 'index_scan', 'bitmap_scan',
                    'backward_scan',
                    'bogus']::text[])
         with ordinality as u(prop,ord)
 order by ord

-- sqlfmt-corpus-separator --

select prop,
       pg_indexam_has_property(a.oid, prop) as "AM",
       pg_index_has_property('gcircleind'::regclass, prop) as "Index",
       pg_index_column_has_property('gcircleind'::regclass, 1, prop) as "Column"
  from pg_am a,
       unnest(array['asc', 'desc', 'nulls_first', 'nulls_last',
                    'orderable', 'distance_orderable', 'returnable',
                    'search_array', 'search_nulls',
                    'clusterable', 'index_scan', 'bitmap_scan',
                    'backward_scan',
                    'can_order', 'can_unique', 'can_multi_col',
                    'can_exclude', 'can_include',
                    'bogus']::text[])
         with ordinality as u(prop,ord)
 where a.amname = 'gist'
 order by ord

-- sqlfmt-corpus-separator --

select prop,
       pg_indexam_has_property(a.oid, prop) as "AM",
       pg_index_has_property('onek_hundred'::regclass, prop) as "Index",
       pg_index_column_has_property('onek_hundred'::regclass, 1, prop) as "Column"
  from pg_am a,
       unnest(array['asc', 'desc', 'nulls_first', 'nulls_last',
                    'orderable', 'distance_orderable', 'returnable',
                    'search_array', 'search_nulls',
                    'clusterable', 'index_scan', 'bitmap_scan',
                    'backward_scan',
                    'can_order', 'can_unique', 'can_multi_col',
                    'can_exclude', 'can_include',
                    'bogus']::text[])
         with ordinality as u(prop,ord)
 where a.amname = 'btree'
 order by ord

-- sqlfmt-corpus-separator --

select row_to_json(s.*) from generate_series(11,14) with ordinality s

-- sqlfmt-corpus-separator --

update dcomptable set f1[1].cf1 = -1

-- sqlfmt-corpus-separator --

update dcomptable set f1[1].cf1 = 1

-- sqlfmt-corpus-separator --

update dcomptable set f1[1].cf2 = 5

-- sqlfmt-corpus-separator --

update people set fn.first = 'Jack'

-- sqlfmt-corpus-separator --

update people set fn.suffix = 'Jr'

-- sqlfmt-corpus-separator --

update quadtable set q.c1 = 12

-- sqlfmt-corpus-separator --

update quadtable set q.c1.r = 12 where f1 = 2

-- sqlfmt-corpus-separator --

update t1 set f1[5].q2 = 43

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set is_cycle to point '(1,1)' default point '(0,0)' using path
select * from search_graph