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