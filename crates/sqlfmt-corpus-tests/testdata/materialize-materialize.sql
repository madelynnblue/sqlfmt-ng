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

SELECT DISTINCT ON (b) a FROM t GROUP BY a ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a, sum(b) AS a FROM t GROUP BY a OPTIONS (AGGREGATE INPUT GROUP SIZE 100)

-- sqlfmt-corpus-separator --

SELECT a, sum(b) AS a FROM t GROUP BY a OPTIONS (AGGREGATE INPUT GROUP SIZE = 'foo')

-- sqlfmt-corpus-separator --

SELECT a, sum(b) AS a FROM t GROUP BY a OPTIONS (AGGREGATE INPUT  GROUP SIZE = 0.1)

-- sqlfmt-corpus-separator --

SELECT v, count(*) FILTER (WHERE k > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, mark, count(*) FILTER (WHERE k > 5), count(*), max(k) FILTER (WHERE k < 8) FROM filter_test GROUP BY v, mark

-- sqlfmt-corpus-separator --

SELECT abs(1) FILTER (WHERE false)

-- sqlfmt-corpus-separator --

SELECT v, count(*) FILTER (WHERE count(1) > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, avg(k) FILTER (WHERE k > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, variance(k) FILTER (WHERE k > 5), stddev(k) FILTER (WHERE k > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

select count(distinct column1) from (values (1)) _;

-- sqlfmt-corpus-separator --

select count(distinct column1) from (values (1), (2), (1), (4)) _;

-- sqlfmt-corpus-separator --

select sum(distinct column1) from (values (1), (2), (1), (4)) _;

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

SELECT a.*, ROW_NUMBER() over () FROM (SELECT * FROM a ORDER BY x) a

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() over () FROM (SELECT * FROM a ORDER BY x limit 1) a

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() OVER() FROM (SELECT * FROM (SELECT 'a' as x UNION ALL SELECT 'b' as x) ORDER BY x) a

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() OVER() FROM (SELECT * FROM (SELECT 'a' as x UNION ALL SELECT 'b' as x) ORDER BY x limit 1) a

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() OVER() from (SELECT TRUE::text as x FROM(SELECT AVG(0) FROM qs)) a

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b), string_agg(c, ',' ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b ORDER BY b ASC), array_agg(b ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b ASC), array_agg(b ORDER BY b DESC), bool_or(b IS NOT NULL) FROM t;

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b ORDER BY b) FROM t GROUP BY a HAVING array_agg(b ORDER BY b) = array_agg(b ORDER BY b DESC);

-- sqlfmt-corpus-separator --

SELECT a, dense_rank() OVER (ORDER BY a), array_agg(b) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT array_agg(a) FILTER (WHERE a IS NOT NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT array_agg(a) FILTER (WHERE a IS NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT array_agg((a, b) ORDER BY a DESC)::text, array_agg(a ORDER BY a DESC), array_agg(b ORDER BY b DESC) FROM t2;

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF now()

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF current_database()

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF current_database()::mz_timestamp

-- sqlfmt-corpus-separator --

SELECT current_database() AS OF 1;

-- sqlfmt-corpus-separator --

SELECT current_database() AS OF AT LEAST 1;

-- sqlfmt-corpus-separator --

SELECT mz_now() AS OF 1;

-- sqlfmt-corpus-separator --

SELECT now() AS OF 1;

-- sqlfmt-corpus-separator --

SELECT * FROM data ORDER BY a, b AS OF AT LEAST 1

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF 192741824E4::numeric;

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF -1;

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF -1::numeric;

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF 1E38;

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF 1.2;

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF mz_now();

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF a;

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF 'xxx';

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF LIST[7,8,9];

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF 7/0;

-- sqlfmt-corpus-separator --

SELECT * FROM t AS OF 1

-- sqlfmt-corpus-separator --

SELECT count(*) = 2 FROM t AS OF AT LEAST 1

-- sqlfmt-corpus-separator --

SELECT 1 AS OF NULL::timestamp;

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF NULL::numeric;

-- sqlfmt-corpus-separator --

SELECT * FROM events AS OF 0

-- sqlfmt-corpus-separator --

SELECT * FROM events AS OF 100

-- sqlfmt-corpus-separator --

SELECT * FROM events AS OF 101

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

SELECT DISTINCT object FROM objects WHERE schema IN ('mz_catalog') ORDER BY object

-- sqlfmt-corpus-separator --

SELECT DISTINCT object FROM objects WHERE schema IN ('mz_internal') ORDER BY object

-- sqlfmt-corpus-separator --

SELECT DISTINCT object FROM objects WHERE schema IN ('mz_introspection') ORDER BY object

-- sqlfmt-corpus-separator --

SELECT 'a'::character = 'a'::"char";

-- sqlfmt-corpus-separator --

SELECT pg_typeof(coalesce('1'::"char", '1'::char));

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::char;

-- sqlfmt-corpus-separator --

SELECT pg_typeof('a'::"char"::char);

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::varchar;

-- sqlfmt-corpus-separator --

SELECT pg_typeof('a'::"char"::varchar);

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::text;

-- sqlfmt-corpus-separator --

SELECT pg_typeof('a'::"char"::text);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char::"char";

-- sqlfmt-corpus-separator --

SELECT pg_typeof('abc'::char::"char");

-- sqlfmt-corpus-separator --

SELECT 'abc'::varchar::"char";

-- sqlfmt-corpus-separator --

SELECT pg_typeof('abc'::varchar::"char");

-- sqlfmt-corpus-separator --

SELECT 'abc'::text::"char";

-- sqlfmt-corpus-separator --

SELECT pg_typeof('abc'::text::"char");

-- sqlfmt-corpus-separator --

SELECT COALESCE('a'::char, 'a'::"char");

-- sqlfmt-corpus-separator --

SELECT COALESCE('a'::varchar, 'a'::"char");

-- sqlfmt-corpus-separator --

SELECT COALESCE('a'::"char", 'a'::char);

-- sqlfmt-corpus-separator --

SELECT COALESCE('a'::"char", 'a'::varchar);

-- sqlfmt-corpus-separator --

SELECT * FROM kv GROUP BY v, count(DISTINCT w)

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT w) FROM kv GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT sum(v) FROM kv GROUP BY k LIMIT 1 OFFSET sum(v)

-- sqlfmt-corpus-separator --

SELECT
  length(s),
  count(DISTINCT s),
  count(DISTINCT length(s))
FROM kv GROUP BY length(s) HAVING count(DISTINCT s) > 1

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT k), count(DISTINCT v), count(DISTINCT (v)) FROM kv

-- sqlfmt-corpus-separator --

SELECT length(s), count(DISTINCT k), count(DISTINCT v), count(DISTINCT (v)) FROM kv GROUP BY length(s)

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT a.*) FROM kv a, kv b

-- sqlfmt-corpus-separator --

SELECT k, abs(k) FILTER (WHERE k=1) FROM kv

-- sqlfmt-corpus-separator --

SELECT v, count(*) FILTER (WHERE count(*) > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(DISTINCT employee, ',')
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, ',')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTEA, b',')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, '')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTEA, b'')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTEA, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::TEXT, employee)
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

