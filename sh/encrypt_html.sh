#!/bin/sh
# ----------------------------------------------------------------------------
# Written by Rodrigo Jorge <http://www.dbarj.com.br/>
# Last updated on: Feb/2017 by Rodrigo Jorge
# ----------------------------------------------------------------------------
set -e # Exit if error

if [ $# -ne 3 ]
then
  echo "Three arguments are needed..."
  exit 1
fi

in_file=$1
enc_file=$2
x_file=$3
out_file=$1.tmp

SOTYPE=$(uname -s)
if [ "$SOTYPE" = "SunOS" ]
then
  AWKCMD=/usr/xpg4/bin/awk
  SEDCMD=/usr/xpg4/bin/sed
else
  AWKCMD=awk
  SEDCMD=sed
fi

test -f $in_file || exit 1
test -f $enc_file || exit 1
test -f $x_file || exit 1

in_start_line=`$SEDCMD -ne /\<!--BEGIN_SENSITIVE_DATA--\>/= $in_file`
in_stop_line=`$SEDCMD -ne /\<!--END_SENSITIVE_DATA--\>/= $in_file`
in_last_line=`cat $in_file | wc -l`
enc_hash_line=`$SEDCMD -ne /encoded_data/= $enc_file`
enc_last_line=`cat $enc_file | wc -l`

test -n "${in_start_line}" || exit 1
test -n "${in_stop_line}" || exit 1
test -n "${in_last_line}" || exit 1
test -n "${enc_hash_line}" || exit 1
test -n "${enc_last_line}" || exit 1
which openssl > /dev/null 2>&- || exit 1

rm -f $out_file

$AWKCMD "NR >= 1 && NR < $in_start_line {print;}" $in_file >> $out_file
$AWKCMD "NR >= 1 && NR < $enc_hash_line {print;}" $enc_file >> $out_file
$AWKCMD "NR > $in_start_line && NR < $in_stop_line {print;}" $in_file | openssl enc -aes256 -a -salt -pass file:$x_file | $SEDCMD "s/^/'/" | $SEDCMD "s/$/'/" | $SEDCMD -e 's/$/,/' -e '$s/,$//' >> $out_file
$AWKCMD "NR > $enc_hash_line && NR <= $enc_last_line {print;}" $enc_file >> $out_file
$AWKCMD "NR > $in_stop_line && NR <= $in_last_line {print;}" $in_file >> $out_file
mv $out_file $in_file

exit 0
###