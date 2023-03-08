-- Tạo login cho nhân viên NV
CREATE LOGIN NhanVien WITH PASSWORD = '12042002';
GO

-- Tạo user cho nhân viên NV
USE AdventureWorks2008R2;
CREATE USER NhanVien FOR LOGIN NhanVien;
GO