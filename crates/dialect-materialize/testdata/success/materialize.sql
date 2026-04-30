(((((select * from int8_tbl)))))

-- sqlfmt-corpus-separator --

(((SELECT a FROM t ORDER BY a DESC LIMIT 4)))

-- sqlfmt-corpus-separator --

(((SELECT a FROM t))) ORDER BY a DESC LIMIT 4

-- sqlfmt-corpus-separator --

SELECT
	(SELECT * FROM t1 WHERE t1.f1 = t2.f1 AND t1.f1 = t3.f1),
	(SELECT * FROM t1 WHERE t1.f1 = t2.f1 AND t1.f1 = t3.f1)
FROM t2, t3

-- sqlfmt-corpus-separator --

SELECT
	(SELECT t1.f1 FROM t1, t2 WHERE t1.f1 = t3.f1 AND t2.f1 = t3.f1),
	(SELECT t1.f1 FROM t1, t2 WHERE t1.f1 = t3.f1 AND t2.f1 = t3.f1)
FROM t3

-- sqlfmt-corpus-separator --

SELECT
    3 # 4,
    7 # 4,
    7 # 14,
    1342579021 # 1035032143,
    2309456347094635094 # 4321056356463245221

-- sqlfmt-corpus-separator --

SELECT
    3 & 4,
    7 & 4,
    7 & 14,
    1342579021 & 1035032143,
    2309456347094635094 & 4321056356463245221

-- sqlfmt-corpus-separator --

SELECT
    3 | 4,
    7 | 4,
    7 | 14,
    1342579021 | 1035032143,
    2309456347094635094 | 4321056356463245221

-- sqlfmt-corpus-separator --

SELECT
    5 << 1  & 12  as implicit_l,
   (5 << 1) & 12  as explicit_l,
    5 << (1 & 12) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
    5 << 1  >> 3  as implicit_l,
   (5 << 1) >> 3  as explicit_l,
    5 << (1 >> 3) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
    5 >> 1  & 12  as implicit_l,
   (5 >> 1) & 12  as explicit_l,
    5 >> (1 & 12) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
    5 >> 1  << 3  as implicit_l,
   (5 >> 1) << 3  as explicit_l,
    5 >> (1 << 3) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
    a + b,
    a - b,
    a * b,
    a / b,
    a % b,
    a < b,
    a <= b,
    a > b,
    a >= b,
    a = b,
    a <> b
FROM t

-- sqlfmt-corpus-separator --

SELECT
    c_id,
    EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id)
    OR NOT EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id)
FROM c
ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT
   0  &  0  #  1  as implicit_l,
  (0  &  0) #  1  as explicit_l,
   0  & (0  #  1) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
   0  &  0  |  1  as implicit_l,
  (0  &  0) |  1  as explicit_l,
   0  & (0  |  1) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
   1  #  0  &  0  as implicit_l,
  (1  #  0) &  0  as explicit_l,
   1  # (0  &  0) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
   1  #  0  |  1  as implicit_l,
  (1  #  0) |  1  as explicit_l,
   1  # (0  |  1) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
   1  |  0  #  1  as implicit_l,
  (1  |  0) #  1  as explicit_l,
   1  | (0  #  1) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
   1  |  0  &  0  as implicit_l,
  (1  |  0) &  0  as explicit_l,
   1  | (0  &  0) as explicit_r

-- sqlfmt-corpus-separator --

SELECT
   ~1 & 0  as def_and, ~(1 & 0)  as l_prec_and, (~1) & 0  as h_prec_and,
   ~0 | 1  as def_or , ~(0 | 1)  as l_prec_or , (~0) | 1  as h_prec_or

-- sqlfmt-corpus-separator --

SELECT
   ~1 + 1  as def_add, ~(1 + 1)  as l_prec_add, (~1) + 1  as h_prec_add,
   ~1 - 2  as def_sub, ~(1 - 2)  as l_prec_sub, (~1) - 2  as h_prec_sub

-- sqlfmt-corpus-separator --

SELECT
 (tint1 + tint2) / tint2
FROM t_using_dataflow_rendering;

-- sqlfmt-corpus-separator --

SELECT
 (tint1 + tint2) / tint2
FROM v_using_constant_folding;

-- sqlfmt-corpus-separator --

SELECT "Amélie", "Amélie" FROM Amelie

-- sqlfmt-corpus-separator --

SELECT "X" FROM foo

-- sqlfmt-corpus-separator --

SELECT "foo"."v" FROM kv AS foo WHERE foo.k = 'a'

-- sqlfmt-corpus-separator --

SELECT "true", "false", "null", "array", "list", "map", "case", "cast", "coalesce", "greatest", "least", "nullif", "exists", "extract", "not", "row", "trim", "position", "substring", "normalize"
FROM iffy_colnames;

-- sqlfmt-corpus-separator --

SELECT '' || true || false

-- sqlfmt-corpus-separator --

SELECT '1' < 2

-- sqlfmt-corpus-separator --

SELECT 'CONCAT' || ' ' || 'operator'

-- sqlfmt-corpus-separator --

SELECT 'CONCAT' || 'operator'

-- sqlfmt-corpus-separator --

SELECT 'CONCAT' || 3 || 'operator'

-- sqlfmt-corpus-separator --

SELECT 'CONCAT' || NULL

-- sqlfmt-corpus-separator --

SELECT 'Foo' !~ 'foo', 'Foo' !~* 'foo'

-- sqlfmt-corpus-separator --

SELECT 'Foo' ~ 'foo', 'Foo' ~* 'foo'

-- sqlfmt-corpus-separator --

SELECT 'abs' ~ '\';

-- sqlfmt-corpus-separator --

SELECT 'foo' !~ 'foo?', 'fo' !~ 'foo?', 'f' !~ 'foo?'

-- sqlfmt-corpus-separator --

SELECT 'foo' !~~ 'f%';

-- sqlfmt-corpus-separator --

SELECT 'foo' !~~ 'g%';

-- sqlfmt-corpus-separator --

SELECT 'foo' !~~* 'G%';

-- sqlfmt-corpus-separator --

SELECT 'foo' !~~* 'f%';

-- sqlfmt-corpus-separator --

SELECT 'foo' ~ 'foo?', 'fo' ~ 'foo?', 'f' ~ 'foo?'

-- sqlfmt-corpus-separator --

SELECT 'foo' ~~ 'F%';

-- sqlfmt-corpus-separator --

SELECT 'foo' ~~ 'f%';

-- sqlfmt-corpus-separator --

SELECT 'foo' ~~* 'F%';

-- sqlfmt-corpus-separator --

SELECT 'foo' ~~* 'G%';

-- sqlfmt-corpus-separator --

SELECT 'idk';

-- sqlfmt-corpus-separator --

SELECT 'true' OR 'false'

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL AS t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL AS tx

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", * FROM J1_TBL tx

-- sqlfmt-corpus-separator --

SELECT 'x' AS "xxx", t1.a, t2.e FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e) WHERE t1.a = t2.d

-- sqlfmt-corpus-separator --

SELECT '你' || '好'

-- sqlfmt-corpus-separator --

SELECT ((multi_dim_text_array_empty) @> (multi_dim_text_array_two_elem)) FROM t5;

-- sqlfmt-corpus-separator --

SELECT (1/0 > 0) AND FALSE;

-- sqlfmt-corpus-separator --

SELECT (1/0 > 0) AND NULL;

-- sqlfmt-corpus-separator --

SELECT (1/0 > 0) AND TRUE;

-- sqlfmt-corpus-separator --

SELECT (1/0 > 0) OR FALSE;

-- sqlfmt-corpus-separator --

SELECT (1/0 > 0) OR NULL;

-- sqlfmt-corpus-separator --

SELECT (1/0 > 0) OR TRUE;

-- sqlfmt-corpus-separator --

SELECT (SELECT (SELECT * FROM t1 WHERE t1.f1 = t2.f1) FROM t2 WHERE t2.f1 = t3.f1) FROM t3

-- sqlfmt-corpus-separator --

SELECT (SELECT * FROM abc)

-- sqlfmt-corpus-separator --

SELECT (SELECT * FROM t1 WHERE t1.f1 = t2.f1 + 1) , (SELECT * FROM t1 WHERE t1.f1 = t2.f1 + 2) FROM t2

-- sqlfmt-corpus-separator --

SELECT (SELECT * FROM t1 WHERE t1.f1 = t2.f1) , (SELECT * FROM t1 WHERE t1.f1 = t2.f1) FROM t2

-- sqlfmt-corpus-separator --

SELECT (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT (SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT (SELECT DISTINCT ON (a) a FROM abc ORDER BY a, b||'foo') || 'bar';

-- sqlfmt-corpus-separator --

SELECT (SELECT a FROM abc WHERE false)

-- sqlfmt-corpus-separator --

SELECT (SELECT a FROM abc)

-- sqlfmt-corpus-separator --

SELECT (SELECT a FROM t GROUP BY b) FROM t

-- sqlfmt-corpus-separator --

SELECT (SELECT f1 + 1 FROM t1 WHERE t1.f1 = t2.f1) , (SELECT f1 + 2 FROM t1 WHERE t1.f1 = t2.f1) FROM t2

-- sqlfmt-corpus-separator --

SELECT (SELECT t2.a FROM t t2 WHERE t1.b = t2.b) FROM t t1 GROUP BY t1.a;

-- sqlfmt-corpus-separator --

SELECT (SELECT);

-- sqlfmt-corpus-separator --

SELECT (interval '-1' day + interval '1' day) = (interval '1' day + interval '-1' day)

-- sqlfmt-corpus-separator --

SELECT (test_json->>'field3') FROM test_jsonb WHERE json_type = 'object';

-- sqlfmt-corpus-separator --

SELECT *

-- sqlfmt-corpus-separator --

SELECT *
  FROM t1, t2, t3, t4, t5, t6
  ORDER BY a1, a2, a3, a4, a5, a6
  LIMIT 1

-- sqlfmt-corpus-separator --

SELECT *
FROM bar

-- sqlfmt-corpus-separator --

SELECT *
FROM c
WHERE
    EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id)
    OR NOT EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT *
FROM c
WHERE (SELECT o_id FROM o WHERE o.c_id=c.c_id AND ship='WY')=4;

-- sqlfmt-corpus-separator --

SELECT * FROM "!\_\""w3😊_weird_name".t2;

-- sqlfmt-corpus-separator --

SELECT * FROM "A"

-- sqlfmt-corpus-separator --

SELECT * FROM "B"

-- sqlfmt-corpus-separator --

SELECT * FROM "CASE".case;

-- sqlfmt-corpus-separator --

SELECT * FROM "cAsE".case;

-- sqlfmt-corpus-separator --

SELECT * FROM "q" ORDER BY p

-- sqlfmt-corpus-separator --

SELECT * FROM "t" ORDER BY v

-- sqlfmt-corpus-separator --

SELECT * FROM B

-- sqlfmt-corpus-separator --

SELECT * FROM SUBSELECT_TBL

-- sqlfmt-corpus-separator --

SELECT * FROM a

-- sqlfmt-corpus-separator --

SELECT * FROM a ORDER BY b

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE x > 1

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE x > 1 AND x < 3

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE x > 1 AND y < 30

-- sqlfmt-corpus-separator --

SELECT * FROM a WHERE y > 1

-- sqlfmt-corpus-separator --

SELECT * FROM ab AS foo (foo1, foo2)

-- sqlfmt-corpus-separator --

SELECT * FROM ab AS foo (foo1, foo2, foo3)

-- sqlfmt-corpus-separator --

SELECT * FROM abc

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2)

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2) WHERE foo.c = 6

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2) WHERE foo.foo1 = 1

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2) WHERE foo.foo2 = 2

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2, foo3)

