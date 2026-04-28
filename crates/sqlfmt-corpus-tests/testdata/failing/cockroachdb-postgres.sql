SELECT (1, 2) = ANY(SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT (1, 2) = SOME(SELECT 1, 2)

-- sqlfmt-corpus-separator --

SELECT * FROM abc WHERE a = ANY(SELECT a FROM abc WHERE b = 10)

-- sqlfmt-corpus-separator --

SELECT * FROM c WHERE bill = ANY(SELECT ship FROM o);

-- sqlfmt-corpus-separator --

SELECT 1 = ANY(SELECT 1)

-- sqlfmt-corpus-separator --

SELECT 1 = SOME(SELECT 1)

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