PL/SQL Developer Test script 3.0
10
declare
  -- Non-scalar parameters require additional processing 
      result sys.odcinumberlist;
begin
  -- Call the function
     result := update_vehicle_equip(p_vid => :p_vid);
     get_equipment_and_suppliers(result);

end;

1
p_vid
1
45140096
3
0