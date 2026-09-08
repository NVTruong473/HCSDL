USE DatabaseLeetCode_BTL;
GO

-- P052 — Latest attempt per assignment, then current average per student.
WITH Ranked AS (
    SELECT kq.*, ROW_NUMBER() OVER (PARTITION BY MaPhanCong,MaSinhVien ORDER BY LanThi DESC) AS rn
    FROM dbo.KetQua AS kq
)
SELECT MaSinhVien, AVG(CAST(Diem AS DECIMAL(10,2))) AS CurrentAverage
FROM Ranked WHERE rn=1 GROUP BY MaSinhVien;

-- P053 — Count distinct completed assignments from latest attempts.
WITH Ranked AS (
    SELECT kq.*, ROW_NUMBER() OVER (PARTITION BY MaPhanCong,MaSinhVien ORDER BY LanThi DESC) AS rn
    FROM dbo.KetQua AS kq
)
SELECT MaSinhVien, COUNT(*) AS CompletedAssignments
FROM Ranked WHERE rn=1 AND Diem>=5 GROUP BY MaSinhVien;

-- P054 — Top 3 students per class by current average.
WITH Latest AS (
    SELECT kq.*, ROW_NUMBER() OVER (PARTITION BY MaPhanCong,MaSinhVien ORDER BY LanThi DESC) AS rn
    FROM dbo.KetQua AS kq
), AvgByStudent AS (
    SELECT sv.MaLop, sv.MaSinhVien, AVG(CAST(l.Diem AS DECIMAL(10,2))) AS AvgScore
    FROM dbo.SinhVien sv JOIN Latest l ON l.MaSinhVien=sv.MaSinhVien AND l.rn=1
    WHERE sv.IsDeleted=0 GROUP BY sv.MaLop,sv.MaSinhVien
), Ranked AS (
    SELECT *, DENSE_RANK() OVER (PARTITION BY MaLop ORDER BY AvgScore DESC) AS RankInClass
    FROM AvgByStudent
)
SELECT * FROM Ranked WHERE RankInClass<=3 ORDER BY MaLop,RankInClass,MaSinhVien;

-- P055 — Overall student rank by current average.
WITH Latest AS (
    SELECT kq.*, ROW_NUMBER() OVER (PARTITION BY MaPhanCong,MaSinhVien ORDER BY LanThi DESC) AS rn
    FROM dbo.KetQua kq
), A AS (
    SELECT MaSinhVien,AVG(CAST(Diem AS DECIMAL(10,2))) AvgScore FROM Latest WHERE rn=1 GROUP BY MaSinhVien
)
SELECT *,DENSE_RANK() OVER(ORDER BY AvgScore DESC) OverallRank FROM A;

-- P056 — Running average along assignment start dates.
WITH X AS (
    SELECT kq.MaSinhVien,pc.NgayBatDau,kq.MaPhanCong,kq.LanThi,kq.Diem,
           ROW_NUMBER() OVER(PARTITION BY kq.MaPhanCong,kq.MaSinhVien ORDER BY kq.LanThi DESC) rn
    FROM dbo.KetQua kq JOIN dbo.PhanCong pc ON pc.MaPhanCong=kq.MaPhanCong
)
SELECT MaSinhVien,NgayBatDau,MaPhanCong,Diem,
       AVG(CAST(Diem AS DECIMAL(10,2))) OVER(PARTITION BY MaSinhVien ORDER BY NgayBatDau,MaPhanCong ROWS UNBOUNDED PRECEDING) RunningAverage
FROM X WHERE rn=1;

-- P057 — Students whose current average is above their class average.
WITH Latest AS (
    SELECT kq.*,ROW_NUMBER() OVER(PARTITION BY MaPhanCong,MaSinhVien ORDER BY LanThi DESC) rn FROM dbo.KetQua kq
), A AS (
    SELECT sv.MaLop,sv.MaSinhVien,AVG(CAST(l.Diem AS DECIMAL(10,2))) AvgScore
    FROM dbo.SinhVien sv JOIN Latest l ON l.MaSinhVien=sv.MaSinhVien AND l.rn=1
    WHERE sv.IsDeleted=0 GROUP BY sv.MaLop,sv.MaSinhVien
), B AS (
    SELECT *,AVG(AvgScore) OVER(PARTITION BY MaLop) ClassAverage FROM A
)
SELECT * FROM B WHERE AvgScore>ClassAverage;

