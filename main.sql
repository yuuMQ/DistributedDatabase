-- Procedure ds Khach Hang Chua Mua Hang Muc 1
create proc dbo.ProcKHChuaMuaHangMuc1
as 
begin
	SELECT *
	FROM Northwind.dbo.Customers KH
	WHERE KH.CustomerID not in
	(
		SELECT DH.CustomerID
		from Northwind.dbo.Orders DH
	)
end
go

exec ProcKHChuaMuaHangMuc1
go

-- Procedure ds Khach Hang Chua Mua Hang Muc 2

create proc dbo.ProcKHChuaMuaHangMuc2
as
begin
	SELECT *
	FROM Northwind1.dbo.KH1 KH 
	WHERE KH.CustomerID not in (
		SELECT CustomerID
		FROM Northwind1.dbo.DH1
	)

	UNION

	SELECT *
	FROM Northwind1.dbo.KH2 KH 
	WHERE KH.CustomerID not in (
		SELECT CustomerID
		FROM Northwind1.dbo.DH2
	)
end
go

exec ProcKHChuaMuaHangMuc2
go


-- Cau 5
use Northwind
go

create proc dbo.ProcThemKHMuc1(
	@maKH nvarchar(5),
	@tenCT nvarchar(40),
	@tenTP nvarchar(15),
	@tenQG nvarchar(15)
)
as 
begin
	if exists(
		select CustomerID
		from Northwind.dbo.Customers
		where CustomerID = @maKH
	)
	print N'Lỗi trung mã khách hàng, không thêm khách hàng được'
	
	else
		begin
			insert into Northwind.dbo.Customers(CustomerID, CompanyName, City, Country)
			values (@maKH, @tenCT, @tenTP, @tenQG)
			print N'Đã thêm thành công 1 hàng vào bảng Customers.'
		end
end
go

exec Northwind.dbo.ProcThemKHMuc1 N'ABCD', N'Công ty ABCD', N'TP.HCM', N'Việt Nam'
go

select * from Northwind.dbo.Customers


use Northwind1
go

create proc ProcThemKHMuc2(
	@maKH nvarchar(5),
	@tenCT nvarchar(40),
	@tenTP nvarchar(15),
	@tenQG nvarchar(15)
)
as
begin
	if exists(
		select CustomerID
		from Northwind1.dbo.KH1
		where CustomerID = @maKH
	)
	print N'Lỗi trung mã khách hàng ở bảng KH1, không thêm khách hàng được'
	else if exists(
		select CustomerID
		from Northwind1.dbo.KH2
		where CustomerID = @maKH
	)
	print N'Lỗi trung mã khách hàng ở bảng KH1, không thêm khách hàng được'

	else if (@tenQG = N'USA' or @tenQG = N'UK')
		begin
			insert into Northwind1.dbo.KH1(CustomerID, CompanyName, City, Country)
			values (@maKH, @tenCT, @tenTP, @tenQG)
			print N'Đã thêm thành công 1 hàng vào bảng KH1.'
		end
	else
		begin
			insert into Northwind1.dbo.KH2(CustomerID, CompanyName, City, Country)
			values (@maKH, @tenCT, @tenTP, @tenQG)
			print N'Đã thêm thành công 1 hàng vào bảng KH2.'
		end
end
go


exec Northwind1.dbo.ProcThemKHMuc2 N'KH001', N'Công ty 001', N'HCMC', N'Vietnam'
go

exec Northwind1.dbo.ProcThemKHMuc2 N'KH002', N'Công ty 002', N'London', N'UK'
go

select *
from KH1

select *
from KH2


-- Cau 6
use Northwind
go
create proc ProcSuaKHMuc1(
	@maKH nvarchar(5),
	@tenTP nvarchar(15),
	@tenQG nvarchar(15)
)
as
begin
	if not exists (
		SELECT CustomerID
		FROM Customers
		WHERE CustomerID = @maKH
	)
	print N'Không tìm thấy khách hàng để sửa'
	else
		begin
			update Customers
				set City=@tenTP, Country=@tenQG
				where CustomerID=@maKH
			print N'Đã sửa thành công 1 hàng của bảng Customers'
		end
end

exec Northwind.dbo.ProcSuaKHMuc1 N'KH001', N'San Francisco', N'USA'
go

