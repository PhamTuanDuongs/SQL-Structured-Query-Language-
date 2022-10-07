CREATE DATABASE DBDESIGN_PHONEBOOK

USE DBDESIGN_PHONEBOOK

CREATE TABLE PhoneBook
(
 NickName nvarchar(30),
 Phone varchar(50),
 -- 3 số phone gộp vào 1 cột
)
SELECT * FROM PhoneBook
INSERT INTO PhoneBook VALUES (N'annguyen', '090x')
-- An có 2 số phone, làm sao để lưu?
INSERT INTO PhoneBook VALUES (N'annguyen','090x, 091x')

-- Bình có 3 số phone, làm sao lưu? mày ko thấy tao để độ rộng
-- phone 50 à
INSERT INTO PhoneBook VALUES(N'binhle', '090x; 091x;  092x')

-- phân tích: 
-- ƯU Điểm: SELECT PHONE ra được tất cả các số di động
 
-- Cho tôi biết số để bàn nhà anh binhle
-- Đáp án: quy ước số đầu tiên là để bàn, số 2 là di động, 3 work
-- khó khăn vì quy ước ngầm, số nào là loại nào!!! khó nhớ cho
-- người nhập liệu
-- In cho tôi số di động của tất cả mọi người
INSERT INTO PhoneBook VALUES(N'binhle', '090x | 091x |  092x')
INSERT INTO PhoneBook VALUES(N'cuongvo', '090x, 091x,  092x')
INSERT INTO PhoneBook VALUES(N'dungpham', '090x - 091x - 092x')

-- Tiêu chí cắt chuỗi - DELIMITER dấu phân cách không nhất quán
--- Quy ước ngầm về nhập dấu phân cách

-- đếm xem mỗi người có bao nhiêu số phone!!! count() quá đen
-- dấu phân cách khó khăn cho cắt để count!!!!


-- khó khăn xảy ra khi ta gom nhiều value cùng kiểu ngữ nghĩa

--- Trong 1 column (Cột phone lưu nhiều số phone cách nhau dấu cách)

--Gây khó khăn cho nhập dữ liệu (ko nhất quán dấu cách), khi select
-- Count() thống kê theo tiêu chí (In số phone ở nhà)
-- update thêm phone mới, xóa số cũ, 

-- Một cell mà chứa nhiều Value cùng kiểu, được gọi là cột ĐA TRỊ
-- Multi-valued Column -> tiềm ẩn nhiều khó khăn cho việc xử lí data

-- Nếu 1 TABLE có cột Đa Trị người ta nói rằng nó éo đạt chuẩn 1
-- LEVEL thiết kế chán quá - 1ST Normalization

-- Chuẩn 1, chất lượng thiết kế tính từ 1, 2, 3,....

-- Thiết kế kém thì phải nâng cấp, ko chơi ĐA TRỊ nữa !!!
-- Ko chơi gom values trong 1 cell
-- 2 chiến lược FIX
-- Chiều ngang, chiều dọc 

