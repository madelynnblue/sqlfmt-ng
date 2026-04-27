(((SELECT q1 FROM int8_tbl INTERSECT SELECT q2 FROM int8_tbl ORDER BY 1))) UNION ALL SELECT q2 FROM int8_tbl

-- sqlfmt-corpus-separator --

(((SELECT q1 FROM int8_tbl UNION ALL SELECT q2 FROM int8_tbl))) EXCEPT SELECT q1 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

((SELECT 2)) UNION SELECT 2

-- sqlfmt-corpus-separator --

(SELECT * FROM distinct_hash_1 EXCEPT SELECT * FROM distinct_group_1)
  UNION ALL
(SELECT * FROM distinct_group_1 EXCEPT SELECT * FROM distinct_hash_1)

-- sqlfmt-corpus-separator --

(SELECT 1,2,3 UNION SELECT 4,5,6 ORDER BY 1,2) EXCEPT SELECT 4,5,6

-- sqlfmt-corpus-separator --

(SELECT 1,2,3 UNION SELECT 4,5,6 ORDER BY 1,2) INTERSECT SELECT 4,5,6

-- sqlfmt-corpus-separator --

(SELECT 1,2,3 UNION SELECT 4,5,6) EXCEPT SELECT 4,5,6

-- sqlfmt-corpus-separator --

(SELECT 1,2,3 UNION SELECT 4,5,6) INTERSECT SELECT 4,5,6

-- sqlfmt-corpus-separator --

(SELECT 2) UNION SELECT 2

-- sqlfmt-corpus-separator --

(select * from agg_hash_1 except select * from agg_group_1)
  union all
(select * from agg_group_1 except select * from agg_hash_1)

-- sqlfmt-corpus-separator --

(select * from agg_hash_2 except select * from agg_group_2)
  union all
(select * from agg_group_2 except select * from agg_hash_2)

-- sqlfmt-corpus-separator --

(select * from agg_hash_3 except select * from agg_group_3)
  union all
(select * from agg_group_3 except select * from agg_hash_3)

-- sqlfmt-corpus-separator --

(select * from agg_hash_4 except select * from agg_group_4)
  union all
(select * from agg_group_4 except select * from agg_hash_4)

-- sqlfmt-corpus-separator --

(select * from gs_hash_1 except select * from gs_group_1)
  union all
(select * from gs_group_1 except select * from gs_hash_1)

-- sqlfmt-corpus-separator --

SELECT
    empno,
    depname,
    row_number() OVER (PARTITION BY depname ORDER BY enroll_date) rn,
    rank() OVER (PARTITION BY depname ORDER BY enroll_date ROWS BETWEEN
                 UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) rnk,
    count(*) OVER (PARTITION BY depname ORDER BY enroll_date RANGE BETWEEN
                   CURRENT ROW AND CURRENT ROW) cnt
FROM empsalary

-- sqlfmt-corpus-separator --

SELECT
    pg_catalog.pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relname', 'test',
        'relpages', 18::integer,
        'reltuples', 21::real,
        'relallvisible', 24::integer,
        'relallfrozen', 27::integer)

-- sqlfmt-corpus-separator --

SELECT  ctid, oprcom
FROM    pg_catalog.pg_operator fk
WHERE   oprcom != 0 AND
        NOT EXISTS(SELECT 1 FROM pg_catalog.pg_operator pk WHERE pk.oid = fk.oprcom)

-- sqlfmt-corpus-separator --

SELECT  ctid, oprnegate
FROM    pg_catalog.pg_operator fk
WHERE   oprnegate != 0 AND
        NOT EXISTS(SELECT 1 FROM pg_catalog.pg_operator pk WHERE pk.oid = fk.oprnegate)

-- sqlfmt-corpus-separator --

SELECT  thousand
		FROM onek WHERE thousand < 5
		ORDER BY thousand FETCH FIRST 1 ROW WITH TIES

-- sqlfmt-corpus-separator --

SELECT  thousand
		FROM onek WHERE thousand < 5
		ORDER BY thousand FETCH FIRST 2 ROW WITH TIES

-- sqlfmt-corpus-separator --

SELECT  thousand
		FROM onek WHERE thousand < 5
		ORDER BY thousand FETCH FIRST ROWS WITH TIES

-- sqlfmt-corpus-separator --

SELECT '    true   '::text::boolean AS true,
       '     FALSE'::text::boolean AS false

-- sqlfmt-corpus-separator --

SELECT '  tru e '::text::boolean AS invalid

-- sqlfmt-corpus-separator --

SELECT ''::text::"char"

-- sqlfmt-corpus-separator --

SELECT ''::text::boolean AS invalid

-- sqlfmt-corpus-separator --

SELECT '0/0'::pg_lsn + ('FFFFFFFF/FFFFFFFF'::pg_lsn - '0/0'::pg_lsn)

-- sqlfmt-corpus-separator --

SELECT '127.0.0.2'::inet  - ('127.0.0.2'::inet + 500)

-- sqlfmt-corpus-separator --

SELECT '127.0.0.2'::inet  - ('127.0.0.2'::inet - 500)

-- sqlfmt-corpus-separator --

SELECT '127::2'::inet  - ('127::2'::inet + 500)

-- sqlfmt-corpus-separator --

SELECT '127::2'::inet  - ('127::2'::inet - 500)

-- sqlfmt-corpus-separator --

SELECT '1912-01-01 00:00 MMT'::timestamptz AT TIME ZONE 'UTC'

-- sqlfmt-corpus-separator --

SELECT '19970210 173201' AT TIME ZONE 'America/New_York'

-- sqlfmt-corpus-separator --

SELECT '19970710 173201' AT TIME ZONE 'America/Does_not_exist'

-- sqlfmt-corpus-separator --

SELECT '19970710 173201' AT TIME ZONE 'America/New_York'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 21:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 21:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 22:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 22:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 22:59:59 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 22:59:59 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:00:01 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:00:01 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:59:59 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:59:59 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 00:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 00:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 00:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 00:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 01:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 01:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 01:59:59'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 01:59:59'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:00:01'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:00:01'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:59:59'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:59:59'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 03:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 03:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 03:00:01'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 03:00:01'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 04:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 04:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 21:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 21:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 21:59:59 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 21:59:59 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 22:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 22:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 22:00:01 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 22:00:01 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 23:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 23:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 00:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 00:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 00:59:59'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 00:59:59'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 01:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 01:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 01:00:01'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 01:00:01'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 02:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 02:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '3.4'::numeric UNION SELECT 'foo'

-- sqlfmt-corpus-separator --

SELECT '878.08'::money / 11::bigint

-- sqlfmt-corpus-separator --

SELECT '878.08'::money / 11::int

-- sqlfmt-corpus-separator --

SELECT '878.08'::money / 11::smallint

-- sqlfmt-corpus-separator --

SELECT '90000000000000099.00'::money / 10::bigint

-- sqlfmt-corpus-separator --

SELECT '90000000000000099.00'::money / 10::int

-- sqlfmt-corpus-separator --

SELECT '90000000000000099.00'::money / 10::smallint

-- sqlfmt-corpus-separator --

SELECT 'FFFFFFFF/FFFFFFFF'::pg_lsn - ('FFFFFFFF/FFFFFFFF'::pg_lsn - '0/0'::pg_lsn)

-- sqlfmt-corpus-separator --

SELECT 'TrUe'::text::boolean AS true, 'fAlse'::text::boolean AS false

-- sqlfmt-corpus-separator --

SELECT '\000'::"char"::text

-- sqlfmt-corpus-separator --

SELECT '\101'::"char"

-- sqlfmt-corpus-separator --

SELECT '\377'::"char"

-- sqlfmt-corpus-separator --

SELECT '\377'::"char"::text

-- sqlfmt-corpus-separator --

SELECT '\377'::text::"char"

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::text

-- sqlfmt-corpus-separator --

SELECT 'a'::text::"char"

-- sqlfmt-corpus-separator --

SELECT 'a_c'::bytea LIKE 'a$__'::bytea ESCAPE '$'::bytea AS "true"

-- sqlfmt-corpus-separator --

SELECT 'a_c'::bytea NOT LIKE 'a$__'::bytea ESCAPE '$'::bytea AS "false"

-- sqlfmt-corpus-separator --

SELECT 'abcd%' SIMILAR TO '_bcd#%' ESCAPE '#' AS true

-- sqlfmt-corpus-separator --

SELECT 'abcd\efg' SIMILAR TO '_bcd\%' ESCAPE '' AS true

-- sqlfmt-corpus-separator --

SELECT 'abcdefg' SIMILAR TO '_bcd#%' ESCAPE '##' AS error

-- sqlfmt-corpus-separator --

SELECT 'abcdefg' SIMILAR TO '_bcd#%' ESCAPE '#' AS false

-- sqlfmt-corpus-separator --

SELECT 'abcdefg' SIMILAR TO '_bcd%' AS true

-- sqlfmt-corpus-separator --

SELECT 'abcdefg' SIMILAR TO '_bcd%' ESCAPE NULL AS null

-- sqlfmt-corpus-separator --

SELECT 'abcdefg' SIMILAR TO '_bcd\%' AS false

-- sqlfmt-corpus-separator --

SELECT 'abcdefg' SIMILAR TO 'bcd%' AS false

-- sqlfmt-corpus-separator --

SELECT 'be_r' LIKE '__e__r' ESCAPE '_' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'be_r' LIKE 'b_e__r' ESCAPE '_' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'be_r' NOT LIKE '__e__r' ESCAPE '_' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'be_r' NOT LIKE 'b_e__r' ESCAPE '_' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'bear' LIKE 'b_ear' ESCAPE '_' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'bear' NOT LIKE 'b_ear' ESCAPE '_' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'h%' LIKE 'h#%' ESCAPE '#' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'h%' NOT LIKE 'h#%' ESCAPE '#' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'h%awkeye' LIKE 'h#%a%k%e' ESCAPE '#' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'h%awkeye' NOT LIKE 'h#%a%k%e' ESCAPE '#' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'h%wkeye' LIKE 'h#%%' ESCAPE '#' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'h%wkeye' LIKE 'h#%' ESCAPE '#' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'h%wkeye' NOT LIKE 'h#%%' ESCAPE '#' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'h%wkeye' NOT LIKE 'h#%' ESCAPE '#' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' LIKE 'h%' ESCAPE '#' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' NOT LIKE 'h%' ESCAPE '#' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'i_dio' LIKE 'i$_d%o' ESCAPE '$' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'i_dio' LIKE 'i$_d_o' ESCAPE '$' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'i_dio' LIKE 'i$_nd_o' ESCAPE '$' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'i_dio' NOT LIKE 'i$_d%o' ESCAPE '$' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'i_dio' NOT LIKE 'i$_d_o' ESCAPE '$' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'i_dio' NOT LIKE 'i$_nd_o' ESCAPE '$' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'indio' LIKE '_ndio' ESCAPE '$' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'indio' LIKE 'ind_o' ESCAPE '$' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'indio' NOT LIKE '_ndio' ESCAPE '$' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'indio' NOT LIKE 'ind_o' ESCAPE '$' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'ma%a' LIKE 'm%a%%a' ESCAPE '%' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'ma%a' NOT LIKE 'm%a%%a' ESCAPE '%' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'maca' LIKE 'm%aca' ESCAPE '%' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'maca' NOT LIKE 'm%aca' ESCAPE '%' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'red' = ALL ('{red,green,blue}'::rainbow[])

-- sqlfmt-corpus-separator --

SELECT 'red' = ALL ('{red,red}'::rainbow[])

-- sqlfmt-corpus-separator --

SELECT 'red' = ANY ('{red,green,blue}'::rainbow[])

-- sqlfmt-corpus-separator --

SELECT 'yellow' = ANY ('{red,green,blue}'::rainbow[])

-- sqlfmt-corpus-separator --

SELECT '{1,null,3}'::int[]

-- sqlfmt-corpus-separator --

SELECT ('"'||repeat('.', 12)||'abc"')::json

-- sqlfmt-corpus-separator --

SELECT ('"'||repeat('.', 12)||'abc\n"')::json

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat(' ', 32))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat('!', 32))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat('/', 34))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat('0', 34))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat('9', 32))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat(':', 32))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat('@', 34))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat('A', 34))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat('F', 32))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat('G', 32))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat('`', 34))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat('a', 34))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat('f', 32))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat('g', 32))::bytea

-- sqlfmt-corpus-separator --

SELECT ('\x' || repeat('~', 34))::bytea

-- sqlfmt-corpus-separator --

SELECT (((SELECT 2)) UNION SELECT 2)

-- sqlfmt-corpus-separator --

SELECT ((-1::int2<<15)+1::int2)::text

-- sqlfmt-corpus-separator --

SELECT ((-1::int4<<31)+1)::text

-- sqlfmt-corpus-separator --

SELECT ((-1::int8<<63)+1)::text

-- sqlfmt-corpus-separator --

SELECT ((SELECT 2) UNION SELECT 2)

-- sqlfmt-corpus-separator --

SELECT (-12345678901234567)::int8::money

-- sqlfmt-corpus-separator --

SELECT (-12345678901234567)::money

-- sqlfmt-corpus-separator --

SELECT (-12345678901234567)::numeric::money

-- sqlfmt-corpus-separator --

SELECT (-1::int2<<15)::text

-- sqlfmt-corpus-separator --

SELECT (-1::int4<<31)::text

-- sqlfmt-corpus-separator --

SELECT (-1::int8<<63)::text

-- sqlfmt-corpus-separator --

SELECT (-2147483648)::int4 % (-1)::int2

-- sqlfmt-corpus-separator --

SELECT (-2147483648)::int4 % (-1)::int4

-- sqlfmt-corpus-separator --

SELECT (-2147483648)::int4 * (-1)::int2

-- sqlfmt-corpus-separator --

SELECT (-2147483648)::int4 * (-1)::int4

-- sqlfmt-corpus-separator --

SELECT (-2147483648)::int4 / (-1)::int2

-- sqlfmt-corpus-separator --

SELECT (-2147483648)::int4 / (-1)::int4

-- sqlfmt-corpus-separator --

SELECT (-2147483648.4)::int4

-- sqlfmt-corpus-separator --

SELECT (-2147483648.5)::int4

-- sqlfmt-corpus-separator --

SELECT (-32768.4)::int2

-- sqlfmt-corpus-separator --

SELECT (-32768.5)::int2

-- sqlfmt-corpus-separator --

SELECT (-9223372036854775808)::int8 % (-1)::int2

-- sqlfmt-corpus-separator --

SELECT (-9223372036854775808)::int8 % (-1)::int4

-- sqlfmt-corpus-separator --

SELECT (-9223372036854775808)::int8 % (-1)::int8

-- sqlfmt-corpus-separator --

SELECT (-9223372036854775808)::int8 * (-1)::int2

-- sqlfmt-corpus-separator --

SELECT (-9223372036854775808)::int8 * (-1)::int4

-- sqlfmt-corpus-separator --

SELECT (-9223372036854775808)::int8 * (-1)::int8

-- sqlfmt-corpus-separator --

SELECT (-9223372036854775808)::int8 / (-1)::int2

-- sqlfmt-corpus-separator --

SELECT (-9223372036854775808)::int8 / (-1)::int4

-- sqlfmt-corpus-separator --

SELECT (-9223372036854775808)::int8 / (-1)::int8

-- sqlfmt-corpus-separator --

SELECT (-9223372036854775808.4)::int8

-- sqlfmt-corpus-separator --

SELECT (-9223372036854775808.5)::int8

-- sqlfmt-corpus-separator --

SELECT (2 + 2) / 2 AS two

-- sqlfmt-corpus-separator --

SELECT (count(*) OVER (PARTITION BY four ORDER BY ten) +
  sum(hundred) OVER (PARTITION BY four ORDER BY ten))::varchar AS cntsum
  FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT (time '00:00', interval '1 hour')
  OVERLAPS (time '00:30', interval '1 hour') AS "True"

-- sqlfmt-corpus-separator --

SELECT (time '00:00', interval '1 hour')
  OVERLAPS (time '01:30', interval '1 day') AS "False"

-- sqlfmt-corpus-separator --

SELECT (time '00:00', interval '1 hour')
  OVERLAPS (time '01:30', interval '1 hour') AS "False"

-- sqlfmt-corpus-separator --

SELECT (time '00:00', time '01:00')
  OVERLAPS (time '00:30', time '01:30') AS "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp with time zone '2000-11-26', timestamp with time zone '2000-11-27')
  OVERLAPS (timestamp with time zone '2000-11-27 12:00', timestamp with time zone '2000-11-30') AS "False"

-- sqlfmt-corpus-separator --

SELECT (timestamp with time zone '2000-11-27', interval '12 hours')
  OVERLAPS (timestamp with time zone '2000-11-27 12:00', interval '12 hours') AS "False"

-- sqlfmt-corpus-separator --

SELECT (timestamp with time zone '2000-11-27', interval '12 hours')
  OVERLAPS (timestamp with time zone '2000-11-27 12:00', timestamp with time zone '2000-11-30') AS "False"

-- sqlfmt-corpus-separator --

SELECT (timestamp with time zone '2000-11-27', interval '12 hours')
  OVERLAPS (timestamp with time zone '2000-11-27', interval '12 hours') AS "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp with time zone '2000-11-27', timestamp with time zone '2000-11-28')
  OVERLAPS (timestamp with time zone '2000-11-27 12:00', interval '1 day') AS "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp with time zone '2000-11-27', timestamp with time zone '2000-11-28')
  OVERLAPS (timestamp with time zone '2000-11-27 12:00', timestamp with time zone '2000-11-30') AS "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp with time zone 'today' = (timestamp with time zone 'tomorrow' - interval '1 day')) as "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp with time zone 'today' = (timestamp with time zone 'yesterday' + interval '1 day')) as "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp with time zone 'tomorrow' = (timestamp with time zone 'yesterday' + interval '2 days')) as "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp with time zone 'tomorrow' > 'now') as "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone '10:30 today' = (timestamp without time zone 'yesterday' + interval '1 day 10 hr 30 min')) as "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone '12:34:56 yesterday' = (timestamp without time zone 'tomorrow' - interval '2 days - 12:34:56')) as "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone '16:00:00 tomorrow' = (timestamp without time zone 'today' + interval '1 day 16 hours')) as "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone '2000-11-26', timestamp without time zone '2000-11-27')
  OVERLAPS (timestamp without time zone '2000-11-27 12:00', timestamp without time zone '2000-11-30') AS "False"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone '2000-11-27', interval '12 hours')
  OVERLAPS (timestamp without time zone '2000-11-27 12:00', interval '12 hours') AS "False"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone '2000-11-27', interval '12 hours')
  OVERLAPS (timestamp without time zone '2000-11-27 12:00', timestamp without time zone '2000-11-30') AS "False"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone '2000-11-27', interval '12 hours')
  OVERLAPS (timestamp without time zone '2000-11-27', interval '12 hours') AS "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone '2000-11-27', timestamp without time zone '2000-11-28')
  OVERLAPS (timestamp without time zone '2000-11-27 12:00', interval '1 day') AS "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone '2000-11-27', timestamp without time zone '2000-11-28')
  OVERLAPS (timestamp without time zone '2000-11-27 12:00', timestamp without time zone '2000-11-30') AS "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone 'today 10:30' = (timestamp without time zone 'yesterday' + interval '1 day 10 hr 30 min')) as "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone 'today' = (timestamp without time zone 'tomorrow' - interval '1 day')) as "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone 'today' = (timestamp without time zone 'yesterday' + interval '1 day')) as "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone 'tomorrow 16:00:00' = (timestamp without time zone 'today' + interval '1 day 16 hours')) as "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone 'tomorrow' = (timestamp without time zone 'yesterday' + interval '2 days')) as "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone 'tomorrow' > 'now') as "True"

-- sqlfmt-corpus-separator --

SELECT (timestamp without time zone 'yesterday 12:34:56' = (timestamp without time zone 'tomorrow' - interval '2 days - 12:34:56')) as "True"

-- sqlfmt-corpus-separator --

SELECT *
   INTO TABLE ramp
   FROM ONLY road
   WHERE name ~ '.*Ramp'

-- sqlfmt-corpus-separator --

SELECT *
   INTO TABLE sitmp1
   FROM onek
   WHERE onek.unique1 < 2

-- sqlfmt-corpus-separator --

SELECT *
   INTO TABLE sitmp1
   FROM onek2
   WHERE onek2.unique1 < 2

-- sqlfmt-corpus-separator --

SELECT *
  FROM J1_TBL AS t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT *
  FROM J1_TBL t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT *
  FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)

-- sqlfmt-corpus-separator --

SELECT * FROM INT2_TBL AS f(a, b)

-- sqlfmt-corpus-separator --

SELECT * FROM atest1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM atest1 WHERE ( b IN ( SELECT col1 FROM atest2 ) )

-- sqlfmt-corpus-separator --

SELECT * FROM atest2 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM atest2 WHERE ( col1 IN ( SELECT b FROM atest1 ) )

-- sqlfmt-corpus-separator --

SELECT * FROM clstr_1 UNION ALL
  SELECT * FROM clstr_2 UNION ALL
  SELECT * FROM clstr_3

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test10 WHERE (x COLLATE "POSIX", y COLLATE "C") NOT IN (SELECT y, x FROM collate_test10)

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test10 WHERE (x, y) NOT IN (SELECT y, x FROM collate_test10)

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_tvvm FOR SHARE

-- sqlfmt-corpus-separator --

SELECT * FROM not_null_tab
WHERE id NOT IN (SELECT id FROM notnull_notvalid_tab)

-- sqlfmt-corpus-separator --

SELECT * FROM onek EXCEPT ALL SELECT * FROM onek_copy

-- sqlfmt-corpus-separator --

SELECT * FROM onek_copy EXCEPT ALL SELECT * FROM onek

-- sqlfmt-corpus-separator --

SELECT * FROM outer_text WHERE (f1, f2) NOT IN (SELECT * FROM inner_text)

-- sqlfmt-corpus-separator --

SELECT * FROM pg_enum WHERE NOT EXISTS
  (SELECT 1 FROM pg_type WHERE pg_type.oid = enumtypid)

-- sqlfmt-corpus-separator --

SELECT * FROM pxtest_rowlock WHERE id = 1 FOR SHARE

-- sqlfmt-corpus-separator --

SELECT * FROM pxtest_rowlock WHERE id = 1 FOR UPDATE NOWAIT

-- sqlfmt-corpus-separator --

SELECT * FROM rls_test_src FOR KEY SHARE

-- sqlfmt-corpus-separator --

SELECT * FROM rls_test_src FOR NO KEY UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM rls_test_src FOR SHARE

-- sqlfmt-corpus-separator --

SELECT * FROM rls_test_src FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM rw_view1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM rw_view2 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND (j1.a*j1.c/3) = (random()/3 + 3)::int
  AND (random()/3 + 3)::int = (j2.a*j2.c/3)

-- sqlfmt-corpus-separator --

SELECT * FROM t1 FOR SHARE

-- sqlfmt-corpus-separator --

SELECT * FROM t1 WHERE f_leak(b) FOR SHARE

-- sqlfmt-corpus-separator --

SELECT * FROM tenk1
  WHERE thousand = 42 AND (tenthous = 1 OR tenthous = (SELECT 1 + 2) OR tenthous = 42)

-- sqlfmt-corpus-separator --

SELECT * FROM tenk1
  WHERE thousand = 42 AND (tenthous = 1 OR tenthous = 3 OR tenthous = 42 OR tenthous = 0)

-- sqlfmt-corpus-separator --

SELECT * FROM tenk1
  WHERE thousand = 42 AND (tenthous = 1 OR tenthous = 3 OR tenthous = 42)

-- sqlfmt-corpus-separator --

SELECT * FROM testcase WHERE id = 1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM testcase WHERE testcase.id = 1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM truncate_a
   UNION ALL
 SELECT * FROM trunc_c
   UNION ALL
 SELECT * FROM trunc_b
   UNION ALL
 SELECT * FROM trunc_d

-- sqlfmt-corpus-separator --

SELECT * INTO cmmove1 FROM cmdata

-- sqlfmt-corpus-separator --

SELECT * INTO cmmove1 FROM cmdata_lz4

-- sqlfmt-corpus-separator --

SELECT * INTO result FROM partitioned_table WHERE a = a_val

-- sqlfmt-corpus-separator --

SELECT * INTO t4 FROM t1

-- sqlfmt-corpus-separator --

