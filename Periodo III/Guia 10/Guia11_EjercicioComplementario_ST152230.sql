--Crear la base de datos
CREATE DATABASE Control_Examen_ST152230
GO
--Hacer uso de la base de datos
USE Control_Examen_ST152230
GO

CREATE TABLE Alumno
(
Carnet VARCHAR(10) NOT NULL PRIMARY KEY,
Nombre VARCHAR(30) NOT NULL,
Apellido1 VARCHAR(30) NOT NULL,
Apellido2 VARCHAR(30) NOT NULL,
Sexo VARCHAR(2) NOT NULL,
)
GO

CREATE TABLE Examenes
(
cod_examen INT NOT NULL PRIMARY KEY,
titulo VARCHAR(100) NOT NULL,
n_preguntas INT NOT NULL,
)
GO

CREATE TABLE Notas
(
cod_examen INT NOT NULL FOREIGN KEY REFERENCES Examenes(cod_examen),
Carnet VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES Alumno(Carnet),
nota_examen DECIMAL(4,2) NOT NULL,
fecha SMALLDATETIME NOT NULL,
)
GO

CREATE TABLE Respuestas
(
cod_examen INT NOT NULL FOREIGN KEY REFERENCES Examenes(cod_examen),
Carnet VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES Alumno(Carnet),
n_pregunta INT NOT NULL,
opcion_respuesta INT NOT NULL,
)
GO

CREATE TABLE Preguntas
(
cod_examen INT NOT NULL FOREIGN KEY REFERENCES Examenes(cod_examen),
n_pregunta INT NOT NULL,
texto_pregunta VARCHAR(100) NOT NULL,
n_opciones INT NOT NULL,
opcion_correcta INT NOT NULL
)
GO

CREATE TABLE Opciones
(
cod_examen INT NOT NULL FOREIGN KEY REFERENCES Examenes(cod_examen),
n_pregunta INT NOT NULL,
n_opcion INT NOT NULL,
texto_opcion VARCHAR(50) NULL
)
GO
------------------------PROCEDIMIENTOS-------------------
CREATE PROCEDURE Insert_Alumno
@carnet CHAR(8), @nombre CHAR(15), @apell1 CHAR(15), @apell2 CHAR(15), @sexo CHAR(1)
AS
INSERT INTO Alumno VALUES (@carnet, @nombre, @apell1, @apell2, @sexo)
return(0)
GO

EXEC Insert_Alumno 'SB970326', 'Alicia', 'Salinas', 'Benitez', 'F'
EXEC Insert_Alumno 'SC970245', 'Pedro', 'Salazar', 'Calderon', 'M'
EXEC Insert_Alumno 'RC970201', 'Karla', 'Ramirez', 'Chicas', 'F'

CREATE PROC Insert_Exa
@cod INT,
@title VARCHAR(100),
@Npreg INT
AS
  INSERT Examenes VALUES (@cod, @title, @Npreg)
  Return(0)

--Agregando datos del examen
EXEC Insert_Exa 1,'Conceptos de procedimientos almacenados',2
EXEC Insert_Exa 2,'Conceptos sobre redes de area local',3
--Aregando datos a preguntas
INSERT INTO Preguntas VALUES 
(1,1,'Con que sentencia se crea un procedimiento almacenado:',3,3),
(1,2, 'Con que comando se ejecuta un procedimiento almacenado:',2,1)
--Agregando datos a opciones
INSERT INTO Opciones VALUES
(1,1,1,'Create procedure'),
(1,1,2,'Create Proc'),
(1,1,3,'Ambas opciones'),
(1,2,1, 'EXECUTE'),
(1,2,2,'sp_executesql')

USE master
GO
EXEC sp_addmessage 50001,16, N'Usted se encuentra en la ultima pregunta del examen'

USE Control_Examen_ST152230
GO

--Verificar si exits el procedimieno y si este existe se elimina
IF EXISTS (SELECT name FROM sysobjects WHERE name='Calculo_de_Nota' AND type='P')
DROP PROCEDURE Calculo_de_Nota
GO

--creacion del procedimiento
CREATE PROC Calculo_de_Nota
@carnetx VARCHAR(10), @codexamen INT
AS
BEGIN
DECLARE @totcorrecta INT, --contador para respuestas correctas
        @porcentaje FLOAT, --procentake de cada pregunta
		@npreguntas INT, --numero de preguntas del examen
		@correctaresp INT, --captura la opcion correcta del examen(opc_Corecta)
		@respuesta INT, --captura la opcion que selecciono el alumno (opcion respuesta)
		@perfect FLOAT, --CONTASTNTE =10
		@NOTA FLOAT --nota del examen
 
 SELECT @npreguntas = CONVERT(FLOAT,COUNT(n_pregunta)) FROM Preguntas
 WHERE cod_examen=@codexamen
 SELECT  @perfect = 10.00 --asignar un dato a una varibale
 SELECT @porcentaje=@perfect/@npreguntas --calculo de procentaje para c/pregunta
 SELECT @totcorrecta=0 --se inicializa un contador de repuestas correctas a 0
 WHILE(@npreguntas >0)
 BEGIN
  --Asginar la opcion correcta del examen
  SELECT  @correctaresp = opcion_correcta FROM Preguntas
