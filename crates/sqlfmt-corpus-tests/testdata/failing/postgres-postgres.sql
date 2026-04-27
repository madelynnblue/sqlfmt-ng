SELECT *
  FROM J1_TBL AS t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT *
  FROM J1_TBL t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT *
  FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)

-- sqlfmt-corpus-separator --

SELECT * FROM INT2_TBL AS f(a, b)

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test10 WHERE (x COLLATE "POSIX", y COLLATE "C") NOT IN (SELECT y, x FROM collate_test10)

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test10 WHERE (x, y) NOT IN (SELECT y, x FROM collate_test10)

-- sqlfmt-corpus-separator --

SELECT * FROM outer_text WHERE (f1, f2) NOT IN (SELECT * FROM inner_text)

-- sqlfmt-corpus-separator --

SELECT * FROM pxtest_rowlock WHERE id = 1 FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT 1 IS DISTINCT FROM 2 as "yes"

-- sqlfmt-corpus-separator --

SELECT 1 IS NOT DISTINCT FROM 2 as "no"

-- sqlfmt-corpus-separator --

SELECT 2 IS DISTINCT FROM 2 as "no"

-- sqlfmt-corpus-separator --

SELECT 2 IS DISTINCT FROM null as "yes"

-- sqlfmt-corpus-separator --

SELECT 2 IS NOT DISTINCT FROM 2 as "yes"

-- sqlfmt-corpus-separator --

SELECT 2 IS NOT DISTINCT FROM null as "no"

-- sqlfmt-corpus-separator --

SELECT COUNT(*) OVER w FROM tenk1 WHERE unique2 < 10 WINDOW w AS ()

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (string4) string4, two, ten
   FROM onek
   ORDER BY string4 using <, two using >, ten using <

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (string4, ten) string4, ten, two
   FROM onek
   ORDER BY string4 using <, ten using >, two using <

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (string4, ten) string4, two, ten
   FROM onek
   ORDER BY string4 using <, two using <, ten using <

-- sqlfmt-corpus-separator --

SELECT a, b COLLATE "C" FROM collate_test1 UNION SELECT a, b FROM collate_test2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b COLLATE "C" FROM collate_test1 UNION SELECT a, b FROM collate_test3 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a.f1 FROM (SELECT 'test' AS f1 FROM varchar_tbl) a
UNION
SELECT b.f1 FROM (SELECT f1 FROM varchar_tbl) b
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT a1.amopfamily, a1.amopstrategy
FROM pg_amop as a1
WHERE NOT ((a1.amoppurpose = 's' AND a1.amopsortfamily = 0) OR
           (a1.amoppurpose = 'o' AND a1.amopsortfamily <> 0))

-- sqlfmt-corpus-separator --

SELECT array_agg(a ORDER BY x COLLATE "C", y COLLATE "POSIX") FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY guid_encoded COLLATE "C") FROM guid3

-- sqlfmt-corpus-separator --

SELECT count(*) OVER w FROM tenk1 WINDOW w AS (ORDER BY unique1), w AS (ORDER BY unique1)

-- sqlfmt-corpus-separator --

SELECT depname, empno, salary, rank() OVER w FROM empsalary WINDOW w AS (PARTITION BY depname ORDER BY salary) ORDER BY rank() OVER w

-- sqlfmt-corpus-separator --

SELECT depname, empno, salary, sum(salary) OVER w FROM empsalary WINDOW w AS (PARTITION BY depname)

-- sqlfmt-corpus-separator --

SELECT f1 AS five FROM FLOAT8_TBL
  WHERE f1 BETWEEN -1e6 AND 1e6
UNION
SELECT f1 FROM INT4_TBL
  WHERE f1 BETWEEN 0 AND 1000000
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1, f1 IS DISTINCT FROM f1 as "false" FROM disttable

-- sqlfmt-corpus-separator --

