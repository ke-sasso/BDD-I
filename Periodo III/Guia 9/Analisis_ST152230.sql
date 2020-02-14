CREATE DATABASE Bodega
GO
USE Bodega
GO
CREATE TABLE PRODUCTO
(
idprod char(7) PRIMARY KEY,
descripcion varchar(25),
existencias int,
precio decimal(10,2) not null,
preciov decimal(10,2) not null,
ganancia as preciov - precio,
CHECK (preciov>precio)
)
GO
CREATE TABLE Pedido
(
idpedido char(7),
idprod char(7),
cantidad int,
FOREIGN KEY (idprod) REFERENCES Producto(idprod)
)
GO



CREATE PROCEDURE Insertar_PRODUCTOS
@ID char(7),
@Descripcion VARCHAR(25),
@existencias int,
@precio decimal(10,2),
@preciov decimal(10,2)
AS
IF(SELECT COUNT(*) FROM PRODUCTO WHERE idprod=@ID)=0
   INSERT INTO PRODUCTO
   VALUES(@ID, @Descripcion,@existencias, @precio, @preciov)
   ELSE
   PRINT 'ERROR YA EXISTE ESTE PRODUCTO'
GO


INSERT INTO PRODUCTO VALUES
('PRO0000', 'Bebidas', 10,5,6),
('PRO0001', 'Frutas', 200,4,5),
('PRO0002', 'Carnes', 500,3,5),
('PRO0003', 'Churros', 1000,1,2)
GO

EXEC Insertar_PRODUCTOS 'PRO0000', 'Bebidas', 10,5,6
GO
EXEC Insertar_PRODUCTOS 'PRO0004', 'Cereales', 100,2,3
GO


CREATE PROCEDURE ingresarPedido
@ID char(7),
@producto char(7),
@cantidad int
AS
DECLARE @total int --declaracion de variables locales
SELECT @total=existencias FROM PRODUCTO WHERE idprod=@producto


IF (SELECT COUNT(*) FROM Pedido WHERE idpedido=@ID)=0
BEGIN

		IF(SELECT COUNT(*) FROM PRODUCTO WHERE idprod=@producto)=1
						   IF(@cantidad>@total)
						   BEGIN
								PRINT 'EXISTENCIA DEL PRODUCTO INSUFIENTE'
						   END
						   ELSE 
						   BEGIN
						   INSERT INTO Pedido
								VALUES(@ID, @producto,@cantidad)
								UPDATE PRODUCTO SET existencias=@total-@cantidad WHERE idprod=@producto
						   END
		 ELSE 
		 PRINT 'ESTE PRODUCTO NO EXISTE'
		 END
ELSE
PRINT 'ESTE PEDIDO YA EXISTE'
GO


INSERT INTO PEDIDO VALUES
('PED0001','PRO0000',2)
GO
EXEC ingresarPedido 'PED0004','PRO0001',10
GO

