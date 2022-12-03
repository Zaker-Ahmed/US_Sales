CREATE DATABASE US_Sales;
GO

USE US_Sales;
GO

CREATE SCHEMA Business_Data;
GO

--
--Table structure for Sales Channel
--

CREATE TABLE SalesChannel(
SalesChannelID INT,
SalesChannel NVARCHAR(100) NOT NULL,
CONSTRAINT PK_SalesChannelID PRIMARY KEY (SalesChannelID)
);

--
--Table structure for Sales Region
--

CREATE TABLE SalesRegion(
SalesRegionID INT,
SalesCardinalRegion NVARCHAR(15) NOT NULL,
CONSTRAINT PK_SalesRegionID PRIMARY KEY (SalesRegionID)
);

--
--Table structure for Sales Team
--

CREATE TABLE SalesTeam(
SalesTeamID INT,
SalesTeam NVARCHAR(255) NOT NULL,
SalesChannelID INT,
SalesRegionID INT,
CONSTRAINT PK_SalesTeamID PRIMARY KEY (SalesTeamID),
CONSTRAINT FK_SalesTeam_SalesChannel FOREIGN KEY (SalesChannelID) REFERENCES SalesChannel (SalesChannelID) ON DELETE SET NULL,
CONSTRAINT FK_SalesTeam_SalesRegion FOREIGN KEY (SalesRegionID) REFERENCES SalesRegion (SalesRegionID) ON DELETE SET NULL
);
--SET NULL was used due to the potential removal or withdrawl of operating within a region or trhough a certain channel
--does not inherently mean the employee is fired and should be removed trhough the use of CASCADE.
--Setting the column to null allows the possibility for the business to assign a sales team to a different region or sales channel.

--
--Table structure for Customer
--

CREATE TABLE Customer(
CustomerID INT,
CustomerName NVARCHAR(255) NOT NULL,
CONSTRAINT PK_CustomerID PRIMARY KEY (CustomerID)
);

--
--Table structure for Product
--

CREATE TABLE Product(
ProductID INT,
ProductName NVARCHAR(255) NOT NULL,
CONSTRAINT PK_ProductID PRIMARY KEY (ProductID)
);

--
--Table structure for Warehouse
--

CREATE TABLE Warehouse(
WarehouseID INT,
WarehouseCode NVARCHAR(15) NOT NULL,
CONSTRAINT PK_WarehouseID PRIMARY KEY (WarehouseID)
);

--
--Table structure for Store Region
--

CREATE TABLE StoreRegion(
StoreRegionID INT,
StoreCardinalRegion NVARCHAR(15) NOT NULL,
CONSTRAINT PK_StoreRegionID PRIMARY KEY (StoreRegionID)
);

--
--Table structure for Time Zone
--

CREATE TABLE TimeZone(
TimeZoneID INT,
TimeZone NVARCHAR(255) NOT NULL,
CONSTRAINT PK_TimeZoneID PRIMARY KEY (TimeZoneID)
);

--
--Table structure for state
--

--The plural was used due to "State" being a system reserved word
CREATE TABLE States(
StateID INT,
StateName NVARCHAR(255) NOT NULL,
StateCode NVARCHAR(2) UNIQUE NOT NULL,
StoreRegionID INT,
TimeZoneID INT,
CONSTRAINT PK_StateID PRIMARY KEY (StateID),
CONSTRAINT FK_States_TimeZone FOREIGN KEY (TimeZoneID) REFERENCES TimeZone (TimeZoneID) ON DELETE CASCADE,
CONSTRAINT FK_States_StoreRegion FOREIGN KEY (StoreRegionID) REFERENCES StoreRegion (StoreRegionID) ON DELETE CASCADE
);

--
--Table structure for County
--

CREATE TABLE County(
CountyID INT,
CountyName NVARCHAR(255) NOT NULL,
StateID INT,
CONSTRAINT PK_CountyID PRIMARY KEY (CountyID),
CONSTRAINT FK_County_States FOREIGN KEY (StateID) REFERENCES States (StateID) ON DELETE CASCADE
);

--
--Table structure for AreaType
--

CREATE TABLE AreaType(
AreaTypeID INT,
Area NVARCHAR(25) NOT NULL,
CONSTRAINT PK_AreaTypeID PRIMARY KEY (AreaTypeID)
);

--
--Table structure for City
--