SELECT first_value(unique1) over (ORDER BY four rows between current row and 2 following exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT first_value(unique1) over (ORDER BY four rows between current row and 2 following exclude group),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT first_value(unique1) over (ORDER BY four rows between current row and 2 following exclude ties),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT first_value(unique1) over w,
	nth_value(unique1, 2) over w AS nth_2,
	last_value(unique1) over w, unique1, four
FROM tenk1 WHERE unique1 < 10
WINDOW w AS (order by four range between current row and unbounded following)

-- sqlfmt-corpus-separator --

SELECT four FROM tenk1 WHERE FALSE WINDOW w AS (PARTITION BY ten)

-- sqlfmt-corpus-separator --

SELECT generate_series(1,3) IS DISTINCT FROM 2

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_nn IS DISTINCT FROM 10

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_nn IS DISTINCT FROM NULL::INT

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_nn IS NOT DISTINCT FROM 10

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_nn IS NOT DISTINCT FROM NULL::INT

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_null IS DISTINCT FROM 20

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_null IS DISTINCT FROM NULL::INT

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_null IS NOT DISTINCT FROM NULL::INT

-- sqlfmt-corpus-separator --

SELECT json_build_array(VARIADIC '{1,2,3,4}'::int[])

-- sqlfmt-corpus-separator --

SELECT json_build_array(VARIADIC '{1,2,3,4}'::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_array(VARIADIC '{a,b,c}'::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_array(VARIADIC '{{1,4},{2,5},{3,6}}'::int[][])

-- sqlfmt-corpus-separator --

SELECT json_build_array(VARIADIC '{}'::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_array(VARIADIC NULL::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_object(VARIADIC '{1,2,3,4}'::int[])

-- sqlfmt-corpus-separator --

SELECT json_build_object(VARIADIC '{1,2,3,4}'::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_object(VARIADIC '{a,b,c}'::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_object(VARIADIC '{{1,4},{2,5},{3,6}}'::int[][])

-- sqlfmt-corpus-separator --

SELECT json_build_object(VARIADIC '{}'::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_object(VARIADIC NULL::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array(VARIADIC '{1,2,3,4}'::int[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array(VARIADIC '{1,2,3,4}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array(VARIADIC '{a,b,c}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array(VARIADIC '{{1,4},{2,5},{3,6}}'::int[][])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array(VARIADIC '{}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array(VARIADIC NULL::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(VARIADIC '{1,2,3,4}'::int[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(VARIADIC '{1,2,3,4}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(VARIADIC '{a,b,c}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(VARIADIC '{{1,4},{2,5},{3,6}}'::int[][])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(VARIADIC '{}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(VARIADIC NULL::text[])

-- sqlfmt-corpus-separator --

SELECT last_value(unique1) over (ORDER BY four rows between current row and 2 following exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT last_value(unique1) over (ORDER BY four rows between current row and 2 following exclude group),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT last_value(unique1) over (ORDER BY four rows between current row and 2 following exclude ties),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT last_value(unique1) over (ORDER BY four rows between current row and 9223372036854775807 following exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT null IS DISTINCT FROM null as "no"

-- sqlfmt-corpus-separator --

SELECT null IS NOT DISTINCT FROM null as "yes"

-- sqlfmt-corpus-separator --

SELECT num_nonnulls(VARIADIC '{"1","2","3","4"}'::text[])

-- sqlfmt-corpus-separator --

SELECT num_nonnulls(VARIADIC '{1,2,NULL,3}'::int[])

-- sqlfmt-corpus-separator --

SELECT num_nonnulls(VARIADIC '{}'::int[])

-- sqlfmt-corpus-separator --

SELECT num_nonnulls(VARIADIC NULL::text[])

-- sqlfmt-corpus-separator --

SELECT num_nulls(VARIADIC '{"1","2","3","4"}'::text[])

-- sqlfmt-corpus-separator --

SELECT num_nulls(VARIADIC '{1,2,NULL,3}'::int[])

-- sqlfmt-corpus-separator --

SELECT num_nulls(VARIADIC '{}'::int[])

-- sqlfmt-corpus-separator --

SELECT num_nulls(VARIADIC NULL::text[])

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname FROM pg_operator AS o1
WHERE (o1.oprcanmerge OR o1.oprcanhash) AND NOT
    (o1.oprkind = 'b' AND o1.oprresult = 'bool'::regtype AND o1.oprcom != 0)

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT (((SELECT q2 FROM int8_tbl ORDER BY q2 LIMIT 1))) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT ALL SELECT q1 FROM int8_tbl FOR NO KEY UPDATE

-- sqlfmt-corpus-separator --

SELECT relname, relkind, relpersistence FROM pg_class WHERE relname ~ '^logged1'
UNION ALL
SELECT r.relname || ' toast table', t.relkind, t.relpersistence FROM pg_class r JOIN pg_class t ON t.oid = r.reltoastrelid WHERE r.relname ~ '^logged1'
UNION ALL
SELECT r.relname || ' toast index', ri.relkind, ri.relpersistence FROM pg_class r join pg_class t ON t.oid = r.reltoastrelid JOIN pg_index i ON i.indrelid = t.oid JOIN pg_class ri ON ri.oid = i.indexrelid WHERE r.relname ~ '^logged1'
ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT relname, relkind, relpersistence FROM pg_class WHERE relname ~ '^logged1'
UNION ALL
SELECT r.relname || ' toast table', t.relkind, t.relpersistence FROM pg_class r JOIN pg_class t ON t.oid = r.reltoastrelid WHERE r.relname ~ '^logged1'
UNION ALL
SELECT r.relname ||' toast index', ri.relkind, ri.relpersistence FROM pg_class r join pg_class t ON t.oid = r.reltoastrelid JOIN pg_index i ON i.indrelid = t.oid JOIN pg_class ri ON ri.oid = i.indexrelid WHERE r.relname ~ '^logged1'
ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT relname, relkind, relpersistence FROM pg_class WHERE relname ~ '^unlogged1'
UNION ALL
SELECT r.relname || ' toast table', t.relkind, t.relpersistence FROM pg_class r JOIN pg_class t ON t.oid = r.reltoastrelid WHERE r.relname ~ '^unlogged1'
UNION ALL
SELECT r.relname || ' toast index', ri.relkind, ri.relpersistence FROM pg_class r join pg_class t ON t.oid = r.reltoastrelid JOIN pg_index i ON i.indrelid = t.oid JOIN pg_class ri ON ri.oid = i.indexrelid WHERE r.relname ~ '^unlogged1'
ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT sum((3 = ANY(SELECT generate_series(1,4)))::int)

-- sqlfmt-corpus-separator --

SELECT sum(salary) OVER w, rank() OVER w FROM empsalary WINDOW w AS (PARTITION BY depname ORDER BY salary DESC)

-- sqlfmt-corpus-separator --

SELECT sum(salary) OVER w1, count(*) OVER w2
FROM empsalary WINDOW w1 AS (ORDER BY salary), w2 AS (ORDER BY salary)

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 2 preceding and 1 following
	exclude current row), unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 2 preceding and 1 following
	exclude group), unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 2 preceding and 1 following
	exclude ties), unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between 2::int8 preceding and 1::int2 preceding exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between 2::int8 preceding and 1::int2 preceding exclude group),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between 2::int8 preceding and 1::int2 preceding exclude ties),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between 2::int8 preceding and 6::int2 following exclude group),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between 2::int8 preceding and 6::int2 following exclude ties),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (partition by four order by unique1 range between 5::int8 preceding and 6::int2 following
	exclude current row),unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (partition by ten
	order by four groups between 0 preceding and 0 following exclude current row), unique1, four, ten
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (partition by ten
	order by four groups between 0 preceding and 0 following exclude group), unique1, four, ten
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (partition by ten
	order by four groups between 0 preceding and 0 following exclude ties), unique1, four, ten
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 2 preceding and 2 following exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 2 preceding and 2 following exclude group),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 2 preceding and 2 following exclude ties),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between current row and 9223372036854775807 following exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (w range between current row and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10 WINDOW w AS (order by four)

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (w range between unbounded preceding and current row exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10 WINDOW w AS (order by four)

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (w range between unbounded preceding and current row exclude group),
	unique1, four
FROM tenk1 WHERE unique1 < 10 WINDOW w AS (order by four)

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (w range between unbounded preceding and current row exclude ties),
	unique1, four
FROM tenk1 WHERE unique1 < 10 WINDOW w AS (order by four)

-- sqlfmt-corpus-separator --

SELECT t1.a, t2.e
  FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)
  WHERE t1.a = t2.d

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname,
       t1.typelem, t1.typlen, t1.typbyval
FROM pg_type AS t1
WHERE t1.typsubscript = 'array_subscript_handler'::regproc AND NOT
    (t1.typelem != 0 AND t1.typlen = -1 AND NOT t1.typbyval)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname,
       t1.typelem, t1.typlen, t1.typbyval
FROM pg_type AS t1
WHERE t1.typsubscript = 'raw_array_subscript_handler'::regproc AND NOT
    (t1.typelem != 0 AND t1.typlen > 0 AND NOT t1.typbyval)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typinput = p1.oid AND
    (t1.typelem != 0 AND t1.typlen < 0) AND NOT
    (p1.oid = 'array_in'::regproc)
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typoutput = p1.oid AND NOT
    (p1.prorettype = 'cstring'::regtype AND NOT p1.proretset)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typreceive = p1.oid AND
    (t1.typelem != 0 AND t1.typlen < 0) AND NOT
    (p1.oid = 'array_recv'::regproc)
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typsend = p1.oid AND NOT
    (p1.prorettype = 'bytea'::regtype AND NOT p1.proretset)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, t2.oid, t2.typname
FROM pg_type AS t1, pg_type AS t2
WHERE t1.typelem = t2.oid AND NOT
    (t1.typmodin = t2.typmodin AND t1.typmodout = t2.typmodout)

-- sqlfmt-corpus-separator --

SELECT ten, two, sum(hundred) AS gsum, sum(sum(hundred)) OVER win AS wsum
FROM tenk1 GROUP BY ten, two WINDOW win AS (PARTITION BY two ORDER BY ten)

-- sqlfmt-corpus-separator --

VALUES (1,2), (3,4+4), (7,77.7)

-- sqlfmt-corpus-separator --

VALUES (1,2), (3,4+4), (7,77.7)
UNION ALL
SELECT 2+2, 57
UNION ALL
TABLE int8_tbl

-- sqlfmt-corpus-separator --

VALUES(1, generate_series(1,2))

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
    x(id) AS (SELECT * FROM y UNION ALL SELECT id+1 FROM x WHERE id < 5),
    y(id) AS (values (1))
 SELECT * FROM x

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

WITH RECURSIVE
  y (id) AS (VALUES (1)),
  x (id) AS (SELECT * FROM y UNION ALL SELECT id+1 FROM x WHERE id < 5)
SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(i) AS
    (values (1)
    UNION ALL
	   SELECT * FROM
       (SELECT i+1 FROM foo WHERE i < 10
          UNION ALL
       SELECT i+1 FROM foo WHERE i < 5) AS t
) SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(i) AS
    (values (1)
    UNION ALL
       (SELECT i+1 FROM foo WHERE i < 10
          EXCEPT
       SELECT i+1 FROM foo WHERE i < 5)
) SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(i) AS
    (values (1)
    UNION ALL
       (SELECT i+1 FROM foo WHERE i < 10
          INTERSECT
       SELECT i+1 FROM foo WHERE i < 5)
) SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(i) AS
    (values (1)
    UNION ALL
       (SELECT i+1 FROM foo WHERE i < 10
          UNION ALL
       SELECT i+1 FROM foo WHERE i < 5)
) SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(i) AS
   (SELECT i FROM (VALUES(1),(2)) t(i)
   UNION ALL
   SELECT (i+1)::numeric(10,0) FROM foo WHERE i < 10)
SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(i) AS
   (SELECT i::numeric(3,0) FROM (VALUES(1),(2)) t(i)
   UNION ALL
   SELECT (i+1)::numeric(10,0) FROM foo WHERE i < 10)
SELECT * FROM foo

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

WITH RECURSIVE outermost(x) AS (
  SELECT 1
  UNION (WITH innermost as (SELECT 2)
         SELECT * FROM outermost
         UNION SELECT * FROM innermost)
)
SELECT * FROM outermost ORDER BY 1

-- sqlfmt-corpus-separator --

WITH RECURSIVE outermost(x) AS (
  WITH innermost as (SELECT 2 FROM outermost) -- fail
    SELECT * FROM innermost
    UNION SELECT * from outermost
)
SELECT * FROM outermost ORDER BY 1

-- sqlfmt-corpus-separator --

WITH RECURSIVE outermost(x) AS (
 SELECT 1
 UNION (WITH innermost1 AS (
  SELECT 2
  UNION (WITH innermost2 AS (
   SELECT 3
   UNION (WITH innermost3 AS (
    SELECT 4
    UNION (WITH innermost4 AS (
     SELECT 5
     UNION (WITH innermost5 AS (
      SELECT 6
      UNION (WITH innermost6 AS
       (SELECT 7)
       SELECT * FROM innermost6))
      SELECT * FROM innermost5))
     SELECT * FROM innermost4))
    SELECT * FROM innermost3))
   SELECT * FROM innermost2))
  SELECT * FROM outermost
  UNION SELECT * FROM innermost1)
 )
 SELECT * FROM outermost ORDER BY 1

-- sqlfmt-corpus-separator --

WITH RECURSIVE subdepartment AS
(
	SELECT id, parent_department, name FROM department WHERE name = 'A'

	UNION

	SELECT d.id, d.parent_department, d.name FROM department AS d
	INNER JOIN subdepartment AS sd ON d.parent_department = sd.id
)
SELECT * FROM subdepartment ORDER BY name

-- sqlfmt-corpus-separator --

WITH RECURSIVE t AS (
	INSERT INTO y
		SELECT * FROM t
)
VALUES(FALSE)

-- sqlfmt-corpus-separator --

WITH RECURSIVE t AS (
	INSERT INTO y
		SELECT a+5 FROM t2 WHERE a > 5
	RETURNING *
), t2 AS (
	UPDATE y SET a=a-11 RETURNING *
)
SELECT * FROM t
UNION ALL
SELECT * FROM t2

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(i,j) AS (
	VALUES (1,2)
	UNION ALL
	SELECT t2.i, t.j+1 FROM
		(SELECT 2 AS i UNION ALL SELECT 3 AS i) AS t2
		JOIN t ON (t2.i = t.i+1))

	SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(j) AS (
    WITH RECURSIVE s(i) AS (
        VALUES (1)
        UNION ALL
        SELECT i+1 FROM s WHERE i < 10
    )
    SELECT i FROM s
    UNION ALL
    SELECT j+1 FROM t WHERE j < 10
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    SELECT (VALUES(1))
UNION ALL
    SELECT n+1 FROM t WHERE n < 5
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    VALUES ('01'::varbit)
UNION
    SELECT n || '10'::varbit FROM t WHERE n < '100'::varbit
)
SELECT n FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    VALUES (1)
UNION ALL
    SELECT n+1 FROM t WHERE n < 100
)
SELECT sum(n) FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    VALUES (1)
UNION ALL
    SELECT n+1 FROM t)
SELECT * FROM t LIMIT 10

-- sqlfmt-corpus-separator --

WITH RECURSIVE t1 AS (
  INSERT INTO y SELECT * FROM y RETURNING *
), t2 AS (
  INSERT INTO yy SELECT * FROM t1 RETURNING *
)
SELECT 1

-- sqlfmt-corpus-separator --

WITH RECURSIVE t1 AS (
  INSERT INTO yy SELECT * FROM t2 RETURNING *
), t2 AS (
  INSERT INTO y SELECT * FROM y RETURNING *
)
SELECT 1

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(id) AS (values (1)
    UNION ALL
    SELECT (SELECT * FROM x) FROM x WHERE id < 5
) SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (
  (WITH x1 AS (SELECT 1 FROM x) SELECT * FROM x1)
  UNION
  SELECT 0)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (
  WITH sub_cte AS (SELECT * FROM x)
  DELETE FROM graph RETURNING f)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (
  WITH x1 AS (SELECT 1 AS n)
    SELECT 0
    UNION
    SELECT * FROM x1)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (
  WITH x1 AS (SELECT 1 FROM x)
    SELECT 0
    UNION
    SELECT * FROM x1)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM x FOR UPDATE)
  SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT a FROM y WHERE a = 1
	UNION ALL
	SELECT x.n+1 FROM x FULL JOIN y ON x.n = y.a WHERE n < 10)
SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT a FROM y WHERE a = 1
	UNION ALL
	SELECT x.n+1 FROM x RIGHT JOIN y ON x.n = y.a WHERE n < 10)
SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT a FROM y WHERE a = 1
	UNION ALL
	SELECT x.n+1 FROM y LEFT JOIN x ON x.n = y.a WHERE n < 10)
SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH aa AS (
    INSERT INTO withz VALUES(1, 5) ON CONFLICT (k) DO UPDATE SET v = EXCLUDED.v
    WHERE withz.k != EXCLUDED.k
    RETURNING *
)
SELECT * FROM aa

-- sqlfmt-corpus-separator --

WITH cte (x) AS (
        SELECT * FROM generate_series(1, 35, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x groups between 1 preceding and 1 following)

-- sqlfmt-corpus-separator --

WITH cte (x) AS (
        SELECT * FROM generate_series(1, 35, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x range between 1 preceding and 1 following)

-- sqlfmt-corpus-separator --

WITH cte (x) AS (
        SELECT * FROM generate_series(1, 35, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x rows between 1 preceding and 1 following)

-- sqlfmt-corpus-separator --

WITH cte (x) AS (
        select 1 union all select 1 union all select 1 union all
        SELECT * FROM generate_series(5, 49, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x groups between 1 preceding and 1 following)

-- sqlfmt-corpus-separator --

WITH cte (x) AS (
        select 1 union all select 1 union all select 1 union all
        SELECT * FROM generate_series(5, 49, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x range between 1 preceding and 1 following)

-- sqlfmt-corpus-separator --

WITH cte (x) AS (
        select 1 union all select 1 union all select 1 union all
        SELECT * FROM generate_series(5, 49, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x rows between 1 preceding and 1 following)

-- sqlfmt-corpus-separator --

WITH cte1 AS (INSERT INTO t1 VALUES (20, 'Success') RETURNING *) SELECT * FROM cte1

-- sqlfmt-corpus-separator --

WITH cte1 AS (INSERT INTO t1 VALUES (21, 'Fail') RETURNING *) SELECT * FROM cte1

-- sqlfmt-corpus-separator --

WITH cte1 AS (UPDATE t1 SET a = a + 1 RETURNING *) SELECT * FROM cte1

-- sqlfmt-corpus-separator --

WITH cte1 AS (UPDATE t1 SET a = a RETURNING *) SELECT * FROM cte1

-- sqlfmt-corpus-separator --

WITH cte1 AS MATERIALIZED (SELECT * FROM t1 WHERE f_leak(b)) SELECT * FROM cte1

-- sqlfmt-corpus-separator --

WITH foo AS (
  MERGE INTO target USING source ON (true)
  WHEN MATCHED THEN DELETE
) SELECT * FROM foo

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

WITH rows AS
  (SELECT i, to_char(i, 'RN') AS roman FROM generate_series(1, 3999) AS i)
SELECT
  bool_and(to_number(roman, 'RN') = i) as valid
FROM rows

-- sqlfmt-corpus-separator --

WITH t AS (
	DELETE FROM y RETURNING *
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
	INSERT INTO y VALUES(0)
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
	INSERT INTO y VALUES(0)
)
VALUES(FALSE)

-- sqlfmt-corpus-separator --

WITH t AS (
    DELETE FROM y
    WHERE a <= 10
    RETURNING *
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
    INSERT INTO y
    VALUES
        (11),
        (12),
        (13),
        (14),
        (15),
        (16),
        (17),
        (18),
        (19),
        (20)
    RETURNING *
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
    INSERT INTO y
    VALUES
        (21),
        (22),
        (23)
    RETURNING *
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
    INSERT INTO y
    VALUES
        (31),
        (32),
        (33)
    RETURNING *
)
SELECT * FROM t LIMIT 1

-- sqlfmt-corpus-separator --

WITH t AS (
    INSERT INTO y
    VALUES
        (41),
        (42),
        (43)
    RETURNING *
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
    UPDATE y
    SET a=a+1
    RETURNING *
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
    UPDATE y SET a = a * 100 RETURNING *
)
SELECT * FROM t LIMIT 10

-- sqlfmt-corpus-separator --

WITH t(b, p, bc_result) AS (VALUES
(0.12, -2829.8369, 58463948950011752465280493160293790845494328939320966633018493248607815580903065923369555885857984675501574162389726507612128133630191173383130639968378879506624785786843501848666498440326970769604109017960864573408272864266102690849952650095786874354625921641729880352858506454246180842452983243549491658464046163869265572232996388827878976066830374513768599285647145439771472435206769249126377164951470622827631950210853282324510655982757098065657709137845327135766013147354253426364240746381620690117663724329288646510198895137275207992825719846135857839292915100523542874885080351683587865157015032404901182924720371819942957083390475846809517968191151435281268695782594904484795360890092607679215675240583291240729468370895035823777914792823688291214492607109455017754453939895630226174304357121900605689015734289765672740769194115142607443713769825894380064727556869268488695795705030158832909348803019429370973064732712469794182891757241046263341655894972953512257981661670321890336672832647028099324621932563236459127918144141230217523147304565594514812518826936144181257723061181656522095236928347413997136815409159361412494284201481609684892562646522086577634100783077813105675590737823924220663206479031113753135119759722725207724879578900186075841393115040465401462266086907464970054073340036852442184414587772177753008511913377364966775792477387717262694468450099866775550614257191941835797445874557362115814601886902749237439492398087966544817154173072811937702110580330775581851211123491341435883319798273456296794954514173820352334127081705706502510709179711510240917772628308487366740741280043704807717608366220401933596364641284631036907635403895053036499618723044314773148779735006542501244942039455169872946018271985844759209768927953340447524637670938413827595013338859796135512187473850161303598087634723542727044978083220970836296653305188470017342167913572166172051819741354902582606590658382067039498769674611071582171914886494269818475850690414812481252963932223686078322390396586222238852602472958831686564971334200490182175112490433364675164900946902818404704835106260174052265784055642968397240262737313737007322288203637798365320295080314524864099419556398713380156353062937736280885716820226469419928595465390700629307079710611273715705695938635644841913194091407807776191951797748706106000922803167645881087385311847268311361092838264814899353459146959869764278464187826798546290981492648723002412475976344071283321798061003719251864595518596639432393032991023409676558943539937377229130132816883146259468718344018277257037013406135980469482324577407154032999045733141275895.3432),
(1.2, 32908.8896, 58463467728170833376633133695001863276259293590926929026251227859007891876739460057725441400966420577009060860805883032969522911803372870882799865787473726926215148161529632590083389287080925059682489116446754279752928005457087175157581627230586554364417068189211136840990661174760199073702207450133797324318403866058202372178813998850887986769280847189341565507156189065295823921162851958925352114220880236114784962150135485415106748467247897246441194126125699204912883449386043559785865023459356275014504597646990160571664166410683323036984805434677654413174177920726210827006973855410386789516533036723888687725436216478665958434776205940192130053647653715221076841771578099896259902368829351569726536927952661429685419815305418450230567773264738536471211804481206474781470237730069753206249915908804615495060673071058534441654604668770343616386612119048579369195201590008082689834456232255266932976831478404670192731621439902738547169253818323045451045749609624500171633897705543164388470746657118050314064066768449450440405619135824055131398727045420324382226572368236570500391463795989258779677208133531636928003546809249007993065200108076924439703799231711400266122025052209803513232429907231051873161206025860851056337427740362763618748092029386371493898291580557004812947013231371383576580415676519066503391905962989205397824064923920045371823949776899815750413244195402085917098964452866825666226141169411712884994564949174271056284898570445214367063763956186792886147126466387576513166370247576466566827375268334148320298849218878848928271566491769458471357076035396330179659440244425914213309776100351793665960978678576150833311810944729586040624059867137538839913141142139636023129691775489034134511666020819676247950267220131499463010350308195762769192775344260909521732256844149916046793599150786757764962585268686580124987490115873389726527572428003433405659445349155536369077209682951123806333170190998931670309088422483075609203671527331975811507450670132060984691061148836994322505371265263690017938762760088575875666254883673433331627055180154954694693433502522592907190906966067656027637884202418119121728966267936832338377284832958974299187166554160783467156478554899314000348357280306042140481751668215838656488457943830180819301102535170705017482946779698265096226184239631924271857062033454725540956591929965181603262502135610768915716020374362368495244256420143645126927013882334008435586481691725030031204304273292938132599127402133470745819213047706793887965197191137237066440328777206799072470374264316425913530947082957300047105685634407092811630672103242089966046839626911122.7149))
SELECT b, p, bc_result, b^p AS power, b^p - bc_result AS diff FROM t

-- sqlfmt-corpus-separator --

WITH t(x) AS (SELECT '1e'||n FROM generate_series(1, 100) g(n))
SELECT x, log(x::numeric) FROM t

-- sqlfmt-corpus-separator --

WITH t(x) AS (SELECT '1e-'||n FROM generate_series(1, 100) g(n))
SELECT x, log(x::numeric) FROM t

-- sqlfmt-corpus-separator --

WITH t(x, bc_result) AS (VALUES
(484990182159328900690402236933516249572671683638747490717351807610531884491845416923860371219625151551889257298200816555016472471293780254009492949585031653913930735918829139712249577547959394351523545901788627247613322896296041868431769047433229466634098452564756860190085118463828382895145244362033728480588969626012192733802377468089120757046364393407262957242230928854711898925295251902007136232994524624903257456111389508582206404271734668422903183500589303866613158037169610592539145461637447957948521714058034772237111009429638870236361143304703683377693378577075353794118557951847394763531830696578809001981568860219578880229402696449243344235099860421846016326538272155937175661905904288335499593232232926636205909086901191153907183842087577811871344870731324067822883041265129394268082883745408414994.8967939438561591657171240282983703914075472645212002662497023142663831371447287624846942598424990784971781730103682951722370983277124599054059027055336437808366784501932987082321905202623642371063626378290734289114618092750984153422293450048717769065428713836637664433167768445609659527458911187829232316677137895259433038764404970599325009178297626038331436654541552998098529141205301472138026818453893127265938030066392881979113522757891639646670670272542401773230506961559808927249585675430838495658225557294666522469887436551840596777627408780618586500922973500018513068499587683746133637919751545157547095670767246977244726331271787622126889459658539988980096764323712767863722912919120929339399753431689512753214200090670880647731689804555417871258907716687575767185444541243606329768784843125926070743277339790277626515824924290352180761378846035233155198504033292692893297993698953705472933411199778880561376633444249703838589180474329586470353212010427945060694794274109764269805332803290229,
 1864.3702986939570026328504202935192533137907736189919154633800554877738455118081651650863235106905871352085850240570561347180517240105510505203972860921397909573687877993477806728098306202020229409548306695695574102950949468160529713610952021974630774784174851619325758380143625473386495586347322798415543385655090746985183329114860118551572428921774322172798724455202876781611633419444058398798142214904998877857425038669920064728855823072107227506485770367799671977282350083029452784747350395161797215115525867416898416360638482342253129160308632504217096916335590470843180746834864303790913372081974355613359678634194879425862536147988835528973291020680020540866655622823550861337486588647231688134992810403147262346312159819432914207194632564009749236609081399504118359354620598232725290537215007867979331582119891661859015726276335168158288396939655310210558566592649049602925182137256134162660116182293851038854455437841571331011002023088829768308520393956515509475418031437505751407687618234418262),
(87190145885430429849953615409019208993240447426362428988181639909267773304254748257120061524000254226856815085523676417146197197996896030672521334101413071112068202429835905642444187493717977611730127126387257253646790849384975208460867137315507010888782632024640844766297185244443116696943912406389670302370461137850160539373600494054874979342373255280815156048999900951842673141766630630919020492255966628630634124452614590400422133958133100159154995520080124736657520969784129924799670552560034302960877087853678350801769339861812435411200669026902417951572668727488315537985378304242438181615160041688723201917323705450185975141141262578884689500612295576288125956289035673242989906973367691922065122033180281670221390667818909912035903387888639331486823729897326624516015340.0330856710565117793999512551468220085711713631167607285185762046751452975325645379302403715842570486302993296501788672462090620871511446272026693318239212657949496275318383141403236705902077406660768573015707706831878445598837931116223956945944726162551477136715847593742032488181481888084716920605114101902724395659898621880016853548602514706686907951229872573180602614761229992106144727082722940736406782659562775289407005631298246624198606031298081220736931229256511054595028182057216042683060059115371651410352645266000330509331097811566633211452233019461903115970558624057877018778178814946285827512359903934291318219271464841957435711594154280905473802599888081783098187210283997106131616471807951265003903143099667366508222327805543948921694362089860577380749774036318574113007382111997454202845559941557812813566442364810680529092880773126707073967537693927177460459341763934709686530005721141046645111784404932103241501569571235364365556796422998363930810983452790309019295181282099408260156,
 1793.5767085750017553306932533574391150814202249805881581227430032600579405884415934520704053351781361105595296647510475380766428668443641914861849764330704062323054023252886955844207807229267936432730818329225450152491146839618683772020068682795388746108876393249306737841247788224204701299467519965182171772253974884845661168860422489046657965359832930382114760565628765599962013955588754803194908990025689040598990346417563277021386852342928910383706995866844541160576254266641602065102228267316550706943783591722246885978355472097314691737807509436806788803362444745551013400341861820755594413819894154786253014501454443272120342005711761286524843010157182464200556865694401941794983935172457481497909987740544409272349152397774548604845897687504977786762391359552407068124283290504752932824699865504970420939586707791994870941813718246825616335675307740641350673558328821461530563823677144691877374809441673507467507447891562257806191361453045937798278733402269265623588493124129181374135958668436774),
(93936642222690597390233191619858485419795942047468396309991947772747208870873993801669373075421461116465960407843923269693395211616591453397070258466704654943689268224479477016161636938138334729982904232438440955361656138189836032891825113139184685132178764873033678116450665758561650355252211196676137179184043639278410827092182700922151290703747496962700158844772453483316974221113826173404445159281421213715669245417896170368554410830320000019029956317336703559699859949692222685614036912057150632902650913831404804982509990655560731349634628713944739168096272097122388116038119844786988276635032016787352796502360718569977397214936366251320294621522016.6483354941025384161536675750898007896744690911429670830432784905421638721478353275821072200938900938046264210604940707974410950770029535636602548377806284157951164875821446035013896786653932045182167021839184824627082391478016195098055107001433336586881395912782883663046617432598969149948351689103230162742769845955320418573803127107923535948653168889411316007796459064267436246637115946581149511513369842911210359447262641996566147462977170742544980481275049898092152042927981394239266559286915303786701737610786594006685748456635797125029722684151298695274097006242412384086302106763844070230264910503179385988626477852818174114043927841085089058972074427820150462261941575665882880501074676800316585217150509780489224388148722603385921057007086785238310735038314861960410473809826927329368597558806004392175746233568789445929554890241140656324160187253042639339549705859147930476532359840809944163908006480881926041259363654863689570520534301207043189181147254153307163555433328278834311658232337,
 1510.4332713542154696529645934345554302578243896764921637693542962119938599884313210100957753316832762996428481801312323020427109678979117469716796746760060470871840325255146954580681101106876674367471955788143763250819168311353856748872452260808797135108102729064040463343792765872545182299889360257515315869180266759715933989413256377582681707188367254513700731642913479683031478361835565783219287780434673712341147656477670848734998849030451414278832848680301511646182446524915091598080243532068451726548537866633622180283865668708517173065893429240665300584705585310049892047293928733753369421499719516009692095913169665213597158441636480707309244604139865130782756488091268094213446272360006907802989573582755585110277620911226015342778471352130366770729972784317323917141031824334355639769512749560550167491709646539950725523461943580211843652293561678342656010571108219244870234329176123205423872844099992204896411752620881541000940129833754169391528449211839693800724450201835161044717173715867437))
SELECT trim_scale(ln(x::numeric)-bc_result) AS diff FROM t

-- sqlfmt-corpus-separator --

WITH tzs (tz) AS (VALUES
    ('+1'), ('+1:'), ('+1:0'), ('+100'), ('+1:00'), ('+01:00'),
    ('+10'), ('+1000'), ('+10:'), ('+10:0'), ('+10:00'), ('+10:00:'),
    ('+10:00:1'), ('+10:00:01'),
    ('+10:00:10'))
     SELECT make_timestamptz(2010, 2, 27, 3, 45, 00, tz), tz FROM tzs

-- sqlfmt-corpus-separator --

WITH uuidts AS (
    SELECT y, ts as ts, lag(ts) OVER (ORDER BY y) AS prev_ts
    FROM (SELECT y, uuid_extract_timestamp(uuidv7((y || ' years')::interval)) AS ts
        FROM generate_series(1970 - extract(year from now())::int, 10888 - extract(year from now())::int) y)
)
SELECT y, ts, prev_ts FROM uuidts WHERE ts < prev_ts

-- sqlfmt-corpus-separator --

WITH v(exp) AS
  (VALUES(-16379),(-16378),(-1234),(-789),(-45),(-5),(-4),(-3),(-2),(-1),(0),
         (1),(2),(3),(4),(5),(38),(275),(2345),(45678),(131070),(131071))
SELECT exp,
  to_char(('1.2345e'||exp)::numeric, '9.999EEEE') as numeric
FROM v

-- sqlfmt-corpus-separator --

WITH v(val) AS
  (VALUES('0'::numeric),('-4.2'),('4.2e9'),('1.2e-5'),('inf'),('-inf'),('nan'))
SELECT val,
  to_char(val, '9.999EEEE') as numeric,
  to_char(val::float8, '9.999EEEE') as float8,
  to_char(val::float4, '9.999EEEE') as float4
FROM v

-- sqlfmt-corpus-separator --

WITH v(val) AS
  (VALUES('0'::numeric),('-4.2'),('4.2e9'),('1.2e-5'),('inf'),('-inf'),('nan'))
SELECT val,
  to_char(val, 'MI99.99') as numeric,
  to_char(val::float8, 'MI99.99') as float8,
  to_char(val::float4, 'MI99.99') as float4
FROM v

-- sqlfmt-corpus-separator --

WITH v(val) AS
  (VALUES('0'::numeric),('-4.2'),('4.2e9'),('1.2e-5'),('inf'),('-inf'),('nan'))
SELECT val,
  to_char(val, 'MI9999999999.99') as numeric,
  to_char(val::float8, 'MI9999999999.99') as float8,
  to_char(val::float4, 'MI9999999999.99') as float4
FROM v

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('-7.777'),('1e340'),('-1e340'),
         ('inf'),('-inf'),('nan'),
         ('inf'),('-inf'),('nan'))
SELECT substring(x::text, 1, 32)
FROM v ORDER BY x

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('-7.777'),('inf'),('-inf'),('nan'))
SELECT x, -x as minusx, abs(x), floor(x), ceil(x), sign(x), numeric_inc(x) as inc
FROM v

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('-7.777'),('inf'),('-inf'),('nan'))
SELECT x, round(x), round(x,1) as round1, trunc(x), trunc(x,1) as trunc1
FROM v

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('inf'),('-inf'),('nan'))
SELECT x1, x2,
  x1 + x2 AS sum,
  x1 - x2 AS diff,
  x1 * x2 AS prod
FROM v AS v1(x1), v AS v2(x2)

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('inf'),('-inf'),('nan'))
SELECT x1, x2,
  x1 / x2 AS quot,
  x1 % x2 AS mod,
  div(x1, x2) AS div
FROM v AS v1(x1), v AS v2(x2) WHERE x2 != 0

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('2'),('4.2'),('inf'),('nan'))
SELECT x1, x2,
  power(x1, x2)
FROM v AS v1(x1), v AS v2(x2) WHERE x1 != 0 OR x2 >= 0

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('4.2'),('inf'),('nan'))
SELECT x, sqrt(x)
FROM v

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('1'::numeric),('4.2'),('inf'),('nan'))
SELECT x,
  log(x),
  log10(x),
  ln(x)
