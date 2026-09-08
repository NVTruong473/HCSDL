# -*- coding: utf-8 -*-
"""Original name preserved: ASM_P2.py

Refactored solutions for P007-P012:
- ERD/cardinality text -> relational mapping
- attribute closure
- minimal candidate-key enumeration

The module has no third-party dependencies and is import-safe for tests.
"""
from __future__ import annotations

from dataclasses import dataclass
from itertools import combinations
import argparse
import re
from pathlib import Path
from typing import Iterable, Sequence


@dataclass(frozen=True)
class Entity:
    name: str
    attributes: tuple[str, ...]
    primary_key: tuple[str, ...]


@dataclass(frozen=True)
class Relationship:
    left: Entity
    right: Entity
    kind: str


@dataclass(frozen=True)
class FunctionalDependency:
    lhs: frozenset[str]
    rhs: frozenset[str]


_ENTITY_RE = re.compile(r"\[([^\]]+)\]\s*\(([^)]*)\)(?:\s*\(([^)]*)\))?")


def _split_attrs(text: str) -> tuple[str, ...]:
    return tuple(part.strip() for part in text.split(",") if part.strip())


def _extract_pk(attributes: Sequence[str], constraint_text: str | None) -> tuple[str, ...]:
    if constraint_text:
        pks = []
        for part in _split_attrs(constraint_text):
            if ":" in part:
                name, annotation = part.split(":", 1)
                if "PK" in annotation.upper():
                    pks.append(name.strip())
        if pks:
            return tuple(pks)
    # Without an explicit key, do not pretend the model is certain.
    return (attributes[0],) if attributes else tuple()


def normalize_relationship_kind(raw: str) -> str:
    value = raw.strip().lower().replace("–", "-").replace("—", "-")
    value = re.sub(r"\s+", "", value)
    aliases = {"1-1": "1-1", "n-1": "n-1", "n-n": "n-n", "cha-con": "parent-child"}
    if value not in aliases:
        raise ValueError(f"Unsupported relationship type: {raw!r}")
    return aliases[value]


def parse_relationship_line(line: str) -> Relationship:
    """Parse one original Input1-style ERD line."""
    matches = list(_ENTITY_RE.finditer(line))
    if len(matches) != 2:
        raise ValueError(f"Expected exactly two entities: {line}")

    entities = []
    for match in matches:
        attrs = _split_attrs(match.group(2))
        entities.append(Entity(match.group(1).strip(), attrs, _extract_pk(attrs, match.group(3))))

    if ":" not in line:
        raise ValueError(f"Missing relationship cardinality: {line}")
    kind = normalize_relationship_kind(line.rsplit(":", 1)[1])
    return Relationship(entities[0], entities[1], kind)


def map_relationship(rel: Relationship) -> list[str]:
    """Return a compact relational mapping for P007-P010."""
    left, right = rel.left, rel.right
    if not left.primary_key or not right.primary_key:
        raise ValueError("Both entities need a key to map their relationship")

    if rel.kind == "n-1":
        fk = right.primary_key
        return [
            f"{left.name}({', '.join(left.attributes + tuple(fk))}) [FK {fk} -> {right.name}]",
            f"{right.name}({', '.join(right.attributes)})",
        ]
    if rel.kind == "n-n":
        bridge = f"{left.name.replace(' ', '_')}_{right.name.replace(' ', '_')}"
        keys = left.primary_key + right.primary_key
        return [
            f"{left.name}({', '.join(left.attributes)})",
            f"{bridge}({', '.join(keys)}) [PK {keys}; FKs to both parents]",
            f"{right.name}({', '.join(right.attributes)})",
        ]
    if rel.kind == "1-1":
        # Cardinality alone does not reveal optionality; choose right->left by convention
        # and mark the FK UNIQUE so the mapping really stays one-to-one.
        fk = left.primary_key
        return [
            f"{left.name}({', '.join(left.attributes)})",
            f"{right.name}({', '.join(right.attributes + tuple(fk))}) [UNIQUE FK {fk} -> {left.name}]",
        ]
    if rel.kind == "parent-child":
        return [
            f"{left.name}({', '.join(left.attributes)})",
            f"{right.name}({', '.join(left.primary_key + right.attributes)}) [PK/FK {left.primary_key} -> {left.name}]",
        ]
    raise AssertionError(rel.kind)


def convert_erd_text(text: str) -> str:
    out: list[str] = []
    for raw in text.splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        rel = parse_relationship_line(line)
        out.append(f"# {rel.left.name} {rel.kind} {rel.right.name}")
        out.extend(map_relationship(rel))
    return "\n".join(out) + ("\n" if out else "")