-- sqlfmt-corpus-separator --

SELECT * FROM abc AS foo (foo1, foo2, foo3, foo4)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE 'hello'

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE NULL

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = 11

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = 7

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = NULL

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a > 5 AND a < 5

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a > 5 AND a < 5 AND b>=100

-- sqlfmt-corpus-separator --

SELECT * FROM arrays

-- sqlfmt-corpus-separator --

SELECT * FROM b

-- sqlfmt-corpus-separator --

SELECT * FROM bar GROUP BY a, b

-- sqlfmt-corpus-separator --

SELECT * FROM bar ORDER BY baz, id

-- sqlfmt-corpus-separator --

SELECT * FROM baz

-- sqlfmt-corpus-separator --

SELECT * FROM bazv

-- sqlfmt-corpus-separator --

SELECT * FROM blue.t2;

-- sqlfmt-corpus-separator --

SELECT * FROM blue_mv1;

-- sqlfmt-corpus-separator --

SELECT * FROM blue_t1 LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT * FROM blue_v1;

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id AND c.bill='TX');

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE NOT EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id);

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE str >= 'moo'

-- sqlfmt-corpus-separator --

SELECT * FROM c1.v1;

-- sqlfmt-corpus-separator --

SELECT * FROM c1;

-- sqlfmt-corpus-separator --

SELECT * FROM cluster_privileges ORDER BY name, privilege

-- sqlfmt-corpus-separator --

SELECT * FROM cluster_privileges WHERE name = 'c'

-- sqlfmt-corpus-separator --

SELECT * FROM const_mv

-- sqlfmt-corpus-separator --

SELECT * FROM const_mv2

-- sqlfmt-corpus-separator --

SELECT * FROM crud_view

-- sqlfmt-corpus-separator --

SELECT * FROM d

-- sqlfmt-corpus-separator --

SELECT * FROM d.qualified_columns;

-- sqlfmt-corpus-separator --

SELECT * FROM d_renamed.qualified_columns LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT * FROM data

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF 'xxx';

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF -1;

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF 1.2;

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF 1E38;

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF 7/0;

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF a;

-- sqlfmt-corpus-separator --

SELECT * FROM data ORDER BY a, b AS OF AT LEAST 1

-- sqlfmt-corpus-separator --

SELECT * FROM database_privileges

-- sqlfmt-corpus-separator --

SELECT * FROM database_privileges WHERE name = 'd'

-- sqlfmt-corpus-separator --

SELECT * FROM default_privileges

-- sqlfmt-corpus-separator --

SELECT * FROM dt

-- sqlfmt-corpus-separator --

SELECT * FROM dt2

-- sqlfmt-corpus-separator --

SELECT * FROM enemy.v2;

-- sqlfmt-corpus-separator --

SELECT * FROM erroring LIMIT 10;

-- sqlfmt-corpus-separator --

SELECT * FROM events AS OF 0

-- sqlfmt-corpus-separator --

SELECT * FROM events AS OF 100

-- sqlfmt-corpus-separator --

SELECT * FROM events AS OF 101

-- sqlfmt-corpus-separator --

SELECT * FROM f

-- sqlfmt-corpus-separator --

SELECT * FROM fizz FETCH FIRST 2 ROWS WITH TIES

-- sqlfmt-corpus-separator --

SELECT * FROM fizzlimitoffsetview2

-- sqlfmt-corpus-separator --

SELECT * FROM fizzlimitview2

-- sqlfmt-corpus-separator --

SELECT * FROM fizzoffsetview2

-- sqlfmt-corpus-separator --

SELECT * FROM fizzorderview

-- sqlfmt-corpus-separator --

SELECT * FROM foo
WHERE a = 0 AND b = 1 AND c = 2 AND v = 'xxx';

-- sqlfmt-corpus-separator --

SELECT * FROM foo
WHERE a = 0;

-- sqlfmt-corpus-separator --

SELECT * FROM foo
WHERE a = 1000000;

-- sqlfmt-corpus-separator --

SELECT * FROM foo
WHERE v = 'xxx';

-- sqlfmt-corpus-separator --

SELECT * FROM friend.v1;

-- sqlfmt-corpus-separator --

SELECT * FROM i

-- sqlfmt-corpus-separator --

SELECT * FROM i WHERE f = 0

-- sqlfmt-corpus-separator --

SELECT * FROM id_pool_mv1

-- sqlfmt-corpus-separator --

SELECT * FROM id_pool_mv1_new

-- sqlfmt-corpus-separator --

SELECT * FROM id_pool_v1

-- sqlfmt-corpus-separator --

SELECT * FROM id_pool_v1_new

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.character_sets

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.columns WHERE table_name = 'v' OR table_name = 't'

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema.tables;

-- sqlfmt-corpus-separator --

SELECT * FROM int4

-- sqlfmt-corpus-separator --

SELECT * FROM iv_ish

-- sqlfmt-corpus-separator --

SELECT * FROM j.k.l;

-- sqlfmt-corpus-separator --

SELECT * FROM j_other.l;

-- sqlfmt-corpus-separator --

SELECT * FROM kv

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE False

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE True

-- sqlfmt-corpus-separator --

SELECT * FROM kv WHERE nonexistent = 1

-- sqlfmt-corpus-separator --

SELECT * FROM kv2

-- sqlfmt-corpus-separator --

SELECT * FROM kv3

-- sqlfmt-corpus-separator --

SELECT * FROM kview

-- sqlfmt-corpus-separator --

SELECT * FROM large_rows LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT * FROM large_rows LIMIT 99;

-- sqlfmt-corpus-separator --

SELECT * FROM mv

-- sqlfmt-corpus-separator --

SELECT * FROM mv1

-- sqlfmt-corpus-separator --

SELECT * FROM mv10

-- sqlfmt-corpus-separator --

SELECT * FROM mv11

-- sqlfmt-corpus-separator --

SELECT * FROM mv12

-- sqlfmt-corpus-separator --

SELECT * FROM mv1;

-- sqlfmt-corpus-separator --

SELECT * FROM mv2

-- sqlfmt-corpus-separator --

SELECT * FROM mv2;

-- sqlfmt-corpus-separator --

SELECT * FROM mv3;

-- sqlfmt-corpus-separator --

SELECT * FROM mv4;

-- sqlfmt-corpus-separator --

SELECT * FROM mv5;

-- sqlfmt-corpus-separator --

SELECT * FROM mv6

-- sqlfmt-corpus-separator --

SELECT * FROM mv7

-- sqlfmt-corpus-separator --

SELECT * FROM mv9;

-- sqlfmt-corpus-separator --

SELECT * FROM mv;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_aligned_to_future;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_aligned_to_past;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_assertion_at_begin ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_assertion_at_begin;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_assertion_at_end;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_assertion_plus_refresh_every ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_complex_mfp_accumulable;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_complex_mfp_basic_distinct_single;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_complex_mfp_basic_multiple;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_complex_mfp_basic_single;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_complex_mfp_bucketed;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_complex_mfp_collation;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_fusable_mfp_accumulable;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_good_assertion_on_renamed_column;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_greatest;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_limited
ORDER BY a
LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_limited;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_misordered_assertions

-- sqlfmt-corpus-separator --

SELECT * FROM mv_multiple_refresh_options;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_no_assertions ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_no_creation_refresh;

-- sqlfmt-corpus-separator --

SELECT * FROM mv_session

-- sqlfmt-corpus-separator --

SELECT * FROM mv_two_assertions;

-- sqlfmt-corpus-separator --

SELECT * FROM mvi1;

-- sqlfmt-corpus-separator --

SELECT * FROM mvi2;

-- sqlfmt-corpus-separator --

SELECT * FROM mvi3

-- sqlfmt-corpus-separator --

SELECT * FROM mz_compute_exports

-- sqlfmt-corpus-separator --

SELECT * FROM mz_default_privileges

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_catalog_raw

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_cluster_workload_classes

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_comments WHERE id = 'u1';

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_compute_exports

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_network_policy_rules

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_show_all_privileges ORDER BY object_type, database, schema, name, grantee

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_show_cluster_privileges ORDER BY name, grantee

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_show_database_privileges ORDER BY name, grantee

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_show_default_privileges

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_show_default_privileges ORDER BY object_type, database, schema, grantee

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_show_object_privileges ORDER BY database, schema, name, grantee

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_show_role_members ORDER BY role, member

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_show_schema_privileges ORDER BY database, name, grantee

-- sqlfmt-corpus-separator --

SELECT * FROM mz_internal.mz_show_system_privileges ORDER BY grantee

-- sqlfmt-corpus-separator --

SELECT * FROM mz_introspection.mz_active_peeks

-- sqlfmt-corpus-separator --

SELECT * FROM mz_introspection.mz_arrangement_batches_raw;

-- sqlfmt-corpus-separator --

SELECT * FROM mz_introspection.mz_compute_exports

-- sqlfmt-corpus-separator --

SELECT * FROM mz_role_members

-- sqlfmt-corpus-separator --

SELECT * FROM mz_schemas LIMIT 0;

-- sqlfmt-corpus-separator --

SELECT * FROM mz_views LIMIT 0

-- sqlfmt-corpus-separator --

SELECT * FROM noncover WHERE b = 2

-- sqlfmt-corpus-separator --

SELECT * FROM noncover WHERE b = 5 AND b <> 5

-- sqlfmt-corpus-separator --

SELECT * FROM noncover WHERE b = 5 AND b <> 5 AND d>100

-- sqlfmt-corpus-separator --

SELECT * FROM noncover WHERE c = 7

-- sqlfmt-corpus-separator --

SELECT * FROM noncover WHERE c > 0 AND d = 8

-- sqlfmt-corpus-separator --

SELECT * FROM noncover WHERE c > 0 ORDER BY c DESC

-- sqlfmt-corpus-separator --

SELECT * FROM onecolumn AS a, onecolumn AS b ORDER BY x

-- sqlfmt-corpus-separator --

SELECT * FROM orders_view

-- sqlfmt-corpus-separator --

SELECT * FROM p WHERE f = 'NaN'

-- sqlfmt-corpus-separator --

SELECT * FROM pairs, square WHERE pairs.a + pairs.b = square.sq

-- sqlfmt-corpus-separator --

SELECT * FROM pairs, square WHERE pairs.b = square.n

-- sqlfmt-corpus-separator --

SELECT * FROM pg_catalog.pg_timezone_names where name = 'America/Denver'

-- sqlfmt-corpus-separator --

SELECT * FROM pg_tablespace ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT * FROM q ORDER BY "p"

-- sqlfmt-corpus-separator --

SELECT * FROM repro_v

-- sqlfmt-corpus-separator --

SELECT * FROM role_members

-- sqlfmt-corpus-separator --

SELECT * FROM rtr

-- sqlfmt-corpus-separator --

SELECT * FROM s WHERE d = 'NaN'

-- sqlfmt-corpus-separator --

SELECT * FROM s WHERE d = 0

-- sqlfmt-corpus-separator --

SELECT * FROM salary_exceptions

-- sqlfmt-corpus-separator --

SELECT * FROM single_time_monotonic_t;

-- sqlfmt-corpus-separator --

SELECT * FROM store ORDER BY baz, extra

-- sqlfmt-corpus-separator --

SELECT * FROM t

-- sqlfmt-corpus-separator --

SELECT * FROM t AS OF 1

-- sqlfmt-corpus-separator --

SELECT * FROM t AS OF AT LEAST 1683131452106;

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY "v"

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY 0

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY a, b

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY a, b, c

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY d

