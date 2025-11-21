
--Bài giải câu 4, bài thực hành 4

-- tạo CSDL để demo
use Master
go
CREATE DATABASE CSDL_2
go

-- chuyển dbowwner cho login khác
use CSDL_2
GO
sp_changedbowner '513\Admin'

-- chuyển dbowwner cho login khác
use CSDL_2
GO
sp_changedbowner 'sa'

-- xem thông tin 1 CSDL
USE Master
GO
EXEC sp_helpdb CSDL_2
go
-- xem thông tin 1 CSDL
USE Master
GO
EXEC sp_helpdb AdventureWorks

-- xem thông tin tất cả CSDL
USE Master
GO
EXEC sp_helpdb

--Tạo mới Schema
USE CSDL_2
GO
CREATE SCHEMA TenSchema
go

--Tạo bảng mới trong schema
USE CSDL_2
GO
CREATE TABLE TenSchema.BangNhanVien
(MaNV int IDENTITY(1,1) Primary key
,HoNV varchar(75) NOT NULL
,TenNV varchar(75) NOT NULL)

--xóa schema
USE CSDL_2
GO
DROP SCHEMA TenSchema

--đổi 1 bảng sang schema khác
USE CSDL_2
GO
ALTER SCHEMA dbo TRANSFER TenSchema.BangNhanVien

--xóa bảng
DROP TABLE dbo.BangNhanVien
go

-- xóa CSDL_2, có ngắt kết nối trước khi xóa
use [master];
go
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'CSDL_2'
GO
use [master];
go
ALTER DATABASE CSDL_2 SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
DROP DATABASE CSDL_2
GO
