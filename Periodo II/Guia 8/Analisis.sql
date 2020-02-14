CREATE DATABASE Guia8;
GO
USE Guia8
GO

CREATE TABLE Maquina
(
Cod_Maquinaria char(6) NOT NULL PRIMARY KEY Check (Cod_Maquinaria Like 'M[0-9][0-9][0-9][0-9][0-9]'),
Descripcion varchar(50) NOT NULL,
Marca varchar(50) NOT NULL,
Modelo varchar(50) NOT NULL,
FechaIngreso DATE Default Getdate()
)
GO

CREATE TABLE Empleado
(
Id char(10) PRIMARY KEY CHECK (Id like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]'),
Nombres varchar(50) NOT NULL,
Apellidos varchar(50) NOT NULL,
Edad char(2) NOT NULL,
FechaInicio DATE Default GetDate()
)
GO

CREATE TABLE Bitacora
(
Correlativo INT NOT NULL PRIMARY KEY IDENTITY,
Id char(10) NOT NULL,
Cod_Maquina char(6) NOT NULL,
TiempoUso char(5) NOT NULL,
Lugar varchar(50) NOT NULL,
CONSTRAINT FK_Empleado FOREIGN KEY (Id) REFERENCES Empleado(Id),
CONSTRAINT FK_Maquina FOREIGN KEY (Cod_Maquina) REFERENCES Maquina(Cod_Maquinaria)
ON DELETE CASCADE
ON UPDATE CASCADE
)
GO


INSERT INTO Bitacora Values 
('12345678-9','M00001', '250', 'Santiago Nonualco'),
('01234567-8','M00002', '300', 'Santiago Nonualco'),
('90123456-7','M00003', '500', 'Alegria, Usulutan'),
('89012345-6','M00004', '300', 'Alegria, Usulutan'),
('90123456-7','M00005', '250', 'Santiago Nonualco'),
('01234567-8','M00002', '125', 'Santiago Nonualco'),
('12345678-9','M00003', '375', 'Alegria, Usulutan'),
('12345678-9','M00004', '200', 'Alegria, Usulutan')
go

INSERT INTO Empleado VALUES
('01234567-8','Carlos Fidel','Argueta Miranda','45','2006-08-21'),
('12345678-9','Juan Francisco','Villatla Alvarado','32','2010-02-27'),
('78901234-5','Raúl Alejandro','Poncio Valladares','32','2010-02-27'),
('89012345-6','Miguel Eduardo','Morales Claro','26','2010-08-21'),
('90123456-7','Fabricio David','Alas Flores','30','2008-12-01')
GO

INSERT INTO Maquina VALUES
('M00001','TALADORA DE ELEMENTOS VARIOS','CARTERPILAR','EVO2000','2006-01-31'),
('M00002','APLANADORA DE SUELOS Y OTROS','CARTERPILAR','FLU5000','2006-01-31'),
('M00003','PULVERIZADORA DE ELEMENTOS','CARTERPILAR','ASD2001','2006-01-31'),
('M00004','CONCRETERIA','MG','EDS','2006-05-31'),
('M00005','MAQUINA ESPECIAL PARA PROYECTO 10','MG','SFD','2006-05-31'),
('M00006','MAQUINA ESPECIAL PARA PROYECTO 30','MG','SFD','2006-12-01')
GO
-------------------A---------------

--a. Mostrar los empleados que hayan o estén haciendo uso de una maquina
--i. Campos a mostrar: Nombres del empleado, Marca, Modelo y Descripción de la maquina
SELECT A.Nombres, B.Marca, B.Modelo, B.Descripcion
FROM Bitacora 
RIGHT JOIN Empleado A
ON Bitacora.Id = A.Id
INNER JOIN Maquina B
ON Bitacora.Cod_Maquina = B.Cod_Maquinaria
GO