-- sqlfmt-corpus-separator --

SELECT * FROM t ORDER BY foo

-- sqlfmt-corpus-separator --

SELECT * FROM t WHERE v > -20 AND w > 30 ORDER BY v LIMIT 2

-- sqlfmt-corpus-separator --

SELECT * FROM t, mz_views

-- sqlfmt-corpus-separator --

SELECT * FROM t1

-- sqlfmt-corpus-separator --

SELECT * FROM t1
WHERE (a = 1) OR (a = 3 AND b = 'l3')

-- sqlfmt-corpus-separator --

SELECT * FROM t1
WHERE a = 2 AND b = 'l2'

-- sqlfmt-corpus-separator --

SELECT * FROM t1
WHERE a = NULL OR a = 2

-- sqlfmt-corpus-separator --

SELECT * FROM t1 LIMIT 1 OFFSET 0;

-- sqlfmt-corpus-separator --

SELECT * FROM t1 LIMIT 1 OFFSET 1;

-- sqlfmt-corpus-separator --

SELECT * FROM t1 ORDER BY a ASC;

-- sqlfmt-corpus-separator --

SELECT * FROM t1 WHERE NOT (f1 = f1)

-- sqlfmt-corpus-separator --

SELECT * FROM t1 WHERE f1 = 0 and (f1 = 0 or f1 = 1)

-- sqlfmt-corpus-separator --

SELECT * FROM t1;

-- sqlfmt-corpus-separator --

SELECT * FROM t2 ORDER BY d

-- sqlfmt-corpus-separator --

SELECT * FROM t2 WHERE d = '-Infinity' and v = '-Infinity'

-- sqlfmt-corpus-separator --

SELECT * FROM t2 WHERE d = 'Infinity' and v = 'Infinity'

-- sqlfmt-corpus-separator --

SELECT * FROM t3 WHERE NOT ((t3.c0 != 0.6) AND (t3.c0 != -0.1) AND (t3.c0 != 0.1) AND (-0.1 != t3.c0));

-- sqlfmt-corpus-separator --

SELECT * FROM t;

-- sqlfmt-corpus-separator --

SELECT * FROM tbl WHERE string OPERATOR(pg_catalog.~) '^123$'

-- sqlfmt-corpus-separator --

SELECT * FROM tbl WHERE string OPERATOR(pg_catalog.~) '^1234'

-- sqlfmt-corpus-separator --

SELECT * FROM tbl WHERE string OPERATOR(~) '^123$'

-- sqlfmt-corpus-separator --

SELECT * FROM tbl WHERE string OPERATOR(~) '^1234'

-- sqlfmt-corpus-separator --

SELECT * FROM tbl WHERE string ~ '^123$'

-- sqlfmt-corpus-separator --

SELECT * FROM tbl WHERE string ~ '^1234'

-- sqlfmt-corpus-separator --

SELECT * FROM test

-- sqlfmt-corpus-separator --

SELECT * FROM test;

-- sqlfmt-corpus-separator --

SELECT * FROM this_is_a_schema_with_a_super_long_name_of_exactly_255_characters_which_happens_to_be_the_maximum_we_allow_in_materialize_for_identifiers_of_any_kind_including_for_the_schema_name_so_this_should_still_work_perfectly_fine_as_long_as_we_dont_make_it_longer.t2;

-- sqlfmt-corpus-separator --

SELECT * FROM times ORDER BY t

-- sqlfmt-corpus-separator --

SELECT * FROM timestamptzish

-- sqlfmt-corpus-separator --

SELECT * FROM timestampwithtzish

-- sqlfmt-corpus-separator --

SELECT * FROM to_drop_mv

-- sqlfmt-corpus-separator --

SELECT * FROM u ORDER BY a

-- sqlfmt-corpus-separator --

SELECT * FROM universe.db.schema.foo

-- sqlfmt-corpus-separator --

SELECT * FROM untyped

-- sqlfmt-corpus-separator --

SELECT * FROM userz LIMIT 0

-- sqlfmt-corpus-separator --

SELECT * FROM uvw ORDER BY u, v, w

-- sqlfmt-corpus-separator --

SELECT * FROM v

-- sqlfmt-corpus-separator --

SELECT * FROM v1

-- sqlfmt-corpus-separator --

SELECT * FROM v1 GROUP BY f1;

-- sqlfmt-corpus-separator --

SELECT * FROM v1;

-- sqlfmt-corpus-separator --

SELECT * FROM v2

-- sqlfmt-corpus-separator --

SELECT * FROM v2 ORDER BY a ASC;

-- sqlfmt-corpus-separator --

SELECT * FROM v2 ORDER BY x DESC LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM v2;

-- sqlfmt-corpus-separator --

SELECT * FROM v3 ORDER BY a ASC;

-- sqlfmt-corpus-separator --

SELECT * FROM v4 ORDER BY a ASC;

-- sqlfmt-corpus-separator --

SELECT * FROM v6

-- sqlfmt-corpus-separator --

SELECT * FROM v7

-- sqlfmt-corpus-separator --

SELECT * FROM v7 ORDER BY x LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM v_maintained;

-- sqlfmt-corpus-separator --

SELECT * FROM v_one_off;

-- sqlfmt-corpus-separator --

SELECT * FROM webhook_buildkite2;

-- sqlfmt-corpus-separator --

SELECT * FROM webhook_buildkite2_renamed;

-- sqlfmt-corpus-separator --

SELECT * FROM xyz

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT -100

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT 0

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT 3.3

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT 9223372036854775808

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT x

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw OFFSET -100

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw OFFSET 1 + y

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw OFFSET 1.5

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw OFFSET 9223372036854775808

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY 1 LIMIT '1'

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY x LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY x LIMIT 1 OFFSET 1

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY x OFFSET 1 + 0.0

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY y OFFSET 1

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw ORDER BY y OFFSET 1 LIMIT 1

-- sqlfmt-corpus-separator --

SELECT * from foo where bar->'x' = '[1]'

-- sqlfmt-corpus-separator --

SELECT * from foo where bar->'x' = '{}'

-- sqlfmt-corpus-separator --

SELECT * from t ORDER BY t.timestamp;

-- sqlfmt-corpus-separator --

SELECT * from t ORDER BY timestamp;

-- sqlfmt-corpus-separator --

SELECT *, "from", kw."from" FROM kw

-- sqlfmt-corpus-separator --

SELECT *, EXISTS(
  SELECT * FROM likes WHERE likee = likes.liker
) FROM likes

-- sqlfmt-corpus-separator --

SELECT *, EXISTS(
  SELECT * FROM likes as likes2 WHERE likee = likes2.liker
) FROM likes

-- sqlfmt-corpus-separator --

SELECT *, EXISTS(
  SELECT * FROM likes as likes2 WHERE likes.likee = likes2.liker
) FROM likes

-- sqlfmt-corpus-separator --

SELECT *,* FROM abc

-- sqlfmt-corpus-separator --

SELECT - INTERVAL '-1 year -2 months -3 days -04:05:06.7';

-- sqlfmt-corpus-separator --

SELECT - INTERVAL '-1 year -2 months 3 days 04:05:06.7';

-- sqlfmt-corpus-separator --

SELECT - INTERVAL '1 year 2 months -3 days -04:05:06.7';

-- sqlfmt-corpus-separator --

SELECT - INTERVAL '1-2 3 4:5:6.7';

-- sqlfmt-corpus-separator --

SELECT -(.1 * 2.2)

-- sqlfmt-corpus-separator --

SELECT -(0.1 - 0.10);

-- sqlfmt-corpus-separator --

SELECT -(1.23 - 2.34)

-- sqlfmt-corpus-separator --

SELECT -0.00;

-- sqlfmt-corpus-separator --

SELECT -1.00 < -1.00;

-- sqlfmt-corpus-separator --

SELECT -1.00 <= -1.00;

-- sqlfmt-corpus-separator --

SELECT -1.00 <> -1.00;

-- sqlfmt-corpus-separator --

SELECT -1.00 = -1.00;

-- sqlfmt-corpus-separator --

SELECT -1.00 > -1.00;

-- sqlfmt-corpus-separator --

SELECT -1.00 >= -1.00;

-- sqlfmt-corpus-separator --

SELECT -1.1 * -2.2

-- sqlfmt-corpus-separator --

SELECT -1.1 * .2

-- sqlfmt-corpus-separator --

SELECT -1.1 * 2.2

-- sqlfmt-corpus-separator --

SELECT -1.23 - -2.34

-- sqlfmt-corpus-separator --

SELECT -16.3 % 4.1

-- sqlfmt-corpus-separator --

SELECT -20.1 % -4.1

-- sqlfmt-corpus-separator --

SELECT -INTERVAL '-2147483648 days -2562047787 hours -59 minutes -59.999999 seconds';

-- sqlfmt-corpus-separator --

SELECT -INTERVAL '-2147483648 days';

-- sqlfmt-corpus-separator --

SELECT -INTERVAL '-2147483648 months';

-- sqlfmt-corpus-separator --

SELECT -INTERVAL '-9223372036854775808 microseconds';

-- sqlfmt-corpus-separator --

SELECT .1 * -2.2

-- sqlfmt-corpus-separator --

SELECT .123456789012345678901234567890123456789 * .1

-- sqlfmt-corpus-separator --

SELECT 0 * b, b % 1, 0 % b from abc

-- sqlfmt-corpus-separator --

SELECT 0.0, 0.00, 0.000, 0.0000, 0.00000

-- sqlfmt-corpus-separator --

SELECT 0.00 < -1.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 < 0.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 < 1.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 < 1.2;

-- sqlfmt-corpus-separator --

SELECT 0.00 <= -1.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 <= 0.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 <= 1.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 <= 1.2;

-- sqlfmt-corpus-separator --

SELECT 0.00 <> -1.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 <> 0.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 <> 1.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 <> 1.2;

-- sqlfmt-corpus-separator --

SELECT 0.00 = -1.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 = 0.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 = 1.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 = 1.2;

-- sqlfmt-corpus-separator --

SELECT 0.00 > -1.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 > 0.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 > 1.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 > 1.2;

-- sqlfmt-corpus-separator --

SELECT 0.00 >= -1.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 >= 0.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 >= 1.00;

-- sqlfmt-corpus-separator --

SELECT 0.00 >= 1.2;

-- sqlfmt-corpus-separator --

SELECT 1

-- sqlfmt-corpus-separator --

SELECT 1 % 0

-- sqlfmt-corpus-separator --

SELECT 1 % 0.0

-- sqlfmt-corpus-separator --

SELECT 1 + (SELECT 1 AS a, 2 AS b)

-- sqlfmt-corpus-separator --

