-- This code will skip a script and print what command line was not executed.
COL c_skip_script_1 NEW_V 1 NOPRI
COL c_skip_script_2 NEW_V 2 NOPRI
COL c_skip_script_3 NEW_V 3 NOPRI
COL c_skip_script_4 NEW_V 4 NOPRI
COL c_skip_script_5 NEW_V 5 NOPRI
COL c_skip_script_6 NEW_V 6 NOPRI
COL c_skip_script_7 NEW_V 7 NOPRI
COL c_skip_script_8 NEW_V 8 NOPRI

@@&&fc_set_term_off.

SELECT '' c_skip_script_1, '' c_skip_script_2, '' c_skip_script_3, '' c_skip_script_4, '' c_skip_script_5, '' c_skip_script_6, '' c_skip_script_7, '' c_skip_script_8 FROM dual WHERE ROWNUM = 0;

COL c_skip_script_1 clear
COL c_skip_script_2 clear
COL c_skip_script_3 clear
COL c_skip_script_4 clear
COL c_skip_script_5 clear
COL c_skip_script_6 clear
COL c_skip_script_7 clear
COL c_skip_script_8 clear

COL c_skip_result NEW_V c_skip_result NOPRI

SELECT TRIM('&1. &2. &3. &4. &5. &6. &7. &8.') c_skip_result FROM dual;

COL c_skip_result clear

PRO Skip call "&c_skip_result." as per execution parameter.

UNDEF 1 2 3 4 5 6 7 8

UNDEF c_skip_result