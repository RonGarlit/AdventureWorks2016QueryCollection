
/***************************************************************************************************
FILENAME: 003-AdventureWorks SELECT - Other Features Collection
***************************************************************************************************/
/***************************************************************************************************
NOTES: AdventureWorks SELECT - HAVING Collection

https://docs.microsoft.com/en-us/sql/t-sql/queries/select-having-transact-sql?view=sql-server-2017
***************************************************************************************************/

USE AdventureWorks2016;  
GO
SELECT SalesOrderID
     , SUM(LineTotal) AS SubTotal
FROM   Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(LineTotal) > 100000.00
ORDER BY SalesOrderID;
USE AdventureWorks2016;  
GO

/***************************************************************************************************
NOTES: AdventureWorks SELECT - INTO Clause Collection

https://docs.microsoft.com/en-us/sql/t-sql/queries/select-into-clause-transact-sql?view=sql-server-2017
***************************************************************************************************/

-- Creating a table by specifying columns from multiple sources
USE AdventureWorks2016;  
GO
SELECT c.FirstName
     , c.LastName
     , e.JobTitle
     , a.AddressLine1
     , a.City
     , sp.Name AS [State/Province]
     , a.PostalCode
INTO dbo.EmployeeAddresses
FROM   Person.Person AS c
       JOIN HumanResources.Employee AS e ON e.BusinessEntityID = c.BusinessEntityID
       JOIN Person.BusinessEntityAddress AS bea ON e.BusinessEntityID = bea.BusinessEntityID
       JOIN Person.Address AS a ON bea.AddressID = a.AddressID
       JOIN Person.StateProvince AS sp ON sp.StateProvinceID = a.StateProvinceID;  
GO

-- Inserting rows using minimal logging
ALTER DATABASE AdventureWorks2016 SET RECOVERY BULK_LOGGED;  
GO
SELECT *
INTO dbo.NewProducts
FROM   Production.Product
WHERE  ListPrice > $25
       AND ListPrice < $100;  
GO  
ALTER DATABASE AdventureWorks2016 SET RECOVERY FULL;  
GO

-- Creating an identity column using the IDENTITY function
-- Determine the IDENTITY status of the source column AddressID.  
SELECT OBJECT_NAME(object_id) AS TableName
     , name AS column_name
     , is_identity
     , seed_value
     , increment_value
FROM   sys.identity_columns
WHERE  name = 'AddressID';

-- Create a new table with columns from the existing table Person.Address. 
-- A new IDENTITY column is created by using the IDENTITY function.  
SELECT IDENTITY( INT, 100, 5) AS AddressID
     , a.AddressLine1
     , a.City
     , b.Name AS State
     , a.PostalCode
INTO Person.USAddress
FROM   Person.Address AS a
       INNER JOIN Person.StateProvince AS b ON a.StateProvinceID = b.StateProvinceID
WHERE  b.CountryRegionCode = N'US';

-- Verify the IDENTITY status of the AddressID columns in both tables.  
SELECT OBJECT_NAME(object_id) AS TableName
     , name AS column_name
     , is_identity
     , seed_value
     , increment_value
FROM   sys.identity_columns
WHERE  name = 'AddressID';

-- Creating a table by specifying columns from a remote data source
-- We are not inserting Linked Server EXamples here
-- Read this link for mor information:
-- https://docs.microsoft.com/en-us/sql/t-sql/queries/select-into-clause-transact-sql?view=sql-server-2017#d-creating-a-table-by-specifying-columns-from-a-remote-data-source
/***************************************************************************************************
NOTES:
***************************************************************************************************/