# P049 — Scholarship validation trigger

**Difficulty:** Medium  
**Track:** Legacy coursework: academic-management BTL  
**Topics:** trigger, multi-row

## Problem

Reject a batch if any inserted/updated scholarship exceeds policy.

## Practice contract

Solve this problem before opening the repository solution. Check not only whether the query returns rows, but also whether it is correct for duplicates, NULLs, retakes, multi-row DML, and concurrent execution when those concerns apply.

## Solution

See [`sql/03_btl/triggers.sql`](../../sql/03_btl/triggers.sql) and find the section marked `P049` (or the corresponding documented section for design/theory problems).
