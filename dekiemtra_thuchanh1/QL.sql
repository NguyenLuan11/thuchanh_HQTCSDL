-- Tạo login cho nhân viên QuanLy
CREATE LOGIN QuanLy WITH PASSWORD = '12042002';
GO

-- Tạo user cho nhân viên QL
USE AdventureWorks2008R2;
CREATE USER QuanLy FOR LOGIN QuanLy;
GO
