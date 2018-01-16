-- This code will generate a temporary file name to be used by the code.
-- Param 1 = Variable name
-- Param 2 = Optionally file name prefix

def c_param1 = '&&1.'
undef 1

@@&&fc_def_empty_var. 2
def c_param2 = '&&2.'
undef 2

EXEC :temp_seq := :temp_seq + 1;

col c1 new_v &&c_param1. NOPRI
SELECT '&&moat369_sw_output_fdr./step_file_' || LPAD(:temp_seq, 5, '0') || DECODE('&&c_param2',NULL,'','_&&c_param2.') || '.sql' c1 from dual;
col c1 clear

undef c_param1 c_param2