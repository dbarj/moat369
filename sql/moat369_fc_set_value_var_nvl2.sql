-- 4 parameters are given, works similar to NVL2 function: param1 = NVL2(param2,param3,param4)
-- NVL2 lets you determine the value returned by a query based on whether a specified expression is null or not null.
-- If param2 is not null, then NVL2 returns param3. If param2 is null, then NVL2 returns param4.

def c_param1 = '&&1.'
def c_param2 = '&&2.'
def c_param3 = '&&3.'
def c_param4 = '&&4.'
undef 1 2 3 4

col c1 new_v &&c_param1. NOPRI
select q'[&&c_param3.]' "c1" from dual where q'[&&c_param2.]' is not null;
select q'[&&c_param4.]' "c1" from dual where q'[&&c_param2.]' is null;
col c1 clear

undef c_param1 c_param2 c_param3 c_param4