FROM v

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('2'::numeric),('4.2'),('inf'),('nan'))
SELECT x1, x2,
  log(x1, x2)
FROM v AS v1(x1), v AS v2(x2)

-- sqlfmt-corpus-separator --

select ( with cte(foo) as ( values(f1) )
          values((select foo from cte)) )
from int4_tbl

-- sqlfmt-corpus-separator --

select ( with cte(foo) as ( values(f1) )
         select (select foo from cte) )
from int4_tbl

-- sqlfmt-corpus-separator --

select (1 = any(array_agg(f1))) = any (select false) from int4_tbl

-- sqlfmt-corpus-separator --

select * from int4_tbl o where (f1, f1) in
  (select f1, generate_series(1,50) / 10 g from int4_tbl i group by f1)

-- sqlfmt-corpus-separator --

select * from int4_tbl where
  (case when f1 in (select unique1 from tenk1 a) then f1 else null end) in
  (select ten from tenk1 b)

-- sqlfmt-corpus-separator --

select * from int8_tbl i where i.* in (values(i.*::int8_tbl))

-- sqlfmt-corpus-separator --

select * from onek
    where (unique1,ten) in (values (1,1), (20,0), (99,9), (17,99))
    order by unique1

-- sqlfmt-corpus-separator --

select * from outer_7597 where (f1, f2) not in (select * from inner_7597)