SELECT company_id, string_agg(NULL::BYTEA, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL, NULL::TEXT)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL, NULL::BYTEA)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, lower(employee))
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(lower(employee), employee)
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, employee, employee)
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee)
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT string_agg('foo', CAST ((SELECT NULL) AS BYTEA)) OVER ();

-- sqlfmt-corpus-separator --

SELECT left('💩abcde'::bytes, 2)

-- sqlfmt-corpus-separator --

SELECT right('abcde💩'::bytes, 2)

-- sqlfmt-corpus-separator --

SELECT left('💩abcde', 2)

-- sqlfmt-corpus-separator --

SELECT right('abcde💩', 2)

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT (v)) FROM kv

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

SELECT DISTINCT ON (x, y, z) x, y, z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x, z) x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (z, y, x) z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (b, c, a) a, c, b FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (b, c, a) a FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (c, a, b) b FROM abc ORDER BY b

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, y) y, x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x) x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, y) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a, c) a, b FROM abc ORDER BY a, c, b

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (c, a) b, c, a FROM abc ORDER BY c, a, b DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (c) a FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (b) b FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a) a, b, c FROM abc ORDER BY a, b, c

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a) a, c FROM abc ORDER BY a, c DESC, b

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) x, y, z FROM xyz ORDER BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y) x, y, z FROM xyz ORDER BY x, y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, z) x, y, z FROM xyz ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) x FROM xyz ORDER BY x DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, z) y, z, x FROM xyz WHERE (x,y,z) != (4, 1, 6) ORDER BY z

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) y, z, x FROM xyz ORDER BY x ASC, z DESC, y DESC

-- sqlfmt-corpus-separator --

SELECT (SELECT DISTINCT ON (a) a FROM abc ORDER BY a, b||'foo') || 'bar';

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(max(x)) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(max(x), z) min(y) FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (max(x)) min(y) FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (min(x)) max(y) FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(min(a), max(b), min(c)) max(c) FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) min(x) FROM xyz GROUP BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(y) min(x) FROM xyz GROUP BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(min(x)) min(x) FROM xyz GROUP BY y HAVING min(x) = 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz ORDER BY row_number() OVER(ORDER BY (pk1, pk2)) DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (2) x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (1) x FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (1,2,3) x, y, z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(x) x AS y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(((x)), (x, y)) x, y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(pk1, pk2, x, y) x, y, z FROM xyz ORDER BY x, y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, y, z) pk1 FROM (SELECT * FROM xyz WHERE x >= 2) ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) x, y FROM xyz WHERE x = 1 ORDER BY x, y

-- sqlfmt-corpus-separator --

SELECT generate_series FROM generate_series(1, 100) ORDER BY generate_series OFFSET 3 ROWS FETCH NEXT ROW ONLY;

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY k OFFSET 5

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY v LIMIT (1+4) OFFSET 1

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY v DESC LIMIT (1+4) OFFSET 1

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY k LIMIT length(pg_typeof(123)) OFFSET length(pg_typeof(123))-2

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY k OFFSET (SELECT count(*)-3 FROM t)

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY k LIMIT (SELECT count(*)-3 FROM t) OFFSET (SELECT count(*)-5 FROM t)

-- sqlfmt-corpus-separator --

SELECT DISTINCT b1.title FROM books as b1 JOIN books2 as b2 ON b1.title = b2.title WHERE b1.shelf <> b2.shelf

-- sqlfmt-corpus-separator --

SELECT DISTINCT authors.name FROM books AS b1, books2 as b2, authors WHERE b1.title = b2.title AND authors.book = b1.title AND b1.shelf <> b2.shelf

-- sqlfmt-corpus-separator --

SELECT DISTINCT c, b FROM t ORDER BY b DESC LIMIT 2

-- sqlfmt-corpus-separator --

SELECT a FROM abc ORDER BY a DESC OFFSET 1

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL AS t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", t1.a, t2.e FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e) WHERE t1.a = t2.d

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", ii, tt, kk FROM (J1_TBL CROSS JOIN J2_TBL) AS tx (ii, jj, tt, ii2, kk)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", tx.ii, tx.jj, tx.kk FROM (J1_TBL t1 (a, b, c) CROSS JOIN J2_TBL t2 (d, e)) AS tx (ii, jj, tt, ii2, kk)

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw OFFSET 1 + y

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw OFFSET 1.5

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw OFFSET -100

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw OFFSET 9223372036854775808

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY x OFFSET 1 + 0.0

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY x LIMIT 1 OFFSET 1

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY y OFFSET 1

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY y OFFSET 1 LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT (random() * 0.0)::int OFFSET (random() * 0.0)::int

-- sqlfmt-corpus-separator --

SELECT * FROM (SELECT * FROM xyzw LIMIT 5) OFFSET 5

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2)

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2, foo3)

-- sqlfmt-corpus-separator --

SELECT foo1, foo.foo1, b, foo.c FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2) WHERE foo.foo1 = 1

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2) WHERE foo.foo2 = 2

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2) WHERE foo.c = 6

-- sqlfmt-corpus-separator --

SELECT abc.foo1 FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT abc.b FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT foo.a FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2, foo3, foo4)

-- sqlfmt-corpus-separator --

SELECT * FROM ab AS foo (foo1, foo2)

-- sqlfmt-corpus-separator --

SELECT * FROM ab AS foo (foo1, foo2, foo3)

-- sqlfmt-corpus-separator --

PREPARE a AS SELECT 1 = (SELECT $1::int)

-- sqlfmt-corpus-separator --

PREPARE b AS SELECT EXISTS (SELECT $1::int)

-- sqlfmt-corpus-separator --

SELECT (SELECT string_agg(DISTINCT ship, ', ')
  FROM
  (SELECT c_id AS o_c_id, ship FROM o ORDER BY ship)
  WHERE o_c_id=c.c_id)
