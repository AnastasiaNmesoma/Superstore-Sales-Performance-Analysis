/* Creating superstore database */
CREATE DATABASE Superstore_DB;
USE Superstore_DB;

/*All column names from Orders table*/
SELECT STRING_AGG(COLUMN_NAME, ', ')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Orders';

/*checking for duplicate In Orders Table*/
SELECT 
    Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Customer_Name, Segment, Country, City, State, Postal_Code, Region, Product_ID, Category, Sub_Category, Product_Name, Sales, Quantity, Discount, Profit,
    COUNT(*) AS duplicate_count
FROM Orders
GROUP BY 
    Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Customer_Name, Segment, Country, City, State, Postal_Code, Region, Product_ID, Category, Sub_Category, Product_Name, Sales, Quantity, Discount, Profit
HAVING COUNT(*) > 1;

/* Checking duplicate in Row_ID */
SELECT Row_ID, COUNT(*) 
FROM Orders
GROUP BY Row_ID
HAVING COUNT(*) > 1;

/* Adding primary key to Row_ID */
ALTER TABLE Orders
ADD CONSTRAINT PK_Row_ID PRIMARY KEY (Row_ID);

/* Renaming the columns in People table */
EXEC sp_rename 'People.Column1', 'Person', 'COLUMN';
EXEC sp_rename 'People.Column2', 'Region', 'COLUMN';

-- Sales KPIs

/*Total Sales, Total Profit, Total Orders */
SELECT 
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders

/*Profit Margin*/
SELECT 
    ROUND(SUM(Profit) / SUM(Sales), 2) AS Profit_Margin
FROM Orders

/*Average Order Value*/
SELECT 
    ROUND(SUM(Sales) / COUNT(Order_ID), 2) AS Avg_Order_Value
FROM Orders

-- Time Analysis

/* Yearly sales trend */
SELECT
    DISTINCT DATEPART(YEAR, Order_Date) AS Years,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
GROUP BY DATEPART(YEAR, Order_Date)

/* Monthly sales Trend */
SELECT
    DISTINCT DATEPART(MONTH, Order_Date) AS Months,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
WHERE DATEPART(YEAR, Order_Date) = 2015
GROUP BY DATEPART(MONTH, Order_Date)
ORDER BY Total_Sales

/*Quaterly sales trend*/
SELECT
    DISTINCT DATEPART(QUARTER, Order_Date) AS Quarters,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders 
WHERE DATEPART(YEAR, Order_Date) = 2014
GROUP BY DATEPART(QUARTER, Order_Date)
ORDER BY Total_Sales

-- Category and product

/*Top 10 product by sales */
SELECT TOP 10
    Product_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Orders
GROUP BY Product_Name
ORDER BY Total_Sales DESC

/*Sales and Profit by Catergory and Sub-Category */
SELECT
    Category,
    Sub_Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
GROUP BY Category, Sub_Category
ORDER BY Total_Profit DESC

/* Products with Loss */
SELECT 
    DISTINCT Product_Name,
    ROUND(SUM(Sales), 2) AS Total_sales,
    ROUND(SUM(Profit), 2) AS Total_profit
FROM Orders
GROUP BY Product_Name
HAVING SUM(Profit) < 0
ORDER BY Total_profit ASC

SELECT
    DISTINCT Category,
    SUM(Discount) AS Total_Discount
FROM Orders
GROUP BY Category
ORDER BY Total_Discount DESC


-- Region / State Analysis

/*Total Sales & profit by Region */
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
GROUP BY Region
ORDER BY Total_Sales DESC

/*Total Sales & profit by State */
SELECT
    State,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
GROUP BY State
ORDER BY Total_Profit DESC





SELECT * from Orders;
SELECT * from People;
SELECT * from Return;