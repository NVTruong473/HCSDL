CREATE DATABASE BTL2;
GO

-- Tạo bảng Môn học
CREATE TABLE MonHoc (
    MaMonHoc INT PRIMARY KEY,
    TenMonHoc VARCHAR(100),
    SoTietLyThuyet INT,
    SoTietThucHanh INT
);
go

-- Tạo bảng Dân tộc
CREATE TABLE DanToc (
    MaDanToc INT PRIMARY KEY,
    TenDanToc VARCHAR(100)
);
GO

-- Tạo bảng Tôn giáo
CREATE TABLE TonGiao (
    MaTonGiao INT PRIMARY KEY,
    TenTonGiao VARCHAR(100)
);
go

-- Tạo bảng Quê quán
CREATE TABLE QueQuan (
    MaQueQuan INT PRIMARY KEY,
    TenTinhThanhPho VARCHAR(100),
    TenQuanHuyen VARCHAR(100),
    TenPhuongXa VARCHAR(100)
);
go


-- Tạo bảng Giáo viên
CREATE TABLE GiaoVien (
    MaGiaoVien INT PRIMARY KEY,
    TenGiaoVien VARCHAR(100),
    Phai BIT,
    NgaySinh DATE,
    SoDienThoai VARCHAR(15),
    DiaChi VARCHAR(200),
    Email VARCHAR(100),
    MaQueQuan INT,
    MaDanToc INT,
    MaTonGiao INT,
    FOREIGN KEY (MaQueQuan) REFERENCES QueQuan(MaQueQuan),
    FOREIGN KEY (MaDanToc) REFERENCES DanToc(MaDanToc),
    FOREIGN KEY (MaTonGiao) REFERENCES TonGiao(MaTonGiao)
);
go

-- Tạo bảng Lớp
CREATE TABLE Lop (
    MaLop INT PRIMARY KEY,
    TenLop VARCHAR(100),
    MaNganhHoc VARCHAR(100),
    MaGVCN INT,
    FOREIGN KEY (MaGVCN) REFERENCES GiaoVien(MaGiaoVien)
);
GO

-- Tạo bảng Sinh viên
CREATE TABLE SinhVien (
    MaSinhVien INT PRIMARY KEY,
    HoSinhVien VARCHAR(100),
    TenSinhVien VARCHAR(100),
    MaLop INT,
    Phai BIT,
    NgaySinh DATE,
    DiaChi VARCHAR(200),
    MaQueQuan INT,
    MaDanToc INT,
    MaTonGiao INT,
    HocBong DECIMAL(10, 2),
    FOREIGN KEY (MaLop) REFERENCES Lop(MaLop),
    FOREIGN KEY (MaQueQuan) REFERENCES QueQuan(MaQueQuan),
    FOREIGN KEY (MaDanToc) REFERENCES DanToc(MaDanToc),
    FOREIGN KEY (MaTonGiao) REFERENCES TonGiao(MaTonGiao)
);
go

-- Tạo bảng Phân công
CREATE TABLE PhanCong (
    MaPhanCong INT PRIMARY KEY,
    MaMonHoc INT,
    MaGiaoVien INT,
    MaLop INT,
    HocKy INT,
    Nam INT,
    NgayBatDau DATE,
    NgayKetThuc DATE,
    FOREIGN KEY (MaMonHoc) REFERENCES MonHoc(MaMonHoc),
    FOREIGN KEY (MaGiaoVien) REFERENCES GiaoVien(MaGiaoVien),
    FOREIGN KEY (MaLop) REFERENCES Lop(MaLop)
);
go

CREATE TABLE KetQua (
    MaPhanCong INT,
    MaSinhVien INT,
    LanThi INT,
    Diem DECIMAL(3, 1),
    GhiChu VARCHAR(200),
    PRIMARY KEY (MaPhanCong, MaSinhVien, LanThi),
    FOREIGN KEY (MaPhanCong) REFERENCES PhanCong(MaPhanCong),
    FOREIGN KEY (MaSinhVien) REFERENCES SinhVien(MaSinhVien)
);
go

-- INSERT data into table
-- Sử dụng cơ sở dữ liệu BTL

-- 1. Chèn dữ liệu vào bảng DanToc
INSERT INTO DanToc (MaDanToc, TenDanToc) 
VALUES 
    (1, 'Kinh'), 
    (2, 'Tày'), 
    (3, 'Thái'), 
    (4, 'Mường'), 
    (5, 'Nùng');
