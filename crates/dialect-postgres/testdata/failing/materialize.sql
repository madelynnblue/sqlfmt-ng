ALTER INDEX idx_owner_plans OWNER TO plan_owner_other

-- sqlfmt-corpus-separator --

ALTER INDEX jt_ind OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER INDEX mt_ind OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER INDEX mt_ind OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW jmv OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mmv OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mmv OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv_owner_plans OWNER TO plan_owner_other

-- sqlfmt-corpus-separator --

ALTER TABLE t1 ADD COLUMN IF NOT EXISTS a int;

-- sqlfmt-corpus-separator --

ALTER VIEW jv OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER VIEW mv OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER VIEW mv OWNER TO group_no_one

-- sqlfmt-corpus-separator --

BEGIN ISOLATION LEVEL REPEATABLE READ

-- sqlfmt-corpus-separator --

BEGIN ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

BEGIN READ ONLY

-- sqlfmt-corpus-separator --

BEGIN READ WRITE

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION READ WRITE

-- sqlfmt-corpus-separator --

COMMENT ON VIEW c IS 'this_is_a_view';

-- sqlfmt-corpus-separator --

COMMIT AND CHAIN

-- sqlfmt-corpus-separator --

CREATE INDEX ON i (f)

-- sqlfmt-corpus-separator --

CREATE INDEX ON t1(y);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv AS SELECT (mz_tables).* FROM mz_tables;

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON i (f)

-- sqlfmt-corpus-separator --

CREATE VIEW PathQ19 AS
WITH
  -- asymmetrize...
  knows_asymmetric AS (
    SELECT person1id, person2id
      FROM Person_knows_person
     WHERE person1id < person2id
  ),
  -- compute interaction scores (no interactions means we ignore that 'knows' relationship)
  weights(src, dst, w) AS (
    SELECT
        person1id AS src,
        person2id AS dst,
        greatest(round(40 - sqrt(count(*)))::bigint, 1) AS w
    FROM Message m1,
         Message m2,
         knows_asymmetric pp
    WHERE pp.person1id = least(m1.creatorpersonid, m2.creatorpersonid)
      AND pp.person2id = greatest(m1.creatorpersonid, m2.creatorpersonid)
      AND m1.parentmessageid = m2.messageid
      AND m1.creatorpersonid <> m2.creatorpersonid
 GROUP BY src, dst
)
-- resymmetrize
SELECT src, dst, w FROM weights
UNION ALL
SELECT dst, src, w FROM weights;

-- sqlfmt-corpus-separator --

CREATE VIEW v AS SELECT (mz_tables).* FROM mz_tables;

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

PREPARE p AS SELECT repeat($1, $1);

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
SELECT $1 || $1;

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

PREPARE p4 AS
VALUES (0), (1), (2) OFFSET $1

-- sqlfmt-corpus-separator --

PREPARE p5 AS
SELECT $1, $1::bigint;

-- sqlfmt-corpus-separator --

PREPARE p5 AS
VALUES (10), (11), (12) OFFSET $1 - 1

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
    OFFSET outer_foo.a + $1
  )
FROM foo AS outer_foo;

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

ROLLBACK AND CHAIN

-- sqlfmt-corpus-separator --

SELECT
    (information_schema._pg_expandarray(ARRAY[100])).*,
    (information_schema._pg_expandarray(ARRAY[100])).x,
    information_schema._pg_expandarray(ARRAY[100])::text,
    generate_series(1, 2),
    jsonb_array_elements('[3]'),
    jsonb_array_elements('[4,5]')
ORDER BY generate_series

-- sqlfmt-corpus-separator --

SELECT
    a[1][1][1],
	a[1][1][2],
	a[1][2][1],
	a[1][2][2],
	a[2][1][1],
	a[2][1][2],
	a[2][2][1],
	a[2][2][2]
FROM array_t;

-- sqlfmt-corpus-separator --

SELECT
    concat_ws(
        E'\t',
        v,
        array_length(v, 1),
        array_length(v, 2),
        array_length(v, 3),
        array_length(v, 4),
        v[1],
        v[1][1],
        v[1][1][1],
        v[1][1][1][1]
    )
FROM (
    SELECT a::text[] AS v FROM (
        VALUES (null),
        ('       {a}'),
        ('{null}        '),
        ('{      b,b}'),
        ('{{c      },{c},{c}}'),
        ('{{a       }}'),
        ('{{a},        {a}}'),
        ('{{a,b,c},{    a,b,c}}'),
        ('{{{b},{b}},{{b},{b}}      }'),
        ('{{{c},{c},{c}}}         '),
        ('{  {  c  ,  d  }  ,  {  c  ,  d  }  ,  {  c  ,  d  }  }  ')
    ) AS x (a)
) AS x (v);

