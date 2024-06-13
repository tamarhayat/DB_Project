select * FROM Vehicles
WHERE vID IN (
  SELECT vid
  FROM VehiclesRepairs
  GROUP BY vID
  HAVING COUNT(rID) > 5
);

select * from Suppliers
where Suppliers.Sid in ( 
select S.Sid
from Suppliers S
where not exists (
      select O.SID 
      from Orders O
      --where O.ORDERDATE > TO_DATE('2023-01-01', 'YYYY-MM-DD') AND O.Sid = S.Sid
       WHERE EXTRACT(YEAR FROM O.ORDERDATE) > 2022 AND O.Sid = S.Sid
       ));
       
select * from orders 
where orders.sid= '322864751';

--select all necessary details about mobile or not mobile Equipment
select sid,sname,eid,ename,price 
from (Suppliers s natural join orders o) 
               natural join (equip_order eo natural join Equipment e) 
               where e.ismobile= &<name="mobility" 
               hint="show mobile or not mobile"
               list="true,false" type="string">;
               
