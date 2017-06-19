-- End Time
VAR moat369_main_time1 NUMBER;
EXEC :moat369_main_time1 := DBMS_UTILITY.GET_TIME;

COL total_hours NEW_V total_hours;
SELECT 'Tool execution hours: '||TO_CHAR(ROUND((:moat369_main_time1 - :moat369_main_time0) / 100 / 3600, 3), '990.000')||'.' total_hours FROM DUAL;
COL total_hours clear

SPO &&moat369_main_report..html APP;
@@moat369_0e_html_footer.sql
SPO OFF;

@@&&fc_encrypt_html. &&moat369_main_report..html 'INDEX'

PRO ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- turing trace off
ALTER SESSION SET SQL_TRACE = FALSE;
@@&&moat369_0g.tkprof.sql

PRO ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- readme
SPO 00000_readme_first.txt
PRO 1. Unzip &&moat369_zip_filename..zip into a directory
PRO 2. Review &&moat369_main_report..html
SPO OFF;

-- cleanup
SET HEA ON; 
SET LIN 80; 
SET NEWP 1; 
SET PAGES 14; 
SET LONG 80; 
SET LONGC 80; 
SET WRA ON; 
SET TRIMS OFF; 
SET TRIM OFF; 
SET TI OFF; 
SET TIMI OFF; 
SET ARRAY 15; 
SET NUM 10; 
SET NUMF ""; 
SET SQLBL OFF; 
SET BLO ON; 
SET RECSEP WR;
UNDEF 1

-- alert log (3 methods)
COL db_name_upper NEW_V db_name_upper
COL db_name_lower NEW_V db_name_lower
COL background_dump_dest NEW_V background_dump_dest
SELECT UPPER(SYS_CONTEXT('USERENV', 'DB_NAME')) db_name_upper FROM DUAL;
SELECT LOWER(SYS_CONTEXT('USERENV', 'DB_NAME')) db_name_lower FROM DUAL;
SELECT value background_dump_dest FROM v$parameter WHERE name = 'background_dump_dest';
COL db_name_upper clear
COL db_name_lower clear
COL background_dump_dest clear
HOS cp &&background_dump_dest./alert_&&db_name_upper.*.log . >> &&moat369_log3..txt
HOS cp &&background_dump_dest./alert_&&db_name_lower.*.log . >> &&moat369_log3..txt
HOS cp &&background_dump_dest./alert_&&_connect_identifier..log . >> &&moat369_log3..txt
-- Altered to be compatible with SunOS:
-- HOS rename alert_ 00006_&&common_moat369_prefix._alert_ alert_*.log >> &&moat369_log3..txt
HOS ls -1 alert_*.log | while read line || [ -n "$line" ]; do mv $line 00006_&&common_moat369_prefix._$line; done >> &&moat369_log3..txt

--
DEF moat369_opatch = '00007_&&common_moat369_prefix._opatch.zip'
-- zip
HOS rm -f &&enc_key_file.
HOS zip -m &&moat369_zip_filename. &&common_moat369_prefix._query.sql >> &&moat369_log3..txt
HOS zip -d &&moat369_zip_filename. &&common_moat369_prefix._query.sql >> &&moat369_log3..txt
HOS zip -m &&moat369_zip_filename. 00006_&&common_moat369_prefix._alert_*.log >> &&moat369_log3..txt
HOS if [ '&&moat369_conf_incl_opatch.' == 'Y' ]; then zip -j &&moat369_opatch. $ORACLE_HOME/cfgtoollogs/opatch/opatch* >> &&moat369_log3..txt; fi
HOS if [ -f &&moat369_opatch. ]; then zip -m &&moat369_zip_filename. &&moat369_opatch. >> &&moat369_log3..txt; fi
HOS zip -m &&moat369_zip_filename. &&moat369_driver. >> &&moat369_log3..txt
HOS zip -m &&moat369_zip_filename. &&moat369_log2..txt >> &&moat369_log3..txt
HOS zip -m &&moat369_zip_filename. &&moat369_tkprof._sort.txt >> &&moat369_log3..txt
HOS zip -m &&moat369_zip_filename. &&moat369_log..txt >> &&moat369_log3..txt
HOS zip -m &&moat369_zip_filename. &&moat369_main_report..html >> &&moat369_log3..txt
HOS zip -m &&moat369_zip_filename. 00000_readme_first.txt >> &&moat369_log3..txt
HOS unzip -l &&moat369_zip_filename. >> &&moat369_log3..txt
HOS zip -m &&moat369_zip_filename. &&moat369_log3..txt
SET TERM ON;
