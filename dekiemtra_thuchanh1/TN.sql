-- Tạo login cho trưởng nhóm trưởng nhóm
CREATE LOGIN TruongNhom WITH PASSWORD = '12042002';
GO

-- Tạo user cho trưởng nhóm trưởng nhóm
USE AdventureWorks2008R2;
CREATE USER TruongNhom FOR LOGIN TruongNhom;
GO
