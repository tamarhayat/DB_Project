CREATE OR REPLACE PROCEDURE update_premium_status IS
     
       v_changes NUMBER := 0;
       v_premium NUMBER := 0;

    -- cursor declare
    CURSOR donors_cursor IS
        SELECT dID, premium
        FROM Donors;

    donor_rec donors_cursor%ROWTYPE;
BEGIN

    OPEN donors_cursor;

    LOOP
        FETCH donors_cursor INTO donor_rec;
        EXIT WHEN donors_cursor%NOTFOUND;

        -- check if the donor donate unless one vhicale who wasen't under repair 
            v_premium :=0;    
    
            SELECT COUNT(*)
            INTO v_premium
            FROM Vehicles v
            WHERE v.dID = donor_rec.dID
              AND NOT EXISTS (
                  SELECT 1
                  FROM VehiclesRepairs vr
                  WHERE vr.vID = v.vID
              );

            --check the current status and updat if necessary
            IF v_premium > 0 AND donor_rec.premium != 'true' THEN
                UPDATE Donors
                SET premium = 'true'
                WHERE dID = donor_rec.dID;
                v_changes := v_changes + 1;
            ELSIF v_premium = 0 AND donor_rec.premium != 'false' THEN
                UPDATE Donors
                SET premium = 'false'
                WHERE dID = donor_rec.dID;
                v_changes := v_changes + 1;
            END IF;
      
    END LOOP;

--close the cursor
    CLOSE donors_cursor;

-- printing the number of changes that have done
    DBMS_OUTPUT.PUT_LINE('Number of changes made: ' || v_changes);
END;
/
