SELECT count(DISTINCT four) AS cnt_4 FROM onek

-- sqlfmt-corpus-separator --

select ten, count(four), sum(DISTINCT four) from onek
group by ten order by ten

-- sqlfmt-corpus-separator --

select ten, sum(distinct four) from onek a
group by ten
having exists (select 1 from onek b where sum(distinct a.four) = b.four)

-- sqlfmt-corpus-separator --

select ten, sum(distinct four) from onek a
group by ten
having exists (select 1 from onek b
               where sum(distinct a.four + b.four) = b.four)

-- sqlfmt-corpus-separator --

select distinct max(unique2) from tenk1

-- sqlfmt-corpus-separator --

select distinct min(f1), max(f1) from minmaxtest

-- sqlfmt-corpus-separator --

select f1, (select distinct min(t1.f1) from int4_tbl t1 where t1.f1 = t0.f1)
from int4_tbl t0

-- sqlfmt-corpus-separator --

select avg((select avg(a1.col1 order by (select avg(a2.col2) from tenk1 a3))
            from tenk1 a1(col1)))
from tenk1 a2(col2)

-- sqlfmt-corpus-separator --

select array_agg(distinct val)
from (select null as val from generate_series(1, 2))

-- sqlfmt-corpus-separator --

select array_agg(a order by b)
  from (values (1,4),(2,3),(3,1),(4,2)) v(a,b)

-- sqlfmt-corpus-separator --

select array_agg(a order by a)
  from (values (1,4),(2,3),(3,1),(4,2)) v(a,b)

-- sqlfmt-corpus-separator --

select array_agg(a order by a desc)
  from (values (1,4),(2,3),(3,1),(4,2)) v(a,b)

-- sqlfmt-corpus-separator --

select array_agg(b order by a desc)
  from (values (1,4),(2,3),(3,1),(4,2)) v(a,b)

-- sqlfmt-corpus-separator --

select array_agg(distinct a)
  from (values (1),(2),(1),(3),(null),(2)) v(a)

-- sqlfmt-corpus-separator --

select array_agg(distinct a order by a)
  from (values (1),(2),(1),(3),(null),(2)) v(a)

-- sqlfmt-corpus-separator --

select array_agg(distinct a order by a desc)
  from (values (1),(2),(1),(3),(null),(2)) v(a)

-- sqlfmt-corpus-separator --

select array_agg(distinct a order by a desc nulls last)
  from (values (1),(2),(1),(3),(null),(2)) v(a)

-- sqlfmt-corpus-separator --

select aggfstr(distinct a,b,c)
  from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
       generate_series(1,3) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c)
  from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
       generate_series(1,3) i

-- sqlfmt-corpus-separator --

select aggfstr(distinct a,b,c order by b)
  from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
       generate_series(1,3) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c order by b)
  from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
       generate_series(1,3) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,a,c order by a)
  from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
       generate_series(1,2) i

-- sqlfmt-corpus-separator --

select
    string_agg(distinct 'a', ','),
    sum((
        select sum(1)
        from (values(1)) b(id)
        where a.id = b.id
)) from unnest(array[1]) a(id)

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c order by i)
  from (values (1,1,'foo')) v(a,b,c), generate_series(1,2) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c order by a,b+1)
  from (values (1,1,'foo')) v(a,b,c), generate_series(1,2) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c order by a,b,i,c)
  from (values (1,1,'foo')) v(a,b,c), generate_series(1,2) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,a,c order by a,b)
  from (values (1,1,'foo')) v(a,b,c), generate_series(1,2) i

-- sqlfmt-corpus-separator --

select string_agg(distinct f1, ',' order by f1) from varchar_tbl

-- sqlfmt-corpus-separator --

select string_agg(distinct f1::text, ',' order by f1) from varchar_tbl

-- sqlfmt-corpus-separator --

select string_agg(distinct f1, ',' order by f1::text) from varchar_tbl

-- sqlfmt-corpus-separator --

select string_agg(distinct f1::text, ',' order by f1::text) from varchar_tbl

-- sqlfmt-corpus-separator --

select min(unique1) filter (where unique1 > 100) from tenk1

-- sqlfmt-corpus-separator --

select sum(1/ten) filter (where ten > 0) from tenk1

-- sqlfmt-corpus-separator --

select ten, sum(distinct four) filter (where four::text ~ '123') from onek a
group by ten

-- sqlfmt-corpus-separator --

select ten, sum(distinct four) filter (where four > 10) from onek a
group by ten
having exists (select 1 from onek b where sum(distinct a.four) = b.four)

-- sqlfmt-corpus-separator --

select max(foo COLLATE "C") filter (where (bar collate "POSIX") > '0')
from (values ('a', 'b')) AS v(foo,bar)

-- sqlfmt-corpus-separator --

select any_value(v) filter (where v > 2) from (values (1), (2), (3)) as v (v)

-- sqlfmt-corpus-separator --

select (select count(*) filter (where outer_c <> 0)
        from (values (1)) t0(inner_c))
from (values (2),(3)) t1(outer_c)

-- sqlfmt-corpus-separator --

select (select count(inner_c) filter (where outer_c <> 0)
        from (values (1)) t0(inner_c))
from (values (2),(3)) t1(outer_c)

-- sqlfmt-corpus-separator --

select
  (select max((select i.unique2 from tenk1 i where i.unique1 = o.unique1))
     filter (where o.unique1 < 10))
from tenk1 o

-- sqlfmt-corpus-separator --

select sum(unique1) FILTER (WHERE
  unique1 IN (SELECT unique1 FROM onek where unique1 < 100)) FROM tenk1

-- sqlfmt-corpus-separator --

select max(0) filter (where b1) from bool_test

-- sqlfmt-corpus-separator --

select (select max(0) filter (where b1)) from bool_test

-- sqlfmt-corpus-separator --

select max(unique1) filter (where sum(ten) > 0) from tenk1

-- sqlfmt-corpus-separator --

select (select max(unique1) filter (where sum(ten) > 0) from int8_tbl) from tenk1

-- sqlfmt-corpus-separator --

select max(unique1) filter (where bool_or(ten > 0)) from tenk1

-- sqlfmt-corpus-separator --

select (select max(unique1) filter (where bool_or(ten > 0)) from int8_tbl) from tenk1

-- sqlfmt-corpus-separator --

select my_avg(distinct one),my_sum(distinct one) from (values(1),(3),(1)) t(one)

-- sqlfmt-corpus-separator --

select my_avg(distinct one),my_sum(one) from (values(1),(3)) t(one)

-- sqlfmt-corpus-separator --

select my_avg(one) filter (where one > 1),my_sum(one) from (values(1),(3)) t(one)

-- sqlfmt-corpus-separator --

SELECT avg(c1.f ORDER BY c1.x, c1.y)
FROM group_agg_pk c1 JOIN group_agg_pk c2 ON c1.x = c2.x
GROUP BY c1.w, c1.z

-- sqlfmt-corpus-separator --

SELECT min(x ORDER BY y) FROM (VALUES(1, NULL)) AS d(x,y)

-- sqlfmt-corpus-separator --

SELECT min(x ORDER BY y) FROM (VALUES(1, 2)) AS d(x,y)

-- sqlfmt-corpus-separator --

select array_agg(distinct ar order by ar desc)
  from (select array[i / 2] from generate_series(1,10) a(i)) b(ar)

-- sqlfmt-corpus-separator --