use Northwind1
go
create or alter proc ProcSuaKHMuc2(
	@maKH nvarchar(5),
	@tenTP nvarchar(15),
	@tenQG nvarchar(15)
)
as
begin
	if exists (
		SELECT CustomerID
		FROM KH1
		WHERE CustomerID = @maKH
	) 
		begin
			if(@tenQG = N'USA' or @tenQG = N'UK')
				begin
					update KH1
						set City=@tenTP, Country=@tenQG
						where CustomerID=@maKH
					print N'Đã sửa thành công 1 hàng của phân mảnh KH1.'
				end
			else
				begin
					update KH1
						set City=@tenTP, Country=@tenQG
						where CustomerID=@maKH
					
					insert into KH2
						select * from KH1 where CustomerID = @maKH
					delete from KH1 where CustomerID = @maKH

					insert into DH2
						select * from DH1 where CustomerID = @maKH
					delete from DH1 where CustomerID = @maKH
					print N'Đã sửa thành công 1 hàng ở phân mảnh KH1 và chuyển hàng này qua lưu ở phân mảnh KH2; Đã dời các đơn hàng của KH này đang lưu ở phân mảnh DH1 sang phân mảnh DH2'
				end
		end
	else if exists (
		SELECT CustomerID
		FROM KH2
		WHERE CustomerID = @maKH
	) 
		begin
			if(@tenQG <> N'USA' and @tenQG <> N'UK')
				begin
					update KH2
						set City=@tenTP, Country=@tenQG
						where CustomerID=@maKH
					print N'Đã sửa thành công 1 hàng của phân mảnh KH2.'
				end
			else
				begin
					update KH2
						set City=@tenTP, Country=@tenQG
						where CustomerID=@maKH

					insert into KH1
						select * from KH2 where CustomerID = @maKH
					delete from KH2 where CustomerID = @maKH

					insert into DH1
						select * from DH2 where CustomerID = @maKH
					delete from DH2 where CustomerID = @maKH
					print N'Đã sửa thành công 1 hàng ở phân mảnh KH2 và chuyển hàng này qua lưu ở phân mảnh KH1; Đã dời các đơn hàng của KH này đang lưu ở phân mảnh DH2 sang phân mảnh DH1'
				end
		end
		else
			print N'Không tim thấy mã khách hàng cần sửa!'
end
go

exec Northwind1.dbo.ProcSuaKHMuc2 N'KH001', N'HCMC', N'Việt nam'
go

exec Northwind1.dbo.ProcSuaKHMuc2 N'KH001', N'Viêng Chăng', N'Lào'
go

exec Northwind1.dbo.ProcSuaKHMuc2  N'KH001', N'Westminter', N'UK'
go

delete from Northwind1.dbo.KH1 where CustomerID='KH001'
delete from Northwind1.dbo.KH2 where CustomerID='KH001'

delete from Northwind1.dbo.KH1 where CustomerID='KH002'
delete from Northwind1.dbo.KH2 where CustomerID='KH002'


-- Cau 7
use Northwind
go

create proc ProXoaKHMuc1(
	@maKH nvarchar(5)
)
as
begin
	if not exists(
		SELECT CustomerID
		FROM Customers
		WHERE CustomerID = @maKH
	)
	print N'Không tìm thấy mã khách hàng để xóa'
	
	else
		begin
			delete from [Order Details] 
			where OrderID in (
				Select OrderID
				From Orders
				where CustomerID = @maKH
			)
			print N'Đã xóa thành công chi tiết đơn hàng của khách hàng bị xóa đã mua'
			delete from Orders where CustomerID = @maKH
			print N'Đã xóa thành công đơn hàng của khách hàng bị xóa đã mua'
			delete from Customers where CustomerID = @maKH
			print N'Đã xóa thành công một khách hàng ở bảng Customers.'
		end
end
go

exec Northwind.dbo.ProcThemKHMuc1 N'KH001', N'Công ty 001', N'TP.HCM', N'VietNam'
go

exec Northwind.dbo.ProXoaKHMuc1 N'KH001'
go


use Northwind1
go

