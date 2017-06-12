-- Works as NVL function
-- Define variable in 1st parameter as 3rd parameter if 2nd parameter is NULL. Else keep untouched.
def c_param1 = '&&1.'
def c_param2 = '&&2.'
def c_param3 = '&&3.'
undef 1 2 3

col c1 new_v &&c_param1. NOPRI
select '&&c_param3.' "c1" from dual where '&&c_param2.' is null;
col c1 clear

undef c_param1 c_param2 c_param3