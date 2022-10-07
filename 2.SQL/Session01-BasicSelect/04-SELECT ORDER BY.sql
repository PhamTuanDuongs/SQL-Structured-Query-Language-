USE Northwind
-- Lí thuyết 
-- Cú pháp mở rộng lệnh SELECT
-- Ta muốn sắp xếp dữ liệu/ sort theo tiêu chí nào đó 
-- ascending/asc (tăng dần)
-- descending/desc(giảm dần)
--
-- Mặc định ko nói gì cả thì sort tăng dần
-- A < B < C
-- 1 < 2 < 3
-- Ta có thể sort trên nhiều cột, logic này từ từ tính
-- SELECT ... FROM <Tên table > ORDER BY tên - cột muốn sort <Kiểu sort>
--------------------------------------------------------------------------- 

-- 1. In ra danh sách nhân viên 
SELECT * FROM Employees

-- 2. In ra danh sách nhân viên tăng dần theo năm sinh
SELECT * FROM Employees ORDER BY BirthDate ASC

-- 3. In ra danh sách giảm dần theo năm sinh
SELECT * FROM Employees ORDER BY BirthDate DESC

-- 4. Tính tiền chi tiết mua hàng 
SELECT * FROM [Order Details]


-- 5. Tính tiền chi tiết mua hàng, sắp xếp giảm dần theo số tiền
SELECT *, UnitPrice * Quantity * (1 - Discount) As [Subtotal] FROM [Order Details]
                                 ORDER BY Subtotal DESC

-- 6. Tính tiền chi tiết mua hàng, sắp xếp giảm dần theo số tiền
SELECT *, UnitPrice * Quantity * (1 - Discount) As [Subtotal] FROM [Order Details]
                                 ORDER BY Subtotal ASC

-- 7. In ra danh sách nhân viên giảm dần theo tuổi

SELECT * FROM Employees

SELECT *,   YEAR(GETDATE())- YEAR(BirthDate) As [age] FROM Employees ORDER BY age DESC

--In ra danh sách nhân viên tăng dần theo tuổi
SELECT EmployeeID, LastName, FirstName,  BirthDate, YEAR(GETDATE())- YEAR(BirthDate) As [age] FROM Employees ORDER BY age ASC

