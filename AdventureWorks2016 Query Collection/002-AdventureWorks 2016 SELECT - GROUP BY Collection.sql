/***************************************************************************************************
FILENAME: 002-AdventureWorks 2016 SELECT - GROUP BY Collection
***************************************************************************************************/
/***************************************************************************************************
NOTES: AdventureWorks 2016 SELECT - GROUP BY Collection

https://docs.microsoft.com/en-us/sql/t-sql/queries/select-group-by-transact-sql?view=sql-server-2017
***************************************************************************************************/
use AdventureWorks2016;
GO

-- GROUP BY DEMO
CREATE TABLE SalesGroupByTable ( Country varchar(50), Region varchar(50), SalesGroupByTable int );

INSERT INTO SalesGroupByTable VALUES (N'Canada', N'Alberta', 100);
INSERT INTO SalesGroupByTable VALUES (N'Canada', N'British Columbia', 200);
INSERT INTO SalesGroupByTable VALUES (N'Canada', N'British Columbia', 300);
INSERT INTO SalesGroupByTable VALUES (N'United States', N'Montana', 100);


SELECT Country, Region, SUM(SalesGroupByTable) AS TotalSalesGroupByTable
FROM SalesGroupByTable
GROUP BY Country, Region;

-- GROUP BY ROLLUP
SELECT Country, Region, SUM(SalesGroupByTable) AS TotalSalesGroupByTable
FROM SalesGroupByTable
GROUP BY ROLLUP (Country, Region);

-- GROUP BY CUBE
SELECT Country, Region, SUM(SalesGroupByTable) AS TotalSalesGroupByTable
FROM SalesGroupByTable
GROUP BY CUBE (Country, Region);


--GROUP BY GROUPING SETS
SELECT Country, Region, SUM(SalesGroupByTable) AS TotalSalesGroupByTable
FROM SalesGroupByTable
GROUP BY GROUPING SETS ( ROLLUP (Country, Region), CUBE (Country, Region) );

SELECT Country, Region, SUM(SalesGroupByTable) AS TotalSalesGroupByTable
FROM SalesGroupByTable
GROUP BY ROLLUP (Country, Region)
UNION ALL
SELECT Country, Region, SUM(SalesGroupByTable) AS TotalSalesGroupByTable
FROM SalesGroupByTable
GROUP BY CUBE (Country, Region);

-- GROUP BY ()
SELECT Country, SUM(SalesGroupByTable) AS TotalSalesGroupByTable
FROM SalesGroupByTable
GROUP BY GROUPING SETS ( Country, () );


/***************************************************************************************************
NOTES:
***************************************************************************************************/

