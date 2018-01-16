-- Parameter 1 : HTML file to be encrypted
-- Parameter 2 : Optional parameter. If not null, means this is the first index page and add a the application logo
DEF in_enc_html_src_file = '&1.'
UNDEF 1

-- Do not ask for &2. if 2nd parameter is null.
COL C2 NEW_V 2
SELECT '' "C2" FROM dual WHERE ROWNUM = 0;
COL C2 clear
--

DEF enc_html_template_file = ''
COL enc_html_template_file NEW_V enc_html_template_file 
SELECT DECODE('&2.','','&&moat369_fdr_sql./moat369_0h_html_encryption.sql','&&moat369_fdr_sql./moat369_0i_html_encryption_index.sql') enc_html_template_file FROM DUAL;
COL enc_html_template_file clear
UNDEF 2

DEF step_enc_html_file = '&&moat369_sw_output_fdr./step_enc_html_template.sql'
SPOOL &&step_enc_html_file.
@@&&enc_html_template_file.
SPOOL OFF

HOS sh &&moat369_fdr_sh./encrypt_html.sh &&in_enc_html_src_file. &&step_enc_html_file. &&enc_key_file. ### Encrypt file.

UNDEF in_enc_html_src_file enc_html_template_file

HOS rm -f &&step_enc_html_file.
UNDEF step_enc_html_file