CREATE DATABASE DBDESIGN_ONEMANY

USE DBDESIGN_ONEMANY

-- Table 1 tạo trước, Table N tạo sau
CREATE TABLE MajorV1
(
		MajorID char(2) PRIMARY KEY, --mặc định Dbe tự tạo tên ràng buộc
		MajorName nvarchar(40) NOT NULL
)
-- Chèn Data - Mua quần áo bỏ vào tủ
INSERT INTO MajorV1 VALUES('SE', N'Kĩ thuật phần mềm')
INSERT INTO MajorV1 VALUES('IA', N'Kĩ thuật phần mềm')

CREATE TABLE StudentV1
(
	StudentID char(8) NOT NULL ,  
	LastName nvarchar(40) NOT NULL,  
	FirstName nvarchar(10) NOT NULL, 
	DOB datetime NULL,
	Address nvarchar(50) NULL, -- thừa từ NULL. do default là vậy
	MID char(2), -- tên cột khóa ngoại/ tham chiếu không cần trùng với bên 1-key
			   -- bắt buộc trùng 100% kiểu dữ liệu, cần tham chiếu data

	--PRIMARY KEY(StudentID)  -- tự database engine đặt cho 
	Constraint PK_StudentsV1 PRIMARY KEY (StudentID)
)

SELECT * FROM StudentV1
SELECT * FROM MajorV1

INSERT INTO StudentV1 VALUES ('SE1', N'Nguyễn', N'An', NULL, NULL, 'SE')

-- Thiết kế ở trên là sai vì không có tham chiếu giữa hai MajorID của Students vs Major phía trên
-- 
INSERT INTO StudentV1 VALUES ('SE2', N'Lê', N'Bình', NULL, NULL, 'Ah')



--- Version 2

CREATE TABLE MajorV2
(
		MajorID char(2) PRIMARY KEY, --mặc định Dbe tự tạo tên ràng buộc
		MajorName nvarchar(40) NOT NULL
)
-- Chèn Data - Mua quần áo bỏ vào tủ
SELECT * FROM MajorV2
INSERT INTO MajorV2 VALUES('SE', N'Kĩ thuật phần mềm')
INSERT INTO MajorV2 VALUES('IA', N'Kĩ thuật phần mềm')

CREATE TABLE StudentV2
(
	StudentID char(8) PRIMARY KEY ,  
	LastName nvarchar(40) NOT NULL,  
	FirstName nvarchar(10) NOT NULL, 
	DOB datetime NULL,
	Address nvarchar(50) NULL, -- thừa từ NULL. do default là vậy
	--MajorID char(2) REFERENCES MajorV2(MajorID),
	MajorID char(2) FOREIGN KEY REFERENCES MajorV2(MajorID)
	-- tớ chọn chuyên nghành ở trên kia kìa, xin tham chiếu ở trên kia kìa
 
)
 
 
INSERT INTO StudentV2 VALUES ('SE1', N'Nguyễn', N'An', NULL, NULL, 'SE')

INSERT INTO StudentV2 VALUES ('SE2', N'Lê', N'Bình', NULL, NULL, 'Ah') -- ko khớp với Foreign key

SELECT * FROM StudentV2

-- Ko được xóa Table 1 nếu nó đang được tham chiếu bởi thằng khác
-- Nếu có mối quan hệ 1-N, Xóa N trước rồi xóa 1 sau

-- Thêm Kĩ thuật FK, Y chang cách viết của PK
 CREATE TABLE MajorV3
(
		MajorID char(2) PRIMARY KEY, --mặc định Dbe tự tạo tên ràng buộc
		MajorName nvarchar(40) NOT NULL
)
-- Chèn Data - Mua quần áo bỏ vào tủ
SELECT * FROM MajorV3
INSERT INTO MajorV3 VALUES('SE', N'Kĩ thuật phần mềm')
INSERT INTO MajorV3 VALUES('IA', N'Kĩ thuật phần mềm')
INSERT INTO MajorV3 VALUES('AH', N'Ahihi đồ ngốc')
/*
CREATE TABLE StudentV3
(
	StudentID char(8) PRIMARY KEY ,  
	LastName nvarchar(40) NOT NULL,  
	FirstName nvarchar(10) NOT NULL, 
	DOB datetime NULL,
	Address nvarchar(50) NULL, 
	MajorID char(2),

	CONSTRAINT FK_StudentV3_MajorV3 
							FOREIGN KEY(MajorID) REFERENCES MajorV3(MajorID)
 
)
*/

-- Ta có quyền gỡ 1 ràng buộc đã được thiết lập!!!

 CREATE TABLE StudentV3
(
	StudentID char(8) PRIMARY KEY ,  
	LastName nvarchar(40) NOT NULL,  
	FirstName nvarchar(10) NOT NULL, 
	DOB datetime NULL,
	Address nvarchar(50) NULL, 
	MajorID char(2) DEFAULT 'SE',

	CONSTRAINT FK_StudentV3_MajorV3 
							FOREIGN KEY(MajorID) REFERENCES MajorV3(MajorID)
							ON DELETE SET DEFAULT
							ON UPDATE CASCADE
)

