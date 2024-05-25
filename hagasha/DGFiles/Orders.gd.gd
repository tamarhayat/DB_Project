
[General]
Version=1

[Preferences]
Username=
Password=2592
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=TAHAYAT
Name=ORDERS
Count=400

[Record]
Name=OID
Type=NUMBER
Size=5
Data=Sequence(39999, [1], [40399])
Master=

[Record]
Name=ORDERDATE
Type=DATE
Size=
Data=Random(1/1/2020, 22/5/2024)
Master=

[Record]
Name=SID
Type=NUMBER
Size=9
Data=List(select sID from Suppliers)
Master=

