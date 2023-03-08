----1. Cho biết danh sách các nhân viên có ít nhất một thân nhân----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'HỌ TÊN NHÂN VIÊN', COUNT(*) AS N'SỐ LƯỢNG THÂN NHÂN'
FROM NHANVIEN INNER JOIN THANNHAN ON NHANVIEN.MaNV = THANNHAN.MaNV
GROUP BY HoNV, TenLot, TenNV
----OR----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'HỌ TÊN NHÂN VIÊN KHÔNG CÓ THÂN NHÂN'
FROM NHANVIEN
WHERE NHANVIEN.MaNV IN (SELECT NHANVIEN.MaNV
							FROM NHANVIEN, THANNHAN WHERE NHANVIEN.MaNV = THANNHAN.MaNV)
GROUP BY HoNV, TenLot, TenNV

----2. Cho biết danh sách các nhân viên không có thân nhân nào----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'HỌ TÊN NHÂN VIÊN KHÔNG CÓ THÂN NHÂN'
FROM NHANVIEN
WHERE NHANVIEN.MaNV NOT IN (SELECT NHANVIEN.MaNV
							FROM NHANVIEN, THANNHAN WHERE NHANVIEN.MaNV = THANNHAN.MaNV)
GROUP BY HoNV, TenLot, TenNV

----3. Cho biết họ tên các nhân viên có trên 2 thân nhân----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'HỌ TÊN NHÂN VIÊN CÓ TRÊN 2 THÂN NHÂN'
FROM NHANVIEN, THANNHAN
WHERE NHANVIEN.MaNV = THANNHAN.MaNV
GROUP BY HoNV, TenLot, TenNV
HAVING COUNT(THANNHAN.MaNV) > 2

----4. Cho biết họ tên những trưởng phòng có ít nhất một thân nhân----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'HỌ TÊN NHÂN VIÊN KHÔNG CÓ THÂN NHÂN'
FROM NHANVIEN INNER JOIN PHONGBAN ON NHANVIEN.MaNV = PHONGBAN.TRPHG
WHERE PHONGBAN.TRPHG IN (SELECT NHANVIEN.MaNV
							FROM NHANVIEN, THANNHAN WHERE NHANVIEN.MaNV = THANNHAN.MaNV)
GROUP BY HoNV, TenLot, TenNV

----6. Cho biết họ tên các nhân viên phòng Quản lý có mức lương trên mức lương trung bình của phòng Quản lý----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'HỌ TÊN NHÂN VIÊN', Luong
FROM NHANVIEN
WHERE NHANVIEN.Luong > (SELECT AVG(NHANVIEN.Luong) FROM NHANVIEN INNER JOIN PHONGBAN ON NHANVIEN.Phong = PHONGBAN.MaPhg
				WHERE PHONGBAN.TenPhg LIKE N'Quản lý')

----7. Cho biết họ tên nhân viên có mức lương trên mức lương trung bình của phòng mà nhân viên đó đang làm việc----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'HỌ TÊN NHÂN VIÊN', Luong
FROM NHANVIEN
WHERE NHANVIEN.Luong > (SELECT AVG(NHANVIEN.Luong) FROM NHANVIEN INNER JOIN PHONGBAN ON NHANVIEN.Phong = PHONGBAN.MaPhg)

----8. Cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất----
SELECT (HoNV + ' ' + TenLot + ' '+ TenNV) AS 'Họ tên trưởng phòng của phòng ban đông nhân viên nhất'
FROM NHANVIEN, PHONGBAN
WHERE NHANVIEN.MaNV = PHONGBAN.TRPHG AND
		  PHONGBAN.MaPhg = (SELECT TOP 1 PHONGBAN.MaPhg FROM NHANVIEN INNER JOIN PHONGBAN ON NHANVIEN.Phong = PHONGBAN.MaPhg
							GROUP BY PHONGBAN.MaPhg
							ORDER BY COUNT (NHANVIEN.Phong) DESC)

----9. Cho biết danh sách các đề án mà nhân viên có mã là 456 chưa tham gia----
SELECT MaDA AS N'Danh sách các đề án mà nhân viên có mã là 456 chưa tham gia'
FROM NHANVIEN, DEAN
WHERE NHANVIEN.MaNV = '456' AND DEAN.MaDA NOT IN (SELECT PHANCONG.MaDA
						FROM PHANCONG WHERE PHANCONG.MaNV ='456')
