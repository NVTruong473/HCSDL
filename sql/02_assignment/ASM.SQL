/*
  Original name preserved: ASM.SQL
  Refactored track: P013-P016
*/

IF DB_ID(N'DatabaseLeetCode_Assignment') IS NULL
    EXEC(N'CREATE DATABASE DatabaseLeetCode_Assignment');
GO
USE DatabaseLeetCode_Assignment;
GO

DROP TABLE IF EXISTS dbo.KetQua;
DROP TABLE IF EXISTS dbo.LopHoc;
DROP TABLE IF EXISTS dbo.SinhVien;
DROP TABLE IF EXISTS dbo.MonHoc;
DROP TABLE IF EXISTS dbo.NganhHoc;
DROP TABLE IF EXISTS dbo.Khoa;
IF OBJECT_ID(N'dbo.StudentCodeSeq', N'SO') IS NOT NULL DROP SEQUENCE dbo.StudentCodeSeq;
GO

-- P013 — Create the university relational schema.
CREATE TABLE dbo.Khoa (
    MaKhoa   CHAR(4)        NOT NULL CONSTRAINT PK_Khoa PRIMARY KEY,
    TenKhoa  NVARCHAR(100)  NOT NULL,
    DiaChi   NVARCHAR(255)  NULL
);

CREATE TABLE dbo.NganhHoc (
    MaNganh  CHAR(6)        NOT NULL CONSTRAINT PK_NganhHoc PRIMARY KEY,
    TenNganh NVARCHAR(100)  NOT NULL,
    MaKhoa   CHAR(4)        NOT NULL,
    CONSTRAINT FK_NganhHoc_Khoa FOREIGN KEY (MaKhoa) REFERENCES dbo.Khoa(MaKhoa)
);

CREATE TABLE dbo.MonHoc (
    MaMon    CHAR(6)        NOT NULL CONSTRAINT PK_MonHoc PRIMARY KEY,
    TenMon   NVARCHAR(100)  NOT NULL,
    SoTinChi TINYINT        NOT NULL,
    CONSTRAINT CK_MonHoc_SoTinChi CHECK (SoTinChi BETWEEN 1 AND 10)
);

CREATE TABLE dbo.LopHoc (
    MaLop     CHAR(6)        NOT NULL CONSTRAINT PK_LopHoc PRIMARY KEY,
    TenLop    NVARCHAR(100)  NOT NULL,
    MaMon     CHAR(6)        NOT NULL,
    GiaoVien  NVARCHAR(100)  NOT NULL,
    CONSTRAINT FK_LopHoc_MonHoc FOREIGN KEY (MaMon) REFERENCES dbo.MonHoc(MaMon)
);

CREATE TABLE dbo.SinhVien (
    MSSV      CHAR(6)        NOT NULL CONSTRAINT PK_SinhVien PRIMARY KEY,
    HoTen     NVARCHAR(100)  NOT NULL,
    NgaySinh  DATE           NOT NULL,
    GioiTinh  NVARCHAR(10)   NULL,
    DiaChi    NVARCHAR(255)  NULL,
    MaNganh   CHAR(6)        NOT NULL,
    CONSTRAINT FK_SinhVien_NganhHoc FOREIGN KEY (MaNganh) REFERENCES dbo.NganhHoc(MaNganh)
);

CREATE TABLE dbo.KetQua (
    MSSV   CHAR(6)       NOT NULL,
    MaMon  CHAR(6)       NOT NULL,
    Diem   DECIMAL(4,2)  NOT NULL,
    CONSTRAINT PK_KetQua PRIMARY KEY (MSSV, MaMon),
    CONSTRAINT FK_KetQua_SinhVien FOREIGN KEY (MSSV) REFERENCES dbo.SinhVien(MSSV),
    CONSTRAINT FK_KetQua_MonHoc FOREIGN KEY (MaMon) REFERENCES dbo.MonHoc(MaMon),
    CONSTRAINT CK_KetQua_Diem CHECK (Diem BETWEEN 0 AND 10)
);
GO

CREATE SEQUENCE dbo.StudentCodeSeq AS INT START WITH 1001 INCREMENT BY 1;
GO

-- P014 — Add a student with an automatically generated SVxxxx code, without IDENTITY.
CREATE OR ALTER PROCEDURE dbo.AddSinhVien
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(10),
    @DiaChi NVARCHAR(255),
    @MaNganh CHAR(6),
    @NewMSSV CHAR(6) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE @n INT = NEXT VALUE FOR dbo.StudentCodeSeq;
    IF @n > 9999 THROW 50001, 'Student code sequence exhausted for SVxxxx format.', 1;

    SET @NewMSSV = 'SV' + RIGHT('0000' + CONVERT(VARCHAR(4), @n), 4);

    INSERT dbo.SinhVien (MSSV, HoTen, NgaySinh, GioiTinh, DiaChi, MaNganh)
    VALUES (@NewMSSV, @HoTen, @NgaySinh, @GioiTinh, @DiaChi, @MaNganh);
END;
GO

-- P015 — Insert/update one subject result safely.
CREATE OR ALTER PROCEDURE dbo.AddKetQua
    @MSSV CHAR(6),
    @MaMon CHAR(6),
    @Diem DECIMAL(4,2)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF @Diem NOT BETWEEN 0 AND 10
        THROW 50002, 'Diem must be between 0 and 10.', 1;

    INSERT dbo.KetQua (MSSV, MaMon, Diem)
    VALUES (@MSSV, @MaMon, @Diem);
END;
GO

-- P016 — Trigger exercise: reject invalid score batches.
-- The CHECK constraint above is still the primary integrity rule.
CREATE OR ALTER TRIGGER dbo.KiemTraDiem
ON dbo.KetQua
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM inserted WHERE Diem < 0 OR Diem > 10)
        THROW 50003, 'Diem must be between 0 and 10.', 1;
END;
GO
