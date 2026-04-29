DECLARE c CURSOR FOR
SELECT ctid, * FROM tidscan WHERE ctid = ANY(ARRAY['(0,1)', '(0,2)']::tid[])

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT * from hash_split_heap WHERE keycol = 1

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT ctid,cmin,* FROM combocidtest

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT f1,count(*) FROM uctest GROUP BY f1

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SELECT unique2/0 FROM tenk1 ORDER BY unique2

-- sqlfmt-corpus-separator --

DECLARE c1 CURSOR FOR SELECT * FROM uctest a, uctest b WHERE a.f1 = b.f1 + 5

-- sqlfmt-corpus-separator --

PREPARE data_sel AS SELECT generate_series(1,3)

-- sqlfmt-corpus-separator --

PREPARE foo AS
  SELECT id, keywords, title, body, created
  FROM articles
  GROUP BY id

-- sqlfmt-corpus-separator --

PREPARE p1 AS SELECT $0_1

-- sqlfmt-corpus-separator --

PREPARE p1 AS SELECT $1a

-- sqlfmt-corpus-separator --

PREPARE select1 AS SELECT 1 as a

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

SELECT (count(*) FILTER (WHERE r < -2104533975)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 2104533974)) > 0 AS has_large
FROM (SELECT random(-2147483648, 2147483647) r FROM generate_series(1, 2000)) ss

-- sqlfmt-corpus-separator --

SELECT (count(*) FILTER (WHERE r < -9038904596117680292)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 9038904596117680291)) > 0 AS has_large
FROM (SELECT random(-9223372036854775808, 9223372036854775807) r
      FROM generate_series(1, 2000)) ss

-- sqlfmt-corpus-separator --

SELECT * FROM empsalary WHERE row_number() OVER (ORDER BY salary) < 10

-- sqlfmt-corpus-separator --

SELECT COUNT(*) OVER () FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT COUNT(a), COUNT(1) FILTER(WHERE a=1) FROM heapmv

-- sqlfmt-corpus-separator --

SELECT COUNT(a), COUNT(1) FILTER(WHERE a=1) FROM heaptable

-- sqlfmt-corpus-separator --

SELECT DISTINCT (i || '/' || j)::pg_lsn f
  FROM generate_series(1, 10) i,
       generate_series(1, 10) j,
       generate_series(1, 5) k
  WHERE i <= 10 AND j > 0 AND j <= 10
  ORDER BY f

-- sqlfmt-corpus-separator --

SELECT DISTINCT (i || '000000000000' || j)::oid8 f
  FROM generate_series(1, 10) i,
       generate_series(1, 10) j,
       generate_series(1, 5) k
  WHERE i <= 10 AND j > 0 AND j <= 10
  ORDER BY f

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

SELECT DISTINCT ON (four) four,two
   FROM tenk1 WHERE four = 0 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (g) a, b, generate_series(1,3) g
FROM (VALUES (3, 2), (3,1), (1,1), (1,4), (5,3), (5,1)) AS t(a, b)

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x) x, y FROM (SELECT * FROM distinct_on_tbl ORDER BY x) s

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x) x, y FROM (select * from distinct_on_tbl order by x, z, y) s ORDER BY y, x, z

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x) x, y FROM distinct_on_tbl

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y, x) x, y FROM distinct_on_tbl ORDER BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT amopmethod, amopstrategy, oprname
FROM pg_amop a1 LEFT JOIN pg_operator o1 ON amopopr = o1.oid
ORDER BY 1, 2, 3

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

SELECT DISTINCT x FROM test3bpci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT x FROM test3ci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT x FROM test3cs ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, x FROM (SELECT * FROM distinct_tbl ORDER BY x) s

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, x FROM distinct_tbl

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, x FROM distinct_tbl ORDER BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, x FROM distinct_tbl limit 10

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAYAGG(i ORDER BY i DESC)
FROM generate_series(1, 5) i

-- sqlfmt-corpus-separator --

SELECT LEFT(a,10),b FROM
    (VALUES(REPEAT('a', 512 * 1024),1),(REPEAT('b', 512 * 1024),2)) v(a,b)
ORDER BY v.a DESC

-- sqlfmt-corpus-separator --