-- sqlfmt-corpus-separator --

select * from outer_text where (f1, f2) not in (select * from inner_text)

-- sqlfmt-corpus-separator --

select * from rtest_vcomp where size_in_cm > 10.0 order by size_in_cm using >

-- sqlfmt-corpus-separator --

select avg((select avg(a1.col1 order by (select avg(a2.col2) from tenk1 a3))
            from tenk1 a1(col1)))
from tenk1 a2(col2)

-- sqlfmt-corpus-separator --

select concat(variadic '{}'::int[]) = ''

-- sqlfmt-corpus-separator --

select concat_ws(',', variadic 10)

-- sqlfmt-corpus-separator --

select concat_ws(',', variadic NULL::int[])

-- sqlfmt-corpus-separator --

select count(*) > 0 as ok, count(*) FILTER (WHERE error IS NOT NULL) = 0 AS no_err
  from pg_hba_file_rules

-- sqlfmt-corpus-separator --

select count(*) >= 0 as ok, count(*) FILTER (WHERE error IS NOT NULL) = 0 AS no_err
  from pg_ident_file_mappings

-- sqlfmt-corpus-separator --

select count(*) from tenk1 where (two, four) not in
	(select hundred, thousand from tenk2 where thousand > 100)

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by enroll_date groups between 1 following and 3 following
	exclude current row),
	lead(salary) over(order by enroll_date groups between 1 following and 3 following exclude ties),
	nth_value(salary, 1) over(order by enroll_date groups between 1 following and 3 following
	exclude ties),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude current row),
	last_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude current row),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude group),
	last_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude group),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude ties),
	last_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude ties),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude ties),
	last_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by salary range between 1000 following and 3000 following
	exclude current row),
	lead(salary) over(order by salary range between 1000 following and 3000 following exclude ties),
	nth_value(salary, 1) over(order by salary range between 1000 following and 3000 following
	exclude ties),
	salary from empsalary

