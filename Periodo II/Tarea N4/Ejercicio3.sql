CREATE DATABASE Control_Biblioteca
ON
(	NAME = Control_Biblioteca_dat,
	FILENAME = 'C:\Tarea4\Control_Biblioteca.mdf',
	SIZE =10,
	MAXSIZE=50,
	FILEGROWTH=5
)
LOG ON
(	NAME = Control_Biblioteca_log,
	FILENAME = 'C:\Tarea4\Control_Biblioteca.ldf',
	SIZE =5,
	MAXSIZE=25,
	FILEGROWTH=2
)
GO
USE Control_Biblioteca
GO

----------------------------------------
CREATE TABLE Editorial
(
Codigo char(5) NOT NULL PRIMARY KEY,
Nombre varchar(50),
Pais varchar(10)
)
ALTER TABLE Editorial
ADD CONSTRAINT CK_CodigoEditorial
CHECK (Codigo like 'ED[0-9][0-9][0-9]')
GO
---------------------------------------
CREATE TABLE Libro
(
Codigo char(6) PRIMARY KEY NOT NULL,
Titulo varchar(50) NOT NULL,
ISBN varchar(20) UNIQUE NOT NULL,
Descripcion varchar(50) NOT NULL,
Resumen varchar(50),
Año_edicion date NOT NULL,
CodigoEditorial char(5)
)
GO
ALTER TABLE Libro
ADD
CONSTRAINT fk_libro FOREIGN KEY (CodigoEditorial) REFERENCES Editorial(Codigo)
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE Libro
ADD CONSTRAINT CK_CodigoLibro
CHECK (Codigo like 'LB[0-9][0-9][0-9][0-9]')
GO

ALTER TABLE Libro
ADD CONSTRAINT CK_anoedicion
CHECK (year(Año_edicion) > 1980)
GO
---------------------------------------
CREATE TABLE Ejemplar
(
Codigo char(6) PRIMARY KEY NOT NULL,
CodigoLibro char(6),
Ubicacion varchar(50) NOT NULL,
Estado varchar(50) NOT NULL
)
GO

ALTER TABLE Ejemplar
ADD
CONSTRAINT fk_ejemplarlibro FOREIGN KEY (Codigolibro) REFERENCES Libro(Codigo)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE Ejemplar
ADD CONSTRAINT CK_CodigoEjemplar
CHECK (Codigo like 'EJ[0-9][0-9][0-9][0-9]')
GO

ALTER TABLE Ejemplar
ADD CONSTRAINT CK_estadooo
CHECK ( Estado in ('Disponible','Prestado','Reservado'))
GO
----------------------------------------
CREATE TABLE Prestamo
(
CodigoEjemplar char(6) NOT NULL,
Fecha_Prestamo date NOT NULL,
Fecha_Devolucion date NOT NULL,
Mora decimal (18,2) NOT NULL
)


ALTER TABLE Prestamo
ADD
CONSTRAINT fk_prestamo FOREIGN KEY (CodigoEjemplar) REFERENCES Ejemplar(Codigo)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE Prestamo
ADD CONSTRAINT CK_fechasprestamo
CHECK (fecha_Prestamo < Fecha_Devolucion)
GO

ALTER TABLE Prestamo
ADD CONSTRAINT CK_moraprestamo
CHECK (mora >= 0)
GO
----------------------------------------
CREATE TABLE Autor
(
Codigo char(6) NOT NULL PRIMARY KEY,
Nombres varchar(30) NOT NULL,
Apellidos varchar(50) NOT NULL,
Nacionalidad varchar(50) NOT NULL
)
ALTER TABLE Autor
ADD CONSTRAINT CK_CodigoAutor
CHECK (Codigo like 'AU[0-9][0-9][0-9][0-9]')
GO
----------------------------------------
CREATE TABLE Autor_libro
(
CodigoLibro char(6),
CodigoAutor  char(6)
)

ALTER TABLE Autor_Libro
ADD
CONSTRAINT fk_autorlibro1 FOREIGN KEY (CodigoLibro) REFERENCES Libro(Codigo)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE Autor_Libro
ADD
CONSTRAINT fk_autorlibro2 FOREIGN KEY (CodigoAutor) REFERENCES Autor(Codigo)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

INSERT INTO Editorial VALUES('ED001','Santillana', 'España');
INSERT INTO Editorial VALUES ('ED002','Hoja verde', 'Colombia');
INSERT INTO Editorial VALUES('ED003','Enteros', 'España');
INSERT INTO Editorial VALUES('ED004','Letras nuevas', 'El Salvador');
INSERT INTO Editorial VALUES('ED005','LeerS', 'España');
INSERT INTO Editorial VALUES('ED006','Lo mejor de leer', 'España');
INSERT INTO Editorial VALUES('ED007','Letras sin vida', 'EE.UU');
INSERT INTO Editorial VALUES('ED008','Mejores escritores', 'Colombia');
INSERT INTO Editorial VALUES('ED009','Poetas sin amor', 'Honduras');
INSERT INTO Editorial VALUES('ED010','Letras inspiradoras', 'Costa Rica');
GO


