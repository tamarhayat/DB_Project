
[General]
Version=1

[Preferences]
Username=
Password=2463
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=HILA
Name=VEHICLE_EQUIP
Count=400

[Record]
Name=EQUIPAMOUNT
Type=NUMBER
Size=
Data=Random(1,25)
Master=

[Record]
Name=EID
Type=NUMBER
Size=5
Data=List(select eID from Equipment)
Master=

[Record]
Name=VID
Type=NUMBER
Size=8
Data=List(select Vid from Vehicles)
Master=

