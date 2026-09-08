USE DatabaseLeetCode_BTL;
GO

-- P042 — Add student.
CREATE OR ALTER PROCEDURE dbo.ThemSinhVien
    @MaSinhVien INT, @HoSinhVien NVARCHAR(100), @TenSinhVien NVARCHAR(100), @MaLop INT,
    @Phai BIT, @NgaySinh DATE, @DiaChi NVARCHAR(200), @MaQueQuan INT,
    @MaDanToc INT, @MaTonGiao INT, @HocBong DECIMAL(12,2)
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    INSERT dbo.SinhVien (MaSinhVien,HoSinhVien,TenSinhVien,MaLop,Phai,NgaySinh,DiaChi,MaQueQuan,MaDanToc,MaTonGiao,HocBong)
    VALUES (@MaSinhVien,@HoSinhVien,@TenSinhVien,@MaLop,@Phai,@NgaySinh,@DiaChi,@MaQueQuan,@MaDanToc,@MaTonGiao,@HocBong);
END;
GO

-- P043 — Update student.
CREATE OR ALTER PROCEDURE dbo.CapNhatSinhVien
    @MaSinhVien INT, @HoSinhVien NVARCHAR(100), @TenSinhVien NVARCHAR(100), @MaLop INT,
    @Phai BIT, @NgaySinh DATE, @DiaChi NVARCHAR(200), @MaQueQuan INT,
    @MaDanToc INT, @MaTonGiao INT, @HocBong DECIMAL(12,2)
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    UPDATE dbo.SinhVien SET HoSinhVien=@HoSinhVien, TenSinhVien=@TenSinhVien, MaLop=@MaLop,
        Phai=@Phai, NgaySinh=@NgaySinh, DiaChi=@DiaChi, MaQueQuan=@MaQueQuan,
        MaDanToc=@MaDanToc, MaTonGiao=@MaTonGiao, HocBong=@HocBong
    WHERE MaSinhVien=@MaSinhVien AND IsDeleted=0;
    IF @@ROWCOUNT = 0 THROW 51001, 'Student not found or already deleted.', 1;
END;
GO

-- P044 — Hard-delete student only when explicitly requested by the original exercise.
CREATE OR ALTER PROCEDURE dbo.XoaSinhVien @MaSinhVien INT
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    DELETE dbo.SinhVien WHERE MaSinhVien=@MaSinhVien;
END;
GO

-- P045 — Add subject.
CREATE OR ALTER PROCEDURE dbo.ThemMonHoc
    @MaMonHoc INT, @TenMonHoc NVARCHAR(100), @SoTietLyThuyet SMALLINT, @SoTietThucHanh SMALLINT
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    INSERT dbo.MonHoc VALUES (@MaMonHoc,@TenMonHoc,@SoTietLyThuyet,@SoTietThucHanh);
END;
GO

-- P046 — Update one exam result.
CREATE OR ALTER PROCEDURE dbo.CapNhatKetQuaThi
    @MaPhanCong INT, @MaSinhVien INT, @LanThi TINYINT, @Diem DECIMAL(4,1), @GhiChu NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    UPDATE dbo.KetQua SET Diem=@Diem, GhiChu=@GhiChu
    WHERE MaPhanCong=@MaPhanCong AND MaSinhVien=@MaSinhVien AND LanThi=@LanThi;
    IF @@ROWCOUNT = 0 THROW 51002, 'Result row not found.', 1;
END;
GO

-- P047 — Add teacher.
CREATE OR ALTER PROCEDURE dbo.ThemGiaoVien
    @MaGiaoVien INT, @TenGiaoVien NVARCHAR(100), @Phai BIT, @NgaySinh DATE,
    @SoDienThoai VARCHAR(15), @DiaChi NVARCHAR(200), @Email VARCHAR(254),
    @MaQueQuan INT, @MaDanToc INT, @MaTonGiao INT
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    INSERT dbo.GiaoVien VALUES (@MaGiaoVien,@TenGiaoVien,@Phai,@NgaySinh,@SoDienThoai,@DiaChi,@Email,@MaQueQuan,@MaDanToc,@MaTonGiao);
END;
GO

-- P048 — Assign subject to teacher and class.
CREATE OR ALTER PROCEDURE dbo.PhanCongMonHoc
    @MaPhanCong INT, @MaMonHoc INT, @MaGiaoVien INT, @MaLop INT,
    @HocKy TINYINT, @Nam SMALLINT, @NgayBatDau DATE, @NgayKetThuc DATE
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    INSERT dbo.PhanCong VALUES (@MaPhanCong,@MaMonHoc,@MaGiaoVien,@MaLop,@HocKy,@Nam,@NgayBatDau,@NgayKetThuc);
END;
GO
