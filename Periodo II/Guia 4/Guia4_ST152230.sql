--Creando la base de datos
USE master;--hacer uso de la base de datos MASTERE
GO --comando que inidica el final de un lote de instrucciones

CREATE DATABASE Basededatos_ST152230
ON 
(
NAME = Basededatos_ST152230_dat,
FILENAME = 'C:\Guia4_ST152230\Basededatos_ST152230.mdf',
SIZE=5,
MAXSIZE=20,
FILEGROWTH=5)
LOG ON
(
NAME = Basededatos_ST152230_log,
FILENAME = 'C:\Guia4_ST152230\Basededatos_ST152230.ldf',
SIZE=2,
MAXSIZE=10,
FILEGROWTH=2
);
GO
--SELECCIONANDO LA BASE DE DATOS DEL EJERCICIO
Use Basededatos_ST152230
go

--CREANDO LAS TABLAS
--tabla autor
CREATE TABLE Autor
(
CodigoAutor char(5) NOT NULL,
PrimerNombre varchar(25),
SegundoNombre varchar(30),
FechaNacimiento date,
Nacionalidad varchar(35),
)
GO
--tabla libro
CREATE TABLE Libro
(
CodigoLibro char(10) NOT NULL,
Titulo varchar(max),
ISBN varchar(20) NOT NULL,
AñoEdicion char(4),
CodigoEditorial char(5),
)
GO

--tabla Editorial
CREATE TABLE Editorial
(
CodigoEditorial char(5) NOT NULL,
Nombre varchar(45),
Pais varchar(50),
)
GO

--tabla Detalle_AutorLibro
CREATE TABLE Detalle_AutorLibro
(
CodigoAutor char(5),
CodigoLibro char(10),
Fecha date,
)
GO

--CREANDO LAS RESTRICCIONES 
--CREANDO LLAVES PRIMARIAS
--TABLA AUTOR
ALTER TABLE Autor
ADD CONSTRAINT PK_CodigoAutor
PRIMARY KEY (CodigoAutor)
GO
--TABLA LIBRO
ALTER TABLE Libro
ADD CONSTRAINT PK_CodigoLibro
PRIMARY KEY (CodigoLibro)
GO
--TABLA Editorial
ALTER TABLE Editorial
ADD CONSTRAINT PK_CodigoEditorial
PRIMARY KEY (CodigoEditorial)
GO

--Creacion de llaves foraneas
--Relacion entre autor y detalle autorLibro
ALTER TABLE Detalle_AutorLibro
ADD CONSTRAINT FK_CodigoAutor
FOREIGN KEY (CodigoAutor)
REFERENCES Autor(CodigoAutor)
GO
--Relacion entre libro y detalle autorLibro
ALTER TABLE Detalle_AutorLibro
ADD CONSTRAINT FK_CodigoLibro
FOREIGN KEY (CodigoLibro)
REFERENCES Libro(CodigoLibro)
GO

--Relacion entre Editorial y libro
ALTER TABLE Libro
ADD CONSTRAINT FK_LibroEditorial
FOREIGN KEY (CodigoEditorial)
REFERENCES Editorial(CodigoEditorial)
GO

--Restriccion default
ALTER TABLE Detalle_AutorLibro
ADD CONSTRAINT DF_fecha
DEFAULT getdate()  FOR fecha;
GO
--Restriccion default
ALTER TABLE Libro
ADD CONSTRAINT CK_añoedicion
CHECK (AñoEdicion >2010);
GO
--RESTRICCION UNIQUE
ALTER TABLE Libro
ADD CONSTRAINT U_isbn
UNIQUE (ISBN)
go


--USO DE COMANDO DROP
CREATE DATABASE GUIA5_ST152230
GO
USE GUIA5_ST152230
GO
CREATE TABLE tabla
(
campo1 int,
campo2 varchar(5)
)
GO
--eliminando la tabla
DROP TABLE tabla
GO
--ELIMINANDO LA BASE DE DATOS
USE master
GO
DROP DATABASE GUIA5_ST152230
GO