SELECT -f1,
    EXTRACT(MICROSECOND FROM -f1) AS MICROSECOND,
    EXTRACT(MILLISECOND FROM -f1) AS MILLISECOND,
    EXTRACT(SECOND FROM -f1) AS SECOND,
    EXTRACT(MINUTE FROM -f1) AS MINUTE,
    EXTRACT(HOUR FROM -f1) AS HOUR,
    EXTRACT(DAY FROM -f1) AS DAY,
    EXTRACT(WEEK FROM -f1) AS WEEK,
    EXTRACT(MONTH FROM -f1) AS MONTH,
    EXTRACT(QUARTER FROM -f1) AS QUARTER,
    EXTRACT(YEAR FROM -f1) AS YEAR,
    EXTRACT(DECADE FROM -f1) AS DECADE,
    EXTRACT(CENTURY FROM -f1) AS CENTURY,
    EXTRACT(MILLENNIUM FROM -f1) AS MILLENNIUM,
    EXTRACT(EPOCH FROM -f1) AS EPOCH
    FROM INTERVAL_TBL

-- sqlfmt-corpus-separator --

SELECT 0::boolean

-- sqlfmt-corpus-separator --

SELECT 1 AS one UNION SELECT 1 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS one UNION SELECT 1.0::float8 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS one WHERE 1 IN (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 AS three UNION SELECT 2 UNION ALL SELECT 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS three UNION SELECT 2 UNION SELECT 3 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS two UNION ALL SELECT 1

-- sqlfmt-corpus-separator --

SELECT 1 AS two UNION ALL SELECT 2

-- sqlfmt-corpus-separator --

SELECT 1 AS two UNION SELECT 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS two UNION SELECT 2 UNION SELECT 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS two UNION SELECT 2.2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1 AS zero WHERE 1 IN (SELECT 2)

-- sqlfmt-corpus-separator --

SELECT 1 AS zero WHERE 1 NOT IN (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 IS DISTINCT FROM 2 as "yes"

-- sqlfmt-corpus-separator --

SELECT 1 IS NOT DISTINCT FROM 2 as "no"

-- sqlfmt-corpus-separator --

SELECT 1.0::float8 AS two UNION ALL SELECT 1 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1 AS three UNION SELECT 2 UNION ALL SELECT 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1 AS three UNION SELECT 2 UNION SELECT 3 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1 AS two UNION (SELECT 2 UNION ALL SELECT 2) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1 AS two UNION ALL SELECT 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1 AS two UNION SELECT 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1 AS two UNION SELECT 2.2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1.1::float8 AS two UNION SELECT 2 UNION SELECT 2.0::float8 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT 1::boolean

-- sqlfmt-corpus-separator --

SELECT 2 IS DISTINCT FROM 2 as "no"

-- sqlfmt-corpus-separator --

SELECT 2 IS DISTINCT FROM null as "yes"

-- sqlfmt-corpus-separator --

SELECT 2 IS NOT DISTINCT FROM 2 as "yes"

-- sqlfmt-corpus-separator --

SELECT 2 IS NOT DISTINCT FROM null as "no"

-- sqlfmt-corpus-separator --

SELECT 2::boolean

-- sqlfmt-corpus-separator --

SELECT ARRAY(select f2 from arrtest_f order by f2) AS "ARRAY"

-- sqlfmt-corpus-separator --

SELECT CAST(f1 AS char(4)) AS three FROM VARCHAR_TBL
UNION
SELECT f1 FROM CHAR_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT COUNT(*) OVER w FROM tenk1 WHERE unique2 < 10 WINDOW w AS ()

-- sqlfmt-corpus-separator --

SELECT COUNT(a), COUNT(1) FILTER(WHERE a=1) FROM heapmv

-- sqlfmt-corpus-separator --

SELECT COUNT(a), COUNT(1) FILTER(WHERE a=1) FROM heaptable

-- sqlfmt-corpus-separator --

SELECT COUNT(id) FROM xmltest WHERE xmlexists('/menu/beer' PASSING BY REF data BY REF)

-- sqlfmt-corpus-separator --

SELECT COUNT(id) FROM xmltest WHERE xmlexists('/menu/beer' PASSING data)

-- sqlfmt-corpus-separator --

SELECT COUNT(id) FROM xmltest WHERE xmlexists('/menu/beers' PASSING BY REF data)

-- sqlfmt-corpus-separator --

SELECT COUNT(id) FROM xmltest WHERE xmlexists('/menu/beers/name[text() = ''Molson'']' PASSING BY REF data)

-- sqlfmt-corpus-separator --

SELECT COUNT(id) FROM xmltest, query WHERE xmlexists(expr PASSING BY REF data)

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (string4) string4, two, ten
   FROM onek
   ORDER BY string4 using <, two using >, ten using <

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (string4, ten) string4, ten, two
   FROM onek
   ORDER BY string4 using <, ten using >, two using <

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (string4, ten) string4, two, ten
   FROM onek
   ORDER BY string4 using <, two using <, ten using <

-- sqlfmt-corpus-separator --

SELECT DISTINCT f1 AS two FROM TEMP_GROUP ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT four FROM tenk1

-- sqlfmt-corpus-separator --

SELECT DISTINCT four FROM tenk1 WHERE four = 0

-- sqlfmt-corpus-separator --

SELECT DISTINCT four FROM tenk1 WHERE four = 0 AND two <> 0

-- sqlfmt-corpus-separator --

SELECT DISTINCT four,1,2,3 FROM tenk1 WHERE four = 0

-- sqlfmt-corpus-separator --

SELECT DISTINCT hobbies_r.name, name(hobbies_r.equipment) FROM hobbies_r
  ORDER BY 1,2

-- sqlfmt-corpus-separator --

SELECT DISTINCT o1.oprname AS op1, o2.oprname AS op2
FROM pg_operator o1, pg_operator o2
WHERE o1.oprcom = o2.oid AND o1.oprname <= o2.oprname
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT o1.oprname AS op1, o2.oprname AS op2
FROM pg_operator o1, pg_operator o2
WHERE o1.oprnegate = o2.oid AND o1.oprname <= o2.oprname
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.prorettype::regtype, p2.prorettype::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    p1.prosrc NOT LIKE E'range\\_constructor_' AND
    p2.prosrc NOT LIKE E'range\\_constructor_' AND
    p1.prosrc NOT LIKE E'multirange\\_constructor_' AND
    p2.prosrc NOT LIKE E'multirange\\_constructor_' AND
    (p1.prorettype < p2.prorettype)
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT proname, oprname
FROM pg_operator AS o, pg_aggregate AS a, pg_proc AS p
WHERE a.aggfnoid = p.oid AND a.aggsortop = o.oid
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT proname, oprname, amopstrategy
FROM pg_operator AS o, pg_aggregate AS a, pg_proc AS p,
     pg_amop as ao
WHERE a.aggfnoid = p.oid AND a.aggsortop = o.oid AND
    amopopr = o.oid AND
    amopmethod = (SELECT oid FROM pg_am WHERE amname = 'btree')
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT x FROM test3bpci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT x FROM test3ci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT x FROM test3cs ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, x FROM distinct_tbl

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, x FROM distinct_tbl ORDER BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, x FROM distinct_tbl limit 10

-- sqlfmt-corpus-separator --

SELECT EXISTS (
SELECT 1
FROM pg_class
WHERE oid = 'vacuum_in_leader_small_index'::regclass AND
  pg_relation_size(oid) <
  pg_size_bytes(current_setting('min_parallel_index_scan_size'))
) as leader_will_handle_small_index

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY       FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY    FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '0001-01-01 AD')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '0001-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '0001-12-31 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '0100-12-31 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '0101-12-31 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '1900-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '1901-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '2001-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM INTERVAL '-100 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM INTERVAL '-99 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM INTERVAL '100 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM INTERVAL '99 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY           FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY           FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY         FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY         FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY FROM DATE '-infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE        FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE     FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '0001-01-01 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '0002-12-31 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '0009-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '0010-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '0011-01-01 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '0012-12-31 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '1994-12-25')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM INTERVAL '-100 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM INTERVAL '-99 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM INTERVAL '100 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM INTERVAL '99 y')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOW           FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOW           FROM DATE '2020-08-16')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOW           FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOY           FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOY           FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH         FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH       FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH       FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH      FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH FROM DATE        '1970-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH FROM DATE '-infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(FORTNIGHT   FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(FORTNIGHT   FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(FORTNIGHT FROM INTERVAL '2 days')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(HOUR          FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(HOUR        FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(HOUR        FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISODOW        FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISODOW        FROM DATE '2020-08-16')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISODOW        FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISOYEAR       FROM DATE '2020-08-11 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISOYEAR       FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISOYEAR    FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(JULIAN        FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(JULIAN     FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MICROSEC  FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MICROSECOND FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MICROSECOND FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MICROSECONDS  FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM    FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '0001-01-01 AD')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '0001-12-31 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '1000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '1001-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '2001-01-01')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLISECOND FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLISECOND FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLISECONDS  FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MINUTE        FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MINUTE      FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MINUTE      FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MONTH         FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MONTH         FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(QUARTER       FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(QUARTER       FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(SECOND        FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(SECOND      FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(SECOND      FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE      FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE    FROM TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE    FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04:30')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE FROM INTERVAL '2 days')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE_H    FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE_HOUR   FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04:30')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE_M    FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(TIMEZONE_MINUTE FROM TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04:30')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(WEEK          FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(WEEK          FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(YEAR          FROM DATE '2020-08-11 BC')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(YEAR          FROM DATE '2020-08-11')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(YEAR       FROM DATE 'infinity')

-- sqlfmt-corpus-separator --

SELECT INTO tableam_tblselectinto_heapx FROM tableam_tbl_heapx

-- sqlfmt-corpus-separator --

SELECT JSON_SCALAR(NULL::int)

-- sqlfmt-corpus-separator --

SELECT NULL::text[]::int[] AS "NULL"

-- sqlfmt-corpus-separator --

SELECT OVERLAY('abcdef' PLACING '45' FROM 4) AS "abc45f"

-- sqlfmt-corpus-separator --

SELECT OVERLAY('babosa' PLACING 'ubb' FROM 2 FOR 4) AS "bubba"

-- sqlfmt-corpus-separator --

SELECT OVERLAY('yabadoo' PLACING 'daba' FROM 5 FOR 0) AS "yabadabadoo"

-- sqlfmt-corpus-separator --

SELECT OVERLAY('yabadoo' PLACING 'daba' FROM 5) AS "yabadaba"

-- sqlfmt-corpus-separator --

SELECT POSITION(B'' IN B'')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'' IN B'00001010')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'0' IN B'')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'0000000000011101011111010110' IN B'000000000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'000000000011101011111010110' IN B'000000000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'00000000011101011111010110' IN B'000000000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1010' IN B'00000101')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1010' IN B'000001010')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1010' IN B'0000101')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1010' IN B'00001010')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'101101' IN B'001011011011011000')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'10110110' IN B'001011011011010')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1011011011011' IN B'00001011011011011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1011011011011' IN B'001011011011011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1101' IN b),
       POSITION(B'11011' IN b),
       b
       FROM BIT_SHIFT_TABLE

-- sqlfmt-corpus-separator --

SELECT POSITION(B'1101' IN v),
       POSITION(B'11011' IN v),
       v
       FROM VARBIT_SHIFT_TABLE

-- sqlfmt-corpus-separator --

SELECT POSITION(B'11101011' IN B'0000011101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'11101011' IN B'00011101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'11101011' IN B'011101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'11101011' IN B'11101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'00000000001110101111101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'000000000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'000000001110101111101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'0000000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'0000001110101111101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'00000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'0000011101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'00000111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'000001110101111101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'0000011101011111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'00011101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'000111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'011101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'0111010110')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'11101011')

-- sqlfmt-corpus-separator --

SELECT POSITION(B'111010110' IN B'111010110')

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('01010101'::bit(8) FROM -10 FOR -2147483646) AS "error"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('01010101'::varbit FROM -10 FOR -2147483646) AS "error"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('a' SIMILAR U&'\00AC' ESCAPE U&'\00A7')

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('abcdefg' FROM 'a#"(b_d)#"%' FOR '#') AS "bcd"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('abcdefg' FROM 'b(.*)f') AS "cde"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('abcdefg' FROM 'c.e') AS "cde"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('abcdefg' SIMILAR 'a#"%#"g' ESCAPE '#') AS "bcdef"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('abcdefg' SIMILAR 'a#"%#"x|g' ESCAPE '#') AS "bcdef"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('abcdefg' SIMILAR 'a#"%g' ESCAPE '#') AS "bcdefg"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('abcdefg' SIMILAR 'a#"%|ab#"g' ESCAPE '#') AS "bcdef"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('abcdefg' SIMILAR 'a#"(b_d)#"%' ESCAPE '#') AS "bcd"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('abcdefg' SIMILAR 'a%g' ESCAPE '#') AS "abcdefg"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('abcdefg' SIMILAR 'a*#"%#"g*#"x' ESCAPE '#') AS "error"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('abcdefg' SIMILAR 'a*#"%#"g*' ESCAPE '#') AS "abcdefg"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('abcdefg' SIMILAR 'a|b#"%#"g' ESCAPE '#') AS "bcdef"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('string' FROM -10 FOR -2147483646) AS "error"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('string' FROM -10 FOR 2147483646) AS "string"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('string' FROM 2 FOR 2147483646) AS "tring"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('string'::bytea FROM -10 FOR -2147483646) AS "error"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('string'::bytea FROM -10 FOR 2147483646) AS "string"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING('string'::bytea FROM 2 FOR 2147483646) AS "tring"

-- sqlfmt-corpus-separator --

SELECT SUBSTRING(c FROM 1 FOR 1) FROM toast_3b_utf8

-- sqlfmt-corpus-separator --

SELECT SUBSTRING(c FROM 3000 FOR 1) FROM toast_4b_utf8

-- sqlfmt-corpus-separator --

SELECT SUBSTRING(c FROM 4000 FOR 1) FROM toast_3b_utf8

-- sqlfmt-corpus-separator --

SELECT SUBSTRING(c FROM 4001 FOR 1) FROM toast_3b_utf8

-- sqlfmt-corpus-separator --

SELECT U&'\00E4\24D1c' IS NFC NORMALIZED AS test_nfc

-- sqlfmt-corpus-separator --

SELECT U&'\00E4\24D1c' IS NORMALIZED AS test_default

-- sqlfmt-corpus-separator --

SELECT a, b COLLATE "C" FROM collate_test1 UNION SELECT a, b FROM collate_test2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b COLLATE "C" FROM collate_test1 UNION SELECT a, b FROM collate_test3 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test1 EXCEPT SELECT a, b FROM collate_test2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test1 EXCEPT SELECT a, b FROM collate_test3 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test1 INTERSECT SELECT a, b FROM collate_test2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test1 INTERSECT SELECT a, b FROM collate_test3 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test1 UNION ALL SELECT a, b FROM collate_test1 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test1 UNION ALL SELECT a, b FROM collate_test2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test1 UNION ALL SELECT a, b FROM collate_test2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test1 UNION ALL SELECT a, b FROM collate_test3

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test1 UNION ALL SELECT a, b FROM collate_test3 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test1 UNION SELECT a, b FROM collate_test2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test1 UNION SELECT a, b FROM collate_test3 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test2 EXCEPT SELECT a, b FROM collate_test2 WHERE a < 2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test2 UNION SELECT a, b FROM collate_test2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test2 WHERE a < 4 INTERSECT SELECT a, b FROM collate_test2 WHERE a > 1 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test3 EXCEPT SELECT a, b FROM collate_test3 WHERE a < 2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test3 WHERE a < 4 INTERSECT SELECT a, b FROM collate_test3 WHERE a > 1 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b, tableoid::regclass FROM t2 UNION ALL SELECT a, b, tableoid::regclass FROM t3

-- sqlfmt-corpus-separator --

SELECT a, c, sum(b), avg(c), count(*) FROM pagg_tab_m GROUP BY (a+b)/2, 2, 1 HAVING sum(b) = 50 AND avg(c) > 25 ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT a, lower(nullif(x, 'foo')), lower(nullif(y, 'foo')) FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT a, nullif(b, 'abc') FROM collate_test1 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, nullif(b, 'abc') FROM collate_test2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, nullif(b, 'abc') FROM collate_test3 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, sum(b), avg(c), count(*) FROM pagg_tab_m GROUP BY a, (a+b)/2 HAVING sum(b) < 50 ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT a,b,c,substring(d for 30), length(d) from clstr_tst

-- sqlfmt-corpus-separator --

SELECT a,b,c,substring(d for 30), length(d) from clstr_tst ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a,b,c,substring(d for 30), length(d) from clstr_tst ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a,b,c,substring(d for 30), length(d) from clstr_tst ORDER BY c

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid, a.aggcombinefn, a.aggserialfn, a.aggdeserialfn,
       b.aggfnoid, b.aggcombinefn, b.aggserialfn, b.aggdeserialfn
FROM
    pg_aggregate a, pg_aggregate b
WHERE
    a.aggfnoid < b.aggfnoid AND a.aggtransfn = b.aggtransfn AND
    (a.aggcombinefn != b.aggcombinefn OR a.aggserialfn != b.aggserialfn
     OR a.aggdeserialfn != b.aggdeserialfn)

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid::oid, o.oid
FROM pg_operator AS o, pg_aggregate AS a, pg_proc AS p
WHERE a.aggfnoid = p.oid AND a.aggsortop = o.oid AND
    NOT EXISTS(SELECT 1 FROM pg_amop
               WHERE amopmethod = (SELECT oid FROM pg_am WHERE amname = 'btree')
                     AND amopopr = o.oid
                     AND amoplefttype = o.oprleft
                     AND amoprighttype = o.oprright)

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid::oid, p.proname
FROM pg_aggregate as a, pg_proc as p
WHERE a.aggfnoid = p.oid AND
    (p.prokind != 'a' OR p.proretset OR p.pronargs < a.aggnumdirectargs)

-- sqlfmt-corpus-separator --

SELECT a.f1 FROM (SELECT 'test' AS f1 FROM varchar_tbl) a
UNION
SELECT b.f1 FROM (SELECT f1 FROM varchar_tbl) b
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT a1.amopfamily, a1.amopopr, o1.oid, o1.oprname
FROM pg_amop AS a1, pg_operator AS o1
WHERE a1.amopopr = o1.oid AND a1.amoppurpose = 's' AND
    (o1.oprrest = 0 OR o1.oprjoin = 0)

-- sqlfmt-corpus-separator --

SELECT a1.amopfamily, a1.amopstrategy
FROM pg_amop as a1
WHERE NOT ((a1.amoppurpose = 's' AND a1.amopsortfamily = 0) OR
           (a1.amoppurpose = 'o' AND a1.amopsortfamily <> 0))

-- sqlfmt-corpus-separator --

SELECT a1.amopfamily, a1.amopstrategy, a1.amopopr
FROM pg_amop AS a1
WHERE NOT EXISTS(SELECT 1 FROM pg_opclass AS c1
                 WHERE c1.opcfamily = a1.amopfamily
                   AND binary_coercible(c1.opcintype, a1.amoplefttype))

-- sqlfmt-corpus-separator --

SELECT a1.attrelid, a1.attname, t1.oid, t1.typname
FROM pg_attribute AS a1, pg_type AS t1
WHERE a1.atttypid = t1.oid AND
    (a1.attlen != t1.typlen OR
     a1.attalign != t1.typalign OR
     a1.attbyval != t1.typbyval OR
     (a1.attstorage != t1.typstorage AND a1.attstorage != 'p'))

-- sqlfmt-corpus-separator --

SELECT aggfnoid, aggtranstype, aggserialfn, aggdeserialfn
FROM pg_aggregate
WHERE (aggserialfn != 0 OR aggdeserialfn != 0)
  AND (aggtranstype != 'internal'::regtype OR aggcombinefn = 0 OR
       aggserialfn = 0 OR aggdeserialfn = 0)

-- sqlfmt-corpus-separator --

SELECT array_agg(a ORDER BY x COLLATE "C", y COLLATE "POSIX") FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT array_agg(a ORDER BY x||y) FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b) FROM collate_test1

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b) FROM collate_test2

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b) FROM collate_test3

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY guid_encoded COLLATE "C") FROM guid3

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY guid_field) FROM guid3

-- sqlfmt-corpus-separator --

SELECT array_dims(array_sample('[-1:2][2:3]={{1,2},{3,NULL},{5,6},{7,8}}'::int[], 3))

-- sqlfmt-corpus-separator --

SELECT array_dims(array_sample('{{{1,2},{3,NULL}},{{5,6},{7,8}},{{9,10},{11,12}}}'::int[], 2))

-- sqlfmt-corpus-separator --

SELECT array_dims(array_shuffle('[-1:2][2:3]={{1,2},{3,NULL},{5,6},{7,8}}'::int[]))

-- sqlfmt-corpus-separator --

SELECT array_dims(array_shuffle('{{{1,2},{3,NULL}},{{5,6},{7,8}},{{9,10},{11,12}}}'::int[]))

-- sqlfmt-corpus-separator --

SELECT array_length(array_sample('{1,2,3,4,5,6}'::int[], 3), 1)

-- sqlfmt-corpus-separator --

SELECT array_position('[2:4]={1,2,3}'::int[], 1)

-- sqlfmt-corpus-separator --

SELECT array_positions('[2:4]={1,2,3}'::int[], 1)

-- sqlfmt-corpus-separator --

SELECT array_positions(NULL, NULL::int)

-- sqlfmt-corpus-separator --

SELECT array_reverse('{1,2,3,NULL,4,5,6}'::int[])

-- sqlfmt-corpus-separator --

SELECT array_reverse('{1,2}'::int[])

-- sqlfmt-corpus-separator --

SELECT array_reverse('{1}'::int[])

-- sqlfmt-corpus-separator --

SELECT array_reverse('{{1,2},{3,4},{5,6},{7,8}}'::int[])

-- sqlfmt-corpus-separator --

SELECT array_reverse('{}'::int[])

-- sqlfmt-corpus-separator --

SELECT array_sample('{1,2,3,4,5,6}'::int[], -1)

-- sqlfmt-corpus-separator --

SELECT array_sample('{1,2,3,4,5,6}'::int[], 3) <@ '{1,2,3,4,5,6}'

-- sqlfmt-corpus-separator --

SELECT array_sample('{1,2,3,4,5,6}'::int[], 7)

-- sqlfmt-corpus-separator --

SELECT array_shuffle('{1,2,3,4,5,6}'::int[]) <@ '{1,2,3,4,5,6}'

-- sqlfmt-corpus-separator --

SELECT array_shuffle('{1,2,3,4,5,6}'::int[]) @> '{1,2,3,4,5,6}'

-- sqlfmt-corpus-separator --

SELECT array_sort('{1,3,5,2,4,6}'::int[])

-- sqlfmt-corpus-separator --

SELECT array_sort('{1}'::int[])

-- sqlfmt-corpus-separator --

SELECT array_sort('{{1}}'::int[])

-- sqlfmt-corpus-separator --

SELECT array_sort('{}'::int[])

-- sqlfmt-corpus-separator --

SELECT array_sort(ARRAY(SELECT '1 4'::int2vector UNION ALL SELECT '1 2'::int2vector))

-- sqlfmt-corpus-separator --

SELECT array_to_json('{{1,5},{99,100}}'::int[])

-- sqlfmt-corpus-separator --

SELECT array_to_json(array(select 1 as a))

-- sqlfmt-corpus-separator --

SELECT b,
       SUBSTRING(b FROM 2 FOR 4) AS sub_2_4,
       SUBSTRING(b FROM 7 FOR 13) AS sub_7_13,
       SUBSTRING(b FROM 6) AS sub_6
       FROM BIT_TABLE

-- sqlfmt-corpus-separator --

SELECT c.oid::pg_catalog.regclass, c.relpersistence FROM pg_catalog.pg_class c WHERE c.oid = 't'::regclass

-- sqlfmt-corpus-separator --

SELECT c.relname, a.amname FROM pg_class c, pg_am a
  WHERE c.relam = a.oid AND
        c.relname LIKE 'am_partitioned%'
UNION ALL
SELECT c.relname, 'default' FROM pg_class c
  WHERE c.relam = 0
        AND c.relname LIKE 'am_partitioned%' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT c1.opcname, c1.opcfamily
FROM pg_opclass AS c1
WHERE NOT EXISTS(SELECT 1 FROM pg_amop AS a1
                 WHERE a1.amopfamily = c1.opcfamily
                   AND binary_coercible(c1.opcintype, a1.amoplefttype))

-- sqlfmt-corpus-separator --

