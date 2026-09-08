from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]


class RepositoryStructureTests(unittest.TestCase):
    def test_core_entrypoints_exist(self):
        expected = [
            ROOT / "sql/01_hospital/hospital.sql",
            ROOT / "sql/02_assignment/ASM.SQL",
            ROOT / "python/ASM_P2.py",
            ROOT / "sql/03_btl/btl.sql",
        ]
        for path in expected:
            self.assertTrue(path.exists(), path)

    def test_no_personal_student_ids_in_text(self):
        forbidden = ("521" + "H0324", "521" + "H0016", "NguyenVan" + "Truong_ASSIGNMENT")
        for path in ROOT.rglob("*"):
            if not path.is_file() or "__pycache__" in path.parts:
                continue
            try:
                text = path.read_text(encoding="utf-8")
            except UnicodeDecodeError:
                continue
            for token in forbidden:
                self.assertNotIn(token, text, f"{token} leaked in {path}")

    def test_no_zip_archives(self):
        self.assertEqual(list(ROOT.glob("*.zip")), [])

    def test_problem_count(self):
        problem_dirs = [p for p in (ROOT / "problems").iterdir() if p.is_dir()]
        self.assertEqual(len(problem_dirs), 100)

    def test_advanced_is_labeled(self):
        p52 = next((ROOT / "problems").glob("052-*/README.md"))
        self.assertIn("Advanced extension", p52.read_text(encoding="utf-8"))


if __name__ == "__main__":
    unittest.main()
