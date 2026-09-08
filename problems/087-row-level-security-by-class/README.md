# P087 — Row-level security by class

**Difficulty:** Hard  
**Track:** Advanced extension  
**Topics:** RLS, security policy

## Problem

Filter student visibility by a class id stored in SESSION_CONTEXT.

## Practice contract

Solve this problem before opening the repository solution. Check not only whether the query returns rows, but also whether it is correct for duplicates, NULLs, retakes, multi-row DML, and concurrent execution when those concerns apply.

## Solution

See [`sql/04_advanced/security.sql`](../../sql/04_advanced/security.sql) and find the section marked `P087` (or the corresponding documented section for design/theory problems).
