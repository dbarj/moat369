-- This code will check if file has a <pre> tag, representing an ORA- occurred and put row_num = "-1" if it does.
DEF in_param = "&1."
UNDEF 1

DEF step_file = 'step_file.sql';
HOS if [ -f &&in_param. ]; then touch &&step_file.; &&cmd_grep. "<pre>" &&in_param. > /dev/null &&""echo "DEF row_num = '-1'" > &&step_file.; fi
@&&step_file.
HOS rm -f &&step_file.
UNDEF step_file

UNDEF in_param