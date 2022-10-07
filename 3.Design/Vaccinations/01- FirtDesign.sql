-- thiết kế đầu tiên: Gom tất cả trong 1 TABLE
-- Đặc điểm chín là cột, value dđ chính là CELL
-- Thông tin chích ngừa bao gồm: Tên: An nguyễn, cccvd: 1234556789
USE DBDESIGN_VACCINATION
CREATE TABLE Vaccination_1
(
 ID char(11) PRIMARY KEY,
 LastName nvarchar(30),
 FirstName nvarchar(20), -- làm như này để sort tên còn để FULL name là nó sẽ sort họ 
 Phone varchar(11) NOT NULL UNIQUE, 
 -- Constraint, cấm trùng

 InjectionInfor nvarchar(255)
)
SELECT * FROM Vaccination_1
-- Cách thiết kế này lưu trữ các mũi chích của mình được không ? - được
INSERT INTO Vaccination_1 VALUES('00000000001', N'Nguyễn', N'AN', '090X', N'AZ Ngày 28.9.2021 Đại Học FPT | AZ Ngày 28.10.2021 Bệnh Viện Việt Đức')

-- Đây là cách thiết kế Multiplevalue(Đa trị)
-- Phân tích:
-- Ưu: Dễ lưu trữ, SELECT, có ngay, đa trị tốt trong vụ này
-- Nhược điểm thống kê ko được, ít nhất đi cắt chuỗi, căng do đa trị

-- Solution: Nếu cần quan tâm cả thống kê, tính toán số liệu (? Mũi, AZ có bao người)

-- tách cột, tách bảng

CREATE TABLE Vaccination_2
(
 ID char(11) PRIMARY KEY,
 LastName nvarchar(30),
 FirstName nvarchar(20), -- làm như này để sort tên còn để FULL name là nó sẽ sort họ 
 Phone varchar(11) NOT NULL UNIQUE, 
 -- Constraint, cấm trùng

 Dose1 nvarchar(160),
 Dose2 nvarchar(255)

)

-- Phân tích:
-- Ưu	: gọn gàng, select gọn gàng
-- Nhược: NULL!!!!, thêm mũi nhắc3,4 thì sao ?
--  Chỉ vì vài người mà ta phải chừa chỗ NULL do đó nó sẽ tốn tài nguyên RAM 
-- Thống kê!!! Cột COMPOSITE chưa cho mình được thống kê




-- Multi- value: Một CELL chứa nhiều INFO độc lập bình đẳng về ngữ nghĩa 
-- Example: Address: 1/1 LL, Q1, TP.HCM; 1/1 Man Thiện, TP.TĐ tạm trú

-- Gói COMPO, nhiều đồ trong 1 cell

-- COMPOSITE VALUE CELL: Một value duy nhất, nhưng mỗi value lại gom nhiều miếng nhỏ, 
											-- mỗi miếng nhỏ lại mang 1 vai trò riêng mà gom
											-- trung lại thành 1 thứ khác 
--                                          Address: 1/1 Man Thiện, P.5, TP HCM
--											FullName: Hoàng Ngọc Trinh -> Cả: tên gọi đầy đủ

-- vì số lần chích còn có thể gia tăng cho từng người, Mũi 2, Mũi khác, Mũi thường niên
-- Ai chích nhiều thì nhiều dòng

-- Composite gộp N thông tin vào trong 1 CELL
-- Dễ, nhanh là ưu điểm, nhập 1 chuỗi dài là xong
-- FullName sort làm sao 
-- COMPOSITE sẽ tách cột, vì mình đã cố trước đó gom N thứ khác nhau để làm ra 1 thứ khác 
--						Tách cột nó sẽ trả lại đúng ngữ nghĩa cho từng thằng 
--						

CREATE TABLE Person_3
(
 ID char(11) PRIMARY KEY,
 LastName nvarchar(30),
 FirstName nvarchar(20), -- làm như này để sort tên còn để FULL name là nó sẽ sort họ 
 Phone varchar(11) NOT NULL UNIQUE, 
 -- Constraint, cấm trùng
 
)

CREATE TABLE Vaccination_3
(
 Dose nvarchar(160),
 PersonID char(11) REFERENCES Person_3(ID)
 )

 -- Phân tích 
 -- Chắc chăn là được chích thêm nhát nào thì chưa chích, chấp 10 mũi luôn ko ảnh hưởng đến người chưa chích
 -- COMPOSITE phải tách tiếp thành cột cột cột , trả lại ý nghĩa đúng cho từng ý nghĩa


 
  CREATE TABLE Person_4
(
 ID char(11) PRIMARY KEY,
 LastName nvarchar(30),
 FirstName nvarchar(20),  --sort heng, FULLNAME là sort họ đó
 Phone varchar(11) NOT NULL UNIQUE, 
 -- Constraint, cấm trùng nhưng ko là PK
 
)

CREATE TABLE Vaccination_4
(
 Dose int,  -- liều chích số 1
 InjDate datetime,
 TypeVaccination nvarchar(50),
 Lot nvarchar(20),
 [Location] nvarchar(50),
 PersonID char(11) REFERENCES Person_4(ID)
 )

 SELECT * FROM Person_4
 SELECT * FROM Vaccination_4

  INSERT INTO Person_4 VALUES('0000000001', N'Phạm', N'Dương', '0971597955')
  INSERT INTO Person_4 VALUES('0000000002', N'Phạm', N'Hùng', '0386617760')

  INSERT INTO Vaccination_4 VALUES(3, GETDATE(), 'AZ',NULL, NULL, '0000000001');
  SELECT * FROM  Vaccination_4,Person_4

  -- In ra xanh vàng cho mỗi người 
   SELECT * FROM Person_4 p INNER JOIN Vaccination_4 v ON p.ID = v.PersonID
   SELECT p.ID, p.FirstName , COUNT(v.Dose) FROM Person_4 p LEFT JOIN Vaccination_4 v ON p.ID = v.PersonID GROUP BY p.ID, p.FirstName

   -- Ăn tiền xanh đỏ
      SELECT p.ID, p.FirstName ,  IIF(COUNT(v.Dose) = 0, 'NOOP', 
								  IIF(COUNT(v.Dose) = 1, 'YELLOW', 'GREEN'))								   
									AS STATUS
									FROM PERSON_4 P LEFT JOIN VACCINATION_4 V 
									ON P.ID = V.PERSONID 
											GROUP BY P.ID, P.FIRSTNAME