SELECT 1 + (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 + 2

-- sqlfmt-corpus-separator --

SELECT 1 / 0

-- sqlfmt-corpus-separator --

SELECT 1 / 0.0

-- sqlfmt-corpus-separator --

SELECT 1 / 0.5;

-- sqlfmt-corpus-separator --

SELECT 1 / 1.21035

-- sqlfmt-corpus-separator --

SELECT 1 AND 1

-- sqlfmt-corpus-separator --

SELECT 1 AND FALSE

-- sqlfmt-corpus-separator --

SELECT 1 AS "column name with spaces!", 2 AS "nospaces", 3 AS "space again";

-- sqlfmt-corpus-separator --

SELECT 1 AS "justriiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiight"

-- sqlfmt-corpus-separator --

SELECT 1 AS a, b AS a FROM foo ORDER BY a

-- sqlfmt-corpus-separator --

SELECT 1 AS justriiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiight

-- sqlfmt-corpus-separator --

SELECT 1 FROM kv GROUP BY v

-- sqlfmt-corpus-separator --

SELECT 1 FROM mz_internal.mz_activity_log WHERE 1 = 0

-- sqlfmt-corpus-separator --

SELECT 1 FROM mz_internal.mz_activity_log_redacted WHERE 1 = 0

-- sqlfmt-corpus-separator --

SELECT 1 FROM mz_internal.mz_prepared_statement_history WHERE 1 = 0

-- sqlfmt-corpus-separator --

SELECT 1 FROM mz_internal.mz_recent_activity_log WHERE 1 = 0

-- sqlfmt-corpus-separator --

SELECT 1 FROM mz_internal.mz_recent_activity_log_redacted WHERE 1 = 0

-- sqlfmt-corpus-separator --

SELECT 1 FROM mz_internal.mz_sql_text WHERE 1 = 0

-- sqlfmt-corpus-separator --

SELECT 1 FROM mz_internal.mz_sql_text_redacted WHERE 1 = 0

-- sqlfmt-corpus-separator --

SELECT 1 FROM mz_internal.mz_statement_execution_history WHERE 1 = 0

-- sqlfmt-corpus-separator --

SELECT 1 FROM mz_internal.mz_statement_execution_history_redacted WHERE 1 = 0

-- sqlfmt-corpus-separator --

SELECT 1 FROM mz_sources LIMIT 1

-- sqlfmt-corpus-separator --

SELECT 1 FROM mz_types LIMIT 1

-- sqlfmt-corpus-separator --

SELECT 1 FROM pg_attribute LIMIT 1

-- sqlfmt-corpus-separator --

SELECT 1 FROM pg_catalog.pg_am LIMIT 1

-- sqlfmt-corpus-separator --

SELECT 1 FROM t GROUP BY a HAVING b > 0

-- sqlfmt-corpus-separator --

SELECT 1 FROM t GROUP BY a ORDER BY b

-- sqlfmt-corpus-separator --

SELECT 1 FROM t LIMIT 1

-- sqlfmt-corpus-separator --

SELECT 1 FROM v LIMIT 1

-- sqlfmt-corpus-separator --

SELECT 1 OR 1

-- sqlfmt-corpus-separator --

SELECT 1 OR FALSE

-- sqlfmt-corpus-separator --

SELECT 1+1 AS two, 2+2 AS four

-- sqlfmt-corpus-separator --

SELECT 1, * FROM nocols

-- sqlfmt-corpus-separator --

SELECT 1.0 % 0

-- sqlfmt-corpus-separator --

SELECT 1.0 % 0.0

-- sqlfmt-corpus-separator --

SELECT 1.0 / 0

-- sqlfmt-corpus-separator --

SELECT 1.0 / 0.0

-- sqlfmt-corpus-separator --

SELECT 1.00 < -1.00;

-- sqlfmt-corpus-separator --

SELECT 1.00 < 1.00;

-- sqlfmt-corpus-separator --

SELECT 1.00 < 1.2;

-- sqlfmt-corpus-separator --

SELECT 1.00 <= -1.00;

-- sqlfmt-corpus-separator --

SELECT 1.00 <= 1.00;

-- sqlfmt-corpus-separator --

SELECT 1.00 <= 1.2;

-- sqlfmt-corpus-separator --

SELECT 1.00 <> -1.00;

-- sqlfmt-corpus-separator --

SELECT 1.00 <> 1.00;

-- sqlfmt-corpus-separator --

SELECT 1.00 <> 1.2;

-- sqlfmt-corpus-separator --

SELECT 1.00 = -1.00;

-- sqlfmt-corpus-separator --

SELECT 1.00 = 1.00;

-- sqlfmt-corpus-separator --

SELECT 1.00 = 1.2;

-- sqlfmt-corpus-separator --

SELECT 1.00 > -1.00;

-- sqlfmt-corpus-separator --

SELECT 1.00 > 1.00;

-- sqlfmt-corpus-separator --

SELECT 1.00 > 1.2;

-- sqlfmt-corpus-separator --

SELECT 1.00 >= -1.00;

-- sqlfmt-corpus-separator --

SELECT 1.00 >= 1.00;

-- sqlfmt-corpus-separator --

SELECT 1.00 >= 1.2;

-- sqlfmt-corpus-separator --

SELECT 1.1 * -2.2

-- sqlfmt-corpus-separator --

SELECT 1.1 * 2.2

-- sqlfmt-corpus-separator --

SELECT 1.2 < -1.00;

-- sqlfmt-corpus-separator --

SELECT 1.2 < 1.2;

-- sqlfmt-corpus-separator --

SELECT 1.2 <= -1.00;

-- sqlfmt-corpus-separator --

SELECT 1.2 <= 1.2;

-- sqlfmt-corpus-separator --

SELECT 1.2 <> -1.00;

-- sqlfmt-corpus-separator --

SELECT 1.2 <> 1.2;

-- sqlfmt-corpus-separator --

SELECT 1.2 = -1.00;

-- sqlfmt-corpus-separator --

SELECT 1.2 = 1.2;

-- sqlfmt-corpus-separator --

SELECT 1.2 > -1.00;

-- sqlfmt-corpus-separator --

SELECT 1.2 > 1.2;

-- sqlfmt-corpus-separator --

SELECT 1.2 >= -1.00;

-- sqlfmt-corpus-separator --

SELECT 1.2 >= 1.2;

-- sqlfmt-corpus-separator --

SELECT 1.23 + -1.23

-- sqlfmt-corpus-separator --

SELECT 1.23 + -2.34

-- sqlfmt-corpus-separator --

SELECT 1.23 + 2.34

-- sqlfmt-corpus-separator --

SELECT 1.23 - -2.34

-- sqlfmt-corpus-separator --

SELECT 1.23 - 1.23

-- sqlfmt-corpus-separator --

SELECT 1.23 - 2.34

-- sqlfmt-corpus-separator --

SELECT 1.50000000 * 1.50000000

-- sqlfmt-corpus-separator --

SELECT 1000*x, 1000*y, 1000*z
FROM mv_on_commit;

-- sqlfmt-corpus-separator --

SELECT 1073741824*2

-- sqlfmt-corpus-separator --

SELECT 11579208923731619542357098500868.7900057 / 3402823669209384.634633746074317682

-- sqlfmt-corpus-separator --

SELECT 123, '123', 123.0, TRUE, FALSE, NULL

-- sqlfmt-corpus-separator --

SELECT 1234567890123456789.012345 * 1234567890123456789.012345;

-- sqlfmt-corpus-separator --

SELECT 123456789012345678901234567890123456789 / .1

-- sqlfmt-corpus-separator --

SELECT 123456789012345678901234567890123456789.0 = 123456789012345678901234567890123456789.4999;

-- sqlfmt-corpus-separator --

SELECT 1E-39 * .1

-- sqlfmt-corpus-separator --

SELECT 1e38 + -1e38 + 1e-39

-- sqlfmt-corpus-separator --

SELECT 1e38 + 1e-39

-- sqlfmt-corpus-separator --

SELECT 1e38 + 1e-39 + -1e38

-- sqlfmt-corpus-separator --

SELECT 1e38 - 1e-39 - 1e38

-- sqlfmt-corpus-separator --

SELECT 1e38 - 1e38 - 1e-39

-- sqlfmt-corpus-separator --

SELECT 2 OPERATOR(*) 2 + 2, 2 * 2 + 2

-- sqlfmt-corpus-separator --

SELECT 2*a as d
FROM foo
ORDER BY -2*a;

-- sqlfmt-corpus-separator --

SELECT 2*a as d
FROM foo
ORDER BY -d;

-- sqlfmt-corpus-separator --

SELECT 2*a as d
FROM foo
ORDER BY d;

-- sqlfmt-corpus-separator --

SELECT 2.0 / 1.1;

-- sqlfmt-corpus-separator --

SELECT 2.0 / 1;

-- sqlfmt-corpus-separator --

SELECT 20.1 % -4.1

-- sqlfmt-corpus-separator --

SELECT 20.1 % 4.1

-- sqlfmt-corpus-separator --

SELECT 2147483646+1

-- sqlfmt-corpus-separator --

SELECT 2147483647+1

-- sqlfmt-corpus-separator --

SELECT 3 FROM kv GROUP BY k HAVING v > 2

-- sqlfmt-corpus-separator --

SELECT 3 FROM kv GROUP BY v HAVING k > 5

-- sqlfmt-corpus-separator --

SELECT 3 FROM kv HAVING TRUE

-- sqlfmt-corpus-separator --

SELECT 3402823669209384.634633746074317682 * 3402823669209384.634633746074317682

-- sqlfmt-corpus-separator --

SELECT 9.1e10, -9.1e10, 9.1e-10, -9.1e-10

-- sqlfmt-corpus-separator --

SELECT 98754321098754321098754321098754321

-- sqlfmt-corpus-separator --

SELECT 98765432109876543210987654321098765432.109

-- sqlfmt-corpus-separator --

SELECT 9876543210987654321098765432109876543210

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

SELECT DISTINCT ON (x, y, z) x, y, z FROM xyz

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

SELECT DISTINCT ON(max(x)) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(pk1, pk2, x, y) x, y, z FROM xyz ORDER BY x, y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(x) x AS y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM foo ORDER BY a + 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT a FROM foo ORDER BY b

-- sqlfmt-corpus-separator --

SELECT DISTINCT authors.name FROM books AS b1, books2 as b2, authors WHERE b1.title = b2.title AND authors.book = b1.title AND b1.shelf <> b2.shelf

-- sqlfmt-corpus-separator --

SELECT DISTINCT b, a FROM foo ORDER BY b

-- sqlfmt-corpus-separator --

SELECT DISTINCT c, b FROM t ORDER BY b DESC LIMIT 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT name, create_sql
FROM mz_indexes
WHERE cluster_id =
  (SELECT id FROM mz_clusters WHERE name = 'mz_catalog_server')
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT(attgenerated = '') FROM pg_attribute

-- sqlfmt-corpus-separator --

SELECT DISTINCT(privilege) FROM item_privileges WHERE type = 'table'

-- sqlfmt-corpus-separator --

SELECT DISTINCT(privilege) FROM item_privileges WHERE type = 'type'

-- sqlfmt-corpus-separator --

SELECT DISTINCT(privilege) FROM item_privileges WHERE type = 'view' OR type = 'materialized view' OR type = 'source'

-- sqlfmt-corpus-separator --

SELECT EXISTS (SELECT 1)

-- sqlfmt-corpus-separator --

SELECT EXISTS(SELECT * FROM t)

-- sqlfmt-corpus-separator --

SELECT EXISTS(SELECT 1 FROM kv AS x WHERE x.k = 1)

-- sqlfmt-corpus-separator --

SELECT EXISTS(SELECT 1 FROM kv WHERE k = 2)

-- sqlfmt-corpus-separator --

SELECT FALSE

-- sqlfmt-corpus-separator --

SELECT FALSE AND (1/0 > 0);

-- sqlfmt-corpus-separator --

SELECT FALSE AND 1

-- sqlfmt-corpus-separator --

SELECT FALSE OR (1/0 > 0);

-- sqlfmt-corpus-separator --

SELECT FALSE OR 1

-- sqlfmt-corpus-separator --

SELECT FOO.k FROM kv AS foo WHERE foo.k = 'a'

-- sqlfmt-corpus-separator --

SELECT FROM abc

-- sqlfmt-corpus-separator --

SELECT INTERVAL '+1 year +2 days +3:4:5.6';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.01 months -9223372036854775808 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.1 centuries -2147483648 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.1 days -9223372036854775808 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.1 decades -2147483648 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.1 millennium -2147483648 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.1 months -2147483648 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-0.1 yrs -2147483648 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 -:.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 ::.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 century -2147483648 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 day 0.27 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 day' - INTERVAL '-2147483648 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 day' < INTERVAL '-9999999 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 decade -2147483648 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 hours' + INTERVAL '-2562047788 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 millennium -2147483648 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 month' < INTERVAL '-9999999 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 month' < INTERVAL '-999999999 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1 months' - INTERVAL '-2147483648 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1-2 -3 -4:5:6.7' * 999

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1-2 -3 -4:5:6.7' + INTERVAL '1-2 3 4:5:6.7'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1-2 -3 -4:5:6.7';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1-2 -3 -4::.5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1-2 -3 4::.5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1-2 3 -4:5:6.7';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1.2345649' SECOND(5);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1.23456789' SECOND(2);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1.23456789' SECOND(5);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-1.555555555 years 2.555555555 months -3.555555555 days 4.555555555 hours -5.555555555 minutes 6.555555555 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-13 years -10 months +14 days +07:59:59.73';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-13 years -10 months -15 days -16:00:00.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-13-10 -15 -16::.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-13-10 15 -16::.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-153722867280.912930133 minutes';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-153722867281 minutes';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483647' MONTH * 1.01

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 centuries';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -0.1 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047786 hours -59 minutes -59.999999 seconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047787 hours -59 minutes -59.999999 seconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047788 hours -54 seconds' - INTERVAL '1'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047788 hours -54.775808 seconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047788 hours -59 min -60 sec'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047788 hours -60 min'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 days -2562047789 hours'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 decades';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 millennium';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 months -0.1 centuries';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 months -0.1 decades';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 months -0.1 millennium';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 months -0.1 yrs';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 months -2147483648 days -9223372036854775808 us'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 years -1 century';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 years -1 decade';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483648 years -1 millennium';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483649 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483649 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2147483649 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2562047788.01521550222 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2562047788.0152155023 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2562047788:00:54.775808' SECOND(2);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-2562047789 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-6.7 seconds 5 minutes -3 days 4 hours -1 year 2 month';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-6.7 seconds 5.6 minutes -3.4 days 4.5 hours -1.2 year 2.3 month';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854.775808 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775.808 milliseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775808 microseconds -0.01 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775808 microseconds -0.1 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775808 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775808 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775808 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854775809 microsecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036854777 millisecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-9223372036855 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-::1.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '-:::::1.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '.001 second';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '.33333 minute .1 second';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0 foo';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0 year 0 month 0 day 0 hour 0 minute 0.0 second';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0-0 0 0:0:0.0';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.00000001 min 0.0006 millisecond 3.5 microsecond' SECOND(5);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.00000001 min 0.0006 millisecond 3.5 microsecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.01 months 9223372036854775807 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 2562047788:0:54.775807';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 centuries 2147483647 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 days 9223372036854775807 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 decades 2147483647 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 millennium 2147483647 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 months 2147483647 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.1 yrs 2147483647 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.4 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.5 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.6 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '0.999999999 months 0.999999999 days 0.999999999 hours 0.999999999 minutes 0.999999999 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:00:01.00000009';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:00:01.0000004';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:00:01.0000009';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:02:03' MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:02:03minute hour day year';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '01:02:03minute';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 0:.27';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 2-3 4:5' DAY

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 2:';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 MIN'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 MINS'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 SEC'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 SECS'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 century 2147483647 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 day -0.27 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 day 2-3 4' SECOND(7);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 day'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 day' > INTERVAL '9999999 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 decade 2147483647 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 millennium 2147483647 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 millennium'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 millenniums 2 centuries 3 decades 4 years'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 milliseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 month' > INTERVAL '9999999 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 month' > INTERVAL '999999999 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 nanosecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 ns';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 second 42 milliseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 year 2 month 3 day 4 hour 5 minute 6.7 second';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 year 2 years'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1 years 2 months 3 days 4 hours 5 minutes 6.7 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' MINUTE

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' MONTH

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' MONTH * 0.5, 0.5 * INTERVAL '1' MONTH

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' MONTH / 30

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' YEAR

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' YEAR * 0.9999999

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' YEAR * 13/12

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' YEAR / 0

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1' YEAR / 360

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1+2:3.4';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1- 2 3:';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6' DAY;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6' HOUR, INTERVAL '1-2 3 4:5:6' DAY TO HOUR

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6' MINUTE, INTERVAL '1-2 3 4:5:6' HOUR TO MINUTE, INTERVAL '1-2 3 4:5:6' DAY TO MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6' MONTH, INTERVAL '1-2 3 4:5:6' YEAR TO MONTH;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6' SECOND, INTERVAL '1-2 3 4:5:6' MINUTE TO SECOND, INTERVAL '1-2 3 4:5:6' HOUR TO SECOND, INTERVAL '1-2 3 4:5:6' DAY TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6' YEAR

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' + - INTERVAL '7-6 5 4:3:2.1';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' + INTERVAL '-1-2 -3 -4:5:6.7'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' + INTERVAL '-7-6 -5 -4:3:2.1';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' + INTERVAL '1-2 3 4:5:6.7';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' - INTERVAL '-7-6 -5 -4:3:2.1';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' - INTERVAL '1-2 3 4:5:6.7'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' - INTERVAL '7-6 5 4:3:2.1';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' DAY TO HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' DAY;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' MONTH TO MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' MONTH;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4:5:6.7' YEAR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 4::.5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3 year'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3' HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3' MONTH;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3-4'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3:4 5 day';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3:4 5 second';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3:4 5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 3:4';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-2 5 second 3:4';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1-3' YEAR TO MONTH

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.0 second 42 milliseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.2345649' SECOND(5);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.23456789' SECOND

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.23456789' SECOND(2);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.23456789' SECOND(5);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.4 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5 microseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5 second 42 milliseconds 43 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5 second 42 milliseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5 second 43 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5555 month 2 3:4:5.6' DAY TO HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5555 month 2 3:4:5.6' HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5555 month 2 3:4:5.6';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5555555 day';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5555555 minute';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.5555555 month';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.999999999999999999 days'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1.999999999999999999days'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '10 years' *  9999999999.999999999;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '10 years' / 0.000000000000000001;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '10.333 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '10.333' years;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '100-11 366 250:59:61';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '100-11 366 250:61';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '100-13';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1002 milliseconds 1 second'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1002 milliseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '106751991167300 days .1 month';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '106751991167300.9 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '106751991167301 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' DAY TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' HOUR TO MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' HOUR TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' MINUTE TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' MONTH TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34' SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56' HOUR TO MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56' HOUR TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56' HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56' MINUTE TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56' MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56' SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '12:34:56';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '153722867280.912930117 minutes';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '153722867281 minutes';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:3.4 5-6 7' DAY;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:3.4 5-6 7' YEAR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:3.4 5-6';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:3.4.5';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1:2:31.23456789' MINUTE TO SECOND(2);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1x2:3.4';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1y 2.3mon 4.5d';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1y 2mon 3d 4h 5m 6.7s';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '1year 2months 3.4days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2 YR 5 DAYS'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2 YRS 5 DAYS'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2 century'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 centuries';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 days 0.1 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 days 2562047787 hours 59 minutes 59.999999 seconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 days 2562047788 hours 54 seconds' + INTERVAL '1'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 days 2562047788 hours 54.775807 seconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 days 2562047789 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 decades';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 millennium';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 months 0.1 centuries';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 months 0.1 decades';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 months 0.1 millennium';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 months 0.1 yrs';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 months 2147483647 days 9223372036854775807 us'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 years 1 century';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 years 1 decade';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647 years 1 millennium';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483647' MONTH / 0.99

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483648 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483648 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2147483648 years';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2562047788.01521550194 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2562047788.015215502 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2562047788:00:54.775807' SECOND(2);

-- sqlfmt-corpus-separator --

SELECT INTERVAL '2562047789 hours';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '27 second 24 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '27.0 second 24 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '27.0 second 46 milliseconds 24 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '3 decade'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '4 year'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5 day 3:4 1-2';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5' DAY;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5' HOUR, INTERVAL '5' DAY TO HOUR;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5' MINUTE, INTERVAL '5' HOUR TO MINUTE, INTERVAL '5' DAY TO MINUTE;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5' MONTH, INTERVAL '5' YEAR TO MONTH;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5' YEAR

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5', INTERVAL '5' SECOND, INTERVAL '5' MINUTE TO SECOND, INTERVAL '5' HOUR TO SECOND, INTERVAL '5' DAY TO SECOND;

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5000006 microseconds 1 second'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '5000006 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '6.7 seconds 5 minutes 3 days 4 hours 1 year 2 month';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '768614336404564650.7 year';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '768614336404564651 year';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854.775807 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854771807 seconds 1.9 hour';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775.807 milliseconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775707 seconds 1.9 minute';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775807 microseconds 0.01 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775807 microseconds 0.1 days';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775807 microseconds'

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775807 seconds 1 hour';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775807 seconds 1 minute';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775808 microsecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775808 months';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854775808 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036854777 millisecond';

-- sqlfmt-corpus-separator --

SELECT INTERVAL '9223372036855 seconds';

-- sqlfmt-corpus-separator --

SELECT INTERVAL ':::1- ::2 ::::3:';

-- sqlfmt-corpus-separator --

SELECT INTERVAL ':::::1.27';

-- sqlfmt-corpus-separator --

SELECT NOT 1

-- sqlfmt-corpus-separator --

SELECT NOT FALSE

-- sqlfmt-corpus-separator --

SELECT NOT FALSE OR FALSE

-- sqlfmt-corpus-separator --

SELECT NOT TRUE

-- sqlfmt-corpus-separator --

SELECT NULL

-- sqlfmt-corpus-separator --

SELECT NULL ? 'a'

-- sqlfmt-corpus-separator --

SELECT NULL ?& 'a'

-- sqlfmt-corpus-separator --

SELECT NULL ?| 'a'

-- sqlfmt-corpus-separator --

SELECT NULL AND (1/0 > 0);

-- sqlfmt-corpus-separator --

SELECT NULL AS z, * FROM abc

-- sqlfmt-corpus-separator --

SELECT NULL OR (1/0 > 0);

-- sqlfmt-corpus-separator --

SELECT NULL || 'CONCAT'

-- sqlfmt-corpus-separator --

SELECT TRUE

-- sqlfmt-corpus-separator --

SELECT TRUE AND (1/0 > 0);

-- sqlfmt-corpus-separator --

SELECT TRUE AND NOT TRUE

-- sqlfmt-corpus-separator --

SELECT TRUE OR (1/0 > 0);

-- sqlfmt-corpus-separator --

SELECT Y FROM foo

-- sqlfmt-corpus-separator --

SELECT a + 1 AS c FROM foo ORDER BY a + c

-- sqlfmt-corpus-separator --

SELECT a + 1 FROM foo ORDER BY a + 1

-- sqlfmt-corpus-separator --

SELECT a < b FROM test1

-- sqlfmt-corpus-separator --

SELECT a = 'a ', a != 'a ', 'a ' < a, 'a ' <= a, a > 'a ', a >= 'a ' FROM bpchar_t;

-- sqlfmt-corpus-separator --

SELECT a = 1 FROM t1 WHERE a = 1;

-- sqlfmt-corpus-separator --

SELECT a AS "foo.bar", b FROM t ORDER BY "foo.bar" DESC

-- sqlfmt-corpus-separator --

SELECT a AS foo, (a) AS foo FROM t ORDER BY foo LIMIT 1

-- sqlfmt-corpus-separator --

SELECT a AS foo, b AS foo FROM t ORDER BY foo

-- sqlfmt-corpus-separator --

SELECT a AS foo, b FROM t ORDER BY a DESC

-- sqlfmt-corpus-separator --

SELECT a AS foo, b FROM t ORDER BY foo DESC

-- sqlfmt-corpus-separator --

SELECT a AS t FROM daterange_values ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a AS t FROM int4range_values ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a AS t FROM int8range_values ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a AS t FROM numrange_values ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a AS t FROM tsrange_values ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a AS t FROM tstzrange_values ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a FROM MaxIntTest WHERE a = 9223372036854775807

-- sqlfmt-corpus-separator --

SELECT a FROM [u1 AS materialize.public.y]

-- sqlfmt-corpus-separator --

SELECT a FROM abc ORDER BY a DESC

-- sqlfmt-corpus-separator --

SELECT a FROM abc ORDER BY a DESC LIMIT 1

-- sqlfmt-corpus-separator --

SELECT a FROM abc ORDER BY a DESC OFFSET 1

-- sqlfmt-corpus-separator --

SELECT a FROM bar

-- sqlfmt-corpus-separator --

SELECT a FROM c1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM c2 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM dateish

-- sqlfmt-corpus-separator --

SELECT a FROM foo

-- sqlfmt-corpus-separator --

SELECT a FROM foo GROUP BY a, foo.a

-- sqlfmt-corpus-separator --

SELECT a FROM foo ORDER BY (0-a)

-- sqlfmt-corpus-separator --

SELECT a FROM foo ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM foo ORDER BY a DESC

-- sqlfmt-corpus-separator --

SELECT a FROM foo ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a FROM foo ORDER BY b || 'blah'

-- sqlfmt-corpus-separator --

SELECT a FROM foo ORDER BY exists (SELECT * FROM bar WHERE bar.a = foo.a), a

-- sqlfmt-corpus-separator --

SELECT a FROM multiple

-- sqlfmt-corpus-separator --

SELECT a FROM noncover WHERE b=2 ORDER BY c DESC

-- sqlfmt-corpus-separator --

SELECT a FROM p ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a FROM t

-- sqlfmt-corpus-separator --

SELECT a FROM t GROUP BY t.a, public.t.a

-- sqlfmt-corpus-separator --

SELECT a FROM t GROUP BY t.a, t.a

-- sqlfmt-corpus-separator --

SELECT a FROM t ORDER BY (((a)))

-- sqlfmt-corpus-separator --

SELECT a FROM t ORDER BY 1 DESC

-- sqlfmt-corpus-separator --

SELECT a FROM t ORDER BY a+b DESC, a

-- sqlfmt-corpus-separator --

SELECT a FROM t ORDER BY a.b

-- sqlfmt-corpus-separator --

SELECT a FROM t WHERE a < 4.0

-- sqlfmt-corpus-separator --

SELECT a FROM t1
WHERE a+a = 2

-- sqlfmt-corpus-separator --

SELECT a FROM t1 WHERE EXISTS (SELECT 1 FROM t2 WHERE EXISTS (SELECT 1 FROM t3 WHERE t1.a = t3.a AND t2.b = t3.b))

-- sqlfmt-corpus-separator --

SELECT a FROM t4

-- sqlfmt-corpus-separator --

SELECT a FROM t8

-- sqlfmt-corpus-separator --

SELECT a FROM tz WHERE c < d

-- sqlfmt-corpus-separator --

SELECT a FROM tz WHERE c <= d

-- sqlfmt-corpus-separator --

SELECT a FROM tz WHERE c = d

-- sqlfmt-corpus-separator --

SELECT a FROM x

-- sqlfmt-corpus-separator --

SELECT a from t2

-- sqlfmt-corpus-separator --

SELECT a+b+c AS foo FROM abc

-- sqlfmt-corpus-separator --

SELECT a, (SELECT a FROM y) FROM x

-- sqlfmt-corpus-separator --

SELECT a, a AS c FROM foo ORDER BY c

-- sqlfmt-corpus-separator --

SELECT a, b FROM noncover WHERE b=2 AND d>3 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a, b FROM t

-- sqlfmt-corpus-separator --

SELECT a, b FROM t ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a, b FROM t ORDER BY b DESC

-- sqlfmt-corpus-separator --

SELECT a, b FROM t ORDER BY b DESC LIMIT 2

-- sqlfmt-corpus-separator --

SELECT a, b FROM t ORDER BY b, a DESC

-- sqlfmt-corpus-separator --

SELECT a, b FROM t WHERE b = 7 ORDER BY b, a

-- sqlfmt-corpus-separator --

SELECT a, b, a+b AS ab FROM t WHERE b = 7 ORDER BY ab DESC, a

-- sqlfmt-corpus-separator --

SELECT a, b, c FROM tz ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b, c, rowid FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, d FROM noncover WHERE b=2 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT a, d FROM noncover WHERE b=2

-- sqlfmt-corpus-separator --

SELECT a,a,a,a FROM abc

-- sqlfmt-corpus-separator --

SELECT a,b FROM json_family ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a,c FROM abc

-- sqlfmt-corpus-separator --

SELECT abc.b FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT abc.foo1 FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT attnotnull FROM pg_catalog.pg_attribute WHERE attname = 'nonnull_string_agg'

-- sqlfmt-corpus-separator --

SELECT attnotnull FROM pg_catalog.pg_attribute WHERE attname = 'nullable_string_agg'

-- sqlfmt-corpus-separator --

SELECT atttypid, attname, atttypmod FROM pg_attribute WHERE attrelid = (SELECT oid FROM mz_tables WHERE name='coltypes') ORDER BY atttypid

-- sqlfmt-corpus-separator --

SELECT b + '6 month' from t order by a desc

-- sqlfmt-corpus-separator --

SELECT b + interval '1m', interval '1m' + b, c + interval '1m', interval '1m' + c FROM tz WHERE a = 1

-- sqlfmt-corpus-separator --

SELECT b AS a FROM foo ORDER BY -a

-- sqlfmt-corpus-separator --

SELECT b AS a FROM foo ORDER BY a

-- sqlfmt-corpus-separator --

SELECT b FROM c1 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT b FROM c2 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT b FROM multiple

-- sqlfmt-corpus-separator --

SELECT b FROM t GROUP BY a

-- sqlfmt-corpus-separator --

SELECT b FROM t ORDER BY a DESC

-- sqlfmt-corpus-separator --

SELECT b FROM t WHERE c > 4.0 AND a < 4

-- sqlfmt-corpus-separator --

SELECT b FROM timeish

-- sqlfmt-corpus-separator --

SELECT b FROM timestampish

-- sqlfmt-corpus-separator --

SELECT b || a
FROM mv1

-- sqlfmt-corpus-separator --

SELECT b || a
FROM mv1
OFFSET 1

-- sqlfmt-corpus-separator --

SELECT b || a
FROM mv1
OFFSET 2 - 1

-- sqlfmt-corpus-separator --

SELECT b || a
FROM v1

-- sqlfmt-corpus-separator --

SELECT b || a
FROM v1
OFFSET 1

-- sqlfmt-corpus-separator --

SELECT b || a
FROM v1
OFFSET 2 - 1

-- sqlfmt-corpus-separator --

SELECT b, (SELECT val1 FROM baz WHERE val2 = a ORDER BY val1 limit 1 offset 1 rows) c
FROM fizz ORDER BY b, c DESC

-- sqlfmt-corpus-separator --

SELECT b, a
FROM foo
ORDER BY b
FETCH FIRST 2 ROWS ONLY OFFSET 1;

-- sqlfmt-corpus-separator --

SELECT b, a
FROM foo
ORDER BY b
FETCH FIRST 2 ROWS ONLY;

-- sqlfmt-corpus-separator --

SELECT b, a
FROM foo
ORDER BY b
LIMIT 2 OFFSET 1;

-- sqlfmt-corpus-separator --

SELECT b, a
FROM foo
ORDER BY b
LIMIT 2;

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
OFFSET 1 LIMIT 1;

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

SELECT b, a
FROM foo
ORDER BY b
OFFSET 1;

-- sqlfmt-corpus-separator --

SELECT b, a FROM foo ORDER BY b

-- sqlfmt-corpus-separator --

SELECT bar FROM foo

-- sqlfmt-corpus-separator --

SELECT bar FROM foo ORDER BY bar

-- sqlfmt-corpus-separator --

SELECT bar FROM foo WHERE bar ? 'a'

-- sqlfmt-corpus-separator --

SELECT bar FROM foo WHERE bar ? 'goodbye'

-- sqlfmt-corpus-separator --

SELECT bar FROM foo WHERE bar ? 'hello'

-- sqlfmt-corpus-separator --

SELECT bar FROM foo WHERE bar->>'a' = 'b'

-- sqlfmt-corpus-separator --

SELECT bar FROM t1 ORDER BY bar ASC;

-- sqlfmt-corpus-separator --

SELECT bar FROM t1;

-- sqlfmt-corpus-separator --

SELECT bar->'a' FROM foo

-- sqlfmt-corpus-separator --

SELECT bar->'a'->'c',bar->'a'->>'c' FROM foo

-- sqlfmt-corpus-separator --

SELECT c FROM t GROUP BY a

-- sqlfmt-corpus-separator --

SELECT c FROM t ORDER BY c

-- sqlfmt-corpus-separator --

SELECT c FROM t ORDER BY c DESC

-- sqlfmt-corpus-separator --

SELECT c_id, EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id AND c.bill='TX') FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT c_id, EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id) FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT c_id, NOT EXISTS(SELECT * FROM o WHERE o.c_id=c.c_id) FROM c ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT coalesce, greatest, least, nullif, exists, extract
FROM iffy_colnames;

