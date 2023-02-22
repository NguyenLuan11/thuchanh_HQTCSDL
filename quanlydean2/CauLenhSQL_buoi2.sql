CREATE TABLE PHONGBAN(
	MaPhg VARCHAR(2) PRIMARY KEY NOT NULL,
	TenPhg NVARCHAR(20)
);

CREATE TABLE NHANVIEN(
	MaNV VARCHAR(9) PRIMARY KEY NOT NULL,
	HoNV NVARCHAR(15),
	TenLot NVARCHAR(30),
	TenNV NVARCHAR(30),
	NgSinh SMALLDATETIME,
	DiaChi NVARCHAR(150),
	Phai NVARCHAR(3),
	Luong NUMERIC(18,0),
	Phong VARCHAR(2) FOREIGN KEY REFERENCES PHONGBAN(MaPhg)
);

CREATE TABLE DEAN(
	MaDA VARCHAR(2) PRIMARY KEY NOT NULL,
	TenDA NVARCHAR(50),
	DDiemDA VARCHAR(20)
);

CREATE TABLE PHANCONG(
	MaNV VARCHAR(9) FOREIGN KEY REFERENCES NHANVIEN(MaNV) NOT NULL,
	MaDA VARCHAR(2) FOREIGN KEY REFERENCES DEAN(MaDA) NOT NULL,
	ThoiGian NUMERIC(18,0),
	PRIMARY KEY(MaNV, MaDA)
);

CREATE TABLE THANNHAN(
	MaNV VARCHAR(9) FOREIGN KEY REFERENCES NHANVIEN(MaNV) NOT NULL,
	TenTN VARCHAR(20) NOT NULL,
	NgaySinh SMALLDATETIME,
	Phai VARCHAR(3),
	QuanHe VARCHAR(15),
	PRIMARY KEY(MaNV, TenTN)
);

---------Cau4----------
ALTER TABLE PHONGBAN
ALTER COLUMN TenPhg NVARCHAR(30)

ALTER TABLE DEAN
ALTER COLUMN DDiemDA NVARCHAR(20)

ALTER TABLE THANNHAN
ALTER COLUMN Phai NVACHAR(3)

ALTER TABLE THANNHAN
ALTER COLUMN TenTN NVARCHAR(20)

ALTER TABLE THANNHAN
ALTER COLUMN QuanHe NVARCHAR(15)

ALTER TABLE NHANVIEN
ADD SoDienThoai VARCHAR(15)
ALTER TABLE NHANVIEN
DROP COLUMN SoDienThoai

---------Cau5----------
INSERT INTO PHONGBAN VALUES('1', N'Quản lý'), ('4', N'Điều hành'), ('5', N'Nghiên cứu')

INSERT INTO NHANVIEN
VALUES('123', N'Đinh', N'Bá', N'Tiến', '1982-02-27', N'Mộ Đức', 'Nam', NULL, '4'),
('234', N'Nguyễn', N'Thanh', N'Tùng', '1956-08-12', N'Sơn Tịnh', 'Nam', NULL, '5'),
('345', N'Bùi', N'Thúy', N'Vũ', NULL, N'Tư Nghĩa', 'Nữ', NULL, '5'),
('456', N'Lê', N'Thị', N'Nhàn', '1962-07-12', N'Mộ Đức', 'Nữ', NULL, '4'),
('567', N'Nguyễn', N'Mạnh', N'Hùng', '1985-03-25', N'Sơn Tịnh', 'Nam', NULL, '5'),
('678', N'Trần', N'Hồng', N'Quang', NULL, N'Bình Sơn', 'Nam', NULL, '5'),
('789', N'Trần', N'Thanh', N'Tâm', '1972-06-17', N'Tp Quảng Ngãi', 'Nam', NULL, '5'),
('890', N'Cao', N'Thanh', N'Huyền', NULL, N'Tư Nghĩa', 'Nữ', NULL, '1'),
('901', N'Vương', N'Ngọc', N'Quyền', '1987-12-12', N'Mộ Đức', 'Nam', NULL, '1')

INSERT INTO DEAN VALUES('1', N'Nâng cao chất lượng muối', N'Sa Huỳnh'), ('10', N'Xây dựng nhà máy chế biến thủy sản', N'Dung Quất'),
('2', N'Phát triển hạ tầng mạng', N'Tp Quảng Ngãi'), ('20', N'Truyền tải cáp quang', N'Tp Quảng Ngãi'),
('3', N'Tin học hóa trường học', N'Ba Tơ'), ('30', N'Đào tạo nhân lực', N'Tịnh Phong')

INSERT INTO THANNHAN
VALUES('123', N'Châu', '2005-10-30', N'Nữ', N'Con gái'), ('123', N'Duy', '2001-10-25', N'Nam', N'Con trai'),
('123', N'Phương', N'1985-10-30', N'Nữ', N'Vợ chồng'), ('234', N'Thanh', '1980-04-05', N'Nữ', N'Con gái'),
('345', N'Dương', '1956-10-30', N'Nam', N'Vợ chồng'), ('345', N'Khang', '1982-10-25', N'Nam', N'Con trai'),
('456', N'Hùng', '1987-01-01', N'Nam', N'Con trai'), ('901', N'Thương', '1989-04-05', N'Nữ', N'Vợ chồng')

INSERT INTO PHANCONG VALUES('123', '1', '33'), ('123','2', '8'), ('345', '10', '10'), ('345', '20', '10'), ('345', '3', '10'),
('456', '1', '20'), ('456', '2', '20'), ('678', '3', '40'), ('789', '10', '35'), ('789', '20', '30'), ('789', '30', '5')

