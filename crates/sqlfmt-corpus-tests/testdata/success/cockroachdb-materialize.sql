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

-- sqlfmt-corpus-separator --

SELECT
	a,
	b,
	count(*) OVER (ORDER BY b),
	count(*) OVER (
		ORDER BY
			b
		RANGE
			BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	),
	count(*) OVER (
		ORDER BY
			b
		ROWS
			BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	)
FROM
	(VALUES (1, 1), (2, 1), (3, 2), (4, 2)) AS t (a, b)
ORDER BY
	a, b

-- sqlfmt-corpus-separator --

SELECT
	array_agg(t_pk.table_name ORDER BY t_pk.table_name)
FROM
	information_schema.statistics AS i
	LEFT JOIN (
			SELECT
				array_agg(c.column_name) AS table_primary_key_columns,
				c.table_name
			FROM
				information_schema.columns AS c
			GROUP BY
				c.table_name
		)
			AS t_pk ON i.table_name = t_pk.table_name
GROUP BY
	t_pk.table_primary_key_columns

-- sqlfmt-corpus-separator --

SELECT
    indexname, array_agg(attname ORDER BY rnum), indisunique, indisprimary,
    array_agg(ordering ORDER BY rnum), amname, exprdef, s2.attoptions
FROM (
    SELECT
        c2.relname as indexname, idx.*, attr.attname, am.amname,
        CASE
            WHEN idx.indexprs IS NOT NULL THEN
                pg_get_indexdef(idx.indexrelid)
        END AS exprdef,
        CASE am.amname
            WHEN 'prefix' THEN
                CASE (option & 1)
                    WHEN 1 THEN 'DESC' ELSE 'ASC'
                END
        END as ordering,
        c2.reloptions as attoptions
    FROM (
        SELECT
            row_number() OVER () as rnum, *,
            unnest(i.indkey) as key, unnest(i.indoption) as option
        FROM pg_index i
    ) idx
    LEFT JOIN pg_class c ON idx.indrelid = c.oid
    LEFT JOIN pg_class c2 ON idx.indexrelid = c2.oid
    LEFT JOIN pg_am am ON c2.relam = am.oid
    LEFT JOIN pg_attribute attr ON attr.attrelid = c.oid AND attr.attnum = idx.key
    WHERE c.relname = 'indexes_table'
) s2
GROUP BY indexname, indisunique, indisprimary, amname, exprdef, attoptions
ORDER BY indexname

-- sqlfmt-corpus-separator --

SELECT
    min(a) OVER (PARTITION BY (a, a)) AS min,
    max(a) OVER (PARTITION BY (a, a)) AS max
FROM
    (SELECT 1 AS a)

-- sqlfmt-corpus-separator --

SELECT
    row_number() OVER (PARTITION BY s)
FROM
    (SELECT sum(a) AS s FROM (SELECT a FROM x UNION ALL SELECT a FROM x) GROUP BY a)

-- sqlfmt-corpus-separator --

SELECT
  DISTINCT ON ("genre") genre
FROM
  "public"."author"
ORDER BY
  "genre" ASC NULLS LAST

-- sqlfmt-corpus-separator --

