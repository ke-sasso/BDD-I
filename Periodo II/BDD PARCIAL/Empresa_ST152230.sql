DR


CREATE DATABASE Empresa_ST152230
ON
(
NAME=Empresa_ST152230_dat,
FILENAME='C:\bd\Empresa_ST152230dat.mdf',
SIZE=5,
MAXSIZE=20,
FILEGROWTH=5 )
LOG ON
(
NAME=Empresa_ST152230_log,
FILENAME='C:\bd\Empresa_ST152230log.ldf',
SIZE=2,
MAXSIZE=10,
FILEGROWTH=2 );
GO

Use Empresa_ST152230
GO

CREATE TABLE Proyecto
(
CodigoProyecto char(4) NOT NULL PRIMARY KEY CHECK (CodigoProyecto like 'PR[0-9]'),
Nombre varchar(50) NOT NULL UNIQUE,
FechaInicio date NOT NULL,
FechaFinal date NOT NULL, 
Presupuesto decimal(18,2) NOT NULL CHECK(Presupuesto > 1500), 
CONSTRAINT ck_fecha CHECK (FechaFinal >FechaInicio)
)
GO
CREATE TABLE Empleado
(
CodigoEmpleado char(4) NOT NULL PRIMARY KEY CHECK (CodigoEmpleado like 'EM[0-9][0-9]'),
Nombre varchar(50) NOT NULL CHECK (Nombre NOT LIKE '%[0-9]%'),
Apellido varchar(50) NOT NULL CHECK (Apellido NOT LIKE '%[0-9]%'),
Dui char(9) NOT NULL CHECK (Dui like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]'),
Salario decimal(18,2) NOT NULL CHECK(Salario > 0),
Cargo varchar(50) NOT NULL CHECK (Cargo NOT LIKE '%[0-9]%')
)
GO

CREATE TABLE Departamento
(
CodigoDepartamento char(4) NOT NULL PRIMARY KEY CHECK (CodigoDepartamento LIKE 'DP[0-9]'),
Nombre varchar (50) NOT NULL UNIQUE,
)
GO

CREATE TABLE DetalleDepartamento
(
Id int NOT NULL PRIMARY KEY IDENTITY,
CodigoDepartamento char(4) NOT NULL,
CodigoEmpleado char(4)  NOT NULL,
CodigoProyecto char(4),
CONSTRAINT FK_Departamento FOREIGN KEY (CodigoDepartamento) REFERENCES Departamento(CodigoDepartamento),
CONSTRAINT FK_Empleado FOREIGN KEY (CodigoEmpleado) REFERENCES Empleado(CodigoEmpleado),
CONSTRAINT FK_Proyecto FOREIGN KEY (CodigoProyecto) REFERENCES Proyecto(CodigoProyecto)
ON DELETE CASCADE
ON UPDATE CASCADE
)



INSERT INTO Empleado values
('EM01','Jorge', 'Perez', '1234567-1', 1500, 'Coordinador'),
('EM02','Marìa', 'Morales', '7648975-9', 850, 'Desarrollador'),
('EM03','Julieta', 'Vargas','3452190-8', 550, 'Secretaria'),
('EM04','Juan', 'Pineda', '5634980-1', 1700, 'Coordinador'),
('EM05','Karla', 'Perez', '4539087-5', 890, 'Coontador'),
('EM06','Mario', 'Rodriquez', '6723109-4', 750, 'Auxiliar Contable'),
('EM07','Felipe', 'Torres', '4567908-6', 950, 'Contador'),
('EM08','Claudia', 'Montoya', '1235678-1', 550, 'Secretaria'),
('EM09','Vannessa', 'Linares', '2309116-0', 1000, 'Coordinador'),
('EM10','Camila', 'Fuentes', '9873450-6', 550, 'Secretaria'),
('EM11','Roberto', 'Martinez', '2956678-6', 1200, 'Director'),
('EM12','Teresa', 'Saravia', '3748876-4', 550, 'Secretaria'),
('EM13','Luis', 'Aguilar', '6572345-7', 1000, 'Coordinador')
GO

