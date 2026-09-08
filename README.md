# Database LeetCode — HCSDL

[![CI](https://github.com/NVTruong473/HCSDL/actions/workflows/ci.yml/badge.svg)](https://github.com/NVTruong473/HCSDL/actions/workflows/ci.yml)

> **100 database challenges** rebuilt from my university Database Systems coursework into one continuous practice repository: **51 original-derived problems + 49 advanced extensions**.

This repository is no longer organized as disconnected labs or ZIP submissions. The coursework has been anonymized and rebuilt as a LeetCode-style database track that a reviewer can browse, run, test, and audit. Personal student identifiers and submission-specific filenames are intentionally omitted.

## What this repo proves

- Relational modeling: ERD, cardinality, subtype/supertype mapping, junction tables.
- Relational theory: functional dependencies, attribute closure, candidate keys, normalization through BCNF.
- SQL: filtering, joins, set operators, aggregation, subqueries, CTEs, window functions, relational division, PIVOT, JSON.
- Database programming: functions, stored procedures, triggers, sequences, transactions, error handling.
- Correctness: `CHECK`/`UNIQUE`/FK constraints, set-based multi-row triggers, `NOT EXISTS`, latest-attempt semantics.
- Performance: SARGability, covering/filtered indexes, keyset pagination, query-plan thinking, columnstore scenarios.
- Concurrency & security: isolation levels, race-free upsert patterns, deadlock prevention, rowversion, least privilege, row-level security.

## Repository map

```text
HCSDL/
├── problems/                     # 100 LeetCode-style problem pages
├── sql/
│   ├── 01_hospital/              # original HCSDL project, corrected
│   ├── 02_assignment/            # original ASM SQL, corrected
│   ├── 03_btl/                   # original BTL split into runnable modules
│   └── 04_advanced/              # advanced extensions
├── python/
│   └── ASM_P2.py                 # ERD mapping + candidate-key algorithms
├── docs/
│   ├── ERD.md                    # Mermaid ER diagrams + mapping rules
│   ├── NORMALIZATION.md          # FD, closure, keys, 1NF→BCNF
│   ├── ORIGINAL_TO_CHALLENGE_MAP.md
│   └── DESIGN_DECISIONS.md
├── tests/                        # executable tests for theory tooling + catalog
├── docker-compose.yml            # local SQL Server
└── Makefile
```

## Challenge tracks

| Track | IDs | Count | Origin |
|---|---:|---:|---|
| Hospital schema & queries | P001–P006 | 6 | legacy hospital coursework → `hospital.sql` |
| ERD & relational theory | P007–P012 | 6 | Assignment → `ASM_P2.py` |
| Assignment SQL | P013–P016 | 4 | Assignment → `ASM.SQL` |
| BTL SQL query set | P017–P036 | 20 | Legacy academic-management BTL |
| BTL functions | P037–P041 | 5 | Legacy academic-management BTL |
| BTL procedures | P042–P048 | 7 | Legacy academic-management BTL |
| BTL triggers | P049–P051 | 3 | Legacy academic-management BTL |
| Advanced database extensions | P052–P100 | 49 | New exercises derived from the same schemas |

**Important:** P001–P051 are traceable to the original coursework. P052–P100 are explicitly labeled **Advanced extension**; they are not presented as original university assignments.

Browse the full index at [`problems/README.md`](problems/README.md) and the provenance map at [`docs/ORIGINAL_TO_CHALLENGE_MAP.md`](docs/ORIGINAL_TO_CHALLENGE_MAP.md).

## Quick start

### 1. Run the Python/theory tests

```bash
python -m unittest discover -s tests -v
```

### 2. Start SQL Server locally

```bash
cp .env.example .env
# edit MSSQL_SA_PASSWORD in .env

docker compose up -d
```

Connect to `localhost:1433` using SSMS, Azure Data Studio, VS Code SQL tools, DBeaver, or `sqlcmd`.

### 3. Run the coursework-derived SQL in order

```text
sql/01_hospital/hospital.sql
sql/02_assignment/ASM.SQL
sql/03_btl/schema.sql
sql/03_btl/seed.sql
sql/03_btl/queries.sql
sql/03_btl/functions.sql
sql/03_btl/procedures.sql
sql/03_btl/triggers.sql
sql/04_advanced/advanced_challenges.sql
```

`sql/03_btl/btl.sql` is the SQLCMD orchestrator for the BTL modules.

## What was intentionally improved from the old submission

The refactor does not blindly preserve mistakes. Examples:

- `HoTen = 'Nguyen%'` was corrected to a real prefix search with `LIKE`.
- “Nguyễn **and** TP.HCM” is expressed with `AND`, not a `UNION` of unrelated predicates.
- `NOT IN` anti-joins were upgraded to null-safe `NOT EXISTS` where appropriate.
- “completed subjects” counts distinct assignments using the **latest** attempt, avoiding retry double-counting.
- age calculation accounts for whether the birthday has occurred this year.
- trigger logic is set-based and safe when one statement affects many rows.
- automatic student codes use a SQL Server `SEQUENCE` rather than race-prone `MAX(code) + 1`, while still respecting the original “no IDENTITY” requirement.
- constraints are used as the first line of integrity; triggers are retained when the exercise specifically asks for trigger practice.

See [`docs/DESIGN_DECISIONS.md`](docs/DESIGN_DECISIONS.md) for the reasoning.

## How to practice like LeetCode

1. Pick a problem from [`problems/README.md`](problems/README.md).
2. Read only the problem page first.
3. Solve it in your own scratch database/file.
4. Open the linked repository solution.
5. Compare correctness, edge cases, set-based behavior, and expected indexes—not only syntax.
6. For advanced problems, explain *why* the solution is correct and when it would stop scaling.

## Privacy & provenance

Technical provenance is retained at the coursework-area level, while personal student IDs, submission archive names, personal phone numbers, and other submission-specific identifiers are removed from the public tree. The old ZIP files are not retained because they both hide the work from GitHub review and can re-expose private submission metadata. Nothing in P052–P100 is misrepresented as a historical assignment.

## Database target

Primary dialect: **Microsoft SQL Server / T-SQL**. The SQL is written for modern SQL Server versions (2022+), using features such as `CREATE OR ALTER`, `SEQUENCE`, window functions, JSON, and row-level security demonstrations.

---

### Tóm tắt tiếng Việt

Repo này biến toàn bộ bài Hệ Cơ Sở Dữ Liệu cũ thành một lộ trình luyện tập liên tục kiểu LeetCode. Nguồn bài được truy vết theo nhóm coursework nhưng đã ẩn mã sinh viên/thông tin định danh; lời giải cũ được sửa những chỗ sai logic/không an toàn; các bài P052–P100 là phần nâng cao bổ sung để thể hiện năng lực SQL, ERD, chuẩn hóa, transaction, index, concurrency và security ở mức sâu hơn.
