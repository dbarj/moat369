-- This code will call a section and print it.
-- Param 1 = Section ID 
-- Param 2 = Section Name
-- Param 3 = File Name

DEF moat369_sec_id = '&1.'
DEF moat369_sec_fl = '&2.'
DEF moat369_sec_nm = '&3.'
UNDEF 1 2 3

@@&&moat369_0g.tkprof.sql
DEF section_id = '&&moat369_sec_id.';
DEF section_name = '&&moat369_sec_nm.';
EXEC DBMS_APPLICATION_INFO.SET_MODULE('&&moat369_prefix.','&&section_id.');
SPO &&moat369_main_report. APP;
PRO <h3>&&section_id.. &&section_name.</h3>
PRO <ol start="&&report_sequence.">
SPO OFF;

DEF sub_section_fifo = '&&moat369_sw_output_fdr./&&moat369_sec_id._fifo.sql'
HOS mkfifo &&sub_section_fifo.
set define ^ 
HOS [ '^^moat369_sw_enc_sql.' == 'Y' ] && (cat ^^moat369_sw_folder./^^moat369_sec_fl. | openssl enc -d -aes256 -a -salt -pass file:^^moat369_enc_pub_file. > ^^sub_section_fifo. &) || (cat ^^moat369_sw_folder./^^moat369_sec_fl. > ^^sub_section_fifo. &)
set define &

@&&sub_section_fifo.
HOS rm &&sub_section_fifo.

SPO &&moat369_main_report. APP;
PRO </ol>
SPO OFF;

UNDEF section_id section_name sub_section_fifo

UNDEF moat369_sec_id moat369_sec_fl moat369_sec_nm