SELECT castsource::regtype, casttarget::regtype, castfunc, castcontext
FROM pg_cast c
WHERE c.castmethod = 'b' AND
    NOT EXISTS (SELECT 1 FROM pg_cast k
                WHERE k.castmethod = 'b' AND
                    k.castsource = c.casttarget AND
                    k.casttarget = c.castsource)

-- sqlfmt-corpus-separator --

SELECT char 'c' = char 'c' AS true

-- sqlfmt-corpus-separator --

SELECT collation for ('foo')

-- sqlfmt-corpus-separator --

SELECT collation for ('foo'::text)

-- sqlfmt-corpus-separator --

SELECT collation for ((SELECT a FROM collate_test1 LIMIT 1))

-- sqlfmt-corpus-separator --

SELECT collation for ((SELECT b FROM collate_test1 LIMIT 1))

-- sqlfmt-corpus-separator --

SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'today'

-- sqlfmt-corpus-separator --

SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'tomorrow EST'

-- sqlfmt-corpus-separator --

SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'tomorrow zulu'

-- sqlfmt-corpus-separator --

SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'tomorrow'

-- sqlfmt-corpus-separator --

SELECT count(*) AS One FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp with time zone 'yesterday'

-- sqlfmt-corpus-separator --

SELECT count(*) AS two FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp(2) with time zone 'now'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM pg_class where relname = 'pubview'
AND relnamespace IN (SELECT OID FROM pg_namespace WHERE nspname = 'testviewschm2')

-- sqlfmt-corpus-separator --

SELECT count(*) FROM pg_class where relname LIKE 'mytempview'
And relnamespace IN (SELECT OID FROM pg_namespace WHERE nspname LIKE 'pg_temp%')

-- sqlfmt-corpus-separator --

SELECT count(*) FROM t WHERE i = 0 AND tab_id IN (SELECT tab_id FROM t WHERE i = 1)

-- sqlfmt-corpus-separator --

SELECT count(*) FROM t WHERE i = 15 AND g IN (SELECT g + 10 FROM t WHERE i = 5)

-- sqlfmt-corpus-separator --

SELECT count(*) FROM tenk1
  WHERE hundred = 42 AND (thousand < 42 OR thousand < 99 OR 43 > thousand OR 42 > thousand)

-- sqlfmt-corpus-separator --

SELECT count(*) FROM tenk1
  WHERE hundred = 42 AND (thousand = 42 OR thousand = 41 OR thousand = 99 AND tenthous = 2)

-- sqlfmt-corpus-separator --

SELECT count(*) FROM tenk1
  WHERE hundred = 42 AND (thousand = 42 OR thousand = 99 OR tenthous < 2) OR thousand = 41

-- sqlfmt-corpus-separator --

SELECT count(*) FROM tenk1
  WHERE hundred = 42 AND (thousand = 42 OR thousand = 99)

-- sqlfmt-corpus-separator --

SELECT count(*) FROM tenk1
  WHERE thousand = 42 AND (tenthous = 1 OR tenthous = 3) OR thousand = 41

-- sqlfmt-corpus-separator --

SELECT count(*) FROM test_tsvector WHERE a @@ any ('{wr,qh}')

-- sqlfmt-corpus-separator --

SELECT count(*) OVER w FROM tenk1 WINDOW w AS (ORDER BY unique1), w AS (ORDER BY unique1)

-- sqlfmt-corpus-separator --

SELECT count(b) FROM test_missing_target
	GROUP BY (b + 1) / 2 ORDER BY (b + 1) / 2 desc

-- sqlfmt-corpus-separator --

SELECT ctid, aggfnoid::oid
FROM pg_aggregate as a
WHERE aggmtranstype != 0 AND
    (aggmtransfn = 0 OR aggminvtransfn = 0)

-- sqlfmt-corpus-separator --

SELECT ctid,cmin,* FROM combocidtest FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT d.f1 AS "timestamp",
   timestamp with time zone '1980-01-06 00:00 GMT' AS gpstime_zero,
   d.f1 - timestamp with time zone '1980-01-06 00:00 GMT' AS difference
  FROM TEMP_TIMESTAMP d
  ORDER BY difference

-- sqlfmt-corpus-separator --

SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 != timestamp with time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 < timestamp with time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 <= timestamp with time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 = timestamp with time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 > timestamp with time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT d1 FROM TIMESTAMPTZ_TBL
   WHERE d1 >= timestamp with time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT d1 as "timestamp",
   extract(microseconds from d1) AS microseconds,
   extract(milliseconds from d1) AS milliseconds,
   extract(seconds from d1) AS seconds,
   round(extract(julian from d1)) AS julian,
   extract(epoch from d1) AS epoch
   FROM TIMESTAMPTZ_TBL

-- sqlfmt-corpus-separator --

SELECT d1 as "timestamp",
   extract(microseconds from d1) AS microseconds,
   extract(milliseconds from d1) AS milliseconds,
   extract(seconds from d1) AS seconds,
   round(extract(julian from d1)) AS julian,
   extract(epoch from d1) AS epoch
   FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT date '1994-01-01' + time '10:00' AS "Jan_01_1994_10am"

-- sqlfmt-corpus-separator --

SELECT date '1994-01-01' + time '11:00' AS "Jan_01_1994_11am"

-- sqlfmt-corpus-separator --

SELECT date '1994-01-01' + timetz '11:00-5' AS "Jan_01_1994_8am"

-- sqlfmt-corpus-separator --

SELECT date_bin('-2 days'::interval, timestamp with time zone '1970-01-01 01:00:00+00' , timestamp with time zone '1970-01-01 00:00:00+00')

-- sqlfmt-corpus-separator --

SELECT date_bin('0 days'::interval, timestamp with time zone '1970-01-01 01:00:00+00' , timestamp with time zone '1970-01-01 00:00:00+00')

-- sqlfmt-corpus-separator --

SELECT date_bin('5 months'::interval, timestamp with time zone '2020-02-01 01:01:01+00', timestamp with time zone '2001-01-01+00')

-- sqlfmt-corpus-separator --

SELECT date_bin('5 years'::interval,  timestamp with time zone '2020-02-01 01:01:01+00', timestamp with time zone '2001-01-01+00')

-- sqlfmt-corpus-separator --

SELECT date_part('epoch',       TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT date_part('microsecond', TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT date_part('millisecond', TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT date_part('second',      TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'ago', timestamp with time zone 'infinity' ) AS invalid_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'timezone', timestamp with time zone '2004-02-29 15:44:17.71393' ) AS notsupp_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'timezone', timestamp with time zone 'infinity' ) AS notsupp_inf_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'week', timestamp with time zone '2004-02-29 15:44:17.71393' ) AS week_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'week', timestamp with time zone 'infinity' ) AS inf_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'week', timestamp with time zone 'infinity', 'GMT') AS inf_zone_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc('ago', timestamp with time zone 'infinity', 'GMT') AS invalid_zone_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc('day', timestamp with time zone '2001-02-16 20:38:40+00', 'Australia/Sydney') as sydney_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc('day', timestamp with time zone '2001-02-16 20:38:40+00', 'GMT') as gmt_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc('day', timestamp with time zone '2001-02-16 20:38:40+00', 'VET') as vet_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc('timezone', timestamp with time zone 'infinity', 'GMT') AS notsupp_zone_trunc

-- sqlfmt-corpus-separator --

SELECT decode(encode(('\x' || repeat('1234567890abcdef0001', 7))::bytea,
                     'base64'), 'base64')

-- sqlfmt-corpus-separator --

SELECT depname, empno, salary, rank() OVER w FROM empsalary WINDOW w AS (PARTITION BY depname ORDER BY salary) ORDER BY rank() OVER w

-- sqlfmt-corpus-separator --

SELECT depname, empno, salary, sum(salary) OVER w FROM empsalary WINDOW w AS (PARTITION BY depname)

-- sqlfmt-corpus-separator --

SELECT encode(('\x' || repeat('1234567890abcdef0001', 7))::bytea, 'base64')

-- sqlfmt-corpus-separator --

SELECT encode(overlay(E'Th\\000omas'::bytea placing E'Th\\001omas'::bytea from 2),'escape')

-- sqlfmt-corpus-separator --

SELECT encode(overlay(E'Th\\000omas'::bytea placing E'\\002\\003'::bytea from 5 for 3),'escape')

-- sqlfmt-corpus-separator --

SELECT encode(overlay(E'Th\\000omas'::bytea placing E'\\002\\003'::bytea from 8),'escape')

-- sqlfmt-corpus-separator --

SELECT error_on_null('{1,2,NULL,3}'::int[])

-- sqlfmt-corpus-separator --

SELECT error_on_null(NULL::int)

-- sqlfmt-corpus-separator --

SELECT error_on_null(NULL::int[])

-- sqlfmt-corpus-separator --

SELECT extract(epoch from '294270-01-01 00:00:00'::timestamp)

-- sqlfmt-corpus-separator --

