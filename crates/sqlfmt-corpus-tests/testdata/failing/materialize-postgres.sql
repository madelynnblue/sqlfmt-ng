SELECT 'x' AS "xxx", ii, tt, kk FROM (J1_TBL CROSS JOIN J2_TBL) AS tx (ii, jj, tt, ii2, kk)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", tx.ii, tx.jj, tx.kk FROM (J1_TBL t1 (a, b, c) CROSS JOIN J2_TBL t2 (d, e)) AS tx (ii, jj, tt, ii2, kk)

-- sqlfmt-corpus-separator --

SELECT *
FROM
  (VALUES (ARRAY['bb','a'])) AS v(x),
  LATERAL unnest(x) WITH ORDINALITY;

-- sqlfmt-corpus-separator --

SELECT *
FROM ROWS FROM (generate_series(6, 7), generate_series(10, 12)) WITH ORDINALITY
ORDER BY ordinality;

-- sqlfmt-corpus-separator --

SELECT *
FROM unnest(ARRAY['a','b','c']) WITH ORDINALITY AS t(letter, position);

-- sqlfmt-corpus-separator --

SELECT * FROM (SELECT 1 a) t1 CROSS JOIN ((SELECT 1 a) t1 CROSS JOIN LATERAL (SELECT a) t2) t3;

-- sqlfmt-corpus-separator --

SELECT * FROM (SELECT 1 a) t1 CROSS JOIN ((SELECT 1 a) t1 CROSS JOIN LATERAL (SELECT t1) t2) t3;

-- sqlfmt-corpus-separator --

SELECT * FROM (SELECT 1 a) t1 CROSS JOIN ((SELECT 1 a) t1 CROSS JOIN LATERAL (SELECT t1.a) t2) t3;

-- sqlfmt-corpus-separator --

SELECT * FROM (SELECT 1 f1) s1 CROSS JOIN ((SELECT 2 f1) s2 CROSS JOIN LATERAL (SELECT f1) s3)

-- sqlfmt-corpus-separator --

SELECT * FROM LATERAL ROWS FROM (generate_series(1, 2), generate_series(3, 6)) WITH ORDINALITY ORDER BY 3;

-- sqlfmt-corpus-separator --

SELECT * FROM LATERAL ROWS FROM (generate_series(1,1)) AS g

-- sqlfmt-corpus-separator --

SELECT * FROM LATERAL ROWS FROM (generate_series(1,1));

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1, 1)) WITH ORDINALITY AS t(g1, o);

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1, 1), generate_series(1, 2)) WITH ORDINALITY AS t(g1, g2, o);

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1, 1), generate_series(1, 2), generate_series(1,3)) WITH ORDINALITY AS t(g1, g2, g3, o);

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1, 1), generate_series(1, 2), generate_series(1,3), generate_series(1,4)) WITH ORDINALITY AS t(g1, g2, g3, g4, o);

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1, 1), generate_series(1, 2), generate_series(1,3), generate_series(1,4), generate_series(1,5)) WITH ORDINALITY AS t(g1, g2, g3, g4, g5, o);

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1, 1), generate_series(1, 2), generate_series(1,3), generate_series(1,4), generate_series(1,5), generate_series(1,6)) WITH ORDINALITY AS t(g1, g2, g3, g4, g5, g6, o);

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1, 1), generate_series(1, 2), generate_series(1,6), generate_series(1,3), generate_series(1,4), generate_series(1,5)) WITH ORDINALITY AS t(g1, g2, g3, g4, g5, g6, o);

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1, 2), generate_series(3, 5)) WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1, 2), generate_series(3, 5)) WITH ORDINALITY AS t (a, b)

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1, 2), generate_series(3, 5)) WITH ORDINALITY AS t (a, b, c)

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1, 2), generate_series(3, 5)) WITH ORDINALITY AS t (a, b, c, d)

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1,6), generate_series(1, 1), generate_series(1, 2), generate_series(1,3), generate_series(1,4), generate_series(1,5)) WITH ORDINALITY AS t(g1, g2, g3, g4, g5, g6, o);

-- sqlfmt-corpus-separator --

SELECT * FROM a CROSS JOIN (b FULL JOIN LATERAL(SELECT a.a FROM c) x ON TRUE);

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE (NULL::text NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id)) IS NOT NULL;

-- sqlfmt-corpus-separator --

SELECT * FROM generate_series(0,3), repeat_row(abs(generate_series - 1)) WITH ORDINALITY;

-- sqlfmt-corpus-separator --

SELECT * FROM generate_series(0,3), repeat_row(generate_series) WITH ORDINALITY;

-- sqlfmt-corpus-separator --

SELECT * FROM generate_series(0,3), repeat_row_non_negative(abs(generate_series - 1)) WITH ORDINALITY;

-- sqlfmt-corpus-separator --

SELECT * FROM generate_series(0,3), repeat_row_non_negative(generate_series) WITH ORDINALITY;

-- sqlfmt-corpus-separator --

SELECT * FROM generate_series(2, 4) WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT * FROM length('str') WITH ORDINALITY;

-- sqlfmt-corpus-separator --

SELECT * FROM mod(3,4) WITH ORDINALITY;

-- sqlfmt-corpus-separator --

SELECT * FROM y a, y b, jsonb_array_elements(a.a) WITH ORDINALITY;

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

SELECT x.a, g, o
FROM x, LATERAL (SELECT * FROM generate_series(1, x.a) WITH ORDINALITY AS t(g, o))

-- sqlfmt-corpus-separator --

SELECT x.a, generate_series, ordinality
FROM x, LATERAL (SELECT * FROM generate_series(1, x.a) WITH ORDINALITY)

-- sqlfmt-corpus-separator --

select * from ((select f1/2 as x from int4_tbl) ss1 join int4_tbl i4 on x = f1) j,
  lateral (select x) ss2(y);