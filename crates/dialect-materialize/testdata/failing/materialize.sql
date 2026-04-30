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

-- Query 07
CREATE VIEW Q07 AS
SELECT
    supp_nation,
    cust_nation,
    l_year,
    sum(volume) AS revenue
FROM
    (
        SELECT
            n1.n_name AS supp_nation,
            n2.n_name AS cust_nation,
            extract(year FROM l_shipdate) AS l_year,
            l_extendedprice * (1 - l_discount) AS volume
        FROM
            supplier,
            lineitem,
            orders,
            customer,
            nation n1,
            nation n2
        WHERE
            s_suppkey = l_suppkey
            AND o_orderkey = l_orderkey
            AND c_custkey = o_custkey
            AND s_nationkey = n1.n_nationkey
            AND c_nationkey = n2.n_nationkey
            AND (
                (n1.n_name = 'FRANCE' AND n2.n_name = 'GERMANY')
                or (n1.n_name = 'GERMANY' AND n2.n_name = 'FRANCE')
            )
            AND l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
    ) AS shipping
GROUP BY
    supp_nation,
    cust_nation,
    l_year
ORDER BY
    supp_nation,
    cust_nation,
    l_year;

-- sqlfmt-corpus-separator --

-- Query 07
EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
CREATE MATERIALIZED VIEW Q07 AS
SELECT
    supp_nation,
    cust_nation,
    l_year,
    sum(volume) AS revenue
FROM
    (
        SELECT
            n1.n_name AS supp_nation,
            n2.n_name AS cust_nation,
            extract(year FROM l_shipdate) AS l_year,
            l_extendedprice * (1 - l_discount) AS volume
        FROM
            supplier,
            lineitem,
            orders,
            customer,
            nation n1,
            nation n2
        WHERE
            s_suppkey = l_suppkey
            AND o_orderkey = l_orderkey
            AND c_custkey = o_custkey
            AND s_nationkey = n1.n_nationkey
            AND c_nationkey = n2.n_nationkey
            AND (
                (n1.n_name = 'FRANCE' AND n2.n_name = 'GERMANY')
                or (n1.n_name = 'GERMANY' AND n2.n_name = 'FRANCE')
            )
            AND l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
    ) AS shipping
GROUP BY
    supp_nation,
    cust_nation,
    l_year
ORDER BY
    supp_nation,
    cust_nation,
    l_year;

-- sqlfmt-corpus-separator --

-- Query 07
EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
SELECT
    supp_nation,
    cust_nation,
    l_year,
    sum(volume) AS revenue
FROM
    (
        SELECT
            n1.n_name AS supp_nation,
            n2.n_name AS cust_nation,
            extract(year FROM l_shipdate) AS l_year,
            l_extendedprice * (1 - l_discount) AS volume
        FROM
            supplier,
            lineitem,
            orders,
            customer,
            nation n1,
            nation n2
        WHERE
            s_suppkey = l_suppkey
            AND o_orderkey = l_orderkey
            AND c_custkey = o_custkey
            AND s_nationkey = n1.n_nationkey
            AND c_nationkey = n2.n_nationkey
            AND (
                (n1.n_name = 'FRANCE' AND n2.n_name = 'GERMANY')
                or (n1.n_name = 'GERMANY' AND n2.n_name = 'FRANCE')
            )
            AND l_shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
    ) AS shipping
GROUP BY
    supp_nation,
    cust_nation,
    l_year
ORDER BY
    supp_nation,
    cust_nation,
    l_year;

-- sqlfmt-corpus-separator --

-- Query 08
CREATE VIEW Q08 AS
SELECT
    o_year,
    sum(case
        when nation = 'BRAZIL' then volume
        else 0
    end) / sum(volume) AS mkt_share
FROM
    (
        SELECT
            extract(year FROM o_orderdate) AS o_year,
            l_extendedprice * (1 - l_discount) AS volume,
            n2.n_name AS nation
        FROM
            part,
            supplier,
            lineitem,
            orders,
            customer,
            nation n1,
            nation n2,
            region
        WHERE
            p_partkey = l_partkey
            AND s_suppkey = l_suppkey
            AND l_orderkey = o_orderkey
            AND o_custkey = c_custkey
            AND c_nationkey = n1.n_nationkey
            AND n1.n_regionkey = r_regionkey
            AND r_name = 'AMERICA'
            AND s_nationkey = n2.n_nationkey
            AND o_orderdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
            AND p_type = 'ECONOMY ANODIZED STEEL'
    ) AS all_nations
GROUP BY
    o_year
ORDER BY
    o_year;

-- sqlfmt-corpus-separator --

-- Query 08
EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
CREATE MATERIALIZED VIEW Q08 AS
SELECT
    o_year,
    sum(case
        when nation = 'BRAZIL' then volume
        else 0
    end) / sum(volume) AS mkt_share
FROM
    (
        SELECT
            extract(year FROM o_orderdate) AS o_year,
            l_extendedprice * (1 - l_discount) AS volume,
            n2.n_name AS nation
        FROM
            part,
            supplier,
            lineitem,
            orders,
            customer,
            nation n1,
            nation n2,
            region
        WHERE
            p_partkey = l_partkey
            AND s_suppkey = l_suppkey
            AND l_orderkey = o_orderkey
            AND o_custkey = c_custkey
            AND c_nationkey = n1.n_nationkey
            AND n1.n_regionkey = r_regionkey
            AND r_name = 'AMERICA'
            AND s_nationkey = n2.n_nationkey
            AND o_orderdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
            AND p_type = 'ECONOMY ANODIZED STEEL'
    ) AS all_nations
GROUP BY
    o_year
ORDER BY
    o_year;

-- sqlfmt-corpus-separator --

-- Query 08
EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
SELECT
    o_year,
    sum(case
        when nation = 'BRAZIL' then volume
        else 0
    end) / sum(volume) AS mkt_share
FROM
    (
        SELECT
            extract(year FROM o_orderdate) AS o_year,
            l_extendedprice * (1 - l_discount) AS volume,
            n2.n_name AS nation
        FROM
            part,
            supplier,
            lineitem,
            orders,
            customer,
            nation n1,
            nation n2,
            region
        WHERE
            p_partkey = l_partkey
            AND s_suppkey = l_suppkey
            AND l_orderkey = o_orderkey
            AND o_custkey = c_custkey
            AND c_nationkey = n1.n_nationkey
            AND n1.n_regionkey = r_regionkey
            AND r_name = 'AMERICA'
            AND s_nationkey = n2.n_nationkey
            AND o_orderdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
            AND p_type = 'ECONOMY ANODIZED STEEL'
    ) AS all_nations
GROUP BY
    o_year
ORDER BY
    o_year;

-- sqlfmt-corpus-separator --

-- Query 09
CREATE VIEW Q09 AS
SELECT
    nation,
    o_year,
    sum(amount) AS sum_profit
FROM
    (
        SELECT
            n_name AS nation,
            extract(year FROM o_orderdate) AS o_year,
            l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount
        FROM
            part,
            supplier,
            lineitem,
            partsupp,
            orders,
            nation
        WHERE
            s_suppkey = l_suppkey
            AND ps_suppkey = l_suppkey
            AND ps_partkey = l_partkey
            AND p_partkey = l_partkey
            AND o_orderkey = l_orderkey
            AND s_nationkey = n_nationkey
            AND p_name like '%green%'
    ) AS profit
GROUP BY
    nation,
    o_year
ORDER BY
    nation,
    o_year DESC;

-- sqlfmt-corpus-separator --

-- Query 09
EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
CREATE MATERIALIZED VIEW Q09 AS
SELECT
    nation,
    o_year,
    sum(amount) AS sum_profit
FROM
    (
        SELECT
            n_name AS nation,
            extract(year FROM o_orderdate) AS o_year,
            l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount
        FROM
            part,
            supplier,
            lineitem,
            partsupp,
            orders,
            nation
        WHERE
            s_suppkey = l_suppkey
            AND ps_suppkey = l_suppkey
            AND ps_partkey = l_partkey
            AND p_partkey = l_partkey
            AND o_orderkey = l_orderkey
            AND s_nationkey = n_nationkey
            AND p_name like '%green%'
    ) AS profit
GROUP BY
    nation,
    o_year
ORDER BY
    nation,
    o_year DESC;

-- sqlfmt-corpus-separator --

-- Query 09
EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
SELECT
    nation,
    o_year,
    sum(amount) AS sum_profit
FROM
    (
        SELECT
            n_name AS nation,
            extract(year FROM o_orderdate) AS o_year,
            l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity AS amount
        FROM
            part,
            supplier,
            lineitem,
            partsupp,
            orders,
            nation
        WHERE
            s_suppkey = l_suppkey
            AND ps_suppkey = l_suppkey
            AND ps_partkey = l_partkey
            AND p_partkey = l_partkey
            AND o_orderkey = l_orderkey
            AND s_nationkey = n_nationkey
            AND p_name like '%green%'
    ) AS profit
GROUP BY
    nation,
    o_year
ORDER BY
    nation,
    o_year DESC;

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

CREATE MATERIALIZED VIEW err AS
SELECT *
FROM foo
ORDER BY b, a
OFFSET mz_now()::string::bigint;

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

CREATE MATERIALIZED VIEW foobar26 AS
  SELECT tableA.id
    FROM tableA
   WHERE ((1000 * cast(extract(epoch FROM tableA.happened_at) AS numeric)) <= mz_now()
     AND mz_now() <= (1000 * cast(extract(epoch FROM tableA.happened_at) AS numeric) + offs ))
     AND id = 10;

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

CREATE MATERIALIZED VIEW mv1 AS
SELECT *
FROM t2
WHERE ts + INTERVAL '30' minutes >= mz_now();

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv1 AS
SELECT count(*)
FROM events
WHERE mz_now() >= insert_ms
  AND mz_now() < delete_ms;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv10 AS
SELECT * from items
WHERE mz_now() <= date_trunc(
    'month',
    ship_time
    - (
        CASE WHEN EXTRACT(MONTH FROM ship_time) < 6 THEN EXTRACT(MONTH FROM ship_time) + 6 ELSE 0 END
        + CASE WHEN EXTRACT(MONTH FROM ship_time) >= 6 THEN EXTRACT(MONTH FROM ship_time) - 6 ELSE 0 END
    )
    * INTERVAL '1 months'
);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv11 AS
SELECT * from items
WHERE CASE WHEN id = 10 THEN EXTRACT(MONTH FROM ship_time) ELSE 0 END < mz_now();

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv12 AS
SELECT * from items
WHERE CASE WHEN EXTRACT(MONTH FROM ship_time) >= 6 THEN 12 ELSE 0 END < mz_now();

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv2 AS
SELECT *, row_number() OVER (ORDER BY t) AS rn
FROM mv1;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv2 AS
SELECT content, insert_ms
FROM events
-- The event should appear in only one interval of duration `10000`.
-- The interval begins here ...
WHERE mz_now() >= 10000 * (insert_ms / 10000)
-- ... and ends here.
  AND mz_now() < 10000 * (1 + insert_ms / 10000);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv3 AS
SELECT *
FROM t2
WHERE
  ts + INTERVAL '30' minutes >= mz_now()
  AND x != 7;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv3 AS
SELECT content, insert_ms
FROM events
-- The event should appear in `6` intervals each of width `10000`.
-- The interval begins here ...
WHERE mz_now() >= 10000 * (insert_ms / 10000)
-- ... and ends here.
  AND mz_now() < 6 * (10000 + insert_ms / 10000);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv4 AS
(
    SELECT *
    FROM t2
    WHERE x = 7
)
UNION ALL
(
  SELECT *
  FROM t2
  WHERE
    ts + INTERVAL '30' minutes >= mz_now()
    AND x != 7
);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv4 AS
SELECT content, insert_ms
FROM events
-- The event should appear inside the interval that begins at
-- `insert_ms` and ends at  `insert_ms + 30000`.
-- The interval begins here ..
WHERE mz_now() >= insert_ms
-- ... and ends here.
  AND mz_now() < insert_ms + 30000;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv5 AS
SELECT *
FROM t2
WHERE ts + INTERVAL '30' minutes >= mz_now()
UNION ALL
SELECT *
FROM t2
WHERE ts + INTERVAL '60' minutes >= mz_now();

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv5 AS
SELECT content, insert_ms, delete_ms
FROM events
WHERE mz_now() >= insert_ms + 60000
  AND mz_now() < delete_ms + 60000;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv6 AS
