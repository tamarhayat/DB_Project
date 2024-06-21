CREATE OR REPLACE FUNCTION update_vehicle_equipment(p_eID IN NUMBER, p_amount IN NUMBER, p_vID IN NUMBER)
RETURN NUMBER IS
    v_current_quantity Equipment.quantity%TYPE;
    v_current_vehicle_quantity vehicle_equip.equipAmount%TYPE;
    v_new_vehicle_quantity vehicle_equip.equipAmount%TYPE;

    -- Custom exceptions
    insufficient_quantity EXCEPTION;
    equipment_not_found EXCEPTION;

    -- Explicit cursor
    CURSOR c_vehicle_equip IS
        SELECT equipAmount 
        FROM vehicle_equip 
        WHERE eID = p_eID AND vID = p_vID;

    -- Cursor record
    rec_vehicle_equip c_vehicle_equip%ROWTYPE;
BEGIN
    -- Check the quantity in stock
    SELECT quantity INTO v_current_quantity FROM Equipment WHERE eID = p_eID;
    IF v_current_quantity < p_amount THEN
        RAISE insufficient_quantity;
    END IF;

    -- Open the cursor and fetch the current equipment amount for the vehicle
    OPEN c_vehicle_equip;
    FETCH c_vehicle_equip INTO rec_vehicle_equip;
    
    -- Check if no data was found
    IF c_vehicle_equip%NOTFOUND THEN
        RAISE equipment_not_found;
    END IF;

    -- Print the current quantity
    v_current_vehicle_quantity := rec_vehicle_equip.equipAmount;
    DBMS_OUTPUT.PUT_LINE('Current vehicle equipment amount: ' || v_current_vehicle_quantity);

    -- Update the vehicle's equipment amount
    v_new_vehicle_quantity := v_current_vehicle_quantity + p_amount;
    UPDATE vehicle_equip SET equipAmount = v_new_vehicle_quantity WHERE eID = p_eID AND vID = p_vID;

    -- Update the equipment stock
    UPDATE Equipment SET quantity = v_current_quantity - p_amount WHERE eID = p_eID;

    -- Print the new quantity
    DBMS_OUTPUT.PUT_LINE('New vehicle equipment amount: ' || v_new_vehicle_quantity);

    CLOSE c_vehicle_equip;

    RETURN p_vID;

EXCEPTION
    WHEN insufficient_quantity THEN
        DBMS_OUTPUT.PUT_LINE('Error: Insufficient quantity in stock.');
        RETURN NULL;
    WHEN equipment_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Error: Equipment not found in the specified vehicle.');
        RETURN NULL;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
        RETURN NULL;
END;
/
