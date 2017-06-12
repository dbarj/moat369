-- add seq to one_spool_filename
EXEC :file_seq := :file_seq + 1;
SELECT LPAD(:file_seq, 5, '0')||'_&&spool_filename.' one_spool_filename FROM DUAL;

-- display
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') hh_mm_ss FROM DUAL;
SET TERM ON;
SPO &&moat369_log..txt APP;
PRO &&hh_mm_ss. &&section_id. "&&one_spool_filename..csv"
SPO OFF;
@@&&fc_set_term_off.

-- update main report
SPO &&moat369_main_report..html APP;
PRO <a href="&&one_spool_filename..csv">csv</a>
SPO OFF;

-- get time t0
EXEC :get_time_t0 := DBMS_UTILITY.get_time;

-- get sql
GET &&common_moat369_prefix._query.sql

-- header
SPO &&one_spool_filename..csv;

-- body
SET PAGES 50000;
SET COLSEP '<,>';
/
SET PAGES &&def_max_rows.;
SET COLSEP ' ';

-- get sql_id
--SPO &&moat369_log..txt APP;
SELECT prev_sql_id moat369_prev_sql_id, TO_CHAR(prev_child_number) moat369_prev_child_number FROM v$session WHERE sid = SYS_CONTEXT('USERENV', 'SID')
/
--SPO &&one_spool_filename..csv;

-- footer
SPO OFF;

-- get time t1
EXEC :get_time_t1 := DBMS_UTILITY.get_time;

-- update log2
SET HEA OFF;
SPO &&moat369_log2..txt APP;
SELECT TO_CHAR(SYSDATE, '&&moat369_date_format.')||' , '||
       TO_CHAR((:get_time_t1 - :get_time_t0)/100, '999,999,990.00')||'s , rows:'||
       '&&row_num., &&section_id., &&main_table., &&moat369_prev_sql_id., &&moat369_prev_child_number., &&title_no_spaces., csv , &&one_spool_filename..csv'
  FROM DUAL
/
SPO OFF;
SET HEA ON;

-- zip
HOS zip -m &&moat369_zip_filename. &&one_spool_filename..csv >> &&moat369_log3..txt
