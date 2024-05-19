drop table Donors;
drop table Suppliers;
drop table vehiclesrepairs;
drop table Equipment;
drop table
drop table
drop table
drop table
drop table
drop table
drop table
drop table
drop table


BEGIN
    -- Loop through all tables and drop them
    FOR table_name IN (SELECT table_name FROM user_tables) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || table_name.table_name || ' CASCADE CONSTRAINTS PURGE';
    END LOOP;
END;
/
