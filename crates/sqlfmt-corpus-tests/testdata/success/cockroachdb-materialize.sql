DECLARE bar CURSOR FOR SELECT 1,2,3;

-- sqlfmt-corpus-separator --

PREPARE change_db_3 AS SELECT * from othertable AS t1, test.othertable AS t2

-- sqlfmt-corpus-separator --

PREPARE change_drop AS SELECT * FROM othertable WHERE b=10

-- sqlfmt-corpus-separator --

PREPARE change_placeholders AS SELECT * FROM othertable WHERE a=$1

-- sqlfmt-corpus-separator --

PREPARE concat_stmt AS SELECT concat("foo"."a", $1::STRING) FROM foo

-- sqlfmt-corpus-separator --

PREPARE concat_stmt2 AS SELECT concat("foo"."a", $1) FROM foo

-- sqlfmt-corpus-separator --

PREPARE concat_stmt3 AS SELECT concat("foo"."a", $1) FROM foo

-- sqlfmt-corpus-separator --

PREPARE foo AS SELECT $1::INT, f144020();

-- sqlfmt-corpus-separator --

PREPARE forbar AS insert into bar (id) VALUES (1)

-- sqlfmt-corpus-separator --

PREPARE insert_a AS INSERT INTO assn_cast(a) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_a2 AS INSERT INTO assn_cast(a) VALUES (ARRAY[$1])

-- sqlfmt-corpus-separator --

PREPARE insert_a3 AS INSERT INTO assn_cast(a) VALUES (ARRAY[30.12, $1, 32.1])

-- sqlfmt-corpus-separator --

PREPARE insert_c AS INSERT INTO assn_cast(c) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_ca AS INSERT INTO assn_cast(ca) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_d AS INSERT INTO assn_cast(d) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_d2 AS INSERT INTO assn_cast(d) SELECT * FROM (VALUES ($1::DECIMAL(10, 2)))

-- sqlfmt-corpus-separator --

PREPARE insert_f4 AS INSERT INTO assn_cast(f4) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_i AS INSERT INTO assn_cast(i) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_i2 AS INSERT INTO assn_cast(i2) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_qc AS INSERT INTO assn_cast(qc) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_s AS INSERT INTO assn_cast(s) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE insert_vba AS INSERT INTO assn_cast(vba) VALUES ($1)

-- sqlfmt-corpus-separator --

PREPARE jba_stmt AS SELECT json_build_array(a, $1::STRING) FROM foo;

-- sqlfmt-corpus-separator --

PREPARE jbo_stmt AS SELECT json_build_object('a', a, 'b', $1::STRING) FROM foo;

-- sqlfmt-corpus-separator --

PREPARE loc_dependent_operator AS
SELECT
  extract(EPOCH FROM TIMESTAMP WITH TIME ZONE '2010-11-06 23:59:00-05:00'),
  extract(EPOCH FROM TIMESTAMP WITH TIME ZONE '2010-11-06 23:59:00-05:00' + INTERVAL '1 day')

-- sqlfmt-corpus-separator --

PREPARE nn_stmt AS SELECT num_nulls(42, $1::STRING, a, b),
                          num_nulls(b, $1, 42, a),
                          num_nulls(a, b, $1, 42),
                          num_nulls($1, a, b, 42),
                          num_nonnulls(42, $1, a, b),
                          num_nonnulls(b, $1, 42, a),
                          num_nonnulls(a, b, $1, 42),
                          num_nonnulls($1, a, b, 42)
                     FROM nulls_test

-- sqlfmt-corpus-separator --

PREPARE nn_stmt3 AS SELECT num_nulls(42, $1::INT, a) FROM nulls_test

-- sqlfmt-corpus-separator --

PREPARE p AS
SELECT * FROM (
  SELECT id FROM t155159 WHERE a = $1 AND b >= $2
  ORDER BY b, id
  LIMIT 250
)
UNION
SELECT * FROM (
  SELECT id FROM t155159 WHERE a = $3 AND b >= $4
)

-- sqlfmt-corpus-separator --

PREPARE p AS
SELECT * FROM g
UNION ALL
SELECT * FROM g WHERE a IN ($1, $2) AND b > $3

-- sqlfmt-corpus-separator --

PREPARE p AS
SELECT t.k, c.k, g.k FROM t
JOIN c ON t.k = c.a
JOIN g ON c.k = g.a
WHERE t.a = $1 AND t.c = $2

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT $1::INT

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT 'foo'::BPCHAR = $1

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT f($1::REGCLASS::INT)

