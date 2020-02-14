CREATE DATABASE Renta;
GO
USE renta;
GO

CREATE TABLE Cliente
(
IdCliente char(5) PRIMARY KEY NOT NULL,
Nombres varchar(50) NOT NULL,
Apellidos varchar(50) NOT NULL,
Direccion varchar(50) NOT NULL,
);
GO

CREATE TABLE NumeroCliente
(
IdCliente char(5),
Telefono char(9)
)
GO
ALTER TABLE NumeroCliente
ADD
--Creando la relacion entre la tabla cliente y la tabla reserva
CONSTRAINT fk_cliente_tel FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
GO


CREATE TABLE CorreoCliente
(
IdCliente char(5),
Correos varchar(70)
)
GO
ALTER TABLE CorreoCliente
ADD
--Creando la relacion entre la tabla cliente y la tabla reserva
CONSTRAINT fk_cliente_correos FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
GO
ALTER TABLE CorreoCliente
ADD CONSTRAINT UQ_CORREO
UNIQUE(Correos)
GO


CREATE TABLE Autos
(
IdAuto char(5) PRIMARY KEY NOT NULL,
Marca varchar(50) NOT NULL,
Modelo varchar (50) NOT NULL,
NumPlaca varchar(20) NOT NULL UNIQUE, 
Observaciones varchar(50) NOT NULL
);
GO

CREATE TABLE Reserva(
IdReserva int IDENTITY,
FechaInicio date NOT NULL,
FechaFin date NOT NULL,
IdCliente char(5) NOT NULL,
IdAuto char(5)NOT NULL
);
GO

ALTER TABLE Reserva
ADD CONSTRAINT DF_Fecha
DEFAULT getdate() FOR FechaInicio;
GO


ALTER TABLE Reserva
ADD
--Creando la relacion entre la tabla cliente y la tabla reserva
CONSTRAINT fk_cliente_1 FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE Reserva
ADD
--Creando la relacion entre la tabla auto y la tabla reserva
CONSTRAINT fk_auto FOREIGN KEY (IdAuto) REFERENCES Auto(IdAuto)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

-------------------------------CONSULTAS INSERT
INSERT INTO Cliente VALUES
('KS002', 'Kevin Edmundo', 'Sasso Torres', 'Monte Blanco. Soyapando');
GO
INSERT INTO Cliente Values
('MS003', 'Manuel Alexander', 'Sousa Sariaba', 'San Jose. Santa tecla');
GO
INSERT INTO Cliente Values
('MO004', 'Maria Odilia', 'Orellana Sasso', 'Margaritas. Soyapando');
GO
INSERT INTO Cliente Values
('AP005', 'Alberto Jose', 'Miranda Peña', 'Sierra 2, Soyapando');
GO
INSERT INTO Cliente Values
('HL006', 'Henry Emerson', 'Lopez Fuentes', 'Rerp. Gudalupe, Soyapando');
GO
INSERT INTO Cliente Values
('MJ007', 'Miguel Angel', 'Juarez Perez', 'Prados II Soyapando');
GO
INSERT INTO Cliente Values
('AM008', 'Amilcar Jose', 'Montano Ramos', 'Alta vista Ilopango');
GO
INSERT INTO Cliente Values
('FG009', 'Fernando Jose', 'Gomez Hernandez', 'Prusia, Soyapando');
GO
INSERT INTO Cliente Values
('RQ010', 'Rafael Alejandro', 'Quezada Romero', 'Prados I, Soyapando');
GO


INSERT INTO CorreoCliente Values('RQ0010', 'rafa@gamil.com')
INSERT INTO CorreoCliente Values ('KS002', 'kevin_edu@gmail.com')
INSERT INTO CorreoCliente Values('KS002', 'kevin_edu_2015@gmail.com')
INSERT INTO CorreoCliente Values('FG009', 'fatima@gmail.com')
INSERT INTO CorreoCliente Values('AM008', 'amilcar@gmail.com')
INSERT INTO CorreoCliente Values('HL006', 'henry@gmail.com')
INSERT INTO CorreoCliente Values('HL006', 'k_LOPEZ@gmail.com')
INSERT INTO CorreoCliente Values('RQ010', 'rafa2015@gamil.com')
INSERT INTO CorreoCliente Values('AP005', 'ALBERTO@gmail.com')
INSERT INTO CorreoCliente Values('AP005', 'alberto_2015@gmail.com')
GO


