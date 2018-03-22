# Analytics

Variation in names leads to difficulty in identifying a unique person and hence deduplication of records is an unsolved challenge. The problem becomes more complicated in cases where data is coming from multiple sources.

This assignment is for explaining my approach towards removing deduplication of records.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

System requirements to run this query

```
	- Microsoft SQL Server 2012
	- Windows OS 
	- Text Editor
```

### Approach

####	**1. Import data from  local**
	
- Right click on the database that, go to Tasks.
- Go to Import Data
  - In source file type. I selected **Flat File Source**.
  - Select the database name and browse the given .csv file from local and then load.
  - Check the loaded data by clicking on Columns on left hand side of the wizard.
  - Click next and finish.
  - It will load the data in to database. 
  - After successful completion it shows message Success.
- Check the total number of rows to be loaded in report to make sure that all data has been loaded into the database.
- Exit the wizard.
			
*To test the data load, run a query*

```
SELECT *
FROM [dbo].[Deduplication Problem - Sample Dataset]
```
**Above query will show total records.


#### **2. Queries to remove duplicate data** 
		 
- First find the total number of duplicate records from the dataset. I have used row_number function to find that out.
		  
```
SELECT count(*)
FROM  ( 
SELECT fn,ln,dob,row_number() OVER ( 
PARTITION BY  fn,ln, dob
ORDER BY fn ASC) rn
FROM  [dbo].[Deduplication Problem - Sample Dataset] 
)rn
WHERE  rn>1
```
		  
- Delete duplicate records by storing all the duplicate data in CTE and delete it.
		  
```
WITH cte AS
(
SELECT id ,fn,ln,dob, row_number() OVER ( 
PARTITION BY  fn,ln, dob
ORDER BY id,fn ASC) RowNumber
FROM  [dbo].[Deduplication Problem - Sample Dataset] 
)		 
DELETE FROM cte
WHERE RowNumber != 1
```
**To check the exact deletion of duplicate records, run below query.

```
SELECT count(*)
FROM [dbo].[Deduplication Problem - Sample Dataset]
```
**For above run query Analytics_Script_1.sql**

**See the output**

![o9](https://user-images.githubusercontent.com/37592944/37763765-f1df679c-2de5-11e8-86b7-4a47595d8439.PNG)

**Since the above query deletes the full duplicate records means that records that match exactly column by column. But to remove spam
records that we can only remove them manually.


##### By below query we can take LastName or First Name as an input and can delete spam records.

```
execute sp_deleteSpamRecords last_name
```

**For above run query sp_deleteSpamRecords_Script2.sql**
			
#### **3. Export data from local database to flat file**
	
- This is similar as importing data. Right Click on the database and go to Tasks.
- Go to Export Data.
- Select source file type. It will be the first option on SQL Server Client v.xx.
- Browse the path where you want to store the file and press Next.
- Set the file type as well. I selected **Flat File Source** and press Next.
- Choose how you want tht data. There are two options.
  - Choose a table name from where you want the data.
  - Write and execute a query to extract the data from.
  - Select one of them and press Next.
- Press Next and proceed with the final step of exporting data.
- Check the data, total number of records and Success message.
- Exit the Wizard and check you destination output file.

#### This is how you will be able to find and remove duplicate records.

#### Link for github branch: (https://github.com/anmol242/Analytics)