SELECT
  avg(a) OVER            (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(a) OVER (ORDER BY a RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(a) OVER (ORDER BY b RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(a) OVER (ORDER BY c RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(b) OVER            (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(b) OVER (ORDER BY a RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(b) OVER (ORDER BY b RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(b) OVER (ORDER BY c RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(c) OVER            (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(c) OVER (ORDER BY a RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(c) OVER (ORDER BY b RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),
  avg(c) OVER (ORDER BY c RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM abc

-- sqlfmt-corpus-separator --

SELECT
  avg(a) OVER (),
  avg(a) OVER (ORDER BY a),
  avg(a) OVER (ORDER BY b),
  avg(a) OVER (ORDER BY c),
  avg(b) OVER (),
  avg(b) OVER (ORDER BY a),
  avg(b) OVER (ORDER BY b),
  avg(b) OVER (ORDER BY c),
  avg(c) OVER (),
  avg(c) OVER (ORDER BY a),
  avg(c) OVER (ORDER BY b),
  avg(c) OVER (ORDER BY c)
FROM abc

-- sqlfmt-corpus-separator --

SELECT
  id,
  row_number() OVER (ORDER BY id NULLS LAST) AS row_num_using_nulls_last,
  row_number() OVER (ORDER BY COALESCE(id, 999)) AS row_num_using_coalesce
FROM
  nulls_last_test
ORDER BY
  id NULLS LAST

-- sqlfmt-corpus-separator --

SELECT
  id,
  row_number() OVER (ORDER BY id) AS row_num_using_nulls_last,
  row_number() OVER (ORDER BY COALESCE(id, 999)) AS row_num_using_coalesce
FROM
  nulls_last_test
ORDER BY
  id

-- sqlfmt-corpus-separator --

SELECT
  s_p.nspname AS parentschema,
  t_p.relname AS parenttable,
  unnest(
    (
      SELECT
        array_agg(attname ORDER BY i)
      FROM
        (
          SELECT
            unnest(confkey) AS attnum,
            generate_subscripts(confkey, 1) AS i
        )
          AS x
        JOIN pg_catalog.pg_attribute AS c USING (attnum)
      WHERE
        c.attrelid = fk.confrelid
    )
  )
    AS parentcolumn,
  s_c.nspname AS childschema,
  t_c.relname AS childtable,
  unnest(
    (
      SELECT
        array_agg(attname ORDER BY i)
      FROM
        (
          SELECT
            unnest(conkey) AS attnum,
            generate_subscripts(conkey, 1) AS i
        )
          AS x
        JOIN pg_catalog.pg_attribute AS c USING (attnum)
      WHERE
        c.attrelid = fk.conrelid
    )
  )
    AS childcolumn
FROM
  pg_catalog.pg_constraint AS fk
  JOIN pg_catalog.pg_class AS t_p ON t_p.oid = fk.confrelid
  JOIN pg_catalog.pg_namespace AS s_p ON
      s_p.oid = t_p.relnamespace
  JOIN pg_catalog.pg_class AS t_c ON t_c.oid = fk.conrelid
  JOIN pg_catalog.pg_namespace AS s_c ON
      s_c.oid = t_c.relnamespace
WHERE
  fk.contype = 'f';

-- sqlfmt-corpus-separator --

SELECT
DISTINCT ON (t2.id)
t2.*
FROM t1, t2
ORDER BY t2.id ASC NULLS LAST

-- sqlfmt-corpus-separator --

SELECT
DISTINCT ON (t2.id)
t2.*
FROM t1, t2
ORDER BY t2.id DESC NULLS FIRST

-- sqlfmt-corpus-separator --

SELECT "reportingID",
       (info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp')
       || (
			SELECT json_build_object(
					'CascadeDroppedViews',
					json_agg(value ORDER BY value)
			       )
			  FROM ROWS FROM (
					json_array_elements((info::JSONB)->'CascadeDroppedViews')
			       )
		)
  FROM system.eventlog
 WHERE "eventType" IN ('drop_view', 'drop_table')
 ORDER BY "timestamp" DESC
 LIMIT 1;

-- sqlfmt-corpus-separator --

SELECT "reportingID",
       (info::JSONB - 'Timestamp' - 'DescriptorID' - 'TxnReadTimestamp')
       || (
			SELECT json_build_object(
					'DroppedSchemaObjects',
					json_agg(value ORDER BY value)
			       )
			  FROM ROWS FROM (
					json_array_elements((info::JSONB)->'DroppedSchemaObjects')
			       )
		)
  FROM system.eventlog
 WHERE "eventType" = 'drop_database'
       AND info::JSONB->>'Statement' LIKE 'DROP DATABASE eventlogtest%'
 ORDER BY "timestamp";

-- sqlfmt-corpus-separator --

SELECT (1/j) * max(i) * (row_number() OVER (ORDER BY max(i))) FROM (SELECT 1 AS i, 2 AS j) GROUP BY j

-- sqlfmt-corpus-separator --

SELECT (SELECT DISTINCT ON (a) a FROM abc ORDER BY a, b||'foo') || 'bar';

-- sqlfmt-corpus-separator --

SELECT (SELECT string_agg(DISTINCT ship, ', ')
  FROM
  (SELECT c_id AS o_c_id, ship FROM o ORDER BY ship)
  WHERE o_c_id=c.c_id)
FROM c ORDER BY c_id

-- sqlfmt-corpus-separator --

SELECT (avg(d) OVER (PARTITION BY v ORDER BY w) + avg(d) OVER (PARTITION BY v ORDER BY w)) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT (avg(d) OVER (PARTITION BY v ORDER BY w) + avg(d) OVER (PARTITION BY w ORDER BY v)) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT * FROM (SELECT k, d, v, stddev(d) OVER (PARTITION BY v) FROM kv) sub ORDER BY variance(d) OVER (PARTITION BY v), k

-- sqlfmt-corpus-separator --

SELECT * FROM kv GROUP BY v, count(DISTINCT w)

-- sqlfmt-corpus-separator --

SELECT * FROM kv GROUP BY v, count(w) OVER ()

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY w LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY w, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY y, w LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY w, z ORDER BY y) FROM wxyz ORDER BY w, z, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY w, z ORDER BY y) FROM wxyz ORDER BY z, w, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, avg(w) OVER (PARTITION BY z ORDER BY y) FROM wxyz ORDER BY y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY w LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY w, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY y, w LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY w, z ORDER BY y) FROM wxyz ORDER BY w, z, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY w, z ORDER BY y) FROM wxyz ORDER BY z, w, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, dense_rank() OVER (PARTITION BY z ORDER BY y) FROM wxyz ORDER BY y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY w LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY w, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY w ORDER BY y) FROM wxyz ORDER BY y, w LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY w, z ORDER BY y) FROM wxyz ORDER BY w, z, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY w, z ORDER BY y) FROM wxyz ORDER BY z, w, y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT *, rank() OVER (PARTITION BY z ORDER BY y) FROM wxyz ORDER BY y LIMIT 2

-- sqlfmt-corpus-separator --

SELECT 1 FROM kv GROUP BY 1 HAVING sum(1) OVER (PARTITION BY 1) > 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT (a) FROM data

-- sqlfmt-corpus-separator --

SELECT DISTINCT (x) FROM t

-- sqlfmt-corpus-separator --

SELECT DISTINCT (y,z) FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT * FROM t44079

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

SELECT DISTINCT ON (a, b) a, b FROM abc ORDER BY a, b, c

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a, c) a, b FROM abc ORDER BY a, c, b

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (a,b,c) a, b, c FROM abc

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

SELECT DISTINCT ON (max(x)) min(y) FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (min(x)) max(y) FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x) min(x) FROM xyz GROUP BY y

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

SELECT DISTINCT ON (x, y, z) pk1 FROM (SELECT * FROM xyz WHERE x >= 2) ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, y, z) x, y, z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x, z) y, z, x FROM xyz WHERE (x,y,z) != (4, 1, 6) ORDER BY z

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x,y,z) x, y, z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (x,y,z) x, y, z FROM xyz ORDER BY x

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (y) x, y FROM xyz ORDER BY y, x

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

SELECT DISTINCT ON(max(x), z) min(y) FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(min(a), max(b), min(c)) max(c) FROM abc

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(min(x)) min(x) FROM xyz GROUP BY y HAVING min(x) = 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(pk1, pk2, x, y) x, y, z FROM xyz ORDER BY x, y

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz ORDER BY row_number() OVER(ORDER BY (pk1, pk2)) DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(x) x AS y FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(y) min(x) FROM xyz GROUP BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT _int FROM t88110 WHERE NOT _bool;

