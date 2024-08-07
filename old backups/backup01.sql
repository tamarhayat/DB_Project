prompt PL/SQL Developer import file
prompt Created on ��������� 22 ��� 2024 by 97258
set feedback off
set define off
prompt Creating DONORS...
create table DONORS
(
  did         NUMBER(9) not null,
  dname       VARCHAR2(30) not null,
  address     VARCHAR2(100) not null,
  phonenumber VARCHAR2(15) not null
)
;
alter table DONORS
  add primary key (DID)
  ;

prompt Creating EQUIPMENT...
create table EQUIPMENT
(
  eid      NUMBER(5) not null,
  ename    VARCHAR2(30) not null,
  ismobile VARCHAR2(5) not null,
  quantity INTEGER not null,
  price    NUMBER(7,2) not null
)
;
alter table EQUIPMENT
  add primary key (EID)
  ;
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
;
alter table SUPPLIERS
  add primary key (SID)
  ;

prompt Creating ORDERS...
create table ORDERS
(
  oid       NUMBER(5) not null,
  orderdate DATE not null,
  sid       NUMBER(9) not null
)
;
alter table ORDERS
  add primary key (OID)
  ;
alter table ORDERS
  add foreign key (SID)
  references SUPPLIERS (SID);

prompt Disabling triggers for DONORS...
alter table DONORS disable all triggers;
prompt Disabling triggers for EQUIPMENT...
alter table EQUIPMENT disable all triggers;
prompt Disabling triggers for SUPPLIERS...
alter table SUPPLIERS disable all triggers;
prompt Disabling triggers for ORDERS...
alter table ORDERS disable all triggers;
prompt Disabling foreign key constraints for ORDERS...
alter table ORDERS disable constraint SYS_C007223;
prompt Loading DONORS...
insert into DONORS (did, dname, address, phonenumber)
values (322498469, 'Donald  Pleasure', '867 McBride, Green bay, USA', '058-7009826');
insert into DONORS (did, dname, address, phonenumber)
values (322498530, 'Tyrone  Moreno', '8 Kahn Blvd, Kyoto, Japan', '050-8828859');
insert into DONORS (did, dname, address, phonenumber)
values (322498795, 'Aidan  Kapanka', '24 North bethesda Drive, Tilst, Denmark', '055-2435751');
insert into DONORS (did, dname, address, phonenumber)
values (322498847, 'Tia  Gary', '98 Kansas City Road, Gliwice, Poland', '050-9261618');
insert into DONORS (did, dname, address, phonenumber)
values (322498747, 'Ashley  Pony', '29 Ann Road, Santa Cruz, USA', '051-1551753');
insert into DONORS (did, dname, address, phonenumber)
values (322498696, 'Willie  Raye', '17 Spring City Road, Key Biscayne, USA', '058-7451128');
insert into DONORS (did, dname, address, phonenumber)
values (322498754, 'Murray  Stoltz', '44 Sarandon Ave, Koppl, Austria', '055-8896508');
insert into DONORS (did, dname, address, phonenumber)
values (322498493, 'Uma  Madonna', '39 Cocker Ave, Gen�ve, Switzerland', '050-9714038');
insert into DONORS (did, dname, address, phonenumber)
values (322498715, 'Barry  Redford', '9 Luis Street, Massagno, Switzerland', '051-4674357');
insert into DONORS (did, dname, address, phonenumber)
values (322498495, 'Mary  Damon', '385 Englund Road, Lodi, Italy', '051-4314720');
insert into DONORS (did, dname, address, phonenumber)
values (322498471, 'Stephen  Waite', '62nd Street, San Francisco, USA', '057-8593191');
insert into DONORS (did, dname, address, phonenumber)
values (322498669, 'Adam  McDowell', '28 Forrest Road, Eschen, Liechtenstein', '051-8019735');
insert into DONORS (did, dname, address, phonenumber)
values (322498524, 'Rob  Collette', '88 Raul Street, Hamburg, Germany', '057-7985383');
insert into DONORS (did, dname, address, phonenumber)
values (322498751, 'Hilton  Skerritt', '100 Streep Road, Omaha, USA', '057-6982126');
insert into DONORS (did, dname, address, phonenumber)
values (322498756, 'Sharon  Harmon', '27 Sayer Road, Wakayama, Japan', '059-2486026');
insert into DONORS (did, dname, address, phonenumber)
values (322498703, 'Henry  Hauser', '78 Utsunomiya Road, Pretoria, South Africa', '054-7654621');
insert into DONORS (did, dname, address, phonenumber)
values (322498677, 'Jena  Loeb', '54 Meryl Road, Salvador, Brazil', '054-5947603');
insert into DONORS (did, dname, address, phonenumber)
values (322498772, 'Jake  Carrere', '25 Gaynor Road, Luzern, Switzerland', '050-3146671');
insert into DONORS (did, dname, address, phonenumber)
values (322498473, 'Neve  Holly', '25 LaPaglia Street, Oxon, United Kingdom', '059-7057869');
insert into DONORS (did, dname, address, phonenumber)
values (322498558, 'Nick  Gaines', '85 Fraser Street, Horb, Germany', '052-7982184');
insert into DONORS (did, dname, address, phonenumber)
values (322498761, 'Cloris  Whitwam', '85 Murdock Street, Lexington, USA', '056-8212086');
insert into DONORS (did, dname, address, phonenumber)
values (322498627, 'Emm  Henstridge', '82 Walsh Drive, Michendorf, Germany', '052-1196858');
insert into DONORS (did, dname, address, phonenumber)
values (322498526, 'Graham  Dickinson', '37 D''Onofrio Drive, Mississauga, Canada', '053-7907188');
insert into DONORS (did, dname, address, phonenumber)
values (322498684, 'Sammy  Carlisle', '9 Winwood Street, Bradenton, USA', '050-1827995');
insert into DONORS (did, dname, address, phonenumber)
values (322498516, 'Jonny  Armstrong', '32nd Street, Maebashi, Japan', '050-7690453');
insert into DONORS (did, dname, address, phonenumber)
values (322498597, 'Shelby  Trevino', '69 Lynn Ave, Angers, France', '051-4649390');
insert into DONORS (did, dname, address, phonenumber)
values (322498809, 'Juliette  McClinton', '38 McIntyre Drive, Sulzbach, Germany', '054-4096044');
insert into DONORS (did, dname, address, phonenumber)
values (322498592, 'Rhona  Feore', '46 Sheena Street, East Providence, USA', '050-6894427');
insert into DONORS (did, dname, address, phonenumber)
values (322498791, 'David  O''Donnell', '90 Benoit Street, St. Louis, USA', '050-2922554');
insert into DONORS (did, dname, address, phonenumber)
values (322498783, 'Bridgette  Bedelia', '99 Turku Street, Tartu, Estonia', '058-6818686');
insert into DONORS (did, dname, address, phonenumber)
values (322498600, 'Robbie  Kershaw', '21st Street, Milan, Italy', '058-1553021');
insert into DONORS (did, dname, address, phonenumber)
values (322498468, 'Kitty  Aglukark', '72 Aidan Street, Harsum, Germany', '053-3635828');
insert into DONORS (did, dname, address, phonenumber)
values (322498765, 'Lili  Curtis-Hall', '214 Vista, Holliston, USA', '054-4729945');
insert into DONORS (did, dname, address, phonenumber)
values (322498507, 'Christine  Mifune', '67 Embeth Drive, Cuenca, Ecuador', '058-4982666');
insert into DONORS (did, dname, address, phonenumber)
values (322498646, 'Gabriel  Deschanel', '12nd Street, Dreieich, Germany', '052-6204354');
insert into DONORS (did, dname, address, phonenumber)
values (322498527, 'Sally  Clark', '24 Romijn-Stamos Street, Dunn loring, USA', '053-2848170');
insert into DONORS (did, dname, address, phonenumber)
values (322498652, 'Frances  Brando', '69 Playboys Road, Uetikon am See, Switzerland', '053-8464342');
insert into DONORS (did, dname, address, phonenumber)
values (322498738, 'Talvin  Leigh', '54 Pressly Road, Juneau, USA', '058-5078081');
insert into DONORS (did, dname, address, phonenumber)
values (322498688, 'Jesse  Studi', '81 Toronto Ave, Mechanicsburg, USA', '056-8091358');
insert into DONORS (did, dname, address, phonenumber)
values (322498702, 'Frances  Nugent', '47 Aiken Street, Chinnor, United Kingdom', '051-5668966');
insert into DONORS (did, dname, address, phonenumber)
values (322498824, 'Eileen  Bale', '16 Yamagata Drive, Columbia, USA', '057-9315783');
insert into DONORS (did, dname, address, phonenumber)
values (322498474, 'Tony  McGill', '80 S. Bernardo do Campo Road, League city, USA', '056-1125980');
insert into DONORS (did, dname, address, phonenumber)
values (322498601, 'Joy  Meniketti', '53rd Street, Ohtsu, Japan', '052-1811626');
insert into DONORS (did, dname, address, phonenumber)
values (322498467, 'Julianna  Wright', '46 Heche Drive, Boston, USA', '050-8328541');
insert into DONORS (did, dname, address, phonenumber)
values (322498576, 'Shannon  Wills', '67 Drew Street, Parma, Italy', '054-8698845');
insert into DONORS (did, dname, address, phonenumber)
values (322498822, 'Jill  Paltrow', '58 Casey Street, Yavne, Israel', '050-4159033');
insert into DONORS (did, dname, address, phonenumber)
values (322498842, 'Delbert  Griffith', '28 Vince, Batavia, USA', '057-6127599');
insert into DONORS (did, dname, address, phonenumber)
values (322498589, 'Rich  Fichtner', '36 Collie Drive, Horb, Germany', '059-5633687');
insert into DONORS (did, dname, address, phonenumber)
values (322498698, 'Rufus  Campbell', '36 Domino Road, San Mateo, USA', '055-4695960');
insert into DONORS (did, dname, address, phonenumber)
values (322498712, 'Jet  Black', '66 Dillane Road, Battle Creek, USA', '057-4472114');
insert into DONORS (did, dname, address, phonenumber)
values (322498812, 'Freda  McNeice', '5 Brolin Road, Akron, USA', '051-2516044');
insert into DONORS (did, dname, address, phonenumber)
values (322498734, 'Giancarlo  Parm', '28 Kurtz Street, Casselberry, USA', '054-9274509');
insert into DONORS (did, dname, address, phonenumber)
values (322498569, 'Graham  Hauer', '60 Foster Road, Bischofshofen, Austria', '053-6866923');
insert into DONORS (did, dname, address, phonenumber)
values (322498519, 'Carlos  Serbedzija', '27 Cromwell, Houma, USA', '056-3996072');
insert into DONORS (did, dname, address, phonenumber)
values (322498801, 'Cyndi  Sharp', '56 Gilley Street, Wellington, New Zealand', '059-7390141');
insert into DONORS (did, dname, address, phonenumber)
values (322498584, 'Brian  Bell', '36 Denver Street, Kaunas, Lithuania', '059-2213679');
insert into DONORS (did, dname, address, phonenumber)
values (322498557, 'Isabella  Feliciano', '51 Benoit Drive, Protvino, Russia', '055-1123007');
insert into DONORS (did, dname, address, phonenumber)
values (322498657, 'Arturo  DeVita', '10 Mattea Road, Ankara, Turkey', '059-4857509');
insert into DONORS (did, dname, address, phonenumber)
values (322498802, 'Bernie  Freeman', '72 Peterborough Street, Ilmenau, Germany', '057-5328544');
insert into DONORS (did, dname, address, phonenumber)
values (322498522, 'Liam  Kweller', '1 Chubby Street, Takapuna, New Zealand', '059-3645085');
insert into DONORS (did, dname, address, phonenumber)
values (322498736, 'Natacha  Himmelman', '49 Plummer Street, Angers, France', '051-4039793');
insert into DONORS (did, dname, address, phonenumber)
values (322498682, 'Kay  Slater', '63 Kutcher Road, Londrina, Brazil', '056-4109636');
insert into DONORS (did, dname, address, phonenumber)
values (322498628, 'Sinead  Stormare', '663 Robbins Street, Peachtree City, USA', '053-9176548');
insert into DONORS (did, dname, address, phonenumber)
values (322498699, 'Sal  Schiff', '55 Guzman Street, Milsons Point, Australia', '051-4643253');
insert into DONORS (did, dname, address, phonenumber)
values (322498639, 'Davy  Lange', '46 Judd Street, Barnegat, USA', '051-4806281');
insert into DONORS (did, dname, address, phonenumber)
values (322498622, 'Lily  Phillips', '93 Orange Ave, Mount Olive, USA', '055-5233620');
insert into DONORS (did, dname, address, phonenumber)
values (322498786, 'Winona  DeGraw', '123 Khan, South Jordan, USA', '053-9293602');
insert into DONORS (did, dname, address, phonenumber)
values (322498681, 'Nastassja  Rickles', '94 Tamala, Coimbra, Portugal', '055-4455993');
insert into DONORS (did, dname, address, phonenumber)
values (322498606, 'Geraldine  Fraser', '51st Street, Budapest, Hungary', '059-5815821');
insert into DONORS (did, dname, address, phonenumber)
values (322498726, 'Viggo  Giamatti', '92 Ed Road, Cherepovets, Russia', '052-9246152');
insert into DONORS (did, dname, address, phonenumber)
values (322498741, 'Lea  Thomson', '73rd Street, Dalmine, Italy', '056-7430784');
insert into DONORS (did, dname, address, phonenumber)
values (322498732, 'Jake  Patton', '163 Kilmer, Echirolles, France', '058-9920769');
insert into DONORS (did, dname, address, phonenumber)
values (322498607, 'Humberto  Benoit', '736 Fukui, New Delhi, India', '059-9598172');
insert into DONORS (did, dname, address, phonenumber)
values (322498787, 'Wayne  Lauper', '63 Lattimore Ave, Sidney, Canada', '054-9020194');
insert into DONORS (did, dname, address, phonenumber)
values (322498706, 'Talvin  Dalley', '52 Milano Road, Regina, Canada', '052-7554785');
insert into DONORS (did, dname, address, phonenumber)
values (322498501, 'Annette  Tippe', '81 Tori Drive, Herdecke, Germany', '057-4076785');
insert into DONORS (did, dname, address, phonenumber)
values (322498839, 'Laura  Douglas', '829 Sheryl Ave, Santiago, Chile', '055-4331871');
insert into DONORS (did, dname, address, phonenumber)
values (322498701, 'Maggie  Harary', '59 Singletary Road, Richmond Hill, Canada', '054-9662457');
insert into DONORS (did, dname, address, phonenumber)
values (322498583, 'Rachid  Holm', '96 Tempest Drive, Irati, Brazil', '054-5617084');
insert into DONORS (did, dname, address, phonenumber)
values (322498619, 'Tramaine  Benoit', '69 Campbell Drive, Orlando, USA', '050-8752752');
insert into DONORS (did, dname, address, phonenumber)
values (322498658, 'Gailard  Wills', '78 Santana Street, San Diego, USA', '054-3117861');
insert into DONORS (did, dname, address, phonenumber)
values (322498629, 'Ossie  Streep', '250 Karen Road, Herford, Germany', '057-5917599');
insert into DONORS (did, dname, address, phonenumber)
values (322498654, 'Tcheky  Adler', '88 Waite Drive, Ittigen, Switzerland', '057-7672715');
insert into DONORS (did, dname, address, phonenumber)
values (322498768, 'Trey  Jackson', '91 Lenny Road, Dalmine, Italy', '051-3582662');
insert into DONORS (did, dname, address, phonenumber)
values (322498621, 'Olga  Turner', '57 Lexington Street, Piacenza, Italy', '054-5243485');
insert into DONORS (did, dname, address, phonenumber)
values (322498472, 'Peabo  Greene', '38 Angers Blvd, Biella, Italy', '050-8253389');
insert into DONORS (did, dname, address, phonenumber)
values (322498560, 'Liam  Cocker', '33 Fred Blvd, Saudarkrokur, Iceland', '056-4655453');
insert into DONORS (did, dname, address, phonenumber)
values (322498810, 'Marlon  Turturro', '6 Udine Street, Lyon, France', '056-4481912');
insert into DONORS (did, dname, address, phonenumber)
values (322498478, 'Darren  Hanks', '83 Matthew Road, Walnut Creek, USA', '059-5739362');
insert into DONORS (did, dname, address, phonenumber)
values (322498716, 'Rutger  Duke', '28 Willis, Toledo, Spain', '054-5549089');
insert into DONORS (did, dname, address, phonenumber)
values (322498517, 'Kevin  Remar', '92nd Street, Uden, Netherlands', '051-9144263');
insert into DONORS (did, dname, address, phonenumber)
values (322498481, 'Curt  Galecki', '84 Zellweger Street, Bellevue, USA', '059-8535230');
insert into DONORS (did, dname, address, phonenumber)
values (322498615, 'Kathleen  Dolenz', '33rd Street, Edenbridge, United Kingdom', '059-2410369');
insert into DONORS (did, dname, address, phonenumber)
values (322498663, 'Powers  Cronin', '576 Santana Street, Bedford, USA', '054-8512695');
insert into DONORS (did, dname, address, phonenumber)
values (322498541, 'Merrilee  Pride', '232 Hurt Road, Treviso, Italy', '059-2813345');
insert into DONORS (did, dname, address, phonenumber)
values (322498582, 'Mia  Hunt', '29 Soroe Drive, Campana, Argentina', '051-5040825');
insert into DONORS (did, dname, address, phonenumber)
values (322498770, 'Steven  Thorton', '77 Ivan Street, Aberdeen, United Kingdom', '059-9852042');
insert into DONORS (did, dname, address, phonenumber)
values (322498776, 'Cliff  Porter', '33 Wilder Road, Hearst, Canada', '050-7930696');
insert into DONORS (did, dname, address, phonenumber)
values (322498667, 'Walter  Rippy', '466 Emilio Drive, Milford, USA', '053-7390270');
insert into DONORS (did, dname, address, phonenumber)
values (322498853, 'Percy  Krieger', '76 Merrilee Drive, Duluth, USA', '052-1996672');
commit;
prompt 100 records committed...
insert into DONORS (did, dname, address, phonenumber)
values (322498785, 'Sheena  Pacino', '89 Burstyn Road, Ramat Gan, Israel', '052-3546441');
insert into DONORS (did, dname, address, phonenumber)
values (322498722, 'Oded  Lang', '501 Penders Road, Virginia Beach, USA', '059-5064211');
insert into DONORS (did, dname, address, phonenumber)
values (322498470, 'Liquid  Englund', '18 Kreuzau Drive, Munich, Germany', '059-9965987');
insert into DONORS (did, dname, address, phonenumber)
values (322498739, 'Harrison  Oszajca', '626 Fort gordon Street, San Antonio, USA', '051-4969393');
insert into DONORS (did, dname, address, phonenumber)
values (322498733, 'Alannah  Theron', '1 Rourke Drive, Milton, Australia', '059-9710017');
insert into DONORS (did, dname, address, phonenumber)
values (322498671, 'Hank  Vega', '72 Goslar Street, Aracruz, Brazil', '056-5634176');
insert into DONORS (did, dname, address, phonenumber)
values (322498860, 'Johnette  Mirren', '95 Cervine Street, Durban, South Africa', '053-4179512');
insert into DONORS (did, dname, address, phonenumber)
values (322498707, 'CeCe  Domino', '75 Klein Ave, Draper, USA', '051-9617301');
insert into DONORS (did, dname, address, phonenumber)
values (322498605, 'Ossie  Cruise', '25 Ronstadt Road, Freising, Germany', '053-5863683');
insert into DONORS (did, dname, address, phonenumber)
values (322498531, 'Nicolas  Holliday', '29 Horace Drive, Fairfax, USA', '059-2565993');
insert into DONORS (did, dname, address, phonenumber)
values (322498484, 'Sophie  Vanian', '618 Connery Blvd, Rothenburg, Germany', '056-6885427');
insert into DONORS (did, dname, address, phonenumber)
values (322498820, 'Gailard  Torn', '51 Raul Blvd, Carlsbad, USA', '053-2168647');
insert into DONORS (did, dname, address, phonenumber)
values (322498720, 'Tommy  Evett', '702 Lofgren Drive, Peine, Germany', '050-6294199');
insert into DONORS (did, dname, address, phonenumber)
values (322498833, 'Nickel  Def', '62 Danger Blvd, Oulu, Finland', '053-1486294');
insert into DONORS (did, dname, address, phonenumber)
values (322498690, 'Brian  Rundgren', '73 Janeane Drive, Gaithersburg, USA', '052-7008699');
insert into DONORS (did, dname, address, phonenumber)
values (322498577, 'Rose  Brooks', '375 Arlington Road, Chur, Switzerland', '055-9186084');
insert into DONORS (did, dname, address, phonenumber)
values (322498499, 'Brent  Ponce', '78 Art Drive, Den Haag, Netherlands', '055-7441604');
insert into DONORS (did, dname, address, phonenumber)
values (322498483, 'Anita  Hingle', '49 Mobile Drive, Lummen, Belgium', '057-8544964');
insert into DONORS (did, dname, address, phonenumber)
values (322498602, 'Lynette  Garcia', '69 Ruiz Road, Treviso, Italy', '053-8960874');
insert into DONORS (did, dname, address, phonenumber)
values (322498748, 'Ralph  McKellen', '22 Metcalf Road, West Drayton, United Kingdom', '059-2456317');
insert into DONORS (did, dname, address, phonenumber)
values (322498638, 'Rufus  Hingle', '11 Yaphet Drive, Lyon, France', '052-6462661');
insert into DONORS (did, dname, address, phonenumber)
values (322498729, 'Nancy  Cruise', '18 Preston Street, Waalwijk, Netherlands', '052-3836265');
insert into DONORS (did, dname, address, phonenumber)
values (322498564, 'Kimberly  Keith', '93 Curtis Ave, Ellicott City, USA', '050-8383100');
insert into DONORS (did, dname, address, phonenumber)
values (322498753, 'Humberto  Balin', '11 Tracy Drive, Solon, USA', '052-3477340');
insert into DONORS (did, dname, address, phonenumber)
values (322498645, 'Chaka  McGovern', '26 Dolenz Drive, Anyang-si, South Korea', '051-5335875');
insert into DONORS (did, dname, address, phonenumber)
values (322498790, 'Rachid  Harrelson', '51 Scorsese Road, Gothenburg, Sweden', '052-9743565');
insert into DONORS (did, dname, address, phonenumber)
values (322498565, 'Regina  Derringer', '40 Martin Road, Maintenon, France', '058-2600252');
insert into DONORS (did, dname, address, phonenumber)
values (322498644, 'Sheryl  Wincott', '502 Wainwright Street, Noumea, New Caledonia', '055-1315133');
insert into DONORS (did, dname, address, phonenumber)
values (322498719, 'Victoria  Slater', '25 Santa Rosa Street, Fort Saskatchewan, Canada', '058-9039502');
insert into DONORS (did, dname, address, phonenumber)
values (322498542, 'Terry  Duchovny', '29 Griffin Drive, Chambersburg, USA', '055-2688460');
insert into DONORS (did, dname, address, phonenumber)
values (322498746, 'Micky  Gambon', '88 West Point Blvd, Singapore, Singapore', '050-3826345');
insert into DONORS (did, dname, address, phonenumber)
values (322498794, 'Geggy  Dysart', '950 Jakarta Road, Bracknell, United Kingdom', '059-3532031');
insert into DONORS (did, dname, address, phonenumber)
values (322498775, 'Bridget  Cox', '796 Pitt Road, Mount Olive, USA', '054-4880185');
insert into DONORS (did, dname, address, phonenumber)
values (322498815, 'Julio  Ali', '62 Kapanka Blvd, Woking, United Kingdom', '052-2386606');
insert into DONORS (did, dname, address, phonenumber)
values (322498480, 'Don  Makeba', '854 Vaughn Blvd, Pacific Grove, USA', '055-7055971');
insert into DONORS (did, dname, address, phonenumber)
values (322973454, 'Bridgette  Dushku', '454 Domino Street, Greenwood Village, USA', '057-8226255');
insert into DONORS (did, dname, address, phonenumber)
values (322973455, 'Lupe  Diffie', '18 Bolzano, Gifu, Japan', '058-5805580');
insert into DONORS (did, dname, address, phonenumber)
values (322973456, 'Hal  Place', '92 Lou Road, Shreveport, USA', '052-4908119');
insert into DONORS (did, dname, address, phonenumber)
values (322973457, 'Alannah  Masur', '69 Choice Drive, Gifu, Japan', '054-9595522');
insert into DONORS (did, dname, address, phonenumber)
values (322973458, 'Patti  Gellar', '687 Tbilisi Street, Slough, United Kingdom', '052-6595302');
insert into DONORS (did, dname, address, phonenumber)
values (322973459, 'Bette  Del Toro', '63 Levin Blvd, Mechelen, Belgium', '057-5228339');
insert into DONORS (did, dname, address, phonenumber)
values (322973460, 'Anita  Def', '44 Winwood Drive, Derwood, USA', '058-1597041');
insert into DONORS (did, dname, address, phonenumber)
values (322973461, 'Sylvester  Hauser', '65 Breckin Road, Adamstown, Australia', '050-7492551');
insert into DONORS (did, dname, address, phonenumber)
values (322973462, 'Christmas  Oszajca', '51 Sainte-Marie Ave, Franklin, USA', '051-2693338');
insert into DONORS (did, dname, address, phonenumber)
values (322973463, 'Solomon  Ponty', '29 Gallagher Blvd, Key Biscayne, USA', '054-2811575');
insert into DONORS (did, dname, address, phonenumber)
values (322973464, 'Lonnie  Gilliam', '3 Belle Road, M�nchengladbach, Germany', '050-2692775');
insert into DONORS (did, dname, address, phonenumber)
values (322973465, 'Oded  Spall', '16 Eddie Drive, Fort Saskatchewan, Canada', '052-9391072');
insert into DONORS (did, dname, address, phonenumber)
values (322973466, 'Jason  Sisto', '80 Keitel Street, Chapel hill, USA', '058-7705009');
insert into DONORS (did, dname, address, phonenumber)
values (322973467, 'Martha  Holmes', '75 Tomlin Ave, Coimbra, Portugal', '053-1905062');
insert into DONORS (did, dname, address, phonenumber)
values (322973468, 'Kirsten  Derringer', '92 Culkin Drive, Olsztyn, Poland', '059-5480658');
insert into DONORS (did, dname, address, phonenumber)
values (322973469, 'Jay  Bacharach', '3 Griggs Street, Chemnitz, Germany', '053-3417105');
insert into DONORS (did, dname, address, phonenumber)
values (322973470, 'Steven  McGovern', '43 Omaha Road, Reading, United Kingdom', '057-8224150');
insert into DONORS (did, dname, address, phonenumber)
values (322973471, 'Gran  McKean', '8 Johnnie Road, Matsuyama, Japan', '050-1498341');
insert into DONORS (did, dname, address, phonenumber)
values (322973472, 'Jake  Shaye', '23 Visnjic Street, Birmingham, United Kingdom', '057-6826788');
insert into DONORS (did, dname, address, phonenumber)
values (322973473, 'Lupe  Sepulveda', '8 Trejo Street, Fleet, United Kingdom', '058-2517889');
insert into DONORS (did, dname, address, phonenumber)
values (322973474, 'Nils  Wiedlin', '500 Ford Ave, Batavia, USA', '054-2082919');
insert into DONORS (did, dname, address, phonenumber)
values (322973475, 'Sammy  Neill', '14 Suwon Street, Uetikon am See, Switzerland', '053-2450613');
insert into DONORS (did, dname, address, phonenumber)
values (322973476, 'Charlton  King', '38 Oates Street, Pretoria, South Africa', '051-1712906');
insert into DONORS (did, dname, address, phonenumber)
values (322973477, 'Tramaine  Phillippe', '80 Vilnius Ave, Kochi, Japan', '055-3860694');
insert into DONORS (did, dname, address, phonenumber)
values (322973478, 'Jean-Luc  Dempsey', '8 Cuba Road, Hannover, Germany', '059-8577419');
insert into DONORS (did, dname, address, phonenumber)
values (322973479, 'Alannah  Sellers', '33rd Street, Lucca, Italy', '054-5929770');
insert into DONORS (did, dname, address, phonenumber)
values (322973480, 'Moe  Bacharach', '99 King Road, Bolton, Canada', '059-7050188');
insert into DONORS (did, dname, address, phonenumber)
values (322973481, 'Wayne  Aniston', '24 Capshaw Ave, Vaduz, Liechtenstein', '057-6248072');
insert into DONORS (did, dname, address, phonenumber)
values (322973482, 'Chaka  Rockwell', '96 Irons Blvd, Tooele, USA', '052-2092990');
insert into DONORS (did, dname, address, phonenumber)
values (322973483, 'Tim  Sandler', '82nd Street, Moreno Valley, USA', '055-4894462');
insert into DONORS (did, dname, address, phonenumber)
values (322973484, 'Kyra  Roberts', '39 Spacey Drive, Swannanoa, USA', '056-7667651');
insert into DONORS (did, dname, address, phonenumber)
values (322973485, 'Clay  Channing', '51 Turturro, Burr Ridge, USA', '057-9454189');
insert into DONORS (did, dname, address, phonenumber)
values (322973486, 'Josh  Horizon', '769 Stiers Drive, Borger, USA', '057-1725133');
insert into DONORS (did, dname, address, phonenumber)
values (322973487, 'Tzi  Prinze', '18 Whitehouse Station, Mogliano Veneto, Italy', '053-7049330');
insert into DONORS (did, dname, address, phonenumber)
values (322973488, 'Ted  Arkin', '52 Omaha Road, Vienna, Austria', '053-9674996');
insert into DONORS (did, dname, address, phonenumber)
values (322973489, 'Emmylou  Minogue', '60 Gauteng, Turku, Finland', '050-2707550');
insert into DONORS (did, dname, address, phonenumber)
values (322973490, 'Ramsey  Suchet', '66 Caguas Street, Narrows, USA', '050-6464588');
insert into DONORS (did, dname, address, phonenumber)
values (322973491, 'Rob  Hong', '83 Giancarlo Street, Jakarta, Indonesia', '058-7528773');
insert into DONORS (did, dname, address, phonenumber)
values (322973492, 'Radney  Cube', '60 El Paso Drive, Johannesburg, South Africa', '051-5158170');
insert into DONORS (did, dname, address, phonenumber)
values (322973493, 'Loreena  Hutch', '867 Grant Blvd, New Hope, USA', '055-3955478');
insert into DONORS (did, dname, address, phonenumber)
values (322973494, 'Loren  Phifer', '49 Irons Ave, Vista, USA', '050-3817756');
insert into DONORS (did, dname, address, phonenumber)
values (322973495, 'Trick  Weir', '54 El Segundo, Unionville, Canada', '050-5797729');
insert into DONORS (did, dname, address, phonenumber)
values (322973496, 'Juliette  Heslov', '670 Broadbent Ave, Whittier, USA', '054-6520218');
insert into DONORS (did, dname, address, phonenumber)
values (322973497, 'Dabney  Armstrong', '66 Pompeia Ave, Thames Ditton, United Kingdom', '053-5660625');
insert into DONORS (did, dname, address, phonenumber)
values (322973498, 'John  Lavigne', '52nd Street, Germantown, USA', '059-9996240');
insert into DONORS (did, dname, address, phonenumber)
values (322973499, 'Helen  Mortensen', '86 Ashley Street, Ismaning, Germany', '058-1818308');
insert into DONORS (did, dname, address, phonenumber)
values (322973500, 'Liam  Guilfoyle', '41 Vannelli Drive, Nuernberg, Germany', '057-1122507');
insert into DONORS (did, dname, address, phonenumber)
values (322973501, 'Lea  Watson', '77 Karachi Drive, Sihung-si, South Korea', '054-6064942');
insert into DONORS (did, dname, address, phonenumber)
values (322973502, 'Tramaine  Cheadle', '73 Eden prairie Street, St-laurent, Canada', '056-1400128');
insert into DONORS (did, dname, address, phonenumber)
values (322973503, 'Nancy  Stampley', '91st Street, New Castle, USA', '056-6519399');
insert into DONORS (did, dname, address, phonenumber)
values (322973504, 'Roscoe  Chan', '13 Lila Road, Londrina, Brazil', '053-5797205');
insert into DONORS (did, dname, address, phonenumber)
values (322973505, 'Juliana  Khan', '13 Remar Ave, Paisley, United Kingdom', '056-1516304');
insert into DONORS (did, dname, address, phonenumber)
values (322973506, 'Nikki  Lapointe', '15 Kelly Road, League city, USA', '059-9793899');
insert into DONORS (did, dname, address, phonenumber)
values (322973507, 'Hookah  Moody', '53 Tisdale Street, Bozeman, USA', '056-7983709');
insert into DONORS (did, dname, address, phonenumber)
values (322973508, 'Rosco  Mantegna', '550 Secada Drive, Tilst, Denmark', '059-2132904');
insert into DONORS (did, dname, address, phonenumber)
values (322973509, 'Bob  Rourke', '32 Portland, Slmea, USA', '057-5644407');
insert into DONORS (did, dname, address, phonenumber)
values (322973510, 'Belinda  Hanley', '86 Nantes Street, Adelaide, Australia', '050-9904037');
insert into DONORS (did, dname, address, phonenumber)
values (322973511, 'Henry  Brandt', '77 Zahn Ave, Taipei, Taiwan', '056-8002639');
insert into DONORS (did, dname, address, phonenumber)
values (322973512, 'Marc  Lofgren', '67 Roundtree Road, Burgess Hill, United Kingdom', '050-9237968');
insert into DONORS (did, dname, address, phonenumber)
values (322973513, 'Maxine  Spacey', '90 New Fairfield Road, Kristiansand, Norway', '058-6430438');
insert into DONORS (did, dname, address, phonenumber)
values (322973514, 'Nicole  Burrows', '52 Joli Blvd, Manaus, Brazil', '051-2983095');
insert into DONORS (did, dname, address, phonenumber)
values (322973515, 'Laurie  Keith', '82 Changwon-si Street, Phoenix, USA', '052-2287048');
insert into DONORS (did, dname, address, phonenumber)
values (322973516, 'Samuel  Laurie', '89 Penders Street, Buffalo Grove, USA', '055-6175071');
insert into DONORS (did, dname, address, phonenumber)
values (322973517, 'Gilberto  Reilly', '64 Cummings Ave, Bautzen, Germany', '053-3261308');
insert into DONORS (did, dname, address, phonenumber)
values (322973518, 'Ramsey  Mathis', '34 Matheson Blvd, Wien, Austria', '057-8913265');
commit;
prompt 200 records committed...
insert into DONORS (did, dname, address, phonenumber)
values (322973519, 'Sam  Cleary', '87 Robby Blvd, Shreveport, USA', '056-6196277');
insert into DONORS (did, dname, address, phonenumber)
values (322973520, 'Joe  Davis', '62nd Street, Hunt Valley, USA', '051-1617013');
insert into DONORS (did, dname, address, phonenumber)
values (322973521, 'Busta  Moody', '94 Rockwell Street, Newnan, USA', '058-2677961');
insert into DONORS (did, dname, address, phonenumber)
values (322973522, 'Rawlins  Weaving', '755 Van Damme Blvd, Benbrook, USA', '052-6991712');
insert into DONORS (did, dname, address, phonenumber)
values (322973523, 'Sophie  Coverdale', '15 East sussex Road, Peine, Germany', '050-9078966');
insert into DONORS (did, dname, address, phonenumber)
values (322973524, 'Graham  Pitt', '744 Borgnine Road, Eschen, Liechtenstein', '055-7623371');
insert into DONORS (did, dname, address, phonenumber)
values (322973525, 'Selma  Kristofferson', '33 Micky, Glasgow, United Kingdom', '057-5149435');
insert into DONORS (did, dname, address, phonenumber)
values (322973526, 'Judi  Cotton', '72nd Street, Traralgon, Australia', '059-1145950');
insert into DONORS (did, dname, address, phonenumber)
values (322973527, 'Stevie  Van Damme', '535 Graham Blvd, Juazeiro, Brazil', '052-1520583');
insert into DONORS (did, dname, address, phonenumber)
values (322973528, 'Rufus  Norton', '73rd Street, Rancho Palos Verdes, USA', '053-4480210');
insert into DONORS (did, dname, address, phonenumber)
values (322973529, 'Danny  Peniston', '613 Field Road, Bracknell, United Kingdom', '058-8864785');
insert into DONORS (did, dname, address, phonenumber)
values (322973530, 'Kasey  Mortensen', '49 Limeira Ave, Akron, USA', '057-6026977');
insert into DONORS (did, dname, address, phonenumber)
values (322973531, 'Dylan  Guinness', '92 De Niro Street, Kyunnam, South Korea', '050-4212894');
insert into DONORS (did, dname, address, phonenumber)
values (322973532, 'Andy  Todd', '71st Street, Michendorf, Germany', '051-4976215');
insert into DONORS (did, dname, address, phonenumber)
values (322973533, 'Joan  Davis', '99 Weaving Street, Tulsa, USA', '058-1867164');
insert into DONORS (did, dname, address, phonenumber)
values (322973534, 'Cate  Ferry', '57 Cage Street, Meppel, Netherlands', '055-4530424');
insert into DONORS (did, dname, address, phonenumber)
values (322973535, 'Hector  Keith', '79 Jonathan Road, Hong Kong, Hong Kong', '053-4410000');
insert into DONORS (did, dname, address, phonenumber)
values (322973536, 'Vin  Brooke', '85 Winger Street, Horsham, USA', '059-4070397');
insert into DONORS (did, dname, address, phonenumber)
values (322973537, 'Ritchie  Macht', '33 Hawke Street, Duesseldorf, Germany', '053-4510629');
insert into DONORS (did, dname, address, phonenumber)
values (322973538, 'Gil  Imbruglia', '672 Chalee Ave, Narrows, USA', '056-8285744');
insert into DONORS (did, dname, address, phonenumber)
values (322973539, 'Lionel  Wayans', '69 Agoncillo Street, Eindhoven, Netherlands', '058-6985138');
insert into DONORS (did, dname, address, phonenumber)
values (322973540, 'Louise  Berkoff', '63 Paisley Drive, Gaza, Palestine', '053-7795432');
insert into DONORS (did, dname, address, phonenumber)
values (322973541, 'Brendan  Sarandon', '24 Leto Road, Odense, Denmark', '058-8795845');
insert into DONORS (did, dname, address, phonenumber)
values (322973542, 'Stanley  Lightfoot', '81st Street, El Masnou, Spain', '058-4645709');
insert into DONORS (did, dname, address, phonenumber)
values (322973543, 'Sammy  Boorem', '89 Paul Road, Jacksonville, USA', '059-5599899');
insert into DONORS (did, dname, address, phonenumber)
values (322973544, 'Taylor  Coyote', '77 Jean-Claude Street, Kaunas, Lithuania', '056-2792530');
insert into DONORS (did, dname, address, phonenumber)
values (322973545, 'Kazem  Spine', '11 Cuenca Street, Torino, Italy', '059-9016480');
insert into DONORS (did, dname, address, phonenumber)
values (322973546, 'Art  Moody', '30 Bonnie Street, Fort gordon, USA', '057-7736162');
insert into DONORS (did, dname, address, phonenumber)
values (322973547, 'Ty  Ryan', '17 Skaggs Road, Redwood City, USA', '053-9606925');
insert into DONORS (did, dname, address, phonenumber)
values (322973548, 'Joy  Pollack', '736 Lancaster Street, High Wycombe, United Kingdom', '053-8647110');
insert into DONORS (did, dname, address, phonenumber)
values (322973549, 'Irene  Bosco', '40 Applegate Drive, Warren, USA', '055-9041843');
insert into DONORS (did, dname, address, phonenumber)
values (322973550, 'Barry  Van Helden', '44 Rickles Road, New York, USA', '055-8308507');
insert into DONORS (did, dname, address, phonenumber)
values (322973551, 'Austin  Crewson', '24 David Blvd, Marburg, Germany', '051-5329580');
insert into DONORS (did, dname, address, phonenumber)
values (322973552, 'Nikki  Culkin', '9 St Kilda Street, Waldorf, USA', '056-3451614');
insert into DONORS (did, dname, address, phonenumber)
values (322973553, 'Nikki  Condition', '11 Shizuoka Street, Bergara, Spain', '054-6244288');
insert into DONORS (did, dname, address, phonenumber)
values (322973554, 'Harris  Cheadle', '98 Ronnie Drive, Luedenscheid, Germany', '053-4520964');
insert into DONORS (did, dname, address, phonenumber)
values (322973555, 'Leo  Ingram', '72nd Street, Douala, Cameroun', '054-8560269');
insert into DONORS (did, dname, address, phonenumber)
values (322973556, 'Jennifer  Broadbent', '65 McGovern Blvd, Springville, USA', '050-3663679');
insert into DONORS (did, dname, address, phonenumber)
values (322973557, 'Marianne  McGoohan', '74 Remar, California, USA', '051-9066221');
insert into DONORS (did, dname, address, phonenumber)
values (322973558, 'Glenn  Robbins', '50 Bebe Street, Akita, Japan', '058-4809270');
insert into DONORS (did, dname, address, phonenumber)
values (322973559, 'Hector  Minogue', '27 Jason Road, Mapo-gu, South Korea', '051-7870012');
insert into DONORS (did, dname, address, phonenumber)
values (322973560, 'Annie  O''Hara', '48 East Peoria Road, Gettysburg, USA', '055-3487350');
insert into DONORS (did, dname, address, phonenumber)
values (322973561, 'Giancarlo  Keeslar', '63 Ness Street, Bend, USA', '057-5705387');
insert into DONORS (did, dname, address, phonenumber)
values (322973562, 'Philip  Negbaur', '81 Debbie Road, Waltham, USA', '052-9892853');
insert into DONORS (did, dname, address, phonenumber)
values (322973563, 'Sander  Sayer', '24 Nicholson Drive, Cottbus, Germany', '054-1283724');
insert into DONORS (did, dname, address, phonenumber)
values (322973564, 'Marina  Miller', '97 Potter Street, Redding, USA', '057-5004732');
insert into DONORS (did, dname, address, phonenumber)
values (322973565, 'Pat  Tillis', '10 Burt Road, Redwood Shores, USA', '055-7942598');
insert into DONORS (did, dname, address, phonenumber)
values (322973566, 'Nicolas  Scott', '37 Carradine Drive, Sapulpa, USA', '051-7552641');
insert into DONORS (did, dname, address, phonenumber)
values (322973567, 'LeVar  Skarsgard', '62 Kaiserslautern Road, Toledo, Spain', '057-8401225');
insert into DONORS (did, dname, address, phonenumber)
values (322973568, 'Madeline  Viterelli', '73 Sanchez Ave, Fornacette, Italy', '052-1782779');
insert into DONORS (did, dname, address, phonenumber)
values (322973569, 'Suzanne  MacNeil', '64 Rod Street, Lake Forest, USA', '050-8794983');
insert into DONORS (did, dname, address, phonenumber)
values (322973570, 'Marlon  Overstreet', '79 Columbus Road, Obfelden, Switzerland', '055-2934634');
insert into DONORS (did, dname, address, phonenumber)
values (322973571, 'Courtney  Ifans', '37 Gere Street, Reno, USA', '053-5205027');
insert into DONORS (did, dname, address, phonenumber)
values (322973572, 'Stephanie  Kinnear', '65 Wakeling Street, Albuquerque, USA', '053-5454136');
insert into DONORS (did, dname, address, phonenumber)
values (322973573, 'Rachid  Baker', '63rd Street, San Diego, USA', '056-8103783');
insert into DONORS (did, dname, address, phonenumber)
values (322973574, 'Geoffrey  Chaykin', '24 Bristol, Gaza, Palestine', '053-8575379');
insert into DONORS (did, dname, address, phonenumber)
values (322973575, 'Seth  Burns', '21 Southampton Road, Fort Lewis, USA', '053-3949007');
insert into DONORS (did, dname, address, phonenumber)
values (322973576, 'Cheech  Kidman', '72 Wilmington Drive, Bristol, United Kingdom', '050-1546957');
insert into DONORS (did, dname, address, phonenumber)
values (322973577, 'Lucinda  Schwimmer', '18 Pepper Blvd, Ann Arbor, USA', '053-2437315');
insert into DONORS (did, dname, address, phonenumber)
values (322973578, 'Emilio  Clarkson', '9 Aglukark Street, El Dorado Hills, USA', '058-7437861');
insert into DONORS (did, dname, address, phonenumber)
values (322973579, 'Isaac  Sampson', '79 Freddy Drive, Maidenhead, United Kingdom', '055-8245507');
insert into DONORS (did, dname, address, phonenumber)
values (322973580, 'Miranda  Donovan', '63 Hiller�d Street, Tilburg, Netherlands', '054-3554031');
insert into DONORS (did, dname, address, phonenumber)
values (322973581, 'Brittany  Beatty', '15 Connelly Street, Stone Mountain, USA', '054-4677393');
insert into DONORS (did, dname, address, phonenumber)
values (322973582, 'Charlie  McGill', '49 Oklahoma city Road, Carlin, USA', '055-4347984');
insert into DONORS (did, dname, address, phonenumber)
values (322973583, 'Nelly  Benson', '5 Redgrave Street, Palma de Mallorca, Spain', '057-9837897');
insert into DONORS (did, dname, address, phonenumber)
values (322973584, 'Malcolm  Diddley', '37 Lucien Road, Chennai, India', '057-8446180');
insert into DONORS (did, dname, address, phonenumber)
values (322973585, 'Lee  Mortensen', '58 Marsden Road, Buenos Aires, Argentina', '059-6544820');
insert into DONORS (did, dname, address, phonenumber)
values (322973586, 'Jack  Ledger', '23 Mariano Comense Blvd, Gen�ve, Switzerland', '052-8778816');
insert into DONORS (did, dname, address, phonenumber)
values (322973587, 'Rich  Sweet', '42 Shelton Street, Perth, Australia', '055-9060325');
insert into DONORS (did, dname, address, phonenumber)
values (322973588, 'Adam  Coverdale', '19 North Yorkshire Ave, Takamatsu, Japan', '052-8438273');
insert into DONORS (did, dname, address, phonenumber)
values (322973589, 'Arnold  Heron', '98 Ritchie Road, Hong Kong, Hong Kong', '055-3591417');
insert into DONORS (did, dname, address, phonenumber)
values (322973590, 'Carole  Pride', '12nd Street, Bonn, Germany', '059-7651709');
insert into DONORS (did, dname, address, phonenumber)
values (322973591, 'Neneh  MacPherson', '912 Brad Drive, Rocklin, USA', '056-7603047');
insert into DONORS (did, dname, address, phonenumber)
values (322973592, 'Ashton  Presley', '16 Bonnie, Heubach, Germany', '051-8823798');
insert into DONORS (did, dname, address, phonenumber)
values (322973593, 'Ivan  Hunter', '78 Gordon Road, Thalwil, Switzerland', '050-9592931');
insert into DONORS (did, dname, address, phonenumber)
values (322973594, 'Maureen  Giannini', '41 Vondie Drive, Telford, United Kingdom', '056-9204956');
insert into DONORS (did, dname, address, phonenumber)
values (322973595, 'Cornell  Twilley', '57 Rizzo Road, Singapore, Singapore', '056-6532818');
insert into DONORS (did, dname, address, phonenumber)
values (322973596, 'Ronny  Rock', '32 Nikka, Corona, USA', '058-6350889');
insert into DONORS (did, dname, address, phonenumber)
values (322973597, 'Leelee  Wainwright', '61 Yavne Street, Eiksmarka, Norway', '058-9960162');
insert into DONORS (did, dname, address, phonenumber)
values (322973598, 'Nicholas  Cervine', '62nd Street, Chinnor, United Kingdom', '051-8549849');
insert into DONORS (did, dname, address, phonenumber)
values (322973599, 'Ricky  Fichtner', '49 Chesnutt Drive, durham, United Kingdom', '057-3670451');
insert into DONORS (did, dname, address, phonenumber)
values (322973600, 'Maura  Levert', '79 Daryle Road, Ebersdorf, Germany', '053-1315809');
insert into DONORS (did, dname, address, phonenumber)
values (322973601, 'Dwight  Wen', '25 Shaye Road, El Dorado Hills, USA', '051-8651482');
insert into DONORS (did, dname, address, phonenumber)
values (322973602, 'Fred  McDowall', '90 Bergen Road, Reno, USA', '054-9933871');
insert into DONORS (did, dname, address, phonenumber)
values (322973603, 'Geena  Dutton', '89 Judi Street, Potsdam, Germany', '051-3516278');
insert into DONORS (did, dname, address, phonenumber)
values (322973604, 'Sona  Hannah', '690 Giamatti, Sao paulo, Brazil', '058-7348883');
insert into DONORS (did, dname, address, phonenumber)
values (322973605, 'Jeroen  Rosas', '4 Garr Drive, Rtp, USA', '058-8440197');
insert into DONORS (did, dname, address, phonenumber)
values (322973606, 'Jennifer  Barnett', '50 Botti Street, Glasgow, United Kingdom', '052-2532110');
insert into DONORS (did, dname, address, phonenumber)
values (322973607, 'Vern  McGoohan', '28 Middletown Street, Seongnam-si, South Korea', '054-8742947');
insert into DONORS (did, dname, address, phonenumber)
values (322973608, 'Jessica  Mahood', '889 Winwood Road, Paraju, Brazil', '055-1827888');
insert into DONORS (did, dname, address, phonenumber)
values (322973609, 'Hugo  Jonze', '93 W�rth Ave, El Dorado Hills, USA', '052-7373470');
insert into DONORS (did, dname, address, phonenumber)
values (322973610, 'Terence  Favreau', '548 Garth Blvd, Villata, Italy', '058-9608347');
insert into DONORS (did, dname, address, phonenumber)
values (322973611, 'Queen  Fehr', '96 Dunst Street, Aracruz, Brazil', '051-4878775');
insert into DONORS (did, dname, address, phonenumber)
values (322973612, 'Clay  Lachey', '572 Parker Drive, Dunn loring, USA', '056-6997276');
insert into DONORS (did, dname, address, phonenumber)
values (322973613, 'Bridgette  Crimson', '313 Beatty Road, Bloomington, USA', '058-1536604');
insert into DONORS (did, dname, address, phonenumber)
values (322973614, 'Marianne  Santa Rosa', '71st Street, Dublin, USA', '051-7009240');
insert into DONORS (did, dname, address, phonenumber)
values (322973615, 'Stewart  Pullman', '79 Michaels Road, Middleburg Heights, USA', '053-6962352');
insert into DONORS (did, dname, address, phonenumber)
values (322973616, 'Gino  Kershaw', '15 Garland Street, W�rzburg, Germany', '055-2906818');
insert into DONORS (did, dname, address, phonenumber)
values (322973617, 'Nina  Vicious', '12nd Street, San Mateo, USA', '055-4683170');
insert into DONORS (did, dname, address, phonenumber)
values (322973618, 'Carol  Whitman', '39 Potter Street, Treviso, Italy', '051-4120619');
commit;
prompt 300 records committed...
insert into DONORS (did, dname, address, phonenumber)
values (322973619, 'Kyle  Wagner', '10 Chambers Road, Kristiansand, Norway', '050-1190406');
insert into DONORS (did, dname, address, phonenumber)
values (322973620, 'Ian  Goldwyn', '478 Griffiths Blvd, Sundsvall, Sweden', '056-1163854');
insert into DONORS (did, dname, address, phonenumber)
values (322973621, 'Albert  Connick', '25 Heatherly Ave, Caracas, Venezuela', '051-6881085');
insert into DONORS (did, dname, address, phonenumber)
values (322973622, 'Mena  Sartain', '22 Highton Road, Las Vegas, USA', '059-4566856');
insert into DONORS (did, dname, address, phonenumber)
values (322973623, 'Bo  Evans', '10 Dunaway Street, Fort gordon, USA', '051-4081812');
insert into DONORS (did, dname, address, phonenumber)
values (322973624, 'Jody  Michael', '493 Dunn loring Road, Belmont, USA', '053-1807829');
insert into DONORS (did, dname, address, phonenumber)
values (322973625, 'Juliana  Stevens', '30 Knoxville Drive, Nuernberg, Germany', '058-1703834');
insert into DONORS (did, dname, address, phonenumber)
values (322973626, 'Ronny  Mazzello', '94 Shirley Street, Ani�res, Switzerland', '056-3375362');
insert into DONORS (did, dname, address, phonenumber)
values (322973627, 'Alannah  Dunst', '17 Alleroed Road, Redwood Shores, USA', '051-4329414');
insert into DONORS (did, dname, address, phonenumber)
values (322973628, 'Carole  Hewett', '73 Zwolle Road, Colombes, France', '054-3487533');
insert into DONORS (did, dname, address, phonenumber)
values (322973629, 'Seann  Estevez', '47 Hedaya Road, Belp, Switzerland', '052-6342497');
insert into DONORS (did, dname, address, phonenumber)
values (322973630, 'Harriet  Kweller', '83rd Street, Oberwangen, Switzerland', '053-8772070');
insert into DONORS (did, dname, address, phonenumber)
values (322973631, 'Elle  Jovovich', '95 McCain Road, Bratislava, Slovakia', '052-3782843');
insert into DONORS (did, dname, address, phonenumber)
values (322973632, 'Marianne  McCann', '93 Brisbane Street, Paraju, Brazil', '057-6559212');
insert into DONORS (did, dname, address, phonenumber)
values (322973633, 'Annie  Bryson', '84 Sale Street, Libertyville, USA', '051-1764003');
insert into DONORS (did, dname, address, phonenumber)
values (322973634, 'Rascal  Guzman', '27 Rtp Ave, Long Island City, USA', '058-2165385');
insert into DONORS (did, dname, address, phonenumber)
values (322973635, 'Maxine  Hobson', '95 Miki Ave, Coppell, USA', '052-4938723');
insert into DONORS (did, dname, address, phonenumber)
values (322973636, 'Dorry  Walsh', '82 Kinney Road, Burlington, USA', '057-9411435');
insert into DONORS (did, dname, address, phonenumber)
values (322973637, 'Thora  Soul', '14 Dunn Street, Chemnitz, Germany', '058-5738925');
insert into DONORS (did, dname, address, phonenumber)
values (322973638, 'Laura  Sandoval', '42 Witherspoon Street, Wageningen, Netherlands', '054-7225702');
insert into DONORS (did, dname, address, phonenumber)
values (322973639, 'Shannyn  Weber', '10 Stuttgart Road, Ulsteinvik, Norway', '058-1386029');
insert into DONORS (did, dname, address, phonenumber)
values (322973640, 'Sissy  Ford', '52 Palma de Mallorca Street, Udine, Italy', '056-4219929');
insert into DONORS (did, dname, address, phonenumber)
values (322973641, 'Sam  Guzman', '16 Epps Road, Farmington Hills, USA', '058-8614691');
insert into DONORS (did, dname, address, phonenumber)
values (322973642, 'Julie  Lane', '290 Napolitano Street, Fairbanks, USA', '056-2865968');
insert into DONORS (did, dname, address, phonenumber)
values (322973643, 'Warren  Gray', '74 Ike Street, Tampa, USA', '059-5647212');
insert into DONORS (did, dname, address, phonenumber)
values (322973644, 'Whoopi  Holmes', '100 Ferraz  vasconcelos Street, Bloomington, USA', '059-6979419');
insert into DONORS (did, dname, address, phonenumber)
values (322973645, 'Emm  DeVita', '71 Horsens Street, Longueuil, Canada', '053-6548088');
insert into DONORS (did, dname, address, phonenumber)
values (322973646, 'Gene  Marie', '59 Krabbe, Adelaide, Australia', '050-4015599');
insert into DONORS (did, dname, address, phonenumber)
values (322973647, 'Chubby  Lucien', '179 Eugene Street, Braintree, United Kingdom', '055-7964618');
insert into DONORS (did, dname, address, phonenumber)
values (322973648, 'Kurtwood  Rain', '11 Lois, Stavanger, Norway', '056-6256808');
insert into DONORS (did, dname, address, phonenumber)
values (322973649, 'Albert  Peniston', '728 Warley Road, Saudarkrokur, Iceland', '058-3329749');
insert into DONORS (did, dname, address, phonenumber)
values (322973650, 'Tony  Davies', '70 Hawn Road, Chennai, India', '059-5391261');
insert into DONORS (did, dname, address, phonenumber)
values (322973651, 'Meryl  Ripley', '97 Natascha Road, Cuenca, Ecuador', '059-9023373');
insert into DONORS (did, dname, address, phonenumber)
values (322973652, 'Alfred  Lithgow', '69 Fiennes Street, Rozenburg, Netherlands', '058-6421988');
insert into DONORS (did, dname, address, phonenumber)
values (322973653, 'Hex  Delta', '14 Queen Drive, Coimbra, Portugal', '050-9481796');
insert into DONORS (did, dname, address, phonenumber)
values (322973654, 'Scott  Rock', '46 Stone Street, Albany, USA', '050-1333050');
insert into DONORS (did, dname, address, phonenumber)
values (322973655, 'Roy  Witt', '53 Darren Drive, Arlington, USA', '059-2631094');
insert into DONORS (did, dname, address, phonenumber)
values (322973656, 'Kid  Allan', '32nd Street, Burlington, Canada', '059-5305062');
insert into DONORS (did, dname, address, phonenumber)
values (322973657, 'Tcheky  Reinhold', '201 North Yorkshire Road, Rueil-Malmaison, France', '056-9596733');
insert into DONORS (did, dname, address, phonenumber)
values (322973658, 'Jaime  Rickman', '83 Moorestown Road, Veenendaal, Netherlands', '051-9887004');
insert into DONORS (did, dname, address, phonenumber)
values (322973659, 'Celia  Winger', '58 Charlie Road, Kwun Tong, Hong Kong', '058-7786988');
insert into DONORS (did, dname, address, phonenumber)
values (322973660, 'Mary Beth  Gray', '89 Milpitas Street, Jakarta, Indonesia', '052-9175249');
insert into DONORS (did, dname, address, phonenumber)
values (322973661, 'Liquid  Phoenix', '95 Alexander Blvd, Mogliano Veneto, Italy', '056-9007862');
insert into DONORS (did, dname, address, phonenumber)
values (322973662, 'Omar  McDonald', '59 Bham Blvd, Sao paulo, Brazil', '054-2317677');
insert into DONORS (did, dname, address, phonenumber)
values (322973663, 'Jesse  Farrow', '50 England Street, Bischofshofen, Austria', '052-2664346');
insert into DONORS (did, dname, address, phonenumber)
values (322973664, 'Jill  Hawthorne', '76 Warwick Ave, Athens, Greece', '052-3429481');
insert into DONORS (did, dname, address, phonenumber)
values (322973665, 'Dwight  Stewart', '65 Dzundza Street, O''fallon, USA', '054-3114291');
insert into DONORS (did, dname, address, phonenumber)
values (322973666, 'Julie  Westerberg', '13rd Street, Chaam, Netherlands', '055-7892049');
insert into DONORS (did, dname, address, phonenumber)
values (322973667, 'Forest  Caan', '350 Burmester, Framingham, USA', '059-3066315');
insert into DONORS (did, dname, address, phonenumber)
values (322973668, 'Courtney  Marin', '8 Auckland Blvd, Yucca, USA', '051-4515119');
insert into DONORS (did, dname, address, phonenumber)
values (322973669, 'Pelvic  Gaynor', '581 Hohenfels Drive, Burlington, Canada', '053-7882401');
insert into DONORS (did, dname, address, phonenumber)
values (322973670, 'Clea  Kristofferson', '42 Mifune Road, Paderborn, Germany', '052-5703720');
insert into DONORS (did, dname, address, phonenumber)
values (322973671, 'Liquid  Warden', '470 Whitaker Road, West Chester, USA', '050-6844566');
insert into DONORS (did, dname, address, phonenumber)
values (322973672, 'Brenda  Matthau', '20 Edward Road, Maebashi, Japan', '051-6720825');
insert into DONORS (did, dname, address, phonenumber)
values (322973673, 'Temuera  Krumholtz', '26 Will Street, Protvino, Russia', '051-5981671');
insert into DONORS (did, dname, address, phonenumber)
values (322973674, 'Phoebe  Isaacs', '42nd Street, Casselberry, USA', '054-9322365');
insert into DONORS (did, dname, address, phonenumber)
values (322973675, 'Nik  Summer', '7 Montr�al Street, Athens, Greece', '058-5631667');
insert into DONORS (did, dname, address, phonenumber)
values (322973676, 'Coley  D''Onofrio', '82nd Street, Lake Bluff, USA', '058-6955288');
insert into DONORS (did, dname, address, phonenumber)
values (322973677, 'Anne  Postlethwaite', '657 Hidalgo Blvd, Johor Bahru, Malaysia', '059-8408257');
insert into DONORS (did, dname, address, phonenumber)
values (322973678, 'Alan  Adler', '46 Witt Street, Oak park, USA', '056-5159179');
insert into DONORS (did, dname, address, phonenumber)
values (322973679, 'Brendan  Parish', '25 Pearce Drive, Peine, Germany', '050-7203758');
insert into DONORS (did, dname, address, phonenumber)
values (322973680, 'Linda  Rain', '103 Gliwice Drive, Holderbank, Switzerland', '050-8846969');
insert into DONORS (did, dname, address, phonenumber)
values (322973681, 'Murray  Plummer', '89 Oshkosh Ave, Pointe-claire, Canada', '058-8679771');
insert into DONORS (did, dname, address, phonenumber)
values (322973682, 'Tea  Eckhart', '46 Schaumburg Street, Battle Creek, USA', '053-6866955');
insert into DONORS (did, dname, address, phonenumber)
values (322973683, 'Debra  Charles', '94 Thurman Street, Calgary, Canada', '057-6881430');
insert into DONORS (did, dname, address, phonenumber)
values (322973684, 'Dabney  Witherspoon', '77 Rourke Drive, Pompeia, Brazil', '050-8978195');
insert into DONORS (did, dname, address, phonenumber)
values (322973685, 'Stephanie  Bedelia', '81st Street, Austin, USA', '058-2015284');
insert into DONORS (did, dname, address, phonenumber)
values (322973686, 'Daryl  Rivers', '98 Cedar Park Street, Eiksmarka, Norway', '055-5548132');
insert into DONORS (did, dname, address, phonenumber)
values (322973687, 'Janeane  Borgnine', '23 Doug Ave, Fredericia, Denmark', '053-6735101');
insert into DONORS (did, dname, address, phonenumber)
values (322973688, 'Marianne  Dayne', '836 Mountain View Street, Koblenz, Germany', '053-6058316');
insert into DONORS (did, dname, address, phonenumber)
values (322973689, 'Elizabeth  Borgnine', '293 Berkoff Street, Stellenbosch, South Africa', '052-9121264');
insert into DONORS (did, dname, address, phonenumber)
values (322973690, 'Rachel  Patillo', '39 McDonald Street, Oulu, Finland', '053-5525743');
insert into DONORS (did, dname, address, phonenumber)
values (322973691, 'Gino  Nolte', '50 Loggins Ave, Cle Elum, USA', '056-7808468');
insert into DONORS (did, dname, address, phonenumber)
values (322973692, 'Marie  Rhodes', '31 Hunter Road, Kongserbg, Norway', '057-3319893');
insert into DONORS (did, dname, address, phonenumber)
values (322973693, 'Tea  Dalton', '150 Yorn Street, Turku, Finland', '059-9144040');
insert into DONORS (did, dname, address, phonenumber)
values (322973694, 'Lydia  Carr', '50 DeGraw Road, Caguas, USA', '056-6303182');
insert into DONORS (did, dname, address, phonenumber)
values (322973695, 'Sara  Barrymore', '46 Laurie Road, Flushing, USA', '059-9532349');
insert into DONORS (did, dname, address, phonenumber)
values (322973696, 'Lois  Rankin', '367 Gerald Blvd, Dublin, USA', '050-6248692');
insert into DONORS (did, dname, address, phonenumber)
values (322973697, 'Darius  Christie', '35 Trace, Lublin, Poland', '052-7389935');
insert into DONORS (did, dname, address, phonenumber)
values (322973698, 'Nastassja  Davis', '412 Elliott, Paraju, Brazil', '058-1529803');
insert into DONORS (did, dname, address, phonenumber)
values (322973699, 'Jennifer  Roth', '61st Street, Bedford, USA', '050-6722244');
insert into DONORS (did, dname, address, phonenumber)
values (322973700, 'Karen  Weber', '25 Eileen Ave, Pittsburgh, USA', '053-2719005');
insert into DONORS (did, dname, address, phonenumber)
values (322973701, 'Daryl  Pride', '53 Canal Winchester Street, Cerritos, USA', '059-3207774');
insert into DONORS (did, dname, address, phonenumber)
values (322973702, 'Chad  Beckinsale', '61 M�nster Ave, Zwolle, Netherlands', '056-6399013');
insert into DONORS (did, dname, address, phonenumber)
values (322973703, 'Tal  Carradine', '59 Hershey Street, Spresiano, Italy', '053-3390097');
insert into DONORS (did, dname, address, phonenumber)
values (322973704, 'Dan  Garcia', '6 New York City Drive, Manchester, United Kingdom', '050-8579650');
insert into DONORS (did, dname, address, phonenumber)
values (322973705, 'Eileen  Nelson', '8 Oldwick Blvd, Ribeirao preto, Brazil', '051-3803376');
insert into DONORS (did, dname, address, phonenumber)
values (322973706, 'Art  Easton', '15 Albert Blvd, Princeton, USA', '052-2427204');
insert into DONORS (did, dname, address, phonenumber)
values (322973707, 'Denny  Romijn-Stamos', '29 DiBiasio Road, Bad Oeynhausen, Germany', '051-6790972');
insert into DONORS (did, dname, address, phonenumber)
values (322973708, 'Rawlins  Berenger', '90 Oxford Street, Silverdale, USA', '052-3329884');
insert into DONORS (did, dname, address, phonenumber)
values (322973709, 'Don  Rispoli', '833 Spencer Road, Hyderabad, India', '050-9865940');
insert into DONORS (did, dname, address, phonenumber)
values (322973710, 'Janice  Kelly', '29 Morgan Road, Leimen, Germany', '059-9285870');
insert into DONORS (did, dname, address, phonenumber)
values (322973711, 'Gavin  Linney', '37 Crosby Street, Taipei, Taiwan', '059-6485207');
insert into DONORS (did, dname, address, phonenumber)
values (322973712, 'Laura  Coolidge', '890 Vickie Street, Pomona, USA', '059-6201822');
insert into DONORS (did, dname, address, phonenumber)
values (322973713, 'Jeff  Alexander', '23 Andre, Gen�ve, Switzerland', '056-2715591');
insert into DONORS (did, dname, address, phonenumber)
values (322973714, 'Juan  Jessee', '18 Carrere Street, West Lafayette, USA', '053-6896603');
insert into DONORS (did, dname, address, phonenumber)
values (322973715, 'Alec  Bradford', '27 Gran Street, Lummen, Belgium', '050-3776774');
insert into DONORS (did, dname, address, phonenumber)
values (322973716, 'Vern  Downie', '71 Nelligan Ave, Draper, USA', '059-8666457');
insert into DONORS (did, dname, address, phonenumber)
values (322973717, 'Carolyn  Laws', '35 Ruffalo Road, Richardson, USA', '056-4818726');
insert into DONORS (did, dname, address, phonenumber)
values (322973718, 'Corey  Dushku', '55 Curfman Drive, Bangalore, India', '054-8408245');
commit;
prompt 400 records committed...
insert into DONORS (did, dname, address, phonenumber)
values (322973719, 'Rob  Rains', '38 Wright Blvd, Bernex, Switzerland', '054-8311275');
insert into DONORS (did, dname, address, phonenumber)
values (322973720, 'Kenny  May', '705 Famke Drive, Turku, Finland', '052-7641268');
insert into DONORS (did, dname, address, phonenumber)
values (322973721, 'Veruca  Hauser', '848 Merrill Drive, Kopavogur, Iceland', '055-1284548');
insert into DONORS (did, dname, address, phonenumber)
values (322973722, 'Ceili  Swayze', '62 Santa Cruz Blvd, Noumea, New Caledonia', '053-1982814');
insert into DONORS (did, dname, address, phonenumber)
values (322973723, 'Beverley  Loggia', '719 Mewes Road, Waltham, USA', '056-6650740');
insert into DONORS (did, dname, address, phonenumber)
values (322973724, 'Karon  Spacek', '84 Banbury Road, Carlingford, Australia', '054-7714704');
insert into DONORS (did, dname, address, phonenumber)
values (322973725, 'Glen  Stone', '92 Denny Drive, Los Angeles, USA', '050-9536589');
insert into DONORS (did, dname, address, phonenumber)
values (322973726, 'Isabella  Avalon', '53 Burstyn, Wavre, Belgium', '055-7945320');
insert into DONORS (did, dname, address, phonenumber)
values (322973727, 'Cornell  Blige', '65 Brossard Street, Timonium, USA', '055-7889462');
insert into DONORS (did, dname, address, phonenumber)
values (322973728, 'Bill  Sainte-Marie', '83 Kathleen Drive, Tlalpan, Mexico', '055-3310330');
insert into DONORS (did, dname, address, phonenumber)
values (322973729, 'Rolando  Hawkins', '22nd Street, Ilmenau, Germany', '059-6847085');
insert into DONORS (did, dname, address, phonenumber)
values (322973730, 'Brent  Pastore', '26 Ermey Street, Manchester, United Kingdom', '058-7008868');
insert into DONORS (did, dname, address, phonenumber)
values (322973731, 'Larnelle  Sylvian', '588 Orleans Ave, Hochwald, Switzerland', '058-8418285');
insert into DONORS (did, dname, address, phonenumber)
values (322973732, 'Cornell  Wills', '229 Madison, Springfield, Australia', '050-9160102');
insert into DONORS (did, dname, address, phonenumber)
values (322973733, 'Joaquim  Coughlan', '41 Carnes Drive, Jerusalem, Israel', '053-3396043');
insert into DONORS (did, dname, address, phonenumber)
values (322973734, 'Edward  Raitt', '42nd Street, Lake Forest, USA', '059-1538902');
insert into DONORS (did, dname, address, phonenumber)
values (322973735, 'Veruca  Heston', '93rd Street, El Masnou, Spain', '058-5468617');
insert into DONORS (did, dname, address, phonenumber)
values (322973736, 'Eugene  Murdock', '756 Holbrook Road, Brookfield, USA', '056-5081260');
insert into DONORS (did, dname, address, phonenumber)
values (322973737, 'Coley  Carter', '119 Zuerich, Holderbank, Switzerland', '057-3162176');
insert into DONORS (did, dname, address, phonenumber)
values (322973738, 'Suzy  Biel', '42 McClinton Road, Frederiksberg, Denmark', '052-2447271');
insert into DONORS (did, dname, address, phonenumber)
values (322973739, 'Cuba  Chandler', '2 Chandler Road, Belmont, USA', '053-3555880');
insert into DONORS (did, dname, address, phonenumber)
values (322973740, 'Marc  Holy', '30 Caan Road, Rome, USA', '058-8349711');
insert into DONORS (did, dname, address, phonenumber)
values (322973741, 'Deborah  Sweeney', '62 Squier Street, Annandale, USA', '050-3386332');
insert into DONORS (did, dname, address, phonenumber)
values (322973742, 'Gary  Rain', '1 Rome Drive, Sursee, Switzerland', '054-7361974');
insert into DONORS (did, dname, address, phonenumber)
values (322973743, 'Gates  Tisdale', '86 Levin Street, Mobile, USA', '057-4586219');
insert into DONORS (did, dname, address, phonenumber)
values (322973744, 'Rodney  Deejay', '11 Arjona Road, Houston, USA', '057-4396935');
insert into DONORS (did, dname, address, phonenumber)
values (322973745, 'Garry  Favreau', '62 Mueller-Stahl, Lake Bluff, USA', '050-5153379');
insert into DONORS (did, dname, address, phonenumber)
values (322973746, 'Brothers  Mulroney', '23 Barnegat Road, Luedenscheid, Germany', '056-6839392');
insert into DONORS (did, dname, address, phonenumber)
values (322973747, 'Alex  Griggs', '99 Palminteri Street, Chapeco, Brazil', '055-5709779');
insert into DONORS (did, dname, address, phonenumber)
values (322973748, 'Hugh  Matthau', '10 Lois Street, Birmingham, USA', '058-8778848');
insert into DONORS (did, dname, address, phonenumber)
values (322973749, 'Maxine  Zane', '15 Caracas Ave, Regensburg, Germany', '059-6834656');
insert into DONORS (did, dname, address, phonenumber)
values (322973750, 'Walter  Lachey', '92 Newnan Street, Boucherville, Canada', '059-9360865');
insert into DONORS (did, dname, address, phonenumber)
values (322973751, 'Neil  Morales', '490 Kiefer Road, Storrington, United Kingdom', '052-9632089');
insert into DONORS (did, dname, address, phonenumber)
values (322973752, 'Sissy  Galecki', '46 Frakes Blvd, Herzogenrath, Germany', '057-7149402');
insert into DONORS (did, dname, address, phonenumber)
values (322973753, 'Wallace  Hawke', '1 Orlando Road, Altamonte Springs, USA', '059-8212230');
insert into DONORS (did, dname, address, phonenumber)
values (322973754, 'Gailard  Del Toro', '58 Grand Rapids Street, West Windsor, USA', '052-6913598');
insert into DONORS (did, dname, address, phonenumber)
values (322973755, 'Goldie  Hatfield', '9 Sylvester Road, Lathrop, USA', '051-3346895');
insert into DONORS (did, dname, address, phonenumber)
values (322973756, 'Art  Gugino', '102 Ray Blvd, Treviso, Italy', '055-2352602');
insert into DONORS (did, dname, address, phonenumber)
values (322973757, 'Shannon  Coleman', '24 Kershaw Blvd, Meppel, Netherlands', '054-3145966');
insert into DONORS (did, dname, address, phonenumber)
values (322973758, 'Rosanne  Magnuson', '18 Curtis Road, Lake Bluff, USA', '055-5757396');
insert into DONORS (did, dname, address, phonenumber)
values (322973759, 'Udo  Callow', '18 Wright Road, Seattle, USA', '056-9179762');
insert into DONORS (did, dname, address, phonenumber)
values (322973760, 'Lila  Rauhofer', '11 Lopez Blvd, Belp, Switzerland', '058-6939280');
insert into DONORS (did, dname, address, phonenumber)
values (322973761, 'Toshiro  Flanagan', '657 Sorvino Drive, Johannesburg, South Africa', '059-7118597');
insert into DONORS (did, dname, address, phonenumber)
values (322973762, 'Val  Tomei', '2 Stigers Ave, Marburg, Germany', '059-3152665');
insert into DONORS (did, dname, address, phonenumber)
values (322973763, 'Ice  Loeb', '915 Graham Street, Ebersdorf, Germany', '057-3240785');
insert into DONORS (did, dname, address, phonenumber)
values (322973764, 'Elvis  Day', '11 Irving Street, Las Vegas, USA', '052-6769237');
insert into DONORS (did, dname, address, phonenumber)
values (322973765, 'Ellen  Sampson', '78 Jason Drive, Paris, France', '052-8182881');
insert into DONORS (did, dname, address, phonenumber)
values (322973766, 'Garland  Winter', '20 Rapaport Road, Fairbanks, USA', '058-1495300');
insert into DONORS (did, dname, address, phonenumber)
values (322973767, 'Liev  Palmieri', '900 Ponty Road, Vilafranca Penedes, Spain', '053-6394088');
insert into DONORS (did, dname, address, phonenumber)
values (322973768, 'Jimmie  Brandt', '99 Lou, Fredericia, Denmark', '056-4517296');
insert into DONORS (did, dname, address, phonenumber)
values (322973769, 'Trace  Goodman', '100 Longueuil Street, Shreveport, USA', '058-9390798');
insert into DONORS (did, dname, address, phonenumber)
values (322973770, 'Dennis  Caan', '59 Courbevoie Ave, Dalmine, Italy', '053-6254310');
insert into DONORS (did, dname, address, phonenumber)
values (322973771, 'Dave  Lawrence', '56 Sellers Drive, Hayward, USA', '056-3121204');
insert into DONORS (did, dname, address, phonenumber)
values (322973772, 'Azucar  Studi', '53rd Street, Scottsdale, USA', '058-9754106');
insert into DONORS (did, dname, address, phonenumber)
values (322973773, 'Sean  Bright', '1 Boulogne Road, Seongnam-si, South Korea', '054-5502912');
insert into DONORS (did, dname, address, phonenumber)
values (322973774, 'Sam  Hatfield', '96 Lloyd Road, Milton Keynes, United Kingdom', '051-2539755');
insert into DONORS (did, dname, address, phonenumber)
values (322973775, 'Adam  Stills', '43 Glasgow Road, Los Angeles, USA', '059-8435849');
insert into DONORS (did, dname, address, phonenumber)
values (322973776, 'Vin  Brock', '65 Blige Road, Szazhalombatta, Hungary', '051-2958000');
insert into DONORS (did, dname, address, phonenumber)
values (322973777, 'Ron  Sepulveda', '703 Granada Hills Drive, Tadley, United Kingdom', '051-6033507');
insert into DONORS (did, dname, address, phonenumber)
values (322973778, 'Woody  Stigers', '48 Hedaya Road, Waterloo, Canada', '052-8412796');
insert into DONORS (did, dname, address, phonenumber)
values (322973779, 'Franz  Mathis', '52 Almond Street, Pompton Plains, USA', '055-1117563');
insert into DONORS (did, dname, address, phonenumber)
values (322973780, 'Debra  Levin', '99 Frampton Drive, Koppl, Austria', '057-4814392');
insert into DONORS (did, dname, address, phonenumber)
values (322973781, 'Alec  Oszajca', '76 von Sydow Blvd, Kopavogur, Iceland', '051-9355524');
insert into DONORS (did, dname, address, phonenumber)
values (322973782, 'Moe  McIntosh', '94 Dabney Drive, Portsmouth, USA', '057-6329318');
insert into DONORS (did, dname, address, phonenumber)
values (322973783, 'Nik  Cochran', '76 Gilley, Woodbridge, USA', '054-3521766');
insert into DONORS (did, dname, address, phonenumber)
values (322973784, 'Rueben  Lindo', '91 Nara Road, Plymouth Meeting, USA', '057-7868462');
insert into DONORS (did, dname, address, phonenumber)
values (322973785, 'Annette  Whitaker', '73 Belles Drive, Park Ridge, USA', '058-5729535');
insert into DONORS (did, dname, address, phonenumber)
values (322973786, 'Tyrone  O''Neill', '28 Ohtsu Street, Dubai, UAE', '053-6105214');
insert into DONORS (did, dname, address, phonenumber)
values (322973787, 'Carlene  Twilley', '75 Beaverton Road, Herzogenrath, Germany', '057-1999268');
insert into DONORS (did, dname, address, phonenumber)
values (322973788, 'Shannyn  McGregor', '46 Larenz Drive, Telford, United Kingdom', '057-1839874');
insert into DONORS (did, dname, address, phonenumber)
values (322973789, 'Mika  Gandolfini', '64 Barry Drive, Utrecht, Netherlands', '051-1909451');
insert into DONORS (did, dname, address, phonenumber)
values (322973790, 'Gladys  Gayle', '63 Gilliam Road, Yokohama, Japan', '058-6930132');
insert into DONORS (did, dname, address, phonenumber)
values (322973791, 'Don  Negbaur', '23 Denis Blvd, Kozani, Greece', '050-1283519');
insert into DONORS (did, dname, address, phonenumber)
values (322973792, 'Colleen  Spine', '1 Nils Road, Milano, Italy', '051-9429605');
insert into DONORS (did, dname, address, phonenumber)
values (322973793, 'Chubby  Thornton', '37 Crow Road, Guadalajara, Mexico', '050-8101857');
insert into DONORS (did, dname, address, phonenumber)
values (322973794, 'Howard  Blades', '85 Buddy Ave, Ljubljana, Slovenia', '054-2421843');
insert into DONORS (did, dname, address, phonenumber)
values (322973795, 'Kasey  Arjona', '44 Senior Street, Nagasaki, Japan', '052-5538942');
insert into DONORS (did, dname, address, phonenumber)
values (322973796, 'Halle  Kotto', '43 Diaz Street, Lima, Peru', '051-6579236');
insert into DONORS (did, dname, address, phonenumber)
values (322973797, 'Angela  Holly', '262 Wehrheim Road, Berlin, Germany', '050-8555608');
insert into DONORS (did, dname, address, phonenumber)
values (322973798, 'Alice  Redford', '70 Zaandam Road, Stockholm, Sweden', '051-2780967');
insert into DONORS (did, dname, address, phonenumber)
values (322973799, 'Dustin  Doucette', '100 Archer Drive, Market Harborough, United Kingdom', '053-2378391');
insert into DONORS (did, dname, address, phonenumber)
values (322973800, 'Celia  Morrison', '27 Santorso, Stone Mountain, USA', '059-2839542');
insert into DONORS (did, dname, address, phonenumber)
values (322973801, 'Rosanne  Walker', '49 Adina Street, Uden, Netherlands', '054-2068606');
insert into DONORS (did, dname, address, phonenumber)
values (322973802, 'Fisher  Gagnon', '56 Rivers Road, Cedar Rapids, USA', '051-4223571');
insert into DONORS (did, dname, address, phonenumber)
values (322973803, 'Juan  Spader', '6 Wakeling Blvd, Aracruz, Brazil', '053-9673634');
insert into DONORS (did, dname, address, phonenumber)
values (322973804, 'Bret  Purefoy', '55 Everett Road, New Hope, USA', '056-1975599');
insert into DONORS (did, dname, address, phonenumber)
values (322973805, 'Owen  Parm', '531 Allen Drive, Saint Paul, USA', '053-6677196');
insert into DONORS (did, dname, address, phonenumber)
values (322973806, 'Alice  Osborne', '19 Raye Blvd, Kaohsiung, China', '052-5276289');
insert into DONORS (did, dname, address, phonenumber)
values (322973807, 'Joey  Connelly', '11st Street, Velizy Villacoublay, France', '053-4600920');
insert into DONORS (did, dname, address, phonenumber)
values (322973808, 'CeCe  Pride', '635 Renee Road, Steyr, Austria', '059-8935981');
insert into DONORS (did, dname, address, phonenumber)
values (322973809, 'Sara  Connery', '27 Biel Road, Spring City, USA', '053-4278393');
insert into DONORS (did, dname, address, phonenumber)
values (322973810, 'Lindsay  Emmett', '94 Golden Drive, Juazeiro, Brazil', '050-2646735');
insert into DONORS (did, dname, address, phonenumber)
values (322973811, 'Johnnie  Bachman', '30 Cobham Road, Fort gordon, USA', '051-7136417');
insert into DONORS (did, dname, address, phonenumber)
values (322973812, 'Juice  Patillo', '19 Perry Road, West Windsor, USA', '057-3019391');
insert into DONORS (did, dname, address, phonenumber)
values (322973813, 'Ty  Downie', '87 Tierney Street, Ulm, Germany', '055-7629617');
insert into DONORS (did, dname, address, phonenumber)
values (322973814, 'Elizabeth  Carrey', '76 Tucci Street, Crete, USA', '055-6988344');
insert into DONORS (did, dname, address, phonenumber)
values (322973815, 'Brent  Holly', '56 George Street, Essex, United Kingdom', '058-5840058');
insert into DONORS (did, dname, address, phonenumber)
values (322973816, 'Malcolm  Benoit', '31 Lupe Road, Horsham, United Kingdom', '058-3216905');
insert into DONORS (did, dname, address, phonenumber)
values (322973817, 'Rachid  Lipnicki', '605 Carlton Blvd, Harahan, USA', '056-9503186');
insert into DONORS (did, dname, address, phonenumber)
values (322973818, 'Jennifer  Mraz', '30 Gailard Street, Bautzen, Germany', '053-4430866');
commit;
prompt 500 records committed...
insert into DONORS (did, dname, address, phonenumber)
values (322973819, 'Janeane  Eat World', '832 Torino Drive, Okayama, Japan', '058-3617569');
insert into DONORS (did, dname, address, phonenumber)
values (322973820, 'Nikka  Stuart', '36 McDormand Road, San Mateo, USA', '058-8791417');
insert into DONORS (did, dname, address, phonenumber)
values (322973821, 'Tea  Kutcher', '68 Tucson Ave, Ulm, Germany', '058-1915900');
insert into DONORS (did, dname, address, phonenumber)
values (322973822, 'Christmas  Prowse', '71 Patricia Drive, Bergen, Denmark', '059-9195691');
insert into DONORS (did, dname, address, phonenumber)
values (322973823, 'Nile  Foley', '43rd Street, Dublin, USA', '058-5187056');
insert into DONORS (did, dname, address, phonenumber)
values (322973824, 'Kazem  Gallant', '220 Indianapolis Road, Braintree, United Kingdom', '050-6694246');
insert into DONORS (did, dname, address, phonenumber)
values (322973825, 'Benjamin  Paul', '873 Lincoln Street, Bellevue, USA', '050-5988926');
insert into DONORS (did, dname, address, phonenumber)
values (322973826, 'Nastassja  Fierstein', '97 Makowicz Street, Cesena, Italy', '056-3894922');
insert into DONORS (did, dname, address, phonenumber)
values (322973827, 'Kathy  Mitchell', '961 Angelina Ave, Tooele, USA', '058-6416633');
insert into DONORS (did, dname, address, phonenumber)
values (322973828, 'Lucinda  Fisher', '4 Boone Street, Karachi, Pakistan', '057-5586413');
insert into DONORS (did, dname, address, phonenumber)
values (322973829, 'Ron  Perrineau', '2 Daryl Road, Huntington Beach, USA', '056-2065887');
insert into DONORS (did, dname, address, phonenumber)
values (322973830, 'Josh  Roth', '325 Encinitas Blvd, Salt Lake City, USA', '058-3116473');
insert into DONORS (did, dname, address, phonenumber)
values (322973831, 'Sissy  Steenburgen', '100 Romijn-Stamos, Pusan-city, South Korea', '053-3615310');
insert into DONORS (did, dname, address, phonenumber)
values (322973832, 'Kevin  Rickman', '91 Roddy Road, Lakeville, USA', '051-7551294');
insert into DONORS (did, dname, address, phonenumber)
values (322973833, 'Charlie  Tilly', '52nd Street, Dunn loring, USA', '056-8516261');
insert into DONORS (did, dname, address, phonenumber)
values (322973834, 'Sander  Chinlund', '58 Rockville Street, Houma, USA', '059-5650936');
insert into DONORS (did, dname, address, phonenumber)
values (322973835, 'Bret  Wincott', '26 Cagle Street, Jakarta, Indonesia', '052-6348077');
insert into DONORS (did, dname, address, phonenumber)
values (322973836, 'Ice  Hawn', '35 Nick Road, Burlington, USA', '059-3338337');
insert into DONORS (did, dname, address, phonenumber)
values (322973837, 'Fairuza  Akins', '44 Fort Saskatchewan Drive, Boulogne, France', '054-7177273');
insert into DONORS (did, dname, address, phonenumber)
values (322973838, 'Patricia  Nunn', '39 Donovan Road, Yamaguchi, Japan', '059-8164915');
insert into DONORS (did, dname, address, phonenumber)
values (322973839, 'Hugh  Adler', '92nd Street, Aiken, USA', '052-6037386');
insert into DONORS (did, dname, address, phonenumber)
values (322973840, 'Hilary  Street', '992 Jane Ave, Bolton, Canada', '054-9643752');
insert into DONORS (did, dname, address, phonenumber)
values (322973841, 'Nathan  Bright', '40 Channing Road, San Francisco, USA', '055-4770588');
insert into DONORS (did, dname, address, phonenumber)
values (322973842, 'Andre  Sartain', '88 Levin Street, Denver, USA', '058-2654734');
insert into DONORS (did, dname, address, phonenumber)
values (322973843, 'Jaime  Heslov', '22 Cathy, Lubbock, USA', '054-2262724');
insert into DONORS (did, dname, address, phonenumber)
values (322973844, 'Sandra  Shepherd', '23rd Street, Bergara, Spain', '052-3880142');
insert into DONORS (did, dname, address, phonenumber)
values (322973845, 'Holly  Tate', '43 Abbotsford Road, Birmingham, USA', '057-2411980');
insert into DONORS (did, dname, address, phonenumber)
values (322973846, 'Andrae  Deejay', '71 Aurora Road, Oak park, USA', '054-9175904');
insert into DONORS (did, dname, address, phonenumber)
values (322973847, 'Brenda  Franks', '9 Murphy Street, Araras, Brazil', '057-2097599');
insert into DONORS (did, dname, address, phonenumber)
values (322973848, 'Sheryl  Connick', '6 Liam Blvd, Mason, USA', '057-5608328');
insert into DONORS (did, dname, address, phonenumber)
values (322973849, 'Don  Unger', '32 Jason Drive, Berlin-Adlershof, Germany', '054-2659573');
insert into DONORS (did, dname, address, phonenumber)
values (322973850, 'Fats  Cale', '32 Shannon Ave, Coventry, United Kingdom', '058-2760311');
insert into DONORS (did, dname, address, phonenumber)
values (322973851, 'Lili  Gaynor', '65 Monterrey Road, Happy Valley, USA', '056-1472094');
insert into DONORS (did, dname, address, phonenumber)
values (322973852, 'William  Crimson', '54 Hiroshima Street, Roma, Italy', '057-1159520');
insert into DONORS (did, dname, address, phonenumber)
values (322973853, 'Deborah  Cube', '83 Harris Street, Erpe-Mere, Belgium', '059-2460963');
commit;
prompt 535 records loaded
prompt Loading EQUIPMENT...
prompt Table is empty
prompt Loading SUPPLIERS...
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864732, 'John Doe', '123 Main St, Springfield, USA', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864733, 'Jane Smith', '456 Elm St, Springfield, Canada', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864734, 'Bob Johnson', '789 Oak St, Springfield, UK', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864735, 'Alice Brown', '101 Pine St, Springfield, Australia', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864736, 'Charlie Davis', '202 Maple St, Springfield, Germany', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864737, 'Eve White', '303 Birch St, Springfield, France', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864738, 'Frank Harris', '404 Cedar St, Springfield, Spain', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864739, 'Grace Clark', '505 Willow St, Springfield, Italy', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864740, 'Hank Lewis', '606 Aspen St, Springfield, Mexico', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864741, 'Ivy Walker', '707 Redwood St, Springfield, Brazil', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864742, 'Jack Hall', '808 Spruce St, Springfield, Japan', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864743, 'Kate Young', '909 Fir St, Springfield, South Africa', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864744, 'Liam King', '1010 Pine St, Springfield, China', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864745, 'Mia Scott', '1111 Oak St, Springfield, India', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864746, 'Noah Green', '1212 Elm St, Springfield, Russia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864747, 'Olivia Adams', '1313 Cedar St, Springfield, Argentina', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864748, 'Paul Baker', '1414 Maple St, Springfield, Egypt', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864749, 'Quinn Mitchell', '1515 Birch St, Springfield, Germany', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864750, 'Ruby Lee', '1616 Willow St, Springfield, France', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864751, 'Sam Hill', '1717 Aspen St, Springfield, Italy', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864752, 'Tina Ward', '1818 Redwood St, Springfield, Mexico', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864753, 'Uma Perez', '1919 Spruce St, Springfield, Brazil', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864754, 'Vince Sanchez', '2020 Fir St, Springfield, Canada', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864755, 'Wade Carter', '2121 Pine St, Springfield, UK', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864756, 'Xena Foster', '2222 Oak St, Springfield, Australia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864757, 'Yara Griffin', '2323 Elm St, Springfield, Germany', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864758, 'Zack Wood', '2424 Cedar St, Springfield, Spain', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864759, 'Alan Butler', '2525 Maple St, Springfield, Italy', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864760, 'Beth Hayes', '2626 Birch St, Springfield, Mexico', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864761, 'Cody White', '2727 Willow St, Springfield, Brazil', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864762, 'Diana Bell', '2828 Aspen St, Springfield, Japan', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864763, 'Erica Brooks', '2929 Redwood St, Springfield, South Africa', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864764, 'Finn Miller', '3030 Spruce St, Springfield, China', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864765, 'Gina Cook', '3131 Fir St, Springfield, India', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864766, 'Henry Cooper', '3232 Pine St, Springfield, Russia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864767, 'Iris Evans', '3333 Oak St, Springfield, Argentina', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864768, 'Jake Reed', '3434 Elm St, Springfield, Egypt', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864769, 'Kara Turner', '3535 Cedar St, Springfield, Germany', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864770, 'Lily Reed', '3636 Maple St, Springfield, France', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864771, 'Max Cox', '3737 Birch St, Springfield, Italy', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864772, 'Nora Hall', '3838 Willow St, Springfield, Mexico', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864773, 'Oscar Perry', '3939 Aspen St, Springfield, Brazil', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864774, 'Penny Bell', '4040 Redwood St, Springfield, Canada', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864775, 'Quinn Morris', '4141 Spruce St, Springfield, UK', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864776, 'Riley Hill', '4242 Fir St, Springfield, Australia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864777, 'Sofia Cox', '4343 Pine St, Springfield, Germany', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864778, 'Tyler Ward', '4444 Oak St, Springfield, Spain', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864779, 'Uma Watson', '4545 Elm St, Springfield, Italy', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864780, 'Vincent Garcia', '4646 Cedar St, Springfield, Mexico', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864781, 'Wendy Scott', '4747 Maple St, Springfield, Brazil', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864782, 'Xavier Murphy', '4848 Birch St, Springfield, Japan', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864783, 'Yasmin Russell', '4949 Willow St, Springfield, South Africa', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864784, 'Zane Hughes', '5050 Spruce St, Springfield, China', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864785, 'Adam Hayes', '5151 Fir St, Springfield, India', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864786, 'Bella Russell', '5252 Pine St, Springfield, Russia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864787, 'Caleb Ortiz', '5353 Oak St, Springfield, Argentina', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864788, 'Daisy Patterson', '5454 Elm St, Springfield, Egypt', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864789, 'Eli Fisher', '5555 Cedar St, Springfield, Germany', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864790, 'Freya Perry', '5656 Maple St, Springfield, France', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864791, 'Gavin Morales', '5757 Birch St, Springfield, Italy', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864792, 'Hannah Foster', '5858 Willow St, Springfield, Mexico', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864793, 'Isaac Warren', '5959 Aspen St, Springfield, Brazil', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864794, 'Julia Gibson', '6060 Redwood St, Springfield, Canada', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864795, 'Kevin Murphy', '6161 Spruce St, Springfield, UK', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864796, 'Luna Hughes', '6262 Fir St, Springfield, Australia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864797, 'Mason Parker', '6363 Pine St, Springfield, Germany', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864798, 'Nina Sanders', '6464 Oak St, Springfield, Spain', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864799, 'Oliver Bennett', '6565 Elm St, Springfield, Italy', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864800, 'Poppy Ward', '6666 Cedar St, Springfield, Mexico', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864801, 'Quinn Hayes', '6767 Maple St, Springfield, Brazil', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864802, 'Riley Rivera', '6868 Birch St, Springfield, Japan', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864803, 'Sophie Watson', '6969 Willow St, Springfield, South Africa', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864804, 'Thomas Kennedy', '7070 Spruce St, Springfield, China', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864805, 'Uma Dunn', '7171 Fir St, Springfield, India', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864806, 'Vincent Stewart', '7272 Pine St, Springfield, Russia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864807, 'Willow Bailey', '7373 Oak St, Springfield, Argentina', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864808, 'Xavier Tucker', '7474 Elm St, Springfield, Egypt', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864809, 'Yara Johnston', '7575 Cedar St, Springfield, Germany', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864810, 'Zane Holland', '7676 Maple St, Springfield, France', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864811, 'Adam Lane', '7777 Birch St, Springfield, Italy', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864812, 'Bella Fletcher', '7878 Willow St, Springfield, Mexico', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864813, 'Caleb Simpson', '7979 Aspen St, Springfield, Brazil', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864814, 'Daisy Keller', '8080 Redwood St, Springfield, Canada', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864815, 'Eli Clarke', '8181 Spruce St, Springfield, UK', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864816, 'Freya Morton', '8282 Fir St, Springfield, Australia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864817, 'Gavin Davidson', '8383 Pine St, Springfield, Germany', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864818, 'Hannah Grant', '8484 Oak St, Springfield, Spain', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864819, 'Isaac Walters', '8585 Elm St, Springfield, Italy', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864820, 'Julia Harvey', '8686 Cedar St, Springfield, Mexico', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864821, 'Kevin Powell', '8787 Maple St, Springfield, Brazil', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864822, 'Luna Hughes', '8888 Birch St, Springfield, Japan', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864823, 'Mason Bradley', '8989 Willow St, Springfield, South Africa', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864824, 'Nina Potter', '9090 Spruce St, Springfield, China', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864825, 'Oliver Fletcher', '9191 Fir St, Springfield, India', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864826, 'Poppy Rose', '9292 Pine St, Springfield, Russia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864827, 'Quinn Myers', '9393 Oak St, Springfield, Argentina', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864828, 'Riley Matthews', '9494 Elm St, Springfield, Egypt', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864829, 'Sophie Knight', '9595 Cedar St, Springfield, Germany', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864830, 'Thomas Andrews', '9696 Maple St, Springfield, France', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864831, 'Uma Austin', '9797 Birch St, Springfield, Italy', '055-0123456');
commit;
prompt 100 records committed...
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864832, 'Vincent Alvarez', '9898 Willow St, Springfield, Mexico', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864833, 'Willow Fuller', '9999 Aspen St, Springfield, Brazil', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864834, 'Xavier Martinez', '10000 Redwood St, Springfield, Canada', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864835, 'Yara Fisher', '10101 Spruce St, Springfield, UK', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864836, 'Zane Alvarez', '10202 Fir St, Springfield, Australia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864837, 'Adam Hayes', '10303 Pine St, Springfield, Germany', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864838, 'Bella Fuller', '10404 Oak St, Springfield, Spain', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864839, 'Caleb Fisher', '10505 Elm St, Springfield, Italy', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864840, 'Daisy Scott', '10606 Cedar St, Springfield, Mexico', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864841, 'Eli Hayes', '10707 Maple St, Springfield, Brazil', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864842, 'Freya Hayes', '10808 Birch St, Springfield, Japan', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864843, 'John Smith', '123 Main St, Springfield, USA', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864844, 'Emma Johnson', '456 Elm St, Springfield, Canada', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864845, 'William Williams', '789 Oak St, Springfield, UK', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864846, 'Sophia Brown', '101 Pine St, Springfield, Australia', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864847, 'James Davis', '202 Maple St, Springfield, Germany', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864848, 'Olivia Miller', '303 Birch St, Springfield, France', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864849, 'Logan Wilson', '404 Cedar St, Springfield, Spain', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864850, 'Amelia Taylor', '505 Willow St, Springfield, Italy', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864851, 'Benjamin Martinez', '606 Aspen St, Springfield, Mexico', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864852, 'Charlotte Anderson', '707 Redwood St, Springfield, Brazil', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864853, 'Mason Moore', '808 Spruce St, Springfield, Japan', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864854, 'Evelyn Jackson', '909 Fir St, Springfield, South Africa', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864855, 'Ethan White', '1010 Pine St, Springfield, China', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864856, 'Harper Harris', '1111 Oak St, Springfield, India', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864857, 'Michael Lee', '1212 Elm St, Springfield, Russia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864858, 'Ella Clark', '1313 Cedar St, Springfield, Argentina', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864859, 'Daniel King', '1414 Maple St, Springfield, Egypt', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864860, 'Avery Baker', '1515 Birch St, Springfield, Germany', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864861, 'Abigail Carter', '1616 Willow St, Springfield, France', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864862, 'Alexander Hall', '1717 Aspen St, Springfield, Italy', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864863, 'Emily Hill', '1818 Redwood St, Springfield, Mexico', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864864, 'Madison Moore', '1919 Spruce St, Springfield, Brazil', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864865, 'David Phillips', '2020 Fir St, Springfield, Canada', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864866, 'Chloe Ross', '2121 Pine St, Springfield, UK', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864867, 'Elijah Howard', '2222 Oak St, Springfield, Australia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864868, 'Aria Evans', '2323 Elm St, Springfield, Germany', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864869, 'Ethan Garcia', '2424 Cedar St, Springfield, Spain', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864870, 'Scarlett Murphy', '2525 Maple St, Springfield, Italy', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864871, 'Mason Gonzalez', '2626 Birch St, Springfield, Mexico', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864872, 'Aurora Wright', '2727 Willow St, Springfield, Brazil', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864873, 'Carter Cooper', '2828 Aspen St, Springfield, Japan', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864874, 'Sofia Martinez', '2929 Redwood St, Springfield, South Africa', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864875, 'Jackson Perez', '3030 Spruce St, Springfield, China', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864876, 'Avery Sanchez', '3131 Fir St, Springfield, India', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864877, 'Grace Torres', '3232 Pine St, Springfield, Russia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864878, 'Lucas Morris', '3333 Oak St, Springfield, Argentina', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864879, 'Lily Rivera', '3434 Elm St, Springfield, Egypt', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864880, 'Gabriel Peterson', '3535 Cedar St, Springfield, Germany', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864881, 'Zoey Bailey', '3636 Maple St, Springfield, France', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864882, 'Jackson Cooper', '3737 Birch St, Springfield, Italy', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864883, 'Penelope Reed', '3838 Willow St, Springfield, Mexico', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864884, 'Caleb Ramirez', '3939 Aspen St, Springfield, Brazil', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864885, 'Grace Bell', '4040 Redwood St, Springfield, Canada', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864886, 'Nathan Coleman', '4141 Spruce St, Springfield, UK', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864887, 'Hannah Rodriguez', '4242 Fir St, Springfield, Australia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864888, 'Levi Morgan', '4343 Pine St, Springfield, Germany', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864889, 'Riley Richardson', '4444 Oak St, Springfield, Spain', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864890, 'Stella Henderson', '4545 Elm St, Springfield, Italy', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864891, 'David Bennett', '4646 Cedar St, Springfield, Mexico', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864892, 'Zoe Ross', '4747 Maple St, Springfield, Brazil', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864893, 'Aaron Patel', '4848 Birch St, Springfield, Japan', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864894, 'Bella Carter', '4949 Willow St, Springfield, South Africa', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864895, 'Emma Torres', '5050 Spruce St, Springfield, China', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864896, 'Luke Griffin', '5151 Fir St, Springfield, India', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864897, 'Luna Murphy', '5252 Pine St, Springfield, Russia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864898, 'Natalie Hayes', '5353 Oak St, Springfield, Argentina', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864899, 'Jack Powell', '5454 Elm St, Springfield, Egypt', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864900, 'Aubrey Coleman', '5555 Cedar St, Springfield, Germany', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864901, 'Asher Russell', '5656 Maple St, Springfield, France', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864902, 'Adeline Barnes', '5757 Birch St, Springfield, Italy', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864903, 'William Wallace', '5858 Willow St, Springfield, Mexico', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864904, 'Madelyn Stewart', '5959 Aspen St, Springfield, Brazil', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864905, 'Santiago Peterson', '6060 Redwood St, Springfield, Canada', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864906, 'Ruby Bailey', '6161 Spruce St, Springfield, UK', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864907, 'Landon Fisher', '6262 Fir St, Springfield, Australia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864908, 'Aurora Ross', '6363 Pine St, Springfield, Germany', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864909, 'Ellie Long', '6464 Oak St, Springfield, Spain', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864910, 'Jaxon Martinez', '6565 Elm St, Springfield, Italy', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864911, 'Skylar Hughes', '6666 Cedar St, Springfield, Mexico', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864912, 'Grayson Watson', '6767 Maple St, Springfield, Brazil', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864913, 'Paisley Rogers', '6868 Birch St, Springfield, Japan', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864914, 'Mateo Sanders', '6969 Willow St, Springfield, South Africa', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864915, 'Zara Howard', '7070 Spruce St, Springfield, China', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864916, 'Kai Griffin', '7171 Fir St, Springfield, India', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864917, 'Layla Simmons', '7272 Pine St, Springfield, Russia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864918, 'Axel Ramirez', '7373 Oak St, Springfield, Argentina', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864919, 'Nova Knight', '7474 Elm St, Springfield, Egypt', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864920, 'Bryce Reed', '7575 Cedar St, Springfield, Germany', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864921, 'Mila Nguyen', '7676 Maple St, Springfield, France', '054-9012345');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864922, 'Maddox Cooper', '7777 Birch St, Springfield, Italy', '055-0123456');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864923, 'Lila Perez', '7878 Willow St, Springfield, Mexico', '051-1234567');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864924, 'Brady Taylor', '7979 Aspen St, Springfield, Brazil', '052-2345678');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864925, 'Aria Bailey', '8080 Redwood St, Springfield, Canada', '053-3456789');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864926, 'Hudson Torres', '8181 Spruce St, Springfield, UK', '054-4567890');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864927, 'Aubree Sanchez', '8282 Fir St, Springfield, Australia', '055-5678901');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864928, 'Chase Patel', '8383 Pine St, Springfield, Germany', '051-6789012');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864929, 'Hazel Griffin', '8484 Oak St, Springfield, Spain', '052-7890123');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864930, 'Easton Wright', '8585 Elm St, Springfield, Italy', '053-8901234');
insert into SUPPLIERS (sid, sname, address, phonenumber)
values (322864931, 'Kinsley Flores', '8686 Cedar St, Springfield, Mexico', '054-9012345');
commit;
prompt 200 records committed...
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
commit;
prompt 216 records loaded
prompt Loading ORDERS...
insert into ORDERS (oid, orderdate, sid)
values (20163, to_date('29-06-2023', 'dd-mm-yyyy'), 322864741);
insert into ORDERS (oid, orderdate, sid)
values (20081, to_date('20-11-2022', 'dd-mm-yyyy'), 322864913);
insert into ORDERS (oid, orderdate, sid)
values (20157, to_date('02-08-2023', 'dd-mm-yyyy'), 322864855);
insert into ORDERS (oid, orderdate, sid)
values (20298, to_date('28-12-2022', 'dd-mm-yyyy'), 322864857);
insert into ORDERS (oid, orderdate, sid)
values (20329, to_date('26-01-2021', 'dd-mm-yyyy'), 322864854);
insert into ORDERS (oid, orderdate, sid)
values (20385, to_date('12-02-2021', 'dd-mm-yyyy'), 322864889);
insert into ORDERS (oid, orderdate, sid)
values (20278, to_date('08-11-2020', 'dd-mm-yyyy'), 322864901);
insert into ORDERS (oid, orderdate, sid)
values (20228, to_date('09-01-2022', 'dd-mm-yyyy'), 322864901);
insert into ORDERS (oid, orderdate, sid)
values (20216, to_date('12-02-2024', 'dd-mm-yyyy'), 322864758);
insert into ORDERS (oid, orderdate, sid)
values (20345, to_date('17-12-2023', 'dd-mm-yyyy'), 322864775);
insert into ORDERS (oid, orderdate, sid)
values (20290, to_date('28-08-2021', 'dd-mm-yyyy'), 322864945);
insert into ORDERS (oid, orderdate, sid)
values (20243, to_date('30-12-2021', 'dd-mm-yyyy'), 322864853);
insert into ORDERS (oid, orderdate, sid)
values (20172, to_date('21-02-2021', 'dd-mm-yyyy'), 322864807);
insert into ORDERS (oid, orderdate, sid)
values (20106, to_date('16-10-2021', 'dd-mm-yyyy'), 322864851);
insert into ORDERS (oid, orderdate, sid)
values (20230, to_date('11-05-2024', 'dd-mm-yyyy'), 322864800);
insert into ORDERS (oid, orderdate, sid)
values (20259, to_date('17-01-2023', 'dd-mm-yyyy'), 322864897);
insert into ORDERS (oid, orderdate, sid)
values (20223, to_date('20-12-2022', 'dd-mm-yyyy'), 322864836);
insert into ORDERS (oid, orderdate, sid)
values (19999, to_date('31-01-2020', 'dd-mm-yyyy'), 322864883);
insert into ORDERS (oid, orderdate, sid)
values (20000, to_date('29-02-2024', 'dd-mm-yyyy'), 322864911);
insert into ORDERS (oid, orderdate, sid)
values (20001, to_date('30-12-2022', 'dd-mm-yyyy'), 322864780);
insert into ORDERS (oid, orderdate, sid)
values (20002, to_date('05-12-2021', 'dd-mm-yyyy'), 322864809);
insert into ORDERS (oid, orderdate, sid)
values (20003, to_date('10-02-2021', 'dd-mm-yyyy'), 322864918);
insert into ORDERS (oid, orderdate, sid)
values (20004, to_date('07-05-2023', 'dd-mm-yyyy'), 322864878);
insert into ORDERS (oid, orderdate, sid)
values (20005, to_date('22-09-2022', 'dd-mm-yyyy'), 322864902);
insert into ORDERS (oid, orderdate, sid)
values (20006, to_date('25-03-2020', 'dd-mm-yyyy'), 322864854);
insert into ORDERS (oid, orderdate, sid)
values (20007, to_date('31-12-2023', 'dd-mm-yyyy'), 322864875);
insert into ORDERS (oid, orderdate, sid)
values (20008, to_date('05-05-2022', 'dd-mm-yyyy'), 322864834);
insert into ORDERS (oid, orderdate, sid)
values (20009, to_date('15-04-2023', 'dd-mm-yyyy'), 322864778);
insert into ORDERS (oid, orderdate, sid)
values (20010, to_date('23-07-2022', 'dd-mm-yyyy'), 322864897);
insert into ORDERS (oid, orderdate, sid)
values (20011, to_date('15-07-2020', 'dd-mm-yyyy'), 322864943);
insert into ORDERS (oid, orderdate, sid)
values (20012, to_date('08-12-2022', 'dd-mm-yyyy'), 322864812);
insert into ORDERS (oid, orderdate, sid)
values (20013, to_date('26-06-2021', 'dd-mm-yyyy'), 322864848);
insert into ORDERS (oid, orderdate, sid)
values (20014, to_date('06-12-2022', 'dd-mm-yyyy'), 322864793);
insert into ORDERS (oid, orderdate, sid)
values (20015, to_date('23-10-2020', 'dd-mm-yyyy'), 322864896);
insert into ORDERS (oid, orderdate, sid)
values (20016, to_date('11-03-2021', 'dd-mm-yyyy'), 322864852);
insert into ORDERS (oid, orderdate, sid)
values (20017, to_date('18-11-2022', 'dd-mm-yyyy'), 322864916);
insert into ORDERS (oid, orderdate, sid)
values (20018, to_date('06-03-2022', 'dd-mm-yyyy'), 322864897);
insert into ORDERS (oid, orderdate, sid)
values (20019, to_date('28-09-2023', 'dd-mm-yyyy'), 322864799);
insert into ORDERS (oid, orderdate, sid)
values (20020, to_date('07-03-2022', 'dd-mm-yyyy'), 322864739);
insert into ORDERS (oid, orderdate, sid)
values (20021, to_date('22-12-2023', 'dd-mm-yyyy'), 322864943);
insert into ORDERS (oid, orderdate, sid)
values (20022, to_date('16-11-2020', 'dd-mm-yyyy'), 322864760);
insert into ORDERS (oid, orderdate, sid)
values (20023, to_date('28-03-2020', 'dd-mm-yyyy'), 322864919);
insert into ORDERS (oid, orderdate, sid)
values (20024, to_date('24-01-2022', 'dd-mm-yyyy'), 322864782);
insert into ORDERS (oid, orderdate, sid)
values (20025, to_date('13-12-2020', 'dd-mm-yyyy'), 322864827);
insert into ORDERS (oid, orderdate, sid)
values (20026, to_date('13-07-2023', 'dd-mm-yyyy'), 322864804);
insert into ORDERS (oid, orderdate, sid)
values (20027, to_date('12-12-2022', 'dd-mm-yyyy'), 322864837);
insert into ORDERS (oid, orderdate, sid)
values (20028, to_date('30-05-2023', 'dd-mm-yyyy'), 322864823);
insert into ORDERS (oid, orderdate, sid)
values (20029, to_date('16-02-2023', 'dd-mm-yyyy'), 322864903);
insert into ORDERS (oid, orderdate, sid)
values (20030, to_date('01-04-2023', 'dd-mm-yyyy'), 322864930);
insert into ORDERS (oid, orderdate, sid)
values (20031, to_date('02-09-2021', 'dd-mm-yyyy'), 322864790);
insert into ORDERS (oid, orderdate, sid)
values (20032, to_date('05-03-2022', 'dd-mm-yyyy'), 322864933);
insert into ORDERS (oid, orderdate, sid)
values (20033, to_date('09-10-2022', 'dd-mm-yyyy'), 322864780);
insert into ORDERS (oid, orderdate, sid)
values (20034, to_date('19-01-2024', 'dd-mm-yyyy'), 322864820);
insert into ORDERS (oid, orderdate, sid)
values (20035, to_date('12-06-2022', 'dd-mm-yyyy'), 322864922);
insert into ORDERS (oid, orderdate, sid)
values (20036, to_date('31-07-2023', 'dd-mm-yyyy'), 322864772);
insert into ORDERS (oid, orderdate, sid)
values (20037, to_date('29-03-2022', 'dd-mm-yyyy'), 322864834);
insert into ORDERS (oid, orderdate, sid)
values (20038, to_date('14-09-2021', 'dd-mm-yyyy'), 322864840);
insert into ORDERS (oid, orderdate, sid)
values (20039, to_date('26-01-2021', 'dd-mm-yyyy'), 322864810);
insert into ORDERS (oid, orderdate, sid)
values (20040, to_date('21-11-2020', 'dd-mm-yyyy'), 322864852);
insert into ORDERS (oid, orderdate, sid)
values (20041, to_date('26-11-2021', 'dd-mm-yyyy'), 322864752);
insert into ORDERS (oid, orderdate, sid)
values (20042, to_date('05-03-2022', 'dd-mm-yyyy'), 322864746);
insert into ORDERS (oid, orderdate, sid)
values (20043, to_date('12-10-2020', 'dd-mm-yyyy'), 322864799);
insert into ORDERS (oid, orderdate, sid)
values (20044, to_date('30-07-2020', 'dd-mm-yyyy'), 322864736);
insert into ORDERS (oid, orderdate, sid)
values (20045, to_date('08-07-2021', 'dd-mm-yyyy'), 322864945);
insert into ORDERS (oid, orderdate, sid)
values (20046, to_date('10-01-2023', 'dd-mm-yyyy'), 322864942);
insert into ORDERS (oid, orderdate, sid)
values (20047, to_date('16-11-2023', 'dd-mm-yyyy'), 322864800);
insert into ORDERS (oid, orderdate, sid)
values (20048, to_date('04-09-2021', 'dd-mm-yyyy'), 322864872);
insert into ORDERS (oid, orderdate, sid)
values (20049, to_date('07-11-2021', 'dd-mm-yyyy'), 322864792);
insert into ORDERS (oid, orderdate, sid)
values (20050, to_date('22-08-2023', 'dd-mm-yyyy'), 322864885);
insert into ORDERS (oid, orderdate, sid)
values (20051, to_date('15-08-2023', 'dd-mm-yyyy'), 322864890);
insert into ORDERS (oid, orderdate, sid)
values (20052, to_date('03-12-2023', 'dd-mm-yyyy'), 322864920);
insert into ORDERS (oid, orderdate, sid)
values (20053, to_date('17-03-2022', 'dd-mm-yyyy'), 322864837);
insert into ORDERS (oid, orderdate, sid)
values (20054, to_date('27-04-2020', 'dd-mm-yyyy'), 322864912);
insert into ORDERS (oid, orderdate, sid)
values (20055, to_date('04-10-2022', 'dd-mm-yyyy'), 322864899);
insert into ORDERS (oid, orderdate, sid)
values (20056, to_date('29-10-2020', 'dd-mm-yyyy'), 322864862);
insert into ORDERS (oid, orderdate, sid)
values (20057, to_date('16-08-2022', 'dd-mm-yyyy'), 322864737);
insert into ORDERS (oid, orderdate, sid)
values (20058, to_date('20-06-2021', 'dd-mm-yyyy'), 322864784);
insert into ORDERS (oid, orderdate, sid)
values (20059, to_date('24-07-2021', 'dd-mm-yyyy'), 322864927);
insert into ORDERS (oid, orderdate, sid)
values (20060, to_date('21-07-2021', 'dd-mm-yyyy'), 322864759);
insert into ORDERS (oid, orderdate, sid)
values (20061, to_date('04-12-2021', 'dd-mm-yyyy'), 322864946);
insert into ORDERS (oid, orderdate, sid)
values (20062, to_date('11-04-2021', 'dd-mm-yyyy'), 322864776);
insert into ORDERS (oid, orderdate, sid)
values (20063, to_date('19-09-2023', 'dd-mm-yyyy'), 322864850);
insert into ORDERS (oid, orderdate, sid)
values (20064, to_date('26-07-2022', 'dd-mm-yyyy'), 322864914);
insert into ORDERS (oid, orderdate, sid)
values (20065, to_date('20-06-2020', 'dd-mm-yyyy'), 322864795);
insert into ORDERS (oid, orderdate, sid)
values (20066, to_date('23-03-2024', 'dd-mm-yyyy'), 322864792);
insert into ORDERS (oid, orderdate, sid)
values (20067, to_date('23-07-2020', 'dd-mm-yyyy'), 322864754);
insert into ORDERS (oid, orderdate, sid)
values (20068, to_date('13-04-2021', 'dd-mm-yyyy'), 322864902);
insert into ORDERS (oid, orderdate, sid)
values (20069, to_date('25-02-2023', 'dd-mm-yyyy'), 322864746);
insert into ORDERS (oid, orderdate, sid)
values (20070, to_date('27-09-2023', 'dd-mm-yyyy'), 322864945);
insert into ORDERS (oid, orderdate, sid)
values (20071, to_date('29-10-2023', 'dd-mm-yyyy'), 322864795);
insert into ORDERS (oid, orderdate, sid)
values (20072, to_date('28-05-2023', 'dd-mm-yyyy'), 322864947);
insert into ORDERS (oid, orderdate, sid)
values (20073, to_date('01-10-2020', 'dd-mm-yyyy'), 322864824);
insert into ORDERS (oid, orderdate, sid)
values (20074, to_date('25-10-2022', 'dd-mm-yyyy'), 322864802);
insert into ORDERS (oid, orderdate, sid)
values (20075, to_date('09-02-2024', 'dd-mm-yyyy'), 322864903);
insert into ORDERS (oid, orderdate, sid)
values (20076, to_date('22-12-2021', 'dd-mm-yyyy'), 322864876);
insert into ORDERS (oid, orderdate, sid)
values (20077, to_date('14-03-2024', 'dd-mm-yyyy'), 322864844);
insert into ORDERS (oid, orderdate, sid)
values (20078, to_date('10-01-2022', 'dd-mm-yyyy'), 322864748);
insert into ORDERS (oid, orderdate, sid)
values (20079, to_date('24-02-2024', 'dd-mm-yyyy'), 322864775);
insert into ORDERS (oid, orderdate, sid)
values (20080, to_date('03-11-2022', 'dd-mm-yyyy'), 322864756);
insert into ORDERS (oid, orderdate, sid)
values (39999, to_date('02-02-2022', 'dd-mm-yyyy'), 322864818);
commit;
prompt 100 records committed...
insert into ORDERS (oid, orderdate, sid)
values (40000, to_date('15-01-2023', 'dd-mm-yyyy'), 322864745);
insert into ORDERS (oid, orderdate, sid)
values (40001, to_date('04-05-2020', 'dd-mm-yyyy'), 322864799);
insert into ORDERS (oid, orderdate, sid)
values (40002, to_date('03-05-2022', 'dd-mm-yyyy'), 322864753);
insert into ORDERS (oid, orderdate, sid)
values (40003, to_date('30-01-2024', 'dd-mm-yyyy'), 322864795);
insert into ORDERS (oid, orderdate, sid)
values (40004, to_date('13-02-2024', 'dd-mm-yyyy'), 322864746);
insert into ORDERS (oid, orderdate, sid)
values (40005, to_date('09-01-2023', 'dd-mm-yyyy'), 322864930);
insert into ORDERS (oid, orderdate, sid)
values (40006, to_date('01-12-2020', 'dd-mm-yyyy'), 322864811);
insert into ORDERS (oid, orderdate, sid)
values (40007, to_date('04-01-2023', 'dd-mm-yyyy'), 322864759);
insert into ORDERS (oid, orderdate, sid)
values (40008, to_date('05-05-2021', 'dd-mm-yyyy'), 322864888);
insert into ORDERS (oid, orderdate, sid)
values (40009, to_date('05-09-2023', 'dd-mm-yyyy'), 322864928);
insert into ORDERS (oid, orderdate, sid)
values (40010, to_date('20-11-2023', 'dd-mm-yyyy'), 322864899);
insert into ORDERS (oid, orderdate, sid)
values (40011, to_date('10-01-2024', 'dd-mm-yyyy'), 322864851);
insert into ORDERS (oid, orderdate, sid)
values (40012, to_date('16-04-2021', 'dd-mm-yyyy'), 322864838);
insert into ORDERS (oid, orderdate, sid)
values (40013, to_date('06-12-2022', 'dd-mm-yyyy'), 322864770);
insert into ORDERS (oid, orderdate, sid)
values (40014, to_date('21-10-2023', 'dd-mm-yyyy'), 322864754);
insert into ORDERS (oid, orderdate, sid)
values (40015, to_date('25-04-2023', 'dd-mm-yyyy'), 322864824);
insert into ORDERS (oid, orderdate, sid)
values (40016, to_date('07-09-2020', 'dd-mm-yyyy'), 322864876);
insert into ORDERS (oid, orderdate, sid)
values (40017, to_date('02-07-2023', 'dd-mm-yyyy'), 322864850);
insert into ORDERS (oid, orderdate, sid)
values (40018, to_date('14-02-2024', 'dd-mm-yyyy'), 322864857);
insert into ORDERS (oid, orderdate, sid)
values (40019, to_date('19-02-2024', 'dd-mm-yyyy'), 322864780);
insert into ORDERS (oid, orderdate, sid)
values (40020, to_date('05-07-2020', 'dd-mm-yyyy'), 322864833);
insert into ORDERS (oid, orderdate, sid)
values (40021, to_date('01-04-2023', 'dd-mm-yyyy'), 322864921);
insert into ORDERS (oid, orderdate, sid)
values (40022, to_date('17-10-2023', 'dd-mm-yyyy'), 322864819);
insert into ORDERS (oid, orderdate, sid)
values (40023, to_date('05-04-2021', 'dd-mm-yyyy'), 322864801);
insert into ORDERS (oid, orderdate, sid)
values (40024, to_date('03-11-2022', 'dd-mm-yyyy'), 322864820);
insert into ORDERS (oid, orderdate, sid)
values (40025, to_date('17-11-2023', 'dd-mm-yyyy'), 322864942);
insert into ORDERS (oid, orderdate, sid)
values (40026, to_date('23-02-2024', 'dd-mm-yyyy'), 322864843);
insert into ORDERS (oid, orderdate, sid)
values (40027, to_date('21-12-2022', 'dd-mm-yyyy'), 322864739);
insert into ORDERS (oid, orderdate, sid)
values (40028, to_date('31-07-2023', 'dd-mm-yyyy'), 322864739);
insert into ORDERS (oid, orderdate, sid)
values (40029, to_date('04-03-2020', 'dd-mm-yyyy'), 322864797);
insert into ORDERS (oid, orderdate, sid)
values (40030, to_date('27-10-2022', 'dd-mm-yyyy'), 322864887);
insert into ORDERS (oid, orderdate, sid)
values (40031, to_date('14-11-2022', 'dd-mm-yyyy'), 322864847);
insert into ORDERS (oid, orderdate, sid)
values (40032, to_date('31-12-2022', 'dd-mm-yyyy'), 322864934);
insert into ORDERS (oid, orderdate, sid)
values (40033, to_date('26-05-2022', 'dd-mm-yyyy'), 322864850);
insert into ORDERS (oid, orderdate, sid)
values (40034, to_date('05-03-2021', 'dd-mm-yyyy'), 322864759);
insert into ORDERS (oid, orderdate, sid)
values (40035, to_date('05-06-2022', 'dd-mm-yyyy'), 322864840);
insert into ORDERS (oid, orderdate, sid)
values (40036, to_date('26-05-2023', 'dd-mm-yyyy'), 322864750);
insert into ORDERS (oid, orderdate, sid)
values (40037, to_date('22-02-2024', 'dd-mm-yyyy'), 322864936);
insert into ORDERS (oid, orderdate, sid)
values (40038, to_date('05-03-2023', 'dd-mm-yyyy'), 322864922);
insert into ORDERS (oid, orderdate, sid)
values (40039, to_date('24-11-2020', 'dd-mm-yyyy'), 322864876);
insert into ORDERS (oid, orderdate, sid)
values (40040, to_date('30-08-2022', 'dd-mm-yyyy'), 322864832);
insert into ORDERS (oid, orderdate, sid)
values (40041, to_date('16-11-2020', 'dd-mm-yyyy'), 322864828);
insert into ORDERS (oid, orderdate, sid)
values (40042, to_date('25-05-2021', 'dd-mm-yyyy'), 322864778);
insert into ORDERS (oid, orderdate, sid)
values (40043, to_date('13-11-2020', 'dd-mm-yyyy'), 322864757);
insert into ORDERS (oid, orderdate, sid)
values (40044, to_date('26-03-2021', 'dd-mm-yyyy'), 322864741);
insert into ORDERS (oid, orderdate, sid)
values (40045, to_date('29-03-2022', 'dd-mm-yyyy'), 322864883);
insert into ORDERS (oid, orderdate, sid)
values (40046, to_date('25-10-2022', 'dd-mm-yyyy'), 322864906);
insert into ORDERS (oid, orderdate, sid)
values (40047, to_date('05-02-2023', 'dd-mm-yyyy'), 322864821);
insert into ORDERS (oid, orderdate, sid)
values (40048, to_date('07-08-2020', 'dd-mm-yyyy'), 322864744);
insert into ORDERS (oid, orderdate, sid)
values (40049, to_date('15-11-2022', 'dd-mm-yyyy'), 322864912);
insert into ORDERS (oid, orderdate, sid)
values (40050, to_date('02-03-2022', 'dd-mm-yyyy'), 322864837);
insert into ORDERS (oid, orderdate, sid)
values (40051, to_date('02-11-2023', 'dd-mm-yyyy'), 322864851);
insert into ORDERS (oid, orderdate, sid)
values (40052, to_date('20-01-2022', 'dd-mm-yyyy'), 322864854);
insert into ORDERS (oid, orderdate, sid)
values (40053, to_date('07-01-2024', 'dd-mm-yyyy'), 322864744);
insert into ORDERS (oid, orderdate, sid)
values (40054, to_date('25-11-2023', 'dd-mm-yyyy'), 322864773);
insert into ORDERS (oid, orderdate, sid)
values (40055, to_date('25-05-2023', 'dd-mm-yyyy'), 322864887);
insert into ORDERS (oid, orderdate, sid)
values (40056, to_date('04-05-2021', 'dd-mm-yyyy'), 322864812);
insert into ORDERS (oid, orderdate, sid)
values (40057, to_date('17-06-2022', 'dd-mm-yyyy'), 322864747);
insert into ORDERS (oid, orderdate, sid)
values (40058, to_date('29-06-2020', 'dd-mm-yyyy'), 322864793);
insert into ORDERS (oid, orderdate, sid)
values (40059, to_date('04-01-2024', 'dd-mm-yyyy'), 322864912);
insert into ORDERS (oid, orderdate, sid)
values (40060, to_date('08-02-2021', 'dd-mm-yyyy'), 322864777);
insert into ORDERS (oid, orderdate, sid)
values (40061, to_date('27-11-2023', 'dd-mm-yyyy'), 322864794);
insert into ORDERS (oid, orderdate, sid)
values (40062, to_date('20-09-2023', 'dd-mm-yyyy'), 322864769);
insert into ORDERS (oid, orderdate, sid)
values (40063, to_date('22-05-2021', 'dd-mm-yyyy'), 322864942);
insert into ORDERS (oid, orderdate, sid)
values (40064, to_date('25-09-2021', 'dd-mm-yyyy'), 322864796);
insert into ORDERS (oid, orderdate, sid)
values (40065, to_date('09-09-2023', 'dd-mm-yyyy'), 322864922);
insert into ORDERS (oid, orderdate, sid)
values (40066, to_date('24-07-2021', 'dd-mm-yyyy'), 322864783);
insert into ORDERS (oid, orderdate, sid)
values (40067, to_date('11-09-2020', 'dd-mm-yyyy'), 322864845);
insert into ORDERS (oid, orderdate, sid)
values (40068, to_date('05-03-2021', 'dd-mm-yyyy'), 322864762);
insert into ORDERS (oid, orderdate, sid)
values (40069, to_date('12-09-2020', 'dd-mm-yyyy'), 322864866);
insert into ORDERS (oid, orderdate, sid)
values (40070, to_date('16-03-2023', 'dd-mm-yyyy'), 322864743);
insert into ORDERS (oid, orderdate, sid)
values (40071, to_date('02-04-2024', 'dd-mm-yyyy'), 322864779);
insert into ORDERS (oid, orderdate, sid)
values (40072, to_date('09-11-2023', 'dd-mm-yyyy'), 322864880);
insert into ORDERS (oid, orderdate, sid)
values (40073, to_date('28-07-2020', 'dd-mm-yyyy'), 322864850);
insert into ORDERS (oid, orderdate, sid)
values (40074, to_date('18-11-2020', 'dd-mm-yyyy'), 322864941);
insert into ORDERS (oid, orderdate, sid)
values (40075, to_date('27-09-2021', 'dd-mm-yyyy'), 322864932);
insert into ORDERS (oid, orderdate, sid)
values (40076, to_date('18-07-2023', 'dd-mm-yyyy'), 322864904);
insert into ORDERS (oid, orderdate, sid)
values (40077, to_date('08-11-2023', 'dd-mm-yyyy'), 322864828);
insert into ORDERS (oid, orderdate, sid)
values (40078, to_date('04-04-2022', 'dd-mm-yyyy'), 322864937);
insert into ORDERS (oid, orderdate, sid)
values (40079, to_date('02-05-2022', 'dd-mm-yyyy'), 322864800);
insert into ORDERS (oid, orderdate, sid)
values (40080, to_date('20-07-2021', 'dd-mm-yyyy'), 322864734);
insert into ORDERS (oid, orderdate, sid)
values (40081, to_date('11-12-2020', 'dd-mm-yyyy'), 322864756);
insert into ORDERS (oid, orderdate, sid)
values (40082, to_date('02-08-2021', 'dd-mm-yyyy'), 322864899);
insert into ORDERS (oid, orderdate, sid)
values (40083, to_date('05-07-2023', 'dd-mm-yyyy'), 322864788);
insert into ORDERS (oid, orderdate, sid)
values (40084, to_date('30-04-2023', 'dd-mm-yyyy'), 322864863);
insert into ORDERS (oid, orderdate, sid)
values (40085, to_date('23-04-2020', 'dd-mm-yyyy'), 322864836);
insert into ORDERS (oid, orderdate, sid)
values (40086, to_date('15-11-2023', 'dd-mm-yyyy'), 322864843);
insert into ORDERS (oid, orderdate, sid)
values (40087, to_date('14-10-2021', 'dd-mm-yyyy'), 322864760);
insert into ORDERS (oid, orderdate, sid)
values (40088, to_date('09-02-2022', 'dd-mm-yyyy'), 322864743);
insert into ORDERS (oid, orderdate, sid)
values (40089, to_date('17-01-2022', 'dd-mm-yyyy'), 322864847);
insert into ORDERS (oid, orderdate, sid)
values (40090, to_date('22-12-2020', 'dd-mm-yyyy'), 322864803);
insert into ORDERS (oid, orderdate, sid)
values (40091, to_date('31-07-2021', 'dd-mm-yyyy'), 322864914);
insert into ORDERS (oid, orderdate, sid)
values (40092, to_date('15-05-2022', 'dd-mm-yyyy'), 322864872);
insert into ORDERS (oid, orderdate, sid)
values (40093, to_date('15-04-2020', 'dd-mm-yyyy'), 322864947);
insert into ORDERS (oid, orderdate, sid)
values (40094, to_date('10-09-2020', 'dd-mm-yyyy'), 322864861);
insert into ORDERS (oid, orderdate, sid)
values (40095, to_date('01-03-2020', 'dd-mm-yyyy'), 322864892);
insert into ORDERS (oid, orderdate, sid)
values (40096, to_date('17-01-2024', 'dd-mm-yyyy'), 322864864);
insert into ORDERS (oid, orderdate, sid)
values (40097, to_date('23-03-2021', 'dd-mm-yyyy'), 322864928);
insert into ORDERS (oid, orderdate, sid)
values (40098, to_date('05-06-2023', 'dd-mm-yyyy'), 322864805);
insert into ORDERS (oid, orderdate, sid)
values (40099, to_date('14-06-2021', 'dd-mm-yyyy'), 322864796);
commit;
prompt 200 records committed...
insert into ORDERS (oid, orderdate, sid)
values (40100, to_date('07-03-2020', 'dd-mm-yyyy'), 322864808);
insert into ORDERS (oid, orderdate, sid)
values (40101, to_date('08-02-2024', 'dd-mm-yyyy'), 322864938);
insert into ORDERS (oid, orderdate, sid)
values (40102, to_date('27-01-2021', 'dd-mm-yyyy'), 322864938);
insert into ORDERS (oid, orderdate, sid)
values (40103, to_date('06-07-2021', 'dd-mm-yyyy'), 322864864);
insert into ORDERS (oid, orderdate, sid)
values (40104, to_date('20-03-2021', 'dd-mm-yyyy'), 322864769);
insert into ORDERS (oid, orderdate, sid)
values (40105, to_date('01-04-2022', 'dd-mm-yyyy'), 322864868);
insert into ORDERS (oid, orderdate, sid)
values (40106, to_date('19-07-2022', 'dd-mm-yyyy'), 322864789);
insert into ORDERS (oid, orderdate, sid)
values (40107, to_date('23-11-2022', 'dd-mm-yyyy'), 322864889);
insert into ORDERS (oid, orderdate, sid)
values (40108, to_date('15-06-2022', 'dd-mm-yyyy'), 322864772);
insert into ORDERS (oid, orderdate, sid)
values (40109, to_date('05-02-2024', 'dd-mm-yyyy'), 322864781);
insert into ORDERS (oid, orderdate, sid)
values (40110, to_date('20-06-2022', 'dd-mm-yyyy'), 322864928);
insert into ORDERS (oid, orderdate, sid)
values (40111, to_date('16-09-2020', 'dd-mm-yyyy'), 322864898);
insert into ORDERS (oid, orderdate, sid)
values (40112, to_date('09-02-2020', 'dd-mm-yyyy'), 322864863);
insert into ORDERS (oid, orderdate, sid)
values (40113, to_date('20-01-2024', 'dd-mm-yyyy'), 322864862);
insert into ORDERS (oid, orderdate, sid)
values (40114, to_date('09-11-2022', 'dd-mm-yyyy'), 322864945);
insert into ORDERS (oid, orderdate, sid)
values (40115, to_date('17-11-2021', 'dd-mm-yyyy'), 322864925);
insert into ORDERS (oid, orderdate, sid)
values (40116, to_date('23-03-2023', 'dd-mm-yyyy'), 322864805);
insert into ORDERS (oid, orderdate, sid)
values (40117, to_date('01-02-2024', 'dd-mm-yyyy'), 322864901);
insert into ORDERS (oid, orderdate, sid)
values (40118, to_date('27-04-2024', 'dd-mm-yyyy'), 322864748);
insert into ORDERS (oid, orderdate, sid)
values (40119, to_date('23-12-2022', 'dd-mm-yyyy'), 322864736);
insert into ORDERS (oid, orderdate, sid)
values (40120, to_date('28-12-2021', 'dd-mm-yyyy'), 322864915);
insert into ORDERS (oid, orderdate, sid)
values (40121, to_date('31-08-2022', 'dd-mm-yyyy'), 322864818);
insert into ORDERS (oid, orderdate, sid)
values (40122, to_date('13-12-2021', 'dd-mm-yyyy'), 322864841);
insert into ORDERS (oid, orderdate, sid)
values (40123, to_date('09-04-2021', 'dd-mm-yyyy'), 322864824);
insert into ORDERS (oid, orderdate, sid)
values (40124, to_date('25-02-2022', 'dd-mm-yyyy'), 322864820);
insert into ORDERS (oid, orderdate, sid)
values (40125, to_date('01-10-2023', 'dd-mm-yyyy'), 322864920);
insert into ORDERS (oid, orderdate, sid)
values (40126, to_date('29-05-2023', 'dd-mm-yyyy'), 322864733);
insert into ORDERS (oid, orderdate, sid)
values (40127, to_date('29-10-2023', 'dd-mm-yyyy'), 322864755);
insert into ORDERS (oid, orderdate, sid)
values (40128, to_date('27-08-2022', 'dd-mm-yyyy'), 322864858);
insert into ORDERS (oid, orderdate, sid)
values (40129, to_date('22-11-2021', 'dd-mm-yyyy'), 322864835);
insert into ORDERS (oid, orderdate, sid)
values (40130, to_date('26-05-2023', 'dd-mm-yyyy'), 322864863);
insert into ORDERS (oid, orderdate, sid)
values (40131, to_date('23-12-2023', 'dd-mm-yyyy'), 322864946);
insert into ORDERS (oid, orderdate, sid)
values (40132, to_date('04-04-2024', 'dd-mm-yyyy'), 322864753);
insert into ORDERS (oid, orderdate, sid)
values (40133, to_date('17-07-2020', 'dd-mm-yyyy'), 322864773);
insert into ORDERS (oid, orderdate, sid)
values (40134, to_date('03-05-2022', 'dd-mm-yyyy'), 322864928);
insert into ORDERS (oid, orderdate, sid)
values (40135, to_date('26-02-2024', 'dd-mm-yyyy'), 322864931);
insert into ORDERS (oid, orderdate, sid)
values (40136, to_date('29-11-2020', 'dd-mm-yyyy'), 322864937);
insert into ORDERS (oid, orderdate, sid)
values (40137, to_date('03-02-2022', 'dd-mm-yyyy'), 322864807);
insert into ORDERS (oid, orderdate, sid)
values (40138, to_date('19-04-2023', 'dd-mm-yyyy'), 322864860);
insert into ORDERS (oid, orderdate, sid)
values (40139, to_date('09-09-2021', 'dd-mm-yyyy'), 322864839);
insert into ORDERS (oid, orderdate, sid)
values (40140, to_date('30-01-2022', 'dd-mm-yyyy'), 322864924);
insert into ORDERS (oid, orderdate, sid)
values (40141, to_date('24-05-2020', 'dd-mm-yyyy'), 322864756);
insert into ORDERS (oid, orderdate, sid)
values (40142, to_date('01-07-2020', 'dd-mm-yyyy'), 322864802);
insert into ORDERS (oid, orderdate, sid)
values (40143, to_date('27-05-2023', 'dd-mm-yyyy'), 322864878);
insert into ORDERS (oid, orderdate, sid)
values (40144, to_date('18-09-2022', 'dd-mm-yyyy'), 322864775);
insert into ORDERS (oid, orderdate, sid)
values (40145, to_date('30-01-2022', 'dd-mm-yyyy'), 322864899);
insert into ORDERS (oid, orderdate, sid)
values (40146, to_date('28-02-2023', 'dd-mm-yyyy'), 322864930);
insert into ORDERS (oid, orderdate, sid)
values (40147, to_date('28-02-2023', 'dd-mm-yyyy'), 322864787);
insert into ORDERS (oid, orderdate, sid)
values (40148, to_date('28-09-2021', 'dd-mm-yyyy'), 322864894);
insert into ORDERS (oid, orderdate, sid)
values (40149, to_date('27-01-2022', 'dd-mm-yyyy'), 322864913);
insert into ORDERS (oid, orderdate, sid)
values (40150, to_date('27-07-2022', 'dd-mm-yyyy'), 322864908);
insert into ORDERS (oid, orderdate, sid)
values (40151, to_date('10-06-2021', 'dd-mm-yyyy'), 322864751);
insert into ORDERS (oid, orderdate, sid)
values (40152, to_date('25-04-2023', 'dd-mm-yyyy'), 322864822);
insert into ORDERS (oid, orderdate, sid)
values (40153, to_date('20-01-2021', 'dd-mm-yyyy'), 322864936);
insert into ORDERS (oid, orderdate, sid)
values (40154, to_date('17-11-2020', 'dd-mm-yyyy'), 322864929);
insert into ORDERS (oid, orderdate, sid)
values (40155, to_date('24-12-2020', 'dd-mm-yyyy'), 322864773);
insert into ORDERS (oid, orderdate, sid)
values (40156, to_date('23-09-2020', 'dd-mm-yyyy'), 322864903);
insert into ORDERS (oid, orderdate, sid)
values (40157, to_date('27-06-2023', 'dd-mm-yyyy'), 322864861);
insert into ORDERS (oid, orderdate, sid)
values (40158, to_date('05-09-2020', 'dd-mm-yyyy'), 322864872);
insert into ORDERS (oid, orderdate, sid)
values (40159, to_date('12-07-2020', 'dd-mm-yyyy'), 322864859);
insert into ORDERS (oid, orderdate, sid)
values (40160, to_date('01-03-2020', 'dd-mm-yyyy'), 322864772);
insert into ORDERS (oid, orderdate, sid)
values (40161, to_date('05-07-2020', 'dd-mm-yyyy'), 322864879);
insert into ORDERS (oid, orderdate, sid)
values (40162, to_date('09-08-2023', 'dd-mm-yyyy'), 322864831);
insert into ORDERS (oid, orderdate, sid)
values (40163, to_date('31-03-2024', 'dd-mm-yyyy'), 322864739);
insert into ORDERS (oid, orderdate, sid)
values (40164, to_date('12-10-2020', 'dd-mm-yyyy'), 322864945);
insert into ORDERS (oid, orderdate, sid)
values (40165, to_date('14-08-2023', 'dd-mm-yyyy'), 322864913);
insert into ORDERS (oid, orderdate, sid)
values (40166, to_date('20-06-2020', 'dd-mm-yyyy'), 322864838);
insert into ORDERS (oid, orderdate, sid)
values (40167, to_date('27-10-2022', 'dd-mm-yyyy'), 322864838);
insert into ORDERS (oid, orderdate, sid)
values (40168, to_date('05-06-2021', 'dd-mm-yyyy'), 322864794);
insert into ORDERS (oid, orderdate, sid)
values (40169, to_date('12-10-2021', 'dd-mm-yyyy'), 322864864);
insert into ORDERS (oid, orderdate, sid)
values (40170, to_date('20-02-2021', 'dd-mm-yyyy'), 322864878);
insert into ORDERS (oid, orderdate, sid)
values (40171, to_date('20-12-2020', 'dd-mm-yyyy'), 322864834);
insert into ORDERS (oid, orderdate, sid)
values (40172, to_date('29-03-2023', 'dd-mm-yyyy'), 322864914);
insert into ORDERS (oid, orderdate, sid)
values (40173, to_date('18-01-2020', 'dd-mm-yyyy'), 322864822);
insert into ORDERS (oid, orderdate, sid)
values (40174, to_date('08-04-2023', 'dd-mm-yyyy'), 322864750);
insert into ORDERS (oid, orderdate, sid)
values (40175, to_date('05-07-2023', 'dd-mm-yyyy'), 322864770);
insert into ORDERS (oid, orderdate, sid)
values (40176, to_date('27-09-2023', 'dd-mm-yyyy'), 322864811);
insert into ORDERS (oid, orderdate, sid)
values (40177, to_date('24-07-2023', 'dd-mm-yyyy'), 322864808);
insert into ORDERS (oid, orderdate, sid)
values (40178, to_date('12-10-2020', 'dd-mm-yyyy'), 322864863);
insert into ORDERS (oid, orderdate, sid)
values (40179, to_date('20-11-2023', 'dd-mm-yyyy'), 322864816);
insert into ORDERS (oid, orderdate, sid)
values (40180, to_date('12-05-2024', 'dd-mm-yyyy'), 322864751);
insert into ORDERS (oid, orderdate, sid)
values (40181, to_date('14-01-2024', 'dd-mm-yyyy'), 322864898);
insert into ORDERS (oid, orderdate, sid)
values (40182, to_date('04-06-2021', 'dd-mm-yyyy'), 322864936);
insert into ORDERS (oid, orderdate, sid)
values (40183, to_date('13-07-2021', 'dd-mm-yyyy'), 322864796);
insert into ORDERS (oid, orderdate, sid)
values (40184, to_date('21-09-2020', 'dd-mm-yyyy'), 322864874);
insert into ORDERS (oid, orderdate, sid)
values (40185, to_date('31-10-2023', 'dd-mm-yyyy'), 322864886);
insert into ORDERS (oid, orderdate, sid)
values (40186, to_date('15-09-2020', 'dd-mm-yyyy'), 322864929);
insert into ORDERS (oid, orderdate, sid)
values (40187, to_date('07-02-2024', 'dd-mm-yyyy'), 322864733);
insert into ORDERS (oid, orderdate, sid)
values (40188, to_date('07-11-2023', 'dd-mm-yyyy'), 322864809);
insert into ORDERS (oid, orderdate, sid)
values (40189, to_date('16-12-2022', 'dd-mm-yyyy'), 322864758);
insert into ORDERS (oid, orderdate, sid)
values (40190, to_date('14-05-2024', 'dd-mm-yyyy'), 322864743);
insert into ORDERS (oid, orderdate, sid)
values (40191, to_date('29-06-2021', 'dd-mm-yyyy'), 322864938);
insert into ORDERS (oid, orderdate, sid)
values (40192, to_date('11-04-2020', 'dd-mm-yyyy'), 322864868);
insert into ORDERS (oid, orderdate, sid)
values (40193, to_date('09-10-2021', 'dd-mm-yyyy'), 322864921);
insert into ORDERS (oid, orderdate, sid)
values (40194, to_date('15-11-2022', 'dd-mm-yyyy'), 322864852);
insert into ORDERS (oid, orderdate, sid)
values (40195, to_date('26-09-2023', 'dd-mm-yyyy'), 322864752);
insert into ORDERS (oid, orderdate, sid)
values (40196, to_date('03-03-2020', 'dd-mm-yyyy'), 322864926);
insert into ORDERS (oid, orderdate, sid)
values (40197, to_date('14-09-2021', 'dd-mm-yyyy'), 322864872);
insert into ORDERS (oid, orderdate, sid)
values (40198, to_date('21-03-2023', 'dd-mm-yyyy'), 322864845);
insert into ORDERS (oid, orderdate, sid)
values (40199, to_date('28-05-2022', 'dd-mm-yyyy'), 322864924);
commit;
prompt 300 records committed...
insert into ORDERS (oid, orderdate, sid)
values (40200, to_date('07-05-2022', 'dd-mm-yyyy'), 322864886);
insert into ORDERS (oid, orderdate, sid)
values (40201, to_date('01-02-2024', 'dd-mm-yyyy'), 322864856);
insert into ORDERS (oid, orderdate, sid)
values (40202, to_date('17-12-2023', 'dd-mm-yyyy'), 322864838);
insert into ORDERS (oid, orderdate, sid)
values (40203, to_date('12-04-2020', 'dd-mm-yyyy'), 322864764);
insert into ORDERS (oid, orderdate, sid)
values (40204, to_date('16-06-2023', 'dd-mm-yyyy'), 322864781);
insert into ORDERS (oid, orderdate, sid)
values (40205, to_date('03-09-2022', 'dd-mm-yyyy'), 322864884);
insert into ORDERS (oid, orderdate, sid)
values (40206, to_date('29-03-2021', 'dd-mm-yyyy'), 322864800);
insert into ORDERS (oid, orderdate, sid)
values (40207, to_date('05-01-2024', 'dd-mm-yyyy'), 322864874);
insert into ORDERS (oid, orderdate, sid)
values (40208, to_date('15-01-2023', 'dd-mm-yyyy'), 322864938);
insert into ORDERS (oid, orderdate, sid)
values (40209, to_date('26-07-2020', 'dd-mm-yyyy'), 322864798);
insert into ORDERS (oid, orderdate, sid)
values (40210, to_date('15-11-2023', 'dd-mm-yyyy'), 322864806);
insert into ORDERS (oid, orderdate, sid)
values (40211, to_date('07-09-2021', 'dd-mm-yyyy'), 322864862);
insert into ORDERS (oid, orderdate, sid)
values (40212, to_date('09-02-2020', 'dd-mm-yyyy'), 322864915);
insert into ORDERS (oid, orderdate, sid)
values (40213, to_date('17-04-2023', 'dd-mm-yyyy'), 322864939);
insert into ORDERS (oid, orderdate, sid)
values (40214, to_date('27-05-2020', 'dd-mm-yyyy'), 322864927);
insert into ORDERS (oid, orderdate, sid)
values (40215, to_date('21-04-2024', 'dd-mm-yyyy'), 322864914);
insert into ORDERS (oid, orderdate, sid)
values (40216, to_date('17-02-2023', 'dd-mm-yyyy'), 322864887);
insert into ORDERS (oid, orderdate, sid)
values (40217, to_date('22-02-2021', 'dd-mm-yyyy'), 322864836);
insert into ORDERS (oid, orderdate, sid)
values (40218, to_date('30-01-2021', 'dd-mm-yyyy'), 322864754);
insert into ORDERS (oid, orderdate, sid)
values (40219, to_date('16-12-2021', 'dd-mm-yyyy'), 322864943);
insert into ORDERS (oid, orderdate, sid)
values (40220, to_date('25-10-2020', 'dd-mm-yyyy'), 322864930);
insert into ORDERS (oid, orderdate, sid)
values (40221, to_date('01-05-2022', 'dd-mm-yyyy'), 322864867);
insert into ORDERS (oid, orderdate, sid)
values (40222, to_date('05-02-2021', 'dd-mm-yyyy'), 322864940);
insert into ORDERS (oid, orderdate, sid)
values (40223, to_date('16-06-2021', 'dd-mm-yyyy'), 322864780);
insert into ORDERS (oid, orderdate, sid)
values (40224, to_date('26-05-2023', 'dd-mm-yyyy'), 322864814);
insert into ORDERS (oid, orderdate, sid)
values (40225, to_date('10-09-2022', 'dd-mm-yyyy'), 322864871);
insert into ORDERS (oid, orderdate, sid)
values (40226, to_date('17-02-2021', 'dd-mm-yyyy'), 322864909);
insert into ORDERS (oid, orderdate, sid)
values (40227, to_date('16-08-2020', 'dd-mm-yyyy'), 322864753);
insert into ORDERS (oid, orderdate, sid)
values (40228, to_date('10-10-2020', 'dd-mm-yyyy'), 322864936);
insert into ORDERS (oid, orderdate, sid)
values (40229, to_date('28-10-2021', 'dd-mm-yyyy'), 322864867);
insert into ORDERS (oid, orderdate, sid)
values (40230, to_date('14-11-2021', 'dd-mm-yyyy'), 322864749);
insert into ORDERS (oid, orderdate, sid)
values (40231, to_date('17-02-2020', 'dd-mm-yyyy'), 322864937);
insert into ORDERS (oid, orderdate, sid)
values (40232, to_date('09-05-2024', 'dd-mm-yyyy'), 322864734);
insert into ORDERS (oid, orderdate, sid)
values (40233, to_date('06-02-2024', 'dd-mm-yyyy'), 322864873);
insert into ORDERS (oid, orderdate, sid)
values (40234, to_date('07-03-2023', 'dd-mm-yyyy'), 322864791);
insert into ORDERS (oid, orderdate, sid)
values (40235, to_date('08-04-2020', 'dd-mm-yyyy'), 322864788);
insert into ORDERS (oid, orderdate, sid)
values (40236, to_date('09-05-2021', 'dd-mm-yyyy'), 322864835);
insert into ORDERS (oid, orderdate, sid)
values (40237, to_date('16-03-2020', 'dd-mm-yyyy'), 322864903);
insert into ORDERS (oid, orderdate, sid)
values (40238, to_date('14-07-2023', 'dd-mm-yyyy'), 322864821);
insert into ORDERS (oid, orderdate, sid)
values (40239, to_date('17-03-2020', 'dd-mm-yyyy'), 322864899);
insert into ORDERS (oid, orderdate, sid)
values (40240, to_date('29-07-2021', 'dd-mm-yyyy'), 322864742);
insert into ORDERS (oid, orderdate, sid)
values (40241, to_date('30-10-2023', 'dd-mm-yyyy'), 322864917);
insert into ORDERS (oid, orderdate, sid)
values (40242, to_date('19-02-2024', 'dd-mm-yyyy'), 322864877);
insert into ORDERS (oid, orderdate, sid)
values (40243, to_date('24-01-2024', 'dd-mm-yyyy'), 322864828);
insert into ORDERS (oid, orderdate, sid)
values (40244, to_date('16-01-2021', 'dd-mm-yyyy'), 322864900);
insert into ORDERS (oid, orderdate, sid)
values (40245, to_date('07-01-2023', 'dd-mm-yyyy'), 322864740);
insert into ORDERS (oid, orderdate, sid)
values (40246, to_date('12-02-2020', 'dd-mm-yyyy'), 322864816);
insert into ORDERS (oid, orderdate, sid)
values (40247, to_date('21-02-2023', 'dd-mm-yyyy'), 322864773);
insert into ORDERS (oid, orderdate, sid)
values (40248, to_date('27-12-2022', 'dd-mm-yyyy'), 322864733);
insert into ORDERS (oid, orderdate, sid)
values (40249, to_date('23-10-2021', 'dd-mm-yyyy'), 322864794);
insert into ORDERS (oid, orderdate, sid)
values (40250, to_date('05-10-2022', 'dd-mm-yyyy'), 322864806);
insert into ORDERS (oid, orderdate, sid)
values (40251, to_date('17-02-2020', 'dd-mm-yyyy'), 322864834);
insert into ORDERS (oid, orderdate, sid)
values (40252, to_date('20-12-2023', 'dd-mm-yyyy'), 322864846);
insert into ORDERS (oid, orderdate, sid)
values (40253, to_date('14-11-2022', 'dd-mm-yyyy'), 322864853);
insert into ORDERS (oid, orderdate, sid)
values (40254, to_date('14-07-2020', 'dd-mm-yyyy'), 322864819);
insert into ORDERS (oid, orderdate, sid)
values (40255, to_date('31-08-2020', 'dd-mm-yyyy'), 322864874);
insert into ORDERS (oid, orderdate, sid)
values (40256, to_date('02-04-2022', 'dd-mm-yyyy'), 322864764);
insert into ORDERS (oid, orderdate, sid)
values (40257, to_date('17-05-2021', 'dd-mm-yyyy'), 322864915);
insert into ORDERS (oid, orderdate, sid)
values (40258, to_date('16-10-2023', 'dd-mm-yyyy'), 322864822);
insert into ORDERS (oid, orderdate, sid)
values (40259, to_date('18-12-2022', 'dd-mm-yyyy'), 322864780);
insert into ORDERS (oid, orderdate, sid)
values (40260, to_date('16-01-2022', 'dd-mm-yyyy'), 322864841);
insert into ORDERS (oid, orderdate, sid)
values (40261, to_date('29-04-2023', 'dd-mm-yyyy'), 322864737);
insert into ORDERS (oid, orderdate, sid)
values (40262, to_date('22-12-2021', 'dd-mm-yyyy'), 322864836);
insert into ORDERS (oid, orderdate, sid)
values (40263, to_date('31-01-2023', 'dd-mm-yyyy'), 322864896);
insert into ORDERS (oid, orderdate, sid)
values (40264, to_date('13-06-2020', 'dd-mm-yyyy'), 322864774);
insert into ORDERS (oid, orderdate, sid)
values (40265, to_date('27-05-2022', 'dd-mm-yyyy'), 322864841);
insert into ORDERS (oid, orderdate, sid)
values (40266, to_date('05-02-2020', 'dd-mm-yyyy'), 322864840);
insert into ORDERS (oid, orderdate, sid)
values (40267, to_date('07-09-2022', 'dd-mm-yyyy'), 322864903);
insert into ORDERS (oid, orderdate, sid)
values (40268, to_date('17-01-2021', 'dd-mm-yyyy'), 322864791);
insert into ORDERS (oid, orderdate, sid)
values (40269, to_date('30-03-2023', 'dd-mm-yyyy'), 322864892);
insert into ORDERS (oid, orderdate, sid)
values (40270, to_date('21-10-2022', 'dd-mm-yyyy'), 322864733);
insert into ORDERS (oid, orderdate, sid)
values (40271, to_date('30-08-2021', 'dd-mm-yyyy'), 322864821);
insert into ORDERS (oid, orderdate, sid)
values (40272, to_date('26-05-2021', 'dd-mm-yyyy'), 322864944);
insert into ORDERS (oid, orderdate, sid)
values (40273, to_date('24-03-2023', 'dd-mm-yyyy'), 322864835);
insert into ORDERS (oid, orderdate, sid)
values (40274, to_date('20-02-2023', 'dd-mm-yyyy'), 322864816);
insert into ORDERS (oid, orderdate, sid)
values (40275, to_date('25-01-2022', 'dd-mm-yyyy'), 322864885);
insert into ORDERS (oid, orderdate, sid)
values (40276, to_date('12-10-2022', 'dd-mm-yyyy'), 322864920);
insert into ORDERS (oid, orderdate, sid)
values (40277, to_date('09-02-2023', 'dd-mm-yyyy'), 322864921);
insert into ORDERS (oid, orderdate, sid)
values (40278, to_date('11-04-2022', 'dd-mm-yyyy'), 322864808);
insert into ORDERS (oid, orderdate, sid)
values (40279, to_date('16-04-2021', 'dd-mm-yyyy'), 322864741);
insert into ORDERS (oid, orderdate, sid)
values (40280, to_date('15-08-2022', 'dd-mm-yyyy'), 322864767);
insert into ORDERS (oid, orderdate, sid)
values (40281, to_date('23-07-2022', 'dd-mm-yyyy'), 322864821);
insert into ORDERS (oid, orderdate, sid)
values (40282, to_date('14-03-2023', 'dd-mm-yyyy'), 322864891);
insert into ORDERS (oid, orderdate, sid)
values (40283, to_date('29-11-2020', 'dd-mm-yyyy'), 322864754);
insert into ORDERS (oid, orderdate, sid)
values (40284, to_date('28-05-2020', 'dd-mm-yyyy'), 322864838);
insert into ORDERS (oid, orderdate, sid)
values (40285, to_date('19-07-2022', 'dd-mm-yyyy'), 322864863);
insert into ORDERS (oid, orderdate, sid)
values (40286, to_date('09-04-2020', 'dd-mm-yyyy'), 322864867);
insert into ORDERS (oid, orderdate, sid)
values (40287, to_date('12-06-2020', 'dd-mm-yyyy'), 322864901);
insert into ORDERS (oid, orderdate, sid)
values (40288, to_date('31-10-2023', 'dd-mm-yyyy'), 322864927);
insert into ORDERS (oid, orderdate, sid)
values (40289, to_date('04-06-2021', 'dd-mm-yyyy'), 322864855);
insert into ORDERS (oid, orderdate, sid)
values (40290, to_date('13-03-2024', 'dd-mm-yyyy'), 322864896);
insert into ORDERS (oid, orderdate, sid)
values (40291, to_date('07-05-2022', 'dd-mm-yyyy'), 322864925);
insert into ORDERS (oid, orderdate, sid)
values (40292, to_date('17-02-2020', 'dd-mm-yyyy'), 322864773);
insert into ORDERS (oid, orderdate, sid)
values (40293, to_date('03-04-2022', 'dd-mm-yyyy'), 322864805);
insert into ORDERS (oid, orderdate, sid)
values (40294, to_date('27-05-2021', 'dd-mm-yyyy'), 322864798);
insert into ORDERS (oid, orderdate, sid)
values (40295, to_date('27-11-2021', 'dd-mm-yyyy'), 322864871);
insert into ORDERS (oid, orderdate, sid)
values (40296, to_date('14-04-2022', 'dd-mm-yyyy'), 322864852);
insert into ORDERS (oid, orderdate, sid)
values (40297, to_date('01-09-2020', 'dd-mm-yyyy'), 322864741);
insert into ORDERS (oid, orderdate, sid)
values (40298, to_date('30-06-2021', 'dd-mm-yyyy'), 322864926);
insert into ORDERS (oid, orderdate, sid)
values (40299, to_date('01-08-2021', 'dd-mm-yyyy'), 322864944);
commit;
prompt 400 records committed...
insert into ORDERS (oid, orderdate, sid)
values (40300, to_date('08-05-2023', 'dd-mm-yyyy'), 322864850);
insert into ORDERS (oid, orderdate, sid)
values (40301, to_date('10-07-2021', 'dd-mm-yyyy'), 322864921);
insert into ORDERS (oid, orderdate, sid)
values (40302, to_date('01-08-2021', 'dd-mm-yyyy'), 322864944);
insert into ORDERS (oid, orderdate, sid)
values (40303, to_date('23-06-2021', 'dd-mm-yyyy'), 322864887);
insert into ORDERS (oid, orderdate, sid)
values (40304, to_date('09-04-2021', 'dd-mm-yyyy'), 322864808);
insert into ORDERS (oid, orderdate, sid)
values (40305, to_date('25-11-2022', 'dd-mm-yyyy'), 322864925);
insert into ORDERS (oid, orderdate, sid)
values (40306, to_date('23-07-2023', 'dd-mm-yyyy'), 322864846);
insert into ORDERS (oid, orderdate, sid)
values (40307, to_date('02-01-2021', 'dd-mm-yyyy'), 322864830);
insert into ORDERS (oid, orderdate, sid)
values (40308, to_date('06-01-2022', 'dd-mm-yyyy'), 322864811);
insert into ORDERS (oid, orderdate, sid)
values (40309, to_date('01-03-2020', 'dd-mm-yyyy'), 322864863);
insert into ORDERS (oid, orderdate, sid)
values (40310, to_date('28-11-2020', 'dd-mm-yyyy'), 322864946);
insert into ORDERS (oid, orderdate, sid)
values (40311, to_date('08-02-2023', 'dd-mm-yyyy'), 322864809);
insert into ORDERS (oid, orderdate, sid)
values (40312, to_date('25-01-2021', 'dd-mm-yyyy'), 322864753);
insert into ORDERS (oid, orderdate, sid)
values (40313, to_date('25-03-2021', 'dd-mm-yyyy'), 322864817);
insert into ORDERS (oid, orderdate, sid)
values (40314, to_date('12-12-2020', 'dd-mm-yyyy'), 322864870);
insert into ORDERS (oid, orderdate, sid)
values (40315, to_date('22-04-2023', 'dd-mm-yyyy'), 322864889);
insert into ORDERS (oid, orderdate, sid)
values (40316, to_date('11-04-2020', 'dd-mm-yyyy'), 322864812);
insert into ORDERS (oid, orderdate, sid)
values (40317, to_date('06-06-2020', 'dd-mm-yyyy'), 322864886);
insert into ORDERS (oid, orderdate, sid)
values (40318, to_date('23-05-2023', 'dd-mm-yyyy'), 322864762);
insert into ORDERS (oid, orderdate, sid)
values (40319, to_date('27-03-2023', 'dd-mm-yyyy'), 322864811);
insert into ORDERS (oid, orderdate, sid)
values (40320, to_date('21-01-2023', 'dd-mm-yyyy'), 322864916);
insert into ORDERS (oid, orderdate, sid)
values (40321, to_date('19-02-2023', 'dd-mm-yyyy'), 322864768);
insert into ORDERS (oid, orderdate, sid)
values (40322, to_date('06-03-2021', 'dd-mm-yyyy'), 322864844);
insert into ORDERS (oid, orderdate, sid)
values (40323, to_date('31-03-2020', 'dd-mm-yyyy'), 322864901);
insert into ORDERS (oid, orderdate, sid)
values (40324, to_date('23-01-2021', 'dd-mm-yyyy'), 322864921);
insert into ORDERS (oid, orderdate, sid)
values (40325, to_date('26-02-2020', 'dd-mm-yyyy'), 322864803);
insert into ORDERS (oid, orderdate, sid)
values (40326, to_date('06-07-2023', 'dd-mm-yyyy'), 322864813);
insert into ORDERS (oid, orderdate, sid)
values (40327, to_date('29-06-2021', 'dd-mm-yyyy'), 322864772);
insert into ORDERS (oid, orderdate, sid)
values (40328, to_date('31-08-2020', 'dd-mm-yyyy'), 322864863);
insert into ORDERS (oid, orderdate, sid)
values (40329, to_date('03-09-2021', 'dd-mm-yyyy'), 322864822);
insert into ORDERS (oid, orderdate, sid)
values (40330, to_date('04-02-2022', 'dd-mm-yyyy'), 322864829);
insert into ORDERS (oid, orderdate, sid)
values (40331, to_date('29-11-2020', 'dd-mm-yyyy'), 322864801);
insert into ORDERS (oid, orderdate, sid)
values (40332, to_date('28-05-2021', 'dd-mm-yyyy'), 322864836);
insert into ORDERS (oid, orderdate, sid)
values (40333, to_date('11-06-2023', 'dd-mm-yyyy'), 322864894);
insert into ORDERS (oid, orderdate, sid)
values (40334, to_date('04-07-2023', 'dd-mm-yyyy'), 322864836);
insert into ORDERS (oid, orderdate, sid)
values (40335, to_date('18-08-2022', 'dd-mm-yyyy'), 322864750);
insert into ORDERS (oid, orderdate, sid)
values (40336, to_date('17-01-2021', 'dd-mm-yyyy'), 322864947);
insert into ORDERS (oid, orderdate, sid)
values (40337, to_date('17-09-2023', 'dd-mm-yyyy'), 322864747);
insert into ORDERS (oid, orderdate, sid)
values (40338, to_date('18-05-2020', 'dd-mm-yyyy'), 322864815);
insert into ORDERS (oid, orderdate, sid)
values (40339, to_date('25-11-2022', 'dd-mm-yyyy'), 322864942);
insert into ORDERS (oid, orderdate, sid)
values (40340, to_date('10-12-2020', 'dd-mm-yyyy'), 322864898);
insert into ORDERS (oid, orderdate, sid)
values (40341, to_date('31-08-2020', 'dd-mm-yyyy'), 322864864);
insert into ORDERS (oid, orderdate, sid)
values (40342, to_date('24-04-2024', 'dd-mm-yyyy'), 322864895);
insert into ORDERS (oid, orderdate, sid)
values (40343, to_date('13-11-2020', 'dd-mm-yyyy'), 322864805);
insert into ORDERS (oid, orderdate, sid)
values (40344, to_date('06-11-2022', 'dd-mm-yyyy'), 322864940);
insert into ORDERS (oid, orderdate, sid)
values (40345, to_date('22-02-2021', 'dd-mm-yyyy'), 322864735);
insert into ORDERS (oid, orderdate, sid)
values (40346, to_date('21-01-2020', 'dd-mm-yyyy'), 322864872);
insert into ORDERS (oid, orderdate, sid)
values (40347, to_date('09-01-2023', 'dd-mm-yyyy'), 322864831);
insert into ORDERS (oid, orderdate, sid)
values (40348, to_date('28-08-2021', 'dd-mm-yyyy'), 322864942);
insert into ORDERS (oid, orderdate, sid)
values (40349, to_date('30-01-2021', 'dd-mm-yyyy'), 322864746);
insert into ORDERS (oid, orderdate, sid)
values (40350, to_date('27-11-2020', 'dd-mm-yyyy'), 322864886);
insert into ORDERS (oid, orderdate, sid)
values (40351, to_date('10-10-2023', 'dd-mm-yyyy'), 322864824);
insert into ORDERS (oid, orderdate, sid)
values (40352, to_date('02-05-2020', 'dd-mm-yyyy'), 322864832);
insert into ORDERS (oid, orderdate, sid)
values (40353, to_date('13-07-2023', 'dd-mm-yyyy'), 322864782);
insert into ORDERS (oid, orderdate, sid)
values (40354, to_date('11-06-2023', 'dd-mm-yyyy'), 322864864);
insert into ORDERS (oid, orderdate, sid)
values (40355, to_date('15-08-2023', 'dd-mm-yyyy'), 322864908);
insert into ORDERS (oid, orderdate, sid)
values (40356, to_date('13-03-2023', 'dd-mm-yyyy'), 322864879);
insert into ORDERS (oid, orderdate, sid)
values (40357, to_date('19-01-2024', 'dd-mm-yyyy'), 322864732);
insert into ORDERS (oid, orderdate, sid)
values (40358, to_date('22-12-2023', 'dd-mm-yyyy'), 322864896);
insert into ORDERS (oid, orderdate, sid)
values (40359, to_date('15-06-2023', 'dd-mm-yyyy'), 322864779);
insert into ORDERS (oid, orderdate, sid)
values (40360, to_date('01-09-2020', 'dd-mm-yyyy'), 322864761);
insert into ORDERS (oid, orderdate, sid)
values (40361, to_date('03-07-2020', 'dd-mm-yyyy'), 322864740);
insert into ORDERS (oid, orderdate, sid)
values (40362, to_date('03-02-2022', 'dd-mm-yyyy'), 322864815);
insert into ORDERS (oid, orderdate, sid)
values (40363, to_date('25-04-2021', 'dd-mm-yyyy'), 322864849);
insert into ORDERS (oid, orderdate, sid)
values (40364, to_date('11-08-2022', 'dd-mm-yyyy'), 322864843);
insert into ORDERS (oid, orderdate, sid)
values (40365, to_date('10-12-2020', 'dd-mm-yyyy'), 322864773);
insert into ORDERS (oid, orderdate, sid)
values (40366, to_date('17-02-2020', 'dd-mm-yyyy'), 322864923);
insert into ORDERS (oid, orderdate, sid)
values (40367, to_date('02-06-2020', 'dd-mm-yyyy'), 322864765);
insert into ORDERS (oid, orderdate, sid)
values (40368, to_date('08-09-2021', 'dd-mm-yyyy'), 322864732);
insert into ORDERS (oid, orderdate, sid)
values (40369, to_date('20-03-2023', 'dd-mm-yyyy'), 322864783);
insert into ORDERS (oid, orderdate, sid)
values (40370, to_date('09-11-2022', 'dd-mm-yyyy'), 322864841);
insert into ORDERS (oid, orderdate, sid)
values (40371, to_date('31-01-2022', 'dd-mm-yyyy'), 322864908);
insert into ORDERS (oid, orderdate, sid)
values (40372, to_date('07-11-2022', 'dd-mm-yyyy'), 322864909);
insert into ORDERS (oid, orderdate, sid)
values (40373, to_date('28-05-2023', 'dd-mm-yyyy'), 322864842);
insert into ORDERS (oid, orderdate, sid)
values (40374, to_date('26-04-2024', 'dd-mm-yyyy'), 322864806);
insert into ORDERS (oid, orderdate, sid)
values (40375, to_date('13-02-2021', 'dd-mm-yyyy'), 322864827);
insert into ORDERS (oid, orderdate, sid)
values (40376, to_date('01-06-2020', 'dd-mm-yyyy'), 322864766);
insert into ORDERS (oid, orderdate, sid)
values (40377, to_date('02-05-2022', 'dd-mm-yyyy'), 322864798);
insert into ORDERS (oid, orderdate, sid)
values (40378, to_date('09-04-2021', 'dd-mm-yyyy'), 322864867);
insert into ORDERS (oid, orderdate, sid)
values (40379, to_date('03-04-2021', 'dd-mm-yyyy'), 322864875);
insert into ORDERS (oid, orderdate, sid)
values (40380, to_date('19-09-2023', 'dd-mm-yyyy'), 322864809);
insert into ORDERS (oid, orderdate, sid)
values (40381, to_date('15-05-2021', 'dd-mm-yyyy'), 322864755);
insert into ORDERS (oid, orderdate, sid)
values (40382, to_date('26-06-2022', 'dd-mm-yyyy'), 322864809);
insert into ORDERS (oid, orderdate, sid)
values (40383, to_date('21-04-2022', 'dd-mm-yyyy'), 322864782);
insert into ORDERS (oid, orderdate, sid)
values (40384, to_date('23-07-2021', 'dd-mm-yyyy'), 322864828);
insert into ORDERS (oid, orderdate, sid)
values (40385, to_date('17-09-2020', 'dd-mm-yyyy'), 322864864);
insert into ORDERS (oid, orderdate, sid)
values (40386, to_date('27-03-2023', 'dd-mm-yyyy'), 322864776);
insert into ORDERS (oid, orderdate, sid)
values (40387, to_date('19-12-2022', 'dd-mm-yyyy'), 322864768);
insert into ORDERS (oid, orderdate, sid)
values (40388, to_date('02-08-2021', 'dd-mm-yyyy'), 322864943);
insert into ORDERS (oid, orderdate, sid)
values (40389, to_date('13-02-2020', 'dd-mm-yyyy'), 322864861);
insert into ORDERS (oid, orderdate, sid)
values (40390, to_date('14-12-2023', 'dd-mm-yyyy'), 322864901);
insert into ORDERS (oid, orderdate, sid)
values (40391, to_date('18-09-2021', 'dd-mm-yyyy'), 322864909);
insert into ORDERS (oid, orderdate, sid)
values (40392, to_date('25-01-2024', 'dd-mm-yyyy'), 322864766);
insert into ORDERS (oid, orderdate, sid)
values (40393, to_date('19-02-2022', 'dd-mm-yyyy'), 322864856);
insert into ORDERS (oid, orderdate, sid)
values (40394, to_date('16-10-2022', 'dd-mm-yyyy'), 322864771);
insert into ORDERS (oid, orderdate, sid)
values (40395, to_date('23-02-2020', 'dd-mm-yyyy'), 322864869);
insert into ORDERS (oid, orderdate, sid)
values (40396, to_date('20-04-2022', 'dd-mm-yyyy'), 322864802);
insert into ORDERS (oid, orderdate, sid)
values (40397, to_date('23-03-2020', 'dd-mm-yyyy'), 322864787);
insert into ORDERS (oid, orderdate, sid)
values (40398, to_date('01-09-2021', 'dd-mm-yyyy'), 322864910);
commit;
prompt 499 records loaded
prompt Enabling foreign key constraints for ORDERS...
alter table ORDERS enable constraint SYS_C007223;
prompt Enabling triggers for DONORS...
alter table DONORS enable all triggers;
prompt Enabling triggers for EQUIPMENT...
alter table EQUIPMENT enable all triggers;
prompt Enabling triggers for SUPPLIERS...
alter table SUPPLIERS enable all triggers;
prompt Enabling triggers for ORDERS...
alter table ORDERS enable all triggers;
set feedback on
set define on
prompt Done.
