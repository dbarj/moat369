-- Ask for License if not passed as parameter on the main code
SET TERM ON
ACCEPT license_pack_param char format a1 default '?' PROMPT "Oracle Pack License? (Tuning, Diagnostics or None) [ T | D | N ] (required): "