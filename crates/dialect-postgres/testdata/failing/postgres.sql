/*
 * 6. EXCLUDE constraint.
 */
CREATE TABLE tbl_gist (c1 int, c2 int, c3 int, c4 box, EXCLUDE USING gist (c4 WITH &&) INCLUDE (c1, c2, c3))

-- sqlfmt-corpus-separator --

/* Has ee entry */

CREATE TABLE inhf (LIKE inhx, LIKE inhx)

-- sqlfmt-corpus-separator --

/* Multiple primary keys creation should fail */
CREATE TABLE inhg (x text, LIKE inhx INCLUDING INDEXES, PRIMARY KEY(x))

-- sqlfmt-corpus-separator --

/* Ok to create multiple unique indexes */
CREATE TABLE inhg (x text UNIQUE, LIKE inhz INCLUDING INDEXES)

-- sqlfmt-corpus-separator --

/* Throw error */

CREATE TABLE inhf (LIKE inhx INCLUDING DEFAULTS INCLUDING CONSTRAINTS)

-- sqlfmt-corpus-separator --

/* Use primary key imported by LIKE for self-referential FK constraint */
CREATE TABLE inhz (x text REFERENCES inhz, LIKE inhx INCLUDING INDEXES)

-- sqlfmt-corpus-separator --

/* but works fine with FULL replica identity */
ALTER TABLE testpub_tbl5d REPLICA IDENTITY FULL

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ALTER COLUMN c7 OPTIONS (ADD p1 'v1', ADD p2 'v2'),
                        ALTER COLUMN c8 OPTIONS (ADD p1 'v1', ADD p2 'v2')

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ALTER COLUMN c8 OPTIONS (SET p2 'V2', DROP p1)

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 OPTIONS (DROP delimiter, SET quote '~', ADD escape '@')

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 RENAME TO foreign_table_1

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE foreign_schema.foreign_table_1
	DISABLE TRIGGER trigtest_before_stmt

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE foreign_schema.foreign_table_1
	ENABLE TRIGGER trigtest_before_stmt

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE ft1 ALTER COLUMN c1 SET (n_distinct = 100)

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE ft1 ALTER COLUMN c1 SET STATISTICS 10000

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE ft1 ALTER COLUMN c7 OPTIONS (ADD p1 'v1', ADD p2 'v2'),
                        ALTER COLUMN c8 OPTIONS (ADD p1 'v1', ADD p2 'v2')

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE ft1 ALTER COLUMN c8 OPTIONS (SET p2 'V2', DROP p1)

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE ft1 ALTER COLUMN c8 SET STATISTICS -1

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE ft1 ALTER COLUMN c8 SET STORAGE PLAIN

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE ft1 ALTER COLUMN xmin OPTIONS (ADD p1 'v1')

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE ft1 ALTER CONSTRAINT ft1_c9_check DEFERRABLE

-- sqlfmt-corpus-separator --

ALTER FOREIGN TABLE ft1 OPTIONS (DROP delimiter, SET quote '~', ADD escape '@')

-- sqlfmt-corpus-separator --

ALTER INDEX IF EXISTS __attmp_onek_unique1 RENAME TO onek_unique1

-- sqlfmt-corpus-separator --

ALTER INDEX IF EXISTS __onek_unique1 RENAME TO attmp_onek_unique1

-- sqlfmt-corpus-separator --

ALTER INDEX attmp_idx ALTER COLUMN 1 SET STATISTICS 1000

-- sqlfmt-corpus-separator --

ALTER INDEX attmp_idx ALTER COLUMN 2 SET STATISTICS -1

-- sqlfmt-corpus-separator --

ALTER INDEX attmp_idx ALTER COLUMN 2 SET STATISTICS 1000

-- sqlfmt-corpus-separator --

ALTER INDEX attmp_idx ALTER COLUMN 4 SET STATISTICS 1000

-- sqlfmt-corpus-separator --

ALTER INDEX btree_part_idx ALTER COLUMN id SET (n_distinct=100)

-- sqlfmt-corpus-separator --

ALTER INDEX btree_tall_idx2 ALTER COLUMN id SET (n_distinct=100)

-- sqlfmt-corpus-separator --

ALTER INDEX concur_exprs_index_expr ALTER COLUMN 1 SET STATISTICS 100

-- sqlfmt-corpus-separator --

ALTER INDEX concur_reindex_part_index ATTACH PARTITION concur_reindex_part_index_0

-- sqlfmt-corpus-separator --

ALTER INDEX concur_reindex_part_index ATTACH PARTITION concur_reindex_part_index_10

-- sqlfmt-corpus-separator --

ALTER INDEX concur_reindex_part_index_0 ATTACH PARTITION concur_reindex_part_index_0_1

-- sqlfmt-corpus-separator --

ALTER INDEX concur_reindex_part_index_0 ATTACH PARTITION concur_reindex_part_index_0_2

-- sqlfmt-corpus-separator --

ALTER INDEX ptif_test0_index ATTACH PARTITION ptif_test01_index

-- sqlfmt-corpus-separator --

ALTER INDEX ptif_test1_index ATTACH PARTITION ptif_test11_index

-- sqlfmt-corpus-separator --

ALTER INDEX ptif_test_index ATTACH PARTITION ptif_test0_index

-- sqlfmt-corpus-separator --

ALTER INDEX ptif_test_index ATTACH PARTITION ptif_test1_index

-- sqlfmt-corpus-separator --

ALTER INDEX ptif_test_index ATTACH PARTITION ptif_test2_index

-- sqlfmt-corpus-separator --

ALTER INDEX ptif_test_index ATTACH PARTITION ptif_test3_index

-- sqlfmt-corpus-separator --

ALTER INDEX regress_tblspace_test_tbl_idx SET TABLESPACE pg_default

-- sqlfmt-corpus-separator --

ALTER INDEX t_a_idx ATTACH PARTITION tp_pkey

-- sqlfmt-corpus-separator --

ALTER INDEX t_b_idx ATTACH PARTITION tp_b_a_key

-- sqlfmt-corpus-separator --

ALTER INDEX tbl_idx ALTER COLUMN 1 SET STATISTICS 1000

-- sqlfmt-corpus-separator --

ALTER INDEX tbl_idx ALTER COLUMN 2 SET STATISTICS 1000

-- sqlfmt-corpus-separator --

ALTER INDEX tbl_idx ALTER COLUMN 3 SET STATISTICS 1000

-- sqlfmt-corpus-separator --

ALTER INDEX tbl_idx ALTER COLUMN 4 SET STATISTICS 1000

-- sqlfmt-corpus-separator --

ALTER INDEX tbspace_reindex_part_index ATTACH PARTITION tbspace_reindex_part_index_0

-- sqlfmt-corpus-separator --

ALTER INDEX tbspace_reindex_part_index ATTACH PARTITION tbspace_reindex_part_index_10

-- sqlfmt-corpus-separator --

ALTER INDEX tbspace_reindex_part_index_0 ATTACH PARTITION tbspace_reindex_part_index_0_1

-- sqlfmt-corpus-separator --

ALTER INDEX tbspace_reindex_part_index_0 ATTACH PARTITION tbspace_reindex_part_index_0_2

-- sqlfmt-corpus-separator --

ALTER INDEX testschema.anindex SET TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

ALTER INDEX testschema.part_a_idx SET TABLESPACE pg_default

-- sqlfmt-corpus-separator --

ALTER INDEX testschema.part_a_idx SET TABLESPACE pg_global

-- sqlfmt-corpus-separator --

ALTER INDEX testschema.part_a_idx SET TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW compressmv ALTER COLUMN x SET COMPRESSION lz4

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW heapmv SET ACCESS METHOD heap, SET ACCESS METHOD heap2

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW heapmv SET ACCESS METHOD heap2

-- sqlfmt-corpus-separator --

ALTER MATERIALIZED VIEW testschema.amv SET TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

ALTER ROLE regress_hasprivs RENAME TO regress_tenant

-- sqlfmt-corpus-separator --

ALTER ROLE regress_passwd2 RENAME TO regress_passwd2_new

-- sqlfmt-corpus-separator --

ALTER ROLE regress_passwd2_new RENAME TO regress_passwd2

-- sqlfmt-corpus-separator --

ALTER ROLE regress_role_normal RENAME TO regress_role_abnormal

-- sqlfmt-corpus-separator --

ALTER ROLE regress_schemauser2 RENAME TO regress_schemauser_renamed

-- sqlfmt-corpus-separator --

ALTER SEQUENCE identity_dump_logged_a_seq SET UNLOGGED

-- sqlfmt-corpus-separator --

ALTER SEQUENCE identity_dump_unlogged_a_seq SET LOGGED

-- sqlfmt-corpus-separator --

ALTER SEQUENCE sequence_test_unlogged SET LOGGED

-- sqlfmt-corpus-separator --

ALTER TABLE FKTABLE ADD CONSTRAINT fkdd FOREIGN KEY(ftest1) REFERENCES pktable
  ON DELETE CASCADE ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED

-- sqlfmt-corpus-separator --

ALTER TABLE FKTABLE ADD CONSTRAINT fkdi FOREIGN KEY(ftest1) REFERENCES pktable
  ON DELETE CASCADE ON UPDATE NO ACTION DEFERRABLE INITIALLY IMMEDIATE

-- sqlfmt-corpus-separator --

ALTER TABLE FKTABLE ADD CONSTRAINT fknd2 FOREIGN KEY(ftest1) REFERENCES pktable
  ON DELETE CASCADE ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED

-- sqlfmt-corpus-separator --

ALTER TABLE FKTABLE ALTER CONSTRAINT fk_con DEFERRABLE INITIALLY DEFERRED

-- sqlfmt-corpus-separator --

ALTER TABLE FKTABLE ALTER CONSTRAINT fkdd2 DEFERRABLE INITIALLY DEFERRED

-- sqlfmt-corpus-separator --

ALTER TABLE FKTABLE ALTER CONSTRAINT fkdi2 DEFERRABLE INITIALLY IMMEDIATE

-- sqlfmt-corpus-separator --

ALTER TABLE FKTABLE ALTER CONSTRAINT fknd2 NOT DEFERRABLE

-- sqlfmt-corpus-separator --

ALTER TABLE IF EXISTS constraint_rename_test ADD CONSTRAINT con4 UNIQUE (a)

-- sqlfmt-corpus-separator --

ALTER TABLE IF EXISTS tt8 ADD CHECK (f BETWEEN 0 AND 10)

-- sqlfmt-corpus-separator --

ALTER TABLE IF EXISTS tt8 ADD COLUMN f int

-- sqlfmt-corpus-separator --

ALTER TABLE IF EXISTS tt8 ADD CONSTRAINT xxx PRIMARY KEY(f)

-- sqlfmt-corpus-separator --

ALTER TABLE IF EXISTS tt8 ALTER COLUMN f SET DEFAULT 0

-- sqlfmt-corpus-separator --

ALTER TABLE ONLY gtest30 ALTER COLUMN b DROP EXPRESSION

-- sqlfmt-corpus-separator --

ALTER TABLE ONLY pitest2 ALTER COLUMN f3 SET GENERATED BY DEFAULT SET INCREMENT BY 2 SET START WITH 1000 RESTART

-- sqlfmt-corpus-separator --

ALTER TABLE ONLY pitest3
            ALTER COLUMN f3 ADD GENERATED ALWAYS AS IDENTITY (START WITH 3)

-- sqlfmt-corpus-separator --

ALTER TABLE ONLY pitest3 ALTER COLUMN f3 DROP IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE ONLY test_add_column
	ADD COLUMN IF NOT EXISTS c2 integer

-- sqlfmt-corpus-separator --

ALTER TABLE ONLY test_replica_identity4
  ATTACH PARTITION test_replica_identity4_1 FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE ONLY test_replica_identity4
  REPLICA IDENTITY USING INDEX test_replica_identity4_pkey

-- sqlfmt-corpus-separator --

ALTER TABLE PKTABLE ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE ab1 ALTER a SET STATISTICS -1

-- sqlfmt-corpus-separator --

ALTER TABLE ab1 ALTER a SET STATISTICS 0

-- sqlfmt-corpus-separator --

ALTER TABLE alter_table_under_transition_tables
  ALTER COLUMN name TYPE int USING name::integer

-- sqlfmt-corpus-separator --

ALTER TABLE am_partitioned SET ACCESS METHOD heap

-- sqlfmt-corpus-separator --

ALTER TABLE am_partitioned SET ACCESS METHOD heap2

-- sqlfmt-corpus-separator --

ALTER TABLE ataddindex
  ALTER f1 SET DATA TYPE TEXT,
  ADD EXCLUDE ((f1 LIKE 'a') WITH =)

-- sqlfmt-corpus-separator --

ALTER TABLE atnnparted ATTACH PARTITION atnnpart1 FOR VALUES IN ('1')

-- sqlfmt-corpus-separator --

ALTER TABLE atnnparted VALIDATE CONSTRAINT dummy_constr

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ALTER COLUMN i RESET (n_distinct_inherited)

-- sqlfmt-corpus-separator --

ALTER TABLE attmp ALTER COLUMN i SET (n_distinct = 1, n_distinct_inherited = 2)

-- sqlfmt-corpus-separator --

ALTER TABLE attmp3 VALIDATE CONSTRAINT b_greater_than_ten

-- sqlfmt-corpus-separator --

ALTER TABLE attmp3 VALIDATE CONSTRAINT b_greater_than_ten_not_enforced

-- sqlfmt-corpus-separator --

ALTER TABLE attmp3 VALIDATE CONSTRAINT b_le_20

-- sqlfmt-corpus-separator --

ALTER TABLE attmp3 VALIDATE CONSTRAINT identity

-- sqlfmt-corpus-separator --

ALTER TABLE attmp3 add constraint attmpconstr foreign key (a) references attmp2 match full NOT VALID

-- sqlfmt-corpus-separator --

ALTER TABLE attmp3 validate constraint attmpconstr

-- sqlfmt-corpus-separator --

ALTER TABLE b1 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE badcompresstbl ALTER a SET COMPRESSION I_Do_Not_Exist_Compression

-- sqlfmt-corpus-separator --

ALTER TABLE blog ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE category ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE circles ADD EXCLUDE USING gist
  (c1 WITH &&, (c2::circle) WITH &&)

-- sqlfmt-corpus-separator --

ALTER TABLE clstr_tst CLUSTER ON clstr_tst_b_c

-- sqlfmt-corpus-separator --

ALTER TABLE clstr_tst SET WITHOUT CLUSTER

-- sqlfmt-corpus-separator --

ALTER TABLE clstrpart CLUSTER ON clstrpart_idx

-- sqlfmt-corpus-separator --

ALTER TABLE clstrpart SET WITHOUT CLUSTER

-- sqlfmt-corpus-separator --

ALTER TABLE cmdata2 ALTER COLUMN f1 SET COMPRESSION pglz

-- sqlfmt-corpus-separator --

ALTER TABLE cmdata_pglz ALTER COLUMN f1 SET COMPRESSION lz4

-- sqlfmt-corpus-separator --

ALTER TABLE cmdata_pglz ALTER COLUMN f1 SET COMPRESSION pglz

-- sqlfmt-corpus-separator --

ALTER TABLE cmpart ATTACH PARTITION cmpart2 FOR VALUES WITH (MODULUS 2, REMAINDER 1)

-- sqlfmt-corpus-separator --

ALTER TABLE cmpart2 ALTER COLUMN f1 SET COMPRESSION lz4

-- sqlfmt-corpus-separator --

ALTER TABLE coll_t ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE comment ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE comment_test ALTER COLUMN id SET DATA TYPE int COLLATE "C"

-- sqlfmt-corpus-separator --

ALTER TABLE comment_test ALTER COLUMN id SET DATA TYPE int USING id::integer

-- sqlfmt-corpus-separator --

ALTER TABLE concur_clustered CLUSTER ON concur_clustered_i_idx

-- sqlfmt-corpus-separator --

ALTER TABLE concur_replident REPLICA IDENTITY
  USING INDEX concur_replident_i_idx

-- sqlfmt-corpus-separator --

ALTER TABLE copy_rel_to ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE copy_t ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE ctl_table ALTER COLUMN b SET STORAGE MAIN

-- sqlfmt-corpus-separator --

ALTER TABLE ctlt1 ALTER COLUMN a SET STORAGE MAIN

-- sqlfmt-corpus-separator --

ALTER TABLE ctlt2 ALTER COLUMN c SET STORAGE EXTERNAL

-- sqlfmt-corpus-separator --

ALTER TABLE ctlt3 ALTER COLUMN a SET STORAGE MAIN

-- sqlfmt-corpus-separator --

ALTER TABLE ctlt3 ALTER COLUMN c SET STORAGE EXTERNAL

-- sqlfmt-corpus-separator --

ALTER TABLE ctlt4 ALTER COLUMN c SET STORAGE EXTERNAL

-- sqlfmt-corpus-separator --

ALTER TABLE current_check ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE current_check_2 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE current_check_2 FORCE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE deferred_excl ADD EXCLUDE (f1 WITH =)

-- sqlfmt-corpus-separator --

ALTER TABLE document ATTACH PARTITION document_people FOR VALUES IN ('People')

-- sqlfmt-corpus-separator --

ALTER TABLE document ATTACH PARTITION document_places FOR VALUES IN ('Places')

-- sqlfmt-corpus-separator --

ALTER TABLE document ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE document FORCE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE document_people ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE droppk DETACH PARTITION droppk1

-- sqlfmt-corpus-separator --

ALTER TABLE droppk DETACH PARTITION droppk2

-- sqlfmt-corpus-separator --

ALTER TABLE droppk DETACH PARTITION droppk_d

-- sqlfmt-corpus-separator --

ALTER TABLE droppk2 DETACH PARTITION droppk21

-- sqlfmt-corpus-separator --

ALTER TABLE droppk2 DETACH PARTITION droppk2_d

-- sqlfmt-corpus-separator --

ALTER TABLE errtst ATTACH PARTITION errtst_part_1 FOR VALUES IN ('aaa')

-- sqlfmt-corpus-separator --

ALTER TABLE errtst ATTACH PARTITION errtst_part_2 FOR VALUES IN ('aaaa')

-- sqlfmt-corpus-separator --

ALTER TABLE errtst_parent ATTACH PARTITION errtst_child_fastdef FOR VALUES FROM (0) TO (10)

-- sqlfmt-corpus-separator --

ALTER TABLE errtst_parent ATTACH PARTITION errtst_child_plaindef FOR VALUES FROM (10) TO (20)

-- sqlfmt-corpus-separator --

ALTER TABLE errtst_parent ATTACH PARTITION errtst_child_reorder FOR VALUES FROM (20) TO (30)

-- sqlfmt-corpus-separator --

ALTER TABLE evttrig.id ALTER COLUMN col_d DROP IDENTITY,
  ALTER COLUMN col_d SET DATA TYPE int

-- sqlfmt-corpus-separator --

ALTER TABLE fail_part ALTER b TYPE char (2) COLLATE "POSIX"

-- sqlfmt-corpus-separator --

ALTER TABLE fd_pt1 ALTER COLUMN c1 SET (n_distinct = 100)

-- sqlfmt-corpus-separator --

ALTER TABLE fd_pt1 ALTER COLUMN c1 SET STATISTICS 10000

-- sqlfmt-corpus-separator --

ALTER TABLE fd_pt1 ALTER COLUMN c8 SET STATISTICS -1

-- sqlfmt-corpus-separator --

ALTER TABLE fd_pt1 ALTER COLUMN c8 SET STORAGE EXTERNAL

-- sqlfmt-corpus-separator --

ALTER TABLE fd_pt1 ALTER COLUMN c8 TYPE char(10) USING '0'

-- sqlfmt-corpus-separator --

ALTER TABLE fd_pt2 ATTACH PARTITION fd_pt2_1 FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE fd_pt2 DETACH PARTITION fd_pt2_1

-- sqlfmt-corpus-separator --

ALTER TABLE ffk DETACH PARTITION ffk1

-- sqlfmt-corpus-separator --

ALTER TABLE fk ATTACH PARTITION fk2 FOR VALUES FROM (750) TO (3500)

-- sqlfmt-corpus-separator --

ALTER TABLE fk ATTACH PARTITION fk3 FOR VALUES IN (3)

-- sqlfmt-corpus-separator --

ALTER TABLE fk ATTACH PARTITION fk4 FOR VALUES IN (50)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_notpartitioned_fk ADD CONSTRAINT fk_notpartitioned_fk_a_b_fkey
	FOREIGN KEY (a, b) REFERENCES fk_partitioned_pk NOT VALID

-- sqlfmt-corpus-separator --

ALTER TABLE fk_notpartitioned_fk VALIDATE CONSTRAINT fk_notpartitioned_fk_a_b_fkey

-- sqlfmt-corpus-separator --

ALTER TABLE fk_p_1 ATTACH PARTITION fk_p_1_2 FOR VALUES IN (2)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk ADD FOREIGN KEY (a, b)
  REFERENCES fk_notpartitioned_pk
  ON DELETE SET DEFAULT (a)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk ADD FOREIGN KEY (a, b)
  REFERENCES fk_notpartitioned_pk
  ON DELETE SET NULL (a)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk ADD FOREIGN KEY (a, b) REFERENCES fk_notpartitioned_pk NOT VALID

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk ATTACH PARTITION fk_partitioned_fk_1 FOR VALUES FROM (0,0) TO (1000,1000)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk ATTACH PARTITION fk_partitioned_fk_2
  FOR VALUES IN (1600)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk ATTACH PARTITION fk_partitioned_fk_2 FOR VALUES FROM (1000,1000) TO (2000,2000)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk ATTACH PARTITION fk_partitioned_fk_2 FOR VALUES IN (1500,1502)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk ATTACH PARTITION fk_partitioned_fk_3
  FOR VALUES FROM (2000,2000) TO (3000,3000)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk ATTACH PARTITION fk_partitioned_fk_3 FOR VALUES FROM (2000,2000) TO (3000,3000)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk ATTACH PARTITION fk_partitioned_fk_3 FOR VALUES IN (2500,2501,2502,2503)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk ATTACH PARTITION fk_partitioned_fk_4 FOR VALUES IN (3500,3502)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk ATTACH PARTITION fk_partitioned_fk_5 FOR VALUES IN (4500)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk DETACH PARTITION fk_partitioned_fk_2

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk DETACH PARTITION fk_partitioned_fk_4

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk DETACH PARTITION fk_partitioned_fk_5

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk VALIDATE CONSTRAINT fk_partitioned_fk_a_b_fkey

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk_2 ADD FOREIGN KEY (a, b) REFERENCES fk_notpartitioned_pk NOT VALID

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk_3 ADD FOREIGN KEY (a, b) REFERENCES fk_notpartitioned_pk NOT VALID

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk_3 ATTACH PARTITION fk_partitioned_fk_3_1 FOR VALUES FROM (2000,2000) TO (3000,3000)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk_4 ATTACH PARTITION fk_partitioned_fk_4_2 FOR VALUES FROM (100,100) TO (1000,1000)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk_5 ATTACH PARTITION fk_partitioned_fk_5_1 FOR VALUES FROM (0) TO (10)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk_6 ATTACH PARTITION fk_partitioned_fk_6_1 FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk_6 ATTACH PARTITION fk_partitioned_pk_6 FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_fk_6 DETACH PARTITION fk_partitioned_fk_6_1

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_pk ADD CONSTRAINT selffk FOREIGN KEY (a, b) REFERENCES fk_partitioned_pk NOT VALID

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_pk VALIDATE CONSTRAINT selffk

-- sqlfmt-corpus-separator --

ALTER TABLE fk_partitioned_pk_2 VALIDATE CONSTRAINT selffk

-- sqlfmt-corpus-separator --

ALTER TABLE fk_r ATTACH PARTITION fk_r_1 FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_r ATTACH PARTITION fk_r_2 FOR VALUES IN (2)

-- sqlfmt-corpus-separator --

ALTER TABLE fk_r DETACH PARTITION fk_r_1

-- sqlfmt-corpus-separator --

ALTER TABLE fk_r DETACH PARTITION fk_r_2

-- sqlfmt-corpus-separator --

ALTER TABLE fkpart11.pk1 ATTACH PARTITION fkpart11.pk11 FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE fkpart11.pk1 ATTACH PARTITION fkpart11.pk12 FOR VALUES IN (2)

-- sqlfmt-corpus-separator --

ALTER TABLE fktable ALTER CONSTRAINT fktable_fk_fkey DEFERRABLE INITIALLY IMMEDIATE

-- sqlfmt-corpus-separator --

ALTER TABLE fktable ALTER CONSTRAINT fktable_fk_fkey NOT DEFERRABLE

-- sqlfmt-corpus-separator --

ALTER TABLE foo_parted ATTACH PARTITION foo_part_d1 FOR VALUES IN (3)

-- sqlfmt-corpus-separator --

ALTER TABLE foo_parted ATTACH PARTITION foo_part_d2 FOR VALUES IN (4)

-- sqlfmt-corpus-separator --

ALTER TABLE gtest20b VALIDATE CONSTRAINT chk

-- sqlfmt-corpus-separator --

ALTER TABLE gtest27 ALTER COLUMN x TYPE boolean USING x <> 0

-- sqlfmt-corpus-separator --

ALTER TABLE gtest29 ALTER COLUMN a DROP EXPRESSION

-- sqlfmt-corpus-separator --

ALTER TABLE gtest29 ALTER COLUMN a DROP EXPRESSION IF EXISTS

-- sqlfmt-corpus-separator --

ALTER TABLE gtest30 ALTER COLUMN b DROP EXPRESSION

-- sqlfmt-corpus-separator --

ALTER TABLE gtest31_2 ADD CONSTRAINT cc CHECK ((y).b IS NOT NULL)

-- sqlfmt-corpus-separator --

ALTER TABLE gtest_parent ATTACH PARTITION gtest_child FOR VALUES FROM ('2016-07-01') TO ('2016-08-01')

-- sqlfmt-corpus-separator --

ALTER TABLE gtest_parent ATTACH PARTITION gtest_child3 FOR VALUES FROM ('2016-09-01') TO ('2016-10-01')

-- sqlfmt-corpus-separator --

ALTER TABLE hash_parted ATTACH PARTITION fail_part FOR VALUES WITH (MODULUS 0, REMAINDER 1)

-- sqlfmt-corpus-separator --

ALTER TABLE hash_parted ATTACH PARTITION fail_part FOR VALUES WITH (MODULUS 3, REMAINDER 2)

-- sqlfmt-corpus-separator --

ALTER TABLE hash_parted ATTACH PARTITION fail_part FOR VALUES WITH (MODULUS 8, REMAINDER 0)

-- sqlfmt-corpus-separator --

ALTER TABLE hash_parted ATTACH PARTITION fail_part FOR VALUES WITH (MODULUS 8, REMAINDER 4)

-- sqlfmt-corpus-separator --

ALTER TABLE hash_parted ATTACH PARTITION fail_part FOR VALUES WITH (MODULUS 8, REMAINDER 8)

-- sqlfmt-corpus-separator --

ALTER TABLE hash_parted ATTACH PARTITION hpart_2 FOR VALUES WITH (MODULUS 4, REMAINDER 1)

-- sqlfmt-corpus-separator --

ALTER TABLE hash_parted ATTACH PARTITION hpart_5 FOR VALUES WITH (MODULUS 4, REMAINDER 2)

-- sqlfmt-corpus-separator --

ALTER TABLE hash_parted DETACH PARTITION hpart_4

-- sqlfmt-corpus-separator --

ALTER TABLE hash_parted DETACH PARTITION not_a_part

-- sqlfmt-corpus-separator --

ALTER TABLE hash_parted2 DETACH PARTITION part_hp CONCURRENTLY

-- sqlfmt-corpus-separator --

ALTER TABLE heaptable SET ACCESS METHOD heap

-- sqlfmt-corpus-separator --

ALTER TABLE heaptable SET ACCESS METHOD heap, SET ACCESS METHOD heap2

-- sqlfmt-corpus-separator --

ALTER TABLE heaptable SET ACCESS METHOD heap2

-- sqlfmt-corpus-separator --

ALTER TABLE idxpart ATTACH PARTITION idxpart1 FOR VALUES FROM (100) TO (200)

-- sqlfmt-corpus-separator --

ALTER TABLE itest14 ALTER id ADD GENERATED BY DEFAULT AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE itest17 ALTER COLUMN a ADD GENERATED ALWAYS AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE itest18 SET UNLOGGED, ALTER COLUMN a ADD GENERATED ALWAYS AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE itest3 ALTER COLUMN a ADD GENERATED ALWAYS AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE itest4 ALTER COLUMN a ADD GENERATED ALWAYS AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE itest4 ALTER COLUMN a DROP IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE itest4 ALTER COLUMN a DROP IDENTITY IF EXISTS

-- sqlfmt-corpus-separator --

ALTER TABLE itest4 ALTER COLUMN b ADD GENERATED ALWAYS AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE itest4 ALTER COLUMN c ADD GENERATED ALWAYS AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE itest5 ALTER COLUMN a ADD GENERATED ALWAYS AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE itest6 ALTER COLUMN a SET GENERATED BY DEFAULT SET INCREMENT BY 2 SET START WITH 100 RESTART

-- sqlfmt-corpus-separator --

ALTER TABLE itest6 ALTER COLUMN b SET INCREMENT BY 2

-- sqlfmt-corpus-separator --

ALTER TABLE itest7 ALTER COLUMN a DROP IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE itest7 ALTER COLUMN a RESTART

-- sqlfmt-corpus-separator --

ALTER TABLE itest7 ALTER COLUMN a SET GENERATED BY DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE itest7d ALTER COLUMN a ADD GENERATED ALWAYS AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE itest8
  ADD COLUMN f2 int NOT NULL,
  ALTER COLUMN f2 ADD GENERATED ALWAYS AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE itest8
  ADD COLUMN f22 int NOT NULL,
  ALTER COLUMN f22 ADD GENERATED ALWAYS AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE itest8
  ADD COLUMN f3 int NOT NULL,
  ALTER COLUMN f3 ADD GENERATED ALWAYS AS IDENTITY,
  ALTER COLUMN f3 SET GENERATED BY DEFAULT SET INCREMENT 10

-- sqlfmt-corpus-separator --

ALTER TABLE itest8
  ALTER COLUMN f4 SET NOT NULL,
  ALTER COLUMN f4 ADD GENERATED ALWAYS AS IDENTITY,
  ALTER COLUMN f4 SET DATA TYPE bigint

-- sqlfmt-corpus-separator --

ALTER TABLE itest8
  ALTER COLUMN f5 DROP IDENTITY,
  ALTER COLUMN f5 DROP NOT NULL,
  ALTER COLUMN f5 SET DATA TYPE bigint

-- sqlfmt-corpus-separator --

ALTER TABLE large_tuple_test ALTER COLUMN b SET STORAGE plain

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted ATTACH PARTITION child FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted ATTACH PARTITION def_part DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted ATTACH PARTITION fail_def_part DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted ATTACH PARTITION fail_part FOR VALUES FROM (1) TO (10)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted ATTACH PARTITION fail_part FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted ATTACH PARTITION list_part1 for VALUES in (2,3)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted ATTACH PARTITION nonexistent FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted ATTACH PARTITION parent FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted ATTACH PARTITION part_1 FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted ATTACH PARTITION part_fail FOR VALUES IN (2)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted2 ATTACH PARTITION list_parted2 FOR VALUES IN (0)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted2 ATTACH PARTITION part_2 FOR VALUES IN (2)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted2 ATTACH PARTITION part_3 FOR VALUES IN (11)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted2 ATTACH PARTITION part_3_4 FOR VALUES IN (3, 4)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted2 ATTACH PARTITION part_5 FOR VALUES IN (5)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted2 ATTACH PARTITION part_6 FOR VALUES IN (6)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted2 ATTACH PARTITION part_7 FOR VALUES IN (7)

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted2 DETACH PARTITION not_a_part

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted2 DETACH PARTITION part_1

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted2 DETACH PARTITION part_3_4

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted2 DETACH PARTITION part_4

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted2 DETACH PARTITION part_5

-- sqlfmt-corpus-separator --

ALTER TABLE list_parted2 DETACH PARTITION part_7

-- sqlfmt-corpus-separator --

ALTER TABLE logged1 SET UNLOGGED

-- sqlfmt-corpus-separator --

ALTER TABLE logged2 SET UNLOGGED

-- sqlfmt-corpus-separator --

ALTER TABLE logged3 SET UNLOGGED

-- sqlfmt-corpus-separator --

ALTER TABLE lt1 ATTACH PARTITION ft_part2
  FOR VALUES FROM (1000) TO (2000)

-- sqlfmt-corpus-separator --

ALTER TABLE lt1 ATTACH PARTITION ft_part2 FOR VALUES FROM (1000) TO (2000)

-- sqlfmt-corpus-separator --

ALTER TABLE lt1_part1 ATTACH PARTITION ft_part_1_2 FOR VALUES FROM (100) TO (200)

-- sqlfmt-corpus-separator --

ALTER TABLE measurement ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE measurement FORCE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE no_index_cleanup ALTER COLUMN t SET STORAGE EXTERNAL

-- sqlfmt-corpus-separator --

ALTER TABLE no_index_cleanup SET (vacuum_index_cleanup = true,
    toast.vacuum_index_cleanup = false)

-- sqlfmt-corpus-separator --

ALTER TABLE notnull_part1_upg ATTACH PARTITION notnull_part1_2_upg FOR VALUES IN (3,4)

-- sqlfmt-corpus-separator --

ALTER TABLE notnull_part1_upg ATTACH PARTITION notnull_part1_3_upg FOR VALUES IN (NULL,5)

-- sqlfmt-corpus-separator --

ALTER TABLE notnull_tbl1 ALTER COLUMN a ADD GENERATED ALWAYS AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE notnull_tbl1 ATTACH PARTITION notnull_tbl1_2 FOR VALUES IN (3,4)

-- sqlfmt-corpus-separator --

ALTER TABLE notnull_tbl1 ATTACH PARTITION notnull_tbl1_3 FOR VALUES IN (NULL,5)

-- sqlfmt-corpus-separator --

ALTER TABLE notnull_tbl1 VALIDATE CONSTRAINT nn

-- sqlfmt-corpus-separator --

ALTER TABLE notnull_tbl1 VALIDATE CONSTRAINT nn_parent

-- sqlfmt-corpus-separator --

ALTER TABLE notnull_tbl1_3 VALIDATE CONSTRAINT nn3

-- sqlfmt-corpus-separator --

ALTER TABLE owned_by_me ATTACH PARTITION not_owned_by_me FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE pa_target ATTACH PARTITION part1 FOR VALUES IN (1,4)

-- sqlfmt-corpus-separator --

ALTER TABLE pa_target ATTACH PARTITION part2 FOR VALUES IN (2,5,6)

-- sqlfmt-corpus-separator --

ALTER TABLE pa_target ATTACH PARTITION part3 FOR VALUES IN (3,8,9)

-- sqlfmt-corpus-separator --

ALTER TABLE pa_target ATTACH PARTITION part4 DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE pa_target ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE pa_target FORCE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE pagg_tab_ml ATTACH PARTITION pagg_tab_ml_p3 FOR VALUES FROM (20) TO (30)

-- sqlfmt-corpus-separator --

ALTER TABLE pagg_tab_ml_p3 ATTACH PARTITION pagg_tab_ml_p3_s1 FOR VALUES FROM (0) TO (7)

-- sqlfmt-corpus-separator --

ALTER TABLE part ATTACH PARTITION part_rev FOR VALUES IN (3)

-- sqlfmt-corpus-separator --

ALTER TABLE part3_self_fk ATTACH PARTITION part33_self_fk FOR VALUES FROM (30) TO (40)

-- sqlfmt-corpus-separator --

ALTER TABLE part3_self_fk DETACH PARTITION part33_self_fk

-- sqlfmt-corpus-separator --

ALTER TABLE part_5 ATTACH PARTITION list_parted2 FOR VALUES IN ('b')

-- sqlfmt-corpus-separator --

ALTER TABLE part_5 ATTACH PARTITION part5_p1 FOR VALUES IN ('y')

-- sqlfmt-corpus-separator --

ALTER TABLE part_7 ATTACH PARTITION part_7_a_null FOR VALUES IN ('a', null)

-- sqlfmt-corpus-separator --

ALTER TABLE part_b_10_b_20 ATTACH PARTITION part_c_100_200 FOR VALUES FROM (100) TO (200)

-- sqlfmt-corpus-separator --

ALTER TABLE part_b_10_b_20 ATTACH PARTITION part_c_1_100 FOR VALUES FROM (1) TO (100)

-- sqlfmt-corpus-separator --

ALTER TABLE part_document ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE part_document_satire ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE parted_fk_naming ATTACH PARTITION parted_fk_naming_1 FOR VALUES IN ('1')

-- sqlfmt-corpus-separator --

ALTER TABLE parted_self_fk ATTACH PARTITION part1_self_fk FOR VALUES FROM (0) TO (10)

-- sqlfmt-corpus-separator --

ALTER TABLE parted_self_fk ATTACH PARTITION part2_self_fk FOR VALUES FROM (10) TO (20)

-- sqlfmt-corpus-separator --

ALTER TABLE parted_self_fk ATTACH PARTITION part3_self_fk FOR VALUES FROM (20) TO (40)

-- sqlfmt-corpus-separator --

ALTER TABLE parted_self_fk ATTACH PARTITION part3_self_fk FOR VALUES FROM (30) TO (40)

-- sqlfmt-corpus-separator --

ALTER TABLE parted_self_fk DETACH PARTITION part2_self_fk

-- sqlfmt-corpus-separator --

ALTER TABLE parted_self_fk DETACH PARTITION part3_self_fk

-- sqlfmt-corpus-separator --

ALTER TABLE pitest1 ALTER COLUMN f3 ADD GENERATED BY DEFAULT AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE pitest1 ATTACH PARTITION pitest1_p2 FOR VALUES FROM ('2016-08-01') TO ('2016-09-01')

-- sqlfmt-corpus-separator --

ALTER TABLE pitest1 ATTACH PARTITION pitest1_pfail FOR VALUES FROM ('2016-11-01') TO ('2016-12-01')

-- sqlfmt-corpus-separator --

ALTER TABLE pitest1_p2 ALTER COLUMN f3 ADD GENERATED BY DEFAULT AS IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE pitest2 ALTER COLUMN f3 SET GENERATED BY DEFAULT SET INCREMENT BY 2 SET START WITH 1000 RESTART

-- sqlfmt-corpus-separator --

ALTER TABLE pitest2 DETACH PARTITION pitest2_p1

-- sqlfmt-corpus-separator --

ALTER TABLE pitest2_p1 ALTER COLUMN f3 SET GENERATED BY DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE pitest2_p1 ALTER COLUMN f3 SET INCREMENT BY 2

-- sqlfmt-corpus-separator --

ALTER TABLE pitest3
            ALTER COLUMN f3 SET NOT NULL,
            ALTER COLUMN f3 ADD GENERATED ALWAYS AS IDENTITY (START WITH 3)

-- sqlfmt-corpus-separator --

ALTER TABLE pitest3 ALTER COLUMN f3 DROP IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE pitest3 ATTACH PARTITION pitest1_pfail FOR VALUES FROM ('2016-11-01') TO ('2016-12-01')

-- sqlfmt-corpus-separator --

ALTER TABLE pitest3_p1
            ALTER COLUMN f3 SET NOT NULL,
            ALTER COLUMN f3 ADD GENERATED ALWAYS AS IDENTITY (START WITH 3)

-- sqlfmt-corpus-separator --

ALTER TABLE pitest3_p1 ALTER COLUMN f3 DROP IDENTITY

-- sqlfmt-corpus-separator --

ALTER TABLE pk ATTACH PARTITION pk2 FOR VALUES FROM (1000) TO (2000)

-- sqlfmt-corpus-separator --

ALTER TABLE pk ATTACH PARTITION pk3 FOR VALUES IN (31, 32)

-- sqlfmt-corpus-separator --

ALTER TABLE pk ATTACH PARTITION pk4 FOR VALUES FROM (3000) TO (4000)

-- sqlfmt-corpus-separator --

ALTER TABLE pk ATTACH PARTITION pk5 FOR VALUES FROM (4000) TO (5000)

-- sqlfmt-corpus-separator --

ALTER TABLE pk3 ATTACH PARTITION pk32 FOR VALUES IN (32)

-- sqlfmt-corpus-separator --

ALTER TABLE plt1 ATTACH PARTITION plt1_p3 DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE plt1 DETACH PARTITION plt1_p3

-- sqlfmt-corpus-separator --

ALTER TABLE plt1_adv ATTACH PARTITION plt1_adv_p1 DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE plt1_adv ATTACH PARTITION plt1_adv_p1 FOR VALUES IN ('0001', '0003')

-- sqlfmt-corpus-separator --

ALTER TABLE plt1_adv DETACH PARTITION plt1_adv_p1

-- sqlfmt-corpus-separator --

ALTER TABLE plt2 ATTACH PARTITION plt2_p3 DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE plt2 DETACH PARTITION plt2_p3

-- sqlfmt-corpus-separator --

ALTER TABLE plt2_adv ATTACH PARTITION plt2_adv_p2 FOR VALUES IN ('0004', '0006')

-- sqlfmt-corpus-separator --

ALTER TABLE plt2_adv ATTACH PARTITION plt2_adv_p2_ext DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE plt2_adv ATTACH PARTITION plt2_adv_p3 FOR VALUES IN ('0007', '0009')

-- sqlfmt-corpus-separator --

ALTER TABLE plt2_adv DETACH PARTITION plt2_adv_p2

-- sqlfmt-corpus-separator --

ALTER TABLE plt2_adv DETACH PARTITION plt2_adv_p2_ext

-- sqlfmt-corpus-separator --

ALTER TABLE plt2_adv DETACH PARTITION plt2_adv_p3

-- sqlfmt-corpus-separator --

ALTER TABLE pp ATTACH PARTITION pp_1 FOR VALUES FROM (1) TO (5)

-- sqlfmt-corpus-separator --

ALTER TABLE pp ATTACH PARTITION pp_2 FOR VALUES FROM (5) TO (10)

-- sqlfmt-corpus-separator --

ALTER TABLE pp_nn ATTACH PARTITION pp_nn_1 FOR VALUES IN (NULL,5)

-- sqlfmt-corpus-separator --

ALTER TABLE pp_nn_1 VALIDATE CONSTRAINT nn1

-- sqlfmt-corpus-separator --

ALTER TABLE prt1 ATTACH PARTITION prt1_p3 DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE prt1 DETACH PARTITION prt1_p3

-- sqlfmt-corpus-separator --

ALTER TABLE prt1_adv ATTACH PARTITION prt1_adv_p1 DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE prt1_adv ATTACH PARTITION prt1_adv_p3 FOR VALUES FROM (300) TO (400)

-- sqlfmt-corpus-separator --

ALTER TABLE prt1_adv DETACH PARTITION prt1_adv_p1

-- sqlfmt-corpus-separator --

ALTER TABLE prt1_adv DETACH PARTITION prt1_adv_p3

-- sqlfmt-corpus-separator --

ALTER TABLE prt2 ATTACH PARTITION prt2_p3 DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE prt2 DETACH PARTITION prt2_p3

-- sqlfmt-corpus-separator --

ALTER TABLE prt2_adv ATTACH PARTITION prt2_adv_p3 DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE prt2_adv ATTACH PARTITION prt2_adv_p3 FOR VALUES FROM (350) TO (500)

-- sqlfmt-corpus-separator --

ALTER TABLE prt2_adv DETACH PARTITION prt2_adv_p3

-- sqlfmt-corpus-separator --

ALTER TABLE quuux ATTACH PARTITION quuux1 FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE quuux ATTACH PARTITION quuux2 FOR VALUES IN (2)

-- sqlfmt-corpus-separator --

ALTER TABLE r1 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE r1 FORCE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE r1 NO FORCE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE r2 DISABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE r2 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE r2 FORCE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE r2 NO FORCE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE range_parted ATTACH PARTITION part1 FOR VALUES FROM (1, 1) TO (1, 10)

-- sqlfmt-corpus-separator --

ALTER TABLE range_parted ATTACH PARTITION part2 FOR VALUES FROM (1, 10) TO (1, 20)

-- sqlfmt-corpus-separator --

ALTER TABLE range_parted ATTACH PARTITION part_b_10_b_20 FOR VALUES FROM ('b', 10) TO ('b', 20)

-- sqlfmt-corpus-separator --

ALTER TABLE range_parted ATTACH PARTITION part_b_20_b_30 FOR VALUES FROM ('b', 20) TO ('b', 30)

-- sqlfmt-corpus-separator --

ALTER TABLE range_parted ATTACH PARTITION partr_def2 DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE range_parted ATTACH partition part3 FOR VALUES FROM (2, 10) TO (2, 20)

-- sqlfmt-corpus-separator --

ALTER TABLE range_parted ATTACH partition part3 FOR VALUES FROM (3, 10) TO (3, 20)

-- sqlfmt-corpus-separator --

ALTER TABLE range_parted ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE range_parted2 DETACH PARTITION part_rp

-- sqlfmt-corpus-separator --

ALTER TABLE range_parted2 DETACH PARTITION part_rp CONCURRENTLY

-- sqlfmt-corpus-separator --

ALTER TABLE range_parted2 DETACH PARTITION part_rpd CONCURRENTLY

-- sqlfmt-corpus-separator --

ALTER TABLE rec1 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE rec2 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE ref ALTER CONSTRAINT ref_f1_f2_fkey
  DEFERRABLE INITIALLY DEFERRED

-- sqlfmt-corpus-separator --

ALTER TABLE ref ALTER CONSTRAINT ref_f1_f2_fkey_1
  DEFERRABLE INITIALLY DEFERRED

-- sqlfmt-corpus-separator --

ALTER TABLE ref22 ALTER CONSTRAINT ref_f1_f2_fkey
  DEFERRABLE INITIALLY IMMEDIATE

-- sqlfmt-corpus-separator --

ALTER TABLE regress_constr_partitioned DETACH PARTITION regress_constr_partition1

-- sqlfmt-corpus-separator --

ALTER TABLE regular_table DETACH PARTITION any_name

-- sqlfmt-corpus-separator --

ALTER TABLE regular_table DETACH PARTITION any_name CONCURRENTLY

-- sqlfmt-corpus-separator --

ALTER TABLE regular_table DETACH PARTITION any_name FINALIZE

-- sqlfmt-corpus-separator --

ALTER TABLE reloptions_test RESET (fillfactor=12)

-- sqlfmt-corpus-separator --

ALTER TABLE reloptions_test RESET (toast.autovacuum_vacuum_cost_delay)

-- sqlfmt-corpus-separator --

ALTER TABLE rf_tbl_abcd_nopk REPLICA IDENTITY FULL

-- sqlfmt-corpus-separator --

ALTER TABLE rf_tbl_abcd_nopk REPLICA IDENTITY NOTHING

-- sqlfmt-corpus-separator --

ALTER TABLE rf_tbl_abcd_nopk REPLICA IDENTITY USING INDEX idx_abcd_nopk_c

-- sqlfmt-corpus-separator --

ALTER TABLE rf_tbl_abcd_part_pk ATTACH PARTITION rf_tbl_abcd_part_pk_1 FOR VALUES FROM (1) TO (10)

-- sqlfmt-corpus-separator --

ALTER TABLE rf_tbl_abcd_pk REPLICA IDENTITY FULL

-- sqlfmt-corpus-separator --

ALTER TABLE rf_tbl_abcd_pk REPLICA IDENTITY NOTHING

-- sqlfmt-corpus-separator --

ALTER TABLE rf_tbl_abcd_pk REPLICA IDENTITY USING INDEX idx_abcd_pk_c

-- sqlfmt-corpus-separator --

ALTER TABLE rls_child_tbl ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE rls_part ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE rls_ptbl ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE rls_t1 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE rls_t1 FORCE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE rls_tbl ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE rls_tbl FORCE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE rls_tbl_force ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE rls_tbl_force FORCE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE rls_test_src ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE rls_test_tgt ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE rule_merge1 DISABLE RULE rule1

-- sqlfmt-corpus-separator --

ALTER TABLE rule_merge1 DISABLE RULE rule2

-- sqlfmt-corpus-separator --

ALTER TABLE rule_merge1 DISABLE RULE rule3

-- sqlfmt-corpus-separator --

ALTER TABLE ruletest1 DISABLE RULE rule1

-- sqlfmt-corpus-separator --

ALTER TABLE ruletest1 ENABLE REPLICA RULE rule1

-- sqlfmt-corpus-separator --

ALTER TABLE ruletest1 ENABLE RULE rule1

-- sqlfmt-corpus-separator --

ALTER TABLE s1 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE s2 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE sales_range ATTACH PARTITION sales_apr2022 FOR VALUES FROM ('2022-04-01') TO ('2022-05-01')

-- sqlfmt-corpus-separator --

ALTER TABLE sales_range DETACH PARTITION sales_others

-- sqlfmt-corpus-separator --

ALTER TABLE salespeople ATTACH PARTITION salespeople10_20 FOR VALUES FROM (10) TO (20)

-- sqlfmt-corpus-separator --

ALTER TABLE salespeople ATTACH PARTITION salespeople10_40 FOR VALUES FROM (10) TO (40)

-- sqlfmt-corpus-separator --

ALTER TABLE salespeople ATTACH PARTITION salespeople20_30 FOR VALUES FROM (20) TO (30)

-- sqlfmt-corpus-separator --

ALTER TABLE salespeople ATTACH PARTITION salespeople2_5 FOR VALUES FROM (2) TO (5)

-- sqlfmt-corpus-separator --

ALTER TABLE salespeople ATTACH PARTITION salespeople30_40 FOR VALUES FROM (30) TO (40)

-- sqlfmt-corpus-separator --

ALTER TABLE sch1.tbl1 ATTACH PARTITION sch1.tbl1_part3 FOR VALUES FROM (20) to (30)

-- sqlfmt-corpus-separator --

ALTER TABLE sub_parted ATTACH PARTITION sub_part1 for VALUES in (1)

-- sqlfmt-corpus-separator --

ALTER TABLE sub_parted ATTACH PARTITION sub_part2 for VALUES in (2)

-- sqlfmt-corpus-separator --

ALTER TABLE t ATTACH PARTITION tp FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE t ATTACH PARTITION tp FOR VALUES WITH (MODULUS 1, REMAINDER 0)

-- sqlfmt-corpus-separator --

ALTER TABLE t ATTACH PARTITION tp_0_1 FOR VALUES FROM (0) TO (1)

-- sqlfmt-corpus-separator --

ALTER TABLE t ATTACH PARTITION tp_0_2 FOR VALUES FROM (0) TO (2)

-- sqlfmt-corpus-separator --

ALTER TABLE t ATTACH PARTITION tp_1 FOR VALUES FROM (-1) TO (10)

-- sqlfmt-corpus-separator --

ALTER TABLE t ATTACH PARTITION tp_1_2 FOR VALUES FROM (1) TO (2)

-- sqlfmt-corpus-separator --

ALTER TABLE t ATTACH PARTITION tp_2 FOR VALUES FROM (10) TO (20)

-- sqlfmt-corpus-separator --

ALTER TABLE t ATTACH PARTITION tp_x FOR VALUES FROM (0) TO (2)

-- sqlfmt-corpus-separator --

ALTER TABLE t DETACH PARTITION tp

-- sqlfmt-corpus-separator --

ALTER TABLE t1 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE t2 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE t_fk ADD CONSTRAINT t_fk_i_fkey FOREIGN KEY (i) REFERENCES t NOT VALID

-- sqlfmt-corpus-separator --

ALTER TABLE tab_main ATTACH PARTITION testpub_root FOR VALUES FROM (0) TO (200)

-- sqlfmt-corpus-separator --

ALTER TABLE tbl_include_box_pk add PRIMARY KEY (c1, c2) INCLUDE (c3, c4)

-- sqlfmt-corpus-separator --

ALTER TABLE tbl_include_pk add PRIMARY KEY (c1, c2) INCLUDE (c3, c4)

-- sqlfmt-corpus-separator --

ALTER TABLE tbl_include_unique1 add UNIQUE (c1, c2) INCLUDE (c3, c4)

-- sqlfmt-corpus-separator --

ALTER TABLE tbl_include_unique2 add UNIQUE (c1, c2) INCLUDE (c3, c4)

-- sqlfmt-corpus-separator --

ALTER TABLE temp_parted ATTACH PARTITION foreign_part DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE temp_parted ATTACH PARTITION perm_part FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE temporal3 ALTER COLUMN valid_at TYPE tstzrange USING tstzrange(lower(valid_at), upper(valid_at))

-- sqlfmt-corpus-separator --

ALTER TABLE temporal_fk_mltrng2mltrng
    ALTER CONSTRAINT temporal_fk_mltrng2mltrng_fk
    DEFERRABLE INITIALLY DEFERRED

-- sqlfmt-corpus-separator --

ALTER TABLE temporal_fk_rng2rng
    ALTER CONSTRAINT temporal_fk_rng2rng_fk
    DEFERRABLE INITIALLY DEFERRED

-- sqlfmt-corpus-separator --

ALTER TABLE temporal_fk_rng2rng
  ALTER COLUMN valid_at TYPE daterange USING daterange(lower(valid_at)::date, upper(valid_at)::date)

-- sqlfmt-corpus-separator --

ALTER TABLE temporal_partitioned ATTACH PARTITION temporal_partitioned_3 FOR VALUES IN ('[3,4)', '[4,5)')

-- sqlfmt-corpus-separator --

ALTER TABLE temporal_partitioned ATTACH PARTITION temporal_partitioned_5 FOR VALUES IN ('[5,6)', '[6,7)')

-- sqlfmt-corpus-separator --

ALTER TABLE temporal_partitioned DETACH PARTITION temporal_partitioned_3

-- sqlfmt-corpus-separator --

ALTER TABLE temporal_partitioned DETACH PARTITION temporal_partitioned_5

-- sqlfmt-corpus-separator --

ALTER TABLE test_add_column
	ADD IF NOT EXISTS c6 integer

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity REPLICA IDENTITY DEFAULT

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity REPLICA IDENTITY FULL

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_expr

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_hash

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_keyab

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_keyab_key

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_nonkey

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_othertable_pkey

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_partial

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_pkey

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_unique_defer

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity2 REPLICA IDENTITY USING INDEX test_replica_identity2_id_key

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity3 REPLICA IDENTITY FULL

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity3 REPLICA IDENTITY USING INDEX test_replica_identity3_id_key

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity5 REPLICA IDENTITY USING INDEX test_replica_identity5_a_b_key

-- sqlfmt-corpus-separator --

ALTER TABLE test_replica_identity_t3 REPLICA IDENTITY USING INDEX pk

-- sqlfmt-corpus-separator --

ALTER TABLE test_type_diff ALTER COLUMN f2 TYPE bigint USING f2::bigint

-- sqlfmt-corpus-separator --

ALTER TABLE test_type_diff2 ALTER COLUMN int_four TYPE int4 USING (pg_column_size(test_type_diff2))

-- sqlfmt-corpus-separator --

ALTER TABLE test_type_diff2 ALTER COLUMN int_four TYPE int8 USING int_four::int8

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_gencol REPLICA IDENTITY FULL

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_gencol REPLICA IDENTITY USING index testpub_gencol_idx

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_parted ATTACH PARTITION testpub_parted1 FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_parted ATTACH PARTITION testpub_parted2 FOR VALUES IN (2)

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_parted DETACH PARTITION testpub_parted1

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_tbl5 REPLICA IDENTITY USING INDEX testpub_tbl5_b_key

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_tbl6 REPLICA IDENTITY FULL

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_tbl8 ATTACH PARTITION testpub_tbl8_0 FOR VALUES WITH (modulus 2, remainder 0)

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_tbl8 ATTACH PARTITION testpub_tbl8_1 FOR VALUES WITH (modulus 2, remainder 1)

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_tbl8_0 REPLICA IDENTITY FULL

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_tbl8_0 REPLICA IDENTITY USING INDEX testpub_tbl8_0_pkey

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_tbl8_1 REPLICA IDENTITY FULL

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_tbl8_1 REPLICA IDENTITY USING INDEX testpub_tbl8_1_pkey

-- sqlfmt-corpus-separator --

ALTER TABLE testpub_tbl_both_filters REPLICA IDENTITY USING INDEX testpub_tbl_both_filters_pkey

-- sqlfmt-corpus-separator --

ALTER TABLE toasttest ALTER COLUMN f1 SET STORAGE EXTENDED

-- sqlfmt-corpus-separator --

ALTER TABLE toasttest ALTER COLUMN f1 SET STORAGE EXTERNAL

-- sqlfmt-corpus-separator --

ALTER TABLE toasttest ALTER COLUMN f1 SET STORAGE MAIN

-- sqlfmt-corpus-separator --

ALTER TABLE toasttest ALTER COLUMN f2 SET STORAGE EXTENDED

-- sqlfmt-corpus-separator --

ALTER TABLE toasttest ALTER COLUMN f2 SET STORAGE EXTERNAL

-- sqlfmt-corpus-separator --

ALTER TABLE toasttest ALTER COLUMN f2 SET STORAGE MAIN

-- sqlfmt-corpus-separator --

ALTER TABLE trgfire ATTACH PARTITION trgfire3 FOR VALUES FROM (20) TO (30)

-- sqlfmt-corpus-separator --

ALTER TABLE trgfire ATTACH PARTITION trgfire5 FOR VALUES FROM (40) TO (50)

-- sqlfmt-corpus-separator --

ALTER TABLE trgfire DISABLE TRIGGER tg

-- sqlfmt-corpus-separator --

ALTER TABLE trgfire ENABLE TRIGGER tg

-- sqlfmt-corpus-separator --

ALTER TABLE tststats.priv_test_parent_tbl ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE tststats.priv_test_tbl ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE tststats.priv_test_tbl INHERIT tststats.priv_test_parent_tbl

-- sqlfmt-corpus-separator --

ALTER TABLE tt0 OF tt_t0

-- sqlfmt-corpus-separator --

ALTER TABLE tt1 OF tt_t0

-- sqlfmt-corpus-separator --

ALTER TABLE tt2 OF tt_t0

-- sqlfmt-corpus-separator --

ALTER TABLE tt3 OF tt_t0

-- sqlfmt-corpus-separator --

ALTER TABLE tt4 OF tt_t0

-- sqlfmt-corpus-separator --

ALTER TABLE tt5 OF tt_t0

-- sqlfmt-corpus-separator --

ALTER TABLE tt6 OF tt_t0

-- sqlfmt-corpus-separator --

ALTER TABLE tt7 NOT OF

-- sqlfmt-corpus-separator --

ALTER TABLE tt7 OF tt_t0

-- sqlfmt-corpus-separator --

ALTER TABLE tt7 OF tt_t1

-- sqlfmt-corpus-separator --

ALTER TABLE unique_tbl ADD CONSTRAINT unique_tbl_i_key
	UNIQUE (i) DEFERRABLE INITIALLY DEFERRED

-- sqlfmt-corpus-separator --

ALTER TABLE unlogged1 SET LOGGED

-- sqlfmt-corpus-separator --

ALTER TABLE unlogged1 SET UNLOGGED

-- sqlfmt-corpus-separator --

ALTER TABLE unlogged2 SET LOGGED

-- sqlfmt-corpus-separator --

ALTER TABLE unlogged3 SET LOGGED

-- sqlfmt-corpus-separator --

ALTER TABLE unparted ATTACH PARTITION fail_part FOR VALUES IN ('a')

-- sqlfmt-corpus-separator --

ALTER TABLE upsert_test ATTACH PARTITION upsert_test_2 FOR VALUES IN (2)

-- sqlfmt-corpus-separator --

ALTER TABLE vac_option_tab ALTER COLUMN t SET STORAGE EXTERNAL

-- sqlfmt-corpus-separator --

ALTER TABLE vac_rewrite_toast ALTER COLUMN f1 SET STORAGE EXTERNAL

-- sqlfmt-corpus-separator --

ALTER TABLE vaccluster CLUSTER ON vaccluster_pkey

-- sqlfmt-corpus-separator --

ALTER TABLE vtype
      ALTER b TYPE text USING b::text,
      ALTER c TYPE text USING c::text

-- sqlfmt-corpus-separator --

ALTER TABLE vtype2 ALTER COLUMN b TYPE varchar(20) USING b::varchar(20)

-- sqlfmt-corpus-separator --

ALTER TABLE x1 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE y1 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE y2 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TABLE z1 ENABLE ROW LEVEL SECURITY

-- sqlfmt-corpus-separator --

ALTER TYPE test8a ADD ATTRIBUTE c priv_testdomain1

-- sqlfmt-corpus-separator --

ALTER TYPE test8a ALTER ATTRIBUTE b TYPE priv_testdomain1

-- sqlfmt-corpus-separator --

ALTER TYPE test8b ADD ATTRIBUTE c priv_testdomain1

-- sqlfmt-corpus-separator --

ALTER TYPE test8b ALTER ATTRIBUTE b TYPE priv_testdomain1

-- sqlfmt-corpus-separator --

ALTER TYPE test_type ADD ATTRIBUTE b text

-- sqlfmt-corpus-separator --

ALTER TYPE test_type ALTER ATTRIBUTE b SET DATA TYPE varchar

-- sqlfmt-corpus-separator --

ALTER TYPE test_type DROP ATTRIBUTE IF EXISTS c

-- sqlfmt-corpus-separator --

ALTER TYPE test_type DROP ATTRIBUTE a, ADD ATTRIBUTE d boolean

-- sqlfmt-corpus-separator --

ALTER TYPE test_type1 ALTER ATTRIBUTE b TYPE varchar

-- sqlfmt-corpus-separator --

ALTER TYPE test_type2 ADD ATTRIBUTE c text CASCADE

-- sqlfmt-corpus-separator --

ALTER TYPE test_type2 ALTER ATTRIBUTE b TYPE varchar CASCADE

-- sqlfmt-corpus-separator --

ALTER TYPE test_type2 DROP ATTRIBUTE b CASCADE

-- sqlfmt-corpus-separator --

ALTER TYPE test_type3 DROP ATTRIBUTE a, ADD ATTRIBUTE b int

-- sqlfmt-corpus-separator --

ALTER TYPE test_typex DROP ATTRIBUTE a

-- sqlfmt-corpus-separator --

ALTER TYPE test_typex DROP ATTRIBUTE a CASCADE

-- sqlfmt-corpus-separator --

ALTER TYPE tt_t0 DROP ATTRIBUTE z

-- sqlfmt-corpus-separator --

ALTER VIEW gtest1v ALTER COLUMN b SET DEFAULT 100

-- sqlfmt-corpus-separator --

ALTER VIEW my_property_normal SET (security_barrier=true)

-- sqlfmt-corpus-separator --

ALTER VIEW my_property_secure SET (security_barrier=false)

-- sqlfmt-corpus-separator --

ALTER VIEW rls_view OWNER TO regress_rls_bob

-- sqlfmt-corpus-separator --

ALTER VIEW rw_view1 ALTER COLUMN bb SET DEFAULT 'View default'

-- sqlfmt-corpus-separator --

ALTER VIEW rw_view1 SET (security_barrier = true)

-- sqlfmt-corpus-separator --

ALTER VIEW rw_view1 SET (security_invoker = true)

-- sqlfmt-corpus-separator --

ALTER VIEW rw_view15 ALTER COLUMN upper SET DEFAULT 'NOT SET'

-- sqlfmt-corpus-separator --

ALTER VIEW rw_view2 RESET (check_option)

-- sqlfmt-corpus-separator --

ALTER VIEW tenant_view OWNER TO regress_role_admin

-- sqlfmt-corpus-separator --

ANALYZE

-- sqlfmt-corpus-separator --

ANALYZE (BUFFER_USAGE_LIMIT '512 kB') vac_option_tab

-- sqlfmt-corpus-separator --

ANALYZE (BUFFER_USAGE_LIMIT 0) vac_option_tab

-- sqlfmt-corpus-separator --

ANALYZE (SKIP_LOCKED) vactst

-- sqlfmt-corpus-separator --

ANALYZE (SKIP_LOCKED, VERBOSE) does_not_exist

-- sqlfmt-corpus-separator --

ANALYZE (VERBOSE) does_not_exist

-- sqlfmt-corpus-separator --

ANALYZE (VERBOSE, SKIP_LOCKED) does_not_exist

-- sqlfmt-corpus-separator --

ANALYZE (nonexistentarg) does_not_exit

-- sqlfmt-corpus-separator --

ANALYZE a_star

-- sqlfmt-corpus-separator --

ANALYZE ab1

-- sqlfmt-corpus-separator --

ANALYZE agg_sort_order

-- sqlfmt-corpus-separator --

ANALYZE aggtest

-- sqlfmt-corpus-separator --

ANALYZE alpha

-- sqlfmt-corpus-separator --

ANALYZE array_index_op_test

-- sqlfmt-corpus-separator --

ANALYZE array_op_test

-- sqlfmt-corpus-separator --

ANALYZE attmp

-- sqlfmt-corpus-separator --

ANALYZE b_star

-- sqlfmt-corpus-separator --

ANALYZE beta

-- sqlfmt-corpus-separator --

ANALYZE bitmap_split_or

-- sqlfmt-corpus-separator --

ANALYZE bool_tab

-- sqlfmt-corpus-separator --

ANALYZE bt_f8_heap

-- sqlfmt-corpus-separator --

ANALYZE bt_i4_heap

-- sqlfmt-corpus-separator --

ANALYZE bt_name_heap

-- sqlfmt-corpus-separator --

ANALYZE bt_txt_heap

-- sqlfmt-corpus-separator --

ANALYZE btg

-- sqlfmt-corpus-separator --

ANALYZE c_star

-- sqlfmt-corpus-separator --

ANALYZE check_fk_presence_2

-- sqlfmt-corpus-separator --

ANALYZE concur_exprs_tab

-- sqlfmt-corpus-separator --

ANALYZE ctv_data

-- sqlfmt-corpus-separator --

ANALYZE current_check

-- sqlfmt-corpus-separator --

ANALYZE d_star

-- sqlfmt-corpus-separator --

ANALYZE dist_tab

-- sqlfmt-corpus-separator --

ANALYZE distinct_on_tbl

-- sqlfmt-corpus-separator --

ANALYZE distinct_tbl

-- sqlfmt-corpus-separator --

ANALYZE dupindexcols

-- sqlfmt-corpus-separator --

ANALYZE e_star

-- sqlfmt-corpus-separator --

ANALYZE eager_agg_t1

-- sqlfmt-corpus-separator --

ANALYZE eager_agg_t2

-- sqlfmt-corpus-separator --

ANALYZE eager_agg_t3

-- sqlfmt-corpus-separator --

ANALYZE eager_agg_tab1

-- sqlfmt-corpus-separator --

ANALYZE eager_agg_tab2

-- sqlfmt-corpus-separator --

ANALYZE eager_agg_tab_ml

-- sqlfmt-corpus-separator --

ANALYZE expr_stats

-- sqlfmt-corpus-separator --

ANALYZE expr_stats_incompatible_test

-- sqlfmt-corpus-separator --

ANALYZE f_star

-- sqlfmt-corpus-separator --

ANALYZE fast_emp4000

-- sqlfmt-corpus-separator --

ANALYZE flt

-- sqlfmt-corpus-separator --

ANALYZE fract_t

-- sqlfmt-corpus-separator --

ANALYZE functional_dependencies

-- sqlfmt-corpus-separator --

ANALYZE functional_dependencies_multi

-- sqlfmt-corpus-separator --

ANALYZE group_agg_pk

-- sqlfmt-corpus-separator --

ANALYZE group_tbl

-- sqlfmt-corpus-separator --

ANALYZE grouping_unique

-- sqlfmt-corpus-separator --

ANALYZE gtest22c

-- sqlfmt-corpus-separator --

ANALYZE hash_f8_heap

-- sqlfmt-corpus-separator --

ANALYZE hash_i4_heap

-- sqlfmt-corpus-separator --

ANALYZE hash_name_heap

-- sqlfmt-corpus-separator --

ANALYZE hash_txt_heap

-- sqlfmt-corpus-separator --

ANALYZE maintain_test

-- sqlfmt-corpus-separator --

ANALYZE mcv_lists

-- sqlfmt-corpus-separator --

ANALYZE mcv_lists_arrays

-- sqlfmt-corpus-separator --

ANALYZE mcv_lists_bool

-- sqlfmt-corpus-separator --

ANALYZE mcv_lists_multi

-- sqlfmt-corpus-separator --

ANALYZE mcv_lists_partial

-- sqlfmt-corpus-separator --

ANALYZE mcv_lists_uuid

-- sqlfmt-corpus-separator --

ANALYZE ndistinct

-- sqlfmt-corpus-separator --

ANALYZE onek2

-- sqlfmt-corpus-separator --

ANALYZE only_inh_parent

-- sqlfmt-corpus-separator --

ANALYZE only_parted

-- sqlfmt-corpus-separator --

ANALYZE pagg_tab

-- sqlfmt-corpus-separator --

ANALYZE pagg_tab1

-- sqlfmt-corpus-separator --

ANALYZE pagg_tab2

-- sqlfmt-corpus-separator --

ANALYZE pagg_tab3

-- sqlfmt-corpus-separator --

ANALYZE pagg_tab4

-- sqlfmt-corpus-separator --

ANALYZE pagg_tab5

-- sqlfmt-corpus-separator --

ANALYZE pagg_tab6

-- sqlfmt-corpus-separator --

ANALYZE pagg_tab_m

-- sqlfmt-corpus-separator --

ANALYZE pagg_tab_ml

-- sqlfmt-corpus-separator --

ANALYZE pagg_tab_para

-- sqlfmt-corpus-separator --

ANALYZE past_inh_db_parent

-- sqlfmt-corpus-separator --

ANALYZE past_inh_parent

-- sqlfmt-corpus-separator --

ANALYZE past_parted

-- sqlfmt-corpus-separator --

ANALYZE pg_catalog.pg_authid

-- sqlfmt-corpus-separator --

ANALYZE pg_catalog.pg_class

-- sqlfmt-corpus-separator --

ANALYZE pht1

-- sqlfmt-corpus-separator --

ANALYZE pht1_e

-- sqlfmt-corpus-separator --

ANALYZE pht2

-- sqlfmt-corpus-separator --

ANALYZE plt1

-- sqlfmt-corpus-separator --

ANALYZE plt1_adv

-- sqlfmt-corpus-separator --

ANALYZE plt1_e

-- sqlfmt-corpus-separator --

ANALYZE plt2

-- sqlfmt-corpus-separator --

ANALYZE plt2_adv

-- sqlfmt-corpus-separator --

ANALYZE plt3_adv

-- sqlfmt-corpus-separator --

ANALYZE pred_tab

-- sqlfmt-corpus-separator --

ANALYZE pred_tab_notnull

-- sqlfmt-corpus-separator --

ANALYZE prt

-- sqlfmt-corpus-separator --

ANALYZE prt1

-- sqlfmt-corpus-separator --

ANALYZE prt1_adv

-- sqlfmt-corpus-separator --

ANALYZE prt1_e

-- sqlfmt-corpus-separator --

ANALYZE prt1_l

-- sqlfmt-corpus-separator --

ANALYZE prt1_m

-- sqlfmt-corpus-separator --

ANALYZE prt1_n

-- sqlfmt-corpus-separator --

ANALYZE prt2

-- sqlfmt-corpus-separator --

ANALYZE prt2_adv

-- sqlfmt-corpus-separator --

ANALYZE prt2_e

-- sqlfmt-corpus-separator --

ANALYZE prt2_l

-- sqlfmt-corpus-separator --

ANALYZE prt2_m

-- sqlfmt-corpus-separator --

ANALYZE prt2_n

-- sqlfmt-corpus-separator --

ANALYZE prt3_adv

-- sqlfmt-corpus-separator --

ANALYZE prt3_n

-- sqlfmt-corpus-separator --

ANALYZE prt4_n

-- sqlfmt-corpus-separator --

ANALYZE real_city

-- sqlfmt-corpus-separator --

ANALYZE rls_child_tbl

-- sqlfmt-corpus-separator --

ANALYZE rls_ptbl, rls_part

-- sqlfmt-corpus-separator --

ANALYZE rls_tbl

-- sqlfmt-corpus-separator --

ANALYZE sb_1, sb_2

-- sqlfmt-corpus-separator --

ANALYZE sb_2

-- sqlfmt-corpus-separator --

ANALYZE slow_emp4000

-- sqlfmt-corpus-separator --

ANALYZE stats_ext_tbl

-- sqlfmt-corpus-separator --

ANALYZE stats_ext_tbl_range

-- sqlfmt-corpus-separator --

ANALYZE stats_import.part_parent

-- sqlfmt-corpus-separator --

ANALYZE stats_import.test

-- sqlfmt-corpus-separator --

ANALYZE stats_import.test_range_expr_null

-- sqlfmt-corpus-separator --

ANALYZE strtest

-- sqlfmt-corpus-separator --

ANALYZE t1

-- sqlfmt-corpus-separator --

ANALYZE t11

-- sqlfmt-corpus-separator --

ANALYZE t111

-- sqlfmt-corpus-separator --

ANALYZE t12

-- sqlfmt-corpus-separator --

ANALYZE tab_anti

-- sqlfmt-corpus-separator --

ANALYZE target

-- sqlfmt-corpus-separator --

ANALYZE test_maint_search_path.test_maint

-- sqlfmt-corpus-separator --

ANALYZE test_tsvector

-- sqlfmt-corpus-separator --

ANALYZE transition_table_level1

-- sqlfmt-corpus-separator --

ANALYZE transition_table_level2

-- sqlfmt-corpus-separator --

ANALYZE transition_table_status

-- sqlfmt-corpus-separator --

ANALYZE tststats.priv_test_tbl

-- sqlfmt-corpus-separator --

ANALYZE vaccluster

-- sqlfmt-corpus-separator --

ANALYZE vacowned

-- sqlfmt-corpus-separator --

ANALYZE vacowned_part1

-- sqlfmt-corpus-separator --

ANALYZE vacowned_part2

-- sqlfmt-corpus-separator --

ANALYZE vacowned_parted

-- sqlfmt-corpus-separator --

ANALYZE vacparted (b), vactst

-- sqlfmt-corpus-separator --

ANALYZE vacparted(a,b,b)

-- sqlfmt-corpus-separator --

ANALYZE vactst

-- sqlfmt-corpus-separator --

ANALYZE vactst (i), vacparted (does_not_exist)

-- sqlfmt-corpus-separator --

ANALYZE vactst, does_not_exist, vacparted

-- sqlfmt-corpus-separator --

ANALYZE vactst, vacparted

-- sqlfmt-corpus-separator --

ANALYZE vactst, vactst

-- sqlfmt-corpus-separator --

ANALYZE virtual_gen_stats

-- sqlfmt-corpus-separator --

BEGIN ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION DEFERRABLE

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

BEGIN TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

CALL ptest1($1)

-- sqlfmt-corpus-separator --

CALL ptest10(a => null, b => 8, c => 2)

-- sqlfmt-corpus-separator --

CALL ptest10(b => 8, c => 2, a => 0)

-- sqlfmt-corpus-separator --

CALL ptest10(null, 7, c => 2)

-- sqlfmt-corpus-separator --

CALL ptest10(null, c => 4, b => 11)

-- sqlfmt-corpus-separator --

CALL ptest5(10, b => 'Hello')

-- sqlfmt-corpus-separator --

CALL ptest5(b => 'Hello', a => 10)

-- sqlfmt-corpus-separator --

CALL ptest7(least('a', 'b'), 'a')

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT comment_test_child_fk ON comment_test_child IS 'FOREIGN KEY constraint of comment_test_child'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT comment_test_pk ON comment_test IS 'PRIMARY KEY constraint of comment_test'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT comment_test_positive_col_check ON comment_test IS 'CHECK constraint on comment_test.positive_col'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT constr_parent2_a_not_null ON constr_child2 IS 'this constraint is valid'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT constr_parent2_a_not_null ON constr_parent2 IS 'this constraint is invalid'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT constrname ON FKTABLE IS 'fk constraint comment'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT constrname ON FKTABLE IS NULL

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT constrname_wrong ON FKTABLE IS 'fk constraint comment'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT ctlt1_a_check ON ctlt1 IS 't1_a_check'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT ctlt2_c_not_null ON ctlt2 IS 't2_c_not_null'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT ctlt3_a_check ON ctlt3 IS 't3_a_check'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT id_notnull_constraint ON comment_test IS 'NOT NULL constraint of comment_test'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT inv_ck ON DOMAIN constraint_comments_dom IS 'comment on invalid constraint'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT no_constraint ON DOMAIN constraint_comments_dom IS 'yes, another comment'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT no_constraint ON constraint_comments_tbl IS 'yes, the comment'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT noinh_con_copy_b_not_null ON noinh_con_copy IS 'not null b'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT noinh_con_copy_c_not_null ON noinh_con_copy IS 'not null c no inherit'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT the_constraint ON DOMAIN constraint_comments_dom IS 'no, another comment'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT the_constraint ON DOMAIN constraint_comments_dom IS 'yes, another comment'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT the_constraint ON DOMAIN constraint_comments_dom IS NULL

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT the_constraint ON DOMAIN no_comments_dom IS 'another bad comment'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT the_constraint ON constraint_comments_tbl IS 'no, the comment'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT the_constraint ON constraint_comments_tbl IS 'yes, the comment'

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT the_constraint ON constraint_comments_tbl IS NULL

-- sqlfmt-corpus-separator --

COMMENT ON CONSTRAINT the_constraint ON no_comments_tbl IS 'bad comment'

-- sqlfmt-corpus-separator --

COMMENT ON INDEX six IS ''

-- sqlfmt-corpus-separator --

COMMENT ON ROLE regress_hasprivs IS ''

-- sqlfmt-corpus-separator --

COMMENT ON VIEW noview IS 'no view'

-- sqlfmt-corpus-separator --

COMMENT ON VIEW toyemp IS 'is a view'

-- sqlfmt-corpus-separator --

COMMENT ON VIEW toyemp IS NULL

-- sqlfmt-corpus-separator --

COMMIT AND CHAIN

-- sqlfmt-corpus-separator --

COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NOT_NULL *)

-- sqlfmt-corpus-separator --

COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NOT_NULL *, FORCE_NOT_NULL(b))

-- sqlfmt-corpus-separator --

COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NOT_NULL *, FORCE_NULL *)

-- sqlfmt-corpus-separator --

COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NOT_NULL(b), FORCE_NULL(c))

-- sqlfmt-corpus-separator --

COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NULL *)

-- sqlfmt-corpus-separator --

COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NULL *, FORCE_NULL(b))

-- sqlfmt-corpus-separator --

COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NULL(b), FORCE_NOT_NULL(c))

-- sqlfmt-corpus-separator --

COPY forcetest (a, b, c, d) FROM STDIN WITH (FORMAT csv, FORCE_NOT_NULL(c,d), FORCE_NULL(c,d))

-- sqlfmt-corpus-separator --

COPY forcetest (d, e) FROM STDIN WITH (FORMAT csv, FORCE_NOT_NULL(b))

-- sqlfmt-corpus-separator --

COPY forcetest (d, e) FROM STDIN WITH (FORMAT csv, FORCE_NULL(b))

-- sqlfmt-corpus-separator --

COPY gtest1 FROM stdin WHERE b <> 10

-- sqlfmt-corpus-separator --

COPY gtest1 FROM stdin WHERE gtest1 IS NULL

-- sqlfmt-corpus-separator --

COPY vistest FROM stdin CSV FREEZE

-- sqlfmt-corpus-separator --

COPY x from stdin (convert_selectively (a), convert_selectively (b))

-- sqlfmt-corpus-separator --

COPY x from stdin (force_not_null (a), force_not_null (b))

-- sqlfmt-corpus-separator --

COPY x from stdin (force_null (a), force_null (b))

-- sqlfmt-corpus-separator --

COPY x from stdin (force_quote (a), force_quote *)

-- sqlfmt-corpus-separator --

COPY x from stdin (format CSV, force_quote *)

-- sqlfmt-corpus-separator --

COPY x from stdin (format CSV, force_quote(a))

-- sqlfmt-corpus-separator --

COPY x from stdin (format TEXT, force_not_null *)

-- sqlfmt-corpus-separator --

COPY x from stdin (format TEXT, force_not_null(a))

-- sqlfmt-corpus-separator --

COPY x from stdin (format TEXT, force_null *)

-- sqlfmt-corpus-separator --

COPY x from stdin (format TEXT, force_null(a))

-- sqlfmt-corpus-separator --

COPY x from stdin (format TEXT, force_quote *)

-- sqlfmt-corpus-separator --

COPY x from stdin (format TEXT, force_quote(a))

-- sqlfmt-corpus-separator --

COPY x from stdin (null ' ', null ' ')

-- sqlfmt-corpus-separator --

COPY x from stdin (on_error set_null, reject_limit 2)

-- sqlfmt-corpus-separator --

COPY x from stdin WHERE a = 50004

-- sqlfmt-corpus-separator --

COPY x from stdin WHERE a = max(x.b)

-- sqlfmt-corpus-separator --

COPY x from stdin WHERE a = row_number() over(b)

-- sqlfmt-corpus-separator --

COPY x from stdin WHERE a IN (SELECT 1 FROM x)

-- sqlfmt-corpus-separator --

COPY x from stdin WHERE a IN (generate_series(1,5))

-- sqlfmt-corpus-separator --

COPY x from stdin WHERE tableoid = 'x'::regclass

-- sqlfmt-corpus-separator --

COPY x from stdin with (header '2.5')

-- sqlfmt-corpus-separator --

COPY x from stdin with (header -1)

-- sqlfmt-corpus-separator --

COPY x from stdin with (header 2.5)

-- sqlfmt-corpus-separator --

COPY x from stdin with (on_error ignore, reject_limit 0)

-- sqlfmt-corpus-separator --

COPY x from stdin with (reject_limit 1)

-- sqlfmt-corpus-separator --

COPY x to stdout (format CSV, force_not_null *)

-- sqlfmt-corpus-separator --

COPY x to stdout (format CSV, force_not_null(a))

-- sqlfmt-corpus-separator --

COPY x to stdout (format CSV, force_null *)

-- sqlfmt-corpus-separator --

COPY x to stdout (format CSV, force_null(a))

-- sqlfmt-corpus-separator --

COPY x to stdout with (header '-1')

-- sqlfmt-corpus-separator --

COPY x to stdout with (header '2')

-- sqlfmt-corpus-separator --

COPY x to stdout with (header 2)

-- sqlfmt-corpus-separator --

COPY y TO stdout (FORMAT CSV, FORCE_QUOTE *)

-- sqlfmt-corpus-separator --

COPY y TO stdout WITH CSV FORCE QUOTE *

-- sqlfmt-corpus-separator --

CREATE INDEX CONCURRENTLY jidx ON testjsonb USING gin (j jsonb_path_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX CONCURRENTLY on concur_heap((f2||f1))

-- sqlfmt-corpus-separator --

CREATE INDEX CONCURRENTLY tbl_gist_idx ON tbl_gist using gist (c4) INCLUDE (c1,c2,c3)

-- sqlfmt-corpus-separator --

CREATE INDEX IF NOT EXISTS onek_unique1 ON onek USING btree(unique1 int4_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX ON INTERVAL_TBL_OF USING btree (f1)

-- sqlfmt-corpus-separator --

CREATE INDEX ON OID8_TBL USING hash(f1)

-- sqlfmt-corpus-separator --

CREATE INDEX ON atest12 (a)

-- sqlfmt-corpus-separator --

CREATE INDEX ON atest12 (abs(a))

-- sqlfmt-corpus-separator --

CREATE INDEX ON brin_date_test USING brin (a date_minmax_multi_ops) WITH (pages_per_range=1)

-- sqlfmt-corpus-separator --

CREATE INDEX ON brin_hot_2 USING brin (b) WHERE a = 2

-- sqlfmt-corpus-separator --

CREATE INDEX ON brin_hot_3 USING brin (a) WITH (pages_per_range = 1)

-- sqlfmt-corpus-separator --

CREATE INDEX ON brin_interval_test USING brin (a interval_minmax_multi_ops) WITH (pages_per_range=1)

-- sqlfmt-corpus-separator --

CREATE INDEX ON brin_test_inet USING brin (a inet_minmax_multi_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX ON brin_timestamp_test USING brin (a timestamp_minmax_multi_ops) WITH (pages_per_range=1)

-- sqlfmt-corpus-separator --

CREATE INDEX ON brin_timestamp_test USING brin (a timestamptz_minmax_multi_ops) WITH (pages_per_range=1)

-- sqlfmt-corpus-separator --

CREATE INDEX ON idxpart (col1)

-- sqlfmt-corpus-separator --

CREATE INDEX ON lt1 (a)

-- sqlfmt-corpus-separator --

CREATE INDEX ON maintain_test (a)

-- sqlfmt-corpus-separator --

CREATE INDEX ON matview(col1)

-- sqlfmt-corpus-separator --

CREATE INDEX ON past_inh_db_parent ((1))

-- sqlfmt-corpus-separator --

CREATE INDEX ON pvactst2 (i)

-- sqlfmt-corpus-separator --

CREATE INDEX ON quad_point_tbl_ord_seq1 USING spgist(p) INCLUDE(dist)

-- sqlfmt-corpus-separator --

CREATE INDEX ON rescan_bhs (a)

-- sqlfmt-corpus-separator --

CREATE INDEX ON skip_fetch(a)

-- sqlfmt-corpus-separator --

CREATE INDEX ON syscol_table ((ctid >= '(1000,0)'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON syscol_table (a) WHERE ctid >= '(1000,0)'

-- sqlfmt-corpus-separator --

CREATE INDEX ON syscol_table (ctid)

-- sqlfmt-corpus-separator --

CREATE INDEX ON t (run_me(i))

-- sqlfmt-corpus-separator --

CREATE INDEX ON t(a)

-- sqlfmt-corpus-separator --

CREATE INDEX ON table2(col2)

-- sqlfmt-corpus-separator --

CREATE INDEX ON tbl_include_reg (c1, c2) INCLUDE (c1, c3)

-- sqlfmt-corpus-separator --

CREATE INDEX ON temptest(bit_length(''))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test3bpci (x bpchar_pattern_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX ON test3ci (x text_pattern_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX ON test4c (x)

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@ < $.datetime())'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.date() < $.datetime("HH:MI TZH"))'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.date() < $.time())'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.date() < $.time_tz())'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.datetime("HH:MI TZH") < $.datetime("HH:MI TZH"))'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.datetime("HH:MI TZH") < $.datetime("YY-MM-DD HH:MI"))'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.datetime("HH:MI") < $.datetime("YY-MM-DD HH:MI"))'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.datetime() < $.datetime("HH:MI TZH"))'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.datetime() < $.datetime())'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.time() < $.datetime("HH:MI TZH"))'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.time() < $.time())'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.time() < $.time_tz())'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.timestamp() < $.datetime("HH:MI TZH"))'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.timestamp() < $.datetime("HH:MI"))'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.timestamp() < $.timestamp_tz())'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.timestamp(2) < $.timestamp(3))'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.timestamp_tz() < $.datetime("HH:MI TZH"))'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.timestamp_tz() < $.datetime("HH:MI"))'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a ? (@.timestamp_tz() < $.timestamp_tz())'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.a[0]'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.btrim()'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.date()'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.datetime()'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.initcap()'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.lower()'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.ltrim()'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.replace("hello", "bye")'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.rtrim()'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.split_part(",", 2)'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.time()'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.time_tz()'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.timestamp()'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.timestamp_tz()'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON test_jsonb_mutability (JSON_QUERY(js, '$.upper()'))

-- sqlfmt-corpus-separator --

CREATE INDEX ON vaccluster(wrap_do_analyze(i))

-- sqlfmt-corpus-separator --

CREATE INDEX brin_large_range_idx ON brin_large_range USING brin (a int4_minmax_multi_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX brin_summarize_bloom_idx ON brin_summarize_bloom USING brin (value) WITH (pages_per_range=2)

-- sqlfmt-corpus-separator --

CREATE INDEX brin_summarize_idx ON brin_summarize USING brin (value) WITH (pages_per_range=2)

-- sqlfmt-corpus-separator --

CREATE INDEX brin_summarize_multi_idx ON brin_summarize_multi USING brin (value) WITH (pages_per_range=2)

-- sqlfmt-corpus-separator --

CREATE INDEX brin_test_a_idx ON brin_test USING brin (a) WITH (pages_per_range = 2)

-- sqlfmt-corpus-separator --

CREATE INDEX brin_test_b_idx ON brin_test USING brin (b) WITH (pages_per_range = 2)

-- sqlfmt-corpus-separator --

CREATE INDEX brin_test_bloom_a_idx ON brin_test_bloom USING brin (a) WITH (pages_per_range = 2)

-- sqlfmt-corpus-separator --

CREATE INDEX brin_test_bloom_b_idx ON brin_test_bloom USING brin (b) WITH (pages_per_range = 2)

-- sqlfmt-corpus-separator --

CREATE INDEX brin_test_multi_1_idx_1 ON brin_test_multi_1 USING brin (a int4_minmax_multi_ops) WITH (pages_per_range=5)

-- sqlfmt-corpus-separator --

CREATE INDEX brin_test_multi_1_idx_2 ON brin_test_multi_1 USING brin (b int8_minmax_multi_ops) WITH (pages_per_range=5)

-- sqlfmt-corpus-separator --

CREATE INDEX brin_test_multi_2_idx ON brin_test_multi_2 USING brin (a uuid_minmax_multi_ops) WITH (pages_per_range=5)

-- sqlfmt-corpus-separator --

CREATE INDEX brin_test_multi_a_idx ON brin_test_multi USING brin (a) WITH (pages_per_range = 2)

-- sqlfmt-corpus-separator --

CREATE INDEX brin_test_multi_b_idx ON brin_test_multi USING brin (b) WITH (pages_per_range = 2)

-- sqlfmt-corpus-separator --

CREATE INDEX brinidx ON brintest USING brin (
	byteacol,
	charcol,
	namecol,
	int8col,
	int2col,
	int4col,
	textcol,
	oidcol,
	tidcol,
	float4col,
	float8col,
	macaddrcol,
	inetcol inet_inclusion_ops,
	inetcol inet_minmax_ops,
	cidrcol inet_inclusion_ops,
	cidrcol inet_minmax_ops,
	bpcharcol,
	datecol,
	timecol,
	timestampcol,
	timestamptzcol,
	intervalcol,
	timetzcol,
	bitcol,
	varbitcol,
	numericcol,
	uuidcol,
	int4rangecol,
	lsncol,
	boxcol
) with (pages_per_range = 1)

-- sqlfmt-corpus-separator --

CREATE INDEX brinidx_bloom ON brintest_bloom USING brin (
	byteacol bytea_bloom_ops(false_positive_rate = 0.00009)
)

-- sqlfmt-corpus-separator --

CREATE INDEX brinidx_bloom ON brintest_bloom USING brin (
	byteacol bytea_bloom_ops(false_positive_rate = 0.26)
)

-- sqlfmt-corpus-separator --

CREATE INDEX brinidx_bloom ON brintest_bloom USING brin (
	byteacol bytea_bloom_ops(n_distinct_per_range = -1.1)
)

-- sqlfmt-corpus-separator --

CREATE INDEX brinidx_bloom ON brintest_bloom USING brin (
	byteacol bytea_bloom_ops,
	charcol char_bloom_ops,
	namecol name_bloom_ops,
	int8col int8_bloom_ops,
	int2col int2_bloom_ops,
	int4col int4_bloom_ops,
	textcol text_bloom_ops,
	oidcol oid_bloom_ops,
	float4col float4_bloom_ops,
	float8col float8_bloom_ops,
	macaddrcol macaddr_bloom_ops,
	inetcol inet_bloom_ops,
	cidrcol inet_bloom_ops,
	bpcharcol bpchar_bloom_ops,
	datecol date_bloom_ops,
	timecol time_bloom_ops,
	timestampcol timestamp_bloom_ops,
	timestamptzcol timestamptz_bloom_ops,
	intervalcol interval_bloom_ops,
	timetzcol timetz_bloom_ops,
	numericcol numeric_bloom_ops,
	uuidcol uuid_bloom_ops,
	lsncol pg_lsn_bloom_ops
) with (pages_per_range = 1)

-- sqlfmt-corpus-separator --

CREATE INDEX brinidx_multi ON brintest_multi USING brin (
	int8col int8_minmax_multi_ops(values_per_range = 257)
)

-- sqlfmt-corpus-separator --

CREATE INDEX brinidx_multi ON brintest_multi USING brin (
	int8col int8_minmax_multi_ops(values_per_range = 7)
)

-- sqlfmt-corpus-separator --

CREATE INDEX brinidx_multi ON brintest_multi USING brin (
	int8col int8_minmax_multi_ops,
	int2col int2_minmax_multi_ops,
	int4col int4_minmax_multi_ops,
	oidcol oid_minmax_multi_ops,
	tidcol tid_minmax_multi_ops,
	float4col float4_minmax_multi_ops,
	float8col float8_minmax_multi_ops,
	macaddrcol macaddr_minmax_multi_ops,
	macaddr8col macaddr8_minmax_multi_ops,
	inetcol inet_minmax_multi_ops,
	cidrcol inet_minmax_multi_ops,
	datecol date_minmax_multi_ops,
	timecol time_minmax_multi_ops,
	timestampcol timestamp_minmax_multi_ops,
	timestamptzcol timestamptz_minmax_multi_ops,
	intervalcol interval_minmax_multi_ops,
	timetzcol timetz_minmax_multi_ops,
	numericcol numeric_minmax_multi_ops,
	uuidcol uuid_minmax_multi_ops,
	lsncol pg_lsn_minmax_multi_ops
)

-- sqlfmt-corpus-separator --

CREATE INDEX brinidx_multi ON brintest_multi USING brin (
	int8col int8_minmax_multi_ops,
	int2col int2_minmax_multi_ops,
	int4col int4_minmax_multi_ops,
	oidcol oid_minmax_multi_ops,
	tidcol tid_minmax_multi_ops,
	float4col float4_minmax_multi_ops,
	float8col float8_minmax_multi_ops,
	macaddrcol macaddr_minmax_multi_ops,
	macaddr8col macaddr8_minmax_multi_ops,
	inetcol inet_minmax_multi_ops,
	cidrcol inet_minmax_multi_ops,
	datecol date_minmax_multi_ops,
	timecol time_minmax_multi_ops,
	timestampcol timestamp_minmax_multi_ops,
	timestamptzcol timestamptz_minmax_multi_ops,
	intervalcol interval_minmax_multi_ops,
	timetzcol timetz_minmax_multi_ops,
	numericcol numeric_minmax_multi_ops,
	uuidcol uuid_minmax_multi_ops,
	lsncol pg_lsn_minmax_multi_ops
) with (pages_per_range = 1)

-- sqlfmt-corpus-separator --

CREATE INDEX bt_f8_index ON bt_f8_heap USING btree (seqno float8_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX bt_i4_index ON bt_i4_heap USING btree (seqno int4_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX bt_name_index ON bt_name_heap USING btree (seqno name_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX bt_txt_index ON bt_txt_heap USING btree (seqno text_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX collate_dep_test4i ON collate_dep_test4t (b COLLATE test0)

-- sqlfmt-corpus-separator --

CREATE INDEX collate_test1_idx2 ON collate_test1 (b COLLATE "C")

-- sqlfmt-corpus-separator --

CREATE INDEX collate_test1_idx2 ON collate_test1 (b COLLATE "POSIX")

-- sqlfmt-corpus-separator --

CREATE INDEX collate_test1_idx3 ON collate_test1 ((b COLLATE "C"))

-- sqlfmt-corpus-separator --

CREATE INDEX collate_test1_idx3 ON collate_test1 ((b COLLATE "POSIX"))

-- sqlfmt-corpus-separator --

CREATE INDEX collate_test1_idx4 ON collate_test1 (((b||'foo') COLLATE "POSIX"))

-- sqlfmt-corpus-separator --

CREATE INDEX collate_test1_idx5 ON collate_test1 (a COLLATE "C")

-- sqlfmt-corpus-separator --

CREATE INDEX collate_test1_idx5 ON collate_test1 (a COLLATE "POSIX")

-- sqlfmt-corpus-separator --

CREATE INDEX collate_test1_idx6 ON collate_test1 ((a COLLATE "C"))

-- sqlfmt-corpus-separator --

CREATE INDEX collate_test1_idx6 ON collate_test1 ((a COLLATE "POSIX"))

-- sqlfmt-corpus-separator --

CREATE INDEX concur_appclass_ind on concur_appclass_tab
  USING gist (i tsvector_ops (siglen='1000'), j tsvector_ops (siglen='500'))

-- sqlfmt-corpus-separator --

CREATE INDEX concur_appclass_ind_2 on concur_appclass_tab
  USING gist (k tsvector_ops (siglen='300'), j tsvector_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX dupindexcols_i ON dupindexcols (f1, id, f1 text_pattern_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX foo_idx on testschema.foo(i) TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

CREATE INDEX foocover ON foo (f1) INCLUDE (f2,f3)

-- sqlfmt-corpus-separator --

CREATE INDEX gin_relopts_test ON array_index_op_test USING gin (i)
  WITH (FASTUPDATE=on, GIN_PENDING_LIST_LIMIT=128)

-- sqlfmt-corpus-separator --

CREATE INDEX gtest31_2_y_idx ON gtest31_2(((y).b))

-- sqlfmt-corpus-separator --

CREATE INDEX hash_f8_index ON hash_f8_heap USING hash (random float8_ops)
  WITH (fillfactor=60)

-- sqlfmt-corpus-separator --

CREATE INDEX hash_f8_index2 ON hash_f8_heap USING hash (random float8_ops)
	WITH (fillfactor=101)

-- sqlfmt-corpus-separator --

CREATE INDEX hash_f8_index2 ON hash_f8_heap USING hash (random float8_ops)
	WITH (fillfactor=9)

-- sqlfmt-corpus-separator --

CREATE INDEX hash_i4_index ON hash_i4_heap USING hash (random int4_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX hash_name_index ON hash_name_heap USING hash (random name_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX hash_tuplesort_idx ON tenk1 USING hash (stringu1 name_ops) WITH (fillfactor = 10)

-- sqlfmt-corpus-separator --

CREATE INDEX hash_txt_index ON hash_txt_heap USING hash (random text_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX iix ON ihighway USING btree (name text_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX inet_idx2 ON inet_tbl using gist (i inet_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX is_odd ON stats_import.test(((comp).a % 2 = 1))

-- sqlfmt-corpus-separator --

CREATE INDEX is_odd_clone ON stats_import.test_clone(((comp).a % 2 = 1))

-- sqlfmt-corpus-separator --

CREATE INDEX k ON testschema.tablespace_acl (c) TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

CREATE INDEX nametbl_c1_c2_idx ON nametbl (c2, c1) INCLUDE (c3)

-- sqlfmt-corpus-separator --

CREATE INDEX on OID8_TBL USING btree(f1)

-- sqlfmt-corpus-separator --

CREATE INDEX on tbl USING brin(c1, c2) INCLUDE (c3, c4)

-- sqlfmt-corpus-separator --

CREATE INDEX on tbl USING btree(c1, c2) INCLUDE (c3, c4)

-- sqlfmt-corpus-separator --

CREATE INDEX on tbl USING gin(c1, c2) INCLUDE (c3, c4)

-- sqlfmt-corpus-separator --

CREATE INDEX on tbl USING gist(c3) INCLUDE (c1, c4)

-- sqlfmt-corpus-separator --

CREATE INDEX on tbl USING hash(c1, c2) INCLUDE (c3, c4)

-- sqlfmt-corpus-separator --

CREATE INDEX on tbl USING rtree(c3) INCLUDE (c1, c4)

-- sqlfmt-corpus-separator --

CREATE INDEX on tbl USING spgist(c3) INCLUDE (c4)

-- sqlfmt-corpus-separator --

CREATE INDEX onek2_stu1_prtl ON onek2 USING btree(stringu1 name_ops)
	where onek2.stringu1 >= 'J' and onek2.stringu1 < 'K'

-- sqlfmt-corpus-separator --

CREATE INDEX onek2_u1_prtl ON onek2 USING btree(unique1 int4_ops)
	where unique1 < 20 or unique1 > 980

-- sqlfmt-corpus-separator --

CREATE INDEX onek2_u2_prtl ON onek2 USING btree(unique2 int4_ops)
	where stringu1 < 'B'

-- sqlfmt-corpus-separator --

CREATE INDEX onek_hundred ON onek USING btree(hundred int4_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX onek_stringu1 ON onek USING btree(stringu1 name_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX onek_unique2 ON onek USING btree(unique2 int4_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX part_a_idx ON testschema.part (a) TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

CREATE INDEX qq ON test_tsquery USING gist (keyword tsquery_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX reloptions_test_idx ON reloptions_test (s)
	WITH (not_existing_ns.fillfactor=2)

-- sqlfmt-corpus-separator --

CREATE INDEX reloptions_test_idx ON reloptions_test (s)
	WITH (not_existing_option=2)

-- sqlfmt-corpus-separator --

CREATE INDEX reloptions_test_idx ON reloptions_test (s) WITH (fillfactor=30)

-- sqlfmt-corpus-separator --

CREATE INDEX reloptions_test_idx2 ON reloptions_test (s) WITH (fillfactor=1)

-- sqlfmt-corpus-separator --

CREATE INDEX reloptions_test_idx2 ON reloptions_test (s) WITH (fillfactor=130)

-- sqlfmt-corpus-separator --

CREATE INDEX rix ON road USING btree (name text_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX six ON shighway USING btree (name text_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX sp_kd_ind ON kd_point_tbl USING spgist (p kd_point_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX tbl_gist_idx ON tbl_gist using gist (c4) INCLUDE (c1,c2,c3)

-- sqlfmt-corpus-separator --

CREATE INDEX tbl_gist_idx ON tbl_gist using gist (c4) INCLUDE (c1,c3)

-- sqlfmt-corpus-separator --

CREATE INDEX tbl_include_reg_idx ON tbl_include_reg (c1, c2) INCLUDE (c3, c4)

-- sqlfmt-corpus-separator --

CREATE INDEX tenk1_hundred ON tenk1 USING btree(hundred int4_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX tenk1_unique1 ON tenk1 USING btree(unique1 int4_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX tenk1_unique2 ON tenk1 USING btree(unique2 int4_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX tenk2_hundred ON tenk2 USING btree(hundred int4_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX tenk2_unique1 ON tenk2 USING btree(unique1 int4_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX tenk2_unique2 ON tenk2 USING btree(unique2 int4_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX test_index2 on testschema.test_default_tab (id) TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

CREATE INDEX test_index2 on testschema.test_default_tab_p (val) TABLESPACE regress_tblspace

-- sqlfmt-corpus-separator --

CREATE INDEX unlogged_hash_index ON unlogged_hash_table USING hash (id int4_ops)

-- sqlfmt-corpus-separator --

CREATE INDEX wowidx ON test_tsvector USING gist (a tsvector_ops(siglen=484))

-- sqlfmt-corpus-separator --

CREATE INDEX wowidx1 ON test_tsvector USING gist (a tsvector_ops(foo=1))

-- sqlfmt-corpus-separator --

CREATE INDEX wowidx1 ON test_tsvector USING gist (a tsvector_ops(siglen=0))

-- sqlfmt-corpus-separator --

CREATE INDEX wowidx1 ON test_tsvector USING gist (a tsvector_ops(siglen=100, siglen = 200))

-- sqlfmt-corpus-separator --

CREATE INDEX wowidx1 ON test_tsvector USING gist (a tsvector_ops(siglen=100,foo='bar'))

-- sqlfmt-corpus-separator --

CREATE INDEX wowidx1 ON test_tsvector USING gist (a tsvector_ops(siglen=2048))

-- sqlfmt-corpus-separator --

CREATE INDEX wowidx2 ON test_tsvector USING gist (a tsvector_ops(siglen=1))

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW heapmv USING heap AS SELECT * FROM heaptable

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW heapmv USING heap AS SELECT 1 AS a

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mat_view_heap_psql USING heap_psql AS SELECT f1 from tbl_heap_psql

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW mvtest_mv2 AS SELECT * FROM mvtest_mv1
  WHERE col1 = (SELECT LEAST(col1) FROM mvtest_mv1) WITH NO DATA

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW tableam_tblmv_heap2 USING heap2 AS SELECT * FROM tableam_tbl_heap2

-- sqlfmt-corpus-separator --

CREATE MATERIALIZED VIEW tableam_tblmv_heapx USING heap2 AS SELECT * FROM tableam_tbl_heapx

-- sqlfmt-corpus-separator --

CREATE OR REPLACE VIEW mysecview3 WITH (security_barrier=true)
       AS SELECT * FROM tbl1 WHERE a < 256

-- sqlfmt-corpus-separator --

CREATE OR REPLACE VIEW mysecview4 WITH (security_barrier=false)
       AS SELECT * FROM tbl1 WHERE a <> 256

-- sqlfmt-corpus-separator --

CREATE OR REPLACE VIEW mysecview8 WITH (security_invoker=true)
       AS SELECT * FROM tbl1 WHERE a < 256

-- sqlfmt-corpus-separator --

CREATE OR REPLACE VIEW mysecview9 WITH (security_invoker=false, security_barrier=true)
       AS SELECT * FROM tbl1 WHERE a <> 256

-- sqlfmt-corpus-separator --

CREATE SCHEMA AUTHORIZATION CURRENT_ROLE
  CREATE INDEX ON schema_not_existing.tab (id)

-- sqlfmt-corpus-separator --

CREATE SCHEMA AUTHORIZATION CURRENT_ROLE
  CREATE SEQUENCE schema_not_existing.seq

-- sqlfmt-corpus-separator --

CREATE SCHEMA AUTHORIZATION CURRENT_ROLE
  CREATE TABLE regress_create_schema_role.tab (id int)

-- sqlfmt-corpus-separator --

CREATE SCHEMA AUTHORIZATION CURRENT_ROLE
  CREATE TABLE schema_not_existing.tab (id int)

-- sqlfmt-corpus-separator --

CREATE SCHEMA AUTHORIZATION CURRENT_ROLE
  CREATE TRIGGER schema_trig BEFORE INSERT ON schema_not_existing.tab
  EXECUTE FUNCTION schema_trig.no_func()

-- sqlfmt-corpus-separator --

CREATE SCHEMA AUTHORIZATION CURRENT_ROLE
  CREATE VIEW schema_not_existing.view AS SELECT 1

-- sqlfmt-corpus-separator --

CREATE SCHEMA AUTHORIZATION regress_create_schema_role
  CREATE INDEX ON schema_not_existing.tab (id)

-- sqlfmt-corpus-separator --

CREATE SCHEMA AUTHORIZATION regress_create_schema_role
  CREATE SEQUENCE schema_not_existing.seq

-- sqlfmt-corpus-separator --

CREATE SCHEMA AUTHORIZATION regress_create_schema_role
  CREATE TABLE regress_create_schema_role.tab (id int)

-- sqlfmt-corpus-separator --

CREATE SCHEMA AUTHORIZATION regress_create_schema_role
  CREATE TABLE schema_not_existing.tab (id int)

-- sqlfmt-corpus-separator --

CREATE SCHEMA AUTHORIZATION regress_create_schema_role
  CREATE TRIGGER schema_trig BEFORE INSERT ON schema_not_existing.tab
  EXECUTE FUNCTION schema_trig.no_func()

-- sqlfmt-corpus-separator --

CREATE SCHEMA AUTHORIZATION regress_create_schema_role
  CREATE VIEW schema_not_existing.view AS SELECT 1

-- sqlfmt-corpus-separator --

CREATE SCHEMA audit_tbls authorization regress_evt_user

-- sqlfmt-corpus-separator --

CREATE SCHEMA evttrig
	CREATE TABLE one (col_a SERIAL PRIMARY KEY, col_b text DEFAULT 'forty two', col_c SERIAL)
	CREATE INDEX one_idx ON one (col_b)
	CREATE TABLE two (col_c INTEGER CHECK (col_c > 0) REFERENCES one DEFAULT 42)
	CREATE TABLE id (col_d int NOT NULL GENERATED ALWAYS AS IDENTITY)
	CREATE VIEW one_view AS SELECT * FROM two

-- sqlfmt-corpus-separator --

CREATE SCHEMA fkpart10
  CREATE TABLE tbl1(f1 int PRIMARY KEY) PARTITION BY RANGE(f1)
  CREATE TABLE tbl1_p1 PARTITION OF tbl1 FOR VALUES FROM (minvalue) TO (1)
  CREATE TABLE tbl1_p2 PARTITION OF tbl1 FOR VALUES FROM (1) TO (maxvalue)
  CREATE TABLE tbl2(f1 int REFERENCES tbl1 DEFERRABLE INITIALLY DEFERRED)
  CREATE TABLE tbl3(f1 int PRIMARY KEY) PARTITION BY RANGE(f1)
  CREATE TABLE tbl3_p1 PARTITION OF tbl3 FOR VALUES FROM (minvalue) TO (1)
  CREATE TABLE tbl3_p2 PARTITION OF tbl3 FOR VALUES FROM (1) TO (maxvalue)
  CREATE TABLE tbl4(f1 int REFERENCES tbl3 DEFERRABLE INITIALLY DEFERRED)

-- sqlfmt-corpus-separator --

CREATE SCHEMA fkpart11
  CREATE TABLE pk (a INT PRIMARY KEY, b text) PARTITION BY LIST (a)
  CREATE TABLE fk (
    a INT,
    CONSTRAINT fkey FOREIGN KEY (a) REFERENCES pk(a) ON UPDATE CASCADE ON DELETE CASCADE
  )
  CREATE TABLE fk_parted (
    a INT PRIMARY KEY,
    CONSTRAINT fkey FOREIGN KEY (a) REFERENCES pk(a) ON UPDATE CASCADE ON DELETE CASCADE
  ) PARTITION BY LIST (a)
  CREATE TABLE fk_another (
    a INT,
    CONSTRAINT fkey FOREIGN KEY (a) REFERENCES fk_parted (a) ON UPDATE CASCADE ON DELETE CASCADE
  )
  CREATE TABLE pk1 PARTITION OF pk FOR VALUES IN (1, 2) PARTITION BY LIST (a)
  CREATE TABLE pk2 PARTITION OF pk FOR VALUES IN (3)
  CREATE TABLE pk3 PARTITION OF pk FOR VALUES IN (4)
  CREATE TABLE fk1 PARTITION OF fk_parted FOR VALUES IN (1, 2)
  CREATE TABLE fk2 PARTITION OF fk_parted FOR VALUES IN (3)
  CREATE TABLE fk3 PARTITION OF fk_parted FOR VALUES IN (4)

-- sqlfmt-corpus-separator --

CREATE SCHEMA fkpart12
  CREATE TABLE fk_p ( id int, jd int, PRIMARY KEY(id, jd)) PARTITION BY list (id)
  CREATE TABLE fk_p_1 PARTITION OF fk_p FOR VALUES IN (1) PARTITION BY list (jd)
  CREATE TABLE fk_p_1_1 PARTITION OF fk_p_1 FOR VALUES IN (1)
  CREATE TABLE fk_p_1_2 (x int, y int, jd int NOT NULL, id int NOT NULL)
  CREATE TABLE fk_p_2 PARTITION OF fk_p FOR VALUES IN (2) PARTITION BY list (jd)
  CREATE TABLE fk_p_2_1 PARTITION OF fk_p_2 FOR VALUES IN (1)
  CREATE TABLE fk_p_2_2 PARTITION OF fk_p_2 FOR VALUES IN (2)
  CREATE TABLE fk_r_1 ( p_jd int NOT NULL, x int, id int PRIMARY KEY, p_id int NOT NULL)
  CREATE TABLE fk_r_2 ( id int PRIMARY KEY, p_id int NOT NULL, p_jd int NOT NULL) PARTITION BY list (id)
  CREATE TABLE fk_r_2_1 PARTITION OF fk_r_2 FOR VALUES IN (2, 1)
  CREATE TABLE fk_r   ( id int PRIMARY KEY, p_id int NOT NULL, p_jd int NOT NULL,
       FOREIGN KEY (p_id, p_jd) REFERENCES fk_p (id, jd)
  ) PARTITION BY list (id)

-- sqlfmt-corpus-separator --

CREATE SCHEMA fkpart7
  CREATE TABLE pkpart (a int) PARTITION BY LIST (a)
  CREATE TABLE pkpart1 PARTITION OF pkpart FOR VALUES IN (1)

-- sqlfmt-corpus-separator --

CREATE SCHEMA fkpart8
  CREATE TABLE tbl1(f1 int PRIMARY KEY)
  CREATE TABLE tbl2(f1 int REFERENCES tbl1 DEFERRABLE INITIALLY DEFERRED) PARTITION BY RANGE(f1)
  CREATE TABLE tbl2_p1 PARTITION OF tbl2 FOR VALUES FROM (minvalue) TO (maxvalue)

-- sqlfmt-corpus-separator --

CREATE SCHEMA fkpart9
  CREATE TABLE pk (a INT PRIMARY KEY) PARTITION BY RANGE (a)
  CREATE TABLE fk (
    fk_a INT REFERENCES pk(a) ON DELETE CASCADE
  )
  CREATE TABLE pk1 PARTITION OF pk FOR VALUES FROM (30) TO (50) PARTITION BY RANGE (a)
  CREATE TABLE pk11 PARTITION OF pk1 FOR VALUES FROM (30) TO (40)

-- sqlfmt-corpus-separator --

CREATE SCHEMA pubme CREATE TABLE t0 (c int, d int) CREATE TABLE t1 (c int)

-- sqlfmt-corpus-separator --

CREATE SCHEMA pubme2 CREATE TABLE t0 (c int, d int)

-- sqlfmt-corpus-separator --

CREATE SCHEMA regress_schema_1 AUTHORIZATION CURRENT_ROLE
  CREATE INDEX ON schema_not_existing.tab (id)

-- sqlfmt-corpus-separator --

CREATE SCHEMA regress_schema_1 AUTHORIZATION CURRENT_ROLE
  CREATE SEQUENCE schema_not_existing.seq

-- sqlfmt-corpus-separator --

CREATE SCHEMA regress_schema_1 AUTHORIZATION CURRENT_ROLE
  CREATE TABLE regress_schema_1.tab (id int)

-- sqlfmt-corpus-separator --

CREATE SCHEMA regress_schema_1 AUTHORIZATION CURRENT_ROLE
  CREATE TABLE schema_not_existing.tab (id int)

-- sqlfmt-corpus-separator --

CREATE SCHEMA regress_schema_1 AUTHORIZATION CURRENT_ROLE
  CREATE TRIGGER schema_trig BEFORE INSERT ON schema_not_existing.tab
  EXECUTE FUNCTION schema_trig.no_func()

-- sqlfmt-corpus-separator --

CREATE SCHEMA regress_schema_1 AUTHORIZATION CURRENT_ROLE
  CREATE VIEW abcd_view AS SELECT a FROM abcd
  CREATE TABLE abcd (a int)

-- sqlfmt-corpus-separator --

CREATE SCHEMA regress_schema_1 AUTHORIZATION CURRENT_ROLE
  CREATE VIEW schema_not_existing.view AS SELECT 1

-- sqlfmt-corpus-separator --

CREATE SCHEMA regress_tenant2_schema AUTHORIZATION regress_tenant2

-- sqlfmt-corpus-separator --

CREATE SCHEMA regress_tenant_schema AUTHORIZATION regress_tenant

-- sqlfmt-corpus-separator --

CREATE SCHEMA schema_one authorization regress_evt_user

-- sqlfmt-corpus-separator --

CREATE SCHEMA schema_two authorization regress_evt_user

-- sqlfmt-corpus-separator --

CREATE SCHEMA sts_sch1 CREATE TABLE sts_sch1.tbl (a INT, b INT, c INT GENERATED ALWAYS AS (b * 2) STORED)

-- sqlfmt-corpus-separator --

CREATE SCHEMA temp_view_test
    CREATE TABLE base_table (a int, id int)
    CREATE TABLE base_table2 (a int, id int)

-- sqlfmt-corpus-separator --

CREATE SCHEMA test_ns_schema_1
       CREATE TABLE abc (
              a serial,
              b int UNIQUE
       )

       CREATE UNIQUE INDEX abc_a_idx ON abc (a)

       CREATE VIEW abc_view AS
              SELECT a+1 AS a, b+1 AS b FROM abc

-- sqlfmt-corpus-separator --

CREATE SCHEMA test_ns_schema_2
       CREATE VIEW abc_view AS SELECT a FROM abc

-- sqlfmt-corpus-separator --

CREATE SCHEMA test_ns_schema_2
       CREATE VIEW abc_view AS SELECT c FROM abc

-- sqlfmt-corpus-separator --

CREATE SCHEMA test_view_schema
    CREATE TEMP VIEW testview AS SELECT 1

-- sqlfmt-corpus-separator --

CREATE SEQUENCE IF NOT EXISTS sequence_test

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_test10 AS integer MINVALUE -100000 START 1

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_test11 AS smallint

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_test12 AS smallint INCREMENT -1

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_test13 AS smallint MINVALUE -32768

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_test14 AS smallint MAXVALUE 32767 INCREMENT -1

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_test5 AS integer

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_test6 AS smallint

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_test7 AS bigint

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_test8 AS integer MAXVALUE 100000

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_test9 AS integer INCREMENT BY -1

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_testx AS nosuchtype

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_testx AS smallint MAXVALUE 100000

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_testx AS smallint MINVALUE -100000

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_testx AS text

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_testx OWNED BY nobody

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_testx OWNED BY pg_class.relname

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_testx OWNED BY pg_class_oid_index.oid

-- sqlfmt-corpus-separator --

CREATE SEQUENCE sequence_testx OWNED BY sequence_test_table.b

-- sqlfmt-corpus-separator --

CREATE TABLE IF NOT EXISTS as_select1 AS EXECUTE select1

-- sqlfmt-corpus-separator --

CREATE TABLE as_select1 AS EXECUTE select1

-- sqlfmt-corpus-separator --

CREATE TABLE brin_hot (
  id  integer PRIMARY KEY,
  val integer NOT NULL
) WITH (autovacuum_enabled = off, fillfactor = 70)

-- sqlfmt-corpus-separator --

CREATE TABLE brintest (byteacol bytea,
	charcol "char",
	namecol name,
	int8col bigint,
	int2col smallint,
	int4col integer,
	textcol text,
	oidcol oid,
	tidcol tid,
	float4col real,
	float8col double precision,
	macaddrcol macaddr,
	inetcol inet,
	cidrcol cidr,
	bpcharcol character,
	datecol date,
	timecol time without time zone,
	timestampcol timestamp without time zone,
	timestamptzcol timestamp with time zone,
	intervalcol interval,
	timetzcol time with time zone,
	bitcol bit(10),
	varbitcol bit varying(16),
	numericcol numeric,
	uuidcol uuid,
	int4rangecol int4range,
	lsncol pg_lsn,
	boxcol box
) WITH (fillfactor=10, autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE circles (
  c1 CIRCLE,
  c2 TEXT,
  EXCLUDE USING gist
    (c1 WITH &&, (c2::circle) WITH &&)
    WHERE (circle_center(c1) <> '(0,0)')
)

-- sqlfmt-corpus-separator --

CREATE TABLE cj_source1 (sid1 integer, scat integer, delta integer)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE cj_source2 (sid2 integer, sval text)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE cj_target (tid integer, balance float, val text)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE cmdata2 (LIKE cmdata_lz4 INCLUDING COMPRESSION)

-- sqlfmt-corpus-separator --

CREATE TABLE collate_test_like (
    LIKE collate_test1
)

-- sqlfmt-corpus-separator --

CREATE TABLE concur_reindex_tab3 (c1 int, c2 int4range, EXCLUDE USING gist (c2 WITH &&))

-- sqlfmt-corpus-separator --

CREATE TABLE ctlt1 (LIKE ctlt1 INCLUDING ALL)

-- sqlfmt-corpus-separator --

CREATE TABLE ctlt10 (LIKE ctlseq1)

-- sqlfmt-corpus-separator --

CREATE TABLE ctlt11 (LIKE ctlv1)

-- sqlfmt-corpus-separator --

CREATE TABLE ctlt11a (LIKE ctlv1 INCLUDING ALL)

-- sqlfmt-corpus-separator --

CREATE TABLE ctlt12 (LIKE ctlty1)

-- sqlfmt-corpus-separator --

CREATE TABLE ctlt12_storage (LIKE ctlt1 INCLUDING STORAGE, LIKE ctlt2 INCLUDING STORAGE)

-- sqlfmt-corpus-separator --

CREATE TABLE ctlt1_inh (LIKE ctlt1 INCLUDING CONSTRAINTS INCLUDING COMMENTS) INHERITS (ctlt1)

-- sqlfmt-corpus-separator --

CREATE TABLE ctlt_all (LIKE ctlt1 INCLUDING ALL)

-- sqlfmt-corpus-separator --

CREATE TABLE def_part (LIKE list_parted INCLUDING CONSTRAINTS)

-- sqlfmt-corpus-separator --

CREATE TABLE deferred_excl (
  f1 int,
  f2 int,
  CONSTRAINT deferred_excl_con EXCLUDE (f1 WITH =) INITIALLY DEFERRED
)

-- sqlfmt-corpus-separator --

CREATE TABLE ex_msource (a int, b int)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE ex_mtarget (a int, b int)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE fail_def_part (LIKE part_1 INCLUDING CONSTRAINTS)

-- sqlfmt-corpus-separator --

CREATE TABLE fail_part (LIKE hpart_1)

-- sqlfmt-corpus-separator --

CREATE TABLE fail_part (LIKE list_parted)

-- sqlfmt-corpus-separator --

CREATE TABLE fail_part (LIKE part_1 INCLUDING CONSTRAINTS)

-- sqlfmt-corpus-separator --

CREATE TABLE fail_part (like list_parted, c int)

-- sqlfmt-corpus-separator --

CREATE TABLE fail_part (like unparted)

-- sqlfmt-corpus-separator --

CREATE TABLE fail_part(LIKE hash_parted)

-- sqlfmt-corpus-separator --

CREATE TABLE fk (a int REFERENCES pk DEFERRABLE INITIALLY IMMEDIATE)

-- sqlfmt-corpus-separator --

CREATE TABLE fk4 (LIKE fk)

-- sqlfmt-corpus-separator --

CREATE TABLE fktable (
	id		INT4 PRIMARY KEY,
	fk		INT4 REFERENCES pktable DEFERRABLE
)

-- sqlfmt-corpus-separator --

CREATE TABLE fktable (
	id		INT4 PRIMARY KEY,
	fk		INT4 REFERENCES pktable DEFERRABLE INITIALLY DEFERRED
)

-- sqlfmt-corpus-separator --

CREATE TABLE foo (LIKE nonexistent)

-- sqlfmt-corpus-separator --

CREATE TABLE fp_fk_commit (a int REFERENCES fp_pk_commit
    DEFERRABLE INITIALLY DEFERRED)

-- sqlfmt-corpus-separator --

CREATE TABLE fp_fk_defer (a int REFERENCES fp_pk_defer DEFERRABLE INITIALLY DEFERRED)

-- sqlfmt-corpus-separator --

CREATE TABLE fs_target (a int, b int, c text)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE functional_dependencies (
    filler1 TEXT,
    filler2 NUMERIC,
    a INT,
    b TEXT,
    filler3 DATE,
    c INT,
    d TEXT
)
WITH (autovacuum_enabled = off)

-- sqlfmt-corpus-separator --

CREATE TABLE functional_dependencies_multi (
	a INTEGER,
	b INTEGER,
	c INTEGER,
	d INTEGER
)
WITH (autovacuum_enabled = off)

-- sqlfmt-corpus-separator --

CREATE TABLE gtest28b (LIKE gtest28a INCLUDING GENERATED)

-- sqlfmt-corpus-separator --

CREATE TABLE heaptable USING heap AS
  SELECT a, repeat(a::text, 100) FROM generate_series(1,9) AS a

-- sqlfmt-corpus-separator --

CREATE TABLE hpart_2 (LIKE hash_parted)

-- sqlfmt-corpus-separator --

CREATE TABLE hpart_5 (
	LIKE hash_parted
) PARTITION BY LIST (b)

-- sqlfmt-corpus-separator --

CREATE TABLE idxpart1 (LIKE idxpart)

-- sqlfmt-corpus-separator --

CREATE TABLE inh_error2 (LIKE ctlt4 INCLUDING STORAGE) INHERITS (ctlt1)

-- sqlfmt-corpus-separator --

CREATE TABLE inh_test (LIKE part_2)

-- sqlfmt-corpus-separator --

CREATE TABLE inhe (ee text, LIKE inhx) inherits (ctlb)

-- sqlfmt-corpus-separator --

CREATE TABLE inhg (LIKE inhx)

-- sqlfmt-corpus-separator --

CREATE TABLE inhg (x text, LIKE inhx INCLUDING CONSTRAINTS, y text)

-- sqlfmt-corpus-separator --

CREATE TABLE inhg (x text, LIKE inhx INCLUDING INDEXES, y text)

-- sqlfmt-corpus-separator --

CREATE TABLE like_constraint_rename_cache
  (LIKE constraint_rename_cache INCLUDING ALL)

-- sqlfmt-corpus-separator --

CREATE TABLE mcv_lists (
    filler1 TEXT,
    filler2 NUMERIC,
    a INT,
    b VARCHAR,
    filler3 DATE,
    c INT,
    d TEXT,
    ia INT[]
)
WITH (autovacuum_enabled = off)

-- sqlfmt-corpus-separator --

CREATE TABLE mcv_lists_arrays (
    a TEXT[],
    b NUMERIC[],
    c INT[]
)
WITH (autovacuum_enabled = off)

-- sqlfmt-corpus-separator --

CREATE TABLE mcv_lists_bool (
    a BOOL,
    b BOOL,
    c BOOL
)
WITH (autovacuum_enabled = off)

-- sqlfmt-corpus-separator --

CREATE TABLE mcv_lists_multi (
	a INTEGER,
	b INTEGER,
	c INTEGER,
	d INTEGER
)
WITH (autovacuum_enabled = off)

-- sqlfmt-corpus-separator --

CREATE TABLE mcv_lists_uuid (
    a UUID,
    b UUID,
    c UUID
)
WITH (autovacuum_enabled = off)

-- sqlfmt-corpus-separator --

CREATE TABLE measurement (
    city_id         int not null,
    logdate         date not null,
    peaktemp        int,
    unitsales       int
) WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE measurement_y2006m02 (
    CHECK ( logdate >= DATE '2006-02-01' AND logdate < DATE '2006-03-01' )
) INHERITS (measurement) WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE measurement_y2006m03 (
    CHECK ( logdate >= DATE '2006-03-01' AND logdate < DATE '2006-04-01' )
) INHERITS (measurement) WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE measurement_y2007m01 (
    filler          text,
    peaktemp        int,
    logdate         date not null,
    city_id         int not null,
    unitsales       int
    CHECK ( logdate >= DATE '2007-01-01' AND logdate < DATE '2007-02-01')
) WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE ndistinct (
    filler1 TEXT,
    filler2 NUMERIC,
    a INT,
    b INT,
    filler3 DATE,
    c INT,
    d INT
)
WITH (autovacuum_enabled = off)

-- sqlfmt-corpus-separator --

CREATE TABLE new_measurement (LIKE measurement) WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE noinh_con_copy1 (LIKE noinh_con_copy INCLUDING CONSTRAINTS INCLUDING COMMENTS)

-- sqlfmt-corpus-separator --

CREATE TABLE noinh_con_copy1_parted (LIKE noinh_con_copy INCLUDING ALL)
  PARTITION BY LIST (a)

-- sqlfmt-corpus-separator --

CREATE TABLE not_owned_by_me (LIKE list_parted)

-- sqlfmt-corpus-separator --

CREATE TABLE notnull_tbl4 (a INTEGER PRIMARY KEY INITIALLY DEFERRED)

-- sqlfmt-corpus-separator --

CREATE TABLE notnull_tbl4_lk (LIKE notnull_tbl4)

-- sqlfmt-corpus-separator --

CREATE TABLE notnull_tbl4_lk2 (LIKE notnull_tbl4 INCLUDING INDEXES)

-- sqlfmt-corpus-separator --

CREATE TABLE pa_source (sid integer, delta float)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE parallel_vacuum_table (a int) WITH (autovacuum_enabled = off)

-- sqlfmt-corpus-separator --

CREATE TABLE parent (LIKE list_parted)

-- sqlfmt-corpus-separator --

CREATE TABLE part1 (tid integer, balance float, val text)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE part1 PARTITION OF pa_target FOR VALUES IN (1,4)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE part2 (balance float, tid integer, val text)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE part2 PARTITION OF pa_target FOR VALUES IN (2,5,6)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE part3 (LIKE range_parted)

-- sqlfmt-corpus-separator --

CREATE TABLE part3 (tid integer, balance float, val text)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE part3 PARTITION OF pa_target FOR VALUES IN (3,8,9)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE part4 (extraid text, tid integer, balance float, val text)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE part4 PARTITION OF pa_target DEFAULT
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE part5_p1 (LIKE part_5)

-- sqlfmt-corpus-separator --

CREATE TABLE part_2 (LIKE list_parted2)

-- sqlfmt-corpus-separator --

CREATE TABLE part_3 (LIKE list_parted2)

-- sqlfmt-corpus-separator --

CREATE TABLE part_3_4 (
	LIKE list_parted2,
	CONSTRAINT check_a CHECK (a IN (3))
)

-- sqlfmt-corpus-separator --

CREATE TABLE part_5 (
	LIKE list_parted2
) PARTITION BY LIST (b)

-- sqlfmt-corpus-separator --

CREATE TABLE part_6 (
	c int,
	LIKE list_parted2,
	CONSTRAINT check_a CHECK (a IS NOT NULL AND a = 6)
)

-- sqlfmt-corpus-separator --

CREATE TABLE part_7 (
	LIKE list_parted2,
	CONSTRAINT check_a CHECK (a IS NOT NULL AND a = 7)
) PARTITION BY LIST (b)

-- sqlfmt-corpus-separator --

CREATE TABLE part_7_a_null (
	c int,
	d int,
	e int,
	LIKE list_parted2,  -- 'a' will have attnum = 4
	CONSTRAINT check_b CHECK (b IS NULL OR b = 'a'),
	CONSTRAINT check_a CHECK (a IS NOT NULL AND a = 7)
)

-- sqlfmt-corpus-separator --

CREATE TABLE part_m01_even PARTITION OF part_m01
	FOR VALUES IN (2,4,6,8) WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE part_m01_odd PARTITION OF part_m01
	FOR VALUES IN (1,3,5,7,9) WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE part_m02_even PARTITION OF part_m02
	FOR VALUES IN (2,4,6,8) WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE part_m02_odd PARTITION OF part_m02
	FOR VALUES IN (1,3,5,7,9) WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE parted_uniq_tbl (i int UNIQUE DEFERRABLE) partition by range (i)

-- sqlfmt-corpus-separator --

CREATE TABLE partr_def2 (LIKE part1 INCLUDING CONSTRAINTS)

-- sqlfmt-corpus-separator --

CREATE TABLE pg_attrdef (LIKE ctlt1 INCLUDING ALL)

-- sqlfmt-corpus-separator --

CREATE TABLE pitest1_p1_like (LIKE pitest1_p1 INCLUDING IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TABLE pk4 (LIKE pk)

-- sqlfmt-corpus-separator --

CREATE TABLE pvactst (i INT, a INT[], p POINT) with (autovacuum_enabled = off)

-- sqlfmt-corpus-separator --

CREATE TABLE pvactst2 (i INT) WITH (autovacuum_enabled = off)

-- sqlfmt-corpus-separator --

CREATE TABLE reloptions_test(i INT) WITH (vacuum_truncate=FaLS)

-- sqlfmt-corpus-separator --

CREATE TABLE sales_external (LIKE sales_list)

-- sqlfmt-corpus-separator --

CREATE TABLE sales_list2 (LIKE sales_list) PARTITION BY LIST (sales_state)

-- sqlfmt-corpus-separator --

CREATE TABLE selinto_schema.tbl_nodata3 (a) AS
  EXECUTE data_sel WITH NO DATA

-- sqlfmt-corpus-separator --

CREATE TABLE selinto_schema.tbl_withdata3 (a) AS
  EXECUTE data_sel WITH DATA

-- sqlfmt-corpus-separator --

CREATE TABLE source (sid integer, delta integer) -- no index
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE source2 (sid integer, delta integer)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE sq_source (delta integer, sid integer, balance integer DEFAULT 0)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE sq_target (tid integer NOT NULL, balance integer)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE stats_import.test_clone ( LIKE stats_import.test )
    WITH (autovacuum_enabled = false)

-- sqlfmt-corpus-separator --

CREATE TABLE stats_import.test_mr_clone ( LIKE stats_import.test_mr )
    WITH (autovacuum_enabled = false)

-- sqlfmt-corpus-separator --

CREATE TABLE table_fillfactor (
  n char(1000)
) with (fillfactor=10, autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE tableam_tblas_heap2 USING heap2 AS SELECT * FROM tableam_tbl_heap2

-- sqlfmt-corpus-separator --

CREATE TABLE target (tid integer, balance integer)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE target2 (tid integer, balance integer)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE tas_case WITH ("Fillfactor" = 10) AS SELECT 1 a

-- sqlfmt-corpus-separator --

CREATE TABLE tbl (c1 int,c2 int, c3 int, c4 box,
				EXCLUDE USING btree (c1 WITH =) INCLUDE(c3,c4))

-- sqlfmt-corpus-separator --

CREATE TABLE temporal_rng2 (LIKE temporal_rng INCLUDING ALL)

-- sqlfmt-corpus-separator --

CREATE TABLE test_ex_constraints (
    c circle,
    EXCLUDE USING gist (c WITH &&)
)

-- sqlfmt-corpus-separator --

CREATE TABLE test_like_4b (LIKE test_like_4 INCLUDING DEFAULTS)

-- sqlfmt-corpus-separator --

CREATE TABLE test_like_4c (LIKE test_like_4 INCLUDING GENERATED)

-- sqlfmt-corpus-separator --

CREATE TABLE test_like_4d (LIKE test_like_4 INCLUDING DEFAULTS INCLUDING GENERATED)

-- sqlfmt-corpus-separator --

CREATE TABLE test_like_5c (LIKE test_like_4 INCLUDING ALL)
  INHERITS (test_like_5, test_like_5x)

-- sqlfmt-corpus-separator --

CREATE TABLE test_like_6c (LIKE test_like_6 INCLUDING ALL)

-- sqlfmt-corpus-separator --

CREATE TABLE test_like_gen_2 (LIKE test_like_gen_1)

-- sqlfmt-corpus-separator --

CREATE TABLE test_like_gen_3 (LIKE test_like_gen_1 INCLUDING GENERATED)

-- sqlfmt-corpus-separator --

CREATE TABLE test_like_id_2 (LIKE test_like_id_1)

-- sqlfmt-corpus-separator --

CREATE TABLE test_like_id_3 (LIKE test_like_id_1 INCLUDING IDENTITY)

-- sqlfmt-corpus-separator --

CREATE TABLE test_replica_identity_t3 (id serial constraint pk primary key deferrable)

-- sqlfmt-corpus-separator --

CREATE TABLE test_tblx (x int, y test_typex check ((y).a > 0))

-- sqlfmt-corpus-separator --

CREATE TABLE testpub_parted1 (LIKE testpub_parted)

-- sqlfmt-corpus-separator --

CREATE TABLE testpub_parted2 (LIKE testpub_parted)

-- sqlfmt-corpus-separator --

CREATE TABLE testschema.asexecute TABLESPACE regress_tblspace
    AS EXECUTE selectsource(2)

-- sqlfmt-corpus-separator --

CREATE TABLE testschema.asselect TABLESPACE regress_tblspace AS SELECT 1

-- sqlfmt-corpus-separator --

CREATE TABLE trgfire3 (LIKE trgfire)

-- sqlfmt-corpus-separator --

CREATE TABLE trgfire5 (LIKE trgfire) PARTITION BY LIST (i)

-- sqlfmt-corpus-separator --

CREATE TABLE unique_tbl (i int UNIQUE DEFERRABLE, t text)

-- sqlfmt-corpus-separator --

CREATE TABLE vistest (LIKE testeoc)

-- sqlfmt-corpus-separator --

CREATE TABLE wq_source (balance integer, sid integer)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TABLE wq_target (tid integer not null, balance integer DEFAULT -1)
  WITH (autovacuum_enabled=off)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE fktable (
    id int primary key,
    fk int references pktable deferrable initially deferred
)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE onek_copy (LIKE onek)

-- sqlfmt-corpus-separator --

CREATE TEMP TABLE stud_emp_copy (LIKE stud_emp)

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE q5_prep_nodata AS EXECUTE q5(200, 'DTAAAA')
    WITH NO DATA

-- sqlfmt-corpus-separator --

CREATE TEMPORARY TABLE q5_prep_results AS EXECUTE q5(200, 'DTAAAA')

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX CONCURRENTLY on tbl (c1, c2) INCLUDE (c3, c4)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON ONLY p1 (a)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON emp1((id*id))

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON lt1 (a)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON mvtest_mv (a)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON mvtest_mv (b)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON mvtest_mv(a)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON mvtest_mv_foo (i)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON regress_constr_partitioned (a)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON sj_t2 USING btree (id)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON sj_t3 USING btree (a,id)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON sro_index_mv (c) WHERE unwanted_grant_nofail(1) > 0

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON test1bpci (x)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON test1ci (x)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON test1cs (x)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON test3bpci (x)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON test3ci (x)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX ON test3cs (x)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX concur_exprs_index_expr
  ON concur_exprs_tab ((c1::text COLLATE "C"))

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX covering_index_index on covering_index_heap (f1,f2) INCLUDE(f3)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX covering_pkey on covering_index_heap (f1,f2) INCLUDE(f3)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX cwi_a_nnd ON cwi_test (a) NULLS NOT DISTINCT

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX cwi_uniq4_idx ON cwi_test(b collate "POSIX")

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX dedup_unique ON dedup_unique_test_table (a) WITH (deduplicate_items=on)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX on mvtest_mv (c)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX parallel_hang_idx
					ON parallel_hang
					USING btree (i int4_custom_ops)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX plain_unique ON dedup_unique_test_table (a) WITH (deduplicate_items=off)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX tbl_idx ON tbl using btree(c1, c2) INCLUDE(c3,c4)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX tbl_idx_unique ON tbl using btree(c1, c2) INCLUDE (c3,c4)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX tbl_include_box_idx_unique ON tbl_include_box using btree (c1, c2) INCLUDE (c3, c4)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX tbl_include_unique1_idx_unique ON tbl_include_unique1 using btree (c1, c2) INCLUDE (c3, c4)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX tbl_include_unique2_idx_unique ON tbl_include_unique2 using btree (c1, c2) INCLUDE (c3, c4)

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX unique_idx2 ON unique_tbl (i) NULLS NOT DISTINCT

-- sqlfmt-corpus-separator --

CREATE UNIQUE INDEX unique_idx4 ON unique_tbl (i) NULLS NOT DISTINCT

-- sqlfmt-corpus-separator --

CREATE UNLOGGED SEQUENCE sequence_test_unlogged

-- sqlfmt-corpus-separator --

CREATE VIEW atest12sbv WITH (security_barrier=true) AS
  SELECT * FROM atest12 WHERE b <<< 5

-- sqlfmt-corpus-separator --

CREATE VIEW bv1 WITH (security_barrier) AS SELECT * FROM b1 WHERE a > 0 WITH CHECK OPTION

-- sqlfmt-corpus-separator --

CREATE VIEW dfview AS
   SELECT q1, q2,
     dfunc(q1,q2, flag := q1>q2) as c3,
     dfunc(q1, flag := q1<q2, b := q2) as c4
     FROM int8_tbl

-- sqlfmt-corpus-separator --

CREATE VIEW domain_isjson AS
WITH cte(a) AS (VALUES('{"a": 1, "a": 2}'))
SELECT	a::jd1 IS JSON WITH UNIQUE KEYS as jd1,
		a::jd3 IS JSON WITH UNIQUE KEYS as jd3,
		a::jd4 IS JSON WITH UNIQUE KEYS as jd4
FROM cte

-- sqlfmt-corpus-separator --

CREATE VIEW gstest_view AS select a, b, grouping(a,b), sum(c), count(*), max(c)
  from gstest2 group by rollup ((a,b,c),(c,d))

-- sqlfmt-corpus-separator --

CREATE VIEW is_json_view AS
SELECT '1' IS JSON AS "any", ('1' || i) IS JSON SCALAR AS "scalar", '[]' IS NOT JSON ARRAY AS "array", '{}' IS JSON OBJECT WITH UNIQUE AS "object" FROM generate_series(1, 3) i

-- sqlfmt-corpus-separator --

CREATE VIEW json_array_subquery_view AS
SELECT JSON_ARRAY(SELECT i FROM (VALUES (1), (2), (NULL), (4)) foo(i) RETURNING jsonb)

-- sqlfmt-corpus-separator --

CREATE VIEW json_array_view AS
SELECT JSON_ARRAY('1' FORMAT JSON, 2 RETURNING json)

-- sqlfmt-corpus-separator --

CREATE VIEW json_arrayagg_view AS
SELECT JSON_ARRAYAGG(('111' || i)::bytea FORMAT JSON NULL ON NULL RETURNING text) FILTER (WHERE i > 3)
FROM generate_series(1,5) i

-- sqlfmt-corpus-separator --

CREATE VIEW json_object_view AS
SELECT JSON_OBJECT('foo' : '1' FORMAT JSON, 'bar' : 'baz' RETURNING json)

-- sqlfmt-corpus-separator --

CREATE VIEW json_objectagg_view AS
SELECT JSON_OBJECTAGG(i: ('111' || i)::bytea FORMAT JSON WITH UNIQUE RETURNING text) FILTER (WHERE i > 3)
FROM generate_series(1,5) i

-- sqlfmt-corpus-separator --

CREATE VIEW lock_view8 WITH (security_invoker) AS SELECT * FROM lock_tbl1

-- sqlfmt-corpus-separator --

CREATE VIEW my_credit_card_secure WITH (security_barrier) AS
       SELECT * FROM customer l NATURAL JOIN credit_card r
       WHERE l.name = current_user

-- sqlfmt-corpus-separator --

CREATE VIEW my_credit_card_usage_secure WITH (security_barrier) AS
       SELECT * FROM my_credit_card_secure l NATURAL JOIN credit_usage r

-- sqlfmt-corpus-separator --

CREATE VIEW my_property_secure WITH (security_barrier) AS
       SELECT * FROM customer WHERE name = current_user

-- sqlfmt-corpus-separator --

CREATE VIEW mysecview10 WITH (security_invoker=100)	-- Error
       AS SELECT * FROM tbl1 WHERE a <> 100

-- sqlfmt-corpus-separator --

CREATE VIEW mysecview2 WITH (security_barrier=true)
       AS SELECT * FROM tbl1 WHERE a > 0

-- sqlfmt-corpus-separator --

CREATE VIEW mysecview3 WITH (security_barrier=false)
       AS SELECT * FROM tbl1 WHERE a < 0

-- sqlfmt-corpus-separator --

CREATE VIEW mysecview4 WITH (security_barrier)
       AS SELECT * FROM tbl1 WHERE a <> 0

-- sqlfmt-corpus-separator --

CREATE VIEW mysecview5 WITH (security_barrier=100)	-- Error
       AS SELECT * FROM tbl1 WHERE a > 100

-- sqlfmt-corpus-separator --

CREATE VIEW mysecview6 WITH (invalid_option)		-- Error
       AS SELECT * FROM tbl1 WHERE a < 100

-- sqlfmt-corpus-separator --

CREATE VIEW mysecview7 WITH (security_invoker=true)
       AS SELECT * FROM tbl1 WHERE a = 100

-- sqlfmt-corpus-separator --

CREATE VIEW mysecview8 WITH (security_invoker=false, security_barrier=true)
       AS SELECT * FROM tbl1 WHERE a > 100

-- sqlfmt-corpus-separator --

CREATE VIEW mysecview9 WITH (security_invoker)
       AS SELECT * FROM tbl1 WHERE a < 100

-- sqlfmt-corpus-separator --

CREATE VIEW rec1v WITH (security_barrier) AS SELECT * FROM rec1

-- sqlfmt-corpus-separator --

CREATE VIEW rec2v WITH (security_barrier) AS SELECT * FROM rec2

-- sqlfmt-corpus-separator --

CREATE VIEW rls_sbv WITH (security_barrier) AS
    SELECT * FROM y1 WHERE f_leak(b)

-- sqlfmt-corpus-separator --

CREATE VIEW rls_view WITH (security_invoker) AS
    SELECT * FROM z1 WHERE f_leak(b)

-- sqlfmt-corpus-separator --

CREATE VIEW ruletest_v1 WITH (security_invoker=true) AS
    SELECT * FROM ruletest_t1

-- sqlfmt-corpus-separator --

CREATE VIEW rw_view1 WITH (security_barrier=true) AS
  SELECT id, data FROM base_tbl WHERE NOT deleted

-- sqlfmt-corpus-separator --

CREATE VIEW rw_view2 WITH (security_barrier = true) AS
  SELECT * FROM rw_view1 WHERE snoop(person)

-- sqlfmt-corpus-separator --

CREATE VIEW tenk1_vw_sec WITH (security_barrier) AS SELECT * FROM tenk1

-- sqlfmt-corpus-separator --

CREATE VIEW test_tablesample_v1 AS
  SELECT id FROM test_tablesample TABLESAMPLE SYSTEM (10*2) REPEATABLE (2)

-- sqlfmt-corpus-separator --

CREATE VIEW test_tablesample_v2 AS
  SELECT id FROM test_tablesample TABLESAMPLE SYSTEM (99)

-- sqlfmt-corpus-separator --

CREATE VIEW tststats.priv_test_view WITH (security_barrier=true)
    AS SELECT * FROM tststats.priv_test_tbl WHERE false

-- sqlfmt-corpus-separator --

CREATE VIEW v1 WITH (security_barrier = true) AS
  SELECT * FROM t1

-- sqlfmt-corpus-separator --

CREATE VIEW v1 WITH (security_barrier = true) AS
  SELECT * FROM t1 WHERE (a > 0)
  WITH CHECK OPTION

-- sqlfmt-corpus-separator --

CREATE VIEW v1 WITH (security_barrier=true) AS
SELECT *, (SELECT d FROM t11 WHERE t11.a = t1.a LIMIT 1) AS d
FROM t1
WHERE a > 5 AND EXISTS(SELECT 1 FROM t12 WHERE t12.a = t1.a)

-- sqlfmt-corpus-separator --

CREATE VIEW v2 WITH (security_barrier = true) AS
  SELECT * FROM v1 WHERE EXISTS (SELECT 1 FROM t2 WHERE t2.cc = v1.c)
  WITH CHECK OPTION

-- sqlfmt-corpus-separator --

CREATE VIEW v2 WITH (security_barrier = true) AS
  SELECT * FROM v1 WHERE EXISTS (SELECT 1)

-- sqlfmt-corpus-separator --

CREATE VIEW vw_getrngfunc AS
  SELECT * FROM ROWS FROM( getrngfunc6(1) AS (rngfuncid int, rngfuncsubid int, rngfuncname text) )
                WITH ORDINALITY

-- sqlfmt-corpus-separator --

CREATE VIEW vw_getrngfunc AS
  SELECT * FROM ROWS FROM( getrngfunc7(1) AS (rngfuncid int, rngfuncsubid int, rngfuncname text) )
                WITH ORDINALITY

-- sqlfmt-corpus-separator --

CREATE VIEW xmltableview1 AS SELECT  xmltable.*
   FROM (SELECT data FROM xmldata) x,
        LATERAL XMLTABLE('/ROWS/ROW'
                         PASSING data
                         COLUMNS id int PATH '@id',
                                  _id FOR ORDINALITY,
                                  country_name text PATH 'COUNTRY_NAME/text()' NOT NULL,
                                  country_id text PATH 'COUNTRY_ID',
                                  region_id int PATH 'REGION_ID',
                                  size float PATH 'SIZE',
                                  unit text PATH 'SIZE/@unit',
                                  premier_name text PATH 'PREMIER_NAME' DEFAULT 'not specified')

-- sqlfmt-corpus-separator --

CREATE VIEW xmltableview2 AS SELECT * FROM XMLTABLE(XMLNAMESPACES('http://x.y' AS "Zz"),
                      '/Zz:rows/Zz:row'
                      PASSING '<rows xmlns="http://x.y"><row><a>10</a></row></rows>'
                      COLUMNS a int PATH 'Zz:a')

-- sqlfmt-corpus-separator --

CREATE VIEW xmlview10 AS SELECT xmlserialize(document '<foo><bar>42</bar></foo>' AS text indent)

-- sqlfmt-corpus-separator --

CREATE VIEW xmlview11 AS SELECT xmlserialize(document '<foo><bar>42</bar></foo>' AS character varying no indent)

-- sqlfmt-corpus-separator --

CREATE VIEW xmlview2 AS SELECT xmlconcat('hello', 'you')

-- sqlfmt-corpus-separator --

CREATE VIEW xmlview3 AS SELECT xmlelement(name element, xmlattributes (1 as ":one:", 'deuce' as two), 'content&')

-- sqlfmt-corpus-separator --

CREATE VIEW xmlview4 AS SELECT xmlelement(name employee, xmlforest(name, age, salary as pay)) FROM emp

-- sqlfmt-corpus-separator --

CREATE VIEW xmlview5 AS SELECT xmlparse(content '<abc>x</abc>')

-- sqlfmt-corpus-separator --

CREATE VIEW xmlview6 AS SELECT xmlpi(name foo, 'bar')

-- sqlfmt-corpus-separator --

CREATE VIEW xmlview7 AS SELECT xmlroot(xml '<foo/>', version no value, standalone yes)

-- sqlfmt-corpus-separator --

CREATE VIEW xmlview8 AS SELECT xmlserialize(content 'good' as char(10))

-- sqlfmt-corpus-separator --

CREATE VIEW xmlview9 AS SELECT xmlserialize(content 'good' as text)

-- sqlfmt-corpus-separator --

DECLARE tablesample_cur SCROLL CURSOR FOR
  SELECT id FROM test_tablesample TABLESAMPLE SYSTEM (50) REPEATABLE (0)

-- sqlfmt-corpus-separator --

DELETE FROM arrtest WHERE a[2] IS NULL AND b IS NULL

-- sqlfmt-corpus-separator --

DELETE FROM current_check WHERE CURRENT OF c1 RETURNING *

-- sqlfmt-corpus-separator --

DELETE FROM current_check WHERE CURRENT OF current_check_cursor RETURNING *

-- sqlfmt-corpus-separator --

DELETE FROM foo WHERE f1 > 2 RETURNING f3, f2, f1, least(f1,f3)

-- sqlfmt-corpus-separator --

DELETE FROM onek WHERE CURRENT OF c1

-- sqlfmt-corpus-separator --

DELETE FROM tenk1 WHERE CURRENT OF c

-- sqlfmt-corpus-separator --

DELETE FROM uctest WHERE CURRENT OF c

-- sqlfmt-corpus-separator --

DELETE FROM uctest WHERE CURRENT OF c1

-- sqlfmt-corpus-separator --

DELETE FROM uctest WHERE CURRENT OF cx

-- sqlfmt-corpus-separator --

DELETE FROM ucview WHERE CURRENT OF c1

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER IF EXISTS nonexistent

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER IF EXISTS test_fdw_exists

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER addr_fdw CASCADE

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER alt_fdw2 CASCADE

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER alt_fdw3 CASCADE

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER ctl_dummy CASCADE

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER dummy

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER dummy CASCADE

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER extstats_dummy_fdw CASCADE

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER foo

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER foo CASCADE

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER nonexistent

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER postgresql CASCADE

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER test_fdw

-- sqlfmt-corpus-separator --

DROP FOREIGN DATA WRAPPER test_fdw_exists

-- sqlfmt-corpus-separator --

DROP SERVER IF EXISTS nonexistent

-- sqlfmt-corpus-separator --

DROP SERVER IF EXISTS test_server_exists

-- sqlfmt-corpus-separator --

DROP SERVER nonexistent

-- sqlfmt-corpus-separator --

DROP SERVER s0

-- sqlfmt-corpus-separator --

DROP SERVER s1

-- sqlfmt-corpus-separator --

DROP SERVER s10 CASCADE

-- sqlfmt-corpus-separator --

DROP SERVER s2

-- sqlfmt-corpus-separator --

DROP SERVER s3 CASCADE

-- sqlfmt-corpus-separator --

DROP SERVER s4

-- sqlfmt-corpus-separator --

DROP SERVER s6

-- sqlfmt-corpus-separator --

DROP SERVER s7

-- sqlfmt-corpus-separator --

DROP SERVER s8 CASCADE

-- sqlfmt-corpus-separator --

DROP SERVER s9 CASCADE

-- sqlfmt-corpus-separator --

DROP SERVER t1 CASCADE

-- sqlfmt-corpus-separator --

DROP SERVER test_server

-- sqlfmt-corpus-separator --

DROP SERVER test_server_exists

-- sqlfmt-corpus-separator --

DROP TEXT SEARCH CONFIGURATION IF EXISTS no_such_schema.foo

-- sqlfmt-corpus-separator --

DROP TEXT SEARCH CONFIGURATION IF EXISTS test_tsconfig_exists

-- sqlfmt-corpus-separator --

DROP TEXT SEARCH CONFIGURATION dummy_tst

-- sqlfmt-corpus-separator --

DROP TEXT SEARCH CONFIGURATION test_tsconfig_exists

-- sqlfmt-corpus-separator --

DROP TEXT SEARCH DICTIONARY IF EXISTS no_such_schema.foo

-- sqlfmt-corpus-separator --

DROP TEXT SEARCH DICTIONARY IF EXISTS test_tsdict_exists

-- sqlfmt-corpus-separator --

DROP TEXT SEARCH DICTIONARY test_tsdict_exists

-- sqlfmt-corpus-separator --

DROP TEXT SEARCH PARSER IF EXISTS no_such_schema.foo

-- sqlfmt-corpus-separator --

DROP TEXT SEARCH PARSER IF EXISTS test_tsparser_exists

-- sqlfmt-corpus-separator --

DROP TEXT SEARCH PARSER test_tsparser_exists

-- sqlfmt-corpus-separator --

DROP TEXT SEARCH TEMPLATE IF EXISTS no_such_schema.foo

-- sqlfmt-corpus-separator --

DROP TEXT SEARCH TEMPLATE IF EXISTS test_tstemplate_exists

-- sqlfmt-corpus-separator --

DROP TEXT SEARCH TEMPLATE test_tstemplate_exists

-- sqlfmt-corpus-separator --

EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF)
  CREATE TABLE IF NOT EXISTS ctas_ine_tbl AS EXECUTE ctas_ine_query

-- sqlfmt-corpus-separator --

EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF)
  CREATE TABLE ctas_ine_tbl AS EXECUTE ctas_ine_query

-- sqlfmt-corpus-separator --

EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF, BUFFERS OFF)
  CREATE TABLE selinto_schema.tbl_nodata4 (a) AS
  EXECUTE data_sel WITH NO DATA

-- sqlfmt-corpus-separator --

EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF, BUFFERS OFF)
  CREATE TABLE selinto_schema.tbl_withdata4 (a) AS
  EXECUTE data_sel WITH DATA

-- sqlfmt-corpus-separator --

EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF, BUFFERS OFF)
UPDATE tidscan SET id = -id WHERE CURRENT OF c RETURNING *

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
  SELECT id FROM test_tablesample TABLESAMPLE SYSTEM (50) REPEATABLE (2)

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT * FROM fast_emp4000
    WHERE home_base <@ '(200,200),(2000,1000)'::box
    ORDER BY (home_base[0])[0]

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT * FROM not_null_tab
WHERE id NOT IN (
    SELECT id
    FROM not_null_tab
    GROUP BY GROUPING SETS ((id), (val))
)

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT * FROM polygon_tbl WHERE f1 @> '((1,1),(2,2),(2,1))'::polygon
    ORDER BY (poly_center(f1))[0]

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab WHERE ((a > 1) IS TRUE) IS NULL

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab WHERE (a < 5 AND b IS NOT NULL AND c IS NOT NULL) IS TRUE

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab WHERE GREATEST(b, a) IS NULL

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT * FROM pred_tab WHERE GREATEST(b, c) IS NULL

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT * FROM prt1 t1 JOIN LATERAL
			  (SELECT * FROM prt1 t2 TABLESAMPLE SYSTEM (t1.a) REPEATABLE(t1.b)) s
			  ON t1.a = s.a

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT * FROM prt1 t1 LEFT JOIN LATERAL
			  (SELECT t2.a AS t2a, t3.a AS t3a, least(t1.a,t2.a,t3.b) FROM prt1 t2 JOIN prt2 t3 ON (t2.a = t3.b)) ss
			  ON t1.a = ss.t2a WHERE t1.b = 0 ORDER BY t1.a

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT * FROM prt1_l t1 JOIN LATERAL
			  (SELECT * FROM prt1_l t2 TABLESAMPLE SYSTEM (t1.a) REPEATABLE(t1.b)) s
			  ON t1.a = s.a AND t1.b = s.b AND t1.c = s.c

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT * FROM prt1_l t1 LEFT JOIN LATERAL
			  (SELECT t2.a AS t2a, t2.c AS t2c, t2.b AS t2b, t3.b AS t3b, least(t1.a,t2.a,t3.b) FROM prt1_l t2 JOIN prt2_l t3 ON (t2.a = t3.b AND t2.c = t3.c)) ss
			  ON t1.a = ss.t2a AND t1.c = ss.t2c WHERE t1.b = 0 ORDER BY t1.a

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND (j1.a*j1.a) = (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int
  AND (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int = (j2.a*j2.a)

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND j1.a = (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int
  AND (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int = j2.a

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT c, sum(a) FROM pagg_tab GROUP BY rollup(c) ORDER BY 1, 2

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT id FROM bool_tab WHERE flag_nn IS FALSE

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT id FROM bool_tab WHERE flag_nn IS NOT FALSE

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT id FROM bool_tab WHERE flag_nn IS NOT TRUE

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT id FROM bool_tab WHERE flag_nn IS NOT UNKNOWN

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT id FROM bool_tab WHERE flag_nn IS TRUE

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT id FROM bool_tab WHERE flag_nn IS UNKNOWN

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT id FROM bool_tab WHERE flag_null IS UNKNOWN

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
SELECT t1.a, ss.t2a, ss.t2c FROM prt1 t1 LEFT JOIN LATERAL
			  (SELECT t2.a AS t2a, t3.a AS t3a, t2.b t2b, t2.c t2c, least(t1.a,t2.a,t3.b) FROM prt1 t2 JOIN prt2 t3 ON (t2.a = t3.b)) ss
			  ON t1.c = ss.t2c WHERE (t1.b + coalesce(ss.t2b, 0)) = 0 ORDER BY t1.a

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF)
UPDATE current_check_2 SET b = 'Manzana' WHERE CURRENT OF current_check_cursor

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF) SELECT a, b, count(*), max(a), max(b) FROM gstest3 GROUP BY GROUPING SETS(a, b,()) ORDER BY a, b

-- sqlfmt-corpus-separator --

EXPLAIN (COSTS OFF) UPDATE current_check SET payload = payload WHERE CURRENT OF current_check_cursor

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF)
SELECT  xmltable.*
   FROM (SELECT data FROM xmldata) x,
        LATERAL XMLTABLE('/ROWS/ROW'
                         PASSING data
                         COLUMNS id int PATH '@id',
                                  _id FOR ORDINALITY,
                                  country_name text PATH 'COUNTRY_NAME' NOT NULL,
                                  country_id text PATH 'COUNTRY_ID',
                                  region_id int PATH 'REGION_ID',
                                  size float PATH 'SIZE',
                                  unit text PATH 'SIZE/@unit',
                                  premier_name text PATH 'PREMIER_NAME' DEFAULT 'not specified')

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF)
SELECT  xmltable.*
   FROM (SELECT data FROM xmldata) x,
        LATERAL XMLTABLE('/ROWS/ROW'
                         PASSING data
                         COLUMNS id int PATH '@id',
                                  _id FOR ORDINALITY,
                                  country_name text PATH 'COUNTRY_NAME' NOT NULL,
                                  country_id text PATH 'COUNTRY_ID',
                                  region_id int PATH 'REGION_ID',
                                  size float PATH 'SIZE',
                                  unit text PATH 'SIZE/@unit',
                                  premier_name text PATH 'PREMIER_NAME' DEFAULT 'not specified')
  WHERE region_id = 2

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF)
SELECT '1' IS JSON AS "any", ('1' || i) IS JSON SCALAR AS "scalar", '[]' IS NOT JSON ARRAY AS "array", '{}' IS JSON OBJECT WITH UNIQUE AS "object" FROM generate_series(1, 3) i

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF)
SELECT JSON_ARRAY('1' FORMAT JSON, 2 RETURNING json)

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF)
SELECT JSON_ARRAY(SELECT i FROM (VALUES (1), (2), (NULL), (4)) foo(i) RETURNING jsonb)

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF)
SELECT JSON_ARRAYAGG(('111' || i)::bytea FORMAT JSON NULL ON NULL RETURNING text) FILTER (WHERE i > 3)
FROM generate_series(1,5) i

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF)
SELECT JSON_ARRAYAGG(('111' || i)::bytea FORMAT JSON NULL ON NULL RETURNING text) OVER (PARTITION BY i % 2)
FROM generate_series(1,5) i

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF)
SELECT JSON_OBJECT('foo' : '1' FORMAT JSON, 'bar' : 'baz' RETURNING json)

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF)
SELECT JSON_OBJECTAGG(i: ('111' || i)::bytea FORMAT JSON WITH UNIQUE RETURNING text) FILTER (WHERE i > 3)
FROM generate_series(1,5) i

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF)
SELECT JSON_OBJECTAGG(i: ('111' || i)::bytea FORMAT JSON WITH UNIQUE RETURNING text) OVER (PARTITION BY i % 2)
FROM generate_series(1,5) i

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF)
SELECT f.* FROM xmldata, LATERAL xmltable('/ROWS/ROW[COUNTRY_NAME="Japan" or COUNTRY_NAME="India"]' PASSING data COLUMNS "COUNTRY_NAME" text, "REGION_ID" int) AS f WHERE "COUNTRY_NAME" = 'Japan'

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF)
UPDATE update_test t
  SET (a, b) = (SELECT b, a FROM update_test s WHERE s.a = t.a)
  WHERE CURRENT_USER = SESSION_USER

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF) SELECT JSON_OBJECT('a': JSON_OBJECTAGG('b': 1 RETURNING text) FORMAT JSON)

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF) SELECT JSON_OBJECT('a': JSON_OBJECTAGG('b': stable_one() RETURNING text) FORMAT JSON)

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, COSTS OFF) SELECT JSON_OBJECT('a': JSON_OBJECTAGG('b': volatile_one() RETURNING text) FORMAT JSON)

-- sqlfmt-corpus-separator --

EXPLAIN (VERBOSE, FORMAT JSON, COSTS OFF)
SELECT f.* FROM xmldata, LATERAL xmltable('/ROWS/ROW[COUNTRY_NAME="Japan" or COUNTRY_NAME="India"]' PASSING data COLUMNS "COUNTRY_NAME" text, "REGION_ID" int) AS f WHERE "COUNTRY_NAME" = 'Japan'

-- sqlfmt-corpus-separator --

EXPLAIN (verbose, costs off)
MERGE INTO tgt t
USING (SELECT *, (SELECT count(*) FROM ref r
                   WHERE r.ab = s.a + s.b
                     AND r.cd = s.c - s.d) cnt
         FROM src s) s
ON t.a = s.a AND t.b < s.cnt
WHEN MATCHED AND t.c > s.cnt THEN
  UPDATE SET (b, c) = (SELECT s.b, s.cnt)

-- sqlfmt-corpus-separator --

INSERT INTO base_tbl (id, idplus1) VALUES (3, DEFAULT)

-- sqlfmt-corpus-separator --

INSERT INTO foo (f2,f3)
  VALUES ('test', DEFAULT), ('More', 11), (upper('more'), 7+9)
  RETURNING *, f1+f3 AS sum

-- sqlfmt-corpus-separator --

INSERT INTO gtest1 VALUES (2, DEFAULT)

-- sqlfmt-corpus-separator --

INSERT INTO gtest1 VALUES (3, 33), (4, DEFAULT)

-- sqlfmt-corpus-separator --

INSERT INTO gtest1 VALUES (3, DEFAULT), (4, 44)

-- sqlfmt-corpus-separator --

INSERT INTO gtest1 VALUES (3, DEFAULT), (4, DEFAULT)

-- sqlfmt-corpus-separator --

INSERT INTO gtest1v VALUES (5, DEFAULT)

-- sqlfmt-corpus-separator --

INSERT INTO gtest1v VALUES (6, 66), (7, DEFAULT)

-- sqlfmt-corpus-separator --

INSERT INTO gtest1v VALUES (6, DEFAULT), (7, 77)

-- sqlfmt-corpus-separator --

INSERT INTO gtest1v VALUES (6, DEFAULT), (7, DEFAULT)

-- sqlfmt-corpus-separator --

INSERT INTO gtest1v VALUES (8, DEFAULT)

-- sqlfmt-corpus-separator --

INSERT INTO gtest1v VALUES (8, DEFAULT), (9, DEFAULT)

-- sqlfmt-corpus-separator --

INSERT INTO gtestnn_parent VALUES (1, 2, default)

-- sqlfmt-corpus-separator --

INSERT INTO gtestnn_parent VALUES (10, 11, default)

-- sqlfmt-corpus-separator --

INSERT INTO gtestnn_parent VALUES (2, 10, default)

-- sqlfmt-corpus-separator --

INSERT INTO gtestnn_parent VALUES (2, 2, default), (3, 5, default), (14, 12, default)

-- sqlfmt-corpus-separator --

INSERT INTO inhe VALUES ('ee-col1', 'ee-col2', DEFAULT, 'ee-col4')

-- sqlfmt-corpus-separator --

INSERT INTO itest14 (id) VALUES (DEFAULT)

-- sqlfmt-corpus-separator --

INSERT INTO itest3 VALUES (DEFAULT, 'a')

-- sqlfmt-corpus-separator --

INSERT INTO itest3 VALUES (DEFAULT, 'b'), (DEFAULT, 'c')

-- sqlfmt-corpus-separator --

INSERT INTO itest5 OVERRIDING SYSTEM VALUE VALUES (-5, 'ff'), (DEFAULT, 'gg')

-- sqlfmt-corpus-separator --

INSERT INTO itest5 OVERRIDING SYSTEM VALUE VALUES (DEFAULT, 'dd'), (-4, 'ee')

-- sqlfmt-corpus-separator --

INSERT INTO itest5 OVERRIDING SYSTEM VALUE VALUES (DEFAULT, 'hh'), (DEFAULT, 'ii')

-- sqlfmt-corpus-separator --

INSERT INTO itest5 OVERRIDING USER VALUE VALUES (-5, 'fff'), (DEFAULT, 'ggg')

-- sqlfmt-corpus-separator --

INSERT INTO itest5 OVERRIDING USER VALUE VALUES (DEFAULT, 'ddd'), (-4, 'eee')

-- sqlfmt-corpus-separator --

INSERT INTO itest5 OVERRIDING USER VALUE VALUES (DEFAULT, 'hhh'), (DEFAULT, 'iii')

-- sqlfmt-corpus-separator --

INSERT INTO itest5 VALUES (2, 'b'), (DEFAULT, 'c')

-- sqlfmt-corpus-separator --

INSERT INTO itest5 VALUES (DEFAULT, 'a')

-- sqlfmt-corpus-separator --

INSERT INTO itest5 VALUES (DEFAULT, 'b'), (3, 'c')

-- sqlfmt-corpus-separator --

INSERT INTO itest5 VALUES (DEFAULT, 'b'), (DEFAULT, 'c')

-- sqlfmt-corpus-separator --

INSERT INTO rw_view1 (id, idplus1) VALUES (4, DEFAULT)

-- sqlfmt-corpus-separator --

INSERT INTO rw_view1 (s, c, a) VALUES (default, default, 1.1)

-- sqlfmt-corpus-separator --

INSERT INTO rw_view1 VALUES (9, DEFAULT), (10, DEFAULT)

-- sqlfmt-corpus-separator --

INSERT INTO tp_0_1(i, t, b) VALUES(0, DEFAULT, 1)

-- sqlfmt-corpus-separator --

INSERT INTO tp_1_2(i, t, b) VALUES(1, DEFAULT, 2)

-- sqlfmt-corpus-separator --

INSERT INTO tp_x(i, t, b) VALUES(0, DEFAULT, 1)

-- sqlfmt-corpus-separator --

INSERT INTO tp_x(i, t, b) VALUES(1, DEFAULT, 2)

-- sqlfmt-corpus-separator --

INSERT INTO upsert_test VALUES (1, 'Bat'), (3, 'Zot') ON CONFLICT(a)
  DO UPDATE SET (b, a) = (SELECT b || ', Excluded', a from upsert_test i WHERE i.a = excluded.a)
  RETURNING *

-- sqlfmt-corpus-separator --

INSERT INTO upsert_test VALUES (1, 'Baz'), (3, 'Zaz') ON CONFLICT(a)
  DO UPDATE SET (b, a) = (SELECT b || ', Correlated', a from upsert_test i WHERE i.a = upsert_test.a)
  RETURNING *

-- sqlfmt-corpus-separator --

INSERT INTO upsert_test VALUES (2, 'Beeble') ON CONFLICT(a)
  DO UPDATE SET (b, a) = (SELECT b || ', Excluded', a from upsert_test i WHERE i.a = excluded.a)
  RETURNING tableoid::regclass, xmin = pg_current_xact_id()::xid AS xmin_correct, xmax = 0 AS xmax_correct

-- sqlfmt-corpus-separator --

INSERT INTO upsert_test VALUES (2, 'Brox') ON CONFLICT(a)
  DO UPDATE SET (b, a) = (SELECT b || ', Excluded', a from upsert_test i WHERE i.a = excluded.a)
  RETURNING tableoid::regclass, xmin = pg_current_xact_id()::xid AS xmin_correct, xmax = pg_current_xact_id()::xid AS xmax_correct

-- sqlfmt-corpus-separator --

LOCK TABLE lock_tbl1 IN ACCESS EXCLUSIVE MODE NOWAIT

-- sqlfmt-corpus-separator --

LOCK TABLE lock_tbl1 IN ACCESS SHARE MODE NOWAIT

-- sqlfmt-corpus-separator --

LOCK TABLE lock_tbl1 IN EXCLUSIVE MODE NOWAIT

-- sqlfmt-corpus-separator --

LOCK TABLE lock_tbl1 IN ROW EXCLUSIVE MODE NOWAIT

-- sqlfmt-corpus-separator --

LOCK TABLE lock_tbl1 IN ROW SHARE MODE NOWAIT

-- sqlfmt-corpus-separator --

LOCK TABLE lock_tbl1 IN SHARE MODE NOWAIT

-- sqlfmt-corpus-separator --

LOCK TABLE lock_tbl1 IN SHARE ROW EXCLUSIVE MODE NOWAIT

-- sqlfmt-corpus-separator --

LOCK TABLE lock_tbl1 IN SHARE UPDATE EXCLUSIVE MODE NOWAIT

-- sqlfmt-corpus-separator --

MERGE INTO ONLY measurement m
 USING new_measurement nm ON
      (m.city_id = nm.city_id and m.logdate=nm.logdate)
WHEN MATCHED AND nm.peaktemp IS NULL THEN DELETE
WHEN MATCHED THEN UPDATE
     SET peaktemp = greatest(m.peaktemp, nm.peaktemp),
        unitsales = m.unitsales + coalesce(nm.unitsales, 0)
WHEN NOT MATCHED THEN INSERT
     (city_id, logdate, peaktemp, unitsales)
   VALUES (city_id, logdate, peaktemp, unitsales)

-- sqlfmt-corpus-separator --

MERGE into measurement m
 USING new_measurement nm ON
      (m.city_id = nm.city_id and m.logdate=nm.logdate)
WHEN MATCHED AND nm.peaktemp IS NULL THEN DELETE
WHEN MATCHED THEN UPDATE
     SET peaktemp = greatest(m.peaktemp, nm.peaktemp),
        unitsales = m.unitsales + coalesce(nm.unitsales, 0)
WHEN NOT MATCHED THEN INSERT
     (city_id, logdate, peaktemp, unitsales)
   VALUES (city_id, logdate, peaktemp, unitsales)

-- sqlfmt-corpus-separator --

PREPARE foo (xml) AS SELECT xmlconcat('<foo/>', $1)

-- sqlfmt-corpus-separator --

PREPARE foom2 (integer, integer) AS
MERGE INTO target t
USING (SELECT 1) s
ON t.tid = $1
WHEN MATCHED THEN
UPDATE SET balance = $2

-- sqlfmt-corpus-separator --

PREPARE get_partition_info(regclass[]) AS
SELECT  c.oid::pg_catalog.regclass,
        c.relpersistence,
        c.relkind,
        i.inhdetachpending,
        pg_catalog.pg_get_expr(c.relpartbound, c.oid)
FROM    pg_catalog.pg_class c, pg_catalog.pg_inherits i
WHERE   c.oid = i.inhrelid AND i.inhparent = ANY($1)
ORDER BY pg_catalog.pg_get_expr(c.relpartbound, c.oid) = 'DEFAULT',
         c.oid::regclass::text COLLATE "C"

-- sqlfmt-corpus-separator --

PREPARE ins(int, int[]) AS INSERT INTO rw_view1 VALUES($1, $2)

-- sqlfmt-corpus-separator --

PREPARE p1 AS SELECT $0_1

-- sqlfmt-corpus-separator --

PREPARE p1 AS SELECT $1a

-- sqlfmt-corpus-separator --

PREPARE p1 AS SELECT $2147483648

-- sqlfmt-corpus-separator --

PREPARE p1(int) AS SELECT * FROM t1 WHERE a <= $1

-- sqlfmt-corpus-separator --

PREPARE p2(int) AS SELECT * FROM t1 WHERE a = $1

-- sqlfmt-corpus-separator --

PREPARE pp AS
SELECT  xmltable.*
   FROM (SELECT data FROM xmldata) x,
        LATERAL XMLTABLE('/ROWS/ROW'
                         PASSING data
                         COLUMNS id int PATH '@id',
                                  _id FOR ORDINALITY,
                                  country_name text PATH 'COUNTRY_NAME' NOT NULL,
                                  country_id text PATH 'COUNTRY_ID',
                                  region_id int PATH 'REGION_ID',
                                  size float PATH 'SIZE',
                                  unit text PATH 'SIZE/@unit',
                                  premier_name text PATH 'PREMIER_NAME' DEFAULT 'not specified')

-- sqlfmt-corpus-separator --

PREPARE prepstmt2(bigint) AS SELECT * FROM pcachetest WHERE q1 = $1

-- sqlfmt-corpus-separator --

PREPARE pstmt(text, int[]) AS SELECT * FROM fooarr WHERE f1 = $1 AND f2 = $2

-- sqlfmt-corpus-separator --

PREPARE q2(text) AS
	SELECT datname, datistemplate, datallowconn
	FROM pg_database WHERE datname = $1

-- sqlfmt-corpus-separator --

PREPARE q3(text, int, float, boolean, smallint) AS
	SELECT * FROM tenk1 WHERE string4 = $1 AND (four = $2 OR
	ten = $3::bigint OR true = $4 OR odd = $5::int)
	ORDER BY unique1

-- sqlfmt-corpus-separator --

PREPARE q4(nonexistenttype) AS SELECT $1

-- sqlfmt-corpus-separator --

PREPARE q5(int, text) AS
	SELECT * FROM tenk1 WHERE unique1 = $1 OR stringu1 = $2
	ORDER BY unique1

-- sqlfmt-corpus-separator --

PREPARE q6 AS
    SELECT * FROM tenk1 WHERE unique1 = $1 AND stringu1 = $2

-- sqlfmt-corpus-separator --

PREPARE q7(unknown) AS
    SELECT * FROM road WHERE thepath = $1

-- sqlfmt-corpus-separator --

PREPARE q8 AS
    UPDATE tenk1 SET stringu1 = $2 WHERE unique1 = $1

-- sqlfmt-corpus-separator --

PREPARE selectsource(int) AS SELECT $1

-- sqlfmt-corpus-separator --

PREPARE test (int, numeric, text) AS
  SELECT ten FROM onek WHERE sin(two) * four / ($3::real) IN (VALUES (sin($2)), (2), ($1))

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE pg_global) INDEX CONCURRENTLY regress_tblspace_test_tbl_idx

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE pg_global) INDEX regress_tblspace_test_tbl_idx

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE pg_global) TABLE CONCURRENTLY pg_authid

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE pg_global) TABLE pg_authid

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace) INDEX CONCURRENTLY pg_toast.pg_toast_1262_index

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace) INDEX pg_toast.pg_toast_1262_index

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace) INDEX regress_tblspace_test_tbl_idx

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace) TABLE CONCURRENTLY pg_am

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace) TABLE CONCURRENTLY pg_authid

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace) TABLE CONCURRENTLY pg_toast.pg_toast_1262

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace) TABLE pg_am

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace) TABLE pg_authid

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace) TABLE pg_toast.pg_toast_1262

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace) TABLE regress_tblspace_test_tbl

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace) TABLE tablespace_table

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace, CONCURRENTLY) TABLE regress_tblspace_test_tbl

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace, CONCURRENTLY) TABLE tablespace_table

-- sqlfmt-corpus-separator --

REINDEX (TABLESPACE regress_tblspace, CONCURRENTLY) TABLE tbspace_reindex_part

-- sqlfmt-corpus-separator --

ROLLBACK AND CHAIN

-- sqlfmt-corpus-separator --

SELECT	JSON_ARRAYAGG(NULL NULL ON NULL),
		JSON_ARRAYAGG(NULL NULL ON NULL RETURNING jsonb)
FROM generate_series(1, 5)

-- sqlfmt-corpus-separator --

SELECT	JSON_ARRAYAGG(NULL),
		JSON_ARRAYAGG(NULL RETURNING jsonb)
FROM generate_series(1, 5)

-- sqlfmt-corpus-separator --

SELECT	JSON_ARRAYAGG(i) IS NULL,
		JSON_ARRAYAGG(i RETURNING jsonb) IS NULL
FROM generate_series(1, 0) i

-- sqlfmt-corpus-separator --

SELECT	JSON_ARRAYAGG(i),
		JSON_ARRAYAGG(i RETURNING jsonb)
FROM generate_series(1, 5) i

-- sqlfmt-corpus-separator --

SELECT	JSON_OBJECTAGG('key': 1) IS NULL,
		JSON_OBJECTAGG('key': 1 RETURNING jsonb) IS NULL
WHERE FALSE

-- sqlfmt-corpus-separator --

SELECT
	JSON_OBJECTAGG(i: i),
	JSON_OBJECTAGG(i: i RETURNING jsonb)
FROM
	generate_series(1, 5) i

-- sqlfmt-corpus-separator --

SELECT
	JSON_OBJECTAGG(k: v),
	JSON_OBJECTAGG(k: v NULL ON NULL),
	JSON_OBJECTAGG(k: v ABSENT ON NULL),
	JSON_OBJECTAGG(k: v RETURNING jsonb),
	JSON_OBJECTAGG(k: v NULL ON NULL RETURNING jsonb),
	JSON_OBJECTAGG(k: v ABSENT ON NULL RETURNING jsonb)
FROM
	(VALUES (1, 1), (1, NULL), (2, NULL), (3, 3)) foo(k, v)

-- sqlfmt-corpus-separator --

SELECT
	js,
	js IS JSON "IS JSON",
	js IS NOT JSON "IS NOT JSON",
	js IS JSON VALUE "IS VALUE",
	js IS JSON OBJECT "IS OBJECT",
	js IS JSON ARRAY "IS ARRAY",
	js IS JSON SCALAR "IS SCALAR",
	js IS JSON WITHOUT UNIQUE KEYS "WITHOUT UNIQUE",
	js IS JSON WITH UNIQUE KEYS "WITH UNIQUE"
FROM
	(SELECT js::json FROM test_is_json WHERE js IS JSON) foo(js)

-- sqlfmt-corpus-separator --

SELECT
	js,
	js IS JSON "IS JSON",
	js IS NOT JSON "IS NOT JSON",
	js IS JSON VALUE "IS VALUE",
	js IS JSON OBJECT "IS OBJECT",
	js IS JSON ARRAY "IS ARRAY",
	js IS JSON SCALAR "IS SCALAR",
	js IS JSON WITHOUT UNIQUE KEYS "WITHOUT UNIQUE",
	js IS JSON WITH UNIQUE KEYS "WITH UNIQUE"
FROM
	(SELECT js::jsonb FROM test_is_json WHERE js IS JSON) foo(js)

-- sqlfmt-corpus-separator --

SELECT
	js,
	js IS JSON "IS JSON",
	js IS NOT JSON "IS NOT JSON",
	js IS JSON VALUE "IS VALUE",
	js IS JSON OBJECT "IS OBJECT",
	js IS JSON ARRAY "IS ARRAY",
	js IS JSON SCALAR "IS SCALAR",
	js IS JSON WITHOUT UNIQUE KEYS "WITHOUT UNIQUE",
	js IS JSON WITH UNIQUE KEYS "WITH UNIQUE"
FROM
	test_is_json

-- sqlfmt-corpus-separator --

SELECT
	js0,
	js IS JSON "IS JSON",
	js IS NOT JSON "IS NOT JSON",
	js IS JSON VALUE "IS VALUE",
	js IS JSON OBJECT "IS OBJECT",
	js IS JSON ARRAY "IS ARRAY",
	js IS JSON SCALAR "IS SCALAR",
	js IS JSON WITHOUT UNIQUE KEYS "WITHOUT UNIQUE",
	js IS JSON WITH UNIQUE KEYS "WITH UNIQUE"
FROM
	(SELECT js, js::bytea FROM test_is_json WHERE js IS JSON) foo(js0, js)

-- sqlfmt-corpus-separator --

SELECT
    (array_agg(id ORDER BY id DESC NULLS FIRST))[0:5],
    (array_agg(abort_increasing ORDER BY abort_increasing DESC NULLS LAST))[0:5],
    (array_agg(id::text ORDER BY id::text DESC NULLS LAST))[0:5],
    percentile_disc(0.99) WITHIN GROUP (ORDER BY id),
    percentile_disc(0.01) WITHIN GROUP (ORDER BY id),
    percentile_disc(0.8) WITHIN GROUP (ORDER BY abort_increasing),
    percentile_disc(0.2) WITHIN GROUP (ORDER BY id::text),
    rank('00000000-0000-0000-0000-000000000000', '2', '2') WITHIN GROUP (ORDER BY noabort_increasing, id, id::text)
FROM (
    SELECT * FROM abbrev_abort_uuids
    UNION ALL
    SELECT NULL, NULL, NULL, NULL, NULL) s

-- sqlfmt-corpus-separator --

SELECT
    d,
    b IS TRUE AS istrue,
    b IS NOT TRUE AS isnottrue,
    b IS FALSE AS isfalse,
    b IS NOT FALSE AS isnotfalse,
    b IS UNKNOWN AS isunknown,
    b IS NOT UNKNOWN AS isnotunknown
FROM booltbl3 ORDER BY o

-- sqlfmt-corpus-separator --

SELECT  xmltable.*
   FROM (SELECT data FROM xmldata) x,
        LATERAL XMLTABLE('/ROWS/ROW'
                         PASSING data
                         COLUMNS id int PATH '@id',
                                  _id FOR ORDINALITY,
                                  country_name text PATH 'COUNTRY_NAME' NOT NULL,
                                  country_id text PATH 'COUNTRY_ID',
                                  region_id int PATH 'REGION_ID',
                                  size float PATH 'SIZE' NOT NULL,
                                  unit text PATH 'SIZE/@unit',
                                  premier_name text PATH 'PREMIER_NAME' DEFAULT 'not specified')

-- sqlfmt-corpus-separator --

SELECT  xmltable.*
   FROM (SELECT data FROM xmldata) x,
        LATERAL XMLTABLE('/ROWS/ROW'
                         PASSING data
                         COLUMNS id int PATH '@id',
                                  _id FOR ORDINALITY,
                                  country_name text PATH 'COUNTRY_NAME' NOT NULL,
                                  country_id text PATH 'COUNTRY_ID',
                                  region_id int PATH 'REGION_ID',
                                  size float PATH 'SIZE',
                                  unit text PATH 'SIZE/@unit',
                                  premier_name text PATH 'PREMIER_NAME' DEFAULT 'not specified')

-- sqlfmt-corpus-separator --

SELECT  xmltable.*
   FROM (SELECT data FROM xmldata) x,
        LATERAL XMLTABLE('/ROWS/ROW'
                         PASSING data
                         COLUMNS id int PATH '@id',
                                  _id FOR ORDINALITY,
                                  country_name text PATH 'COUNTRY_NAME' NOT NULL,
                                  country_id text PATH 'COUNTRY_ID',
                                  region_id int PATH 'REGION_ID',
                                  size float PATH 'SIZE',
                                  unit text PATH 'SIZE/@unit',
                                  premier_name text PATH 'PREMIER_NAME' DEFAULT 'not specified')
  WHERE region_id = 2

-- sqlfmt-corpus-separator --

SELECT  xmltable.*
   FROM (SELECT data FROM xmldata) x,
        LATERAL XMLTABLE('/ROWS/ROW'
                         PASSING data
                         COLUMNS id int PATH '@id',
                                  _id FOR ORDINALITY,
                                  country_name text PATH 'COUNTRY_NAME/text()' NOT NULL,
                                  country_id text PATH 'COUNTRY_ID',
                                  region_id int PATH 'REGION_ID',
                                  size float PATH 'SIZE',
                                  unit text PATH 'SIZE/@unit',
                                  premier_name text PATH 'PREMIER_NAME' DEFAULT 'not specified')

-- sqlfmt-corpus-separator --

SELECT '' IS JSON

-- sqlfmt-corpus-separator --

SELECT '<>' IS NOT DOCUMENT

-- sqlfmt-corpus-separator --

SELECT ('{red,green,blue}'::rainbow[])[2]

-- sqlfmt-corpus-separator --

SELECT ('{{{1},{2},{3}},{{4},{5},{6}}}'::int[])[1][1:NULL][1]

-- sqlfmt-corpus-separator --

SELECT ('{{{1},{2},{3}},{{4},{5},{6}}}'::int[])[1][NULL:1][1]

-- sqlfmt-corpus-separator --

SELECT ('{{{1},{2},{3}},{{4},{5},{6}}}'::int[])[1][NULL][1]

-- sqlfmt-corpus-separator --

SELECT ('{}'::int[])[1][2][3][4][5][6][7]

-- sqlfmt-corpus-separator --

SELECT (((SELECT ARRAY[1,2,3])))[3]

-- sqlfmt-corpus-separator --

SELECT ((SELECT ARRAY[1,2,3]))[2]

-- sqlfmt-corpus-separator --

SELECT (NULL::compositetable).a

-- sqlfmt-corpus-separator --

SELECT (NULL::compositetable).nonexistent

-- sqlfmt-corpus-separator --

SELECT (NULL::compositetable).oid

-- sqlfmt-corpus-separator --

SELECT (SELECT ARRAY[1,2,3])[1]

-- sqlfmt-corpus-separator --

SELECT (array[1,2])[(SELECT g.i):(SELECT g.i + 1)] FROM generate_series(1, 1) g(i)

-- sqlfmt-corpus-separator --

SELECT (array[1,2])[(SELECT g.i)] FROM generate_series(1, 1) g(i)

-- sqlfmt-corpus-separator --

SELECT (current_schemas(true))[1] = ('pg_temp_' || beid::text) AS match
FROM pg_stat_get_backend_idset() beid
WHERE pg_stat_get_backend_pid(beid) = pg_backend_pid()

-- sqlfmt-corpus-separator --

SELECT (d).a, (d).b FROM (SELECT compositetable AS d FROM compositetable) s

-- sqlfmt-corpus-separator --

SELECT (d).ctid FROM (SELECT compositetable AS d FROM compositetable) s

-- sqlfmt-corpus-separator --

SELECT (json_populate_record(NULL::jsrec, js)).* FROM jspoptest

-- sqlfmt-corpus-separator --

SELECT (jsonb_populate_record(NULL::jsbrec, js)).* FROM jsbpoptest

-- sqlfmt-corpus-separator --

SELECT (now())[1]

-- sqlfmt-corpus-separator --

SELECT (p.hobbies).equipment.name, name(p.hobbies), p.name FROM ONLY person p

-- sqlfmt-corpus-separator --

SELECT (p.hobbies).equipment.name, p.name, name(p.hobbies) FROM person* p

-- sqlfmt-corpus-separator --

SELECT (pg_identify_object(classid, objid, objsubid)).*
    FROM pg_depend
    WHERE refclassid = 'pg_class'::regclass AND
          refobjid = 'create_property_graph_tests.g2'::regclass
    ORDER BY 1, 2, 3, 4

-- sqlfmt-corpus-separator --

SELECT (pg_identify_object_as_address(classid, objid, objsubid)).*
    FROM pg_depend
    WHERE refclassid = 'pg_class'::regclass AND
          refobjid = 'create_property_graph_tests.g2'::regclass
    ORDER BY 1, 2, 3

-- sqlfmt-corpus-separator --

SELECT (string_to_array(polqual, ':'))[7] AS inputcollid FROM pg_policy WHERE polrelid = 'coll_t'::regclass

-- sqlfmt-corpus-separator --

SELECT *
   FROM arrtest
   WHERE a[1] < 5 and
         c = '{"foobar"}'::_name

-- sqlfmt-corpus-separator --

SELECT * FROM
  ( SELECT oid AS cfgid, (ts_token_type(cfgparser)).tokid AS tokid
    FROM pg_ts_config ) AS tt
RIGHT JOIN pg_ts_config_map AS m
    ON (tt.cfgid=m.mapcfg AND tt.tokid=m.maptokentype)
WHERE
    tt.cfgid IS NULL OR tt.tokid IS NULL

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM( getrngfunc6(1) AS (rngfuncid int, rngfuncsubid int, rngfuncname text) ) WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT * FROM ROWS FROM( getrngfunc7(1) AS (rngfuncid int, rngfuncsubid int, rngfuncname text) ) WITH ORDINALITY

-- sqlfmt-corpus-separator --

SELECT * FROM XMLTABLE (ROW () PASSING null COLUMNS v1 timestamp) AS f (v1, v2)

-- sqlfmt-corpus-separator --

SELECT * FROM XMLTABLE('*' PASSING '<a>a</a>' COLUMNS a xml PATH '.', b text PATH '.', c text PATH '"hi"', d boolean PATH '. = "a"', e integer PATH 'string-length(.)')

-- sqlfmt-corpus-separator --

SELECT * FROM XMLTABLE('.'
                       PASSING '<foo/>'
                       COLUMNS a text PATH 'foo/namespace::node()')

-- sqlfmt-corpus-separator --

SELECT * FROM XMLTABLE(XMLNAMESPACES('http://x.y' AS zz),
                      '/zz:rows/zz:row'
                      PASSING '<rows xmlns="http://x.y"><row><a>10</a></row></rows>'
                      COLUMNS a int PATH 'zz:a')

-- sqlfmt-corpus-separator --

SELECT * FROM document TABLESAMPLE BERNOULLI(50) REPEATABLE(0)
  WHERE f_leak(dtitle) ORDER BY did

-- sqlfmt-corpus-separator --

SELECT * FROM fast_emp4000
    WHERE home_base <@ '(200,200),(2000,1000)'::box
    ORDER BY (home_base[0])[0]

-- sqlfmt-corpus-separator --

SELECT * FROM polygon_tbl WHERE f1 @> '((1,1),(2,2),(2,1))'::polygon
    ORDER BY (poly_center(f1))[0]

-- sqlfmt-corpus-separator --

SELECT * FROM pred_tab WHERE (a < 5 AND b IS NOT NULL AND c IS NOT NULL) IS TRUE

-- sqlfmt-corpus-separator --

SELECT * FROM prt1 t1 LEFT JOIN LATERAL
			  (SELECT t2.a AS t2a, t3.a AS t3a, least(t1.a,t2.a,t3.b) FROM prt1 t2 JOIN prt2 t3 ON (t2.a = t3.b)) ss
			  ON t1.a = ss.t2a WHERE t1.b = 0 ORDER BY t1.a

-- sqlfmt-corpus-separator --

SELECT * FROM prt1_l t1 LEFT JOIN LATERAL
			  (SELECT t2.a AS t2a, t2.c AS t2c, t2.b AS t2b, t3.b AS t3b, least(t1.a,t2.a,t3.b) FROM prt1_l t2 JOIN prt2_l t3 ON (t2.a = t3.b AND t2.c = t3.c)) ss
			  ON t1.a = ss.t2a AND t1.c = ss.t2c WHERE t1.b = 0 ORDER BY t1.a

-- sqlfmt-corpus-separator --

SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND (j1.a*j1.a) = (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int
  AND (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int = (j2.a*j2.a)

-- sqlfmt-corpus-separator --

SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND j1.a = (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int
  AND (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int = j2.a

-- sqlfmt-corpus-separator --

SELECT * FROM xmltable('/root' passing '<root><element>a1a<!-- aaaa -->a2a<?aaaaa?> <!--z-->  bbbb<x>xxx</x>cccc</element></root>' COLUMNS element text PATH 'element/text()')

-- sqlfmt-corpus-separator --

SELECT * FROM xmltable('/root' passing '<root><element>a1a<!-- aaaa -->a2a<?aaaaa?> <!--z-->  bbbb<x>xxx</x>cccc</element></root>' COLUMNS element text)

-- sqlfmt-corpus-separator --

SELECT *, (equipment(CAST((h.*) AS hobbies_r))).name FROM hobbies_r h

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[0]::regtype, p2.proargtypes[0]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    p1.prosrc NOT LIKE E'range\\_constructor_' AND
    p2.prosrc NOT LIKE E'range\\_constructor_' AND
    p1.prosrc NOT LIKE E'multirange\\_constructor_' AND
    p2.prosrc NOT LIKE E'multirange\\_constructor_' AND
    (p1.proargtypes[0] < p2.proargtypes[0])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[1]::regtype, p2.proargtypes[1]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    p1.prosrc NOT LIKE E'range\\_constructor_' AND
    p2.prosrc NOT LIKE E'range\\_constructor_' AND
    p1.prosrc NOT LIKE E'multirange\\_constructor_' AND
    p2.prosrc NOT LIKE E'multirange\\_constructor_' AND
    (p1.proargtypes[1] < p2.proargtypes[1])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[2]::regtype, p2.proargtypes[2]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    (p1.proargtypes[2] < p2.proargtypes[2])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[3]::regtype, p2.proargtypes[3]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    (p1.proargtypes[3] < p2.proargtypes[3])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[4]::regtype, p2.proargtypes[4]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    (p1.proargtypes[4] < p2.proargtypes[4])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[5]::regtype, p2.proargtypes[5]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    (p1.proargtypes[5] < p2.proargtypes[5])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[6]::regtype, p2.proargtypes[6]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    (p1.proargtypes[6] < p2.proargtypes[6])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT DISTINCT p1.proargtypes[7]::regtype, p2.proargtypes[7]::regtype
FROM pg_proc AS p1, pg_proc AS p2
WHERE p1.oid != p2.oid AND
    p1.prosrc = p2.prosrc AND
    p1.prolang = 12 AND p2.prolang = 12 AND
    p1.prokind != 'a' AND p2.prokind != 'a' AND
    (p1.proargtypes[7] < p2.proargtypes[7])
ORDER BY 1, 2

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY('a',  NULL, 'b' ABSENT ON NULL RETURNING jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY('a',  NULL, 'b' ABSENT ON NULL)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY('a',  NULL, 'b' NULL   ON NULL RETURNING jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY('a',  NULL, 'b' NULL   ON NULL)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY('aaa', 111, true, array[1,2,3], NULL, json '{"a": [1]}', jsonb '["a",3]')

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY()

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(JSON_ARRAY('{ "a" : 123 }' FORMAT JSON RETURNING text) FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(JSON_ARRAY('{ "a" : 123 }' FORMAT JSON RETURNING text))

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(JSON_ARRAY('{ "a" : 123 }' RETURNING text))

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(JSON_ARRAY('{ "a" : 123 }' RETURNING varchar(2)))

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(NULL, NULL, 'b' ABSENT ON NULL RETURNING jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(NULL, NULL, 'b' ABSENT ON NULL)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(RETURNING bytea FORMAT JSON ENCODING UTF16)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(RETURNING bytea FORMAT JSON ENCODING UTF32)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(RETURNING bytea FORMAT JSON ENCODING UTF8)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(RETURNING bytea FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(RETURNING bytea)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(RETURNING json FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(RETURNING json)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(RETURNING jsonb FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(RETURNING jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(RETURNING text FORMAT JSON ENCODING UTF8)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(RETURNING text FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(RETURNING text)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(SELECT * FROM (VALUES (1, 2)) foo(i, j))

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(SELECT FROM (VALUES (1)) foo(i))

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(SELECT i FROM (VALUES (1), (2), (NULL), (4)) foo(i))

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(SELECT i FROM (VALUES (3), (1), (NULL), (2)) foo(i) ORDER BY i)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(SELECT i FROM (VALUES (NULL::int[]), ('{1,2}'), (NULL), (NULL), ('{3,4}'), (NULL)) foo(i) RETURNING jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(SELECT i FROM (VALUES (NULL::int[]), ('{1,2}'), (NULL), (NULL), ('{3,4}'), (NULL)) foo(i))

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(SELECT i, i FROM (VALUES (1)) foo(i))

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAY(WITH x AS (SELECT 1) VALUES (TRUE))

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAYAGG(('111' || i)::bytea FORMAT JSON NULL ON NULL RETURNING varchar(2)) FROM generate_series(1,1) i

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAYAGG(JSON_ARRAY(i, i + 1 RETURNING text) FORMAT JSON)
FROM generate_series(1, 5) i

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAYAGG(i ORDER BY i DESC)
FROM generate_series(1, 5) i

-- sqlfmt-corpus-separator --

SELECT JSON_ARRAYAGG(i::text::json)
FROM generate_series(1, 5) i

-- sqlfmt-corpus-separator --

SELECT JSON_EXISTS(JSON_OBJECT(RETURNING jsonb), '$')

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(
	'a': '123',
	1.23: 123,
	'c': json '[ 1,true,{ } ]',
	'd': jsonb '{ "x" : 123.45 }'
	RETURNING jsonb
)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(
	'a': '123',
	1.23: 123,
	'c': json '[ 1,true,{ } ]',
	'd': jsonb '{ "x" : 123.45 }'
)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a' VALUE 2 + 3)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a' VALUE 2::text)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a' || 2: 1)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': '1', 'b': NULL, 'c': 2 ABSENT ON NULL)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': '1', 'b': NULL, 'c': 2 NULL ON NULL)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': '1', 'b': NULL, 'c': 2)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': '123', 'b': JSON_OBJECT('a': 111, 'b': 'aaa' RETURNING jsonb))

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': 2 + 3)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': 2::text)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': JSON_OBJECT('b': 1 RETURNING bytea) FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': JSON_OBJECT('b': 1 RETURNING bytea))

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': JSON_OBJECT('b': 1 RETURNING text) FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': JSON_OBJECT('b': 1 RETURNING text))

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': JSON_OBJECT('b': 1 RETURNING varchar(2)))

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': JSON_OBJECTAGG('b': 1 RETURNING text) FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': JSON_OBJECTAGG('b': stable_one() RETURNING text) FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('a': JSON_OBJECTAGG('b': volatile_one() RETURNING text) FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('foo': NULL::int FORMAT JSON ENCODING UTF8)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('foo': NULL::int FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('foo': NULL::json FORMAT JSON ENCODING UTF8)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('foo': NULL::json FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('foo': NULL::jsonb FORMAT JSON ENCODING UTF8)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('foo': NULL::jsonb FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT('happy'::mood: '123'::jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(('a' || 2) VALUE 1)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT((1::text) VALUE 2)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT()

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(1: 1, '1': NULL ABSENT ON NULL WITH UNIQUE RETURNING jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(1: 1, '1': NULL ABSENT ON NULL WITH UNIQUE)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(1: 1, '1': NULL NULL ON NULL WITH UNIQUE RETURNING jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(1: 1, '1': NULL WITH UNIQUE)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(1: 1, '2': NULL, '1': 1 ABSENT ON NULL WITH UNIQUE RETURNING jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(1: 1, '2': NULL, '1': 1 ABSENT ON NULL WITH UNIQUE)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(1: 1, '2': NULL, '1': 1 ABSENT ON NULL WITHOUT UNIQUE RETURNING jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(1: 1, '2': NULL, '1': 1 ABSENT ON NULL WITHOUT UNIQUE)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(1: 1, '2': NULL, '1': 1 NULL ON NULL WITH UNIQUE)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(1: 1, '2': NULL, '3': 1, 4: NULL, '5': 'a' ABSENT ON NULL WITH UNIQUE RETURNING jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(1: 1, '2': NULL, '3': 1, repeat('x', 1000): 1, 2: repeat('a', 100) WITH UNIQUE)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(1::text: 2)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(ARRAY[1,2,3]: 'aaa')

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(NULL: 1)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(RETURNING bytea FORMAT JSON ENCODING UTF16)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(RETURNING bytea FORMAT JSON ENCODING UTF32)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(RETURNING bytea FORMAT JSON ENCODING UTF8)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(RETURNING bytea FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(RETURNING bytea)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(RETURNING json FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(RETURNING json)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(RETURNING jsonb FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(RETURNING jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(RETURNING text FORMAT JSON ENCODING UTF8)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(RETURNING text FORMAT JSON)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(RETURNING text)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECT(json '[1]': 123)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECTAGG(NULL: 1 RETURNING jsonb)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECTAGG(NULL: 1)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECTAGG(i: ('111' || i)::bytea FORMAT JSON WITH UNIQUE RETURNING varchar(2)) FROM generate_series(1, 1) i

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECTAGG(k: v ABSENT ON NULL WITH UNIQUE KEYS RETURNING jsonb)
FROM (VALUES (1, 1), (0, NULL),(4, null), (5, null),(6, null),(2, 2)) foo(k, v)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECTAGG(k: v ABSENT ON NULL WITH UNIQUE KEYS RETURNING jsonb)
FROM (VALUES (1, 1), (1, NULL), (2, 2)) foo(k, v)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECTAGG(k: v ABSENT ON NULL WITH UNIQUE KEYS)
FROM (VALUES (1, 1), (0, NULL), (3, NULL), (2, 2), (4, NULL)) foo(k, v)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECTAGG(k: v ABSENT ON NULL WITH UNIQUE KEYS)
FROM (VALUES (1, 1), (1, NULL), (2, 2)) foo(k, v)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECTAGG(k: v WITH UNIQUE KEYS RETURNING jsonb)
FROM (VALUES (1, 1), (1, NULL), (2, 2)) foo(k, v)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECTAGG(k: v WITH UNIQUE KEYS)
FROM (VALUES (1, 1), (1, NULL), (2, 2)) foo(k, v)

-- sqlfmt-corpus-separator --

SELECT JSON_OBJECTAGG(mod(i,100): (i)::text FORMAT JSON WITH UNIQUE)
FROM generate_series(0, 199) i

-- sqlfmt-corpus-separator --

SELECT NULL IS JSON

-- sqlfmt-corpus-separator --

SELECT NULL IS NOT JSON

-- sqlfmt-corpus-separator --

SELECT NULL::bytea IS JSON

-- sqlfmt-corpus-separator --

SELECT NULL::int IS JSON

-- sqlfmt-corpus-separator --

SELECT NULL::jd1 IS JSON, NULL::jd2 IS JSON, NULL::jd3 IS JSON, NULL::jd4 IS JSON

-- sqlfmt-corpus-separator --

SELECT NULL::jd1 IS NOT JSON

-- sqlfmt-corpus-separator --

SELECT NULL::jd5 IS JSON

-- sqlfmt-corpus-separator --

SELECT NULL::jd5 IS JSON WITH UNIQUE KEYS

-- sqlfmt-corpus-separator --

SELECT NULL::json IS JSON

-- sqlfmt-corpus-separator --

SELECT NULL::jsonb IS JSON

-- sqlfmt-corpus-separator --

SELECT NULL::text IS JSON

-- sqlfmt-corpus-separator --

SELECT a FROM arrtest WHERE a[2] IS NULL

-- sqlfmt-corpus-separator --

SELECT a, b, count(*), max(a), max(b) FROM gstest3 GROUP BY GROUPING SETS(a, b,()) ORDER BY a, b

-- sqlfmt-corpus-separator --

SELECT a, b, greatest(b, 'CCC') FROM collate_test1 ORDER BY 3

-- sqlfmt-corpus-separator --

SELECT a, b, greatest(b, 'CCC') FROM collate_test2 ORDER BY 3

-- sqlfmt-corpus-separator --

SELECT a, b, greatest(b, 'CCC') FROM collate_test3 ORDER BY 3

-- sqlfmt-corpus-separator --

SELECT a, x, y, lower(greatest(x, 'foo')), lower(greatest(y, 'foo')) FROM collate_test10

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid, p.proname
FROM pg_aggregate as a, pg_proc as p
WHERE a.aggcombinefn = p.oid AND
    (p.pronargs != 2 OR
     p.prorettype != p.proargtypes[0] OR
     p.prorettype != p.proargtypes[1] OR
     NOT binary_coercible(a.aggtranstype, p.proargtypes[0]))

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid::oid, o.oid
FROM pg_operator AS o, pg_aggregate AS a, pg_proc AS p
WHERE a.aggfnoid = p.oid AND a.aggsortop = o.oid AND
    (oprkind != 'b' OR oprresult != 'boolean'::regtype
     OR oprleft != p.proargtypes[0] OR oprright != p.proargtypes[0])

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid::oid, p.proname, pfn.oid, pfn.proname
FROM pg_aggregate AS a, pg_proc AS p, pg_proc AS pfn
WHERE a.aggfnoid = p.oid AND
    a.aggfinalfn = pfn.oid AND
    (pfn.proretset OR
     NOT binary_coercible(pfn.prorettype, p.prorettype) OR
     NOT binary_coercible(a.aggtranstype, pfn.proargtypes[0]) OR
     CASE WHEN a.aggfinalextra THEN pfn.pronargs != p.pronargs + 1
          ELSE pfn.pronargs != a.aggnumdirectargs + 1 END
     OR (pfn.pronargs > 1 AND
         NOT binary_coercible(p.proargtypes[0], pfn.proargtypes[1]))
     OR (pfn.pronargs > 2 AND
         NOT binary_coercible(p.proargtypes[1], pfn.proargtypes[2]))
     OR (pfn.pronargs > 3 AND
         NOT binary_coercible(p.proargtypes[2], pfn.proargtypes[3]))
     OR (pfn.pronargs > 4)
    )

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid::oid, p.proname, pfn.oid, pfn.proname
FROM pg_aggregate AS a, pg_proc AS p, pg_proc AS pfn
WHERE a.aggfnoid = p.oid AND
    a.aggmfinalfn = pfn.oid AND
    (pfn.proretset OR
     NOT binary_coercible(pfn.prorettype, p.prorettype) OR
     NOT binary_coercible(a.aggmtranstype, pfn.proargtypes[0]) OR
     CASE WHEN a.aggmfinalextra THEN pfn.pronargs != p.pronargs + 1
          ELSE pfn.pronargs != a.aggnumdirectargs + 1 END
     OR (pfn.pronargs > 1 AND
         NOT binary_coercible(p.proargtypes[0], pfn.proargtypes[1]))
     OR (pfn.pronargs > 2 AND
         NOT binary_coercible(p.proargtypes[1], pfn.proargtypes[2]))
     OR (pfn.pronargs > 3 AND
         NOT binary_coercible(p.proargtypes[2], pfn.proargtypes[3]))
     OR (pfn.pronargs > 4)
    )

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid::oid, p.proname, ptr.oid, ptr.proname
FROM pg_aggregate AS a, pg_proc AS p, pg_proc AS ptr
WHERE a.aggfnoid = p.oid AND
    a.aggminvtransfn = ptr.oid AND
    (ptr.proretset
     OR NOT (ptr.pronargs =
             CASE WHEN a.aggkind = 'n' THEN p.pronargs + 1
             ELSE greatest(p.pronargs - a.aggnumdirectargs, 1) + 1 END)
     OR NOT binary_coercible(ptr.prorettype, a.aggmtranstype)
     OR NOT binary_coercible(a.aggmtranstype, ptr.proargtypes[0])
     OR (p.pronargs > 0 AND
         NOT binary_coercible(p.proargtypes[0], ptr.proargtypes[1]))
     OR (p.pronargs > 1 AND
         NOT binary_coercible(p.proargtypes[1], ptr.proargtypes[2]))
     OR (p.pronargs > 2 AND
         NOT binary_coercible(p.proargtypes[2], ptr.proargtypes[3]))
     OR (p.pronargs > 3)
    )

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid::oid, p.proname, ptr.oid, ptr.proname
FROM pg_aggregate AS a, pg_proc AS p, pg_proc AS ptr
WHERE a.aggfnoid = p.oid AND
    a.aggmtransfn = ptr.oid AND
    (ptr.proretset
     OR NOT (ptr.pronargs =
             CASE WHEN a.aggkind = 'n' THEN p.pronargs + 1
             ELSE greatest(p.pronargs - a.aggnumdirectargs, 1) + 1 END)
     OR NOT binary_coercible(ptr.prorettype, a.aggmtranstype)
     OR NOT binary_coercible(a.aggmtranstype, ptr.proargtypes[0])
     OR (p.pronargs > 0 AND
         NOT binary_coercible(p.proargtypes[0], ptr.proargtypes[1]))
     OR (p.pronargs > 1 AND
         NOT binary_coercible(p.proargtypes[1], ptr.proargtypes[2]))
     OR (p.pronargs > 2 AND
         NOT binary_coercible(p.proargtypes[2], ptr.proargtypes[3]))
     OR (p.pronargs > 3)
    )

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid::oid, p.proname, ptr.oid, ptr.proname
FROM pg_aggregate AS a, pg_proc AS p, pg_proc AS ptr
WHERE a.aggfnoid = p.oid AND
    a.aggmtransfn = ptr.oid AND ptr.proisstrict AND
    a.aggminitval IS NULL AND
    NOT binary_coercible(p.proargtypes[0], a.aggmtranstype)

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid::oid, p.proname, ptr.oid, ptr.proname
FROM pg_aggregate AS a, pg_proc AS p, pg_proc AS ptr
WHERE a.aggfnoid = p.oid AND
    a.aggtransfn = ptr.oid AND
    (ptr.proretset
     OR NOT (ptr.pronargs =
             CASE WHEN a.aggkind = 'n' THEN p.pronargs + 1
             ELSE greatest(p.pronargs - a.aggnumdirectargs, 1) + 1 END)
     OR NOT binary_coercible(ptr.prorettype, a.aggtranstype)
     OR NOT binary_coercible(a.aggtranstype, ptr.proargtypes[0])
     OR (p.pronargs > 0 AND
         NOT binary_coercible(p.proargtypes[0], ptr.proargtypes[1]))
     OR (p.pronargs > 1 AND
         NOT binary_coercible(p.proargtypes[1], ptr.proargtypes[2]))
     OR (p.pronargs > 2 AND
         NOT binary_coercible(p.proargtypes[2], ptr.proargtypes[3]))
     OR (p.pronargs > 3 AND
         NOT binary_coercible(p.proargtypes[3], ptr.proargtypes[4]))
     OR (p.pronargs > 4)
    )

-- sqlfmt-corpus-separator --

SELECT a.aggfnoid::oid, p.proname, ptr.oid, ptr.proname
FROM pg_aggregate AS a, pg_proc AS p, pg_proc AS ptr
WHERE a.aggfnoid = p.oid AND
    a.aggtransfn = ptr.oid AND ptr.proisstrict AND
    a.agginitval IS NULL AND
    NOT binary_coercible(p.proargtypes[0], a.aggtranstype)

-- sqlfmt-corpus-separator --

SELECT a1.oid, a1.amname, p1.oid, p1.proname
FROM pg_am AS a1, pg_proc AS p1
WHERE p1.oid = a1.amhandler AND a1.amtype = 'i' AND
    (p1.prorettype != 'index_am_handler'::regtype
     OR p1.proretset
     OR p1.pronargs != 1
     OR p1.proargtypes[0] != 'internal'::regtype)

-- sqlfmt-corpus-separator --

SELECT a1.oid, a1.amname, p1.oid, p1.proname
FROM pg_am AS a1, pg_proc AS p1
WHERE p1.oid = a1.amhandler AND a1.amtype = 't' AND
    (p1.prorettype != 'table_am_handler'::regtype
     OR p1.proretset
     OR p1.pronargs != 1
     OR p1.proargtypes[0] != 'internal'::regtype)

-- sqlfmt-corpus-separator --

SELECT a::jd2 IS JSON WITH UNIQUE KEYS as col1 FROM (VALUES('{"a": 1, "a": 2}')) s(a)

-- sqlfmt-corpus-separator --

SELECT a[1:3],
          b[1:1][1:2][1:2],
          c[1:2],
          d[1:1][1:2]
   FROM arrtest

-- sqlfmt-corpus-separator --

SELECT a[1:3],
          b[1:1][1:2][1:2],
          c[1:2],
          d[1:1][2:2]
   FROM arrtest

-- sqlfmt-corpus-separator --

SELECT a[1], b[1][1][1], c[1], d[1][1], e[0]
   FROM arrtest

-- sqlfmt-corpus-separator --

SELECT a[2:], b[2:][2:] FROM arrtest_s

-- sqlfmt-corpus-separator --

SELECT a[:3], b[:2][:2] FROM arrtest_s

-- sqlfmt-corpus-separator --

SELECT a[:], b[:] FROM arrtest_s

-- sqlfmt-corpus-separator --

SELECT array_sort(a [-1:0]) FROM (VALUES ('[-2:0][20:21]={{1,2},{10,20},{1,-4}}'::int[])) v(a)

-- sqlfmt-corpus-separator --

SELECT array_sort(a [-1:0][20:20]) FROM (VALUES ('[-2:0][20:21]={{1,2},{10,20},{1,-4}}'::int[])) v(a)

-- sqlfmt-corpus-separator --

SELECT arrtest.a[1],
          arrtest.b[1][1][1],
          arrtest.c[1],
          arrtest.d[1][1],
          arrtest.e[0]
   FROM arrtest

-- sqlfmt-corpus-separator --

SELECT attnum, attname, atthasmissing, atthasdef, attmissingval
FROM  pg_attribute
WHERE attnum > 0 AND attrelid = 'test_add_domain_col'::regclass AND attisdropped is false
AND   atthasmissing
ORDER BY attnum

-- sqlfmt-corpus-separator --

SELECT b.f1, p.f1, b.f1 * p.f1 FROM BOX_TBL b, POINT_TBL p WHERE p.f1[0] > 1000

-- sqlfmt-corpus-separator --

SELECT b.f1, p.f1, b.f1 * p.f1 FROM BOX_TBL b, POINT_TBL p WHERE p.f1[0] BETWEEN 1 AND 1000

-- sqlfmt-corpus-separator --

SELECT b.f1, p.f1, b.f1 / p.f1 FROM BOX_TBL b, POINT_TBL p WHERE p.f1[0] BETWEEN 1 AND 1000

-- sqlfmt-corpus-separator --

SELECT b[1:1][2][2],
       d[1:1][2]
   FROM arrtest

-- sqlfmt-corpus-separator --

SELECT bytea '\x00' IS JSON

-- sqlfmt-corpus-separator --

SELECT c.*
FROM pg_cast c, pg_proc p
WHERE c.castfunc = p.oid AND
    ((p.pronargs > 1 AND p.proargtypes[1] != 'int4'::regtype) OR
     (p.pronargs > 2 AND p.proargtypes[2] != 'bool'::regtype))

-- sqlfmt-corpus-separator --

SELECT c.*
FROM pg_cast c, pg_proc p
WHERE c.castfunc = p.oid AND
    (p.pronargs < 1 OR p.pronargs > 3
     OR NOT (binary_coercible(c.castsource, p.proargtypes[0])
             OR (c.castsource = 'character'::regtype AND
                 p.proargtypes[0] = 'text'::regtype))
     OR NOT binary_coercible(p.prorettype, c.casttarget))

-- sqlfmt-corpus-separator --

SELECT c.f1, p.f1, c.f1 / p.f1 FROM CIRCLE_TBL c, POINT_TBL p WHERE p.f1[0] > 1000

-- sqlfmt-corpus-separator --

SELECT c.f1, p.f1, c.f1 / p.f1 FROM CIRCLE_TBL c, POINT_TBL p WHERE p.f1[0] BETWEEN 1 AND 1000

-- sqlfmt-corpus-separator --

SELECT c1.f1 AS circle, p1.f1 AS point, (p1.f1 <-> c1.f1) AS distance
   FROM CIRCLE_TBL c1, POINT_TBL p1
   WHERE (p1.f1 <-> c1.f1) > 0
   ORDER BY distance, area(c1.f1), p1.f1[0]

-- sqlfmt-corpus-separator --

SELECT count(*) FROM (SELECT (jsonb_each(j)).key FROM testjsonb) AS wow

-- sqlfmt-corpus-separator --

SELECT count(*) FROM test_tablesample TABLESAMPLE SYSTEM (100)

-- sqlfmt-corpus-separator --

SELECT count(*) FROM test_tablesample TABLESAMPLE SYSTEM (100) REPEATABLE (0.4)

-- sqlfmt-corpus-separator --

SELECT count(*) FROM test_tablesample TABLESAMPLE SYSTEM (100) REPEATABLE (1+2)

-- sqlfmt-corpus-separator --

SELECT count(*) FROM test_tablesample TABLESAMPLE bernoulli (('1'::text < '0'::text)::int)

-- sqlfmt-corpus-separator --

SELECT dataa, datab b, generate_series(1,2) g, count(*) FROM few GROUP BY CUBE(dataa, datab)

-- sqlfmt-corpus-separator --

SELECT dataa, datab b, generate_series(1,2) g, count(*) FROM few GROUP BY CUBE(dataa, datab) ORDER BY dataa

-- sqlfmt-corpus-separator --

SELECT dataa, datab b, generate_series(1,2) g, count(*) FROM few GROUP BY CUBE(dataa, datab) ORDER BY g

-- sqlfmt-corpus-separator --

SELECT dataa, datab b, generate_series(1,2) g, count(*) FROM few GROUP BY CUBE(dataa, datab, g)

-- sqlfmt-corpus-separator --

SELECT dataa, datab b, generate_series(1,2) g, count(*) FROM few GROUP BY CUBE(dataa, datab, g) ORDER BY dataa

-- sqlfmt-corpus-separator --

SELECT dataa, datab b, generate_series(1,2) g, count(*) FROM few GROUP BY CUBE(dataa, datab, g) ORDER BY g

-- sqlfmt-corpus-separator --

SELECT f1
   FROM BOOLTBL1
   WHERE f1 IS FALSE

-- sqlfmt-corpus-separator --

SELECT f1
   FROM BOOLTBL1
   WHERE f1 IS NOT FALSE

-- sqlfmt-corpus-separator --

SELECT f1
   FROM BOOLTBL1
   WHERE f1 IS NOT TRUE

-- sqlfmt-corpus-separator --

SELECT f1
   FROM BOOLTBL1
   WHERE f1 IS TRUE

-- sqlfmt-corpus-separator --

SELECT f1
   FROM BOOLTBL2
   WHERE f1 IS FALSE

-- sqlfmt-corpus-separator --

SELECT f1
   FROM BOOLTBL2
   WHERE f1 IS NOT FALSE

-- sqlfmt-corpus-separator --

SELECT f1
   FROM BOOLTBL2
   WHERE f1 IS NOT TRUE

-- sqlfmt-corpus-separator --

SELECT f1
   FROM BOOLTBL2
   WHERE f1 IS TRUE

-- sqlfmt-corpus-separator --

SELECT f1[0:1] FROM POINT_TBL

-- sqlfmt-corpus-separator --

SELECT f1[0:] FROM POINT_TBL

-- sqlfmt-corpus-separator --

SELECT f1[:1] FROM POINT_TBL

-- sqlfmt-corpus-separator --

SELECT f1[:] FROM POINT_TBL

-- sqlfmt-corpus-separator --

SELECT hobbies_r.name, (hobbies_r.equipment).name FROM hobbies_r

-- sqlfmt-corpus-separator --

SELECT id FROM bool_tab WHERE flag_nn IS FALSE

-- sqlfmt-corpus-separator --

SELECT id FROM bool_tab WHERE flag_nn IS NOT FALSE

-- sqlfmt-corpus-separator --

SELECT id FROM bool_tab WHERE flag_nn IS NOT TRUE

-- sqlfmt-corpus-separator --

SELECT id FROM bool_tab WHERE flag_nn IS NOT UNKNOWN

-- sqlfmt-corpus-separator --

SELECT id FROM bool_tab WHERE flag_nn IS TRUE

-- sqlfmt-corpus-separator --

SELECT id FROM bool_tab WHERE flag_nn IS UNKNOWN

-- sqlfmt-corpus-separator --

SELECT id FROM bool_tab WHERE flag_null IS UNKNOWN

-- sqlfmt-corpus-separator --

SELECT id FROM test_tablesample TABLESAMPLE BERNOULLI (-1)

-- sqlfmt-corpus-separator --

SELECT id FROM test_tablesample TABLESAMPLE BERNOULLI (200)

-- sqlfmt-corpus-separator --

SELECT id FROM test_tablesample TABLESAMPLE BERNOULLI (5.5) REPEATABLE (0)

-- sqlfmt-corpus-separator --

SELECT id FROM test_tablesample TABLESAMPLE BERNOULLI (50) REPEATABLE (0)

-- sqlfmt-corpus-separator --

SELECT id FROM test_tablesample TABLESAMPLE FOOBAR (1)

-- sqlfmt-corpus-separator --

SELECT id FROM test_tablesample TABLESAMPLE SYSTEM (-1)

-- sqlfmt-corpus-separator --

SELECT id FROM test_tablesample TABLESAMPLE SYSTEM (100.0/11) REPEATABLE (0)

-- sqlfmt-corpus-separator --

SELECT id FROM test_tablesample TABLESAMPLE SYSTEM (200)

-- sqlfmt-corpus-separator --

SELECT id FROM test_tablesample TABLESAMPLE SYSTEM (50) REPEATABLE (0)

-- sqlfmt-corpus-separator --

SELECT id FROM test_tablesample TABLESAMPLE SYSTEM (50) REPEATABLE (NULL)

-- sqlfmt-corpus-separator --

SELECT id FROM test_tablesample TABLESAMPLE SYSTEM (NULL)

-- sqlfmt-corpus-separator --

SELECT id FROM test_tablesample_v1 TABLESAMPLE BERNOULLI (1)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_exists('[{"a": 1}, {"a": 2}, {"a": 3}, {"a": 5}]', '$[*] ? (@.a > $min && @.a < $max)', vars => '{"min": 1, "max": 4}')

-- sqlfmt-corpus-separator --

SELECT jsonb_path_exists('[{"a": 1}, {"a": 2}, {"a": 3}, {"a": 5}]', '$[*] ? (@.a > $min && @.a < $max)', vars => '{"min": 3, "max": 4}')

-- sqlfmt-corpus-separator --

SELECT jsonb_path_match('"a"', '$', silent => false)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_match('1', '$', silent => false)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_match('1', '$', silent => true)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_match('[true, true]', '$[*]', silent => false)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_match('[true]', '$', silent => false)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_match('false', '$', silent => false)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_match('null', '$', silent => false)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_match('true', '$', silent => false)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_match('{}', '$', silent => false)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_match('{}', 'lax $.a', silent => false)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_match('{}', 'strict $.a', silent => false)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_match('{}', 'strict $.a', silent => true)

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query_array('[{"a": 1}, {"a": 2}, {"a": 3}, {"a": 5}]', '$[*].a ? (@ > $min && @ < $max)', vars => '{"min": 1, "max": 4}')

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query_array('[{"a": 1}, {"a": 2}, {"a": 3}, {"a": 5}]', '$[*].a ? (@ > $min && @ < $max)', vars => '{"min": 3, "max": 4}')

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query_first('[{"a": 1}, {"a": 2}, {"a": 3}, {"a": 5}]', '$[*].a ? (@ > $min && @ < $max)', vars => '{"min": 1, "max": 4}')

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query_first('[{"a": 1}, {"a": 2}, {"a": 3}, {"a": 5}]', '$[*].a ? (@ > $min && @ < $max)', vars => '{"min": 3, "max": 4}')

-- sqlfmt-corpus-separator --

SELECT jsonb_path_query_first('[{"a": 1}, {"a": 2}, {}]', 'strict $[*].a', silent => true)

-- sqlfmt-corpus-separator --

SELECT key, count(*) FROM (SELECT (jsonb_each(j)).key FROM testjsonb) AS wow GROUP BY key ORDER BY count DESC, key

-- sqlfmt-corpus-separator --

SELECT length(a[1]), length(a[2]) from parse_ident('"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx".yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy') as a

-- sqlfmt-corpus-separator --

SELECT length(current_timestamp::text) >= length(current_timestamp(0)::text)

-- sqlfmt-corpus-separator --

SELECT lexeme, positions[1] from unnest('base:7 hidden:6 rebel:1 spaceship:2,33A,34B,35C,36D strike:3'::tsvector)

-- sqlfmt-corpus-separator --

SELECT nth_value_def(n := 2, val := ten) OVER (PARTITION BY four), ten, four
  FROM (SELECT * FROM tenk1 WHERE unique2 < 10 ORDER BY four, ten) s

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname, p1.oid, p1.proname
FROM pg_operator AS o1, pg_proc AS p1
WHERE o1.oprcode = p1.oid AND
    o1.oprkind = 'b' AND
    (p1.pronargs != 2
     OR NOT binary_coercible(p1.prorettype, o1.oprresult)
     OR NOT binary_coercible(o1.oprleft, p1.proargtypes[0])
     OR NOT binary_coercible(o1.oprright, p1.proargtypes[1]))

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname, p1.oid, p1.proname
FROM pg_operator AS o1, pg_proc AS p1
WHERE o1.oprcode = p1.oid AND
    o1.oprkind = 'l' AND
    (p1.pronargs != 1
     OR NOT binary_coercible(p1.prorettype, o1.oprresult)
     OR NOT binary_coercible(o1.oprright, p1.proargtypes[0])
     OR o1.oprleft != 0)

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname, p2.oid, p2.proname
FROM pg_operator AS o1, pg_proc AS p2
WHERE o1.oprjoin = p2.oid AND
    (o1.oprkind != 'b' OR o1.oprresult != 'bool'::regtype OR
     p2.prorettype != 'float8'::regtype OR p2.proretset OR
     p2.pronargs != 5 OR
     p2.proargtypes[0] != 'internal'::regtype OR
     p2.proargtypes[1] != 'oid'::regtype OR
     p2.proargtypes[2] != 'internal'::regtype OR
     p2.proargtypes[3] != 'int2'::regtype OR
     p2.proargtypes[4] != 'internal'::regtype)

-- sqlfmt-corpus-separator --

SELECT o1.oid, o1.oprname, p2.oid, p2.proname
FROM pg_operator AS o1, pg_proc AS p2
WHERE o1.oprrest = p2.oid AND
    (o1.oprresult != 'bool'::regtype OR
     p2.prorettype != 'float8'::regtype OR p2.proretset OR
     p2.pronargs != 4 OR
     p2.proargtypes[0] != 'internal'::regtype OR
     p2.proargtypes[1] != 'oid'::regtype OR
     p2.proargtypes[2] != 'internal'::regtype OR
     p2.proargtypes[3] != 'int4'::regtype)

-- sqlfmt-corpus-separator --

SELECT oid::regprocedure, provariadic::regtype, proargtypes::regtype[]
FROM pg_proc
WHERE provariadic != 0
AND case proargtypes[array_length(proargtypes, 1)-1]
	WHEN '"any"'::regtype THEN '"any"'::regtype
	WHEN 'anyarray'::regtype THEN 'anyelement'::regtype
	WHEN 'anycompatiblearray'::regtype THEN 'anycompatible'::regtype
	ELSE (SELECT t.oid
		  FROM pg_type t
		  WHERE t.typarray = proargtypes[array_length(proargtypes, 1)-1])
	END  != provariadic

-- sqlfmt-corpus-separator --

SELECT p.f1, p1.f1, p.f1 / p1.f1 FROM PATH_TBL p, POINT_TBL p1 WHERE p1.f1[0] BETWEEN 1 AND 1000

-- sqlfmt-corpus-separator --

SELECT p.oid, p.proname, c.oid, c.conname
FROM pg_proc p, pg_conversion c
WHERE p.oid = c.conproc AND
    (p.prorettype != 'int4'::regtype OR p.proretset OR
     p.pronargs != 6 OR
     p.proargtypes[0] != 'int4'::regtype OR
     p.proargtypes[1] != 'int4'::regtype OR
     p.proargtypes[2] != 'cstring'::regtype OR
     p.proargtypes[3] != 'internal'::regtype OR
     p.proargtypes[4] != 'int4'::regtype OR
     p.proargtypes[5] != 'bool'::regtype)

-- sqlfmt-corpus-separator --

SELECT p1.f1 AS point1, p2.f1 AS point2, (p1.f1 <-> p2.f1) AS distance
   FROM POINT_TBL p1, POINT_TBL p2
   WHERE (p1.f1 <-> p2.f1) > 3 and p1.f1 << p2.f1
   ORDER BY distance, p1.f1[0], p2.f1[0]

-- sqlfmt-corpus-separator --

SELECT p1.f1 AS point1, p2.f1 AS point2, p1.f1 <-> p2.f1 AS dist
   FROM POINT_TBL p1, POINT_TBL p2
   ORDER BY dist, p1.f1[0], p2.f1[0]

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1, p1.f1 * p2.f1 FROM POINT_TBL p1, POINT_TBL p2 WHERE p1.f1[0] < 1

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1, p1.f1 * p2.f1 FROM POINT_TBL p1, POINT_TBL p2 WHERE p1.f1[0] BETWEEN 1 AND 1000

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1, p1.f1 / p2.f1 FROM POINT_TBL p1, POINT_TBL p2 WHERE p2.f1[0] > 1000

-- sqlfmt-corpus-separator --

SELECT p1.f1, p2.f1, p1.f1 / p2.f1 FROM POINT_TBL p1, POINT_TBL p2 WHERE p2.f1[0] BETWEEN 1 AND 1000

-- sqlfmt-corpus-separator --

SELECT p1.oid, p1.proname
FROM pg_proc AS p1
WHERE (pronargdefaults <> 0) != (proargdefaults IS NOT NULL)

-- sqlfmt-corpus-separator --

SELECT p1.oid, p1.proname, p1.proargtypes, p1.proallargtypes, p1.proargmodes
FROM pg_proc as p1
WHERE proallargtypes IS NOT NULL AND
  ARRAY(SELECT unnest(proargtypes)) <>
  ARRAY(SELECT proallargtypes[i]
        FROM generate_series(1, array_length(proallargtypes, 1)) g(i)
        WHERE proargmodes IS NULL OR proargmodes[i] IN ('i', 'b', 'v'))

-- sqlfmt-corpus-separator --

SELECT p1.oid, p1.proname, p2.oid, p2.proname
FROM pg_proc AS p1, pg_proc AS p2
WHERE p2.oid = p1.prosupport AND
    (p2.prorettype != 'internal'::regtype OR p2.proretset OR p2.pronargs != 1
     OR p2.proargtypes[0] != 'internal'::regtype)

-- sqlfmt-corpus-separator --

SELECT parse_ident('foo.boo[]', strict => false)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_clear_attribute_stats(
    schemaname => 'stats_import',
    relname => 'test',
    attname => 'arange',
    inherited => false)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_clear_extended_stats(
  schemaname => 'stats_import',
  relname => 'part_parent',
  statistics_schemaname => 'stats_import',
  statistics_name => 'part_parent_stat',
  inherited => true)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_clear_extended_stats(
  schemaname => 'stats_import',
  relname => 'test',
  statistics_schemaname => 'stats_import',
  statistics_name => 'test_stat',
  inherited => false)

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_clear_relation_stats(schemaname => 'stats_import', relname => 'test')

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_clear_relation_stats(schemaname => 'stats_import', relname => 'testseq')

-- sqlfmt-corpus-separator --

SELECT pg_catalog.pg_clear_relation_stats(schemaname => 'stats_import', relname => 'testview')

-- sqlfmt-corpus-separator --

SELECT pg_clear_extended_stats(schemaname => 'schema_foo',
  relname => 'rel_foo',
  statistics_schemaname => 'schema_foo',
  statistics_name => 'stat_bar',
  inherited => NULL)

-- sqlfmt-corpus-separator --

SELECT pg_clear_extended_stats(schemaname => 'schema_foo',
  relname => 'rel_foo',
  statistics_schemaname => 'schema_foo',
  statistics_name => NULL,
  inherited => false)

-- sqlfmt-corpus-separator --

SELECT pg_clear_extended_stats(schemaname => 'schema_foo',
  relname => 'rel_foo',
  statistics_schemaname => NULL,
  statistics_name => 'stat_bar',
  inherited => false)

-- sqlfmt-corpus-separator --

SELECT pg_clear_extended_stats(schemaname => 'schema_foo',
  relname => NULL,
  statistics_schemaname => 'schema_foo',
  statistics_name => 'stat_bar',
  inherited => false)

-- sqlfmt-corpus-separator --

SELECT pg_clear_extended_stats(schemaname => 'schema_not_exist',
  relname => 'test',
  statistics_schemaname => 'schema_not_exist',
  statistics_name => 'test_stat',
  inherited => false)

-- sqlfmt-corpus-separator --

SELECT pg_clear_extended_stats(schemaname => 'stats_import',
  relname => 'table_not_exist',
  statistics_schemaname => 'stats_import',
  statistics_name => 'test_stat',
  inherited => false)

-- sqlfmt-corpus-separator --

SELECT pg_clear_extended_stats(schemaname => 'stats_import',
  relname => 'test',
  statistics_schemaname => 'schema_not_exist',
  statistics_name => 'test_stat',
  inherited => false)

-- sqlfmt-corpus-separator --

SELECT pg_clear_extended_stats(schemaname => 'stats_import',
  relname => 'test',
  statistics_schemaname => 'stats_import',
  statistics_name => 'ext_stats_not_exist',
  inherited => false)

-- sqlfmt-corpus-separator --

SELECT pg_clear_extended_stats(schemaname => 'stats_import',
  relname => 'test',
  statistics_schemaname => 'stats_import',
  statistics_name => 'test_stat_clone',
  inherited => false)

-- sqlfmt-corpus-separator --

SELECT pg_clear_extended_stats(schemaname => NULL,
  relname => 'rel_foo',
  statistics_schemaname => 'schema_foo',
  statistics_name => 'stat_bar',
  inherited => false)

-- sqlfmt-corpus-separator --

SELECT r.rngtypid, r.rngsubtype, p.proname
FROM pg_range r JOIN pg_proc p ON p.oid = r.rngcanonical
WHERE pronargs != 1 OR proargtypes[0] != rngtypid OR prorettype != rngtypid

-- sqlfmt-corpus-separator --

SELECT r.rngtypid, r.rngsubtype, p.proname
FROM pg_range r JOIN pg_proc p ON p.oid = r.rngconstruct2 JOIN pg_type t ON r.rngtypid = t.oid
WHERE p.pronargs != 2
    OR p.proargtypes[0] != r.rngsubtype OR p.proargtypes[1] != r.rngsubtype
    OR p.prorettype != r.rngtypid
    OR p.proname != t.typname OR p.prosrc != 'range_constructor2'

-- sqlfmt-corpus-separator --

SELECT r.rngtypid, r.rngsubtype, p.proname
FROM pg_range r JOIN pg_proc p ON p.oid = r.rngconstruct3 JOIN pg_type t ON r.rngtypid = t.oid
WHERE p.pronargs != 3
    OR p.proargtypes[0] != r.rngsubtype OR p.proargtypes[1] != r.rngsubtype OR p.proargtypes[2] != 'pg_catalog.text'::regtype
    OR p.prorettype != r.rngtypid
    OR p.proname != t.typname OR p.prosrc != 'range_constructor3'

-- sqlfmt-corpus-separator --

SELECT r.rngtypid, r.rngsubtype, p.proname
FROM pg_range r JOIN pg_proc p ON p.oid = r.rngmltconstruct1 JOIN pg_type t ON r.rngmultitypid = t.oid
WHERE p.pronargs != 1
    OR p.proargtypes[0] != r.rngtypid
    OR p.prorettype != r.rngmultitypid
    OR p.proname != t.typname OR p.prosrc != 'multirange_constructor1'

-- sqlfmt-corpus-separator --

SELECT r.rngtypid, r.rngsubtype, p.proname
FROM pg_range r JOIN pg_proc p ON p.oid = r.rngmltconstruct2 JOIN pg_type t ON r.rngmultitypid = t.oid JOIN pg_type t2 ON r.rngtypid = t2.oid
WHERE p.pronargs != 1
    OR p.proargtypes[0] != t2.typarray
    OR p.prorettype != r.rngmultitypid
    OR p.proname != t.typname OR p.prosrc != 'multirange_constructor2'

-- sqlfmt-corpus-separator --

SELECT r.rngtypid, r.rngsubtype, p.proname
FROM pg_range r JOIN pg_proc p ON p.oid = r.rngsubdiff
WHERE pronargs != 2
    OR proargtypes[0] != rngsubtype OR proargtypes[1] != rngsubtype
    OR prorettype != 'pg_catalog.float8'::regtype

-- sqlfmt-corpus-separator --

SELECT random_normal(mean => 1, stddev => 0.1) r FROM generate_series(1, 10)

-- sqlfmt-corpus-separator --

SELECT relname, nspname
 FROM pg_class c LEFT JOIN pg_namespace n ON n.oid = relnamespace JOIN pg_attribute a ON (attrelid = c.oid AND attname = 'oid')
 WHERE relkind = 'r' and c.oid < 16384
     AND ((nspname ~ '^pg_') IS NOT FALSE)
     AND NOT EXISTS (SELECT 1 FROM pg_index i WHERE indrelid = c.oid
                     AND indkey[0] = a.attnum AND indnatts = 1
                     AND indisunique AND indimmediate)

-- sqlfmt-corpus-separator --

SELECT t.f[1][3][1] AS "131", t.f[2][2][1] AS "221" FROM (
  SELECT ARRAY[[[111,112],[121,122],[131,132]],[[211,212],[221,122],[231,232]]] AS f
) AS t

-- sqlfmt-corpus-separator --

SELECT t.id FROM test_tablesample AS t TABLESAMPLE SYSTEM (50) REPEATABLE (0)

-- sqlfmt-corpus-separator --

SELECT t.oid, t.typname, t.typanalyze
FROM pg_type t LEFT JOIN pg_range r on t.oid = r.rngtypid
WHERE t.typbasetype = 0 AND
    (t.typanalyze = 'range_typanalyze'::regproc) != (r.rngtypid IS NOT NULL)

-- sqlfmt-corpus-separator --

SELECT t1.a, ss.t2a, ss.t2c FROM prt1 t1 LEFT JOIN LATERAL
			  (SELECT t2.a AS t2a, t3.a AS t3a, t2.b t2b, t2.c t2c, least(t1.a,t2.a,t3.a) FROM prt1 t2 JOIN prt2 t3 ON (t2.a = t3.b)) ss
			  ON t1.c = ss.t2c WHERE (t1.b + coalesce(ss.t2b, 0)) = 0 ORDER BY t1.a

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typanalyze = p1.oid AND NOT
    (p1.pronargs = 1 AND
     p1.proargtypes[0] = 'internal'::regtype AND
     p1.prorettype = 'bool'::regtype AND NOT p1.proretset)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typinput = p1.oid AND NOT
    ((p1.pronargs = 1 AND p1.proargtypes[0] = 'cstring'::regtype) OR
     (p1.pronargs = 2 AND p1.proargtypes[0] = 'cstring'::regtype AND
      p1.proargtypes[1] = 'oid'::regtype) OR
     (p1.pronargs = 3 AND p1.proargtypes[0] = 'cstring'::regtype AND
      p1.proargtypes[1] = 'oid'::regtype AND
      p1.proargtypes[2] = 'int4'::regtype))

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typmodin = p1.oid AND NOT
    (p1.pronargs = 1 AND
     p1.proargtypes[0] = 'cstring[]'::regtype AND
     p1.prorettype = 'int4'::regtype AND NOT p1.proretset)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typmodout = p1.oid AND NOT
    (p1.pronargs = 1 AND
     p1.proargtypes[0] = 'int4'::regtype AND
     p1.prorettype = 'cstring'::regtype AND NOT p1.proretset)

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typoutput = p1.oid AND t1.typtype in ('b', 'p') AND NOT
    (p1.pronargs = 1 AND
     (p1.proargtypes[0] = t1.oid OR
      (p1.oid = 'array_out'::regproc AND
       t1.typelem != 0 AND t1.typlen = -1)))
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typreceive = p1.oid AND NOT
    ((p1.pronargs = 1 AND p1.proargtypes[0] = 'internal'::regtype) OR
     (p1.pronargs = 2 AND p1.proargtypes[0] = 'internal'::regtype AND
      p1.proargtypes[1] = 'oid'::regtype) OR
     (p1.pronargs = 3 AND p1.proargtypes[0] = 'internal'::regtype AND
      p1.proargtypes[1] = 'oid'::regtype AND
      p1.proargtypes[2] = 'int4'::regtype))

-- sqlfmt-corpus-separator --

SELECT t1.oid, t1.typname, p1.oid, p1.proname
FROM pg_type AS t1, pg_proc AS p1
WHERE t1.typsend = p1.oid AND t1.typtype in ('b', 'p') AND NOT
    (p1.pronargs = 1 AND
     (p1.proargtypes[0] = t1.oid OR
      (p1.oid = 'array_send'::regproc AND
       t1.typelem != 0 AND t1.typlen = -1)))
ORDER BY 1

-- sqlfmt-corpus-separator --

SELECT to_json(a) AS a, JSON_OBJECTAGG(k : v ABSENT ON NULL WITH UNIQUE KEYS)
   OVER (ORDER BY k)
FROM (VALUES (1,1), (1,null), (2,2)) a(k,v)

-- sqlfmt-corpus-separator --

SELECT to_json(a) AS a, JSON_OBJECTAGG(k : v ABSENT ON NULL)
OVER (ORDER BY k RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM (VALUES (1,1), (1,null), (2,2)) a(k,v)

-- sqlfmt-corpus-separator --

SELECT to_json(a) AS a, JSON_OBJECTAGG(k : v ABSENT ON NULL)
OVER (ORDER BY k)
FROM (VALUES (1,1), (1,null), (2,2)) a(k,v)

-- sqlfmt-corpus-separator --

SELECT to_json(a) AS a, JSON_OBJECTAGG(k : v WITH UNIQUE KEYS) OVER (ORDER BY k)
FROM (VALUES (1,1), (1,2), (2,2)) a(k,v)

-- sqlfmt-corpus-separator --

SELECT to_json(a) AS a, JSON_OBJECTAGG(k : v WITH UNIQUE KEYS) OVER (ORDER BY k)
FROM (VALUES (1,1), (2,2)) a(k,v)

-- sqlfmt-corpus-separator --

SELECT v as value, hash_aclitem(v)::bit(32) as standard,
       hash_aclitem_extended(v, 0)::bit(32) as extended0,
       hash_aclitem_extended(v, 1)::bit(32) as extended1
FROM   (SELECT DISTINCT(relacl[1]) FROM pg_class LIMIT 10) x(v)
WHERE  hash_aclitem(v)::bit(32) != hash_aclitem_extended(v, 0)::bit(32)
       OR hash_aclitem(v)::bit(32) = hash_aclitem_extended(v, 1)::bit(32)

-- sqlfmt-corpus-separator --

SELECT xml '<abc/>' IS NOT DOCUMENT

-- sqlfmt-corpus-separator --

SELECT xml '<foo>bar</foo>' IS DOCUMENT

-- sqlfmt-corpus-separator --

SELECT xml '<foo>bar</foo><bar>foo</bar>' IS DOCUMENT

-- sqlfmt-corpus-separator --

SELECT xml 'abc' IS NOT DOCUMENT

-- sqlfmt-corpus-separator --

SELECT xmlconcat('<?xml version="1.1"?><foo/>', NULL, '<?xml version="1.1" standalone="no"?><bar/>')

-- sqlfmt-corpus-separator --

SELECT xmlconcat('<foo/>', NULL, '<?xml version="1.1" standalone="no"?><bar/>')

-- sqlfmt-corpus-separator --

SELECT xmlconcat('bad', '<syntax')

-- sqlfmt-corpus-separator --

SELECT xmlconcat('hello', 'you')

-- sqlfmt-corpus-separator --

SELECT xmlconcat(1, 2)

-- sqlfmt-corpus-separator --

SELECT xmlconcat(NULL)

-- sqlfmt-corpus-separator --

SELECT xmlconcat(NULL, NULL)

-- sqlfmt-corpus-separator --

SELECT xmlconcat(xmlcomment('hello'),
                 xmlelement(NAME qux, 'foo'),
                 xmlcomment('world'))

-- sqlfmt-corpus-separator --

SELECT xmlelement(name duplicate, xmlattributes(1 as a, 2 as b, 3 as a))

-- sqlfmt-corpus-separator --

SELECT xmlelement(name element,
                  xmlattributes ('unnamed and wrong'))

-- sqlfmt-corpus-separator --

SELECT xmlelement(name element,
                  xmlattributes (1 as one, 'deuce' as two),
                  'content')

-- sqlfmt-corpus-separator --

SELECT xmlelement(name element, xmlelement(name nested, 'stuff'))

-- sqlfmt-corpus-separator --

SELECT xmlelement(name employee, xmlforest(name, age, salary as pay)) FROM emp

-- sqlfmt-corpus-separator --

SELECT xmlelement(name employees, xmlagg(xmlelement(name name, name))) FROM emp

-- sqlfmt-corpus-separator --

SELECT xmlelement(name foo, array[1, 2, 3])

-- sqlfmt-corpus-separator --

SELECT xmlelement(name foo, bytea 'bar')

-- sqlfmt-corpus-separator --

SELECT xmlelement(name foo, text 'b<a/>r')

-- sqlfmt-corpus-separator --

SELECT xmlelement(name foo, text 'bar')

-- sqlfmt-corpus-separator --

SELECT xmlelement(name foo, xml 'b<a/>r')

-- sqlfmt-corpus-separator --

SELECT xmlelement(name foo, xml 'bar')

-- sqlfmt-corpus-separator --

SELECT xmlelement(name foo, xmlattributes('2009-04-09 00:24:37'::timestamp as bar))

-- sqlfmt-corpus-separator --

SELECT xmlelement(name foo, xmlattributes('<>&"''' as funny, xml 'b<a/>r' as funnier))

-- sqlfmt-corpus-separator --

SELECT xmlelement(name foo, xmlattributes('infinity'::timestamp as bar))

-- sqlfmt-corpus-separator --

SELECT xmlelement(name foo, xmlattributes(true as bar))

-- sqlfmt-corpus-separator --

SELECT xmlelement(name num, 37)

-- sqlfmt-corpus-separator --

SELECT xmlforest(c1, c2, c3, c4) FROM testxmlschema.test3

-- sqlfmt-corpus-separator --

SELECT xmlparse(content '  ')

-- sqlfmt-corpus-separator --

SELECT xmlparse(content '')

-- sqlfmt-corpus-separator --

SELECT xmlparse(content '<abc>x</abc>')

-- sqlfmt-corpus-separator --

SELECT xmlparse(content '<invalidentity>&</invalidentity>')

-- sqlfmt-corpus-separator --

SELECT xmlparse(content '<nosuchprefix:tag/>')

-- sqlfmt-corpus-separator --

SELECT xmlparse(content '<relativens xmlns=''relative''/>')

-- sqlfmt-corpus-separator --

SELECT xmlparse(content 'abc')

-- sqlfmt-corpus-separator --

SELECT xmlparse(document '   ')

-- sqlfmt-corpus-separator --

SELECT xmlparse(document '<abc>x</abc>')

-- sqlfmt-corpus-separator --

SELECT xmlparse(document '<invalidentity>&</abc>')

-- sqlfmt-corpus-separator --

SELECT xmlparse(document '<nosuchprefix:tag/>')

-- sqlfmt-corpus-separator --

SELECT xmlparse(document '<relativens xmlns=''relative''/>')

-- sqlfmt-corpus-separator --

SELECT xmlparse(document 'abc')

-- sqlfmt-corpus-separator --

SELECT xmlpi(name "123")

-- sqlfmt-corpus-separator --

SELECT xmlpi(name ":::_xml_abc135.%-&_")

-- sqlfmt-corpus-separator --

SELECT xmlpi(name "xml-stylesheet", 'href="mystyle.css" type="text/css"')

-- sqlfmt-corpus-separator --

SELECT xmlpi(name foo)

-- sqlfmt-corpus-separator --

SELECT xmlpi(name foo, '   bar')

-- sqlfmt-corpus-separator --

SELECT xmlpi(name foo, 'bar')

-- sqlfmt-corpus-separator --

SELECT xmlpi(name foo, 'in?>valid')

-- sqlfmt-corpus-separator --

SELECT xmlpi(name foo, null)

-- sqlfmt-corpus-separator --

SELECT xmlpi(name xml)

-- sqlfmt-corpus-separator --

SELECT xmlpi(name xml, null)

-- sqlfmt-corpus-separator --

SELECT xmlpi(name xmlstuff)

-- sqlfmt-corpus-separator --

SELECT xmlpi(name xmlstuff, null)

-- sqlfmt-corpus-separator --

SELECT xmlroot (
  xmlelement (
    name gazonk,
    xmlattributes (
      'val' AS name,
      1 + 1 AS num
    ),
    xmlelement (
      NAME qux,
      'foo'
    )
  ),
  version '1.0',
  standalone yes
)

-- sqlfmt-corpus-separator --

SELECT xmlroot('<?xml version="1.1" standalone="yes"?><foo/>', version no value)

-- sqlfmt-corpus-separator --

SELECT xmlroot('<?xml version="1.1" standalone="yes"?><foo/>', version no value, standalone no value)

-- sqlfmt-corpus-separator --

SELECT xmlroot('<?xml version="1.1" standalone="yes"?><foo/>', version no value, standalone no)

-- sqlfmt-corpus-separator --

SELECT xmlroot(xml '<?xml version="1.1"?><foo/>', version no value, standalone yes)

-- sqlfmt-corpus-separator --

SELECT xmlroot(xml '<foo/>', version '2.0')

-- sqlfmt-corpus-separator --

SELECT xmlroot(xml '<foo/>', version no value, standalone no value)

-- sqlfmt-corpus-separator --

SELECT xmlroot(xml '<foo/>', version no value, standalone yes)

-- sqlfmt-corpus-separator --

SELECT xmlroot(xmlroot(xml '<foo/>', version '1.0'), version '1.1', standalone no)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(CONTENT  '  ' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(CONTENT  '' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(CONTENT  '<!DOCTYPE a><a/>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(CONTENT  '<?xml version="1.0" encoding="UTF-8"?><foo><bar><val>73</val></bar></foo>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(CONTENT  '<foo>73</foo><bar><val x="y">42</val></bar>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(CONTENT  '<foo><bar></bar></foo>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(CONTENT  '<foo><bar><val x="y">42</val></bar></foo>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(CONTENT  '<foo><bar><val x="y">42</val></bar></foo>' AS text NO INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(CONTENT  '<foo><bar><val x="y">42</val></bar></foo>' AS text) = xmlserialize(CONTENT '<foo><bar><val x="y">42</val></bar></foo>' AS text NO INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(CONTENT  '<foo><bar><val x="y">42</val><val x="y">text node<val>73</val></val></bar></foo>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(CONTENT  'text node<foo>    <bar></bar>   </foo>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(CONTENT  'text node<foo>73</foo>text node<bar><val x="y">42</val></bar>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(CONTENT  NULL AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(DOCUMENT '  ' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(DOCUMENT '' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(DOCUMENT '<!DOCTYPE a><a/>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(DOCUMENT '<?xml version="1.0" encoding="UTF-8"?><foo><bar><val>73</val></bar></foo>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(DOCUMENT '<foo>   <bar></bar>    </foo>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(DOCUMENT '<foo>73</foo><bar><val x="y">42</val></bar>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(DOCUMENT '<foo><bar></bar></foo>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(DOCUMENT '<foo><bar><val x="y">42</val></bar></foo>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(DOCUMENT '<foo><bar><val x="y">42</val></bar></foo>' AS text NO INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(DOCUMENT '<foo><bar><val x="y">42</val></bar></foo>' AS text) = xmlserialize(DOCUMENT '<foo><bar><val x="y">42</val></bar></foo>' AS text NO INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(DOCUMENT '<foo><bar><val x="y">42</val><val x="y">text node<val>73</val></val></bar></foo>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(DOCUMENT 'text node<foo>73</foo>text node<bar><val x="y">42</val></bar>' AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(DOCUMENT NULL AS text INDENT)

-- sqlfmt-corpus-separator --

SELECT xmlserialize(content 'good' as char(10))

-- sqlfmt-corpus-separator --

SELECT xmlserialize(content data as character varying(20)) FROM xmltest

-- sqlfmt-corpus-separator --

SELECT xmlserialize(document 'bad' as text)

-- sqlfmt-corpus-separator --

SELECT xmltable.* FROM xmldata, LATERAL xmltable('/ROWS/ROW[COUNTRY_NAME="Japan" or COUNTRY_NAME="India"]' PASSING data COLUMNS "COUNTRY_NAME" text, "REGION_ID" int)

-- sqlfmt-corpus-separator --

SELECT xmltable.* FROM xmldata, LATERAL xmltable('/ROWS/ROW[COUNTRY_NAME="Japan" or COUNTRY_NAME="India"]' PASSING data COLUMNS "COUNTRY_NAME" text, "REGION_ID" int) WHERE "COUNTRY_NAME" = 'Japan'

-- sqlfmt-corpus-separator --

SELECT xmltable.* FROM xmldata, LATERAL xmltable('/ROWS/ROW[COUNTRY_NAME="Japan" or COUNTRY_NAME="India"]' PASSING data COLUMNS id FOR ORDINALITY)

-- sqlfmt-corpus-separator --

SELECT xmltable.* FROM xmldata, LATERAL xmltable('/ROWS/ROW[COUNTRY_NAME="Japan" or COUNTRY_NAME="India"]' PASSING data COLUMNS id FOR ORDINALITY, "COUNTRY_NAME" text, "REGION_ID" int)

-- sqlfmt-corpus-separator --

SELECT xmltable.* FROM xmldata, LATERAL xmltable('/ROWS/ROW[COUNTRY_NAME="Japan" or COUNTRY_NAME="India"]' PASSING data COLUMNS id int PATH '@id')

-- sqlfmt-corpus-separator --

SELECT xmltable.* FROM xmldata, LATERAL xmltable('/ROWS/ROW[COUNTRY_NAME="Japan" or COUNTRY_NAME="India"]' PASSING data COLUMNS id int PATH '@id', "COUNTRY_NAME" text, "REGION_ID" int)

-- sqlfmt-corpus-separator --

SELECT xmltable.* FROM xmldata, LATERAL xmltable('/ROWS/ROW[COUNTRY_NAME="Japan" or COUNTRY_NAME="India"]' PASSING data COLUMNS id int PATH '@id', "COUNTRY_NAME" text, "REGION_ID" int, rawdata xml PATH '.')

-- sqlfmt-corpus-separator --

SELECT xmltable.* FROM xmldata, LATERAL xmltable('/ROWS/ROW[COUNTRY_NAME="Japan" or COUNTRY_NAME="India"]' PASSING data COLUMNS id int PATH '@id', "COUNTRY_NAME" text, "REGION_ID" int, rawdata xml PATH './*')

-- sqlfmt-corpus-separator --

SELECT xmltable.* FROM xmltest2, LATERAL xmltable('/d/r' PASSING x COLUMNS a int PATH '' || lower(_path) || 'c')

-- sqlfmt-corpus-separator --

SELECT xmltable.* FROM xmltest2, LATERAL xmltable(('/d/r/' || lower(_path) || 'c') PASSING x COLUMNS a int PATH '.')

-- sqlfmt-corpus-separator --

SELECT xmltable.* FROM xmltest2, LATERAL xmltable(('/d/r/' || lower(_path) || 'c') PASSING x COLUMNS a int PATH 'x' DEFAULT ascii(_path) - 54)

-- sqlfmt-corpus-separator --

SET SESSION CHARACTERISTICS AS TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

SET SESSION CHARACTERISTICS AS TRANSACTION READ WRITE

-- sqlfmt-corpus-separator --

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

-- sqlfmt-corpus-separator --

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE, READ ONLY, DEFERRABLE

-- sqlfmt-corpus-separator --

SET TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

SET TRANSACTION READ WRITE

-- sqlfmt-corpus-separator --

SET TRANSACTION SNAPSHOT 'FFF-FFF-F'

-- sqlfmt-corpus-separator --

SET TRANSACTION SNAPSHOT 'Incorrect Identifier'

-- sqlfmt-corpus-separator --

START TRANSACTION ISOLATION LEVEL READ COMMITTED, READ WRITE, DEFERRABLE

-- sqlfmt-corpus-separator --

START TRANSACTION ISOLATION LEVEL REPEATABLE READ, READ WRITE, DEFERRABLE

-- sqlfmt-corpus-separator --

START TRANSACTION ISOLATION LEVEL SERIALIZABLE, READ WRITE, NOT DEFERRABLE

-- sqlfmt-corpus-separator --

START TRANSACTION READ ONLY

-- sqlfmt-corpus-separator --

START TRANSACTION READ WRITE

-- sqlfmt-corpus-separator --

TRUNCATE truncate_a RESTART IDENTITY

-- sqlfmt-corpus-separator --

TRUNCATE truncate_b RESTART IDENTITY

-- sqlfmt-corpus-separator --

UPDATE arrtest SET a[4] = NULL WHERE a[2] IS NULL

-- sqlfmt-corpus-separator --

UPDATE current_check SET payload = payload || '_new' WHERE CURRENT OF current_check_cursor RETURNING *

-- sqlfmt-corpus-separator --

UPDATE current_check_2 SET b = 'Manzana' WHERE CURRENT OF current_check_cursor

-- sqlfmt-corpus-separator --

UPDATE foo SET f2 = lower(f2), f3 = DEFAULT RETURNING foo.*, f1+f3 AS sum13

-- sqlfmt-corpus-separator --

UPDATE gtest1 SET b = DEFAULT WHERE a = 1

-- sqlfmt-corpus-separator --

UPDATE itest1 SET a = DEFAULT WHERE a = 2

-- sqlfmt-corpus-separator --

UPDATE itest2 SET a = DEFAULT WHERE a = 2

-- sqlfmt-corpus-separator --

UPDATE rw_view1 SET b[1] = -b[1] WHERE a = 1

-- sqlfmt-corpus-separator --

UPDATE rw_view1 SET b[2] = -b[2] WHERE a = 1

-- sqlfmt-corpus-separator --

UPDATE rw_view15 SET upper=DEFAULT WHERE a=3

-- sqlfmt-corpus-separator --

UPDATE uctest SET f1 = 8 WHERE CURRENT OF c1

-- sqlfmt-corpus-separator --

UPDATE uctest SET f1 = f1 + 10 WHERE CURRENT OF c1

-- sqlfmt-corpus-separator --

UPDATE ucview SET f1 = f1 + 10 WHERE CURRENT OF c1

-- sqlfmt-corpus-separator --

UPDATE update_test
  SET (b,a) = (select a,b from update_test where b = 41 and c = 'car')
  WHERE a = 100 AND b = 20

-- sqlfmt-corpus-separator --

UPDATE update_test SET (a,b) = (v.*) FROM (VALUES(21, 101)) AS v(i, j)
  WHERE update_test.a = v.i

-- sqlfmt-corpus-separator --

UPDATE update_test SET (a,b) = ROW(v.*) FROM (VALUES(21, 100)) AS v(i, j)
  WHERE update_test.a = v.i

-- sqlfmt-corpus-separator --

UPDATE update_test SET (b,a) = (select a+1,b from update_test where a = 1000)
  WHERE a = 11

-- sqlfmt-corpus-separator --

UPDATE update_test SET (b,a) = (select a+1,b from update_test)

-- sqlfmt-corpus-separator --

UPDATE update_test SET (c,b) = ('car', a+b), a = a + 1 WHERE a = 10

-- sqlfmt-corpus-separator --

UPDATE update_test SET (c,b) = ('car', a+b), b = a + 1 WHERE a = 10

-- sqlfmt-corpus-separator --

UPDATE update_test SET (c,b,a) = ('bugle', b+11, DEFAULT) WHERE c = 'foo'

-- sqlfmt-corpus-separator --

UPDATE update_test SET a = DEFAULT, b = DEFAULT

-- sqlfmt-corpus-separator --

UPDATE update_test o
  SET (b,a) = (select a+1,b from update_test i
               where i.a=o.a and i.b=o.b and i.c is not distinct from o.c)

-- sqlfmt-corpus-separator --

UPDATE update_test t
  SET (a, b) = (SELECT b, a FROM update_test s WHERE s.a = t.a)
  WHERE CURRENT_USER = SESSION_USER

-- sqlfmt-corpus-separator --

VACUUM (BUFFER_USAGE_LIMIT '512 kB') vac_option_tab

-- sqlfmt-corpus-separator --

VACUUM (BUFFER_USAGE_LIMIT '512 kB', FULL) vac_option_tab

-- sqlfmt-corpus-separator --

VACUUM (BUFFER_USAGE_LIMIT 0) vac_option_tab

-- sqlfmt-corpus-separator --

VACUUM (BUFFER_USAGE_LIMIT 10000000000) vac_option_tab

-- sqlfmt-corpus-separator --

VACUUM (BUFFER_USAGE_LIMIT 120) vac_option_tab

-- sqlfmt-corpus-separator --

VACUUM (BUFFER_USAGE_LIMIT 16777220) vac_option_tab

-- sqlfmt-corpus-separator --

VACUUM (FULL TRUE) no_index_cleanup

-- sqlfmt-corpus-separator --

VACUUM (INDEX_CLEANUP AUTO) vactst

-- sqlfmt-corpus-separator --

VACUUM (INDEX_CLEANUP FALSE) vaccluster

-- sqlfmt-corpus-separator --

VACUUM (INDEX_CLEANUP FALSE, FREEZE TRUE) vaccluster

-- sqlfmt-corpus-separator --

VACUUM (INDEX_CLEANUP TRUE, FULL TRUE) no_index_cleanup

-- sqlfmt-corpus-separator --

VACUUM (PARALLEL -1) pvactst

-- sqlfmt-corpus-separator --

VACUUM (PARALLEL 0) pvactst

-- sqlfmt-corpus-separator --

VACUUM (PARALLEL 0, BUFFER_USAGE_LIMIT 128) test_io_vac_strategy

-- sqlfmt-corpus-separator --

VACUUM (PARALLEL 0, FULL TRUE) tmp

-- sqlfmt-corpus-separator --

VACUUM (PARALLEL 1, FULL FALSE) tmp

-- sqlfmt-corpus-separator --

VACUUM (PARALLEL 2) pvactst

-- sqlfmt-corpus-separator --

VACUUM (PARALLEL 2) pvactst2

-- sqlfmt-corpus-separator --

VACUUM (PARALLEL 2, FULL TRUE) pvactst

-- sqlfmt-corpus-separator --

VACUUM (PARALLEL 2, INDEX_CLEANUP FALSE) pvactst

-- sqlfmt-corpus-separator --

VACUUM (PARALLEL 4, INDEX_CLEANUP ON) parallel_vacuum_table

-- sqlfmt-corpus-separator --

VACUUM (PROCESS_MAIN FALSE) vac_option_tab

-- sqlfmt-corpus-separator --

VACUUM (PROCESS_MAIN FALSE, PROCESS_TOAST FALSE) vac_option_tab

-- sqlfmt-corpus-separator --

VACUUM (PROCESS_TOAST FALSE) vac_option_tab

-- sqlfmt-corpus-separator --

VACUUM (PROCESS_TOAST FALSE, FULL) vac_option_tab

-- sqlfmt-corpus-separator --

VACUUM (PROCESS_TOAST TRUE) vac_option_tab

-- sqlfmt-corpus-separator --

VACUUM (TRUNCATE FALSE, DISABLE_PAGE_SKIPPING) vac_truncate_test

-- sqlfmt-corpus-separator --

VACUUM (TRUNCATE FALSE, FULL TRUE) vac_truncate_test

-- sqlfmt-corpus-separator --

VACUUM ANALYZE vacparted(a,b,a)

-- sqlfmt-corpus-separator --

VACUUM ANALYZE vactst (does_not_exist), vacparted (b)

-- sqlfmt-corpus-separator --

VACUUM ANALYZE vactst, vacparted (a)

-- sqlfmt-corpus-separator --

VACUUM FULL vactst, vacparted (a, b), vaccluster (i)

-- sqlfmt-corpus-separator --

WITH
   x AS (SELECT proname, proowner, procost::numeric, pronargs,
                array_to_string(proargnames,',') as proargnames,
                case when proargtypes <> '' then array_to_string(proargtypes::oid[],',') end as proargtypes
           FROM pg_proc WHERE proname = 'f_leak'),
   y AS (SELECT xmlelement(name proc,
                           xmlforest(proname, proowner,
                                     procost, pronargs,
                                     proargnames, proargtypes)) as proc
           FROM x),
   z AS (SELECT xmltable.*
           FROM y,
                LATERAL xmltable('/proc' PASSING proc
                                 COLUMNS proname name,
                                         proowner oid,
                                         procost float,
                                         pronargs int,
                                         proargnames text,
                                         proargtypes text))
   SELECT * FROM z
   EXCEPT SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH
   x AS (SELECT proname, proowner, procost::numeric, pronargs,
                array_to_string(proargnames,',') as proargnames,
                case when proargtypes <> '' then array_to_string(proargtypes::oid[],',') end as proargtypes
           FROM pg_proc),
   y AS (SELECT xmlelement(name data,
                           xmlagg(xmlelement(name proc,
                                             xmlforest(proname, proowner, procost,
                                                       pronargs, proargnames, proargtypes)))) as doc
           FROM x),
   z AS (SELECT xmltable.*
           FROM y,
                LATERAL xmltable('/data/proc' PASSING doc
                                 COLUMNS proname name,
                                         proowner oid,
                                         procost float,
                                         pronargs int,
                                         proargnames text,
                                         proargtypes text))
   SELECT * FROM z
   EXCEPT SELECT * FROM x

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(id, path) AS (
    VALUES(1,ARRAY[]::integer[])
UNION ALL
    SELECT tree.id, t.path || tree.id
    FROM tree JOIN t ON (tree.parent_id = t.id)
)
SELECT t1.*, t2.* FROM t AS t1 JOIN t AS t2 ON
	(t1.path[1] = t2.path[1] AND
	array_upper(t1.path,1) = 1 AND
	array_upper(t2.path,1) > 1)
	ORDER BY t1.id, t2.id

-- sqlfmt-corpus-separator --

WITH RECURSIVE t(id, path) AS (
    VALUES(1,ARRAY[]::integer[])
UNION ALL
    SELECT tree.id, t.path || tree.id
    FROM tree JOIN t ON (tree.parent_id = t.id)
)
SELECT t1.id, count(t2.*) FROM t AS t1 JOIN t AS t2 ON
	(t1.path[1] = t2.path[1] AND
	array_upper(t1.path,1) = 1 AND
	array_upper(t2.path,1) > 1)
	GROUP BY t1.id
	ORDER BY t1.id

-- sqlfmt-corpus-separator --

WITH aaa AS (SELECT 1 AS a, 'Foo' AS b) INSERT INTO upsert_test
  VALUES (1, 'Bar') ON CONFLICT(a)
  DO UPDATE SET (b, a) = (SELECT b, a FROM aaa) RETURNING *

-- sqlfmt-corpus-separator --

WITH aaa AS (SELECT 1 AS ctea, ' Foo' AS cteb) INSERT INTO upsert_test
  VALUES (1, 'Bar'), (2, 'Baz') ON CONFLICT(a)
  DO UPDATE SET (b, a) = (SELECT upsert_test.b||cteb, upsert_test.a FROM aaa) RETURNING *

-- sqlfmt-corpus-separator --

WITH query_select AS (SELECT * FROM test_tablesample)
SELECT * FROM query_select TABLESAMPLE BERNOULLI (5.5) REPEATABLE (1)

-- sqlfmt-corpus-separator --

WITH rand_value AS (SELECT string_agg(fipshash((-i)::text),'') AS val FROM generate_series(1,60) s(i))
INSERT INTO brintest_3
SELECT val, val, val, val FROM rand_value

-- sqlfmt-corpus-separator --

WITH simpletup AS (
  SELECT 2 k, 'Green' v),
upsert_cte AS (
  INSERT INTO withz VALUES(2, 'Blue') ON CONFLICT (k) DO
    UPDATE SET (k, v) = (SELECT k, v FROM simpletup WHERE simpletup.k = withz.k)
    RETURNING k, v)
INSERT INTO withz VALUES(2, 'Red') ON CONFLICT (k) DO
UPDATE SET (k, v) = (SELECT k, v FROM upsert_cte WHERE upsert_cte.k = withz.k)
RETURNING k, v

-- sqlfmt-corpus-separator --

WITH str(j, num) AS
(
	SELECT jsonb_build_object('s', s), num
	FROM unnest('{"", "a", "ab", "abc", "abcd", "b", "A", "AB", "ABC", "ABc", "ABcD", "B"}'::text[]) WITH ORDINALITY AS a(s, num)
)
SELECT
	s1.j, s2.j,
	jsonb_path_query_first(s1.j, '$.s < $s', vars => s2.j) lt,
	jsonb_path_query_first(s1.j, '$.s <= $s', vars => s2.j) le,
	jsonb_path_query_first(s1.j, '$.s == $s', vars => s2.j) eq,
	jsonb_path_query_first(s1.j, '$.s >= $s', vars => s2.j) ge,
	jsonb_path_query_first(s1.j, '$.s > $s', vars => s2.j) gt
FROM str s1, str s2
ORDER BY s1.num, s2.num

-- sqlfmt-corpus-separator --

alter domain testdomain1 rename constraint unsigned to unsigned_foo

-- sqlfmt-corpus-separator --

alter index idxpart attach partition idxpart1

-- sqlfmt-corpus-separator --

alter index idxpart1_a_idx attach partition idxpart11_a_idx

-- sqlfmt-corpus-separator --

alter index idxpart2_a_idx attach partition idxpart21_a_idx

-- sqlfmt-corpus-separator --

alter index idxpart2_a_idx attach partition idxpart22_a_idx

-- sqlfmt-corpus-separator --

alter index idxpart_1_idx attach partition idxpart1_1_idx

-- sqlfmt-corpus-separator --

alter index idxpart_1_idx attach partition idxpart1_1b_idx

-- sqlfmt-corpus-separator --

alter index idxpart_2_idx attach partition idxpart1_2_idx

-- sqlfmt-corpus-separator --

alter index idxpart_2_idx attach partition idxpart1_2b_idx

-- sqlfmt-corpus-separator --

alter index idxpart_2_idx attach partition idxpart1_2c_idx

-- sqlfmt-corpus-separator --

alter index idxpart_a_b_idx attach partition idxpart1

-- sqlfmt-corpus-separator --

alter index idxpart_a_b_idx attach partition idxpart1_2_a_b

-- sqlfmt-corpus-separator --

alter index idxpart_a_b_idx attach partition idxpart1_a_b_idx

-- sqlfmt-corpus-separator --

alter index idxpart_a_b_idx attach partition idxpart1_b_idx

-- sqlfmt-corpus-separator --

alter index idxpart_a_b_idx attach partition idxpart1_tst1

-- sqlfmt-corpus-separator --

alter index idxpart_a_b_idx attach partition idxpart1_tst2

-- sqlfmt-corpus-separator --

alter index idxpart_a_b_idx attach partition idxpart1_tst3

-- sqlfmt-corpus-separator --

alter index idxpart_a_b_idx attach partition idxpart_a_b_idx

-- sqlfmt-corpus-separator --

alter index idxpart_a_idx attach partition idxpart1_a_idx

-- sqlfmt-corpus-separator --

alter index idxpart_a_idx attach partition idxpart2_a_idx

-- sqlfmt-corpus-separator --

alter index idxpart_c attach partition idxpart1_c

-- sqlfmt-corpus-separator --

alter index idxpart_expr_idx attach partition idxpart1_expr_idx

-- sqlfmt-corpus-separator --

alter index idxpart_expr_idx attach partition idxpart2_expr_idx

-- sqlfmt-corpus-separator --

alter index idxpart_pkey attach partition idxpart0_a_key

-- sqlfmt-corpus-separator --

alter index idxpart_pkey attach partition idxpart0_pkey

-- sqlfmt-corpus-separator --

alter index idxpart_pkey attach partition idxpart1_a_idx

-- sqlfmt-corpus-separator --

alter index parted_conflict_a_idx attach partition parted_conflict_1_a_idx

-- sqlfmt-corpus-separator --

alter index parted_replica_idx ATTACH PARTITION parted_replica_idx_1

-- sqlfmt-corpus-separator --

alter index parted_replica_idx_1 ATTACH PARTITION parted_replica_idx_11

-- sqlfmt-corpus-separator --

alter table a alter column aa type integer using bit_length(aa)

-- sqlfmt-corpus-separator --

alter table alterlock alter column f2 set (n_distinct = 1)

-- sqlfmt-corpus-separator --

alter table alterlock alter column f2 set statistics 150

-- sqlfmt-corpus-separator --

alter table alterlock alter column f2 set storage extended

-- sqlfmt-corpus-separator --

alter table alterlock cluster on alterlock_pkey

-- sqlfmt-corpus-separator --

alter table alterlock set without cluster

-- sqlfmt-corpus-separator --

alter table alterlock2
add constraint alterlock2nv foreign key (f1) references alterlock (f1) NOT VALID

-- sqlfmt-corpus-separator --

alter table alterlock2 validate constraint alterlock2nv

-- sqlfmt-corpus-separator --

alter table alttype_cluster cluster on alttype_cluster_ind

-- sqlfmt-corpus-separator --

alter table alttype_cluster cluster on alttype_cluster_pkey

-- sqlfmt-corpus-separator --

alter table another
  alter f1 type text using f2 || ' and ' || f3 || ' more',
  alter f2 type bigint using f1 * 10,
  drop column f3

-- sqlfmt-corpus-separator --

alter table anothertab
  add exclude using btree (f3 with =)

-- sqlfmt-corpus-separator --

alter table anothertab
  add exclude using btree (f4 with =) where (f4 is not null)

-- sqlfmt-corpus-separator --

alter table anothertab
  add exclude using btree (f4 with =) where (f5 > 0)

-- sqlfmt-corpus-separator --

alter table anothertab alter column atcol1 type boolean
        using case when atcol1 % 2 = 0 then true else false end

-- sqlfmt-corpus-separator --

alter table anothertab alter column atcol1 type boolean using atcol1::int

-- sqlfmt-corpus-separator --

alter table anothertab alter column atcol2 type text
      using case when atcol2 is true then 'IT WAS TRUE'
                 when atcol2 is false then 'IT WAS FALSE'
                 else 'IT WAS NULL!' end

-- sqlfmt-corpus-separator --

alter table at_test_sql_partop attach partition at_test_sql_partop_1 for values from (0) to (10)

-- sqlfmt-corpus-separator --

alter table atacc1 add constraint atacc1_fkey foreign key (a) references atacc1 (a) not valid

-- sqlfmt-corpus-separator --

alter table atacc1 alter "........pg.dropped.1........" set statistics 0

-- sqlfmt-corpus-separator --

alter table atacc1 alter "........pg.dropped.1........" set storage plain

-- sqlfmt-corpus-separator --

alter table atacc1 alter a set statistics 0

-- sqlfmt-corpus-separator --

alter table atacc1 alter a set storage plain

-- sqlfmt-corpus-separator --

alter table atacc1 alter column test type integer using 0

-- sqlfmt-corpus-separator --

alter table atacc1 validate constraint atacc1_chk, alter a type int

-- sqlfmt-corpus-separator --

alter table atacc1 validate constraint atacc1_fkey, alter a type bigint

-- sqlfmt-corpus-separator --

alter table attbl replica identity using index pk_attbl

-- sqlfmt-corpus-separator --

alter table bar1 attach partition bar2 default

-- sqlfmt-corpus-separator --

alter table btree_tall_tbl alter COLUMN t set storage plain

-- sqlfmt-corpus-separator --

alter table constr_child validate constraint constr_parent_a_not_null

-- sqlfmt-corpus-separator --

alter table constr_child2 validate constraint constr_parent2_a_not_null

-- sqlfmt-corpus-separator --

alter table convslot_test_parent
  attach partition convslot_test_part for values from (1) to (1000)

-- sqlfmt-corpus-separator --

alter table covidxpart attach partition covidxpart3 for values in (3)

-- sqlfmt-corpus-separator --

alter table covidxpart attach partition covidxpart4 for values in (4)

-- sqlfmt-corpus-separator --

alter table defcheck attach partition defcheck_def default

-- sqlfmt-corpus-separator --

alter table defpart_attach_test attach partition defpart_attach_test_2 for values in (2)

-- sqlfmt-corpus-separator --

alter table defpart_attach_test attach partition defpart_attach_test_d default

-- sqlfmt-corpus-separator --

alter table donothingbrtrig_test attach partition donothingbrtrig_test1 for values in (1)

-- sqlfmt-corpus-separator --

alter table donothingbrtrig_test attach partition donothingbrtrig_test2 for values in (2)

-- sqlfmt-corpus-separator --

alter table ec1 enable row level security

-- sqlfmt-corpus-separator --

alter table fkpart1.fk_part detach partition fkpart1.fk_part_1

-- sqlfmt-corpus-separator --

alter table fkpart2.fk_part detach partition fkpart2.fk_part_1

-- sqlfmt-corpus-separator --

alter table fkpart2.fk_part_1 attach partition fkpart2.fk_part_1_1 for values in (1)

-- sqlfmt-corpus-separator --

alter table gtest32 alter column e type bigint using b

-- sqlfmt-corpus-separator --

alter table idxpart add exclude USING GIST (a with -|-)

-- sqlfmt-corpus-separator --

alter table idxpart add exclude USING GIST (a with =)

-- sqlfmt-corpus-separator --

alter table idxpart add exclude USING GIST (a with =, b with &&)

-- sqlfmt-corpus-separator --

alter table idxpart add exclude USING GIST (a with =, b with =)

-- sqlfmt-corpus-separator --

alter table idxpart add exclude USING GIST (a with =, b with =, c with &&)

-- sqlfmt-corpus-separator --

alter table idxpart add exclude USING GIST (b with =, c with &&)

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart0 default

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart0 for values from (0) to (1000)

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart1 for values from ('aaa') to ('bbb')

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart1 for values from (0) to (10)

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart1 for values from (0) to (1000)

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart1 for values from (0) to (10000)

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart1 for values from (0000) to (1000)

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart1 for values from (1) to (1000)

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart1 for values from (1) to (2)

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart2 for values from ('bbb') to ('ccc')

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart2 for values from (0) to (1)

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart2 for values from (10) to (20)

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart2 for values from (1000) to (2000)

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart2 for values from (100000) to (1000000)

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart3 for values from (1000) to (2000)

-- sqlfmt-corpus-separator --

alter table idxpart attach partition idxpart3 for values from (20, 20) to (30, 30)

-- sqlfmt-corpus-separator --

alter table idxpart detach partition idxpart1

-- sqlfmt-corpus-separator --

alter table idxpart detach partition idxpart2

-- sqlfmt-corpus-separator --

alter table idxpart detach partition idxpart3

-- sqlfmt-corpus-separator --

alter table idxpart1 attach partition idxpart11 for values from (0) to (1000)

-- sqlfmt-corpus-separator --

alter table idxpart_c attach partition idxpart1_c for values from (10) to (20)

-- sqlfmt-corpus-separator --

alter table idxpart_c detach partition idxpart1_c

-- sqlfmt-corpus-separator --

alter table inh_parent add constraint inh_parent_excl exclude ((1) with =)

-- sqlfmt-corpus-separator --

alter table inhpar attach partition inhcld1 for values from (1) to (5)

-- sqlfmt-corpus-separator --

alter table inhpar attach partition inhcld2 for values from (5) to (100)

-- sqlfmt-corpus-separator --

alter table mlparted attach partition mlparted1 for values from (1, 2) to (1, 10)

-- sqlfmt-corpus-separator --

alter table mlparted attach partition mlparted2 for values from (1, 10) to (1, 20)

-- sqlfmt-corpus-separator --

alter table mlparted attach partition mlparted4 for values from (1, 30) to (1, 40)

-- sqlfmt-corpus-separator --

alter table mlparted attach partition mlparted5 for values from (1, 40) to (1, 50)

-- sqlfmt-corpus-separator --

alter table mlparted1 attach partition mlparted11 for values from (2) to (5)

-- sqlfmt-corpus-separator --

alter table mlparted5 attach partition mlparted5a for values in ('a')

-- sqlfmt-corpus-separator --

alter table mlparted5_ab attach partition mlparted5_b for values in ('b')

-- sqlfmt-corpus-separator --

alter table nv_child_2011 VALIDATE CONSTRAINT nv_child_2011_d_check

-- sqlfmt-corpus-separator --

alter table only parent enable always trigger tg

-- sqlfmt-corpus-separator --

alter table only parted_replica_tab_1 replica identity
  using index parted_replica_idx_1

-- sqlfmt-corpus-separator --

alter table only trigger_parted_p2 disable trigger aft_row

-- sqlfmt-corpus-separator --

alter table p attach partition p1 for values from (1, 2) to (1, 10)

-- sqlfmt-corpus-separator --

alter table p1 attach partition p11 for values from (2) to (5)

-- sqlfmt-corpus-separator --

alter table parent attach partition child for values in ('AAA')

-- sqlfmt-corpus-separator --

alter table parent attach partition child1 for values in ('AAA')

-- sqlfmt-corpus-separator --

alter table parent attach partition child2 for values in ('BBB')

-- sqlfmt-corpus-separator --

alter table parent attach partition child3 for values in ('CCC')

-- sqlfmt-corpus-separator --

alter table parent detach partition child

-- sqlfmt-corpus-separator --

alter table parent disable trigger all

-- sqlfmt-corpus-separator --

alter table parent disable trigger tg

-- sqlfmt-corpus-separator --

alter table parent disable trigger user

-- sqlfmt-corpus-separator --

alter table parent enable always trigger tg

-- sqlfmt-corpus-separator --

alter table parent enable always trigger tg_stmt

-- sqlfmt-corpus-separator --

alter table parent_noinh_convalid validate constraint check_a_is_2

-- sqlfmt-corpus-separator --

alter table part_abc attach partition part_abc_1 for values in (1)

-- sqlfmt-corpus-separator --

alter table part_abc attach partition part_abc_2 for values in (2)

-- sqlfmt-corpus-separator --

alter table part_abc attach partition part_bac for values in(1)

-- sqlfmt-corpus-separator --

alter table part_bac attach partition part_cab for values in(2)

-- sqlfmt-corpus-separator --

alter table part_cab attach partition part_abc_p1 for values in(3)

-- sqlfmt-corpus-separator --

alter table parted_ch attach partition parted_ch_2 for values from (10) to (20)

-- sqlfmt-corpus-separator --

alter table parted_conflict attach partition parted_conflict_1 for values from (0) to (1000)

-- sqlfmt-corpus-separator --

alter table parted_conflict_test attach partition parted_conflict_test_2 for values in (3)

-- sqlfmt-corpus-separator --

alter table parted_constr attach partition parted1_constr
  for values from ('aaaa') to ('bbbb')

-- sqlfmt-corpus-separator --

alter table parted_constr_ancestor attach partition parted_constr
  for values from ('aaaa') to ('zzzz')

-- sqlfmt-corpus-separator --

alter table parted_copytest attach partition parted_copytest_a1 for values in(1)

-- sqlfmt-corpus-separator --

alter table parted_copytest attach partition parted_copytest_a2 for values in(2)

-- sqlfmt-corpus-separator --

alter table parted_inval_tab attach partition parted_inval_tab_1
  for values from (1) to (100)

-- sqlfmt-corpus-separator --

alter table parted_irreg attach partition parted1_irreg
  for values from ('aaaa') to ('bbbb')

-- sqlfmt-corpus-separator --

alter table parted_irreg_ancestor attach partition parted_irreg
  for values from ('aaaa') to ('zzzz')

-- sqlfmt-corpus-separator --

alter table parted_pk_detach_test detach partition parted_pk_detach_test1

-- sqlfmt-corpus-separator --

alter table parted_stmt_trig enable trigger trig_ins_after_parent

-- sqlfmt-corpus-separator --

alter table parted_trig attach partition parted_trig3 for values in (3)

-- sqlfmt-corpus-separator --

alter table parted_trigger attach partition parted_trigger_2 for values from (1000) to (2000)

-- sqlfmt-corpus-separator --

alter table parted_trigger attach partition parted_trigger_3 for values from (2000) to (3000)

-- sqlfmt-corpus-separator --

alter table parted_uniq_detach_test detach partition parted_uniq_detach_test1

-- sqlfmt-corpus-separator --

alter table parted_validate_test validate constraint parted_validate_test_chka

-- sqlfmt-corpus-separator --

alter table pc_list_parted detach partition pc_list_part_null

-- sqlfmt-corpus-separator --

alter table perm_part_parent attach partition temp_part_child default

-- sqlfmt-corpus-separator --

alter table permtest_child attach partition permtest_grandchild for values in ('a')

-- sqlfmt-corpus-separator --

alter table permtest_parent attach partition permtest_child for values in (1)

-- sqlfmt-corpus-separator --

alter table pk attach partition pk2 for values from (1000) to (2000)

-- sqlfmt-corpus-separator --

alter table pk attach partition pk4 for values from (3000) to (4000)

-- sqlfmt-corpus-separator --

alter table pk attach partition pk5 for values from (4000) to (5000)

-- sqlfmt-corpus-separator --

alter table returningwrtest attach partition returningwrtest2 for values in (2)

-- sqlfmt-corpus-separator --

alter table rlp attach partition rlp3 for values from (15) to (20)

-- sqlfmt-corpus-separator --

alter table rls_t enable row level security

-- sqlfmt-corpus-separator --

alter table target_parted attach partition attach_parted for values in (1)

-- sqlfmt-corpus-separator --

alter table target_parted detach partition attach_parted

-- sqlfmt-corpus-separator --

alter table temp_part_parent attach partition perm_part_child default

-- sqlfmt-corpus-separator --

alter table temp_part_parent attach partition temp_part_child default

-- sqlfmt-corpus-separator --

alter table test_storage alter a set storage default

-- sqlfmt-corpus-separator --

alter table test_storage alter a set storage plain

-- sqlfmt-corpus-separator --

alter table test_storage alter column a set storage external

-- sqlfmt-corpus-separator --

alter table toasttest alter column f1 set storage external

-- sqlfmt-corpus-separator --

alter table trg_clone add constraint uniq unique (a) deferrable

-- sqlfmt-corpus-separator --

alter table trigger_parted_p2_2 enable always trigger aft_row

-- sqlfmt-corpus-separator --

alter table trigpart attach partition trigpart3 for values from (2000) to (3000)

-- sqlfmt-corpus-separator --

alter table trigpart detach partition trigpart3

-- sqlfmt-corpus-separator --

alter table trigpart detach partition trigpart4

-- sqlfmt-corpus-separator --

alter table trigpart4 attach partition trigpart42 for values from (3500) to (4000)

-- sqlfmt-corpus-separator --

alter table trigtest disable trigger all

-- sqlfmt-corpus-separator --

alter table trigtest disable trigger trigtest_b_row_tg

-- sqlfmt-corpus-separator --

alter table trigtest disable trigger user

-- sqlfmt-corpus-separator --

alter table trigtest enable always trigger trigtest_a_stmt_tg

-- sqlfmt-corpus-separator --

alter table trigtest enable trigger trigtest_a_stmt_tg

-- sqlfmt-corpus-separator --

alter table tt14t alter column f4 type integer using f4::integer

-- sqlfmt-corpus-separator --

alter table utrtest attach partition utr1 for values in (1)

-- sqlfmt-corpus-separator --

alter table utrtest attach partition utr2 for values in (2)

-- sqlfmt-corpus-separator --

alter table uv_pt attach partition uv_pt1 for values from (1, 2) to (1, 10)

-- sqlfmt-corpus-separator --

alter table uv_pt1 attach partition uv_pt11 for values from (2) to (5)

-- sqlfmt-corpus-separator --

alter table wcowrtest attach partition wcowrtest2 for values in (2)

-- sqlfmt-corpus-separator --

alter type comptype alter attribute r type bigint

-- sqlfmt-corpus-separator --

alter type comptype alter attribute r type varchar

-- sqlfmt-corpus-separator --

alter type comptype drop attribute i

-- sqlfmt-corpus-separator --

alter type comptype drop attribute r

-- sqlfmt-corpus-separator --

alter type rewritetype alter attribute a type text cascade

-- sqlfmt-corpus-separator --

alter type rewritetype alter attribute a type varchar cascade

-- sqlfmt-corpus-separator --

alter type two_ints add attribute c two_ints_multirange

-- sqlfmt-corpus-separator --

alter type two_ints add attribute c two_ints_range

-- sqlfmt-corpus-separator --

alter view base_tab_def_view alter b set default 'View default'

-- sqlfmt-corpus-separator --

alter view base_tab_def_view alter d set default 'View default'

-- sqlfmt-corpus-separator --

alter view base_tab_view alter column c set default 'View default'

-- sqlfmt-corpus-separator --

alter view my_locks reset (autovacuum_enabled)

-- sqlfmt-corpus-separator --

alter view my_locks reset (security_barrier)

-- sqlfmt-corpus-separator --

alter view my_locks set (autovacuum_enabled = false)

-- sqlfmt-corpus-separator --

alter view uv_iocu_view alter column bb set default 'view default'

-- sqlfmt-corpus-separator --

analyze agg_data_20k

-- sqlfmt-corpus-separator --

analyze agg_data_2k

-- sqlfmt-corpus-separator --

analyze atacc1("........pg.dropped.1........")

-- sqlfmt-corpus-separator --

analyze atacc1(a)

-- sqlfmt-corpus-separator --

analyze bigger_than_it_looks

-- sqlfmt-corpus-separator --

analyze bug_16784

-- sqlfmt-corpus-separator --

analyze exists_tbl

-- sqlfmt-corpus-separator --

analyze extremely_skewed

-- sqlfmt-corpus-separator --

analyze fkest

-- sqlfmt-corpus-separator --

analyze fkest1

-- sqlfmt-corpus-separator --

analyze gs_data_1

-- sqlfmt-corpus-separator --

analyze gtest32

-- sqlfmt-corpus-separator --

analyze j1

-- sqlfmt-corpus-separator --

analyze j2

-- sqlfmt-corpus-separator --

analyze j3

-- sqlfmt-corpus-separator --

analyze join_foo, join_bar

-- sqlfmt-corpus-separator --

analyze lprt_a

-- sqlfmt-corpus-separator --

analyze ma_test

-- sqlfmt-corpus-separator --

analyze matest0

-- sqlfmt-corpus-separator --

analyze matest1

-- sqlfmt-corpus-separator --

analyze nummultirange_test

-- sqlfmt-corpus-separator --

analyze numrange_test

-- sqlfmt-corpus-separator --

analyze onerow

-- sqlfmt-corpus-separator --

analyze patest0

-- sqlfmt-corpus-separator --

analyze patest1

-- sqlfmt-corpus-separator --

analyze patest2

-- sqlfmt-corpus-separator --

analyze permtest_parent

-- sqlfmt-corpus-separator --

analyze prt_tbl

-- sqlfmt-corpus-separator --

analyze prtx1

-- sqlfmt-corpus-separator --

analyze prtx2

-- sqlfmt-corpus-separator --

analyze q1

-- sqlfmt-corpus-separator --

analyze q2

-- sqlfmt-corpus-separator --

analyze rows

-- sqlfmt-corpus-separator --

analyze semijoin_unique_tbl

-- sqlfmt-corpus-separator --

analyze simple

-- sqlfmt-corpus-separator --

analyze sj

-- sqlfmt-corpus-separator --

analyze skewedtable

-- sqlfmt-corpus-separator --

analyze stts_t1

-- sqlfmt-corpus-separator --

analyze t

-- sqlfmt-corpus-separator --

analyze t3

-- sqlfmt-corpus-separator --

analyze t_gin_test_tbl

-- sqlfmt-corpus-separator --

analyze tbl_ra

-- sqlfmt-corpus-separator --

analyze tbl_rs

-- sqlfmt-corpus-separator --

analyze test_mode

-- sqlfmt-corpus-separator --

analyze test_multirange_gist

-- sqlfmt-corpus-separator --

analyze test_range_gist

-- sqlfmt-corpus-separator --

analyze tt3

-- sqlfmt-corpus-separator --

analyze tt4

-- sqlfmt-corpus-separator --

analyze tuplesest_parted

-- sqlfmt-corpus-separator --

analyze tuplesest_tab

-- sqlfmt-corpus-separator --

analyze unique_tbl_p

-- sqlfmt-corpus-separator --

begin transaction isolation level read committed

-- sqlfmt-corpus-separator --

begin transaction isolation level repeatable read

-- sqlfmt-corpus-separator --

begin transaction isolation level serializable

-- sqlfmt-corpus-separator --

comment on constraint at_partitioned_0_id_name_key on at_partitioned_0 is 'child 0 constraint'

-- sqlfmt-corpus-separator --

comment on constraint at_partitioned_1_id_name_key on at_partitioned_1 is 'child 1 constraint'

-- sqlfmt-corpus-separator --

comment on constraint at_partitioned_id_name_key on at_partitioned is 'parent constraint'

-- sqlfmt-corpus-separator --

comment on constraint c1 on domain dcomptype is 'random commentary'

-- sqlfmt-corpus-separator --

copy copy_default from stdin with (default E'\n')

-- sqlfmt-corpus-separator --

copy copy_default from stdin with (default E'\r')

-- sqlfmt-corpus-separator --

copy copytest3 from stdin csv header

-- sqlfmt-corpus-separator --

copy copytest5 from stdin (format csv, header '0')

-- sqlfmt-corpus-separator --

copy copytest5 from stdin (format csv, header '1')

-- sqlfmt-corpus-separator --

copy copytest5 from stdin (format csv, header 2)

-- sqlfmt-corpus-separator --

copy copytest5 from stdin (format csv, header 4)

-- sqlfmt-corpus-separator --

copy copytest5 from stdin (format csv, header 5)

-- sqlfmt-corpus-separator --

create index HSlot_hubname on HSlot using btree (hubname bpchar_ops)

-- sqlfmt-corpus-separator --

create index atref_idx on atref (((b).a))

-- sqlfmt-corpus-separator --

create index btree_tall_idx on btree_tall_tbl (t, id) with (fillfactor = 10)

-- sqlfmt-corpus-separator --

create index concurrently on idxpart (a)

-- sqlfmt-corpus-separator --

create index concurrently on idxpart1 ((a/b))

-- sqlfmt-corpus-separator --

create index concurrently on idxpart11 ((a/b))

-- sqlfmt-corpus-separator --

create index concurrently on idxpart2 ((a/b))

-- sqlfmt-corpus-separator --

create index gin_test_idx on gin_test_tbl using gin (i)
  with (fastupdate = on, gin_pending_list_limit = 4096)

-- sqlfmt-corpus-separator --

create index gist_pointidx2 on gist_point_tbl using gist(p) with (buffering = on, fillfactor=50)

-- sqlfmt-corpus-separator --

create index gist_pointidx3 on gist_point_tbl using gist(p) with (buffering = off)

-- sqlfmt-corpus-separator --

create index gist_pointidx4 on gist_point_tbl using gist(p) with (buffering = auto)

-- sqlfmt-corpus-separator --

create index gist_pointidx5 on gist_point_tbl using gist(p) with (buffering = invalid_value)

-- sqlfmt-corpus-separator --

create index gist_pointidx5 on gist_point_tbl using gist(p) with (fillfactor=101)

-- sqlfmt-corpus-separator --

create index gist_pointidx5 on gist_point_tbl using gist(p) with (fillfactor=9)

-- sqlfmt-corpus-separator --

create index gist_tbl_box_index_forcing_buffering on gist_tbl using gist (p)
  with (buffering=on, fillfactor=50)

-- sqlfmt-corpus-separator --

create index on anothertab(f2,f3)

-- sqlfmt-corpus-separator --

create index on at_partitioned (a)

-- sqlfmt-corpus-separator --

create index on at_partitioned (b)

-- sqlfmt-corpus-separator --

create index on bool_lp (b)

-- sqlfmt-corpus-separator --

create index on bool_rp (b,a)

-- sqlfmt-corpus-separator --

create index on btree_bpchar(f1 bpchar_ops) WITH (deduplicate_items=on)

-- sqlfmt-corpus-separator --

create index on btree_tall_tbl (id int4_ops(foo=1))

-- sqlfmt-corpus-separator --

create index on idxpart ((a + b))

-- sqlfmt-corpus-separator --

create index on idxpart ((b + 1))

-- sqlfmt-corpus-separator --

create index on idxpart (a collate "C")

-- sqlfmt-corpus-separator --

create index on idxpart (a text_pattern_ops)

-- sqlfmt-corpus-separator --

create index on idxpart (a)

-- sqlfmt-corpus-separator --

create index on idxpart (a) where b > 1000

-- sqlfmt-corpus-separator --

create index on idxpart (a, b)

-- sqlfmt-corpus-separator --

create index on idxpart (abs(b))

-- sqlfmt-corpus-separator --

create index on idxpart (col_keep)

-- sqlfmt-corpus-separator --

create index on idxpart(c)

-- sqlfmt-corpus-separator --

create index on idxpart1 ((a + 0))

-- sqlfmt-corpus-separator --

create index on idxpart1 ((a + b))

-- sqlfmt-corpus-separator --

create index on idxpart1 ((a+b)) where d = true

-- sqlfmt-corpus-separator --

create index on idxpart1 (a)

-- sqlfmt-corpus-separator --

create index on idxpart1 (a) where b > 1

-- sqlfmt-corpus-separator --

create index on idxpart1 (a, a)

-- sqlfmt-corpus-separator --

create index on idxpart1 (a, b)

-- sqlfmt-corpus-separator --

create index on idxpart1 (col_keep)

-- sqlfmt-corpus-separator --

create index on idxpart1 using hash (a)

-- sqlfmt-corpus-separator --

create index on idxpart11 (a)

-- sqlfmt-corpus-separator --

create index on idxpart2 (a collate "C")

-- sqlfmt-corpus-separator --

create index on idxpart2 (a collate "POSIX")

-- sqlfmt-corpus-separator --

create index on idxpart2 (a)

-- sqlfmt-corpus-separator --

create index on idxpart2 (a) where b > 1000

-- sqlfmt-corpus-separator --

create index on idxpart2 (abs(b))

-- sqlfmt-corpus-separator --

create index on idxpart2 (c, b)

-- sqlfmt-corpus-separator --

create index on idxpart22 (a)

-- sqlfmt-corpus-separator --

create index on idxpart_temp(a)

-- sqlfmt-corpus-separator --

create index on ma_test (b)

-- sqlfmt-corpus-separator --

create index on mclparted (a)

-- sqlfmt-corpus-separator --

create index on mcrparted1 (a, abs(b), c)

-- sqlfmt-corpus-separator --

create index on mcrparted2 (a, abs(b), c)

-- sqlfmt-corpus-separator --

create index on mcrparted3 (a, abs(b), c)

-- sqlfmt-corpus-separator --

create index on mcrparted4 (a, abs(b), c)

-- sqlfmt-corpus-separator --

create index on nestjsonb using gin(j jsonb_path_ops)

-- sqlfmt-corpus-separator --

create index on only idxpart ((a/b))

-- sqlfmt-corpus-separator --

create index on only idxpart (a text_pattern_ops)

-- sqlfmt-corpus-separator --

create index on only idxpart (a)

-- sqlfmt-corpus-separator --

create index on only idxpart1 ((a/b))

-- sqlfmt-corpus-separator --

create index on only idxpart1 (a)

-- sqlfmt-corpus-separator --

create index on only idxpart2 ((a/b))

-- sqlfmt-corpus-separator --

create index on only idxpart2 (a)

-- sqlfmt-corpus-separator --

create index on part_abc (a)

-- sqlfmt-corpus-separator --

create index on parted_copytest (b)

-- sqlfmt-corpus-separator --

create index on parted_index_col_drop (b)

-- sqlfmt-corpus-separator --

create index on parted_index_col_drop (b, c)

-- sqlfmt-corpus-separator --

create index on parted_index_col_drop (c)

-- sqlfmt-corpus-separator --

create index on permtest_parent (left(c, 3))

-- sqlfmt-corpus-separator --

create index on prt_tbl_1(a)

-- sqlfmt-corpus-separator --

create index on prt_tbl_2(a, b)

-- sqlfmt-corpus-separator --

create index on prtx2 (b)

-- sqlfmt-corpus-separator --

create index on prtx2 (c)

-- sqlfmt-corpus-separator --

create index on range_parted (a,b,c)

-- sqlfmt-corpus-separator --

create index on rangep (a)

-- sqlfmt-corpus-separator --

create index on semijoin_unique_tbl(a, b)

-- sqlfmt-corpus-separator --

create index on sk(a)

-- sqlfmt-corpus-separator --

create index on some_tab_child(f1, f2)

-- sqlfmt-corpus-separator --

create index on t (a)

-- sqlfmt-corpus-separator --

create index on t_gin_test_tbl using gin (i, j)

-- sqlfmt-corpus-separator --

create index on tbl_ra (b)

-- sqlfmt-corpus-separator --

create index on test_mode (a)

-- sqlfmt-corpus-separator --

create index on test_mutability(json_array(a returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_array(b returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_array(c returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_array(d returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_array(f1 returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_array(f2 returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_array(f3 returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_array(f4 returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_array(f5 returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_array(f6 returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_object('hello' value a returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_object('hello' value b returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_object('hello' value c returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_object('hello' value d returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_object('hello' value f1 returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_object('hello' value f2 returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_object('hello' value f3 returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_object('hello' value f4 returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_object('hello' value f5 returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_mutability(json_object('hello' value f6 returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_range_elem using spgist(int4range(i,i+10))

-- sqlfmt-corpus-separator --

create index on test_range_immutable(json_array(m returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_range_immutable(json_array(r returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_range_immutable(json_object('key' value m returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_range_immutable(json_object('key' value r returning jsonb))

-- sqlfmt-corpus-separator --

create index on test_table (a,b)

-- sqlfmt-corpus-separator --

create index on tidv (idv)

-- sqlfmt-corpus-separator --

create index on unique_tbl_p1(a)

-- sqlfmt-corpus-separator --

create index on unique_tbl_p2(a)

-- sqlfmt-corpus-separator --

create index on unique_tbl_p3(a)

-- sqlfmt-corpus-separator --

create index on xid8_t1 using btree(x)

-- sqlfmt-corpus-separator --

create index on xid8_t1 using hash(x)

-- sqlfmt-corpus-separator --

create index spgist_point_idx on spgist_point_tbl using spgist(p) with (fillfactor = 75)

-- sqlfmt-corpus-separator --

create index spgist_point_idx2 on spgist_point_tbl using spgist(p) with (fillfactor = 101)

-- sqlfmt-corpus-separator --

create index spgist_point_idx2 on spgist_point_tbl using spgist(p) with (fillfactor = 9)

-- sqlfmt-corpus-separator --

create index xx on test_mutability(json_arrayagg(a returning json))

-- sqlfmt-corpus-separator --

create index xx on test_mutability(json_arrayagg(a returning jsonb))

-- sqlfmt-corpus-separator --

create index xx on test_mutability(json_objectagg(a: b absent on null with unique keys returning json))

-- sqlfmt-corpus-separator --

create index xx on test_mutability(json_objectagg(a: b absent on null with unique keys returning jsonb))

-- sqlfmt-corpus-separator --

create schema fkpart0
  create table pkey (a int primary key)
  create table fk_part (a int) partition by list (a)
  create table fk_part_1 partition of fk_part
      (foreign key (a) references fkpart0.pkey) for values in (1)
  create table fk_part_23 partition of fk_part
      (foreign key (a) references fkpart0.pkey) for values in (2, 3)
      partition by list (a)
  create table fk_part_23_2 partition of fk_part_23 for values in (2)

-- sqlfmt-corpus-separator --

create schema fkpart1
  create table pkey (a int primary key)
  create table fk_part (a int) partition by list (a)
  create table fk_part_1 partition of fk_part for values in (1) partition by list (a)
  create table fk_part_1_1 partition of fk_part_1 for values in (1)

-- sqlfmt-corpus-separator --

create schema fkpart2
  create table pkey (a int primary key)
  create table fk_part (a int, constraint fkey foreign key (a) references fkpart2.pkey) partition by list (a)
  create table fk_part_1 partition of fkpart2.fk_part for values in (1) partition by list (a)
  create table fk_part_1_1 (a int, constraint my_fkey foreign key (a) references fkpart2.pkey)

-- sqlfmt-corpus-separator --

create schema fkpart3
  create table pkey (a int primary key)
  create table fk_part (a int, constraint fkey foreign key (a) references fkpart3.pkey deferrable initially immediate) partition by list (a)
  create table fk_part_1 partition of fkpart3.fk_part for values in (1) partition by list (a)
  create table fk_part_1_1 partition of fkpart3.fk_part_1 for values in (1)
  create table fk_part_2 partition of fkpart3.fk_part for values in (2)

-- sqlfmt-corpus-separator --

create schema s1
  create table abc (f1 int)

-- sqlfmt-corpus-separator --

create schema s2
  create table abc (f1 int)

-- sqlfmt-corpus-separator --

create table atref(b attbl check ((b).a is not null))

-- sqlfmt-corpus-separator --

create table defpart_attach_test_2 (like defpart_attach_test_d)

-- sqlfmt-corpus-separator --

create table fktable2(f1 int references pktable2 deferrable initially deferred)

-- sqlfmt-corpus-separator --

create table gin_test_tbl(i int4[]) with (autovacuum_enabled = off)

-- sqlfmt-corpus-separator --

create table gs_group_1 as
select g100, g10, sum(g::numeric), count(*), max(g::text)
from gs_data_1 group by cube (g1000, g100,g10)

-- sqlfmt-corpus-separator --

create table gs_hash_1 as
select g100, g10, sum(g::numeric), count(*), max(g::text)
from gs_data_1 group by cube (g1000, g100,g10)

-- sqlfmt-corpus-separator --

create table idxpart (a int4range, b int4range, c int4range, exclude USING GIST (a with =, b with =, c with &&)) partition by range (a, b)

-- sqlfmt-corpus-separator --

create table idxpart (a int4range, b int4range, c int4range, exclude USING GIST (b with =, c with &&)) partition by range (a)

-- sqlfmt-corpus-separator --

create table idxpart (a int4range, b int4range, exclude USING GIST (a with = )) partition by range (a, b)

-- sqlfmt-corpus-separator --

create table idxpart (a int4range, b int4range, exclude USING GIST (a with =, b with &&)) partition by range (a)

-- sqlfmt-corpus-separator --

create table idxpart (a int4range, b int4range, exclude USING GIST (a with =, b with =)) partition by range (a)

-- sqlfmt-corpus-separator --

create table idxpart (a int4range, b int4range, exclude USING GIST (a with =, b with =)) partition by range (a, b)

-- sqlfmt-corpus-separator --

create table idxpart (a int4range, exclude USING GIST (a with -|- )) partition by range (a)

-- sqlfmt-corpus-separator --

create table idxpart (a int4range, exclude USING GIST (a with = )) partition by range (a)

-- sqlfmt-corpus-separator --

create table idxpart0 (like idxpart)

-- sqlfmt-corpus-separator --

create table idxpart1 (like idxpart including indexes)

-- sqlfmt-corpus-separator --

create table idxpart1 (like idxpart)

-- sqlfmt-corpus-separator --

create table idxpart2 (c int, like idxpart)

-- sqlfmt-corpus-separator --

create table idxpart2 (like idxpart)

-- sqlfmt-corpus-separator --

create table inh_child3 (like inh_parent)

-- sqlfmt-corpus-separator --

create table mlparted11 (like mlparted1)

-- sqlfmt-corpus-separator --

create table mlparted4 (like mlparted)

-- sqlfmt-corpus-separator --

create table more_derived (like derived, b int) inherits (derived)

-- sqlfmt-corpus-separator --

create table p11 (like p1)

-- sqlfmt-corpus-separator --

create table pagg_test (x int, y int) with (autovacuum_enabled = off)

-- sqlfmt-corpus-separator --

create table parallel_write as execute prep_stmt

-- sqlfmt-corpus-separator --

create table parted_trig3 (like parted_trig)

-- sqlfmt-corpus-separator --

create table pk4 (like pk)

-- sqlfmt-corpus-separator --

create table pk5 (like pk) partition by range (a)

-- sqlfmt-corpus-separator --

create table test_range_excl(
  room int4range,
  speaker int4range,
  during tsrange,
  exclude using gist (room with =, during with &&),
  exclude using gist (speaker with =, during with &&)
)

-- sqlfmt-corpus-separator --

create table trig_table (fk int references refd_table initially deferred)

-- sqlfmt-corpus-separator --

create table trigpart3 (like trigpart)

-- sqlfmt-corpus-separator --

create table trigpart42 (like trigpart)

-- sqlfmt-corpus-separator --

create table twoconstraints (f1 int unique, f2 box,
                             exclude using gist(f2 with &&))

-- sqlfmt-corpus-separator --

create table uv_pt11 (like uv_pt1)

-- sqlfmt-corpus-separator --

create temp table copytest2 (like copytest)

-- sqlfmt-corpus-separator --

create temp table temp_parted_oncommit_test1
  partition of temp_parted_oncommit_test
  for values in (1) on commit preserve rows

-- sqlfmt-corpus-separator --

create temporary view vw_ord as select * from rows from(unnest(array[10,20],array['foo','bar'],array[1.0])) as z(a,b,c)

-- sqlfmt-corpus-separator --

create temporary view vw_rngfunc as
  select * from rows from(getrngfunc9(1),
                      getrngfunc7(1) AS (rngfuncid int, rngfuncsubid int, rngfuncname text),
                      getrngfunc1(1))
                with ordinality as t1(a,b,c,d,e,f,g,n)

-- sqlfmt-corpus-separator --

create unique index HSlot_name on HSlot using btree (slotname bpchar_ops)

-- sqlfmt-corpus-separator --

create unique index Hub_name on Hub using btree (name bpchar_ops)

-- sqlfmt-corpus-separator --

create unique index IFace_name on IFace using btree (slotname bpchar_ops)

-- sqlfmt-corpus-separator --

create unique index PField_name on PField using btree (name text_ops)

-- sqlfmt-corpus-separator --

create unique index PHone_name on PHone using btree (slotname bpchar_ops)

-- sqlfmt-corpus-separator --

create unique index PLine_name on PLine using btree (slotname bpchar_ops)

-- sqlfmt-corpus-separator --

create unique index PSlot_name on PSlot using btree (slotname bpchar_ops)

-- sqlfmt-corpus-separator --

create unique index Room_rno on Room using btree (roomno bpchar_ops)

-- sqlfmt-corpus-separator --

create unique index System_name on System using btree (name text_ops)

-- sqlfmt-corpus-separator --

create unique index WSlot_name on WSlot using btree (slotname bpchar_ops)

-- sqlfmt-corpus-separator --

create unique index both_index_key on insertconflicttest(key, fruit collate "C" text_pattern_ops)

-- sqlfmt-corpus-separator --

create unique index collation_index_key on insertconflicttest(key, fruit collate "C")

-- sqlfmt-corpus-separator --

create unique index hat_data_unique_idx
  on hat_data (hat_name COLLATE "C" bpchar_pattern_ops)

-- sqlfmt-corpus-separator --

create unique index on anothertab(f4)

-- sqlfmt-corpus-separator --

create unique index on covidxpart (a) include (b)

-- sqlfmt-corpus-separator --

create unique index on covidxpart (b) include (a)

-- sqlfmt-corpus-separator --

create unique index on covidxpart4 (a)

-- sqlfmt-corpus-separator --

create unique index on covidxpart4 (a) include (b)

-- sqlfmt-corpus-separator --

create unique index on cwi_test (a)

-- sqlfmt-corpus-separator --

create unique index on fkest(x, x10, x100)

-- sqlfmt-corpus-separator --

create unique index on idxpart (a)

-- sqlfmt-corpus-separator --

create unique index on idxpart1 (a)

-- sqlfmt-corpus-separator --

create unique index on j3(unique1, tenthous)

-- sqlfmt-corpus-separator --

create unique index on only parted_conflict (a)

-- sqlfmt-corpus-separator --

create unique index on only parted_conflict_1 (a)

-- sqlfmt-corpus-separator --

create unique index on parallel_mat_view(length)

-- sqlfmt-corpus-separator --

create unique index on parted_conflict (a, b)

-- sqlfmt-corpus-separator --

create unique index on sl(a, b)

-- sqlfmt-corpus-separator --

create unique index op_index_key on insertconflicttest(key, fruit text_pattern_ops)

-- sqlfmt-corpus-separator --

create unique index t2_z_uidx on t2(z) nulls not distinct

-- sqlfmt-corpus-separator --

create view composite_v as
with cte(c) as materialized (select row(1, 2)),
     cte2(c) as (select * from cte)
select 1 as one from cte2 as t
where (select * from (select c as c1) s
       where (select (c1).f1 > 0)) is not null

-- sqlfmt-corpus-separator --

create view rls_v with (security_invoker) as select * from rls_t

-- sqlfmt-corpus-separator --

create view tt24v as
with cte as materialized (select r from (values(1,2),(3,4)) r)
select (r).column2 as col_a, (rr).column2 as col_b from
  cte join (select rr from (values(1,7),(3,8)) rr limit 2) ss
  on (r).column1 = (rr).column1

-- sqlfmt-corpus-separator --

create view tt25v as
with cte as materialized (select pg_get_keywords() k)
select (k).word from cte

-- sqlfmt-corpus-separator --

delete from gtest_cursor where current of curs

-- sqlfmt-corpus-separator --

drop database if exists test_database_exists (force)

-- sqlfmt-corpus-separator --

drop database if exists test_database_exists with (force)

-- sqlfmt-corpus-separator --

drop database test_database_exists (force)

-- sqlfmt-corpus-separator --

drop database test_database_exists with (force)

-- sqlfmt-corpus-separator --

explain (costs off)
  select *
    from (values (1),(2)) v(x),
         lateral (select a, b, sum(v.x) from gstest_data(v.x) group by grouping sets (a,b)) s

-- sqlfmt-corpus-separator --

explain (costs off)
  select * from boolindex where b is false order by i desc limit 10

-- sqlfmt-corpus-separator --

explain (costs off)
  select * from boolindex where b is true order by i desc limit 10

-- sqlfmt-corpus-separator --

explain (costs off)
  select * from parted_sample tablesample bernoulli (100)

-- sqlfmt-corpus-separator --

explain (costs off)
  select a, b, grouping(a,b), array_agg(v order by v)
    from gstest1 group by cube(a,b)

-- sqlfmt-corpus-separator --

explain (costs off)
  select a, b, grouping(a,b), sum(v), count(*), max(v)
    from gstest1 group by grouping sets ((a,b),(a+1,b+1),(a+2,b+2)) order by 3,6

-- sqlfmt-corpus-separator --

explain (costs off)
  select a, b, sum(c), sum(sum(c)) over (order by a,b) as rsum
    from gstest2 group by cube (a,b) order by rsum, a, b

-- sqlfmt-corpus-separator --

explain (costs off)
  select a, b, sum(v), count(*) from gstest_empty group by grouping sets ((a,b),(),(),())

-- sqlfmt-corpus-separator --

explain (costs off)
  select a, b, sum(v), count(*) from gstest_empty group by grouping sets ((a,b),a)

-- sqlfmt-corpus-separator --

explain (costs off)
  select a, b, sum(v.x)
    from (values (1),(2)) v(x), gstest_data(v.x)
   group by cube (a,b) order by a,b

-- sqlfmt-corpus-separator --

explain (costs off)
  select a, b, sum(v.x)
    from (values (1),(2)) v(x), gstest_data(v.x)
   group by grouping sets (a,b)
   order by 3, 1, 2

-- sqlfmt-corpus-separator --

explain (costs off)
  select a, d, grouping(a,b,c)
    from gstest3
   group by grouping sets ((a,b), (a,c))

-- sqlfmt-corpus-separator --

explain (costs off)
  select a,count(*) from gstest2 group by rollup(a) having a is distinct from 1 order by a

-- sqlfmt-corpus-separator --

explain (costs off)
  select count(*) from person tablesample bernoulli (100)

-- sqlfmt-corpus-separator --

explain (costs off)
  select min(unique1) from tenk1 GROUP BY ()

-- sqlfmt-corpus-separator --

explain (costs off)
  select sum(v), count(*) from gstest_empty group by grouping sets ((),(),())

-- sqlfmt-corpus-separator --

explain (costs off)
  select unhashable_col, unsortable_col,
         grouping(unhashable_col, unsortable_col),
         count(*), sum(v)
    from gstest4 group by grouping sets ((unhashable_col),(unsortable_col))
   order by 3,5

-- sqlfmt-corpus-separator --

explain (costs off)
  select unhashable_col, unsortable_col,
         grouping(unhashable_col, unsortable_col),
         count(*), sum(v)
    from gstest4 group by grouping sets ((v,unhashable_col),(v,unsortable_col))
   order by 3,5

-- sqlfmt-corpus-separator --

explain (costs off)
  select unique1,
         count(two), count(four), count(ten),
         count(hundred), count(thousand), count(twothousand),
         count(*)
    from tenk1 group by grouping sets (unique1,hundred,ten,four,two)

-- sqlfmt-corpus-separator --

explain (costs off)
  select unique1,
         count(two), count(four), count(ten),
         count(hundred), count(thousand), count(twothousand),
         count(*)
    from tenk1 group by grouping sets (unique1,twothousand,thousand,hundred,ten,four,two)

-- sqlfmt-corpus-separator --

explain (costs off)
  select v.c, (select count(*) from gstest2 group by () having v.c)
    from (values (false),(true)) v(c) order by v.c

-- sqlfmt-corpus-separator --

explain (costs off)
select (select grouping(v1)) from (values ((select 1))) v(v1) group by cube(v1)

-- sqlfmt-corpus-separator --

explain (costs off)
select (select grouping(v1)) from (values ((select 1))) v(v1) group by v1

-- sqlfmt-corpus-separator --

explain (costs off)
select * from (select a, b from phv_boolpart) t
  where a is true
  group by grouping sets (a, b)

-- sqlfmt-corpus-separator --

explain (costs off)
select * from (select a, b from phv_part) t
  where a = 1
  group by grouping sets (a, b)

-- sqlfmt-corpus-separator --

explain (costs off)
select * from (select a, b from phv_part) t
  where a in (1, null)
  group by grouping sets (a, b)

-- sqlfmt-corpus-separator --

explain (costs off)
select * from (select a, b from phv_part) t
  where a is null
  group by grouping sets (a, b)

-- sqlfmt-corpus-separator --

explain (costs off)
select * from (select a::oid as x, b from phv_part) t
  where x::int = 1
  group by grouping sets (x, b)

-- sqlfmt-corpus-separator --

explain (costs off)
select * from gstest1 group by grouping sets((a,b,v),(v)) order by v,b,a

-- sqlfmt-corpus-separator --

explain (costs off)
select * from sj t1
    join lateral
      (select * from sj tablesample system(t1.b)) s
    on t1.a = s.a

-- sqlfmt-corpus-separator --

explain (costs off)
select 1 as one group by rollup(one) order by one nulls first

-- sqlfmt-corpus-separator --

explain (costs off)
select a < b and b < 3 from (values (1, 2)) t(a, b) group by rollup(a < b and b < 3) having a < b and b < 3

-- sqlfmt-corpus-separator --

explain (costs off)
select a, b
from (values (1, 1), (2, 2)) as t (a, b) where a = b
group by grouping sets((a, b), (a))
order by a, b nulls first

-- sqlfmt-corpus-separator --

explain (costs off)
select a, b, count(*) from gstest2 group by grouping sets ((a), (b)) having false

-- sqlfmt-corpus-separator --

explain (costs off)
select a, b, count(*) from gstest2 group by grouping sets ((a, b), (a)) having a > 1 and b > 1

-- sqlfmt-corpus-separator --

explain (costs off)
select a, b, count(*) from gstest2 group by rollup(a), b having b > 1

-- sqlfmt-corpus-separator --

explain (costs off)
select a, b, row_number() over (order by a, b nulls first)
from (values (1, 1), (2, 2)) as t (a, b) where a = b
group by grouping sets((a, b), (a))

-- sqlfmt-corpus-separator --

explain (costs off)
select a, count(*) from gstest2 group by grouping sets ((a), ()) having false

-- sqlfmt-corpus-separator --

explain (costs off)
select count(*) from gstest2 group by grouping sets (()) having false

-- sqlfmt-corpus-separator --

explain (costs off)
select d.* from d left join (select 1 as x from b group by ()) s
  on d.a = s.x

-- sqlfmt-corpus-separator --

explain (costs off)
select d.* from d left join (select 1 as x from b group by distinct grouping sets((), ())) s
  on d.a = s.x

-- sqlfmt-corpus-separator --

explain (costs off)
select d.* from d left join (select 1 as x from b group by grouping sets(())) s
  on d.a = s.x

-- sqlfmt-corpus-separator --

explain (costs off)
select d.* from d left join (select 1 as x from b group by grouping sets(()), grouping sets(())) s
  on d.a = s.x

-- sqlfmt-corpus-separator --

explain (costs off)
select d.* from d left join (select 1 as x from b group by grouping sets((), ())) s
  on d.a = s.x

-- sqlfmt-corpus-separator --

explain (costs off)
select d.* from d left join (select 1 as x from b group by grouping sets((), grouping sets(()))) s
  on d.a = s.x

-- sqlfmt-corpus-separator --

explain (costs off)
select d.* from d left join (select 1 as x from b group by rollup(x)) s
  on d.a = s.x

-- sqlfmt-corpus-separator --

explain (costs off)
select distinct on (a, b) a, b
from (values (1, 1), (2, 2)) as t (a, b) where a = b
group by grouping sets((a, b), (a))
order by a, b

-- sqlfmt-corpus-separator --

explain (costs off)
select distinct on (a, b+1) a, b+1
from (values (1, 0), (2, 1)) as t (a, b) where a = b+1
group by grouping sets((a, b+1), (a))
order by a, b+1

-- sqlfmt-corpus-separator --

explain (costs off)
select g as alias1, g as alias2
  from generate_series(1,3) g
 group by alias1, rollup(alias2)

-- sqlfmt-corpus-separator --

explain (costs off)
select g100, g10, sum(g::numeric), count(*), max(g::text)
from gs_data_1 group by cube (g1000, g100,g10)

-- sqlfmt-corpus-separator --

explain (costs off)
select not a from (values(true)) t(a) group by rollup(not a) having not not a

-- sqlfmt-corpus-separator --

explain (costs off)
select p from
  (values (box(point(0,0), point(0.5,0.5))),
          (box(point(0.5,0.5), point(0.75,0.75))),
          (box(point(0.8,0.8), point(1.0,1.0)))) as v(bb)
cross join lateral
  (select p from gist_tbl where p <@ bb order by p <-> bb[0] limit 2) ss

-- sqlfmt-corpus-separator --

explain (costs off)
select pct, count(unique1) from
  (values (0),(100)) v(pct),
  lateral (select * from tenk1 tablesample bernoulli (pct)) ss
  group by pct

-- sqlfmt-corpus-separator --

explain (costs off)
select x, y
  from (select t1.unique1 as x, t1.unique2 as y from tenk1 t1, tenk1 t2) as t
  where x = 1
  group by grouping sets (x, y)
  order by 1, 2

-- sqlfmt-corpus-separator --

explain (costs off)
select x, y
  from (select unique1 as x, unique2 as y from tenk1) as t
  where x = 1
  group by grouping sets (x, y)
  order by 1, 2

-- sqlfmt-corpus-separator --

explain (costs off)
select x, y
  from (select unique1::oid as x, unique2 as y from tenk1) as t
  where x::integer = 1
  group by grouping sets (x, y)
  order by 1, 2

-- sqlfmt-corpus-separator --

explain (costs off)  select * from boolrangep where a is not false and not b and c = 25

-- sqlfmt-corpus-separator --

explain (costs off)  select * from boolrangep where a is not true and not b and c = 25

-- sqlfmt-corpus-separator --

explain (costs off) create table parallel_write as execute prep_stmt

-- sqlfmt-corpus-separator --

explain (costs off) insert into insertconflicttest values(0, 'Crowberry') on conflict (fruit collate "C" text_pattern_ops, key) do nothing

-- sqlfmt-corpus-separator --

explain (costs off) insert into insertconflicttest values(0, 'Crowberry') on conflict (fruit, key, fruit text_pattern_ops, key) do nothing

-- sqlfmt-corpus-separator --

explain (costs off) insert into insertconflicttest values(0, 'Crowberry') on conflict (key, fruit collate "C") do nothing

-- sqlfmt-corpus-separator --

explain (costs off) insert into insertconflicttest values(0, 'Crowberry') on conflict (key, fruit text_pattern_ops) do nothing

-- sqlfmt-corpus-separator --

explain (costs off) select * from boolpart where a is false and a is unknown

-- sqlfmt-corpus-separator --

explain (costs off) select * from boolpart where a is not false

-- sqlfmt-corpus-separator --

explain (costs off) select * from boolpart where a is not true

-- sqlfmt-corpus-separator --

explain (costs off) select * from boolpart where a is not true and a is not false

-- sqlfmt-corpus-separator --

explain (costs off) select * from boolpart where a is not unknown

-- sqlfmt-corpus-separator --

explain (costs off) select * from boolpart where a is not unknown and a is unknown

-- sqlfmt-corpus-separator --

explain (costs off) select * from boolpart where a is true and a is unknown

-- sqlfmt-corpus-separator --

explain (costs off) select * from boolpart where a is true or a is not true

-- sqlfmt-corpus-separator --

explain (costs off) select * from boolpart where a is unknown

-- sqlfmt-corpus-separator --

explain (costs off) select * from iboolpart where a is not true

-- sqlfmt-corpus-separator --

explain (costs off) select * from iboolpart where a is not true and a is not false

-- sqlfmt-corpus-separator --

explain (costs off) select * from iboolpart where a is not unknown

-- sqlfmt-corpus-separator --

explain (costs off) select * from iboolpart where a is true or a is not true

-- sqlfmt-corpus-separator --

explain (costs off) select * from iboolpart where a is unknown

-- sqlfmt-corpus-separator --

explain (costs off) select a, b, grouping(a,b), sum(v), count(*), max(v)
  from gstest1 group by cube(a,b) order by 3,1,2

-- sqlfmt-corpus-separator --

explain (costs off) select a, b, grouping(a,b), sum(v), count(*), max(v)
  from gstest1 group by grouping sets ((a),(b)) order by 3,1,2

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
  update dcomptable set d1.r = (d1).r - 1, d1.i = (d1).i + 1 where (d1).i > 0

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
  update dcomptable set d1[1].r = d1[1].r - 1, d1[1].i = d1[1].i + 1
    where d1[1].i > 0

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select (r).column2 from (select r from (values(1,2),(3,4)) r limit 1) ss

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select (select grouping(ss.x))
from int8_tbl i1
cross join lateral (select (select i1.q1) as x) ss
group by ss.x

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select (ss.a).x, (ss.a).n from
  (select information_schema._pg_expandarray(array[1,2]) AS a) ss

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select (ss.a).x, (ss.a).n from
  (select information_schema._pg_expandarray(array[1,2]) AS a) ss
where false

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select (t2.*).unique1, f_field_select(t2) from tenk1 t1
    left join onek t2 on t1.unique1 = t2.unique1
    left join int8_tbl t3 on true

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select * from
  int8_tbl a left join lateral
  (select b.q1 as bq1, c.q1 as cq1, least(a.q1,b.q1,c.q1) from
   int8_tbl b cross join int8_tbl c) ss
  on a.q2 = ss.bq1

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select * from (
  select 1 as x, q1, sum(q2)
  from int8_tbl i1
  group by grouping sets(1, 2)
) ss
where x = 1 and q1 = 123

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select * from (values (0), (1)) v(id),
lateral (select * from int8_tbl t1,
         lateral (select * from
                    (select * from int8_tbl t2
                     where (q1, random() > 0) = any (select q2, random() > 0 from int8_tbl t3
                                     where q2 = (select greatest(t1.q1,t2.q2))
                                       and (select v.id=0)) offset 0) ss2) ss
         where t1.q1 = ss.q2) ss0

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select * from gtest32 t group by grouping sets (a, b, c, d, e, f) having c = 20

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select * from json_tab t1 left join (select json_array(1, a) from json_tab t2) s on false

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select generate_series(1, a) as g
from (values (1, 1), (2, 2)) as t (a, b)
group by rollup(g)
order by 1

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select generate_series(1, a) as g, a+b as ab
from (values (1, 1), (2, 2)) as t (a, b)
group by rollup(a, ab)
order by 1, 2

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select grouping((select t1.v from gstest5 t2 where id = t1.id)),
       (select t1.v from gstest5 t2 where id = t1.id) as s
from gstest5 t1
group by grouping sets(v, s)
order by case when grouping((select t1.v from gstest5 t2 where id = t1.id)) = 0
              then (select t1.v from gstest5 t2 where id = t1.id)
              else null end
         nulls first

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select grouping((select t1.v from gstest5 t2 where id = t1.id)),
       (select t1.v from gstest5 t2 where id = t1.id) as s,
       case when grouping((select t1.v from gstest5 t2 where id = t1.id)) = 0
            then (select t1.v from gstest5 t2 where id = t1.id)
            else null end as o
from gstest5 t1
group by grouping sets(v, s)
order by o nulls first

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select grouping(ss.x)
from int8_tbl i1
cross join lateral (select (select i1.q1) as x) ss
group by ss.x

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
select t1.b, ss.phv from join_ut1 t1 left join lateral
              (select t2.a as t2a, t3.a t3a, least(t1.a, t2.a, t3.a) phv
					  from join_pt1 t2 join join_ut1 t3 on t2.a = t3.b) ss
              on t1.a = ss.t2a order by t1.a

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
update inhpar i set (f1, f2) = (select i.f1, i.f2 || '-' from int4_tbl limit 1)

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
with cte(c) as materialized (select row(1, 2)),
     cte2(c) as (select * from cte)
select (c).f1 from cte2 as t

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
with cte(c) as materialized (select row(1, 2)),
     cte2(c) as (select * from cte)
select (c).f1 from cte2 as t
where false

-- sqlfmt-corpus-separator --

explain (verbose, costs off)
with cte(c) as materialized (select row(1, 2)),
     cte2(c) as (select * from cte)
select * from cte2 as t
where (select * from (select c as c1) s
       where (select (c1).f1 > 0)) is not null

-- sqlfmt-corpus-separator --

insert into anothertab (atcol1, atcol2) values (default, false)

-- sqlfmt-corpus-separator --

insert into anothertab (atcol1, atcol2) values (default, null)

-- sqlfmt-corpus-separator --

insert into anothertab (atcol1, atcol2) values (default, true)

-- sqlfmt-corpus-separator --

insert into arr_pk_tbl values (1, '{3,4,5}') on conflict (pk)
  do update set f1[1] = excluded.f1[1], f1[3] = excluded.f1[3]
  returning pk, f1

-- sqlfmt-corpus-separator --

insert into arr_pk_tbl(pk, f1[1:2]) values (1, '{6,7,8}') on conflict (pk)
  do update set f1[1] = excluded.f1[1],
    f1[2] = excluded.f1[2],
    f1[3] = excluded.f1[3]
  returning pk, f1

-- sqlfmt-corpus-separator --

insert into atacc1 ("........pg.dropped.1........") values (default)

-- sqlfmt-corpus-separator --

insert into atacc1 ("........pg.dropped.1........",b,c,d) values (default,11,12,13)

-- sqlfmt-corpus-separator --

insert into atacc1 (a) values (default)

-- sqlfmt-corpus-separator --

insert into atacc1 (a,b,c,d) values (default,11,12,13)

-- sqlfmt-corpus-separator --

insert into atacc1 values (default, 11, 12, 13)

-- sqlfmt-corpus-separator --

insert into base_tab_def values (4, default, default, default, default)

-- sqlfmt-corpus-separator --

insert into base_tab_def values (5, default, default, default, default),
                                (6, default, default, default, default)

-- sqlfmt-corpus-separator --

insert into base_tab_def_view values (1, default, default, default, default)

-- sqlfmt-corpus-separator --

insert into base_tab_def_view values (14, default, default, default, default)

-- sqlfmt-corpus-separator --

insert into base_tab_def_view values (15, default, default, default, default),
                                     (16, default, default, default, default)

-- sqlfmt-corpus-separator --

insert into base_tab_def_view values (17), (default)

-- sqlfmt-corpus-separator --

insert into base_tab_def_view values (2, default, default, default, default),
                                     (3, default, default, default, default)

-- sqlfmt-corpus-separator --

insert into base_tab_view (b[1], b[2], c, b[5], b[4], a, b[3])
values (1, 2, default, 5, 4, default, 3), (10, 11, 'C value', 14, 13, 100, 12)

-- sqlfmt-corpus-separator --

insert into inhpar as i values (3), (7) on conflict (f1)
  do update set (f1, f2) = (select i.f1, i.f2 || '+')

-- sqlfmt-corpus-separator --

insert into insertconflicttest
values (1, 'Apple'), (2, 'Orange')
on conflict (key) do update set (fruit, key) = (excluded.fruit, excluded.key)

-- sqlfmt-corpus-separator --

insert into insertconflicttest values (1) on conflict (key int4_ops (fillfactor=10)) do nothing

-- sqlfmt-corpus-separator --

insert into inserttest (col1) values (DEFAULT, DEFAULT)

-- sqlfmt-corpus-separator --

insert into inserttest (col1, col2, col3) values (DEFAULT, 5, DEFAULT)

-- sqlfmt-corpus-separator --

insert into inserttest (col1, col2, col3) values (DEFAULT, DEFAULT)

-- sqlfmt-corpus-separator --

insert into inserttest (col1, col2, col3) values (DEFAULT, DEFAULT, DEFAULT)

-- sqlfmt-corpus-separator --

insert into inserttest (col2, col3) values (3, DEFAULT)

-- sqlfmt-corpus-separator --

insert into inserttest (f2[1], f2[2]) values (1,default)

-- sqlfmt-corpus-separator --

insert into inserttest (f3.if1, f3.if2) values (1,default)

-- sqlfmt-corpus-separator --

insert into inserttest values (DEFAULT, 5, 'test')

-- sqlfmt-corpus-separator --

insert into inserttest values (DEFAULT, 7)

-- sqlfmt-corpus-separator --

insert into inserttest values(10, 20, '40'), (-1, 2, DEFAULT),
    ((select 2), (select i from (values(3)) as foo (i)), 'values are fun!')

-- sqlfmt-corpus-separator --

insert into inserttesta (f2[1], f2[2]) values (1,default)

-- sqlfmt-corpus-separator --

insert into inserttestb (f3.if1, f3.if2) values (1,default)

-- sqlfmt-corpus-separator --

insert into parted_conflict values (50, 'cincuenta', 2)
  on conflict (a, b) do update set (a, b, c) = row(excluded.*)
  where parted_conflict = (50, text 'cincuenta', 1) and
        excluded = (50, text 'cincuenta', 2)

-- sqlfmt-corpus-separator --

insert into rules_src values(22,23), (33,default)

-- sqlfmt-corpus-separator --

insert into t1 values($1)

-- sqlfmt-corpus-separator --

insert into trunc_trigger_log values
      (TG_OP, TG_LEVEL, TG_WHEN, TG_ARGV[0], tg_table_name, c)

-- sqlfmt-corpus-separator --

lock table pxtest3 in access share mode nowait

-- sqlfmt-corpus-separator --

prepare ab_q1 (int, int) as
select a from ab where a between $1 and $2 and b < 3

-- sqlfmt-corpus-separator --

prepare ab_q1 (int, int, int) as
select * from ab where a between $1 and $2 and b <= $3

-- sqlfmt-corpus-separator --

prepare ab_q2 (int, int) as
select a from ab where a between $1 and $2 and b < (select 3)

-- sqlfmt-corpus-separator --

prepare ab_q3 (int, int) as
select a from ab where b between $1 and $2 and a < (select 3)

-- sqlfmt-corpus-separator --

prepare ab_q4 (int, int) as
select avg(a) from ab where a between $1 and $2 and b < 4

-- sqlfmt-corpus-separator --

prepare ab_q5 (int, int, int) as
select avg(a) from ab where a in($1,$2,$3) and b < 4

-- sqlfmt-corpus-separator --

prepare ab_q6 as
select * from (
	select tableoid::regclass,a,b from ab
union all
	select tableoid::regclass,x,y from xy_1
union all
	select tableoid::regclass,a,b from ab
) ab where a = $1 and b = (select -10)

-- sqlfmt-corpus-separator --

prepare foo(bool) as
  select count(*) from tenk1 a left join tenk1 b
    on (a.unique2 = b.unique1 and exists
        (select 1 from tenk1 c where c.thousand = b.unique2 and $1))

-- sqlfmt-corpus-separator --

prepare hp_q1 (text) as
select * from hp where a is null and b = $1

-- sqlfmt-corpus-separator --

prepare mt_q1 (int) as select a from ma_test where a >= $1 and a % 10 = 5 order by b

-- sqlfmt-corpus-separator --

prepare mt_q2 (int) as select * from ma_test where a >= $1 order by b limit 1

-- sqlfmt-corpus-separator --

prepare part_abc_q1 (int, int, int) as
select * from part_abc where a = $1 and b = $2 and c = $3

-- sqlfmt-corpus-separator --

prepare ps1 as
  select * from mc3p where a = $1 and abs(b) < (select 3)

-- sqlfmt-corpus-separator --

prepare ps2 as
  select * from mc3p where a <= $1 and abs(b) < (select 3)

-- sqlfmt-corpus-separator --

prepare pstmt_def_insert (int) as insert into pc_list_part_def values($1)

-- sqlfmt-corpus-separator --

prepare q (int, int) as
select *
from (
      select * from p
      union all
      select * from q1
      union all
      select 1, 1, 1
     ) s(a, b, c)
where s.a = $1 and s.b = $2 and s.c = (select 1)

-- sqlfmt-corpus-separator --

prepare q1 (int,int) as select * from listp where b in ($1,$2)

-- sqlfmt-corpus-separator --

prepare q1 (int,int,int,int) as select * from listp where b in($1,$2) and $3 <> b and $4 <> b

-- sqlfmt-corpus-separator --

prepare s1 as select $1::pos_int = 10 as "is_ten"

-- sqlfmt-corpus-separator --

prepare tenk1_count(integer) As select  count((unique1)) from tenk1 where hundred > $1

-- sqlfmt-corpus-separator --

prepare test_mode_pp (int) as select count(*) from test_mode where a = $1

-- sqlfmt-corpus-separator --

prepare update_part_abc_view as update part_abc_view set b = $2 where a = $1 returning *

-- sqlfmt-corpus-separator --

select ('123'::jsonb)['a']

-- sqlfmt-corpus-separator --

select ('123'::jsonb)[0]

-- sqlfmt-corpus-separator --

select ('123'::jsonb)[NULL]

-- sqlfmt-corpus-separator --

select ('123.45'::jsonb).numeric

-- sqlfmt-corpus-separator --

select ('["a", "b", "c"]'::jsonb).jsonb_array_length

-- sqlfmt-corpus-separator --

select ('[0:2][0:2]={{1,2,3},{4,5,6},{7,8,9}}'::int[])[1:2][2]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)['1']

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)['a']

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[-2]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[0]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[1.0]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[1:2]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[1:]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[1]['a']

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[1][0]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[2]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[3]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[:2]

-- sqlfmt-corpus-separator --

select ('[1, "2", null]'::jsonb)[:]

-- sqlfmt-corpus-separator --

select ('[{"name": "alice"}, {"name": "bob"}]'::jsonb).name

-- sqlfmt-corpus-separator --

select ('true'::jsonb).bool

-- sqlfmt-corpus-separator --

select ('{"a": 1, "b": "c", "d": [1, 2, 3]}'::jsonb)['b']

-- sqlfmt-corpus-separator --

select ('{"a": 1, "b": "c", "d": [1, 2, 3]}'::jsonb)['d']

-- sqlfmt-corpus-separator --

select ('{"a": 1, "b": "c", "d": [1, 2, 3]}'::jsonb)['d']['a']

-- sqlfmt-corpus-separator --

select ('{"a": 1, "b": "c", "d": [1, 2, 3]}'::jsonb)['d'][1]

-- sqlfmt-corpus-separator --

select ('{"a": 1}'::jsonb)['a':'b']

-- sqlfmt-corpus-separator --

select ('{"a": 1}'::jsonb)['a']

-- sqlfmt-corpus-separator --

select ('{"a": 1}'::jsonb)['not_exist']

-- sqlfmt-corpus-separator --

select ('{"a": 1}'::jsonb)[0]

-- sqlfmt-corpus-separator --

select ('{"a": 1}'::jsonb)[NULL]

-- sqlfmt-corpus-separator --

select ('{"a": ["a1", {"b1": ["aaa", "bbb", "ccc"]}], "b": "bb"}'::jsonb)['a'][1]['b1']

-- sqlfmt-corpus-separator --

select ('{"a": ["a1", {"b1": ["aaa", "bbb", "ccc"]}], "b": "bb"}'::jsonb)['a'][1]['b1'][2]

-- sqlfmt-corpus-separator --

select ('{"a": {"a1": {"a2": "aaa"}}, "b": "bbb", "c": "ccc"}'::jsonb)['a']['a1']

-- sqlfmt-corpus-separator --

select ('{"a": {"a1": {"a2": "aaa"}}, "b": "bbb", "c": "ccc"}'::jsonb)['a']['a1']['a2']

-- sqlfmt-corpus-separator --

select ('{"a": {"a1": {"a2": "aaa"}}, "b": "bbb", "c": "ccc"}'::jsonb)['a']['a1']['a2']['a3']

-- sqlfmt-corpus-separator --

select ('{"a":1, "b":2}'::jsonb).jsonb_object_keys

-- sqlfmt-corpus-separator --

select ('{"a":1}'::jsonb).jsonb_typeof

-- sqlfmt-corpus-separator --

select ('{"text": "hello"}'::jsonb).text

-- sqlfmt-corpus-separator --

select ('{{1,2,3},{4,5,6},{7,8,9}}'::int[])[1:2][2]

-- sqlfmt-corpus-separator --

select (d1).r, (d1).i, (d1).* from dcomptable

-- sqlfmt-corpus-separator --

select (dfunc('Hello World', 20, '2009-07-25'::date)).*

-- sqlfmt-corpus-separator --

select (dfunc()).*

-- sqlfmt-corpus-separator --

select (dfunc(10,20,30)).*

-- sqlfmt-corpus-separator --

select (dfunc(a := 10, b := 20, c := 30)).*

-- sqlfmt-corpus-separator --

select (fn).first, substr((fn).last, 1, 20), length((fn).last) from people

-- sqlfmt-corpus-separator --

select (r).* from (select row(1, 2.0) as r) ss

-- sqlfmt-corpus-separator --

select (r).f1 from (select row(1, 2.0) as r) ss

-- sqlfmt-corpus-separator --

select (r).f3 from (select row(1, 2.0) as r) ss

-- sqlfmt-corpus-separator --

select (row('Jim', 'Beam')).text

-- sqlfmt-corpus-separator --

select (row(1, 2.0)).*

-- sqlfmt-corpus-separator --

select (row(1, 2.0)).f1

-- sqlfmt-corpus-separator --

select (row(1, 2.0)).f2

-- sqlfmt-corpus-separator --

select (row(1, 2.0)).nosuch

-- sqlfmt-corpus-separator --

select (select a),
       (select b),
       (select grouping(a, b)),
       (select sum(t1.v)),
       (select max(t2.c))
  from gstest1 t1 full join gstest2 t2 using (a,b)
 group by grouping sets ((a, b), ())

-- sqlfmt-corpus-separator --

select (select grouping(a,b) from gstest2) from gstest2 group by a,b

-- sqlfmt-corpus-separator --

select (select grouping(ss.x))
from int8_tbl i1
cross join lateral (select (select i1.q1) as x) ss
group by ss.x

-- sqlfmt-corpus-separator --

select (select grouping(v1)) from (values ((select 1))) v(v1) group by cube(v1)

-- sqlfmt-corpus-separator --

select (select grouping(v1)) from (values ((select 1))) v(v1) group by v1

-- sqlfmt-corpus-separator --

select (x+y)*1, sum(z)
 from (select 1 as x, 2 as y, 3 as z) s
 group by grouping sets (x+y, x)

-- sqlfmt-corpus-separator --

select *
  from (values (1),(2)) v(x),
       lateral (select a, b, sum(v.x) from gstest_data(v.x) group by grouping sets (a,b)) s

-- sqlfmt-corpus-separator --

select *
  from (values (1),(2)) v(x),
       lateral (select a, b, sum(v.x) from gstest_data(v.x) group by rollup (a,b)) s

-- sqlfmt-corpus-separator --

select * from
  (values (0),(100)) v(pct),
  lateral (select count(*) from tenk1 tablesample bernoulli (pct)) ss

-- sqlfmt-corpus-separator --

select * from
  (values (0),(100)) v(pct),
  lateral (select count(*) from tenk1 tablesample system (pct)) ss

-- sqlfmt-corpus-separator --

select * from
  (values (1),(2)) v(a),
  lateral (select a, i, j, count(*) from
             bug_16784 group by cube(i,j)) s
  order by v.a, i, j

-- sqlfmt-corpus-separator --

select * from
  int8_tbl a left join lateral
  (select b.q1 as bq1, c.q1 as cq1, least(a.q1,b.q1,c.q1) from
   int8_tbl b cross join int8_tbl c) ss
  on a.q2 = ss.bq1

-- sqlfmt-corpus-separator --

select * from
  int8_tbl x cross join (int4_tbl x cross join lateral (select x.f1) ss)

-- sqlfmt-corpus-separator --

select * from (
  select 1 as x, q1, sum(q2)
  from int8_tbl i1
  group by grouping sets(1, 2)
) ss
where x = 1 and q1 = 123

-- sqlfmt-corpus-separator --

select * from (select (pg_timezone_names()).name) ptn where name='UTC' limit 1

-- sqlfmt-corpus-separator --

select * from (select a, b from phv_boolpart) t
  where a is true
  group by grouping sets (a, b)

-- sqlfmt-corpus-separator --

select * from (select a, b from phv_part) t
  where a = 1
  group by grouping sets (a, b)

-- sqlfmt-corpus-separator --

select * from (select a, b from phv_part) t
  where a in (1, null)
  group by grouping sets (a, b)

-- sqlfmt-corpus-separator --

select * from (select a, b from phv_part) t
  where a is null
  group by grouping sets (a, b)

-- sqlfmt-corpus-separator --

select * from (select a::oid as x, b from phv_part) t
  where x::int = 1
  group by grouping sets (x, b)

-- sqlfmt-corpus-separator --

select * from (values (0), (1)) v(id),
lateral (select * from int8_tbl t1,
         lateral (select * from
                    (select * from int8_tbl t2
                     where (q1, random() > 0) = any (select q2, random() > 0 from int8_tbl t3
                                     where q2 = (select greatest(t1.q1,t2.q2))
                                       and (select v.id=0)) offset 0) ss2) ss
         where t1.q1 = ss.q2) ss0

-- sqlfmt-corpus-separator --

select * from (values (1),(2)) v(a) left join lateral (select v.a, four, ten, count(*) from onek group by cube(four,ten)) s on true order by v.a,four,ten

-- sqlfmt-corpus-separator --

select * from (values (1),(2)) v(a) left join lateral (select v.a, four, ten, count(*) from onek group by grouping sets(four,ten)) s on true order by v.a,four,ten

-- sqlfmt-corpus-separator --

select * from boolpart where a is not false

-- sqlfmt-corpus-separator --

select * from boolpart where a is not true

-- sqlfmt-corpus-separator --

select * from boolpart where a is not true and a is not false

-- sqlfmt-corpus-separator --

select * from boolpart where a is not unknown

-- sqlfmt-corpus-separator --

select * from boolpart where a is true or a is not true

-- sqlfmt-corpus-separator --

select * from boolpart where a is unknown

-- sqlfmt-corpus-separator --

select * from dfunc('Hello World', b := 20, c := '2009-07-25'::date)

-- sqlfmt-corpus-separator --

select * from dfunc('Hello World', c := '2009-07-25'::date, b := 20)

-- sqlfmt-corpus-separator --

select * from dfunc('Hello World', c := 20, b := '2009-07-25'::date)

-- sqlfmt-corpus-separator --

select * from dfunc('Hello', c := 100)

-- sqlfmt-corpus-separator --

select * from dfunc(1,2,c := 3)

-- sqlfmt-corpus-separator --

select * from dfunc(1,2,d := 3)

-- sqlfmt-corpus-separator --

select * from dfunc(1,c := 2,d := 3)

-- sqlfmt-corpus-separator --

select * from dfunc(10, 10, a := 20)

-- sqlfmt-corpus-separator --

select * from dfunc(10, b := 20, 30)

-- sqlfmt-corpus-separator --

select * from dfunc(a := 'Hello', c := 100)

-- sqlfmt-corpus-separator --

select * from dfunc(a := 10, b := 20)

-- sqlfmt-corpus-separator --

select * from dfunc(b := 10, a := 20)

-- sqlfmt-corpus-separator --

select * from dfunc(c := '2009-07-25'::date, a := 'Hello World', b := 20)

-- sqlfmt-corpus-separator --

select * from dfunc(c := 100)

-- sqlfmt-corpus-separator --

select * from dfunc(c := 100, a := 'Hello')

-- sqlfmt-corpus-separator --

select * from dfunc(x := 10, b := 20, c := 30)

-- sqlfmt-corpus-separator --

select * from dfunc(x := 20, b := 10, x := 30)

-- sqlfmt-corpus-separator --

select * from gtest32 t group by grouping sets (a, b, c, d, e, f) having c = 20

-- sqlfmt-corpus-separator --

select * from iboolpart where a is not false

-- sqlfmt-corpus-separator --

select * from iboolpart where a is not true

-- sqlfmt-corpus-separator --

select * from iboolpart where a is not true and a is not false

-- sqlfmt-corpus-separator --

select * from iboolpart where a is not unknown

-- sqlfmt-corpus-separator --

select * from iboolpart where a is true or a is not true

-- sqlfmt-corpus-separator --

select * from iboolpart where a is unknown

-- sqlfmt-corpus-separator --

select * from json_tab t1 left join (select json_array(1, a) from json_tab t2) s on false

-- sqlfmt-corpus-separator --

select * from rows from(getrngfunc1(1),getrngfunc2(1),getrngfunc3(1),getrngfunc4(1),getrngfunc5(1),
                    getrngfunc6(1) AS (rngfuncid int, rngfuncsubid int, rngfuncname text),
                    getrngfunc7(1) AS (rngfuncid int, rngfuncsubid int, rngfuncname text),
                    getrngfunc8(1),getrngfunc9(1))
              with ordinality as t1(a,b,c,d,e,f,g,h,i,j,k,l,m,o,p,q,r,s,t,u)

-- sqlfmt-corpus-separator --

select * from rows from(getrngfunc9(1),getrngfunc8(1),
                    getrngfunc7(1) AS (rngfuncid int, rngfuncsubid int, rngfuncname text),
                    getrngfunc6(1) AS (rngfuncid int, rngfuncsubid int, rngfuncname text),
                    getrngfunc5(1),getrngfunc4(1),getrngfunc3(1),getrngfunc2(1),getrngfunc1(1))
              with ordinality as t1(a,b,c,d,e,f,g,h,i,j,k,l,m,o,p,q,r,s,t,u)

-- sqlfmt-corpus-separator --

select * from rows from(unnest(array[10,20],array['foo','bar'],array[1.0])) with ordinality as z(a,b,c,ord)

-- sqlfmt-corpus-separator --

select * from test_jsonb_subscript where test_json['key'] = '"value"'

-- sqlfmt-corpus-separator --

select * from test_jsonb_subscript where test_json['key'] = '"wrong_value"'

-- sqlfmt-corpus-separator --

select * from test_jsonb_subscript where test_json['key_doesnt_exists'] = '"value"'

-- sqlfmt-corpus-separator --

select * from xmltable('d/r' passing '<d><r><c><![CDATA[<hello> &"<>!<a>foo</a>]]></c></r><r><c>2</c></r></d>' columns c text)

-- sqlfmt-corpus-separator --

select 1 as one group by rollup(one) order by one nulls first

-- sqlfmt-corpus-separator --

select a < b and b < 3 from (values (1, 2)) t(a, b) group by rollup(a < b and b < 3) having a < b and b < 3

-- sqlfmt-corpus-separator --

select a, b
from (values (1, 1), (2, 2)) as t (a, b) where a = b
group by grouping sets((a, b), (a))
order by a, b nulls first

-- sqlfmt-corpus-separator --

select a, b from (values (1,2),(2,3)) v(a,b) group by a,b, grouping sets(a)

-- sqlfmt-corpus-separator --

select a, b, c
from (values (1, 2, 3), (4, null, 6), (7, 8, 9)) as t (a, b, c)
group by all rollup(a, b), rollup(a, c)
order by a, b, c

-- sqlfmt-corpus-separator --

select a, b, c
from (values (1, 2, 3), (4, null, 6), (7, 8, 9)) as t (a, b, c)
group by distinct rollup(a, b), rollup(a, c)
order by a, b, c

-- sqlfmt-corpus-separator --

select a, b, c
from (values (1, 2, 3), (4, null, 6), (7, 8, 9)) as t (a, b, c)
group by rollup(a, b), rollup(a, c)
order by a, b, c

-- sqlfmt-corpus-separator --

select a, b, c, d from gstest2 group by rollup(a,b),grouping sets(c,d)

-- sqlfmt-corpus-separator --

select a, b, count(*) from gstest2 group by grouping sets ((a), (b)) having false

-- sqlfmt-corpus-separator --

select a, b, count(*) from gstest2 group by grouping sets ((a, b), (a)) having a > 1 and b > 1

-- sqlfmt-corpus-separator --

select a, b, count(*) from gstest2 group by rollup(a), b having b > 1

-- sqlfmt-corpus-separator --

select a, b, grouping(a, b), sum(t1.v), max(t2.c)
  from gstest1 t1 full join gstest2 t2 using (a,b)
 group by grouping sets ((a, b), ())

-- sqlfmt-corpus-separator --

select a, b, grouping(a, b), sum(t1.v), max(t2.c)
  from gstest1 t1 join gstest2 t2 using (a,b)
 group by grouping sets ((a, b), ())

-- sqlfmt-corpus-separator --

select a, b, grouping(a,b),
       array_agg(v order by v),
       string_agg(v::text, ':' order by v desc),
       percentile_disc(0.5) within group (order by v),
       rank(1,2,12) within group (order by a,b,v)
  from gstest1 group by rollup (a,b) order by a,b

-- sqlfmt-corpus-separator --

select a, b, grouping(a,b), sum(v), count(*), max(v)
  from gstest1 group by cube(a,b) order by 3,1,2

-- sqlfmt-corpus-separator --

select a, b, grouping(a,b), sum(v), count(*), max(v)
  from gstest1 group by grouping sets ((a),(b)) order by 3,1,2

-- sqlfmt-corpus-separator --

select a, b, grouping(a,b), sum(v), count(*), max(v)
  from gstest1 group by grouping sets ((a,b),(a+1,b+1),(a+2,b+2)) order by 3,6

-- sqlfmt-corpus-separator --

select a, b, grouping(a,b), sum(v), count(*), max(v)
  from gstest1 group by rollup (a,b)

-- sqlfmt-corpus-separator --

select a, b, grouping(a,b), sum(v), count(*), max(v)
  from gstest1 group by rollup (a,b) order by a,b

-- sqlfmt-corpus-separator --

select a, b, grouping(a,b), sum(v), count(*), max(v)
  from gstest1 group by rollup (a,b) order by b desc, a

-- sqlfmt-corpus-separator --

select a, b, grouping(a,b), sum(v), count(*), max(v)
  from gstest1 group by rollup (a,b) order by coalesce(a,0)+coalesce(b,0)

-- sqlfmt-corpus-separator --

select a, b, row_number() over (order by a, b nulls first)
from (values (1, 1), (2, 2)) as t (a, b) where a = b
group by grouping sets((a, b), (a))

-- sqlfmt-corpus-separator --

select a, b, sum(c) from (values (1,1,10),(1,1,11),(1,2,12),(1,2,13),(1,3,14),(2,3,15),(3,3,16),(3,4,17),(4,1,18),(4,1,19)) v(a,b,c) group by rollup (a,b)

-- sqlfmt-corpus-separator --

select a, b, sum(c), count(*) from gstest2 group by grouping sets (rollup(a,b),a)

-- sqlfmt-corpus-separator --

select a, b, sum(c), sum(sum(c)) over (order by a,b) as rsum
  from gstest2 group by cube (a,b) order by rsum, a, b

-- sqlfmt-corpus-separator --

select a, b, sum(c), sum(sum(c)) over (order by a,b) as rsum
  from gstest2 group by rollup (a,b) order by rsum, a, b

-- sqlfmt-corpus-separator --

select a, b, sum(v), count(*) from gstest_empty group by grouping sets ((a,b),())

-- sqlfmt-corpus-separator --

select a, b, sum(v), count(*) from gstest_empty group by grouping sets ((a,b),(),(),())

-- sqlfmt-corpus-separator --

select a, b, sum(v), count(*) from gstest_empty group by grouping sets ((a,b),a)

-- sqlfmt-corpus-separator --

select a, b, sum(v.x)
  from (values (1),(2)) v(x), gstest_data(v.x)
 group by cube (a,b) order by a,b

-- sqlfmt-corpus-separator --

select a, b, sum(v.x)
  from (values (1),(2)) v(x), gstest_data(v.x)
 group by grouping sets (a,b)
 order by 1, 2, 3

-- sqlfmt-corpus-separator --

select a, b, sum(v.x)
  from (values (1),(2)) v(x), gstest_data(v.x)
 group by rollup (a,b)

-- sqlfmt-corpus-separator --

select a, count(*) from gstest2 group by grouping sets ((a), ()) having false

-- sqlfmt-corpus-separator --

select a, d, grouping(a,b,c)
  from gstest3
 group by grouping sets ((a,b), (a,c))

-- sqlfmt-corpus-separator --

select a,count(*) from gstest2 group by rollup(a) having a is distinct from 1 order by a

-- sqlfmt-corpus-separator --

select a,count(*) from gstest2 group by rollup(a) order by a

-- sqlfmt-corpus-separator --

select array(select row(v.a,s1.*) from (select two,four, count(*) from onek group by cube(two,four) order by two,four) s1) from (values (1),(2)) v(a)

-- sqlfmt-corpus-separator --

select array(select row(v.a,s1.*) from (select two,four, count(*) from onek group by grouping sets(two,four) order by two,four) s1) from (values (1),(2)) v(a)

-- sqlfmt-corpus-separator --

select array_agg(v order by v) from gstest4 group by grouping sets ((id,unsortable_col),(id))

-- sqlfmt-corpus-separator --

select c2[1:2].f3[1:2] from comptable

-- sqlfmt-corpus-separator --

select c2[2].f2 from comptable

-- sqlfmt-corpus-separator --

select c2[2].f3 from comptable

-- sqlfmt-corpus-separator --

select c2[2].f3[1:2] from comptable

-- sqlfmt-corpus-separator --

select conrelid::regclass, conname, contype, conkey,
 (select attname from pg_attribute where attrelid = conrelid and attnum = conkey[1]),
 coninhcount, conislocal, connoinherit
 from pg_constraint where contype = 'n' and
 conrelid::regclass::text like 'inh\_nn\_%'
 order by 2, 1

-- sqlfmt-corpus-separator --

select conrelid::regclass, contype, conname,
  (select attname from pg_attribute where attrelid = conrelid and attnum = conkey[1]),
  coninhcount, conislocal
 from pg_constraint where contype = 'n' and
 conrelid::regclass in ('inh_p1', 'inh_p2', 'inh_p3', 'inh_p4',
	'inh_multiparent')
 order by conrelid::regclass::text, conname

-- sqlfmt-corpus-separator --

select conrelid::regclass, contype, conname,
  (select attname from pg_attribute where attrelid = conrelid and attnum = conkey[1]),
  coninhcount, conislocal
 from pg_constraint where contype = 'n' and
 conrelid::regclass in ('inh_p3', 'inh_multiparent', 'inh_multiparent2')
 order by conrelid::regclass::text, conname

-- sqlfmt-corpus-separator --

select count(*) from gstest2 group by grouping sets (()) having false

-- sqlfmt-corpus-separator --

select count(*) from gstest4 group by rollup(unhashable_col,unsortable_col)

-- sqlfmt-corpus-separator --

select count(*) from person tablesample bernoulli (100)

-- sqlfmt-corpus-separator --

select d1[2], d1[1].r, d1[1].i from dcomptable

-- sqlfmt-corpus-separator --

select description, (test_conv(inbytes, 'utf8', 'utf8')).* from utf8_inputs

-- sqlfmt-corpus-separator --

select description, (test_conv(inbytes, 'utf8', 'utf8')).* from utf8_verification_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'big5', 'big5')).* from big5_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'big5', 'utf8')).* from big5_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'euc_jis_2004', 'euc_jis_2004')).* from euc_jis_2004_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'euc_jis_2004', 'utf8')).* from euc_jis_2004_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'gb18030', 'utf8')).* from gb18030_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'iso8859-5', 'iso8859-5')).* from iso8859_5_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'iso8859-5', 'koi8r')).* from iso8859_5_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'iso8859-5', 'utf8')).* from iso8859_5_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'shiftjis2004', 'euc_jis_2004')).* from shiftjis2004_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'shiftjis2004', 'shiftjis2004')).* from shiftjis2004_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'shiftjis2004', 'utf8')).* from shiftjis2004_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'utf8', 'euc_jis_2004')).* from utf8_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'utf8', 'gb18030')).* from utf8_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'utf8', 'koi8r')).* from utf8_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'utf8', 'latin1')).* from utf8_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'utf8', 'latin2')).* from utf8_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes, 'utf8', 'latin5')).* from utf8_inputs

-- sqlfmt-corpus-separator --

select description, inbytes, (test_conv(inbytes::text::bytea, 'gb18030', 'gb18030')).* from gb18030_inputs

-- sqlfmt-corpus-separator --

select dfunc('a'::text, 'b', flag := false)

-- sqlfmt-corpus-separator --

select dfunc('a'::text, 'b', flag := true)

-- sqlfmt-corpus-separator --

select dfunc('a'::text, 'b', flag => false)

-- sqlfmt-corpus-separator --

select dfunc('a'::text, 'b', flag => true)

-- sqlfmt-corpus-separator --

select dfunc(a := 'a'::text, b := 'b')

-- sqlfmt-corpus-separator --

select dfunc(a := 'a'::text, b := 'b', flag := false)

-- sqlfmt-corpus-separator --

select dfunc(a := 'a'::text, flag := false)

-- sqlfmt-corpus-separator --

select dfunc(a := 'a'::text, flag := true)

-- sqlfmt-corpus-separator --

select dfunc(a := 1, b := 2)

-- sqlfmt-corpus-separator --

select dfunc(a => 'a'::text, b => 'b')

-- sqlfmt-corpus-separator --

select dfunc(a => 'a'::text, b => 'b', flag => false)

-- sqlfmt-corpus-separator --

select dfunc(a => 'a'::text, flag => false)

-- sqlfmt-corpus-separator --

select dfunc(a => 'a'::text, flag => true)

-- sqlfmt-corpus-separator --

select dfunc(a => 1, b => 2)

-- sqlfmt-corpus-separator --

select dfunc(a =>+1)

-- sqlfmt-corpus-separator --

select dfunc(a =>--comment to be removed by psql
  1)

-- sqlfmt-corpus-separator --

select dfunc(a =>-1)

-- sqlfmt-corpus-separator --

select dfunc(a =>/**/1)

-- sqlfmt-corpus-separator --

select dfunc(b := 'b'::text, a := 'a')

-- sqlfmt-corpus-separator --

select dfunc(b := 'b'::text, a := 'a', flag := true)

-- sqlfmt-corpus-separator --

select dfunc(b => 'b'::text, a => 'a')

-- sqlfmt-corpus-separator --

select dfunc(b => 'b'::text, a => 'a', flag => true)

-- sqlfmt-corpus-separator --

select distinct a, b, c
from (values (1, 2, 3), (4, null, 6), (7, 8, 9)) as t (a, b, c)
group by rollup(a, b), rollup(a, c)
order by a, b, c

-- sqlfmt-corpus-separator --

select distinct on (a, b) a, b
from (values (1, 1), (2, 2)) as t (a, b) where a = b
group by grouping sets((a, b), (a))
order by a, b

-- sqlfmt-corpus-separator --

select distinct on (a, b+1) a, b+1
from (values (1, 0), (2, 1)) as t (a, b) where a = b+1
group by grouping sets((a, b+1), (a))
order by a, b+1

-- sqlfmt-corpus-separator --

select f1, (q).c1, (qq.q).c1.i from quadtable qq

-- sqlfmt-corpus-separator --

select f1, f1[1], (f1[1])[1] from dposintatable

-- sqlfmt-corpus-separator --

select f1, f1[1], (f1[2])[1] from dposintatable

-- sqlfmt-corpus-separator --

select four, x
  from (select four, ten, 'foo'::text as x from tenk1) as t
  group by grouping sets (four, x)
  having x = 'foo'

-- sqlfmt-corpus-separator --

select four, x || 'x'
  from (select four, ten, 'foo'::text as x from tenk1) as t
  group by grouping sets (four, x)
  order by four

-- sqlfmt-corpus-separator --

select g as alias1, g as alias2
  from generate_series(1,3) g
 group by alias1, rollup(alias2)

-- sqlfmt-corpus-separator --

select generate_series(1, a) as g
from (values (1, 1), (2, 2)) as t (a, b)
group by rollup(g)
order by 1

-- sqlfmt-corpus-separator --

select generate_series(1, a) as g, a+b as ab
from (values (1, 1), (2, 2)) as t (a, b)
group by rollup(a, ab)
order by 1, 2

-- sqlfmt-corpus-separator --

select grouping((select t1.v from gstest5 t2 where id = t1.id)),
       (select t1.v from gstest5 t2 where id = t1.id) as s
from gstest5 t1
group by grouping sets(v, s)
order by case when grouping((select t1.v from gstest5 t2 where id = t1.id)) = 0
              then (select t1.v from gstest5 t2 where id = t1.id)
              else null end
         nulls first

-- sqlfmt-corpus-separator --

select grouping((select t1.v from gstest5 t2 where id = t1.id)),
       (select t1.v from gstest5 t2 where id = t1.id) as s,
       case when grouping((select t1.v from gstest5 t2 where id = t1.id)) = 0
            then (select t1.v from gstest5 t2 where id = t1.id)
            else null end as o
from gstest5 t1
group by grouping sets(v, s)
order by o nulls first

-- sqlfmt-corpus-separator --

select grouping(a), a, array_agg(b),
       rank(a) within group (order by b nulls first),
       rank(a) within group (order by b nulls last)
  from (values (1,1),(1,4),(1,5),(3,1),(3,2)) v(a,b)
 group by rollup (a) order by a

-- sqlfmt-corpus-separator --

select grouping(ss.x)
from int8_tbl i1
cross join lateral (select (select i1.q1) as x) ss
group by ss.x

-- sqlfmt-corpus-separator --

select jsonb_path_exists('[{"a": 1}, {"a": 2}, 3]', 'lax $[*].a', silent => false)

-- sqlfmt-corpus-separator --

select jsonb_path_exists('[{"a": 1}, {"a": 2}, 3]', 'lax $[*].a', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_exists('[{"a": 1}, {"a": 2}, 3]', 'strict $[*].a', silent => false)

-- sqlfmt-corpus-separator --

select jsonb_path_exists('[{"a": 1}, {"a": 2}, 3]', 'strict $[*].a', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_match('[{"a": 1}, {"a": 2}, 3]', 'lax exists($[*].a)', silent => false)

-- sqlfmt-corpus-separator --

select jsonb_path_match('[{"a": 1}, {"a": 2}, 3]', 'lax exists($[*].a)', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_match('[{"a": 1}, {"a": 2}, 3]', 'strict exists($[*].a)', silent => false)

-- sqlfmt-corpus-separator --

select jsonb_path_match('[{"a": 1}, {"a": 2}, 3]', 'strict exists($[*].a)', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"-inf"', '$.bigint()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"-inf"', '$.boolean()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"-inf"', '$.decimal()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"-inf"', '$.double()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"-inf"', '$.integer()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"-inf"', '$.number()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"1.2"', '$.ceiling()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"a"', '-$', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"inf"', '$.bigint()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"inf"', '$.boolean()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"inf"', '$.decimal()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"inf"', '$.double()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"inf"', '$.integer()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('"inf"', '$.number()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('1', '$ + "2"', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('1', 'strict $.*', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('1', 'strict $.a', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('1', 'strict $[*]', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('1', 'strict $[1]', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[1, 2]', '3 * $', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[1,"2",3]', '+$', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[1,2,3]', '$[last ? (@.type() == "string")]', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[1,2,3]', 'strict $[*].a', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[1,null,true,"11",[],[1],[1,2,3],{},{"a":1,"b":2}]', 'strict $[*].size()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[1]', 'strict $[1]', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $.a', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $.bigint()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $.boolean()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $.decimal()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $.double()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $.initcap()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $.integer()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $.lower()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $.ltrim()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $.number()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $.replace("x", "bye")', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $.string()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $.upper()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $["a"]', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $[1]', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[]', 'strict $[last]', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('[{},1]', '$[*].keyvalue()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('null', '$.bigint()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('null', '$.boolean()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('null', '$.decimal()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('null', '$.double()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('null', '$.initcap()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('null', '$.integer()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('null', '$.lower()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('null', '$.ltrim()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('null', '$.number()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('null', '$.replace("x", "bye")', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('null', '$.string()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('null', '$.upper()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('true', '$.bigint()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('true', '$.decimal()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('true', '$.double()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('true', '$.floor()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('true', '$.integer()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('true', '$.number()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{"a": [1, 2]}', 'lax $.a * 3', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', '$.abs()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', '$.bigint()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', '$.boolean()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', '$.decimal()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', '$.double()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', '$.initcap()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', '$.integer()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', '$.lower()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', '$.ltrim()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', '$.number()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', '$.replace("x", "bye")', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', '$.string()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', '$.upper()', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_path_query('{}', 'strict $.a', silent => true)

-- sqlfmt-corpus-separator --

select jsonb_set_lax('{"a":1,"b":2}', '{b}', null, null_value_treatment => 'delete_key') as delete_key

-- sqlfmt-corpus-separator --

select jsonb_set_lax('{"a":1,"b":2}', '{b}', null, null_value_treatment => 'raise_exception') as raise_exception

-- sqlfmt-corpus-separator --

select jsonb_set_lax('{"a":1,"b":2}', '{b}', null, null_value_treatment => 'return_target') as return_target

-- sqlfmt-corpus-separator --

select jsonb_set_lax('{"a":1,"b":2}', '{b}', null, null_value_treatment => 'use_json_null') as use_json_null

-- sqlfmt-corpus-separator --

select length(fipshash((f1[1]).c2)) from dest

-- sqlfmt-corpus-separator --

select length(id), test_json[id] from test_jsonb_subscript

-- sqlfmt-corpus-separator --

select make_interval() = make_interval(years := 0, months := 0, weeks := 0, days := 0, mins := 0, secs := 0.0)

-- sqlfmt-corpus-separator --

select make_interval(hours := -2, mins := -10, secs := -25.3)

-- sqlfmt-corpus-separator --

select make_interval(mins := -1, secs := -9223372036800.0)

-- sqlfmt-corpus-separator --

select make_interval(mins := 1, secs := 9223372036800.0)

-- sqlfmt-corpus-separator --

select make_interval(months := 'NaN'::float::int)

-- sqlfmt-corpus-separator --

select make_interval(secs := 'NaN')

-- sqlfmt-corpus-separator --

select make_interval(secs := 'inf')

-- sqlfmt-corpus-separator --

select make_interval(secs := -1e18)

-- sqlfmt-corpus-separator --

select make_interval(secs := 1e18)

-- sqlfmt-corpus-separator --

select make_interval(secs := 1e308)

-- sqlfmt-corpus-separator --

select make_interval(secs := 7e12)

-- sqlfmt-corpus-separator --

select make_interval(weeks := -1, days := -2147483648)

-- sqlfmt-corpus-separator --

select make_interval(weeks := -306783379)

-- sqlfmt-corpus-separator --

select make_interval(weeks := 1, days := 2147483647)

-- sqlfmt-corpus-separator --

select make_interval(weeks := 306783379)

-- sqlfmt-corpus-separator --

select make_interval(years := 'inf'::float::int)

-- sqlfmt-corpus-separator --

select make_interval(years := -1, months := -2147483648)

-- sqlfmt-corpus-separator --

select make_interval(years := -178956971)

-- sqlfmt-corpus-separator --

select make_interval(years := 1, months := -1, weeks := 5, days := -7, hours := 25, mins := -180)

-- sqlfmt-corpus-separator --

select make_interval(years := 1, months := 2147483647)

-- sqlfmt-corpus-separator --

select make_interval(years := 1, months := 6)

-- sqlfmt-corpus-separator --

select make_interval(years := 178956971)

-- sqlfmt-corpus-separator --

select make_interval(years := 2)

-- sqlfmt-corpus-separator --

select not a from (values(true)) t(a) group by rollup(not a) having not not a

-- sqlfmt-corpus-separator --

select null from pg_database group by grouping sets (()) for update

-- sqlfmt-corpus-separator --

select p from
  (values (box(point(0,0), point(0.5,0.5))),
          (box(point(0.5,0.5), point(0.75,0.75))),
          (box(point(0.8,0.8), point(1.0,1.0)))) as v(bb)
cross join lateral
  (select p from gist_tbl where p <@ bb order by p <-> bb[0] limit 2) ss

-- sqlfmt-corpus-separator --

select pct, count(unique1) from
  (values (0),(100)) v(pct),
  lateral (select * from tenk1 tablesample bernoulli (pct)) ss
  group by pct

-- sqlfmt-corpus-separator --

select pct, count(unique1) from
  (values (0),(100)) v(pct),
  lateral (select * from tenk1 tablesample system (pct)) ss
  group by pct

-- sqlfmt-corpus-separator --

select pg_typeof((f1[1])[1]) from dposintatable

-- sqlfmt-corpus-separator --

select pg_typeof(f1[1]) from dposintatable

-- sqlfmt-corpus-separator --

select pg_typeof(f1[1][1]) from dposintatable

-- sqlfmt-corpus-separator --

select sum(c) from gstest2
  group by grouping sets((), grouping sets((), grouping sets(((a, b)))))
  order by 1 desc

-- sqlfmt-corpus-separator --

select sum(c) from gstest2
  group by grouping sets((), grouping sets((), grouping sets(())))
  order by 1 desc

-- sqlfmt-corpus-separator --

select sum(c) from gstest2
  group by grouping sets((a,(a,b)), grouping sets((a,(a,b)),a))
  order by 1 desc

-- sqlfmt-corpus-separator --

select sum(c) from gstest2
  group by grouping sets(a, grouping sets(a, cube(b)))
  order by 1 desc

-- sqlfmt-corpus-separator --

select sum(c) from gstest2
  group by grouping sets(grouping sets((a, (b))))
  order by 1 desc

-- sqlfmt-corpus-separator --

select sum(c) from gstest2
  group by grouping sets(grouping sets((a, b)))
  order by 1 desc

-- sqlfmt-corpus-separator --

select sum(c) from gstest2
  group by grouping sets(grouping sets(a, grouping sets(a), a))
  order by 1 desc

-- sqlfmt-corpus-separator --

select sum(c) from gstest2
  group by grouping sets(grouping sets(a, grouping sets(a, grouping sets(a), ((a)), a, grouping sets(a), (a)), a))
  order by 1 desc

-- sqlfmt-corpus-separator --

select sum(c) from gstest2
  group by grouping sets(grouping sets(rollup(c), grouping sets(cube(c))))
  order by 1 desc

-- sqlfmt-corpus-separator --

select sum(ten) from onek group by rollup(four::text), two order by 1

-- sqlfmt-corpus-separator --

select sum(ten) from onek group by two, rollup(four::text) order by 1

-- sqlfmt-corpus-separator --

select sum(v), count(*) from gstest_empty group by grouping sets ((),(),())

-- sqlfmt-corpus-separator --

select t1.a, t2.b, grouping(t1.a, t2.b), sum(t1.v), max(t2.a)
  from gstest1 t1 join gstest2 t2 on (t1.a=t2.a)
 group by grouping sets ((t1.a, t2.b), ())

-- sqlfmt-corpus-separator --

select t1.a, t2.b, grouping(t1.a, t2.b), sum(t1.v), max(t2.a)
  from gstest1 t1, gstest2 t2
 group by grouping sets ((t1.a, t2.b), ())

-- sqlfmt-corpus-separator --

select t1.a, t2.b, sum(t1.v), count(*) from gstest_empty t1, gstest_empty t2
 group by grouping sets ((t1.a,t2.b),())

-- sqlfmt-corpus-separator --

select t1.b, ss.phv from join_ut1 t1 left join lateral
              (select t2.a as t2a, t3.a t3a, least(t1.a, t2.a, t3.a) phv
					  from join_pt1 t2 join join_ut1 t3 on t2.a = t3.b) ss
              on t1.a = ss.t2a order by t1.a

-- sqlfmt-corpus-separator --

select ten, grouping(ten) from onek
group by (ten) having grouping(ten) >= 0
order by 2,1

-- sqlfmt-corpus-separator --

select ten, grouping(ten) from onek
group by cube(ten) having grouping(ten) > 0
order by 2,1

-- sqlfmt-corpus-separator --

select ten, grouping(ten) from onek
group by grouping sets(ten) having grouping(ten) >= 0
order by 2,1

-- sqlfmt-corpus-separator --

select ten, grouping(ten) from onek
group by grouping sets(ten, four) having grouping(ten) > 0
order by 2,1

-- sqlfmt-corpus-separator --

select ten, grouping(ten) from onek
group by rollup(ten) having grouping(ten) > 0
order by 2,1

-- sqlfmt-corpus-separator --

select ten, sum(distinct four) filter (where four::text ~ '123') from onek a
group by rollup(ten)

-- sqlfmt-corpus-separator --

select ten, sum(distinct four) from onek a
group by grouping sets((ten,four),(ten))
having exists (select 1 from onek b where sum(distinct a.four) = b.four)

-- sqlfmt-corpus-separator --

select testint4arr[1], testchar4arr[2:2] from domarrtest

-- sqlfmt-corpus-separator --

select unhashable_col, unsortable_col,
       grouping(unhashable_col, unsortable_col),
       count(*), sum(v)
  from gstest4 group by grouping sets ((unhashable_col),(unsortable_col))
 order by 3, 5

-- sqlfmt-corpus-separator --

select unhashable_col, unsortable_col,
       grouping(unhashable_col, unsortable_col),
       count(*), sum(v)
  from gstest4 group by grouping sets ((v,unhashable_col),(v,unsortable_col))
 order by 3,5

-- sqlfmt-corpus-separator --

select unsortable_col, count(*)
  from gstest4 group by grouping sets ((unsortable_col),(unsortable_col))
  order by unsortable_col::text

-- sqlfmt-corpus-separator --

select v.c, (select count(*) from gstest2 group by () having v.c)
  from (values (false),(true)) v(c) order by v.c

-- sqlfmt-corpus-separator --

select v||'a', case grouping(v||'a') when 1 then 1 else 0 end, count(*)
  from unnest(array[1,1], array['a','b']) u(i,v)
 group by rollup(i, v||'a') order by 1,3

-- sqlfmt-corpus-separator --

select v||'a', case when grouping(v||'a') = 1 then 1 else 0 end, count(*)
  from unnest(array[1,1], array['a','b']) u(i,v)
 group by rollup(i, v||'a') order by 1,3

-- sqlfmt-corpus-separator --

select x, not x as not_x, q2 from
  (select *, q1 = 1 as x from int8_tbl i1) as t
  group by grouping sets(x, q2)
  order by x, q2

-- sqlfmt-corpus-separator --

select x, y
  from (select four as x, four as y from tenk1) as t
  group by grouping sets (x, y)
  having y is null
  order by 1, 2

-- sqlfmt-corpus-separator --

select x, y
  from (select t1.unique1 as x, t1.unique2 as y from tenk1 t1, tenk1 t2) as t
  where x = 1
  group by grouping sets (x, y)
  order by 1, 2

-- sqlfmt-corpus-separator --

select x, y
  from (select unique1 as x, unique2 as y from tenk1) as t
  where x = 1
  group by grouping sets (x, y)
  order by 1, 2

-- sqlfmt-corpus-separator --

select x, y
  from (select unique1::oid as x, unique2 as y from tenk1) as t
  where x::integer = 1
  group by grouping sets (x, y)
  order by 1, 2

-- sqlfmt-corpus-separator --

select x, y || 'y'
  from (select four as x, four as y from tenk1) as t
  group by grouping sets (x, y)
  order by 1, 2

-- sqlfmt-corpus-separator --

select xleast(1, variadic arr => array[2,3])

-- sqlfmt-corpus-separator --

select xleast(1, variadic x => array[2,3])

-- sqlfmt-corpus-separator --

select xleast(arr => 1, variadic x => array[2,3])

-- sqlfmt-corpus-separator --

select xleast(arr => array[1], variadic x => 3)

-- sqlfmt-corpus-separator --

select xleast(arr => array[1], x => 3)

-- sqlfmt-corpus-separator --

select xleast(foo => 1, variadic arr => array[2,3])

-- sqlfmt-corpus-separator --

select xleast(x => 1, variadic arr => array[2,3])

-- sqlfmt-corpus-separator --

select xleast(x => 1, variadic array[2,3])

-- sqlfmt-corpus-separator --

select(select (select grouping(a,b) from (values (1)) v2(c)) from (values (1,2)) v1(a,b) group by (a,b)) from (values(6,7)) v3(e,f) GROUP BY CUBE((e+1),(f+1)) ORDER BY (e+1),(f+1)

-- sqlfmt-corpus-separator --

select(select (select grouping(a,b) from (values (1)) v2(c)) from (values (1,2)) v1(a,b) group by (a,b)) from (values(6,7)) v3(e,f) GROUP BY ROLLUP((e+1),(f+1))

-- sqlfmt-corpus-separator --

select(select (select grouping(a,b) from (values (1)) v2(c)) from (values (1,2)) v1(a,b) group by (a,b)) from (values(6,7)) v3(e,f) GROUP BY ROLLUP(e,f)

-- sqlfmt-corpus-separator --

select(select (select grouping(c) from (values (1)) v2(c) GROUP BY c) from (values (1,2)) v1(a,b) group by (a,b)) from (values(6,7)) v3(e,f) GROUP BY ROLLUP(e,f)

-- sqlfmt-corpus-separator --

select(select (select grouping(e,f) from (values (1)) v2(c)) from (values (1,2)) v1(a,b) group by (a,b)) from (values(6,7)) v3(e,f) GROUP BY ROLLUP(e,f)

-- sqlfmt-corpus-separator --

update dcomptable set d1.r = (d1).r + 1 where (d1).i > 0

-- sqlfmt-corpus-separator --

update dcomptable set d1.r = (d1).r - 1, d1.i = (d1).i + 1 where (d1).i > 0

-- sqlfmt-corpus-separator --

update dcomptable set d1[1].r = d1[1].r + 1 where d1[1].i > 0

-- sqlfmt-corpus-separator --

update dcomptable set d1[1].r = d1[1].r - 1, d1[1].i = d1[1].i + 1
  where d1[1].i > 0

-- sqlfmt-corpus-separator --

update dcomptable set d1[2] = row(d1[2].i, d1[2].r)

-- sqlfmt-corpus-separator --

update domarrtest set
  testint4arr[1] = testint4arr[1] + 1,
  testint4arr[3] = testint4arr[3] - 1
where testchar4arr is null

-- sqlfmt-corpus-separator --

update forc_test set i = i * 100, j = r.j * 2 where current of c

-- sqlfmt-corpus-separator --

update gtest_cursor set a = 99 where current of curs

-- sqlfmt-corpus-separator --

update inhpar i set (f1, f2) = (select i.f1, i.f2 || '-' from int4_tbl limit 1)

-- sqlfmt-corpus-separator --

update pitable set f1[1] = f1[1] + 1

-- sqlfmt-corpus-separator --

vacuum analyze atacc1("........pg.dropped.1........")

-- sqlfmt-corpus-separator --

vacuum analyze atacc1(a)

-- sqlfmt-corpus-separator --

with contexts as (
  select * from pg_backend_memory_contexts
)
select count(*) > 1
from contexts c1, contexts c2
where c2.name = 'CacheMemoryContext'
and c1.path[c2.level] = c2.path[c2.level]

-- sqlfmt-corpus-separator --

with cte(c) as materialized (select row(1, 2)),
     cte2(c) as (select * from cte)
select * from cte2 as t
where (select * from (select c as c1) s
       where (select (c1).f1 > 0)) is not null

-- sqlfmt-corpus-separator --

with test_bytes as (
  select
    inbytes,
    description,
    (test_conv(inbytes || repeat('.', 3)::bytea, 'utf8', 'utf8')).error
  from utf8_verification_inputs
), test_padded as (
  select
    description,
    (test_conv(inbytes || repeat('.', 64)::bytea, 'utf8', 'utf8')).error
  from test_bytes
)
select
  description,
  b.error as orig_error,
  p.error as error_after_padding
from test_padded p
join test_bytes b
using (description)
where p.error is distinct from b.error
order by description

-- sqlfmt-corpus-separator --

with test_bytes as (
  select
    inbytes,
    description,
    (test_conv(inbytes || repeat('.', 3)::bytea, 'utf8', 'utf8')).error
  from utf8_verification_inputs
), test_padded as (
  select
    description,
    (test_conv(repeat('.', 64 - length(inbytes))::bytea || inbytes || repeat('.', 3)::bytea, 'utf8', 'utf8')).error
  from test_bytes
)
select
  description,
  b.error as orig_error,
  p.error as error_after_padding
from test_padded p
join test_bytes b
using (description)
where p.error is distinct from b.error
order by description

-- sqlfmt-corpus-separator --

with test_bytes as (
  select
    inbytes,
    description,
    (test_conv(inbytes || repeat('.', 3)::bytea, 'utf8', 'utf8')).error
  from utf8_verification_inputs
), test_padded as (
  select
    description,
    (test_conv(repeat('.', 64 - length(inbytes))::bytea || inbytes || repeat('.', 64)::bytea, 'utf8', 'utf8')).error
  from test_bytes
)
select
  description,
  b.error as orig_error,
  p.error as error_after_padding
from test_padded p
join test_bytes b
using (description)
where p.error is distinct from b.error
order by description

-- sqlfmt-corpus-separator --

with test_bytes as (
  select
    inbytes,
    description,
    (test_conv(inbytes || repeat('.', 3)::bytea, 'utf8', 'utf8')).error
  from utf8_verification_inputs
), test_padded as (
  select
    description,
    (test_conv(repeat('.', 64)::bytea || inbytes || repeat('.', 3)::bytea, 'utf8', 'utf8')).error
  from test_bytes
)
select
  description,
  b.error as orig_error,
  p.error as error_after_padding
from test_padded p
join test_bytes b
using (description)
where p.error is distinct from b.error
order by description