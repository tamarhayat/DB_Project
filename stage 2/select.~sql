  
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


-- delete all suppliers who did not provide equipment in the last year
delete from Suppliers
where Suppliers.Sid in ( 
select S.Sid
from Suppliers S
where not exists (
      select O.SID 
      from Orders O
      --where O.ORDERDATE > TO_DATE('2023-01-01', 'YYYY-MM-DD') AND O.Sid = S.Sid
       WHERE EXTRACT(YEAR FROM O.ORDERDATE) > 2022 AND O.Sid = S.Sid
       ))T;
select * from orders O
where EXTRACT(YEAR FROM O.ORDERDATE) > 2022 --AND O.Sid = S.Sid

-- The names of all the products supplied by supplier 322864762
select ename
from (
select eid
from (select oID, eID from equip_order) 
natural join 
(select oid,sid from orders)
where sid= 322864762
) natural join Equipment

--select all detales for mobile eqweepment
SELECT r.rID, r.repairDate, r.description
FROM Repairs r
WHERE r.rID IN (SELECT er.rID
                FROM EquipRepairs er
                WHERE er.eID IN (SELECT e.eID
                                 FROM Equipment e
                                 WHERE e.isMobile = 'true'));
