USE DatabaseLeetCode_BTL;
GO

-- P086 — Least privilege with a read-only role.
IF DATABASE_PRINCIPAL_ID(N'db_leetcode_reader') IS NULL CREATE ROLE db_leetcode_reader;
GRANT SELECT ON SCHEMA::dbo TO db_leetcode_reader;
DENY INSERT,UPDATE,DELETE ON SCHEMA::dbo TO db_leetcode_reader;
GO

-- P087 — Row-level security demo: session context limits visible class rows.
CREATE OR ALTER FUNCTION dbo.fn_ClassSecurityPredicate(@MaLop INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS allowed
WHERE @MaLop=TRY_CONVERT(INT,SESSION_CONTEXT(N'MaLop'))
   OR IS_MEMBER(N'db_owner')=1;
GO
IF EXISTS(SELECT 1 FROM sys.security_policies WHERE name=N'StudentClassPolicy')
    DROP SECURITY POLICY dbo.StudentClassPolicy;
GO
CREATE SECURITY POLICY dbo.StudentClassPolicy
ADD FILTER PREDICATE dbo.fn_ClassSecurityPredicate(MaLop) ON dbo.SinhVien
WITH (STATE=ON);
GO

-- P088 — System-versioned temporal-table demonstration without altering the core exercise table.
DROP TABLE IF EXISTS dbo.SinhVienTemporalDemo;
CREATE TABLE dbo.SinhVienTemporalDemo(
    MaSinhVien INT NOT NULL PRIMARY KEY,
    HoTen NVARCHAR(200) NOT NULL,
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL,
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,
    PERIOD FOR SYSTEM_TIME(ValidFrom,ValidTo)
) WITH (SYSTEM_VERSIONING=ON (HISTORY_TABLE=dbo.SinhVienTemporalDemoHistory));
GO

-- P089 — Indexed view example (aggregation maintained by SQL Server).
SET NUMERIC_ROUNDABORT OFF;
SET ANSI_NULLS ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET ARITHABORT ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET QUOTED_IDENTIFIER ON;
GO
CREATE OR ALTER VIEW dbo.vw_ClassStudentCount
WITH SCHEMABINDING
AS
SELECT MaLop,COUNT_BIG(*) AS StudentCount
FROM dbo.SinhVien
WHERE IsDeleted=CONVERT(bit,0)
GROUP BY MaLop;
GO
CREATE UNIQUE CLUSTERED INDEX CIX_vw_ClassStudentCount ON dbo.vw_ClassStudentCount(MaLop);
GO

-- P090 — Analytics scenario: nonclustered columnstore on grade facts.
CREATE NONCLUSTERED COLUMNSTORE INDEX NCCI_KetQua_Analytics
ON dbo.KetQua(MaPhanCong,MaSinhVien,LanThi,Diem);
GO

-- P091 — Sequence-based identifiers are concurrency-safe and do not require IDENTITY.
IF OBJECT_ID(N'dbo.DemoStudentSeq',N'SO') IS NOT NULL DROP SEQUENCE dbo.DemoStudentSeq;
CREATE SEQUENCE dbo.DemoStudentSeq AS INT START WITH 10000 INCREMENT BY 1;
SELECT NEXT VALUE FOR dbo.DemoStudentSeq AS NextStudentNumber;
GO
