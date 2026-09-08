USE DatabaseLeetCode_BTL;
GO

-- P017 — All students.
SELECT * FROM dbo.SinhVien WHERE IsDeleted = 0;

-- P018 — Scholarship greater than 5,000,000.
SELECT * FROM dbo.SinhVien WHERE HocBong > 5000000 AND IsDeleted = 0;

-- P019 — Student count by class.
SELECT MaLop, COUNT(*) AS SoLuongSinhVien
FROM dbo.SinhVien WHERE IsDeleted = 0 GROUP BY MaLop;

-- P020 — Total theory + practice hours per subject.
SELECT MaMonHoc, TenMonHoc, SoTietLyThuyet + SoTietThucHanh AS TongSoTiet
FROM dbo.MonHoc;

-- P021 — Highest score ever achieved by each student (all attempts).
SELECT MaSinhVien, MAX(Diem) AS DiemCaoNhat
FROM dbo.KetQua GROUP BY MaSinhVien;

-- P022 — Sum of every recorded attempt score per student (literal original exercise).
SELECT MaSinhVien, SUM(Diem) AS TongDiem
FROM dbo.KetQua GROUP BY MaSinhVien;

-- P023 — Student and class name.
SELECT sv.MaSinhVien, CONCAT(sv.HoSinhVien,N' ',sv.TenSinhVien) AS HoTen, l.TenLop
FROM dbo.SinhVien AS sv JOIN dbo.Lop AS l ON l.MaLop = sv.MaLop
WHERE sv.IsDeleted = 0;

-- P024 — Nguyen-family students from Hanoi.
SELECT sv.*
FROM dbo.SinhVien AS sv
JOIN dbo.QueQuan AS qq ON qq.MaQueQuan = sv.MaQueQuan
WHERE sv.HoSinhVien LIKE N'Nguyễn%' AND qq.TenTinhThanhPho = N'Hà Nội' AND sv.IsDeleted = 0;

-- P025 — Teachers and subjects they have taught.
SELECT DISTINCT gv.MaGiaoVien, gv.TenGiaoVien, mh.MaMonHoc, mh.TenMonHoc
FROM dbo.PhanCong AS pc
JOIN dbo.GiaoVien AS gv ON gv.MaGiaoVien = pc.MaGiaoVien
JOIN dbo.MonHoc AS mh ON mh.MaMonHoc = pc.MaMonHoc;

-- P026 — Student count by ethnicity.
SELECT dt.MaDanToc, dt.TenDanToc, COUNT(sv.MaSinhVien) AS SoLuongSinhVien
FROM dbo.DanToc AS dt
LEFT JOIN dbo.SinhVien AS sv ON sv.MaDanToc = dt.MaDanToc AND sv.IsDeleted = 0
GROUP BY dt.MaDanToc, dt.TenDanToc;

-- P027 — Average of every recorded attempt per student (literal original exercise).
SELECT MaSinhVien, AVG(CAST(Diem AS DECIMAL(10,2))) AS DiemTrungBinh
FROM dbo.KetQua GROUP BY MaSinhVien;

-- P028 — Students whose all-attempt average is above 8.
SELECT MaSinhVien, AVG(CAST(Diem AS DECIMAL(10,2))) AS DiemTrungBinh
FROM dbo.KetQua GROUP BY MaSinhVien
HAVING AVG(CAST(Diem AS DECIMAL(10,2))) > 8;

-- P029 — Sort by all-attempt average descending.
SELECT MaSinhVien, AVG(CAST(Diem AS DECIMAL(10,2))) AS DiemTrungBinh
FROM dbo.KetQua GROUP BY MaSinhVien
ORDER BY DiemTrungBinh DESC, MaSinhVien;

-- P030 — Student count by religion.
SELECT tg.MaTonGiao, tg.TenTonGiao, COUNT(sv.MaSinhVien) AS SoLuongSinhVien
FROM dbo.TonGiao AS tg
LEFT JOIN dbo.SinhVien AS sv ON sv.MaTonGiao = tg.MaTonGiao AND sv.IsDeleted = 0
GROUP BY tg.MaTonGiao, tg.TenTonGiao;

-- P031 — Lowest score recorded in each attempt number.
SELECT LanThi, MIN(Diem) AS DiemThapNhat
FROM dbo.KetQua GROUP BY LanThi;

-- P032 — Student, class, and homeroom teacher.
SELECT sv.MaSinhVien, CONCAT(sv.HoSinhVien,N' ',sv.TenSinhVien) AS HoTen,
       l.TenLop, gv.TenGiaoVien AS GVCN
FROM dbo.SinhVien AS sv
JOIN dbo.Lop AS l ON l.MaLop = sv.MaLop
JOIN dbo.GiaoVien AS gv ON gv.MaGiaoVien = l.MaGVCN
WHERE sv.IsDeleted = 0;

-- P033 — Teachers who taught more than two distinct subjects.
SELECT gv.MaGiaoVien, gv.TenGiaoVien, COUNT(DISTINCT pc.MaMonHoc) AS SoLuongMonHoc
FROM dbo.GiaoVien AS gv
JOIN dbo.PhanCong AS pc ON pc.MaGiaoVien = gv.MaGiaoVien
GROUP BY gv.MaGiaoVien, gv.TenGiaoVien
HAVING COUNT(DISTINCT pc.MaMonHoc) > 2;

-- P034 — Students not in Kinh ethnicity.
SELECT sv.MaSinhVien, CONCAT(sv.HoSinhVien,N' ',sv.TenSinhVien) AS HoTen, dt.TenDanToc
FROM dbo.SinhVien AS sv
JOIN dbo.DanToc AS dt ON dt.MaDanToc = sv.MaDanToc
WHERE dt.TenDanToc <> N'Kinh' AND sv.IsDeleted = 0;

-- P035 — First-attempt scores below 5.
SELECT MaPhanCong, MaSinhVien, Diem
FROM dbo.KetQua WHERE LanThi = 1 AND Diem < 5;

-- P036 — Students ordered by hometown then average score.
SELECT qq.TenTinhThanhPho, sv.MaSinhVien,
       CONCAT(sv.HoSinhVien,N' ',sv.TenSinhVien) AS HoTen,
       AVG(CAST(kq.Diem AS DECIMAL(10,2))) AS DiemTrungBinh
FROM dbo.SinhVien AS sv
JOIN dbo.QueQuan AS qq ON qq.MaQueQuan = sv.MaQueQuan
JOIN dbo.KetQua AS kq ON kq.MaSinhVien = sv.MaSinhVien
WHERE sv.IsDeleted = 0
GROUP BY qq.TenTinhThanhPho, sv.MaSinhVien, sv.HoSinhVien, sv.TenSinhVien
ORDER BY qq.TenTinhThanhPho, DiemTrungBinh DESC, sv.MaSinhVien;
GO
