-- Tao CSDL Northwind1:
USE Master
go
CREATE DATABASE Northwind1
go				
-- Cach Tao Phan Manh KH1, KH2 co Khoa chinh
-- Neu da tao hay xoa KH1 va KH2

USE Northwind1
go
CREATE TABLE [Northwind1].[dbo].[KH1](
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
	[Fax] [nvarchar](24) NULL)
	
CREATE TABLE [Northwind1].[dbo].[KH2](
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
	[Fax] [nvarchar](24) NULL)

--Lay du lieu co 2 phan manh KH1 va KH2

INSERT INTO Northwind1.dbo.KH1
	SELECT * FROM Northwind.dbo.Customers
	WHERE Country='USA' OR Country='UK'
	
INSERT INTO Northwind1.dbo.KH2
	SELECT * FROM Northwind.dbo.Customers
	WHERE Country<>'USA' AND Country<>'UK'


-- Cach Tao Phan Manh DH1, DH2 co Khoa chinh, va khong co identyti cot khoa chinh
-- Neu da tao hay xoa DH1 va DH2
CREATE TABLE [Northwind1].[dbo].[DH1](
	[OrderID] [int] PRIMARY KEY,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipVia] [int] NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL)	
CREATE TABLE [Northwind1].[dbo].[DH2](
	[OrderID] [int] PRIMARY KEY,
	[CustomerID] [nchar](5) NULL,
	[EmployeeID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipVia] [int] NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL)
-- Lay du lieu cho phan manh DH1, DH2	
INSERT INTO Northwind1.dbo.DH1 
	SELECT *
	FROM  Northwind.dbo.Orders DH
	WHERE DH.CustomerID IN 
			(SELECT CustomerID FROM Northwind.dbo.Customers
				WHERE Country = N'USA' OR Country = N'UK')	
INSERT INTO Northwind1.dbo.DH2 
	SELECT *
	FROM  Northwind.dbo.Orders DH
	WHERE DH.CustomerID IN 
			(SELECT CustomerID FROM Northwind.dbo.Customers
				WHERE Country <> N'USA' AND Country <> N'UK')
				
				
				
				

-- Cach Tao Phan Manh NV1, NV2 co Khoa chinh, va khong co identyti cot khoa chinh
-- Neu da tao hay xoa NV1 va NV2
CREATE TABLE [Northwind1].[dbo].[NV1](
	[EmployeeID] [int] PRIMARY KEY,
	[LastName] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL)
CREATE TABLE [Northwind1].[dbo].[NV2](
	[EmployeeID] [int] PRIMARY KEY,
	[Title] [nvarchar](30) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](24) NULL,
	[Extension] [nvarchar](4) NULL,
	[Photo] [image] NULL,
	[Notes] [ntext] NULL,
	[ReportsTo] [int] NULL,
	[PhotoPath] [nvarchar](255) NULL)

-- Lay du lieu cho phan manh NV1, NV2	
INSERT INTO Northwind1.dbo.NV1 ([EmployeeID],[LastName],[FirstName],[TitleOfCourtesy]) 
	SELECT [EmployeeID],[LastName],[FirstName],[TitleOfCourtesy]
	FROM  Northwind.dbo.Employees
	
INSERT INTO Northwind1.dbo.NV2 (
	   [EmployeeID]
      ,[Title]
      ,[BirthDate]
      ,[HireDate]
      ,[Address]
      ,[City]
      ,[Region]
      ,[PostalCode]
      ,[Country]
      ,[HomePhone]
      ,[Extension]
      ,[Photo]
      ,[Notes]
      ,[ReportsTo]
      ,[PhotoPath]) 
	SELECT [EmployeeID]
      ,[Title]
      ,[BirthDate]
      ,[HireDate]
      ,[Address]
      ,[City]
      ,[Region]
      ,[PostalCode]
      ,[Country]
      ,[HomePhone]
      ,[Extension]
      ,[Photo]
      ,[Notes]
      ,[ReportsTo]
      ,[PhotoPath]
	FROM  Northwind.dbo.Employees

