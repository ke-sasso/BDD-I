CREATE DATABASE ControlAlumnoST152230;
GO
USE ControlAlumnoST152230;
GO
CREATE TABLE Alumno(
Carnet char(8) NOT NULL PRIMARY KEY,
NombreCompleto varchar(50),
);
GO
CREATE TABLE Materia(
Codigo char(5) NOT NULL, 
Nombre varchar(30), 
UV int,
--Creando la llave primaria de la tabla
CONSTRAINT pk_materia PRIMARY KEY (Codigo),
--CREANDO LA RESTRICCION UNIQUE
CONSTRAINT u_nombre UNIQUE(Nombre),
--restriccion en las uv
CONSTRAINT ck_uv CHECK (UV >=2 AND UV<=5)
)
GO

CREATE TABLE Inscripcion(
Carnet char(8),
CodigoMateria Char(5),
Ciclo char(5)
--se esta creando una clave primaria compuesta
--en donde la union de los tres datos es un valor unico
CONSTRAINT pk_inscripcion PRIMARY KEY (Carnet, CodigoMateria, Ciclo)
)
GO


ALTER TABLE Inscripcion
ADD
--Creando la relacion entre la tabla inscripcion y la tabla alumno
CONSTRAINT fk_alumno_ins FOREIGN KEY (Carnet) REFERENCES Alumno(Carnet)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE Inscripcion
ADD
--Creando la relacion entre la tabla inscripcion y la tabla alumno
CONSTRAINT fk_materia_ins FOREIGN KEY (CodigoMateria) REFERENCES Materia(Codigo)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

--INSERT---------
INSERT INTO Alumno Values
('GH121214', 'Gerardo Hierro'),
('VN121415', 'Veronica Nuñez'),
('CD121515', 'Cesar Deras'),
('HL130334', 'Helen Lara'),
('GM119056', 'Gricelda Martinez')
GO

SELECT * FROM Alumno;
go

INSERT INTO Materia VALUES ('BD01', 'Base de datoos I', 4)
INSERT INTO Materia VALUES ('IP01', 'Introduccion a la programacion', 4)
INSERT INTO Materia VALUES ('AL01', 'Algebra Lineal', 3)
INSERT INTO Materia VALUES ('RD02', 'Redes de area amplia', 5)
INSERT INTO Materia VALUES ('GE01', 'Gestion Empresarial', 2)
INSERT INTO Materia VALUES ('HM02', 'Humanistica II', 3)
GO

INSERT INTO Inscripcion (Carnet, CodigoMateria, Ciclo) VALUES('GH121214', 'BD01', 'C1-15')
INSERT INTO Inscripcion (CodigoMateria, Carnet, Ciclo) VALUES('GE01', 'GH121214', 'C1-15')
INSERT INTO Inscripcion (Ciclo, Carnet, CodigoMateria) VALUES('C1-15', 'GH121214', 'HM02')
GO
SELECT * FROM Inscripcion;
GO
UPDATE Alumno SET NombreCompleto='Gerardo Hernandez' WHERE Carnet='GH121214';
GO
SELECT * FROM Alumno;
go

UPDATE Alumno SET Carnet='GH111214' WHERE NombreCompleto='Gerardo Hernandez';
GO

DELETE FROM Alumno WHERE Carnet='GH111214'
GO

---------------------------
USE ControlAlumnoST152230;
go
INSERT INTO Alumno VALUES
('MC129854', 'Mauricio Campos')
('IP110943', 'Ignacio Perez'),
('MU127895','Mikel Urrutia'),
('OH132390', 'Oscar Hernandez'),
('ML139032','Mayra Lopez')
GO

SELECT * FROM ALUMNO;
GO

INSERT INTO Inscripcion VALUES
('CD121515', 'AL01', 'C1-14'),
('CD121515', 'GE01', 'C1-14'),
('CD121515', 'HM02', 'C1-14'),
('GM119056', 'IP01', 'C2-14'),
('GM119056', 'RD02', 'C2-14'),
('HL130334', 'BD01', 'C1-15'),
('VN121415', 'BD01', 'C1-15'),
('VN121415', 'RD02', 'C1-15'),
('MC129854', 'AL01', 'C1-14'),
('MC129854', 'GE01', 'C1-14'),
('IP110943', 'GE01', 'C1-15'),
('IP110943', 'HM02', 'C1-15')
GO
-----------------------------------------------
SELECT * INTO MateriaUV
FROM Materia
WHERE UV >= 4;
GO
SELECT * FROM MateriaUV;
GO
----------------------------------------------
CREATE TABLE Alumno2012(
Carnet char(8) NOT NULL PRIMARY KEY,
NombreCompleto varchar(50),
);
GO
INSERT INTO Alumno2012 
SELECT Carnet, NombreCompleto FROM Alumno WHERE  Carnet LIKE '__12____';
GO
SELECT * FROM Alumno2012;
GO
-------------------------------------------------
UPDATE  Alumno SET NombreCompleto='Martinez' WHERE Carnet='GM119056';
GO
UPDATE Alumno SET Carnet='GM119156' WHERE NombreCompleto='Gricelda Martinez';
GO
UPDATE Inscripcion SET Ciclo='C1-15' WHERE Ciclo='C1-14';
GO
UPDATE Materia SET Codigo='HM02' WHERE Codigo='HM01';
GO
UPDATE Alumno SET NombreCompleto='Pereira' WHERE Carnet='IP110943';
GO
--------------------------------------------------
DELETE FROM Alumno	WHERE Carnet='GM119056';
GO
DELETE FROM Alumno WHERE  Carnet like 'M%';
GO
DELETE FROM Materia WHERE Nombre='Introduccion a la programacion';
GO
DELETE FROM Alumno WHERE NombreCompleto='Oscar Hernandez';
GO
DELETE FROM Inscripcion WHERE CodigoMateria='RD02' AND Ciclo='C1-15';
GO