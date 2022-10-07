CREATE DATABASE DBDESIGN_PHONEBOOK

USE DBDESIGN_PHONEBOOK

 

  CREATE TABLE PhoneBook3_1
(
 NickName nvarchar(30), -- Ngoài cột này, mình còn cần thêm cột
						-- fullname, tên cty, chức vụ
--- CompanyName,....
 Phone char(11), --chỉ 1 số phone thôi, cần giải nghĩa thêm số này là loại số gì 
 PhoneType nvarchar(20)  --090x
 )

 INSERT INTO PhoneBook3_1 VALUES (N'annguyen', '098x', 'CELL')
INSERT INTO PhoneBook3_1 VALUES (N'annguyen', '091x', 'CELL')
INSERT INTO PhoneBook3_1 VALUES (N'annguyen', '091x', 'HOME')
INSERT INTO PhoneBook3_1 VALUES (N'duongpham', '090x', 'WORK')
INSERT INTO PhoneBook3_1 VALUES (N'duongpham', '091x', 'CELL')
INSERT INTO PhoneBook3_1 VALUES (N'duongpham', '092x', 'CELL')
 

 -- Tách bảng
 -- khốn nạn, Infor phân mảnh, nằm nhiều nơi, phải JOIN rồi 
 -- Nhập DATA coi chưng bị vênh, xóa DATA coi chừng lạc trôi, 
 -- Phân mảnh phải có lúc tái nhập(JOIN) JOIN trên cột nào
 -- FK xuất hiện
 -- hok thích chơi FK được ko được ko được
 -- Nếu chỉ cần join ko cần FK, cột = value, khớp là JOIN, nối bảng, ghép ngang
 -- Nếu kèm thêm xóa, sửa, thêm, chết mẹ, lộn xộn ko nhất quán
  CREATE TABLE Person4_1
(
	NickName nvarchar(30),
	Title nvarchar(30),
	Company nvarchar(40)
)
SELECT * FROM Person4_1
INSERT Person4_1 VALUES(N'hoangnt', 'lecturer', 'FPTU HCMC')
INSERT Person4_1 VALUES(N'annguyen', 'Student', 'FPTU HCMC')
INSERT Person4_1 VALUES(N'duongpham', 'Student', 'FPTU HL')


  CREATE TABLE PhoneBook4_1
(
 
  Phone char(11), 
  PhoneType nvarchar(20),
  Nick nvarchar(30) -- ko cần FK, chỉ cần join vẫn oke

 )
 SELECT * FROM Person4_1
 SELECT * FROM PhoneBook4_1

INSERT INTO PhoneBook4_1 VALUES ( '098x', 'CELL',N'hoangnt')
INSERT INTO PhoneBook4_1 VALUES (  '091x', 'CELL',N'annguyen')
INSERT INTO PhoneBook4_1 VALUES ( '091x', 'HOME',N'annguyen')
INSERT INTO PhoneBook4_1 VALUES ( '090x', 'WORK',N'duongpham')
INSERT INTO PhoneBook4_1 VALUES ( '091x', 'CELL',N'duongpham')
INSERT INTO PhoneBook4_1 VALUES ( '092x', 'CELL',N'duongpham')

-- Nhược điểm 
-- Tính ko nhất quán(inconsistency) của loại phone: có người gõ: CELL, cell éo
-- sợ vì cùng là 1 kiểu nhưng có người gõ thêm: Di động - Cả đám đều là 1 
--												Nhưng máy hiểu khác nhau
-- query liệt kê các số di động của tất cả mọi ngườ, trong khi WHERE
-- Vì ko biết được có bao nhiêu loại chữ biểu diễn di động

--SQL. Liệt kê các số di động của bạn binhle
SELECT * FROM PhoneBook4_1 WHERE PhoneType	IN('CELL', 'cell', 'DĐ')
--					Mày tính IN cái tập hợp này đến bao giờ khi người ta còn gõ từ khác
--                  Cùng biểu diễn khái niệm di động
