SELECT d.dID, d.dname
FROM Donors d
JOIN (
    SELECT dID
    FROM Vehicles
    GROUP BY dID
    HAVING COUNT(DISTINCT typeIs) = 3
) v ON d.dID = v.dID;

--delete from Vehicles where vID > 45140390;
SELECT dID
    FROM Vehicles
    GROUP BY dID
    HAVING COUNT(DISTINCT typeIs) = 2;
    
SELECT d.dID, d.dname
FROM Donors d
WHERE NOT EXISTS (
    SELECT typeIs
    FROM (SELECT DISTINCT typeIs FROM Vehicles) vt
    WHERE NOT EXISTS (
        SELECT *
        FROM Vehicles v
        WHERE v.dID = d.dID AND v.typeIs = vt.typeIs
    )
);

select * 
from Donors natural join Vehicles;

select typeIs
from Vehicles
group by typeIs;



SELECT D.typeIs
FROM (
    SELECT did, typeIs
    FROM Vehicles
    NATURAL JOIN Donors
) D
WHERE NOT EXISTS (
    SELECT T.typeIs
    FROM (
        SELECT typeIs
        FROM Vehicles
        GROUP BY typeIs
    ) T
    WHERE T.typeIs NOT IN (
        SELECT D1.typeIs
        FROM (
            SELECT did, typeIs
            FROM Vehicles
            NATURAL JOIN Donors
        ) D1
        WHERE D1.typeIs = D.typeIs
    )
);


--
delete from Suppliers
where Suppliers.Sid in ( 
select S.Sid
from Suppliers S
where not exists (
      select O.SID 
      from Orders O
      where O.ORDERDATE > TO_DATE('2023-01-01', 'YYYY-MM-DD') AND O.Sid = S.Sid ))T;
 

--שמות כל המוצרים שספק 322864762 סיפק
select ename
from (
select eid
from (select oID, eID from equip_order) 
natural join 
(select oid,sid from orders)
where sid= 322864762
) natural join Equipment