create proc ProcXoaKHMuc2(
	@maKH nvarchar(5)
)
as
begin
	if exists(
		SELECT CustomerID
		FROM KH1
		WHERE CustomerID = @maKH
	)
		begin
			delete from DH1 where CustomerID = @maKH
			print N'Đã xóa thành công đơn hàng của khách hàng bị xóa đã mua'
			delete from KH1 where CustomerID = @maKH
			print N'Đã xóa thành công một khách hàng ở phân mảnh KH1'
		end
	else if exists(
		SELECT CustomerID
		FROM KH2
		WHERE CustomerID = @maKH
	)
		begin
			delete from DH2 where CustomerID = @maKH
			print N'Đã xóa thành công đơn hàng của khách hàng bị xóa đã mua'
			delete from KH2 where CustomerID = @maKH
			print N'Đã xóa thành công một khách hàng ở phân mảnh KH2'
		end
	else
		print N'Không tìm thấy khách hàng để xóa'
end
go

exec Northwind1.dbo.ProcThemKHMuc2 N'KH001', N'Công ty 001', N'TP.HCM', N'Việt nam'
go
exec Northwind1.dbo.ProcThemKHMuc2 N'KH002', N'Công ty 002', N'London', N'UK'
go

select * from Northwind1.dbo.KH1
select * from Northwind1.dbo.KH2

exec Northwind1.dbo.ProcXoaKHMuc2 N'KH000'
go
exec Northwind1.dbo.ProcXoaKHMuc2 N'KH001'
go
exec Northwind1.dbo.ProcXoaKHMuc2 N'KH002'
go


-- Cau 8
use Northwind
go
create function dbo.FuncSLDHMuc1(
	@tenQG nvarchar(15)
)
returns int
as 
begin
	declare @KQ int
	if @tenQG is NULL
		select @KQ = COUNT(OrderID)
		from Orders
	else
		select @KQ = COUNT(OrderID)
		from Orders, Customers
		where (Orders.CustomerID = Customers.CustomerID)
			and Customers.Country = @tenQG
	return @KQ
end
go

select Northwind.dbo.FuncSLDHMuc1 (NULL) as SoLuongDonHang
go
select Northwind.dbo.FuncSLDHMuc1 (N'USA') as SoLuongDonHang
go

use Northwind1
go

create function FuncSLDHMuc2 (
	@tenQG nvarchar(15)
)
returns int
as
begin
	declare @KQ int
	if @tenQG is null
		begin
			declare @KQ1 int, @KQ2 int
			select @KQ1 = COUNT(OrderID) from DH1
			select @KQ2 = COUNT(OrderID) from DH2
			set @KQ = @KQ1 + @KQ2
		end
	else if @tenQG = N'USA' or @tenQG = N'UK'
		SELECT @KQ = COUNT(OrderID)
		from KH1, DH1 
		where KH1.CustomerID = DH1.CustomerID 
		and KH1.Country = @tenQG
	else
		SELECT @KQ = COUNT(OrderID)
		from KH2, DH2
		where KH2.CustomerID = DH2.CustomerID 
		and KH2.Country = @tenQG
	return @KQ
end
go

select dbo.FuncSLDHMuc2 (NULL) as SLDonHang
print dbo.FuncSLDHMuc2 (NULL)


-- Cau 9
use Northwind
go

create function FuncDSDHMuc1(
	@tenQG nvarchar(15)
)
returns table
as
return
(
	select Orders.*
	from Orders, Customers
	where Orders.CustomerID = Customers.CustomerID
		and Customers.Country = @tenQG
)
go

select *
from dbo.FuncDSDHMuc1 (N'USA')
go


use Northwind1
go

create function FuncDSDHMuc2(
	@tenQG nvarchar(15)
)
returns @KQ TABLE
(
	[OrderID] [int] primary key,
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
	[ShipCountry] [nvarchar](15) NULL
)
as
begin
	if @tenQG is null
		begin
			insert into @KQ
				select * from DH1
			insert into @KQ
				select * from DH2
		end
	else if @tenQG = N'USA' or @tenQG = N'UK'
		insert into @KQ
			select DH1.*
			from DH1, KH1
			where DH1.CustomerID = KH1.CustomerID
				and KH1.Country = @tenQG
	else
		insert into @KQ
			select DH2.*
			from DH2, KH2
			where DH2.CustomerID = KH2.CustomerID
				and KH2.Country = @tenQG
	return
end
go

select * from dbo.FuncDSDHMuc2 (N'USA')
go

backup database Northwind1
to disk=N'D:\CSDLPT\Northwind1_sauTH_buoi4_baiTH5.bak'
with format

backup database Northwind
to disk=N'D:\CSDLPT\Northwind_sauTH_buoi4_baiTH5.bak'
with format