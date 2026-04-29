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

-- sqlfmt-corpus-separator --

SELECT
	DISTINCT column1::daterange
FROM
	(
		VALUES
			('   empty'),
			('empty  '),
			('  [1970-01-01,)'),
			('[  1970-01-01,)'),
			('[1970-01-01  ,)'),
			('[  1970-01-01  ,)'),
('[1970-01-01,  1970-01-01)'),
			('[1970-01-01,1970-01-01  )'),
			('[1970-01-01,  1970-01-01  )'),
			('[1970-01-01,)  '),
			('  (,1970-01-01)'),
			('(,  1970-01-01)'),
			('  (,)  ')
	) t;

-- sqlfmt-corpus-separator --

SELECT
	DISTINCT column1::int4range
FROM
	(
		VALUES
			('   empty'),
			('empty  '),
			('  [1,)'),
			('[  1,)'),
			('[1  ,)'),
			('[  1  ,)'),
            ('[1,  2)'),
			('[1,2  )'),
			('[1,  2  )'),
			('[1,)  '),
			('  (,1)'),
			('(,  1)'),
			('  (,)  ')
	) t;

-- sqlfmt-corpus-separator --

SELECT
	DISTINCT column1::numrange
FROM
	(
		VALUES
			('   empty'),
			('empty  '),
			('  [1,)'),
			('[  1,)'),
			('[1  ,)'),
			('[  1  ,)'),
('[1,  2)'),
			('[1,2  )'),
			('[1,  2  )'),
			('[1,)  '),
			('  (,1)'),
			('(,  1)'),
			('  (,)  ')
	) t;

-- sqlfmt-corpus-separator --

SELECT
	DISTINCT column1::tsrange
FROM
	(
		VALUES
			('   empty'),
			('empty  '),
			('  [1970-01-01 00:00:01,)'),
			('[  1970-01-01 00:00:01,)'),
			('[1970-01-01 00:00:01  ,)'),
			('[  1970-01-01 00:00:01  ,)'),
('[1970-01-01 00:00:01,  1970-01-01 00:00:02)'),
			('[1970-01-01 00:00:01,1970-01-01 00:00:02  )'),
			('[1970-01-01 00:00:01,  1970-01-01 00:00:02  )'),
			('[1970-01-01 00:00:01,)  '),
			('  (,1970-01-01 00:00:01)'),
			('(,  1970-01-01 00:00:01)'),
			('  (,)  ')
	) t;

-- sqlfmt-corpus-separator --

SELECT
	DISTINCT column1::tstzrange
FROM
	(
		VALUES
			('   empty'),
			('empty  '),
			('  [1970-01-01 00:00:01,)'),
			('[  1970-01-01 00:00:01,)'),
			('[1970-01-01 00:00:01  ,)'),
			('[  1970-01-01 00:00:01  ,)'),
('[1970-01-01 00:00:01,  1970-01-01 00:00:02)'),
			('[1970-01-01 00:00:01,1970-01-01 00:00:02  )'),
			('[1970-01-01 00:00:01,  1970-01-01 00:00:02  )'),
			('[1970-01-01 00:00:01,)  '),
			('  (,1970-01-01 00:00:01)'),
			('(,  1970-01-01 00:00:01)'),
			('  (,)  ')
	) t;

-- sqlfmt-corpus-separator --

SELECT
    (
        SELECT inner2.f2
        FROM t1 AS inner1 RIGHT JOIN t2 AS inner2 ON (inner2.f2 + 1 = inner2.f2)
        WHERE outer2.f2 BETWEEN 0 AND 0 AND outer1.f2 = outer1.f1
        ORDER BY 1
        LIMIT 1
    ),
    (
        SELECT inner1.f1 + 1
        FROM t1 AS inner1 LEFT JOIN t2 AS inner2 ON (inner1.f2 + 1 BETWEEN inner2.f2 AND inner1.f2)
        WHERE outer1.f2 + 1 IS NULL AND inner2.f2 IS NULL
        ORDER BY 1
        LIMIT 1
    ),
    (
        SELECT inner1.f1 + 1
        FROM pk1 AS inner1, pk2 AS inner2
        WHERE inner2.f1 + 1 IS NOT NULL AND inner2.f2 IS NULL
        ORDER BY 1
        LIMIT 0
    ),
    (
        SELECT inner1.f1
        FROM t1 AS inner1 JOIN t2 AS inner2 ON (inner2.f2 + 1 BETWEEN 1 AND 1)
        WHERE inner2.f1 IS NOT NULL OR inner1.f1 IS NOT NULL
        ORDER BY 1
        LIMIT 1
    )
FROM
    t1 AS outer1
        JOIN
            (
                    SELECT DISTINCT inner1.f2 AS f1, inner1.f2 + 1 AS f2
                    FROM pk2 AS inner1, pk2 AS inner2
                    WHERE inner2.f1 IS NOT NULL
                )
                AS outer2
            ON (outer2.f1 BETWEEN 1 AND 8)
WHERE
    outer1.f2 BETWEEN outer1.f1 AND outer2.f2 + 1
        AND
    outer2.f2
    = (
            SELECT inner2.f2
            FROM t1 AS inner1 JOIN t2 AS inner2 ON (inner2.f1 BETWEEN inner1.f1 AND 1)
            WHERE inner2.f1 + 1 IS NOT NULL AND outer2.f1 + 1 IS NULL
            ORDER BY 1
            LIMIT 0
        )
        AND
    outer1.f1 + 1
    = (
            SELECT inner1.f2 FROM t1 AS inner1, pk1 AS inner2 WHERE outer2.f2 > outer2.f1 + 1
            ORDER BY 1
            LIMIT 1
        )
        AND
    outer2.f2 + 1
    = (
            SELECT inner1.f1 + 1
            FROM t1 AS inner1 LEFT JOIN t2 AS inner2 ON (inner1.f2 IS NULL)
            WHERE inner1.f2 + 1 BETWEEN 1 AND outer2.f2
            ORDER BY 1
            LIMIT 1
        )
        AND
    NOT
    EXISTS (
        SELECT DISTINCT inner2.f1
        FROM t1 AS inner1 LEFT JOIN t2 AS inner2 ON (inner1.f2 BETWEEN inner1.f2 AND 1)
        WHERE inner1.f2 + 1 BETWEEN 8 AND inner1.f1 AND outer1.f2 BETWEEN 9 AND 1
    )
        OR
    outer2.f2 + 1 = outer1.f2 + 1;

-- sqlfmt-corpus-separator --

SELECT
    c.position, c.name, c.type, c.type_mod, left(t.id, 1)
    FROM mz_columns c
    JOIN mz_views v ON c.id = v.id
    JOIN mz_types t ON c.type_oid = t.oid
    WHERE v.name = 'v'
    ORDER BY c.position

-- sqlfmt-corpus-separator --