FROM c ORDER BY c_id

-- sqlfmt-corpus-separator --

WITH a AS (SELECT 1) SELECT * FROM a CROSS JOIN a

-- sqlfmt-corpus-separator --

WITH t AS (SELECT a FROM y WHERE a < 3)
  SELECT * FROM x NATURAL JOIN t

-- sqlfmt-corpus-separator --

WITH t AS (SELECT * FROM y WHERE a < 3)
  SELECT * FROM x NATURAL JOIN t

-- sqlfmt-corpus-separator --

WITH t(x) AS (SELECT a FROM x)
  SELECT * FROM y WHERE a IN (SELECT x FROM t)

-- sqlfmt-corpus-separator --

WITH t(b) AS (SELECT a FROM x) SELECT b, t.b FROM t

-- sqlfmt-corpus-separator --

WITH t(a, b) AS (SELECT true a, false b)
  SELECT a, b FROM t

-- sqlfmt-corpus-separator --

WITH t(b, a) AS (SELECT true a, false b)
  SELECT a, b FROM t

-- sqlfmt-corpus-separator --

WITH
    t AS (SELECT true),
    t AS (SELECT false)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t(b, c) AS (SELECT a FROM x) SELECT b, t.b FROM t

-- sqlfmt-corpus-separator --

WITH t AS (SELECT a FROM x) SELECT a, x.t FROM t

-- sqlfmt-corpus-separator --

WITH t(x) AS (WITH t(x) AS (SELECT 1) SELECT x * 10 FROM t) SELECT x + 2 FROM t

-- sqlfmt-corpus-separator --

WITH t AS (SELECT * FROM y WHERE a < 3)
  SELECT * FROM t NATURAL JOIN x

-- sqlfmt-corpus-separator --

WITH t(x) AS (SELECT * FROM y WHERE a < 3)
  SELECT * FROM x WHERE a IN (
    SELECT a FROM t WHERE x.a = t.x
  )

-- sqlfmt-corpus-separator --

WITH c AS (SELECT a + 1 FROM x) SELECT (SELECT * FROM c);

-- sqlfmt-corpus-separator --

WITH squares_y AS (
    SELECT y FROM squares
  )
SELECT * FROM squares_y WHERE y IN (
  SELECT y * y FROM squares_y
)

-- sqlfmt-corpus-separator --

WITH q AS (SELECT 'foo' AS x)
SELECT x, pg_typeof(x)  FROM q;

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

WITH count AS (VALUES (9)) SELECT count(*) FROM count;

-- sqlfmt-corpus-separator --

SELECT now(DISTINCT)

-- sqlfmt-corpus-separator --

SELECT round(DISTINCT 1)

-- sqlfmt-corpus-separator --

with mutually recursive
    a(x int) as (select * from a)
select * from a;

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

select
  subq_0."c2" as c0,
  (select "id" from mz_introspection.mz_records_per_dataflow limit 1 offset 62)
     as c1,
  subq_0."c2" as c2
from
  (select
        ref_0."id" as c0,
        ref_0."name" as c1,
        (select "count" from mz_introspection.mz_scheduling_parks_histogram_per_worker limit 1 offset 3)
           as c2,
        ref_0."name" as c3,
        ref_0."records" as c4,
        ref_0."batches" as c5
      from
        mz_introspection.mz_dataflow_arrangement_sizes as ref_0
      where pg_catalog.date(
          CAST((select "updated_at" from mz_internal.mz_cluster_replica_statuses limit 1 offset 5)
             as timestamptz)) < (select "o_orderdate" from public.orders limit 1 offset 1)
      limit 140) as subq_0
where subq_0."c5" > subq_0."c5"
limit 21;

-- sqlfmt-corpus-separator --

select distinct 'postgres', current_user() from mz_internal.mz_cluster_replica_metrics;

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

SELECT count(DISTINCT id) FROM mz_objects WHERE name LIKE 'id_pool_%'

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(a) FILTER (WHERE a IS NOT NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg(a, a) FILTER (WHERE a IS NOT NULL) FROM t1

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY (SELECT * FROM t2)) FROM t2

-- sqlfmt-corpus-separator --

SELECT sum(a ORDER BY b) FROM t2

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

SELECT
    c.position, c.name, c.type, c.type_mod, left(t.id, 1)
    FROM mz_columns c
    JOIN mz_views v ON c.id = v.id
    JOIN mz_types t ON c.type_oid = t.oid
    WHERE v.name = 'v'
    ORDER BY c.position

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

SELECT lag(10*right_a+3) OVER (ORDER BY right_a NULLS FIRST), -sum(foo.a), b
FROM foo LEFT JOIN (SELECT a as right_a FROM foo WHERE a<2) ON foo.a = right_a
GROUP BY b, right_a
ORDER BY lag(10*right_a+3) OVER (ORDER BY right_a NULLS FIRST), -sum(foo.a), b;

-- sqlfmt-corpus-separator --

SELECT -sum(foo.a), b
FROM foo LEFT JOIN (SELECT a as right_a FROM foo WHERE a<2) ON foo.a = right_a
GROUP BY b, right_a
ORDER BY lag(10*right_a+3) OVER (ORDER BY right_a NULLS FIRST), -sum(foo.a), b;

-- sqlfmt-corpus-separator --

SELECT lag(10*right_a+3) OVER (ORDER BY right_a NULLS FIRST), sum(foo.a), length(b)
FROM foo LEFT JOIN (SELECT a as right_a FROM foo WHERE a<2) ON foo.a = right_a
GROUP BY b, right_a
ORDER BY lag(10*right_a+3) OVER (ORDER BY right_a NULLS FIRST), -sum(foo.a)/10, length(b) DESC NULLS FIRST;

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

SELECT a, lag(a) OVER (ORDER BY a) as d
FROM foo
ORDER BY d;

-- sqlfmt-corpus-separator --

SELECT a, lag(a) OVER (ORDER BY a) as d
FROM foo
ORDER BY -d;

-- sqlfmt-corpus-separator --

SELECT a, 2*a as d
FROM foo
ORDER BY lag(d) OVER (ORDER BY d);

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM foo ORDER BY b

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM foo ORDER BY a + 1

-- sqlfmt-corpus-separator --

SELECT a FROM foo
ORDER BY lag(a) OVER (ORDER BY a) NULLS LAST;

-- sqlfmt-corpus-separator --

SELECT a FROM foo
ORDER BY lag(a) OVER (ORDER BY -a NULLS FIRST) DESC NULLS LAST;

