USE library
GO
BACKUP DATABASE library
TO DISK = 'C:\Backups_ST152230\Library.bak'
WITH FORMAT

drop database library
RESTORE DATABASE Library
FROM DISK = 'C:\BACKUPS_ST152230\Library.bak'
GO