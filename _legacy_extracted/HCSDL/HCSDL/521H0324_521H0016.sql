CREATE DATABASE MYSQL
GO
USE MYSQL
GO

CREATE TABLE Nhan_Vien
(
	MaNV VARCHAR(50) PRIMARY KEY NOT NULL,
	Ho_ten VARCHAR(50) NOT NULL,
	Ngay_sinh DATE NOT NULL,
	Dia_chi VARCHAR(50) NOT NULL,
	So_Dien_Thoai VARCHAR(50) NOT NULL
)
INSERT into Nhan_vien VALUES('NV01','Nguyen Van Truong','2003-07-08', 'TPHCM', '0378882992')
INSERT into Nhan_vien VALUES('NV02','Nguyen Hong Son','2003-11-09','TPHCM', '0374462912')
INSERT into Nhan_vien VALUES('NV03','Le Thái Thanh','2003-07-29', 'TPHCM','0356273737')
INSERT into Nhan_vien VALUES('NV04','Bui Anh Tuấn','2003-04-19', 'TPHCM','0738228391')
INSERT into Nhan_vien VALUES('NV05','Tran Thi Tam','2003-11-16', 'TPHCM','0384720193')

CREATE TABLE NVVP
(
	MaNV VARCHAR(50) PRIMARY KEY NOT NULL,
	Loai_CV VARCHAR(50) NOT NULL,
	FOREIGN KEY(MaNV) REFERENCES Nhan_Vien (MaNV)
)
INSERT into NVVP VALUES('NV01','quan li dl')
INSERT into NVVP VALUES('NV02','quan li ds benh nhan')
INSERT into NVVP VALUES('NV03','thu ngan')
INSERT into NVVP VALUES('NV04','quan li camera')
INSERT into NVVP VALUES('NV05','quan li ds nguoi nha') 

CREATE TABLE Y_Ta
(
	MaNV VARCHAR(50) PRIMARY KEY NOT NULL,
	MSCC VARCHAR(50) NOT NULL,
	TenKDT VARCHAR(50) NOT NULL,
	FOREIGN KEY (MaNV) REFERENCES Nhan_Vien(MaNV)
)
INSERT INTO Y_Ta VALUES('NV01','CC01', 'Khoa Ngoai')
INSERT INTO Y_Ta VALUES('NV02','CC02', 'Khoa Da Lieu')
INSERT INTO Y_Ta VALUES('NV03','CC03', 'Khoa Ung Buu')
INSERT INTO Y_Ta VALUES('NV04','CC04', 'Khoa Noi')
INSERT INTO Y_Ta VALUES('NV05','CC05', 'Khoa San')

CREATE TABLE Khu_Dieu_Tri
(
	Ten VARCHAR(50) PRIMARY KEY NOT NULL,
	Dia_Diem VARCHAR(50) NOT NULL,
	MaYT VARCHAR(50) NOT NULL,
	FOREIGN KEY (MaYT) REFERENCES Y_Ta(MaNV)
)
INSERT INTO Khu_Dieu_Tri VALUES('Khoa Ngoai', 'Khu A', 'NV01')
INSERT INTO Khu_Dieu_Tri VALUES('Khoa Da Lieu', 'Khu B', 'NV02')
INSERT INTO Khu_Dieu_Tri VALUES('Khoa Ung Buu', 'Khu A1', 'NV03')
INSERT INTO Khu_Dieu_Tri VALUES('Khoa Noi', 'Khu B2', 'NV04')
INSERT INTO Khu_Dieu_Tri VALUES('Khoa San', 'Khu C', 'NV05')

CREATE TABLE Benh_Nhan
(
	MaSo VARCHAR(50) PRIMARY KEY NOT NULL,
	Dia_chi VARCHAR(50) NOT NULL,
	Ngay_Nhap_Vien DATE NOT NULL
)
INSERT INTO Benh_Nhan VALUES('BN01', 'TPHCM', '2022-01-02')
INSERT INTO Benh_Nhan VALUES('BN02', 'TPHCM', '2022-03-02')
INSERT INTO Benh_Nhan VALUES('BN03', 'BR-VT', '2022-06-03')
INSERT INTO Benh_Nhan VALUES('BN04', 'DongNai', '2022-03-28')
INSERT INTO Benh_Nhan VALUES('BN05', 'BinhThuan', '2022-01-04')

