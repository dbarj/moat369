-- Works as DECODE function: param1 = DECODE(param2,param3,param4,param5)
-- Define variable in 1st parameter as 4th parameter if param2=param3. Else set as param5.
def c_param1 = '&&1.'
def c_param2 = '&&2.'
def c_param3 = '&&3.'
def c_param4 = '&&4.'
def c_param5 = '&&5.'
undef 1 2 3 4 5

col c1 new_v &&c_param1. NOPRI
select DECODE('&&c_param2.','&&c_param3.','&&c_param4.','&&c_param5.') "c1" from dual;
col c1 clear

undef c_param1 c_param2 c_param3 c_param4 c_param5