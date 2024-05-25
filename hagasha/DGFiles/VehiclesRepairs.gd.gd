
[General]
Version=1

[Preferences]
Username=
Password=2647
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=HILA
Name=VEHICLESREPAIRS
Count=400

[Record]
Name=RID
Type=NUMBER
Size=5
Data=List(select rID from Repairs)
Master=

[Record]
Name=VID
Type=NUMBER
Size=8
Data=List(select Vid from Vehicles)
Master=

