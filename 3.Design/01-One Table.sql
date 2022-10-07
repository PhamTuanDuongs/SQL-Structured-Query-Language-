     -- CREATE DATABASE DBDESIGN_ONETABLE
-- CREATE dùng để tạo cấu trúc lưu trữ/ dàn khung/ thùng chứa dùng lưu trữ data/Info
-- Tương đương với việc xây phòng chứa đồ - Database 
-- Mua tủ để trong phòng - Table 

-- 1 Database chứa nhiều table tương đương 1 tủ có nhiều ngăn hay 1 ngôi nhà có nhiều phòng 


-- Tạo ra cấu trúc lưu trữ - chưa nói data bỏ vào -- DDL (Phân nhánh của SQL)


	  USE DBDESIGN_ONETABLE
-- Tạo table để lưu trữ hồ sơ sinh viên: mã số (phân biệt các sinh viên với nhau), tên, dob, địa chỉ ...
-- SV ~ Object ~ Entity 
-- 1 Table sẽ dùng để lưu trữ nhiều Entity 

-- Gài cách đưa data vào table để ko xảy ra những hiện tượng bất thường,
-- 1 dòng trống trơn, key trùng
-- Gài - Constraints 
 CREATE TABLE StudentV1
(
	StudentID char(8), -- bao hàm luôn cái NOT NULL -- bắt buộc phải đưa data, cấm trùng
	LastName nvarchar(40),  -- tại sao ko gộp full cho rồi ??
	FirstName nvarchar(10), -- n lưu ý Unicode tiếng việt
	DOB datetime,
	Address nvarchar(50)
)
-- Thao tác trên Data/ Món đồ trong tủ/ trong table - DML/ DQL(dành cho SELECT)
SELECT * FROM StudentV1

-- Đưa data vào table/ Mua đồ quần áo bỏ vào tủ 

-- Đưa hết vào các cột, Sv full ko che thông tin 
INSERT INTO StudentV1 VALUES('SE123456', N'Nguyễn', 'An', '2002-1-1', N'TP. Hà Nội')

-- Một số chưa thèm nhập Info, được quyền bỏ trống nếu cột cho phép chống Value 
-- Default khi đóng cái tủ/ Mua tủ/ thiết kế tủ, Mặc định Null
INSERT INTO StudentV1 VALUES('SE123457', N'Lê', N'Bình', '2002-1-1', NULL) 
-- Tên thành phố là Null, WHERE = 'Null ' Okie vì nó là Data 
-- Null ở câu trên WHERE Address IS NULL 
INSERT INTO StudentV1 VALUES('SE123458', N'Võ', N'Cường', '2002-1-1', N'NULL') 

-- Tôi chỉ muốn lưu vài Info thôi ko đủ số cột, miễn những cột còn lại được phép null thì mới đc làm 
INSERT INTO StudentV1 (StudentID, LastName, FirstName)
			VALUES('SE123459', N'Trần', N'Dũng') 

 INSERT INTO StudentV1 (LastName,StudentID , FirstName)
			VALUES( N'Phạm', 'SE123459', N'Em') 


 INSERT INTO StudentV1 (LastName,StudentID , FirstName)
			VALUES( NULL, NULL, NULL) 

 INSERT INTO StudentV1 (LastName,StudentID , FirstName)
			VALUES( NULL, NULL, NULL) -- Siêu nguy hiểm vì toàn sinh viên info bỏ trống 
									  -- Gài cách đưa data vào các cột sao cho hợp lí
									  -- Constraint trên Data/Cell/Column

SELECT * FROM StudentV1
-- Cú nguy hiểm này còn lớn hơn
-- trùng mã số là không chấp nhận được, ko xác định được 1 sinh viên -- 
-- Gài ràng buộc dữ liệu quan trọng này
-- Cột mà value cấm trùng trên mọi cell cùng cột
-- Dùng làm chìa khóa/ key để tìm ra/ mở ra/ xác định
-- Duy nhất 1 infor, dòng 1, 1 sv, 1 Entity, 1 objects

SELECT * FROM StudentV1 WHERE StudentID = 'SE123459'
 
   CREATE TABLE StudentV2
(
	StudentID char(8) PRIMARY KEY, -- bao hàm luôn cái NOT NULL -- bắt buộc phải đưa data, cấm trùng
	LastName nvarchar(40) NOT NULL,  -- tại sao ko gộp full cho rồi ??
	FirstName nvarchar(10) NOT NULL, -- n lưu ý Unicode tiếng việt
	DOB datetime,
	Address nvarchar(50)
)
SELECT * FROM StudentV2
INSERT INTO StudentV2 VALUES('SE123456', N'Nguyễn', 'An', '2002-1-1', N'TP. Hà Nội')

