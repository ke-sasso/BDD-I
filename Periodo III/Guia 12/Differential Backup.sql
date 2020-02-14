--Differential Backup
--Definici�n
--Hace copia de seguridad de una base de datos completa de SQL Server para crear una copia de seguridad
--de la base de datos, o uno o m�s archivos o grupos de archivos de la base de datos para crear una copia 
--de seguridad de archivo (BACKUP DATABASE). Adem�s, con el modelo de recuperaci�n completa o con el modelo 
--de recuperaci�n optimizado para cargas masivas de registros, realiza la copia de seguridad del registro 
--de transacciones de la base de datos para crear una copia de seguridad de registros (BACKUP LOG).

--Ejmplo de Realizar una copia de seguridad de la base de datos y el registro

USE master;
GO
ALTER DATABASE AdventureWorks2012
   SET RECOVERY FULL;
GO
 
USE master
GO
EXEC sp_addumpdevice 'disk', 'AdvWorksData', 
'Z:\SQLServerBackups\AdvWorksData.bak';
GO
EXEC sp_addumpdevice 'disk', 'AdvWorksLog', 
'X:\SQLServerBackups\AdvWorksLog.bak';
GO

-- Back up the full AdventureWorks2012 database.
BACKUP DATABASE AdventureWorks2012 TO AdvWorksData;
GO
-- Back up the AdventureWorks2012 log.
BACKUP LOG AdventureWorks2012
   TO AdvWorksLog;
GO