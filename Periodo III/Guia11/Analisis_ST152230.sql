CREATE DATABASE Control_Pedidos
GO

USE Control_Pedidos
GO

CREATE SCHEMA Datos
GO

CREATE SCHEMA Pedidos
GO

CREATE TABLE Datos.Clientes 
(IDCliente int NOT NULL IDENTITY,
NombreCliente varchar(25) NOT NULL,
Direccion varchar(140),
Telefono char(9) NOT NULL,
TipoCliente int NOT NULL
CONSTRAINT PK_CLIENTE PRIMARY KEY (IDCliente) 
)
GO

CREATE TABLE Pedidos.Transportes 
(NumTransporte int NOT NULL IDENTITY,
NombreConductor varchar(25) NOT NULL,
CONSTRAINT PK_TRANSPORTE PRIMARY KEY (NumTransporte) 
)
GO

CREATE TABLE Datos.Ciudades 
(NombreCiudad varchar(50) NOT NULL,
Departamento varchar(50) NOT NULL
CONSTRAINT PK_CIUDAD PRIMARY KEY (NombreCiudad) 
)
GO

CREATE TABLE Pedidos.Pedidos 
(IDPedido int NOT NULL IDENTITY,
IDCliente int NOT NULL,
NumTransporte int NOT NULL,
Destino varchar(50) NOT NULL,
Peso decimal(10,2) NOT NULL,
FechaPedido date NOT NULL,
CONSTRAINT PK_PEDIDO PRIMARY KEY (IDPedido),
CONSTRAINT FK_PEDIDO_CLIENTE FOREIGN KEY (IDCliente) REFERENCES Datos.Clientes(IDCliente),
CONSTRAINT FK_PEDIDO_TRANSPORTE FOREIGN KEY (NumTransporte) REFERENCES Pedidos.Transportes(NumTransporte),
CONSTRAINT FK_PEDIDO_CIUDADES FOREIGN KEY (Destino) REFERENCES Datos.Ciudades(NombreCiudad)
ON DELETE CASCADE
ON UPDATE CASCADE 
)
GO



--A)
CREATE LOGIN RecursosHumanos WITH PASSWORD = '123456'
GO
CREATE USER RecursosHumanos_ FOR LOGIN RecursosHumanos
WITH DEFAULT_SCHEMA = Datos 
GO

GRANT SELECT, INSERT, UPDATE, DELETE  
ON SCHEMA :: Datos 
TO RecursosHumanos_
WITH GRANT OPTION
GO  	

--B)
CREATE LOGIN Secretaria WITH PASSWORD = '123456'
GO
CREATE USER Secretaria_ FOR LOGIN Secretaria
GRANT SELECT ON Pedidos.Pedidos TO Secretaria_


--c)
CREATE LOGIN Administrador WITH PASSWORD = '123456'
GO
CREATE USER Administrador_ FOR LOGIN Administrador
WITH DEFAULT_SCHEMA = Pedidos 
GO

GRANT SELECT, INSERT, UPDATE, DELETE 
ON SCHEMA :: Pedidos 
TO Administrador_
WITH GRANT OPTION
GO  	
