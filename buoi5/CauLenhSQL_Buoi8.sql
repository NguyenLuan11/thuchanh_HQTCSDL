----CAU1----
CREATE PROCEDURE spTangLuong
AS
BEGIN
    UPDATE NhanVien
    SET Luong = Luong * 1.1
END;

EXEC spTangLuong;

----CAU2----
ALTER TABLE NHANVIEN
ADD NgayNghiHuu SMALLDATETIME;

CREATE PROCEDURE spNghiHuu
AS
BEGIN
    UPDATE NHANVIEN
    SET NgayNghiHuu = DATEADD(day, 100, GETDATE())
    WHERE (Phai = 'Nam' AND DATEDIFF(year, NgSinh, GETDATE()) >= 60)
    OR (Phai = 'Nu' AND DATEDIFF(year, NgSinh, GETDATE()) >= 55)
END;

EXEC spNghiHuu;

----CAU3----
CREATE PROCEDURE spXemDeAn @DDiemDA NVARCHAR(255)
AS
BEGIN
    SELECT * FROM DeAn
    WHERE DDiemDA = @DDiemDA
END;

EXEC spXemDeAn @DDiemDA = N'<địa điểm>';

----CAU4----
CREATE PROCEDURE spCapNhatDeAn @diadiem_cu NVARCHAR(255), @diadiem_moi NVARCHAR(255)
AS
BEGIN
    UPDATE DeAn
    SET DDiemDA = @diadiem_moi
    WHERE DDiemDA = @diadiem_cu
END;

EXEC spCapNhatDeAn @diadiem_cu = N'<địa điểm cũ>', @diadiem_moi = N'<địa điểm mới>';

----CAU5----
CREATE PROCEDURE spThemDeAn
    @MaDeAn INT,
    @TenDeAn NVARCHAR(50),
    @DDiemDA NVARCHAR(255)
AS
BEGIN
    INSERT INTO DEAN (MaDA, TenDA, DDiemDA)
    VALUES (@MaDeAn, @TenDeAn, @DDiemDA)
END

EXEC spThemDeAn @MaDeAn = 0 , @TenDeAn = N'<>', @DDiemDA = N'<>';

----CAU6----
CREATE PROCEDURE spCheckThemDeAn
    @MaDeAn INT,
    @TenDeAn NVARCHAR(50),
    @DDiemDA NVARCHAR(255),
    @MaPhongBan INT
AS
BEGIN
    IF EXISTS (SELECT * FROM DEAN WHERE MaDA = @MaDeAn)
    BEGIN
        RAISERROR ('Mã đề án đã tồn tại, đề nghị chọn mã đề án khác', 16, 1);
        RETURN;
    END
IF NOT EXISTS (SELECT * FROM PHONGBAN WHERE MaPhg = @MaPhongBan)
    BEGIN
        RAISERROR ('Mã phòng không tồn tại', 16, 1);
        RETURN;
    END

    INSERT INTO DEAN (MaDA, TenDA, DDiemDA)
    VALUES (@MaDeAn, @TenDeAn, @DDiemDA)
END

-- Trường hợp hợp lệ:
EXEC spCheckThemDeAn 17, 'Đề án A', 'Mô tả cho Đề án A', 1;

-- Trường hợp không hợp lệ: Mã đề án đã tồн tại
EXEC spCheckThemDeAn 1, 'Đề án B', 'Mô tả cho Đề án B', 1;

-- Trường hợp không hợp lệ: Mã phòng ban không tồн tại
EXEC spCheckThemDeAn 2;

----CAU7----
CREATE PROCEDURE spXoaDeAn
    @MaDA INT
AS
BEGIN
    IF EXISTS (SELECT * FROM PHANCONG WHERE MaDA = @MaDA)
    BEGIN
        PRINT 'Không thể xóa đề án này vì nó đã được phân công';
        RETURN;
    END

    DELETE FROM DEAN WHERE MaDA = @MaDA;
END

EXEC spXoaDeAn @MaDA = 1;

----CAU8----
CREATE PROCEDURE spXoaDA
    @MaDA INT
AS
BEGIN
    IF EXISTS (SELECT * FROM PHANCONG WHERE MaDA = @MaDA)
    BEGIN
        DELETE FROM PHANCONG WHERE MaDA = @MaDA;
    END

    DELETE FROM DEAN WHERE MaDA = @MaDA;
END

EXEC spXoaDA @MaDA = 17;

----CAU9----
CREATE PROCEDURE spTongGioLamViec
    @MaNV INT,
    @TongGioLamViec INT OUTPUT
AS
BEGIN
    SELECT @TongGioLamViec = SUM(ThoiGian) FROM PHANCONG WHERE MaNV = @MaNV;
END

DECLARE @KetQua INT;

EXEC spTongGioLamViec 1, @KetQua OUTPUT;

SELECT @KetQua AS TongGioLamViec;