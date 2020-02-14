USE master;--hacer uso de la base de datos MASTERE
GO 
CREATE DATABASE Hotel_ST152230
ON 
(
NAME = Hotel_ST152230_dat,
FILENAME = 'C:\Guia4_ST152230\Hotel_ST152230.mdf',
SIZE=5,
MAXSIZE=20,
FILEGROWTH=5)
LOG ON
(
NAME = Hotel_ST152230_log,
FILENAME = 'C:\Guia4_ST152230\Hotel_ST152230.ldf',
SIZE=2,
MAXSIZE=10,
FILEGROWTH=2
);

Use Hotel_ST152230
GO

CREATE TABLE Hotel
(
CodigoHotel char(5) NOT NULL PRIMARY KEY,
Nombre varchar(25),
Direccion varchar(30),
SitioWeb varchar(50),
)
GO

CREATE TABLE Habitacion
(
CodigoHabitacion char(5) NOT NULL PRIMARY KEY,
Tipo varchar(25),
Precio decimal(18,0),
CodigoHotel char(5) NOT NULL FOREIGN KEY REFERENCES Hotel(CodigoHotel),
)
GO

CREATE TABLE Huesped
(
CodigoHuesped char(5) NOT NULL PRIMARY KEY,
Nombre varchar(25),
Email varchar(MAX),
Direccion varchar(50),
)
GO

CREATE TABLE Reservacion
(
CodigoReservacion char(5) NOT NULL PRIMARY KEY,
Fechainicio date NOT NULL,
Fechafinal date NOT NULL,
CodigoHotel char(5) NOT NULL FOREIGN KEY REFERENCES Hotel(CodigoHotel),
CodigoHabitacion char(5) NOT NULL FOREIGN KEY REFERENCES Habitacion(CodigoHabitacion),
CodigoHuesped char(5) NOT NULL FOREIGN KEY REFERENCES Huesped(CodigoHuesped),
)
GO

--UNIQUUE-------
ALTER TABLE Hotel
ADD CONSTRAINT U_NOMBRE
UNIQUE (Nombre)
go
ALTER TABLE Hotel
ADD CONSTRAINT U_sitio
UNIQUE (SitioWeb)
go

ALTER TABLE Huesped
ADD CONSTRAINT U_email
UNIQUE (Email)
GO



--CHEKC
ALTER TABLE Habitacion
ADD CONSTRAINT CK_precio
CHECK (Precio >25);
GO
ALTER TABLE Habitacion
ADD CONSTRAINT CK_tipo
CHECK (Tipo = 'Doble' or Tipo='Individual');
GO
ALTER TABLE Reservacion
ADD CONSTRAINT CK_fechas
CHECK (FechaFinal > Fechainicio);
GO

--Restriccion default
ALTER TABLE Reservacion
ADD CONSTRAINT DF_fecha
DEFAULT getdate()  FOR fechainicio;
GO