-- sqlfmt-corpus-separator --

SELECT DISTINCT a, b FROM data WHERE (a + b + c::INT) = 27 ORDER BY a,b

-- sqlfmt-corpus-separator --

SELECT DISTINCT a, b FROM data WHERE (a + b + c::INT) = 27 ORDER BY b,a

-- sqlfmt-corpus-separator --

SELECT DISTINCT authors.name FROM books AS b1, books2 as b2, authors WHERE b1.title = b2.title AND authors.book = b1.title AND b1.shelf <> b2.shelf

-- sqlfmt-corpus-separator --

SELECT DISTINCT b1.title FROM books as b1 JOIN books2 as b2 ON b1.title = b2.title WHERE b1.shelf <> b2.shelf

-- sqlfmt-corpus-separator --

SELECT DISTINCT c, b FROM t ORDER BY b DESC LIMIT 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT classid, refclassid FROM pg_shdepend
WHERE classid != 0
LIMIT 5

-- sqlfmt-corpus-separator --

SELECT DISTINCT classid, refclassid, cla.relname AS tablename, refcla.relname AS reftablename
FROM pg_catalog.pg_depend
JOIN pg_class cla ON classid=cla.oid
JOIN pg_class refcla ON refclassid=refcla.oid

-- sqlfmt-corpus-separator --

SELECT DISTINCT pg_constraint.contype
FROM pg_depend
JOIN pg_constraint ON objid=pg_constraint.oid AND refobjid=pg_constraint.conindid

-- sqlfmt-corpus-separator --

SELECT DISTINCT proname, prokind FROM pg_catalog.pg_proc
WHERE proname IN ('lag', 'abs', 'max', 'pro')

-- sqlfmt-corpus-separator --

SELECT DISTINCT s FROM t1

-- sqlfmt-corpus-separator --

SELECT DISTINCT s FROM t2

-- sqlfmt-corpus-separator --

SELECT DISTINCT tableoid FROM pg_attribute LIMIT 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT tableoid FROM pg_class LIMIT 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT tableoid FROM pg_index LIMIT 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT tableoid FROM pg_namespace LIMIT 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT tableoid FROM pg_proc LIMIT 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT tableoid FROM pg_type LIMIT 1

-- sqlfmt-corpus-separator --

SELECT DISTINCT v FROM kv

-- sqlfmt-corpus-separator --

SELECT DISTINCT x FROM t2

-- sqlfmt-corpus-separator --

SELECT DISTINCT x FROM t2 ORDER BY x DESC

-- sqlfmt-corpus-separator --

SELECT DISTINCT y + z FROM xyz ORDER by (y + z)

-- sqlfmt-corpus-separator --

SELECT DISTINCT y AS w FROM xyz ORDER by y

-- sqlfmt-corpus-separator --

SELECT DISTINCT y AS w, z FROM xyz ORDER by z, w

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, z FROM xyz ORDER BY y

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, z FROM xyz ORDER BY y, z

-- sqlfmt-corpus-separator --

SELECT DISTINCT y, z FROM xyz ORDER BY z

-- sqlfmt-corpus-separator --

SELECT DISTINCT y,z FROM xyz

-- sqlfmt-corpus-separator --

SELECT DISTINCT(a), b FROM a ORDER BY 1, 2 LIMIT 10

-- sqlfmt-corpus-separator --

SELECT DISTINCT(database_id) FROM crdb_internal.tenant_span_stats()

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_Collect(geom ORDER BY geom)) FROM geo_table

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_MakeLine(geom ORDER BY geom)) FROM geo_table

-- sqlfmt-corpus-separator --

SELECT ST_AsText(ST_MemCollect(geom ORDER BY geom)) FROM geo_table

-- sqlfmt-corpus-separator --

SELECT a, b - lag(b, 1) OVER (ORDER BY a) FROM t ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, b, avg(b) OVER () FROM t ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b, avg(b) OVER (ROWS 0 PRECEDING) FROM t ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, b, c, cume_dist() OVER (PARTITION BY a ORDER BY c) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, c, dense_rank() OVER (PARTITION BY a ORDER BY c) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, c, ntile(2) OVER (PARTITION BY a ORDER BY c) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, c, percent_rank() OVER (PARTITION BY a ORDER BY c) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, c, rank() OVER (PARTITION BY a ORDER BY c) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, cume_dist() OVER () FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, cume_dist() OVER (ORDER BY a) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, dense_rank() OVER () FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, dense_rank() OVER (ORDER BY a) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, ntile(2) OVER (ORDER BY a, b) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, percent_rank() OVER () FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, percent_rank() OVER (ORDER BY a) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, rank() OVER () FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, rank() OVER (ORDER BY a) FROM t

-- sqlfmt-corpus-separator --

SELECT a, b, row_number() OVER (ORDER BY a, b) FROM t ORDER BY a, b

-- sqlfmt-corpus-separator --

SELECT a, b, row_number() OVER (PARTITION BY a ORDER BY b) FROM t ORDER BY a, b

-- sqlfmt-corpus-separator --

SELECT a, b, row_number() OVER (PARTITION BY a, b) FROM t ORDER BY a, b

-- sqlfmt-corpus-separator --

SELECT a, b, sum(b) OVER (ROWS 0 PRECEDING) FROM t ORDER BY a

-- sqlfmt-corpus-separator --

SELECT a, json_agg(a) OVER (ORDER BY a) FROM x ORDER BY a

-- sqlfmt-corpus-separator --

SELECT array_agg((k, v) ORDER BY (k+1, v||'foo') NULLS FIRST) FROM nulls_last_test;

-- sqlfmt-corpus-separator --

SELECT array_agg((k, v) ORDER BY (k+1, v||'foo') NULLS LAST) FROM nulls_last_test;

-- sqlfmt-corpus-separator --

