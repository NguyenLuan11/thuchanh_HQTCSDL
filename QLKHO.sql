-----------CAU1------------
CREATE TABLE TON(
	MaVT VARCHAR(4) PRIMARY KEY NOT NULL,
	TenVT NVARCHAR(30),
	SoLuongT INT
);

CREATE TABLE NHAP(
	SoHDN VARCHAR(4) PRIMARY KEY NOT NULL,
	MaVT VARCHAR(4) FOREIGN KEY REFERENCES TON(MaVT),
	SoLuongN INT,
	DonGiaN MONEY,
	NgayN DATE
);

CREATE TABLE XUAT(
	SoHDX VARCHAR(4) PRIMARY KEY NOT NULL,
	MaVT VARCHAR(4) FOREIGN KEY REFERENCES TON(MaVT),
	SoLuongX INT,
	DonGiaX MONEY,
	NgayX DATE
);

INSERT INTO TON VALUES('VT01', N'Gạch ống', 255), ('VT02', N'Ngói đỏ', 137), ('VT03', N'Gạch men lát tường', 300),
('VT04', N'Đá hoa cương', 435), ('VT05', N'Xi măng', 567)

INSERT INTO NHAP VALUES('N001', 'VT01', 500, 11700000, '2019-03-27'), ('N002', 'VT04', 600, 18500000, '2020-05-27'),
('N003', 'VT02', 337, 17000000, '2020-12-27')

INSERT INTO XUAT VALUES('X001', 'VT01', 245, 5890000, '2019-03-27'), ('X002', 'VT03', 200, 11200000, '2020-05-27')

-----------CAU2: thống kê tiền bán theo mã vật tư gồm MaVT, TênVT, TienBan (TienBan=SoLuongX*DonGiaX)------------
CREATE VIEW CAU2
AS
SELECT TON.MaVT, TenVT, SUM(SoLuongX * DonGiaX) AS N'Tiền bán'
FROM XUAT INNER JOIN TON ON XUAT.MaVT = TON.MaVT
GROUP BY TON.MaVT, TenVT
----TEST----
SELECT * FROM CAU2

-----------CAU3: thống kê soluongxuat theo tên vattu------------
CREATE VIEW CAU3
AS
SELECT TON.TenVT, SUM(SoLuongX) AS N'Tổng sl'
FROM XUAT INNER JOIN TON ON XUAT.MaVT = TON.MaVT
GROUP BY TON.TenVT
----TEST----
SELECT * FROM CAU3

-----------CAU4: thống kê soluongnhap theo tên vật tư------------
CREATE VIEW CAU4
AS
SELECT TON.TenVT, SUM(SoLuongN) AS N'Tổng sl'
FROM NHAP INNER JOIN TON ON NHAP.MaVT = TON.MaVT
GROUP BY TON.TenVT
----TEST----
SELECT * FROM CAU4

-----------CAU5: đưa ra tổng soluong còn trong kho biết còn = nhap – xuất + tồn theo từng nhóm vật tư------------
CREATE VIEW CAU5
AS
SELECT TON.MaVT, TON.TenVT, SUM(SoLuongN) - SUM(SoLuongX) + SUM(SoLuongT) AS N'TỔNG TỒN'
FROM NHAP INNER JOIN TON ON NHAP.MaVT = TON.MaVT INNER JOIN XUAT ON TON.MaVT = XUAT.MaVT
GROUP BY TON.MaVT, TON.TenVT
----TEST----
SELECT * FROM CAU5

-----------CAU6: đưa ra tên vật tư số lượng tồn nhiều nhất------------
CREATE VIEW CAU6
AS
SELECT TenVT
FROM TON
WHERE SoLuongT = (SELECT MAX(SoLuongT) FROM TON)
----TEST----
SELECT * FROM CAU6

-----------CAU7: đưa ra các vật tư có tổng số lượng xuất lớn hơn 100------------
CREATE VIEW CAU7
AS
SELECT TON.MaVT, TON.TenVT
FROM TON INNER JOIN XUAT ON TON.MaVT = XUAT.MaVT
GROUP BY TON.MaVT, TON.TenVT
HAVING SUM(SoLuongX) >= 100
----TEST----
SELECT * FROM CAU7

-----------CAU8: Tạo view đưa ra tháng xuất, năm xuất, tổng số lượng xuất thống kê theo tháng và năm xuất------------
CREATE VIEW CAU8
AS
SELECT MONTH(NgayX) AS N'NGÀY XUẤT', YEAR(NgayX) AS N'NĂM XUẤT', SUM(SoLuongX) AS N'SỐ LƯỢNG XUẤT'
FROM XUAT
GROUP BY XUAT.NgayX
----TEST----
SELECT * FROM CAU8

-----------CAU9: tạo view đưa ra mã vật tư. tên vật tư. số lượng nhập. số lượng xuất. đơn giá N. đơn giá X. ngày nhập. Ngày xuất------------
CREATE VIEW CAU9
AS
SELECT TON.MaVT, TON.TenVT, NHAP.SoLuongN, XUAT.SoLuongX, NHAP.DonGiaN, XUAT.DonGiaX, NHAP.NgayN, XUAT.NgayX
FROM TON INNER JOIN NHAP ON TON.MaVT = NHAP.MaVT INNER JOIN XUAT ON TON.MaVT = XUAT.MaVT
GROUP BY TON.MaVT, TON.TenVT, NHAP.NgayN, XUAT.NgayX, NHAP.SoLuongN, XUAT.SoLuongX, NHAP.DonGiaN, XUAT.DonGiaX
----TEST----
SELECT * FROM CAU9