SELECT content, insert_ms, delete_ms
FROM events
WHERE COALESCE(delete_ms, insert_ms) < mz_now();

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv7 AS
SELECT content, insert_ms, delete_ms
FROM events
WHERE mz_now() < delete_ms + 10000
  AND mz_now() < delete_ms + 20000
  AND mz_now() < delete_ms + 30000
  AND mz_now() < delete_ms + 40000
  AND mz_now() < delete_ms + 50000
  AND mz_now() < delete_ms + 60000
  AND mz_now() < delete_ms + 70000
  AND mz_now() < delete_ms + 80000
  AND mz_now() < delete_ms + 90000;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv8 AS
SELECT content, inserted_at
FROM events_timestamped
WHERE mz_now() < try_parse_monotonic_iso8601_timestamp(content);

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv9 AS
with cte as (
  select x, t, case when x=0 then t - INTERVAL '1' day else t - INTERVAL '2' day end as case_statement from t
)
select x, t from cte
where case_statement < mz_now();

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

CREATE MATERIALIZED VIEW mv_dynamic_pricing AS
WITH recent_prices AS (
	SELECT grp.product_id, AVG(price) AS avg_price
	FROM (SELECT DISTINCT product_id FROM sales) grp,
	LATERAL (
		SELECT product_id, price
		FROM sales
		WHERE sales.product_id = grp.product_id
		ORDER BY sale_date DESC LIMIT 10
	) sub
	GROUP BY grp.product_id
),
promotion_effect AS (
	SELECT
		p.product_id,
		MIN(pr.promotion_discount) AS promotion_discount
	FROM promotions pr
	JOIN products p ON pr.product_id = p.product_id
	WHERE pr.active = TRUE
	GROUP BY p.product_id
),
popularity_score AS (
	SELECT
		s.product_id,
		RANK() OVER (PARTITION BY p.category_id ORDER BY COUNT(s.sale_id) DESC) AS popularity_rank,
		COUNT(s.sale_id) AS sale_count
	FROM sales s
	JOIN products p ON s.product_id = p.product_id
	GROUP BY s.product_id, p.category_id
),
inventory_status AS (
	SELECT
		i.product_id,
		SUM(i.stock) AS total_stock,
		RANK() OVER (ORDER BY SUM(i.stock) DESC) AS stock_rank
	FROM inventory i
	GROUP BY i.product_id
),
high_demand_products AS (
	SELECT
		p.product_id,
		AVG(s.sale_price) AS avg_sale_price,
		COUNT(s.sale_id) AS total_sales
	FROM products p
	JOIN sales s ON p.product_id = s.product_id
	GROUP BY p.product_id
	HAVING COUNT(s.sale_id) > (SELECT AVG(total_sales) FROM (SELECT COUNT(*) AS total_sales FROM sales GROUP BY product_id) subquery)
),
dynamic_pricing AS (
	SELECT
		p.product_id,
		p.base_price,
		CASE
			WHEN pop.popularity_rank <= 3 THEN 1.2
			WHEN pop.popularity_rank BETWEEN 4 AND 10 THEN 1.1
			ELSE 0.9
		END AS popularity_adjustment,
		rp.avg_price,
		COALESCE(1.0 - (pe.promotion_discount / 100), 1) AS promotion_discount,
		CASE
			WHEN inv.stock_rank <= 3 THEN 1.1
			WHEN inv.stock_rank BETWEEN 4 AND 10 THEN 1.05
			ELSE 1
		END AS stock_adjustment,
		CASE
			WHEN p.base_price > rp.avg_price THEN 1 + (p.base_price - rp.avg_price) / rp.avg_price
			ELSE 1 - (rp.avg_price - p.base_price) / rp.avg_price
		END AS demand_multiplier,
		hd.avg_sale_price,
		CASE
			WHEN p.product_name ilike '%cheap%' THEN 0.8
			ELSE 1.0
		END AS additional_discount
	FROM products p
	LEFT JOIN recent_prices rp ON p.product_id = rp.product_id
	LEFT JOIN promotion_effect pe ON p.product_id = pe.product_id
	JOIN popularity_score pop ON p.product_id = pop.product_id
	LEFT JOIN inventory_status inv ON p.product_id = inv.product_id
	LEFT JOIN high_demand_products hd ON p.product_id = hd.product_id
)
SELECT
	dp.product_id,
	dp.base_price * dp.popularity_adjustment * dp.promotion_discount * dp.stock_adjustment * dp.demand_multiplier * dp.additional_discount AS adjusted_price,
	p.last_update_time
FROM dynamic_pricing dp
JOIN products p ON dp.product_id = p.product_id;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv_err AS
SELECT *
FROM t2
WHERE
  ts + INTERVAL '30' minutes >= mz_now()
  OR ts IS NULL;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv_err AS
SELECT *
FROM t2
WHERE
  x = 7
  OR ts + INTERVAL '30' minutes >= mz_now();

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mv_err AS
SELECT *
FROM t2
WHERE ts >= mz_now() - INTERVAL '30' minutes;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW v1 AS
WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 2)
  cnt (f1 INTEGER) AS (
    SELECT f1 FROM t1 UNION ALL SELECT f1+1 AS f1 FROM cnt
  )
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW valid AS
SELECT *
FROM intervals
WHERE mz_now() BETWEEN a AND b;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW valid_events AS
SELECT content, count(*)
FROM events
WHERE mz_now() >= insert_ts
  AND mz_now()  < delete_ts
GROUP BY content;

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW valid_max AS
SELECT *
FROM intervals_max
WHERE mz_now() BETWEEN a AND b

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

CREATE VIEW dynamic_pricing AS
WITH recent_prices AS (
	SELECT grp.product_id, AVG(price) AS avg_price
	FROM (SELECT DISTINCT product_id FROM sales) grp,
	LATERAL (
		SELECT product_id, price
		FROM sales
		WHERE sales.product_id = grp.product_id
		ORDER BY sale_date DESC LIMIT 10
	) sub
	GROUP BY grp.product_id
),
promotion_effect AS (
	SELECT
		p.product_id,
		MIN(pr.promotion_discount) AS promotion_discount
	FROM promotions pr
	JOIN products p ON pr.product_id = p.product_id
	WHERE pr.active = TRUE
	GROUP BY p.product_id
),
popularity_score AS (
	SELECT
		s.product_id,
		RANK() OVER (PARTITION BY p.category_id ORDER BY COUNT(s.sale_id) DESC) AS popularity_rank,
		COUNT(s.sale_id) AS sale_count
	FROM sales s
	JOIN products p ON s.product_id = p.product_id
	GROUP BY s.product_id, p.category_id
),
inventory_status AS (
	SELECT
		i.product_id,
		SUM(i.stock) AS total_stock,
		RANK() OVER (ORDER BY SUM(i.stock) DESC) AS stock_rank
	FROM inventory i
	GROUP BY i.product_id
),
high_demand_products AS (
	SELECT
		p.product_id,
		AVG(s.sale_price) AS avg_sale_price,
		COUNT(s.sale_id) AS total_sales
	FROM products p
	JOIN sales s ON p.product_id = s.product_id
	GROUP BY p.product_id
	HAVING COUNT(s.sale_id) > (SELECT AVG(total_sales) FROM (SELECT COUNT(*) AS total_sales FROM sales GROUP BY product_id) subquery)
),
dynamic_pricing AS (
	SELECT
		p.product_id,
		p.base_price,
		CASE
			WHEN pop.popularity_rank <= 3 THEN 1.2
			WHEN pop.popularity_rank BETWEEN 4 AND 10 THEN 1.1
			ELSE 0.9
		END AS popularity_adjustment,
		rp.avg_price,
		COALESCE(1.0 - (pe.promotion_discount / 100), 1) AS promotion_discount,
		CASE
			WHEN inv.stock_rank <= 3 THEN 1.1
			WHEN inv.stock_rank BETWEEN 4 AND 10 THEN 1.05
			ELSE 1
		END AS stock_adjustment,
		CASE
			WHEN p.base_price > rp.avg_price THEN 1 + (p.base_price - rp.avg_price) / rp.avg_price
			ELSE 1 - (rp.avg_price - p.base_price) / rp.avg_price
		END AS demand_multiplier,
		hd.avg_sale_price,
		CASE
			WHEN p.product_name ilike '%cheap%' THEN 0.8
			ELSE 1.0
		END AS additional_discount
	FROM products p
	LEFT JOIN recent_prices rp ON p.product_id = rp.product_id
	LEFT JOIN promotion_effect pe ON p.product_id = pe.product_id
	JOIN popularity_score pop ON p.product_id = pop.product_id
	LEFT JOIN inventory_status inv ON p.product_id = inv.product_id
	LEFT JOIN high_demand_products hd ON p.product_id = hd.product_id
)
SELECT
	dp.product_id,
	dp.base_price * dp.popularity_adjustment * dp.promotion_discount * dp.stock_adjustment * dp.demand_multiplier * dp.additional_discount AS adjusted_price,
	p.last_update_time
FROM dynamic_pricing dp
JOIN products p ON dp.product_id = p.product_id;

-- sqlfmt-corpus-separator --

CREATE VIEW err AS
SELECT *
FROM foo
ORDER BY b, a
OFFSET mz_now()::string::bigint;

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

CREATE VIEW logical_timestamp_view(ts) AS SELECT mz_now()

-- sqlfmt-corpus-separator --

CREATE VIEW mlt AS SELECT 1 WHERE mz_logical_timestamp() = 0;

-- sqlfmt-corpus-separator --

CREATE VIEW now_view AS SELECT now() AS ts

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

CREATE VIEW v AS SELECT mz_now()

-- sqlfmt-corpus-separator --

CREATE VIEW v1 AS
SELECT t, d1, d2, EXTRACT(MILLISECOND FROM t) * 91 % 1223 AS d3, d4, d5, d6
FROM t10;

-- sqlfmt-corpus-separator --

CREATE VIEW v1 AS
WITH MUTUALLY RECURSIVE (RETURN AT RECURSION LIMIT 2)
  cnt (f1 INTEGER) AS (
    SELECT f1 FROM t1 UNION ALL SELECT f1+1 AS f1 FROM cnt
  )
SELECT * FROM cnt;

-- sqlfmt-corpus-separator --

CREATE VIEW v_maintained AS
SELECT *
FROM t2
WHERE
  ts + INTERVAL '30' minutes >= mz_now();

-- sqlfmt-corpus-separator --

CREATE VIEW v_one_off AS
SELECT *
FROM t2
WHERE
  ts + INTERVAL '30' minutes >= mz_now()
  OR ts IS NULL;

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

DELETE FROM dec WHERE d = mz_now()

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

EXPLAIN DECORRELATED PLAN WITH(arity) FOR
SELECT row_number() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

EXPLAIN DECORRELATED PLAN WITH(arity) FOR SELECT * FROM t2, LATERAL(SELECT t1.*, ROW_NUMBER() OVER() FROM t1 WHERE t1.f2 = t2.f2) AS foo;

-- sqlfmt-corpus-separator --

EXPLAIN DECORRELATED PLAN WITH(arity) FOR SELECT * FROM t2, LATERAL(SELECT t1.*, ROW_NUMBER() OVER(PARTITION BY f1) FROM t1 WHERE t1.f2 = t2.f2) AS foo;

-- sqlfmt-corpus-separator --

