# US Sales Analysis
Gaining insight through queries, KPIs and visualisations from data stored within a relational database that was created after data pre-processing, normalisation and data modelling.

## Tech Stack:
* **Languages**
  
  - SQL
    
* **Tools**
    
  - Draw.io
  - Excel
  - Power Query
  - SSMS
  - SSIS
  - Power BI
<br/>

___

## The Aim
Produce visualisations to provide insights for a business, so that they can analyse their performance and create more informed business decisons.

## Objectives
- Has the net revenue grown annually?

- What sales channel is the most profitable?

- What are the top performing products?

- Which quarter on average performs best?

- Which store locations have the highest sales conversions?

- Do higher discounts result in an increase to the average order quantitiy?
<br/>

___

## The Process

<br/>

### Data Pre-Processing


#### Thematic Analysis

This was conducted to become familiar with the dataset, gain an understanding for the overall theme of the data, identify issues as well as aid with dictating the overall aim and objectives.  

This helped to deduce that the raw dataset depicts a company that operate on a B2B scheme within the US. Conducting this also displayed that the dataset is currently  contained within a star-schema but still contains repeating values and irrelevant data. Meaning, normalisation will be required to relinquish these data quality related issues, which will result in a snowflake schema.

#### Data Cleaning

Due to the thematic analysis, issues such as irrelevant data, repeating data, incorrect formatting and transitive dependencies had become apparent. 

#### Data Manipulation

This step allowed more data to be extracted from the original raw dataset, where the columns Discount Applied, Unit Price and Unit Cost from the US_Sales_Data_Dirty.xlsx were manipulated by creating calcualtions between themselves to generate the columns TotalCost, GrossRevenue and NetRevenue within the US_Sales_Data_Cleaned.xlsx file.

#### Data Modelling


<br/>

### Data Storage

<center> #### Databse Schema </center>

The database schema was created based on the data models within the data models folder. This is essential because future sales will generate more data that will require storage space, so having a database with an already existing schema makes storing future data easier. This also helps with automating data mapping, data dumps and the ETL process. 

The schema allows constraints to be applied which can reduce issues and increase data accuracy and ensure the data quality is of the highest quality, which means improved accuracy in terms of data analysis which will inform and influence business decisions. 

Constraints were declared through DDL, within the Database_1_Schema file, to set character limits and only allow certain columns to accept the declared data type. The primary and foreign key are essential within relational databases because they uphold the relational integrity and consistency between tables. The primary key column is what uniquely identifies each record, but the unique key constraint wasn't declared within the file because it is automatically applied when declaring a primary key. 

The command ON DELETE CASCADE was on the foreign key for related tables that cannot exist without the parent table. For example, there is no point in storing data related stores within a city if the business no longer operates within that state, in which case this command will delete child tables/irrelevant data. ON DELETE SET NULL was used where data may no longer be required but shouldn't warrant the removal of related records entirely, in which case it will only set the referenced field to NULL. This was applied to the SalesTeam table. 

The implementation of further restrictions with the use of complex RegEx through a check constraint wasn't applied because MS SQL Server doesn't facilitate it, unlike Oracle.

#### ETL
source, destination and data mapping

#### Database Optimisation 

Clustered index

#### Database Views

<br/>

### Exploratory Data Analysis

</br>

### Data Visualisation

DAX



