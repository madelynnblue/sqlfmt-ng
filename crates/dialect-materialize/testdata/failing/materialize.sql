(WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 10)
    t (n int) AS (
        VALUES (1)
        UNION ALL
        SELECT n+1 FROM t
    )
SELECT sum(n) FROM t)
UNION ALL
(WITH MUTUALLY RECURSIVE (ERROR AT RECURSION LIMIT 100)
    t (n int) AS (
        VALUES (1)
        UNION ALL
        SELECT n+1 FROM t
    )
SELECT sum(n) FROM t);

-- sqlfmt-corpus-separator --

(WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 3)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT -10, i FROM cnt)
UNION
(WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 5)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT -20, i FROM cnt)

-- sqlfmt-corpus-separator --

ALTER CLUSTER IF EXISTS bar RENAME TO foo

-- sqlfmt-corpus-separator --

ALTER CLUSTER IF EXISTS nonexistent SWAP WITH bar;

-- sqlfmt-corpus-separator --

ALTER CLUSTER IF EXISTS swap_test_a SWAP WITH swap_test_b;

-- sqlfmt-corpus-separator --

ALTER CLUSTER REPLICA IF EXISTS quickstart.bar_foo RENAME TO foo_bar

-- sqlfmt-corpus-separator --

ALTER CLUSTER REPLICA foo.r RENAME TO s;

-- sqlfmt-corpus-separator --

ALTER CLUSTER REPLICA foo.r2 RENAME TO bar

-- sqlfmt-corpus-separator --

ALTER CLUSTER REPLICA foo.weewoo1 RENAME TO weewoo2;

-- sqlfmt-corpus-separator --

ALTER CLUSTER REPLICA jclus.jr2 OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER CLUSTER REPLICA jclus.jr2 RENAME TO jr3

-- sqlfmt-corpus-separator --

ALTER CLUSTER REPLICA materialize_public_s.linked OWNER TO joe

-- sqlfmt-corpus-separator --

ALTER CLUSTER REPLICA mclus.mr2 OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER CLUSTER REPLICA mclus.mr2 OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER CLUSTER REPLICA mclus.mr2 RENAME TO mr3

-- sqlfmt-corpus-separator --

ALTER CLUSTER REPLICA quickstart.bar_foo RENAME TO foo_bar

-- sqlfmt-corpus-separator --

ALTER CLUSTER REPLICA quickstart.foo_bar RENAME TO bar_foo

-- sqlfmt-corpus-separator --

ALTER CLUSTER bar SWAP WITH foo;

-- sqlfmt-corpus-separator --

ALTER CLUSTER baz RESET (AVAILABILITY ZONES)

-- sqlfmt-corpus-separator --

ALTER CLUSTER baz RESET (INTROSPECTION DEBUGGING)

-- sqlfmt-corpus-separator --

ALTER CLUSTER baz RESET (INTROSPECTION INTERVAL)

-- sqlfmt-corpus-separator --

ALTER CLUSTER baz RESET (REPLICAS)

-- sqlfmt-corpus-separator --

ALTER CLUSTER baz RESET (REPLICATION FACTOR)

-- sqlfmt-corpus-separator --

ALTER CLUSTER baz RESET (SIZE)

-- sqlfmt-corpus-separator --

ALTER CLUSTER baz SET (MANAGED)

-- sqlfmt-corpus-separator --

ALTER CLUSTER baz SET (MANAGED, SIZE 'scale=1,workers=1')

-- sqlfmt-corpus-separator --

ALTER CLUSTER baz SET (REPLICATION FACTOR 2)

-- sqlfmt-corpus-separator --

ALTER CLUSTER baz SET (SIZE 'scale=1,workers=2')

-- sqlfmt-corpus-separator --

ALTER CLUSTER blue_green_dbt_deploy SWAP WITH blue_green;

-- sqlfmt-corpus-separator --

ALTER CLUSTER c SET (REPLICATION FACTOR 0);

-- sqlfmt-corpus-separator --

ALTER CLUSTER c SET (REPLICATION FACTOR 1)

-- sqlfmt-corpus-separator --

ALTER CLUSTER c SET (REPLICATION FACTOR 1);

-- sqlfmt-corpus-separator --

ALTER CLUSTER c SET (REPLICATION FACTOR 2)

-- sqlfmt-corpus-separator --

ALTER CLUSTER c1 RESET (WORKLOAD CLASS)

-- sqlfmt-corpus-separator --

ALTER CLUSTER c1 SET (SIZE = 'scale=1,workers=2');

-- sqlfmt-corpus-separator --

ALTER CLUSTER c1 SET (WORKLOAD CLASS 'qa')

-- sqlfmt-corpus-separator --

ALTER CLUSTER c1 SET (WORKLOAD CLASS NULL)

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_1 RESET (INTROSPECTION DEBUGGING);

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_1 RESET (SCHEDULE);

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_1 SET (INTROSPECTION DEBUGGING = TRUE);

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_1 SET (MANAGED = false);

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_1 SET (MANAGED = false, SCHEDULE = MANUAL);

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_1 SET (MANAGED = false, SCHEDULE = ON REFRESH);

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_1 SET (MANAGED = true, SIZE = 'scale=1,workers=1');

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_1 SET (REPLICATION FACTOR = 1, SCHEDULE = ON REFRESH);

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_1 SET (SCHEDULE = MANUAL);

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_1 SET (SCHEDULE = ON REFRESH (HYDRATION TIME ESTIMATE = '0 seconds'));

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_1 SET (SCHEDULE = ON REFRESH);

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_3 SET (REPLICATION FACTOR = 1);

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_4 RESET (SCHEDULE);

-- sqlfmt-corpus-separator --

ALTER CLUSTER c_schedule_4 SET (REPLICATION FACTOR = 0);

-- sqlfmt-corpus-separator --

ALTER CLUSTER distinct_arrangements SET (MANAGED = false);

-- sqlfmt-corpus-separator --

ALTER CLUSTER distinct_arrangements SET (MANAGED = true)

-- sqlfmt-corpus-separator --

ALTER CLUSTER distinct_arrangements SET (REPLICATION FACTOR = 0)

-- sqlfmt-corpus-separator --

ALTER CLUSTER distinct_arrangements SET (REPLICATION FACTOR = 1)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo RENAME TO bar

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo RENAME TO bar;

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo RESET (AVAILABILITY ZONES)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo RESET (INTROSPECTION DEBUGGING)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo RESET (INTROSPECTION INTERVAL)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo RESET (MANAGED)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo RESET (REPLICATION FACTOR)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo RESET (SIZE)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (MANAGED = false)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (MANAGED)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (MANAGED, REPLICATION FACTOR 1)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (MANAGED, REPLICATION FACTOR 2)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (MANAGED, REPLICATION FACTOR 4)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (MANAGED, SIZE 'scale=1,workers=1')

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (MANAGED, SIZE 'scale=1,workers=2')

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (MANAGED, SIZE abc)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (REPLICATION FACTOR 0)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (REPLICATION FACTOR 1)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (REPLICATION FACTOR 2)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (SIZE 'scale=1,workers=1', REPLICATION FACTOR 1)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (SIZE 'scale=1,workers=2')

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SET (SIZE invalid_size)

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo SWAP WITH bar;

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo set (SIZE 'scale=1,workers=2') WITH (WAIT FOR '0s')

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo set (SIZE 'scale=1,workers=4') WITH (WAIT UNTIL READY (TIMEOUT '0s', ON TIMEOUT 'COMMIT') )

-- sqlfmt-corpus-separator --

ALTER CLUSTER foo set (SIZE 'scale=1,workers=4') WITH (WAIT UNTIL READY (TIMEOUT '10ms', ON TIMEOUT 'ROLLBACK') )

-- sqlfmt-corpus-separator --

ALTER CLUSTER green_compute RENAME TO blue_compute;

-- sqlfmt-corpus-separator --

ALTER CLUSTER jclus OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER CLUSTER jclus RENAME TO jclus2

-- sqlfmt-corpus-separator --

ALTER CLUSTER materialize_public_s OWNER TO joe

-- sqlfmt-corpus-separator --

ALTER CLUSTER mclus OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER CLUSTER mclus OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER CLUSTER mz_catalog_server RENAME TO foo

-- sqlfmt-corpus-separator --

ALTER CLUSTER mz_catalog_server SET (REPLICATION FACTOR 2);

-- sqlfmt-corpus-separator --

ALTER CLUSTER mz_system SET (MANAGED = false)

-- sqlfmt-corpus-separator --

ALTER CLUSTER mz_system SET (REPLICATION FACTOR 1)

-- sqlfmt-corpus-separator --

ALTER CLUSTER t1 SET (MANAGED false);

-- sqlfmt-corpus-separator --

ALTER CLUSTER t1 SET (MANAGED);

-- sqlfmt-corpus-separator --

ALTER CONNECTION c RENAME TO d;

-- sqlfmt-corpus-separator --

ALTER CONNECTION conn ROTATE KEYS

-- sqlfmt-corpus-separator --

ALTER CONNECTION jc OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER CONNECTION jc RENAME TO cool

-- sqlfmt-corpus-separator --

ALTER CONNECTION jssh ROTATE KEYS

-- sqlfmt-corpus-separator --

ALTER CONNECTION mc OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER CONNECTION mc OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER CONNECTION mc RENAME TO ICs

-- sqlfmt-corpus-separator --

ALTER CONNECTION mssh ROTATE KEYS

-- sqlfmt-corpus-separator --

ALTER CONNECTION rectype_sneaky RENAME TO rectype

-- sqlfmt-corpus-separator --

ALTER DATABASE jdb OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER DATABASE mdb OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER DATABASE mdb OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES GRANT INSERT ON TABLES TO r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ALL ROLES REVOKE INSERT ON TABLES FROM r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE PUBLIC GRANT CREATE ON CLUSTERS TO materialize

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE PUBLIC REVOKE CREATE ON CLUSTERS FROM materialize

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT ALL ON CLUSTERS TO r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT ALL ON DATABASES TO r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT ALL ON SCHEMAS TO r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT ALL PRIVILEGES ON CONNECTIONS TO r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT ALL PRIVILEGES ON SECRETS TO r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT ALL PRIVILEGES ON TABLES TO r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT ALL PRIVILEGES ON TYPES TO r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT CREATE ON CLUSTERS TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT CREATE ON CLUSTERS TO r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT CREATE ON DATABASES TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT CREATE ON DATABASES TO r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT CREATE ON SCHEMAS TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT CREATE ON SCHEMAS TO r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT DELETE ON CLUSTERS TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT INSERT ON TABLES TO mz_system

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT INSERT ON TABLES TO r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT INSERT ON TYPES TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT SELECT ON TABLES TO r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT SELECT ON TABLES TO r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT SELECT, INSERT ON TABLES TO r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT UPDATE ON TABLES TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT USAGE ON CLUSTERS TO r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT USAGE ON CONNECTIONS TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT USAGE ON CONNECTIONS TO r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT USAGE ON CONNECTIONS TO r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT USAGE ON DATABASES TO r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT USAGE ON SCHEMAS TO r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT USAGE ON SECRETS TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT USAGE ON SECRETS TO r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT USAGE ON TYPES TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize GRANT USAGE ON TYPES TO r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE d GRANT SELECT ON TABLES TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE d GRANT UPDATE ON TABLES TO r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE d1, d2 GRANT CREATE ON SCHEMAS TO r4

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE d1, d2 GRANT INSERT ON TABLES TO r4

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE d1, d2 GRANT USAGE ON CONNECTIONS TO r4

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE d1, d2 GRANT USAGE ON SECRETS TO r4

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE d1, d2 GRANT USAGE ON TYPES TO r4

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE d1, d2 REVOKE CREATE ON SCHEMAS FROM r4

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE d1, d2 REVOKE INSERT ON TABLES FROM r4

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE d1, d2 REVOKE USAGE ON CONNECTIONS FROM r4

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE d1, d2 REVOKE USAGE ON SECRETS FROM r4

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE d1, d2 REVOKE USAGE ON TYPES FROM r4

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE materialize GRANT USAGE ON CLUSTERS TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN DATABASE materialize GRANT USAGE ON DATABASES TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA d1.s1, d2.s2 GRANT DELETE ON TABLES TO r5

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA d1.s1, d2.s2 GRANT USAGE ON CONNECTIONS TO r5

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA d1.s1, d2.s2 GRANT USAGE ON SECRETS TO r5

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA d1.s1, d2.s2 GRANT USAGE ON TYPES TO r5

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA d1.s1, d2.s2 REVOKE DELETE ON TABLES FROM r5

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA d1.s1, d2.s2 REVOKE USAGE ON CONNECTIONS FROM r5

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA d1.s1, d2.s2 REVOKE USAGE ON SECRETS FROM r5

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA d1.s1, d2.s2 REVOKE USAGE ON TYPES FROM r5

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA mz_catalog GRANT INSERT ON TABLES TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA public GRANT USAGE ON CLUSTERS TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA public GRANT USAGE ON DATABASES TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA public GRANT USAGE ON SCHEMAS TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA s GRANT SELECT ON TABLES TO PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA s GRANT USAGE ON CONNECTIONS TO r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize IN SCHEMA s GRANT USAGE ON SECRETS TO r5

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE ALL ON CLUSTERS FROM r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE ALL ON DATABASES FROM r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE ALL ON SCHEMAS FROM r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE ALL ON TABLES FROM r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE ALL PRIVILEGES ON CONNECTIONS FROM r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE ALL PRIVILEGES ON SECRETS FROM r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE ALL PRIVILEGES ON TABLES FROM r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE ALL PRIVILEGES ON TYPES FROM r3

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE CREATE ON CLUSTERS FROM PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE CREATE ON CLUSTERS FROM r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE CREATE ON DATABASES FROM PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE CREATE ON DATABASES FROM r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE CREATE ON SCHEMAS FROM PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE CREATE ON SCHEMAS FROM r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE INSERT ON TABLES FROM r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE SELECT ON TABLES FROM r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE UPDATE ON TABLES FROM PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE USAGE ON CLUSTERS FROM mz_support

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE USAGE ON CLUSTERS FROM r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE USAGE ON CONNECTIONS FROM PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE USAGE ON CONNECTIONS FROM r1

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE USAGE ON CONNECTIONS FROM r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE USAGE ON DATABASES FROM r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE USAGE ON SCHEMAS FROM r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE USAGE ON SECRETS FROM PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE USAGE ON SECRETS FROM r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE USAGE ON TYPES FROM PUBLIC

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE materialize REVOKE USAGE ON TYPES FROM r1, r2

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r1 GRANT SELECT ON TABLES TO materialize

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r1 REVOKE SELECT ON TABLES FROM materialize

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r11 IN SCHEMA d1.s1, d2.s2 GRANT DELETE ON TABLES TO r12

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r11 IN SCHEMA d1.s1, d2.s2 GRANT USAGE ON CONNECTIONS TO r12

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r11 IN SCHEMA d1.s1, d2.s2 GRANT USAGE ON SECRETS TO r12

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r11 IN SCHEMA d1.s1, d2.s2 GRANT USAGE ON TYPES TO r12

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r11 IN SCHEMA d1.s1, d2.s2 REVOKE DELETE ON TABLES FROM r12

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r11 IN SCHEMA d1.s1, d2.s2 REVOKE USAGE ON CONNECTIONS FROM r12

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r11 IN SCHEMA d1.s1, d2.s2 REVOKE USAGE ON SECRETS FROM r12

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r11 IN SCHEMA d1.s1, d2.s2 REVOKE USAGE ON TYPES FROM r12

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 GRANT CREATE ON CLUSTERS TO r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 GRANT CREATE ON DATABASES TO r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 GRANT CREATE ON SCHEMAS TO r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 GRANT SELECT ON TABLES TO r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 GRANT USAGE ON CONNECTIONS TO r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 GRANT USAGE ON SECRETS TO r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 GRANT USAGE ON TYPES TO r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 REVOKE CREATE ON CLUSTERS FROM r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 REVOKE CREATE ON DATABASES FROM r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 REVOKE CREATE ON SCHEMAS FROM r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 REVOKE SELECT ON TABLES FROM r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 REVOKE USAGE ON CONNECTIONS FROM r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 REVOKE USAGE ON SECRETS FROM r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r6, r7 REVOKE USAGE ON TYPES FROM r8

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r9 IN DATABASE d1, d2 GRANT CREATE ON SCHEMAS TO r10

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r9 IN DATABASE d1, d2 GRANT INSERT ON TABLES TO r10

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r9 IN DATABASE d1, d2 GRANT USAGE ON CONNECTIONS TO r10

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r9 IN DATABASE d1, d2 GRANT USAGE ON SECRETS TO r10

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r9 IN DATABASE d1, d2 GRANT USAGE ON TYPES TO r10

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r9 IN DATABASE d1, d2 REVOKE CREATE ON SCHEMAS FROM r10

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r9 IN DATABASE d1, d2 REVOKE INSERT ON TABLES FROM r10

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r9 IN DATABASE d1, d2 REVOKE USAGE ON CONNECTIONS FROM r10

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r9 IN DATABASE d1, d2 REVOKE USAGE ON SECRETS FROM r10

-- sqlfmt-corpus-separator --

ALTER DEFAULT PRIVILEGES FOR ROLE r9 IN DATABASE d1, d2 REVOKE USAGE ON TYPES FROM r10

-- sqlfmt-corpus-separator --

ALTER INDEX accounts_balance_idx RENAME TO accounts_balance_index;

-- sqlfmt-corpus-separator --

ALTER INDEX i RESET (RETAIN HISTORY)

-- sqlfmt-corpus-separator --

ALTER INDEX i SET (RETAIN HISTORY = FOR '1000 hours')

-- sqlfmt-corpus-separator --

ALTER INDEX i SET (RETAIN HISTORY FOR '1m')

-- sqlfmt-corpus-separator --

ALTER INDEX idx_a SET (RETAIN HISTORY FOR '5m')

-- sqlfmt-corpus-separator --

ALTER INDEX idx_a SET (RETAIN HISTORY FOR '7m')

-- sqlfmt-corpus-separator --

ALTER INDEX idx_alter_plans RESET (RETAIN HISTORY)

-- sqlfmt-corpus-separator --

ALTER INDEX idx_alter_plans SET (RETAIN HISTORY FOR '1m')

-- sqlfmt-corpus-separator --

ALTER INDEX idx_b RESET (RETAIN HISTORY)

-- sqlfmt-corpus-separator --

ALTER INDEX idx_b SET (RETAIN HISTORY FOR '3m')

-- sqlfmt-corpus-separator --

ALTER INDEX idx_b SET (RETAIN HISTORY FOR '6m')

-- sqlfmt-corpus-separator --

ALTER INDEX idx_c RESET (RETAIN HISTORY)

-- sqlfmt-corpus-separator --

ALTER INDEX idx_c SET (RETAIN HISTORY FOR '1m')

-- sqlfmt-corpus-separator --

ALTER INDEX idx_c SET (RETAIN HISTORY FOR '4m')

-- sqlfmt-corpus-separator --

ALTER INDEX idx_owner_plans OWNER TO plan_owner_other

-- sqlfmt-corpus-separator --

ALTER INDEX idx_rename_metainfo RENAME TO idx_rename_metainfo_renamed

-- sqlfmt-corpus-separator --

ALTER INDEX jt_ind OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER INDEX jt_ind RENAME TO cool

-- sqlfmt-corpus-separator --

ALTER INDEX jt_ind SET (RETAIN HISTORY = FOR '1000 hours')

-- sqlfmt-corpus-separator --

ALTER INDEX mt_ind OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER INDEX mt_ind OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER INDEX mt_ind RENAME TO ICs

-- sqlfmt-corpus-separator --

ALTER INDEX mt_ind SET (RETAIN HISTORY = FOR '1000 hours')

-- sqlfmt-corpus-separator --

ALTER INDEX rectype_sneaky_i RENAME TO rectype

-- sqlfmt-corpus-separator --

ALTER INDEX s_primary_idx SET (RETAIN HISTORY = FOR '1000 hours')

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW does_not_exist SET CLUSTER quickstart

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW green_mv1 RENAME TO blue_mv1;

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW jmv OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW jmv RENAME TO cool

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mmv OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mmv OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mmv RENAME TO ICs

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv APPLY REPLACEMENT rp

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv APPLY REPLACEMENT rp2

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv APPLY REPLACEMENT t

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv RENAME TO mv2

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv RESET (RETAIN HISTORY)

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv SET (RETAIN HISTORY FOR '1m')

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv SET CLUSTER does_not_exist

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv SET CLUSTER other_cluster

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv SET CLUSTER quickstart

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv2 RENAME TO mv2_renamed;

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv2_renamed RENAME TO mv2;

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv_alter_plans RESET (RETAIN HISTORY)

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv_alter_plans SET (RETAIN HISTORY FOR '1m')

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv_alter_plans SET CLUSTER quickstart

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv_owner_plans OWNER TO plan_owner_other

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW mv_rename_metainfo RENAME TO mv_rename_metainfo_renamed

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW rectype_sneaky_mv RENAME TO rectype

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW v SET CLUSTER quickstart

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW v2 RESET (RETAIN HISTORY);

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW v2 SET (RETAIN HISTORY FOR '5m');

-- sqlfmt-corpus-separator --

ALTER ROLE foo CREATECLUSTER

-- sqlfmt-corpus-separator --

ALTER ROLE foo CREATEDB

-- sqlfmt-corpus-separator --

ALTER ROLE foo CREATEROLE

-- sqlfmt-corpus-separator --

ALTER ROLE foo INHERIT INHERIT

-- sqlfmt-corpus-separator --

ALTER ROLE foo NOINHERIT

-- sqlfmt-corpus-separator --

ALTER ROLE foo WITH LOGIN

-- sqlfmt-corpus-separator --

ALTER ROLE foo WITH NOLOGIN

-- sqlfmt-corpus-separator --

ALTER ROLE joe SET cluster TO will_work

-- sqlfmt-corpus-separator --

ALTER ROLE mz_system INHERIT

-- sqlfmt-corpus-separator --

ALTER ROLE parker SET cluster TO foo;

-- sqlfmt-corpus-separator --

ALTER ROLE parker SET transaction_isolation TO 'garbage';

-- sqlfmt-corpus-separator --

ALTER ROLE password_removal_test PASSWORD NULL

-- sqlfmt-corpus-separator --

ALTER ROLE public INHERIT

-- sqlfmt-corpus-separator --

ALTER SCHEMA "case" RENAME TO "cAsE";

-- sqlfmt-corpus-separator --

ALTER SCHEMA IF EXISTS nonexistent SWAP WITH green;

-- sqlfmt-corpus-separator --

ALTER SCHEMA IF EXISTS swap_s1 SWAP WITH swap_s2;

-- sqlfmt-corpus-separator --

ALTER SCHEMA NULL SWAP WITH green;

-- sqlfmt-corpus-separator --

ALTER SCHEMA b.foo RENAME TO bbb;

-- sqlfmt-corpus-separator --

ALTER SCHEMA b1 RENAME TO a1

-- sqlfmt-corpus-separator --

ALTER SCHEMA b1 RENAME TO b2

-- sqlfmt-corpus-separator --

ALTER SCHEMA b1 RENAME TO mz_special

-- sqlfmt-corpus-separator --

ALTER SCHEMA b2 RENAME TO b3;

-- sqlfmt-corpus-separator --

ALTER SCHEMA b3 RENAME TO b4;

-- sqlfmt-corpus-separator --

ALTER SCHEMA blue RENAME TO pink;

-- sqlfmt-corpus-separator --

ALTER SCHEMA blue RENAME to pink;

-- sqlfmt-corpus-separator --

ALTER SCHEMA blue SWAP WITH "!\_\""w3😊_weird_name";

-- sqlfmt-corpus-separator --

ALTER SCHEMA blue SWAP WITH NULL;

-- sqlfmt-corpus-separator --

ALTER SCHEMA blue SWAP WITH blue;

-- sqlfmt-corpus-separator --

ALTER SCHEMA blue SWAP WITH green;

-- sqlfmt-corpus-separator --

ALTER SCHEMA blue SWAP WITH mz_temp;

-- sqlfmt-corpus-separator --

ALTER SCHEMA c.foo RENAME TO ccc;

-- sqlfmt-corpus-separator --

ALTER SCHEMA c1 RENAME TO c2;

-- sqlfmt-corpus-separator --

ALTER SCHEMA c2 RENAME TO c3;

-- sqlfmt-corpus-separator --

ALTER SCHEMA d RENAME TO d_renamed;

-- sqlfmt-corpus-separator --

ALTER SCHEMA d.amb RENAME TO this_rename_will_fail;

-- sqlfmt-corpus-separator --

ALTER SCHEMA does_not_exist RENAME TO other_does_not_exist;

-- sqlfmt-corpus-separator --

ALTER SCHEMA enemy RENAME TO friend_again;

-- sqlfmt-corpus-separator --

ALTER SCHEMA friend RENAME TO enemy;

-- sqlfmt-corpus-separator --

ALTER SCHEMA grand_friend RENAME TO grand_acquaintance;

-- sqlfmt-corpus-separator --

ALTER SCHEMA green RENAME TO purple;

-- sqlfmt-corpus-separator --

ALTER SCHEMA green RENAME TO red;

-- sqlfmt-corpus-separator --

ALTER SCHEMA information_schema RENAME TO information_schema_other;

-- sqlfmt-corpus-separator --

ALTER SCHEMA j RENAME TO j_other;

-- sqlfmt-corpus-separator --

ALTER SCHEMA jsc OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER SCHEMA msc OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER SCHEMA msc OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER SCHEMA mz_catalog RENAME TO mz_catalog_other;

-- sqlfmt-corpus-separator --

ALTER SCHEMA mz_internal RENAME TO mz_internal_other;

-- sqlfmt-corpus-separator --

ALTER SCHEMA mz_internal SWAP WITH mz_catalog;

-- sqlfmt-corpus-separator --

ALTER SCHEMA mz_temp RENAME TO other_name;

-- sqlfmt-corpus-separator --

ALTER SCHEMA mz_temp SWAP WITH blue;

-- sqlfmt-corpus-separator --

ALTER SCHEMA orange RENAME TO green;

-- sqlfmt-corpus-separator --

