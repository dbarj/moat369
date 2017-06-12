-- This code will check if parameter 1 has a valid file. If it does, it will put the file in the stardard name and update the input parameter with the new name.
-- Param 1 = Variable with file path

DEF in_param = "&1."
UNDEF 1

DEF step_file = 'step_file.sql'
HOS echo "DEF in_param_content = '&&""&&in_param..'" > &&step_file.
@&&step_file.

HOS if [ -f &&in_param_content. ]; then echo "EXEC :file_seq := :file_seq + 1;" > &&step_file.; fi
HOS if [ -f &&in_param_content. ]; then echo "SELECT LPAD(:file_seq, 5, '0')||'_&&""common_moat369_prefix._&&""section_id._&&""in_param_content.' one_spool_filename FROM DUAL;" >> &&step_file.; fi
HOS if [ -f &&in_param_content. ]; then echo "HOS mv &&""in_param_content. &&""one_spool_filename." >> &&step_file.; fi
HOS if [ -f &&in_param_content. ]; then echo "DEF &&in_param. = '&&""one_spool_filename.'" >> &&step_file.; fi
@&&step_file.

HOS rm -f &&step_file.
UNDEF step_file

UNDEF in_param in_param_content