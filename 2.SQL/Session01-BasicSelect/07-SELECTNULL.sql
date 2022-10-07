USE Northwind

-- Lí thuyết
-- Cú pháp mở rộng lệnh SELECT 
-- Trong thực tế dữ liệu mình chưa xác định được nó là gì 
-- VD: Kí tên danh sách thi, danh sách kí tên có cột điểm, điểm ngay lúc kí tên 
-- chưa xác định được. Từ từ sẽ có, sẽ update sau 
-- Hiện tượng dữ liệu chưa xác định, chưa biết, từ từ đưa vào sau, hiện nhìn vào
-- Chưa thấy có data, thì ta gọi là giá trị chưa xác định này là NULL
-- NULL đại diện cho thứ chưa xác định, chưa xác định tức là không có giá trị
-- không có giá trị thì không thể so sánh > >= < <= !=
-- Cấm tuyệt đối xài các toán tử so sánh kèm với giá trị NULL
-- Ta dùng toán tử, IS NULL, IS NOT NULL, NOT(IS NULL) để Filter ra cell 
-- Mang giá trị NULL

-- 1 In ra danh sách nhân viên
SELECT * FROM Employees

-- 2 Ai chưa xác định khu vực ở, region null
SELECT * FROM Employees WHERE Region = 'NULL' -- 0, vì không ai ở khu vực tên là NULL

SELECT * FROM Employees WHERE Region = NULL  -- 0, Vì NULL không thể dùng >< =

SELECT * FROM Employees WHERE Region IS  NULL

-- 3 Ai xác định được khu vực ở, region is not null

SELECT * FROM Employees WHERE Region IS NOT NULL

SELECT * FROM Employees WHERE NOT (Region IS NULL)

-- 4. Những nhân viên có chức danh đại diện kinh doanh và xác định được nơi cư trú

SELECT * FROM Employees WHERE Title = 'Sales Representative' AND  Region IS NOT NULL
 

SELECT * FROM Employees WHERE Title = 'Sales Representative' AND NOT (Region IS NULL)

-- 5. Liệt kê các khách hàng đến từ USA, FRANCE, UK, có cả thông tin số fax và Region


SELECT * FROM Customers WHERE Country IN('UK', 'FRANCE', 'USA') 
                              AND NOT(Fax IS NULL OR Region IS NULL) ORDER BY Fax ASC


