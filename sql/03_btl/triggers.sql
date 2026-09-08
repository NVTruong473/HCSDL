USE DatabaseLeetCode_BTL;
GO

-- P049 — Scholarship validation, set-based and multi-row safe.
-- A CHECK constraint enforces non-negative values; this trigger demonstrates an upper policy cap.
CREATE OR ALTER TRIGGER dbo.CheckHocBongSinhVien
ON dbo.SinhVien
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM inserted WHERE HocBong > 10000000)
        THROW 52001, 'HocBong exceeds the configured maximum of 10,000,000.', 1;
END;
GO

-- P050 — Audit course-hour changes for any number of updated rows.
DROP TABLE IF EXISTS dbo.MonHocAudit;
CREATE TABLE dbo.MonHocAudit (
    AuditID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_MonHocAudit PRIMARY KEY,
    MaMonHoc INT NOT NULL,
    OldLyThuyet SMALLINT NOT NULL,
    NewLyThuyet SMALLINT NOT NULL,
    OldThucHanh SMALLINT NOT NULL,
    NewThucHanh SMALLINT NOT NULL,
    ChangedAt DATETIME2(0) NOT NULL CONSTRAINT DF_MonHocAudit_ChangedAt DEFAULT SYSUTCDATETIME()
);
GO
CREATE OR ALTER TRIGGER dbo.CapNhatSoTietMonHoc
ON dbo.MonHoc
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT (UPDATE(SoTietLyThuyet) OR UPDATE(SoTietThucHanh)) RETURN;
    INSERT dbo.MonHocAudit (MaMonHoc,OldLyThuyet,NewLyThuyet,OldThucHanh,NewThucHanh)
    SELECT i.MaMonHoc,d.SoTietLyThuyet,i.SoTietLyThuyet,d.SoTietThucHanh,i.SoTietThucHanh
    FROM inserted AS i JOIN deleted AS d ON d.MaMonHoc=i.MaMonHoc
    WHERE i.SoTietLyThuyet<>d.SoTietLyThuyet OR i.SoTietThucHanh<>d.SoTietThucHanh;
END;
GO

-- P051 — Delete grade rows when students are hard-deleted; handles a batch delete.
CREATE OR ALTER TRIGGER dbo.XoaKetQuaThiKhiXoaSinhVien
ON dbo.SinhVien
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DELETE kq FROM dbo.KetQua AS kq JOIN deleted AS d ON d.MaSinhVien=kq.MaSinhVien;
    DELETE sv FROM dbo.SinhVien AS sv JOIN deleted AS d ON d.MaSinhVien=sv.MaSinhVien;
END;
GO
