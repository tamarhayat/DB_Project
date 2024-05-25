
[General]
Version=1

[Preferences]
Username=
Password=2590
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=TAHAYAT
Name=DONORS
Count=400

[Record]
Name=DID
Type=NUMBER
Size=9
Data=Sequence(322498461, [1], [322498861]) 
Master=

[Record]
Name=DNAME
Type=VARCHAR2
Size=30
Data=FirstName  '  ' LastName
Master=

[Record]
Name=ADDRESS
Type=VARCHAR2
Size=100
Data=Address1 ', ' + City ', '   Country
Master=

[Record]
Name=PHONENUMBER
Type=VARCHAR2
Size=15
Data='05' +Random(0, 9)+ '-'+ Random(1111111, 9999999)
Master=

