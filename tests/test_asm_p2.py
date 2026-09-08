import importlib.util
from pathlib import Path
import unittest

MODULE_PATH = Path(__file__).resolve().parents[1] / "python" / "ASM_P2.py"
spec = importlib.util.spec_from_file_location("asm_p2", MODULE_PATH)
asm = importlib.util.module_from_spec(spec)
assert spec.loader is not None
import sys
sys.modules[spec.name] = asm
spec.loader.exec_module(asm)


class RelationalTheoryTests(unittest.TestCase):
    def test_parse_n_to_one(self):
        rel = asm.parse_relationship_line("[Sinh vien] (Masv, hoten) (Masv: PK) – [Lop hoc] (MaLop, Tenlop) (MaLop: PK): n – 1")
        self.assertEqual(rel.kind, "n-1")
        mapped = "\n".join(asm.map_relationship(rel))
        self.assertIn("MaLop", mapped)
        self.assertIn("FK", mapped)

    def test_many_to_many_builds_bridge(self):
        rel = asm.parse_relationship_line("[Sinh vien] (Masv, hoten) (Masv: PK) – [Mon hoc] (Mamon, tenmon) (Mamon: PK): n – n")
        mapped = asm.map_relationship(rel)
        self.assertEqual(len(mapped), 3)
        self.assertIn("Sinh_vien_Mon_hoc", mapped[1])
        self.assertIn("Masv", mapped[1])
        self.assertIn("Mamon", mapped[1])

    def test_closure(self):
        fds = [
            asm.FunctionalDependency(frozenset({"A"}), frozenset({"B"})),
            asm.FunctionalDependency(frozenset({"B"}), frozenset({"C"})),
        ]
        self.assertEqual(asm.closure({"A"}, fds), frozenset({"A", "B", "C"}))

    def test_candidate_keys_multiple(self):
        fds = [
            asm.FunctionalDependency(frozenset({"A"}), frozenset({"B"})),
            asm.FunctionalDependency(frozenset({"B"}), frozenset({"A"})),
        ]
        keys = set(asm.candidate_keys({"A", "B", "C"}, fds))
        self.assertEqual(keys, {frozenset({"A", "C"}), frozenset({"B", "C"})})

    def test_composite_fd_parser(self):
        fds = asm.parse_fd_list("(OrderID, ProductID -> Quantity)")
        self.assertEqual(fds[0].lhs, frozenset({"OrderID", "ProductID"}))
        self.assertEqual(fds[0].rhs, frozenset({"Quantity"}))

    def test_original_style_schema(self):
        text = """\
# Các bảng trong cơ sở dữ liệu
Customer: (CustomerID, Name, Email)
OrderDetails: (OrderID, ProductID, Quantity)
# Các phụ thuộc hàm
Customer: (CustomerID -> Name, CustomerID -> Email)
OrderDetails: (OrderID, ProductID -> Quantity)
# Các ràng buộc
Customer: (PRIMARY KEY(CustomerID), UNIQUE(Email))
OrderDetails: (PRIMARY KEY(OrderID, ProductID))
"""
        model = asm.parse_schema_and_fds(text)
        customer_keys = asm.candidate_keys(*model["Customer"])
        detail_keys = asm.candidate_keys(*model["OrderDetails"])
        self.assertEqual(customer_keys, [frozenset({"CustomerID"})])
        self.assertEqual(detail_keys, [frozenset({"OrderID", "ProductID"})])


if __name__ == "__main__":
    unittest.main()
