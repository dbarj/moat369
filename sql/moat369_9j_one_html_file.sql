-- add seq to spool_filename
DEF one_spool_filename = '&&spool_filename.'
@@&&fc_seq_output_file. one_spool_filename

-- Check mandatory variables
@@&&fc_def_empty_var. one_spool_html_file

-- display
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') hh_mm_ss FROM DUAL;
SET TERM ON
SPO &&moat369_log. APP
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
PRO <h1> <img src="&&moat369_sw_logo_file." alt="&&moat369_sw_name." height="46" width="47" /> &&section_id..&&report_sequence.. &&title.&&title_suffix.</h1>
PRO <!--BEGIN_SENSITIVE_DATA-->
PRO <br>
PRO &&abstract.
PRO &&abstract2.
PRO

-- body
SPO OFF

HOS cat &&one_spool_html_file. >> &&one_spool_filename..html

DEF step_file = 'step_file.sql';
HOS echo "DEF row_num = '"$(($(cat &&one_spool_html_file. | grep '<tr>' | wc -l)-1))"'" > &&step_file.
@&&step_file.
HOS rm -f &&step_file.


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
--DESC &&main_table.
SET HEA OFF
SET LIN 32767
--PRINT sql_text_display;
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
SPO &&moat369_log2. APP
SELECT TO_CHAR(SYSDATE, '&&moat369_date_format.')||' , '||
       TO_CHAR((:get_time_t1 - :get_time_t0)/100, '999,999,990.00')||'s , rows:'||
       '&&row_num., &&section_id., &&main_table., &&moat369_prev_sql_id., &&moat369_prev_child_number., &&title_no_spaces., html , &&one_spool_filename..html'
  FROM DUAL
/
SPO OFF
SET HEA ON

@@&&fc_encrypt_html. &&one_spool_filename..html

-- zip
HOS zip -m &&moat369_zip_filename. &&one_spool_filename..html >> &&moat369_log3.

HOS rm -f &&one_spool_html_file.

UNDEF one_spool_html_file