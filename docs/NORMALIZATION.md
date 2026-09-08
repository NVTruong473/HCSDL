# Functional Dependencies, Candidate Keys & Normalization

## Attribute closure

For attribute set `X` and functional dependencies `F`, the closure `X+` is found by repeatedly adding every right-hand side `Y` where the left-hand side of `X -> Y` is already contained in the closure. `X` is a superkey when `X+` contains every attribute of the relation; it is a candidate key when no proper subset is also a superkey.

The implementation is in [`python/ASM_P2.py`](../python/ASM_P2.py), with pruning based on attributes that never occur on the right-hand side.

## Important observation from original `Input2.txt`

The old input provides:

- `CustomerID -> Name, Email`, so `CustomerID` is a candidate key of `Customer`.
- `OrderID -> CustomerID, OrderDate`; the declared PK additionally determines all attributes of `Order`.
- `(OrderID, ProductID) -> Quantity`, matching the composite key of `OrderDetails`.
- no functional dependency or primary-key declaration for `Product` in the supplied constraint section.

Therefore a rigorous algorithm must **not silently invent** `ProductID -> ProductName, Price`. With only the supplied theory input, the key cannot be inferred as `ProductID` unless that constraint/FD is added. This repo reports the data-model gap instead of guessing.

## Normal forms

### 1NF
Every attribute is atomic for the chosen model; no repeating groups or arrays are stored in a single scalar column.

### 2NF
A 1NF relation is in 2NF when every non-prime attribute depends on the **whole** candidate key, not a proper subset. This mainly matters when candidate keys are composite.

### 3NF
For every non-trivial FD `X -> A`, either `X` is a superkey or `A` is prime. Operationally, remove transitive dependencies such as storing `TenDanToc` directly in `SinhVien` when it depends on `MaDanToc`.

### BCNF
For every non-trivial FD `X -> Y`, `X` must be a superkey. BCNF is stricter than 3NF and can trade dependency preservation for stronger redundancy control.

## P081–P085 design exercises

- **P081:** decompose repeated hometown/address data into referenced relations instead of duplicating city/district/ward text.
- **P082:** given `R(A,B,C)` with `AB -> C` and `C -> B`, `C -> B` violates BCNF if `C` is not a superkey. Decompose using the violating dependency and verify losslessness.
- **P083:** test a decomposition for lossless join (common-attribute intersection functionally determines one side) and then test whether all original FDs can be enforced without joining relations.
- **P084:** use natural/composite keys when they are stable and meaningful; use surrogate keys when the natural key is wide, mutable, sensitive, or operationally awkward. Keep business uniqueness with a `UNIQUE` constraint even when a surrogate PK is chosen.
- **P085:** use `ON DELETE CASCADE` only when child rows have no independent lifecycle and deletion semantics are intentional. Prefer `NO ACTION`/restrict for records such as grades/audit history unless the domain explicitly requires cascade.
