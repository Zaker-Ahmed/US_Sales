--Script_3-DML
--EDA - Exploratory Data Analysis

USE US_Sales;

GO

--
--Testing view
--
SELECT * FROM VIEW_Sales_Order_Sheet;

GO


--
--Sales Channel performance
--

SELECT Sales_Channel,
SUM(Total_Cost) AS Total_Cost,
SUM(Gross_Revenue) AS Gross_Revenue,
SUM(Net_Revenue) AS Net_Revenue
FROM View_Sales_Order_Sheet
GROUP BY Sales_Channel
ORDER BY Net_Revenue DESC;

/*
|----------------|-------------|----------------|--------------|
| Sales_Channel  | Total_Cost  | Gross_Revenue  | Net_Revenue  |
|----------------|-------------|----------------|--------------|
| In-Store       | 20294451.47 | 32434475.14    | 12139648.57  |
| Online         | 17087478.42 | 27068375.05    | 9980573.38   |
| Distributor    | 9247362.39  | 14798480.40    | 5550953.78   |
| Wholesale      | 5188736.49  | 8387266.55     | 3198433.69   |
|----------------|-------------|----------------|--------------|
*/



--
--Top performing products
--

SELECT TOP 10 Product, 
COUNT(Product) AS Product_Quantity_Sold
FROM VIEW_Sales_Order_Sheet
GROUP BY Product
ORDER BY Product_Quantity_Sold DESC;

/*
|------------------|-----------------------|
| Product          | Product_Quantity_Sold |
|------------------|-----------------------|
| Platters         | 200                   |
| Serveware        | 200                   |
| Cocktail Glasses | 195                   |
| Accessories      | 194                   |
| Wreaths          | 190                   |
| Rugs             | 184                   |
| Wardrobes        | 183                   |
| Ornaments        | 182                   |
| Sculptures       | 182                   |
| Dining Furniture | 181                   |
|------------------|-----------------------|
*/



--
--Worst performing products
--

SELECT TOP 10 Product, 
COUNT(Product) AS Product_Quantity_Sold
FROM VIEW_Sales_Order_Sheet
GROUP BY Product
ORDER BY Product_Quantity_Sold ASC;

/*
|-------------------|-----------------------|
| Product           | Product_Quantity_Sold |
|-------------------|-----------------------|
| Pillows           | 126                   |
| Vases             | 145                   |
| Bean Bags         | 147                   |
| Bedroom Furniture | 152                   |
| Audio             | 152                   |
| Computers         | 154                   |
| Basketball        | 156                   |
| Wall Coverings    | 156                   |
| Outdoor Furniture | 157                   |
| Candles           | 158                   |
|-------------------|-----------------------|
*/



--
--Most profitable cities
--

SELECT DISTINCT TOP 10 City,
SUM(Net_Revenue) AS City_Net_Revenue
FROM VIEW_Sales_Order_Sheet
GROUP BY City
ORDER BY City_Net_Revenue DESC;

/*
|--------------|------------------|
| City         | City_Net_Revenue |
|--------------|------------------|
| Springfield  | 252060.45        |
| Columbia     | 247809.09        |
| Richmond     | 216021.73        |
| Rochester    | 212053.42        |
| Warren       | 196691.40		    |
| Wayne        | 196336.16		    |
| Broken Arrow | 196027.62		    |
| Arlington    | 184371.82		    |
| Aurora       | 174426.52		    |
| Hollywood    | 170216.46		    |
|--------------|------------------|
*/



--
--Most profitable States
--

SELECT DISTINCT TOP 10 State_,
SUM(Net_Revenue) AS State_Net_Revenue
FROM VIEW_Sales_Order_Sheet
GROUP BY State_
ORDER BY State_Net_Revenue DESC;

/*
|----------------|-------------------|
| State_         | State_Net_Revenue |
|----------------|-------------------|
| California     | 5993915.15        |
| Texas          | 2956349.50        |
| Illinois       | 2627265.88        |
| Florida        | 2167262.46        |
| Colorado       | 1772840.67	       |
| Indiana        | 1222118.60		     |
| Arizona        | 1041353.13		     |
| New York       | 905024.83	       |
| North Carolina | 820274.97	       |
| Hollywood      | 777108.48	       |
|----------------|-------------------|
*/



--
--Sales Team Performance 
--

SELECT DISTINCT TOP 10 Sales_Team_Manager,
COUNT(Order_Number) AS Total_Sales_Secured,
SUM(Order_Quantity) AS Total_Units_Sold
FROM VIEW_Sales_Order_Sheet
GROUP BY Sales_Team_Manager
ORDER BY Total_Sales_Secured DESC, Total_Units_Sold DESC;

/*
|--------------------|---------------------|------------------|
| Sales_Team_Manager | Total_Sales_Secured | Total_Units_Sold |
|--------------------|---------------------|------------------|
| Todd Roberts		   | 340				         | 1474			        |
| Shawn Wallace		   | 316				         | 1476			        |
| George Lewis		   | 315				         | 1409			        |
| Carl Nguyen		     | 314				         | 1393			        |
| Shawn Cook		     | 303				         | 1306			        |
| Adam Hernandez     | 302				         | 1366			        |
| Anthony Berry		   | 298				         | 1337			        |
| Donald Reynolds	   | 296				         | 1391			        |
| Samuel Fowler		   | 296				         | 1388			        |
| Jerry Green		     | 296				         | 1371			        |
|--------------------|---------------------|------------------|
*/



--
--Annual performance
--

SELECT DISTINCT YEAR(Order_Date) AS Year_,
SUM(Net_Revenue) AS Net_Revenue
FROM VIEW_Sales_Order_Sheet
GROUP BY YEAR(Order_Date)
ORDER BY YEAR(Order_Date) DESC;

/*
|------|-------------|
| Year | Net_Revenue |
|------|-------------|
| 2020 | 11873519.10 |
| 2019 | 11859153.32 |
| 2018 | 7136937.00  |
|------|-------------|
*/



--
--Sales impact based on discount
--

SELECT DISTINCT Discount_Per_Unit AS Discount,
AVG(Order_Quantity) AS Average_Order_Quantity,
SUM(Order_Quantity) AS Total_Order_Quantity
FROM VIEW_Sales_Order_Sheet
GROUP BY Discount_Per_Unit
ORDER BY Discount_Per_Unit ASC;

/*
|----------|------------------------|----------------------|
| Discount | Average_Order_Quantity | Total_Order_Quantity |
|----------|------------------------|----------------------|
| 0.05     | 4                      | 10694                |
| 0.07     | 4                      | 9174                 |
| 0.10     | 4                      | 6049                 |
| 0.15     | 4                      | 4247                 |
| 0.20     | 4                      | 2971                 |
| 0.30     | 4                      | 1452                 |
| 0.40     | 4                      | 1575                 |
|----------|------------------------|----------------------|
*/