-- sqlfmt-corpus-separator --

SELECT e FROM ef WHERE f > 0 AND f < 2 ORDER BY f

-- sqlfmt-corpus-separator --

SELECT event_type, object_type, details FROM mz_audit_events WHERE event_type = 'alter' AND object_type = 'schema';

-- sqlfmt-corpus-separator --

SELECT f.f1 / '0.0' from float4_tbl f;

-- sqlfmt-corpus-separator --

SELECT f1+f2 FROM t1

-- sqlfmt-corpus-separator --

SELECT foo.a FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT foo1, foo.foo1, b, foo.c FROM abc AS foo (foo1)

-- sqlfmt-corpus-separator --

SELECT foo_multi_case.case FROM foo_multi_case;

-- sqlfmt-corpus-separator --

SELECT global_id, lir_id FROM mz_internal.mz_lir_mapping ORDER BY global_id, lir_id DESC;

-- sqlfmt-corpus-separator --

SELECT id FROM mz_catalog.mz_tables WHERE name = 'x'

-- sqlfmt-corpus-separator --

SELECT id FROM mz_clusters WHERE name = 'foo';

-- sqlfmt-corpus-separator --

SELECT id, address, name, parent_id, arrangement_records, elapsed_ns FROM all_ops WHERE export_id = 'does_not_exist';