-- sqlfmt-corpus-separator --

select format('Hello', variadic NULL::int[])

-- sqlfmt-corpus-separator --

select from generate_series(1,5) except all select from generate_series(1,3)

-- sqlfmt-corpus-separator --

select from generate_series(1,5) except select from generate_series(1,3)

-- sqlfmt-corpus-separator --

select from generate_series(1,5) intersect all select from generate_series(1,3)

-- sqlfmt-corpus-separator --

select from generate_series(1,5) intersect select from generate_series(1,3)

-- sqlfmt-corpus-separator --

select from generate_series(1,5) union all select from generate_series(1,3)

-- sqlfmt-corpus-separator --

select from generate_series(1,5) union select from generate_series(1,3)

-- sqlfmt-corpus-separator --

select id, f_float4, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float4 range between
             'inf' following and 'inf' following)

-- sqlfmt-corpus-separator --

select id, f_float4, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float4 range between
             'inf' preceding and 'inf' following)

-- sqlfmt-corpus-separator --

select id, f_float4, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float4 range between
             'inf' preceding and 'inf' preceding)

-- sqlfmt-corpus-separator --

select id, f_float4, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float4 range between
             1 preceding and 1 following)

-- sqlfmt-corpus-separator --

select id, f_float4, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float4 range between
             1 preceding and 1.1::float4 following)