EXPLAIN DECORRELATED PLAN WITH(arity) FOR SELECT f1 FROM t1
WHERE f1 IN (SELECT ROW_NUMBER() OVER () FROM t2);

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN FOR select
  mz_internal.mz_session_id() as c0,
  pg_catalog.jsonb_build_array() as c1,
  ((((0::uint4) & (0::uint4)) # (cast(coalesce(2::uint4,
          case when false then null::uint4 else null::uint4 end
            ) as uint4))) * (mz_catalog.seahash(
        CAST(case when ((0::uint8) <= (null::uint8))
            and (true) then pg_catalog.digest(
            CAST(1::text as text),
            CAST(2::text as text)) else pg_catalog.digest(
            CAST(1::text as text),
            CAST(2::text as text)) end
           as bytea)))) # (mz_catalog.seahash(
      CAST(cast(coalesce(pg_catalog.sha512(
          CAST(pg_catalog.sha384(
            CAST(cast('\xDEADBEEF' as bytea) as bytea)) as bytea)),
        cast(nullif(pg_catalog.hmac(
            CAST(cast('\xDEADBEEF' as bytea) as bytea),
            CAST(cast('\xDEADBEEF' as bytea) as bytea),
            CAST(1::text as text)),
          cast('\xFFFFFF' as bytea)) as bytea)) as bytea) as bytea))) as c2,
  pg_catalog.makeaclitem(
    CAST(mz_internal.aclitem_grantee(
      CAST(cast(null as aclitem) as aclitem)) as oid),
    CAST(mz_internal.aclitem_grantor(
      CAST(case when 87 is not NULL then pg_catalog.makeaclitem(
          CAST(mz_internal.aclitem_grantor(
            CAST(cast(null as aclitem) as aclitem)) as oid),
          CAST(null::oid as oid),
          CAST(case when false then null::text else null::text end
             as text),
          CAST(true as bool)) else pg_catalog.makeaclitem(
          CAST(mz_internal.aclitem_grantor(
            CAST(cast(null as aclitem) as aclitem)) as oid),
          CAST(null::oid as oid),
          CAST(case when false then null::text else null::text end
             as text),
          CAST(true as bool)) end
         as aclitem)) as oid),
    CAST(case when ((case when (true)
              or (false) then 1::text else 1::text end
            ) || (pg_catalog.chr(
            CAST(68 as int4)))) <= (pg_catalog.session_user()) then cast(nullif((pg_catalog.obj_description(
            CAST(null::oid as oid),
            CAST(1::text as text))) || (case when (TIME '00:00:00') >= (TIME '01:23:45') then null::text else null::text end
            ),
        pg_catalog.current_schema()) as text) else cast(nullif((pg_catalog.obj_description(
            CAST(null::oid as oid),
            CAST(1::text as text))) || (case when (TIME '00:00:00') >= (TIME '01:23:45') then null::text else null::text end
            ),
        pg_catalog.current_schema()) as text) end
       as text),
    CAST(case when (cast(coalesce((null::uint4) | (2::uint4),
          cast(nullif(0::uint4,
            null::uint4) as uint4)) as uint4)) >= (null::uint4) then pg_catalog.pg_has_role(
        CAST(cast(0 as oid) as oid),
        CAST(cast(coalesce(case when ('{}'::jsonb) = ('[]'::jsonb) then 1::oid else 1::oid end
            ,
          1::oid) as oid) as oid),
        CAST(pg_catalog.current_database() as text)) else pg_catalog.pg_has_role(
        CAST(cast(0 as oid) as oid),
        CAST(cast(coalesce(case when ('{}'::jsonb) = ('[]'::jsonb) then 1::oid else 1::oid end
            ,
          1::oid) as oid) as oid),
        CAST(pg_catalog.current_database() as text)) end
       as bool)) as c3,
  pg_catalog.pg_is_in_recovery() as c4,
  mz_catalog.mz_now() as c5,
  pg_catalog.timezone(
    CAST(mz_catalog.mz_version() as text),
    CAST(pg_catalog.current_timestamp() as timestamptz)) as c6,
  pg_catalog.reverse(
    CAST((mz_catalog.mz_version()) || (1::text) as text)) as c7
from
  (select
        case when false then mz_internal.mz_role_oid_memberships() else mz_internal.mz_role_oid_memberships() end
           as c0,
        mz_internal.mz_role_oid_memberships() as c1,
        pg_catalog.current_database() as c2,
        mz_internal.mz_name_rank(
          CAST(pg_catalog.version() as text),
          CAST(array['a', 'b', null, '']::text[] as _text),
          CAST(case when (cast(0 as bpchar)) > (cast(0 as bpchar)) then 1::text else 1::text end
             as text),
          CAST(1::text as text)) as c3,
        mz_catalog.mz_uptime() as c4,
        mz_internal.mz_role_oid_memberships() as c5,
        case when false then 58 else 58 end
           as c6,
        (case when ((2::int8) <> (-9223372036854775808::int8))
              or ((-32768::int2) = (-32768::int2)) then 0::uint8 else 0::uint8 end
            ) / (0::uint8) as c7,
        mz_internal.mz_role_oid_memberships() as c8,
        (cast(coalesce('inf'::float4,
            'nan'::float4) as float4)) - (case when ((67) = (19))
              or (52 is NULL) then 'inf'::float4 else 'inf'::float4 end
            ) as c9,
        mz_catalog.mz_uptime() as c10
      from
        (select
              18 as c0,
              50 as c1
            from
              (select
                    73 as c0,
                    58 as c1,
                    24 as c2,
                    32 as c3,
                    12 as c4
                  from
                    "mz_internal"."mz_session_history" as ref_11
                  where true) as subq_8
            where false) as subq_9
      where (array[null, null]) > (pg_catalog.regexp_split_to_array(
          CAST(('{"1":2,"3":4}'::jsonb) ->> (9223372036854775807::int8) as text),
          CAST(cast(0 as text) as text),
          CAST(pg_catalog.session_user() as text)))) as subq_10
where (mz_internal.aclitem_grantee(
    CAST(cast(null as aclitem) as aclitem))) <= (mz_internal.aclitem_grantor(
    CAST(pg_catalog.makeaclitem(
      CAST(case when (cast(coalesce(cast('\xDEADBEEF' as bytea),
            cast('\xDEADBEEF' as bytea)) as bytea)) >= (cast('\xDEADBEEF' as bytea)) then case when ((cast('\xFFFFFF' as bytea)) >= (cast('\xFFFFFF' as bytea)))
            or ((61) >= (6)) then 1::oid else 1::oid end
           else case when ((cast('\xFFFFFF' as bytea)) >= (cast('\xFFFFFF' as bytea)))
            or ((61) >= (6)) then 1::oid else 1::oid end
           end
         as oid),
      CAST(cast(0 as oid) as oid),
      CAST(pg_catalog.session_user() as text),
      CAST(mz_internal.is_rbac_enabled() as bool)) as aclitem)));

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
SELECT
 f1 || f4,
 UPPER(f1), LOWER(f1),
 SUBSTRING(f1, 1),
 REPLACE(f1, f2, f3),
 POSITION(f2 IN f1),
 SPLIT_PART(f1, f2, 1),
 TRANSLATE(f1, 'C', 'Z'),
 BTRIM(f1ls), LTRIM(f1ls),
 BTRIM(f1rs), RTRIM(f1rs),
 LPAD(f1, 1),
 LPAD(f1, 10),
 LPAD(f1, 10, f2),
  REGEXP_MATCH(f1, f2),
 REGEXP_MATCH(f1, f3, 'i') AS case_insensitive
FROM t_using_dataflow_rendering;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR
SELECT
 f1 || f4,
 UPPER(f1), LOWER(f1),
 SUBSTRING(f1, 1),
 REPLACE(f1, f2, f3),
 POSITION(f2 IN f1),
 SPLIT_PART(f1, f2, 1),
 TRANSLATE(f1, 'C', 'Z'),
 BTRIM(f1ls), LTRIM(f1ls),
 BTRIM(f1rs), RTRIM(f1rs),
 LPAD(f1, 1),
 LPAD(f1, 10),
 LPAD(f1, 10, f2),
  REGEXP_MATCH(f1, f2),
 REGEXP_MATCH(f1, f3, 'i') AS case_insensitive
FROM v_using_constant_folding;

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
WITH recent_prices AS (
	SELECT grp.product_id, AVG(price) AS avg_price
	FROM (SELECT DISTINCT product_id FROM sales) grp,
	LATERAL (
		SELECT product_id, price
		FROM sales
		WHERE sales.product_id = grp.product_id
		ORDER BY sale_date DESC LIMIT 10
	) sub
	GROUP BY grp.product_id
),
promotion_effect AS (
	SELECT
		p.product_id,
		MIN(pr.promotion_discount) AS promotion_discount
	FROM promotions pr
	JOIN products p ON pr.product_id = p.product_id
	WHERE pr.active = TRUE
	GROUP BY p.product_id
),
popularity_score AS (
	SELECT
		s.product_id,
		RANK() OVER (PARTITION BY p.category_id ORDER BY COUNT(s.sale_id) DESC) AS popularity_rank,
		COUNT(s.sale_id) AS sale_count
	FROM sales s
	JOIN products p ON s.product_id = p.product_id
	GROUP BY s.product_id, p.category_id
),
inventory_status AS (
	SELECT
		i.product_id,
		SUM(i.stock) AS total_stock,
		RANK() OVER (ORDER BY SUM(i.stock) DESC) AS stock_rank
	FROM inventory i
	GROUP BY i.product_id
),
high_demand_products AS (
	SELECT
		p.product_id,
		AVG(s.sale_price) AS avg_sale_price,
		COUNT(s.sale_id) AS total_sales
	FROM products p
	JOIN sales s ON p.product_id = s.product_id
	GROUP BY p.product_id
	HAVING COUNT(s.sale_id) > (SELECT AVG(total_sales) FROM (SELECT COUNT(*) AS total_sales FROM sales GROUP BY product_id) subquery)
),
dynamic_pricing AS (
	SELECT
		p.product_id,
		p.base_price,
		CASE
			WHEN pop.popularity_rank <= 3 THEN 1.2
			WHEN pop.popularity_rank BETWEEN 4 AND 10 THEN 1.1
			ELSE 0.9
		END AS popularity_adjustment,
		rp.avg_price,
		COALESCE(1.0 - (pe.promotion_discount / 100), 1) AS promotion_discount,
		CASE
			WHEN inv.stock_rank <= 3 THEN 1.1
			WHEN inv.stock_rank BETWEEN 4 AND 10 THEN 1.05
			ELSE 1
		END AS stock_adjustment,
		CASE
			WHEN p.base_price > rp.avg_price THEN 1 + (p.base_price - rp.avg_price) / rp.avg_price
			ELSE 1 - (rp.avg_price - p.base_price) / rp.avg_price
		END AS demand_multiplier,
		hd.avg_sale_price,
		CASE
			WHEN p.product_name ilike '%cheap%' THEN 0.8
			ELSE 1.0
		END AS additional_discount
	FROM products p
	LEFT JOIN recent_prices rp ON p.product_id = rp.product_id
	LEFT JOIN promotion_effect pe ON p.product_id = pe.product_id
	JOIN popularity_score pop ON p.product_id = pop.product_id
	LEFT JOIN inventory_status inv ON p.product_id = inv.product_id
	LEFT JOIN high_demand_products hd ON p.product_id = hd.product_id
)
SELECT
	dp.product_id,
	dp.base_price * dp.popularity_adjustment * dp.promotion_discount * dp.stock_adjustment * dp.demand_multiplier * dp.additional_discount AS adjusted_price,
	p.last_update_time
