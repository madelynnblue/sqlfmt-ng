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

select * from
  int8_tbl x cross join (int4_tbl x cross join lateral (select x.f1) ss)

-- sqlfmt-corpus-separator --

select * from rows from(unnest(array[10,20],array['foo','bar'],array[1.0])) with ordinality as z(a,b,c,ord)

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