PL/SQL Developer Test script 3.0
12
SET SERVEROUTPUT ON;

DECLARE
  result VARCHAR2(10); -- הכרזת המשתנה result
BEGIN
  result := update_according_order(p_order_id => :p_order_id);
  DBMS_OUTPUT.PUT_LINE('Update according order result: ' || result);

  IF result = 'true' THEN
    update_premium_status;
  END IF;
END;
2
result
0
-5
p_order_id
1
ן»¿40192
5
0
