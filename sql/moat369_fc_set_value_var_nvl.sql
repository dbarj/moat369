-- If 3 parameters are given, works as NVL function: param1 = NVL(param2,param3)
-- Define variable in 1st parameter as 3rd parameter if 2nd parameter is NULL. Else keep untouched.
-- If 4 parameters are given, works similar to NVL2 function: param1 = NVL2(param2,param4,param3)
-- Define variable in 1st parameter as 3rd parameter if 2nd parameter is NULL or 4th parameter if 2nd parameter is NOT NULL.
def c_param1 = '&&1.'
def c_param2 = '&&2.'
def c_param3 = '&&3.'
undef 1 2 3

@@&&fc_def_empty_var. 4
def c_param4 = '&&4.'
undef 4

col c1 new_v &&c_param1. NOPRI
select '&&c_param3.' "c1" from dual where '&&c_param2.' is null;
select '&&c_param4.' "c1" from dual where '&&c_param2.' is not null and '&&c_param4.' is not null;
col c1 clear

undef c_param1 c_param2 c_param3 c_param4