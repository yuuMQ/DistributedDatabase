CREATE DATABASE Northwind1
go

---------Tao PM ngang cach 2 (chi gom 1 buoc: Vua tao thiet ke PM vua lay DL cho PM)

--Phai xoa 2 PM KH1, KH2 neu da co
------------------------------------------------------

--Tao KH1:
SELECT * INTO Northwind1.dbo.KH1
	FROM Northwind.dbo.Customers
	WHERE Country=N'USA' OR Country=N'UK'

--Test KH1:
SELECT * FROM Northwind1.dbo.KH1
------------------------------------------------------

--Tao KH2:
SELECT * INTO Northwind1.dbo.KH2
	FROM Northwind.dbo.Customers
	WHERE Country=N'USA' OR Country=N'UK'

--Test KH2:
SELECT * FROM Northwind1.dbo.KH2
	