SELECT
  *,
  first_value(
    lag(x*x,y,1111) OVER (PARTITION BY x ORDER BY y)
  ) OVER (PARTITION BY x ORDER BY y),
  x*y,
  last_value(
    lag(x*x,y,2222) OVER (PARTITION BY x ORDER BY y)
  ) OVER (PARTITION BY x ORDER BY y+y),
  last_value(x+y) OVER (PARTITION BY x ORDER BY y+y),
  lag(y)          OVER (ORDER BY x),
  x+y
FROM t7
ORDER BY x,y;

-- sqlfmt-corpus-separator --

SELECT
  *,
  lag(x)          OVER (ORDER BY x),
  first_value(x)  OVER (ORDER BY x),
  last_value(x)   OVER (ORDER BY x),
  x*y,
  lag(y)          OVER (ORDER BY x),
  lag(x+x,1,null) OVER (PARTITION BY x ORDER BY y),
  lead(x,2,null)  OVER (PARTITION BY x ORDER BY -y NULLS FIRST),
  lead(x,2,null)  OVER (PARTITION BY x ORDER BY -y NULLS LAST),
  x+y,
  lag(x+x,2,null) OVER (PARTITION BY x ORDER BY y),
  sum(x)          OVER (ORDER BY x),
  min(x)          OVER (ORDER BY x),
  max(x)          OVER (ORDER BY y)
FROM t7
ORDER BY x,y;

-- sqlfmt-corpus-separator --