-- sqlfmt-corpus-separator --

SELECT DISTINCT b, a FROM foo ORDER BY b

-- sqlfmt-corpus-separator --

SELECT b, a
FROM foo
ORDER BY b
LIMIT 2 OFFSET 1;

-- sqlfmt-corpus-separator --

SELECT b, a
FROM foo
ORDER BY b
FETCH FIRST 2 ROWS ONLY OFFSET 1;

-- sqlfmt-corpus-separator --

SELECT b, a
FROM foo
ORDER BY b
OFFSET 1 LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT b, a
FROM foo
ORDER BY b
OFFSET 1;

-- sqlfmt-corpus-separator --

SELECT b, a
FROM foo
ORDER BY b
OFFSET 1
FETCH FIRST 1 ROWS ONLY;

-- sqlfmt-corpus-separator --

SELECT b, a
FROM foo
ORDER BY b
OFFSET 1
FETCH NEXT 1 ROWS ONLY;

-- sqlfmt-corpus-separator --

SELECT b, a
FROM foo
ORDER BY b
OFFSET 1 ROW LIMIT 3;

-- sqlfmt-corpus-separator --

SELECT b, a
FROM foo
ORDER BY b
OFFSET 1 ROWS LIMIT 3;

-- sqlfmt-corpus-separator --

SELECT b, (SELECT val1 FROM baz WHERE val2 = a ORDER BY val1 limit 1 offset 1 rows) c
FROM fizz ORDER BY b, c DESC

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), (NULL), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x NULLS FIRST), x FROM t;

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), (NULL), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x NULLS LAST), x FROM t;

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x NULLS FIRST), x FROM t;

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x NULLS LAST), x FROM t;

-- sqlfmt-corpus-separator --

PREPARE p1 AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET $1;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET null;

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

PREPARE p3 AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET $1 - 2;

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
OFFSET 'aaa';

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET a;

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
ORDER BY b, a
OFFSET mz_now()::string::bigint;

-- sqlfmt-corpus-separator --

SELECT b || a
FROM v1
OFFSET 1

-- sqlfmt-corpus-separator --

SELECT b || a
FROM v1
OFFSET 2 - 1

-- sqlfmt-corpus-separator --

SELECT b || a
FROM mv1
OFFSET 1

-- sqlfmt-corpus-separator --

SELECT b || a
FROM mv1
OFFSET 2 - 1

-- sqlfmt-corpus-separator --

PREPARE p6 AS
VALUES (10), (11), (12), ($2), ($3)
ORDER BY 1 DESC
OFFSET $1 - 1

-- sqlfmt-corpus-separator --

PREPARE fizz_paginated AS
SELECT *
FROM fizz
ORDER BY a, b DESC
LIMIT $1
OFFSET $2

-- sqlfmt-corpus-separator --

SELECT value from numbers LIMIT 10 OFFSET 6;

-- sqlfmt-corpus-separator --

SELECT * FROM t1 LIMIT 1 OFFSET 0;

-- sqlfmt-corpus-separator --

SELECT * FROM t1 LIMIT 1 OFFSET 1;

-- sqlfmt-corpus-separator --

SELECT DISTINCT(attgenerated = '') FROM pg_attribute

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_names

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_abbrevs

-- sqlfmt-corpus-separator --

SELECT DISTINCT - CASE CAST ( - 91 AS INTEGER ) WHEN + COUNT ( * ) THEN NULL WHEN + 31 - + COALESCE ( + CAST ( - 3 AS INTEGER ), - + 66 ) THEN - + AVG ( DISTINCT + 72 ) ELSE - COUNT ( * ) END * 58 * + + ( COUNT ( * ) ) / - 61 * + - 33 * + 65 - - 65 AS col0

-- sqlfmt-corpus-separator --

SELECT ALL NULLIF ( 38, + 23 * + ( + 46 ) ) + + COUNT ( * ) - + COUNT ( DISTINCT + + 0 ) + + - 57 + + - 48 / - + COALESCE ( 85, - AVG ( + 53 ) ) * + 4 * + 44 / 22

-- sqlfmt-corpus-separator --

SELECT 78 + - MAX ( DISTINCT - 32 ) / COALESCE ( - 25, 13 + MIN ( + 12 ) + - CAST ( NULL AS INTEGER ) * + MAX ( 8 ) * + AVG ( + + 43 ) ) * + 61 + ( + 36 ) + + ( 17 ) + - + 40 * + + 82

-- sqlfmt-corpus-separator --

select count(distinct ss.ten) from
  (select ten from tenk1 a
   where unique1 IN (select hundred from tenk1 b)) ss;

-- sqlfmt-corpus-separator --

select count(distinct ss.ten) from
  (select ten from tenk1 a
   where unique1 IN (select distinct hundred from tenk1 b)) ss;

-- sqlfmt-corpus-separator --

with q as (select max(f1) from int4_tbl group by f1 order by f1)
  select q from q;

-- sqlfmt-corpus-separator --

select distinct q1 from
  (select distinct * from int8_tbl i81
   union all
   select distinct * from int8_tbl i82) ss
where q2 = q2
order by 1

-- sqlfmt-corpus-separator --

select distinct q1 from
  (select distinct * from int8_tbl i81
   union all
   select distinct * from int8_tbl i82) ss
where -q1 = q2

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

PREPARE p2 AS
SELECT $1::bigint + $1::bigint;

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

PREPARE p7 AS
SELECT $1 || $1, $1 + $1::bigint;

-- sqlfmt-corpus-separator --

SELECT DISTINCT(privilege) FROM item_privileges WHERE type = 'view' OR type = 'materialized view' OR type = 'source'

-- sqlfmt-corpus-separator --

SELECT DISTINCT(privilege) FROM item_privileges WHERE type = 'table'

-- sqlfmt-corpus-separator --

SELECT DISTINCT(privilege) FROM item_privileges WHERE type = 'type'

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

SELECT DISTINCT lower(a), upper(a) FROM int4range_values
ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM int4range_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a >> v GROUP BY a ORDER BY a;

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

SELECT DISTINCT lower(a), upper(a) FROM int8range_values
ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM int8range_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a >> v GROUP BY a ORDER BY a;

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

SELECT DISTINCT lower(a), upper(a) FROM daterange_values;

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM daterange_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a >> v GROUP BY a ORDER BY a;

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

SELECT DISTINCT lower(a), upper(a) FROM numrange_values;

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM numrange_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a >> v GROUP BY a ORDER BY a;

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

