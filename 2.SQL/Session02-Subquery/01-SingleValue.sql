USE Northwind

-- Lí thuyết 
-- Cú pháp chuẩn của lệnh SELECT
-- WHERE Cột = Value nào đó
-- WHERE cột LIKE PATTERN nào đó e.g. '_____'
-- WHERE CỘT BETWEEN RANGE
-- WHERE CỘT IN(Tập hợp giá trị liệt kê)


-- Một câu SELECT tùy cách viết có thể có thể trả về đúng 1 Tập giá trị/cell

-- Tập kết quả này đồng nhất(Các giá trị khác nhau của 1 biến)

-- WHERE Cột = VALUE nào đó - đã học. e.g YEAR(DOB) = 2003
--             THAY VALUE này = 1 câu SQL khác miễn trả về 1 Cell

-- Kĩ thuật viết câu SQL theo kiểu hỏi gián tiếp, lồng nhau, trong  

-- Câu SQL chứa SQL kh

--1. In ra danh sách nhân viên
SELECT * FROM Employees
SELECT FirstName FROM Employees WHERE EmployeeID = 1 -- CELL

SELECT FirstName FROM Employees  -- 1 tập giá trị/cột/phép chiếu
--2. Liệt kê các nhân viên ở London
SELECT * FROM Employees WHERE City = 'London'

--3. Liệt kê các nhân viên cùng quê với King Robert

SELECT City FROM Employees WHERE FirstName = 'Robert' 

-- Đáp án cho câu 3
--SELECT * FROM Employees WHERE City = City quê của  Robert

SELECT * FROM Employees WHERE City =  (
									SELECT City FROM Employees WHERE FirstName = 'Robert' 
                                       )
-- Nhưng trong kq còn Robert bị dư, tìm cùng quê Robert

SELECT * FROM Employees WHERE City =  (
									SELECT City FROM Employees WHERE FirstName = 'Robert' 
                                       ) AND FirstName <> 'Robert'

-- 4. Liệt kê các đơn hàng
SELECT * FROM Orders ORDER BY Freight DESC

--4.1 Liệt kê các đơn hàng trọng lượng lớn hơn 252 kg
SELECT * FROM Orders WHERE Freight > 252 

SELECT Freight  FROM Orders WHERE OrderID = 10555

--4.2 Liệt kê tất cả các đơn hàng có trọng lượng lớn hơn trọng lượng đơn hàng 10555

SELECT * FROM Orders WHERE Freight >= (
										SELECT Freight  FROM Orders WHERE OrderID = 10555
									  ) AND OrderID != 10555
-- BTVN 