GO


-- 2. Chèn dữ liệu vào bảng TonGiao
INSERT INTO TonGiao (MaTonGiao, TenTonGiao) 
VALUES 
    (1, 'Không'), 
    (2, 'Phật Giáo'), 
    (3, 'Thiên Chúa Giáo'), 
    (4, 'Cao Đài'), 
    (5, 'Hòa Hảo');
GO

-- 3. Chèn dữ liệu vào bảng QueQuan
INSERT INTO QueQuan (MaQueQuan, TenTinhThanhPho, TenQuanHuyen, TenPhuongXa)
VALUES
    (1, 'Hà Nội', 'Ba Đình', 'Phường Giảng Võ'),
    (2, 'Hà Nội', 'Hoàn Kiếm', 'Phường Nguyễn Du'),
    (3, 'TP. Hồ Chí Minh', 'Quận 1', 'Phường Bến Nghé'),
    (4, 'Đà Nẵng', 'Quận Hải Châu', 'Phường Thạch Thang'),
    (5, 'Hải Phòng', 'Quận Lê Chân', 'Phường Dư Hàng Kênh');
GO

-- 4. Chèn dữ liệu vào bảng MonHoc
INSERT INTO MonHoc (MaMonHoc, TenMonHoc, SoTietLyThuyet, SoTietThucHanh)
VALUES
    (1, 'Toán Đại Cương', 45, 15),
    (2, 'Vật Lý Cơ Bản', 40, 20),
    (3, 'Hóa Học', 35, 25),
    (4, 'Lập Trình Cơ Bản', 30, 30),
    (5, 'Giáo dục Quốc phòng', 20, 10);
GO

-- 5. Chèn dữ liệu vào bảng GiaoVien
INSERT INTO GiaoVien (MaGiaoVien, TenGiaoVien, Phai, NgaySinh, SoDienThoai, DiaChi, Email, MaQueQuan, MaDanToc, MaTonGiao)
VALUES
    (1, 'Nguyễn Văn A', 1, '1980-05-15', '0909123456', '123 Đường A, Phường Giảng Võ, Hà Nội', 'nguyenvana@example.com', 1, 1, 2),
    (2, 'Trần Thị B', 0, '1985-08-22', '0918123456', '456 Đường B, Phường Nguyễn Du, Hà Nội', 'tranthib@example.com', 2, 2, 1),
    (3, 'Lê Văn C', 1, '1975-12-10', '0927123456', '789 Đường C, Phường Bến Nghé, TP. Hồ Chí Minh', 'levanc@example.com', 3, 3, 3),
    (4, 'Phạm Thị D', 0, '1990-03-05', '0936123456', '321 Đường D, Phường Thạch Thang, Đà Nẵng', 'phamthid@example.com', 4, 4, 4),
    (5, 'Hoàng Văn E', 1, '1982-07-18', '0945123456', '654 Đường E, Phường Dư Hàng Kênh, Hải Phòng', 'hoangvane@example.com', 5, 5, 5);
GO


-- 6. Chèn dữ liệu vào bảng Lop
INSERT INTO Lop (MaLop, TenLop, MaNganhHoc, MaGVCN)
VALUES
    (1, 'Lớp 10A1', 'CNTT', 1),
    (2, 'Lớp 10A2', 'CNTT', 2),
    (3, 'Lớp 10B1', 'Vật Lý', 3),
    (4, 'Lớp 10B2', 'Hóa Học', 4),
    (5, 'Lớp 10C1', 'Toán', 5);
GO

-- 7. Chèn dữ liệu vào bảng SinhVien
INSERT INTO SinhVien (MaSinhVien, HoSinhVien, TenSinhVien, MaLop, Phai, NgaySinh, DiaChi, MaQueQuan, MaDanToc, MaTonGiao, HocBong)
VALUES
    (1, 'Nguyễn Văn', 'Anh', 1, 1, '2005-01-10', 'Hà Nội', 1, 1, 2, 6000000.00),
    (2, 'Trần Thị', 'Bích', 1, 0, '2005-02-20', 'Hà Nội', 2, 2, 1, 3000000.00),
    (3, 'Lê Văn', 'Cường', 2, 1, '2005-03-15', 'TP. Hồ Chí Minh', 3, 3, 3, 0.00),
    (4, 'Phạm Thị', 'Diễm', 2, 0, '2005-04-25', 'Đà Nẵng', 4, 4, 4, 4500000.00),
    (5, 'Hoàng Văn', 'Em', 3, 1, '2005-05-30', 'Hải Phòng', 5, 5, 5, 7000000.00),
    (6, 'Nguyễn Văn', 'F', 3, 1, '2005-06-18', 'Hà Nội', 1, 1, 2, 0.00),
    (7, 'Trần Thị', 'G', 4, 0, '2005-07-22', 'Hà Nội', 2, 2, 1, 2000000.00),
    (8, 'Lê Văn', 'H', 4, 1, '2005-08-14', 'TP. Hồ Chí Minh', 3, 3, 3, 5000000.00),
    (9, 'Phạm Thị', 'I', 5, 0, '2005-09-09', 'Đà Nẵng', 4, 4, 4, 0.00),
    (10, 'Hoàng Văn', 'J', 5, 1, '2005-10-01', 'Hải Phòng', 5, 5, 5, 8000000.00);
