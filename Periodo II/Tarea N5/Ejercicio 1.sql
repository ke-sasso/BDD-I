CREATE DATABASE Control_BibliotecaDigital
GO
Use Control_BibliotecaDigital
GO


CREATE TABLE Categoria
(
IdCategoria char(4) NOT NULL PRIMARY KEY CHECK (IdCategoria LIKE 'CT[0-9][0-9]'),
Nombre varchar(50) NOT NULL,
Descripcion varchar (100) DEFAULT 'Sin descripcion'
)
GO
CREATE TABLE Libros
(
CodigoLibro char(4) NOT NULL PRIMARY KEY CHECK (CodigoLibro like 'TL[0-9][0-9]'),
Titulo varchar(100) NOT NULL,
Autor varchar(70) CHECK (Autor NOT LIKE '%[0-9]%') DEFAULT 'Anonimo',
Año_Edicion datetime CHECK (Año_Edicion > 1990),
ISBN char(10) UNIQUE CHECK (ISBN LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]'),
Precio decimal(18,2) CHECK (Precio > 5.00),
IdCategoria char(4),
CONSTRAINT FK_Categoria FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
ON DELETE CASCADE
ON UPDATE CASCADE
)

CREATE TABLE Usuarios
(
IdUsuario char(4) NOT NULL PRIMARY KEY CHECK (IdUsuario LIKE 'US[0-9][0-9]'),
Nombres varchar(70) CHECK (Nombres NOT LIKE '%[0-9]%'),
Apellidos varchar(70) CHECK (Apellidos NOT LIKE '%[0-9]%'),
Usuario varchar(50) NOT NULL,
Contraseña varchar(50) NOT NULL,
CorreoElectronico varchar(70),
Pais varchar(70) CHECK (Pais NOT LIKE '%[0-9]%')
)
GO

CREATE TABLE EjemplaresDigitales
(
CodigoEjemplar int NOT NULL PRIMARY KEY IDENTITY,
CodigoUsuario char(4),
CodigoLibro char(4),
Comentarios varchar(200),
Estado varchar(25),
CONSTRAINT FK_Usuario FOREIGN KEY (CodigoUsuario) REFERENCES Usuarios(IdUsuario),
CONSTRAINT FK_Libro FOREIGN KEY (CodigoLibro) REFERENCES Libros(CodigoLibro)
ON DELETE CASCADE
ON UPDATE CASCADE
)

INSERT INTO Categoria VALUES
('CT02','Aventura', NULL),
('CT03','Ciencia', NULL),
('CT04','Programacion','Nueva Categoria')
GO

INSERT INTO LIBROS VALUES
('TL01','Bajo la misma estrella', 'Fernando Gomez', '2007-01-12','12345678-1',10.00, 'CT02'),
('TL02','Principito', 'Fernando Hernandez', '1998-03-12','29845678-1',6.00, 'CT02'),
('TL03','JAVA', 'Guillermo Caldero', '2015-12-12','98023678-1',9.00, 'CT04')

INSERT INTO Usuarios VALUES
('US01', 'Kevin Edmundo', 'Sasso Torres', 'ke_Sasso', '1234', 'sasso@gmail.com', 'El Salvador'),
('US02', 'Miguel Angel', 'Sasso Torres', 'miguelito', '1d3f42', 'miguel@gmail.com', 'Costa Rica'),
('US03', 'Hector Fernando', 'Gomez Hernandez', 'fernandito', 'df234f2', 'gomez@gmail.com', 'El Salvador')
GO

INSERT INTO EjemplaresDigitales VALUES 
('US01','TL01', NULL, 'Activo'),
('US02','TL02', 'El mejor libro de todos', 'Activo'),
('US02','TL03', 'Excelente libro', 'Desactivo')

