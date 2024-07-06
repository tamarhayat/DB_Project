
[General]
Version=1

[Preferences]
Username=
Password=2140
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=TAHAYAT
Name=EQUIP_ORDER
Count=200

[Record]
Name=AMOUNTINORDER
Type=NUMBER
Size=
Data=Random(5, 20)
Master=

[Record]
Name=EID
Type=NUMBER
Size=5
Data=List(select eid from equipment)
Master=

[Record]
Name=OID
Type=NUMBER
Size=5
Data=List(select oid from orders)
Master=