-- sqlfmt-corpus-separator --

PREPARE p1 AS INSERT INTO multiple_uniq
VALUES ($1, $1, $1, $1), ($2, $2, $2, $2)

-- sqlfmt-corpus-separator --

PREPARE p1 AS INSERT INTO users2 (name, email)
VALUES ($1, $2), ($3, $4)

-- sqlfmt-corpus-separator --

PREPARE pscs02 AS SELECT $1::float, 2

-- sqlfmt-corpus-separator --

PREPARE pscs03 AS SELECT $1::decimal, 3

-- sqlfmt-corpus-separator --

PREPARE pscs04 AS SELECT $1::string, 4

-- sqlfmt-corpus-separator --

PREPARE pscs05 AS SELECT $1::json, 5

-- sqlfmt-corpus-separator --

PREPARE pscs06 AS SELECT $1::int, 6

-- sqlfmt-corpus-separator --

PREPARE pscs10 AS SELECT $1::bytes, 10

-- sqlfmt-corpus-separator --

PREPARE pscs11 AS SELECT $1::smallint, 11

-- sqlfmt-corpus-separator --

PREPARE pscs13 AS SELECT $1::bigint, 13

-- sqlfmt-corpus-separator --

PREPARE pscs14 AS SELECT $1::int, 14

-- sqlfmt-corpus-separator --

PREPARE pscs16 AS SELECT $1::float, 16

-- sqlfmt-corpus-separator --

PREPARE regression_71394 AS SELECT ARRAY[$1]::int[];

-- sqlfmt-corpus-separator --

PREPARE s1 AS SELECT * FROM t1 WHERE a=$1

-- sqlfmt-corpus-separator --

PREPARE s73450_a AS SELECT $1::INT2

-- sqlfmt-corpus-separator --

PREPARE s73450_b AS SELECT $1::CHAR

-- sqlfmt-corpus-separator --

PREPARE s73450_c AS SELECT * FROM t73450 WHERE c = $1::CHAR

-- sqlfmt-corpus-separator --

PREPARE s_114867 AS INSERT INTO test_114867(colors) VALUES (ARRAY[$1::text]::color[]);
EXECUTE s_114867('red')

-- sqlfmt-corpus-separator --

PREPARE selectin AS SELECT 1 in ($1, $2)

-- sqlfmt-corpus-separator --

PREPARE selectin2 AS SELECT $1::int in ($2, $3)

-- sqlfmt-corpus-separator --

PREPARE showOwners AS
  WITH db_id AS (
                SELECT id
                  FROM system.namespace
                 WHERE "parentID" = 0
                   AND "parentSchemaID" = 0
                   AND name = $1
             ),
       entities AS (
                    SELECT ns.id
                      FROM system.namespace AS ns
                      JOIN db_id ON (ns."parentID" = db_id.id)
                ),
      descs AS (
         SELECT crdb_internal.pb_to_json('cockroach.sql.sqlbase.Descriptor', descriptor) AS jdesc
           FROM system.descriptor AS sd
           JOIN entities ON (entities.id = sd.id)
      )
SELECT jdesc->'schema'->>'name' AS schema, jdesc->'schema'->'privileges'->>'ownerProto' AS owner,
       jdesc->'type'->>'name' AS type, jdesc->'type'->'privileges'->>'ownerProto' AS owner,
       jdesc->'table'->>'name' AS object, jdesc->'table'->'privileges'->>'ownerProto' AS owner
       FROM descs
ORDER BY 1,2,3,4,5,6

-- sqlfmt-corpus-separator --

PREPARE subqueryprep AS SELECT * FROM abc WHERE EXISTS(SELECT * FROM xyz WHERE y IN ($1 + 1))

-- sqlfmt-corpus-separator --

PREPARE update_d2 AS UPDATE assn_cast SET d = (SELECT * FROM (VALUES ($1::DECIMAL(10, 2))))

-- sqlfmt-corpus-separator --

PREPARE update_privileges AS UPDATE othertable SET b=$1

-- sqlfmt-corpus-separator --

PREPARE x AS INSERT INTO kv VALUES ($1, $2) RETURNING NOTHING

-- sqlfmt-corpus-separator --

PREPARE x AS SELECT $1 = (1,2) AS r FROM tb

-- sqlfmt-corpus-separator --

PREPARE x19597 AS SELECT $1 IN ($2, null);

-- sqlfmt-corpus-separator --

PREPARE y AS SELECT (1,2) = $1 AS r FROM tb