from pathlib import Path
import re

root = Path(__file__).resolve().parents[1]
problem_root = root / "problems"
folders = sorted(p for p in problem_root.iterdir() if p.is_dir())
ids = []
for folder in folders:
    m = re.match(r"(\d{3})-", folder.name)
    if not m:
        raise SystemExit(f"Invalid problem folder name: {folder.name}")
    ids.append(int(m.group(1)))
    readme = folder / "README.md"
    if not readme.exists():
        raise SystemExit(f"Missing README: {folder}")

expected = list(range(1, 101))
if ids != expected:
    missing = sorted(set(expected)-set(ids))
    extra = sorted(set(ids)-set(expected))
    raise SystemExit(f"Catalog mismatch. Missing={missing}, extra={extra}")

index = (problem_root / "README.md").read_text(encoding="utf-8")
for pid in expected:
    if f"P{pid:03d}" not in index:
        raise SystemExit(f"P{pid:03d} missing from catalog index")
print("OK: 100 numbered problem folders and index entries verified.")
