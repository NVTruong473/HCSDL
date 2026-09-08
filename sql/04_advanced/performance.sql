USE DatabaseLeetCode_BTL;
GO

-- P066 — Cover a common active-student class lookup.
CREATE INDEX IX_SinhVien_MaLop_Active
ON dbo.SinhVien(MaLop,MaSinhVien)
INCLUDE(HoSinhVien,TenSinhVien,HocBong)
WHERE IsDeleted=0;
GO

-- P067 — Filtered index for failed attempts.
CREATE INDEX IX_KetQua_Failed
ON dbo.KetQua(MaSinhVien,MaPhanCong,LanThi)
INCLUDE(Diem)
WHERE Diem<5;
GO

-- P068 — SARGable age/date predicate: transform the constant, not the column.
DECLARE @Today DATE=CAST(GETDATE() AS DATE);
DECLARE @AdultCutoff DATE=DATEADD(YEAR,-18,@Today);
SELECT MaSinhVien,NgaySinh
FROM dbo.SinhVien
WHERE IsDeleted=0 AND NgaySinh<@AdultCutoff;
GO

-- P099 — Index key order follows equality/filter prefix before range/order needs for this workload.
CREATE INDEX IX_PhanCong_ClassYearTerm
ON dbo.PhanCong(MaLop,Nam,HocKy,NgayBatDau)
INCLUDE(MaMonHoc,MaGiaoVien,NgayKetThuc);
GO
