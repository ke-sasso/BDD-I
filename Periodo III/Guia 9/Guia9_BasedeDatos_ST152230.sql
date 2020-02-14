use NORTHWND
GO

-----------vistas----------------
CREATE VIEW productos_proveedor_ST152230
AS
SELECT ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
Discontinued
FROM Products
WHERE SupplierID = 14
GO

SELECT * FROM productos_proveedor_ST152230
GO

--------------------------------------------
CREATE VIEW productos_proveedor_2_ST152230
AS
SELECT ProductID, ProductName, a.SupplierID, CategoryID, QuantityPerUnit, UnitPrice,
Discontinued, b.CompanyName
FROM Products a
INNER JOIN Suppliers b
ON a.SupplierID = b.SupplierID
WHERE a.SupplierID = 14
GO

SELECT * FROM productos_proveedor_2_ST152230
GO
DROP VIEW productos_proveedor_2_ST152230
go

----------------------------------------------------------
CREATE VIEW PerdidosProductos1997_ST152230
AS
SELECT A.ProductName, C.OrderDate, C.ShippedDate, (B.UnitPrice*B.Quantity) AS 'TOTAL'
FROM Products A
INNER JOIN [Order Details] B
ON A.ProductID = B.ProductID
INNER JOIN Orders C
ON B.OrderID = C.OrderID
WHERE Year(OrderDate) = YEAR('1997')
go

SELECT * FROM PerdidosProductos1997_ST152230 ORDER BY ProductName

-----------------------------------------------------------
CREATE VIEW TotalProductos_ST152230
AS
SELECT A.ProductName, SUM(B.UnitPrice*B.Quantity) AS 'SUBTOTAL', SUM(B.UnitPrice*B.Quantity-(B.UnitPrice*B.Quantity*B.Discount)) AS 'TOTAL'
FROM Products A
INNER JOIN [Order Details] B
ON A.ProductID = B.ProductID
GROUP BY ProductName
GO

SELECT * FROM TotalProductos_ST152230  ORDER BY ProductName

------------------------------------------------------------
CREATE PROCEDURE sp_Insertar_CategoriasST152230
@ID int,
@NombreCategoria VARCHAR(15)
AS
IF(SELECT COUNT(*) FROM Categories
   WHERE CategoryID=@ID OR CategoryName=@NombreCategoria)=0
   INSERT INTO Categories(CategoryName)
   VALUES(@NombreCategoria)
   ELSE
   PRINT 'ERROR LA CATEGORIA YA EXISTE'
GO

EXEC sp_Insertar_CategoriasST152230 1, 'Alimentos'
GO
EXEC sp_Insertar_CategoriasST152230 9, 'Alimentos'
go
EXEC sp_Insertar_CategoriasST152230 10, 'Alimentos'
go

----------------------------------------------------
CREATE PROCEDURE sp_Hay_ClientesST152230
@ciudad varchar(15)
AS
SELECT 
CASE(SELECT COUNT(*) FROM Customers WHERE City=@ciudad)
WHEN 0 THEN 'No hay clientes en la ciudad de ' + @ciudad
ELSE 'Hay clientes en la ciudad de  ' + @ciudad
END

EXEC sp_Hay_ClientesST152230 'Barcelona'
EXEC sp_Hay_ClientesST152230 'New York'

---------------------------------------------------
CREATE PROCEDURE PROCE_totalST152230
AS
SELECT OrderID,
SUM(CONVERT (money,(unitPrice*Quantity*(1-Discount)/100))*100)
AS 'TOTAL'
FROM [Order Details]
GROUP BY OrderID
GO
EXEC  PROCE_totalST152230
-----------------------------------------------------
CREATE PROCEDURE PROCE_total_2ST152230
@Cod_orden int
AS
SELECT OrderID,
SUM(CONVERT (money,(unitPrice*Quantity*(1-Discount)/100))*100)
AS 'TOTAL'
FROM [Order Details]
WHERE OrderID=@Cod_orden
GROUP BY OrderID
GO
EXEC  PROCE_total_2ST152230 10248
EXEC  PROCE_total_2ST152230 10242

----------------------------------------------
ALTER PROCEDURE Proce_total_2ST152230
@Cod_orden int
AS
DECLARE @total int --declaracion de variables locales
SELECT @total=count(orderid) FROM [Order Details] WHERE OrderID=@Cod_orden
if(@total>=1)
BEGIN 
SELECT OD.OrderID,
SUM(CONVERT(money,(OD.UnitPrice*Quantity*(1-Discount)/100))*100) AS 'TOTAL'
FROM [Order Details] OD
WHERE OrderID =  @Cod_orden
group by OD.OrderID
END
ELSE
BEGIN 
PRINT 'La orden no existe y el codigo es: ' + convert(varchar(10), @Cod_Orden)
END
GO
EXEC  PROCE_total_2ST152230 10248
EXEC  PROCE_total_2ST152230 10242


--------------------------complementario-----------------------
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