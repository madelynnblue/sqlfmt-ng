DECLARE c CURSOR FOR SUBSCRIBE (SELECT 1/a FROM t)

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t ENVELOPE UPSERT (KEY (a)) WITH (PROGRESS)

-- sqlfmt-corpus-separator --

DECLARE c2 CURSOR FOR SUBSCRIBE TO (SHOW CLUSTER REPLICAS);

-- sqlfmt-corpus-separator --

PREPARE a AS SELECT 1 = (SELECT $1::int)

-- sqlfmt-corpus-separator --

PREPARE b AS SELECT EXISTS (SELECT $1::int)

-- sqlfmt-corpus-separator --

PREPARE fizz_paginated AS
SELECT *
FROM fizz
ORDER BY a, b DESC
LIMIT $1
OFFSET $2

-- sqlfmt-corpus-separator --

PREPARE i1 AS
INSERT INTO t(a) VALUES($1);

-- sqlfmt-corpus-separator --

PREPARE i2 AS
INSERT INTO t(a) VALUES($1 - 1) RETURNING $1 + 1;

-- sqlfmt-corpus-separator --

PREPARE i3 AS
INSERT INTO t(a) VALUES(4) RETURNING $1 + $1;

-- sqlfmt-corpus-separator --

PREPARE i3 AS
INSERT INTO t(a) VALUES(4) RETURNING $1;

-- sqlfmt-corpus-separator --

PREPARE p1 AS
SELECT $1 + $1::bigint;

-- sqlfmt-corpus-separator --

PREPARE p1 AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET $1;

-- sqlfmt-corpus-separator --

PREPARE p2 AS
SELECT
  (SELECT sum(a) FROM (
    SELECT a
    FROM foo
    ORDER BY a, b
    OFFSET $1
  ))
FROM foo AS outer_foo
OFFSET $2;

-- sqlfmt-corpus-separator --

PREPARE p2 AS
SELECT $1::bigint + $1::bigint;

-- sqlfmt-corpus-separator --

PREPARE p3 AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET $1 - 2;

-- sqlfmt-corpus-separator --

PREPARE p4 AS
SELECT $1::text || $1::bigint::text;

-- sqlfmt-corpus-separator --

PREPARE p5 AS
SELECT $1, $1::bigint;

-- sqlfmt-corpus-separator --

PREPARE p6 AS
SELECT $1 + $1::bigint, $1 || $1;

-- sqlfmt-corpus-separator --

PREPARE p6 AS
VALUES (10), (11), (12), ($2), ($3)
ORDER BY 1 DESC
OFFSET $1 - 1

-- sqlfmt-corpus-separator --

PREPARE p7 AS
SELECT $1 || $1, $1 + $1::bigint;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT
  (
    SELECT *
    FROM foo
    ORDER BY a, b
    OFFSET outer_foo.a
  )
FROM foo AS outer_foo;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT
  (
    SELECT *
    FROM foo
    ORDER BY a, b
    OFFSET outer_foo.a + $1
  )
FROM foo AS outer_foo;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT
  (
    SELECT a
    FROM foo
    ORDER BY a, b
    OFFSET lag(5) OVER ()
  )
FROM foo AS outer_foo;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET 'aaa';

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET -7;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET 5-7;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET a;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET null;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY b, a
OFFSET (SELECT 2);

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY b, a
OFFSET lag(5) OVER ();

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY b, a
OFFSET mz_now()::string::bigint;

-- sqlfmt-corpus-separator --

PREPARE p_error_1 AS
SELECT
  (
    SELECT b
    FROM foo
    ORDER BY a, b
    OFFSET outer_foo.a + $1
  )
FROM foo AS outer_foo;