
[General]
Version=1

[Preferences]
Username=
Password=2249
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=HILA
Name=EQUIP_ORDER
Count=400

[Record]
Name=AMOUNTINORDER
Type=NUMBER
Size=
Data=Random(2, 75)
Master=

[Record]
Name=EID
Type=NUMBER
Size=5
Data=List(select eID from Equipment)
Master=

[Record]
Name=OID
Type=NUMBER
Size=5
Data=Sequence(39999, [1], [40399])
Master=