FROM dynamic_pricing dp
JOIN products p ON dp.product_id = p.product_id;

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

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR BROKEN
CREATE MATERIALIZED VIEW mv AS
SELECT pg_catalog.now();

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

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT * FROM t WHERE a < mz_now();

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT * FROM t1, t2 WHERE t1.x || mz_internal.mz_session_id()  = t2.x || mz_internal.mz_session_id();

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT * FROM t1, t2 WHERE t1.x || mz_now()  = t2.x || mz_now();

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT * from numbers WHERE value > mz_now()::text::int8 / 100000000000000 LIMIT 10;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT MAX(extract(epoch from h.occurred_at) * 1000) as last_occurred, h.error, COUNT(h.occurred_at)
FROM mz_internal.mz_source_status_history h
WHERE source_id = 'u6'
AND error IS NOT NULL
AND h.occurred_at BETWEEN 0 AND 100
GROUP BY h.error
ORDER BY last_occurred DESC
LIMIT 10;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT a, array_agg(b ORDER BY b ASC), array_agg(b ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT a, array_agg(b ORDER BY b) FROM t GROUP BY a HAVING array_agg(b ORDER BY b) = array_agg(b ORDER BY b DESC);

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT a, array_agg(b), string_agg(c, ',' ORDER BY b DESC) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH (humanized expressions) AS VERBOSE TEXT FOR SELECT a, dense_rank() OVER (ORDER BY a), array_agg(b) FROM t GROUP BY a;

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
SELECT
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days,
    (SELECT max(timestamp_col)
       FROM events
      WHERE (payload->>'type' = 'foo1'
         AND category_id = origins.category_id
         AND origin_id = origins.id
         AND mz_now() BETWEEN (1000 * CAST(extract(epoch from timestamp_col) AS numeric)) AND (1000 * CAST(extract(epoch from timestamp_col + interval '90' days) AS numeric))
      )
    ) AS quz__foo1_types__max_time__90days
FROM
    origins;

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
SELECT
    EXTRACT(year FROM o_entry_d) AS l_year,
    sum(CASE WHEN n2.n_name = 'GERMANY' THEN ol_amount ELSE 0 END) / CASE WHEN sum(ol_amount) = 0 THEN 1 ELSE sum(ol_amount) END AS mkt_share
FROM item, supplier, stock, orderline, "order", customer, nation n1, nation n2, region
WHERE i_id = s_i_id
AND ol_i_id = s_i_id
AND ol_supply_w_id = s_w_id
AND s_su_suppkey = su_suppkey
AND ol_w_id = o_w_id
AND ol_d_id = o_d_id
AND ol_o_id = o_id
AND c_id = o_c_id
AND c_w_id = o_w_id
AND c_d_id = o_d_id
AND n1.n_nationkey = c_n_nationkey
AND n1.n_regionkey = r_regionkey
AND ol_i_id < 1000
AND r_name = 'EUROPE'
AND su_nationkey = n2.n_nationkey
AND o_entry_d BETWEEN TIMESTAMP '2007-01-02 00:00:00.000000' AND TIMESTAMP '2012-01-02 00:00:00.000000'
AND i_data like '%b'
AND i_id = ol_i_id
GROUP BY EXTRACT(year FROM o_entry_d)
ORDER BY l_year

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
SELECT
    n_name, EXTRACT(year FROM o_entry_d) AS l_year,
    sum(ol_amount) AS sum_profit
FROM item, stock, supplier, orderline, "order", nation
WHERE ol_i_id = s_i_id
AND ol_supply_w_id = s_w_id
AND s_su_suppkey = su_suppkey
AND ol_w_id = o_w_id
AND ol_d_id = o_d_id
AND ol_o_id = o_id
AND ol_i_id = i_id
AND su_nationkey = n_nationkey
AND i_data like '%BB'
GROUP BY n_name, EXTRACT(year FROM o_entry_d)
ORDER BY n_name, l_year DESC

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR
SELECT
    su_nationkey AS supp_nation,
    substr(c_state, 1, 1) AS cust_nation,
    EXTRACT(year FROM o_entry_d) AS l_year,
    sum(ol_amount) AS revenue
FROM supplier, stock, orderline, "order", customer, nation n1, nation n2
WHERE ol_supply_w_id = s_w_id
AND ol_i_id = s_i_id
AND s_su_suppkey = su_suppkey
AND ol_w_id = o_w_id
AND ol_d_id = o_d_id
AND ol_o_id = o_id
AND c_id = o_c_id
AND c_w_id = o_w_id
AND c_d_id = o_d_id
AND su_nationkey = n1.n_nationkey
AND c_n_nationkey = n2.n_nationkey
AND (
    (n1.n_name = 'GERMANY' AND n2.n_name = 'CAMBODIA')
    OR
    (n1.n_name = 'CAMBODIA' AND n2.n_name = 'GERMANY')
)
AND ol_delivery_d BETWEEN TIMESTAMP '2007-01-02 00:00:00.000000' AND TIMESTAMP '2012-01-02 00:00:00.000000'
GROUP BY su_nationkey, substr(c_state, 1, 1), EXTRACT(year FROM o_entry_d)
ORDER BY su_nationkey, cust_nation, l_year

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
WITH parsed AS (
  SELECT regexp_split_to_table(input, '\n') AS line FROM aoc_1204
),
numbers AS (
  SELECT split_part(line,':',1) AS card_id,
         replace(split_part(line,':',2),'|','') AS nrs
  FROM parsed
),
arr AS (
  SELECT card_id,
         nrs,
         regexp_split_to_array(ltrim(rtrim(nrs)),'\s') AS nrs_arr
  FROM numbers
),
winning AS (
  SELECT card_id,
         unnest(array_remove(nrs_arr,'')) nr,
         ROW_NUMBER() OVER (PARTITION BY card_id) AS row_num
  FROM arr
  GROUP BY card_id, nr HAVING COUNT(*)>1
  ORDER BY card_id
),
winning_points AS (
  SELECT ROUND(EXP(SUM(LN(CASE WHEN row_num = 1 THEN row_num ELSE 2 END)))) AS points
  FROM winning
  GROUP BY card_id
)
SELECT SUM(points)
FROM winning_points;

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
select
  case when (((false)
          and (true))
        and ((numrange(0,0)) -|- (case when (cast(null as mz_aclitem)) = (cast(null as mz_aclitem)) then numrange(0,0) else numrange(0,0) end
            )))
      and (((10::uint8) & (case when (TIMESTAMPTZ '2023-01-01 01:23:45+06') >= ((TIMESTAMPTZ '95143-12-31 23:59:59+06' + INTERVAL '167 MILLENNIUM')) then 2::uint8 else 2::uint8 end
            )) < (pg_catalog.mod(
          CAST(null::uint8 as uint8),
          CAST(null::uint8 as uint8)))) then mz_catalog.kafka_murmur2(
      CAST(cast('\xDEADBEEF' as bytea) as bytea)) else mz_catalog.kafka_murmur2(
      CAST(cast('\xDEADBEEF' as bytea) as bytea)) end
     as c0,
  (mz_unsafe.mz_avg_promotion(
      CAST(0::uint4 as uint4))) / (null::numeric) as c1,
  mz_catalog.try_parse_monotonic_iso8601_timestamp(
    CAST(pg_catalog.obj_description(
      CAST(mz_internal.aclitem_grantee(
        CAST(cast(null as aclitem) as aclitem)) as oid),
      CAST((('[]'::jsonb) -> (pg_catalog.session_user())) ->> (pg_catalog.pg_get_viewdef(
          CAST(case when ('{}'::map[text=>text]) ?| (array['a', 'b', null, '']::text[]) then null::oid else null::oid end
             as oid),
          CAST(true as bool))) as text)) as text)) as c2,
  '2024-12-18 12:54:29.994+00'::timestamptz as c3
from
  (select distinct
        mz_catalog.map_agg(
          CAST(cast(coalesce(null::text,
            null::text) as text) as text),
          null) as c0,
        mz_catalog.mz_environment_id() as c1,
        (mz_catalog.mz_environment_id()) || ((null::uint4) + (4294967295::uint4)) as c2,
        pg_catalog.tstzrange(
          CAST((INTERVAL '2147483647 MONTHS') + (TIMESTAMPTZ '2023-01-01 01:23:45+06') as timestamptz),
          CAST(TIMESTAMPTZ '2023-01-01 01:23:45+06' as timestamptz)) as c3,
        pg_catalog.version() as c4
      from
        (select
              36 as c0,
              33 as c1
            from
              (select
                    4 as c0
                  from
                    "mz_catalog"."mz_columns" as ref_2
                  where (false) <> (true)
                  limit coalesce(13, 72)) as subq_0
            where (true) = (true)
            limit coalesce(82, 50)) as subq_1
      where (pg_catalog.mod(
          CAST(case when ((TIMESTAMPTZ '0001-01-01 00:00:00+06' - INTERVAL '4713 YEARS')) >= ((TIMESTAMPTZ '95143-12-31 23:59:59+06' + INTERVAL '167 MILLENNIUM')) then null::int2 else null::int2 end
             as int2),
          CAST(10::int2 as int2))) > (null::int2)
      limit coalesce(90, 42)) as subq_2
where true
limit coalesce(43, 120);

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

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR SELECT 1::mz_timestamp = mz_now()

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR SELECT f1 FROM t1
WHERE f1 IN (SELECT ROW_NUMBER() OVER () FROM t2);

-- sqlfmt-corpus-separator --

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR SELECT row_number() over () from (select f1 from m3 limit 1)

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
  message_count AS (
    SELECT 0.0 + count(*) AS cnt
      FROM Message
     WHERE creationDate < '2010-06-11T09:21:46.000+00:00'::TIMESTAMP
)
, message_prep AS (
    SELECT extract(year from creationDate) AS messageYear
         , ParentMessageId IS NOT NULL AS isComment
         , CASE
             WHEN length <  40 THEN 0 -- short
             WHEN length <  80 THEN 1 -- one liner
             WHEN length < 160 THEN 2 -- tweet
             ELSE                   3 -- long
           END AS lengthCategory
         , length
      FROM Message
     WHERE creationDate < '2010-06-11T09:21:46.000+00:00'::TIMESTAMP
       AND content IS NOT NULL
)
SELECT messageYear, isComment, lengthCategory
     , count(*) AS messageCount
     , avg(length::bigint) AS averageMessageLength
     , sum(length::bigint) AS sumMessageLength
     , count(*) / mc.cnt AS percentageOfMessages
  FROM message_prep
     , message_count mc
 GROUP BY messageYear, isComment, lengthCategory, mc.cnt
 ORDER BY messageYear DESC, isComment ASC, lengthCategory ASC

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

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, arity, join implementations) AS VERBOSE TEXT FOR WITH Zombies AS (
    SELECT Person.id AS zombieid
      FROM Country
      JOIN City
        ON City.PartOfCountryId = Country.id
      JOIN Person
        ON Person.LocationCityId = City.id
      LEFT JOIN Message
         ON Person.id = Message.CreatorPersonId
        AND Message.creationDate BETWEEN Person.creationDate AND '2012-11-09'::TIMESTAMP -- the lower bound is an optmization to prune messages
     WHERE Country.name = 'India'
       AND Person.creationDate < '2012-11-09'::TIMESTAMP
     GROUP BY Person.id, Person.creationDate
        -- average of [0, 1) messages per month is equivalent with having less messages than the month span between person creationDate and parameter '2012-11-09'::TIMESTAMP
    HAVING count(Message.MessageId) < 12*extract(YEAR FROM '2012-11-09'::TIMESTAMP) + extract(MONTH FROM '2012-11-09'::TIMESTAMP)
                            - (12*extract(YEAR FROM Person.creationDate) + extract(MONTH FROM Person.creationDate))
                            + 1
)
SELECT Z.zombieid AS "zombie.id"
     , coalesce(t.zombieLikeCount, 0) AS zombieLikeCount
     , coalesce(t.totalLikeCount, 0) AS totalLikeCount
     , CASE WHEN t.totalLikeCount > 0 THEN t.zombieLikeCount::float/t.totalLikeCount ELSE 0 END AS zombieScore
  FROM Zombies Z LEFT JOIN (
    SELECT Z.zombieid, count(*) as totalLikeCount, sum(case when exists (SELECT 1 FROM Zombies ZL WHERE ZL.zombieid = p.id) then 1 else 0 end) AS zombieLikeCount
    FROM Person p, Person_likes_Message plm, Message m, Zombies Z
    WHERE Z.zombieid = m.CreatorPersonId AND p.creationDate < '2012-11-09'::TIMESTAMP
        AND p.id = plm.PersonId AND m.MessageId = plm.MessageId
    GROUP BY Z.zombieid
  ) t ON (Z.zombieid = t.zombieid)
 ORDER BY zombieScore DESC, Z.zombieid
 LIMIT 100

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

EXPLAIN OPTIMIZED PLAN WITH(humanized expressions, filter pushdown) AS VERBOSE TEXT FOR
SELECT content, inserted_at
FROM events_timestamped
WHERE EXTRACT(YEAR FROM inserted_at) = 2021;

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
CREATE MATERIALIZED VIEW mv AS
SELECT pg_catalog.now();

-- sqlfmt-corpus-separator --

EXPLAIN PHYSICAL PLAN AS VERBOSE TEXT FOR
SELECT
  row_number() OVER (ORDER BY x),
  x
FROM t7
ORDER BY row_number

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

EXPLAIN PHYSICAL PLAN AS VERBOSE TEXT FOR SELECT a, dense_rank() OVER (ORDER BY a), array_agg(b) FROM t GROUP BY a;

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
SELECT row_number() OVER (ORDER BY r DESC)
FROM (
    SELECT row_number() OVER (PARTITION BY l) as r
    FROM (
        SELECT lag(b, 3) OVER (PARTITION BY b%2, a%3 ORDER BY a DESC, -b, 2*b + a NULLS FIRST) as l
        FROM t
    )
);

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

