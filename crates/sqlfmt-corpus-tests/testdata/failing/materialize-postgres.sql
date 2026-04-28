SELECT 'x' AS "xxx", ii, tt, kk FROM (J1_TBL CROSS JOIN J2_TBL) AS tx (ii, jj, tt, ii2, kk)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", tx.ii, tx.jj, tx.kk FROM (J1_TBL t1 (a, b, c) CROSS JOIN J2_TBL t2 (d, e)) AS tx (ii, jj, tt, ii2, kk)

-- sqlfmt-corpus-separator --

SELECT * FROM (SELECT 1 a) t1 CROSS JOIN ((SELECT 1 a) t1 CROSS JOIN LATERAL (SELECT a) t2) t3;

-- sqlfmt-corpus-separator --

SELECT * FROM (SELECT 1 a) t1 CROSS JOIN ((SELECT 1 a) t1 CROSS JOIN LATERAL (SELECT t1) t2) t3;

-- sqlfmt-corpus-separator --

SELECT * FROM (SELECT 1 a) t1 CROSS JOIN ((SELECT 1 a) t1 CROSS JOIN LATERAL (SELECT t1.a) t2) t3;

-- sqlfmt-corpus-separator --

SELECT * FROM (SELECT 1 f1) s1 CROSS JOIN ((SELECT 2 f1) s2 CROSS JOIN LATERAL (SELECT f1) s3)

-- sqlfmt-corpus-separator --

SELECT * FROM LATERAL ROWS FROM (generate_series(1,1)) AS g

-- sqlfmt-corpus-separator --

SELECT * FROM LATERAL ROWS FROM (generate_series(1,1));

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1, 1)) WITH ORDINALITY AS t(g1, o);

-- sqlfmt-corpus-separator --

SELECT * FROM a CROSS JOIN (b FULL JOIN LATERAL(SELECT a.a FROM c) x ON TRUE);

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE (NULL::text NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id)) IS NOT NULL;

-- sqlfmt-corpus-separator --

SELECT _pg_expandarray.* FROM ROWS FROM (information_schema._pg_expandarray(array[9]))

-- sqlfmt-corpus-separator --

SELECT _pg_expandarray::text FROM ROWS FROM (information_schema._pg_expandarray(array[9]))

-- sqlfmt-corpus-separator --

SELECT c_id, (NULL::text NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id)) IS NOT NULL
FROM c
ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT g FROM ROWS FROM (generate_series(1, 1)) AS g(a)

-- sqlfmt-corpus-separator --

SELECT g.g FROM LATERAL ROWS FROM (generate_series(1,1)) AS g

-- sqlfmt-corpus-separator --

SELECT g.g FROM LATERAL ROWS FROM (generate_series(1,1)) AS g(g)

-- sqlfmt-corpus-separator --

SELECT generate_series FROM ROWS FROM (generate_series(1, 1))

-- sqlfmt-corpus-separator --

SELECT t.a FROM (t1 NATURAL JOIN t2) t

-- sqlfmt-corpus-separator --

select * from ((select f1/2 as x from int4_tbl) ss1 join int4_tbl i4 on x = f1) j,
  lateral (select x) ss2(y);