-- sqlfmt-corpus-separator --

SELECT
    concat_ws(
        E'\t',
        v,
        array_length(v, 1),
        array_length(v, 2),
        array_length(v, 3),
        array_length(v, 4),
        v[1],
        v[1][1],
        v[1][1][1],
        v[1][1][1][1],
        'end'
    )
FROM (
    SELECT a::text[] AS v FROM (
        VALUES (null),
        ('{a}'),
        ('{""}'),
        ('{''}'),
        ('{" "}'),
        ('{" 🌍 "}'),
        ('{\\}'),
        ('{"{",\\}'),
        ('{\"\", \"\\\"\"}'),
        ('{null}'),
        ('{b,b}'),
        ('{{c},{c},{c}}'),
        ('{{a}}'),
        ('{{a},{a}}'),
        ('{{a,b,c},{a,b,c}}'),
        ('{{{b},{b}},{{b},{b}}}'),
        ('{{{c},{c},{c}}}'),
        ('{{"c", d},{"c", d},{"c", d}}'),
        ('{{c, null},{null, d},{"null", null}}'),
        ('{{{{b},{b}}},{{{b},{b}}},{{{b},{b}}}}'),
        ('{{{a}}}'),
        ('{{{a}},{{a}}}'),
        ('{{{a}},{{null}}}'),
        ('{}'),
        ('{{},{}}'),
        ('{{{}},{{}}}'),
        ('{{{null}},{{null}}}'),
        -- Can exceed max dims with empty array which consolidates down
        ('{{{{{{{},{}}}}}}}')
    ) AS x (a)
) AS x (v);

-- sqlfmt-corpus-separator --

SELECT
    concat_ws(' ', a, b, c, COALESCE(((array_fill(5, ARRAY[3, 2, 1], ARRAY[1, 2, 3]))[a][b][c])::text, 'null'))
FROM
    generate_series(1, 3) AS a,
    generate_series(1, 3) AS b,
    generate_series(1, 3) AS c
ORDER BY 1;

-- sqlfmt-corpus-separator --

SELECT
    concat_ws(' ', o, i, COALESCE(((array_fill(5, ARRAY[3, 2]))[o][i])::text, 'null'))
FROM generate_series(1, 4) AS o, generate_series(1, 4) AS i
ORDER BY 1;

-- sqlfmt-corpus-separator --

SELECT
    concat_ws(' ', o, i, COALESCE(((array_fill(5, ARRAY[3, 2], ARRAY[2, 3]))[o][i])::text, 'null'))
FROM generate_series(1, 4) AS o, generate_series(1, 4) AS i
ORDER BY 1;

-- sqlfmt-corpus-separator --

SELECT
    concat_ws(E'\t', o, i, COALESCE(((array_fill(5, ARRAY[2, 2], ARRAY[-2, -1]))[o][i])::text, 'null'))
FROM generate_series(-3, 0) AS o, generate_series(-2, 0) AS i
ORDER BY o, i;

-- sqlfmt-corpus-separator --

SELECT
  '1702129950259'::mz_timestamp::text,
  '1990-01-04 11:00'::mz_timestamp::text,
  greatest('1990-01-04 11:00', mz_now()) > '1990-01-04 11:00'::mz_timestamp,
     least('1990-01-04 11:00', mz_now()) > '1990-01-04 11:00'::mz_timestamp,
  greatest(mz_now(), '1990-01-04 11:00') > '3000-01-04 11:00'::mz_timestamp,
  '1990-01-04 11:00+08'::mz_timestamp < '1990-01-04 11:00+06'::mz_timestamp;

-- sqlfmt-corpus-separator --

