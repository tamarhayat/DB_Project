
ALTER TABLE donors
ADD CONSTRAINT check_donor_phone
CHECK (phoneNumber LIKE '05_-_______');

ALTER TABLE equip_order
ADD CONSTRAINT check_amount_in_order
CHECK (amountInOrder > 0);

ALTER TABLE Equipment
ADD CONSTRAINT check_equipment_quantity
CHECK (quantity >= 0);

ALTER TABLE vehicle_equip
ADD CONSTRAINT check_equip_amount
CHECK (equipAmount >= 0);
commit;


--examples that show its work:
insert into DONORS (DID, DNAME, ADDRESS, PHONENUMBER)
values 
(222498461, 'Tori  Keaton', '27 Hong Kong, Lathrop, USA', '057-528143');

insert into EQUIP_ORDER (AMOUNTINORDER, EID, OID)
values (0, 10345, 40159);

insert into Equipment (eID, ename, isMobile, quantity, price) 
values (20403, 'Blood donation needle','false', -2, 150.45);

insert into vehicle_equip (EQUIPAMOUNT, EID, VID)
values (-1, 10323, 45140092);



----------------------------for delete query 1----------------------------

-- Drop the foreign key constraint
ALTER TABLE VehiclesRepairs
DROP CONSTRAINT SYS_C007714;
--add delete cascade
ALTER TABLE VehiclesRepairs
ADD CONSTRAINT fk_vehicles_repairs_vehicles
FOREIGN KEY (vID) REFERENCES Vehicles(vID) ON DELETE CASCADE;
commit;

--Drop the foreign key constraint
ALTER TABLE Vehicle_equip
DROP CONSTRAINT SYS_C007720;
--add delete cascade
ALTER TABLE vehicle_equip
ADD CONSTRAINT fk_vehicle_equip_vehicles
FOREIGN KEY (vID) REFERENCES Vehicles(vID) ON DELETE CASCADE;
commit;
---------------------------------------------------------------------------


----------------------------for delete query 2-----------------------------
ALTER TABLE orders
DROP CONSTRAINT fk_orders_suppliers;

---the deleting query----

ALTER TABLE orders
ADD CONSTRAINT fk_orders_suppliers
FOREIGN KEY (sID) REFERENCES suppliers(sid);
---------------------------------------------------------------------------
commit;

------------------add constraint for premium donor-------------------------

ALTER TABLE Donors ADD premium VARCHAR2(5) DEFAULT 'false' 
CHECK (premium IN ('true', 'false'));


UPDATE Donors SET premium = 'false';

commit;


---------add column for requiredb amount in vehicle-----------------------

ALTER TABLE equipment ADD required_in_vehicle integer DEFAULT 1 
CHECK (required_in_vehicle > 0 OR required_in_vehicle IS NULL);

update equipment set required_in_vehicle= null  where ismobile='false';
commit;

UPDATE equipment
    SET required_in_vehicle = TRUNC(DBMS_RANDOM.VALUE(2, 31))
    WHERE required_in_vehicle IS NOT NULL;
    
    
    select * from equipment
