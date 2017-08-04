-- This code will save step files generated during MOAT369 execution for DEBUG.
DEF in_file_name = '&1.'
UNDEF 1

EXEC :driver_seq := :driver_seq + 1;

COL step_new_file_name new_v step_new_file_name nopri
SELECT LPAD(:driver_seq, 3, '0') || '_&&in_file_name.' step_new_file_name from dual;
COL step_new_file_name clear

HOS mv &&in_file_name. &&step_new_file_name.

HOS zip -m &&moat369_driver. &&step_new_file_name. >> &&moat369_log3.

UNDEF in_file_name step_new_file_name