SELECT
 real1, real1 + 1, real1 - 1,
 real1 + 0, double1 + 0, numeric1 + 0,
 real1 + real1, double1 + double1, numeric1 + numeric1,
 SQRT(real1), SQRT(double1), SQRT(numeric1),
 SQRT(real1 + real1), SQRT(double1 + double1), SQRT(numeric1 + numeric1),
 tint1 / tint2, tint2 / tint1,
 COALESCE(real1, NULL), COALESCE(double1, NULL), COALESCE(numeric1, NULL),
 GREATEST(real1, 1), GREATEST(double1, 1), GREATEST(numeric1, 1),
 LEAST(real1, 1e38::real), LEAST(double1, 1e38::double), LEAST(numeric1, 1e38::numeric),
 NULLIF(real1, 1e38::real), NULLIF(double1, 1e38::double), NULLIF(numeric1, 1e38::numeric),
 real1 <= 1e38::real, double1 <= 1e38::double, numeric1 <= 1e38::numeric,
 real1 >= 1e38::real, double1 >= 1e38::double, numeric1 >= 1e38::numeric,
 real1 < 1e38::real, double1 < 1e38::double, numeric1 < 1e38::numeric,
 real1 > 1e38::real, double1 > 1e38::double, numeric1 > 1e38::numeric,
 real1 = 1e38::real, double1 = 1e38::double, numeric1 = 1e38::numeric,
 CASE WHEN 1=1 THEN real1 ELSE -1 END, CASE WHEN 1=1 THEN double1 ELSE -1 END, CASE WHEN 1=1 THEN numeric1 ELSE -1 END
FROM t_using_dataflow_rendering
ORDER BY real1;

-- sqlfmt-corpus-separator --

SELECT
 real1, real1 + 1, real1 - 1,
 real1 + 0, double1 + 0, numeric1 + 0,
 real1 + real1, double1 + double1, numeric1 + numeric1,
 SQRT(real1), SQRT(double1), SQRT(numeric1),
 SQRT(real1 + real1), SQRT(double1 + double1), SQRT(numeric1 + numeric1),
 tint1 / tint2, tint2 / tint1,
 COALESCE(real1, NULL), COALESCE(double1, NULL), COALESCE(numeric1, NULL),
 GREATEST(real1, 1), GREATEST(double1, 1), GREATEST(numeric1, 1),
 LEAST(real1, 1e38::real), LEAST(double1, 1e38::double), LEAST(numeric1, 1e38::numeric),
 NULLIF(real1, 1e38::real), NULLIF(double1, 1e38::double), NULLIF(numeric1, 1e38::numeric),
 real1 <= 1e38::real, double1 <= 1e38::double, numeric1 <= 1e38::numeric,
 real1 >= 1e38::real, double1 >= 1e38::double, numeric1 >= 1e38::numeric,
 real1 < 1e38::real, double1 < 1e38::double, numeric1 < 1e38::numeric,
 real1 > 1e38::real, double1 > 1e38::double, numeric1 > 1e38::numeric,
 real1 = 1e38::real, double1 = 1e38::double, numeric1 = 1e38::numeric,
 CASE WHEN 1=1 THEN real1 ELSE -1 END, CASE WHEN 1=1 THEN double1 ELSE -1 END, CASE WHEN 1=1 THEN numeric1 ELSE -1 END
FROM v_using_constant_folding
ORDER BY real1;

-- sqlfmt-corpus-separator --

SELECT $1::int

-- sqlfmt-corpus-separator --

SELECT ('1 2 3'::int2vector)[1]::text;

-- sqlfmt-corpus-separator --

SELECT ('1 2 3'::int2vector::int2[])[1]::text;

-- sqlfmt-corpus-separator --

SELECT ('{1 2 3, 4 5 6}'::int2vector[])[2]::text;

-- sqlfmt-corpus-separator --

SELECT ('{1 2 3, 4 5 6}'::int2vector[])[2][1]::text;

-- sqlfmt-corpus-separator --

SELECT (('[1,100)')@>(t_disallowed_types.c0)) IS TRUE FROM t_disallowed_types;

-- sqlfmt-corpus-separator --

SELECT (('[1,100)')@>(t_disallowed_types.c1)) IS TRUE FROM t_disallowed_types;

-- sqlfmt-corpus-separator --

SELECT (('{1 2 3, 4 5 6}'::int2vector[])[2])[1]::text;

-- sqlfmt-corpus-separator --

SELECT (((SELECT ARRAY[1,2,3])))[3];

-- sqlfmt-corpus-separator --

SELECT ((SELECT ARRAY[1,2,3]))[2];

-- sqlfmt-corpus-separator --

SELECT (ARRAY['a', 'b', 'c'])[2]

-- sqlfmt-corpus-separator --

SELECT (LIST['1']::text)::text

-- sqlfmt-corpus-separator --

SELECT (LIST[1] || '{2}')::text

-- sqlfmt-corpus-separator --

SELECT (LIST[1] || NULL)::text

-- sqlfmt-corpus-separator --

SELECT (LIST[1] || NULL::INT)::text

-- sqlfmt-corpus-separator --

SELECT (LIST[1])::text

-- sqlfmt-corpus-separator --

SELECT (LIST[1][-9223372036854775807::bigint:-9223372036854775807::bigint])::text

