USE NORTHWND
go
---------------1-----------------------
CREATE VIEW mostrar_productos
AS
SELECT ProductID, ProductName, UnitPrice
FROM Products
go

SELECT * FROM mostrar_productos

---------------2-----------------------
CREATE VIEW categoria
AS
SELECT A.ProductName, B.CategoryName
FROM Products A
INNER JOIN Categories B
on A.CategoryID = b.CategoryID
WHERE B.CategoryName = 'Beverages'
go
SELECT * FROM categoria

---------------3----------------------
CREATE VIEW CLIENTES
AS
SELECT A.CustomerId, A.CompanyName, B.OrderDate
FROM Customers A
INNER JOIN Orders B
ON A.CustomerID = B.CustomerID
GO

SELECT *  FROM CLIENTES 

---------------4---------------------
CREATE VIEW CategoriasProduct
AS
SELECT B.CategoryName, COUNT(*) AS 'EXISTENCIA'
FROM Products A
INNER JOIN Categories B
ON A.CategoryID = B.CategoryID
GROUP BY B.CategoryName
GO

SELECT * FROM CategoriasProduct
---------------5----------------------
CREATE VIEW promedio_categoria
AS
SELECT B.CategoryName, AVG(A.UnitPrice) AS 'Promedio'
from Products A
INNER JOIN Categories B
ON A.CategoryID = B.CategoryID
WHERE CategoryName='Produce' OR CategoryName='Confections'
GROUP BY CategoryName
GO
SELECT * FROM promedio_categoria