EXPLAIN RAW PLAN FOR
SELECT row_number() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

EXPLAIN RAW PLAN WITH (TYPES, NO FAST PATH) AS TEXT FOR SELECT
  (((null::int8) / (mz_catalog.datediff(
          CAST(pg_catalog.right(
            CAST(1::text as text),
            CAST(80 as int4)) as text),
          CAST(TIMESTAMP(3) '2023-01-01 01:23:45' as timestamp),
          CAST(pg_catalog.timezone(
            CAST(INTERVAL '1' MINUTE as interval),
            CAST(TIMESTAMPTZ '2023-01-01 01:23:45+06' as timestamptz)) as timestamp)))) % (case when (cast(coalesce('{"1":2,"3":4}'::jsonb,
            '{"1":2,"3":4}'::jsonb) as jsonb)) ? (pg_catalog.reverse(
            CAST(null::text as text))) then pg_catalog.pg_relation_size(
          CAST(1::regclass as regclass),
          CAST(cast(coalesce(cast(0 as text),
            cast(0 as text)) as text) as text)) else pg_catalog.pg_relation_size(
          CAST(1::regclass as regclass),
          CAST(cast(coalesce(cast(0 as text),
            cast(0 as text)) as text) as text)) end
        )) / (pg_catalog.pg_relation_size(
      CAST(cast(0 as regclass) as regclass))) as c0,
  pg_catalog.floor(
    CAST((case when false then case when (1::text) >= (1::text) then 1::numeric else 1::numeric end
           else case when (1::text) >= (1::text) then 1::numeric else 1::numeric end
           end
        ) / (case when 17 is not NULL then case when 36 is NULL then (cast(0 as numeric)) % (cast(0 as numeric)) else (cast(0 as numeric)) % (cast(0 as numeric)) end
           else case when 36 is NULL then (cast(0 as numeric)) % (cast(0 as numeric)) else (cast(0 as numeric)) % (cast(0 as numeric)) end
           end
        ) as numeric)) as c1,
  (pg_catalog.jsonb_build_array()) #> (pg_catalog.parse_ident(
      CAST(pg_catalog.pg_get_viewdef(
        CAST(pg_catalog.current_user() as text)) as text))) as c2,
  (pg_catalog.mod(
      CAST(32767::int2 as int2),
      CAST((pg_catalog.mod(
          CAST(case when 6 is not NULL then null::int2 else null::int2 end
             as int2),
          CAST(32767::int2 as int2))) # (-32768::int2) as int2))) % ((~ 32767::int2) / (((pg_catalog.mod(
            CAST(null::int2 as int2),
            CAST(-32768::int2 as int2))) # ((-32768::int2) & (32767::int2))) / (case when ('{"1":2,"3":4}'::jsonb) < ('{"1":2,"3":4}'::jsonb) then null::int2 else null::int2 end
          ))) as c3
from
  (select distinct
        mz_internal.mz_normalize_schema_name(
          CAST(('{"1":2,"3":4}'::jsonb) ->> (null::int8) as text)) as c0,
        mz_internal.aclitem_grantee(
          CAST(pg_catalog.makeaclitem(
            CAST(cast(0 as oid) as oid),
            CAST(1::oid as oid),
            CAST(cast(0 as text) as text),
            CAST(false as bool)) as aclitem)) as c1,
        (0::uint2) * (~ 0::uint2) as c2,
        30 as c3,
        53 as c4,
        47 as c5
      from
        (select
              44 as c0,
              84 as c1
            from
              (select
                    41 as c0
                  from
                    "mz_introspection"."mz_compute_frontiers_per_worker" as ref_0
                  where (10::oid) < (cast(0 as oid))) as subq_0
            where (null::mz_timestamp) > (cast(0 as mz_timestamp))) as subq_1
      where (case when (cast(0 as mz_timestamp)) = (1::mz_timestamp) then cast(0 as bpchar) else cast(0 as bpchar) end
          ) ~ (cast(coalesce(pg_catalog.user(),
          ('"foo"'::jsonb) ->> (null::int8)) as text))) as subq_2
where (cast(coalesce(null::name,
    cast(nullif(cast(0 as name),
      null::name) as name)) as name)) <> (1::name);

-- sqlfmt-corpus-separator --

EXPLAIN WITH (humanized expressions)
SELECT * FROM t WHERE a < mz_now();

-- sqlfmt-corpus-separator --

EXPLAIN WITH (humanized expressions)
SELECT * FROM t1, t2 WHERE t1.x || mz_internal.mz_session_id()  = t2.x || mz_internal.mz_session_id();

-- sqlfmt-corpus-separator --

EXPLAIN WITH (humanized expressions)
SELECT * FROM t1, t2 WHERE t1.x || mz_now()  = t2.x || mz_now();

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

INSERT INTO baz VALUES (now()::text)

-- sqlfmt-corpus-separator --

INSERT INTO dec VALUES (0) RETURNING mz_now()

-- sqlfmt-corpus-separator --

INSERT INTO dec VALUES (mz_now())

-- sqlfmt-corpus-separator --

INSERT INTO dt VALUES (now())

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES ('a', transaction_timestamp())

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES ('b', transaction_timestamp());
SELECT * FROM kv;
COMMIT

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (1, cluster_logical_timestamp()-(select mints from m));
SELECT * FROM kv

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (2, cluster_logical_timestamp());
SELECT * FROM kv;
COMMIT

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (2, cluster_logical_timestamp()-(select mints from m));
SELECT * FROM kv

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (3, cluster_logical_timestamp()-(select mints from m));
SELECT * FROM kv

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (4, cluster_logical_timestamp()-(select mints from m));
SELECT * FROM kv

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (5, cluster_logical_timestamp()-(select mints from m));
SELECT * FROM kv

-- sqlfmt-corpus-separator --

INSERT INTO kv (k,v) VALUES (6, cluster_logical_timestamp()-(select mints from m));
SELECT * FROM kv

-- sqlfmt-corpus-separator --

INSERT INTO m VALUES (cluster_logical_timestamp())

-- sqlfmt-corpus-separator --

INSERT INTO now_inc VALUES (now())

-- sqlfmt-corpus-separator --

INSERT INTO start_time VALUES (now());

-- sqlfmt-corpus-separator --

INSERT INTO t VALUES (1, 1) RETURNING mz_version();

-- sqlfmt-corpus-separator --

INSERT INTO t VALUES (7, 8) RETURNING mz_now()

-- sqlfmt-corpus-separator --

INSERT INTO t VALUES (7, 8) RETURNING now()

-- sqlfmt-corpus-separator --

INSERT INTO t VALUES (7, 8) RETURNING row_number()

-- sqlfmt-corpus-separator --

INSERT INTO tableA VALUES (now(), null, 10, 10);

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
    class_objects.oid as attrelid,
    mz_columns.name as attname,
    mz_columns.type_oid AS atttypid,
    class_objects.type as relation_type,
    mz_columns.type as typename,
    position as attnum,
    mzsc.name as schema_name,
    class_objects.name as relation_name
FROM (
    SELECT id, oid, schema_id, name, type FROM mz_catalog.mz_relations
    UNION ALL
        SELECT mz_indexes.id, mz_indexes.oid, mz_relations.schema_id, mz_indexes.name, 'index' AS type
        FROM mz_catalog.mz_indexes
        JOIN mz_catalog.mz_relations ON mz_indexes.on_id = mz_relations.id
) AS class_objects
JOIN mz_catalog.mz_columns ON class_objects.id = mz_columns.id
JOIN pg_catalog.pg_type ON pg_type.oid = mz_columns.type_oid
JOIN mz_catalog.mz_databases d ON (d.id IS NULL OR d.name = pg_catalog.current_database())
JOIN mz_catalog.mz_schemas mzsc ON class_objects.schema_id = mzsc.id
WHERE mzsc.name IN ('pg_catalog', 'information_schema')
  AND mz_columns.type like '%uint%'

-- sqlfmt-corpus-separator --

SELECT
  '1702129950259'::mz_timestamp::text,
  '1990-01-04 11:00'::mz_timestamp::text,
  greatest('1990-01-04 11:00', mz_now()) > '1990-01-04 11:00'::mz_timestamp,
     least('1990-01-04 11:00', mz_now()) > '1990-01-04 11:00'::mz_timestamp,
  greatest(mz_now(), '1990-01-04 11:00') > '3000-01-04 11:00'::mz_timestamp,
  '1990-01-04 11:00+08'::mz_timestamp < '1990-01-04 11:00+06'::mz_timestamp;

-- sqlfmt-corpus-separator --

SELECT
  name,
  type,
  interval,
  now() - aligned_to < INTERVAL '30 minutes',
  now() - at < INTERVAL '30 minutes'