SELECT extract(epoch from '294270-01-01 00:00:00+00'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(epoch from '5000-01-01 00:00:00'::timestamp)

-- sqlfmt-corpus-separator --

SELECT extract(epoch from '5000-01-01 00:00:00+00'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(epoch from interval '1000000000 days')

-- sqlfmt-corpus-separator --

SELECT f1 + time '00:01' AS "Illegal" FROM TIME_TBL

-- sqlfmt-corpus-separator --

SELECT f1 + time with time zone '00:01' AS "Illegal" FROM TIMETZ_TBL

-- sqlfmt-corpus-separator --

SELECT f1 AS "Eight" FROM TIME_TBL WHERE f1 >= '00:00'

-- sqlfmt-corpus-separator --

SELECT f1 AS "Five" FROM TIME_TBL WHERE f1 > '05:06:07'

-- sqlfmt-corpus-separator --

SELECT f1 AS "None" FROM TIMETZ_TBL WHERE f1 < '00:00-07'

-- sqlfmt-corpus-separator --

SELECT f1 AS "None" FROM TIME_TBL WHERE f1 < '00:00'

-- sqlfmt-corpus-separator --

SELECT f1 AS "Seven" FROM TIMETZ_TBL WHERE f1 > '05:06:07-07'

-- sqlfmt-corpus-separator --

SELECT f1 AS "Ten" FROM TIMETZ_TBL WHERE f1 >= '00:00-07'

-- sqlfmt-corpus-separator --

SELECT f1 AS "Three" FROM TIMETZ_TBL WHERE f1 < '05:06:07-07'

-- sqlfmt-corpus-separator --

SELECT f1 AS "Three" FROM TIME_TBL WHERE f1 < '05:06:07'

-- sqlfmt-corpus-separator --

SELECT f1 AS "Time" FROM TIME_TBL

-- sqlfmt-corpus-separator --

SELECT f1 AS dat,
       f1 AT TIME ZONE 'UTC+10' AS dat_at_tz,
       f1 AT TIME ZONE INTERVAL '-10:00' AS dat_at_int
  FROM TIMETZ_TBL
  ORDER BY f1

-- sqlfmt-corpus-separator --

SELECT f1 AS eight FROM VARCHAR_TBL
UNION ALL
SELECT f1 FROM CHAR_TBL

-- sqlfmt-corpus-separator --

SELECT f1 AS five FROM FLOAT8_TBL
  WHERE f1 BETWEEN -1e6 AND 1e6
UNION
SELECT f1 FROM INT4_TBL
  WHERE f1 BETWEEN 0 AND 1000000
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 AS five FROM FLOAT8_TBL
UNION
SELECT f1 FROM FLOAT8_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 AS five FROM TEXT_TBL
UNION
SELECT f1 FROM VARCHAR_TBL
UNION
SELECT TRIM(TRAILING FROM f1) FROM CHAR_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 AS nine FROM FLOAT8_TBL
UNION
SELECT f1 FROM INT4_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 AS ten FROM FLOAT8_TBL
UNION ALL
SELECT f1 FROM FLOAT8_TBL

-- sqlfmt-corpus-separator --

SELECT f1 AS ten FROM FLOAT8_TBL
UNION ALL
SELECT f1 FROM INT4_TBL

-- sqlfmt-corpus-separator --

SELECT f1 AS three FROM VARCHAR_TBL
UNION
SELECT CAST(f1 AS varchar) FROM CHAR_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 FROM float8_tbl EXCEPT SELECT f1 FROM int4_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1 FROM float8_tbl INTERSECT SELECT f1 FROM int4_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT f1,
    EXTRACT(MICROSECOND FROM f1) AS MICROSECOND,
    EXTRACT(MILLISECOND FROM f1) AS MILLISECOND,
    EXTRACT(SECOND FROM f1) AS SECOND,
    EXTRACT(MINUTE FROM f1) AS MINUTE,
    EXTRACT(HOUR FROM f1) AS HOUR,
    EXTRACT(DAY FROM f1) AS DAY,
    EXTRACT(WEEK FROM f1) AS WEEK,
    EXTRACT(MONTH FROM f1) AS MONTH,
    EXTRACT(QUARTER FROM f1) AS QUARTER,
    EXTRACT(YEAR FROM f1) AS YEAR,
    EXTRACT(DECADE FROM f1) AS DECADE,
    EXTRACT(CENTURY FROM f1) AS CENTURY,
    EXTRACT(MILLENNIUM FROM f1) AS MILLENNIUM,
    EXTRACT(EPOCH FROM f1) AS EPOCH
    FROM INTERVAL_TBL

-- sqlfmt-corpus-separator --

SELECT f1, f1 IS DISTINCT FROM f1 as "false" FROM disttable

-- sqlfmt-corpus-separator --

SELECT f1, f1::INTERVAL DAY TO MINUTE AS "minutes",
  (f1 + INTERVAL '1 month')::INTERVAL MONTH::INTERVAL YEAR AS "years"
  FROM interval_tbl

-- sqlfmt-corpus-separator --

SELECT few.dataa, count(*) FROM few WHERE dataa = 'a' GROUP BY few.dataa, unnest('{1,1,3}'::int[]) ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT few.dataa, count(*), min(id), max(id), unnest('{1,1,3}'::int[]) FROM few WHERE few.id = 1 GROUP BY few.dataa

-- sqlfmt-corpus-separator --

SELECT few.dataa, count(*), min(id), max(id), unnest('{1,1,3}'::int[]) FROM few WHERE few.id = 1 GROUP BY few.dataa, 5

-- sqlfmt-corpus-separator --

SELECT few.dataa, count(*), min(id), max(id), unnest('{1,1,3}'::int[]) FROM few WHERE few.id = 1 GROUP BY few.dataa, unnest('{1,1,3}'::int[])

-- sqlfmt-corpus-separator --

SELECT first_value(unique1) over (ORDER BY four rows between current row and 2 following exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT first_value(unique1) over (ORDER BY four rows between current row and 2 following exclude group),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT first_value(unique1) over (ORDER BY four rows between current row and 2 following exclude ties),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT first_value(unique1) over w,
	nth_value(unique1, 2) over w AS nth_2,
	last_value(unique1) over w, unique1, four
FROM tenk1 WHERE unique1 < 10
WINDOW w AS (order by four range between current row and unbounded following)

-- sqlfmt-corpus-separator --

SELECT four FROM tenk1 WHERE FALSE WINDOW w AS (PARTITION BY ten)

-- sqlfmt-corpus-separator --

SELECT gcd((-2147483648)::int4, (-2147483648)::int4)

-- sqlfmt-corpus-separator --

SELECT gcd((-2147483648)::int4, 0::int4)

-- sqlfmt-corpus-separator --

SELECT gcd((-9223372036854775808)::int8, (-9223372036854775808)::int8)

-- sqlfmt-corpus-separator --

SELECT gcd((-9223372036854775808)::int8, 0::int8)

-- sqlfmt-corpus-separator --

SELECT generate_series(1,3) IS DISTINCT FROM 2

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_nn IS DISTINCT FROM 10

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_nn IS DISTINCT FROM NULL::INT

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_nn IS NOT DISTINCT FROM 10

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_nn IS NOT DISTINCT FROM NULL::INT

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_null IS DISTINCT FROM 20

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_null IS DISTINCT FROM NULL::INT

-- sqlfmt-corpus-separator --

SELECT id FROM dist_tab WHERE val_null IS NOT DISTINCT FROM NULL::INT

-- sqlfmt-corpus-separator --

SELECT indexrelid::regclass
FROM pg_index
WHERE (is_catalog_text_unique_index_oid(indexrelid) <>
       (indisunique AND
        indexrelid < 16384 AND
        EXISTS (SELECT 1 FROM pg_attribute
                WHERE attrelid = indexrelid AND atttypid = 'text'::regtype)))

-- sqlfmt-corpus-separator --

SELECT interval '-2562047788:00:54.775807' second(2)

-- sqlfmt-corpus-separator --

SELECT interval '0 days' * '-infinity'::float

-- sqlfmt-corpus-separator --

SELECT interval '0 days' * 'infinity'::float

-- sqlfmt-corpus-separator --

SELECT interval '1 +2:03' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 +2:03:04' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 -2:03' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 -2:03:04' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2' day to hour

-- sqlfmt-corpus-separator --

SELECT interval '1 2' day to minute

-- sqlfmt-corpus-separator --

SELECT interval '1 2' day to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2' hour to minute

-- sqlfmt-corpus-separator --

SELECT interval '1 2' hour to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2.345' day to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2.345' hour to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2.3456' minute to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' day to hour

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' day to minute

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' day to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' day to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' hour to minute

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' hour to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03.4567' day to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03.45678' hour to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03.5678' minute to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04' day to hour

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04' day to minute

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04' day to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04' hour to minute

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04' hour to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04' minute to second

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04.5678' day to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04.5678' hour to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1 2:03:04.5678' minute to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '1' year

-- sqlfmt-corpus-separator --

SELECT interval '1' year to month

-- sqlfmt-corpus-separator --

SELECT interval '1-2' year to month

-- sqlfmt-corpus-separator --

SELECT interval '1.234' second

-- sqlfmt-corpus-separator --

SELECT interval '1.234' second(2)

-- sqlfmt-corpus-separator --

SELECT interval '123 11' day

-- sqlfmt-corpus-separator --

SELECT interval '123 11' day to hour

-- sqlfmt-corpus-separator --

SELECT interval '12:34.5678' minute to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '2' month

-- sqlfmt-corpus-separator --

SELECT interval '2562047788:00:54.775807' second(2)

-- sqlfmt-corpus-separator --

SELECT interval '3' day

-- sqlfmt-corpus-separator --

SELECT interval '4' hour

-- sqlfmt-corpus-separator --

SELECT interval '5 days' * '-infinity'::float

-- sqlfmt-corpus-separator --

SELECT interval '5 days' * 'infinity'::float

-- sqlfmt-corpus-separator --

SELECT interval '5' minute

-- sqlfmt-corpus-separator --

SELECT interval '6' second

-- sqlfmt-corpus-separator --

SELECT interval '999' day

-- sqlfmt-corpus-separator --

SELECT interval '999' hour

-- sqlfmt-corpus-separator --

SELECT interval '999' minute

-- sqlfmt-corpus-separator --

SELECT interval '999' month

-- sqlfmt-corpus-separator --

SELECT interval '999' second

-- sqlfmt-corpus-separator --

SELECT interval(0) '1 day 01:23:45.6789'

-- sqlfmt-corpus-separator --

SELECT interval(2) '1 day 01:23:45.6789'

-- sqlfmt-corpus-separator --

SELECT json_agg(q ORDER BY x NULLS FIRST, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT json_agg(q ORDER BY x, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT json_build_array(VARIADIC '{1,2,3,4}'::int[])

-- sqlfmt-corpus-separator --

SELECT json_build_array(VARIADIC '{1,2,3,4}'::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_array(VARIADIC '{a,b,c}'::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_array(VARIADIC '{{1,4},{2,5},{3,6}}'::int[][])

-- sqlfmt-corpus-separator --

SELECT json_build_array(VARIADIC '{}'::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_array(VARIADIC NULL::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_object('{1,2,3}'::int[], 3)

-- sqlfmt-corpus-separator --

SELECT json_build_object(VARIADIC '{1,2,3,4}'::int[])

-- sqlfmt-corpus-separator --

SELECT json_build_object(VARIADIC '{1,2,3,4}'::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_object(VARIADIC '{a,b,c}'::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_object(VARIADIC '{{1,4},{2,5},{3,6}}'::int[][])

-- sqlfmt-corpus-separator --

SELECT json_build_object(VARIADIC '{}'::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_object(VARIADIC NULL::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(q ORDER BY x NULLS FIRST, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(q ORDER BY x, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array(VARIADIC '{1,2,3,4}'::int[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array(VARIADIC '{1,2,3,4}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array(VARIADIC '{a,b,c}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array(VARIADIC '{{1,4},{2,5},{3,6}}'::int[][])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array(VARIADIC '{}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array(VARIADIC NULL::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object('{1,2,3}'::int[], 3)

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(VARIADIC '{1,2,3,4}'::int[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(VARIADIC '{1,2,3,4}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(VARIADIC '{a,b,c}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(VARIADIC '{{1,4},{2,5},{3,6}}'::int[][])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(VARIADIC '{}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object(VARIADIC NULL::text[])

-- sqlfmt-corpus-separator --

SELECT last_value(unique1) over (ORDER BY four rows between current row and 2 following exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT last_value(unique1) over (ORDER BY four rows between current row and 2 following exclude group),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT last_value(unique1) over (ORDER BY four rows between current row and 2 following exclude ties),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT last_value(unique1) over (ORDER BY four rows between current row and 9223372036854775807 following exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT lcm((-2147483648)::int4, 1::int4)

-- sqlfmt-corpus-separator --

SELECT lcm((-9223372036854775808)::int8, 1::int8)

-- sqlfmt-corpus-separator --

SELECT lcm(9999 * (10::numeric)^131068 + (10::numeric^131068 - 1), 2)

-- sqlfmt-corpus-separator --

SELECT lo_open(2121, x'20000'::int)

-- sqlfmt-corpus-separator --

SELECT lo_open(2121, x'40000'::int)

-- sqlfmt-corpus-separator --

SELECT lo_open(loid, x'40000'::int) from lotest_stash_values

-- sqlfmt-corpus-separator --

SELECT lo_truncate(lo_open(1002, x'20000'::int), 0)

-- sqlfmt-corpus-separator --

SELECT lo_truncate(lo_open(1002, x'20000'::int), 10)

-- sqlfmt-corpus-separator --

SELECT lo_truncate(lo_open(1005, x'20000'::int), 10)

-- sqlfmt-corpus-separator --

SELECT lo_truncate(lo_open(2001, x'20000'::int), 10)

-- sqlfmt-corpus-separator --

SELECT loread(lo_open(1001, x'20000'::int), 32)

-- sqlfmt-corpus-separator --

SELECT loread(lo_open(1001, x'40000'::int), 32)

-- sqlfmt-corpus-separator --

SELECT loread(lo_open(1002, x'40000'::int), 32)

-- sqlfmt-corpus-separator --

SELECT loread(lo_open(1003, x'40000'::int), 32)

-- sqlfmt-corpus-separator --

SELECT loread(lo_open(1004, x'40000'::int), 32)

-- sqlfmt-corpus-separator --

SELECT loread(lo_open(1005, x'40000'::int), 32)

-- sqlfmt-corpus-separator --

SELECT lowrite(lo_open(1001, x'20000'::int), 'abcd')

-- sqlfmt-corpus-separator --

SELECT lowrite(lo_open(1001, x'40000'::int), 'abcd')

-- sqlfmt-corpus-separator --

SELECT lowrite(lo_open(1002, x'20000'::int), 'abcd')

-- sqlfmt-corpus-separator --

SELECT lowrite(lo_open(1003, x'20000'::int), 'abcd')

-- sqlfmt-corpus-separator --

SELECT lowrite(lo_open(1004, x'20000'::int), 'abcd')

-- sqlfmt-corpus-separator --

SELECT make_timestamptz(1881, 12, 10, 0, 0, 0, 'Asia/Singapore') AT TIME ZONE 'UTC'

-- sqlfmt-corpus-separator --

SELECT make_timestamptz(1881, 12, 10, 0, 0, 0, 'Europe/Paris') AT TIME ZONE 'UTC'

-- sqlfmt-corpus-separator --

SELECT make_timestamptz(1881, 12, 10, 0, 0, 0, 'Pacific/Honolulu') AT TIME ZONE 'UTC'

-- sqlfmt-corpus-separator --

SELECT make_timestamptz(2014, 12, 10, 0, 0, 0, 'Europe/Prague') AT TIME ZONE 'UTC'

-- sqlfmt-corpus-separator --

SELECT name 'name string' = name 'name string ' AS "False"

-- sqlfmt-corpus-separator --

SELECT name 'name string' = name 'name string' AS "True"

-- sqlfmt-corpus-separator --

SELECT null IS DISTINCT FROM null as "no"

-- sqlfmt-corpus-separator --

SELECT null IS NOT DISTINCT FROM null as "yes"

-- sqlfmt-corpus-separator --

SELECT num_nonnulls(NULL::text, NULL::int)

-- sqlfmt-corpus-separator --

SELECT num_nonnulls(VARIADIC '{"1","2","3","4"}'::text[])

-- sqlfmt-corpus-separator --

SELECT num_nonnulls(VARIADIC '{1,2,NULL,3}'::int[])

-- sqlfmt-corpus-separator --

SELECT num_nonnulls(VARIADIC '{}'::int[])

-- sqlfmt-corpus-separator --

SELECT num_nonnulls(VARIADIC NULL::text[])

-- sqlfmt-corpus-separator --

SELECT num_nulls(NULL::text, NULL::int)

-- sqlfmt-corpus-separator --

SELECT num_nulls(VARIADIC '{"1","2","3","4"}'::text[])

-- sqlfmt-corpus-separator --

SELECT num_nulls(VARIADIC '{1,2,NULL,3}'::int[])

-- sqlfmt-corpus-separator --

SELECT num_nulls(VARIADIC '{}'::int[])

-- sqlfmt-corpus-separator --

SELECT num_nulls(VARIADIC NULL::text[])

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprcode, o2.oid, o2.oprcode
FROM pg_operator AS o1, pg_operator AS o2, pg_proc AS p1, pg_proc AS p2
WHERE o1.oprcom = o2.oid AND p1.oid = o1.oprcode AND p2.oid = o2.oprcode AND
    (p1.provolatile != p2.provolatile OR
     p1.proleakproof != p2.proleakproof)

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprcode, o2.oid, o2.oprcode
FROM pg_operator AS o1, pg_operator AS o2, pg_proc AS p1, pg_proc AS p2
WHERE o1.oprnegate = o2.oid AND p1.oid = o1.oprcode AND p2.oid = o2.oprcode AND
    (p1.provolatile != p2.provolatile OR
     p1.proleakproof != p2.proleakproof)

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname
FROM pg_operator AS o1
WHERE o1.oprcanhash AND NOT EXISTS
  (SELECT 1 FROM pg_amop
   WHERE amopmethod = (SELECT oid FROM pg_am WHERE amname = 'hash') AND
         amopopr = o1.oid AND amopstrategy = 1)

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname
FROM pg_operator AS o1
WHERE o1.oprcanmerge AND NOT EXISTS
  (SELECT 1 FROM pg_amop
   WHERE amopmethod = (SELECT oid FROM pg_am WHERE amname = 'btree') AND
         amopopr = o1.oid AND amopstrategy = 3)

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname FROM pg_operator AS o1
WHERE (o1.oprcanmerge OR o1.oprcanhash) AND NOT
    (o1.oprkind = 'b' AND o1.oprresult = 'bool'::regtype AND o1.oprcom != 0)

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname, o2.oid, o2.oprname
FROM pg_operator AS o1, pg_operator AS o2
WHERE o1.oprcom = o2.oid AND
    (o1.oprcanmerge != o2.oprcanmerge OR
     o1.oprcanhash != o2.oprcanhash)

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname, p1.oid, p1.proname
FROM pg_operator AS o1, pg_proc AS p1
WHERE o1.oprcode = p1.oid AND
    (o1.oprcanmerge OR o1.oprcanhash) AND
    p1.provolatile = 'v'

-- sqlfmt-corpus-separator --

SELECT octet_length((jsonb '{ "a":  "\ud83d\ude04\ud83d\udc36" }' -> 'a')::text) AS correct_in_utf8

-- sqlfmt-corpus-separator --

SELECT oid, opfname FROM pg_opfamily f
WHERE NOT EXISTS (SELECT 1 FROM pg_opclass WHERE opcfamily = f.oid)

-- sqlfmt-corpus-separator --

SELECT oid, proname
FROM pg_proc as p
WHERE p.prokind = 'a' AND
    NOT EXISTS (SELECT 1 FROM pg_aggregate a WHERE a.aggfnoid = p.oid)

-- sqlfmt-corpus-separator --

SELECT overlay(B'0101011100' placing '001' from 11)

-- sqlfmt-corpus-separator --

SELECT overlay(B'0101011100' placing '001' from 2 for 3)

-- sqlfmt-corpus-separator --

SELECT overlay(B'0101011100' placing '001' from 20)

-- sqlfmt-corpus-separator --

SELECT overlay(B'0101011100' placing '101' from 6)

-- sqlfmt-corpus-separator --

SELECT p1.oid, p1.proname
FROM pg_proc as p1
WHERE  p1.prorettype = 'cstring'::regtype
    AND NOT EXISTS(SELECT 1 FROM pg_type WHERE typoutput = p1.oid)
    AND NOT EXISTS(SELECT 1 FROM pg_type WHERE typmodout = p1.oid)
    AND p1.oid != 'shell_out(void)'::regprocedure
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT p1.oid, p1.proname
FROM pg_proc as p1
WHERE 'cstring'::regtype = ANY (p1.proargtypes)
    AND NOT EXISTS(SELECT 1 FROM pg_type WHERE typinput = p1.oid)
    AND NOT EXISTS(SELECT 1 FROM pg_conversion WHERE conproc = p1.oid)
    AND p1.oid != 'shell_in(cstring)'::regprocedure
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT p1.oid, p1.proname
FROM pg_proc as p1
WHERE p1.prorettype = 'anycompatiblerange'::regtype
  AND NOT
     'anycompatiblerange'::regtype = ANY (p1.proargtypes)
ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT p1.oid, p1.proname
FROM pg_proc as p1
WHERE p1.prorettype = 'internal'::regtype AND NOT
    'internal'::regtype = ANY (p1.proargtypes)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_get_partkeydef('sales_range'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.1::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'nope',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.1::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'pg_temp',
    'relname', 'stats_temp',
    'attname', 'i',
    'inherited', false::boolean,
    'null_frac', 0.0123::real
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.1::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'nope',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.1::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'arange',
    'inherited', false::boolean,
    'null_frac', 0.28::real,
    'range_length_histogram', '{399,499,Infinity}'::text
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'arange',
    'inherited', false::boolean,
    'null_frac', 0.29::real,
    'range_empty_frac', 0.5::real
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'arange',
    'inherited', false::boolean,
    'null_frac', 0.32::real,
    'most_common_elems', '{3,1}'::text,
    'most_common_elem_freqs', '{0.3,0.2,0.2,0.3,0.0}'::real[]
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'arange',
    'inherited', false::boolean,
    'range_bounds_histogram', '{"[-1,1)","[0,4)","[1,4)","[1,100)"}'::text
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'arange',
    'inherited', false::boolean,
    'range_empty_frac', 0.5::real,
    'range_length_histogram', '{399,499,Infinity}'::text
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'attnum', 1::smallint,
    'inherited', false::boolean,
    'null_frac', 0.1::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', NULL::boolean,
    'null_frac', 0.1::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'histogram_bounds', '{1,2,3,4}'::text
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'most_common_vals', '{2,1,3}'::text,
    'most_common_freqs', '{0.3,0.25,0.05}'::real[]
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.21::real,
    'most_common_freqs', '{0.1,0.2,0.3}'::real[]
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.21::real,
    'most_common_vals', '{1,2,3}'::text
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.22::real,
    'most_common_vals', '{2,1,3}'::text,
    'most_common_freqs', '{0.2,0.1}'::double precision[]
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.23::real,
    'most_common_vals', '{2,four,3}'::text,
    'most_common_freqs', '{0.3,0.25,0.05}'::real[]
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.24::real,
    'histogram_bounds', '{1,NULL,3,4}'::text
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.27::real,
    'range_empty_frac', 0.5::real,
    'range_length_histogram', '{399,499,Infinity}'::text
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.2::real,
    'nope', 0.5::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.31::real,
    'range_bounds_histogram', '{"[-1,1)","[0,4)","[1,4)","[1,100)"}'::text
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.33::real,
    'most_common_elems', '{1,3}'::text,
    'most_common_elem_freqs', '{0.3,0.2,0.2,0.3,0.0}'::real[]
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.36::real,
    'elem_count_histogram', '{1,1,1,1,1,1,1,1,1,1}'::real[]
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'id',
    'inherited', false::boolean,
    'version', 150000::integer,
    'null_frac', 0.2::real,
    'avg_width', 5::integer,
    'n_distinct', 0.6::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'nope',
    'inherited', false::boolean,
    'null_frac', 0.1::real,
    'avg_width', 2::integer,
    'n_distinct', 0.3::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'tags',
    'inherited', false::boolean,
    'most_common_elems', '{one,three}'::text,
    'most_common_elem_freqs', '{0.3,0.2,0.2,0.3,0.0}'::real[]
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'tags',
    'inherited', false::boolean,
    'null_frac', 0.25::real,
    'elem_count_histogram', '{1,1,NULL,1,1,1,1,1}'::real[]
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'tags',
    'inherited', false::boolean,
    'null_frac', 0.26::real,
    'elem_count_histogram', '{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}'::real[]
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'tags',
    'inherited', false::boolean,
    'null_frac', 0.34::real,
    'most_common_elems', '{one,two}'::text
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'tags',
    'inherited', false::boolean,
    'null_frac', 0.35::real,
    'most_common_elem_freqs', '{0.3,0.2,0.2,0.3}'::real[]
    )

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', 'xmin',
    'inherited', false::boolean,
    'null_frac', 0.1::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attname', NULL,
    'inherited', false::boolean,
    'null_frac', 0.1::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'attnum', 1::smallint,
    'inherited', false::boolean,
    'null_frac', 0.4::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', 'test',
    'inherited', false::boolean,
    'null_frac', 0.1::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
    'schemaname', 'stats_import',
    'relname', NULL,
    'attname', 'id',
    'inherited', false::boolean,
    'null_frac', 0.1::real)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_attribute_stats(
  'schemaname', 'stats_import',
  'relname', 'test_mr',
  'attname', 'mrange',
  'inherited', false,
  'range_length_histogram', '{19,29,109}'::text,
  'range_empty_frac', '0'::real,
  'range_bounds_histogram', '{"[1,30)","[11,30)","[21,130)"}'::text
)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_dependencies',
  'inherited', false,
  'dependencies', '[{"attributes": [1], "dependency": 3, "degree": 1.000000},
                    {"attributes": [3], "dependency": 1, "degree": 1.000000}]'::pg_dependencies)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_dependencies',
  'inherited', false,
  'dependencies', '[{"attributes": [2], "dependency": 3, "degree": 1.000000},
                    {"attributes": [3], "dependency": 2, "degree": 1.000000}]'::pg_dependencies)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_dependencies',
  'inherited', false,
  'n_distinct', '[{"attributes" : [1,3], "ndistinct" : 4}]'::pg_ndistinct)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_dependencies_exprs',
  'inherited', false,
  'dependencies', '[{"attributes": [-1], "dependency": -2, "degree": 1.000000},
                    {"attributes": [-2], "dependency": -1, "degree": 1.000000}]'::pg_dependencies)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_dependencies_exprs',
  'inherited', false,
  'dependencies', '[{"attributes": [-1], "dependency": 1, "degree": 1.000000},
                    {"attributes": [1], "dependency": -1, "degree": 1.000000}]'::pg_dependencies)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcelem',
  'inherited', false,
  'exprs', '[
              {
                  "avg_width": "33",
                  "null_frac": "0",
                  "n_distinct": "-1",
                  "correlation": "1",
                  "histogram_bounds": "{\"{1,1}\",\"{2,1}\",\"{3,-1}\",\"{NULL,0}\"}",
                  "most_common_vals": null,
                  "most_common_elems": "{-1,0,1,2,3}",
                  "most_common_freqs": null,
                  "elem_count_histogram": "{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1.5}",
                  "most_common_elem_freqs": "{0.25,0.25,0.5,0.25,0.25,0.25,0.5,0.25}"
              }
            ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcelem',
  'inherited', false,
  'exprs', '[
              {
                  "elem_count_histogram": "{BADELEMHIST,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1.5}"
              }
            ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcelem',
  'inherited', false,
  'exprs', '[
              {
                  "most_common_elem_freqs": "{0.25,0.25,0.5,0.25,0.25,0.25,0.5,0.25}"
              }
            ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcelem',
  'inherited', false,
  'exprs', '[
              {
                  "most_common_elems": "{-1,0,1,2,3}"
              }
            ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcelem',
  'inherited', false,
  'exprs', '[
              {
                  "most_common_elems": "{-1,0,1,2,3}",
                  "most_common_elem_freqs": "{BADELEMFREQ,0.25,0.5,0.25,0.25,0.25,0.5,0.25}"
              }
            ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcelem',
  'inherited', false,
  'exprs', '[
              {
                  "most_common_elems": "{-1,0,1,2,3}",
                  "most_common_elem_freqs": null
              }
            ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcelem',
  'inherited', false,
  'exprs', '[
              {
                  "most_common_elems": "{-1,BADELEM,1,2,3}",
                  "most_common_elem_freqs": "{0.25,0.25,0.5,0.25,0.25,0.25,0.5,0.25}"
              }
            ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcelem',
  'inherited', false,
  'exprs', '[
              {
                  "most_common_elems": null,
                  "most_common_elem_freqs": "{0.25,0.25,0.5,0.25,0.25,0.25,0.5,0.25}"
              }
            ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcv',
  'inherited', false,
  'most_common_freqs', '{0.25,0.25,0.25,0.25}'::double precision[],
  'most_common_base_freqs', '{0.0625,0.0625,0.0625,0.0625}'::double precision[])

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcv',
  'inherited', false,
  'most_common_vals', '{four,NULL}'::text[],
  'most_common_freqs', '{0.25,0.25,0.25,0.25}'::double precision[],
  'most_common_base_freqs', '{0.0625,0.0625,0.0625,0.0625}'::double precision[])

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcv',
  'inherited', false,
  'most_common_vals', '{{four,NULL,0,NULL},
                        {one,"(1,1.1,ONE,01-01-2001,\"{\"\"xkey\"\": \"\"xval\"\"}\")",1,2},
                        {tre,"(3,3.3,TRE,03-03-2003,)",-1,3},
                        {two,"(2,2.2,TWO,02-02-2002,\"[true, 4, \"\"six\"\"]\")",1,2}}'::text[],
  'most_common_freqs', '{0.25,0.25,0.25,0.25}'::double precision[],
  'most_common_base_freqs', '{0.00390625,0.015625,0.00390625,0.015625}'::double precision[])

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcv',
  'inherited', false,
  'most_common_vals', '{{four,NULL},
                        {one,"(1,1.1,ONE,01-01-2001,\"{\"\"xkey\"\": \"\"xval\"\"}\")"},
                        {tre,"(3,3.3,TRE,03-03-2003,)"},
                        {two,"(2,2.2,TWO,02-02-2002,\"[true, 4, \"\"six\"\"]\")"}}'::text[],
  'most_common_base_freqs', '{0.0625,0.0625,0.0625,0.0625}'::double precision[])

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcv',
  'inherited', false,
  'most_common_vals', '{{four,NULL},
                        {one,"(1,1.1,ONE,01-01-2001,\"{\"\"xkey\"\": \"\"xval\"\"}\")"},
                        {tre,"(3,3.3,TRE,03-03-2003,)"},
                        {two,"(2,2.2,TWO,02-02-2002,\"[true, 4, \"\"six\"\"]\")"}}'::text[],
  'most_common_freqs', '{0.25,0.25,0.25,0.25}'::double precision[])

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcv',
  'inherited', false,
  'most_common_vals', '{{four,NULL},
                        {one,"(1,1.1,ONE,01-01-2001,\"{\"\"xkey\"\": \"\"xval\"\"}\")"},
                        {tre,"(3,3.3,TRE,03-03-2003,)"},
                        {two,"(2,2.2,TWO,02-02-2002,\"[true, 4, \"\"six\"\"]\")"}}'::text[],
  'most_common_freqs', '{0.25,0.25,0.25,0.25}'::double precision[],
  'most_common_base_freqs', '{0.0625,0.0625,0.0625,0.0625}'::double precision[])

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcv',
  'inherited', false,
  'most_common_vals', '{{four,NULL},
                        {one,"(1,1.1,ONE,01-01-2001,\"{\"\"xkey\"\": \"\"xval\"\"}\")"},
                        {tre,"(3,3.3,TRE,03-03-2003,)"},
                        {two,"(2,2.2,TWO,02-02-2002,\"[true, 4, \"\"six\"\"]\")"}}'::text[],
  'most_common_freqs', '{0.25,0.25,0.25,0.25}'::double precision[],
  'most_common_base_freqs', '{0.0625,0.0625,0.0625}'::double precision[])

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcv',
  'inherited', false,
  'most_common_vals', '{{four,NULL},
                        {one,"(1,1.1,ONE,01-01-2001,\"{\"\"xkey\"\": \"\"xval\"\"}\")"},
                        {tre,"(3,3.3,TRE,03-03-2003,)"},
                        {two,"(2,2.2,TWO,02-02-2002,\"[true, 4, \"\"six\"\"]\")"}}'::text[],
  'most_common_freqs', '{0.25,0.25,0.25}'::double precision[],
  'most_common_base_freqs', '{0.0625,0.0625,0.0625,0.0625}'::double precision[])

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_mcv_exprs',
  'inherited', false,
  'most_common_vals', '{{four,FOUR},{one,NULL},{NULL,TRE},{two,TWO}}'::text[],
  'most_common_freqs', '{0.25,0.25,0.25,0.99}'::double precision[],
  'most_common_base_freqs', '{0.0625,0.0625,0.023,0.087}'::double precision[])

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_ndistinct',
  'inherited', false,
  'dependencies', '[{"attributes": [2], "dependency": 3, "degree": 1.000000},
                    {"attributes": [3], "dependency": 2, "degree": 1.000000}]'::pg_dependencies)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_ndistinct',
  'inherited', false,
  'n_distinct', '[{"attributes" : [1,3], "ndistinct" : 4}]'::pg_ndistinct)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_ndistinct',
  'inherited', false,
  'n_distinct', '[{"attributes" : [2,3], "ndistinct" : 4}]'::pg_ndistinct)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_ndistinct_exprs',
  'inherited', false,
  'n_distinct', '[{"attributes" : [-1,-2], "ndistinct" : 4}]'::pg_ndistinct)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_ndistinct_exprs',
  'inherited', false,
  'n_distinct', '[{"attributes" : [1,-1], "ndistinct" : 4}]'::pg_ndistinct)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_tsvec',
  'inherited', false,
  'exprs', '[null,
             {
                "most_common_elems": "{one,tre,two,four}",
                "most_common_elem_freqs": "{0.25,0.25,0.25,0.25,0.25,0.25}"
             }
          ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[
              null,
              {
                  "avg_width": "4",
                  "null_frac": "0.25",
                  "n_distinct": "-0.5",
                  "correlation": "1",
                  "histogram_bounds": null,
                  "most_common_vals": "{2}",
                  "most_common_elems": null,
                  "most_common_freqs": "{0.5}",
                  "elem_count_histogram": null,
                  "most_common_elem_freqs": null
              }
          ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[
              null,
              {
                  "elem_count_histogram": "{1,2,3,4,5}"
              }
          ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[
              null,
              {
                  "most_common_elems": "{1,2,3}",
                  "most_common_elem_freqs": "{0.3,0.3,0.4}"
              }
          ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[
              null,
              {
                  "range_length_histogram": "{10179,10189,10199}",
                  "range_empty_frac": "0",
                  "range_bounds_histogram": "{10200,10200,10200}"
              }
          ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[
              {
                  "avg_width": "4",
                  "null_frac": "0",
                  "n_distinct": "-0.75",
                  "correlation": "-0.6",
                  "histogram_bounds": "{-1,0}",
                  "most_common_vals": "{BADMCV}",
                  "most_common_elems": null,
                  "most_common_freqs": "{0.5}",
                  "elem_count_histogram": null,
                  "most_common_elem_freqs": null
              },
              {
                  "avg_width": "4",
                  "null_frac": "0.25",
                  "n_distinct": "-0.5",
                  "correlation": "1",
                  "histogram_bounds": null,
                  "most_common_vals": "{2}",
                  "most_common_elems": null,
                  "most_common_freqs": "{0.5}",
                  "elem_count_histogram": null,
                  "most_common_elem_freqs": null
              }
          ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[
              { "histogram_bounds": "{BADHIST,0}" },
              { "histogram_bounds": null }
          ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[
              { "most_common_freqs": "{0.5}" },
              { "most_common_vals": "{2}", "most_common_freqs": "{0.5}" }
          ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[
              { "most_common_vals": "{1}" },
              { "most_common_vals": "{2}", "most_common_freqs": "{0.5}" }
          ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[
              { "most_common_vals": "{1}", "most_common_elems": null },
              { "most_common_vals": "{2}", "most_common_freqs": "{0.5}" }
          ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[
              { "most_common_vals": "{1}", "most_common_freqs": "{BADMCF}" },
              { "most_common_vals": "{2}", "most_common_freqs": "{0.5}" }
          ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[
              { "most_common_vals": null, "most_common_freqs": "{0.5}" },
              { "most_common_vals": "{2}", "most_common_freqs": "{0.5}" }
          ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[ { "avg_width": "4" } ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[ { "avg_width": "BADAVGWIDTH" },
              { "avg_width": "4" } ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[ { "correlation": "BADCORR" },
              { "correlation": "1" }
          ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[ { "n_distinct": "BADNDISTINCT" },
              { "n_distinct": "-0.5" } ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[ { "null_frac": "BADNULLFRAC" },
              { "null_frac": "0.25" } ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[ { "null_frac": 1 },
              { "null_frac": "0.25" } ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[1, null]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '[null, [{"avg_width" : [1]}]]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'exprs', '{ "avg_width": "4", "null_frac": "0" }'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_clone',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_stat_clone',
  'inherited', false,
  'n_distinct', '[{"attributes" : [2,3], "ndistinct" : 4}]'::pg_ndistinct)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_mr',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_mr_stat',
  'inherited', false,
  'exprs', '[{"range_bounds_histogram": "{\"[1,10200)\",\"[11,10200)\"}"}]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_mr',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_mr_stat',
  'inherited', false,
  'exprs', '[{"range_bounds_histogram": "{\"[1,10200)\"}", "range_empty_frac": "0"}]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_mr',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_mr_stat',
  'inherited', false,
  'exprs', '[{"range_bounds_histogram": "{\"[1,10200)\"}", "range_length_histogram": "{10179}"}]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_mr',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_mr_stat',
  'inherited', false,
  'exprs', '[{"range_length_histogram": "{10179,10189}", "range_empty_frac": "0"}]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_mr',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'test_mr_stat',
  'inherited', false,
  'n_distinct', '[{"attributes": [2, 3], "ndistinct": 3},
                  {"attributes": [2, -1], "ndistinct": 3},
                  {"attributes": [3, -1], "ndistinct": 3},
                  {"attributes": [2, 3, -1], "ndistinct": 3}]'::pg_catalog.pg_ndistinct,
  'dependencies', '[{"attributes": [3], "dependency": 2, "degree": 1.000000},
                    {"attributes": [3], "dependency": -1, "degree": 1.000000},
                    {"attributes": [-1], "dependency": 2, "degree": 1.000000},
                    {"attributes": [-1], "dependency": 3, "degree": 1.000000},
                    {"attributes": [2, 3], "dependency": -1, "degree": 1.000000},
                    {"attributes": [2, -1], "dependency": 3, "degree": 1.000000},
                    {"attributes": [3, -1], "dependency": 2, "degree": 1.000000}]'::pg_catalog.pg_dependencies,
  'most_common_vals', '{{red,"{[1,3),[5,9),[20,30)}","{[1,3),[5,9),[20,30),[10000,10200)}"},
                        {red,"{[11,13),[15,19),[20,30)}","{[11,13),[15,19),[20,30),[10000,10200)}"},
                        {red,"{[21,23),[25,29),[120,130)}","{[21,23),[25,29),[120,130),[10000,10200)}"}}'::text[],
  'most_common_freqs', '{0.3333333333333333,0.3333333333333333,0.3333333333333333}'::double precision[],
  'most_common_base_freqs', '{0.1111111111111111,0.1111111111111111,0.1111111111111111}'::double precision[],
  'exprs', '[{ "avg_width": "60", "null_frac": "0", "n_distinct": "-1",
               "range_length_histogram": "{10179,10189,10199}",
               "range_empty_frac": "0",
               "range_bounds_histogram": "{\"[1,10200)\",\"[11,10200)\",\"[21,10200)\"}"
            }]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_extended_stats(
  'schemaname', 'stats_import',
  'relname', 'test_range_expr_null',
  'statistics_schemaname', 'stats_import',
  'statistics_name', 'stat_range_expr_null',
  'inherited', false,
  'exprs', '[
              {
                  "avg_width": "14",
                  "null_frac": "0",
                  "n_distinct": "-1"
              }
            ]'::jsonb)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_relation_stats(
        'relname', 'test',
        'relpages', 17::integer)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relname', 'nope',
        'relpages', 17::integer)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relname', 'part_parent_i',
        'relpages', 2::integer)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relname', 'test_i',
        'relpages', 18::integer)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relname', 0::oid,
        'relpages', 17::integer)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relpages', 17::integer)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_restore_relation_stats(
        'schemaname', 3.6::float,
        'relname', 'test',
        'relpages', 17::integer)

-- sqlfmt-corpus-separator --

SELECT pg_restore_relation_stats(
        'schemaname', 'pg_temp',
        'relname', 'stats_temp',
        'relpages', '-19'::integer,
        'reltuples', 401::real,
        'relallvisible', 5::integer,
        'relallfrozen', 3::integer)

-- sqlfmt-corpus-separator --

SELECT pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relname', 'test',
        'relallvisible', 5::integer)

-- sqlfmt-corpus-separator --

SELECT pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relname', 'test',
        'relpages', '16'::integer)

-- sqlfmt-corpus-separator --

SELECT pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relname', 'test',
        'relpages', '171'::integer,
        'nope', 10::integer)

-- sqlfmt-corpus-separator --

SELECT pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relname', 'test',
        'relpages', 'nope'::text,
        'reltuples', 400.0::real,
        'relallvisible', 4::integer,
        'relallfrozen', 3::integer)

-- sqlfmt-corpus-separator --

SELECT pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relname', 'test',
        'reltuples', '500'::real)

