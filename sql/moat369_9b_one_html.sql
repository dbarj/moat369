-- add seq to spool_filename
EXEC :file_seq := :file_seq + 1;
SELECT LPAD(:file_seq, 5, '0')||'_&&spool_filename.' one_spool_filename FROM DUAL;

-- display
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') hh_mm_ss FROM DUAL;
SET TERM ON
SPO &&moat369_log..txt APP
PRO &&hh_mm_ss. &&section_id. "&&one_spool_filename..html"
SPO OFF
@@&&fc_set_term_off.

-- update main report
SPO &&moat369_main_report..html APP
PRO <a href="&&one_spool_filename..html">html</a>
SPO OFF

-- get time t0
EXEC :get_time_t0 := DBMS_UTILITY.get_time;

-- get sql
GET &&common_moat369_prefix._query.sql

-- header
SPO &&one_spool_filename..html
@@moat369_0d_html_header.sql
PRO <script type="text/javascript" src="sorttable.js"></script>
PRO
PRO <!-- &&one_spool_filename..html $ -->
PRO </head>
PRO <body>
PRO <h1> <img src="&&moat369_sw_logo_file." alt="&&moat369_sw_name." height="46" width="47" /> &&section_id..&&report_sequence.. &&title.&&title_suffix. <em>(&&main_table.)</em></h1>
PRO <!--BEGIN_SENSITIVE_DATA-->
PRO <br>
PRO &&abstract.
PRO &&abstract2.
PRO

-- body
SET MARK HTML ON TABLE 'class="sortable"' SPOOL OFF
/
SET MARK HTML OFF
SPO OFF

@@&&fc_check_last_sql_status. &&one_spool_filename..html

-- get sql_id
SELECT prev_sql_id moat369_prev_sql_id, TO_CHAR(prev_child_number) moat369_prev_child_number FROM v$session WHERE sid = SYS_CONTEXT('USERENV', 'SID')
/

SPO &&one_spool_filename..html APP
-- footer
PRO &&foot.
PRO #: click on a column heading to sort on it
PRO
PRO <pre>
SET LIN 80
DESC &&main_table.
SET HEA OFF
SET LIN 32767
PRINT sql_text_display
SET HEA ON
PRO &&row_num. rows selected.
PRO </pre>
PRO <!--END_SENSITIVE_DATA-->
@@moat369_0e_html_footer.sql
SPO OFF

-- get time t1
EXEC :get_time_t1 := DBMS_UTILITY.get_time;

-- update log2
SET HEA OFF
SPO &&moat369_log2..txt APP
SELECT TO_CHAR(SYSDATE, '&&moat369_date_format.')||' , '||
       TO_CHAR((:get_time_t1 - :get_time_t0)/100, '999,999,990.00')||'s , rows:'||
       '&&row_num., &&section_id., &&main_table., &&moat369_prev_sql_id., &&moat369_prev_child_number., &&title_no_spaces., html , &&one_spool_filename..html'
  FROM DUAL
/
SPO OFF
SET HEA ON

@@&&fc_encrypt_html. &&one_spool_filename..html

-- zip
HOS zip -m &&moat369_zip_filename. &&one_spool_filename..html >> &&moat369_log3..txt
