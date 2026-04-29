EXPLAIN RAW PLAN FOR
    SELECT 'a'::"char" < 'a'::char;

-- sqlfmt-corpus-separator --

EXPLAIN RAW PLAN FOR
    SELECT 'a'::"char" < 'a'::varchar;

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::char;

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::text;

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::varchar;

-- sqlfmt-corpus-separator --

SELECT 'a'::character = 'a'::"char";

-- sqlfmt-corpus-separator --

SELECT 'abc'::char::"char";

-- sqlfmt-corpus-separator --

SELECT 'abc'::text::"char";

-- sqlfmt-corpus-separator --

SELECT 'abc'::varchar::"char";

-- sqlfmt-corpus-separator --

SELECT COALESCE('a'::"char", 'a'::char);

-- sqlfmt-corpus-separator --

SELECT COALESCE('a'::"char", 'a'::varchar);

-- sqlfmt-corpus-separator --

SELECT COALESCE('a'::char, 'a'::"char");

-- sqlfmt-corpus-separator --

SELECT COALESCE('a'::varchar, 'a'::"char");

-- sqlfmt-corpus-separator --

SELECT a, sum(b) AS a FROM t GROUP BY a OPTIONS (AGGREGATE INPUT  GROUP SIZE = 0.1)

-- sqlfmt-corpus-separator --

SELECT a, sum(b) AS a FROM t GROUP BY a OPTIONS (AGGREGATE INPUT GROUP SIZE 100)

-- sqlfmt-corpus-separator --

SELECT a, sum(b) AS a FROM t GROUP BY a OPTIONS (AGGREGATE INPUT GROUP SIZE = 'foo')

-- sqlfmt-corpus-separator --

SELECT bound, (
    WITH MUTUALLY RECURSIVE
        numbers (n int) as (
            VALUES (1)
            UNION ALL
            (
                WITH rebound AS (SELECT * FROM numbers)
                SELECT distinct t1.n + t2.n AS n
                FROM rebound AS t1, rebound AS t2
                WHERE t1.n <= bound AND t2.n <= bound
            )
        )
    SELECT count(*) FROM numbers
)
FROM (
    SELECT generate_series AS bound FROM generate_series(1, 10)
);

-- sqlfmt-corpus-separator --

SELECT pg_typeof('a'::"char"::char);

-- sqlfmt-corpus-separator --

SELECT pg_typeof('a'::"char"::text);

-- sqlfmt-corpus-separator --

SELECT pg_typeof('a'::"char"::varchar);

-- sqlfmt-corpus-separator --

SELECT pg_typeof('abc'::char::"char");

-- sqlfmt-corpus-separator --

SELECT pg_typeof('abc'::text::"char");

-- sqlfmt-corpus-separator --

SELECT pg_typeof('abc'::varchar::"char");

-- sqlfmt-corpus-separator --

SELECT pg_typeof(coalesce('1'::"char", '1'::char));

-- sqlfmt-corpus-separator --

WITH
    lines AS (
        SELECT regexp_split_to_table(input, '\n') AS line
        FROM aoc_1201
    ),
    slices AS (
        SELECT line, index, substring(line, index, width) AS slice
        FROM
            lines,
            generate_series(1, length(line)) AS index,
            generate_series(1, 5) AS width
    ),
    numbers (t, n) AS (
        VALUES ('0', 0), ('1', 1), ('2', 2), ('3', 3), ('4', 4), ('5', 5), ('6', 6), ('7', 7), ('8', 8), ('9', 9),
               ('zero', 0), ('one', 1), ('two', 2), ('three', 3), ('four', 4), ('five', 5), ('six', 6), ('seven', 7), ('eight', 8), ('nine', 9)
    ),
    findings AS (
        SELECT line, index, n AS number
        FROM slices, numbers
        WHERE slices.slice = numbers.t
    ),
    first AS ( SELECT DISTINCT ON (line) line, number AS f FROM findings ORDER BY line, index ),
    last AS ( SELECT DISTINCT ON (line) line, number AS l FROM findings ORDER BY line, index DESC )
SELECT SUM(f * 10 + l)
FROM first, last
WHERE first.line = last.line

-- sqlfmt-corpus-separator --

WITH
    t AS (SELECT true),
    t AS (SELECT false)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2)
        )
SELECT
    jsonb_agg(a ORDER BY a DESC)::text AS a_desc,
    jsonb_agg(a ORDER BY b)::text AS b,
    jsonb_agg(a ORDER BY b, a ASC)::text AS b_a_asc,
    jsonb_agg(a ORDER BY b, a DESC)::text AS b_a_desc
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2)
        )
SELECT
    jsonb_object_agg(b, a ORDER BY a DESC)::text AS a_desc,
    jsonb_object_agg(b, a ORDER BY b)::text AS b,
    jsonb_object_agg(b, a ORDER BY b, a ASC)::text AS b_a_asc,
    jsonb_object_agg(b, a ORDER BY b, a DESC)::text AS b_a_desc
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2)
        )
