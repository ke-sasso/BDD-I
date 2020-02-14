CREATE DATABASE Control_pedidos
GO

USE Control_pedidos
GO

CREATE TABLE Productos
(
idproducto CHAR(8) NOT NULL,
nombreproducto VARCHAR(25),
existencia INT NOT NULL,
precio DECIMAL(10,2) NOT NULL, 
preciov DECIMAL(10,2) NOT NULL,
CONSTRAINT pk_idproducto PRIMARY KEY(idproducto)
)
GO

CREATE TABLE Pedidos
(
idpedido INT IDENTITY,
idproducto CHAR(8) NOT NULL,
cantidad_pedido INT,
CONSTRAINT fk_idbod FOREIGN KEY (idproducto) REFERENCES Productos(idproducto)
)
GO

INSERT INTO Productos VALUES
('prod001', 'Filtros pantalla', 5, 10, 12.5),
('prod002', 'Parlantes', 7, 10, 11.5),
('prod003', 'Mouse', 10, 60.2, 80.0),
('prod004', 'Monitor', 8, 4.5, 6),
('prod005', 'Lápiz', 5, 1.2, 2.0)
GO

---1---

CREATE TRIGGER Agregar_producto
ON Productos
FOR INSERT
AS
	PRINT 'Producto ingresado'
GO

INSERT INTO Productos VALUES
('prod006', 'Lapiceros BIC', 100, 0.15, 0.25)
GO

SELECT * FROM Productos
GO

CREATE TRIGGER AgregarPedido
ON Pedidos
FOR INSERT
AS
	PRINT 'Pedido ingresado'
GO

INSERT INTO Pedidos VALUES
('prod005', 1)
GO

SELECT * FROM Pedidos
GO

---2--------

CREATE TRIGGER T_producto
ON Productos
FOR INSERT, UPDATE
AS
	DECLARE @precio DECIMAL(10,2)
	DECLARE @precio_venta DECIMAL(10,2)

	SELECT @precio = precio FROM inserted
	SELECT @precio_venta = preciov FROM inserted

	IF @precio > @precio_venta

	  BEGIN
	    PRINT 'El precio no debe de ser mayor al precio de venta.'
		ROLLBACK TRANSACTION
	  END 

   ELSE IF UPDATE(precio)
	
		BEGIN
			PRINT 'Precio actualizado'
		END 

  ELSE
   
	 BEGIN
	  PRINT 'Datos ingresados'
	 END
 
GO

INSERT INTO Productos VALUES
('prod001', 'lg g4', 50, 10.00, 250.00)
GO

UPDATE Productos SET precio = '20.00' WHERE idproducto = 'prod001'
GO

---3------------

CREATE TRIGGER t_pedidos
ON Pedidos
FOR INSERT, UPDATE
AS
	DECLARE
    @existencias INT,
	@pedido INT,
    @id CHAR(8)
	SELECT @pedido = cantidad_pedido FROM inserted
	SELECT @id = idproducto FROM inserted
	SELECT @existencias = existencia FROM Productos WHERE idproducto = @id
	if(@existencias<@pedido)
		BEGIN
			PRINT 'la cantidad es mayor a la de existencia'
			ROLLBACK TRANSACTION
		END
	ELSE
		BEGIN
		   UPDATE Productos SET existencia = @existencias - @pedido WHERE idproducto = @id
		   PRINT 'Se a registrado un nuevo registro a la tabla pedido'
		END

GO


INSERT INTO Pedidos VALUES
('prod004', 5)
GO

