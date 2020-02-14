USE NORTHWND;
GO

SELECT CompanyName, COUNT(*) AS [Total de clientes] FROM Customers
GROUP BY CompanyName
GO

SELECT  OrderID, CustomerID, EmployeeID, OrderDate, ShipAddress FROM Orders
WHERE YEAR(OrderDate) = '1996'
GO

SELECT TerritoryID, Count(*) 
FROM EmployeeTerritories
GROUP BY TerritoryID
GO

SELECT OrderID, EmployeeID, SUM(Freight) as [Total]
FROM Orders
GROUP BY OrderID, EmployeeID
WITH ROLLUP
ORDER BY EmployeeID, OrderId
GO

SELECT RegionID, COUNT(*) AS [Total de territorios]
FROM Territories
GROUP BY RegionID
GO

SELECT ProductID, SUM(Quantity) AS [Total de productos]
FROM [Order Details]
GROUP BY ProductID
HAVING SUM(Quantity) > 50
ORDER BY SUM(Quantity) DESC
GO

-----------------------------------
USE AdventureWorks2012
GO
SELECT SalesOrderID, SUM(OrderQty) as [Unidades vendidas] FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
GO

SELECT SalesOrderID, AVG(LineTotal) AS [Promedio total] FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
GO

SELECT SalesOrderID, MAX(LineTotal) AS [MAXIMA VENTA] FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
GO

SELECT SalesOrderID, MIN(LineTotal) AS [VENTA MINIMA] FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
GO

----------------------------------
SELECT * FROM Sales.Store 
ORDER BY SalesPersonID
GO

SELECT CONCAT(Name, ' ', SalesPersonID) AS [NOMBRE DE LA TIENDA Y EL ENCARGADO]
FROM Sales.Store
GO

SELECT LOWER(NAME) AS [Nombre en minuscula],
UPPER(NAME) AS [Nombre en mayuscula]
FROM Sales.Store
GO
