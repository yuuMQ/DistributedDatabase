
-- Lớp QTHCSDL - Thầy Khải
--File sql để rename servername từ 'D16' thành 'TênMáyTính'

--Xem tên servername trước khi đổi tên

use master
go
Select name as TênServerNameCũ from sys.servers
go
--Xóa tên servername cũ 'D16'
sp_dropserver 'D16'
go
-- Thêm lại tên servername mới đúng với tên máy tính
sp_addserver 'C41', 'local'
go
--Xem tên servername sau khi đổi tên
select name as TênServerNameMới from sys.servers
go
Select N'Hãy restart SQL Server là đổi tên servername xong' AS ThôngBáo
go
