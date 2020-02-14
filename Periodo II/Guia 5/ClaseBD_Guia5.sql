Select * from Categories;
GO
select CategoryName, CategoryId FROM Categories;
GO
SELECT OrderID, ProductID, UnitPrice FROM [Order Details] WHERE OrderID=10251;
GO
SELECT CompanyName FROM Customers WHERE CompanyName='Alfreds Futterkiste';
go

SELECT OrderId, ProductID, unitprice FROM [Order Details] where ORDERID=10251 AND PRODUCTID=57;
GO

select ProductID, ProductName, UnitPrice FROM products;
GO

select ProductID, ProductName, UnitPrice FROM products WHERE UnitPrice > 15;
GO

select ProductID, ProductName, UnitPrice FROM products WHERE UnitPrice >= 15 AND UnitPrice <= 50;
GO

select ProductID, ProductName, UnitPrice FROM products WHERE UnitPrice BETWEEN 15 AND 50;
GO
 
select ProductID, ProductName, UnitPrice FROM products WHERE not UnitPrice > 15;
GO

select ProductID, ProductName, UnitPrice FROM products WHERE ProductID > 15 OR UnitPrice < 10;
GO

select EmployeeID, LastName FROM Employees WHERE LastName LIKE 'D%';
GO

SELECT  EmployeeID, LastName FROM Employees WHERE Lastname LIKE '%N';
GO

SELECT  EmployeeID, LastName, title FROM Employees WHERE title LIKE '%sales%';
GO

SELECT  EmployeeID, LastName FROM Employees WHERE Lastname NOT LIKE 'D%';
GO

SELECT  EmployeeID, LastName, Title FROM Employees WHERE title NOT LIKE '%REPRESENTATIVE%';
GO

SELECT OrderID FROM [Order Details] where OrderID like '_0248';
go

SELECT OrderID from [Order Details] WHERE OrderID like '10[1-5]48';
go

select ProductID, ProductName, UnitPrice FROM Products order by productID ASC;
GO

select ProductID, ProductName, UnitPrice FROM Products order by productID DESC;
GO
 
 select distinct orderID FROM [Order Details];
 go

 select TOP 5 orderID, productID, Quantity FROM [Order Details];
 go

 select top 2 with ties OrderID, productID, Quantity FROm [Order Details] ORDER BY OrderID;
 go

 SELECT TOP 10 PERCENT OrderId, ProductID, Quantity FROM [Order Details];
 GO

 select CategoryName As [Nombre de Categoria] from categories;
 go

 select OrderID, OrderDate, ShippedDate, ShippedDate + 5 As RetrasoEnvio FROM Orders;
 go


