CREATE DATABASE Northwind1
go

---------Tao PM ngang cach 1 (gom 2 buoc: Tao thiet ke PM va lay DL cho PM)
--Tao thiet ke PM KH1
CREATE TABLE Northwind1.[dbo].[KH1]
(
	[CustomerID] [nchar](5) PRIMARY KEY,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL
	)
	
	--Lay DL cho KH1:
	INSERT INTO Northwind1.dbo.KH1
		SELECT * FROM Northwind.dbo.Customers
		WHERE Country=N'USA' OR Country=N'UK'
	
	--Test KH1:
		SELECT * FROM Northwind1.dbo.KH1	
	
	
	--Tao thiet ke cho PM KH2:
	CREATE TABLE Northwind1.[dbo].[KH2]
(
	[CustomerID] [nchar](5) PRIMARY KEY,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL
	)
	--Lay DL cho KH2:
	INSERT INTO Northwind1.dbo.KH2
		SELECT * FROM Northwind.dbo.Customers
		WHERE Country<>N'USA' AND Country<>N'UK'
	--Test KH2:
		SELECT * FROM Northwind1.dbo.KH2