(((((select * from int8_tbl)))))

-- sqlfmt-corpus-separator --

/* Columns aa, bb, xx value NULL, ee */
SELECT * FROM inhx

-- sqlfmt-corpus-separator --

/* Empty set since LIKE inherits structure only */
SELECT * FROM ctlb

-- sqlfmt-corpus-separator --

/* Has ee entry */
SELECT * FROM ctla

-- sqlfmt-corpus-separator --

/* fails due to constraint */
SELECT * FROM inhg

-- sqlfmt-corpus-separator --

SELECT  b & '00:00:00:ff:ff:ff' FROM macaddr8_data

-- sqlfmt-corpus-separator --

SELECT  b & '00:00:00:ff:ff:ff' FROM macaddr_data

-- sqlfmt-corpus-separator --

SELECT  b | '01:02:03:04:05:06' FROM macaddr8_data

-- sqlfmt-corpus-separator --

SELECT  b | '01:02:03:04:05:06' FROM macaddr_data

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

SELECT  interval '0'                       AS "zero",
        interval '1-2' year to month       AS "year-month",
        interval '1 2:03:04' day to second AS "day-time",
        - interval '1-2'                   AS "negative year-month",
        - interval '1 2:03:04'             AS "negative day-time"

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
		ORDER BY thousand FETCH FIRST 2 ROW ONLY

-- sqlfmt-corpus-separator --

SELECT  thousand
		FROM onek WHERE thousand < 5
		ORDER BY thousand FETCH FIRST 2 ROW WITH TIES

-- sqlfmt-corpus-separator --

SELECT  thousand
		FROM onek WHERE thousand < 5
		ORDER BY thousand FETCH FIRST ROWS WITH TIES

-- sqlfmt-corpus-separator --