-- P058 — Relational division: students who passed every assignment belonging to their class.
WITH Latest AS (
    SELECT kq.*,ROW_NUMBER() OVER(PARTITION BY MaPhanCong,MaSinhVien ORDER BY LanThi DESC) rn FROM dbo.KetQua kq
)
SELECT sv.MaSinhVien
FROM dbo.SinhVien sv
WHERE sv.IsDeleted=0
  AND NOT EXISTS (
      SELECT 1 FROM dbo.PhanCong pc
      WHERE pc.MaLop=sv.MaLop
        AND NOT EXISTS (
            SELECT 1 FROM Latest l
            WHERE l.MaPhanCong=pc.MaPhanCong AND l.MaSinhVien=sv.MaSinhVien AND l.rn=1 AND l.Diem>=5
        )
  );

-- P059 — Teachers with no teaching assignment.
SELECT gv.* FROM dbo.GiaoVien gv
WHERE NOT EXISTS (SELECT 1 FROM dbo.PhanCong pc WHERE pc.MaGiaoVien=gv.MaGiaoVien);

-- P060 — Duplicate e-mail detection pattern (should return no rows because schema enforces UNIQUE).
SELECT Email,COUNT(*) DuplicateCount FROM dbo.GiaoVien GROUP BY Email HAVING COUNT(*)>1;

-- P061 — Cross-table integrity audit: grade rows where student's class differs from assigned class.
SELECT kq.*
FROM dbo.KetQua kq
JOIN dbo.SinhVien sv ON sv.MaSinhVien=kq.MaSinhVien
JOIN dbo.PhanCong pc ON pc.MaPhanCong=kq.MaPhanCong
WHERE sv.MaLop<>pc.MaLop;

-- P062 — Race-safe grade upsert with transaction and key-range locking.
CREATE OR ALTER PROCEDURE dbo.UpsertKetQua
    @MaPhanCong INT,@MaSinhVien INT,@LanThi TINYINT,@Diem DECIMAL(4,1),@GhiChu NVARCHAR(200)=NULL
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    BEGIN TRAN;
    IF EXISTS (
        SELECT 1 FROM dbo.KetQua WITH (UPDLOCK,HOLDLOCK)
        WHERE MaPhanCong=@MaPhanCong AND MaSinhVien=@MaSinhVien AND LanThi=@LanThi
    )
        UPDATE dbo.KetQua SET Diem=@Diem,GhiChu=@GhiChu
        WHERE MaPhanCong=@MaPhanCong AND MaSinhVien=@MaSinhVien AND LanThi=@LanThi;
    ELSE
        INSERT dbo.KetQua VALUES(@MaPhanCong,@MaSinhVien,@LanThi,@Diem,@GhiChu);
    COMMIT;
END;
GO

-- P063 — Savepoint: preserve the outer transaction while rolling back one optional operation.
BEGIN TRAN;
SAVE TRAN BeforeOptionalUpdate;
BEGIN TRY
    UPDATE dbo.SinhVien SET HocBong=HocBong+100000 WHERE MaSinhVien=1;
    -- optional work here
END TRY
BEGIN CATCH
    ROLLBACK TRAN BeforeOptionalUpdate;
END CATCH;
ROLLBACK; -- demo only
GO

-- P064 — Isolation-level exercise. Run competing transactions in two sessions and observe behavior.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- Repeat under READ UNCOMMITTED, REPEATABLE READ, SNAPSHOT (when enabled), and SERIALIZABLE.
SELECT MaSinhVien,HocBong FROM dbo.SinhVien WHERE MaSinhVien=1;
GO

