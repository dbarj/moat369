-- This code will if row_num is -1 meaning no lines were returned by the sql_text.
-- If it is, it will count lines on table to ensure it is empty and update to 0.

DEF step_file = '&&moat369_sw_output_fdr./step_file_recount.sql';

SPO &&step_file.
PRO COL row_num NOPRI
PRO GET &&moat369_query.
PRO -- remove rownum
PRO 1
PRO c/TO_CHAR(ROWNUM) row_num, v0.*/TRIM(COUNT(*)) row_num
PRO /
PRO COL row_num PRI
SPO OFF

@@&&fc_set_value_var_decode. 'step_file_exec' '&&row_num.' '-1' '&&step_file.' '&&fc_skip_script. &&step_file.'

@&&step_file_exec.
HOS rm -f &&step_file.
UNDEF step_file step_file_exec
