-- add seq to one_spool_filename
DEF one_spool_filename = '&&spool_filename.'
@@&&fc_seq_output_file. one_spool_filename
@@&&fc_def_output_file. one_spool_fullpath_filename '&&one_spool_filename._map_chart.html'

@@moat369_0j_html_topic_intro.sql &&one_spool_filename._map_chart.html map

SPO &&one_spool_fullpath_filename. APP
PRO <script type="text/javascript" src="https://www.google.com/jsapi"></script>

-- chart header
PRO    <script type="text/javascript" id="gchart_script">
PRO      google.load('visualization', '1', { 'packages': ['map'] });
PRO      google.setOnLoadCallback(drawChart);
PRO      function drawChart() {
PRO        var data = google.visualization.arrayToDataTable([

-- Count lines returned by PL/SQL
VAR row_count NUMBER;
EXEC :row_count := -1;

-- body
SET SERVEROUT ON;
SET SERVEROUT ON SIZE 1000000;
SET SERVEROUT ON SIZE UNL;
DECLARE
  cur SYS_REFCURSOR;
  l_name VARCHAR2(1000);
  l_lat VARCHAR2(1000);
  l_long VARCHAR2(1000);
  l_sql_text VARCHAR2(32767);
BEGIN
  DBMS_OUTPUT.PUT_LINE('[''Latitude'', ''Longitude'', ''Name'']');
  --OPEN cur FOR :sql_text;
  l_sql_text := DBMS_LOB.SUBSTR(:sql_text); -- needed for 10g
  OPEN cur FOR l_sql_text; -- needed for 10g
  LOOP
    FETCH cur INTO l_name, l_lat, l_long;
    EXIT WHEN cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(',['||l_lat||', '||l_long||', '''||l_name||''']');
  END LOOP;
  :row_count := cur%ROWCOUNT;
  CLOSE cur;
END;
/
SET SERVEROUT OFF;

-- get sql_id
SELECT prev_sql_id moat369_prev_sql_id, TO_CHAR(prev_child_number) moat369_prev_child_number FROM v$session WHERE sid = SYS_CONTEXT('USERENV', 'SID');

-- Set row_num to row_count;
COL row_num NOPRI
select TRIM(:row_count) row_num from dual;
COL row_num PRI

-- map chart footer
PRO        ]);;
PRO        var geoView = new google.visualization.DataView(data);;
PRO        
PRO        var options = {
PRO              showTooltip: true,
PRO              showInfoWindow: true,
PRO              useMapTypeControl: true
PRO            };;
PRO        
PRO        var map = new google.visualization.Map(document.getElementById('chart_div'));;
PRO        map.draw(geoView, options);;
PRO
PRO      }
PRO    </script>
PRO
PRO    <div id="chart_div" class="google-chart"></div>


-- footer
PRO <br />
PRO <font class="n">Notes:<br>1) Locations are approximated<br></font>
PRO <font class="n">2) &&foot.</font>
PRO
SPO OFF

@@moat369_0k_html_topic_end.sql &&one_spool_filename._map_chart.html map '' &&sql_show.

@@&&fc_encode_html. &&one_spool_fullpath_filename.

HOS zip -mj &&moat369_zip_filename. &&one_spool_fullpath_filename. >> &&moat369_log3.

UNDEF one_spool_fullpath_filename