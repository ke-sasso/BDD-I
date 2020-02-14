USE Northwind
go

CREATE PROCEDURE Mostrar_10_pedidos_ST152230
AS
DECLARE @contador int
DECLARE @num int

SET @contador=0
--obteniendo el primer valor del campo ORDERID de la tabla orders
SET @num=(SELECT TOP 1 OrderID FROM Orders ORDER BY OrderID)
--evalua si el contador e menor que 10 si la condicion se cumple
--realiza la instruccion SELECT
WHILE @contador<10
BEGIN
   SELECT OrderID, OrderDate FROM Orders WHERE OrderID=@num+@contador
   --se incrementa el contadpr
   SET @contador=@contador+1
END

EXEC Mostrar_10_pedidos_ST152230
GO
------------------------------------------------------------
CREATE PROCEDURE Actualizar_precio_ST152230
AS
   WHILE (SELECT AVG(UnitPrice) FROM Products) < 300
   BEGIN
      UPDATE Products
	  SET UnitPrice = UnitPrice*2
	  SELECT MAX(UnitPrice) AS [Precio Maximo] FROM Products
	  IF(SELECT MAX(UnitPrice) FROM Products)<500
	   BREAK
	   --SALE DEL BUCLE MAS INTERNO EN UNA INSTRUCCION WHILE O UNA INSTRUCCION IF.ELSE
	   --DENTRO DE UN BUCLE WHILE
	   ELSE
	   CONTINUE
	   --REINICIA UN BUCLE WHILE LAS INTRUCCIONES QUE SE ENCUENTREN DESPUES DE LA
	   --PALABRA CLAVE CONTINUE SE OMITEN
	   END

SELECT UnitPrice FROM Products
ORDER BY UnitPrice desc

EXECUTE Actualizar_precio_ST152230
GO

-----------------------------------------------
CREATE PROC Mostrar_Clientes_ST155230
AS
   DECLARE @Nombre NVARCHAR(40)
   --Se declara el cursos @CURSOS, EL CUAL SE utiliza para recorrer
   --cada resultado de la consulta SELECT
   DECLARE @cursor CURSOR

   --Se asigna el primer dato al cursor
   SET @cursor = CURSOR FOR SELECT CompanyName FROM Customers
   --abrir el cursor
   OPEN @cursor
   --RECUPERA LAS FILAS DEL CURSOR
   FETCH NEXT
   FROM @cursor INTO @Nombre
   WHILE @@FETCH_STATUS = 0
   BEGIN
      PRINT 'El nombre del cliente es: ' + @Nombre
	  --se mueve al siguiente registro
	  FETCH NEXT FROM @cursor INTO @Nombre
   END
   --ESTE COMANDO HACE DESPARECER EL PUNTERO SOBRE EL REGISTRO ACUTUAL
   CLOSE @cursor
   DEALLOCATE @cursor
   GO

EXEC Mostrar_Clientes_ST155230
GO

--------------------TRIGGERS O DESENCADENADORES-----------------------
CREATE TRIGGER Disp_SEGURIDAD_ST152230
ON DATABASE FOR DROP_TABLE, ALTER_TABLE
AS
   BEGIN 
   --RAISERROR SE USA PARA DEVOLVER MENSAJES ALAS APLICACIONES
   --MISMO FORMATO QUE UN ERROR DEL SISTEMA
   RAISERROR ('No esta permitido borrar ni modificar tablas', 16,1)
   --16 severidad
   --1 estadp

   ROLLBACK TRANSACTION
   END
   GO

--crear la tabla
CREATE TABLE Prueba_j
(
CAMPO INT
)
go

DROP TABLE prueba_j

CREATE TRIGGER Mensaje_Insersion_ST152230
ON prueba_j
AFTER INSERT
AS
   BEGIN
   PRINT 'Se agreggo un nuevo registro a la tabla'

   --EL ROLLBACK NO PERMITE REGISTRAR EN LA TABLA
   --ROLLBACK TRANSACTION
   END

INSERT INTO prueba_j VALUES (3)

---------------------------------------------
INSERT INTO Employees(LastName, FirstName) VALUES ('Kevin','Sasso')

CREATE TRIGGER Actualizar_emple_ST152230
ON Employees
AFTER UPDATE
AS
  IF UPDATE(Lastname)
  BEGIN
    PRINT 'Se realizo un cambi en el apellido de un empleado'
  END

SELECT * FROM Employees

UPDATE Employees SET LastName='Torres' WHERE EmployeeID=10

------------------------------------------------
INSERT INTO Employees(LastName, FirstName) VALUES ('Miguel','Sasso')

CREATE TRIGGER Eliminar_emple_ST152230
ON Employees
FOR DELETE
AS
 IF(SELECT COUNT(*) FROM deleted)>1
 BEGIN
  PRINT 'NO SE PUEDE BORRAR MAS DE UN EMPLEADO AL MISMO TIEMPO'
  ROLLBACK TRANSACTION
END

DELETE FROM Employees WHERE EmployeeID >= 10
DELETE FROM Employees WHERE EmployeeID = 11