-- setup
SET VER OFF
SET FEED OFF
SET ECHO OFF
SELECT TO_CHAR(SYSDATE, '&&moat369_date_format.') moat369_time_stamp FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') hh_mm_ss FROM DUAL;
@@&&fc_clean_file_name. "title" "title_no_spaces"
SELECT '&&report_sequence._&&title_no_spaces.' spool_filename FROM DUAL;
SET HEA OFF
SET TERM ON

-- log
SPO &&moat369_log. APP;
PRO
PRO ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PRO
PRO &&hh_mm_ss. &&section_id. "&&section_name."
PRO &&hh_mm_ss. &&title.&&title_suffix.
PRO

-- Check if we will use sql_text or sql_text_cdb
BEGIN
  IF :sql_text_cdb IS NOT NULL AND '&&is_cdb.' = 'Y' then
    :sql_text := :sql_text_cdb;
  ELSE
    :sql_text := :sql_text; -- Do not remove this crazy thing.
  END IF;
END;
/

EXEC :sql_text_display := TRIM(CHR(10) FROM :sql_text);

-- count
PRINT sql_text_display;
--SELECT '0' row_num FROM DUAL;
PRO &&hh_mm_ss. &&section_id..&&report_sequence.
EXEC :sql_text_display := REPLACE(REPLACE(TRIM(CHR(10) FROM :sql_text)||';', '<', CHR(38)||'lt;'), '>', CHR(38)||'gt;');
--SET TIMI ON;
--SET SERVEROUT ON;

-- TODO COPY FROM EDB

--SET TIMI OFF;
--SET SERVEROUT OFF;
--PRO
SPO OFF;
@@&&fc_set_term_off.
HOS zip &&moat369_zip_filename. &&moat369_log. >> &&moat369_log3.

-- spools query
SPO &&common_moat369_prefix._query.sql;
SELECT 'SELECT TO_CHAR(ROWNUM) row_num, v0.* FROM /* &&section_id..&&report_sequence. */ (' || REPLACE(CHR(10)||TRIM(CHR(10) FROM :sql_text)||CHR(10),CHR(10)||CHR(10),CHR(10)) || ') v0 WHERE ROWNUM <= &&max_rows.' FROM DUAL;
SPO OFF;
SET HEA ON;
--GET &&common_moat369_prefix._query.sql

-- update main report
SPO &&moat369_main_report..html APP;
PRO <li title="&&main_table.">&&title.
SPO OFF;
HOS zip &&moat369_zip_filename. &&moat369_main_report..html >> &&moat369_log3.

-- Put standard values on skip
@@&&fc_set_value_var_nvl. skip_html       '&&skip_html.'       '' '&&fc_skip_script.'
@@&&fc_set_value_var_nvl. skip_text       '&&skip_text.'       '' '&&fc_skip_script.'
@@&&fc_set_value_var_nvl. skip_csv        '&&skip_csv.'        '' '&&fc_skip_script.'
@@&&fc_set_value_var_nvl. skip_lch        '&&skip_lch.'        '' '&&fc_skip_script.'
@@&&fc_set_value_var_nvl. skip_pch        '&&skip_pch.'        '' '&&fc_skip_script.'
@@&&fc_set_value_var_nvl. skip_bch        '&&skip_bch.'        '' '&&fc_skip_script.'
@@&&fc_set_value_var_nvl. skip_graph      '&&skip_graph.'      '' '&&fc_skip_script.'
@@&&fc_set_value_var_nvl. skip_html_spool '&&skip_html_spool.' '' '&&fc_skip_script.'
@@&&fc_set_value_var_nvl. skip_text_file  '&&skip_text_file.'  '' '&&fc_skip_script.'
@@&&fc_set_value_var_nvl. skip_html_file  '&&skip_html_file.'  '' '&&fc_skip_script.'