INSERT INTO Proyecto Values
('PR1', 'Llevar control de ventas de las empresa', '2014-11-12','2015-05-05', 13679),
('PR2', 'Llevar control de los suministro', '2014-03-03','2015-04-12', 5900),
('PR3', 'Controlar las cuentas empresas', '2014-01-01','2015-02-12', 3800)
go

INSERT INTO Departamento VALUES
('DP1', 'Informatica'),
('DP2','Financiero'),
('DP3', 'Recursos Humanos'),
('DP4', 'Administrador'),
('DP5', 'Marketing')
GO


INSERT INTO DetalleDepartamento VALUES
('DP1','EM01','PR1'),
('DP1','EM02','PR1'),
('DP1','EM03',NULL),
('DP2','EM04','PR2'),
('DP2','EM05','PR3'),
('DP2','EM06','PR3'),
('DP2','EM07','PR1'),
('DP2','EM08',NULL),
('DP3','EM09',NULL),
('DP3','EM10',NULL),
('DP4','EM11','PR3'),
('DP4','EM12',NULL),
('DP5','EM13','PR1')
GO

------------A--------------
SELECT Apellido FROM Empleado
WHERE Apellido LIKE 'P%'
GO
------------B--------------
SELECT CodigoDepartamento, COUNT(CodigoEmpleado)
FROM DetalleDepartamento
GROUP BY CodigoDepartamento
ORDER BY CodigoDepartamento
GO
-----------C---------------
SELECT CodigoProyecto
FROM Proyecto
WHERE FechaInicio BETWEEN '2014-01-01' AND '2015-02-12'
GO

------------D--------------
SELECT A.CodigoDepartamento, B.CodigoProyecto, SUM(B.Presupuesto)
FROM DetalleDepartamento A
INNER JOIN Proyecto B
ON A.CodigoProyecto = B.CodigoProyecto
GROUP BY A.CodigoDepartamento
GO


-----------E----------------
SELECT A.Nombre, A.Apellido, B.Nombre AS DEPARTAMENTO
FROM Empleado A
INNER JOIN DetalleDepartamento C
ON A.CodigoEmpleado = C.CodigoEmpleado
INNER JOIN Departamento B
ON B.CodigoDepartamento = C.CodigoDepartamento
GO
----------F----------------
SELECT  B.Presupuesto, CONCAT(A.Nombre, ' ', A.Apellido) AS [NOMBRE DEL EMPLEADO]
FROM Empleado A
INNER JOIN DetalleDepartamento C
ON C.CodigoEmpleado = A.CodigoEmpleado
INNER JOIN Proyecto B
ON C.CodigoProyecto = B.CodigoProyecto
WHERE B.Presupuesto > (SELECT AVG(Presupuesto) FROM Proyecto)
GO

SELECT AVG(Presupuesto) FROM Proyecto
GO
-------------g-------------------
SELECT CodigoEmpleado, CodigoProyecto 
FROM DetalleDepartamento
WHERE NOT (CodigoProyecto IS NULL)
GO

---------h----------------------
SELECT CodigoEmpleado
FROM DetalleDepartamento
WHERE CodigoProyecto is NULL
GO


------------CONSULTAS UPDATE----------------
UPDATE Empleado SET Nombre='Kevin', Apellido ='Sasso' WHERE CodigoEmpleado='EM01'
GO
UPDATE Proyecto SET  Presupuesto=10000 WHERE CodigoProyecto='PR3'
GO
UPDATE Departamento SET Nombre='Programadores' WHERE CodigoDepartamento='DP1'
GO
------------CONSULTAS DELETE----------------
DELETE FROM DetalleDepartamento WHERE CodigoEmpleado='EM10'
GO
DELETE FROM Empleado WHERE Dui = '1234567-1'
GO
DELETE FROM Departamento WHERE CodigoDepartamento = 'DP5'
GO