SELECT 'abc'::char(3) !~~* 'Abc'::char(4);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) ~~ 'abc ';

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) ~~ 'abc'::char(4);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) ~~ 'abc';

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(4) ~~ 'abc ';

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(4) ~~ 'abc'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(4) ~~ 'abc'::char(4);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(4) ~~ 'abc';

-- sqlfmt-corpus-separator --

SELECT (1, 2) = ANY(SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT (1, 2) = SOME(SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = ANY(SELECT a FROM abc WHERE b = 10)

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE bill = ANY(SELECT ship FROM o);

-- sqlfmt-corpus-separator --

SELECT 1 = ANY(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 = SOME(SELECT 1)