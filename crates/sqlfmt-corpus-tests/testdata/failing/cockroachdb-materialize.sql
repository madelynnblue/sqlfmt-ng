CREATE TABLE assn_cast (
  c CHAR,
  vc VARCHAR(1),
  qc "char",
  b BIT,
  i INT,
  i2 INT2,
  f4 FLOAT4,
  t timestamp,
  d DECIMAL(10, 0),
  a DECIMAL(10, 0)[],
  s STRING,
  ca CHAR[],
  vba VARBIT(1)[]
)

-- sqlfmt-corpus-separator --

CREATE TABLE assn_cast_char_default (
  c CHAR DEFAULT 'foo'::TEXT,
  c2 CHAR(2) DEFAULT 'bar',
  qc "char" DEFAULT 'baz'
)

-- sqlfmt-corpus-separator --

CREATE TABLE assn_cast_upsert (
  k INT PRIMARY KEY,
  c CHAR,
  qc "char",
  i2 INT2,
  d DECIMAL(10, 0),
  a DECIMAL(10, 0)[]
)

-- sqlfmt-corpus-separator --

CREATE TABLE t65631(a "char", b "char" COLLATE en)

-- sqlfmt-corpus-separator --

SELECT
  COALESCE(g.rolname, 'PUBLIC') AS grantor,
  COALESCE(e.rolname, 'PUBLIC') AS grantee,
  a.privilege_type,
  a.is_grantable
FROM aclexplode(acldefault('d'::"char", 'root'::regrole)) a
LEFT JOIN pg_roles g ON g.oid = a.grantor
LEFT JOIN pg_roles e ON e.oid = a.grantee
ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT
  COALESCE(g.rolname, 'PUBLIC') AS grantor,
  COALESCE(e.rolname, 'PUBLIC') AS grantee,
  a.privilege_type,
  a.is_grantable
FROM aclexplode(acldefault('l'::"char", 'root'::regrole)) a
LEFT JOIN pg_roles g ON g.oid = a.grantor
LEFT JOIN pg_roles e ON e.oid = a.grantee
ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT
  COALESCE(g.rolname, 'PUBLIC') AS grantor,
  COALESCE(e.rolname, 'PUBLIC') AS grantee,
  a.privilege_type,
  a.is_grantable
FROM aclexplode(acldefault('p'::"char", 'root'::regrole)) a
LEFT JOIN pg_roles g ON g.oid = a.grantor
LEFT JOIN pg_roles e ON e.oid = a.grantee
ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT
  COALESCE(g.rolname, 'PUBLIC') AS grantor,
  COALESCE(e.rolname, 'PUBLIC') AS grantee,
  a.privilege_type,
  a.is_grantable
FROM aclexplode(acldefault('r'::"char", 'root'::regrole)) a
LEFT JOIN pg_roles g ON g.oid = a.grantor
LEFT JOIN pg_roles e ON e.oid = a.grantee
ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT 'a'::"char" FROM t47131_0

-- sqlfmt-corpus-separator --

SELECT (-129)::"char";

-- sqlfmt-corpus-separator --

SELECT 128::"char";

-- sqlfmt-corpus-separator --

SELECT acldefault('T'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('Z'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('c'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('d'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('f'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('l'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('n'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('p'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT acldefault('r'::"char", 'root'::regrole)

-- sqlfmt-corpus-separator --

SELECT i, i::"char"::bytea, length(i::"char")
FROM (VALUES (32), (97), (127), (0), (-1), (-127), (-128)) v(i);