ALTER SCHEMA orange RENAME TO red;

-- sqlfmt-corpus-separator --

ALTER SCHEMA pink RENAME TO purple;

-- sqlfmt-corpus-separator --

ALTER SCHEMA public RENAME TO public_other;

-- sqlfmt-corpus-separator --

ALTER SCHEMA purple RENAME TO orange;

-- sqlfmt-corpus-separator --

ALTER SCHEMA red RENAME TO orange;

-- sqlfmt-corpus-separator --

ALTER SCHEMA s_rename_metainfo RENAME TO s_rename_metainfo_renamed

-- sqlfmt-corpus-separator --

ALTER SCHEMA this_is_a_schema_with_a_super_long_name_of_exactly_255_characters_which_happens_to_be_the_maximum_we_allow_in_materialize_for_identifiers_of_any_kind_including_for_the_schema_name_so_this_should_still_work_perfectly_fine_as_long_as_we_dont_make_it_longer SWAP WITH blue;

-- sqlfmt-corpus-separator --

ALTER SECRET certificate RENAME TO existing

-- sqlfmt-corpus-separator --

ALTER SECRET certificate RENAME TO t1

-- sqlfmt-corpus-separator --

ALTER SECRET certificate as decode('c2VjcmV0Cg==', 'base64');

-- sqlfmt-corpus-separator --

ALTER SECRET jse AS decode('c2VjcmV0Cg==', 'base64');

-- sqlfmt-corpus-separator --

ALTER SECRET jse OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER SECRET jse RENAME TO cool

-- sqlfmt-corpus-separator --

ALTER SECRET key RENAME TO certificate

-- sqlfmt-corpus-separator --

ALTER SECRET mse AS decode('c2VjcmV0Cg==', 'base64');

-- sqlfmt-corpus-separator --

ALTER SECRET mse OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER SECRET mse OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER SECRET mse RENAME TO ICs

-- sqlfmt-corpus-separator --

ALTER SECRET nonexistant as decode('c2VjcmV0Cg==', 'base64');

-- sqlfmt-corpus-separator --

ALTER SECRET rectype_sneaky RENAME TO rectype

-- sqlfmt-corpus-separator --

ALTER SECRET t1 as 'textsecret';

-- sqlfmt-corpus-separator --

ALTER SECRET t1 rename to t2;

-- sqlfmt-corpus-separator --

ALTER SINK does_not_exist SET CLUSTER quickstart

-- sqlfmt-corpus-separator --

ALTER SINK v SET CLUSTER quickstart

-- sqlfmt-corpus-separator --

ALTER SOURCE auction_house RESET (RETAIN HISTORY)

-- sqlfmt-corpus-separator --

ALTER SOURCE auction_house SET (RETAIN HISTORY FOR '1m')

-- sqlfmt-corpus-separator --

ALTER SOURCE counter RESET (RETAIN HISTORY)

-- sqlfmt-corpus-separator --

ALTER SOURCE counter SET (RETAIN HISTORY FOR '0')

-- sqlfmt-corpus-separator --

ALTER SOURCE counter SET (RETAIN HISTORY FOR '1m')

-- sqlfmt-corpus-separator --

ALTER SOURCE counter SET (RETAIN HISTORY FOR '1ms')

-- sqlfmt-corpus-separator --

ALTER SOURCE does_not_exist SET CLUSTER quickstart

-- sqlfmt-corpus-separator --

ALTER SOURCE js OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER SOURCE js RENAME TO cool

-- sqlfmt-corpus-separator --

ALTER SOURCE ms OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER SOURCE ms OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER SOURCE ms RENAME TO ICs

-- sqlfmt-corpus-separator --

ALTER SOURCE mz_internal.mz_storage_shards RENAME TO foo;

-- sqlfmt-corpus-separator --

ALTER SOURCE mz_introspection.mz_dataflow_channels RENAME TO foo;

-- sqlfmt-corpus-separator --

ALTER SOURCE rectype_sneaky_s RENAME TO rectype

-- sqlfmt-corpus-separator --

ALTER SOURCE s OWNER TO joe

-- sqlfmt-corpus-separator --

ALTER SOURCE s RENAME TO v

-- sqlfmt-corpus-separator --

ALTER SOURCE s RESET (RETAIN HISTORY)

-- sqlfmt-corpus-separator --

ALTER SOURCE s RESET (TIMESTAMP INTERVAL)

-- sqlfmt-corpus-separator --

ALTER SOURCE s SET (RETAIN HISTORY FOR '1m')

-- sqlfmt-corpus-separator --

ALTER SOURCE s SET (TIMESTAMP INTERVAL '2s')

-- sqlfmt-corpus-separator --

ALTER SOURCE s SET (TIMESTAMP INTERVAL '500ms')

-- sqlfmt-corpus-separator --

ALTER SOURCE webhook_buildkite2 RENAME TO webhook_buildkite2_renamed;

-- sqlfmt-corpus-separator --

ALTER TABLE blue_t1 RENAME TO purple_t1;

-- sqlfmt-corpus-separator --

ALTER TABLE blue_t1 RENAME TO red_t1;

-- sqlfmt-corpus-separator --

ALTER TABLE d1.public.foo RENAME TO bar

-- sqlfmt-corpus-separator --

ALTER TABLE green_t1 RENAME TO blue_t1;

-- sqlfmt-corpus-separator --

ALTER TABLE jt OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER TABLE jt RENAME TO cool

-- sqlfmt-corpus-separator --

ALTER TABLE mt OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER TABLE mt OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER TABLE mt RENAME TO ICs

-- sqlfmt-corpus-separator --

ALTER TABLE mz_tables RENAME TO foo;

-- sqlfmt-corpus-separator --

ALTER TABLE non_temp_base RENAME TO non_temp_table;

-- sqlfmt-corpus-separator --

ALTER TABLE rectype_sneaky_t RENAME TO rectype

-- sqlfmt-corpus-separator --

ALTER TABLE t RENAME TO t2

-- sqlfmt-corpus-separator --

ALTER TABLE t RESET (RETAIN HISTORY)

-- sqlfmt-corpus-separator --

ALTER TABLE t SET (RETAIN HISTORY FOR '1m')

-- sqlfmt-corpus-separator --

ALTER TABLE t1 ADD COLUMN IF NOT EXISTS a int;

-- sqlfmt-corpus-separator --

ALTER TABLE t1 ADD COLUMN a int;

-- sqlfmt-corpus-separator --

ALTER TABLE t1 ADD COLUMN b text;

-- sqlfmt-corpus-separator --

ALTER TABLE t1 ADD COLUMN c timestamp;

-- sqlfmt-corpus-separator --

ALTER TABLE t2 ADD COLUMN b text;

-- sqlfmt-corpus-separator --

ALTER TABLE t2 ADD COLUMN c timestamp;

-- sqlfmt-corpus-separator --

ALTER TABLE t2 ADD COLUMN c2 OID;

-- sqlfmt-corpus-separator --

ALTER TABLE users RENAME TO userz

-- sqlfmt-corpus-separator --

ALTER TYPE jty OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER TYPE mty OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER TYPE mty OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER USER "materialize@foocorp.io" SET cluster = "cluster=cluster=cluster=";

-- sqlfmt-corpus-separator --

ALTER USER "materialize@foocorp.io" SET search_path = 'abc,def';

-- sqlfmt-corpus-separator --

ALTER VIEW green_v1 RENAME TO blue_v1;

-- sqlfmt-corpus-separator --

ALTER VIEW jv OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER VIEW jv RENAME TO cool

-- sqlfmt-corpus-separator --

ALTER VIEW mv OWNER TO group_materialize

-- sqlfmt-corpus-separator --

ALTER VIEW mv OWNER TO group_no_one

-- sqlfmt-corpus-separator --

ALTER VIEW mv RENAME TO ICs

-- sqlfmt-corpus-separator --

ALTER VIEW mv RENAME TO mv2

-- sqlfmt-corpus-separator --

ALTER VIEW mv SET CLUSTER quickstart

-- sqlfmt-corpus-separator --

ALTER VIEW rectype_sneaky_v RENAME TO rectype

-- sqlfmt-corpus-separator --

ALTER VIEW unmat RENAME TO renamed

-- sqlfmt-corpus-separator --

ALTER cluster unmanaged1 SET (SCHEDULE = MANUAL);

-- sqlfmt-corpus-separator --

ALTER cluster unmanaged1 SET (SCHEDULE = ON REFRESH);

-- sqlfmt-corpus-separator --

ALTER cluster unmanaged1 SET (managed = true, SCHEDULE = ON REFRESH, REPLICATION FACTOR = 1, SIZE = 'scale=1,workers=1');

-- sqlfmt-corpus-separator --

BEGIN

-- sqlfmt-corpus-separator --

BEGIN ISOLATION LEVEL REPEATABLE READ

-- sqlfmt-corpus-separator --

BEGIN ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

BEGIN READ ONLY

-- sqlfmt-corpus-separator --

BEGIN READ WRITE

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION READ WRITE

-- sqlfmt-corpus-separator --

BEGIN;

-- sqlfmt-corpus-separator --

BEGIN;
INSERT INTO kv (k,v) VALUES ('a', transaction_timestamp());
SELECT * FROM kv

-- sqlfmt-corpus-separator --

BEGIN;
INSERT INTO kv (k,v) VALUES ('b', transaction_timestamp());
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES ('c', transaction_timestamp());
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES ('d', current_timestamp());
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES ('e', current_timestamp());
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES ('f', now());
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES ('g', now());
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES ('h', statement_timestamp());
SELECT * FROM kv;
COMMIT;
SELECT * FROM kv;
BEGIN;
SELECT * FROM KV;
INSERT INTO kv (k,v) VALUES ('i', transaction_timestamp());
COMMIT

-- sqlfmt-corpus-separator --

BEGIN;
INSERT INTO kv (k,v) VALUES (1, cluster_logical_timestamp());
SELECT * FROM kv

-- sqlfmt-corpus-separator --

BEGIN;
SELECT * FROM KV;
INSERT INTO kv (k,v) VALUES ('c', transaction_timestamp());
COMMIT

-- sqlfmt-corpus-separator --

BEGIN;
SELECT * FROM kv;
INSERT INTO kv (k,v) VALUES (3, cluster_logical_timestamp());
COMMIT

-- sqlfmt-corpus-separator --

COMMIT

-- sqlfmt-corpus-separator --

COMMIT AND CHAIN

-- sqlfmt-corpus-separator --

COMMIT TRANSACTION

-- sqlfmt-corpus-separator --

COMMIT;

-- sqlfmt-corpus-separator --

CREATE CLUSTER "foo-bar" REPLICAS ()

-- sqlfmt-corpus-separator --

CREATE CLUSTER FOO SIZE = 'scale=1,workers=1' FEATURES (ENABLE EAGER DELTA JOINS = TRUE);

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA "foo-bar"."foo-bar" SIZE 'scale=1,workers=1'

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA distinct_arrangements.replica SIZE = 'scale=1,workers=2', INTROSPECTION DEBUGGING = true;

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA mclus.mr2 SIZE 'scale=1,workers=1';

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA no_such_cluster.size_1 SIZE 'scale=1,workers=1';

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA quickstart."foo-bar" SIZE 'scale=1,workers=1'

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA quickstart."好-好" SIZE 'scale=1,workers=1'

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA quickstart."好_好" SIZE 'scale=1,workers=1'

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA quickstart.bar_foo SIZE 'scale=1,workers=1'

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA quickstart.foo_bar SIZE 'scale=1,workers=1'

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA quickstart.replica AVAILABILITY ZONE 'a', AVAILABILITY ZONE 'b'

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA quickstart.replica AVAILABILITY ZONE 'a', STORAGECTL ADDRESSES ['host']

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA quickstart.replica SIZE 'scale=1,workers=1', AVAILABILITY ZONE 'a'

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA quickstart.replica STORAGECTL ADDRESSES ['host'], AVAILABILITY ZONE 'a'

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA quickstart.size_1 SIZE 'scale=1,workers=1';

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA quickstart.size_1 SIZE;

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA t1.free2 SIZE 'scale=1,workers=2', BILLED AS 'free'

-- sqlfmt-corpus-separator --

CREATE CLUSTER REPLICA t1.free2 SIZE 'scale=1,workers=2', INTERNAL

-- sqlfmt-corpus-separator --

CREATE CLUSTER bad REPLICAS (size_2 (SIZE ''));

-- sqlfmt-corpus-separator --

