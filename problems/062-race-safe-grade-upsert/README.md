# P062 — Race-safe grade upsert

**Difficulty:** Hard  
**Track:** Advanced extension  
**Topics:** transaction, locking

## Problem

Upsert a grade under UPDLOCK/HOLDLOCK so concurrent sessions cannot create the same key.

## Practice contract

Solve this problem before opening the repository solution. Check not only whether the query returns rows, but also whether it is correct for duplicates, NULLs, retakes, multi-row DML, and concurrent execution when those concerns apply.

## Solution

See [`sql/04_advanced/advanced_challenges.sql`](../../sql/04_advanced/advanced_challenges.sql) and find the section marked `P062` (or the corresponding documented section for design/theory problems).
