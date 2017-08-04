-- add seq to one_spool_filename
DEF one_spool_filename = '&&spool_filename.'
@@&&fc_seq_output_file. one_spool_filename

-- Define bar_height and set value if undef
@@&&fc_def_empty_var. bar_height
@@&&fc_set_value_var_nvl. 'bar_height' '&&bar_height.' '65%'

-- display
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') hh_mm_ss FROM DUAL;
SET TERM ON;
SPO &&moat369_log. APP;
PRO &&hh_mm_ss. &&section_id. "&&one_spool_filename._bar_chart.html"
SPO OFF;
@@&&fc_set_term_off.

-- update main report
SPO &&moat369_main_report..html APP;
PRO <a href="&&one_spool_filename._bar_chart.html">bar</a>
SPO OFF;

-- get time t0
EXEC :get_time_t0 := DBMS_UTILITY.get_time;

-- header
SPO &&one_spool_filename._bar_chart.html;
@@moat369_0d_html_header.sql
PRO <!-- &&one_spool_filename._bar_chart.html $ -->
PRO  </head>
PRO  <body>
PRO <h1> <img src="&&moat369_sw_logo_file." alt="&&moat369_sw_name." height="46" width="47" /> &&section_id..&&report_sequence.. &&title.&&title_suffix. <em>(&&main_table.)</em></h1>
--PRO <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
PRO <script type="text/javascript" src="https://www.google.com/jsapi"></script>
PRO <!--BEGIN_SENSITIVE_DATA-->
PRO <br />
PRO &&abstract.
PRO &&abstract2.
PRO
-- chart header
PRO    <script type="text/javascript">
PRO      google.load("visualization", "1", {packages:["corechart"]});
PRO      google.setOnLoadCallback(drawChart);
PRO      function drawChart() {
PRO        var data = google.visualization.arrayToDataTable([

-- body
SET SERVEROUT ON;
SET SERVEROUT ON SIZE 1000000;
SET SERVEROUT ON SIZE UNL;
DECLARE
  cur SYS_REFCURSOR;
  l_bar VARCHAR2(1000);
  l_value NUMBER;
  l_others NUMBER := 100;
  l_style VARCHAR2(1000);
  l_tooltip VARCHAR2(1000);
  l_sql_text VARCHAR2(32767);
BEGIN
  DBMS_OUTPUT.PUT_LINE('[''Bucket'', ''Number of Rows'', { role: ''style'' }, { role: ''tooltip'' }]');
  --OPEN cur FOR :sql_text;
  l_sql_text := DBMS_LOB.SUBSTR(:sql_text); -- needed for 10g
  OPEN cur FOR l_sql_text; -- needed for 10g
  LOOP
    FETCH cur INTO l_bar, l_value, l_style, l_tooltip;
    EXIT WHEN cur%NOTFOUND;
    IF l_value >= 5 THEN
      DBMS_OUTPUT.PUT_LINE(',['''||l_bar||''', '||l_value||', '''||l_style||''', '''||l_tooltip||''']');
      l_others := l_others - l_value;
    END IF;
  END LOOP;
  CLOSE cur;
  l_bar := 'The rest ('||l_others||'%)';
  l_value := l_others;
  l_style := 'D3D3D3'; -- light gray
  l_tooltip := '('||l_others||'% of remaining data)';
  DBMS_OUTPUT.PUT_LINE(',['''||l_bar||''', '||l_value||', '''||l_style||''', '''||l_tooltip||''']');
END;
/
SET SERVEROUT OFF;

-- get sql_id
SELECT prev_sql_id moat369_prev_sql_id, TO_CHAR(prev_child_number) moat369_prev_child_number FROM v$session WHERE sid = SYS_CONTEXT('USERENV', 'SID')
/

-- bar chart footer
PRO        ]);;
PRO        
PRO        var options = {
PRO          chartArea:{left:90, top:90, width:'85%', height:'&&bar_height.'},
PRO          backgroundColor: {fill: 'white', stroke: '#336699', strokeWidth: 1},
PRO          title: '&&section_id..&&report_sequence.. &&title.&&title_suffix.',
PRO          titleTextStyle: {fontSize: 18, bold: false},
PRO          legend: {position: 'none'},
PRO          vAxis: {minValue: 0, title: '&&vaxis.', titleTextStyle: {fontSize: 16, bold: false}}, 
PRO          hAxis: {title: '&&haxis.', titleTextStyle: {fontSize: 16, bold: false}},
PRO          tooltip: {textStyle: {fontSize: 14}}
PRO        };
PRO
PRO        var chart = new google.visualization.ColumnChart(document.getElementById('barchart'));
PRO        chart.draw(data, options);
PRO      }
PRO    </script>
PRO
PRO    <div id="barchart" class="google-chart"></div>
PRO

-- footer
PRO <br />
PRO <font class="n">Notes:<br>1) Values are approximated<br>2) Hovering on the bars show more info.</font>
PRO <font class="n"><br />3) &&foot.</font>
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
       '&&row_num., &&section_id., &&main_table., &&moat369_prev_sql_id., &&moat369_prev_child_number., &&title_no_spaces., bar , &&one_spool_filename._bar_chart.html'
  FROM DUAL
/
SPO OFF;
SET HEA ON;

@@&&fc_encrypt_html. &&one_spool_filename._pie_chart.html

-- zip
HOS zip -m &&moat369_zip_filename. &&one_spool_filename._bar_chart.html >> &&moat369_log3.
