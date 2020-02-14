USE NORTHWND;
go

INSERT  INTO Customers (CustomerID, CompanyName) VALUES('Tiple', 'Tipicos Regionales');
GO
INSERT  INTO Customers (CustomerID, CompanyName) VALUES('FLOSU', 'Flores del sur');
GO
INSERT INTO Orders (CustomerID) VALUES (null);
GO



SELECT OrderId, Customers.CustomerID
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
go
SELECT OrderId, A.CustomerID
FROM Customers A
INNER JOIN Orders B
ON A.CustomerID=B.CustomerID
go
----------------------------
SELECT OrderID, Customers.CustomerID
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GO

SELECT OrderID, A.CustomerID
FROM Customers A
RIGHT JOIN Orders B
ON A.CustomerID = B.CustomerID
GO
------------------
SELECT OrderID, Customers.CustomerID
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
WHERE Customers.CustomerID IS NULL
GO

SELECT OrderID, A.CustomerID
FROM Customers A
RIGHT JOIN Orders B
ON A.CustomerID = B.CustomerID
WHERE A.CustomerID IS NULL
GO

-----------------------
SELECT OrderID, Customers.CustomerID
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
GO

SELECT OrderID, A.CustomerID
FROM Customers A
LEFT JOIN Orders B
ON A.CustomerID=B.CustomerID
GO

--------------------------
SELECT OrderID, Customers.CustomerID
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
WHERE Orders.CustomerID IS NULL
GO
SELECT OrderID, A.CustomerID
FROM Customers A
LEFT JOIN Orders B
ON A.CustomerID=B.CustomerID
WHERE B.CustomerID IS NULL
GO
-----------------------
SELECT OrderID, Customers.CustomerID
FROM Customers
FULL JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
GO

SELECT OrderID, A.CustomerID
FROM Customers A
FULL JOIN Orders B
ON A.CustomerID=B.CustomerID
GO
--------------------------
SELECT OrderID, Customers.CustomerID
FROM Customers
FULL JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
WHERE Customers.CustomerID IS NULL OR Orders.CustomerID IS NULL
GO

SELECT OrderID, A.CustomerID
FROM Customers A
FULL JOIN Orders B
ON A.CustomerID=B.CustomerID
WHERE A.CustomerID IS NULL OR B.CustomerID IS NULL
GO

------------------------------
SELECT OrderId, A.CustomerID
FROM Customers A
CROSS JOIN  Orders B
GO

SELECT OrderId, A.CustomerID
FROM Customers A
CROSS JOIN  Orders B
WHERE A.CustomerID = B.CustomerID
GO

-------------------------
--1. Obtener los datos de los clientes que han realizado pedidos mayor o igual a la fecha 1 de Enero de 1998
SELECT CustomerID, CompanyName, ContactName, Country
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders
                      WHERE OrderDate>='1998-01-01')
					  GO
SELECT CustomerID, CompanyName, ContactName, Country
FROM Customers
WHERE CustomerID not IN (SELECT CustomerID FROM Orders
                      WHERE OrderDate>='1998-01-01')
					  GO
---------------------------------------
--3. Con el siguiente ejemplo se obtiene los datos del cliente que posee el código del Pedido 10248
SELECT CustomerID, CompanyName, ContactName, Country 
FROM Customers
WHERE CustomerID = (SELECT CustomerID FROM Orders
                       WHERE OrderID='10248')

----------------------------------------
--5. En el siguiente ejemplo se evalúa si existen clientes que han realizado pedidos mayor o igual a la fecha 1 de Enero de 1998 y se muestra el resultado
SELECT CustomerID, CompanyName, ContactName, Country
FROM Customers C
WHERE EXISTS (SELECT * FROM Orders O
              WHERE C.CustomerID=O.CustomerID
			  AND OrderDate>='1998-01-01')

SELECT CustomerID, CompanyName, ContactName, Country
FROM Customers C
WHERE NOT EXISTS (SELECT * FROM Orders O
              WHERE C.CustomerID=O.CustomerID
			  AND OrderDate>='1998-01-01')

-------------------------------------------------
--7. Mostrar el máximo Precio unitario (UnitPrice) por cada pedido
SELECT  O.OrderID, OrderDate, (SELECT MAX(UNITPRICE)
FROM [Order Details] OD WHERE OD.OrderID=O.orderID)
AS maxpreciounitario
FROM Orders AS O

----------COMPLEMENTARIO----------
SELECT A.OrderDate, b.ProductID 
FROM Orders A
INNER JOIN [Order Details] b
ON A.OrderID = B.OrderID
WHERE  A.OrderDate = '1996-07-04'
GO

----------------------
SELECT A.productID, A.productname, B.Quantity, c.orderdate
FROM Products A
INNER JOIN [Order Details] B
ON A.ProductID = B.ProductID
INNER JOIN Orders C
ON B.OrderID = c.OrderID

----------------------------------
--Haciendo uso de SUBCONSULTAS mostrar los campos OrderID, ProductID y Quantity de la tabla Orders Details donde la fecha de pedido (OrderDate de la tabla Orders) sea la más antigua
SELECT a.OrderID, a.ProductID, a.Quantity, b.ORDERDATE 
FROM [Order Details] A
INNER JOIN Orders B
ON A.OrderID = b.OrderID
WHERE B.OrderDate = (SELECT MIN(OrderDate) from Orders)
-------------------------------
INSERT INTO Employees (LastName, FirstName) VALUES('Sasso', 'Kevin')

INSERT INTO Orders (EmployeeID) VALUES (11)
go

INSERT INTO Orders (EmployeeID) VALUES (NULL)
go

SELECT A.LastName, A.EmployeeID, B.OrderDate
FROM Employees A
LEFT JOIN Orders B
ON A.EmployeeID=B.EmployeeID
GO

SELECT A.LastName, A.EmployeeID, B.OrderDate
FROM Employees A
FULL JOIN Orders B
ON A.EmployeeID=B.EmployeeID
GO