SELECT
    list_agg(a ORDER BY a DESC)::text AS a_desc,
    list_agg(a ORDER BY b)::text AS b,
    list_agg(a ORDER BY b, a ASC)::text AS b_a_asc,
    list_agg(a ORDER BY b, a DESC)::text AS b_a_desc
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2)
        )
SELECT
    string_agg(a, '-' ORDER BY a DESC)::text AS a_desc,
    string_agg(a, '-' ORDER BY b)::text AS b,
    string_agg(a, '-' ORDER BY b, a ASC)::text AS b_a_asc,
    string_agg(a, '-' ORDER BY b, a DESC)::text AS b_a_desc
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2),
                ('e', NULL)
        )
SELECT
    array_agg(a ORDER BY a DESC)::text AS a_desc,
    array_agg(a ORDER BY b)::text AS b,
    array_agg(a ORDER BY b, a ASC)::text AS b_a_asc,
    array_agg(a ORDER BY b, a DESC)::text AS b_a_desc,
    array_agg(a ORDER BY b NULLS FIRST, a DESC)::text AS b_a_desc_nulls_first
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    w (c) AS (VALUES (NULL), (NULL))
SELECT
    '1971-03-18'::DATE + 300866802885581286
FROM
    w
ORDER BY
    c

-- sqlfmt-corpus-separator --

WITH
  array_agg AS (
    SELECT x%5, array_agg(y) OVER (PARTITION BY x%5) AS l
    FROM t7
  )
SELECT s
FROM
  array_agg,
  LATERAL (
    SELECT sum(ul) AS s
    FROM (SELECT unnest(l) AS ul FROM array_agg) AS sq1
  ) AS sq2;

-- sqlfmt-corpus-separator --

WITH
  array_agg_unnest_grouped_agg AS (
    SELECT x%5 AS k1, avg(u) AS avg1
    FROM (
      SELECT x, unnest(l) AS u
      FROM (
        SELECT x, array_agg(y) OVER (PARTITION BY x%5) AS l
        FROM t7
      ) AS ff1
    ) AS ff2
    GROUP BY x%5
  ),
  grouped_agg AS (
    SELECT x%5 AS k2, avg(y) AS avg2
    FROM t7
    GROUP BY x%5
  )
SELECT k1, avg1 = avg2, avg1, avg2
FROM array_agg_unnest_grouped_agg, grouped_agg
WHERE k1 = k2 AND avg1 IS NOT NULL
ORDER BY k1;

-- sqlfmt-corpus-separator --

WITH
  simple AS (
    SELECT
      x%5 AS x5_simple,
      avg(y) OVER (PARTITION BY x%5) AS avg_simple
    FROM t7
  ),
  complicated AS ( -- array_agg, then do an unnest and global agg in a subquery in a SELECT
    WITH
      array_agg AS (
        SELECT
          x%5 AS x5,
          array_agg(y) OVER (PARTITION BY x%5) AS l
        FROM t7
      )
    SELECT
      x5 AS x5_complicated,
      (
        SELECT avg(uy)
        FROM unnest(l) AS uy
      ) AS avg_complicated
    FROM array_agg
  )
SELECT DISTINCT
  x5_simple,
  avg_simple,
  avg_complicated,
  avg_simple = avg_complicated
FROM simple, complicated
WHERE x5_simple = x5_complicated
ORDER BY x5_simple;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x INT8) as (SELECT '1')
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x NUMERIC(38,2)) as (SELECT sum(a) + 1.23456 FROM y)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x NUMERIC) as (SELECT sum(a) + 1.23456 FROM y)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x NUMERIC) as (SELECT sum(a) FROM y)
SELECT pg_typeof(x) FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x NUMERIC) as (SELECT sum(a) FROM y)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x UINT2) as (SELECT -1::INT8)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x UINT2) as (SELECT 1::INT8)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x list_numeric_scale_2) as (SELECT LIST['1'::TEXT])
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x list_numeric_scale_2) as (SELECT LIST[sum(a) + 1.2345] FROM y)
SELECT x::TEXT FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    c1 (f1 INTEGER, f2 INTEGER, f3 INTEGER) AS (
        SELECT * FROM (VALUES (0, 0, 0))
        UNION ALL (
            SELECT
                a1.f1 + 1 AS f1,
                a1.f2 + 1 AS f2,
                a1.f3 + 1 AS f3
            FROM
                c1 AS a1,
                (
                    SELECT *
                    FROM c1 AS a1
                    LEFT JOIN c1 AS a2 USING (f2)
                    WHERE a1.f1 < 100 AND a2.f2 IS NULL
                ) AS a2
            WHERE a1 . f1 < 100
        )
    )
SELECT * FROM c1;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    evens(n int) AS (
        VALUES (1)
        UNION ALL
        SELECT n+1 FROM odds WHERE n < 100
    ),
    odds (n int) AS (
        VALUES (0)
        UNION ALL
        SELECT n+1 FROM evens
    ),
    both (n int) AS (
        SELECT * FROM evens
        UNION ALL
        SELECT * FROM odds
    )