GO


-- 8. Chèn dữ liệu vào bảng PhanCong
INSERT INTO PhanCong (MaPhanCong, MaMonHoc, MaGiaoVien, MaLop, HocKy, Nam, NgayBatDau, NgayKetThuc)
VALUES
    (1, 1, 1, 1, 1, 2024, '2024-09-01', '2024-12-20'),
    (2, 2, 3, 1, 1, 2024, '2024-09-01', '2024-12-20'),
    (3, 4, 2, 2, 1, 2024, '2024-09-01', '2024-12-20'),
    (4, 3, 4, 3, 1, 2024, '2024-09-01', '2024-12-20'),
    (5, 5, 5, 4, 1, 2024, '2024-09-01', '2024-12-20'),
    (6, 4, 1, 5, 1, 2024, '2024-09-01', '2024-12-20');
GO

-- 9. Chèn dữ liệu vào bảng KetQua
INSERT INTO KetQua (MaPhanCong, MaSinhVien, LanThi, Diem, GhiChu)
VALUES
    -- Kết quả cho MaPhanCong = 1 (Toán Đại Cương)
    (1, 1, 1, 8.5, 'Đạt'),
    (1, 2, 1, 6.0, 'Đạt'),
    (1, 3, 1, 4.5, 'Không đạt'),
    (1, 4, 1, 7.0, 'Đạt'),
    (1, 5, 1, 9.0, 'Đạt'),
    (1, 6, 1, 5.5, 'Đạt'),
    (1, 7, 1, 3.0, 'Không đạt'),
    (1, 8, 1, 7.5, 'Đạt'),
    (1, 9, 1, 4.0, 'Không đạt'),
    (1, 10, 1, 8.0, 'Đạt'),

    -- Kết quả cho MaPhanCong = 2 (Vật Lý Cơ Bản)
    (2, 1, 1, 7.0, 'Đạt'),
    (2, 2, 1, 5.5, 'Đạt'),
    (2, 3, 1, 6.0, 'Đạt'),
    (2, 4, 1, 8.0, 'Đạt'),
    (2, 5, 1, 7.5, 'Đạt'),
    (2, 6, 1, 4.5, 'Không đạt'),
    (2, 7, 1, 5.0, 'Đạt'),
    (2, 8, 1, 6.5, 'Đạt'),
    (2, 9, 1, 3.5, 'Không đạt'),
    (2, 10, 1, 7.0, 'Đạt'),

    -- Kết quả cho MaPhanCong = 3 (Lập Trình Cơ Bản)
    (3, 1, 1, 9.0, 'Đạt'),
    (3, 2, 1, 8.5, 'Đạt'),
    (3, 3, 1, 7.0, 'Đạt'),
    (3, 4, 1, 6.5, 'Đạt'),
    (3, 5, 1, 8.0, 'Đạt'),
    (3, 6, 1, 5.5, 'Đạt'),
    (3, 7, 1, 4.0, 'Không đạt'),
    (3, 8, 1, 7.5, 'Đạt'),
    (3, 9, 1, 6.0, 'Đạt'),
    (3, 10, 1, 9.0, 'Đạt'),

    -- Kết quả cho MaPhanCong = 4 (Hóa Học)
    (4, 1, 1, 6.5, 'Đạt'),
    (4, 2, 1, 7.0, 'Đạt'),
    (4, 3, 1, 5.5, 'Đạt'),
    (4, 4, 1, 8.5, 'Đạt'),
    (4, 5, 1, 7.5, 'Đạt'),
    (4, 6, 1, 6.0, 'Đạt'),
    (4, 7, 1, 4.5, 'Không đạt'),
    (4, 8, 1, 7.0, 'Đạt'),
    (4, 9, 1, 5.0, 'Đạt'),
    (4, 10, 1, 8.0, 'Đạt'),

    -- Kết quả cho MaPhanCong = 5 (Giáo dục Quốc phòng)
    (5, 1, 1, 9.0, 'Đạt'),
    (5, 2, 1, 8.5, 'Đạt'),
    (5, 3, 1, 7.0, 'Đạt'),
    (5, 4, 1, 6.5, 'Đạt'),
    (5, 5, 1, 9.5, 'Đạt'),
    (5, 6, 1, 7.5, 'Đạt'),
    (5, 7, 1, 5.0, 'Đạt'),
    (5, 8, 1, 8.0, 'Đạt'),
    (5, 9, 1, 6.0, 'Đạt'),
    (5, 10, 1, 9.0, 'Đạt'),

    -- Kết quả cho MaPhanCong = 6 (Lập Trình Cơ Bản cho Lớp 10C1)
    (6, 1, 1, 8.0, 'Đạt'),
    (6, 2, 1, 7.5, 'Đạt'),
    (6, 3, 1, 6.0, 'Đạt'),
    (6, 4, 1, 7.0, 'Đạt'),
    (6, 5, 1, 8.5, 'Đạt'),
    (6, 6, 1, 5.5, 'Đạt'),
    (6, 7, 1, 4.0, 'Không đạt'),
    (6, 8, 1, 7.5, 'Đạt'),
    (6, 9, 1, 6.0, 'Đạt'),
    (6, 10, 1, 8.0, 'Đạt');