SELECT '''w'':4A,3B,2C,1D,5 a:8'

-- sqlfmt-corpus-separator --

SELECT 'after error' AS noshow

-- sqlfmt-corpus-separator --

SELECT 'before multi-line' AS fourth

-- sqlfmt-corpus-separator --

SELECT 'first line'
' - next line'
	' - third line'
	AS "Three lines to one"

-- sqlfmt-corpus-separator --

SELECT 'ok' AS "done"

-- sqlfmt-corpus-separator --

SELECT 'trailing' AS first

-- sqlfmt-corpus-separator --

SELECT 'unknown' || ' and unknown' AS "Concat unknown types"

-- sqlfmt-corpus-separator --

SELECT 'val5', 'val6'

-- sqlfmt-corpus-separator --

SELECT (2 + 2) / 2 AS two

-- sqlfmt-corpus-separator --

SELECT *
  FROM J1_TBL AS t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT *
  FROM J1_TBL AS tx

-- sqlfmt-corpus-separator --

SELECT *
  FROM J1_TBL t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT *
  FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)

-- sqlfmt-corpus-separator --

SELECT *
  FROM J1_TBL tx

-- sqlfmt-corpus-separator --

SELECT *
FROM pg_cast c
WHERE castsource = casttarget AND castfunc = 0

-- sqlfmt-corpus-separator --

SELECT *
FROM stats_import.pg_stats_stable
WHERE schemaname = 'stats_import'
AND tablename = 'test'
AND inherited = false
AND attname = 'arange'

-- sqlfmt-corpus-separator --

SELECT *
FROM stats_import.pg_stats_stable
WHERE schemaname = 'stats_import'
AND tablename = 'test'
AND inherited = false
AND attname = 'id'

-- sqlfmt-corpus-separator --

SELECT *
FROM stats_import.pg_stats_stable
WHERE schemaname = 'stats_import'
AND tablename = 'test'
AND inherited = false
AND attname = 'tags'

-- sqlfmt-corpus-separator --

SELECT * FROM BIT_TABLE

-- sqlfmt-corpus-separator --

SELECT * FROM BOX_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM CASE_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM CHAR_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM CHECK_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM CIRCLE_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM COPY_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM DEFAULTEXPR_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM DEFAULT_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM FKTABLE

-- sqlfmt-corpus-separator --

SELECT * FROM FKTABLE ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM FLOAT4_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM FLOAT4_TBL ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM FLOAT8_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM FLOAT8_TBL ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM INSERT_CHILD

-- sqlfmt-corpus-separator --

SELECT * FROM INSERT_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM INT2_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM INT2_TBL AS f(a, b)

-- sqlfmt-corpus-separator --

SELECT * FROM INT4_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE 123 < q1

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE 123 <= q1

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE 123 <> q1

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE 123 = q1

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE 123 > q1

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE 123 >= q1

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 < 456

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 < 4567890123456789

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 <= 456

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 <= 4567890123456789

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 <> 456

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 <> 4567890123456789

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 = 456

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 = 4567890123456789

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 > 456

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 > 4567890123456789

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 >= 456

-- sqlfmt-corpus-separator --

SELECT * FROM INT8_TBL WHERE q2 >= 4567890123456789

-- sqlfmt-corpus-separator --

SELECT * FROM INTERVAL_TBL

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

SELECT * FROM NAME_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM NE_CHECK_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM OID8_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM OID_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM ONLY base_tbl_parent ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM ONLY measurement ORDER BY city_id, logdate

-- sqlfmt-corpus-separator --

SELECT * FROM ONLY rw_view1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM PKTABLE

-- sqlfmt-corpus-separator --

SELECT * FROM POINT_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM POLYGON_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM PRIMARY_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM SUBSELECT_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM T

-- sqlfmt-corpus-separator --

SELECT * FROM T ORDER BY c_bigint, c_text, pk LIMIT 10

-- sqlfmt-corpus-separator --

SELECT * FROM T ORDER BY pk

-- sqlfmt-corpus-separator --

SELECT * FROM T WHERE c_bigint > -1 ORDER BY c_bigint, c_text, pk LIMIT 10

-- sqlfmt-corpus-separator --

SELECT * FROM TEXT_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM TIMESTAMPTZ_TST ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM UNIQUE_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM VARBIT_TABLE

-- sqlfmt-corpus-separator --

SELECT * FROM VARCHAR_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM ac_test

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i && '{17}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i && '{32,17}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i && '{32}' AND t @> '{AAAAAAA80240}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i && '{32}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i && '{NULL}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i && '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i <@ '{38,34,32,89}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i <@ '{NULL}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i <@ '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i = '{47,77}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i = '{NULL}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i = '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i @> '{17}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i @> '{32,17}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i @> '{32}' AND t && '{AAAAAAA80240}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i @> '{32}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i @> '{NULL}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE i @> '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t && '{AAAAAAA80240}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t && '{AAAAAAAA72908,AAAAAAAAAA646}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t && '{AAAAAAAA72908}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t && '{AAAAAAAAAA646}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t && '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t <@ '{AAAAAAAA72908,AAAAAAAAAAAAAAAAAAA17075,AA88409,AAAAAAAAAAAAAAAAAA36842,AAAAAAA48038,AAAAAAAAAAAAAA10611}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t <@ '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t = '{AAAAAAAAAA646,A87088}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t = '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAA80240}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAAA72908,AAAAAAAAAA646}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAAA72908}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAAAAA646}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_index_op_test WHERE t @> '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i && '{17}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i && '{32,17}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i && '{32}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i && '{NULL}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i && '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i <@ '{38,34,32,89}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i <@ '{NULL}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i <@ '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i = '{NULL}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i = '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i @> '{17}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i @> '{32,17}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i @> '{32}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i @> '{NULL}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE i @> '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE t && '{AAAAAAAA72908,AAAAAAAAAA646}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE t && '{AAAAAAAA72908}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE t && '{AAAAAAAAAA646}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE t && '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE t <@ '{AAAAAAAA72908,AAAAAAAAAAAAAAAAAAA17075,AA88409,AAAAAAAAAAAAAAAAAA36842,AAAAAAA48038,AAAAAAAAAAAAAA10611}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE t <@ '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE t = '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE t @> '{AAAAAAAA72908,AAAAAAAAAA646}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE t @> '{AAAAAAAA72908}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE t @> '{AAAAAAAAAA646}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM array_op_test WHERE t @> '{}' ORDER BY seqno

-- sqlfmt-corpus-separator --

SELECT * FROM arrtest

-- sqlfmt-corpus-separator --

SELECT * FROM arrtest_s

-- sqlfmt-corpus-separator --

SELECT * FROM as_select1

-- sqlfmt-corpus-separator --

SELECT * FROM atest1

-- sqlfmt-corpus-separator --

SELECT * FROM atest1, atest5

-- sqlfmt-corpus-separator --

SELECT * FROM atest2

-- sqlfmt-corpus-separator --

SELECT * FROM atest3

-- sqlfmt-corpus-separator --

SELECT * FROM atest5

-- sqlfmt-corpus-separator --

SELECT * FROM atest6

-- sqlfmt-corpus-separator --

SELECT * FROM atestv0

-- sqlfmt-corpus-separator --

SELECT * FROM atestv1

-- sqlfmt-corpus-separator --

SELECT * FROM atestv2

-- sqlfmt-corpus-separator --

SELECT * FROM atestv3

-- sqlfmt-corpus-separator --

SELECT * FROM atestv4

-- sqlfmt-corpus-separator --

SELECT * FROM attmp

-- sqlfmt-corpus-separator --

SELECT * FROM attmp_new

-- sqlfmt-corpus-separator --

SELECT * FROM attmp_new2

-- sqlfmt-corpus-separator --

SELECT * FROM b1

-- sqlfmt-corpus-separator --

SELECT * FROM base_tbl

-- sqlfmt-corpus-separator --

SELECT * FROM base_tbl ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM base_tbl ORDER BY a, b

-- sqlfmt-corpus-separator --

SELECT * FROM base_tbl_child ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM bla ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM box_temp WHERE f1 && '(15,20),(25,30)'

-- sqlfmt-corpus-separator --

SELECT * FROM box_temp WHERE f1 &< '(10,4.333334),(5,100)'

-- sqlfmt-corpus-separator --

SELECT * FROM box_temp WHERE f1 &<| '(10,4.3333334),(5,1)'

-- sqlfmt-corpus-separator --

SELECT * FROM box_temp WHERE f1 &> '(40,30),(45,50)'

-- sqlfmt-corpus-separator --

SELECT * FROM box_temp WHERE f1 << '(10,20),(30,40)'

-- sqlfmt-corpus-separator --

SELECT * FROM box_temp WHERE f1 <<| '(10,4.33334),(5,100)'

-- sqlfmt-corpus-separator --

SELECT * FROM box_temp WHERE f1 <@ '(10,15),(30,35)'

-- sqlfmt-corpus-separator --

SELECT * FROM box_temp WHERE f1 >> '(30,40),(40,30)'

-- sqlfmt-corpus-separator --

SELECT * FROM box_temp WHERE f1 @> '(10,11),(15,16)'

-- sqlfmt-corpus-separator --

SELECT * FROM box_temp WHERE f1 |&> '(49.99,49.99),(49.99,49.99)'

-- sqlfmt-corpus-separator --

SELECT * FROM box_temp WHERE f1 |>> '(37,38),(39,40)'

-- sqlfmt-corpus-separator --

SELECT * FROM box_temp WHERE f1 ~= '(20,20),(40,40)'

-- sqlfmt-corpus-separator --

SELECT * FROM brintest_3 WHERE b < '0'

-- sqlfmt-corpus-separator --

SELECT * FROM bug18634t

-- sqlfmt-corpus-separator --

SELECT * FROM bug6051

-- sqlfmt-corpus-separator --

SELECT * FROM bug6051_2

-- sqlfmt-corpus-separator --

SELECT * FROM bug6051_3

-- sqlfmt-corpus-separator --

SELECT * FROM category

-- sqlfmt-corpus-separator --

SELECT * FROM check_ign_err2

-- sqlfmt-corpus-separator --

SELECT * FROM cj_target

-- sqlfmt-corpus-separator --

SELECT * FROM clstr_1

-- sqlfmt-corpus-separator --

SELECT * FROM clstr_expression WHERE -a = -3 ORDER BY -a, b

-- sqlfmt-corpus-separator --

SELECT * FROM clustertest

-- sqlfmt-corpus-separator --

SELECT * FROM coll_t

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 WHERE b >= 'bbc'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 WHERE b ~ '^abc$'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 WHERE b ~ '^abc'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 WHERE b ~ 'bc'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 WHERE b ~* '^abc$'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 WHERE b ~* '^abc'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test1 WHERE b ~* 'bc'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test2 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test2 WHERE b >= 'bbc'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test3 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test3 WHERE b >= 'BBC'

-- sqlfmt-corpus-separator --

SELECT * FROM collate_test3 WHERE b >= 'bbc'

-- sqlfmt-corpus-separator --

SELECT * FROM cp_test

-- sqlfmt-corpus-separator --

SELECT * FROM created_table

-- sqlfmt-corpus-separator --

SELECT * FROM ctas_nodata

-- sqlfmt-corpus-separator --

SELECT * FROM ctas_nodata_2

-- sqlfmt-corpus-separator --

SELECT * FROM ctas_nodata_3

-- sqlfmt-corpus-separator --

SELECT * FROM ctas_nodata_4

-- sqlfmt-corpus-separator --

SELECT * FROM current_check

-- sqlfmt-corpus-separator --

SELECT * FROM customers

-- sqlfmt-corpus-separator --

SELECT * FROM customers_us_redacted

-- sqlfmt-corpus-separator --

SELECT * FROM customers_view

-- sqlfmt-corpus-separator --

SELECT * FROM default_test

-- sqlfmt-corpus-separator --

SELECT * FROM deferred_excl

-- sqlfmt-corpus-separator --

SELECT * FROM document

-- sqlfmt-corpus-separator --

SELECT * FROM document WHERE did = 13

-- sqlfmt-corpus-separator --

SELECT * FROM document WHERE did = 2

-- sqlfmt-corpus-separator --

SELECT * FROM document WHERE did = 4

-- sqlfmt-corpus-separator --

SELECT * FROM document WHERE did = 8

-- sqlfmt-corpus-separator --

SELECT * FROM dropped_objects WHERE object_type = 'schema'

-- sqlfmt-corpus-separator --

SELECT * FROM enumtest WHERE col < 'green' ORDER BY col

-- sqlfmt-corpus-separator --

SELECT * FROM enumtest WHERE col <= 'green' ORDER BY col

-- sqlfmt-corpus-separator --

SELECT * FROM enumtest WHERE col <> 'orange' ORDER BY col

-- sqlfmt-corpus-separator --

SELECT * FROM enumtest WHERE col = 'orange'

-- sqlfmt-corpus-separator --

SELECT * FROM enumtest WHERE col > 'yellow' ORDER BY col

-- sqlfmt-corpus-separator --

SELECT * FROM enumtest WHERE col >= 'yellow' ORDER BY col

-- sqlfmt-corpus-separator --

SELECT * FROM fewmore

-- sqlfmt-corpus-separator --

SELECT * FROM fk_partitioned_fk ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM fk_partitioned_fk WHERE a = 142857

-- sqlfmt-corpus-separator --

SELECT * FROM fk_partitioned_fk WHERE b = 142857

-- sqlfmt-corpus-separator --

SELECT * FROM fkpart9.fk

-- sqlfmt-corpus-separator --

SELECT * FROM fkpart9.pk

-- sqlfmt-corpus-separator --

SELECT * FROM foo

-- sqlfmt-corpus-separator --

SELECT * FROM foo ORDER BY f1

-- sqlfmt-corpus-separator --

SELECT * FROM foo ORDER BY f1 ASC

-- sqlfmt-corpus-separator --

SELECT * FROM foo ORDER BY f1 DESC

-- sqlfmt-corpus-separator --

SELECT * FROM foo ORDER BY f1 DESC NULLS LAST

-- sqlfmt-corpus-separator --

SELECT * FROM foo ORDER BY f1 NULLS FIRST

-- sqlfmt-corpus-separator --

SELECT * FROM foo_seq_new

-- sqlfmt-corpus-separator --

SELECT * FROM foochild

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test ORDER BY id, valid1_at, valid2_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test WHERE id = '[1,2)' ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test WHERE id = '[10,11)'

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test WHERE id = '[10,11)' ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test WHERE id = '[11,12)' ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test WHERE id = '[2,3)' ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test WHERE id = '[3,4)' ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test WHERE id = '[4,5)' ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test WHERE id = '[5,6)' ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test WHERE id = '[6,7)' ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test WHERE id = '[7,8)' ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test WHERE id = '[8,9)' ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test2 ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test2 WHERE id = '[1,2)' ORDER BY valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test2 WHERE id = '[2,3)' ORDER BY valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test2 WHERE id = 1 ORDER BY valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM for_portion_of_test2 WHERE id = 2 ORDER BY valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM fp_fk_subxact

-- sqlfmt-corpus-separator --

SELECT * FROM fract_only

-- sqlfmt-corpus-separator --

SELECT * FROM ft1

-- sqlfmt-corpus-separator --

SELECT * FROM gtest1

-- sqlfmt-corpus-separator --

SELECT * FROM gtest1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM gtest1_1

-- sqlfmt-corpus-separator --

SELECT * FROM gtest1v

-- sqlfmt-corpus-separator --

SELECT * FROM gtest2

-- sqlfmt-corpus-separator --

SELECT * FROM gtest22c WHERE a = 1 AND b > 0

-- sqlfmt-corpus-separator --

SELECT * FROM gtest22c WHERE b * 3 = 12

-- sqlfmt-corpus-separator --

SELECT * FROM gtest22c WHERE b * 3 = 6

-- sqlfmt-corpus-separator --

SELECT * FROM gtest22c WHERE b = 4

-- sqlfmt-corpus-separator --

SELECT * FROM gtest22c WHERE b = 8

-- sqlfmt-corpus-separator --

SELECT * FROM gtest25 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM gtest26 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM gtest29

-- sqlfmt-corpus-separator --

SELECT * FROM gtest3 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM gtest3a ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM gtest4

-- sqlfmt-corpus-separator --

SELECT * FROM gtest_rule

-- sqlfmt-corpus-separator --

SELECT * FROM gtest_rule_log

-- sqlfmt-corpus-separator --

SELECT * FROM gtest_tableoid

-- sqlfmt-corpus-separator --

SELECT * FROM gtest_varlena ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM gtestm ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM gtestnn_parent ORDER BY f1, f2, f3

-- sqlfmt-corpus-separator --

SELECT * FROM gtestx

-- sqlfmt-corpus-separator --

SELECT * FROM gtestx, gtest1 WHERE gtestx.y = gtest1.a

-- sqlfmt-corpus-separator --

SELECT * FROM hash_i4_heap
   WHERE hash_i4_heap.random = 66766766

-- sqlfmt-corpus-separator --

SELECT * FROM hash_i4_heap
   WHERE hash_i4_heap.random = 843938989

-- sqlfmt-corpus-separator --

SELECT * FROM hash_i4_heap
   WHERE seqno = 9999

-- sqlfmt-corpus-separator --

SELECT * FROM hat_data WHERE hat_name = 'h8'

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.foreign_data_wrapper_options
ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.foreign_data_wrapper_options ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.foreign_data_wrappers ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.foreign_server_options ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.foreign_servers ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.foreign_table_options ORDER BY 1, 2, 3, 4

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.foreign_tables ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.pg_edge_table_components ORDER BY property_graph_name, edge_table_alias, edge_end DESC, ordinal_position

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.pg_element_table_key_columns ORDER BY property_graph_name, element_table_alias, ordinal_position

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.pg_element_table_labels ORDER BY property_graph_name, element_table_alias, label_name

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.pg_element_table_properties ORDER BY property_graph_name, element_table_alias, property_name

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.pg_element_tables ORDER BY property_graph_name, element_table_alias

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.pg_label_properties ORDER BY property_graph_name, label_name, property_name

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.pg_labels ORDER BY property_graph_name, label_name

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.pg_property_data_types ORDER BY property_graph_name, property_name

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.property_graphs ORDER BY property_graph_name

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.user_mapping_options ORDER BY 1, 2, 3, 4

-- sqlfmt-corpus-separator --

SELECT * FROM inhe

-- sqlfmt-corpus-separator --

SELECT * FROM inhf

-- sqlfmt-corpus-separator --

SELECT * FROM itest1

-- sqlfmt-corpus-separator --

SELECT * FROM itest13

-- sqlfmt-corpus-separator --

SELECT * FROM itest15

-- sqlfmt-corpus-separator --

SELECT * FROM itest16

-- sqlfmt-corpus-separator --

SELECT * FROM itest2

-- sqlfmt-corpus-separator --

SELECT * FROM itest3

-- sqlfmt-corpus-separator --

SELECT * FROM itest4

-- sqlfmt-corpus-separator --

SELECT * FROM itest5

-- sqlfmt-corpus-separator --

SELECT * FROM itest6

-- sqlfmt-corpus-separator --

SELECT * FROM itest7

-- sqlfmt-corpus-separator --

SELECT * FROM itest7c

-- sqlfmt-corpus-separator --

SELECT * FROM itest8

-- sqlfmt-corpus-separator --

SELECT * FROM itestv10

-- sqlfmt-corpus-separator --

SELECT * FROM itestv11

-- sqlfmt-corpus-separator --

SELECT * FROM joinview

-- sqlfmt-corpus-separator --

SELECT * FROM list_parted

-- sqlfmt-corpus-separator --

SELECT * FROM m where k = 0

-- sqlfmt-corpus-separator --

SELECT * FROM m where k = 1

-- sqlfmt-corpus-separator --

SELECT * FROM m where k = 15

-- sqlfmt-corpus-separator --

SELECT * FROM macaddr8_data ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM macaddr_data

-- sqlfmt-corpus-separator --

SELECT * FROM main_table ORDER BY a, b

-- sqlfmt-corpus-separator --

SELECT * FROM money_data

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest1

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest2

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_boxmv ORDER BY id

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_mv_v

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_mv_v_2

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_mv_v_3

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_mv_v_4

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_tm ORDER BY type

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_tmm

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_tv ORDER BY type

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_tvm

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_tvm ORDER BY type

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_tvmm

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_tvvm

-- sqlfmt-corpus-separator --

SELECT * FROM mvtest_v

-- sqlfmt-corpus-separator --

SELECT * FROM myshop

-- sqlfmt-corpus-separator --

SELECT * FROM new_measurement ORDER BY city_id, logdate

-- sqlfmt-corpus-separator --

SELECT * FROM num_input_test

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE 4.0 <@ nmr

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr < '{[-1000.0, -1000.0]}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr < '{[0.0, 1.0]}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr < '{[1000.0, 1001.0]}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr < '{}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr <= '{[3,)}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr <= '{}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr <> '{(,5)}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr <> '{}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr = '{(,5)}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr = '{[1.7,1.7],[1.9,2.1)}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr = '{[1.7,1.7]}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr = '{[3,)}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr = '{}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr > '{[-1000.0, -1000.0]}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr > '{[0.0, 1.0]}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr > '{[1000.0, 1001.0]}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr > '{}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr >= '{[3,)}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr >= '{}'

-- sqlfmt-corpus-separator --

SELECT * FROM nummultirange_test WHERE nmr @> 4.0

-- sqlfmt-corpus-separator --

SELECT * FROM numrange_test WHERE 1.9 <@ nr

-- sqlfmt-corpus-separator --

SELECT * FROM nums

-- sqlfmt-corpus-separator --

SELECT * FROM oer_test

-- sqlfmt-corpus-separator --

SELECT * FROM orders_view

-- sqlfmt-corpus-separator --

SELECT * FROM pa_target ORDER BY tid

-- sqlfmt-corpus-separator --

SELECT * FROM pa_target ORDER BY tid, val

-- sqlfmt-corpus-separator --

SELECT * FROM parent

-- sqlfmt-corpus-separator --

SELECT * FROM part_document ORDER BY did

-- sqlfmt-corpus-separator --

SELECT * FROM part_document ORDER by did

-- sqlfmt-corpus-separator --

SELECT * FROM part_document_satire ORDER by did

-- sqlfmt-corpus-separator --

SELECT * FROM partitions_merge_schema2.sales_feb_mar_apr2022 where sales_date > '2022-01-01'

-- sqlfmt-corpus-separator --

SELECT * FROM perform_test

-- sqlfmt-corpus-separator --

SELECT * FROM persons

-- sqlfmt-corpus-separator --

SELECT * FROM pg_enum WHERE NOT EXISTS
  (SELECT 1 FROM pg_type WHERE pg_type.oid = enumtypid)

-- sqlfmt-corpus-separator --

SELECT * FROM pg_indexes WHERE tablename = 'sales_feb_mar_apr2022' and schemaname = 'partitions_merge_schema2'

-- sqlfmt-corpus-separator --

SELECT * FROM pg_largeobject LIMIT 0

-- sqlfmt-corpus-separator --

SELECT * FROM pg_publication_tables

-- sqlfmt-corpus-separator --

SELECT * FROM pg_user_mapping

-- sqlfmt-corpus-separator --

SELECT * FROM point_tbl ORDER BY f1 <-> '0,1'

-- sqlfmt-corpus-separator --

SELECT * FROM pxtest1

-- sqlfmt-corpus-separator --

SELECT * FROM pxtest2

-- sqlfmt-corpus-separator --

SELECT * FROM pxtest3

-- sqlfmt-corpus-separator --

SELECT * FROM q5_prep_nodata

-- sqlfmt-corpus-separator --

SELECT * FROM q5_prep_results

-- sqlfmt-corpus-separator --

SELECT * FROM r1

-- sqlfmt-corpus-separator --

SELECT * FROM r2

-- sqlfmt-corpus-separator --

SELECT * FROM rec1

-- sqlfmt-corpus-separator --

SELECT * FROM ref_tbl

-- sqlfmt-corpus-separator --

SELECT * FROM rls_child_tbl WHERE a <<< 1000

-- sqlfmt-corpus-separator --

SELECT * FROM rls_part WHERE a <<< 1000

-- sqlfmt-corpus-separator --

SELECT * FROM rls_ptbl WHERE a <<< 1000

-- sqlfmt-corpus-separator --

SELECT * FROM rls_tbl

-- sqlfmt-corpus-separator --

SELECT * FROM rls_tbl WHERE a <<< 1000

-- sqlfmt-corpus-separator --

SELECT * FROM rls_tbl_view WHERE a <<< 1000

-- sqlfmt-corpus-separator --

SELECT * FROM rls_test_src

-- sqlfmt-corpus-separator --

SELECT * FROM rls_view

-- sqlfmt-corpus-separator --

SELECT * FROM rule_t1

-- sqlfmt-corpus-separator --

SELECT * FROM rule_v1

-- sqlfmt-corpus-separator --

SELECT * FROM ruletest1

-- sqlfmt-corpus-separator --

SELECT * FROM ruletest2

-- sqlfmt-corpus-separator --

SELECT * FROM ruletest_t1

-- sqlfmt-corpus-separator --

SELECT * FROM ruletest_t2

-- sqlfmt-corpus-separator --

SELECT * FROM ruletest_tbl2

-- sqlfmt-corpus-separator --

SELECT * FROM rw_view1

-- sqlfmt-corpus-separator --

SELECT * FROM rw_view1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM rw_view15

-- sqlfmt-corpus-separator --

SELECT * FROM rw_view2

-- sqlfmt-corpus-separator --

SELECT * FROM rw_view2 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM rw_view2 ORDER BY aaa

-- sqlfmt-corpus-separator --

SELECT * FROM sales_all WHERE sales_state = 'Warsaw'

-- sqlfmt-corpus-separator --

SELECT * FROM sales_apr2022 where sales_date > '2022-01-01'

-- sqlfmt-corpus-separator --

SELECT * FROM sales_central WHERE sales_state = 'Warsaw'

-- sqlfmt-corpus-separator --

SELECT * FROM sales_feb2022 where sales_date > '2022-01-01'

-- sqlfmt-corpus-separator --

SELECT * FROM sales_list WHERE sales_state = 'Warsaw'

-- sqlfmt-corpus-separator --

SELECT * FROM sales_list WHERE salesperson_name = 'Ivanov'

-- sqlfmt-corpus-separator --

SELECT * FROM sales_mar2022 where sales_date > '2022-01-01'

-- sqlfmt-corpus-separator --

SELECT * FROM sales_others

-- sqlfmt-corpus-separator --

SELECT * FROM sales_others ORDER BY salesperson_id

-- sqlfmt-corpus-separator --

SELECT * FROM sales_others where sales_date > '2022-01-01'

-- sqlfmt-corpus-separator --

SELECT * FROM salespeople01_10

-- sqlfmt-corpus-separator --

SELECT * FROM salespeople10_40

-- sqlfmt-corpus-separator --

SELECT * FROM savepoints

-- sqlfmt-corpus-separator --

SELECT * FROM serialTest1

-- sqlfmt-corpus-separator --

SELECT * FROM serialTest2 ORDER BY f2 ASC

-- sqlfmt-corpus-separator --

SELECT * FROM shoe ORDER BY shoename

-- sqlfmt-corpus-separator --

SELECT * FROM shoe_ready WHERE total_avail >= 2 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM shoelace ORDER BY sl_name

-- sqlfmt-corpus-separator --

SELECT * FROM shoelace_candelete

-- sqlfmt-corpus-separator --

SELECT * FROM shoelace_log

-- sqlfmt-corpus-separator --

SELECT * FROM shoelace_log ORDER BY sl_name

-- sqlfmt-corpus-separator --

SELECT * FROM shoelace_obsolete ORDER BY sl_len_cm

-- sqlfmt-corpus-separator --

SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND 1 = j1.a AND j2.a = 1

-- sqlfmt-corpus-separator --

SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND j1.a = 1 AND j2.a = 1

-- sqlfmt-corpus-separator --

SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND j1.a = 2 AND j2.a = 2

-- sqlfmt-corpus-separator --

SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND j1.a = 2 AND j2.a = 3

-- sqlfmt-corpus-separator --

SELECT * FROM source ORDER BY sid

-- sqlfmt-corpus-separator --

SELECT * FROM sq_source ORDER BY sid

-- sqlfmt-corpus-separator --

SELECT * FROM sq_target

-- sqlfmt-corpus-separator --

SELECT * FROM sq_target ORDER BY tid

-- sqlfmt-corpus-separator --

SELECT * FROM sq_target WHERE tid = 1

-- sqlfmt-corpus-separator --

SELECT * FROM sq_target_merge_log ORDER BY tid

-- sqlfmt-corpus-separator --

SELECT * FROM street

-- sqlfmt-corpus-separator --

SELECT * FROM stud_emp_copy

-- sqlfmt-corpus-separator --

SELECT * FROM t

-- sqlfmt-corpus-separator --

SELECT * FROM t1

-- sqlfmt-corpus-separator --

SELECT * FROM t1 ORDER BY a,b

-- sqlfmt-corpus-separator --

SELECT * FROM t1 WHERE a=100

-- sqlfmt-corpus-separator --

SELECT * FROM t2

-- sqlfmt-corpus-separator --

SELECT * FROM t3

-- sqlfmt-corpus-separator --

SELECT * FROM t4

-- sqlfmt-corpus-separator --

SELECT * FROM t5 ORDER BY c ASC, a ASC

-- sqlfmt-corpus-separator --

SELECT * FROM target ORDER BY tid

-- sqlfmt-corpus-separator --

SELECT * FROM tasks

-- sqlfmt-corpus-separator --

SELECT * FROM temporal3 ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM temporal_mltrng ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM temporal_mltrng3 ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM temporal_partitioned

-- sqlfmt-corpus-separator --

SELECT * FROM temporal_partitioned ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM temporal_partitioned_1 ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM temporal_partitioned_3 ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM temporal_partitioned_5 ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM temporal_rng ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM temporal_rng3 ORDER BY id, valid_at

-- sqlfmt-corpus-separator --

SELECT * FROM temptest

-- sqlfmt-corpus-separator --

SELECT * FROM temptest1

-- sqlfmt-corpus-separator --

SELECT * FROM temptest2

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

SELECT * FROM test12fk

-- sqlfmt-corpus-separator --

SELECT * FROM test12pk

-- sqlfmt-corpus-separator --

SELECT * FROM test20_1

-- sqlfmt-corpus-separator --

SELECT * FROM test21_1

-- sqlfmt-corpus-separator --

SELECT * FROM test30_1

-- sqlfmt-corpus-separator --

SELECT * FROM test31_1

-- sqlfmt-corpus-separator --

SELECT * FROM test4 WHERE b = 'cote'

-- sqlfmt-corpus-separator --

SELECT * FROM test6

-- sqlfmt-corpus-separator --

SELECT * FROM test6a

-- sqlfmt-corpus-separator --

SELECT * FROM test_like_gen_1

-- sqlfmt-corpus-separator --

SELECT * FROM test_like_gen_2

-- sqlfmt-corpus-separator --

SELECT * FROM test_like_gen_3

-- sqlfmt-corpus-separator --

SELECT * FROM test_like_id_1

-- sqlfmt-corpus-separator --

SELECT * FROM test_like_id_2

-- sqlfmt-corpus-separator --

SELECT * FROM test_like_id_3

-- sqlfmt-corpus-separator --

SELECT * FROM test_missing_target2

-- sqlfmt-corpus-separator --

SELECT * FROM test_missing_target3

-- sqlfmt-corpus-separator --

SELECT * FROM test_ns_schema_1.abc

-- sqlfmt-corpus-separator --

SELECT * FROM test_ns_schema_1.abc_view

-- sqlfmt-corpus-separator --

SELECT * FROM tgt

-- sqlfmt-corpus-separator --

SELECT * FROM tidscan

-- sqlfmt-corpus-separator --

SELECT * FROM tidscan WHERE ctid = '(0,1)'

-- sqlfmt-corpus-separator --

SELECT * FROM toyemp WHERE name = 'sharon'

-- sqlfmt-corpus-separator --

SELECT * FROM trans_abc ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM trans_bar

-- sqlfmt-corpus-separator --

SELECT * FROM trans_barbaz

-- sqlfmt-corpus-separator --

SELECT * FROM trans_baz

-- sqlfmt-corpus-separator --

SELECT * FROM trans_foo

-- sqlfmt-corpus-separator --

SELECT * FROM trunc_e

-- sqlfmt-corpus-separator --

SELECT * FROM trunc_f

-- sqlfmt-corpus-separator --

SELECT * FROM trunc_fa

-- sqlfmt-corpus-separator --

SELECT * FROM trunc_faa

-- sqlfmt-corpus-separator --

SELECT * FROM trunc_trigger_log

-- sqlfmt-corpus-separator --

SELECT * FROM truncate_a

-- sqlfmt-corpus-separator --

SELECT * FROM truncate_b

-- sqlfmt-corpus-separator --

SELECT * FROM tststats.priv_test_parent_tbl WHERE a <<< 0 AND b <<< 0

-- sqlfmt-corpus-separator --

SELECT * FROM tststats.priv_test_parent_tbl WHERE a <<< 0 OR b <<< 0

-- sqlfmt-corpus-separator --

SELECT * FROM tststats.priv_test_tbl

-- sqlfmt-corpus-separator --

SELECT * FROM tststats.priv_test_tbl WHERE a <<< 0 AND b <<< 0

-- sqlfmt-corpus-separator --

SELECT * FROM tststats.priv_test_tbl WHERE a <<< 0 OR b <<< 0

-- sqlfmt-corpus-separator --

SELECT * FROM tststats.priv_test_view WHERE a <<< 0 AND b <<< 0

-- sqlfmt-corpus-separator --

SELECT * FROM tststats.priv_test_view WHERE a <<< 0 OR b <<< 0

-- sqlfmt-corpus-separator --

SELECT * FROM tx1

-- sqlfmt-corpus-separator --

SELECT * FROM uctest

-- sqlfmt-corpus-separator --

SELECT * FROM unique_tbl

-- sqlfmt-corpus-separator --

SELECT * FROM update_test

-- sqlfmt-corpus-separator --

SELECT * FROM v1 WHERE a=100

-- sqlfmt-corpus-separator --

SELECT * FROM v1 WHERE a=3

-- sqlfmt-corpus-separator --

SELECT * FROM v1 WHERE a=8

-- sqlfmt-corpus-separator --

SELECT * FROM v1 WHERE b=8

-- sqlfmt-corpus-separator --

SELECT * FROM v2

-- sqlfmt-corpus-separator --

SELECT * FROM v_window

-- sqlfmt-corpus-separator --

SELECT * FROM vac_option_tab_counts

-- sqlfmt-corpus-separator --

SELECT * FROM vactst

-- sqlfmt-corpus-separator --

SELECT * FROM view_unnamed_ss

-- sqlfmt-corpus-separator --

SELECT * FROM viewtest

-- sqlfmt-corpus-separator --

SELECT * FROM vistest

-- sqlfmt-corpus-separator --

SELECT * FROM voo

-- sqlfmt-corpus-separator --

SELECT * FROM vsubdepartment ORDER BY name

-- sqlfmt-corpus-separator --

SELECT * FROM vtype

-- sqlfmt-corpus-separator --

SELECT * FROM vtype2

-- sqlfmt-corpus-separator --

SELECT * FROM vw_getrngfunc

-- sqlfmt-corpus-separator --

SELECT * FROM vx1

-- sqlfmt-corpus-separator --

SELECT * FROM withz ORDER BY k

-- sqlfmt-corpus-separator --

SELECT * FROM wq_source

-- sqlfmt-corpus-separator --

SELECT * FROM wq_target

-- sqlfmt-corpus-separator --

SELECT * FROM writetest

-- sqlfmt-corpus-separator --

SELECT * FROM writetest, temptest

-- sqlfmt-corpus-separator --

SELECT * FROM x

-- sqlfmt-corpus-separator --

SELECT * FROM xacttest

-- sqlfmt-corpus-separator --

SELECT * FROM xmltableview1

-- sqlfmt-corpus-separator --

SELECT * FROM xmltableview2

-- sqlfmt-corpus-separator --

SELECT * FROM xmltest

-- sqlfmt-corpus-separator --

SELECT * FROM y

-- sqlfmt-corpus-separator --

SELECT * FROM yy

-- sqlfmt-corpus-separator --

SELECT * from CHECK2_TBL

-- sqlfmt-corpus-separator --

SELECT * from FKTABLE

-- sqlfmt-corpus-separator --

SELECT * from PKTABLE

-- sqlfmt-corpus-separator --

SELECT * from id_alw1

-- sqlfmt-corpus-separator --

SELECT * from id_alw2

-- sqlfmt-corpus-separator --

SELECT * from id_alw3

-- sqlfmt-corpus-separator --

SELECT * from id_alw4

-- sqlfmt-corpus-separator --

SELECT * from part_rp

-- sqlfmt-corpus-separator --

SELECT *, t1 FROM t1

-- sqlfmt-corpus-separator --

SELECT -0b10000000000000000000000000000000

-- sqlfmt-corpus-separator --

SELECT -0b1000000000000000000000000000000000000000000000000000000000000000

-- sqlfmt-corpus-separator --

SELECT -0b1000000000000000000000000000000000000000000000000000000000000001

-- sqlfmt-corpus-separator --

SELECT -0b10000000000000000000000000000001

-- sqlfmt-corpus-separator --

SELECT -0o1000000000000000000000

-- sqlfmt-corpus-separator --

SELECT -0o1000000000000000000001

-- sqlfmt-corpus-separator --

SELECT -0o20000000000

-- sqlfmt-corpus-separator --

SELECT -0o20000000001

-- sqlfmt-corpus-separator --

SELECT -0x80000000

-- sqlfmt-corpus-separator --

SELECT -0x8000000000000000

-- sqlfmt-corpus-separator --

SELECT -0x8000000000000001

-- sqlfmt-corpus-separator --

SELECT -0x80000001

-- sqlfmt-corpus-separator --

SELECT -2+3 AS one

-- sqlfmt-corpus-separator --

SELECT -interval '-2147483647 months -2147483647 days -9223372036854775807 us'

-- sqlfmt-corpus-separator --

SELECT .000_005

-- sqlfmt-corpus-separator --

SELECT .0a

-- sqlfmt-corpus-separator --

SELECT /* both embedded and trailing single line */ 'both' AS third

-- sqlfmt-corpus-separator --

SELECT /* embedded single line */ 'embedded' AS second

-- sqlfmt-corpus-separator --

SELECT 0 ^ 0 + 0 ^ 1 + 0 ^ 0.0 + 0 ^ 0.5

-- sqlfmt-corpus-separator --

SELECT 0.0a

-- sqlfmt-corpus-separator --

SELECT 0.0e

-- sqlfmt-corpus-separator --

SELECT 0.0e1a

-- sqlfmt-corpus-separator --

SELECT 0.a

-- sqlfmt-corpus-separator --

SELECT 0/0

-- sqlfmt-corpus-separator --

SELECT 0b

-- sqlfmt-corpus-separator --

SELECT 0b0x

-- sqlfmt-corpus-separator --

SELECT 0b10000000000000000000000000000000

-- sqlfmt-corpus-separator --

SELECT 0b1000000000000000000000000000000000000000000000000000000000000000

-- sqlfmt-corpus-separator --

SELECT 0b100101

-- sqlfmt-corpus-separator --

SELECT 0b1111111111111111111111111111111

-- sqlfmt-corpus-separator --

SELECT 0b111111111111111111111111111111111111111111111111111111111111111

-- sqlfmt-corpus-separator --

SELECT 0b_10_0101

-- sqlfmt-corpus-separator --

SELECT 0o

-- sqlfmt-corpus-separator --

SELECT 0o0x

-- sqlfmt-corpus-separator --

SELECT 0o1000000000000000000000

-- sqlfmt-corpus-separator --

SELECT 0o17777777777

-- sqlfmt-corpus-separator --

SELECT 0o20000000000

-- sqlfmt-corpus-separator --

SELECT 0o273

-- sqlfmt-corpus-separator --

SELECT 0o2_73

-- sqlfmt-corpus-separator --

SELECT 0o777777777777777777777

-- sqlfmt-corpus-separator --

SELECT 0x

-- sqlfmt-corpus-separator --

SELECT 0x0o

-- sqlfmt-corpus-separator --

SELECT 0x0y

-- sqlfmt-corpus-separator --

SELECT 0x1EEE_FFFF

-- sqlfmt-corpus-separator --

SELECT 0x42F

-- sqlfmt-corpus-separator --

SELECT 0x7FFFFFFF

-- sqlfmt-corpus-separator --

SELECT 0x7FFFFFFFFFFFFFFF

-- sqlfmt-corpus-separator --

SELECT 0x80000000

-- sqlfmt-corpus-separator --

SELECT 0x8000000000000000

-- sqlfmt-corpus-separator --

SELECT 1

-- sqlfmt-corpus-separator --

SELECT 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 AS ten

-- sqlfmt-corpus-separator --

SELECT 1 AS one

-- sqlfmt-corpus-separator --

SELECT 1 AS one FROM test_having HAVING 1 < 2

-- sqlfmt-corpus-separator --

SELECT 1 AS one FROM test_having HAVING 1 > 2

-- sqlfmt-corpus-separator --

SELECT 1 AS one FROM test_having HAVING a > 1

-- sqlfmt-corpus-separator --

SELECT 1 AS one FROM test_having WHERE 1/a = 1 HAVING 1 < 2

-- sqlfmt-corpus-separator --

SELECT 1 AS x ORDER BY x

-- sqlfmt-corpus-separator --

SELECT 1 FROM atest5

-- sqlfmt-corpus-separator --

SELECT 1 FROM atest5 WHERE two = 2

-- sqlfmt-corpus-separator --

SELECT 1 FROM atest6

-- sqlfmt-corpus-separator --

SELECT 10 AS ten

-- sqlfmt-corpus-separator --

SELECT 100_

-- sqlfmt-corpus-separator --

SELECT 100__000

-- sqlfmt-corpus-separator --

SELECT 123abc

-- sqlfmt-corpus-separator --

SELECT 1_000_000

-- sqlfmt-corpus-separator --

SELECT 1_2_3

-- sqlfmt-corpus-separator --

SELECT 1b

-- sqlfmt-corpus-separator --

SELECT 1o

-- sqlfmt-corpus-separator --

SELECT 1x

-- sqlfmt-corpus-separator --

SELECT 2

-- sqlfmt-corpus-separator --

SELECT 2 !=-- comment to be removed by psql
  1

-- sqlfmt-corpus-separator --

SELECT 2 !=/**/ 1, 2 !=/**/ 2

-- sqlfmt-corpus-separator --

SELECT 2 * m FROM money_data

-- sqlfmt-corpus-separator --

SELECT 2 * q1 AS "twice int4" FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT 2 + 2 / 2 AS three

-- sqlfmt-corpus-separator --

SELECT 2 - -2 AS four

-- sqlfmt-corpus-separator --

SELECT 2 AS two

-- sqlfmt-corpus-separator --

SELECT 2- -1 AS three

-- sqlfmt-corpus-separator --

SELECT 2<=/**/3, 3>=/**/2, 2<>/**/3

-- sqlfmt-corpus-separator --

SELECT 3

-- sqlfmt-corpus-separator --

SELECT 3 AS c

-- sqlfmt-corpus-separator --

SELECT 37 + q1 AS plus4 FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT 37 - q1 AS minus4 FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT 3<=/**/2, 2>=/**/3, 2<>/**/2

-- sqlfmt-corpus-separator --

SELECT 4-2 AS two

-- sqlfmt-corpus-separator --

SELECT 7

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (four) four,two
   FROM tenk1 WHERE four = 0 ORDER BY 1

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

SELECT E'a\\b' AS "a\b"

-- sqlfmt-corpus-separator --

SELECT E'd\u0061t\U00000061' AS "data"

-- sqlfmt-corpus-separator --

SELECT INTERVAL '+02:00' AS "Two hours"

-- sqlfmt-corpus-separator --

SELECT INTERVAL '+infinity -infinity'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-08:00' AS "Eight hours"

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 +02:03' AS "22 hours ago..."

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 days +02:03' AS "22 hours ago..."

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-infinity' AS "beginning of time"

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:00' AS "One hour"

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 year months days 5 hours'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5 months' AS "One month 15 days"

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5 weeks' AS "Ten days twelve hours"

-- sqlfmt-corpus-separator --

SELECT INTERVAL '10 years -11 month -12 days +13:14' AS "9 years..."

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

SELECT U&'a\\b' AS "a\b"

-- sqlfmt-corpus-separator --

SELECT U&'wrong: \+0061'

-- sqlfmt-corpus-separator --

SELECT U&'wrong: \+00db99\+000061'

-- sqlfmt-corpus-separator --

SELECT U&'wrong: \+2FFFFF'

-- sqlfmt-corpus-separator --

SELECT U&'wrong: \061'

-- sqlfmt-corpus-separator --

SELECT U&'wrong: \db99'

-- sqlfmt-corpus-separator --

SELECT U&'wrong: \db99\0061'

-- sqlfmt-corpus-separator --

SELECT U&'wrong: \db99\\'

-- sqlfmt-corpus-separator --

SELECT U&'wrong: \db99xy'

-- sqlfmt-corpus-separator --

SELECT _100

-- sqlfmt-corpus-separator --

SELECT a FROM arrtest

-- sqlfmt-corpus-separator --

SELECT a FROM pagg_tab WHERE a < 3 GROUP BY a ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT a FROM ref_b

-- sqlfmt-corpus-separator --

SELECT a FROM xacttest WHERE a > 100

-- sqlfmt-corpus-separator --

SELECT a as "from table ref_c" FROM ref_c

-- sqlfmt-corpus-separator --

SELECT a as "from table trunc_a" FROM trunc_a ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, (SELECT gtest1.b) FROM gtest1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, a FROM test_missing_target
	ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM base_tbl_hist

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test1 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test2 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test3 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test4 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a, b FROM collate_test5 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a, b FROM gtest1 WHERE b = 4 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b FROM gtest11

-- sqlfmt-corpus-separator --

SELECT a, b, b * 2 AS b2 FROM gtest1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM test_like_4a

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM test_like_4b

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM test_like_4c

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM test_like_4d

-- sqlfmt-corpus-separator --

SELECT a, c FROM gtest11

-- sqlfmt-corpus-separator --

SELECT a, c FROM gtest12

-- sqlfmt-corpus-separator --

SELECT a,a<<4 AS "a<<4",b,b>>2 AS "b>>2" FROM bit_table

-- sqlfmt-corpus-separator --

SELECT a,a<<4 AS "a<<4",b,b>>2 AS "b>>2" FROM varbit_table

-- sqlfmt-corpus-separator --

SELECT a,b,a<b AS "a<b",a<=b AS "a<=b",a=b AS "a=b",
        a>=b AS "a>=b",a>b AS "a>b",a<>b AS "a<>b" FROM bit_table

-- sqlfmt-corpus-separator --

SELECT a,b,a<b AS "a<b",a<=b AS "a<=b",a=b AS "a=b",
        a>=b AS "a>=b",a>b AS "a>b",a<>b AS "a<>b" FROM varbit_table

-- sqlfmt-corpus-separator --

SELECT a,b,c FROM arrtest

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

SELECT a.amname FROM pg_class c, pg_am a
  WHERE c.relname = 'am_partitioned' AND a.oid = c.relam

-- sqlfmt-corpus-separator --

SELECT a.amname FROM pg_class c, pg_am a
  WHERE c.relname = 'tableam_parted_heap2' AND a.oid = c.relam

-- sqlfmt-corpus-separator --

SELECT a.xmin = b.xmin FROM savepoints a, savepoints b WHERE a.a=6 AND b.a=7

-- sqlfmt-corpus-separator --

SELECT a.xmin = b.xmin FROM savepoints a, savepoints b WHERE a.a=6 AND b.a=8

-- sqlfmt-corpus-separator --

SELECT a.xmin = b.xmin FROM savepoints a, savepoints b WHERE a.a=9 AND b.a=11

-- sqlfmt-corpus-separator --

SELECT a/2, a/2 FROM test_missing_target
	GROUP BY a/2 ORDER BY a/2

-- sqlfmt-corpus-separator --

SELECT a/2, a/2 FROM test_missing_target
	ORDER BY a/2

-- sqlfmt-corpus-separator --

SELECT a1.amopfamily, a1.amopopr, o1.oid, o1.oprname
FROM pg_amop AS a1, pg_operator AS o1
WHERE a1.amopopr = o1.oid AND a1.amoppurpose = 's' AND
    (o1.oprrest = 0 OR o1.oprjoin = 0)

-- sqlfmt-corpus-separator --

SELECT a1.amopfamily, a1.amopopr, o1.oprname, p1.prosrc
FROM pg_amop AS a1, pg_operator AS o1, pg_proc AS p1
WHERE a1.amopopr = o1.oid AND o1.oprcode = p1.oid AND
    a1.amoplefttype != a1.amoprighttype AND
    p1.provolatile = 'v'

-- sqlfmt-corpus-separator --

SELECT a1.amopfamily, a1.amopopr, o1.oprname, p1.prosrc
FROM pg_amop AS a1, pg_operator AS o1, pg_proc AS p1
WHERE a1.amopopr = o1.oid AND o1.oprcode = p1.oid AND
    a1.amoplefttype = a1.amoprighttype AND
    p1.provolatile != 'i'

-- sqlfmt-corpus-separator --

SELECT a1.amopfamily, a1.amopstrategy
FROM pg_amop as a1
WHERE NOT ((a1.amoppurpose = 's' AND a1.amopsortfamily = 0) OR
           (a1.amoppurpose = 'o' AND a1.amopsortfamily <> 0))

-- sqlfmt-corpus-separator --

SELECT a1.amopfamily, a1.amopstrategy
FROM pg_amop as a1
WHERE a1.amopfamily = 0 OR a1.amoplefttype = 0 OR a1.amoprighttype = 0
    OR a1.amopopr = 0 OR a1.amopmethod = 0 OR a1.amopstrategy < 1

-- sqlfmt-corpus-separator --

SELECT a1.amprocfamily, a1.amproc, p1.prosrc
FROM pg_amproc AS a1, pg_proc AS p1
WHERE a1.amproc = p1.oid AND
    a1.amproclefttype != a1.amprocrighttype AND
    p1.provolatile = 'v'

-- sqlfmt-corpus-separator --

SELECT a1.amprocfamily, a1.amproc, p1.prosrc
FROM pg_amproc AS a1, pg_proc AS p1
WHERE a1.amproc = p1.oid AND
    a1.amproclefttype = a1.amprocrighttype AND
    p1.provolatile != 'i'

-- sqlfmt-corpus-separator --

SELECT a1.amprocfamily, a1.amprocnum
FROM pg_amproc as a1
WHERE a1.amprocfamily = 0 OR a1.amproclefttype = 0 OR a1.amprocrighttype = 0
    OR a1.amprocnum < 0 OR a1.amproc = 0

-- sqlfmt-corpus-separator --

SELECT a1.attrelid, a1.attname
FROM pg_attribute as a1
WHERE a1.attrelid = 0 OR a1.atttypid = 0 OR a1.attnum = 0 OR
    a1.attinhcount < 0 OR (a1.attinhcount = 0 AND NOT a1.attislocal)

-- sqlfmt-corpus-separator --

SELECT a1.attrelid, a1.attname, c1.oid, c1.relname
FROM pg_attribute AS a1, pg_class AS c1
WHERE a1.attrelid = c1.oid AND a1.attnum > c1.relnatts

-- sqlfmt-corpus-separator --

SELECT a1.attrelid, a1.attname, t1.oid, t1.typname
FROM pg_attribute AS a1, pg_type AS t1
WHERE a1.atttypid = t1.oid AND
    (a1.attlen != t1.typlen OR
     a1.attalign != t1.typalign OR
     a1.attbyval != t1.typbyval OR
     (a1.attstorage != t1.typstorage AND a1.attstorage != 'p'))

-- sqlfmt-corpus-separator --

SELECT a1.oid, a1.amname
FROM pg_am AS a1
WHERE a1.amhandler = 0

-- sqlfmt-corpus-separator --

SELECT a1.oid, f1.oid
FROM pg_amop AS a1, pg_opfamily AS f1
WHERE a1.amopfamily = f1.oid AND a1.amopmethod != f1.opfmethod

-- sqlfmt-corpus-separator --

SELECT abort_increasing, abort_decreasing FROM abbrev_abort_uuids ORDER BY abort_decreasing NULLS FIRST OFFSET 20000 - 4

-- sqlfmt-corpus-separator --

SELECT abort_increasing, abort_decreasing FROM abbrev_abort_uuids ORDER BY abort_increasing OFFSET 20000 - 4

-- sqlfmt-corpus-separator --

SELECT abort_increasing, noabort_increasing FROM abbrev_abort_uuids ORDER BY abort_increasing LIMIT 5

-- sqlfmt-corpus-separator --

SELECT abort_increasing, noabort_increasing FROM abbrev_abort_uuids ORDER BY noabort_increasing NULLS FIRST LIMIT 5

-- sqlfmt-corpus-separator --

SELECT amname, amhandler, amtype FROM pg_am where amtype = 't' ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT atest5 FROM atest5

-- sqlfmt-corpus-separator --

SELECT atest6 FROM atest6

-- sqlfmt-corpus-separator --

SELECT atestp2 FROM atestp2

-- sqlfmt-corpus-separator --

SELECT attname, most_common_vals FROM pg_stats
  WHERE tablename = 'current_check'
  ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT attnames, most_common_vals
   FROM pg_stats_ext
   WHERE statistics_name = 'stats_ext_range'

-- sqlfmt-corpus-separator --

SELECT b <  '08:00:2b:01:02:03:04:06' FROM macaddr8_data WHERE a = 15

-- sqlfmt-corpus-separator --

SELECT b <  '08:00:2b:01:02:04' FROM macaddr8_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b <  '08:00:2b:01:02:04' FROM macaddr_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b <= '08:00:2b:01:02:03:04:06' FROM macaddr8_data WHERE a = 15

-- sqlfmt-corpus-separator --

SELECT b <= '08:00:2b:01:02:04' FROM macaddr_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b <> '08:00:2b:01:02:03' FROM macaddr_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b <> '08:00:2b:01:02:03:04:05' FROM macaddr8_data WHERE a = 15

-- sqlfmt-corpus-separator --

SELECT b <> '08:00:2b:01:02:03:04:06' FROM macaddr8_data WHERE a = 15

-- sqlfmt-corpus-separator --

SELECT b <> '08:00:2b:01:02:04' FROM macaddr_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b =  '08:00:2b:01:02:03' FROM macaddr_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b =  '08:00:2b:01:02:03:04:05' FROM macaddr8_data WHERE a = 15

-- sqlfmt-corpus-separator --

SELECT b =  '08:00:2b:ff:fe:01:02:03' FROM macaddr8_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b >  '08:00:2b:01:02:03' FROM macaddr_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b >  '08:00:2b:01:02:03:04:05' FROM macaddr8_data WHERE a = 15

-- sqlfmt-corpus-separator --

SELECT b >  '08:00:2b:01:02:03:04:06' FROM macaddr8_data WHERE a = 15

-- sqlfmt-corpus-separator --

SELECT b >  '08:00:2b:01:02:04' FROM macaddr_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b >  '08:00:2b:ff:fe:01:02:03' FROM macaddr8_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b >  '08:00:2b:ff:fe:01:02:04' FROM macaddr8_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b >= '08:00:2b:01:02:03:04:06' FROM macaddr8_data WHERE a = 15

-- sqlfmt-corpus-separator --

SELECT b >= '08:00:2b:01:02:04' FROM macaddr_data WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b,
       b ~ '^[[:alpha:]]+$' AS is_alpha,
       b ~ '^[[:upper:]]+$' AS is_upper,
       b ~ '^[[:lower:]]+$' AS is_lower,
       b ~ '^[[:digit:]]+$' AS is_digit,
       b ~ '^[[:alnum:]]+$' AS is_alnum,
       b ~ '^[[:graph:]]+$' AS is_graph,
       b ~ '^[[:print:]]+$' AS is_print,
       b ~ '^[[:punct:]]+$' AS is_punct,
       b ~ '^[[:space:]]+$' AS is_space
FROM collate_test6

-- sqlfmt-corpus-separator --

SELECT b, b >> 1 AS bsr, b << 1 AS bsl
       FROM BIT_SHIFT_TABLE

-- sqlfmt-corpus-separator --

SELECT b, b >> 8 AS bsr8, b << 8 AS bsl8
       FROM BIT_SHIFT_TABLE

-- sqlfmt-corpus-separator --

SELECT b, c FROM forcetest WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b, c FROM forcetest WHERE a = 4

-- sqlfmt-corpus-separator --

SELECT b, c FROM forcetest WHERE a = 5

-- sqlfmt-corpus-separator --

SELECT b, c FROM forcetest WHERE a = 6

-- sqlfmt-corpus-separator --

SELECT b, c FROM test_having
	GROUP BY b, c HAVING b = 3 ORDER BY b, c

-- sqlfmt-corpus-separator --

SELECT b.f1 + p.f1 AS translation
   FROM BOX_TBL b, POINT_TBL p

-- sqlfmt-corpus-separator --

SELECT b.f1 - p.f1 AS translation
   FROM BOX_TBL b, POINT_TBL p

-- sqlfmt-corpus-separator --

SELECT b1.f1, b2.f1, b1.f1 # b2.f1 FROM BOX_TBL b1, BOX_TBL b2

-- sqlfmt-corpus-separator --

SELECT b1.f1, b2.f1, b1.f1 <-> b2.f1 FROM BOX_TBL b1, BOX_TBL b2

-- sqlfmt-corpus-separator --

SELECT b1.f1, b2.f1, b1.f1 <^ b2.f1 FROM BOX_TBL b1, BOX_TBL b2

-- sqlfmt-corpus-separator --

SELECT b1.f1, b2.f1, b1.f1 >^ b2.f1 FROM BOX_TBL b1, BOX_TBL b2

-- sqlfmt-corpus-separator --

SELECT c AS cidr, i AS inet FROM INET_TBL

-- sqlfmt-corpus-separator --

SELECT c AS cidr, i AS inet FROM INET_TBL
  WHERE c = i

-- sqlfmt-corpus-separator --

SELECT c FROM pagg_tab GROUP BY c ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT c FROM test_missing_target ORDER BY a

-- sqlfmt-corpus-separator --

SELECT c FROM toasttest

-- sqlfmt-corpus-separator --

SELECT c, d FROM forcetest WHERE a = 2

-- sqlfmt-corpus-separator --

SELECT c.f1 FROM NAME_TBL c WHERE c.f1 !~ '.*'

-- sqlfmt-corpus-separator --

SELECT c.f1 FROM NAME_TBL c WHERE c.f1 < '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890ABCDEFGHIJKLMNOPQR'

-- sqlfmt-corpus-separator --

SELECT c.f1 FROM NAME_TBL c WHERE c.f1 <= '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890ABCDEFGHIJKLMNOPQR'

-- sqlfmt-corpus-separator --

SELECT c.f1 FROM NAME_TBL c WHERE c.f1 <> '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890ABCDEFGHIJKLMNOPQR'

-- sqlfmt-corpus-separator --

SELECT c.f1 FROM NAME_TBL c WHERE c.f1 = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890ABCDEFGHIJKLMNOPQR'

-- sqlfmt-corpus-separator --

SELECT c.f1 FROM NAME_TBL c WHERE c.f1 > '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890ABCDEFGHIJKLMNOPQR'

-- sqlfmt-corpus-separator --

SELECT c.f1 FROM NAME_TBL c WHERE c.f1 >= '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890ABCDEFGHIJKLMNOPQR'

-- sqlfmt-corpus-separator --

SELECT c.f1 FROM NAME_TBL c WHERE c.f1 ~ '.*'

-- sqlfmt-corpus-separator --

SELECT c.f1 FROM NAME_TBL c WHERE c.f1 ~ '.*asdf.*'

-- sqlfmt-corpus-separator --

SELECT c.f1 FROM NAME_TBL c WHERE c.f1 ~ '[0-9]'

-- sqlfmt-corpus-separator --

SELECT c.f1, p.f1, c.f1 * p.f1 FROM CIRCLE_TBL c, POINT_TBL p

-- sqlfmt-corpus-separator --

SELECT c.f1, p.f1, c.f1 + p.f1 FROM CIRCLE_TBL c, POINT_TBL p

-- sqlfmt-corpus-separator --

SELECT c.f1, p.f1, c.f1 - p.f1 FROM CIRCLE_TBL c, POINT_TBL p

-- sqlfmt-corpus-separator --

SELECT c.f1, p.f1, c.f1 <-> p.f1 FROM CIRCLE_TBL c, POLYGON_TBL p

-- sqlfmt-corpus-separator --

SELECT c.relname FROM pg_class c, pg_tablespace s
  WHERE c.reltablespace = s.oid AND s.spcname = 'regress_tblspace'

-- sqlfmt-corpus-separator --

SELECT c.relname FROM pg_class c, pg_tablespace s
  WHERE c.reltablespace = s.oid AND s.spcname = 'regress_tblspace'
  ORDER BY c.relname

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 != c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 && c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 &< c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 &<| c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 &> c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 < c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 << c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 <<| c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 <= c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 <@ c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 = c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 > c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 >= c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 >> c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 @> c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 |&> c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 |>> c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.f1, c2.f1 FROM CIRCLE_TBL c1, CIRCLE_TBL c2 WHERE c1.f1 ~= c2.f1

-- sqlfmt-corpus-separator --

SELECT c1.oid
FROM pg_opclass AS c1
WHERE c1.opcmethod = 0 OR c1.opcnamespace = 0 OR c1.opcfamily = 0
    OR c1.opcintype = 0

-- sqlfmt-corpus-separator --

SELECT c1.oid, c2.oid
FROM pg_opclass AS c1, pg_opclass AS c2
WHERE c1.oid != c2.oid AND
    c1.opcmethod = c2.opcmethod AND c1.opcintype = c2.opcintype AND
    c1.opcdefault AND c2.opcdefault

-- sqlfmt-corpus-separator --

SELECT c1.oid, f1.oid
FROM pg_opclass AS c1, pg_opfamily AS f1
WHERE c1.opcfamily = f1.oid AND c1.opcmethod != f1.opfmethod

-- sqlfmt-corpus-separator --

SELECT c2, c1, c3 FROM nametbl WHERE c2 = 'two' AND c1 = 1

-- sqlfmt-corpus-separator --

SELECT c_bigint, c_text FROM T WHERE c_bigint = -1 LIMIT 1

-- sqlfmt-corpus-separator --

SELECT c_bigint, c_text FROM T WHERE c_text = 'hello' LIMIT 1

-- sqlfmt-corpus-separator --

SELECT c_text FROM T WHERE c_int = -1

-- sqlfmt-corpus-separator --

SELECT col1 FROM atest2 WHERE col2 = true

-- sqlfmt-corpus-separator --

SELECT condeferrable, condeferred, conenforced, convalidated
FROM pg_constraint WHERE conname = 'fk_con'

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE '(1,7)' >= ctid AND ctid > '(1,4)'

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE '(2,8)' < ctid

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE ctid < '(0,0)'

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE ctid < '(0,0)' LIMIT 1

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE ctid < '(1, 0)'

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE ctid < '(1,0)'

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE ctid <= '(1,5)'

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE ctid > '(0,65535)' AND ctid < '(1,0)' LIMIT 1

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE ctid > '(1,4)' AND '(1,7)' >= ctid

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE ctid > '(2,8)'

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE ctid > '(4294967295,65535)'

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE ctid > '(9, 0)'

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE ctid >= '(100,0)'

-- sqlfmt-corpus-separator --

SELECT ctid FROM tidrangescan WHERE ctid >= '(2,8)'

-- sqlfmt-corpus-separator --

SELECT ctid, * FROM current_check_2

-- sqlfmt-corpus-separator --

SELECT ctid, * FROM tidscan

-- sqlfmt-corpus-separator --

SELECT ctid, * FROM tidscan WHERE '(0,1)' = ctid

-- sqlfmt-corpus-separator --

SELECT ctid, * FROM tidscan WHERE ctid = '(0,1)'

-- sqlfmt-corpus-separator --

SELECT ctid, * FROM tidscan WHERE ctid = '(0,2)' OR '(0,1)' = ctid

-- sqlfmt-corpus-separator --

SELECT ctid,cmin,* FROM combocidtest

-- sqlfmt-corpus-separator --

SELECT current_schema

-- sqlfmt-corpus-separator --

SELECT current_user = 'regress_guc_user'

-- sqlfmt-corpus-separator --

SELECT d.f1 AS "timestamp", t.f1 AS "interval", d.f1 + t.f1 AS plus
  FROM TEMP_TIMESTAMP d, INTERVAL_TBL t
  ORDER BY plus, "timestamp", "interval"

-- sqlfmt-corpus-separator --

SELECT d.f1 AS "timestamp", t.f1 AS "interval", d.f1 - t.f1 AS minus
  FROM TEMP_TIMESTAMP d, INTERVAL_TBL t
  ORDER BY minus, "timestamp", "interval"

-- sqlfmt-corpus-separator --

SELECT d1 + interval '1 year' AS one_year FROM TIMESTAMPTZ_TBL

-- sqlfmt-corpus-separator --

SELECT d1 + interval '1 year' AS one_year FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT d1 - interval '1 year' AS one_year FROM TIMESTAMPTZ_TBL

-- sqlfmt-corpus-separator --

SELECT d1 - interval '1 year' AS one_year FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT d1 AS european_iso FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT d1 AS european_postgres FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT d1 AS european_sql FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT d1 AS us_iso FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT d1 AS us_postgres FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT d1 AS us_sql FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT d1 FROM TIMESTAMPTZ_TBL

-- sqlfmt-corpus-separator --

SELECT d1 FROM TIMESTAMP_TBL

-- sqlfmt-corpus-separator --

SELECT d1.f1 AS timestamp1, d2.f1 AS timestamp2, d1.f1 - d2.f1 AS difference
  FROM TEMP_TIMESTAMP d1, TEMP_TIMESTAMP d2
  ORDER BY timestamp1, timestamp2, difference

-- sqlfmt-corpus-separator --

SELECT definition FROM pg_rules WHERE tablename = 'hats' ORDER BY rulename

-- sqlfmt-corpus-separator --

SELECT description FROM serializable_update_tab WHERE id = 1

-- sqlfmt-corpus-separator --

SELECT dictinitoption FROM pg_ts_dict WHERE dictname = 'synonym'

-- sqlfmt-corpus-separator --

SELECT f.f1 * '1e200' from FLOAT8_TBL f

-- sqlfmt-corpus-separator --

SELECT f.f1 / '0.0' from FLOAT4_TBL f

-- sqlfmt-corpus-separator --

SELECT f.f1 / '0.0' from FLOAT8_TBL f

-- sqlfmt-corpus-separator --

SELECT f.f1 ^ '1e200' from FLOAT8_TBL f

-- sqlfmt-corpus-separator --

SELECT f.f1 ^ '2.0' AS square_f1
   FROM FLOAT8_TBL f where f.f1 = '1004.3'

-- sqlfmt-corpus-separator --

SELECT f.f1, f.f1 * '-10' AS x
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1, f.f1 * '-10' AS x FROM FLOAT4_TBL f
   WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1, f.f1 + '-10' AS x
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1, f.f1 + '-10' AS x FROM FLOAT4_TBL f
   WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1, f.f1 - '-10' AS x
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1, f.f1 - '-10' AS x FROM FLOAT4_TBL f
   WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1, f.f1 / '-10' AS x
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.f1, f.f1 / '-10' AS x FROM FLOAT4_TBL f
   WHERE f.f1 > '0.0'

-- sqlfmt-corpus-separator --

SELECT f.oid
FROM pg_opfamily as f
WHERE f.opfmethod = 0 OR f.opfnamespace = 0

-- sqlfmt-corpus-separator --

SELECT f1 - f1 FROM INTERVAL_TBL_OF

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

SELECT f1 AS "Time TZ" FROM TIMETZ_TBL

-- sqlfmt-corpus-separator --

SELECT f1 AS "Time" FROM TIME_TBL

-- sqlfmt-corpus-separator --

SELECT f1 AS "timestamp"
  FROM TEMP_TIMESTAMP
  ORDER BY "timestamp"

-- sqlfmt-corpus-separator --

SELECT f1 FROM DATE_TBL

-- sqlfmt-corpus-separator --

SELECT f1 FROM DATE_TBL WHERE f1 < '2000-01-01'

-- sqlfmt-corpus-separator --

SELECT f1 FROM INTERVAL_TBL_OF r1 ORDER BY f1

-- sqlfmt-corpus-separator --

SELECT f1 FROM TEMP_FLOAT
  ORDER BY f1

-- sqlfmt-corpus-separator --

SELECT f1 FROM TEMP_INT2
  ORDER BY f1

-- sqlfmt-corpus-separator --

SELECT f1 FROM TEMP_INT4
  ORDER BY f1

-- sqlfmt-corpus-separator --

SELECT f1 FROM tableam_tbl_heap2 ORDER BY f1

-- sqlfmt-corpus-separator --

SELECT f1 FROM tableam_tblmv_heap2 ORDER BY f1

-- sqlfmt-corpus-separator --

SELECT f1, -f1 FROM INTERVAL_TBL

-- sqlfmt-corpus-separator --

SELECT f2 FROM atestc

-- sqlfmt-corpus-separator --

SELECT f2 FROM atestp1

-- sqlfmt-corpus-separator --

SELECT false

-- sqlfmt-corpus-separator --

SELECT false AS false

-- sqlfmt-corpus-separator --

SELECT fdwname, fdwhandler, fdwvalidator, fdwoptions FROM pg_foreign_data_wrapper

-- sqlfmt-corpus-separator --

SELECT firstc, lastc FROM extra_wide_table

-- sqlfmt-corpus-separator --

SELECT fx FROM atestp2

-- sqlfmt-corpus-separator --

SELECT fy FROM atestc

-- sqlfmt-corpus-separator --

SELECT fy FROM atestp2

-- sqlfmt-corpus-separator --

SELECT gid FROM pg_prepared_xacts WHERE gid ~ '^regress_' ORDER BY gid

-- sqlfmt-corpus-separator --

SELECT good, truncated, with_nul FROM regress_encoding

-- sqlfmt-corpus-separator --

SELECT gtest1 FROM gtest1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT guid_field FROM guid1

-- sqlfmt-corpus-separator --

SELECT guid_field FROM guid1 ORDER BY guid_field ASC

-- sqlfmt-corpus-separator --

SELECT guid_field FROM guid1 ORDER BY guid_field DESC

-- sqlfmt-corpus-separator --

SELECT h.seqno AS i1492, h.random AS i1
   FROM hash_i4_heap h
   WHERE h.random = 1

-- sqlfmt-corpus-separator --

SELECT h.seqno AS i20000
   FROM hash_i4_heap h
   WHERE h.random = 1492795354

-- sqlfmt-corpus-separator --

SELECT i FROM t ORDER BY i

-- sqlfmt-corpus-separator --

SELECT i, c,
  i < c AS lt, i <= c AS le, i = c AS eq,
  i >= c AS ge, i > c AS gt, i <> c AS ne,
  i << c AS sb, i <<= c AS sbe,
  i >> c AS sup, i >>= c AS spe,
  i && c AS ovr
  FROM INET_TBL

-- sqlfmt-corpus-separator --

SELECT i, c, i & c AS "and" FROM inet_tbl

-- sqlfmt-corpus-separator --

SELECT i, c, i - c AS "minus" FROM inet_tbl

-- sqlfmt-corpus-separator --

SELECT i, c, i | c AS "or" FROM inet_tbl

-- sqlfmt-corpus-separator --

SELECT i, i + 500 AS "i+500" FROM inet_tbl

-- sqlfmt-corpus-separator --

SELECT i, i - 500 AS "i-500" FROM inet_tbl

-- sqlfmt-corpus-separator --

SELECT i, ~i AS "~i" FROM inet_tbl

-- sqlfmt-corpus-separator --

SELECT id FROM btree_tall_tbl WHERE id = 55 ORDER BY t DESC, id DESC

-- sqlfmt-corpus-separator --

SELECT id FROM btree_tall_tbl WHERE id = 55 ORDER BY t, id

-- sqlfmt-corpus-separator --

SELECT id, abort_increasing, abort_decreasing FROM abbrev_abort_uuids ORDER BY abort_decreasing LIMIT 5

-- sqlfmt-corpus-separator --

SELECT id, abort_increasing, abort_decreasing FROM abbrev_abort_uuids ORDER BY abort_increasing LIMIT 5

-- sqlfmt-corpus-separator --

SELECT id, abort_increasing, abort_decreasing, noabort_increasing, noabort_decreasing
FROM abbrev_abort_uuids
ORDER BY ctid DESC LIMIT 5

-- sqlfmt-corpus-separator --

SELECT id, abort_increasing, abort_decreasing, noabort_increasing, noabort_decreasing
FROM abbrev_abort_uuids
ORDER BY ctid LIMIT 5

-- sqlfmt-corpus-separator --

SELECT id, keywords, title, body, created
FROM articles
GROUP BY body

-- sqlfmt-corpus-separator --

SELECT id, keywords, title, body, created
FROM articles
GROUP BY id

-- sqlfmt-corpus-separator --

SELECT id, keywords, title, body, created
FROM articles
GROUP BY keywords

-- sqlfmt-corpus-separator --

SELECT id, keywords, title, body, created
FROM articles
GROUP BY title

-- sqlfmt-corpus-separator --

SELECT id, noabort_increasing, noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_decreasing LIMIT 5

-- sqlfmt-corpus-separator --

SELECT id, noabort_increasing, noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_increasing LIMIT 5

-- sqlfmt-corpus-separator --

SELECT indexdef FROM pg_indexes WHERE tablename = 'tbl' ORDER BY indexname

-- sqlfmt-corpus-separator --

SELECT indexdef FROM pg_indexes WHERE tablename = 'tbl_gist' ORDER BY indexname

-- sqlfmt-corpus-separator --

SELECT indexrelid, indrelid
FROM pg_index
WHERE indexrelid = 0 OR indrelid = 0 OR
      indnatts <= 0 OR indnatts > 32

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

SELECT isfalse AND isnul AND istrue FROM booltbl4

-- sqlfmt-corpus-separator --

SELECT isfalse OR isfalse OR isnul FROM booltbl4

-- sqlfmt-corpus-separator --

SELECT isfalse OR isnul OR isfalse FROM booltbl4

-- sqlfmt-corpus-separator --

SELECT isfalse OR isnul OR istrue FROM booltbl4

-- sqlfmt-corpus-separator --

SELECT isnul AND istrue AND isfalse FROM booltbl4

-- sqlfmt-corpus-separator --

SELECT isnul AND istrue AND istrue FROM booltbl4

-- sqlfmt-corpus-separator --

SELECT isnul OR isfalse OR isfalse FROM booltbl4

-- sqlfmt-corpus-separator --

SELECT isnul OR istrue OR isfalse FROM booltbl4

-- sqlfmt-corpus-separator --

SELECT istrue AND isfalse AND isnul FROM booltbl4

-- sqlfmt-corpus-separator --

SELECT istrue AND istrue AND isnul FROM booltbl4

-- sqlfmt-corpus-separator --

SELECT istrue OR isfalse OR isnul FROM booltbl4

-- sqlfmt-corpus-separator --

SELECT keyword FROM test_tsquery WHERE keyword <@ 'moscow'

-- sqlfmt-corpus-separator --

SELECT keyword FROM test_tsquery WHERE keyword <@ 'new'

-- sqlfmt-corpus-separator --

SELECT keyword FROM test_tsquery WHERE keyword @> 'moscow'

-- sqlfmt-corpus-separator --

SELECT keyword FROM test_tsquery WHERE keyword @> 'new'

-- sqlfmt-corpus-separator --

SELECT l.s, b.f1 FROM LINE_TBL l, BOX_TBL b WHERE l.s ?# b.f1

-- sqlfmt-corpus-separator --

SELECT l.s, b.f1 FROM LSEG_TBL l, BOX_TBL b WHERE l.s <@ b.f1

-- sqlfmt-corpus-separator --

SELECT l.s, b.f1 FROM LSEG_TBL l, BOX_TBL b WHERE l.s ?# b.f1

-- sqlfmt-corpus-separator --

SELECT l.s, b.f1, l.s ## b.f1 FROM LSEG_TBL l, BOX_TBL b

-- sqlfmt-corpus-separator --

SELECT l.s, b.f1, l.s <-> b.f1 AS dist_sb, b.f1 <-> l.s AS dist_bs FROM LSEG_TBL l, BOX_TBL b

-- sqlfmt-corpus-separator --

SELECT l.s, l1.s FROM LSEG_TBL l, LINE_TBL l1 WHERE l.s <@ l1.s

-- sqlfmt-corpus-separator --

SELECT l.s, l1.s FROM LSEG_TBL l, LINE_TBL l1 WHERE l.s ?# l1.s

-- sqlfmt-corpus-separator --

SELECT l.s, l1.s, l.s ## l1.s FROM LINE_TBL l, LSEG_TBL l1

-- sqlfmt-corpus-separator --

SELECT l.s, l1.s, l.s <-> l1.s AS dist_sl, l1.s <-> l.s AS dist_ls FROM LSEG_TBL l, LINE_TBL l1

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s FROM LINE_TBL l1, LINE_TBL l2 WHERE l1.s = l2.s

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s FROM LINE_TBL l1, LINE_TBL l2 WHERE l1.s ?# l2.s

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s FROM LINE_TBL l1, LINE_TBL l2 WHERE l1.s ?-| l2.s

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s FROM LINE_TBL l1, LINE_TBL l2 WHERE l1.s ?|| l2.s

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s != l2.s

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s < l2.s

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s <= l2.s

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s = l2.s

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s > l2.s

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s >= l2.s

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s ?-| l2.s

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s FROM LSEG_TBL l1, LSEG_TBL l2 WHERE l1.s ?|| l2.s

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s, l1.s # l2.s FROM LINE_TBL l1, LINE_TBL l2

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s, l1.s # l2.s FROM LSEG_TBL l1, LSEG_TBL l2

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s, l1.s ## l2.s FROM LSEG_TBL l1, LSEG_TBL l2

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s, l1.s <-> l2.s FROM LINE_TBL l1, LINE_TBL l2

-- sqlfmt-corpus-separator --

SELECT l1.s, l2.s, l1.s <-> l2.s FROM LSEG_TBL l1, LSEG_TBL l2

-- sqlfmt-corpus-separator --

SELECT line FROM reload_output ORDER BY lineno

-- sqlfmt-corpus-separator --

SELECT m != '$123.00' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m != '$124.00' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m * 2 FROM money_data

-- sqlfmt-corpus-separator --

SELECT m + '123' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m + '123.45' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m - '123.45' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m / 2 FROM money_data

-- sqlfmt-corpus-separator --

SELECT m < '$122.00' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m < '$124.00' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m <= '$122.99' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m <= '$123.00' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m = '$123.00' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m = '$123.01' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m > '$122.00' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m > '$124.00' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m >= '$123.00' FROM money_data

-- sqlfmt-corpus-separator --

SELECT m >= '$123.01' FROM money_data

-- sqlfmt-corpus-separator --

SELECT mapcfg, maptokentype, mapseqno
FROM pg_ts_config_map
WHERE mapcfg = 0 OR mapdict = 0

-- sqlfmt-corpus-separator --

SELECT n_tup_ins, n_live_tup, n_dead_tup
  FROM pg_stat_all_tables WHERE relname = 'test'

-- sqlfmt-corpus-separator --

SELECT n_tup_ins, n_live_tup, n_dead_tup
  FROM pg_stat_all_tables WHERE relname = 'test_2pc'

-- sqlfmt-corpus-separator --

SELECT n_tup_ins, n_live_tup, n_dead_tup
  FROM pg_stat_all_tables WHERE relname = 'test_2pc_abort'

-- sqlfmt-corpus-separator --

SELECT n_tup_ins, n_live_tup, n_dead_tup
  FROM pg_stat_all_tables WHERE relname = 'test_2pc_multi'

-- sqlfmt-corpus-separator --

SELECT n_tup_ins, n_live_tup, n_dead_tup
  FROM pg_stat_all_tables WHERE relname = 'test_2pc_rewrite_alone'

-- sqlfmt-corpus-separator --

SELECT n_tup_ins, n_live_tup, n_dead_tup
  FROM pg_stat_all_tables WHERE relname = 'test_2pc_rewrite_alone_abort'

-- sqlfmt-corpus-separator --

SELECT n_tup_ins, n_live_tup, n_dead_tup
  FROM pg_stat_all_tables WHERE relname = 'test_2pc_savepoint'

-- sqlfmt-corpus-separator --

SELECT n_tup_ins, n_live_tup, n_dead_tup
  FROM pg_stat_all_tables WHERE relname = 'test_abort'

-- sqlfmt-corpus-separator --

SELECT n_tup_ins, n_live_tup, n_dead_tup
  FROM pg_stat_all_tables WHERE relname = 'test_alone'

-- sqlfmt-corpus-separator --

SELECT n_tup_ins, n_live_tup, n_dead_tup
  FROM pg_stat_all_tables WHERE relname = 'test_multi'

-- sqlfmt-corpus-separator --

SELECT n_tup_ins, n_live_tup, n_dead_tup
  FROM pg_stat_all_tables WHERE relname = 'test_rewrite_alone_abort'

-- sqlfmt-corpus-separator --

SELECT n_tup_ins, n_live_tup, n_dead_tup
  FROM pg_stat_all_tables WHERE relname = 'test_savepoint'

-- sqlfmt-corpus-separator --

SELECT n_tup_ins, n_live_tup, n_dead_tup
  FROM pg_stat_all_tables WHERE relname = 'test_tbs'

-- sqlfmt-corpus-separator --

SELECT name FROM pg_cursors

-- sqlfmt-corpus-separator --

SELECT name FROM pg_cursors ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT name FROM pg_prepared_statements

-- sqlfmt-corpus-separator --

SELECT name FROM tab_settings_flags
  WHERE NOT category = 'Preset Options' AND runtime_computed
  ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT name FROM tab_settings_flags
  WHERE category = 'Developer Options' AND NOT not_in_sample
  ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT name FROM tab_settings_flags
  WHERE category = 'Preset Options' AND NOT not_in_sample
  ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT name FROM tab_settings_flags
  WHERE category ~ '^Query Tuning' AND NOT explain
  ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT name FROM tab_settings_flags
  WHERE no_reset AND NOT no_reset_all
  ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT name, statement, is_holdable, is_binary, is_scrollable FROM pg_cursors

-- sqlfmt-corpus-separator --

SELECT name, statement, is_holdable, is_binary, is_scrollable FROM pg_cursors ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT name, statement, parameter_types FROM pg_prepared_statements
    ORDER BY name

-- sqlfmt-corpus-separator --

SELECT name, statement, parameter_types, result_types FROM pg_prepared_statements

-- sqlfmt-corpus-separator --

SELECT name, statement, parameter_types, result_types FROM pg_prepared_statements
    ORDER BY name

-- sqlfmt-corpus-separator --

SELECT noabort_increasing, noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_decreasing NULLS FIRST OFFSET 20000 - 4

-- sqlfmt-corpus-separator --

SELECT noabort_increasing, noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_increasing OFFSET 20000 - 4

-- sqlfmt-corpus-separator --

SELECT nspname, rolname FROM pg_namespace, pg_roles WHERE pg_namespace.nspname = 'testns' AND pg_namespace.nspowner = pg_roles.oid

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprcode, o2.oid, o2.oprcode
FROM pg_operator AS o1, pg_operator AS o2
WHERE o1.oid != o2.oid AND
    o1.oprname = o2.oprname AND
    o1.oprkind = o2.oprkind AND
    o1.oprleft = o2.oprleft AND
    o1.oprright = o2.oprright

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

SELECT o1.oid, o1.oprname
FROM pg_operator as o1
WHERE (o1.oprkind != 'b' AND o1.oprkind != 'l') OR
    o1.oprresult = 0 OR o1.oprcode = 0

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname
FROM pg_operator as o1
WHERE (o1.oprleft = 0 and o1.oprkind != 'l') OR
    (o1.oprleft != 0 and o1.oprkind = 'l') OR
    o1.oprright = 0

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname, o2.oid, o2.oprname
FROM pg_operator AS o1, pg_operator AS o2
WHERE o1.oprcom = o2.oid AND
    (o1.oprcanmerge != o2.oprcanmerge OR
     o1.oprcanhash != o2.oprcanhash)

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname, p.amopfamily
FROM pg_operator AS o1, pg_amop p
WHERE amopopr = o1.oid
  AND amopmethod = (SELECT oid FROM pg_am WHERE amname = 'btree')
  AND amopstrategy = 3
  AND NOT o1.oprcanmerge

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname, p.amopfamily
FROM pg_operator AS o1, pg_amop p
WHERE amopopr = o1.oid
  AND amopmethod = (SELECT oid FROM pg_am WHERE amname = 'hash')
  AND NOT o1.oprcanhash

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname, p1.oid, p1.proname
FROM pg_operator AS o1, pg_proc AS p1
WHERE o1.oprcode = p1.oid AND
    (o1.oprcanmerge OR o1.oprcanhash) AND
    p1.provolatile = 'v'

-- sqlfmt-corpus-separator --

SELECT oid FROM pg_class WHERE relname = 'disappear'

-- sqlfmt-corpus-separator --

SELECT oid, cfgname
FROM pg_ts_config
WHERE cfgnamespace = 0 OR cfgowner = 0 OR cfgparser = 0

-- sqlfmt-corpus-separator --

SELECT oid, dictname
FROM pg_ts_dict
WHERE dictnamespace = 0 OR dictowner = 0 OR dicttemplate = 0

-- sqlfmt-corpus-separator --

SELECT oid, opfname FROM pg_opfamily f
WHERE NOT EXISTS (SELECT 1 FROM pg_opclass WHERE opcfamily = f.oid)

-- sqlfmt-corpus-separator --

SELECT oid, proname
FROM pg_proc as p
WHERE p.prokind = 'a' AND
    NOT EXISTS (SELECT 1 FROM pg_aggregate a WHERE a.aggfnoid = p.oid)

-- sqlfmt-corpus-separator --

SELECT oid, tmplname
FROM pg_ts_template
WHERE tmplnamespace = 0 OR tmpllexize = 0

-- sqlfmt-corpus-separator --

SELECT one FROM atest5

-- sqlfmt-corpus-separator --

SELECT one, two FROM atest5

-- sqlfmt-corpus-separator --

SELECT p, dist FROM quad_point_tbl_ord_seq1 ORDER BY p <-> '0,0' LIMIT 10

-- sqlfmt-corpus-separator --

SELECT p.f1, b.f1, p.f1 ## b.f1 FROM POINT_TBL p, BOX_TBL b

-- sqlfmt-corpus-separator --

SELECT p.f1, b.f1, p.f1 <-> b.f1 AS dist_pb, b.f1 <-> p.f1 AS dist_bp FROM POINT_TBL p, BOX_TBL b

-- sqlfmt-corpus-separator --

SELECT p.f1, l.s FROM POINT_TBL p, LINE_TBL l WHERE p.f1 <@ l.s

-- sqlfmt-corpus-separator --

SELECT p.f1, l.s FROM POINT_TBL p, LSEG_TBL l WHERE p.f1 <@ l.s

-- sqlfmt-corpus-separator --

SELECT p.f1, l.s, l.s # p.f1 AS intersection
   FROM LSEG_TBL l, POINT_TBL p

-- sqlfmt-corpus-separator --

SELECT p.f1, l.s, p.f1 ## l.s FROM POINT_TBL p, LINE_TBL l

-- sqlfmt-corpus-separator --

SELECT p.f1, l.s, p.f1 ## l.s FROM POINT_TBL p, LSEG_TBL l

-- sqlfmt-corpus-separator --

SELECT p.f1, l.s, p.f1 <-> l.s AS dist_pl, l.s <-> p.f1 AS dist_lp FROM POINT_TBL p, LINE_TBL l

-- sqlfmt-corpus-separator --

SELECT p.f1, l.s, p.f1 <-> l.s AS dist_ps, l.s <-> p.f1 AS dist_sp FROM POINT_TBL p, LSEG_TBL l

-- sqlfmt-corpus-separator --

SELECT p.f1, p1.f1 FROM POINT_TBL p, PATH_TBL p1 WHERE p.f1 <@ p1.f1

-- sqlfmt-corpus-separator --

SELECT p.f1, p1.f1, p.f1 * p1.f1 FROM PATH_TBL p, POINT_TBL p1

-- sqlfmt-corpus-separator --

SELECT p.f1, p1.f1, p.f1 + p1.f1 FROM PATH_TBL p, POINT_TBL p1

-- sqlfmt-corpus-separator --

SELECT p.f1, p1.f1, p.f1 - p1.f1 FROM PATH_TBL p, POINT_TBL p1

-- sqlfmt-corpus-separator --

SELECT p.f1, p1.f1, p.f1 <-> p1.f1 AS dist_ppath, p1.f1 <-> p.f1 AS dist_pathp FROM POINT_TBL p, PATH_TBL p1

-- sqlfmt-corpus-separator --

SELECT p.f1, p1.f1, p.f1 <-> p1.f1 AS dist_ppoly, p1.f1 <-> p.f1 AS dist_polyp FROM POINT_TBL p, POLYGON_TBL p1

-- sqlfmt-corpus-separator --

SELECT p.f1, poly.f1, p.f1 <@ poly.f1 AS contained
   FROM POLYGON_TBL poly, POINT_TBL p

-- sqlfmt-corpus-separator --

SELECT p.f1, poly.f1, poly.f1 @> p.f1 AS contains
   FROM POLYGON_TBL poly, POINT_TBL p

-- sqlfmt-corpus-separator --

SELECT p1.f1 AS point1, p2.f1 AS point2
   FROM POINT_TBL p1, POINT_TBL p2
   WHERE (p1.f1 <-> p2.f1) > 3

-- sqlfmt-corpus-separator --

SELECT p1.f1 AS point1, p2.f1 AS point2, (p1.f1 <-> p2.f1) AS distance
   FROM POINT_TBL p1, POINT_TBL p2
   WHERE (p1.f1 <-> p2.f1) > 3 and p1.f1 << p2.f1 and p1.f1 |>> p2.f1
   ORDER BY distance

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM PATH_TBL p1, PATH_TBL p2 WHERE p1.f1 < p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM PATH_TBL p1, PATH_TBL p2 WHERE p1.f1 <= p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM PATH_TBL p1, PATH_TBL p2 WHERE p1.f1 = p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM PATH_TBL p1, PATH_TBL p2 WHERE p1.f1 > p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM PATH_TBL p1, PATH_TBL p2 WHERE p1.f1 >= p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 && p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 &< p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 &<| p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 &> p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 << p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 <<| p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 <@ p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 >> p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 @> p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 |&> p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 |>> p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2 WHERE p1.f1 ~= p2.f1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1, p1.f1 + p2.f1 FROM PATH_TBL p1, PATH_TBL p2

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1, p1.f1 + p2.f1 FROM POINT_TBL p1, POINT_TBL p2

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1, p1.f1 - p2.f1 FROM POINT_TBL p1, POINT_TBL p2

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1, p1.f1 <-> p2.f1 FROM PATH_TBL p1, PATH_TBL p2

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1, p1.f1 <-> p2.f1 FROM POLYGON_TBL p1, POLYGON_TBL p2

-- sqlfmt-corpus-separator --

SELECT p1.oid, p1.proname
FROM pg_proc AS p1
WHERE proretset AND prokind != 'f'

-- sqlfmt-corpus-separator --

SELECT p1.oid, p1.proname
FROM pg_proc AS p1
WHERE prosecdef
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT p1.oid, p1.proname
FROM pg_proc AS p1
WHERE provolatile = 'i' AND proparallel = 'u'

-- sqlfmt-corpus-separator --

SELECT p1.oid, p1.proname, p2.oid, p2.proname
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.proname = p2.proname AND
    p1.pronargs = p2.pronargs AND
    p1.proargtypes = p2.proargtypes

-- sqlfmt-corpus-separator --

SELECT pg_class.relname FROM pg_index, pg_class, pg_class AS pg_class_2
WHERE pg_class.oid=indexrelid
	AND indrelid=pg_class_2.oid
	AND pg_class_2.relname = 'clstr_tst'
	AND indisclustered

-- sqlfmt-corpus-separator --

SELECT pubname, puballtables, puballsequences FROM pg_publication WHERE pubname = 'regress_pub_for_allsequences_alltables'

-- sqlfmt-corpus-separator --

SELECT pubname, puballtables, puballsequences FROM pg_publication WHERE pubname = 'regress_pub_forallsequences1'

-- sqlfmt-corpus-separator --

SELECT q1 * 2 AS "twice int4" FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT q1 AS plus, -q1 AS minus FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT q1, q1 << 2 AS "shl", q1 >> 3 AS "shr" FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT q1, q2, q1 & q2 AS "and", q1 | q2 AS "or", q1 # q2 AS "xor", ~q1 AS "not" FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT q1, q2, q1 * q2 AS multiply FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT q1, q2, q1 * q2 AS multiply FROM INT8_TBL
 WHERE q1 < 1000 or (q2 > 0 and q2 < 1000)

-- sqlfmt-corpus-separator --

SELECT q1, q2, q1 + q2 AS plus FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT q1, q2, q1 - q2 AS minus FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT q1, q2, q1 / q2 AS divide, q1 % q2 AS mod FROM INT8_TBL

-- sqlfmt-corpus-separator --

SELECT r.rngtypid, r.rngsubtype
FROM pg_range as r
WHERE r.rngtypid = 0 OR r.rngsubtype = 0 OR r.rngsubopc = 0
    OR r.rngconstruct2 = 0 OR r.rngconstruct3 = 0
    OR r.rngmltconstruct0 = 0 OR r.rngmltconstruct1 = 0 OR r.rngmltconstruct2 = 0

-- sqlfmt-corpus-separator --

SELECT range_length_histogram, range_empty_frac, range_bounds_histogram
   FROM pg_stats_ext_exprs
   WHERE statistics_name = 'stats_ext_range'

-- sqlfmt-corpus-separator --

SELECT relam FROM pg_class WHERE relname = 'am_partitioned'

-- sqlfmt-corpus-separator --

SELECT relkind FROM pg_class WHERE relname = 'partitioned'

-- sqlfmt-corpus-separator --

SELECT relname FROM pg_class WHERE relname = 'reset_test'

-- sqlfmt-corpus-separator --

SELECT relname FROM pg_class WHERE relname ~* '^abc'

-- sqlfmt-corpus-separator --

SELECT relname from pg_class where relname = 'tmp_foo'

-- sqlfmt-corpus-separator --

SELECT relname, attname, attcollation
FROM pg_class c, pg_attribute a
WHERE c.oid = attrelid AND c.oid < 16384 AND
    c.relkind != 'v' AND  -- we don't care about columns in views
    attcollation != 0 AND
    attcollation != (SELECT oid FROM pg_collation WHERE collname = 'C')

-- sqlfmt-corpus-separator --

SELECT relname, relkind, relpersistence FROM pg_class WHERE relname ~ '^unlogged\d' ORDER BY relname

-- sqlfmt-corpus-separator --

SELECT relname, relpersistence FROM pg_class
  WHERE relname ~ '^identity_dump_' ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT relname, spcname FROM pg_catalog.pg_tablespace t, pg_catalog.pg_class c
    where c.reltablespace = t.oid AND c.relname = 'asexecute'

-- sqlfmt-corpus-separator --

SELECT relname, spcname FROM pg_catalog.pg_tablespace t, pg_catalog.pg_class c
    where c.reltablespace = t.oid AND c.relname = 'asselect'

-- sqlfmt-corpus-separator --

SELECT relname, spcname FROM pg_catalog.pg_tablespace t, pg_catalog.pg_class c
    where c.reltablespace = t.oid AND c.relname = 'foo'

-- sqlfmt-corpus-separator --

SELECT relname, spcname FROM pg_catalog.pg_tablespace t, pg_catalog.pg_class c
    where c.reltablespace = t.oid AND c.relname = 'foo_idx'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_bypassrls'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_createdb'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_createrole'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_def_bypassrls'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_def_createdb'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_def_createrole'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_def_inherit'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_def_replication'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_def_role_canlogin'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_def_superuser'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_def_user_canlogin'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_inherit'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_replication'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_role_canlogin'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_superuser'

-- sqlfmt-corpus-separator --

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolbypassrls, rolconnlimit, rolpassword, rolvaliduntil FROM pg_authid WHERE rolname = 'regress_test_user_canlogin'

-- sqlfmt-corpus-separator --

SELECT rolpassword FROM pg_authid WHERE rolname='regress_passwd_empty'

-- sqlfmt-corpus-separator --

SELECT routine_name, sequence_name FROM information_schema.routine_sequence_usage
  WHERE routine_schema = 'temp_func_test'
  ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT routine_name, table_name FROM information_schema.routine_table_usage
  WHERE routine_schema = 'temp_func_test'
  ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT routine_name, table_name, column_name FROM information_schema.routine_column_usage
  WHERE routine_schema = 'temp_func_test'
  ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT sequence_name FROM itest4_a_seq

-- sqlfmt-corpus-separator --

SELECT session_user, current_user

-- sqlfmt-corpus-separator --

SELECT span * 8.2 AS product
FROM INTERVAL_MULDIV_TBL

-- sqlfmt-corpus-separator --

SELECT span / 10 AS quotient
FROM INTERVAL_MULDIV_TBL

-- sqlfmt-corpus-separator --

SELECT span / 100 AS quotient
FROM INTERVAL_MULDIV_TBL

-- sqlfmt-corpus-separator --

SELECT spcoptions FROM pg_tablespace WHERE spcname = 'regress_tblspacewith'

-- sqlfmt-corpus-separator --

SELECT srvname, srvoptions FROM pg_foreign_server

-- sqlfmt-corpus-separator --

SELECT st.heap_blks_read + st.heap_blks_hit >= pr.heap_blks + cl.relpages,
       st.idx_blks_read + st.idx_blks_hit >= pr.idx_blks + 1
  FROM pg_statio_user_tables AS st, pg_class AS cl, prevstats AS pr
 WHERE st.relname='tenk2' AND cl.relname='tenk2'

-- sqlfmt-corpus-separator --

SELECT st.seq_scan >= pr.seq_scan + 1,
       st.seq_tup_read >= pr.seq_tup_read + cl.reltuples,
       st.idx_scan >= pr.idx_scan + 1,
       st.idx_tup_fetch >= pr.idx_tup_fetch + 1
  FROM pg_stat_user_tables AS st, pg_class AS cl, prevstats AS pr
 WHERE st.relname='tenk2' AND cl.relname='tenk2'

-- sqlfmt-corpus-separator --

SELECT stringu1 FROM onek WHERE stringu1 = 'DZAAAA'

-- sqlfmt-corpus-separator --

SELECT stxkind FROM pg_statistic_ext WHERE stxname = 'ab1_exprstat_2'

-- sqlfmt-corpus-separator --

SELECT stxkind FROM pg_statistic_ext WHERE stxname = 'ab1_exprstat_3'

-- sqlfmt-corpus-separator --

SELECT t1.a, t1.c, t2.b, t2.c FROM prt1 t1, prt2 t2 WHERE t1.a = t2.a AND t1.a = t2.b ORDER BY t1.a, t2.b

-- sqlfmt-corpus-separator --

SELECT t1.a, t1.c, t2.b, t2.c FROM prt1 t1, prt2 t2 WHERE t1.a = t2.b AND t1.a < 450 AND t2.b > 250 AND t1.b = 0 ORDER BY t1.a, t2.b

-- sqlfmt-corpus-separator --

SELECT t1.a, t1.c, t2.b, t2.c FROM prt1 t1, prt2 t2 WHERE t1.a = t2.b AND t1.b = 0 ORDER BY t1.a, t2.b

-- sqlfmt-corpus-separator --

SELECT t1.a, t1.c, t2.b, t2.c FROM prt1_e t1, prt2_e t2 WHERE (t1.a + t1.b)/2 = (t2.b + t2.a)/2 AND t1.c = 0 ORDER BY t1.a, t2.b

-- sqlfmt-corpus-separator --

SELECT t1.a, t1.c, t2.b, t2.c FROM prt1_l t1, prt2_l t2 WHERE t1.a = t2.a AND t1.a = t2.b AND t1.c = t2.c ORDER BY t1.a, t2.b

-- sqlfmt-corpus-separator --

SELECT t1.a, t1.c, t2.b, t2.c FROM prt1_l t1, prt2_l t2 WHERE t1.a = t2.b AND t1.b = 0 ORDER BY t1.a, t2.b

-- sqlfmt-corpus-separator --

SELECT t1.a, t1.c, t2.b, t2.c, t3.a + t3.b, t3.c FROM prt1 t1, prt2 t2, prt1_e t3 WHERE t1.a = t2.b AND t1.a = (t3.a + t3.b)/2 AND t1.b = 0 ORDER BY t1.a, t2.b

-- sqlfmt-corpus-separator --

SELECT t1.a, t2.e
  FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)
  WHERE t1.a = t2.d

-- sqlfmt-corpus-separator --

SELECT t1.id1, t1.id2, t1.result, t2.expected
    FROM num_result t1, num_exp_add t2
    WHERE t1.id1 = t2.id1 AND t1.id2 = t2.id2
    AND t1.result != t2.expected

-- sqlfmt-corpus-separator --

SELECT t1.id1, t1.id2, t1.result, t2.expected
    FROM num_result t1, num_exp_div t2
    WHERE t1.id1 = t2.id1 AND t1.id2 = t2.id2
    AND t1.result != t2.expected

-- sqlfmt-corpus-separator --

SELECT t1.id1, t1.id2, t1.result, t2.expected
    FROM num_result t1, num_exp_mul t2
    WHERE t1.id1 = t2.id1 AND t1.id2 = t2.id2
    AND t1.result != t2.expected

-- sqlfmt-corpus-separator --

SELECT t1.id1, t1.id2, t1.result, t2.expected
    FROM num_result t1, num_exp_sub t2
    WHERE t1.id1 = t2.id1 AND t1.id2 = t2.id2
    AND t1.result != t2.expected

-- sqlfmt-corpus-separator --

SELECT t1.id1, t1.result, t2.expected
    FROM num_result t1, num_exp_ln t2
    WHERE t1.id1 = t2.id
    AND t1.result != t2.expected

-- sqlfmt-corpus-separator --

SELECT t1.id1, t1.result, t2.expected
    FROM num_result t1, num_exp_log10 t2
    WHERE t1.id1 = t2.id
    AND t1.result != t2.expected

-- sqlfmt-corpus-separator --

SELECT t1.id1, t1.result, t2.expected
    FROM num_result t1, num_exp_power_10_ln t2
    WHERE t1.id1 = t2.id
    AND t1.result != t2.expected

-- sqlfmt-corpus-separator --

SELECT t1.id1, t1.result, t2.expected
    FROM num_result t1, num_exp_sqrt t2
    WHERE t1.id1 = t2.id
    AND t1.result != t2.expected

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname
FROM pg_type as t1
WHERE (t1.typinput = 0 OR t1.typoutput = 0)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname
FROM pg_type as t1
WHERE (t1.typtype = 'c' AND t1.typrelid = 0) OR
    (t1.typtype != 'c' AND t1.typrelid != 0)

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

SELECT t1.oid, t1.typname, p1.oid, p1.proname, p2.oid, p2.proname
FROM pg_type AS t1, pg_proc AS p1, pg_proc AS p2
WHERE t1.typinput = p1.oid AND t1.typreceive = p2.oid AND
    p1.pronargs != p2.pronargs

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, t1.typelem
FROM pg_type AS t1
WHERE t1.typelem != 0 AND t1.typsubscript = 0

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, t2.oid, t2.typname
FROM pg_type AS t1, pg_type AS t2
WHERE t1.typarray = t2.oid AND NOT (t1.typdelim = t2.typdelim)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, t2.oid, t2.typname
FROM pg_type AS t1, pg_type AS t2
WHERE t1.typelem = t2.oid AND NOT
    (t1.typmodin = t2.typmodin AND t1.typmodout = t2.typmodout)

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, column_default, is_nullable, is_generated, generation_expression FROM information_schema.columns WHERE table_schema = 'generated_stored_tests' ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, column_default, is_nullable, is_generated, generation_expression FROM information_schema.columns WHERE table_schema = 'generated_virtual_tests' ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, dependent_column FROM information_schema.column_column_usage WHERE table_schema = 'generated_stored_tests' ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, dependent_column FROM information_schema.column_column_usage WHERE table_schema = 'generated_virtual_tests' ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, is_identity, identity_generation FROM information_schema.columns WHERE table_name = 'itest6' ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, is_updatable
  FROM information_schema.columns
 WHERE table_name = 'rw_view1'
 ORDER BY ordinal_position

-- sqlfmt-corpus-separator --

SELECT table_name, column_name, is_updatable
  FROM information_schema.columns
 WHERE table_name = 'rw_view2'
 ORDER BY ordinal_position

-- sqlfmt-corpus-separator --

SELECT table_name, is_insertable_into
  FROM information_schema.tables
 WHERE table_name = 'rw_view1'

-- sqlfmt-corpus-separator --

SELECT table_name, is_insertable_into
  FROM information_schema.tables
 WHERE table_name = 'rw_view2'

-- sqlfmt-corpus-separator --

SELECT table_name, is_updatable, is_insertable_into
  FROM information_schema.views
 WHERE table_name = 'rw_view1'

-- sqlfmt-corpus-separator --

SELECT table_name, is_updatable, is_insertable_into
  FROM information_schema.views
 WHERE table_name = 'rw_view2'

-- sqlfmt-corpus-separator --

SELECT tablename, rulename, definition FROM pg_rules
	WHERE tablename = 'hats'

-- sqlfmt-corpus-separator --

SELECT tablename, rulename, definition FROM pg_rules
WHERE schemaname = 'pg_catalog'
ORDER BY tablename, rulename

-- sqlfmt-corpus-separator --

SELECT tableoid FROM atestp2

-- sqlfmt-corpus-separator --

SELECT test_json -> 'field2' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json -> 'x'
FROM test_json
WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json -> 'x'
FROM test_json
WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json -> 'x'
FROM test_json
WHERE json_type = 'scalar'

-- sqlfmt-corpus-separator --

SELECT test_json -> 'x' FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json -> 'x' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json -> 'x' FROM test_jsonb WHERE json_type = 'scalar'

-- sqlfmt-corpus-separator --

SELECT test_json -> -1
FROM test_json
WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json -> 2
FROM test_json
WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json -> 2
FROM test_json
WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json -> 2
FROM test_json
WHERE json_type = 'scalar'

-- sqlfmt-corpus-separator --

SELECT test_json -> 2 FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json -> 2 FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json -> 2 FROM test_jsonb WHERE json_type = 'scalar'

-- sqlfmt-corpus-separator --

SELECT test_json -> 9 FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field2' FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field2' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field2' FROM test_jsonb WHERE json_type = 'scalar'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field4' FROM test_json WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field4' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field5' FROM test_json WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field5' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field6' FROM test_json WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field6' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 2 FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 2 FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 2 FROM test_jsonb WHERE json_type = 'scalar'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 6 FROM test_json WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 6 FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 7 FROM test_json WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 7 FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json->'field2'
FROM test_json
WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json->>'field2'
FROM test_json
WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json->>2
FROM test_json
WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT thousand, tenthous FROM tenk1
WHERE thousand < 3 and thousand <= 2 AND tenthous = 1001
ORDER BY thousand

-- sqlfmt-corpus-separator --

SELECT thousand, tenthous FROM tenk1
WHERE thousand > -1 and thousand >= 0 AND tenthous = 3000
ORDER BY thousand

-- sqlfmt-corpus-separator --

SELECT trans_foo

-- sqlfmt-corpus-separator --

SELECT true AS true

-- sqlfmt-corpus-separator --

SELECT two FROM atest5

-- sqlfmt-corpus-separator --

SELECT typinput, typoutput, typreceive, typsend, typmodin, typmodout,
       typanalyze, typsubscript, typstorage
FROM pg_type WHERE typname = '_myvarchar'

-- sqlfmt-corpus-separator --

SELECT typinput, typoutput, typreceive, typsend, typmodin, typmodout,
       typanalyze, typsubscript, typstorage
FROM pg_type WHERE typname = '_myvarchardom'

-- sqlfmt-corpus-separator --

SELECT typinput, typoutput, typreceive, typsend, typmodin, typmodout,
       typanalyze, typsubscript, typstorage
FROM pg_type WHERE typname = 'myvarchar'

-- sqlfmt-corpus-separator --

SELECT typinput, typoutput, typreceive, typsend, typmodin, typmodout,
       typanalyze, typsubscript, typstorage
FROM pg_type WHERE typname = 'myvarchardom'

-- sqlfmt-corpus-separator --

SELECT unique1 FROM tenk1 WHERE unique1 < 3 and unique1 <= 3

-- sqlfmt-corpus-separator --

SELECT unique1 FROM tenk1 WHERE unique1 < 5

-- sqlfmt-corpus-separator --

SELECT unique1 FROM tenk1 WHERE unique1 > 9996 and unique1 >= 9999

-- sqlfmt-corpus-separator --

SELECT unique1, unique2 FROM onek_with_null
  ORDER BY unique2 DESC LIMIT 5

-- sqlfmt-corpus-separator --

SELECT unique1, unique2 FROM onek_with_null
  ORDER BY unique2 LIMIT 2

-- sqlfmt-corpus-separator --

SELECT unique1, unique2 FROM onek_with_null WHERE unique1 = 500 ORDER BY unique2 DESC, unique1 DESC LIMIT 1

-- sqlfmt-corpus-separator --

SELECT unique1, unique2 FROM onek_with_null WHERE unique2 < 999
  ORDER BY unique2 DESC LIMIT 2

-- sqlfmt-corpus-separator --

SELECT unique1, unique2 FROM onek_with_null WHERE unique2 >= -1
  ORDER BY unique2 DESC LIMIT 3

-- sqlfmt-corpus-separator --

SELECT unique1, unique2 FROM onek_with_null WHERE unique2 >= -1
  ORDER BY unique2 LIMIT 2

-- sqlfmt-corpus-separator --

SELECT unique1, unique2 FROM onek_with_null WHERE unique2 >= 0
  ORDER BY unique2 LIMIT 2

-- sqlfmt-corpus-separator --

SELECT v, b, (v || b) AS concat
       FROM BIT_TABLE, VARBIT_TABLE
       ORDER BY 3

-- sqlfmt-corpus-separator --

SELECT v, v >> 1 AS vsr, v << 1 AS vsl
       FROM VARBIT_SHIFT_TABLE

-- sqlfmt-corpus-separator --

SELECT v, v >> 8 AS vsr8, v << 8 AS vsl8
       FROM VARBIT_SHIFT_TABLE

-- sqlfmt-corpus-separator --

SELECT x FROM test3bpci WHERE x <> 'abc'

-- sqlfmt-corpus-separator --

SELECT x FROM test3bpci WHERE x = 'abc'

-- sqlfmt-corpus-separator --

SELECT x FROM test3bpci WHERE x ~ 'a'

-- sqlfmt-corpus-separator --

SELECT x FROM test3ci WHERE x <> 'abc'

-- sqlfmt-corpus-separator --

SELECT x FROM test3ci WHERE x = 'abc'

-- sqlfmt-corpus-separator --

SELECT x FROM test3ci WHERE x ~ 'a'

-- sqlfmt-corpus-separator --

SELECT x FROM test3cs WHERE x <> 'abc'

-- sqlfmt-corpus-separator --

SELECT x FROM test3cs WHERE x = 'abc'

-- sqlfmt-corpus-separator --

SELECT x FROM test3cs WHERE x ~ 'a'

-- sqlfmt-corpus-separator --

SELECT x' 0'

-- sqlfmt-corpus-separator --

SELECT x'0 '

-- sqlfmt-corpus-separator --

SELECT ~b                       FROM macaddr8_data

-- sqlfmt-corpus-separator --

SELECT ~b                       FROM macaddr_data

-- sqlfmt-corpus-separator --

WITH foo AS (SELECT * FROM gtest1) SELECT * FROM foo

-- sqlfmt-corpus-separator --

WITH q1(x,y) AS (SELECT 1,2)
SELECT * FROM q1, q1 AS q2

-- sqlfmt-corpus-separator --

WITH x(n, b) AS (SELECT 1)
SELECT * FROM x

-- sqlfmt-corpus-separator --

select

-- sqlfmt-corpus-separator --

select  interval '0'                                AS "zero",
        interval '1-2'                              AS "a year 2 months",
        interval '1 2:03:04'                        AS "a bit over a day",
        interval '2:03:04.45679'                    AS "a bit over 2 hours",
        (interval '1-2' + interval '3 4:05:06.7')   AS "all fields",
        (interval '1-2' - interval '3 4:05:06.7')   AS "mixed sign",
        (- interval '1-2' + interval '3 4:05:06.7') AS "negative"

-- sqlfmt-corpus-separator --

select  interval 'P0002'                  AS "year only",
        interval 'P0002-10'               AS "year month",
        interval 'P0002-10-15'            AS "year month day",
        interval 'P0002T1S'               AS "year only plus time",
        interval 'P0002-10T1S'            AS "year month plus time",
        interval 'P0002-10-15T1S'         AS "year month day plus time",
        interval 'PT10'                   AS "hour only",
        interval 'PT10:30'                AS "hour minute"

-- sqlfmt-corpus-separator --

select  interval 'P00021015T103020'       AS "ISO8601 Basic Format",
        interval 'P0002-10-15T10:30:20'   AS "ISO8601 Extended Format"

-- sqlfmt-corpus-separator --

select  interval 'P0Y'                    AS "zero",
        interval 'P1Y2M'                  AS "a year 2 months",
        interval 'P1W'                    AS "a week",
        interval 'P1DT2H3M4S'             AS "a bit over a day",
        interval 'P1Y2M3DT4H5M6.7S'       AS "all fields",
        interval 'P-1Y-2M-3DT-4H-5M-6.7S' AS "negative",
        interval 'PT-0.1S'                AS "fractional second"

-- sqlfmt-corpus-separator --

select "........pg.dropped.1........" from atacc1

-- sqlfmt-corpus-separator --

select "........pg.dropped.1........",b,c,d from atacc1

-- sqlfmt-corpus-separator --

select 'Programmer' ~ '(\w).*?\1' as t

-- sqlfmt-corpus-separator --

select '\.' as data

-- sqlfmt-corpus-separator --

select 'a' ~ '$($$)+'

-- sqlfmt-corpus-separator --

select 'a' ~ '$()|^\1'

-- sqlfmt-corpus-separator --

select 'a' ~ '($^)+'

-- sqlfmt-corpus-separator --

select 'a' ~ '($|^)*'

-- sqlfmt-corpus-separator --

select 'a' ~ '((((((a)*)*)*)*)*)*'

-- sqlfmt-corpus-separator --

select 'a' ~ '((((((a+|)+|)+|)+|)+|)+|)'

-- sqlfmt-corpus-separator --

select 'a' ~ '()*\1'

-- sqlfmt-corpus-separator --

select 'a' ~ '()+\1'

-- sqlfmt-corpus-separator --

select 'a' ~ '(^$)*'

-- sqlfmt-corpus-separator --

select 'a' ~ '(^)+^'

-- sqlfmt-corpus-separator --

select 'a' ~ '.. ()|\1'

-- sqlfmt-corpus-separator --

select 'a' ~ '\x7fffffff'

-- sqlfmt-corpus-separator --

select 'a' ~ '^abcd*(((((^(a c(e?d)a+|)+|)+|)+|)+|a)+|)'

-- sqlfmt-corpus-separator --

select 'aa bb cc' ~ '(^(?!aa))+'

-- sqlfmt-corpus-separator --

select 'aa x' ~ '(^(?!aa)(?!bb)(?!cc))+'

-- sqlfmt-corpus-separator --

select 'abadef' ~ '^((.)\2|..)\2' as f

-- sqlfmt-corpus-separator --

select 'abc abc abc' ~ '^(.+)( \1)+$' as t

-- sqlfmt-corpus-separator --

select 'abc abc abc' ~ '^(\w+)( \1)+$' as t

-- sqlfmt-corpus-separator --

select 'abc abc abd' ~ '^(.+)( \1)+$' as f

-- sqlfmt-corpus-separator --

select 'abc abc abd' ~ '^(\w+)( \1)+$' as f

-- sqlfmt-corpus-separator --

select 'abc abd abc' ~ '^(.+)( \1)+$' as f

-- sqlfmt-corpus-separator --

select 'abc abd abc' ~ '^(\w+)( \1)+$' as f

-- sqlfmt-corpus-separator --

select 'abcdef' ~ '^(.)\1|\1.' as f

-- sqlfmt-corpus-separator --

select 'b' ~ '^([bc])\1*$' as t

-- sqlfmt-corpus-separator --

select 'bb x' ~ '(^(?!aa)(?!bb)(?!cc))+'

-- sqlfmt-corpus-separator --

select 'bbbbb' ~ '^([bc])\1*$' as t

-- sqlfmt-corpus-separator --

select 'bbc' ~ '^([bc])\1*$' as f

-- sqlfmt-corpus-separator --

select 'cc x' ~ '(^(?!aa)(?!bb)(?!cc))+'

-- sqlfmt-corpus-separator --

select 'ccc' ~ '^([bc])\1*$' as t

-- sqlfmt-corpus-separator --

select 'dd x' ~ '(^(?!aa)(?!bb)(?!cc))+'

-- sqlfmt-corpus-separator --

select 'four: ' || 2+2

-- sqlfmt-corpus-separator --

select 'still okay'

-- sqlfmt-corpus-separator --

select 'x'  ~ 'x(?![xy])'

-- sqlfmt-corpus-separator --

select 'x' ~ 'a^(^)bcd*xy(((((($a+|)+|)+|)+$|)+|)+|)^$'

-- sqlfmt-corpus-separator --

select 'x' ~ 'abcd(\m)+xyz'

-- sqlfmt-corpus-separator --

select 'x' ~ 'xyz(\Y\Y)+'

-- sqlfmt-corpus-separator --

select 'x' ~ 'x|(?:\M)+'

-- sqlfmt-corpus-separator --

select 'xxx' ~ '((.)){0}(\2)' as f

-- sqlfmt-corpus-separator --

select 'xxx' ~ '(.){0}(\1)' as f

-- sqlfmt-corpus-separator --

select 'xxx' ~ '^([bc])\1*$' as f

-- sqlfmt-corpus-separator --

select 'xy' ~ 'x(?![xy])'

-- sqlfmt-corpus-separator --

select 'xy' ~ 'x(?=[xy])'

-- sqlfmt-corpus-separator --

select 'xyy' ~ '(?<![xy])yy+'

-- sqlfmt-corpus-separator --

select 'xyy' ~ '(?<=[xy])yy+'

-- sqlfmt-corpus-separator --

select 'xyz' ~ '((.)){0}(\2){0}' as t

-- sqlfmt-corpus-separator --

select 'xyz' ~ 'x(\w)(?=(\1))'

-- sqlfmt-corpus-separator --

select 'xyz' ~ 'x(\w)(?=\1)'

-- sqlfmt-corpus-separator --

select 'xz' ~ 'x(?![xy])'

-- sqlfmt-corpus-separator --

select 'xz' ~ 'x(?=[xy])'

-- sqlfmt-corpus-separator --

select 'zyy' ~ '(?<![xy])yy+'

-- sqlfmt-corpus-separator --

select 'zyy' ~ '(?<=[xy])yy+'

-- sqlfmt-corpus-separator --

select (-1.0) ^ 1000000000000000

-- sqlfmt-corpus-separator --

select (-1.0) ^ 1000000000000001

-- sqlfmt-corpus-separator --

select (-1.0) ^ 2147483646

-- sqlfmt-corpus-separator --

select (-1.0) ^ 2147483647

-- sqlfmt-corpus-separator --

select (-1.0) ^ 2147483648

-- sqlfmt-corpus-separator --

select (-12.34) ^ 0.0

-- sqlfmt-corpus-separator --

select (-12.34) ^ 1.2

-- sqlfmt-corpus-separator --

select (select (select view_a)) from view_a

-- sqlfmt-corpus-separator --

select (select view_a) from view_a

-- sqlfmt-corpus-separator --

select *  from trigtest

-- sqlfmt-corpus-separator --

select * from LINE_TBL

-- sqlfmt-corpus-separator --

select * from LSEG_TBL

-- sqlfmt-corpus-separator --

select * from PField_v1 where pfname = 'PF0_1' order by slotname

-- sqlfmt-corpus-separator --

select * from PField_v1 where pfname = 'PF0_2' order by slotname

-- sqlfmt-corpus-separator --

select * from PSlot order by slotname

-- sqlfmt-corpus-separator --

select * from PSlot where slotname ~ 'PS.base.a' order by slotname

-- sqlfmt-corpus-separator --

select * from WSlot order by slotname

-- sqlfmt-corpus-separator --

select * from WSlot where roomno = '001' order by slotname

-- sqlfmt-corpus-separator --

select * from agg_view1

-- sqlfmt-corpus-separator --

select * from aggordview1 order by ten

-- sqlfmt-corpus-separator --

select * from alter2.t1

-- sqlfmt-corpus-separator --

select * from alter2.v1

-- sqlfmt-corpus-separator --

select * from another

-- sqlfmt-corpus-separator --

select * from anothertab

-- sqlfmt-corpus-separator --

select * from arr_tbl where f1 > '{1,2,3}' and f1 <= '{1,5,3}'

-- sqlfmt-corpus-separator --

select * from arr_tbl where f1 >= '{1,2,3}' and f1 < '{1,5,3}'

-- sqlfmt-corpus-separator --

select * from arrtest1

-- sqlfmt-corpus-separator --

select * from at_view_2

-- sqlfmt-corpus-separator --

select * from atacc1

-- sqlfmt-corpus-separator --

select * from atacc1 group by "........pg.dropped.1........"

-- sqlfmt-corpus-separator --

select * from atacc1 group by a

-- sqlfmt-corpus-separator --

select * from atacc1 order by "........pg.dropped.1........"

-- sqlfmt-corpus-separator --

select * from atacc1 order by a

-- sqlfmt-corpus-separator --

select * from atacc1 where "........pg.dropped.1........" = 1

-- sqlfmt-corpus-separator --

select * from atacc1 where a = 1

-- sqlfmt-corpus-separator --

select * from atpgv1

-- sqlfmt-corpus-separator --

select * from atpgv2

-- sqlfmt-corpus-separator --

select * from attest1

-- sqlfmt-corpus-separator --

select * from attest2

-- sqlfmt-corpus-separator --

select * from attmp3

-- sqlfmt-corpus-separator --

select * from bar1

-- sqlfmt-corpus-separator --

select * from base_tab order by a

-- sqlfmt-corpus-separator --

select * from base_tab_def order by a

-- sqlfmt-corpus-separator --

select * from base_tab_def order by a, c NULLS LAST

-- sqlfmt-corpus-separator --

select * from base_tab_def order by a, e nulls first

-- sqlfmt-corpus-separator --

select * from base_tbl

-- sqlfmt-corpus-separator --

select * from boolpart where a = false

-- sqlfmt-corpus-separator --

select * from boolpart where not a = false

-- sqlfmt-corpus-separator --

select * from capitals

-- sqlfmt-corpus-separator --

select * from cc order by f1

-- sqlfmt-corpus-separator --

select * from cchild

-- sqlfmt-corpus-separator --

select * from check_constraint_status

-- sqlfmt-corpus-separator --

select * from child

-- sqlfmt-corpus-separator --

select * from clstr_temp

-- sqlfmt-corpus-separator --

select * from cnullparent

-- sqlfmt-corpus-separator --

select * from cnullparent where f1 = 2

-- sqlfmt-corpus-separator --

select * from compos

-- sqlfmt-corpus-separator --

select * from comptable

-- sqlfmt-corpus-separator --

select * from d

-- sqlfmt-corpus-separator --

select * from dcomptable

-- sqlfmt-corpus-separator --

select * from def_test

-- sqlfmt-corpus-separator --

select * from def_view_test

-- sqlfmt-corpus-separator --

select * from defc

-- sqlfmt-corpus-separator --

select * from dfview

-- sqlfmt-corpus-separator --

select * from domarrtest

-- sqlfmt-corpus-separator --

select * from domdeftest

-- sqlfmt-corpus-separator --

select * from domview

-- sqlfmt-corpus-separator --

select * from emp1 t1 where exists (select * from emp1 t2
                                    where t2.id = t1.code and t2.code > 0)

-- sqlfmt-corpus-separator --

select * from exists_tbl t1
  where (exists(select 1 from exists_tbl t2 where t1.c1 = t2.c2) or c3 < 0)

-- sqlfmt-corpus-separator --

select * from fktable2

-- sqlfmt-corpus-separator --

select * from float8multirange_test

-- sqlfmt-corpus-separator --

select * from float8range_test

-- sqlfmt-corpus-separator --

select * from foo

-- sqlfmt-corpus-separator --

select * from forc_test

-- sqlfmt-corpus-separator --

select * from found_test_tbl

-- sqlfmt-corpus-separator --

select * from gtest_cursor order by id

-- sqlfmt-corpus-separator --

select * from i8mr_array

-- sqlfmt-corpus-separator --

select * from i8r_array

-- sqlfmt-corpus-separator --

select * from i_table

-- sqlfmt-corpus-separator --

select * from iboolpart where a = false

-- sqlfmt-corpus-separator --

select * from iboolpart where not a = false

-- sqlfmt-corpus-separator --

select * from id_ordered

-- sqlfmt-corpus-separator --

select * from inh_fk_1 order by 1

-- sqlfmt-corpus-separator --

select * from inh_fk_2 order by 1, 2

-- sqlfmt-corpus-separator --

select * from inhpar

-- sqlfmt-corpus-separator --

select * from inhpar order by f1

-- sqlfmt-corpus-separator --

select * from insertconflict

-- sqlfmt-corpus-separator --

select * from inserttest

-- sqlfmt-corpus-separator --

select * from inserttesta

-- sqlfmt-corpus-separator --

select * from inserttestb

-- sqlfmt-corpus-separator --

select * from listp where b = 1

-- sqlfmt-corpus-separator --

select * from log

-- sqlfmt-corpus-separator --

select * from matest0 order by 1-id

-- sqlfmt-corpus-separator --

select * from my_locks order by 1

-- sqlfmt-corpus-separator --

select * from myview

-- sqlfmt-corpus-separator --

select * from nestjsonb where j @> '[[14]]'

-- sqlfmt-corpus-separator --

select * from nestjsonb where j @> '{"c":3}'

-- sqlfmt-corpus-separator --

select * from no_such_table

-- sqlfmt-corpus-separator --

select * from nonesuch

-- sqlfmt-corpus-separator --

select * from nummultirange_test2 where nmr = '{}'

-- sqlfmt-corpus-separator --

select * from numrange_test where nr < 'empty'

-- sqlfmt-corpus-separator --

select * from numrange_test where nr <= 'empty'

-- sqlfmt-corpus-separator --

select * from numrange_test where nr = '(1.1, 2.2)'

-- sqlfmt-corpus-separator --

select * from numrange_test where nr = '[1.1, 2.2)'

-- sqlfmt-corpus-separator --

select * from numrange_test where nr = 'empty'

-- sqlfmt-corpus-separator --

select * from numrange_test where nr > 'empty'

-- sqlfmt-corpus-separator --

select * from numrange_test where nr >= 'empty'

-- sqlfmt-corpus-separator --

select * from onek2 where unique2 = 11 and stringu1 < 'B'

-- sqlfmt-corpus-separator --

select * from onek2 where unique2 = 11 and stringu1 = 'ATAAAA'

-- sqlfmt-corpus-separator --

select * from only t1

-- sqlfmt-corpus-separator --

select * from only t1_1

-- sqlfmt-corpus-separator --

select * from only t1_2

-- sqlfmt-corpus-separator --

select * from op

-- sqlfmt-corpus-separator --

select * from p t1 where exists
  (select 1 from p t2 where t1.a = t2.a and t1.a = 1)

-- sqlfmt-corpus-separator --

select * from p1

-- sqlfmt-corpus-separator --

select * from parent

-- sqlfmt-corpus-separator --

select * from parted

-- sqlfmt-corpus-separator --

select * from parted_conflict order by a

-- sqlfmt-corpus-separator --

select * from parted_conflict_test order by a

-- sqlfmt-corpus-separator --

select * from parted_copytest where b = 2

-- sqlfmt-corpus-separator --

select * from people

-- sqlfmt-corpus-separator --

select * from pg_database where nonesuch = pg_database.datname

-- sqlfmt-corpus-separator --

select * from pg_database where pg_database.datname = nonesuch

-- sqlfmt-corpus-separator --

select * from pg_timezone_abbrevs where abbrev = 'LMT'

-- sqlfmt-corpus-separator --

select * from pitable

-- sqlfmt-corpus-separator --

select * from pktable2

-- sqlfmt-corpus-separator --

select * from price

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

select * from quadtable

-- sqlfmt-corpus-separator --

select * from rtest_admin

-- sqlfmt-corpus-separator --

select * from rtest_admin order by pname, sysname

-- sqlfmt-corpus-separator --

select * from rtest_interface

-- sqlfmt-corpus-separator --

select * from rtest_nothn1

-- sqlfmt-corpus-separator --

select * from rtest_nothn2

-- sqlfmt-corpus-separator --

select * from rtest_nothn3

-- sqlfmt-corpus-separator --

select * from rtest_order2

-- sqlfmt-corpus-separator --

select * from rtest_t4

-- sqlfmt-corpus-separator --

select * from rtest_t5

-- sqlfmt-corpus-separator --

select * from rtest_t6

-- sqlfmt-corpus-separator --

select * from rtest_t7

-- sqlfmt-corpus-separator --

select * from rtest_t8

-- sqlfmt-corpus-separator --

select * from rtest_v1

-- sqlfmt-corpus-separator --

select * from rtest_vcomp order by part

-- sqlfmt-corpus-separator --

select * from rtest_view3

-- sqlfmt-corpus-separator --

select * from rtest_view4

-- sqlfmt-corpus-separator --

select * from rtest_view4 order by a, b

-- sqlfmt-corpus-separator --

select * from rtest_vview1

-- sqlfmt-corpus-separator --

select * from rtest_vview2

-- sqlfmt-corpus-separator --

select * from rtest_vview3

-- sqlfmt-corpus-separator --

select * from rtest_vview4 order by a, b

-- sqlfmt-corpus-separator --

select * from rtest_vview5

-- sqlfmt-corpus-separator --

select * from rules_foo

-- sqlfmt-corpus-separator --

select * from rules_foo2

-- sqlfmt-corpus-separator --

select * from rules_log

-- sqlfmt-corpus-separator --

select * from rules_src

-- sqlfmt-corpus-separator --

select * from salespeople

-- sqlfmt-corpus-separator --

select * from salespeople01_10

-- sqlfmt-corpus-separator --

select * from salespeople10_40

-- sqlfmt-corpus-separator --

select * from self_ref_trigger

-- sqlfmt-corpus-separator --

select * from selfconflict

-- sqlfmt-corpus-separator --

select * from shipped_view

-- sqlfmt-corpus-separator --

select * from sj p
where exists (select * from sj q
              where q.a = p.a and q.b < 10)

-- sqlfmt-corpus-separator --

select * from spgist_domain_tbl where f1 = 'fo'

-- sqlfmt-corpus-separator --

select * from t t1, t t2 where exists
  (select 1 from t t3 where t1.a = t3.a and t2.b = t3.b and t3.a = 1 and t3.b = 2)

-- sqlfmt-corpus-separator --

select * from t1

-- sqlfmt-corpus-separator --

select * from t_gin_test_tbl where i @> '{}'

-- sqlfmt-corpus-separator --

select * from table1

-- sqlfmt-corpus-separator --

select * from table2

-- sqlfmt-corpus-separator --

select * from tbl_ra t1
where not exists (select 1 from tbl_ra t2 where t2.b = t1.a) and t1.b < 2

-- sqlfmt-corpus-separator --

select * from temp_inh_oncommit_test

-- sqlfmt-corpus-separator --

select * from temp_parted_oncommit

-- sqlfmt-corpus-separator --

select * from temp_parted_oncommit_test

-- sqlfmt-corpus-separator --

select * from test_jsonb_subscript

-- sqlfmt-corpus-separator --

select * from textrange_test where tr < 'empty'

-- sqlfmt-corpus-separator --

select * from textrange_test where tr = '("b","g")'

-- sqlfmt-corpus-separator --

select * from textrange_test where tr = '["b","g")'

-- sqlfmt-corpus-separator --

select * from textrange_test where tr = 'empty'

-- sqlfmt-corpus-separator --

select * from trig_table

-- sqlfmt-corpus-separator --

select * from trigtest

-- sqlfmt-corpus-separator --

select * from trigtest2

-- sqlfmt-corpus-separator --

select * from tt

-- sqlfmt-corpus-separator --

select * from tt14v

-- sqlfmt-corpus-separator --

select * from tt15v

-- sqlfmt-corpus-separator --

select * from tt16v

-- sqlfmt-corpus-separator --

select * from tt17v

-- sqlfmt-corpus-separator --

select * from tt5,tt6 where tt5.f1 = tt6.f1 and tt5.f1 = tt5.f2 - tt6.f2

-- sqlfmt-corpus-separator --

select * from tt_log

-- sqlfmt-corpus-separator --

select * from twoconstraints

-- sqlfmt-corpus-separator --

select * from upsert

-- sqlfmt-corpus-separator --

select * from usersview

-- sqlfmt-corpus-separator --

select * from uv_fpo_view order by id, valid_at

-- sqlfmt-corpus-separator --

select * from uv_iocu_tab

-- sqlfmt-corpus-separator --

select * from uv_iocu_view

-- sqlfmt-corpus-separator --

select * from v_cycle1

-- sqlfmt-corpus-separator --

select * from v_cycle2

-- sqlfmt-corpus-separator --

select * from v_pagg_test order by y

-- sqlfmt-corpus-separator --

select * from v_search

-- sqlfmt-corpus-separator --

select * from vc4table

-- sqlfmt-corpus-separator --

select * from vview

-- sqlfmt-corpus-separator --

select * from vw_ord

-- sqlfmt-corpus-separator --

select * from vw_rngfunc

-- sqlfmt-corpus-separator --

select * from whereami

-- sqlfmt-corpus-separator --

select * from with_test

-- sqlfmt-corpus-separator --

select * from x

-- sqlfmt-corpus-separator --

select * from xacttest

-- sqlfmt-corpus-separator --

select * from y

-- sqlfmt-corpus-separator --

select 0.0 ^ (-12.34)

-- sqlfmt-corpus-separator --

select 0.0 ^ 0.0

-- sqlfmt-corpus-separator --

select 0.0 ^ 12.34

-- sqlfmt-corpus-separator --

select 0.12 ^ (-20)

-- sqlfmt-corpus-separator --

select 0.12 ^ (-25)

-- sqlfmt-corpus-separator --

select 0.5678 ^ (-85)

-- sqlfmt-corpus-separator --

select 1

-- sqlfmt-corpus-separator --

select 1 from gtest32 t1 where exists
  (select 1 from gtest32 t2 where t1.a > t2.a and t2.b = 2)

-- sqlfmt-corpus-separator --

select 1.000000000123 ^ (-2147483648)

-- sqlfmt-corpus-separator --

select 1.2 ^ 345

-- sqlfmt-corpus-separator --

select 1.234 ^ 5678

-- sqlfmt-corpus-separator --

select 1/(15-unique2) from tenk1 order by unique2 limit 19

-- sqlfmt-corpus-separator --

select 1/0

-- sqlfmt-corpus-separator --

select 10.0 ^ -2147483647 as rounds_to_zero

-- sqlfmt-corpus-separator --

select 10.0 ^ -2147483648 as rounds_to_zero

-- sqlfmt-corpus-separator --

select 10.0 ^ 2147483647 as overflows

-- sqlfmt-corpus-separator --

select 117743296169.0 ^ 1000000000 as overflows

-- sqlfmt-corpus-separator --

select 12.3 ^ (-45.6)

-- sqlfmt-corpus-separator --

select 12.3 ^ 45.6

-- sqlfmt-corpus-separator --

select 12.34 ^ 0.0

-- sqlfmt-corpus-separator --

select 12345678901234567890 % 123

-- sqlfmt-corpus-separator --

select 12345678901234567890 / 123

-- sqlfmt-corpus-separator --

select 2

-- sqlfmt-corpus-separator --

select 3 || 4.0

-- sqlfmt-corpus-separator --

select 3.789 ^ 21.0000000000000000

-- sqlfmt-corpus-separator --

select 3.789 ^ 35.0000000000000000

-- sqlfmt-corpus-separator --

select 32.1 ^ (-9.8)

-- sqlfmt-corpus-separator --

select 32.1 ^ 9.8

-- sqlfmt-corpus-separator --

select 4

-- sqlfmt-corpus-separator --

select 4769999999999999999999999999999999999999999999999999999999999999999999999999999999999999 * 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999

-- sqlfmt-corpus-separator --

select 4770999999999999999999999999999999999999999999999999999999999999999999999999999999999999 * 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999

-- sqlfmt-corpus-separator --

select 4789999999999999999999999999999999999999999999999999999999999999999999999999999999999999 * 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999

-- sqlfmt-corpus-separator --

select 4790999999999999999999999999999999999999999999999999999999999999999999999999999999999999 * 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999

-- sqlfmt-corpus-separator --

select 70.0 / 70

-- sqlfmt-corpus-separator --

select a from atacc1

-- sqlfmt-corpus-separator --

select a from stats_test_tab1 where a = 3

-- sqlfmt-corpus-separator --

select a from tt27v where a > 0

-- sqlfmt-corpus-separator --

select a from twophase_tab

-- sqlfmt-corpus-separator --

select a, b from selfref

-- sqlfmt-corpus-separator --

select a,b,c,d from atacc1

-- sqlfmt-corpus-separator --

select a.thousand from tenk1 a, tenk1 b
where a.thousand = b.thousand
  and exists ( select 1 from tenk1 c where b.hundred = c.hundred
                   and not exists ( select 1 from tenk1 d
                                    where a.thousand = d.thousand ) )

-- sqlfmt-corpus-separator --

select atacc1."........pg.dropped.1........" from atacc1

-- sqlfmt-corpus-separator --

select atacc1.a from atacc1

-- sqlfmt-corpus-separator --

select b,c,d from atacc1

-- sqlfmt-corpus-separator --

select current_user = session_user

-- sqlfmt-corpus-separator --

select definition from pg_views where viewname='vw_ord'

-- sqlfmt-corpus-separator --

select distinct from pg_database

-- sqlfmt-corpus-separator --

select distinct on (foobar) * from pg_database

-- sqlfmt-corpus-separator --

select ename, who = current_user as "matches user", action, newsal, oldsal from rtest_emplog order by ename, action, newsal

-- sqlfmt-corpus-separator --

select exists(select * from nocolumns)

-- sqlfmt-corpus-separator --

select f.last from fullname f

-- sqlfmt-corpus-separator --

select f.longname from fullname f

-- sqlfmt-corpus-separator --

select f1 from abc

-- sqlfmt-corpus-separator --

select f1 from c1

-- sqlfmt-corpus-separator --

select f1, f3 from tt14v

-- sqlfmt-corpus-separator --

select f1, f4 from tt14v

-- sqlfmt-corpus-separator --

select f1, q.c1 from quadtable

-- sqlfmt-corpus-separator --

select fivethous from tenk1 order by fivethous limit 4

-- sqlfmt-corpus-separator --

select fullname.text from fullname

-- sqlfmt-corpus-separator --

select hundred, twenty from tenk1 where hundred < 48 order by hundred desc limit 1

-- sqlfmt-corpus-separator --

select hundred, twenty from tenk1 where hundred <= 48 order by hundred desc limit 1

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

select name, generic_plans, custom_plans from pg_prepared_statements
  where  name = 'test_mode_pp'

-- sqlfmt-corpus-separator --

select nonesuch from pg_database

-- sqlfmt-corpus-separator --

select relhassubclass from pg_class where relname = 'idxpart_idx'

-- sqlfmt-corpus-separator --

select relname from pg_class where relname ~ '^temp_inh_oncommit_test'

-- sqlfmt-corpus-separator --

select relname from pg_class where relname ~ '^temp_parted_oncommit_test'

-- sqlfmt-corpus-separator --

select relname from pg_class where relname ~ '^temp_parted_oncommit_test'
  order by relname

-- sqlfmt-corpus-separator --

select snap from snapshot_test order by nr

-- sqlfmt-corpus-separator --

select string4 from tenk1 order by string4 limit 5

-- sqlfmt-corpus-separator --

select table_name, column_name, is_updatable
  from information_schema.columns where table_name = 'uv_ptv' order by column_name

-- sqlfmt-corpus-separator --

select table_name, is_updatable, is_insertable_into
  from information_schema.views where table_name = 'uv_ptv'

-- sqlfmt-corpus-separator --

select test2 from atacc2

-- sqlfmt-corpus-separator --

select testtext || testvarchar as concat, testnumeric + 42 as sum
from basictest

-- sqlfmt-corpus-separator --

select two + four as g, (select f1 from int4_tbl where f1 = (two + four))
from tenk1 t1
group by two + four order by 1

-- sqlfmt-corpus-separator --

select type, name, ident, level, total_bytes >= free_bytes
  from pg_backend_memory_contexts where level = 1

-- sqlfmt-corpus-separator --

select type, name, total_bytes > 0, total_nblocks, free_bytes > 0, free_chunks
from pg_backend_memory_contexts where name = 'Caller tuples'

-- sqlfmt-corpus-separator --

select unique1, unique2 from onek2
  where (unique2 = 11 and stringu1 < 'B') or unique1 = 0

-- sqlfmt-corpus-separator --

select unique1, unique2 from onek2
  where (unique2 = 11 or unique1 = 0) and stringu1 < 'B'

-- sqlfmt-corpus-separator --

select unique2 from onek2 where unique2 = 11 and stringu1 < 'B'

-- sqlfmt-corpus-separator --

select unique2 from onek2 where unique2 = 11 and stringu1 < 'C'

-- sqlfmt-corpus-separator --

select unique2 from onek2 where unique2 = 11 and stringu1 = 'ATAAAA'

-- sqlfmt-corpus-separator --

select view_a from view_a

-- sqlfmt-corpus-separator --

select viewname from pg_views where viewname = 'tt27v'

-- sqlfmt-corpus-separator --

select x < y from collate_test10

-- sqlfmt-corpus-separator --

select x || y from collate_test10

-- sqlfmt-corpus-separator --

select x, y from collate_test10 order by x || y

-- sqlfmt-corpus-separator --

with ordinality as (select 1 as x) select * from ordinality