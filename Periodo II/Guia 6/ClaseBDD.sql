USE Northwind;
go

SELECT * FROM Products;
GO

SELECT ProductID, ProductName, UnitPrice FROM Products;
GO

SELECT ProductID, ProductName, UnitPrice FROM Products WHERE UnitPrice > 15;
GO

SELECT ProductID, ProductName, UnitPrice FROM Products WHERE UnitPrice >= 15 AND UnitPrice <= 50;
GO

SELECT ProductID, ProductName, UnitPrice FROM Products WHERE UnitPrice BETWEEN 15 AND 50;
GO

SELECT ProductID, ProductName, UnitPrice FROM Products WHERE  NOT UnitPrice > 15;
GO


SELECT ProductID, ProductName, UnitPrice FROM Products WHERE  ProductID > 15 OR UnitPrice < 10;
GO

--% indica que no importa lo que siga de la D
SELECT EmployeeID, LastName From Employees WHERE LastName LIKE 'D%';
go

SELECT EmployeeID, LastName From Employees WHERE LastName LIKE '%N';
go


--%sale% no importa donde este esa palabra clave dentro del titulo
SELECT EmployeeID, LastName, Title From Employees WHERE title LIKE '%SALES%';
go

SELECT EmployeeID, LastName From Employees WHERE LastName NOT LIKE 'D%';
go

--Esta entre corchetes porque el nombre de la tabla tiene un espacio
SELECT OrderID From [Order Details] WHERE OrderId  LIKE '_0248';
go


SELECT ProductID, ProductName, UnitPrice FROM Products ORDER BY productId	ASC
GO

SELECT ProductID, ProductName, UnitPrice FROM Products ORDER BY productId	desc
GO

SELECT DISTINCT OrderID from [Order Details];
GO

SELECT TOP 5 OrderID, ProductId, Quantity FROM [Order Details];
GO

SELECT TOP 2 WITH TIES OrderID, ProductId, Quantity FROM [Order Details] ORDER BY OrderId;
GO

SELECT TOP 10 PERCENT OrderID, ProductId, Quantity FROM [Order Details];
GO

SELECT CategoryName AS [Nombre de Categoria] FROM Categories;
GO

SELECT OrderId, OrderDate, ShippedDate, ShippedDate + 5 AS RetrasoEnvio FROM Orders;
GO


----------------------------------------------------------------------------------------------------
CREATE DATABASE Produc;
GO
USE Produc;
go

CREATE TABLE Categoria(
CodigoCategoria int PRIMARY KEY,
NombreCategoria varchar(50) 
);
GO

CREATE TABLE Producto(
CodigoProducto int PRIMARY KEY,
NombreProducto varchar(50),
PrecioUnitario decimal(18,2),
CodigoCategoria INT FOREIGN KEY REFERENCES Categoria(codigocategoria)
)
GO

INSERT INTO Producto VALUES
(1, 'Soda Coca Cola', 1.25, 1), 
(2, 'Carne bistec', 3.50, 2), 
(3, 'Camaronesd pequeños', 1.15, 6), 
(4, 'Harina blanca', 0.75, 3), 
(5, 'Te verde', 1.0, 1), 
(6, 'Lomo de aguja', 4.50, 2), 
(7, 'Soda de naranja', 1.25, 1), 
(8, 'Chiles verdes', 0.25, 4), 
(9, 'Tomates', 0.2, 4), 
(10, 'Manzana verde', 0.25, 5)
GO
--SE CREA UNA NUEVA TABLA Y A LA VEZ INSERTANDO 
SELECT * INTO [Producto CategoriaBebidas]
FROM Producto
WHERE CodigoCategoria=1;
GO

SELECT * FROM [Producto CategoriaBebidas];
go

CREATE TABLE[Producto CategoriaVegetales](
CodigoProducto int NOT NULL,
NombreProducto varchar(50),
PrecioUnitario decimal (18,2),
CodigoCategoria int,
CONSTRAINT pk_producto1 PRIMARY KEY(CodigoProducto),
CONSTRAINT fk_categoria1 FOREIGN KEY (CodigoCategoria) REFERENCES Categoria(CodigoCategoria)
)
GO

INSERT INTO [Producto CategoriaVegetales]
SELECT CodigoProducto, NombreProducto, PrecioUnitario, CodigoCategoria FROM Producto WHERE CodigoCategoria=4;
GO
SELECT * FROM [Producto CategoriaVegetales];
go

UPDATE [Producto CategoriaBebidas] SET PrecioUnitario = 1.50;
GO
UPDATE [Producto CategoriaBebidas] SET PrecioUnitario=1.25 WHERE CodigoProducto=1;
GO
UPDATE [Producto CategoriaBebidas] SET PrecioUnitario=1.75 WHERE CodigoProducto=1 AND CodigoCategoria=1;
GO
UPDATE [Producto CategoriaBebidas] SET PrecioUnitario=5.75 WHERE NombreProducto='Te verde';
GO
UPDATE [Producto CategoriaBebidas] SET PrecioUnitario=2.00, NombreProducto='Soda LC' WHERE CodigoProducto=1 AND CodigoCategoria=1;
GO

DELETE FROM [Producto CategoriaBebidas];
GO
DELETE FROM Producto WHERE CodigoCategoria=4;
GO
------------CONSULTAS EN CASCADA
DELETE FROM Categoria WHERE CodigoCategoria = 6;
GO

ALTER TABLE Producto
ADD CONSTRAINT fk_categoria
FOREIGN KEY (CodigoCategoria) REFERENCES Categoria (CodigoCategoria)
ON DELETE CASCADE
ON UPDATE CASCADE
GO

CREATE TABLE [Producto CategoriaFrutas]
(CodigoProducto int NOT NULL,
NombreProducto varchar(50),
PrecioUnitario decimal (18,2),
CodigoCategoria int,
CONSTRAINT pk_producto2 PRIMARY KEY(CodigoProducto),
CONSTRAINT fk_categoria2 FOREIGN KEY (CodigoCategoria) REFERENCES Categoria(CodigoCategoria)
ON DELETE CASCADE
ON UPDATE CASCADE
)
GO


INSERT INTO [Producto CategoriaFrutas]
SELECT CodigoProducto, NombreProducto, PrecioUnitario, CodigoCategoria FROM Producto WHERE CodigoCategoria=5;
GO

SELECT * FROM [Producto CategoriaFrutas];
GO


UPDATE [Producto CategoriaFrutas] SET PrecioUnitario=2.50 WHERE CodigoCategoria=5;
GO
UPDATE [Producto CategoriaFrutas] SET CodigoCategoria=1 WHERE CodigoProducto=10;
GO

DELETE FROM [Producto CategoriaFrutas] WHERE CodigoCategoria=1;
GO




