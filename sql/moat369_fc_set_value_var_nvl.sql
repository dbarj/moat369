-- 3 parameters are given, works as NVL function: param1 = NVL(param2,param3)
-- Define variable in 1st parameter as 3rd parameter if 2nd parameter is NULL. Else return the 2nd.
def c_param1 = '&&1.'
def c_param2 = '&&2.'
def c_param3 = '&&3.'
undef 1 2 3

DEF &&c_param1. = "&&c_param2."
col c1 new_v &&c_param1. NOPRI
select q'[&&c_param3.]' "c1" from dual where q'[&&c_param2.]' is null;
col c1 clear

undef c_param1 c_param2 c_param3