----------------------ĐỀ THI MÁY CHẲN-----------
--MÔN: CSDLPT
--MSSV:
--HỌ TÊN SV: PMQ

-----------------------------------------------------------------------

--PHẦN 1: Phân mảnh ngang chính và phân mảnh ngang dẫn xuất (4 điểm)

--Câu 1: (2 điểm) Hãy viết 2 Stored procedure tên: 
--(SV TỰ ĐẶT TÊN CHO CÁC PHÂN MẢNH NGANG)
use QLNhanVien
go
-- Tạo PROC TaoPM_Ngang_PhongBan:
create proc TaoPM_Ngang_PhongBan
as
begin
	select * into PhongBanCT
	from PhongBan where PhongBan.ChiNhanh = N'Cần Thơ'

	select * into PhongBanDN
	from PhongBan where PhongBan.ChiNhanh = N'Đà Nẵng'
end
go
-- Test PROC TaoPM_Ngang_PhongBan:
exec TaoPM_Ngang_PhongBan
go

-- Tạo PROC TaoPM_Ngang_NhanVien:
create proc TaoPM_Ngang_NhanVien
as
begin
	select NhanVien.* into NhanVienCT
	from PhongBan, NhanVien 
	where NhanVien.MaPB = PhongBan.MaPB 
		and PhongBan.ChiNhanh = N'Cần Thơ'

	select NhanVien.* into NhanVienDN
	from PhongBan, NhanVien 
	where NhanVien.MaPB = PhongBan.MaPB 
		and PhongBan.ChiNhanh = N'Đà Nẵng'
end
go

-- Test PROC TaoPM_Ngang_NhanVien:
exec TaoPM_Ngang_NhanVien
go

--Câu 2: (2 điểm) Tạo stored procedure tên SuaPB_Ngang:

-- Tạo PROC SuaPB_Ngang:
create proc SuaPB_Nang_Muc1(
	@MaPB nvarchar(10),
	@TenPB nvarchar(50),
	@ChiNhanh nvarchar(50)
)
as
begin
	if @MaPB is null
		print N'Không thể sửa dữ liệu vì thiếu mã PB'
	else if @TenPB is null
		print N'Không thể sửa dữ liệu vì thiếu tên PB'
	else if @ChiNhanh is null
		print N'Không thể sửa dữ liệu vì thiếu chi nhánh'
	else if not exists (
		select *
		from PhongBan
		where MaPB = @MaPB
	)
		print N'Không thể sửa dữ liệu vì không tìm thấy mã PB'
	else if @ChiNhanh not in (N'Cần Thơ', 'Đà Nẵng')
		print N'Không thể sửa dữ liệu vì chi nhánh không hợp lệ'
	else
		begin
			update PhongBan
			set TenPB = @TenPB, ChiNhanh = @ChiNhanh
			where MaPB = @MaPB
		end
end
go

-- Muc 2
create or alter proc SuaPB_Nang(
	@MaPB nvarchar(10),
	@TenPB nvarchar(50),
	@ChiNhanh nvarchar(50)
)
as
begin
	if @MaPB is null
		print N'Không thể sửa dữ liệu vì thiếu mã PB'
	else if @TenPB is null
		print N'Không thể sửa dữ liệu vì thiếu tên PB'
	else if @ChiNhanh is null
		print N'Không thể sửa dữ liệu vì thiếu chi nhánh'
	else if @ChiNhanh not in (N'Cần Thơ', N'Đà Nẵng')
		print N'Không thể sửa dữ liệu vì chi nhánh không hợp lệ'
	else if not exists (
		select *
		from PhongBanCT
		where MaPB = @MaPB

		UNION 

		select *
		from PhongBanDN
		where MaPB = @MaPB
	)
		print N'Không thể sửa dữ liệu vì không tìm thấy mã PB'
	else if exists (
		select *
		from PhongBanCT where MaPB = @MaPB
	)
		begin
			update PhongBanCT
			set TenPB = @TenPB, ChiNhanh = @ChiNhanh
			where MaPB = @MaPB
			
			if @ChiNhanh = N'Đà Nẵng'
			begin
				insert into PhongBanDN
				select * from PhongBanCT
				where MaPB = @MaPB
				delete from PhongBanCT where MaPB = @MaPB

				insert into NhanVienDN
				select * from NhanVienCT
				where MaPB = @MaPB
				delete from NhanVienCT where MaPB = @MaPB
				print N'Sửa dữ liệu thành công. Đã di dời dữ liệu có chi nhánh Đà Nẵng từ phòng ban Cần Thơ sang phòng ban Đà Nẵng. Đã di dời thành công nhân viên có mã phòng ban tương ứng từ chi nhánh Cần Thơ sang Đà Nẵng'
			end
			else
				print N'Sửa dữ liệu trên phòng ban Cần Thơ thành công'
		end
	else if exists (
		select *
		from PhongBanDN where MaPB = @MaPB
	)
		begin
			update PhongBanDN
			set TenPB = @TenPB, ChiNhanh = @ChiNhanh
			where MaPB = @MaPB

			if @ChiNhanh = N'Cần Thơ'
			begin
				insert into PhongBanCT
				select * from PhongBanDN
				where MaPB = @MaPB
				delete from PhongBanDN where MaPB = @MaPB

				insert into NhanVienCT
				select * from NhanVienDN
				where MaPB = @MaPB
				delete from NhanVienDN where MaPB = @MaPB
				print N'Sửa dữ liệu thành công. Đã di dời dữ liệu có chi nhánh Cần Thơ từ phòng ban Đà Nẵng sang phòng ban Cần Thơ. Đã di dời thành công nhân viên có mã phòng ban tương ứng từ chi nhánh Đà Nẵng sang Cần Thơ'
			end
			else
				print N'Sửa dữ liệu thành công.'
		end
