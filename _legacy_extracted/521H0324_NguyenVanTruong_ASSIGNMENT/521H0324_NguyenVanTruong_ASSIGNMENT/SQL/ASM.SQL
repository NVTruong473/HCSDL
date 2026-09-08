-- CREATE DATABASE ASM;
-- GO

-- 4. Sử dụng câu lệnh SQL để thực hiện các thao tác sau:
-- a.	Tạo các bảng cho mô hình quan hệ trên (0.5 điểm)

-- Bảng Khoa
CREATE TABLE Khoa (
    MaKhoa CHAR(4) PRIMARY KEY,
    TenKhoa NVARCHAR(100),
    DiaChi NVARCHAR(255)
);
GO

-- Bảng Ngành học
CREATE TABLE NganhHoc (
    MaNganh CHAR(6) PRIMARY KEY,
    TenNganh NVARCHAR(100),
    MaKhoa CHAR(4),
    FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa)
);
GO

-- Bảng Môn học
CREATE TABLE MonHoc (
    MaMon CHAR(6) PRIMARY KEY,
    TenMon NVARCHAR(100),
    SoTinChi INT
);
GO


-- Bảng Lớp học
CREATE TABLE LopHoc (
    MaLop CHAR(6) PRIMARY KEY,
    TenLop NVARCHAR(100),
    MaMon CHAR(6),
    GiaoVien NVARCHAR(100),
    FOREIGN KEY (MaMon) REFERENCES MonHoc(MaMon)
);
GO

-- Bảng Sinh viên
CREATE TABLE SinhVien (
    MSSV CHAR(8) PRIMARY KEY,
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    DiaChi NVARCHAR(255),
    MaNganh CHAR(6),
    FOREIGN KEY (MaNganh) REFERENCES NganhHoc(MaNganh)
);
GO



-- Bảng Kết quả học tập
CREATE TABLE KetQua (
    MSSV CHAR(8),
    MaMon CHAR(6),
    Diem FLOAT,
    PRIMARY KEY (MSSV, MaMon),
    FOREIGN KEY (MSSV) REFERENCES SinhVien(MSSV),
    FOREIGN KEY (MaMon) REFERENCES MonHoc(MaMon)
);
GO



-- b.	Tạo ít nhất 2 function để thêm dữ liệu vào các bảng trên. (1 điểm)
-- i.	Trong đó, khoá chính của các bảng phải được phát sinh tự động theo một quy tắc nào đó. Ví dụ Mô hình quan hệ có bảng Sinh viên, khoá chính là Mã số sinh viên gồm 2 ký tự đầu là “SV”, 4 ký tự sau là số (thể hiện số thứ tự). Ví dụ Bảng sinh viên đang có Mã số sinh viên lớn nhất là “SV1010” thì khi thêm sinh viên mới sẽ có mã số là “SV1011”. 
-- ii.	Sinh viên tự đặt ra quy tắc phát sinh
-- iii.	KHÔNG được sử dụng Identity trong SQL Server để phát sinh tự động.


--  P/S: vì function không insert value vô bảng được nên sử dụng procedure

-- Procedure thêm sinh viên
CREATE PROCEDURE AddSinhVien (
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(10),
    @DiaChi NVARCHAR(255),
    @MaNganh CHAR(6)
)
AS
BEGIN
    DECLARE @NewMSSV CHAR(8)
    
    -- Find the current maximum MSSV
    SELECT @NewMSSV = 'SV' + RIGHT('0000' + CAST(CAST(SUBSTRING(MAX(MSSV), 3, 4) AS INT) + 1 AS VARCHAR), 4)
    FROM SinhVien
    
    -- Insert the new SinhVien
    INSERT INTO SinhVien (MSSV, HoTen, NgaySinh, GioiTinh, DiaChi, MaNganh)
    VALUES (@NewMSSV, @HoTen, @NgaySinh, @GioiTinh, @DiaChi, @MaNganh)
END;
GO

-- Procedure thêm kết quả
CREATE PROCEDURE AddKetQua (
    @MSSV CHAR(8),
    @MaMon CHAR(6),
    @Diem FLOAT
)
AS
BEGIN
    -- Insert the new KetQua
    INSERT INTO KetQua (MSSV, MaMon, Diem)
    VALUES (@MSSV, @MaMon, @Diem)
END;
GO

-- c.	Tạo ít nhất một trigger để kiểm tra ràng buộc khoá ngoại, ràng buộc miền giá trị. (0.5 điểm)
-- Trigger kiểm tra ràng buộc điểm
CREATE TRIGGER KiemTraDiem
ON KetQua
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM Inserted WHERE Diem < 0 OR Diem > 10)
    BEGIN
        RAISERROR ('Diem nam trong khoang 0-10', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

