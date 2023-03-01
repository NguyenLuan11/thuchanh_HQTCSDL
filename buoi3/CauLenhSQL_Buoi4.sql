----1. Liệt kê danh sách tất cả các nhân viên----
SELECT * FROM NHANVIEN
----2. Tìm các nhân viên làm việc ở phòng số 5----
SELECT * FROM NHANVIEN
WHERE Phong = 5
----3. Liệt kê họ tên và phòng làm việc các nhân viên có mức lương trên 6.000.000 đồng----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', Phong AS 'Phòng làm việc'
FROM NHANVIEN
WHERE Luong > 6000000
----4. Tìm các nhân viên có mức lương trên 6.500.000 ở phòng 1 hoặc các nhân viên có mức lương trên 5.000.000 ở phòng 4----
SELECT *
FROM NHANVIEN
WHERE (Phong = 1 AND Luong > 6500000) OR (Phong = 4 AND Luong > 5500000)
----5. Cho biết họ tên đầy đủ của các nhân viên ở TP Quảng Ngãi----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', DiaChi AS 'Địa chỉ'
FROM NHANVIEN
WHERE DiaChi LIKE N'TP Quảng Ngãi'
----6. Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự 'N'----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên'
FROM NHANVIEN
WHERE HoNV LIKE N'N%'
----7. Cho biết ngày sinh và địa chỉ của nhân viên Cao Thanh Huyền----
SELECT MaNV, (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', NgSinh, DiaChi
FROM NHANVIEN
WHERE HoNV LIKE N'Cao' AND TenLot LIKE N'Thanh' AND TenNV LIKE N'Huyền'
----8. Cho biết các nhân viên có năm sinh trong khoảng 1955 đến 1975----
SELECT *
FROM NHANVIEN
WHERE YEAR(NgSinh) BETWEEN 1955 AND 1975
----9. Cho biết các nhân viên và năm sinh của nhân viên----
SELECT MaNV, (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', YEAR(NgSinh) AS 'Năm sinh'
FROM NHANVIEN
----10. Cho biết họ tên và tuổi của tất cả các nhân viên----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', YEAR(GETDATE()) - YEAR(NgSinh) AS 'Tuổi'
FROM NHANVIEN
----11. Tìm tên những người trưởng phòng của từng phòng ban----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên trưởng phòng'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.MaNV = PHONGBAN.TRPHG
----12. Tìm tên và địa chỉ của tất cả các nhân viên của phòng "Điều hành".----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', DiaChi AS 'Địa chỉ', TenPhg AS 'Tên phòng'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.Phong = PHONGBAN.MaPhg AND NHANVIEN.Phong = 4
----13. Với mỗi đề án ở Tp Quảng Ngãi, cho biết tên đề án, tên phòng ban, họ tên và ngày nhận chức của trưởng phòng của phòng ban chủ trì đề án đó----
SELECT TenDA, TenPhg, (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên'
FROM DEAN, PHONGBAN, NHANVIEN
WHERE NHANVIEN.MaNV = PHONGBAN.TRPHG AND PHONGBAN.MaPhg = DEAN.PHONG AND DEAN.DDiemDA LIKE 'Tp Quảng Ngãi'
----14. Tìm tên những nữ nhân viên và tên người thân của họ----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', NHANVIEN.Phai, TenTN AS 'Tên người thân'
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MaNV = THANNHAN.MaNV AND NHANVIEN.Phai LIKE N'Nữ'
----15. Với mỗi nhân viên, cho biết họ tên của nhân viên, họ tên trưởng phòng của phòng ban mà nhân viên đó đang làm việc----
SELECT (NV1.HoNV + ' ' + NV1.TenLot + ' ' + NV1.TenNV) AS N'Họ tên nhân viên', NV1.Phong, (NV2.HoNV + ' ' + NV2.TenLot + ' ' + NV2.TenNV) AS N'Họ tên trưởng phòng'
FROM NHANVIEN NV1, NHANVIEN NV2, PHONGBAN
WHERE NV1.Phong = PHONGBAN.MaPhg AND NV2.MaNV = PHONGBAN.TRPHG
----16. Tên những nhân viên phòng Nghiên cứu có tham gia vào đề án "Xây dựng nhà máy chế biến thủy sản"----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', TenPHG AS 'Tên phòng', TenDA AS 'Tên đề án'
FROM NHANVIEN INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV INNER JOIN DEAN ON DEAN.MaDA = PHANCONG.MaDA, PHONGBAN
WHERE NHANVIEN.Phong = PHONGBAN.MaPhg AND TenPhg LIKE 'Nghiên cứu' AND TenDA LIKE 'Xây dựng nhà máy chế biến thủy sản'
GROUP BY TenPhg, TenDA, HoNV, TenLot, TenNV
----17. Cho biết tên các đề án mà nhân viên Trần Thanh Tâm đã tham gia----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Họ tên', TenDA AS 'Tên đề án'
FROM NHANVIEN, DEAN, PHANCONG
WHERE NHANVIEN.MaNV = PHANCONG.MaNV AND DEAN.MaDA = PHANCONG.MaDA AND HoNV LIKE N'Trần' AND TenLot LIKE N'Thanh' AND TenNV LIKE N'Tâm'