-----------------B---------------------
--b. Mostrar los empleados que todavía no tienen asignada una maquina
--i. Campos a mostrar: Nombres y Apellidos del empleado y Código de la maquina
SELECT A.Nombres, B.Marca, B.Modelo, B.Descripcion
FROM Bitacora 
INNER JOIN Empleado A
ON Bitacora.Id = A.Id
INNER JOIN Maquina B
ON Bitacora.Cod_Maquina = B.Cod_Maquinaria
GO
------------------C---------------------
--c. Mostrar las maquinas que no están asignadas a un proyecto
--i. Campos a mostrar: Nombres y Apellidos del empleado y Descripción de la maquina
SELECT e.Nombres,e.Apellidos,m.Descripcion 
FROM Empleado e
INNER JOIN Bitacora b
ON b.id = e.Id
RIGHT JOIN Maquina m
ON m.Cod_Maquinaria = b.Cod_Maquina
WHERE b.Cod_Maquina IS NULl

---------------------PARTE 2--------------------

-----------------------1----------------------------------
SELECT A.PrimerNombre, A.PrimerApellido, B.Titulo 
FROM AUTOR A
INNER JOIN DETALLE_AUTORLIBRO C
ON A.CodigoAutor = C.CodigoAutor
INNER JOIN Libro B
ON B.CodigoLibro = C.CodigoLibro
GO

-----------------------2---------------------------------
SELECT A.Nombre, B.Titulo 
FROM EDITORIAL A
INNER JOIN Libro B
ON A.CodigoEditorial = B.CodigoEditorial
GO
----------------------3---------------------------------
SELECT A.Nombre, B.Titulo 
FROM EDITORIAL A
INNER JOIN Libro B
ON A.CodigoEditorial = B.CodigoEditorial
WHERE A.Pais = 'Inglaterra'
GO
--------------------4-----------------------------------
--4. Mostrar los nombres de los autores y el título del libro donde el año de edición sea el más actual
SELECT A.PrimerNombre, B.Titulo 
FROM AUTOR A
INNER JOIN DETALLE_AUTORLIBRO C
ON C.CodigoAutor = A.CodigoAutor
INNER JOIN LIBRO B
ON C.CodigoLibro = B.CodigoLibro
WHERE B.Año < YEAR(GetDate())
GO


----------------------5---------------------------------
--5. Mostrar los nombres de los autores y el título del libro donde el año de edición sea el menos actual
SELECT a.PrimerNombre,a.PrimerApellido,l.Titulo FROM AUTOR a
INNER JOIN DETALLE_AUTORLIBRO da
ON a.CodigoAutor = da.CodigoAutor
INNER JOIN LIBRO l
ON l.CodigoLibro = da.CodigoLibro
WHERE l.Año < YEAR(GETDATE())

-----------------6------------------------------------------
INSERT INTO AUTOR VALUES ('KS009','Kevin','Sasso','01/10/1966','Salvadoreño',54)
INSERT INTO LIBRO VALUES ('STCOL00007','Bajo la misma Estrella','83243-8911988','2014','ED001')

-- AUTORES QUE NO HAN ESCRITO LIBRO AÚN
SELECT a.PrimerNombre,a.PrimerApellido
FROM AUTOR a
LEFT JOIN DETALLE_AUTORLIBRO da
ON a.CodigoAutor = da.CodigoAutor
WHERE da.CodigoAutor IS NULL

-- LIBROS QUE NO TIENEN UN AUTOR DEFINIDO----------------
SELECT l.Titulo 
FROM LIBRO l 
LEFT JOIN DETALLE_AUTORLIBRO  da 
ON l.CodigoLibro = da.CodigoLibro
WHERE da.CodigoLibro IS NULL

-- LIBROS QUE NO TIENEN UN AUTOR Y AUTOR QUE NO TIENE LIBRO----------------
SELECT a.PrimerNombre,a.PrimerApellido,l.Titulo FROM AUTOR a
FULL JOIN DETALLE_AUTORLIBRO da
ON a.CodigoAutor = da.CodigoAutor
FULL JOIN LIBRO l
ON l.CodigoLibro = da.CodigoLibro
WHERE da.CodigoLibro IS NULL AND da.CodigoAutor IS NULL