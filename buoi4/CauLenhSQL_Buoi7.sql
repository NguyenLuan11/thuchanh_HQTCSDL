----CAU1----
CREATE VIEW vwNhanVienNam
AS
SELECT MaNV, HoNV, TenLot, TenNV, NgSinh, Phong
FROM NHANVIEN
WHERE Phai = N'Nam'

----CAU2----
CREATE VIEW vwNhanVienPhong5 
AS
SELECT MaNV, HoNV, TenLot, TenNV, YEAR(GETDATE()) - YEAR(NgSinh) AS N'Tuổi', Luong
FROM NHANVIEN
WHERE Phong = 5

----CAU3----
CREATE VIEW vwThanNhanNVNu 
AS
SELECT NHANVIEN.MaNV, TenNV, TenTN
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.Phai = N'Nữ'
GROUP BY NHANVIEN.MaNV, TenNV, TenTN

----CAU4----
CREATE VIEW vwPhongLuongCao 
AS
SELECT PHONGBAN.TenPhg
FROM NHANVIEN INNER JOIN PHONGBAN ON NHANVIEN.Phong = PHONGBAN.MaPhg INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV 
INNER JOIN DEAN ON PHANCONG.MaDA = DEAN.MaDA
GROUP BY TenPhg
HAVING AVG(NHANVIEN.Luong) > 7000000

----CAU5----
INSERT INTO vwNhanVienNam VALUES('246', N'Trần', N'Công', N'Minh', '1992/12/12', 1)
SELECT * FROM NHANVIEN
----CAU6----
SELECT * FROM vwNhanVienNam

----CAU7----
INSERT INTO vwNhanVienPhong5 VALUES('247', N'Lê', N'Minh', N'Hoàng', 40, 6200000)
----Update or insert of view or function 'vwNhanVienPhong5' failed because it contains a derived or constant field----

----8. Sử dụng thủ tục sp_helptext để xem nội dung câu lệnh SELECT định nghĩa view vwNhanVienPhong5----
EXEC sp_helptext 'vwNhanVienPhong5';

----9. Định nghĩa lại view vwNhanVienPhong5 để giấu nội dung câu lệnh SELECT định nghĩa view này. Kiểm tra kết quả với thủ tục sp_helptext----
