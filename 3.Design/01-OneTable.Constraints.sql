-- Phần này dính đến các ràng buộc các quy tắc - Constraints
-- Quy tắc gài trên Data
-- 1. Ràng buộc PRIMARY KEY
-- Tạm thời hiểu PK là 1 cột (tương lai có thể là nhiều cột) mà
-- giá trị trên mọi dòng/mọi cell của cột này ko trùng lại, mục đích
-- WHERE ra được 1 dòng duy nhất
-- Value của key có thể được tạo ra theo 2 cách 
-- Cách1: Tự nhập bằng tay, DBENGINE sẽ tự kiểm tra giùm mình có trùng hay ko
--     Nếu mà trùng DB ENGINE tự báo vi phạm PK CONSTRAINT
-- UI/UX

-- Cách 2: Ko cần nhập bằng tay cái value của PK, Máy/DB ENGINE tự GENERATE cho 
--  Mình 1 con số ko trùng lại!!!!! con số tự tăng, con số HEXA...
-- Thực hành
-- Thiết kế table lưu thông tin đăng kí event nào đó(Giống đk qua Google Form)
-- Thông tin cần lưu trữ: số thứ tự đăng kí, tên fullName, email
-- Ngày giờ đk, số di động.....
-- * Phân tích ngày giờ đk: ko bắt nhập, default

-- Số thứ tự: Nhập vào là bạy rồi !!! tự gán chứ!!!
-- email, phone: ko cho trùng, 1 email 1 lần đk
-- 

USE DBDESIGN_ONETABLE
/*
 CREATE TABLE Registration
 (
  SEQ int PRIMARY KEY, -- Phải tự nhập số thứ tự, vớ vẩn
  FirstName nvarchar(10),
  LastName nvarchar(30),
  Email varchar(50), -- Cấm trùng làm sao ??
  Phone varchar(11),
  RegDate datetime DEFAULT GetDATE() -- Constraint default
 
 )
 */

  CREATE TABLE Registration
 (
  SEQ int PRIMARY KEY IDENTITY, -- Phải tự nhập số thứ tự, vớ vẩn
								-- mặc định đi từ1, nhảy ++ cho người sau
								-- Ghi rõ IDENTITY(1,1) nhưng mà thừa
								-- IDENTITY(1,5), từ 1, 6, 11
  FirstName nvarchar(10),
  LastName nvarchar(30),
  Email varchar(50), -- Cấm trùng làm sao ??
  Phone varchar(11),
  RegDate datetime DEFAULT GetDATE() -- Constraint default
 
 )

 -- Đăng kí Event
 SELECT * FROM Registration
 INSERT INTO Registration(FirstName, LastName, Email, Phone) VALUES(N'An', N'Dương', 'an@...', '090X')

  INSERT INTO Registration VALUES(5,N'An', N'Dương', 'an@...', '090X', NULL)

  -- Xóa 1 dòng có AUTO GENERATED KEY, thì TABLE Sẽ bị lủng số, DB ENGINE ko lấp chỗ
  -- Ví dụ có 20 sinh viên khi xóa sinh viên thứ 10 sau đó mình INSERT thêm 1 sinh viên vào
  -- thì nó ko tự động lấp đầy khoảng trống thay vào đó nó sẽ tự động tăng lên sv thứ 21
  --