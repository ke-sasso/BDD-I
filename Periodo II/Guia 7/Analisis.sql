
CREATE DATABASE Control_de_libros
USE Control_de_libros
GO


CREATE TABLE AUTOR
(CodigoAutor char(5) NOT NULL,
PrimerNombre varchar (30) NOT NULL,
PrimerApellido varchar(30) NOT NULL,
FechaNacimiento date NOT NULL,
Nacionalidad varchar(50) NOT NULL,
Edad char(2) NOT NULL
CONSTRAINT PK_AUTOR PRIMARY KEY (CodigoAutor),
CONSTRAINT CK_CodigoA CHECK(CodigoAutor like '[a-zA-Z][a-zA-Z][0-9][0-9][0-9]'),
CONSTRAINT CK_Edad CHECK(Edad like '[0-9][0-9]')
)

 

CREATE TABLE EDITORIAL
(CodigoEditorial char(5) NOT NULL,
Nombre varchar (30) NOT NULL,
Pais varchar(30) NOT NULL
CONSTRAINT PK_EDITORIAL PRIMARY KEY (CodigoEditorial),
CONSTRAINT CK_CodigoE CHECK(CodigoEditorial like 'ED[0-9][0-9][0-9]')
)

CREATE TABLE LIBRO
(CodigoLibro char(10) NOT NULL,
Titulo varchar (140) NOT NULL,
ISBN varchar(30) NOT NULL,
Año char(4) NOT NULL,
CodigoEditorial char(5)
CONSTRAINT PK_LIBRO PRIMARY KEY (CodigoLibro),
CONSTRAINT CK_CodigoL CHECK(CodigoLibro like '[a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z][a-zA-Z][0-9][0-9][0-9][0-9][0-9]'),
CONSTRAINT FK_Libro_Editorial FOREIGN KEY (CodigoEditorial) REFERENCES EDITORIAL(CodigoEditorial)
ON DELETE CASCADE
ON UPDATE CASCADE
)


CREATE TABLE DETALLE_AUTORLIBRO
(CodigoLibro char(10) NOT NULL,
CodigoAutor char(5) NOT NULL
CONSTRAINT FK_Autor_2 FOREIGN KEY (CodigoAutor) REFERENCES AUTOR(CodigoAutor),
CONSTRAINT FK_Libro_2 FOREIGN KEY (CodigoLibro) REFERENCES LIBRO(CodigoLibro)
ON DELETE CASCADE
ON UPDATE CASCADE
)

INSERT INTO AUTOR VALUES
('PL001','Pablo','López','19/08/1960','Colombiana',54),
('CM002','Claudia','Martínez','10/06/1970','Salvadoreña',45),
('PM003','Patricio','Murry','12/12/1967','Española',47),
('NH004','Nuria','Hernández','03/09/1980','Colombiana',34),
('HM005','Helen','Martínez','22/11/1980','Española',34),
('JR006','José','Roldán','13/09/1967','Colombiana',54)

INSERT INTO EDITORIAL VALUES
('ED001','Omega 2000','Colombia'),
('ED002','Anaya Multimedia','España'),
('ED003','McGrawHill','Inglaterra'),
('ED004','Reyes','México'),
('ED005','Pretice Hall','Inglaterra')

INSERT INTO LIBRO VALUES 
('BDCOL00001','Fundamentos de Base de datos','12333-8999988','2004','ED001'),
('BDESP00002','La Biblia de SQLServer 2008','3444-99888-88','2008','ED002'),
('PRCOL00002','Programación orientada a objetos','8999-9999444','2011','ED001'),
('DWING00003','Diseño Web y Hojas de estilo','300096-99999','2010','ED003'),
('PRING00004','Programación en C/C++','45667-87878','2009','ED005'),
('HJMEX00005','Uso de hojas de estilo con JavaScript','0990-87878787 ','2008','ED004'),
('ABESP00006','Administración de Base de datos','585885-88484848','2010','ED002')

