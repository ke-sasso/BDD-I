USE NORTHWND;
GO

SELECT AVG(UnitPrice) AS [Suma Cantidad]
FROM [Order Details]
GO

SELECT COUNT(*) AS [Total Empleados]
FROM Employees
GO

SELECT EmployeeID, Region FROM Employees;
GO
--Cuenta todos los registro pero aquellos que no son nulos
SELECT COUNT(ALL Region) AS [Total Empleados]
FROM Employees
GO
--Cuenta todos los registro pero aquellos que no son nulos
SELECT COUNT(Region) AS [Total Empleados]
FROM Employees
GO
--Cuenta aquellos registros en los cuales no se repitan
SELECT COUNT(DISTINCT Region) As [Total empleados] FROM Employees
GO
--SE OBTIONE EL MAXIMO VALOR DE LA COLUMNA
SELECT MAX(UnitPrice) As [Precio mas alto] FROM Products 
GO
--SE OBTINE EL MINIMO VALOR DE LA COMLUMNA
SELECT MIN(UnitPrice) As [Precio mas bajo] FROM Products
GO
--HACE LA SUMATORIA DE CADA IDPRODUCTO
SELECT ProductID, SUM(Quantity) AS [Total de productoa]
FROM [Order Details]
GROUP BY ProductID
ORDER BY ProductID ASC
GO

SELECT ProductID, SUM(Quantity) AS [Total de productos]
FROM [Order Details]
WHERE ProductID BETWEEN 10 AND 25
GROUP BY ProductID
ORDER BY ProductID  ASC
GO

SELECT Country, Region, COUNT(*) AS [Total de clientes]
FROM Customers
GROUP BY Country, Region
ORDER BY Country
GO

SELECT ProductID, SUM(Quantity) AS [Total de productos]
FROM [Order Details]
GROUP BY ProductID
HAVING SUM(Quantity) >=100
ORDER BY SUM(Quantity)
GO

SELECT ProductID, OrderID, SUM(Quantity) AS [Total de productos]
FROM [Order Details]
GROUP BY ProductID, OrderID
WITH ROLLUP
ORDER BY ProductID, OrderID
GO

SELECT SUM(Quantity) AS [Total de productos]
FROM [Order Details]
GO

SELECT ProductID, SUM(Quantity) as [Total de productos]
FROM [Order Details]
GROUP BY ProductID
ORDER BY ProductID
GO

SELECT OrderID,ProductID, SUM(Quantity) as [Total de productos]
FROM [Order Details]
WHERE OrderID < 10250
GROUP BY OrderID, ProductID
ORDER BY ProductID, OrderId
GO

SELECT OrderID,ProductID, SUM(Quantity) as [Total de productos]
FROM [Order Details]
GROUP BY OrderID, ProductID
WITH ROLLUP
ORDER BY ProductID, OrderId
GO


SELECT ProductID, OrderID, SUM(Quantity) as [Total de productos]
FROM [Order Details]
GROUP BY OrderID, ProductID
WITH CUBE
ORDER BY ProductID, OrderId
GO

SELECT Country, City, COUNT(*) AS [Total de proveedores]
FROM Suppliers
GROUP BY GROUPING SETS ((Country),(City))
GO

SELECT Country, NULL As City, Count(*) AS [Total de proveedores]
FROM Suppliers
GROUP BY Country
UNION ALL
SELECT NULL AS Country, City, Count(*) AS [Total de proveedores]
FROM Suppliers
GROUP BY City
GO



SELECT YEAR('2014-03-14 17:06:00.390') AS Año
go
SELECT YEAR(GETDATE()) AS Año
go

SELECT MONTH(GETDATE()) AS Mes;
GO

SELECT DAY(GETDATE()) AS Dia;
GO

SELECT DATENAME(HOUR, GETDATE()) AS Hora;
GO

SELECT DATENAME(MINUTE, GETDATE()) AS minuto;
GO

SELECT DATENAME(SECOND,GETDATE()) AS Segundo
GO

USE AdventureWorks2012
go

SELECT LEFT(Name, 5) AS [Nombre Producto] FROM Production.Product
ORDER BY ProductID;
GO

SELECT RIGHT(Name, 5) AS [Nombre Producto] FROM Production.Product
ORDER BY ProductID;
GO

SELECT CONCAT (FirstName, ' ', MiddleName, ' ', LastName, ' ') AS [Nombre completo]
FROM Person.Person
GO

SELECT LOWER(NAME) AS [Nombre en minuscula],
UPPER(NAME) AS [Nombre en mayuscula]
FROM Production.Product
WHERE ListPrice Between 11.00 and 20.00
GO

SELECT FirstName, SUBSTRING(FirstName,1,1) AS inicial
FROM Person.Person
ORDER BY LastName
GO

------------------------complementario
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