INSERT INTO brintest SELECT
	repeat(stringu1, 8)::bytea,
	substr(stringu1, 1, 1)::"char",
	stringu1::name, 142857 * tenthous,
	thousand,
	twothousand,
	repeat(stringu1, 8),
	unique1::oid,
	format('(%s,%s)', tenthous, twenty)::tid,
	(four + 1.0)/(hundred+1),
	odd::float8 / (tenthous + 1),
	format('%s:00:%s:00:%s:00', to_hex(odd), to_hex(even), to_hex(hundred))::macaddr,
	inet '10.2.3.4/24' + tenthous,
	cidr '10.2.3/24' + tenthous,
	substr(stringu1, 1, 1)::bpchar,
	date '1995-08-15' + tenthous,
	time '01:20:30' + thousand * interval '18.5 second',
	timestamp '1942-07-23 03:05:09' + tenthous * interval '36.38 hours',
	timestamptz '1972-10-10 03:00' + thousand * interval '1 hour',
	justify_days(justify_hours(tenthous * interval '12 minutes')),
	timetz '01:30:20+02' + hundred * interval '15 seconds',
	thousand::bit(10),
	tenthous::bit(16)::varbit,
	tenthous::numeric(36,30) * fivethous * even / (hundred + 1),
	format('%s%s-%s-%s-%s-%s%s%s', to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'))::uuid,
	int4range(thousand, twothousand),
	format('%s/%s%s', odd, even, tenthous)::pg_lsn,
	box(point(odd, even), point(thousand, twothousand))
FROM tenk1 ORDER BY unique2 LIMIT 100

-- sqlfmt-corpus-separator --

INSERT INTO brintest SELECT
	repeat(stringu1, 42)::bytea,
	substr(stringu1, 1, 1)::"char",
	stringu1::name, 142857 * tenthous,
	thousand,
	twothousand,
	repeat(stringu1, 42),
	unique1::oid,
	format('(%s,%s)', tenthous, twenty)::tid,
	(four + 1.0)/(hundred+1),
	odd::float8 / (tenthous + 1),
	format('%s:00:%s:00:%s:00', to_hex(odd), to_hex(even), to_hex(hundred))::macaddr,
	inet '10.2.3.4' + tenthous,
	cidr '10.2.3/24' + tenthous,
	substr(stringu1, 1, 1)::bpchar,
	date '1995-08-15' + tenthous,
	time '01:20:30' + thousand * interval '18.5 second',
	timestamp '1942-07-23 03:05:09' + tenthous * interval '36.38 hours',
	timestamptz '1972-10-10 03:00' + thousand * interval '1 hour',
	justify_days(justify_hours(tenthous * interval '12 minutes')),
	timetz '01:30:20' + hundred * interval '15 seconds',
	thousand::bit(10),
	tenthous::bit(16)::varbit,
	tenthous::numeric(36,30) * fivethous * even / (hundred + 1),
	format('%s%s-%s-%s-%s-%s%s%s', to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'))::uuid,
	int4range(thousand, twothousand),
	format('%s/%s%s', odd, even, tenthous)::pg_lsn,
	box(point(odd, even), point(thousand, twothousand))
FROM tenk1 ORDER BY unique2 LIMIT 5 OFFSET 5

-- sqlfmt-corpus-separator --

INSERT INTO brintest_bloom SELECT
	repeat(stringu1, 8)::bytea,
	substr(stringu1, 1, 1)::"char",
	stringu1::name, 142857 * tenthous,
	thousand,
	twothousand,
	repeat(stringu1, 8),
	unique1::oid,
	(four + 1.0)/(hundred+1),
	odd::float8 / (tenthous + 1),
	format('%s:00:%s:00:%s:00', to_hex(odd), to_hex(even), to_hex(hundred))::macaddr,
	inet '10.2.3.4/24' + tenthous,
	cidr '10.2.3/24' + tenthous,
	substr(stringu1, 1, 1)::bpchar,
	date '1995-08-15' + tenthous,
	time '01:20:30' + thousand * interval '18.5 second',
	timestamp '1942-07-23 03:05:09' + tenthous * interval '36.38 hours',
	timestamptz '1972-10-10 03:00' + thousand * interval '1 hour',
	justify_days(justify_hours(tenthous * interval '12 minutes')),
	timetz '01:30:20+02' + hundred * interval '15 seconds',
	tenthous::numeric(36,30) * fivethous * even / (hundred + 1),
	format('%s%s-%s-%s-%s-%s%s%s', to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'))::uuid,
	format('%s/%s%s', odd, even, tenthous)::pg_lsn
FROM tenk1 ORDER BY unique2 LIMIT 100

-- sqlfmt-corpus-separator --

INSERT INTO brintest_bloom SELECT
	repeat(stringu1, 42)::bytea,
	substr(stringu1, 1, 1)::"char",
	stringu1::name, 142857 * tenthous,
	thousand,
	twothousand,
	repeat(stringu1, 42),
	unique1::oid,
	(four + 1.0)/(hundred+1),
	odd::float8 / (tenthous + 1),
	format('%s:00:%s:00:%s:00', to_hex(odd), to_hex(even), to_hex(hundred))::macaddr,
	inet '10.2.3.4' + tenthous,
	cidr '10.2.3/24' + tenthous,
	substr(stringu1, 1, 1)::bpchar,
	date '1995-08-15' + tenthous,
	time '01:20:30' + thousand * interval '18.5 second',
	timestamp '1942-07-23 03:05:09' + tenthous * interval '36.38 hours',
	timestamptz '1972-10-10 03:00' + thousand * interval '1 hour',
	justify_days(justify_hours(tenthous * interval '12 minutes')),
	timetz '01:30:20' + hundred * interval '15 seconds',
	tenthous::numeric(36,30) * fivethous * even / (hundred + 1),
	format('%s%s-%s-%s-%s-%s%s%s', to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'), to_char(tenthous, 'FM0000'))::uuid,
	format('%s/%s%s', odd, even, tenthous)::pg_lsn
FROM tenk1 ORDER BY unique2 LIMIT 5 OFFSET 5

-- sqlfmt-corpus-separator --

select distinct hundred from tenk1 where hundred in (47, 48, 72, 82)

-- sqlfmt-corpus-separator --

select distinct hundred from tenk1 where hundred in (47, 48, 72, 82) order by hundred desc

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"

-- sqlfmt-corpus-separator --

SELECT '\101'::"char"

-- sqlfmt-corpus-separator --

SELECT '\377'::"char"

-- sqlfmt-corpus-separator --

SELECT 'a'::"char"::text

-- sqlfmt-corpus-separator --

SELECT '\377'::"char"::text

-- sqlfmt-corpus-separator --

SELECT '\000'::"char"::text

-- sqlfmt-corpus-separator --

SELECT 'a'::text::"char"

-- sqlfmt-corpus-separator --

SELECT '\377'::text::"char"

-- sqlfmt-corpus-separator --

SELECT ''::text::"char"

-- sqlfmt-corpus-separator --

WITH rows AS
  (SELECT ctid, lag(a) OVER (ORDER BY ctid) AS la, a FROM clstr_expression)
SELECT * FROM rows WHERE la < a

-- sqlfmt-corpus-separator --

WITH rows AS
  (SELECT ctid, lag(b) OVER (ORDER BY ctid) AS lb, b FROM clstr_expression)
SELECT * FROM rows WHERE upper(lb) > upper(b)

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b) FROM collate_test1

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b) FROM collate_test2

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b) FROM collate_test3

-- sqlfmt-corpus-separator --

SELECT DISTINCT x FROM test3cs ORDER BY x

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT x) FROM test3cs

-- sqlfmt-corpus-separator --

SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3cs ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT x FROM test3ci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT x) FROM test3ci

-- sqlfmt-corpus-separator --

SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3ci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT x FROM test3bpci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT x) FROM test3bpci

-- sqlfmt-corpus-separator --

SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3bpci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT array_agg(x COLLATE "C" ORDER BY y COLLATE "POSIX") FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT array_agg(a ORDER BY x COLLATE "C", y COLLATE "POSIX") FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT array_agg(a ORDER BY x||y) FROM collate_test10

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT ctid,cmin,* FROM combocidtest

-- sqlfmt-corpus-separator --

with test_bytes as (
  select
    inbytes,
    description,
    (test_conv(inbytes || repeat('.', 3)::bytea, 'utf8', 'utf8')).error
  from utf8_verification_inputs
), test_padded as (
  select
    description,
    (test_conv(inbytes || repeat('.', 64)::bytea, 'utf8', 'utf8')).error
  from test_bytes
)
select
  description,
  b.error as orig_error,
  p.error as error_after_padding
from test_padded p
join test_bytes b
using (description)
where p.error is distinct from b.error
order by description

-- sqlfmt-corpus-separator --

with test_bytes as (
  select
    inbytes,
    description,
    (test_conv(inbytes || repeat('.', 3)::bytea, 'utf8', 'utf8')).error
  from utf8_verification_inputs
), test_padded as (
  select
    description,
    (test_conv(repeat('.', 64 - length(inbytes))::bytea || inbytes || repeat('.', 64)::bytea, 'utf8', 'utf8')).error
  from test_bytes
)
select
  description,
  b.error as orig_error,
  p.error as error_after_padding
from test_padded p
join test_bytes b
using (description)
where p.error is distinct from b.error
order by description

-- sqlfmt-corpus-separator --

with test_bytes as (
  select
    inbytes,
    description,
    (test_conv(inbytes || repeat('.', 3)::bytea, 'utf8', 'utf8')).error
  from utf8_verification_inputs
), test_padded as (
  select
    description,
    (test_conv(repeat('.', 64)::bytea || inbytes || repeat('.', 3)::bytea, 'utf8', 'utf8')).error
  from test_bytes
)
select
  description,
  b.error as orig_error,
  p.error as error_after_padding
from test_padded p
join test_bytes b
using (description)
where p.error is distinct from b.error
order by description

-- sqlfmt-corpus-separator --

with test_bytes as (
  select
    inbytes,
    description,
    (test_conv(inbytes || repeat('.', 3)::bytea, 'utf8', 'utf8')).error
  from utf8_verification_inputs
), test_padded as (
  select
    description,
    (test_conv(repeat('.', 64 - length(inbytes))::bytea || inbytes || repeat('.', 3)::bytea, 'utf8', 'utf8')).error
  from test_bytes
)
select
  description,
  b.error as orig_error,
  p.error as error_after_padding
from test_padded p
join test_bytes b
using (description)
where p.error is distinct from b.error
order by description

-- sqlfmt-corpus-separator --

SELECT COUNT(a), COUNT(1) FILTER(WHERE a=1) FROM heaptable

-- sqlfmt-corpus-separator --

SELECT COUNT(a), COUNT(1) FILTER(WHERE a=1) FROM heapmv

-- sqlfmt-corpus-separator --

PREPARE select1 AS SELECT 1 as a

-- sqlfmt-corpus-separator --

prepare s1 as select $1::pos_int = 10 as "is_ten"

-- sqlfmt-corpus-separator --

select distinct from pg_database

-- sqlfmt-corpus-separator --

select distinct on (foobar) * from pg_database

-- sqlfmt-corpus-separator --

prepare int8_query as select * from int8_tbl i8

-- sqlfmt-corpus-separator --

SELECT set('t')

-- sqlfmt-corpus-separator --

SELECT a,
       stddev(cast((SELECT sum(1) FROM generate_series(1,20) x) AS float4))
          OVER (PARTITION BY a,b,c ORDER BY b)
       AS z
FROM t1

-- sqlfmt-corpus-separator --

