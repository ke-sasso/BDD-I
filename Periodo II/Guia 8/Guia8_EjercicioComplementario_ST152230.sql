----------1-------------
SELECT A.OrderDate, b.ProductID 
FROM Orders A
INNER JOIN [Order Details] b
ON A.OrderID = B.OrderID
WHERE  A.OrderDate = '1996-07-04'
GO

-----------2-----------
SELECT A.productID, A.productname, B.Quantity, c.orderdate
FROM Products A
INNER JOIN [Order Details] B
ON A.ProductID = B.ProductID
INNER JOIN Orders C
ON B.OrderID = c.OrderID

-----------3-----------------------
SELECT a.OrderID, a.ProductID, a.Quantity, b.ORDERDATE 
FROM [Order Details] A
INNER JOIN Orders B
ON A.OrderID = b.OrderID
WHERE B.OrderDate = (SELECT MIN(OrderDate) from Orders)
------------4-------------------
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
FROM Orders B
RIGHT JOIN  Employees A
ON A.EmployeeID=B.EmployeeID
GO
SELECT A.LastName, A.EmployeeID, B.OrderDate
FROM Employees A
FULL JOIN Orders B
ON A.EmployeeID=B.EmployeeID
GO





