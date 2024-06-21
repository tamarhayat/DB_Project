CREATE OR REPLACE FUNCTION update_according_order(p_order_id IN NUMBER) RETURN VARCHAR2 IS
    v_eid          Equipment.eID%TYPE;
    v_quantity     Equipment.quantity%TYPE;
    v_amount_order INT;
    v_message      VARCHAR2(1000);
    v_oldquantity  Equipment.quantity%TYPE;
    v_ename        Equipment.ename%TYPE;         
BEGIN
    -- Cursor to select all equipment from the given order
    FOR rec IN (
        SELECT eo.eID,e.ename, e.quantity, eo.amountInOrder
        FROM equip_order eo
        JOIN Equipment e ON eo.eID = e.eID
        WHERE eo.oID = p_order_id
    ) LOOP
        v_eid := rec.eID;
        v_quantity := rec.quantity;
        v_amount_order := rec.amountInOrder;
        v_ename := rec.ename;
        v_oldquantity := v_quantity;
        
        -- Update the equipment quantity
        UPDATE Equipment
        SET quantity = quantity + v_amount_order
        WHERE eID = v_eid;

        -- Select the updated quantity
        SELECT quantity INTO v_quantity
        FROM Equipment
        WHERE eID = v_eid;

        -- Print the updated stock status
        DBMS_OUTPUT.PUT_LINE(v_eid  ||'     ' || 'quantity before: ' ||v_oldquantity||'     ' ||'quantity after: '|| v_quantity||'     ' || v_ename);
    END LOOP;

    v_message := 'Inventory updated for order ID: ' || p_order_id;
    RETURN v_message;
EXCEPTION
    WHEN OTHERS THEN
        v_message := 'Error occurred: ' || SQLERRM;
        RETURN v_message;
END;
/