with testdata(bits) as (values
  (x'00000000'),
  (x'00800000'), (x'00800001'), (x'00800004'), (x'00800005'),
  (x'00800006'),
  (x'008002f1'), (x'008002f2'), (x'008002f3'),
  (x'00800e17'), (x'00800e18'), (x'00800e19'),
  (x'01000001'), (x'01102843'), (x'01a52c98'),
  (x'0219c229'), (x'02e4464d'), (x'037343c1'), (x'03a91b36'),
  (x'047ada65'), (x'0496fe87'), (x'0550844f'), (x'05999da3'),
  (x'060ea5e2'), (x'06e63c45'), (x'07f1e548'), (x'0fc5282b'),
  (x'1f850283'), (x'2874a9d6'),
  (x'3356bf94'), (x'3356bf95'), (x'3356bf96'),
  (x'33d6bf94'), (x'33d6bf95'), (x'33d6bf96'),
  (x'34a10faf'), (x'34a10fb0'), (x'34a10fb1'),
  (x'350637bc'), (x'350637bd'), (x'350637be'),
  (x'35719786'), (x'35719787'), (x'35719788'),
  (x'358637bc'), (x'358637bd'), (x'358637be'),
  (x'36a7c5ab'), (x'36a7c5ac'), (x'36a7c5ad'),
  (x'3727c5ab'), (x'3727c5ac'), (x'3727c5ad'),
  (x'38d1b714'), (x'38d1b715'), (x'38d1b716'),
  (x'38d1b717'), (x'38d1b718'), (x'38d1b719'),
  (x'38d1b71a'), (x'38d1b71b'), (x'38d1b71c'),
  (x'38d1b71d'),
  (x'38dffffe'), (x'38dfffff'), (x'38e00000'),
  (x'38efffff'), (x'38f00000'), (x'38f00001'),
  (x'3a83126e'), (x'3a83126f'), (x'3a831270'),
  (x'3c23d709'), (x'3c23d70a'), (x'3c23d70b'),
  (x'3dcccccc'), (x'3dcccccd'), (x'3dccccce'),
  (x'3dcccd6f'), (x'3dcccd70'), (x'3dcccd71'),
  (x'3effffff'), (x'3f000000'), (x'3f000001'),
  (x'3f333332'), (x'3f333333'), (x'3f333334'),
  (x'3f666665'), (x'3f666666'), (x'3f666667'),
  (x'3f7d70a3'), (x'3f7d70a4'), (x'3f7d70a5'),
  (x'3f7fbe76'), (x'3f7fbe77'), (x'3f7fbe78'),
  (x'3f7ff971'), (x'3f7ff972'), (x'3f7ff973'),
  (x'3f7fff57'), (x'3f7fff58'), (x'3f7fff59'),
  (x'3f7fffee'), (x'3f7fffef'),
  (x'3f7ffff0'), (x'3f7ffff1'), (x'3f7ffff2'),
  (x'3f7ffff3'), (x'3f7ffff4'), (x'3f7ffff5'),
  (x'3f7ffff6'), (x'3f7ffff7'), (x'3f7ffff8'),
  (x'3f7ffff9'), (x'3f7ffffa'), (x'3f7ffffb'),
  (x'3f7ffffc'), (x'3f7ffffd'), (x'3f7ffffe'),
  (x'3f7fffff'),
  (x'3f800000'),
  (x'3f800001'), (x'3f800002'), (x'3f800003'),
  (x'3f800004'), (x'3f800005'), (x'3f800006'),
  (x'3f800007'), (x'3f800008'), (x'3f800009'),
  (x'3f80000f'), (x'3f800010'), (x'3f800011'),
  (x'3f800012'), (x'3f800013'), (x'3f800014'),
  (x'3f800017'), (x'3f800018'), (x'3f800019'),
  (x'3f80001a'), (x'3f80001b'), (x'3f80001c'),
  (x'3f800029'), (x'3f80002a'), (x'3f80002b'),
  (x'3f800053'), (x'3f800054'), (x'3f800055'),
  (x'3f800346'), (x'3f800347'), (x'3f800348'),
  (x'3f8020c4'), (x'3f8020c5'), (x'3f8020c6'),
  (x'3f8147ad'), (x'3f8147ae'), (x'3f8147af'),
  (x'3f8ccccc'), (x'3f8ccccd'), (x'3f8cccce'),
  (x'3fc90fdb'), -- pi/2
  (x'402df854'), -- e
  (x'40490fdb'), -- pi
  (x'409fffff'), (x'40a00000'), (x'40a00001'),
  (x'40afffff'), (x'40b00000'), (x'40b00001'),
  (x'411fffff'), (x'41200000'), (x'41200001'),
  (x'42c7ffff'), (x'42c80000'), (x'42c80001'),
  (x'4479ffff'), (x'447a0000'), (x'447a0001'),
  (x'461c3fff'), (x'461c4000'), (x'461c4001'),
  (x'47c34fff'), (x'47c35000'), (x'47c35001'),
  (x'497423ff'), (x'49742400'), (x'49742401'),
  (x'4b18967f'), (x'4b189680'), (x'4b189681'),
  (x'4cbebc1f'), (x'4cbebc20'), (x'4cbebc21'),
  (x'4e6e6b27'), (x'4e6e6b28'), (x'4e6e6b29'),
  (x'501502f8'), (x'501502f9'), (x'501502fa'),
  (x'51ba43b6'), (x'51ba43b7'), (x'51ba43b8'),
  (x'1f6c1e4a'),  -- 5e-20
  (x'59be6cea'),  -- 67e14
  (x'5d5ab6c4'),  -- 985e15
  (x'2cc4a9bd'),  -- 55895e-16
  (x'15ae43fd'),  -- 7038531e-32
  (x'2cf757ca'),  -- 702990899e-20
  (x'665ba998'),  -- 25933168707e13
  (x'743c3324'),  -- 596428896559e20
  (x'47f1205a'),
  (x'4640e6ae'),
  (x'449a5225'),
  (x'42f6e9d5'),
  (x'414587dd'),
  (x'3f9e064b'),
  (x'4c000004'),
  (x'50061c46'),
  (x'510006a8'),
  (x'48951f84'),
  (x'45fd1840'),
  (x'39800000'),
  (x'3b200000'),
  (x'3b900000'),
  (x'3bd00000'),
  (x'63800000'),
  (x'4b000000'),
  (x'4b800000'),
  (x'4c000001'),
  (x'4c800b0d'),
  (x'00d24584'),
  (x'00d90b88'),
  (x'45803f34'),
  (x'4f9f24f7'),
  (x'3a8722c3'),
  (x'5c800041'),
  (x'15ae43fd'),
  (x'5d4cccfb'),
  (x'4c800001'),
  (x'57800ed8'),
  (x'5f000000'),
  (x'700000f0'),
  (x'5f23e9ac'),
  (x'5e9502f9'),
  (x'5e8012b1'),
  (x'3c000028'),
  (x'60cde861'),
  (x'03aa2a50'),
  (x'43480000'),
  (x'4c000000'),
  (x'5D1502F9'),
  (x'5D9502F9'),
  (x'5E1502F9'),
  (x'3f99999a'),
  (x'3f9d70a4'),
  (x'3f9df3b6'),
  (x'3f9e0419'),
  (x'3f9e0610'),
  (x'3f9e064b'),
  (x'3f9e0651'),
  (x'03d20cfe')
)
select float4send(flt) as ibits,
       flt,
       flt::text::float4 as r_flt,
       float4send(flt::text::float4) as obits,
       float4send(flt::text::float4) = float4send(flt) as correct
  from (select bits::integer::xfloat4::float4 as flt
          from testdata
	offset 0) s

-- sqlfmt-corpus-separator --