-- sqlfmt-corpus-separator --

SELECT id, event_type, object_type, details, user FROM mz_audit_events ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, event_type, object_type, details, user FROM mz_audit_events ORDER BY id DESC LIMIT 1

-- sqlfmt-corpus-separator --

SELECT id, event_type, object_type, details, user FROM mz_audit_events ORDER BY id DESC LIMIT 2

-- sqlfmt-corpus-separator --

SELECT id, event_type, object_type, details, user FROM mz_audit_events ORDER BY id DESC LIMIT 3

-- sqlfmt-corpus-separator --

SELECT id, event_type, object_type, details, user, occurred_at FROM mz_audit_events ORDER BY id DESC LIMIT 1

-- sqlfmt-corpus-separator --

SELECT id, global_id FROM mz_internal.mz_dataflow_global_ids ORDER BY id, global_id;

-- sqlfmt-corpus-separator --

SELECT id, name FROM mz_clusters

-- sqlfmt-corpus-separator --

SELECT id, name FROM mz_databases

-- sqlfmt-corpus-separator --

SELECT id, name FROM mz_roles

-- sqlfmt-corpus-separator --

SELECT id, name FROM mz_schemas

-- sqlfmt-corpus-separator --

SELECT id, name FROM mz_schemas WHERE name = 'mz_catalog' OR name = 'pg_catalog' OR name = 'mz_internal' OR name = 'information_schema';