-- execute one sql
@@&&skip_html.&&moat369_skip_html.moat369_9b_one_html.sql
@@&&skip_text.&&moat369_skip_text.moat369_9c_one_text.sql
@@&&skip_csv.&&moat369_skip_csv.moat369_9d_one_csv.sql
@@&&skip_lch.&&moat369_skip_line.moat369_9e_one_line_chart.sql
@@&&skip_pch.&&moat369_skip_pie.moat369_9f_one_pie_chart.sql
@@&&skip_bch.&&moat369_skip_bar.moat369_9k_one_bar_chart.sql
@@&&skip_graph.&&moat369_skip_graph.moat369_9g_one_graphviz_chart.sql
@@&&skip_html_spool.&&moat369_skip_html.moat369_9h_one_html_spool.sql
@@&&skip_text_file.&&moat369_skip_file.moat369_9i_one_text_file.sql
@@&&skip_html_file.&&moat369_skip_html.moat369_9j_one_html_file.sql
--
HOS zip &&moat369_zip_filename. &&moat369_log2. >> &&moat369_log3.
HOS zip &&moat369_zip_filename. &&moat369_log3. > /dev/null

-- sql monitor long executions of sql from moat369
-- SELECT 'N' moat369_tuning_pack_for_sqlmon, '--' skip_sqlmon_exec FROM DUAL
-- /
-- SELECT '&&tuning_pack.' moat369_tuning_pack_for_sqlmon, NULL skip_sqlmon_exec, SUBSTR(sql_text, 1, 100) moat369_sql_text_100, elapsed_time FROM v$sql
-- WHERE sql_id = '&&moat369_prev_sql_id.' AND elapsed_time / 1e6 > 60 /* seconds */
-- /
-- @@&&skip_tuning.&&skip_sqlmon_exec.sqlmon.sql &&moat369_tuning_pack_for_sqlmon. &&moat369_prev_sql_id.
-- HOS zip -m &&moat369_zip_filename. sqlmon_&&moat369_prev_sql_id._&&current_time..zip >> &&moat369_log3.

SET TERM ON
SPO &&moat369_log. APP
PRO
PRO &&row_num. rows selected.
SPO OFF
@@&&fc_set_term_off.

-- update main report
SPO &&moat369_main_report..html APP;
PRO <small><em> (&&row_num.)</em></small>
PRO </li>
SPO OFF;
HOS zip &&moat369_zip_filename. &&moat369_main_report..html >> &&moat369_log3.

-- needed reset after eventual sqlmon above
SET HEA ON
SET LIN 32767
SET NEWP NONE
SET PAGES &&def_max_rows.
SET LONG 32000000
SET LONGC 2000
SET WRA ON
SET TRIMS ON
SET TRIM ON
SET TI OFF
SET TIMI OFF
SET ARRAY 1000
SET NUM 20
SET SQLBL ON
SET BLO .
SET RECSEP OFF

-- cleanup
EXEC :sql_text := NULL;
EXEC :sql_text_cdb := NULL;
DEF row_num = '0'
DEF abstract = '';
DEF abstract2 = '';
DEF main_table = '';
DEF foot = '';
DEF max_rows = '&&def_max_rows.';
--
DEF skip_html       = '&&moat369_def_skip_html.'
DEF skip_text       = '&&moat369_def_skip_text.'
DEF skip_csv        = '&&moat369_def_skip_csv.'
DEF skip_lch        = '&&moat369_def_skip_line.'
DEF skip_pch        = '&&moat369_def_skip_pie.'
DEF skip_bch        = '&&moat369_def_skip_bar.'
DEF skip_graph      = '&&moat369_def_skip_graph.'
DEF skip_html_spool = '&&fc_skip_script.'
DEF skip_text_file  = '&&fc_skip_script.'
DEF skip_html_file  = '&&fc_skip_script.'
--
DEF title_suffix = '';
DEF haxis = '&&db_version. &&cores_threads_hosts.'

-- report sequence
EXEC :repo_seq := :repo_seq + 1;
SELECT TO_CHAR(:repo_seq) report_sequence FROM DUAL;