with testdata(bits) as (values
  (x'0000000000000000'),
  (x'0010000000000000'), (x'0010000000000001'),
  (x'0010000000000002'), (x'0018000000000000'),
  (x'3ddb7cdfd9d7bdba'), (x'3ddb7cdfd9d7bdbb'), (x'3ddb7cdfd9d7bdbc'),
  (x'3e112e0be826d694'), (x'3e112e0be826d695'), (x'3e112e0be826d696'),
  (x'3e45798ee2308c39'), (x'3e45798ee2308c3a'), (x'3e45798ee2308c3b'),
  (x'3e7ad7f29abcaf47'), (x'3e7ad7f29abcaf48'), (x'3e7ad7f29abcaf49'),
  (x'3eb0c6f7a0b5ed8c'), (x'3eb0c6f7a0b5ed8d'), (x'3eb0c6f7a0b5ed8e'),
  (x'3ee4f8b588e368ef'), (x'3ee4f8b588e368f0'), (x'3ee4f8b588e368f1'),
  (x'3f1a36e2eb1c432c'), (x'3f1a36e2eb1c432d'), (x'3f1a36e2eb1c432e'),
  (x'3f50624dd2f1a9fb'), (x'3f50624dd2f1a9fc'), (x'3f50624dd2f1a9fd'),
  (x'3f847ae147ae147a'), (x'3f847ae147ae147b'), (x'3f847ae147ae147c'),
  (x'3fb9999999999999'), (x'3fb999999999999a'), (x'3fb999999999999b'),
  (x'3feffffffffffff0'), (x'3feffffffffffff1'), (x'3feffffffffffff2'),
  (x'3feffffffffffff3'), (x'3feffffffffffff4'), (x'3feffffffffffff5'),
  (x'3feffffffffffff6'), (x'3feffffffffffff7'), (x'3feffffffffffff8'),
  (x'3feffffffffffff9'), (x'3feffffffffffffa'), (x'3feffffffffffffb'),
  (x'3feffffffffffffc'), (x'3feffffffffffffd'), (x'3feffffffffffffe'),
  (x'3fefffffffffffff'),
  (x'3ff0000000000000'),
  (x'3ff0000000000001'), (x'3ff0000000000002'), (x'3ff0000000000003'),
  (x'3ff0000000000004'), (x'3ff0000000000005'), (x'3ff0000000000006'),
  (x'3ff0000000000007'), (x'3ff0000000000008'), (x'3ff0000000000009'),
  (x'3ff921fb54442d18'),
  (x'4005bf0a8b14576a'),
  (x'400921fb54442d18'),
  (x'4023ffffffffffff'), (x'4024000000000000'), (x'4024000000000001'),
  (x'4058ffffffffffff'), (x'4059000000000000'), (x'4059000000000001'),
  (x'408f3fffffffffff'), (x'408f400000000000'), (x'408f400000000001'),
  (x'40c387ffffffffff'), (x'40c3880000000000'), (x'40c3880000000001'),
  (x'40f869ffffffffff'), (x'40f86a0000000000'), (x'40f86a0000000001'),
  (x'412e847fffffffff'), (x'412e848000000000'), (x'412e848000000001'),
  (x'416312cfffffffff'), (x'416312d000000000'), (x'416312d000000001'),
  (x'4197d783ffffffff'), (x'4197d78400000000'), (x'4197d78400000001'),
  (x'41cdcd64ffffffff'), (x'41cdcd6500000000'), (x'41cdcd6500000001'),
  (x'4202a05f1fffffff'), (x'4202a05f20000000'), (x'4202a05f20000001'),
  (x'42374876e7ffffff'), (x'42374876e8000000'), (x'42374876e8000001'),
  (x'426d1a94a1ffffff'), (x'426d1a94a2000000'), (x'426d1a94a2000001'),
  (x'42a2309ce53fffff'), (x'42a2309ce5400000'), (x'42a2309ce5400001'),
  (x'42d6bcc41e8fffff'), (x'42d6bcc41e900000'), (x'42d6bcc41e900001'),
  (x'430c6bf52633ffff'), (x'430c6bf526340000'), (x'430c6bf526340001'),
  (x'4341c37937e07fff'), (x'4341c37937e08000'), (x'4341c37937e08001'),
  (x'4376345785d89fff'), (x'4376345785d8a000'), (x'4376345785d8a001'),
  (x'43abc16d674ec7ff'), (x'43abc16d674ec800'), (x'43abc16d674ec801'),
  (x'43e158e460913cff'), (x'43e158e460913d00'), (x'43e158e460913d01'),
  (x'4415af1d78b58c3f'), (x'4415af1d78b58c40'), (x'4415af1d78b58c41'),
  (x'444b1ae4d6e2ef4f'), (x'444b1ae4d6e2ef50'), (x'444b1ae4d6e2ef51'),
  (x'4480f0cf064dd591'), (x'4480f0cf064dd592'), (x'4480f0cf064dd593'),
  (x'44b52d02c7e14af5'), (x'44b52d02c7e14af6'), (x'44b52d02c7e14af7'),
  (x'44ea784379d99db3'), (x'44ea784379d99db4'), (x'44ea784379d99db5'),
  (x'45208b2a2c280290'), (x'45208b2a2c280291'), (x'45208b2a2c280292'),
  (x'7feffffffffffffe'), (x'7fefffffffffffff'),
  (x'4350000000000002'),
  (x'4350000000002e06'),
  (x'4352000000000003'),
  (x'4352000000000004'),
  (x'4358000000000003'),
  (x'4358000000000004'),
  (x'435f000000000020'),
  (x'c350000000000002'),
  (x'c350000000002e06'),
  (x'c352000000000003'),
  (x'c352000000000004'),
  (x'c358000000000003'),
  (x'c358000000000004'),
  (x'c35f000000000020'),
  (x'42dc12218377de66'),
  (x'42a674e79c5fe51f'),
  (x'4271f71fb04cb74c'),
  (x'423cbe991a145879'),
  (x'4206fee0e1a9e061'),
  (x'41d26580b487e6b4'),
  (x'419d6f34540ca453'),
  (x'41678c29dcd6e9dc'),
  (x'4132d687e3df217d'),
  (x'40fe240c9fcb68c8'),
  (x'40c81cd6e63c53d3'),
  (x'40934a4584fd0fdc'),
  (x'405edd3c07fb4c93'),
  (x'4028b0fcd32f7076'),
  (x'3ff3c0ca428c59f8'),
  (x'3e60000000000000'),
  (x'c352bd2668e077c4'),
  (x'434018601510c000'),
  (x'43d055dc36f24000'),
  (x'43e052961c6f8000'),
  (x'3ff3c0ca2a5b1d5d'),
  (x'4830f0cf064dd592'),
  (x'4840f0cf064dd592'),
  (x'4850f0cf064dd592'),
  (x'3ff3333333333333'),
  (x'3ff3ae147ae147ae'),
  (x'3ff3be76c8b43958'),
  (x'3ff3c083126e978d'),
  (x'3ff3c0c1fc8f3238'),
  (x'3ff3c0c9539b8887'),
  (x'3ff3c0ca2a5b1d5d'),
  (x'3ff3c0ca4283de1b'),
  (x'3ff3c0ca43db770a'),
  (x'3ff3c0ca428abd53'),
  (x'3ff3c0ca428c1d2b'),
  (x'3ff3c0ca428c51f2'),
  (x'3ff3c0ca428c58fc'),
  (x'3ff3c0ca428c59dd'),
  (x'3ff3c0ca428c59f8'),
  (x'3ff3c0ca428c59fb'),
  (x'40112e0be8047a7d'),
  (x'40112e0be815a889'),
  (x'40112e0be826d695'),
  (x'40112e0be83804a1'),
  (x'40112e0be84932ad'),
  (x'0040000000000000'),
  (x'007fffffffffffff'),
  (x'0290000000000000'),
  (x'029fffffffffffff'),
  (x'4350000000000000'),
  (x'435fffffffffffff'),
  (x'1330000000000000'),
  (x'133fffffffffffff'),
  (x'3a6fa7161a4d6e0c')
)
select float8send(flt) as ibits,
       flt,
       flt::text::float8 as r_flt,
       float8send(flt::text::float8) as obits,
       float8send(flt::text::float8) = float8send(flt) as correct
  from (select bits::bigint::xfloat8::float8 as flt
          from testdata
	offset 0) s

-- sqlfmt-corpus-separator --

PREPARE foo AS
  SELECT id, keywords, title, body, created
  FROM articles
  GROUP BY id

-- sqlfmt-corpus-separator --

WITH foo AS (SELECT * FROM gtest1) SELECT * FROM foo

-- sqlfmt-corpus-separator --

select sum(t2.b) over (partition by t2.a),
       sum(t2.c) over (partition by t2.a),
       sum(t2.d) over (partition by t2.a)
from gtest32 as t1 left join gtest32 as t2 on (t1.a = t2.a)
order by t1.a

-- sqlfmt-corpus-separator --

select a, b, sum(c), sum(sum(c)) over (order by a,b) as rsum
  from gstest2 group by rollup (a,b) order by rsum, a, b

-- sqlfmt-corpus-separator --

select a, b, sum(c), sum(sum(c)) over (order by a,b) as rsum
  from gstest2 group by cube (a,b) order by rsum, a, b

-- sqlfmt-corpus-separator --

select ten, sum(distinct four) filter (where four::text ~ '123') from onek a
group by rollup(ten)

-- sqlfmt-corpus-separator --

select distinct a, b, c
from (values (1, 2, 3), (4, null, 6), (7, 8, 9)) as t (a, b, c)
group by rollup(a, b), rollup(a, c)
order by a, b, c

-- sqlfmt-corpus-separator --

SELECT v as value, hashchar(v)::bit(32) as standard,
       hashcharextended(v, 0)::bit(32) as extended0,
       hashcharextended(v, 1)::bit(32) as extended1
FROM   (VALUES (NULL::"char"), ('1'), ('x'), ('X'), ('p'), ('N')) x(v)
WHERE  hashchar(v)::bit(32) != hashcharextended(v, 0)::bit(32)
       OR hashchar(v)::bit(32) = hashcharextended(v, 1)::bit(32)

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT * from hash_split_heap WHERE keycol = 1

-- sqlfmt-corpus-separator --

SELECT * FROM INT2_TBL AS f(a, b)

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

SELECT t1.a, t2.e
  FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)
  WHERE t1.a = t2.d

-- sqlfmt-corpus-separator --

SELECT ii, tt, kk
  FROM (J1_TBL CROSS JOIN J2_TBL)
    AS tx (ii, jj, tt, ii2, kk)

-- sqlfmt-corpus-separator --

SELECT tx.ii, tx.jj, tx.kk
  FROM (J1_TBL t1 (a, b, c) CROSS JOIN J2_TBL t2 (d, e))
    AS tx (ii, jj, tt, ii2, kk)

-- sqlfmt-corpus-separator --

SELECT * FROM (int8_tbl i cross join int4_tbl j) ss(a,b,c,d)

-- sqlfmt-corpus-separator --