-- sqlfmt-corpus-separator --

SELECT pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relname', 'test',
        'version', 150000::integer,
        'relallfrozen', 3::integer)

-- sqlfmt-corpus-separator --

SELECT pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relname', 'test',
        'version', 150000::integer,
        'relpages', '-17'::integer,
        'reltuples', 400::real,
        'relallvisible', 4::integer,
        'relallfrozen', 2::integer)

-- sqlfmt-corpus-separator --

SELECT pg_restore_relation_stats(
        'schemaname', 'stats_import',
        'relname', 'test',
        NULL, '17'::integer)

-- sqlfmt-corpus-separator --

SELECT pg_size_pretty('-9223372036854775808'::bigint),
       pg_size_pretty('9223372036854775807'::bigint)

-- sqlfmt-corpus-separator --

SELECT pp.oid::regprocedure as proc, pp.provolatile as vp, pp.proleakproof as lp,
       po.oid::regprocedure as opr, po.provolatile as vo, po.proleakproof as lo
FROM pg_proc pp, pg_proc po, pg_operator o, pg_amproc ap, pg_amop ao
WHERE pp.oid = ap.amproc AND po.oid = o.oprcode AND o.oid = ao.amopopr AND
    ao.amopmethod = (SELECT oid FROM pg_am WHERE amname = 'btree') AND
    ao.amopfamily = ap.amprocfamily AND
    ao.amoplefttype = ap.amproclefttype AND
    ao.amoprighttype = ap.amprocrighttype AND
    ap.amprocnum = 1 AND
    (pp.provolatile != po.provolatile OR
     pp.proleakproof != po.proleakproof)
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT (((SELECT q2 FROM int8_tbl ORDER BY q2 LIMIT 1))) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT ALL SELECT DISTINCT q2 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT ALL SELECT q1 FROM int8_tbl FOR NO KEY UPDATE

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT ALL SELECT q2 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT SELECT q2 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl EXCEPT SELECT q2 FROM int8_tbl ORDER BY q2 LIMIT 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl INTERSECT (((SELECT q2 FROM int8_tbl UNION ALL SELECT q2 FROM int8_tbl))) ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl INTERSECT SELECT q2 FROM int8_tbl UNION ALL SELECT q2 FROM int8_tbl  ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl UNION ALL (((SELECT q2 FROM int8_tbl EXCEPT SELECT q1 FROM int8_tbl ORDER BY 1)))

-- sqlfmt-corpus-separator --

SELECT q1 FROM int8_tbl UNION ALL SELECT q2 FROM int8_tbl EXCEPT SELECT q1 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q1,q2 FROM int8_tbl EXCEPT SELECT q2,q1 FROM int8_tbl
ORDER BY q2,q1

-- sqlfmt-corpus-separator --

SELECT q2 FROM int8_tbl EXCEPT ALL SELECT DISTINCT q1 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q2 FROM int8_tbl EXCEPT ALL SELECT q1 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q2 FROM int8_tbl EXCEPT SELECT q1 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q2 FROM int8_tbl INTERSECT ALL SELECT q1 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT q2 FROM int8_tbl INTERSECT SELECT q1 FROM int8_tbl ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT relname
FROM pg_class
WHERE relnamespace = 'pg_catalog'::regnamespace AND relkind = 'r'
      AND pg_class.oid NOT IN (SELECT indrelid FROM pg_index WHERE indisprimary)
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT relname FROM pg_class
    WHERE relname LIKE 'temporal%'
    AND relnamespace IN (SELECT oid FROM pg_namespace WHERE nspname LIKE 'pg_temp%')
    ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT relname FROM pg_class
    WHERE relname LIKE 'v%'
    AND relnamespace IN (SELECT oid FROM pg_namespace WHERE nspname LIKE 'pg_temp%')
    ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT relname, relkind,
    EXISTS(SELECT 1 FROM pg_class WHERE oid = c.reltoastrelid) AS hastoast
FROM pg_class c WHERE relname LIKE 'clstr_tst%' ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT relname, relkind, relpersistence FROM pg_class WHERE relname ~ '^logged1'
UNION ALL
SELECT r.relname || ' toast table', t.relkind, t.relpersistence FROM pg_class r JOIN pg_class t ON t.oid = r.reltoastrelid WHERE r.relname ~ '^logged1'
UNION ALL
SELECT r.relname || ' toast index', ri.relkind, ri.relpersistence FROM pg_class r join pg_class t ON t.oid = r.reltoastrelid JOIN pg_index i ON i.indrelid = t.oid JOIN pg_class ri ON ri.oid = i.indexrelid WHERE r.relname ~ '^logged1'
ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT relname, relkind, relpersistence FROM pg_class WHERE relname ~ '^logged1'
UNION ALL
SELECT r.relname || ' toast table', t.relkind, t.relpersistence FROM pg_class r JOIN pg_class t ON t.oid = r.reltoastrelid WHERE r.relname ~ '^logged1'
UNION ALL
SELECT r.relname ||' toast index', ri.relkind, ri.relpersistence FROM pg_class r join pg_class t ON t.oid = r.reltoastrelid JOIN pg_index i ON i.indrelid = t.oid JOIN pg_class ri ON ri.oid = i.indexrelid WHERE r.relname ~ '^logged1'
ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT relname, relkind, relpersistence FROM pg_class WHERE relname ~ '^unlogged1'
UNION ALL
SELECT r.relname || ' toast table', t.relkind, t.relpersistence FROM pg_class r JOIN pg_class t ON t.oid = r.reltoastrelid WHERE r.relname ~ '^unlogged1'
UNION ALL
SELECT r.relname || ' toast index', ri.relkind, ri.relpersistence FROM pg_class r join pg_class t ON t.oid = r.reltoastrelid JOIN pg_index i ON i.indrelid = t.oid JOIN pg_class ri ON ri.oid = i.indexrelid WHERE r.relname ~ '^unlogged1'
ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash'::regclass, 2, 1, NULL::int, NULL::int)

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash'::regclass, 3, 1, NULL::int)

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash'::regclass, 4, 0, NULL::int, NULL::text, NULL::json)

-- sqlfmt-corpus-separator --

SELECT sum((3 = ANY(SELECT generate_series(1,4)))::int)

-- sqlfmt-corpus-separator --

SELECT sum(salary) OVER w, rank() OVER w FROM empsalary WINDOW w AS (PARTITION BY depname ORDER BY salary DESC)

-- sqlfmt-corpus-separator --

SELECT sum(salary) OVER w1, count(*) OVER w2
FROM empsalary WINDOW w1 AS (ORDER BY salary), w2 AS (ORDER BY salary)

-- sqlfmt-corpus-separator --

SELECT sum(salary), row_number() OVER (ORDER BY depname), sum(
    sum(salary) FILTER (WHERE enroll_date > '2007-01-01')
) FILTER (WHERE depname <> 'sales') OVER (ORDER BY depname DESC) AS "filtered_sum",
    depname
FROM empsalary GROUP BY depname

-- sqlfmt-corpus-separator --

SELECT sum(t1.a), avg(t1.a), sum(t1.b), avg(t1.b) FROM prt1 t1 WHERE NOT EXISTS (SELECT 1 FROM prt2 t2 WHERE t1.a = t2.b)

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over
	(order by unique1
	 rows (SELECT unique1 FROM tenk1 ORDER BY unique1 LIMIT 1) + 1 PRECEDING),
	unique1
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (ORDER BY four groups between 9223372036854775807 following and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (ORDER BY four groups between current row and 9223372036854775807 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four desc range between 2::int8 preceding and 1::int2 preceding),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 0 preceding and 0 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 1 following and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 1 preceding and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 2 preceding and 1 following
	exclude current row), unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 2 preceding and 1 following
	exclude group), unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 2 preceding and 1 following
	exclude ties), unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 2 preceding and 1 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 2 preceding and 1 preceding),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between current row and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between unbounded preceding and 2 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between unbounded preceding and current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between unbounded preceding and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between 2::int8 preceding and 1::int2 preceding exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between 2::int8 preceding and 1::int2 preceding exclude group),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between 2::int8 preceding and 1::int2 preceding exclude no others),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between 2::int8 preceding and 1::int2 preceding exclude ties),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between 2::int8 preceding and 1::int2 preceding),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between 2::int8 preceding and 6::int2 following exclude group),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between 2::int8 preceding and 6::int2 following exclude ties),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between current row and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (partition by four order by unique1 range between 5::int8 preceding and 6::int2 following
	exclude current row),unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (partition by four order by unique1 range between 5::int8 preceding and 6::int2 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (partition by ten
	order by four groups between 0 preceding and 0 following exclude current row), unique1, four, ten
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (partition by ten
	order by four groups between 0 preceding and 0 following exclude group), unique1, four, ten
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (partition by ten
	order by four groups between 0 preceding and 0 following exclude ties), unique1, four, ten
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (partition by ten
	order by four groups between 0 preceding and 0 following),unique1, four, ten
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 1 following and 3 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 1 preceding and 1 following),
       unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 2 preceding and 1 preceding),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 2 preceding and 2 following exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 2 preceding and 2 following exclude group),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 2 preceding and 2 following exclude no others),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 2 preceding and 2 following exclude ties),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 2 preceding and 2 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 9223372036854775807 following and 1 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between current row and 9223372036854775807 following exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between current row and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between unbounded preceding and 1 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between unbounded(1) preceding and unbounded(1) following),
       unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (w range between current row and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10 WINDOW w AS (order by four)

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (w range between unbounded preceding and current row exclude current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10 WINDOW w AS (order by four)

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (w range between unbounded preceding and current row exclude group),
	unique1, four
FROM tenk1 WHERE unique1 < 10 WINDOW w AS (order by four)

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (w range between unbounded preceding and current row exclude ties),
	unique1, four
FROM tenk1 WHERE unique1 < 10 WINDOW w AS (order by four)

-- sqlfmt-corpus-separator --

SELECT t1.* FROM plt1_adv t1 WHERE EXISTS (SELECT 1 FROM plt2_adv t2 WHERE t1.a = t2.a AND t1.c = t2.c) AND t1.b < 10 ORDER BY t1.a

-- sqlfmt-corpus-separator --

SELECT t1.* FROM plt1_adv t1 WHERE NOT EXISTS (SELECT 1 FROM plt2_adv t2 WHERE t1.a = t2.a AND t1.c = t2.c) AND t1.b < 10 ORDER BY t1.a

-- sqlfmt-corpus-separator --

SELECT t1.* FROM prt1 t1 WHERE t1.a IN (SELECT t1.b FROM prt2 t1 WHERE t1.b IN (SELECT (t1.a + t1.b)/2 FROM prt1_e t1 WHERE t1.c = 0)) AND t1.b = 0 ORDER BY t1.a

-- sqlfmt-corpus-separator --

SELECT t1.* FROM prt1 t1 WHERE t1.a IN (SELECT t1.b FROM prt2 t1 WHERE t1.b IN (SELECT (t1.a + t1.b)/2 FROM prt1_e t1 WHERE t1.c = 0)) ORDER BY t1.a

-- sqlfmt-corpus-separator --

SELECT t1.* FROM prt1 t1 WHERE t1.a IN (SELECT t1.b FROM prt2 t1, prt1_e t2 WHERE t1.a = 0 AND t1.b = (t2.a + t2.b)/2) AND t1.b = 0 ORDER BY t1.a

-- sqlfmt-corpus-separator --

SELECT t1.* FROM prt1 t1 WHERE t1.a IN (SELECT t2.b FROM prt2 t2 WHERE t2.a = 0) AND t1.b = 0 ORDER BY t1.a

-- sqlfmt-corpus-separator --

SELECT t1.* FROM prt1_adv t1 WHERE EXISTS (SELECT 1 FROM prt2_adv t2 WHERE t1.a = t2.b) AND t1.b = 0 ORDER BY t1.a

-- sqlfmt-corpus-separator --

SELECT t1.* FROM prt1_adv t1 WHERE NOT EXISTS (SELECT 1 FROM prt2_adv t2 WHERE t1.a = t2.b) AND t1.b = 0 ORDER BY t1.a

-- sqlfmt-corpus-separator --

SELECT t1.a, t1.c, t2.b, t2.c FROM prt1_e t1, prt2_e t2 WHERE (t1.a + t1.b)/2 = (t2.b + t2.a)/2 AND t1.c = 0 ORDER BY t1.a, t2.b

-- sqlfmt-corpus-separator --

SELECT t1.a, t1.c, t2.b, t2.c, t3.a + t3.b, t3.c FROM prt1 t1, prt2 t2, prt1_e t3 WHERE t1.a = t2.b AND t1.a = (t3.a + t3.b)/2 AND t1.b = 0 ORDER BY t1.a, t2.b

-- sqlfmt-corpus-separator --

SELECT t1.a, t2.e
  FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)
  WHERE t1.a = t2.d

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname
FROM pg_type as t1
WHERE t1.typbyval AND
    (t1.typlen != 1 OR t1.typalign != 'c') AND
    (t1.typlen != 2 OR t1.typalign != 's') AND
    (t1.typlen != 4 OR t1.typalign != 'i') AND
    (t1.typlen != 8 OR t1.typalign != 'd')

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname
FROM pg_type as t1
WHERE t1.typstorage != 'p' AND
    (t1.typbyval OR t1.typlen != -1)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname
FROM pg_type as t1
WHERE t1.typtype = 'r' AND
   NOT EXISTS(SELECT 1 FROM pg_range r WHERE rngtypid = t1.oid)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname,
       t1.typelem, t1.typlen, t1.typbyval
FROM pg_type AS t1
WHERE t1.typsubscript = 'array_subscript_handler'::regproc AND NOT
    (t1.typelem != 0 AND t1.typlen = -1 AND NOT t1.typbyval)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname,
       t1.typelem, t1.typlen, t1.typbyval
FROM pg_type AS t1
WHERE t1.typsubscript = 'raw_array_subscript_handler'::regproc AND NOT
    (t1.typelem != 0 AND t1.typlen > 0 AND NOT t1.typbyval)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typinput = p1.oid AND
    (t1.typelem != 0 AND t1.typlen < 0) AND NOT
    (p1.oid = 'array_in'::regproc)
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typoutput = p1.oid AND NOT
    (p1.prorettype = 'cstring'::regtype AND NOT p1.proretset)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typreceive = p1.oid AND
    (t1.typelem != 0 AND t1.typlen < 0) AND NOT
    (p1.oid = 'array_recv'::regproc)
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typsend = p1.oid AND NOT
    (p1.prorettype = 'bytea'::regtype AND NOT p1.proretset)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, t2.oid, t2.typname
FROM pg_type AS t1, pg_type AS t2
WHERE t1.typelem = t2.oid AND NOT
    (t1.typmodin = t2.typmodin AND t1.typmodout = t2.typmodout)

-- sqlfmt-corpus-separator --

SELECT tableoid::pg_catalog.regclass, * FROM fkpart11.fk

-- sqlfmt-corpus-separator --

SELECT tableoid::pg_catalog.regclass, * FROM fkpart11.fk_another

-- sqlfmt-corpus-separator --

SELECT tableoid::pg_catalog.regclass, * FROM fkpart11.fk_parted

-- sqlfmt-corpus-separator --

SELECT tableoid::pg_catalog.regclass, * FROM fkpart11.pk

-- sqlfmt-corpus-separator --

SELECT ten, two, sum(hundred) AS gsum, sum(sum(hundred)) OVER win AS wsum
FROM tenk1 GROUP BY ten, two WINDOW win AS (PARTITION BY two ORDER BY ten)

-- sqlfmt-corpus-separator --

SELECT tgrelid::regclass, tgenabled FROM pg_trigger
  WHERE tgrelid::regclass IN (SELECT oid from pg_class where relname LIKE 'trgfire%')
  ORDER BY tgrelid::regclass::text

-- sqlfmt-corpus-separator --

SELECT time with time zone '0405+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone '040506+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone '040506.07+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone '040506.789+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone '040506.789-08'

-- sqlfmt-corpus-separator --

SELECT time with time zone '04:05+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone '04:05:06+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone '04:05:06.07+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone '2001-12-27 T040506.789 America/Los_Angeles'

-- sqlfmt-corpus-separator --

SELECT time with time zone 'J2452271 T040506.789 America/Los_Angeles'

-- sqlfmt-corpus-separator --

SELECT time with time zone 'T04+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone 'T0405+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone 'T040506+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone 'T040506.07+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone 'T040506.789 +08'

-- sqlfmt-corpus-separator --

SELECT time with time zone 'T040506.789 -08'

-- sqlfmt-corpus-separator --

SELECT time with time zone 'T040506.789 America/Los_Angeles'

-- sqlfmt-corpus-separator --

SELECT time with time zone 'T040506.789+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone 'T040506.789-08'

-- sqlfmt-corpus-separator --

SELECT time with time zone 'T04:05+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone 'T04:05:06+08'

-- sqlfmt-corpus-separator --

SELECT time with time zone 'T04:05:06.07+08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '12.27.2001 04:05:06.789+08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '12.27.2001 04:05:06.789-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '12/27/2001 04:05:06.789-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '2001-12-27 04:05:06.789 MET DST'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '2001-12-27 04:05:06.789-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '2001-12-27 allballs'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '2001.12.27 04:05:06.789-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '2001/12/27 04:05:06.789-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '20011227 040506+08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '20011227 040506-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '20011227 040506.789+08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '20011227 040506.789-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '20011227T040506+08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '20011227T040506-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '20011227T040506.789+08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '20011227T040506.789-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '27.12.2001 04:05:06.789+08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '27.12.2001 04:05:06.789-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone '27/12/2001 04:05:06.789-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'J2452271 04:05:06+08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'J2452271 04:05:06-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'J2452271 T X03456-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'J2452271 T X03456.001e6-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'J2452271+08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'J2452271-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'J2452271.5+08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'J2452271.5-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'J2452271T040506+08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'J2452271T040506-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'J2452271T040506.789+08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'J2452271T040506.789-08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'Y2001M12D27H04M05S06.789+08'

-- sqlfmt-corpus-separator --

SELECT timestamp with time zone 'Y2001M12D27H04MM05S06.789-08'

-- sqlfmt-corpus-separator --

SELECT timestamptz(date '1994-01-01', time '10:00') AS "Jan_01_1994_9am"

-- sqlfmt-corpus-separator --

SELECT timestamptz(date '1994-01-01', time '11:00') AS "Jan_01_1994_10am"

-- sqlfmt-corpus-separator --

SELECT timestamptz(date '1994-01-01', time with time zone '10:00-8') AS "Jan_01_1994_10am"

-- sqlfmt-corpus-separator --

SELECT timestamptz(date '1994-01-01', time with time zone '11:00-5') AS "Jan_01_1994_8am"

-- sqlfmt-corpus-separator --

SELECT timestamptz(date '1994-01-01', time with time zone '11:00-8') AS "Jan_01_1994_11am"

-- sqlfmt-corpus-separator --

SELECT to_timestamp(' Infinity'::float)

-- sqlfmt-corpus-separator --

SELECT to_timestamp('-Infinity'::float)

-- sqlfmt-corpus-separator --

SELECT to_timestamp('NaN'::float)

-- sqlfmt-corpus-separator --

SELECT trim(E'\\000'::bytea from E'\\000Tom\\000'::bytea)

-- sqlfmt-corpus-separator --

SELECT trim(leading E'\\000'::bytea from E'\\000Tom\\000'::bytea)

-- sqlfmt-corpus-separator --

SELECT trim(trailing E'\\000'::bytea from E'\\000Tom\\000'::bytea)

-- sqlfmt-corpus-separator --

SELECT true::boolean::text AS true, false::boolean::text AS false

-- sqlfmt-corpus-separator --

SELECT two FROM tenk1 WHERE 1=2
UNION
SELECT four FROM tenk1
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT two, stringu1, ten, string4
   INTO TABLE tmp
   FROM onek

-- sqlfmt-corpus-separator --

SELECT unique1 FROM tenk1 WHERE unique1 < 3 and unique1 < (-1)::bigint

-- sqlfmt-corpus-separator --

SELECT unique1 FROM tenk1 WHERE unique1 = ANY('{7, 14, 22}') and unique1 = ANY('{33, 44}'::bigint[])

-- sqlfmt-corpus-separator --

SELECT unique1 FROM tenk1 WHERE unique1 = ANY('{NULL,NULL,NULL}')

-- sqlfmt-corpus-separator --

SELECT unique1 FROM tenk1 WHERE unique1 = ANY(NULL)

-- sqlfmt-corpus-separator --

SELECT v,
       SUBSTRING(v FROM 2 FOR 4) AS sub_2_4,
       SUBSTRING(v FROM 7 FOR 13) AS sub_7_13,
       SUBSTRING(v FROM 6) AS sub_6
       FROM VARBIT_TABLE

-- sqlfmt-corpus-separator --

SELECT v, EXTRACT(year FROM d), count(*)
 FROM ctv_data
 GROUP BY 1, 2
 ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT x FROM test1bpci EXCEPT SELECT x FROM test2bpci

-- sqlfmt-corpus-separator --

SELECT x FROM test1bpci INTERSECT SELECT x FROM test2bpci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM test1bpci UNION SELECT x FROM test2bpci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM test1ci EXCEPT SELECT x FROM test2ci

-- sqlfmt-corpus-separator --

SELECT x FROM test1ci INTERSECT SELECT x FROM test2ci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM test1ci UNION SELECT x FROM test2ci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM test1cs EXCEPT SELECT x FROM test2cs

-- sqlfmt-corpus-separator --

SELECT x FROM test1cs INTERSECT SELECT x FROM test2cs

-- sqlfmt-corpus-separator --

SELECT x FROM test1cs UNION SELECT x FROM test2cs ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM test2bpci EXCEPT SELECT x FROM test1bpci

-- sqlfmt-corpus-separator --

SELECT x FROM test2bpci INTERSECT SELECT x FROM test1bpci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM test2bpci UNION SELECT x FROM test1bpci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM test2ci EXCEPT SELECT x FROM test1ci

-- sqlfmt-corpus-separator --

SELECT x FROM test2ci INTERSECT SELECT x FROM test1ci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM test2ci UNION SELECT x FROM test1ci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM test2cs EXCEPT SELECT x FROM test1cs

-- sqlfmt-corpus-separator --

SELECT x FROM test2cs INTERSECT SELECT x FROM test1cs

-- sqlfmt-corpus-separator --

SELECT x FROM test2cs UNION SELECT x FROM test1cs ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM test3bpci WHERE x SIMILAR TO 'a%'

-- sqlfmt-corpus-separator --

SELECT x FROM test3ci WHERE x SIMILAR TO 'a%'

-- sqlfmt-corpus-separator --

SELECT x FROM test3cs WHERE x SIMILAR TO 'a%'

-- sqlfmt-corpus-separator --

SELECT xmlexists('//town[text() = ''Cwmbran'']' PASSING BY REF '<towns><town>Bidford-on-Avon</town><town>Cwmbran</town><town>Bristol</town></towns>')

-- sqlfmt-corpus-separator --

SELECT xmlexists('//town[text() = ''Toronto'']' PASSING BY REF '<towns><town>Bidford-on-Avon</town><town>Cwmbran</town><town>Bristol</town></towns>')

-- sqlfmt-corpus-separator --

SELECT xmlexists('count(/nosuchtag)' PASSING BY REF '<root/>')

-- sqlfmt-corpus-separator --

SELECT xmltext('x'|| '<P>73</P>'::xml || .42 || true || 'j'::char)

-- sqlfmt-corpus-separator --

VALUES (1,2), (3,4+4), (7,77.7)

-- sqlfmt-corpus-separator --

VALUES (1,2), (3,4+4), (7,77.7)
UNION ALL
SELECT 2+2, 57
UNION ALL
TABLE int8_tbl

-- sqlfmt-corpus-separator --

VALUES(1, generate_series(1,2))

-- sqlfmt-corpus-separator --

WITH
   x AS (SELECT proname, proowner, procost::numeric, pronargs,
                array_to_string(proargnames,',') as proargnames,
                case when proargtypes <> '' then array_to_string(proargtypes::oid[],',') end as proargtypes
           FROM pg_proc WHERE proname = 'f_leak'),
   y AS (SELECT xmlelement(name proc,
                           xmlforest(proname, proowner,
                                     procost, pronargs,
                                     proargnames, proargtypes)) as proc
           FROM x),
   z AS (SELECT xmltable.*
           FROM y,
                LATERAL xmltable('/proc' PASSING proc
                                 COLUMNS proname name,
                                         proowner oid,
                                         procost float,
                                         pronargs int,
                                         proargnames text,
                                         proargtypes text))
   SELECT * FROM z
   EXCEPT SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH
   x AS (SELECT proname, proowner, procost::numeric, pronargs,
                array_to_string(proargnames,',') as proargnames,
                case when proargtypes <> '' then array_to_string(proargtypes::oid[],',') end as proargtypes
           FROM pg_proc),
   y AS (SELECT xmlelement(name data,
                           xmlagg(xmlelement(name proc,
                                             xmlforest(proname, proowner, procost,
                                                       pronargs, proargnames, proargtypes)))) as doc
           FROM x),
   z AS (SELECT xmltable.*
           FROM y,
                LATERAL xmltable('/data/proc' PASSING doc
                                 COLUMNS proname name,
                                         proowner oid,
                                         procost float,
                                         pronargs int,
                                         proargnames text,
                                         proargtypes text))
   SELECT * FROM z
   EXCEPT SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE
    x(id) AS (SELECT * FROM y UNION ALL SELECT id+1 FROM x WHERE id < 5),
    y(id) AS (values (1))
 SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE
   x(id) AS
     (SELECT 1 UNION ALL SELECT id+1 FROM x WHERE id < 3 ),
   y(id) AS
     (SELECT * FROM x UNION ALL SELECT * FROM x),
   z(id) AS
     (SELECT * FROM x UNION ALL SELECT id+1 FROM z WHERE id < 10)
 SELECT * FROM z

-- sqlfmt-corpus-separator --

WITH RECURSIVE
   x(id) AS
     (SELECT 1 UNION ALL SELECT id+1 FROM x WHERE id < 3 ),
   y(id) AS
     (SELECT * FROM x UNION ALL SELECT * FROM x),
   z(id) AS
     (SELECT * FROM y UNION ALL SELECT id+1 FROM z WHERE id < 10)
 SELECT * FROM z

-- sqlfmt-corpus-separator --

WITH RECURSIVE
  tab(id_key,link) AS (VALUES (1,17), (2,17), (3,17), (4,17), (6,17), (5,17)),
  iter (id_key, row_type, link) AS (
      SELECT 0, 'base', 17
    UNION (
      WITH remaining(id_key, row_type, link, min) AS (
        SELECT tab.id_key, 'true'::text, iter.link, MIN(tab.id_key) OVER ()
        FROM tab INNER JOIN iter USING (link)
        WHERE tab.id_key > iter.id_key
      ),
      first_remaining AS (
        SELECT id_key, row_type, link
        FROM remaining
        WHERE id_key=min
      ),
      effect AS (
        SELECT tab.id_key, 'new'::text, tab.link
        FROM first_remaining e INNER JOIN tab ON e.id_key=tab.id_key
        WHERE e.row_type = 'false'
      )
      SELECT * FROM first_remaining
      UNION ALL SELECT * FROM effect
    )
  )
SELECT * FROM iter

-- sqlfmt-corpus-separator --

WITH RECURSIVE
  tab(id_key,link) AS (VALUES (1,17), (2,17), (3,17), (4,17), (6,17), (5,17)),
  iter (id_key, row_type, link) AS (
      SELECT 0, 'base', 17
    UNION ALL (
      WITH remaining(id_key, row_type, link, min) AS (
        SELECT tab.id_key, 'true'::text, iter.link, MIN(tab.id_key) OVER ()
        FROM tab INNER JOIN iter USING (link)
        WHERE tab.id_key > iter.id_key
      ),
      first_remaining AS (
        SELECT id_key, row_type, link
        FROM remaining
        WHERE id_key=min
      ),
      effect AS (
        SELECT tab.id_key, 'new'::text, tab.link
        FROM first_remaining e INNER JOIN tab ON e.id_key=tab.id_key
        WHERE e.row_type = 'false'
      )
      SELECT * FROM first_remaining
      UNION ALL SELECT * FROM effect
    )
  )
SELECT * FROM iter

-- sqlfmt-corpus-separator --

WITH RECURSIVE
  x (id) AS (SELECT 1 UNION ALL SELECT id+1 FROM y WHERE id < 5),
  y (id) AS (SELECT 1 UNION ALL SELECT id+1 FROM x WHERE id < 5)
SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE
  y (id) AS (VALUES (1)),
  x (id) AS (SELECT * FROM y UNION ALL SELECT id+1 FROM x WHERE id < 5)
SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE cte (a) as (
	SELECT a FROM duplicates
	UNION
	SELECT a FROM cte
)
SELECT a FROM cte

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(i) AS
    (values (1)
    UNION ALL
	   SELECT * FROM
       (SELECT i+1 FROM foo WHERE i < 10
          UNION ALL
       SELECT i+1 FROM foo WHERE i < 5) AS t
) SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(i) AS
    (values (1)
    UNION ALL
       (SELECT i+1 FROM foo WHERE i < 10
          EXCEPT
       SELECT i+1 FROM foo WHERE i < 5)
) SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(i) AS
    (values (1)
    UNION ALL
       (SELECT i+1 FROM foo WHERE i < 10
          INTERSECT
       SELECT i+1 FROM foo WHERE i < 5)
) SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(i) AS
    (values (1)
    UNION ALL
       (SELECT i+1 FROM foo WHERE i < 10
          UNION ALL
       SELECT i+1 FROM foo WHERE i < 5)
) SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(i) AS
   (SELECT i FROM (VALUES(1),(2)) t(i)
   UNION ALL
   SELECT (i+1)::numeric(10,0) FROM foo WHERE i < 10)
SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(i) AS
   (SELECT i::numeric(3,0) FROM (VALUES(1),(2)) t(i)
   UNION ALL
   SELECT (i+1)::numeric(10,0) FROM foo WHERE i < 10)
SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(x) AS
   (SELECT x FROM (VALUES('a' COLLATE "C"),('b')) t(x)
   UNION ALL
   SELECT (x || 'c') COLLATE "POSIX" FROM foo WHERE length(x) < 10)
SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(x) AS
   (SELECT x FROM (VALUES('a' COLLATE "en-x-icu"),('b')) t(x)
   UNION ALL
   SELECT (x || 'c') COLLATE "de-x-icu" FROM foo WHERE length(x) < 10)
SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE foo(x) AS
   (SELECT x FROM (VALUES('a' COLLATE "en_US"),('b')) t(x)
   UNION ALL
   SELECT (x || 'c') COLLATE "de_DE" FROM foo WHERE length(x) < 10)
SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH RECURSIVE outermost(x) AS (
  SELECT 1
  UNION (WITH innermost as (SELECT 2)
         SELECT * FROM outermost
         UNION SELECT * FROM innermost)
)
SELECT * FROM outermost ORDER BY 1

-- sqlfmt-corpus-separator --

WITH RECURSIVE outermost(x) AS (
  WITH innermost as (SELECT 2 FROM outermost) -- fail
    SELECT * FROM innermost
    UNION SELECT * from outermost
)
SELECT * FROM outermost ORDER BY 1

-- sqlfmt-corpus-separator --

WITH RECURSIVE outermost(x) AS (
 SELECT 1
 UNION (WITH innermost1 AS (
  SELECT 2
  UNION (WITH innermost2 AS (
   SELECT 3
   UNION (WITH innermost3 AS (
    SELECT 4
    UNION (WITH innermost4 AS (
     SELECT 5
     UNION (WITH innermost5 AS (
      SELECT 6
      UNION (WITH innermost6 AS
       (SELECT 7)
       SELECT * FROM innermost6))
      SELECT * FROM innermost5))
     SELECT * FROM innermost4))
    SELECT * FROM innermost3))
   SELECT * FROM innermost2))
  SELECT * FROM outermost
  UNION SELECT * FROM innermost1)
 )
 SELECT * FROM outermost ORDER BY 1

-- sqlfmt-corpus-separator --

WITH RECURSIVE subdepartment AS
(
	SELECT * FROM department WHERE name = 'A'
)
SELECT * FROM subdepartment ORDER BY name

-- sqlfmt-corpus-separator --

WITH RECURSIVE subdepartment AS
(
	SELECT id, parent_department, name FROM department WHERE name = 'A'

	UNION

	SELECT d.id, d.parent_department, d.name FROM department AS d
	INNER JOIN subdepartment AS sd ON d.parent_department = sd.id
)
SELECT * FROM subdepartment ORDER BY name

-- sqlfmt-corpus-separator --

WITH RECURSIVE subdepartment AS
(
	SELECT name as root_name, * FROM department WHERE name = 'A'

	UNION ALL

	SELECT sd.root_name, d.* FROM department AS d, subdepartment AS sd
		WHERE d.parent_department = sd.id
)
SELECT * FROM subdepartment ORDER BY name

-- sqlfmt-corpus-separator --

WITH RECURSIVE subdepartment(level, id, parent_department, name) AS
(
	SELECT 1, * FROM department WHERE name = 'A'

	UNION ALL

	SELECT sd.level + 1, d.* FROM department AS d, subdepartment AS sd
		WHERE d.parent_department = sd.id
)
SELECT * FROM subdepartment ORDER BY name

-- sqlfmt-corpus-separator --

WITH RECURSIVE subdepartment(level, id, parent_department, name) AS
(
	SELECT 1, * FROM department WHERE name = 'A'

	UNION ALL

	SELECT sd.level + 1, d.* FROM department AS d, subdepartment AS sd
		WHERE d.parent_department = sd.id
)
SELECT * FROM subdepartment WHERE level >= 2 ORDER BY name

-- sqlfmt-corpus-separator --

WITH RECURSIVE t AS (
	INSERT INTO y
		SELECT * FROM t
)
VALUES(FALSE)

-- sqlfmt-corpus-separator --

WITH RECURSIVE t AS (
	INSERT INTO y
		SELECT a+5 FROM t2 WHERE a > 5
	RETURNING *
), t2 AS (
	UPDATE y SET a=a-11 RETURNING *
)
SELECT * FROM t
UNION ALL
SELECT * FROM t2

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(i,j) AS (
	VALUES (1,2)
	UNION ALL
	SELECT t2.i, t.j+1 FROM
		(SELECT 2 AS i UNION ALL SELECT 3 AS i) AS t2
		JOIN t ON (t2.i = t.i+1))

	SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(j) AS (
    WITH RECURSIVE s(i) AS (
        VALUES (1)
        UNION ALL
        SELECT i+1 FROM s WHERE i < 10
    )
    SELECT i FROM s
    UNION ALL
    SELECT j+1 FROM t WHERE j < 10
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    SELECT '7'
UNION ALL
    SELECT n+1 FROM t WHERE n < 10
)
SELECT n, pg_typeof(n) FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    SELECT 'foo'
UNION ALL
    SELECT n || ' bar' FROM t WHERE length(n) < 20
)
SELECT n, pg_typeof(n) FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    SELECT (VALUES(1))
UNION ALL
    SELECT n+1 FROM t WHERE n < 5
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    SELECT 1
UNION
    SELECT 10-n FROM t)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    SELECT 1
