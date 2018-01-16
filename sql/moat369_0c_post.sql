 -- End Time
VAR moat369_main_time1 NUMBER;
EXEC :moat369_main_time1 := DBMS_UTILITY.GET_TIME;

COL total_hours NEW_V total_hours;
SELECT 'Tool execution hours: '||TO_CHAR(ROUND((:moat369_main_time1 - :moat369_main_time0) / 100 / 3600, 3), '990.000')||'.' total_hours FROM DUAL;
COL total_hours clear

SPO &&moat369_main_report. APP;
@@moat369_0e_html_footer.sql
SPO OFF;

@@&&fc_encrypt_html. &&moat369_main_report. 'INDEX'

PRO ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- turing trace off
ALTER SESSION SET SQL_TRACE = FALSE;
@@&&moat369_0g.tkprof.sql

PRO ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- readme
SPO &&moat369_readme.
PRO 1. Unzip &&moat369_zip_filename_nopath..zip into a directory
PRO 2. Review &&moat369_main_report.
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
HOS cp &&background_dump_dest./alert_&&db_name_upper.*.log &&moat369_sw_output_fdr./ >> &&moat369_log3. 2> &&moat369_log3.
HOS cp &&background_dump_dest./alert_&&db_name_lower.*.log &&moat369_sw_output_fdr./ >> &&moat369_log3. 2> &&moat369_log3.
HOS cp &&background_dump_dest./alert_&&_connect_identifier..log &&moat369_sw_output_fdr./ >> &&moat369_log3. 2> &&moat369_log3.
-- Altered to be compatible with SunOS:
-- HOS rename alert_ &&moat369_alert._ alert_*.log >> &&moat369_log3.
HOS ls -1 &&moat369_sw_output_fdr./alert_*.log 2> &&moat369_log3. | while read line || [ -n "$line" ]; do mv $line &&moat369_alert._$line; done >> &&moat369_log3.

-- zip
HOS if [ -z '&&moat369_sw_key_file.' ]; then rm -f &&enc_key_file.; fi
HOS zip -mj &&moat369_zip_filename. &&moat369_alert.*.log >> &&moat369_log3.
HOS if [ '&&moat369_conf_incl_opatch.' == 'Y' ]; then zip -j &&moat369_opatch. $ORACLE_HOME/cfgtoollogs/opatch/opatch* >> &&moat369_log3.; fi
HOS if [ -f &&moat369_opatch. ]; then zip -mj &&moat369_zip_filename. &&moat369_opatch. >> &&moat369_log3.; fi
HOS zip -mj &&moat369_zip_filename. &&moat369_driver.           >> &&moat369_log3.
HOS zip -mj &&moat369_zip_filename. &&moat369_log2.             >> &&moat369_log3.
HOS zip -mj &&moat369_zip_filename. &&moat369_tkprof._sort.txt  >> &&moat369_log3.
HOS zip -mj &&moat369_zip_filename. &&moat369_log.              >> &&moat369_log3.
HOS zip -mj &&moat369_zip_filename. &&moat369_main_report.      >> &&moat369_log3.
HOS zip -mj &&moat369_zip_filename. &&moat369_readme.           >> &&moat369_log3.
HOS unzip -l &&moat369_zip_filename.                            >> &&moat369_log3.
HOS zip -mj &&moat369_zip_filename. &&moat369_log3.             > /dev/null
SET TERM ON;