GO

-- 10. Chèn dữ liệu vào bảng KetQua cho các lần thi khác (nếu cần)
-- Ví dụ: LanThi = 2 cho một số sinh viên

INSERT INTO KetQua (MaPhanCong, MaSinhVien, LanThi, Diem, GhiChu)
VALUES
    -- Kết quả lần thi thứ 2 cho MaPhanCong = 1 (Toán Đại Cương)
    (1, 3, 2, 5.5, 'Đạt sau thi lại'),
    (1, 7, 2, 5.0, 'Đạt sau thi lại'),
    (1, 9, 2, 5.5, 'Đạt sau thi lại'),

    -- Kết quả lần thi thứ 2 cho MaPhanCong = 2 (Vật Lý Cơ Bản)
    (2, 6, 2, 6.0, 'Đạt sau thi lại'),
    (2, 9, 2, 5.0, 'Đạt sau thi lại'),

    -- Kết quả lần thi thứ 2 cho MaPhanCong = 4 (Hóa Học)
    (4, 7, 2, 5.0, 'Đạt sau thi lại'),
    (4, 9, 2, 5.5, 'Đạt sau thi lại'),

    -- Kết quả lần thi thứ 2 cho MaPhanCong = 6 (Lập Trình Cơ Bản cho Lớp 10C1)
    (6, 7, 2, 5.5, 'Đạt sau thi lại');
GO


-- 20 câu truy vấn

-- — Truy vấn tất cả sinh viên
SELECT * FROM SinhVien;
GO

-- — Truy vấn sinh viên có học bổng lớn hơn 5 triệu
SELECT * FROM SinhVien WHERE HocBong > 5000000;
GO

-- — Đếm số lượng sinh viên theo từng lớp
SELECT MaLop, COUNT(*) AS SoLuongSinhVien FROM SinhVien GROUP BY MaLop;
GO

-- — Tính tổng số tiết (lý thuyết + thực hành) của mỗi môn học
SELECT TenMonHoc, (SoTietLyThuyet + SoTietThucHanh) AS TongSoTiet FROM MonHoc;
GO

-- — Tìm điểm cao nhất mà một sinh viên đạt được
SELECT MaSinhVien, MAX(Diem) AS DiemCaoNhat FROM KetQua GROUP BY MaSinhVien;
GO

-- — Tính tổng điểm của mỗi sinh viên
SELECT MaSinhVien, SUM(Diem) AS TongDiem FROM KetQua GROUP BY MaSinhVien;
GO

-- — Truy vấn sinh viên và hiển thị tên lớp học của họ
SELECT sv.MaSinhVien, sv.TenSinhVien, l.TenLop
FROM SinhVien sv
JOIN Lop l ON sv.MaLop = l.MaLop;
GO