SELECT json_agg(q ORDER BY x, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT json_agg(q ORDER BY x NULLS FIRST, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(q ORDER BY x, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(q ORDER BY x NULLS FIRST, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg_unique(i, null) OVER (ORDER BY i)
  FROM generate_series(1, 10) g(i)

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg_unique_strict(i, null) OVER (ORDER BY i)
  FROM generate_series(1, 10) g(i)

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg(DISTINCT 'a', 'abc')

-- sqlfmt-corpus-separator --

SELECT count(distinct j) FROM testjsonb

-- sqlfmt-corpus-separator --

SELECT distinct * FROM (values (jsonb '{}' || ''::text),('{}')) v(j)

-- sqlfmt-corpus-separator --

SELECT ''::text AS three, unique1, unique2, stringu1
		FROM onek WHERE unique1 > 100
		ORDER BY unique1 LIMIT 3 OFFSET 20

-- sqlfmt-corpus-separator --

SELECT ''::text AS zero, unique1, unique2, stringu1
		FROM onek WHERE unique1 < 50
		ORDER BY unique1 DESC LIMIT 8 OFFSET 99

-- sqlfmt-corpus-separator --

SELECT ''::text AS eleven, unique1, unique2, stringu1
		FROM onek WHERE unique1 < 50
		ORDER BY unique1 DESC LIMIT 20 OFFSET 39

-- sqlfmt-corpus-separator --

SELECT ''::text AS ten, unique1, unique2, stringu1
		FROM onek
		ORDER BY unique1 OFFSET 990

-- sqlfmt-corpus-separator --

SELECT ''::text AS five, unique1, unique2, stringu1
		FROM onek
		ORDER BY unique1 OFFSET 990 LIMIT 5

-- sqlfmt-corpus-separator --

SELECT ''::text AS five, unique1, unique2, stringu1
		FROM onek
		ORDER BY unique1 LIMIT 5 OFFSET 900

-- sqlfmt-corpus-separator --

select * from int8_tbl offset (case when random() < 0.5 then null::bigint end)

-- sqlfmt-corpus-separator --

declare c1 cursor for select * from int8_tbl limit 10

-- sqlfmt-corpus-separator --

declare c2 cursor for select * from int8_tbl limit 3

-- sqlfmt-corpus-separator --

declare c3 cursor for select * from int8_tbl offset 3

-- sqlfmt-corpus-separator --

declare c4 cursor for select * from int8_tbl offset 10

-- sqlfmt-corpus-separator --

declare c5 cursor for select * from int8_tbl order by q1 fetch first 2 rows with ties

-- sqlfmt-corpus-separator --

SELECT unique1 FROM tenk1 t0
WHERE unique1 < 3
  AND EXISTS (
	SELECT 1 FROM tenk1 t1
	INNER JOIN tenk1 t2 ON t1.unique1 = t2.hundred
	WHERE t0.ten = t1.twenty AND t0.two <> t2.four OFFSET 0)

-- sqlfmt-corpus-separator --

SELECT DISTINCT hobbies_r.name, name(hobbies_r.equipment) FROM hobbies_r
  ORDER BY 1,2

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
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('-7.777'),('1e340'),('-1e340'),
         ('inf'),('-inf'),('nan'),
         ('inf'),('-inf'),('nan'))
SELECT substring(x::text, 1, 32)
FROM v ORDER BY x

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

WITH v(x) AS
  (VALUES('0'::numeric),('1'),('2'),('4.2'),('inf'),('nan'))
SELECT x1, x2,
  power(x1, x2)
FROM v AS v1(x1), v AS v2(x2) WHERE x1 != 0 OR x2 >= 0

-- sqlfmt-corpus-separator --

WITH v(val) AS
  (VALUES('0'::numeric),('-4.2'),('4.2e9'),('1.2e-5'),('inf'),('-inf'),('nan'))
SELECT val,
  to_char(val, '9.999EEEE') as numeric,
  to_char(val::float8, '9.999EEEE') as float8,
  to_char(val::float4, '9.999EEEE') as float4
FROM v

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
  to_char(val, 'MI9999999999.99') as numeric,
  to_char(val::float8, 'MI9999999999.99') as float8,
  to_char(val::float4, 'MI9999999999.99') as float4
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

WITH rows AS
  (SELECT i, to_char(i, 'RN') AS roman FROM generate_series(1, 3999) AS i)
SELECT
  bool_and(to_number(roman, 'RN') = i) as valid
FROM rows

-- sqlfmt-corpus-separator --

WITH t(b, p, bc_result) AS (VALUES
(0.12, -2829.8369, 58463948950011752465280493160293790845494328939320966633018493248607815580903065923369555885857984675501574162389726507612128133630191173383130639968378879506624785786843501848666498440326970769604109017960864573408272864266102690849952650095786874354625921641729880352858506454246180842452983243549491658464046163869265572232996388827878976066830374513768599285647145439771472435206769249126377164951470622827631950210853282324510655982757098065657709137845327135766013147354253426364240746381620690117663724329288646510198895137275207992825719846135857839292915100523542874885080351683587865157015032404901182924720371819942957083390475846809517968191151435281268695782594904484795360890092607679215675240583291240729468370895035823777914792823688291214492607109455017754453939895630226174304357121900605689015734289765672740769194115142607443713769825894380064727556869268488695795705030158832909348803019429370973064732712469794182891757241046263341655894972953512257981661670321890336672832647028099324621932563236459127918144141230217523147304565594514812518826936144181257723061181656522095236928347413997136815409159361412494284201481609684892562646522086577634100783077813105675590737823924220663206479031113753135119759722725207724879578900186075841393115040465401462266086907464970054073340036852442184414587772177753008511913377364966775792477387717262694468450099866775550614257191941835797445874557362115814601886902749237439492398087966544817154173072811937702110580330775581851211123491341435883319798273456296794954514173820352334127081705706502510709179711510240917772628308487366740741280043704807717608366220401933596364641284631036907635403895053036499618723044314773148779735006542501244942039455169872946018271985844759209768927953340447524637670938413827595013338859796135512187473850161303598087634723542727044978083220970836296653305188470017342167913572166172051819741354902582606590658382067039498769674611071582171914886494269818475850690414812481252963932223686078322390396586222238852602472958831686564971334200490182175112490433364675164900946902818404704835106260174052265784055642968397240262737313737007322288203637798365320295080314524864099419556398713380156353062937736280885716820226469419928595465390700629307079710611273715705695938635644841913194091407807776191951797748706106000922803167645881087385311847268311361092838264814899353459146959869764278464187826798546290981492648723002412475976344071283321798061003719251864595518596639432393032991023409676558943539937377229130132816883146259468718344018277257037013406135980469482324577407154032999045733141275895.3432),
(1.2, 32908.8896, 58463467728170833376633133695001863276259293590926929026251227859007891876739460057725441400966420577009060860805883032969522911803372870882799865787473726926215148161529632590083389287080925059682489116446754279752928005457087175157581627230586554364417068189211136840990661174760199073702207450133797324318403866058202372178813998850887986769280847189341565507156189065295823921162851958925352114220880236114784962150135485415106748467247897246441194126125699204912883449386043559785865023459356275014504597646990160571664166410683323036984805434677654413174177920726210827006973855410386789516533036723888687725436216478665958434776205940192130053647653715221076841771578099896259902368829351569726536927952661429685419815305418450230567773264738536471211804481206474781470237730069753206249915908804615495060673071058534441654604668770343616386612119048579369195201590008082689834456232255266932976831478404670192731621439902738547169253818323045451045749609624500171633897705543164388470746657118050314064066768449450440405619135824055131398727045420324382226572368236570500391463795989258779677208133531636928003546809249007993065200108076924439703799231711400266122025052209803513232429907231051873161206025860851056337427740362763618748092029386371493898291580557004812947013231371383576580415676519066503391905962989205397824064923920045371823949776899815750413244195402085917098964452866825666226141169411712884994564949174271056284898570445214367063763956186792886147126466387576513166370247576466566827375268334148320298849218878848928271566491769458471357076035396330179659440244425914213309776100351793665960978678576150833311810944729586040624059867137538839913141142139636023129691775489034134511666020819676247950267220131499463010350308195762769192775344260909521732256844149916046793599150786757764962585268686580124987490115873389726527572428003433405659445349155536369077209682951123806333170190998931670309088422483075609203671527331975811507450670132060984691061148836994322505371265263690017938762760088575875666254883673433331627055180154954694693433502522592907190906966067656027637884202418119121728966267936832338377284832958974299187166554160783467156478554899314000348357280306042140481751668215838656488457943830180819301102535170705017482946779698265096226184239631924271857062033454725540956591929965181603262502135610768915716020374362368495244256420143645126927013882334008435586481691725030031204304273292938132599127402133470745819213047706793887965197191137237066440328777206799072470374264316425913530947082957300047105685634407092811630672103242089966046839626911122.7149))
SELECT b, p, bc_result, b^p AS power, b^p - bc_result AS diff FROM t

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

WITH t(x) AS (SELECT '1e-'||n FROM generate_series(1, 100) g(n))
SELECT x, log(x::numeric) FROM t

-- sqlfmt-corpus-separator --

WITH t(x) AS (SELECT '1e'||n FROM generate_series(1, 100) g(n))
SELECT x, log(x::numeric) FROM t

-- sqlfmt-corpus-separator --

PREPARE p1 AS SELECT $1a

-- sqlfmt-corpus-separator --

PREPARE p1 AS SELECT $0_1

-- sqlfmt-corpus-separator --

SELECT DISTINCT f1 AS two FROM TEMP_GROUP ORDER BY 1

-- sqlfmt-corpus-separator --

WITH objects (classid, objid, objsubid) AS (VALUES
    ('pg_class'::regclass, 0, 0), -- no relation
    ('pg_class'::regclass, 'pg_class'::regclass, 100), -- no column for relation
    ('pg_proc'::regclass, 0, 0), -- no function
    ('pg_type'::regclass, 0, 0), -- no type
    ('pg_cast'::regclass, 0, 0), -- no cast
    ('pg_collation'::regclass, 0, 0), -- no collation
    ('pg_constraint'::regclass, 0, 0), -- no constraint
    ('pg_conversion'::regclass, 0, 0), -- no conversion
    ('pg_attrdef'::regclass, 0, 0), -- no default attribute
    ('pg_language'::regclass, 0, 0), -- no language
    ('pg_largeobject'::regclass, 0, 0), -- no large object, no error
    ('pg_operator'::regclass, 0, 0), -- no operator
    ('pg_opclass'::regclass, 0, 0), -- no opclass, no need to check for no access method
    ('pg_opfamily'::regclass, 0, 0), -- no opfamily
    ('pg_am'::regclass, 0, 0), -- no access method
    ('pg_amop'::regclass, 0, 0), -- no AM operator
    ('pg_amproc'::regclass, 0, 0), -- no AM proc
    ('pg_rewrite'::regclass, 0, 0), -- no rewrite
    ('pg_trigger'::regclass, 0, 0), -- no trigger
    ('pg_namespace'::regclass, 0, 0), -- no schema
    ('pg_statistic_ext'::regclass, 0, 0), -- no statistics
    ('pg_ts_parser'::regclass, 0, 0), -- no TS parser
    ('pg_ts_dict'::regclass, 0, 0), -- no TS dictionary
    ('pg_ts_template'::regclass, 0, 0), -- no TS template
    ('pg_ts_config'::regclass, 0, 0), -- no TS configuration
    ('pg_authid'::regclass, 0, 0), -- no role
    ('pg_auth_members'::regclass, 0, 0),  -- no role membership
    ('pg_database'::regclass, 0, 0), -- no database
    ('pg_tablespace'::regclass, 0, 0), -- no tablespace
    ('pg_foreign_data_wrapper'::regclass, 0, 0), -- no FDW
    ('pg_foreign_server'::regclass, 0, 0), -- no server
    ('pg_user_mapping'::regclass, 0, 0), -- no user mapping
    ('pg_default_acl'::regclass, 0, 0), -- no default ACL
    ('pg_extension'::regclass, 0, 0), -- no extension
    ('pg_event_trigger'::regclass, 0, 0), -- no event trigger
    ('pg_parameter_acl'::regclass, 0, 0), -- no parameter ACL
    ('pg_policy'::regclass, 0, 0), -- no policy
    ('pg_propgraph_element'::regclass, 0, 0), -- no property graph element
    ('pg_propgraph_label'::regclass, 0, 0), -- no property graph label
    ('pg_propgraph_property'::regclass, 0, 0), -- no property graph property
    ('pg_publication'::regclass, 0, 0), -- no publication
    ('pg_publication_namespace'::regclass, 0, 0), -- no publication namespace
    ('pg_publication_rel'::regclass, 0, 0), -- no publication relation
    ('pg_subscription'::regclass, 0, 0), -- no subscription
    ('pg_transform'::regclass, 0, 0) -- no transformation
  )
SELECT ROW(pg_identify_object(objects.classid, objects.objid, objects.objsubid))
         AS ident,
       ROW(pg_identify_object_as_address(objects.classid, objects.objid, objects.objsubid))
         AS addr,
       pg_describe_object(objects.classid, objects.objid, objects.objsubid)
         AS descr
FROM objects
ORDER BY objects.classid, objects.objid, objects.objsubid

-- sqlfmt-corpus-separator --

SELECT DISTINCT (i || '000000000000' || j)::oid8 f
  FROM generate_series(1, 10) i,
       generate_series(1, 10) j,
       generate_series(1, 5) k
  WHERE i <= 10 AND j > 0 AND j <= 10
  ORDER BY f

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

SELECT DISTINCT p1.proargtypes[0]::regtype, p2.proargtypes[0]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    p1.prosrc NOT LIKE E'range\\_constructor_' AND
    p2.prosrc NOT LIKE E'range\\_constructor_' AND
    p1.prosrc NOT LIKE E'multirange\\_constructor_' AND
    p2.prosrc NOT LIKE E'multirange\\_constructor_' AND
    (p1.proargtypes[0] < p2.proargtypes[0])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[1]::regtype, p2.proargtypes[1]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    p1.prosrc NOT LIKE E'range\\_constructor_' AND
    p2.prosrc NOT LIKE E'range\\_constructor_' AND
    p1.prosrc NOT LIKE E'multirange\\_constructor_' AND
    p2.prosrc NOT LIKE E'multirange\\_constructor_' AND
    (p1.proargtypes[1] < p2.proargtypes[1])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[2]::regtype, p2.proargtypes[2]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    (p1.proargtypes[2] < p2.proargtypes[2])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[3]::regtype, p2.proargtypes[3]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    (p1.proargtypes[3] < p2.proargtypes[3])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[4]::regtype, p2.proargtypes[4]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    (p1.proargtypes[4] < p2.proargtypes[4])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[5]::regtype, p2.proargtypes[5]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    (p1.proargtypes[5] < p2.proargtypes[5])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[6]::regtype, p2.proargtypes[6]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    (p1.proargtypes[6] < p2.proargtypes[6])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[7]::regtype, p2.proargtypes[7]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    (p1.proargtypes[7] < p2.proargtypes[7])
ORDER BY 1, 2

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

SELECT DISTINCT amopmethod, amopstrategy, oprname
FROM pg_amop a1 LEFT JOIN pg_operator o1 ON amopopr = o1.oid
ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT a, sum(b), array_agg(distinct c), count(*) FROM pagg_tab_ml GROUP BY a HAVING avg(b) < 3 ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

prepare ab_q6 as
select * from (
	select tableoid::regclass,a,b from ab
union all
	select tableoid::regclass,x,y from xy_1
union all
	select tableoid::regclass,a,b from ab
) ab where a = $1 and b = (select -10)

-- sqlfmt-corpus-separator --

prepare ps1 as
  select * from mc3p where a = $1 and abs(b) < (select 3)

-- sqlfmt-corpus-separator --

prepare ps2 as
  select * from mc3p where a <= $1 and abs(b) < (select 3)

-- sqlfmt-corpus-separator --

SELECT DISTINCT (i || '/' || j)::pg_lsn f
  FROM generate_series(1, 10) i,
       generate_series(1, 10) j,
       generate_series(1, 5) k
  WHERE i <= 10 AND j > 0 AND j <= 10
  ORDER BY f

-- sqlfmt-corpus-separator --

prepare p1 as select f1 from abc

-- sqlfmt-corpus-separator --

prepare p2 as select nextval('seq')

-- sqlfmt-corpus-separator --

select first_el_agg_f8(x::float8) over(order by x) from generate_series(1,10) x

-- sqlfmt-corpus-separator --

select first_el_agg_any(x) over(order by x) from generate_series(1,10) x

-- sqlfmt-corpus-separator --

select distinct array_ndims(histogram_bounds) from pg_stats
where histogram_bounds is not null

-- sqlfmt-corpus-separator --

declare c1 cursor for select count_tt1_v(), count_tt1_s()

-- sqlfmt-corpus-separator --

DECLARE c1 CURSOR FOR SELECT * FROM uctest a, uctest b WHERE a.f1 = b.f1 + 5

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT f1,count(*) FROM uctest GROUP BY f1

-- sqlfmt-corpus-separator --

declare c cursor for select * from int8_tbl limit nochange(3)

-- sqlfmt-corpus-separator --

declare local_portal cursor for select * from toasted_data

-- sqlfmt-corpus-separator --

prepare q as select array_to_string(array_agg(repeat('x',2*n)),E'\n') as "ab

c", array_to_string(array_agg(repeat('y',20-2*n)),E'\n') as "a
bc" from generate_series(1,10) as n(n) group by n>1 order by n>1

-- sqlfmt-corpus-separator --

prepare q as select repeat('x',2*n) as "0123456789abcdef", repeat('y',20-2*n) as "0123456789" from generate_series(1,10) as n

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE r < 0 OR r >= 1) AS out_of_range,
       (count(*) FILTER (WHERE r < 0.01)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 0.99)) > 0 AS has_large
FROM (SELECT random() r FROM generate_series(1, 2000)) ss

-- sqlfmt-corpus-separator --

SELECT (count(*) FILTER (WHERE r < -2104533975)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 2104533974)) > 0 AS has_large
FROM (SELECT random(-2147483648, 2147483647) r FROM generate_series(1, 2000)) ss

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE r < -1500000000 OR r > 1500000000) AS out_of_range,
       (count(*) FILTER (WHERE r < -1470000000)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 1470000000)) > 0 AS has_large
