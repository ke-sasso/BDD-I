--El comando BACKUP LOG le da muchas opciones para crear 
--copias de seguridad de registro de transacciones. A continuaci�n se presentan diferentes ejemplos.


--Crear una copia de seguridad y darle una descripci�n
--Este comando utiliza la opci�n Descripci�n para dar la copia de seguridad de un nombre. 
--Esta tarde se puede utilizar con algunos de los comandos restore para ver lo que est� contenido 
--en la copia de seguridad. El tama�o m�ximo es de 255 caracteres.
BACKUP LOG AdventureWorks 
TO DISK = 'C:\AdventureWorks.TRN'
WITH DESCRIPTION = 'Log backup for AdventureWorks'
GO