-- P065 — Optimistic concurrency using rowversion.
CREATE OR ALTER PROCEDURE dbo.UpdateStudentScholarshipOptimistic
    @MaSinhVien INT,@ExpectedRowVer BINARY(8),@HocBong DECIMAL(12,2)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.SinhVien SET HocBong=@HocBong
    WHERE MaSinhVien=@MaSinhVien AND RowVer=@ExpectedRowVer AND IsDeleted=0;
    IF @@ROWCOUNT=0 THROW 53001,'Concurrency conflict or student not found.',1;
END;
GO

-- P069 — Keyset pagination (stable and scalable compared with deep OFFSET scans).
DECLARE @AfterId INT=0,@PageSize INT=20;
SELECT TOP (@PageSize) MaSinhVien,HoSinhVien,TenSinhVien
FROM dbo.SinhVien
WHERE IsDeleted=0 AND MaSinhVien>@AfterId
ORDER BY MaSinhVien;

-- P070 — Multi-row student audit trigger.
DROP TABLE IF EXISTS dbo.SinhVienAudit;
CREATE TABLE dbo.SinhVienAudit(
    AuditID BIGINT IDENTITY PRIMARY KEY, MaSinhVien INT NOT NULL, ActionType VARCHAR(10) NOT NULL,
    OldHocBong DECIMAL(12,2) NULL,NewHocBong DECIMAL(12,2) NULL,ChangedAt DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME()
);
GO
CREATE OR ALTER TRIGGER dbo.AuditSinhVien
ON dbo.SinhVien
AFTER INSERT,UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT dbo.SinhVienAudit(MaSinhVien,ActionType,OldHocBong,NewHocBong)
    SELECT i.MaSinhVien,CASE WHEN d.MaSinhVien IS NULL THEN 'INSERT' ELSE 'UPDATE' END,d.HocBong,i.HocBong
    FROM inserted i LEFT JOIN deleted d ON d.MaSinhVien=i.MaSinhVien;
END;
GO

-- P071 — Soft-delete operation.
CREATE OR ALTER PROCEDURE dbo.SoftDeleteStudent @MaSinhVien INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.SinhVien SET IsDeleted=1 WHERE MaSinhVien=@MaSinhVien AND IsDeleted=0;
END;
GO

-- P072 — Idempotent seed pattern.
IF NOT EXISTS(SELECT 1 FROM dbo.DanToc WHERE MaDanToc=99)
    INSERT dbo.DanToc(MaDanToc,TenDanToc) VALUES(99,N'Demo');
DELETE dbo.DanToc WHERE MaDanToc=99;
GO

-- P073 — Deadlock prevention: acquire rows in a consistent key order.
BEGIN TRAN;
UPDATE dbo.SinhVien WITH (UPDLOCK) SET HocBong=HocBong WHERE MaSinhVien=1;
UPDATE dbo.SinhVien WITH (UPDLOCK) SET HocBong=HocBong WHERE MaSinhVien=2;
ROLLBACK;
GO

-- P074 — TRY/CATCH + XACT_STATE error handling.
CREATE OR ALTER PROCEDURE dbo.TransferScholarship
    @FromStudent INT,@ToStudent INT,@Amount DECIMAL(12,2)
AS
BEGIN
    SET NOCOUNT ON; SET XACT_ABORT ON;
    BEGIN TRY
        BEGIN TRAN;
        UPDATE dbo.SinhVien SET HocBong=HocBong-@Amount WHERE MaSinhVien=@FromStudent AND HocBong>=@Amount;
        IF @@ROWCOUNT=0 THROW 53002,'Source student missing or insufficient scholarship.',1;
        UPDATE dbo.SinhVien SET HocBong=HocBong+@Amount WHERE MaSinhVien=@ToStudent;
        IF @@ROWCOUNT=0 THROW 53003,'Destination student missing.',1;
        COMMIT;
    END TRY
    BEGIN CATCH
        IF XACT_STATE()<>0 ROLLBACK;
        THROW;
    END CATCH
END;
GO