SELECT STDDEV(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(0,NULL),(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV(n::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(0,NULL),(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(0,NULL),(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV(n::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(0,NULL),(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_POP(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_POP(n::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_POP(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_POP(n::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_SAMP(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_SAMP(n::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_SAMP(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT STDDEV_SAMP(n::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT SUM(COUNT(f1)) OVER () FROM int4_tbl WHERE f1=42

-- sqlfmt-corpus-separator --

SELECT SUM(count(*)) OVER(PARTITION BY generate_series(1,3) ORDER BY generate_series(1,3)), generate_series(1,3) g FROM few GROUP BY g

-- sqlfmt-corpus-separator --

SELECT SUM(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1.01),(2,2),(3,3)) v(i,n)

-- sqlfmt-corpus-separator --

SELECT VARIANCE(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VARIANCE(n::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VARIANCE(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VARIANCE(n::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_POP(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_POP(n::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_POP(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_POP(n::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_SAMP(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_SAMP(n::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_SAMP(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT VAR_SAMP(n::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n)

-- sqlfmt-corpus-separator --

SELECT a,
       stddev(cast((SELECT sum(1) FROM generate_series(1,20) x) AS float4))
          OVER (PARTITION BY a,b,c ORDER BY b)
       AS z
FROM t1

-- sqlfmt-corpus-separator --

SELECT a, b,
       SUM(b) OVER(ORDER BY A ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM (VALUES(1,1::numeric),(2,2),(3,'NaN'),(4,3),(5,4)) t(a,b)

-- sqlfmt-corpus-separator --

SELECT a, sum(b), array_agg(distinct c), count(*) FROM pagg_tab_ml GROUP BY a HAVING avg(b) < 3 ORDER BY 1, 2, 3

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

SELECT array_agg(x COLLATE "C" ORDER BY y COLLATE "POSIX") FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT avg(c1.f ORDER BY c1.x, c1.y)
FROM group_agg_pk c1 JOIN group_agg_pk c2 ON c1.x = c2.x
GROUP BY c1.w, c1.z

-- sqlfmt-corpus-separator --

SELECT avg(four) OVER (PARTITION BY four ORDER BY thousand / 100) FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT count() OVER () FROM tenk1

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE r < -1.5 OR r > 1.5) AS out_of_range,
       (count(*) FILTER (WHERE r < -1.47)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 1.47)) > 0 AS has_large
FROM (SELECT random(-1.500000000000000, 1.500000000000000) r
      FROM generate_series(1, 2000)) ss

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE r < -1500000000 OR r > 1500000000) AS out_of_range,
       (count(*) FILTER (WHERE r < -1470000000)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 1470000000)) > 0 AS has_large
FROM (SELECT random(-1500000000, 1500000000) r FROM generate_series(1, 2000)) ss

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE r < -1500000000000000 OR r > 1500000000000000) AS out_of_range,
       (count(*) FILTER (WHERE r < -1470000000000000)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 1470000000000000)) > 0 AS has_large
FROM (SELECT random(-1500000000000000, 1500000000000000) r
      FROM generate_series(1, 2000)) ss

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE r < 0 OR r >= 1) AS out_of_range,
       (count(*) FILTER (WHERE r < 0.01)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 0.99)) > 0 AS has_large
FROM (SELECT random() r FROM generate_series(1, 2000)) ss

-- sqlfmt-corpus-separator --

SELECT count(*) OVER (PARTITION BY four) FROM (SELECT * FROM tenk1 UNION ALL SELECT * FROM tenk2)s LIMIT 0

-- sqlfmt-corpus-separator --

SELECT count(*) OVER (PARTITION BY four) FROM (SELECT * FROM tenk1 WHERE FALSE)s

-- sqlfmt-corpus-separator --

SELECT count(*) OVER (PARTITION BY four), four FROM (SELECT * FROM tenk1 WHERE two = 1)s WHERE unique2 < 10

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

SELECT count(d1) AS three, count(DISTINCT d1) AS two FROM TIMESTAMPTZ_TBL

-- sqlfmt-corpus-separator --

SELECT count(d1) AS three, count(DISTINCT d1) AS two FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT count(distinct j) FROM testjsonb

-- sqlfmt-corpus-separator --

SELECT cume_dist() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT cume_dist() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT cume_dist() OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT cume_dist() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT dense_rank() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT dense_rank() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT depname, empno, salary, rank() OVER (PARTITION BY depname ORDER BY salary) FROM empsalary

-- sqlfmt-corpus-separator --

SELECT depname, empno, salary, sum(salary) OVER (PARTITION BY depname) FROM empsalary ORDER BY depname, salary

-- sqlfmt-corpus-separator --

SELECT distinct * FROM (values (jsonb '{}' || ''::text),('{}')) v(j)

-- sqlfmt-corpus-separator --

SELECT empno, depname, salary, bonus, depadj, MIN(bonus) OVER (ORDER BY empno), MAX(depadj) OVER () FROM(
	SELECT *,
		CASE WHEN enroll_date < '2008-01-01' THEN 2008 - extract(YEAR FROM enroll_date) END * 500 AS bonus,
		CASE WHEN
			AVG(salary) OVER (PARTITION BY depname) < salary
		THEN 200 END AS depadj FROM empsalary
)s

-- sqlfmt-corpus-separator --

SELECT first_value(ten) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

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

SELECT four, ten,
	sum(ten) over (partition by four order by ten),
	last_value(ten) over (partition by four order by ten)
FROM (select distinct ten, four from tenk1) ss

-- sqlfmt-corpus-separator --

SELECT four, ten, SUM(SUM(four)) OVER (PARTITION BY four), AVG(ten) FROM tenk1
GROUP BY four, ten ORDER BY four, ten

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

SELECT generate_series(1, 100) OVER () FROM empsalary

-- sqlfmt-corpus-separator --

SELECT i,AVG(v::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,AVG(v::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,AVG(v::interval) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,'1 sec'),(2,'2 sec'),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,AVG(v::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1.5),(2,2.5),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,AVG(v::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,COUNT(*) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,COUNT(v) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::int) OVER (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,3),(4,4)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::int) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::interval) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,'1 sec'),(2,'2 sec'),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::money) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,'1.10'),(2,'2.20'),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1.1),(2,2.2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT i,SUM(v::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v)

-- sqlfmt-corpus-separator --

SELECT id,lag(id) OVER(), count(*) OVER(), generate_series(1,3) FROM few

-- sqlfmt-corpus-separator --

SELECT json_agg(q ORDER BY x NULLS FIRST, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT json_agg(q ORDER BY x, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(q ORDER BY x NULLS FIRST, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(q ORDER BY x, y)
  FROM rows q

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg(DISTINCT 'a', 'abc')

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg_unique(i, null) OVER (ORDER BY i)
  FROM generate_series(1, 10) g(i)

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg_unique_strict(i, null) OVER (ORDER BY i)
  FROM generate_series(1, 10) g(i)

-- sqlfmt-corpus-separator --

SELECT lag(ten) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lag(ten, four) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lag(ten, four, 0) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT lag(ten, four, 0.7) OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10 ORDER BY four, ten

-- sqlfmt-corpus-separator --

SELECT last_value(four) OVER (ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT last_value(ten) OVER (PARTITION BY four), ten, four FROM
	(SELECT * FROM tenk1 WHERE unique2 < 10 ORDER BY four, ten)s
	ORDER BY four, ten

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

SELECT min(generate_series(1, 3)) OVER() FROM few

-- sqlfmt-corpus-separator --

SELECT min(x ORDER BY y) FROM (VALUES(1, 2)) AS d(x,y)

-- sqlfmt-corpus-separator --

SELECT min(x ORDER BY y) FROM (VALUES(1, NULL)) AS d(x,y)

-- sqlfmt-corpus-separator --

SELECT nth_value(four, 0) OVER (ORDER BY ten), ten, four FROM tenk1

-- sqlfmt-corpus-separator --

SELECT nth_value(ten, four + 1) OVER (PARTITION BY four), ten, four
	FROM (SELECT * FROM tenk1 WHERE unique2 < 10 ORDER BY four, ten)s

-- sqlfmt-corpus-separator --

SELECT nth_value_def(ten) OVER (PARTITION BY four), ten, four
  FROM (SELECT * FROM tenk1 WHERE unique2 < 10 ORDER BY four, ten) s

-- sqlfmt-corpus-separator --

SELECT ntile(0) OVER (ORDER BY ten), ten, four FROM tenk1

-- sqlfmt-corpus-separator --

SELECT ntile(1) IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT ntile(1) OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT ntile(1) RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT ntile(3) OVER (ORDER BY ten, four), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT ntile(NULL) OVER (ORDER BY ten, four), ten, four FROM tenk1 LIMIT 2

-- sqlfmt-corpus-separator --

SELECT percent_rank() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT percent_rank() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT percent_rank() OVER (PARTITION BY four ORDER BY ten), ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT percent_rank() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT rank() IGNORE NULLS OVER () FROM planets

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

SELECT rank() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT row_number() IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT row_number() OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY unique2) FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT row_number() RESPECT NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT set('t')

-- sqlfmt-corpus-separator --

SELECT sum(four) OVER (PARTITION BY ten ORDER BY unique2) AS sum_1, ten, four FROM tenk1 WHERE unique2 < 10

-- sqlfmt-corpus-separator --

SELECT sum(orbit) IGNORE NULLS OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT sum(orbit) OVER () FROM planets

-- sqlfmt-corpus-separator --

SELECT sum(orbit) RESPECT NULLS OVER () FROM planets

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

SELECT sum(unique1) over (ORDER BY four groups between 9223372036854775807 following and unbounded following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (ORDER BY four groups between current row and 9223372036854775807 following),
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

SELECT sum(unique1) over (order by four range between current row and unbounded following),
	unique1, four
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

SELECT sum(unique1) over (rows between 2 preceding and 2 following),
	unique1, four
FROM tenk1 WHERE unique1 < 10

-- sqlfmt-corpus-separator --

SELECT sum(unique1) over (rows between 9223372036854775807 following and 1 following),
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

SELECT ten, two, sum(hundred) AS gsum, sum(sum(hundred)) OVER (PARTITION BY two ORDER BY ten) AS wsum
FROM tenk1 GROUP BY ten, two

-- sqlfmt-corpus-separator --

SELECT to_char(SUM(n::float8) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING),'999999999999999999999D9')
  FROM (VALUES(1,1e20),(2,1)) n(i,n)

-- sqlfmt-corpus-separator --

SELECT x, avg(x) OVER(ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM (VALUES (NULL::interval),
               ('3 days'::interval),
               ('infinity'::timestamptz - now()),
               ('6 days'::interval),
               ('-infinity'::interval)) v(x)

-- sqlfmt-corpus-separator --

SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3bpci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3ci ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3cs ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x, sum(x) OVER(ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
FROM (VALUES (NULL::interval),
               ('3 days'::interval),
               ('infinity'::timestamptz - now()),
               ('6 days'::interval),
               ('-infinity'::interval)) v(x)

-- sqlfmt-corpus-separator --

declare c cursor for select * from int8_tbl limit nochange(3)

-- sqlfmt-corpus-separator --

declare c1 cursor for select * from int8_tbl limit 10

-- sqlfmt-corpus-separator --

declare c1 cursor for select count_tt1_v(), count_tt1_s()

-- sqlfmt-corpus-separator --

declare c2 cursor for select * from int8_tbl limit 3

-- sqlfmt-corpus-separator --

declare c3 cursor for select * from int8_tbl offset 3

-- sqlfmt-corpus-separator --

declare c4 cursor for select * from int8_tbl offset 10

-- sqlfmt-corpus-separator --

declare c5 cursor for select * from int8_tbl order by q1 fetch first 2 rows with ties

-- sqlfmt-corpus-separator --

declare cur cursor for select left(a,10), b
  from (values(repeat('a', 512 * 1024),1),(repeat('b', 512),2)) v(a,b)
  order by v.a desc

-- sqlfmt-corpus-separator --

declare foo cursor for select * from trans_abc

-- sqlfmt-corpus-separator --

declare local_portal cursor for select * from toasted_data

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

prepare int8_query as select * from int8_tbl i8

-- sqlfmt-corpus-separator --

prepare p1 as select f1 from abc

-- sqlfmt-corpus-separator --

prepare p2 as select nextval('seq')

-- sqlfmt-corpus-separator --

prepare prep_stmt as select length(stringu1) from tenk1 group by length(stringu1)

-- sqlfmt-corpus-separator --

prepare ps1 as
  select * from mc3p where a = $1 and abs(b) < (select 3)

-- sqlfmt-corpus-separator --

prepare ps2 as
  select * from mc3p where a <= $1 and abs(b) < (select 3)

-- sqlfmt-corpus-separator --

prepare q as select array_to_string(array_agg(repeat('x',2*n)),E'\n') as "ab

c", array_to_string(array_agg(repeat('y',20-2*n)),E'\n') as "a
bc" from generate_series(1,10) as n(n) group by n>1 order by n>1

-- sqlfmt-corpus-separator --

prepare q as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare q as select repeat('x',2*n) as "0123456789abcdef", repeat('y',20-2*n) as "0123456789" from generate_series(1,10) as n

-- sqlfmt-corpus-separator --

prepare r as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare s as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare s1 as select $1::pos_int = 10 as "is_ten"

-- sqlfmt-corpus-separator --

prepare t as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare u as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

prepare v as select current_user, * from rls_f()

-- sqlfmt-corpus-separator --

select
    string_agg(distinct 'a', ','),
    sum((
        select sum(1)
        from (values(1)) b(id)
        where a.id = b.id
)) from unnest(array[1]) a(id)

-- sqlfmt-corpus-separator --

select
  (select max((select i.unique2 from tenk1 i where i.unique1 = o.unique1))
     filter (where o.unique1 < 10))
from tenk1 o

-- sqlfmt-corpus-separator --

select (select count(*) filter (where outer_c <> 0)
        from (values (1)) t0(inner_c))
from (values (2),(3)) t1(outer_c)

-- sqlfmt-corpus-separator --

select (select count(inner_c) filter (where outer_c <> 0)
        from (values (1)) t0(inner_c))
from (values (2),(3)) t1(outer_c)

-- sqlfmt-corpus-separator --

select (select max(0) filter (where b1)) from bool_test

-- sqlfmt-corpus-separator --

select (select max(unique1) filter (where bool_or(ten > 0)) from int8_tbl) from tenk1

-- sqlfmt-corpus-separator --

select (select max(unique1) filter (where sum(ten) > 0) from int8_tbl) from tenk1

-- sqlfmt-corpus-separator --

select a, b, sum(c), sum(sum(c)) over (order by a,b) as rsum
  from gstest2 group by cube (a,b) order by rsum, a, b

-- sqlfmt-corpus-separator --

select a, b, sum(c), sum(sum(c)) over (order by a,b) as rsum
  from gstest2 group by rollup (a,b) order by rsum, a, b

-- sqlfmt-corpus-separator --

select aggfns(distinct a,a,c order by a)
  from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
       generate_series(1,2) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,a,c order by a,b)
  from (values (1,1,'foo')) v(a,b,c), generate_series(1,2) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c order by a,b+1)
  from (values (1,1,'foo')) v(a,b,c), generate_series(1,2) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c order by a,b,i,c)
  from (values (1,1,'foo')) v(a,b,c), generate_series(1,2) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c order by b)
  from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
       generate_series(1,3) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c order by i)
  from (values (1,1,'foo')) v(a,b,c), generate_series(1,2) i

-- sqlfmt-corpus-separator --

select aggfns(distinct a,b,c)
  from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
       generate_series(1,3) i

-- sqlfmt-corpus-separator --

select aggfstr(distinct a,b,c order by b)
  from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
       generate_series(1,3) i

-- sqlfmt-corpus-separator --

select aggfstr(distinct a,b,c)
  from (values (1,3,'foo'),(0,null,null),(2,2,'bar'),(3,1,'baz')) v(a,b,c),
       generate_series(1,3) i

-- sqlfmt-corpus-separator --

select any_value(v) filter (where v > 2) from (values (1), (2), (3)) as v (v)

-- sqlfmt-corpus-separator --

select array_agg(a order by a desc)
  from (values (1,4),(2,3),(3,1),(4,2)) v(a,b)

-- sqlfmt-corpus-separator --

select array_agg(a order by a)
  from (values (1,4),(2,3),(3,1),(4,2)) v(a,b)

-- sqlfmt-corpus-separator --

select array_agg(a order by b)
  from (values (1,4),(2,3),(3,1),(4,2)) v(a,b)

-- sqlfmt-corpus-separator --

select array_agg(b order by a desc)
  from (values (1,4),(2,3),(3,1),(4,2)) v(a,b)

-- sqlfmt-corpus-separator --

select array_agg(distinct a order by a desc nulls last)
  from (values (1),(2),(1),(3),(null),(2)) v(a)

-- sqlfmt-corpus-separator --

select array_agg(distinct a order by a desc)
  from (values (1),(2),(1),(3),(null),(2)) v(a)

-- sqlfmt-corpus-separator --

select array_agg(distinct a order by a)
  from (values (1),(2),(1),(3),(null),(2)) v(a)

-- sqlfmt-corpus-separator --

select array_agg(distinct a)
  from (values (1),(2),(1),(3),(null),(2)) v(a)

-- sqlfmt-corpus-separator --

select array_agg(distinct ar order by ar desc)
  from (select array[i / 2] from generate_series(1,10) a(i)) b(ar)

-- sqlfmt-corpus-separator --

select array_agg(distinct val)
from (select null as val from generate_series(1, 2))

-- sqlfmt-corpus-separator --

select count(*) > 0 as ok, count(*) FILTER (WHERE error IS NOT NULL) = 0 AS no_err
  from pg_hba_file_rules

-- sqlfmt-corpus-separator --

select count(*) >= 0 as ok, count(*) FILTER (WHERE error IS NOT NULL) = 0 AS no_err
  from pg_ident_file_mappings

-- sqlfmt-corpus-separator --

select count(distinct ss.ten) from
  (select ten from tenk1 a
   where unique1 IN (select distinct hundred from tenk1 b)) ss

-- sqlfmt-corpus-separator --

select count(distinct ss.ten) from
  (select ten from tenk1 a
   where unique1 IN (select hundred from tenk1 b)) ss

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_abbrevs

-- sqlfmt-corpus-separator --

select count(distinct utc_offset) >= 24 as ok from pg_timezone_names

-- sqlfmt-corpus-separator --

select distinct a, b, c
from (values (1, 2, 3), (4, null, 6), (7, 8, 9)) as t (a, b, c)
group by rollup(a, b), rollup(a, c)
order by a, b, c

-- sqlfmt-corpus-separator --

select distinct array_ndims(histogram_bounds) from pg_stats
where histogram_bounds is not null

-- sqlfmt-corpus-separator --

select distinct from pg_database

-- sqlfmt-corpus-separator --

select distinct hundred from tenk1 where hundred in (47, 48, 72, 82)

-- sqlfmt-corpus-separator --

select distinct hundred from tenk1 where hundred in (47, 48, 72, 82) order by hundred desc

-- sqlfmt-corpus-separator --

select distinct max(unique2) from tenk1

-- sqlfmt-corpus-separator --

select distinct min(f1), max(f1) from minmaxtest

-- sqlfmt-corpus-separator --

select distinct on (1) floor(random()) as r, f1 from int4_tbl order by 1,2

-- sqlfmt-corpus-separator --

select distinct on (foobar) * from pg_database

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

-- sqlfmt-corpus-separator --

select f1, (select distinct min(t1.f1) from int4_tbl t1 where t1.f1 = t0.f1)
from int4_tbl t0

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

select first_el_agg_any(x) over(order by x) from generate_series(1,10) x

-- sqlfmt-corpus-separator --

select first_el_agg_f8(x::float8) over(order by x) from generate_series(1,10) x

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by enroll_date groups between 1 preceding and 1 following),
	lead(salary) over(order by enroll_date groups between 1 preceding and 1 following),
	nth_value(salary, 1) over(order by enroll_date groups between 1 preceding and 1 following),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select first_value(salary) over(order by salary range between 1000 preceding and 1000 following),
	lead(salary) over(order by salary range between 1000 preceding and 1000 following),
	nth_value(salary, 1) over(order by salary range between 1000 preceding and 1000 following),
	salary from empsalary

-- sqlfmt-corpus-separator --

select i, left('ahoj', i), right('ahoj', i) from generate_series(-5, 5) t(i) order by i

-- sqlfmt-corpus-separator --

select last_value(salary) over(order by enroll_date groups between 1 preceding and 1 following),
	lag(salary) over(order by enroll_date groups between 1 preceding and 1 following),
	salary, enroll_date from empsalary

-- sqlfmt-corpus-separator --

select last_value(salary) over(order by salary range between 1000 preceding and 1000 following),
	lag(salary) over(order by salary range between 1000 preceding and 1000 following),
	salary from empsalary

-- sqlfmt-corpus-separator --

select max(0) filter (where b1) from bool_test

-- sqlfmt-corpus-separator --

select max(foo COLLATE "C") filter (where (bar collate "POSIX") > '0')
from (values ('a', 'b')) AS v(foo,bar)

-- sqlfmt-corpus-separator --

select max(unique1) filter (where bool_or(ten > 0)) from tenk1

-- sqlfmt-corpus-separator --

select max(unique1) filter (where sum(ten) > 0) from tenk1

-- sqlfmt-corpus-separator --

select min(unique1) filter (where unique1 > 100) from tenk1

-- sqlfmt-corpus-separator --

select my_avg(distinct one),my_sum(distinct one) from (values(1),(3),(1)) t(one)

-- sqlfmt-corpus-separator --

select my_avg(distinct one),my_sum(one) from (values(1),(3)) t(one)

-- sqlfmt-corpus-separator --

select my_avg(one) filter (where one > 1),my_sum(one) from (values(1),(3)) t(one)

-- sqlfmt-corpus-separator --

select string_agg(distinct f1, ',' order by f1) from varchar_tbl

-- sqlfmt-corpus-separator --

select string_agg(distinct f1, ',' order by f1::text) from varchar_tbl

-- sqlfmt-corpus-separator --

select string_agg(distinct f1::text, ',' order by f1) from varchar_tbl

-- sqlfmt-corpus-separator --

select string_agg(distinct f1::text, ',' order by f1::text) from varchar_tbl

-- sqlfmt-corpus-separator --

select sum(1/ten) filter (where ten > 0) from tenk1

-- sqlfmt-corpus-separator --

select sum(t2.b) over (partition by t2.a),
       sum(t2.c) over (partition by t2.a),
       sum(t2.d) over (partition by t2.a)
from gtest32 as t1 left join gtest32 as t2 on (t1.a = t2.a)
order by t1.a

-- sqlfmt-corpus-separator --

select sum(unique1) FILTER (WHERE
  unique1 IN (SELECT unique1 FROM onek where unique1 < 100)) FROM tenk1

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

select ten, sum(distinct four) filter (where four > 10) from onek a
group by ten
having exists (select 1 from onek b where sum(distinct a.four) = b.four)

-- sqlfmt-corpus-separator --

select ten, sum(distinct four) filter (where four::text ~ '123') from onek a
group by rollup(ten)

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

select x, lag(x, 1) over (order by x), lead(x, 3) over (order by x)
from (select x::numeric as x from generate_series(1,10) x)

-- sqlfmt-corpus-separator --

select x, last_value(x) over (order by x desc range between current row and 5 following)
from generate_series(-2147483646, -2147483644) x

-- sqlfmt-corpus-separator --

select x, last_value(x) over (order by x desc range between current row and 5 following)
from generate_series(-9223372036854775806, -9223372036854775804) x

-- sqlfmt-corpus-separator --

select x, last_value(x) over (order by x range between current row and 4 following)
from generate_series(2147483644, 2147483646) x

-- sqlfmt-corpus-separator --

select x, last_value(x) over (order by x range between current row and 4 following)
from generate_series(9223372036854775804, 9223372036854775806) x

-- sqlfmt-corpus-separator --

select x, last_value(x) over (order by x::smallint desc range between current row and 2147450885 following)
from generate_series(-32766, -32764) x

-- sqlfmt-corpus-separator --

select x, last_value(x) over (order by x::smallint range between current row and 2147450884 following)
from generate_series(32764, 32766) x