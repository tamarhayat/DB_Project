CREATE OR REPLACE FUNCTION update_according_order(p_order_id IN orders.oid%type) RETURN VARCHAR2 IS
    -- Cursor to select all equipment from the given order
    CURSOR equip_order_cursor IS
        SELECT eo.eID, e.ename, e.quantity, eo.amountInOrder
        FROM equip_order eo
        JOIN Equipment e ON eo.eID = e.eID
        WHERE eo.oID = p_order_id;
    
           
    v_eid Equipment.eID%TYPE;
    v_ename Equipment.ename%TYPE;
    v_oldquantity Equipment.quantity%TYPE;
    v_quantity Equipment.quantity%TYPE;
    v_amount_order equip_order.amountInOrder%TYPE;
    v_message VARCHAR2(5);
    no_order_found EXCEPTION;

BEGIN
    OPEN equip_order_cursor;
    FETCH equip_order_cursor INTO v_eid, v_ename, v_oldquantity, v_amount_order;

    IF equip_order_cursor%NOTFOUND THEN
        RAISE no_order_found;
    END IF;
    LOOP
                -- Update the equipment quantity
        UPDATE Equipment
        SET quantity = quantity + v_amount_order
        WHERE eID = v_eid;

        -- Select the updated quantity
        SELECT quantity INTO v_quantity
        FROM Equipment
        WHERE eID = v_eid;

        -- Print the updated stock status
        DBMS_OUTPUT.PUT_LINE(v_eid || '     ' || 'quantity before: ' 
        ||v_oldquantity || '     ' || 'quantity after: ' 
        || v_quantity || '     ' || v_ename);

        -- Check if the old quantity was 0 and print message
        IF v_oldquantity = 0 THEN
            DBMS_OUTPUT.PUT_LINE(v_ename || ' is back in stock.');
        END IF;
        FETCH equip_order_cursor INTO v_eid, v_ename, v_oldquantity, v_amount_order;
        EXIT WHEN equip_order_cursor%NOTFOUND;
    END LOOP;
    
    CLOSE equip_order_cursor;
    v_message := 'true';
    RETURN v_message;

EXCEPTION
    WHEN no_order_found THEN
         v_message := 'false';
         DBMS_OUTPUT.PUT_LINE('Order No.  '||p_order_id || ' does not exist.');
         RETURN v_message;
         CLOSE equip_order_cursor;
    WHEN OTHERS THEN
        v_message := 'false';
        RETURN v_message;
        CLOSE equip_order_cursor;
END;
/