UNION
    SELECT n+1 FROM t)
SELECT * FROM t LIMIT 10

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    VALUES ('01'::varbit)
UNION
    SELECT n || '10'::varbit FROM t WHERE n < '100'::varbit
)
SELECT n FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    VALUES (1)
UNION ALL
    SELECT n+1 FROM t WHERE n < 100
)
SELECT sum(n) FROM t

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(n) AS (
    VALUES (1)
UNION ALL
    SELECT n+1 FROM t)
SELECT * FROM t LIMIT 10

-- sqlfmt-corpus-separator --

WITH RECURSIVE t1 AS (
  INSERT INTO y SELECT * FROM y RETURNING *
), t2 AS (
  INSERT INTO yy SELECT * FROM t1 RETURNING *
)
SELECT 1

-- sqlfmt-corpus-separator --

WITH RECURSIVE t1 AS (
  INSERT INTO yy SELECT * FROM t2 RETURNING *
), t2 AS (
  INSERT INTO y SELECT * FROM y RETURNING *
)
SELECT 1

-- sqlfmt-corpus-separator --

WITH RECURSIVE w1(c1) AS
 (WITH w2(c2) AS
  (WITH w3(c3) AS
   (WITH w4(c4) AS
    (WITH w5(c5) AS
     (WITH RECURSIVE w6(c6) AS
      (WITH w6(c6) AS
       (WITH w8(c8) AS
        (SELECT 1)
        SELECT * FROM w8)
       SELECT * FROM w6)
      SELECT * FROM w6)
     SELECT * FROM w5)
    SELECT * FROM w4)
   SELECT * FROM w3)
  SELECT * FROM w2)
SELECT * FROM w1

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(id) AS (values (1)
    UNION ALL
    SELECT (SELECT * FROM x) FROM x WHERE id < 5
) SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (
  (WITH x1 AS (SELECT 1 FROM x) SELECT * FROM x1)
  UNION
  SELECT 0)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (
  SELECT 0 UNION SELECT 1
  ORDER BY (SELECT n FROM x))
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (
  WITH sub_cte AS (SELECT * FROM x)
  DELETE FROM graph RETURNING f)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (
  WITH x1 AS (SELECT 1 AS n)
    SELECT 0
    UNION
    SELECT * FROM x1)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (
  WITH x1 AS (SELECT 1 FROM x)
    SELECT 0
    UNION
    SELECT * FROM x1)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT 1 EXCEPT ALL SELECT n+1 FROM x)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT 1 EXCEPT SELECT n+1 FROM x)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT 1 INTERSECT ALL SELECT n+1 FROM x)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT 1 INTERSECT SELECT n+1 FROM x)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT 1 UNION ALL SELECT count(*) FROM x)
  SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM x
                          WHERE n IN (SELECT * FROM x))
  SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM x FOR UPDATE)
  SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM x LIMIT 10 OFFSET 1)
  SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM x ORDER BY 1)
  SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT 1 UNION ALL SELECT sum(n) FROM x)
  SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT a FROM y WHERE a = 1
	UNION ALL
	SELECT x.n+1 FROM x FULL JOIN y ON x.n = y.a WHERE n < 10)
SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT a FROM y WHERE a = 1
	UNION ALL
	SELECT x.n+1 FROM x RIGHT JOIN y ON x.n = y.a WHERE n < 10)
SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT a FROM y WHERE a = 1
	UNION ALL
	SELECT x.n+1 FROM y LEFT JOIN x ON x.n = y.a WHERE n < 10)
SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT n FROM x UNION ALL SELECT 1)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT n FROM x)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH aa AS (
    INSERT INTO withz VALUES(1, 5) ON CONFLICT (k) DO UPDATE SET v = EXCLUDED.v
    WHERE withz.k != EXCLUDED.k
    RETURNING *
)
SELECT * FROM aa

-- sqlfmt-corpus-separator --