-- ALTER TABLE StudentV3 ADD CONSTRAINT... ở trên DONE

SELECT * FROM StudentV3
ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3


-- Bổ sung lại 1 ràng buộc khác

ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 
									FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID)
 SELECT * FROM MajorV3 -- rỗng
 SELECT * FROM StudentV3-- rỗng

 -- Insert là chết, do tham chiếu ko tồn tại
INSERT INTO StudentV3 VALUES ('SE1', N'Nguyễn', N'An', NULL, NULL, 'SE')

 
INSERT INTO StudentV3 VALUES ('AHi', N'Vui', N'Vẻ', NULL, NULL, 'AH')

-- Thao tác mạnh tay trên data/ Món đồ trong quần áo DML(UPDATE< DELETE)

DELETE FROM StudentV3 -- Cực kì nguy hiểm khi thiếu WHERE, Xóa hết Data!!!

DELETE FROM StudentV3 WHERE StudentID = 'AH'

DELETE FROM MajorV3 WHERE MajorID = 'AH'

 SELECT * FROM MajorV3 -- rỗng
 SELECT * FROM StudentV3-- rỗng

 -- gài thêm hành xử khi xóa, sửa data ở ràng buộc khóa ngoại
 -- Dính khóa chính
 -- Hiệu ứng Domino, sụp đổ dây chuyền
 -- 1 xóa, N đi sạch >> CASCADE DELETE, 
 -- 1 sửa, N bị sửa theo >>> CASCADE UPDATE

 -- Ngay lúc Design table ta đã phải tính vụ này rồi 
 -- Vẫn có thể sửa sau này khi có Data, có thể Trouble

 -- Cụm lệnh: Create / Alter / Drop 
				
				
ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3
-- Xóa ràng buộc bị thiếu 
-- Việc gài thêm ràng buộc nhỏ liên quan xóa sửa Data

ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 
					  FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID)
					  ON DELETE CASCADE
					  ON UPDATE CASCADE

-- UPDATE DML, mạnh mẽ, sửa data đang có
UPDATE MajorV3 SET MajorID = 'AK'-- Cẩn thận nếu ko có where car table sẽ bị ảnh hưởng
								 -- Trừ UPDATE Cột KEY

UPDATE MajorV3 SET MajorID = 'AK' WHERE MajorID = 'AH'

-- Sụp đổ, xóa chuyên ngành AHIHI, xem sao ??? còn sv nào ko

DELETE FROM MajorV3 WHERE MajorID = 'AH'

DELETE FROM MajorV3 WHERE MajorID = 'AK' -- sv AH1 lên đường

-- Còn 2 cái gài nữa liên quan đến tính đồng bộ nhất quán  Data/ Consistence
-- Set Null Và Default
-- khi 1 xóa, N về NULL 


-- *** chốt hạ
-- Xóa bên 1 tức là mất bên 1, ko lẽ sụp đổ cả đám bên N, ko hay, Nên chọn đưa bên N về NULL
-- UPDATE bên 1, bên 1 vẫn còn giữ dòng, bên N đồng bộ theo, ăn theo, Cascade

ALTER TABLE StudentV3 DROP CONSTRAINT FK_StudentV3_MajorV3
-- Xóa ràng buộc bị thiếu 
-- Việc gài thêm ràng buộc nhỏ liên quan xóa sửa Data

ALTER TABLE StudentV3 ADD CONSTRAINT FK_StudentV3_MajorV3 
					  FOREIGN KEY (MajorID) REFERENCES MajorV3(MajorID)
					  ON DELETE SET NULL -- Xóa cho mồ côi, bơ vơ, NULL
					  ON UPDATE CASCADE -- Sửa bị ảnh hưởng dây chuyền 
 
 UPDATE MajorV3 SET MajorID = 'AK' WHERE MajorID = 'AH'

 DELETE FROM MajorV3 WHERE MajorID = 'AK'


 -- Cho sinh viên bơ vơ chuyên ngành về học SE
 UPDATE StudentV3 SET MajorID = 'SE' -- Toàn trường học SE
 UPDATE StudentV3 SET MajorID = 'SE' WHERE MajorID IS NULL

 SELECT * FROM MajorV3 -- rỗng
 SELECT * FROM StudentV3-- rỗng

  CREATE TABLE StudentV3
(
	StudentID char(8) PRIMARY KEY ,  
	LastName nvarchar(40) NOT NULL,  
	FirstName nvarchar(10) NOT NULL, 
	DOB datetime NULL,
	Address nvarchar(50) NULL, 
	MajorID char(2) DEFAULT 'SE',

	CONSTRAINT FK_StudentV3_MajorV3 
							FOREIGN KEY(MajorID) REFERENCES MajorV3(MajorID)
							ON DELETE SET DEFAULT
							ON UPDATE CASCADE
)


-- Cho sinh viên ko chọn chuyên ngành nó sẽ default học SE
INSERT INTO StudentV3 (StudentID, LastName, FirstName) VALUES('SE2', N'Phạm', N'Dương')

DELETE FROM MajorV3 WHERE MajorID = 'AH'

  