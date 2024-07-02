CREATE OR REPLACE PROCEDURE update_vehicle_equip(p_vID IN vehicles.vid%type) IS
    CURSOR c_vehicle_equip IS
        SELECT e.eID, e.required_in_vehicle, ve.equipAmount, e.quantity
        FROM vehicle_equip ve
        JOIN Equipment e ON ve.eID = e.eID
        WHERE ve.vID = p_vID;
        
    rec_vehicle_equip c_vehicle_equip%ROWTYPE;

    v_diff INT;
   -- v_new_vehicle_amount INT;
    --v_new_stock_quantity INT;
    
BEGIN
    OPEN c_vehicle_equip;
    
    LOOP
        FETCH c_vehicle_equip INTO rec_vehicle_equip;
        EXIT WHEN c_vehicle_equip%NOTFOUND;

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
                
                DBMS_OUTPUT.PUT_LINE('Added ' || v_diff || ' units of equipment ID ' || rec_vehicle_equip.eID || ' to vehicle ID ' || p_vID);
            ELSE
                -- Add what is available and set stock to zero
                UPDATE vehicle_equip
                SET equipAmount = rec_vehicle_equip.equipAmount + rec_vehicle_equip.quantity
                WHERE vID = p_vID AND eID = rec_vehicle_equip.eID;

                -- Update stock quantity to zero
                UPDATE Equipment
                SET quantity = 0
                WHERE eID = rec_vehicle_equip.eID;
                
                DBMS_OUTPUT.PUT_LINE('Partially added ' || rec_vehicle_equip.quantity || ' units of equipment ID ' || rec_vehicle_equip.eID || ' to vehicle ID ' || p_vID || '. Not enough stock to fully fulfill the desired quantity.');
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

            DBMS_OUTPUT.PUT_LINE('Removed ' || ABS(v_diff) || ' units of equipment ID ' || rec_vehicle_equip.eID || ' from vehicle ID ' || p_vID);
        END IF;
    END LOOP;

    CLOSE c_vehicle_equip;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/
