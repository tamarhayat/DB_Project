


-- Create the Suppliers table
CREATE TABLE Suppliers
(
  sID INT NOT NULL,
  sname VARCHAR2(30) NOT NULL,
  address VARCHAR2(100) NOT NULL,
  phoneNumber VARCHAR2(15) NOT NULL,
  PRIMARY KEY (sID)
);
-- Create the Equipment table
CREATE TABLE Equipment
(
  eID INT NOT NULL,
  ename VARCHAR2(30) NOT NULL,
  isMobile VARCHAR2(5) NOT NULL,
  quantity INT NOT NULL,
  supplierId INT NOT NULL,
  PRIMARY KEY (eID),
  FOREIGN KEY (supplierId) REFERENCES Suppliers(sID),
  CHECK (isMobile IN ('true', 'false'))
);

-- Create the Orders table
CREATE TABLE Orders
(
  oID INT NOT NULL,
  orderDate DATE NOT NULL,
  total FLOAT NOT NULL,
  sID INT NOT NULL,
  PRIMARY KEY (oID),
  FOREIGN KEY (sID) REFERENCES Suppliers(sID)
);

-- Create the Donors table
CREATE TABLE Donors
(
  dID INT NOT NULL,
  dname VARCHAR2(30) NOT NULL,
  address VARCHAR2(100) NOT NULL,
  phoneNumber VARCHAR2(15) NOT NULL,
  PRIMARY KEY (dID)
);

-- Create the Repairs table
CREATE TABLE Repairs
(
  rID INT NOT NULL,
  repairDate DATE NOT NULL,
  description VARCHAR2(255) NOT NULL,
  PRIMARY KEY (rID)
);

-- Create the EquipRepairs table
CREATE TABLE EquipRepairs
(
  rID INT NOT NULL,
  eID INT NOT NULL,
  PRIMARY KEY (rID, eID),
  FOREIGN KEY (rID) REFERENCES Repairs(rID),
  FOREIGN KEY (eID) REFERENCES Equipment(eID)
);

-- Create the equip_order table
CREATE TABLE equip_order
(
  amountInOrder INT NOT NULL,
  eID INT NOT NULL,
  oID INT NOT NULL,
  PRIMARY KEY (eID, oID),
  FOREIGN KEY (eID) REFERENCES Equipment(eID),
  FOREIGN KEY (oID) REFERENCES Orders(oID)
);

-- Create the Vehicles table
CREATE TABLE Vehicles
(
  vID INT NOT NULL,
  type VARCHAR2(12) NOT NULL,
  status VARCHAR2(12) NOT NULL,
  dID INT NOT NULL,
  PRIMARY KEY (vID),
  FOREIGN KEY (dID) REFERENCES Donors(dID),
  CHECK (type IN ('ambulance', 'helicopter', 'motorcycle'))
);

-- Create the VehiclesRepairs table
CREATE TABLE VehiclesRepairs
(
  rID INT NOT NULL,
  vID INT NOT NULL,
  PRIMARY KEY (rID, vID),
  FOREIGN KEY (rID) REFERENCES Repairs(rID),
  FOREIGN KEY (vID) REFERENCES Vehicles(vID)
);

-- Create the vehicle_equip table
CREATE TABLE vehicle_equip
(
  equipAmount INT NOT NULL,
  eID INT NOT NULL,
  vID INT NOT NULL,
  PRIMARY KEY (eID, vID),
  FOREIGN KEY (eID) REFERENCES Equipment(eID),
  FOREIGN KEY (vID) REFERENCES Vehicles(vID)
);



