----18. Cho biết số lượng đề án của công ty----
SELECT COUNT(*) AS N'Số lượng đề án'
FROM DEAN
----19. Liệt kê danh sách các phòng ban có tham gia chủ trì các đề án----
SELECT TenPhg AS N'Tên phòng ban', TenDA AS N'Tên đề án'
FROM NHANVIEN INNER JOIN PHONGBAN ON PHONGBAN.MaPhg = NHANVIEN.Phong INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV 
INNER JOIN DEAN ON DEAN.MaDA = PHANCONG.MaDA
GROUP BY TenPhg, TenDA
----20. Cho biết số lượng các phòng ban có tham gia chủ trì các đề án----
SELECT COUNT(*) AS N'SL phòng ban tham gia chủ trì',TenDA AS N'Tên đề án'
FROM NHANVIEN INNER JOIN PHONGBAN ON PHONGBAN.MaPhg = NHANVIEN.Phong INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV 
INNER JOIN DEAN ON DEAN.MaDA = PHANCONG.MaDA
GROUP BY TenPhg, TenDA
----21. Cho biết số lượng đề án do phòng Nghiên Cứu chủ trì----
SELECT TenPhg AS N'Tên phòng ban', COUNT(TenDA) AS N'SL đề án chủ trì'
FROM NHANVIEN INNER JOIN PHONGBAN ON PHONGBAN.MaPhg = NHANVIEN.Phong INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV 
INNER JOIN DEAN ON DEAN.MaDA = PHANCONG.MaDA
WHERE MaPhg = 5 AND TenPhg = N'Nghiên Cứu'
GROUP BY PHONGBAN.TenPhg
----22. Cho biết lương trung bình của các nữ nhân viên----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', Phai, AVG(Luong) AS N'Lương trung bình'
FROM NHANVIEN
WHERE Phai LIKE N'Nữ'
GROUP BY HoNV, TenLot, TenNV, Phai
----23. Cho biết số thân nhân của nhân viên Đinh Bá Tiến----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', COUNT(*) AS N'Số thân nhân'
FROM NHANVIEN INNER JOIN THANNHAN ON NHANVIEN.MaNV = THANNHAN.MaNV
WHERE HoNV LIKE N'Đinh' AND TenLot LIKE N'Bá' AND TenNV LIKE N'Tiến'
GROUP BY HoNV, TenLot, TenNV
----24. Liệt kê danh sách 3 nhân viên lớn tuổi nhất, danh sách bao gồm họ tên và năm sinh----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', YEAR(NgSinh) AS N'Năm sinh'
FROM NHANVIEN
ORDER BY YEAR(NgSinh)
-----25. Với mỗi đề án, liệt kê mã đề án và tổng số giờ làm việc của tất cả các nhân viên tham gia đề án đó----
SELECT DEAN.MaDA, SUM(PHANCONG.ThoiGian) AS N'Tổng số giờ làm việc'
FROM NHANVIEN, PHANCONG, DEAN
WHERE NHANVIEN.MaNV = PHANCONG.MaNV AND PHANCONG.MaDA = DEAN.MaDA
GROUP BY DEAN.MaDA
----26. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc của tất cả các nhân viên tham gia đề án đó----
SELECT DEAN.TenDA AS N'Tên đề án', SUM(PHANCONG.ThoiGian) AS N'Tổng số giờ làm việc'
FROM NHANVIEN, PHANCONG, DEAN
WHERE NHANVIEN.MaNV = PHANCONG.MaNV AND PHANCONG.MaDA = DEAN.MaDA
GROUP BY DEAN.TenDA
----27. Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó, thông tin bao gồm tên đề án và số lượng nhân viên----
SELECT DEAN.TenDA AS N'Tên đề án', COUNT(PHANCONG.MaNV) AS N'Số lượng nhân viên'
FROM NHANVIEN, PHANCONG, DEAN
WHERE NHANVIEN.MaNV = PHANCONG.MaNV AND PHANCONG.MaDA = DEAN.MaDA
GROUP BY DEAN.TenDA
----28. Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân của nhân viên đó----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', COUNT(*) AS N'Số lượng thân nhân'
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MaNV = THANNHAN.MaNV
GROUP BY HoNV, TenLot, TenNV
----29. Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà nhân viên đó đã tham gia----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', COUNT(*) AS N'Số lượng đề án'
FROM NHANVIEN, PHANCONG
WHERE NHANVIEN.MaNV = PHANCONG.MaNV
GROUP BY HoNV, TenLot, TenNV
----30. Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó----
SELECT TenPhg AS N'Tên phòng ban', AVG(Luong)
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.Phong = PHONGBAN.MaPhg
GROUP BY TenPhg
----31. Với các phòng ban có mức lương trung bình trên 5.200.000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó----
SELECT TenPhg AS N'Tên phòng ban', COUNT(MaNV) AS N'Số lượng nhân viên'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.Phong = PHONGBAN.MaPhg
GROUP BY TenPhg, MaNV
HAVING AVG(Luong) > 5200000
----32. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì----
SELECT TenPhg AS N'Tên phòng ban', COUNT(PHANCONG.MaDA) AS N'Số lượng đề án'
FROM NHANVIEN, PHONGBAN, DEAN, PHANCONG
WHERE NHANVIEN.Phong = PHONGBAN.MaPhg AND NHANVIEN.MaNV = PHANCONG.MaNV AND DEAN.MaDA = PHANCONG.MaDA
GROUP BY TenPhg
----33. Với mỗi phòng ban, cho biết tên phòng ban, họ tên người trưởng phòng và số lượng đề án mà phòng ban đó chủ trì----

----34. Với mỗi đề án, cho biết tên đề án và số lượng nhân viên tham gia đề án----
SELECT TenDA, COUNT(PHANCONG.MaNV) AS N'Số lượng nhân viên tham gia'
FROM DEAN, PHANCONG, NHANVIEN
WHERE DEAN.MaDA = PHANCONG.MaDA AND NHANVIEN.MaNV = PHANCONG.MaNV
GROUP BY TenDA