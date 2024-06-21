-- select The names of all the products supplied by supplier 322864762 
select ename
from (
select eid
from (select oID, eID from equip_order) 
natural join 
(select oid,sid from orders)
where sid= &<name="sid" hint="number with 9 digits" type= "integer" required= true>
) natural join Equipment


-- select all details by a choosen equipment.ename 

SELECT s.sID, s.sname, e.eID, e.ename, e.price
FROM Suppliers s
JOIN Orders o ON s.sID = o.sID
JOIN equip_order eo ON o.oID = eo.oID
JOIN Equipment e ON eo.eID = e.eID
WHERE e.ename = &<name="ename" hint="equipment name" type="string"
                  list="select ename from equipment"  required= true>;


-- update the quantity of equipment according to choosen order   

UPDATE Equipment e
SET e.quantity = e.quantity + (
  SELECT COALESCE(SUM(eo.amountInOrder), 0)
  FROM equip_order eo
  WHERE eo.eID = e.eID
  AND eo.oID = oID
)
WHERE e.eID IN (
  SELECT eo.eID
  FROM equip_order eo
  WHERE eo.oID =&<name="oID" hint="number with 5 digits" type="integer" required= true>
);

--select all necessary details about mobile or not mobile Equipment
select sid,sname,eid,ename,price 
from (Suppliers s natural join orders o) 
               natural join (equip_order eo natural join Equipment e) 
               where e.ismobile= &<name="mobility" 
               hint="show mobile or not mobile"
               list="true,false" type="string">;