SELECT
  a,
  3 + lag(a) OVER (ORDER BY a),
  3 + lag(a) OVER (ORDER BY a),
  lag(a) OVER (ORDER BY a),
  lead(a) OVER (ORDER BY a),
  5 + lag(a) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT
  array_agg(y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  array_agg(y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  avg(y+y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  avg(y+y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  count(*) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  count(min(x)) OVER ()
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  count(y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  count(y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING),
  sum(y)   OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  count(y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  lag(x,y,100) OVER (PARTITION BY x ORDER BY y+y)
FROM t9;

-- sqlfmt-corpus-separator --

SELECT
  lead(x,y-2,120) OVER (PARTITION BY x ORDER BY x)
FROM t9;

-- sqlfmt-corpus-separator --

SELECT
  length(s),
  count(DISTINCT s),
  count(DISTINCT length(s))
FROM kv GROUP BY length(s) HAVING count(DISTINCT s) > 1

-- sqlfmt-corpus-separator --

SELECT
  min(count(x)) OVER ()
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  min(y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  o1,
  o2,
  v,
  sum(v) OVER (ORDER BY o1, o2),
  max(v) OVER (ORDER BY o1, o2),
  min(v) OVER (ORDER BY o1, o2),
  array_agg(v) OVER (ORDER BY o1, o2 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t8
ORDER BY o1, o2;

-- sqlfmt-corpus-separator --

SELECT
  o1,
  o2,
  v,
  sum(v) OVER (PARTITION BY o1 ORDER BY o2),
  max(v) OVER (PARTITION BY o1 ORDER BY o2),
  min(v) OVER (PARTITION BY o1 ORDER BY o2),
  array_agg(v) OVER (PARTITION BY o1 ORDER BY o2 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t8
ORDER BY o1, o2;

-- sqlfmt-corpus-separator --

SELECT
  sum(sum(x)) OVER ()
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (ORDER BY x ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (ORDER BY x ROWS BETWEEN 3 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  tcm.chat_id AS chat_id,
  tcm.chat_message_id AS chat_message_id,
  tcm.message_tstamp AS message_tstamp,
  tcm.first_xxx_id AS first_xxx_id,
  lead(tcm.first_xxx_id) ignore nulls over (partition by tcm.chat_id order by tcm.message_tstamp) AS _lead,
  lag(tcm.first_xxx_id) ignore nulls over (partition by tcm.chat_id order by tcm.message_tstamp) AS _lag,
  CASE
    WHEN tcm.boolean_flag THEN
      coalesce(
          lead(tcm.first_xxx_id) ignore nulls over (partition by tcm.chat_id order by tcm.message_tstamp),
          lag(tcm.first_xxx_id) ignore nulls over (partition by tcm.chat_id order by tcm.message_tstamp),
          tcm.xxx_id
      )
    ELSE tcm.user_id end AS xxx_id,
  tcm.boolean_flag AS boolean_flag
FROM tcm
ORDER BY chat_id, message_tstamp;

-- sqlfmt-corpus-separator --

SELECT
  x,
  sum(sum(x) OVER (ORDER BY x)) OVER (ORDER BY x),
  sum(x/3.14) OVER (ORDER BY x),
  max(x/3.14) OVER (ORDER BY x)
FROM (SELECT DISTINCT ON(x) * FROM t_using_dataflow_rendering);

-- sqlfmt-corpus-separator --

SELECT
  x,
  sum(x) OVER (ORDER BY x),
  sum(sum(x) OVER (ORDER BY x)) OVER (ORDER BY x)
FROM (SELECT DISTINCT ON(x) * FROM t7);

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  lag(x,y,100)    OVER (PARTITION BY x ORDER BY y+y),
  lag(x,y,110)    OVER (PARTITION BY x ORDER BY y+y),
  lag(x,y,100)    OVER (PARTITION BY x ORDER BY y+y),
  first_value(y)  OVER (PARTITION BY x ORDER BY y+y),
  last_value(y)   OVER (PARTITION BY x ORDER BY y+y),
  lead(x,y-2,120) OVER (PARTITION BY x ORDER BY y+y)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING),
  max(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING),
  min(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING),
  array_agg(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING)
FROM t7
ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING),
  max(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING),
  min(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING),
  array_agg(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING)
FROM t7
ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING),
  max(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING),
  min(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING),
  array_agg(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t7
ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 FOLLOWING AND 4 FOLLOWING),
  max(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 FOLLOWING AND 4 FOLLOWING),
  min(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 FOLLOWING AND 4 FOLLOWING),
  array_agg(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 FOLLOWING AND 4 FOLLOWING)
FROM t7
ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING),
  max(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING),
  min(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING),
  array_agg(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING)
FROM t7
ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING),
  max(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING),
  min(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING),
  array_agg(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING)
FROM t7
ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 30 FOLLOWING AND 1 FOLLOWING),
  max(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 30 FOLLOWING AND 1 FOLLOWING),
  min(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 30 FOLLOWING AND 1 FOLLOWING),
  array_agg(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 30 FOLLOWING AND 1 FOLLOWING)
FROM t7
ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  max(x+x) OVER (PARTITION BY x-y ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  min(x+x) OVER (PARTITION BY x-y ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-y ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x-y, x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  max(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  min(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x-y, x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(y) OVER (),
  max(y) OVER (),
  min(y) OVER (),
  array_agg(y ORDER BY y) OVER (),
  array_agg(y ORDER BY y NULLS LAST) OVER (),
  array_agg(y ORDER BY y NULLS FIRST) OVER (),
  bool_and(x%3 != 0) OVER ()
FROM t7
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(y) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  max(y) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  min(y) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(y) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(y) OVER (ORDER BY x ROWS BETWEEN 2 FOLLOWING AND 5 FOLLOWING),
  max(y) OVER (ORDER BY x ROWS BETWEEN 2 FOLLOWING AND 5 FOLLOWING),
  min(y) OVER (ORDER BY x ROWS BETWEEN 2 FOLLOWING AND 5 FOLLOWING),
  list_agg(y) OVER (ORDER BY x ROWS BETWEEN 2 FOLLOWING AND 5 FOLLOWING)[1]
FROM t7
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(y) OVER (ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
  max(y) OVER (ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
  min(y) OVER (ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
  jsonb_agg(y) OVER (ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t7
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(y) OVER (ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  max(y) OVER (ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  min(y) OVER (ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(y) OVER (ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
  max(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
  min(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
  array_agg(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t7
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  y/10,
  lag(y, y/10) OVER (ORDER BY x),
  lag(y, y/10) IGNORE NULLS OVER (ORDER BY x),
  lead(y, y/10) OVER (ORDER BY x),
  lead(y, y/10) IGNORE NULLS OVER (ORDER BY x)
FROM t6_no_nulls
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x-row_number() OVER (ORDER BY x+y),
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  max(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  min(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t7
ORDER BY x-row_number() OVER (ORDER BY x+y), x;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  max(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  min(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t7
ORDER BY x-y+x/10, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1000000 PRECEDING AND 1000000 FOLLOWING),
  max(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1000000 PRECEDING AND 1000000 FOLLOWING),
  min(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1000000 PRECEDING AND 1000000 FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 1000000 PRECEDING AND 1000000 FOLLOWING)
FROM t7
ORDER BY x-y+x/10, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
  max(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
  min(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
  array_agg(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t7
ORDER BY x-y+x/10, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING),
  max(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING),
  min(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t7
ORDER BY x-y+x/10, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND CURRENT ROW),
  max(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND CURRENT ROW),
  min(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND CURRENT ROW),
  array_agg(x+x) OVER (PARTITION BY x-y+x/10 ORDER BY x ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t7
ORDER BY x-y+x/10, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(y) OVER (PARTITION BY x-y+x/10 ROWS BETWEEN 200 PRECEDING AND 100 PRECEDING),
  count(y) OVER (PARTITION BY x-y+x/10 ROWS BETWEEN 200 PRECEDING AND 100 PRECEDING),
  array_agg(y) OVER (PARTITION BY x-y+x/10 ROWS BETWEEN 200 PRECEDING AND 100 PRECEDING),
  avg(y) OVER (PARTITION BY x-y+x/10 ROWS BETWEEN 200 PRECEDING AND 100 PRECEDING)
FROM t7
ORDER BY x, y;

-- sqlfmt-corpus-separator --

SELECT
  x-y+x/10,
  x,
  y,
  sum(y) OVER (PARTITION BY x-y+x/10),
  max(y) OVER (PARTITION BY x-y+x/10),
  min(y) OVER (PARTITION BY x-y+x/10),
  array_agg(y) OVER (PARTITION BY x-y+x/10)
FROM t7
ORDER BY x-y+x/10;

-- sqlfmt-corpus-separator --

SELECT
  x-y,
  x,
  y,
  array_agg(x ORDER BY CASE WHEN y IS NOT NULL THEN y ELSE x%5 END DESC) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(2*x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  list_agg(2*x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)[2]
FROM t7
ORDER BY x-y, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y,
  x,
  y,
  array_agg(x/10) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  count(DISTINCT x/10) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x-y, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y,
  x,
  y,
  jsonb_agg(2*x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  avg(x+y) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  variance(x+y) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  var_pop(x+y) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  stddev(x+y) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  stddev_pop(x+y) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x-y, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y,
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  max(x*y+1) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  min(x*y+1) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(2*x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  count(2*x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  count(CASE WHEN x%3 != 0 THEN x ELSE null END) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  count(*) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  sum(x) FILTER (WHERE x%3 != 0) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  bool_and(x%3 != 0) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  bool_or(x%3 = 0) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x-y, x;

-- sqlfmt-corpus-separator --

SELECT
  x-y,
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  max(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  min(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x-y, x;

-- sqlfmt-corpus-separator --

SELECT (SELECT DISTINCT ON (a) a FROM abc ORDER BY a, b||'foo') || 'bar';

-- sqlfmt-corpus-separator --

SELECT (SELECT count(*) FROM foo WHERE length(b) = length(outer_b)) as part, *,
    lag(outer_a) OVER (
        PARTITION BY (SELECT count(*) FROM foo WHERE length(b) = length(outer_b))
        ORDER BY outer_a
    )
FROM (
    SELECT a AS outer_a, b AS outer_b
    FROM foo
) as fsq
ORDER BY part, outer_a;

-- sqlfmt-corpus-separator --

SELECT (SELECT count(*) FROM foo WHERE length(outer_b) > a + 2) as ord, *,
    lag(outer_a) OVER (
        ORDER BY (SELECT count(*) FROM foo WHERE length(outer_b) > a + 2), outer_a
    )
FROM (
    SELECT a AS outer_a, b AS outer_b
    FROM foo
) as fsq
ORDER BY ord, outer_a;

-- sqlfmt-corpus-separator --

SELECT (SELECT string_agg(DISTINCT ship, ', ')
  FROM
  (SELECT c_id AS o_c_id, ship FROM o ORDER BY ship)
  WHERE o_c_id=c.c_id)
FROM c ORDER BY c_id

-- sqlfmt-corpus-separator --

SELECT * FROM kv GROUP BY v, count(DISTINCT w)

-- sqlfmt-corpus-separator --

SELECT * FROM not_allowed_tests GROUP BY v, count(w) OVER ();

-- sqlfmt-corpus-separator --

SELECT * FROM t
WHERE row_number() over () > 1;

-- sqlfmt-corpus-separator --

SELECT *,
    lag(
        outer_a,
        (SELECT count(*) FROM foo WHERE length(b) = length(outer_b))::integer
    ) OVER (ORDER BY outer_a)
FROM (
    SELECT a AS outer_a, b AS outer_b
    FROM foo
) as fsq
ORDER BY outer_a;

-- sqlfmt-corpus-separator --

SELECT *,
    lag(
        outer_a,
        (SELECT count(*) FROM foo WHERE length(b) = length(outer_b))::integer,
        CASE WHEN outer_a - 1 IN (SELECT a FrOM foo) THEN 100 ELSE 500 END
    ) OVER (ORDER BY outer_a)
FROM (
    SELECT a AS outer_a, b AS outer_b
    FROM foo
) as fsq
ORDER BY outer_a;

-- sqlfmt-corpus-separator --

SELECT *,
    lag(outer_a) OVER (
        ORDER BY (SELECT count(*) FROM foo WHERE length(outer_b) > a + 2), outer_a
    )
FROM (
    SELECT a AS outer_a, b AS outer_b
    FROM foo
) as fsq
ORDER BY outer_a;

-- sqlfmt-corpus-separator --

SELECT *,
    lag(outer_a) OVER (
        PARTITION BY (SELECT count(*) FROM foo WHERE length(b) = length(outer_b))
        ORDER BY outer_a
    )
FROM (
    SELECT a AS outer_a, b AS outer_b
    FROM foo
) as fsq
ORDER BY outer_a;

-- sqlfmt-corpus-separator --

SELECT *, row_number() OVER (PARTITION BY len ORDER BY sum DESC, lag NULLS FIRST) as row_num FROM (
    (SELECT length(b) AS len, sum(a) AS sum, lag(sum(a)) OVER (ORDER BY sum(a)) AS lag
     FROM foo
     GROUP BY length(b))
    UNION
    (SELECT length(b), -1 + sum(a) + row_number() OVER (ORDER BY length(b)), lag(sum(a)) OVER (ORDER BY length(b))
     FROM foo
     GROUP BY length(b))
) AS sq
ORDER BY len, row_num;

-- sqlfmt-corpus-separator --

SELECT -sum(foo.a), b
FROM foo LEFT JOIN (SELECT a as right_a FROM foo WHERE a<2) ON foo.a = right_a
GROUP BY b, right_a
ORDER BY lag(10*right_a+3) OVER (ORDER BY right_a NULLS FIRST), -sum(foo.a), b;

-- sqlfmt-corpus-separator --

SELECT 1 + lag(a, 1, 0) OVER (ORDER BY a), *
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a), a ASC;

-- sqlfmt-corpus-separator --

SELECT 1 + lag(a, 1, 0) OVER (ORDER BY a), *
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT 1 + lag(a, 1, 0) OVER (ORDER BY a), lead(a) OVER (ORDER BY b) AS o, a, b
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a), o DESC;

-- sqlfmt-corpus-separator --

SELECT 1 FROM not_allowed_tests GROUP BY 1 HAVING sum(1) OVER (PARTITION BY 1) > 1;

-- sqlfmt-corpus-separator --

SELECT 10-sum(a), lag(sum(a)) OVER (ORDER BY sum(a))
FROM foo
GROUP BY b
ORDER BY 2;

-- sqlfmt-corpus-separator --

SELECT 10-sum(a), lag(sum(a)) OVER (ORDER BY sum(a))
FROM foo
GROUP BY b
ORDER BY 3;

-- sqlfmt-corpus-separator --

SELECT 78 + - MAX ( DISTINCT - 32 ) / COALESCE ( - 25, 13 + MIN ( + 12 ) + - CAST ( NULL AS INTEGER ) * + MAX ( 8 ) * + AVG ( + + 43 ) ) * + 61 + ( + 36 ) + + ( 17 ) + - + 40 * + + 82

-- sqlfmt-corpus-separator --

SELECT ALL NULLIF ( 38, + 23 * + ( + 46 ) ) + + COUNT ( * ) - + COUNT ( DISTINCT + + 0 ) + + - 57 + + - 48 / - + COALESCE ( 85, - AVG ( + 53 ) ) * + 4 * + 44 / 22

-- sqlfmt-corpus-separator --

SELECT DISTINCT
  (a1.f1) AS c1,
  (a1.f2) AS c2
FROM
  t1 AS a1
  JOIN (VALUES(1, 2)) AS a2(f1, f2) ON (a2.f2 = a1.f1)
WHERE
  a1.f2 + a2.f2 > (SELECT DISTINCT 0 c2 FROM t2 AS a1) AND a2.f2 IS NULL
  OR NULLIF (a2.f2, a2.f1) = a1.f2 + a1.f2;

-- sqlfmt-corpus-separator --

SELECT DISTINCT
  event_type,
  object_type,
  (details->'cluster_name')::text,
  (details->'reason')::text,
  (details->'scheduling_policies') IS NULL,
  regexp_replace((details->'scheduling_policies'->'on_refresh')::text, '\["u.*"\]', '["uXXX"]')
FROM mz_audit_events
WHERE
  event_type IN ('create', 'drop') AND
  object_type = 'cluster-replica' AND
  ((details->'cluster_name')::text LIKE '"c_schedule_%"' OR (details->'cluster_name')::text = '"other"') AND
  (details->'cluster_name')::text != '"c_schedule_4"';

-- sqlfmt-corpus-separator --

SELECT DISTINCT
  event_type,
  object_type,
  (details->'cluster_name')::text,
  (details->'reason')::text,
  (details->'scheduling_policies') IS NULL,
  regexp_replace((details->'scheduling_policies'->'on_refresh')::text, '\["u.*"\]', '["uXXX"]')
FROM mz_audit_events
WHERE
  event_type IN ('create', 'drop') AND
  object_type = 'cluster-replica' AND
  (details->'cluster_name')::text = '"c_schedule_6"';

-- sqlfmt-corpus-separator --

SELECT DISTINCT - CASE CAST ( - 91 AS INTEGER ) WHEN + COUNT ( * ) THEN NULL WHEN + 31 - + COALESCE ( + CAST ( - 3 AS INTEGER ), - + 66 ) THEN - + AVG ( DISTINCT + 72 ) ELSE - COUNT ( * ) END * 58 * + + ( COUNT ( * ) ) / - 61 * + - 33 * + 65 - - 65 AS col0

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (1) x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (1,2,3) x, y, z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (2) x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a) a, b, c FROM abc ORDER BY a, b, c

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a) a, c FROM abc ORDER BY a, c DESC, b

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a, c) a, b FROM abc ORDER BY a, c, b

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (b) a FROM t GROUP BY a ORDER BY b

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (b) b FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (b, c, a) a FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (b, c, a) a, c, b FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (c) a FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (c, a) b, c, a FROM abc ORDER BY c, a, b DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (c, a, b) b FROM abc ORDER BY b

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (max(x)) min(y) FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (min(x)) max(y) FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (row_number() OVER ()) *
FROM t
ORDER BY row_number() OVER ()

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) min(x) FROM xyz GROUP BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) x FROM xyz ORDER BY x DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) x, y FROM xyz WHERE x = 1 ORDER BY x, y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) x, y, z FROM xyz ORDER BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) y, z, x FROM xyz ORDER BY x ASC, z DESC, y DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, y) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, y) y, x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, y, z) pk1 FROM (SELECT * FROM xyz WHERE x >= 2) ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, y, z) x, y, z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, z) y, z, x FROM xyz WHERE (x,y,z) != (4, 1, 6) ORDER BY z

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y) x, y, z FROM xyz ORDER BY x, y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x) x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x, z) x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, z) x, y, z FROM xyz ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (z, y, x) z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(((x)), (x, y)) x, y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(1 + lag(a, 1, 0) OVER (ORDER BY a)) *
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a), a ASC;

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(1 + lag(a, 1, 0) OVER (ORDER BY a)) *
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(1 + lag(a, 1, 0) OVER (ORDER BY a)) *
FROM foo
ORDER BY lag(a, 1, 0) OVER (ORDER BY a), a DESC;

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(1 + lag(a, 1, 0) OVER (ORDER BY a)) lead(a) OVER (ORDER BY b) AS o, a, b
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a), o DESC;

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(max(x)) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(max(x), z) min(y) FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(max_a) max_a, b
FROM (
    SELECT b, MAX(a) AS max_a
    FROM t
    GROUP BY b
)
ORDER BY max_a, b DESC;

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(min(a), max(b), min(c)) max(c) FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(min(x)) min(x) FROM xyz GROUP BY y HAVING min(x) = 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(pk1, pk2, x, y) x, y, z FROM xyz ORDER BY x, y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz ORDER BY row_number() OVER(ORDER BY (pk1, pk2)) DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(x) x AS y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(y) min(x) FROM xyz GROUP BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM daterange_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM foo ORDER BY a + 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM foo ORDER BY b

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM int4range_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM int8range_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM numrange_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM tsrange_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM tstzrange_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT DISTINCT authors.name FROM books AS b1, books2 as b2, authors WHERE b1.title = b2.title AND authors.book = b1.title AND b1.shelf <> b2.shelf

-- sqlfmt-corpus-separator --

SELECT DISTINCT b, a FROM foo ORDER BY b

-- sqlfmt-corpus-separator --

SELECT DISTINCT b1.title FROM books as b1 JOIN books2 as b2 ON b1.title = b2.title WHERE b1.shelf <> b2.shelf

-- sqlfmt-corpus-separator --

SELECT DISTINCT c, b FROM t ORDER BY b DESC LIMIT 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT column1 FROM (
    VALUES
        (0.1),
        (0.10),
        (0.100),
        (0.1000),
        (0.10000)
);

-- sqlfmt-corpus-separator --

SELECT DISTINCT lower(a), upper(a) FROM daterange_values;

-- sqlfmt-corpus-separator --

SELECT DISTINCT lower(a), upper(a) FROM int4range_values
ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

SELECT DISTINCT lower(a), upper(a) FROM int8range_values
ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

SELECT DISTINCT lower(a), upper(a) FROM numrange_values;

-- sqlfmt-corpus-separator --

SELECT DISTINCT lower(a), upper(a) FROM tsrange_values ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

SELECT DISTINCT lower(a), upper(a) FROM tstzrange_values ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

SELECT DISTINCT name, create_sql
FROM mz_indexes
WHERE cluster_id =
  (SELECT id FROM mz_clusters WHERE name = 'mz_catalog_server')
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT o.name dependent_object_name, co.name column_name
FROM mz_indexes i
LEFT JOIN mz_internal.mz_object_transitive_dependencies d ON i.id = d.object_id
LEFT JOIN mz_objects o ON o.id = d.referenced_object_id
JOIN mz_columns co on co.id = o.id
WHERE i.cluster_id =
  (SELECT id FROM mz_clusters WHERE name = 'mz_catalog_server')
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT object FROM objects WHERE schema IN ('mz_catalog') ORDER BY object

-- sqlfmt-corpus-separator --

SELECT DISTINCT object FROM objects WHERE schema IN ('mz_internal') ORDER BY object

-- sqlfmt-corpus-separator --

SELECT DISTINCT object FROM objects WHERE schema IN ('mz_introspection') ORDER BY object

-- sqlfmt-corpus-separator --

SELECT DISTINCT octet_length(a) FROM bpchar_t;

-- sqlfmt-corpus-separator --

SELECT DISTINCT(attgenerated = '') FROM pg_attribute

-- sqlfmt-corpus-separator --

SELECT DISTINCT(privilege) FROM item_privileges WHERE type = 'table'

-- sqlfmt-corpus-separator --

SELECT DISTINCT(privilege) FROM item_privileges WHERE type = 'type'

-- sqlfmt-corpus-separator --

SELECT DISTINCT(privilege) FROM item_privileges WHERE type = 'view' OR type = 'materialized view' OR type = 'source'

-- sqlfmt-corpus-separator --

SELECT a FROM foo
ORDER BY lag(a) OVER (ORDER BY -a NULLS FIRST) DESC NULLS LAST;

-- sqlfmt-corpus-separator --

SELECT a FROM foo
ORDER BY lag(a) OVER (ORDER BY a) NULLS LAST;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a &< v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a &> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a -|- v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a >> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a &< v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a &> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a -|- v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a >> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a &< v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a &> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a -|- v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a >> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a &< v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a &> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a -|- v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a >> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a &< v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a &> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a -|- v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a >> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a &< v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a &> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a -|- v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a >> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, 2*a as d
FROM foo
ORDER BY lag(d) OVER (ORDER BY d);

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b ORDER BY b ASC), array_agg(b ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b ORDER BY b) FROM t GROUP BY a HAVING array_agg(b ORDER BY b) = array_agg(b ORDER BY b DESC);

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b), string_agg(c, ',' ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY a) + lag(a) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY a) + lead(a) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY a), lag(lag(a) OVER (ORDER BY a)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY lag(a) OVER (ORDER BY a))
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY lag(a) OVER (ORDER BY a)), lag(a) OVER (ORDER BY a)
FROM foo
ORDER BY lag(a) OVER (ORDER BY a);

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (PARTITION BY lag(length(b)) OVER (ORDER BY a) ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (PARTITION BY lag(length(b)) OVER (ORDER BY a) ORDER BY a), lag(length(b)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(lag(a) OVER (ORDER BY a)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(lag(a) OVER (ORDER BY a)) OVER (ORDER BY a), lag(a) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(lag(a) OVER (PARTITION BY length(b) ORDER BY a)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lead(lag(a) OVER (PARTITION BY lag(length(b)) OVER (ORDER BY a) ORDER BY a), 1, -5) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, row_number() OVER (PARTITION BY lag(length(b)) OVER (ORDER BY a) ORDER BY a), lag(length(b)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, dense_rank() OVER (ORDER BY a), array_agg(b) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT a, lag(a) OVER (ORDER BY a) as d
FROM foo
ORDER BY -d;

-- sqlfmt-corpus-separator --

SELECT a, lag(a) OVER (ORDER BY a) as d
FROM foo
ORDER BY d;

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() OVER() FROM (SELECT * FROM (SELECT 'a' as x UNION ALL SELECT 'b' as x) ORDER BY x limit 1) a

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() OVER() FROM (SELECT * FROM (SELECT 'a' as x UNION ALL SELECT 'b' as x) ORDER BY x) a

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() OVER() from (SELECT TRUE::text as x FROM(SELECT AVG(0) FROM qs)) a

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() over () FROM (SELECT * FROM a ORDER BY x limit 1) a

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() over () FROM (SELECT * FROM a ORDER BY x) a

-- sqlfmt-corpus-separator --

SELECT abs(1) FILTER (WHERE false)

-- sqlfmt-corpus-separator --

SELECT array_agg((a, b) ORDER BY a DESC)::text, array_agg(a ORDER BY a DESC), array_agg(b ORDER BY b DESC) FROM t2;

-- sqlfmt-corpus-separator --

SELECT array_agg(a) FILTER (WHERE a IS NOT NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT array_agg(a) FILTER (WHERE a IS NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b ASC), array_agg(b ORDER BY b DESC), bool_or(b IS NOT NULL) FROM t;

-- sqlfmt-corpus-separator --

SELECT c_custkey,
       COUNT(l_commitDATE),
       COUNT(DISTINCT c_custkey)
FROM lineitem
JOIN orders ON (l_orderkey = o_orderkey)
JOIN customer ON (c_acctbal < o_totalprice)
WHERE l_extendedprice < o_totalprice
  AND l_shipDATE <= '1994-03-17'
  AND o_orderkey >= 53
GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(DISTINCT employee, ',')
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL, NULL::BYTEA)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL, NULL::TEXT)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::BYTEA, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::BYTEA, employee::BYTEA)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::TEXT, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::TEXT, employee)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee)
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, '')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, ',')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, employee, employee)
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, lower(employee))
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTEA, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTEA, b'')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTEA, b',')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(lower(employee), employee)
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT (v)) FROM kv

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT a.*) FROM kv a, kv b

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT id) FROM mz_objects WHERE name LIKE 'id_pool_%'

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT k), count(DISTINCT v), count(DISTINCT (v)) FROM kv

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT w) FROM kv GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT count(w) OVER () FROM not_allowed_tests GROUP BY 1;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY dense_rank, x;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY dense_rank, x;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC, z), x, y, z
FROM t
ORDER BY y, x DESC, z;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY dense_rank, x;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY z DESC), x, y, z
FROM t
ORDER BY y, z DESC, x;

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 100 FOLLOWING AND 1000001 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1000 PRECEDING AND 1000 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1000 PRECEDING AND 999 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551614 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551614 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551615 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + coalesce(nullif(f3, 'NaN'), -10)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, -2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, 10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, -10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 1, f3) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, NULL, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, f1 - 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, nullif(f1, 1)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(nullif(f1, 4)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1000 FOLLOWING AND 1000 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1000 FOLLOWING AND 1001 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1000001 PRECEDING AND 100 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551614 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551615 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f3) OVER (PARTITION BY f2 ORDER BY f1)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + coalesce(nullif(f3, 'NaN'), -10)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, -2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, 10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, -10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 1, f3) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, NULL, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, f1 - 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, nullif(f1, 1)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(nullif(f1, 4)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, lag(0, f1 , 0) OVER (PARTITION BY f1 ORDER BY f1) FROM t3 GROUP BY f1 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1 * f2, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1 * f2, 1, f1 * f2 + 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1 * f2, f1 - 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1 * f2, f1 - f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1 * f2, f2 - 2 * f1, f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, -1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, 0) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, 0, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, 1, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, 1, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, lead(0, f1 , 0) OVER (PARTITION BY f1 ORDER BY f1) FROM t4 GROUP BY f1 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1 * f2, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1 * f2, 1, f1 * f2 + 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1 * f2, f1 - 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1 * f2, f1 - f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1 * f2, f2 - 2 * f1, f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, -1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, 0) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, 0, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, 1, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, 1, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT generate_series(DISTINCT 1, 1)