-- sqlfmt-corpus-separator --

SELECT (LIST[1][-9223372036854775807::bigint:9223372036854775807::bigint])::text

-- sqlfmt-corpus-separator --

SELECT (LIST[1][9223372036854775807::bigint:-9223372036854775807::bigint])::text

-- sqlfmt-corpus-separator --

SELECT (LIST[1][9223372036854775807::bigint:9223372036854775807::bigint])::text

-- sqlfmt-corpus-separator --

SELECT (LIST[NULL]::text)::text

-- sqlfmt-corpus-separator --

SELECT (LIST[NULL][:])::text

-- sqlfmt-corpus-separator --

SELECT (LIST[null])::text

-- sqlfmt-corpus-separator --

SELECT (NULL || LIST[1])::text

-- sqlfmt-corpus-separator --

SELECT (NULL::INT || LIST[1])::text

-- sqlfmt-corpus-separator --

SELECT (SELECT ARRAY(SELECT 1))[1]

-- sqlfmt-corpus-separator --

SELECT (SELECT ARRAY[1,2,3])[1];

-- sqlfmt-corpus-separator --

SELECT (array_fill(3, ARRAY[2], ARRAY[-3]))[-3];

-- sqlfmt-corpus-separator --

SELECT (array_fill(5, array[3]))[1]

-- sqlfmt-corpus-separator --

SELECT (array_fill(5, array[3], array[2]))[1]

-- sqlfmt-corpus-separator --

SELECT (array_fill(5, array[3], array[2]))[2]

-- sqlfmt-corpus-separator --

SELECT (d::text[])[1] FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT (d::text[])[1][1] FROM array_t2;

-- sqlfmt-corpus-separator --

SELECT (generate_series(1, 1)).*

-- sqlfmt-corpus-separator --

SELECT (generate_series(1, 1)).generate_series

-- sqlfmt-corpus-separator --

SELECT (information_schema._pg_expandarray(array[10])).x, information_schema._pg_expandarray(array[10])

-- sqlfmt-corpus-separator --

SELECT (list['{1}'])::text

-- sqlfmt-corpus-separator --

SELECT (list[list[list['"']]])::text

-- sqlfmt-corpus-separator --

SELECT (list_append(LIST[1], NULL))::text

-- sqlfmt-corpus-separator --

SELECT (list_append(NULL, LIST[1]))::text

-- sqlfmt-corpus-separator --

SELECT (list_cat(LIST[1], NULL))::text

-- sqlfmt-corpus-separator --

SELECT (list_cat(NULL, LIST[1]))::text

-- sqlfmt-corpus-separator --

SELECT (list_prepend(LIST[1], NULL))::text

-- sqlfmt-corpus-separator --

SELECT (list_prepend(NULL, LIST[1]))::text

-- sqlfmt-corpus-separator --

SELECT (list_prepend(NULL::INT, LIST[1]))::text

-- sqlfmt-corpus-separator --

SELECT (mz_tables).* FROM mz_tables LIMIT 0;

-- sqlfmt-corpus-separator --

SELECT (pg_get_keywords()).word FROM t

-- sqlfmt-corpus-separator --

SELECT (t).a FROM t

-- sqlfmt-corpus-separator --

SELECT (t.*).* FROM t ORDER BY 1,2

-- sqlfmt-corpus-separator --

SELECT (x).f1, (x).f2
    FROM (SELECT (ROW(a, b)) AS x FROM t)
ORDER BY 1
   LIMIT 1

-- sqlfmt-corpus-separator --

SELECT *
FROM x, unnest(LIST[5]) WITH ORDINALITY;

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

SELECT * FROM bool1 WHERE a IS FALSE

-- sqlfmt-corpus-separator --

SELECT * FROM bool1 WHERE a IS NOT FALSE

-- sqlfmt-corpus-separator --

SELECT * FROM bool1 WHERE a IS NOT TRUE

-- sqlfmt-corpus-separator --

SELECT * FROM bool1 WHERE a IS TRUE

-- sqlfmt-corpus-separator --

SELECT * FROM bool2 WHERE a IS FALSE

-- sqlfmt-corpus-separator --

SELECT * FROM bool2 WHERE a IS NOT FALSE

-- sqlfmt-corpus-separator --

SELECT * FROM bool2 WHERE a IS NOT TRUE

-- sqlfmt-corpus-separator --

SELECT * FROM bool2 WHERE a IS TRUE

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE (NULL::text NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id)) IS NOT NULL;

-- sqlfmt-corpus-separator --

SELECT *, a, a[0], (((((((((a))))))))), t COLLATE "en_US" FROM t