end
go

-- Test PROC SuaPB_Ngang:
exec SuaPB_Nang N'PB06', N'Quảng cáo', N'Cần Thơ'
go
exec SuaPB_Nang N'PB06', N'Quảng cáo', Null
go
exec SuaPB_Nang N'PB06', N'Quảng cáo', N'Sài gòn'
go
exec SuaPB_Nang N'PB06', N'Quảng cáo', N'Đà Nẵng'
go
exec SuaPB_Nang N'PB010', N'Quảng cáo', N'Cần Thơ'
go
exec SuaPB_Nang N'PB03', N'Quảng cáo', N'Cần Thơ'
go
exec SuaPB_Nang N'PB06', N'Quảng cáo', N'Đà Nẵng'
go






------------------------------------------------------------------

--PHẦN 2: Phân mảnh dọc (4 điểm)

--Câu 3: (1 điểm) Hãy viết Stored procedure tên: TaoPM_Doc_PhongBan:
--PhongBan_Doc1(MaPB, TenPB)
--PhongBan_Doc2(MaPB, ChiNhanh)

-- Tạo PROC TaoPM_Doc_PhongBan:
create proc TaoPM_Doc_PhongBan
as
begin
	select MaPB, TenPB into PhongBan_Doc_1
	from PhongBan

	select MaPB, ChiNhanh into PhongBan_Doc_2
	from PhongBan
end
go


-- Test PROC TaoPM_Doc_PhongBan:
exec TaoPM_Doc_PhongBan
go

--Câu 4: (1 điểm) Hãy viết Stored procedure tên: XemPB_Doc:

-- Tạo PROC XemPB_Doc:
create proc XemPB_Doc
as
begin
	select PhongBan_Doc_1.*, PhongBan_Doc_2.ChiNhanh
	from PhongBan_Doc_1, PhongBan_Doc_2
	where PhongBan_Doc_1.MaPB = PhongBan_Doc_2.MaPB
	and PhongBan_Doc_1.TenPB in (N'Tiếp Thị', N'Sản xuất')
end
go
-- Test PROC XemPB_Doc:
exec XemPB_Doc
go
--Câu 5: (2 điểm) Tạo stored procedure tên SuaPB_Doc:

-- Tạo PROC SuaPB_Doc:
create or alter proc SuaPB_Doc (
	@MaPB nvarchar(10),
	@TenPB nvarchar(50),
	@ChiNhanh nvarchar(50)
)
as
begin
	if @MaPB is null
		print N'Không thể sửa dữ liệu vì thiếu giá trị mã PB'
	else if @TenPB is null
		print N'Không thể sửa dữ liệu vì thiếu giá trị tên PB'
	else if @ChiNhanh is null
		print N'Không thể sửa dữ liệu vì thiếu giá trị chi nhánh'
	else if not exists(
		select *
		from PhongBan_Doc_1
		where MaPB = @MaPB
	)
		print N'Không thể sửa dữ liệu vì không tìm thấy mã PB'
	else if @ChiNhanh not in (N'Cần Thơ', N'Đà Nẵng')
		print N'Không thể sửa dữ liệu vì chi nhánh không hợp lệ'
	else if exists (
		select *
		from PhongBan_Doc_1
		where MaPB = @MaPB
	)
		begin
			update PhongBan_Doc_1
			set TenPB = @TenPB
			where MaPB = @MaPB
			print N'Sửa dữ liệu trên PB dọc 1 thành công'
		
			update PhongBan_Doc_2
			set ChiNhanh = @ChiNhanh
			where MaPB = @MaPB
			print N'Sửa dữ liệu trên PB dọc 2 thành công'
		end
end
go

-- Test PROC SuaPB_Doc:
exec SuaPB_Doc Null, N'Cung Cấp', N'Cần Thơ'
go
exec SuaPB_Doc N'PB01', N'Cung Cấp', N'Cần Thơ'
go
exec SuaPB_Doc N'PB10', N'Cung Cấp', N'Cần Thơ'
go
exec SuaPB_Doc N'PB05', N'Phát Triển', N'Sài Gòn'
go
exec SuaPB_Doc N'PB04', N'IT', N'Đà Nẵng'
go


