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