-- sqlfmt-corpus-separator --

SELECT int8range(1, 1, '') OVER (PARTITION BY 1 ORDER BY 1);

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(a) FILTER (WHERE a IS NOT NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg(a, a) FILTER (WHERE a IS NOT NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT k FROM not_allowed_tests WHERE avg(k) OVER () > 1;

-- sqlfmt-corpus-separator --

SELECT k, abs(k) FILTER (WHERE k=1) FROM kv

-- sqlfmt-corpus-separator --

SELECT lag(10*right_a+3) OVER (ORDER BY right_a NULLS FIRST), -sum(foo.a), b
FROM foo LEFT JOIN (SELECT a as right_a FROM foo WHERE a<2) ON foo.a = right_a
GROUP BY b, right_a
ORDER BY lag(10*right_a+3) OVER (ORDER BY right_a NULLS FIRST), -sum(foo.a), b;

-- sqlfmt-corpus-separator --

SELECT lag(10*right_a+3) OVER (ORDER BY right_a NULLS FIRST), sum(foo.a), length(b)
FROM foo LEFT JOIN (SELECT a as right_a FROM foo WHERE a<2) ON foo.a = right_a
GROUP BY b, right_a
ORDER BY lag(10*right_a+3) OVER (ORDER BY right_a NULLS FIRST), -sum(foo.a)/10, length(b) DESC NULLS FIRST;

-- sqlfmt-corpus-separator --

SELECT lag(a1.x) OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lead(a1.x) OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT left('hello', -2147483647)

-- sqlfmt-corpus-separator --

SELECT left('hello', -2147483648)

-- sqlfmt-corpus-separator --

SELECT left('hello', 2147483648)

-- sqlfmt-corpus-separator --

SELECT left('str')

-- sqlfmt-corpus-separator --

SELECT left('str', 42, 17)

-- sqlfmt-corpus-separator --

SELECT left('str', NULL)

-- sqlfmt-corpus-separator --

SELECT left('रः॑', -1)

-- sqlfmt-corpus-separator --

SELECT left('रः॑', 0)

-- sqlfmt-corpus-separator --

SELECT left('रः॑', 1)

-- sqlfmt-corpus-separator --

SELECT left('💩abcde', 2)

-- sqlfmt-corpus-separator --

SELECT left('💩abcde'::bytes, 2)

-- sqlfmt-corpus-separator --

SELECT left(42)

-- sqlfmt-corpus-separator --

SELECT left(42, 'str')

-- sqlfmt-corpus-separator --

SELECT left(NULL, 99)

-- sqlfmt-corpus-separator --

SELECT left(e'\u0930\u0903\u0951', -1)

-- sqlfmt-corpus-separator --

SELECT left(vccol, -2) FROM lefttest

-- sqlfmt-corpus-separator --

SELECT left(vccol, 0) FROM lefttest

-- sqlfmt-corpus-separator --

SELECT left(vccol, 2) FROM lefttest

-- sqlfmt-corpus-separator --

SELECT left(vccol, smicol), left(vccol, intcol) FROM lefttest

-- sqlfmt-corpus-separator --

SELECT length(b), sum(a), lag(sum(a)) OVER (ORDER BY length(b))
FROM foo
GROUP BY length(b)
ORDER BY length(b);

-- sqlfmt-corpus-separator --

SELECT length(b), sum(a), lag(sum(a)) OVER (ORDER BY sum(a))
FROM foo
GROUP BY length(b)
ORDER BY sum(a), length(b);

-- sqlfmt-corpus-separator --

SELECT length(s), count(DISTINCT k), count(DISTINCT v), count(DISTINCT (v)) FROM kv GROUP BY length(s)

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY (SELECT * FROM t2)) FROM t2

-- sqlfmt-corpus-separator --

SELECT now(DISTINCT)

-- sqlfmt-corpus-separator --

SELECT o_orderkey,
       COUNT(o_orderkey),
       COUNT(DISTINCT c_custkey)
FROM lineitem
JOIN orders ON (l_orderkey = o_orderkey)
JOIN customer ON (o_custkey = c_custkey)
WHERE l_receiptDATE BETWEEN '1992-06-21' AND '1992-11-22'
  AND l_receiptDATE BETWEEN '1992-07-13' AND '1998-11-27'
  AND l_quantity BETWEEN 1 AND 21 + 9
GROUP BY 1
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY x DESC), dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY x), dense_rank() OVER (ORDER BY x), x FROM t

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY NULL ORDER BY 10000), dense_rank() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY NULL), dense_rank() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY x ORDER BY x), dense_rank() OVER (PARTITION BY x ORDER BY x), x FROM t;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY y ORDER BY x DESC), dense_rank() OVER (PARTITION BY y ORDER BY x DESC), x FROM t;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY y ORDER BY x DESC, z), dense_rank() OVER (PARTITION BY y ORDER BY x DESC, z), x, y, z
FROM t;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY y ORDER BY x), dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t;

