SELECT 'abc'::char(3) !~~* 'Abc'::char(4);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) ~~ 'abc ';

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) ~~ 'abc'::char(4);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(3) ~~ 'abc';

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(4) ~~ 'abc ';

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(4) ~~ 'abc'::char(3);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(4) ~~ 'abc'::char(4);

-- sqlfmt-corpus-separator --

SELECT 'abc'::char(4) ~~ 'abc';

-- sqlfmt-corpus-separator --

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

with table_privileges as (
 select
   NULL as role,
   t.schemaname as schema,
   t.objectname as table,
   pg_catalog.has_table_privilege(current_user, '"' || t.schemaname || '"' || '.' || '"' || t.objectname || '"',  'UPDATE') as update,
   pg_catalog.has_table_privilege(current_user, '"' || t.schemaname || '"' || '.' || '"' || t.objectname || '"',  'SELECT') as select,
   pg_catalog.has_table_privilege(current_user, '"' || t.schemaname || '"' || '.' || '"' || t.objectname || '"',  'INSERT') as insert,
   pg_catalog.has_table_privilege(current_user, '"' || t.schemaname || '"' || '.' || '"' || t.objectname || '"',  'DELETE') as delete
 from (
   select schemaname, tablename as objectname from pg_catalog.pg_tables
   union
   select schemaname, viewname as objectname from pg_catalog.pg_views
   union
   select schemaname, matviewname as objectname from pg_catalog.pg_matviews
 ) t
 where t.schemaname !~ '^pg_'
   and t.schemaname <> 'information_schema'
   and pg_catalog.has_schema_privilege(current_user, t.schemaname, 'USAGE')
)
select t.*
from table_privileges t