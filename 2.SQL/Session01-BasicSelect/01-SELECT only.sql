USE Northwind -- Chọn để chơi với thùng chứa data nào đó 
              -- tại 1 thời điểm chơi với 1 thùng chứa data

SELECT * FROM Customers

SELECT * FROM Employees

--------------------------------------------
-- Lí thuyết 
-- DBE cung cấp câu lệnh SELECT dùng để 
-- in ra màn hình 1 cái gì đó ~~~ printf() sout
-- in ra dữ liệu có trong table (hàng/cột)  !!!!!!!!!!!!!!!!!!!!!!
-- dùng cho mục đích nào thì kết quả hiển thị luôn là 1 table
-- 



-------------------------------



-- 1. Hôm nay là ngay bao nhiêu ??
SELECT GETDATE()

SELECT GETDATE() AS [Hôm nay là ngày]

-- 2.Bây giờ là tháng mấy hỡi em 

SELECT MONTH(GETDATE()) AS[Bây giờ là tháng mấy]

SELECT YEAR(GETDATE()) AS[Năm nay năm thứ mấy]

-- 3. trị tuyệt đối của -5 là mấy ?

SELECT ABS(-5) AS [Trị tuyệt đối của -5 là mấy ?]

-- 4.5 + 5 là mấy ??
SELECT 5 + 5


-- 5. In ra tên của mình
SELECT N'Phạm Tuấn Dương' AS [My full name is]
SELECT N'Phạm'+ N' Tuấn' + N' Dương' AS [My full name is]

-- 6 Tính tuổi
-- My age is
SELECT YEAR(GETDATE()) - 2002

SELECT N'Phạm'+ N' Tuấn' + N' Dương' + '  ' + CONVERT(varchar,  YEAR(GETDATE()) - 2002) + '    ' + 'YEARS OLD'  AS [MY PROFILE]
 
-- SELECT N'Phạm'+ N' Tuấn' + N' Dương' + '  ' + CAST(YEAR(GETDATE()) - 2002 AS VARCHAR)  AS MY PROFILE
-- nếu mà tên mà cách nhau bởi khoảng trắng chúng ta phải dùng as []


-- 7. Phép nhân 2 số 
SELECT 10 * 10 As [10 * 10 = ]