WITH cte (x) AS (
        SELECT * FROM generate_series(1, 35, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x groups between 1 preceding and 1 following)

-- sqlfmt-corpus-separator --

WITH cte (x) AS (
        SELECT * FROM generate_series(1, 35, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x range between 1 preceding and 1 following)

-- sqlfmt-corpus-separator --

WITH cte (x) AS (
        SELECT * FROM generate_series(1, 35, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x rows between 1 preceding and 1 following)

-- sqlfmt-corpus-separator --

WITH cte (x) AS (
        select 1 union all select 1 union all select 1 union all
        SELECT * FROM generate_series(5, 49, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x groups between 1 preceding and 1 following)

-- sqlfmt-corpus-separator --

WITH cte (x) AS (
        select 1 union all select 1 union all select 1 union all
        SELECT * FROM generate_series(5, 49, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x range between 1 preceding and 1 following)

-- sqlfmt-corpus-separator --

WITH cte (x) AS (
        select 1 union all select 1 union all select 1 union all
        SELECT * FROM generate_series(5, 49, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x rows between 1 preceding and 1 following)

-- sqlfmt-corpus-separator --

WITH cte1 AS (INSERT INTO t1 VALUES (20, 'Success') RETURNING *) SELECT * FROM cte1

-- sqlfmt-corpus-separator --

WITH cte1 AS (INSERT INTO t1 VALUES (21, 'Fail') RETURNING *) SELECT * FROM cte1

-- sqlfmt-corpus-separator --

WITH cte1 AS (UPDATE t1 SET a = a + 1 RETURNING *) SELECT * FROM cte1

-- sqlfmt-corpus-separator --

WITH cte1 AS (UPDATE t1 SET a = a RETURNING *) SELECT * FROM cte1

-- sqlfmt-corpus-separator --

WITH cte1 AS MATERIALIZED (SELECT * FROM t1 WHERE f_leak(b)) SELECT * FROM cte1

-- sqlfmt-corpus-separator --

WITH foo AS (
  MERGE INTO target USING source ON (true)
  WHEN MATCHED THEN DELETE
) SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH foo AS (SELECT * FROM gtest1) SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH outermost(x) AS (
  SELECT 1
  UNION (WITH innermost as (SELECT 2)
         SELECT * FROM innermost
         UNION SELECT 3)
)
SELECT * FROM outermost ORDER BY 1

-- sqlfmt-corpus-separator --

WITH outermost(x) AS (
  SELECT 1
  UNION (WITH innermost as (SELECT 2)
         SELECT * FROM outermost  -- fail
         UNION SELECT * FROM innermost)
)
SELECT * FROM outermost ORDER BY 1

-- sqlfmt-corpus-separator --

WITH q AS (SELECT 'foo' AS x)
SELECT x, pg_typeof(x) FROM q

-- sqlfmt-corpus-separator --

WITH q1(x,y) AS (
    SELECT hundred, sum(ten) FROM tenk1 GROUP BY hundred
  )
SELECT count(*) FROM q1 WHERE y > (SELECT sum(y)/100 FROM q1 qsub)

-- sqlfmt-corpus-separator --

WITH q1(x,y) AS (SELECT 1,2)
SELECT * FROM q1, q1 AS q2

-- sqlfmt-corpus-separator --

WITH rows AS
  (SELECT ctid, lag(a) OVER (ORDER BY ctid) AS la, a FROM clstr_expression)
SELECT * FROM rows WHERE la < a

-- sqlfmt-corpus-separator --

WITH rows AS
  (SELECT ctid, lag(b) OVER (ORDER BY ctid) AS lb, b FROM clstr_expression)
SELECT * FROM rows WHERE upper(lb) > upper(b)

-- sqlfmt-corpus-separator --

WITH rows AS
  (SELECT i, to_char(i, 'RN') AS roman FROM generate_series(1, 3999) AS i)
SELECT
  bool_and(to_number(roman, 'RN') = i) as valid
FROM rows

-- sqlfmt-corpus-separator --

WITH t AS (
	DELETE FROM y RETURNING *
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
	INSERT INTO y VALUES(0)
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
	INSERT INTO y VALUES(0)
)
VALUES(FALSE)

-- sqlfmt-corpus-separator --

WITH t AS (
    DELETE FROM y
    WHERE a <= 10
    RETURNING *
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
    INSERT INTO y
    VALUES
        (11),
        (12),
        (13),
        (14),
        (15),
        (16),
        (17),
        (18),
        (19),
        (20)
    RETURNING *
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
    INSERT INTO y
    VALUES
        (21),
        (22),
        (23)
    RETURNING *
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
    INSERT INTO y
    VALUES
        (31),
        (32),
        (33)
    RETURNING *
)
SELECT * FROM t LIMIT 1

-- sqlfmt-corpus-separator --

WITH t AS (
    INSERT INTO y
    VALUES
        (41),
        (42),
        (43)
    RETURNING *
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
    UPDATE y
    SET a=a+1
    RETURNING *
)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH t AS (
    UPDATE y SET a = a * 100 RETURNING *
)
SELECT * FROM t LIMIT 10

-- sqlfmt-corpus-separator --

WITH t(b, p, bc_result) AS (VALUES
(0.12, -2829.8369, 58463948950011752465280493160293790845494328939320966633018493248607815580903065923369555885857984675501574162389726507612128133630191173383130639968378879506624785786843501848666498440326970769604109017960864573408272864266102690849952650095786874354625921641729880352858506454246180842452983243549491658464046163869265572232996388827878976066830374513768599285647145439771472435206769249126377164951470622827631950210853282324510655982757098065657709137845327135766013147354253426364240746381620690117663724329288646510198895137275207992825719846135857839292915100523542874885080351683587865157015032404901182924720371819942957083390475846809517968191151435281268695782594904484795360890092607679215675240583291240729468370895035823777914792823688291214492607109455017754453939895630226174304357121900605689015734289765672740769194115142607443713769825894380064727556869268488695795705030158832909348803019429370973064732712469794182891757241046263341655894972953512257981661670321890336672832647028099324621932563236459127918144141230217523147304565594514812518826936144181257723061181656522095236928347413997136815409159361412494284201481609684892562646522086577634100783077813105675590737823924220663206479031113753135119759722725207724879578900186075841393115040465401462266086907464970054073340036852442184414587772177753008511913377364966775792477387717262694468450099866775550614257191941835797445874557362115814601886902749237439492398087966544817154173072811937702110580330775581851211123491341435883319798273456296794954514173820352334127081705706502510709179711510240917772628308487366740741280043704807717608366220401933596364641284631036907635403895053036499618723044314773148779735006542501244942039455169872946018271985844759209768927953340447524637670938413827595013338859796135512187473850161303598087634723542727044978083220970836296653305188470017342167913572166172051819741354902582606590658382067039498769674611071582171914886494269818475850690414812481252963932223686078322390396586222238852602472958831686564971334200490182175112490433364675164900946902818404704835106260174052265784055642968397240262737313737007322288203637798365320295080314524864099419556398713380156353062937736280885716820226469419928595465390700629307079710611273715705695938635644841913194091407807776191951797748706106000922803167645881087385311847268311361092838264814899353459146959869764278464187826798546290981492648723002412475976344071283321798061003719251864595518596639432393032991023409676558943539937377229130132816883146259468718344018277257037013406135980469482324577407154032999045733141275895.3432),
(1.2, 32908.8896, 58463467728170833376633133695001863276259293590926929026251227859007891876739460057725441400966420577009060860805883032969522911803372870882799865787473726926215148161529632590083389287080925059682489116446754279752928005457087175157581627230586554364417068189211136840990661174760199073702207450133797324318403866058202372178813998850887986769280847189341565507156189065295823921162851958925352114220880236114784962150135485415106748467247897246441194126125699204912883449386043559785865023459356275014504597646990160571664166410683323036984805434677654413174177920726210827006973855410386789516533036723888687725436216478665958434776205940192130053647653715221076841771578099896259902368829351569726536927952661429685419815305418450230567773264738536471211804481206474781470237730069753206249915908804615495060673071058534441654604668770343616386612119048579369195201590008082689834456232255266932976831478404670192731621439902738547169253818323045451045749609624500171633897705543164388470746657118050314064066768449450440405619135824055131398727045420324382226572368236570500391463795989258779677208133531636928003546809249007993065200108076924439703799231711400266122025052209803513232429907231051873161206025860851056337427740362763618748092029386371493898291580557004812947013231371383576580415676519066503391905962989205397824064923920045371823949776899815750413244195402085917098964452866825666226141169411712884994564949174271056284898570445214367063763956186792886147126466387576513166370247576466566827375268334148320298849218878848928271566491769458471357076035396330179659440244425914213309776100351793665960978678576150833311810944729586040624059867137538839913141142139636023129691775489034134511666020819676247950267220131499463010350308195762769192775344260909521732256844149916046793599150786757764962585268686580124987490115873389726527572428003433405659445349155536369077209682951123806333170190998931670309088422483075609203671527331975811507450670132060984691061148836994322505371265263690017938762760088575875666254883673433331627055180154954694693433502522592907190906966067656027637884202418119121728966267936832338377284832958974299187166554160783467156478554899314000348357280306042140481751668215838656488457943830180819301102535170705017482946779698265096226184239631924271857062033454725540956591929965181603262502135610768915716020374362368495244256420143645126927013882334008435586481691725030031204304273292938132599127402133470745819213047706793887965197191137237066440328777206799072470374264316425913530947082957300047105685634407092811630672103242089966046839626911122.7149))
SELECT b, p, bc_result, b^p AS power, b^p - bc_result AS diff FROM t

-- sqlfmt-corpus-separator --

WITH t(x) AS (SELECT '1e'||n FROM generate_series(1, 100) g(n))
SELECT x, log(x::numeric) FROM t

-- sqlfmt-corpus-separator --

WITH t(x) AS (SELECT '1e-'||n FROM generate_series(1, 100) g(n))
SELECT x, log(x::numeric) FROM t

-- sqlfmt-corpus-separator --

WITH t(x, bc_result) AS (VALUES
(484990182159328900690402236933516249572671683638747490717351807610531884491845416923860371219625151551889257298200816555016472471293780254009492949585031653913930735918829139712249577547959394351523545901788627247613322896296041868431769047433229466634098452564756860190085118463828382895145244362033728480588969626012192733802377468089120757046364393407262957242230928854711898925295251902007136232994524624903257456111389508582206404271734668422903183500589303866613158037169610592539145461637447957948521714058034772237111009429638870236361143304703683377693378577075353794118557951847394763531830696578809001981568860219578880229402696449243344235099860421846016326538272155937175661905904288335499593232232926636205909086901191153907183842087577811871344870731324067822883041265129394268082883745408414994.8967939438561591657171240282983703914075472645212002662497023142663831371447287624846942598424990784971781730103682951722370983277124599054059027055336437808366784501932987082321905202623642371063626378290734289114618092750984153422293450048717769065428713836637664433167768445609659527458911187829232316677137895259433038764404970599325009178297626038331436654541552998098529141205301472138026818453893127265938030066392881979113522757891639646670670272542401773230506961559808927249585675430838495658225557294666522469887436551840596777627408780618586500922973500018513068499587683746133637919751545157547095670767246977244726331271787622126889459658539988980096764323712767863722912919120929339399753431689512753214200090670880647731689804555417871258907716687575767185444541243606329768784843125926070743277339790277626515824924290352180761378846035233155198504033292692893297993698953705472933411199778880561376633444249703838589180474329586470353212010427945060694794274109764269805332803290229,
 1864.3702986939570026328504202935192533137907736189919154633800554877738455118081651650863235106905871352085850240570561347180517240105510505203972860921397909573687877993477806728098306202020229409548306695695574102950949468160529713610952021974630774784174851619325758380143625473386495586347322798415543385655090746985183329114860118551572428921774322172798724455202876781611633419444058398798142214904998877857425038669920064728855823072107227506485770367799671977282350083029452784747350395161797215115525867416898416360638482342253129160308632504217096916335590470843180746834864303790913372081974355613359678634194879425862536147988835528973291020680020540866655622823550861337486588647231688134992810403147262346312159819432914207194632564009749236609081399504118359354620598232725290537215007867979331582119891661859015726276335168158288396939655310210558566592649049602925182137256134162660116182293851038854455437841571331011002023088829768308520393956515509475418031437505751407687618234418262),
(87190145885430429849953615409019208993240447426362428988181639909267773304254748257120061524000254226856815085523676417146197197996896030672521334101413071112068202429835905642444187493717977611730127126387257253646790849384975208460867137315507010888782632024640844766297185244443116696943912406389670302370461137850160539373600494054874979342373255280815156048999900951842673141766630630919020492255966628630634124452614590400422133958133100159154995520080124736657520969784129924799670552560034302960877087853678350801769339861812435411200669026902417951572668727488315537985378304242438181615160041688723201917323705450185975141141262578884689500612295576288125956289035673242989906973367691922065122033180281670221390667818909912035903387888639331486823729897326624516015340.0330856710565117793999512551468220085711713631167607285185762046751452975325645379302403715842570486302993296501788672462090620871511446272026693318239212657949496275318383141403236705902077406660768573015707706831878445598837931116223956945944726162551477136715847593742032488181481888084716920605114101902724395659898621880016853548602514706686907951229872573180602614761229992106144727082722940736406782659562775289407005631298246624198606031298081220736931229256511054595028182057216042683060059115371651410352645266000330509331097811566633211452233019461903115970558624057877018778178814946285827512359903934291318219271464841957435711594154280905473802599888081783098187210283997106131616471807951265003903143099667366508222327805543948921694362089860577380749774036318574113007382111997454202845559941557812813566442364810680529092880773126707073967537693927177460459341763934709686530005721141046645111784404932103241501569571235364365556796422998363930810983452790309019295181282099408260156,
 1793.5767085750017553306932533574391150814202249805881581227430032600579405884415934520704053351781361105595296647510475380766428668443641914861849764330704062323054023252886955844207807229267936432730818329225450152491146839618683772020068682795388746108876393249306737841247788224204701299467519965182171772253974884845661168860422489046657965359832930382114760565628765599962013955588754803194908990025689040598990346417563277021386852342928910383706995866844541160576254266641602065102228267316550706943783591722246885978355472097314691737807509436806788803362444745551013400341861820755594413819894154786253014501454443272120342005711761286524843010157182464200556865694401941794983935172457481497909987740544409272349152397774548604845897687504977786762391359552407068124283290504752932824699865504970420939586707791994870941813718246825616335675307740641350673558328821461530563823677144691877374809441673507467507447891562257806191361453045937798278733402269265623588493124129181374135958668436774),
(93936642222690597390233191619858485419795942047468396309991947772747208870873993801669373075421461116465960407843923269693395211616591453397070258466704654943689268224479477016161636938138334729982904232438440955361656138189836032891825113139184685132178764873033678116450665758561650355252211196676137179184043639278410827092182700922151290703747496962700158844772453483316974221113826173404445159281421213715669245417896170368554410830320000019029956317336703559699859949692222685614036912057150632902650913831404804982509990655560731349634628713944739168096272097122388116038119844786988276635032016787352796502360718569977397214936366251320294621522016.6483354941025384161536675750898007896744690911429670830432784905421638721478353275821072200938900938046264210604940707974410950770029535636602548377806284157951164875821446035013896786653932045182167021839184824627082391478016195098055107001433336586881395912782883663046617432598969149948351689103230162742769845955320418573803127107923535948653168889411316007796459064267436246637115946581149511513369842911210359447262641996566147462977170742544980481275049898092152042927981394239266559286915303786701737610786594006685748456635797125029722684151298695274097006242412384086302106763844070230264910503179385988626477852818174114043927841085089058972074427820150462261941575665882880501074676800316585217150509780489224388148722603385921057007086785238310735038314861960410473809826927329368597558806004392175746233568789445929554890241140656324160187253042639339549705859147930476532359840809944163908006480881926041259363654863689570520534301207043189181147254153307163555433328278834311658232337,
 1510.4332713542154696529645934345554302578243896764921637693542962119938599884313210100957753316832762996428481801312323020427109678979117469716796746760060470871840325255146954580681101106876674367471955788143763250819168311353856748872452260808797135108102729064040463343792765872545182299889360257515315869180266759715933989413256377582681707188367254513700731642913479683031478361835565783219287780434673712341147656477670848734998849030451414278832848680301511646182446524915091598080243532068451726548537866633622180283865668708517173065893429240665300584705585310049892047293928733753369421499719516009692095913169665213597158441636480707309244604139865130782756488091268094213446272360006907802989573582755585110277620911226015342778471352130366770729972784317323917141031824334355639769512749560550167491709646539950725523461943580211843652293561678342656010571108219244870234329176123205423872844099992204896411752620881541000940129833754169391528449211839693800724450201835161044717173715867437))
SELECT trim_scale(ln(x::numeric)-bc_result) AS diff FROM t

-- sqlfmt-corpus-separator --

WITH tzs (tz) AS (VALUES
    ('+1'), ('+1:'), ('+1:0'), ('+100'), ('+1:00'), ('+01:00'),
    ('+10'), ('+1000'), ('+10:'), ('+10:0'), ('+10:00'), ('+10:00:'),
    ('+10:00:1'), ('+10:00:01'),
    ('+10:00:10'))
     SELECT make_timestamptz(2010, 2, 27, 3, 45, 00, tz), tz FROM tzs

-- sqlfmt-corpus-separator --

WITH uuidts AS (
    SELECT y, ts as ts, lag(ts) OVER (ORDER BY y) AS prev_ts
    FROM (SELECT y, uuid_extract_timestamp(uuidv7((y || ' years')::interval)) AS ts
        FROM generate_series(1970 - extract(year from now())::int, 10888 - extract(year from now())::int) y)
)
SELECT y, ts, prev_ts FROM uuidts WHERE ts < prev_ts

-- sqlfmt-corpus-separator --

WITH v(exp) AS
  (VALUES(-16379),(-16378),(-1234),(-789),(-45),(-5),(-4),(-3),(-2),(-1),(0),
         (1),(2),(3),(4),(5),(38),(275),(2345),(45678),(131070),(131071))
SELECT exp,
  to_char(('1.2345e'||exp)::numeric, '9.999EEEE') as numeric
FROM v

-- sqlfmt-corpus-separator --

WITH v(val) AS
  (VALUES('0'::numeric),('-4.2'),('4.2e9'),('1.2e-5'),('inf'),('-inf'),('nan'))
SELECT val,
  to_char(val, '9.999EEEE') as numeric,
  to_char(val::float8, '9.999EEEE') as float8,
  to_char(val::float4, '9.999EEEE') as float4
FROM v

-- sqlfmt-corpus-separator --

WITH v(val) AS
  (VALUES('0'::numeric),('-4.2'),('4.2e9'),('1.2e-5'),('inf'),('-inf'),('nan'))
SELECT val,
  to_char(val, 'MI99.99') as numeric,
  to_char(val::float8, 'MI99.99') as float8,
  to_char(val::float4, 'MI99.99') as float4
FROM v

-- sqlfmt-corpus-separator --

WITH v(val) AS
  (VALUES('0'::numeric),('-4.2'),('4.2e9'),('1.2e-5'),('inf'),('-inf'),('nan'))
SELECT val,
  to_char(val, 'MI9999999999.99') as numeric,
  to_char(val::float8, 'MI9999999999.99') as float8,
  to_char(val::float4, 'MI9999999999.99') as float4
FROM v

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('-7.777'),('1e340'),('-1e340'),
         ('inf'),('-inf'),('nan'),
         ('inf'),('-inf'),('nan'))
SELECT substring(x::text, 1, 32)
FROM v ORDER BY x

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('-7.777'),('inf'),('-inf'),('nan'))
SELECT x, -x as minusx, abs(x), floor(x), ceil(x), sign(x), numeric_inc(x) as inc
FROM v

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('-7.777'),('inf'),('-inf'),('nan'))
SELECT x, round(x), round(x,1) as round1, trunc(x), trunc(x,1) as trunc1
FROM v

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('inf'),('-inf'),('nan'))
SELECT x1, x2,
  x1 + x2 AS sum,
  x1 - x2 AS diff,
  x1 * x2 AS prod
FROM v AS v1(x1), v AS v2(x2)

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('inf'),('-inf'),('nan'))
SELECT x1, x2,
  x1 / x2 AS quot,
  x1 % x2 AS mod,
  div(x1, x2) AS div
FROM v AS v1(x1), v AS v2(x2) WHERE x2 != 0

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('2'),('4.2'),('inf'),('nan'))
SELECT x1, x2,
  power(x1, x2)
FROM v AS v1(x1), v AS v2(x2) WHERE x1 != 0 OR x2 >= 0

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('4.2'),('inf'),('nan'))
SELECT x, sqrt(x)
FROM v

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('1'::numeric),('4.2'),('inf'),('nan'))
SELECT x,
  log(x),
  log10(x),
  ln(x)
FROM v

-- sqlfmt-corpus-separator --

WITH v(x) AS
  (VALUES('2'::numeric),('4.2'),('inf'),('nan'))
SELECT x1, x2,
  log(x1, x2)
FROM v AS v1(x1), v AS v2(x2)

-- sqlfmt-corpus-separator --

WITH x(n, b) AS (SELECT 1)
SELECT * FROM x

-- sqlfmt-corpus-separator --

select
  (select max((select i.unique2 from tenk1 i where i.unique1 = o.unique1))
     filter (where o.unique1 < 10))
from tenk1 o

-- sqlfmt-corpus-separator --

select '(01,10)'::varbitrange except select '(10,11)'::varbitrange

-- sqlfmt-corpus-separator --

select '1'::text in (select '1'::name union all select '1'::name)

-- sqlfmt-corpus-separator --

select '1.0'::jsonb::float

-- sqlfmt-corpus-separator --

select '[-2147483648:-2147483647]={1,2}'::int[]

-- sqlfmt-corpus-separator --

select '[-2147483649:-2147483648]={1,2}'::int[]

-- sqlfmt-corpus-separator --

select '[0:2][0:2]={{1,2,3},{4,5,6},{7,8,9}}'::int[]

-- sqlfmt-corpus-separator --

select '[1.0]'::jsonb::float

-- sqlfmt-corpus-separator --

select '[1:-1]={}'::int[]

-- sqlfmt-corpus-separator --

select '[1:0]={}'::int[]

-- sqlfmt-corpus-separator --

select '[1:]={1}'::int[]

-- sqlfmt-corpus-separator --

select '[2147483646:2147483646]={1}'::int[]

-- sqlfmt-corpus-separator --

select '[2147483646:2147483647]={1,2}'::int[]

-- sqlfmt-corpus-separator --

select '[21474836488:21474836489]={1,2}'::int[]

-- sqlfmt-corpus-separator --

select '[2]={1,7}'::int[]

-- sqlfmt-corpus-separator --

select '[2]={1}'::int[]

-- sqlfmt-corpus-separator --

select '[:1]={1}'::int[]

-- sqlfmt-corpus-separator --

select 'foo'::text in (select 'bar'::name union all select 'bar'::name)

-- sqlfmt-corpus-separator --

select 'null'::jsonb::float

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json -> null::int

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json ->> null::int

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> null::int

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> null::int

-- sqlfmt-corpus-separator --

select '{(01,10)}'::varbitmultirange except select '{(10,11)}'::varbitmultirange

-- sqlfmt-corpus-separator --

select '{{1,2,3},{4,5,6},{7,8,9}}'::int[]

-- sqlfmt-corpus-separator --

select ( with cte(foo) as ( values(f1) )
          values((select foo from cte)) )
from int4_tbl

-- sqlfmt-corpus-separator --

select ( with cte(foo) as ( values(f1) )
         select (select foo from cte) )
from int4_tbl

-- sqlfmt-corpus-separator --

select (1 = any(array_agg(f1))) = any (select false) from int4_tbl

-- sqlfmt-corpus-separator --

select (select max(0) filter (where b1)) from bool_test

-- sqlfmt-corpus-separator --

select (select max(unique1) filter (where bool_or(ten > 0)) from int8_tbl) from tenk1

-- sqlfmt-corpus-separator --

select (select max(unique1) filter (where sum(ten) > 0) from int8_tbl) from tenk1

-- sqlfmt-corpus-separator --

select (stringu1 || repeat('abcd', 5000))::int2 from tenk1 where unique1 = 1

-- sqlfmt-corpus-separator --

select * from copytest except select * from copytest2

-- sqlfmt-corpus-separator --

select * from emp1 t1 where exists (select * from emp1 t2
                                    where t2.id = t1.code and t2.code > 0)

-- sqlfmt-corpus-separator --

select * from exists_tbl t1
  where (exists(select 1 from exists_tbl t2 where t1.c1 = t2.c2) or c3 < 0)

-- sqlfmt-corpus-separator --

select * from float_table
  where float_col in (select num_col from numeric_table)

-- sqlfmt-corpus-separator --

select * from int4_tbl o where (f1, f1) in
  (select f1, generate_series(1,50) / 10 g from int4_tbl i group by f1)

-- sqlfmt-corpus-separator --

select * from int4_tbl where
  (case when f1 in (select unique1 from tenk1 a) then f1 else null end) in
  (select ten from tenk1 b)

-- sqlfmt-corpus-separator --

select * from int8_tbl i where i.* in (values(i.*::int8_tbl))

-- sqlfmt-corpus-separator --

select * from int8_tbl intersect select q2, q1 from int8_tbl order by 1, 2

-- sqlfmt-corpus-separator --

select * from int8_tbl where q1 in (select c1 from inner_text)

-- sqlfmt-corpus-separator --

select * from notinouter where a not in (select b from notininner)

-- sqlfmt-corpus-separator --

select * from numeric_table
  where num_col in (select float_col from float_table)

-- sqlfmt-corpus-separator --

select * from onek
    where (unique1,ten) in (values (1,1), (20,0), (99,9), (17,99))
    order by unique1

-- sqlfmt-corpus-separator --

select * from outer_7597 where (f1, f2) not in (select * from inner_7597)

-- sqlfmt-corpus-separator --

select * from outer_text where (f1, f2) not in (select * from inner_text)

-- sqlfmt-corpus-separator --

select * from p t1 where exists
  (select 1 from p t2 where t1.a = t2.a and t1.a = 1)

-- sqlfmt-corpus-separator --

select * from prtx1
where not exists (select 1 from prtx2
                  where prtx2.a=prtx1.a and (prtx2.b=prtx1.b+1 or prtx2.c=99))
  and a<20 and c=91

-- sqlfmt-corpus-separator --

select * from prtx1
where not exists (select 1 from prtx2
                  where prtx2.a=prtx1.a and prtx2.b=prtx1.b and prtx2.c=123)
  and a<20 and c=120

-- sqlfmt-corpus-separator --

select * from rtest_vcomp where size_in_cm > 10.0 order by size_in_cm using >

-- sqlfmt-corpus-separator --

select * from sj p
where exists (select * from sj q
              where q.a = p.a and q.b < 10)

-- sqlfmt-corpus-separator --

select * from t t1, t t2 where exists
  (select 1 from t t3 where t1.a = t3.a and t2.b = t3.b and t3.a = 1 and t3.b = 2)

-- sqlfmt-corpus-separator --

select * from tbl_ra t1
where not exists (select 1 from tbl_ra t2 where t2.b = t1.a) and t1.b < 2

-- sqlfmt-corpus-separator --

select * from tmptz where f1 at time zone 'utc' = '2017-01-18 00:00'

-- sqlfmt-corpus-separator --

select * into attest2 from atacc1

-- sqlfmt-corpus-separator --

select 1 = all (select (select 1))

-- sqlfmt-corpus-separator --

select 1 from gtest32 t1 where exists
  (select 1 from gtest32 t2 where t1.a > t2.a and t2.b = 2)

-- sqlfmt-corpus-separator --

select 1, 2, 3 into t

-- sqlfmt-corpus-separator --

select 1/(15-unique2) from tenk1 order by unique2 limit 19

-- sqlfmt-corpus-separator --

select 33 * any ('{1,2,3}')

-- sqlfmt-corpus-separator --

select 33 * any (44)

-- sqlfmt-corpus-separator --

select 33 = all ('{1,2,33}')

-- sqlfmt-corpus-separator --

select 33 = all ('{1,null,3}')

-- sqlfmt-corpus-separator --

select 33 = all ('{33,null,33}')

-- sqlfmt-corpus-separator --

select 33 = all (null::int[])

-- sqlfmt-corpus-separator --

select 33 = any ('{1,2,33}')

-- sqlfmt-corpus-separator --

select 33 = any ('{1,2,3}')

-- sqlfmt-corpus-separator --

select 33 = any ('{1,null,33}')

-- sqlfmt-corpus-separator --

select 33 = any ('{1,null,3}')

-- sqlfmt-corpus-separator --

select 33 = any (null::int[])

-- sqlfmt-corpus-separator --

select 33 >= all ('{1,2,33}')

-- sqlfmt-corpus-separator --

select a.thousand from tenk1 a, tenk1 b
where a.thousand = b.thousand
  and exists ( select 1 from tenk1 c where b.hundred = c.hundred
                   and not exists ( select 1 from tenk1 d
                                    where a.thousand = d.thousand ) )

-- sqlfmt-corpus-separator --

select attrelid::regclass, attname, attnum
from pg_attribute
where attname = 'a'
 and (attrelid = 'mlparted'::regclass
   or attrelid = 'mlparted1'::regclass
   or attrelid = 'mlparted11'::regclass)
order by attrelid::regclass::text

-- sqlfmt-corpus-separator --

select attrelid::regclass, attname, attnum
from pg_attribute
where attname = 'a'
 and (attrelid = 'p'::regclass
   or attrelid = 'p1'::regclass
   or attrelid = 'p11'::regclass)
order by attrelid::regclass::text

-- sqlfmt-corpus-separator --

select avg((select avg(a1.col1 order by (select avg(a2.col2) from tenk1 a3))
            from tenk1 a1(col1)))
from tenk1 a2(col2)

-- sqlfmt-corpus-separator --

select cardinality('[2:4]={5,6,7}'::int[])

-- sqlfmt-corpus-separator --

select cardinality('{{1,2},{3,4},{5,6}}'::int[])

-- sqlfmt-corpus-separator --

select cardinality('{{1,2}}'::int[])

-- sqlfmt-corpus-separator --

select cardinality('{{{1,9},{5,6}},{{2,3},{3,4}}}'::int[])

-- sqlfmt-corpus-separator --

select cardinality('{}'::int[])

-- sqlfmt-corpus-separator --

select cardinality(NULL::int[])

-- sqlfmt-corpus-separator --

select concat(variadic '{}'::int[]) = ''

-- sqlfmt-corpus-separator --

select concat_ws(',', variadic 10)

-- sqlfmt-corpus-separator --

select concat_ws(',', variadic NULL::int[])

-- sqlfmt-corpus-separator --

select count(*) > 0 as ok, count(*) FILTER (WHERE error IS NOT NULL) = 0 AS no_err
  from pg_hba_file_rules

-- sqlfmt-corpus-separator --

select count(*) >= 0 as ok, count(*) FILTER (WHERE error IS NOT NULL) = 0 AS no_err
  from pg_ident_file_mappings

-- sqlfmt-corpus-separator --

select count(*) from t_gin_test_tbl where j @> '{}'::int[]

-- sqlfmt-corpus-separator --

select count(*) from tenk1 t
where (exists(select 1 from tenk1 k where k.unique1 = t.unique2) or ten < 0)

-- sqlfmt-corpus-separator --

select count(*) from tenk1 t
where (exists(select 1 from tenk1 k where k.unique1 = t.unique2) or ten < 0)
  and thousand = 1

-- sqlfmt-corpus-separator --

select count(*) from tenk1 where (two, four) not in
	(select hundred, thousand from tenk2 where thousand > 100)

-- sqlfmt-corpus-separator --

select count(*) from tenk1 x where
  x.unique1 in (select a.f1 from int4_tbl a,float8_tbl b where a.f1=b.f1) and
  x.unique1 = 0 and
  x.unique1 in (select aa.f1 from int4_tbl aa,float8_tbl bb where aa.f1=bb.f1)

-- sqlfmt-corpus-separator --

select distinct max(unique2) from tenk1

-- sqlfmt-corpus-separator --

select distinct min(f1), max(f1) from minmaxtest

-- sqlfmt-corpus-separator --

select except select

-- sqlfmt-corpus-separator --

select exists(select * from nocolumns)

-- sqlfmt-corpus-separator --

select extract(epoch from '256 microseconds'::interval * (2^55)::float8)

-- sqlfmt-corpus-separator --

select f1(int4range(42, 49), 11, 2::smallint) as int, f1(float8range(4.5, 7.8), 7.8, 11::real) as num