CREATE TABLE Y_Si
(
	MaNV VARCHAR(50) PRIMARY KEY NOT NULL,
	Chuyen_Nghanh VARCHAR(50) NOT NULL,
	MaBN VARCHAR(50) NOT NULL,
	FOREIGN KEY (MaNV) REFERENCES Nhan_Vien(MaNV),
	FOREIGN KEY (MaBN) REFERENCES Benh_Nhan(MaSo)
)
INSERT INTO Y_Si VALUES('NV01' ,'Nhan Khoa', 'BN01')
INSERT INTO Y_Si VALUES('NV02' ,'Nhi Khoa', 'BN02')
INSERT INTO Y_Si VALUES('NV03' ,'San Khoa', 'BN03')
INSERT INTO Y_Si VALUES('NV04' ,'San Khoa', 'BN04')
INSERT INTO Y_Si VALUES('NV05' ,'Nhan Khoa', 'BN05')

CREATE TABLE KT_Vien
(
	MaNV VARCHAR(50) PRIMARY KEY NOT NULL,
	Ky_Nang VARCHAR(50) NOT NULL,
	FOREIGN KEY (MaNV) REFERENCES Nhan_Vien(MaNV)
)
INSERT INTO KT_Vien VALUES('NV01' ,'Xet Nghiem')
INSERT INTO KT_Vien VALUES('NV02' ,'Dieu Che')
INSERT INTO KT_Vien VALUES('NV03' ,'Xet Nghiem')
INSERT INTO KT_Vien VALUES('NV04' ,'Dieu che')
INSERT INTO KT_Vien VALUES('NV05' ,'Xet Nghiem')

CREATE TABLE PTN
(
	Ten VARCHAR(50) PRIMARY KEY NOT NULL,
	Dia_Diem VARCHAR(50) NOT NULL
)

INSERT INTO PTN VALUES('A1', 'Khu A')
INSERT INTO PTN VALUES('A2', 'Khu A')
INSERT INTO PTN VALUES('B1', 'Khu B')
INSERT INTO PTN VALUES('B2', 'Khu B')
INSERT INTO PTN VALUES('DB', 'Khu C')

CREATE TABLE Chi_Tiet_PTN
(
	MaNV VARCHAR(50) NOT NULL,
	TenPTN VARCHAR(50) NOT NULL,
	PRIMARY KEY (MaNV,TenPTN),
	FOREIGN KEY (MaNV) REFERENCES Nhan_Vien(MaNV),
	FOREIGN KEY (TenPTN) REFERENCES PTN(Ten)
)
GO

INSERT INTO Chi_Tiet_PTN VALUES('NV01', 'A1')
INSERT INTO Chi_Tiet_PTN VALUES('NV02', 'A2')
INSERT INTO Chi_Tiet_PTN VALUES('NV03', 'B1')
INSERT INTO Chi_Tiet_PTN VALUES('NV04', 'B2')
INSERT INTO Chi_Tiet_PTN VALUES('NV05', 'DB')

---LIET NHAN VIEN CO DIA CHI O TPHCM--
---nhân viên ở TPHCM và có họ Nguyen---
select Ho_Ten from Nhan_Vien where Ho_Ten = 'Nguyen%' 
union
select Ho_Ten from Nhan_Vien where Dia_Chi= 'TPHCM'

---liet ke ma benh nhan khong duoc y si cham soc---
select *from Benh_Nhan
where MaSo not in (SELECT MaBN from Y_Si)

-- Liệt kê bệnh nhân có địa chỉ tại TPHCM---
select * from Benh_Nhan where Dia_Chi = 'TPHCM'

---Liệt kê sinh viên có họ là “Nguyễn”, & lớn hơn 18 tuổi---
select * from Nhan_Vien where Ho_ten LIKE N'Nguyen%' and 
year(getDate()) - year(Ngay_sinh) > 18 

--Liệt kê những nhân viên là y tá
select MaNV from Nhan_Vien
intersect
select MaNV from Y_Ta

