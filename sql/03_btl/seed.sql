USE DatabaseLeetCode_BTL;
GO

INSERT dbo.DanToc VALUES (1,N'Kinh'),(2,N'Tày'),(3,N'Thái'),(4,N'Mường'),(5,N'Nùng');
INSERT dbo.TonGiao VALUES (1,N'Không'),(2,N'Phật Giáo'),(3,N'Thiên Chúa Giáo'),(4,N'Cao Đài'),(5,N'Hòa Hảo');
INSERT dbo.QueQuan VALUES
(1,N'Hà Nội',N'Ba Đình',N'Giảng Võ'),
(2,N'Hà Nội',N'Hoàn Kiếm',N'Nguyễn Du'),
(3,N'TP. Hồ Chí Minh',N'Quận 1',N'Bến Nghé'),
(4,N'Đà Nẵng',N'Hải Châu',N'Thạch Thang'),
(5,N'Hải Phòng',N'Lê Chân',N'Dư Hàng Kênh');

INSERT dbo.MonHoc VALUES
(1,N'Toán Đại Cương',45,15),(2,N'Vật Lý Cơ Bản',40,20),(3,N'Hóa Học',35,25),
(4,N'Lập Trình Cơ Bản',30,30),(5,N'Giáo dục Quốc phòng',20,10);

INSERT dbo.GiaoVien VALUES
(1,N'Nguyễn Văn A',1,'1980-05-15','0909123456',N'Hà Nội','nguyenvana@example.com',1,1,2),
(2,N'Trần Thị B',0,'1985-08-22','0918123456',N'Hà Nội','tranthib@example.com',2,2,1),
(3,N'Lê Văn C',1,'1975-12-10','0927123456',N'TP.HCM','levanc@example.com',3,3,3),
(4,N'Phạm Thị D',0,'1990-03-05','0936123456',N'Đà Nẵng','phamthid@example.com',4,4,4),
(5,N'Hoàng Văn E',1,'1982-07-18','0945123456',N'Hải Phòng','hoangvane@example.com',5,5,5);

INSERT dbo.Lop VALUES
(1,N'Lớp 10A1',N'CNTT',1),(2,N'Lớp 10A2',N'CNTT',2),(3,N'Lớp 10B1',N'Vật Lý',3),
(4,N'Lớp 10B2',N'Hóa Học',4),(5,N'Lớp 10C1',N'Toán',5);

INSERT dbo.SinhVien (MaSinhVien,HoSinhVien,TenSinhVien,MaLop,Phai,NgaySinh,DiaChi,MaQueQuan,MaDanToc,MaTonGiao,HocBong) VALUES
(1,N'Nguyễn Văn',N'Anh',1,1,'2005-01-10',N'Hà Nội',1,1,2,6000000),
(2,N'Trần Thị',N'Bích',1,0,'2005-02-20',N'Hà Nội',2,2,1,3000000),
(3,N'Lê Văn',N'Cường',2,1,'2005-03-15',N'TP.HCM',3,3,3,0),
(4,N'Phạm Thị',N'Diễm',2,0,'2005-04-25',N'Đà Nẵng',4,4,4,4500000),
(5,N'Hoàng Văn',N'Em',3,1,'2005-05-30',N'Hải Phòng',5,5,5,7000000),
(6,N'Nguyễn Văn',N'Phúc',3,1,'2005-06-18',N'Hà Nội',1,1,2,0),
(7,N'Trần Thị',N'Giang',4,0,'2005-07-22',N'Hà Nội',2,2,1,2000000),
(8,N'Lê Văn',N'Hùng',4,1,'2005-08-14',N'TP.HCM',3,3,3,5000000),
(9,N'Phạm Thị',N'Ích',5,0,'2005-09-09',N'Đà Nẵng',4,4,4,0),
(10,N'Hoàng Văn',N'Khang',5,1,'2005-10-01',N'Hải Phòng',5,5,5,8000000);

INSERT dbo.PhanCong VALUES
(1,1,1,1,1,2024,'2024-09-01','2024-12-20'),
(2,2,3,1,1,2024,'2024-09-01','2024-12-20'),
(3,4,2,2,1,2024,'2024-09-01','2024-12-20'),
(4,3,4,3,1,2024,'2024-09-01','2024-12-20'),
(5,5,5,4,1,2024,'2024-09-01','2024-12-20'),
(6,4,1,5,1,2024,'2024-09-01','2024-12-20');

-- Results respect each assignment's class membership.
INSERT dbo.KetQua VALUES
(1,1,1,8.5,N'Đạt'),(1,2,1,4.5,N'Không đạt'),(1,2,2,6.0,N'Đạt sau thi lại'),
(2,1,1,7.0,N'Đạt'),(2,2,1,5.5,N'Đạt'),
(3,3,1,7.0,N'Đạt'),(3,4,1,6.5,N'Đạt'),
(4,5,1,7.5,N'Đạt'),(4,6,1,4.0,N'Không đạt'),(4,6,2,5.5,N'Đạt sau thi lại'),
(5,7,1,3.5,N'Không đạt'),(5,7,2,5.0,N'Đạt sau thi lại'),(5,8,1,8.0,N'Đạt'),
(6,9,1,6.0,N'Đạt'),(6,10,1,4.5,N'Không đạt'),(6,10,2,6.0,N'Đạt sau thi lại');
GO