FROM mz_internal.mz_materialized_view_refresh_strategies mvrs, mz_catalog.mz_materialized_views mv
WHERE mv.id LIKE 'u%' AND mv.id = mvrs.materialized_view_id
ORDER BY name;

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
  x-row_number() OVER (ORDER BY x+y),
  x,
  y,
  sum(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  max(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  min(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING),
  array_agg(x+x) OVER (PARTITION BY x-row_number() OVER (ORDER BY x+y) ORDER BY x ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
FROM t7
ORDER BY x-row_number() OVER (ORDER BY x+y), x;

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

SELECT
 f1 || f4,
 UPPER(f1), LOWER(f1),
 SUBSTRING(f1, 1),
 REPLACE(f1, f2, f3),
 POSITION(f2 IN f1),
 SPLIT_PART(f1, f2, 1),
 TRANSLATE(f1, 'C', 'Z'),
 BTRIM(f1ls), LTRIM(f1ls),
 BTRIM(f1rs), RTRIM(f1rs),
 LPAD(f1, 1),
 LPAD(f1, 10),
 LPAD(f1, 10, f2),
 REGEXP_MATCH(f1, f2),
 REGEXP_MATCH(f1, f3, 'i') AS case_insensitive
FROM t_using_dataflow_rendering;

-- sqlfmt-corpus-separator --

SELECT
 f1 || f4,
 UPPER(f1), LOWER(f1),
 SUBSTRING(f1, 1),
 REPLACE(f1, f2, f3),
 POSITION(f2 IN f1),
 SPLIT_PART(f1, f2, 1),
 TRANSLATE(f1, 'C', 'Z'),
 BTRIM(f1ls), LTRIM(f1ls),
 BTRIM(f1rs), RTRIM(f1rs),
 LPAD(f1, 1),
 LPAD(f1, 10),
 LPAD(f1, 10, f2),
 REGEXP_MATCH(f1, f2),
 REGEXP_MATCH(f1, f3, 'i') AS case_insensitive
FROM v_using_constant_folding;

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

SELECT (now(), 2) = (now() :: timestamp, 2) AS r
  FROM tb

-- sqlfmt-corpus-separator --

SELECT (pg_get_keywords()).word FROM t

-- sqlfmt-corpus-separator --

SELECT *
FROM events
WHERE insert_ts + 30 >= mz_now();

-- sqlfmt-corpus-separator --

SELECT *
FROM events
WHERE insert_ts >= mz_now() - 30;

-- sqlfmt-corpus-separator --

SELECT *
FROM t
ORDER BY row_number();

-- sqlfmt-corpus-separator --

SELECT *
FROM t
QUALIFY row_number();

-- sqlfmt-corpus-separator --

SELECT *
FROM t2
WHERE
  ts + INTERVAL '30' minutes >= mz_now()
  OR ts IS NULL;

-- sqlfmt-corpus-separator --

SELECT *
FROM t2
WHERE ts + INTERVAL '30' minutes >= mz_now()
UNION ALL
SELECT *
FROM t2
WHERE ts + INTERVAL '60' minutes >= mz_now();

-- sqlfmt-corpus-separator --

SELECT *
FROM t2
WHERE ts + INTERVAL '30' minutes >= mz_now();

-- sqlfmt-corpus-separator --

SELECT *
FROM t2
WHERE ts >= mz_now() - INTERVAL '30' minutes;

-- sqlfmt-corpus-separator --

SELECT *
FROM t6
QUALIFY row_number() OVER (PARTITION BY x%3 ORDER BY y) = 1;

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

SELECT * FROM ROWS FROM (current_user(), current_user())

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (current_user(), generate_series(1,2))

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM (generate_series(1,2), current_user())

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF current_database()

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF current_database()::mz_timestamp

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF mz_now();

-- sqlfmt-corpus-separator --

SELECT * FROM data AS OF now()

-- sqlfmt-corpus-separator --

SELECT * FROM information_schema._pg_expandarray()

-- sqlfmt-corpus-separator --

SELECT * FROM noexist()

-- sqlfmt-corpus-separator --

SELECT * FROM t
WHERE row_number() over () > 1;

-- sqlfmt-corpus-separator --

SELECT * FROM t AS v JOIN t ON row_number() over () > 1;

-- sqlfmt-corpus-separator --

SELECT * FROM t1, LATERAL(SELECT t2.*, ROW_NUMBER() OVER() FROM t2 WHERE t1.f1 = t2.f1 AND t1.f2 = t2.f2) AS foo;

-- sqlfmt-corpus-separator --

SELECT * FROM t1, LATERAL(SELECT t2.*, ROW_NUMBER() OVER() FROM t2 WHERE t1.f1 = t2.f1) AS foo;

-- sqlfmt-corpus-separator --

SELECT * FROM t1, LATERAL(SELECT t2.*, ROW_NUMBER() OVER() FROM t2 WHERE t1.f2 = t2.f2) AS foo;

-- sqlfmt-corpus-separator --

SELECT * FROM t2, LATERAL(SELECT t1.*, ROW_NUMBER() OVER() FROM t1 WHERE t1.f1 = t2.f1 AND t1.f2 = t2.f2) AS foo;

-- sqlfmt-corpus-separator --

SELECT * FROM t2, LATERAL(SELECT t1.*, ROW_NUMBER() OVER() FROM t1 WHERE t1.f1 = t2.f1) AS foo;

-- sqlfmt-corpus-separator --

SELECT * FROM t2, LATERAL(SELECT t1.*, ROW_NUMBER() OVER() FROM t1 WHERE t1.f2 = t2.f2) AS foo;

-- sqlfmt-corpus-separator --

SELECT * FROM xyzw LIMIT (random() * 0.0)::int OFFSET (random() * 0.0)::int

-- sqlfmt-corpus-separator --

SELECT *,
    (
        SELECT sum(2 * w) + max(w)
        FROM (
            SELECT lead(a) OVER (ORDER BY a) + row_number() OVER (ORDER BY a) AS w
            FROM foo
            WHERE a <= outer_a AND a < 3
        ) as fsq2
    )
FROM (
    SELECT a AS outer_a, b AS outer_b
    FROM foo
) as fsq
ORDER BY outer_a;

-- sqlfmt-corpus-separator --

SELECT *, row_number() OVER (PARTITION BY len ORDER BY sum DESC, lag NULLS FIRST) as row_num FROM (
    (SELECT length(b) AS len, sum(a) AS sum, lag(sum(a)) OVER (ORDER BY sum(a)) AS lag
     FROM foo
     GROUP BY length(b))
    UNION
    (SELECT length(b), -1 + sum(a) + row_number() OVER (ORDER BY length(b)), lag(sum(a)) OVER (ORDER BY length(b))
     FROM foo
     GROUP BY length(b))
) AS sq
ORDER BY len, row_num;

-- sqlfmt-corpus-separator --

SELECT *, x%3, row_number() OVER (PARTITION BY x%3 ORDER BY y)
FROM t6
QUALIFY row_number() OVER (PARTITION BY x%3 ORDER BY y) = 1;

-- sqlfmt-corpus-separator --

SELECT 0::mz_timestamp <= mz_now()

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON (row_number() OVER ()) *
FROM t
ORDER BY row_number() OVER ()

-- sqlfmt-corpus-separator --

SELECT DISTINCT ON(row_number() OVER(ORDER BY (pk1, pk2))) y FROM xyz ORDER BY row_number() OVER(ORDER BY (pk1, pk2)) DESC

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY FROM DATE '2001-01-01'),
    EXTRACT(CENTURY FROM DATE '2000-01-01'),
    EXTRACT(CENTURY FROM DATE '1999-01-01'),
    EXTRACT(CENTURY FROM DATE '1001-01-01'),
    EXTRACT(CENTURY FROM DATE '1000-01-01'),
    EXTRACT(CENTURY FROM DATE '0001-01-01'),
    EXTRACT(CENTURY FROM DATE '0001-01-01' - INTERVAL '1'SECOND),
    EXTRACT(CENTURY FROM DATE '0001-01-01' - INTERVAL '100 YEAR 1 SECOND')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(CENTURY from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DAY from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE FROM DATE '2001-01-01'),
    EXTRACT(DECADE FROM DATE '2000-01-01'),
    EXTRACT(DECADE FROM DATE '1999-01-01'),
    EXTRACT(DECADE FROM DATE '0001-01-01'),
    EXTRACT(DECADE FROM DATE '0001-01-01' - INTERVAL '1'SECOND),
    EXTRACT(DECADE FROM DATE '0001-01-01' - INTERVAL '1 YEAR 1 SECOND'),
    EXTRACT(DECADE FROM DATE '0001-01-01' - INTERVAL '10 YEAR 1 SECOND'),
    EXTRACT(DECADE FROM DATE '0001-01-01' - INTERVAL '11 YEAR 1 SECOND')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE from INTERVAL '39'YEAR),
    EXTRACT(CENTURY from INTERVAL '399'YEAR),
    EXTRACT(MILLENNIUM from INTERVAL '3999'YEAR)

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DECADE from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOW FROM TIMESTAMP '1999-12-26 00:00:00'), EXTRACT(DOW FROM TIMESTAMP '2000-01-01 00:00:00')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOW from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOY FROM DATE '2000-01-01'), EXTRACT(DOY FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(DOY from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(MILLENNIUM FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(CENTURY FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(DECADE FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(YEAR FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(QUARTER FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(WEEK FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(MONTH FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(HOUR FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(DAY FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(DOW FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(DOY FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(ISODOW FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(MINUTE FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(SECOND FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(MS FROM TIMESTAMP '2019-11-26 15:56:46.241150'),
    EXTRACT(US FROM TIMESTAMP '2019-11-26 15:56:46.241150')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH from INTERVAL '-1' MINUTE), EXTRACT(MINUTE from INTERVAL '-1' MINUTE)

-- sqlfmt-corpus-separator --

SELECT EXTRACT(EPOCH from INTERVAL '1' YEAR), EXTRACT(EPOCH from INTERVAL '1' MONTH) * 12

-- sqlfmt-corpus-separator --

SELECT EXTRACT(HOUR FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(HOUR from TIME '11:12:42.666'),
    EXTRACT(MINUTE from TIME '11:12:42.666'),
    EXTRACT(SECOND from TIME '11:12:42.666'),
    EXTRACT(MILLISECONDS from TIME '11:12:42.666'),
    EXTRACT(MICROSECONDS from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISODOW FROM TIMESTAMP '1999-12-26 00:00:00'), EXTRACT(ISODOW FROM TIMESTAMP '2000-01-01 00:00:00')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISODOW from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(ISODOY from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MICROSECOND FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM FROM DATE '2001-01-01'),
    EXTRACT(MILLENNIUM FROM DATE '2000-01-01'),
    EXTRACT(MILLENNIUM FROM DATE '1999-01-01'),
    EXTRACT(MILLENNIUM FROM DATE '1001-01-01'),
    EXTRACT(MILLENNIUM FROM DATE '1000-01-01'),
    EXTRACT(MILLENNIUM FROM DATE '0001-01-01'),
    EXTRACT(MILLENNIUM FROM DATE '0001-01-01' - INTERVAL '1'SECOND),
    EXTRACT(MILLENNIUM FROM DATE '0001-01-01' - INTERVAL '1000 YEAR 1 SECOND')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLENNIUM from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLISECOND FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MILLISECOND from INTERVAL '72.345678'SECOND), EXTRACT(MICROSECOND from INTERVAL '72.345678'SECOND)

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MONTH from INTERVAL '-13'MONTH), EXTRACT(MONTH from INTERVAL '15'MONTH)

-- sqlfmt-corpus-separator --

SELECT EXTRACT(MONTH from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(QUARTER FROM DATE '2000-01-01'),
    EXTRACT(QUARTER FROM DATE '2000-02-03'),
    EXTRACT(QUARTER FROM DATE '2000-03-05'),
    EXTRACT(QUARTER FROM DATE '2000-04-07'),
    EXTRACT(QUARTER FROM DATE '2000-05-09'),
    EXTRACT(QUARTER FROM DATE '2000-06-11'),
    EXTRACT(QUARTER FROM DATE '2000-07-13'),
    EXTRACT(QUARTER FROM DATE '2000-08-15'),
    EXTRACT(QUARTER FROM DATE '2000-09-17'),
    EXTRACT(QUARTER FROM DATE '2000-10-19'),
    EXTRACT(QUARTER FROM DATE '2000-11-21'),
    EXTRACT(QUARTER FROM DATE '2000-12-24')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(QUARTER from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(SECOND FROM DATE '2000-12-31')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(WEEK FROM DATE '2000-01-01'), EXTRACT(WEEK FROM DATE '2000-01-08')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(WEEK from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(YEAR from TIME '11:12:42.666')

-- sqlfmt-corpus-separator --

SELECT EXTRACT(epoch FROM INTERVAL '-2147483648 months -2147483648 days -2147483648 hours -59 minutes -59.999999 seconds');

-- sqlfmt-corpus-separator --

SELECT EXTRACT(epoch FROM INTERVAL '2147483647 months 2147483647 days 2147483647 hours 59 minutes 59.999999 seconds');

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

SELECT a, b, row_number() OVER (PARTITION BY lag(length(b)) OVER (ORDER BY a) ORDER BY a), lag(length(b)) OVER (ORDER BY a)
FROM foo
ORDER BY a;

-- sqlfmt-corpus-separator --

SELECT a, dense_rank() OVER (ORDER BY a), array_agg(b) FROM t GROUP BY a;

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() OVER() FROM (SELECT * FROM (SELECT 'a' as x UNION ALL SELECT 'b' as x) ORDER BY x limit 1) a

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() OVER() FROM (SELECT * FROM (SELECT 'a' as x UNION ALL SELECT 'b' as x) ORDER BY x) a

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() OVER() from (SELECT TRUE::text as x FROM(SELECT AVG(0) FROM qs)) a

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() over () FROM (SELECT * FROM a ORDER BY x limit 1) a

-- sqlfmt-corpus-separator --

SELECT a.*, ROW_NUMBER() over () FROM (SELECT * FROM a ORDER BY x) a

-- sqlfmt-corpus-separator --

SELECT abs(sin(pi())) < 1e-12

-- sqlfmt-corpus-separator --

SELECT age('1957-06-13') - age(now(), '1957-06-13') = interval '0s'

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

SELECT clock_timestamp() - statement_timestamp() < interval '10s'

-- sqlfmt-corpus-separator --

SELECT cluster, replica, size FROM (SHOW CLUSTER REPLICAS WHERE cluster != 'quickstart') ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT cluster, replica, size FROM (SHOW CLUSTER REPLICAS) ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT cluster, replica, size FROM (SHOW CLUSTER REPLICAS) WHERE cluster != 'quickstart' ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT concat() || 'empty'

-- sqlfmt-corpus-separator --

SELECT concat_ws()

-- sqlfmt-corpus-separator --

SELECT concat_ws();

-- sqlfmt-corpus-separator --

SELECT count()

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

SELECT current_catalog = current_catalog()

-- sqlfmt-corpus-separator --

SELECT current_catalog() = current_database()

-- sqlfmt-corpus-separator --

SELECT current_database()

-- sqlfmt-corpus-separator --

SELECT current_database() AS OF 1;

-- sqlfmt-corpus-separator --

SELECT current_database() AS OF AT LEAST 1;

-- sqlfmt-corpus-separator --

SELECT current_date - current_date() = 0

-- sqlfmt-corpus-separator --

SELECT current_role = current_role()

-- sqlfmt-corpus-separator --

SELECT current_role() = current_user()

-- sqlfmt-corpus-separator --

SELECT current_schema = current_schema()

-- sqlfmt-corpus-separator --

SELECT current_schema()

-- sqlfmt-corpus-separator --

SELECT current_schemas()

-- sqlfmt-corpus-separator --

SELECT current_timestamp() > TIMESTAMP '2016-06-13 00:00:00'

-- sqlfmt-corpus-separator --

SELECT current_user = current_user()

-- sqlfmt-corpus-separator --

SELECT current_user()

-- sqlfmt-corpus-separator --

SELECT defaults()

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY dense_rank, x;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY dense_rank, x;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC, z), x, y, z
FROM t
ORDER BY y, x DESC, z;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY dense_rank, x;

-- sqlfmt-corpus-separator --

SELECT dense_rank() OVER (PARTITION BY y ORDER BY z DESC), x, y, z
FROM t
ORDER BY y, z DESC, x;

-- sqlfmt-corpus-separator --

SELECT extract(day FROM DATE '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(day FROM TIMESTAMP '2010-09-28 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(day from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract(dayofweek FROM DATE '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(dayofweek FROM TIMESTAMP '2010-09-28 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(dayofyear FROM DATE '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(dayofyear FROM TIMESTAMP '2010-09-28 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(epoch FROM INTERVAL '10:20.30' MINUTE TO SECOND)

-- sqlfmt-corpus-separator --

SELECT extract(epoch FROM TIMESTAMP '2010-01-10 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(epoch from time '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract(hour FROM '123m')

-- sqlfmt-corpus-separator --

SELECT extract(hour FROM INTERVAL '123' MINUTE)

-- sqlfmt-corpus-separator --

SELECT extract(hour FROM TIME '12:00:00')

-- sqlfmt-corpus-separator --

SELECT extract(hour FROM TIMESTAMP '2010-01-10 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(hour from '2016-02-10 19:46:33.306157519-04'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(hour from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(hours from '2016-02-10 19:46:33.306157519-04'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(microsecond FROM TIME '12:00:00.123456')

-- sqlfmt-corpus-separator --

SELECT extract(microsecond FROM TIMESTAMP '2010-01-10 12:13:14.123456')

-- sqlfmt-corpus-separator --

SELECT extract(microsecond from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(millisecond FROM INTERVAL '20.3040' SECOND)

-- sqlfmt-corpus-separator --

SELECT extract(millisecond FROM TIME '12:00:00.123456')

-- sqlfmt-corpus-separator --

SELECT extract(millisecond FROM TIMESTAMP '2010-01-10 12:13:14.123456')

-- sqlfmt-corpus-separator --

SELECT extract(millisecond from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(minute FROM INTERVAL '23:10' MINUTE TO SECOND)

-- sqlfmt-corpus-separator --

SELECT extract(minute FROM TIME '12:30:00')

-- sqlfmt-corpus-separator --

SELECT extract(minute FROM TIMESTAMP '2010-01-10 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(minute from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(month FROM DATE '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(month FROM TIMESTAMP '2010-09-28 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(nansecond from '2001-04-10 12:04:59.34565423'::timestamp)

-- sqlfmt-corpus-separator --

SELECT extract(nansecond from '2001-04-10 12:04:59.34565423'::timestamptz)

-- sqlfmt-corpus-separator --

SELECT extract(quarter FROM DATE '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(quarter FROM TIMESTAMP '2010-09-28 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(second FROM INTERVAL '10:20.30' MINUTE TO SECOND)

-- sqlfmt-corpus-separator --

SELECT extract(second FROM TIME '12:00:30')

-- sqlfmt-corpus-separator --

SELECT extract(second FROM TIMESTAMP '2010-01-10 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(second from time '12:01:02.345678')

-- sqlfmt-corpus-separator --

SELECT extract(week FROM DATE '2010-01-14')

-- sqlfmt-corpus-separator --

SELECT extract(week FROM TIMESTAMP '2010-01-14 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(year FROM '2010-09-28 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT extract(year FROM '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(year FROM DATE '2010-09-28')

-- sqlfmt-corpus-separator --

SELECT extract(year FROM TIMESTAMP '2010-09-28 12:13:14.1')

-- sqlfmt-corpus-separator --

SELECT f1 FROM t1
WHERE f1 IN (SELECT ROW_NUMBER() OVER () FROM t2);

-- sqlfmt-corpus-separator --

SELECT foo.bar()

-- sqlfmt-corpus-separator --

SELECT id, normalize(text) FROM test_normalize ORDER BY id

-- sqlfmt-corpus-separator --

SELECT id, normalize(text, NFKC) FROM test_normalize ORDER BY id

-- sqlfmt-corpus-separator --

SELECT information_schema._pg_expandarray()

-- sqlfmt-corpus-separator --

SELECT json_build_array()

-- sqlfmt-corpus-separator --

SELECT json_build_object()

-- sqlfmt-corpus-separator --

SELECT jsonb_build_array()

-- sqlfmt-corpus-separator --

SELECT jsonb_build_object()

-- sqlfmt-corpus-separator --

SELECT k FROM kv where v = transaction_timestamp()

-- sqlfmt-corpus-separator --

SELECT length(gen_random_uuid()::BYTES), gen_random_uuid() = gen_random_uuid()

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

SELECT mz_internal.is_rbac_enabled()

-- sqlfmt-corpus-separator --

SELECT mz_internal.is_rbac_enabled();

-- sqlfmt-corpus-separator --

SELECT mz_internal.mz_minimal_name_qualification(COALESCE(pg_catalog.string_to_array(pg_catalog."current_role"(), pg_catalog."user"()), COALESCE(mz_internal.mz_normalize_object_name(NULL), pg_catalog.regexp_match(CAST(0 AS text), CAST(0 AS text)))), mz_catalog.mz_version()) AS c1;

-- sqlfmt-corpus-separator --

SELECT mz_now() = mz_now()

-- sqlfmt-corpus-separator --

SELECT mz_now() AS OF 1;

-- sqlfmt-corpus-separator --

SELECT mz_now() LIMIT 0

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

SELECT noexist()

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

SELECT now()

-- sqlfmt-corpus-separator --

SELECT now() + '1m'::interval > now(), now() + '1m'::interval >= now()

-- sqlfmt-corpus-separator --

SELECT now() + INTERVAL '100' HOUR > now()

-- sqlfmt-corpus-separator --

SELECT now() + null;

-- sqlfmt-corpus-separator --

SELECT now() - (SELECT * from start_time) >= INTERVAL '3 sec';

-- sqlfmt-corpus-separator --

SELECT now() - (SELECT * from start_time) >= INTERVAL '5 sec';

-- sqlfmt-corpus-separator --

SELECT now() - current_date()::timestamptz < interval '24h10s'

-- sqlfmt-corpus-separator --

SELECT now() - current_timestamp = interval '0s'

-- sqlfmt-corpus-separator --

SELECT now() - current_timestamp() = interval '0s'

-- sqlfmt-corpus-separator --

SELECT now() - statement_timestamp() < interval '10s'

-- sqlfmt-corpus-separator --

SELECT now() - timestamp '2015-06-13' > interval '100h'

-- sqlfmt-corpus-separator --

SELECT now() - transaction_timestamp() = interval '0s'

-- sqlfmt-corpus-separator --

SELECT now() < now() + '1m'::interval, now() <= now() + '1m'::interval

-- sqlfmt-corpus-separator --

SELECT now() = now()::timestamp, now()::timestamp = now()

-- sqlfmt-corpus-separator --

SELECT now() > timestamp '2015-06-13 00:00:00'

-- sqlfmt-corpus-separator --

SELECT now() AS OF 1;

-- sqlfmt-corpus-separator --

SELECT now()::timestamp - now(), now() - now()::timestamp

-- sqlfmt-corpus-separator --

SELECT now()::timestamp < now(), now() < now()::timestamp

-- sqlfmt-corpus-separator --

SELECT now()::timestamp <= now(), now() <= now()::timestamp

-- sqlfmt-corpus-separator --

SELECT now(DISTINCT)

-- sqlfmt-corpus-separator --

SELECT pg_backend_pid() > 0

-- sqlfmt-corpus-separator --

SELECT pg_catalog.inet_client_addr(), pg_catalog.inet_client_port(), pg_catalog.inet_server_addr(), pg_catalog.inet_server_port()
FROM pg_class
WHERE relname = 'pg_constraint'

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_client_encoding()

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_get_viewdef(NULL) AS c2
FROM (SELECT DISTINCT mz_internal.mz_normalize_schema_name(NULL) AS c0,
                      mz_internal.aclitem_grantee(pg_catalog.makeaclitem(0,
                                                                         1,
                                                                         CAST(0 AS text),
                                                                         FALSE)) AS c1,
                      CAST(0 AS uint2) AS c2,
                      30 AS c3,
                      53 AS c4,
                      47 AS c5
      WHERE CAST(0 AS bpchar) ~ pg_catalog."user"()) AS subq_2;

-- sqlfmt-corpus-separator --

SELECT pg_is_in_recovery()

-- sqlfmt-corpus-separator --

SELECT pg_is_xlog_replay_paused()

-- sqlfmt-corpus-separator --

SELECT pg_typeof(mz_now()), pg_typeof(1::mz_timestamp)

-- sqlfmt-corpus-separator --

SELECT pi()

-- sqlfmt-corpus-separator --

SELECT position('a' in 'high')

-- sqlfmt-corpus-separator --

SELECT position('ig' in 'high')

-- sqlfmt-corpus-separator --

SELECT position('str' IN 42)

-- sqlfmt-corpus-separator --

SELECT position('str' IN NULL)

-- sqlfmt-corpus-separator --

SELECT position('ः॑' IN 'रः॑')

-- sqlfmt-corpus-separator --

SELECT position(42 IN 'str')

-- sqlfmt-corpus-separator --

SELECT position(NULL IN 'str')

-- sqlfmt-corpus-separator --

SELECT position(e'\u0903\u0951' IN e'\u0930\u0903\u0951')

-- sqlfmt-corpus-separator --

SELECT position(vccol1 IN vccol2) FROM positiontest

-- sqlfmt-corpus-separator --

SELECT pow(CAST (pi() AS DECIMAL), DECIMAL '2.0')

-- sqlfmt-corpus-separator --

SELECT pretty_sql(create_sql) FROM (SHOW REDACTED CREATE CONNECTION kafka_conn);

-- sqlfmt-corpus-separator --

SELECT pretty_sql(create_sql) FROM (SHOW REDACTED CREATE MATERIALIZED VIEW mv1);

-- sqlfmt-corpus-separator --

SELECT pretty_sql(create_sql) FROM (SHOW REDACTED CREATE TABLE redactable_t)

-- sqlfmt-corpus-separator --

SELECT pretty_sql(create_sql) FROM (SHOW REDACTED CREATE VIEW v);

-- sqlfmt-corpus-separator --

SELECT random() * 0.0

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY x DESC), dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

SELECT rank() OVER (ORDER BY x), dense_rank() OVER (ORDER BY x), x FROM t

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY NULL ORDER BY 10000), dense_rank() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY NULL), dense_rank() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY x ORDER BY x), dense_rank() OVER (PARTITION BY x ORDER BY x), x FROM t;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY y ORDER BY x DESC), dense_rank() OVER (PARTITION BY y ORDER BY x DESC), x FROM t;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY y ORDER BY x DESC, z), dense_rank() OVER (PARTITION BY y ORDER BY x DESC, z), x, y, z
FROM t;

-- sqlfmt-corpus-separator --

SELECT rank() OVER (PARTITION BY y ORDER BY x), dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t;

-- sqlfmt-corpus-separator --

SELECT rank(x) OVER (ORDER BY x), dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank;

-- sqlfmt-corpus-separator --

SELECT regexp_replace(create_sql, 'AT \d+', 'XXX', 'g') FROM (SHOW CREATE MATERIALIZED VIEW mvi3);

-- sqlfmt-corpus-separator --

SELECT regexp_replace(create_sql, 'u[0-9]+', 'uX', 'g') FROM (SHOW REDACTED CREATE SOURCE s);

-- sqlfmt-corpus-separator --

SELECT regexp_replace(pretty_sql(create_sql), 'u[0-9]+', 'uX', 'g') FROM (SHOW REDACTED CREATE SOURCE s);

-- sqlfmt-corpus-separator --

SELECT row_number()
FROM t;

-- sqlfmt-corpus-separator --

SELECT row_number() OVER ()

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (), row_number() OVER ()

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (), row_number() OVER () from t

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN CURRENT ROW AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN CURRENT ROW AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (GROUPS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x DESC), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x NULLS FIRST), x FROM t;

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x NULLS LAST), x FROM t;

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ORDER BY x), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 FOLLOWING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN CURRENT ROW AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN CURRENT ROW AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (RANGE UNBOUNDED PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 1 FOLLOWING AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 1 FOLLOWING AND CURRENT ROW)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 1 PRECEDING AND 2 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN 2 FOLLOWING AND 1 FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN CURRENT ROW AND 1 PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED PRECEDING)

-- sqlfmt-corpus-separator --

SELECT row_number() OVER (ROWS UNBOUNDED FOLLOWING)

-- sqlfmt-corpus-separator --

SELECT session_user = session_user()

-- sqlfmt-corpus-separator --

SELECT split_part()

-- sqlfmt-corpus-separator --

SELECT strpos('hello world', 'world') = position('world' IN 'hello world')

-- sqlfmt-corpus-separator --

SELECT strpos(version(), 'CockroachDB')

-- sqlfmt-corpus-separator --

SELECT subq_2.c2 AS c5,
       mz_catalog.mz_now() AS c7
FROM (SELECT CAST('62143-12-31' AS date) + '200000 YEARS' AS c2
      FROM (SELECT
            FROM (SELECT FROM t) AS subq_0) AS subq_1
      WHERE pg_catalog."current_timestamp"() = pg_catalog.pg_postmaster_start_time()) AS subq_2;

-- sqlfmt-corpus-separator --

SELECT sum(a ORDER BY b) FROM t2

-- sqlfmt-corpus-separator --

SELECT textrecv()

-- sqlfmt-corpus-separator --

SELECT timezone_offset('-05', now())

-- sqlfmt-corpus-separator --

SELECT timezone_offset('America/New_Yorks', now())

-- sqlfmt-corpus-separator --

SELECT timezone_offset('PST', now())

-- sqlfmt-corpus-separator --

SELECT to_ip()

-- sqlfmt-corpus-separator --

SELECT unique_rowid() < unique_rowid()

-- sqlfmt-corpus-separator --

SELECT user() = current_user()

-- sqlfmt-corpus-separator --

SELECT uuid_v4() != uuid_v4(), length(uuid_v4())

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

UPDATE dec SET d = mz_now()

-- sqlfmt-corpus-separator --

UPDATE dt SET t = mz_now()

-- sqlfmt-corpus-separator --

UPDATE dt SET t = now()

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

WITH parsed AS (
  SELECT regexp_split_to_table(input, '\n') AS line FROM aoc_1204
),
numbers AS (
  SELECT split_part(line,':',1) AS card_id,
         replace(split_part(line,':',2),'|','') AS nrs
  FROM parsed
),
arr AS (
  SELECT card_id,
         nrs,
         regexp_split_to_array(ltrim(rtrim(nrs)),'\s') AS nrs_arr
  FROM numbers
),
winning AS (
  SELECT card_id,
         unnest(array_remove(nrs_arr,'')) nr,
         ROW_NUMBER() OVER (PARTITION BY card_id) AS row_num
  FROM arr
  GROUP BY card_id, nr HAVING COUNT(*)>1
  ORDER BY card_id
),
winning_points AS (
  SELECT ROUND(EXP(SUM(LN(CASE WHEN row_num = 1 THEN row_num ELSE 2 END)))) AS points
  FROM winning
  GROUP BY card_id
)
SELECT SUM(points)
FROM winning_points;

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'))
SELECT dense_rank() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'))
SELECT row_number() OVER (PARTITION BY NULL) AS q, x, 'b'
FROM t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'))
SELECT row_number() OVER (), row_number() OVER () from t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('b'), ('c'), ('c'))
SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT * FROM t
WHERE row_number() over () > 1;

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT * FROM t AS v JOIN t ON row_number() over () > 1;

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT DISTINCT ON (row_number() OVER ()) *
FROM t
ORDER BY row_number() OVER ()

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x DESC), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT dense_rank() OVER (ORDER BY x), x FROM t
ORDER BY dense_rank

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT row_number() FROM t

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x DESC), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x), x FROM t
ORDER BY row_number

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), (NULL), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x NULLS FIRST), x FROM t;

-- sqlfmt-corpus-separator --

WITH t (x) AS (VALUES ('a'), (NULL), ('b'), ('c'))
SELECT row_number() OVER (ORDER BY x NULLS LAST), x FROM t;

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT dense_rank() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC, a1.x DESC

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT dense_rank() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT row_number() OVER (PARTITION BY NULL ORDER BY 10000) AS q, a1.x
FROM t AS a1, t AS a2
ORDER BY q DESC

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT row_number() OVER (PARTITION BY x ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 1), ('b', 2), ('c', 1))
SELECT row_number() OVER (PARTITION BY y ORDER BY x DESC), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98))
SELECT row_number() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY row_number, x

-- sqlfmt-corpus-separator --

WITH t (x, y) AS (VALUES ('a', 98), ('b', 99), ('c', 98), ('a', 98), ('a', 99))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x), x FROM t
ORDER BY dense_rank, x

-- sqlfmt-corpus-separator --

WITH t (x, y, z) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY x DESC, z), x, y, z
FROM t
ORDER BY y, x DESC, z

-- sqlfmt-corpus-separator --

WITH t (x, y, z) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0))
SELECT dense_rank() OVER (PARTITION BY y ORDER BY z DESC), x, y, z
FROM t
ORDER BY y, z DESC, x

-- sqlfmt-corpus-separator --

WITH t (x, y, z) AS (VALUES (1, 'a', 1.0), (2, 'a', 1.0), (2, 'a', 1.0), (3, 'a', 1.0), (4, 'b', 0), (4, 'b', 1), (1, 'c', 'NaN'), (2, 'c', 'NaN'), (3, 'c', 1.0))
SELECT rank() OVER (PARTITION BY y ORDER BY z DESC), dense_rank() OVER (PARTITION BY y ORDER BY z DESC), x, y, z
FROM t;

-- sqlfmt-corpus-separator --

begin;

-- sqlfmt-corpus-separator --

create cluster c replicas (r1 (STORAGECTL ADDRESSES ['s:1'], STORAGE ADDRESSES ['st:1'], COMPUTECTL ADDRESSES ['c:1'], COMPUTE ADDRESSES ['ct:1']))

-- sqlfmt-corpus-separator --

create materialized view temp as select 1 where current_timestamp() > current_timestamp()

-- sqlfmt-corpus-separator --

create materialized view temp as select 1 where current_timestamp() > mz_now()

-- sqlfmt-corpus-separator --

create materialized view temp as select 1 where mz_version() = ''

-- sqlfmt-corpus-separator --

create materialized view temp as select mz_version()

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

create view events as select * from events_over_time where mz_now() >= column2;

-- sqlfmt-corpus-separator --

create view v as select mz_now() as x;

-- sqlfmt-corpus-separator --

select
  96 as c0,
  subq_0."c1" as c1
from
  (select
        ref_0."name" as c0,
        21 as c1
      from
        mz_introspection.mz_dataflow_operator_dataflows as ref_0
      where (select pg_catalog.count("batches") from mz_introspection.mz_arrangement_sizes_per_worker)
           = cast(coalesce((select "a" from public.t limit 1 offset 6)
            ,
          pg_catalog.pg_backend_pid()) as int4)) as subq_0
where (subq_0."c1" <= subq_0."c1")
  or (pg_catalog.mod(
      CAST(cast(null as uint2) as uint2),
      CAST(pg_catalog.mod(
        CAST(pg_catalog.mod(
          CAST(cast(nullif(cast(null as uint2),
            cast(null as uint2)) as uint2) as uint2),
          CAST(cast(nullif(cast(null as uint2),
            cast(null as uint2)) as uint2) as uint2)) as uint2),
        CAST(pg_catalog.mod(
          CAST(case when (cast(null as uuid) <= (select "id" from mz_introspection.mz_active_peeks limit 1 offset 1)
                  )
              or ((false)
                and (subq_0."c1" is not NULL)) then cast(null as uint2) else cast(null as uint2) end
             as uint2),
          CAST(cast(null as uint2) as uint2)) as uint2)) as uint2)) <> cast(nullif(cast(nullif(cast(null as uint2),
        pg_catalog.mod(
          CAST(case when (select "count" from mz_introspection.mz_compute_operator_durations_histogram limit 1 offset 6)
                 > cast(null as numeric) then cast(null as uint2) else cast(null as uint2) end
             as uint2),
          CAST(cast(null as uint2) as uint2))) as uint2),
      cast(null as uint2)) as uint2))
limit 99;

-- sqlfmt-corpus-separator --

select * from (SHOW NETWORK POLICIES)

-- sqlfmt-corpus-separator --

select distinct 'postgres', current_user() from mz_internal.mz_cluster_replica_metrics;

-- sqlfmt-corpus-separator --

select max(1) over (partition by 1 order by 1, 1)
from
  (select
        subq_2."c9" as c0
      from
        (select
              subq_1."c0" as c0,
              subq_1."c2" as c1,
              subq_1."c4" as c2,
              subq_1."c2" as c3,
              subq_1."c1" as c4,
              subq_1."c0" as c5,
              subq_1."c5" as c6,
              subq_1."c0" as c7,
              subq_1."c5" as c8,
              subq_1."c1" as c9,
              subq_1."c2" as c10,
              87 as c11,
              subq_1."c1" as c12
            from
              (select
                    subq_0."c1" as c0,
                    subq_0."c0" as c1,
                    subq_0."c1" as c2,
                    subq_0."c0" as c3,
                    subq_0."c1" as c4,
                    subq_0."c0" as c5
                  from
                    (select
                          ref_0."form_of_use" as c0,
                          ref_0."default_collate_schema" as c1
                        from
                          information_schema.character_sets as ref_0
                        ) as subq_0
                    ) as subq_1
            ) as subq_2
      ) as subq_3
where (case when (((select "collection_timestamp" from mz_internal.mz_storage_usage_by_shard limit 1 offset 4)
          ) < ((select pg_catalog.min("occurred_at") from mz_internal.mz_source_status_history)
          ))
      and ((case when subq_3."c0" is NULL then TIMESTAMPTZ '2023-01-01 01:23:45+06' else TIMESTAMPTZ '2023-01-01 01:23:45+06' end
          ) <> (pg_catalog.now())) then case when (((select pg_catalog.sum("connection_id") from mz_internal.mz_sessions)
            ) - (0::uint8)) >= ((select "worker_id" from mz_introspection.mz_arrangement_sharing_per_worker limit 1 offset 3)
          ) then numrange(0,0) else numrange(0,0) end
       else case when (((select pg_catalog.sum("connection_id") from mz_internal.mz_sessions)
            ) - (0::uint8)) >= ((select "worker_id" from mz_introspection.mz_arrangement_sharing_per_worker limit 1 offset 3)
          ) then numrange(0,0) else numrange(0,0) end
       end
    ) >= (case when (0::uint4) > (pg_catalog.mod(
        CAST((select 1 from mz_internal.mz_subscriptions limit 1 offset 2)
           as uint4),
        CAST((4294967295::uint4) * (2::uint4) as uint4))) then case when (mz_catalog.map_length(
          mz_internal.mz_role_oid_memberships())) = ((select pg_catalog.min("rolconnlimit") from pg_catalog.pg_roles)
          ) then case when (null::uint4) = (null::uint4) then numrange(0,0) else numrange(0,0) end
         else case when (null::uint4) = (null::uint4) then numrange(0,0) else numrange(0,0) end
         end
       else case when (mz_catalog.map_length(
          mz_internal.mz_role_oid_memberships())) = ((select pg_catalog.min("rolconnlimit") from pg_catalog.pg_roles)
          ) then case when (null::uint4) = (null::uint4) then numrange(0,0) else numrange(0,0) end
         else case when (null::uint4) = (null::uint4) then numrange(0,0) else numrange(0,0) end
         end
       end
    );

-- sqlfmt-corpus-separator --

select mz_now() < '3000-01-01';

-- sqlfmt-corpus-separator --

select position(strcol1 IN strcol2) from positiontest;

-- sqlfmt-corpus-separator --

select row_number() ignore nulls over();

-- sqlfmt-corpus-separator --

select row_number() ignore nulls respect nulls over();

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

-- sqlfmt-corpus-separator --

with v as (select mz_now() < '3000-01-01') select * from v;