-- sqlfmt-corpus-separator --

select id, f_float4, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float4 range between
             1.1 preceding and 'NaN' following)

-- sqlfmt-corpus-separator --

select id, f_float8, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float8 range between
             'inf' following and 'inf' following)

-- sqlfmt-corpus-separator --

select id, f_float8, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float8 range between
             'inf' preceding and 'inf' following)

-- sqlfmt-corpus-separator --

select id, f_float8, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float8 range between
             'inf' preceding and 'inf' preceding)

-- sqlfmt-corpus-separator --

select id, f_float8, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float8 range between
             1 preceding and 1 following)

-- sqlfmt-corpus-separator --

select id, f_float8, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float8 range between
             1 preceding and 1.1::float8 following)

-- sqlfmt-corpus-separator --

select id, f_float8, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float8 range between
             1.1 preceding and 'NaN' following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval desc range between
             '-1 year' preceding and '1 year' following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval desc range between
             '1 year' preceding and '1 year' following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval range between
             '-infinity'::interval following and
             'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval range between
             '1 year'::interval preceding and '1 year'::interval following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval range between
             'infinity'::interval following and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval range between
             'infinity'::interval preceding and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval range between
             'infinity'::interval preceding and 'infinity'::interval preceding)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             'inf' following and 'inf' following)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             'inf' preceding and 'inf' following)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             'inf' preceding and 'inf' preceding)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             1 preceding and 1 following)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             1 preceding and 1.1::float8 following)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             1 preceding and 1.1::numeric following)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             1.1 preceding and 'NaN' following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time desc range between
             '-70 min' preceding and '2 hours' following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time desc range between
             '70 min' preceding and '2 hours' following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time range between
             '-infinity'::interval following and
             'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time range between
             '70 min'::interval preceding and '2 hours'::interval following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time range between
             'infinity'::interval following and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time range between
             'infinity'::interval preceding and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time range between
             'infinity'::interval preceding and 'infinity'::interval preceding)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp desc range between
             '-1 year' preceding and '1 year' following)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp desc range between
             '1 year' preceding and '1 year' following)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp range between
             '-infinity'::interval following and
             'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp range between
             '1 year'::interval preceding and '1 year'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp range between
             'infinity'::interval following and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp range between
             'infinity'::interval preceding and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp range between
             'infinity'::interval preceding and 'infinity'::interval preceding)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz desc range between
             '1 year' preceding and '-1 year' following)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz desc range between
             '1 year' preceding and '1 year' following)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz range between
             '-infinity'::interval following and
             'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz range between
             '1 year'::interval preceding and '1 year'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz range between
             'infinity'::interval following and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz range between
             'infinity'::interval preceding and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz range between
             'infinity'::interval preceding and 'infinity'::interval preceding)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz desc range between
             '70 min' preceding and '-2 hours' following)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz desc range between
             '70 min' preceding and '2 hours' following)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz range between
             '70 min'::interval preceding and '2 hours'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz range between
             'infinity'::interval following and
             '-infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz range between
             'infinity'::interval following and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz range between
             'infinity'::interval preceding and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz range between
             'infinity'::interval preceding and 'infinity'::interval preceding)

