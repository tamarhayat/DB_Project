CREATE OR REPLACE FUNCTION update_vehicle_equip
(p_vID IN vehicles.vid%TYPE) 
RETURN SYS.ODCINUMBERLIST
IS
    -- Cursor to select equipment related to the given vehicle
    CURSOR c_vehicle_equip IS
        SELECT e.eID, e.ename, e.required_in_vehicle, ve.equipAmount, e.quantity
        FROM vehicle_equip ve
        JOIN Equipment e ON ve.eID = e.eID
        WHERE ve.vID = p_vID
        FOR UPDATE OF ve.equipAmount, e.quantity;

    rec_vehicle_equip c_vehicle_equip%ROWTYPE;

    v_diff INT;

    zero_stock_list SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST();
    
    -- Declare custom exception
    no_equipment_found EXCEPTION;
    
BEGIN
    OPEN c_vehicle_equip;
    
    FETCH c_vehicle_equip INTO rec_vehicle_equip;
    IF c_vehicle_equip%NOTFOUND THEN
        CLOSE c_vehicle_equip;
        RAISE no_equipment_found;
    END IF;

    LOOP
        -- We have already fetched the first record, no need to fetch again here
        v_diff := rec_vehicle_equip.required_in_vehicle - rec_vehicle_equip.equipAmount;
        
        IF v_diff > 0 THEN
            -- If there is a deficit in the vehicle, try to add from stock
            IF rec_vehicle_equip.quantity >= v_diff THEN
                -- Update vehicle's equipment amount
                UPDATE vehicle_equip
                SET equipAmount = rec_vehicle_equip.required_in_vehicle
                WHERE vID = p_vID AND eID = rec_vehicle_equip.eID;
                
                -- Update stock quantity
                UPDATE Equipment
                SET quantity = quantity - v_diff
                WHERE eID = rec_vehicle_equip.eID;
                
                DBMS_OUTPUT.PUT_LINE('Added ' || v_diff || ' units of equipment ID ' 
                || rec_vehicle_equip.eID || ' to vehicle ID ' || p_vID);
            ELSE
                -- Add what is available and set stock to zero
                UPDATE vehicle_equip
                SET equipAmount = rec_vehicle_equip.equipAmount + rec_vehicle_equip.quantity
                WHERE vID = p_vID AND eID = rec_vehicle_equip.eID;

                -- Update stock quantity to zero
                UPDATE Equipment
                SET quantity = 0
                WHERE eID = rec_vehicle_equip.eID;

                DBMS_OUTPUT.PUT_LINE('Partially added ' 
                || rec_vehicle_equip.quantity || ' units of equipment ID ' 
                || rec_vehicle_equip.eID || ' to vehicle ID ' || p_vID 
                || '. Not enough stock to fully fulfill the desired quantity.');
                
                -- Add to zero stock list
                zero_stock_list.EXTEND;
                zero_stock_list(zero_stock_list.LAST) := rec_vehicle_equip.eID;
            END IF;

        ELSIF v_diff < 0 THEN
            -- If there is an excess in the vehicle, return to stock
            UPDATE vehicle_equip
            SET equipAmount = rec_vehicle_equip.required_in_vehicle
            WHERE vID = p_vID AND eID = rec_vehicle_equip.eID;
            
            -- Update stock quantity
            UPDATE Equipment
            SET quantity = quantity - v_diff
            WHERE eID = rec_vehicle_equip.eID;

            DBMS_OUTPUT.PUT_LINE('Removed ' || ABS(v_diff) 
            || ' units of equipment ID ' || rec_vehicle_equip.eID 
            || ' from vehicle ID ' || p_vID);
        END IF;
        
        FETCH c_vehicle_equip INTO rec_vehicle_equip;
        EXIT WHEN c_vehicle_equip%NOTFOUND;
    END LOOP;

    CLOSE c_vehicle_equip;

    RETURN zero_stock_list;
EXCEPTION
    WHEN no_equipment_found THEN
        DBMS_OUTPUT.PUT_LINE('No equipment found for vehicle ID ' || p_vID);
        RETURN zero_stock_list;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
        RETURN NULL;
END;
/
