INSERT
INTO
    regional_by_row_table_as4
SELECT
    g, g
FROM
    ROWS FROM (generate_series(1, 1000)) AS g (g)

-- sqlfmt-corpus-separator --

INSERT INTO kv (k.*) VALUES ('hello')

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

SELECT * FROM c WHERE (NULL::text NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id)) IS NOT NULL;

-- sqlfmt-corpus-separator --

SELECT c_id, (NULL::text NOT IN (SELECT ship FROM o WHERE o.c_id=c.c_id)) IS NOT NULL
FROM c
ORDER BY c_id;

-- sqlfmt-corpus-separator --

SELECT crdb_internal.range_stats(k)
  FROM (
          SELECT *
            FROM (
                     SELECT start_key AS k, random() AS r FROM crdb_internal.ranges_no_leases
                     UNION ALL SELECT NULL, random() FROM ROWS FROM (generate_series(1, 100))
                 )
        ORDER BY r DESC
       );

-- sqlfmt-corpus-separator --

SELECT i, random() FROM ROWS FROM (generate_series(1, 5)) AS i ORDER by i

-- sqlfmt-corpus-separator --

UPDATE kv SET k.* = 9

-- sqlfmt-corpus-separator --

WITH
  a AS (SELECT crdb_internal.create_session_revival_token() AS token),
  b AS (
    SELECT
      crdb_internal.pb_to_json(
        'cockroach.sql.sessiondatapb.SessionRevivalToken',
        a.token
      ) AS json_token
    FROM a
  ),
  c AS (
    SELECT
      (json_populate_record(
        NULL::token_payload,
        crdb_internal.pb_to_json(
          'cockroach.sql.sessiondatapb.SessionRevivalToken.Payload',
          decode(b.json_token->>'payload', 'base64'),
          true
        )
      )).*
    FROM b
  )
SELECT
  algorithm,
  "user",
  "expiresAt" > now(),
  "expiresAt" < (now() + INTERVAL '11 minutes'),
  "expiresAt" > "issuedAt",
  crdb_internal.validate_session_revival_token(a.token)
FROM
  c, a