# P014 — Generate SV code without IDENTITY

**Difficulty:** Hard  
**Track:** Original: ASM.SQL  
**Topics:** SEQUENCE, concurrency

## Problem

Insert a student with an SVxxxx key generated automatically without IDENTITY and without MAX+1 races.

## Practice contract

Solve this problem before opening the repository solution. Check not only whether the query returns rows, but also whether it is correct for duplicates, NULLs, retakes, multi-row DML, and concurrent execution when those concerns apply.

## Solution

See [`sql/02_assignment/ASM.SQL`](../../sql/02_assignment/ASM.SQL) and find the section marked `P014` (or the corresponding documented section for design/theory problems).
