/*
  Anonymized legacy hospital coursework
  Refactored track: P001-P006
  Dialect: SQL Server / T-SQL
*/

IF DB_ID(N'DatabaseLeetCode_Hospital') IS NULL
    EXEC(N'CREATE DATABASE DatabaseLeetCode_Hospital');
GO
USE DatabaseLeetCode_Hospital;
GO

DROP TABLE IF EXISTS dbo.Chi_Tiet_PTN;
DROP TABLE IF EXISTS dbo.Khu_Dieu_Tri;
DROP TABLE IF EXISTS dbo.KT_Vien;
DROP TABLE IF EXISTS dbo.Y_Si;
DROP TABLE IF EXISTS dbo.Y_Ta;
DROP TABLE IF EXISTS dbo.NVVP;
DROP TABLE IF EXISTS dbo.PTN;
DROP TABLE IF EXISTS dbo.Benh_Nhan;
DROP TABLE IF EXISTS dbo.Nhan_Vien;
GO

-- P001 — Build the hospital relational schema.
CREATE TABLE dbo.Nhan_Vien (
    MaNV          VARCHAR(10)   NOT NULL CONSTRAINT PK_NhanVien PRIMARY KEY,
    HoTen         NVARCHAR(100) NOT NULL,
    NgaySinh      DATE          NOT NULL,
    DiaChi        NVARCHAR(100) NOT NULL,
    SoDienThoai   VARCHAR(20)   NOT NULL CONSTRAINT UQ_NhanVien_SDT UNIQUE,
    CONSTRAINT CK_NhanVien_NgaySinh CHECK (NgaySinh < CAST(GETDATE() AS DATE))
);

CREATE TABLE dbo.NVVP (
    MaNV      VARCHAR(10)   NOT NULL CONSTRAINT PK_NVVP PRIMARY KEY,
    LoaiCV    NVARCHAR(100) NOT NULL,
    CONSTRAINT FK_NVVP_NhanVien FOREIGN KEY (MaNV) REFERENCES dbo.Nhan_Vien(MaNV)
);

CREATE TABLE dbo.Y_Ta (
    MaNV       VARCHAR(10)   NOT NULL CONSTRAINT PK_YTa PRIMARY KEY,
    MSCC       VARCHAR(20)   NOT NULL CONSTRAINT UQ_YTa_MSCC UNIQUE,
    TenKDT     NVARCHAR(100) NOT NULL,
    CONSTRAINT FK_YTa_NhanVien FOREIGN KEY (MaNV) REFERENCES dbo.Nhan_Vien(MaNV)
);

CREATE TABLE dbo.Benh_Nhan (
    MaSo          VARCHAR(10)   NOT NULL CONSTRAINT PK_BenhNhan PRIMARY KEY,
    DiaChi        NVARCHAR(100) NOT NULL,
    NgayNhapVien  DATE          NOT NULL
);

CREATE TABLE dbo.Y_Si (
    MaNV          VARCHAR(10)   NOT NULL CONSTRAINT PK_YSi PRIMARY KEY,
    ChuyenNganh   NVARCHAR(100) NOT NULL,
    MaBN          VARCHAR(10)   NULL,
    CONSTRAINT FK_YSi_NhanVien FOREIGN KEY (MaNV) REFERENCES dbo.Nhan_Vien(MaNV),
    CONSTRAINT FK_YSi_BenhNhan FOREIGN KEY (MaBN) REFERENCES dbo.Benh_Nhan(MaSo)
);

CREATE TABLE dbo.KT_Vien (
    MaNV      VARCHAR(10)   NOT NULL CONSTRAINT PK_KTVien PRIMARY KEY,
    KyNang    NVARCHAR(100) NOT NULL,
    CONSTRAINT FK_KTVien_NhanVien FOREIGN KEY (MaNV) REFERENCES dbo.Nhan_Vien(MaNV)
);

CREATE TABLE dbo.PTN (
    Ten       VARCHAR(20)   NOT NULL CONSTRAINT PK_PTN PRIMARY KEY,
    DiaDiem   NVARCHAR(100) NOT NULL
);

CREATE TABLE dbo.Khu_Dieu_Tri (
    Ten       NVARCHAR(100) NOT NULL CONSTRAINT PK_KhuDieuTri PRIMARY KEY,
    DiaDiem   NVARCHAR(100) NOT NULL,
    MaYT      VARCHAR(10)   NOT NULL,
    CONSTRAINT FK_KhuDieuTri_YTa FOREIGN KEY (MaYT) REFERENCES dbo.Y_Ta(MaNV)
);

