------generate eid for tool-------------------------------------------------------
DECLARE
    seq_number NUMBER := 10404;
BEGIN
    FOR rec IN (SELECT ROWID, eid FROM Tool) LOOP
        UPDATE Tool
        SET eid = seq_number
        WHERE ROWID = rec.ROWID;
        seq_number := seq_number + 1;
    END LOOP;
    COMMIT;
END;

----generate quantity for tool-----------------------------------------------------

BEGIN
    FOR rec IN (SELECT ROWID FROM Tool) LOOP
        UPDATE Tool
        SET quantity = TRUNC(DBMS_RANDOM.VALUE(10, 200))
        WHERE ROWID = rec.ROWID;
    END LOOP;
    COMMIT;
END;

---generate price for tool---------------------------------------------------------
BEGIN
    FOR rec IN (SELECT ROWID FROM Tool) LOOP
        UPDATE Tool
        SET price = DBMS_RANDOM.VALUE(10.5, 120.25)
        WHERE ROWID = rec.ROWID;
    END LOOP;
    COMMIT;
END;

---generate made-in for equipment-------------------------------------------

DECLARE
    TYPE StringArray IS TABLE OF VARCHAR2(100);
    arr StringArray := StringArray('China', 'USA', 'Germany', 'India', 'France',
     'Spain','Canada', 'Japan', 'Mexico', 'Italy');
    random_index INTEGER;
BEGIN
    FOR rec IN (SELECT ROWID FROM Equipment) LOOP
        random_index := TRUNC(DBMS_RANDOM.VALUE(1, arr.COUNT + 1));
        UPDATE Equipment
        SET made_in = arr(random_index)
        WHERE ROWID = rec.ROWID;
    END LOOP;
    COMMIT;
END;

----generate color for Equipment----------------------------------------------

DECLARE
    TYPE StringArray IS TABLE OF VARCHAR2(100);
    arr StringArray := StringArray('White','Silver','Pink');
    random_index INTEGER;
BEGIN
    FOR rec IN (SELECT ROWID FROM Equipment) LOOP
        random_index := TRUNC(DBMS_RANDOM.VALUE(1, arr.COUNT + 1));
        UPDATE Equipment
        SET color = arr(random_index)
        WHERE ROWID = rec.ROWID;
    END LOOP;
    COMMIT;
END;

----generate weight for equipment----------------------------------------------------
BEGIN
    FOR rec IN (SELECT ROWID FROM Equipment) LOOP
        UPDATE Equipment
        SET weight = DBMS_RANDOM.VALUE(0.1,1)
        WHERE ROWID = rec.ROWID;
    END LOOP;
    COMMIT;
END;

-----generate catagory name for equipment----------------------------
BEGIN
    FOR rec IN (SELECT eid FROM Equipment) LOOP
        UPDATE Equipment
        SET category_name = (
            SELECT category_name
            FROM (
                SELECT category_name
                FROM TCATEGORY
                ORDER BY DBMS_RANDOM.VALUE
            )
            WHERE ROWNUM = 1
        )
        WHERE eid = rec.eid;
    END LOOP;
END;

commit;

----marge the 2 tables to equipment------------------

INSERT INTO Equipment (eid, ename, ismobile, quantity, price,
     required_in_vehicle, weight, made_in,
     color, category_name)
    SELECT eid, ename, ismobile, quantity, price,
    required_in_vehicle, weight, made_in,
      color, category_name
    FROM Tool



