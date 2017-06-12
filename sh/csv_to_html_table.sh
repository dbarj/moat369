#!/bin/sh
# ----------------------------------------------------------------------------
# Written by Rodrigo Jorge <http://www.dbarj.com.br/>
# Last updated on: Dec/2016 by Rodrigo Jorge
# ----------------------------------------------------------------------------
if [ $# -ne 2 ]
then
  echo "Two arguments are needed..."
  exit 1
fi

v_sep=$1
v_sourcecsv=$2

test -f $v_sourcecsv || exit 1

echo "<p>"
echo "<table class=sortable>"

v_fcol_tag_o='<th scope="col">'
v_fcol_tag_c="</th>"
v_acol_tag_o="<td>"
v_acol_tag_c="</td>"
f_line_o="<tr>"
f_line_c="</tr>"

SOTYPE=$(uname -s)
if [ "$SOTYPE" = "SunOS" ]
then
  AWKCMD=/usr/xpg4/bin/awk
  SEDCMD=/usr/xpg4/bin/sed
  # echo -e "xxx" in solaris prints "-e xxx" when using /bin/sh.
  ECHO_E="echo"
else
  AWKCMD=awk
  SEDCMD=sed
  ECHO_E="echo -e"
fi

v_firstline=true

v_head_ncols=$(head -n 1 $v_sourcecsv | $AWKCMD '{n=split($0, array, "'$v_sep'")} END{print n }')

v_count=0

while read line || [ -n "$line" ]
do
  v_ncols=$(echo $line | $AWKCMD '{n=split($0, array, "'$v_sep'")} END{print n }')
  if [ $v_head_ncols -ne $v_ncols ]
  then
    echo ERROR
    break
  fi
  $ECHO_E $f_line_o\\c
  if $v_firstline
  then
    #for ((i=1;i<=v_ncols;i++)); do
    #  v_col=$(echo $line | $AWKCMD '{split($0,a,"'$v_sep'"); print a['$i']}')
    #  $ECHO_E ${v_fcol_tag_o}${v_col}${v_fcol_tag_c}\\c
    #done
    v_linerep=$(echo $line | $SEDCMD "s|$v_sep|${v_fcol_tag_c}${v_fcol_tag_o}|g")
    $ECHO_E ${v_fcol_tag_o}#${v_fcol_tag_c}${v_fcol_tag_o}${v_linerep}${v_fcol_tag_c}\\c
    v_firstline=false
  else
    #for ((i=1;i<=v_ncols;i++)); do
    #  v_col=$(echo $line | $AWKCMD '{split($0,a,"'$v_sep'"); print a['$i']}')
    #  $ECHO_E ${v_acol_tag_o}${v_col}${v_acol_tag_c}\\c
    #done
    v_linerep=$(echo $line | $SEDCMD "s|$v_sep|${v_acol_tag_c}${v_acol_tag_o}|g")
    $ECHO_E ${v_acol_tag_o}${v_count}${v_acol_tag_c}${v_acol_tag_o}${v_linerep}${v_acol_tag_c}\\c
  fi
  echo $f_line_c
  v_count=$((v_count+1))
done < ${v_sourcecsv}

echo "</table>"
echo "<p>"

exit 0
####