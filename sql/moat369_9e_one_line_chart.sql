-- add seq to one_spool_filename
DEF one_spool_filename = '&&spool_filename.'
@@&&fc_seq_output_file. one_spool_filename

-- Check mandatory variables
@@&&fc_def_empty_var. tit_01
@@&&fc_def_empty_var. tit_02
@@&&fc_def_empty_var. tit_03
@@&&fc_def_empty_var. tit_04
@@&&fc_def_empty_var. tit_05
@@&&fc_def_empty_var. tit_06
@@&&fc_def_empty_var. tit_07
@@&&fc_def_empty_var. tit_08
@@&&fc_def_empty_var. tit_09
@@&&fc_def_empty_var. tit_10
@@&&fc_def_empty_var. tit_11
@@&&fc_def_empty_var. tit_12
@@&&fc_def_empty_var. tit_13
@@&&fc_def_empty_var. tit_14
@@&&fc_def_empty_var. tit_15
@@&&fc_def_empty_var. stacked
@@&&fc_def_empty_var. haxis
@@&&fc_def_empty_var. vaxis
@@&&fc_def_empty_var. vbaseline
@@&&fc_def_empty_var. chartype

-- Check mandatory variables
@@&&fc_def_empty_var. one_spool_line_chart_file

-- display
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') hh_mm_ss FROM DUAL;
SET TERM ON;
SPO &&moat369_log. APP;
PRO &&hh_mm_ss. &&section_id. "&&one_spool_filename._line_chart.html"
SPO OFF;
@@&&fc_set_term_off.

-- update main report
SPO &&moat369_main_report..html APP;
PRO <a href="&&one_spool_filename._line_chart.html">line</a>
SPO OFF;

-- get time t0
EXEC :get_time_t0 := DBMS_UTILITY.get_time;

-- header
SPO &&one_spool_filename._line_chart.html;
@@moat369_0d_html_header.sql
PRO <!-- &&one_spool_filename._line_chart.html $ -->
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
  l_snap_id NUMBER;
  l_begin_time VARCHAR2(32);
  l_end_time VARCHAR2(32);
  l_col_01 NUMBER;
  l_col_02 NUMBER;
  l_col_03 NUMBER;
  l_col_04 NUMBER;
  l_col_05 NUMBER;
  l_col_06 NUMBER;
  l_col_07 NUMBER;
  l_col_08 NUMBER;
  l_col_09 NUMBER;
  l_col_10 NUMBER;
  l_col_11 NUMBER;
  l_col_12 NUMBER;
  l_col_13 NUMBER;
  l_col_14 NUMBER;
  l_col_15 NUMBER;
  l_line VARCHAR2(1000);
  l_sql_text VARCHAR2(32767);