-- sqlfmt-corpus-separator --

SELECT rank(x) OVER (ORDER BY x), dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank;

-- sqlfmt-corpus-separator --

SELECT right('abcde💩', 2)

-- sqlfmt-corpus-separator --

SELECT right('abcde💩'::bytes, 2)

-- sqlfmt-corpus-separator --

SELECT right('hello', -2147483647)

-- sqlfmt-corpus-separator --

SELECT right('hello', -2147483648)

-- sqlfmt-corpus-separator --

SELECT right('hello', 2147483648)

-- sqlfmt-corpus-separator --

SELECT right('str')

-- sqlfmt-corpus-separator --

SELECT right('str', 42, 17)

-- sqlfmt-corpus-separator --

SELECT right('str', NULL)

-- sqlfmt-corpus-separator --

SELECT right('रः॑', -1)

-- sqlfmt-corpus-separator --

SELECT right('रः॑', 0)

-- sqlfmt-corpus-separator --

SELECT right('रः॑', 1)

-- sqlfmt-corpus-separator --

SELECT right(42)

-- sqlfmt-corpus-separator --

SELECT right(42, 'str')

-- sqlfmt-corpus-separator --

SELECT right(NULL, 99)

-- sqlfmt-corpus-separator --

SELECT right(e'\u0930\u0903\u0951', -1)

