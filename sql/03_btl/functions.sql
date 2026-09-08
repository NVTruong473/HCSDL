USE DatabaseLeetCode_BTL;
GO

-- P037 — Average score over all recorded attempts (matches original exercise literally).
CREATE OR ALTER FUNCTION dbo.TinhDiemTrungBinh(@MaSinhVien INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @DiemTB DECIMAL(5,2);
    SELECT @DiemTB = AVG(CAST(Diem AS DECIMAL(10,2)))
    FROM dbo.KetQua WHERE MaSinhVien = @MaSinhVien;
    RETURN @DiemTB;
END;
GO

-- P038 — Count assignments completed using latest attempt only; retries do not double-count.
CREATE OR ALTER FUNCTION dbo.TinhSoMonDaHoanThanh(@MaSinhVien INT)
RETURNS INT
AS
BEGIN
    DECLARE @SoMon INT;
    WITH Latest AS (
        SELECT MaPhanCong, Diem,
               ROW_NUMBER() OVER (PARTITION BY MaPhanCong ORDER BY LanThi DESC) AS rn
        FROM dbo.KetQua WHERE MaSinhVien = @MaSinhVien
    )
    SELECT @SoMon = COUNT(*) FROM Latest WHERE rn = 1 AND Diem >= 5;
    RETURN COALESCE(@SoMon, 0);
END;
GO

-- P039 — Highest score ever achieved.
CREATE OR ALTER FUNCTION dbo.TinhDiemCaoNhat(@MaSinhVien INT)
RETURNS DECIMAL(4,1)
AS
BEGIN
    DECLARE @Diem DECIMAL(4,1);
    SELECT @Diem = MAX(Diem) FROM dbo.KetQua WHERE MaSinhVien = @MaSinhVien;
    RETURN @Diem;
END;
GO

-- P040 — Correct age: subtract one if this year's birthday has not occurred.
CREATE OR ALTER FUNCTION dbo.TinhTuoi(@NgaySinh DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Today DATE = CAST(GETDATE() AS DATE);
    DECLARE @Age INT = DATEDIFF(YEAR, @NgaySinh, @Today);
    IF DATEADD(YEAR, @Age, @NgaySinh) > @Today SET @Age -= 1;
    RETURN @Age;
END;
GO

-- P041 — Has the student passed every assignment they attempted, based on latest attempt?
CREATE OR ALTER FUNCTION dbo.KiemTraSinhVienVuotQua(@MaSinhVien INT)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @Result NVARCHAR(10) = N'Có';
    IF EXISTS (
        SELECT 1
        FROM (
            SELECT MaPhanCong, Diem,
                   ROW_NUMBER() OVER (PARTITION BY MaPhanCong ORDER BY LanThi DESC) AS rn
            FROM dbo.KetQua WHERE MaSinhVien = @MaSinhVien
        ) AS x
        WHERE x.rn = 1 AND x.Diem < 5
    ) SET @Result = N'Không';
    RETURN @Result;
END;
GO