INSERT INTO NumeroCliente Values('RQ010', '7784-3456')
INSERT INTO NumeroCliente Values ('KS002', '2235-3445')
INSERT INTO NumeroCliente Values('KS002', '7734-3456')
INSERT INTO NumeroCliente Values('FG009', '7892-3452')
INSERT INTO NumeroCliente Values('AM008', '7734-9022')
INSERT INTO NumeroCliente Values('HL006', '6789-1342')
INSERT INTO NumeroCliente Values('HL006', '7722-0987')
INSERT INTO NumeroCliente Values('RQ010', '7723-1234')
INSERT INTO NumeroCliente Values('AP005', '7233-5342')
INSERT INTO NumeroCliente Values('AP005', '7722-6452')
GO

INSERT INTO Autos VALUES('CC201', 'Honda Civic', 'Año 2015', '234234-32','En perefecto estado')
GO
INSERT INTO Autos VALUES('CD201', 'Honda Civic', 'Año 2010', '24354-32','En perefecto estado')
INSERT INTO Autos VALUES('CY201', 'Hyuday', 'Año 2011', '334234-32','En perefecto estado')
INSERT INTO Autos VALUES('CJ201', 'Nissan', 'Año 2011', '434234-32','En perefecto estado')
INSERT INTO Autos VALUES('CZ200', 'Toyota', 'Año 2000', '2334234-32','En perefecto estado')
INSERT INTO Autos VALUES('CS200', 'Toyota', 'Año 2001', '564234-32','En perefecto estado')
INSERT INTO Autos VALUES('CP200', 'Ford', 'Año 2005', '095234-32','En perefecto estado')
INSERT INTO Autos VALUES('CW200', 'Ford', 'Año 2014', '043434-32','En perefecto estado')
INSERT INTO Autos VALUES('CQ199', 'Nissan', 'Año 1999', '12434-32','En perefecto estado')
INSERT INTO Autos VALUES ('CU201', 'Honda', 'Año 2010', '8475334-32','En perefecto estado')
GO



INSERT	INTO Reserva VALUES
('01/02/2015', '01/10/2015', 'AM008', 'CC201');
GO
INSERT INTO Reserva VALUES
('02/09/2015', '01/01/2016','AP005'	,'CC201'),
('05/09/2015', '01/10/2016','FG009', 'CD201'),
('10/02/2015', '01/04/2015','HL006', 'CJ201'),
('03/01/2015', '16/01/2016', 'KS002', 'CP200'),
('02/02/2015', '13/07/2015', 'MJ001', 'CQ199'),
('22/05/2015', '05/08/2016', 'MJ007', 'CS200'),
('25/03/2015', '03/06/2015', 'MO004', 'CU201'),
('21/08/2015', '17/10/2015', 'MS003', 'CW200'),
('26/04/2015', '22/05/2015', 'RQ010', 'CZ200')
GO


---------------------------------------- CONSULTAS UPDATE
UPDATE Cliente SET Nombres='Guillermo Alexander' WHERE IdCliente='AM008';
GO
UPDATE Autos SET IdAuto='JJ200' WHERE NumPlaca='2334234-32';
GO
UPDATE NumeroCliente SET Telefono='73516827' WHERE IdCliente='KS002'
GO
UPDATE Reserva SET FechaFin='1/10/16' WHERE IdCliente='AP005' AND IdAuto='CC201';
GO
UPDATE Cliente SET Direccion='Ciudad Merliot, Santa Tecla' WHERE IdCliente='KS002';
GO

------------------------------------CONSULTAS DELETE
DELETE FROM Autos WHERE  NumPlaca='2334234-32';
GO
DELETE FROM Autos WHERE IdAuto='CC201';
GO
DELETE FROM NumeroCliente WHERE IdCliente='KS002';
GO
DELETE FROM CorreoCliente WHERE IdCliente='KS002';
GO
DELETE FROM Reserva WHERE IdCliente='MS003' AND IdAuto='CW200';
GO
