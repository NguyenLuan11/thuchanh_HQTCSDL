------------1--------------
EXEC sp_addtype 'Mota', 'NVARCHAR(40)';
EXEC sp_addtype 'IDKH', 'CHAR(10)', 'NOT NULL'
EXEC sp_addtype 'DT', 'CHAR(12)'
------------2-------------
CREATE TABLE SanPham(
	Masp char(6) NOT NULL,
	Tensp varchar(20) NOT NULL,
	NgayNhap date,
	DVT char(10),
	SoLuongTon int,
	DonGiaNhap money,
	PRIMARY KEY (Masp)
);

CREATE TABLE KhachHang(
	MaKH IDKH NOT NULL,
	TenKH nvarchar(30),
	DiaChi nvarchar(40),
	DienThoai DT,
	PRIMARY KEY (MaKH)
);

CREATE TABLE HoaDon(
	MaHD char(10) NOT NULL,
	NgayLap date,
	NgayGiao date,
	MaKH IDKH FOREIGN KEY REFERENCES KhachHang(MaKH),
	DienGiai Mota,
	PRIMARY KEY (MaHD)
);

CREATE TABLE ChiTietHD(
	MaHD char(10) FOREIGN KEY REFERENCES HoaDon(MaHD),
	Masp char(6) FOREIGN KEY REFERENCES SanPham(Masp),
	SoLuong int,
	PRIMARY KEY (MaHD, Masp)
);

------------3-------------
ALTER TABLE HoaDon
ALTER COLUMN DienGiai nvarchar(100);

------------4-------------
ALTER TABLE SanPham
ADD TyLeHoaHong float;

------------5-------------
ALTER TABLE SanPham
DROP COLUMN NgayNhap;

------------7-------------
---NgayGiao >= NgayLap---
ALTER TABLE HoaDon
ADD CONSTRAINT check_NgayLap CHECK (NgayGiao >= NgayLap);
--MaHD gồm 6 ký tự, 2 ký tự đầu là chữ, các ký tự còn lại là số--
ALTER TABLE HoaDon
ADD CONSTRAINT check_MaHD CHECK (MaHD LIKE '[A-Z][A-Z][0-9][0-9][0-9][0-9]');
----Giá trị mặc định ban đầu cho cột NgayLap luôn luôn là ngày hiện hành----
ALTER TABLE HoaDon
ADD CONSTRAINT value_NgayLap DEFAULT GETDATE() FOR NgayLap;

-----------8---------------
---SoLuongTon chỉ nhập từ 0 đến 500---
ALTER TABLE SanPham
ADD CONSTRAINT check_SLTon CHECK (SoLuongTon BETWEEN 0 AND 500);
---DonGiaNhap lớn hơn 0---
ALTER TABLE SanPham
ADD CONSTRAINT check_DonGiaNhap CHECK (DonGiaNhap > 0);
---Giá trị mặc định cho NgayNhap là ngày hiện hành---
ALTER TABLE SanPham
ADD CONSTRAINT value_NgayNhap DEFAULT GETDATE() FOR NgayNhap;
---DVT chỉ nhập vào các giá trị ‘KG’, ‘Thùng’, ‘Hộp’, ‘Cái’---
ALTER TABLE SanPham
ADD CONSTRAINT check_DVT CHECK (DVT = N'KG' OR DVT = N'Thùng' OR DVT = N'Hộp' OR DVT = N'Cái');

-----------9---------------