go

---------------------------------------------------


--PHẦN 3: Phân mảnh HỖN HỢP (2 điểm)

--Câu 6: (1 điểm) Tạo View tên DanhSachTatCaPB_HH:

-- Tạo View DanhSachTatCaPB_HH:
create view DanhSachTatCaPB_HH
as
	-- Can Tho
	select PhongBan_HH1.*, PhongBan_HH2.ChiNhanh
	from PhongBan_HH1, PhongBan_HH2
	where PhongBan_HH1.MaPB = PhongBan_HH2.MaPB
	UNION
	-- Da Nang
	select PhongBan_HH3.*, PhongBan_HH4.ChiNhanh
	from PhongBan_HH3, PhongBan_HH4
	where PhongBan_HH3.MaPB = PhongBan_HH4.MaPB
go
-- Test View DanhSachTatCaPB_HH:
select * from DanhSachTatCaPB_HH
go
--Câu 7: (1 điểm) Tạo stored procedure tên SuaPB_HH:

-- Tạo PROC SuaPB_HH:
create or alter proc SuaPB_HH(
	@MaPB nvarchar(10),
	@TenPB nvarchar(50),
	@ChiNhanh nvarchar(50)
)
as
begin
	if @MaPB is null
		print N'Không thể sửa dữ liệu vì thiếu giá trị mã PB'
	else if @TenPB is null
		print N'Không thể sửa dữ liệu vì thiếu giá trị tên PB'
	else if @ChiNhanh is null
		print N'Không thể sửa dữ liệu vì thiếu giá trị chi nhánh'
	else if not exists(
		select *
		from PhongBan_HH1
		where MaPB = @MaPB

		UNION

		select *
		from PhongBan_HH3
		where MaPB = @MaPB
	)
		print N'Không thể sửa dữ liệu vì không tìm thấy mã PB'

	else if @ChiNhanh not in (N'Cần Thơ', N'Đà Nẵng')
		print N'Không thể sửa dữ liệu vì chi nhánh không hợp lệ'
	
	else if exists(
		select *
		from PhongBan_HH1
		where MaPB = @MaPB
	)
		begin
			update PhongBan_HH1
			set TenPB = @TenPB
			where MaPB = @MaPB

			update PhongBan_HH2
			set ChiNhanh = @ChiNhanh
			where MaPB = @MaPB

			if @ChiNhanh = N'Đà Nẵng'
				begin
					insert into PhongBan_HH3
					select * from PhongBan_HH1 where MaPB = @MaPB
					delete from PhongBan_HH1 where MaPB = @MaPB
					
					insert into PhongBan_HH4
					select * from PhongBan_HH2 where MaPB = @MaPB
					delete from PhongBan_HH2 where MaPB = @MaPB

					print N'Đã sửa thành công dữ liệu. Đã di dời dữ liệu từ phòng ban Cần Thơ sang phòng ban Đà Nẵng từ hỗn hợp 1 2 sang 3 4'
				end
			else
				print N'Đã sửa dữ liệu thành công'
		end

	else if exists(
			select *
			from PhongBan_HH3
			where MaPB = @MaPB
		)
			begin
				update PhongBan_HH3
				set TenPB = @TenPB
				where MaPB = @MaPB

				update PhongBan_HH4
				set ChiNhanh = @ChiNhanh
				where MaPB = @MaPB

				if @ChiNhanh = N'Cần Thơ'
					begin
						insert into PhongBan_HH1
						select * from PhongBan_HH3 where MaPB = @MaPB
						delete from PhongBan_HH3 where MaPB = @MaPB
					
						insert into PhongBan_HH2
						select * from PhongBan_HH4 where MaPB = @MaPB
						delete from PhongBan_HH4 where MaPB = @MaPB

						print N'Đã sửa thành công dữ liệu. Đã di dời dữ liệu từ phòng ban Đà Nẵng sang phòng ban Cần Thơ từ hỗn hợp 3 4 sang 1 2'
					end
				else
					print N'Đã sửa dữ liệu thành công'
			end
end
go
-- Test PROC SuaPB_HH:
exec SuaPB_HH Null, N'Cung Cấp', N'Cần Thơ'
go
exec SuaPB_HH N'PB01', N'Cung Cấp', N'Cần Thơ'
go
exec SuaPB_HH N'PB10', N'Cung Cấp', N'Cần Thơ'
go
exec SuaPB_HH N'PB05', N'Phát Triển', N'Sài Gòn'
go
exec SuaPB_HH N'PB05', N'IT', N'Đà Nẵng'
go
exec SuaPB_HH N'PB06', N'CNTT', N'Cần Thơ'
go

--ĐỂ CÓ ĐIỂM, CÁC EM NHỚ LƯU FILE SQL NÀY VÀO Ổ S:\
------------------------HẾT-----------------------------------------

