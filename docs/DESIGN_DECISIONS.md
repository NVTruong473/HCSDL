# Design Decisions & Corrections

The goal of this refactor is not to preserve every old implementation detail. It preserves the **exercise identity and learning objective** while upgrading correctness.

## 1. Integrity belongs in constraints first

A score range is a domain rule, so `CHECK (Diem BETWEEN 0 AND 10)` is the primary protection. A trigger is also included where the original assignment explicitly asks for trigger practice, but the schema does not rely on trigger-only validation.

## 2. Triggers are statement-level, not row-level

SQL Server's `inserted` and `deleted` logical tables can contain many rows. Every trigger in this repo is written set-wise. Scalar assignment such as `SELECT @id = id FROM inserted` is intentionally avoided for correctness under multi-row DML.

## 3. Student code generation is concurrency-safe

The old pattern `MAX(MSSV) + 1` can hand the same next code to concurrent sessions. The revised assignment uses a SQL Server `SEQUENCE`, satisfying the original “do not use IDENTITY” rule while removing the race.

## 4. Retakes need a declared semantic

For transcript-style questions, this repo defines a student's current result for an assignment as the row with the greatest `LanThi`. Aggregate exercises that intentionally ask about every attempt still aggregate every row; advanced exercises explicitly use latest-attempt semantics.

## 5. `NOT EXISTS` over nullable `NOT IN`

`NOT IN` can become UNKNOWN for every candidate when the subquery contains NULL. Anti-join exercises therefore prefer `NOT EXISTS`.

## 6. Correct age calculation

`DATEDIFF(YEAR, birth_date, GETDATE())` counts year boundaries and can overstate age before the birthday. The corrected function subtracts one when the birthday for the current year has not yet occurred.

## 7. Performance claims require workload context

Indexes in the advanced track are examples tied to concrete query predicates. They are not blanket recommendations. A covering index can reduce reads but increases storage and write cost; filtered indexes help only when the filter matches useful workload selectivity.

## 8. SQL Server is the primary dialect

The original coursework uses `GO`, procedures, functions, and triggers in T-SQL style. This refactor keeps SQL Server as the primary engine instead of forcing portability at the cost of losing the original database-programming exercises.
