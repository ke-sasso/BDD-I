use AdventureWorks2012
go

SELECT * FROM Sales.SalesPerson;
GO

SELECT Name, ProductNumber, MakeFlag, [FinishedGoodsFlag] FROM Production.Product;
GO

SELECT TOP 10 StandardCost from [Production].[ProductCostHistory];
go

SELECT Name as [Nombre producto], ProductNumber as [Numero de producto], Listprice as [Precio] from Production.Product ORDER BY name asc;
go


SELECT BusinessEntityID, AccountNumber, Name FROM Purchasing.Vendor WHERE AccountNumber like '[G-T]%';
GO

SELECT * from Person.CountryRegion where 
CountryRegionCode in('BO', 'CO', 'ES', 'ES', 'SV', 'VN');
GO

SELECT distinct CountryRegionCode FROM Person.StateProvince;
GO

SELECT SalesOrderID, OrderQty,UnitPrice FROM Sales.SalesOrderDetail WHERE UnitPrice between 200 and 1000; 
GO

SELECT ProductID, ListPrice, (ListPrice*1.15) AS [Aumento de precio] FROM Production.Product;
GO

SELECT  TOP 20 PERCENT * from Sales.SalesOrderDetail;
GO