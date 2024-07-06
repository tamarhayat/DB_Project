CREATE OR REPLACE PROCEDURE get_equipment_and_suppliers(
    p_eid_list IN SYS.ODCINUMBERLIST
) IS
    -- Cursor to fetch equipment details
    CURSOR c_equipment_details IS
        SELECT e.eID, e.ename, e.isMobile, e.quantity, e.price, e.required_in_vehicle
        FROM Equipment e
        WHERE e.eID IN (SELECT COLUMN_VALUE FROM TABLE(p_eid_list));
        
    -- Record type for the equipment details cursor
    rec_equipment c_equipment_details%ROWTYPE;

    -- Custom exception for empty list
    empty_list EXCEPTION;

BEGIN
    -- Check if the list is empty
    IF p_eid_list IS NULL OR p_eid_list.COUNT = 0 THEN
        RAISE empty_list;
    END IF;
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    -- Print equipment details header
    DBMS_OUTPUT.PUT_LINE('Equipment Details:');
    DBMS_OUTPUT.PUT_LINE('eID   | Name             | Quantity | Price    | Required in Vehicle');
    DBMS_OUTPUT.PUT_LINE('------|------------------|----------|----------|-------------------');
    
    OPEN c_equipment_details;
    LOOP
        FETCH c_equipment_details INTO rec_equipment;
        EXIT WHEN c_equipment_details%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(LPAD(rec_equipment.eID, 5) || ' | ' ||
                             RPAD(rec_equipment.ename, 16) || ' | ' ||
                             LPAD(rec_equipment.quantity, 8) || ' | ' ||
                             LPAD(TO_CHAR(rec_equipment.price, '999.99'), 8) || ' | ' ||
                             LPAD(rec_equipment.required_in_vehicle, 19));
    END LOOP;
    CLOSE c_equipment_details;
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE(CHR(10));
    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Suppliers Details:');
    DBMS_OUTPUT.PUT_LINE('Supplier ID  | Supplier Name       | Equipment ID | Name             ');
    DBMS_OUTPUT.PUT_LINE('-------------|---------------------|--------------|------------------');
    
    FOR rec IN (
        SELECT DISTINCT s.sID, s.sname
        FROM Suppliers s
        JOIN Orders o ON s.sID = o.sID
        JOIN equip_order eo ON o.oID = eo.oID
        WHERE eo.eID IN (SELECT COLUMN_VALUE FROM TABLE(p_eid_list))
    ) LOOP
        -- Print supplier details header
 DBMS_OUTPUT.PUT_LINE(LPAD(TRIM(rec.sID), 12) || ' | ' 
 || RPAD(REPLACE(TRIM(rec.sname), CHR(10), ''), 21));

    FOR eq_rec IN (
        SELECT e.eID, e.ename
        FROM Equipment e
        JOIN equip_order eo ON e.eID = eo.eID
        JOIN Orders o ON eo.oID = o.oID
        WHERE o.sID = rec.sID AND e.eID IN (SELECT COLUMN_VALUE FROM TABLE(p_eid_list))
    ) LOOP
      DBMS_OUTPUT.PUT_LINE('             |                     | ' ||
                           LPAD(TRIM(eq_rec.eID), 12) || ' | ' ||
                           RPAD(REPLACE(TRIM(eq_rec.ename), CHR(10), ''), 16));
        END LOOP;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(CHR(10));
EXCEPTION
    WHEN empty_list THEN
        DBMS_OUTPUT.PUT_LINE('the list is empty.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/
