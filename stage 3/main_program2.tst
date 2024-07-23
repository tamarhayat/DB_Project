PL/SQL Developer Test script 3.0
10

DECLARE
    result INTEGER; -- Declare the result variable

BEGIN
    -- Call the function and store the result
    :result := update_according_order(p_order_id => :p_order_id);
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    update_premium_status;
END;
2
result
1
﻿true
5
p_order_id
1
﻿40192
5
0
