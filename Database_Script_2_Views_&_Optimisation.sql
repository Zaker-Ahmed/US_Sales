--Script_2 
--Creating Indexes, Views & Indexed Views

--SSIS was used to create an ETL package to dump data from the cleaned Excel file (US_Sales_Data_Cleaned.xlsx)
--into each table, whilst adhering to the schema within the US_Sales DB

USE US_Sales;

GO

--Re-enabling FK's to maintain referential integrity

--
--Re-enabling FK constraints for Sales Order
--

ALTER TABLE SalesOrder WITH CHECK CHECK CONSTRAINT FK_SalesOrder_SalesTeam;
ALTER TABLE SalesOrder WITH CHECK CHECK CONSTRAINT FK_SalesOrder_Customer;
ALTER TABLE SalesOrder WITH CHECK CHECK CONSTRAINT FK_SalesOrder_Store;
ALTER TABLE SalesOrder WITH CHECK CHECK CONSTRAINT FK_SalesOrder_Product;
ALTER TABLE SalesOrder WITH CHECK CHECK CONSTRAINT FK_SalesOrder_Warehouse;

--
--Re-enabling FK constraints for Store
--

ALTER TABLE Store WITH CHECK CHECK CONSTRAINT FK_Store_City;

--
--Re-enabling FK constraints for City
--

ALTER TABLE City WITH CHECK CHECK CONSTRAINT FK_City_AreaType;
ALTER TABLE City WITH CHECK CHECK CONSTRAINT FK_City_County;

--
--Re-enabling FK constraints for County
--

ALTER TABLE County WITH CHECK CHECK CONSTRAINT FK_County_States;

--
--Re-enabling FK constraints for State
--

ALTER TABLE States WITH CHECK CHECK CONSTRAINT FK_States_TimeZone;
ALTER TABLE States WITH CHECK CHECK CONSTRAINT FK_States_StoreRegion;

--
--Re-enabling FK constraints for Sales Team
--

ALTER TABLE SalesTeam WITH CHECK CHECK CONSTRAINT FK_SalesTeam_SalesChannel;
ALTER TABLE SalesTeam WITH CHECK CHECK CONSTRAINT FK_SalesTeam_SalesRegion;

GO

CREATE INDEX IDX_SalesOrder_OrderNumber_Search
ON SalesOrder (OrderNumber ASC); 

CREATE INDEX IDX_SalesOrder_OrderDate_Search
ON SalesOrder (OrderDate DESC);

GO

--
--CREATE VIEW 
--

CREATE VIEW Sales_Order_Sheet AS
SELECT SO.OrderNumber AS Order_Number,
CSTMR.CustomerName AS Customer,
ST.SalesTeam AS Sales_Team_Manager,
SC.SalesChannel AS Sales_Channel,
SR.SalesCardinalRegion AS Sales_Region,
STTS.StateName AS State_,
STTS.StateCode AS State_Code,
CNTY.CountyName AS County,
C.CityName AS City,
S.AreaCode AS Area_Code,
AREAT.Area AS Area_Type,
SO.OrderDate AS Order_Date,
SO.ShipDate AS Ship_Date,
SO.DeliveryDate AS Delivery_Date,
P.ProductName AS Product,
SO.OrderQuantity AS Order_Quantity,
SO.UnitCost AS Unit_Cost,
SO.UnitPrice AS Unit_Price,
SO.DiscountPerUnit AS Discount_Per_Unit,
SO.TotalCost AS Total_Cost,
SO.GrossRevenue AS Gross_Revenue,
SO.NetRevenue AS Net_Revenue
FROM SalesOrder AS SO
LEFT JOIN Product AS P
ON SO.ProductID = P.ProductID
LEFT JOIN Customer AS CSTMR
ON SO.CustomerID = CSTMR.CustomerID
LEFT JOIN SalesTeam AS ST
ON SO.SalesTeamID = ST.SalesTeamID
LEFT JOIN SalesRegion AS SR
ON ST.SalesRegionID = SR.SalesRegionID
LEFT JOIN SalesChannel AS SC
ON ST.SalesChannelID = SC.SalesChannelID
LEFT JOIN Store AS S
ON SO.StoreID = S.StoreID
LEFT JOIN City AS C
ON S.CityID = C.CityID
LEFT JOIN County AS CNTY
ON C.CountyID = CNTY.CountyID
LEFT JOIN States AS STTS
ON CNTY.StateID = STTS.StateID
LEFT JOIN AreaType AS AREAT
ON C.AreaTypeID = AREAT.AreaTypeID
;

GO
