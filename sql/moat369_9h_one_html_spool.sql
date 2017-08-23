-- add seq to spool_filename
DEF one_spool_filename = '&&spool_filename.'
@@&&fc_seq_output_file. one_spool_filename

@@moat369_0j_html_topic_intro.sql &&one_spool_filename..html html

-- get sql
SET HEA OFF
COL row_num NOPRI
GET &&common_moat369_prefix._query.sql
-- remove rownum
--1
--c/TO_CHAR(ROWNUM) row_num,/

SPO &&one_spool_filename..html APP
-- body
SET MARK HTML OFF HEAD OFF SPOOL OFF
/
SPO OFF

@@&&fc_check_last_sql_status. &&one_spool_filename..html

-- get sql_id
SELECT prev_sql_id moat369_prev_sql_id, TO_CHAR(prev_child_number) moat369_prev_child_number FROM v$session WHERE sid = SYS_CONTEXT('USERENV', 'SID')
/

SPO &&one_spool_filename..html APP
-- footer
PRO &&foot.
--PRO #: click on a column heading to sort on it
PRO
SPO OFF

@@moat369_0k_html_topic_end.sql &&one_spool_filename..html html N

COL row_num PRI

@@&&fc_encrypt_html. &&one_spool_filename..html

-- zip
HOS zip -m &&moat369_zip_filename. &&one_spool_filename..html >> &&moat369_log3.
