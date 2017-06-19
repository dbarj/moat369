-- log header
SPO &&moat369_log..txt;
PRO begin log
PRO
DEF;
PRO Parameters
SHOW PARAMETERS;
SET TI ON;
SET TIMI ON;
SET TERM ON;
PRO Getting SYS.WR_$% Tables
PRO Please wait ...
SET TERM OFF;
SELECT table_name, blocks, num_rows, last_analyzed
  FROM dba_tables
 WHERE owner = 'SYS'
   AND table_name LIKE 'WR_$%'
 ORDER BY
       table_name;
SET TERM ON;
PRO Getting SYS.WR_$% Table Partitions
PRO Please wait ...
SET TERM OFF;
SELECT table_name, partition_name, blocks, num_rows, last_analyzed
  FROM dba_tab_partitions
 WHERE table_owner = 'SYS'
   AND table_name LIKE 'WR_$%'
 ORDER BY
       table_name, partition_name;
SET TERM ON;
PRO Getting SYS.WR_$% Tables and Partitions
PRO Please wait ...
SET TERM OFF;
SELECT table_name, partition_name, inserts, updates, deletes, timestamp, truncated
  FROM dba_tab_modifications
 WHERE table_owner = 'SYS'
   AND table_name LIKE 'WR_$%'
 ORDER BY
       table_name, partition_name;
SET TERM ON;
PRO Getting SYS.WR_$% Indexes
PRO Please wait ...
SET TERM OFF;
SELECT table_name, index_name, leaf_blocks, num_rows, last_analyzed
  FROM dba_indexes
 WHERE table_owner = 'SYS'
   AND table_name LIKE 'WR_$%'
 ORDER BY
       table_name, index_name;
SET TERM ON;
PRO Getting SYS.WR_$% Index Partitions
PRO Please wait ...
SET TERM OFF;
SELECT index_name, partition_name, leaf_blocks, num_rows, last_analyzed
  FROM dba_ind_partitions
 WHERE index_owner = 'SYS'
   AND index_name LIKE 'WR_$%'
 ORDER BY
       index_name, partition_name;
SET TERM ON;
PRO Getting SYS.WR_$% Segments
PRO Please wait ...
SET TERM OFF;
COL seg_part_name FOR A61
SELECT segment_name||' '||partition_name seg_part_name, segment_type, blocks
  FROM dba_segments
 WHERE owner = 'SYS'
   AND segment_name LIKE 'WR_$%'
 ORDER BY
       segment_name, partition_name;
COL seg_part_name clear
SET TI OFF;
SET TIMI OFF;
SPO OFF;
@@&&fc_set_term_off.