SELECT array_agg((k, v) ORDER BY (k+1, v||'foo')) FROM nulls_last_test;

-- sqlfmt-corpus-separator --

SELECT array_agg((k, v) ORDER BY (k, v) NULLS FIRST) FROM nulls_last_test

-- sqlfmt-corpus-separator --

SELECT array_agg((k, v) ORDER BY (k, v) NULLS LAST) FROM nulls_last_test

-- sqlfmt-corpus-separator --

SELECT array_agg((k, v) ORDER BY (k, v)) FROM nulls_last_test

-- sqlfmt-corpus-separator --

SELECT array_agg(ROW(k,v) ORDER BY k) FROM kv

-- sqlfmt-corpus-separator --

SELECT array_agg(a) OVER () FROM l LIMIT 1

-- sqlfmt-corpus-separator --

SELECT array_agg(a) OVER (ORDER BY a ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) FROM t38901 ORDER BY a

-- sqlfmt-corpus-separator --

SELECT array_agg(bar ORDER BY pk) FROM foo

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1), array_agg(col1 ORDER BY col1) FILTER (WHERE col1 < 0) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1), array_agg(col1 ORDER BY col2, col1), array_agg(col1 ORDER BY col3, col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1), array_agg(col1 ORDER BY col2, col1), col3 FROM tab GROUP BY col3 ORDER BY col3

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col1), array_agg(col1 ORDER BY col2, col1), count(col3), count(*) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col2) FROM TAB

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col2*100+col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(col1 ORDER BY col3, col1) FILTER (WHERE col1 < 0), array_agg(col1 ORDER BY col3, col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY id NULLS LAST) FROM nulls_last_test

-- sqlfmt-corpus-separator --

SELECT array_agg(id ORDER BY id) FROM nulls_last_test

-- sqlfmt-corpus-separator --

SELECT array_agg(v ORDER BY k) FROM kv_enum

-- sqlfmt-corpus-separator --

SELECT array_agg(x ORDER BY x) FROM t;

-- sqlfmt-corpus-separator --

SELECT array_agg(y ORDER BY y) FROM t;

-- sqlfmt-corpus-separator --

SELECT array_cat_agg(arr ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_cat_agg(arr ORDER BY col2*100+col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT array_cat_agg(arr ORDER BY k), array_cat_agg(NULL::INT[]), array_cat_agg('{NULL, NULL}'::INT[]) FROM kv WHERE arr IS NOT NULL

-- sqlfmt-corpus-separator --

SELECT array_to_string(array_agg(i ORDER BY pk), ' ') FROM intervals

-- sqlfmt-corpus-separator --

SELECT avg(DISTINCT k), avg(DISTINCT v), sum(DISTINCT k), sum(DISTINCT v) FROM kv

-- sqlfmt-corpus-separator --

SELECT avg(avg(k) OVER ()) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(avg(k) OVER ()) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(avg(k)) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(d) OVER (PARTITION BY v) FROM kv WHERE FALSE ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(d) OVER (PARTITION BY v, v, v, v, v, v, v, v, v, v) FROM kv WHERE FALSE ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(d) OVER (PARTITION BY v, v, v, v, v, v, v, v, v, v) FROM kv WHERE k = 3 ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(d) OVER (PARTITION BY w ORDER BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(f) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (), avg(v) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY 1-w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY a) FROM kv

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY b) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY kv.*) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY w DESC) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (ORDER BY w, b) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY a) FROM kv

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY b) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY kv.*) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k) OVER (PARTITION BY w, b) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(k), max(v), min(w), 2 + row_number() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT avg(price) OVER (GROUPS 1 PRECEDING) FROM products

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(DISTINCT employee, ',')
FROM string_agg_test
GROUP BY company_id
ORDER BY company_id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL, NULL::BYTES)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL, NULL::STRING)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::BYTES, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::BYTES, employee::BYTES)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::STRING, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(NULL::STRING, employee)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee)
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, '')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, ',')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, 'foo', employee, 'bar')
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, employee, employee)
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee, lower(employee))
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTES, NULL)
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTES, b'')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(employee::BYTES, b',')
OVER (PARTITION BY company_id ORDER BY id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT company_id, string_agg(lower(employee), employee)
OVER (PARTITION BY company_id)
FROM string_agg_test
ORDER BY company_id, id;

-- sqlfmt-corpus-separator --

SELECT concat_agg(col3 ORDER BY col1 DESC) FROM tab

-- sqlfmt-corpus-separator --

SELECT concat_agg(col3 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT corr(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT corr(DISTINCT y, x), count(DISTINCT y) FROM t55776

-- sqlfmt-corpus-separator --

SELECT corr(DISTINCT y, x), count(y) FROM t55837

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE 1) OVER () FROM products

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE count(*) > 5) OVER () FROM products

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE count(*) OVER () > 5) OVER () FROM products

-- sqlfmt-corpus-separator --

SELECT count(*) FILTER (WHERE true) OVER (), count(*) FILTER (WHERE false) OVER () FROM products

-- sqlfmt-corpus-separator --

SELECT count(1), concat_agg(col3 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT (k, (v))) FROM kv

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT (k, v)) FROM kv

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT (v)) FROM kv

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT a), count(DISTINCT b), count(DISTINCT c) FROM serial

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT a), count(DISTINCT b), count(DISTINCT c) FROM serials

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT a), count(DISTINCT b), count(DISTINCT c) FROM smallbig

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT a.*) FROM kv a, kv b

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT g) FROM t111556_res

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT group_name) OVER (), count(DISTINCT product_name) OVER () FROM products

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT k), count(DISTINCT v), count(DISTINCT (v)) FROM kv

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT ts) FROM txn_timestamps;

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT w) FROM kv GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT x) FROM svals

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT(1)) FROM pg_attrdef

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT(1)) FROM pg_attribute

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT(1)) FROM pg_class

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT(1)) FROM pg_namespace

