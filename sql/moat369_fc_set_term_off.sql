-- This module will turn term output off only if debug mode is not enabled.
SET TERM OFF

COL c_set_term_off NEW_V PARAM1 NOPRI
DEF PARAM1 = 'TERM OFF'

SELECT 'TERM ON' c_set_term_off FROM DUAL WHERE UPPER(TRIM('&&DEBUG.')) = 'ON';
SET &&PARAM1.

COL c_set_term_off clear
UNDEF PARAM1