CREATE TABLE dbo.Chi_Tiet_PTN (
    MaNV      VARCHAR(10) NOT NULL,
    TenPTN    VARCHAR(20) NOT NULL,
    CONSTRAINT PK_ChiTietPTN PRIMARY KEY (MaNV, TenPTN),
    CONSTRAINT FK_ChiTietPTN_NhanVien FOREIGN KEY (MaNV) REFERENCES dbo.Nhan_Vien(MaNV),
    CONSTRAINT FK_ChiTietPTN_PTN FOREIGN KEY (TenPTN) REFERENCES dbo.PTN(Ten)
);
GO

INSERT dbo.Nhan_Vien (MaNV, HoTen, NgaySinh, DiaChi, SoDienThoai) VALUES
('NV01', N'Nguyen Van An',     '1998-07-08', N'TPHCM', '0900000001'),
('NV02', N'Nguyen Thi Binh',   '1997-11-09', N'TPHCM', '0900000002'),
('NV03', N'Le Minh Chau',      '1996-07-29', N'TPHCM', '0900000003'),
('NV04', N'Bui Gia Dung',      '1995-04-19', N'Dong Nai', '0900000004'),
('NV05', N'Tran Ha Giang',     '1994-11-16', N'Binh Thuan', '0900000005'),
('NV06', N'Nguyen Minh Hoa',   '2010-09-20', N'TPHCM', '0900000006');

INSERT dbo.Benh_Nhan (MaSo, DiaChi, NgayNhapVien) VALUES
('BN01', N'TPHCM', '2022-01-02'),
('BN02', N'TPHCM', '2022-03-02'),
('BN03', N'BR-VT', '2022-06-03'),
('BN04', N'Dong Nai', '2022-03-28'),
('BN05', N'Binh Thuan', '2022-01-04');

INSERT dbo.NVVP (MaNV, LoaiCV) VALUES ('NV04', N'Quan ly camera');
INSERT dbo.Y_Ta (MaNV, MSCC, TenKDT) VALUES
('NV01', 'CC01', N'Khoa Ngoai'), ('NV02', 'CC02', N'Khoa Da Lieu');
INSERT dbo.Y_Si (MaNV, ChuyenNganh, MaBN) VALUES
('NV03', N'Nhan khoa', 'BN01'), ('NV05', N'San khoa', 'BN02');
INSERT dbo.KT_Vien (MaNV, KyNang) VALUES ('NV04', N'Xet nghiem');
INSERT dbo.Khu_Dieu_Tri (Ten, DiaDiem, MaYT) VALUES
(N'Khoa Ngoai', N'Khu A', 'NV01'), (N'Khoa Da Lieu', N'Khu B', 'NV02');
INSERT dbo.PTN (Ten, DiaDiem) VALUES ('A1', N'Khu A'), ('A2', N'Khu A'), ('B1', N'Khu B');
INSERT dbo.Chi_Tiet_PTN (MaNV, TenPTN) VALUES ('NV03', 'A1'), ('NV04', 'A2');
GO

-- P002 — Employees whose surname starts with Nguyen AND whose address is TPHCM.
SELECT nv.MaNV, nv.HoTen
FROM dbo.Nhan_Vien AS nv
WHERE nv.HoTen LIKE N'Nguyen%'
  AND nv.DiaChi = N'TPHCM';

-- P003 — Patients not currently referenced by any doctor.
SELECT bn.*
FROM dbo.Benh_Nhan AS bn
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Y_Si AS ys
    WHERE ys.MaBN = bn.MaSo
);

-- P004 — Patients living in TPHCM.
SELECT *
FROM dbo.Benh_Nhan
WHERE DiaChi = N'TPHCM';

-- P005 — Employees with surname Nguyen and strictly older than 18.
SELECT nv.*
FROM dbo.Nhan_Vien AS nv
WHERE nv.HoTen LIKE N'Nguyen%'
  AND DATEADD(YEAR, 18, nv.NgaySinh) < CAST(GETDATE() AS DATE);

-- P006 — Employees who are nurses.
SELECT nv.MaNV, nv.HoTen
FROM dbo.Nhan_Vien AS nv
WHERE EXISTS (
    SELECT 1 FROM dbo.Y_Ta AS yt WHERE yt.MaNV = nv.MaNV
);
GO