GROUP BY MaDA

----10. Danh sách nhân viên gồm mã nhân viên, họ tên và địa chỉ của những nhân viên không sống tại TP Quảng Ngãi nhưng làm việc cho một đề án ở TP Quảng Ngãi----
SELECT NHANVIEN.MaNV, (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'HỌ TÊN NHÂN VIÊN', DiaChi, DDiemDA
FROM NHANVIEN INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV INNER JOIN DEAN ON PHANCONG.MaDA = DEAN.MaDA
WHERE (DiaChi NOT LIKE N'TP Quảng Ngãi' AND DEAN.MaDA = '2') OR (DiaChi NOT LIKE N'TP Quảng Ngãi' AND DEAN.MaDA = '20')
GROUP BY HoNV, TenLot, TenNV, NHANVIEN.MaNV, DiaChi, DDiemDA

----11. Tìm họ tên và địa chỉ của các nhân viên làm việc cho một đề án ở một địa điểm nhưng lại không sống tại địa điểm đó----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'HỌ TÊN NHÂN VIÊN', DiaChi, DDiemDA
FROM NHANVIEN INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV INNER JOIN DEAN ON PHANCONG.MaDA = DEAN.MaDA
WHERE (DiaChi NOT LIKE  DEAN.DDiemDA)
GROUP BY HoNV, TenLot, TenNV, DiaChi, DDiemDA

----12. Cho biết danh sách các mã đề án có: nhân công với họ là Lê hoặc có người trưởng phòng chủ trì đề án với họ là Lê----
SELECT DEAN.MaDA, (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'Nhân công với họ là Lê hoặc có người trưởng phòng chủ trì đề án với họ là Lê'
FROM NHANVIEN INNER JOIN PHONGBAN ON NHANVIEN.MaNV = PHONGBAN.TRPHG INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV 
INNER JOIN DEAN ON PHANCONG.MaDA = DEAN.MaDA
WHERE NHANVIEN.HoNV LIKE N'Lê'

----13. Liệt kê danh sách các đề án mà cả hai nhân viên có mã số 123 và 789 cùng làm----
SELECT NHANVIEN.MaNV, DEAN.TenDA
FROM NHANVIEN INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV INNER JOIN DEAN ON PHANCONG.MaDA = DEAN.MaDA
WHERE NHANVIEN.MaNV = '123' AND NHANVIEN.MaNV = '789'
GROUP BY NHANVIEN.MaNV, DEAN.TenDA

----14. Liệt kê danh sách các đề án mà cả hai nhân viên Đinh Bá Tiến và Trần Thanh Tâm cùng làm----
SELECT (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'HỌ TÊN NHÂN VIÊN', DEAN.TenDA
FROM NHANVIEN INNER JOIN PHANCONG ON NHANVIEN.MaNV = PHANCONG.MaNV INNER JOIN DEAN ON PHANCONG.MaDA = DEAN.MaDA
WHERE (HoNV LIKE N'Đinh' AND TenLot LIKE N'Bá' AND TenNV LIKE N'Tiến') AND (HoNV LIKE N'Trần' AND TenLot LIKE N'Thanh' AND TenNV LIKE N'Tâm')
GROUP BY DEAN.TenDA, HoNV, TenLot, TenNV

----15. Danh sách những nhân viên (bao gồm mã nhân viên, họ tên, phái) làm việc trong mọi đề án của công ty----
SELECT PHANCONG.MaNV, (HoNV + ' ' + TenLot + ' ' + TenNV) AS N'HỌ TÊN NHÂN VIÊN', Phai, TenDA
FROM PHANCONG, NHANVIEN, DEAN
WHERE PHANCONG.MaNV = NHANVIEN.MANV 
AND NOT EXISTS(SELECT DEAN.MaDA
               FROM DeAn 
               WHERE NOT EXISTS(SELECT PHANCONG.MaDA
                                FROM PHANCONG 
                                WHERE PHANCONG.MaDA = DEAN.MaDA 
                                AND PHANCONG.MaNV = NHANVIEN.MANV))