INSERT INTO Libro VALUES('LB0001', 'Bajo','23432-3' ,'Amor', 'Mejores', '2010-01-10','ED010');
INSERT INTO Libro VALUES('LB0002','Hojas','3454-45','Comedia','Mejores libros del mundo','2001-02-04','ED003');
INSERT INTO Libro VALUES('LB0003', 'Quijote','435432-3' ,'Literatura', 'Mejores', '2010-01-10','ED001');
INSERT INTO Libro VALUES('LB0004', 'Polpovu','264532-3' ,'Programacion', 'Mejores', '2015-01-10','ED001');
INSERT INTO Libro VALUES('LB0005', 'JAVA','343432-3' ,'Programacion', 'Mejores', '2013-01-10','ED004');
INSERT INTO Libro VALUES('LB0006', 'PHP 9.0','5332-3' ,'Programacion', 'Mejores', '2003-01-10','ED005');
INSERT INTO Libro VALUES('LB0007', 'C# NUEVO','233432-3' ,'Programacion', 'Mejores', '2012-01-10','ED006');
INSERT INTO Libro VALUES('LB0008', 'AQUI MISMO','22223432-3' ,'Programacion', 'Mejores', '2000-01-10','ED007');
INSERT INTO Libro VALUES('LB0009', 'Soccer','67432-3' ,'Amor', 'Ficcion', '2009-01-10','ED008');
INSERT INTO Libro VALUES('LB0010', 'Ingles','3462-3' ,'Amor', 'Ficcion', '2008-01-10','ED009');
GO

INSERT INTO Ejemplar VALUES('EJ0001','LB0001','Modulo #2','Disponible');
INSERT INTO Ejemplar VALUES('EJ0002','LB0002','Modulo #1','Disponible');
INSERT INTO Ejemplar VALUES('EJ0003','LB0003','Modulo #3','Reservado');
INSERT INTO Ejemplar VALUES('EJ0004','LB0004','Modulo #5','Prestado');
INSERT INTO Ejemplar VALUES('EJ0005','LB0004','Modulo #10','Prestado');
INSERT INTO Ejemplar  VALUES('EJ0006','LB0006','Modulo #2','Reservado');
INSERT INTO Ejemplar VALUES('EJ0007','LB0007','Modulo #7','Prestado');
INSERT INTO Ejemplar VALUES('EJ0008','LB0008','Modulo #3','Reservado');
INSERT INTO Ejemplar VALUES('EJ0009','LB0009','Modulo #1','Reservado');
INSERT INTO Ejemplar VALUES('EJ0010','LB0010','Modulo #9','Prestado');
GO


INSERT INTO Prestamo VALUES('EJ0001','2010-01-3','2010-01-26',10.0);
INSERT INTO Prestamo VALUES('EJ0002','2012-02-3','2015-06-23',10.0);
INSERT INTO Prestamo VALUES('EJ0003','2014-03-3','2015-05-22',30.0);
INSERT INTO Prestamo VALUES('EJ0004','2011-01-3','2015-07-2',1.0);
INSERT INTO Prestamo VALUES('EJ0005','2013-06-3','2013-08-6',1.0);
INSERT INTO Prestamo VALUES('EJ0010','2012-03-3','2012-06-3',5.0);
INSERT INTO Prestamo VALUES('EJ0003','2015-01-3','2015-03-2',7.0);
INSERT INTO Prestamo VALUES('EJ0004','2015-07-3','2015-08-3',9.0);
INSERT INTO Prestamo VALUES('EJ0005','2015-04-3','2015-08-1',1.0);
INSERT INTO Prestamo VALUES('EJ0010','2015-04-3','2015-08-1',1.0);
GO


INSERT INTO Autor VALUES ('AU0001','Kevin Edmundo', 'Sasso Torres', 'España')
INSERT INTO Autor VALUES ('AU0002','Miguel Angel', 'Perez Torres', 'El Salvador')
INSERT INTO Autor VALUES ('AU0003','Jose Antonio', 'Montano Ramos', 'Honduras')
INSERT INTO Autor VALUES ('AU0004','Henry Emerson', 'Lopez Hernandez', 'EE.UU')
INSERT INTO Autor VALUES ('AU0005','Rafael QUezada', 'Cortez Cadenas', 'Colombia')
INSERT INTO Autor VALUES ('AU0006','Hector Fernando', 'Padilla Contreras', 'España')
INSERT INTO Autor VALUES ('AU0007','Brian Alejandro', 'Romero Romero', 'Venezuela')
INSERT INTO Autor VALUES ('AU0008','Jose Cristian', 'Alvarado Menjivar', 'España')
INSERT INTO Autor VALUES ('AU0009','Walter David', 'Tores Torres', 'Panama')
INSERT INTO Autor VALUES ('AU0010','Arenivar Arenivar', 'Sanchez Deras', 'España')


INSERT INTO Autor_libro VALUES ('LB0001','AU0001')
INSERT INTO Autor_libro VALUES ('LB0003','AU0004')
INSERT INTO Autor_libro VALUES ('LB0002','AU0007')
INSERT INTO Autor_libro VALUES ('LB0003','AU0007')
INSERT INTO Autor_libro VALUES ('LB0002','AU0003')
INSERT INTO Autor_libro VALUES ('LB0007','AU0002')
INSERT INTO Autor_libro VALUES ('LB0008','AU0002')
INSERT INTO Autor_libro VALUES ('LB0002','AU0009')
INSERT INTO Autor_libro VALUES ('LB0004','AU0007')
INSERT INTO Autor_libro VALUES ('LB0009','AU0006')