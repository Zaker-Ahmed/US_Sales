SELECT TOP 10 * FROM Sales_Order_Sheet;

SELECT Sales_Channel,
SUM(Total_Cost) AS Total_Cost,
SUM(Gross_Revenue) AS Gross_Revenue,
SUM(Net_Revenue) AS Net_Revenue
FROM Sales_Order_Sheet
GROUP BY Sales_Channel
ORDER BY Net_Revenue DESC;
-- can make a decision tree view by grouping net revenue by sales channel and add column that disploys the total 
-- can also concatenate the net revenue to a calculation that displays the revenue %



--limiting results for query optimisation
--elapsed time displays the ms response time to complete the query