-- Convert string on variable specified at parameter 1 to file_name string returned on variable specified on parameter 2
-- Param 1 = Input Variable
-- Param 2 = Output Variable

DEF in_param  = '&1.'
DEF out_param = '&2.'
UNDEF 1 2

DEF step_file = 'step_file.sql'
SPOOL &&step_file.
PRO DEF in_param_content = '&&&&in_param..'
SPOOL OFF
@&&step_file.
HOS rm -f &&step_file.
UNDEF step_file

COL &&out_param. NEW_V &&out_param.
SELECT REPLACE(TRANSLATE('&&in_param_content.',
'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ''`~!@#$%^*()-_=+[]{}\|;:",.<>/?'||CHR(0)||CHR(9)||CHR(10)||CHR(13)||CHR(38),
'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz0123456789_'), '__', '_') &&out_param. FROM DUAL;
COL &&out_param. clear

UNDEF in_param in_param_content out_param