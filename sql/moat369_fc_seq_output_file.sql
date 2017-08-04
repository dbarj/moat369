-- This code will append to the variable provided in param1 the file sequence and the common_prefix.
-- Param 1 = Variable name

DEF in_param = "&1."
UNDEF 1

DEF step_file_seq_out = 'step_file_seq_out.sql'
HOS echo "DEF in_param_content = '&&""&&in_param..'" > &&step_file_seq_out.
@&&step_file_seq_out.
HOS rm -f &&step_file_seq_out.
UNDEF step_file_seq_out


EXEC :file_seq := :file_seq + 1;

col in_param_content new_v in_param_content nopri
SELECT LPAD(:file_seq, 5, '0') || REGEXP_REPLACE(REPLACE('_&&common_moat369_prefix._&&section_id._&&in_param_content.','__','_'),'_$','') in_param_content FROM DUAL;
col in_param_content clear

DEF &&in_param. = '&&in_param_content.'
UNDEF in_param in_param_content