-- sqlfmt-corpus-separator --

SELECT *, a[1] FROM arr

-- sqlfmt-corpus-separator --

SELECT CASE 1 WHEN 2 THEN 3 END,
       CASE 1 WHEN 2 THEN 3 ELSE a[0] END,
       CASE 1 WHEN 2 THEN 3 ELSE length(t) END,
       CASE 1 WHEN 2 THEN 3 ELSE (t||'a')::INT END,
       CASE 1 WHEN 2 THEN 3 ELSE 4 END
  FROM t

-- sqlfmt-corpus-separator --

SELECT LIST[1] = '{1}'

-- sqlfmt-corpus-separator --

SELECT LIST[1] = '{2}'

-- sqlfmt-corpus-separator --

SELECT LIST[1] = '{2}'::text

-- sqlfmt-corpus-separator --

SELECT LIST[1] = LIST['a']

-- sqlfmt-corpus-separator --

SELECT LIST[1] || 'a'

-- sqlfmt-corpus-separator --

SELECT LIST[1] || '{2}'::text

-- sqlfmt-corpus-separator --

SELECT LIST[1] || LIST['a']

-- sqlfmt-corpus-separator --

SELECT LIST[1][-9223372036854775807::bigint]

-- sqlfmt-corpus-separator --

SELECT LIST[1][9223372036854775807::bigint]

-- sqlfmt-corpus-separator --

SELECT LIST[DATE '2008-02-01']::int list

-- sqlfmt-corpus-separator --

SELECT LIST[NULL] = LIST[1]

-- sqlfmt-corpus-separator --

SELECT LIST[NULL] || LIST[1]

-- sqlfmt-corpus-separator --

SELECT _pg_expandarray.* FROM ROWS FROM (information_schema._pg_expandarray(array[9]))

-- sqlfmt-corpus-separator --

SELECT _pg_expandarray::text FROM ROWS FROM (information_schema._pg_expandarray(array[9]))

-- sqlfmt-corpus-separator --

SELECT array_fill(LIST[1], array[3, 2])

-- sqlfmt-corpus-separator --

SELECT array_fill(LIST[1], array[3, 2], array[2, 3])

-- sqlfmt-corpus-separator --

SELECT c_id, (NULL::text NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id)) IS NOT NULL
FROM c
ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT foo.* IS NOT TRUE FROM (VALUES (1)) AS foo(x)

-- sqlfmt-corpus-separator --

SELECT g FROM ROWS FROM (generate_series(1, 1)) AS g(a)

-- sqlfmt-corpus-separator --

SELECT g.g FROM LATERAL ROWS FROM (generate_series(1,1)) AS g

-- sqlfmt-corpus-separator --

SELECT g.g FROM LATERAL ROWS FROM (generate_series(1,1)) AS g(g)

-- sqlfmt-corpus-separator --

SELECT generate_series FROM ROWS FROM (generate_series(1, 1))

-- sqlfmt-corpus-separator --

SELECT generate_series(1, 2), (information_schema._pg_expandarray(ARRAY[100])).*, jsonb_array_elements('[3]')::text ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT greatest('2010-09-29', '2010-09-28'::TIMESTAMP)

-- sqlfmt-corpus-separator --

SELECT greatest('PT12H2M', 'PT12H2M'::INTERVAL, '1s')

-- sqlfmt-corpus-separator --

SELECT greatest('foo', 'bar', 'foobar')

-- sqlfmt-corpus-separator --

SELECT greatest((3), (0), (-1));

-- sqlfmt-corpus-separator --

SELECT greatest(-1, 1, 2.3, 123456789, 3 + 5, -(-4))

-- sqlfmt-corpus-separator --

SELECT greatest(-1, 1, 2.3, 123456789, 3 + 5, -(-4), abs(-9.0))

-- sqlfmt-corpus-separator --

SELECT greatest(-1.123, 1.21313, 2.3, 123456789.321, 3 + 5.3213, -(-4.3213), abs(-9))

-- sqlfmt-corpus-separator --

SELECT greatest(1)

-- sqlfmt-corpus-separator --

SELECT greatest(1, 1.2)

-- sqlfmt-corpus-separator --

SELECT greatest(1, 2)

-- sqlfmt-corpus-separator --

SELECT greatest(1, NULL, -1)

-- sqlfmt-corpus-separator --

SELECT greatest(1::int, 2::text)

-- sqlfmt-corpus-separator --

SELECT greatest(2, '4')

-- sqlfmt-corpus-separator --

SELECT greatest(2, NULL, NULL, NULL, NULL)