SELECT sum(n) FROM both;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (
        SELECT 1, 2 UNION
        SELECT * FROM (
            SELECT MIN(c), 2 FROM bar
        )
    ),
    bar (c int) as (SELECT a FROM foo)
SELECT * FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (
        WITH MUTUALLY RECURSIVE
            foo (a int, b int) AS (SELECT 1, 2 UNION SELECT c, 5 FROM bar),
            bar (c int) as (SELECT a FROM foo)
        SELECT a, c FROM foo, bar
    ),
    bar (a int) as (SELECT a FROM foo)
SELECT a FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT (
        SELECT MIN(c) FROM bar
    ), 2 UNION SELECT 5, 5 FROM bar),
    bar (c int) as (SELECT a FROM foo)
SELECT * FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1 UNION SELECT a FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT a FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT 5, 5 FROM bar),
    bar (c int) as (SELECT c FROM foo)
SELECT * FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 5 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT a FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 5 FROM bar),
    bar (c int) as (SELECT c FROM foo)
SELECT * FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT (SELECT COUNT(*) FROM foo) FROM bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT * FROM bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2, 3 UNION SELECT a, 5, 6 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT a FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a text, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT * FROM bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    label (node int, comp int) AS (
        SELECT dst, MIN(comp)
        FROM (
            SELECT dst, dst AS comp FROM edges
            UNION ALL
            SELECT edges.dst, label.comp
            FROM edges, label
            WHERE edges.src = label.node
        )
        GROUP BY dst
    )
SELECT round, COUNT(*) FROM (
    WITH MUTUALLY RECURSIVE
        relabel (node int, comp int, round int) AS (
            SELECT DISTINCT ON(node) node, comp, round
            FROM (
                SELECT node, comp, 0 as round FROM label
                UNION ALL
                SELECT edges.dst, relabel.comp, relabel.round + 1
                FROM edges, relabel
                WHERE edges.src = relabel.node
            )
            ORDER BY node, comp
        )
    SELECT round FROM relabel
)
GROUP BY round;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    numbers (n int) as (
        VALUES (1)
        UNION ALL
        (
            WITH rebound AS (SELECT * FROM numbers)
            SELECT distinct t1.n + t2.n AS n
            FROM rebound AS t1, rebound AS t2
            WHERE t1.n <= 256 AND t2.n <= 256
        )
    )
SELECT count(*) FROM numbers;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    t (n int) AS (
        VALUES (1)
        UNION ALL
        SELECT n+1 FROM t WHERE n < 100
    )
SELECT sum(n) FROM t;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    ties(slower NUMERIC, faster NUMERIC) AS (
        SELECT
            (time + sqrt(time * time - 4 * distance)) / 2 as slower,
            (time - sqrt(time * time - 4 * distance)) / 2 as faster
        FROM input
    ),
    options(choices NUMERIC) AS (
        SELECT 1 + FLOOR(slower)::NUMERIC - CEIL(faster)::NUMERIC FROM ties
    ),
    part12(part12 NUMERIC) AS (
        SELECT pow(10.0, SUM(log(choices))) FROM options
    )
SELECT * FROM part12;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
  c0(key int, a int) AS (
    SELECT * FROM c2
    UNION
    SELECT a, a FROM t
  ),
  c1(key int, a int) AS (
    SELECT key + 1, -a FROM c0
  ),
  c2(key int, a int) AS (
    SELECT c0.key + c1.key, c0.a + c1.a
    FROM c0, c1
    WHERE c0.key = c1.key
  )
SELECT * FROM c2
ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
  cnt (i int) AS (
    (WITH MUTUALLY RECURSIVE
       cnt (i int) AS (
         SELECT 1 AS i
         UNION
         SELECT i+1 FROM cnt WHERE i < 3)
       SELECT i FROM cnt
    )
    UNION
    SELECT i+100 FROM cnt WHERE i < 500)
SELECT i FROM cnt
ORDER BY i;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
  xaxis(x double) AS (VALUES(-2.0) UNION ALL SELECT x+0.05 FROM xaxis WHERE x<1.2),
  yaxis(y double) AS (VALUES(-1.0) UNION ALL SELECT y+0.1 FROM yaxis WHERE y<1.0),
  m(iter int, cx double, cy double, x double, y double) AS (
    SELECT 0, x, y, 0.0, 0.0 FROM xaxis, yaxis
    UNION ALL
    SELECT iter+1, cx, cy, x*x-y*y + cx, 2.0*x*y + cy FROM m
     WHERE (x*x + y*y) < 4.0 AND iter<28
  ),
  m2(iter int, cx double, cy double) AS (
    SELECT max(iter), cx, cy FROM m GROUP BY cx, cy
  ),
  a(t text, cy double) AS (
    SELECT string_agg( substr(' .+*#', 1+least(iter/7,4), 1), '' ORDER BY cx), cy
    FROM m2 GROUP BY cy
  )