INSERT INTO DETALLE_AUTORLIBRO VALUES ('BDCOL00001','PL001') 
INSERT INTO DETALLE_AUTORLIBRO VALUES('BDCOL00001','NH004')
INSERT INTO DETALLE_AUTORLIBRO VALUES ('PRCOL00002','CM002')
INSERT INTO DETALLE_AUTORLIBRO VALUES ('BDESP00002','PM003')
INSERT INTO DETALLE_AUTORLIBRO VALUES ('DWING00003','PM003')
INSERT INTO DETALLE_AUTORLIBRO VALUES ('PRING00004','HM005')
INSERT INTO DETALLE_AUTORLIBRO VALUES ('ABESP00006','CM002')
INSERT INTO DETALLE_AUTORLIBRO VALUES('HJMEX00005','NH004')
INSERT INTO DETALLE_AUTORLIBRO VALUES('DWING00003','JR006')

---------------------------------------------------------------------------------------

--a--
--a. Mostrar cuantos autores hay por cada nacionalidad
SELECT Nacionalidad, COUNT(CodigoAutor) AS [Autores por Nacionalidad]
FROM AUTOR
GROUP BY Nacionalidad
--b----
--b. Calcular cuántos libros hay por cada editorial
SELECT CodigoEditorial, COUNT(CodigoLibro) AS [Libros por Editorial]
FROM LIBRO
GROUP BY CodigoEditorial
GO
--c--
--c. Mostrar la cantidad de editoriales que hay por cada país
SELECT Pais, COUNT(CodigoEditorial) AS [Editorial por País]
FROM EDITORIAL
GROUP BY Pais
GO
--d---
--d. Mostrar el libro donde el año de edición sea el más actual
SELECT Titulo, Año
FROM LIBRO
WHERE Año = (SELECT MAX(Año) FROM LIBRO)
GO
--E--
--e. Mostrar el libro donde el año de edición sea el menos actual
SELECT Titulo, Año
FROM LIBRO
WHERE Año = (SELECT MIN(Año) FROM LIBRO)
GO

--- F ---
--f. Calcular el promedio de las edades de los autore
SELECT AVG(Edad) AS PROMEDIO FROM AUTOR

--- G ---
--g. Mostrar cuántos libros ha escrito cada autor
SELECT CodigoAutor,COUNT(*) AS TOTAL FROM DETALLE_AUTORLIBRO
GROUP BY CodigoAutor
--- H ---
--h. Mostrar cuantos autores nacieron en el mismo mes
SELECT MONTH(FechaNacimiento) AS MES,COUNT(*) AS TOTAL FROM AUTOR
GROUP BY MONTH(FechaNacimiento)

--- I ---

SELECT CONCAT(PrimerNombre,' ',PrimerApellido) AS [Nombre Completo] FROM AUTOR

--- J ---
SELECT COUNT(*) AS [Total de libros con la palabra] FROM LIBRO
WHERE Titulo LIKE '%PROGRAMACIÓN%'
--k------
SELECT PrimerNombre, SUBSTRING(PrimerNombre,1,1) AS INICIAL FROM AUTOR
ORDER BY PrimerNombre DESC
--l-----
--l. Mostrar los autores que nacieron antes del año 1980
SELECT * FROM AUTOR 
WHERE YEAR(FECHANACIMIENTO) < 1980
--m---
SELECT CODIGOAUTOR, COUNT(*) AS CANTIDAD_LIBROS FROM Detalle_AutorLibro
GROUP BY CODIGOAUTOR
--n--
--n. Mostrar cuantos autores comienzan con la inicial P en su primer apellido
SELECT COUNT(*) AS CANTIDAD_DE_APELLIDOS_CON_P FROM AUTOR
WHERE PrimerApellido like 'P%'
--o--
--o. Mostrar cuantos libros finalizan con la palabra Base de datos en su título
SELECT COUNT(*) AS CANTIDAD_DE_LIBROS FROM LIBRO
WHERE Titulo like '% Base de datos'


---------------------------------------------------------