-- P075 — Improvement between attempts using LAG.
SELECT MaPhanCong,MaSinhVien,LanThi,Diem,
       Diem-LAG(Diem) OVER(PARTITION BY MaPhanCong,MaSinhVien ORDER BY LanThi) AS Improvement
FROM dbo.KetQua;

-- P076 — Static PIVOT: latest grade columns for assignment IDs 1..6.
WITH Latest AS (
    SELECT MaPhanCong,MaSinhVien,Diem,ROW_NUMBER() OVER(PARTITION BY MaPhanCong,MaSinhVien ORDER BY LanThi DESC) rn
    FROM dbo.KetQua
)
SELECT * FROM (SELECT MaSinhVien,MaPhanCong,Diem FROM Latest WHERE rn=1) src
PIVOT (MAX(Diem) FOR MaPhanCong IN ([1],[2],[3],[4],[5],[6])) p;

-- P077 — GROUPING SETS for class/ethnicity rollups.
SELECT sv.MaLop,sv.MaDanToc,COUNT(*) AS StudentCount
FROM dbo.SinhVien sv WHERE IsDeleted=0
GROUP BY GROUPING SETS ((sv.MaLop,sv.MaDanToc),(sv.MaLop),(sv.MaDanToc),());

-- P078 — JSON export + validated import projection.
SELECT MaSinhVien,HoSinhVien,TenSinhVien,MaLop FROM dbo.SinhVien WHERE IsDeleted=0 FOR JSON PATH;
DECLARE @json NVARCHAR(MAX)=N'[{"MaSinhVien":999,"HoSinhVien":"Demo","TenSinhVien":"JSON","MaLop":1}]';
SELECT * FROM OPENJSON(@json) WITH(MaSinhVien INT,HoSinhVien NVARCHAR(100),TenSinhVien NVARCHAR(100),MaLop INT);

-- P079 — Optional-filter search. OPTION(RECOMPILE) lets SQL Server optimize for supplied parameters.
CREATE OR ALTER PROCEDURE dbo.SearchStudents @MaLop INT=NULL,@MinScholarship DECIMAL(12,2)=NULL,@Name NVARCHAR(100)=NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT MaSinhVien,HoSinhVien,TenSinhVien,MaLop,HocBong
    FROM dbo.SinhVien
    WHERE IsDeleted=0
      AND (@MaLop IS NULL OR MaLop=@MaLop)
      AND (@MinScholarship IS NULL OR HocBong>=@MinScholarship)
      AND (@Name IS NULL OR CONCAT(HoSinhVien,N' ',TenSinhVien) LIKE @Name+N'%')
    OPTION(RECOMPILE);
END;
GO

-- P080 — Recursive prerequisite traversal.
DROP TABLE IF EXISTS dbo.MonHocTienQuyet;
CREATE TABLE dbo.MonHocTienQuyet(MaMonHoc INT NOT NULL,MaTienQuyet INT NOT NULL,
    CONSTRAINT PK_MonHocTienQuyet PRIMARY KEY(MaMonHoc,MaTienQuyet),
    FOREIGN KEY(MaMonHoc) REFERENCES dbo.MonHoc(MaMonHoc),FOREIGN KEY(MaTienQuyet) REFERENCES dbo.MonHoc(MaMonHoc));
INSERT dbo.MonHocTienQuyet VALUES(4,1),(3,1);
WITH Prereq AS (
    SELECT MaMonHoc,MaTienQuyet,1 Depth FROM dbo.MonHocTienQuyet WHERE MaMonHoc=4
    UNION ALL
    SELECT p.MaMonHoc,m.MaTienQuyet,p.Depth+1
    FROM Prereq p JOIN dbo.MonHocTienQuyet m ON m.MaMonHoc=p.MaTienQuyet
)
SELECT * FROM Prereq OPTION(MAXRECURSION 100);
GO

-- P092 — Set-based trigger pattern: validate student/class consistency for grade batches.
CREATE OR ALTER TRIGGER dbo.ValidateGradeClass
ON dbo.KetQua
AFTER INSERT,UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS(
        SELECT 1 FROM inserted i
        JOIN dbo.SinhVien sv ON sv.MaSinhVien=i.MaSinhVien
        JOIN dbo.PhanCong pc ON pc.MaPhanCong=i.MaPhanCong
        WHERE sv.MaLop<>pc.MaLop
    ) THROW 53004,'Student is not in the class for this assignment.',1;