def closure(attributes: Iterable[str], fds: Iterable[FunctionalDependency]) -> frozenset[str]:
    result = set(attributes)
    fd_list = list(fds)
    changed = True
    while changed:
        changed = False
        for fd in fd_list:
            if fd.lhs <= result and not fd.rhs <= result:
                result.update(fd.rhs)
                changed = True
    return frozenset(result)


def candidate_keys(attributes: Iterable[str], fds: Iterable[FunctionalDependency]) -> list[frozenset[str]]:
    """Enumerate all minimal candidate keys with mandatory-attribute pruning."""
    universe = frozenset(attributes)
    fd_list = list(fds)
    if not universe:
        return [frozenset()]

    rhs_attrs = frozenset().union(*(fd.rhs for fd in fd_list)) if fd_list else frozenset()
    mandatory = universe - rhs_attrs
    optional = sorted(universe - mandatory)
    keys: list[frozenset[str]] = []

    for size in range(len(optional) + 1):
        for extra in combinations(optional, size):
            candidate = frozenset(set(mandatory) | set(extra))
            if any(key <= candidate for key in keys):
                continue
            if closure(candidate, fd_list) == universe:
                keys.append(candidate)
    return keys


def parse_fd_list(text: str) -> list[FunctionalDependency]:
    """Parse comma-separated original syntax, including composite LHS like A, B -> C."""
    body = text.strip().strip("()")
    tokens = [token.strip() for token in body.split(",") if token.strip()]
    pending_lhs: list[str] = []
    result: list[FunctionalDependency] = []
    for token in tokens:
        if "->" not in token:
            pending_lhs.append(token)
            continue
        left_tail, right = token.split("->", 1)
        lhs = [*pending_lhs, left_tail.strip()]
        pending_lhs.clear()
        rhs = [right.strip()]
        result.append(FunctionalDependency(frozenset(lhs), frozenset(rhs)))
    if pending_lhs:
        raise ValueError(f"Unparsed FD fragment: {pending_lhs}")
    return result


def parse_schema_and_fds(text: str) -> dict[str, tuple[frozenset[str], list[FunctionalDependency]]]:
    schemas: dict[str, frozenset[str]] = {}
    fd_map: dict[str, list[FunctionalDependency]] = {}
    section = "schema"

    for raw in text.splitlines():
        line = raw.strip()
        if not line:
            continue
        if line.startswith("#"):
            if "phụ thuộc" in line.lower() or "functional" in line.lower():
                section = "fds"
            elif "ràng buộc" in line.lower() or "constraint" in line.lower():
                section = "constraints"
            continue
        if ":" not in line:
            continue
        table, body = line.split(":", 1)
        table = table.strip()
        if section == "schema":
            schemas[table] = frozenset(_split_attrs(body.strip().strip("()")))
        elif section == "fds":
            fd_map.setdefault(table, []).extend(parse_fd_list(body))
        elif section == "constraints":
            # Primary keys are authoritative FDs to all attributes in that relation.
            m = re.search(r"PRIMARY\s+KEY\s*\(([^)]*)\)", body, flags=re.I)
            if m and table in schemas:
                pk = frozenset(_split_attrs(m.group(1)))
                fd_map.setdefault(table, []).append(FunctionalDependency(pk, schemas[table] - pk))

    return {name: (attrs, fd_map.get(name, [])) for name, attrs in schemas.items()}


def solve_candidate_keys_text(text: str) -> str:
    model = parse_schema_and_fds(text)
    lines: list[str] = []
    for table, (attrs, fds) in model.items():
        keys = candidate_keys(attrs, fds)
        rendered = ["{" + ", ".join(sorted(key)) + "}" for key in keys]
        lines.append(f"{table}: {', '.join(rendered)}")
    return "\n".join(lines) + "\n"


def main() -> None:
    parser = argparse.ArgumentParser(description="Database LeetCode relational-theory tools")
    sub = parser.add_subparsers(dest="command", required=True)

    erd = sub.add_parser("erd", help="convert Input1-style ERD text")
    erd.add_argument("input", type=Path)
    erd.add_argument("output", type=Path)

    keys = sub.add_parser("keys", help="find candidate keys from Input2-style text")
    keys.add_argument("input", type=Path)
    keys.add_argument("output", type=Path)

    args = parser.parse_args()
    text = args.input.read_text(encoding="utf-8")
    if args.command == "erd":
        args.output.write_text(convert_erd_text(text), encoding="utf-8")
    else:
        args.output.write_text(solve_candidate_keys_text(text), encoding="utf-8")


if __name__ == "__main__":
    main()
