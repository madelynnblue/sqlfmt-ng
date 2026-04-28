SELECT sum((3 = ANY(SELECT generate_series(1,4)))::int)

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

WITH RECURSIVE foo(x) AS
   (SELECT x FROM (VALUES('a' COLLATE "C"),('b')) t(x)
   UNION ALL
   SELECT (x || 'c') COLLATE "POSIX" FROM foo WHERE length(x) < 10)
SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(x) AS
   (SELECT x FROM (VALUES('a' COLLATE "en-x-icu"),('b')) t(x)
   UNION ALL
   SELECT (x || 'c') COLLATE "de-x-icu" FROM foo WHERE length(x) < 10)
SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(x) AS
   (SELECT x FROM (VALUES('a' COLLATE "en_US"),('b')) t(x)
   UNION ALL
   SELECT (x || 'c') COLLATE "de_DE" FROM foo WHERE length(x) < 10)
SELECT * FROM foo

-- sqlfmt-corpus-separator --

select (1 = any(array_agg(f1))) = any (select false) from int4_tbl

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set is_cycle to point '(1,1)' default point '(0,0)' using path
select * from search_graph