SELECT DISTINCT lower(a), upper(a) FROM tsrange_values ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM tsrange_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a >> v GROUP BY a ORDER BY a;

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

SELECT DISTINCT lower(a), upper(a) FROM tstzrange_values ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM tstzrange_values WHERE lower_inf(a) AND upper_inf(a);

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a >> v GROUP BY a ORDER BY a;

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

WITH cte1 AS (SELECT 1 AS a, 2 AS a) SELECT * FROM cte1 WHERE cte1.a = 1

-- sqlfmt-corpus-separator --

SELECT left(42)

-- sqlfmt-corpus-separator --

SELECT left('str')

-- sqlfmt-corpus-separator --

SELECT left(42, 'str')

-- sqlfmt-corpus-separator --

SELECT left('str', 42, 17)

-- sqlfmt-corpus-separator --

select left(strcol, 3) from lefttest

-- sqlfmt-corpus-separator --

SELECT left(vccol, 0) FROM lefttest

-- sqlfmt-corpus-separator --

SELECT left(vccol, 2) FROM lefttest

-- sqlfmt-corpus-separator --

SELECT left(vccol, -2) FROM lefttest

-- sqlfmt-corpus-separator --

SELECT left(vccol, smicol), left(vccol, intcol) FROM lefttest

-- sqlfmt-corpus-separator --

SELECT left(NULL, 99)

-- sqlfmt-corpus-separator --

SELECT left('str', NULL)

-- sqlfmt-corpus-separator --

SELECT left('रः॑', 0)

-- sqlfmt-corpus-separator --

SELECT left('रः॑', 1)

-- sqlfmt-corpus-separator --

SELECT left('रः॑', -1)

-- sqlfmt-corpus-separator --

SELECT left(e'\u0930\u0903\u0951', -1)

-- sqlfmt-corpus-separator --

SELECT left('hello', -2147483648)

-- sqlfmt-corpus-separator --

SELECT left('hello', -2147483647)

-- sqlfmt-corpus-separator --

SELECT left('hello', 2147483648)

-- sqlfmt-corpus-separator --

SELECT right(42)

-- sqlfmt-corpus-separator --

SELECT right('str')

-- sqlfmt-corpus-separator --

SELECT right(42, 'str')

-- sqlfmt-corpus-separator --

SELECT right('str', 42, 17)

-- sqlfmt-corpus-separator --

select right(strcol, 3) from righttest

-- sqlfmt-corpus-separator --

SELECT right(vccol, 0) FROM righttest

-- sqlfmt-corpus-separator --

SELECT right(vccol, 2) FROM righttest

-- sqlfmt-corpus-separator --

SELECT right(vccol, -2) FROM righttest

-- sqlfmt-corpus-separator --

SELECT right(vccol, smicol), right(vccol, intcol) FROM righttest

-- sqlfmt-corpus-separator --

SELECT right(NULL, 99)

-- sqlfmt-corpus-separator --

SELECT right('str', NULL)

-- sqlfmt-corpus-separator --

SELECT right('रः॑', 0)

-- sqlfmt-corpus-separator --

SELECT right('रः॑', 1)

-- sqlfmt-corpus-separator --

SELECT right('रः॑', -1)

-- sqlfmt-corpus-separator --

SELECT right(e'\u0930\u0903\u0951', -1)

-- sqlfmt-corpus-separator --

SELECT right('hello', -2147483648)

-- sqlfmt-corpus-separator --

SELECT right('hello', -2147483647)

-- sqlfmt-corpus-separator --

SELECT right('hello', 2147483648)

-- sqlfmt-corpus-separator --

SELECT DISTINCT octet_length(a) FROM bpchar_t;

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE (SELECT 1/a FROM t)

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t ENVELOPE UPSERT (KEY (a)) WITH (PROGRESS)

-- sqlfmt-corpus-separator --

DECLARE c2 CURSOR FOR SUBSCRIBE TO (SHOW CLUSTER REPLICAS);

-- sqlfmt-corpus-separator --

SELECT generate_series(DISTINCT 1, 1)

-- sqlfmt-corpus-separator --

WITH a(x) AS (SELECT 'a') SELECT generate_series(1, 2), * FROM a ORDER BY generate_series

-- sqlfmt-corpus-separator --

select * from valid AS OF 2;

-- sqlfmt-corpus-separator --

select * from valid AS OF 3;

-- sqlfmt-corpus-separator --

select * from valid AS OF 11;

-- sqlfmt-corpus-separator --

select * from valid AS OF 14;

-- sqlfmt-corpus-separator --

select * from valid AS OF 18446744073709551614;

-- sqlfmt-corpus-separator --

select * from valid_max AS OF 0

-- sqlfmt-corpus-separator --

with v as (select mz_now() < '3000-01-01') select * from v;

-- sqlfmt-corpus-separator --