-- sqlfmt-corpus-separator --

SELECT greatest(3, 1)

-- sqlfmt-corpus-separator --

SELECT greatest(4, 5, 7, 1, 2)

-- sqlfmt-corpus-separator --

SELECT greatest(4, NULL, 7, 1, 2)

-- sqlfmt-corpus-separator --

SELECT greatest(NULL)

-- sqlfmt-corpus-separator --

SELECT greatest(NULL, NULL, 7, NULL, 2)

-- sqlfmt-corpus-separator --

SELECT greatest(NULL, NULL, NULL)

-- sqlfmt-corpus-separator --

SELECT greatest(NULL, NULL, NULL, NULL, 2)

-- sqlfmt-corpus-separator --

SELECT greatest(NULL, NULL, NULL, a, -1) FROM foo

-- sqlfmt-corpus-separator --

SELECT greatest(NULL, a, 5, NULL) FROM foo

-- sqlfmt-corpus-separator --

SELECT greatest(row(1), row(1)::custom_composite)

-- sqlfmt-corpus-separator --

SELECT greatest(row(1, 2), 'hello');

-- sqlfmt-corpus-separator --

SELECT greatest(row(1, 2), row(3), row(4, 5));

-- sqlfmt-corpus-separator --

SELECT greatest(row(2, 3), row(1, 4), row(5, 0));

-- sqlfmt-corpus-separator --

SELECT greatest(row(4, 3), row(4, 2), row(4, 4));

-- sqlfmt-corpus-separator --

SELECT greatest(row(row(2, 4), 5), row(row(0, 10), 10), row(row(4, 3), 4));

-- sqlfmt-corpus-separator --

SELECT least('foo', 'bar', 'foobar')

-- sqlfmt-corpus-separator --

SELECT least((3), (0), (-1));

-- sqlfmt-corpus-separator --

SELECT least(1)

-- sqlfmt-corpus-separator --

SELECT least(1, 2)

-- sqlfmt-corpus-separator --

SELECT least(1, NULL, -1)

-- sqlfmt-corpus-separator --

SELECT least(1::int, 2::text)

-- sqlfmt-corpus-separator --

SELECT least(2, '4')

-- sqlfmt-corpus-separator --

SELECT least(3, 1)

-- sqlfmt-corpus-separator --

SELECT least(4, 5, 7, 1, 2)

-- sqlfmt-corpus-separator --

SELECT least(4, NULL, 7, 1, 2)

-- sqlfmt-corpus-separator --

SELECT least(NULL)

-- sqlfmt-corpus-separator --

SELECT least(NULL, NULL, NULL)

-- sqlfmt-corpus-separator --

SELECT least(NULL, NULL, NULL, a, -1) FROM foo

-- sqlfmt-corpus-separator --

SELECT least(NULL, a, 5, NULL) FROM foo

-- sqlfmt-corpus-separator --

SELECT least(row(1), row(1)::custom_composite)

-- sqlfmt-corpus-separator --

SELECT least(row(1, 2), 'hello');

-- sqlfmt-corpus-separator --

SELECT least(row(1, 2), row(3), row(4, 5));

-- sqlfmt-corpus-separator --

SELECT least(row(2, 3), row(1, 4), row(5, 0));

-- sqlfmt-corpus-separator --

SELECT least(row(4, 3), row(4, 2), row(4, 4));

-- sqlfmt-corpus-separator --

SELECT least(row(row(2, 4), 5), row(row(0, 10), 10), row(row(4, 3), 4));

-- sqlfmt-corpus-separator --

SELECT length(parse_ident[1]), length(parse_ident[2])
FROM
  (
    SELECT
      parse_ident(
        '"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx".yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
      )
  );

-- sqlfmt-corpus-separator --

SELECT list_append(1, LIST[1])

-- sqlfmt-corpus-separator --

SELECT list_append(LIST[1], 'a')::text

-- sqlfmt-corpus-separator --

SELECT list_append(LIST[1], LIST[2])

-- sqlfmt-corpus-separator --

SELECT list_cat('a', LIST[1])

-- sqlfmt-corpus-separator --

SELECT list_length(LIST [1])

-- sqlfmt-corpus-separator --

SELECT list_prepend('a', LIST[1])

-- sqlfmt-corpus-separator --

SELECT list_prepend(LIST[1], 1)

-- sqlfmt-corpus-separator --

SELECT list_prepend(LIST[1], LIST[2])

-- sqlfmt-corpus-separator --

SELECT map_build(LIST[1])::TEXT;

-- sqlfmt-corpus-separator --

