-- add seq to one_spool_filename
EXEC :file_seq := :file_seq + 1;
SELECT LPAD(:file_seq, 5, '0')||'_&&spool_filename.' one_spool_filename FROM DUAL;

-- display
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') hh_mm_ss FROM DUAL;
SET TERM ON;
SPO &&moat369_log..txt APP;
PRO &&hh_mm_ss. &&section_id. "&&one_spool_filename._pie_chart.html"
SPO OFF;
@@&&fc_set_term_off.

-- update main report
SPO &&moat369_main_report..html APP;
PRO <a href="&&one_spool_filename._pie_chart.html">pie</a>
SPO OFF;

-- get time t0
EXEC :get_time_t0 := DBMS_UTILITY.get_time;

-- header
SPO &&one_spool_filename._pie_chart.html;
@@moat369_0d_html_header.sql
PRO <!-- &&one_spool_filename._pie_chart.html $ -->
PRO  </head>
PRO  <body>
PRO <h1> <img src="&&moat369_sw_logo_file." alt="&&moat369_sw_name." height="46" width="47" /> &&section_id..&&report_sequence.. &&title.&&title_suffix. <em>(&&main_table.)</em></h1>
PRO <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
PRO <!--BEGIN_SENSITIVE_DATA-->
PRO <br>
PRO &&abstract.
PRO &&abstract2.
PRO
-- chart header
PRO    <script type="text/javascript" id="gchart_script">
PRO      google.charts.load("current", {packages:["corechart"]});
PRO      google.charts.setOnLoadCallback(drawChart);
PRO      function drawChart() {
PRO        var data = google.visualization.arrayToDataTable([

-- body
SET SERVEROUT ON;
DECLARE
  cur SYS_REFCURSOR;
  l_slice VARCHAR2(32767);
  l_value NUMBER;
  l_percent NUMBER;
  l_text VARCHAR2(32767);
  l_sql_text VARCHAR2(32767);
BEGIN
  DBMS_OUTPUT.PUT_LINE('[''Slice'', ''Value'']');
  --OPEN cur FOR :sql_text;
  l_sql_text := DBMS_LOB.SUBSTR(:sql_text); -- needed for 10g
  OPEN cur FOR l_sql_text; -- needed for 10g
  LOOP
    FETCH cur INTO l_slice, l_value, l_percent, l_text;
    EXIT WHEN cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(',['''||l_slice||''', {v: '||l_value||', f: '''||l_percent||'%''}]');
  END LOOP;
  CLOSE cur;
END;
/
SET SERVEROUT OFF;

-- get sql_id
SELECT prev_sql_id moat369_prev_sql_id, TO_CHAR(prev_child_number) moat369_prev_child_number FROM v$session WHERE sid = SYS_CONTEXT('USERENV', 'SID')
/

-- chart footer
PRO        ]);;
PRO        
PRO        var options = {
PRO          is3D: true,
PRO          backgroundColor: {fill: '#fcfcf0', stroke: '#336699', strokeWidth: 1},
PRO          title: '&&title.&&title_suffix.',
PRO          titleTextStyle: {fontSize: 16, bold: false},
PRO          legend: {position: 'right', textStyle: {fontSize: 12}},
PRO          tooltip: {textStyle: {fontSize: 14}},
PRO          sliceVisibilityThreshold: 1/10000,
PRO          pieSliceText: 'value',
PRO          tooltip: {
PRO                    showColorCode: true,
PRO                    text: 'value',
PRO                    trigger: 'selection'
PRO                  }
PRO          };
PRO
PRO        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
PRO        chart.draw(data, options);
PRO      }
PRO    </script>
PRO
PRO    <div id="piechart_3d" class="google-chart"></div>
PRO

-- footer
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
SPO &&moat369_log2..txt APP;
SELECT TO_CHAR(SYSDATE, '&&moat369_date_format.')||' , '||
       TO_CHAR((:get_time_t1 - :get_time_t0)/100, '999,999,990.00')||'s , rows:'||
       '&&row_num., &&section_id., &&main_table., &&moat369_prev_sql_id., &&moat369_prev_child_number., &&title_no_spaces., pie , &&one_spool_filename._pie_chart.html'
  FROM DUAL
/
SPO OFF;
SET HEA ON;

@@&&fc_encrypt_html. &&one_spool_filename._pie_chart.html

-- zip
HOS zip -m &&moat369_zip_filename. &&one_spool_filename._pie_chart.html >> &&moat369_log3..txt