-- sqlfmt-corpus-separator --

select f1, (select distinct min(t1.f1) from int4_tbl t1 where t1.f1 = t0.f1)
from int4_tbl t0

-- sqlfmt-corpus-separator --

select f1, (with cte1(x,y) as (select 1,2)
            select count((select i4.f1 from cte1))) as ss
from int4_tbl i4

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1
                         groups between 1 preceding and 1 following)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1
                         range between 1 preceding and 1 following)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1 order by f2
                         groups between 1 preceding and 1 following)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1 order by f2
                         range between 1 preceding and 1 following)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1, f1 order by f2
                         groups between 2 preceding and 1 preceding)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1, f1 order by f2
                         range between 2 preceding and 1 preceding)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1, f2 order by f2
                         groups between 1 following and 2 following)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1, f2 order by f2
                         range between 1 following and 2 following)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by enroll_date groups between 1 following and 3 following
	exclude current row),
	lead(salary) over(order by enroll_date groups between 1 following and 3 following exclude ties),
	nth_value(salary, 1) over(order by enroll_date groups between 1 following and 3 following
	exclude ties),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by enroll_date groups between 1 preceding and 1 following),
	lead(salary) over(order by enroll_date groups between 1 preceding and 1 following),
	nth_value(salary, 1) over(order by enroll_date groups between 1 preceding and 1 following),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude current row),
	last_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude current row),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude group),
	last_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude group),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude ties),
	last_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude ties),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude ties),
	last_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by salary range between 1000 following and 3000 following
	exclude current row),
	lead(salary) over(order by salary range between 1000 following and 3000 following exclude ties),
	nth_value(salary, 1) over(order by salary range between 1000 following and 3000 following
	exclude ties),
	salary from empsalary

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by salary range between 1000 preceding and 1000 following),
	lead(salary) over(order by salary range between 1000 preceding and 1000 following),
	nth_value(salary, 1) over(order by salary range between 1000 preceding and 1000 following),
	salary from empsalary

-- sqlfmt-corpus-separator --

select format('Hello', variadic NULL::int[])

-- sqlfmt-corpus-separator --

select from generate_series(1,5) except all select from generate_series(1,3)

-- sqlfmt-corpus-separator --

select from generate_series(1,5) except select from generate_series(1,3)

-- sqlfmt-corpus-separator --

select from generate_series(1,5) intersect all select from generate_series(1,3)

-- sqlfmt-corpus-separator --

select from generate_series(1,5) intersect select from generate_series(1,3)

-- sqlfmt-corpus-separator --

select from generate_series(1,5) union all select from generate_series(1,3)

-- sqlfmt-corpus-separator --

select from generate_series(1,5) union select from generate_series(1,3)

-- sqlfmt-corpus-separator --

select generate_series(0,2) as s1, generate_series((random()*.1)::int,2) as s2

-- sqlfmt-corpus-separator --

select generate_series(0,2) as s1, generate_series((random()*.1)::int,2) as s2
order by s2 desc

-- sqlfmt-corpus-separator --

select id, f_float4, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float4 range between
             'inf' following and 'inf' following)

-- sqlfmt-corpus-separator --

select id, f_float4, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float4 range between
             'inf' preceding and 'inf' following)

-- sqlfmt-corpus-separator --

select id, f_float4, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float4 range between
             'inf' preceding and 'inf' preceding)

-- sqlfmt-corpus-separator --

select id, f_float4, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float4 range between
             1 preceding and 1 following)

-- sqlfmt-corpus-separator --

select id, f_float4, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float4 range between
             1 preceding and 1.1::float4 following)

-- sqlfmt-corpus-separator --

select id, f_float4, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float4 range between
             1.1 preceding and 'NaN' following)

-- sqlfmt-corpus-separator --

select id, f_float8, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float8 range between
             'inf' following and 'inf' following)

-- sqlfmt-corpus-separator --

select id, f_float8, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float8 range between
             'inf' preceding and 'inf' following)

-- sqlfmt-corpus-separator --

select id, f_float8, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float8 range between
             'inf' preceding and 'inf' preceding)

-- sqlfmt-corpus-separator --

select id, f_float8, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float8 range between
             1 preceding and 1 following)

-- sqlfmt-corpus-separator --

select id, f_float8, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float8 range between
             1 preceding and 1.1::float8 following)

-- sqlfmt-corpus-separator --

select id, f_float8, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_float8 range between
             1.1 preceding and 'NaN' following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval desc range between
             '-1 year' preceding and '1 year' following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval desc range between
             '1 year' preceding and '1 year' following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval range between
             '-infinity'::interval following and
             'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval range between
             '1 year'::interval preceding and '1 year'::interval following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval range between
             'infinity'::interval following and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval range between
             'infinity'::interval preceding and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_interval, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_interval range between
             'infinity'::interval preceding and 'infinity'::interval preceding)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             'inf' following and 'inf' following)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             'inf' preceding and 'inf' following)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             'inf' preceding and 'inf' preceding)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             1 preceding and 1 following)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             1 preceding and 1.1::float8 following)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             1 preceding and 1.1::numeric following)

-- sqlfmt-corpus-separator --

select id, f_numeric, first_value(id) over w, last_value(id) over w
from numerics
window w as (order by f_numeric range between
             1.1 preceding and 'NaN' following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time desc range between
             '-70 min' preceding and '2 hours' following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time desc range between
             '70 min' preceding and '2 hours' following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time range between
             '-infinity'::interval following and
             'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time range between
             '70 min'::interval preceding and '2 hours'::interval following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time range between
             'infinity'::interval following and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time range between
             'infinity'::interval preceding and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_time, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_time range between
             'infinity'::interval preceding and 'infinity'::interval preceding)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp desc range between
             '-1 year' preceding and '1 year' following)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp desc range between
             '1 year' preceding and '1 year' following)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp range between
             '-infinity'::interval following and
             'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp range between
             '1 year'::interval preceding and '1 year'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp range between
             'infinity'::interval following and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp range between
             'infinity'::interval preceding and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamp, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamp range between
             'infinity'::interval preceding and 'infinity'::interval preceding)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz desc range between
             '1 year' preceding and '-1 year' following)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz desc range between
             '1 year' preceding and '1 year' following)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz range between
             '-infinity'::interval following and
             'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz range between
             '1 year'::interval preceding and '1 year'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz range between
             'infinity'::interval following and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz range between
             'infinity'::interval preceding and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timestamptz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timestamptz range between
             'infinity'::interval preceding and 'infinity'::interval preceding)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz desc range between
             '70 min' preceding and '-2 hours' following)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz desc range between
             '70 min' preceding and '2 hours' following)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz range between
             '70 min'::interval preceding and '2 hours'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz range between
             'infinity'::interval following and
             '-infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz range between
             'infinity'::interval following and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz range between
             'infinity'::interval preceding and 'infinity'::interval following)

-- sqlfmt-corpus-separator --

select id, f_timetz, first_value(id) over w, last_value(id) over w
from datetimes
window w as (order by f_timetz range between
             'infinity'::interval preceding and 'infinity'::interval preceding)

-- sqlfmt-corpus-separator --

select intersect select

-- sqlfmt-corpus-separator --

select last_value(salary) over(order by enroll_date groups between 1 following and 3 following
	exclude group),
	lag(salary) over(order by enroll_date groups between 1 following and 3 following exclude group),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select last_value(salary) over(order by enroll_date groups between 1 preceding and 1 following),
	lag(salary) over(order by enroll_date groups between 1 preceding and 1 following),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select last_value(salary) over(order by salary range between 1000 following and 3000 following
	exclude group),
	lag(salary) over(order by salary range between 1000 following and 3000 following exclude group),
	salary from empsalary

-- sqlfmt-corpus-separator --

select last_value(salary) over(order by salary range between 1000 preceding and 1000 following),
	lag(salary) over(order by salary range between 1000 preceding and 1000 following),
	salary from empsalary

-- sqlfmt-corpus-separator --

select length(stringu1) into parallel_write
    from tenk1 group by length(stringu1)

-- sqlfmt-corpus-separator --

select max(0) filter (where b1) from bool_test

-- sqlfmt-corpus-separator --

select max(enroll_date) over (order by enroll_date range between '1 year'::interval preceding and '-2 years'::interval following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select max(enroll_date) over (order by enroll_date range between 1 preceding and 2 following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select max(enroll_date) over (order by salary range between '1 year'::interval preceding and '2 years'::interval following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select max(enroll_date) over (order by salary range between -1 preceding and 2 following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select max(enroll_date) over (order by salary range between 1 preceding and -2 following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select max(unique1) filter (where bool_or(ten > 0)) from tenk1

-- sqlfmt-corpus-separator --

select max(unique1) filter (where sum(ten) > 0) from tenk1

-- sqlfmt-corpus-separator --

select md5('') = 'd41d8cd98f00b204e9800998ecf8427e' AS "TRUE"

-- sqlfmt-corpus-separator --

select md5(''::bytea) = 'd41d8cd98f00b204e9800998ecf8427e' AS "TRUE"

-- sqlfmt-corpus-separator --

select md5('12345678901234567890123456789012345678901234567890123456789012345678901234567890') = '57edf4a22be3c955ac49da2e2107b67a' AS "TRUE"

-- sqlfmt-corpus-separator --

select md5('12345678901234567890123456789012345678901234567890123456789012345678901234567890'::bytea) = '57edf4a22be3c955ac49da2e2107b67a' AS "TRUE"

-- sqlfmt-corpus-separator --

select md5('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789') = 'd174ab98d277d9f5a5611c2c9f419d9f' AS "TRUE"

-- sqlfmt-corpus-separator --

select md5('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'::bytea) = 'd174ab98d277d9f5a5611c2c9f419d9f' AS "TRUE"

-- sqlfmt-corpus-separator --

select md5('a') = '0cc175b9c0f1b6a831c399e269772661' AS "TRUE"

-- sqlfmt-corpus-separator --

select md5('a'::bytea) = '0cc175b9c0f1b6a831c399e269772661' AS "TRUE"

-- sqlfmt-corpus-separator --

select md5('abc') = '900150983cd24fb0d6963f7d28e17f72' AS "TRUE"

-- sqlfmt-corpus-separator --

select md5('abc'::bytea) = '900150983cd24fb0d6963f7d28e17f72' AS "TRUE"

-- sqlfmt-corpus-separator --

select md5('abcdefghijklmnopqrstuvwxyz') = 'c3fcd3d76192e4007dfb496cca67e13b' AS "TRUE"

-- sqlfmt-corpus-separator --

select md5('abcdefghijklmnopqrstuvwxyz'::bytea) = 'c3fcd3d76192e4007dfb496cca67e13b' AS "TRUE"

-- sqlfmt-corpus-separator --

select md5('message digest') = 'f96b697d7cb7938d525a2f31aaf161d0' AS "TRUE"

-- sqlfmt-corpus-separator --

select md5('message digest'::bytea) = 'f96b697d7cb7938d525a2f31aaf161d0' AS "TRUE"

-- sqlfmt-corpus-separator --

select min(unique1) filter (where unique1 > 100) from tenk1

-- sqlfmt-corpus-separator --

select null from pg_database group by datname for update

-- sqlfmt-corpus-separator --

select null::int = all ('{1,2,3}')

-- sqlfmt-corpus-separator --

select null::int = any ('{1,2,3}')

-- sqlfmt-corpus-separator --

select null::int >= all ('{1,2,33}')

-- sqlfmt-corpus-separator --

select null::int >= all ('{}')

-- sqlfmt-corpus-separator --

select null::int >= any ('{}')

-- sqlfmt-corpus-separator --

select percentile_cont(0.5) within group (order by b) from aggtest

-- sqlfmt-corpus-separator --

select percentile_cont(0.5) within group (order by b), sum(b) from aggtest

-- sqlfmt-corpus-separator --

select percentile_cont(0.5) within group (order by thousand) from tenk1

-- sqlfmt-corpus-separator --

select percentile_disc(0.5) within group (order by thousand) from tenk1

-- sqlfmt-corpus-separator --

select pg_catalog.pg_column_is_updatable('uv_pt'::regclass, 1::smallint, false)

-- sqlfmt-corpus-separator --

select pg_catalog.pg_column_is_updatable('uv_pt'::regclass, 2::smallint, false)

-- sqlfmt-corpus-separator --

select polyf(int4range(42, 49), 11, 2::smallint) as int, polyf(float8range(4.5, 7.8), 7.8, 11::real) as num

-- sqlfmt-corpus-separator --

select polyf(multirange(int4range(42, 49)), 11, 2::smallint) as int, polyf(multirange(float8range(4.5, 7.8)), 7.8, 11::real) as num

-- sqlfmt-corpus-separator --

select q2, q1 from int8_tbl intersect select * from int8_tbl order by 1, 2

-- sqlfmt-corpus-separator --

select rank(3) within group (order by stringu1,stringu2) from tenk1

-- sqlfmt-corpus-separator --

select round(((1 - 1.500012345678e-1000) ^ 1.45e1003) * 1e1000)

-- sqlfmt-corpus-separator --

select row_to_json(i) from int8_tbl i(x,y)

-- sqlfmt-corpus-separator --

select string_agg(distinct f1, ',' order by f1) from varchar_tbl

-- sqlfmt-corpus-separator --

select string_agg(distinct f1, ',' order by f1::text) from varchar_tbl

-- sqlfmt-corpus-separator --

select string_agg(distinct f1::text, ',' order by f1) from varchar_tbl

-- sqlfmt-corpus-separator --

select string_agg(distinct f1::text, ',' order by f1::text) from varchar_tbl

-- sqlfmt-corpus-separator --

select substring('a' from '((a))+')

-- sqlfmt-corpus-separator --

select substring('a' from '((a)+)')

-- sqlfmt-corpus-separator --

select substring('asd TO foo' from ' TO (([a-z0-9._]+|"([^"]+|"")+")+)')

-- sqlfmt-corpus-separator --

select sum(1/ten) filter (where ten > 0) from tenk1

-- sqlfmt-corpus-separator --

select sum(f1) into total from t1

-- sqlfmt-corpus-separator --

select sum(salary) over (order by depname range between '1 year'::interval preceding and '2 years'::interval following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(salary) over (order by enroll_date desc range between '1 year'::interval following and '1 year'::interval following),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(salary) over (order by enroll_date desc range between '1 year'::interval preceding and '1 year'::interval following),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(salary) over (order by enroll_date range between '1 year'::interval preceding and '1 year'::interval following
	exclude current row), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(salary) over (order by enroll_date range between '1 year'::interval preceding and '1 year'::interval following
	exclude group), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(salary) over (order by enroll_date range between '1 year'::interval preceding and '1 year'::interval following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(salary) over (order by enroll_date range between '1 year'::interval preceding and '1 year'::interval following),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(salary) over (order by enroll_date, salary range between '1 year'::interval preceding and '2 years'::interval following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(salary) over (range between '1 year'::interval preceding and '2 years'::interval following
	exclude ties), salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select sum(unique1) FILTER (WHERE
  unique1 IN (SELECT unique1 FROM onek where unique1 < 100)) FROM tenk1

-- sqlfmt-corpus-separator --

select ten, mode() within group (order by string4) from tenk1 group by ten

-- sqlfmt-corpus-separator --

select ten, sum(distinct four) filter (where four > 10) from onek a
group by ten
having exists (select 1 from onek b where sum(distinct a.four) = b.four)

-- sqlfmt-corpus-separator --

select ten, sum(distinct four) filter (where four::text ~ '123') from onek a
group by ten

-- sqlfmt-corpus-separator --

select ten, sum(distinct four) from onek a
group by ten
having exists (select 1 from onek b
               where sum(distinct a.four + b.four) = b.four)

-- sqlfmt-corpus-separator --

select ten, sum(distinct four) from onek a
group by ten
having exists (select 1 from onek b where sum(distinct a.four) = b.four)

-- sqlfmt-corpus-separator --

select test_percentile_disc(0.5) within group (order by thousand) from tenk1

-- sqlfmt-corpus-separator --

select to_bin(-1234::bigint)

-- sqlfmt-corpus-separator --

select to_hex(-1234::bigint) AS "fffffffffffffb2e"

-- sqlfmt-corpus-separator --

select to_hex(256::bigint*256::bigint*256::bigint*256::bigint - 1) AS "ffffffff"

-- sqlfmt-corpus-separator --

select trim_scale((0.1 - 2e-16383) * (0.1 - 3e-16383))

-- sqlfmt-corpus-separator --

select union select

-- sqlfmt-corpus-separator --

select unique1 from tenk1 except select unique2 from tenk1 where unique2 != 10

-- sqlfmt-corpus-separator --

select unique1, unique2 from onek2
  where (unique2 = 11 or unique1 = 0) and stringu1 < 'B'

-- sqlfmt-corpus-separator --

select unique1, unique2 from tenk1
where (unique1, unique2) < any (select ten, ten from tenk1 where hundred < 3)
      and unique1 <= 20
order by 1

-- sqlfmt-corpus-separator --

select unique2 from onek2 where unique2 = 11 and stringu1 < 'B' for update

-- sqlfmt-corpus-separator --

select x from (values (array['10'::varbit]), (array['11'::varbit])) _(x) union select x from (values (array['10'::varbit]), (array['01'::varbit])) _(x)

-- sqlfmt-corpus-separator --

select x from (values (array[1, 2]), (array[1, 3])) _(x) except select x from (values (array[1, 2]), (array[1, 4])) _(x)

-- sqlfmt-corpus-separator --

select x from (values (array[1, 2]), (array[1, 3])) _(x) intersect select x from (values (array[1, 2]), (array[1, 4])) _(x)

-- sqlfmt-corpus-separator --

select x from (values (array[1, 2]), (array[1, 3])) _(x) union select x from (values (array[1, 2]), (array[1, 4])) _(x)

-- sqlfmt-corpus-separator --

select x from (values (row('10'::varbit)), (row('11'::varbit))) _(x) union select x from (values (row('10'::varbit)), (row('01'::varbit))) _(x)

-- sqlfmt-corpus-separator --

select x from (values (row('10'::varbit)::ct1), (row('11'::varbit)::ct1)) _(x) union select x from (values (row('10'::varbit)::ct1), (row('01'::varbit)::ct1)) _(x)

-- sqlfmt-corpus-separator --

select x from (values (row(1, 2)), (row(1, 3))) _(x) except select x from (values (row(1, 2)), (row(1, 4))) _(x)

-- sqlfmt-corpus-separator --

select x from (values (row(1, 2)), (row(1, 3))) _(x) intersect select x from (values (row(1, 2)), (row(1, 4))) _(x)

-- sqlfmt-corpus-separator --

select x from (values (row(1, 2)), (row(1, 3))) _(x) union select x from (values (row(1, 2)), (row(1, 4))) _(x)

-- sqlfmt-corpus-separator --

with
A as ( select q2 as id, (select q1) as x from int8_tbl ),
B as ( select id, row_number() over (partition by id) as r from A ),
C as ( select A.id, array(select B.id from B where B.id = A.id) from A )
select * from C

-- sqlfmt-corpus-separator --

with a as ( select id from (values (1), (2)) as v(id) ),
     b as ( select max((select sum(id) from a)) as agg )
select agg from b

-- sqlfmt-corpus-separator --

with cte as materialized (select s from generate_series(1,5) s)
select from cte union select from cte

-- sqlfmt-corpus-separator --

with cte as not materialized (select s from generate_series(1,5) s)
select from cte union select from cte

-- sqlfmt-corpus-separator --

with cte(foo) as ( values(42) ) values((select foo from cte))

-- sqlfmt-corpus-separator --

with ins (a, b, c) as
  (insert into mlparted (b, a) select s.a, 1 from generate_series(2, 39) s(a) returning tableoid::regclass, *)
  select a, b, min(c), max(c) from ins group by a, b order by 1

-- sqlfmt-corpus-separator --

with ordinality as (select 1 as x) select * from ordinality

-- sqlfmt-corpus-separator --

with q as (select max(f1) from int4_tbl group by f1 order by f1)
  select q from q

-- sqlfmt-corpus-separator --

with recursive
graph(f, t, label) as (
  values (1, 2, 'arc 1 -> 2'),
         (1, 3, 'arc 1 -> 3'),
         (2, 3, 'arc 2 -> 3'),
         (1, 4, 'arc 1 -> 4'),
         (4, 5, 'arc 4 -> 5'),
         (5, 1, 'arc 5 -> 1')
),
search_graph(f, t, label) as (
        select * from graph g
        union all
        select g.*
        from graph g, search_graph sg
        where g.f = sg.t
) cycle f, t set is_cycle to true default false using path
select f, t, label from search_graph

-- sqlfmt-corpus-separator --

with recursive a as (
	select 1 as b
	union all
	select * from a
) cycle b set c using p
select * from a

-- sqlfmt-corpus-separator --

with recursive q as (
      select * from department
    union all
      (with recursive x as (
           select * from department
         union all
           (select * from q union all select * from x)
        )
       select * from x)
    )
select * from q limit 32

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set foo to true default false using foo
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set is_cycle to point '(1,1)' default point '(0,0)' using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set is_cycle to true default 55 using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set is_cycle to true default false using label
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set is_cycle using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set label to true default false using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t, f set is_cycle to true default false using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle foo, tar set is_cycle using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) search breadth first by f, t set seq
  cycle f, t set is_cycle using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set foo
  cycle f, t set foo to true default false using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set foo
  cycle f, t set is_cycle to true default false using foo
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union all
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set seq
  cycle f, t set is_cycle using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph g
	union distinct
	select g.*
	from graph g, search_graph sg
	where g.f = sg.t
) cycle f, t set is_cycle to 'Y' default 'N' using path
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	(select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t)
) search depth first by f, t set seq
select * from search_graph order by seq

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set seq
select * from search_graph order by seq

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search breadth first by f, t set seq
select * from search_graph order by seq

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set label
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set seq
select * from search_graph order by seq

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search depth first by f, t, f set seq
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union all
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search depth first by foo, tar set seq
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union distinct
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search breadth first by f, t set seq
select * from search_graph order by seq

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label) as (
	select * from graph0 g
	union distinct
	select g.*
	from graph0 g, search_graph sg
	where g.f = sg.t
) search depth first by f, t set seq
select * from search_graph order by seq

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label, is_cycle, path) as (
	select *, false, array[row(g.f, g.t)] from graph g
	union all
	select g.*, row(g.f, g.t) = any(path), path || row(g.f, g.t)
	from graph g, search_graph sg
	where g.f = sg.t and not is_cycle
)
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label, is_cycle, path) as (
	select *, false, array[row(g.f, g.t)] from graph g
	union all
	select g.*, row(g.f, g.t) = any(path), path || row(g.f, g.t)
	from graph g, search_graph sg
	where g.f = sg.t and not is_cycle
)
select * from search_graph order by path

-- sqlfmt-corpus-separator --

with recursive search_graph(f, t, label, is_cycle, path) as (
	select *, false, array[row(g.f, g.t)] from graph g
	union distinct
	select g.*, row(g.f, g.t) = any(path), path || row(g.f, g.t)
	from graph g, search_graph sg
	where g.f = sg.t and not is_cycle
)
select * from search_graph

-- sqlfmt-corpus-separator --

with recursive test as (
  select 0 as x
  union all
  select (x + 1) % 10
  from test
    where not is_cycle  -- redundant, but legal
) cycle x set is_cycle using path
select * from test

-- sqlfmt-corpus-separator --

with recursive test as (
  select 0 as x
  union all
  select (x + 1) % 10
  from test
) cycle x set is_cycle using path
select * from test

-- sqlfmt-corpus-separator --

with recursive test as (
  select 1 as x
  union all
  select x + 1
  from test
) search breadth first by x set y
select * from test limit 5

-- sqlfmt-corpus-separator --

with recursive test as (
  select 1 as x
  union all
  select x + 1
  from test
) search depth first by x set y
select * from test limit 5

-- sqlfmt-corpus-separator --

with recursive x(a) as
  ((values ('a'), ('b'))
   union all
   (with z as not materialized (select * from x)
    select z.a || z.a as a from z
    where length(z.a || z.a) < 5))
select * from x

-- sqlfmt-corpus-separator --

with recursive x(a) as
  ((values ('a'), ('b'))
   union all
   (with z as not materialized (select * from x)
    select z.a || z1.a as a from z cross join z as z1
    where length(z.a || z1.a) < 5))
select * from x

-- sqlfmt-corpus-separator --

with recursive x(col) as (
	select 1
	union
	(with x as (select * from x)
	 select * from x)
) search depth first by col set seq
select * from x