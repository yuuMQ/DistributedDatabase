use master
go
create database Northwind1
go

CREATE TABLE Northwind1.dbo.KH1(
	[CustomerID] [nchar](5) NOT NULL,
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
go

CREATE TABLE Northwind1.dbo.KH2(
	[CustomerID] [nchar](5) NOT NULL,
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
go

INSERT INTO Northwind1.dbo.KH1
select * from Northwind.dbo.Customers KH
where (KH.Country = N'USA') OR (KH.Country = N'UK')
go

INSERT INTO Northwind1.dbo.KH2
select * from Northwind.dbo.Customers KH
where (KH.Country <> N'USA') AND (KH.Country <> N'UK')
go


create table Northwind1.dbo.DH1(
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
	[ShipCountry] [nvarchar](15) NULL,
)
go

create table Northwind1.dbo.DH2(
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
	[ShipCountry] [nvarchar](15) NULL,
)
go

INSERT INTO Northwind1.dbo.DH1
SELECT * FROM Northwind.dbo.Orders DH
WHERE DH.CustomerID IN (
	SELECT CustomerID 
	FROM Northwind1.dbo.KH1
)
go

select * FROM Northwind1.dbo.DH1
go

Insert into Northwind1.dbo.DH2
select * FROM Northwind.dbo.Orders DH
WHERE DH.CustomerID IN (
	SELECT CustomerID
	FROM Northwind1.dbo.KH2
)

select * FROM Northwind1.dbo.DH2
go


use Northwind1
go
create proc dbo.DSKHBietQGMUC1(
	@QG nvarchar(15)
)
as
begin
	select *
	FROM Northwind.dbo.Orders DH
	where DH.CustomerID IN 
	(
		SELECT CustomerID
		FROM Northwind.dbo.Customers
		WHERE Country = @QG
	)
end
go

exec dbo.DSKHBietQGMUC1 N'Canada'
go
exec dbo.DSKHBietQGMUC1 N'USA'
go

create proc dbo.DSDHBietQGMuc2(
	@QG nvarchar(15)
)
as
begin
	if (@QG = N'USA' or @QG = N'UK')
		SELECT * 
		FROM Northwind1.dbo.DH1 TB1
		WHERE TB1.CustomerID IN (
			SELECT TB2.CustomerID
			FROM Northwind1.dbo.KH1 TB2
			WHERE TB2.Country = @QG
		)
	else
		SELECT * 
		FROM Northwind1.dbo.DH2 TB1
		WHERE TB1.CustomerID IN (
			SELECT TB2.CustomerID
			FROM Northwind1.dbo.KH2 TB2
			WHERE TB2.Country = @QG
		)
end
go

exec DSDHBietQGMuc2 N'USA'
go
exec DSDHBietQGMuc2 N'Canada'
go

create table Northwind1.dbo.NV1(
	[EmployeeID] [int] Primary Key,
	[LastName] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
	--[Title] [nvarchar](30) NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL,
	--[BirthDate] [datetime] NULL,
	--[HireDate] [datetime] NULL,
	--[Address] [nvarchar](60) NULL,
	--[City] [nvarchar](15) NULL,
	--[Region] [nvarchar](15) NULL,
	--[PostalCode] [nvarchar](10) NULL,
	--[Country] [nvarchar](15) NULL,
	--[HomePhone] [nvarchar](24) NULL,
	--[Extension] [nvarchar](4) NULL,
	--[Photo] [image] NULL,
	--[Notes] [ntext] NULL,
	--[ReportsTo] [int] NULL,
	--[PhotoPath] [nvarchar](255) NULL,
)
go

create table Northwind1.dbo.NV2(
	[EmployeeID] [int] primary key,
	--[LastName] [nvarchar](20) NOT NULL,
	--[FirstName] [nvarchar](10) NOT NULL,
	[Title] [nvarchar](30) NULL,
	--[TitleOfCourtesy] [nvarchar](25) NULL,
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
	[PhotoPath] [nvarchar](255) NULL,
)
go

insert into Northwind1.dbo.NV1
	SELECT EmployeeID, LastName, FirstName, TitleOfCourtesy
	FROM Northwind.dbo.Employees
go

insert into Northwind1.dbo.NV2
	SELECT [EmployeeID]
			, [Title]
			, [BirthDate]
			, [HireDate]
			, [Address]
			, [City]
			, [Region]
			, [PostalCode]
			, [Country]
			, [HomePhone]
			, [Extension]
			, [Photo]
			, [Notes]
			, [ReportsTo]
			, [PhotoPath]
	FROM Northwind.dbo.Employees
go

select *
from Northwind1.dbo.NV1
go

select *
from Northwind1.dbo.NV2
go

select * from Northwind.dbo.Employees
go

select TB1.EmployeeID,
		LastName,
		FirstName,
		Title,
		TitleOfCourtesy,
		HireDate,
		[Address],
		City,
		Region,
		PostalCode,
		Country,
		HomePhone,
		Extension,
		Photo,
		Notes,
		ReportsTo,
		PhotoPath
from Northwind1.dbo.NV1 TB1, Northwind1.dbo.NV2 TB2
where TB1.EmployeeID = TB2.EmployeeID
go

use Northwind1
go

create view dbo.ViewThongKeSLKHTheoQGMuc1 
as 
	SELECT COUNT(KH.CustomerID) SoLuongKH, KH.Country
	FROM Northwind.dbo.Customers KH
	Group By KH.Country
go


use Northwind1
go

create view dbo.ViewThongKeSLKHTheoQGMuc2
as
	SELECT COUNT(KH.CustomerID) SoLuongKH, KH.Country
	FROM Northwind1.dbo.KH1 KH
	Group By KH.Country
	UNION
	SELECT COUNT(KH.CustomerID) SoLuongKH, KH.Country
	FROM Northwind1.dbo.KH2 KH
	Group By KH.Country
go

use Northwind1
go

create view dbo.ViewThongSLDHTheoQGMuc1
as
	SELECT COUNT(DH.OrderID) SoLuongDH, KH.Country
	FROM Northwind.dbo.Orders DH, Northwind.dbo.Customers KH
	WHERE DH.CustomerID = KH.CustomerID
	Group By KH.Country
go

use Northwind1
go

create view dbo.ViewThongSLDHTheoQGMuc2
as
	SELECT COUNT(DH.OrderID) SoLuongDH, KH.Country
	FROM Northwind1.dbo.DH1 DH, Northwind1.dbo.KH1 KH
	WHERE DH.CustomerID = KH.CustomerID
	Group By KH.Country

	UNION 

	SELECT COUNT(DH.OrderID) SoLuongDH, KH.Country
	FROM Northwind1.dbo.DH2 DH, Northwind1.dbo.KH2 KH
	WHERE DH.CustomerID = KH.CustomerID
	Group By KH.Country

go


use Northwind1
go

create proc dbo.ProcKHChuaMuaHangMuc1
as
begin
	SELECT *
	FROM Northwind.dbo.Customers KH
	where KH.CustomerID not in (
		SELECT CustomerID
		FROM Northwind.dbo.Orders
	)
end
go

create proc ProcKHChuaMuaHangMuc2
as
begin
	SELECT *
	FROM Northwind1.dbo.KH1 KH
	where KH.CustomerID not in (
		SELECT CustomerID
		FROM Northwind1.dbo.DH1
	)

	UNION

	SELECT *
	FROM Northwind1.dbo.KH2 KH
	where KH.CustomerID not in (
		SELECT CustomerID
		FROM Northwind1.dbo.DH2
	)

end
go