FROM (SELECT random(-1500000000, 1500000000) r FROM generate_series(1, 2000)) ss

-- sqlfmt-corpus-separator --

SELECT (count(*) FILTER (WHERE r < -9038904596117680292)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 9038904596117680291)) > 0 AS has_large
FROM (SELECT random(-9223372036854775808, 9223372036854775807) r
      FROM generate_series(1, 2000)) ss

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE r < -1500000000000000 OR r > 1500000000000000) AS out_of_range,
       (count(*) FILTER (WHERE r < -1470000000000000)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 1470000000000000)) > 0 AS has_large
FROM (SELECT random(-1500000000000000, 1500000000000000) r
      FROM generate_series(1, 2000)) ss

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE r < -1.5 OR r > 1.5) AS out_of_range,
       (count(*) FILTER (WHERE r < -1.47)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 1.47)) > 0 AS has_large
FROM (SELECT random(-1.500000000000000, 1.500000000000000) r
      FROM generate_series(1, 2000)) ss

-- sqlfmt-corpus-separator --

prepare q as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare r as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare s as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare t as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare u as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare v as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

select row_to_json(i) from int8_tbl i(x,y)

-- sqlfmt-corpus-separator --

SELECT DISTINCT four FROM tenk1

-- sqlfmt-corpus-separator --

SELECT DISTINCT four FROM tenk1 WHERE four = 0

-- sqlfmt-corpus-separator --

SELECT DISTINCT four FROM tenk1 WHERE four = 0 AND two <> 0

-- sqlfmt-corpus-separator --

SELECT DISTINCT four,1,2,3 FROM tenk1 WHERE four = 0

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, x FROM distinct_tbl

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, x FROM (SELECT * FROM distinct_tbl ORDER BY x) s

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, x FROM distinct_tbl limit 10

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, x FROM distinct_tbl ORDER BY y

-- sqlfmt-corpus-separator --

select distinct on (1) floor(random()) as r, f1 from int4_tbl order by 1,2

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (four) four,two
   FROM tenk1 WHERE four = 0 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x) x, y FROM distinct_on_tbl

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x) x, y FROM (SELECT * FROM distinct_on_tbl ORDER BY x) s

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x) x, y FROM distinct_on_tbl ORDER BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x) x, y FROM (select * from distinct_on_tbl order by x, z, y) s ORDER BY y, x, z

-- sqlfmt-corpus-separator --

PREPARE data_sel AS SELECT generate_series(1,3)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAYAGG(i ORDER BY i DESC)
FROM generate_series(1, 5) i

-- sqlfmt-corpus-separator --

select count(distinct ss.ten) from
  (select ten from tenk1 a
   where unique1 IN (select hundred from tenk1 b)) ss

-- sqlfmt-corpus-separator --

select count(distinct ss.ten) from
  (select ten from tenk1 a
   where unique1 IN (select distinct hundred from tenk1 b)) ss

-- sqlfmt-corpus-separator --

with q as (select max(f1) from int4_tbl group by f1 order by f1)
  select q from q

-- sqlfmt-corpus-separator --

declare cur cursor for select left(a,10), b
  from (values(repeat('a', 512 * 1024),1),(repeat('b', 512),2)) v(a,b)
  order by v.a desc

-- sqlfmt-corpus-separator --

with contexts as (
  select * from pg_backend_memory_contexts
)
select count(*) > 1
from contexts c1, contexts c2
where c2.name = 'CacheMemoryContext'
and c1.path[c2.level] = c2.path[c2.level]

-- sqlfmt-corpus-separator --

select count(*) > 0 as ok, count(*) FILTER (WHERE error IS NOT NULL) = 0 AS no_err
  from pg_hba_file_rules

-- sqlfmt-corpus-separator --

select count(*) >= 0 as ok, count(*) FILTER (WHERE error IS NOT NULL) = 0 AS no_err
  from pg_ident_file_mappings

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_names

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_abbrevs

-- sqlfmt-corpus-separator --

select i, left('ahoj', i), right('ahoj', i) from generate_series(-5, 5) t(i) order by i

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR
SELECT ctid, * FROM tidscan WHERE ctid = ANY(ARRAY['(0,1)', '(0,2)']::tid[])

-- sqlfmt-corpus-separator --

SELECT count(d1) AS three, count(DISTINCT d1) AS two FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT count(d1) AS three, count(DISTINCT d1) AS two FROM TIMESTAMPTZ_TBL

-- sqlfmt-corpus-separator --