SELECT mdco.id, from_operator_id, from_operator_address, from_port, to_operator_id, to_operator_address, to_port, COALESCE(sum(sent), 0) AS sent
FROM mz_introspection.mz_dataflow_channel_operators AS mdco
JOIN mz_introspection.mz_dataflow_channels AS mdc ON mdc.id = mdco.id
LEFT JOIN mz_introspection.mz_message_counts AS mmc ON mdco.id = mmc.channel_id
JOIN mz_introspection.mz_compute_exports mce ON mce.dataflow_id = from_operator_address[1]
WHERE mce.export_id = 'does_not_exist'
GROUP BY mdco.id, from_operator_id, from_operator_address, to_operator_id, to_operator_address, from_port, to_port;

-- sqlfmt-corpus-separator --

SELECT nonexistent.* IS NOT TRUE

-- sqlfmt-corpus-separator --

SELECT pg_typeof($1)

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::int2 || LIST[2::int8])

-- sqlfmt-corpus-separator --

SELECT pg_typeof(1::int8 || LIST[2::int2])

-- sqlfmt-corpus-separator --

SELECT pg_typeof(LIST[1::int2] || 2::int8)

-- sqlfmt-corpus-separator --

SELECT pg_typeof(LIST[1::int2] || LIST[2::int8])

-- sqlfmt-corpus-separator --

SELECT pg_typeof(LIST[1::int8] || 2::int2)

-- sqlfmt-corpus-separator --

SELECT pg_typeof(LIST[1::int8] || LIST[2::int2])

-- sqlfmt-corpus-separator --

SELECT pg_typeof(list_append(LIST[1::int2], 1::int8))

-- sqlfmt-corpus-separator --

SELECT pg_typeof(list_append(LIST[1::int8], 1::int2))

-- sqlfmt-corpus-separator --

SELECT pg_typeof(list_cat(LIST[1::int2], LIST[1::int8]))

-- sqlfmt-corpus-separator --

SELECT pg_typeof(list_cat(LIST[1::int8], LIST[1::int2]))

-- sqlfmt-corpus-separator --

SELECT pg_typeof(list_prepend(1::int2, LIST[1::int8]))

-- sqlfmt-corpus-separator --

SELECT pg_typeof(list_prepend(1::int8, LIST[1::int2]))

-- sqlfmt-corpus-separator --

SELECT t.oid, t.typname, t.typsend, t.typreceive, t.typoutput, t.typinput, t.typelem
	FROM pg_type AS t
	WHERE t.oid NOT IN (
	  SELECT (ARRAY[704,11676,10005,3912,11765,59410,11397])[i]
	  FROM generate_series(1, 376) AS i
	)

-- sqlfmt-corpus-separator --

SELECT unnest(LIST[5]) from x;

-- sqlfmt-corpus-separator --

SELECT unnest::text FROM unnest(LIST[NULL])

-- sqlfmt-corpus-separator --

SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

SET TRANSACTION ISOLATION LEVEL serializable

-- sqlfmt-corpus-separator --

SET TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

create index on potato(a);

-- sqlfmt-corpus-separator --

select
    attr.attname as "column.Name",
    col_description(attr.attrelid, attr.attnum) as "column.Comment",
    exists(
        select 1
        from pg_catalog.pg_index indx
        where attr.attrelid = indx.indrelid and attr.attnum = any(indx.indkey) and indx.indisprimary
    ) as "column.IsPrimaryKey",
    not attr.attnotnull as "column.isNullable",
    attr.attgenerated = 's' as "column.isGenerated",
    attr.atthasdef as "column.hasDefault",
    (case when tp.typcategory = 'A' then greatest(1, attr.attndims) --cockroach num dims fix
          else 0
        end) as "dataType.dimensions",
    (case coalesce(elem.typtype, tp.typtype)
         when 'b' then 'base'
         when 'd' then 'base'
         when 'e' then 'enum'
         when 'r' then 'range'
        end) as "dataType.Kind",
    (case when tp.typtype = 'd' then (select pg_type.typname from pg_catalog.pg_type where pg_type.oid = tp.typbasetype)
          when tp.typcategory = 'A' then elem.typname
          else tp.typname
        end) as "dataType.Name",
    false as "dataType.isUnsigned"
from pg_catalog.pg_attribute as attr
     join pg_catalog.pg_class as cls on cls.oid = attr.attrelid
     join pg_catalog.pg_namespace as ns on ns.oid = cls.relnamespace
     join pg_catalog.pg_type as tp on tp.oid = attr.atttypid
	 left join pg_catalog.pg_type elem ON tp.typelem = elem.oid -- only for arrays