END;
GO

-- P093 — NULL-safe anti-join.
SELECT sv.MaSinhVien FROM dbo.SinhVien sv
WHERE NOT EXISTS(SELECT 1 FROM dbo.KetQua kq WHERE kq.MaSinhVien=sv.MaSinhVien);

-- P094 — DISTINCT when the goal is deduplication, GROUP BY when aggregation is required.
SELECT DISTINCT MaLop FROM dbo.SinhVien WHERE IsDeleted=0;
SELECT MaLop,COUNT(*) StudentCount FROM dbo.SinhVien WHERE IsDeleted=0 GROUP BY MaLop;

-- P095 — WHERE filters rows before grouping; HAVING filters groups after aggregation.
SELECT MaLop,AVG(HocBong) AvgScholarship
FROM dbo.SinhVien WHERE IsDeleted=0 AND HocBong>0
GROUP BY MaLop HAVING AVG(HocBong)>3000000;

-- P096 — UNION ALL keeps duplicates and avoids duplicate-elimination work when sets are known disjoint.
SELECT MaSinhVien FROM dbo.SinhVien WHERE MaLop=1
UNION ALL
SELECT MaSinhVien FROM dbo.SinhVien WHERE MaLop=2;

-- P097 — EXISTS avoids accidental row multiplication when only existence matters.
SELECT sv.MaSinhVien FROM dbo.SinhVien sv
WHERE EXISTS(SELECT 1 FROM dbo.KetQua kq WHERE kq.MaSinhVien=sv.MaSinhVien AND kq.Diem>=8);

-- P098 — Temp table when intermediate results need indexing/reuse across statements.
DROP TABLE IF EXISTS #Latest;
SELECT MaPhanCong,MaSinhVien,LanThi,Diem INTO #Latest
FROM (SELECT kq.*,ROW_NUMBER() OVER(PARTITION BY MaPhanCong,MaSinhVien ORDER BY LanThi DESC) rn FROM dbo.KetQua kq) x
WHERE rn=1;
CREATE INDEX IX_Latest_Student ON #Latest(MaSinhVien) INCLUDE(Diem,MaPhanCong);
SELECT MaSinhVien,AVG(Diem) AvgScore FROM #Latest GROUP BY MaSinhVien;

-- P100 — Capstone transcript: latest results, pass state, average, and overall rank.
WITH Latest AS (
    SELECT kq.*,ROW_NUMBER() OVER(PARTITION BY MaPhanCong,MaSinhVien ORDER BY LanThi DESC) rn FROM dbo.KetQua kq
), CurrentRows AS (
    SELECT sv.MaSinhVien,CONCAT(sv.HoSinhVien,N' ',sv.TenSinhVien) HoTen,
           pc.MaMonHoc,mh.TenMonHoc,l.Diem,
           CASE WHEN l.Diem>=5 THEN 1 ELSE 0 END Passed
    FROM Latest l
    JOIN dbo.SinhVien sv ON sv.MaSinhVien=l.MaSinhVien
    JOIN dbo.PhanCong pc ON pc.MaPhanCong=l.MaPhanCong
    JOIN dbo.MonHoc mh ON mh.MaMonHoc=pc.MaMonHoc
    WHERE l.rn=1 AND sv.IsDeleted=0
), Summary AS (
    SELECT MaSinhVien,MAX(HoTen) HoTen,AVG(CAST(Diem AS DECIMAL(10,2))) AvgScore,
           SUM(Passed) PassedSubjects,COUNT(*) AttemptedSubjects
    FROM CurrentRows GROUP BY MaSinhVien
)
SELECT *,DENSE_RANK() OVER(ORDER BY AvgScore DESC) OverallRank
FROM Summary ORDER BY OverallRank,MaSinhVien;
GO