WHERE (cod_examen = @codexamen and n_pregunta = @npreguntas)
  --ASIGNAR LA RESPUETA DEL ALUMNO DEL EXAMEN
  SELECT @respuesta = opcion_respuesta FROM  Respuestas
  WHERE (cod_examen = @codexamen and Carnet = @carnetx and n_pregunta = @npreguntas)

  --COMPARA LA OPCION CORRECTA DEL EXAMEN CON LA RESPUESTA DEL ALUMNO
  IF(@correctaresp = @respuesta)
  BEGIN
  --SI COINCIDEN LOS DATOS SE INCREMENTA UN CONTADOR, EL CUAL CONTROLA EL TOTAL DE RESPUESTAS
  --CORRECTA POR PARTES DEL ALUMNO
  SELECT @totcorrecta = @totcorrecta + 1
  END --FIN DEL IF
  SELECT @npreguntas=@npreguntas-1 --se decrementa el total de pregunas
END --FIN DEL WHILE

--CALCULA LA NOTA DEL EXAMEN
SELECT @NOTA = @totcorrecta * @porcentaje
--AGREGA LA NOTA A LA TABL NOTAS
INSERT INTO Notas VALUES (@codexamen, @carnetx, @NOTA, GETDATE())

END--FIN DEL CUERPO DEL PROCEDIMIENTO

--PARA VER LA NOTA EN LA VENTA A DE RESULTADOS
SELECT "NOTA_EXAMEN"=CONVERT(float, @NOTA)

--VERIFICAMOS SI EXISTE EL TRIGGER Y SI ESTE EXISTE SE ELIMINA
IF EXISTS (SELECT name FROM sysobjects WHERE name='Warning' AND type='TR')
 DROP TRIGGER Warning
 GO

 --creacion del trigger
 CREATE TRIGGER Warning
 ON Respuestas
 FOR INSERT --indica que se dispara al insertar datos en la tabla respuestas
AS
  DECLARE @tot_preguntas INT,
          @Npregunta INT,
		  @codExa INT,
		  @Nota FLOAT,
		  @carnetx VARCHAR(10)

SELECT @codExa = cod_examen FROM inserted --la tabla inserted almacena copia de las filas
--afectadas durante llas intrucciones INSERT Y U`PDATE

SELECT @tot_preguntas = n_preguntas FROM Examenes WHERE cod_examen = @codExa
--ASIGNA A LA VARIABLE @Npregunra la pregunta del examen que se esta contestando
SELECT @Npregunta = n_pregunta FROM inserted
--evalua el numero de la pregunra con el total que tiene el examen

SELECT @carnetx = carnet FROM inserted

IF(SELECT COUNT(*) FROM NOTAS WHERE cod_examen =@codExa   and  carnet=@carnetx)=0
BEGIN 
		IF @Npregunta = @tot_preguntas
		BEGIN
		  --COLOCAR EL NUMERO DE MENSAJE DE ERROR QUE CREO EN EL PUNTO 13
		  RAISERROR (50001, 16, 1)
		  SELECT @carnetx = carnet FROM inserted
		  --NOTAR QUE UN TRIGGER PUEDE LLAMAR A UN STRORE PROCEDURE
		  EXEC Calculo_de_Nota @carnetx, @codExa

		  --ALMACENA EN LA VARIABLE @NOTA La nota del alumno con respecto al examen que a contestado
		  SELECT @Nota = nota_examen FROM Notas WHERE cod_examen=@codExa
		  AND Carnet=@carnetx
		  PRINT 'Su nota fue: ' + convert(varchar(4), @Nota)
		END --FIN DE IF
END
ELSE
BEGIN
PRINT 'ESTE ALUMNO YA REALIZO LA PRUEBA'
ROLLBACK TRANSACTION
END
GO

--realizando pruebas 
--a la pregunta 1 contestp la opcion 3, es la correcta
INSERT INTO Respuestas VALUES (1,'RC970201',1,3)
--A LA PREGUNTA 2 CONTESTO LA OPCION 2 CONTESTO MAL
INSERT INTO Respuestas VALUES (1,'RC970201',2,2)

select * from Respuestas
select * from Notas