where
    ns.nspname = 'public' and
    cls.relname = 'attndims_test' and
    not attr.attisdropped and
    attr.attnum > 0
order by
    attr.attnum;

-- sqlfmt-corpus-separator --

select '1 = 1' is true

-- sqlfmt-corpus-separator --

select 'true' is true

-- sqlfmt-corpus-separator --

select 'true'::text is true

-- sqlfmt-corpus-separator --

select 'true'::text is unknown

-- sqlfmt-corpus-separator --

select ('123'::jsonb)['a']

-- sqlfmt-corpus-separator --

select ('123'::jsonb)[0]

-- sqlfmt-corpus-separator --

select ('123'::jsonb)[NULL]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)['1']

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)['a']

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[-2]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[0]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[1.0]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[1:2]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[1:]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[1]['a']

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[1][0]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[2]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[3]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[:2]

-- sqlfmt-corpus-separator --

select ('{"a": 1, "b": "c", "d": [1, 2, 3]}'::jsonb)['b']

-- sqlfmt-corpus-separator --

select ('{"a": 1, "b": "c", "d": [1, 2, 3]}'::jsonb)['d'];

-- sqlfmt-corpus-separator --

select ('{"a": 1, "b": "c", "d": [1, 2, 3]}'::jsonb)['d']['a'];

-- sqlfmt-corpus-separator --

select ('{"a": 1, "b": "c", "d": [1, 2, 3]}'::jsonb)['d'][1]

-- sqlfmt-corpus-separator --

select ('{"a": 1}'::jsonb)['a':'b']

-- sqlfmt-corpus-separator --

select ('{"a": 1}'::jsonb)['a']

-- sqlfmt-corpus-separator --

select ('{"a": 1}'::jsonb)['not_exist']

-- sqlfmt-corpus-separator --

select ('{"a": 1}'::jsonb)[0]

-- sqlfmt-corpus-separator --

select ('{"a": 1}'::jsonb)[NULL]

-- sqlfmt-corpus-separator --

select ('{"a": ["a1", {"b1": ["aaa", "bbb", "ccc"]}], "b": "bb"}'::jsonb)['a'][1]['b1']

-- sqlfmt-corpus-separator --

select ('{"a": ["a1", {"b1": ["aaa", "bbb", "ccc"]}], "b": "bb"}'::jsonb)['a'][1]['b1'][2]

-- sqlfmt-corpus-separator --

select ('{"a": {"a1": {"a2": "aaa"}}, "b": "bbb", "c": "ccc"}'::jsonb)['a']['a1']

-- sqlfmt-corpus-separator --

select ('{"a": {"a1": {"a2": "aaa"}}, "b": "bbb", "c": "ccc"}'::jsonb)['a']['a1']['a2']

-- sqlfmt-corpus-separator --

select ('{"a": {"a1": {"a2": "aaa"}}, "b": "bbb", "c": "ccc"}'::jsonb)['a']['a1']['a2']['a3']

-- sqlfmt-corpus-separator --

select (r).* from (select row(1, 2.0) as r) ss;

-- sqlfmt-corpus-separator --

select (r).f1 from (select row(1, 2.0) as r) ss;

-- sqlfmt-corpus-separator --

select (r).f3 from (select row(1, 2.0) as r) ss;

-- sqlfmt-corpus-separator --

select (row(1, 2.0)).*;

-- sqlfmt-corpus-separator --

select (row(1, 2.0)).f1;

-- sqlfmt-corpus-separator --

select (row(1, 2.0)).f2;

-- sqlfmt-corpus-separator --

select (row(1, 2.0)).nosuch;

-- sqlfmt-corpus-separator --

select 1 = 1 is false

-- sqlfmt-corpus-separator --

select 1 = 1 is true

-- sqlfmt-corpus-separator --

select 2 = 1 is not unknown

-- sqlfmt-corpus-separator --

select 2 is true

-- sqlfmt-corpus-separator --

select NULL = 1 is unknown

-- sqlfmt-corpus-separator --

select NULL is true

-- sqlfmt-corpus-separator --

select f1, (q).c1, (qq.q).c1.i from quadtable qq;

-- sqlfmt-corpus-separator --

select row(4,2)::testtype8 = (row(row(4,2))::testtype6).inner;

-- sqlfmt-corpus-separator --

select row(4,2)::testtype8 > (row(row(4,1))::testtype6).inner;

-- sqlfmt-corpus-separator --

select row(4,2)::testtype8 > (row(row(4,2))::testtype6).inner;