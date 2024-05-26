
[General]
Version=1

[Preferences]
Username=
Password=2980
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=TAHAYAT
Name=VEHICLESREPAIRS
Count=400

[Record]
Name=RID
Type=NUMBER
Size=5
Data=Sequence(62010, [1], [62410])
Master=

[Record]
Name=VID
Type=NUMBER
Size=8
Data=List(select vid from vehicles)
Master=

