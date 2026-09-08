# P069 — Keyset pagination

**Difficulty:** Medium  
**Track:** Advanced extension  
**Topics:** pagination, index

## Problem

Page by the last seen primary key instead of deep OFFSET scans.

## Practice contract

Solve this problem before opening the repository solution. Check not only whether the query returns rows, but also whether it is correct for duplicates, NULLs, retakes, multi-row DML, and concurrent execution when those concerns apply.

## Solution

See [`sql/04_advanced/advanced_challenges.sql`](../../sql/04_advanced/advanced_challenges.sql) and find the section marked `P069` (or the corresponding documented section for design/theory problems).
