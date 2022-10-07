CREATE DATABASE DBDESIGN_PHONEBOOK

USE DBDESIGN_PHONEBOOK

CREATE TABLE PhoneBook3
(
 NickName nvarchar(30),
 Phone char(11), --chỉ 1 số phone thôi
 )
 SELECT * FROM PhoneBook3
 -- Mở rộng TABLE theo chiều dọc, ai có nhiều sim thì thêm dòng !!!!
  INSERT INTO PhoneBook3 VALUES (N'annguyen', '090x')
    INSERT INTO PhoneBook3 VALUES (N'annguyen', '091x')
  INSERT INTO PhoneBook3 VALUES (N'duongpham', '090x')
  INSERT INTO PhoneBook3 VALUES (N'duongpham', '091x')
  -- Nhược điểm 
  --> ko biết số phone X nào đó thuộc loại nào ?!!!! 
  -- Đếm xem mỗi thành viên có bao nhiêu số đt
  -- 
  -- Vi phạm PK, redundancy, lặp lại nhiều lần làm gì khi ta mới chỉ lưu nickName
  -- còn fulltname, title, tên City, email

  SELECT NickName, COUNT(*) As [No phone] FROM PhoneBook3 GROUP BY NickName

  ----------------------------------------------------------

  -- Ta cần giải quyết phone này thuộc loại nào ????
  CREATE TABLE PhoneBook3_1
(
 NickName nvarchar(30),
 Phone char(11), --chỉ 1 số phone thôi, cần giải nghĩa thêm số này là loại số gì 
 PhoneType nvarchar(20)  --090x
 )
 SELECT * FROM PhoneBook3_1
 
INSERT INTO PhoneBook3_1 VALUES (N'annguyen', '098x', 'CELL')
INSERT INTO PhoneBook3_1 VALUES (N'annguyen', '091x', 'CELL')
INSERT INTO PhoneBook3_1 VALUES (N'annguyen', '091x', 'HOME')
INSERT INTO PhoneBook3_1 VALUES (N'duongpham', '090x', 'WORK')
INSERT INTO PhoneBook3_1 VALUES (N'duongpham', '091x', 'CELL')
INSERT INTO PhoneBook3_1 VALUES (N'duongpham', '092x', 'CELL')

-- phân tích 
-- Ưu điểm 
-- COUNT ngon, group by theo Nick theo loại phone 
-- WHERE theo loại phone ngon 

-- Nhược điểm nó vẫn bị duplicate và redundancy trên Infor cuar Nick/full
SELECT COUNT(*) FROM PhoneBook3_1 WHERE PhoneType = 'CELL' GROUP BY NickName