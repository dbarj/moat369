-- add seq to spool_filename
DEF one_spool_filename = '&&spool_filename.'
@@&&fc_seq_output_file. one_spool_filename
DEF one_spool_fullpath_filename = '&&moat369_sw_output_fdr./&&one_spool_filename..html'

@@moat369_0j_html_topic_intro.sql &&one_spool_filename..html html

SPO &&one_spool_fullpath_filename. APP
PRO <script type="text/javascript" src="sorttable.js"></script>
SPO OFF

-- get sql
GET &&moat369_query.

SPO &&one_spool_fullpath_filename. APP
-- body
SET MARK HTML ON TABLE 'class="sortable"' SPOOL OFF
/
SET MARK HTML OFF
SPO OFF

-- get sql_id
SELECT prev_sql_id moat369_prev_sql_id, TO_CHAR(prev_child_number) moat369_prev_child_number FROM v$session WHERE sid = SYS_CONTEXT('USERENV', 'SID');

@@&&fc_check_last_sql_status.

SPO &&one_spool_fullpath_filename. APP
-- footer
PRO &&foot.
PRO #: click on a column heading to sort on it
PRO
SPO OFF

@@moat369_0k_html_topic_end.sql &&one_spool_filename..html html

@@&&fc_encrypt_html. &&one_spool_fullpath_filename.

HOS zip -mj &&moat369_zip_filename. &&one_spool_fullpath_filename. >> &&moat369_log3.

UNDEF one_spool_fullpath_filename