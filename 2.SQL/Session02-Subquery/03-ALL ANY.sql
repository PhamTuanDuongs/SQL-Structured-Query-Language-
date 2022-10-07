USE Northwind


-- Lí thuyết
-- Cú pháp chuẩn của câu lênh SELECT
-- SELECT * FROM <Table> WHERE...
-- WHERE Cột Toán - Tử  - So - Sánh với - Value - cần - Lọc
--                Cột > >= < <= = !=
--                 Dùng câu SUB - QUERY Tùy ngữ cảnh 
-- Cột               = (SUB Chỉ có 1 Value)
-- Cột               IN (SUB Chỉ có 1 cột nhưng nhiều VALUE)

--  Cột              > >= < <= ALL (1 Câu SUB 1 Cột Nhiều Value)
--					 > >= < <= ANY (1 Câu SUB 1 Cột Nhiều Value)
-- Thực hành
-- Tạo 1 table có 1 cột tên là Numbr, chỉ chứa 1 đống dòng các số nguyên
CREATE TABLE Num
(
   Numbr int

)

SELECT * FROM Num
INSERT INTO NUM VALUES (1)
INSERT INTO NUM VALUES (1)
INSERT INTO NUM VALUES (2)
INSERT INTO NUM VALUES (9)
INSERT INTO NUM VALUES (5)
INSERT INTO NUM VALUES (100)
INSERT INTO NUM VALUES (101)

-- 1. In ra những số lớn hơn 5
SELECT * FROM Num WHERE Numbr > 5
-- 2. In ra số lớn nhất trong các số đã nhập
-- Số lớn nhất trong 1 đám được định nghĩa là lớn nhất trong cả đám và bằng chính nó
SELECT * FROM Num WHERE Numbr  >= ALL(SELECT * FROM Num)


-- 4. Nhân viên nào lớn tuổi nhất
SELECT * FROM Employees
SELECT * FROM Employees WHERE YEAR(GETDATE()) - YEAR(BirthDate)  >= ALL(SELECT YEAR(GETDATE()) - YEAR(BirthDate) FROM Employees)

-- 5. Đơn hàng nào có trọng lượng nặng nhất 

SELECT * FROM Orders WHERE Freight >= ALL(SELECT Freight FROM Orders)