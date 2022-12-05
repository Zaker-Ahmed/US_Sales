--Script_2 
--Creating Indexes, Views & Indexed Views

--SSIS was used to create an ETL package to dump data from the cleaned Excel file (US_Sales_Data_Cleaned.xlsx)
--into each table, whilst adhering to the schema within the US_Sales DB



USE US_Sales;

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



--CREATE VIEW 

SELECT SO.OrderNumber AS Order_Number,
CTMR.CustomerName AS Customer,
ST.SalesTeam AS Sales_Team_Manager,
SR.SalesCardinalRegion,
SL.SalesChannel,
SO.OrderDate,
SO.ShipDate,
SO.DeliveryDate,
P.ProductName,
SO.OrderQuantity,
SO.UnitCost,
SO.UnitPrice,
SO.DiscountPerUnit,
SO.TotalCost,
SO.GrossRevenue,
SO.NetRevenue
FROM SalesOrder AS SO
LEFT JOIN Product AS P
ON SO.ProductID = P.ProductID
LEFT JOIN Customer AS CTMR
ON SO.CustomerID = CTMR.CustomerID
LEFT JOIN SalesTeam AS ST
ON SO.SalesTeamID = ST.SalesTeamID
LEFT JOIN SalesRegion AS SR
ON ST.SalesRegionID = SR.SalesRegionID
LEFT JOIN SalesChannel AS SL
ON ST.SalesChannelID = SL.SalesChannelID
--ORDER BY
;


-- can make a decision tree view by grouping net revenue by sales channel and add column that disploys the total 
-- can also concatenate the net revenue to a calculation that displays the revenue %


--limiting results for query optimisation
--elapsed time displays the ms response time to complete the query