drop table EquipRepairs;
drop table vehiclesrepairs;
drop table Repairs;
drop table vehicle_equip;
drop table Vehicles;
drop table equip_order;
drop table Equipment;
drop table Orders;
drop table Suppliers;
drop table Donors;


BEGIN
    -- Loop through all tables and drop them
   FOR table_name IN (SELECT table_name FROM user_tables) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || table_name.table_name || ' CASCADE CONSTRAINTS PURGE';
    END LOOP;
END;
/