SELECT * FROM t AS OF AT LEAST 1683131452106;

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

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT row_number() FROM t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x DESC), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT row_number() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT row_number() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT row_number() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT row_number() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'))
SELECT row_number() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (), row_number() OVER ()

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'))
SELECT row_number() OVER (), row_number() OVER () from t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT * FROM t AS v JOIN t ON row_number() over () > 1;

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT * FROM t
WHERE row_number() over () > 1;

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT DISTINCT ON (row_number() OVER ()) *
FROM t
ORDER BY row_number() OVER ()

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98), ('a', 98), ('a', 99))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT dense_rank() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT dense_rank() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'))
SELECT dense_rank() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t

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

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT lag(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT lag(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT lag(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT lag(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT lag(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT lag(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT lag(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98), ('a', 98), ('a', 99))
SELECT lag(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lag(x) OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lag(x) OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lag(a1.x) OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + coalesce(nullif(f3, 'NaN'), -10)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(nullif(f1, 4)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
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
SELECT f1, f2, f3, lag(f1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, -2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1 + f3, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, -10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, f1 - 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, nullif(f1, 1)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, NULL, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lag(f1, 1, f3) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, 0) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, -1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, 1, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

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
SELECT f1, lag(f1 * f2, f1 - f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1 * f2, f1 - 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1 * f2, f2 - 2 * f1, f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, 0, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lag(f1, 1, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT lead(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT lead(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT lead(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT lead(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT lead(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT lead(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT lead(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98), ('a', 98), ('a', 99))
SELECT lead(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lead(x) OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lead(x) OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT lead(a1.x) OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + coalesce(nullif(f3, 'NaN'), -10)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(nullif(f1, 4)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
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
SELECT f1, f2, f3, lead(f1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, -2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1 + f3, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, -10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, f1 - 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, nullif(f1, 1)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, NULL, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0), (7, 'd', -5.0))
SELECT f1, f2, f3, lead(f1, 1, f3) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, 0) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, -1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, 1, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

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
SELECT f1, lead(f1 * f2, f1 - f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1 * f2, f1 - 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1 * f2, f2 - 2 * f1, f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, 0, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

WITH t (f1, f2) AS (VALUES (1, 2), (1, 2), (3, 4))
SELECT f1, lead(f1, 1, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN CURRENT ROW AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 1 FOLLOWING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 1 FOLLOWING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN CURRENT ROW AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN CURRENT ROW AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 FOLLOWING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER ()

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE UNBOUNDED PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN CURRENT ROW AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN CURRENT ROW AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
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
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551614 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551615 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551614 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

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

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND 10 FOLLOWING)
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
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551615 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551614 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551615 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551614 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1, 'a', 1), (2, 'a', 2), (2, 'a', 3), (3, 'a', 4), (4, 'b', 5), (4, 'b', 6), (1, 'c', 7), (2, 'c', 8), (3, 'c', 9), (7, 'd', 10))
SELECT
  sum(f1)   OVER (ORDER BY f2) s,
  max(f1)   OVER (ORDER BY f2) m,
  count(f1) OVER (ORDER BY f3) c
FROM t
ORDER BY s, m, c;

-- sqlfmt-corpus-separator --

SELECT
  x,
  sum(sum(x) OVER (ORDER BY x)) OVER (ORDER BY x),
  sum(x/3.14) OVER (ORDER BY x),
  max(x/3.14) OVER (ORDER BY x)
FROM (SELECT DISTINCT ON(x) * FROM t_using_dataflow_rendering);

-- sqlfmt-corpus-separator --

WITH const_values(x,y) AS (VALUES (1,2), (3,null), (5,6), (7,8), (9, null), (11, null), (13, 14), (15, 16), (17, 18), (10, -40), (10, -50))
SELECT
  x,
  sum(sum(x) OVER (ORDER BY x)) OVER (ORDER BY x),
  sum(x/3.14) OVER (ORDER BY x),
  max(x/3.14) OVER (ORDER BY x)
FROM (SELECT DISTINCT ON(x) * FROM const_values);

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

SELECT a,b
FROM t1
WHERE a IN (4,3,2,1)
ORDER BY -a, b
LIMIT 3 OFFSET 1;

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

SELECT DISTINCT ON(max_a) max_a, b
FROM (
    SELECT b, MAX(a) AS max_a
    FROM t
    GROUP BY b
)
ORDER BY max_a, b DESC;

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

WITH t3_with_key AS (select f1 as key, sum(f2) as nokey from t3 group by f1)
SELECT a1.* FROM t3_with_key AS a1 LEFT JOIN t3_with_key AS a2 ON (a1.key = a2.key)

-- sqlfmt-corpus-separator --

WITH t3_with_key AS (select f1 as key, sum(f2) as nokey from t3 group by f1)
SELECT a1.* FROM t3 AS a1 LEFT JOIN t3_with_key AS a2 ON (a1.f1 = a2.key)

-- sqlfmt-corpus-separator --

WITH t3_with_key AS (select f1 as key, sum(f2) as nokey from t3 group by f1)
SELECT a1.* FROM t3 AS a1 LEFT JOIN t3_with_key AS a2 ON (a1.f1 = a2.key or (a1.f1 is null and a2.key is null));

-- sqlfmt-corpus-separator --

EXPLAIN RAW PLAN FOR
    SELECT 'a'::"char" < 'a'::varchar;

-- sqlfmt-corpus-separator --

EXPLAIN RAW PLAN FOR
    SELECT 'a'::"char" < 'a'::char;

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1::uint8, 'a', 1.0))
SELECT lag(f1, 1::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1::uint8, 'a', 1.0))
SELECT pg_typeof(lag(f1, 1::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1))
FROM t

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1::uint8, 'a', 1.0))
SELECT lag(f1, 1::int, 0::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t

-- sqlfmt-corpus-separator --

WITH t (f1, f2, f3) AS (VALUES (1::uint8, 'a', 1.0))
SELECT pg_typeof(lag(f1, 1::int, 0::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1))
FROM t

-- sqlfmt-corpus-separator --

SELECT *
FROM t
QUALIFY row_number();

-- sqlfmt-corpus-separator --

SELECT int8range(1, 1, '') OVER (PARTITION BY 1 ORDER BY 1);

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x DESC), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (), row_number() OVER () from t

-- sqlfmt-corpus-separator --

SELECT * FROM t
WHERE row_number() over () > 1;

-- sqlfmt-corpus-separator --

SELECT * FROM not_allowed_tests GROUP BY v, count(w) OVER ();

-- sqlfmt-corpus-separator --

SELECT count(w) OVER () FROM not_allowed_tests GROUP BY 1;

-- sqlfmt-corpus-separator --

SELECT sum(v) FROM not_allowed_tests GROUP BY k LIMIT sum(v) OVER ();

-- sqlfmt-corpus-separator --

SELECT sum(v) FROM not_allowed_tests GROUP BY k LIMIT 1 OFFSET sum(v) OVER ();

-- sqlfmt-corpus-separator --

SELECT k FROM not_allowed_tests WHERE avg(k) OVER () > 1;

-- sqlfmt-corpus-separator --

SELECT 1 FROM not_allowed_tests GROUP BY 1 HAVING sum(1) OVER (PARTITION BY 1) > 1;

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (row_number() OVER ()) *
FROM t
ORDER BY row_number() OVER ()

-- sqlfmt-corpus-separator --

SELECT rank(x) OVER (ORDER BY x), dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY x), dense_rank() OVER (ORDER BY x), x FROM t

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY x DESC), dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY y ORDER BY x), dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY dense_rank, x;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY y ORDER BY x DESC), dense_rank() OVER (PARTITION BY y ORDER BY x DESC), x FROM t;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY dense_rank, x;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY x ORDER BY x), dense_rank() OVER (PARTITION BY x ORDER BY x), x FROM t;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY dense_rank, x;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY NULL ORDER BY 10000), dense_rank() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY NULL), dense_rank() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY y ORDER BY x DESC, z), dense_rank() OVER (PARTITION BY y ORDER BY x DESC, z), x, y, z
FROM t;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC, z), x, y, z
FROM t
ORDER BY y, x DESC, z;

-- sqlfmt-corpus-separator --