WITH tzs (tz) AS (VALUES
    ('+1'), ('+1:'), ('+1:0'), ('+100'), ('+1:00'), ('+01:00'),
    ('+10'), ('+1000'), ('+10:'), ('+10:0'), ('+10:00'), ('+10:00:'),
    ('+10:00:1'), ('+10:00:01'),
    ('+10:00:10'))
     SELECT make_timestamptz(2010, 2, 27, 3, 45, 00, tz), tz FROM tzs

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT unique2/0 FROM tenk1 ORDER BY unique2

-- sqlfmt-corpus-separator --

declare foo cursor for select * from trans_abc

-- sqlfmt-corpus-separator --

SELECT min(generate_series(1, 3)) OVER() FROM few

-- sqlfmt-corpus-separator --

SELECT id,lag(id) OVER(), count(*) OVER(), generate_series(1,3) FROM few

-- sqlfmt-corpus-separator --

SELECT SUM(count(*)) OVER(PARTITION BY generate_series(1,3) ORDER BY generate_series(1,3)), generate_series(1,3) g FROM few GROUP BY g

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a) a, b, generate_series(1,3) g
FROM (VALUES (3, 2), (3,1), (1,1), (1,4), (5,3), (5,1)) AS t(a, b)

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a) a, b, generate_series(1,3) g
FROM (VALUES (3, 2), (3,1), (1,1), (1,4), (5,3), (5,1)) AS t(a, b)
ORDER BY a, b DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a) a, b, generate_series(1,3) g
FROM (VALUES (3, 2), (3,1), (1,1), (1,4), (5,3), (5,1)) AS t(a, b)
ORDER BY a, b DESC, g DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a, b, g) a, b, generate_series(1,3) g
FROM (VALUES (3, 2), (3,1), (1,1), (1,4), (5,3), (5,1)) AS t(a, b)
ORDER BY a, b DESC, g DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (g) a, b, generate_series(1,3) g
FROM (VALUES (3, 2), (3,1), (1,1), (1,4), (5,3), (5,1)) AS t(a, b)

-- sqlfmt-corpus-separator --

SELECT a, generate_series(1,2) FROM (VALUES(1),(2),(3)) r(a) LIMIT 2 OFFSET 2

-- sqlfmt-corpus-separator --

SELECT (SELECT generate_series(1,3) LIMIT 1 OFFSET few.id) FROM few

-- sqlfmt-corpus-separator --

SELECT (SELECT generate_series(1,3) LIMIT 1 OFFSET g.i) FROM generate_series(0,3) g(i)

-- sqlfmt-corpus-separator --

SELECT abort_increasing, abort_decreasing FROM abbrev_abort_uuids ORDER BY abort_increasing OFFSET 20000 - 4

-- sqlfmt-corpus-separator --

SELECT abort_increasing, abort_decreasing FROM abbrev_abort_uuids ORDER BY abort_decreasing NULLS FIRST OFFSET 20000 - 4

-- sqlfmt-corpus-separator --

SELECT noabort_increasing, noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_increasing OFFSET 20000 - 4

-- sqlfmt-corpus-separator --

SELECT noabort_increasing, noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_decreasing NULLS FIRST OFFSET 20000 - 4

-- sqlfmt-corpus-separator --

SELECT LEFT(a,10),b FROM
    (VALUES(REPEAT('a', 512 * 1024),1),(REPEAT('b', 512 * 1024),2)) v(a,b)
ORDER BY v.a DESC

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, t1.typalign, t2.typname, t2.typalign
FROM pg_type as t1
     LEFT JOIN pg_range as r ON rngtypid = t1.oid
     LEFT JOIN pg_type as t2 ON rngsubtype = t2.oid
WHERE t1.typtype = 'r' AND
    (t1.typalign != (CASE WHEN t2.typalign = 'd' THEN 'd'::"char"
                          ELSE 'i'::"char" END)
     OR t2.oid IS NULL)

-- sqlfmt-corpus-separator --

SELECT DISTINCT typtype, typinput
FROM pg_type AS t1
WHERE t1.typtype not in ('b', 'p')
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT typtype, typoutput
FROM pg_type AS t1
WHERE t1.typtype not in ('b', 'd', 'p')
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT typtype, typreceive
FROM pg_type AS t1
WHERE t1.typtype not in ('b', 'p')
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT typtype, typsend
FROM pg_type AS t1
WHERE t1.typtype not in ('b', 'd', 'p')
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, t1.typalign, t2.typname, t2.typalign
FROM pg_type AS t1, pg_type AS t2
WHERE t1.typarray = t2.oid AND
    t2.typalign != (CASE WHEN t1.typalign = 'd' THEN 'd'::"char"
                         ELSE 'i'::"char" END)

-- sqlfmt-corpus-separator --

select distinct q1 from
  (select distinct * from int8_tbl i81
   union all
   select distinct * from int8_tbl i82) ss
where q2 = q2

-- sqlfmt-corpus-separator --

select distinct q1 from
  (select distinct * from int8_tbl i81
   union all
   select distinct * from int8_tbl i82) ss
where -q1 = q2

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT guid_field) FROM guid1

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY guid_field) FROM guid3

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY guid_encoded COLLATE "C") FROM guid3

-- sqlfmt-corpus-separator --

WITH uuidts AS (
    SELECT y, ts as ts, lag(ts) OVER (ORDER BY y) AS prev_ts
    FROM (SELECT y, uuid_extract_timestamp(uuidv7((y || ' years')::interval)) AS ts
        FROM generate_series(1970 - extract(year from now())::int, 10888 - extract(year from now())::int) y)
)
SELECT y, ts, prev_ts FROM uuidts WHERE ts < prev_ts

-- sqlfmt-corpus-separator --

SELECT depname, empno, salary, sum(salary) OVER (PARTITION BY depname) FROM empsalary ORDER BY depname, salary

-- sqlfmt-corpus-separator --

SELECT depname, empno, salary, rank() OVER (PARTITION BY depname ORDER BY salary) FROM empsalary

-- sqlfmt-corpus-separator --

SELECT four, ten, SUM(SUM(four)) OVER (PARTITION BY four), AVG(ten) FROM tenk1
GROUP BY four, ten ORDER BY four, ten

-- sqlfmt-corpus-separator --

SELECT COUNT(*) OVER () FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT sum(four) OVER (PARTITION BY ten ORDER BY unique2) AS sum_1, ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY unique2) FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY four ORDER BY ten) AS rank_1, ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT percent_rank() OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT cume_dist() OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT ntile(3) OVER (ORDER BY ten, four), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT ntile(NULL) OVER (ORDER BY ten, four), ten, four FROM tenk1 LIMIT 2

-- sqlfmt-corpus-separator --

SELECT lag(ten) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lag(ten, four) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lag(ten, four, 0) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lag(ten, four, 0.7) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10 ORDER BY four, ten

-- sqlfmt-corpus-separator --

SELECT lead(ten) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lead(ten * 2, 1) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lead(ten * 2, 1, -1) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lead(ten * 2, 1, -1.4) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10 ORDER BY four, ten

-- sqlfmt-corpus-separator --

SELECT first_value(ten) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT last_value(four) OVER (ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT last_value(ten) OVER (PARTITION BY four), ten, four FROM
	(SELECT * FROM tenk1 WHERE unique2 < 10 ORDER BY four, ten)s
	ORDER BY four, ten

-- sqlfmt-corpus-separator --

SELECT nth_value(ten, four + 1) OVER (PARTITION BY four), ten, four
	FROM (SELECT * FROM tenk1 WHERE unique2 < 10 ORDER BY four, ten)s

-- sqlfmt-corpus-separator --

SELECT ten, two, sum(hundred) AS gsum, sum(sum(hundred)) OVER (PARTITION BY two ORDER BY ten) AS wsum
FROM tenk1 GROUP BY ten, two

-- sqlfmt-corpus-separator --

SELECT count(*) OVER (PARTITION BY four), four FROM (SELECT * FROM tenk1 WHERE two = 1)s WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT avg(four) OVER (PARTITION BY four ORDER BY thousand / 100) FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT sum(salary),
	row_number() OVER (ORDER BY depname),
	sum(sum(salary)) OVER (ORDER BY depname DESC)
FROM empsalary GROUP BY depname

-- sqlfmt-corpus-separator --

SELECT lead(ten, (SELECT two FROM tenk1 WHERE s.unique2 = unique2)) OVER (PARTITION BY four ORDER BY ten)
FROM tenk1 s WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT count(*) OVER (PARTITION BY four) FROM (SELECT * FROM tenk1 WHERE FALSE)s

-- sqlfmt-corpus-separator --

SELECT empno, depname, salary, bonus, depadj, MIN(bonus) OVER (ORDER BY empno), MAX(depadj) OVER () FROM(
	SELECT *,
		CASE WHEN enroll_date < '2008-01-01' THEN 2008 - extract(YEAR FROM enroll_date) END * 500 AS bonus,
		CASE WHEN
			AVG(salary) OVER (PARTITION BY depname) < salary
		THEN 200 END AS depadj FROM empsalary
)s

-- sqlfmt-corpus-separator --

SELECT SUM(COUNT(f1)) OVER () FROM int4_tbl WHERE f1=42

-- sqlfmt-corpus-separator --

select ten,
  sum(unique1) + sum(unique2) as res,
  rank() over (order by sum(unique1) + sum(unique2)) as rank
from tenk1
group by ten order by ten

-- sqlfmt-corpus-separator --

select x, lag(x, 1) over (order by x), lead(x, 3) over (order by x)
from (select x::numeric as x from generate_series(1,10) x)

-- sqlfmt-corpus-separator --

SELECT four, ten,
	sum(ten) over (partition by four order by ten),
	last_value(ten) over (partition by four order by ten)
FROM (select distinct ten, four from tenk1) ss

-- sqlfmt-corpus-separator --

SELECT four, ten,
	sum(ten) over (partition by four order by ten range between unbounded preceding and current row),
	last_value(ten) over (partition by four order by ten range between unbounded preceding and current row)
FROM (select distinct ten, four from tenk1) ss

-- sqlfmt-corpus-separator --

SELECT four, ten,
	sum(ten) over (partition by four order by ten range between unbounded preceding and unbounded following),
	last_value(ten) over (partition by four order by ten range between unbounded preceding and unbounded following)
FROM (select distinct ten, four from tenk1) ss

-- sqlfmt-corpus-separator --

SELECT four, ten/4 as two,
	sum(ten/4) over (partition by four order by ten/4 range between unbounded preceding and current row),
	last_value(ten/4) over (partition by four order by ten/4 range between unbounded preceding and current row)
FROM (select distinct ten, four from tenk1) ss

-- sqlfmt-corpus-separator --

SELECT four, ten/4 as two,
	sum(ten/4) over (partition by four order by ten/4 rows between unbounded preceding and current row),
	last_value(ten/4) over (partition by four order by ten/4 rows between unbounded preceding and current row)
FROM (select distinct ten, four from tenk1) ss

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four range between current row and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between current row and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 2 preceding and 2 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 2 preceding and 1 preceding),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 1 following and 3 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between unbounded preceding and 1 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 9223372036854775807 following and 1 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (ORDER BY four groups between current row and 9223372036854775807 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (ORDER BY four groups between 9223372036854775807 following and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by salary range between 1000 preceding and 1000 following),
	lead(salary) over(order by salary range between 1000 preceding and 1000 following),
	nth_value(salary, 1) over(order by salary range between 1000 preceding and 1000 following),
	salary from empsalary

-- sqlfmt-corpus-separator --

select last_value(salary) over(order by salary range between 1000 preceding and 1000 following),
	lag(salary) over(order by salary range between 1000 preceding and 1000 following),
	salary from empsalary

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 1 preceding and 1 following),
       unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