-- sqlfmt-corpus-separator --

SELECT count(DISTINCT(1)) FROM pg_tables

-- sqlfmt-corpus-separator --

SELECT count(a) OVER (ROWS 1 PRECEDING) FROM t

-- sqlfmt-corpus-separator --

SELECT count(distinct a) FROM impure

-- sqlfmt-corpus-separator --

SELECT count(distinct(node_id)), count(*)  FROM crdb_internal.node_runtime_info

-- sqlfmt-corpus-separator --

SELECT count(w) OVER () FROM kv GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT covar_pop(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT covar_samp(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT distinct is_identity FROM information_schema.columns

-- sqlfmt-corpus-separator --

SELECT distinct(a) FROM t53922

-- sqlfmt-corpus-separator --

SELECT distinct(st_astext(geom)) FROM
( VALUES
  (st_snaptogrid('LINESTRING(0 0, 1 1, 2 2, 3 3, 4 4)'::geometry, 2, 1)),
  (st_snaptogrid('LINESTRING(0 0, 1 1, 2 2, 3 3, 4 4)'::geometry, 0, 0, 2, 1)),
  (st_snaptogrid('LINESTRING(0 0, 1 1, 2 2, 3 3, 4 4)'::geometry, 'POINT EMPTY'::geometry, 2, 1, 0, 0)),
  (st_snaptogrid('LINESTRING(0 0, 1 1, 2 2, 3 3, 4 4)'::geometry, 'POINT EMPTY'::geometry, 2, 1, 2, 1)),
  (st_snaptogrid('LINESTRING(0 0, 1 1, 2 2, 3 3, 4 4)'::geometry, 'POINT(0 0)'::geometry, 2, 1, 0, 0)),
  (st_snaptogrid('LINESTRING(0 0, 1 1, 2 2, 3 3, 4 4)'::geometry, 'POINT(0 0 4 5)'::geometry, 2, 1, 2, 1))
) AS t(geom)

-- sqlfmt-corpus-separator --

SELECT distinct(st_astext(geom)) FROM
( VALUES
  (st_snaptogrid('MULTIPOINT(0 0 0, 7 5 5, 6 6 7)'::geometry, 2)),
  (st_snaptogrid('MULTIPOINT(0 0 0, 7 5 5, 6 6 7)'::geometry, 2, 2)),
  (st_snaptogrid('MULTIPOINT(0 0 0, 7 5 5, 6 6 7)'::geometry, 0, 0, 2, 2)),
  (st_snaptogrid('MULTIPOINT(0 0 0, 7 5 5, 6 6 7)'::geometry, 'POINT EMPTY'::geometry, 2, 2, 0, 0)),
  (st_snaptogrid('MULTIPOINT(0 0 0, 7 5 5, 6 6 7)'::geometry, 'POINT(0 0)'::geometry, 2, 2, 0, 0)),
  (st_snaptogrid('MULTIPOINT(0 0 0, 7 5 5, 6 6 7)'::geometry, 'POINT(0 0 0 0)'::geometry, 2, 2, 0, 0)),
  (st_snaptogrid('MULTIPOINT(0 0 0, 7 5 5, 6 6 7)'::geometry, 'POINT(0 0 3 2)'::geometry, 2, 2, 0, 0))
) AS t(geom)

-- sqlfmt-corpus-separator --

SELECT final_variance(1.2, 1.2, 123) OVER (PARTITION BY k) FROM kv

-- sqlfmt-corpus-separator --

SELECT group_name, price, product_name, array_agg(product_name) OVER (PARTITION BY group_name ORDER BY price, group_id) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, price, sum(pricefloat) OVER (PARTITION BY group_name ORDER BY pricefloat DESC RANGE BETWEEN 50 FOLLOWING AND 300 FOLLOWING) FROM products ORDER BY group_name, price DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, price, sum(pricefloat) OVER (PARTITION BY group_name ORDER BY pricefloat RANGE BETWEEN 50 FOLLOWING AND 300 FOLLOWING) FROM products ORDER BY group_name, price, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, array_agg(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING) AS array_agg_price FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, avg(price) OVER (ORDER BY group_id GROUPS BETWEEN 1 PRECEDING AND 2 PRECEDING), avg(price) OVER (ORDER BY price GROUPS BETWEEN CURRENT ROW AND CURRENT ROW) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, avg(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING) AS running_avg FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, avg(price) OVER (PARTITION BY group_name ORDER BY price GROUPS BETWEEN CURRENT ROW AND 3 FOLLOWING), avg(price) OVER (ORDER BY price GROUPS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, avg(price) OVER (PARTITION BY group_name RANGE UNBOUNDED PRECEDING) AS avg_price FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, min(price) OVER (PARTITION BY group_name ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING) AS min_over_empty_frame FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, min(price) OVER (PARTITION BY group_name ROWS CURRENT ROW) AS min_over_single_row FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS 2 PRECEDING) AS running_sum FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (RANGE BETWEEN CURRENT ROW AND CURRENT ROW) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(price) OVER (RANGE CURRENT ROW) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(priceint) OVER (PARTITION BY group_name ORDER BY priceint DESC RANGE 200 PRECEDING) FROM products ORDER BY group_name, priceint DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(priceint) OVER (PARTITION BY group_name ORDER BY priceint DESC RANGE BETWEEN 300 PRECEDING AND 50 PRECEDING) FROM products ORDER BY group_name, priceint DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(priceint) OVER (PARTITION BY group_name ORDER BY priceint DESC RANGE BETWEEN 50 FOLLOWING AND 300 FOLLOWING) FROM products ORDER BY group_name, priceint DESC, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(priceint) OVER (PARTITION BY group_name ORDER BY priceint RANGE 200 PRECEDING) FROM products ORDER BY group_name, priceint, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(priceint) OVER (PARTITION BY group_name ORDER BY priceint RANGE BETWEEN 300 PRECEDING AND 50 PRECEDING) FROM products ORDER BY group_name, priceint, group_id

-- sqlfmt-corpus-separator --

SELECT group_name, product_name, price, sum(priceint) OVER (PARTITION BY group_name ORDER BY priceint RANGE BETWEEN 50 FOLLOWING AND 300 FOLLOWING) FROM products ORDER BY group_name, priceint, group_id

-- sqlfmt-corpus-separator --

SELECT i, avg(i) OVER (ORDER BY i) FROM kv ORDER BY i

-- sqlfmt-corpus-separator --

SELECT i.relname AS name,
       ix.indisprimary AS PRIMARY,
       ix.indisunique AS UNIQUE,
       ix.indkey AS indkey,
       array_agg(a.attnum ORDER BY a.attnum) AS column_indexes,
       array_agg(a.attname ORDER BY a.attnum) AS column_names,
       pg_get_indexdef(ix.indexrelid) AS definition
FROM pg_class t,
     pg_class i,
     pg_index ix,
     pg_attribute a
WHERE t.oid = ix.indrelid
AND   i.oid = ix.indexrelid
AND   a.attrelid = t.oid
AND   t.relkind = 'r'
AND   t.relname = 'customers' -- this query is run once for each table
GROUP BY i.relname,
         ix.indexrelid,
         ix.indisprimary,
         ix.indisunique,
         ix.indkey
ORDER BY i.relname

-- sqlfmt-corpus-separator --

SELECT index_rec, (
    SELECT array_agg(n ORDER BY n)
    FROM unnest(fingerprint_ids) AS n
  ) AS sorted_fp
FROM workload_index_recs('2023-07-05 15:10:10+00:00'::TIMESTAMPTZ - '2 weeks'::interval) order by index_rec;

-- sqlfmt-corpus-separator --

SELECT index_rec, (
    SELECT array_agg(n ORDER BY n)
    FROM unnest(fingerprint_ids) AS n
  ) AS sorted_fp
FROM workload_index_recs() order by index_rec;

-- sqlfmt-corpus-separator --

SELECT json_agg(col1 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT json_agg(v ORDER BY v) FROM t115054_1

-- sqlfmt-corpus-separator --

SELECT json_agg(v ORDER BY v) FROM t115054_2

-- sqlfmt-corpus-separator --

SELECT json_build_object(b.name, json_object_agg(p.property_name, p.property_value ORDER BY p.property_value))
FROM blog b, blog_properties p WHERE b.id = p.blog_id
GROUP BY b.name

-- sqlfmt-corpus-separator --

SELECT json_object_agg(s, s) OVER (ORDER BY s DESC) FROM t54604

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(a) OVER (ORDER BY a GROUPS BETWEEN 5 FOLLOWING AND UNBOUNDED FOLLOWING) FROM x

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(col1 ORDER BY col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT jsonb_agg(col1 ORDER BY col2, col1) FROM tab

-- sqlfmt-corpus-separator --

SELECT jsonb_object_agg(s, s) OVER (ORDER BY s RANGE UNBOUNDED PRECEDING) FROM t54604

-- sqlfmt-corpus-separator --

SELECT k FROM kv WHERE avg(k) OVER () > 1

-- sqlfmt-corpus-separator --

SELECT k, abs(k) FILTER (WHERE k=1) FROM kv

-- sqlfmt-corpus-separator --

SELECT k, bool_and(b) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, bool_or(b) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, concat_agg(s) OVER (PARTITION BY k ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, concat_agg(s) OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, count(*) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, count(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, cume_dist() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, dense_rank() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, first_value(1) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, first_value(199.9 * 23.3) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, first_value(NULL::INT) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, first_value(k) OVER (ORDER BY v GROUPS BETWEEN 0 PRECEDING AND 2 PRECEDING) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, first_value(v) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, first_value(v) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(9) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k) OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, -5) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, -5) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 0) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 0) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 1, 'FOO') OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 1, s) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 3) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 3) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 3, -99) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 3, -99) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 3, v) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, 3, v) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, NULL::INT) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, w - w) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, w) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lag(k, w) OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, last_value(1) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, last_value(199.9 * 23.3) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, last_value(NULL::INT) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, last_value(v) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, last_value(v) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(9) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k) OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, -5) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, -5) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 0) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 0) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 1, 'FOO') OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 1, s) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 3) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 3) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 3, -99) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 3, -99) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 3, v) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, 3, v) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, NULL::INT) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, w - w) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, w) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, lead(k, w) OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, max(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, max(d) OVER (PARTITION BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, max(stddev) OVER (ORDER BY d DESC) FROM (SELECT k, d, stddev(d) OVER (PARTITION BY v) as stddev FROM kv) sub ORDER BY 2, k

-- sqlfmt-corpus-separator --

SELECT k, max(stddev) OVER (ORDER BY d) FROM (SELECT k, d, stddev(d) OVER (PARTITION BY v) as stddev FROM kv) sub ORDER BY 2, k

-- sqlfmt-corpus-separator --

SELECT k, min(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(1, 3) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(1, 33) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(199.9 * 23.3, 7) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(NULL::INT, 5) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, 'FOO') OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, -99) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, 0) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, 1) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, 8) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, k) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, v) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, v) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, nth_value(v, v) OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(-10) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(0) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(1) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(1::INT4) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(20) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(4) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, ntile(NULL::INT) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, percent_rank() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, pow(max(d) OVER (PARTITION BY v), k::DECIMAL) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, rank() FILTER (WHERE k=1) OVER () FROM kv