CREATE TABLE City(
CityID INT,
CityName NVARCHAR(255) NOT NULL,
AreaTypeID INT,
CountyID INT,
CONSTRAINT PK_CityID PRIMARY KEY (CityID),
CONSTRAINT FK_City_AreaType FOREIGN KEY (AreaTypeID) REFERENCES AreaType (AreaTypeID) ON DELETE CASCADE,
CONSTRAINT FK_City_County FOREIGN KEY (CountyID) REFERENCES County (CountyID) ON DELETE CASCADE
);

--
--Table structure for Store
--

CREATE TABLE Store(
StoreID INT,
Latitude FLOAT(12) NOT NULL,
Longitude FLOAT(12) NOT NULL,
AreaCode INT NOT NULL,
AreaPopulation INT,
HouseholdIncome INT,
MedianIncome INT,
LandArea INT,
WaterArea INT,
CityID INT,
CONSTRAINT PK_StoreID PRIMARY KEY (StoreID),
CONSTRAINT FK_Store_City FOREIGN KEY (CityID) REFERENCES City (CityID) ON DELETE CASCADE
);

--
--Table structure for Sales Order
--

CREATE TABLE SalesOrder(
OrderID INT,
OrderNumber NVARCHAR(255) UNIQUE NOT NULL,
ProcuredDate DATE NOT NULL,
OrderDate DATE NOT NULL,
ShipDate DATE NOT NULL,
DeliveryDate DATE NOT NULL,
OrderQuantity SMALLINT DEFAULT 1 NOT NULL,
UnitCost NUMERIC(10,2) NOT NULL,
UnitPrice NUMERIC(10,2) NOT NULL,
DiscountPerUnit NUMERIC(10,2) NOT NULL,
TotalCost NUMERIC(10,2) NOT NULL,
GrossRevenue NUMERIC(10,2) NOT NULL,
NetRevenue NUMERIC(10,2) NOT NULL,
SalesTeamID INT,
CustomerID INT,
StoreID INT,
ProductID INT,
WarehouseID INT,
CONSTRAINT PK_OrderID PRIMARY KEY (OrderID),
CONSTRAINT FK_SalesOrder_SalesTeam FOREIGN KEY (SalesTeamID) REFERENCES SalesTeam (SalesTeamID),
CONSTRAINT FK_SalesOrder_Customer FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID),
CONSTRAINT FK_SalesOrder_Store FOREIGN KEY (StoreID) REFERENCES Store (StoreID),
CONSTRAINT FK_SalesOrder_Product FOREIGN KEY (ProductID) REFERENCES Product (ProductID),
CONSTRAINT FK_SalesOrder_Warehouse FOREIGN KEY (WarehouseID) REFERENCES Warehouse (WarehouseID) 
);

GO

--
--Disabling FK constraints for Sales Order
--

--Disabling Foreign Key constraints to avoid errors regarding the reference column/table not currently existing so that the
--cleaned data can be imported into the tables whilst adhering to the schema through an integration package via SSIS
ALTER TABLE SalesOrder NOCHECK CONSTRAINT FK_SalesOrder_SalesTeam;
ALTER TABLE SalesOrder NOCHECK CONSTRAINT FK_SalesOrder_Customer;
ALTER TABLE SalesOrder NOCHECK CONSTRAINT FK_SalesOrder_Store;
ALTER TABLE SalesOrder NOCHECK CONSTRAINT FK_SalesOrder_Product;
ALTER TABLE SalesOrder NOCHECK CONSTRAINT FK_SalesOrder_Warehouse;

--
--Disabling FK constraints for Store
--

ALTER TABLE Store NOCHECK CONSTRAINT FK_Store_City;

--
--Disabling FK constraints for City
--

ALTER TABLE City NOCHECK CONSTRAINT FK_City_AreaType;
ALTER TABLE City NOCHECK CONSTRAINT FK_City_County;

--
--Disabling FK constraints for County
--

ALTER TABLE County NOCHECK CONSTRAINT FK_County_States;

--
--Disabling FK constraints for State
--

ALTER TABLE States NOCHECK CONSTRAINT FK_States_TimeZone;
ALTER TABLE States NOCHECK CONSTRAINT FK_States_StoreRegion;

--
--Disabling FK constraints for Sales Team
--

ALTER TABLE SalesTeam NOCHECK CONSTRAINT FK_SalesTeam_SalesChannel;
ALTER TABLE SalesTeam NOCHECK CONSTRAINT FK_SalesTeam_SalesRegion;
