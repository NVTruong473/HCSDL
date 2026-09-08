# P072 — Idempotent seed script

**Difficulty:** Medium  
**Track:** Advanced extension  
**Topics:** deployment, idempotency

## Problem

Make a seed operation safe to run more than once.

## Practice contract

Solve this problem before opening the repository solution. Check not only whether the query returns rows, but also whether it is correct for duplicates, NULLs, retakes, multi-row DML, and concurrent execution when those concerns apply.

## Solution

See [`sql/04_advanced/advanced_challenges.sql`](../../sql/04_advanced/advanced_challenges.sql) and find the section marked `P072` (or the corresponding documented section for design/theory problems).
