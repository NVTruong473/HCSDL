# P065 — Optimistic concurrency with rowversion

**Difficulty:** Hard  
**Track:** Advanced extension  
**Topics:** rowversion

## Problem

Reject stale updates using an expected rowversion token.

## Practice contract

Solve this problem before opening the repository solution. Check not only whether the query returns rows, but also whether it is correct for duplicates, NULLs, retakes, multi-row DML, and concurrent execution when those concerns apply.

## Solution

See [`sql/04_advanced/advanced_challenges.sql`](../../sql/04_advanced/advanced_challenges.sql) and find the section marked `P065` (or the corresponding documented section for design/theory problems).
