-- This code will check for all sections configured for a given column (parameter 1) and load them.
DEF in_cur_col_id = '&1.'
UNDEF 1

DEF moat369_sections_file  = '&&moat369_sw_folder./00_sections.csv'

DEF moat369_col_temp_file = 'moat369_temp_onload_section_&&in_cur_col_id..sql'
HOS &&cmd_grep. -e "^&&in_cur_col_id." &&moat369_sections_file. | while read line || [ -n "$line" ]; do echo $line | &&cmd_awk. -F',' '{printf("@"$4"&&""&&moat369_sw_name._"$1".&&""fc_call_secion. "$1" &&moat369_sw_name._"$1"_"$2" "$3"\n")}'; done > &&moat369_col_temp_file.
@&&moat369_col_temp_file.
@@&&fc_zip_driver_files. &&moat369_col_temp_file.
UNDEF moat369_col_temp_file

UNDEF in_cur_col_id moat369_sections_file