-- sqlfmt-corpus-separator --

SELECT right(vccol, -2) FROM righttest

-- sqlfmt-corpus-separator --

SELECT right(vccol, 0) FROM righttest

-- sqlfmt-corpus-separator --

SELECT right(vccol, 2) FROM righttest

-- sqlfmt-corpus-separator --

SELECT right(vccol, smicol), right(vccol, intcol) FROM righttest

-- sqlfmt-corpus-separator --

SELECT round(DISTINCT 1)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER ()

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (), row_number() OVER ()

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (), row_number() OVER () from t

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN CURRENT ROW AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN CURRENT ROW AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x DESC), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x NULLS FIRST), x FROM t;

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x NULLS LAST), x FROM t;

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 FOLLOWING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN CURRENT ROW AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN CURRENT ROW AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE UNBOUNDED PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 1 FOLLOWING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 1 FOLLOWING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN CURRENT ROW AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT string_agg('foo', CAST ((SELECT NULL) AS BYTEA)) OVER ();

-- sqlfmt-corpus-separator --

SELECT sum(a ORDER BY b) FROM t2

-- sqlfmt-corpus-separator --

SELECT sum(sum(x) OVER ()) FROM t7;

-- sqlfmt-corpus-separator --

SELECT sum(sum(x) OVER ()) OVER () FROM t7;

