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

SELECT
  '(0,0)'::tid as tid00,
  '(0,1)'::tid as tid01,
  '(-1,0)'::tid as tidm10,
  '(4294967295,65535)'::tid as tidmax

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

SELECT  interval ''

-- sqlfmt-corpus-separator --

SELECT  interval '+1 -1:00:00',
        interval '-1 +1:00:00',
        interval '+1-2 -3 +4:05:06.789',
        interval '-1-2 +3 -4:05:06.789'

-- sqlfmt-corpus-separator --

SELECT  interval '-23 hours 45 min 12.34 sec',
        interval '-1 day 23 hours 45 min 12.34 sec',
        interval '-1 year 2 months 1 day 23 hours 45 min 12.34 sec',
        interval '-1 year 2 months 1 day 23 hours 45 min +12.34 sec'

-- sqlfmt-corpus-separator --

SELECT  interval '1 day -1 hours',
        interval '-1 days +1 hours',
        interval '1 years 2 months -3 days 4 hours 5 minutes 6.789 seconds',
        - interval '1 years 2 months -3 days 4 hours 5 minutes 6.789 seconds'

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

SELECT $$'' '1' '2'$$::tsvector

-- sqlfmt-corpus-separator --

SELECT $$''$$::json

-- sqlfmt-corpus-separator --

SELECT $$''$$::jsonb

-- sqlfmt-corpus-separator --

SELECT $$'\\as' ab\c ab\\c AB\\\c ab\\\\c$$::tsvector

-- sqlfmt-corpus-separator --

SELECT $$'\\as'$$::tsquery

-- sqlfmt-corpus-separator --

SELECT '          -INFINiTY   '::float4

-- sqlfmt-corpus-separator --

SELECT '          -INFINiTY   '::float8

-- sqlfmt-corpus-separator --

SELECT '    '::json

-- sqlfmt-corpus-separator --

SELECT '    '::jsonb

-- sqlfmt-corpus-separator --

SELECT '    08:00:2b:01:02:03     '::macaddr8

-- sqlfmt-corpus-separator --

SELECT '    08:00:2b:01:02:03'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '    08:00:2b:01:02:03:04:05     '::macaddr8

-- sqlfmt-corpus-separator --

SELECT '    08:00:2b:01:02:03:04:05'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '    true   '::text::boolean AS true,
       '     FALSE'::text::boolean AS false

-- sqlfmt-corpus-separator --

SELECT '   NAN  '::float4

-- sqlfmt-corpus-separator --

SELECT '   NAN  '::float8

-- sqlfmt-corpus-separator --

SELECT '  tru e '::text::boolean AS invalid

-- sqlfmt-corpus-separator --

SELECT ' 1 '::tsquery

-- sqlfmt-corpus-separator --

SELECT ' 1 '::tsvector

-- sqlfmt-corpus-separator --

SELECT ' 1'::tsquery

-- sqlfmt-corpus-separator --

SELECT ' 1'::tsvector

-- sqlfmt-corpus-separator --

SELECT ' INFINITY    x'::float4

-- sqlfmt-corpus-separator --

SELECT ' INFINITY    x'::float8

-- sqlfmt-corpus-separator --

SELECT ' true '::json

-- sqlfmt-corpus-separator --

SELECT ' true '::jsonb

-- sqlfmt-corpus-separator --

SELECT '!!!b'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!!a & !!b'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!!a & b'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!!b'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!(!1|!2)'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!(!1|2)'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!(!b)'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!(1&2)'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!(1)&2'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!(1|!2)'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!(1|2)&3'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!(1|2)'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!1&!2'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!1&2'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!1'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!1|!2'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!1|(2&3)'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!1|2&3'::tsquery

-- sqlfmt-corpus-separator --

SELECT '!1|2'::tsquery

-- sqlfmt-corpus-separator --

SELECT '""'::json

-- sqlfmt-corpus-separator --

SELECT '""'::jsonb

-- sqlfmt-corpus-separator --

SELECT '""=r*/""'::aclitem

-- sqlfmt-corpus-separator --

SELECT '"\n\"\\"'::json

-- sqlfmt-corpus-separator --

SELECT '"\n\"\\"'::jsonb

-- sqlfmt-corpus-separator --

SELECT '"\u"'::json

-- sqlfmt-corpus-separator --

SELECT '"\u"'::jsonb

-- sqlfmt-corpus-separator --

SELECT '"\u"'::jsonpath

-- sqlfmt-corpus-separator --

SELECT '"\u00"'::json

-- sqlfmt-corpus-separator --

SELECT '"\u00"'::jsonb

-- sqlfmt-corpus-separator --

SELECT '"\u00"'::jsonpath

-- sqlfmt-corpus-separator --

SELECT '"\u0000"'::json

-- sqlfmt-corpus-separator --

SELECT '"\u0000"'::jsonb

-- sqlfmt-corpus-separator --

SELECT '"\u0000"'::jsonpath

-- sqlfmt-corpus-separator --

SELECT '"\u000g"'::json

-- sqlfmt-corpus-separator --

SELECT '"\u000g"'::jsonb

-- sqlfmt-corpus-separator --

SELECT '"\u000g"'::jsonpath

-- sqlfmt-corpus-separator --

SELECT '"\u0045"'::jsonb

-- sqlfmt-corpus-separator --

SELECT '"\uaBcD"'::json

-- sqlfmt-corpus-separator --

SELECT '"\uaBcD"'::jsonpath

-- sqlfmt-corpus-separator --

SELECT '"\v"'::json

-- sqlfmt-corpus-separator --

SELECT '"\v"'::jsonb

-- sqlfmt-corpus-separator --

SELECT '"abc
def"'::json

-- sqlfmt-corpus-separator --

SELECT '"abc
def"'::jsonb

-- sqlfmt-corpus-separator --

SELECT '"abc"'::json

-- sqlfmt-corpus-separator --

SELECT '"abc"'::jsonb

-- sqlfmt-corpus-separator --

SELECT '"abc'::json

-- sqlfmt-corpus-separator --

SELECT '"abc'::jsonb

-- sqlfmt-corpus-separator --

SELECT '"regress_""quoted"=r*/"regress_""quoted"'::aclitem

-- sqlfmt-corpus-separator --

SELECT '$."\u"'::jsonpath

-- sqlfmt-corpus-separator --

SELECT '$."\u00"'::jsonpath

-- sqlfmt-corpus-separator --

SELECT '$."\u0000"'::jsonpath

-- sqlfmt-corpus-separator --

SELECT '$."\u000g"'::jsonpath

-- sqlfmt-corpus-separator --

SELECT '$."\uaBcD"'::jsonpath

-- sqlfmt-corpus-separator --

SELECT '''1 2'''::tsquery

-- sqlfmt-corpus-separator --

SELECT '''1 2'''::tsvector

-- sqlfmt-corpus-separator --

SELECT ''::json

-- sqlfmt-corpus-separator --

SELECT ''::jsonb

-- sqlfmt-corpus-separator --

SELECT ''::text AS eleven, unique1, unique2, stringu1
		FROM onek WHERE unique1 < 50
		ORDER BY unique1 DESC LIMIT 20 OFFSET 39

-- sqlfmt-corpus-separator --

SELECT ''::text AS five, unique1, unique2, stringu1
		FROM onek
		ORDER BY unique1 LIMIT 5 OFFSET 900

-- sqlfmt-corpus-separator --

SELECT ''::text AS five, unique1, unique2, stringu1
		FROM onek
		ORDER BY unique1 OFFSET 990 LIMIT 5

-- sqlfmt-corpus-separator --

SELECT ''::text AS five, unique1, unique2, stringu1
		FROM onek WHERE unique1 > 60
		ORDER BY unique1 LIMIT 5

-- sqlfmt-corpus-separator --

SELECT ''::text AS ten, unique1, unique2, stringu1
		FROM onek
		ORDER BY unique1 OFFSET 990

-- sqlfmt-corpus-separator --

SELECT ''::text AS three, unique1, unique2, stringu1
		FROM onek WHERE unique1 > 100
		ORDER BY unique1 LIMIT 3 OFFSET 20

-- sqlfmt-corpus-separator --

SELECT ''::text AS two, unique1, unique2, stringu1
		FROM onek WHERE unique1 > 50
		ORDER BY unique1 LIMIT 2

-- sqlfmt-corpus-separator --

SELECT ''::text AS two, unique1, unique2, stringu1
		FROM onek WHERE unique1 > 60 AND unique1 < 63
		ORDER BY unique1 LIMIT 5

-- sqlfmt-corpus-separator --

SELECT ''::text AS zero, unique1, unique2, stringu1
		FROM onek WHERE unique1 < 50
		ORDER BY unique1 DESC LIMIT 8 OFFSET 99

-- sqlfmt-corpus-separator --

SELECT ''::text::"char"

-- sqlfmt-corpus-separator --

SELECT ''::text::boolean AS invalid

-- sqlfmt-corpus-separator --

SELECT '(!1|2)&3'::tsquery

-- sqlfmt-corpus-separator --

SELECT '($123,456.78)'::money

-- sqlfmt-corpus-separator --

SELECT '(1&2)'::tsquery

-- sqlfmt-corpus-separator --

SELECT '(1)'::money

-- sqlfmt-corpus-separator --

SELECT '(1,65536)'::tid

-- sqlfmt-corpus-separator --

SELECT '(1|2)&3'::tsquery

-- sqlfmt-corpus-separator --

SELECT '(4294967296,1)'::tid

-- sqlfmt-corpus-separator --

SELECT '-1'::money / 1.175494e-38::float4

-- sqlfmt-corpus-separator --

SELECT '-10e-400'::float8

-- sqlfmt-corpus-separator --

SELECT '-10e400'::float8

-- sqlfmt-corpus-separator --

SELECT '-12345'::money

-- sqlfmt-corpus-separator --

SELECT '-1234567890'::money

-- sqlfmt-corpus-separator --

SELECT '-12345678901234567'::money

-- sqlfmt-corpus-separator --

SELECT '-12345678901234567'::money::numeric

-- sqlfmt-corpus-separator --

SELECT '-123456789012345678'::money

-- sqlfmt-corpus-separator --

SELECT '-2147483648.4'::float8::int4

-- sqlfmt-corpus-separator --

SELECT '-2147483648.5'::float4::int4

-- sqlfmt-corpus-separator --

SELECT '-2147483648.6'::float8::int4

-- sqlfmt-corpus-separator --

SELECT '-2147483900'::float4::int4

-- sqlfmt-corpus-separator --

SELECT '-32768.4'::float4::int2

-- sqlfmt-corpus-separator --

SELECT '-32768.4'::float8::int2

-- sqlfmt-corpus-separator --

SELECT '-32768.6'::float4::int2

-- sqlfmt-corpus-separator --

SELECT '-32768.6'::float8::int2

-- sqlfmt-corpus-separator --

SELECT '-92233720368547758.08'::money

-- sqlfmt-corpus-separator --

SELECT '-92233720368547758.08'::money - '0.01'::money

-- sqlfmt-corpus-separator --

SELECT '-92233720368547758.08'::money::numeric

-- sqlfmt-corpus-separator --

SELECT '-92233720368547758.085'::money

-- sqlfmt-corpus-separator --

SELECT '-92233720368547758.09'::money

-- sqlfmt-corpus-separator --

SELECT '-9223372036854775808'::money

-- sqlfmt-corpus-separator --

SELECT '-9223372036854775808.5'::float4::int8

-- sqlfmt-corpus-separator --

SELECT '-9223372036854775808.5'::float8::int8

-- sqlfmt-corpus-separator --

SELECT '-9223372036854780000'::float8::int8

-- sqlfmt-corpus-separator --

SELECT '-9223380000000000000'::float4::int8

-- sqlfmt-corpus-separator --

SELECT '-Infinity'::float4::numeric

-- sqlfmt-corpus-separator --

SELECT '-Infinity'::float8::numeric

-- sqlfmt-corpus-separator --

SELECT '-Infinity'::numeric::float4

-- sqlfmt-corpus-separator --

SELECT '-Infinity'::numeric::float8

-- sqlfmt-corpus-separator --

SELECT '-Infinity'::numeric::int2

-- sqlfmt-corpus-separator --

SELECT '-Infinity'::numeric::int4

-- sqlfmt-corpus-separator --

SELECT '-Infinity'::numeric::int8

-- sqlfmt-corpus-separator --

SELECT '-inf'::numeric % '0'

-- sqlfmt-corpus-separator --

SELECT '-inf'::numeric / '0'

-- sqlfmt-corpus-separator --

SELECT '-infinity'::interval::time

-- sqlfmt-corpus-separator --

SELECT '0'::json

-- sqlfmt-corpus-separator --

SELECT '0'::jsonb

-- sqlfmt-corpus-separator --

SELECT '0'::numeric % '0'

-- sqlfmt-corpus-separator --

SELECT '0'::numeric / '0'

-- sqlfmt-corpus-separator --

SELECT '0.1'::json

-- sqlfmt-corpus-separator --

SELECT '0.1'::jsonb

-- sqlfmt-corpus-separator --

SELECT '0.x1'::json

-- sqlfmt-corpus-separator --

SELECT '0.x1'::jsonb

-- sqlfmt-corpus-separator --

SELECT '0/0'::pg_lsn + ('FFFFFFFF/FFFFFFFF'::pg_lsn - '0/0'::pg_lsn)

-- sqlfmt-corpus-separator --

SELECT '0/1'::pg_lsn - 1::numeric

-- sqlfmt-corpus-separator --

SELECT '0/1'::pg_lsn - 2::numeric

-- sqlfmt-corpus-separator --

SELECT '0/16AE7F7' < '0/16AE7F8'::pg_lsn

-- sqlfmt-corpus-separator --

SELECT '0/16AE7F7'::pg_lsn + 'NaN'::numeric

-- sqlfmt-corpus-separator --

SELECT '0/16AE7F7'::pg_lsn + 16::numeric

-- sqlfmt-corpus-separator --

SELECT '0/16AE7F7'::pg_lsn - '0/16AE7F8'::pg_lsn

-- sqlfmt-corpus-separator --

SELECT '0/16AE7F7'::pg_lsn - 'NaN'::numeric

-- sqlfmt-corpus-separator --

SELECT '0/16AE7F7'::pg_lsn - 16::numeric

-- sqlfmt-corpus-separator --

SELECT '0/16AE7F8' = '0/16AE7F8'::pg_lsn

-- sqlfmt-corpus-separator --

SELECT '0/16AE7F8' > pg_lsn '0/16AE7F7'

-- sqlfmt-corpus-separator --

SELECT '0/16AE7F8'::pg_lsn != '0/16AE7F7'

-- sqlfmt-corpus-separator --

SELECT '0/16AE7F8'::pg_lsn - '0/16AE7F7'::pg_lsn

-- sqlfmt-corpus-separator --

SELECT '01'::json

-- sqlfmt-corpus-separator --

SELECT '01'::jsonb

-- sqlfmt-corpus-separator --

SELECT '08-00-2b-01-02-03-04-05-06-07'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '08002b01020304050607'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '08002b010203xyza'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '08002b:01020304050607'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '08:00-2b:01:02:03:04:05'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '08:00:2b:01.02:03:04:05'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '08:00:2b:01:02:03     '::macaddr8

-- sqlfmt-corpus-separator --

SELECT '08:00:2b:01:02:03  123'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '08:00:2b:01:02:03:04:05     '::macaddr8

-- sqlfmt-corpus-separator --

SELECT '08:00:2b:01:02:03:04:05  123'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '08:00:2b:01:02:03:04:05:06:07'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '0z002b0102030405'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '1 '::tsquery

-- sqlfmt-corpus-separator --

SELECT '1 '::tsvector

-- sqlfmt-corpus-separator --

SELECT '1 2'::tsvector

-- sqlfmt-corpus-separator --

SELECT '1 day 1 day'::interval

-- sqlfmt-corpus-separator --

SELECT '1 millisecond'::interval, '1 microsecond'::interval,
       '500 seconds 99 milliseconds 51 microseconds'::interval

-- sqlfmt-corpus-separator --

SELECT '1 month 2146410 days'::interval * 1000.5002

-- sqlfmt-corpus-separator --

SELECT '1 second 2 seconds'::interval

-- sqlfmt-corpus-separator --

SELECT '1&!2'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1&(2&(4&(5&6)))'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1&(2&(4&(5|!6)))'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1&(2&(4&(5|6)))'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1&(2)'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1&2&4&5&6'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1&2'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1'::json

-- sqlfmt-corpus-separator --

SELECT '1'::jsonb

-- sqlfmt-corpus-separator --

SELECT '1'::money / 0::int2

-- sqlfmt-corpus-separator --

SELECT '1'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1'::tsvector

-- sqlfmt-corpus-separator --

SELECT '1.3e100'::json

-- sqlfmt-corpus-separator --

SELECT '1.3e100'::jsonb

-- sqlfmt-corpus-separator --

SELECT '1.3ex100'::json

-- sqlfmt-corpus-separator --

SELECT '1.3ex100'::jsonb

-- sqlfmt-corpus-separator --

SELECT '10 milliseconds 20 milliseconds'::interval

-- sqlfmt-corpus-separator --

SELECT '10e-400'::float8

-- sqlfmt-corpus-separator --

SELECT '10e400'::float8

-- sqlfmt-corpus-separator --

SELECT '123    08:00:2b:01:02:03'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '123    08:00:2b:01:02:03:04:05'::macaddr8

-- sqlfmt-corpus-separator --

SELECT '1234567890'::money

-- sqlfmt-corpus-separator --

SELECT '12345678901234567'::money

-- sqlfmt-corpus-separator --

SELECT '12345678901234567'::money::numeric

-- sqlfmt-corpus-separator --

SELECT '123456789012345678'::money

-- sqlfmt-corpus-separator --

SELECT '126::1'::inet - '127::2'::inet

-- sqlfmt-corpus-separator --

SELECT '127.0.0.1'::inet + 10000000000

-- sqlfmt-corpus-separator --

SELECT '127.0.0.1'::inet + 257

-- sqlfmt-corpus-separator --

SELECT '127.0.0.1'::inet - 10000000000

-- sqlfmt-corpus-separator --

SELECT '127.0.0.2'::inet  - ('127.0.0.2'::inet + 500)

-- sqlfmt-corpus-separator --

SELECT '127.0.0.2'::inet  - ('127.0.0.2'::inet - 500)

-- sqlfmt-corpus-separator --

SELECT '127::1'::inet + 10000000000

-- sqlfmt-corpus-separator --

SELECT '127::1'::inet + 257

-- sqlfmt-corpus-separator --

SELECT '127::1'::inet - '126::2'::inet

-- sqlfmt-corpus-separator --

SELECT '127::1'::inet - '127::2'::inet

-- sqlfmt-corpus-separator --

SELECT '127::2'::inet  - ('127::2'::inet + 500)

-- sqlfmt-corpus-separator --

SELECT '127::2'::inet  - ('127::2'::inet - 500)

-- sqlfmt-corpus-separator --

SELECT '1912-01-01 00:00 MMT'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '1912-01-01 00:00 MMT'::timestamptz AT TIME ZONE 'UTC'

-- sqlfmt-corpus-separator --

SELECT '1912-01-01 00:00'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '19970210 173201' AT TIME ZONE 'America/New_York'

-- sqlfmt-corpus-separator --

SELECT '19970710 173201' AT TIME ZONE 'America/Does_not_exist'

-- sqlfmt-corpus-separator --

SELECT '19970710 173201' AT TIME ZONE 'America/New_York'

-- sqlfmt-corpus-separator --

SELECT '1:20:05 5 microseconds'::interval

-- sqlfmt-corpus-separator --

SELECT '1e100'::json

-- sqlfmt-corpus-separator --

SELECT '1e100'::jsonb

-- sqlfmt-corpus-separator --

SELECT '1f2'::json

-- sqlfmt-corpus-separator --

SELECT '1f2'::jsonb

-- sqlfmt-corpus-separator --

SELECT '1|!2&3'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1|!2'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1|(2&3)'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1|(2|(4|(5|6)))'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1|2&!3'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1|2&3'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1|2'::tsquery

-- sqlfmt-corpus-separator --

SELECT '1|2|4|5|6'::tsquery

-- sqlfmt-corpus-separator --

SELECT '2006-08-13 12:34:56'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 21:00:00 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 21:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 21:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 22:00:00 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 22:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 22:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 22:59:59 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 22:59:59 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 22:59:59 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:00:00 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:00:01 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:00:01 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:00:01 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:59:59 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:59:59 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-26 23:59:59 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 00:00:00 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 00:00:00 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 00:00:00 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 00:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 00:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 00:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 00:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 01:00:00 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 01:00:00 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 01:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 01:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 01:59:59 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 01:59:59 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 01:59:59'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 01:59:59'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:00:00 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:00:00 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:00:01 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:00:01 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:00:01'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:00:01'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:59:59 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:59:59 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:59:59'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 02:59:59'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 03:00:00 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 03:00:00 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 03:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 03:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 03:00:01 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 03:00:01 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 03:00:01'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 03:00:01'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 04:00:00 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 04:00:00 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 04:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2011-03-27 04:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2012-12-12 12:00 America/New_York'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2012-12-12 12:00'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 21:00:00 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 21:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 21:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 21:59:59 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 21:59:59 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 21:59:59 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 22:00:00 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 22:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 22:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 22:00:01 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 22:00:01 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 22:00:01 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 23:00:00 UTC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 23:00:00 UTC'::timestamptz AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-25 23:00:00 UTC'::timestamptz AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 00:00:00 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 00:00:00 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 00:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 00:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 00:59:59 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 00:59:59 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 00:59:59'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 00:59:59'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 01:00:00 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 01:00:00 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 01:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 01:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 01:00:01 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 01:00:01 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 01:00:01'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 01:00:01'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 02:00:00 Europe/Moscow'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 02:00:00 MSK'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 02:00:00'::timestamp AT TIME ZONE 'Europe/Moscow'

-- sqlfmt-corpus-separator --

SELECT '2014-10-26 02:00:00'::timestamp AT TIME ZONE 'MSK'

-- sqlfmt-corpus-separator --

SELECT '2020-10-05'::timestamp > '2202020-10-05'::date as f

-- sqlfmt-corpus-separator --

SELECT '2020-10-05'::timestamptz > '2202020-10-05'::date as f

-- sqlfmt-corpus-separator --

SELECT '2020-10-05'::timestamptz >= '4714-11-24 BC'::date as t

-- sqlfmt-corpus-separator --

SELECT '2020-10-05'::timestamptz >= '4714-11-24 BC'::timestamp as t

-- sqlfmt-corpus-separator --

SELECT '205000-01-10 17:32:01 Europe/Helsinki'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '205000-07-10 17:32:01 Europe/Helsinki'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '20500110 173201 Europe/Helsinki'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '20500710 173201 Europe/Helsinki'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '2147483520'::float4::int4

-- sqlfmt-corpus-separator --

SELECT '2147483647'::float4::int4

-- sqlfmt-corpus-separator --

SELECT '2147483647.4'::float8::int4

-- sqlfmt-corpus-separator --

SELECT '2147483647.6'::float8::int4

-- sqlfmt-corpus-separator --

SELECT '2202020-10-05'::date > '2020-10-05'::timestamp as t

-- sqlfmt-corpus-separator --

SELECT '2202020-10-05'::date > '2020-10-05'::timestamptz as t

-- sqlfmt-corpus-separator --

SELECT '2202020-10-05'::date::timestamp

-- sqlfmt-corpus-separator --

SELECT '2202020-10-05'::date::timestamptz

-- sqlfmt-corpus-separator --

SELECT '23:59:59.999999 PDT'::timetz

-- sqlfmt-corpus-separator --

SELECT '23:59:59.999999'::time

-- sqlfmt-corpus-separator --

SELECT '23:59:59.9999999 PDT'::timetz

-- sqlfmt-corpus-separator --

SELECT '23:59:59.9999999'::time

-- sqlfmt-corpus-separator --

SELECT '23:59:60 PDT'::timetz

-- sqlfmt-corpus-separator --

SELECT '23:59:60'::time

-- sqlfmt-corpus-separator --

SELECT '23:59:60.01 PDT'::timetz

-- sqlfmt-corpus-separator --

SELECT '23:59:60.01'::time

-- sqlfmt-corpus-separator --

SELECT '24:00:00 PDT'::timetz

-- sqlfmt-corpus-separator --

SELECT '24:00:00'::time

-- sqlfmt-corpus-separator --

SELECT '24:00:00.01 PDT'::timetz

-- sqlfmt-corpus-separator --

SELECT '24:00:00.01'::time

-- sqlfmt-corpus-separator --

SELECT '24:01:00 PDT'::timetz

-- sqlfmt-corpus-separator --

SELECT '24:01:00'::time

-- sqlfmt-corpus-separator --

SELECT '25:00:00 PDT'::timetz

-- sqlfmt-corpus-separator --

SELECT '25:00:00'::time

-- sqlfmt-corpus-separator --

SELECT '294276-12-31 15:59:59-08'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '294276-12-31 23:59:59'::timestamp

-- sqlfmt-corpus-separator --

SELECT '294276-12-31 23:59:59+00'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '294277-01-01 00:00:00'::timestamp

-- sqlfmt-corpus-separator --

SELECT '294277-01-01 00:00:00+00'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '294277-12-31 16:00:00-08'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '3 days 5 milliseconds'::interval

-- sqlfmt-corpus-separator --

SELECT '3.4'::numeric UNION SELECT 'foo'

-- sqlfmt-corpus-separator --

SELECT '3000000 days'::interval * 1000

-- sqlfmt-corpus-separator --

SELECT '3000000 days'::interval / 0.001

-- sqlfmt-corpus-separator --

SELECT '3000000 months'::interval * 1000

-- sqlfmt-corpus-separator --

SELECT '3000000 months'::interval / 0.001

-- sqlfmt-corpus-separator --

SELECT '32767.4'::float4::int2

-- sqlfmt-corpus-separator --

SELECT '32767.4'::float8::int2

-- sqlfmt-corpus-separator --

SELECT '32767.6'::float4::int2

-- sqlfmt-corpus-separator --

SELECT '32767.6'::float8::int2

-- sqlfmt-corpus-separator --

SELECT '42'::float4 / 'Infinity'::float4

-- sqlfmt-corpus-separator --

SELECT '42'::float8 / 'Infinity'::float8

-- sqlfmt-corpus-separator --

SELECT '42'::int2::numeric

-- sqlfmt-corpus-separator --

SELECT '42'::money * '-inf'::float8

-- sqlfmt-corpus-separator --

SELECT '42'::money * 'inf'::float8

-- sqlfmt-corpus-separator --

SELECT '42'::money * 'nan'::float4

-- sqlfmt-corpus-separator --

SELECT '4611686018427387904 usec'::interval / 0.1

-- sqlfmt-corpus-separator --

SELECT '4714-11-23 16:00:00-08 BC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '4714-11-23 23:59:59 BC'::timestamp

-- sqlfmt-corpus-separator --

SELECT '4714-11-23 23:59:59+00 BC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '4714-11-24 00:00:00 BC'::timestamp

-- sqlfmt-corpus-separator --

SELECT '4714-11-24 00:00:00+00 BC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '4714-11-24 BC'::date < '2020-10-05'::timestamptz as t

-- sqlfmt-corpus-separator --

SELECT '4714-11-24 BC'::date::timestamptz

-- sqlfmt-corpus-separator --

SELECT '4714-11-24 BC'::timestamp < '2020-10-05'::timestamptz as t

-- sqlfmt-corpus-separator --

SELECT '5'::jsonb @> '5'

-- sqlfmt-corpus-separator --

SELECT '5'::jsonb @> '[5]'

-- sqlfmt-corpus-separator --

SELECT '5.5 seconds 3 milliseconds'::interval

-- sqlfmt-corpus-separator --

SELECT '5b35380a-7143-4912-9b55-f322699c6770'::uuid::bytea

-- sqlfmt-corpus-separator --

SELECT '878.08'::money / 11::bigint

-- sqlfmt-corpus-separator --

SELECT '878.08'::money / 11::float4

-- sqlfmt-corpus-separator --

SELECT '878.08'::money / 11::float8

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

SELECT '9223369837831520256'::float4::int8

-- sqlfmt-corpus-separator --

SELECT '9223372036854773760'::float8::int8

-- sqlfmt-corpus-separator --

SELECT '92233720368547758.07'::money

-- sqlfmt-corpus-separator --

SELECT '92233720368547758.07'::money * 2::float8

-- sqlfmt-corpus-separator --

SELECT '92233720368547758.07'::money * 2::int4

-- sqlfmt-corpus-separator --

SELECT '92233720368547758.07'::money + '0.01'::money

-- sqlfmt-corpus-separator --

SELECT '92233720368547758.07'::money::numeric

-- sqlfmt-corpus-separator --

SELECT '92233720368547758.075'::money

-- sqlfmt-corpus-separator --

SELECT '92233720368547758.08'::money

-- sqlfmt-corpus-separator --

SELECT '9223372036854775807'::float4::int8

-- sqlfmt-corpus-separator --

SELECT '9223372036854775807'::float8::int8

-- sqlfmt-corpus-separator --

SELECT '9223372036854775807'::money

-- sqlfmt-corpus-separator --

SELECT '9223372036854775808'::json

-- sqlfmt-corpus-separator --

SELECT '9223372036854775808'::jsonb

-- sqlfmt-corpus-separator --

SELECT 'ABC'::name ILIKE '_b_' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'ABC'::name NOT ILIKE '_b_' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'FFFFFFFF/FFFFFFFE'::pg_lsn + 1::numeric

-- sqlfmt-corpus-separator --

SELECT 'FFFFFFFF/FFFFFFFE'::pg_lsn + 2::numeric

-- sqlfmt-corpus-separator --

SELECT 'FFFFFFFF/FFFFFFFF'::pg_lsn - ('FFFFFFFF/FFFFFFFF'::pg_lsn - '0/0'::pg_lsn)

-- sqlfmt-corpus-separator --

SELECT 'Hawkeye' ILIKE 'h%' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'Hawkeye' NOT ILIKE 'h%' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::float4 + 100.0

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::float4 / 'Infinity'::float4

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::float4::numeric

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::float8 + 100.0

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::float8 / 'Infinity'::float8

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::float8::numeric

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::numeric::float4

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::numeric::float8

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::numeric::int2

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::numeric::int4

-- sqlfmt-corpus-separator --

SELECT 'Infinity'::numeric::int8

-- sqlfmt-corpus-separator --

SELECT 'Jan 01 00:00:00 1000 LMT'::timestamptz

-- sqlfmt-corpus-separator --

SELECT 'Jan 01 00:00:00 2024 LMT'::timestamptz

-- sqlfmt-corpus-separator --

SELECT 'N A N'::float4

-- sqlfmt-corpus-separator --

SELECT 'N A N'::float8

-- sqlfmt-corpus-separator --

SELECT 'NaN x'::float4

-- sqlfmt-corpus-separator --

SELECT 'NaN x'::float8

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float4

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float4::numeric

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float8

-- sqlfmt-corpus-separator --

SELECT 'NaN'::float8::numeric

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric::float4

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric::float8

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric::int2

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric::int4

-- sqlfmt-corpus-separator --

SELECT 'NaN'::numeric::int8

-- sqlfmt-corpus-separator --

SELECT 'Sun Nov 23 16:00:00 4714 PST BC'::timestamptz

-- sqlfmt-corpus-separator --

SELECT 'TrUe'::text::boolean AS true, 'fAlse'::text::boolean AS false

-- sqlfmt-corpus-separator --

SELECT 'Wed Jul 11 10:51:14 America/New_York 2001'::timestamptz

-- sqlfmt-corpus-separator --

SELECT 'Wed Jul 11 10:51:14 GMT+4 2001'::timestamptz

-- sqlfmt-corpus-separator --

SELECT 'Wed Jul 11 10:51:14 GMT-4 2001'::timestamptz

-- sqlfmt-corpus-separator --

SELECT 'Wed Jul 11 10:51:14 PST+03:00 2001'::timestamptz

-- sqlfmt-corpus-separator --

SELECT 'Wed Jul 11 10:51:14 PST-03:00 2001'::timestamptz

-- sqlfmt-corpus-separator --

SELECT '["9", ["7", "3"], 1]'::jsonb @> '["9", ["7", "3"], 1]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '["9", ["7", "3"], ["1"]]'::jsonb @> '["9", ["7", "3"], ["1"]]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '["a","b","c","b"]'::jsonb @> '["a","b"]'

-- sqlfmt-corpus-separator --

SELECT '["a","b","c",[1,2],null]'::jsonb -> -1

-- sqlfmt-corpus-separator --

SELECT '["a","b","c",[1,2],null]'::jsonb -> -5

-- sqlfmt-corpus-separator --

SELECT '["a","b","c",[1,2],null]'::jsonb -> -6

-- sqlfmt-corpus-separator --

SELECT '["a","b","c",[1,2],null]'::jsonb -> 0

-- sqlfmt-corpus-separator --

SELECT '["a","b","c",[1,2],null]'::jsonb -> 1

-- sqlfmt-corpus-separator --

SELECT '["a","b","c",[1,2],null]'::jsonb -> 2

-- sqlfmt-corpus-separator --

SELECT '["a","b","c",[1,2],null]'::jsonb -> 3

-- sqlfmt-corpus-separator --

SELECT '["a","b","c",[1,2],null]'::jsonb -> 3 -> 1

-- sqlfmt-corpus-separator --

SELECT '["a","b","c",[1,2],null]'::jsonb -> 4

-- sqlfmt-corpus-separator --

SELECT '["a","b","c",[1,2],null]'::jsonb -> 5

-- sqlfmt-corpus-separator --

SELECT '["a","b","c",[1,2]]'::jsonb @> '["a",[1,2]]'

-- sqlfmt-corpus-separator --

SELECT '["a","b","c",[1,2]]'::jsonb @> '["b",[1,2]]'

-- sqlfmt-corpus-separator --

SELECT '["a","b"]'::jsonb @> '["a","b","c","b"]'

-- sqlfmt-corpus-separator --

SELECT '[0,1,2,[3,4],{"5":"five"}]'::jsonb #> '{0}'

-- sqlfmt-corpus-separator --

SELECT '[0,1,2,[3,4],{"5":"five"}]'::jsonb #> '{3}'

-- sqlfmt-corpus-separator --

SELECT '[0,1,2,[3,4],{"5":"five"}]'::jsonb #> '{4,5}'

-- sqlfmt-corpus-separator --

SELECT '[0,1,2,[3,4],{"5":"five"}]'::jsonb #> '{4}'

-- sqlfmt-corpus-separator --

SELECT '[1,1,2]'::jsonb @> '[1,2,2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,2'::json

-- sqlfmt-corpus-separator --

SELECT '[1,2'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,2,2]'::jsonb <@ '[1,1,2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,2,2]'::jsonb <@ '[1,2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,2,]'::json

-- sqlfmt-corpus-separator --

SELECT '[1,2,]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,2]'::json

-- sqlfmt-corpus-separator --

SELECT '[1,2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,2]'::jsonb @> '[1,2,2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[1,[2]'::json

-- sqlfmt-corpus-separator --

SELECT '[1,[2]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[5]'::jsonb @> '5'

-- sqlfmt-corpus-separator --

SELECT '[5]'::jsonb @> '[5]'

-- sqlfmt-corpus-separator --

SELECT '[[1,2,2]]'::jsonb <@ '[[1,2]]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[[1,2]]'::jsonb @> '[[1,2,2]]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]'::json

-- sqlfmt-corpus-separator --

SELECT '[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[]'::json

-- sqlfmt-corpus-separator --

SELECT '[]'::jsonb

-- sqlfmt-corpus-separator --

SELECT '[]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[null]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[null]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"\ud83d" : [1, 2], "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"\ud83d" : [2,3], "dependency" : 4, "degree": 0.250}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : "a", "dependency" : 4, "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : "a", "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : 1, "dependency" : 4, "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : 1, "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : ["\ud83d", 2], "ndistinct" : 1}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : ["\ud83d",3], "dependency" : 4, "degree": 0.250}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [-7,-9], "dependency" : 4, "degree": 0.500}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [-7,-9], "ndistinct" : 1}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [0,1], "ndistinct" : 1}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [0,2], "dependency" : 4, "degree": 0.500}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [1, 2], "\ud83d" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [1, 2], "ndistinct" : "\ud83d"}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [1, {"a": 1}], "ndistinct" : 1}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [1, {}], "dependency" : 1, "degree": "1.2"}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [1,2,3,4,5,6,7,8,9], "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [1,2,3,4,5,6,7,8], "dependency" : 4, "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [1,2,3,4,5,6,7], "dependency" : -9, "degree": "1.2"}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [1,2,3,4,5,6,7], "dependency" : 0, "degree": "1.2"}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [1,2], "dependency" : 1, "degree": "a"}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [1,2], "dependency" : 3, "degree": {}}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [1,2], "dependency" : {}, "degree": 1.0}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [1,2], "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,"a"], "dependency" : 4, "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,"a"], "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,-1], "ndistinct" : 1},
         {"attributes" : [2,3,-1], "ndistinct" : 3}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,-1], "ndistinct" : 1},
         {"attributes" : [3,-1], "ndistinct" : 2},
         {"attributes" : [2,3,-1], "ndistinct" : 3}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,2], "dependency" : 4, "degree": 0.500}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,2], "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "attributes" : [1,3], "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "attributes": [1,2], "dependency" : 4, "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "degree" : 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency" : "\ud83d", "degree": 0.250}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency" : "a", "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency" : 4, "degree": "\ud83d"}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency" : 4, "degree": 0.250},
         {"attributes" : [2,-1], "dependency" : 4, "degree": 0.500},
         {"attributes" : [2,3,-1], "dependency" : 4, "degree": 0.750},
         {"attributes" : [2,3,-1,-2], "dependency" : 4, "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency" : 4, "degree": 1.000},
         {"attributes" : [1,-1], "dependency" : 4, "degree": 1.000},
         {"attributes" : [2,3,-1], "dependency" : 4, "degree": 1.000},
         {"attributes" : [2,3,-1,-2], "dependency" : 4, "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency" : 4, "degree": 1.000},
         {"attributes" : [2,3], "dependency" : 4, "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency" : 4, "degree": NaN}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency" : 4, "dependency": 4, "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency" : 4}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency" : [1,null], "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency" : [], "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency" : [null], "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency" : null, "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "dependency": 4, "degree": 1.000, "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "invalid" : 3, "dependency" : 4}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "invalid" : 3, "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "ndistinct" : "a"}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "ndistinct" : 4, "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "ndistinct" : 4},
         {"attributes" : [2,-1], "ndistinct" : 4},
         {"attributes" : [2,3,-1], "ndistinct" : 4},
         {"attributes" : [1,3,-1,-2], "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "ndistinct" : 4},
         {"attributes" : [2,3], "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "ndistinct" : [1,null]}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "ndistinct" : []}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "ndistinct" : [null]}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "ndistinct" : null}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3], "ndistinct" : {"a": 1}}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,3]}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,null], "dependency" : 4, "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2,null], "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2], "dependency" : 4, "degree": "-inf"}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2], "dependency" : 4, "degree": "-inf"}]'::pg_dependencies::text::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2], "dependency" : 4, "degree": "NaN"}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2], "dependency" : 4, "degree": "inf"}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [2], "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : [], "ndistinct" : 1}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : null, "dependency" : 4, "degree": 1.000}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : null, "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : {"a": 1}, "dependency" : 4, "degree": "1.2"}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes" : {"a": 1}, "ndistinct" : 1}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"attributes": [1,2], "dependency": 2, "degree": 1}]' ::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes": [], "dependency": 2, "degree": 1}]' ::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes_invalid" : [2,3], "dependency" : 4}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"attributes_invalid" : [2,3], "ndistinct" : 4}]'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '[{"dependency" : 4, "degree": "1.2"}]'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '[{"ndistinct" : 4}]'::pg_ndistinct

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

SELECT '\x019a2f859ced7225b99d9c55044a2563'::bytea::uuid

-- sqlfmt-corpus-separator --

SELECT '\x112233445566778899'::bytea::int8

-- sqlfmt-corpus-separator --

SELECT '\x123456'::bytea::int2

-- sqlfmt-corpus-separator --

SELECT '\x1234567890abcdef'::bytea::uuid

-- sqlfmt-corpus-separator --

SELECT '\x123456789A'::bytea::int4

-- sqlfmt-corpus-separator --

SELECT 'a & !!b'::tsquery

-- sqlfmt-corpus-separator --

SELECT 'a & g' <-> 'b & d'::tsquery

-- sqlfmt-corpus-separator --

SELECT 'a & g' <-> 'b <-> d'::tsquery

-- sqlfmt-corpus-separator --

SELECT 'a & g' <-> 'b | d'::tsquery

-- sqlfmt-corpus-separator --

SELECT 'a b:89  ca:23A,64b cb:80c d:34c'::tsvector @@ 'd:AC & c:*C' as "true"

-- sqlfmt-corpus-separator --

SELECT 'a b:89  ca:23A,64b d:34c'::tsvector @@ 'd:AC & c:*C' as "false"

-- sqlfmt-corpus-separator --

SELECT 'a b:89  ca:23A,64b d:34c'::tsvector @@ 'd:AC & c:*CB' as "true"

-- sqlfmt-corpus-separator --

SELECT 'a b:89  ca:23A,64b d:34c'::tsvector @@ 'd:AC & ca' as "true"

-- sqlfmt-corpus-separator --

SELECT 'a b:89  ca:23A,64b d:34c'::tsvector @@ 'd:AC & ca:A' as "true"

-- sqlfmt-corpus-separator --

SELECT 'a b:89  ca:23A,64b d:34c'::tsvector @@ 'd:AC & ca:B' as "true"

-- sqlfmt-corpus-separator --

SELECT 'a b:89  ca:23A,64b d:34c'::tsvector @@ 'd:AC & ca:C' as "false"

-- sqlfmt-corpus-separator --

SELECT 'a b:89  ca:23A,64b d:34c'::tsvector @@ 'd:AC & ca:CB' as "true"

-- sqlfmt-corpus-separator --

SELECT 'a b:89  ca:23A,64c cb:80b d:34c'::tsvector @@ 'd:AC & c:*B' as "true"

-- sqlfmt-corpus-separator --

SELECT 'a b:89  ca:23A,64c cb:80b d:34c'::tsvector @@ 'd:AC & c:*C' as "true"

-- sqlfmt-corpus-separator --

SELECT 'a | f | g' < 'b & c'::tsquery as "false"

-- sqlfmt-corpus-separator --

SELECT 'a | f' < 'b & c'::tsquery as "false"

-- sqlfmt-corpus-separator --

SELECT 'a | ff' < 'b & c'::tsquery as "false"

-- sqlfmt-corpus-separator --

SELECT 'a' < 'b & c'::tsquery as "true"

-- sqlfmt-corpus-separator --

SELECT 'a' <-> 'b & d'::tsquery

-- sqlfmt-corpus-separator --

SELECT 'a' > 'b & c'::tsquery as "false"

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::text

-- sqlfmt-corpus-separator --

SELECT 'a'::text::"char"

-- sqlfmt-corpus-separator --

SELECT 'a:* & nbb:*ac | doo:a* | goo'::tsquery

-- sqlfmt-corpus-separator --

SELECT 'a:1 b:2'::tsvector @@ 'a <-> b'::tsquery AS "true"

-- sqlfmt-corpus-separator --

SELECT 'a:1 b:2'::tsvector @@ 'a <0> b'::tsquery AS "false"

-- sqlfmt-corpus-separator --

SELECT 'a:1 b:2'::tsvector @@ 'a <1> b'::tsquery AS "true"

-- sqlfmt-corpus-separator --

SELECT 'a:1 b:2'::tsvector @@ 'a <2> b'::tsquery AS "false"

-- sqlfmt-corpus-separator --

SELECT 'a:1 b:3'::tsvector @@ 'a <-> b'::tsquery AS "false"

-- sqlfmt-corpus-separator --

SELECT 'a:1 b:3'::tsvector @@ 'a <0> a:*'::tsquery AS "true"

-- sqlfmt-corpus-separator --

SELECT 'a:1 b:3'::tsvector @@ 'a <0> b'::tsquery AS "false"

-- sqlfmt-corpus-separator --

SELECT 'a:1 b:3'::tsvector @@ 'a <1> b'::tsquery AS "false"

-- sqlfmt-corpus-separator --

SELECT 'a:1 b:3'::tsvector @@ 'a <2> b'::tsquery AS "true"

-- sqlfmt-corpus-separator --

SELECT 'a:1 b:3'::tsvector @@ 'a <3> b'::tsquery AS "false"

-- sqlfmt-corpus-separator --

SELECT 'a:3A b:2a'::tsvector || 'ba:1234 a:1B'

-- sqlfmt-corpus-separator --

SELECT 'a_c'::bytea LIKE 'a$__'::bytea ESCAPE '$'::bytea AS "true"

-- sqlfmt-corpus-separator --

SELECT 'a_c'::bytea NOT LIKE 'a$__'::bytea ESCAPE '$'::bytea AS "false"

-- sqlfmt-corpus-separator --

SELECT 'abc'::bytea LIKE '_b_'::bytea AS "true"

-- sqlfmt-corpus-separator --

SELECT 'abc'::bytea NOT LIKE '_b_'::bytea AS "false"

-- sqlfmt-corpus-separator --

SELECT 'abc'::name LIKE '_b_' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'abc'::name NOT LIKE '_b_' AS "false"

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

SELECT 'bad'::bogon

-- sqlfmt-corpus-separator --

SELECT 'bad'::bogus

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

SELECT 'empty'::numrange && nummultirange()

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange && nummultirange(numrange(1,2))

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange &< nummultirange()

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange &< nummultirange(numrange(1,2))

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange &> nummultirange()

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange &> nummultirange(numrange(1,2))

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange -|- nummultirange()

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange -|- nummultirange(numrange(1,2))

-- sqlfmt-corpus-separator --

SELECT 'empty'::numrange <@ nummultirange()

-- sqlfmt-corpus-separator --

SELECT 'false'::json

-- sqlfmt-corpus-separator --

SELECT 'false'::jsonb

-- sqlfmt-corpus-separator --

SELECT 'foo & bar'::tsquery && 'asd | fg'

-- sqlfmt-corpus-separator --

SELECT 'foo & bar'::tsquery && 'asd'

-- sqlfmt-corpus-separator --

SELECT 'foo & bar'::tsquery || !!'asd & fg'::tsquery

-- sqlfmt-corpus-separator --

SELECT 'foo & bar'::tsquery || 'asd & fg'

-- sqlfmt-corpus-separator --

SELECT 'foo' LIKE '%_' as t, 'f' LIKE '%_' as t, '' LIKE '%_' as f

-- sqlfmt-corpus-separator --

SELECT 'foo' LIKE '%__' as t, 'foo' LIKE '%___' as t, 'foo' LIKE '%____' as f

-- sqlfmt-corpus-separator --

SELECT 'foo' LIKE '_%' as t, 'f' LIKE '_%' as t, '' LIKE '_%' as f

-- sqlfmt-corpus-separator --

SELECT 'foo' LIKE '__%' as t, 'foo' LIKE '___%' as t, 'foo' LIKE '____%' as f

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

SELECT 'hawkeye' ILIKE 'H%' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' ILIKE 'H%Eye' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' ILIKE 'h%' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' LIKE 'H%' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' LIKE 'h%' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' LIKE 'h%' ESCAPE '#' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' LIKE 'h%eye' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' LIKE 'indio%' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' NOT ILIKE 'H%' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' NOT ILIKE 'H%Eye' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' NOT ILIKE 'h%' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' NOT LIKE 'H%' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' NOT LIKE 'h%' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' NOT LIKE 'h%' ESCAPE '#' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' NOT LIKE 'h%eye' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'hawkeye' NOT LIKE 'indio%' AS "true"

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

SELECT 'indio' LIKE '_ndio' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'indio' LIKE '_ndio' ESCAPE '$' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'indio' LIKE 'in__o' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'indio' LIKE 'in_o' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'indio' LIKE 'ind_o' ESCAPE '$' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'indio' NOT LIKE '_ndio' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'indio' NOT LIKE '_ndio' ESCAPE '$' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'indio' NOT LIKE 'in__o' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'indio' NOT LIKE 'in_o' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'indio' NOT LIKE 'ind_o' ESCAPE '$' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'inf'::numeric % '0'

-- sqlfmt-corpus-separator --

SELECT 'inf'::numeric / '0'

-- sqlfmt-corpus-separator --

SELECT 'infinity'::float4

-- sqlfmt-corpus-separator --

SELECT 'infinity'::float8

-- sqlfmt-corpus-separator --

SELECT 'infinity'::interval::time

-- sqlfmt-corpus-separator --

SELECT 'jack' LIKE '%____%' AS t

-- sqlfmt-corpus-separator --

SELECT 'ma%a' LIKE 'm%a%%a' ESCAPE '%' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'ma%a' NOT LIKE 'm%a%%a' ESCAPE '%' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'maca' LIKE 'm%aca' ESCAPE '%' AS "true"

-- sqlfmt-corpus-separator --

SELECT 'maca' NOT LIKE 'm%aca' ESCAPE '%' AS "false"

-- sqlfmt-corpus-separator --

SELECT 'mauve'::rainbow

-- sqlfmt-corpus-separator --

SELECT 'nan'::float4

-- sqlfmt-corpus-separator --

SELECT 'nan'::float4 / '0'::float4

-- sqlfmt-corpus-separator --

SELECT 'nan'::float4 / 'nan'::float4

-- sqlfmt-corpus-separator --

SELECT 'nan'::float8

-- sqlfmt-corpus-separator --

SELECT 'nan'::float8 / '0'::float8

-- sqlfmt-corpus-separator --

SELECT 'nan'::float8 / 'nan'::float8

-- sqlfmt-corpus-separator --

SELECT 'nan'::numeric % '0'

-- sqlfmt-corpus-separator --

SELECT 'nan'::numeric / '0'

-- sqlfmt-corpus-separator --

SELECT 'nan'::numeric::float4

-- sqlfmt-corpus-separator --

SELECT 'nan'::numeric::float8

-- sqlfmt-corpus-separator --

SELECT 'new'::bogus

-- sqlfmt-corpus-separator --

SELECT 'null'::json

-- sqlfmt-corpus-separator --

SELECT 'null'::jsonb

-- sqlfmt-corpus-separator --

SELECT 'null'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT 'null'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT 'purple'::rainbow::rgb

-- sqlfmt-corpus-separator --

SELECT 'purple'::rgb

-- sqlfmt-corpus-separator --

SELECT 'red' = ALL ('{red,green,blue}'::rainbow[])

-- sqlfmt-corpus-separator --

SELECT 'red' = ALL ('{red,red}'::rainbow[])

-- sqlfmt-corpus-separator --

SELECT 'red' = ANY ('{red,green,blue}'::rainbow[])

-- sqlfmt-corpus-separator --

SELECT 'red'::rainbow

-- sqlfmt-corpus-separator --

SELECT 'red'::rainbow::text || 'hithere'

-- sqlfmt-corpus-separator --

SELECT 'red'::rgb

-- sqlfmt-corpus-separator --

SELECT 'red'::text::rainbow = 'red'::rainbow

-- sqlfmt-corpus-separator --

SELECT 'supeanova supernova'::tsvector @@ 'super'::tsquery AS "false"

-- sqlfmt-corpus-separator --

SELECT 'supeanova supernova'::tsvector @@ 'super:*'::tsquery AS "true"

-- sqlfmt-corpus-separator --

SELECT 'supernova'::tsvector @@ 'super'::tsquery AS "false"

-- sqlfmt-corpus-separator --

SELECT 'supernova'::tsvector @@ 'super:*'::tsquery AS "true"

-- sqlfmt-corpus-separator --

SELECT 'supeznova supernova'::tsvector @@ 'super'::tsquery AS "false"

-- sqlfmt-corpus-separator --

SELECT 'supeznova supernova'::tsvector @@ 'super:*'::tsquery AS "true"

-- sqlfmt-corpus-separator --

SELECT 'true false'::json

-- sqlfmt-corpus-separator --

SELECT 'true false'::jsonb

-- sqlfmt-corpus-separator --

SELECT 'true'::json

-- sqlfmt-corpus-separator --

SELECT 'true'::jsonb

-- sqlfmt-corpus-separator --

SELECT 'true, false'::json

-- sqlfmt-corpus-separator --

SELECT 'true, false'::jsonb

-- sqlfmt-corpus-separator --

SELECT 'trues'::json

-- sqlfmt-corpus-separator --

SELECT 'trues'::jsonb

-- sqlfmt-corpus-separator --

SELECT 'truf'::json

-- sqlfmt-corpus-separator --

SELECT 'truf'::jsonb

-- sqlfmt-corpus-separator --

SELECT 'wa:1A wb:2D'::tsvector @@ 'w:*D <-> w:*A'::tsquery as "false"

-- sqlfmt-corpus-separator --

SELECT 'wa:1A'::tsvector @@ '!w:*A'::tsquery as "false"

-- sqlfmt-corpus-separator --

SELECT 'wa:1A'::tsvector @@ '!w:*D'::tsquery as "true"

-- sqlfmt-corpus-separator --

SELECT 'wa:1A'::tsvector @@ 'w:*A'::tsquery as "true"

-- sqlfmt-corpus-separator --

SELECT 'wa:1A'::tsvector @@ 'w:*D'::tsquery as "false"

-- sqlfmt-corpus-separator --

SELECT 'wa:1D wb:2A'::tsvector @@ 'w:*D & w:*A'::tsquery as "true"

-- sqlfmt-corpus-separator --

SELECT 'wa:1D wb:2A'::tsvector @@ 'w:*D <-> w:*A'::tsquery as "true"

-- sqlfmt-corpus-separator --

SELECT 'yellow' = ANY ('{red,green,blue}'::rainbow[])

-- sqlfmt-corpus-separator --

SELECT '{
		"one": 1,
		"two":"two",
		"averyveryveryveryveryveryveryveryveryverylongfieldname":}'::json

-- sqlfmt-corpus-separator --

SELECT '{
		"one": 1,
		"two":"two",
		"averyveryveryveryveryveryveryveryveryverylongfieldname":}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{
		"one": 1,
		"two":"two",
		"three":
		true}'::json

-- sqlfmt-corpus-separator --

SELECT '{
		"one": 1,
		"two":"two",
		"three":
		true}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{
		"one": 1,
		"two":,"two",  -- ERROR extraneous comma before field "two"
		"three":
		true}'::json

-- sqlfmt-corpus-separator --

SELECT '{
		"one": 1,
		"two":,"two",  -- ERROR extraneous comma before field "two"
		"three":
		true}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{ "name": "Bob", "tags": [ "enim", "qui"]}'::jsonb @> '{"tags":["qu"]}'

-- sqlfmt-corpus-separator --

SELECT '{"a": 1}'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '{"a": 1}'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "b":1, "c":null}'::jsonb @> '{"a":"b", "c":"q"}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "b":1, "c":null}'::jsonb @> '{"a":"b", "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "b":1, "c":null}'::jsonb @> '{"a":"b", "g":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "b":1, "c":null}'::jsonb @> '{"a":"b"}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "b":1, "c":null}'::jsonb @> '{"a":"c"}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "b":1, "c":null}'::jsonb @> '{"g":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "c":"q"}'::jsonb <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "c":null}'::jsonb <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b", "g":null}'::jsonb <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{0}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{a}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,-1}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,-3}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,-4}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,0}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,1}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,2}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c,3}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b","c":[1,2,3]}'::jsonb #> '{c}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"b"}'::jsonb <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":"c"}'::jsonb <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"a":[1,2,{"c":3,"x":4}],"c":"b"}'::jsonb @> '{"a":[{"c":3}]}'

-- sqlfmt-corpus-separator --

SELECT '{"a":[1,2,{"c":3,"x":4}],"c":"b"}'::jsonb @> '{"a":[{"x":4},1]}'

-- sqlfmt-corpus-separator --

SELECT '{"a":[1,2,{"c":3,"x":4}],"c":"b"}'::jsonb @> '{"a":[{"x":4},3]}'

-- sqlfmt-corpus-separator --

SELECT '{"a":[1,2,{"c":3,"x":4}],"c":"b"}'::jsonb @> '{"a":[{"x":4}]}'

-- sqlfmt-corpus-separator --

SELECT '{"a":[1,2],"c":"b"}'::jsonb @> '{"a":[1,2]}'

-- sqlfmt-corpus-separator --

SELECT '{"a":[1,2],"c":"b"}'::jsonb @> '{"a":[1]}'

-- sqlfmt-corpus-separator --

SELECT '{"a":[1,2],"c":"b"}'::jsonb @> '{"a":[2]}'

-- sqlfmt-corpus-separator --

SELECT '{"a":[1,2],"c":"b"}'::jsonb @> '{"a":[3]}'

-- sqlfmt-corpus-separator --

SELECT '{"a":[2,1],"c":"b"}'::jsonb @> '{"a":[1,2]}'

-- sqlfmt-corpus-separator --

SELECT '{"a":{"1":2},"c":"b"}'::jsonb @> '{"a":[1,2]}'

-- sqlfmt-corpus-separator --

SELECT '{"a":{"1":2},"c":"b"}'::jsonb @> '{"a":{"1":2}}'

-- sqlfmt-corpus-separator --

SELECT '{"a":{"2":1},"c":"b"}'::jsonb @> '{"a":[1,2]}'

-- sqlfmt-corpus-separator --

SELECT '{"a":{"2":1},"c":"b"}'::jsonb @> '{"a":{"1":2}}'

-- sqlfmt-corpus-separator --

SELECT '{"aa":["a","aaa"],"qq":{"a":"12","b":"16","c":["c1","c2",["c3"],{"c4":4}],"d":{"d1":"d1","d2":"d2"}}}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"aa":["a","aaa"],"qq":{"a":"12","b":"16","c":["c1","c2"],"d":{"d1":"d1","d2":"d2"}}}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"aa":["a","aaa"],"qq":{"a":12,"b":16,"c":["c1","c2"],"d":{"d1":"d1","d2":"d2","d1":"d3"}}}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"abc",1}'::json

-- sqlfmt-corpus-separator --

SELECT '{"abc",1}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"abc":1,"def":2,"ghi":[3,4],"hij":{"klm":5,"nop":[6]}}'::json

-- sqlfmt-corpus-separator --

SELECT '{"abc":1,"def":2,"ghi":[3,4],"hij":{"klm":5,"nop":[6]}}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"abc":1,3}'::json

-- sqlfmt-corpus-separator --

SELECT '{"abc":1,3}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"abc":1:2}'::json

-- sqlfmt-corpus-separator --

SELECT '{"abc":1:2}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"abc":1}'::json

-- sqlfmt-corpus-separator --

SELECT '{"abc":1}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"abc"::1}'::json

-- sqlfmt-corpus-separator --

SELECT '{"abc"::1}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"abc"=1}'::json

-- sqlfmt-corpus-separator --

SELECT '{"abc"=1}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"abc"}'::json

-- sqlfmt-corpus-separator --

SELECT '{"abc"}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"ff":["a","aaa"]}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"ff":{"a":12,"b":16},"qq":123}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"ff":{"a":12,"b":16}}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"g":null}'::jsonb <@ '{"a":"b", "b":1, "c":null}'

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'a'

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'b'

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'c'

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'd'

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'd' -> '1'

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'e'

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 'n'

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb -> 0

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb ? 'a'

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb ? 'b'

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb ? 'c'

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb ? 'd'

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb ? 'e'

-- sqlfmt-corpus-separator --

SELECT '{"n":null,"a":1,"b":[1,2],"c":{"1":2},"d":{"1":[2,3]}}'::jsonb ? 'n'

-- sqlfmt-corpus-separator --

SELECT '{"x":"y"}'::jsonb <> '{"x":"y"}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"x":"y"}'::jsonb <> '{"x":"z"}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"x":"y"}'::jsonb = '{"x":"y"}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{"x":"y"}'::jsonb = '{"x":"z"}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{1,null,3}'::int[]

-- sqlfmt-corpus-separator --

SELECT '{1:"abc"}'::json

-- sqlfmt-corpus-separator --

SELECT '{1:"abc"}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{1}'::int4[]::int8[]

-- sqlfmt-corpus-separator --

SELECT '{[-4,-2), [1,5)}'::nummultirange <@ '{[1,9)}'

-- sqlfmt-corpus-separator --

SELECT '{[-4,-2), [1,5)}'::nummultirange @> '{[1,5)}'

-- sqlfmt-corpus-separator --

SELECT '{[1,3)}'::nummultirange * '{[0,2)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,3)}'::nummultirange * '{[0,5)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,3)}'::nummultirange * '{[1,5)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,3)}'::nummultirange * '{[2,5)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,4), [7,10)}'::nummultirange * '{[-5,-4), [5,6), [9,12)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,4), [7,10)}'::nummultirange * '{[0,2), [3,8), [9,12)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,4), [7,10)}'::nummultirange * '{[0,8), [9,12)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,4), [7,10)}'::nummultirange * '{[9,12)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,4)}'::nummultirange * '{[0,2), [3,5)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,4)}'::nummultirange * '{[2,3)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,5), [6,10)}'::nummultirange <@ '{[1,9)}'

-- sqlfmt-corpus-separator --

SELECT '{[1,5), [6,9)}'::nummultirange <@ '{[1,9)}'

-- sqlfmt-corpus-separator --

SELECT '{[1,5), [6,9)}'::nummultirange @> '{[6,7)}'

-- sqlfmt-corpus-separator --

SELECT '{[1,5), [8,9)}'::nummultirange <@ '{[1,9)}'

-- sqlfmt-corpus-separator --

SELECT '{[1,5), [8,9)}'::nummultirange @> '{[1,5)}'

-- sqlfmt-corpus-separator --

SELECT '{[1,5), [8,9)}'::nummultirange @> '{[6,7)}'

-- sqlfmt-corpus-separator --

SELECT '{[1,5)}' <@ '{[-4,-2), [1,5)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,5)}' <@ '{[1,5), [8,9)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,5)}' <@ '{[1,5)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,5)}'::nummultirange <@ '{[1,9)}'

-- sqlfmt-corpus-separator --

SELECT '{[1,5)}'::nummultirange @> '{[1,5)}'

-- sqlfmt-corpus-separator --

SELECT '{[1,9)}' @> '{[-4,-2), [1,5)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,9)}' @> '{[1,5), [6,10)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,9)}' @> '{[1,5), [6,9)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,9)}' @> '{[1,5), [8,9)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[1,9)}' @> '{[1,5)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[6,7)}' <@ '{[1,5), [6,9)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{[6,7)}' <@ '{[1,5), [8,9)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT '{red,green,blue}'::rainbow[]

-- sqlfmt-corpus-separator --

SELECT '{}'::json

-- sqlfmt-corpus-separator --

SELECT '{}'::jsonb

-- sqlfmt-corpus-separator --

SELECT '{}'::pg_dependencies

-- sqlfmt-corpus-separator --

SELECT '{}'::pg_ndistinct

-- sqlfmt-corpus-separator --

SELECT ('"'||repeat('.', 12)||'abc"')::json

-- sqlfmt-corpus-separator --

SELECT ('"'||repeat('.', 12)||'abc\n"')::json

-- sqlfmt-corpus-separator --

SELECT ('127.0.0.1'::inet + 257) - 257

-- sqlfmt-corpus-separator --

SELECT ('127::1'::inet + 257) - 257

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

SELECT (-12345)::money

-- sqlfmt-corpus-separator --

SELECT (-1234567890)::int4::money

-- sqlfmt-corpus-separator --

SELECT (-1234567890)::money

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

SELECT (-32768)::int2 % (-1)::int2

-- sqlfmt-corpus-separator --

SELECT (-32768)::int2 * (-1)::int2

-- sqlfmt-corpus-separator --

SELECT (-32768)::int2 / (-1)::int2

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

SELECT (SELECT x FROM s1 LIMIT 1) xx, * FROM s2 WHERE y like '%28%'

-- sqlfmt-corpus-separator --

SELECT (count(*) OVER (PARTITION BY four ORDER BY ten) +
  sum(hundred) OVER (PARTITION BY four ORDER BY ten))::varchar AS cntsum
  FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT (n_tup_ins + n_tup_upd) > 0 AS has_data FROM pg_stat_all_tables
  WHERE relid = 'pg_shdescription'::regclass

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
   FROM b_star* x
   WHERE x.b = text 'bumble' or x.a < 3

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

SELECT * FROM INT8_TBL WHERE '123'::int2 < q1

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE '123'::int2 <= q1

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE '123'::int2 <> q1

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE '123'::int2 = q1

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE '123'::int2 > q1

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE '123'::int2 >= q1

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 < '456'::int2

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 <= '456'::int2

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 <> '456'::int2

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 = '456'::int2

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 > '456'::int2

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 >= '456'::int2

-- sqlfmt-corpus-separator --

SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 < interval '@ 1 day'

-- sqlfmt-corpus-separator --

SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 <= interval '@ 5 hours'

-- sqlfmt-corpus-separator --

SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 <> interval '@ 10 days'

-- sqlfmt-corpus-separator --

SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 = interval '@ 34 years'

-- sqlfmt-corpus-separator --

SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 > interval '@ 3 seconds ago'

-- sqlfmt-corpus-separator --

SELECT * FROM INTERVAL_TBL
   WHERE INTERVAL_TBL.f1 >= interval '@ 1 month'

-- sqlfmt-corpus-separator --

SELECT * FROM ONLY base_tbl_parent ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM ONLY measurement ORDER BY city_id, logdate

-- sqlfmt-corpus-separator --

SELECT * FROM ONLY rw_view1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM T WHERE c_text LIKE '"%"' ORDER BY PK

-- sqlfmt-corpus-separator --

SELECT * FROM atest1 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM atest1 WHERE ( b IN ( SELECT col1 FROM atest2 ) )

-- sqlfmt-corpus-separator --

SELECT * FROM atest2 FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT * FROM atest2 WHERE ( col1 IN ( SELECT b FROM atest1 ) )

-- sqlfmt-corpus-separator --

SELECT * FROM byteatest WHERE a LIKE '%1%'

-- sqlfmt-corpus-separator --

SELECT * FROM clstr_1 UNION ALL
  SELECT * FROM clstr_2 UNION ALL
  SELECT * FROM clstr_3

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 WHERE b ILIKE '%bc%'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 WHERE b ILIKE 'abc%'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 WHERE b ILIKE 'abc'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 WHERE b LIKE '%bc%'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 WHERE b LIKE 'abc%'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 WHERE b LIKE 'abc'

-- sqlfmt-corpus-separator --

SELECT * FROM empsalary WHERE row_number() OVER (ORDER BY salary) < 10

-- sqlfmt-corpus-separator --

SELECT * FROM foo ORDER BY f1 DESC NULLS LAST

-- sqlfmt-corpus-separator --

SELECT * FROM foo ORDER BY f1 NULLS FIRST

-- sqlfmt-corpus-separator --

SELECT * FROM gpolygon_tbl ORDER BY f1 <-> '(0,0)'::point LIMIT 10

-- sqlfmt-corpus-separator --

SELECT * FROM hash_f8_heap
   WHERE hash_f8_heap.random = '444705537'::float8

-- sqlfmt-corpus-separator --

SELECT * FROM hash_f8_heap
   WHERE hash_f8_heap.random = '88888888'::float8

-- sqlfmt-corpus-separator --

SELECT * FROM hash_name_heap
   WHERE hash_name_heap.random = '1505703298'::name

-- sqlfmt-corpus-separator --

SELECT * FROM hash_name_heap
   WHERE hash_name_heap.random = '7777777'::name

-- sqlfmt-corpus-separator --

SELECT * FROM hash_txt_heap
   WHERE hash_txt_heap.random = '111111112222222233333333'::text

-- sqlfmt-corpus-separator --

SELECT * FROM hash_txt_heap
   WHERE hash_txt_heap.random = '1351610853'::text

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE '192.168.1.0/24'::cidr >> i

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE '192.168.1.0/24'::cidr >>= i

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE i && '192.168.1.0/24'::cidr ORDER BY i

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE i < '192.168.1.0/24'::cidr ORDER BY i

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE i << '192.168.1.0/24'::cidr ORDER BY i

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE i <<= '192.168.1.0/24'::cidr ORDER BY i

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE i <= '192.168.1.0/24'::cidr ORDER BY i

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE i <> '192.168.1.0/24'::cidr ORDER BY i

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE i = '192.168.1.0/24'::cidr ORDER BY i

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE i > '192.168.1.0/24'::cidr ORDER BY i

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE i >= '192.168.1.0/24'::cidr ORDER BY i

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE i >> '192.168.1.0/24'::cidr ORDER BY i

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE i >>= '192.168.1.0/24'::cidr ORDER BY i

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE i<<'192.168.1.0/24'::cidr

-- sqlfmt-corpus-separator --

SELECT * FROM inet_tbl WHERE i<<='192.168.1.0/24'::cidr

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.pg_property_graph_privileges WHERE grantee LIKE 'regress%' ORDER BY property_graph_name, grantor, grantee, privilege_type

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.views WHERE table_name LIKE E'rw\\_view_' ORDER BY table_name

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_tvvm FOR SHARE

-- sqlfmt-corpus-separator --

SELECT * FROM not_null_tab
WHERE id NOT IN (SELECT id FROM notnull_notvalid_tab)

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE '{[4.0,4.2), [6.0, 8.0)}'::nummultirange <@ nmr

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr @> '{[4.0,4.2), [6.0, 8.0)}'::nummultirange

-- sqlfmt-corpus-separator --

SELECT * FROM onek EXCEPT ALL SELECT * FROM onek_copy

-- sqlfmt-corpus-separator --

SELECT * FROM onek_copy EXCEPT ALL SELECT * FROM onek

-- sqlfmt-corpus-separator --

SELECT * FROM pg_enum WHERE NOT EXISTS
  (SELECT 1 FROM pg_type WHERE pg_type.oid = enumtypid)

-- sqlfmt-corpus-separator --

SELECT * FROM point_tbl WHERE f1 <@ '(-10,-10),(10,10)':: box ORDER BY f1 <-> '0,1'

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

SELECT * FROM textrange_test WHERE 'e'::text <@ tr

-- sqlfmt-corpus-separator --

SELECT * FROM texttest WHERE a LIKE '%1%'

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

SELECT *, tableoid::regclass::text FROM SYS_COL_CHECK_TBL

-- sqlfmt-corpus-separator --

SELECT -('-2147483647 days'::interval)

-- sqlfmt-corpus-separator --

SELECT -('-2147483647 months -2147483647 days -9223372036854775807 us'::interval)

-- sqlfmt-corpus-separator --

SELECT -('-2147483647 months'::interval)

-- sqlfmt-corpus-separator --

SELECT -('-2147483648 days'::interval)

-- sqlfmt-corpus-separator --

SELECT -('-2147483648 months'::interval)

-- sqlfmt-corpus-separator --

SELECT -('-9223372036854775807 us'::interval)

-- sqlfmt-corpus-separator --

SELECT -('-9223372036854775808 us'::interval)

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

SELECT -interval '-2147483647 months -2147483647 days -9223372036854775807 us'

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

SELECT 1 FROM pg_statistic_ext WHERE stxrelid = 'stxdinp'::regclass

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

SELECT 12345678901234567::int8::money

-- sqlfmt-corpus-separator --

SELECT 12345678901234567::money

-- sqlfmt-corpus-separator --

SELECT 12345678901234567::numeric::money

-- sqlfmt-corpus-separator --

SELECT 1234567890::int4::money

-- sqlfmt-corpus-separator --

SELECT 1234567890::money

-- sqlfmt-corpus-separator --

SELECT 1234::int4::casttesttype

-- sqlfmt-corpus-separator --

SELECT 16::numeric + '0/16AE7F7'::pg_lsn

-- sqlfmt-corpus-separator --

SELECT 1::boolean

-- sqlfmt-corpus-separator --

SELECT 1::int2::oid8

-- sqlfmt-corpus-separator --

SELECT 1::int4::oid8

-- sqlfmt-corpus-separator --

SELECT 1::int8::oid8

-- sqlfmt-corpus-separator --

SELECT 1::oid8::int8

-- sqlfmt-corpus-separator --

SELECT 1::oid8::oid

-- sqlfmt-corpus-separator --

SELECT 1::oid::oid8

-- sqlfmt-corpus-separator --

SELECT 2 IS DISTINCT FROM 2 as "no"

-- sqlfmt-corpus-separator --

SELECT 2 IS DISTINCT FROM null as "yes"

-- sqlfmt-corpus-separator --

SELECT 2 IS NOT DISTINCT FROM 2 as "yes"

-- sqlfmt-corpus-separator --

SELECT 2 IS NOT DISTINCT FROM null as "no"

-- sqlfmt-corpus-separator --

SELECT 2147483647.4::int4

-- sqlfmt-corpus-separator --

SELECT 2147483647.5::int4

-- sqlfmt-corpus-separator --

SELECT 2::boolean

-- sqlfmt-corpus-separator --

SELECT 2::float4 * m FROM money_data

-- sqlfmt-corpus-separator --

SELECT 2::float8 * m FROM money_data

-- sqlfmt-corpus-separator --

SELECT 2::int2 * m FROM money_data

-- sqlfmt-corpus-separator --

SELECT 2::int8 * m FROM money_data

-- sqlfmt-corpus-separator --

SELECT 32767.4::int2

-- sqlfmt-corpus-separator --

SELECT 32767.5::int2

-- sqlfmt-corpus-separator --

SELECT 9223372036854775807.4::int8

-- sqlfmt-corpus-separator --

SELECT 9223372036854775807.5::int8

-- sqlfmt-corpus-separator --

SELECT ARRAY(select f2 from arrtest_f order by f2) AS "ARRAY"

-- sqlfmt-corpus-separator --

SELECT BOOLTBL1.*
   FROM BOOLTBL1
   WHERE booleq(bool 'false', f1)

-- sqlfmt-corpus-separator --

SELECT BOOLTBL1.*
   FROM BOOLTBL1
   WHERE f1 <> bool 'false'

-- sqlfmt-corpus-separator --

SELECT BOOLTBL1.*
   FROM BOOLTBL1
   WHERE f1 = bool 'false'

-- sqlfmt-corpus-separator --

SELECT BOOLTBL1.*
   FROM BOOLTBL1
   WHERE f1 = bool 'true'

-- sqlfmt-corpus-separator --

SELECT BOOLTBL1.*, BOOLTBL2.*
   FROM BOOLTBL1, BOOLTBL2
   WHERE BOOLTBL2.f1 = BOOLTBL1.f1 and BOOLTBL1.f1 = bool 'false'

-- sqlfmt-corpus-separator --

SELECT BOOLTBL1.*, BOOLTBL2.*
   FROM BOOLTBL1, BOOLTBL2
   WHERE BOOLTBL2.f1 = BOOLTBL1.f1 or BOOLTBL1.f1 = bool 'true'
   ORDER BY BOOLTBL1.f1, BOOLTBL2.f1

-- sqlfmt-corpus-separator --

SELECT CAST('36854775807.0'::float4 AS int8)

-- sqlfmt-corpus-separator --

SELECT CAST('42'::int2 AS int8), CAST('-37'::int2 AS int8)

-- sqlfmt-corpus-separator --

SELECT CAST('922337203685477580700.0'::float8 AS int8)

-- sqlfmt-corpus-separator --

SELECT CAST(f1 AS char(4)) AS three FROM VARCHAR_TBL
UNION
SELECT f1 FROM CHAR_TBL
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT CAST(q1 AS float4), CAST(q2 AS float8) FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT CAST(q1 AS int2) FROM int8_tbl WHERE q2 <> 456

-- sqlfmt-corpus-separator --

SELECT CAST(q1 AS int2) FROM int8_tbl WHERE q2 = 456

-- sqlfmt-corpus-separator --

SELECT CAST(q1 AS int4) FROM int8_tbl WHERE q2 <> 456

-- sqlfmt-corpus-separator --

SELECT CAST(q1 AS int4) FROM int8_tbl WHERE q2 = 456

-- sqlfmt-corpus-separator --

SELECT CAST(q1 AS oid) FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT COUNT(*) FROM pg_attribute
  WHERE attrelid = 'pg_catalog.pg_statistic'::regclass AND
    attnum > 0

-- sqlfmt-corpus-separator --

SELECT COUNT(*) FROM pg_attribute
  WHERE attrelid = 'pg_catalog.pg_stats_ext'::regclass AND
    attnum > 0

-- sqlfmt-corpus-separator --

SELECT COUNT(*) FROM pg_attribute
  WHERE attrelid = 'pg_catalog.pg_stats_ext_exprs'::regclass AND
    attnum > 0

-- sqlfmt-corpus-separator --

SELECT COUNT(*) FROM pg_enum WHERE enumtypid = 'rainbow'::regtype

-- sqlfmt-corpus-separator --

SELECT COUNT(*) FROM point_gist_tbl WHERE f1 <@ '(0.0000009,0.0000009),(0.0000009,0.0000009)'::box

-- sqlfmt-corpus-separator --

SELECT COUNT(*) FROM point_gist_tbl WHERE f1 ~= '(0.0000009,0.0000009)'::point

-- sqlfmt-corpus-separator --

SELECT COUNT(*) FROM point_gist_tbl WHERE f1 ~= '(0.0000018,0.0000018)'::point

-- sqlfmt-corpus-separator --

SELECT COUNT(*) FROM stats_import.test_range_expr_null
  WHERE (rng * int4range(50, 150)) && '[60,70)'::int4range

-- sqlfmt-corpus-separator --

SELECT COUNT(*) OVER () FROM tenk1 WHERE unique2 < 10

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

SELECT DATE_TRUNC('CENTURY', DATE '0002-02-04')

-- sqlfmt-corpus-separator --

SELECT DATE_TRUNC('CENTURY', DATE '0055-08-10 BC')

-- sqlfmt-corpus-separator --

SELECT DATE_TRUNC('CENTURY', DATE '1970-03-20')

-- sqlfmt-corpus-separator --

SELECT DATE_TRUNC('CENTURY', DATE '2004-08-10')

-- sqlfmt-corpus-separator --

SELECT DATE_TRUNC('CENTURY', TIMESTAMP '1970-03-20 04:30:00.00000')

-- sqlfmt-corpus-separator --

SELECT DATE_TRUNC('DECADE', DATE '0002-12-31 BC')

-- sqlfmt-corpus-separator --

SELECT DATE_TRUNC('DECADE', DATE '0004-12-25')

-- sqlfmt-corpus-separator --

SELECT DATE_TRUNC('DECADE', DATE '1993-12-25')

-- sqlfmt-corpus-separator --

SELECT DATE_TRUNC('MILLENNIUM', DATE '1970-03-20')

-- sqlfmt-corpus-separator --

SELECT DATE_TRUNC('MILLENNIUM', TIMESTAMP '1970-03-20 04:30:00.00000')

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (four) four,two
   FROM tenk1 WHERE four = 0 ORDER BY 1

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

SELECT DISTINCT ON (y, x) x, y FROM distinct_on_tbl

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x) x, y FROM distinct_on_tbl ORDER BY y

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

SELECT E'''1 \\''2'' '' 3'' 4 '::tsvector

-- sqlfmt-corpus-separator --

SELECT E'''1 \\''2'' 3'::tsvector

-- sqlfmt-corpus-separator --

SELECT E'''1 \\''2'''::tsquery

-- sqlfmt-corpus-separator --

SELECT E'''1 \\''2'''::tsvector

-- sqlfmt-corpus-separator --

SELECT E'''1 \\''2''3'::tsvector

-- sqlfmt-corpus-separator --

SELECT E'1&(''2''&('' 4''&(\\|5 | ''6 \\'' !|&'')))'::tsquery

-- sqlfmt-corpus-separator --

SELECT E'DeAdBeEf'::bytea

-- sqlfmt-corpus-separator --

SELECT E'DeAd\\\\BeEf'::bytea

-- sqlfmt-corpus-separator --

SELECT E'De\123dBeEf'::bytea

-- sqlfmt-corpus-separator --

SELECT E'De\\000dBeEf'::bytea

-- sqlfmt-corpus-separator --

SELECT E'De\\123dBeEf'::bytea

-- sqlfmt-corpus-separator --

SELECT E'De\\678dBeEf'::bytea

-- sqlfmt-corpus-separator --

SELECT E'\\x De Ad Be Ef '::bytea

-- sqlfmt-corpus-separator --

SELECT E'\\xDe00BeEf'::bytea

-- sqlfmt-corpus-separator --

SELECT E'\\xDeAdBeE'::bytea

-- sqlfmt-corpus-separator --

SELECT E'\\xDeAdBeEf'::bytea

-- sqlfmt-corpus-separator --

SELECT E'\\xDeAdBeEx'::bytea

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

SELECT INTERVAL '+infinity -infinity'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 year months days 5 hours'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2 minutes ago 5 days'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '42 days 2 seconds ago ago'

-- sqlfmt-corpus-separator --

SELECT INTERVAL 'allballs'

-- sqlfmt-corpus-separator --

SELECT INTERVAL 'epoch'

-- sqlfmt-corpus-separator --

SELECT INTERVAL 'hour 5 months'

-- sqlfmt-corpus-separator --

SELECT INTERVAL 'infinity ago'

-- sqlfmt-corpus-separator --

SELECT INTERVAL 'infinity years'

-- sqlfmt-corpus-separator --

SELECT INTERVAL 'infinity' AS "eternity"

-- sqlfmt-corpus-separator --

SELECT INTERVAL 'now'

-- sqlfmt-corpus-separator --

SELECT INTERVAL 'today'

-- sqlfmt-corpus-separator --

SELECT INTERVAL 'tomorrow'

-- sqlfmt-corpus-separator --

SELECT INTERVAL 'yesterday'

-- sqlfmt-corpus-separator --

SELECT INTO tableam_tblselectinto_heapx FROM tableam_tbl_heapx

-- sqlfmt-corpus-separator --

SELECT JSON('   1   '::json)

-- sqlfmt-corpus-separator --

SELECT JSON('   1   '::jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(NULL::jsonb, '$')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(json '{"a": 123}', '$' || '.' || 'a')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '1', '$ > 2')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '1', '$')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '1', '$.a')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '1', '$.a.b')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '1', 'strict $.a')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '[1, "aaa", {"a": 1}]', 'lax $.a')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '[1, "aaa", {"a": 1}]', 'strict $.a')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '[]', '$')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '[]', '$.a')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb 'null', '$')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb 'null', '$.a')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '{"a": 1, "b": 2}', '$.a.b')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '{"a": 123}', '$' || '.' || 'a')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '{"a": {"b": 1}}', '$.a.b')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '{"b": 1, "a": 2}', '$.a')

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(jsonb '{}', '$.a')

-- sqlfmt-corpus-separator --

SELECT JSON_QUERY(jsonb '[]', '$[*]')

-- sqlfmt-corpus-separator --

SELECT JSON_QUERY(jsonb '{"a": 123}', '$' || '.' || 'a')

-- sqlfmt-corpus-separator --

SELECT JSON_QUERY(jsonb '{"a": 123}', 'error' || ' ' || 'error')

-- sqlfmt-corpus-separator --

SELECT JSON_SCALAR('2020-06-07 01:02:03'::timestamp)

-- sqlfmt-corpus-separator --

SELECT JSON_SCALAR('2020-06-07'::date)

-- sqlfmt-corpus-separator --

SELECT JSON_SCALAR('{}'::json)

-- sqlfmt-corpus-separator --

SELECT JSON_SCALAR('{}'::jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_SCALAR(123.45::numeric)

-- sqlfmt-corpus-separator --

SELECT JSON_SCALAR(NULL::int)

-- sqlfmt-corpus-separator --

SELECT JSON_VALUE(NULL::jsonb, '$')

-- sqlfmt-corpus-separator --

SELECT JSON_VALUE(jsonb '"aaa"', '$')

-- sqlfmt-corpus-separator --

SELECT JSON_VALUE(jsonb '1', '$.a')

-- sqlfmt-corpus-separator --

SELECT JSON_VALUE(jsonb '1.23', '$')

-- sqlfmt-corpus-separator --

SELECT JSON_VALUE(jsonb '123', '$')

-- sqlfmt-corpus-separator --

SELECT JSON_VALUE(jsonb '[]', '$')

-- sqlfmt-corpus-separator --

SELECT JSON_VALUE(jsonb 'null', '$')

-- sqlfmt-corpus-separator --

SELECT JSON_VALUE(jsonb 'true', '$')

-- sqlfmt-corpus-separator --

SELECT JSON_VALUE(jsonb '{"a": 123}', '$' || '.' || 'a')

-- sqlfmt-corpus-separator --

SELECT JSON_VALUE(jsonb '{}', '$')

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

SELECT SUM(COUNT(f1)) OVER () FROM int4_tbl WHERE f1=42

-- sqlfmt-corpus-separator --

SELECT SUM(count(*)) OVER(PARTITION BY generate_series(1,3) ORDER BY generate_series(1,3)), generate_series(1,3) g FROM few GROUP BY g

-- sqlfmt-corpus-separator --

SELECT U&'\00E4\24D1c' IS NFC NORMALIZED AS test_nfc

-- sqlfmt-corpus-separator --

SELECT U&'\00E4\24D1c' IS NORMALIZED AS test_default

-- sqlfmt-corpus-separator --

SELECT a, CAST(b AS varchar) FROM collate_test1 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, CAST(b AS varchar) FROM collate_test2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, CAST(b AS varchar) FROM collate_test3 ORDER BY 2

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

SELECT a, b::testdomain FROM collate_test1 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b::testdomain FROM collate_test2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b::testdomain FROM collate_test3 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b::testdomain_p FROM collate_test2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, b::testdomain_sv FROM collate_test3 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, c, sum(b), avg(c), count(*) FROM pagg_tab_m GROUP BY (a+b)/2, 2, 1 HAVING sum(b) = 50 AND avg(c) > 25 ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT a, lower(nullif(x, 'foo')), lower(nullif(y, 'foo')) FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT a, lower(x::testdomain), lower(y::testdomain) FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT a, nullif(b, 'abc') FROM collate_test1 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, nullif(b, 'abc') FROM collate_test2 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, nullif(b, 'abc') FROM collate_test3 ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT a, sum(b), array_agg(distinct c), count(*) FROM pagg_tab_ml GROUP BY a HAVING avg(b) < 3 ORDER BY 1, 2, 3

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

SELECT a.aggfnoid, p.proname
FROM pg_aggregate as a, pg_proc as p
WHERE a.aggcombinefn = p.oid AND
    a.aggtranstype = 'internal'::regtype AND p.proisstrict

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

SELECT a.aggfnoid::oid, p.proname
FROM pg_aggregate as a, pg_proc as p
WHERE a.aggfnoid = p.oid AND
    a.aggfinalfn = 0 AND p.prorettype != a.aggtranstype

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid::oid, p.proname
FROM pg_aggregate as a, pg_proc as p
WHERE a.aggfnoid = p.oid AND
    a.aggmtransfn != 0 AND
    a.aggmfinalfn = 0 AND p.prorettype != a.aggmtranstype

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid::oid, p.proname, ptr.oid, ptr.proname, iptr.oid, iptr.proname
FROM pg_aggregate AS a, pg_proc AS p, pg_proc AS ptr, pg_proc AS iptr
WHERE a.aggfnoid = p.oid AND
    a.aggmtransfn = ptr.oid AND
    a.aggminvtransfn = iptr.oid AND
    ptr.proisstrict != iptr.proisstrict

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

SELECT a::varchar(3) FROM tt1

-- sqlfmt-corpus-separator --

SELECT abort_increasing, abort_decreasing FROM abbrev_abort_uuids ORDER BY abort_decreasing NULLS FIRST OFFSET 20000 - 4

-- sqlfmt-corpus-separator --

SELECT abort_increasing, noabort_increasing FROM abbrev_abort_uuids ORDER BY noabort_increasing NULLS FIRST LIMIT 5

-- sqlfmt-corpus-separator --

SELECT acosh(float8 '-infinity')

-- sqlfmt-corpus-separator --

SELECT acosh(float8 '2')

-- sqlfmt-corpus-separator --

SELECT acosh(float8 'nan')

-- sqlfmt-corpus-separator --

SELECT age(timestamptz '-infinity')

-- sqlfmt-corpus-separator --

SELECT age(timestamptz '-infinity', timestamptz '-infinity')

-- sqlfmt-corpus-separator --

SELECT age(timestamptz '-infinity', timestamptz 'infinity')

-- sqlfmt-corpus-separator --

SELECT age(timestamptz 'infinity')

-- sqlfmt-corpus-separator --

SELECT age(timestamptz 'infinity', timestamptz '-infinity')

-- sqlfmt-corpus-separator --

SELECT age(timestamptz 'infinity', timestamptz 'infinity')

-- sqlfmt-corpus-separator --

SELECT aggfnoid, aggtransfn, aggcombinefn, aggtranstype::regtype,
       aggserialfn, aggdeserialfn, aggfinalmodify
FROM pg_aggregate
WHERE aggfnoid = 'myavg'::REGPROC

-- sqlfmt-corpus-separator --

SELECT aggfnoid, aggtranstype, aggserialfn, aggdeserialfn
FROM pg_aggregate
WHERE (aggserialfn != 0 OR aggdeserialfn != 0)
  AND (aggtranstype != 'internal'::regtype OR aggcombinefn = 0 OR
       aggserialfn = 0 OR aggdeserialfn = 0)

-- sqlfmt-corpus-separator --

SELECT amname FROM pg_class c, pg_am am
  WHERE c.relam = am.oid AND c.oid = 'heapmv'::regclass

-- sqlfmt-corpus-separator --

SELECT amname FROM pg_class c, pg_am am
  WHERE c.relam = am.oid AND c.oid = 'heaptable'::regclass

-- sqlfmt-corpus-separator --

SELECT array_agg(a ORDER BY x||y) FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b) FROM collate_test1

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b) FROM collate_test2

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b) FROM collate_test3

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

SELECT array_sort('{1,2,3}'::xid[])

-- sqlfmt-corpus-separator --

SELECT array_sort('{1,3,5,2,4,6}'::int[])

-- sqlfmt-corpus-separator --

SELECT array_sort('{1.1,3.3,5.5,2.2,4.4,6.6}'::numeric[])

-- sqlfmt-corpus-separator --

SELECT array_sort('{1.1,3.3,5.5,2.2,null,4.4,6.6}'::float8[], false)

-- sqlfmt-corpus-separator --

SELECT array_sort('{1.1,3.3,5.5,2.2,null,4.4,6.6}'::float8[], false, false)

-- sqlfmt-corpus-separator --

SELECT array_sort('{1.1,3.3,5.5,2.2,null,4.4,6.6}'::float8[], false, true)

-- sqlfmt-corpus-separator --

SELECT array_sort('{1.1,3.3,5.5,2.2,null,4.4,6.6}'::float8[], true)

-- sqlfmt-corpus-separator --

SELECT array_sort('{1.1,3.3,5.5,2.2,null,4.4,6.6}'::float8[], true, false)

-- sqlfmt-corpus-separator --

SELECT array_sort('{1.1,3.3,5.5,2.2,null,4.4,6.6}'::float8[], true, true)

-- sqlfmt-corpus-separator --

SELECT array_sort('{1}'::int[])

-- sqlfmt-corpus-separator --

SELECT array_sort('{1}'::xid[])

-- sqlfmt-corpus-separator --

SELECT array_sort('{{"1 2","3 4"}, {"1 -2","-1 4"}}'::int2vector[])

-- sqlfmt-corpus-separator --

SELECT array_sort('{{1,2,3},{2,3,4}}'::xid[])

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

SELECT asinh(float8 '-infinity')

-- sqlfmt-corpus-separator --

SELECT asinh(float8 '1')

-- sqlfmt-corpus-separator --

SELECT asinh(float8 'infinity')

-- sqlfmt-corpus-separator --

SELECT asinh(float8 'nan')

-- sqlfmt-corpus-separator --

SELECT atanh(float8 '-infinity')

-- sqlfmt-corpus-separator --

SELECT atanh(float8 '0.5')

-- sqlfmt-corpus-separator --

SELECT atanh(float8 'infinity')

-- sqlfmt-corpus-separator --

SELECT atanh(float8 'nan')

-- sqlfmt-corpus-separator --

SELECT attinhcount, attislocal FROM pg_attribute WHERE attrelid = 'part_3_4'::regclass AND attnum > 0

-- sqlfmt-corpus-separator --

SELECT attislocal, attinhcount FROM pg_attribute WHERE attrelid = 'part_1'::regclass AND attnum > 0

-- sqlfmt-corpus-separator --

SELECT attname, atthasmissing, attmissingval FROM pg_attribute
  WHERE attrelid = 't'::regclass AND attnum > 0
  ORDER BY attnum

-- sqlfmt-corpus-separator --

SELECT attname, attislocal, attinhcount FROM pg_attribute
  WHERE attrelid = 'part_a'::regclass and attnum > 0
  ORDER BY attnum

-- sqlfmt-corpus-separator --

SELECT attnum, attname, atthasmissing, atthasdef, attmissingval
FROM pg_attribute
WHERE attnum > 0 AND attrelid = 't2'::regclass
ORDER BY attnum

-- sqlfmt-corpus-separator --

SELECT avg(b)::numeric(10,3) AS avg_107_943 FROM aggtest

-- sqlfmt-corpus-separator --

SELECT avg(four) OVER (PARTITION BY four ORDER BY thousand / 100) FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT avg(gpa) AS avg_3_4 FROM ONLY student

-- sqlfmt-corpus-separator --

SELECT b'0 '

-- sqlfmt-corpus-separator --

SELECT b,
       SUBSTRING(b FROM 2 FOR 4) AS sub_2_4,
       SUBSTRING(b FROM 7 FOR 13) AS sub_7_13,
       SUBSTRING(b FROM 6) AS sub_6
       FROM BIT_TABLE

-- sqlfmt-corpus-separator --

SELECT b.*
   FROM bt_f8_heap b
   WHERE b.seqno < '1'::float8

-- sqlfmt-corpus-separator --

SELECT b.*
   FROM bt_f8_heap b
   WHERE b.seqno = '4500'::float8

-- sqlfmt-corpus-separator --

SELECT b.*
   FROM bt_f8_heap b
   WHERE b.seqno >= '9999'::float8

-- sqlfmt-corpus-separator --

SELECT b.*
   FROM bt_name_heap b
   WHERE b.seqno < '1'::name

-- sqlfmt-corpus-separator --

SELECT b.*
   FROM bt_name_heap b
   WHERE b.seqno = '4500'::name

-- sqlfmt-corpus-separator --

SELECT b.*
   FROM bt_name_heap b
   WHERE b.seqno >= '9999'::name

-- sqlfmt-corpus-separator --

SELECT b.*
   FROM bt_txt_heap b
   WHERE b.seqno < '1'::text

-- sqlfmt-corpus-separator --

SELECT b.*
   FROM bt_txt_heap b
   WHERE b.seqno = '4500'::text

-- sqlfmt-corpus-separator --

SELECT b.*
   FROM bt_txt_heap b
   WHERE b.seqno >= '9999'::text

-- sqlfmt-corpus-separator --

SELECT b.f1
   FROM BOX_TBL b				-- zero area
   WHERE b.f1 > box '(3.5,3.0,4.5,3.0)'

-- sqlfmt-corpus-separator --

SELECT b.f1
   FROM BOX_TBL b				-- zero area
   WHERE b.f1 >= box '(3.5,3.0,4.5,3.0)'

-- sqlfmt-corpus-separator --

SELECT b.f1
   FROM BOX_TBL b
   WHERE b.f1 && box '(2.5,2.5,1.0,1.0)'

-- sqlfmt-corpus-separator --

SELECT b.f1
   FROM BOX_TBL b
   WHERE b.f1 < box '(3.0,3.0,5.0,5.0)'

-- sqlfmt-corpus-separator --

SELECT b.f1
   FROM BOX_TBL b
   WHERE b.f1 << box '(3.0,3.0,5.0,5.0)'

-- sqlfmt-corpus-separator --

SELECT b.f1
   FROM BOX_TBL b
   WHERE b.f1 <= box '(3.0,3.0,5.0,5.0)'

-- sqlfmt-corpus-separator --

SELECT b.f1
   FROM BOX_TBL b
   WHERE b.f1 <@ box '(0,0,3,3)'

-- sqlfmt-corpus-separator --

SELECT b.f1
   FROM BOX_TBL b
   WHERE b.f1 = box '(3.0,3.0,5.0,5.0)'

-- sqlfmt-corpus-separator --

SELECT b.f1
   FROM BOX_TBL b
   WHERE box '(0,0,3,3)' @> b.f1

-- sqlfmt-corpus-separator --

SELECT b.f1
   FROM BOX_TBL b
   WHERE box '(1,1,3,3)' ~= b.f1

-- sqlfmt-corpus-separator --

SELECT b.f1
   FROM BOX_TBL b
   WHERE box '(3.0,3.0,5.0,5.0)' >> b.f1

-- sqlfmt-corpus-separator --

SELECT b1.*
   FROM BOX_TBL b1
   WHERE b1.f1 &< box '(2.0,2.0,2.5,2.5)'

-- sqlfmt-corpus-separator --

SELECT b1.*
   FROM BOX_TBL b1
   WHERE b1.f1 &> box '(2.0,2.0,2.5,2.5)'

-- sqlfmt-corpus-separator --

SELECT b::bit(15), b::bit(15) >> 1 AS bsr, b::bit(15) << 1 AS bsl
       FROM BIT_SHIFT_TABLE

-- sqlfmt-corpus-separator --

SELECT b::bit(15), b::bit(15) >> 8 AS bsr8, b::bit(15) << 8 AS bsl8
       FROM BIT_SHIFT_TABLE

-- sqlfmt-corpus-separator --

SELECT b::macaddr <= '08:00:2b:01:02:04' FROM macaddr8_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b::macaddr <> '08:00:2b:01:02:03'::macaddr FROM macaddr8_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b::macaddr <> '08:00:2b:01:02:04'::macaddr FROM macaddr8_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b::macaddr >= '08:00:2b:01:02:04' FROM macaddr8_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT bit_count('\x1234567890'::bytea)

-- sqlfmt-corpus-separator --

SELECT bit_count(B'0101011100'::bit(10))

-- sqlfmt-corpus-separator --

SELECT bit_count(B'1111111111'::bit(10))

-- sqlfmt-corpus-separator --

SELECT bit_count(repeat('0', 100)::bit(100))

-- sqlfmt-corpus-separator --

SELECT bit_count(repeat('01', 500)::bit(1000))

-- sqlfmt-corpus-separator --

SELECT bit_count(repeat('1', 100)::bit(100))

-- sqlfmt-corpus-separator --

SELECT bit_count(repeat('10101', 200)::bit(1000))

-- sqlfmt-corpus-separator --

SELECT bool '   f           ' AS false

-- sqlfmt-corpus-separator --

SELECT bool '' AS error

-- sqlfmt-corpus-separator --

SELECT bool '0' AS false

-- sqlfmt-corpus-separator --

SELECT bool '000' AS error

-- sqlfmt-corpus-separator --

SELECT bool '1' AS true

-- sqlfmt-corpus-separator --

SELECT bool '11' AS error

-- sqlfmt-corpus-separator --

SELECT bool 'f' < bool 't' AS true

-- sqlfmt-corpus-separator --

SELECT bool 'f' <= bool 't' AS true

-- sqlfmt-corpus-separator --

SELECT bool 'false' AS false

-- sqlfmt-corpus-separator --

SELECT bool 'foo' AS error

-- sqlfmt-corpus-separator --

SELECT bool 'n' AS false

-- sqlfmt-corpus-separator --

SELECT bool 'nay' AS error

-- sqlfmt-corpus-separator --

SELECT bool 'no' AS false

-- sqlfmt-corpus-separator --

SELECT bool 'o' AS error

-- sqlfmt-corpus-separator --

SELECT bool 'of' AS false

-- sqlfmt-corpus-separator --

SELECT bool 'off' AS false

-- sqlfmt-corpus-separator --

SELECT bool 'off_' AS error

-- sqlfmt-corpus-separator --

SELECT bool 'on' AS true

-- sqlfmt-corpus-separator --

SELECT bool 'on_' AS error

-- sqlfmt-corpus-separator --

SELECT bool 't' <> bool 'f' AS true

-- sqlfmt-corpus-separator --

SELECT bool 't' = bool 'f' AS false

-- sqlfmt-corpus-separator --

SELECT bool 't' > bool 'f' AS true

-- sqlfmt-corpus-separator --

SELECT bool 't' >= bool 'f' AS true

-- sqlfmt-corpus-separator --

SELECT bool 't' AS true

-- sqlfmt-corpus-separator --

SELECT bool 't' and bool 'f' AS false

-- sqlfmt-corpus-separator --

SELECT bool 't' or bool 'f' AS true

-- sqlfmt-corpus-separator --

SELECT bool 'test' AS error

-- sqlfmt-corpus-separator --

SELECT bool 'true' AS true

-- sqlfmt-corpus-separator --

SELECT bool 'y' AS true

-- sqlfmt-corpus-separator --

SELECT bool 'yeah' AS error

-- sqlfmt-corpus-separator --

SELECT bool 'yes' AS true

-- sqlfmt-corpus-separator --

SELECT btoid8cmp(1::oid8, 2::oid8) < 0 AS val_lower

-- sqlfmt-corpus-separator --

SELECT btoid8cmp(2::oid8, 1::oid8) > 0 AS val_higher

-- sqlfmt-corpus-separator --

SELECT btoid8cmp(2::oid8, 2::oid8) = 0 AS val_equal

-- sqlfmt-corpus-separator --

SELECT btrim(''::bytea, E'\\000'::bytea)

-- sqlfmt-corpus-separator --

SELECT btrim(E'\\000trim\\000'::bytea, ''::bytea)

-- sqlfmt-corpus-separator --

SELECT btrim(E'\\000trim\\000'::bytea, E'\\000'::bytea)

-- sqlfmt-corpus-separator --

SELECT c.f1, p.f1, c.f1 / p.f1 FROM CIRCLE_TBL c, POINT_TBL p WHERE p.f1 ~= '(0,0)'::point

-- sqlfmt-corpus-separator --

SELECT c.oid, c.conname
FROM pg_conversion as c
WHERE condefault AND
    convert('ABC'::bytea, pg_encoding_to_char(conforencoding),
            pg_encoding_to_char(contoencoding)) != 'ABC'

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

SELECT cast('1' as dnotnull)

-- sqlfmt-corpus-separator --

SELECT cast('12345' as domainvarchar)

-- sqlfmt-corpus-separator --

SELECT cast('123456' as domainvarchar)

-- sqlfmt-corpus-separator --

SELECT cast(NULL as dnotnull)

-- sqlfmt-corpus-separator --

SELECT cast(cast(NULL as dnull) as dnotnull)

-- sqlfmt-corpus-separator --

SELECT cast(col4 as dnotnull) from nulltest

-- sqlfmt-corpus-separator --

SELECT castsource::regtype, casttarget::regtype, castfunc, castcontext
FROM pg_cast c
WHERE c.castmethod = 'b' AND
    NOT EXISTS (SELECT 1 FROM pg_cast k
                WHERE k.castmethod = 'b' AND
                    k.castsource = c.casttarget AND
                    k.casttarget = c.castsource)

-- sqlfmt-corpus-separator --

SELECT casttestfunc('foo'::text)

-- sqlfmt-corpus-separator --

SELECT casttestfunc('foo'::text::casttesttype)

-- sqlfmt-corpus-separator --

SELECT char 'c' = char 'c' AS true

-- sqlfmt-corpus-separator --

SELECT circle_center(f1), round(radius(f1)) as radius FROM gcircle_tbl ORDER BY f1 <-> '(200,300)'::point LIMIT 10

-- sqlfmt-corpus-separator --

SELECT class, a
   FROM c_star* x
   WHERE x.c ~ text 'hi'

-- sqlfmt-corpus-separator --

SELECT col_description('comment_test'::regclass, 1) as comment

-- sqlfmt-corpus-separator --

SELECT col_description('comment_test_child'::regclass, 1) as comment

-- sqlfmt-corpus-separator --

SELECT collation for ('foo')

-- sqlfmt-corpus-separator --

SELECT collation for ('foo'::text)

-- sqlfmt-corpus-separator --

SELECT collation for ((SELECT a FROM collate_test1 LIMIT 1))

-- sqlfmt-corpus-separator --

SELECT collation for ((SELECT b FROM collate_test1 LIMIT 1))

-- sqlfmt-corpus-separator --

SELECT collname FROM pg_collation WHERE collname LIKE 'test%'

-- sqlfmt-corpus-separator --

SELECT collname FROM pg_collation WHERE collname LIKE 'test%' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT coninhcount, conislocal FROM pg_constraint WHERE conrelid = 'part_3_4'::regclass AND conname = 'check_a'

-- sqlfmt-corpus-separator --

SELECT conislocal, coninhcount FROM pg_constraint WHERE conrelid = 'part_1'::regclass AND conname = 'check_a'

-- sqlfmt-corpus-separator --

SELECT conname FROM pg_constraint WHERE conrelid = 'clstr_tst'::regclass
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT conname FROM pg_constraint WHERE conrelid = 'parted_fk_naming_1'::regclass AND contype = 'f'

-- sqlfmt-corpus-separator --

SELECT conname as constraint, obj_description(oid, 'pg_constraint') as comment FROM pg_constraint where conrelid = 'comment_test'::regclass ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT conname as constraint, obj_description(oid, 'pg_constraint') as comment FROM pg_constraint where conrelid = 'comment_test_child'::regclass ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT conname, conenforced, convalidated FROM pg_constraint
WHERE conrelid = 'fk_notpartitioned_fk'::regclass ORDER BY oid::regclass::text

-- sqlfmt-corpus-separator --

SELECT conname, conenforced, convalidated FROM pg_constraint
WHERE conrelid = 'fk_partitioned_pk'::regclass AND contype = 'f'
ORDER BY oid::regclass::text

-- sqlfmt-corpus-separator --

SELECT conname, conislocal, coninhcount FROM pg_constraint WHERE conrelid = 'part_b'::regclass ORDER BY coninhcount DESC, conname

-- sqlfmt-corpus-separator --

SELECT conname, conrelid::regclass FROM pg_constraint
  WHERE conname LIKE 'parted_uniq%' ORDER BY conname

-- sqlfmt-corpus-separator --

SELECT conname, convalidated FROM pg_constraint
WHERE conrelid = 'fk_partitioned_fk_2'::regclass ORDER BY oid::regclass::text

-- sqlfmt-corpus-separator --

SELECT conname, convalidated, conrelid::regclass FROM pg_constraint
WHERE conrelid::regclass::text like 'fk_partitioned_fk%' ORDER BY oid::regclass::text

-- sqlfmt-corpus-separator --

SELECT cosh(float8 '-infinity')

-- sqlfmt-corpus-separator --

SELECT cosh(float8 '1')

-- sqlfmt-corpus-separator --

SELECT cosh(float8 'infinity')

-- sqlfmt-corpus-separator --

SELECT cosh(float8 'nan')

-- sqlfmt-corpus-separator --

SELECT count() OVER () FROM tenk1

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

SELECT count(*) AS One FROM TIMESTAMP_TBL WHERE d1 = timestamp without time zone 'today'

-- sqlfmt-corpus-separator --

SELECT count(*) AS One FROM TIMESTAMP_TBL WHERE d1 = timestamp without time zone 'yesterday'

-- sqlfmt-corpus-separator --

SELECT count(*) AS Three FROM TIMESTAMP_TBL WHERE d1 = timestamp without time zone 'tomorrow'

-- sqlfmt-corpus-separator --

SELECT count(*) AS two FROM TIMESTAMPTZ_TBL WHERE d1 = timestamp(2) with time zone 'now'

-- sqlfmt-corpus-separator --

SELECT count(*) AS two FROM TIMESTAMP_TBL WHERE d1 = timestamp(2) without time zone 'now'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM fast_emp4000 WHERE home_base && '(1000,1000,0,0)'::box

-- sqlfmt-corpus-separator --

SELECT count(*) FROM gcircle_tbl WHERE f1 && '<(500,500),500>'::circle

-- sqlfmt-corpus-separator --

SELECT count(*) FROM gpolygon_tbl WHERE f1 && '(1000,1000,0,0)'::polygon

-- sqlfmt-corpus-separator --

SELECT count(*) FROM kd_point_tbl WHERE box '(200,200,1000,1000)' @> p

-- sqlfmt-corpus-separator --

SELECT count(*) FROM kd_point_tbl WHERE p <@ box '(200,200,1000,1000)'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM pg_class WHERE relkind='i' AND relname LIKE 'guid%'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM pg_class where relname = 'pubview'
AND relnamespace IN (SELECT OID FROM pg_namespace WHERE nspname = 'testviewschm2')

-- sqlfmt-corpus-separator --

SELECT count(*) FROM pg_class where relname LIKE 'mytempview'
And relnamespace IN (SELECT OID FROM pg_namespace WHERE nspname LIKE 'pg_temp%')

-- sqlfmt-corpus-separator --

SELECT count(*) FROM pg_index WHERE indrelid = 'test_replica_identity'::regclass AND indisreplident

-- sqlfmt-corpus-separator --

SELECT count(*) FROM pg_shdepend
  WHERE deptype = 'a' AND
        refobjid = 'regress_priv_user2'::regrole AND
	classid = 'pg_default_acl'::regclass

-- sqlfmt-corpus-separator --

SELECT count(*) FROM pg_trigger WHERE tgrelid = 'main_table'::regclass AND tgname = 'modified_a'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM pg_trigger WHERE tgrelid = 'main_table'::regclass AND tgname = 'modified_modified_a'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM point_tbl WHERE box '(0,0,100,100)' @> f1

-- sqlfmt-corpus-separator --

SELECT count(*) FROM point_tbl WHERE f1 <@ box '(0,0,100,100)'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM point_tbl WHERE f1 <@ circle '<(50,50),50>'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM point_tbl WHERE f1 <@ polygon '(0,0),(0,100),(100,100),(50,50),(100,0),(0,0)'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_box_tbl WHERE b &&  box '((100,200),(300,500))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_box_tbl WHERE b &<  box '((100,200),(300,500))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_box_tbl WHERE b &<| box '((100,200),(300,500))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_box_tbl WHERE b &>  box '((100,200),(300,500))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_box_tbl WHERE b <<  box '((100,200),(300,500))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_box_tbl WHERE b <<| box '((100,200),(300,500))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_box_tbl WHERE b <@  box '((100,200),(300,500))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_box_tbl WHERE b >>  box '((100,200),(300,500))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_box_tbl WHERE b @>  box '((201,301),(202,303))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_box_tbl WHERE b |&> box '((100,200),(300,500))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_box_tbl WHERE b |>> box '((100,200),(300,500))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_box_tbl WHERE b ~=  box '((200,300),(205,305))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_point_tbl WHERE box '(200,200,1000,1000)' @> p

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_point_tbl WHERE p <@ box '(200,200,1000,1000)'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_poly_tbl WHERE p && polygon '((300,300),(400,600),(600,500),(700,200))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_poly_tbl WHERE p &< polygon '((300,300),(400,600),(600,500),(700,200))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_poly_tbl WHERE p &<| polygon '((300,300),(400,600),(600,500),(700,200))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_poly_tbl WHERE p &> polygon '((300,300),(400,600),(600,500),(700,200))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_poly_tbl WHERE p << polygon '((300,300),(400,600),(600,500),(700,200))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_poly_tbl WHERE p <<| polygon '((300,300),(400,600),(600,500),(700,200))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_poly_tbl WHERE p <@ polygon '((300,300),(400,600),(600,500),(700,200))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_poly_tbl WHERE p >> polygon '((300,300),(400,600),(600,500),(700,200))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_poly_tbl WHERE p @> polygon '((340,550),(343,552),(341,553))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_poly_tbl WHERE p |&> polygon '((300,300),(400,600),(600,500),(700,200))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_poly_tbl WHERE p |>> polygon '((300,300),(400,600),(600,500),(700,200))'

-- sqlfmt-corpus-separator --

SELECT count(*) FROM quad_poly_tbl WHERE p ~= polygon '((200, 300),(210, 310),(230, 290))'

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

SELECT count(*) from testjsonb  WHERE j->'array' ? '5'::text

-- sqlfmt-corpus-separator --

SELECT count(*) from testjsonb  WHERE j->'array' @> '5'::jsonb

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT four) AS cnt_4 FROM onek

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT guid_field) FROM guid1

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT x) FROM test3bpci

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT x) FROM test3ci

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT x) FROM test3cs

-- sqlfmt-corpus-separator --

SELECT count(b) FROM test_missing_target
	GROUP BY (b + 1) / 2 ORDER BY (b + 1) / 2 desc

-- sqlfmt-corpus-separator --

SELECT count(d1) AS three, count(DISTINCT d1) AS two FROM TIMESTAMPTZ_TBL

-- sqlfmt-corpus-separator --

SELECT count(d1) AS three, count(DISTINCT d1) AS two FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT count(distinct j) FROM testjsonb

-- sqlfmt-corpus-separator --

SELECT covar_pop(1::float8,'inf'::float8), covar_samp(3::float8,'inf'::float8)

-- sqlfmt-corpus-separator --

SELECT covar_pop(1::float8,'nan'::float8), covar_samp(3::float8,'nan'::float8)

-- sqlfmt-corpus-separator --

SELECT covar_pop(1::float8,2::float8), covar_samp(3::float8,4::float8)

-- sqlfmt-corpus-separator --

SELECT crc32c(repeat('A', 127)::bytea)

-- sqlfmt-corpus-separator --

SELECT crc32c(repeat('A', 128)::bytea)

-- sqlfmt-corpus-separator --

SELECT crc32c(repeat('A', 129)::bytea)

-- sqlfmt-corpus-separator --

SELECT crc32c(repeat('A', 800)::bytea)

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE ctid >= (SELECT NULL::tid)

-- sqlfmt-corpus-separator --

SELECT ctid, aggfnoid::oid
FROM pg_aggregate as a
WHERE aggmtranstype != 0 AND
    (aggmtransfn = 0 OR aggminvtransfn = 0)

-- sqlfmt-corpus-separator --

SELECT ctid,cmin,* FROM combocidtest FOR UPDATE

-- sqlfmt-corpus-separator --

SELECT cume_dist() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT cume_dist() OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT currtid2('tid_ind'::text, '(0,1)'::tid)

-- sqlfmt-corpus-separator --

SELECT currtid2('tid_matview'::text, '(0,1)'::tid)

-- sqlfmt-corpus-separator --

SELECT currtid2('tid_part'::text, '(0,1)'::tid)

-- sqlfmt-corpus-separator --

SELECT currtid2('tid_seq'::text, '(0,1)'::tid)

-- sqlfmt-corpus-separator --

SELECT currtid2('tid_view_fake_ctid'::text, '(0,1)'::tid)

-- sqlfmt-corpus-separator --

SELECT currtid2('tid_view_no_ctid'::text, '(0,1)'::tid)

-- sqlfmt-corpus-separator --

SELECT currtid2('tid_view_with_ctid'::text, '(0,1)'::tid)

-- sqlfmt-corpus-separator --

SELECT currval('sequence_test'::regclass)

-- sqlfmt-corpus-separator --

SELECT currval('sequence_test'::text)

-- sqlfmt-corpus-separator --

SELECT cursor_to_xml('xc'::refcursor, 5, false, true, '')

-- sqlfmt-corpus-separator --

SELECT cursor_to_xml('xc'::refcursor, 5, true, false, '')

-- sqlfmt-corpus-separator --

SELECT cursor_to_xmlschema('xc'::refcursor, false, true, '')

-- sqlfmt-corpus-separator --

SELECT cursor_to_xmlschema('xc'::refcursor, true, false, '')

-- sqlfmt-corpus-separator --

SELECT d.f1 AS "timestamp",
   timestamp with time zone '1980-01-06 00:00 GMT' AS gpstime_zero,
   d.f1 - timestamp with time zone '1980-01-06 00:00 GMT' AS difference
  FROM TEMP_TIMESTAMP d
  ORDER BY difference

-- sqlfmt-corpus-separator --

SELECT d1 + interval '1 year' AS one_year FROM TIMESTAMPTZ_TBL

-- sqlfmt-corpus-separator --

SELECT d1 + interval '1 year' AS one_year FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT d1 - interval '1 year' AS one_year FROM TIMESTAMPTZ_TBL

-- sqlfmt-corpus-separator --

SELECT d1 - interval '1 year' AS one_year FROM TIMESTAMP_TBL

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

SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 != timestamp without time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 < timestamp without time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 <= timestamp without time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 = timestamp without time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 > timestamp without time zone '1997-01-02'

-- sqlfmt-corpus-separator --

SELECT d1 FROM TIMESTAMP_TBL
   WHERE d1 >= timestamp without time zone '1997-01-02'

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

SELECT date '-infinity infinity'

-- sqlfmt-corpus-separator --

SELECT date '01 08 1999'

-- sqlfmt-corpus-separator --

SELECT date '01 08 99'

-- sqlfmt-corpus-separator --

SELECT date '01-08-1999'

-- sqlfmt-corpus-separator --

SELECT date '01-08-99'

-- sqlfmt-corpus-separator --

SELECT date '01/02/03'

-- sqlfmt-corpus-separator --

SELECT date '08 01 1999'

-- sqlfmt-corpus-separator --

SELECT date '08 01 99'

-- sqlfmt-corpus-separator --

SELECT date '08 Jan 1999'

-- sqlfmt-corpus-separator --

SELECT date '08 Jan 99'

-- sqlfmt-corpus-separator --

SELECT date '08-01-1999'

-- sqlfmt-corpus-separator --

SELECT date '08-01-99'

-- sqlfmt-corpus-separator --

SELECT date '08-Jan-1999'

-- sqlfmt-corpus-separator --

SELECT date '08-Jan-99'

-- sqlfmt-corpus-separator --

SELECT date '1/18/1999'

-- sqlfmt-corpus-separator --

SELECT date '1/8/1999'

-- sqlfmt-corpus-separator --

SELECT date '18/1/1999'

-- sqlfmt-corpus-separator --

SELECT date '1994-01-01' + time '10:00' AS "Jan_01_1994_10am"

-- sqlfmt-corpus-separator --

SELECT date '1994-01-01' + time '11:00' AS "Jan_01_1994_11am"

-- sqlfmt-corpus-separator --

SELECT date '1994-01-01' + timetz '11:00-5' AS "Jan_01_1994_8am"

-- sqlfmt-corpus-separator --

SELECT date '1995-08-06  J J J'

-- sqlfmt-corpus-separator --

SELECT date '1995-08-06 -infinity'

-- sqlfmt-corpus-separator --

SELECT date '1995-08-06 epoch'

-- sqlfmt-corpus-separator --

SELECT date '1995-08-06 infinity'

-- sqlfmt-corpus-separator --

SELECT date '1999 01 08'

-- sqlfmt-corpus-separator --

SELECT date '1999 08 01'

-- sqlfmt-corpus-separator --

SELECT date '1999 08 Jan'

-- sqlfmt-corpus-separator --

SELECT date '1999 Jan 08'

-- sqlfmt-corpus-separator --

SELECT date '1999-01-08'

-- sqlfmt-corpus-separator --

SELECT date '1999-01-18'

-- sqlfmt-corpus-separator --

SELECT date '1999-08-01'

-- sqlfmt-corpus-separator --

SELECT date '1999-08-Jan'

-- sqlfmt-corpus-separator --

SELECT date '1999-Jan-08'

-- sqlfmt-corpus-separator --

SELECT date '1999.008'

-- sqlfmt-corpus-separator --

SELECT date '19990108'

-- sqlfmt-corpus-separator --

SELECT date '4714-11-23 BC'

-- sqlfmt-corpus-separator --

SELECT date '4714-11-24 BC'

-- sqlfmt-corpus-separator --

SELECT date '5874897-12-31'

-- sqlfmt-corpus-separator --

SELECT date '5874898-01-01'

-- sqlfmt-corpus-separator --

SELECT date '99 01 08'

-- sqlfmt-corpus-separator --

SELECT date '99 08 01'

-- sqlfmt-corpus-separator --

SELECT date '99 08 Jan'

-- sqlfmt-corpus-separator --

SELECT date '99 Jan 08'

-- sqlfmt-corpus-separator --

SELECT date '99-01-08'

-- sqlfmt-corpus-separator --

SELECT date '99-08-01'

-- sqlfmt-corpus-separator --

SELECT date '99-08-Jan'

-- sqlfmt-corpus-separator --

SELECT date '99-Jan-08'

-- sqlfmt-corpus-separator --

SELECT date '990108'

-- sqlfmt-corpus-separator --

SELECT date 'J J 1520447'

-- sqlfmt-corpus-separator --

SELECT date 'J2451187'

-- sqlfmt-corpus-separator --

SELECT date 'Jan 08 1999'

-- sqlfmt-corpus-separator --

SELECT date 'Jan 08 99'

-- sqlfmt-corpus-separator --

SELECT date 'Jan-08-1999'

-- sqlfmt-corpus-separator --

SELECT date 'Jan-08-99'

-- sqlfmt-corpus-separator --

SELECT date 'January 8, 1999'

-- sqlfmt-corpus-separator --

SELECT date 'January 8, 99 BC'

-- sqlfmt-corpus-separator --

SELECT date 'today infinity'

-- sqlfmt-corpus-separator --

SELECT date_add('2021-10-31 00:00:00+02'::timestamptz,
                '1 day'::interval,
                'Europe/Warsaw')

-- sqlfmt-corpus-separator --

SELECT date_add('2022-10-30 00:00:00+01'::timestamptz,
                '1 day'::interval)

-- sqlfmt-corpus-separator --

SELECT date_bin('-2 days'::interval, timestamp '1970-01-01 01:00:00' , timestamp '1970-01-01 00:00:00')

-- sqlfmt-corpus-separator --

SELECT date_bin('-2 days'::interval, timestamp with time zone '1970-01-01 01:00:00+00' , timestamp with time zone '1970-01-01 00:00:00+00')

-- sqlfmt-corpus-separator --

SELECT date_bin('-infinity', timestamp '2001-02-16 20:38:40', timestamp '2001-02-16 20:05:00')

-- sqlfmt-corpus-separator --

SELECT date_bin('0 days'::interval, timestamp '1970-01-01 01:00:00' , timestamp '1970-01-01 00:00:00')

-- sqlfmt-corpus-separator --

SELECT date_bin('0 days'::interval, timestamp with time zone '1970-01-01 01:00:00+00' , timestamp with time zone '1970-01-01 00:00:00+00')

-- sqlfmt-corpus-separator --

SELECT date_bin('30 minutes'::interval, timestamp '2024-02-01 15:00:00', timestamp '2024-02-01 17:00:00')

-- sqlfmt-corpus-separator --

SELECT date_bin('30 minutes'::interval, timestamptz '2024-02-01 15:00:00', timestamptz '2024-02-01 17:00:00')

-- sqlfmt-corpus-separator --

SELECT date_bin('5 min'::interval, timestamp '2020-02-01 01:01:01', timestamp '2020-02-01 00:02:30')

-- sqlfmt-corpus-separator --

SELECT date_bin('5 min'::interval, timestamptz '2020-02-01 01:01:01+00', timestamptz '2020-02-01 00:02:30+00')

-- sqlfmt-corpus-separator --

SELECT date_bin('5 months'::interval, timestamp '2020-02-01 01:01:01', timestamp '2001-01-01')

-- sqlfmt-corpus-separator --

SELECT date_bin('5 months'::interval, timestamp with time zone '2020-02-01 01:01:01+00', timestamp with time zone '2001-01-01+00')

-- sqlfmt-corpus-separator --

SELECT date_bin('5 years'::interval,  timestamp '2020-02-01 01:01:01', timestamp '2001-01-01')

-- sqlfmt-corpus-separator --

SELECT date_bin('5 years'::interval,  timestamp with time zone '2020-02-01 01:01:01+00', timestamp with time zone '2001-01-01+00')

-- sqlfmt-corpus-separator --

SELECT date_bin('infinity', timestamp '2001-02-16 20:38:40', timestamp '2001-02-16 20:05:00')

-- sqlfmt-corpus-separator --

SELECT date_part('epoch',       TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT date_part('epoch',       TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT date_part('epoch', '294270-01-01 00:00:00'::timestamp)

-- sqlfmt-corpus-separator --

SELECT date_part('epoch', '294270-01-01 00:00:00+00'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT date_part('microsecond', TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT date_part('microsecond', TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT date_part('millisecond', TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT date_part('millisecond', TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT date_part('second',      TIME '2020-05-26 13:30:25.575401')

-- sqlfmt-corpus-separator --

SELECT date_part('second',      TIME WITH TIME ZONE '2020-05-26 13:30:25.575401-04')

-- sqlfmt-corpus-separator --

SELECT date_subtract('2021-10-31 00:00:00+02'::timestamptz,
                     '1 day'::interval,
                     'Europe/Warsaw')

-- sqlfmt-corpus-separator --

SELECT date_subtract('2022-10-30 00:00:00+01'::timestamptz,
                     '1 day'::interval)

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'ago', timestamp 'infinity' ) AS invalid_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'ago', timestamp with time zone 'infinity' ) AS invalid_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'timezone', timestamp '2004-02-29 15:44:17.71393' ) AS notsupp_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'timezone', timestamp 'infinity' ) AS notsupp_inf_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'timezone', timestamp with time zone '2004-02-29 15:44:17.71393' ) AS notsupp_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'timezone', timestamp with time zone 'infinity' ) AS notsupp_inf_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'week', timestamp '2004-02-29 15:44:17.71393' ) AS week_trunc

-- sqlfmt-corpus-separator --

SELECT date_trunc( 'week', timestamp 'infinity' ) AS inf_trunc

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

SELECT dense_rank() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT depname, empno, salary, rank() OVER (PARTITION BY depname ORDER BY salary) FROM empsalary

-- sqlfmt-corpus-separator --

SELECT depname, empno, salary, sum(salary) OVER (PARTITION BY depname) FROM empsalary ORDER BY depname, salary

-- sqlfmt-corpus-separator --

SELECT depname, empno, salary, sum(salary) OVER w FROM empsalary WINDOW w AS (PARTITION BY depname)

-- sqlfmt-corpus-separator --

SELECT descr, substring(make_tuple_indirect(indtoasttest)::text, 1, 200) FROM indtoasttest

-- sqlfmt-corpus-separator --

SELECT div('-inf'::numeric, '0')

-- sqlfmt-corpus-separator --

SELECT div('0'::numeric, '0')

-- sqlfmt-corpus-separator --

SELECT div('inf'::numeric, '0')

-- sqlfmt-corpus-separator --

SELECT div('nan'::numeric, '0')

-- sqlfmt-corpus-separator --

SELECT dup('xyz'::text)

-- sqlfmt-corpus-separator --

SELECT echo_me('red'::rainbow)

-- sqlfmt-corpus-separator --

SELECT encode('\x01'::bytea, 'invalid')

-- sqlfmt-corpus-separator --

SELECT encode('\x0102'::bytea, 'base64url')

-- sqlfmt-corpus-separator --

SELECT encode('\x010203'::bytea, 'base64url')

-- sqlfmt-corpus-separator --

SELECT encode('\xdeadbeef'::bytea, 'base64url')

-- sqlfmt-corpus-separator --

SELECT encode(('\x' || repeat('1234567890abcdef0001', 7))::bytea, 'base64')

-- sqlfmt-corpus-separator --

SELECT encode(overlay(E'Th\\000omas'::bytea placing E'Th\\001omas'::bytea from 2),'escape')

-- sqlfmt-corpus-separator --

SELECT encode(overlay(E'Th\\000omas'::bytea placing E'\\002\\003'::bytea from 5 for 3),'escape')

-- sqlfmt-corpus-separator --

SELECT encode(overlay(E'Th\\000omas'::bytea placing E'\\002\\003'::bytea from 8),'escape')

-- sqlfmt-corpus-separator --

SELECT enum_first(NULL::rainbow)

-- sqlfmt-corpus-separator --

SELECT enum_first(null::bogus)

-- sqlfmt-corpus-separator --

SELECT enum_last('green'::rainbow)

-- sqlfmt-corpus-separator --

SELECT enum_last(NULL::planets)

-- sqlfmt-corpus-separator --

SELECT enum_last(null::bogus)

-- sqlfmt-corpus-separator --

SELECT enum_range('orange'::rainbow, 'green'::rainbow)

-- sqlfmt-corpus-separator --

SELECT enum_range('orange'::rainbow, NULL)

-- sqlfmt-corpus-separator --

SELECT enum_range(NULL, 'green'::rainbow)

-- sqlfmt-corpus-separator --

SELECT enum_range(NULL::rainbow)

-- sqlfmt-corpus-separator --

SELECT enum_range(NULL::rainbow, NULL)

-- sqlfmt-corpus-separator --

SELECT enum_range(null::bogus)

-- sqlfmt-corpus-separator --

SELECT enumlabel, enumsortorder
FROM pg_enum
WHERE enumtypid = 'bogus'::regtype
ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT enumlabel, enumsortorder
FROM pg_enum
WHERE enumtypid = 'planets'::regtype
ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT enumlabel, enumsortorder
FROM pg_enum
WHERE enumtypid = 'planets'::regtype
ORDER BY enumlabel::planets

-- sqlfmt-corpus-separator --

SELECT enumlabel, enumsortorder
FROM pg_enum
WHERE enumtypid = 'rainbow'::regtype
ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT error_on_null('{1,2,NULL,3}'::int[])

-- sqlfmt-corpus-separator --

SELECT error_on_null(NULL::int)

-- sqlfmt-corpus-separator --

SELECT error_on_null(NULL::int[])

-- sqlfmt-corpus-separator --

SELECT exp('inf'::float8), exp('-inf'::float8), exp('nan'::float8)

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

SELECT f1 AS "timestamp", date(f1) AS date
  FROM TEMP_TIMESTAMP
  WHERE f1 <> timestamp 'now'
  ORDER BY date, "timestamp"

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

SELECT f1, f1::box FROM POLYGON_TBL

-- sqlfmt-corpus-separator --

SELECT f1, f1::path FROM POLYGON_TBL

-- sqlfmt-corpus-separator --

SELECT f1, f1::polygon FROM CIRCLE_TBL WHERE f1 >= '<(0,0),1>'

-- sqlfmt-corpus-separator --

SELECT f1, f1::polygon FROM PATH_TBL WHERE isclosed(f1)

-- sqlfmt-corpus-separator --

SELECT f1, f1::polygon FROM PATH_TBL WHERE isopen(f1)

-- sqlfmt-corpus-separator --

SELECT f1::box
	FROM POINT_TBL

-- sqlfmt-corpus-separator --

SELECT fdwname FROM pg_foreign_data_wrapper WHERE fdwname like 'alt_fdw%'

-- sqlfmt-corpus-separator --

SELECT fdwname, fdwhandler::regproc, fdwvalidator::regproc, fdwoptions FROM pg_foreign_data_wrapper ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT few.dataa, count(*) FROM few WHERE dataa = 'a' GROUP BY few.dataa, unnest('{1,1,3}'::int[]) ORDER BY 2

-- sqlfmt-corpus-separator --

SELECT few.dataa, count(*), min(id), max(id), unnest('{1,1,3}'::int[]) FROM few WHERE few.id = 1 GROUP BY few.dataa

-- sqlfmt-corpus-separator --

SELECT few.dataa, count(*), min(id), max(id), unnest('{1,1,3}'::int[]) FROM few WHERE few.id = 1 GROUP BY few.dataa, 5

-- sqlfmt-corpus-separator --

SELECT few.dataa, count(*), min(id), max(id), unnest('{1,1,3}'::int[]) FROM few WHERE few.id = 1 GROUP BY few.dataa, unnest('{1,1,3}'::int[])

-- sqlfmt-corpus-separator --

SELECT first_value(ten) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

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

SELECT float4send('1.17549435e-38'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('1.1754944e-38'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('2539e-18'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('3e-23'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('5382571e-37'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('55895e-16'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('57e18'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('5e-20'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('67e14'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('702990899e-20'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('7038531e-32'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('750486563e-38'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('76173e28'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('789e-35'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('82381273e-35'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('887745e-11'::float4)

-- sqlfmt-corpus-separator --

SELECT float4send('985e15'::float4)

-- sqlfmt-corpus-separator --

SELECT float8_accum('{4,140,2900}'::float8[], 100)

-- sqlfmt-corpus-separator --

SELECT float8_combine('{0,0,0}'::float8[], '{2,180,200}'::float8[])

-- sqlfmt-corpus-separator --

SELECT float8_combine('{3,60,200}'::float8[], '{0,0,0}'::float8[])

-- sqlfmt-corpus-separator --

SELECT float8_combine('{3,60,200}'::float8[], '{2,180,200}'::float8[])

-- sqlfmt-corpus-separator --

SELECT float8_regr_accum('{4,140,2900,1290,83075,15050,100,0}'::float8[], 200, 100)

-- sqlfmt-corpus-separator --

SELECT float8_regr_combine('{0,0,0,0,0,0,0,0}'::float8[],
                           '{2,180,200,740,57800,-3400,NaN,1}'::float8[])

-- sqlfmt-corpus-separator --

SELECT float8_regr_combine('{3,60,200,750,20000,2000,1,NaN}'::float8[],
                           '{0,0,0,0,0,0,0,0}'::float8[])

-- sqlfmt-corpus-separator --

SELECT float8_regr_combine('{3,60,200,750,20000,2000,7,8}'::float8[],
                           '{2,180,200,740,57800,-3400,7,9}'::float8[])

-- sqlfmt-corpus-separator --

SELECT float8send('2.2250738585072014E-308'::float8)

-- sqlfmt-corpus-separator --

SELECT format_type(atttypid,atttypmod) FROM pg_attribute
WHERE attrelid = 'mytab'::regclass AND attnum > 0

-- sqlfmt-corpus-separator --

SELECT four FROM tenk1 WHERE FALSE WINDOW w AS (PARTITION BY ten)

-- sqlfmt-corpus-separator --

SELECT four, ten, SUM(SUM(four)) OVER (PARTITION BY four), AVG(ten) FROM tenk1
GROUP BY four, ten ORDER BY four, ten

-- sqlfmt-corpus-separator --

SELECT gamma(float8 '-1')

-- sqlfmt-corpus-separator --

SELECT gamma(float8 '-1000.5')

-- sqlfmt-corpus-separator --

SELECT gamma(float8 '-infinity')

-- sqlfmt-corpus-separator --

SELECT gamma(float8 '0')

-- sqlfmt-corpus-separator --

SELECT gamma(float8 '1000')

-- sqlfmt-corpus-separator --

SELECT gcd((-2147483648)::int4, (-2147483648)::int4)

-- sqlfmt-corpus-separator --

SELECT gcd((-2147483648)::int4, 0::int4)

-- sqlfmt-corpus-separator --

SELECT gcd((-9223372036854775808)::int8, (-9223372036854775808)::int8)

-- sqlfmt-corpus-separator --

SELECT gcd((-9223372036854775808)::int8, 0::int8)

-- sqlfmt-corpus-separator --

SELECT generate_series(1, 100) OVER () FROM empsalary

-- sqlfmt-corpus-separator --

SELECT generate_series(1,3) IS DISTINCT FROM 2

-- sqlfmt-corpus-separator --

SELECT get_bit('\x1234567890abcdef00'::bytea, 43)

-- sqlfmt-corpus-separator --

SELECT get_bit('\x1234567890abcdef00'::bytea, 99)

-- sqlfmt-corpus-separator --

SELECT get_bit(B'0101011000100', 10)

-- sqlfmt-corpus-separator --

SELECT get_byte('\x1234567890abcdef00'::bytea, 3)

-- sqlfmt-corpus-separator --

SELECT get_byte('\x1234567890abcdef00'::bytea, 99)

-- sqlfmt-corpus-separator --

SELECT grantor::regrole FROM pg_auth_members WHERE roleid = 'regress_priv_user1'::regrole and member = 'regress_priv_user4'::regrole

-- sqlfmt-corpus-separator --

SELECT h.seqno AS f20000
   FROM hash_f8_heap h
   WHERE h.random = '488912369'::float8

-- sqlfmt-corpus-separator --

SELECT h.seqno AS i4002, h.random AS c0_to_p
   FROM hash_txt_heap h
   WHERE h.random = '0123456789abcdefghijklmnop'::text

-- sqlfmt-corpus-separator --

SELECT h.seqno AS i6543, h.random AS c0_to_f
   FROM hash_name_heap h
   WHERE h.random = '0123456789abcdef'::name

-- sqlfmt-corpus-separator --

SELECT h.seqno AS i8096, h.random AS f1234_1234
   FROM hash_f8_heap h
   WHERE h.random = '-1234.1234'::float8

-- sqlfmt-corpus-separator --

SELECT h.seqno AS t20000
   FROM hash_txt_heap h
   WHERE h.random = '959363399'::text

-- sqlfmt-corpus-separator --

SELECT hashfloat4('0'::float4) = hashfloat4('-0'::float4) AS t

-- sqlfmt-corpus-separator --

SELECT hashfloat4('NaN'::float4) = hashfloat4(-'NaN'::float4) AS t

-- sqlfmt-corpus-separator --

SELECT hashfloat4('NaN'::float4) = hashfloat8('NaN'::float8) AS t

-- sqlfmt-corpus-separator --

SELECT hashfloat8('0'::float8) = hashfloat8('-0'::float8) AS t

-- sqlfmt-corpus-separator --

SELECT hashfloat8('NaN'::float8) = hashfloat8(-'NaN'::float8) AS t

-- sqlfmt-corpus-separator --

SELECT hjtest_1.a a1, hjtest_2.a a2,hjtest_1.tableoid::regclass t1, hjtest_2.tableoid::regclass t2
FROM hjtest_1, hjtest_2
WHERE
    hjtest_1.id = (SELECT 1 WHERE hjtest_2.id = 1)
    AND (SELECT hjtest_1.b * 5) = (SELECT hjtest_2.c*5)
    AND (SELECT hjtest_1.b * 5) < 50
    AND (SELECT hjtest_2.c * 5) < 55
    AND hjtest_1.a <> hjtest_2.b

-- sqlfmt-corpus-separator --

SELECT hjtest_1.a a1, hjtest_2.a a2,hjtest_1.tableoid::regclass t1, hjtest_2.tableoid::regclass t2
FROM hjtest_2, hjtest_1
WHERE
    hjtest_1.id = (SELECT 1 WHERE hjtest_2.id = 1)
    AND (SELECT hjtest_1.b * 5) = (SELECT hjtest_2.c*5)
    AND (SELECT hjtest_1.b * 5) < 50
    AND (SELECT hjtest_2.c * 5) < 55
    AND hjtest_1.a <> hjtest_2.b

-- sqlfmt-corpus-separator --

SELECT i FROM inet_tbl WHERE i << '192.168.1.0/24'::cidr ORDER BY i

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE (i.f1 % int2 '2') = int2 '1'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE (i.f1 % int4 '2') = int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE i.f1 < int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE i.f1 < int4 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE i.f1 <= int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE i.f1 <= int4 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE i.f1 <> int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE i.f1 <> int4 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE i.f1 = int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE i.f1 = int4 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE i.f1 > int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE i.f1 > int4 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE i.f1 >= int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT2_TBL i WHERE i.f1 >= int4 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE (i.f1 % int2 '2') = int2 '1'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE (i.f1 % int4 '2') = int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE i.f1 < int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE i.f1 < int4 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE i.f1 <= int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE i.f1 <= int4 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE i.f1 <> int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE i.f1 <> int4 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE i.f1 = int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE i.f1 = int4 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE i.f1 > int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE i.f1 > int4 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE i.f1 >= int2 '0'

-- sqlfmt-corpus-separator --

SELECT i.* FROM INT4_TBL i WHERE i.f1 >= int4 '0'

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 * int2 '2' AS x FROM INT2_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 * int2 '2' AS x FROM INT2_TBL i
WHERE abs(f1) < 16384

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 * int2 '2' AS x FROM INT4_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 * int2 '2' AS x FROM INT4_TBL i
WHERE abs(f1) < 1073741824

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 * int4 '2' AS x FROM INT2_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 * int4 '2' AS x FROM INT4_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 * int4 '2' AS x FROM INT4_TBL i
WHERE abs(f1) < 1073741824

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 + int2 '2' AS x FROM INT2_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 + int2 '2' AS x FROM INT2_TBL i
WHERE f1 < 32766

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 + int2 '2' AS x FROM INT4_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 + int2 '2' AS x FROM INT4_TBL i
WHERE f1 < 2147483646

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 + int4 '2' AS x FROM INT2_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 + int4 '2' AS x FROM INT4_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 + int4 '2' AS x FROM INT4_TBL i
WHERE f1 < 2147483646

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 - int2 '2' AS x FROM INT2_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 - int2 '2' AS x FROM INT2_TBL i
WHERE f1 > -32767

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 - int2 '2' AS x FROM INT4_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 - int2 '2' AS x FROM INT4_TBL i
WHERE f1 > -2147483647

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 - int4 '2' AS x FROM INT2_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 - int4 '2' AS x FROM INT4_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 - int4 '2' AS x FROM INT4_TBL i
WHERE f1 > -2147483647

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 / int2 '2' AS x FROM INT2_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 / int2 '2' AS x FROM INT4_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 / int4 '2' AS x FROM INT2_TBL i

-- sqlfmt-corpus-separator --

SELECT i.f1, i.f1 / int4 '2' AS x FROM INT4_TBL i

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

SELECT id,lag(id) OVER(), count(*) OVER(), generate_series(1,3) FROM few

-- sqlfmt-corpus-separator --

SELECT indexrelid::regclass
FROM pg_index
WHERE (is_catalog_text_unique_index_oid(indexrelid) <>
       (indisunique AND
        indexrelid < 16384 AND
        EXISTS (SELECT 1 FROM pg_attribute
                WHERE attrelid = indexrelid AND atttypid = 'text'::regtype)))

-- sqlfmt-corpus-separator --

SELECT indexrelid::regclass, indisclustered FROM pg_index
  WHERE indrelid = 'concur_clustered'::regclass

-- sqlfmt-corpus-separator --

SELECT indexrelid::regclass, indisreplident FROM pg_index
  WHERE indrelid = 'concur_replident'::regclass

-- sqlfmt-corpus-separator --

SELECT indexrelid::regclass, indnatts, indnkeyatts, indisunique, indisprimary, indkey, indclass FROM pg_index WHERE indrelid = 'tbl'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT indexrelid::regclass::text as index, obj_description(indexrelid, 'pg_class') as comment FROM pg_index where indrelid = 'comment_test'::regclass ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT indexrelid::regclass::text as index, obj_description(indexrelid, 'pg_class') as comment FROM pg_index where indrelid = 'comment_test_child'::regclass ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT int2 '-0b1000000000000000'

-- sqlfmt-corpus-separator --

SELECT int2 '-0b1000000000000001'

-- sqlfmt-corpus-separator --

SELECT int2 '-0o100000'

-- sqlfmt-corpus-separator --

SELECT int2 '-0o100001'

-- sqlfmt-corpus-separator --

SELECT int2 '-0x8000'

-- sqlfmt-corpus-separator --

SELECT int2 '-0x8001'

-- sqlfmt-corpus-separator --

SELECT int2 '0b'

-- sqlfmt-corpus-separator --

SELECT int2 '0b1000000000000000'

-- sqlfmt-corpus-separator --

SELECT int2 '0b100101'

-- sqlfmt-corpus-separator --

SELECT int2 '0b111111111111111'

-- sqlfmt-corpus-separator --

SELECT int2 '0b_10_0101'

-- sqlfmt-corpus-separator --

SELECT int2 '0o'

-- sqlfmt-corpus-separator --

SELECT int2 '0o100000'

-- sqlfmt-corpus-separator --

SELECT int2 '0o273'

-- sqlfmt-corpus-separator --

SELECT int2 '0o2_73'

-- sqlfmt-corpus-separator --

SELECT int2 '0o77777'

-- sqlfmt-corpus-separator --

SELECT int2 '0x'

-- sqlfmt-corpus-separator --

SELECT int2 '0x42F'

-- sqlfmt-corpus-separator --

SELECT int2 '0x7FFF'

-- sqlfmt-corpus-separator --

SELECT int2 '0x8000'

-- sqlfmt-corpus-separator --

SELECT int2 '0xE_FF'

-- sqlfmt-corpus-separator --

SELECT int2 '100_'

-- sqlfmt-corpus-separator --

SELECT int2 '10__000'

-- sqlfmt-corpus-separator --

SELECT int2 '1_000'

-- sqlfmt-corpus-separator --

SELECT int2 '1_2_3'

-- sqlfmt-corpus-separator --

SELECT int2 '2' * int2 '2' = int2 '16' / int2 '4' AS true

-- sqlfmt-corpus-separator --

SELECT int2 '2' * int4 '2' = int4 '16' / int2 '4' AS true

-- sqlfmt-corpus-separator --

SELECT int2 '_100'

-- sqlfmt-corpus-separator --

SELECT int4 '-0b10000000000000000000000000000000'

-- sqlfmt-corpus-separator --

SELECT int4 '-0b10000000000000000000000000000001'

-- sqlfmt-corpus-separator --

SELECT int4 '-0o20000000000'

-- sqlfmt-corpus-separator --

SELECT int4 '-0o20000000001'

-- sqlfmt-corpus-separator --

SELECT int4 '-0x80000000'

-- sqlfmt-corpus-separator --

SELECT int4 '-0x80000001'

-- sqlfmt-corpus-separator --

SELECT int4 '0b'

-- sqlfmt-corpus-separator --

SELECT int4 '0b10000000000000000000000000000000'

-- sqlfmt-corpus-separator --

SELECT int4 '0b100101'

-- sqlfmt-corpus-separator --

SELECT int4 '0b1111111111111111111111111111111'

-- sqlfmt-corpus-separator --

SELECT int4 '0b_10_0101'

-- sqlfmt-corpus-separator --

SELECT int4 '0o'

-- sqlfmt-corpus-separator --

SELECT int4 '0o17777777777'

-- sqlfmt-corpus-separator --

SELECT int4 '0o20000000000'

-- sqlfmt-corpus-separator --

SELECT int4 '0o273'

-- sqlfmt-corpus-separator --

SELECT int4 '0o2_73'

-- sqlfmt-corpus-separator --

SELECT int4 '0x'

-- sqlfmt-corpus-separator --

SELECT int4 '0x1EEE_FFFF'

-- sqlfmt-corpus-separator --

SELECT int4 '0x42F'

-- sqlfmt-corpus-separator --

SELECT int4 '0x7FFFFFFF'

-- sqlfmt-corpus-separator --

SELECT int4 '0x80000000'

-- sqlfmt-corpus-separator --

SELECT int4 '1000' < int4 '999' AS false

-- sqlfmt-corpus-separator --

SELECT int4 '100_'

-- sqlfmt-corpus-separator --

SELECT int4 '100__000'

-- sqlfmt-corpus-separator --

SELECT int4 '1_000_000'

-- sqlfmt-corpus-separator --

SELECT int4 '1_2_3'

-- sqlfmt-corpus-separator --

SELECT int4 '2' * int2 '2' = int2 '16' / int4 '4' AS true

-- sqlfmt-corpus-separator --

SELECT int4 '_100'

-- sqlfmt-corpus-separator --

SELECT int8 '-0b1000000000000000000000000000000000000000000000000000000000000000'

-- sqlfmt-corpus-separator --

SELECT int8 '-0b1000000000000000000000000000000000000000000000000000000000000001'

-- sqlfmt-corpus-separator --

SELECT int8 '-0o1000000000000000000000'

-- sqlfmt-corpus-separator --

SELECT int8 '-0o1000000000000000000001'

-- sqlfmt-corpus-separator --

SELECT int8 '-0x8000000000000000'

-- sqlfmt-corpus-separator --

SELECT int8 '-0x8000000000000001'

-- sqlfmt-corpus-separator --

SELECT int8 '0b'

-- sqlfmt-corpus-separator --

SELECT int8 '0b1000000000000000000000000000000000000000000000000000000000000000'

-- sqlfmt-corpus-separator --

SELECT int8 '0b100101'

-- sqlfmt-corpus-separator --

SELECT int8 '0b111111111111111111111111111111111111111111111111111111111111111'

-- sqlfmt-corpus-separator --

SELECT int8 '0b_10_0101'

-- sqlfmt-corpus-separator --

SELECT int8 '0o'

-- sqlfmt-corpus-separator --

SELECT int8 '0o1000000000000000000000'

-- sqlfmt-corpus-separator --

SELECT int8 '0o273'

-- sqlfmt-corpus-separator --

SELECT int8 '0o2_73'

-- sqlfmt-corpus-separator --

SELECT int8 '0o777777777777777777777'

-- sqlfmt-corpus-separator --

SELECT int8 '0x'

-- sqlfmt-corpus-separator --

SELECT int8 '0x1EEE_FFFF'

-- sqlfmt-corpus-separator --

SELECT int8 '0x42F'

-- sqlfmt-corpus-separator --

SELECT int8 '0x7FFFFFFFFFFFFFFF'

-- sqlfmt-corpus-separator --

SELECT int8 '0x8000000000000000'

-- sqlfmt-corpus-separator --

SELECT int8 '100_'

-- sqlfmt-corpus-separator --

SELECT int8 '100__000'

-- sqlfmt-corpus-separator --

SELECT int8 '1_000_000'

-- sqlfmt-corpus-separator --

SELECT int8 '1_2_3'

-- sqlfmt-corpus-separator --

SELECT int8 '_100'

-- sqlfmt-corpus-separator --

SELECT interval '-1073741824 months -1073741824 days -4611686018427387904 us' * 2

-- sqlfmt-corpus-separator --

SELECT interval '-1073741824 months -1073741824 days -4611686018427387904 us' / 0.5

-- sqlfmt-corpus-separator --

SELECT interval '-2147483647 months -2147483647 days -9223372036854775807 us' + interval '-1 month -1 day -1 us'

-- sqlfmt-corpus-separator --

SELECT interval '-2147483647 months -2147483647 days -9223372036854775807 us' - interval '1 month 1 day 1 us'

-- sqlfmt-corpus-separator --

SELECT interval '-2147483648 months -2147483648 days -9223372036854775807 us'

-- sqlfmt-corpus-separator --

SELECT interval '-2147483648 months -2147483648 days -9223372036854775808 us'

-- sqlfmt-corpus-separator --

SELECT interval '-2562047788:00:54.775807' second(2)

-- sqlfmt-corpus-separator --

SELECT interval '-infinity' * 'nan'

-- sqlfmt-corpus-separator --

SELECT interval '-infinity' * 0

-- sqlfmt-corpus-separator --

SELECT interval '-infinity' / '-infinity'

-- sqlfmt-corpus-separator --

SELECT interval '-infinity' / 'infinity'

-- sqlfmt-corpus-separator --

SELECT interval '-infinity' / 'nan'

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

SELECT interval '1-2'

-- sqlfmt-corpus-separator --

SELECT interval '1-2' year to month

-- sqlfmt-corpus-separator --

SELECT interval '1.234' second

-- sqlfmt-corpus-separator --

SELECT interval '1.234' second(2)

-- sqlfmt-corpus-separator --

SELECT interval '123 11'

-- sqlfmt-corpus-separator --

SELECT interval '123 11' day

-- sqlfmt-corpus-separator --

SELECT interval '123 11' day to hour

-- sqlfmt-corpus-separator --

SELECT interval '123 2:03 -2:04'

-- sqlfmt-corpus-separator --

SELECT interval '12:34.5678' minute to second(2)

-- sqlfmt-corpus-separator --

SELECT interval '2' month

-- sqlfmt-corpus-separator --

SELECT interval '2147483646 months 2147483646 days 9223372036854775806 us' + interval '1 month 1 day 1 us'

-- sqlfmt-corpus-separator --

SELECT interval '2147483646 months 2147483646 days 9223372036854775806 us' - interval '-1 month -1 day -1 us'

-- sqlfmt-corpus-separator --

SELECT interval '2147483647 months 2147483647 days 9223372036854775806 us'

-- sqlfmt-corpus-separator --

SELECT interval '2147483647 months 2147483647 days 9223372036854775807 us'

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

SELECT interval 'infinity' * 'nan'

-- sqlfmt-corpus-separator --

SELECT interval 'infinity' * 0

-- sqlfmt-corpus-separator --

SELECT interval 'infinity' / '-infinity'

-- sqlfmt-corpus-separator --

SELECT interval 'infinity' / 'infinity'

-- sqlfmt-corpus-separator --

SELECT interval 'infinity' / 'nan'

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

SELECT json_build_array('a',1,'b',1.2,'c',true,'d',null,'e',json '{"x": 3, "y": [1,2,3]}')

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

SELECT json_build_object('a',1,'b',1.2,'c',true,'d',null,'e',json '{"x": 3, "y": [1,2,3]}')

-- sqlfmt-corpus-separator --

SELECT json_build_object('{1,2,3}'::int[], 3)

-- sqlfmt-corpus-separator --

SELECT json_build_object('{a,b,c}'::text[])

-- sqlfmt-corpus-separator --

SELECT json_build_object('{a,b,c}'::text[], '{d,e,f}'::text[])

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

SELECT json_build_object(json '{"a":1,"b":2}', 3)

-- sqlfmt-corpus-separator --

SELECT json_populate_record(null::j_ordered_pair, '{"x": 0, "y": 1}')

-- sqlfmt-corpus-separator --

SELECT json_populate_record(null::record, '{"x": 0, "y": 1}')

-- sqlfmt-corpus-separator --

SELECT json_populate_recordset(null::j_ordered_pair, '[{"x": 0, "y": 1}]')

-- sqlfmt-corpus-separator --

SELECT json_populate_recordset(null::record, '[]')

-- sqlfmt-corpus-separator --

SELECT json_populate_recordset(null::record, '[{"x": 0, "y": 1}]')

-- sqlfmt-corpus-separator --

SELECT jsonb '[{"a": 1}, {"a": 2}]' @? '$[*] ? (@.a > 2)'

-- sqlfmt-corpus-separator --

SELECT jsonb '[{"a": 1}, {"a": 2}]' @? '$[*].a ? (@ > 1)'

-- sqlfmt-corpus-separator --

SELECT jsonb '[{"a": 1}, {"a": 2}]' @@ '$[*].a > 1'

-- sqlfmt-corpus-separator --

SELECT jsonb '[{"a": 1}, {"a": 2}]' @@ '$[*].a > 2'

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "\ud83dX" }' -> 'a'

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "\ud83d\ud83d" }' -> 'a'

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "\ude04X" }' -> 'a'

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "\ude04\ud83d" }' -> 'a'

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "dollar \\u0024 character" }' ->> 'a' as not_an_escape

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "dollar \\u0024 character" }' as not_an_escape

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "dollar \u0024 character" }' ->> 'a' as correct_everywhere

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "dollar \u0024 character" }' as correct_everywhere

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "null \\u0000 escape" }' ->> 'a' as not_an_escape

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "null \\u0000 escape" }' as not_an_escape

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "null \u0000 escape" }' ->> 'a' as fails

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "null \u0000 escape" }' as fails

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "the Copyright \u00a9 sign" }' ->> 'a' as correct_in_utf8

-- sqlfmt-corpus-separator --

SELECT jsonb '{ "a":  "the Copyright \u00a9 sign" }' as correct_in_utf8

-- sqlfmt-corpus-separator --

SELECT jsonb '{"a":"null", "b":"qq"}' ? 'a'

-- sqlfmt-corpus-separator --

SELECT jsonb '{"a":null, "b":"qq"}' ? 'a'

-- sqlfmt-corpus-separator --

SELECT jsonb '{"a":null, "b":"qq"}' ? 'b'

-- sqlfmt-corpus-separator --

SELECT jsonb '{"a":null, "b":"qq"}' ? 'c'

-- sqlfmt-corpus-separator --

SELECT jsonb '{"a":null, "b":"qq"}' ?& '{}'::text[]

-- sqlfmt-corpus-separator --

SELECT jsonb '{"a":null, "b":"qq"}' ?| '{}'::text[]

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(q ORDER BY x NULLS FIRST, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(q ORDER BY x, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array('a',1,'b',1.2,'c',true,'d',null,'e',json '{"x": 3, "y": [1,2,3]}')

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

SELECT jsonb_build_object('a',1,'b',1.2,'c',true,'d',null,'e',json '{"x": 3, "y": [1,2,3]}')

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object('{1,2,3}'::int[], 3)

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object('{a,b,c}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object('{a,b,c}'::text[], '{d,e,f}'::text[])

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

SELECT jsonb_build_object(json '{"a":1,"b":2}', 3)

-- sqlfmt-corpus-separator --

SELECT jsonb_each('{"a":{"b":"c","c":"b","1":"first"},"b":[1,2],"c":"cc","1":"first","n":null}'::jsonb) AS q

-- sqlfmt-corpus-separator --

SELECT jsonb_each_text('{"a":{"b":"c","c":"b","1":"first"},"b":[1,2],"c":"cc","1":"first","n":null}'::jsonb) AS q

-- sqlfmt-corpus-separator --

SELECT jsonb_exists_all('{"a":null, "b":"qq"}', '{}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_exists_any('{"a":null, "b":"qq"}', '{}'::text[])

-- sqlfmt-corpus-separator --

SELECT jsonb_extract_path('{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}','f2',0::text)

-- sqlfmt-corpus-separator --

SELECT jsonb_extract_path('{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}','f2',1::text)

-- sqlfmt-corpus-separator --

SELECT jsonb_extract_path_text('{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}','f2',0::text)

-- sqlfmt-corpus-separator --

SELECT jsonb_extract_path_text('{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}','f2',1::text)

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg(1, NULL::jsonb)

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg(DISTINCT 'a', 'abc')

-- sqlfmt-corpus-separator --

SELECT jsonb_populate_record(null::jb_ordered_pair, '{"x": 0, "y": 1}')

-- sqlfmt-corpus-separator --

SELECT jsonb_populate_record(null::record, '{"x": 0, "y": 1}')

-- sqlfmt-corpus-separator --

SELECT jsonb_populate_recordset(null::jb_ordered_pair, '[{"x": 0, "y": 1}]')

-- sqlfmt-corpus-separator --

SELECT jsonb_populate_recordset(null::record, '[]')

-- sqlfmt-corpus-separator --

SELECT jsonb_populate_recordset(null::record, '[{"x": 0, "y": 1}]')

-- sqlfmt-corpus-separator --

SELECT justify_days(interval '2147483647 months 30 days')

-- sqlfmt-corpus-separator --

SELECT justify_hours(interval '2147483647 days 24 hrs')

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '-2147483648 days -24 hrs')

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '-2147483648 months -30 days 24 hrs')

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '-2147483648 months -30 days')

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '-2147483648 months 30 days -1440 hrs')

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '2147483647 days 24 hrs')

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '2147483647 months -30 days 1440 hrs')

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '2147483647 months 30 days -24 hrs')

-- sqlfmt-corpus-separator --

SELECT justify_interval(interval '2147483647 months 30 days')

-- sqlfmt-corpus-separator --

SELECT lag(ten) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lag(ten, four) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lag(ten, four, 0) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lag(ten, four, 0.7) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10 ORDER BY four, ten

-- sqlfmt-corpus-separator --

SELECT lanname, a.rolname
  FROM pg_language l, pg_authid a
  WHERE l.lanowner = a.oid AND l.lanname like 'alt_lang%'
  ORDER BY lanname

-- sqlfmt-corpus-separator --

SELECT last_seq_scan, last_idx_scan FROM pg_stat_all_tables WHERE relid = 'test_last_scan'::regclass

-- sqlfmt-corpus-separator --

SELECT last_value(four) OVER (ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

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

SELECT lcm(2147483647::int4, 2147483646::int4)

-- sqlfmt-corpus-separator --

SELECT lcm(9223372036854775807::int8, 9223372036854775806::int8)

-- sqlfmt-corpus-separator --

SELECT lcm(9999 * (10::numeric)^131068 + (10::numeric^131068 - 1), 2)

-- sqlfmt-corpus-separator --

SELECT lead(ten * 2, 1) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lead(ten * 2, 1, -1) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lead(ten * 2, 1, -1.4) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10 ORDER BY four, ten

-- sqlfmt-corpus-separator --

SELECT lead(ten) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lead(ten, (SELECT two FROM tenk1 WHERE s.unique2 = unique2)) OVER (PARTITION BY four ORDER BY ten)
FROM tenk1 s WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT length(c), c::text FROM toasttest

-- sqlfmt-corpus-separator --

SELECT length(test_pglz_decompress('\x01'::bytea, 1024, false)) AS ctrl_only_len

-- sqlfmt-corpus-separator --

SELECT lgamma(float8 '-1')

-- sqlfmt-corpus-separator --

SELECT lgamma(float8 '-1000.5')

-- sqlfmt-corpus-separator --

SELECT lgamma(float8 '-infinity')

-- sqlfmt-corpus-separator --

SELECT lgamma(float8 '0')

-- sqlfmt-corpus-separator --

SELECT lgamma(float8 '1000')

-- sqlfmt-corpus-separator --

SELECT lgamma(float8 '1e308')

-- sqlfmt-corpus-separator --

SELECT ln('-1'::numeric)

-- sqlfmt-corpus-separator --

SELECT ln('-inf'::numeric)

-- sqlfmt-corpus-separator --

SELECT ln('0'::numeric)

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

SELECT log('-inf'::numeric, '10')

-- sqlfmt-corpus-separator --

SELECT log('-inf'::numeric, 'inf')

-- sqlfmt-corpus-separator --

SELECT log('0'::numeric, '10')

-- sqlfmt-corpus-separator --

SELECT log('10'::numeric, '-inf')

-- sqlfmt-corpus-separator --

SELECT log('10'::numeric, '0')

-- sqlfmt-corpus-separator --

SELECT log('inf'::numeric, '-inf')

-- sqlfmt-corpus-separator --

SELECT log('inf'::numeric, '0')

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

SELECT m * 2::float4 FROM money_data

-- sqlfmt-corpus-separator --

SELECT m * 2::float8 FROM money_data

-- sqlfmt-corpus-separator --

SELECT m * 2::int2 FROM money_data

-- sqlfmt-corpus-separator --

SELECT m * 2::int8 FROM money_data

-- sqlfmt-corpus-separator --

SELECT m / '2'::money FROM money_data

-- sqlfmt-corpus-separator --

SELECT m / 2::float4 FROM money_data

-- sqlfmt-corpus-separator --

SELECT m / 2::float8 FROM money_data

-- sqlfmt-corpus-separator --

SELECT m / 2::int2 FROM money_data

-- sqlfmt-corpus-separator --

SELECT m / 2::int8 FROM money_data

-- sqlfmt-corpus-separator --

SELECT macaddr8_set7bit('00:08:2b:01:02:03'::macaddr8)

-- sqlfmt-corpus-separator --

SELECT make_timestamptz(1881, 12, 10, 0, 0, 0, 'Asia/Singapore') AT TIME ZONE 'UTC'

-- sqlfmt-corpus-separator --

SELECT make_timestamptz(1881, 12, 10, 0, 0, 0, 'Europe/Paris') AT TIME ZONE 'UTC'

-- sqlfmt-corpus-separator --

SELECT make_timestamptz(1881, 12, 10, 0, 0, 0, 'Pacific/Honolulu') AT TIME ZONE 'UTC'

-- sqlfmt-corpus-separator --

SELECT make_timestamptz(1973, 07, 15, 08, 15, 55.33, '+2') = '1973-07-15 08:15:55.33+02'::timestamptz

-- sqlfmt-corpus-separator --

SELECT make_timestamptz(2014, 12, 10, 0, 0, 0, 'Europe/Prague') = timestamptz '2014-12-10 00:00:00 Europe/Prague'

-- sqlfmt-corpus-separator --

SELECT make_timestamptz(2014, 12, 10, 0, 0, 0, 'Europe/Prague') AT TIME ZONE 'UTC'

-- sqlfmt-corpus-separator --

SELECT makeaclitem('regress_"quoted'::regrole, 'regress_"quoted'::regrole,
                   'SELECT', TRUE)

-- sqlfmt-corpus-separator --

SELECT makeaclitem('regress_priv_user1'::regrole, 'regress_priv_user2'::regrole,
	'SELECT', TRUE)

-- sqlfmt-corpus-separator --

SELECT makeaclitem('regress_priv_user1'::regrole, 'regress_priv_user2'::regrole,
	'SELECT, INSERT,  UPDATE , DELETE  ', FALSE)

-- sqlfmt-corpus-separator --

SELECT makeaclitem('regress_priv_user1'::regrole, 'regress_priv_user2'::regrole,
	'SELECT, fake_privilege', FALSE)

-- sqlfmt-corpus-separator --

SELECT member::regrole, admin_option FROM pg_auth_members WHERE roleid = 'regress_priv_user1'::regrole

-- sqlfmt-corpus-separator --

SELECT min(generate_series(1, 3)) OVER() FROM few

-- sqlfmt-corpus-separator --

SELECT mode FROM pg_locks
WHERE relation = 'stats_import.part_parent'::regclass AND
      pid = pg_backend_pid() AND granted

-- sqlfmt-corpus-separator --

SELECT mode FROM pg_locks
WHERE relation = 'stats_import.part_parent_i'::regclass AND
      pid = pg_backend_pid() AND granted

-- sqlfmt-corpus-separator --

SELECT mode FROM pg_locks
WHERE relation = 'stats_import.test'::regclass AND
      pid = pg_backend_pid() AND granted

-- sqlfmt-corpus-separator --

SELECT mode FROM pg_locks
WHERE relation = 'stats_import.test_i'::regclass AND
      pid = pg_backend_pid() AND granted

-- sqlfmt-corpus-separator --

SELECT mode FROM pg_locks WHERE locktype = 'relation' AND
  relation = 'stats_import.test'::regclass AND
  pid = pg_backend_pid()

-- sqlfmt-corpus-separator --

SELECT mode FROM pg_locks WHERE locktype = 'relation' AND
  relation = 'stats_import.test_clone'::regclass AND
  pid = pg_backend_pid()

-- sqlfmt-corpus-separator --

SELECT name 'name string' = name 'name string ' AS "False"

-- sqlfmt-corpus-separator --

SELECT name 'name string' = name 'name string' AS "True"

-- sqlfmt-corpus-separator --

SELECT name(equipment(hobby_construct(text 'skywalking', text 'mer')))

-- sqlfmt-corpus-separator --

SELECT name(equipment(hobby_construct_named(text 'skywalking', text 'mer')))

-- sqlfmt-corpus-separator --

SELECT name(equipment(p.hobbies)), p.name, name(p.hobbies) FROM ONLY person p

-- sqlfmt-corpus-separator --

SELECT name(equipment_named(hobby_construct_named(text 'skywalking', text 'mer')))

-- sqlfmt-corpus-separator --

SELECT name(equipment_named_ambiguous_1a(hobby_construct_named(text 'skywalking', text 'mer')))

-- sqlfmt-corpus-separator --

SELECT name(equipment_named_ambiguous_1b(hobby_construct_named(text 'skywalking', text 'mer')))

-- sqlfmt-corpus-separator --

SELECT name(equipment_named_ambiguous_1c(hobby_construct_named(text 'skywalking', text 'mer')))

-- sqlfmt-corpus-separator --

SELECT name(equipment_named_ambiguous_2a(text 'skywalking'))

-- sqlfmt-corpus-separator --

SELECT name(equipment_named_ambiguous_2b(text 'skywalking'))

-- sqlfmt-corpus-separator --

SELECT nextval('sequence_test'::regclass)

-- sqlfmt-corpus-separator --

SELECT nextval('sequence_test'::text)

-- sqlfmt-corpus-separator --

SELECT noabort_increasing, noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_decreasing NULLS FIRST OFFSET 20000 - 4

-- sqlfmt-corpus-separator --

SELECT normalize('')

-- sqlfmt-corpus-separator --

SELECT not bool 'f' AS true

-- sqlfmt-corpus-separator --

SELECT nspname, prsname
  FROM pg_ts_parser t, pg_namespace n
  WHERE t.prsnamespace = n.oid AND nspname like 'alt_nsp%'
  ORDER BY nspname, prsname

-- sqlfmt-corpus-separator --

SELECT nspname, tmplname
  FROM pg_ts_template t, pg_namespace n
  WHERE t.tmplnamespace = n.oid AND nspname like 'alt_nsp%'
  ORDER BY nspname, tmplname

-- sqlfmt-corpus-separator --

SELECT nth_value(four, 0) OVER (ORDER BY ten), ten, four FROM tenk1

-- sqlfmt-corpus-separator --

SELECT ntile(0) OVER (ORDER BY ten), ten, four FROM tenk1

-- sqlfmt-corpus-separator --

SELECT ntile(1) OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT ntile(3) OVER (ORDER BY ten, four), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT ntile(NULL) OVER (ORDER BY ten, four), ten, four FROM tenk1 LIMIT 2

-- sqlfmt-corpus-separator --

SELECT null IS DISTINCT FROM null as "no"

-- sqlfmt-corpus-separator --

SELECT null IS NOT DISTINCT FROM null as "yes"

-- sqlfmt-corpus-separator --

SELECT num_nonnulls(1, 2, NULL::text, NULL::point, '', int8 '9', 1.0 / NULL)

-- sqlfmt-corpus-separator --

SELECT num_nonnulls(NULL::text)

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

SELECT num_nulls(1, 2, NULL::text, NULL::point, '', int8 '9', 1.0 / NULL)

-- sqlfmt-corpus-separator --

SELECT num_nulls(NULL::text)

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

SELECT nummultirange() && 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT nummultirange() &< 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT nummultirange() &> 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT nummultirange() -|- 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT nummultirange() @> 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT nummultirange(numrange(1,2)) && 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT nummultirange(numrange(1,2)) &< 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT nummultirange(numrange(1,2)) &> 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT nummultirange(numrange(1,2)) -|- 'empty'::numrange

-- sqlfmt-corpus-separator --

SELECT numnode( 'new & york | qwery'::tsquery )

-- sqlfmt-corpus-separator --

SELECT numnode( 'new & york'::tsquery )

-- sqlfmt-corpus-separator --

SELECT numnode( 'new'::tsquery )

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

SELECT obj_description('parted_col_comment'::regclass)

-- sqlfmt-corpus-separator --

SELECT obj_description('testcomment_idx1'::regclass, 'pg_class')

-- sqlfmt-corpus-separator --

SELECT octet_length('"\uaBcD"'::jsonb::text)

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

SELECT oid::int8 FROM pg_class WHERE relname = 'pg_class'

-- sqlfmt-corpus-separator --

SELECT oprcanmerge, oprcanhash
FROM pg_operator WHERE oprname = '==='
  AND oprleft = 'boolean'::regtype AND oprright = 'real'::regtype

-- sqlfmt-corpus-separator --

SELECT oprcanmerge, oprcanhash,
       pg_describe_object('pg_operator'::regclass, oprcom, 0) AS commutator,
       pg_describe_object('pg_operator'::regclass, oprnegate, 0) AS negator
  FROM pg_operator WHERE oprname = '==='
  AND oprleft = 'boolean'::regtype AND oprright = 'real'::regtype

-- sqlfmt-corpus-separator --

SELECT oprrest, oprjoin FROM pg_operator WHERE oprname = '==='
  AND oprleft = 'boolean'::regtype AND oprright = 'boolean'::regtype

-- sqlfmt-corpus-separator --

SELECT overlay(B'0101011100' placing '001' from 11)

-- sqlfmt-corpus-separator --

SELECT overlay(B'0101011100' placing '001' from 2 for 3)

-- sqlfmt-corpus-separator --

SELECT overlay(B'0101011100' placing '001' from 20)

-- sqlfmt-corpus-separator --

SELECT overlay(B'0101011100' placing '101' from 6)

-- sqlfmt-corpus-separator --

SELECT p.* FROM POINT_TBL p
   WHERE box '(0,0,100,100)' @> p.f1

-- sqlfmt-corpus-separator --

SELECT p.* FROM POINT_TBL p
   WHERE not box '(0,0,100,100)' @> p.f1

-- sqlfmt-corpus-separator --

SELECT p.* FROM POINT_TBL p
   WHERE not p.f1 <@ box '(0,0,100,100)'

-- sqlfmt-corpus-separator --

SELECT p.* FROM POINT_TBL p
   WHERE p.f1 <@ box '(0,0,100,100)'

-- sqlfmt-corpus-separator --

SELECT p.* FROM POINT_TBL p
   WHERE p.f1 <@ path '[(0,0),(-10,0),(-10,10)]'

-- sqlfmt-corpus-separator --

SELECT p.f1, p.f1 <-> point '(0,0)' AS dist
   FROM POINT_TBL p
   ORDER BY dist

-- sqlfmt-corpus-separator --

SELECT p.f1, p1.f1, p.f1 / p1.f1 FROM PATH_TBL p, POINT_TBL p1 WHERE p1.f1 ~= '(0,0)'::point

-- sqlfmt-corpus-separator --

SELECT p.name, name(p.hobbies) FROM ONLY person p

-- sqlfmt-corpus-separator --

SELECT p.name, name(p.hobbies), name(equipment(p.hobbies)) FROM ONLY person p

-- sqlfmt-corpus-separator --

SELECT p1.f1
   FROM POINT_TBL p1
   WHERE ishorizontal(p1.f1, point '(0,0)')

-- sqlfmt-corpus-separator --

SELECT p1.f1
   FROM POINT_TBL p1
   WHERE isvertical(p1.f1, point '(5.1,34.5)')

-- sqlfmt-corpus-separator --

SELECT p1.f1
   FROM POINT_TBL p1
   WHERE p1.f1 ?- point '(0,0)'

-- sqlfmt-corpus-separator --

SELECT p1.f1
   FROM POINT_TBL p1
   WHERE p1.f1 ?| point '(5.1,34.5)'

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1, p1.f1 / p2.f1 FROM POINT_TBL p1, POINT_TBL p2 WHERE p2.f1 ~= '(0,0)'::point

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

SELECT parse_ident(' first . "  second  " ."   third   ". "  ' || repeat('x',66) || '"')::name[]

-- sqlfmt-corpus-separator --

SELECT percent_rank() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT percent_rank() OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

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

SELECT pg_describe_object(classid, objid, objsubid) AS obj,
       pg_describe_object(refclassid, refobjid, refobjsubid) as refobj
  FROM pg_depend, pg_am
  WHERE pg_depend.refclassid = 'pg_am'::regclass
    AND pg_am.oid = pg_depend.refobjid
    AND pg_depend.objid = 'am_partitioned'::regclass

-- sqlfmt-corpus-separator --

SELECT pg_describe_object(classid, objid, objsubid) as obj,
       pg_describe_object(refclassid, refobjid, refobjsubid) as objref,
       deptype
  FROM pg_depend
  WHERE classid = 'pg_class'::regclass AND
        objid = 'heaptable'::regclass
  ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT pg_describe_object(classid, objid, objsubid) as obj,
       pg_describe_object(refclassid, refobjid, refobjsubid) as objref,
       deptype
FROM pg_depend
WHERE classid = 'pg_cast'::regclass AND
      objid = (SELECT oid FROM pg_cast
               WHERE castsource = 'int4'::regtype
                 AND casttarget = 'casttesttype'::regtype)
ORDER BY refclassid

-- sqlfmt-corpus-separator --

SELECT pg_describe_object(classid, objid, objsubid) as obj,
       pg_describe_object(refclassid, refobjid, refobjsubid) as reference_graph
    FROM pg_depend
    WHERE refclassid = 'pg_class'::regclass AND
          refobjid = 'create_property_graph_tests.g2'::regclass
    ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT pg_describe_object(classid,objid,objsubid) AS obj
FROM pg_depend, pg_am
WHERE pg_depend.refclassid = 'pg_am'::regclass
    AND pg_am.oid = pg_depend.refobjid
    AND pg_am.amname = 'heap2'
ORDER BY classid, objid, objsubid

-- sqlfmt-corpus-separator --

SELECT pg_describe_object(refclassid,refobjid,refobjsubid) as ref, deptype
FROM pg_depend
WHERE classid = 'pg_operator'::regclass AND
      objid = '===(bool,bool)'::regoperator
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT pg_get_acl('pg_class'::regclass, 'atest2'::regclass::oid, 0)

-- sqlfmt-corpus-separator --

SELECT pg_get_acl('pg_class'::regclass, 0, 0)

-- sqlfmt-corpus-separator --

SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conrelid = 'fktable'::regclass::oid ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT pg_get_constraintdef(oid), conname, conkey FROM pg_constraint WHERE conrelid = 'tbl'::regclass::oid

-- sqlfmt-corpus-separator --

SELECT pg_get_constraintdef(oid), conname, conkey FROM pg_constraint WHERE conrelid = 'tbl'::regclass::oid AND contype = 'p'

-- sqlfmt-corpus-separator --

SELECT pg_get_expr(adbin, adrelid)
FROM pg_attrdef
WHERE adrelid = 'test_jsonb_constraints'::regclass
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT pg_get_function_arg_default('pg_class'::regclass, 0)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('func_with_set_params()'::regprocedure)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('functest_A_1'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('functest_B_3'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('functest_C_3'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('functest_F_2'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('functest_S_1'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('functest_S_10'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('functest_S_13'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('functest_S_15'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('functest_S_16'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('functest_S_2'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('functest_S_3'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_functiondef('functest_S_3a'::regproc)

-- sqlfmt-corpus-separator --

SELECT pg_get_indexdef('concur_exprs_index_expr'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_get_indexdef('concur_exprs_index_pred'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_get_indexdef('concur_exprs_index_pred_2'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_get_indexdef('unique_idx4'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_get_propgraphdef('g3'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_get_propgraphdef('g4'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_get_propgraphdef('g5'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_get_propgraphdef('pg_type'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_get_triggerdef(oid) FROM pg_trigger WHERE tgrelid = 'main_table'::regclass AND tgname = 'after_upd_a_b_row_trig'

-- sqlfmt-corpus-separator --

SELECT pg_get_triggerdef(oid, false) FROM pg_trigger WHERE tgrelid = 'main_table'::regclass AND tgname = 'modified_a'

-- sqlfmt-corpus-separator --

SELECT pg_get_triggerdef(oid, true) FROM pg_trigger WHERE tgrelid = 'main_table'::regclass AND tgname = 'modified_a'

-- sqlfmt-corpus-separator --

SELECT pg_get_triggerdef(oid, true) FROM pg_trigger WHERE tgrelid = 'main_table'::regclass AND tgname = 'modified_any'

-- sqlfmt-corpus-separator --

SELECT pg_get_viewdef('customers_us'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_get_viewdef('v1'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_get_viewdef('vsubdepartment'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_get_viewdef('vsubdepartment'::regclass, true)

-- sqlfmt-corpus-separator --

SELECT pg_lsn('NaN'::numeric)

-- sqlfmt-corpus-separator --

SELECT pg_lsn(-1::numeric)

-- sqlfmt-corpus-separator --

SELECT pg_lsn(0::numeric)

-- sqlfmt-corpus-separator --

SELECT pg_lsn(18446744073709551615::numeric)

-- sqlfmt-corpus-separator --

SELECT pg_lsn(18446744073709551616::numeric)

-- sqlfmt-corpus-separator --

SELECT pg_lsn(23783416::numeric)

-- sqlfmt-corpus-separator --

SELECT pg_relation_size('test_io_local') / current_setting('block_size')::int8 > 100

-- sqlfmt-corpus-separator --

SELECT pg_relation_size('test_temp') / current_setting('block_size')::int8 > 200

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

SELECT pg_size_pretty(pg_relation_size('large_tuple_test'::regclass, 'main'))

-- sqlfmt-corpus-separator --

SELECT pg_snapshot '1:9223372036854775807:3'

-- sqlfmt-corpus-separator --

SELECT pg_snapshot '1:9223372036854775808:3'

-- sqlfmt-corpus-separator --

SELECT pg_stat_get_tuples_hot_updated('brin_hot'::regclass::oid)

-- sqlfmt-corpus-separator --

SELECT pg_stat_reset_single_table_counters('pg_shdescription'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_stat_reset_single_table_counters('test_last_scan'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_stat_reset_single_table_counters('test_last_scan_pkey'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_stat_reset_single_table_counters('test_seq1'::regclass)

-- sqlfmt-corpus-separator --

SELECT pg_xact_status('1'::xid8)

-- sqlfmt-corpus-separator --

SELECT pg_xact_status('2'::xid8)

-- sqlfmt-corpus-separator --

SELECT pg_xact_status('3'::xid8)

-- sqlfmt-corpus-separator --

SELECT point '(1,2)' <% widget '(0,0,3)' AS t,
       point '(1,2)' <% widget '(0,0,1)' AS f

-- sqlfmt-corpus-separator --

SELECT power('-1'::numeric, 'inf')

-- sqlfmt-corpus-separator --

SELECT power('-2'::numeric, '-1')

-- sqlfmt-corpus-separator --

SELECT power('-2'::numeric, '-1.5')

-- sqlfmt-corpus-separator --

SELECT power('-2'::numeric, '-inf')

-- sqlfmt-corpus-separator --

SELECT power('-2'::numeric, '3')

-- sqlfmt-corpus-separator --

SELECT power('-2'::numeric, '3.3')

-- sqlfmt-corpus-separator --

SELECT power('-2'::numeric, 'inf')

-- sqlfmt-corpus-separator --

SELECT power('-inf'::numeric, '-2')

-- sqlfmt-corpus-separator --

SELECT power('-inf'::numeric, '-3')

-- sqlfmt-corpus-separator --

SELECT power('-inf'::numeric, '-inf')

-- sqlfmt-corpus-separator --

SELECT power('-inf'::numeric, '0')

-- sqlfmt-corpus-separator --

SELECT power('-inf'::numeric, '2')

-- sqlfmt-corpus-separator --

SELECT power('-inf'::numeric, '3')

-- sqlfmt-corpus-separator --

SELECT power('-inf'::numeric, '4.5')

-- sqlfmt-corpus-separator --

SELECT power('-inf'::numeric, 'inf')

-- sqlfmt-corpus-separator --

SELECT power('0'::numeric, '-1')

-- sqlfmt-corpus-separator --

SELECT power('0'::numeric, '-inf')

-- sqlfmt-corpus-separator --

SELECT power('inf'::numeric, '-2')

-- sqlfmt-corpus-separator --

SELECT power('inf'::numeric, '-inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-0.1', float8 '-inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-0.1', float8 'inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-1', float8 '-inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-1', float8 'NaN')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-1', float8 'inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-1.1', float8 '-inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-1.1', float8 'inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-inf', float8 '-2') = '0'

-- sqlfmt-corpus-separator --

SELECT power(float8 '-inf', float8 '-3')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-inf', float8 '-inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-inf', float8 '0')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-inf', float8 '2')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-inf', float8 '3')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-inf', float8 '3.5')

-- sqlfmt-corpus-separator --

SELECT power(float8 '-inf', float8 'inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '0', float8 '-inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '0', float8 'inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '0.1', float8 '-inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '0.1', float8 'inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '1', float8 '-inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '1', float8 'NaN')

-- sqlfmt-corpus-separator --

SELECT power(float8 '1', float8 'inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '1.1', float8 '-inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '1.1', float8 'inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 '144', float8 '0.5')

-- sqlfmt-corpus-separator --

SELECT power(float8 '144', float8 'NaN')

-- sqlfmt-corpus-separator --

SELECT power(float8 'NaN', float8 '0')

-- sqlfmt-corpus-separator --

SELECT power(float8 'NaN', float8 '0.5')

-- sqlfmt-corpus-separator --

SELECT power(float8 'NaN', float8 'NaN')

-- sqlfmt-corpus-separator --

SELECT power(float8 'inf', float8 '-2')

-- sqlfmt-corpus-separator --

SELECT power(float8 'inf', float8 '-inf')

-- sqlfmt-corpus-separator --

SELECT power(float8 'inf', float8 '0')

-- sqlfmt-corpus-separator --

SELECT power(float8 'inf', float8 '2')

-- sqlfmt-corpus-separator --

SELECT power(float8 'inf', float8 'inf')

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

SELECT q1 FROM int8_tbl EXCEPT ALL SELECT DISTINCT q2 FROM int8_tbl ORDER BY 1

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

SELECT random('-Inf'::numeric, 0)

-- sqlfmt-corpus-separator --

SELECT random('-infinity'::date, '2024-01-01'::date)

-- sqlfmt-corpus-separator --

SELECT random('-infinity'::timestamp, '2024-01-01'::timestamp)

-- sqlfmt-corpus-separator --

SELECT random('-infinity'::timestamptz, '2024-01-01 +07'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT random('1979-02-08 +01'::timestamptz,'2025-07-03 +02'::timestamptz) AS random_timestamptz_multiple_years

-- sqlfmt-corpus-separator --

SELECT random('1979-02-08 +05'::timestamptz,'1979-02-08 +05'::timestamptz) AS random_timestamptz_empty_range

-- sqlfmt-corpus-separator --

SELECT random('1979-02-08'::date,'1979-02-08'::date) AS random_date_empty_range

-- sqlfmt-corpus-separator --

SELECT random('1979-02-08'::date,'2025-07-03'::date) AS random_date_multiple_years

-- sqlfmt-corpus-separator --

SELECT random('1979-02-08'::timestamp,'1979-02-08'::timestamp) AS random_timestamp_empty_range

-- sqlfmt-corpus-separator --

SELECT random('1979-02-08'::timestamp,'2025-07-03'::timestamp) AS random_timestamp_multiple_years

-- sqlfmt-corpus-separator --

SELECT random('2024-01-01 +06'::timestamptz, '2024-01-01 +07'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT random('2024-01-01 +06'::timestamptz, 'infinity'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT random('2024-07-01 12:00:00.000001 +04'::timestamptz, '2024-07-01 12:00:00.999999 +04'::timestamptz) AS random_timestamptz_narrow_range

-- sqlfmt-corpus-separator --

SELECT random('2024-07-01 12:00:00.000001'::timestamp, '2024-07-01 12:00:00.999999'::timestamp) AS random_narrow_range

-- sqlfmt-corpus-separator --

SELECT random('2024-12-31'::date, '2024-01-01'::date)

-- sqlfmt-corpus-separator --

SELECT random('2024-12-31'::date, 'infinity'::date)

-- sqlfmt-corpus-separator --

SELECT random('2024-12-31'::timestamp, '2024-01-01'::timestamp)

-- sqlfmt-corpus-separator --

SELECT random('2024-12-31'::timestamp, 'infinity'::timestamp)

-- sqlfmt-corpus-separator --

SELECT random('4714-11-24 BC +00'::timestamptz,'294276-12-31 23:59:59.999999 +00'::timestamptz) AS random_timestamptz_maximum_range

-- sqlfmt-corpus-separator --

SELECT random('4714-11-24 BC'::date,'5874897-12-31 AD'::date) AS random_date_maximum_range

-- sqlfmt-corpus-separator --

SELECT random('4714-11-24 BC'::timestamp,'294276-12-31 23:59:59.999999'::timestamp) AS random_timestamp_maximum_range

-- sqlfmt-corpus-separator --

SELECT random('NaN'::numeric, 10)

-- sqlfmt-corpus-separator --

SELECT random(0, 'Inf'::numeric)

-- sqlfmt-corpus-separator --

SELECT random(0, 'NaN'::numeric)

-- sqlfmt-corpus-separator --

SELECT rank() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY 1), count(*) FROM empsalary GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY length('abc'))

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY rank() OVER (ORDER BY random()))

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY four ORDER BY ten) AS rank_1, ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT refclassid::regclass, deptype
  FROM pg_depend
  WHERE classid = 'pg_policy'::regclass
  AND refobjid = 'tbl1'::regclass

-- sqlfmt-corpus-separator --

SELECT regclass('-')::oid

-- sqlfmt-corpus-separator --

SELECT regcollation('-')::oid

-- sqlfmt-corpus-separator --

SELECT regconfig('-')::oid

-- sqlfmt-corpus-separator --

SELECT regdatabase('-')::oid

-- sqlfmt-corpus-separator --

SELECT regdictionary('-')::oid

-- sqlfmt-corpus-separator --

SELECT regnamespace('-')::oid

-- sqlfmt-corpus-separator --

SELECT regproc('-')::oid

-- sqlfmt-corpus-separator --

SELECT regprocedure('-')::oid

-- sqlfmt-corpus-separator --

SELECT regrole('-')::oid

-- sqlfmt-corpus-separator --

SELECT regtype('-')::oid

-- sqlfmt-corpus-separator --

SELECT relispopulated FROM pg_class WHERE oid = 'mv_test3'::regclass

-- sqlfmt-corpus-separator --

SELECT relispopulated FROM pg_class WHERE oid = 'mvtest_tm'::regclass

-- sqlfmt-corpus-separator --

SELECT relname
FROM pg_class
WHERE relnamespace = 'pg_catalog'::regnamespace AND relkind = 'r'
      AND pg_class.oid NOT IN (SELECT indrelid FROM pg_index WHERE indisprimary)
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT relname FROM pg_class
    WHERE relname LIKE 'nontemp%'
    AND relnamespace = (SELECT oid FROM pg_namespace WHERE nspname = 'testviewschm2')
    ORDER BY relname

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

SELECT relname FROM pg_class
    WHERE relname LIKE 'v_'
    AND relnamespace = (SELECT oid FROM pg_namespace WHERE nspname = 'temp_view_test')
    ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT relname FROM pg_class WHERE relname ILIKE 'abc%'

-- sqlfmt-corpus-separator --

SELECT relname, a.* FROM ONLY a, pg_class where a.tableoid = pg_class.oid

-- sqlfmt-corpus-separator --

SELECT relname, b.* FROM ONLY b, pg_class where b.tableoid = pg_class.oid

-- sqlfmt-corpus-separator --

SELECT relname, c.* FROM ONLY c, pg_class where c.tableoid = pg_class.oid

-- sqlfmt-corpus-separator --

SELECT relname, d.* FROM ONLY d, pg_class where d.tableoid = pg_class.oid

-- sqlfmt-corpus-separator --

SELECT relname, n_tup_ins, n_tup_upd, n_tup_del, n_live_tup, n_dead_tup
  FROM pg_stat_user_tables
 WHERE relname like 'trunc_stats_test%' order by relname

-- sqlfmt-corpus-separator --

SELECT relname, pg_get_indexdef(oid) FROM pg_class WHERE relname LIKE 'collate_test%_idx%' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT relname, relkind,
    EXISTS(SELECT 1 FROM pg_class WHERE oid = c.reltoastrelid) AS hastoast
FROM pg_class c WHERE relname LIKE 'clstr_tst%' ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT relname, relpages, reltuples, relallvisible, relallfrozen
FROM pg_class
WHERE oid = 'pg_temp.stats_temp'::regclass
ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT relname, relpages, reltuples, relallvisible, relallfrozen
FROM pg_class
WHERE oid = 'stats_import.test'::regclass
ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT relname, spcname FROM pg_catalog.pg_tablespace t, pg_catalog.pg_class c
    where c.reltablespace = t.oid AND c.relname LIKE 'part%_idx' ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT reloptions FROM pg_class WHERE oid =
	(SELECT reltoastrelid FROM pg_class
	WHERE oid = 'reloptions_test'::regclass)

-- sqlfmt-corpus-separator --

SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test'::regclass

-- sqlfmt-corpus-separator --

SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test_idx'::regclass

-- sqlfmt-corpus-separator --

SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test_idx3'::regclass

-- sqlfmt-corpus-separator --

SELECT reloptions FROM pg_class WHERE oid = (
	SELECT reltoastrelid FROM pg_class WHERE oid = 'reloptions_test'::regclass)

-- sqlfmt-corpus-separator --

SELECT relpages
FROM pg_class
WHERE oid = 'stats_import.part_parent'::regclass

-- sqlfmt-corpus-separator --

SELECT relpages
FROM pg_class
WHERE oid = 'stats_import.part_parent_i'::regclass

-- sqlfmt-corpus-separator --

SELECT relpages, reltuples, relallvisible
FROM pg_class
WHERE oid = 'stats_import.test'::regclass

-- sqlfmt-corpus-separator --

SELECT relpages, reltuples, relallvisible, relallfrozen
FROM pg_class
WHERE oid = 'stats_import.test'::regclass

-- sqlfmt-corpus-separator --

SELECT relpages, reltuples, relallvisible, relallfrozen
FROM pg_class
WHERE oid = 'stats_import.test_i'::regclass

-- sqlfmt-corpus-separator --

SELECT relreplident FROM pg_class WHERE oid = 'pg_class'::regclass

-- sqlfmt-corpus-separator --

SELECT relreplident FROM pg_class WHERE oid = 'pg_constraint'::regclass

-- sqlfmt-corpus-separator --

SELECT relreplident FROM pg_class WHERE oid = 'test_replica_identity'::regclass

-- sqlfmt-corpus-separator --

SELECT reltuples, relhassubclass
  FROM pg_class WHERE oid = 'past_inh_db_parent'::regclass

-- sqlfmt-corpus-separator --

SELECT reltuples, relhassubclass
  FROM pg_class WHERE oid = 'past_inh_parent'::regclass

-- sqlfmt-corpus-separator --

SELECT reltuples, relhassubclass
  FROM pg_class WHERE oid = 'past_parted'::regclass

-- sqlfmt-corpus-separator --

SELECT repeat('[', 10000)::json

-- sqlfmt-corpus-separator --

SELECT repeat('[', 10000)::jsonb

-- sqlfmt-corpus-separator --

SELECT repeat('{"a":', 10000)::json

-- sqlfmt-corpus-separator --

SELECT repeat('{"a":', 10000)::jsonb

-- sqlfmt-corpus-separator --

SELECT repeat(U&'\00A7', 30)::json

-- sqlfmt-corpus-separator --

SELECT reverse(''::bytea)

-- sqlfmt-corpus-separator --

SELECT reverse('\xaa'::bytea)

-- sqlfmt-corpus-separator --

SELECT reverse('\xabcd'::bytea)

-- sqlfmt-corpus-separator --

SELECT rolname, regexp_replace(rolpassword, '(SCRAM-SHA-256)\$(\d+):([a-zA-Z0-9+/=]+)\$([a-zA-Z0-9+=/]+):([a-zA-Z0-9+/=]+)', '\1$\2:<salt>$<storedkey>:<serverkey>') as rolpassword_masked
    FROM pg_authid
    WHERE rolname LIKE 'regress_passwd%'
    ORDER BY rolname, rolpassword

-- sqlfmt-corpus-separator --

SELECT rolname, rolpassword
    FROM pg_authid
    WHERE rolname LIKE 'regress_passwd%'
    ORDER BY rolname, rolpassword

-- sqlfmt-corpus-separator --

SELECT rolname, rolpassword
    FROM pg_authid
    WHERE rolname LIKE 'regress_passwd2_new'
    ORDER BY rolname, rolpassword

-- sqlfmt-corpus-separator --

SELECT rolname, rolpassword not like '%A6xHKoH/494E941doaPOYg==%' as is_rolpassword_rehashed
    FROM pg_authid
    WHERE rolname LIKE 'regress_passwd_sha_len%'
    ORDER BY rolname

-- sqlfmt-corpus-separator --

SELECT row_number() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY unique2) FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT s, s::point FROM LSEG_TBL

-- sqlfmt-corpus-separator --

SELECT s.stxkind, replace(d.stxdndistinct, '}, ', E'},\n') AS stxdndistinct
  FROM pg_statistic_ext s, pg_statistic_ext_data d
 WHERE s.stxrelid = 'ndistinct'::regclass
   AND d.stxoid = s.oid

-- sqlfmt-corpus-separator --

SELECT s.stxname, objsubid, description FROM pg_description, pg_statistic_ext s WHERE classoid = 'pg_statistic_ext'::regclass AND objoid = s.oid AND s.stxrelid = 'ctlt_all'::regclass ORDER BY s.stxname, objsubid

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash'::regclass, 0, 0, NULL)

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash'::regclass, 1, -1, NULL)

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash'::regclass, 1, 1, NULL)

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash'::regclass, 2, 1, NULL::int, NULL::int)

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash'::regclass, 3, 1, NULL::int)

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash'::regclass, 4, 0, 0, ''::text)

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash'::regclass, 4, 0, 2, ''::text)

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash'::regclass, 4, 0, NULL::int, NULL::text, NULL::json)

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash'::regclass, 4, NULL, NULL)

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash'::regclass, NULL, 0, NULL)

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('mchash1'::regclass, 4, 0, NULL)

-- sqlfmt-corpus-separator --

SELECT satisfies_hash_partition('tenk1'::regclass, 4, 0, NULL)

-- sqlfmt-corpus-separator --

SELECT seqtypid::regtype FROM pg_sequence WHERE seqrelid = 'itest3_a_seq'::regclass

-- sqlfmt-corpus-separator --

SELECT sequence_name FROM information_schema.sequences WHERE sequence_name LIKE 'itest%'

-- sqlfmt-corpus-separator --

SELECT set_bit('\x1234567890abcdef00'::bytea, 43, 0)

-- sqlfmt-corpus-separator --

SELECT set_bit('\x1234567890abcdef00'::bytea, 99, 0)

-- sqlfmt-corpus-separator --

SELECT set_bit(B'0101011000100100', 15, 1)

-- sqlfmt-corpus-separator --

SELECT set_bit(B'0101011000100100', 16, 1)

-- sqlfmt-corpus-separator --

SELECT set_byte('\x1234567890abcdef00'::bytea, 7, 11)

-- sqlfmt-corpus-separator --

SELECT set_byte('\x1234567890abcdef00'::bytea, 99, 11)

-- sqlfmt-corpus-separator --

SELECT setval('sequence_test'::regclass, 32)

-- sqlfmt-corpus-separator --

SELECT setval('sequence_test'::regclass, 99, false)

-- sqlfmt-corpus-separator --

SELECT setval('sequence_test'::text, 32)

-- sqlfmt-corpus-separator --

SELECT setval('sequence_test'::text, 99, false)

-- sqlfmt-corpus-separator --

SELECT setweight('a:1,3A asd:1C w:5,6,12B,13A zxc:81,222A,567'::tsvector, 'c')

-- sqlfmt-corpus-separator --

SELECT setweight('a:1,3A asd:1C w:5,6,12B,13A zxc:81,222A,567'::tsvector, 'c', '{a,zxc}')

-- sqlfmt-corpus-separator --

SELECT setweight('a:1,3A asd:1C w:5,6,12B,13A zxc:81,222A,567'::tsvector, 'c', '{a}')

-- sqlfmt-corpus-separator --

SELECT setweight('w:12B w:13* w:12,5,6 a:1,3* a:3 w asd:1dc asd zxc:81,567,222A'::tsvector, 'c')

-- sqlfmt-corpus-separator --

SELECT sinh(float8 '-infinity')

-- sqlfmt-corpus-separator --

SELECT sinh(float8 '1')

-- sqlfmt-corpus-separator --

SELECT sinh(float8 'infinity')

-- sqlfmt-corpus-separator --

SELECT sinh(float8 'nan')

-- sqlfmt-corpus-separator --

SELECT sqrt('-1'::numeric)

-- sqlfmt-corpus-separator --

SELECT sqrt('-inf'::numeric)

-- sqlfmt-corpus-separator --

SELECT sqrt(float8 '64') AS eight

-- sqlfmt-corpus-separator --

SELECT srvname FROM pg_foreign_server WHERE srvname like 'alt_fserv%'

-- sqlfmt-corpus-separator --

SELECT stddev_pop('inf'::float4), stddev_samp('inf'::float4)

-- sqlfmt-corpus-separator --

SELECT stddev_pop('inf'::float8), stddev_samp('inf'::float8)

-- sqlfmt-corpus-separator --

SELECT stddev_pop('inf'::numeric), stddev_samp('inf'::numeric)

-- sqlfmt-corpus-separator --

SELECT stddev_pop('nan'::float4), stddev_samp('nan'::float4)

-- sqlfmt-corpus-separator --

SELECT stddev_pop('nan'::float8), stddev_samp('nan'::float8)

-- sqlfmt-corpus-separator --

SELECT stddev_pop('nan'::numeric), stddev_samp('nan'::numeric)

-- sqlfmt-corpus-separator --

SELECT stddev_pop(3.0::float4), stddev_samp(4.0::float4)

-- sqlfmt-corpus-separator --

SELECT stddev_pop(3.0::float8), stddev_samp(4.0::float8)

-- sqlfmt-corpus-separator --

SELECT stddev_pop(3.0::numeric), stddev_samp(4.0::numeric)

-- sqlfmt-corpus-separator --

SELECT stddev_pop(b::numeric) FROM aggtest

-- sqlfmt-corpus-separator --

SELECT stddev_samp(b::numeric) FROM aggtest

-- sqlfmt-corpus-separator --

SELECT strip('base hidden rebel spaceship strike'::tsvector)

-- sqlfmt-corpus-separator --

SELECT strip('base:7 hidden:6 rebel:1 spaceship:2,33A,34B,35C,36D strike:3'::tsvector)

-- sqlfmt-corpus-separator --

SELECT strip('w:12B w:13* w:12,5,6 a:1,3* a:3 w asd:1dc asd'::tsvector)

-- sqlfmt-corpus-separator --

SELECT strip('wa:1A'::tsvector) @@ '!w:*A'::tsquery as "false"

-- sqlfmt-corpus-separator --

SELECT strip('wa:1A'::tsvector) @@ '!w:*D'::tsquery as "false"

-- sqlfmt-corpus-separator --

SELECT strip('wa:1A'::tsvector) @@ 'w:*A'::tsquery as "true"

-- sqlfmt-corpus-separator --

SELECT strip('wa:1A'::tsvector) @@ 'w:*D'::tsquery as "true"

-- sqlfmt-corpus-separator --

SELECT stxname FROM pg_statistic_ext WHERE stxname LIKE 'ab1%'

-- sqlfmt-corpus-separator --

SELECT substring(indtoasttest::text, 1, 200) FROM indtoasttest

-- sqlfmt-corpus-separator --

SELECT sum(four) OVER (PARTITION BY ten ORDER BY unique2) AS sum_1, ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT sum(gpa) AS avg_6_8 FROM ONLY student

-- sqlfmt-corpus-separator --

SELECT sum(orbit) OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT sum(salary) OVER w, rank() OVER w FROM empsalary WINDOW w AS (PARTITION BY depname ORDER BY salary DESC)

-- sqlfmt-corpus-separator --

SELECT sum(salary) OVER w1, count(*) OVER w2
FROM empsalary WINDOW w1 AS (ORDER BY salary), w2 AS (ORDER BY salary)

-- sqlfmt-corpus-separator --

SELECT sum(salary),
	row_number() OVER (ORDER BY depname),
	sum(sum(salary)) OVER (ORDER BY depname DESC)
FROM empsalary GROUP BY depname

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

SELECT t1.a, t2.b FROM prt1 t1, prt2 t2 WHERE t1::text = t2::text AND t1.a = t2.b ORDER BY t1.a

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
WHERE t1.typoutput = p1.oid AND NOT
    (p1.prorettype = 'cstring'::regtype AND NOT p1.proretset)

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

SELECT table_name, column_name, column_default, is_nullable, is_identity, identity_generation, identity_start, identity_increment, identity_maximum, identity_minimum, identity_cycle FROM information_schema.columns WHERE table_name LIKE 'itest_' ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, is_nullable, is_identity, identity_generation FROM information_schema.columns WHERE table_name LIKE 'itest7%' ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, is_updatable
  FROM information_schema.columns
 WHERE table_name LIKE 'rw_view%'
 ORDER BY table_name, ordinal_position

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, is_updatable
  FROM information_schema.columns
 WHERE table_name LIKE E'r_\\_view%'
 ORDER BY table_name, ordinal_position

-- sqlfmt-corpus-separator --

SELECT table_name, is_insertable_into
  FROM information_schema.tables
 WHERE table_name LIKE 'rw_view%'
 ORDER BY table_name

-- sqlfmt-corpus-separator --

SELECT table_name, is_insertable_into
  FROM information_schema.tables
 WHERE table_name LIKE E'r_\\_view%'
 ORDER BY table_name

-- sqlfmt-corpus-separator --

SELECT table_name, is_updatable, is_insertable_into
  FROM information_schema.views
 WHERE table_name LIKE 'rw_view%'
 ORDER BY table_name

-- sqlfmt-corpus-separator --

SELECT table_name, is_updatable, is_insertable_into
  FROM information_schema.views
 WHERE table_name LIKE E'r_\\_view%'
 ORDER BY table_name

-- sqlfmt-corpus-separator --

SELECT table_name, is_updatable, is_insertable_into,
       is_trigger_updatable, is_trigger_deletable,
       is_trigger_insertable_into
  FROM information_schema.views
 WHERE table_name LIKE 'rw_view%'
 ORDER BY table_name

-- sqlfmt-corpus-separator --

SELECT table_name, view_definition FROM information_schema.views
  WHERE table_name LIKE 'collview%' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT table_name, view_definition FROM information_schema.views
  WHERE table_name LIKE 'xmlview%' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT tablename, null_frac
FROM pg_stats
WHERE schemaname like 'pg_temp%'
AND tablename = 'stats_temp'
AND inherited = false
AND attname = 'i'

-- sqlfmt-corpus-separator --

SELECT tableoid::pg_catalog.regclass, * FROM fkpart11.fk

-- sqlfmt-corpus-separator --

SELECT tableoid::pg_catalog.regclass, * FROM fkpart11.fk_another

-- sqlfmt-corpus-separator --

SELECT tableoid::pg_catalog.regclass, * FROM fkpart11.fk_parted

-- sqlfmt-corpus-separator --

SELECT tableoid::pg_catalog.regclass, * FROM fkpart11.pk

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, * FROM fk

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, * FROM gtest_child ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, * FROM gtest_child2 ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, * FROM gtest_child3 ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, * FROM gtest_parent ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, * FROM measurement ORDER BY city_id, logdate

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, * FROM measurement ORDER BY city_id, logdate, peaktemp

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, * FROM sales_date

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, * FROM t ORDER BY b

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, * FROM t1

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, * FROM temporal_partitioned ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, a, b FROM part_7 order by a

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, f1, f2, f3 FROM pitest1

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, f1, f2, f3 FROM pitest1_p1_like

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, f1, f2, f3 FROM pitest2

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, f1, f2, f3 FROM pitest2_p1

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, f1, f2, f3 FROM pitest3

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, f1, f2, f3, pg_typeof(f3) FROM pitest1

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, f1, f2, f3, pg_typeof(f3) FROM pitest1_p2

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass, id % 2 = 0 is_even, count(*) from parted_si GROUP BY 1, 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass,* FROM fkpart13_t2

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass,* FROM fkpart13_t3

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass::text, * FROM list_parted ORDER BY 1, 2, 3, 4

-- sqlfmt-corpus-separator --

SELECT tableoid::regclass::text, * FROM list_parted WHERE a = 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT tanh(float8 '-infinity')

-- sqlfmt-corpus-separator --

SELECT tanh(float8 '1')

-- sqlfmt-corpus-separator --

SELECT tanh(float8 'infinity')

-- sqlfmt-corpus-separator --

SELECT tanh(float8 'nan')

-- sqlfmt-corpus-separator --

SELECT ten, two, sum(hundred) AS gsum, sum(sum(hundred)) OVER (PARTITION BY two ORDER BY ten) AS wsum
FROM tenk1 GROUP BY ten, two

-- sqlfmt-corpus-separator --

SELECT ten, two, sum(hundred) AS gsum, sum(sum(hundred)) OVER win AS wsum
FROM tenk1 GROUP BY ten, two WINDOW win AS (PARTITION BY two ORDER BY ten)

-- sqlfmt-corpus-separator --

SELECT test_pglz_decompress('\x01'::bytea, 1024, true)

-- sqlfmt-corpus-separator --

SELECT test_pglz_decompress('\x010f01'::bytea, 1024, false)

-- sqlfmt-corpus-separator --

SELECT test_pglz_decompress('\x010f01'::bytea, 1024, true)

-- sqlfmt-corpus-separator --

SELECT test_pglz_decompress('\x01ff'::bytea, 1024, false)

-- sqlfmt-corpus-separator --

SELECT test_pglz_decompress('\x01ff'::bytea, 1024, true)

-- sqlfmt-corpus-separator --

SELECT text 'this is a text string' = text 'this is a text strin' AS false

-- sqlfmt-corpus-separator --

SELECT text 'this is a text string' = text 'this is a text string' AS true

-- sqlfmt-corpus-separator --

SELECT tgrelid::regclass, tgenabled FROM pg_trigger
  WHERE tgrelid::regclass IN (SELECT oid from pg_class where relname LIKE 'trgfire%')
  ORDER BY tgrelid::regclass::text

-- sqlfmt-corpus-separator --

SELECT tid_block('(-1,0)'::tid)

-- sqlfmt-corpus-separator --

SELECT tid_block('(0,0)'::tid), tid_offset('(0,0)'::tid)

-- sqlfmt-corpus-separator --

SELECT tid_block('(0,1)'::tid), tid_offset('(0,1)'::tid)

-- sqlfmt-corpus-separator --

SELECT tid_block('(42,7)'::tid), tid_offset('(42,7)'::tid)

-- sqlfmt-corpus-separator --

SELECT tid_block('(4294967295,65535)'::tid), tid_offset('(4294967295,65535)'::tid)

-- sqlfmt-corpus-separator --

SELECT tid_block(NULL::tid), tid_offset(NULL::tid)

-- sqlfmt-corpus-separator --

SELECT time '11:27:42' + interval '-infinity'

-- sqlfmt-corpus-separator --

SELECT time '11:27:42' + interval 'infinity'

-- sqlfmt-corpus-separator --

SELECT time '11:27:42' - interval '-infinity'

-- sqlfmt-corpus-separator --

SELECT time '11:27:42' - interval 'infinity'

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

SELECT time without time zone '0405'

-- sqlfmt-corpus-separator --

SELECT time without time zone '040506'

-- sqlfmt-corpus-separator --

SELECT time without time zone '040506.07'

-- sqlfmt-corpus-separator --

SELECT time without time zone '040506.789+08'

-- sqlfmt-corpus-separator --

SELECT time without time zone '040506.789-08'

-- sqlfmt-corpus-separator --

SELECT time without time zone '04:05'

-- sqlfmt-corpus-separator --

SELECT time without time zone '04:05:06'

-- sqlfmt-corpus-separator --

SELECT time without time zone '04:05:06.07'

-- sqlfmt-corpus-separator --

SELECT time without time zone 'T04'

-- sqlfmt-corpus-separator --

SELECT time without time zone 'T0405'

-- sqlfmt-corpus-separator --

SELECT time without time zone 'T040506'

-- sqlfmt-corpus-separator --

SELECT time without time zone 'T040506.07'

-- sqlfmt-corpus-separator --

SELECT time without time zone 'T040506.789+08'

-- sqlfmt-corpus-separator --

SELECT time without time zone 'T040506.789-08'

-- sqlfmt-corpus-separator --

SELECT time without time zone 'T04:05'

-- sqlfmt-corpus-separator --

SELECT time without time zone 'T04:05:06'

-- sqlfmt-corpus-separator --

SELECT time without time zone 'T04:05:06.07'

-- sqlfmt-corpus-separator --

SELECT timestamp '-infinity 01:01:01'

-- sqlfmt-corpus-separator --

SELECT timestamp '-infinity infinity'

-- sqlfmt-corpus-separator --

SELECT timestamp '1995-08-06 -infinity'

-- sqlfmt-corpus-separator --

SELECT timestamp '1995-08-06 epoch'

-- sqlfmt-corpus-separator --

SELECT timestamp '1995-08-06 infinity'

-- sqlfmt-corpus-separator --

SELECT timestamp '294276-12-31 23:59:59' - timestamp '1999-12-23 19:59:04.224192' AS overflows

-- sqlfmt-corpus-separator --

SELECT timestamp '294276-12-31 23:59:59' - timestamp '1999-12-23 19:59:04.224193' AS ok

-- sqlfmt-corpus-separator --

SELECT timestamp 'epoch 01:01:01'

-- sqlfmt-corpus-separator --

SELECT timestamp 'infinity 01:01:01'

-- sqlfmt-corpus-separator --

SELECT timestamp 'infinity' = timestamp '+infinity' AS t

-- sqlfmt-corpus-separator --

SELECT timestamp 'now epoch'

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

SELECT timestamptz '-infinity 01:01:01'

-- sqlfmt-corpus-separator --

SELECT timestamptz '-infinity infinity'

-- sqlfmt-corpus-separator --

SELECT timestamptz '-infinity' - timestamptz '-infinity'

-- sqlfmt-corpus-separator --

SELECT timestamptz '-infinity' - timestamptz '1995-08-06 12:12:12'

-- sqlfmt-corpus-separator --

SELECT timestamptz '-infinity' - timestamptz 'infinity'

-- sqlfmt-corpus-separator --

SELECT timestamptz '1995-08-06 -infinity'

-- sqlfmt-corpus-separator --

SELECT timestamptz '1995-08-06 epoch'

-- sqlfmt-corpus-separator --

SELECT timestamptz '1995-08-06 infinity'

-- sqlfmt-corpus-separator --

SELECT timestamptz '294276-12-31 23:59:59 UTC' - timestamptz '1999-12-23 19:59:04.224192 UTC' AS overflows

-- sqlfmt-corpus-separator --

SELECT timestamptz '294276-12-31 23:59:59 UTC' - timestamptz '1999-12-23 19:59:04.224193 UTC' AS ok

-- sqlfmt-corpus-separator --

SELECT timestamptz 'epoch 01:01:01'

-- sqlfmt-corpus-separator --

SELECT timestamptz 'infinity 01:01:01'

-- sqlfmt-corpus-separator --

SELECT timestamptz 'infinity' - timestamptz '-infinity'

-- sqlfmt-corpus-separator --

SELECT timestamptz 'infinity' - timestamptz '1995-08-06 12:12:12'

-- sqlfmt-corpus-separator --

SELECT timestamptz 'infinity' - timestamptz 'infinity'

-- sqlfmt-corpus-separator --

SELECT timestamptz 'infinity' = timestamptz '+infinity' AS t

-- sqlfmt-corpus-separator --

SELECT timestamptz 'now epoch'

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

SELECT timetz '11:27:42' + interval '-infinity'

-- sqlfmt-corpus-separator --

SELECT timetz '11:27:42' + interval 'infinity'

-- sqlfmt-corpus-separator --

SELECT timetz '11:27:42' - interval '-infinity'

-- sqlfmt-corpus-separator --

SELECT timetz '11:27:42' - interval 'infinity'

-- sqlfmt-corpus-separator --

SELECT timezone('-infinity'::interval, '12:12:12'::time)

-- sqlfmt-corpus-separator --

SELECT timezone('-infinity'::interval, '12:12:12'::timetz)

-- sqlfmt-corpus-separator --

SELECT timezone('-infinity'::interval, '1995-08-06 12:12:12'::timestamp)

-- sqlfmt-corpus-separator --

SELECT timezone('-infinity'::interval, '1995-08-06 12:12:12'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT timezone('infinity'::interval, '12:12:12'::time)

-- sqlfmt-corpus-separator --

SELECT timezone('infinity'::interval, '12:12:12'::timetz)

-- sqlfmt-corpus-separator --

SELECT timezone('infinity'::interval, '1995-08-06 12:12:12'::timestamp)

-- sqlfmt-corpus-separator --

SELECT timezone('infinity'::interval, '1995-08-06 12:12:12'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT to_char('-infinity'::interval, 'YYYY')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'FM999')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'FM999.')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'FM999.9')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'f"\\ool"999')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'f"\ool"999')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'f"ool"999')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'f"ool\"999')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'f"ool\\"999')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'f\"oo999')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'f\\"oo999')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'f\\oo999')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'f\oo999')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'foo999')

-- sqlfmt-corpus-separator --

SELECT to_char('100'::numeric, 'rn')

-- sqlfmt-corpus-separator --

SELECT to_char('100e9'::float4, 'RN')

-- sqlfmt-corpus-separator --

SELECT to_char('100e9'::float8, 'RN')

-- sqlfmt-corpus-separator --

SELECT to_char('100e9'::numeric, 'RN')

-- sqlfmt-corpus-separator --

SELECT to_char('1234'::numeric, 'rn')

-- sqlfmt-corpus-separator --

SELECT to_char('12345678901'::float8, 'FM9999999999D9999900000000000000000')

-- sqlfmt-corpus-separator --

SELECT to_char('1235'::float4, 'rn')

-- sqlfmt-corpus-separator --

SELECT to_char('1236'::float8, 'rn')

-- sqlfmt-corpus-separator --

SELECT to_char('1237'::float8, 'fmrn')

-- sqlfmt-corpus-separator --

SELECT to_char('2012-12-12 12:00'::timestamptz, 'YYYY-MM-DD HH:MI:SS TZ')

-- sqlfmt-corpus-separator --

SELECT to_char('2012-12-12 12:00'::timestamptz, 'YYYY-MM-DD HH:MI:SS tz')

-- sqlfmt-corpus-separator --

SELECT to_char('2012-12-12 12:00'::timestamptz, 'YYYY-MM-DD SSSS')

-- sqlfmt-corpus-separator --

SELECT to_char('2012-12-12 12:00'::timestamptz, 'YYYY-MM-DD SSSSS')

-- sqlfmt-corpus-separator --

SELECT to_char('infinity'::interval, 'YYYY')

-- sqlfmt-corpus-separator --

SELECT to_char(-1234::int8, '9.99eeee')

-- sqlfmt-corpus-separator --

SELECT to_char(1234.56::float4, '99999V99')

-- sqlfmt-corpus-separator --

SELECT to_char(1234.56::float8, '99999V99')

-- sqlfmt-corpus-separator --

SELECT to_char(1234.56::numeric, '99999V99')

-- sqlfmt-corpus-separator --

SELECT to_char(1234::int8, '9.99eeee')

-- sqlfmt-corpus-separator --

SELECT to_char(1234::int8, '99999V99')

-- sqlfmt-corpus-separator --

SELECT to_char(date '2010-02-01', 'DD TMMON YYYY')

-- sqlfmt-corpus-separator --

SELECT to_char(date '2010-04-01', 'DD TMMON YYYY')

-- sqlfmt-corpus-separator --

SELECT to_regclass('-')::oid

-- sqlfmt-corpus-separator --

SELECT to_regcollation('-')::oid

-- sqlfmt-corpus-separator --

SELECT to_regdatabase('-')::oid

-- sqlfmt-corpus-separator --

SELECT to_regnamespace('-')::oid

-- sqlfmt-corpus-separator --

SELECT to_regproc('-')::oid

-- sqlfmt-corpus-separator --

SELECT to_regprocedure('-')::oid

-- sqlfmt-corpus-separator --

SELECT to_regrole('-')::oid

-- sqlfmt-corpus-separator --

SELECT to_regtype('-')::oid

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

SELECT ts_delete('base hidden rebel spaceship strike'::tsvector, 'spaceship')

-- sqlfmt-corpus-separator --

SELECT ts_delete('base:7 hidden:6 rebel:1 spaceship:2,33A,34B,35C,36D strike:3'::tsvector, 'bas')

-- sqlfmt-corpus-separator --

SELECT ts_delete('base:7 hidden:6 rebel:1 spaceship:2,33A,34B,35C,36D strike:3'::tsvector, 'base')

-- sqlfmt-corpus-separator --

SELECT ts_delete('base:7 hidden:6 rebel:1 spaceship:2,33A,34B,35C,36D strike:3'::tsvector, 'bases')

-- sqlfmt-corpus-separator --

SELECT ts_delete('base:7 hidden:6 rebel:1 spaceship:2,33A,34B,35C,36D strike:3'::tsvector, 'spaceship')

-- sqlfmt-corpus-separator --

SELECT ts_filter('base hidden rebel spaceship strike'::tsvector, '{a,b,NULL}')

-- sqlfmt-corpus-separator --

SELECT ts_filter('base hidden rebel spaceship strike'::tsvector, '{a}')

-- sqlfmt-corpus-separator --

SELECT ts_filter('base:7A empir:17 evil:15 first:11 galact:16 hidden:6A rebel:1A spaceship:2A strike:3A victori:12 won:9'::tsvector, '{a}')

-- sqlfmt-corpus-separator --

SELECT ts_headline('simple', '1 2 3 1 3'::text, '1 & 3', 'MaxWords=4, MinWords=1')

-- sqlfmt-corpus-separator --

SELECT ts_headline('simple', '1 2 3 1 3'::text, '1 <-> 3', 'MaxWords=2, MinWords=1')

-- sqlfmt-corpus-separator --

SELECT ts_headline('simple', '1 2 3 1 3'::text, '1 <-> 3', 'MaxWords=4, MinWords=1')

-- sqlfmt-corpus-separator --

SELECT ts_rank(' a:1 s:2 d g'::tsvector, 'a & s')

-- sqlfmt-corpus-separator --

SELECT ts_rank(' a:1 s:2 d g'::tsvector, 'a | s')

-- sqlfmt-corpus-separator --

SELECT ts_rank(' a:1 s:2B d g'::tsvector, 'a & s')

-- sqlfmt-corpus-separator --

SELECT ts_rank(' a:1 s:2B d g'::tsvector, 'a | s')

-- sqlfmt-corpus-separator --

SELECT ts_rank(' a:1 s:2C d g'::tsvector, 'a & s')

-- sqlfmt-corpus-separator --

SELECT ts_rank(' a:1 s:2C d g'::tsvector, 'a | s')

-- sqlfmt-corpus-separator --

SELECT ts_rank(' a:1 sa:2C d g'::tsvector, 'a | s')

-- sqlfmt-corpus-separator --

SELECT ts_rank(' a:1 sa:2C d g'::tsvector, 'a | s:*')

-- sqlfmt-corpus-separator --

SELECT ts_rank(' a:1 sa:2C d g'::tsvector, 'a | sa:*')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 b:2 s:3A d:2A g'::tsvector, 'a <2> s:A')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 s:2 d g'::tsvector, 'a & s')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 s:2 d g'::tsvector, 'a <-> s')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 s:2 d g'::tsvector, 'a | s')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 s:2 d:2A g'::tsvector, 'a <-> s')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 s:2,3A d:2A g'::tsvector, 'a <2> s:A')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 s:2A d g'::tsvector, 'a <-> s')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 s:2B d g'::tsvector, 'a & s')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 s:2B d g'::tsvector, 'a | s')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 s:2C d g'::tsvector, 'a & s')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 s:2C d g'::tsvector, 'a <-> s')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 s:2C d g'::tsvector, 'a | s')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 sa:2A sb:2D g'::tsvector, 'a <-> s:* <-> sa:A')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 sa:2A sb:2D g'::tsvector, 'a <-> s:* <-> sa:B')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 sa:2A sb:2D g'::tsvector, 'a <-> s:*')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 sa:2C d g'::tsvector, 'a | s')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 sa:2C d g'::tsvector, 'a | s:*')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 sa:2C d g'::tsvector, 'a | sa:*')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 sa:2D sb:2A g'::tsvector, 'a <-> s:*')

-- sqlfmt-corpus-separator --

SELECT ts_rank_cd(' a:1 sa:3C sab:2c d g'::tsvector, 'a | sa:*')

-- sqlfmt-corpus-separator --

SELECT ts_rewrite('1 & (2 <-> 3)', 'SELECT keyword, sample FROM test_tsquery'::text )

-- sqlfmt-corpus-separator --

SELECT ts_rewrite('1 & (2 <2> 3)', 'SELECT keyword, sample FROM test_tsquery'::text )

-- sqlfmt-corpus-separator --

SELECT ts_rewrite('5 <-> (1 & (2 <-> 3))', 'SELECT keyword, sample FROM test_tsquery'::text )

-- sqlfmt-corpus-separator --

SELECT ts_rewrite('5 <-> (6 | 8)', 'SELECT keyword, sample FROM test_tsquery'::text )

-- sqlfmt-corpus-separator --

SELECT ts_rewrite('bar & qq & foo & (new <-> york)', 'SELECT keyword, sample FROM test_tsquery'::text )

-- sqlfmt-corpus-separator --

SELECT ts_rewrite('foo & bar & qq & new & york',  'new & york'::tsquery, 'big & apple | nyc | new & york & city')

-- sqlfmt-corpus-separator --

SELECT ts_rewrite('moscow & hotel', 'SELECT keyword, sample FROM test_tsquery'::text )

-- sqlfmt-corpus-separator --

SELECT ts_rewrite('moscow', 'SELECT keyword, sample FROM test_tsquery'::text )

-- sqlfmt-corpus-separator --

SELECT tsvector_to_array('base hidden rebel spaceship strike'::tsvector)

-- sqlfmt-corpus-separator --

SELECT tsvector_to_array('base:7 hidden:6 rebel:1 spaceship:2,33A,34B,35C,36D strike:3'::tsvector)

-- sqlfmt-corpus-separator --

SELECT tsvectorin(tsvectorout($$'\\as' ab\c ab\\c AB\\\c ab\\\\c$$::tsvector))

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

SELECT txid_snapshot '1:9223372036854775807:3'

-- sqlfmt-corpus-separator --

SELECT txid_snapshot '1:9223372036854775808:3'

-- sqlfmt-corpus-separator --

SELECT typname FROM pg_type WHERE oid = '_attmp_array[]'::regtype

-- sqlfmt-corpus-separator --

SELECT typname FROM pg_type WHERE oid = 'attmp_array2[]'::regtype

-- sqlfmt-corpus-separator --

SELECT typname FROM pg_type WHERE oid = 'attmp_array[]'::regtype

-- sqlfmt-corpus-separator --

SELECT unique1 FROM tenk1 WHERE unique1 < 3 and unique1 < (-1)::bigint

-- sqlfmt-corpus-separator --

SELECT unique1 FROM tenk1 WHERE unique1 = ANY('{7, 14, 22}') and unique1 = ANY('{33, 44}'::bigint[])

-- sqlfmt-corpus-separator --

SELECT unique1 FROM tenk1 WHERE unique1 = ANY('{NULL,NULL,NULL}')

-- sqlfmt-corpus-separator --

SELECT unique1 FROM tenk1 WHERE unique1 = ANY(NULL)

-- sqlfmt-corpus-separator --

SELECT unnest('base hidden rebel spaceship strike'::tsvector)

-- sqlfmt-corpus-separator --

SELECT unnest('base:7 hidden:6 rebel:1 spaceship:2,33A,34B,35C,36D strike:3'::tsvector)

-- sqlfmt-corpus-separator --

SELECT unnest(pg_get_acl('pg_class'::regclass, 'atest2'::regclass::oid, 0))

-- sqlfmt-corpus-separator --

SELECT unnest(pg_get_acl('pg_class'::regclass, 'atest5'::regclass::oid, 1))

-- sqlfmt-corpus-separator --

SELECT unnest(pg_get_acl('pg_class'::regclass, 'atest5'::regclass::oid, 2))

-- sqlfmt-corpus-separator --

SELECT unnest(pg_get_acl('pg_class'::regclass, 'atest5'::regclass::oid, 3))

-- sqlfmt-corpus-separator --

SELECT unnest(pg_get_acl('pg_class'::regclass, 'atest5'::regclass::oid, 4))

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

SELECT var_pop('inf'::float4), var_samp('inf'::float4)

-- sqlfmt-corpus-separator --

SELECT var_pop('inf'::float8), var_samp('inf'::float8)

-- sqlfmt-corpus-separator --

SELECT var_pop('inf'::numeric), var_samp('inf'::numeric)

-- sqlfmt-corpus-separator --

SELECT var_pop('nan'::float4), var_samp('nan'::float4)

-- sqlfmt-corpus-separator --

SELECT var_pop('nan'::float8), var_samp('nan'::float8)

-- sqlfmt-corpus-separator --

SELECT var_pop('nan'::numeric), var_samp('nan'::numeric)

-- sqlfmt-corpus-separator --

SELECT var_pop(1.0::float4), var_samp(2.0::float4)

-- sqlfmt-corpus-separator --

SELECT var_pop(1.0::float8), var_samp(2.0::float8)

-- sqlfmt-corpus-separator --

SELECT var_pop(1.0::numeric), var_samp(2.0::numeric)

-- sqlfmt-corpus-separator --

SELECT var_pop(b::numeric) FROM aggtest

-- sqlfmt-corpus-separator --

SELECT var_samp(b::numeric) FROM aggtest

-- sqlfmt-corpus-separator --

SELECT width_bucket('Infinity'::float8, 1, 10, 10),
       width_bucket('-Infinity'::float8, 1, 10, 10)

-- sqlfmt-corpus-separator --

SELECT width_bucket('Infinity'::numeric, 1, 10, 10),
       width_bucket('-Infinity'::numeric, 1, 10, 10)

-- sqlfmt-corpus-separator --

SELECT width_bucket('NaN'::float8, 3.0::float8, 4.0::float8, 888)

-- sqlfmt-corpus-separator --

SELECT width_bucket(0, -1e100::float8, 1, 10)

-- sqlfmt-corpus-separator --

SELECT width_bucket(0, -1e100::numeric, 1, 10)

-- sqlfmt-corpus-separator --

SELECT width_bucket(0.0::float8, 'Infinity'::float8, 5, 10)

-- sqlfmt-corpus-separator --

SELECT width_bucket(0.0::float8, 5, '-Infinity'::float8, 20)

-- sqlfmt-corpus-separator --

SELECT width_bucket(0.0::numeric, 'Infinity'::numeric, 5, 10)

-- sqlfmt-corpus-separator --

SELECT width_bucket(0.0::numeric, 5, '-Infinity'::numeric, 20)

-- sqlfmt-corpus-separator --

SELECT width_bucket(0::float8, '-inf', 4.0::float8, 888)

-- sqlfmt-corpus-separator --

SELECT width_bucket(0::float8, 'NaN', 4.0::float8, 888)

-- sqlfmt-corpus-separator --

SELECT width_bucket(0::float8, 1, 0, 2147483647)

-- sqlfmt-corpus-separator --

SELECT width_bucket(1, 1e100::float8, 0, 10)

-- sqlfmt-corpus-separator --

SELECT width_bucket(1, 1e100::numeric, 0, 10)

-- sqlfmt-corpus-separator --

SELECT width_bucket(1::float8, 0, 1, 2147483647)

-- sqlfmt-corpus-separator --

SELECT width_bucket(3.5::float8, 3.0::float8, 3.0::float8, 888)

-- sqlfmt-corpus-separator --

SELECT width_bucket(5.0::float8, 3.0::float8, 4.0::float8, -5)

-- sqlfmt-corpus-separator --

SELECT width_bucket(5.0::float8, 3.0::float8, 4.0::float8, 0)

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

SELECT x FROM test3bpci WHERE x ILIKE 'a%'

-- sqlfmt-corpus-separator --

SELECT x FROM test3bpci WHERE x LIKE 'a%'

-- sqlfmt-corpus-separator --

SELECT x FROM test3bpci WHERE x SIMILAR TO 'a%'

-- sqlfmt-corpus-separator --

SELECT x FROM test3ci WHERE x ILIKE 'a%'

-- sqlfmt-corpus-separator --

SELECT x FROM test3ci WHERE x LIKE 'a%'

-- sqlfmt-corpus-separator --

SELECT x FROM test3ci WHERE x SIMILAR TO 'a%'

-- sqlfmt-corpus-separator --

SELECT x FROM test3cs WHERE x ILIKE 'a%'

-- sqlfmt-corpus-separator --

SELECT x FROM test3cs WHERE x LIKE 'a%'

-- sqlfmt-corpus-separator --

SELECT x FROM test3cs WHERE x SIMILAR TO 'a%'

-- sqlfmt-corpus-separator --

SELECT x'0 '

-- sqlfmt-corpus-separator --

SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3bpci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3ci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3cs ORDER BY x

-- sqlfmt-corpus-separator --

SELECT xml '<!-- hi--> <oops/> <!DOCTYPE a><a/>'

-- sqlfmt-corpus-separator --

SELECT xml '<!-- hi--> oops <!DOCTYPE a><a/>'

-- sqlfmt-corpus-separator --

SELECT xml '<!-- in SQL:2006+ a doc is content too--> <?y z?> <!DOCTYPE a><a/>'

-- sqlfmt-corpus-separator --

SELECT xml '<!DOCTYPE a><a/>'

-- sqlfmt-corpus-separator --

SELECT xml '<!DOCTYPE a><a/><b/>'

-- sqlfmt-corpus-separator --

SELECT xml '<?xml version="1.0"?> <!-- hi--> <!DOCTYPE a><a/>'

-- sqlfmt-corpus-separator --

SELECT xmlexists('//town[text() = ''Cwmbran'']' PASSING BY REF '<towns><town>Bidford-on-Avon</town><town>Cwmbran</town><town>Bristol</town></towns>')

-- sqlfmt-corpus-separator --

SELECT xmlexists('//town[text() = ''Toronto'']' PASSING BY REF '<towns><town>Bidford-on-Avon</town><town>Cwmbran</town><town>Bristol</town></towns>')

-- sqlfmt-corpus-separator --

SELECT xmlexists('count(/nosuchtag)' PASSING BY REF '<root/>')

-- sqlfmt-corpus-separator --

SELECT xmltext('x'|| '<P>73</P>'::xml || .42 || true || 'j'::char)

-- sqlfmt-corpus-separator --

SELECT xpath_exists('//town[text() = ''Cwmbran'']','<towns><town>Bidford-on-Avon</town><town>Cwmbran</town><town>Bristol</town></towns>'::xml)

-- sqlfmt-corpus-separator --

SELECT xpath_exists('//town[text() = ''Toronto'']','<towns><town>Bidford-on-Avon</town><town>Cwmbran</town><town>Bristol</town></towns>'::xml)

-- sqlfmt-corpus-separator --

SELECT xpath_exists('count(/nosuchtag)', '<root/>'::xml)

-- sqlfmt-corpus-separator --

SELECT |/ float8 '64' AS eight

-- sqlfmt-corpus-separator --

SELECT ||/ float8 '27' AS three

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
  x (id) AS (SELECT 1 UNION ALL SELECT id+1 FROM y WHERE id < 5),
  y (id) AS (SELECT 1 UNION ALL SELECT id+1 FROM x WHERE id < 5)
SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE cte (a) as (
	SELECT a FROM duplicates
	UNION
	SELECT a FROM cte
)
SELECT a FROM cte

-- sqlfmt-corpus-separator --

WITH RECURSIVE subdepartment AS
(
	SELECT * FROM department WHERE name = 'A'
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

WITH RECURSIVE x(n) AS (
  SELECT 0 UNION SELECT 1
  ORDER BY (SELECT n FROM x))
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

WITH RECURSIVE x(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM x LIMIT 10 OFFSET 1)
  SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM x ORDER BY 1)
  SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT 1 UNION ALL SELECT sum(n) FROM x)
  SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT n FROM x UNION ALL SELECT 1)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE x(n) AS (SELECT n FROM x)
	SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH foo AS (SELECT * FROM gtest1) SELECT * FROM foo

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

WITH x(n, b) AS (SELECT 1)
SELECT * FROM x

-- sqlfmt-corpus-separator --

select
  (select max((select i.unique2 from tenk1 i where i.unique1 = o.unique1))
     filter (where o.unique1 < 10))
from tenk1 o

-- sqlfmt-corpus-separator --

select '  empty  '::textrange

-- sqlfmt-corpus-separator --

select '  {   {  "  0 second  "   ,  0 second  }   }'::text[]

-- sqlfmt-corpus-separator --

select '  {}  '::textmultirange

-- sqlfmt-corpus-separator --

select ' ( " a " " a ", " z " " z " )  '::textrange

-- sqlfmt-corpus-separator --

select ' ( empty, empty )  '::textrange

-- sqlfmt-corpus-separator --

select ' (Joe,Blow)  '::fullname

-- sqlfmt-corpus-separator --

select ' { empty, empty }  '::textmultirange

-- sqlfmt-corpus-separator --

select ' {( " a " " a ", " z " " z " )  }'::textmultirange

-- sqlfmt-corpus-separator --

select '"\b\f\r\n\t\v\"\''\\"'::jsonpath

-- sqlfmt-corpus-separator --

select '"\ud83dX"'::jsonpath

-- sqlfmt-corpus-separator --

select '"\ud83d\ud83d"'::jsonpath

-- sqlfmt-corpus-separator --

select '"\ud83d\ude04\ud83d\udc36"'::jsonpath as correct_in_utf8

-- sqlfmt-corpus-separator --

select '"\ude04X"'::jsonpath

-- sqlfmt-corpus-separator --

select '"\ude04\ud83d"'::jsonpath

-- sqlfmt-corpus-separator --

select '"\x50\u0067\u{53}\u{051}\u{00004C}"'::jsonpath

-- sqlfmt-corpus-separator --

select '"\z"'::jsonpath

-- sqlfmt-corpus-separator --

select '"a"'::jsonb #- '{a}'

-- sqlfmt-corpus-separator --

select '"a"'::jsonb - 'a'

-- sqlfmt-corpus-separator --

select '"a"'::jsonb - 1

-- sqlfmt-corpus-separator --

select '"a"'::jsonb || '{"a":1}'

-- sqlfmt-corpus-separator --

select '"aaa".type()'::jsonpath

-- sqlfmt-corpus-separator --

select '"b"'::jsonb || '"a"'::jsonb

-- sqlfmt-corpus-separator --

select '"c"' || '["a", "b"]'::jsonb

-- sqlfmt-corpus-separator --

select '"dollar \\u0024 character"'::jsonpath as not_an_escape

-- sqlfmt-corpus-separator --

select '"dollar \u0024 character"'::jsonpath as correct_everywhere

-- sqlfmt-corpus-separator --

select '"foo"'::json #> '{}'

-- sqlfmt-corpus-separator --

select '"foo"'::json #>> '{}'

-- sqlfmt-corpus-separator --

select '"foo"'::json -> 'z'

-- sqlfmt-corpus-separator --

select '"foo"'::json -> 1

-- sqlfmt-corpus-separator --

select '"foo"'::json ->> 'z'

-- sqlfmt-corpus-separator --

select '"foo"'::json ->> 1

-- sqlfmt-corpus-separator --

select '"foo"'::jsonb #> '{}'

-- sqlfmt-corpus-separator --

select '"foo"'::jsonb #>> '{}'

-- sqlfmt-corpus-separator --

select '"foo"'::jsonb -> 'z'

-- sqlfmt-corpus-separator --

select '"foo"'::jsonb -> 1

-- sqlfmt-corpus-separator --

select '"foo"'::jsonb ->> 'z'

-- sqlfmt-corpus-separator --

select '"foo"'::jsonb ->> 1

-- sqlfmt-corpus-separator --

select '"hello"'::jsonb::int2

-- sqlfmt-corpus-separator --

select '"hello"'::jsonb::int4

-- sqlfmt-corpus-separator --

select '"hello"'::jsonb::int8

-- sqlfmt-corpus-separator --

select '"last"'::jsonpath

-- sqlfmt-corpus-separator --

select '"null \\u0000 escape"'::jsonpath as not_an_escape

-- sqlfmt-corpus-separator --

select '"null \u0000 escape"'::jsonpath as not_unescaped

-- sqlfmt-corpus-separator --

select '"the Copyright \u00a9 sign"'::jsonpath as correct_in_utf8

-- sqlfmt-corpus-separator --

select '$ < 1'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@ like_regex "(invalid pattern")'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@ like_regex "pattern" flag "")'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@ like_regex "pattern" flag "a")'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@ like_regex "pattern" flag "i")'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@ like_regex "pattern" flag "iq")'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@ like_regex "pattern" flag "is")'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@ like_regex "pattern" flag "isim")'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@ like_regex "pattern" flag "q")'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@ like_regex "pattern" flag "smixq")'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@ like_regex "pattern" flag "xsms")'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@ like_regex "pattern")'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@ starts with "abc")'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@ starts with $var)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +.1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +.1e+1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +.1e-1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +.1e1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +0.1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +0.1e+1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +0.1e-1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +0.1e1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +10.1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +10.1e+1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +10.1e-1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +10.1e1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +1e+1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +1e-1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < +1e1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -.1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -.1e+1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -.1e-1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -.1e1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -0.1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -0.1e+1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -0.1e-1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -0.1e1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -10.1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -10.1e+1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -10.1e-1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -10.1e1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -1e+1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -1e-1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < -1e1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < .1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < .1e+1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < .1e-1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < .1e1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < 0.1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < 0.1e+1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < 0.1e-1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < 0.1e1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < 1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < 10.1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < 10.1e+1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < 10.1e-1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < 10.1e1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < 1e+1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < 1e-1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (@.a < 1e1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$ ? (last > 0)'::jsonpath

-- sqlfmt-corpus-separator --

select '$'::jsonpath

-- sqlfmt-corpus-separator --

select '$+1'::jsonpath

-- sqlfmt-corpus-separator --

select '$--+1'::jsonpath

-- sqlfmt-corpus-separator --

select '$-1'::jsonpath

-- sqlfmt-corpus-separator --

select '$."\ud83dX"'::jsonpath

-- sqlfmt-corpus-separator --

select '$."\ud83d\ud83d"'::jsonpath

-- sqlfmt-corpus-separator --

select '$."\ud83d\ude04\ud83d\udc36"'::jsonpath as correct_in_utf8

-- sqlfmt-corpus-separator --

select '$."\ude04X"'::jsonpath

-- sqlfmt-corpus-separator --

select '$."\ude04\ud83d"'::jsonpath

-- sqlfmt-corpus-separator --

select '$."dollar \\u0024 character"'::jsonpath as not_an_escape

-- sqlfmt-corpus-separator --

select '$."dollar \u0024 character"'::jsonpath as correct_everywhere

-- sqlfmt-corpus-separator --

select '$."null \\u0000 escape"'::jsonpath as not_an_escape

-- sqlfmt-corpus-separator --

select '$."null \u0000 escape"'::jsonpath as not_unescaped

-- sqlfmt-corpus-separator --

select '$."the Copyright \u00a9 sign"'::jsonpath as correct_in_utf8

-- sqlfmt-corpus-separator --

select '$.*[*]'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a.*'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a.**.b'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a.**{0 to 5}.b'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a.**{2 to 2}.b'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a.**{2 to 5}.b'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a.**{2}.b'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a.**{5 to last}.b'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a.**{last to 5}.b'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a.**{last}.b'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a.v'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a/+-1'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a[$.a.size() - 3]'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a[$a + 1, ($b[*]) to -($[0] * 2)]'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a[*]'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a[*][*]'::jsonpath

-- sqlfmt-corpus-separator --

select '$.a[1,2, 3 to 16]'::jsonpath

-- sqlfmt-corpus-separator --

select '$.bigint().integer().number().decimal()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.boolean()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.btrim'::jsonpath

-- sqlfmt-corpus-separator --

select '$.btrim("xyz")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.btrim()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.date()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.datetime("datetime template")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.datetime()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.decimal(4,2)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.double().floor().ceiling().abs()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.foo\x50\u0067\u{53}\u{051}\u{00004C}\t\"bar'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? ($.a == 1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? ((@.x >= 123 || @.a == 4) && exists (@.x ? (@ == 14)))'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? ((@.x >= 123 || @.a == 4) is unknown)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? (+@.x >= +-(+@.a + 2))'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? (@ == 1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? (@.a == 1 && @.a == 4)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? (@.a == 1 || !(@.a == 4) && @.b == 7)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? (@.a == 1 || !(@.x >= 123 || @.a == 4) && @.b == 7)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? (@.a == 1 || @.a == 4 && @.b == 7)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? (@.a == 1 || @.a == 4)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? (@.a == 1)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? (@.x >= @[*]?(@.a > "abc"))'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? (@.zip == $zip)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? (exists (@.x ? (@ == 14)))'::jsonpath

-- sqlfmt-corpus-separator --

select '$.g ? (exists (@.x))'::jsonpath

-- sqlfmt-corpus-separator --

select '$.initcap'::jsonpath

-- sqlfmt-corpus-separator --

select '$.initcap("hi")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.initcap()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.keyvalue().key'::jsonpath

-- sqlfmt-corpus-separator --

select '$.last'::jsonpath

-- sqlfmt-corpus-separator --

select '$.lower'::jsonpath

-- sqlfmt-corpus-separator --

select '$.lower("hi")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.lower()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.lower().upper().lower().replace("hello","bye")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.ltrim'::jsonpath

-- sqlfmt-corpus-separator --

select '$.ltrim("x", "y")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.ltrim("xyz")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.ltrim()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.ltrim(42)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.replace'::jsonpath

-- sqlfmt-corpus-separator --

select '$.replace("hello")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.replace("hello","bye")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.replace("hello","bye","extra")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.replace()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.rtrim'::jsonpath

-- sqlfmt-corpus-separator --

select '$.rtrim("x", "y")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.rtrim("xyz")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.rtrim()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.rtrim(42)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.split_part'::jsonpath

-- sqlfmt-corpus-separator --

select '$.split_part("~@~")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.split_part("~@~", "hi")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.split_part("~@~", 2)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.split_part("~@~", 2, "extra")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.split_part()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.string()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.time()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.time(6)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.time_tz()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.time_tz(4)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.timestamp()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.timestamp(2)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.timestamp_tz()'::jsonpath

-- sqlfmt-corpus-separator --

select '$.timestamp_tz(0)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.trim("x", "y")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.trim(42)'::jsonpath

-- sqlfmt-corpus-separator --

select '$.upper'::jsonpath

-- sqlfmt-corpus-separator --

select '$.upper("hi")'::jsonpath

-- sqlfmt-corpus-separator --

select '$.upper()'::jsonpath

-- sqlfmt-corpus-separator --

select '$[$[0] ? (last > 0)]'::jsonpath

-- sqlfmt-corpus-separator --

select '$[*]'::jsonpath

-- sqlfmt-corpus-separator --

select '$[*].a'::jsonpath

-- sqlfmt-corpus-separator --

select '$[*][0]'::jsonpath

-- sqlfmt-corpus-separator --

select '$[*][0].a.b'::jsonpath

-- sqlfmt-corpus-separator --

select '$[0]'::jsonpath

-- sqlfmt-corpus-separator --

select '$[last]'::jsonpath

-- sqlfmt-corpus-separator --

select '$a'::jsonpath

-- sqlfmt-corpus-separator --

select '$a.b'::jsonpath

-- sqlfmt-corpus-separator --

select '$a[*]'::jsonpath

-- sqlfmt-corpus-separator --

select ''::jsonpath

-- sqlfmt-corpus-separator --

select ''::nonempty

-- sqlfmt-corpus-separator --

select ''::xid

-- sqlfmt-corpus-separator --

select ''::xid8

-- sqlfmt-corpus-separator --

select '(!,()'::textrange

-- sqlfmt-corpus-separator --

select '(!,[)'::textrange

-- sqlfmt-corpus-separator --

select '(",a)'::textrange

-- sqlfmt-corpus-separator --

select '($ < 1) || $.a.b <= $x'::jsonpath

-- sqlfmt-corpus-separator --

select '($)'::jsonpath

-- sqlfmt-corpus-separator --

select '($).a.b'::jsonpath

-- sqlfmt-corpus-separator --

select '($.a.b + -$.x.y).c.d'::jsonpath

-- sqlfmt-corpus-separator --

select '($.a.b).c.d'::jsonpath

-- sqlfmt-corpus-separator --

select '(($))'::jsonpath

-- sqlfmt-corpus-separator --

select '((($ + 1)).a + ((2)).b ? ((((@ > 1)) || (exists(@.c)))))'::jsonpath

-- sqlfmt-corpus-separator --

select '((,z)'::textrange

-- sqlfmt-corpus-separator --

select '(),a)'::textrange

-- sqlfmt-corpus-separator --

select '(,)'::textrange

-- sqlfmt-corpus-separator --

select '(,,a)'::textrange

-- sqlfmt-corpus-separator --

select '(-+$.a.b).c.d'::jsonpath

-- sqlfmt-corpus-separator --

select '(01,10)'::varbitrange except select '(10,11)'::varbitrange

-- sqlfmt-corpus-separator --

select '(1).type()'::jsonpath

-- sqlfmt-corpus-separator --

select '(1.).e'::jsonpath

-- sqlfmt-corpus-separator --

select '(1.).e3'::jsonpath

-- sqlfmt-corpus-separator --

select '(1.2).e'::jsonpath

-- sqlfmt-corpus-separator --

select '(1.2).e3'::jsonpath

-- sqlfmt-corpus-separator --

select '(Joe)'::fullname

-- sqlfmt-corpus-separator --

select '(Joe,"Blow,Jr")'::fullname

-- sqlfmt-corpus-separator --

select '(Joe,"von""Blow")'::fullname, E'(Joe,d\\\\Blow)'::fullname

-- sqlfmt-corpus-separator --

select '(Joe,)'::fullname

-- sqlfmt-corpus-separator --

select '(Joe,,)'::fullname

-- sqlfmt-corpus-separator --

select '(Joe,Blow) /'::fullname

-- sqlfmt-corpus-separator --

select '(Joe,von Blow)'::fullname, '(Joe,d''Blow)'::fullname

-- sqlfmt-corpus-separator --

select '([,z)'::textrange

-- sqlfmt-corpus-separator --

select '(\\,a)'::textrange

-- sqlfmt-corpus-separator --

select '(],a)'::textrange

-- sqlfmt-corpus-separator --

select '(a,)'::textrange

-- sqlfmt-corpus-separator --

select '(a,))'::textrange

-- sqlfmt-corpus-separator --

select '(a,])'::textrange

-- sqlfmt-corpus-separator --

select '(a,a)'::textrange

-- sqlfmt-corpus-separator --

select '(a,a]'::textrange

-- sqlfmt-corpus-separator --

select '-100'::int2 - '9223372036854775800'::int8

-- sqlfmt-corpus-separator --

select '-100'::int4 - '9223372036854775800'::int8

-- sqlfmt-corpus-separator --

select '-9223372036854775800'::int8 + '-9223372036854775800'::int8

-- sqlfmt-corpus-separator --

select '-9223372036854775800'::int8 - '100'::int2

-- sqlfmt-corpus-separator --

select '-9223372036854775800'::int8 - '100'::int4

-- sqlfmt-corpus-separator --

select '-9223372036854775800'::int8 - '9223372036854775800'::int8

-- sqlfmt-corpus-separator --

select '-9223372036854775808'::int8

-- sqlfmt-corpus-separator --

select '-9223372036854775808'::int8 / '0'::int2

-- sqlfmt-corpus-separator --

select '-9223372036854775809'::int8

-- sqlfmt-corpus-separator --

select '-[a,z)'::textrange

-- sqlfmt-corpus-separator --

select '-infinity'::date < 'today'::date as t

-- sqlfmt-corpus-separator --

select '.000_005'::jsonpath

-- sqlfmt-corpus-separator --

select '.001'::jsonpath

-- sqlfmt-corpus-separator --

select '.001e1'::jsonpath

-- sqlfmt-corpus-separator --

select '0'::jsonpath

-- sqlfmt-corpus-separator --

select '0.0'::jsonpath

-- sqlfmt-corpus-separator --

select '0.000'::jsonpath

-- sqlfmt-corpus-separator --

select '0.000e1'::jsonpath

-- sqlfmt-corpus-separator --

select '0.000e2'::jsonpath

-- sqlfmt-corpus-separator --

select '0.000e3'::jsonpath

-- sqlfmt-corpus-separator --

select '0.0010'::jsonpath

-- sqlfmt-corpus-separator --

select '0.0010e+1'::jsonpath

-- sqlfmt-corpus-separator --

select '0.0010e+2'::jsonpath

-- sqlfmt-corpus-separator --

select '0.0010e-1'::jsonpath

-- sqlfmt-corpus-separator --

select '00'::jsonpath

-- sqlfmt-corpus-separator --

select '010'::xid,
       '42'::xid,
       '0xffffffff'::xid,
       '-1'::xid,
	   '010'::xid8,
	   '42'::xid8,
	   '0xffffffffffffffff'::xid8,
	   '-1'::xid8

-- sqlfmt-corpus-separator --

select '0755'::jsonpath

-- sqlfmt-corpus-separator --

select '0:1:'::pg_snapshot

-- sqlfmt-corpus-separator --

select '0:1:'::txid_snapshot

-- sqlfmt-corpus-separator --

select '0b'::jsonpath

-- sqlfmt-corpus-separator --

select '0b0x'::jsonpath

-- sqlfmt-corpus-separator --

select '0b100101'::jsonpath

-- sqlfmt-corpus-separator --

select '0b10_0101'::jsonpath

-- sqlfmt-corpus-separator --

select '0b_10_0101'::jsonpath

-- sqlfmt-corpus-separator --

select '0o'::jsonpath

-- sqlfmt-corpus-separator --

select '0o0x'::jsonpath

-- sqlfmt-corpus-separator --

select '0o273'::jsonpath

-- sqlfmt-corpus-separator --

select '0o2_73'::jsonpath

-- sqlfmt-corpus-separator --

select '0o_273'::jsonpath

-- sqlfmt-corpus-separator --

select '0x'::jsonpath

-- sqlfmt-corpus-separator --

select '0x0y'::jsonpath

-- sqlfmt-corpus-separator --

select '0x1EEE_FFFF'::jsonpath

-- sqlfmt-corpus-separator --

select '0x42F'::jsonpath

-- sqlfmt-corpus-separator --

select '0x_42F'::jsonpath

-- sqlfmt-corpus-separator --

select '1 * 2 + 4 % -3 != false'::jsonpath

-- sqlfmt-corpus-separator --

select '1 + ($.a.b + 2).c.d'::jsonpath

-- sqlfmt-corpus-separator --

select '1 + ($.a.b > 2).c.d'::jsonpath

-- sqlfmt-corpus-separator --

select '1'::text in (select '1'::name union all select '1'::name)

-- sqlfmt-corpus-separator --

select '1'::xid != '1'::xid

-- sqlfmt-corpus-separator --

select '1'::xid != '1'::xid8::xid

-- sqlfmt-corpus-separator --

select '1'::xid < '2'::xid

-- sqlfmt-corpus-separator --

select '1'::xid <= '2'::xid

-- sqlfmt-corpus-separator --

select '1'::xid = '1'::xid

-- sqlfmt-corpus-separator --

select '1'::xid = '1'::xid8::xid

-- sqlfmt-corpus-separator --

select '1'::xid > '2'::xid

-- sqlfmt-corpus-separator --

select '1'::xid >= '2'::xid

-- sqlfmt-corpus-separator --

select '1'::xid8 != '1'::xid8

-- sqlfmt-corpus-separator --

select '1'::xid8 < '2'::xid8, '2'::xid8 < '2'::xid8, '2'::xid8 < '1'::xid8

-- sqlfmt-corpus-separator --

select '1'::xid8 <= '2'::xid8, '2'::xid8 <= '2'::xid8, '2'::xid8 <= '1'::xid8

-- sqlfmt-corpus-separator --

select '1'::xid8 = '1'::xid8

-- sqlfmt-corpus-separator --

select '1'::xid8 > '2'::xid8, '2'::xid8 > '2'::xid8, '2'::xid8 > '1'::xid8

-- sqlfmt-corpus-separator --

select '1'::xid8 >= '2'::xid8, '2'::xid8 >= '2'::xid8, '2'::xid8 >= '1'::xid8

-- sqlfmt-corpus-separator --

select '1.'::jsonpath

-- sqlfmt-corpus-separator --

select '1..e'::jsonpath

-- sqlfmt-corpus-separator --

select '1..e3'::jsonpath

-- sqlfmt-corpus-separator --

select '1.0'::jsonb::float

-- sqlfmt-corpus-separator --

select '1.0'::jsonb::float4

-- sqlfmt-corpus-separator --

select '1.2.e'::jsonpath

-- sqlfmt-corpus-separator --

select '1.2.e3'::jsonpath

-- sqlfmt-corpus-separator --

select '1.2.type()'::jsonpath

-- sqlfmt-corpus-separator --

select '1.2a'::jsonpath

-- sqlfmt-corpus-separator --

select '1.2e'::jsonpath

-- sqlfmt-corpus-separator --

select '1.2e3'::jsonpath

-- sqlfmt-corpus-separator --

select '1.2e3a'::jsonpath

-- sqlfmt-corpus-separator --

select '1.e'::jsonpath

-- sqlfmt-corpus-separator --

select '1.e1'::jsonpath

-- sqlfmt-corpus-separator --

select '1.e3'::jsonpath

-- sqlfmt-corpus-separator --

select '1.e3.e'::jsonpath

-- sqlfmt-corpus-separator --

select '1.e3.e4'::jsonpath

-- sqlfmt-corpus-separator --

select '1.type()'::jsonpath

-- sqlfmt-corpus-separator --

select '100'::int2 * '9223372036854775800'::int8

-- sqlfmt-corpus-separator --

select '100'::int2 + '9223372036854775800'::int8

-- sqlfmt-corpus-separator --

select '100'::int2 / '0'::int8

-- sqlfmt-corpus-separator --

select '100'::int4 * '9223372036854775800'::int8

-- sqlfmt-corpus-separator --

select '100'::int4 + '9223372036854775800'::int8

-- sqlfmt-corpus-separator --

select '100000000y 10mon -1000000000d -100000h -10min -10.000001s ago'::interval

-- sqlfmt-corpus-separator --

select '100_'::jsonpath

-- sqlfmt-corpus-separator --

select '100__000'::jsonpath

-- sqlfmt-corpus-separator --

select '12345'::jsonb::int2

-- sqlfmt-corpus-separator --

select '12345'::jsonb::int4

-- sqlfmt-corpus-separator --

select '12345'::jsonb::int8

-- sqlfmt-corpus-separator --

select '12345'::jsonb::numeric

-- sqlfmt-corpus-separator --

select '12345.0000000000000000000000000000000000000000000005'::jsonb::float4

-- sqlfmt-corpus-separator --

select '12345.0000000000000000000000000000000000000000000005'::jsonb::float8

-- sqlfmt-corpus-separator --

select '12345.0000000000000000000000000000000000000000000005'::jsonb::int2

-- sqlfmt-corpus-separator --

select '12345.0000000000000000000000000000000000000000000005'::jsonb::int4

-- sqlfmt-corpus-separator --

select '12345.0000000000000000000000000000000000000000000005'::jsonb::int8

-- sqlfmt-corpus-separator --

select '12345.0000000000000000000000000000000000000000000005'::jsonb::numeric

-- sqlfmt-corpus-separator --

select '12345.05'::jsonb::float4

-- sqlfmt-corpus-separator --

select '12345.05'::jsonb::float8

-- sqlfmt-corpus-separator --

select '12345.05'::jsonb::int2

-- sqlfmt-corpus-separator --

select '12345.05'::jsonb::int4

-- sqlfmt-corpus-separator --

select '12345.05'::jsonb::int8

-- sqlfmt-corpus-separator --

select '12345.05'::jsonb::numeric

-- sqlfmt-corpus-separator --

select '12:13:'::pg_snapshot

-- sqlfmt-corpus-separator --

select '12:13:'::txid_snapshot

-- sqlfmt-corpus-separator --

select '12:13:0'::pg_snapshot

-- sqlfmt-corpus-separator --

select '12:13:0'::txid_snapshot

-- sqlfmt-corpus-separator --

select '12:16:14,13'::pg_snapshot

-- sqlfmt-corpus-separator --

select '12:16:14,13'::txid_snapshot

-- sqlfmt-corpus-separator --

select '12:16:14,14'::pg_snapshot

-- sqlfmt-corpus-separator --

select '12:16:14,14'::txid_snapshot

-- sqlfmt-corpus-separator --

select '12:18:14,16'::pg_snapshot

-- sqlfmt-corpus-separator --

select '12:18:14,16'::txid_snapshot

-- sqlfmt-corpus-separator --

select '1?(2>3)'::jsonpath

-- sqlfmt-corpus-separator --

select '1_000.'::jsonpath

-- sqlfmt-corpus-separator --

select '1_000.000_005'::jsonpath

-- sqlfmt-corpus-separator --

select '1_000.5_'::jsonpath

-- sqlfmt-corpus-separator --

select '1_000.5e0_1'::jsonpath

-- sqlfmt-corpus-separator --

select '1_000.5e_1'::jsonpath

-- sqlfmt-corpus-separator --

select '1_000._5'::jsonpath

-- sqlfmt-corpus-separator --

select '1_000_.5'::jsonpath

-- sqlfmt-corpus-separator --

select '1_000_000'::jsonpath

-- sqlfmt-corpus-separator --

select '1_2_3'::jsonpath

-- sqlfmt-corpus-separator --

select '1a'::jsonpath

-- sqlfmt-corpus-separator --

select '1b'::jsonpath

-- sqlfmt-corpus-separator --

select '1e'::jsonpath

-- sqlfmt-corpus-separator --

select '1e3'::jsonpath

-- sqlfmt-corpus-separator --

select '1o'::jsonpath

-- sqlfmt-corpus-separator --

select '1x'::jsonpath

-- sqlfmt-corpus-separator --

select '3'::jsonb || '4'::jsonb

-- sqlfmt-corpus-separator --

select '3'::jsonb || '[]'::jsonb

-- sqlfmt-corpus-separator --

select '3'::jsonb || '{}'::jsonb

-- sqlfmt-corpus-separator --

select '30 days'::interval = '1 month'::interval as t

-- sqlfmt-corpus-separator --

select '31:12:'::pg_snapshot

-- sqlfmt-corpus-separator --

select '31:12:'::txid_snapshot

-- sqlfmt-corpus-separator --

select '4 millenniums 5 centuries 4 decades 1 year 4 months 4 days 17 minutes 31 seconds'::interval

-- sqlfmt-corpus-separator --

select '42'::json #> '{}'

-- sqlfmt-corpus-separator --

select '42'::json #>> '{}'

-- sqlfmt-corpus-separator --

select '42'::jsonb #> '{}'

-- sqlfmt-corpus-separator --

select '42'::jsonb #>> '{}'

-- sqlfmt-corpus-separator --

select '9223372036854775800'::int8 % '0'::int8

-- sqlfmt-corpus-separator --

select '9223372036854775800'::int8 * '100'::int2

-- sqlfmt-corpus-separator --

select '9223372036854775800'::int8 * '100'::int4

-- sqlfmt-corpus-separator --

select '9223372036854775800'::int8 * '9223372036854775800'::int8

-- sqlfmt-corpus-separator --

select '9223372036854775800'::int8 + '100'::int2

-- sqlfmt-corpus-separator --

select '9223372036854775800'::int8 + '100'::int4

-- sqlfmt-corpus-separator --

select '9223372036854775800'::int8 + '9223372036854775800'::int8

-- sqlfmt-corpus-separator --

select '9223372036854775800'::int8 - '-9223372036854775800'::int8

-- sqlfmt-corpus-separator --

select '9223372036854775800'::int8 / '0'::int8

-- sqlfmt-corpus-separator --

select '9223372036854775807'::int8

-- sqlfmt-corpus-separator --

select '9223372036854775808'::int8

-- sqlfmt-corpus-separator --

select '@ + 1'::jsonpath

-- sqlfmt-corpus-separator --

select 'NaN'::numeric ^ 'NaN'::numeric

-- sqlfmt-corpus-separator --

select 'NaN'::numeric ^ 0

-- sqlfmt-corpus-separator --

select 'NaN'::numeric ^ 1

-- sqlfmt-corpus-separator --

select '[ , ]'::textrange

-- sqlfmt-corpus-separator --

select '["",""]'::textrange

-- sqlfmt-corpus-separator --

select '[",",","]'::textrange

-- sqlfmt-corpus-separator --

select '["\\","\\"]'::textrange

-- sqlfmt-corpus-separator --

select '["a", "b"]'::jsonb || '"c"'

-- sqlfmt-corpus-separator --

select '["a", "b"]'::jsonb || '["c", "d"]'

-- sqlfmt-corpus-separator --

select '["a", "b"]'::jsonb || '["c"]'

-- sqlfmt-corpus-separator --

select '["a", "b"]'::jsonb || '{"c":1}'

-- sqlfmt-corpus-separator --

select '["a","b","c"]'::jsonb - -1

-- sqlfmt-corpus-separator --

select '["a","b","c"]'::jsonb - -2

-- sqlfmt-corpus-separator --

select '["a","b","c"]'::jsonb - -3

-- sqlfmt-corpus-separator --

select '["a","b","c"]'::jsonb - -4

-- sqlfmt-corpus-separator --

select '["a","b","c"]'::jsonb - 0

-- sqlfmt-corpus-separator --

select '["a","b","c"]'::jsonb - 1

-- sqlfmt-corpus-separator --

select '["a","b","c"]'::jsonb - 2

-- sqlfmt-corpus-separator --

select '["a","b","c"]'::jsonb - 3

-- sqlfmt-corpus-separator --

select '["c"]' || '["a", "b"]'::jsonb

-- sqlfmt-corpus-separator --

select '[,z]'::textrange

-- sqlfmt-corpus-separator --

select '[-2147483648:-2147483647]={1,2}'::int[]

-- sqlfmt-corpus-separator --

select '[-2147483649:-2147483648]={1,2}'::int[]

-- sqlfmt-corpus-separator --

select '[0:1]={1.1,2.2}'::float8[]

-- sqlfmt-corpus-separator --

select '[0:2][0:2]={{1,2,3},{4,5,6},{7,8,9}}'::int[]

-- sqlfmt-corpus-separator --

select '[1,2,3]'::json #> '{}'

-- sqlfmt-corpus-separator --

select '[1,2,3]'::json #>> '{}'

-- sqlfmt-corpus-separator --

select '[1,2,3]'::jsonb #> '{}'

-- sqlfmt-corpus-separator --

select '[1,2,3]'::jsonb #>> '{}'

-- sqlfmt-corpus-separator --

select '[1.0]'::jsonb::float

-- sqlfmt-corpus-separator --

select '[1.0]'::jsonb::float4

-- sqlfmt-corpus-separator --

select '[123.001, 5.e9)'::float8range @> 888.882::float8

-- sqlfmt-corpus-separator --

select '[1:-1]={}'::int[]

-- sqlfmt-corpus-separator --

select '[1:0]={}'::int[]

-- sqlfmt-corpus-separator --

select '[1:]={1}'::int[]

-- sqlfmt-corpus-separator --

select '[2010-01-01 01:00:00 -05, 2010-01-01 02:00:00 -08)'::tstzrange

-- sqlfmt-corpus-separator --

select '[2010-01-01 01:00:00 -08, 2010-01-01 02:00:00 -05)'::tstzrange

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

select '[3]'::jsonb || '{}'::jsonb

-- sqlfmt-corpus-separator --

select '[4,5)'::restrictedrange @> 7

-- sqlfmt-corpus-separator --

select '[4,50)'::mydomainrange @> 7::mydomain

-- sqlfmt-corpus-separator --

select '[4,50)'::restrictedrange @> 7

-- sqlfmt-corpus-separator --

select '[:1]={1}'::int[]

-- sqlfmt-corpus-separator --

select '[]'::fullname

-- sqlfmt-corpus-separator --

select '[]'::jsonb #- '{a}'

-- sqlfmt-corpus-separator --

select '[]'::jsonb - 'a'

-- sqlfmt-corpus-separator --

select '[]'::jsonb - 1

-- sqlfmt-corpus-separator --

select '[]'::jsonb -> -2147483648

-- sqlfmt-corpus-separator --

select '[]'::jsonb ->> -2147483648

-- sqlfmt-corpus-separator --

select '[]'::jsonb || '"a"'::jsonb

-- sqlfmt-corpus-separator --

select '[]'::jsonb || '["a"]'::jsonb

-- sqlfmt-corpus-separator --

select '[]'::jsonb || '{"a":"b"}'::jsonb

-- sqlfmt-corpus-separator --

select '[]'::jsonb::bool

-- sqlfmt-corpus-separator --

select '[a,]'::textrange

-- sqlfmt-corpus-separator --

select '[a,a)'::textrange

-- sqlfmt-corpus-separator --

select '[a,a]'::textrange

-- sqlfmt-corpus-separator --

select '[a,z) - '::textrange

-- sqlfmt-corpus-separator --

select '[z,a]'::textrange

-- sqlfmt-corpus-separator --

select '[{"b": "c"}, {"b": "cc"}]'::json -> 'z'

-- sqlfmt-corpus-separator --

select '[{"b": "c"}, {"b": "cc"}]'::json -> 1

-- sqlfmt-corpus-separator --

select '[{"b": "c"}, {"b": "cc"}]'::json -> 3

-- sqlfmt-corpus-separator --

select '[{"b": "c"}, {"b": "cc"}]'::json ->> 'z'

-- sqlfmt-corpus-separator --

select '[{"b": "c"}, {"b": "cc"}]'::json ->> 1

-- sqlfmt-corpus-separator --

select '[{"b": "c"}, {"b": "cc"}]'::json ->> 3

-- sqlfmt-corpus-separator --

select '[{"b": "c"}, {"b": "cc"}]'::jsonb -> 'z'

-- sqlfmt-corpus-separator --

select '[{"b": "c"}, {"b": "cc"}]'::jsonb -> 1

-- sqlfmt-corpus-separator --

select '[{"b": "c"}, {"b": "cc"}]'::jsonb -> 3

-- sqlfmt-corpus-separator --

select '[{"b": "c"}, {"b": "cc"}]'::jsonb ->> 'z'

-- sqlfmt-corpus-separator --

select '[{"b": "c"}, {"b": "cc"}]'::jsonb ->> 1

-- sqlfmt-corpus-separator --

select '[{"b": "c"}, {"b": "cc"}]'::jsonb ->> 3

-- sqlfmt-corpus-separator --

select '_100'::jsonpath

-- sqlfmt-corpus-separator --

select '_1_000.5'::jsonpath

-- sqlfmt-corpus-separator --

select 'asdf'::xid

-- sqlfmt-corpus-separator --

select 'asdf'::xid8

-- sqlfmt-corpus-separator --

select 'empty'::int4range::int4multirange

-- sqlfmt-corpus-separator --

select 'empty'::numrange << nummultirange()

-- sqlfmt-corpus-separator --

select 'empty'::numrange >> nummultirange()

-- sqlfmt-corpus-separator --

select 'empty'::textrange::textmultirange

-- sqlfmt-corpus-separator --

select 'foo'::text in (select 'bar'::name union all select 'bar'::name)

-- sqlfmt-corpus-separator --

select 'four: '::text || 2+2

-- sqlfmt-corpus-separator --

select 'infinity'::date = '+infinity'::date as t

-- sqlfmt-corpus-separator --

select 'infinity'::date > 'today'::date as t

-- sqlfmt-corpus-separator --

select 'infinity'::date, '-infinity'::date

-- sqlfmt-corpus-separator --

select 'last'::jsonpath

-- sqlfmt-corpus-separator --

select 'lax $'::jsonpath

-- sqlfmt-corpus-separator --

select 'null'::json #> '{}'

-- sqlfmt-corpus-separator --

select 'null'::json #>> '{}'

-- sqlfmt-corpus-separator --

select 'null'::jsonb #> '{}'

-- sqlfmt-corpus-separator --

select 'null'::jsonb #>> '{}'

-- sqlfmt-corpus-separator --

select 'null'::jsonb::bool

-- sqlfmt-corpus-separator --

select 'null'::jsonb::float

-- sqlfmt-corpus-separator --

select 'null'::jsonb::float4

-- sqlfmt-corpus-separator --

select 'null'::jsonb::int2

-- sqlfmt-corpus-separator --

select 'null'::jsonb::int4

-- sqlfmt-corpus-separator --

select 'null'::jsonb::int8

-- sqlfmt-corpus-separator --

select 'null'::jsonb::numeric

-- sqlfmt-corpus-separator --

select 'null.type()'::jsonpath

-- sqlfmt-corpus-separator --

select 'strict $'::jsonpath

-- sqlfmt-corpus-separator --

select 'true'::jsonb::bool

-- sqlfmt-corpus-separator --

select 'true.type()'::jsonpath

-- sqlfmt-corpus-separator --

select 'x123'::dtop

-- sqlfmt-corpus-separator --

select 'x1234'::dtop

-- sqlfmt-corpus-separator --

select 'xz23'::dtop

-- sqlfmt-corpus-separator --

select 'y123'::dtop

-- sqlfmt-corpus-separator --

select 'y1234'::dtop

-- sqlfmt-corpus-separator --

select 'yz23'::dtop

-- sqlfmt-corpus-separator --

select '{
           0 second,
           @ 1 hour @ 42 minutes @ 20 seconds
         }'::interval[]

-- sqlfmt-corpus-separator --

select '{ ab\c , "ab\"c" }'::text[]

-- sqlfmt-corpus-separator --

select '{ { "," } , { 3 } }'::text[]

-- sqlfmt-corpus-separator --

select '{ }}'::text[]

-- sqlfmt-corpus-separator --

select '{"a""b"}'::text[]

-- sqlfmt-corpus-separator --

select '{"a": "c", "b": null}'::json -> 'b'

-- sqlfmt-corpus-separator --

select '{"a": "c", "b": null}'::json ->> 'b'

-- sqlfmt-corpus-separator --

select '{"a": "c", "b": null}'::jsonb -> 'b'

-- sqlfmt-corpus-separator --

select '{"a": "c", "b": null}'::jsonb ->> 'b'

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json -> ''

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json -> 'z'

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json -> -1

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json -> 1

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json -> null::int

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json -> null::text

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json ->> ''

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json ->> 'z'

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json ->> 1

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json ->> null::int

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::json ->> null::text

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> ''

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> 'z'

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> 1

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> null::int

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb -> null::text

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> ''

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> 'z'

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> 1

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> null::int

-- sqlfmt-corpus-separator --

select '{"a": [{"b": "c"}, {"b": "cc"}]}'::jsonb ->> null::text

-- sqlfmt-corpus-separator --

select '{"a": {"b":{"c": "foo"}}}'::json #> '{}'

-- sqlfmt-corpus-separator --

select '{"a": {"b":{"c": "foo"}}}'::json #>> '{}'

-- sqlfmt-corpus-separator --

select '{"a": {"b":{"c": "foo"}}}'::jsonb #> '{}'

-- sqlfmt-corpus-separator --

select '{"a": {"b":{"c": "foo"}}}'::jsonb #>> '{}'

-- sqlfmt-corpus-separator --

select '{"a":"b"}'::jsonb || '[]'::jsonb

-- sqlfmt-corpus-separator --

select '{"a":1 , "b":2, "c":3}'::jsonb - 'a'

-- sqlfmt-corpus-separator --

select '{"a":1 , "b":2, "c":3}'::jsonb - 'b'

-- sqlfmt-corpus-separator --

select '{"a":1 , "b":2, "c":3}'::jsonb - 'c'

-- sqlfmt-corpus-separator --

select '{"a":1 , "b":2, "c":3}'::jsonb - 'd'

-- sqlfmt-corpus-separator --

select '{"a":1 , "b":2, "c":3}'::jsonb - '{b}'::text[]

-- sqlfmt-corpus-separator --

select '{"a":1 , "b":2, "c":3}'::jsonb - '{c,b}'::text[]

-- sqlfmt-corpus-separator --

select '{"a":1 , "b":2, "c":3}'::jsonb - '{}'::text[]

-- sqlfmt-corpus-separator --

select '{"a":1}' || '"a"'::jsonb

-- sqlfmt-corpus-separator --

select '{"a":null , "b":2, "c":3}'::jsonb - 'a'

-- sqlfmt-corpus-separator --

select '{"a"b}'::text[]

-- sqlfmt-corpus-separator --

select '{"aa":1 , "b":2, "cq":3}'::jsonb || '{"aa":"l"}'

-- sqlfmt-corpus-separator --

select '{"aa":1 , "b":2, "cq":3}'::jsonb || '{"aq":"l"}'

-- sqlfmt-corpus-separator --

select '{"aa":1 , "b":2, "cq":3}'::jsonb || '{"cq":"l", "b":"g", "fg":false}'

-- sqlfmt-corpus-separator --

select '{"aa":1 , "b":2, "cq":3}'::jsonb || '{}'

-- sqlfmt-corpus-separator --

select '{"c": 1}'::jsonb || '["a", "b"]'

-- sqlfmt-corpus-separator --

select '{"foo"{}}'::text[]

-- sqlfmt-corpus-separator --

select '{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb #- '{b,-1e}'

-- sqlfmt-corpus-separator --

select '{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb #- '{b,-1}'

-- sqlfmt-corpus-separator --

select '{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb #- '{d,1,0}'

-- sqlfmt-corpus-separator --

select '{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb #- '{n}'

-- sqlfmt-corpus-separator --

select '{(!,()}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(!,[)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(",a)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{((,z)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(),a)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(,)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(,)}.'::textmultirange

-- sqlfmt-corpus-separator --

select '{(,,a)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(,z)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(01,10)}'::varbitmultirange except select '{(10,11)}'::varbitmultirange

-- sqlfmt-corpus-separator --

select '{(10,20),(30,40),(50,60)}'::nummultirange && '(42,92)'::numrange

-- sqlfmt-corpus-separator --

select '{(10,20),(30,40),(50,60)}'::nummultirange @> '(52,56)'::numrange

-- sqlfmt-corpus-separator --

select '{([,z)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(\\,a)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(],a)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(a,))}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(a,)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(a,])}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(a,a)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{(a,a]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{,[a,c)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{,}'::textmultirange

-- sqlfmt-corpus-separator --

select '{-[a,z)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{0 second  ,0 second}'::interval[]

-- sqlfmt-corpus-separator --

select '{1,2,3}'::dia

-- sqlfmt-corpus-separator --

select '{1,2}'::orderedarray

-- sqlfmt-corpus-separator --

select '{1,}'::text[]

-- sqlfmt-corpus-separator --

select '{2,1}'::orderedarray

-- sqlfmt-corpus-separator --

select '{[ , ]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{["""","\""]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{["",""]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[",",","]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{["\\","\\"]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[,z]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[1,2], [3,4]}'::int4multirange

-- sqlfmt-corpus-separator --

select '{[123.001, 5.e9)}'::float8multirange @> 888.882::float8

-- sqlfmt-corpus-separator --

select '{[4,5)}'::restrictedmultirange @> 7

-- sqlfmt-corpus-separator --

select '{[4,50)}'::mydomainmultirange @> 7::mydomain

-- sqlfmt-corpus-separator --

select '{[4,50)}'::restrictedmultirange @> 7

-- sqlfmt-corpus-separator --

select '{[a,]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[a,a)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[a,a], [b,b], [c,c]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[a,a], [b,b]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[a,a],[a,b]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[a,a],[b,b]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[a,a]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[a,b), [b,e]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[a,c),}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[a,d), [b,f]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[a,d), [d,e)}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[a,d], [b,e]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{[a,z) - }'::textmultirange

-- sqlfmt-corpus-separator --

select '{[z,a]}'::textmultirange

-- sqlfmt-corpus-separator --

select '{a"b"}'::text[]

-- sqlfmt-corpus-separator --

select '{foo,,bar}'::text[]

-- sqlfmt-corpus-separator --

select '{foo{}}'::text[]

-- sqlfmt-corpus-separator --

select '{nan, 1, nan}'::line = '{nan, 1, nan}'::line as true,
	   '{nan, 1, nan}'::line = '{nan, 2, nan}'::line as false

-- sqlfmt-corpus-separator --

select '{null,n\ull,"null"}'::text[]

-- sqlfmt-corpus-separator --

select '{{"1 2" x},{3}}'::text[]

-- sqlfmt-corpus-separator --

select '{{"1 2"} x,{3}}'::text[]

-- sqlfmt-corpus-separator --

select '{{1,2,3},{4,5,6},{7,8,9}}'::int[]

-- sqlfmt-corpus-separator --

select '{{1,{2}},{2,3}}'::text[]

-- sqlfmt-corpus-separator --

select '{{1,},{1},}'::text[]

-- sqlfmt-corpus-separator --

select '{{1,},{1}}'::text[]

-- sqlfmt-corpus-separator --

select '{{1,}}'::text[]

-- sqlfmt-corpus-separator --

select '{{1},{{2}}}'::text[]

-- sqlfmt-corpus-separator --

select '{{1},{}}'::text[]

-- sqlfmt-corpus-separator --

select '{{{1,2,3,4},{2,3,4,5}},{{3,4,5,6},{4,5,6,7}}}'::text[]

-- sqlfmt-corpus-separator --

select '{{{1}},{2}}'::text[]

-- sqlfmt-corpus-separator --

select '{{{}},{}}'::text[]

-- sqlfmt-corpus-separator --

select '{{},{1}}'::text[]

-- sqlfmt-corpus-separator --

select '{{},{{}}}'::text[]

-- sqlfmt-corpus-separator --

select '{{},{}}'::text[]

-- sqlfmt-corpus-separator --

select '{}'::jsonb #- '{a}'

-- sqlfmt-corpus-separator --

select '{}'::jsonb -  1

-- sqlfmt-corpus-separator --

select '{}'::jsonb - 'a'

-- sqlfmt-corpus-separator --

select '{}'::jsonb || '{"a":"b"}'::jsonb

-- sqlfmt-corpus-separator --

select '{}'::jsonb || '{"cq":"l", "b":"g", "fg":false}'

-- sqlfmt-corpus-separator --

select '{}'::jsonb::numeric

-- sqlfmt-corpus-separator --

select '{}'::text[]

-- sqlfmt-corpus-separator --

select '{}'::textmultirange

-- sqlfmt-corpus-separator --

select '{}}'::text[]

-- sqlfmt-corpus-separator --

select '}{'::text[]

-- sqlfmt-corpus-separator --

select ('123.45'::jsonb)::numeric

-- sqlfmt-corpus-separator --

select ('[{"name": "alice"}, {"name": "bob"}]'::jsonb)::name

-- sqlfmt-corpus-separator --

select ('true'::jsonb)::bool

-- sqlfmt-corpus-separator --

select ('{"text": "hello"}'::jsonb)::text

-- sqlfmt-corpus-separator --

select (select (a.*)::text) from view_a a

-- sqlfmt-corpus-separator --

select (select max(0) filter (where b1)) from bool_test

-- sqlfmt-corpus-separator --

select (select max(unique1) filter (where bool_or(ten > 0)) from int8_tbl) from tenk1

-- sqlfmt-corpus-separator --

select (select max(unique1) filter (where sum(ten) > 0) from int8_tbl) from tenk1

-- sqlfmt-corpus-separator --

select (stringu1 || repeat('abcd', 5000))::int2 from tenk1 where unique1 = 1

-- sqlfmt-corpus-separator --

select * from base_tab_def order by a, c NULLS LAST

-- sqlfmt-corpus-separator --

select * from base_tab_def order by a, e nulls first

-- sqlfmt-corpus-separator --

select * from btree_bpchar where f1 like 'foo%'

-- sqlfmt-corpus-separator --

select * from btree_bpchar where f1 like 'foo'

-- sqlfmt-corpus-separator --

select * from btree_bpchar where f1::bpchar like 'foo%'

-- sqlfmt-corpus-separator --

select * from btree_bpchar where f1::bpchar like 'foo'

-- sqlfmt-corpus-separator --

select * from collate_test1 where b ilike 'ABC'

-- sqlfmt-corpus-separator --

select * from collate_test1 where b ilike 'abc'

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

select * from int8_tbl intersect select q2, q1 from int8_tbl order by 1, 2

-- sqlfmt-corpus-separator --

select * from int8_tbl where q1 in (select c1 from inner_text)

-- sqlfmt-corpus-separator --

select * from nestjsonb where j @> '{"a":[[{"x":2}]]}'::jsonb

-- sqlfmt-corpus-separator --

select * from notinouter where a not in (select b from notininner)

-- sqlfmt-corpus-separator --

select * from numeric_table
  where num_col in (select float_col from float_table)

-- sqlfmt-corpus-separator --

select * from numrange_test2 where nr = 'empty'::numrange

-- sqlfmt-corpus-separator --

select * from only t1

-- sqlfmt-corpus-separator --

select * from only t1_1

-- sqlfmt-corpus-separator --

select * from only t1_2

-- sqlfmt-corpus-separator --

select * from p t1 where exists
  (select 1 from p t2 where t1.a = t2.a and t1.a = 1)

-- sqlfmt-corpus-separator --

select * from pendtest where 'ipi:*'::tsquery @@ ts

-- sqlfmt-corpus-separator --

select * from pendtest where 'ips:*'::tsquery @@ ts

-- sqlfmt-corpus-separator --

select * from pendtest where 'ipsa:*'::tsquery @@ ts

-- sqlfmt-corpus-separator --

select * from pendtest where 'ipsu:*'::tsquery @@ ts

-- sqlfmt-corpus-separator --

select * from pendtest where 'ipt:*'::tsquery @@ ts

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

select -('-9223372036854775807'::int8)

-- sqlfmt-corpus-separator --

select -('-9223372036854775808'::int8)

-- sqlfmt-corpus-separator --

select 0 ^ 'NaN'::numeric

-- sqlfmt-corpus-separator --

select 0::int8 - '-9223372036854775808'::int8

-- sqlfmt-corpus-separator --

select 1 = all (select (select 1))

-- sqlfmt-corpus-separator --

select 1 ^ 'NaN'::numeric

-- sqlfmt-corpus-separator --

select 1 from gtest32 t1 where exists
  (select 1 from gtest32 t2 where t1.a > t2.a and t2.b = 2)

-- sqlfmt-corpus-separator --

select 1, 2, 3 into t

-- sqlfmt-corpus-separator --

select 1/(15-unique2) from tenk1 order by unique2 limit 19

-- sqlfmt-corpus-separator --

select 1/0::float4

-- sqlfmt-corpus-separator --

select 1/0::float8

-- sqlfmt-corpus-separator --

select 1/0::int2

-- sqlfmt-corpus-separator --

select 1/0::int8

-- sqlfmt-corpus-separator --

select 1/0::numeric

-- sqlfmt-corpus-separator --

select 1::float4/0

-- sqlfmt-corpus-separator --

select 1::float8/0

-- sqlfmt-corpus-separator --

select 1::inotnull

-- sqlfmt-corpus-separator --

select 1::int2/0

-- sqlfmt-corpus-separator --

select 1::int8/0

-- sqlfmt-corpus-separator --

select 1::numeric/0

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

select 999999999999999999999::numeric/1000000000000000000000

-- sqlfmt-corpus-separator --

select B'001' & B'10'

-- sqlfmt-corpus-separator --

select B'0010' # B'011101'

-- sqlfmt-corpus-separator --

select B'0111' | B'011'

-- sqlfmt-corpus-separator --

select E'{{1,2},\\{2,3}}'::text[]

-- sqlfmt-corpus-separator --

select NULL::derived::base

-- sqlfmt-corpus-separator --

select _textrange1(textrange2('a','z')) @> 'b'::text

-- sqlfmt-corpus-separator --

select a.thousand from tenk1 a, tenk1 b
where a.thousand = b.thousand
  and exists ( select 1 from tenk1 c where b.hundred = c.hundred
                   and not exists ( select 1 from tenk1 d
                                    where a.thousand = d.thousand ) )

-- sqlfmt-corpus-separator --

select abs('-9223372036854775808'::int8)

-- sqlfmt-corpus-separator --

select age(timestamp '-infinity')

-- sqlfmt-corpus-separator --

select age(timestamp '-infinity', timestamp '-infinity')

-- sqlfmt-corpus-separator --

select age(timestamp '-infinity', timestamp 'infinity')

-- sqlfmt-corpus-separator --

select age(timestamp 'infinity')

-- sqlfmt-corpus-separator --

select age(timestamp 'infinity', timestamp '-infinity')

-- sqlfmt-corpus-separator --

select age(timestamp 'infinity', timestamp 'infinity')

-- sqlfmt-corpus-separator --

select anyrange_in('[10,20)','int4range'::regtype,-1)

-- sqlfmt-corpus-separator --

select array_dims('{1,2,3}'::dia)

-- sqlfmt-corpus-separator --

select array_in('{1,2,3}','int4'::regtype,-1)

-- sqlfmt-corpus-separator --

select array_to_string('{}'::int4[], ',')

-- sqlfmt-corpus-separator --

select attname, to_json(histogram_bounds) histogram_bounds
from pg_stats
where tablename = 'rows' and
      schemaname = pg_my_temp_schema()::regnamespace::text
order by 1

-- sqlfmt-corpus-separator --

select attname, to_jsonb(histogram_bounds) histogram_bounds
from pg_stats
where tablename = 'rows' and
      schemaname = pg_my_temp_schema()::regnamespace::text
order by 1

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

select avg(unique1::int8) from tenk1

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

select cast (fullname as text) from fullname

-- sqlfmt-corpus-separator --

select concat('|', 'a'::text, 'b', 'c')

-- sqlfmt-corpus-separator --

select concat(variadic '{}'::int[]) = ''

-- sqlfmt-corpus-separator --

select conname from pg_constraint where conrelid = 'fktable2'::regclass order by conname

-- sqlfmt-corpus-separator --

select conname, contype, conkey from pg_constraint where conrelid = 'notnull_tbl1'::regclass

-- sqlfmt-corpus-separator --

select conname, contype, conrelid::regclass, conindid::regclass, conkey
  from pg_constraint where conrelid::regclass::text like 'idxpart%'
  order by conrelid::regclass::text, conname

-- sqlfmt-corpus-separator --

select conname, obj_description(oid, 'pg_constraint') as desc
  from pg_constraint where conname like 'at_partitioned%'
  order by conname

-- sqlfmt-corpus-separator --

select conname, obj_description(oid, 'pg_constraint') from pg_constraint
  where contypid = 'dcomptype'::regtype

-- sqlfmt-corpus-separator --

select conname, pg_get_constraintdef(oid) from pg_constraint
 where contypid = 'dnotnulltest'::regtype

-- sqlfmt-corpus-separator --

select conrelid::regclass::text as relname, conname,
       convalidated, conislocal, coninhcount, connoinherit
from pg_constraint where conname like 'inh\_check\_constraint%'
order by 1, 2

-- sqlfmt-corpus-separator --

select conrelid::regclass::text as relname, conname, conislocal, coninhcount, conenforced, convalidated
from pg_constraint where conname like 'inh\_check\_constraint%'
order by 1, 2

-- sqlfmt-corpus-separator --

select convalidated from pg_constraint where conrelid = 'parent_noinh_convalid'::regclass and conname = 'check_a_is_2'

-- sqlfmt-corpus-separator --

select count(*) from pg_constraint where contypid = 'connotnull'::regtype and contype = 'n'

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

select count(*) from tenk1 x where
  x.unique1 in (select a.f1 from int4_tbl a,float8_tbl b where a.f1=b.f1) and
  x.unique1 = 0 and
  x.unique1 in (select aa.f1 from int4_tbl aa,float8_tbl bb where aa.f1=bb.f1)

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr && 'empty'::int4range

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr && '{(10,20),(30,40),(50,60)}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr && '{}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr &< 'empty'::int4range

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr &< '{}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr &> 'empty'::int4range

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr &> '{}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr -|- 'empty'::int4range

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr -|- '{}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr << 'empty'::int4range

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr << '{}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr <@ 'empty'::int4range

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr <@ '{(10,30),(40,60),(70,90)}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr <@ '{}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr = '{}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr >> 'empty'::int4range

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr >> '{}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr @> 'empty'::int4range

-- sqlfmt-corpus-separator --

select count(*) from test_multirange_gist where mr @> '{}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_range_gist where ir && '{(10,20),(30,40),(50,60)}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_range_gist where ir <@ '{(10,30),(40,60),(70,90)}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_range_gist where ir @> 'empty'::int4range

-- sqlfmt-corpus-separator --

select count(*) from test_range_gist where ir @> '{}'::int4multirange

-- sqlfmt-corpus-separator --

select count(*) from test_range_spgist where ir @> 'empty'::int4range

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_abbrevs

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_names

-- sqlfmt-corpus-separator --

select date_bin('15 minutes'::interval, timestamp '294276-12-30', timestamp '4000-12-20 BC')

-- sqlfmt-corpus-separator --

select date_bin('15 minutes'::interval, timestamptz '294276-12-30', timestamptz '4000-12-20 BC')

-- sqlfmt-corpus-separator --

select date_bin('200000000 days'::interval, '2024-02-01'::timestamp, '2024-01-01'::timestamp)

-- sqlfmt-corpus-separator --

select date_bin('200000000 days'::interval, '2024-02-01'::timestamptz, '2024-01-01'::timestamptz)

-- sqlfmt-corpus-separator --

select date_bin('365000 days'::interval, '4400-01-01 BC'::timestamp, '4000-01-01 BC'::timestamp)

-- sqlfmt-corpus-separator --

select date_bin('365000 days'::interval, '4400-01-01 BC'::timestamptz, '4000-01-01 BC'::timestamptz)

-- sqlfmt-corpus-separator --

select daterange('-infinity'::date, '2000-01-01'::date, '()')

-- sqlfmt-corpus-separator --

select daterange('-infinity'::date, '2000-01-01'::date, '[)')

-- sqlfmt-corpus-separator --

select daterange('2000-01-01'::date, 'infinity'::date, '[)')

-- sqlfmt-corpus-separator --

select daterange('2000-01-01'::date, 'infinity'::date, '[]')

-- sqlfmt-corpus-separator --

select daterange('2000-01-10'::date, '2000-01-11'::date, '()')

-- sqlfmt-corpus-separator --

select daterange('2000-01-10'::date, '2000-01-11'::date, '(]')

-- sqlfmt-corpus-separator --

select daterange('2000-01-10'::date, '2000-01-20'::date, '()')

-- sqlfmt-corpus-separator --

select daterange('2000-01-10'::date, '2000-01-20'::date, '(]')

-- sqlfmt-corpus-separator --

select daterange('2000-01-10'::date, '2000-01-20'::date, '[)')

-- sqlfmt-corpus-separator --

select daterange('2000-01-10'::date, '2000-01-20'::date, '[]')

-- sqlfmt-corpus-separator --

select derived::base from derived

-- sqlfmt-corpus-separator --

select dfunc('City'::text)

-- sqlfmt-corpus-separator --

select dfunc('a'::text, 'b')

-- sqlfmt-corpus-separator --

select dfunc('a'::text, 'b', false)

-- sqlfmt-corpus-separator --

select dfunc('a'::text, 'b', true)

-- sqlfmt-corpus-separator --

select distinct max(unique2) from tenk1

-- sqlfmt-corpus-separator --

select distinct min(f1), max(f1) from minmaxtest

-- sqlfmt-corpus-separator --

select distinct on (1) floor(random()) as r, f1 from int4_tbl order by 1,2

-- sqlfmt-corpus-separator --

select distinct on (foobar) * from pg_database

-- sqlfmt-corpus-separator --

select div(-9999999999999999999999::numeric,1000000000000000000000)

-- sqlfmt-corpus-separator --

select div(-9999999999999999999999::numeric,1000000000000000000000)*1000000000000000000000 + mod(-9999999999999999999999::numeric,1000000000000000000000)

-- sqlfmt-corpus-separator --

select div(999999999999999999999::numeric,1000000000000000000000)

-- sqlfmt-corpus-separator --

select enum_range(null::bogon)

-- sqlfmt-corpus-separator --

select except select

-- sqlfmt-corpus-separator --

select exists(select * from nocolumns)

-- sqlfmt-corpus-separator --

select exp('-inf'::numeric)

-- sqlfmt-corpus-separator --

select exp('inf'::numeric)

-- sqlfmt-corpus-separator --

select exp('nan'::numeric)

-- sqlfmt-corpus-separator --

select exp(1.0::numeric(71,70))

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

select formarray(1, 'x'::text)

-- sqlfmt-corpus-separator --

select format_type('bpchar'::regtype, -1)

-- sqlfmt-corpus-separator --

select format_type('bpchar'::regtype, null)

-- sqlfmt-corpus-separator --

select format_type('varchar'::regtype, 42)

-- sqlfmt-corpus-separator --

select fullname::text from fullname

-- sqlfmt-corpus-separator --

select generate_series('2022-01-01 00:00'::timestamp,
                       'infinity'::timestamp,
                       '1 month'::interval) limit 10

-- sqlfmt-corpus-separator --

select generate_series('2022-01-01 00:00'::timestamptz,
                       'infinity'::timestamptz,
                       '1 month'::interval) limit 10

-- sqlfmt-corpus-separator --

select generate_series(0,2) as s1, generate_series((random()*.1)::int,2) as s2

-- sqlfmt-corpus-separator --

select generate_series(0,2) as s1, generate_series((random()*.1)::int,2) as s2
order by s2 desc

-- sqlfmt-corpus-separator --

select generate_series(timestamp '1995-08-06 12:12:12', timestamp '1996-08-06 12:12:12', interval '-infinity')

-- sqlfmt-corpus-separator --

select generate_series(timestamp '1995-08-06 12:12:12', timestamp '1996-08-06 12:12:12', interval 'infinity')

-- sqlfmt-corpus-separator --

select generate_series(timestamptz '1995-08-06 12:12:12', timestamptz '1996-08-06 12:12:12', interval '-infinity')

-- sqlfmt-corpus-separator --

select generate_series(timestamptz '1995-08-06 12:12:12', timestamptz '1996-08-06 12:12:12', interval 'infinity')

-- sqlfmt-corpus-separator --

select has_column_privilege('mytable',2::int2,'select')

-- sqlfmt-corpus-separator --

select has_column_privilege('mytable',99::int2,'select')

-- sqlfmt-corpus-separator --

select has_column_privilege('pg_authid',99::int2,'select')

-- sqlfmt-corpus-separator --

select has_column_privilege(9999,99::int2,'select')

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

select indexdef from pg_indexes where indexname like 'idxpart_idx%'

-- sqlfmt-corpus-separator --

select indexrelid::regclass, indisclustered from pg_index
  where indrelid = 'alttype_cluster'::regclass
  order by indexrelid::regclass::text

-- sqlfmt-corpus-separator --

select indexrelid::regclass, indrelid::regclass
  from pg_index where indexrelid::regclass::text like 'idxpart%'

-- sqlfmt-corpus-separator --

select int4range(1, 3)::int4multirange

-- sqlfmt-corpus-separator --

select int4range(1, null)::int4multirange

-- sqlfmt-corpus-separator --

select int4range(null, null)::int4multirange

-- sqlfmt-corpus-separator --

select int8range(10000000000::int8, 20000000000::int8,'(]')

-- sqlfmt-corpus-separator --

select intersect select

-- sqlfmt-corpus-separator --

select interval '-0.01 months -9223372036854775808 microseconds'

-- sqlfmt-corpus-separator --

select interval '-0.1 centuries -2147483648 months'

-- sqlfmt-corpus-separator --

select interval '-0.1 days -9223372036854775808 microseconds'

-- sqlfmt-corpus-separator --

select interval '-0.1 decades -2147483648 months'

-- sqlfmt-corpus-separator --

select interval '-0.1 millennium -2147483648 months'

-- sqlfmt-corpus-separator --

select interval '-0.1 months -2147483648 days'

-- sqlfmt-corpus-separator --

select interval '-0.1 weeks -9223372036854775808 microseconds'

-- sqlfmt-corpus-separator --

select interval '-0.1 yrs -2147483648 months'

-- sqlfmt-corpus-separator --

select interval '-0.5 weeks -2147483648 days'

-- sqlfmt-corpus-separator --

select interval '-1 century -2147483648 years'

-- sqlfmt-corpus-separator --

select interval '-1 decade -2147483648 years'

-- sqlfmt-corpus-separator --

select interval '-1 millennium -2147483648 years'

-- sqlfmt-corpus-separator --

select interval '-1 week -2147483648 days'

-- sqlfmt-corpus-separator --

select interval '-10 mons -3 days +03:55:06.70'

-- sqlfmt-corpus-separator --

select interval '-153722867280.912930133 minutes'

-- sqlfmt-corpus-separator --

select interval '-153722867281 minutes'

-- sqlfmt-corpus-separator --

select interval '-2147483647 months -2147483648 days -9223372036854775808 us'

-- sqlfmt-corpus-separator --

select interval '-2147483648 centuries'

-- sqlfmt-corpus-separator --

select interval '-2147483648 days -0.1 months'

-- sqlfmt-corpus-separator --

select interval '-2147483648 days -0.5 weeks'

-- sqlfmt-corpus-separator --

select interval '-2147483648 days -1 week'

-- sqlfmt-corpus-separator --

select interval '-2147483648 days ago'

-- sqlfmt-corpus-separator --

select interval '-2147483648 decades'

-- sqlfmt-corpus-separator --

select interval '-2147483648 millennium'

-- sqlfmt-corpus-separator --

select interval '-2147483648 months -0.1 centuries'

-- sqlfmt-corpus-separator --

select interval '-2147483648 months -0.1 decades'

-- sqlfmt-corpus-separator --

select interval '-2147483648 months -0.1 millennium'

-- sqlfmt-corpus-separator --

select interval '-2147483648 months -0.1 yrs'

-- sqlfmt-corpus-separator --

select interval '-2147483648 months -2147483648 days -9223372036854775808 microseconds ago'

-- sqlfmt-corpus-separator --

select interval '-2147483648 months ago'

-- sqlfmt-corpus-separator --

select interval '-2147483648 weeks'

-- sqlfmt-corpus-separator --

select interval '-2147483648 years -1 century'

-- sqlfmt-corpus-separator --

select interval '-2147483648 years -1 decade'

-- sqlfmt-corpus-separator --

select interval '-2147483648 years -1 millennium'

-- sqlfmt-corpus-separator --

select interval '-2147483649 days'

-- sqlfmt-corpus-separator --

select interval '-2147483649 months'

-- sqlfmt-corpus-separator --

select interval '-2147483649 years'

-- sqlfmt-corpus-separator --

select interval '-2562047788.01521550222 hours'

-- sqlfmt-corpus-separator --

select interval '-2562047789 hours'

-- sqlfmt-corpus-separator --

select interval '-9223372036854.775808 seconds'

-- sqlfmt-corpus-separator --

select interval '-9223372036854775.808 milliseconds'

-- sqlfmt-corpus-separator --

select interval '-9223372036854775808 microseconds -0.01 months'

-- sqlfmt-corpus-separator --

select interval '-9223372036854775808 microseconds -0.1 days'

-- sqlfmt-corpus-separator --

select interval '-9223372036854775808 microseconds -0.1 weeks'

-- sqlfmt-corpus-separator --

select interval '-9223372036854775808 microseconds ago'

-- sqlfmt-corpus-separator --

select interval '-9223372036854775808 microseconds'

-- sqlfmt-corpus-separator --

select interval '-9223372036854775809 microsecond'

-- sqlfmt-corpus-separator --

select interval '-9223372036854777 millisecond'

-- sqlfmt-corpus-separator --

select interval '-9223372036855 seconds'

-- sqlfmt-corpus-separator --

select interval '0.01 months 9223372036854775807 microseconds'

-- sqlfmt-corpus-separator --

select interval '0.1 2562047788:0:54.775807'

-- sqlfmt-corpus-separator --

select interval '0.1 2562047788:0:54.775808 ago'

-- sqlfmt-corpus-separator --

select interval '0.1 centuries 2147483647 months'

-- sqlfmt-corpus-separator --

select interval '0.1 days 9223372036854775807 microseconds'

-- sqlfmt-corpus-separator --

select interval '0.1 decades 2147483647 months'

-- sqlfmt-corpus-separator --

select interval '0.1 millennium 2147483647 months'

-- sqlfmt-corpus-separator --

select interval '0.1 months 2147483647 days'

-- sqlfmt-corpus-separator --

select interval '0.1 weeks 9223372036854775807 microseconds'

-- sqlfmt-corpus-separator --

select interval '0.1 yrs 2147483647 months'

-- sqlfmt-corpus-separator --

select interval '0.5 weeks 2147483647 days'

-- sqlfmt-corpus-separator --

select interval '0:0:0.7', interval '@ 0.70 secs', interval '0.7 seconds'

-- sqlfmt-corpus-separator --

select interval '1 century 2147483647 years'

-- sqlfmt-corpus-separator --

select interval '1 decade 2147483647 years'

-- sqlfmt-corpus-separator --

select interval '1 millennium 2147483647 years'

-- sqlfmt-corpus-separator --

select interval '1 week 2147483647 days'

-- sqlfmt-corpus-separator --

select interval '1 year 2 mons 3 days 04:05:06.699999'

-- sqlfmt-corpus-separator --

select interval '153722867280.912930117 minutes'

-- sqlfmt-corpus-separator --

select interval '153722867281 minutes'

-- sqlfmt-corpus-separator --

select interval '2147483647 centuries'

-- sqlfmt-corpus-separator --

select interval '2147483647 days 0.1 months'

-- sqlfmt-corpus-separator --

select interval '2147483647 days 0.5 weeks'

-- sqlfmt-corpus-separator --

select interval '2147483647 days 1 week'

-- sqlfmt-corpus-separator --

select interval '2147483647 decades'

-- sqlfmt-corpus-separator --

select interval '2147483647 millennium'

-- sqlfmt-corpus-separator --

select interval '2147483647 months 0.1 centuries'

-- sqlfmt-corpus-separator --

select interval '2147483647 months 0.1 decades'

-- sqlfmt-corpus-separator --

select interval '2147483647 months 0.1 millennium'

-- sqlfmt-corpus-separator --

select interval '2147483647 months 0.1 yrs'

-- sqlfmt-corpus-separator --

select interval '2147483647 weeks'

-- sqlfmt-corpus-separator --

select interval '2147483647 years 1 century'

-- sqlfmt-corpus-separator --

select interval '2147483647 years 1 decade'

-- sqlfmt-corpus-separator --

select interval '2147483647 years 1 millennium'

-- sqlfmt-corpus-separator --

select interval '2147483648 days'

-- sqlfmt-corpus-separator --

select interval '2147483648 months'

-- sqlfmt-corpus-separator --

select interval '2147483648 years'

-- sqlfmt-corpus-separator --

select interval '2562047788.01521550194 hours'

-- sqlfmt-corpus-separator --

select interval '2562047788.1:0:54.775807'

-- sqlfmt-corpus-separator --

select interval '2562047788.1:0:54.775808 ago'

-- sqlfmt-corpus-separator --

select interval '2562047788:0.1:54.775807'

-- sqlfmt-corpus-separator --

select interval '2562047788:0.1:54.775808 ago'

-- sqlfmt-corpus-separator --

select interval '2562047789 hours'

-- sqlfmt-corpus-separator --

select interval '9223372036854.775807 seconds'

-- sqlfmt-corpus-separator --

select interval '9223372036854775.807 milliseconds'

-- sqlfmt-corpus-separator --

select interval '9223372036854775807 microseconds 0.01 months'

-- sqlfmt-corpus-separator --

select interval '9223372036854775807 microseconds 0.1 days'

-- sqlfmt-corpus-separator --

select interval '9223372036854775807 microseconds 0.1 weeks'

-- sqlfmt-corpus-separator --

select interval '9223372036854775807 microseconds'

-- sqlfmt-corpus-separator --

select interval '9223372036854775808 microsecond'

-- sqlfmt-corpus-separator --

select interval '9223372036854777 millisecond'

-- sqlfmt-corpus-separator --

select interval '9223372036855 seconds'

-- sqlfmt-corpus-separator --

select interval 'P-0.01MT-2562047788H-54.775808S'

-- sqlfmt-corpus-separator --

select interval 'P-0.1DT-2562047788H-54.775808S'

-- sqlfmt-corpus-separator --

select interval 'P-0.1M-2147483648D'

-- sqlfmt-corpus-separator --

select interval 'P-0.1Y-2147483648M'

-- sqlfmt-corpus-separator --

select interval 'P-0.5W-2147483648D'

-- sqlfmt-corpus-separator --

select interval 'P-1W-2147483648D'

-- sqlfmt-corpus-separator --

select interval 'P-2147483648D-0.1M'

-- sqlfmt-corpus-separator --

select interval 'P-2147483648D-0.5W'

-- sqlfmt-corpus-separator --

select interval 'P-2147483648D-1W'

-- sqlfmt-corpus-separator --

select interval 'P-2147483648M-0.1Y'

-- sqlfmt-corpus-separator --

select interval 'P-2147483649'

-- sqlfmt-corpus-separator --

select interval 'P.1Y0M3DT4H5M6S'

-- sqlfmt-corpus-separator --

select interval 'P.Y0M3DT4H5M6S'

-- sqlfmt-corpus-separator --

select interval 'P0.01MT2562047788H54.775807S'

-- sqlfmt-corpus-separator --

select interval 'P0.1-2147483647-00'

-- sqlfmt-corpus-separator --

select interval 'P0.1DT2562047788H54.775807S'

-- sqlfmt-corpus-separator --

select interval 'P0.1M2147483647D'

-- sqlfmt-corpus-separator --

select interval 'P0.1Y2147483647M'

-- sqlfmt-corpus-separator --

select interval 'P0.5W2147483647D'

-- sqlfmt-corpus-separator --

select interval 'P00-0.01-00T2562047788:00:54.775807'

-- sqlfmt-corpus-separator --

select interval 'P00-0.1-2147483647'

-- sqlfmt-corpus-separator --

select interval 'P00-00-0.1T2562047788:00:54.775807'

-- sqlfmt-corpus-separator --

select interval 'P1-2147483647-2147483647'

-- sqlfmt-corpus-separator --

select interval 'P1.0Y0M3DT4H5M6S'

-- sqlfmt-corpus-separator --

select interval 'P1.1Y0M3DT4H5M6S'

-- sqlfmt-corpus-separator --

select interval 'P1.Y0M3DT4H5M6S'

-- sqlfmt-corpus-separator --

select interval 'P10.5e4Y'

-- sqlfmt-corpus-separator --

select interval 'P1W2147483647D'

-- sqlfmt-corpus-separator --

select interval 'P1Y0M3DT4H5M6S'

-- sqlfmt-corpus-separator --

select interval 'P2147483647D0.1M'

-- sqlfmt-corpus-separator --

select interval 'P2147483647D0.5W'

-- sqlfmt-corpus-separator --

select interval 'P2147483647D1W'

-- sqlfmt-corpus-separator --

select interval 'P2147483647M0.1Y'

-- sqlfmt-corpus-separator --

select interval 'P2147483648'

-- sqlfmt-corpus-separator --

select interval 'PT-2562047788.0152155022222'

-- sqlfmt-corpus-separator --

select interval 'PT-2562047788.1H-54.775808S'

-- sqlfmt-corpus-separator --

select interval 'PT-2562047788H-0.1M-54.775808S'

-- sqlfmt-corpus-separator --

select interval 'PT-2562047788H-54.775808S'

-- sqlfmt-corpus-separator --

select interval 'PT-2562047789'

-- sqlfmt-corpus-separator --

select interval 'PT2562047788.0152155019444'

-- sqlfmt-corpus-separator --

select interval 'PT2562047788.1:00:54.775807'

-- sqlfmt-corpus-separator --

select interval 'PT2562047788.1H54.775807S'

-- sqlfmt-corpus-separator --

select interval 'PT2562047788:00:54.775807'

-- sqlfmt-corpus-separator --

select interval 'PT2562047788:01.:54.775807'

-- sqlfmt-corpus-separator --

select interval 'PT2562047788H0.1M54.775807S'

-- sqlfmt-corpus-separator --

select interval 'PT2562047788H54.775807S'

-- sqlfmt-corpus-separator --

select interval 'PT2562047789'

-- sqlfmt-corpus-separator --

select interval_hash('30 days'::interval) = interval_hash('1 month'::interval) as t

-- sqlfmt-corpus-separator --

select isfinite('infinity'::date), isfinite('-infinity'::date), isfinite('today'::date)

-- sqlfmt-corpus-separator --

select json '{ "a":  "\ud83dX" }' -> 'a'

-- sqlfmt-corpus-separator --

select json '{ "a":  "\ud83d\ud83d" }' -> 'a'

-- sqlfmt-corpus-separator --

select json '{ "a":  "\ud83d\ude04\ud83d\udc36" }' -> 'a' as correct_in_utf8

-- sqlfmt-corpus-separator --

select json '{ "a":  "\ude04X" }' -> 'a'

-- sqlfmt-corpus-separator --

select json '{ "a":  "\ude04\ud83d" }' -> 'a'

-- sqlfmt-corpus-separator --

select json '{ "a":  "dollar \\u0024 character" }' ->> 'a' as not_an_escape

-- sqlfmt-corpus-separator --

select json '{ "a":  "dollar \\u0024 character" }' as not_an_escape

-- sqlfmt-corpus-separator --

select json '{ "a":  "dollar \u0024 character" }' ->> 'a' as correct_everywhere

-- sqlfmt-corpus-separator --

select json '{ "a":  "dollar \u0024 character" }' as correct_everywhere

-- sqlfmt-corpus-separator --

select json '{ "a":  "null \\u0000 escape" }' ->> 'a' as not_an_escape

-- sqlfmt-corpus-separator --

select json '{ "a":  "null \\u0000 escape" }' as not_an_escape

-- sqlfmt-corpus-separator --

select json '{ "a":  "null \u0000 escape" }' ->> 'a' as fails

-- sqlfmt-corpus-separator --

select json '{ "a":  "null \u0000 escape" }' as not_unescaped

-- sqlfmt-corpus-separator --

select json '{ "a":  "the Copyright \u00a9 sign" }' ->> 'a' as correct_in_utf8

-- sqlfmt-corpus-separator --

select json '{ "a":  "the Copyright \u00a9 sign" }' as correct_in_utf8

-- sqlfmt-corpus-separator --

select json_extract_path('{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}','f2',0::text)

-- sqlfmt-corpus-separator --

select json_extract_path('{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}','f2',1::text)

-- sqlfmt-corpus-separator --

select json_extract_path_text('{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}','f2',0::text)

-- sqlfmt-corpus-separator --

select json_extract_path_text('{"f2":["f3",1],"f4":{"f5":99,"f6":"stringy"}}','f2',1::text)

-- sqlfmt-corpus-separator --

select json_to_tsvector('""'::json, '"all"')

-- sqlfmt-corpus-separator --

select json_to_tsvector('[]'::json, '"all"')

-- sqlfmt-corpus-separator --

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '""')

-- sqlfmt-corpus-separator --

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"all"')

-- sqlfmt-corpus-separator --

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"boolean"')

-- sqlfmt-corpus-separator --

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"key"')

-- sqlfmt-corpus-separator --

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"numeric"')

-- sqlfmt-corpus-separator --

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '"string"')

-- sqlfmt-corpus-separator --

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '["all", null]')

-- sqlfmt-corpus-separator --

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '["string", "numeric"]')

-- sqlfmt-corpus-separator --

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '[]')

-- sqlfmt-corpus-separator --

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, 'null')

-- sqlfmt-corpus-separator --

select json_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::json, '{}')

-- sqlfmt-corpus-separator --

select json_to_tsvector('null'::json, '"all"')

-- sqlfmt-corpus-separator --

select json_to_tsvector('{}'::json, '"all"')

-- sqlfmt-corpus-separator --

select jsonb '"10-03-2017"' @? '$.datetime("dd-mm-yyyy")'

-- sqlfmt-corpus-separator --

select jsonb '"12:34:56 +05:30"' @? '$.time_tz()'

-- sqlfmt-corpus-separator --

select jsonb '"12:34:56"' @? '$.time()'

-- sqlfmt-corpus-separator --

select jsonb '"2023-08-15 12:34:56 +05:30"' @? '$.timestamp_tz()'

-- sqlfmt-corpus-separator --

select jsonb '"2023-08-15 12:34:56"' @? '$.timestamp()'

-- sqlfmt-corpus-separator --

select jsonb '"2023-08-15"' @? '$.date()'

-- sqlfmt-corpus-separator --

select jsonb '1' @? '$ ? ($ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '1' @? '$ ? ((@ == "1") is unknown)'

-- sqlfmt-corpus-separator --

select jsonb '1' @? '$ ? ((@ == 1) is unknown)'

-- sqlfmt-corpus-separator --

select jsonb '2' @? '$ == "2"'

-- sqlfmt-corpus-separator --

select jsonb '2' @@ '$ <= 1'

-- sqlfmt-corpus-separator --

select jsonb '2' @@ '$ == "2"'

-- sqlfmt-corpus-separator --

select jsonb '2' @@ '$ > 1'

-- sqlfmt-corpus-separator --

select jsonb '2' @@ '1'

-- sqlfmt-corpus-separator --

select jsonb '["1",2,0,3]' @? '-$[*]'

-- sqlfmt-corpus-separator --

select jsonb '["1",2,0,3]' @? 'strict -$[*]'

-- sqlfmt-corpus-separator --

select jsonb '[1,"2",0,3]' @? '-$[*]'

-- sqlfmt-corpus-separator --

select jsonb '[1,"2",0,3]' @? 'strict -$[*]'

-- sqlfmt-corpus-separator --

select jsonb '[1,2,3,{"b": [3,4,5]}]' @? 'lax $.*'

-- sqlfmt-corpus-separator --

select jsonb '[1,2,3,{"b": [3,4,5]}]' @? 'strict $.*'

-- sqlfmt-corpus-separator --

select jsonb '[1,2,3]' @? '$ ? (+@[*] > +2)'

-- sqlfmt-corpus-separator --

select jsonb '[1,2,3]' @? '$ ? (+@[*] > +3)'

-- sqlfmt-corpus-separator --

select jsonb '[1,2,3]' @? '$ ? (-@[*] < -2)'

-- sqlfmt-corpus-separator --

select jsonb '[1,2,3]' @? '$ ? (-@[*] < -3)'

-- sqlfmt-corpus-separator --

select jsonb '[1,2,3]' @? '$.*'

-- sqlfmt-corpus-separator --

select jsonb '[1,2,3]' @@ '$[*]'

-- sqlfmt-corpus-separator --

select jsonb '[1]' @? '$[*]'

-- sqlfmt-corpus-separator --

select jsonb '[1]' @? '$[0.3]'

-- sqlfmt-corpus-separator --

select jsonb '[1]' @? '$[0.5]'

-- sqlfmt-corpus-separator --

select jsonb '[1]' @? '$[0.9]'

-- sqlfmt-corpus-separator --

select jsonb '[1]' @? '$[0]'

-- sqlfmt-corpus-separator --

select jsonb '[1]' @? '$[1.2]'

-- sqlfmt-corpus-separator --

select jsonb '[1]' @? '$[1]'

-- sqlfmt-corpus-separator --

select jsonb '[1]' @? 'lax $[10000000000000000]'

-- sqlfmt-corpus-separator --

select jsonb '[1]' @? 'strict $[1.2]'

-- sqlfmt-corpus-separator --

select jsonb '[1]' @? 'strict $[10000000000000000]'

-- sqlfmt-corpus-separator --

select jsonb '[1]' @? 'strict $[1]'

-- sqlfmt-corpus-separator --

select jsonb '[]' @? '$[*]'

-- sqlfmt-corpus-separator --

select jsonb '[]' @@ '$'

-- sqlfmt-corpus-separator --

select jsonb '[]' @@ '$[*]'

-- sqlfmt-corpus-separator --

select jsonb '[{"a": 1}, {"a": 2}]' @? '$[0 to 1] ? (@.a > 1)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": 1, "b": [1, 2]}' @? 'lax $.keyvalue()'

-- sqlfmt-corpus-separator --

select jsonb '{"a": 1, "b": [1, 2]}' @? 'lax $.keyvalue().key'

-- sqlfmt-corpus-separator --

select jsonb '{"a": 1, "b":1}' @? '$ ? (@.a == @.b)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": 1, "b":1}' @? '$.** ? (@.a == @.b)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": 12}' @? '$'

-- sqlfmt-corpus-separator --

select jsonb '{"a": 12}' @? '$.a + 2'

-- sqlfmt-corpus-separator --

select jsonb '{"a": 12}' @? '$.a.b'

-- sqlfmt-corpus-separator --

select jsonb '{"a": 12}' @? '$.b + 2'

-- sqlfmt-corpus-separator --

select jsonb '{"a": 12}' @? '$.b'

-- sqlfmt-corpus-separator --

select jsonb '{"a": 12}' @? '1'

-- sqlfmt-corpus-separator --

select jsonb '{"a": 1}' @? '$.*'

-- sqlfmt-corpus-separator --

select jsonb '{"a": [1,2,3], "b": [3,4,"5"]}' @? '$ ? (@.a[*] >= @.b[*])'

-- sqlfmt-corpus-separator --

select jsonb '{"a": [1,2,3], "b": [3,4,"5"]}' @? 'strict $ ? (@.a[*] >= @.b[*])'

-- sqlfmt-corpus-separator --

select jsonb '{"a": [1,2,3], "b": [3,4,5]}' @? '$ ? (@.a[*] >  @.b[*])'

-- sqlfmt-corpus-separator --

select jsonb '{"a": [1,2,3], "b": [3,4,5]}' @? '$ ? (@.a[*] >= @.b[*])'

-- sqlfmt-corpus-separator --

select jsonb '{"a": [1,2,3], "b": [3,4,5]}' @? '$.*'

-- sqlfmt-corpus-separator --

select jsonb '{"a": [1,2,3], "b": [3,4,null]}' @? '$ ? (@.a[*] >= @.b[*])'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"a": 12}}' @? '$.*.a'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"a": 12}}' @? '$.a.a'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"b": 1}}' @? '$.**.b ? ( @ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"b": 1}}' @? '$.**{0 to last}.b ? ( @ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"b": 1}}' @? '$.**{0}.b ? ( @ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"b": 1}}' @? '$.**{1 to 2}.b ? ( @ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"b": 1}}' @? '$.**{1 to last}.b ? ( @ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"b": 1}}' @? '$.**{1}.b ? ( @ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"b": 1}}' @? 'lax $.**{1}'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"b": 1}}' @? 'lax $.**{2}'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"b": 1}}' @? 'lax $.**{3}'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**.b ? ( @ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{0 to last}.b ? ( @ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{0}.b ? ( @ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{1 to 2}.b ? ( @ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{1 to last}.b ? ( @ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{1}.b ? ( @ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '{"a": {"c": {"b": 1}}}' @? '$.**{2 to 3}.b ? ( @ > 0)'

-- sqlfmt-corpus-separator --

select jsonb '{"b": {"a": 12}}' @? '$.*.a'

-- sqlfmt-corpus-separator --

select jsonb '{"b": {"a": 12}}' @? '$.*.b'

-- sqlfmt-corpus-separator --

select jsonb '{"b": {"a": 12}}' @? 'strict $.*.b'

-- sqlfmt-corpus-separator --

select jsonb '{"c": {"a": -1, "b":1}}' @? '$.** ? (@.a == - 1)'

-- sqlfmt-corpus-separator --

select jsonb '{"c": {"a": -1, "b":1}}' @? '$.** ? (@.a == - @.b)'

-- sqlfmt-corpus-separator --

select jsonb '{"c": {"a": -1, "b":1}}' @? '$.** ? (@.a == -1)'

-- sqlfmt-corpus-separator --

select jsonb '{"c": {"a": -1, "b":1}}' @? '$.** ? (@.a == -@.b)'

-- sqlfmt-corpus-separator --

select jsonb '{"c": {"a": 0, "b":1}}' @? '$.** ? (@.a == 1 - +@.b)'

-- sqlfmt-corpus-separator --

select jsonb '{"c": {"a": 0, "b":1}}' @? '$.** ? (@.a == 1 - @.b)'

-- sqlfmt-corpus-separator --

select jsonb '{"c": {"a": 1, "b":1}}' @? '$ ? (@.a == @.b)'

-- sqlfmt-corpus-separator --

select jsonb '{"c": {"a": 1, "b":1}}' @? '$.* ? (@.a == @.b)'

-- sqlfmt-corpus-separator --

select jsonb '{"c": {"a": 1, "b":1}}' @? '$.** ? (@.a == @.b)'

-- sqlfmt-corpus-separator --

select jsonb '{"c": {"a": 1, "b":1}}' @? '$.c ? ($.c.a == @.b)'

-- sqlfmt-corpus-separator --

select jsonb '{"c": {"a": 1, "b":1}}' @? '$.c ? (@.a == @.b)'

-- sqlfmt-corpus-separator --

select jsonb '{"c": {"a": 2, "b":1}}' @? '$.** ? (@.a == 1 - - @.b)'

-- sqlfmt-corpus-separator --

select jsonb '{}' @? '$.*'

-- sqlfmt-corpus-separator --

select jsonb '{}' @@ '$'

-- sqlfmt-corpus-separator --

select jsonb_array_length('["a", "b", "c"]'::jsonb)

-- sqlfmt-corpus-separator --

select jsonb_delete('{"a":1 , "b":2, "c":3}'::jsonb, 'a')

-- sqlfmt-corpus-separator --

select jsonb_delete('{"a":1 , "b":2, "c":3}'::jsonb, 'b')

-- sqlfmt-corpus-separator --

select jsonb_delete('{"a":1 , "b":2, "c":3}'::jsonb, 'c')

-- sqlfmt-corpus-separator --

select jsonb_delete('{"a":1 , "b":2, "c":3}'::jsonb, 'd')

-- sqlfmt-corpus-separator --

select jsonb_delete('{"a":null , "b":2, "c":3}'::jsonb, 'a')

-- sqlfmt-corpus-separator --

select jsonb_object_keys('{"a":1, "b":2}'::jsonb)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"1000000-01-01"', '$.datetime() > "2020-01-01 12:00:00".datetime()'::jsonpath)

-- sqlfmt-corpus-separator --

select jsonb_populate_record_valid(NULL::jsb_char2, '{"a": "aa"}')

-- sqlfmt-corpus-separator --

select jsonb_populate_record_valid(NULL::jsb_char2, '{"a": "aaa"}')

-- sqlfmt-corpus-separator --

select jsonb_populate_record_valid(NULL::jsb_i_gt_1_rec, '{"a": 1}')

-- sqlfmt-corpus-separator --

select jsonb_populate_record_valid(NULL::jsb_i_gt_1_rec, '{"a": 2}')

-- sqlfmt-corpus-separator --

select jsonb_populate_record_valid(NULL::jsb_i_not_null_rec, '{"a": 1}')

-- sqlfmt-corpus-separator --

select jsonb_populate_record_valid(NULL::jsb_i_not_null_rec, '{"a": null}')

-- sqlfmt-corpus-separator --

select jsonb_populate_record_valid(NULL::jsb_ia, '{"a": 43.2}')

-- sqlfmt-corpus-separator --

select jsonb_populate_record_valid(NULL::jsb_ia, '{"a": [1, 2]}')

-- sqlfmt-corpus-separator --

select jsonb_populate_record_valid(NULL::jsb_ia2, '{"a": [[1, 0], [2, 3]]}')

-- sqlfmt-corpus-separator --

select jsonb_populate_record_valid(NULL::jsb_ia2, '{"a": [[1], [2, 3]]}')

-- sqlfmt-corpus-separator --

select jsonb_set('{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb, '{b,-1}', '"test"')

-- sqlfmt-corpus-separator --

select jsonb_set('{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb, '{b,-1}', '[1,2,3]')

-- sqlfmt-corpus-separator --

select jsonb_set('{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb, '{b,-1}', '{"1": 2}')

-- sqlfmt-corpus-separator --

select jsonb_set('{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb, '{b,-1}', '{"f": "test"}')

-- sqlfmt-corpus-separator --

select jsonb_set('{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb, '{d,1,0}', '[1,2,3]')

-- sqlfmt-corpus-separator --

select jsonb_set('{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb, '{d,1,0}', '{"1": 2}')

-- sqlfmt-corpus-separator --

select jsonb_set('{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb, '{d,NULL,0}', '[1,2,3]')

-- sqlfmt-corpus-separator --

select jsonb_set('{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb, '{d,NULL,0}', '{"1": 2}')

-- sqlfmt-corpus-separator --

select jsonb_set('{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb, '{n}', '[1,2,3]')

-- sqlfmt-corpus-separator --

select jsonb_set('{"n":null, "a":1, "b":[1,2], "c":{"1":2}, "d":{"1":[2,3]}}'::jsonb, '{n}', '{"1": 2}')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('""'::jsonb, '"all"')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('[]'::jsonb, '"all"')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::jsonb, '""')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::jsonb, '"all"')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::jsonb, '"boolean"')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::jsonb, '"key"')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::jsonb, '"numeric"')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::jsonb, '"string"')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::jsonb, '["all", null]')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::jsonb, '["string", "numeric"]')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::jsonb, '[]')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::jsonb, 'null')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('english', '{"a": "aaa in bbb", "b": 123, "c": 456, "d": true, "f": false, "g": null}'::jsonb, '{}')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('null'::jsonb, '"all"')

-- sqlfmt-corpus-separator --

select jsonb_to_tsvector('{}'::jsonb, '"all"')

-- sqlfmt-corpus-separator --

select jsonb_typeof('{"a":1}'::jsonb)

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

select mod(-9999999999999999999999::numeric,1000000000000000000000)

-- sqlfmt-corpus-separator --

select mod(999999999999999999999::numeric,1000000000000000000000)

-- sqlfmt-corpus-separator --

select multirange_of_text(textrange1('a','Z')) @> 'b'::text

-- sqlfmt-corpus-separator --

select myleast('z'::text)

-- sqlfmt-corpus-separator --

select name, setting from pg_settings where name like 'enable%'

-- sqlfmt-corpus-separator --

select null from pg_database group by datname for update

-- sqlfmt-corpus-separator --

select null::inotnull

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

select nummultirange() << 'empty'::numrange

-- sqlfmt-corpus-separator --

select nummultirange() >> 'empty'::numrange

-- sqlfmt-corpus-separator --

select obj_description('unreserved_test()'::regprocedure, 'pg_proc')

-- sqlfmt-corpus-separator --

select percentile_cont(0.5) within group (order by b) from aggtest

-- sqlfmt-corpus-separator --

select percentile_cont(0.5) within group (order by b), sum(b) from aggtest

-- sqlfmt-corpus-separator --

select percentile_cont(0.5) within group (order by thousand) from tenk1

-- sqlfmt-corpus-separator --

select percentile_disc(0.5) within group (order by thousand) from tenk1

-- sqlfmt-corpus-separator --

select pg_basetype('mytext'::regtype)

-- sqlfmt-corpus-separator --

select pg_basetype('mytext_child_1'::regtype)

-- sqlfmt-corpus-separator --

select pg_catalog.pg_column_is_updatable('uv_pt'::regclass, 1::smallint, false)

-- sqlfmt-corpus-separator --

select pg_catalog.pg_column_is_updatable('uv_pt'::regclass, 2::smallint, false)

-- sqlfmt-corpus-separator --

select pg_column_size('{"a":1 , "b":2, "c":3}'::jsonb - 'b') = pg_column_size('{"a":1, "b":2}'::jsonb)

-- sqlfmt-corpus-separator --

select pg_column_size('{"aa":1, "b":2}'::jsonb || '{}'::jsonb) = pg_column_size('{"aa":1, "b":2}'::jsonb)

-- sqlfmt-corpus-separator --

select pg_column_size('{"aa":1}'::jsonb || '{"b":2}'::jsonb) = pg_column_size('{"aa":1, "b":2}'::jsonb)

-- sqlfmt-corpus-separator --

select pg_column_size('{}'::jsonb || '{"aa":1, "b":2}'::jsonb) = pg_column_size('{"aa":1, "b":2}'::jsonb)

-- sqlfmt-corpus-separator --

select pg_column_size('{}'::jsonb || '{}'::jsonb) = pg_column_size('{}'::jsonb)

-- sqlfmt-corpus-separator --

select pg_get_ruledef(oid, true) from pg_rewrite
  where ev_class = 'tt23v'::regclass and ev_type = '1'

-- sqlfmt-corpus-separator --

select pg_get_viewdef('agg_view1'::regclass)

-- sqlfmt-corpus-separator --

select pg_get_viewdef('gstest_view'::regclass, true)

-- sqlfmt-corpus-separator --

select pg_get_viewdef('shoe'::regclass) as unpretty

-- sqlfmt-corpus-separator --

select pg_get_viewdef('shoe'::regclass,0) as prettier

-- sqlfmt-corpus-separator --

select pg_get_viewdef('shoe'::regclass,true) as pretty

-- sqlfmt-corpus-separator --

select pg_get_viewdef('v1'::regclass)

-- sqlfmt-corpus-separator --

select pg_snapshot '1000100010001000:1000100010001100:1000100010001012,1000100010001013'

-- sqlfmt-corpus-separator --

select pg_typeof('{1,2,3}'::dia || 42)

-- sqlfmt-corpus-separator --

select pg_typeof('{1,2,3}'::dia)

-- sqlfmt-corpus-separator --

select pg_typeof(unnest('11 22 33'::int2vector))

-- sqlfmt-corpus-separator --

select pg_typeof(unnest('11 22 33'::oidvector))

-- sqlfmt-corpus-separator --

select polyf(int4range(42, 49), 11, 2::smallint) as int, polyf(float8range(4.5, 7.8), 7.8, 11::real) as num

-- sqlfmt-corpus-separator --

select polyf(multirange(int4range(42, 49)), 11, 2::smallint) as int, polyf(multirange(float8range(4.5, 7.8)), 7.8, 11::real) as num

-- sqlfmt-corpus-separator --

select proname from pg_proc where proname ilike '00%foo' order by 1

-- sqlfmt-corpus-separator --

select proname from pg_proc where proname like E'RI\\_FKey%del' order by 1

-- sqlfmt-corpus-separator --

select q2, q1 from int8_tbl intersect select * from int8_tbl order by 1, 2

-- sqlfmt-corpus-separator --

select range_agg(null::nummultirange) from nummultirange_test

-- sqlfmt-corpus-separator --

select range_intersect_agg(null::nummultirange) from nummultirange_test

-- sqlfmt-corpus-separator --

select range_minus_multi('empty'::numrange, numrange(2.0, 3.0))

-- sqlfmt-corpus-separator --

select range_minus_multi(numrange(1.1, 2.2), 'empty'::numrange)

-- sqlfmt-corpus-separator --

select rank(3) within group (order by stringu1,stringu2) from tenk1

-- sqlfmt-corpus-separator --

select relname from pg_locks l, pg_class c
 where l.relation = c.oid and relname like '%lock_%' and mode = 'AccessExclusiveLock'
 order by relname

-- sqlfmt-corpus-separator --

select relname from pg_locks l, pg_class c
 where l.relation = c.oid and relname like '%lock_%' and mode = 'ExclusiveLock'
 order by relname

-- sqlfmt-corpus-separator --

select relname, relkind from pg_class
  where relname like 'idxpart%' order by relname

-- sqlfmt-corpus-separator --

select relname, relkind from pg_class
  where relname like 'idxpart_temp%' order by relname

-- sqlfmt-corpus-separator --

select relname, relkind from pg_class where relname like 'idxpart%' order by relname

-- sqlfmt-corpus-separator --

select reltoastrelid <> 0 as has_toast_table
  from pg_class where oid = 'test_storage'::regclass

-- sqlfmt-corpus-separator --

select round(((1 - 1.500012345678e-1000) ^ 1.45e1003) * 1e1000)

-- sqlfmt-corpus-separator --

select row_to_json(i) from int8_tbl i(x,y)

-- sqlfmt-corpus-separator --

select row_to_json(tt3::tt2::tt1) from tt3

-- sqlfmt-corpus-separator --

select satisfies_hash_partition('text_hashp'::regclass, 2, 0, 'xxx'::text) OR
	   satisfies_hash_partition('text_hashp'::regclass, 2, 1, 'xxx'::text) AS satisfies

-- sqlfmt-corpus-separator --

select scale(NULL::numeric)

-- sqlfmt-corpus-separator --

select scale(numeric 'NaN')

-- sqlfmt-corpus-separator --

select scale(numeric 'inf')

-- sqlfmt-corpus-separator --

select sqrt(1.000000000000003::numeric)

-- sqlfmt-corpus-separator --

select sqrt(1.000000000000004::numeric)

-- sqlfmt-corpus-separator --

select sqrt(515549506212297735.073688290367::numeric)

-- sqlfmt-corpus-separator --

select sqrt(515549506212297735.073688290368::numeric)

-- sqlfmt-corpus-separator --

select sqrt(8015491789940783531003294973900306::numeric)

-- sqlfmt-corpus-separator --

select sqrt(8015491789940783531003294973900307::numeric)

-- sqlfmt-corpus-separator --

select sqrt(96627521408608.56340355805::numeric)

-- sqlfmt-corpus-separator --

select sqrt(96627521408608.56340355806::numeric)

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

select tableoid::regclass from volatile_partbound_test

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from ab

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from cities

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from hp order by c

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from idxpart order by a

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from list_parted

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from mcrparted order by a, b

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from mlparted

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from mlparted order by a, b, c, d

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from mlparted_def

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from parted

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from pph_arrpart order by 1

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from range_parted

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from uv_pt

-- sqlfmt-corpus-separator --

select tableoid::regclass, * from uv_pt order by a, b

-- sqlfmt-corpus-separator --

select tableoid::regclass, a from list_parted

-- sqlfmt-corpus-separator --

select tableoid::regclass, a1 from inh_perm_parent

-- sqlfmt-corpus-separator --

select tableoid::regclass, a1 from inh_temp_parent

-- sqlfmt-corpus-separator --

select tableoid::regclass,count(*),sum(a) from parted_copytest
group by tableoid order by tableoid::regclass::name

-- sqlfmt-corpus-separator --

select tableoid::regclass::text as relname, bar.* from bar order by 1,2

-- sqlfmt-corpus-separator --

select tableoid::regclass::text as relname, mlparted_tab.* from mlparted_tab order by 1,2

-- sqlfmt-corpus-separator --

select tableoid::regclass::text as relname, parted_tab.* from parted_tab order by 1,2

-- sqlfmt-corpus-separator --

select tableoid::regclass::text, * from mcrparted order by 1

-- sqlfmt-corpus-separator --

select tableoid::regclass::text, a, min(b) as min_b, max(b) as max_b from list_parted group by 1, 2 order by 1

-- sqlfmt-corpus-separator --

select ten,
  sum(unique1) + sum(unique2) as res,
  rank() over (order by sum(unique1) + sum(unique2)) as rank
from tenk1
group by ten order by ten

-- sqlfmt-corpus-separator --

select ten, count(four), sum(DISTINCT four) from onek
group by ten order by ten

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

select textrange('\\\\', repeat('a', 200))::textmultirange

-- sqlfmt-corpus-separator --

select textrange('a', 'c')::textmultirange

-- sqlfmt-corpus-separator --

select textrange('a', null)::textmultirange

-- sqlfmt-corpus-separator --

select textrange(null, null)::textmultirange

-- sqlfmt-corpus-separator --

select textrange1('a','Z') @> 'b'::text

-- sqlfmt-corpus-separator --

select textrange2('a','z') @> 'b'::text

-- sqlfmt-corpus-separator --

select textrange_c('A','Z') @> 'b'::text

-- sqlfmt-corpus-separator --

select textrange_en_us('A','Z') @> 'b'::text

-- sqlfmt-corpus-separator --

select tgrelid::regclass, tgname, tgfoid::regproc from pg_trigger
  where tgrelid::regclass::text like 'trigpart%' order by tgrelid::regclass::text

-- sqlfmt-corpus-separator --

select tgrelid::regclass::text, tgname, tgfoid::regproc, tgenabled, tgisinternal from pg_trigger
  where tgname ~ '^trg1' order by 1

-- sqlfmt-corpus-separator --

select timestamp '-infinity' - timestamp '-infinity'

-- sqlfmt-corpus-separator --

select timestamp '-infinity' - timestamp '1995-08-06 12:12:12'

-- sqlfmt-corpus-separator --

select timestamp '-infinity' - timestamp 'infinity'

-- sqlfmt-corpus-separator --

select timestamp '1999-12-31 24:00:00'

-- sqlfmt-corpus-separator --

select timestamp 'infinity' - timestamp '-infinity'

-- sqlfmt-corpus-separator --

select timestamp 'infinity' - timestamp '1995-08-06 12:12:12'

-- sqlfmt-corpus-separator --

select timestamp 'infinity' - timestamp 'infinity'

-- sqlfmt-corpus-separator --

select timestamptz '1999-12-31 24:00:00'

-- sqlfmt-corpus-separator --

select to_bin(-1234::bigint)

-- sqlfmt-corpus-separator --

select to_hex(-1234::bigint) AS "fffffffffffffb2e"

-- sqlfmt-corpus-separator --

select to_hex(256::bigint*256::bigint*256::bigint*256::bigint - 1) AS "ffffffff"

-- sqlfmt-corpus-separator --

select to_json(date '-Infinity')

-- sqlfmt-corpus-separator --

select to_json(date '2014-05-28')

-- sqlfmt-corpus-separator --

select to_json(date 'Infinity')

-- sqlfmt-corpus-separator --

select to_json(timestamp '-Infinity')

-- sqlfmt-corpus-separator --

select to_json(timestamp '2014-05-28 12:22:35.614298')

-- sqlfmt-corpus-separator --

select to_json(timestamp 'Infinity')

-- sqlfmt-corpus-separator --

select to_json(timestamptz '-Infinity')

-- sqlfmt-corpus-separator --

select to_json(timestamptz '2014-05-28 12:22:35.614298-04')

-- sqlfmt-corpus-separator --

select to_json(timestamptz 'Infinity')

-- sqlfmt-corpus-separator --

select to_jsonb(date '-Infinity')

-- sqlfmt-corpus-separator --

select to_jsonb(date '2014-05-28')

-- sqlfmt-corpus-separator --

select to_jsonb(date 'Infinity')

-- sqlfmt-corpus-separator --

select to_jsonb(timestamp '-Infinity')

-- sqlfmt-corpus-separator --

select to_jsonb(timestamp '2014-05-28 12:22:35.614298')

-- sqlfmt-corpus-separator --

select to_jsonb(timestamp 'Infinity')

-- sqlfmt-corpus-separator --

select to_jsonb(timestamptz '-Infinity')

-- sqlfmt-corpus-separator --

select to_jsonb(timestamptz '2014-05-28 12:22:35.614298-04')

-- sqlfmt-corpus-separator --

select to_jsonb(timestamptz 'Infinity')

-- sqlfmt-corpus-separator --

select to_tsvector('""'::json)

-- sqlfmt-corpus-separator --

select to_tsvector('""'::jsonb)

-- sqlfmt-corpus-separator --

select to_tsvector('[]'::json)

-- sqlfmt-corpus-separator --

select to_tsvector('[]'::jsonb)

-- sqlfmt-corpus-separator --

select to_tsvector('english', '{"a": "aaa in bbb ddd ccc", "b": 123, "c": 456}'::json)

-- sqlfmt-corpus-separator --

select to_tsvector('english', '{"a": "aaa in bbb ddd ccc", "b": 123, "c": 456}'::jsonb)

-- sqlfmt-corpus-separator --

select to_tsvector('english', '{"a": "aaa in bbb ddd ccc", "b": ["the eee fff ggg"], "c": {"d": "hhh. iii"}}'::json)

-- sqlfmt-corpus-separator --

select to_tsvector('english', '{"a": "aaa in bbb ddd ccc", "b": ["the eee fff ggg"], "c": {"d": "hhh. iii"}}'::jsonb)

-- sqlfmt-corpus-separator --

select to_tsvector('null'::json)

-- sqlfmt-corpus-separator --

select to_tsvector('null'::jsonb)

-- sqlfmt-corpus-separator --

select to_tsvector('simple', '{"a": "aaa bbb ddd ccc", "b": ["eee fff ggg"], "c": {"d": "hhh iii"}}'::json)

-- sqlfmt-corpus-separator --

select to_tsvector('simple', '{"a": "aaa bbb ddd ccc", "b": ["eee fff ggg"], "c": {"d": "hhh iii"}}'::jsonb)

-- sqlfmt-corpus-separator --

select to_tsvector('{"a": "aaa bbb ddd ccc", "b": ["eee fff ggg"], "c": {"d": "hhh iii"}}'::json)

-- sqlfmt-corpus-separator --

select to_tsvector('{}'::json)

-- sqlfmt-corpus-separator --

select to_tsvector('{}'::jsonb)

-- sqlfmt-corpus-separator --

select trim_scale((0.1 - 2e-16383) * (0.1 - 3e-16383))

-- sqlfmt-corpus-separator --

select trim_scale(numeric 'NaN')

-- sqlfmt-corpus-separator --

select trim_scale(numeric 'inf')

-- sqlfmt-corpus-separator --

select ts_headline('[]'::json, tsquery('aaa & bbb'))

-- sqlfmt-corpus-separator --

select ts_headline('[]'::jsonb, tsquery('aaa & bbb'))

-- sqlfmt-corpus-separator --

select ts_headline('english', '{"a": "aaa bbb", "b": {"c": "ccc ddd fff", "c1": "ccc1 ddd1"}, "d": ["ggg hhh", "iii jjj"]}'::json, tsquery('bbb & ddd & hhh'), 'StartSel = <, StopSel = >')

-- sqlfmt-corpus-separator --

select ts_headline('english', '{"a": "aaa bbb", "b": {"c": "ccc ddd fff", "c1": "ccc1 ddd1"}, "d": ["ggg hhh", "iii jjj"]}'::jsonb, tsquery('bbb & ddd & hhh'), 'StartSel = <, StopSel = >')

-- sqlfmt-corpus-separator --

select ts_headline('english', '{"a": "aaa bbb", "b": {"c": "ccc ddd fff"}, "d": ["ggg hhh", "iii jjj"]}'::json, tsquery('bbb & ddd & hhh'))

-- sqlfmt-corpus-separator --

select ts_headline('english', '{"a": "aaa bbb", "b": {"c": "ccc ddd fff"}, "d": ["ggg hhh", "iii jjj"]}'::jsonb, tsquery('bbb & ddd & hhh'))

-- sqlfmt-corpus-separator --

select ts_headline('null'::json, tsquery('aaa & bbb'))

-- sqlfmt-corpus-separator --

select ts_headline('null'::jsonb, tsquery('aaa & bbb'))

-- sqlfmt-corpus-separator --

select ts_headline('{"a": "aaa bbb", "b": {"c": "ccc ddd fff", "c1": "ccc1 ddd1"}, "d": ["ggg hhh", "iii jjj"]}'::json, tsquery('bbb & ddd & hhh'))

-- sqlfmt-corpus-separator --

select ts_headline('{"a": "aaa bbb", "b": {"c": "ccc ddd fff", "c1": "ccc1 ddd1"}, "d": ["ggg hhh", "iii jjj"]}'::json, tsquery('bbb & ddd & hhh'), 'StartSel = <, StopSel = >')

-- sqlfmt-corpus-separator --

select ts_headline('{"a": "aaa bbb", "b": {"c": "ccc ddd fff", "c1": "ccc1 ddd1"}, "d": ["ggg hhh", "iii jjj"]}'::jsonb, tsquery('bbb & ddd & hhh'))

-- sqlfmt-corpus-separator --

select ts_headline('{"a": "aaa bbb", "b": {"c": "ccc ddd fff", "c1": "ccc1 ddd1"}, "d": ["ggg hhh", "iii jjj"]}'::jsonb, tsquery('bbb & ddd & hhh'), 'StartSel = <, StopSel = >')

-- sqlfmt-corpus-separator --

select ts_headline('{}'::json, tsquery('aaa & bbb'))

-- sqlfmt-corpus-separator --

select ts_headline('{}'::jsonb, tsquery('aaa & bbb'))

-- sqlfmt-corpus-separator --

select txid_snapshot '1000100010001000:1000100010001100:1000100010001012,1000100010001013'

-- sqlfmt-corpus-separator --

select union select

-- sqlfmt-corpus-separator --

select unique1 from tenk1 except select unique2 from tenk1 where unique2 != 10

-- sqlfmt-corpus-separator --

select unique1, unique2 from onek2
  where (unique2 = 11 or unique1 = 0) and stringu1 < 'B'

-- sqlfmt-corpus-separator --

select unique2 from onek2 where unique2 = 11 and stringu1 < 'B' for update

-- sqlfmt-corpus-separator --

select unnest('11 22 33'::int2vector)

-- sqlfmt-corpus-separator --

select unnest('11 22 33'::oidvector)

-- sqlfmt-corpus-separator --

with
A as ( select q2 as id, (select q1) as x from int8_tbl ),
B as ( select id, row_number() over (partition by id) as r from A ),
C as ( select A.id, array(select B.id from B where B.id = A.id) from A )
select * from C

-- sqlfmt-corpus-separator --

with ordinality as (select 1 as x) select * from ordinality

-- sqlfmt-corpus-separator --

with q as (select max(f1) from int4_tbl group by f1 order by f1)
  select q from q