-- — Tìm sinh viên có Ho là “Nguyễn” và đến từ Hà Nội
SELECT sv.* 
FROM SinhVien sv 
JOIN QueQuan qq ON sv.MaQueQuan = qq.MaQueQuan 
WHERE sv.HoSinhVien LIKE '%Nguyễn%' AND qq.TenTinhThanhPho = 'Hà Nội';
GO

-- — Liệt kê các giáo viên đã giảng dạy môn học và tên môn học của họ
SELECT gv.TenGiaoVien, mh.TenMonHoc
FROM PhanCong pc
JOIN GiaoVien gv ON pc.MaGiaoVien = gv.MaGiaoVien
JOIN MonHoc mh ON pc.MaMonHoc = mh.MaMonHoc;
GO

-- — Tính số lượng sinh viên theo dân tộc
SELECT dt.TenDanToc, COUNT(*) AS SoLuongSinhVien
FROM SinhVien sv
JOIN DanToc dt ON sv.MaDanToc = dt.MaDanToc
GROUP BY dt.TenDanToc;
GO

-- — Tính điểm trung bình của mỗi sinh viên
SELECT MaSinhVien, AVG(Diem) AS DiemTrungBinh FROM KetQua GROUP BY MaSinhVien;
GO

-- — Tìm những sinh viên có điểm trung bình trên 8
SELECT MaSinhVien, AVG(Diem) AS DiemTrungBinh
FROM KetQua
GROUP BY MaSinhVien
HAVING AVG(Diem) > 8;
GO

-- — Sắp xếp danh sách sinh viên theo điểm trung bình từ cao đến thấp
SELECT MaSinhVien, AVG(Diem) AS DiemTrungBinh
FROM KetQua
GROUP BY MaSinhVien
ORDER BY DiemTrungBinh DESC;
GO

-- — Đếm số lượng sinh viên thuộc mỗi tôn giáo
SELECT tg.TenTonGiao, COUNT(*) AS SoLuongSinhVien
FROM SinhVien sv
JOIN TonGiao tg ON sv.MaTonGiao = tg.MaTonGiao
GROUP BY tg.TenTonGiao;
GO

-- — Tìm sinh viên có điểm thấp nhất trong mỗi lần thi
SELECT MaSinhVien, LanThi, MIN(Diem) AS DiemThapNhat
FROM KetQua
GROUP BY MaSinhVien, LanThi;
GO

-- — Truy vấn sinh viên thuộc lớp nào và tên giáo viên chủ nhiệm của lớp đó
SELECT sv.MaSinhVien, sv.TenSinhVien, l.TenLop, gv.TenGiaoVien AS GVCN
FROM SinhVien sv
JOIN Lop l ON sv.MaLop = l.MaLop
JOIN GiaoVien gv ON l.MaGVCN = gv.MaGiaoVien;
GO

-- — Tìm những giáo viên đã dạy nhiều hơn 2 môn học
SELECT gv.TenGiaoVien, COUNT(pc.MaMonHoc) AS SoLuongMonHoc
FROM PhanCong pc
JOIN GiaoVien gv ON pc.MaGiaoVien = gv.MaGiaoVien
GROUP BY gv.TenGiaoVien
HAVING COUNT(pc.MaMonHoc) > 2;
GO

-- — Tìm sinh viên không thuộc dân tộc Kinh
SELECT sv.TenSinhVien, dt.TenDanToc
FROM SinhVien sv
JOIN DanToc dt ON sv.MaDanToc = dt.MaDanToc
WHERE dt.TenDanToc != 'Kinh';
GO

-- — Tìm sinh viên có điểm thi lần đầu tiên dưới 5
SELECT MaSinhVien, Diem
FROM KetQua
WHERE LanThi = 1 AND Diem < 5;
GO

-- — Sắp xếp sinh viên theo quê quán và điểm thi trung bình
SELECT qq.TenTinhThanhPho, sv.TenSinhVien, AVG(kq.Diem) AS DiemTrungBinh
FROM SinhVien sv
JOIN QueQuan qq ON sv.MaQueQuan = qq.MaQueQuan
JOIN KetQua kq ON sv.MaSinhVien = kq.MaSinhVien
GROUP BY qq.TenTinhThanhPho, sv.TenSinhVien
ORDER BY qq.TenTinhThanhPho, DiemTrungBinh DESC;
GO


-- 6. Viết 05 Hàm (Function) SQL

-- 1. hàm tính điểm trung bình của sinh viên:

