/***
* To remove duplicate records from the dataset. Firstly count total number of duplicate records.
* For that row_number() function is used. 
* Row_number() - Returns the result set in sequential order for a particular set, starting from 1 for each partition
* Then using CTE, all the duplicate records are deleted. T
* CTE is Commom Table Expression where in temporary result can be stored that can be a result of any SELECT, INSERT, UPDATE or 
* DELETE commonds. To check the correct number of deletion of records execute query SELECT * FROM table_name and subtract the 
* number from total number of records. Answer should be equal to the result of 2) query.
***/


-------------------------------------------------------------------------------
-- 1) Display all records present in table [dbo].[Deduplication Problem - Sample Dataset].

SELECT * 
FROM [dbo].[Deduplication Problem - Sample Dataset]

-------------------------------------------------------------------------------
-- 2) Checks total number of duplicate records in [dbo].[Deduplication Problem - Sample Dataset].

SELECT count(*)
FROM  ( SELECT fn,ln,dob,row_number() OVER ( 
         PARTITION BY  fn,ln, dob
         ORDER BY fn ASC)rn
         FROM  [dbo].[Deduplication Problem - Sample Dataset] 
       )rn
WHERE  rn>1

--------------------------------------------------------------------------------
--- 3) Delete duplicate records in [dbo].[Deduplication Problem - Sample Dataset].
WITH cte AS
(
	SELECT fn,ln,dob, row_number() OVER ( 
		PARTITION BY  fn,ln, dob
        ORDER BY fn ASC) RowNumber
        FROM  [dbo].[Deduplication Problem - Sample Dataset] 
		 )
		 
DELETE FROM cte
WHERE RowNumber != 1
--------------------------------------------------------------------------------
--- 5) To count total number of records.

    SELECT count(*)
	FROM [dbo].[Deduplication Problem - Sample Dataset]
--------------------------------------------------------------------------------
--- 4) Adding new column id to show the duplicacy.

ALTER TABLE [dbo].[Deduplication Problem - Sample Dataset] 
DROP COLUMN  id

ALTER TABLE [dbo].[Deduplication Problem - Sample Dataset]
ADD id int identity(1,1)

--------------------------------------------------------------------------------
--- 5) Drop Table

DROP TABLE [dbo].[Deduplication Problem - Sample Dataset]