
[General]
Version=1

[Preferences]
Username=
Password=2591
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=HILA
Name=EQUIPREPAIRS
Count=400

[Record]
Name=RID
Type=NUMBER
Size=5
Data=List(select rID from Repairs)
Master=

[Record]
Name=EID
Type=NUMBER
Size=
Data=List(select eID from Equipment)
Master=

