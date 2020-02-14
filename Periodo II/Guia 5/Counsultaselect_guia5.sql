use NORTHWND
go

select * from Categories
go

select CategoryName, CategoryID from Categories
go

-------------------------------------------------

select OrderID, ProductID, UnitPrice from [Order Details]
where OrderID=10251
go

---------------------------------------------------

select CompanyName from Customers 
where CompanyName='Alfreds Futterkiste'
go

---------------------------------------------------

select OrderID, ProductID, UnitPrice from [Order Details]
where OrderID=10251 and ProductID=57
go

------------------------------------------------------

select OrderID, ProductID, UnitPrice from [Order Details]
where OrderID=10251 or ProductID=57
go

-------------------------------------------------------

select OrderID, ProductID, UnitPrice from [Order Details]
where OrderID>=11000
go

----------------------------------------------------------


select OrderID, ProductID, UnitPrice from [Order Details]
where OrderID>=11000 and OrderID<=11003
go

-----------------------------------------------------------

select OrderID, ProductID, UnitPrice from [Order Details]
where OrderID between 11000 and 11003
go

-----------------------------------------------------------

select companyName from Customers
where companyName like 'A%'
go

-----------------------------------------------------------

select CompanyName from Customers
where CompanyName like '%MA'
go

-----------------------------------------------------------

select regionDescription from Region
where regionDescription like '%TERN%'
go

------------------------------------------------------------

select OrderID from [Order Details]
where OrderID like '_0285'
go

------------------------------------------------------------

select CompanyName from Customers
where CompanyName like '[a-c]%'
go

------------------------------------------------------------

select * from [Order Details]
where OrderID in (10248,10255,10270)
go

------------------------------------------------------------

select * from [Order Details]
where OrderID=10248 or OrderID=10255 or orderID=10270
go

------------------------------------------------------------

select categoryName, categoryID from Categories
order by CategoryName desc
go

select categoryName, categoryID from Categories
order by CategoryName 
go

--------------------------------------------------------------

select SupplierID, CategoryID from Products
go

select distinct SupplierID, CategoryID from Products
go

----------------------------------------------------------------

select top 3 OrderID, (unitprice*quantity) as [Ventas Total] from [Order Details]
order by [Ventas Total] desc
go

select top 3 with ties OrderID, (unitprice*quantity) as [Ventas Total] from [Order Details]
order by [Ventas Total] desc
go

select top 25 percent OrderID, (unitprice*quantity) as [Ventas Total]
from [Order Details]
order by [Ventas Total] desc
go

---------------------------------------------------------------------

