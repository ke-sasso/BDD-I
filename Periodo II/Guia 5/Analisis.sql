
--ST152230
--GH152207
--1) Base de datos AdeventureWorks2012--------------
use AdventureWorks2012;
go
SELECT * FROM HumanResources.Department
GO
SELECT BusinessEntityID, NationalIDNumber, JobTitle FROM HumanResources.Employee WHERE JobTitle like '%Production%';
GO
SELECT * FROM Sales.Customer WHERE CustomerID IN (2,4,7,10);
GO
SELECT DepartmentID, Name FROM HumanResources.Department WHERE DepartmentID between 5 and 12; 
GO
SELECT AddressID, City, StateProvinceID FROM Person.Address WHERE City like 'B%';
GO
SELECT * FROM Production.Culture WHERE NAME LIKE 'English' OR NAME LIKE 'Spanish';
GO
SELECT TOP 50 PERCENT * FROM Sales.CreditCard;
GO

SELECT TOP 10 LineTotal FROM Sales.SalesOrderDetail;
GO
SELECT distinct JobTitle FROM HumanResources.Employee ORDER BY JobTitle DESC;
GO

SELECT Name, ProductNumber, ListPrice As 'Price' FROM Production.Product WHERE ProductLine='R' and DaysToManufacture>= 4;
GO

--2) Library ---------------------------
use Library;
GO
SELECT * FROM Adult WHERE Expr_date between '01/12/2006' and '30/06/2007';
GO
SELECT * FROM Reservation;
GO
SELECT author FROM title WHERE author like 'M%';
GO
SELECT author, title FROM title ORDER BY author ASC;
GO
SELECT * FROM loan WHERE isbn IN (519,529,539);
GO
--3) Pubs-----------------------------------
use pubs;
GO
SELECT * FROM employee WHERE Iname like '%B%';
GO
SELECT * FROM employee WHERE emp_id between 'F' and 'M';
GO
SELECT * FROM sales WHERE ord_date >= '01/01/1994';
GO
SELECT * FROM stores WHERE state='CA';
GO
SELECT TOP 5  price FROM titles;
GO 