-- sqlfmt-corpus-separator --

SELECT id, name, managed, replication_factor, size FROM mz_clusters WHERE name != 'quickstart'

-- sqlfmt-corpus-separator --

SELECT id, name, owner_id FROM mz_internal.mz_network_policies

-- sqlfmt-corpus-separator --

SELECT id, object_type, comment FROM mz_internal.mz_comments

-- sqlfmt-corpus-separator --

SELECT id, schema_id, name FROM mz_secrets

-- sqlfmt-corpus-separator --

SELECT interval '02!01!1~01:02:03';

-- sqlfmt-corpus-separator --

SELECT interval '02-01!1~01:02:03';

-- sqlfmt-corpus-separator --

SELECT interval '1! hour';

-- sqlfmt-corpus-separator --

SELECT interval '1-2 3 4:5:6.7'

-- sqlfmt-corpus-separator --

SELECT k FROM kv

-- sqlfmt-corpus-separator --

SELECT k FROM kv HAVING k > 7

-- sqlfmt-corpus-separator --

SELECT k FROM kv ORDER BY v

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY k LIMIT 5

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY k OFFSET 5

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY v DESC LIMIT (1+4) OFFSET 1

-- sqlfmt-corpus-separator --

SELECT k, v FROM t ORDER BY v LIMIT (1+4) OFFSET 1

-- sqlfmt-corpus-separator --

SELECT k,v FROM kv

-- sqlfmt-corpus-separator --

SELECT key FROM bar;

-- sqlfmt-corpus-separator --

SELECT kv.K,KV.v FROM kv

-- sqlfmt-corpus-separator --

SELECT l1.la, l2.lb, l3.lb
FROM l as l1, l as l2, l as l3
WHERE l1.la + 1 = l2.la AND l3.la = l1.la + l2.la

-- sqlfmt-corpus-separator --

SELECT lb, rb FROM l3, r3 WHERE la = ra

-- sqlfmt-corpus-separator --

SELECT list, map
FROM iffy_colnames;

-- sqlfmt-corpus-separator --

SELECT name FROM mz_cluster_replicas WHERE name = 'replica1'

-- sqlfmt-corpus-separator --

SELECT name FROM mz_clusters WHERE name = 'bar';

-- sqlfmt-corpus-separator --

SELECT name FROM mz_clusters WHERE name = 'c'

-- sqlfmt-corpus-separator --

SELECT name FROM mz_columns WHERE name = 'foobar';

-- sqlfmt-corpus-separator --

SELECT name FROM mz_databases WHERE name = 'db'

-- sqlfmt-corpus-separator --

SELECT name FROM mz_internal.mz_network_policies WHERE name = 'np_drop'

-- sqlfmt-corpus-separator --

SELECT name FROM mz_materialized_views WHERE name = 'mv'

-- sqlfmt-corpus-separator --

SELECT name FROM mz_roles

-- sqlfmt-corpus-separator --

SELECT name FROM mz_roles WHERE name = 'test_retraction_role'

-- sqlfmt-corpus-separator --

SELECT name FROM mz_schemas WHERE name = 's'

-- sqlfmt-corpus-separator --

SELECT name FROM mz_tables WHERE name = 't'

-- sqlfmt-corpus-separator --

SELECT name, cluster_id, size, owner_id FROM mz_cluster_replicas WHERE cluster_id = 'u2'

-- sqlfmt-corpus-separator --

SELECT name, cluster_id, size, owner_id FROM mz_cluster_replicas WHERE cluster_id = 'u4'

-- sqlfmt-corpus-separator --

SELECT name, id FROM v4362 WHERE name = 'a'

-- sqlfmt-corpus-separator --

SELECT name, id FROM v4362 WHERE name = (SELECT name FROM v4362 WHERE id = 1)

-- sqlfmt-corpus-separator --

SELECT name, inherit FROM mz_roles

-- sqlfmt-corpus-separator --

SELECT name, inherit, rolcanlogin FROM mz_roles WHERE name = 'foo'

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM cluster_privileges WHERE name = 'c'

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM database_privileges WHERE name = 'd'

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM item_privileges WHERE name = 'conn'

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM item_privileges WHERE name = 'mv'

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM item_privileges WHERE name = 's'

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM item_privileges WHERE name = 'se'

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM item_privileges WHERE name = 't'

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM item_privileges WHERE name = 't1'

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM item_privileges WHERE name = 'ty'

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM item_privileges WHERE name = 'v'

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM item_privileges WHERE name = 'v1'

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM schema_privileges ORDER BY name, privilege

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM schema_privileges WHERE name = 'public' ORDER BY name, privilege

-- sqlfmt-corpus-separator --

SELECT name, privilege FROM schema_privileges WHERE name = 'sch'

-- sqlfmt-corpus-separator --

SELECT name, rolcanlogin FROM mz_roles WHERE name = 'foo'

-- sqlfmt-corpus-separator --

SELECT name, rolcanlogin FROM mz_roles WHERE name = 'test_retraction_role'

-- sqlfmt-corpus-separator --

SELECT name, type FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_cluster_prometheus_metrics' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_array_types' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_audit_events' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_aws_privatelink_connections' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_base_types' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_cluster_replica_frontiers' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_cluster_replica_sizes' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_cluster_replicas' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_clusters' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_columns' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_connections' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_databases' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_default_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_egress_ips' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_functions' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_iceberg_sinks' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_index_columns' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_indexes' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_kafka_connections' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_kafka_sinks' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_kafka_sources' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_list_types' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_map_types' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_materialized_views' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_objects' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_pseudo_types' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_recent_storage_usage' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_relations' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_role_auth' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_role_members' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_role_parameters' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_roles' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_schemas' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_secrets' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_sinks' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_sources' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_ssh_tunnel_connections' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_storage_usage' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_system_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_tables' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_timezone_abbreviations' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_timezone_names' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_types' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_catalog' AND object = 'mz_views' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_aws_connections' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_aws_privatelink_connection_status_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_aws_privatelink_connection_statuses' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_cluster_deployment_lineage' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_cluster_replica_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_cluster_replica_metrics' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_cluster_replica_metrics_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_cluster_replica_name_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_cluster_replica_status_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_cluster_replica_statuses' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_cluster_replica_utilization' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_cluster_replica_utilization_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_cluster_schedules' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_comments' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_compute_dependencies' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_compute_hydration_statuses' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_compute_operator_hydration_statuses' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_frontiers' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_history_retention_strategies' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_hydration_statuses' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_index_advice' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_internal_cluster_replicas' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_kafka_source_tables' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_license_keys' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_materialization_dependencies' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_materialization_lag' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_materialized_view_refresh_strategies' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_materialized_view_refreshes' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_mcp_data_product_details' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_mcp_data_products' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_mysql_source_tables' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_network_policies' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_network_policy_rules' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_notices' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_notices_redacted' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_object_dependencies' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_object_fully_qualified_names' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_object_global_ids' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_object_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_object_lifetimes' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_object_transitive_dependencies' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_pending_cluster_replicas' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_postgres_source_tables' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_postgres_sources' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_recent_activity_log' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_session_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_sessions' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_all_my_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_all_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_cluster_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_database_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_default_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_my_cluster_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_my_database_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_my_default_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_my_object_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_my_role_members' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_my_schema_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_my_system_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_object_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_role_members' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_schema_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_show_system_privileges' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_sink_statistics' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_sink_status_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_sink_statuses' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_source_statistics' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_source_status_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_source_statuses' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_sql_server_source_tables' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_statement_lifecycle_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_subscriptions' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_wallclock_global_lag' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_wallclock_global_lag_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_wallclock_global_lag_recent_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_wallclock_lag_history' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_internal' AND object = 'mz_webhook_sources' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_active_peeks' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_arrangement_sharing' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_arrangement_sizes' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_compute_error_counts' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_compute_exports' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_compute_frontiers' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_compute_import_frontiers' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_compute_operator_durations_histogram' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_dataflow_addresses' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_dataflow_arrangement_sizes' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_dataflow_channel_operators' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_dataflow_channels' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_dataflow_global_ids' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_dataflow_operator_dataflows' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_dataflow_operator_parents' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_dataflow_operators' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_dataflows' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_expected_group_size_advice' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_lir_mapping' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_mappable_objects' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_message_counts' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_peek_durations_histogram' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_records_per_dataflow' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_records_per_dataflow_operator' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_scheduling_elapsed' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, comment FROM objects WHERE schema = 'mz_introspection' AND object = 'mz_scheduling_parks_histogram' ORDER BY position

-- sqlfmt-corpus-separator --

SELECT name, type, status, error FROM mz_internal.mz_source_statuses WHERE name = 'webhook_bytes'

-- sqlfmt-corpus-separator --

SELECT nspname, nspacl FROM pg_catalog.pg_namespace

-- sqlfmt-corpus-separator --

SELECT objsubid, description FROM pg_description WHERE objoid >= 20000;

-- sqlfmt-corpus-separator --

SELECT oid >= 20000 FROM pg_type WHERE typname = 'int4_list_c';

-- sqlfmt-corpus-separator --

SELECT oprname, oid, oprresult, oprleft, oprright
FROM pg_catalog.pg_operator
WHERE oprname = '+'
ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_cluster_replicas GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_clusters GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_connections GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_databases GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_functions GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_indexes GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_materialized_views GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_relations GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_schemas GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_secrets GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_sinks GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_sources GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_tables GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_types GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT owner_id FROM mz_views GROUP BY owner_id

-- sqlfmt-corpus-separator --

SELECT peep, (
  SELECT likee FROM likes WHERE liker = peep
) FROM peeps

-- sqlfmt-corpus-separator --

SELECT peep, EXISTS(
  SELECT * FROM likes WHERE peep = liker
) FROM peeps

-- sqlfmt-corpus-separator --

SELECT peeps.peep, (
  SELECT age FROM likes, age WHERE peeps.peep = liker AND likee = age.peep
) FROM peeps

-- sqlfmt-corpus-separator --

SELECT previous_name, new_name FROM mz_internal.mz_cluster_replica_name_history WHERE new_name = 'weewoo1' OR new_name = 'weewoo2';

-- sqlfmt-corpus-separator --

SELECT proname, pronamespace, oid, proargdefaults, prorettype
FROM pg_catalog.pg_proc
WHERE proname = 'substring'
ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT r+r FROM mv13;

-- sqlfmt-corpus-separator --

SELECT redacted_create_sql FROM mz_connections WHERE name = 'kafka_conn'

-- sqlfmt-corpus-separator --

SELECT redacted_create_sql FROM mz_indexes WHERE name = 't_idx_i'

-- sqlfmt-corpus-separator --

SELECT redacted_create_sql FROM mz_tables WHERE name = 'redactable_t'

-- sqlfmt-corpus-separator --

SELECT redacted_create_sql FROM mz_tables WHERE name = 't'

-- sqlfmt-corpus-separator --