SELECT string_agg(rtrim(t), chr(10) ORDER BY cy) FROM a;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
lines(line string) AS (
    SELECT
        regexp_split_to_table(input, '\n') AS line
    FROM
        aoc_1204
),
cards(match string[]) AS (
    SELECT
        regexp_match(line, 'Card +(\d+): (.*)') AS match
    FROM
        lines
),
card_parts(card_id int, parts string[]) AS (
    SELECT
        match[1]::int AS card_id,
        regexp_split_to_array(match[2], ' \| ') AS parts
    FROM
        cards
),
winners(card_id int, val int) AS (
    SELECT
        card_id,
        regexp_split_to_table(trim(parts[1]), '\s+')::int AS val
    FROM
        card_parts
),
ours(card_id int, val int) AS (
    SELECT
        card_id,
        regexp_split_to_table(trim(parts[2]), '\s+')::int AS val
    FROM
        card_parts
),
count_winning_numbers(card_id int, count int) AS (
    SELECT
        ours.card_id,
        count(winners.val)::int AS count
    FROM
        ours LEFT OUTER JOIN winners ON (
            ours.card_id = winners.card_id AND
            ours.val = winners.val
        )
    GROUP BY ours.card_id
),
prizes(card_id int, prize_id int) AS (
    SELECT
        card_id,
        prize_id
    FROM
        count_winning_numbers CROSS JOIN generate_series(card_id + 1, card_id + count) AS prize_id
    UNION
    SELECT
        0 AS card_id,
        ours.card_id AS prize_id
    FROM
        ours
),
multipliers(card_id int, multiplier int) AS (
    SELECT
        prizes.prize_id AS card_id,
        SUM(coalesce(multipliers.multiplier, 1))::int AS multiplier
    FROM
        prizes left outer JOIN multipliers ON (
            prizes.card_id = multipliers.card_id
        )
    GROUP BY prizes.prize_id
)
SELECT
    SUM(multiplier) AS answer
FROM
    multipliers;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (ERROR AT RECURSION LIMIT 3)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (ERROR AT RECURSION LIMIT 3, RETURN AT RECURSION LIMIT 5)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT -3)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT 0)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT 3, ERROR AT RECURSION LIMIT 5)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT 3, RECURSION LIMIT 5)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT 3, RETURN AT RECURSION LIMIT 5)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT aaaaaaa)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 100)
    t (n int) AS (
        VALUES (1)
        UNION ALL
        SELECT n+1 FROM t
    )
SELECT sum(n) FROM t;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 100)
    t0 (n int) AS (
        VALUES (1)
        UNION ALL
        SELECT n+1 FROM t0
    ),
    t1 (n int) AS (
        VALUES (-1)
        UNION ALL
        SELECT n+1 FROM t1
    )
SELECT (SELECT sum(n) FROM t0) - (SELECT sum(n) FROM t1);

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 3)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 6)
  cnt (i int) AS (
    (WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 3)
       cnt (i int) AS (
         SELECT 1 AS i
         UNION
         SELECT i+1 FROM cnt)
       SELECT i FROM cnt
    )
    UNION
    SELECT i+100 FROM cnt)
SELECT i FROM cnt
ORDER BY i;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT = 3)
  c0(f1 int) as (
    (SELECT * FROM t5)
    UNION
    (SELECT t5.f1 + c0.f1
    FROM t5, c0
    WHERE (t5.f1 = 0 OR t5.f1 = 2 OR t5.f1 = 8))
  )
SELECT * FROM c0;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT = 3)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE input(a int) AS (
    SELECT generate_series(1, 40000) AS a
    UNION
    SELECT DISTINCT ON(a) a
    FROM input
    WHERE a > 20000
)
SELECT MAX(a)
FROM input;

-- sqlfmt-corpus-separator --

WITH a AS (SELECT 1) SELECT * FROM a CROSS JOIN a

-- sqlfmt-corpus-separator --

WITH a(x) AS (SELECT 'a') SELECT generate_series(1, 2), * FROM a ORDER BY generate_series

-- sqlfmt-corpus-separator --

WITH c AS (SELECT a + 1 FROM x) SELECT (SELECT * FROM c);

-- sqlfmt-corpus-separator --

WITH const_values(x,y) AS (VALUES (1,2), (3,null), (5,6), (7,8), (9, null), (11, null), (13, 14), (15, 16), (17, 18), (10, -40), (10, -50))
SELECT
  x,
  sum(sum(x) OVER (ORDER BY x)) OVER (ORDER BY x),
  sum(x/3.14) OVER (ORDER BY x),
  max(x/3.14) OVER (ORDER BY x)
FROM (SELECT DISTINCT ON(x) * FROM const_values);

-- sqlfmt-corpus-separator --

WITH count AS (VALUES (9)) SELECT count(*) FROM count;

-- sqlfmt-corpus-separator --

WITH cte1 AS (SELECT 1 AS a, 2 AS a) SELECT * FROM cte1 WHERE cte1.a = 1

-- sqlfmt-corpus-separator --

WITH game_cnt AS (
SELECT split_part(game_id,' ', 2)::int AS game_id,
       COUNT(set_id) AS total_set_cnt,
       COUNT(set_id) FILTER (WHERE (green_cnt <= 13) AND (red_cnt <= 12) AND (blue_cnt <= 14)) AS possible_set_cnt
FROM aoc_1202
GROUP BY game_id
)
SELECT SUM(game_id) FROM game_cnt WHERE total_set_cnt = possible_set_cnt;

