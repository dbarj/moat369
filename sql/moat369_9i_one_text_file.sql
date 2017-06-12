-- Check mandatory variables
@@&&fc_def_empty_var. one_spool_text_file
@@&&fc_def_empty_var. one_spool_text_file_rename

-- add seq to one_spool_filename
BEGIN
  IF '&&one_spool_text_file_rename.' = 'Y' THEN
    :file_seq := :file_seq + 1;
  END IF;
END;
/

SELECT CASE WHEN '&&one_spool_text_file_rename.' = 'Y' THEN
 LPAD(:file_seq, 5, '0')||'_&&common_moat369_prefix._&&section_id._&&report_sequence._&&one_spool_text_file.'
ELSE
 '&&one_spool_text_file.'
END one_spool_filename
FROM DUAL;

-- display
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') hh_mm_ss FROM DUAL;
SET TERM ON;
SPO &&moat369_log..txt APP
PRO &&hh_mm_ss. &&section_id. "&&one_spool_filename."
SPO OFF
@@&&fc_set_term_off.

-- get time t0
EXEC :get_time_t0 := DBMS_UTILITY.get_time;

-- Protect accidentaly renaming files not in Tool Folder:
COL one_spool_text_file_rep NEW_V one_spool_text_file_rep NOPRI
select translate('&&one_spool_text_file.','/\\',' ') one_spool_text_file_rep FROM DUAL;
COL one_spool_text_file_rep clear

HOS if [ '&&one_spool_text_file_rename.' == 'Y' ]; then touch &&one_spool_filename.; fi
HOS if [ '&&one_spool_text_file_rename.' == 'Y' -a -f &&one_spool_text_file. -a '&&one_spool_text_file.' == '&&one_spool_text_file_rep.' ]; then mv &&one_spool_text_file. &&one_spool_filename.; fi
UNDEF one_spool_text_file_rep

DEF step_file = 'step_file.sql';
HOS echo "DEF row_num = '"$(if [ -f &&one_spool_filename. ]; then cat &&one_spool_filename. | wc -l | tr -d '[:space:]'; else echo 0; fi)"'" > &&step_file.
@&&step_file.
HOS rm -f &&step_file.

-- get sql_id
--SPO &&moat369_log..txt APP;
SELECT prev_sql_id moat369_prev_sql_id, TO_CHAR(prev_child_number) moat369_prev_child_number FROM v$session WHERE sid = SYS_CONTEXT('USERENV', 'SID')
/
--SPO &&one_spool_filename.;

-- get time t1
EXEC :get_time_t1 := DBMS_UTILITY.get_time;

-- update log2
SET HEA OFF;
SPO &&moat369_log2..txt APP;
SELECT TO_CHAR(SYSDATE, '&&moat369_date_format.')||' , '||
       TO_CHAR((:get_time_t1 - :get_time_t0)/100, '999,999,990.00')||'s , rows:'||
       '&&row_num., &&section_id., &&main_table., &&moat369_prev_sql_id., &&moat369_prev_child_number., &&title_no_spaces., txt , &&one_spool_filename.'
  FROM DUAL
/
SPO OFF;
SET HEA ON;

DEF step_file = 'step_file.sql';
HOS if [ '&&one_spool_text_file_rename.' == 'Y' ]; then echo "@&&fc_convert_txt_to_html. one_spool_filename" > &&step_file.; fi
HOS if [ '&&one_spool_text_file_rename.' == 'Y' ]; then echo "@&&fc_encrypt_html. &&""one_spool_filename." >> &&step_file.; fi
@&&step_file.
HOS rm -f &&step_file.

-- update main report
SPO &&moat369_main_report..html APP;
PRO <a href="&&one_spool_filename.">text</a>
SPO OFF;

-- zip
HOS if [ '&&one_spool_text_file_rename.' == 'Y' ]; then zip -m &&moat369_zip_filename. &&one_spool_filename. >> &&moat369_log3..txt; fi

UNDEF one_spool_text_file one_spool_text_file_rename
