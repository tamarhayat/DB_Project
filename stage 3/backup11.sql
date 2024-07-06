prompt PL/SQL Developer import file
prompt Created on יום ראשון 07 יולי 2024 by 97258
set feedback off
set define off
prompt Dropping DONORS...
drop table DONORS cascade constraints;
prompt Dropping EQUIPMENT...
drop table EQUIPMENT cascade constraints;
prompt Dropping SUPPLIERS...
drop table SUPPLIERS cascade constraints;
prompt Dropping ORDERS...
drop table ORDERS cascade constraints;
prompt Dropping EQUIP_ORDER...
drop table EQUIP_ORDER cascade constraints;
prompt Dropping REPAIRS...
drop table REPAIRS cascade constraints;
prompt Dropping EQUIPREPAIRS...
drop table EQUIPREPAIRS cascade constraints;
prompt Dropping VEHICLES...
drop table VEHICLES cascade constraints;
prompt Dropping VEHICLE_EQUIP...
drop table VEHICLE_EQUIP cascade constraints;
prompt Dropping VEHICLESREPAIRS...
drop table VEHICLESREPAIRS cascade constraints;
prompt Creating DONORS...
create table DONORS
(
  did         NUMBER(9) not null,
  dname       VARCHAR2(30) not null,
  address     VARCHAR2(100) not null,
  phonenumber VARCHAR2(15) not null,
  premium     VARCHAR2(5) default 'false'
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DONORS
  add primary key (DID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table DONORS
  add constraint CHECK_DONOR_PHONE
  check (phoneNumber LIKE '05_-_______');
alter table DONORS
  add check (premium IN ('true', 'false'));

prompt Creating EQUIPMENT...
create table EQUIPMENT
(
  eid                 NUMBER(5) not null,
  ename               VARCHAR2(30) not null,
  ismobile            VARCHAR2(5) not null,
  quantity            INTEGER not null,
  price               NUMBER(7,2) not null,
  required_in_vehicle INTEGER default 1
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EQUIPMENT
  add primary key (EID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EQUIPMENT
  add constraint CHECK_EQUIPMENT_QUANTITY
  check (quantity >= 0);
alter table EQUIPMENT
  add constraint CHK_REQUIRED_IN_VEHICLE
  check (required_in_vehicle > 0 OR required_in_vehicle IS NULL);
alter table EQUIPMENT
  add check (isMobile IN ('true', 'false'));

prompt Creating SUPPLIERS...
create table SUPPLIERS
(
  sid         NUMBER(9) not null,
  sname       VARCHAR2(30) not null,
  address     VARCHAR2(100) not null,
  phonenumber VARCHAR2(15) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table SUPPLIERS
  add primary key (SID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating ORDERS...
create table ORDERS
(
  oid       NUMBER(5) not null,
  orderdate DATE not null,
  sid       NUMBER(9) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ORDERS
  add primary key (OID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ORDERS
  add constraint FK_ORDERS_SUPPLIERS foreign key (SID)
  references SUPPLIERS (SID);

prompt Creating EQUIP_ORDER...
create table EQUIP_ORDER
(
  amountinorder INTEGER not null,
  eid           NUMBER(5) not null,
  oid           NUMBER(5) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EQUIP_ORDER
  add primary key (EID, OID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EQUIP_ORDER
  add foreign key (EID)
  references EQUIPMENT (EID);
alter table EQUIP_ORDER
  add foreign key (OID)
  references ORDERS (OID);
alter table EQUIP_ORDER
  add constraint CHECK_AMOUNT_IN_ORDER
  check (amountInOrder > 0);

prompt Creating REPAIRS...
create table REPAIRS
(
  rid         NUMBER(5) not null,
  repairdate  DATE not null,
  description VARCHAR2(255) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table REPAIRS
  add primary key (RID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating EQUIPREPAIRS...
create table EQUIPREPAIRS
(
  rid NUMBER(5) not null,
  eid INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EQUIPREPAIRS
  add primary key (RID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EQUIPREPAIRS
  add foreign key (RID)
  references REPAIRS (RID);
alter table EQUIPREPAIRS
  add foreign key (EID)
  references EQUIPMENT (EID);

prompt Creating VEHICLES...
create table VEHICLES
(
  vid    NUMBER(8) not null,
  typeis VARCHAR2(12) not null,
  status VARCHAR2(12) not null,
  did    NUMBER(9) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table VEHICLES
  add primary key (VID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table VEHICLES
  add foreign key (DID)
  references DONORS (DID);
alter table VEHICLES
  add check (typeIs IN ('ambulance', 'helicopter', 'motorcycle'));
alter table VEHICLES
  add check (status IN ('normal', 'not normal', 'under repair'));

prompt Creating VEHICLE_EQUIP...
create table VEHICLE_EQUIP
(
  equipamount INTEGER not null,
  eid         NUMBER(5) not null,
  vid         NUMBER(8) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table VEHICLE_EQUIP
  add primary key (EID, VID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table VEHICLE_EQUIP
  add constraint FK_VEHICLE_EQUIP_VEHICLES foreign key (VID)
  references VEHICLES (VID) on delete cascade;
alter table VEHICLE_EQUIP
  add foreign key (EID)
  references EQUIPMENT (EID);
alter table VEHICLE_EQUIP
  add constraint CHECK_EQUIP_AMOUNT
  check (equipAmount >= 0);

prompt Creating VEHICLESREPAIRS...
create table VEHICLESREPAIRS
(
  rid NUMBER(5) not null,
  vid NUMBER(8) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table VEHICLESREPAIRS
  add primary key (RID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table VEHICLESREPAIRS
  add constraint FK_VEHICLES_REPAIRS_VEHICLES foreign key (VID)
  references VEHICLES (VID) on delete cascade;
alter table VEHICLESREPAIRS
  add foreign key (RID)
  references REPAIRS (RID);

prompt Disabling triggers for DONORS...
alter table DONORS disable all triggers;
prompt Disabling triggers for EQUIPMENT...
alter table EQUIPMENT disable all triggers;
prompt Disabling triggers for SUPPLIERS...
alter table SUPPLIERS disable all triggers;
prompt Disabling triggers for ORDERS...
alter table ORDERS disable all triggers;
prompt Disabling triggers for EQUIP_ORDER...
alter table EQUIP_ORDER disable all triggers;
prompt Disabling triggers for REPAIRS...
alter table REPAIRS disable all triggers;
prompt Disabling triggers for EQUIPREPAIRS...
alter table EQUIPREPAIRS disable all triggers;
prompt Disabling triggers for VEHICLES...
alter table VEHICLES disable all triggers;
prompt Disabling triggers for VEHICLE_EQUIP...
alter table VEHICLE_EQUIP disable all triggers;
prompt Disabling triggers for VEHICLESREPAIRS...
alter table VEHICLESREPAIRS disable all triggers;
prompt Disabling foreign key constraints for ORDERS...
alter table ORDERS disable constraint FK_ORDERS_SUPPLIERS;
prompt Disabling foreign key constraints for EQUIP_ORDER...
alter table EQUIP_ORDER disable constraint SYS_C007899;
alter table EQUIP_ORDER disable constraint SYS_C007900;
prompt Disabling foreign key constraints for EQUIPREPAIRS...
alter table EQUIPREPAIRS disable constraint SYS_C007883;
alter table EQUIPREPAIRS disable constraint SYS_C007884;
prompt Disabling foreign key constraints for VEHICLES...
alter table VEHICLES disable constraint SYS_C007907;
prompt Disabling foreign key constraints for VEHICLE_EQUIP...
alter table VEHICLE_EQUIP disable constraint FK_VEHICLE_EQUIP_VEHICLES;
alter table VEHICLE_EQUIP disable constraint SYS_C007920;
prompt Disabling foreign key constraints for VEHICLESREPAIRS...
alter table VEHICLESREPAIRS disable constraint FK_VEHICLES_REPAIRS_VEHICLES;
alter table VEHICLESREPAIRS disable constraint SYS_C007914;
prompt Loading DONORS...
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498461, 'Tori  Keaton', '27 Hong Kong, Lathrop, USA', '057-5228143', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498462, 'Larnelle  Bergen', '491 Bullock Road, Fremont, USA', '053-8234879', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498463, 'Annette  Bruce', '54 Butner, Frederiksberg, Denmark', '051-5908785', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498464, 'Rebecca  Janney', '31 Ashley Ave, Soest, Netherlands', '059-7498715', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498465, 'Olga  Copeland', '32nd Street, Hunt Valley, USA', '056-3787029', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498466, 'Andy  Gordon', '48 South Weber Road, Schlieren, Switzerland', '053-3578865', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498467, 'Stevie  Cleary', '27 Viterelli Street, Barnegat, USA', '056-3864601', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498468, 'Roy  McDowall', '62nd Street, Fort gordon, USA', '057-2928096', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498469, 'Juan  Kline', '89 Mitra Road, Melrose, USA', '059-1884068', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498470, 'Neve  Morales', '961 Santa Rosa Drive, Kingston, Canada', '058-3666535', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498471, 'Raul  Amos', '72 Art, Monterey, USA', '058-4440049', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498472, 'Emily  Potter', '31 Orleans Street, Stocksbridge, United Kingdom', '055-3738195', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498473, 'Rebeka  Mueller-Stahl', '37 Alston Road, Fort gordon, USA', '052-4630804', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498474, 'Rachid  Thompson', '98 Cesar Ave, Portsmouth, USA', '058-2544478', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498475, 'Debra  Bentley', '43rd Street, Oak Park, USA', '059-1162916', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498476, 'Danny  Lopez', '22 Bkk Blvd, Or-yehuda, Israel', '059-8272597', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498477, 'Terrence  Holly', '100 Hopkins Road, Philadelphia, USA', '052-4670012', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498478, 'Kate  Steagall', '807 Chloe Road, Bern, Switzerland', '058-4468497', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498479, 'Ron  Mitchell', '522 Neuchײ³ֲ¢tel Drive, Lund, Sweden', '054-8370605', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498480, 'Raul  LaMond', '46 Hawthorne Blvd, Kanazawa, Japan', '051-3958891', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498481, 'Maury  Diaz', '4 Le chesnay Ave, Hochwald, Switzerland', '050-6298140', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498482, 'Stephen  Hurt', '97 Kim Road, Paisley, United Kingdom', '058-6248440', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498483, 'Sandra  Benson', '98 Nanaimo Street, New York City, USA', '055-4621349', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498484, 'Joseph  Sorvino', '88 Boston Street, Alleroed, Denmark', '058-3398557', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498485, 'Fairuza  Orlando', '36 Pordenone Drive, Lucca, Italy', '058-6407803', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498486, 'Gavin  McPherson', '47 Laredo Drive, Glenshaw, USA', '058-7822561', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498487, 'Mary-Louise  Judd', '63 Yomgok-dong Road, Valencia, Spain', '057-8357733', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498488, 'Trace  Spine', '55 Leo Road, Neuchײ³ֲ¢tel, Switzerland', '051-2152326', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498489, 'Kirsten  Garfunkel', '60 Atlas, Ben-Gurion, Israel', '055-5218066', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498490, 'Rick  Foxx', '43 Tempest Blvd, Trieste, Italy', '050-5801974', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498491, 'Judi  Evanswood', '858 Timothy Drive, Rochester, USA', '050-2966769', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498492, 'Mos  Kattan', '420 Freda Blvd, Jakarta, Indonesia', '055-4654260', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498493, 'Marie  Tilly', '83rd Street, Germantown, USA', '058-2054446', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498494, 'Debi  Colin Young', '32nd Street, Newnan, USA', '056-5424596', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498495, 'Andrae  Leguizamo', '15 Peachtree City, Trieste, Italy', '052-9657424', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498496, 'Bradley  Sledge', '462 Foster City Blvd, Murray, USA', '059-6803980', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498497, 'Danny  Dunst', '6 Cockburn Drive, Northbrook, USA', '059-6334027', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498498, 'Bernard  Cromwell', '81 Sammy Street, Guamo, Italy', '059-1888337', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498499, 'Wendy  Briscoe', '99 Hersh Blvd, Uden, Netherlands', '050-8687891', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498500, 'Denis  Moraz', '67 Marin Street, Melbourne, Australia', '055-9007471', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498501, 'Kylie  Purefoy', '53 Vienna, Yamagata, Japan', '056-2117965', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498502, 'Yaphet  Bonneville', '75 Brickell Drive, Glenshaw, USA', '051-2482937', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498503, 'Minnie  Ponty', '25 Sheen Street, Sursee, Switzerland', '059-4967659', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498504, 'Jose  Rourke', '72 Stoneham Road, Berwyn, USA', '052-1857492', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498505, 'Miranda  Cassidy', '279 Beatty Road, Alpharetta, USA', '054-9597833', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498506, 'Kathleen  Tomlin', '276 Robinson Road, Odense, Denmark', '058-2613953', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498507, 'Mos  Sevenfold', '12 Berkoff Drive, Mechanicsburg, USA', '054-8598892', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498508, 'Carla  Greene', '93rd Street, Ebersberg, Germany', '056-4059358', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498509, 'Carolyn  Ripley', '51st Street, Johannesburg, South Africa', '056-1234227', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498510, 'Night  Monk', '47 Ving Blvd, Gauteng, South Africa', '051-8422283', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498511, 'Nicholas  Ticotin', '4 Linz Road, Lecanto, USA', '053-8457680', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498512, 'Morris  Lynn', '72 Lynne Drive, Abbotsford, Australia', '055-3281858', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498513, 'Rachel  MacIsaac', '79 Dern Road, Kanazawa, Japan', '050-7248335', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498514, 'Mike  Coleman', '100 Del Toro Street, Karachi, Pakistan', '055-3913270', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498515, 'Matthew  Frampton', '84 Stiller, Horb, Germany', '052-1999010', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498516, 'Randall  Fichtner', '79 McPherson Street, Reisterstown, USA', '056-8353630', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498517, 'Brenda  Garcia', '56 Rome Street, Mito, Japan', '058-8886188', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498518, 'Seann  Downie', '81st Street, Neuchײ³ֲ¢tel, Switzerland', '051-9880140', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498519, 'Mandy  Detmer', '96 Wakeling, Berkeley, USA', '057-4755851', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498520, 'Emma  Chinlund', '72nd Street, Algermissen, Germany', '056-6461166', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498521, 'Terence  Hanley', '568 Susan Drive, Bloomington, USA', '053-3078533', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498522, 'Rosco  Sossamon', '43 Magstadt Road, Alexandria, USA', '053-5853526', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498523, 'Candice  Eldard', '923 Stiers Ave, Valencia, Spain', '053-1636194', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498524, 'Brad  Stiller', '24 Vinton Street, Kerava, Finland', '053-3154815', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498525, 'Kimberly  Iglesias', '33 Shawnee Street, Rockville, USA', '052-6237380', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498526, 'Frederic  Knight', '146 Kingsley Street, Casselberry, USA', '052-9517976', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498527, 'Fairuza  MacIsaac', '78 Gauteng Road, Lexington, USA', '050-1810195', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498528, 'Moe  Colin Young', '394 Capshaw Drive, Pompton Plains, USA', '057-2638348', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498529, 'Isaiah  Schreiber', '30 Mos, Leimen, Germany', '059-1896064', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498530, 'Donal  Sheen', '25 Dearborn Street, Lefkosa, Turkey', '051-4344692', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498531, 'Lynette  Kristofferson', '32 Hector Road, Friedrichshafe, Germany', '059-4589768', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498532, 'Ike  Moore', '72 Pullman Street, Tulsa, USA', '055-5366218', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498533, 'Irene  Pullman', '43 Rueben Ave, Helsinki, Finland', '054-3151415', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498534, 'Tamala  Candy', '310 Foxx Ave, Birmensdorf, Switzerland', '056-2635324', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498535, 'Judge  Gaynor', '4 Catherine Ave, Butner, USA', '055-4778234', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498536, 'Cole  Danes', '673 Cassel, Harsum, Germany', '051-8907025', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498537, 'Antonio  Bassett', '90 Hiatt Road, Menlo Park, USA', '050-6233363', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498538, 'Lance  McDowell', '13 Sedgwick Drive, Itu, Brazil', '053-6696929', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498539, 'Maury  Hayes', '83rd Street, Cary, USA', '059-7996087', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498540, 'Bradley  Haynes', '47 Rankin Street, Graz, Austria', '052-6233869', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498541, 'Michelle  Benson', '65 Christie Blvd, Woking, United Kingdom', '050-1398628', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498542, 'Michelle  Rea', '8 Jun-nam Street, Wuerzburg, Germany', '051-7462491', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498543, 'Cloris  McGriff', '60 Mira Drive, Darmstadt, Germany', '057-8618152', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498544, 'Sissy  Bandy', '91 Rosie Drive, Milford, USA', '053-2519253', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498545, 'Ralph  McCready', '41st Street, Cardiff, United Kingdom', '058-1587247', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498546, 'Christine  Finn', '20 Salisbury Street, Augst, Switzerland', '057-1925493', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498547, 'Lisa  von Sydow', '57 Leawood Street, Buffalo, Canada', '054-4411171', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498548, 'King  Skerritt', '8 Merle, Chemnitz, Germany', '055-8326999', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498549, 'Boyd  Favreau', '24 Redmond Road, Nordhausen, Germany', '050-5791821', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498550, 'Matthew  Hagerty', '57 Lynn Street, Trenton, USA', '058-6954075', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498551, 'Ernie  Ellis', '47 Bergara Road, South Jordan, USA', '058-6770625', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498552, 'Alec  Coleman', '11 Holeman Blvd, Hײ³ג‚×ssleholm, Sweden', '055-8106673', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498553, 'Judy  Tambor', '2 Phoenix Drive, Guelph, Canada', '053-8707816', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498554, 'Darren  Fraser', '66 Caine Street, Nuernberg, Germany', '056-2813677', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498555, 'Tal  Norton', '32nd Street, Santa Fe, USA', '055-1310220', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498556, 'Natascha  Michael', '39 Clark Ave, Pirmasens, Germany', '053-4951053', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498557, 'Heath  Reid', '24 Ming-Na Street, Ottawa, Canada', '054-4147566', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498558, 'Drew  Santana', '52 Donovan Road, Macclesfield, United Kingdom', '058-3102954', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498559, 'Nancy  Benet', '77 Fierstein Drive, Antwerpen, Belgium', '053-4382682', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498560, 'Carol  Gagnon', '78 Birch Street, Zwolle, Netherlands', '050-5989097', 'true');
commit;
prompt 100 records committed...
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498561, 'Harris  Shandling', '745 Lila Road, Berlin, Germany', '056-3928493', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498562, 'Elias  Garr', '20 Malcolm Road, San Jose, USA', '054-3518280', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498563, 'Gary  Johnson', '32 Stanley Street, Turku, Finland', '051-9653237', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498564, 'Hookah  Akins', '7 Kinski, Natal, Brazil', '055-2686988', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498565, 'Alfie  Kline', '79 Osment Road, Kײ³ֲ¸benhavn, Denmark', '052-5542240', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498566, 'Tal  Avital', '76 Roundtree Road, Gaithersburg, USA', '052-1594274', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498567, 'Cameron  Boorem', '58 Albertina Road, Albany, USA', '053-3817107', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498568, 'Patty  Brock', '57 Padova Drive, Caracas, Venezuela', '051-3910656', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498569, 'Richie  Dillon', '62 Angela Blvd, Campinas, Brazil', '051-4919317', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498570, 'Crystal  Johansson', '891 Viggo, Tulsa, USA', '051-6655614', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498571, 'Humberto  Frakes', '316 Epps Street, Fuchstal-asch, Germany', '050-9458885', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498572, 'Rosario  McIntosh', '84 Whitman Street, Macau, Macau', '057-1832386', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498573, 'Ernest  Nightingale', '14 Osaka Street, Yavne, Israel', '055-6068155', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498574, 'Richard  Emmerich', '92 Wilder Drive, Phoenix, USA', '053-8846779', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498575, 'Radney  Chestnut', '6 Port Macquarie Road, Nizhnevartovsk, Russia', '052-5828817', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498576, 'Maxine  Parsons', '35 Shocked Road, Herford, Germany', '050-4904480', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498577, 'Orlando  Blanchett', '35 Lake Forest Street, Stafford, USA', '059-3034592', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498578, 'Michael  McNeice', '67 Webb Drive, Dinslaken, Germany', '058-4845072', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498579, 'Hector  Yankovic', '81 Lund Drive, Douala, Cameroun', '056-5437830', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498580, 'Demi  DiCaprio', '69 Adamstown Road, Prague, Czech republic', '053-8459835', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498581, 'Willem  Freeman', '40 Barrymore Street, Parsippany, USA', '056-6386734', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498582, 'Nicky  Cervine', '35 Geena Drive, Hounslow, United Kingdom', '056-2677052', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498583, 'Karen  Grier', '899 Shreveport, Williamstown, USA', '052-9423999', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498584, 'Terri  Wilkinson', '32 Tomlin Drive, Bradenton, USA', '058-5642931', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498585, 'Thomas  Newman', '898 Warwick Ave, Middleburg Heights, USA', '055-1677835', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498586, 'Stanley  Abraham', '59 Elliott Ave, Lancaster, USA', '054-7676537', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498587, 'Carolyn  Head', '33 Spears Street, Amherst, USA', '054-1181606', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498588, 'Eliza  Connick', '51 Kennedy Street, Sevilla, Spain', '053-4091793', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498589, 'Dom  Vanian', '22 Marlon Street, Mountain View, USA', '054-6511887', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498590, 'Toni  Whitman', '299 Hornsby Street, Leipzig, Germany', '055-4441180', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498591, 'Tori  Bandy', '79 Bischofshofen Drive, Ebersdorf, Germany', '050-1831469', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498592, 'Tramaine  Paltrow', '83 Russo, Bad Camberg, Germany', '050-3141029', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498593, 'Rosco  Brown', '100 Copeland Road, Ribeirao preto, Brazil', '054-5594170', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498594, 'Mindy  Dawson', '27 Marshall, Fukui, Japan', '056-9431681', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498595, 'Mekhi  McNarland', '3 Reubens Drive, Johannesburg, South Africa', '059-4310223', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498596, 'Doug  Travers', '53 Ticotin Blvd, Ottawa, Canada', '050-3550572', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498597, 'Hookah  Colon', '63 Matthew, Daejeon, South Korea', '053-1178274', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498598, 'Dom  Kenoly', '50 Gellar Ave, Limeira, Brazil', '059-1905299', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498599, 'Juan  Easton', '64 Orlando Street, Graz, Austria', '055-6419120', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498600, 'Ali  Luongo', '44 McLachlan, Barcelona, Spain', '050-7945386', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498601, 'Carrie-Anne  Briscoe', '95 Dillon Street, Bruneck, Italy', '057-9904281', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498602, 'Randall  Dunaway', '498 Lizzy Drive, Staten Island, USA', '056-4092494', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498603, 'Clea  Sobieski', '37 Benoit Road, Lund, Sweden', '054-1408309', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498604, 'Rutger  Coverdale', '85 Oldwick Street, Brookfield, USA', '052-9194605', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498605, 'Shannon  Smith', '53 Weaving Road, Royston, United Kingdom', '052-9720588', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498606, 'Miguel  Suchet', '76 Rock Blvd, Mogliano Veneto, Italy', '055-4499835', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498607, 'Mary  Alda', '60 Charlton Road, Zaandam, Netherlands', '055-2540119', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498608, 'Amy  O''Neill', '69 Liotta Road, Ettlingen, Germany', '050-2767062', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498609, 'Courtney  Roth', '33 Jean-Luc Street, Dublin, USA', '056-5296383', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498610, 'Lydia  Carlton', '77 Byrne, Vienna, Austria', '053-9431203', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498611, 'Val  Ammons', '82 Ellis Ave, Spring Valley, USA', '054-8793021', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498612, 'Wally  Winslet', '95 Kahn Blvd, Towson, USA', '054-9940667', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498613, 'Wendy  Lauper', '307 Waite Park Street, Espoo, Finland', '052-3352403', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498614, 'Julianna  Cruz', '61st Street, Virginia Beach, USA', '053-8552201', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498615, 'Woody  Ali', '362 Sundsvall Street, Sale, United Kingdom', '056-6946018', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498616, 'Jean-Luc  Rundgren', '31 Deejay Drive, Zwolle, Netherlands', '051-8738588', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498617, 'Cate  Viterelli', '520 Elizabeth Street, Tempe, USA', '051-5594508', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498618, 'Jonny  Stone', '69 Geggy, Gaithersburg, USA', '053-5922135', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498619, 'Veruca  Berkley', '439 Ness Street, Echirolles, France', '052-4164443', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498620, 'Franco  Simpson', '667 Shizuoka Road, Goslar, Germany', '058-5932364', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498621, 'Queen  Kapanka', '78 Stoltz Blvd, Zײ³ֲ¼rich, Switzerland', '050-8060572', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498622, 'Leo  Diehl', '838 Silverman, Guelph, Canada', '055-9368622', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498623, 'Gordon  Collins', '13 Fort Lee Street, Westport, USA', '051-9764734', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498624, 'Mac  Kahn', '68 Elle Ave, Zײ³ֲ¼rich, Switzerland', '053-9836922', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498625, 'Victor  Margulies', '54 Vincent Road, Curitiba, Brazil', '053-9515705', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498626, 'Arturo  Jackson', '80 Gennevilliers Street, Orlando, USA', '054-1362294', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498627, 'Kevin  Grier', '86 Bellerose Drive, Koppl, Austria', '055-2420806', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498628, 'Andy  Stevens', '76 Mazar Road, Buffalo, Canada', '051-5912700', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498629, 'Patrick  Weaving', '76 Allen Drive, Netanya, Israel', '052-8552092', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498630, 'Domingo  Reed', '12 Jody Road, Colombes, France', '050-4818285', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498631, 'Gena  Lange', '31 Cheshire Road, Odense, Denmark', '050-4307151', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498632, 'Carla  Molina', '7 Stiles Road, Hong Kong, Hong Kong', '055-1525424', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498633, 'Mel  Rydell', '24 Wilkinson Drive, North Sydney, Australia', '052-4489006', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498634, 'Jesse  Brock', '43 Burrows Drive, Bern, Switzerland', '057-7241847', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498635, 'Chi  Redgrave', '32nd Street, Rimini, Italy', '055-1955570', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498636, 'Walter  Ticotin', '83rd Street, San Jose, Costa Rica', '054-3780494', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498637, 'Debby  Buckingham', '4 Folds Ave, Antwerpen, Belgium', '056-6899697', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498638, 'Ethan  Saxon', '477 Takapuna Road, Changwon-si, South Korea', '056-6492020', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498639, 'Robbie  Dushku', '9 Lin Street, Milton Keynes, United Kingdom', '052-9669936', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498640, 'Gabriel  Stevens', '57 Nanci Ave, Shoreline, USA', '054-5584993', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498641, 'Katrin  Andrews', '67 Rade Road, Cleveland, USA', '059-8372078', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498642, 'Kirk  Torino', '264 Hayes Road, Utsunomiya, Japan', '057-2062968', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498643, 'Selma  Mortensen', '286 Hawke Street, Lincoln, USA', '059-4203879', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498644, 'Micky  Kweller', '47 Corey, Szazhalombatta, Hungary', '054-7753069', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498645, 'Amy  Crow', '36 Day-Lewis Road, Fukushima, Japan', '053-9763028', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498646, 'Judd  Mars', '72nd Street, Kwun Tong, Hong Kong', '058-6415108', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498647, 'Nikki  Addy', '340 Kaiserslautern Ave, Pirapora bom Jesus, Brazil', '056-9955409', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498648, 'Juliette  McLean', '91st Street, Bischofshofen, Austria', '057-3912786', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498649, 'Jet  Ward', '39 Stiers Street, Le chesnay, France', '056-4030073', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498650, 'Joely  Oates', '99 Evans Road, Ashland, USA', '055-9047024', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498651, 'Rob  Crosby', '91st Street, St-bruno, Canada', '050-5857381', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498652, 'Randall  Shepherd', '23 Juneau Drive, Steyr, Austria', '053-6535169', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498653, 'Kazem  Blossoms', '63 Crispin Ave, Lyon, France', '058-2314021', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498654, 'Boz  McCracken', '29 Colton Street, Di Savigliano, Italy', '050-6365602', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498655, 'Cate  Postlethwaite', '41 Perry Blvd, Thames Ditton, United Kingdom', '058-2340463', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498656, 'Rachel  Rooker', '12nd Street, Ferraz  vasconcelos, Brazil', '054-5465773', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498657, 'Swoosie  Frampton', '92nd Street, Ipswich, United Kingdom', '054-8557108', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498658, 'Rory  Horton', '63rd Street, Dietikon, Switzerland', '056-4256896', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498659, 'Lisa  Rucker', '41 Burstyn Street, Rtp, USA', '058-9181410', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498660, 'Lari  Oates', '131 Newnan Road, Nashua, USA', '054-8582827', 'false');
commit;
prompt 200 records committed...
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498661, 'Gwyneth  Plummer', '1 Natalie Blvd, Rochester, USA', '052-6317384', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498662, 'Lenny  Hyde', '22 Fort Lewis Drive, Sײ³ֲ£o paulo, Brazil', '059-9088707', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498663, 'Irene  Weaver', '161 Paymer Road, Burgess Hill, United Kingdom', '057-4869043', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498664, 'Campbell  Harmon', '62 Colton Road, Des Plaines, USA', '056-2950649', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498665, 'Breckin  Fonda', '726 Kloten Road, Mount Laurel, USA', '051-7898496', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498666, 'Guy  Summer', '75 Ted Road, Vancouver, Canada', '050-1990025', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498667, 'Raymond  Bacon', '2 Lubbock Road, Stuttgart, Germany', '059-8866693', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498668, 'Jimmie  Ruiz', '821 McClinton Blvd, Manaus, Brazil', '059-8483631', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498669, 'Brad  Ifans', '5 Duvall Blvd, Annandale, USA', '052-9489784', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498670, 'Mac  McLean', '57 Javon Road, Oosterhout, Netherlands', '055-6708806', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498671, 'Josh  Thornton', '13rd Street, Tulsa, USA', '051-9556121', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498672, 'Sally  Walsh', '5 Brno Street, Richardson, USA', '052-7211710', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498673, 'Giovanni  Schwarzenegger', '1 Fairview Heights Road, Biel, Switzerland', '052-7225012', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498674, 'Eugene  Red', '22 Danger, El Segundo, USA', '054-1765646', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498675, 'Giancarlo  McGoohan', '778 Geoff Blvd, Laredo, USA', '056-1782347', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498676, 'Janeane  Costello', '19 Philip Road, Bern, Switzerland', '056-7464535', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498677, 'Davey  Hingle', '34 Sweet Drive, Valencia, Spain', '055-5506988', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498678, 'Whoopi  Dale', '40 Boothe Drive, Trieste, Italy', '056-6358186', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498679, 'Edgar  Murphy', '4 Sinatra Ave, Traralgon, Australia', '055-1379268', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498680, 'Gena  Garfunkel', '262 Rhymes Drive, Media, USA', '053-7720768', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498681, 'Lena  Kinski', '31 Stills Road, Dunn loring, USA', '053-6090888', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498682, 'Dorry  MacDonald', '631 Ft. Lauderdale Street, Runcorn, United Kingdom', '051-4902272', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498683, 'Junior  Womack', '56 Mobile Street, Buffalo Grove, USA', '051-4967669', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498684, 'Zooey  Cohn', '66 Burgess Hill, Eindhoven, Netherlands', '055-8235803', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498685, 'Cyndi  Copeland', '79 Skarsgard Street, Essen, Germany', '055-9633452', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498686, 'Brittany  Paymer', '9 Puckett Blvd, Stanford, USA', '051-4587566', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498687, 'Micky  Carrington', '17 Gates Street, Karlstad, Sweden', '052-2009366', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498688, 'Jessica  Williams', '31 Peebles Street, Park Ridge, USA', '057-5626501', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498689, 'Mike  Walker', '55 Colton Road, Cannock, United Kingdom', '055-7317804', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498690, 'Campbell  Idle', '73 Lonsdale Street, South Hadley, USA', '057-6850035', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498691, 'Robin  Apple', '996 Prowse Road, Calcutta, India', '055-6673021', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498692, 'Maria  urban', '966 Walsh Road, Mapo-gu, South Korea', '053-2453481', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498693, 'Rory  Sandoval', '54 New Castle Drive, New Fairfield, USA', '052-2205863', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498694, 'Ernest  Zellweger', '287 North Yorkshire, Englewood Cliffs, USA', '053-1870901', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498695, 'Irene  O''Neill', '70 McGill Street, Mount Olive, USA', '052-2696699', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498696, 'Elvis  Torino', '39 Regina Street, Beaverton, USA', '050-7953051', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498697, 'Brent  Hampton', '45 Coleman Drive, Warley, United Kingdom', '058-8638760', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498698, 'Tori  Douglas', '62nd Street, Monterey, USA', '057-8302333', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498699, 'Debra  Holliday', '64 Alpharetta Street, Delafield, USA', '053-1123253', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498700, 'Herbie  Reilly', '64 Franklin Road, Oshawa, Canada', '058-7069366', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498701, 'Terry  Meyer', '5 Krumholtz Road, Canberra, Australia', '051-5687159', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498702, 'Colleen  Choice', '17 Warsaw Street, Mobile, USA', '056-3615227', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498703, 'Miko  McKean', '38 Moe Drive, Wellington, New Zealand', '056-4100049', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498704, 'Gladys  Elizabeth', '53 Alicia, Nancy, France', '051-7161168', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498705, 'Carolyn  Barrymore', '71 Atkinson Ave, Paraju, Brazil', '050-5899367', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498706, 'Joanna  Frakes', '741 Grant Road, Belmont, USA', '054-7997741', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498707, 'Vivica  Gandolfini', '13 Keeslar Street, Tbilisi, Georgia', '052-9784865', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498708, 'Jann  Hayek', '82 Turku Road, Hampton, USA', '051-4918953', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498709, 'Geraldine  Ingram', '39 Swayze Street, Bellevue, USA', '055-9559046', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498710, 'Laurie  Bridges', '22 Americana Street, Nantes, France', '054-9825324', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498711, 'Curt  Arden', '73 Washington, Augsburg, Germany', '050-4888594', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498712, 'Etta  Eldard', '421 Bassett Drive, South Jordan, USA', '055-7182924', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498713, 'Janice  McConaughey', '61 Maria Drive, San Francisco, USA', '055-3142028', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498714, 'Maria  Tucker', '35 Cagle Road, Okayama, Japan', '051-5496223', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498715, 'Penelope  Farina', '66 Cliff Street, Angers, France', '058-5685373', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498716, 'Emilio  McKean', '53rd Street, Carlsbad, USA', '050-4306804', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498717, 'Sander  Platt', '39 Matthau Ave, Ebersdorf, Germany', '058-2343276', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498718, 'Dustin  Johnson', '65 Gibson Blvd, Johor Bahru, Malaysia', '058-8939327', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498719, 'Debby  Evanswood', '34 Hampton Road, Cannock, United Kingdom', '058-4138604', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498720, 'Busta  Wahlberg', '40 Barrymore, Charleston, USA', '055-5411187', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498721, 'Karon  Coltrane', '52 Mint Road, Tokushima, Japan', '057-9962599', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498722, 'Coley  Penn', '93 Branagh Street, Kongserbg, Norway', '051-9450111', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498723, 'Katie  Nielsen', '55 Bening Ave, Springfield, USA', '054-4815775', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498724, 'Kieran  Peterson', '254 Alexander, Mײ³ֲ¼nchen, Germany', '054-9290292', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498725, 'Kurtwood  Weaver', '78 Brody Drive, Den Haag, Netherlands', '056-8405611', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498726, 'Kevin  Deschanel', '62nd Street, Mclean, USA', '056-3001965', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498727, 'Thomas  Kinski', '287 Duschel Street, Athens, Greece', '059-2138520', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498728, 'Roberta  Bosco', '92 Oszajca Blvd, Zurich, Switzerland', '059-6666328', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498729, 'Elvis  Leguizamo', '64 Bradley Road, Odense, Denmark', '053-5783117', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498730, 'Blair  O''Sullivan', '649 Traralgon Ave, Lyon, France', '057-2791932', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498731, 'Cesar  Rains', '66 Janice Street, Coimbra, Portugal', '054-4537498', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498732, 'Kurt  Whitley', '406 Richard Road, Horsham, United Kingdom', '053-9828517', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498733, 'Armin  Hatchet', '62 Palmer, Greenwood Village, USA', '056-8524954', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498734, 'Dabney  Harper', '75 Christina Street, Olympia, USA', '054-4580894', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498735, 'Jim  Thomas', '66 Sepulveda Road, Portsmouth, USA', '053-4789766', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498736, 'Armand  David', '35 Benjamin, Silverdale, USA', '057-3755067', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498737, 'Walter  Shawn', '83 Oldwick Road, Vallauris, France', '058-7727296', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498738, 'Darius  Weisberg', '18 Stigers Street, Dublin, Ireland', '056-4937443', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498739, 'Ritchie  Jordan', '55 Gallagher Street, Copenhagen, Denmark', '053-1891587', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498740, 'Willie  Buckingham', '94 Ben-Gurion Street, Mײ³ֲ¼nchen, Germany', '051-7533690', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498741, 'Kasey  Morse', '90 Johnson, West Chester, USA', '059-5803923', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498742, 'Brent  Jordan', '15 Houma Road, Bretzfeld-Waldbach, Germany', '055-7998957', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498743, 'Nanci  McDonnell', '94 Conroy Ave, League city, USA', '052-5331289', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498744, 'Jean-Claude  Chambers', '13 Mann Road, Flower mound, USA', '059-1551868', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498745, 'Jared  Daniels', '73rd Street, Bruneck, Italy', '058-4899645', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498746, 'Lupe  McIntosh', '167 Keith Street, Hartford, USA', '057-6348260', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498747, 'Avenged  Clooney', '73 Cozier Ave, Naestved, Denmark', '053-3762401', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498748, 'Ty  Holmes', '5 Frost Road, Market Harborough, United Kingdom', '053-3755508', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498749, 'Bonnie  Nivola', '42 Mark Street, Marlboro, USA', '055-3965350', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498750, 'Anna  Curry', '63 Platt Drive, Americana, Brazil', '057-1138326', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498751, 'Lynette  Stoltz', '70 Illeana Street, Redding, USA', '056-4277411', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498752, 'Johnette  Mohr', '33 Dench Ave, Annandale, USA', '054-2517820', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498753, 'Donald  Myers', '93 Lachey Road, Kungens kurva, Sweden', '055-9933651', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498754, 'Vondie  Zappacosta', '373 Auckland Drive, Hiroshima, Japan', '051-6576673', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498755, 'Hank  MacLachlan', '30 Harold Road, Holderbank, Switzerland', '051-3139271', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498756, 'Taylor  Shepard', '179 Rockwell Blvd, Boucherville, Canada', '053-2906623', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498757, 'Swoosie  von Sydow', '26 Cohn Road, Shelton, USA', '052-5660327', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498758, 'Sophie  Maguire', '83rd Street, Sevilla, Spain', '054-9079771', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498759, 'Grace  Hagar', '962 McIntyre Ave, Eisenhײ³ֲ¼ttenstadt, Germany', '058-5189885', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498760, 'Carole  Craig', '829 Dianne, Chorzײ³ֲ³w, Poland', '058-6661212', 'false');
commit;
prompt 300 records committed...
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498761, 'Ricky  Breslin', '87 Sewell Blvd, Waco, USA', '058-5996170', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498762, 'Jane  McDonnell', '4 Lee Drive, Kuopio, Finland', '050-9440668', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498763, 'Harrison  Elwes', '99 Whitford Street, Farmington Hills, USA', '058-4246700', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498764, 'Chely  Cooper', '61 Tara Street, Schlieren, Switzerland', '056-6878040', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498765, 'Allan  Cross', '77 Cohn Road, Northampton, United Kingdom', '055-4919673', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498766, 'Junior  Hoffman', '471 James, Dresden, Germany', '052-8690283', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498767, 'Woody  Polito', '288 Diaz Road, Charlotte, USA', '054-6564277', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498768, 'Chalee  Barry', '54 Squier Drive, New orleans, USA', '050-7917074', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498769, 'Jill  Loeb', '60 Howie Drive, Nantes, France', '050-8703278', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498770, 'Patti  Lorenz', '71 Warszawa Street, Altstײ³ג‚×tten, Switzerland', '050-3670971', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498771, 'Sissy  Carnes', '73 Clooney Road, Sapulpa, USA', '050-2700300', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498772, 'Gailard  Mahoney', '28 Snow Drive, Montreal, Canada', '053-2004084', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498773, 'Colin  Johansen', '62 Hercules Ave, Burgess Hill, United Kingdom', '057-2018512', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498774, 'Mac  Schneider', '67 Robby Street, Waco, USA', '051-8426121', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498775, 'Sally  O''Neal', '31 Hingle Road, Sײ³ֲ£o paulo, Brazil', '057-8040765', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498776, 'Bret  Deschanel', '69 Perry Blvd, Londrina, Brazil', '054-6092760', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498777, 'Daryle  Norton', '31 Chloe Drive, Webster Groves, USA', '058-6295902', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498778, 'Paula  Davies', '92nd Street, Slidel, USA', '051-3230101', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498779, 'Natacha  Cetera', '55 Martin Street, Paraju, Brazil', '056-2485232', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498780, 'Pamela  Lofgren', '2 Mandy Drive, Glasgow, United Kingdom', '051-3599594', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498781, 'Jessica  Lindo', '87 Griffin, Uden, Netherlands', '052-6724392', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498782, 'Faye  Flanagan', '31st Street, Suwon, South Korea', '059-5074434', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498783, 'Bill  Osment', '606 Kane Street, Copenhagen, Denmark', '051-9187935', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498784, 'Corey  Stamp', '3 Romijn-Stamos Ave, San Dimas, USA', '058-8405382', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498785, 'Gene  Walker', '43rd Street, Columbia, USA', '058-1191173', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498786, 'Loreena  Chestnut', '917 Elche Street, Geneve, Switzerland', '056-6678928', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498787, 'Walter  Ontiveros', '21st Street, Koppl, Austria', '051-2122183', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498788, 'Stewart  Calle', '22 Madsen, Rockford, USA', '050-1200684', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498789, 'Eliza  Rippy', '11 Terri Road, Unionville, Canada', '056-5773523', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498790, 'Mint  Rebhorn', '53 Polito Ave, Port Macquarie, Australia', '059-8065769', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498791, 'Lucy  Jeffreys', '36 Dickinson Ave, Dublin, USA', '057-7914117', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498792, 'Chantײ³ֲ©  Grier', '43 Hauer Drive, Toulouse, France', '058-5205759', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498793, 'Brent  Broza', '983 LaSalle Street, Victoria, Canada', '058-5816916', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498794, 'Nanci  Holmes', '59 Maxine Road, Moscow, Russia', '051-6260991', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498795, 'Liquid  Douglas', '47 Brampton Road, Athens, USA', '053-7811498', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498796, 'Phil  Yankovic', '75 Irving Blvd, Campana, Argentina', '059-4051708', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498797, 'Melba  Holeman', '351 Benson Road, Brussel, Belgium', '050-6778585', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498798, 'Diane  Prinze', '89 Kathy Road, Ilmenau, Germany', '056-2444437', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498799, 'Toni  Atlas', '81st Street, Yamagata, Japan', '057-4684889', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498800, 'Miguel  Spine', '917 Evanswood, Media, USA', '059-2393630', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498801, 'Howie  Mahood', '57 Martin Street, Richardson, USA', '056-8187411', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498802, 'Vincent  Kinney', '13 Sal Street, Berkshire, United Kingdom', '055-2660246', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498803, 'Miguel  Moore', '77 Dafoe Road, Ilmenau, Germany', '059-1903547', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498804, 'Fionnula  Costner', '24 Kristofferson Road, Aurora, USA', '053-9001183', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498805, 'Balthazar  Kotto', '918 Rebeka Blvd, Mײ³ֲ¶nchengladbach, Germany', '058-2290436', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498806, 'Bernie  Portman', '57 Knoxville Drive, Burwood East, Australia', '050-9765531', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498807, 'Jean  Pepper', '56 Hartnett Street, Issaquah, USA', '056-5240521', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498808, 'Luis  Noseworthy', '312 Fierstein Drive, Baarn, Netherlands', '054-3734797', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498809, 'Eddie  Baez', '619 Shannyn Street, Turku, Finland', '057-9650222', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498810, 'Natacha  Burns', '32 Tilly Street, Waterloo, Canada', '053-5820448', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498811, 'Wang  Feliciano', '32 Harris Road, Clark, USA', '052-9233134', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498812, 'Powers  Connelly', '22 Twilley Drive, Mountain View, USA', '050-3384974', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498813, 'Vickie  Emmett', '8 Branch, Luedenscheid, Germany', '050-2502720', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498814, 'Mark  Fehr', '55 Elizabeth Ave, Englewood, USA', '058-3188510', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498815, 'Philip  Russell', '96 Jerry Street, Oshawa, Canada', '054-8415957', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498816, 'Lionel  Kenoly', '58 Napolitano Road, Fountain Hills, USA', '051-1902750', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498817, 'Sonny  Randal', '32 Buffalo Blvd, Bradenton, USA', '052-8183038', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498818, 'Fats  Shelton', '486 Rick Road, Johor Bahru, Malaysia', '056-4057051', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498819, 'Gladys  Iglesias', '98 Cromwell Road, Sidney, Canada', '053-8037802', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498820, 'Patti  Kenoly', '13rd Street, Chapel hill, USA', '050-9364305', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498821, 'Anne  McGowan', '52 Bello Drive, Debary, USA', '056-8947527', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498822, 'Kasey  Berkeley', '125 Russell, Appenzell, Switzerland', '051-7791492', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498823, 'Isaac  Khan', '39 Madsen Blvd, Pusan-city, South Korea', '052-8811746', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498824, 'Martha  Ronstadt', '92nd Street, Charlottesville, USA', '059-7211557', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498825, 'Jim  Cobbs', '97 Cervine Ave, St Jean de Soudain, France', '050-3653705', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498826, 'Miko  Oldman', '3 Ripley Street, Geneva, Switzerland', '057-1830909', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498827, 'Rachel  Sherman', '62 Carlin Road, Reno, USA', '054-2898543', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498828, 'Judge  Cetera', '55 Balk Street, Westfield, USA', '051-7626941', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498829, 'Fiona  Raye', '13 Richardson Street, Mogliano Veneto, Italy', '055-6467430', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498830, 'Jane  Wells', '60 Gina Street, Valladolid, Spain', '053-4227450', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498831, 'Anthony  Moraz', '38 Hawthorne Street, Saint-vincent-de-dur, France', '058-9005143', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498832, 'Sarah  McCain', '35 Smith Road, Boston, USA', '054-9867442', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498833, 'Joaquim  Theron', '448 Redwood City Road, Annandale, USA', '058-7469622', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498834, 'Crispin  McFadden', '12nd Street, Mapo-gu, South Korea', '059-1685614', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498835, 'Chuck  Swinton', '478 Jones Ave, San Jose, USA', '058-8114911', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498836, 'Toni  Rosas', '77 Bad Camberg Street, South Weber, USA', '054-5967657', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498837, 'Mandy  Diehl', '7 Malmײ³ֲ¶ Street, Tilst, Denmark', '052-3910565', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498838, 'King  Wheel', '68 Fonda Drive, Bischofshofen, Austria', '052-5335569', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498839, 'Malcolm  McCracken', '49 Prinze Road, Utsunomiya, Japan', '058-1984699', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498840, 'Barbara  Alston', '64 Danes Road, Gothenburg, Sweden', '055-2255462', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498841, 'Heather  Dillane', '49 Sissy Drive, Slough, United Kingdom', '051-3102600', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498842, 'Casey  Moriarty', '72nd Street, Kerava, Finland', '054-7771625', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498843, 'Debi  Nelson', '16 Carter Street, Denver, USA', '058-4644253', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498844, 'Nicolas  Barnett', '60 Northam Drive, Sorocaba, Brazil', '053-2555517', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498845, 'Lou  Logue', '387 O''Sullivan Ave, Livermore, USA', '054-7716112', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498846, 'Cornell  Marin', '22 Fair Lawn Drive, Glendale, USA', '053-7390232', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498847, 'King  de Lancie', '4 Nicks Street, Park Ridge, USA', '050-9884717', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498848, 'Ty  Knight', '54 Ebersdorf Road, Guamo, Italy', '054-2915455', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498849, 'Dabney  Phillips', '2 Gavin Ave, Santana do parnaײ³ֲ­ba, Brazil', '050-8150259', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498850, 'Tilda  Schneider', '97 Chely Street, Brugherio, Italy', '056-3773028', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498851, 'Nikki  Warwick', '78 Shaw Street, Roanoke, USA', '050-7034711', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498852, 'Minnie  Supernaw', '92nd Street, Slmea, USA', '050-1658766', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498853, 'Boz  Gershon', '76 Liquid Blvd, Glen Cove, USA', '052-7908712', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498854, 'Lesley  Fisher', '301 Mira Ave, Sendai, Japan', '052-7191154', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498855, 'Ricardo  Hirsch', '20 Potter Drive, Brampton, Canada', '051-6649638', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498856, 'Christopher  Arkenstone', '23 Rebeka Street, Livermore, USA', '055-7162322', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498857, 'Lily  Marx', '395 Hamburg Street, Oak Park, USA', '055-3294618', 'false');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498858, 'Rosie  Stevenson', '45 Tanon Blvd, Miami, USA', '054-1966758', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498859, 'Ruth  Jordan', '44 Oldham Street, Flower mound, USA', '052-2649360', 'true');
insert into DONORS (did, dname, address, phonenumber, premium)
values (322498860, 'Rascal  Vance', '91st Street, Hackensack, USA', '051-3755533', 'true');
commit;
prompt 400 records loaded
prompt Loading EQUIPMENT...
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10000, 'cotton balls', 'true', 458, 261.2, 26);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10001, 'face mask', 'true', 540, 319.33, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10002, 'emergency blanket', 'true', 362, 144.7, 29);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10003, 'instant glucose', 'true', 0, 401.3, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10004, 'emergency whistle', 'true', 9, 347.72, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10005, 'emergency blanket', 'true', 343, 153.77, 14);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10006, 'medical shears', 'true', 586, 317.04, 23);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10007, 'burn gel', 'true', 553, 203.3, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10008, 'splints', 'true', 333, 326.6, 6);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10009, 'emergency radio', 'true', 500, 130.62, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10010, 'elastic bandage', 'true', 553, 413.7, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10011, 'emergency radio', 'true', 353, 126.5, 3);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10012, 'cotton balls', 'true', 336, 490.45, 24);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10013, 'emergency blanket', 'true', 357, 342.63, 12);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10014, 'medical tape', 'true', 473, 371.08, 13);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10015, 'instant glucose', 'true', 550, 336.75, 14);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10016, 'antiseptic wipes', 'true', 469, 338.26, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10017, 'splinter remover', 'true', 339, 181.51, 16);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10018, 'tourniquet', 'true', 334, 109.67, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10019, 'adhesive tape', 'true', 561, 227.8, 17);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10020, 'emergency blanket', 'true', 587, 34.29, 13);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10021, 'bandages', 'true', 361, 64.32, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10022, 'alcohol swabs', 'true', 318, 392.56, 27);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10023, 'instant glucose', 'true', 407, 440.29, 14);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10024, 'ice pack', 'true', 320, 210.7, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10025, 'medical scissors', 'true', 540, 260.45, 29);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10026, 'bandages', 'true', 422, 96.98, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10027, 'burn dressing', 'true', 495, 219.66, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10028, 'splinter remover', 'true', 584, 330.06, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10029, 'triangular bandage', 'true', 360, 326.07, 17);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10030, 'disposable gloves', 'true', 521, 302.39, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10031, 'scissors', 'true', 332, 480.91, 13);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10032, 'elastic bandage', 'true', 319, 282.83, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10033, 'adhesive tape', 'true', 526, 260.04, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10034, 'splinter remover', 'true', 431, 480.3, 13);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10035, 'thermometer', 'true', 340, 455.58, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10036, 'scissors', 'true', 383, 289.87, 23);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10037, 'sterile gauze', 'true', 395, 178.98, 24);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10038, 'emergency blanket', 'true', 410, 232.66, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10039, 'compression bandage', 'true', 460, 499.81, 27);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10040, 'burn dressing', 'true', 519, 209.19, 12);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10041, 'medical tape', 'true', 578, 215.6, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10042, 'cotton balls', 'true', 533, 94.05, 26);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10043, 'cpr mask', 'true', 463, 26.17, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10044, 'splinter remover', 'true', 557, 297.62, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10045, 'instant glucose', 'true', 316, 288.11, 27);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10046, 'burn dressing', 'true', 358, 395.18, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10047, 'adhesive tape', 'true', 418, 393.43, 18);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10048, 'burn dressing', 'true', 472, 485.77, 3);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10049, 'splints', 'true', 439, 187.31, 26);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10050, 'triangular bandage', 'true', 349, 397.23, 16);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10051, 'splinter remover', 'true', 517, 336.82, 23);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10052, 'burn dressing', 'true', 599, 435.43, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10053, 'burn cream', 'true', 410, 471.2, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10054, 'emergency blanket', 'true', 596, 29.05, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10055, 'cotton balls', 'true', 481, 149.9, 7);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10056, 'emergency whistle', 'true', 591, 31.31, 3);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10057, 'tongue depressors', 'true', 474, 160.01, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10058, 'compression bandage', 'true', 474, 172.71, 3);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10059, 'elastic bandage', 'true', 527, 230, 16);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10060, 'tourniquet', 'true', 386, 73.51, 29);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10061, 'eye patch', 'true', 591, 279.5, 20);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10062, 'tourniquet', 'true', 399, 424.73, 7);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10063, 'emergency glow sticks', 'true', 517, 278.79, 3);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10064, 'snake bite kit', 'true', 749, 91.06, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10065, 'eye patch', 'true', 341, 30.78, 27);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10066, 'emergency whistle', 'true', 332, 118.34, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10067, 'burn cream', 'true', 368, 411.78, 16);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10068, 'splinter remover', 'true', 521, 185.5, 6);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10069, 'emergency glow sticks', 'true', 343, 326.71, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10070, 'emergency blanket', 'true', 462, 320.58, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10071, 'bandages', 'true', 585, 276.86, 12);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10072, 'sterile gauze', 'true', 397, 137.27, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10073, 'eye patch', 'true', 493, 190.56, 5);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10074, 'gauze pads', 'true', 557, 170.29, 27);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10075, 'tweezers', 'true', 436, 327.98, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10076, 'elastic bandage', 'true', 510, 56.54, 12);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10077, 'compression bandage', 'true', 391, 194.47, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10078, 'cpr mask', 'true', 460, 296.8, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10079, 'burn dressing', 'true', 521, 162.94, 13);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10080, 'splinter remover', 'true', 435, 468.59, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10081, 'tourniquet', 'true', 450, 183.74, 23);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10082, 'tourniquet', 'true', 493, 60.88, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10083, 'snake bite kit', 'true', 449, 352.79, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10084, 'snake bite kit', 'true', 382, 404.87, 20);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10085, 'instant heat pack', 'true', 319, 125.26, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10086, 'instant heat pack', 'true', 531, 224.8, 18);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10087, 'safety pins', 'true', 419, 246.14, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10088, 'instant heat pack', 'true', 517, 490.45, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10089, 'medical scissors', 'true', 318, 357.22, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10090, 'compression bandage', 'true', 357, 55.06, 23);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10091, 'sterile gauze', 'true', 510, 407.83, 21);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10092, 'burn cream', 'true', 499, 125.59, 14);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10093, 'instant cold pack', 'true', 565, 391.96, 14);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10094, 'emergency glow sticks', 'true', 587, 480.98, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10095, 'emergency blanket', 'true', 480, 15.49, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10096, 'splints', 'true', 496, 323.19, 18);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10097, 'emergency blanket', 'true', 369, 439.71, 5);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10098, 'snake bite kit', 'true', 565, 330.65, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10099, 'splints', 'true', 470, 221.05, 30);
commit;
prompt 100 records committed...
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10100, 'emergency blanket', 'true', 303, 322.39, 16);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10101, 'eye patch', 'true', 344, 241.99, 2);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10102, 'splinter remover', 'true', 521, 310.02, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10103, 'compression bandage', 'true', 426, 117.92, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10104, 'disposable gloves', 'true', 448, 99.47, 29);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10105, 'emergency whistle', 'true', 396, 158.68, 12);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10106, 'emergency blanket', 'true', 506, 364.12, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10107, 'burn dressing', 'true', 358, 360.06, 18);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10108, 'bandages', 'true', 409, 358.53, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10109, 'emergency radio', 'true', 549, 265.38, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10110, 'elastic bandage', 'true', 376, 197.8, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10111, 'burn gel', 'true', 505, 334.57, 27);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10112, 'burn dressing', 'true', 475, 366.81, 29);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10113, 'eye patch', 'true', 439, 470.83, 27);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10114, 'instant cold pack', 'true', 494, 49.58, 14);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10115, 'emergency radio', 'true', 370, 431.94, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10116, 'adhesive tape', 'true', 403, 338.34, 27);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10117, 'instant glucose', 'true', 383, 125.25, 24);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10118, 'scissors', 'true', 536, 304.62, 2);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10119, 'cpr mask', 'true', 364, 225.46, 21);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10120, 'thermometer', 'true', 415, 372.54, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10121, 'instant glucose', 'true', 513, 193.68, 2);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10122, 'scissors', 'true', 429, 64.13, 6);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10123, 'instant cold pack', 'true', 391, 365.14, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10124, 'medical scissors', 'true', 427, 260.91, 2);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10125, 'burn gel', 'true', 421, 469.94, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10126, 'emergency radio', 'true', 502, 231.87, 6);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10127, 'splinter remover', 'true', 543, 328.4, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10128, 'adhesive tape', 'true', 511, 134.75, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10129, 'snake bite kit', 'true', 528, 168.42, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10130, 'tourniquet', 'true', 568, 95.94, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10131, 'snake bite kit', 'true', 318, 176.06, 26);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10132, 'compression bandage', 'true', 542, 155.02, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10133, 'tourniquet', 'true', 316, 377.78, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10134, 'tweezers', 'true', 464, 354.87, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10135, 'eye patch', 'true', 538, 432.35, 24);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10136, 'safety pins', 'true', 595, 171.34, 5);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10137, 'burn gel', 'true', 558, 426.23, 24);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10138, 'cotton balls', 'true', 519, 139.99, 16);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10139, 'emergency blanket', 'true', 512, 412.77, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10140, 'gauze pads', 'true', 525, 405.04, 18);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10141, 'medical shears', 'true', 379, 288.12, 6);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10142, 'instant glucose', 'true', 386, 94.12, 26);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10143, 'surgical gloves', 'true', 534, 352.78, 6);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10144, 'ice pack', 'true', 597, 29.42, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10145, 'instant glucose', 'true', 495, 386.12, 7);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10146, 'splinter remover', 'true', 323, 96.14, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10147, 'snake bite kit', 'true', 541, 496.81, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10148, 'tweezers', 'true', 372, 171.72, 7);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10149, 'elastic bandage', 'true', 333, 177.02, 29);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10150, 'burn cream', 'true', 475, 310.85, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10151, 'emergency glow sticks', 'true', 532, 398.07, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10152, 'medical scissors', 'true', 455, 32.86, 6);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10153, 'emergency blanket', 'true', 370, 340.28, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10154, 'medical tape', 'true', 400, 227.42, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10155, 'emergency blanket', 'true', 373, 48.92, 16);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10156, 'tongue depressors', 'true', 319, 217.93, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10157, 'safety pins', 'true', 541, 294.52, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10158, 'snake bite kit', 'true', 327, 15.38, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10159, 'emergency whistle', 'true', 455, 498.31, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10160, 'instant glucose', 'true', 393, 228.06, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10161, 'cpr mask', 'true', 373, 254.64, 7);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10162, 'gauze pads', 'true', 590, 233.15, 13);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10163, 'gauze pads', 'true', 316, 320.39, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10164, 'bandages', 'true', 582, 337.64, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10165, 'splinter remover', 'true', 528, 67.99, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10166, 'emergency flashlight', 'true', 482, 94.95, 20);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10167, 'disposable gloves', 'true', 322, 83.74, 3);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10168, 'emergency glow sticks', 'true', 512, 430.86, 20);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10169, 'emergency whistle', 'true', 306, 320.82, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10170, 'cpr mask', 'true', 388, 160.25, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10171, 'antiseptic wipes', 'true', 435, 142.78, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10172, 'emergency flashlight', 'true', 534, 397.84, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10173, 'splinter remover', 'true', 556, 275.24, 26);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10174, 'scissors', 'true', 381, 50.49, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10175, 'safety pins', 'true', 568, 68.49, 21);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10176, 'gauze pads', 'true', 418, 460.03, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10177, 'alcohol swabs', 'true', 534, 144.64, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10178, 'cpr mask', 'true', 319, 435.69, 29);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10179, 'elastic bandage', 'true', 511, 472.58, 7);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10180, 'emergency blanket', 'true', 381, 424.14, 7);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10181, 'medical tape', 'true', 475, 328.51, 20);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10182, 'burn dressing', 'true', 413, 132.19, 23);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10183, 'sterile gauze', 'true', 422, 83.52, 14);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10184, 'medical tape', 'true', 346, 268.59, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10185, 'instant glucose', 'true', 311, 226.38, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10186, 'adhesive tape', 'true', 360, 305.54, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10187, 'cotton balls', 'true', 595, 255.23, 27);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10188, 'snake bite kit', 'true', 364, 236, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10189, 'eye patch', 'true', 541, 397.26, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10190, 'snake bite kit', 'true', 354, 258.53, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10191, 'tongue depressors', 'true', 598, 298, 7);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10192, 'tongue depressors', 'true', 419, 198.44, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10193, 'scissors', 'true', 556, 487.3, 27);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10194, 'emergency whistle', 'true', 404, 221.9, 20);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10195, 'emergency flashlight', 'true', 393, 468.18, 24);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10196, 'emergency blanket', 'true', 360, 369.38, 14);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10197, 'burn cream', 'true', 444, 63.68, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10198, 'cotton balls', 'true', 386, 73.28, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10199, 'face mask', 'true', 314, 86.73, 30);
commit;
prompt 200 records committed...
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10200, 'instant glucose', 'true', 362, 102.97, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10201, 'compression bandage', 'true', 416, 475.79, 7);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10202, 'burn gel', 'true', 452, 260.37, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10203, 'tweezers', 'true', 477, 494.12, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10204, 'burn gel', 'true', 387, 252.37, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10205, 'eye patch', 'true', 578, 57.28, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10206, 'surgical gloves', 'true', 562, 444.06, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10207, 'elastic bandage', 'true', 566, 195.52, 12);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10208, 'surgical gloves', 'true', 475, 130.05, 14);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10209, 'cpr mask', 'true', 361, 84.13, 17);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10210, 'medical tape', 'true', 326, 315.96, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10211, 'emergency flashlight', 'true', 448, 367.91, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10212, 'burn gel', 'true', 504, 418.09, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10213, 'burn gel', 'true', 329, 29.7, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10214, 'antiseptic wipes', 'true', 493, 53.95, 20);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10215, 'emergency flashlight', 'true', 340, 42.9, 24);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10216, 'cpr mask', 'true', 432, 477.99, 2);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10217, 'alcohol swabs', 'true', 466, 421.35, 23);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10218, 'emergency whistle', 'true', 593, 367.25, 7);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10219, 'scissors', 'true', 376, 124.33, 7);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10220, 'instant heat pack', 'true', 414, 135.2, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10221, 'burn dressing', 'true', 514, 133.7, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10222, 'tweezers', 'true', 475, 384.64, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10223, 'emergency flashlight', 'true', 473, 22.04, 20);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10224, 'thermometer', 'true', 536, 218.62, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10225, 'elastic bandage', 'true', 581, 266.81, 17);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10226, 'triangular bandage', 'true', 566, 244.16, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10227, 'medical shears', 'true', 313, 48.6, 12);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10228, 'emergency blanket', 'true', 394, 331.11, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10229, 'sterile gauze', 'true', 310, 176.68, 3);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10230, 'splints', 'true', 367, 241.83, 21);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10231, 'disposable gloves', 'true', 356, 410.26, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10232, 'emergency blanket', 'true', 333, 376, 20);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10233, 'emergency whistle', 'true', 500, 174.59, 23);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10234, 'adhesive tape', 'true', 511, 457.26, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10235, 'surgical gloves', 'true', 494, 227.44, 2);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10236, 'eye patch', 'true', 300, 475.78, 29);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10237, 'safety pins', 'true', 486, 60.5, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10238, 'eye patch', 'true', 553, 283.32, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10239, 'emergency flashlight', 'true', 443, 110.15, 6);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10240, 'antiseptic wipes', 'true', 375, 175.96, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10241, 'emergency whistle', 'true', 526, 336.87, 3);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10242, 'medical tape', 'true', 461, 27.73, 12);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10243, 'medical tape', 'true', 598, 410.05, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10244, 'emergency radio', 'true', 539, 356.85, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10245, 'emergency flashlight', 'true', 442, 409.58, 20);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10246, 'sterile eye wash', 'true', 487, 309.28, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10247, 'adhesive tape', 'true', 562, 313.59, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10248, 'surgical gloves', 'true', 521, 55.57, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10249, 'safety pins', 'true', 321, 116.77, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10250, 'emergency blanket', 'true', 393, 353.59, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10251, 'safety pins', 'true', 314, 224.92, 17);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10252, 'emergency whistle', 'true', 563, 63.84, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10253, 'tongue depressors', 'true', 310, 64.24, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10254, 'elastic bandage', 'true', 333, 480.15, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10255, 'sterile eye wash', 'true', 354, 317.12, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10256, 'tongue depressors', 'true', 510, 42.28, 23);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10257, 'emergency radio', 'true', 341, 357.64, 3);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10258, 'compression bandage', 'true', 578, 208.05, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10259, 'antiseptic wipes', 'true', 370, 255.47, 5);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10260, 'burn cream', 'true', 317, 483.23, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10261, 'instant heat pack', 'true', 458, 425.65, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10262, 'snake bite kit', 'true', 461, 204.14, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10263, 'emergency flashlight', 'true', 451, 472.92, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10264, 'splinter remover', 'true', 390, 378.41, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10265, 'splinter remover', 'true', 484, 216.55, 2);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10266, 'face mask', 'true', 335, 209.43, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10267, 'instant glucose', 'true', 576, 253.42, 21);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10268, 'instant glucose', 'true', 340, 342.13, 6);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10269, 'triangular bandage', 'true', 434, 369.77, 14);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10270, 'burn gel', 'true', 378, 189.08, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10271, 'burn cream', 'true', 510, 464.54, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10272, 'cotton balls', 'true', 364, 431.84, 24);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10273, 'medical shears', 'true', 395, 426.55, 17);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10274, 'instant glucose', 'true', 439, 478.39, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10275, 'medical tape', 'true', 412, 98.84, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10276, 'cotton balls', 'true', 368, 144.8, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10277, 'burn dressing', 'true', 426, 375.8, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10278, 'emergency flashlight', 'true', 476, 355.28, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10279, 'emergency flashlight', 'true', 376, 451.22, 13);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10280, 'eye patch', 'true', 434, 285.91, 12);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10281, 'emergency blanket', 'true', 398, 443.76, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10282, 'bandages', 'true', 312, 238.6, 27);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10283, 'instant cold pack', 'true', 498, 71.92, 13);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10284, 'scissors', 'true', 307, 388.84, 16);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10285, 'surgical gloves', 'true', 511, 131.12, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10286, 'emergency flashlight', 'true', 308, 400.98, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10287, 'sterile eye wash', 'true', 576, 128.41, 13);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10288, 'burn gel', 'true', 458, 255.7, 24);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10289, 'bandages', 'true', 474, 226.65, 23);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10290, 'medical tape', 'true', 479, 356.57, 5);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10291, 'medical tape', 'true', 413, 166.01, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10292, 'thermometer', 'true', 315, 382.2, 18);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10293, 'splinter remover', 'true', 538, 445.11, 16);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10294, 'splinter remover', 'true', 327, 65.98, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10295, 'instant glucose', 'true', 427, 242, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10296, 'emergency glow sticks', 'true', 350, 246.82, 3);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10297, 'instant heat pack', 'true', 436, 221.43, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10298, 'burn cream', 'true', 427, 125.35, 12);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10299, 'snake bite kit', 'true', 541, 161.75, 23);
commit;
prompt 300 records committed...
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10300, 'cpr mask', 'true', 585, 212.16, 3);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10301, 'burn cream', 'true', 555, 389.43, 27);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10302, 'alcohol swabs', 'true', 440, 479.9, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10303, 'emergency flashlight', 'true', 387, 211.04, 13);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10304, 'tongue depressors', 'true', 439, 294.81, 12);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10305, 'surgical gloves', 'true', 405, 74.38, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10306, 'safety pins', 'true', 361, 134.23, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10307, 'snake bite kit', 'true', 365, 139.03, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10308, 'thermometer', 'true', 533, 488.85, 21);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10309, 'emergency glow sticks', 'true', 383, 301.49, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10310, 'burn gel', 'true', 408, 139.49, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10311, 'compression bandage', 'true', 326, 419.61, 5);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10312, 'surgical gloves', 'true', 573, 296.18, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10313, 'antiseptic wipes', 'true', 338, 399.94, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10314, 'tourniquet', 'true', 375, 493.58, 16);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10315, 'tongue depressors', 'true', 484, 449.8, 26);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10316, 'burn gel', 'true', 518, 56.26, 17);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10317, 'sterile gauze', 'true', 559, 324.92, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10318, 'emergency blanket', 'true', 597, 98.54, 16);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10319, 'medical scissors', 'true', 327, 443.32, 2);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10320, 'medical scissors', 'true', 380, 392.8, 24);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10321, 'splinter remover', 'true', 476, 34.66, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10322, 'medical scissors', 'true', 561, 160.08, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10323, 'splinter remover', 'true', 471, 149.36, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10324, 'medical shears', 'true', 428, 301.08, 29);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10325, 'emergency flashlight', 'true', 353, 356.72, 6);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10326, 'emergency radio', 'true', 314, 117.69, 29);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10327, 'snake bite kit', 'true', 505, 302.94, 26);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10328, 'first aid manual', 'true', 400, 271.08, 12);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10329, 'bandages', 'true', 385, 288.77, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10330, 'snake bite kit', 'true', 580, 427.84, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10331, 'alcohol swabs', 'true', 481, 445.23, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10332, 'instant cold pack', 'true', 369, 301.1, 5);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10333, 'splints', 'true', 523, 311.02, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10334, 'thermometer', 'true', 540, 423.45, 24);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10335, 'surgical gloves', 'true', 590, 470.15, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10336, 'emergency flashlight', 'true', 325, 134.42, 5);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10337, 'face mask', 'true', 381, 450.88, 5);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10338, 'emergency blanket', 'true', 490, 445.32, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10339, 'burn gel', 'true', 492, 462.38, 7);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10340, 'medical scissors', 'true', 498, 443.57, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10341, 'snake bite kit', 'true', 356, 366.7, 17);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10342, 'tongue depressors', 'true', 308, 215.33, 16);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10343, 'burn gel', 'true', 593, 311.1, 3);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10344, 'splints', 'true', 596, 418.44, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10345, 'emergency whistle', 'true', 452, 381.48, 20);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10346, 'medical shears', 'true', 595, 479.15, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10347, 'emergency flashlight', 'true', 346, 377.49, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10348, 'emergency glow sticks', 'true', 463, 309.9, 13);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10349, 'gauze pads', 'true', 367, 256.53, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10350, 'eye patch', 'true', 523, 55.17, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10351, 'emergency whistle', 'true', 483, 417.98, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10352, 'splints', 'true', 576, 347.46, 13);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10353, 'first aid manual', 'true', 328, 70.68, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10354, 'safety pins', 'true', 456, 422.09, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10355, 'snake bite kit', 'true', 564, 127.86, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10356, 'medical scissors', 'true', 430, 131.65, 3);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10357, 'emergency whistle', 'true', 501, 430.66, 9);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10358, 'burn gel', 'true', 404, 98.78, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10359, 'medical scissors', 'true', 321, 186.39, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10360, 'first aid manual', 'true', 534, 210.73, 6);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10361, 'sterile gauze', 'true', 375, 286.44, 22);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10362, 'burn cream', 'true', 420, 98.02, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10363, 'antiseptic wipes', 'true', 491, 349.09, 24);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10364, 'thermometer', 'true', 554, 348.56, 5);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10365, 'burn dressing', 'true', 491, 287.35, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10366, 'splinter remover', 'true', 578, 175.71, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10367, 'instant glucose', 'true', 474, 282.72, 14);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10368, 'emergency radio', 'true', 501, 442.07, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10369, 'safety pins', 'true', 535, 403.11, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10370, 'sterile eye wash', 'true', 305, 117.43, 2);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10371, 'emergency whistle', 'true', 488, 289.17, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10372, 'antiseptic wipes', 'true', 588, 151.22, 14);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10373, 'antiseptic wipes', 'true', 550, 321.36, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10374, 'emergency blanket', 'true', 354, 366.78, 4);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10375, 'splints', 'true', 421, 80.39, 26);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10376, 'snake bite kit', 'true', 311, 488.99, 8);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10377, 'antiseptic wipes', 'true', 454, 143.96, 2);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10378, 'burn dressing', 'true', 460, 440.8, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10379, 'emergency radio', 'true', 326, 339.31, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10380, 'burn cream', 'true', 300, 430.38, 27);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10381, 'emergency blanket', 'true', 559, 346.14, 17);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10382, 'splinter remover', 'true', 323, 159.7, 20);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10383, 'sterile eye wash', 'true', 556, 175.28, 23);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10384, 'emergency glow sticks', 'true', 598, 49.76, 18);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10385, 'eye patch', 'true', 459, 77.68, 28);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10386, 'first aid manual', 'true', 320, 97.4, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10387, 'burn gel', 'true', 337, 415.57, 6);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10388, 'medical tape', 'true', 394, 116.76, 7);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10389, 'tongue depressors', 'true', 564, 98.42, 2);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10390, 'emergency flashlight', 'true', 578, 440.2, 13);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10391, 'medical scissors', 'true', 464, 471.72, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10392, 'face mask', 'true', 445, 343.29, 25);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10393, 'bandages', 'true', 428, 189.51, 11);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10394, 'cpr mask', 'true', 520, 265.75, 30);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10395, 'emergency flashlight', 'true', 379, 488.51, 19);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10396, 'burn dressing', 'true', 450, 467.88, 20);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10397, 'tweezers', 'true', 364, 347.04, 10);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10398, 'bandages', 'true', 416, 281.12, 15);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10399, 'instant glucose', 'true', 535, 474.4, 18);
commit;
prompt 400 records committed...
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10400, 'Blood portion refrigerator', 'false', 80, 800.99, null);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10401, 'CPR training mannequin', 'false', 50, 108.35, null);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10402, 'weight', 'false', 50, 97.56, null);
insert into EQUIPMENT (eid, ename, ismobile, quantity, price, required_in_vehicle)
values (10403, 'Blood donation needle', 'false', 300, 150.45, null);
commit;
prompt 404 records loaded
prompt Loading SUPPLIERS...
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (111111111, 'ANI ZIUFE', '51 Kennedy Street, Sevilla, Spain', '053-4091793');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864931, 'Colin Foxx', '93rd Street, Bischofshofen, Austria', '059-8940705');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864732, 'Bret Boorem', '47 Sona Road, Elkins Park, USA', '056-2280730');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864733, 'Lili Clooney', '57 Griffith Road, Ciudad del Este, Paraguay', '057-4274459');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864734, 'Katie DeLuise', '54 Marlboro Road, Verdun, Canada', '051-1854233');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864735, 'Pierce Englund', '95 Manning Street, Ebersdorf, Germany', '052-2342493');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864736, 'Halle Hagerty', '91 Bacharach Street, Greenville, USA', '056-3595375');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864737, 'Suzanne James', '27 Flushing Street, S. Bernardo do Campo, Brazil', '056-3971617');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864738, 'First Giamatti', '60 Donna Street, Telford, United Kingdom', '055-5558053');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864739, 'Yaphet Smurfit', '74 Aaron Blvd, Indianapolis, USA', '052-8882118');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864740, 'Juliana DiCaprio', '66 Gano Street, Osaka, Japan', '057-2818375');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864741, 'Nicholas David', '996 Vai Road, Rueil-Malmaison, France', '057-6041137');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864742, 'Kitty Brock', '90 Harmon Road, Milano, Italy', '058-6255840');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864743, 'Jann Flack', '459 Kitty Street, Berkshire, United Kingdom', '059-3991795');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864744, 'Victor Watley', '973 Jill Street, Kuopio, Finland', '055-9473966');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864745, 'Javon Perry', '264 Mac Street, Vienna, Austria', '054-4455310');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864746, 'Stephen Mills', '69 Dennis Road, Or-yehuda, Israel', '052-8395335');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864747, 'Praga Craig', '474 Chuck Street, Lenexa, USA', '055-6374185');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864748, 'Tilda Dern', '902 Reeve Road, Mײ³ֲ¶nchengladbach, Germany', '050-3806780');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864749, 'Roddy Hopkins', '31 Howard Road, Karlsruhe, Germany', '052-2851780');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864750, 'Carrie Gyllenhaal', '10 Schreiber Street, Foster City, USA', '054-7620221');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864751, 'Woody Chesnutt', '56 Sylvian Blvd, Mobile, USA', '050-3969973');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864752, 'Ethan Broza', '10 Turner Street, Maidenhead, United Kingdom', '055-2493723');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864753, 'Faye Idle', '39 Coe Blvd, Pomona, USA', '051-3568934');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864754, 'Lindsay Strathairn', '96 Buffalo Drive, Lengdorf, Germany', '051-7298853');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864755, 'Jessica Cleary', '42 Ittigen Street, Sydney, Australia', '053-4798382');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864756, 'Nelly Cocker', '54 Research Triangle, Winnipeg, Canada', '059-3371639');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864757, 'Deborah Fender', '65 Loveless Street, Shizuoka, Japan', '050-7580667');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864758, 'Marisa Sandoval', '67 Vaughan Street, London, Canada', '057-7254208');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864759, 'Adrien Ellis', '81st Street, Fornacette, Italy', '053-2573444');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864760, 'Carlos Saxon', '61st Street, Clark, USA', '050-1632094');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864761, 'Nigel Bryson', '12nd Street, Albany, USA', '050-6934875');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864762, 'Udo Arquette', '63 Richmond Street, Taipei, Taiwan', '052-5222886');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864763, 'Alan Wakeling', '543 Olivette Road, South Weber, USA', '051-6838297');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864764, 'Rik Harris', '3 Branch Street, San Francisco, USA', '050-3941852');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864765, 'Harvey Clayton', '35 Lea Street, Darmstadt, Germany', '056-1689650');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864766, 'Howard Whitford', '23 Cuenca Road, Thalwil, Switzerland', '058-6631050');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864767, 'Crystal Dourif', '82nd Street, Shoreline, USA', '053-6906952');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864768, 'Miranda Newman', '84 Natascha Blvd, Grand-mere, Canada', '058-7106105');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864769, 'Edwin Cornell', '88 Williamson, Adelaide, Australia', '058-9907773');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864770, 'Stephen Stevens', '16 Nolte Road, Hochwald, Switzerland', '053-6234277');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864771, 'Scott Payne', '79 Spencer Street, Mountain View, USA', '056-1772545');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864772, 'Sydney Giraldo', '21 Coolidge Road, Bolton, Canada', '052-7782092');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864773, 'Aidan Utada', '51 Griggs, Grapevine, USA', '056-4139314');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864774, 'Solomon Macy', '63 Patti Street, Cannock, United Kingdom', '057-1467790');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864775, 'Miles Bancroft', '99 Rains Drive, Northampton, United Kingdom', '054-7955036');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864776, 'Brendan Rea', '37 Allen Street, Highton, Australia', '056-7417350');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864777, 'Raul Parsons', '7 Jesus Blvd, Gersthofen, Germany', '050-8381590');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864778, 'Art Marshall', '115 Laurie Street, Thײ³ֲ¶rishaus, Switzerland', '059-4094729');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864779, 'Anna Singh', '17 Willard Road, Paal Beringen, Belgium', '050-8145458');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864780, 'Suzanne Tempest', '90 McCabe Drive, Bend, USA', '052-2708603');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864781, 'Armin Shannon', '809 Gold Street, Padova, Italy', '055-2211039');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864782, 'Kurt Murray', '2 Maura Street, Milsons Point, Australia', '051-5460988');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864783, 'Bryan Stowe', '52nd Street, La Plata, Argentina', '058-4641261');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864784, 'Josh Schiff', '35 Lopez Road, Chorzײ³ֲ³w, Poland', '058-5056055');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864785, 'Taye Bullock', '23 Levy Drive, Oklahoma city, USA', '052-6320413');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864786, 'Wade Nivola', '85 Owen Road, Hampton, USA', '057-9482507');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864787, 'Mint Jane', '99 Chappelle Drive, Colombo, Sri lanka', '058-8980501');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864788, 'Derrick Wakeling', '42 Paul Drive, Pompton Plains, USA', '059-8030777');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864789, 'Jeroen Favreau', '74 Torn Drive, Stanford, USA', '050-6436315');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864790, 'Praga Bogguss', '26 Warren Street, Wײ³ֲ¶rth, Germany', '059-1901020');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864791, 'Geggy Chilton', '18 Sarasota Street, Taoyuan, Taiwan', '059-6591621');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864792, 'Terrence Boone', '85 Mark Drive, Ferraz  vasconcelos, Brazil', '055-3982990');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864793, 'Pam Quinones', '21 Biel Ave, Bischofshofen, Austria', '057-6535904');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864794, 'Rolando Copeland', '993 Marshall Blvd, Trento, Italy', '053-5711774');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864795, 'Stellan Lemmon', '31 Bright Road, Irvine, USA', '056-2252288');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864796, 'Betty Crowell', '73 Aidan, Bloomington, USA', '054-7880509');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864797, 'Percy Vicious', '42 Gladys Drive, Dalmine, Italy', '056-3009059');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864798, 'Cloris Karyo', '68 Gliwice Blvd, Kista, Sweden', '059-8676626');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864799, 'Michelle Pollack', '5 Winwood Blvd, Augst, Switzerland', '053-9555696');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864800, 'Pam Hersh', '79 Pryce Drive, Perth, Australia', '057-2963805');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864801, 'Oded Schiavelli', '57 Slater Road, Lancaster, USA', '058-2553851');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864802, 'Shannyn Sossamon', '4 Wolf Drive, Darmstadt, Germany', '056-2697046');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864803, 'Linda Brickell', '56 Kieran Street, Hines, USA', '058-1886793');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864804, 'Leslie Miller', '43rd Street, Lancaster, USA', '052-4946262');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864805, 'Joshua Dayne', '80 Offenburg, Shenzhen, China', '059-3665934');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864806, 'Greg Elizondo', '2 Diggs Road, Leipzig, Germany', '057-3983976');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864807, 'CeCe Farris', '6 Suchet Road, Santiago, Chile', '056-4910182');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864808, 'Trini Sarsgaard', '50 Krabbe Drive, Sursee, Switzerland', '050-1801865');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864809, 'Sally Chung', '32 James Road, Uden, Netherlands', '054-2679107');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864810, 'Azucar Albright', '81 California Road, Nuernberg, Germany', '054-5060583');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864811, 'Carole McFerrin', '79 Sinatra Road, Woodland Hills, USA', '057-5509604');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864812, 'Norm Bentley', '87 Kuopio Drive, North Sydney, Australia', '051-8518236');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864813, 'Casey England', '64 Giovanni Drive, Coldmeece, United Kingdom', '056-9832062');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864814, 'Jeanne Elizondo', '25 Joan, Bozeman, USA', '052-8273888');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864815, 'Ali Cartlidge', '30 Ashton Road, Cherepovets, Russia', '055-3276206');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864816, 'Buddy Barry', '56 Turturro Drive, Seattle, USA', '054-8734761');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864817, 'Rueben Peterson', '531 Atkins Road, Torino, Italy', '054-2608112');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864818, 'Busta Stallone', '72nd Street, Fairborn, USA', '051-7265125');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864819, 'Bridget Dooley', '100 Armand Road, Archbold, USA', '056-1249282');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864820, 'Bobby Goldblum', '53rd Street, Ehningen, Germany', '056-4035758');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864821, 'Brenda Rickman', '33 Dawson Road, Rocklin, USA', '054-4251031');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864822, 'Glenn Allen', '42nd Street, Albuquerque, USA', '059-9668040');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864823, 'Kiefer Costello', '24 Hagar Blvd, Eiksmarka, Norway', '055-2780769');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864824, 'Caroline Schreiber', '14 Sevilla Road, Mason, USA', '059-2532829');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864825, 'Grace Cummings', '573 Joaquim Drive, Tartu, Estonia', '053-9764613');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864826, 'Kyra Guzman', '62 Rorschach Blvd, Morioka, Japan', '056-8535554');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864827, 'Carole Tinsley', '53 Pfeiffer Road, Cedar Park, USA', '051-3925382');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864828, 'Fisher Cornell', '30 Ali Street, Portland, USA', '056-1069316');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864829, 'Remy Goldwyn', '571 Goran Drive, Guelph, Canada', '052-2420071');
commit;
prompt 100 records committed...
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864830, 'Paula Gallagher', '63 Eileen Drive, Dortmund, Germany', '051-6219697');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864831, 'Devon Navarro', '90 Gooding Road, Woodland Hills, USA', '057-4094871');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864832, 'Rosie Cazale', '78 Fox Drive, St Leonards, Australia', '051-9719858');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864833, 'Cole Mandrell', '513 Eckhart Ave, Ulm, Germany', '058-6250168');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864834, 'Emmylou Hampton', '68 Penn Street, Knoxville, USA', '055-4045624');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864835, 'Ernie Hatfield', '12nd Street, Carmichael, USA', '057-4577365');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864836, 'Tori Lynn', '79 Plymouth Meeting Road, Fort Lewis, USA', '055-9197461');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864837, 'Billy Nash', '15 Spacey Street, Durham, USA', '054-8527152');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864838, 'Gary Marx', '39 Jose Street, Moscow, Russia', '051-6969801');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864839, 'Corey Danes', '60 Kitty Road, Natal, Brazil', '056-9144130');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864840, 'Trace Rhymes', '54 MacDonald Drive, Durham, USA', '052-1065503');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864841, 'Miriam Portman', '232 Margolyes Ave, Cottbus, Germany', '051-5994219');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864842, 'Mary-Louise Bracco', '30 Verdun Road, Rome, USA', '057-4221613');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864843, 'Carole Secada', '3 Chesnutt, Eschen, Liechtenstein', '053-4672620');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864844, 'Rebeka Emmerich', '81st Street, Des Plaines, USA', '051-6547330');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864845, 'Miranda Burton', '19 Landau Drive, O''fallon, USA', '059-4326395');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864846, 'Kenny Warden', '38 Randal Drive, Madrid, Spain', '058-9028413');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864847, 'Jack Epps', '98 Gere Road, Washington, USA', '057-6538684');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864848, 'Donal Utada', '72nd Street, Yamagata, Japan', '051-6066908');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864849, 'Max Craddock', '89 Araras Blvd, Cherepovets, Russia', '052-1171218');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864850, 'Stewart Perez', '556 Ricci Drive, Hiroshima, Japan', '050-9771338');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864851, 'Rachid Shannon', '1 Warden Blvd, Terrasa, Spain', '051-2593826');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864852, 'Joaquim Westerberg', '67 Detmer Road, Gummersbach, Germany', '059-7599532');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864853, 'Javon Sample', '69 Fierstein Street, Sihung-si, South Korea', '058-8935690');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864854, 'Suzi Koyana', '1 Rock Ave, Bartlesville, USA', '059-3991617');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864855, 'Garry Marsden', '25 Carrere Street, Milan, Italy', '057-3550818');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864856, 'Ivan Rodgers', '13 Billy Road, Oak park, USA', '058-1605131');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864857, 'Owen LaBelle', '66 Crewson Road, Kongserbg, Norway', '050-6025012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864858, 'Ricardo Cruise', '4 Lonnie Drive, Ponta grossa, Brazil', '058-5122630');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864859, 'Mandy Dayne', '7 Mitra Ave, North Sydney, Australia', '056-5754087');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864860, 'Wang Gano', '8 Connelly Blvd, Tampa, USA', '059-3852032');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864861, 'Armand Lunch', '75 Rowan Drive, Paraju, Brazil', '057-6508169');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864862, 'Jennifer Shawn', '8 West Lafayette Blvd, Allen, USA', '052-7420579');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864863, 'Richie Wilkinson', '69 Dale Blvd, Takapuna, New Zealand', '055-7229304');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864864, 'Bradley Travers', '73 Netanya Road, Woodbridge, USA', '051-8621753');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864865, 'Chazz Quaid', '32 Venice Road, West Sussex, United Kingdom', '058-9720840');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864866, 'Leo Lizzy', '61 Renee Road, Pottendorf, Austria', '052-5795259');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864867, 'Owen Suchet', '50 Columbia Street, Olsztyn, Poland', '056-2442634');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864868, 'Celia McGoohan', '61st Street, Cesena, Italy', '055-1401394');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864869, 'Stanley urban', '51 Kevn Street, Charleston, USA', '053-3332787');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864870, 'Elijah Heald', '2 Coburn, Riverdale, USA', '053-9376511');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864871, 'Chi Shocked', '439 Travers Street, Antwerpen, Belgium', '057-7492181');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864872, 'Terence Rickles', '7 Huntington Road, Lyon, France', '059-5561585');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864873, 'Lauren Callow', '45 League city Road, Cerritos, USA', '056-5713822');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864874, 'Ann Frakes', '98 Bridges Ave, Hjallerup, Denmark', '051-8327071');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864875, 'Edward Skaggs', '17 Torino Street, Granada Hills, USA', '056-8313770');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864876, 'Rhys Carr', '95 Chestnut Road, Calgary, Canada', '056-2400603');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864877, 'Raymond Morse', '78 Swank Street, Redwood City, USA', '053-1012748');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864878, 'Freda Gleeson', '52nd Street, Moscow, Russia', '051-6375466');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864879, 'Christmas Richards', '557 Lancaster Road, Double Oak, USA', '052-7565441');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864880, 'Heather Wakeling', '36 Gena Road, Kobe, Japan', '054-4863539');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864881, 'Ashton Kramer', '42 King of Prussia Street, Thames Ditton, United Kingdom', '058-4087462');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864882, 'Yaphet Vaughan', '18 Stanford Blvd, San Diego, USA', '053-7871872');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864883, 'Jude Parker', '60 Novara, Ashland, USA', '059-6626418');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864884, 'Humberto Grant', '78 Pײ³ֲ©tion-ville Road, Darmstadt, Germany', '051-7789127');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864885, 'Merrill Coe', '791 Danger Road, Gdansk, Poland', '056-8563229');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864886, 'Temuera Hamilton', '935 Chubby Street, Double Oak, USA', '050-5495511');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864887, 'Kyra Penders', '31st Street, Newbury, USA', '052-8426476');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864888, 'Connie Rippy', '18 Wakayama Drive, Cromwell, USA', '059-9794780');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864889, 'Andy Voight', '26 Burstyn Road, Grapevine, USA', '051-9655371');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864890, 'Javon Amos', '47 Lin Road, Cle Elum, USA', '054-6046313');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864891, 'Kyra Richards', '923 West Windsor Street, West Launceston, Australia', '057-6174776');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864892, 'Richie Platt', '68 Nastassja Road, Michendorf, Germany', '052-2042901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864893, 'Emm Makeba', '25 Dalley Street, Mito, Japan', '052-4029268');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864894, 'Domingo Adkins', '51 Brock Road, Thames Ditton, United Kingdom', '055-7399913');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864895, 'Wade Tillis', '734 Warburton Road, San Jose, USA', '056-3206567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864896, 'Danni Sanchez', '53 Chappelle Road, Tempe, USA', '059-6956757');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864897, 'Gates Harris', '34 Hawkins Blvd, Carlingford, Australia', '057-1870251');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864898, 'Viggo Barnett', '31 Dorn Street, Spring City, USA', '054-5904219');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864899, 'Nelly Reeve', '248 Gambon Street, Cle Elum, USA', '055-9868081');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864900, 'Gilbert Jenkins', '60 Osbourne, Abbotsford, Australia', '052-8995409');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864901, 'Sigourney Dillane', '21 Telford Drive, Woking, United Kingdom', '054-5650457');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864902, 'Ron McDonnell', '81 Burwood East Drive, San Ramon, USA', '054-1203815');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864903, 'Harold Hannah', '12 Burgess Hill, Redondo beach, USA', '053-3406499');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864904, 'Ike Fender', '59 Ann Drive, Pordenone, Italy', '053-2085413');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864905, 'Stanley Osment', '63 Marty Drive, Dublin, Ireland', '055-7928079');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864906, 'Cherry Wolf', '4 Oszajca Street, Kײ³ֲ¶ln, Germany', '052-6095449');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864907, 'Daniel Van Shelton', '97 Sisto Road, Macau, Macau', '056-6027224');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864908, 'Cledus Harrison', '66 Tracy Street, Reston, USA', '055-5076417');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864909, 'Tracy Johnson', '37 Cleary Ave, Cincinnati, USA', '054-8885246');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864910, 'Pablo Doucette', '65 LeVar Drive, Oxon, United Kingdom', '059-2386201');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864911, 'Claude Venora', '14 King, Guelph, Canada', '055-4499910');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864912, 'Edgar Krabbe', '78 Pierce Drive, Yamagata, Japan', '057-7348041');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864913, 'Benicio Shannon', '430 Chaykin Street, Altamonte Springs, USA', '050-2127251');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864914, 'Denny McDonnell', '39 Jean-Luc Ave, Sainte-foy, Canada', '054-7401266');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864915, 'Kyle Willis', '60 O''Connor Drive, Oulu, Finland', '058-4888749');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864916, 'Cheryl Hornsby', '30 Neuwirth Road, Bellerose, USA', '051-5795736');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864917, 'Jesus Deejay', '79 Ramsey, Bingham Farms, USA', '056-6165792');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864918, 'Tobey Unger', '248 Scott Drive, Treviso, Italy', '058-8700062');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864919, 'Jack Aaron', '10 Perry Street, Cary, USA', '057-5337256');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864920, 'Brad Bell', '63 Paymer Blvd, Marburg, Germany', '056-4155712');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864921, 'Nigel Sinatra', '48 Suvari Road, Coppell, USA', '058-4191626');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864922, 'Earl Hawkins', '95 Santana Drive, Carlsbad, USA', '055-7754019');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864923, 'Helen Bogguss', '92 Jude Road, Barksdale afb, USA', '059-2929977');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864924, 'Garth Hart', '25 Anderson Street, Toulouse, France', '050-3782180');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864925, 'Jodie Tippe', '29 McNarland Road, Aniײ³ֲ¨res, Switzerland', '050-7021245');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864926, 'Drew Hopper', '890 Rod Blvd, Udine, Italy', '052-3109500');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864927, 'Chet Westerberg', '56 Ritchie Blvd, Bham, USA', '059-2291335');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864928, 'Quentin Himmelman', '86 Anthony Street, Seatle, USA', '058-9543113');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864929, 'Leelee Bryson', '41st Street, North bethesda, USA', '055-6380159');
commit;
prompt 200 records committed...
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864930, 'Nicky Burns', '58 Gifu Ave, Nicosia, Cyprus', '054-9430910');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864932, 'Nolan Thompson', '8787 Maple St, Springfield, Brazil', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864933, 'Gabriella Wright', '8888 Birch St, Springfield, Japan', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864934, 'Parker James', '8989 Willow St, Springfield, South Africa', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864935, 'Athena Cooper', '9090 Spruce St, Springfield, China', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864936, 'Camden Nguyen', '9191 Fir St, Springfield, India', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864937, 'Eliza Carter', '9292 Pine St, Springfield, Russia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864938, 'Jaxson Evans', '9393 Oak St, Springfield, Argentina', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864939, 'Lillian Martinez', '9494 Elm St, Springfield, Egypt', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864940, 'Beckett Peterson', '9595 Cedar St, Springfield, Germany', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864941, 'Margot Harrison', '9696 Maple St, Springfield, France', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864942, 'Dante Cole', '9797 Birch St, Springfield, Italy', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864943, 'Isla Howard', '9898 Willow St, Springfield, Mexico', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864944, 'Kingston Bennett', '9999 Aspen St, Springfield, Brazil', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864945, 'Nevaeh Wallace', '10000 Redwood St, Springfield, Canada', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864946, 'Phoenix Brooks', '10101 Spruce St, Springfield, UK', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864947, 'Ryder Kim', '10202 Fir St, Springfield, Australia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864948, 'Lucas Carter', '10303 Maple St, Springfield, USA', '051-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864949, 'Olivia Brooks', '10404 Birch St, Springfield, Canada', '052-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864950, 'Ethan Richardson', '10505 Willow St, Springfield, UK', '053-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864951, 'Ava Parker', '10606 Fir St, Springfield, Australia', '054-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864952, 'Liam Edwards', '10707 Pine St, Springfield, Germany', '055-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864953, 'Sophia Turner', '10808 Oak St, Springfield, France', '051-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864954, 'Noah Foster', '10909 Elm St, Springfield, Italy', '052-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864955, 'Isabella Collins', '11010 Cedar St, Springfield, Mexico', '053-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864956, 'Mason Ward', '11111 Spruce St, Springfield, Brazil', '054-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864957, 'Mia Bennett', '11212 Redwood St, Springfield, Japan', '055-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864958, 'James Bailey', '11313 Maple St, Springfield, South Africa', '051-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864959, 'Charlotte Rivera', '11414 Birch St, Springfield, China', '052-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864960, 'Benjamin Hughes', '11515 Willow St, Springfield, India', '053-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864961, 'Amelia Murphy', '11616 Fir St, Springfield, Russia', '054-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864962, 'Elijah Sullivan', '11717 Pine St, Springfield, Argentina', '055-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864963, 'Evelyn Ramirez', '11818 Oak St, Springfield, Egypt', '051-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864964, 'Alexander Perry', '11919 Elm St, Springfield, Germany', '052-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864965, 'Harper Diaz', '12020 Cedar St, Springfield, France', '053-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864966, 'Sebastian Hughes', '12121 Spruce St, Springfield, Italy', '054-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864967, 'Emily Martinez', '12222 Redwood St, Springfield, Mexico', '055-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864968, 'Jack Cooper', '12323 Maple St, Springfield, Brazil', '051-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864969, 'Abigail Howard', '12424 Birch St, Springfield, Canada', '052-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864970, 'Aiden Price', '12525 Willow St, Springfield, UK', '053-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864971, 'Ella Brooks', '12626 Fir St, Springfield, Australia', '054-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864972, 'Henry Bell', '12727 Pine St, Springfield, Germany', '055-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864973, 'Scarlett Patterson', '12828 Oak St, Springfield, France', '051-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864974, 'Daniel Mitchell', '12929 Elm St, Springfield, Italy', '052-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864975, 'Aria Simmons', '13030 Cedar St, Springfield, Mexico', '053-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864976, 'Matthew Sanders', '13131 Spruce St, Springfield, Brazil', '054-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864977, 'Luna Ross', '13232 Redwood St, Springfield, Japan', '055-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864978, 'Joseph Bailey', '13333 Maple St, Springfield, South Africa', '051-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864979, 'Mila Ward', '13434 Birch St, Springfield, China', '052-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864980, 'David Bryant', '13535 Willow St, Springfield, India', '053-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864981, 'Sofia Evans', '13636 Fir St, Springfield, Russia', '054-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864982, 'John Kelly', '13737 Pine St, Springfield, Argentina', '055-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864983, 'Caleb Powell', '13838 Maple St, Springfield, USA', '051-9876543');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864984, 'Grace Wood', '13939 Birch St, Springfield, Canada', '052-8765432');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864985, 'Julian Bennett', '14040 Willow St, Springfield, UK', '053-7654321');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864986, 'Victoria Torres', '14141 Fir St, Springfield, Australia', '054-6543210');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864987, 'Wyatt Rogers', '14242 Pine St, Springfield, Germany', '055-5432109');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864988, 'Hannah Jenkins', '14343 Oak St, Springfield, France', '051-4321098');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864989, 'Isaac Patterson', '14444 Elm St, Springfield, Italy', '052-3210987');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864990, 'Zoey Gray', '14545 Cedar St, Springfield, Mexico', '053-2109876');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864991, 'Gabriel Russell', '14646 Spruce St, Springfield, Brazil', '054-1098765');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864992, 'Lily Peterson', '14747 Redwood St, Springfield, Japan', '055-0987654');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864993, 'Lincoln Long', '14848 Maple St, Springfield, South Africa', '051-9876543');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864994, 'Violet Hughes', '14949 Birch St, Springfield, China', '052-8765432');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864995, 'Levi Foster', '15050 Willow St, Springfield, India', '053-7654321');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864996, 'Layla Price', '15151 Fir St, Springfield, Russia', '054-6543210');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864997, 'Nathaniel Sanders', '15252 Pine St, Springfield, Argentina', '055-5432109');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864998, 'Zoe Simmons', '15353 Oak St, Springfield, Egypt', '051-4321098');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864999, 'Jack Henderson', '15454 Elm St, Springfield, Germany', '052-3210987');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865000, 'Stella Gonzales', '15555 Cedar St, Springfield, France', '053-2109876');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865001, 'Luke Fisher', '15656 Spruce St, Springfield, Italy', '054-1098765');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865002, 'Penelope Webb', '15757 Redwood St, Springfield, Mexico', '055-0987654');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865003, 'Isaiah Holmes', '15858 Maple St, Springfield, Brazil', '051-9876543');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865004, 'Aurora Mills', '15959 Birch St, Springfield, Canada', '052-8765432');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865005, 'Aaron Warren', '16060 Willow St, Springfield, UK', '053-7654321');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865006, 'Savannah Dixon', '16161 Fir St, Springfield, Australia', '054-6543210');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865007, 'Grayson Hunt', '16262 Pine St, Springfield, Germany', '055-5432109');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865008, 'Aubrey Reed', '16363 Oak St, Springfield, France', '051-4321098');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865009, 'Cameron Hall', '16464 Elm St, Springfield, Italy', '052-3210987');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865010, 'Brooklyn Tucker', '16565 Cedar St, Springfield, Mexico', '053-2109876');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865011, 'Oliver Campbell', '16666 Spruce St, Springfield, Brazil', '054-1098765');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865012, 'Madeline Carter', '16767 Redwood St, Springfield, Japan', '055-0987654');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865013, 'Elias Roberts', '16868 Maple St, Springfield, South Africa', '051-9876543');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865014, 'Ellie Stevens', '16969 Birch St, Springfield, China', '052-8765432');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865015, 'Henry Hayes', '17070 Willow St, Springfield, India', '053-7654321');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865016, 'Hazel Richardson', '17171 Fir St, Springfield, Russia', '054-6543210');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865017, 'Ryan Ramirez', '17272 Pine St, Springfield, Argentina', '055-5432109');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865018, 'Natalie Perry', '17373 Maple St, Springfield, USA', '051-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865019, 'Oliver Powell', '17474 Birch St, Springfield, Canada', '052-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865020, 'Victoria Brooks', '17575 Willow St, Springfield, UK', '053-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865021, 'Matthew Bennett', '17676 Fir St, Springfield, Australia', '054-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865022, 'Emma Turner', '17777 Pine St, Springfield, Germany', '055-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865023, 'Lucas Foster', '17878 Oak St, Springfield, France', '051-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865024, 'Sophia Collins', '17979 Elm St, Springfield, Italy', '052-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865025, 'Benjamin Ward', '18080 Cedar St, Springfield, Mexico', '053-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865026, 'Isabella Bailey', '18181 Spruce St, Springfield, Brazil', '054-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865027, 'James Rivera', '18282 Redwood St, Springfield, Japan', '055-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865028, 'Amelia Hughes', '18383 Maple St, Springfield, South Africa', '051-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865029, 'Mia Diaz', '18484 Birch St, Springfield, China', '052-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865030, 'Ethan Richardson', '18585 Willow St, Springfield, India', '053-4567890');
commit;
prompt 300 records committed...
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865031, 'Charlotte Murphy', '18686 Fir St, Springfield, Russia', '054-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865032, 'Liam Sullivan', '18787 Pine St, Springfield, Argentina', '055-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865033, 'Abigail Ramirez', '18888 Oak St, Springfield, Egypt', '051-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865034, 'Evelyn Perry', '18989 Elm St, Springfield, Germany', '052-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865035, 'Sebastian Diaz', '19090 Cedar St, Springfield, France', '053-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865036, 'Emily Martinez', '19191 Spruce St, Springfield, Italy', '054-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865037, 'Luna Martinez', '19292 Redwood St, Springfield, Mexico', '055-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865038, 'Mason Bell', '19393 Maple St, Springfield, Brazil', '051-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865039, 'Aria Patterson', '19494 Birch St, Springfield, Canada', '052-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865040, 'Alexander Mitchell', '19595 Willow St, Springfield, UK', '053-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865041, 'Mila Simmons', '19696 Fir St, Springfield, Australia', '054-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865042, 'Jack Sanders', '19797 Pine St, Springfield, Germany', '055-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865043, 'Henry Foster', '19898 Oak St, Springfield, France', '051-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865044, 'Daniel Henderson', '19999 Elm St, Springfield, Italy', '052-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865045, 'Scarlett Ward', '20000 Cedar St, Springfield, Mexico', '053-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865046, 'David Cooper', '20101 Spruce St, Springfield, Brazil', '054-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865047, 'Grace Bryant', '20202 Redwood St, Springfield, Japan', '055-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865048, 'Julian Evans', '20303 Maple St, Springfield, South Africa', '051-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865049, 'Ellie Martinez', '20404 Birch St, Springfield, China', '052-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865050, 'Aiden Bailey', '20505 Willow St, Springfield, India', '053-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865051, 'Aubrey Ross', '20606 Fir St, Springfield, Russia', '054-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865052, 'Isaac Kelly', '20707 Pine St, Springfield, Argentina', '055-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865053, 'Avery Carter', '20808 Maple St, Springfield, USA', '051-9876543');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865054, 'Liam Russell', '20909 Birch St, Springfield, Canada', '052-8765432');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865055, 'Zoe Gray', '21010 Willow St, Springfield, UK', '053-7654321');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865056, 'Mia Perry', '21111 Fir St, Springfield, Australia', '054-6543210');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865057, 'Benjamin Price', '21212 Pine St, Springfield, Germany', '055-5432109');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865058, 'Emily Hughes', '21313 Oak St, Springfield, France', '051-4321098');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865059, 'Caleb Gonzales', '21414 Elm St, Springfield, Italy', '052-3210987');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865060, 'Lily Bennett', '21515 Cedar St, Springfield, Mexico', '053-2109876');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865061, 'Noah Rogers', '21616 Spruce St, Springfield, Brazil', '054-1098765');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865062, 'Aria Martinez', '21717 Redwood St, Springfield, Japan', '055-0987654');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865063, 'Jackson Sullivan', '21818 Maple St, Springfield, South Africa', '051-9876543');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865064, 'Ella Collins', '21919 Birch St, Springfield, China', '052-8765432');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865065, 'Henry Sanders', '22020 Willow St, Springfield, India', '053-7654321');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865066, 'Aubrey Patterson', '22121 Fir St, Springfield, Russia', '054-6543210');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865067, 'Jack Howard', '22222 Pine St, Springfield, Argentina', '055-5432109');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865068, 'Hazel Bryant', '22323 Oak St, Springfield, Egypt', '051-4321098');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865069, 'Samuel Foster', '22424 Elm St, Springfield, Germany', '052-3210987');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865070, 'Scarlett Perry', '22525 Cedar St, Springfield, France', '053-2109876');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865071, 'Logan Wood', '22626 Spruce St, Springfield, Italy', '054-1098765');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865072, 'Leah Murphy', '22727 Redwood St, Springfield, Mexico', '055-0987654');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865073, 'Daniel Brooks', '22828 Maple St, Springfield, Brazil', '051-9876543');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865074, 'Luna Foster', '22929 Birch St, Springfield, Canada', '052-8765432');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865075, 'Elijah Russell', '23030 Willow St, Springfield, UK', '053-7654321');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865076, 'Avery Bailey', '23131 Fir St, Springfield, Australia', '054-6543210');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865077, 'Ethan Turner', '23232 Pine St, Springfield, Germany', '055-5432109');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865078, 'Nora Perry', '23333 Oak St, Springfield, France', '051-4321098');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865079, 'Mason Rogers', '23434 Elm St, Springfield, Italy', '052-3210987');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865080, 'Victoria Diaz', '23535 Cedar St, Springfield, Mexico', '053-2109876');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865081, 'Caleb Martinez', '23636 Spruce St, Springfield, Brazil', '054-1098765');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865082, 'Grace Price', '23737 Redwood St, Springfield, Japan', '055-0987654');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865083, 'Oliver Henderson', '23838 Maple St, Springfield, South Africa', '051-9876543');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865084, 'Layla Carter', '23939 Birch St, Springfield, China', '052-8765432');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865085, 'Julian Hughes', '24040 Willow St, Springfield, India', '053-7654321');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865086, 'Penelope Gray', '24141 Fir St, Springfield, Russia', '054-6543210');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865087, 'Isaac Bennett', '24242 Pine St, Springfield, Argentina', '055-5432109');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865088, 'David Bell', '24343 Maple St, Springfield, USA', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865089, 'Madison Clark', '24444 Birch St, Springfield, Canada', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865090, 'Oliver Scott', '24545 Willow St, Springfield, UK', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865091, 'Sophia Adams', '24646 Fir St, Springfield, Australia', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865092, 'Ethan Young', '24747 Pine St, Springfield, Germany', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865093, 'Isabella King', '24848 Oak St, Springfield, France', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865094, 'Mason Wright', '24949 Elm St, Springfield, Italy', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865095, 'Ava Hill', '25050 Cedar St, Springfield, Mexico', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865096, 'James Lopez', '25151 Spruce St, Springfield, Brazil', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865097, 'Mia Green', '25252 Redwood St, Springfield, Japan', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865098, 'Alexander Nelson', '25353 Maple St, Springfield, South Africa', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865099, 'Ella Baker', '25454 Birch St, Springfield, China', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865100, 'Logan Carter', '25555 Willow St, Springfield, India', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865101, 'Scarlett Rivera', '25656 Fir St, Springfield, Russia', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865102, 'Benjamin Mitchell', '25757 Pine St, Springfield, Argentina', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865103, 'Luna Perez', '25858 Oak St, Springfield, Egypt', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865104, 'Jack Roberts', '25959 Elm St, Springfield, Germany', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865105, 'Amelia Hughes', '26060 Cedar St, Springfield, France', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865106, 'Owen Bailey', '26161 Spruce St, Springfield, Italy', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865107, 'Hannah Turner', '26262 Redwood St, Springfield, Mexico', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865108, 'Elijah Lewis', '26363 Maple St, Springfield, Brazil', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865109, 'Zoey Walker', '26464 Birch St, Springfield, Canada', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865110, 'William Hall', '26565 Willow St, Springfield, UK', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865111, 'Abigail Allen', '26666 Fir St, Springfield, Australia', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865112, 'Daniel Young', '26767 Pine St, Springfield, Germany', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865113, 'Grace Hernandez', '26868 Oak St, Springfield, France', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865114, 'Caleb Nelson', '26969 Elm St, Springfield, Italy', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865115, 'Layla King', '27070 Cedar St, Springfield, Mexico', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865116, 'Lucas Wright', '27171 Spruce St, Springfield, Brazil', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865117, 'Avery Scott', '27272 Redwood St, Springfield, Japan', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865118, 'Levi Baker', '27373 Maple St, Springfield, South Africa', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865119, 'Aria Clark', '27474 Birch St, Springfield, China', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865120, 'Jackson Adams', '27575 Willow St, Springfield, India', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865121, 'Harper Young', '27676 Fir St, Springfield, Russia', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865122, 'Samuel Hill', '27777 Pine St, Springfield, Argentina', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865123, 'Liam Davis', '27878 Maple St, Springfield, USA', '051-8765432');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865124, 'Emma Thompson', '27979 Birch St, Springfield, Canada', '052-9876543');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865125, 'Lucas White', '28080 Willow St, Springfield, UK', '053-7654321');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865126, 'Sophia Harris', '28181 Fir St, Springfield, Australia', '054-6543210');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865127, 'Mason Clark', '28282 Pine St, Springfield, Germany', '055-5432109');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865128, 'Olivia Lewis', '28383 Oak St, Springfield, France', '051-4321098');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865129, 'Elijah Young', '28484 Elm St, Springfield, Italy', '052-3210987');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322865130, 'Ava King', '28585 Cedar St, Springfield, Mexico', '053-2109876');
commit;
prompt 400 records loaded
prompt Loading ORDERS...
insert into ORDERS (oid, orderdate, sid)
values (39999, to_date('11-05-2023', 'dd-mm-yyyy'), 322865024);
insert into ORDERS (oid, orderdate, sid)
values (40000, to_date('10-04-2024', 'dd-mm-yyyy'), 322864756);
insert into ORDERS (oid, orderdate, sid)
values (40001, to_date('15-08-2023', 'dd-mm-yyyy'), 322864932);
insert into ORDERS (oid, orderdate, sid)
values (40002, to_date('27-03-2023', 'dd-mm-yyyy'), 322864795);
insert into ORDERS (oid, orderdate, sid)
values (40003, to_date('23-02-2023', 'dd-mm-yyyy'), 322865001);
insert into ORDERS (oid, orderdate, sid)
values (40004, to_date('02-03-2024', 'dd-mm-yyyy'), 322865081);
insert into ORDERS (oid, orderdate, sid)
values (40005, to_date('30-09-2021', 'dd-mm-yyyy'), 322864894);
insert into ORDERS (oid, orderdate, sid)
values (40006, to_date('08-07-2021', 'dd-mm-yyyy'), 322864980);
insert into ORDERS (oid, orderdate, sid)
values (40007, to_date('14-09-2022', 'dd-mm-yyyy'), 322864997);
insert into ORDERS (oid, orderdate, sid)
values (40008, to_date('10-09-2022', 'dd-mm-yyyy'), 322865057);
insert into ORDERS (oid, orderdate, sid)
values (40009, to_date('12-02-2023', 'dd-mm-yyyy'), 322864920);
insert into ORDERS (oid, orderdate, sid)
values (40010, to_date('08-05-2022', 'dd-mm-yyyy'), 322865060);
insert into ORDERS (oid, orderdate, sid)
values (40011, to_date('16-09-2022', 'dd-mm-yyyy'), 322864878);
insert into ORDERS (oid, orderdate, sid)
values (40012, to_date('01-04-2024', 'dd-mm-yyyy'), 322864803);
insert into ORDERS (oid, orderdate, sid)
values (40013, to_date('29-06-2022', 'dd-mm-yyyy'), 322865068);
insert into ORDERS (oid, orderdate, sid)
values (40014, to_date('15-07-2022', 'dd-mm-yyyy'), 322865080);
insert into ORDERS (oid, orderdate, sid)
values (40015, to_date('07-02-2022', 'dd-mm-yyyy'), 322865081);
insert into ORDERS (oid, orderdate, sid)
values (40016, to_date('18-02-2021', 'dd-mm-yyyy'), 322865109);
insert into ORDERS (oid, orderdate, sid)
values (40017, to_date('12-02-2022', 'dd-mm-yyyy'), 322865037);
insert into ORDERS (oid, orderdate, sid)
values (40018, to_date('04-11-2021', 'dd-mm-yyyy'), 322865059);
insert into ORDERS (oid, orderdate, sid)
values (40019, to_date('25-07-2021', 'dd-mm-yyyy'), 322865094);
insert into ORDERS (oid, orderdate, sid)
values (40020, to_date('26-02-2024', 'dd-mm-yyyy'), 322865127);
insert into ORDERS (oid, orderdate, sid)
values (40021, to_date('25-12-2021', 'dd-mm-yyyy'), 322864819);
insert into ORDERS (oid, orderdate, sid)
values (40022, to_date('10-04-2023', 'dd-mm-yyyy'), 322864747);
insert into ORDERS (oid, orderdate, sid)
values (40023, to_date('12-03-2023', 'dd-mm-yyyy'), 322864867);
insert into ORDERS (oid, orderdate, sid)
values (40024, to_date('20-01-2024', 'dd-mm-yyyy'), 322864785);
insert into ORDERS (oid, orderdate, sid)
values (40025, to_date('30-10-2023', 'dd-mm-yyyy'), 322865067);
insert into ORDERS (oid, orderdate, sid)
values (40026, to_date('27-08-2021', 'dd-mm-yyyy'), 322864899);
insert into ORDERS (oid, orderdate, sid)
values (40027, to_date('12-08-2023', 'dd-mm-yyyy'), 322864745);
insert into ORDERS (oid, orderdate, sid)
values (40028, to_date('28-07-2022', 'dd-mm-yyyy'), 322865127);
insert into ORDERS (oid, orderdate, sid)
values (40029, to_date('01-11-2021', 'dd-mm-yyyy'), 322864794);
insert into ORDERS (oid, orderdate, sid)
values (40030, to_date('12-04-2021', 'dd-mm-yyyy'), 322864877);
insert into ORDERS (oid, orderdate, sid)
values (40031, to_date('28-03-2024', 'dd-mm-yyyy'), 322865125);
insert into ORDERS (oid, orderdate, sid)
values (40032, to_date('17-05-2021', 'dd-mm-yyyy'), 322864980);
insert into ORDERS (oid, orderdate, sid)
values (40033, to_date('28-12-2023', 'dd-mm-yyyy'), 322864792);
insert into ORDERS (oid, orderdate, sid)
values (40034, to_date('17-07-2021', 'dd-mm-yyyy'), 322864981);
insert into ORDERS (oid, orderdate, sid)
values (40035, to_date('05-06-2021', 'dd-mm-yyyy'), 322865041);
insert into ORDERS (oid, orderdate, sid)
values (40036, to_date('18-01-2023', 'dd-mm-yyyy'), 322864739);
insert into ORDERS (oid, orderdate, sid)
values (40037, to_date('15-11-2022', 'dd-mm-yyyy'), 322864776);
insert into ORDERS (oid, orderdate, sid)
values (40038, to_date('08-06-2021', 'dd-mm-yyyy'), 322865096);
insert into ORDERS (oid, orderdate, sid)
values (40039, to_date('06-12-2023', 'dd-mm-yyyy'), 322864873);
insert into ORDERS (oid, orderdate, sid)
values (40040, to_date('08-11-2023', 'dd-mm-yyyy'), 322864888);
insert into ORDERS (oid, orderdate, sid)
values (40041, to_date('23-03-2024', 'dd-mm-yyyy'), 322865061);
insert into ORDERS (oid, orderdate, sid)
values (40042, to_date('25-07-2022', 'dd-mm-yyyy'), 322864874);
insert into ORDERS (oid, orderdate, sid)
values (40043, to_date('24-02-2023', 'dd-mm-yyyy'), 322864781);
insert into ORDERS (oid, orderdate, sid)
values (40044, to_date('27-11-2021', 'dd-mm-yyyy'), 322864835);
insert into ORDERS (oid, orderdate, sid)
values (40045, to_date('15-07-2021', 'dd-mm-yyyy'), 322864753);
insert into ORDERS (oid, orderdate, sid)
values (40046, to_date('20-11-2023', 'dd-mm-yyyy'), 322865033);
insert into ORDERS (oid, orderdate, sid)
values (40047, to_date('04-03-2021', 'dd-mm-yyyy'), 322864860);
insert into ORDERS (oid, orderdate, sid)
values (40048, to_date('29-11-2023', 'dd-mm-yyyy'), 322864879);
insert into ORDERS (oid, orderdate, sid)
values (40049, to_date('29-08-2021', 'dd-mm-yyyy'), 322864872);
insert into ORDERS (oid, orderdate, sid)
values (40050, to_date('12-10-2021', 'dd-mm-yyyy'), 322864989);
insert into ORDERS (oid, orderdate, sid)
values (40051, to_date('13-10-2021', 'dd-mm-yyyy'), 322865028);
insert into ORDERS (oid, orderdate, sid)
values (40052, to_date('12-04-2023', 'dd-mm-yyyy'), 322864899);
insert into ORDERS (oid, orderdate, sid)
values (40053, to_date('17-03-2023', 'dd-mm-yyyy'), 322864798);
insert into ORDERS (oid, orderdate, sid)
values (40054, to_date('21-02-2022', 'dd-mm-yyyy'), 322864800);
insert into ORDERS (oid, orderdate, sid)
values (40055, to_date('25-08-2021', 'dd-mm-yyyy'), 322865034);
insert into ORDERS (oid, orderdate, sid)
values (40056, to_date('18-03-2024', 'dd-mm-yyyy'), 322864969);
insert into ORDERS (oid, orderdate, sid)
values (40057, to_date('06-04-2022', 'dd-mm-yyyy'), 322864843);
insert into ORDERS (oid, orderdate, sid)
values (40058, to_date('01-12-2023', 'dd-mm-yyyy'), 322865054);
insert into ORDERS (oid, orderdate, sid)
values (40059, to_date('01-02-2022', 'dd-mm-yyyy'), 322864988);
insert into ORDERS (oid, orderdate, sid)
values (40060, to_date('25-08-2023', 'dd-mm-yyyy'), 322865099);
insert into ORDERS (oid, orderdate, sid)
values (40061, to_date('07-09-2021', 'dd-mm-yyyy'), 322864944);
insert into ORDERS (oid, orderdate, sid)
values (40062, to_date('27-06-2021', 'dd-mm-yyyy'), 322865062);
insert into ORDERS (oid, orderdate, sid)
values (40063, to_date('22-01-2024', 'dd-mm-yyyy'), 322864822);
insert into ORDERS (oid, orderdate, sid)
values (40064, to_date('18-03-2022', 'dd-mm-yyyy'), 322864899);
insert into ORDERS (oid, orderdate, sid)
values (40065, to_date('12-09-2023', 'dd-mm-yyyy'), 322865087);
insert into ORDERS (oid, orderdate, sid)
values (40066, to_date('29-06-2022', 'dd-mm-yyyy'), 322864991);
insert into ORDERS (oid, orderdate, sid)
values (40067, to_date('04-06-2023', 'dd-mm-yyyy'), 322865076);
insert into ORDERS (oid, orderdate, sid)
values (40068, to_date('04-07-2023', 'dd-mm-yyyy'), 322864768);
insert into ORDERS (oid, orderdate, sid)
values (40069, to_date('04-09-2022', 'dd-mm-yyyy'), 322865053);
insert into ORDERS (oid, orderdate, sid)
values (40070, to_date('14-07-2023', 'dd-mm-yyyy'), 322865114);
insert into ORDERS (oid, orderdate, sid)
values (40071, to_date('18-04-2023', 'dd-mm-yyyy'), 322865002);
insert into ORDERS (oid, orderdate, sid)
values (40072, to_date('18-10-2021', 'dd-mm-yyyy'), 322865009);
insert into ORDERS (oid, orderdate, sid)
values (40073, to_date('17-11-2021', 'dd-mm-yyyy'), 322865088);
insert into ORDERS (oid, orderdate, sid)
values (40074, to_date('26-08-2021', 'dd-mm-yyyy'), 322864988);
insert into ORDERS (oid, orderdate, sid)
values (40075, to_date('08-12-2022', 'dd-mm-yyyy'), 322864800);
insert into ORDERS (oid, orderdate, sid)
values (40076, to_date('16-01-2022', 'dd-mm-yyyy'), 322864872);
insert into ORDERS (oid, orderdate, sid)
values (40077, to_date('07-04-2023', 'dd-mm-yyyy'), 322865099);
insert into ORDERS (oid, orderdate, sid)
values (40078, to_date('25-04-2024', 'dd-mm-yyyy'), 322864957);
insert into ORDERS (oid, orderdate, sid)
values (40079, to_date('12-10-2023', 'dd-mm-yyyy'), 322864778);
insert into ORDERS (oid, orderdate, sid)
values (40080, to_date('23-03-2021', 'dd-mm-yyyy'), 322865113);
insert into ORDERS (oid, orderdate, sid)
values (40081, to_date('27-04-2024', 'dd-mm-yyyy'), 322864776);
insert into ORDERS (oid, orderdate, sid)
values (40082, to_date('30-01-2024', 'dd-mm-yyyy'), 322864777);
insert into ORDERS (oid, orderdate, sid)
values (40083, to_date('11-02-2022', 'dd-mm-yyyy'), 322865033);
insert into ORDERS (oid, orderdate, sid)
values (40084, to_date('12-01-2022', 'dd-mm-yyyy'), 322864890);
insert into ORDERS (oid, orderdate, sid)
values (40085, to_date('12-11-2021', 'dd-mm-yyyy'), 322865037);
insert into ORDERS (oid, orderdate, sid)
values (40086, to_date('17-07-2022', 'dd-mm-yyyy'), 322864972);
insert into ORDERS (oid, orderdate, sid)
values (40087, to_date('26-04-2022', 'dd-mm-yyyy'), 322864859);
insert into ORDERS (oid, orderdate, sid)
values (40088, to_date('17-05-2021', 'dd-mm-yyyy'), 322864974);
insert into ORDERS (oid, orderdate, sid)
values (40089, to_date('29-10-2022', 'dd-mm-yyyy'), 322864801);
insert into ORDERS (oid, orderdate, sid)
values (40090, to_date('04-05-2022', 'dd-mm-yyyy'), 322864907);
insert into ORDERS (oid, orderdate, sid)
values (40091, to_date('10-03-2023', 'dd-mm-yyyy'), 322865084);
insert into ORDERS (oid, orderdate, sid)
values (40092, to_date('17-02-2021', 'dd-mm-yyyy'), 322864888);
insert into ORDERS (oid, orderdate, sid)
values (40093, to_date('22-05-2021', 'dd-mm-yyyy'), 322865081);
insert into ORDERS (oid, orderdate, sid)
values (40094, to_date('27-01-2021', 'dd-mm-yyyy'), 322864794);
insert into ORDERS (oid, orderdate, sid)
values (40095, to_date('07-06-2021', 'dd-mm-yyyy'), 322864927);
insert into ORDERS (oid, orderdate, sid)
values (40096, to_date('04-11-2023', 'dd-mm-yyyy'), 322864777);
insert into ORDERS (oid, orderdate, sid)
values (40097, to_date('29-09-2023', 'dd-mm-yyyy'), 322864810);
insert into ORDERS (oid, orderdate, sid)
values (40098, to_date('16-01-2024', 'dd-mm-yyyy'), 322864819);
commit;
prompt 100 records committed...
insert into ORDERS (oid, orderdate, sid)
values (40099, to_date('22-02-2022', 'dd-mm-yyyy'), 322864980);
insert into ORDERS (oid, orderdate, sid)
values (40100, to_date('21-07-2023', 'dd-mm-yyyy'), 322864792);
insert into ORDERS (oid, orderdate, sid)
values (40101, to_date('06-04-2022', 'dd-mm-yyyy'), 322864779);
insert into ORDERS (oid, orderdate, sid)
values (40102, to_date('23-08-2021', 'dd-mm-yyyy'), 322864991);
insert into ORDERS (oid, orderdate, sid)
values (40103, to_date('20-05-2022', 'dd-mm-yyyy'), 322865119);
insert into ORDERS (oid, orderdate, sid)
values (40104, to_date('06-04-2022', 'dd-mm-yyyy'), 322864808);
insert into ORDERS (oid, orderdate, sid)
values (40105, to_date('25-01-2024', 'dd-mm-yyyy'), 322864919);
insert into ORDERS (oid, orderdate, sid)
values (40106, to_date('13-11-2022', 'dd-mm-yyyy'), 322864922);
insert into ORDERS (oid, orderdate, sid)
values (40107, to_date('26-01-2022', 'dd-mm-yyyy'), 322864935);
insert into ORDERS (oid, orderdate, sid)
values (40108, to_date('12-03-2021', 'dd-mm-yyyy'), 322864864);
insert into ORDERS (oid, orderdate, sid)
values (40109, to_date('23-03-2022', 'dd-mm-yyyy'), 322864886);
insert into ORDERS (oid, orderdate, sid)
values (40110, to_date('12-12-2022', 'dd-mm-yyyy'), 322864732);
insert into ORDERS (oid, orderdate, sid)
values (40111, to_date('23-07-2021', 'dd-mm-yyyy'), 322865097);
insert into ORDERS (oid, orderdate, sid)
values (40112, to_date('10-02-2024', 'dd-mm-yyyy'), 322865126);
insert into ORDERS (oid, orderdate, sid)
values (40113, to_date('15-05-2021', 'dd-mm-yyyy'), 322864791);
insert into ORDERS (oid, orderdate, sid)
values (40114, to_date('26-09-2023', 'dd-mm-yyyy'), 322865069);
insert into ORDERS (oid, orderdate, sid)
values (40115, to_date('09-10-2022', 'dd-mm-yyyy'), 322864830);
insert into ORDERS (oid, orderdate, sid)
values (40116, to_date('28-03-2022', 'dd-mm-yyyy'), 322864978);
insert into ORDERS (oid, orderdate, sid)
values (40117, to_date('14-11-2022', 'dd-mm-yyyy'), 322864840);
insert into ORDERS (oid, orderdate, sid)
values (40118, to_date('10-02-2022', 'dd-mm-yyyy'), 322865068);
insert into ORDERS (oid, orderdate, sid)
values (40119, to_date('27-10-2023', 'dd-mm-yyyy'), 322865127);
insert into ORDERS (oid, orderdate, sid)
values (40120, to_date('16-09-2021', 'dd-mm-yyyy'), 322864839);
insert into ORDERS (oid, orderdate, sid)
values (40121, to_date('07-10-2023', 'dd-mm-yyyy'), 322865109);
insert into ORDERS (oid, orderdate, sid)
values (40122, to_date('26-12-2023', 'dd-mm-yyyy'), 322865028);
insert into ORDERS (oid, orderdate, sid)
values (40123, to_date('14-12-2023', 'dd-mm-yyyy'), 322864882);
insert into ORDERS (oid, orderdate, sid)
values (40124, to_date('20-02-2022', 'dd-mm-yyyy'), 322865096);
insert into ORDERS (oid, orderdate, sid)
values (40125, to_date('07-09-2022', 'dd-mm-yyyy'), 322865037);
insert into ORDERS (oid, orderdate, sid)
values (40126, to_date('22-12-2022', 'dd-mm-yyyy'), 322865007);
insert into ORDERS (oid, orderdate, sid)
values (40127, to_date('20-12-2021', 'dd-mm-yyyy'), 322864749);
insert into ORDERS (oid, orderdate, sid)
values (40128, to_date('05-03-2024', 'dd-mm-yyyy'), 322864978);
insert into ORDERS (oid, orderdate, sid)
values (40129, to_date('05-08-2022', 'dd-mm-yyyy'), 322865052);
insert into ORDERS (oid, orderdate, sid)
values (40130, to_date('11-08-2021', 'dd-mm-yyyy'), 322864961);
insert into ORDERS (oid, orderdate, sid)
values (40131, to_date('12-08-2021', 'dd-mm-yyyy'), 322865126);
insert into ORDERS (oid, orderdate, sid)
values (40132, to_date('17-01-2022', 'dd-mm-yyyy'), 322864938);
insert into ORDERS (oid, orderdate, sid)
values (40133, to_date('04-08-2023', 'dd-mm-yyyy'), 322865109);
insert into ORDERS (oid, orderdate, sid)
values (40134, to_date('29-12-2023', 'dd-mm-yyyy'), 322864784);
insert into ORDERS (oid, orderdate, sid)
values (40135, to_date('17-08-2023', 'dd-mm-yyyy'), 322865059);
insert into ORDERS (oid, orderdate, sid)
values (40136, to_date('03-09-2021', 'dd-mm-yyyy'), 322864974);
insert into ORDERS (oid, orderdate, sid)
values (40137, to_date('08-09-2022', 'dd-mm-yyyy'), 322864970);
insert into ORDERS (oid, orderdate, sid)
values (40138, to_date('15-07-2023', 'dd-mm-yyyy'), 322865097);
insert into ORDERS (oid, orderdate, sid)
values (40139, to_date('24-05-2021', 'dd-mm-yyyy'), 322864883);
insert into ORDERS (oid, orderdate, sid)
values (40140, to_date('04-07-2023', 'dd-mm-yyyy'), 322864863);
insert into ORDERS (oid, orderdate, sid)
values (40141, to_date('19-12-2023', 'dd-mm-yyyy'), 322864993);
insert into ORDERS (oid, orderdate, sid)
values (40142, to_date('19-02-2023', 'dd-mm-yyyy'), 322864741);
insert into ORDERS (oid, orderdate, sid)
values (40143, to_date('03-12-2023', 'dd-mm-yyyy'), 322864976);
insert into ORDERS (oid, orderdate, sid)
values (40144, to_date('14-02-2024', 'dd-mm-yyyy'), 111111111);
insert into ORDERS (oid, orderdate, sid)
values (40145, to_date('06-11-2021', 'dd-mm-yyyy'), 322865058);
insert into ORDERS (oid, orderdate, sid)
values (40146, to_date('14-05-2023', 'dd-mm-yyyy'), 322865009);
insert into ORDERS (oid, orderdate, sid)
values (40147, to_date('03-06-2021', 'dd-mm-yyyy'), 322865042);
insert into ORDERS (oid, orderdate, sid)
values (40148, to_date('06-03-2023', 'dd-mm-yyyy'), 322864739);
insert into ORDERS (oid, orderdate, sid)
values (40149, to_date('30-10-2021', 'dd-mm-yyyy'), 322864811);
insert into ORDERS (oid, orderdate, sid)
values (40150, to_date('25-09-2022', 'dd-mm-yyyy'), 322864998);
insert into ORDERS (oid, orderdate, sid)
values (40151, to_date('27-03-2022', 'dd-mm-yyyy'), 322865123);
insert into ORDERS (oid, orderdate, sid)
values (40152, to_date('21-01-2022', 'dd-mm-yyyy'), 322865102);
insert into ORDERS (oid, orderdate, sid)
values (40153, to_date('07-03-2024', 'dd-mm-yyyy'), 322864833);
insert into ORDERS (oid, orderdate, sid)
values (40154, to_date('21-03-2023', 'dd-mm-yyyy'), 322864886);
insert into ORDERS (oid, orderdate, sid)
values (40155, to_date('04-04-2022', 'dd-mm-yyyy'), 322865130);
insert into ORDERS (oid, orderdate, sid)
values (40156, to_date('29-01-2021', 'dd-mm-yyyy'), 322864824);
insert into ORDERS (oid, orderdate, sid)
values (40157, to_date('23-05-2021', 'dd-mm-yyyy'), 322864741);
insert into ORDERS (oid, orderdate, sid)
values (40158, to_date('12-03-2024', 'dd-mm-yyyy'), 322864733);
insert into ORDERS (oid, orderdate, sid)
values (40159, to_date('15-12-2021', 'dd-mm-yyyy'), 322864900);
insert into ORDERS (oid, orderdate, sid)
values (40160, to_date('19-12-2021', 'dd-mm-yyyy'), 322864765);
insert into ORDERS (oid, orderdate, sid)
values (40161, to_date('10-12-2022', 'dd-mm-yyyy'), 322865005);
insert into ORDERS (oid, orderdate, sid)
values (40162, to_date('17-08-2021', 'dd-mm-yyyy'), 322864811);
insert into ORDERS (oid, orderdate, sid)
values (40163, to_date('22-04-2023', 'dd-mm-yyyy'), 322864786);
insert into ORDERS (oid, orderdate, sid)
values (40164, to_date('28-01-2022', 'dd-mm-yyyy'), 322865032);
insert into ORDERS (oid, orderdate, sid)
values (40165, to_date('06-09-2022', 'dd-mm-yyyy'), 322864897);
insert into ORDERS (oid, orderdate, sid)
values (40166, to_date('20-09-2022', 'dd-mm-yyyy'), 322865052);
insert into ORDERS (oid, orderdate, sid)
values (40167, to_date('11-07-2023', 'dd-mm-yyyy'), 322864758);
insert into ORDERS (oid, orderdate, sid)
values (40168, to_date('29-01-2024', 'dd-mm-yyyy'), 322865094);
insert into ORDERS (oid, orderdate, sid)
values (40169, to_date('14-01-2024', 'dd-mm-yyyy'), 322864959);
insert into ORDERS (oid, orderdate, sid)
values (40170, to_date('28-10-2021', 'dd-mm-yyyy'), 322864832);
insert into ORDERS (oid, orderdate, sid)
values (40171, to_date('06-08-2022', 'dd-mm-yyyy'), 322864842);
insert into ORDERS (oid, orderdate, sid)
values (40172, to_date('26-10-2023', 'dd-mm-yyyy'), 322865019);
insert into ORDERS (oid, orderdate, sid)
values (40173, to_date('06-05-2021', 'dd-mm-yyyy'), 322864800);
insert into ORDERS (oid, orderdate, sid)
values (40174, to_date('24-04-2022', 'dd-mm-yyyy'), 322865067);
insert into ORDERS (oid, orderdate, sid)
values (40175, to_date('15-03-2024', 'dd-mm-yyyy'), 322864876);
insert into ORDERS (oid, orderdate, sid)
values (40176, to_date('28-10-2023', 'dd-mm-yyyy'), 322865041);
insert into ORDERS (oid, orderdate, sid)
values (40177, to_date('07-02-2022', 'dd-mm-yyyy'), 322865020);
insert into ORDERS (oid, orderdate, sid)
values (40178, to_date('17-01-2023', 'dd-mm-yyyy'), 322865043);
insert into ORDERS (oid, orderdate, sid)
values (40179, to_date('08-05-2023', 'dd-mm-yyyy'), 322864794);
insert into ORDERS (oid, orderdate, sid)
values (40180, to_date('04-08-2021', 'dd-mm-yyyy'), 322865049);
insert into ORDERS (oid, orderdate, sid)
values (40181, to_date('20-12-2021', 'dd-mm-yyyy'), 322864854);
insert into ORDERS (oid, orderdate, sid)
values (40182, to_date('26-09-2023', 'dd-mm-yyyy'), 322864769);
insert into ORDERS (oid, orderdate, sid)
values (40183, to_date('06-04-2021', 'dd-mm-yyyy'), 322865034);
insert into ORDERS (oid, orderdate, sid)
values (40184, to_date('03-07-2023', 'dd-mm-yyyy'), 322864803);
insert into ORDERS (oid, orderdate, sid)
values (40185, to_date('06-01-2024', 'dd-mm-yyyy'), 322864740);
insert into ORDERS (oid, orderdate, sid)
values (40186, to_date('06-01-2022', 'dd-mm-yyyy'), 322864853);
insert into ORDERS (oid, orderdate, sid)
values (40187, to_date('09-08-2023', 'dd-mm-yyyy'), 322865075);
insert into ORDERS (oid, orderdate, sid)
values (40188, to_date('17-05-2023', 'dd-mm-yyyy'), 322864872);
insert into ORDERS (oid, orderdate, sid)
values (40189, to_date('01-05-2024', 'dd-mm-yyyy'), 322865021);
insert into ORDERS (oid, orderdate, sid)
values (40190, to_date('04-08-2022', 'dd-mm-yyyy'), 322865105);
insert into ORDERS (oid, orderdate, sid)
values (40191, to_date('03-12-2021', 'dd-mm-yyyy'), 322864890);
insert into ORDERS (oid, orderdate, sid)
values (40192, to_date('02-08-2023', 'dd-mm-yyyy'), 322865102);
insert into ORDERS (oid, orderdate, sid)
values (40193, to_date('22-07-2021', 'dd-mm-yyyy'), 322864762);
insert into ORDERS (oid, orderdate, sid)
values (40194, to_date('15-03-2021', 'dd-mm-yyyy'), 322865064);
insert into ORDERS (oid, orderdate, sid)
values (40195, to_date('09-10-2022', 'dd-mm-yyyy'), 322864934);
insert into ORDERS (oid, orderdate, sid)
values (40196, to_date('14-03-2024', 'dd-mm-yyyy'), 322865001);
insert into ORDERS (oid, orderdate, sid)
values (40197, to_date('11-03-2023', 'dd-mm-yyyy'), 322865097);
insert into ORDERS (oid, orderdate, sid)
values (40198, to_date('08-05-2024', 'dd-mm-yyyy'), 322864852);
commit;
prompt 200 records committed...
insert into ORDERS (oid, orderdate, sid)
values (40199, to_date('27-10-2022', 'dd-mm-yyyy'), 322865052);
insert into ORDERS (oid, orderdate, sid)
values (40200, to_date('14-03-2024', 'dd-mm-yyyy'), 322864859);
insert into ORDERS (oid, orderdate, sid)
values (40201, to_date('14-09-2021', 'dd-mm-yyyy'), 322865101);
insert into ORDERS (oid, orderdate, sid)
values (40202, to_date('13-07-2023', 'dd-mm-yyyy'), 322864748);
insert into ORDERS (oid, orderdate, sid)
values (40203, to_date('10-06-2021', 'dd-mm-yyyy'), 322865111);
insert into ORDERS (oid, orderdate, sid)
values (40204, to_date('14-03-2021', 'dd-mm-yyyy'), 322864785);
insert into ORDERS (oid, orderdate, sid)
values (40205, to_date('09-08-2021', 'dd-mm-yyyy'), 322864986);
insert into ORDERS (oid, orderdate, sid)
values (40206, to_date('21-02-2022', 'dd-mm-yyyy'), 322865092);
insert into ORDERS (oid, orderdate, sid)
values (40207, to_date('09-05-2023', 'dd-mm-yyyy'), 322864958);
insert into ORDERS (oid, orderdate, sid)
values (40208, to_date('28-03-2023', 'dd-mm-yyyy'), 322864871);
insert into ORDERS (oid, orderdate, sid)
values (40209, to_date('18-09-2022', 'dd-mm-yyyy'), 322865019);
insert into ORDERS (oid, orderdate, sid)
values (40210, to_date('12-09-2023', 'dd-mm-yyyy'), 322864915);
insert into ORDERS (oid, orderdate, sid)
values (40211, to_date('23-02-2021', 'dd-mm-yyyy'), 322864907);
insert into ORDERS (oid, orderdate, sid)
values (40212, to_date('05-11-2021', 'dd-mm-yyyy'), 322864883);
insert into ORDERS (oid, orderdate, sid)
values (40213, to_date('21-12-2023', 'dd-mm-yyyy'), 322864974);
insert into ORDERS (oid, orderdate, sid)
values (40214, to_date('01-12-2021', 'dd-mm-yyyy'), 322864887);
insert into ORDERS (oid, orderdate, sid)
values (40215, to_date('25-01-2022', 'dd-mm-yyyy'), 322864745);
insert into ORDERS (oid, orderdate, sid)
values (40216, to_date('14-03-2021', 'dd-mm-yyyy'), 322865079);
insert into ORDERS (oid, orderdate, sid)
values (40217, to_date('22-01-2024', 'dd-mm-yyyy'), 322864897);
insert into ORDERS (oid, orderdate, sid)
values (40218, to_date('17-03-2023', 'dd-mm-yyyy'), 322864997);
insert into ORDERS (oid, orderdate, sid)
values (40219, to_date('06-03-2024', 'dd-mm-yyyy'), 322864866);
insert into ORDERS (oid, orderdate, sid)
values (40220, to_date('30-09-2021', 'dd-mm-yyyy'), 322864943);
insert into ORDERS (oid, orderdate, sid)
values (40221, to_date('30-03-2022', 'dd-mm-yyyy'), 322864807);
insert into ORDERS (oid, orderdate, sid)
values (40222, to_date('20-08-2023', 'dd-mm-yyyy'), 322864954);
insert into ORDERS (oid, orderdate, sid)
values (40223, to_date('29-03-2023', 'dd-mm-yyyy'), 322865129);
insert into ORDERS (oid, orderdate, sid)
values (40224, to_date('14-09-2022', 'dd-mm-yyyy'), 322865052);
insert into ORDERS (oid, orderdate, sid)
values (40225, to_date('29-10-2022', 'dd-mm-yyyy'), 322864913);
insert into ORDERS (oid, orderdate, sid)
values (40226, to_date('06-09-2021', 'dd-mm-yyyy'), 322864916);
insert into ORDERS (oid, orderdate, sid)
values (40227, to_date('09-03-2023', 'dd-mm-yyyy'), 322865044);
insert into ORDERS (oid, orderdate, sid)
values (40228, to_date('16-01-2023', 'dd-mm-yyyy'), 322864870);
insert into ORDERS (oid, orderdate, sid)
values (40229, to_date('01-11-2022', 'dd-mm-yyyy'), 322864763);
insert into ORDERS (oid, orderdate, sid)
values (40230, to_date('22-09-2022', 'dd-mm-yyyy'), 322864941);
insert into ORDERS (oid, orderdate, sid)
values (40231, to_date('04-02-2023', 'dd-mm-yyyy'), 322864877);
insert into ORDERS (oid, orderdate, sid)
values (40232, to_date('05-01-2021', 'dd-mm-yyyy'), 322864857);
insert into ORDERS (oid, orderdate, sid)
values (40233, to_date('07-09-2023', 'dd-mm-yyyy'), 322864915);
insert into ORDERS (oid, orderdate, sid)
values (40234, to_date('27-09-2021', 'dd-mm-yyyy'), 322864763);
insert into ORDERS (oid, orderdate, sid)
values (40235, to_date('23-04-2021', 'dd-mm-yyyy'), 322864887);
insert into ORDERS (oid, orderdate, sid)
values (40236, to_date('05-05-2022', 'dd-mm-yyyy'), 322864911);
insert into ORDERS (oid, orderdate, sid)
values (40237, to_date('06-09-2022', 'dd-mm-yyyy'), 322865129);
insert into ORDERS (oid, orderdate, sid)
values (40238, to_date('30-09-2021', 'dd-mm-yyyy'), 322865099);
insert into ORDERS (oid, orderdate, sid)
values (40239, to_date('28-02-2023', 'dd-mm-yyyy'), 322865082);
insert into ORDERS (oid, orderdate, sid)
values (40240, to_date('27-03-2023', 'dd-mm-yyyy'), 322864733);
insert into ORDERS (oid, orderdate, sid)
values (40241, to_date('20-09-2021', 'dd-mm-yyyy'), 322865096);
insert into ORDERS (oid, orderdate, sid)
values (40242, to_date('15-09-2023', 'dd-mm-yyyy'), 322864871);
insert into ORDERS (oid, orderdate, sid)
values (40243, to_date('18-10-2021', 'dd-mm-yyyy'), 322865106);
insert into ORDERS (oid, orderdate, sid)
values (40244, to_date('18-05-2022', 'dd-mm-yyyy'), 322864919);
insert into ORDERS (oid, orderdate, sid)
values (40245, to_date('05-08-2022', 'dd-mm-yyyy'), 322864875);
insert into ORDERS (oid, orderdate, sid)
values (40246, to_date('10-09-2021', 'dd-mm-yyyy'), 322864761);
insert into ORDERS (oid, orderdate, sid)
values (40247, to_date('08-04-2023', 'dd-mm-yyyy'), 322865042);
insert into ORDERS (oid, orderdate, sid)
values (40248, to_date('24-04-2021', 'dd-mm-yyyy'), 322864770);
insert into ORDERS (oid, orderdate, sid)
values (40249, to_date('23-07-2022', 'dd-mm-yyyy'), 322865071);
insert into ORDERS (oid, orderdate, sid)
values (40250, to_date('11-09-2023', 'dd-mm-yyyy'), 322865089);
insert into ORDERS (oid, orderdate, sid)
values (40251, to_date('05-01-2021', 'dd-mm-yyyy'), 322864751);
insert into ORDERS (oid, orderdate, sid)
values (40252, to_date('25-04-2023', 'dd-mm-yyyy'), 322864837);
insert into ORDERS (oid, orderdate, sid)
values (40253, to_date('23-08-2023', 'dd-mm-yyyy'), 322865128);
insert into ORDERS (oid, orderdate, sid)
values (40254, to_date('27-06-2023', 'dd-mm-yyyy'), 322864814);
insert into ORDERS (oid, orderdate, sid)
values (40255, to_date('09-05-2021', 'dd-mm-yyyy'), 322864928);
insert into ORDERS (oid, orderdate, sid)
values (40256, to_date('03-01-2024', 'dd-mm-yyyy'), 322864980);
insert into ORDERS (oid, orderdate, sid)
values (40257, to_date('29-10-2021', 'dd-mm-yyyy'), 322864951);
insert into ORDERS (oid, orderdate, sid)
values (40258, to_date('14-11-2021', 'dd-mm-yyyy'), 322864862);
insert into ORDERS (oid, orderdate, sid)
values (40259, to_date('16-10-2021', 'dd-mm-yyyy'), 322865087);
insert into ORDERS (oid, orderdate, sid)
values (40260, to_date('26-03-2024', 'dd-mm-yyyy'), 322864766);
insert into ORDERS (oid, orderdate, sid)
values (40261, to_date('28-07-2023', 'dd-mm-yyyy'), 322865051);
insert into ORDERS (oid, orderdate, sid)
values (40262, to_date('05-09-2022', 'dd-mm-yyyy'), 322864976);
insert into ORDERS (oid, orderdate, sid)
values (40263, to_date('24-05-2023', 'dd-mm-yyyy'), 322864867);
insert into ORDERS (oid, orderdate, sid)
values (40264, to_date('04-02-2021', 'dd-mm-yyyy'), 322864976);
insert into ORDERS (oid, orderdate, sid)
values (40265, to_date('14-11-2021', 'dd-mm-yyyy'), 322864816);
insert into ORDERS (oid, orderdate, sid)
values (40266, to_date('10-12-2023', 'dd-mm-yyyy'), 322864899);
insert into ORDERS (oid, orderdate, sid)
values (40267, to_date('18-01-2023', 'dd-mm-yyyy'), 322865068);
insert into ORDERS (oid, orderdate, sid)
values (40268, to_date('27-03-2021', 'dd-mm-yyyy'), 322865048);
insert into ORDERS (oid, orderdate, sid)
values (40269, to_date('10-05-2023', 'dd-mm-yyyy'), 322864911);
insert into ORDERS (oid, orderdate, sid)
values (40270, to_date('05-02-2021', 'dd-mm-yyyy'), 322865070);
insert into ORDERS (oid, orderdate, sid)
values (40271, to_date('20-11-2022', 'dd-mm-yyyy'), 322864809);
insert into ORDERS (oid, orderdate, sid)
values (40272, to_date('21-02-2022', 'dd-mm-yyyy'), 322864843);
insert into ORDERS (oid, orderdate, sid)
values (40273, to_date('23-05-2021', 'dd-mm-yyyy'), 322864993);
insert into ORDERS (oid, orderdate, sid)
values (40274, to_date('19-04-2022', 'dd-mm-yyyy'), 322864854);
insert into ORDERS (oid, orderdate, sid)
values (40275, to_date('18-12-2022', 'dd-mm-yyyy'), 322864812);
insert into ORDERS (oid, orderdate, sid)
values (40276, to_date('18-06-2022', 'dd-mm-yyyy'), 322864732);
insert into ORDERS (oid, orderdate, sid)
values (40277, to_date('08-08-2023', 'dd-mm-yyyy'), 322864762);
insert into ORDERS (oid, orderdate, sid)
values (40278, to_date('20-07-2021', 'dd-mm-yyyy'), 322865097);
insert into ORDERS (oid, orderdate, sid)
values (40279, to_date('01-05-2024', 'dd-mm-yyyy'), 322864809);
insert into ORDERS (oid, orderdate, sid)
values (40280, to_date('28-01-2024', 'dd-mm-yyyy'), 322864814);
insert into ORDERS (oid, orderdate, sid)
values (40281, to_date('02-01-2022', 'dd-mm-yyyy'), 322865129);
insert into ORDERS (oid, orderdate, sid)
values (40282, to_date('22-03-2021', 'dd-mm-yyyy'), 322864998);
insert into ORDERS (oid, orderdate, sid)
values (40283, to_date('24-02-2022', 'dd-mm-yyyy'), 322865078);
insert into ORDERS (oid, orderdate, sid)
values (40284, to_date('25-06-2022', 'dd-mm-yyyy'), 322864855);
insert into ORDERS (oid, orderdate, sid)
values (40285, to_date('04-05-2024', 'dd-mm-yyyy'), 322865114);
insert into ORDERS (oid, orderdate, sid)
values (40286, to_date('17-07-2022', 'dd-mm-yyyy'), 322864916);
insert into ORDERS (oid, orderdate, sid)
values (40287, to_date('19-09-2022', 'dd-mm-yyyy'), 322864898);
insert into ORDERS (oid, orderdate, sid)
values (40288, to_date('08-11-2022', 'dd-mm-yyyy'), 322864950);
insert into ORDERS (oid, orderdate, sid)
values (40289, to_date('03-04-2021', 'dd-mm-yyyy'), 322864867);
insert into ORDERS (oid, orderdate, sid)
values (40290, to_date('04-06-2021', 'dd-mm-yyyy'), 322865095);
insert into ORDERS (oid, orderdate, sid)
values (40291, to_date('16-06-2023', 'dd-mm-yyyy'), 322864737);
insert into ORDERS (oid, orderdate, sid)
values (40292, to_date('04-02-2024', 'dd-mm-yyyy'), 322864915);
insert into ORDERS (oid, orderdate, sid)
values (40293, to_date('04-06-2021', 'dd-mm-yyyy'), 322864813);
insert into ORDERS (oid, orderdate, sid)
values (40294, to_date('14-02-2023', 'dd-mm-yyyy'), 322865115);
insert into ORDERS (oid, orderdate, sid)
values (40295, to_date('11-08-2023', 'dd-mm-yyyy'), 322864958);
insert into ORDERS (oid, orderdate, sid)
values (40296, to_date('22-09-2021', 'dd-mm-yyyy'), 322864805);
insert into ORDERS (oid, orderdate, sid)
values (40297, to_date('24-07-2022', 'dd-mm-yyyy'), 322864922);
insert into ORDERS (oid, orderdate, sid)
values (40298, to_date('11-07-2021', 'dd-mm-yyyy'), 322864875);
commit;
prompt 300 records committed...
insert into ORDERS (oid, orderdate, sid)
values (40299, to_date('29-07-2021', 'dd-mm-yyyy'), 322865052);
insert into ORDERS (oid, orderdate, sid)
values (40300, to_date('18-11-2022', 'dd-mm-yyyy'), 322864948);
insert into ORDERS (oid, orderdate, sid)
values (40301, to_date('01-04-2023', 'dd-mm-yyyy'), 322864909);
insert into ORDERS (oid, orderdate, sid)
values (40302, to_date('04-01-2021', 'dd-mm-yyyy'), 322865087);
insert into ORDERS (oid, orderdate, sid)
values (40303, to_date('19-08-2022', 'dd-mm-yyyy'), 322864999);
insert into ORDERS (oid, orderdate, sid)
values (40304, to_date('11-07-2022', 'dd-mm-yyyy'), 322865112);
insert into ORDERS (oid, orderdate, sid)
values (40305, to_date('17-06-2021', 'dd-mm-yyyy'), 322864952);
insert into ORDERS (oid, orderdate, sid)
values (40306, to_date('08-12-2022', 'dd-mm-yyyy'), 322864911);
insert into ORDERS (oid, orderdate, sid)
values (40307, to_date('01-03-2023', 'dd-mm-yyyy'), 322864749);
insert into ORDERS (oid, orderdate, sid)
values (40308, to_date('27-03-2022', 'dd-mm-yyyy'), 322864798);
insert into ORDERS (oid, orderdate, sid)
values (40309, to_date('12-06-2023', 'dd-mm-yyyy'), 322864938);
insert into ORDERS (oid, orderdate, sid)
values (40310, to_date('19-03-2024', 'dd-mm-yyyy'), 322865104);
insert into ORDERS (oid, orderdate, sid)
values (40311, to_date('10-03-2022', 'dd-mm-yyyy'), 322865033);
insert into ORDERS (oid, orderdate, sid)
values (40312, to_date('16-10-2023', 'dd-mm-yyyy'), 322865050);
insert into ORDERS (oid, orderdate, sid)
values (40313, to_date('03-05-2022', 'dd-mm-yyyy'), 322865037);
insert into ORDERS (oid, orderdate, sid)
values (40314, to_date('28-02-2021', 'dd-mm-yyyy'), 322865095);
insert into ORDERS (oid, orderdate, sid)
values (40315, to_date('06-12-2022', 'dd-mm-yyyy'), 322865094);
insert into ORDERS (oid, orderdate, sid)
values (40316, to_date('15-04-2021', 'dd-mm-yyyy'), 322864999);
insert into ORDERS (oid, orderdate, sid)
values (40317, to_date('02-01-2021', 'dd-mm-yyyy'), 322864794);
insert into ORDERS (oid, orderdate, sid)
values (40318, to_date('14-01-2022', 'dd-mm-yyyy'), 322864794);
insert into ORDERS (oid, orderdate, sid)
values (40319, to_date('30-01-2021', 'dd-mm-yyyy'), 322864948);
insert into ORDERS (oid, orderdate, sid)
values (40320, to_date('28-03-2022', 'dd-mm-yyyy'), 322865123);
insert into ORDERS (oid, orderdate, sid)
values (40321, to_date('06-04-2021', 'dd-mm-yyyy'), 322864754);
insert into ORDERS (oid, orderdate, sid)
values (40322, to_date('23-03-2024', 'dd-mm-yyyy'), 322865111);
insert into ORDERS (oid, orderdate, sid)
values (40323, to_date('23-09-2023', 'dd-mm-yyyy'), 322864967);
insert into ORDERS (oid, orderdate, sid)
values (40324, to_date('05-03-2023', 'dd-mm-yyyy'), 322864843);
insert into ORDERS (oid, orderdate, sid)
values (40325, to_date('07-06-2023', 'dd-mm-yyyy'), 322865004);
insert into ORDERS (oid, orderdate, sid)
values (40326, to_date('26-10-2023', 'dd-mm-yyyy'), 322864816);
insert into ORDERS (oid, orderdate, sid)
values (40327, to_date('01-02-2021', 'dd-mm-yyyy'), 322864786);
insert into ORDERS (oid, orderdate, sid)
values (40328, to_date('05-01-2021', 'dd-mm-yyyy'), 322864833);
insert into ORDERS (oid, orderdate, sid)
values (40329, to_date('25-09-2022', 'dd-mm-yyyy'), 322865049);
insert into ORDERS (oid, orderdate, sid)
values (40330, to_date('05-09-2023', 'dd-mm-yyyy'), 322864910);
insert into ORDERS (oid, orderdate, sid)
values (40331, to_date('22-10-2022', 'dd-mm-yyyy'), 322864738);
insert into ORDERS (oid, orderdate, sid)
values (40332, to_date('16-12-2022', 'dd-mm-yyyy'), 322864861);
insert into ORDERS (oid, orderdate, sid)
values (40333, to_date('01-11-2022', 'dd-mm-yyyy'), 322865003);
insert into ORDERS (oid, orderdate, sid)
values (40334, to_date('25-02-2023', 'dd-mm-yyyy'), 322864933);
insert into ORDERS (oid, orderdate, sid)
values (40335, to_date('07-05-2023', 'dd-mm-yyyy'), 322865013);
insert into ORDERS (oid, orderdate, sid)
values (40336, to_date('07-01-2021', 'dd-mm-yyyy'), 322864756);
insert into ORDERS (oid, orderdate, sid)
values (40337, to_date('04-07-2022', 'dd-mm-yyyy'), 322864914);
insert into ORDERS (oid, orderdate, sid)
values (40338, to_date('28-02-2023', 'dd-mm-yyyy'), 322864786);
insert into ORDERS (oid, orderdate, sid)
values (40339, to_date('05-10-2021', 'dd-mm-yyyy'), 322864941);
insert into ORDERS (oid, orderdate, sid)
values (40340, to_date('01-09-2022', 'dd-mm-yyyy'), 322864894);
insert into ORDERS (oid, orderdate, sid)
values (40341, to_date('24-10-2022', 'dd-mm-yyyy'), 322865008);
insert into ORDERS (oid, orderdate, sid)
values (40342, to_date('02-02-2023', 'dd-mm-yyyy'), 322864888);
insert into ORDERS (oid, orderdate, sid)
values (40343, to_date('19-05-2021', 'dd-mm-yyyy'), 322864799);
insert into ORDERS (oid, orderdate, sid)
values (40344, to_date('24-05-2022', 'dd-mm-yyyy'), 322865017);
insert into ORDERS (oid, orderdate, sid)
values (40345, to_date('06-05-2024', 'dd-mm-yyyy'), 322864862);
insert into ORDERS (oid, orderdate, sid)
values (40346, to_date('14-12-2022', 'dd-mm-yyyy'), 322865050);
insert into ORDERS (oid, orderdate, sid)
values (40347, to_date('04-12-2022', 'dd-mm-yyyy'), 322864949);
insert into ORDERS (oid, orderdate, sid)
values (40348, to_date('13-08-2022', 'dd-mm-yyyy'), 322864970);
insert into ORDERS (oid, orderdate, sid)
values (40349, to_date('21-04-2021', 'dd-mm-yyyy'), 322865097);
insert into ORDERS (oid, orderdate, sid)
values (40350, to_date('23-01-2024', 'dd-mm-yyyy'), 322864879);
insert into ORDERS (oid, orderdate, sid)
values (40351, to_date('17-03-2021', 'dd-mm-yyyy'), 322865091);
insert into ORDERS (oid, orderdate, sid)
values (40352, to_date('08-08-2022', 'dd-mm-yyyy'), 322864965);
insert into ORDERS (oid, orderdate, sid)
values (40353, to_date('09-11-2022', 'dd-mm-yyyy'), 322864802);
insert into ORDERS (oid, orderdate, sid)
values (40354, to_date('19-06-2021', 'dd-mm-yyyy'), 322864906);
insert into ORDERS (oid, orderdate, sid)
values (40355, to_date('24-05-2022', 'dd-mm-yyyy'), 322864850);
insert into ORDERS (oid, orderdate, sid)
values (40356, to_date('16-11-2022', 'dd-mm-yyyy'), 322864976);
insert into ORDERS (oid, orderdate, sid)
values (40357, to_date('05-12-2023', 'dd-mm-yyyy'), 322865079);
insert into ORDERS (oid, orderdate, sid)
values (40358, to_date('23-12-2021', 'dd-mm-yyyy'), 322864835);
insert into ORDERS (oid, orderdate, sid)
values (40359, to_date('10-03-2024', 'dd-mm-yyyy'), 322864886);
insert into ORDERS (oid, orderdate, sid)
values (40360, to_date('26-04-2021', 'dd-mm-yyyy'), 322864848);
insert into ORDERS (oid, orderdate, sid)
values (40361, to_date('08-08-2023', 'dd-mm-yyyy'), 322865114);
insert into ORDERS (oid, orderdate, sid)
values (40362, to_date('27-06-2023', 'dd-mm-yyyy'), 322864926);
insert into ORDERS (oid, orderdate, sid)
values (40363, to_date('12-05-2023', 'dd-mm-yyyy'), 322864923);
insert into ORDERS (oid, orderdate, sid)
values (40364, to_date('21-05-2021', 'dd-mm-yyyy'), 322864740);
insert into ORDERS (oid, orderdate, sid)
values (40365, to_date('08-06-2023', 'dd-mm-yyyy'), 322864772);
insert into ORDERS (oid, orderdate, sid)
values (40366, to_date('03-04-2023', 'dd-mm-yyyy'), 322864890);
insert into ORDERS (oid, orderdate, sid)
values (40367, to_date('10-06-2023', 'dd-mm-yyyy'), 322865111);
insert into ORDERS (oid, orderdate, sid)
values (40368, to_date('19-11-2021', 'dd-mm-yyyy'), 322865087);
insert into ORDERS (oid, orderdate, sid)
values (40369, to_date('27-07-2022', 'dd-mm-yyyy'), 322864922);
insert into ORDERS (oid, orderdate, sid)
values (40370, to_date('07-05-2021', 'dd-mm-yyyy'), 322865124);
insert into ORDERS (oid, orderdate, sid)
values (40371, to_date('07-05-2022', 'dd-mm-yyyy'), 322865109);
insert into ORDERS (oid, orderdate, sid)
values (40372, to_date('13-03-2022', 'dd-mm-yyyy'), 322864896);
insert into ORDERS (oid, orderdate, sid)
values (40373, to_date('26-03-2023', 'dd-mm-yyyy'), 322865077);
insert into ORDERS (oid, orderdate, sid)
values (40374, to_date('05-08-2022', 'dd-mm-yyyy'), 322865057);
insert into ORDERS (oid, orderdate, sid)
values (40375, to_date('03-12-2023', 'dd-mm-yyyy'), 322864893);
insert into ORDERS (oid, orderdate, sid)
values (40376, to_date('28-08-2022', 'dd-mm-yyyy'), 322864753);
insert into ORDERS (oid, orderdate, sid)
values (40377, to_date('24-11-2022', 'dd-mm-yyyy'), 322864771);
insert into ORDERS (oid, orderdate, sid)
values (40378, to_date('30-06-2023', 'dd-mm-yyyy'), 322865031);
insert into ORDERS (oid, orderdate, sid)
values (40379, to_date('21-07-2022', 'dd-mm-yyyy'), 322864889);
insert into ORDERS (oid, orderdate, sid)
values (40380, to_date('01-06-2023', 'dd-mm-yyyy'), 322864968);
insert into ORDERS (oid, orderdate, sid)
values (40381, to_date('06-08-2023', 'dd-mm-yyyy'), 322865053);
insert into ORDERS (oid, orderdate, sid)
values (40382, to_date('22-05-2021', 'dd-mm-yyyy'), 322864904);
insert into ORDERS (oid, orderdate, sid)
values (40383, to_date('05-12-2021', 'dd-mm-yyyy'), 322865035);
insert into ORDERS (oid, orderdate, sid)
values (40384, to_date('08-11-2021', 'dd-mm-yyyy'), 322864839);
insert into ORDERS (oid, orderdate, sid)
values (40385, to_date('09-02-2021', 'dd-mm-yyyy'), 322864905);
insert into ORDERS (oid, orderdate, sid)
values (40386, to_date('07-02-2022', 'dd-mm-yyyy'), 322864973);
insert into ORDERS (oid, orderdate, sid)
values (40387, to_date('22-06-2023', 'dd-mm-yyyy'), 322864760);
insert into ORDERS (oid, orderdate, sid)
values (40388, to_date('20-01-2022', 'dd-mm-yyyy'), 322865041);
insert into ORDERS (oid, orderdate, sid)
values (40389, to_date('23-06-2021', 'dd-mm-yyyy'), 322864992);
insert into ORDERS (oid, orderdate, sid)
values (40390, to_date('12-06-2022', 'dd-mm-yyyy'), 322864831);
insert into ORDERS (oid, orderdate, sid)
values (40391, to_date('20-10-2021', 'dd-mm-yyyy'), 322865095);
insert into ORDERS (oid, orderdate, sid)
values (40392, to_date('11-06-2022', 'dd-mm-yyyy'), 322864740);
insert into ORDERS (oid, orderdate, sid)
values (40393, to_date('04-11-2023', 'dd-mm-yyyy'), 322864734);
insert into ORDERS (oid, orderdate, sid)
values (40394, to_date('30-08-2021', 'dd-mm-yyyy'), 322864941);
insert into ORDERS (oid, orderdate, sid)
values (40395, to_date('28-01-2024', 'dd-mm-yyyy'), 322864906);
insert into ORDERS (oid, orderdate, sid)
values (40396, to_date('25-04-2022', 'dd-mm-yyyy'), 322865034);
insert into ORDERS (oid, orderdate, sid)
values (40397, to_date('31-10-2023', 'dd-mm-yyyy'), 322865096);
insert into ORDERS (oid, orderdate, sid)
values (40398, to_date('16-04-2021', 'dd-mm-yyyy'), 322864941);
commit;
prompt 400 records loaded
prompt Loading EQUIP_ORDER...
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (72, 10304, 39999);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (36, 10140, 40000);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (52, 10402, 40001);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (52, 10073, 40002);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (52, 10202, 40003);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (51, 10399, 40004);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (59, 10004, 40005);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (34, 10036, 40006);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (47, 10202, 40007);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (53, 10003, 40008);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10263, 40009);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10222, 40010);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (56, 10211, 40011);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (64, 10083, 40012);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10279, 40013);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (52, 10278, 40014);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10117, 40015);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (56, 10304, 40016);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (70, 10305, 40017);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (53, 10254, 40018);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (24, 10071, 40019);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (60, 10287, 40020);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10227, 40021);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (67, 10125, 40022);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (30, 10188, 40023);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (47, 10259, 40024);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10285, 40025);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (68, 10143, 40026);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (24, 10075, 40027);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (2, 10098, 40028);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (74, 10010, 40029);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10000, 40030);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10200, 40031);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10033, 40032);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (74, 10207, 40033);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (32, 10045, 40034);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (68, 10255, 40035);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (57, 10145, 40036);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (64, 10327, 40037);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10091, 40038);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (29, 10171, 40039);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (50, 10309, 40040);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (56, 10098, 40041);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10276, 40042);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10153, 40043);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10148, 40044);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (61, 10174, 40045);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (64, 10329, 40046);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10124, 40047);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (3, 10240, 40048);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (2, 10185, 40049);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (50, 10073, 40050);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10213, 40051);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (56, 10104, 40052);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (23, 10245, 40053);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (49, 10361, 40054);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (59, 10258, 40055);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (2, 10259, 40056);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10262, 40057);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (65, 10396, 40058);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (46, 10337, 40059);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (75, 10265, 40060);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (70, 10286, 40061);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (48, 10333, 40062);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (60, 10325, 40063);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (67, 10025, 40064);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (57, 10273, 40065);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (54, 10267, 40066);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (68, 10068, 40067);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10301, 40068);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10078, 40069);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10057, 40070);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (46, 10205, 40071);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (42, 10022, 40072);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (73, 10082, 40073);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10383, 40074);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (62, 10375, 40075);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10085, 40076);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (55, 10018, 40077);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (26, 10197, 40078);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10085, 40079);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (50, 10313, 40080);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (40, 10056, 40081);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (26, 10258, 40082);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (47, 10201, 40083);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (44, 10071, 40084);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (68, 10083, 40085);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (68, 10226, 40086);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (51, 10231, 40087);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (66, 10121, 40088);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (58, 10029, 40089);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (61, 10225, 40090);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (47, 10272, 40091);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (35, 10057, 40092);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (48, 10008, 40093);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (54, 10013, 40094);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10359, 40095);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (2, 10217, 40096);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10287, 40097);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (55, 10190, 40098);
commit;
prompt 100 records committed...
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (68, 10042, 40099);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (62, 10373, 40100);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (34, 10269, 40101);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (60, 10205, 40102);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (49, 10210, 40103);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (21, 10076, 40104);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (32, 10128, 40105);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (75, 10018, 40106);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (3, 10293, 40107);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10234, 40108);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10243, 40109);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (39, 10180, 40110);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (68, 10137, 40111);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (26, 10270, 40112);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (28, 10059, 40113);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (39, 10312, 40114);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (53, 10084, 40115);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (67, 10149, 40116);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (40, 10400, 40117);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (61, 10043, 40118);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (3, 10068, 40119);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (53, 10020, 40120);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (33, 10358, 40121);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (25, 10369, 40122);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (35, 10153, 40123);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (59, 10270, 40124);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (69, 10061, 40125);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (30, 10195, 40126);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (56, 10084, 40127);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (55, 10001, 40128);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (71, 10037, 40129);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (61, 10173, 40130);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (26, 10273, 40131);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (73, 10372, 40132);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (3, 10398, 40133);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (64, 10099, 40134);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10195, 40135);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (67, 10294, 40136);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (68, 10251, 40137);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (67, 10375, 40138);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (45, 10231, 40139);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (50, 10230, 40140);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (43, 10169, 40141);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (73, 10270, 40142);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (21, 10112, 40143);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (73, 10362, 40144);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (47, 10033, 40145);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10239, 40146);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (31, 10008, 40147);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (37, 10402, 40148);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (69, 10341, 40149);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (59, 10233, 40150);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10230, 40151);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10235, 40152);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (38, 10103, 40153);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10050, 40154);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (39, 10356, 40155);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (48, 10184, 40156);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (66, 10221, 40157);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (64, 10115, 40158);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (60, 10191, 40159);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (44, 10085, 40160);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (46, 10220, 40161);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (46, 10273, 40162);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (67, 10154, 40163);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10009, 40164);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10063, 40165);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (31, 10212, 40166);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (65, 10271, 40167);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (61, 10197, 40168);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (36, 10165, 40169);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (22, 10322, 40170);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (41, 10212, 40171);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (50, 10210, 40172);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (50, 10027, 40173);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (42, 10157, 40174);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (35, 10347, 40175);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (56, 10135, 40176);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (52, 10322, 40177);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (44, 10147, 40178);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10222, 40179);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (37, 10184, 40180);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10362, 40181);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (36, 10110, 40182);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (23, 10071, 40183);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (33, 10336, 40184);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (50, 10240, 40185);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (41, 10209, 40186);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (32, 10145, 40187);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (67, 10391, 40188);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (63, 10365, 40189);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (44, 10322, 40190);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10260, 40191);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (28, 10064, 40192);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10019, 40193);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (75, 10243, 40194);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (41, 10386, 40195);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (59, 10306, 40196);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (58, 10176, 40197);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (54, 10310, 40198);
commit;
prompt 200 records committed...
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (75, 10246, 40199);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (46, 10212, 40200);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (34, 10086, 40201);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (65, 10044, 40202);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10357, 40203);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (54, 10010, 40204);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (31, 10148, 40205);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (28, 10038, 40206);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (66, 10069, 40207);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10042, 40208);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10158, 40209);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10244, 40210);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10269, 40211);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10165, 40212);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (33, 10214, 40213);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (60, 10296, 40214);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (32, 10256, 40215);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (42, 10398, 40216);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (63, 10227, 40217);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (46, 10270, 40218);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10097, 40219);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (53, 10374, 40220);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (32, 10066, 40221);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (23, 10254, 40222);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10376, 40223);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10039, 40224);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10332, 40225);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10341, 40226);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (36, 10159, 40227);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10366, 40228);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (36, 10134, 40229);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (26, 10261, 40230);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (65, 10026, 40231);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10062, 40232);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (30, 10333, 40233);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (44, 10226, 40234);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (66, 10083, 40235);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (48, 10375, 40236);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (2, 10156, 40237);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (55, 10208, 40238);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10221, 40239);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (46, 10236, 40240);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (72, 10088, 40241);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (66, 10030, 40242);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (60, 10196, 40243);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10307, 40244);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (26, 10153, 40245);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (68, 10306, 40246);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (33, 10340, 40247);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10193, 40248);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10031, 40249);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (2, 10165, 40250);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (44, 10082, 40251);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (36, 10120, 40252);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (33, 10210, 40253);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (73, 10256, 40254);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (44, 10320, 40255);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10211, 40256);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (44, 10140, 40257);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (23, 10120, 40258);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10377, 40259);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10201, 40260);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (41, 10243, 40261);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (4, 10032, 40262);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10025, 40263);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (47, 10377, 40264);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10114, 40265);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (46, 10043, 40266);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (40, 10118, 40267);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (31, 10129, 40268);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (71, 10179, 40269);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (22, 10256, 40270);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (25, 10232, 40271);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (25, 10159, 40272);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10353, 40273);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (40, 10319, 40274);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (56, 10150, 40275);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (23, 10267, 40276);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (49, 10130, 40277);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10158, 40278);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (42, 10383, 40279);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (58, 10403, 40280);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10120, 40281);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (41, 10328, 40282);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (28, 10072, 40283);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (61, 10120, 40284);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (73, 10169, 40285);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (64, 10374, 40286);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (27, 10380, 40287);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10075, 40288);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (41, 10140, 40289);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10038, 40290);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10028, 40291);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (47, 10328, 40292);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (26, 10102, 40293);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (65, 10096, 40294);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (36, 10353, 40295);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (22, 10273, 40296);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (46, 10352, 40297);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (31, 10383, 40298);
commit;
prompt 300 records committed...
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10081, 40299);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (23, 10220, 40300);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (70, 10044, 40301);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (63, 10277, 40302);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (33, 10033, 40303);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (28, 10165, 40304);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10085, 40305);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (33, 10007, 40306);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (34, 10381, 40307);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (47, 10211, 40308);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (28, 10199, 40309);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (29, 10376, 40310);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (21, 10140, 40311);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (44, 10195, 40312);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (45, 10258, 40313);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (21, 10084, 40314);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (4, 10138, 40315);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (49, 10160, 40316);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (29, 10225, 40317);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (28, 10348, 40318);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10134, 40319);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (48, 10035, 40320);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (70, 10322, 40321);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (55, 10254, 40322);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (51, 10219, 40323);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (73, 10154, 40324);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (41, 10217, 40325);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10220, 40326);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10009, 40327);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (60, 10180, 40328);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10053, 40329);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (49, 10218, 40330);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (64, 10092, 40331);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (64, 10079, 40332);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (69, 10081, 40333);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (39, 10063, 40334);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (71, 10065, 40335);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10305, 40336);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (39, 10133, 40337);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10109, 40338);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (36, 10026, 40339);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (37, 10402, 40340);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (58, 10110, 40341);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (25, 10372, 40342);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (23, 10278, 40343);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (57, 10047, 40344);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10309, 40345);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (40, 10068, 40346);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (39, 10050, 40347);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10125, 40348);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10353, 40349);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (21, 10019, 40350);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (4, 10073, 40351);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (64, 10190, 40352);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (2, 10373, 40353);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (73, 10219, 40354);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (54, 10138, 40355);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10397, 40356);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (4, 10391, 40357);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (22, 10269, 40358);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (41, 10113, 40359);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (2, 10223, 40360);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (45, 10343, 40361);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (23, 10235, 40362);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (24, 10378, 40363);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (62, 10046, 40364);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10320, 40365);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (48, 10313, 40366);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (39, 10058, 40367);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (29, 10325, 40368);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10235, 40369);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (21, 10126, 40370);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (48, 10344, 40371);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (36, 10398, 40372);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (31, 10118, 40373);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10064, 40374);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (48, 10352, 40375);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (60, 10135, 40376);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10237, 40377);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (64, 10213, 40378);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (67, 10083, 40379);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (45, 10002, 40380);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (31, 10229, 40381);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (40, 10139, 40382);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (22, 10381, 40383);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10340, 40384);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (21, 10081, 40385);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (25, 10291, 40386);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (58, 10287, 40387);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (48, 10263, 40388);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (75, 10121, 40389);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10214, 40390);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10271, 40391);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10225, 40392);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (33, 10026, 40393);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (39, 10010, 40394);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10049, 40395);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10159, 40396);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (3, 10080, 40397);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (61, 10212, 40398);
commit;
prompt 400 records committed...
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10171, 40361);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10126, 40271);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10136, 40045);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10387, 40088);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10154, 40003);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10369, 40163);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10277, 40345);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10350, 40389);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10249, 40166);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10000, 40012);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10298, 40225);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10297, 40047);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10022, 40247);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10103, 40312);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10050, 40198);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10296, 40062);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10142, 40331);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10282, 40068);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10395, 40103);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10395, 40162);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10308, 40204);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10305, 40247);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10347, 40176);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10185, 40195);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10113, 40219);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10055, 40062);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10135, 40237);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10248, 40388);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10386, 40185);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10300, 40110);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10248, 40189);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10149, 40161);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10378, 40063);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10020, 40061);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10355, 40296);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10295, 40022);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10401, 40046);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10271, 40313);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10077, 40226);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10095, 40029);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10220, 40018);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10022, 40311);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10049, 40347);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10361, 40346);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10175, 40152);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10209, 40341);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10206, 40048);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10147, 40373);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10397, 40046);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10031, 40105);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10388, 40366);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10216, 40195);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10047, 40370);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10303, 40278);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10399, 40315);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10309, 40204);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10205, 40212);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10139, 40166);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10386, 40372);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10162, 40056);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10033, 40286);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10341, 40254);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10076, 40332);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10156, 40223);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10136, 40219);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10382, 40165);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10365, 40386);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10022, 40281);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10116, 40246);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10151, 40225);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10337, 40021);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10162, 40209);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10008, 40159);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10385, 40155);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10296, 40217);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10184, 40239);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10056, 40020);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10268, 40072);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10034, 40119);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10225, 40124);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10252, 40092);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10038, 40338);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10288, 40274);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10241, 40378);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10340, 40297);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10003, 40027);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10064, 40202);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10242, 40142);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10302, 40052);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10001, 40351);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10389, 40198);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10203, 40170);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10167, 40102);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10193, 40298);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10265, 40128);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10110, 40011);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10065, 40114);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10083, 40171);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10146, 40139);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10092, 40011);
commit;
prompt 500 records committed...
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10338, 40316);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10311, 40093);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10084, 40096);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10210, 40239);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10075, 40127);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10330, 40333);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10329, 40011);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10211, 40357);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10118, 40377);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10161, 40363);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10357, 40324);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10284, 40062);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10384, 40387);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10108, 40040);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10052, 40274);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10233, 40216);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10252, 40209);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10208, 40362);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10268, 40396);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10163, 40259);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10330, 40082);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10067, 40029);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10119, 40050);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10103, 40381);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10369, 40055);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10162, 40147);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10182, 40184);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10145, 40234);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10347, 40047);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10198, 40297);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10272, 40036);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10347, 40067);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10078, 40273);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10262, 40101);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10351, 40198);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10150, 40265);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10140, 40129);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10160, 40129);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10329, 40114);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10394, 40171);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10080, 40056);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10045, 40063);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10232, 40264);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10226, 40375);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10113, 40266);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10345, 40154);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10328, 40092);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10247, 40354);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10076, 40274);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10281, 40107);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10071, 40125);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10364, 40232);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10000, 40092);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10031, 40022);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10097, 40364);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10262, 40358);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10338, 40047);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10386, 40124);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10277, 40364);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10038, 40069);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10340, 40273);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10315, 40110);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10265, 40103);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10247, 40331);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10071, 40238);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10205, 40244);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10223, 40056);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10295, 40231);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10354, 40360);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10099, 40046);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10260, 40169);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10302, 40198);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10247, 40271);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10094, 40074);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10101, 40345);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10315, 40152);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10283, 40376);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10078, 40070);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10176, 40351);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10171, 40038);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10396, 40278);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10134, 40366);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10168, 40344);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10161, 40349);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10114, 40116);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10193, 40008);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10043, 40130);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10333, 40298);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10283, 40168);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10063, 40309);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10233, 40160);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10009, 40244);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10355, 40188);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10236, 40277);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10121, 40166);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10393, 40228);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10390, 40021);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10354, 40043);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10171, 40246);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10330, 40218);
commit;
prompt 600 records committed...
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10010, 40361);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10384, 40115);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10220, 40109);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10026, 40140);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10403, 40205);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10380, 40003);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10258, 40276);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10155, 40273);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10225, 40053);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10033, 40233);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10052, 40345);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10041, 40293);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10152, 40026);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10149, 40286);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10123, 40345);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10336, 40140);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10296, 40137);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10202, 40296);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10208, 40050);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10346, 40004);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10170, 40094);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10341, 40036);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10350, 40097);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10055, 40395);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10157, 40070);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10199, 40024);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10143, 40384);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10054, 40186);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10256, 40017);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10250, 40071);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10266, 40175);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10321, 40211);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10070, 40355);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10276, 40325);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10011, 40004);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10142, 40100);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10088, 40222);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10098, 40315);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10398, 40395);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10337, 40126);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10335, 40317);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10159, 40046);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10312, 40099);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10176, 40350);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10262, 40301);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10035, 40068);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10314, 40249);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10041, 40246);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10225, 40017);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10343, 40352);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10145, 40156);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10010, 40085);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10120, 40277);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10279, 40299);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10325, 40130);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10354, 40262);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10172, 40278);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10068, 40330);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10139, 40049);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10397, 40040);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10057, 40000);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10376, 40360);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10183, 40081);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10318, 40103);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10344, 40045);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10077, 40220);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10350, 40050);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (10, 10097, 40192);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (12, 10210, 40268);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (20, 10394, 40329);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10020, 40075);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10023, 40006);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10058, 40266);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (18, 10035, 40267);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (9, 10009, 40368);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10372, 40049);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (6, 10384, 40070);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (17, 10035, 40173);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (13, 10318, 40211);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10022, 40012);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (19, 10041, 40301);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10329, 40398);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (8, 10322, 40212);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (11, 10328, 40356);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (5, 10009, 40355);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (15, 10079, 40146);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10065, 40044);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10058, 40092);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (7, 10275, 40051);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (16, 10144, 40332);
insert into EQUIP_ORDER (amountinorder, eid, oid)
values (14, 10224, 40381);
commit;
prompt 691 records loaded
prompt Loading REPAIRS...
insert into REPAIRS (rid, repairdate, description)
values (62010, to_date('09-11-2022', 'dd-mm-yyyy'), 'safety risks');
insert into REPAIRS (rid, repairdate, description)
values (62011, to_date('08-05-2024', 'dd-mm-yyyy'), 'landing gear');
insert into REPAIRS (rid, repairdate, description)
values (62012, to_date('15-04-2022', 'dd-mm-yyyy'), 'safety risks');
insert into REPAIRS (rid, repairdate, description)
values (62013, to_date('16-04-2024', 'dd-mm-yyyy'), 'lightning strikes');
insert into REPAIRS (rid, repairdate, description)
values (62014, to_date('30-07-2023', 'dd-mm-yyyy'), 'communication equipment');
insert into REPAIRS (rid, repairdate, description)
values (62015, to_date('03-10-2022', 'dd-mm-yyyy'), 'Turbulence');
insert into REPAIRS (rid, repairdate, description)
values (62016, to_date('05-06-2023', 'dd-mm-yyyy'), 'hydraulics');
insert into REPAIRS (rid, repairdate, description)
values (62017, to_date('18-08-2023', 'dd-mm-yyyy'), 'communication equipment');
insert into REPAIRS (rid, repairdate, description)
values (62018, to_date('06-12-2022', 'dd-mm-yyyy'), 'hydraulics');
insert into REPAIRS (rid, repairdate, description)
values (62019, to_date('30-06-2021', 'dd-mm-yyyy'), 'Turbulence');
insert into REPAIRS (rid, repairdate, description)
values (62020, to_date('21-08-2021', 'dd-mm-yyyy'), 'lightning strikes');
insert into REPAIRS (rid, repairdate, description)
values (62021, to_date('26-12-2023', 'dd-mm-yyyy'), 'Turbulence');
insert into REPAIRS (rid, repairdate, description)
values (62022, to_date('03-06-2023', 'dd-mm-yyyy'), 'Issues with engines');
insert into REPAIRS (rid, repairdate, description)
values (62023, to_date('06-03-2022', 'dd-mm-yyyy'), 'lightning strikes');
insert into REPAIRS (rid, repairdate, description)
values (62024, to_date('05-02-2021', 'dd-mm-yyyy'), 'safety risks');
insert into REPAIRS (rid, repairdate, description)
values (62025, to_date('15-04-2022', 'dd-mm-yyyy'), 'Turbulence');
insert into REPAIRS (rid, repairdate, description)
values (62026, to_date('10-08-2022', 'dd-mm-yyyy'), 'hydraulics');
insert into REPAIRS (rid, repairdate, description)
values (62027, to_date('09-05-2022', 'dd-mm-yyyy'), 'landing gear');
insert into REPAIRS (rid, repairdate, description)
values (62028, to_date('27-03-2023', 'dd-mm-yyyy'), 'landing gear');
insert into REPAIRS (rid, repairdate, description)
values (62029, to_date('18-09-2021', 'dd-mm-yyyy'), 'safety risks');
insert into REPAIRS (rid, repairdate, description)
values (62030, to_date('27-03-2022', 'dd-mm-yyyy'), 'communication equipment');
insert into REPAIRS (rid, repairdate, description)
values (62031, to_date('06-04-2023', 'dd-mm-yyyy'), 'safety risks');
insert into REPAIRS (rid, repairdate, description)
values (62032, to_date('10-12-2023', 'dd-mm-yyyy'), 'hydraulics');
insert into REPAIRS (rid, repairdate, description)
values (62033, to_date('13-01-2023', 'dd-mm-yyyy'), 'hydraulics');
insert into REPAIRS (rid, repairdate, description)
values (62034, to_date('04-10-2021', 'dd-mm-yyyy'), 'safety risks');
insert into REPAIRS (rid, repairdate, description)
values (62035, to_date('27-05-2023', 'dd-mm-yyyy'), 'communication equipment');
insert into REPAIRS (rid, repairdate, description)
values (62036, to_date('05-01-2022', 'dd-mm-yyyy'), 'lightning strikes');
insert into REPAIRS (rid, repairdate, description)
values (62037, to_date('28-01-2022', 'dd-mm-yyyy'), 'Turbulence');
insert into REPAIRS (rid, repairdate, description)
values (62038, to_date('25-01-2023', 'dd-mm-yyyy'), 'safety risks');
insert into REPAIRS (rid, repairdate, description)
values (62039, to_date('11-08-2021', 'dd-mm-yyyy'), 'communication equipment');
insert into REPAIRS (rid, repairdate, description)
values (62040, to_date('02-01-2023', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62041, to_date('04-01-2021', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62042, to_date('24-06-2022', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62043, to_date('19-02-2023', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62044, to_date('31-07-2023', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62045, to_date('22-01-2024', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62046, to_date('30-09-2021', 'dd-mm-yyyy'), 'ABS malfunctions');
insert into REPAIRS (rid, repairdate, description)
values (62047, to_date('05-04-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62048, to_date('07-08-2022', 'dd-mm-yyyy'), 'malfunctioning alternators');
insert into REPAIRS (rid, repairdate, description)
values (62049, to_date('02-06-2023', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62050, to_date('16-10-2022', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62051, to_date('24-05-2021', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62052, to_date('16-10-2023', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62053, to_date('10-01-2022', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62054, to_date('28-05-2021', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62055, to_date('09-04-2023', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62056, to_date('08-04-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62057, to_date('12-12-2021', 'dd-mm-yyyy'), 'ABS malfunctions');
insert into REPAIRS (rid, repairdate, description)
values (62058, to_date('12-02-2024', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62059, to_date('03-05-2023', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62060, to_date('25-11-2022', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62061, to_date('20-11-2023', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62062, to_date('24-07-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62063, to_date('08-12-2022', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62064, to_date('06-02-2024', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62065, to_date('03-11-2021', 'dd-mm-yyyy'), 'ABS malfunctions');
insert into REPAIRS (rid, repairdate, description)
values (62066, to_date('12-04-2022', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62067, to_date('20-01-2024', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62068, to_date('03-03-2022', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62069, to_date('12-05-2023', 'dd-mm-yyyy'), 'malfunctioning alternators');
insert into REPAIRS (rid, repairdate, description)
values (62070, to_date('10-04-2024', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62071, to_date('03-08-2022', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62072, to_date('11-08-2022', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62073, to_date('17-04-2024', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62074, to_date('02-10-2023', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62075, to_date('09-11-2023', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62076, to_date('03-03-2021', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62077, to_date('17-09-2022', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62078, to_date('04-08-2022', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62079, to_date('25-09-2022', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62080, to_date('15-05-2022', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62081, to_date('28-02-2021', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62082, to_date('21-09-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62083, to_date('22-12-2022', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62084, to_date('05-05-2024', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62085, to_date('30-01-2024', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62086, to_date('16-11-2023', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62087, to_date('27-02-2021', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62088, to_date('31-03-2024', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62089, to_date('17-07-2023', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62090, to_date('25-12-2022', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62091, to_date('18-01-2023', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62092, to_date('09-11-2023', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62093, to_date('08-03-2024', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62094, to_date('14-04-2024', 'dd-mm-yyyy'), 'ABS malfunctions');
insert into REPAIRS (rid, repairdate, description)
values (62095, to_date('09-03-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62096, to_date('27-10-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62097, to_date('12-08-2022', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62098, to_date('04-01-2024', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62099, to_date('30-10-2021', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62100, to_date('05-02-2023', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62101, to_date('30-07-2022', 'dd-mm-yyyy'), 'ABS malfunctions');
insert into REPAIRS (rid, repairdate, description)
values (62102, to_date('09-02-2023', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62103, to_date('27-12-2022', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62104, to_date('20-06-2021', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62105, to_date('03-08-2021', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62106, to_date('19-04-2024', 'dd-mm-yyyy'), 'malfunctioning alternators');
insert into REPAIRS (rid, repairdate, description)
values (62107, to_date('10-06-2021', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62108, to_date('04-12-2022', 'dd-mm-yyyy'), 'ABS malfunctions');
insert into REPAIRS (rid, repairdate, description)
values (62109, to_date('15-02-2023', 'dd-mm-yyyy'), 'fluid leaks');
commit;
prompt 100 records committed...
insert into REPAIRS (rid, repairdate, description)
values (62110, to_date('15-07-2022', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62111, to_date('09-09-2021', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62112, to_date('06-11-2021', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62113, to_date('01-09-2023', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62114, to_date('09-10-2022', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62115, to_date('30-01-2023', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62116, to_date('09-06-2021', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62117, to_date('12-12-2021', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62118, to_date('01-02-2024', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62119, to_date('25-05-2022', 'dd-mm-yyyy'), 'ABS malfunctions');
insert into REPAIRS (rid, repairdate, description)
values (62120, to_date('06-11-2023', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62121, to_date('06-05-2023', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62122, to_date('29-04-2024', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62123, to_date('24-09-2021', 'dd-mm-yyyy'), 'ABS malfunctions');
insert into REPAIRS (rid, repairdate, description)
values (62124, to_date('12-12-2023', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62125, to_date('12-06-2022', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62126, to_date('05-08-2021', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62127, to_date('06-05-2021', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62128, to_date('04-08-2023', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62129, to_date('08-06-2021', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62130, to_date('13-09-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62131, to_date('10-03-2021', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62132, to_date('02-06-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62133, to_date('25-03-2023', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62134, to_date('07-05-2021', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62135, to_date('03-05-2024', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62136, to_date('23-05-2022', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62137, to_date('09-03-2023', 'dd-mm-yyyy'), 'malfunctioning alternators');
insert into REPAIRS (rid, repairdate, description)
values (62138, to_date('19-12-2023', 'dd-mm-yyyy'), 'ABS malfunctions');
insert into REPAIRS (rid, repairdate, description)
values (62139, to_date('02-01-2022', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62140, to_date('19-05-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62141, to_date('30-12-2022', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62142, to_date('13-07-2021', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62143, to_date('10-02-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62144, to_date('26-02-2023', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62145, to_date('22-10-2022', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62146, to_date('10-08-2022', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62147, to_date('15-12-2022', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62148, to_date('17-05-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62149, to_date('02-01-2022', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62150, to_date('11-03-2022', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62151, to_date('02-02-2024', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62152, to_date('24-05-2023', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62153, to_date('25-11-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62154, to_date('19-08-2021', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62155, to_date('12-07-2022', 'dd-mm-yyyy'), 'malfunctioning alternators');
insert into REPAIRS (rid, repairdate, description)
values (62156, to_date('28-11-2023', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62157, to_date('25-07-2023', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62158, to_date('17-08-2021', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62159, to_date('07-06-2022', 'dd-mm-yyyy'), 'malfunctioning alternators');
insert into REPAIRS (rid, repairdate, description)
values (62160, to_date('13-10-2021', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62161, to_date('26-02-2024', 'dd-mm-yyyy'), 'ABS malfunctions');
insert into REPAIRS (rid, repairdate, description)
values (62162, to_date('17-03-2022', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62163, to_date('17-10-2023', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62164, to_date('29-01-2021', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62165, to_date('15-12-2021', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62166, to_date('16-12-2022', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62167, to_date('04-03-2024', 'dd-mm-yyyy'), 'malfunctioning alternators');
insert into REPAIRS (rid, repairdate, description)
values (62168, to_date('08-05-2021', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62169, to_date('16-04-2023', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62170, to_date('05-06-2023', 'dd-mm-yyyy'), 'ABS malfunctions');
insert into REPAIRS (rid, repairdate, description)
values (62171, to_date('04-05-2022', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62172, to_date('03-02-2024', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62173, to_date('02-04-2024', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62174, to_date('02-10-2023', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62175, to_date('30-10-2023', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62176, to_date('21-06-2022', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62177, to_date('19-06-2021', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62178, to_date('13-02-2022', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62179, to_date('18-04-2021', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62180, to_date('02-10-2021', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62181, to_date('23-04-2021', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62182, to_date('01-08-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62183, to_date('14-03-2024', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62184, to_date('01-09-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62185, to_date('02-01-2024', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62186, to_date('15-10-2022', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62187, to_date('28-08-2022', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62188, to_date('08-12-2021', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62189, to_date('11-02-2023', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62190, to_date('18-03-2022', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62191, to_date('23-04-2024', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62192, to_date('05-03-2023', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62193, to_date('30-11-2023', 'dd-mm-yyyy'), 'malfunctioning alternators');
insert into REPAIRS (rid, repairdate, description)
values (62194, to_date('09-11-2023', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62195, to_date('29-12-2021', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62196, to_date('07-04-2024', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62197, to_date('04-01-2023', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62198, to_date('05-08-2022', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62199, to_date('06-04-2024', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62200, to_date('11-12-2021', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62201, to_date('20-09-2023', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62202, to_date('21-03-2024', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62203, to_date('23-06-2023', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62204, to_date('14-04-2023', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62205, to_date('24-11-2022', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62206, to_date('23-01-2024', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62207, to_date('09-05-2023', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62208, to_date('09-08-2023', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62209, to_date('14-05-2023', 'dd-mm-yyyy'), 'fluid leaks');
commit;
prompt 200 records committed...
insert into REPAIRS (rid, repairdate, description)
values (62210, to_date('20-01-2023', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62211, to_date('14-01-2021', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62212, to_date('15-10-2021', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62213, to_date('26-02-2021', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62214, to_date('21-09-2023', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62215, to_date('15-07-2021', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62216, to_date('21-04-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62217, to_date('25-09-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62218, to_date('20-12-2022', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62219, to_date('29-07-2023', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62220, to_date('09-11-2023', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62221, to_date('17-04-2024', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62222, to_date('08-01-2022', 'dd-mm-yyyy'), 'malfunctioning alternators');
insert into REPAIRS (rid, repairdate, description)
values (62223, to_date('20-04-2024', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62224, to_date('29-10-2021', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62225, to_date('24-06-2021', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62226, to_date('12-01-2023', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62227, to_date('13-07-2022', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62228, to_date('27-01-2021', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62229, to_date('02-05-2021', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62230, to_date('11-07-2022', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62231, to_date('02-11-2023', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62232, to_date('02-11-2021', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62233, to_date('04-10-2023', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62234, to_date('13-12-2021', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62235, to_date('25-11-2023', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62236, to_date('26-10-2022', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62237, to_date('19-07-2022', 'dd-mm-yyyy'), 'ABS malfunctions');
insert into REPAIRS (rid, repairdate, description)
values (62238, to_date('22-07-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62239, to_date('16-03-2024', 'dd-mm-yyyy'), 'malfunctioning alternators');
insert into REPAIRS (rid, repairdate, description)
values (62240, to_date('18-01-2021', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62241, to_date('04-12-2022', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62242, to_date('24-03-2021', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62243, to_date('30-07-2022', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62244, to_date('01-03-2022', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62245, to_date('07-09-2023', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62246, to_date('13-07-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62247, to_date('10-07-2022', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62248, to_date('12-10-2023', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62249, to_date('29-07-2021', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62250, to_date('04-08-2021', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62251, to_date('08-03-2024', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62252, to_date('11-10-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62253, to_date('18-05-2024', 'dd-mm-yyyy'), 'Faulty wiring');
insert into REPAIRS (rid, repairdate, description)
values (62254, to_date('18-12-2023', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62255, to_date('21-12-2023', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62256, to_date('28-10-2022', 'dd-mm-yyyy'), 'malfunctioning alternators');
insert into REPAIRS (rid, repairdate, description)
values (62257, to_date('05-11-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62258, to_date('03-10-2022', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62259, to_date('02-11-2022', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62260, to_date('06-10-2021', 'dd-mm-yyyy'), 'malfunctioning alternators');
insert into REPAIRS (rid, repairdate, description)
values (62261, to_date('19-11-2022', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62262, to_date('25-06-2022', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62263, to_date('21-12-2022', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62264, to_date('09-12-2022', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62265, to_date('15-07-2023', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62266, to_date('23-03-2023', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62267, to_date('12-12-2022', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62268, to_date('03-01-2023', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62269, to_date('15-04-2024', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62270, to_date('15-12-2022', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62271, to_date('05-08-2021', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62272, to_date('10-09-2023', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62273, to_date('05-03-2022', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62274, to_date('19-06-2023', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62275, to_date('06-10-2023', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62276, to_date('29-05-2023', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62277, to_date('19-09-2021', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62278, to_date('09-12-2022', 'dd-mm-yyyy'), 'faulty components');
insert into REPAIRS (rid, repairdate, description)
values (62279, to_date('08-04-2024', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62280, to_date('25-08-2022', 'dd-mm-yyyy'), 'dead batteries');
insert into REPAIRS (rid, repairdate, description)
values (62281, to_date('28-01-2024', 'dd-mm-yyyy'), 'misfires');
insert into REPAIRS (rid, repairdate, description)
values (62282, to_date('21-04-2022', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62283, to_date('02-04-2024', 'dd-mm-yyyy'), 'malfunctioning alternators');
insert into REPAIRS (rid, repairdate, description)
values (62284, to_date('30-10-2022', 'dd-mm-yyyy'), 'shifting gears');
insert into REPAIRS (rid, repairdate, description)
values (62285, to_date('26-06-2021', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62286, to_date('17-08-2021', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62287, to_date('30-04-2022', 'dd-mm-yyyy'), 'ABS malfunctions');
insert into REPAIRS (rid, repairdate, description)
values (62288, to_date('05-12-2021', 'dd-mm-yyyy'), 'slipping transmission');
insert into REPAIRS (rid, repairdate, description)
values (62289, to_date('01-02-2024', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62290, to_date('19-08-2021', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62291, to_date('16-02-2021', 'dd-mm-yyyy'), 'malfunctioning brake lines');
insert into REPAIRS (rid, repairdate, description)
values (62292, to_date('02-12-2022', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62293, to_date('19-06-2023', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62294, to_date('27-10-2022', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62295, to_date('08-03-2022', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62296, to_date('06-03-2022', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62297, to_date('13-07-2021', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62298, to_date('06-02-2024', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62299, to_date('01-01-2021', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62300, to_date('02-05-2021', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62301, to_date('13-10-2021', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62302, to_date('05-03-2023', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62303, to_date('19-04-2023', 'dd-mm-yyyy'), 'lack of maintenance');
insert into REPAIRS (rid, repairdate, description)
values (62304, to_date('29-04-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62305, to_date('30-03-2021', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62306, to_date('20-05-2023', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62307, to_date('28-09-2022', 'dd-mm-yyyy'), 'malfunctioning brake lines');
insert into REPAIRS (rid, repairdate, description)
values (62308, to_date('10-08-2022', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62309, to_date('16-11-2023', 'dd-mm-yyyy'), 'malfunctioning brake lines');
commit;
prompt 300 records committed...
insert into REPAIRS (rid, repairdate, description)
values (62310, to_date('26-03-2024', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62311, to_date('14-03-2021', 'dd-mm-yyyy'), 'lack of maintenance');
insert into REPAIRS (rid, repairdate, description)
values (62312, to_date('02-05-2022', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62313, to_date('06-02-2021', 'dd-mm-yyyy'), 'lack of maintenance');
insert into REPAIRS (rid, repairdate, description)
values (62314, to_date('07-02-2022', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62315, to_date('15-01-2022', 'dd-mm-yyyy'), 'malfunctioning brake lines');
insert into REPAIRS (rid, repairdate, description)
values (62316, to_date('16-08-2023', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62317, to_date('06-05-2023', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62318, to_date('22-12-2022', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62319, to_date('07-09-2023', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62320, to_date('02-01-2023', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62321, to_date('08-01-2024', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62322, to_date('21-03-2023', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62323, to_date('30-06-2023', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62324, to_date('22-06-2023', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62325, to_date('10-05-2021', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62326, to_date('06-10-2022', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62327, to_date('03-12-2021', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62328, to_date('19-05-2022', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62329, to_date('12-06-2023', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62330, to_date('30-03-2023', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62331, to_date('09-06-2023', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62332, to_date('13-07-2021', 'dd-mm-yyyy'), 'poor fuel mixture');
insert into REPAIRS (rid, repairdate, description)
values (62333, to_date('21-01-2023', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62334, to_date('08-04-2021', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62335, to_date('20-02-2024', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62336, to_date('31-03-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62337, to_date('18-06-2023', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62338, to_date('02-12-2023', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62339, to_date('17-04-2023', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62340, to_date('06-05-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62341, to_date('22-10-2023', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62342, to_date('14-02-2022', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62343, to_date('08-07-2021', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62344, to_date('22-10-2021', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62345, to_date('27-08-2021', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62346, to_date('09-07-2023', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62347, to_date('31-07-2022', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62348, to_date('21-07-2023', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62349, to_date('05-07-2022', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62350, to_date('07-11-2022', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62351, to_date('10-11-2021', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62352, to_date('02-08-2022', 'dd-mm-yyyy'), 'poor fuel mixture');
insert into REPAIRS (rid, repairdate, description)
values (62353, to_date('08-06-2022', 'dd-mm-yyyy'), 'poor fuel mixture');
insert into REPAIRS (rid, repairdate, description)
values (62354, to_date('21-09-2021', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62355, to_date('05-02-2022', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62356, to_date('24-02-2024', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62357, to_date('29-05-2021', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62358, to_date('13-02-2023', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62359, to_date('15-04-2022', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62360, to_date('11-02-2023', 'dd-mm-yyyy'), 'malfunctioning brake lines');
insert into REPAIRS (rid, repairdate, description)
values (62361, to_date('15-04-2023', 'dd-mm-yyyy'), 'poor fuel mixture');
insert into REPAIRS (rid, repairdate, description)
values (62362, to_date('05-02-2021', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62363, to_date('12-09-2023', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62364, to_date('28-07-2022', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62365, to_date('26-06-2022', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62366, to_date('03-11-2022', 'dd-mm-yyyy'), 'lack of maintenance');
insert into REPAIRS (rid, repairdate, description)
values (62367, to_date('25-07-2022', 'dd-mm-yyyy'), 'lack of maintenance');
insert into REPAIRS (rid, repairdate, description)
values (62368, to_date('21-10-2023', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62369, to_date('26-04-2021', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62370, to_date('24-10-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62371, to_date('23-04-2023', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62372, to_date('31-07-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62373, to_date('11-11-2023', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62374, to_date('24-08-2023', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62375, to_date('03-07-2021', 'dd-mm-yyyy'), 'poor fuel mixture');
insert into REPAIRS (rid, repairdate, description)
values (62376, to_date('30-08-2021', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62377, to_date('26-03-2023', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62378, to_date('07-02-2023', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62379, to_date('12-04-2024', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62380, to_date('16-12-2022', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62381, to_date('22-12-2022', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62382, to_date('07-08-2023', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62383, to_date('19-07-2023', 'dd-mm-yyyy'), 'malfunctioning brake lines');
insert into REPAIRS (rid, repairdate, description)
values (62384, to_date('03-12-2021', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62385, to_date('20-05-2021', 'dd-mm-yyyy'), 'poor fuel mixture');
insert into REPAIRS (rid, repairdate, description)
values (62386, to_date('19-05-2021', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62387, to_date('10-08-2023', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62388, to_date('21-03-2022', 'dd-mm-yyyy'), 'lack of maintenance');
insert into REPAIRS (rid, repairdate, description)
values (62389, to_date('21-02-2023', 'dd-mm-yyyy'), 'poor fuel mixture');
insert into REPAIRS (rid, repairdate, description)
values (62390, to_date('25-01-2022', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62391, to_date('31-07-2021', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62392, to_date('08-08-2022', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62393, to_date('25-01-2024', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62394, to_date('15-11-2021', 'dd-mm-yyyy'), 'poor fuel mixture');
insert into REPAIRS (rid, repairdate, description)
values (62395, to_date('19-11-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62396, to_date('19-08-2023', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62397, to_date('08-03-2023', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62398, to_date('12-03-2021', 'dd-mm-yyyy'), 'lack of maintenance');
insert into REPAIRS (rid, repairdate, description)
values (62399, to_date('09-11-2023', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62400, to_date('01-10-2022', 'dd-mm-yyyy'), 'malfunctioning brake lines');
insert into REPAIRS (rid, repairdate, description)
values (62401, to_date('04-06-2021', 'dd-mm-yyyy'), 'malfunctioning brake lines');
insert into REPAIRS (rid, repairdate, description)
values (62402, to_date('04-03-2023', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62403, to_date('09-02-2023', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62404, to_date('26-05-2021', 'dd-mm-yyyy'), 'malfunctioning brake lines');
insert into REPAIRS (rid, repairdate, description)
values (62405, to_date('25-12-2023', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62406, to_date('03-01-2024', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62407, to_date('12-04-2023', 'dd-mm-yyyy'), 'poor fuel mixture');
insert into REPAIRS (rid, repairdate, description)
values (62408, to_date('08-12-2023', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62409, to_date('29-06-2022', 'dd-mm-yyyy'), ' overheating');
commit;
prompt 400 records committed...
insert into REPAIRS (rid, repairdate, description)
values (62410, to_date('26-08-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62411, to_date('31-03-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62412, to_date('10-03-2024', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62413, to_date('04-03-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62414, to_date('14-01-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62415, to_date('12-06-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62416, to_date('03-02-2024', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62417, to_date('06-05-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62418, to_date('28-08-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62419, to_date('28-04-2024', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62420, to_date('16-11-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62421, to_date('16-07-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62422, to_date('29-12-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62423, to_date('06-05-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62424, to_date('09-02-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62425, to_date('11-02-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62426, to_date('04-02-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62427, to_date('03-12-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62428, to_date('20-05-2024', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62429, to_date('18-09-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62430, to_date('28-03-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62431, to_date('24-06-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62432, to_date('29-11-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62433, to_date('25-04-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62434, to_date('27-06-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62435, to_date('25-02-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62436, to_date('05-07-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62437, to_date('17-06-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62438, to_date('18-04-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62439, to_date('02-09-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62441, to_date('26-10-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62442, to_date('20-03-2024', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62443, to_date('21-04-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62444, to_date('17-01-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62445, to_date('14-05-2024', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62446, to_date('12-02-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62447, to_date('09-03-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62448, to_date('22-05-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62449, to_date('26-06-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62450, to_date('22-05-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62451, to_date('27-05-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62452, to_date('27-05-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62453, to_date('16-02-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62454, to_date('11-07-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62455, to_date('15-07-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62456, to_date('27-05-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62457, to_date('12-10-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62458, to_date('06-11-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62459, to_date('05-09-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62460, to_date('19-03-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62461, to_date('06-05-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62462, to_date('07-08-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62463, to_date('27-11-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62464, to_date('10-12-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62465, to_date('23-07-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62466, to_date('26-03-2024', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62467, to_date('07-02-2024', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62468, to_date('03-08-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62469, to_date('15-06-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62470, to_date('28-12-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62471, to_date('22-04-2024', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62472, to_date('05-09-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62473, to_date('05-08-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62474, to_date('14-12-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62475, to_date('22-12-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62476, to_date('20-02-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62477, to_date('11-02-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62478, to_date('10-11-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62479, to_date('22-11-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62480, to_date('02-09-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62481, to_date('24-05-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62482, to_date('09-06-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62483, to_date('29-04-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62484, to_date('23-11-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62485, to_date('26-07-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62486, to_date('21-12-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62487, to_date('09-07-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62488, to_date('28-12-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62489, to_date('21-07-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62490, to_date('15-09-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62491, to_date('28-06-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62492, to_date('09-03-2024', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62493, to_date('29-03-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62494, to_date('29-05-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62495, to_date('02-03-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62496, to_date('14-04-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62497, to_date('21-02-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62498, to_date('03-08-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62499, to_date('01-05-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62500, to_date('24-09-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62501, to_date('23-07-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62502, to_date('24-12-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62503, to_date('31-01-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62504, to_date('16-10-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62505, to_date('02-07-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62506, to_date('27-01-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62507, to_date('01-08-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62508, to_date('10-04-2024', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62509, to_date('17-11-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62510, to_date('15-08-2023', 'dd-mm-yyyy'), 'product lubrication');
commit;
prompt 500 records committed...
insert into REPAIRS (rid, repairdate, description)
values (62511, to_date('30-08-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62512, to_date('13-04-2024', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62513, to_date('31-03-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62514, to_date('09-02-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62515, to_date('07-04-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62516, to_date('25-12-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62517, to_date('06-05-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62518, to_date('15-10-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62519, to_date('05-02-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62520, to_date('27-02-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62521, to_date('25-05-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62522, to_date('12-03-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62523, to_date('01-09-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62524, to_date('19-08-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62525, to_date('03-01-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62526, to_date('10-03-2024', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62527, to_date('25-11-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62528, to_date('31-03-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62529, to_date('17-01-2024', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62530, to_date('15-05-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62531, to_date('19-09-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62532, to_date('05-12-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62533, to_date('28-08-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62534, to_date('12-11-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62535, to_date('20-10-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62536, to_date('02-06-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62537, to_date('28-06-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62538, to_date('23-12-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62539, to_date('15-03-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62540, to_date('18-03-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62541, to_date('11-03-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62542, to_date('01-09-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62543, to_date('14-05-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62544, to_date('19-07-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62545, to_date('25-03-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62546, to_date('01-12-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62547, to_date('21-09-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62548, to_date('29-04-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62549, to_date('18-03-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62550, to_date('24-02-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62551, to_date('07-03-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62552, to_date('27-11-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62553, to_date('18-07-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62554, to_date('17-02-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62555, to_date('15-09-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62556, to_date('10-02-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62557, to_date('26-12-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62558, to_date('11-11-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62559, to_date('07-11-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62560, to_date('08-03-2024', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62561, to_date('01-05-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62562, to_date('10-09-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62563, to_date('21-12-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62564, to_date('15-11-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62565, to_date('23-04-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62566, to_date('25-03-2024', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62567, to_date('30-07-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62568, to_date('15-03-2024', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62569, to_date('12-08-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62570, to_date('08-07-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62571, to_date('29-09-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62572, to_date('06-12-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62573, to_date('26-12-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62574, to_date('10-04-2024', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62575, to_date('11-12-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62576, to_date('05-01-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62577, to_date('12-08-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62578, to_date('07-01-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62579, to_date('29-10-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62580, to_date('25-10-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62581, to_date('21-04-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62582, to_date('05-11-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62583, to_date('12-09-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62584, to_date('29-11-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62585, to_date('12-11-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62586, to_date('17-10-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62587, to_date('01-03-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62588, to_date('13-01-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62589, to_date('05-10-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62590, to_date('13-02-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62591, to_date('25-02-2024', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62592, to_date('25-01-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62593, to_date('17-06-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62594, to_date('16-12-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62595, to_date('22-06-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62596, to_date('09-02-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62597, to_date('19-04-2024', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62598, to_date('13-07-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62599, to_date('26-12-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62600, to_date('04-04-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62601, to_date('18-05-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62602, to_date('23-05-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62603, to_date('01-06-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62604, to_date('20-11-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62605, to_date('26-06-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62606, to_date('18-08-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62607, to_date('06-03-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62608, to_date('19-06-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62609, to_date('20-09-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62610, to_date('05-01-2021', 'dd-mm-yyyy'), 'health check');
commit;
prompt 600 records committed...
insert into REPAIRS (rid, repairdate, description)
values (62611, to_date('09-10-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62612, to_date('11-01-2024', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62613, to_date('23-01-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62614, to_date('10-05-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62615, to_date('03-04-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62616, to_date('04-02-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62617, to_date('24-11-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62618, to_date('22-04-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62619, to_date('03-11-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62620, to_date('01-07-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62621, to_date('03-10-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62622, to_date('08-05-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62623, to_date('29-03-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62624, to_date('11-02-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62625, to_date('30-07-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62626, to_date('13-03-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62627, to_date('16-08-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62628, to_date('29-05-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62629, to_date('19-11-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62630, to_date('15-01-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62631, to_date('21-01-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62632, to_date('22-04-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62633, to_date('30-11-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62634, to_date('15-07-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62635, to_date('21-03-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62636, to_date('24-12-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62637, to_date('17-07-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62638, to_date('22-04-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62639, to_date('23-04-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62640, to_date('08-10-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62641, to_date('24-11-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62642, to_date('10-05-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62643, to_date('28-12-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62644, to_date('12-10-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62645, to_date('08-12-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62646, to_date('22-05-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62647, to_date('11-09-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62648, to_date('11-08-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62649, to_date('14-03-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62650, to_date('10-01-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62651, to_date('28-12-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62652, to_date('19-03-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62653, to_date('29-03-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62654, to_date('22-05-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62655, to_date('10-12-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62656, to_date('18-03-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62657, to_date('02-09-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62658, to_date('15-04-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62659, to_date('01-07-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62660, to_date('14-08-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62661, to_date('25-02-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62662, to_date('16-04-2024', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62663, to_date('11-06-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62664, to_date('23-02-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62665, to_date('14-01-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62666, to_date('05-05-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62667, to_date('18-01-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62668, to_date('18-12-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62669, to_date('07-11-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62670, to_date('17-12-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62671, to_date('17-03-2024', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62672, to_date('26-03-2024', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62673, to_date('04-03-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62674, to_date('27-07-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62675, to_date('07-08-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62676, to_date('10-02-2024', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62677, to_date('22-01-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62678, to_date('11-02-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62679, to_date('17-09-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62680, to_date('05-09-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62681, to_date('02-01-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62682, to_date('29-12-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62683, to_date('30-04-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62684, to_date('02-10-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62685, to_date('26-07-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62686, to_date('02-02-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62687, to_date('21-05-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62688, to_date('29-06-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62689, to_date('11-03-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62690, to_date('24-07-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62691, to_date('31-05-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62692, to_date('18-03-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62693, to_date('31-10-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62694, to_date('04-02-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62695, to_date('16-11-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62696, to_date('26-10-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62697, to_date('09-03-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62698, to_date('11-04-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62699, to_date('28-10-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62700, to_date('18-03-2024', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62701, to_date('06-03-2024', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62702, to_date('15-09-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62703, to_date('15-01-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62704, to_date('03-06-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62705, to_date('11-03-2024', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62706, to_date('30-05-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62707, to_date('09-02-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62708, to_date('02-10-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62709, to_date('29-05-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62710, to_date('10-12-2023', 'dd-mm-yyyy'), 'health check');
commit;
prompt 700 records committed...
insert into REPAIRS (rid, repairdate, description)
values (62711, to_date('24-01-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62712, to_date('14-05-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62713, to_date('07-03-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62714, to_date('07-04-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62715, to_date('11-03-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62716, to_date('18-02-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62717, to_date('22-04-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62718, to_date('08-08-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62719, to_date('28-04-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62720, to_date('06-12-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62721, to_date('08-08-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62722, to_date('15-03-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62723, to_date('01-12-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62724, to_date('23-09-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62725, to_date('07-12-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62726, to_date('03-09-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62727, to_date('16-07-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62728, to_date('25-10-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62729, to_date('14-11-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62730, to_date('14-03-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62731, to_date('01-12-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62732, to_date('05-01-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62733, to_date('22-02-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62734, to_date('10-04-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62735, to_date('30-09-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62736, to_date('21-09-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62737, to_date('18-04-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62738, to_date('05-04-2024', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62739, to_date('20-09-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62740, to_date('22-01-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62741, to_date('23-12-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62742, to_date('06-05-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62743, to_date('12-07-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62744, to_date('19-03-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62745, to_date('27-08-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62746, to_date('06-05-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62747, to_date('16-05-2024', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62748, to_date('14-06-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62749, to_date('20-11-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62750, to_date('10-09-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62751, to_date('28-07-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62752, to_date('09-05-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62753, to_date('28-08-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62754, to_date('08-11-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62755, to_date('07-11-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62756, to_date('01-03-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62757, to_date('04-02-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62758, to_date('25-04-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62759, to_date('28-03-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62760, to_date('22-06-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62761, to_date('11-06-2021', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62762, to_date('03-07-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62763, to_date('09-10-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62764, to_date('27-10-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62765, to_date('15-05-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62766, to_date('31-01-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62767, to_date('10-03-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62768, to_date('21-05-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62769, to_date('16-03-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62770, to_date('01-06-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62771, to_date('31-01-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62772, to_date('25-03-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62773, to_date('17-01-2024', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62774, to_date('03-06-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62775, to_date('02-03-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62776, to_date('01-10-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62777, to_date('16-03-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62778, to_date('17-01-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62779, to_date('12-05-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62780, to_date('24-10-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62781, to_date('11-03-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62782, to_date('25-12-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62783, to_date('30-07-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62784, to_date('25-08-2022', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62785, to_date('26-09-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62786, to_date('22-05-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62787, to_date('19-06-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62788, to_date('23-02-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62789, to_date('31-05-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62790, to_date('16-05-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62791, to_date('30-03-2023', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62792, to_date('06-08-2021', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62793, to_date('19-11-2023', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62794, to_date('26-09-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62795, to_date('24-01-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62796, to_date('23-03-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62797, to_date('22-05-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62798, to_date('05-03-2024', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62799, to_date('04-11-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62800, to_date('07-05-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62801, to_date('25-07-2022', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62802, to_date('01-03-2021', 'dd-mm-yyyy'), 'product lubrication');
insert into REPAIRS (rid, repairdate, description)
values (62803, to_date('15-11-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62804, to_date('13-07-2023', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62805, to_date('20-02-2024', 'dd-mm-yyyy'), 'Replacing a broken component');
insert into REPAIRS (rid, repairdate, description)
values (62806, to_date('06-05-2022', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62807, to_date('16-04-2021', 'dd-mm-yyyy'), 'health check');
insert into REPAIRS (rid, repairdate, description)
values (62808, to_date('15-03-2024', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62809, to_date('19-06-2023', 'dd-mm-yyyy'), 'Replacing electrical wires');
insert into REPAIRS (rid, repairdate, description)
values (62440, to_date('06-05-2022', 'dd-mm-yyyy'), 'Replacing a broken component');
commit;
prompt 800 records committed...
insert into REPAIRS (rid, repairdate, description)
values (62810, to_date('17-04-2022', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62811, to_date('07-04-2021', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62812, to_date('03-01-2023', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62813, to_date('15-02-2021', 'dd-mm-yyyy'), 'lack of maintenance');
insert into REPAIRS (rid, repairdate, description)
values (62814, to_date('09-10-2021', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62815, to_date('13-04-2023', 'dd-mm-yyyy'), 'poor fuel mixture');
insert into REPAIRS (rid, repairdate, description)
values (62816, to_date('23-12-2022', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62817, to_date('04-03-2023', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62818, to_date('12-11-2023', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62819, to_date('14-09-2021', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62820, to_date('14-09-2021', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62821, to_date('19-12-2023', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62822, to_date('12-02-2023', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62823, to_date('23-01-2023', 'dd-mm-yyyy'), 'lack of maintenance');
insert into REPAIRS (rid, repairdate, description)
values (62824, to_date('31-01-2021', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62825, to_date('09-06-2022', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62826, to_date('06-02-2022', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62827, to_date('19-01-2022', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62828, to_date('27-12-2023', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62829, to_date('14-06-2023', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62830, to_date('22-09-2021', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62831, to_date('22-06-2021', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62832, to_date('05-06-2021', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62833, to_date('25-04-2022', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62834, to_date('07-12-2022', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62835, to_date('13-08-2023', 'dd-mm-yyyy'), 'poor fuel mixture');
insert into REPAIRS (rid, repairdate, description)
values (62836, to_date('01-01-2024', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62837, to_date('20-08-2021', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62838, to_date('25-10-2021', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62839, to_date('07-07-2023', 'dd-mm-yyyy'), 'lack of maintenance');
insert into REPAIRS (rid, repairdate, description)
values (62840, to_date('28-05-2022', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62841, to_date('08-01-2023', 'dd-mm-yyyy'), 'malfunctioning brake lines');
insert into REPAIRS (rid, repairdate, description)
values (62842, to_date('24-11-2021', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62843, to_date('26-01-2021', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62844, to_date('01-09-2022', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62845, to_date('16-01-2024', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62846, to_date('25-11-2022', 'dd-mm-yyyy'), 'malfunctioning brake lines');
insert into REPAIRS (rid, repairdate, description)
values (62847, to_date('09-07-2021', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62848, to_date('08-01-2024', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62849, to_date('25-11-2023', 'dd-mm-yyyy'), 'electronic systems');
insert into REPAIRS (rid, repairdate, description)
values (62850, to_date('11-04-2023', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62851, to_date('03-04-2024', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62852, to_date('31-01-2024', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62853, to_date('16-03-2024', 'dd-mm-yyyy'), 'poor fuel mixture');
insert into REPAIRS (rid, repairdate, description)
values (62854, to_date('16-12-2022', 'dd-mm-yyyy'), 'leaking brake fluid');
insert into REPAIRS (rid, repairdate, description)
values (62855, to_date('24-09-2023', 'dd-mm-yyyy'), 'oil leaks');
insert into REPAIRS (rid, repairdate, description)
values (62856, to_date('02-04-2024', 'dd-mm-yyyy'), ' overheating');
insert into REPAIRS (rid, repairdate, description)
values (62857, to_date('09-07-2021', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62858, to_date('05-12-2022', 'dd-mm-yyyy'), 'brake issues');
insert into REPAIRS (rid, repairdate, description)
values (62859, to_date('26-05-2022', 'dd-mm-yyyy'), 'malfunctioning brake lines');
insert into REPAIRS (rid, repairdate, description)
values (62860, to_date('05-10-2021', 'dd-mm-yyyy'), 'Worn brake pads');
insert into REPAIRS (rid, repairdate, description)
values (62861, to_date('07-02-2022', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62862, to_date('11-08-2021', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62863, to_date('24-11-2021', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62864, to_date('06-04-2022', 'dd-mm-yyyy'), 'Tire Problems');
insert into REPAIRS (rid, repairdate, description)
values (62865, to_date('28-04-2021', 'dd-mm-yyyy'), 'Battery problems');
insert into REPAIRS (rid, repairdate, description)
values (62866, to_date('22-08-2021', 'dd-mm-yyyy'), 'engine failure');
insert into REPAIRS (rid, repairdate, description)
values (62867, to_date('10-11-2022', 'dd-mm-yyyy'), 'malfunctioning brake lines');
insert into REPAIRS (rid, repairdate, description)
values (62868, to_date('21-02-2022', 'dd-mm-yyyy'), 'fluid leaks');
insert into REPAIRS (rid, repairdate, description)
values (62869, to_date('26-03-2022', 'dd-mm-yyyy'), 'fluid leaks');
commit;
prompt 860 records loaded
prompt Loading EQUIPREPAIRS...
insert into EQUIPREPAIRS (rid, eid)
values (62410, 10139);
insert into EQUIPREPAIRS (rid, eid)
values (62411, 10350);
insert into EQUIPREPAIRS (rid, eid)
values (62412, 10063);
insert into EQUIPREPAIRS (rid, eid)
values (62413, 10361);
insert into EQUIPREPAIRS (rid, eid)
values (62414, 10375);
insert into EQUIPREPAIRS (rid, eid)
values (62415, 10109);
insert into EQUIPREPAIRS (rid, eid)
values (62416, 10140);
insert into EQUIPREPAIRS (rid, eid)
values (62417, 10195);
insert into EQUIPREPAIRS (rid, eid)
values (62418, 10230);
insert into EQUIPREPAIRS (rid, eid)
values (62419, 10234);
insert into EQUIPREPAIRS (rid, eid)
values (62420, 10266);
insert into EQUIPREPAIRS (rid, eid)
values (62421, 10046);
insert into EQUIPREPAIRS (rid, eid)
values (62422, 10199);
insert into EQUIPREPAIRS (rid, eid)
values (62423, 10080);
insert into EQUIPREPAIRS (rid, eid)
values (62424, 10115);
insert into EQUIPREPAIRS (rid, eid)
values (62425, 10214);
insert into EQUIPREPAIRS (rid, eid)
values (62426, 10020);
insert into EQUIPREPAIRS (rid, eid)
values (62427, 10247);
insert into EQUIPREPAIRS (rid, eid)
values (62428, 10028);
insert into EQUIPREPAIRS (rid, eid)
values (62429, 10301);
insert into EQUIPREPAIRS (rid, eid)
values (62430, 10020);
insert into EQUIPREPAIRS (rid, eid)
values (62431, 10200);
insert into EQUIPREPAIRS (rid, eid)
values (62432, 10084);
insert into EQUIPREPAIRS (rid, eid)
values (62433, 10208);
insert into EQUIPREPAIRS (rid, eid)
values (62434, 10371);
insert into EQUIPREPAIRS (rid, eid)
values (62435, 10362);
insert into EQUIPREPAIRS (rid, eid)
values (62436, 10120);
insert into EQUIPREPAIRS (rid, eid)
values (62437, 10212);
insert into EQUIPREPAIRS (rid, eid)
values (62438, 10104);
insert into EQUIPREPAIRS (rid, eid)
values (62439, 10203);
insert into EQUIPREPAIRS (rid, eid)
values (62441, 10167);
insert into EQUIPREPAIRS (rid, eid)
values (62442, 10283);
insert into EQUIPREPAIRS (rid, eid)
values (62443, 10144);
insert into EQUIPREPAIRS (rid, eid)
values (62444, 10207);
insert into EQUIPREPAIRS (rid, eid)
values (62445, 10037);
insert into EQUIPREPAIRS (rid, eid)
values (62446, 10064);
insert into EQUIPREPAIRS (rid, eid)
values (62447, 10203);
insert into EQUIPREPAIRS (rid, eid)
values (62448, 10177);
insert into EQUIPREPAIRS (rid, eid)
values (62449, 10002);
insert into EQUIPREPAIRS (rid, eid)
values (62450, 10325);
insert into EQUIPREPAIRS (rid, eid)
values (62451, 10162);
insert into EQUIPREPAIRS (rid, eid)
values (62452, 10249);
insert into EQUIPREPAIRS (rid, eid)
values (62453, 10106);
insert into EQUIPREPAIRS (rid, eid)
values (62454, 10180);
insert into EQUIPREPAIRS (rid, eid)
values (62455, 10054);
insert into EQUIPREPAIRS (rid, eid)
values (62456, 10234);
insert into EQUIPREPAIRS (rid, eid)
values (62457, 10327);
insert into EQUIPREPAIRS (rid, eid)
values (62458, 10032);
insert into EQUIPREPAIRS (rid, eid)
values (62459, 10291);
insert into EQUIPREPAIRS (rid, eid)
values (62460, 10098);
insert into EQUIPREPAIRS (rid, eid)
values (62461, 10034);
insert into EQUIPREPAIRS (rid, eid)
values (62462, 10329);
insert into EQUIPREPAIRS (rid, eid)
values (62463, 10030);
insert into EQUIPREPAIRS (rid, eid)
values (62464, 10358);
insert into EQUIPREPAIRS (rid, eid)
values (62465, 10318);
insert into EQUIPREPAIRS (rid, eid)
values (62466, 10180);
insert into EQUIPREPAIRS (rid, eid)
values (62467, 10163);
insert into EQUIPREPAIRS (rid, eid)
values (62468, 10133);
insert into EQUIPREPAIRS (rid, eid)
values (62469, 10294);
insert into EQUIPREPAIRS (rid, eid)
values (62470, 10145);
insert into EQUIPREPAIRS (rid, eid)
values (62471, 10036);
insert into EQUIPREPAIRS (rid, eid)
values (62472, 10225);
insert into EQUIPREPAIRS (rid, eid)
values (62473, 10360);
insert into EQUIPREPAIRS (rid, eid)
values (62474, 10231);
insert into EQUIPREPAIRS (rid, eid)
values (62475, 10150);
insert into EQUIPREPAIRS (rid, eid)
values (62476, 10111);
insert into EQUIPREPAIRS (rid, eid)
values (62477, 10069);
insert into EQUIPREPAIRS (rid, eid)
values (62478, 10019);
insert into EQUIPREPAIRS (rid, eid)
values (62479, 10140);
insert into EQUIPREPAIRS (rid, eid)
values (62480, 10056);
insert into EQUIPREPAIRS (rid, eid)
values (62481, 10165);
insert into EQUIPREPAIRS (rid, eid)
values (62482, 10255);
insert into EQUIPREPAIRS (rid, eid)
values (62483, 10044);
insert into EQUIPREPAIRS (rid, eid)
values (62484, 10251);
insert into EQUIPREPAIRS (rid, eid)
values (62485, 10286);
insert into EQUIPREPAIRS (rid, eid)
values (62486, 10097);
insert into EQUIPREPAIRS (rid, eid)
values (62487, 10026);
insert into EQUIPREPAIRS (rid, eid)
values (62488, 10310);
insert into EQUIPREPAIRS (rid, eid)
values (62489, 10054);
insert into EQUIPREPAIRS (rid, eid)
values (62490, 10045);
insert into EQUIPREPAIRS (rid, eid)
values (62491, 10291);
insert into EQUIPREPAIRS (rid, eid)
values (62492, 10132);
insert into EQUIPREPAIRS (rid, eid)
values (62493, 10111);
insert into EQUIPREPAIRS (rid, eid)
values (62494, 10118);
insert into EQUIPREPAIRS (rid, eid)
values (62495, 10195);
insert into EQUIPREPAIRS (rid, eid)
values (62496, 10390);
insert into EQUIPREPAIRS (rid, eid)
values (62497, 10131);
insert into EQUIPREPAIRS (rid, eid)
values (62498, 10273);
insert into EQUIPREPAIRS (rid, eid)
values (62499, 10120);
insert into EQUIPREPAIRS (rid, eid)
values (62500, 10239);
insert into EQUIPREPAIRS (rid, eid)
values (62501, 10230);
insert into EQUIPREPAIRS (rid, eid)
values (62502, 10083);
insert into EQUIPREPAIRS (rid, eid)
values (62503, 10051);
insert into EQUIPREPAIRS (rid, eid)
values (62504, 10398);
insert into EQUIPREPAIRS (rid, eid)
values (62505, 10207);
insert into EQUIPREPAIRS (rid, eid)
values (62506, 10048);
insert into EQUIPREPAIRS (rid, eid)
values (62507, 10242);
insert into EQUIPREPAIRS (rid, eid)
values (62508, 10098);
insert into EQUIPREPAIRS (rid, eid)
values (62509, 10000);
insert into EQUIPREPAIRS (rid, eid)
values (62510, 10136);
commit;
prompt 100 records committed...
insert into EQUIPREPAIRS (rid, eid)
values (62511, 10154);
insert into EQUIPREPAIRS (rid, eid)
values (62512, 10303);
insert into EQUIPREPAIRS (rid, eid)
values (62513, 10031);
insert into EQUIPREPAIRS (rid, eid)
values (62514, 10139);
insert into EQUIPREPAIRS (rid, eid)
values (62515, 10012);
insert into EQUIPREPAIRS (rid, eid)
values (62516, 10280);
insert into EQUIPREPAIRS (rid, eid)
values (62517, 10177);
insert into EQUIPREPAIRS (rid, eid)
values (62518, 10075);
insert into EQUIPREPAIRS (rid, eid)
values (62519, 10166);
insert into EQUIPREPAIRS (rid, eid)
values (62520, 10129);
insert into EQUIPREPAIRS (rid, eid)
values (62521, 10277);
insert into EQUIPREPAIRS (rid, eid)
values (62522, 10176);
insert into EQUIPREPAIRS (rid, eid)
values (62523, 10387);
insert into EQUIPREPAIRS (rid, eid)
values (62524, 10179);
insert into EQUIPREPAIRS (rid, eid)
values (62525, 10321);
insert into EQUIPREPAIRS (rid, eid)
values (62526, 10096);
insert into EQUIPREPAIRS (rid, eid)
values (62527, 10139);
insert into EQUIPREPAIRS (rid, eid)
values (62528, 10379);
insert into EQUIPREPAIRS (rid, eid)
values (62529, 10198);
insert into EQUIPREPAIRS (rid, eid)
values (62530, 10318);
insert into EQUIPREPAIRS (rid, eid)
values (62531, 10129);
insert into EQUIPREPAIRS (rid, eid)
values (62532, 10069);
insert into EQUIPREPAIRS (rid, eid)
values (62533, 10158);
insert into EQUIPREPAIRS (rid, eid)
values (62534, 10349);
insert into EQUIPREPAIRS (rid, eid)
values (62535, 10328);
insert into EQUIPREPAIRS (rid, eid)
values (62536, 10263);
insert into EQUIPREPAIRS (rid, eid)
values (62537, 10075);
insert into EQUIPREPAIRS (rid, eid)
values (62538, 10109);
insert into EQUIPREPAIRS (rid, eid)
values (62539, 10223);
insert into EQUIPREPAIRS (rid, eid)
values (62540, 10144);
insert into EQUIPREPAIRS (rid, eid)
values (62541, 10064);
insert into EQUIPREPAIRS (rid, eid)
values (62542, 10115);
insert into EQUIPREPAIRS (rid, eid)
values (62543, 10313);
insert into EQUIPREPAIRS (rid, eid)
values (62544, 10187);
insert into EQUIPREPAIRS (rid, eid)
values (62545, 10342);
insert into EQUIPREPAIRS (rid, eid)
values (62546, 10200);
insert into EQUIPREPAIRS (rid, eid)
values (62547, 10334);
insert into EQUIPREPAIRS (rid, eid)
values (62548, 10200);
insert into EQUIPREPAIRS (rid, eid)
values (62549, 10260);
insert into EQUIPREPAIRS (rid, eid)
values (62550, 10245);
insert into EQUIPREPAIRS (rid, eid)
values (62551, 10269);
insert into EQUIPREPAIRS (rid, eid)
values (62552, 10032);
insert into EQUIPREPAIRS (rid, eid)
values (62553, 10243);
insert into EQUIPREPAIRS (rid, eid)
values (62554, 10048);
insert into EQUIPREPAIRS (rid, eid)
values (62555, 10249);
insert into EQUIPREPAIRS (rid, eid)
values (62556, 10345);
insert into EQUIPREPAIRS (rid, eid)
values (62557, 10332);
insert into EQUIPREPAIRS (rid, eid)
values (62558, 10369);
insert into EQUIPREPAIRS (rid, eid)
values (62559, 10348);
insert into EQUIPREPAIRS (rid, eid)
values (62560, 10079);
insert into EQUIPREPAIRS (rid, eid)
values (62561, 10038);
insert into EQUIPREPAIRS (rid, eid)
values (62562, 10087);
insert into EQUIPREPAIRS (rid, eid)
values (62563, 10219);
insert into EQUIPREPAIRS (rid, eid)
values (62564, 10324);
insert into EQUIPREPAIRS (rid, eid)
values (62565, 10296);
insert into EQUIPREPAIRS (rid, eid)
values (62566, 10168);
insert into EQUIPREPAIRS (rid, eid)
values (62567, 10177);
insert into EQUIPREPAIRS (rid, eid)
values (62568, 10142);
insert into EQUIPREPAIRS (rid, eid)
values (62569, 10313);
insert into EQUIPREPAIRS (rid, eid)
values (62570, 10290);
insert into EQUIPREPAIRS (rid, eid)
values (62571, 10230);
insert into EQUIPREPAIRS (rid, eid)
values (62572, 10281);
insert into EQUIPREPAIRS (rid, eid)
values (62573, 10375);
insert into EQUIPREPAIRS (rid, eid)
values (62574, 10269);
insert into EQUIPREPAIRS (rid, eid)
values (62575, 10108);
insert into EQUIPREPAIRS (rid, eid)
values (62576, 10147);
insert into EQUIPREPAIRS (rid, eid)
values (62577, 10003);
insert into EQUIPREPAIRS (rid, eid)
values (62578, 10367);
insert into EQUIPREPAIRS (rid, eid)
values (62579, 10195);
insert into EQUIPREPAIRS (rid, eid)
values (62580, 10134);
insert into EQUIPREPAIRS (rid, eid)
values (62581, 10289);
insert into EQUIPREPAIRS (rid, eid)
values (62582, 10341);
insert into EQUIPREPAIRS (rid, eid)
values (62583, 10165);
insert into EQUIPREPAIRS (rid, eid)
values (62584, 10120);
insert into EQUIPREPAIRS (rid, eid)
values (62585, 10394);
insert into EQUIPREPAIRS (rid, eid)
values (62586, 10396);
insert into EQUIPREPAIRS (rid, eid)
values (62587, 10281);
insert into EQUIPREPAIRS (rid, eid)
values (62588, 10387);
insert into EQUIPREPAIRS (rid, eid)
values (62589, 10095);
insert into EQUIPREPAIRS (rid, eid)
values (62590, 10042);
insert into EQUIPREPAIRS (rid, eid)
values (62591, 10329);
insert into EQUIPREPAIRS (rid, eid)
values (62592, 10005);
insert into EQUIPREPAIRS (rid, eid)
values (62593, 10162);
insert into EQUIPREPAIRS (rid, eid)
values (62594, 10269);
insert into EQUIPREPAIRS (rid, eid)
values (62595, 10148);
insert into EQUIPREPAIRS (rid, eid)
values (62596, 10347);
insert into EQUIPREPAIRS (rid, eid)
values (62597, 10137);
insert into EQUIPREPAIRS (rid, eid)
values (62598, 10387);
insert into EQUIPREPAIRS (rid, eid)
values (62599, 10146);
insert into EQUIPREPAIRS (rid, eid)
values (62600, 10111);
insert into EQUIPREPAIRS (rid, eid)
values (62601, 10039);
insert into EQUIPREPAIRS (rid, eid)
values (62602, 10373);
insert into EQUIPREPAIRS (rid, eid)
values (62603, 10333);
insert into EQUIPREPAIRS (rid, eid)
values (62604, 10195);
insert into EQUIPREPAIRS (rid, eid)
values (62605, 10116);
insert into EQUIPREPAIRS (rid, eid)
values (62606, 10310);
insert into EQUIPREPAIRS (rid, eid)
values (62607, 10072);
insert into EQUIPREPAIRS (rid, eid)
values (62608, 10171);
insert into EQUIPREPAIRS (rid, eid)
values (62609, 10121);
insert into EQUIPREPAIRS (rid, eid)
values (62610, 10271);
commit;
prompt 200 records committed...
insert into EQUIPREPAIRS (rid, eid)
values (62611, 10125);
insert into EQUIPREPAIRS (rid, eid)
values (62612, 10059);
insert into EQUIPREPAIRS (rid, eid)
values (62613, 10100);
insert into EQUIPREPAIRS (rid, eid)
values (62614, 10102);
insert into EQUIPREPAIRS (rid, eid)
values (62615, 10114);
insert into EQUIPREPAIRS (rid, eid)
values (62616, 10243);
insert into EQUIPREPAIRS (rid, eid)
values (62617, 10342);
insert into EQUIPREPAIRS (rid, eid)
values (62618, 10248);
insert into EQUIPREPAIRS (rid, eid)
values (62619, 10012);
insert into EQUIPREPAIRS (rid, eid)
values (62620, 10121);
insert into EQUIPREPAIRS (rid, eid)
values (62621, 10250);
insert into EQUIPREPAIRS (rid, eid)
values (62622, 10040);
insert into EQUIPREPAIRS (rid, eid)
values (62623, 10227);
insert into EQUIPREPAIRS (rid, eid)
values (62624, 10226);
insert into EQUIPREPAIRS (rid, eid)
values (62625, 10054);
insert into EQUIPREPAIRS (rid, eid)
values (62626, 10045);
insert into EQUIPREPAIRS (rid, eid)
values (62627, 10208);
insert into EQUIPREPAIRS (rid, eid)
values (62628, 10145);
insert into EQUIPREPAIRS (rid, eid)
values (62629, 10064);
insert into EQUIPREPAIRS (rid, eid)
values (62630, 10244);
insert into EQUIPREPAIRS (rid, eid)
values (62631, 10011);
insert into EQUIPREPAIRS (rid, eid)
values (62632, 10000);
insert into EQUIPREPAIRS (rid, eid)
values (62633, 10373);
insert into EQUIPREPAIRS (rid, eid)
values (62634, 10044);
insert into EQUIPREPAIRS (rid, eid)
values (62635, 10125);
insert into EQUIPREPAIRS (rid, eid)
values (62636, 10032);
insert into EQUIPREPAIRS (rid, eid)
values (62637, 10374);
insert into EQUIPREPAIRS (rid, eid)
values (62638, 10159);
insert into EQUIPREPAIRS (rid, eid)
values (62639, 10163);
insert into EQUIPREPAIRS (rid, eid)
values (62640, 10204);
insert into EQUIPREPAIRS (rid, eid)
values (62641, 10373);
insert into EQUIPREPAIRS (rid, eid)
values (62642, 10055);
insert into EQUIPREPAIRS (rid, eid)
values (62643, 10385);
insert into EQUIPREPAIRS (rid, eid)
values (62644, 10211);
insert into EQUIPREPAIRS (rid, eid)
values (62645, 10018);
insert into EQUIPREPAIRS (rid, eid)
values (62646, 10082);
insert into EQUIPREPAIRS (rid, eid)
values (62647, 10010);
insert into EQUIPREPAIRS (rid, eid)
values (62648, 10008);
insert into EQUIPREPAIRS (rid, eid)
values (62649, 10086);
insert into EQUIPREPAIRS (rid, eid)
values (62650, 10153);
insert into EQUIPREPAIRS (rid, eid)
values (62651, 10113);
insert into EQUIPREPAIRS (rid, eid)
values (62652, 10226);
insert into EQUIPREPAIRS (rid, eid)
values (62653, 10106);
insert into EQUIPREPAIRS (rid, eid)
values (62654, 10290);
insert into EQUIPREPAIRS (rid, eid)
values (62655, 10017);
insert into EQUIPREPAIRS (rid, eid)
values (62656, 10362);
insert into EQUIPREPAIRS (rid, eid)
values (62657, 10187);
insert into EQUIPREPAIRS (rid, eid)
values (62658, 10318);
insert into EQUIPREPAIRS (rid, eid)
values (62659, 10020);
insert into EQUIPREPAIRS (rid, eid)
values (62660, 10385);
insert into EQUIPREPAIRS (rid, eid)
values (62661, 10137);
insert into EQUIPREPAIRS (rid, eid)
values (62662, 10196);
insert into EQUIPREPAIRS (rid, eid)
values (62663, 10385);
insert into EQUIPREPAIRS (rid, eid)
values (62664, 10200);
insert into EQUIPREPAIRS (rid, eid)
values (62665, 10394);
insert into EQUIPREPAIRS (rid, eid)
values (62666, 10107);
insert into EQUIPREPAIRS (rid, eid)
values (62667, 10346);
insert into EQUIPREPAIRS (rid, eid)
values (62668, 10400);
insert into EQUIPREPAIRS (rid, eid)
values (62669, 10093);
insert into EQUIPREPAIRS (rid, eid)
values (62670, 10350);
insert into EQUIPREPAIRS (rid, eid)
values (62671, 10171);
insert into EQUIPREPAIRS (rid, eid)
values (62672, 10148);
insert into EQUIPREPAIRS (rid, eid)
values (62673, 10211);
insert into EQUIPREPAIRS (rid, eid)
values (62674, 10374);
insert into EQUIPREPAIRS (rid, eid)
values (62675, 10153);
insert into EQUIPREPAIRS (rid, eid)
values (62676, 10278);
insert into EQUIPREPAIRS (rid, eid)
values (62677, 10042);
insert into EQUIPREPAIRS (rid, eid)
values (62678, 10032);
insert into EQUIPREPAIRS (rid, eid)
values (62679, 10177);
insert into EQUIPREPAIRS (rid, eid)
values (62680, 10391);
insert into EQUIPREPAIRS (rid, eid)
values (62681, 10010);
insert into EQUIPREPAIRS (rid, eid)
values (62682, 10161);
insert into EQUIPREPAIRS (rid, eid)
values (62683, 10379);
insert into EQUIPREPAIRS (rid, eid)
values (62684, 10227);
insert into EQUIPREPAIRS (rid, eid)
values (62685, 10063);
insert into EQUIPREPAIRS (rid, eid)
values (62686, 10115);
insert into EQUIPREPAIRS (rid, eid)
values (62687, 10311);
insert into EQUIPREPAIRS (rid, eid)
values (62688, 10393);
insert into EQUIPREPAIRS (rid, eid)
values (62689, 10006);
insert into EQUIPREPAIRS (rid, eid)
values (62690, 10078);
insert into EQUIPREPAIRS (rid, eid)
values (62691, 10142);
insert into EQUIPREPAIRS (rid, eid)
values (62692, 10379);
insert into EQUIPREPAIRS (rid, eid)
values (62693, 10095);
insert into EQUIPREPAIRS (rid, eid)
values (62694, 10300);
insert into EQUIPREPAIRS (rid, eid)
values (62695, 10297);
insert into EQUIPREPAIRS (rid, eid)
values (62696, 10050);
insert into EQUIPREPAIRS (rid, eid)
values (62697, 10375);
insert into EQUIPREPAIRS (rid, eid)
values (62698, 10060);
insert into EQUIPREPAIRS (rid, eid)
values (62699, 10046);
insert into EQUIPREPAIRS (rid, eid)
values (62700, 10346);
insert into EQUIPREPAIRS (rid, eid)
values (62701, 10118);
insert into EQUIPREPAIRS (rid, eid)
values (62702, 10008);
insert into EQUIPREPAIRS (rid, eid)
values (62703, 10116);
insert into EQUIPREPAIRS (rid, eid)
values (62704, 10262);
insert into EQUIPREPAIRS (rid, eid)
values (62705, 10081);
insert into EQUIPREPAIRS (rid, eid)
values (62706, 10373);
insert into EQUIPREPAIRS (rid, eid)
values (62707, 10360);
insert into EQUIPREPAIRS (rid, eid)
values (62708, 10206);
insert into EQUIPREPAIRS (rid, eid)
values (62709, 10257);
insert into EQUIPREPAIRS (rid, eid)
values (62710, 10116);
commit;
prompt 300 records committed...
insert into EQUIPREPAIRS (rid, eid)
values (62711, 10167);
insert into EQUIPREPAIRS (rid, eid)
values (62712, 10100);
insert into EQUIPREPAIRS (rid, eid)
values (62713, 10074);
insert into EQUIPREPAIRS (rid, eid)
values (62714, 10225);
insert into EQUIPREPAIRS (rid, eid)
values (62715, 10130);
insert into EQUIPREPAIRS (rid, eid)
values (62716, 10109);
insert into EQUIPREPAIRS (rid, eid)
values (62717, 10402);
insert into EQUIPREPAIRS (rid, eid)
values (62718, 10261);
insert into EQUIPREPAIRS (rid, eid)
values (62719, 10338);
insert into EQUIPREPAIRS (rid, eid)
values (62720, 10254);
insert into EQUIPREPAIRS (rid, eid)
values (62721, 10350);
insert into EQUIPREPAIRS (rid, eid)
values (62722, 10039);
insert into EQUIPREPAIRS (rid, eid)
values (62723, 10054);
insert into EQUIPREPAIRS (rid, eid)
values (62724, 10102);
insert into EQUIPREPAIRS (rid, eid)
values (62725, 10165);
insert into EQUIPREPAIRS (rid, eid)
values (62726, 10217);
insert into EQUIPREPAIRS (rid, eid)
values (62727, 10019);
insert into EQUIPREPAIRS (rid, eid)
values (62728, 10257);
insert into EQUIPREPAIRS (rid, eid)
values (62729, 10167);
insert into EQUIPREPAIRS (rid, eid)
values (62730, 10113);
insert into EQUIPREPAIRS (rid, eid)
values (62731, 10228);
insert into EQUIPREPAIRS (rid, eid)
values (62732, 10187);
insert into EQUIPREPAIRS (rid, eid)
values (62733, 10368);
insert into EQUIPREPAIRS (rid, eid)
values (62734, 10084);
insert into EQUIPREPAIRS (rid, eid)
values (62735, 10255);
insert into EQUIPREPAIRS (rid, eid)
values (62736, 10361);
insert into EQUIPREPAIRS (rid, eid)
values (62737, 10208);
insert into EQUIPREPAIRS (rid, eid)
values (62738, 10111);
insert into EQUIPREPAIRS (rid, eid)
values (62739, 10045);
insert into EQUIPREPAIRS (rid, eid)
values (62740, 10199);
insert into EQUIPREPAIRS (rid, eid)
values (62741, 10018);
insert into EQUIPREPAIRS (rid, eid)
values (62742, 10099);
insert into EQUIPREPAIRS (rid, eid)
values (62743, 10368);
insert into EQUIPREPAIRS (rid, eid)
values (62744, 10022);
insert into EQUIPREPAIRS (rid, eid)
values (62745, 10221);
insert into EQUIPREPAIRS (rid, eid)
values (62746, 10207);
insert into EQUIPREPAIRS (rid, eid)
values (62747, 10233);
insert into EQUIPREPAIRS (rid, eid)
values (62748, 10318);
insert into EQUIPREPAIRS (rid, eid)
values (62749, 10069);
insert into EQUIPREPAIRS (rid, eid)
values (62750, 10064);
insert into EQUIPREPAIRS (rid, eid)
values (62751, 10370);
insert into EQUIPREPAIRS (rid, eid)
values (62752, 10241);
insert into EQUIPREPAIRS (rid, eid)
values (62753, 10222);
insert into EQUIPREPAIRS (rid, eid)
values (62754, 10216);
insert into EQUIPREPAIRS (rid, eid)
values (62755, 10176);
insert into EQUIPREPAIRS (rid, eid)
values (62756, 10191);
insert into EQUIPREPAIRS (rid, eid)
values (62757, 10247);
insert into EQUIPREPAIRS (rid, eid)
values (62758, 10018);
insert into EQUIPREPAIRS (rid, eid)
values (62759, 10261);
insert into EQUIPREPAIRS (rid, eid)
values (62760, 10069);
insert into EQUIPREPAIRS (rid, eid)
values (62761, 10005);
insert into EQUIPREPAIRS (rid, eid)
values (62762, 10382);
insert into EQUIPREPAIRS (rid, eid)
values (62763, 10210);
insert into EQUIPREPAIRS (rid, eid)
values (62764, 10297);
insert into EQUIPREPAIRS (rid, eid)
values (62765, 10234);
insert into EQUIPREPAIRS (rid, eid)
values (62766, 10119);
insert into EQUIPREPAIRS (rid, eid)
values (62767, 10268);
insert into EQUIPREPAIRS (rid, eid)
values (62768, 10211);
insert into EQUIPREPAIRS (rid, eid)
values (62769, 10190);
insert into EQUIPREPAIRS (rid, eid)
values (62770, 10163);
insert into EQUIPREPAIRS (rid, eid)
values (62771, 10402);
insert into EQUIPREPAIRS (rid, eid)
values (62772, 10317);
insert into EQUIPREPAIRS (rid, eid)
values (62773, 10381);
insert into EQUIPREPAIRS (rid, eid)
values (62774, 10154);
insert into EQUIPREPAIRS (rid, eid)
values (62775, 10393);
insert into EQUIPREPAIRS (rid, eid)
values (62776, 10396);
insert into EQUIPREPAIRS (rid, eid)
values (62777, 10373);
insert into EQUIPREPAIRS (rid, eid)
values (62778, 10276);
insert into EQUIPREPAIRS (rid, eid)
values (62779, 10272);
insert into EQUIPREPAIRS (rid, eid)
values (62780, 10146);
insert into EQUIPREPAIRS (rid, eid)
values (62781, 10319);
insert into EQUIPREPAIRS (rid, eid)
values (62782, 10282);
insert into EQUIPREPAIRS (rid, eid)
values (62783, 10103);
insert into EQUIPREPAIRS (rid, eid)
values (62784, 10202);
insert into EQUIPREPAIRS (rid, eid)
values (62785, 10020);
insert into EQUIPREPAIRS (rid, eid)
values (62786, 10324);
insert into EQUIPREPAIRS (rid, eid)
values (62787, 10254);
insert into EQUIPREPAIRS (rid, eid)
values (62788, 10328);
insert into EQUIPREPAIRS (rid, eid)
values (62789, 10329);
insert into EQUIPREPAIRS (rid, eid)
values (62790, 10184);
insert into EQUIPREPAIRS (rid, eid)
values (62791, 10146);
insert into EQUIPREPAIRS (rid, eid)
values (62792, 10106);
insert into EQUIPREPAIRS (rid, eid)
values (62793, 10105);
insert into EQUIPREPAIRS (rid, eid)
values (62794, 10080);
insert into EQUIPREPAIRS (rid, eid)
values (62795, 10047);
insert into EQUIPREPAIRS (rid, eid)
values (62796, 10297);
insert into EQUIPREPAIRS (rid, eid)
values (62797, 10203);
insert into EQUIPREPAIRS (rid, eid)
values (62798, 10269);
insert into EQUIPREPAIRS (rid, eid)
values (62799, 10069);
insert into EQUIPREPAIRS (rid, eid)
values (62800, 10346);
insert into EQUIPREPAIRS (rid, eid)
values (62801, 10214);
insert into EQUIPREPAIRS (rid, eid)
values (62802, 10397);
insert into EQUIPREPAIRS (rid, eid)
values (62803, 10333);
insert into EQUIPREPAIRS (rid, eid)
values (62804, 10069);
insert into EQUIPREPAIRS (rid, eid)
values (62805, 10059);
insert into EQUIPREPAIRS (rid, eid)
values (62806, 10061);
insert into EQUIPREPAIRS (rid, eid)
values (62807, 10292);
insert into EQUIPREPAIRS (rid, eid)
values (62808, 10000);
insert into EQUIPREPAIRS (rid, eid)
values (62809, 10029);
insert into EQUIPREPAIRS (rid, eid)
values (62440, 10387);
commit;
prompt 400 records loaded
prompt Loading VEHICLES...
insert into VEHICLES (vid, typeis, status, did)
values (45140012, 'motorcycle', 'normal', 322498461);
insert into VEHICLES (vid, typeis, status, did)
values (45140013, 'motorcycle', 'normal', 322498462);
insert into VEHICLES (vid, typeis, status, did)
values (45140014, 'motorcycle', 'normal', 322498463);
insert into VEHICLES (vid, typeis, status, did)
values (45140015, 'motorcycle', 'normal', 322498464);
insert into VEHICLES (vid, typeis, status, did)
values (45140016, 'ambulance', 'normal', 322498465);
insert into VEHICLES (vid, typeis, status, did)
values (45140017, 'motorcycle', 'normal', 322498466);
insert into VEHICLES (vid, typeis, status, did)
values (45140018, 'motorcycle', 'normal', 322498467);
insert into VEHICLES (vid, typeis, status, did)
values (45140019, 'motorcycle', 'normal', 322498468);
insert into VEHICLES (vid, typeis, status, did)
values (45140020, 'helicopter', 'normal', 322498469);
insert into VEHICLES (vid, typeis, status, did)
values (45140021, 'helicopter', 'normal', 322498470);
insert into VEHICLES (vid, typeis, status, did)
values (45140022, 'motorcycle', 'normal', 322498471);
insert into VEHICLES (vid, typeis, status, did)
values (45140023, 'motorcycle', 'normal', 322498472);
insert into VEHICLES (vid, typeis, status, did)
values (45140024, 'motorcycle', 'normal', 322498473);
insert into VEHICLES (vid, typeis, status, did)
values (45140025, 'ambulance', 'normal', 322498474);
insert into VEHICLES (vid, typeis, status, did)
values (45140026, 'motorcycle', 'under repair', 322498475);
insert into VEHICLES (vid, typeis, status, did)
values (45140027, 'ambulance', 'normal', 322498476);
insert into VEHICLES (vid, typeis, status, did)
values (45140028, 'motorcycle', 'normal', 322498477);
insert into VEHICLES (vid, typeis, status, did)
values (45140029, 'ambulance', 'normal', 322498478);
insert into VEHICLES (vid, typeis, status, did)
values (45140030, 'ambulance', 'normal', 322498479);
insert into VEHICLES (vid, typeis, status, did)
values (45140031, 'motorcycle', 'under repair', 322498480);
insert into VEHICLES (vid, typeis, status, did)
values (45140032, 'motorcycle', 'normal', 322498481);
insert into VEHICLES (vid, typeis, status, did)
values (45140033, 'motorcycle', 'normal', 322498482);
insert into VEHICLES (vid, typeis, status, did)
values (45140034, 'motorcycle', 'normal', 322498483);
insert into VEHICLES (vid, typeis, status, did)
values (45140035, 'motorcycle', 'normal', 322498484);
insert into VEHICLES (vid, typeis, status, did)
values (45140036, 'motorcycle', 'normal', 322498485);
insert into VEHICLES (vid, typeis, status, did)
values (45140037, 'motorcycle', 'normal', 322498486);
insert into VEHICLES (vid, typeis, status, did)
values (45140038, 'motorcycle', 'normal', 322498487);
insert into VEHICLES (vid, typeis, status, did)
values (45140039, 'motorcycle', 'normal', 322498488);
insert into VEHICLES (vid, typeis, status, did)
values (45140040, 'motorcycle', 'normal', 322498489);
insert into VEHICLES (vid, typeis, status, did)
values (45140041, 'motorcycle', 'normal', 322498490);
insert into VEHICLES (vid, typeis, status, did)
values (45140042, 'ambulance', 'normal', 322498491);
insert into VEHICLES (vid, typeis, status, did)
values (45140043, 'ambulance', 'normal', 322498492);
insert into VEHICLES (vid, typeis, status, did)
values (45140044, 'motorcycle', 'normal', 322498493);
insert into VEHICLES (vid, typeis, status, did)
values (45140045, 'motorcycle', 'normal', 322498494);
insert into VEHICLES (vid, typeis, status, did)
values (45140046, 'motorcycle', 'under repair', 322498495);
insert into VEHICLES (vid, typeis, status, did)
values (45140047, 'motorcycle', 'normal', 322498496);
insert into VEHICLES (vid, typeis, status, did)
values (45140048, 'motorcycle', 'normal', 322498497);
insert into VEHICLES (vid, typeis, status, did)
values (45140049, 'motorcycle', 'normal', 322498498);
insert into VEHICLES (vid, typeis, status, did)
values (45140050, 'motorcycle', 'normal', 322498499);
insert into VEHICLES (vid, typeis, status, did)
values (45140051, 'ambulance', 'normal', 322498500);
insert into VEHICLES (vid, typeis, status, did)
values (45140052, 'motorcycle', 'normal', 322498501);
insert into VEHICLES (vid, typeis, status, did)
values (45140053, 'motorcycle', 'normal', 322498502);
insert into VEHICLES (vid, typeis, status, did)
values (45140054, 'ambulance', 'normal', 322498503);
insert into VEHICLES (vid, typeis, status, did)
values (45140055, 'ambulance', 'normal', 322498504);
insert into VEHICLES (vid, typeis, status, did)
values (45140056, 'ambulance', 'normal', 322498505);
insert into VEHICLES (vid, typeis, status, did)
values (45140057, 'motorcycle', 'normal', 322498506);
insert into VEHICLES (vid, typeis, status, did)
values (45140058, 'motorcycle', 'normal', 322498507);
insert into VEHICLES (vid, typeis, status, did)
values (45140059, 'helicopter', 'normal', 322498508);
insert into VEHICLES (vid, typeis, status, did)
values (45140060, 'motorcycle', 'normal', 322498509);
insert into VEHICLES (vid, typeis, status, did)
values (45140061, 'motorcycle', 'normal', 322498510);
insert into VEHICLES (vid, typeis, status, did)
values (45140062, 'motorcycle', 'normal', 322498511);
insert into VEHICLES (vid, typeis, status, did)
values (45140063, 'motorcycle', 'normal', 322498512);
insert into VEHICLES (vid, typeis, status, did)
values (45140064, 'motorcycle', 'normal', 322498513);
insert into VEHICLES (vid, typeis, status, did)
values (45140065, 'motorcycle', 'normal', 322498514);
insert into VEHICLES (vid, typeis, status, did)
values (45140066, 'motorcycle', 'not normal', 322498515);
insert into VEHICLES (vid, typeis, status, did)
values (45140067, 'motorcycle', 'under repair', 322498516);
insert into VEHICLES (vid, typeis, status, did)
values (45140068, 'motorcycle', 'normal', 322498517);
insert into VEHICLES (vid, typeis, status, did)
values (45140069, 'ambulance', 'normal', 322498518);
insert into VEHICLES (vid, typeis, status, did)
values (45140070, 'motorcycle', 'normal', 322498519);
insert into VEHICLES (vid, typeis, status, did)
values (45140071, 'motorcycle', 'normal', 322498520);
insert into VEHICLES (vid, typeis, status, did)
values (45140072, 'motorcycle', 'normal', 322498521);
insert into VEHICLES (vid, typeis, status, did)
values (45140073, 'motorcycle', 'normal', 322498522);
insert into VEHICLES (vid, typeis, status, did)
values (45140074, 'helicopter', 'normal', 322498523);
insert into VEHICLES (vid, typeis, status, did)
values (45140075, 'motorcycle', 'normal', 322498524);
insert into VEHICLES (vid, typeis, status, did)
values (45140076, 'ambulance', 'normal', 322498525);
insert into VEHICLES (vid, typeis, status, did)
values (45140077, 'motorcycle', 'normal', 322498526);
insert into VEHICLES (vid, typeis, status, did)
values (45140078, 'ambulance', 'normal', 322498527);
insert into VEHICLES (vid, typeis, status, did)
values (45140079, 'helicopter', 'normal', 322498528);
insert into VEHICLES (vid, typeis, status, did)
values (45140080, 'motorcycle', 'normal', 322498529);
insert into VEHICLES (vid, typeis, status, did)
values (45140081, 'motorcycle', 'normal', 322498530);
insert into VEHICLES (vid, typeis, status, did)
values (45140082, 'motorcycle', 'under repair', 322498531);
insert into VEHICLES (vid, typeis, status, did)
values (45140083, 'motorcycle', 'normal', 322498532);
insert into VEHICLES (vid, typeis, status, did)
values (45140084, 'motorcycle', 'normal', 322498533);
insert into VEHICLES (vid, typeis, status, did)
values (45140085, 'motorcycle', 'normal', 322498534);
insert into VEHICLES (vid, typeis, status, did)
values (45140086, 'motorcycle', 'normal', 322498535);
insert into VEHICLES (vid, typeis, status, did)
values (45140087, 'motorcycle', 'normal', 322498536);
insert into VEHICLES (vid, typeis, status, did)
values (45140088, 'motorcycle', 'normal', 322498537);
insert into VEHICLES (vid, typeis, status, did)
values (45140089, 'motorcycle', 'normal', 322498538);
insert into VEHICLES (vid, typeis, status, did)
values (45140090, 'motorcycle', 'normal', 322498539);
insert into VEHICLES (vid, typeis, status, did)
values (45140091, 'helicopter', 'normal', 322498540);
insert into VEHICLES (vid, typeis, status, did)
values (45140092, 'motorcycle', 'normal', 322498541);
insert into VEHICLES (vid, typeis, status, did)
values (45140093, 'motorcycle', 'under repair', 322498542);
insert into VEHICLES (vid, typeis, status, did)
values (45140094, 'motorcycle', 'normal', 322498543);
insert into VEHICLES (vid, typeis, status, did)
values (45140095, 'motorcycle', 'normal', 322498544);
insert into VEHICLES (vid, typeis, status, did)
values (45140096, 'ambulance', 'normal', 322498545);
insert into VEHICLES (vid, typeis, status, did)
values (45140097, 'motorcycle', 'normal', 322498546);
insert into VEHICLES (vid, typeis, status, did)
values (45140098, 'helicopter', 'normal', 322498547);
insert into VEHICLES (vid, typeis, status, did)
values (45140099, 'ambulance', 'normal', 322498548);
insert into VEHICLES (vid, typeis, status, did)
values (45140100, 'ambulance', 'normal', 322498549);
insert into VEHICLES (vid, typeis, status, did)
values (45140101, 'ambulance', 'normal', 322498550);
insert into VEHICLES (vid, typeis, status, did)
values (45140102, 'ambulance', 'normal', 322498551);
insert into VEHICLES (vid, typeis, status, did)
values (45140103, 'motorcycle', 'normal', 322498552);
insert into VEHICLES (vid, typeis, status, did)
values (45140104, 'ambulance', 'under repair', 322498553);
insert into VEHICLES (vid, typeis, status, did)
values (45140105, 'motorcycle', 'under repair', 322498554);
insert into VEHICLES (vid, typeis, status, did)
values (45140106, 'ambulance', 'normal', 322498555);
insert into VEHICLES (vid, typeis, status, did)
values (45140107, 'motorcycle', 'normal', 322498556);
insert into VEHICLES (vid, typeis, status, did)
values (45140108, 'ambulance', 'normal', 322498557);
insert into VEHICLES (vid, typeis, status, did)
values (45140109, 'motorcycle', 'normal', 322498558);
insert into VEHICLES (vid, typeis, status, did)
values (45140110, 'ambulance', 'normal', 322498559);
insert into VEHICLES (vid, typeis, status, did)
values (45140111, 'motorcycle', 'normal', 322498560);
commit;
prompt 100 records committed...
insert into VEHICLES (vid, typeis, status, did)
values (45140112, 'ambulance', 'normal', 322498561);
insert into VEHICLES (vid, typeis, status, did)
values (45140113, 'motorcycle', 'normal', 322498562);
insert into VEHICLES (vid, typeis, status, did)
values (45140114, 'motorcycle', 'under repair', 322498563);
insert into VEHICLES (vid, typeis, status, did)
values (45140115, 'motorcycle', 'normal', 322498564);
insert into VEHICLES (vid, typeis, status, did)
values (45140116, 'ambulance', 'normal', 322498565);
insert into VEHICLES (vid, typeis, status, did)
values (45140117, 'motorcycle', 'normal', 322498566);
insert into VEHICLES (vid, typeis, status, did)
values (45140118, 'motorcycle', 'normal', 322498567);
insert into VEHICLES (vid, typeis, status, did)
values (45140119, 'motorcycle', 'normal', 322498568);
insert into VEHICLES (vid, typeis, status, did)
values (45140120, 'motorcycle', 'normal', 322498569);
insert into VEHICLES (vid, typeis, status, did)
values (45140121, 'motorcycle', 'normal', 322498570);
insert into VEHICLES (vid, typeis, status, did)
values (45140122, 'motorcycle', 'normal', 322498571);
insert into VEHICLES (vid, typeis, status, did)
values (45140123, 'motorcycle', 'normal', 322498572);
insert into VEHICLES (vid, typeis, status, did)
values (45140124, 'motorcycle', 'normal', 322498573);
insert into VEHICLES (vid, typeis, status, did)
values (45140125, 'motorcycle', 'under repair', 322498574);
insert into VEHICLES (vid, typeis, status, did)
values (45140126, 'ambulance', 'normal', 322498575);
insert into VEHICLES (vid, typeis, status, did)
values (45140127, 'ambulance', 'not normal', 322498576);
insert into VEHICLES (vid, typeis, status, did)
values (45140128, 'motorcycle', 'normal', 322498577);
insert into VEHICLES (vid, typeis, status, did)
values (45140129, 'ambulance', 'normal', 322498578);
insert into VEHICLES (vid, typeis, status, did)
values (45140130, 'motorcycle', 'normal', 322498579);
insert into VEHICLES (vid, typeis, status, did)
values (45140131, 'ambulance', 'under repair', 322498580);
insert into VEHICLES (vid, typeis, status, did)
values (45140132, 'motorcycle', 'normal', 322498581);
insert into VEHICLES (vid, typeis, status, did)
values (45140133, 'motorcycle', 'normal', 322498582);
insert into VEHICLES (vid, typeis, status, did)
values (45140134, 'motorcycle', 'normal', 322498583);
insert into VEHICLES (vid, typeis, status, did)
values (45140135, 'motorcycle', 'normal', 322498584);
insert into VEHICLES (vid, typeis, status, did)
values (45140136, 'motorcycle', 'normal', 322498585);
insert into VEHICLES (vid, typeis, status, did)
values (45140137, 'helicopter', 'normal', 322498586);
insert into VEHICLES (vid, typeis, status, did)
values (45140138, 'motorcycle', 'normal', 322498587);
insert into VEHICLES (vid, typeis, status, did)
values (45140139, 'ambulance', 'normal', 322498588);
insert into VEHICLES (vid, typeis, status, did)
values (45140140, 'motorcycle', 'not normal', 322498589);
insert into VEHICLES (vid, typeis, status, did)
values (45140141, 'motorcycle', 'normal', 322498590);
insert into VEHICLES (vid, typeis, status, did)
values (45140142, 'motorcycle', 'normal', 322498591);
insert into VEHICLES (vid, typeis, status, did)
values (45140143, 'motorcycle', 'normal', 322498592);
insert into VEHICLES (vid, typeis, status, did)
values (45140144, 'ambulance', 'normal', 322498593);
insert into VEHICLES (vid, typeis, status, did)
values (45140145, 'motorcycle', 'under repair', 322498594);
insert into VEHICLES (vid, typeis, status, did)
values (45140146, 'motorcycle', 'under repair', 322498595);
insert into VEHICLES (vid, typeis, status, did)
values (45140147, 'motorcycle', 'normal', 322498596);
insert into VEHICLES (vid, typeis, status, did)
values (45140148, 'motorcycle', 'normal', 322498597);
insert into VEHICLES (vid, typeis, status, did)
values (45140149, 'motorcycle', 'normal', 322498598);
insert into VEHICLES (vid, typeis, status, did)
values (45140150, 'motorcycle', 'normal', 322498599);
insert into VEHICLES (vid, typeis, status, did)
values (45140151, 'motorcycle', 'normal', 322498600);
insert into VEHICLES (vid, typeis, status, did)
values (45140152, 'ambulance', 'normal', 322498601);
insert into VEHICLES (vid, typeis, status, did)
values (45140153, 'motorcycle', 'normal', 322498602);
insert into VEHICLES (vid, typeis, status, did)
values (45140154, 'ambulance', 'normal', 322498603);
insert into VEHICLES (vid, typeis, status, did)
values (45140155, 'motorcycle', 'not normal', 322498604);
insert into VEHICLES (vid, typeis, status, did)
values (45140156, 'ambulance', 'normal', 322498605);
insert into VEHICLES (vid, typeis, status, did)
values (45140157, 'motorcycle', 'normal', 322498606);
insert into VEHICLES (vid, typeis, status, did)
values (45140158, 'motorcycle', 'normal', 322498607);
insert into VEHICLES (vid, typeis, status, did)
values (45140159, 'helicopter', 'normal', 322498608);
insert into VEHICLES (vid, typeis, status, did)
values (45140160, 'motorcycle', 'normal', 322498609);
insert into VEHICLES (vid, typeis, status, did)
values (45140161, 'motorcycle', 'normal', 322498610);
insert into VEHICLES (vid, typeis, status, did)
values (45140162, 'motorcycle', 'under repair', 322498611);
insert into VEHICLES (vid, typeis, status, did)
values (45140163, 'motorcycle', 'normal', 322498612);
insert into VEHICLES (vid, typeis, status, did)
values (45140164, 'ambulance', 'not normal', 322498613);
insert into VEHICLES (vid, typeis, status, did)
values (45140165, 'ambulance', 'normal', 322498614);
insert into VEHICLES (vid, typeis, status, did)
values (45140166, 'motorcycle', 'normal', 322498615);
insert into VEHICLES (vid, typeis, status, did)
values (45140167, 'ambulance', 'normal', 322498616);
insert into VEHICLES (vid, typeis, status, did)
values (45140168, 'motorcycle', 'under repair', 322498617);
insert into VEHICLES (vid, typeis, status, did)
values (45140169, 'motorcycle', 'normal', 322498618);
insert into VEHICLES (vid, typeis, status, did)
values (45140170, 'helicopter', 'normal', 322498619);
insert into VEHICLES (vid, typeis, status, did)
values (45140171, 'ambulance', 'normal', 322498620);
insert into VEHICLES (vid, typeis, status, did)
values (45140172, 'helicopter', 'normal', 322498621);
insert into VEHICLES (vid, typeis, status, did)
values (45140173, 'motorcycle', 'normal', 322498622);
insert into VEHICLES (vid, typeis, status, did)
values (45140174, 'motorcycle', 'normal', 322498623);
insert into VEHICLES (vid, typeis, status, did)
values (45140175, 'ambulance', 'normal', 322498624);
insert into VEHICLES (vid, typeis, status, did)
values (45140176, 'ambulance', 'normal', 322498625);
insert into VEHICLES (vid, typeis, status, did)
values (45140177, 'motorcycle', 'normal', 322498626);
insert into VEHICLES (vid, typeis, status, did)
values (45140178, 'motorcycle', 'normal', 322498627);
insert into VEHICLES (vid, typeis, status, did)
values (45140179, 'ambulance', 'under repair', 322498628);
insert into VEHICLES (vid, typeis, status, did)
values (45140180, 'motorcycle', 'normal', 322498629);
insert into VEHICLES (vid, typeis, status, did)
values (45140181, 'motorcycle', 'under repair', 322498630);
insert into VEHICLES (vid, typeis, status, did)
values (45140182, 'motorcycle', 'normal', 322498631);
insert into VEHICLES (vid, typeis, status, did)
values (45140183, 'ambulance', 'normal', 322498632);
insert into VEHICLES (vid, typeis, status, did)
values (45140184, 'motorcycle', 'normal', 322498633);
insert into VEHICLES (vid, typeis, status, did)
values (45140185, 'motorcycle', 'normal', 322498634);
insert into VEHICLES (vid, typeis, status, did)
values (45140186, 'ambulance', 'normal', 322498635);
insert into VEHICLES (vid, typeis, status, did)
values (45140187, 'ambulance', 'normal', 322498636);
insert into VEHICLES (vid, typeis, status, did)
values (45140188, 'ambulance', 'normal', 322498637);
insert into VEHICLES (vid, typeis, status, did)
values (45140189, 'motorcycle', 'normal', 322498638);
insert into VEHICLES (vid, typeis, status, did)
values (45140190, 'ambulance', 'normal', 322498639);
insert into VEHICLES (vid, typeis, status, did)
values (45140191, 'motorcycle', 'under repair', 322498640);
insert into VEHICLES (vid, typeis, status, did)
values (45140192, 'motorcycle', 'normal', 322498641);
insert into VEHICLES (vid, typeis, status, did)
values (45140193, 'motorcycle', 'normal', 322498642);
insert into VEHICLES (vid, typeis, status, did)
values (45140194, 'motorcycle', 'under repair', 322498643);
insert into VEHICLES (vid, typeis, status, did)
values (45140195, 'motorcycle', 'normal', 322498644);
insert into VEHICLES (vid, typeis, status, did)
values (45140196, 'motorcycle', 'normal', 322498645);
insert into VEHICLES (vid, typeis, status, did)
values (45140197, 'ambulance', 'normal', 322498646);
insert into VEHICLES (vid, typeis, status, did)
values (45140198, 'motorcycle', 'not normal', 322498647);
insert into VEHICLES (vid, typeis, status, did)
values (45140199, 'ambulance', 'normal', 322498648);
insert into VEHICLES (vid, typeis, status, did)
values (45140200, 'ambulance', 'normal', 322498649);
insert into VEHICLES (vid, typeis, status, did)
values (45140201, 'motorcycle', 'normal', 322498650);
insert into VEHICLES (vid, typeis, status, did)
values (45140202, 'motorcycle', 'not normal', 322498651);
insert into VEHICLES (vid, typeis, status, did)
values (45140203, 'motorcycle', 'normal', 322498652);
insert into VEHICLES (vid, typeis, status, did)
values (45140204, 'motorcycle', 'normal', 322498653);
insert into VEHICLES (vid, typeis, status, did)
values (45140205, 'motorcycle', 'under repair', 322498654);
insert into VEHICLES (vid, typeis, status, did)
values (45140206, 'motorcycle', 'normal', 322498655);
insert into VEHICLES (vid, typeis, status, did)
values (45140207, 'motorcycle', 'normal', 322498656);
insert into VEHICLES (vid, typeis, status, did)
values (45140208, 'motorcycle', 'not normal', 322498657);
insert into VEHICLES (vid, typeis, status, did)
values (45140209, 'motorcycle', 'normal', 322498658);
insert into VEHICLES (vid, typeis, status, did)
values (45140210, 'motorcycle', 'normal', 322498659);
insert into VEHICLES (vid, typeis, status, did)
values (45140211, 'motorcycle', 'normal', 322498660);
commit;
prompt 200 records committed...
insert into VEHICLES (vid, typeis, status, did)
values (45140212, 'helicopter', 'normal', 322498661);
insert into VEHICLES (vid, typeis, status, did)
values (45140213, 'ambulance', 'normal', 322498662);
insert into VEHICLES (vid, typeis, status, did)
values (45140214, 'helicopter', 'normal', 322498663);
insert into VEHICLES (vid, typeis, status, did)
values (45140215, 'motorcycle', 'normal', 322498664);
insert into VEHICLES (vid, typeis, status, did)
values (45140216, 'motorcycle', 'normal', 322498665);
insert into VEHICLES (vid, typeis, status, did)
values (45140217, 'ambulance', 'normal', 322498666);
insert into VEHICLES (vid, typeis, status, did)
values (45140218, 'ambulance', 'normal', 322498667);
insert into VEHICLES (vid, typeis, status, did)
values (45140219, 'motorcycle', 'normal', 322498668);
insert into VEHICLES (vid, typeis, status, did)
values (45140220, 'motorcycle', 'normal', 322498669);
insert into VEHICLES (vid, typeis, status, did)
values (45140221, 'ambulance', 'under repair', 322498670);
insert into VEHICLES (vid, typeis, status, did)
values (45140222, 'motorcycle', 'normal', 322498671);
insert into VEHICLES (vid, typeis, status, did)
values (45140223, 'motorcycle', 'normal', 322498672);
insert into VEHICLES (vid, typeis, status, did)
values (45140224, 'motorcycle', 'under repair', 322498673);
insert into VEHICLES (vid, typeis, status, did)
values (45140225, 'motorcycle', 'normal', 322498674);
insert into VEHICLES (vid, typeis, status, did)
values (45140226, 'motorcycle', 'normal', 322498675);
insert into VEHICLES (vid, typeis, status, did)
values (45140227, 'helicopter', 'normal', 322498676);
insert into VEHICLES (vid, typeis, status, did)
values (45140228, 'ambulance', 'normal', 322498677);
insert into VEHICLES (vid, typeis, status, did)
values (45140229, 'motorcycle', 'normal', 322498678);
insert into VEHICLES (vid, typeis, status, did)
values (45140230, 'motorcycle', 'normal', 322498679);
insert into VEHICLES (vid, typeis, status, did)
values (45140231, 'ambulance', 'under repair', 322498680);
insert into VEHICLES (vid, typeis, status, did)
values (45140232, 'motorcycle', 'normal', 322498681);
insert into VEHICLES (vid, typeis, status, did)
values (45140233, 'motorcycle', 'normal', 322498682);
insert into VEHICLES (vid, typeis, status, did)
values (45140234, 'motorcycle', 'normal', 322498683);
insert into VEHICLES (vid, typeis, status, did)
values (45140235, 'ambulance', 'normal', 322498684);
insert into VEHICLES (vid, typeis, status, did)
values (45140236, 'motorcycle', 'normal', 322498685);
insert into VEHICLES (vid, typeis, status, did)
values (45140237, 'ambulance', 'normal', 322498686);
insert into VEHICLES (vid, typeis, status, did)
values (45140238, 'motorcycle', 'normal', 322498687);
insert into VEHICLES (vid, typeis, status, did)
values (45140239, 'ambulance', 'normal', 322498688);
insert into VEHICLES (vid, typeis, status, did)
values (45140240, 'ambulance', 'under repair', 322498689);
insert into VEHICLES (vid, typeis, status, did)
values (45140241, 'motorcycle', 'normal', 322498690);
insert into VEHICLES (vid, typeis, status, did)
values (45140242, 'motorcycle', 'normal', 322498691);
insert into VEHICLES (vid, typeis, status, did)
values (45140243, 'ambulance', 'normal', 322498692);
insert into VEHICLES (vid, typeis, status, did)
values (45140244, 'motorcycle', 'normal', 322498693);
insert into VEHICLES (vid, typeis, status, did)
values (45140245, 'motorcycle', 'normal', 322498694);
insert into VEHICLES (vid, typeis, status, did)
values (45140246, 'motorcycle', 'normal', 322498695);
insert into VEHICLES (vid, typeis, status, did)
values (45140247, 'motorcycle', 'normal', 322498696);
insert into VEHICLES (vid, typeis, status, did)
values (45140248, 'ambulance', 'normal', 322498697);
insert into VEHICLES (vid, typeis, status, did)
values (45140249, 'motorcycle', 'normal', 322498698);
insert into VEHICLES (vid, typeis, status, did)
values (45140250, 'motorcycle', 'normal', 322498699);
insert into VEHICLES (vid, typeis, status, did)
values (45140251, 'motorcycle', 'normal', 322498700);
insert into VEHICLES (vid, typeis, status, did)
values (45140252, 'motorcycle', 'normal', 322498701);
insert into VEHICLES (vid, typeis, status, did)
values (45140253, 'motorcycle', 'under repair', 322498702);
insert into VEHICLES (vid, typeis, status, did)
values (45140254, 'motorcycle', 'normal', 322498703);
insert into VEHICLES (vid, typeis, status, did)
values (45140255, 'motorcycle', 'normal', 322498704);
insert into VEHICLES (vid, typeis, status, did)
values (45140256, 'motorcycle', 'normal', 322498705);
insert into VEHICLES (vid, typeis, status, did)
values (45140257, 'ambulance', 'under repair', 322498706);
insert into VEHICLES (vid, typeis, status, did)
values (45140258, 'motorcycle', 'normal', 322498707);
insert into VEHICLES (vid, typeis, status, did)
values (45140259, 'motorcycle', 'normal', 322498708);
insert into VEHICLES (vid, typeis, status, did)
values (45140260, 'motorcycle', 'normal', 322498709);
insert into VEHICLES (vid, typeis, status, did)
values (45140261, 'ambulance', 'normal', 322498710);
insert into VEHICLES (vid, typeis, status, did)
values (45140262, 'motorcycle', 'normal', 322498711);
insert into VEHICLES (vid, typeis, status, did)
values (45140263, 'motorcycle', 'normal', 322498712);
insert into VEHICLES (vid, typeis, status, did)
values (45140264, 'motorcycle', 'normal', 322498713);
insert into VEHICLES (vid, typeis, status, did)
values (45140265, 'motorcycle', 'under repair', 322498714);
insert into VEHICLES (vid, typeis, status, did)
values (45140266, 'ambulance', 'normal', 322498715);
insert into VEHICLES (vid, typeis, status, did)
values (45140267, 'motorcycle', 'normal', 322498716);
insert into VEHICLES (vid, typeis, status, did)
values (45140268, 'helicopter', 'normal', 322498717);
insert into VEHICLES (vid, typeis, status, did)
values (45140269, 'ambulance', 'normal', 322498718);
insert into VEHICLES (vid, typeis, status, did)
values (45140270, 'motorcycle', 'normal', 322498719);
insert into VEHICLES (vid, typeis, status, did)
values (45140271, 'ambulance', 'normal', 322498720);
insert into VEHICLES (vid, typeis, status, did)
values (45140272, 'motorcycle', 'normal', 322498721);
insert into VEHICLES (vid, typeis, status, did)
values (45140273, 'ambulance', 'normal', 322498722);
insert into VEHICLES (vid, typeis, status, did)
values (45140274, 'motorcycle', 'normal', 322498723);
insert into VEHICLES (vid, typeis, status, did)
values (45140275, 'motorcycle', 'normal', 322498724);
insert into VEHICLES (vid, typeis, status, did)
values (45140276, 'motorcycle', 'normal', 322498725);
insert into VEHICLES (vid, typeis, status, did)
values (45140277, 'ambulance', 'normal', 322498726);
insert into VEHICLES (vid, typeis, status, did)
values (45140278, 'ambulance', 'normal', 322498727);
insert into VEHICLES (vid, typeis, status, did)
values (45140279, 'ambulance', 'normal', 322498728);
insert into VEHICLES (vid, typeis, status, did)
values (45140280, 'motorcycle', 'normal', 322498729);
insert into VEHICLES (vid, typeis, status, did)
values (45140281, 'motorcycle', 'normal', 322498730);
insert into VEHICLES (vid, typeis, status, did)
values (45140282, 'motorcycle', 'normal', 322498731);
insert into VEHICLES (vid, typeis, status, did)
values (45140283, 'helicopter', 'normal', 322498732);
insert into VEHICLES (vid, typeis, status, did)
values (45140284, 'motorcycle', 'normal', 322498733);
insert into VEHICLES (vid, typeis, status, did)
values (45140285, 'motorcycle', 'normal', 322498734);
insert into VEHICLES (vid, typeis, status, did)
values (45140286, 'motorcycle', 'under repair', 322498735);
insert into VEHICLES (vid, typeis, status, did)
values (45140287, 'motorcycle', 'normal', 322498736);
insert into VEHICLES (vid, typeis, status, did)
values (45140288, 'motorcycle', 'normal', 322498737);
insert into VEHICLES (vid, typeis, status, did)
values (45140289, 'motorcycle', 'normal', 322498738);
insert into VEHICLES (vid, typeis, status, did)
values (45140290, 'motorcycle', 'normal', 322498739);
insert into VEHICLES (vid, typeis, status, did)
values (45140291, 'ambulance', 'normal', 322498740);
insert into VEHICLES (vid, typeis, status, did)
values (45140292, 'helicopter', 'not normal', 322498741);
insert into VEHICLES (vid, typeis, status, did)
values (45140293, 'ambulance', 'normal', 322498742);
insert into VEHICLES (vid, typeis, status, did)
values (45140294, 'helicopter', 'normal', 322498743);
insert into VEHICLES (vid, typeis, status, did)
values (45140295, 'motorcycle', 'normal', 322498744);
insert into VEHICLES (vid, typeis, status, did)
values (45140296, 'motorcycle', 'normal', 322498745);
insert into VEHICLES (vid, typeis, status, did)
values (45140297, 'motorcycle', 'not normal', 322498746);
insert into VEHICLES (vid, typeis, status, did)
values (45140298, 'motorcycle', 'normal', 322498747);
insert into VEHICLES (vid, typeis, status, did)
values (45140299, 'motorcycle', 'normal', 322498748);
insert into VEHICLES (vid, typeis, status, did)
values (45140300, 'ambulance', 'normal', 322498749);
insert into VEHICLES (vid, typeis, status, did)
values (45140301, 'motorcycle', 'normal', 322498750);
insert into VEHICLES (vid, typeis, status, did)
values (45140302, 'motorcycle', 'normal', 322498751);
insert into VEHICLES (vid, typeis, status, did)
values (45140303, 'ambulance', 'under repair', 322498752);
insert into VEHICLES (vid, typeis, status, did)
values (45140304, 'motorcycle', 'normal', 322498753);
insert into VEHICLES (vid, typeis, status, did)
values (45140305, 'ambulance', 'normal', 322498754);
insert into VEHICLES (vid, typeis, status, did)
values (45140306, 'motorcycle', 'normal', 322498755);
insert into VEHICLES (vid, typeis, status, did)
values (45140307, 'motorcycle', 'not normal', 322498756);
insert into VEHICLES (vid, typeis, status, did)
values (45140308, 'motorcycle', 'normal', 322498757);
insert into VEHICLES (vid, typeis, status, did)
values (45140309, 'motorcycle', 'under repair', 322498758);
insert into VEHICLES (vid, typeis, status, did)
values (45140310, 'ambulance', 'normal', 322498759);
insert into VEHICLES (vid, typeis, status, did)
values (45140311, 'motorcycle', 'normal', 322498760);
commit;
prompt 300 records committed...
insert into VEHICLES (vid, typeis, status, did)
values (45140312, 'motorcycle', 'under repair', 322498761);
insert into VEHICLES (vid, typeis, status, did)
values (45140313, 'motorcycle', 'under repair', 322498762);
insert into VEHICLES (vid, typeis, status, did)
values (45140314, 'motorcycle', 'normal', 322498763);
insert into VEHICLES (vid, typeis, status, did)
values (45140315, 'motorcycle', 'normal', 322498764);
insert into VEHICLES (vid, typeis, status, did)
values (45140316, 'motorcycle', 'normal', 322498765);
insert into VEHICLES (vid, typeis, status, did)
values (45140317, 'motorcycle', 'normal', 322498766);
insert into VEHICLES (vid, typeis, status, did)
values (45140318, 'ambulance', 'normal', 322498767);
insert into VEHICLES (vid, typeis, status, did)
values (45140319, 'motorcycle', 'normal', 322498768);
insert into VEHICLES (vid, typeis, status, did)
values (45140320, 'ambulance', 'normal', 322498769);
insert into VEHICLES (vid, typeis, status, did)
values (45140321, 'motorcycle', 'under repair', 322498770);
insert into VEHICLES (vid, typeis, status, did)
values (45140322, 'motorcycle', 'under repair', 322498771);
insert into VEHICLES (vid, typeis, status, did)
values (45140323, 'motorcycle', 'normal', 322498772);
insert into VEHICLES (vid, typeis, status, did)
values (45140324, 'motorcycle', 'normal', 322498773);
insert into VEHICLES (vid, typeis, status, did)
values (45140325, 'ambulance', 'under repair', 322498774);
insert into VEHICLES (vid, typeis, status, did)
values (45140326, 'motorcycle', 'normal', 322498775);
insert into VEHICLES (vid, typeis, status, did)
values (45140327, 'motorcycle', 'normal', 322498776);
insert into VEHICLES (vid, typeis, status, did)
values (45140328, 'motorcycle', 'normal', 322498777);
insert into VEHICLES (vid, typeis, status, did)
values (45140329, 'motorcycle', 'normal', 322498778);
insert into VEHICLES (vid, typeis, status, did)
values (45140330, 'motorcycle', 'normal', 322498779);
insert into VEHICLES (vid, typeis, status, did)
values (45140331, 'motorcycle', 'normal', 322498780);
insert into VEHICLES (vid, typeis, status, did)
values (45140332, 'ambulance', 'normal', 322498781);
insert into VEHICLES (vid, typeis, status, did)
values (45140333, 'ambulance', 'normal', 322498782);
insert into VEHICLES (vid, typeis, status, did)
values (45140334, 'motorcycle', 'normal', 322498783);
insert into VEHICLES (vid, typeis, status, did)
values (45140335, 'motorcycle', 'not normal', 322498784);
insert into VEHICLES (vid, typeis, status, did)
values (45140336, 'motorcycle', 'normal', 322498785);
insert into VEHICLES (vid, typeis, status, did)
values (45140337, 'motorcycle', 'normal', 322498786);
insert into VEHICLES (vid, typeis, status, did)
values (45140338, 'motorcycle', 'normal', 322498787);
insert into VEHICLES (vid, typeis, status, did)
values (45140339, 'motorcycle', 'under repair', 322498788);
insert into VEHICLES (vid, typeis, status, did)
values (45140340, 'motorcycle', 'normal', 322498789);
insert into VEHICLES (vid, typeis, status, did)
values (45140341, 'motorcycle', 'normal', 322498790);
insert into VEHICLES (vid, typeis, status, did)
values (45140342, 'motorcycle', 'normal', 322498791);
insert into VEHICLES (vid, typeis, status, did)
values (45140343, 'motorcycle', 'normal', 322498792);
insert into VEHICLES (vid, typeis, status, did)
values (45140344, 'motorcycle', 'normal', 322498793);
insert into VEHICLES (vid, typeis, status, did)
values (45140345, 'helicopter', 'normal', 322498794);
insert into VEHICLES (vid, typeis, status, did)
values (45140346, 'motorcycle', 'normal', 322498795);
insert into VEHICLES (vid, typeis, status, did)
values (45140347, 'ambulance', 'under repair', 322498796);
insert into VEHICLES (vid, typeis, status, did)
values (45140348, 'motorcycle', 'under repair', 322498797);
insert into VEHICLES (vid, typeis, status, did)
values (45140349, 'motorcycle', 'normal', 322498798);
insert into VEHICLES (vid, typeis, status, did)
values (45140350, 'motorcycle', 'under repair', 322498799);
insert into VEHICLES (vid, typeis, status, did)
values (45140351, 'motorcycle', 'normal', 322498800);
insert into VEHICLES (vid, typeis, status, did)
values (45140352, 'motorcycle', 'under repair', 322498801);
insert into VEHICLES (vid, typeis, status, did)
values (45140353, 'motorcycle', 'normal', 322498802);
insert into VEHICLES (vid, typeis, status, did)
values (45140354, 'motorcycle', 'normal', 322498803);
insert into VEHICLES (vid, typeis, status, did)
values (45140355, 'ambulance', 'normal', 322498804);
insert into VEHICLES (vid, typeis, status, did)
values (45140356, 'motorcycle', 'normal', 322498805);
insert into VEHICLES (vid, typeis, status, did)
values (45140357, 'motorcycle', 'normal', 322498806);
insert into VEHICLES (vid, typeis, status, did)
values (45140358, 'ambulance', 'normal', 322498807);
insert into VEHICLES (vid, typeis, status, did)
values (45140359, 'helicopter', 'normal', 322498808);
insert into VEHICLES (vid, typeis, status, did)
values (45140360, 'motorcycle', 'normal', 322498809);
insert into VEHICLES (vid, typeis, status, did)
values (45140361, 'motorcycle', 'normal', 322498810);
insert into VEHICLES (vid, typeis, status, did)
values (45140362, 'motorcycle', 'normal', 322498811);
insert into VEHICLES (vid, typeis, status, did)
values (45140363, 'motorcycle', 'normal', 322498812);
insert into VEHICLES (vid, typeis, status, did)
values (45140364, 'motorcycle', 'normal', 322498813);
insert into VEHICLES (vid, typeis, status, did)
values (45140365, 'ambulance', 'normal', 322498814);
insert into VEHICLES (vid, typeis, status, did)
values (45140366, 'motorcycle', 'normal', 322498815);
insert into VEHICLES (vid, typeis, status, did)
values (45140367, 'motorcycle', 'normal', 322498816);
insert into VEHICLES (vid, typeis, status, did)
values (45140368, 'ambulance', 'normal', 322498817);
insert into VEHICLES (vid, typeis, status, did)
values (45140369, 'ambulance', 'normal', 322498818);
insert into VEHICLES (vid, typeis, status, did)
values (45140370, 'motorcycle', 'normal', 322498819);
insert into VEHICLES (vid, typeis, status, did)
values (45140371, 'motorcycle', 'normal', 322498820);
insert into VEHICLES (vid, typeis, status, did)
values (45140372, 'motorcycle', 'normal', 322498821);
insert into VEHICLES (vid, typeis, status, did)
values (45140373, 'motorcycle', 'normal', 322498822);
insert into VEHICLES (vid, typeis, status, did)
values (45140374, 'motorcycle', 'normal', 322498823);
insert into VEHICLES (vid, typeis, status, did)
values (45140375, 'motorcycle', 'normal', 322498824);
insert into VEHICLES (vid, typeis, status, did)
values (45140376, 'motorcycle', 'under repair', 322498825);
insert into VEHICLES (vid, typeis, status, did)
values (45140377, 'motorcycle', 'normal', 322498826);
insert into VEHICLES (vid, typeis, status, did)
values (45140378, 'ambulance', 'under repair', 322498827);
insert into VEHICLES (vid, typeis, status, did)
values (45140379, 'motorcycle', 'normal', 322498828);
insert into VEHICLES (vid, typeis, status, did)
values (45140380, 'motorcycle', 'normal', 322498829);
insert into VEHICLES (vid, typeis, status, did)
values (45140381, 'motorcycle', 'normal', 322498830);
insert into VEHICLES (vid, typeis, status, did)
values (45140382, 'motorcycle', 'normal', 322498831);
insert into VEHICLES (vid, typeis, status, did)
values (45140383, 'motorcycle', 'normal', 322498832);
insert into VEHICLES (vid, typeis, status, did)
values (45140384, 'motorcycle', 'normal', 322498833);
insert into VEHICLES (vid, typeis, status, did)
values (45140385, 'motorcycle', 'normal', 322498834);
insert into VEHICLES (vid, typeis, status, did)
values (45140386, 'motorcycle', 'normal', 322498835);
insert into VEHICLES (vid, typeis, status, did)
values (45140387, 'motorcycle', 'normal', 322498836);
insert into VEHICLES (vid, typeis, status, did)
values (45140388, 'motorcycle', 'normal', 322498837);
insert into VEHICLES (vid, typeis, status, did)
values (45140389, 'motorcycle', 'normal', 322498838);
insert into VEHICLES (vid, typeis, status, did)
values (45140390, 'motorcycle', 'normal', 322498839);
insert into VEHICLES (vid, typeis, status, did)
values (45140391, 'motorcycle', 'normal', 322498840);
insert into VEHICLES (vid, typeis, status, did)
values (45140392, 'ambulance', 'normal', 322498841);
insert into VEHICLES (vid, typeis, status, did)
values (45140393, 'ambulance', 'normal', 322498842);
insert into VEHICLES (vid, typeis, status, did)
values (45140394, 'motorcycle', 'under repair', 322498843);
insert into VEHICLES (vid, typeis, status, did)
values (45140395, 'ambulance', 'normal', 322498844);
insert into VEHICLES (vid, typeis, status, did)
values (45140396, 'ambulance', 'normal', 322498845);
insert into VEHICLES (vid, typeis, status, did)
values (45140397, 'motorcycle', 'normal', 322498846);
insert into VEHICLES (vid, typeis, status, did)
values (45140398, 'motorcycle', 'normal', 322498847);
insert into VEHICLES (vid, typeis, status, did)
values (45140399, 'motorcycle', 'normal', 322498848);
insert into VEHICLES (vid, typeis, status, did)
values (45140400, 'motorcycle', 'normal', 322498849);
insert into VEHICLES (vid, typeis, status, did)
values (45140401, 'motorcycle', 'normal', 322498850);
insert into VEHICLES (vid, typeis, status, did)
values (45140402, 'ambulance', 'normal', 322498851);
insert into VEHICLES (vid, typeis, status, did)
values (45140403, 'ambulance', 'normal', 322498852);
insert into VEHICLES (vid, typeis, status, did)
values (45140404, 'ambulance', 'normal', 322498853);
insert into VEHICLES (vid, typeis, status, did)
values (45140405, 'motorcycle', 'normal', 322498854);
insert into VEHICLES (vid, typeis, status, did)
values (45140406, 'helicopter', 'normal', 322498855);
insert into VEHICLES (vid, typeis, status, did)
values (45140407, 'motorcycle', 'normal', 322498856);
insert into VEHICLES (vid, typeis, status, did)
values (45140408, 'motorcycle', 'not normal', 322498857);
insert into VEHICLES (vid, typeis, status, did)
values (45140409, 'motorcycle', 'normal', 322498858);
insert into VEHICLES (vid, typeis, status, did)
values (45140410, 'ambulance', 'normal', 322498859);
insert into VEHICLES (vid, typeis, status, did)
values (45140411, 'motorcycle', 'not normal', 322498860);
commit;
prompt 400 records committed...
insert into VEHICLES (vid, typeis, status, did)
values (45140412, 'helicopter', 'normal', 322498627);
insert into VEHICLES (vid, typeis, status, did)
values (45140413, 'ambulance', 'normal', 322498516);
insert into VEHICLES (vid, typeis, status, did)
values (45140414, 'motorcycle', 'normal', 322498487);
insert into VEHICLES (vid, typeis, status, did)
values (45140415, 'motorcycle', 'normal', 322498837);
insert into VEHICLES (vid, typeis, status, did)
values (45140416, 'motorcycle', 'normal', 322498603);
insert into VEHICLES (vid, typeis, status, did)
values (45140417, 'motorcycle', 'normal', 322498810);
insert into VEHICLES (vid, typeis, status, did)
values (45140418, 'ambulance', 'normal', 322498563);
insert into VEHICLES (vid, typeis, status, did)
values (45140419, 'helicopter', 'normal', 322498822);
insert into VEHICLES (vid, typeis, status, did)
values (45140420, 'helicopter', 'normal', 322498547);
insert into VEHICLES (vid, typeis, status, did)
values (45140421, 'motorcycle', 'normal', 322498766);
insert into VEHICLES (vid, typeis, status, did)
values (45140422, 'motorcycle', 'normal', 322498498);
insert into VEHICLES (vid, typeis, status, did)
values (45140423, 'motorcycle', 'normal', 322498598);
insert into VEHICLES (vid, typeis, status, did)
values (45140424, 'motorcycle', 'normal', 322498558);
insert into VEHICLES (vid, typeis, status, did)
values (45140425, 'motorcycle', 'normal', 322498555);
insert into VEHICLES (vid, typeis, status, did)
values (45140426, 'motorcycle', 'normal', 322498688);
insert into VEHICLES (vid, typeis, status, did)
values (45140427, 'ambulance', 'normal', 322498656);
insert into VEHICLES (vid, typeis, status, did)
values (45140428, 'motorcycle', 'normal', 322498740);
insert into VEHICLES (vid, typeis, status, did)
values (45140429, 'motorcycle', 'normal', 322498770);
insert into VEHICLES (vid, typeis, status, did)
values (45140430, 'motorcycle', 'normal', 322498821);
insert into VEHICLES (vid, typeis, status, did)
values (45140431, 'motorcycle', 'normal', 322498848);
insert into VEHICLES (vid, typeis, status, did)
values (45140432, 'helicopter', 'normal', 322498585);
insert into VEHICLES (vid, typeis, status, did)
values (45140433, 'motorcycle', 'normal', 322498512);
insert into VEHICLES (vid, typeis, status, did)
values (45140434, 'helicopter', 'normal', 322498827);
insert into VEHICLES (vid, typeis, status, did)
values (45140435, 'motorcycle', 'normal', 322498752);
insert into VEHICLES (vid, typeis, status, did)
values (45140436, 'ambulance', 'normal', 322498720);
insert into VEHICLES (vid, typeis, status, did)
values (45140437, 'ambulance', 'normal', 322498494);
insert into VEHICLES (vid, typeis, status, did)
values (45140438, 'helicopter', 'normal', 322498610);
insert into VEHICLES (vid, typeis, status, did)
values (45140439, 'ambulance', 'normal', 322498493);
insert into VEHICLES (vid, typeis, status, did)
values (45140440, 'ambulance', 'normal', 322498711);
insert into VEHICLES (vid, typeis, status, did)
values (45140441, 'ambulance', 'normal', 322498769);
insert into VEHICLES (vid, typeis, status, did)
values (45140442, 'ambulance', 'normal', 322498572);
insert into VEHICLES (vid, typeis, status, did)
values (45140443, 'ambulance', 'normal', 322498481);
insert into VEHICLES (vid, typeis, status, did)
values (45140444, 'helicopter', 'normal', 322498789);
insert into VEHICLES (vid, typeis, status, did)
values (45140445, 'motorcycle', 'normal', 322498791);
insert into VEHICLES (vid, typeis, status, did)
values (45140446, 'motorcycle', 'normal', 322498587);
insert into VEHICLES (vid, typeis, status, did)
values (45140447, 'ambulance', 'normal', 322498617);
insert into VEHICLES (vid, typeis, status, did)
values (45140448, 'motorcycle', 'normal', 322498600);
insert into VEHICLES (vid, typeis, status, did)
values (45140449, 'motorcycle', 'normal', 322498808);
insert into VEHICLES (vid, typeis, status, did)
values (45140450, 'helicopter', 'normal', 322498822);
insert into VEHICLES (vid, typeis, status, did)
values (45140451, 'helicopter', 'normal', 322498826);
insert into VEHICLES (vid, typeis, status, did)
values (45140452, 'ambulance', 'normal', 322498637);
insert into VEHICLES (vid, typeis, status, did)
values (45140453, 'ambulance', 'normal', 322498497);
insert into VEHICLES (vid, typeis, status, did)
values (45140454, 'ambulance', 'under repair', 322498676);
insert into VEHICLES (vid, typeis, status, did)
values (45140455, 'motorcycle', 'normal', 322498474);
insert into VEHICLES (vid, typeis, status, did)
values (45140456, 'motorcycle', 'normal', 322498466);
insert into VEHICLES (vid, typeis, status, did)
values (45140457, 'motorcycle', 'normal', 322498856);
insert into VEHICLES (vid, typeis, status, did)
values (45140458, 'helicopter', 'normal', 322498629);
insert into VEHICLES (vid, typeis, status, did)
values (45140459, 'motorcycle', 'normal', 322498730);
insert into VEHICLES (vid, typeis, status, did)
values (45140460, 'ambulance', 'normal', 322498779);
insert into VEHICLES (vid, typeis, status, did)
values (45140461, 'ambulance', 'normal', 322498639);
insert into VEHICLES (vid, typeis, status, did)
values (45140462, 'helicopter', 'normal', 322498666);
insert into VEHICLES (vid, typeis, status, did)
values (45140463, 'motorcycle', 'normal', 322498809);
insert into VEHICLES (vid, typeis, status, did)
values (45140464, 'motorcycle', 'normal', 322498820);
insert into VEHICLES (vid, typeis, status, did)
values (45140465, 'ambulance', 'normal', 322498763);
insert into VEHICLES (vid, typeis, status, did)
values (45140466, 'helicopter', 'normal', 322498674);
insert into VEHICLES (vid, typeis, status, did)
values (45140467, 'helicopter', 'normal', 322498787);
insert into VEHICLES (vid, typeis, status, did)
values (45140468, 'helicopter', 'normal', 322498800);
insert into VEHICLES (vid, typeis, status, did)
values (45140469, 'motorcycle', 'normal', 322498575);
insert into VEHICLES (vid, typeis, status, did)
values (45140470, 'motorcycle', 'normal', 322498690);
insert into VEHICLES (vid, typeis, status, did)
values (45140471, 'ambulance', 'normal', 322498502);
insert into VEHICLES (vid, typeis, status, did)
values (45140472, 'motorcycle', 'normal', 322498633);
insert into VEHICLES (vid, typeis, status, did)
values (45140473, 'helicopter', 'normal', 322498799);
insert into VEHICLES (vid, typeis, status, did)
values (45140474, 'ambulance', 'normal', 322498562);
insert into VEHICLES (vid, typeis, status, did)
values (45140475, 'ambulance', 'normal', 322498643);
insert into VEHICLES (vid, typeis, status, did)
values (45140476, 'ambulance', 'normal', 322498840);
insert into VEHICLES (vid, typeis, status, did)
values (45140477, 'helicopter', 'normal', 322498858);
insert into VEHICLES (vid, typeis, status, did)
values (45140478, 'ambulance', 'normal', 322498740);
insert into VEHICLES (vid, typeis, status, did)
values (45140479, 'helicopter', 'normal', 322498538);
insert into VEHICLES (vid, typeis, status, did)
values (45140480, 'helicopter', 'normal', 322498727);
insert into VEHICLES (vid, typeis, status, did)
values (45140481, 'helicopter', 'normal', 322498784);
insert into VEHICLES (vid, typeis, status, did)
values (45140482, 'ambulance', 'normal', 322498743);
insert into VEHICLES (vid, typeis, status, did)
values (45140483, 'ambulance', 'normal', 322498533);
insert into VEHICLES (vid, typeis, status, did)
values (45140484, 'ambulance', 'normal', 322498694);
insert into VEHICLES (vid, typeis, status, did)
values (45140485, 'ambulance', 'normal', 322498822);
insert into VEHICLES (vid, typeis, status, did)
values (45140486, 'motorcycle', 'normal', 322498803);
insert into VEHICLES (vid, typeis, status, did)
values (45140487, 'ambulance', 'normal', 322498500);
insert into VEHICLES (vid, typeis, status, did)
values (45140488, 'helicopter', 'normal', 322498791);
insert into VEHICLES (vid, typeis, status, did)
values (45140489, 'helicopter', 'normal', 322498734);
insert into VEHICLES (vid, typeis, status, did)
values (45140490, 'helicopter', 'normal', 322498665);
insert into VEHICLES (vid, typeis, status, did)
values (45140491, 'motorcycle', 'normal', 322498533);
insert into VEHICLES (vid, typeis, status, did)
values (45140492, 'ambulance', 'normal', 322498546);
insert into VEHICLES (vid, typeis, status, did)
values (45140493, 'ambulance', 'normal', 322498499);
insert into VEHICLES (vid, typeis, status, did)
values (45140494, 'motorcycle', 'normal', 322498817);
insert into VEHICLES (vid, typeis, status, did)
values (45140495, 'motorcycle', 'normal', 322498791);
insert into VEHICLES (vid, typeis, status, did)
values (45140496, 'motorcycle', 'normal', 322498825);
insert into VEHICLES (vid, typeis, status, did)
values (45140497, 'motorcycle', 'normal', 322498640);
insert into VEHICLES (vid, typeis, status, did)
values (45140498, 'helicopter', 'normal', 322498742);
insert into VEHICLES (vid, typeis, status, did)
values (45140499, 'helicopter', 'normal', 322498745);
insert into VEHICLES (vid, typeis, status, did)
values (45140500, 'motorcycle', 'normal', 322498517);
insert into VEHICLES (vid, typeis, status, did)
values (45140501, 'motorcycle', 'normal', 322498854);
insert into VEHICLES (vid, typeis, status, did)
values (45140502, 'motorcycle', 'normal', 322498860);
insert into VEHICLES (vid, typeis, status, did)
values (45140503, 'helicopter', 'normal', 322498577);
insert into VEHICLES (vid, typeis, status, did)
values (45140504, 'motorcycle', 'normal', 322498606);
insert into VEHICLES (vid, typeis, status, did)
values (45140505, 'motorcycle', 'normal', 322498571);
insert into VEHICLES (vid, typeis, status, did)
values (45140506, 'ambulance', 'normal', 322498554);
insert into VEHICLES (vid, typeis, status, did)
values (45140507, 'ambulance', 'normal', 322498802);
insert into VEHICLES (vid, typeis, status, did)
values (45140508, 'motorcycle', 'normal', 322498647);
insert into VEHICLES (vid, typeis, status, did)
values (45140509, 'ambulance', 'normal', 322498748);
insert into VEHICLES (vid, typeis, status, did)
values (45140510, 'ambulance', 'normal', 322498756);
insert into VEHICLES (vid, typeis, status, did)
values (45140511, 'helicopter', 'normal', 322498655);
commit;
prompt 500 records loaded
prompt Loading VEHICLE_EQUIP...
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10203, 45140065);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10210, 45140350);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10207, 45140148);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10075, 45140079);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (27, 10003, 45140410);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10088, 45140041);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10302, 45140088);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (10, 10153, 45140277);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10309, 45140394);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10393, 45140373);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10019, 45140133);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10314, 45140396);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10061, 45140120);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10163, 45140069);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10306, 45140281);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (14, 10056, 45140324);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (14, 10344, 45140094);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10058, 45140193);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10313, 45140098);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (20, 10137, 45140212);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10068, 45140184);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10043, 45140203);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10220, 45140131);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10004, 45140287);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (20, 10079, 45140378);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10274, 45140283);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10150, 45140347);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10364, 45140065);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10005, 45140403);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10184, 45140306);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10118, 45140115);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10039, 45140154);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10122, 45140211);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (13, 10119, 45140289);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (4, 10020, 45140376);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10254, 45140372);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10028, 45140186);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (25, 10323, 45140092);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10375, 45140323);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (4, 10047, 45140367);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10109, 45140081);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10232, 45140216);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10176, 45140225);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10173, 45140263);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (8, 10231, 45140139);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10311, 45140069);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10065, 45140129);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (8, 10223, 45140123);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10240, 45140400);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (10, 10333, 45140132);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10101, 45140263);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10054, 45140347);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10114, 45140269);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10167, 45140209);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10131, 45140282);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10150, 45140403);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10116, 45140121);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10396, 45140397);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10332, 45140182);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10101, 45140201);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10213, 45140028);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10161, 45140342);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10014, 45140217);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10116, 45140119);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10117, 45140391);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10242, 45140029);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10156, 45140037);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10105, 45140181);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10210, 45140163);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10107, 45140277);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (13, 10266, 45140204);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (6, 10246, 45140195);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10085, 45140021);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10357, 45140378);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (8, 10095, 45140091);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10199, 45140363);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10403, 45140408);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10306, 45140046);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10243, 45140310);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10259, 45140361);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (4, 10154, 45140383);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10325, 45140135);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (14, 10255, 45140299);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10224, 45140203);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10077, 45140194);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10082, 45140271);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10162, 45140191);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10258, 45140285);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10085, 45140136);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10100, 45140066);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (4, 10234, 45140210);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10133, 45140128);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10031, 45140381);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10385, 45140263);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (6, 10256, 45140109);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (8, 10137, 45140218);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10349, 45140169);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10104, 45140268);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (30, 10153, 45140096);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (4, 10211, 45140248);
commit;
prompt 100 records committed...
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10392, 45140020);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10366, 45140237);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (25, 10258, 45140372);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10018, 45140376);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10098, 45140377);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (26, 10131, 45140350);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (25, 10004, 45140107);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (10, 10321, 45140196);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10165, 45140136);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10030, 45140060);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10019, 45140402);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10114, 45140236);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10117, 45140259);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10294, 45140142);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (13, 10127, 45140248);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10175, 45140087);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (10, 10145, 45140143);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10086, 45140120);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10053, 45140228);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10003, 45140163);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10241, 45140137);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (10, 10392, 45140123);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10000, 45140385);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10241, 45140212);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10299, 45140074);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (25, 10211, 45140318);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10390, 45140397);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10155, 45140163);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10135, 45140209);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (8, 10096, 45140385);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10187, 45140272);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (6, 10053, 45140246);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10098, 45140245);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10166, 45140390);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10156, 45140320);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10048, 45140156);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10192, 45140217);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (20, 10386, 45140108);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10163, 45140407);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10375, 45140392);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10196, 45140336);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10127, 45140352);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10317, 45140239);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10147, 45140176);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10144, 45140146);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (4, 10155, 45140371);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10109, 45140107);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10348, 45140038);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10185, 45140305);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10232, 45140266);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10284, 45140014);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10074, 45140101);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10216, 45140348);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (4, 10114, 45140283);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10207, 45140019);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (25, 10113, 45140349);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10120, 45140323);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10160, 45140139);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10095, 45140342);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10230, 45140100);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10389, 45140288);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10260, 45140039);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10262, 45140241);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (14, 10026, 45140380);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10144, 45140131);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10345, 45140339);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10103, 45140401);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10017, 45140211);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10190, 45140317);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10195, 45140106);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (13, 10054, 45140080);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10100, 45140314);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (25, 10248, 45140227);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (4, 10388, 45140142);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10178, 45140311);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10319, 45140240);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10230, 45140073);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10280, 45140123);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10021, 45140231);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10081, 45140226);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (4, 10146, 45140078);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (13, 10326, 45140401);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10053, 45140029);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (20, 10155, 45140389);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (20, 10227, 45140296);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10386, 45140341);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10254, 45140180);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10146, 45140367);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10095, 45140151);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10305, 45140338);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10396, 45140265);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10024, 45140203);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (25, 10390, 45140083);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10290, 45140373);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10214, 45140033);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10226, 45140185);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10217, 45140178);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (4, 10283, 45140066);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10170, 45140222);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10221, 45140250);
commit;
prompt 200 records committed...
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10099, 45140359);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (25, 10101, 45140081);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (10, 10403, 45140372);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10354, 45140056);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10356, 45140036);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (20, 10159, 45140036);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10387, 45140165);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10194, 45140121);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10352, 45140371);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10293, 45140181);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10320, 45140128);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10030, 45140151);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10059, 45140063);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10334, 45140199);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10104, 45140409);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (25, 10141, 45140352);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10271, 45140015);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10163, 45140175);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10376, 45140091);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10242, 45140025);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10302, 45140387);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (8, 10272, 45140109);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (14, 10024, 45140339);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10012, 45140279);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (6, 10205, 45140382);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10344, 45140409);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10110, 45140039);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10052, 45140127);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (4, 10086, 45140091);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10327, 45140337);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10361, 45140247);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (10, 10355, 45140213);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10108, 45140130);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10096, 45140252);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10353, 45140285);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10282, 45140041);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10032, 45140195);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10356, 45140016);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (14, 10249, 45140404);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10151, 45140339);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10063, 45140081);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10277, 45140408);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10078, 45140065);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (8, 10152, 45140248);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10036, 45140069);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10376, 45140115);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10305, 45140147);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10133, 45140344);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10124, 45140048);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10275, 45140145);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10036, 45140334);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10208, 45140214);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10292, 45140066);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10045, 45140027);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10269, 45140196);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10273, 45140166);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10288, 45140277);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10230, 45140250);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (6, 10253, 45140201);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10221, 45140406);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10006, 45140382);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (25, 10173, 45140295);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10205, 45140197);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10321, 45140270);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10186, 45140324);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10030, 45140118);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10289, 45140179);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10149, 45140226);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10283, 45140142);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10233, 45140249);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10007, 45140288);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (8, 10170, 45140250);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10109, 45140148);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10371, 45140149);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (13, 10221, 45140265);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10106, 45140278);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (14, 10273, 45140312);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (13, 10330, 45140184);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (20, 10048, 45140290);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (6, 10038, 45140154);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10149, 45140241);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10196, 45140289);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10340, 45140045);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10158, 45140155);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10307, 45140030);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (6, 10372, 45140049);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10128, 45140122);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (10, 10084, 45140134);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10265, 45140367);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10217, 45140283);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10370, 45140021);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10344, 45140150);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10313, 45140369);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10079, 45140267);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (20, 10373, 45140247);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (10, 10232, 45140023);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10080, 45140141);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10009, 45140058);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (13, 10225, 45140167);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10124, 45140098);
commit;
prompt 300 records committed...
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10381, 45140323);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10215, 45140282);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10040, 45140131);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10237, 45140037);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (25, 10007, 45140224);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10370, 45140228);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10290, 45140106);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (20, 10063, 45140138);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10238, 45140213);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (13, 10228, 45140025);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10275, 45140343);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10375, 45140196);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10084, 45140147);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10060, 45140329);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10006, 45140116);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10113, 45140200);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (4, 10063, 45140127);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10344, 45140312);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10347, 45140263);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10344, 45140082);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10147, 45140356);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10228, 45140374);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (6, 10017, 45140155);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10141, 45140220);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10215, 45140178);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10056, 45140162);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10257, 45140230);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (28, 10003, 45140106);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10125, 45140088);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10399, 45140136);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10204, 45140121);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10281, 45140276);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10287, 45140188);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10277, 45140242);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10047, 45140106);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (14, 10347, 45140317);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10060, 45140267);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (13, 10124, 45140154);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (20, 10058, 45140124);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10300, 45140254);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (10, 10291, 45140400);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (6, 10263, 45140034);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (6, 10240, 45140266);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10255, 45140322);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10255, 45140226);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (10, 10262, 45140068);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10204, 45140396);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (18, 10403, 45140234);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10368, 45140012);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10214, 45140334);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10189, 45140217);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10341, 45140342);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10330, 45140256);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (19, 10243, 45140270);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10199, 45140017);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10246, 45140407);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10213, 45140338);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (13, 10273, 45140269);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10390, 45140036);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10162, 45140182);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (13, 10031, 45140378);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10210, 45140093);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10303, 45140067);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (25, 10196, 45140108);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (20, 10244, 45140194);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10350, 45140039);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10267, 45140240);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10094, 45140136);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10151, 45140141);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10346, 45140115);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (3, 10343, 45140410);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (15, 10396, 45140382);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10065, 45140305);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (5, 10379, 45140193);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10340, 45140077);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (14, 10208, 45140211);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (4, 10361, 45140244);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (6, 10243, 45140188);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10117, 45140092);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (24, 10053, 45140073);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (16, 10297, 45140344);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (10, 10197, 45140217);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (9, 10262, 45140240);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10180, 45140078);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10383, 45140384);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (22, 10298, 45140400);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10130, 45140176);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10189, 45140236);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (1, 10083, 45140187);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (17, 10251, 45140057);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (12, 10022, 45140409);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (23, 10233, 45140148);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (2, 10093, 45140130);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10324, 45140155);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (11, 10225, 45140190);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (21, 10158, 45140076);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (8, 10375, 45140206);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10322, 45140164);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (8, 10263, 45140018);
insert into VEHICLE_EQUIP (equipamount, eid, vid)
values (7, 10292, 45140174);
commit;
prompt 400 records loaded
prompt Loading VEHICLESREPAIRS...
insert into VEHICLESREPAIRS (rid, vid)
values (62010, 45140289);
insert into VEHICLESREPAIRS (rid, vid)
values (62011, 45140231);
insert into VEHICLESREPAIRS (rid, vid)
values (62012, 45140339);
insert into VEHICLESREPAIRS (rid, vid)
values (62013, 45140224);
insert into VEHICLESREPAIRS (rid, vid)
values (62014, 45140076);
insert into VEHICLESREPAIRS (rid, vid)
values (62015, 45140035);
insert into VEHICLESREPAIRS (rid, vid)
values (62016, 45140202);
insert into VEHICLESREPAIRS (rid, vid)
values (62017, 45140237);
insert into VEHICLESREPAIRS (rid, vid)
values (62018, 45140408);
insert into VEHICLESREPAIRS (rid, vid)
values (62019, 45140093);
insert into VEHICLESREPAIRS (rid, vid)
values (62020, 45140205);
insert into VEHICLESREPAIRS (rid, vid)
values (62021, 45140242);
insert into VEHICLESREPAIRS (rid, vid)
values (62022, 45140343);
insert into VEHICLESREPAIRS (rid, vid)
values (62023, 45140278);
insert into VEHICLESREPAIRS (rid, vid)
values (62024, 45140131);
insert into VEHICLESREPAIRS (rid, vid)
values (62025, 45140371);
insert into VEHICLESREPAIRS (rid, vid)
values (62026, 45140120);
insert into VEHICLESREPAIRS (rid, vid)
values (62027, 45140397);
insert into VEHICLESREPAIRS (rid, vid)
values (62028, 45140407);
insert into VEHICLESREPAIRS (rid, vid)
values (62029, 45140396);
insert into VEHICLESREPAIRS (rid, vid)
values (62030, 45140286);
insert into VEHICLESREPAIRS (rid, vid)
values (62031, 45140320);
insert into VEHICLESREPAIRS (rid, vid)
values (62032, 45140308);
insert into VEHICLESREPAIRS (rid, vid)
values (62033, 45140226);
insert into VEHICLESREPAIRS (rid, vid)
values (62034, 45140346);
insert into VEHICLESREPAIRS (rid, vid)
values (62035, 45140077);
insert into VEHICLESREPAIRS (rid, vid)
values (62036, 45140023);
insert into VEHICLESREPAIRS (rid, vid)
values (62037, 45140104);
insert into VEHICLESREPAIRS (rid, vid)
values (62038, 45140338);
insert into VEHICLESREPAIRS (rid, vid)
values (62039, 45140222);
insert into VEHICLESREPAIRS (rid, vid)
values (62040, 45140049);
insert into VEHICLESREPAIRS (rid, vid)
values (62041, 45140265);
insert into VEHICLESREPAIRS (rid, vid)
values (62042, 45140062);
insert into VEHICLESREPAIRS (rid, vid)
values (62043, 45140054);
insert into VEHICLESREPAIRS (rid, vid)
values (62044, 45140284);
insert into VEHICLESREPAIRS (rid, vid)
values (62045, 45140271);
insert into VEHICLESREPAIRS (rid, vid)
values (62046, 45140382);
insert into VEHICLESREPAIRS (rid, vid)
values (62047, 45140201);
insert into VEHICLESREPAIRS (rid, vid)
values (62048, 45140093);
insert into VEHICLESREPAIRS (rid, vid)
values (62049, 45140404);
insert into VEHICLESREPAIRS (rid, vid)
values (62050, 45140316);
insert into VEHICLESREPAIRS (rid, vid)
values (62051, 45140139);
insert into VEHICLESREPAIRS (rid, vid)
values (62052, 45140300);
insert into VEHICLESREPAIRS (rid, vid)
values (62053, 45140322);
insert into VEHICLESREPAIRS (rid, vid)
values (62054, 45140132);
insert into VEHICLESREPAIRS (rid, vid)
values (62055, 45140157);
insert into VEHICLESREPAIRS (rid, vid)
values (62056, 45140195);
insert into VEHICLESREPAIRS (rid, vid)
values (62057, 45140357);
insert into VEHICLESREPAIRS (rid, vid)
values (62058, 45140375);
insert into VEHICLESREPAIRS (rid, vid)
values (62059, 45140163);
insert into VEHICLESREPAIRS (rid, vid)
values (62060, 45140311);
insert into VEHICLESREPAIRS (rid, vid)
values (62061, 45140066);
insert into VEHICLESREPAIRS (rid, vid)
values (62062, 45140038);
insert into VEHICLESREPAIRS (rid, vid)
values (62063, 45140207);
insert into VEHICLESREPAIRS (rid, vid)
values (62064, 45140240);
insert into VEHICLESREPAIRS (rid, vid)
values (62065, 45140409);
insert into VEHICLESREPAIRS (rid, vid)
values (62066, 45140397);
insert into VEHICLESREPAIRS (rid, vid)
values (62067, 45140135);
insert into VEHICLESREPAIRS (rid, vid)
values (62068, 45140067);
insert into VEHICLESREPAIRS (rid, vid)
values (62069, 45140378);
insert into VEHICLESREPAIRS (rid, vid)
values (62070, 45140326);
insert into VEHICLESREPAIRS (rid, vid)
values (62071, 45140257);
insert into VEHICLESREPAIRS (rid, vid)
values (62072, 45140081);
insert into VEHICLESREPAIRS (rid, vid)
values (62073, 45140221);
insert into VEHICLESREPAIRS (rid, vid)
values (62074, 45140225);
insert into VEHICLESREPAIRS (rid, vid)
values (62075, 45140222);
insert into VEHICLESREPAIRS (rid, vid)
values (62076, 45140331);
insert into VEHICLESREPAIRS (rid, vid)
values (62077, 45140319);
insert into VEHICLESREPAIRS (rid, vid)
values (62078, 45140152);
insert into VEHICLESREPAIRS (rid, vid)
values (62079, 45140198);
insert into VEHICLESREPAIRS (rid, vid)
values (62080, 45140107);
insert into VEHICLESREPAIRS (rid, vid)
values (62081, 45140047);
insert into VEHICLESREPAIRS (rid, vid)
values (62082, 45140311);
insert into VEHICLESREPAIRS (rid, vid)
values (62083, 45140152);
insert into VEHICLESREPAIRS (rid, vid)
values (62084, 45140301);
insert into VEHICLESREPAIRS (rid, vid)
values (62085, 45140266);
insert into VEHICLESREPAIRS (rid, vid)
values (62086, 45140086);
insert into VEHICLESREPAIRS (rid, vid)
values (62087, 45140318);
insert into VEHICLESREPAIRS (rid, vid)
values (62088, 45140129);
insert into VEHICLESREPAIRS (rid, vid)
values (62089, 45140389);
insert into VEHICLESREPAIRS (rid, vid)
values (62090, 45140360);
insert into VEHICLESREPAIRS (rid, vid)
values (62091, 45140049);
insert into VEHICLESREPAIRS (rid, vid)
values (62092, 45140169);
insert into VEHICLESREPAIRS (rid, vid)
values (62093, 45140274);
insert into VEHICLESREPAIRS (rid, vid)
values (62094, 45140324);
insert into VEHICLESREPAIRS (rid, vid)
values (62095, 45140349);
insert into VEHICLESREPAIRS (rid, vid)
values (62096, 45140199);
insert into VEHICLESREPAIRS (rid, vid)
values (62097, 45140068);
insert into VEHICLESREPAIRS (rid, vid)
values (62098, 45140103);
insert into VEHICLESREPAIRS (rid, vid)
values (62099, 45140281);
insert into VEHICLESREPAIRS (rid, vid)
values (62100, 45140394);
insert into VEHICLESREPAIRS (rid, vid)
values (62101, 45140067);
insert into VEHICLESREPAIRS (rid, vid)
values (62102, 45140217);
insert into VEHICLESREPAIRS (rid, vid)
values (62103, 45140333);
insert into VEHICLESREPAIRS (rid, vid)
values (62104, 45140148);
insert into VEHICLESREPAIRS (rid, vid)
values (62105, 45140324);
insert into VEHICLESREPAIRS (rid, vid)
values (62106, 45140190);
insert into VEHICLESREPAIRS (rid, vid)
values (62107, 45140349);
insert into VEHICLESREPAIRS (rid, vid)
values (62108, 45140105);
insert into VEHICLESREPAIRS (rid, vid)
values (62109, 45140247);
commit;
prompt 100 records committed...
insert into VEHICLESREPAIRS (rid, vid)
values (62110, 45140333);
insert into VEHICLESREPAIRS (rid, vid)
values (62111, 45140116);
insert into VEHICLESREPAIRS (rid, vid)
values (62112, 45140248);
insert into VEHICLESREPAIRS (rid, vid)
values (62113, 45140141);
insert into VEHICLESREPAIRS (rid, vid)
values (62114, 45140014);
insert into VEHICLESREPAIRS (rid, vid)
values (62115, 45140389);
insert into VEHICLESREPAIRS (rid, vid)
values (62116, 45140230);
insert into VEHICLESREPAIRS (rid, vid)
values (62117, 45140328);
insert into VEHICLESREPAIRS (rid, vid)
values (62118, 45140238);
insert into VEHICLESREPAIRS (rid, vid)
values (62119, 45140266);
insert into VEHICLESREPAIRS (rid, vid)
values (62120, 45140208);
insert into VEHICLESREPAIRS (rid, vid)
values (62121, 45140395);
insert into VEHICLESREPAIRS (rid, vid)
values (62122, 45140054);
insert into VEHICLESREPAIRS (rid, vid)
values (62123, 45140098);
insert into VEHICLESREPAIRS (rid, vid)
values (62124, 45140148);
insert into VEHICLESREPAIRS (rid, vid)
values (62125, 45140404);
insert into VEHICLESREPAIRS (rid, vid)
values (62126, 45140407);
insert into VEHICLESREPAIRS (rid, vid)
values (62127, 45140016);
insert into VEHICLESREPAIRS (rid, vid)
values (62128, 45140082);
insert into VEHICLESREPAIRS (rid, vid)
values (62129, 45140029);
insert into VEHICLESREPAIRS (rid, vid)
values (62130, 45140352);
insert into VEHICLESREPAIRS (rid, vid)
values (62131, 45140297);
insert into VEHICLESREPAIRS (rid, vid)
values (62132, 45140264);
insert into VEHICLESREPAIRS (rid, vid)
values (62133, 45140031);
insert into VEHICLESREPAIRS (rid, vid)
values (62134, 45140257);
insert into VEHICLESREPAIRS (rid, vid)
values (62135, 45140231);
insert into VEHICLESREPAIRS (rid, vid)
values (62136, 45140315);
insert into VEHICLESREPAIRS (rid, vid)
values (62137, 45140253);
insert into VEHICLESREPAIRS (rid, vid)
values (62138, 45140303);
insert into VEHICLESREPAIRS (rid, vid)
values (62139, 45140308);
insert into VEHICLESREPAIRS (rid, vid)
values (62140, 45140114);
insert into VEHICLESREPAIRS (rid, vid)
values (62141, 45140340);
insert into VEHICLESREPAIRS (rid, vid)
values (62142, 45140304);
insert into VEHICLESREPAIRS (rid, vid)
values (62143, 45140202);
insert into VEHICLESREPAIRS (rid, vid)
values (62144, 45140104);
insert into VEHICLESREPAIRS (rid, vid)
values (62145, 45140365);
insert into VEHICLESREPAIRS (rid, vid)
values (62146, 45140176);
insert into VEHICLESREPAIRS (rid, vid)
values (62147, 45140358);
insert into VEHICLESREPAIRS (rid, vid)
values (62148, 45140390);
insert into VEHICLESREPAIRS (rid, vid)
values (62149, 45140173);
insert into VEHICLESREPAIRS (rid, vid)
values (62150, 45140049);
insert into VEHICLESREPAIRS (rid, vid)
values (62151, 45140263);
insert into VEHICLESREPAIRS (rid, vid)
values (62152, 45140088);
insert into VEHICLESREPAIRS (rid, vid)
values (62153, 45140405);
insert into VEHICLESREPAIRS (rid, vid)
values (62154, 45140367);
insert into VEHICLESREPAIRS (rid, vid)
values (62155, 45140210);
insert into VEHICLESREPAIRS (rid, vid)
values (62156, 45140096);
insert into VEHICLESREPAIRS (rid, vid)
values (62157, 45140246);
insert into VEHICLESREPAIRS (rid, vid)
values (62158, 45140383);
insert into VEHICLESREPAIRS (rid, vid)
values (62159, 45140235);
insert into VEHICLESREPAIRS (rid, vid)
values (62160, 45140165);
insert into VEHICLESREPAIRS (rid, vid)
values (62161, 45140226);
insert into VEHICLESREPAIRS (rid, vid)
values (62162, 45140362);
insert into VEHICLESREPAIRS (rid, vid)
values (62163, 45140023);
insert into VEHICLESREPAIRS (rid, vid)
values (62164, 45140021);
insert into VEHICLESREPAIRS (rid, vid)
values (62165, 45140136);
insert into VEHICLESREPAIRS (rid, vid)
values (62166, 45140125);
insert into VEHICLESREPAIRS (rid, vid)
values (62167, 45140093);
insert into VEHICLESREPAIRS (rid, vid)
values (62168, 45140030);
insert into VEHICLESREPAIRS (rid, vid)
values (62169, 45140192);
insert into VEHICLESREPAIRS (rid, vid)
values (62170, 45140238);
insert into VEHICLESREPAIRS (rid, vid)
values (62171, 45140226);
insert into VEHICLESREPAIRS (rid, vid)
values (62172, 45140145);
insert into VEHICLESREPAIRS (rid, vid)
values (62173, 45140091);
insert into VEHICLESREPAIRS (rid, vid)
values (62174, 45140277);
insert into VEHICLESREPAIRS (rid, vid)
values (62175, 45140060);
insert into VEHICLESREPAIRS (rid, vid)
values (62176, 45140040);
insert into VEHICLESREPAIRS (rid, vid)
values (62177, 45140306);
insert into VEHICLESREPAIRS (rid, vid)
values (62178, 45140282);
insert into VEHICLESREPAIRS (rid, vid)
values (62179, 45140026);
insert into VEHICLESREPAIRS (rid, vid)
values (62180, 45140164);
insert into VEHICLESREPAIRS (rid, vid)
values (62181, 45140067);
insert into VEHICLESREPAIRS (rid, vid)
values (62182, 45140012);
insert into VEHICLESREPAIRS (rid, vid)
values (62183, 45140125);
insert into VEHICLESREPAIRS (rid, vid)
values (62184, 45140407);
insert into VEHICLESREPAIRS (rid, vid)
values (62185, 45140159);
insert into VEHICLESREPAIRS (rid, vid)
values (62186, 45140339);
insert into VEHICLESREPAIRS (rid, vid)
values (62187, 45140141);
insert into VEHICLESREPAIRS (rid, vid)
values (62188, 45140342);
insert into VEHICLESREPAIRS (rid, vid)
values (62189, 45140393);
insert into VEHICLESREPAIRS (rid, vid)
values (62190, 45140376);
insert into VEHICLESREPAIRS (rid, vid)
values (62191, 45140185);
insert into VEHICLESREPAIRS (rid, vid)
values (62192, 45140305);
insert into VEHICLESREPAIRS (rid, vid)
values (62193, 45140098);
insert into VEHICLESREPAIRS (rid, vid)
values (62194, 45140080);
insert into VEHICLESREPAIRS (rid, vid)
values (62195, 45140153);
insert into VEHICLESREPAIRS (rid, vid)
values (62196, 45140290);
insert into VEHICLESREPAIRS (rid, vid)
values (62197, 45140052);
insert into VEHICLESREPAIRS (rid, vid)
values (62198, 45140128);
insert into VEHICLESREPAIRS (rid, vid)
values (62199, 45140012);
insert into VEHICLESREPAIRS (rid, vid)
values (62200, 45140120);
insert into VEHICLESREPAIRS (rid, vid)
values (62201, 45140033);
insert into VEHICLESREPAIRS (rid, vid)
values (62202, 45140202);
insert into VEHICLESREPAIRS (rid, vid)
values (62203, 45140086);
insert into VEHICLESREPAIRS (rid, vid)
values (62204, 45140070);
insert into VEHICLESREPAIRS (rid, vid)
values (62205, 45140198);
insert into VEHICLESREPAIRS (rid, vid)
values (62206, 45140094);
insert into VEHICLESREPAIRS (rid, vid)
values (62207, 45140249);
insert into VEHICLESREPAIRS (rid, vid)
values (62208, 45140407);
insert into VEHICLESREPAIRS (rid, vid)
values (62209, 45140258);
commit;
prompt 200 records committed...
insert into VEHICLESREPAIRS (rid, vid)
values (62210, 45140146);
insert into VEHICLESREPAIRS (rid, vid)
values (62211, 45140217);
insert into VEHICLESREPAIRS (rid, vid)
values (62212, 45140017);
insert into VEHICLESREPAIRS (rid, vid)
values (62213, 45140088);
insert into VEHICLESREPAIRS (rid, vid)
values (62214, 45140053);
insert into VEHICLESREPAIRS (rid, vid)
values (62215, 45140027);
insert into VEHICLESREPAIRS (rid, vid)
values (62216, 45140383);
insert into VEHICLESREPAIRS (rid, vid)
values (62217, 45140300);
insert into VEHICLESREPAIRS (rid, vid)
values (62218, 45140343);
insert into VEHICLESREPAIRS (rid, vid)
values (62219, 45140304);
insert into VEHICLESREPAIRS (rid, vid)
values (62220, 45140095);
insert into VEHICLESREPAIRS (rid, vid)
values (62221, 45140248);
insert into VEHICLESREPAIRS (rid, vid)
values (62222, 45140146);
insert into VEHICLESREPAIRS (rid, vid)
values (62223, 45140405);
insert into VEHICLESREPAIRS (rid, vid)
values (62224, 45140343);
insert into VEHICLESREPAIRS (rid, vid)
values (62225, 45140191);
insert into VEHICLESREPAIRS (rid, vid)
values (62226, 45140188);
insert into VEHICLESREPAIRS (rid, vid)
values (62227, 45140238);
insert into VEHICLESREPAIRS (rid, vid)
values (62228, 45140376);
insert into VEHICLESREPAIRS (rid, vid)
values (62229, 45140059);
insert into VEHICLESREPAIRS (rid, vid)
values (62230, 45140408);
insert into VEHICLESREPAIRS (rid, vid)
values (62231, 45140041);
insert into VEHICLESREPAIRS (rid, vid)
values (62232, 45140396);
insert into VEHICLESREPAIRS (rid, vid)
values (62233, 45140174);
insert into VEHICLESREPAIRS (rid, vid)
values (62234, 45140134);
insert into VEHICLESREPAIRS (rid, vid)
values (62235, 45140129);
insert into VEHICLESREPAIRS (rid, vid)
values (62236, 45140238);
insert into VEHICLESREPAIRS (rid, vid)
values (62237, 45140165);
insert into VEHICLESREPAIRS (rid, vid)
values (62238, 45140027);
insert into VEHICLESREPAIRS (rid, vid)
values (62239, 45140286);
insert into VEHICLESREPAIRS (rid, vid)
values (62240, 45140333);
insert into VEHICLESREPAIRS (rid, vid)
values (62241, 45140019);
insert into VEHICLESREPAIRS (rid, vid)
values (62242, 45140313);
insert into VEHICLESREPAIRS (rid, vid)
values (62243, 45140210);
insert into VEHICLESREPAIRS (rid, vid)
values (62244, 45140295);
insert into VEHICLESREPAIRS (rid, vid)
values (62245, 45140114);
insert into VEHICLESREPAIRS (rid, vid)
values (62246, 45140328);
insert into VEHICLESREPAIRS (rid, vid)
values (62247, 45140098);
insert into VEHICLESREPAIRS (rid, vid)
values (62248, 45140218);
insert into VEHICLESREPAIRS (rid, vid)
values (62249, 45140379);
insert into VEHICLESREPAIRS (rid, vid)
values (62250, 45140083);
insert into VEHICLESREPAIRS (rid, vid)
values (62251, 45140165);
insert into VEHICLESREPAIRS (rid, vid)
values (62252, 45140248);
insert into VEHICLESREPAIRS (rid, vid)
values (62253, 45140019);
insert into VEHICLESREPAIRS (rid, vid)
values (62254, 45140281);
insert into VEHICLESREPAIRS (rid, vid)
values (62255, 45140389);
insert into VEHICLESREPAIRS (rid, vid)
values (62256, 45140098);
insert into VEHICLESREPAIRS (rid, vid)
values (62257, 45140159);
insert into VEHICLESREPAIRS (rid, vid)
values (62258, 45140097);
insert into VEHICLESREPAIRS (rid, vid)
values (62259, 45140285);
insert into VEHICLESREPAIRS (rid, vid)
values (62260, 45140266);
insert into VEHICLESREPAIRS (rid, vid)
values (62261, 45140240);
insert into VEHICLESREPAIRS (rid, vid)
values (62262, 45140137);
insert into VEHICLESREPAIRS (rid, vid)
values (62263, 45140189);
insert into VEHICLESREPAIRS (rid, vid)
values (62264, 45140047);
insert into VEHICLESREPAIRS (rid, vid)
values (62265, 45140318);
insert into VEHICLESREPAIRS (rid, vid)
values (62266, 45140103);
insert into VEHICLESREPAIRS (rid, vid)
values (62267, 45140052);
insert into VEHICLESREPAIRS (rid, vid)
values (62268, 45140282);
insert into VEHICLESREPAIRS (rid, vid)
values (62269, 45140304);
insert into VEHICLESREPAIRS (rid, vid)
values (62270, 45140381);
insert into VEHICLESREPAIRS (rid, vid)
values (62271, 45140243);
insert into VEHICLESREPAIRS (rid, vid)
values (62272, 45140130);
insert into VEHICLESREPAIRS (rid, vid)
values (62273, 45140095);
insert into VEHICLESREPAIRS (rid, vid)
values (62274, 45140062);
insert into VEHICLESREPAIRS (rid, vid)
values (62275, 45140141);
insert into VEHICLESREPAIRS (rid, vid)
values (62276, 45140026);
insert into VEHICLESREPAIRS (rid, vid)
values (62277, 45140235);
insert into VEHICLESREPAIRS (rid, vid)
values (62278, 45140023);
insert into VEHICLESREPAIRS (rid, vid)
values (62279, 45140026);
insert into VEHICLESREPAIRS (rid, vid)
values (62280, 45140292);
insert into VEHICLESREPAIRS (rid, vid)
values (62281, 45140053);
insert into VEHICLESREPAIRS (rid, vid)
values (62282, 45140193);
insert into VEHICLESREPAIRS (rid, vid)
values (62283, 45140250);
insert into VEHICLESREPAIRS (rid, vid)
values (62284, 45140174);
insert into VEHICLESREPAIRS (rid, vid)
values (62285, 45140319);
insert into VEHICLESREPAIRS (rid, vid)
values (62286, 45140201);
insert into VEHICLESREPAIRS (rid, vid)
values (62287, 45140188);
insert into VEHICLESREPAIRS (rid, vid)
values (62288, 45140172);
insert into VEHICLESREPAIRS (rid, vid)
values (62289, 45140359);
insert into VEHICLESREPAIRS (rid, vid)
values (62290, 45140349);
insert into VEHICLESREPAIRS (rid, vid)
values (62291, 45140359);
insert into VEHICLESREPAIRS (rid, vid)
values (62292, 45140228);
insert into VEHICLESREPAIRS (rid, vid)
values (62293, 45140087);
insert into VEHICLESREPAIRS (rid, vid)
values (62294, 45140316);
insert into VEHICLESREPAIRS (rid, vid)
values (62295, 45140019);
insert into VEHICLESREPAIRS (rid, vid)
values (62296, 45140046);
insert into VEHICLESREPAIRS (rid, vid)
values (62297, 45140277);
insert into VEHICLESREPAIRS (rid, vid)
values (62298, 45140309);
insert into VEHICLESREPAIRS (rid, vid)
values (62299, 45140207);
insert into VEHICLESREPAIRS (rid, vid)
values (62300, 45140315);
insert into VEHICLESREPAIRS (rid, vid)
values (62301, 45140132);
insert into VEHICLESREPAIRS (rid, vid)
values (62302, 45140292);
insert into VEHICLESREPAIRS (rid, vid)
values (62303, 45140348);
insert into VEHICLESREPAIRS (rid, vid)
values (62304, 45140090);
insert into VEHICLESREPAIRS (rid, vid)
values (62305, 45140098);
insert into VEHICLESREPAIRS (rid, vid)
values (62306, 45140199);
insert into VEHICLESREPAIRS (rid, vid)
values (62307, 45140200);
insert into VEHICLESREPAIRS (rid, vid)
values (62308, 45140118);
insert into VEHICLESREPAIRS (rid, vid)
values (62309, 45140344);
commit;
prompt 300 records committed...
insert into VEHICLESREPAIRS (rid, vid)
values (62310, 45140158);
insert into VEHICLESREPAIRS (rid, vid)
values (62311, 45140252);
insert into VEHICLESREPAIRS (rid, vid)
values (62312, 45140367);
insert into VEHICLESREPAIRS (rid, vid)
values (62313, 45140287);
insert into VEHICLESREPAIRS (rid, vid)
values (62314, 45140240);
insert into VEHICLESREPAIRS (rid, vid)
values (62315, 45140140);
insert into VEHICLESREPAIRS (rid, vid)
values (62316, 45140126);
insert into VEHICLESREPAIRS (rid, vid)
values (62317, 45140168);
insert into VEHICLESREPAIRS (rid, vid)
values (62318, 45140157);
insert into VEHICLESREPAIRS (rid, vid)
values (62319, 45140407);
insert into VEHICLESREPAIRS (rid, vid)
values (62320, 45140348);
insert into VEHICLESREPAIRS (rid, vid)
values (62321, 45140256);
insert into VEHICLESREPAIRS (rid, vid)
values (62322, 45140219);
insert into VEHICLESREPAIRS (rid, vid)
values (62323, 45140179);
insert into VEHICLESREPAIRS (rid, vid)
values (62324, 45140411);
insert into VEHICLESREPAIRS (rid, vid)
values (62325, 45140095);
insert into VEHICLESREPAIRS (rid, vid)
values (62326, 45140181);
insert into VEHICLESREPAIRS (rid, vid)
values (62327, 45140253);
insert into VEHICLESREPAIRS (rid, vid)
values (62328, 45140347);
insert into VEHICLESREPAIRS (rid, vid)
values (62329, 45140365);
insert into VEHICLESREPAIRS (rid, vid)
values (62330, 45140284);
insert into VEHICLESREPAIRS (rid, vid)
values (62331, 45140403);
insert into VEHICLESREPAIRS (rid, vid)
values (62332, 45140132);
insert into VEHICLESREPAIRS (rid, vid)
values (62333, 45140373);
insert into VEHICLESREPAIRS (rid, vid)
values (62334, 45140127);
insert into VEHICLESREPAIRS (rid, vid)
values (62335, 45140185);
insert into VEHICLESREPAIRS (rid, vid)
values (62336, 45140086);
insert into VEHICLESREPAIRS (rid, vid)
values (62337, 45140345);
insert into VEHICLESREPAIRS (rid, vid)
values (62338, 45140265);
insert into VEHICLESREPAIRS (rid, vid)
values (62339, 45140237);
insert into VEHICLESREPAIRS (rid, vid)
values (62340, 45140162);
insert into VEHICLESREPAIRS (rid, vid)
values (62341, 45140141);
insert into VEHICLESREPAIRS (rid, vid)
values (62342, 45140382);
insert into VEHICLESREPAIRS (rid, vid)
values (62343, 45140375);
insert into VEHICLESREPAIRS (rid, vid)
values (62344, 45140389);
insert into VEHICLESREPAIRS (rid, vid)
values (62345, 45140148);
insert into VEHICLESREPAIRS (rid, vid)
values (62346, 45140322);
insert into VEHICLESREPAIRS (rid, vid)
values (62347, 45140071);
insert into VEHICLESREPAIRS (rid, vid)
values (62348, 45140040);
insert into VEHICLESREPAIRS (rid, vid)
values (62349, 45140194);
insert into VEHICLESREPAIRS (rid, vid)
values (62350, 45140032);
insert into VEHICLESREPAIRS (rid, vid)
values (62351, 45140211);
insert into VEHICLESREPAIRS (rid, vid)
values (62352, 45140391);
insert into VEHICLESREPAIRS (rid, vid)
values (62353, 45140021);
insert into VEHICLESREPAIRS (rid, vid)
values (62354, 45140112);
insert into VEHICLESREPAIRS (rid, vid)
values (62355, 45140321);
insert into VEHICLESREPAIRS (rid, vid)
values (62356, 45140046);
insert into VEHICLESREPAIRS (rid, vid)
values (62357, 45140169);
insert into VEHICLESREPAIRS (rid, vid)
values (62358, 45140396);
insert into VEHICLESREPAIRS (rid, vid)
values (62359, 45140367);
insert into VEHICLESREPAIRS (rid, vid)
values (62360, 45140283);
insert into VEHICLESREPAIRS (rid, vid)
values (62361, 45140205);
insert into VEHICLESREPAIRS (rid, vid)
values (62362, 45140091);
insert into VEHICLESREPAIRS (rid, vid)
values (62363, 45140306);
insert into VEHICLESREPAIRS (rid, vid)
values (62364, 45140409);
insert into VEHICLESREPAIRS (rid, vid)
values (62365, 45140155);
insert into VEHICLESREPAIRS (rid, vid)
values (62366, 45140283);
insert into VEHICLESREPAIRS (rid, vid)
values (62367, 45140297);
insert into VEHICLESREPAIRS (rid, vid)
values (62368, 45140374);
insert into VEHICLESREPAIRS (rid, vid)
values (62369, 45140260);
insert into VEHICLESREPAIRS (rid, vid)
values (62370, 45140131);
insert into VEHICLESREPAIRS (rid, vid)
values (62371, 45140155);
insert into VEHICLESREPAIRS (rid, vid)
values (62372, 45140029);
insert into VEHICLESREPAIRS (rid, vid)
values (62373, 45140331);
insert into VEHICLESREPAIRS (rid, vid)
values (62374, 45140175);
insert into VEHICLESREPAIRS (rid, vid)
values (62375, 45140350);
insert into VEHICLESREPAIRS (rid, vid)
values (62376, 45140081);
insert into VEHICLESREPAIRS (rid, vid)
values (62377, 45140013);
insert into VEHICLESREPAIRS (rid, vid)
values (62378, 45140266);
insert into VEHICLESREPAIRS (rid, vid)
values (62379, 45140137);
insert into VEHICLESREPAIRS (rid, vid)
values (62380, 45140331);
insert into VEHICLESREPAIRS (rid, vid)
values (62381, 45140229);
insert into VEHICLESREPAIRS (rid, vid)
values (62382, 45140140);
insert into VEHICLESREPAIRS (rid, vid)
values (62383, 45140117);
insert into VEHICLESREPAIRS (rid, vid)
values (62384, 45140046);
insert into VEHICLESREPAIRS (rid, vid)
values (62385, 45140132);
insert into VEHICLESREPAIRS (rid, vid)
values (62386, 45140364);
insert into VEHICLESREPAIRS (rid, vid)
values (62387, 45140217);
insert into VEHICLESREPAIRS (rid, vid)
values (62388, 45140245);
insert into VEHICLESREPAIRS (rid, vid)
values (62389, 45140017);
insert into VEHICLESREPAIRS (rid, vid)
values (62390, 45140259);
insert into VEHICLESREPAIRS (rid, vid)
values (62391, 45140194);
insert into VEHICLESREPAIRS (rid, vid)
values (62392, 45140171);
insert into VEHICLESREPAIRS (rid, vid)
values (62393, 45140327);
insert into VEHICLESREPAIRS (rid, vid)
values (62394, 45140325);
insert into VEHICLESREPAIRS (rid, vid)
values (62395, 45140236);
insert into VEHICLESREPAIRS (rid, vid)
values (62396, 45140303);
insert into VEHICLESREPAIRS (rid, vid)
values (62397, 45140214);
insert into VEHICLESREPAIRS (rid, vid)
values (62398, 45140391);
insert into VEHICLESREPAIRS (rid, vid)
values (62399, 45140179);
insert into VEHICLESREPAIRS (rid, vid)
values (62400, 45140390);
insert into VEHICLESREPAIRS (rid, vid)
values (62401, 45140375);
insert into VEHICLESREPAIRS (rid, vid)
values (62402, 45140399);
insert into VEHICLESREPAIRS (rid, vid)
values (62403, 45140315);
insert into VEHICLESREPAIRS (rid, vid)
values (62404, 45140271);
insert into VEHICLESREPAIRS (rid, vid)
values (62405, 45140228);
insert into VEHICLESREPAIRS (rid, vid)
values (62406, 45140052);
insert into VEHICLESREPAIRS (rid, vid)
values (62407, 45140089);
insert into VEHICLESREPAIRS (rid, vid)
values (62408, 45140151);
insert into VEHICLESREPAIRS (rid, vid)
values (62409, 45140363);
commit;
prompt 400 records committed...
insert into VEHICLESREPAIRS (rid, vid)
values (62710, 45140322);
insert into VEHICLESREPAIRS (rid, vid)
values (62452, 45140323);
insert into VEHICLESREPAIRS (rid, vid)
values (62424, 45140051);
insert into VEHICLESREPAIRS (rid, vid)
values (62792, 45140089);
insert into VEHICLESREPAIRS (rid, vid)
values (62780, 45140335);
insert into VEHICLESREPAIRS (rid, vid)
values (62751, 45140234);
insert into VEHICLESREPAIRS (rid, vid)
values (62810, 45140318);
insert into VEHICLESREPAIRS (rid, vid)
values (62811, 45140310);
insert into VEHICLESREPAIRS (rid, vid)
values (62812, 45140307);
insert into VEHICLESREPAIRS (rid, vid)
values (62813, 45140313);
insert into VEHICLESREPAIRS (rid, vid)
values (62814, 45140317);
insert into VEHICLESREPAIRS (rid, vid)
values (62815, 45140318);
insert into VEHICLESREPAIRS (rid, vid)
values (62816, 45140300);
insert into VEHICLESREPAIRS (rid, vid)
values (62817, 45140309);
insert into VEHICLESREPAIRS (rid, vid)
values (62818, 45140301);
insert into VEHICLESREPAIRS (rid, vid)
values (62819, 45140315);
insert into VEHICLESREPAIRS (rid, vid)
values (62820, 45140306);
insert into VEHICLESREPAIRS (rid, vid)
values (62821, 45140317);
insert into VEHICLESREPAIRS (rid, vid)
values (62822, 45140313);
insert into VEHICLESREPAIRS (rid, vid)
values (62823, 45140314);
insert into VEHICLESREPAIRS (rid, vid)
values (62824, 45140301);
insert into VEHICLESREPAIRS (rid, vid)
values (62825, 45140307);
insert into VEHICLESREPAIRS (rid, vid)
values (62826, 45140317);
insert into VEHICLESREPAIRS (rid, vid)
values (62827, 45140301);
insert into VEHICLESREPAIRS (rid, vid)
values (62828, 45140305);
insert into VEHICLESREPAIRS (rid, vid)
values (62829, 45140309);
insert into VEHICLESREPAIRS (rid, vid)
values (62830, 45140312);
insert into VEHICLESREPAIRS (rid, vid)
values (62831, 45140307);
insert into VEHICLESREPAIRS (rid, vid)
values (62832, 45140315);
insert into VEHICLESREPAIRS (rid, vid)
values (62833, 45140317);
insert into VEHICLESREPAIRS (rid, vid)
values (62834, 45140307);
insert into VEHICLESREPAIRS (rid, vid)
values (62835, 45140308);
insert into VEHICLESREPAIRS (rid, vid)
values (62836, 45140302);
insert into VEHICLESREPAIRS (rid, vid)
values (62837, 45140301);
insert into VEHICLESREPAIRS (rid, vid)
values (62838, 45140320);
insert into VEHICLESREPAIRS (rid, vid)
values (62839, 45140301);
insert into VEHICLESREPAIRS (rid, vid)
values (62840, 45140307);
insert into VEHICLESREPAIRS (rid, vid)
values (62841, 45140308);
insert into VEHICLESREPAIRS (rid, vid)
values (62842, 45140303);
insert into VEHICLESREPAIRS (rid, vid)
values (62843, 45140320);
insert into VEHICLESREPAIRS (rid, vid)
values (62844, 45140310);
insert into VEHICLESREPAIRS (rid, vid)
values (62845, 45140317);
insert into VEHICLESREPAIRS (rid, vid)
values (62846, 45140316);
insert into VEHICLESREPAIRS (rid, vid)
values (62847, 45140307);
insert into VEHICLESREPAIRS (rid, vid)
values (62848, 45140317);
insert into VEHICLESREPAIRS (rid, vid)
values (62849, 45140320);
insert into VEHICLESREPAIRS (rid, vid)
values (62850, 45140316);
insert into VEHICLESREPAIRS (rid, vid)
values (62851, 45140316);
insert into VEHICLESREPAIRS (rid, vid)
values (62852, 45140308);
insert into VEHICLESREPAIRS (rid, vid)
values (62853, 45140320);
insert into VEHICLESREPAIRS (rid, vid)
values (62854, 45140312);
insert into VEHICLESREPAIRS (rid, vid)
values (62855, 45140307);
insert into VEHICLESREPAIRS (rid, vid)
values (62856, 45140316);
insert into VEHICLESREPAIRS (rid, vid)
values (62857, 45140303);
insert into VEHICLESREPAIRS (rid, vid)
values (62858, 45140307);
insert into VEHICLESREPAIRS (rid, vid)
values (62859, 45140309);
insert into VEHICLESREPAIRS (rid, vid)
values (62860, 45140301);
insert into VEHICLESREPAIRS (rid, vid)
values (62861, 45140314);
insert into VEHICLESREPAIRS (rid, vid)
values (62862, 45140301);
insert into VEHICLESREPAIRS (rid, vid)
values (62863, 45140312);
insert into VEHICLESREPAIRS (rid, vid)
values (62864, 45140316);
insert into VEHICLESREPAIRS (rid, vid)
values (62865, 45140315);
insert into VEHICLESREPAIRS (rid, vid)
values (62866, 45140319);
insert into VEHICLESREPAIRS (rid, vid)
values (62867, 45140306);
insert into VEHICLESREPAIRS (rid, vid)
values (62868, 45140315);
insert into VEHICLESREPAIRS (rid, vid)
values (62869, 45140303);
insert into VEHICLESREPAIRS (rid, vid)
values (62680, 45140454);
insert into VEHICLESREPAIRS (rid, vid)
values (62722, 45140175);
commit;
prompt 468 records loaded
prompt Enabling foreign key constraints for ORDERS...
alter table ORDERS enable constraint FK_ORDERS_SUPPLIERS;
prompt Enabling foreign key constraints for EQUIP_ORDER...
alter table EQUIP_ORDER enable constraint SYS_C007899;
alter table EQUIP_ORDER enable constraint SYS_C007900;
prompt Enabling foreign key constraints for EQUIPREPAIRS...
alter table EQUIPREPAIRS enable constraint SYS_C007883;
alter table EQUIPREPAIRS enable constraint SYS_C007884;
prompt Enabling foreign key constraints for VEHICLES...
alter table VEHICLES enable constraint SYS_C007907;
prompt Enabling foreign key constraints for VEHICLE_EQUIP...
alter table VEHICLE_EQUIP enable constraint FK_VEHICLE_EQUIP_VEHICLES;
alter table VEHICLE_EQUIP enable constraint SYS_C007920;
prompt Enabling foreign key constraints for VEHICLESREPAIRS...
alter table VEHICLESREPAIRS enable constraint FK_VEHICLES_REPAIRS_VEHICLES;
alter table VEHICLESREPAIRS enable constraint SYS_C007914;
prompt Enabling triggers for DONORS...
alter table DONORS enable all triggers;
prompt Enabling triggers for EQUIPMENT...
alter table EQUIPMENT enable all triggers;
prompt Enabling triggers for SUPPLIERS...
alter table SUPPLIERS enable all triggers;
prompt Enabling triggers for ORDERS...
alter table ORDERS enable all triggers;
prompt Enabling triggers for EQUIP_ORDER...
alter table EQUIP_ORDER enable all triggers;
prompt Enabling triggers for REPAIRS...
alter table REPAIRS enable all triggers;
prompt Enabling triggers for EQUIPREPAIRS...
alter table EQUIPREPAIRS enable all triggers;
prompt Enabling triggers for VEHICLES...
alter table VEHICLES enable all triggers;
prompt Enabling triggers for VEHICLE_EQUIP...
alter table VEHICLE_EQUIP enable all triggers;
prompt Enabling triggers for VEHICLESREPAIRS...
alter table VEHICLESREPAIRS enable all triggers;
set feedback on
set define on
prompt Done.