SELECT redacted_create_sql FROM mz_types WHERE name = 'ty'

-- sqlfmt-corpus-separator --

SELECT redacted_create_sql FROM mz_views WHERE name = 'v'

-- sqlfmt-corpus-separator --

SELECT relname, reloftype, relam, reltablespace, reltoastrelid, relhasindex, relpersistence, relkind, relchecks,
    relhasrules, relhastriggers, relrowsecurity, relforcerowsecurity, relreplident, relispartition, relhasoids, reltuples
FROM pg_catalog.pg_class
WHERE relname = 'a';

-- sqlfmt-corpus-separator --

SELECT relnatts FROM pg_catalog.pg_class where relname = 'a'

-- sqlfmt-corpus-separator --

SELECT reloftype, relam, reltablespace, reltoastrelid, relhasindex, relpersistence, relkind, relchecks,
    relhasrules, relhastriggers, relrowsecurity, relforcerowsecurity, relreplident, relispartition, relhasoids
FROM pg_catalog.pg_class
WHERE relname = (SELECT name FROM mz_indexes WHERE on_id = (SELECT id FROM mz_objects WHERE name = 'a'));

-- sqlfmt-corpus-separator --

SELECT replication_factor FROM mz_catalog.mz_clusters WHERE name = 'c_schedule_1';

-- sqlfmt-corpus-separator --

SELECT replication_factor FROM mz_catalog.mz_clusters WHERE name = 'c_schedule_3';

-- sqlfmt-corpus-separator --

SELECT replication_factor FROM mz_catalog.mz_clusters WHERE name = 'c_schedule_4';

-- sqlfmt-corpus-separator --

SELECT replication_factor FROM mz_catalog.mz_clusters WHERE name = 'c_schedule_6';

-- sqlfmt-corpus-separator --

SELECT rolname FROM pg_roles ORDER BY oid

-- sqlfmt-corpus-separator --

SELECT row, trim, position, substring, normalize
FROM iffy_colnames;

-- sqlfmt-corpus-separator --

SELECT rowid FROM t WHERE a = 10

-- sqlfmt-corpus-separator --

SELECT sql FROM mz_internal.mz_recent_activity_log_redacted

-- sqlfmt-corpus-separator --

SELECT sql FROM mz_internal.mz_recent_sql_text_redacted

-- sqlfmt-corpus-separator --

SELECT sql FROM mz_internal.mz_statement_execution_history_redacted

-- sqlfmt-corpus-separator --

SELECT t.b FROM t GROUP BY a

-- sqlfmt-corpus-separator --

SELECT t.c FROM t GROUP BY a

-- sqlfmt-corpus-separator --

SELECT t1.a / t2.a FROM error_test t1, error_test t2

-- sqlfmt-corpus-separator --

SELECT t1.a, (SELECT t2.a FROM t t2 WHERE t2.b = 2 AND t1.b = t2.b GROUP BY t2.a) FROM t t1;

-- sqlfmt-corpus-separator --

SELECT t1.a, t1.b, t2.c FROM t1, t2
WHERE
    t1.a = t2.a AND
    t1.a = 2 AND t1.b = 'l2'

-- sqlfmt-corpus-separator --

SELECT t1.a, t1.b, t2.c FROM t1, t2
WHERE
    t1.a = t2.a AND
    t1.b = 'l2'

-- sqlfmt-corpus-separator --

SELECT test_json -> 'field2' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json -> 'x' FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json -> 'x' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json -> 'x' FROM test_jsonb WHERE json_type = 'scalar'

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

SELECT test_json ->> 'field4' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field5' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 'field6' FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 2 FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 2 FROM test_jsonb WHERE json_type = 'object'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 2 FROM test_jsonb WHERE json_type = 'scalar'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 6 FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT test_json ->> 7 FROM test_jsonb WHERE json_type = 'array'

-- sqlfmt-corpus-separator --

SELECT true FROM s1 WHERE EXISTS (SELECT true FROM s2 WHERE EXISTS (SELECT true FROM s3 WHERE a = s3.b))

-- sqlfmt-corpus-separator --

SELECT true || false

-- sqlfmt-corpus-separator --

SELECT true, false, null
FROM iffy_colnames;

-- sqlfmt-corpus-separator --

SELECT ts < 18446744073709551615 FROM logical_timestamp_view

-- sqlfmt-corpus-separator --

SELECT ts FROM untyped WHERE ts != '2015-09-18 00:00:00'

-- sqlfmt-corpus-separator --

SELECT typname, typelem
FROM pg_type t
WHERE typname = 'list';

-- sqlfmt-corpus-separator --

SELECT usename, usesysid, usecreatedb, usesuper, userepl, usebypassrls, passwd, valuntil, useconfig FROM pg_user;

-- sqlfmt-corpus-separator --

SELECT v1."?column?" FROM v1

-- sqlfmt-corpus-separator --

SELECT value FROM boolean_table

-- sqlfmt-corpus-separator --

SELECT value from numbers LIMIT 10 OFFSET 6;

-- sqlfmt-corpus-separator --

SELECT value from numbers LIMIT 20;

-- sqlfmt-corpus-separator --

SELECT value from numbers LIMIT 5;

-- sqlfmt-corpus-separator --

SELECT v||'foo' FROM kv

-- sqlfmt-corpus-separator --

SELECT w FROM t3 WHERE v > 0 AND v < 100 ORDER BY v

-- sqlfmt-corpus-separator --

SELECT x + 1 FROM a

-- sqlfmt-corpus-separator --

SELECT x + 1, x + y FROM a WHERE x + y > 20

-- sqlfmt-corpus-separator --

SELECT x FROM b WHERE rowid > 0

-- sqlfmt-corpus-separator --

SELECT x FROM b1.t

-- sqlfmt-corpus-separator --

SELECT x FROM b2.t

-- sqlfmt-corpus-separator --

SELECT x FROM grand_friend.mv1;

-- sqlfmt-corpus-separator --

SELECT x FROM nan ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x FROM onecolumn AS a, onecolumn AS b

-- sqlfmt-corpus-separator --

SELECT x FROM v2

-- sqlfmt-corpus-separator --

SELECT x FROM v7

-- sqlfmt-corpus-separator --

SELECT x FROM v7 ORDER BY x LIMIT 1

-- sqlfmt-corpus-separator --

SELECT x, X, "Y" FROM foo

-- sqlfmt-corpus-separator --

SELECT x, x + 1, y, y + 1, x + y FROM a

-- sqlfmt-corpus-separator --

SELECT x, x, y, x FROM a

-- sqlfmt-corpus-separator --

SELECT x.a FROM [u1 AS materialize.public.y]

-- sqlfmt-corpus-separator --

SELECT y FROM v2

-- sqlfmt-corpus-separator --

SELECT y FROM v7

-- sqlfmt-corpus-separator --

SELECT y FROM v7 ORDER BY x LIMIT 1

-- sqlfmt-corpus-separator --

SELECT y.a FROM [u1 AS materialize.public.y]

-- sqlfmt-corpus-separator --

SELECT y.a FROM [u6 AS materialize.public.y]

-- sqlfmt-corpus-separator --

SELECT y.a FROM [ux AS materialize.public.y]

-- sqlfmt-corpus-separator --

SELECT y.a FROM [xx AS materialize.public.y]

-- sqlfmt-corpus-separator --

SELECT ~0, ~1, ~65535, ~2147483647, ~9223372036854775807

-- sqlfmt-corpus-separator --

WITH
    t AS (SELECT true),
    t AS (SELECT false)
SELECT * FROM t

-- sqlfmt-corpus-separator --

WITH c AS (SELECT a + 1 FROM x) SELECT (SELECT * FROM c);

-- sqlfmt-corpus-separator --

WITH cte1 AS (SELECT 1 AS a, 2 AS a) SELECT * FROM cte1 WHERE cte1.a = 1

-- sqlfmt-corpus-separator --

WITH t AS (SELECT a FROM x) SELECT a, x.t FROM t

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

WITH t(x) AS (WITH t(x) AS (SELECT 1) SELECT x * 10 FROM t) SELECT x + 2 FROM t

-- sqlfmt-corpus-separator --

select (select (select view_a)) from view_a

-- sqlfmt-corpus-separator --

select (select view_a) from view_a

-- sqlfmt-corpus-separator --

select * FROM d ORDER BY i

-- sqlfmt-corpus-separator --

select * FROM f ORDER BY i

-- sqlfmt-corpus-separator --

select * FROM i ORDER BY i

-- sqlfmt-corpus-separator --

select * from quadtable;

-- sqlfmt-corpus-separator --

select * from t

-- sqlfmt-corpus-separator --

select * from t1

-- sqlfmt-corpus-separator --

select * from valid AS OF 11;

-- sqlfmt-corpus-separator --

select * from valid AS OF 14;

-- sqlfmt-corpus-separator --

select * from valid AS OF 18446744073709551614;

-- sqlfmt-corpus-separator --

select * from valid AS OF 2;

-- sqlfmt-corpus-separator --

select * from valid AS OF 3;

-- sqlfmt-corpus-separator --

select * from valid_events;

-- sqlfmt-corpus-separator --

select * from valid_max AS OF 0

-- sqlfmt-corpus-separator --

select 2 * 2 OPERATOR(+) 2;

-- sqlfmt-corpus-separator --

select 2 OPERATOR(*) 2 + 2;

-- sqlfmt-corpus-separator --

select 2 OPERATOR(*) 2 OPERATOR(+) 2;

-- sqlfmt-corpus-separator --

select 2 OPERATOR(*) 2;

-- sqlfmt-corpus-separator --

select 2 OPERATOR(+) 2;

-- sqlfmt-corpus-separator --

select 2 OPERATOR(-) 2;

-- sqlfmt-corpus-separator --

select 2 OPERATOR(/) 2

-- sqlfmt-corpus-separator --

select 2 OPERATOR(mz_catalog.*) 2;

-- sqlfmt-corpus-separator --

select 2 OPERATOR(mz_catalog.public.*) 2;

-- sqlfmt-corpus-separator --

select 2 OPERATOR(pg_catalog.*) 2;

-- sqlfmt-corpus-separator --

select 2 OPERATOR(pg_catalog.+) 2;

-- sqlfmt-corpus-separator --

select 2 OPERATOR(pg_catalog.-) 2;

-- sqlfmt-corpus-separator --

select 2 OPERATOR(pg_catalog./) 2

-- sqlfmt-corpus-separator --

select a, b, ( select c from test3 where a = test3.a and b = test3.b) from test1;

-- sqlfmt-corpus-separator --

select a.thousand from tenk1 a, tenk1 b
where a.thousand = b.thousand
  and exists ( select 1 from tenk1 c where b.hundred = c.hundred
                   and not exists ( select 1 from tenk1 d
                                    where a.thousand = d.thousand ) )

-- sqlfmt-corpus-separator --

select b, c from foo where a = 5

-- sqlfmt-corpus-separator --

select exists(select * from nocolumns)

-- sqlfmt-corpus-separator --

select f1, q.c1 from quadtable;

-- sqlfmt-corpus-separator --

select foo.a, b, c, d, e from foo, bar where foo.a = bar.a and b = 'this'

-- sqlfmt-corpus-separator --

select foo.a, baz.b
from foo, bar, baz
where foo.a = bar.a
  and baz.a = bar.b

-- sqlfmt-corpus-separator --

select foo.b, bar.b, baz.b
FROM bar, foo, baz
where foo.a = bar.a
  and bar.a + 4 = baz.a

-- sqlfmt-corpus-separator --

select view_a from view_a

-- sqlfmt-corpus-separator --

select x < '3000-01-01' from v;