-- Xem constraint có hoạt động không 
INSERT INTO  StudentV2(LastName,StudentID , FirstName)
			VALUES( NULL, NULL, NULL) 


INSERT INTO  StudentV2(LastName,StudentID , FirstName)
			VALUES( NULL, 'Ahihih', NULL)
		
-- Không được trùng mã sinh viên
INSERT INTO StudentV2 VALUES('SE123456', N'Lê', N'Bình', '2002-1-1', NULL) 


INSERT INTO StudentV2 VALUES('GD123456', N'Lê', N'Bình', '2002-1-1', NULL) 



INSERT INTO StudentV2 VALUES('SE123457', N'Lê', N'Bình', '2002-1-1', NULL) 


INSERT INTO StudentV2 VALUES('SE123458', N'Lê', N'Bình', null, null) 


INSERT INTO  StudentV2(LastName,StudentID , FirstName)
			VALUES( 'Pham', 'SE123459', 'Duong') 


INSERT INTO  StudentV2 
			VALUES( NULL, NULL, NULL, NULL, NULL) -- Gãy ở 3 chỗ Null



CREATE TABLE StudentV3
(
	StudentID char(8) PRIMARY KEY, -- bao hàm luôn cái NOT NULL -- bắt buộc phải đưa data, cấm trùng
	LastName nvarchar(40) NOT NULL,  -- tại sao ko gộp full cho rồi ??
	FirstName nvarchar(10) NOT NULL, -- n lưu ý Unicode tiếng việt
	DOB datetime NULL,
	Address nvarchar(50) NULL -- thừa từ NULL. do default là vậy
)
SELECT * FROM StudentV3


CREATE TABLE StudentV4
(
	StudentID char(8) NOT NULL, -- bao hàm luôn cái NOT NULL -- bắt buộc phải đưa data, cấm trùng
	LastName nvarchar(40) NOT NULL,  -- tại sao ko gộp full cho rồi ??
	FirstName nvarchar(10) NOT NULL, -- n lưu ý Unicode tiếng việt
	DOB datetime NULL,
	Address nvarchar(50) NULL, -- thừa từ NULL. do default là vậy
	PRIMARY KEY(StudentID)
)
SELECT * FROM StudentV4

INSERT INTO StudentV4 VALUES('SE123456', N'Nguyễn', 'An', '2002-1-1', N'TP. Hà Nội')

-- Generate từ ERD trong tool thiết kế
CREATE TABLE StudentV5 (
  Student  int IDENTITY NOT NULL, 
  LastName varchar(50) NOT NULL, 
  FirstNam varchar(10) NOT NULL, 
  PRIMARY KEY (Student)
  )

 SELECT * FROM StudentV5

 
CREATE TABLE StudentV6
(
	StudentID char(8) NOT NULL,  
	LastName nvarchar(40) NOT NULL,  
	FirstName nvarchar(10) NOT NULL, 
	DOB datetime NULL,
	Address nvarchar(50) NULL, -- thừa từ NULL. do default là vậy
	--PRIMARY KEY(StudentID)  -- tự database engine đặt cho 
	Constraint PK_Students PRIMARY KEY (StudentID)
)


-- Dân PRO đôi khi còn làm cách sau. Người ta tách hẳn ra việc
-- tạo ra hẳn cấu trúc table, tức là Create table chỉ chứa tên cấu trúc
-- Cột - Dòng
-- Tạo table xong rồi chỉnh sửa table, chỉnh sửa cái tủ ko phải data trong tủ

DROP TABLE StudentV7 
CREATE TABLE StudentV7
(
	StudentID char(8) NOT NULL ,  
	LastName nvarchar(40) NOT NULL,  
	FirstName nvarchar(10) NOT NULL, 
	DOB datetime NULL,
	Address nvarchar(50) NULL, -- thừa từ NULL. do default là vậy
	--PRIMARY KEY(StudentID)  -- tự database engine đặt cho 
	--Constraint PK_StudentsV7 PRIMARY KEY (StudentID)
)

ALTER TABLE StudentV7 ADD CONSTRAINT PK_StudentV7 PRIMARY KEY(StudentID)

-- Xóa 1 ràng buộc được không được cho ADD thì cho DROP

ALTER TABLE StudentV7 DROP CONSTRAINT PK_StudentV7

ALTER TABLE StudentV2 DROP CONSTRAINT PK__StudentV__32C52A795C46040D