-- sqlfmt-corpus-separator --

WITH game_min AS (
SELECT split_part(game_id,' ', 2)::int AS game_id,
       MAX(green_cnt) AS green_min,
       MAX(red_cnt) AS red_min,
       MAX(blue_cnt) AS blue_min
FROM aoc_1202
GROUP BY split_part(game_id,' ', 2)::int
)
SELECT SUM(green_min*red_min*blue_min) FROM game_min;

-- sqlfmt-corpus-separator --

WITH input AS (
    SELECT a, b, c
    FROM single_time_monotonic_t
    WHERE a % 2 = 1
    UNION ALL
    SELECT a, b, c
    FROM single_time_monotonic_t
    WHERE c % 2 = 1
)
SELECT MIN(a), MAX(b)
FROM (
    SELECT b, generate_series(1, a) AS a
    FROM input
    WHERE a + 1 = 6 AND c + 1 = 2
);

-- sqlfmt-corpus-separator --

WITH options AS
(
	SELECT
	  (floor((time - sqrt(time * time - 4 * distance)) / 2) + 1)::int low,
	  (ceil((time + sqrt(time * time - 4 * distance)) / 2) - 1)::int hi
	FROM input
)
SELECT exp(sum(ln(hi - low + 1)))::int
FROM options;

-- sqlfmt-corpus-separator --

WITH outermost(x) AS (
  SELECT 1
  UNION (WITH innermost as (SELECT 2)
         SELECT * FROM innermost
         UNION SELECT 3)
)
SELECT * FROM outermost ORDER BY 1;

-- sqlfmt-corpus-separator --

WITH outermost(x) AS (
  SELECT 1
  UNION (WITH innermost as (SELECT 2)
         SELECT * FROM outermost  -- fail
         UNION SELECT * FROM innermost)
)
SELECT * FROM outermost ORDER BY 1;

-- sqlfmt-corpus-separator --

WITH parsed AS (
  SELECT regexp_split_to_table(input, '\n') AS line FROM aoc_1204
),
numbers AS (
  SELECT split_part(line,':',1) AS card_id,
         replace(split_part(line,':',2),'|','') AS nrs
  FROM parsed
),
arr AS (
  SELECT card_id,
         nrs,
         regexp_split_to_array(ltrim(rtrim(nrs)),'\s') AS nrs_arr
  FROM numbers
),
winning AS (
  SELECT card_id,
         unnest(array_remove(nrs_arr,'')) nr,
         ROW_NUMBER() OVER (PARTITION BY card_id) AS row_num
  FROM arr
  GROUP BY card_id, nr HAVING COUNT(*)>1
  ORDER BY card_id
),
winning_points AS (
  SELECT ROUND(EXP(SUM(LN(CASE WHEN row_num = 1 THEN row_num ELSE 2 END)))) AS points
  FROM winning
  GROUP BY card_id
)
SELECT SUM(points)
FROM winning_points;

-- sqlfmt-corpus-separator --

WITH q AS (SELECT 'foo' AS x)
SELECT x, pg_typeof(x)  FROM q;

-- sqlfmt-corpus-separator --