-- sqlfmt-corpus-separator --

select last_value(salary) over(order by enroll_date groups between 1 following and 3 following
	exclude group),
	lag(salary) over(order by enroll_date groups between 1 following and 3 following exclude group),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select last_value(salary) over(order by salary range between 1000 following and 3000 following
	exclude group),
	lag(salary) over(order by salary range between 1000 following and 3000 following exclude group),
	salary from empsalary

-- sqlfmt-corpus-separator --

select max(enroll_date) over (order by enroll_date range between '1 year'::interval preceding and '-2 years'::interval following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select max(enroll_date) over (order by enroll_date range between 1 preceding and 2 following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select max(enroll_date) over (order by salary range between '1 year'::interval preceding and '2 years'::interval following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select max(enroll_date) over (order by salary range between -1 preceding and 2 following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select max(enroll_date) over (order by salary range between 1 preceding and -2 following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select row_to_json(i) from int8_tbl i(x,y)

-- sqlfmt-corpus-separator --

select sum(salary) over (order by depname range between '1 year'::interval preceding and '2 years'::interval following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(salary) over (order by enroll_date range between '1 year'::interval preceding and '1 year'::interval following
	exclude current row), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(salary) over (order by enroll_date range between '1 year'::interval preceding and '1 year'::interval following
	exclude group), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(salary) over (order by enroll_date range between '1 year'::interval preceding and '1 year'::interval following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(salary) over (order by enroll_date, salary range between '1 year'::interval preceding and '2 years'::interval following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(salary) over (range between '1 year'::interval preceding and '2 years'::interval following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select unique1, unique2 from tenk1
where (unique1, unique2) < any (select ten, ten from tenk1 where hundred < 3)
      and unique1 <= 20
order by 1

-- sqlfmt-corpus-separator --

select x from (values (array['10'::varbit]), (array['11'::varbit])) _(x) union select x from (values (array['10'::varbit]), (array['01'::varbit])) _(x)

-- sqlfmt-corpus-separator --

select x from (values (array[1, 2]), (array[1, 3])) _(x) except select x from (values (array[1, 2]), (array[1, 4])) _(x)

-- sqlfmt-corpus-separator --

select x from (values (array[1, 2]), (array[1, 3])) _(x) intersect select x from (values (array[1, 2]), (array[1, 4])) _(x)

-- sqlfmt-corpus-separator --

select x from (values (array[1, 2]), (array[1, 3])) _(x) union select x from (values (array[1, 2]), (array[1, 4])) _(x)

-- sqlfmt-corpus-separator --

select x from (values (row('10'::varbit)), (row('11'::varbit))) _(x) union select x from (values (row('10'::varbit)), (row('01'::varbit))) _(x)

-- sqlfmt-corpus-separator --

select x from (values (row('10'::varbit)::ct1), (row('11'::varbit)::ct1)) _(x) union select x from (values (row('10'::varbit)::ct1), (row('01'::varbit)::ct1)) _(x)

-- sqlfmt-corpus-separator --

select x from (values (row(1, 2)), (row(1, 3))) _(x) except select x from (values (row(1, 2)), (row(1, 4))) _(x)

-- sqlfmt-corpus-separator --

select x from (values (row(1, 2)), (row(1, 3))) _(x) intersect select x from (values (row(1, 2)), (row(1, 4))) _(x)

-- sqlfmt-corpus-separator --

select x from (values (row(1, 2)), (row(1, 3))) _(x) union select x from (values (row(1, 2)), (row(1, 4))) _(x)

-- sqlfmt-corpus-separator --

with a as ( select id from (values (1), (2)) as v(id) ),
     b as ( select max((select sum(id) from a)) as agg )
select agg from b

-- sqlfmt-corpus-separator --

with cte as materialized (select s from generate_series(1,5) s)
select from cte union select from cte

-- sqlfmt-corpus-separator --

with cte as not materialized (select s from generate_series(1,5) s)
select from cte union select from cte

-- sqlfmt-corpus-separator --

with cte(foo) as ( values(42) ) values((select foo from cte))

-- sqlfmt-corpus-separator --

with ins (a, b, c) as
  (insert into mlparted (b, a) select s.a, 1 from generate_series(2, 39) s(a) returning tableoid::regclass, *)
  select a, b, min(c), max(c) from ins group by a, b order by 1

-- sqlfmt-corpus-separator --

with recursive
graph(f, t, label) as (
  values (1, 2, 'arc 1 -> 2'),
         (1, 3, 'arc 1 -> 3'),
         (2, 3, 'arc 2 -> 3'),
         (1, 4, 'arc 1 -> 4'),
         (4, 5, 'arc 4 -> 5'),
         (5, 1, 'arc 5 -> 1')
),
search_graph(f, t, label) as (
        select * from graph g
        union all
        select g.*
        from graph g, search_graph sg
        where g.f = sg.t
) cycle f, t set is_cycle to true default false using path
select f, t, label from search_graph

-- sqlfmt-corpus-separator --

with recursive a as (
	select 1 as b
	union all
	select * from a
) cycle b set c using p
select * from a

-- sqlfmt-corpus-separator --

with recursive q as (
      select * from department
    union all
      (with recursive x as (
           select * from department
         union all
           (select * from q union all select * from x)
        )
       select * from x)
    )
select * from q limit 32

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set foo to true default false using foo
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set is_cycle to point '(1,1)' default point '(0,0)' using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set is_cycle to true default 55 using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set is_cycle to true default false using label
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set is_cycle using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set label to true default false using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t, f set is_cycle to true default false using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle foo, tar set is_cycle using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) search breadth first by f, t set seq
  cycle f, t set is_cycle using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set foo
  cycle f, t set foo to true default false using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set foo
  cycle f, t set is_cycle to true default false using foo
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set seq
  cycle f, t set is_cycle using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union distinct
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set is_cycle to 'Y' default 'N' using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	(select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t)
) search depth first by f, t set seq
select * from search_graph order by seq

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set seq
select * from search_graph order by seq

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search breadth first by f, t set seq
select * from search_graph order by seq

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set label
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set seq
select * from search_graph order by seq

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search depth first by f, t, f set seq
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search depth first by foo, tar set seq
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union distinct
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search breadth first by f, t set seq
select * from search_graph order by seq

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union distinct
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set seq
select * from search_graph order by seq

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label, is_cycle, path) as (
	select *, false, array[row(g.f, g.t)] from graph g
	union all
	select g.*, row(g.f, g.t) = any(path), path || row(g.f, g.t)
	from graph g, search_graph sg
	where g.f = sg.t and not is_cycle
)
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label, is_cycle, path) as (
	select *, false, array[row(g.f, g.t)] from graph g
	union all
	select g.*, row(g.f, g.t) = any(path), path || row(g.f, g.t)
	from graph g, search_graph sg
	where g.f = sg.t and not is_cycle
)
select * from search_graph order by path

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label, is_cycle, path) as (
	select *, false, array[row(g.f, g.t)] from graph g
	union distinct
	select g.*, row(g.f, g.t) = any(path), path || row(g.f, g.t)
	from graph g, search_graph sg
	where g.f = sg.t and not is_cycle
)
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive test as (
  select 0 as x
  union all
  select (x + 1) % 10
  from test
    where not is_cycle  -- redundant, but legal
) cycle x set is_cycle using path
select * from test

-- sqlfmt-corpus-separator --

with recursive test as (
  select 0 as x
  union all
  select (x + 1) % 10
  from test
) cycle x set is_cycle using path
select * from test

-- sqlfmt-corpus-separator --

with recursive test as (
  select 1 as x
  union all
  select x + 1
  from test
) search breadth first by x set y
select * from test limit 5

-- sqlfmt-corpus-separator --

with recursive test as (
  select 1 as x
  union all
  select x + 1
  from test
) search depth first by x set y
select * from test limit 5

-- sqlfmt-corpus-separator --

with recursive x(a) as
  ((values ('a'), ('b'))
   union all
   (with z as not materialized (select * from x)
    select z.a || z.a as a from z
    where length(z.a || z.a) < 5))
select * from x

-- sqlfmt-corpus-separator --

with recursive x(a) as
  ((values ('a'), ('b'))
   union all
   (with z as not materialized (select * from x)
    select z.a || z1.a as a from z cross join z as z1
    where length(z.a || z1.a) < 5))
select * from x

-- sqlfmt-corpus-separator --

with recursive x(col) as (
	select 1
	union
	(with x as (select * from x)
	 select * from x)
) search depth first by col set seq
select * from x