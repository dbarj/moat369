-- This code will generate a default "SELECT * FROM" query based on table of parameter 1 and put this query into parameter 2 variable.
DEF in_table    = '&1.'
DEF in_variable = '&2.'

UNDEF 1 2

DEF def_sel_star_qry = ''
COL def_sel_star_qry NEW_V def_sel_star_qry

SELECT
'SELECT /*+ &&top_level_hints. */ /* &&section_id..&&report_sequence. */' || CHR(10) ||
'       *' || CHR(10) ||
'  FROM &&in_table.' || CHR(10) ||
' ORDER BY ' || CHR(10) ||
'       1, 2' def_sel_star_qry
FROM DUAL;

COL def_sel_star_qry clear

EXEC :&&in_variable. := '&&def_sel_star_qry.';

UNDEF in_table in_variable
UNDEF def_sel_star_qry