WITH seeds AS (
    SELECT
        regexp_split_to_table(
            regexp_split_to_array(
                regexp_split_to_array(input, '\n')[1],
                ': '
            )[2],
            ' '
        )::bigint AS seed
    FROM
        input
),
seed_to_soil_lines AS (
    SELECT
        regexp_split_to_array(
            regexp_split_to_table(
                regexp_match(input, 'seed-to-soil map:\n([0-9 \n]*?)\n\n')[1],
                '\n'
            ),
            ' '
        )::bigint[] AS line
    FROM
        input
),
seed_to_soil AS (
    SELECT
        line[1] AS dst_base,
        line[2] AS src_base,
        line[3] AS len
    FROM
        seed_to_soil_lines
),
soil_to_fertilizer_lines AS (
    SELECT
        regexp_split_to_array(
            regexp_split_to_table(
                regexp_match(input, 'soil-to-fertilizer map:\n([0-9 \n]*?)\n\n')[1],
                '\n'
            ),
            ' '
        )::bigint[] AS line
    FROM
        input
),
soil_to_fertilizer AS (
    SELECT
        line[1] AS dst_base,
        line[2] AS src_base,
        line[3] AS len
    FROM
        soil_to_fertilizer_lines
),
fertilizer_to_water_lines AS (
    SELECT
        regexp_split_to_array(
            regexp_split_to_table(
                regexp_match(input, 'fertilizer-to-water map:\n([0-9 \n]*?)\n\n')[1],
                '\n'
            ),
            ' '
        )::bigint[] AS line
    FROM
        input
),
fertilizer_to_water AS (
    SELECT
        line[1] AS dst_base,
        line[2] AS src_base,
        line[3] AS len
    FROM
        fertilizer_to_water_lines
),
water_to_light_lines AS (
    SELECT
        regexp_split_to_array(
            regexp_split_to_table(
                regexp_match(input, 'water-to-light map:\n([0-9 \n]*?)\n\n')[1],
                '\n'
            ),
            ' '
        )::bigint[] AS line
    FROM
        input
),
water_to_light AS (
    SELECT
        line[1] AS dst_base,
        line[2] AS src_base,
        line[3] AS len
    FROM
        water_to_light_lines
),
light_to_temperature_lines AS (
    SELECT
        regexp_split_to_array(
            regexp_split_to_table(
                regexp_match(input, 'light-to-temperature map:\n([0-9 \n]*?)\n\n')[1],
                '\n'
            ),
            ' '
        )::bigint[] AS line
    FROM
        input
),
light_to_temperature AS (
    SELECT
        line[1] AS dst_base,
        line[2] AS src_base,
        line[3] AS len
    FROM
        light_to_temperature_lines
),
temperature_to_humidity_lines AS (
    SELECT
        regexp_split_to_array(
            regexp_split_to_table(
                regexp_match(input, 'temperature-to-humidity map:\n([0-9 \n]*?)\n\n')[1],
                '\n'
            ),
            ' '
        )::bigint[] AS line
    FROM
        input
),
temperature_to_humidity AS (
    SELECT
        line[1] AS dst_base,
        line[2] AS src_base,
        line[3] AS len
    FROM
        temperature_to_humidity_lines
),
humidity_to_location_lines AS (
    SELECT
        regexp_split_to_array(
            regexp_split_to_table(
                regexp_match(input, 'humidity-to-location map:\n([0-9 \n]*)')[1],
                '\n'
            ),
            ' '
        )::bigint[] AS line
    FROM
        input
),
humidity_to_location AS (
    SELECT
        line[1] AS dst_base,
        line[2] AS src_base,
        line[3] AS len
    FROM
        humidity_to_location_lines
),
soil AS (
    SELECT
        seed,
        coalesce(
            MAX(
                CASE
                    WHEN seed >= src_base AND seed < src_base + len
                    THEN dst_base + (seed - src_base)
                    ELSE null
                END
            ),
            seed
        ) AS soil
    FROM
        seeds, seed_to_soil
    GROUP BY seed
),
fertilizer AS (
    SELECT
        soil,
        coalesce(
            MAX(
                CASE
                    WHEN soil >= src_base AND soil < src_base + len
                    THEN dst_base + (soil - src_base)
                    ELSE null
                END
            ),
            soil
        ) AS fertilizer
    FROM
        soil, soil_to_fertilizer
    GROUP BY soil
),
water AS (
    SELECT
        fertilizer,
        coalesce(
            MAX(
                CASE
                    when fertilizer >= src_base AND fertilizer < src_base + len
                    then dst_base + (fertilizer - src_base)
                    else null
                END
            ),
            fertilizer
        ) AS water
    FROM
        fertilizer, fertilizer_to_water
    GROUP BY fertilizer
),
light AS (
    SELECT
        water,
        coalesce(
            MAX(
                CASE
                    WHEN water >= src_base AND water < src_base + len
                    THEN dst_base + (water - src_base)
                    ELSE null
                END
            ),
            water
        ) AS light
    FROM
        water, water_to_light
    GROUP BY water
),
temperature AS (
    SELECT
        light,
        coalesce(
            MAX(
                CASE
                    WHEN light >= src_base AND light < src_base + len
                    THEN dst_base + (light - src_base)
                    ELSE null
                END
            ),
            light
        ) AS temperature
    FROM
        light, light_to_temperature
    GROUP BY light
),
humidity AS (
    SELECT
        temperature,
        coalesce(
            MAX(
                CASE
                    WHEN temperature >= src_base AND temperature < src_base + len
                    THEN dst_base + (temperature - src_base)
                    ELSE null
                END
            ),
            temperature
        ) AS humidity
    FROM
        temperature, temperature_to_humidity
    GROUP BY temperature
),
location AS (
    SELECT
        humidity,
        coalesce(
            MAX(
                CASE
                    WHEN humidity >= src_base AND humidity < src_base + len
                    THEN dst_base + (humidity - src_base)
                    ELSE null
                END
            ),
            humidity
        ) AS location
    FROM
        humidity, humidity_to_location
    GROUP BY humidity
)
SELECT
    MIN(location) AS answer
FROM
    location;

-- sqlfmt-corpus-separator --

WITH squares_y AS (
    SELECT y FROM squares
  )
SELECT * FROM squares_y WHERE y IN (
  SELECT y * y FROM squares_y
)

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1 * f2, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1 * f2, 1, f1 * f2 + 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1 * f2, f1 - 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1 * f2, f1 - f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1 * f2, f2 - 2 * f1, f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, -1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, 0) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, 0, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, 1, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, 1, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1 * f2, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1 * f2, 1, f1 * f2 + 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1 * f2, f1 - 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1 * f2, f1 - f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1 * f2, f2 - 2 * f1, f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, -1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, 0) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, 0, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, 1, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, 1, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT
  sum(f1)   OVER (ORDER BY f2) s,
  max(f1)   OVER (ORDER BY f2) m,
  count(f1) OVER (ORDER BY f3) c