WITH t (x, y, z) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0))
SELECT rank() OVER (PARTITION BY y ORDER BY z DESC), dense_rank() OVER (PARTITION BY y ORDER BY z DESC), x, y, z
FROM t;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY z DESC), x, y, z
FROM t
ORDER BY y, z DESC, x;

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lag(x) OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY x, lag

-- sqlfmt-corpus-separator --

SELECT lag(a1.x) OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + coalesce(nullif(f3, 'NaN'), -10)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(nullif(f1, 4)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
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

SELECT f1, f2, f3, lag(f1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, -2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1 + f3, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, -10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, f1 - 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, nullif(f1, 1)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, NULL, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lag(f1, 1, f3) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lag

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, 0) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, -1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, 1, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1 * f2, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1 * f2, 1, f1 * f2 + 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1 * f2, f1 - f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1 * f2, f1 - 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1 * f2, f2 - 2 * f1, f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, 0, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(f1, 1, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q

-- sqlfmt-corpus-separator --

SELECT f1, lag(0, f1 , 0) OVER (PARTITION BY f1 ORDER BY f1) FROM t3 GROUP BY f1 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT lead(x) OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY x, lead

-- sqlfmt-corpus-separator --

SELECT lead(a1.x) OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + coalesce(nullif(f3, 'NaN'), -10)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(NULL::int) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(nullif(f1, 4)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(NULL::int, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, 2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
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

SELECT f1, f2, f3, lead(f1, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, -1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, -2) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1 + f3, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, -10, 0) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, f1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, f1 - 1) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, NULL) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, nullif(f1, 1)) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, NULL, -10) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, lead(f1, 1, f3) OVER (PARTITION BY f2 ORDER BY f3 DESC, f1)
FROM t
ORDER BY f2 DESC, f3 DESC, f1, lead

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, 0) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, -1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, 1, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1 * f2, 0, 10) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1 * f2, 1, f1 * f2 + 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1 * f2, f1 - f1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1 * f2, f1 - 1) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1 * f2, f2 - 2 * f1, f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, 0, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(f1, 1, f1 * f2) OVER (PARTITION BY f1, f2)
FROM (SELECT DISTINCT f1, f2 FROM t) q
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT f1, lead(0, f1 , 0) OVER (PARTITION BY f1 ORDER BY f1) FROM t4 GROUP BY f1 ORDER BY 1

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

select first_value(x) ignore nulls over() from t6;

-- sqlfmt-corpus-separator --

select row_number() ignore nulls over();

-- sqlfmt-corpus-separator --

select row_number() ignore nulls respect nulls over();

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
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

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 2 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 10 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 100 FOLLOWING AND 1000001 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1000001 PRECEDING AND 100 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551614 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551615 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 18446744073709551615 PRECEDING AND 18446744073709551614 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1000 PRECEDING AND 1000 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, first_value(f1) OVER (PARTITION BY f2 ORDER BY f1, f3 ROWS BETWEEN 1000 PRECEDING AND 999 PRECEDING)
FROM t
ORDER BY f2, f3, f1, first_value

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
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

SELECT f1, first_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

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

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f3) OVER (PARTITION BY f2 ORDER BY f1)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 FOLLOWING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 FOLLOWING AND 10 FOLLOWING)
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

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 10 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 2 PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 10 PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 10 PRECEDING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551615 FOLLOWING AND 18446744073709551615 FOLLOWING)
FROM t
ORDER BY f2, f3, f1, last_value

-- sqlfmt-corpus-separator --

SELECT f1, f2, f3, last_value(f1) OVER (PARTITION BY f2 ORDER BY f1 DESC, f3 DESC ROWS BETWEEN 18446744073709551614 FOLLOWING AND 18446744073709551615 FOLLOWING)
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

SELECT f1, last_value(f1) OVER (PARTITION BY f1)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 FOLLOWING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 FOLLOWING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 FOLLOWING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 0 PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

-- sqlfmt-corpus-separator --

SELECT f1, last_value(f1) OVER (PARTITION BY f1 ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
FROM t5
GROUP BY f1

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

SELECT a, b, lag(a) OVER (ORDER BY a) + lag(a) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY a) + lead(a) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT 1 + lag(a, 1, 0) OVER (ORDER BY a), *
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(1 + lag(a, 1, 0) OVER (ORDER BY a)) *
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a);

-- sqlfmt-corpus-separator --

SELECT 1 + lag(a, 1, 0) OVER (ORDER BY a), *
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a), a ASC;

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(1 + lag(a, 1, 0) OVER (ORDER BY a)) *
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a), a ASC;

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(1 + lag(a, 1, 0) OVER (ORDER BY a)) *
FROM foo
ORDER BY lag(a, 1, 0) OVER (ORDER BY a), a DESC;

-- sqlfmt-corpus-separator --

