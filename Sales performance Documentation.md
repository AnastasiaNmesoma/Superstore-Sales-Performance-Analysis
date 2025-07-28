# **Superstore Sales Performance Analysis**

## **Project Overview**

This project involves analyzing sales performance using the **Superstore** dataset with SQL Server and visualizing key insights in **Power BI**. 

The dataset includes sales transactions across U.S. states from 2014 to 2017\. The goal is to track KPIs, detect sales trends, identify loss areas, and support business decisions.

## **Tools & Technologies**

* **SQL Server** – Data Cleaning, Querying, KPI Computation  
* **Power BI** – Dashboard Design & Data Visualization  
* **DAX** – Calculated Measures and KPIs

**Analytical Focus Areas**

### **Analytical Focus Areas**

1. **Time Series Analysis**  
* Yearly, Quarterly, and Monthly Sales & Profit Trends  
* Month-over-Month (MoM) performance

2. **Geographical Analysis**  
* Sales and Profit by Region and State  
* Identification of high-sales but low-profit states

3. **Product Performance**  
* Top-selling products by revenue  
* Products and sub-categories generating losses  
* Discount impact by category

4. **Customer Segment & Category**  
* Total Sales by Category, Sub-category, and Segment

### **Dataset Overview**

Only the **Superstore table** was used in this project. The **People** and **Returns** tables were available but **not used** in this analysis.

##  **Data Preparation**

* **Duplicates Removed**: Verified uniqueness of transactions  
* **Primary Key**: Added Row\_ID as a primary key to ensure uniqueness.  
* **Data Type Verification:** Ensured date fields were correctly typed  
* **Cleanup:** Minimal transformation required; renamed some columns for clarity

## **Power BI Workflow**

1. #### **Data Connection**

* Connected directly to SQL Server (Superstore database).

2. ####  **Power Query (Data Preparation)**

* Verified all column types, especially `Order_Date`.  
* Minimal transformation: primarily data type corrections.

3. **Date Table**  
* Created a custom Date Table using:

  *Date Table \= CALENDAR(MIN(Orders\[Order\_Date\]), MAX(Orders\[Order\_Date\]))*

Added:

- `Month`, `Month Year`, `Month Number`  
- `Week Number`, `Day Name`, `Day Number`  
- `Weekday Number` (Monday as start of week)

4. ### **Data Modeling**

* A relationship was established between the ‘Orders table’ and the ‘Date Table’ using the Order\_Date column.

5. ### **KPI Metrics**

Custom DAX measures were created for key metrics:

Total Sales \= SUM(Orders\[Sales\])

Total Profit \= SUM(Orders\[Profit\])

Total Orders \= COUNT(Orders\[Order\_ID\])

These were displayed using KPI cards at the top of the dashboard.

6. ### **Advanced DAX Used**

### **Current vs Previous Month Metrics**

Measures were created to compare **Current Month (CM)** and **Previous Month (PM)** for:

* Sales  
* Profit  
* Orders  
  ***CM Sales** \=*   
  *VAR Selected\_Month \= SELECTEDVALUE('Date Table'\[Month\])*  
  *RETURN*  
  *TOTALMTD(CALCULATE(\[Total Sales\], 'Date Table'\[Month\] \= Selected\_Month), 'Date Table'\[Date\])*  
  ***PM Sales** \= CALCULATE(\[CM Sales\], DATEADD('Date Table'\[Date\], \-1, MONTH))*

Similar logic was used for `CM Profit`, `PM Profit`, `CM Orders`, and `PM Orders`.

### **MoM Growth and Difference Measures**

To show trend indicators and absolute change, measures were created for:

* **Month-over-Month (MoM) Growth**

* **Difference in values from previous month**  
  ***MoM Growth and Diff of Sales** \=*  
  *VAR Month\_Diff \= \[CM Sales\] \- \[PM Sales\]*  
  *VAR MoM \= DIVIDE(Month\_Diff, \[PM Sales\])*  
  *VAR \_Sign \= IF(Month\_Diff \> 0, "+", "")*  
  *VAR \_Sign\_trend \= IF(Month\_Diff \> 0, "▲", "▼")*  
  *RETURN*  
  *\_Sign\_trend & " " & \_Sign & FORMAT(MoM, "\#0.0%") & " | " & FORMAT(Month\_Diff/1000, "\#0.0K") & " vs LM"*

Similar measures were created for **Profit** and **Orders**.

7. **Trend Line Charts**  
* Created three line charts for:  
- Total Sales by Date  
- Total Profit by Date  
- Total Orders by Date  
* Each chart had the **MoM growth and difference** measure added to the title for context.

8. ### **Calendar Heatmap**

To visualize sales activity by day:

* Created a **calendar chart** using the Date Table.  
* Columns:  
- **Row**: Week Number  
- **Column**: Day Name  
- **Values**: Day Number  
* Used custom sorting:  
- Sorted ‘Day Name’ using ‘Weekday Number’ to ensure Monday-start format.

9. ### **Regional Sales Visualization**

* Created a **Map Chart** where:  
- Bubbles represent **Total Sales**  
- Used **Region** and **State** fields from the dataset.

10. **Product & Segment Performance**  
* Built **bar charts** for:  
- Total Sales by **Sub-Category**  
- Total Sales by **Category**  
- Total Sales by **Segment**

These helped highlight which products and customer types contributed most to performance.

### ***Notes:***

* Visual design followed a clean and professional layout with dark background and Cream/Green accents.  
* Charts were arranged using containers and rounded shapes to create visual structure.  
* All visuals were made interactive with slicers and tooltips for deeper drill-down.

### **Key Insights**

* ## Sales consistently peaked in Q4 across the years, with November being the strongest month.

* ## California and New York were the top-performing states in terms of both sales and profit.

* ## Categories like Technology and Office Supplies performed well, while certain sub-categories consistently underperformed.

* ## Several states such as Texas, Ohio, and Florida recorded high sales volumes but generated losses due to low profit margins.

* ## High discount levels were associated with low-profit products, especially in the Technology category.