select x, last_value(x) over (order by x::smallint range between current row and 2147450884 following)
from generate_series(32764, 32766) x

-- sqlfmt-corpus-separator --

select x, last_value(x) over (order by x::smallint desc range between current row and 2147450885 following)
from generate_series(-32766, -32764) x

-- sqlfmt-corpus-separator --

select x, last_value(x) over (order by x range between current row and 4 following)
from generate_series(2147483644, 2147483646) x

-- sqlfmt-corpus-separator --

select x, last_value(x) over (order by x desc range between current row and 5 following)
from generate_series(-2147483646, -2147483644) x

-- sqlfmt-corpus-separator --

select x, last_value(x) over (order by x range between current row and 4 following)
from generate_series(9223372036854775804, 9223372036854775806) x

-- sqlfmt-corpus-separator --

select x, last_value(x) over (order by x desc range between current row and 5 following)
from generate_series(-9223372036854775806, -9223372036854775804) x

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between unbounded preceding and current row),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between unbounded preceding and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between current row and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 1 preceding and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 1 following and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between unbounded preceding and 2 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 2 preceding and 1 preceding),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 2 preceding and 1 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (order by four groups between 0 preceding and 0 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (partition by ten
	order by four groups between 0 preceding and 0 following),unique1, four, ten
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by enroll_date groups between 1 preceding and 1 following),
	lead(salary) over(order by enroll_date groups between 1 preceding and 1 following),
	nth_value(salary, 1) over(order by enroll_date groups between 1 preceding and 1 following),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select last_value(salary) over(order by enroll_date groups between 1 preceding and 1 following),
	lag(salary) over(order by enroll_date groups between 1 preceding and 1 following),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

SELECT count(*) OVER (PARTITION BY four) FROM (SELECT * FROM tenk1 UNION ALL SELECT * FROM tenk2)s LIMIT 0

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1
                         range between 1 preceding and 1 following)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1 order by f2
                         range between 1 preceding and 1 following)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1, f1 order by f2
                         range between 2 preceding and 1 preceding)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1, f2 order by f2
                         range between 1 following and 2 following)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1
                         groups between 1 preceding and 1 following)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1 order by f2
                         groups between 1 preceding and 1 following)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1, f1 order by f2
                         groups between 2 preceding and 1 preceding)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

select f1, sum(f1) over (partition by f1, f2 order by f2
                         groups between 1 following and 2 following)
from t1 where f1 = f2

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY length('abc'))

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY rank() OVER (ORDER BY random()))

-- sqlfmt-corpus-separator --

SELECT * FROM empsalary WHERE row_number() OVER (ORDER BY salary) < 10

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY 1), count(*) FROM empsalary GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT count() OVER () FROM tenk1

-- sqlfmt-corpus-separator --

SELECT generate_series(1, 100) OVER () FROM empsalary

-- sqlfmt-corpus-separator --

SELECT ntile(0) OVER (ORDER BY ten), ten, four FROM tenk1

-- sqlfmt-corpus-separator --

SELECT nth_value(four, 0) OVER (ORDER BY ten), ten, four FROM tenk1

-- sqlfmt-corpus-separator --

SELECT sum(salary), row_number() OVER (ORDER BY depname), sum(
    sum(salary) FILTER (WHERE enroll_date > '2007-01-01')
) FILTER (WHERE depname <> 'sales') OVER (ORDER BY depname DESC) AS "filtered_sum",
    depname
FROM empsalary GROUP BY depname

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

SELECT nth_value_def(ten) OVER (PARTITION BY four), ten, four
  FROM (SELECT * FROM tenk1 WHERE unique2 < 10 ORDER BY four, ten) s

-- sqlfmt-corpus-separator --

SELECT i,AVG(v::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,AVG(v::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,AVG(v::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,AVG(v::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1.5),(2,2.5),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,AVG(v::interval) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,'1 sec'),(2,'2 sec'),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT  x
        ,avg(x) OVER(ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING ) as curr_next_avg
        ,avg(x) OVER(ROWS BETWEEN 1 PRECEDING AND CURRENT ROW ) as prev_curr_avg
        ,sum(x) OVER(ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING ) as curr_next_sum
        ,sum(x) OVER(ROWS BETWEEN 1 PRECEDING AND CURRENT ROW ) as prev_curr_sum
FROM (VALUES (NULL::interval),
               ('infinity'::interval),
               ('-2147483648 days -2147483648 months -9223372036854775807 usecs'), -- extreme interval value
               ('-infinity'::interval),
               ('2147483647 days 2147483647 months 9223372036854775806 usecs'), -- extreme interval value
               ('infinity'::interval),
               ('6 days'::interval),
               ('7 days'::interval),
               (NULL::interval),
               ('-infinity'::interval)) v(x)

-- sqlfmt-corpus-separator --

SELECT x, avg(x) OVER(ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM (VALUES (NULL::interval),
               ('3 days'::interval),
               ('infinity'::timestamptz - now()),
               ('6 days'::interval),
               ('-infinity'::interval)) v(x)

-- sqlfmt-corpus-separator --

SELECT x, sum(x) OVER(ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM (VALUES (NULL::interval),
               ('3 days'::interval),
               ('infinity'::timestamptz - now()),
               ('6 days'::interval),
               ('-infinity'::interval)) v(x)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::money) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,'1.10'),(2,'2.20'),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::interval) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,'1 sec'),(2,'2 sec'),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1.1),(2,2.2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT SUM(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1.01),(2,2),(3,3)) v(i,n)

-- sqlfmt-corpus-separator --

SELECT i,COUNT(v) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,COUNT(*) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT VAR_POP(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_POP(n::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_POP(n::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_POP(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_SAMP(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_SAMP(n::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_SAMP(n::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_SAMP(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VARIANCE(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VARIANCE(n::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VARIANCE(n::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VARIANCE(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_POP(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_POP(n::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_POP(n::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_POP(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_SAMP(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_SAMP(n::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_SAMP(n::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_SAMP(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(0,NULL),(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV(n::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(0,NULL),(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV(n::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(0,NULL),(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(0,NULL),(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::int) OVER (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,3),(4,4)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT a, b,
       SUM(b) OVER(ORDER BY A ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM (VALUES(1,1::numeric),(2,2),(3,'NaN'),(4,3),(5,4)) t(a,b)

-- sqlfmt-corpus-separator --

SELECT to_char(SUM(n::float8) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING),'999999999999999999999D9')
  FROM (VALUES(1,1e20),(2,1)) n(i,n)

-- sqlfmt-corpus-separator --

SELECT sum(orbit) OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT sum(orbit) RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT sum(orbit) IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT row_number() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT row_number() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT row_number() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT rank() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT rank() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT rank() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT dense_rank() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT dense_rank() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT percent_rank() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT percent_rank() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT percent_rank() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT cume_dist() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT cume_dist() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT cume_dist() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT ntile(1) OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT ntile(1) RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT ntile(1) IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

WITH q1(x,y) AS (SELECT 1,2)
SELECT * FROM q1, q1 AS q2

-- sqlfmt-corpus-separator --

WITH q AS (SELECT 'foo' AS x)
SELECT x, pg_typeof(x) FROM q

-- sqlfmt-corpus-separator --

WITH q1(x,y) AS (
    SELECT hundred, sum(ten) FROM tenk1 GROUP BY hundred
  )
SELECT count(*) FROM q1 WHERE y > (SELECT sum(y)/100 FROM q1 qsub)

-- sqlfmt-corpus-separator --

WITH x(n, b) AS (SELECT 1)
SELECT * FROM x

-- sqlfmt-corpus-separator --

with cte(foo) as ( select 42 ) select * from ((select foo from cte)) q

-- sqlfmt-corpus-separator --

select ( with cte(foo) as ( values(f1) )
         select (select foo from cte) )
from int4_tbl

-- sqlfmt-corpus-separator --

select f1, (with cte1(x,y) as (select 1,2)
            select count((select i4.f1 from cte1))) as ss
from int4_tbl i4

-- sqlfmt-corpus-separator --

with a as ( select id from (values (1), (2)) as v(id) ),
     b as ( select max((select sum(id) from a)) as agg )
select agg from b

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

with
A as ( select q2 as id, (select q1) as x from int8_tbl ),
B as ( select id, row_number() over (partition by id) as r from A ),
C as ( select A.id, array(select B.id from B where B.id = A.id) from A )
select * from C

-- sqlfmt-corpus-separator --

with ordinality as (select 1 as x) select * from ordinality

-- sqlfmt-corpus-separator --

prepare prep_stmt as select length(stringu1) from tenk1 group by length(stringu1)