CREATE FUNCTION TinhDiemTrungBinh(@MaSinhVien INT)
RETURNS DECIMAL(3, 1)
AS
BEGIN
    DECLARE @DiemTB DECIMAL(3, 1);
    SELECT @DiemTB = AVG(Diem) FROM KetQua WHERE MaSinhVien = @MaSinhVien;
    RETURN @DiemTB;
END;
GO

SELECT MaSinhVien, dbo.TinhDiemTrungBinh(MaSinhVien) AS DiemTrungBinh
FROM SinhVien;
GO


-- 2. Hàm Tính Số Môn Đã Hoàn Thành Của Sinh Viên

CREATE FUNCTION TinhSoMonDaHoanThanh(@MaSinhVien INT)
RETURNS INT
AS
BEGIN
    DECLARE @SoMon INT;
    SELECT @SoMon = COUNT(*)
    FROM KetQua
    WHERE MaSinhVien = @MaSinhVien AND Diem >= 5;
    RETURN @SoMon;
END;
GO

SELECT MaSinhVien, dbo.TinhSoMonDaHoanThanh(MaSinhVien) AS SoMonDaHoanThanh
FROM SinhVien;

-- 3. Hàm tính điểm cao nhất của sinh viên


CREATE FUNCTION TinhDiemCaoNhat(@MaSinhVien INT)
RETURNS DECIMAL(3, 1)
AS
BEGIN
    DECLARE @DiemCaoNhat DECIMAL(3, 1);
    SELECT @DiemCaoNhat = MAX(Diem)
    FROM KetQua
    WHERE MaSinhVien = @MaSinhVien;
    RETURN @DiemCaoNhat;
END;
GO

SELECT MaSinhVien, dbo.TinhDiemCaoNhat(MaSinhVien) AS DiemCaoNhat
FROM SinhVien;

-- 4. Hàm Tính Tuổi Của Sinh Viên