SELECT 1 + lag(a, 1, 0) OVER (ORDER BY a), lead(a) OVER (ORDER BY b) AS o, a, b
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a), o DESC;

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(1 + lag(a, 1, 0) OVER (ORDER BY a)) lead(a) OVER (ORDER BY b) AS o, a, b
FROM foo
ORDER BY 1 + lag(a, 1, 0) OVER (ORDER BY a), o DESC;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(lag(a) OVER (ORDER BY a)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(lag(a) OVER (PARTITION BY length(b) ORDER BY a)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(lag(a) OVER (ORDER BY a)) OVER (ORDER BY a), lag(a) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY a), lag(lag(a) OVER (ORDER BY a)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (PARTITION BY lag(length(b)) OVER (ORDER BY a) ORDER BY a), lag(length(b)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (PARTITION BY lag(length(b)) OVER (ORDER BY a) ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, row_number() OVER (PARTITION BY lag(length(b)) OVER (ORDER BY a) ORDER BY a), lag(length(b)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lead(lag(a) OVER (PARTITION BY lag(length(b)) OVER (ORDER BY a) ORDER BY a), 1, -5) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY lag(a) OVER (ORDER BY a)), lag(a) OVER (ORDER BY a)
FROM foo
ORDER BY lag(a) OVER (ORDER BY a);

-- sqlfmt-corpus-separator --

SELECT a, b, lag(a) OVER (ORDER BY lag(a) OVER (ORDER BY a))
FROM foo
ORDER BY a;

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

SELECT length(b), sum(a), lag(sum(a)) OVER (ORDER BY sum(a))
FROM foo
GROUP BY length(b)
ORDER BY sum(a), length(b);

-- sqlfmt-corpus-separator --

SELECT length(b), sum(a), lag(sum(a)) OVER (ORDER BY length(b))
FROM foo
GROUP BY length(b)
ORDER BY length(b);

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
  sum(y) OVER (ORDER BY x ROWS BETWEEN 2 FOLLOWING AND 5 FOLLOWING),
  max(y) OVER (ORDER BY x ROWS BETWEEN 2 FOLLOWING AND 5 FOLLOWING),
  min(y) OVER (ORDER BY x ROWS BETWEEN 2 FOLLOWING AND 5 FOLLOWING),
  list_agg(y) OVER (ORDER BY x ROWS BETWEEN 2 FOLLOWING AND 5 FOLLOWING)[1]
FROM t7
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT sum(sum(x) OVER ()) FROM t7;

-- sqlfmt-corpus-separator --

SELECT sum(sum(x)) OVER (ORDER BY y) FROM t7 GROUP BY y;

-- sqlfmt-corpus-separator --

SELECT sum(sum(x) OVER ()) OVER () FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  x,
  sum(x) OVER (ORDER BY x),
  sum(sum(x) OVER (ORDER BY x)) OVER (ORDER BY x)
FROM (SELECT DISTINCT ON(x) * FROM t7);

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
  sum(y) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  max(y) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  min(y) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(y) OVER (ORDER BY x RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
FROM t7
ORDER BY x;

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
  sum(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING),
  max(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING),
  min(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING),
  array_agg(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 0 PRECEDING AND 0 FOLLOWING)
FROM t7
ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING)
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING)
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
  sum(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING),
  max(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING),
  min(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING),
  array_agg(x) OVER (ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)
FROM t7
ORDER BY CASE WHEN y IS NOT NULL THEN x*y ELSE x END;

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
  sum(sum(x)) OVER ()
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  min(count(x)) OVER ()
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  count(min(x)) OVER ()
FROM t7;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  min(y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  count(y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  count(*) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  array_agg(y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  avg(y+y) OVER (PARTITION BY x)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  count(y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  sum(y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
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
  array_agg(y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
FROM t9
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  avg(y+y) OVER (PARTITION BY x ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING)
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

SELECT *
FROM t6
QUALIFY row_number() OVER (PARTITION BY x%3 ORDER BY y) = 1;

-- sqlfmt-corpus-separator --

SELECT *, x%3, row_number() OVER (PARTITION BY x%3 ORDER BY y)
FROM t6
QUALIFY row_number() OVER (PARTITION BY x%3 ORDER BY y) = 1;

-- sqlfmt-corpus-separator --

SELECT *
FROM t6
QUALIFY sum(x) OVER (ORDER BY y) = 26;

-- sqlfmt-corpus-separator --

SELECT *
FROM (SELECT * FROM t6 UNION ALL SELECT * FROM t6)
QUALIFY sum(x) OVER (ORDER BY y) = 26;

-- sqlfmt-corpus-separator --

SELECT avg(u)
FROM (
  SELECT x, unnest(l) AS u
  FROM (
    SELECT x, array_agg(y) OVER (PARTITION BY x%5) AS l
    FROM t7
  ) AS ff1
) AS ff2
GROUP BY x%5
QUALIFY sum(avg(u)) OVER (ORDER BY x%5) = -15
ORDER BY x%5;

-- sqlfmt-corpus-separator --

SELECT *
FROM (
  SELECT x, unnest(l) AS u
  FROM (
    SELECT x, array_agg(y) OVER (PARTITION BY x%5) AS l
    FROM t7
  ) AS ff1
)
QUALIFY x-lag(x) OVER (ORDER BY x) = 0 AND lag(x) OVER (ORDER BY x) - lag(lag(x) OVER (ORDER BY x)) OVER (ORDER BY x) = 0
ORDER BY x,u;

-- sqlfmt-corpus-separator --

SELECT *, sum(x-9) OVER (ORDER BY x, u)
FROM
(
  SELECT DISTINCT *
  FROM (
    SELECT x, unnest(l) AS u
    FROM (
      SELECT x, array_agg(y) OVER (PARTITION BY x%5) AS l
      FROM t7
    ) AS ff1
  )
  QUALIFY x-lag(x) OVER (ORDER BY x) = 0 AND lag(x) OVER (ORDER BY x) - lag(lag(x) OVER (ORDER BY x)) OVER (ORDER BY x) = 0
)
QUALIFY sum(x-9) OVER (ORDER BY x, u) > -6
ORDER BY x,u;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT * FROM bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    t (n int) AS (
        VALUES (1)
        UNION ALL
        SELECT n+1 FROM t WHERE n < 100
    )
SELECT sum(n) FROM t;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 100)
    t (n int) AS (
        VALUES (1)
        UNION ALL
        SELECT n+1 FROM t
    )
SELECT sum(n) FROM t;

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

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT (
        SELECT MIN(c) FROM bar
    ), 2 UNION SELECT 5, 5 FROM bar),
    bar (c int) as (SELECT a FROM foo)
SELECT * FROM foo, bar;

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
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT (SELECT COUNT(*) FROM foo) FROM bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a text, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT * FROM bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1 UNION SELECT a FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT a FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2, 3 UNION SELECT a, 5, 6 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT a FROM foo, bar;

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
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT 5, 5 FROM bar),
    bar (c int) as (SELECT c FROM foo)
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

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 3)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT = 3)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (ERROR AT RECURSION LIMIT 3)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT * FROM cnt;

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

WITH MUTUALLY RECURSIVE (RECURSION LIMIT)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT aaaaaaa)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT -3)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT 3, RECURSION LIMIT 5)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT 3, ERROR AT RECURSION LIMIT 5)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT 3, RETURN AT RECURSION LIMIT 5)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (ERROR AT RECURSION LIMIT 3, RETURN AT RECURSION LIMIT 5)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT 0)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x NUMERIC) as (SELECT sum(a) FROM y)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x NUMERIC) as (SELECT sum(a) FROM y)
SELECT pg_typeof(x) FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x NUMERIC) as (SELECT sum(a) + 1.23456 FROM y)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x NUMERIC(38,2)) as (SELECT sum(a) + 1.23456 FROM y)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x UINT2) as (SELECT 1::INT8)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x UINT2) as (SELECT -1::INT8)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x INT8) as (SELECT '1')
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x list_numeric_scale_2) as (SELECT LIST[sum(a) + 1.2345] FROM y)
SELECT x::TEXT FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x list_numeric_scale_2) as (SELECT LIST['1'::TEXT])
SELECT x FROM bar

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