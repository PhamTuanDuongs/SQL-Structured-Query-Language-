CREATE DATABASE DBDESIGN_PHONEBOOK

USE DBDESIGN_PHONEBOOK

CREATE TABLE PhoneBook1
(
 NickName nvarchar(30),
 -- Phone varchar(50), -- cấm đa trị trong 1 cell
 
 HomePhone char(11), -- ko biết cột nào là loại nào 1 2 3 vô hồn 
 WorkPhone char(11),
 CellPhone char(11)
 )
 -- Mở rộng TABLE theo chiều ngang - thêm cột !!!!
 SELECT * FROM PhoneBook1
 INSERT INTO PhoneBook1 VALUES (N'annguyen', NULL, NULL,'090x')
 INSERT INTO PhoneBook1 VALUES (N'annguyen','090x', ' 091x', NULL)
 INSERT INTO PhoneBook1 VALUES(N'binhle', '090x', ' 091x', ' 092x')
 
-- phân tích: 
-- ƯU Điểm: SELECT PHONE ra được tất cả các số di động
-- 1. SQL Cho tôi biết các số di động của mọi người 
SELECT  CellPhone, HomePhone FROM PhoneBook1 

SELECT  p.CellPhone, p.HomePhone FROM PhoneBook1 p
-- Cho tôi biết số để bàn, ở nhà anh binhle
SELECT NickName,HomePhone, CellPhone FROM PhoneBook1 WHERE NickName = 'binhle'
-- >>>> Nhược điểm
--- Thống kê số lượng số điện thoại đang mỗi người xài, mấy sim ??? ko trả lời được
--- Data bị NULL, phí ko gian lưu trữ 
-- Nếu mà NULL nhiều thì bị phí nhiều 
-- Người có 4, 5 phone thì sao ????
-- Solution: thêm cột, càng thêm cột trừ hao về người có nhiều phone
--           những người còn lại bị Null càng nhiều
-- Phí vì chỉ 1 vài người đặc biệt nhiều phone mà tất cả anh em khác đều được
-- xem chung là nhiều số phone, phí ko gian lưu trữ trên đĩa cứng
-- Giả sử vẫn quyết tâm theo cột, nở cột ra, thì giá phải trả sửa code lập trình
-- sau này, vì tên cột mới được thêm vô khi nâng cấp app, sửa thêm 
--> TRIẾT LÍ THIẾT KẾ: Cố gắng giữ nguyên cái tủ, chỉ thêm đồ, 
--                     Ko thêm cột của table, chỉ cần thêm dòng nếu có biến động 
--					   số lượng 

--> Phiên bản 3 - Phiên bản ngon bắt đầu, ai nhiều phone thì nhiều dòng, nhiều
--> CELL theo chiều dọc thêm dòng
--> COUNT ngon lành luôn, trả lời ngay được câu bao nhiêu sim bao nhiêu sóng

 
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


-- Chiều ngang(thêm cột), chiều dọc(thêm dòng !!!!)*****	