-- sqlfmt-corpus-separator --

SELECT sum(sum(x)) OVER (ORDER BY y) FROM t7 GROUP BY y;

-- sqlfmt-corpus-separator --

SELECT sum(v) FROM not_allowed_tests GROUP BY k LIMIT sum(v) OVER ();

-- sqlfmt-corpus-separator --

SELECT v, avg(k) FILTER (WHERE k > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, count(*) FILTER (WHERE count(*) > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, count(*) FILTER (WHERE count(1) > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, count(*) FILTER (WHERE k > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, mark, count(*) FILTER (WHERE k > 5), count(*), max(k) FILTER (WHERE k < 8) FROM filter_test GROUP BY v, mark

-- sqlfmt-corpus-separator --

SELECT v, variance(k) FILTER (WHERE k > 5), stddev(k) FILTER (WHERE k > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

select
  x,
  y,
  lag(y) ignore nulls over (order by x) as lag1,
  lag(y,2) ignore nulls over (order by x) as lag2,
  lag(y,3) ignore nulls over (order by x) as lag3,
  lead(y) ignore nulls over (order by x) as lead1,
  lead(y,2) ignore nulls over (order by x) as lead2,
  lead(y,3) ignore nulls over (order by x) as lead3
from t6_more_nulls
order by x;

-- sqlfmt-corpus-separator --

select
  x,
  y,
  lag(y) over (order by x) as lag1,
  lag(y) respect nulls over (order by x) as lag1_resp,
  lag(y) ignore nulls over (order by x) as lag1_ign,
  lead(y) over (order by x) as lead1,
  lead(y) ignore nulls over (order by x) as lead1_ign,
  lag(y, 2) over (order by x) as lag2,
  lag(y, 2) ignore nulls over (order by x) as lag2_ign,
  lead(y, 2) over (order by x) as lead2,
  lead(y, 2) ignore nulls over (order by x) as lead2_ign,
  lag(y, 2, -1) ignore nulls over (order by x) as lag2_ign_def,
  lead(y, 2, -1) ignore nulls over (order by x) as lead2_ign_def,
  lag(y, 2, 16) ignore nulls over (order by x) as lag2_ign_def16,
  lead(y, 2, 16) ignore nulls over (order by x) as lead2_ign_def16,
  lag(y, -1, 100) ignore nulls over (order by x) as lag_neg_offset,
  lead(y, -2, 100) ignore nulls over (order by x) as lead_neg_offset,
  lag(y, y/5+1) ignore nulls over (order by x) as lag_dynamic_offset,
  lead(y, y/5+1) ignore nulls over (order by x) as lead_dynamic_offset,
  lag(y, null) ignore nulls over (order by x) as lag_literal_null_offset
from t6
order by x;

-- sqlfmt-corpus-separator --

select
  x,
  y,
  lag(y) over (partition by x%4 order by x) as lag1,
  lag(y) respect nulls over (partition by x%4 order by x) as lag1_resp,
  lag(y) ignore nulls over (partition by x%4 order by x) as lag1_ign,
  lead(y) over (partition by x%4 order by x) as lead1,
  lead(y) ignore nulls over (partition by x%4 order by x) as lead1_ign,
  lag(y, 2) over (partition by x%4 order by x) as lag2,
  lag(y, 2) ignore nulls over (partition by x%4 order by x) as lag2_ign,
  lead(y, 2) over (partition by x%4 order by x) as lead2,
  lead(y, 2) ignore nulls over (partition by x%4 order by x) as lead2_ign,
  lag(y, 2, -1) ignore nulls over (partition by x%4 order by x) as lag2_ign_def,
  lead(y, 2, -1) ignore nulls over (partition by x%4 order by x) as lead2_ign_def,
  lag(y, 2, 16) ignore nulls over (partition by x%4 order by x) as lag2_ign_def16,
  lead(y, 2, 16) ignore nulls over (partition by x%4 order by x) as lead2_ign_def16,
  lag(y, -1, 100) ignore nulls over (partition by x%4 order by x) as lag_neg_offset,
  lead(y, -2, 100) ignore nulls over (partition by x%4 order by x) as lead_neg_offset,
  lag(y, y/5+1) ignore nulls over (partition by x%4 order by x) as lag_dynamic_offset,
  lead(y, y/5+1) ignore nulls over (partition by x%4 order by x) as lead_dynamic_offset,
  lag(y, null) ignore nulls over (partition by x%4 order by x) as lag_literal_null_offset
from t6
order by x%4, x;

-- sqlfmt-corpus-separator --

select count(distinct column1) from (values (1)) _;

-- sqlfmt-corpus-separator --

select count(distinct column1) from (values (1), (2), (1), (4)) _;

-- sqlfmt-corpus-separator --

select count(distinct ss.ten) from
  (select ten from tenk1 a
   where unique1 IN (select distinct hundred from tenk1 b)) ss;

-- sqlfmt-corpus-separator --

select count(distinct ss.ten) from
  (select ten from tenk1 a
   where unique1 IN (select hundred from tenk1 b)) ss;

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_abbrevs

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_names

-- sqlfmt-corpus-separator --

select distinct 'postgres', current_user() from mz_internal.mz_cluster_replica_metrics;

-- sqlfmt-corpus-separator --

select distinct q1 from
  (select distinct * from int8_tbl i81
   union all
   select distinct * from int8_tbl i82) ss
where -q1 = q2

-- sqlfmt-corpus-separator --

select distinct q1 from
  (select distinct * from int8_tbl i81
   union all
   select distinct * from int8_tbl i82) ss
where q2 = q2
order by 1

-- sqlfmt-corpus-separator --

select first_value(x) ignore nulls over() from t6;

-- sqlfmt-corpus-separator --

select left(strcol, 3) from lefttest

-- sqlfmt-corpus-separator --

select max(1) over (partition by 1 order by 1, 1)
from
  (select
        subq_2."c9" as c0
      from
        (select
              subq_1."c0" as c0,
              subq_1."c2" as c1,
              subq_1."c4" as c2,
              subq_1."c2" as c3,
              subq_1."c1" as c4,
              subq_1."c0" as c5,
              subq_1."c5" as c6,
              subq_1."c0" as c7,
              subq_1."c5" as c8,
              subq_1."c1" as c9,
              subq_1."c2" as c10,
              87 as c11,
              subq_1."c1" as c12
            from
              (select
                    subq_0."c1" as c0,
                    subq_0."c0" as c1,
                    subq_0."c1" as c2,
                    subq_0."c0" as c3,
                    subq_0."c1" as c4,
                    subq_0."c0" as c5
                  from
                    (select
                          ref_0."form_of_use" as c0,
                          ref_0."default_collate_schema" as c1
                        from
                          information_schema.character_sets as ref_0
                        ) as subq_0
                    ) as subq_1
            ) as subq_2
      ) as subq_3
where (case when (((select "collection_timestamp" from mz_internal.mz_storage_usage_by_shard limit 1 offset 4)
          ) < ((select pg_catalog.min("occurred_at") from mz_internal.mz_source_status_history)
          ))
      and ((case when subq_3."c0" is NULL then TIMESTAMPTZ '2023-01-01 01:23:45+06' else TIMESTAMPTZ '2023-01-01 01:23:45+06' end
          ) <> (pg_catalog.now())) then case when (((select pg_catalog.sum("connection_id") from mz_internal.mz_sessions)
            ) - (0::uint8)) >= ((select "worker_id" from mz_introspection.mz_arrangement_sharing_per_worker limit 1 offset 3)
          ) then numrange(0,0) else numrange(0,0) end
       else case when (((select pg_catalog.sum("connection_id") from mz_internal.mz_sessions)
            ) - (0::uint8)) >= ((select "worker_id" from mz_introspection.mz_arrangement_sharing_per_worker limit 1 offset 3)
          ) then numrange(0,0) else numrange(0,0) end
       end
    ) >= (case when (0::uint4) > (pg_catalog.mod(
        CAST((select 1 from mz_internal.mz_subscriptions limit 1 offset 2)
           as uint4),
        CAST((4294967295::uint4) * (2::uint4) as uint4))) then case when (mz_catalog.map_length(
          mz_internal.mz_role_oid_memberships())) = ((select pg_catalog.min("rolconnlimit") from pg_catalog.pg_roles)
          ) then case when (null::uint4) = (null::uint4) then numrange(0,0) else numrange(0,0) end
         else case when (null::uint4) = (null::uint4) then numrange(0,0) else numrange(0,0) end
         end
       else case when (mz_catalog.map_length(
          mz_internal.mz_role_oid_memberships())) = ((select pg_catalog.min("rolconnlimit") from pg_catalog.pg_roles)
          ) then case when (null::uint4) = (null::uint4) then numrange(0,0) else numrange(0,0) end
         else case when (null::uint4) = (null::uint4) then numrange(0,0) else numrange(0,0) end
         end
       end
    );

-- sqlfmt-corpus-separator --

select right(strcol, 3) from righttest

-- sqlfmt-corpus-separator --

select row_number() ignore nulls over();

-- sqlfmt-corpus-separator --

select row_number() ignore nulls respect nulls over();

-- sqlfmt-corpus-separator --

select sum(distinct column1) from (values (1), (2), (1), (4)) _;