/*
*This procedure finds all the spam records that has same column values but with slight changes in data.
*It takes user input to find the spam records an deletes them accordingly/
*/

create Procedure sp_deleteSpamRecords(@LastName varchar(100))
as 
begin
 
declare @deletequery nvarchar(1000)

set @deletequery='DELETE t1 
			   FROM [dbo].[Deduplication Problem - Sample Dataset] AS t1 
			   JOIN [dbo].[Deduplication Problem - Sample Dataset] AS t2 
			   ON t1.ln=t2.ln 
			   WHERE t1.ln LIKE '''+@LastName+' %'''

execute sp_executesql @deletequery
end
--------------------------------------------------------------------------------------------------

drop procedure sp_deleteSpamRecords
--------------------------------------------------------------------------------------------------

execute sp_deleteSpamRecords FUNARO


 