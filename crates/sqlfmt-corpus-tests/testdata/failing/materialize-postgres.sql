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