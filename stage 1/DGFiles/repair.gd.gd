
[General]
Version=1

[Preferences]
Username=
Password=2392
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=HILA
Name=REPAIRS
Count=120

[Record]
Name=RID
Type=NUMBER
Size=5
Data=Sequence(62290, [1], [62410])
Master=

[Record]
Name=REPAIRDATE
Type=DATE
Size=
Data=Random(1/1/2021,22/5/2024 )
Master=

[Record]
Name=DESCRIPTION
Type=VARCHAR2
Size=255
Data=List(' overheating', 'poor fuel mixture','oil leaks',
='lack of maintenance','engine failure','Worn brake pads',
='malfunctioning brake lines', 'fluid leaks','leaking brake fluid',
='brake issues', 'Tire Problems' ,'Battery problems',
='electronic systems')  
Master=

