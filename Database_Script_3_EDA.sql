--Script_3-DML
--EDA - Exploratory data analysis

USE US_Sales;

GO

SELECT TOP 10 * FROM VIEW_Sales_Order_Sheet;





SELECT Sales_Channel,
SUM(Total_Cost) AS Total_Cost,
SUM(Gross_Revenue) AS Gross_Revenue,
SUM(Net_Revenue) AS Net_Revenue
FROM View_Sales_Order_Sheet
GROUP BY Sales_Channel
ORDER BY Net_Revenue DESC;

/*
| Sales_Channel  | Total_Cost  | Gross_Revenue  | Net_Revenue  |
----------------------------------------------------------------
| In-Store       | 20294451.47 | 32434475.14    | 12139648.57  |
| Online         | 17087478.42 | 27068375.05    | 9980573.38   |
| Distributor    | 9247362.39  | 14798480.40    | 5550953.78   |
| Wholesale      | 5188736.49  | 8387266.55     | 3198433.69   |
*/





SELECT TOP 10 Product, 
COUNT(Product) AS Product_Quantity_Sold
FROM VIEW_Sales_Order_Sheet
GROUP BY Product
ORDER BY Product_Quantity_Sold DESC;

/*
| Product          | Product_Quantity_Sold |
--------------------------------------------
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
*/

-- CAN DO TOP PERFORMING CITY, STATE AND SALES TEAM 
/*
SELECT City,
SUM(Net_Revenue)	
FROM VIEW_Sales_Order_Sheet
GROUP BY Net_Revenue
ORDER BY Net_Revenue DESC;
*/


SELECT DISTINCT YEAR(Order_Date) AS Year_,
SUM(Net_Revenue) AS Net_Revenue
FROM VIEW_Sales_Order_Sheet
GROUP BY YEAR(Order_Date)
ORDER BY YEAR(Order_Date) DESC;

/*
| Year | Net_Revenue |
----------------------
| 2020 | 11873519.10 |
| 2019 | 11859153.32 |
| 2018 | 7136937.00  |
*/


SELECT DISTINCT Discount_Per_Unit AS Discount,
AVG(Order_Quantity) AS Average_Order_Quantity,
SUM(Order_Quantity) AS Total_Order_Quantity
FROM VIEW_Sales_Order_Sheet
GROUP BY Discount_Per_Unit
ORDER BY Discount_Per_Unit ASC;

/*
| Discount | Average_Order_Quantity | Total_Order_Quantity |
------------------------------------------------------------
| 0.05     |4                       |10694                 |
| 0.07     |4                       |9174                  |
| 0.10     |4                       |6049                  |
| 0.15     |4                       |4247                  |
| 0.20     |4                       |2971                  |
| 0.30     |4                       |1452                  |
| 0.40     |4                       |1575                  |
*/
