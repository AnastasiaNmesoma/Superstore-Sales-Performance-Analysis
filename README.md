# Superstore Sales Performance Analysis
An interactive sales and profitability analysis using the Superstore dataset

![Power BI](https://img.shields.io/badge/Tool-PowerBI-yellow)
![SQL](https://img.shields.io/badge/Backend-SQL-blue?logo=postgresql)
![Data Cleaning](https://img.shields.io/badge/Data%20Cleaning-Yes-success)
![Visualization](https://img.shields.io/badge/Visualization-PowerBI-yellowgreen)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![Dataset](https://img.shields.io/badge/Dataset-Superstore-blue)
![GitHub repo size](https://img.shields.io/github/repo-size/AnastasiaNmesoma/Superstore-Sales-Performance-Analysis)


## Project Overview
This Power BI project explores sales and profit performance across different regions, categories, and customer segments using the popular Superstore dataset. The goal was to build an interactive dashboard that enables business decision-makers to gain quick insights into key performance areas such as:
- Regional sales trends
- Profitability by category
- Customer segment performance
- Discount vs. profit relationships

> All visualizations, data modeling, and analysis were built from scratch in Power BI.

## Important Note:
For full context, including project objectives, & dataset description please refer to the [Project documentation](Sales%20performance%20Documentation.md)

## Tools Used
- SQL Server – Data Cleaning, Querying, KPI Computation
- Microsoft Power BI – for data modeling, DAX calculations, and interactive visualization
- DAX – for creating Calculated Measures and KPIs

## Dataset Summary
- **Source**: [Superstore Dataset](Superstore%20Analysis) (Orders table)
- **Time Range**: 2014–2017
- **Fields**: Order ID, Dates, Region, State, Sales, Profit, Product Details, Discount, etc.
- **Unused Tables**: `Returns`, `People` (not used in this analysis)

## SQL Data Preparation & Analysis

This project began with exploratory data analysis and cleaning in SQL before visualization in Power BI.

Key tasks included:
- Creating and connecting to a new database
- Checking for duplicates and setting primary keys
- Renaming poorly labeled columns
- Performing business-level analysis: sales trends, profit margins, category performance, and regional breakdowns

All SQL queries used in this project are available in the [superstore analysis.sql](Superstore%20Analysis.sql) file.

## Analysis Focus Areas

- **Time Trends**: Yearly, Monthly, and Quarterly sales/profit
- **Product**: Top-selling and loss-making products
- **Geography**: Regional and state-level performance
- **Profitability**: Discounts and profit margins by category

## Key KPIs (DAX Measures)

```DAX
Total Sales = SUM(Orders[Sales])
Total Profit = SUM(Orders[Profit])
Total Orders = COUNT(Orders[Order_ID])
```

## Advanced DAX Measures
### Current vs Previous Month
Comparative metrics were built for: Sales, Profit, and Orders

Example for Current Month Sales:
```DAX
CM Sales = 
VAR Selected_Month = SELECTEDVALUE('Date Table'[Month])
RETURN
TOTALMTD(CALCULATE([Total Sales], 'Date Table'[Month] = Selected_Month), 'Date Table'[Date])
```
Previous Month Sales:
```DAX
PM Sales = CALCULATE([CM Sales], DATEADD('Date Table'[Date], -1, MONTH))
```
Same logic applied for CM/PM Profit and CM/PM Orders.

### MoM Growth and Difference
```DAX
MoM Growth and Diff of Sales =
VAR Month_Diff = [CM Sales] - [PM Sales]
VAR MoM = DIVIDE(Month_Diff, [PM Sales])
VAR _Sign = IF(Month_Diff > 0, "+", "")
VAR _Sign_trend = IF(Month_Diff > 0, "▲", "▼")
RETURN
_Sign_trend & " " & _Sign & FORMAT(MoM, "#0.0%") & " | " & FORMAT(Month_Diff / 1000, "#0.0K") & " vs LM"
```
Similar measures created for Profit and Orders.

## Dashboard Preview
> [View the Live Dashboard](https://app.powerbi.com/view?r=eyJrIjoiYmEyNTdlNjEtYWI0Zi00ODBiLTg5ZTctYjdmODU3NWJhMjA2IiwidCI6IjJmYjRmNDUyLTJlY2QtNGVkMy1hZTkzLTM4NTBmNjU4ZmQ3MCJ9)
<img width="692" height="398" alt="Screenshot 2025-07-28 114737" src="https://github.com/user-attachments/assets/361a9da7-64e0-422a-afdf-237acc4d8bc2" />

## Key Insights
- Q4 consistently outperformed other quarters — especially November.
- California and New York had the highest revenue and profit.
- States like Texas, Ohio, and Florida had high sales but low/negative profits.
- Technology was the most profitable category overall, but had several loss-making products.
- Excessive discounting was linked to low profitability, especially in tech.

## Conclusion
The Superstore dashboard provides a clear view of business performance across time, geography, and product segments. It highlights areas for improvement and potential opportunities for growth. 

This project showcases the ability to clean and model data, write efficient SQL queries, and build a professional, interactive dashboard using Power BI.

## Let’s Connect

- [Read My Blog on Substack](https://substack.com/@theanalysisangle)
- [Twitter](https://x.com/Anastasia_Nmeso)  
- [FaceBook](https://www.facebook.com/share/16JoCo9x4F/)  
- [LinkedIn](www.linkedin.com/in/anastasia-nmesoma-947b20317)