BEGIN
  IF '&&one_spool_line_chart_file.' IS NULL THEN
    l_line := '[''Date''';
    IF '&&tit_01.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_01.'''; 
    END IF;
    IF '&&tit_02.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_02.'''; 
    END IF;
    IF '&&tit_03.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_03.'''; 
    END IF;
    IF '&&tit_04.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_04.'''; 
    END IF;
    IF '&&tit_05.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_05.'''; 
    END IF;
    IF '&&tit_06.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_06.'''; 
    END IF;
    IF '&&tit_07.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_07.'''; 
    END IF;
    IF '&&tit_08.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_08.'''; 
    END IF;
    IF '&&tit_09.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_09.'''; 
    END IF;
    IF '&&tit_10.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_10.'''; 
    END IF;
    IF '&&tit_11.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_11.'''; 
    END IF;
    IF '&&tit_12.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_12.'''; 
    END IF;
    IF '&&tit_13.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_13.'''; 
    END IF;
    IF '&&tit_14.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_14.'''; 
    END IF;
    IF '&&tit_15.' IS NOT NULL THEN
      l_line := l_line||', ''&&tit_15.'''; 
    END IF;
    l_line := l_line||']';
    DBMS_OUTPUT.PUT_LINE(l_line);
    --OPEN cur FOR :sql_text;
    l_sql_text := DBMS_LOB.SUBSTR(:sql_text); -- needed for 10g
    OPEN cur FOR l_sql_text; -- needed for 10g
    LOOP
      FETCH cur INTO l_snap_id, l_begin_time, l_end_time,
      l_col_01, l_col_02, l_col_03, l_col_04, l_col_05,
      l_col_06, l_col_07, l_col_08, l_col_09, l_col_10,
      l_col_11, l_col_12, l_col_13, l_col_14, l_col_15;
      EXIT WHEN cur%NOTFOUND;
      l_line := ', [new Date('||SUBSTR(l_end_time,1,4)||','||(TO_NUMBER(SUBSTR(l_end_time,6,2)) - 1)||','||SUBSTR(l_end_time,9,2)||','||SUBSTR(l_end_time,12,2)||','||SUBSTR(l_end_time,15,2)||',0)';
      IF '&&tit_01.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_01; 
      END IF;
      IF '&&tit_02.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_02; 
      END IF;
      IF '&&tit_03.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_03; 
      END IF;
      IF '&&tit_04.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_04; 
      END IF;
      IF '&&tit_05.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_05; 
      END IF;
      IF '&&tit_06.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_06; 
      END IF;
      IF '&&tit_07.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_07; 
      END IF;
      IF '&&tit_08.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_08; 
      END IF;
      IF '&&tit_09.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_09; 
      END IF;
      IF '&&tit_10.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_10; 
      END IF;
      IF '&&tit_11.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_11; 
      END IF;
      IF '&&tit_12.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_12; 
      END IF;
      IF '&&tit_13.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_13; 
      END IF;
      IF '&&tit_14.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_14; 
      END IF;
      IF '&&tit_15.' IS NOT NULL THEN
        l_line := l_line||', '||l_col_15; 
      END IF;
      l_line := l_line||']';
      DBMS_OUTPUT.PUT_LINE(l_line);
    END LOOP;
    CLOSE cur;
  END IF;
END;
/
SET SERVEROUT OFF;
SPO OFF

-- If one_spool_line_chart_file is defined and is readable, paste it contents on HTML.
HOS if [ '&&one_spool_line_chart_file.' != '' ]; then if [ -f &&one_spool_line_chart_file. ]; then cat &&one_spool_line_chart_file. >> &&one_spool_filename._line_chart.html; fi; fi

-- get sql_id
SELECT prev_sql_id moat369_prev_sql_id, TO_CHAR(prev_child_number) moat369_prev_child_number FROM v$session WHERE sid = SYS_CONTEXT('USERENV', 'SID')
/

SPO &&one_spool_filename._line_chart.html APP;
-- chart footer
PRO        ]);;
PRO        
PRO        var options = {&&stacked.
PRO          backgroundColor: {fill: '#fcfcf0', stroke: '#336699', strokeWidth: 1},
PRO          explorer: {actions: ['dragToZoom', 'rightClickToReset'], maxZoomIn: 0.1},
PRO          title: '&&title.&&title_suffix.',
PRO          titleTextStyle: {fontSize: 16, bold: false},
PRO          focusTarget: 'category',
PRO          legend: {position: 'right', textStyle: {fontSize: 12}},
PRO          tooltip: {textStyle: {fontSize: 10}},
PRO          hAxis: {title: '&&haxis.', gridlines: {count: -1}},
PRO          vAxis: {title: '&&vaxis.', &&vbaseline. gridlines: {count: -1}}
PRO        };
PRO
PRO        var chart = new google.visualization.&&chartype.(document.getElementById('chart_div'));
PRO        chart.draw(data, options);
PRO      }
PRO    </script>
PRO
PRO    <div id="chart_div" class="google-chart"></div>
PRO

-- footer
PRO<font class="n">Notes:<br>1) drag to zoom, and right click to reset<br>2) up to &&history_days. days of awr history were considered</font>
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
       '&&row_num., &&section_id., &&main_table., &&moat369_prev_sql_id., &&moat369_prev_child_number., &&title_no_spaces., line , &&one_spool_filename._line_chart.html'
  FROM DUAL
/
SPO OFF;
SET HEA ON;

@@&&fc_encrypt_html. &&one_spool_filename._line_chart.html

-- zip
HOS zip -m &&moat369_zip_filename. &&one_spool_filename._line_chart.html >> &&moat369_log3.

undef one_spool_line_chart_file