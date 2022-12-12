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

#### Databse Schema 

#### ETL
source, destination and data mapping

#### Database Optimisation 

Clustered index

#### Database Views

<br/>

### Exploratory Data Analysis

</br>

### Data Visualisation



