# P091 — Sequence-based identifiers

**Difficulty:** Medium  
**Track:** Advanced extension  
**Topics:** SEQUENCE, concurrency

## Problem

Generate numeric identifiers without IDENTITY and without MAX+1 races.

## Practice contract

Solve this problem before opening the repository solution. Check not only whether the query returns rows, but also whether it is correct for duplicates, NULLs, retakes, multi-row DML, and concurrent execution when those concerns apply.

## Solution

See [`sql/04_advanced/security.sql`](../../sql/04_advanced/security.sql) and find the section marked `P091` (or the corresponding documented section for design/theory problems).