CREATE FUNCTION TinhTuoi(@NgaySinh DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Tuoi INT;
    SELECT @Tuoi = DATEDIFF(YEAR, @NgaySinh, GETDATE());
    RETURN @Tuoi;
END;
GO

SELECT MaSinhVien, dbo.TinhTuoi(NgaySinh) AS Tuoi
FROM SinhVien;


-- 5. Hàm kiểm tra sinh viên có vượt qua tất cả các môn không

CREATE FUNCTION KiemTraSinhVienVotQua(@MaSinhVien INT)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @KetQua NVARCHAR(10);
    
    IF EXISTS (SELECT 1 FROM KetQua WHERE MaSinhVien = @MaSinhVien AND Diem < 5)
        SET @KetQua = N'Không';
    ELSE
        SET @KetQua = N'Có';

    RETURN @KetQua;
END;
GO

SELECT MaSinhVien, dbo.KiemTraSinhVienVotQua(MaSinhVien) AS VotQuaTatCaMon
FROM SinhVien;
go


-- 7. Viết 07 Thủ tục (Procedure) lưu trữ

-- - 1. Thủ tục thêm sinh viên mới:

CREATE PROCEDURE ThemSinhVien
    @MaSinhVien INT,
    @HoSinhVien VARCHAR(100),
    @TenSinhVien VARCHAR(100),
    @MaLop INT,
    @Phai BIT,
    @NgaySinh DATE,
    @DiaChi VARCHAR(200),
    @MaQueQuan INT,
    @MaDanToc INT,
    @MaTonGiao INT,
    @HocBong DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO SinhVien VALUES (@MaSinhVien, @HoSinhVien, @TenSinhVien, @MaLop, @Phai, @NgaySinh, @DiaChi, @MaQueQuan, @MaDanToc, @MaTonGiao, @HocBong);
END;

EXEC ThemSinhVien 
    @MaSinhVien = 123,
    @HoSinhVien = 'Nguyen Thi',
    @TenSinhVien = 'Lan',
    @MaLop = 1,
    @Phai = 0,  -- 0: Nữ, 1: Nam
    @NgaySinh = '2000-01-01',
    @DiaChi = '123, ABC Street, XYZ City',
    @MaQueQuan = 2,
    @MaDanToc = 1,
    @MaTonGiao = 3,
    @HocBong = 5000.00;
GO

SELECT * FROM SinhVien;
Go

-- - 2. Thủ tục cập nhật thông tin sinh viên:
CREATE PROCEDURE CapNhatSinhVien
    @MaSinhVien INT,
    @HoSinhVien VARCHAR(100),
    @TenSinhVien VARCHAR(100),
    @MaLop INT,
    @Phai BIT,
    @NgaySinh DATE,
    @DiaChi VARCHAR(200),
    @MaQueQuan INT,
    @MaDanToc INT,
    @MaTonGiao INT,
    @HocBong DECIMAL(10, 2)
AS
BEGIN
    UPDATE SinhVien
    SET 
        HoSinhVien = @HoSinhVien,
        TenSinhVien = @TenSinhVien,
        MaLop = @MaLop,
        Phai = @Phai,
        NgaySinh = @NgaySinh,
        DiaChi = @DiaChi,
        MaQueQuan = @MaQueQuan,
        MaDanToc = @MaDanToc,
        MaTonGiao = @MaTonGiao,
        HocBong = @HocBong
    WHERE MaSinhVien = @MaSinhVien;
END;

EXEC CapNhatSinhVien 
    @MaSinhVien = 123,
    @HoSinhVien = 'Nguyen Thi',
    @TenSinhVien = 'Lan',
    @MaLop = 1,
    @Phai = 0,  -- 0: Nữ, 1: Nam
    @NgaySinh = '2000-01-01',
    @DiaChi = '123, ABC Street, XYZ City',
    @MaQueQuan = 2,
    @MaDanToc = 1,
    @MaTonGiao = 3,
    @HocBong = 5000.00;
GO
SELECT * FROM SinhVien;
Go

-- - 3. Thủ tục xóa sinh viên:
CREATE PROCEDURE XoaSinhVien
    @MaSinhVien INT
AS
BEGIN
    DELETE FROM SinhVien WHERE MaSinhVien = @MaSinhVien;
END;

EXEC XoaSinhVien @MaSinhVien = 123;
GO

SELECT * FROM SinhVien;
Go

-- - 4. Thủ tục thêm môn học mới:
CREATE PROCEDURE ThemMonHoc
    @MaMonHoc INT,
    @TenMonHoc VARCHAR(100),
    @SoTietLyThuyet INT,
    @SoTietThucHanh INT
AS
BEGIN
    INSERT INTO MonHoc (MaMonHoc, TenMonHoc, SoTietLyThuyet, SoTietThucHanh)
    VALUES (@MaMonHoc, @TenMonHoc, @SoTietLyThuyet, @SoTietThucHanh);
END;

EXEC ThemMonHoc 
    @MaMonHoc = 6,
    @TenMonHoc = 'Kinh tế vĩ mô',
    @SoTietLyThuyet = 40,
    @SoTietThucHanh = 10;
GO

SELECT * FROM MonHoc;
Go

-- - 5. Thủ tục cập nhật kết quả thi của sinh viên:
CREATE PROCEDURE CapNhatKetQuaThi
    @MaPhanCong INT,
    @MaSinhVien INT,
    @LanThi INT,
    @Diem DECIMAL(3, 1),
    @GhiChu VARCHAR(200)
AS
BEGIN
    UPDATE KetQua
    SET Diem = @Diem, GhiChu = @GhiChu
    WHERE MaPhanCong = @MaPhanCong AND MaSinhVien = @MaSinhVien AND LanThi = @LanThi;
END;

EXEC CapNhatKetQuaThi 
    @MaPhanCong = 1,
    @MaSinhVien = 123,
    @LanThi = 1,
    @Diem = 8.5,
    @GhiChu = 'Đạt';
GO

SELECT * FROM KetQua;
Go

-- - 6. Thủ tục thêm giáo viên mới:

CREATE PROCEDURE ThemGiaoVien
    @MaGiaoVien INT,
    @TenGiaoVien VARCHAR(100),
    @Phai BIT,
    @NgaySinh DATE,
    @SoDienThoai VARCHAR(15),
    @DiaChi VARCHAR(200),
    @Email VARCHAR(100),
    @MaQueQuan INT,
    @MaDanToc INT,
    @MaTonGiao INT
AS
BEGIN
    INSERT INTO GiaoVien 
    (MaGiaoVien, TenGiaoVien, Phai, NgaySinh, SoDienThoai, DiaChi, Email, MaQueQuan, MaDanToc, MaTonGiao)
    VALUES 
    (@MaGiaoVien, @TenGiaoVien, @Phai, @NgaySinh, @SoDienThoai, @DiaChi, @Email, @MaQueQuan, @MaDanToc, @MaTonGiao);
END;

EXEC ThemGiaoVien 
    @MaGiaoVien = 6,
    @TenGiaoVien = 'Nguyễn Văn D',
    @Phai = 1,  -- 0: Nữ, 1: Nam
    @NgaySinh = '1980-05-10',
    @SoDienThoai = '0908765432',
    @DiaChi = '12 Đường A, Phường Bến Nghé, TP.HCM',
    @Email = 'nguyenvand@example.com',
    @MaQueQuan = 1,
    @MaDanToc = 1,
    @MaTonGiao = 1;
GO
SELECT * FROM GiaoVien;
Go

-- - 7. Thủ tục phân công môn học cho giáo viên và lớp:
CREATE PROCEDURE PhanCongMonHoc
    @MaPhanCong INT,
    @MaMonHoc INT,
    @MaGiaoVien INT,
    @MaLop INT,
    @HocKy INT,
    @Nam INT,
    @NgayBatDau DATE,
    @NgayKetThuc DATE
AS
BEGIN
    INSERT INTO PhanCong 
    (MaPhanCong, MaMonHoc, MaGiaoVien, MaLop, HocKy, Nam, NgayBatDau, NgayKetThuc)
    VALUES 
    (@MaPhanCong, @MaMonHoc, @MaGiaoVien, @MaLop, @HocKy, @Nam, @NgayBatDau, @NgayKetThuc);
END;

EXEC PhanCongMonHoc 
    @MaPhanCong = 7,
    @MaMonHoc = 1,
    @MaGiaoVien = 6,
    @MaLop = 1,
    @HocKy = 1,
    @Nam = 2024,
    @NgayBatDau = '2024-09-01',
    @NgayKetThuc = '2024-12-01';
GO

SELECT * FROM PhanCong;
Go


-- 8. Viết 03 Trigger
-- -1. Trigger kiểm tra khi thêm sinh viên mới

CREATE TRIGGER CheckHocBongSinhVien
ON SinhVien
AFTER INSERT
AS
BEGIN
    DECLARE @HocBong DECIMAL(10, 2);
    DECLARE @MaSinhVien INT;
    
    SELECT @MaSinhVien = MaSinhVien, @HocBong = HocBong FROM INSERTED;
    
    IF @HocBong > 10000
    BEGIN
        PRINT 'Học bổng của sinh viên ' + CAST(@MaSinhVien AS VARCHAR) + ' vượt quá mức cho phép!';
    END
END;

INSERT INTO SinhVien (MaSinhVien, HoSinhVien, TenSinhVien, MaLop, Phai, NgaySinh, DiaChi, MaQueQuan, MaDanToc, MaTonGiao, HocBong)
VALUES (124, 'Tran Thi', 'Mai', 1, 0, '2001-02-02', '456, DEF Street', 1, 1, 2, 12000.00);
GO

SELECT * FROM SinhVien;
Go

-- -2. Trigger tự động cập nhật số tiết khi cập nhật môn học
CREATE TRIGGER CapNhatSoTietMonHoc
ON MonHoc
AFTER UPDATE
AS
BEGIN
    DECLARE @MaMonHoc INT, @SoTietLyThuyet INT, @SoTietThucHanh INT;
    
    SELECT @MaMonHoc = MaMonHoc, 
           @SoTietLyThuyet = SoTietLyThuyet, 
           @SoTietThucHanh = SoTietThucHanh 
    FROM INSERTED;

    PRINT 'Số tiết lý thuyết và thực hành của môn học ' + CAST(@MaMonHoc AS VARCHAR) + ' đã được cập nhật!';
END;

UPDATE MonHoc
SET SoTietLyThuyet = 45, SoTietThucHanh = 15
WHERE MaMonHoc = 1;
GO

SELECT * FROM MonHoc;
Go

-- - 3. Trigger xóa kết quả thi khi xóa sinh viên

CREATE TRIGGER XoaKetQuaThiKhiXoaSinhVien
ON SinhVien
AFTER DELETE
AS
BEGIN
    DECLARE @MaSinhVien INT;
    
    SELECT @MaSinhVien = MaSinhVien FROM DELETED;
    
    DELETE FROM KetQua WHERE MaSinhVien = @MaSinhVien;
    
    PRINT 'Kết quả thi của sinh viên ' + CAST(@MaSinhVien AS VARCHAR) + ' đã được xóa!';
END;

DELETE FROM SinhVien WHERE MaSinhVien = 123;
GO

SELECT * FROM SinhVien;
Go

SELECT * FROM KetQua;
Go