-- sqlfmt-corpus-separator --

SELECT k, rank() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, row_number() OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, row_number() OVER (PARTITION BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, stddev(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, sum(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, cume_dist() OVER (PARTITION BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, dense_rank() OVER (PARTITION BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, ntile(3) OVER (PARTITION BY v ORDER BY k) FROM kv ORDER BY v, k

-- sqlfmt-corpus-separator --

SELECT k, v, ntile(3) OVER (PARTITION BY v, k) FROM kv ORDER BY v, k

-- sqlfmt-corpus-separator --

SELECT k, v, ntile(3::INT2) OVER (PARTITION BY v ORDER BY k) FROM kv ORDER BY v, k

-- sqlfmt-corpus-separator --

SELECT k, v, ntile(3::INT4) OVER (PARTITION BY v ORDER BY k) FROM kv ORDER BY v, k

-- sqlfmt-corpus-separator --

SELECT k, v, ntile(v) OVER (ORDER BY v, k)
FROM (SELECT * FROM kv WHERE w != 3) ORDER BY v, k

-- sqlfmt-corpus-separator --

SELECT k, v, ntile(v) OVER (ORDER BY v, k) FROM kv ORDER BY v, k

-- sqlfmt-corpus-separator --

SELECT k, v, percent_rank() OVER (PARTITION BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, rank() OVER (PARTITION BY v) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, row_number() OVER (PARTITION BY v ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, cume_dist() OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, dense_rank() OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, first_value(w) OVER (PARTITION BY v ORDER BY w DESC) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, first_value(w) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, last_value(w) OVER (PARTITION BY v ORDER BY w DESC) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, last_value(w) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, nth_value(w, 2) OVER (PARTITION BY v ORDER BY w DESC) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, nth_value(w, 2) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, ntile(6) OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY v, w, k

-- sqlfmt-corpus-separator --

SELECT k, v, w, ntile(6) OVER (PARTITION BY v, k ORDER BY w) FROM kv ORDER BY v, k, w

-- sqlfmt-corpus-separator --

SELECT k, v, w, ntile(v) OVER (PARTITION BY w ORDER BY v, k) FROM kv ORDER BY w, v, k

-- sqlfmt-corpus-separator --

SELECT k, v, w, percent_rank() OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, rank() OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, row_number() OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, v - w + 2 + row_number() OVER (PARTITION BY v ORDER BY w, k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, v, w, v - w + 2 + row_number() OVER (PARTITION BY v, k ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, variance(d) OVER (PARTITION BY v ORDER BY w) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, w, ntile(w) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT k, w, ntile(w) OVER (PARTITION BY k) FROM kv ORDER BY k

-- sqlfmt-corpus-separator --

SELECT k, w, ntile(w::INT4) OVER (ORDER BY k) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT lag(b, 0) OVER (ORDER BY b DESC) FROM t64793 ORDER BY b

-- sqlfmt-corpus-separator --

SELECT lead(x, 10, y::INT4) OVER () FROM (VALUES (1, 2)) v(x, y);

-- sqlfmt-corpus-separator --

SELECT left('💩abcde', 2)

-- sqlfmt-corpus-separator --

SELECT left('💩abcde'::bytes, 2)

-- sqlfmt-corpus-separator --

SELECT max(b::INT8) OVER (PARTITION BY b ORDER BY a RANGE 1 PRECEDING)
FROM t53442_b NATURAL JOIN t53442_a
WHERE false

-- sqlfmt-corpus-separator --

SELECT max(b::INT8) OVER (PARTITION BY b ORDER BY b RANGE 1 PRECEDING)
FROM t53442_b NATURAL JOIN t53442_a
WHERE false

-- sqlfmt-corpus-separator --

SELECT max(i) * (1/j) * (row_number() OVER (ORDER BY max(i))) FROM (SELECT 1 AS i, 2 AS j) GROUP BY j

-- sqlfmt-corpus-separator --

SELECT max(i) * (row_number() OVER (ORDER BY max(i))) FROM (SELECT 1 AS i, 2 AS j) GROUP BY j

-- sqlfmt-corpus-separator --

SELECT min(b) OVER () FROM t

-- sqlfmt-corpus-separator --

SELECT now() OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT nth_value(1, i) OVER (ORDER BY p()) FROM (VALUES (1), (2)) v(i)

-- sqlfmt-corpus-separator --

SELECT nth_value(1, p()) OVER () FROM (VALUES (1), (2))

-- sqlfmt-corpus-separator --

SELECT price, sum(price) OVER (ORDER BY price GROUPS UNBOUNDED PRECEDING), sum(price) OVER (ORDER BY price GROUPS 100 PRECEDING), sum(price) OVER (ORDER BY price GROUPS 1 PRECEDING), sum(price) OVER (ORDER BY group_name GROUPS CURRENT ROW) FROM products ORDER BY price, group_id

-- sqlfmt-corpus-separator --

SELECT product_name, array_agg(product_name) OVER (ORDER BY group_id) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT product_name, group_name, price, avg(price) OVER (PARTITION BY group_name ORDER BY price, product_name ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS avg_of_three FROM products ORDER BY group_name, price, product_name

-- sqlfmt-corpus-separator --

SELECT product_name, group_name, price, avg(priceFloat) OVER (PARTITION BY group_name ORDER BY price, product_name ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS avg_of_three_floats FROM products ORDER BY group_name, price, product_name

-- sqlfmt-corpus-separator --

SELECT product_name, group_name, price, avg(priceInt) OVER (PARTITION BY group_name ORDER BY price, product_name ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS avg_of_three_ints FROM products ORDER BY group_name, price, product_name

-- sqlfmt-corpus-separator --

SELECT product_name, price, min(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS min_over_three, max(price) OVER (PARTITION BY group_name ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_over_partition FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT product_name, price, min(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS UNBOUNDED PRECEDING), max(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING), sum(price) OVER (PARTITION BY group_name ORDER BY group_id ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING), avg(price) OVER (PARTITION BY group_name ROWS CURRENT ROW) FROM products ORDER BY group_id

-- sqlfmt-corpus-separator --

SELECT regr_avgx(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_avgy(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_count(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_count(DISTINCT y, x) FILTER (WHERE x > 3 AND y < 100)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_intercept(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_r2(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_slope(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_sxx(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_sxy(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT regr_syy(DISTINCT y, x)
FROM statistics_agg_test

-- sqlfmt-corpus-separator --

SELECT right('abcde💩', 2)

-- sqlfmt-corpus-separator --

SELECT right('abcde💩'::bytes, 2)

-- sqlfmt-corpus-separator --

SELECT round(avg(k) OVER ()) OVER () FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT round(avg(k) OVER (PARTITION BY v ORDER BY w)) FROM kv ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT st_asmvt(NULL, NULL), array_agg(a ORDER BY a) FROM mvt_null_test

-- sqlfmt-corpus-separator --

SELECT string_agg('foo', CAST ((SELECT NULL) AS BYTES)) OVER ();

-- sqlfmt-corpus-separator --

SELECT string_agg('foo', s) OVER () FROM (SELECT * FROM kv LIMIT 1)

-- sqlfmt-corpus-separator --

SELECT string_agg(col3, ', ' ORDER BY col3 DESC) FROM tab

-- sqlfmt-corpus-separator --

SELECT string_agg(col3, ', ' ORDER BY col3) FROM tab

-- sqlfmt-corpus-separator --

SELECT sum(DISTINCT a), sum_int(DISTINCT a) FROM data

-- sqlfmt-corpus-separator --

SELECT sum(DISTINCT a), sum_int(DISTINCT a), sum(DISTINCT b), sum_int(DISTINCT b) from data

-- sqlfmt-corpus-separator --

SELECT sum(a) OVER (ORDER BY count(a) OVER () + 1) FROM x

-- sqlfmt-corpus-separator --

SELECT sum(a) OVER (ORDER BY count(a) OVER ()) FROM x

-- sqlfmt-corpus-separator --

SELECT sum(a) OVER (PARTITION BY count(a) OVER () + 1) FROM x

-- sqlfmt-corpus-separator --

SELECT sum(a) OVER (PARTITION BY count(a) OVER ()) FROM x

-- sqlfmt-corpus-separator --

SELECT sum(a), avg(DISTINCT a), variance(a) FILTER (WHERE a > 0) FROM data

-- sqlfmt-corpus-separator --

SELECT sum(a), stddev(a), stddev_pop(a), avg(a) FILTER (WHERE a > 5), count(b), avg(b), variance(b), var_pop(b) FILTER (WHERE b < 8), sum(b) FILTER (WHERE b < 8), stddev(b) FILTER (WHERE b > 2) FROM data

-- sqlfmt-corpus-separator --

SELECT sum(a+b), sum(a+b) FILTER (WHERE a < d), sum_int(a+b) FILTER (WHERE a < d), sum(a+b) FILTER (WHERE a = c) FROM data GROUP BY d

-- sqlfmt-corpus-separator --

SELECT sum(a+b), sum(a+b) FILTER (WHERE a < d), sum_int(a+b) FILTER (WHERE a < d), sum(a+b) FILTER (WHERE a = c) FROM data WHERE a = 1 GROUP BY d

-- sqlfmt-corpus-separator --

SELECT sum(price) OVER (ORDER BY price, priceint RANGE 100 PRECEDING) FROM products

-- sqlfmt-corpus-separator --

SELECT sum(price) OVER (ORDER BY ptimestamptz RANGE BETWEEN 123 PRECEDING AND CURRENT ROW) FROM products

-- sqlfmt-corpus-separator --

SELECT sum(price) OVER (RANGE 100 PRECEDING) FROM products

-- sqlfmt-corpus-separator --

SELECT sum(v) FROM kv GROUP BY k LIMIT sum(v) OVER ()

-- sqlfmt-corpus-separator --

SELECT t.typname enum_name, array_agg(e.enumlabel ORDER BY enumsortorder) enum_value
    FROM pg_type t
    JOIN pg_enum e ON t.oid = e.enumtypid
    JOIN pg_catalog.pg_namespace n ON n.oid = t.typnamespace
    WHERE n.nspname = 'public'
    GROUP BY 1

-- sqlfmt-corpus-separator --

SELECT upper(s), count(DISTINCT k), count(DISTINCT v), count(DISTINCT (v)) FROM kv GROUP BY upper(s)

-- sqlfmt-corpus-separator --

SELECT upper(s), count(DISTINCT s), count(DISTINCT upper(s)) FROM kv GROUP BY upper(s) HAVING count(DISTINCT s) > 1

-- sqlfmt-corpus-separator --

SELECT v, count(*) FILTER (WHERE count(*) > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, count(*) FILTER (WHERE k > 5) FROM filter_test GROUP BY v

-- sqlfmt-corpus-separator --

SELECT v, mark, count(*) FILTER (WHERE k > 5), count(*), max(k) FILTER (WHERE k < 8) FROM filter_test GROUP BY v, mark

-- sqlfmt-corpus-separator --

SELECT var_pop(v::INT8) OVER ()
FROM t91817b
GROUP BY k, v
HAVING every(true)

-- sqlfmt-corpus-separator --

SELECT x,
       sqrdiff(x) OVER (ORDER BY x) as sqrdiff,
       var_pop(x) OVER (ORDER BY x) as var_pop,
       var_samp(x) OVER (ORDER BY x) as var_samp,
       stddev_pop(x) OVER (ORDER BY x) as stddev_pop,
       stddev_samp(x) OVER (ORDER BY x) as stddev_samp
FROM t55944
ORDER BY x

-- sqlfmt-corpus-separator --

SELECT x, jsonb_agg(DISTINCT jsonb_build_object('y', y, 'z', z)) FROM (SELECT * FROM t ORDER BY i) GROUP BY x

-- sqlfmt-corpus-separator --

SELECT x, y, first_value(y) OVER (PARTITION BY x ROWS BETWEEN CURRENT ROW AND CURRENT ROW) FROM t;