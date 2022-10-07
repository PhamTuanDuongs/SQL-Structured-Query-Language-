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
 

  CREATE TABLE PhoneBook4_1
(
 
  Phone char(11), 
  PhoneType nvarchar(20),-- Cho gõ trực tiếp loại phone, gây nên lộn xộn về loại Phone, Cell, DĐ, MObile
						-- Thống kê khó khăn, và còn tiếp tục sửa nữa do gõ tự do
						-- hạn chế ko cho gõ lộn xộn, tức là phải gõ theo ai đó có trước, FK
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
-- 


-- Quy tắc thêm có những loại data biết trước là nhiều nhưng hữu hạn cái value để nhập
-- Tỉnh thành nhiều, chỉ 63, Quốc gia nhiều 230, châu lục nhiều 56, trường THPT
-- Có nên cho người ta gõ tay hay ko, ko vì nó sẽ gây nên ko nhất quán!!!
-- Tốt nhất cho chọn, bởi vì nếu cho tự gõ nó sẽ thành tam sao thất bản 
-- Tốt nhất cho chọn, chọn phải từ cái có sẵn, sẵn tức là từ table khác

 -- Ko cho gõ lung tung, gõ trong cái đã có - Dính đến 2 thứ, table khác(Đã nói ở trên)


   CREATE TABLE Person5_1
(
	NickName nvarchar(30),
	Title nvarchar(30),
	Company nvarchar(40)
)
SELECT * FROM Person5_1
INSERT Person5_1 VALUES(N'hoangnt', 'lecturer', 'FPTU HCMC')
INSERT Person5_1 VALUES(N'annguyen', 'Student', 'FPTU HCMC')
INSERT Person5_1 VALUES(N'duongpham', 'Student', 'FPTU HL')



CREATE TABLE PhoneTypeV5_1
(
	 TypeName nvarchar(20)
)
-- ko muốn xóa table mà vẫn thêm khóa chính
ALTER TABLE PhoneTypeV5_1 ADD CONSTRAINT PK_PHONETYPEV5_1 PRIMARY KEY (TypeName)

-- câu lệnh thay đổi trạng thái của  cột trong 1 bảng thay vì DROP mình dùng cách dưới 
ALTER TABLE PhoneTypeV5_1 ALTER COLUMN TypeName nvarchar(20) NOT NULL

SELECT * FROM PhoneTypeV5_1
SELECT * FROM Person5_1

INSERT INTO PhoneTypeV5_1 VALUES (N'Di Động')
INSERT INTO PhoneTypeV5_1 VALUES (N'Nhà/Để bàn')
INSERT INTO PhoneTypeV5_1 VALUES (N'Công ty')
INSERT INTO PhoneTypeV5_1 VALUES (N'Cha dượng ngọt ngào')

  
    CREATE TABLE PhoneBook5_1
(
 
  Phone char(11), 
  TypeName nvarchar(20) REFERENCES PhoneTypeV5_1(TypeName),
  Nick nvarchar(30)  
)

SELECT * FROM PhoneTypeV5_1
SELECT * FROM Person5_1
SELECT * FROM PhoneBook5_1

INSERT INTO PhoneBook5_1 VALUES ( '098x', N'Di Động',N'hoangnt')
INSERT INTO PhoneBook5_1 VALUES (  '091x', N'Nhà/Để bàn',N'annguyen')
INSERT INTO PhoneBook5_1 VALUES (  '091x', N'Cha dượng ngọt ngào',N'binhle')
 
 ---================================================================
 --- Phiên bản Final đẹp

    CREATE TABLE Person6
(
	NickName nvarchar(30) PRIMARY KEY,  -- Còn cần học thêm về key PK here/ Performance 
	Title nvarchar(30),
	Company nvarchar(40)
)
INSERT INTO Person6 VALUES(N'hoangnt', N'Giám Đốc', 'FPT' )


CREATE TABLE PhoneType6
(
	 TypeName nvarchar(20) PRIMARY KEY
)
INSERT INTO PhoneType6 VALUES('CELL')
INSERT INTO PhoneType6 VALUES('WORK')
INSERT INTO PhoneType6 VALUES('HOME')
 
    CREATE TABLE PhoneBook6
(
 
  Phone char(11) NOT NULL, 
  TypeName nvarchar(20) REFERENCES PhoneType6(TypeName), -- Nó thuộc loại nào
  Nick nvarchar(30)  REFERENCES Person6(NickName) -- của thằng cu nào
  -- loại gì và của ai, ko gõ lung tung
  CONSTRAINT PK_PHONEBOOKS6 PRIMARY KEY(Phone)

)

SELECT * FROM Person6
SELECT * FROM PhoneType6
SELECT * FROM PhoneBook6
SELECT * FROM Person6, PhoneType6, PhoneBook6
INSERT INTO PhoneBook6 VALUES ( '098x', 'CELL',N'hoangnt')
INSERT INTO PhoneBook6 VALUES (  '091x', N'Nhà/Để bàn',N'annguyen')
INSERT INTO PhoneBook6 VALUES (  '091x', N'Cha dượng ngọt ngào',N'binhle')
