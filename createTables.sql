


-- Create the Suppliers table
CREATE TABLE Suppliers
(
  sID NUMBER(9) NOT NULL,
  sname VARCHAR2(30) NOT NULL,
  address VARCHAR2(100) NOT NULL,
  phoneNumber VARCHAR2(15) NOT NULL,
  PRIMARY KEY (sID)
);
-- Create the Equipment table
CREATE TABLE Equipment
(
  eID NUMBER(5) NOT NULL,
  ename VARCHAR2(30) NOT NULL,
  isMobile VARCHAR2(5) NOT NULL,
  quantity INT NOT NULL,
  price NUMBER(7,2) NOT NULL,
  PRIMARY KEY (eID),
  CHECK (isMobile IN ('true', 'false'))
);

-- Create the Orders table
CREATE TABLE Orders
(
  oID NUMBER(5) NOT NULL,
  orderDate DATE NOT NULL,
  sID NUMBER(9) NOT NULL,
  PRIMARY KEY (oID),
  FOREIGN KEY (sID) REFERENCES Suppliers(sID)
);

-- Create the Donors table
CREATE TABLE Donors
(
  dID NUMBER(9) NOT NULL,
  dname VARCHAR2(30) NOT NULL,
  address VARCHAR2(100) NOT NULL,
  phoneNumber VARCHAR2(15) NOT NULL,
  PRIMARY KEY (dID)
);

-- Create the Repairs table
CREATE TABLE Repairs
(
  rID NUMBER(5) NOT NULL,
  repairDate DATE NOT NULL,
  description VARCHAR2(255) NOT NULL,
  PRIMARY KEY (rID)
);

-- Create the EquipRepairs table
CREATE TABLE EquipRepairs
(
  rID NUMBER(5) NOT NULL,
  eID INT NOT NULL,
  PRIMARY KEY (rID, eID),
  FOREIGN KEY (rID) REFERENCES Repairs(rID),
  FOREIGN KEY (eID) REFERENCES Equipment(eID)
);

-- Create the equip_order table
CREATE TABLE equip_order
(
  amountInOrder INT NOT NULL,
  eID NUMBER(5) NOT NULL,
  oID NUMBER(5) NOT NULL,
  PRIMARY KEY (eID, oID),
  FOREIGN KEY (eID) REFERENCES Equipment(eID),
  FOREIGN KEY (oID) REFERENCES Orders(oID)
);

-- Create the Vehicles table
CREATE TABLE Vehicles
(
  vID NUMBER(8) NOT NULL,
  type VARCHAR2(12) NOT NULL,
  status VARCHAR2(12) NOT NULL,
  dID NUMBER(9) NOT NULL,
  PRIMARY KEY (vID),
  FOREIGN KEY (dID) REFERENCES Donors(dID),
  CHECK (type IN ('ambulance', 'helicopter', 'motorcycle'))
  CHECK (status IN ('normal', 'not normal', 'under repair'))
);

-- Create the VehiclesRepairs table
CREATE TABLE VehiclesRepairs
(
  rID NUMBER(5) NOT NULL,
  vID NUMBER(8) NOT NULL,
  PRIMARY KEY (rID, vID),
  FOREIGN KEY (rID) REFERENCES Repairs(rID),
  FOREIGN KEY (vID) REFERENCES Vehicles(vID)
);

-- Create the vehicle_equip table
CREATE TABLE vehicle_equip
(
  equipAmount INT NOT NULL,
  eID NUMBER(5) NOT NULL,
  vID NUMBER(8) NOT NULL,
  PRIMARY KEY (eID, vID),
  FOREIGN KEY (eID) REFERENCES Equipment(eID),
  FOREIGN KEY (vID) REFERENCES Vehicles(vID)
);



