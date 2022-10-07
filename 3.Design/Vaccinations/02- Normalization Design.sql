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
  CREATE TABLE TypeVaccination_5
 (
 
 VaccineName varchar(30) PRIMARY KEY
 -- hãng sx, địa chỉ hãng, thông tin về lâm sàng
 )

INSERT INTO TypeVaccination_5 VALUES ('AstraZeneca')
INSERT INTO TypeVaccination_5 VALUES ('Pfrizer')
INSERT INTO TypeVaccination_5 VALUES ('Verocell')
INSERT INTO TypeVaccination_5 VALUES ('Modena')

SELECT * FROM TypeVaccination_5

 -- Primary key mà là VARCHAR() làm giảm hiệu năng về thực thi query
 -- Chạy chậm người ta sẽ chọn PK là con số là tốt nhất, tốt nhì  CHAR
 -- Sẽ giảng riêng 1 buổi về PRIMARY KEY(PK, FK, CK, SPK, NK, SRK-AK)

 
  CREATE TABLE Person_5
(
 ID char(11) PRIMARY KEY,
 LastName nvarchar(30),
 FirstName nvarchar(20),  --sort heng, FULLNAME là sort họ đó
 Phone varchar(11) NOT NULL UNIQUE, 
 -- Constraint, cấm trùng nhưng ko là PK
 
)
DROP TABLE Vaccination_5
 CREATE TABLE Vaccination_5
(
 SEQ int IDENTITY PRIMARY KEY,  -- Cứ tăng mãi mãi đi, 2 tỷ 1 mấy lần chích 
 Dose int,  -- liều chích số 1, 2 có thể lặp lại cho mỗi người
 InjDate datetime,
 Vaccination varchar(30) REFERENCES TypeVaccination_5(VaccineName), -- tên vaccine KO cho gõ tự do, phải tham chiếu 
 Lot nvarchar(20),
 [Location] nvarchar(50),  -- nơi chich bản chất là Composite, tách thành cột city, quận/ huyện
						   -- lại là lookup nếu muốn, để ko gõ lúng túng, thống kê tiện từng đơn vị 
 PersonID char(11) REFERENCES Person_5(ID),
 --CONSTRAINT FK_Vaccination_5_TypeVaccination FOREIGN KEY(Vaccination) REFERENCES TypeVaccination(VaccineName)
 )


 -- CHỐT HẠ : Tách đa trị, hay composite dựa trên nhu cầu thống kê nếu có của dữ liệu ta đang lưu trữ
 --      Chiến lược gom bảng --> Tìm đa trị, tìm composite, tìm look up tách theo nhu cầu !!!
 SELECT * FROM TypeVaccination_5
 SELECT * FROM Person_5
 SELECT * FROM Vaccination_5

 -- Thống kê được những gì
 -- 1. Có bao nhiêu mũi vaccine AZ được chích (chích bao nhiêu nhát, ko care người)
 -- Output: loại vaccine, tổng mũi đã chích 

 -- 2.Ngày x có bao nhiêu mũi được chích
 -- Output: Ngày, tổng số mũi đã chích

 -- 3 thống kê số mũi chích của mỗi cá nhân 
 -- Output: CCC, Tên(Full), di động, số mũi đã chích(0,1,2,3) 

 -- 4 In ra thông tin của mỗi cá nhân 
  -- Output: CCC, Tên(Full), di động, số mũi đã chích(0,1,2,3), Màu sắc

  --5. Có bao nhiêu công dân đã chích ít nhất 1 vaccine

  -- 6. Những công dân nào chưa chích mũi nào
  -- Output: CCCD, Tên 
  -- 7. Công dân có CCCD đã chích những mũi nào 
  -- Output: CCCD, Tên, thông tin chích (In gộp + chuỗi, tái nhập composite)
  INSERT INTO Person_5 VALUES('0000000001', N'Phạm', N'Dương', '0971597955')
  INSERT INTO Person_5 VALUES('0000000002', N'Phạm', N'Hùng', '0386617760')

  INSERT INTO Vaccination_5 VALUES(1, GETDATE(), 'AstraZeneca',NULL, NULL, '0000000002'); -- ok
 
   INSERT INTO Vaccination_5 VALUES(2, GETDATE(), 'AstraZeneca',NULL, NULL, '0000000002');-- ok

   INSERT INTO Vaccination_5 VALUES(3, GETDATE(), 'AZ',NULL, NULL, '0000000002'); -- thất bại
   -- ko có loại vaccine gõ tay AZ
   -- SEQ tăng thành số 3 bị thất bại
INSERT INTO Vaccination_5 VALUES(1, GETDATE(), 'Verocell',NULL, NULL, '0000000002');


SELECT * FROM Vaccination_5  -- Chỉ nhìn thấy Az, vero, ko thấy được MO...
SELECT * FROM TypeVaccination_5 t INNER JOIN Vaccination_5 v ON v.Vaccination = t.VaccineName

SELECT t.VaccineName, IIF(COUNT(v.Dose) = 0, 'NOOP', 
								  IIF(COUNT(v.Dose) = 1, 'YELLOW', 'GREEN'))								   
									AS STATUS COUNT(Dose)  FROM TypeVaccination_5 t LEFT JOIN Vaccination_5 v ON v.Vaccination = t.VaccineName GROUP BY t.VaccineName

  -- In ra xanh vàng cho mỗi người 
   SELECT * FROM Person_4 p INNER JOIN Vaccination_4 v ON p.ID = v.PersonID
   SELECT p.ID, p.FirstName  , COUNT(v.Dose) FROM Person_4 p LEFT JOIN Vaccination_4 v ON p.ID = v.PersonID GROUP BY p.ID, p.FirstName

   -- Ăn tiền xanh đỏ
      SELECT p.ID, p.FirstName ,  IIF(COUNT(v.Dose) = 0, 'NOOP', 
								  IIF(COUNT(v.Dose) = 1, 'YELLOW', 'GREEN'))								   
									AS STATUS
									FROM PERSON_4 P LEFT JOIN VACCINATION_4 V 
									ON P.ID = V.PERSONID 
											GROUP BY P.ID, P.FIRSTNAME

-- phân tích 
-- Cột Vaccine cho phép gõ các giá trị tên vaccine 1 cách tự do --> Inconsistency
-- AZ, Astra, AstraZeneca, Astra Zeneca
-- Có mùi của dropdown, mùi của combo box >>>> Lookup table
-- ko cho gõ mà cho chọn từ danh sách có sẵn ...
-- tham chiếu từ danh sách có sẵn
-- Vaccine phải tách thành table CHA, TABLE 1, đám con đám N
-- Phải REFERENCE về bảng cha
-- Look là mối quan hệ 1 nhiều 