FROM t
ORDER BY s, m, c;

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551614 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551614 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551615 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551614 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551615 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551614 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551615 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f3) OVER (PARTITION BY f2 ORDER BY f1)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + coalesce(nullif(f3, 'NaN'), -10)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, -2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, 10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, -10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 1, f3) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, NULL, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, f1 - 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, nullif(f1, 1)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(nullif(f1, 4)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + coalesce(nullif(f3, 'NaN'), -10)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, -2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, 10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, -10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 1, f3) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, NULL, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, f1 - 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, nullif(f1, 1)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(nullif(f1, 4)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1::uint8, 'a', 1.0))
SELECT lag(f1, 1::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1::uint8, 'a', 1.0))
SELECT lag(f1, 1::int, 0::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1::uint8, 'a', 1.0))
SELECT pg_typeof(lag(f1, 1::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1))
FROM t

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1::uint8, 'a', 1.0))
SELECT pg_typeof(lag(f1, 1::int, 0::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1))
FROM t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'))
SELECT dense_rank() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'))
SELECT row_number() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'))
SELECT row_number() OVER (), row_number() OVER () from t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT lag(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT lag(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT lead(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT lead(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT lag(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT lag(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT lead(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT lead(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT * FROM t
WHERE row_number() over () > 1;

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT * FROM t AS v JOIN t ON row_number() over () > 1;

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT DISTINCT ON (row_number() OVER ()) *
FROM t
ORDER BY row_number() OVER ()

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT lag(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT lag(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT lead(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT lead(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT row_number() FROM t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x DESC), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), (NULL), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x NULLS FIRST), x FROM t;

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), (NULL), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x NULLS LAST), x FROM t;

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT dense_rank() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT dense_rank() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lag(a1.x) OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lag(x) OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lag(x) OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lead(a1.x) OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lead(x) OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lead(x) OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT row_number() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT row_number() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT row_number() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT lag(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT lead(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT row_number() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98), ('a', 98), ('a', 99))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98), ('a', 98), ('a', 99))
SELECT lag(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98), ('a', 98), ('a', 99))
SELECT lead(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x, y, z) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC, z), x, y, z
FROM t
ORDER BY y, x DESC, z

-- sqlfmt-corpus-separator --

WITH t (x, y, z) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY z DESC), x, y, z
FROM t
ORDER BY y, z DESC, x

-- sqlfmt-corpus-separator --

WITH t (x, y, z) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0))
SELECT rank() OVER (PARTITION BY y ORDER BY z DESC), dense_rank() OVER (PARTITION BY y ORDER BY z DESC), x, y, z
FROM t;

-- sqlfmt-corpus-separator --

WITH t AS (SELECT * FROM y WHERE a < 3)
  SELECT * FROM t NATURAL JOIN x

-- sqlfmt-corpus-separator --

WITH t AS (SELECT * FROM y WHERE a < 3)
  SELECT * FROM x NATURAL JOIN t

-- sqlfmt-corpus-separator --

WITH t AS (SELECT a FROM x) SELECT a, x.t FROM t

-- sqlfmt-corpus-separator --

WITH t AS (SELECT a FROM y WHERE a < 3)
  SELECT * FROM x NATURAL JOIN t

-- sqlfmt-corpus-separator --

WITH t(a, b) AS (SELECT true a, false b)
  SELECT a, b FROM t

-- sqlfmt-corpus-separator --

WITH t(b) AS (SELECT a FROM x) SELECT b, t.b FROM t

-- sqlfmt-corpus-separator --

WITH t(b, a) AS (SELECT true a, false b)
  SELECT a, b FROM t

-- sqlfmt-corpus-separator --

WITH t(b, c) AS (SELECT a FROM x) SELECT b, t.b FROM t

-- sqlfmt-corpus-separator --

WITH t(x) AS (SELECT * FROM y WHERE a < 3)
  SELECT * FROM x WHERE a IN (
    SELECT a FROM t WHERE x.a = t.x
  )

-- sqlfmt-corpus-separator --

WITH t(x) AS (SELECT a FROM x)
  SELECT * FROM y WHERE a IN (SELECT x FROM t)

-- sqlfmt-corpus-separator --

WITH t(x) AS (WITH t(x) AS (SELECT 1) SELECT x * 10 FROM t) SELECT x + 2 FROM t

-- sqlfmt-corpus-separator --

WITH t3_with_key AS (select f1 as key, sum(f2) as nokey from t3 group by f1)
SELECT a1.* FROM t3 AS a1 LEFT JOIN t3_with_key AS a2 ON (a1.f1 = a2.key or (a1.f1 is null and a2.key is null));

-- sqlfmt-corpus-separator --

WITH t3_with_key AS (select f1 as key, sum(f2) as nokey from t3 group by f1)
SELECT a1.* FROM t3 AS a1 LEFT JOIN t3_with_key AS a2 ON (a1.f1 = a2.key)

