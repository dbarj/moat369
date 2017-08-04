-- add seq to one_spool_filename
DEF one_spool_filename = '&&spool_filename.'
@@&&fc_seq_output_file. one_spool_filename

-- display
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') hh_mm_ss FROM DUAL;
SET TERM ON;
SPO &&moat369_log. APP;
PRO &&hh_mm_ss. &&section_id. "&&one_spool_filename._graph_chart.html"
SPO OFF;
@@&&fc_set_term_off.

-- update main report
SPO &&moat369_main_report..html APP;
PRO <a href="&&one_spool_filename._graph_chart.html">graph</a>
SPO OFF;

-- get time t0
EXEC :get_time_t0 := DBMS_UTILITY.get_time;

-- header
SPO &&one_spool_filename._graph_chart.html;
@@moat369_0d_html_header.sql
PRO
PRO <!-- &&one_spool_filename._graph_chart.html $ -->
PRO  </head>
PRO  <body>
PRO <h1> <img src="&&moat369_sw_logo_file." alt="&&moat369_sw_name." height="46" width="47" /> &&title.&&title_suffix. <em>(&&main_table.)</em></h1>
PRO <!--BEGIN_SENSITIVE_DATA-->
PRO <br>
PRO &&abstract.
PRO &&abstract2.
PRO
PRO    <img id="graph_chart" style="width: 900px; height: 500px;">
PRO

-- chart header
PRO    <script type="text/javascript" id="gchart_script">
PRO    var dot = 'digraph dot { ' +

-- body
SET SERVEROUT ON;
DECLARE
  cur SYS_REFCURSOR;
  l_node1 VARCHAR2(32767);
  l_node2 VARCHAR2(32767);
  l_attr VARCHAR2(32767);
  l_text VARCHAR2(32767);
  l_sql_text VARCHAR2(32767);
BEGIN
  --OPEN cur FOR :sql_text;
  l_sql_text := DBMS_LOB.SUBSTR(:sql_text); -- needed for 10g
  OPEN cur FOR l_sql_text; -- needed for 10g
  LOOP
    FETCH cur INTO l_node1, l_node2, l_attr, l_text;
    EXIT WHEN cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('''' || l_node1 || ' -> ' || l_node2 || ' ' || l_attr || ';'' +');
  END LOOP;
  CLOSE cur;
END;
/
SET SERVEROUT OFF;

-- get sql_id
SELECT prev_sql_id moat369_prev_sql_id, TO_CHAR(prev_child_number) moat369_prev_child_number FROM v$session WHERE sid = SYS_CONTEXT('USERENV', 'SID')
/

PRO    '}';
SET DEF OFF
PRO    src = "https://chart.googleapis.com/chart?cht=gv&chs=720x400&chl="+dot
SET DEF ON
PRO    document.getElementById("graph_chart").src=src
PRO    </script>

-- footer
PRO <br>
PRO<font class="n">Notes:<br>1) up to &&history_days. days of awr history were considered<br>2) ASH reports are based on number of samples</font>
PRO<font class="n"><br>3) &&foot.</font>
PRO <pre>
SET LIN 80;
DESC &&main_table.
SET HEA OFF;
SET LIN 32767;
PRINT sql_text_display;
SET HEA ON;
PRO &&row_num. rows selected.
PRO </pre>
PRO <!--END_SENSITIVE_DATA-->
@@moat369_0e_html_footer.sql
SPO OFF;

-- get time t1
EXEC :get_time_t1 := DBMS_UTILITY.get_time;

-- update log2
SET HEA OFF;
SPO &&moat369_log2. APP;
SELECT TO_CHAR(SYSDATE, '&&moat369_date_format.')||' , '||
       TO_CHAR((:get_time_t1 - :get_time_t0)/100, '999,999,990.00')||'s , rows:'||
       '&&row_num., &&section_id., &&main_table., &&moat369_prev_sql_id., &&moat369_prev_child_number., &&title_no_spaces., graph , &&one_spool_filename._graph_chart.html'
  FROM DUAL
/
SPO OFF;
SET HEA ON;

@@&&fc_encrypt_html. &&one_spool_filename._graph_chart.html

-- zip
HOS zip -m &&moat369_zip_filename. &&one_spool_filename._graph_chart.html >> &&moat369_log3.
