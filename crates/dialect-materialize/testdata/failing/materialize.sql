ALTER ROLE password_removal_test PASSWORD NULL

-- sqlfmt-corpus-separator --

CREATE ROLE password_removal_test WITH LOGIN PASSWORD 'initial_password789'

-- sqlfmt-corpus-separator --

CREATE ROLE role_with_password WITH LOGIN PASSWORD 'secure_password123'

-- sqlfmt-corpus-separator --

CREATE ROLE test_user WITH LOGIN PASSWORD 'secure_password456'

-- sqlfmt-corpus-separator --

SELECT id, normalize(text) FROM test_normalize ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, normalize(text, NFKC) FROM test_normalize ORDER BY id

-- sqlfmt-corpus-separator --

SELECT length(normalize('한글', NFC))

-- sqlfmt-corpus-separator --

SELECT length(normalize('한글', NFD))

-- sqlfmt-corpus-separator --

SELECT normalize('')

-- sqlfmt-corpus-separator --

SELECT normalize('', NFKC)

-- sqlfmt-corpus-separator --

SELECT normalize('hello world')

-- sqlfmt-corpus-separator --

SELECT normalize('hello world', NFD)

-- sqlfmt-corpus-separator --

SELECT normalize('x²', NFC)

-- sqlfmt-corpus-separator --

SELECT normalize('x²', NFKC)

-- sqlfmt-corpus-separator --

SELECT normalize('Å')

-- sqlfmt-corpus-separator --

SELECT normalize('Å', NFD) = E'A\u030A'

-- sqlfmt-corpus-separator --

SELECT normalize('é')

-- sqlfmt-corpus-separator --

SELECT normalize('é', NFC)

-- sqlfmt-corpus-separator --

SELECT normalize('é', NFD) = E'e\u0301'

-- sqlfmt-corpus-separator --

SELECT normalize('é', Nfd) = E'e\u0301'

-- sqlfmt-corpus-separator --

SELECT normalize('é', nfc)

-- sqlfmt-corpus-separator --

SELECT normalize('Ⅻ', NFC)  -- Roman numeral XII (U+216B)

-- sqlfmt-corpus-separator --

SELECT normalize('Ⅻ', NFKC)

-- sqlfmt-corpus-separator --

SELECT normalize('한글', NFC)

-- sqlfmt-corpus-separator --

SELECT normalize('한글', NFC) = normalize('한글', NFD)

-- sqlfmt-corpus-separator --

SELECT normalize('ﬀ', NFKC)

-- sqlfmt-corpus-separator --

SELECT normalize('ﬁ', NFKC)

-- sqlfmt-corpus-separator --

SELECT normalize('ﬁ', NFKD)

-- sqlfmt-corpus-separator --

SELECT normalize('Ａ', NFC)  -- Full-width A (U+FF21)

-- sqlfmt-corpus-separator --

SELECT normalize('Ａ', NFKC)  -- Should become regular A

-- sqlfmt-corpus-separator --

SELECT normalize(NULL)

-- sqlfmt-corpus-separator --

SELECT normalize(NULL, NFC)