-- sqlfmt-corpus-separator --

WITH t3_with_key AS (select f1 as key, sum(f2) as nokey from t3 group by f1)
SELECT a1.* FROM t3_with_key AS a1 LEFT JOIN t3_with_key AS a2 ON (a1.key = a2.key)

-- sqlfmt-corpus-separator --

WITH v (a) AS (
    SELECT '{a=>1}'::map[text=>int]
),
unnest (key, value) AS (
    SELECT (a).key, (a).value FROM (
        SELECT unnest(a) FROM v
    ) AS u (a)
),
manipulate (key, value) AS (
    SELECT upper(key), value * 100 FROM unnest
)
SELECT map_agg(key, value)::TEXT FROM manipulate;

-- sqlfmt-corpus-separator --

with
  v1 as (
    WITH
            creates AS
            (
                SELECT
                    details ->> 'logical_size' AS size,
                    details ->> 'replica_id' AS replica_id,
                    occurred_at
                FROM mz_catalog.mz_audit_events
                WHERE
                    object_type = 'cluster-replica' AND event_type = 'create'
            )
        SELECT
            mz_unsafe.mz_error_if_null(
                    mz_cluster_replica_sizes.credits_per_hour, 'Replica of unknown size'
                )
                AS credits_per_hour
        FROM
            creates
                LEFT JOIN
                    mz_catalog.mz_cluster_replica_sizes
                    ON mz_cluster_replica_sizes.size = creates.size
  )
select * from v1
WHERE credits_per_hour > credits_per_hour;

-- sqlfmt-corpus-separator --

with mutually recursive
    -- Parse the input up
    lines(line TEXT) as (select regexp_split_to_table(input, '\n') as line from input),
    games(game TEXT, report TEXT) as (select regexp_split_to_array(line, ':')[1], regexp_split_to_array(line, ':')[2] from lines),
    round(game TEXT, visible TEXT) as (select game, regexp_split_to_table(report, ';') from games),
    bacon(game TEXT, color TEXT) as (select game, regexp_split_to_table(visible, ',') from round),
    parsed(game INT, color TEXT, number INT) as (
        select
            substring(game, 5)::INT as game,
            regexp_split_to_array(color, ' ')[3] as color,
            regexp_split_to_array(color, ' ')[2]::INT as number
        from bacon
    ),
    -- PART 1
    limits(color TEXT, number INT) as (SELECT * FROM (VALUES ('red', 12), ('green', 13), ('blue', 14))),
    bad_news(game INT) as (
        select game
        from parsed, limits
        where parsed.color = limits.color
          AND parsed.number > limits.number
    ),
    plausible(game INT) as (select distinct parsed.game from parsed left join bad_news on(parsed.game = bad_news.game) where bad_news.game IS NULL),
    part1(part1 BIGINT) as (select SUM(game) from plausible),
    -- PART 2
    maximum(game INT, color TEXT, number INT) as (select game, color, max(number) from parsed GROUP BY game, color),
    red(game INT) as (select game from maximum, generate_series(1, number) where color = 'red'),
    blue(game INT) as (select game from maximum, generate_series(1, number) where color = 'blue'),
    green(game INT) as (select game from maximum, generate_series(1, number) where color = 'green'),
    power(game INT, product BIGINT) as (SELECT red.game, count(*) from red, blue, green where red.game = blue.game and blue.game = green.game GROUP BY red.game),
    part2(part2 BIGINT) as (select sum(product)::BIGINT from power)
select * from part1, part2;

-- sqlfmt-corpus-separator --

with mutually recursive
    a(x int) as (select * from a)
select * from a;

-- sqlfmt-corpus-separator --

with q as (select max(f1) from int4_tbl group by f1 order by f1)
  select q from q;

-- sqlfmt-corpus-separator --

with table_privileges as (
 select
   NULL as role,
   t.schemaname as schema,
   t.objectname as table,
   pg_catalog.has_table_privilege(current_user, '"' || t.schemaname || '"' || '.' || '"' || t.objectname || '"',  'UPDATE') as update,
   pg_catalog.has_table_privilege(current_user, '"' || t.schemaname || '"' || '.' || '"' || t.objectname || '"',  'SELECT') as select,
   pg_catalog.has_table_privilege(current_user, '"' || t.schemaname || '"' || '.' || '"' || t.objectname || '"',  'INSERT') as insert,
   pg_catalog.has_table_privilege(current_user, '"' || t.schemaname || '"' || '.' || '"' || t.objectname || '"',  'DELETE') as delete
 from (
   select schemaname, tablename as objectname from pg_catalog.pg_tables
   union
   select schemaname, viewname as objectname from pg_catalog.pg_views
   union
   select schemaname, matviewname as objectname from pg_catalog.pg_matviews
 ) t
 where t.schemaname !~ '^pg_'
   and t.schemaname <> 'information_schema'
   and pg_catalog.has_schema_privilege(current_user, t.schemaname, 'USAGE')
)
select t.*
from table_privileges t

-- sqlfmt-corpus-separator --

with v as (select mz_now() < '3000-01-01') select * from v;