CREATE CLUSTER bad REPLICAS (size_2 (SIZE 'no_such_size'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER bad REPLICAS (size_2 (SIZE 1));

-- sqlfmt-corpus-separator --

CREATE CLUSTER bad REPLICAS (size_2 (SIZE NULL));

-- sqlfmt-corpus-separator --

CREATE CLUSTER bad REPLICAS (size_2 (SIZE a));

-- sqlfmt-corpus-separator --

CREATE CLUSTER bar REPLICAS ()

-- sqlfmt-corpus-separator --

CREATE CLUSTER bar REPLICAS (r1 (COMPUTECTL ADDRESSES ['localhost:1235'], COMPUTECTL ADDRESSES ['localhost:1234']))

-- sqlfmt-corpus-separator --

CREATE CLUSTER bar REPLICAS (r1 (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER bar REPLICAS (r1 (SIZE 'scale=1,workers=1'), r1 (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER bar REPLICAS (r1 (SIZE 'scale=1,workers=1'), r2 (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER bar SIZE = 'scale=1,workers=1';

-- sqlfmt-corpus-separator --

CREATE CLUSTER baz REPLICAS (), INTROSPECTION DEBUGGING = true

-- sqlfmt-corpus-separator --

CREATE CLUSTER baz REPLICAS (), INTROSPECTION INTERVAL 1

-- sqlfmt-corpus-separator --

CREATE CLUSTER baz REPLICAS (), MANAGED

-- sqlfmt-corpus-separator --

CREATE CLUSTER baz REPLICAS (), MANAGED = false

-- sqlfmt-corpus-separator --

CREATE CLUSTER baz REPLICAS (), REPLICATION FACTOR 0

-- sqlfmt-corpus-separator --

CREATE CLUSTER baz REPLICAS (), SIZE 'scale=1,workers=1'

-- sqlfmt-corpus-separator --

CREATE CLUSTER baz REPLICAS (r1 (COMPUTECTL ADDRESSES ['localhost:1234'], SIZE 'small'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER baz REPLICAS (r1 (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER baz REPLICAS (r1 (SIZE 'scale=1,workers=2', STORAGECTL ADDRESSES ['localhost:1234']))

-- sqlfmt-corpus-separator --

CREATE CLUSTER baz REPLICAS (r1 (STORAGECTL ADDRESSES ['localhost:1234'], COMPUTECTL ADDRESSES ['localhost:1234', 'localhost:4567']))

-- sqlfmt-corpus-separator --

CREATE CLUSTER baz REPLICAS (r1 (STORAGECTL ADDRESSES ['localhost:1234'], COMPUTECTL ADDRESSES []))

-- sqlfmt-corpus-separator --

CREATE CLUSTER blue_green (SIZE = 'scale=1,workers=1');

-- sqlfmt-corpus-separator --

CREATE CLUSTER blue_green_dbt_deploy (SIZE = 'scale=1,workers=1');

-- sqlfmt-corpus-separator --

CREATE CLUSTER c REPLICAS (r1 (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER c REPLICAS (r1 (SIZE 'scale=1,workers=1'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER c REPLICAS (replica1 (SIZE 'scale=1,workers=1'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER c SIZE 'scale=1,workers=1', REPLICATION FACTOR 2;

-- sqlfmt-corpus-separator --

CREATE CLUSTER c SIZE 'scale=1,workers=1';

-- sqlfmt-corpus-separator --

CREATE CLUSTER c1 (SIZE 'scale=1,workers=1', REPLICATION FACTOR 2)

-- sqlfmt-corpus-separator --

CREATE CLUSTER c1 REPLICAS ()

-- sqlfmt-corpus-separator --

CREATE CLUSTER c1 REPLICAS (r (SIZE 'scale=1,workers=1'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER c1 REPLICAS (replica_a (SIZE 'scale=1,workers=1', INTROSPECTION INTERVAL '50 milliseconds', INTROSPECTION DEBUGGING));

-- sqlfmt-corpus-separator --

CREATE CLUSTER c1 SIZE 'scale=1,workers=1'

-- sqlfmt-corpus-separator --

CREATE CLUSTER c1 SIZE 'scale=1,workers=1', WORKLOAD CLASS 'production'

-- sqlfmt-corpus-separator --

CREATE CLUSTER c1 SIZE 'scale=1,workers=8,mem=2GiB';

-- sqlfmt-corpus-separator --

CREATE CLUSTER c_bad (SIZE = 'scale=1,workers=1', SCHEDULE = ON REFRESH (HYDRATION TIME ESTIMATE = '-1 hour'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER c_bad (SIZE = 'scale=1,workers=1', SCHEDULE = ON REFRESH (HYDRATION TIME ESTIMATE = '1 aaaa'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER c_bad (SIZE = 'scale=1,workers=1', SCHEDULE = ON REFRESH (HYDRATION TIME ESTIMATE = '1 month'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER c_bad (SIZE = 'scale=1,workers=1', SCHEDULE = ON REFRESH (HYDRATION TIME ESTIMATE = '1000000000000 days'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER c_schedule_0 (SIZE = 'scale=1,workers=1', SCHEDULE = ON REFRESH);

-- sqlfmt-corpus-separator --

CREATE CLUSTER c_schedule_0 (SIZE = 'scale=1,workers=1', SCHEDULE = ON REFRESH, REPLICATION FACTOR = 1);

-- sqlfmt-corpus-separator --

CREATE CLUSTER c_schedule_1 (SIZE = 'scale=1,workers=1', SCHEDULE = MANUAL);

-- sqlfmt-corpus-separator --

CREATE CLUSTER c_schedule_2 (SIZE = 'scale=1,workers=1', SCHEDULE MANUAL);

-- sqlfmt-corpus-separator --

CREATE CLUSTER c_schedule_3 (SIZE = 'scale=1,workers=1', SCHEDULE = ON REFRESH);

-- sqlfmt-corpus-separator --

CREATE CLUSTER c_schedule_4 (SIZE = 'scale=1,workers=1', SCHEDULE = ON REFRESH);

-- sqlfmt-corpus-separator --

CREATE CLUSTER c_schedule_5 (SIZE = 'scale=1,workers=1');

-- sqlfmt-corpus-separator --

CREATE CLUSTER c_schedule_6 (SIZE = 'scale=1,workers=1', SCHEDULE = ON REFRESH);

-- sqlfmt-corpus-separator --

CREATE CLUSTER c_schedule_hydration_time_estimate (SIZE = 'scale=1,workers=1', SCHEDULE = ON REFRESH (HYDRATION TIME ESTIMATE = '995 seconds'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER cluster1 REPLICAS (r1 (SIZE 'scale=1,workers=1'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER comment_cluster REPLICAS (r1 (SIZE 'scale=1,workers=1'), r2 (SIZE 'scale=1,workers=1'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER distinct_arrangements REPLICAS (r1 (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER empty (SIZE 'scale=1,workers=1', REPLICATION FACTOR 0)

-- sqlfmt-corpus-separator --

CREATE CLUSTER empty REPLICAS ()

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo (SIZE 'scale=1,workers=1')

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS ( r1 (SIZE = 'scale=1,workers=1') );

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS ( weewoo1 (SIZE = 'scale=1,workers=1') );

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS ()

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (), REPLICAS()

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (a (SIZE 'lol'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (a (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (c1 (SIZE 'scale=1,workers=1'), r2 (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (r (SIZE 'scale=1,workers=1'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (r1 (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (r1 (SIZE 'scale=1,workers=1'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (r1 (SIZE 'scale=1,workers=1'), r2 (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (r1 (SIZE 'scale=1,workers=1'), r2 (SIZE 'scale=1,workers=2'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (r1 (SIZE 'scale=1,workers=1', INTROSPECTION INTERVAL '1s'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (r1 (STORAGECTL ADDRESSES ['s:1234'], COMPUTECTL ADDRESSES ['c:1234']))

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (size_1 (SIZE 'scale=1,workers=1'), size_2 (SIZE 'scale=1,workers=2'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (size_1 (SIZE 'scale=1,workers=1'), size_32 (SIZE 'scale=1,workers=32'), size_2_2 (SIZE 'scale=2,workers=2'), size_1_8g (SIZE 'scale=1,workers=1,mem=8GiB'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo REPLICAS (size_2 (SIZE 'scale=1,workers=1'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo SIZE 'abc', REPLICATION FACTOR 3

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo SIZE 'scale=1,workers=1'

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo SIZE 'scale=1,workers=1', REPLICATION FACTOR 3

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo SIZE 'scale=1,workers=1', replication factor 1

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo SIZE 'scale=1,workers=1', replication factor 99

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo SIZE 'scale=1,workers=1', replication factor 9999999;

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo SIZE = 'scale=1,workers=1';

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo SIZE invalid_size, REPLICATION FACTOR 0

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo2 REPLICAS (a (SIZE 'scale=1,workers=32'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo3 REPLICAS (a (SIZE 'scale=2,workers=2'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER foo4 REPLICAS (a (SIZE "scale=1,workers=1"))

-- sqlfmt-corpus-separator --

CREATE CLUSTER green_compute SIZE 'scale=1,workers=1';

-- sqlfmt-corpus-separator --

CREATE CLUSTER linear_join REPLICAS (r1 (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER mclus REPLICAS (mr1 (SIZE 'scale=1,workers=1'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER multiprocess REPLICAS (a (SIZE 'scale=2,workers=2'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER no_replicas (SIZE 'scale=1,workers=1', REPLICATION FACTOR 0);

-- sqlfmt-corpus-separator --

CREATE CLUSTER non_blue_green (SIZE = 'scale=1,workers=1');

-- sqlfmt-corpus-separator --

CREATE CLUSTER other REPLICAS (r1 (SIZE 'scale=1,workers=1'), r2 (SIZE 'scale=2,workers=2'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER other SIZE 'scale=1,workers=1'

-- sqlfmt-corpus-separator --

CREATE CLUSTER other_cluster SIZE 'scale=1,workers=1', REPLICATION FACTOR 0

-- sqlfmt-corpus-separator --

CREATE CLUSTER quickstart REPLICAS (r1 (SIZE 'scale=1,workers=2')), MANAGED = false;

-- sqlfmt-corpus-separator --

CREATE CLUSTER swap_test_a SIZE = 'scale=1,workers=1';

-- sqlfmt-corpus-separator --

CREATE CLUSTER swap_test_b SIZE = 'scale=1,workers=1';

-- sqlfmt-corpus-separator --

CREATE CLUSTER t1 (REPLICAS (internal_r1 (SIZE 'scale=1,workers=1', BILLED AS 'free')));

-- sqlfmt-corpus-separator --

CREATE CLUSTER t1 (REPLICAS (internal_r1 (SIZE 'scale=1,workers=1', INTERNAL)));

-- sqlfmt-corpus-separator --

CREATE CLUSTER t1 (REPLICAS (internal_r1 (SIZE 'scale=1,workers=1', INTERNAL, BILLED AS 'free')));

-- sqlfmt-corpus-separator --

CREATE CLUSTER t1 (REPLICAS (r1 (SIZE 'scale=1,workers=1', INTERNAL, BILLED AS 'free')));

-- sqlfmt-corpus-separator --

CREATE CLUSTER t1 REPLICAS (r1 (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER t1 SIZE 'scale=1,workers=1'

-- sqlfmt-corpus-separator --

CREATE CLUSTER t1 SIZE 'scale=1,workers=1', REPLICATION FACTOR 1

-- sqlfmt-corpus-separator --

CREATE CLUSTER test
  REPLICAS (
    replica_a (SIZE 'scale=1,workers=1', INTROSPECTION INTERVAL '50 milliseconds'),
    replica_b (SIZE 'scale=1,workers=2', INTROSPECTION INTERVAL '50 milliseconds')
  )

-- sqlfmt-corpus-separator --

CREATE CLUSTER test
  REPLICAS (
    replica_a (SIZE 'scale=1,workers=1', INTROSPECTION INTERVAL 0),
    replica_b (SIZE 'scale=1,workers=1', INTROSPECTION INTERVAL 1)
  )

-- sqlfmt-corpus-separator --

CREATE CLUSTER test
  REPLICAS (replica_a (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER test REPLICAS (foo (SIZE 'scale=1,workers=1'));

-- sqlfmt-corpus-separator --

CREATE CLUSTER test REPLICAS (r1 (SIZE 'scale=1,workers=1'), r2 (SIZE 'scale=1,workers=1'))

-- sqlfmt-corpus-separator --

CREATE CLUSTER test REPLICAS(
    r1 (SIZE 'scale=1,workers=1'),
    r2 (SIZE 'scale=1,workers=1')
)

-- sqlfmt-corpus-separator --

CREATE CLUSTER test SIZE 'scale=2,workers=1';

-- sqlfmt-corpus-separator --

CREATE CLUSTER test1 SIZE 'scale=1,workers=1'

-- sqlfmt-corpus-separator --

CREATE CLUSTER test2 SIZE 'scale=1,workers=1'

-- sqlfmt-corpus-separator --

CREATE CLUSTER to_drop REPLICAS ()

-- sqlfmt-corpus-separator --

CREATE CLUSTER unmanaged1 (SCHEDULE = MANUAL, REPLICAS (r1 (SIZE 'scale=1,workers=1')))

-- sqlfmt-corpus-separator --

CREATE CLUSTER unmanaged2 (SCHEDULE = ON REFRESH, REPLICAS (r1 (SIZE 'scale=1,workers=1')))

-- sqlfmt-corpus-separator --

CREATE CLUSTER webhook_cluster REPLICAS (r1 (SIZE 'scale=1,workers=1'));

-- sqlfmt-corpus-separator --

CREATE CONNECTION IF NOT EXISTS kafka_conn TO KAFKA (BROKER 'broker', SECURITY PROTOCOL PLAINTEXT) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION c TO KAFKA (BROKER 'localhost:9092', SECURITY PROTOCOL PLAINTEXT) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION conn TO KAFKA (BROKER 'localhost:9092', SECURITY PROTOCOL PLAINTEXT) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION conn TO SSH TUNNEL (HOST 'host', PORT 22, USER 'materialize')

-- sqlfmt-corpus-separator --

CREATE CONNECTION d1.s1.c TO KAFKA (BROKER 'localhost:9092', SECURITY PROTOCOL PLAINTEXT) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION d1.s11.c TO KAFKA (BROKER 'localhost:9092', SECURITY PROTOCOL PLAINTEXT) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION d2.s2.c TO KAFKA (BROKER 'localhost:9092', SECURITY PROTOCOL PLAINTEXT) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION d2.s22.c TO KAFKA (BROKER 'localhost:9092', SECURITY PROTOCOL PLAINTEXT) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION kafka_conn TO KAFKA (BROKER 'broker', SECURITY PROTOCOL PLAINTEXT) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION kafka_conn TO KAFKA (BROKER 'localhost:9092', SECURITY PROTOCOL PLAINTEXT) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION kafka_conn2 TO KAFKA (BROKER 'broker', SECURITY PROTOCOL PLAINTEXT, SASL PASSWORD = SECRET not_a_secret) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION kafka_conn2 TO KAFKA (BROKER 'broker', SECURITY PROTOCOL PLAINTEXT, SASL PASSWORD = SECRET not_an_object_at_all) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION materialize.public.a TO AWS (ACCESS KEY ID = 'access_key', SECRET ACCESS KEY = SECRET s3_api_secret_key) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION materialize.public.c TO KAFKA (BROKER 'localhost:9092', SECURITY PROTOCOL PLAINTEXT) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION mc TO KAFKA (BROKER 'localhost:9092', SECURITY PROTOCOL PLAINTEXT) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION mssh TO SSH TUNNEL (HOST 'ssh-bastion-host', USER 'mz', PORT 22) WITH (VALIDATE = false);

-- sqlfmt-corpus-separator --

CREATE CONNECTION pg TO POSTGRES (
  HOST object_reference,
  DATABASE postgres,
  USER postgres
) WITH (VALIDATE = false)

-- sqlfmt-corpus-separator --

CREATE CONNECTION pg TO POSTGRES (
  HOST postgres,
  DATABASE postgres,
  USER postgres,
  PASSWORD SECRET pgpass,
  SSL MODE require,
  SSH TUNNEL not_an_object_at_all
 ) WITH (VALIDATE = false)

-- sqlfmt-corpus-separator --

CREATE CONNECTION rectype TO SSH TUNNEL (HOST 'localhost', USER 'ignored')

-- sqlfmt-corpus-separator --

CREATE CONNECTION rectype_sneaky TO SSH TUNNEL (HOST 'localhost', USER 'ignored')

-- sqlfmt-corpus-separator --

CREATE DATABASE a;

-- sqlfmt-corpus-separator --

CREATE DATABASE b;

-- sqlfmt-corpus-separator --

CREATE DATABASE bar

-- sqlfmt-corpus-separator --

CREATE DATABASE c;

-- sqlfmt-corpus-separator --

CREATE DATABASE comment_on_db;

-- sqlfmt-corpus-separator --

CREATE DATABASE d

-- sqlfmt-corpus-separator --

CREATE DATABASE d1

-- sqlfmt-corpus-separator --

CREATE DATABASE d2

-- sqlfmt-corpus-separator --

CREATE DATABASE d;

-- sqlfmt-corpus-separator --

CREATE DATABASE db

-- sqlfmt-corpus-separator --

CREATE DATABASE foo

-- sqlfmt-corpus-separator --

CREATE DATABASE j;

-- sqlfmt-corpus-separator --

CREATE DATABASE mdb;

-- sqlfmt-corpus-separator --

CREATE DATABASE other

-- sqlfmt-corpus-separator --

CREATE DATABASE otherdb

-- sqlfmt-corpus-separator --

CREATE DATABASE test

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW event_session AS
    WITH MUTUALLY RECURSIVE
        -- Convert each value in events into a 5-minute long session
        make_session (user_id int4, session tsrange)
            AS (
                SELECT
                    user_id, tsrange(event_time, event_time + '5 m'::INTERVAL) AS session
                FROM
                    events
            ),
        -- Merge any overlapping/adjacent sessions
        merge_session (user_id int4, session tsrange)
            AS (
                SELECT
                    DISTINCT user_id, l_session + r_session
                FROM
                    (
                        SELECT
                            l.user_id AS user_id, l.session AS l_session, r.session AS r_session
                        -- Base case is just the `make_session` relation
                        FROM
                            make_session AS l, make_session AS r
                        WHERE
                            l.user_id = r.user_id
                            AND (l.session && r.session OR l.session -|- r.session)
                        UNION ALL
                            -- Further improve any merged sessions against any new sessions
                            SELECT
                                make_session.user_id, make_session.session, merge_session.session
                            FROM
                                make_session, merge_session
                            WHERE
                                -- ? @aalexandrov could this be
                                -- reduce_session.user_id = merge_session.user_id
                                -- AND (
                                --         reduce_session.session && merge_session.session
                                --         OR reduce_session.session -|- merge_session.session
                                --     )
                                -- if we do a cross join of reduce_session, merge_session
                                make_session.user_id = merge_session.user_id
                                AND (
                                        make_session.session && merge_session.session
                                        OR make_session.session -|- merge_session.session
                                    )
                    )
            ),
        -- Keep only widest session that touches any given point in time
        reduce_session (user_id int4, session tsrange)
            AS (
                SELECT
                    user_id, tsrange(lower, upper)
                FROM
                    (
                        SELECT
                            user_id, min(lower) AS lower, upper
                        FROM
                            (
                                SELECT
                                    user_id, lower(session), max(upper(session)) AS upper
                                FROM
                                    merge_session
                                GROUP BY
                                    user_id, lower(session)
                            )
                        GROUP BY
                            user_id, upper
                    )
            )
    SELECT
        *
    FROM
        reduce_session;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW event_session AS
    WITH MUTUALLY RECURSIVE
        make_session (user_id int4, session tsrange)
            AS (
                SELECT
                    user_id, tsrange(event_time, event_time + '5 m'::INTERVAL) AS session
                FROM
                    events
            ),
        merge_session (user_id int4, session tsrange)
            AS (
                SELECT
                    DISTINCT user_id, l_session + r_session
                FROM
                    (
                        SELECT
                            l.user_id AS user_id, l.session AS l_session, r.session AS r_session
                        FROM
                            make_session AS l, make_session AS r
                        WHERE
                            l.user_id = r.user_id
                            AND (l.session && r.session OR l.session -|- r.session)
                        UNION ALL
                            SELECT
                                make_session.user_id, make_session.session, merge_session.session
                            FROM
                                make_session, merge_session
                            WHERE
                                make_session.user_id = merge_session.user_id
                                AND (
                                        make_session.session && merge_session.session
                                        OR make_session.session -|- merge_session.session
                                    )
                    )
            ),
        reduce_session (user_id int4, session tsrange)
            AS (
                SELECT
                    user_id, tsrange(lower, upper)
                FROM
                    (
                        SELECT
                            user_id, min(lower) AS lower, upper
                        FROM
                            (
                                SELECT
                                    user_id, lower(session), max(upper(session)) AS upper
                                FROM
                                    merge_session
                                GROUP BY
                                    user_id, lower(session)
                            )
                        GROUP BY
                            user_id, upper
                    )
            )
    SELECT
        *
    FROM
        reduce_session;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_cluster_replicas AS SELECT cluster, replica, size, ready FROM (SHOW CLUSTER REPLICAS);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_clusters AS SELECT name FROM (SHOW CLUSTERS);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_columns AS SELECT name, nullable, type FROM (SHOW COLUMNS FROM mz_tables);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_connections AS SELECT name, type FROM (SHOW CONNECTIONS);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_databases AS SELECT name FROM (SHOW DATABASES);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_indexes AS SELECT name, on, cluster, key FROM (SHOW INDEXES);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_mat_views AS SELECT name, cluster FROM (SHOW MATERIALIZED VIEWS);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_objects AS SELECT name FROM (SHOW OBJECTS);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_schemas AS SELECT name FROM (SHOW SCHEMAS);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_secrets AS SELECT name FROM (SHOW SECRETS);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_sinks AS SELECT name, type FROM (SHOW SINKS);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_sources AS SELECT name, type FROM (SHOW SOURCES);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_tables AS SELECT name FROM (SHOW TABLES);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_views AS SELECT name FROM (SHOW VIEWS);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv_complex_mfp_basic_distinct_single AS
SELECT a, LIST_AGG(DISTINCT b ORDER BY b DESC)::text
FROM t
GROUP BY a
HAVING
  ((LIST_AGG(DISTINCT b ORDER BY b DESC)[1] + 1) - a) > 2 AND
  (LIST_AGG(DISTINCT b ORDER BY b DESC)[1] + 1) / (1 + a) >= 1;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv_complex_mfp_basic_multiple AS
SELECT a, LIST_AGG(b ORDER BY b DESC)::text
FROM t
GROUP BY a
HAVING
  ((ARRAY_AGG(b ORDER BY b DESC)[1] + 1) - a) > 2 AND
  (ARRAY_AGG(b ORDER BY b DESC)[1] + 1) / (1 + a) >= 1;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv_complex_mfp_basic_single AS
SELECT a, LIST_AGG(b ORDER BY b DESC)::text
FROM t
GROUP BY a
HAVING
  ((LIST_AGG(b ORDER BY b DESC)[1] + 1) - a) > 2 AND
  (LIST_AGG(b ORDER BY b DESC)[1] + 1) / (1 + a) >= 1;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW v1 AS
WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 2)
  cnt (f1 INTEGER) AS (
    SELECT f1 FROM t1 UNION ALL SELECT f1+1 AS f1 FROM cnt
  )
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

CREATE NETWORK POLICY np_drop (RULES (r1 (address='0.0.0.0/0', action='allow', direction='ingress')))

-- sqlfmt-corpus-separator --

CREATE NETWORK POLICY np_reassign (RULES (r1 (address='0.0.0.0/0', action='allow', direction='ingress')))

-- sqlfmt-corpus-separator --

CREATE OR REPLACE MATERIALIZED VIEW Message AS
WITH MUTUALLY RECURSIVE
  -- compute the transitive closure (with root information) using minimnal info
  roots (MessageId bigint, RootPostId bigint, RootPostLanguage text, ContainerForumId bigint, ParentMessageId bigint) AS
    (      SELECT id AS MessageId, id AS RootPostId, language AS RootPostLanguage, ContainerForumId, NULL::bigint AS ParentMessageId FROM Post
     UNION SELECT
              Comment.id AS MessageId,
         ParentPostId AS RootPostId,
         language AS RootPostLanguage,
         Post.ContainerForumId AS ContainerForumId,
         ParentPostId AS ParentMessageId
           FROM Comment
       JOIN Post
       ON Comment.ParentPostId = Post.id),
  ms (MessageId bigint, RootPostId bigint, RootPostLanguage text, ContainerForumId bigint, ParentMessageId bigint) AS
    (      SELECT *
           FROM roots
     UNION SELECT
              Comment.id AS MessageId,
         ms.RootPostId AS RootPostId,
         ms.RootPostLanguage AS RootPostLanguage,
         ms.ContainerForumId AS ContainerForumId,
         ParentCommentId AS ParentMessageId
           FROM Comment
       JOIN ms
       ON ParentCommentId = ms.MessageId)
  -- now do the late materialization
  (     SELECT
          creationDate,
          id AS MessageId,
          id AS RootPostId,
          language AS RootPostLanguage,
          content,
          imageFile,
          locationIP,
          browserUsed,
          length,
          CreatorPersonId,
          ContainerForumId,
          LocationCountryId,
          NULL::bigint AS ParentMessageId
        FROM Post
  UNION (SELECT
          Comment.creationDate AS creationDate,
          Comment.id AS MessageId,
          ms.RootPostId AS RootPostId,
          ms.RootPostLanguage AS RootPostLanguage,
          Comment.content AS content,
          NULL::text AS imageFile,
          Comment.locationIP AS locationIP,
          Comment.browserUsed AS browserUsed,
          Comment.length AS length,
          Comment.CreatorPersonId AS CreatorPersonId,
          ms.ContainerForumId AS ContainerForumId,
          Comment.LocationCountryId AS LocationCityId,
          ms.ParentMessageId AS ParentMessageId
    FROM Comment
    JOIN ms
    ON Comment.id = ms.MessageId))

-- sqlfmt-corpus-separator --

CREATE OR REPLACE MATERIALIZED VIEW PathQ19 AS
WITH
  -- asymmetrize...
  knows_asymmetric AS (
    SELECT person1id, person2id
      FROM Person_knows_person
     WHERE person1id < person2id
  ),
  -- compute interaction scores (no interactions means we ignore that 'knows' relationship)
  weights(src, dst, w) AS (
    SELECT
        person1id AS src,
        person2id AS dst,
        greatest(round(40 - sqrt(count(*)))::bigint, 1) AS w
    FROM Message m1,
         Message m2,
         knows_asymmetric pp
    WHERE pp.person1id = least(m1.creatorpersonid, m2.creatorpersonid)
      AND pp.person2id = greatest(m1.creatorpersonid, m2.creatorpersonid)
      AND m1.parentmessageid = m2.messageid
      AND m1.creatorpersonid <> m2.creatorpersonid
 GROUP BY src, dst
)
-- resymmetrize
SELECT src, dst, w FROM weights
UNION ALL
SELECT dst, src, w FROM weights;

-- sqlfmt-corpus-separator --

CREATE ROLE "materialize@foocorp.io" WITH LOGIN

-- sqlfmt-corpus-separator --

CREATE ROLE additional_role

-- sqlfmt-corpus-separator --

CREATE ROLE bar

-- sqlfmt-corpus-separator --

CREATE ROLE base_role

-- sqlfmt-corpus-separator --

CREATE ROLE external_foo

-- sqlfmt-corpus-separator --

CREATE ROLE foo

-- sqlfmt-corpus-separator --

CREATE ROLE foo CREATECLUSTER

-- sqlfmt-corpus-separator --

CREATE ROLE foo CREATEDB

-- sqlfmt-corpus-separator --

CREATE ROLE foo CREATEROLE

-- sqlfmt-corpus-separator --

CREATE ROLE foo INHERIT INHERIT

-- sqlfmt-corpus-separator --

CREATE ROLE foo NOINHERIT

-- sqlfmt-corpus-separator --

CREATE ROLE group1

-- sqlfmt-corpus-separator --

CREATE ROLE group2

-- sqlfmt-corpus-separator --

CREATE ROLE group2;

-- sqlfmt-corpus-separator --

CREATE ROLE group3

-- sqlfmt-corpus-separator --

CREATE ROLE joe

-- sqlfmt-corpus-separator --

CREATE ROLE joe;

-- sqlfmt-corpus-separator --

CREATE ROLE materialize

-- sqlfmt-corpus-separator --

CREATE ROLE mike

-- sqlfmt-corpus-separator --

CREATE ROLE mz_foo

-- sqlfmt-corpus-separator --

CREATE ROLE mz_system

-- sqlfmt-corpus-separator --

CREATE ROLE nlb

-- sqlfmt-corpus-separator --

CREATE ROLE nonlogin_role

-- sqlfmt-corpus-separator --

CREATE ROLE owner

-- sqlfmt-corpus-separator --

CREATE ROLE parker;

-- sqlfmt-corpus-separator --

CREATE ROLE password_removal_test WITH LOGIN PASSWORD 'initial_password789'

-- sqlfmt-corpus-separator --

CREATE ROLE plan_owner_other

-- sqlfmt-corpus-separator --

CREATE ROLE puBLic

-- sqlfmt-corpus-separator --

CREATE ROLE r1

-- sqlfmt-corpus-separator --

CREATE ROLE r10

-- sqlfmt-corpus-separator --

CREATE ROLE r11

-- sqlfmt-corpus-separator --

CREATE ROLE r12

-- sqlfmt-corpus-separator --

CREATE ROLE r2

-- sqlfmt-corpus-separator --

CREATE ROLE r2;

-- sqlfmt-corpus-separator --

CREATE ROLE r3

-- sqlfmt-corpus-separator --

CREATE ROLE r4

-- sqlfmt-corpus-separator --

CREATE ROLE r5

-- sqlfmt-corpus-separator --

CREATE ROLE r6

-- sqlfmt-corpus-separator --

CREATE ROLE r7

-- sqlfmt-corpus-separator --

CREATE ROLE r8

-- sqlfmt-corpus-separator --

CREATE ROLE r9

-- sqlfmt-corpus-separator --

CREATE ROLE rj

-- sqlfmt-corpus-separator --

CREATE ROLE role_with_password WITH LOGIN PASSWORD 'secure_password123'

-- sqlfmt-corpus-separator --

CREATE ROLE role_without_password

-- sqlfmt-corpus-separator --

CREATE ROLE student;

-- sqlfmt-corpus-separator --

CREATE ROLE teacher;

-- sqlfmt-corpus-separator --

CREATE ROLE test_role

-- sqlfmt-corpus-separator --

CREATE ROLE test_user WITH LOGIN PASSWORD 'secure_password456'

-- sqlfmt-corpus-separator --

CREATE SCHEMA "!\_\""w3😊_weird_name";

-- sqlfmt-corpus-separator --

CREATE SCHEMA "CASE";

-- sqlfmt-corpus-separator --

CREATE SCHEMA "case";

-- sqlfmt-corpus-separator --

CREATE SCHEMA B1

-- sqlfmt-corpus-separator --

CREATE SCHEMA a.foo;

-- sqlfmt-corpus-separator --

CREATE SCHEMA a.green;

-- sqlfmt-corpus-separator --

CREATE SCHEMA a1

-- sqlfmt-corpus-separator --

CREATE SCHEMA amb;

-- sqlfmt-corpus-separator --

CREATE SCHEMA b.blue;

-- sqlfmt-corpus-separator --

CREATE SCHEMA b.foo;

-- sqlfmt-corpus-separator --

CREATE SCHEMA b1

-- sqlfmt-corpus-separator --

CREATE SCHEMA blue;

-- sqlfmt-corpus-separator --

CREATE SCHEMA c.foo;

-- sqlfmt-corpus-separator --

CREATE SCHEMA c1;

-- sqlfmt-corpus-separator --

CREATE SCHEMA comment_on_schema;

-- sqlfmt-corpus-separator --

CREATE SCHEMA d.amb;

-- sqlfmt-corpus-separator --

CREATE SCHEMA d1.s1

-- sqlfmt-corpus-separator --

CREATE SCHEMA d1.s11

-- sqlfmt-corpus-separator --

CREATE SCHEMA d1.sch

-- sqlfmt-corpus-separator --

CREATE SCHEMA d2.s2

-- sqlfmt-corpus-separator --

CREATE SCHEMA d2.s22

-- sqlfmt-corpus-separator --

CREATE SCHEMA d2.sch

-- sqlfmt-corpus-separator --

CREATE SCHEMA d;

-- sqlfmt-corpus-separator --

CREATE SCHEMA db.s

-- sqlfmt-corpus-separator --

CREATE SCHEMA db.sc

-- sqlfmt-corpus-separator --

CREATE SCHEMA dev;

-- sqlfmt-corpus-separator --

CREATE SCHEMA dev_fy2023;

-- sqlfmt-corpus-separator --

CREATE SCHEMA dev_warm;

-- sqlfmt-corpus-separator --

CREATE SCHEMA foo

-- sqlfmt-corpus-separator --

CREATE SCHEMA friend;

-- sqlfmt-corpus-separator --

CREATE SCHEMA grand_friend;

-- sqlfmt-corpus-separator --

CREATE SCHEMA green;

-- sqlfmt-corpus-separator --

CREATE SCHEMA j.k;

-- sqlfmt-corpus-separator --

CREATE SCHEMA j;

-- sqlfmt-corpus-separator --

CREATE SCHEMA jdb.msc_cross;

-- sqlfmt-corpus-separator --

CREATE SCHEMA left_joins;

-- sqlfmt-corpus-separator --

CREATE SCHEMA left_joins_raw;

-- sqlfmt-corpus-separator --

CREATE SCHEMA materialize.sch

-- sqlfmt-corpus-separator --

CREATE SCHEMA msc;

-- sqlfmt-corpus-separator --

CREATE SCHEMA mz_swap;

-- sqlfmt-corpus-separator --

CREATE SCHEMA notices;

-- sqlfmt-corpus-separator --

CREATE SCHEMA other

-- sqlfmt-corpus-separator --

CREATE SCHEMA other;

-- sqlfmt-corpus-separator --

CREATE SCHEMA public ;

-- sqlfmt-corpus-separator --

CREATE SCHEMA public;

-- sqlfmt-corpus-separator --

CREATE SCHEMA s

-- sqlfmt-corpus-separator --

CREATE SCHEMA s0

-- sqlfmt-corpus-separator --

CREATE SCHEMA s1;

-- sqlfmt-corpus-separator --

CREATE SCHEMA s2;

-- sqlfmt-corpus-separator --

CREATE SCHEMA s_rename_metainfo

-- sqlfmt-corpus-separator --

CREATE SCHEMA sch;

-- sqlfmt-corpus-separator --

CREATE SCHEMA schema_a

-- sqlfmt-corpus-separator --

CREATE SCHEMA schema_b

-- sqlfmt-corpus-separator --

CREATE SCHEMA schema_c

-- sqlfmt-corpus-separator --

CREATE SCHEMA swap_s1;

-- sqlfmt-corpus-separator --

CREATE SCHEMA swap_s2;

-- sqlfmt-corpus-separator --

CREATE SCHEMA test.sc1

-- sqlfmt-corpus-separator --

CREATE SCHEMA test.sc2

-- sqlfmt-corpus-separator --

CREATE SCHEMA this_is_a_schema_with_a_super_long_name_of_exactly_255_characters_which_happens_to_be_the_maximum_we_allow_in_materialize_for_identifiers_of_any_kind_including_for_the_schema_name_so_this_should_still_work_perfectly_fine_as_long_as_we_dont_make_it_longer;

-- sqlfmt-corpus-separator --

CREATE SECRET IF NOT EXISTS secret AS decode('c2VjcmV0Cg==', 'base64');

-- sqlfmt-corpus-separator --

CREATE SECRET byte_secret as 'text'::bytea;

-- sqlfmt-corpus-separator --

CREATE SECRET d1.s1.se AS decode('c2VjcmV0Cg==', 'base64')

-- sqlfmt-corpus-separator --

CREATE SECRET d1.s11.se AS decode('c2VjcmV0Cg==', 'base64')

-- sqlfmt-corpus-separator --

CREATE SECRET d2.s2.se AS decode('c2VjcmV0Cg==', 'base64')

-- sqlfmt-corpus-separator --

CREATE SECRET d2.s22.se AS decode('c2VjcmV0Cg==', 'base64')

-- sqlfmt-corpus-separator --

CREATE SECRET existing AS decode('c2VjcmV0Cg==', 'base64');

-- sqlfmt-corpus-separator --

CREATE SECRET id_pool_secret AS 'sekret'

-- sqlfmt-corpus-separator --

CREATE SECRET int_secret as 123456

-- sqlfmt-corpus-separator --

CREATE SECRET invalid_cert AS '\x80';

-- sqlfmt-corpus-separator --

CREATE SECRET key AS decode('c2VjcmV0Cg==', 'base64');

-- sqlfmt-corpus-separator --

CREATE SECRET materialize.public.se AS decode('c2VjcmV0Cg==', 'base64')

-- sqlfmt-corpus-separator --

CREATE SECRET mse AS decode('c2VjcmV0Cg==', 'base64');

-- sqlfmt-corpus-separator --

CREATE SECRET my_secret AS 'foobar';

-- sqlfmt-corpus-separator --

CREATE SECRET null_secret as NULL

-- sqlfmt-corpus-separator --

CREATE SECRET other_secret AS 'another_one';

-- sqlfmt-corpus-separator --

CREATE SECRET pgpass AS 'postgres'

-- sqlfmt-corpus-separator --

CREATE SECRET rectype AS 'ignored'

-- sqlfmt-corpus-separator --

CREATE SECRET rectype_sneaky AS 'ignored'

-- sqlfmt-corpus-separator --

CREATE SECRET roundtrip AS decode(encode('supersecret', 'base64') , 'base64');

-- sqlfmt-corpus-separator --

CREATE SECRET s3_api_secret_key as 'secret_key';

-- sqlfmt-corpus-separator --

CREATE SECRET se AS decode('c2VjcmV0Cg==', 'base64');

-- sqlfmt-corpus-separator --

CREATE SECRET secret AS decode('c2VjcmV0Cg==', 'base64');

-- sqlfmt-corpus-separator --

CREATE SECRET t1 AS decode('c2VjcmV0Cg==', 'base64');

-- sqlfmt-corpus-separator --

CREATE SECRET testschema.key AS decode('c2VjcmV0Cg==', 'base64');

-- sqlfmt-corpus-separator --

CREATE SECRET text_secret as 'text'

-- sqlfmt-corpus-separator --

CREATE SECRET to_be_dropped.secret1 as 'text'

-- sqlfmt-corpus-separator --

CREATE SECRET to_be_dropped.secret2 as 'text'

-- sqlfmt-corpus-separator --

CREATE SECRET to_be_dropped.secret3 as 'text'

-- sqlfmt-corpus-separator --

CREATE SECRET webhook_shared_secret AS 'test_key';

-- sqlfmt-corpus-separator --

CREATE SOURCE "weird-name-(]%/'" IN CLUSTER webhook_cluster FROM WEBHOOK BODY FORMAT BYTES

-- sqlfmt-corpus-separator --

CREATE SOURCE IF NOT EXISTS webhook_text_include_headers IN CLUSTER webhook_cluster FROM WEBHOOK
    BODY FORMAT TEXT
    INCLUDE HEADERS

-- sqlfmt-corpus-separator --

CREATE SOURCE auction_house FROM LOAD GENERATOR AUCTION

-- sqlfmt-corpus-separator --

CREATE SOURCE blue.ctr FROM LOAD GENERATOR COUNTER;

-- sqlfmt-corpus-separator --

CREATE SOURCE counter FROM LOAD GENERATOR COUNTER

-- sqlfmt-corpus-separator --

CREATE SOURCE counter IN CLUSTER test FROM LOAD GENERATOR COUNTER

-- sqlfmt-corpus-separator --

CREATE SOURCE counter_src FROM LOAD GENERATOR COUNTER;

-- sqlfmt-corpus-separator --

CREATE SOURCE d1.s1.s FROM LOAD GENERATOR COUNTER

-- sqlfmt-corpus-separator --

CREATE SOURCE d1.s11.s FROM LOAD GENERATOR COUNTER

-- sqlfmt-corpus-separator --

CREATE SOURCE d2.s2.s FROM LOAD GENERATOR COUNTER

-- sqlfmt-corpus-separator --

CREATE SOURCE d2.s22.s FROM LOAD GENERATOR COUNTER

-- sqlfmt-corpus-separator --

CREATE SOURCE emp_src FROM LOAD GENERATOR COUNTER

-- sqlfmt-corpus-separator --

CREATE SOURCE ldgen IN CLUSTER c FROM LOAD GENERATOR COUNTER (TICK INTERVAL '1s');

-- sqlfmt-corpus-separator --

CREATE SOURCE loadgen IN CLUSTER foo FROM LOAD GENERATOR COUNTER

-- sqlfmt-corpus-separator --

CREATE SOURCE low_rh FROM LOAD GENERATOR COUNTER WITH (RETAIN HISTORY FOR '0')

-- sqlfmt-corpus-separator --

CREATE SOURCE low_rh FROM LOAD GENERATOR COUNTER WITH (RETAIN HISTORY FOR '1ms')

-- sqlfmt-corpus-separator --

CREATE SOURCE materialize.public.s FROM LOAD GENERATOR COUNTER

-- sqlfmt-corpus-separator --

CREATE SOURCE ms FROM LOAD GENERATOR COUNTER;

-- sqlfmt-corpus-separator --

CREATE SOURCE multiplex FROM LOAD GENERATOR AUCTION;

-- sqlfmt-corpus-separator --

CREATE SOURCE my_webhook IN CLUSTER comment_cluster FROM WEBHOOK BODY FORMAT TEXT;

-- sqlfmt-corpus-separator --

CREATE SOURCE rectype FROM LOAD GENERATOR COUNTER

-- sqlfmt-corpus-separator --

CREATE SOURCE rectype_sneaky_s FROM LOAD GENERATOR COUNTER

-- sqlfmt-corpus-separator --

CREATE SOURCE s FROM LOAD GENERATOR AUCTION

-- sqlfmt-corpus-separator --

CREATE SOURCE s FROM LOAD GENERATOR AUCTION;

-- sqlfmt-corpus-separator --

CREATE SOURCE s FROM LOAD GENERATOR COUNTER

-- sqlfmt-corpus-separator --

CREATE SOURCE s FROM LOAD GENERATOR COUNTER WITH (RETAIN HISTORY FOR '5m')

-- sqlfmt-corpus-separator --

CREATE SOURCE s FROM LOAD GENERATOR COUNTER;

-- sqlfmt-corpus-separator --

CREATE SOURCE s1 FROM LOAD GENERATOR COUNTER;

-- sqlfmt-corpus-separator --

CREATE SOURCE s2 FROM LOAD GENERATOR COUNTER;

-- sqlfmt-corpus-separator --

CREATE SOURCE tpch
              FROM LOAD GENERATOR TPCH (SCALE FACTOR 0.00001);

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_bad_validation_expr IN CLUSTER webhook_cluster FROM WEBHOOK
    BODY FORMAT TEXT
    CHECK (
        WITH (HEADERS)
        decode(headers->'signature', 'base64') = hmac(field_that_does_not_exist, 'key', 'sha256')
    )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_bad_validation_expr IN CLUSTER webhook_cluster FROM WEBHOOK
    BODY FORMAT TEXT
    CHECK (
        WITH (HEADERS, BODY)
        decode(headers->'signature', 'base64') = hmac(headers->'timestamp' || '.' || body, 'key', 'sha256')
    )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_buildkite IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT JSON
  CHECK (
    WITH (HEADERS, BODY BYTES)
    decode(split_part(headers->'x-buildkite-signature', 'signature=', 1), 'hex') = hmac(
      split_part(split_part(headers->'x-buildkite-signature', 'timestamp=', 1), ',', 1) || '.' || convert_from(body, 'utf-8'),
      'test_key',
      'sha256'
    )
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_buildkite2 IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT JSON
  CHECK (
    WITH ( HEADERS, BODY, SECRET webhook_shared_secret )
    decode(split_part(headers->'x-buildkite-signature', 'signature=', 1), 'hex') = hmac(
      split_part(split_part(headers->'x-buildkite-signature', 'timestamp=', 1), ',', 1) || '.' || body,
      webhook_shared_secret,
      'sha256'
    )
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_bytes IN CLUSTER webhook_cluster FROM WEBHOOK
    BODY FORMAT BYTES

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_bytes_include_headers IN CLUSTER webhook_cluster FROM WEBHOOK
    BODY FORMAT BYTES
    INCLUDE HEADERS

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_cluster_does_not_exist IN CLUSTER i_do_not_exist FROM WEBHOOK
  BODY FORMAT BYTES;

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_json IN CLUSTER webhook_cluster FROM WEBHOOK
    BODY FORMAT JSON

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_json_include_headers IN CLUSTER webhook_cluster FROM WEBHOOK
    BODY FORMAT JSON
    INCLUDE HEADERS

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_json_with_validation IN CLUSTER webhook_cluster FROM WEBHOOK
    BODY FORMAT JSON
    CHECK ( 'a' = 'test' )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_on_cluster1 IN CLUSTER cluster1 FROM WEBHOOK
  BODY FORMAT BYTES;

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_text IN CLUSTER webhook_cluster FROM WEBHOOK
    BODY FORMAT TEXT

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_text_include_headers IN CLUSTER webhook_cluster FROM WEBHOOK
    BODY FORMAT TEXT
    INCLUDE HEADERS

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_text_mapped_and_filtered_headers IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT TEXT
  INCLUDE HEADER 'x-hash' as hash BYTES
  INCLUDE HEADER 'content-type' as content_type
  INCLUDE HEADERS ('x-special-header')

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_text_with_duplicate_header_alias IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT TEXT
  INCLUDE HEADER 'x-first-header' as header_a
  INCLUDE HEADER 'x-second-header' as header_a

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_text_with_header_alias_as_body IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT TEXT
  INCLUDE HEADER 'x-my-header' as body

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_text_with_mapped_headers IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT TEXT
  INCLUDE HEADER 'x-special-header' AS "specialHeader"
  INCLUDE HEADER 'x-hash' AS hash BYTES
  INCLUDE HEADER 'content-type' AS content_type

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_validation_returns_non_bool IN CLUSTER webhook_cluster FROM WEBHOOK
    BODY FORMAT TEXT
    CHECK ( 'foo' || 'bar' )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_validation_with_current_db IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT BYTES
  CHECK (
    WITH (HEADERS)
    headers->'database' = current_database()
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_validation_with_current_timestamp IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT BYTES
  CHECK (
    WITH (HEADERS)
    headers->'event_ts' = current_timestamp()::text
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_validation_with_mz_now IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT BYTES
  CHECK (
    WITH (HEADERS)
    headers->'event_ts' = mz_now()::text
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_validation_with_now IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT BYTES
  CHECK (
    WITH (HEADERS)
    (headers->'event_ts'::text)::timestamp + INTERVAL '30s' >= now()
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_validation_with_subquery IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT BYTES
  CHECK (
    WITH (HEADERS)
    headers->'signature' IN (select * from mz_tables)
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_with_body_duplicates IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT TEXT
  CHECK (
    WITH (BODY, BODY)
    length(body) > 0
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_with_duplicate_aliases IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT TEXT
  CHECK (
    WITH (HEADERS as x, BODY as x)
    length(x) > 0
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_with_duplicate_secret_names IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT BYTES
  CHECK (
    WITH (
      HEADERS, BODY,
      SECRET webhook_shared_secret AS other_secret,
      SECRET other_secret
    )
    headers->'signature' = other_secret AND body = other_secret
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_with_headers_and_body_alias IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT TEXT
  CHECK (
    WITH (
      HEADERS AS h1 BYTES,
      HEADERS,
      BODY AS b1,
      BODY BYTES
    )
    headers->'signature' = convert_from(h1->'signature', 'utf-8') AND b1 = convert_from(body, 'utf-8')
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_with_headers_duplicates IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT TEXT
  CHECK (
    WITH (HEADERS, HEADERS)
    HEADERS->'signature' = '42'
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_with_secret IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT BYTES
  CHECK (
    WITH ( HEADERS, SECRET webhook_shared_secret )
    headers->'signature' = webhook_shared_secret
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_with_two_secrets IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT BYTES
  CHECK (
    WITH (
      HEADERS, BODY BYTES,
      SECRET webhook_shared_secret AS key,
      SECRET other_secret BYTES
    )
    headers->'signature' = key AND body = other_secret
  )

-- sqlfmt-corpus-separator --

CREATE SOURCE webhook_with_unknown_second_secret IN CLUSTER webhook_cluster FROM WEBHOOK
  BODY FORMAT BYTES
  CHECK (
    WITH (
      HEADERS, BODY,
      SECRET webhook_shared_secret AS key,
      SECRET non_existent_secret
    )
    headers->'signature' = key AND body = non_existent_secret
  )

-- sqlfmt-corpus-separator --

CREATE SUBSOURCE "materialize"."public"."subsource" ();

-- sqlfmt-corpus-separator --

CREATE TABLE accounts FROM SOURCE auction_house (REFERENCE accounts);

-- sqlfmt-corpus-separator --

CREATE TABLE accounts FROM SOURCE multiplex (REFERENCE accounts);

-- sqlfmt-corpus-separator --

CREATE TABLE accounts FROM SOURCE s (REFERENCE accounts);

-- sqlfmt-corpus-separator --

CREATE TABLE auctions FROM SOURCE auction_house (REFERENCE auctions);

-- sqlfmt-corpus-separator --

CREATE TABLE auctions FROM SOURCE multiplex (REFERENCE auctions);

-- sqlfmt-corpus-separator --

CREATE TABLE auctions FROM SOURCE s (REFERENCE auctions);

-- sqlfmt-corpus-separator --

CREATE TABLE bids FROM SOURCE auction_house (REFERENCE bids);

-- sqlfmt-corpus-separator --

CREATE TABLE bids FROM SOURCE multiplex (REFERENCE bids);

-- sqlfmt-corpus-separator --

CREATE TABLE bids FROM SOURCE s (REFERENCE bids);

-- sqlfmt-corpus-separator --

CREATE TABLE counter FROM SOURCE counter_src;

-- sqlfmt-corpus-separator --

CREATE TABLE counter_tbl FROM SOURCE counter

-- sqlfmt-corpus-separator --

CREATE TABLE customer FROM SOURCE tpch (REFERENCE customer);

-- sqlfmt-corpus-separator --

CREATE TABLE employees_from_src FROM SOURCE emp_src

-- sqlfmt-corpus-separator --

CREATE TABLE lineitem FROM SOURCE tpch (REFERENCE lineitem);

-- sqlfmt-corpus-separator --

CREATE TABLE nation FROM SOURCE tpch (REFERENCE nation);

-- sqlfmt-corpus-separator --

CREATE TABLE orders FROM SOURCE tpch (REFERENCE orders);

-- sqlfmt-corpus-separator --

CREATE TABLE organizations FROM SOURCE auction_house (REFERENCE organizations);

-- sqlfmt-corpus-separator --

CREATE TABLE organizations FROM SOURCE multiplex (REFERENCE organizations);

-- sqlfmt-corpus-separator --

CREATE TABLE organizations FROM SOURCE s (REFERENCE organizations);

-- sqlfmt-corpus-separator --

CREATE TABLE part FROM SOURCE tpch (REFERENCE part);

-- sqlfmt-corpus-separator --

CREATE TABLE partsupp FROM SOURCE tpch (REFERENCE partsupp);

-- sqlfmt-corpus-separator --

CREATE TABLE region FROM SOURCE tpch (REFERENCE region);

-- sqlfmt-corpus-separator --

CREATE TABLE supplier FROM SOURCE tpch (REFERENCE supplier);

-- sqlfmt-corpus-separator --

CREATE TABLE users FROM SOURCE auction_house (REFERENCE users);

-- sqlfmt-corpus-separator --

CREATE TABLE users FROM SOURCE multiplex (REFERENCE users);

-- sqlfmt-corpus-separator --

CREATE TABLE users FROM SOURCE s (REFERENCE users);

-- sqlfmt-corpus-separator --

CREATE TYPE array_length AS LIST (ELEMENT TYPE = int4);

-- sqlfmt-corpus-separator --

CREATE TYPE bool AS LIST (ELEMENT TYPE=int4)

-- sqlfmt-corpus-separator --

CREATE TYPE bool AS MAP (KEY TYPE = text, VALUE TYPE = int4)

-- sqlfmt-corpus-separator --

CREATE TYPE bool_list_c AS LIST (ELEMENT TYPE=bool);

-- sqlfmt-corpus-separator --

CREATE TYPE bool_map_c AS MAP (KEY TYPE = text, VALUE TYPE = bool);

-- sqlfmt-corpus-separator --

CREATE TYPE composite AS (a int, b text, c float8);

-- sqlfmt-corpus-separator --

CREATE TYPE custom AS MAP (KEY TYPE = text)

-- sqlfmt-corpus-separator --

CREATE TYPE custom AS MAP (KEY TYPE = text, VALUE TYPE = bool)

-- sqlfmt-corpus-separator --

CREATE TYPE custom AS MAP (VALUE TYPE = bool)

-- sqlfmt-corpus-separator --

CREATE TYPE custom_composite AS (i int);

-- sqlfmt-corpus-separator --

CREATE TYPE custom_list_type AS LIST (ELEMENT TYPE = custom_type)

-- sqlfmt-corpus-separator --

CREATE TYPE custom_map_type AS MAP (KEY TYPE = text, VALUE TYPE = custom_type)

-- sqlfmt-corpus-separator --

CREATE TYPE custom_type AS (x integer, y int4_list);

-- sqlfmt-corpus-separator --

CREATE TYPE d.public.t AS LIST (ELEMENT TYPE = int4);

-- sqlfmt-corpus-separator --

CREATE TYPE d1.s1.ty as (a int)

-- sqlfmt-corpus-separator --

CREATE TYPE d1.s11.ty as (a int)

-- sqlfmt-corpus-separator --

CREATE TYPE d2.s2.ty as (a int)

-- sqlfmt-corpus-separator --

CREATE TYPE d2.s22.ty as (a int)

-- sqlfmt-corpus-separator --

CREATE TYPE date_list_c AS LIST (ELEMENT TYPE=date);

-- sqlfmt-corpus-separator --

CREATE TYPE date_map_c AS MAP (KEY TYPE = text, VALUE TYPE = date);

-- sqlfmt-corpus-separator --

CREATE TYPE float4_list_c AS LIST (ELEMENT TYPE=float4);

-- sqlfmt-corpus-separator --

CREATE TYPE float4_map_c AS MAP (KEY TYPE = text, VALUE TYPE = float4);

-- sqlfmt-corpus-separator --

CREATE TYPE float8_list_c AS LIST (ELEMENT TYPE=float8);

-- sqlfmt-corpus-separator --

CREATE TYPE float8_map_c AS MAP (KEY TYPE = text, VALUE TYPE = float8);

-- sqlfmt-corpus-separator --

CREATE TYPE id_pool_ty1 AS LIST (ELEMENT TYPE = INT4)

-- sqlfmt-corpus-separator --

CREATE TYPE int4 AS (a int)

-- sqlfmt-corpus-separator --

CREATE TYPE int4_list AS LIST (ELEMENT TYPE = int4)

-- sqlfmt-corpus-separator --

CREATE TYPE int4_list AS LIST (ELEMENT TYPE = int4);

-- sqlfmt-corpus-separator --

CREATE TYPE int4_list_c AS LIST (ELEMENT TYPE = int4);

-- sqlfmt-corpus-separator --

CREATE TYPE int4_list_list AS LIST (ELEMENT TYPE = int4_list)

-- sqlfmt-corpus-separator --

CREATE TYPE int4_list_list_c AS LIST (ELEMENT TYPE = int4_list_c);

-- sqlfmt-corpus-separator --

CREATE TYPE int4_list_list_too AS LIST (ELEMENT TYPE = int4_list_too)

-- sqlfmt-corpus-separator --

CREATE TYPE int4_list_too AS LIST (ELEMENT TYPE = int4)

-- sqlfmt-corpus-separator --

CREATE TYPE int4_map AS MAP (KEY TYPE = text, VALUE TYPE = int4);

-- sqlfmt-corpus-separator --

CREATE TYPE int4_map_c AS MAP (KEY TYPE = text, VALUE TYPE = int4);

-- sqlfmt-corpus-separator --

CREATE TYPE int4_named_list AS LIST (ELEMENT TYPE = int4);

-- sqlfmt-corpus-separator --

CREATE TYPE int8_list_c AS LIST (ELEMENT TYPE=int8);

-- sqlfmt-corpus-separator --

CREATE TYPE int8_map_c AS MAP (KEY TYPE = text, VALUE TYPE = int8);

-- sqlfmt-corpus-separator --

CREATE TYPE int_key AS (f1 INT, f2 INT);

-- sqlfmt-corpus-separator --

CREATE TYPE int_list AS LIST (ELEMENT TYPE = int4);

-- sqlfmt-corpus-separator --

CREATE TYPE int_list AS MAP (KEY TYPE = pg_catalog.text, VALUE TYPE = int)

-- sqlfmt-corpus-separator --

CREATE TYPE int_map AS MAP (KEY TYPE = pg_catalog.text, VALUE TYPE = int)

-- sqlfmt-corpus-separator --

CREATE TYPE interval_list_c AS LIST (ELEMENT TYPE=interval);

-- sqlfmt-corpus-separator --

CREATE TYPE interval_map_c AS MAP (KEY TYPE = text, VALUE TYPE = interval);

-- sqlfmt-corpus-separator --

CREATE TYPE jsonb_list_c AS LIST (ELEMENT TYPE=jsonb);

-- sqlfmt-corpus-separator --

CREATE TYPE jsonb_map_c AS MAP (KEY TYPE = text, VALUE TYPE = jsonb);

-- sqlfmt-corpus-separator --

CREATE TYPE l AS (f1 TEXT, f2 int_list);

-- sqlfmt-corpus-separator --

CREATE TYPE l AS LIST (ELEMENT TYPE = int)

-- sqlfmt-corpus-separator --

CREATE TYPE list_numeric_scale_2 AS LIST (ELEMENT TYPE = NUMERIC(38,2));

-- sqlfmt-corpus-separator --

CREATE TYPE m AS MAP (KEY TYPE = text, VALUE TYPE = int)

-- sqlfmt-corpus-separator --

CREATE TYPE materialize.public.ty as (a int)

-- sqlfmt-corpus-separator --

CREATE TYPE melange AS (a int[][], b text[], c int4_list, d int4_map);

-- sqlfmt-corpus-separator --

CREATE TYPE missing_value AS (f1 TEXT);

-- sqlfmt-corpus-separator --

CREATE TYPE mty AS LIST (ELEMENT TYPE=bool);

-- sqlfmt-corpus-separator --

CREATE TYPE nested_list AS LIST (ELEMENT TYPE = "bool list")

-- sqlfmt-corpus-separator --

CREATE TYPE nested_list AS LIST (ELEMENT TYPE = list)

-- sqlfmt-corpus-separator --

CREATE TYPE numeric_list_c AS LIST (ELEMENT TYPE=numeric);

-- sqlfmt-corpus-separator --

CREATE TYPE numeric_map_c AS MAP (KEY TYPE = text, VALUE TYPE = numeric);

-- sqlfmt-corpus-separator --

CREATE TYPE other.composite AS (a text, b text, c float8);

-- sqlfmt-corpus-separator --

CREATE TYPE qualified_int4_list AS LIST (ELEMENT TYPE=pg_catalog.int4)

-- sqlfmt-corpus-separator --

CREATE TYPE qualified_int4_map AS MAP (KEY TYPE = pg_catalog.text, VALUE TYPE = pg_catalog.int4)

-- sqlfmt-corpus-separator --

CREATE TYPE qualified_qualified_int4_list AS LIST (ELEMENT TYPE=public.qualified_int4_list)

-- sqlfmt-corpus-separator --

CREATE TYPE qualified_qualified_int4_map AS MAP (KEY TYPE = pg_catalog.text, VALUE TYPE = public.qualified_int4_map)

-- sqlfmt-corpus-separator --

CREATE TYPE r AS (a int)

-- sqlfmt-corpus-separator --

CREATE TYPE r AS (f1 TEXT, f2 INT);

-- sqlfmt-corpus-separator --

CREATE TYPE rectype AS (a int)

-- sqlfmt-corpus-separator --

CREATE TYPE s.t AS LIST (ELEMENT TYPE = int4);

-- sqlfmt-corpus-separator --

CREATE TYPE scoping_composite AS (i int);

-- sqlfmt-corpus-separator --

CREATE TYPE t AS (x float, y text);

-- sqlfmt-corpus-separator --

CREATE TYPE t AS LIST (ELEMENT TYPE = int4);

-- sqlfmt-corpus-separator --

CREATE TYPE tbl_list AS LIST (ELEMENT TYPE=pg_enum)

-- sqlfmt-corpus-separator --

CREATE TYPE tbl_map AS MAP (KEY TYPE = pg_enum, VALUE TYPE = text)

-- sqlfmt-corpus-separator --

CREATE TYPE tbl_map AS MAP (KEY TYPE = text, VALUE TYPE = pg_enum)

-- sqlfmt-corpus-separator --

CREATE TYPE text_list AS LIST (ELEMENT TYPE = text);

-- sqlfmt-corpus-separator --

CREATE TYPE text_list_c AS LIST (ELEMENT TYPE=text);

-- sqlfmt-corpus-separator --

CREATE TYPE text_map_c AS MAP (KEY TYPE = text, VALUE TYPE = text);

-- sqlfmt-corpus-separator --

CREATE TYPE time_list_c AS LIST (ELEMENT TYPE=time);

-- sqlfmt-corpus-separator --

CREATE TYPE time_map_c AS MAP (KEY TYPE = text, VALUE TYPE = time);

-- sqlfmt-corpus-separator --

CREATE TYPE timestamp_list_c AS LIST (ELEMENT TYPE=timestamp);

-- sqlfmt-corpus-separator --

CREATE TYPE timestamp_map_c AS MAP (KEY TYPE = text, VALUE TYPE = timestamp);

-- sqlfmt-corpus-separator --

CREATE TYPE timestamptz_list_c AS LIST (ELEMENT TYPE=timestamptz);

-- sqlfmt-corpus-separator --

CREATE TYPE timestamptz_map_c AS MAP (KEY TYPE = text, VALUE TYPE = timestamptz);

-- sqlfmt-corpus-separator --

CREATE TYPE ty AS LIST (ELEMENT TYPE = int4);

-- sqlfmt-corpus-separator --

CREATE TYPE ty AS LIST (ELEMENT TYPE=bool)

-- sqlfmt-corpus-separator --

CREATE TYPE ty AS LIST (ELEMENT TYPE=bool);

-- sqlfmt-corpus-separator --

CREATE TYPE unnamed_element_list AS LIST (ELEMENT TYPE=int4 list)

-- sqlfmt-corpus-separator --

CREATE TYPE unnamed_element_map AS MAP (KEY TYPE = text, VALUE TYPE = int4 list)

-- sqlfmt-corpus-separator --

CREATE TYPE y1 AS (
    "id" int4,
    "name" text,
    "num" numeric(3, 1),
    "updatedAt" timestamp(3)
)

-- sqlfmt-corpus-separator --

CREATE TYPE y2 AS LIST (ELEMENT TYPE = timestamp(2))

-- sqlfmt-corpus-separator --

CREATE TYPE y3 AS MAP (KEY TYPE = text, VALUE TYPE = numeric(5, 2))

-- sqlfmt-corpus-separator --

CREATE TYPE y4 AS MAP (KEY TYPE = text, VALUE TYPE = y3)

-- sqlfmt-corpus-separator --

CREATE VIEW PathQ19 AS
WITH
  -- asymmetrize...
  knows_asymmetric AS (
    SELECT person1id, person2id
      FROM Person_knows_person
     WHERE person1id < person2id
  ),
  -- compute interaction scores (no interactions means we ignore that 'knows' relationship)
  weights(src, dst, w) AS (
    SELECT
        person1id AS src,
        person2id AS dst,
        greatest(round(40 - sqrt(count(*)))::bigint, 1) AS w
    FROM Message m1,
         Message m2,
         knows_asymmetric pp
    WHERE pp.person1id = least(m1.creatorpersonid, m2.creatorpersonid)
      AND pp.person2id = greatest(m1.creatorpersonid, m2.creatorpersonid)
      AND m1.parentmessageid = m2.messageid
      AND m1.creatorpersonid <> m2.creatorpersonid
 GROUP BY src, dst
)
-- resymmetrize
SELECT src, dst, w FROM weights
UNION ALL
SELECT dst, src, w FROM weights;

-- sqlfmt-corpus-separator --

CREATE VIEW category_totals AS
WITH MUTUALLY RECURSIVE
  rollup(category_id int, total numeric(20,10), item_count int) AS (
    -- Base: calculate each category's direct total and item count
    SELECT
      c.category_id,
      COALESCE(SUM(d.price), 0)::numeric(20,10),
      COUNT(d.price)
    FROM categories c
    LEFT JOIN dynamic_price_shopping_cart d
      ON c.category_id = d.category_id
    GROUP BY c.category_id
    UNION ALL
    -- Recursive: bubble each category's totals upward to its parent
    SELECT
      c.parent_id,
      r.total,
      r.item_count
    FROM rollup r
    JOIN categories c
      ON r.category_id = c.category_id
    WHERE c.parent_id IS NOT NULL
  ),
  totals(category_id int, total numeric(20,10), item_count int) AS (
    SELECT
      c.category_id,
      SUM(r.total)::numeric(20,10) AS total,
      SUM(r.item_count) AS item_count
    FROM categories c
    JOIN rollup r
      ON c.category_id = r.category_id
    GROUP BY c.category_id
    HAVING SUM(r.item_count) > 0  -- only include categories with items
  ),
  has_subcategories(category_id int, has_subcategory boolean) AS (
    SELECT
      a.category_id,
      count(*) FILTER (WHERE b.parent_id IS NOT NULL) > 0 AS has_subcategory
    FROM categories a
    LEFT JOIN categories b ON a.category_id = b.parent_id
    GROUP BY a.category_id
  )
SELECT
  t.category_id,
  c.parent_id,
  s.has_subcategory,
  c.category_name,
  t.total,
  t.item_count
FROM totals t
JOIN categories c USING (category_id)
JOIN has_subcategories s USING (category_id);

-- sqlfmt-corpus-separator --

CREATE VIEW ldbc_q19 AS
WITH MUTUALLY RECURSIVE
  -- Source and destination identifiers, which do not evolve recursively.
  srcs (f bigint) AS (SELECT id FROM Person WHERE locationcityid = 655::bigint),
  dsts (t bigint) AS (SELECT id FROM Person WHERE locationcityid = 1138::bigint),
  -- Only work off of nodes not more than half a viable path.
  active_forward(src bigint, dst bigint, w double precision) AS (
    SELECT * FROM forward WHERE coalesce (w < (SELECT w/2 FROM shortest), true)
  ),
  forward (src bigint, dst bigint, w double precision) AS (
    SELECT DISTINCT ON (src, dst) src, dst, w
    FROM (
      SELECT f as src, f as dst, 0.0 as w FROM srcs
      UNION ALL
      SELECT f.src, p.dst, f.w + p.w
      FROM active_forward f, PathQ19 p
      WHERE f.dst = p.src
    )
    ORDER BY src, dst, w
  ),
  -- Only work off of nodes not more than half a viable path.
  active_reverse(src bigint, dst bigint, w double precision) AS (
    SELECT * FROM reverse WHERE coalesce (w < (SELECT w/2 FROM shortest), true)
  ),
  reverse (src bigint, dst bigint, w double precision) AS (
    SELECT DISTINCT ON (src, dst) src, dst, w
    FROM (
      SELECT t as src, t as dst, 0.0 as w FROM dsts
      UNION ALL
      SELECT r.src, p.dst, r.w + p.w
      FROM active_reverse r, PathQ19 p
      WHERE r.dst = p.src
    )
    ORDER BY src, dst, w
  ),
  -- Once we find a path from `f` to `t` it appears here.
  paths (f bigint, t bigint, w double precision) AS (
    SELECT l.src as f, r.src as t, min(l.w + r.w) AS w
    FROM forward l, reverse r
    WHERE l.dst = r.dst
    GROUP BY l.src, r.src
  ),
  shortest (w double precision) AS (
    SELECT min(w) FROM paths
  )
SELECT f, t, w
FROM paths
WHERE w = (SELECT MIN(w) FROM paths);

-- sqlfmt-corpus-separator --

CREATE VIEW strongly_connected_components AS
WITH MUTUALLY RECURSIVE
    intra_edges (src int, dst int) as (
        SELECT * FROM edges
        EXCEPT ALL
        SELECT * FROM edges_delayed
        UNION ALL
        SELECT src, dst
        FROM
            edges,
            forward_labels f_src,
            forward_labels f_dst,
            reverse_labels r_src,
            reverse_labels r_dst
        WHERE src = f_src.node
            AND src = r_src.node
            AND dst = f_dst.node
            AND dst = r_dst.node
            AND f_src.label = f_dst.label
            AND r_src.label = r_dst.label
    ),
    forward_labels (node int, label int) AS (
        WITH MUTUALLY RECURSIVE
            label (node int, comp int) AS (
                SELECT dst, MIN(comp)
                FROM (
                    SELECT dst, dst AS comp FROM edges
                    UNION ALL
                    SELECT intra_edges.dst, label.comp
                    FROM intra_edges, label
                    WHERE intra_edges.src = label.node
                )
                GROUP BY dst
            )
        SELECT * FROM label
    ),
    reverse_labels (node int, label int) AS (
        WITH MUTUALLY RECURSIVE
            label (node int, comp int) AS (
                SELECT src, MIN(comp)
                FROM (
                    SELECT src, src AS comp FROM edges
                    UNION ALL
                    SELECT intra_edges.src, label.comp
                    FROM intra_edges, label
                    WHERE intra_edges.dst = label.node
                )
                GROUP BY src
            )
        SELECT * FROM label
    ),
    edges_delayed (src int, dst int) AS (SELECT * FROM edges)
SELECT * FROM forward_labels UNION SELECT * FROM reverse_labels;

-- sqlfmt-corpus-separator --

CREATE VIEW v1 AS
WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 2)
  cnt (f1 INTEGER) AS (
    SELECT f1 FROM t1 UNION ALL SELECT f1+1 AS f1 FROM cnt
  )
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

CREATE schema bar

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE (SELECT 1)

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE (SELECT 1) AS OF 42

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE (SELECT 1/a FROM t)

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE events AS OF 0

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE mv

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t ENVELOPE DEBEZIUM (KEY (a))

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t ENVELOPE DEBEZIUM (KEY (b))

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t ENVELOPE UPSERT (KEY (a))

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t ENVELOPE UPSERT (KEY (a)) WITH (PROGRESS)

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t ENVELOPE UPSERT (KEY (b))

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t WITH (PROGRESS)

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t WITH (PROGRESS) ENVELOPE DEBEZIUM (KEY (a))

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t WITH (PROGRESS) ENVELOPE UPSERT (KEY (a))

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t WITH (PROGRESS) WITHIN TIMESTAMP ORDER BY a, mz_diff

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t WITHIN TIMESTAMP ORDER BY a, mz_diff

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t2 ENVELOPE DEBEZIUM (KEY (b))

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE t2 ENVELOPE DEBEZIUM (KEY (c, b))

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR SUBSCRIBE v

-- sqlfmt-corpus-separator --

DECLARE c CURSOR FOR VALUES (1), (2), (3)

-- sqlfmt-corpus-separator --

DECLARE c2 CURSOR FOR SUBSCRIBE TO (SHOW CLUSTER REPLICAS);

-- sqlfmt-corpus-separator --

DROP OWNED BY materialize

-- sqlfmt-corpus-separator --

DROP OWNED BY materialize CASCADE

-- sqlfmt-corpus-separator --

DROP OWNED BY r1

-- sqlfmt-corpus-separator --

EXECUTE a(1)

-- sqlfmt-corpus-separator --

EXECUTE a(2)

-- sqlfmt-corpus-separator --

EXECUTE b(3)

-- sqlfmt-corpus-separator --

EXECUTE fizz_paginated(4, 2*4);

-- sqlfmt-corpus-separator --

EXECUTE fizz_paginated(4::bigint, 0*4);

-- sqlfmt-corpus-separator --

EXECUTE fizz_paginated(4::bigint, 1*4);

-- sqlfmt-corpus-separator --

EXECUTE fizz_paginated(4::bigint, 2*4);

-- sqlfmt-corpus-separator --

EXECUTE i1(5);

-- sqlfmt-corpus-separator --

EXECUTE i2(7);

-- sqlfmt-corpus-separator --

EXECUTE i3('x');

-- sqlfmt-corpus-separator --

EXECUTE p1('aaa');

-- sqlfmt-corpus-separator --

EXECUTE p1(0);

-- sqlfmt-corpus-separator --

EXECUTE p1(0.4);

-- sqlfmt-corpus-separator --

EXECUTE p1(0.6);

-- sqlfmt-corpus-separator --

EXECUTE p1(1);

-- sqlfmt-corpus-separator --

EXECUTE p1(1+1);

-- sqlfmt-corpus-separator --

EXECUTE p1(5);

-- sqlfmt-corpus-separator --

EXECUTE p1(coalesce(null + 5, 7 + null));

-- sqlfmt-corpus-separator --

EXECUTE p1(null::bigint);

-- sqlfmt-corpus-separator --

EXECUTE p2(0, 0);

-- sqlfmt-corpus-separator --

EXECUTE p2(0, 1);

-- sqlfmt-corpus-separator --

EXECUTE p2(2, 0);

-- sqlfmt-corpus-separator --

EXECUTE p2(2, 1);

-- sqlfmt-corpus-separator --

EXECUTE p2(7);

-- sqlfmt-corpus-separator --

EXECUTE p2;

-- sqlfmt-corpus-separator --

EXECUTE p3('abc');

-- sqlfmt-corpus-separator --

EXECUTE p3(0);

-- sqlfmt-corpus-separator --

EXECUTE p3(2);

-- sqlfmt-corpus-separator --

EXECUTE p3(3);

-- sqlfmt-corpus-separator --

EXECUTE p3;

-- sqlfmt-corpus-separator --

EXECUTE p4('123');

-- sqlfmt-corpus-separator --

EXECUTE p4('abc');

-- sqlfmt-corpus-separator --

EXECUTE p4(1);

-- sqlfmt-corpus-separator --

EXECUTE p5(2);

-- sqlfmt-corpus-separator --

EXECUTE p5(7);

-- sqlfmt-corpus-separator --

EXECUTE p6(2, 100, 200);

-- sqlfmt-corpus-separator --

EXECUTE p_error_1(7);

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(n int) AS (
    (SELECT n FROM init)
    UNION ALL
    (SELECT * FROM c2 WHERE n<3)
  ),
  c1(n int) AS (
    SELECT n+n FROM c0
  ),
  c2(n int) AS (
    (SELECT * FROM c0)
    UNION ALL
    (SELECT * FROM c1)
    UNION ALL
    (SELECT * FROM c1)
  )
SELECT * FROM c1;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(n int) AS (
    (SELECT n FROM init)
    UNION ALL
    (SELECT * FROM c2 WHERE n>7)
  ),
  c1(n int) AS (
    SELECT n+n FROM c0
  ),
  c2(n int) AS (
    (SELECT * FROM c0)
    UNION ALL
    (SELECT * FROM c1)
    UNION ALL
    (SELECT * FROM c1)
  )
SELECT * FROM c2 WHERE n>7;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(n int) AS (
    (SELECT n FROM init)
    UNION ALL
    (SELECT * FROM c2)
  ),
  c1(n int) AS (
    (SELECT n+n FROM c0)
    UNION ALL
    ((SELECT n+3 FROM c0) EXCEPT ALL (SELECT n+3 FROM c0))
  ),
  c2(n int) AS (
    (SELECT * FROM c0)
    UNION ALL
    (SELECT * FROM c1)
    UNION ALL
    (SELECT * FROM c1)
  )
SELECT * FROM c2;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(n int) AS (
    (SELECT n FROM init)
    UNION ALL
    (SELECT * FROM c2)
  ),
  c1(n int) AS (
    SELECT n+n FROM c0
  ),
  c2(n int) AS (
    (SELECT * FROM c0 WHERE n<5)
    UNION ALL
    (SELECT * FROM c1)
    UNION ALL
    (SELECT * FROM c1)
  )
SELECT * FROM c2;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(n int) AS (
    (SELECT n FROM init)
    UNION ALL
    (SELECT * FROM c2)
  ),
  c1(n int) AS (
    SELECT n+n FROM c0
  ),
  c2(n int) AS (
    (SELECT * FROM c0)
    UNION ALL
    (SELECT * FROM c1 WHERE n>7)
    UNION ALL
    (SELECT * FROM c1 WHERE n>7)
  )
SELECT * FROM c1 WHERE n>7;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(n int) AS (
    (SELECT n FROM init)
    UNION ALL
    (SELECT * FROM c2)
  ),
  c1(n int) AS (
    SELECT n+n FROM c0 WHERE n<5
  ),
  c2(n int) AS (
    (SELECT * FROM c0 WHERE n<5)
    UNION ALL
    (SELECT * FROM c1)
    UNION ALL
    (SELECT * FROM c1)
  )
SELECT * FROM ((SELECT * FROM c2) UNION (SELECT * FROM c0));

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(n int) AS (
    (SELECT n FROM init)
    UNION ALL
    (SELECT * FROM c2)
  ),
  c1(n int) AS (
    SELECT n+n FROM c0 WHERE n<5
  ),
  c2(n int) AS (
    (SELECT * FROM c0 WHERE n<5)
    UNION ALL
    (SELECT * FROM c1)
    UNION ALL
    (SELECT * FROM c1)
  )
SELECT * FROM c2;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(n int) AS (
    (SELECT n FROM init)
    UNION ALL
    (SELECT * FROM c2)
  ),
  c1(n int) AS (
    SELECT n+n FROM c0 WHERE n<5
  ),
  c2(n int) AS (
    (SELECT * FROM c0)
    UNION ALL
    (SELECT * FROM c1)
    UNION ALL
    (SELECT * FROM c1)
  )
SELECT * FROM c2;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(x INT, y INT) AS (
    SELECT * FROM (VALUES (1, 2), (3, 4), (5, 6))
  ),
  c1(x INT, y INT) AS (
    SELECT * FROM c0
    UNION ALL
    SELECT DISTINCT y, y-1 FROM c2 WHERE x < 1
  ),
  c2(x INT, y INT) AS (
    SELECT * FROM c0
    UNION ALL
    SELECT DISTINCT x, x+1 FROM c1 WHERE x >= 1
  )
SELECT x, MAX(y) FROM (SELECT * FROM c1 UNION SELECT * FROM c2) GROUP BY x

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(x INT, y INT) AS (
    SELECT * FROM (VALUES (1, 2), (3, 4), (5, 6))
  ),
  c1(x INT, y INT) AS (
    SELECT * FROM c0
    UNION ALL
    SELECT DISTINCT y, y-1 FROM c2 WHERE x < 1
  ),
  c2(x INT, y INT) AS (
    SELECT * FROM c0
    UNION ALL
    SELECT DISTINCT x, x+1 FROM c1 WHERE x >= 1 LIMIT 2
  )
SELECT x, MAX(y) FROM (SELECT * FROM c1 UNION SELECT * FROM c2) GROUP BY x

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  rollup(category_id int, total numeric(20,10), item_count int) AS (
    -- Base: calculate each category's direct total and item count
    SELECT
      c.category_id,
      COALESCE(SUM(d.price), 0)::numeric(20,10),
      COUNT(d.price)
    FROM categories c
    LEFT JOIN dynamic_price_shopping_cart d
      ON c.category_id = d.category_id
    GROUP BY c.category_id
    UNION ALL
    -- Recursive: bubble each category's totals upward to its parent
    SELECT
      c.parent_id,
      r.total,
      r.item_count
    FROM rollup r
    JOIN categories c
      ON r.category_id = c.category_id
    WHERE c.parent_id IS NOT NULL
  ),
  totals(category_id int, total numeric(20,10), item_count int) AS (
    SELECT
      c.category_id,
      SUM(r.total)::numeric(20,10) AS total,
      SUM(r.item_count) AS item_count
    FROM categories c
    JOIN rollup r
      ON c.category_id = r.category_id
    GROUP BY c.category_id
    HAVING SUM(r.item_count) > 0  -- only include categories with items
  ),
  has_subcategories(category_id int, has_subcategory boolean) AS (
    SELECT
      a.category_id,
      count(*) FILTER (WHERE b.parent_id IS NOT NULL) > 0 AS has_subcategory
    FROM categories a
    LEFT JOIN categories b ON a.category_id = b.parent_id
    GROUP BY a.category_id
  )
SELECT
  t.category_id,
  c.parent_id,
  s.has_subcategory,
  c.category_name,
  t.total,
  t.item_count
FROM totals t
JOIN categories c USING (category_id)
JOIN has_subcategories s USING (category_id);

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  triangles(a int, b int, c int) AS (
    SELECT
      a, b, c
    FROM
      edges as edge,
      (
        SELECT
        e2.src as a,
        e2.dst as b,
        e3.dst as c
        FROM
          edges as e2,
          edges as e3
        WHERE
          e2.dst = e3.src
      ) as apex(a, b, c)
    WHERE
      edge.dst = apex.a AND
      edge.src = apex.c
  ),
  triangle_cycles(a int, b int, c int) AS (
    SELECT a, b, c FROM triangles
    UNION
    SELECT c, a, b FROM triangle_cycles
  )
SELECT * FROM triangle_cycles;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT = 3)
  c0(f1 int) as (
    (SELECT * FROM t5)
    UNION
    (SELECT t5.f1 + c0.f1
    FROM t5, c0
    WHERE (t5.f1 = 0 OR t5.f1 = 2 OR t5.f1 = 8))
  )
SELECT * FROM c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
with mutually recursive
  bar2(a int4, v text) as (
    select * from bar
    union
    select a, u from c0
  ),
  keys(a int4) as (
    select distinct c0.a from c0, (select distinct on(a) * from bar2) as bar3 where c0.a = bar3.a
  ),
  c0(a int4, b int8, u text, key int4) as (
    select c0.a, c0.b, c0.u, c0.key from c0, keys where c0.a = keys.a
    union
    select * from c0
  )
select * from c0
union all
select a, -1, v, a from bar2
union all
select a, -2, 'keys', a from keys;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
with mutually recursive
  bar2(a int4, v text) as (
    select * from bar
    union
    select a, u from c0
  ),
  keys(a int4) as (
    select distinct c0.a from c0, (select distinct on(a) * from bar2) as bar3 where c0.a = bar3.a
  ),
  c0(a int4, b int8, u text, key int4) as (
    select c0.a, c0.b, c0.u, c0.key from c0, keys where c0.a = keys.a
    union
    select * from c0
  )
select * from c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
with mutually recursive
  c0(a int4, b int8, u text) as (
    (
      select c0.a + bar.a, c0.b + baz.b, c0.u || cast(baz.c + quux.c as text) from
      c0 left join bar on c0.a = bar.a
         left join baz on c0.b = baz.b
         left join quux on baz.c = quux.c
    )
    union
    select * from foo
  )
select * from c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
with mutually recursive
  c0(a int4, b int8, u text, a_bar int4, v_bar text) as (
    (
      select * from
      foo_raw left join bar on foo_raw.a = bar.a
    )
    union
    select * from c0
  )
select * from c0

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
with mutually recursive
  c0(a int4, b int8, u text, a_bar int4, v_bar text) as (
    (
      select c0.a, c0.b, c0.u, bar.a, bar.v from
      c0 left join bar on c0.a = bar.a
    )
    union
    select *, a, u from foo_raw
  )
select * from c0

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
with mutually recursive
  c0(a int4, b int8, u text, key int4) as (
    select * from (
      with keys as (
        select distinct c0.a from c0, bar where c0.a = bar.a
      )
      select c0.a, c0.b, c0.u, c0.key from c0, keys where c0.a = keys.a
    )
    union
    select * from c0
  )
select * from c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
with mutually recursive
  c0(a int4, b int8, u text, key int4) as (
    select * from (
      with keys as (
        select distinct foo.a from foo, bar where foo.a = bar.a
      )
      select * from foo, keys where foo.a = keys.a
    )
    union
    select * from c0
  )
select * from c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
with mutually recursive
  keys(a int4) as (
    select distinct c0.a from c0, bar where c0.a = bar.a
  ),
  c0(a int4, b int8, u text, key int4) as (
    select c0.a, c0.b, c0.u, c0.key from c0, keys where c0.a = keys.a
    union
    select * from c0
  )
select * from c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT * FROM (
    WITH MUTUALLY RECURSIVE
        foo (a int8) AS (SELECT DISTINCT a FROM foo)
    SELECT * FROM foo
)
UNION ALL
SELECT * FROM (
    WITH MUTUALLY RECURSIVE
        bar (a int8) AS (SELECT DISTINCT a FROM bar)
    SELECT * FROM bar
);

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT * FROM (
    WITH MUTUALLY RECURSIVE (RECURSION LIMIT 27)
        foo (a int8) AS (SELECT DISTINCT a FROM foo)
    SELECT * FROM foo
)
UNION ALL
SELECT * FROM (
    WITH MUTUALLY RECURSIVE (RECURSION LIMIT 27)
        bar (a int8) AS (SELECT DISTINCT a - 2 FROM bar)
    SELECT * FROM bar
);

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT * FROM (
    WITH MUTUALLY RECURSIVE (RECURSION LIMIT 5)
        foo (a int8) AS (SELECT DISTINCT a FROM foo)
    SELECT * FROM foo
)
UNION ALL
SELECT * FROM (
    WITH MUTUALLY RECURSIVE (RECURSION LIMIT 7)
        bar (a int8) AS (SELECT DISTINCT a - 2 FROM bar)
    SELECT * FROM bar
);

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT a, array_agg(b ORDER BY b ASC), array_agg(b ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT a, array_agg(b ORDER BY b) FROM t GROUP BY a HAVING array_agg(b ORDER BY b) = array_agg(b ORDER BY b DESC);

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT a, array_agg(b), string_agg(c, ',' ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT array_agg(b ORDER BY b ASC), array_agg(b ORDER BY b DESC), bool_or(b IS NOT NULL) FROM t;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW CLUSTER REPLICAS

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW CLUSTER REPLICAS WHERE cluster IN ('compute_qck', 'ingest_qck');

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW COLUMNS IN t

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW CONNECTIONS

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW DATABASES

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW INDEXES

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW INDEXES IN CLUSTER quickstart

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW MATERIALIZED VIEWS

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW MATERIALIZED VIEWS IN CLUSTER quickstart

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW OBJECTS

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW SCHEMAS

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW SECRETS

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW SINKS

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW SOURCES

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW TABLES

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW TYPES

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SHOW VIEWS

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT * FROM bar;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR WITH MUTUALLY RECURSIVE
    foo (a int8) AS (
        WITH MUTUALLY RECURSIVE
            bar (b int8) AS (
                SELECT * FROM (SELECT * FROM foo UNION ALL SELECT * FROM bar)
            )
        SELECT * FROM (SELECT * FROM foo EXCEPT ALL SELECT * FROM bar)
    )
SELECT * FROM foo;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR WITH MUTUALLY RECURSIVE
    foo (a int8) AS (
        WITH MUTUALLY RECURSIVE
            bar (b int8) AS (
                SELECT * FROM (SELECT * FROM foo UNION ALL SELECT * FROM baz)
            ),
            baz (b int8) AS (
                SELECT b + 3 FROM bar WHERE b > -5
            )
        SELECT * FROM (SELECT * FROM foo EXCEPT ALL SELECT * FROM baz)
    )
SELECT * FROM foo;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR WITH MUTUALLY RECURSIVE
    foo (a int8) AS (
        WITH MUTUALLY RECURSIVE
            bar (b int8) AS (
                SELECT * FROM foo
            )
        SELECT * FROM (SELECT * FROM foo UNION ALL SELECT * FROM bar)
    )
SELECT * FROM foo;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR WITH MUTUALLY RECURSIVE
    label (node int, comp int) AS (
        SELECT dst, MIN(comp)
        FROM (
            SELECT dst, dst AS comp FROM edges
            UNION ALL
            SELECT edges.dst, label.comp
            FROM edges, label
            WHERE edges.src = label.node
        )
        GROUP BY dst
    )
SELECT round, COUNT(*) FROM (
    WITH MUTUALLY RECURSIVE
        relabel (node int, comp int, round int) AS (
            SELECT DISTINCT ON(node) node, comp, round
            FROM (
                SELECT node, comp, 0 as round FROM label
                UNION ALL
                SELECT edges.dst, relabel.comp, relabel.round + 1
                FROM edges, relabel
                WHERE edges.src = relabel.node
            )
            ORDER BY node, comp
        )
    SELECT round FROM relabel
)
GROUP BY round;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR WITH MUTUALLY RECURSIVE (ERROR AT RECURSION LIMIT 10)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR WITH MUTUALLY RECURSIVE (RECURSION LIMIT 10)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR WITH MUTUALLY RECURSIVE (RECURSION LIMIT 17)
    foo (a int8) AS (
        WITH MUTUALLY RECURSIVE (RECURSION LIMIT 11)
            bar (b int8) AS (
                SELECT * FROM (SELECT * FROM foo UNION ALL SELECT * FROM bar)
            )
        SELECT * FROM (SELECT * FROM foo EXCEPT ALL SELECT * FROM bar)
    )
SELECT * FROM foo;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR WITH MUTUALLY RECURSIVE (RECURSION LIMIT 21)
    label (node int, comp int) AS (
        SELECT dst, MIN(comp)
        FROM (
            SELECT dst, dst AS comp FROM edges
            UNION ALL
            SELECT edges.dst, label.comp
            FROM edges, label
            WHERE edges.src = label.node
        )
        GROUP BY dst
    )
SELECT round, COUNT(*) FROM (
    WITH MUTUALLY RECURSIVE (RECURSION LIMIT 23)
        relabel (node int, comp int, round int) AS (
            SELECT DISTINCT ON(node) node, comp, round
            FROM (
                SELECT node, comp, 0 as round FROM label
                UNION ALL
                SELECT edges.dst, relabel.comp, relabel.round + 1
                FROM edges, relabel
                WHERE edges.src = relabel.node
            )
            ORDER BY node, comp
        )
    SELECT round FROM relabel
)
GROUP BY round;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR WITH MUTUALLY RECURSIVE (RECURSION LIMIT 9)
    foo (a int8) AS (
        WITH MUTUALLY RECURSIVE (RECURSION LIMIT 3)
            bar (b int8) AS (
                SELECT * FROM foo
            )
        SELECT * FROM (SELECT * FROM foo UNION ALL SELECT * FROM bar)
    )
SELECT * FROM foo;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 10)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR with mutually recursive
    a(x int) as (select * from b),
    b(x int) as (select * from foo),
    -- meant to contain `b` minus its previous iterate.
    c(x int) as (select * from b except all select * from a)
select * from c;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (keys) AS VERBOSE TEXT FOR
with mutually recursive
  c0(a int4, b int8, u text, key int4) as (
    select distinct on (1) * from (
      select * from (
        with keys as (
          select distinct foo.a from foo, (select a, u from c0) as likebar where foo.a = likebar.a
        )
        select * from foo, keys where foo.a = keys.a
      )
      union
      select * from c0
    )
  )
select * from c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (keys) AS VERBOSE TEXT FOR
with mutually recursive
  keys(a int4) as (
    select distinct c0.a from c0, (select distinct on(a) * from bar2) as bar3 where c0.a = bar3.a
  ),
  bar2(a int4, v text) as (
    select * from bar
    union
    select a, u from c0
  ),
  c0(a int4, b int8, u text, key int4) as (
    select c0.a, c0.b, c0.u, c0.key from c0, keys where c0.a = keys.a
    union
    select * from c0
  )
select * from c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(arity, humanized expressions) AS VERBOSE TEXT FOR
with mutually recursive
  c0(a int4, b int8, u text) as (
    (
      select c0.a, c0.b, c0.u from
      c0 left join bar on c0.a = bar.a
         left join baz on c0.b = baz.b
         left join quux on baz.c = quux.c
    )
    union
    select * from foo
  )
select * from c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(arity, join implementations, keys, humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(f0 int4, f1 string, f2 int2, f3 string) AS (
    (SELECT DISTINCT *
     FROM x, y
     WHERE x.f1 = y.f1)
    UNION
    (SELECT DISTINCT *
     FROM c0)
  )
SELECT * FROM c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(arity, join implementations, keys, humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(f0 int4, f1 string, f2 int2, f3 string) AS (
    (SELECT DISTINCT *
     FROM x, y
     WHERE x.f1 = y.f1)
    UNION ALL
    (SELECT *
     FROM c0)
  )
SELECT * FROM c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(arity, types, humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(f1 integer, f2 integer) AS (
    SELECT * FROM (
      SELECT * FROM t1
      UNION
      SELECT * FROM c0
    ) WHERE f1 = 3 AND f2 = 5
  )
SELECT f1, f2, f1 + f2 FROM c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(arity, types, humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(f1 integer, f2 integer) AS (
    SELECT * FROM (
      SELECT * FROM t1
      UNION
      SELECT * FROM c0
    ) WHERE f1 IS NOT NULL AND f2 IS NOT NULL
  )
SELECT f1, f2, f1 IS NOT NULL, f2 IS NULL FROM c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(arity, types, humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(f1 integer, f2 integer) AS (
    SELECT * FROM (
      SELECT * FROM t1
      UNION
      SELECT * FROM c0 WHERE f1 IS NOT NULL AND f2 IS NOT NULL
    )
  )
SELECT f1, f2, f1 IS NOT NULL, f2 IS NULL FROM c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(arity, types, humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  it(count integer) AS (
    SELECT 1 UNION SELECT * FROM it WHERE count = 1
  ),
  c0(count integer, f1 integer, f2 integer) AS (
    SELECT * FROM (
      SELECT count * 2, f1, f2 FROM it, t1
      UNION
      SELECT * FROM c0
    )
  )
SELECT * FROM c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(arity, types, humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  it(count integer) AS (
    SELECT 1 UNION SELECT * FROM it WHERE count IS NOT NULL
  ),
  c0(count_is_null boolean, f1 integer, f2 integer) AS (
    SELECT * FROM (
      SELECT count IS NULL, f1, f2 FROM it, t1
      UNION
      SELECT * FROM c0
    )
  )
SELECT * FROM c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
SELECT bound, (
    WITH MUTUALLY RECURSIVE
        numbers (n int) as (
            VALUES (1)
            UNION ALL
            (
                WITH rebound AS (SELECT * FROM numbers)
                SELECT distinct t1.n + t2.n AS n
                FROM rebound AS t1, rebound AS t2
                WHERE t1.n <= bound AND t2.n <= bound
            )
        )
    SELECT count(*) FROM numbers
)
FROM (
    SELECT generate_series AS bound FROM generate_series(1, 10)
);

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH
  t0 AS (
    SELECT DISTINCT f1 % 2 AS f, 42 as c FROM t2
  )
SELECT * FROM (
  WITH MUTUALLY RECURSIVE
    c0(f INT) AS (
      SELECT f FROM t0
    ),
    c1(f1 INT, f2 INT, f INT) AS (
      SELECT * FROM c1
      UNION
      SELECT f, f, f from c0
      UNION
      SELECT * FROM t2, c0 WHERE t2.f1 % 2 = c0.f
    )
  SELECT f FROM c1 UNION ALL SELECT c FROM t0
);

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
    ties(slower NUMERIC, faster NUMERIC) AS (
        SELECT
            (time + sqrt(time * time - 4 * distance)) / 2 as slower,
            (time - sqrt(time * time - 4 * distance)) / 2 as faster
        FROM input
    ),
    options(choices NUMERIC) AS (
        SELECT 1 + FLOOR(slower)::NUMERIC - CEIL(faster)::NUMERIC FROM ties
    ),
    part12(part12 NUMERIC) AS (
        SELECT pow(10.0, SUM(log(choices))) FROM options
    )
SELECT * FROM part12;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(f0 int4, f1 string, f2 int2, f3 string) AS (
    (SELECT DISTINCT *
     FROM x, y
     WHERE x.f1 = y.f1)
    UNION ALL
    (SELECT *
     FROM c0)
  )
SELECT * FROM c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(f1 INT, f2 INT, f INT) AS (
    SELECT * FROM c0
    UNION
    SELECT * FROM t1, (SELECT DISTINCT f1 % 2 AS f FROM t1) t0 WHERE t1.f1 % 2 = t0.f
  )
SELECT * FROM c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(f1 INT, f2 INT, f INT) AS (
    SELECT * FROM c0
    UNION
    SELECT * FROM t2, (SELECT DISTINCT f1 % 2 AS f FROM t2) t0 WHERE t2.f1 % 2 = t0.f
  )
SELECT * FROM c0;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(f1 INTEGER, f2 INTEGER) AS (
    SELECT f1, f2 FROM t1
    UNION ALL
    SELECT f1, f2 FROM t1
  ),
  c1(f1 INTEGER, f2 INTEGER) AS (
    SELECT * FROM c0 WHERE f2 > 7
    UNION ALL
    SELECT * FROM c1 WHERE f2 > 7
    UNION ALL
    SELECT * FROM c1 WHERE f2 > 7
    UNION ALL
    SELECT * FROM c2 WHERE f2 > 7
    UNION ALL
    SELECT * FROM c2 WHERE f2 > 7
  ),
  c2(f1 INTEGER, f2 INTEGER) AS (
    SELECT * FROM c0 WHERE f2 > 7
    UNION ALL
    SELECT * FROM c1 WHERE f2 > 7
    UNION ALL
    SELECT * FROM c1 WHERE f2 > 7
    UNION ALL
    SELECT * FROM c2 WHERE f2 > 7
    UNION ALL
    SELECT * FROM c2 WHERE f2 > 7
  )
SELECT * FROM c0 WHERE f1 > 7
UNION ALL
SELECT * FROM c1 WHERE f1 > 7
UNION ALL
SELECT * FROM c2 WHERE f1 > 7

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(key int, a int) AS (
    SELECT * FROM c2
    UNION
    SELECT a, a FROM t
  ),
  c1(key int, a int) AS (
    SELECT key + 1, -a FROM c0
  ),
  c2(key int, a int) AS (
    SELECT c0.key + c1.key, c0.a + c1.a
    FROM c0, c1
    WHERE c0.key = c1.key
  )
SELECT * FROM c2;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(n INT) AS (
    SELECT src FROM edges WHERE false -- literal false
    UNION ALL
    SELECT dst FROM edges
    UNION ALL
    SELECT * FROM c0 WHERE n IS NULL -- impossible condition (depends on column_knowledge)
    UNION
    SELECT * FROM c0 WHERE n IS NOT NULL -- complement (always true)
  )
SELECT * FROM c0

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(src INT, dst INT) AS (
    SELECT * FROM c0
    UNION
    SELECT src * 2, dst * 2 FROM (VALUES (31, 32), (33, 34)) AS constant(src, dst)
    UNION
    (
      SELECT src + 1, dst + 1 FROM (VALUES (41, 42), (43, 44), (44, 45)) AS constant(src, dst) WHERE src > 1
      EXCEPT
      SELECT src + 2, dst + 2 FROM (VALUES (41, 42), (43, 44), (44, 45)) AS constant(src, dst)
    )
    UNION
    (
      SELECT DISTINCT
        x.src, y.dst
      FROM
        (VALUES (51, 52), (52, 53), (53, 54), (54, 55)) AS x(src, dst),
        (VALUES (52, 53), (53, 54), (54, 55)) AS y(src, dst),
        (VALUES (53, 51), (54, 52), (54, 53)) AS z(src, dst)
      WHERE
        x.dst = y.src AND y.dst = z.src AND z.dst = x.src
    )
  )
SELECT * FROM c0

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(x INT, y INT) AS (
    SELECT * FROM c0
    UNION
    SELECT f1, 42 FROM t1
    UNION
    SELECT f2, 42 FROM t1
  )
SELECT * FROM c0

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(x INT, y INT) AS (
    SELECT f1, 42 FROM t1
    UNION
    SELECT f2, 42 FROM t1
  ),
  c1(x INT, y INT) AS (
    SELECT * FROM c0
    UNION
    SELECT * FROM c1
  )
SELECT * FROM c0 UNION ALL SELECT * FROM c1

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(x INT, y INT, z INT) AS (
    SELECT *, null::int FROM t1
  ),
  c1(x INT, y INT, z INT) AS (
    SELECT * FROM c0 WHERE z > 0 UNION SELECT x, y, 42 FROM c1
  ),
  c2(x INT, y INT, z INT) AS (
    SELECT y, x, z FROM c0
  )
SELECT * FROM (SELECT * FROM c1 UNION ALL SELECT * FROM c2) WHERE z > 0

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
lines(line string) AS (
    SELECT
        regexp_split_to_table(input, '\n') AS line
    FROM
        aoc_1204
),
cards(match string[]) AS (
    SELECT
        regexp_match(line, 'Card +(\d+): (.*)') AS match
    FROM
        lines
),
card_parts(card_id int, parts string[]) AS (
    SELECT
        match[1]::int AS card_id,
        regexp_split_to_array(match[2], ' \| ') AS parts
    FROM
        cards
),
winners(card_id int, val int) AS (
    SELECT
        card_id,
        regexp_split_to_table(trim(parts[1]), '\s+')::int AS val
    FROM
        card_parts
),
ours(card_id int, val int) AS (
    SELECT
        card_id,
        regexp_split_to_table(trim(parts[2]), '\s+')::int AS val
    FROM
        card_parts
),
count_winning_numbers(card_id int, count int) AS (
    SELECT
        ours.card_id,
        count(winners.val)::int AS count
    FROM
        ours LEFT OUTER JOIN winners ON (
            ours.card_id = winners.card_id AND
            ours.val = winners.val
        )
    GROUP BY ours.card_id
),
prizes(card_id int, prize_id int) AS (
    SELECT
        card_id,
        prize_id
    FROM
        count_winning_numbers CROSS JOIN generate_series(card_id + 1, card_id + count) AS prize_id
    UNION
    SELECT
        0 AS card_id,
        ours.card_id AS prize_id
    FROM
        ours
),
multipliers(card_id int, multiplier int) AS (
    SELECT
        prizes.prize_id AS card_id,
        SUM(coalesce(multipliers.multiplier, 1))::int AS multiplier
    FROM
        prizes left outer JOIN multipliers ON (
            prizes.card_id = multipliers.card_id
        )
    GROUP BY prizes.prize_id
)
SELECT
    SUM(multiplier) AS answer
FROM
    multipliers;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
WITH t(x) AS (
  SELECT a
  FROM big
  WHERE a = 5
)
(
  SELECT b1.a
  FROM big as b1, big as b2, t
)
UNION ALL
(SELECT * FROM t);

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
with mutually recursive
    -- Parse the input up
    lines(line TEXT) as (select regexp_split_to_table(input, '\n') as line from input),
    games(game TEXT, report TEXT) as (select regexp_split_to_array(line, ':')[1], regexp_split_to_array(line, ':')[2] from lines),
    round(game TEXT, visible TEXT) as (select game, regexp_split_to_table(report, ';') from games),
    bacon(game TEXT, color TEXT) as (select game, regexp_split_to_table(visible, ',') from round),
    parsed(game INT, color TEXT, number INT) as (
        select
            substring(game, 5)::INT as game,
            regexp_split_to_array(color, ' ')[3] as color,
            regexp_split_to_array(color, ' ')[2]::INT as number
        from bacon
    ),
    -- PART 1
    limits(color TEXT, number INT) as (SELECT * FROM (VALUES ('red', 12), ('green', 13), ('blue', 14))),
    bad_news(game INT) as (
        select game
        from parsed, limits
        where parsed.color = limits.color
          AND parsed.number > limits.number
    ),
    plausible(game INT) as (select distinct parsed.game from parsed left join bad_news on(parsed.game = bad_news.game) where bad_news.game IS NULL),
    part1(part1 BIGINT) as (select SUM(game) from plausible),
    -- PART 2
    maximum(game INT, color TEXT, number INT) as (select game, color, max(number) from parsed GROUP BY game, color),
    red(game INT) as (select game from maximum, generate_series(1, number) where color = 'red'),
    blue(game INT) as (select game from maximum, generate_series(1, number) where color = 'blue'),
    green(game INT) as (select game from maximum, generate_series(1, number) where color = 'green'),
    power(game INT, product BIGINT) as (SELECT red.game, count(*) from red, blue, green where red.game = blue.game and blue.game = green.game GROUP BY red.game),
    part2(part2 BIGINT) as (select sum(product)::BIGINT from power)
select * from part1, part2;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR CREATE OR REPLACE MATERIALIZED VIEW PathQ19 AS
WITH
  -- asymmetrize...
  knows_asymmetric AS (
    SELECT person1id, person2id
      FROM Person_knows_person
     WHERE person1id < person2id
  ),
  -- compute interaction scores (no interactions means we ignore that 'knows' relationship)
  weights(src, dst, w) AS (
    SELECT
        person1id AS src,
        person2id AS dst,
        greatest(round(40 - sqrt(count(*)))::bigint, 1) AS w
    FROM Message m1,
         Message m2,
         knows_asymmetric pp
    WHERE pp.person1id = least(m1.creatorpersonid, m2.creatorpersonid)
      AND pp.person2id = greatest(m1.creatorpersonid, m2.creatorpersonid)
      AND m1.parentmessageid = m2.messageid
      AND m1.creatorpersonid <> m2.creatorpersonid
 GROUP BY src, dst
)
-- resymmetrize
SELECT src, dst, w FROM weights
UNION ALL
SELECT dst, src, w FROM weights;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR WITH
  -- forums within the date range
  myForums AS (
      SELECT id FROM Forum f WHERE f.creationDate BETWEEN '2012-11-06'::TIMESTAMP AND '2012-11-10'::TIMESTAMP
  ),
  -- the (inverse) interaction scores between folks who know each other
  mm AS (
      SELECT least(msg.CreatorPersonId, reply.CreatorPersonId) AS src,
             greatest(msg.CreatorPersonId, reply.CreatorPersonId) AS dst,
             sum(case when msg.ParentMessageId is null then 10 else 5 end) AS w
      FROM Person_knows_Person pp, Message msg, Message reply
      WHERE true
            AND pp.person1id = msg.CreatorPersonId
            AND pp.person2id = reply.CreatorPersonId
            AND reply.ParentMessageId = msg.MessageId
            AND EXISTS (SELECT * FROM myForums f WHERE f.id = msg.containerforumid)
            AND EXISTS (SELECT * FROM myForums f WHERE f.id = reply.containerforumid)
      GROUP BY src, dst
  ),
  -- the true interaction scores, with 0 default for folks with no interactions
  edge AS (
      SELECT pp.person1id AS src,
             pp.person2id AS dst,
             10::double precision / (coalesce(w, 0) + 10) AS w
        FROM Person_knows_Person pp
   LEFT JOIN mm
          ON least(pp.person1id, pp.person2id) = mm.src
         AND greatest(pp.person1id, pp.person2id) = mm.dst
  ),
  completed_paths AS (
    WITH MUTUALLY RECURSIVE
      paths (src bigint, dst bigint, w double precision) AS (
          SELECT 1450::bigint AS src, 1450::bigint AS dst, 0::double precision AS w
          UNION
          SELECT paths1.src, paths2.dst, paths1.w + paths2.w
            FROM minimal_paths paths1
            JOIN edge paths2 -- step-transitive closure
              ON paths1.dst = paths2.src
      ),
      minimal_paths (src bigint, dst bigint, w double precision) AS (
        SELECT src, dst, min(w)
          FROM paths
      GROUP BY src, dst
      )
    SELECT src, dst, w
      FROM minimal_paths
     WHERE dst = 15393162796819),
  results AS (
    SELECT dst, w
      FROM completed_paths
     WHERE w IN (SELECT min(w) FROM completed_paths)
  )
SELECT coalesce(w, -1) FROM results ORDER BY w ASC LIMIT 20

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR WITH
  srcs AS (SELECT id FROM Person WHERE locationcityid = 655::bigint),
  dsts AS (SELECT id FROM Person WHERE locationcityid = 1138::bigint),
  completed_paths AS (
    WITH MUTUALLY RECURSIVE
      paths (src bigint, dst bigint, w double precision) AS (
          SELECT id AS src,
                 id AS dst,
                 0::double precision AS w
                 FROM srcs
          UNION
          SELECT paths1.src AS src,
                 paths2.dst AS dst,
                 paths1.w + paths2.w AS w
            FROM minimal_paths paths1
            JOIN PathQ19 paths2 -- step-transitive closure
              ON paths1.dst = paths2.src
      ),
      minimal_paths (src bigint, dst bigint, w double precision) AS (
        SELECT src, dst, min(w)
          FROM paths
      GROUP BY src, dst
      )
    SELECT src, dst, w
      FROM minimal_paths
     WHERE dst = ANY (SELECT id FROM dsts)
  )
SELECT src, dst, w
  FROM completed_paths
 WHERE w = (SELECT min(w) FROM completed_paths)

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR WITH MUTUALLY RECURSIVE
  srcs (f bigint) AS (SELECT 1450::bigint),
  dsts (t bigint) AS (SELECT 15393162796819),
  myForums (id bigint) AS (
      SELECT id FROM Forum f WHERE f.creationDate BETWEEN '2012-11-06'::TIMESTAMP AND '2012-11-10'::TIMESTAMP
  ),
  mm (src bigint, dst bigint, w bigint) AS (
      SELECT least(msg.CreatorPersonId, reply.CreatorPersonId) AS src,
             greatest(msg.CreatorPersonId, reply.CreatorPersonId) AS dst,
             sum(case when msg.ParentMessageId is null then 10 else 5 end) AS w
      FROM Person_knows_Person pp, Message msg, Message reply
      WHERE true
            AND pp.person1id = msg.CreatorPersonId
            AND pp.person2id = reply.CreatorPersonId
            AND reply.ParentMessageId = msg.MessageId
            AND EXISTS (SELECT * FROM myForums f WHERE f.id = msg.containerforumid)
            AND EXISTS (SELECT * FROM myForums f WHERE f.id = reply.containerforumid)
      GROUP BY src, dst
  ),
  path (src bigint, dst bigint, w double precision) AS (
      SELECT pp.person1id, pp.person2id, 10::double precision / (coalesce(w, 0) + 10)
      FROM Person_knows_Person pp left join mm on least(pp.person1id, pp.person2id) = mm.src AND greatest(pp.person1id, pp.person2id) = mm.dst
  ),
  -- bidirectional bfs for nonexistant paths
  pexists (src bigint, dir bool) AS (
      (
          SELECT f, true FROM srcs
          UNION
          SELECT t, false FROM dsts
      )
      UNION
      (
          WITH
          ss (src, dir) AS (SELECT src, dir FROM pexists),
          ns (src, dir) AS (SELECT p.dst, ss.dir FROM ss, path p WHERE ss.src = p.src),
          bb (src, dir) AS (SELECT src, dir FROM ns UNION ALL SELECT src, dir FROM ss),
          found (found) AS (
              SELECT 1 AS found
              FROM bb b1, bb b2
              WHERE b1.dir AND (NOT b2.dir) AND b1.src = b2.src
          )
          SELECT src, dir
          FROM ns
          WHERE NOT EXISTS (SELECT 1 FROM found)
          UNION
          SELECT -1, true
          WHERE EXISTS (SELECT 1 FROM found)
      )
  ),
  pathfound (c bool) AS (
      SELECT true AS c
      FROM pexists
      WHERE src = -1 AND dir
  ),
  shorts (dir bool, gsrc bigint, dst bigint, w double precision, dead bool, iter bigint) AS (
      (
          SELECT false, f, f, 0::double precision, false, 0 FROM srcs WHERE EXISTS (SELECT 1 FROM pathfound)
          UNION ALL
          SELECT true, t, t, 0::double precision, false, 0 FROM dsts WHERE EXISTS (SELECT 1 FROM pathfound)
      )
      UNION
      (
          WITH
          ss (dir, gsrc, dst, w, dead, iter) AS
             (SELECT * FROM shorts),
          toExplore (dir, gsrc, dst, w, dead, iter) AS
             (SELECT * FROM ss WHERE dead = false ORDER BY w limit 1000),
          -- assumes graph is undirected
          newPoints (dir, gsrc, dst, w, dead) AS (
              SELECT e.dir, e.gsrc AS gsrc, p.dst AS dst, e.w + p.w AS w, false AS dead
              FROM path p join toExplore e on (e.dst = p.src)
              UNION ALL
              SELECT dir, gsrc, dst, w, dead OR EXISTS (SELECT * FROM toExplore e WHERE e.dir = o.dir AND e.gsrc = o.gsrc AND e.dst = o.dst) FROM ss o
          ),
          fullTable (dir, gsrc, dst, w, dead) AS (
              SELECT DISTINCT ON(dir, gsrc, dst) dir, gsrc, dst, w, dead
              FROM newPoints
              ORDER BY dir, gsrc, dst, w, dead DESC
          ),
          found AS (
              SELECT min(l.w + r.w) AS w
              FROM fullTable l, fullTable r
              WHERE l.dir = false AND r.dir = true AND l.dst = r.dst
          )
          SELECT dir,
                 gsrc,
                 dst,
                 w,
                 dead OR (coalesce(t.w > (SELECT f.w/2 FROM found f), false)),
                 e.iter + 1 AS iter
          FROM fullTable t, (SELECT iter FROM toExplore limit 1) e
      )
  ),
  ss (dir bool, gsrc bigint, dst bigint, w double precision, iter bigint) AS (
      SELECT dir, gsrc, dst, w, iter FROM shorts WHERE iter = (SELECT max(iter) FROM shorts)
  ),
  results(f bigint, t bigint, w double precision) AS (
      SELECT l.gsrc, r.gsrc, min(l.w + r.w)
      FROM ss l, ss r
      WHERE l.dir = false AND r.dir = true AND l.dst = r.dst
      GROUP BY l.gsrc, r.gsrc
  )
SELECT coalesce(min(w), -1) FROM results

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR WITH MUTUALLY RECURSIVE
  srcs (f bigint) AS (SELECT id FROM Person WHERE locationcityid = 655::bigint),
  dsts (t bigint) AS (SELECT id FROM Person WHERE locationcityid = 1138::bigint),
  shorts (dir bool, gsrc bigint, dst bigint, w double precision, dead bool, iter bigint) AS (
      (
          SELECT false, f, f, 0::double precision, false, 0 FROM srcs
          UNION ALL
          SELECT true, t, t, 0::double precision, false, 0 FROM dsts
      )
      UNION
      (
          WITH
          ss AS (SELECT * FROM shorts),
          toExplore AS (SELECT * FROM ss WHERE dead = false ORDER BY w LIMIT 1000),
          -- assumes graph is undirected
          newPoints(dir, gsrc, dst, w, dead) AS (
              SELECT e.dir, e.gsrc AS gsrc, p.dst AS dst, e.w + p.w AS w, false AS dead
              FROM PathQ19 p JOIN toExplore e ON (e.dst = p.src)
              UNION
              SELECT dir, gsrc, dst, w, dead OR EXISTS (SELECT * FROM toExplore e WHERE e.dir = o.dir AND e.gsrc = o.gsrc AND e.dst = o.dst) FROM ss o
          ),
          fullTable AS (
              SELECT DISTINCT ON(dir, gsrc, dst) dir, gsrc, dst, w, dead
              FROM newPoints
              ORDER BY dir, gsrc, dst, w, dead DESC
          ),
          found AS (
              SELECT min(l.w + r.w) AS w
              FROM fullTable l, fullTable r
              WHERE l.dir = false AND r.dir = true AND l.dst = r.dst
          )
          SELECT dir,
                 gsrc,
                 dst,
                 w,
                 dead or (coalesce(t.w > (SELECT f.w/2 FROM found f), false)),
                 e.iter + 1 AS iter
          FROM fullTable t, (SELECT iter FROM toExplore LIMIT 1) e
      )
  ),
  ss (dir bool, gsrc bigint, dst bigint, w double precision, iter bigint) AS (
      SELECT dir, gsrc, dst, w, iter FROM shorts WHERE iter = (SELECT max(iter) FROM shorts)
  ),
  results (f bigint, t bigint, w double precision) AS (
      SELECT l.gsrc, r.gsrc, min(l.w + r.w)
      FROM ss l, ss r
      WHERE l.dir = false AND r.dir = true AND l.dst = r.dst
      GROUP BY l.gsrc, r.gsrc
  )
SELECT * FROM results WHERE w = (SELECT min(w) FROM results) ORDER BY f, t

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR WITH minimal_paths AS (
  WITH MUTUALLY RECURSIVE
    paths (dst bigint, w bigint) AS (
      SELECT 10995116285979::bigint AS dst, 0 AS w
      UNION
      SELECT paths2.dst, paths1.w + paths2.w
        FROM minimal_paths paths1
        JOIN PathQ20 paths2 -- step-transitive closure
          ON paths1.dst = paths2.src
    ),
    minimal_paths (dst bigint, w bigint) AS (
      SELECT dst, min(w)
        FROM paths
    GROUP BY dst
    )
  SELECT dst, w FROM minimal_paths),
  dsts AS (
    SELECT personid
      FROM Person_workat_company pwc, Company c
     WHERE pwc.companyid = c.id AND c.name='Balkh_Airlines'
  ),
  completed_paths AS (
    SELECT dst, w
      FROM minimal_paths
     WHERE dst IN (SELECT * FROM dsts)
  ),
  results AS (
    SELECT dst, w
      FROM completed_paths
     WHERE w IN (SELECT min(w) FROM completed_paths)
  )
SELECT dst, w FROM results ORDER BY dst LIMIT 20

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR WITH minimal_paths AS (
  WITH MUTUALLY RECURSIVE
    paths (src bigint, dst bigint, w bigint) AS (
      SELECT 10995116285979::bigint AS src, 10995116285979::bigint AS dst, 0 AS w
      UNION
      SELECT paths1.src, paths2.dst, paths1.w + paths2.w
        FROM minimal_paths paths1
        JOIN PathQ20 paths2 -- step-transitive closure
          ON paths1.dst = paths2.src
    ),
    minimal_paths (src bigint, dst bigint, w bigint) AS (
      SELECT src, dst, min(w)
        FROM paths
    GROUP BY src, dst
    )
  SELECT src, dst, w FROM minimal_paths),
  dsts AS (
    SELECT personid
      FROM Person_workat_company pwc, Company c
     WHERE pwc.companyid = c.id AND c.name='Balkh_Airlines'
  ),
  completed_paths AS (
    SELECT dst, w
      FROM minimal_paths
     WHERE dst IN (SELECT * FROM dsts)
  ),
  results AS (
    SELECT dst, w
      FROM completed_paths
     WHERE w IN (SELECT min(w) FROM completed_paths)
  )
SELECT dst, w FROM results ORDER BY dst LIMIT 20

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR WITH minimal_paths AS (
  WITH MUTUALLY RECURSIVE
    paths (src bigint, dst bigint, w bigint, hops bigint) AS (
      SELECT 10995116285979::bigint AS src, 10995116285979::bigint AS dst, 0 AS w, 0 AS hops
      UNION
      SELECT paths1.src, paths2.dst, paths1.w + paths2.w, paths1.hops + 1
        FROM minimal_paths paths1
        JOIN PathQ20 paths2 -- step-transitive closure
          ON paths1.dst = paths2.src
    ),
    minimal_weights (src bigint, dst bigint, w bigint, hops bigint) AS (
      SELECT src, dst, min(w), hops
        FROM paths
    GROUP BY src, dst, hops
    ),
    minimal_paths (src bigint, dst bigint, w bigint, hops bigint) AS (
      SELECT src, dst, w, min(hops)
        FROM minimal_weights
    GROUP BY src, dst, w
    )
  SELECT src, dst, w, hops FROM minimal_paths),
  dsts AS (
    SELECT personid
      FROM Person_workat_company pwc, Company c
     WHERE pwc.companyid = c.id AND c.name='Balkh_Airlines'
  ),
  completed_paths AS (
    SELECT dst, w, hops
      FROM minimal_paths
     WHERE dst IN (SELECT * FROM dsts)
  ),
  results AS (
    SELECT dst, w, hops
      FROM completed_paths
     WHERE w IN (SELECT min(w) FROM completed_paths)
  )
SELECT dst, w, hops FROM results ORDER BY dst LIMIT 20

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(keys, humanized expressions) AS VERBOSE TEXT FOR
with mutually recursive
  c0(a int4, b int8, u text, a2 int4, v2 text) as (
    select distinct on (1) * from (
      select foo_raw.a, foo_raw.b, foo_raw.u, c0.a, c0.u from
      foo_raw left join c0 on foo_raw.a = c0.a
      union
      select *, a, u from foo_raw
    )
  )
select * from c0

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(linear chains) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT * FROM bar;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(non negative, humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(id int, name text) as (
    (SELECT id, name || '_init' FROM people)
    UNION
    (
      SELECT id, name || '_iter' FROM c0
      EXCEPT
      SELECT id, name || '_iter' FROM c0 WHERE id > 1
    )
  )
SELECT * FROM c0

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(non negative, humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c0(id int, name text) as (
    SELECT id, name FROM people
    EXCEPT
    SELECT id, name FROM people WHERE id > 1
  ),
  c1(id int, name text) as (
    (SELECT id, name || '_init' FROM c0)
    UNION
    (
      SELECT id, name || '_iter' FROM c1
    )
  )
SELECT * FROM c1

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(non negative, humanized expressions) AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE
  c1(id int, name text) as (
    (SELECT id, name || '_init' FROM people)
    UNION
    (
      SELECT id, name || '_iter' FROM c2
      EXCEPT
      SELECT id, name || '_iter' FROM c2 WHERE id > 1
    )
  ),
  c2(id int, name text) as (
    SELECT * FROM c1
    EXCEPT
    SELECT * FROM c1 WHERE id > 2
  )
SELECT * FROM c1

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(non negative, humanized expressions) AS VERBOSE TEXT FOR
WITH a(birth_year, no_people_born) AS (
    SELECT EXTRACT(year from born), COUNT(*)
    FROM people
    GROUP BY EXTRACT(year from born)
)
SELECT * FROM a EXCEPT (SELECT * FROM a WHERE birth_year > 1940);

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(non negative, humanized expressions) AS VERBOSE TEXT FOR
WITH cte AS (SELECT DISTINCT name FROM people)
SELECT * FROM cte EXCEPT ALL SELECT * FROM cte WHERE name LIKE 'J%'

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(non negative, humanized expressions) AS VERBOSE TEXT FOR
WITH cte AS (SELECT people.id FROM people, bands)
SELECT * FROM cte EXCEPT ALL SELECT * FROM cte where id > 5;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(non negative, humanized expressions) AS VERBOSE TEXT FOR
WITH cte1 AS (
    SELECT * FROM people
    EXCEPT ALL
    SELECT * FROM people WHERE name LIKE 'J%'
), cte2 AS (
    SELECT DISTINCT * FROM cte1
)
SELECT * FROM cte2
EXCEPT
SELECT * FROM cte2 WHERE name LIKE 'P%';

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(raw, humanized expressions) AS VERBOSE TEXT FOR
WITH
  cte0 AS (
    SELECT * from t1 where f0 < 27
  )
SELECT * FROM
(
  WITH MUTUALLY RECURSIVE
    cnt (i int) AS (
      (SELECT f0 AS i FROM cte0)
      UNION
      SELECT i+1 FROM cnt)
  SELECT * FROM cnt
);

-- sqlfmt-corpus-separator --

EXPLAIN PHYSICAL PLAN AS JSON FOR
WITH cte(x) as (SELECT a FROM t EXCEPT ALL SELECT b FROM mv)
(SELECT x + 1 FROM cte UNION ALL SELECT x - 1 FROM cte)

-- sqlfmt-corpus-separator --

EXPLAIN PHYSICAL PLAN AS VERBOSE TEXT FOR
SELECT * FROM (
    WITH MUTUALLY RECURSIVE (RECURSION LIMIT 5)
        foo (a int8) AS (SELECT DISTINCT a FROM foo)
    SELECT * FROM foo
)
UNION ALL
SELECT * FROM (
    WITH MUTUALLY RECURSIVE
        bar (a int8) AS (SELECT DISTINCT a - 2 FROM bar)
    SELECT * FROM bar
);

-- sqlfmt-corpus-separator --

EXPLAIN PHYSICAL PLAN AS VERBOSE TEXT FOR
WITH MUTUALLY RECURSIVE input(a int) AS (
    SELECT generate_series(1, 40000) AS a
    UNION
    SELECT DISTINCT ON(a) a
    FROM input
    WHERE a > 20000
)
SELECT MAX(a)
FROM input;

-- sqlfmt-corpus-separator --

EXPLAIN PHYSICAL PLAN AS VERBOSE TEXT FOR
WITH cte(x) as (SELECT a FROM t EXCEPT ALL SELECT b FROM mv)
(SELECT x + 1 FROM cte UNION ALL SELECT x - 1 FROM cte)

-- sqlfmt-corpus-separator --

EXPLAIN PHYSICAL PLAN AS VERBOSE TEXT FOR SELECT a, array_agg(b ORDER BY b ASC), array_agg(b ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

EXPLAIN PHYSICAL PLAN AS VERBOSE TEXT FOR SELECT a, array_agg(b ORDER BY b) FROM t GROUP BY a HAVING array_agg(b ORDER BY b) = array_agg(b ORDER BY b DESC);

-- sqlfmt-corpus-separator --

EXPLAIN PHYSICAL PLAN AS VERBOSE TEXT FOR SELECT a, array_agg(b), string_agg(c, ',' ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

EXPLAIN PHYSICAL PLAN AS VERBOSE TEXT FOR SELECT array_agg(b ORDER BY b ASC), array_agg(b ORDER BY b DESC), bool_or(b IS NOT NULL) FROM t;

-- sqlfmt-corpus-separator --

EXPLAIN PHYSICAL PLAN WITH(redacted) AS VERBOSE TEXT FOR
SELECT * FROM (
    WITH MUTUALLY RECURSIVE (RECURSION LIMIT 5)
        foo (a int8) AS (SELECT DISTINCT a FROM foo)
    SELECT * FROM foo
)
UNION ALL
SELECT * FROM (
    WITH MUTUALLY RECURSIVE
        bar (a int8) AS (SELECT DISTINCT a - 2 FROM bar)
    SELECT * FROM bar
);

-- sqlfmt-corpus-separator --

EXPLAIN PHYSICAL PLAN WITH(redacted) AS VERBOSE TEXT FOR
WITH cte(x) as (SELECT a FROM t EXCEPT ALL SELECT b FROM mv)
(SELECT x + 1 FROM cte UNION ALL SELECT x - 1 FROM cte)

-- sqlfmt-corpus-separator --

EXPLAIN RAW PLAN AS TEXT FOR
WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT * FROM bar;

-- sqlfmt-corpus-separator --

EXPLAIN RAW PLAN AS TEXT FOR
WITH MUTUALLY RECURSIVE (RECURSION LIMIT = 5)
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT * FROM bar;

-- sqlfmt-corpus-separator --

EXPLAIN RAW PLAN AS TEXT FOR
WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT = 5)
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT * FROM bar;

-- sqlfmt-corpus-separator --

FETCH 0 c

-- sqlfmt-corpus-separator --

FETCH 1 c

-- sqlfmt-corpus-separator --

FETCH 2 c

-- sqlfmt-corpus-separator --

FETCH 2 c WITH (TIMEOUT = '10s')

-- sqlfmt-corpus-separator --

FETCH 2 c WITH (TIMEOUT = '1s')

-- sqlfmt-corpus-separator --

FETCH ALL c

-- sqlfmt-corpus-separator --

FETCH c

-- sqlfmt-corpus-separator --

FETCH c WITH (TIMEOUT = '-1s')

-- sqlfmt-corpus-separator --

FETCH c WITH (TIMEOUT = '1s')

-- sqlfmt-corpus-separator --

FETCH c WITH (TIMEOUT = '25h')

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES ('b', transaction_timestamp());
SELECT * FROM kv;
COMMIT

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (2, cluster_logical_timestamp());
SELECT * FROM kv;
COMMIT

-- sqlfmt-corpus-separator --

INSPECT SHARD 'u666'

-- sqlfmt-corpus-separator --

PREPARE a AS SELECT 1 = (SELECT $1::int)

-- sqlfmt-corpus-separator --

PREPARE b AS SELECT EXISTS (SELECT $1::int)

-- sqlfmt-corpus-separator --

PREPARE fizz_paginated AS
SELECT *
FROM fizz
ORDER BY a, b DESC
LIMIT $1
OFFSET $2

-- sqlfmt-corpus-separator --

PREPARE i1 AS
INSERT INTO t(a) VALUES($1);

-- sqlfmt-corpus-separator --

PREPARE i2 AS
INSERT INTO t(a) VALUES($1 - 1) RETURNING $1 + 1;

-- sqlfmt-corpus-separator --

PREPARE i3 AS
INSERT INTO t(a) VALUES(4) RETURNING $1 + $1;

-- sqlfmt-corpus-separator --

PREPARE i3 AS
INSERT INTO t(a) VALUES(4) RETURNING $1;

-- sqlfmt-corpus-separator --

PREPARE p AS SELECT repeat($1, $1);

-- sqlfmt-corpus-separator --

PREPARE p1 AS
SELECT $1 + $1::bigint;

-- sqlfmt-corpus-separator --

PREPARE p1 AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET $1;

-- sqlfmt-corpus-separator --

PREPARE p2 AS
SELECT
  (SELECT sum(a) FROM (
    SELECT a
    FROM foo
    ORDER BY a, b
    OFFSET $1
  ))
FROM foo AS outer_foo
OFFSET $2;

-- sqlfmt-corpus-separator --

PREPARE p2 AS
SELECT $1::bigint + $1::bigint;

-- sqlfmt-corpus-separator --

PREPARE p3 AS
SELECT $1 || $1;

-- sqlfmt-corpus-separator --

PREPARE p3 AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET $1 - 2;

-- sqlfmt-corpus-separator --

PREPARE p4 AS
SELECT $1::text || $1::bigint::text;

-- sqlfmt-corpus-separator --

PREPARE p4 AS
VALUES (0), (1), (2) OFFSET $1

-- sqlfmt-corpus-separator --

PREPARE p5 AS
SELECT $1, $1::bigint;

-- sqlfmt-corpus-separator --

PREPARE p5 AS
VALUES (10), (11), (12) OFFSET $1 - 1

-- sqlfmt-corpus-separator --

PREPARE p6 AS
SELECT $1 + $1::bigint, $1 || $1;

-- sqlfmt-corpus-separator --

PREPARE p6 AS
VALUES (10), (11), (12), ($2), ($3)
ORDER BY 1 DESC
OFFSET $1 - 1

-- sqlfmt-corpus-separator --

PREPARE p7 AS
SELECT $1 || $1, $1 + $1::bigint;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT
  (
    SELECT *
    FROM foo
    ORDER BY a, b
    OFFSET outer_foo.a
  )
FROM foo AS outer_foo;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT
  (
    SELECT *
    FROM foo
    ORDER BY a, b
    OFFSET outer_foo.a + $1
  )
FROM foo AS outer_foo;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT
  (
    SELECT a
    FROM foo
    ORDER BY a, b
    OFFSET lag(5) OVER ()
  )
FROM foo AS outer_foo;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET 'aaa';

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET -7;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET 5-7;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET a;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY a, b
OFFSET null;

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY b, a
OFFSET (SELECT 2);

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY b, a
OFFSET lag(5) OVER ();

-- sqlfmt-corpus-separator --

PREPARE p_error AS
SELECT *
FROM foo
ORDER BY b, a
OFFSET mz_now()::string::bigint;

-- sqlfmt-corpus-separator --

PREPARE p_error_1 AS
SELECT
  (
    SELECT b
    FROM foo
    ORDER BY a, b
    OFFSET outer_foo.a + $1
  )
FROM foo AS outer_foo;

-- sqlfmt-corpus-separator --

REASSIGN OWNED BY materialize TO joe

-- sqlfmt-corpus-separator --

ROLLBACK

-- sqlfmt-corpus-separator --

ROLLBACK AND CHAIN

-- sqlfmt-corpus-separator --

ROLLBACK;

-- sqlfmt-corpus-separator --

SELECT
  x,
  y,
  sum(y) OVER (),
  max(y) OVER (),
  min(y) OVER (),
  array_agg(y ORDER BY y) OVER (),
  array_agg(y ORDER BY y NULLS LAST) OVER (),
  array_agg(y ORDER BY y NULLS FIRST) OVER (),
  bool_and(x%3 != 0) OVER ()
FROM t7
ORDER BY x;

-- sqlfmt-corpus-separator --

SELECT
  x-y,
  x,
  y,
  array_agg(x ORDER BY CASE WHEN y IS NOT NULL THEN y ELSE x%5 END DESC) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  array_agg(2*x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING),
  list_agg(2*x) OVER (PARTITION BY x-y ORDER BY x ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)[2]
FROM t7
ORDER BY x-y, x;

-- sqlfmt-corpus-separator --

SELECT ((LIST[]::INT LIST)[:])::text

-- sqlfmt-corpus-separator --

SELECT (LIST [1, 2, 3, 4, 5][3:5][1:2][:])::text

-- sqlfmt-corpus-separator --

SELECT (LIST [1, 2, 3][:])::text

-- sqlfmt-corpus-separator --

SELECT (LIST [[1, 2, 3], [4, 5]][:100][:])::text

-- sqlfmt-corpus-separator --

SELECT (LIST [[[1, 2], [3, 4, 5]], [[6]], [[7, 8], [9]]][2:3][:][2:2])::text

-- sqlfmt-corpus-separator --

SELECT (LIST[NULL][:])::text

-- sqlfmt-corpus-separator --

SELECT (list_agg(a ORDER BY a) FILTER (WHERE b > '2050-01-01'))::text FROM t2

-- sqlfmt-corpus-separator --

SELECT (list_agg(a ORDER BY a) FILTER (WHERE b IS NOT NULL))::text FROM t2

-- sqlfmt-corpus-separator --

SELECT * FROM (
  (WITH c AS (SELECT 1) SELECT * FROM
    (WITH c AS (SELECT 2) SELECT * FROM c)
    UNION ALL
    SELECT * FROM c
  )
)

-- sqlfmt-corpus-separator --

SELECT * FROM (
  (WITH c AS (SELECT 1), c AS (SELECT 2)
  SELECT * FROM c UNION ALL SELECT * FROM c)
)

-- sqlfmt-corpus-separator --

SELECT * FROM (SHOW DEFAULT PRIVILEGES FOR r1) ORDER BY object_type, database, schema, grantee

-- sqlfmt-corpus-separator --

SELECT * FROM (SHOW DEFAULT PRIVILEGES ON TABLES) ORDER BY object_type, database, schema, grantee

-- sqlfmt-corpus-separator --

SELECT * FROM (SHOW DEFAULT PRIVILEGES) ORDER BY object_type, database, schema, grantee

-- sqlfmt-corpus-separator --

SELECT * FROM (SHOW NETWORK POLICIES)

-- sqlfmt-corpus-separator --

SELECT * FROM (SHOW PRIVILEGES FOR r2) ORDER BY object_type, database, schema, name, grantee

-- sqlfmt-corpus-separator --

SELECT * FROM (SHOW PRIVILEGES ON CLUSTERS) ORDER BY object_type, database, schema, name, grantee

-- sqlfmt-corpus-separator --

SELECT * FROM (SHOW PRIVILEGES) ORDER BY object_type, database, schema, name, grantee

-- sqlfmt-corpus-separator --

SELECT * FROM (SHOW ROLE MEMBERSHIP FOR r2) ORDER BY role, member

-- sqlfmt-corpus-separator --

SELECT * FROM (SHOW ROLE MEMBERSHIP) ORDER BY role, member

-- sqlfmt-corpus-separator --

SELECT * FROM (show client_encoding)

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a &< v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a &> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a -|- v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a >> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM daterange_values WHERE a IS NOT NULL
) daterange_values(a), daterange_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a &< v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a &> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a -|- v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a >> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int4range_values WHERE a IS NOT NULL
) int4range_values(a), int4range_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a &< v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a &> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a -|- v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a >> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM int8range_values WHERE a IS NOT NULL
) int8range_values(a), int8range_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a &< v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a &> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a -|- v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a >> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM numrange_values WHERE a IS NOT NULL
) numrange_values(a), numrange_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a &< v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a &> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a -|- v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a >> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tsrange_values WHERE a IS NOT NULL
) tsrange_values(a), tsrange_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a && v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a &< v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a &> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a -|- v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a << v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a <@ v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a >> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a t, array_agg(v ORDER BY v) FROM (
    SELECT DISTINCT a FROM tstzrange_values WHERE a IS NOT NULL
) tstzrange_values(a), tstzrange_test_values WHERE a @> v GROUP BY a ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b ORDER BY b ASC), array_agg(b ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b ORDER BY b) FROM t GROUP BY a HAVING array_agg(b ORDER BY b) = array_agg(b ORDER BY b DESC);

-- sqlfmt-corpus-separator --

SELECT a, array_agg(b), string_agg(c, ',' ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT array_agg((a, b) ORDER BY a DESC)::text FROM t2;

-- sqlfmt-corpus-separator --

SELECT array_agg((a, b) ORDER BY a DESC)::text, array_agg(a ORDER BY a DESC), array_agg(b ORDER BY b DESC) FROM t2;

-- sqlfmt-corpus-separator --

SELECT array_agg(a ORDER BY a/0)::text FROM (VALUES (1, -1)) AS a(a);

-- sqlfmt-corpus-separator --

SELECT array_agg(a ORDER BY no_such_column)::text FROM (VALUES (1, -1)) AS a(a);

-- sqlfmt-corpus-separator --

SELECT array_agg(b ORDER BY b ASC), array_agg(b ORDER BY b DESC), bool_or(b IS NOT NULL) FROM t;

-- sqlfmt-corpus-separator --

SELECT array_agg(column1 ORDER BY 1234)::text FROM (VALUES (1)) _;

-- sqlfmt-corpus-separator --

SELECT bound, (
    WITH MUTUALLY RECURSIVE
        numbers (n int) as (
            VALUES (1)
            UNION ALL
            (
                WITH rebound AS (SELECT * FROM numbers)
                SELECT distinct t1.n + t2.n AS n
                FROM rebound AS t1, rebound AS t2
                WHERE t1.n <= bound AND t2.n <= bound
            )
        )
    SELECT count(*) FROM numbers
)
FROM (
    SELECT generate_series AS bound FROM generate_series(1, 10)
);

-- sqlfmt-corpus-separator --

SELECT cluster, replica, size FROM (SHOW CLUSTER REPLICAS WHERE cluster != 'quickstart') ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT cluster, replica, size FROM (SHOW CLUSTER REPLICAS) ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT cluster, replica, size FROM (SHOW CLUSTER REPLICAS) WHERE cluster != 'quickstart' ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT create_sql FROM (SHOW CREATE INDEX i)

-- sqlfmt-corpus-separator --

SELECT create_sql FROM (SHOW CREATE MATERIALIZED VIEW mv)

-- sqlfmt-corpus-separator --

SELECT create_sql FROM (SHOW CREATE MATERIALIZED VIEW mv1);

-- sqlfmt-corpus-separator --

SELECT create_sql FROM (SHOW CREATE SOURCE s)

-- sqlfmt-corpus-separator --

SELECT create_sql FROM (SHOW CREATE TABLE t)

-- sqlfmt-corpus-separator --

SELECT create_sql FROM (SHOW REDACTED CREATE CONNECTION kafka_conn);

-- sqlfmt-corpus-separator --

SELECT create_sql FROM (SHOW REDACTED CREATE INDEX t_idx_i);

-- sqlfmt-corpus-separator --

SELECT create_sql FROM (SHOW REDACTED CREATE MATERIALIZED VIEW mv1);

-- sqlfmt-corpus-separator --

SELECT create_sql FROM (SHOW REDACTED CREATE TABLE redactable_t);

-- sqlfmt-corpus-separator --

SELECT create_sql FROM (SHOW REDACTED CREATE TABLE t);

-- sqlfmt-corpus-separator --

SELECT create_sql FROM (SHOW REDACTED CREATE VIEW v);

-- sqlfmt-corpus-separator --

SELECT id, normalize(text) FROM test_normalize ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, normalize(text, NFKC) FROM test_normalize ORDER BY id

-- sqlfmt-corpus-separator --

SELECT length(normalize('한글', NFC))

-- sqlfmt-corpus-separator --

SELECT length(normalize('한글', NFD))

-- sqlfmt-corpus-separator --

SELECT list[list[1,2], list[3,4]][:][2:]::text;

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY (SELECT 'a' FROM t2))::text FROM t2;

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY (SELECT * FROM t2)) FROM t2

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY (SELECT abs(-b)))::text FROM (VALUES (1, -1), (2, -2), (3, -3)) _ (a, b)

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY -a DESC)::text FROM (VALUES (1, -1), (2, -2), (3, -3)) _ (a, b)

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY a > 10, -a)::text FROM (VALUES (1, -1), (2, -2), (3, -3)) _ (a, b)

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY a DESC)::text FROM t2

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY a)::text FROM t2

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY a+1 DESC)::text FROM (VALUES (1, -1), (2, -2), (3, -3)) _ (a, b)

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY abs(b))::text FROM (VALUES (1, -1), (2, -2), (3, -3)) _ (a, b)

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY b)::text FROM (VALUES (1, -1), (2, -2), (3, -3)) _ (a, b)

-- sqlfmt-corpus-separator --

SELECT list_agg(a ORDER BY b)::text FROM t2

-- sqlfmt-corpus-separator --

SELECT map_agg(a, b ORDER BY b ASC)::TEXT FROM (VALUES ('a', 2), ('a', 1)) AS t (a, b);

-- sqlfmt-corpus-separator --

SELECT map_agg(a, b ORDER BY b DESC)::TEXT FROM (VALUES ('a', 2), ('a', 1)) AS t (a, b);

-- sqlfmt-corpus-separator --

SELECT name FROM (SHOW CLUSTERS LIKE 'q%')

-- sqlfmt-corpus-separator --

SELECT name FROM (SHOW CLUSTERS)

-- sqlfmt-corpus-separator --

SELECT name, comment FROM (SHOW CLUSTERS);

-- sqlfmt-corpus-separator --

SELECT name, comment FROM (SHOW COLUMNS FROM a);

-- sqlfmt-corpus-separator --

SELECT name, comment FROM (SHOW COLUMNS FROM c);

-- sqlfmt-corpus-separator --

SELECT name, comment FROM (SHOW COLUMNS FROM mv);

-- sqlfmt-corpus-separator --

SELECT name, comment FROM (SHOW INDEXES);

-- sqlfmt-corpus-separator --

SELECT name, comment FROM (SHOW MATERIALIZED VIEWS);

-- sqlfmt-corpus-separator --

SELECT name, comment FROM (SHOW SOURCES);

-- sqlfmt-corpus-separator --

SELECT name, comment FROM (SHOW VIEWS);

-- sqlfmt-corpus-separator --

SELECT name, replicas FROM (SHOW CLUSTERS) WHERE name != 'quickstart'

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

-- sqlfmt-corpus-separator --

SELECT now(DISTINCT)

-- sqlfmt-corpus-separator --

SELECT pretty_sql(create_sql) FROM (SHOW REDACTED CREATE CONNECTION kafka_conn);

-- sqlfmt-corpus-separator --

SELECT pretty_sql(create_sql) FROM (SHOW REDACTED CREATE MATERIALIZED VIEW mv1);

-- sqlfmt-corpus-separator --

SELECT pretty_sql(create_sql) FROM (SHOW REDACTED CREATE TABLE redactable_t)

-- sqlfmt-corpus-separator --

SELECT pretty_sql(create_sql) FROM (SHOW REDACTED CREATE VIEW v);

-- sqlfmt-corpus-separator --

SELECT regexp_replace(create_sql, 'AT \d+', 'XXX', 'g') FROM (SHOW CREATE MATERIALIZED VIEW mvi3);

-- sqlfmt-corpus-separator --

SELECT regexp_replace(create_sql, 'u[0-9]+', 'uX', 'g') FROM (SHOW REDACTED CREATE SOURCE s);

-- sqlfmt-corpus-separator --

SELECT regexp_replace(pretty_sql(create_sql), 'u[0-9]+', 'uX', 'g') FROM (SHOW REDACTED CREATE SOURCE s);

-- sqlfmt-corpus-separator --

SELECT sum(a ORDER BY b) FROM t2

-- sqlfmt-corpus-separator --

SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL SERIALIZABLE, ISOLATION LEVEL STRICT SERIALIZABLE

-- sqlfmt-corpus-separator --

SET TRANSACTION ISOLATION LEVEL STRICT SERIALIZABLE

-- sqlfmt-corpus-separator --

SET TRANSACTION ISOLATION LEVEL serializable

-- sqlfmt-corpus-separator --

SET TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM "A"

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM "B"

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM B

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM a

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM t

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM t1;

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM tz

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM v2;

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM v3;

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM v4;

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM webhook_bytes

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM webhook_bytes_include_headers

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM webhook_json

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM webhook_json_include_headers

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM webhook_text

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM webhook_text_include_headers

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM webhook_text_mapped_and_filtered_headers

-- sqlfmt-corpus-separator --

SHOW COLUMNS FROM webhook_text_with_mapped_headers

-- sqlfmt-corpus-separator --

SHOW COLUMNS IN mz_columns

-- sqlfmt-corpus-separator --

SHOW COLUMNS from v;

-- sqlfmt-corpus-separator --

SHOW CONNECTIONS

-- sqlfmt-corpus-separator --

SHOW CREATE CLUSTER c1

-- sqlfmt-corpus-separator --

SHOW CREATE INDEX enemy.enemy_v2_idx

-- sqlfmt-corpus-separator --

SHOW CREATE INDEX friend_again.enemy_v2_idx

-- sqlfmt-corpus-separator --

SHOW CREATE MATERIALIZED VIEW grand_friend.mv1;

-- sqlfmt-corpus-separator --

SHOW CREATE MATERIALIZED VIEW mv

-- sqlfmt-corpus-separator --

SHOW CREATE MATERIALIZED VIEW mv1;

-- sqlfmt-corpus-separator --

SHOW CREATE SOURCE mz_internal.mz_source_statistics

-- sqlfmt-corpus-separator --

SHOW CREATE SOURCE mz_introspection.mz_dataflow_channels

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE a1.t;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE b1.t

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE b2.t;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE b3.t;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE c2.c2;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE c3.c2;

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE mz_tables

-- sqlfmt-corpus-separator --

SHOW CREATE TABLE t1;

-- sqlfmt-corpus-separator --

SHOW CREATE TYPE int4;

-- sqlfmt-corpus-separator --

SHOW CREATE TYPE tx;

-- sqlfmt-corpus-separator --

SHOW CREATE TYPE y1;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW "XV"

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW "YV"

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW "cAsE".case;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW ADDER

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW MULTIPLIER

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW PG_ADDER

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW PG_MULTIPLIER

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW YV

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW c.ccc.v1;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW c.foo.v1;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW c1.v1;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW c2.v1;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW d.amb.v1;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW d.qualified_columns;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW d_renamed."case";

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW d_renamed.case;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW d_renamed.qualified_columns;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW enemy.v1;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW enemy.v2;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW foo

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW friend.v1;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW friend_again.v2;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW j.k.l;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW mv

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW pg_matviews

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW pg_views

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW temp_view;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v1

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v1;

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW v2

-- sqlfmt-corpus-separator --

SHOW CREATE VIEW xv

-- sqlfmt-corpus-separator --

SHOW INDEXES IN CLUSTER bar WHERE name NOT LIKE 'mz_%';

-- sqlfmt-corpus-separator --

SHOW INDEXES IN CLUSTER bar WHERE on = 'v';

-- sqlfmt-corpus-separator --

SHOW INDEXES ON "A"

-- sqlfmt-corpus-separator --

SHOW INDEXES ON "B"

-- sqlfmt-corpus-separator --

SHOW INDEXES ON B

-- sqlfmt-corpus-separator --

SHOW INDEXES ON a

-- sqlfmt-corpus-separator --

SHOW INDEXES ON mv

-- sqlfmt-corpus-separator --

SHOW INDEXES ON v IN CLUSTER bar;

-- sqlfmt-corpus-separator --

SHOW INDEXES on bar;

-- sqlfmt-corpus-separator --

SHOW INDEXES;

-- sqlfmt-corpus-separator --

SHOW MATERIALIZED VIEWS

-- sqlfmt-corpus-separator --

SHOW MATERIALIZED VIEWS IN CLUSTER other

-- sqlfmt-corpus-separator --

SHOW OBJECTS

-- sqlfmt-corpus-separator --

SHOW REDACTED CREATE MATERIALIZED VIEW aaaaaaa;

-- sqlfmt-corpus-separator --

SHOW REDACTED CREATE MATERIALIZED VIEW v;

-- sqlfmt-corpus-separator --

SHOW REDACTED CREATE TYPE ty;

-- sqlfmt-corpus-separator --

SHOW REDACTED CREATE VIEW mv1;

-- sqlfmt-corpus-separator --

SHOW ROLES

-- sqlfmt-corpus-separator --

SHOW ROLES LIKE 'f%'

-- sqlfmt-corpus-separator --

SHOW ROLES WHERE name = 'foo'

-- sqlfmt-corpus-separator --

SHOW SCHEMA

-- sqlfmt-corpus-separator --

SHOW SECRETS

-- sqlfmt-corpus-separator --

SHOW SECRETS FROM testschema

-- sqlfmt-corpus-separator --

SHOW SECRETS LIKE 'k%'

-- sqlfmt-corpus-separator --

SHOW SINKS;

-- sqlfmt-corpus-separator --

SHOW SOURCES

-- sqlfmt-corpus-separator --

SHOW SOURCES;

-- sqlfmt-corpus-separator --

SHOW TABLES

-- sqlfmt-corpus-separator --

SHOW TABLES;

-- sqlfmt-corpus-separator --

SHOW TIME ZONE

-- sqlfmt-corpus-separator --

SHOW TIMEZONE

-- sqlfmt-corpus-separator --

SHOW TYPES;

-- sqlfmt-corpus-separator --

SHOW VIEWS

-- sqlfmt-corpus-separator --

SHOW cluster

-- sqlfmt-corpus-separator --

SHOW cluster;

-- sqlfmt-corpus-separator --

SHOW extra_float_digits

-- sqlfmt-corpus-separator --

SHOW max_identifier_length

-- sqlfmt-corpus-separator --

SHOW search_path;

-- sqlfmt-corpus-separator --

SHOW transaction_isolation

-- sqlfmt-corpus-separator --

START TRANSACTION

-- sqlfmt-corpus-separator --

SUBSCRIBE (SELECT * FROM t1 GROUP BY a, b)

-- sqlfmt-corpus-separator --

SUBSCRIBE (SELECT 1) AS OF 10 UP TO 5;

-- sqlfmt-corpus-separator --

SUBSCRIBE (SELECT 1) AS OF NULL::timestamptz;

-- sqlfmt-corpus-separator --

SUBSCRIBE mv UP TO 'xxx';

-- sqlfmt-corpus-separator --

SUBSCRIBE mv UP TO -1;

-- sqlfmt-corpus-separator --

SUBSCRIBE mv UP TO current_database()::mz_timestamp;

-- sqlfmt-corpus-separator --

SUBSCRIBE mv UP TO current_database();

-- sqlfmt-corpus-separator --

SUBSCRIBE mv UP TO mz_now();

-- sqlfmt-corpus-separator --

SUBSCRIBE mv UP TO now();

-- sqlfmt-corpus-separator --

SUBSCRIBE mv UP TO null::mz_timestamp;

-- sqlfmt-corpus-separator --

SUBSCRIBE mv UP TO null;

-- sqlfmt-corpus-separator --

SUBSCRIBE mz_introspection.mz_compute_exports

-- sqlfmt-corpus-separator --

SUBSCRIBE v

-- sqlfmt-corpus-separator --

SUBSCRIBE v_one_off;

-- sqlfmt-corpus-separator --

TABLE abc

-- sqlfmt-corpus-separator --

TABLE materialize.public.t

-- sqlfmt-corpus-separator --

TABLE noexist

-- sqlfmt-corpus-separator --

TABLE t

-- sqlfmt-corpus-separator --

TABLE t UNION ALL TABLE t ORDER BY a LIMIT 5

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2)
        )
SELECT
    jsonb_agg(a ORDER BY a DESC)::text AS a_desc,
    jsonb_agg(a ORDER BY b)::text AS b,
    jsonb_agg(a ORDER BY b, a ASC)::text AS b_a_asc,
    jsonb_agg(a ORDER BY b, a DESC)::text AS b_a_desc
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2)
        )
SELECT
    jsonb_object_agg(b, a ORDER BY a DESC)::text AS a_desc,
    jsonb_object_agg(b, a ORDER BY b)::text AS b,
    jsonb_object_agg(b, a ORDER BY b, a ASC)::text AS b_a_asc,
    jsonb_object_agg(b, a ORDER BY b, a DESC)::text AS b_a_desc
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2)
        )
SELECT
    list_agg(a ORDER BY a DESC)::text AS a_desc,
    list_agg(a ORDER BY b)::text AS b,
    list_agg(a ORDER BY b, a ASC)::text AS b_a_asc,
    list_agg(a ORDER BY b, a DESC)::text AS b_a_desc
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2)
        )
SELECT
    string_agg(a, '-' ORDER BY a DESC)::text AS a_desc,
    string_agg(a, '-' ORDER BY b)::text AS b,
    string_agg(a, '-' ORDER BY b, a ASC)::text AS b_a_asc,
    string_agg(a, '-' ORDER BY b, a DESC)::text AS b_a_desc
FROM
    v

-- sqlfmt-corpus-separator --

WITH
    v (a, b)
        AS (
            VALUES
                ('a', 1),
                ('b', 2),
                ('c', 0),
                ('d', 2),
                ('e', NULL)
        )
SELECT
    array_agg(a ORDER BY a DESC)::text AS a_desc,
    array_agg(a ORDER BY b)::text AS b,
    array_agg(a ORDER BY b, a ASC)::text AS b_a_asc,
    array_agg(a ORDER BY b, a DESC)::text AS b_a_desc,
    array_agg(a ORDER BY b NULLS FIRST, a DESC)::text AS b_a_desc_nulls_first
FROM
    v

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x INT8) as (SELECT '1')
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x NUMERIC(38,2)) as (SELECT sum(a) + 1.23456 FROM y)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x NUMERIC) as (SELECT sum(a) + 1.23456 FROM y)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x NUMERIC) as (SELECT sum(a) FROM y)
SELECT pg_typeof(x) FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x NUMERIC) as (SELECT sum(a) FROM y)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x UINT2) as (SELECT -1::INT8)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x UINT2) as (SELECT 1::INT8)
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x list_numeric_scale_2) as (SELECT LIST['1'::TEXT])
SELECT x FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    bar(x list_numeric_scale_2) as (SELECT LIST[sum(a) + 1.2345] FROM y)
SELECT x::TEXT FROM bar

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    c1 (f1 INTEGER, f2 INTEGER, f3 INTEGER) AS (
        SELECT * FROM (VALUES (0, 0, 0))
        UNION ALL (
            SELECT
                a1.f1 + 1 AS f1,
                a1.f2 + 1 AS f2,
                a1.f3 + 1 AS f3
            FROM
                c1 AS a1,
                (
                    SELECT *
                    FROM c1 AS a1
                    LEFT JOIN c1 AS a2 USING (f2)
                    WHERE a1.f1 < 100 AND a2.f2 IS NULL
                ) AS a2
            WHERE a1 . f1 < 100
        )
    )
SELECT * FROM c1;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    evens(n int) AS (
        VALUES (1)
        UNION ALL
        SELECT n+1 FROM odds WHERE n < 100
    ),
    odds (n int) AS (
        VALUES (0)
        UNION ALL
        SELECT n+1 FROM evens
    ),
    both (n int) AS (
        SELECT * FROM evens
        UNION ALL
        SELECT * FROM odds
    )
SELECT sum(n) FROM both;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (
        SELECT 1, 2 UNION
        SELECT * FROM (
            SELECT MIN(c), 2 FROM bar
        )
    ),
    bar (c int) as (SELECT a FROM foo)
SELECT * FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (
        WITH MUTUALLY RECURSIVE
            foo (a int, b int) AS (SELECT 1, 2 UNION SELECT c, 5 FROM bar),
            bar (c int) as (SELECT a FROM foo)
        SELECT a, c FROM foo, bar
    ),
    bar (a int) as (SELECT a FROM foo)
SELECT a FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT (
        SELECT MIN(c) FROM bar
    ), 2 UNION SELECT 5, 5 FROM bar),
    bar (c int) as (SELECT a FROM foo)
SELECT * FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1 UNION SELECT a FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT a FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT 5, 5 FROM bar),
    bar (c int) as (SELECT c FROM foo)
SELECT * FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 5 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT a FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 5 FROM bar),
    bar (c int) as (SELECT c FROM foo)
SELECT * FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT (SELECT COUNT(*) FROM foo) FROM bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT * FROM bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a int, b int) AS (SELECT 1, 2, 3 UNION SELECT a, 5, 6 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT a FROM foo, bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    foo (a text, b int) AS (SELECT 1, 2 UNION SELECT a, 7 FROM bar),
    bar (a int) as (SELECT a FROM foo)
SELECT * FROM bar;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    label (node int, comp int) AS (
        SELECT dst, MIN(comp)
        FROM (
            SELECT dst, dst AS comp FROM edges
            UNION ALL
            SELECT edges.dst, label.comp
            FROM edges, label
            WHERE edges.src = label.node
        )
        GROUP BY dst
    )
SELECT round, COUNT(*) FROM (
    WITH MUTUALLY RECURSIVE
        relabel (node int, comp int, round int) AS (
            SELECT DISTINCT ON(node) node, comp, round
            FROM (
                SELECT node, comp, 0 as round FROM label
                UNION ALL
                SELECT edges.dst, relabel.comp, relabel.round + 1
                FROM edges, relabel
                WHERE edges.src = relabel.node
            )
            ORDER BY node, comp
        )
    SELECT round FROM relabel
)
GROUP BY round;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    numbers (n int) as (
        VALUES (1)
        UNION ALL
        (
            WITH rebound AS (SELECT * FROM numbers)
            SELECT distinct t1.n + t2.n AS n
            FROM rebound AS t1, rebound AS t2
            WHERE t1.n <= 256 AND t2.n <= 256
        )
    )
SELECT count(*) FROM numbers;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    t (n int) AS (
        VALUES (1)
        UNION ALL
        SELECT n+1 FROM t WHERE n < 100
    )
SELECT sum(n) FROM t;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
    ties(slower NUMERIC, faster NUMERIC) AS (
        SELECT
            (time + sqrt(time * time - 4 * distance)) / 2 as slower,
            (time - sqrt(time * time - 4 * distance)) / 2 as faster
        FROM input
    ),
    options(choices NUMERIC) AS (
        SELECT 1 + FLOOR(slower)::NUMERIC - CEIL(faster)::NUMERIC FROM ties
    ),
    part12(part12 NUMERIC) AS (
        SELECT pow(10.0, SUM(log(choices))) FROM options
    )
SELECT * FROM part12;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
  c0(key int, a int) AS (
    SELECT * FROM c2
    UNION
    SELECT a, a FROM t
  ),
  c1(key int, a int) AS (
    SELECT key + 1, -a FROM c0
  ),
  c2(key int, a int) AS (
    SELECT c0.key + c1.key, c0.a + c1.a
    FROM c0, c1
    WHERE c0.key = c1.key
  )
SELECT * FROM c2
ORDER BY 1, 2;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
  cnt (i int) AS (
    (WITH MUTUALLY RECURSIVE
       cnt (i int) AS (
         SELECT 1 AS i
         UNION
         SELECT i+1 FROM cnt WHERE i < 3)
       SELECT i FROM cnt
    )
    UNION
    SELECT i+100 FROM cnt WHERE i < 500)
SELECT i FROM cnt
ORDER BY i;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
  xaxis(x double) AS (VALUES(-2.0) UNION ALL SELECT x+0.05 FROM xaxis WHERE x<1.2),
  yaxis(y double) AS (VALUES(-1.0) UNION ALL SELECT y+0.1 FROM yaxis WHERE y<1.0),
  m(iter int, cx double, cy double, x double, y double) AS (
    SELECT 0, x, y, 0.0, 0.0 FROM xaxis, yaxis
    UNION ALL
    SELECT iter+1, cx, cy, x*x-y*y + cx, 2.0*x*y + cy FROM m
     WHERE (x*x + y*y) < 4.0 AND iter<28
  ),
  m2(iter int, cx double, cy double) AS (
    SELECT max(iter), cx, cy FROM m GROUP BY cx, cy
  ),
  a(t text, cy double) AS (
    SELECT string_agg( substr(' .+*#', 1+least(iter/7,4), 1), '' ORDER BY cx), cy
    FROM m2 GROUP BY cy
  )
SELECT string_agg(rtrim(t), chr(10) ORDER BY cy) FROM a;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE
lines(line string) AS (
    SELECT
        regexp_split_to_table(input, '\n') AS line
    FROM
        aoc_1204
),
cards(match string[]) AS (
    SELECT
        regexp_match(line, 'Card +(\d+): (.*)') AS match
    FROM
        lines
),
card_parts(card_id int, parts string[]) AS (
    SELECT
        match[1]::int AS card_id,
        regexp_split_to_array(match[2], ' \| ') AS parts
    FROM
        cards
),
winners(card_id int, val int) AS (
    SELECT
        card_id,
        regexp_split_to_table(trim(parts[1]), '\s+')::int AS val
    FROM
        card_parts
),
ours(card_id int, val int) AS (
    SELECT
        card_id,
        regexp_split_to_table(trim(parts[2]), '\s+')::int AS val
    FROM
        card_parts
),
count_winning_numbers(card_id int, count int) AS (
    SELECT
        ours.card_id,
        count(winners.val)::int AS count
    FROM
        ours LEFT OUTER JOIN winners ON (
            ours.card_id = winners.card_id AND
            ours.val = winners.val
        )
    GROUP BY ours.card_id
),
prizes(card_id int, prize_id int) AS (
    SELECT
        card_id,
        prize_id
    FROM
        count_winning_numbers CROSS JOIN generate_series(card_id + 1, card_id + count) AS prize_id
    UNION
    SELECT
        0 AS card_id,
        ours.card_id AS prize_id
    FROM
        ours
),
multipliers(card_id int, multiplier int) AS (
    SELECT
        prizes.prize_id AS card_id,
        SUM(coalesce(multipliers.multiplier, 1))::int AS multiplier
    FROM
        prizes left outer JOIN multipliers ON (
            prizes.card_id = multipliers.card_id
        )
    GROUP BY prizes.prize_id
)
SELECT
    SUM(multiplier) AS answer
FROM
    multipliers;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (ERROR AT RECURSION LIMIT 3)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (ERROR AT RECURSION LIMIT 3, RETURN AT RECURSION LIMIT 5)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT -3)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT 0)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT 3, ERROR AT RECURSION LIMIT 5)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT 3, RECURSION LIMIT 5)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT 3, RETURN AT RECURSION LIMIT 5)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT aaaaaaa)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RECURSION LIMIT)
  cnt (i int) AS (SELECT 1 AS i UNION SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 100)
    t (n int) AS (
        VALUES (1)
        UNION ALL
        SELECT n+1 FROM t
    )
SELECT sum(n) FROM t;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 100)
    t0 (n int) AS (
        VALUES (1)
        UNION ALL
        SELECT n+1 FROM t0
    ),
    t1 (n int) AS (
        VALUES (-1)
        UNION ALL
        SELECT n+1 FROM t1
    )
SELECT (SELECT sum(n) FROM t0) - (SELECT sum(n) FROM t1);

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 3)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 6)
  cnt (i int) AS (
    (WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 3)
       cnt (i int) AS (
         SELECT 1 AS i
         UNION
         SELECT i+1 FROM cnt)
       SELECT i FROM cnt
    )
    UNION
    SELECT i+100 FROM cnt)
SELECT i FROM cnt
ORDER BY i;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT = 3)
  c0(f1 int) as (
    (SELECT * FROM t5)
    UNION
    (SELECT t5.f1 + c0.f1
    FROM t5, c0
    WHERE (t5.f1 = 0 OR t5.f1 = 2 OR t5.f1 = 8))
  )
SELECT * FROM c0;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT = 3)
  cnt (i int) AS (
    SELECT 1 AS i
    UNION
    SELECT i+1 FROM cnt)
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

WITH MUTUALLY RECURSIVE input(a int) AS (
    SELECT generate_series(1, 40000) AS a
    UNION
    SELECT DISTINCT ON(a) a
    FROM input
    WHERE a > 20000
)
SELECT MAX(a)
FROM input;

-- sqlfmt-corpus-separator --

WITH foo AS (SELECT 1)
  (SELECT * FROM foo
    UNION ALL
  (WITH foo AS (SELECT 2) SELECT * FROM foo)
    UNION ALL
  (SELECT * FROM foo))

-- sqlfmt-corpus-separator --

WITH outermost(x) AS (
  SELECT 1
  UNION (WITH innermost as (SELECT 2)
         SELECT * FROM innermost
         UNION SELECT 3)
)
SELECT * FROM outermost ORDER BY 1;

-- sqlfmt-corpus-separator --

WITH outermost(x) AS (
  SELECT 1
  UNION (WITH innermost as (SELECT 2)
         SELECT * FROM outermost  -- fail
         UNION SELECT * FROM innermost)
)
SELECT * FROM outermost ORDER BY 1;

-- sqlfmt-corpus-separator --

begin;

-- sqlfmt-corpus-separator --

create cluster c replicas (r1 (STORAGECTL ADDRESSES ['s:1'], STORAGE ADDRESSES ['st:1'], COMPUTECTL ADDRESSES ['c:1'], COMPUTE ADDRESSES ['ct:1']))

-- sqlfmt-corpus-separator --

create schema s

-- sqlfmt-corpus-separator --

create schema testschema

-- sqlfmt-corpus-separator --

create schema to_be_dropped

-- sqlfmt-corpus-separator --

create secret a AS (SELECT * from t1);

-- sqlfmt-corpus-separator --

create secret aa_secret as 'a' || 'a'

-- sqlfmt-corpus-separator --

create secret ab_secret as ('a' || 'b')::bytea

-- sqlfmt-corpus-separator --

create secret secret_1024 as REPEAT('x', 1024 * 1024)::bytea;

-- sqlfmt-corpus-separator --

create secret secret_512 as REPEAT('x', 1024 * 512)::bytea;

-- sqlfmt-corpus-separator --

create type complex as (r float8, i float8);

-- sqlfmt-corpus-separator --

create type quad as (c1 complex, c2 complex);

-- sqlfmt-corpus-separator --

create type testtype1 as (a int, b int);

-- sqlfmt-corpus-separator --

create type testtype3 as (a int, b text);

-- sqlfmt-corpus-separator --

create type testtype5 as (a int);

-- sqlfmt-corpus-separator --

create type testtype6 as (inner testtype1);

-- sqlfmt-corpus-separator --

create type testtype8 as (f1 int, f2 int);

-- sqlfmt-corpus-separator --

select * from (SHOW NETWORK POLICIES)

-- sqlfmt-corpus-separator --

show roles

-- sqlfmt-corpus-separator --

show search_path

-- sqlfmt-corpus-separator --

show users

-- sqlfmt-corpus-separator --

with mutually recursive
    -- Parse the input up
    lines(line TEXT) as (select regexp_split_to_table(input, '\n') as line from input),
    games(game TEXT, report TEXT) as (select regexp_split_to_array(line, ':')[1], regexp_split_to_array(line, ':')[2] from lines),
    round(game TEXT, visible TEXT) as (select game, regexp_split_to_table(report, ';') from games),
    bacon(game TEXT, color TEXT) as (select game, regexp_split_to_table(visible, ',') from round),
    parsed(game INT, color TEXT, number INT) as (
        select
            substring(game, 5)::INT as game,
            regexp_split_to_array(color, ' ')[3] as color,
            regexp_split_to_array(color, ' ')[2]::INT as number
        from bacon
    ),
    -- PART 1
    limits(color TEXT, number INT) as (SELECT * FROM (VALUES ('red', 12), ('green', 13), ('blue', 14))),
    bad_news(game INT) as (
        select game
        from parsed, limits
        where parsed.color = limits.color
          AND parsed.number > limits.number
    ),
    plausible(game INT) as (select distinct parsed.game from parsed left join bad_news on(parsed.game = bad_news.game) where bad_news.game IS NULL),
    part1(part1 BIGINT) as (select SUM(game) from plausible),
    -- PART 2
    maximum(game INT, color TEXT, number INT) as (select game, color, max(number) from parsed GROUP BY game, color),
    red(game INT) as (select game from maximum, generate_series(1, number) where color = 'red'),
    blue(game INT) as (select game from maximum, generate_series(1, number) where color = 'blue'),
    green(game INT) as (select game from maximum, generate_series(1, number) where color = 'green'),
    power(game INT, product BIGINT) as (SELECT red.game, count(*) from red, blue, green where red.game = blue.game and blue.game = green.game GROUP BY red.game),
    part2(part2 BIGINT) as (select sum(product)::BIGINT from power)
select * from part1, part2;

-- sqlfmt-corpus-separator --

with mutually recursive
    a(x int) as (select * from a)
select * from a;