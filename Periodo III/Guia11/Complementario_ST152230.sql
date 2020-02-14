
use AdventureWorks2012
GO
-----crear login---
CREATE LOGIN KevinSasso
WITH PASSWORD = '123456'
go
---------2-----------
CREATE USER Sasso FOR LOGIN KevinSasso 
WITH DEFAULT_SCHEMA = Person
GO

--------3-----------
GRANT SELECT
ON SCHEMA :: Person
TO Sasso
WITH GRANT OPTION
GO
-------4-----------
GRANT INSERT ON OBJECT :: Person.ContactType
TO Sasso
GO
INSERT INTO Person.ContactType VALUES ('A',GETDATE());


GRANT UPDATE ON OBJECT :: Person.ContactType
TO Sasso
GO


GRANT INSERT ON OBJECT :: Person.CountryRegion
TO Sasso
GO

GRANT UPDATE ON OBJECT :: Person.CountryRegion
TO Sasso
GO

---------------5---------------------------
GRANT CREATE TABLE 
TO Sasso
GO

GRANT CREATE VIEW
TO Sasso
GO

-------------6-----------------------------
CREATE LOGIN EdmundoTorres
WITH PASSWORD = '123456'
go

------------7--------------------------
CREATE USER Edmundo FOR LOGIN EdmundoTorres 
WITH DEFAULT_SCHEMA = Sales
GO


-----------8-------------------------

GRANT SELECT
ON SCHEMA :: Sales
TO Edmundo
WITH GRANT OPTION
GO

-----------------9------------------
GRANT DELETE ON OBJECT :: Sales.ContactType
TO Edmundo
GO

GRANT UPDATE ON OBJECT :: Sales.ContactType
TO Edmundo
GO


GRANT DELETE ON OBJECT :: Sales.Currency
TO Edmundo
GO

GRANT UPDATE ON OBJECT :: Sales.Currency
TO Edmundo
GO

GRANT DELETE ON OBJECT :: Sales.CurrencyRate
TO Edmundo
GO

GRANT UPDATE ON OBJECT :: Sales.CurrencyRate
TO Edmundo
GO

GRANT DELETE ON OBJECT :: Sales.PersonCreditCard
TO Edmundo
GO
GRANT update ON OBJECT :: Sales.PersonCreditCard
TO Edmundo
GO

---------------10--------------------

GRANT CREATE TABLE 
TO Sasso
GO
