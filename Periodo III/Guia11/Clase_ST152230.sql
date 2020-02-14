CREATE DATABASE AlumnosST152230
GO

USE AlumnosST152230
GO

--Creaci�n de los esquemas

CREATE SCHEMA alumnoC
GO

CREATE SCHEMA nota
GO

--Creaci�n de la base de datos

CREATE TABLE alumno.alumnos(
carnet INT PRIMARY KEY,
nombres VARCHAR(25),
apellidos VARCHAR(25)
)
GO

--Creaci�n de la tabla notas en el esquema nota

CREATE TABLE nota.notas(
idnotas INT IDENTITY,
carnet INT FOREIGN KEY REFERENCES alumno.alumnos(carnet)
ON UPDATE CASCADE
ON DELETE CASCADE,
nota1 DECIMAL(10,2),
nota2 DECIMAL(10,2),
nota3 DECIMAL(10,2),
promedio as (nota1+nota2+nota3)/3
)
GO

--Agregando datos a la base de datos
INSERT INTO alumno.alumnos VALUES(111, 'Juan Jos�', 'P�rez')
INSERT INTO alumno.alumnos VALUES(222, 'Maria Luisa', 'Flores')
INSERT INTO alumno.alumnos VALUES(333, 'Carlos Francisco', 'Gavidia')
INSERT INTO alumno.alumnos VALUES(444, 'Claudia Evelyn', 'Rivas')

INSERT INTO nota.notas VALUES(111, 7.6, 10, 5.5)
INSERT INTO nota.notas VALUES(222, 8.5, 9, 10)
INSERT INTO nota.notas VALUES(333, 9.3, 8.5, 5.7)

--Seleccionando los datos

SELECT * FROM alumno.alumnos
GO

SELECT * FROM nota.notas
GO

--Creando el login

CREATE LOGIN GH152207_2 WITH PASSWORD = '12345'
GO

select * from nota.notas

--Creando un nuevo usuario

CREATE USER Gomez FOR LOGIN GH152207_2
WITH DEFAULT_SCHEMA = nota
GO

--Asignando el permiso sobre el esquema
GRANT SELECT
ON SCHEMA :: nota
TO Gomez
WITH GRANT OPTION
GO

--Creaci�n de nuevas tablas
CREATE TABLE materias(
id INT,
nombre VARCHAR(50)
)
GO

INSERT INTO materias VALUES(101, 'F�sica')
INSERT INTO materias VALUES(102, 'Programaci�n')
INSERT INTO materias VALUES(103, 'Dise�o web')
INSERT INTO materias VALUES(104, '�lgebra')

--Esto es con el nuevo usuario creado

--Exitoso, ya que se le asignaron permisos de selecci�n
SELECT * FROM dbo.materias
GO

--Exitoso, ya que se le asignaron permisos de actualizaci�n
UPDATE dbo.materias SET nombre = 'F�sica t�cnica' WHERE id = 101
GO

--Denegado, ya que no se le asignaron permisos de inserci�n de datos
INSERT INTO dbo.materias VALUES (105, 'SQL Server')
GO

--Se puede crear tablas ya que se le asigno permisos de creaci�n de tablas

CREATE TABLE Prueba
(column1 INT NOT NULL,
column2 CHAR(10) NOT NULL)
GO

--No se pudo crear porqu� no tiene permisos de creaci�n de vistas

CREATE VIEW Reporte
AS
	SELECT carnet, nombres, apellidos FROM alumno.alumnos
GO

--Asignando permisos de creaci�n de vistas

GRANT CREATE VIEW
TO Fernando
GO

--Se creo la vista 'Reporte' correctamente

--Eliminando login

DROP LOGIN GH152207_2

--Eliminando usuarios

DROP USER Gomez
