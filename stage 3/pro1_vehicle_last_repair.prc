CREATE OR REPLACE PROCEDURE vehicle_last_repair(v_vehicle_id IN NUMBER) IS
    CURSOR c_repair_details IS
        SELECT r.rID, r.repairDate, r.description
        FROM Repairs r
        JOIN VehiclesRepairs vr ON r.rID = vr.rID
        WHERE vr.vID = v_vehicle_id
        ORDER BY r.repairDate DESC;
    
    v_repair_id       Repairs.rID%TYPE;
    v_repair_date     Repairs.repairDate%TYPE;
    v_description     Repairs.description%TYPE;
    v_repair_count    NUMBER := 0;
BEGIN
    -- Open the cursor
    OPEN c_repair_details;
    
    -- Fetch the first row to get the last repair details
    FETCH c_repair_details INTO v_repair_id, v_repair_date, v_description;
    
    -- Check if any repairs exist for the vehicle
    IF c_repair_details%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Last Repair ID: ' || v_repair_id);
        DBMS_OUTPUT.PUT_LINE('Last Repair Date: ' || TO_CHAR(v_repair_date, 'DD-MM-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Description: ' || v_description);
    ELSE
        DBMS_OUTPUT.PUT_LINE('The vehicle has not undergone any repairs.');
    END IF;
    
    -- Count the total number of repairs using the cursor
    LOOP
        EXIT WHEN c_repair_details%NOTFOUND;
        v_repair_count := v_repair_count + 1;
        FETCH c_repair_details INTO v_repair_id, v_repair_date, v_description;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Total number of repairs: ' || v_repair_count);
    
    -- Close the cursor
    CLOSE c_repair_details;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        IF c_repair_details%ISOPEN THEN
            CLOSE c_repair_details;
        END IF;
END;
/
