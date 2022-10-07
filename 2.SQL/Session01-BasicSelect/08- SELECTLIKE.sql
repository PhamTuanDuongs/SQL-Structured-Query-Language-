USE Northwind

-- Lí thuyết
-- Cú pháp mở rộng lệnh SELECT 
-- Trong thực tế có những lúc ta muốn tìm dữ liệu/filter theo kiểu gần đúng
-- gần đúng trên kiểu chuỗi, ví dụ, liệt kê ai đó có tên là AN, khác câu
-- liệt kê ai đó bắt đầu bằng chữ A
-- Tìm đúng, Toán Tử = 'AN'
-- Tìm gần đúng, tìm có sự xuất hiện, ko dùng =, dùng toán tử LIKE
-- Để sử dụng toán tử LIKE, ta cần thêm 2 thứ trợ giúp, dấu % và Dấu _
-- %: Đại diện cho 1 chuỗi bất kì nào đó
-- _ : Đại diện cho 1 kí tự bất kì nào đó 
-- Ví dụ: Name LIKE 'A%' bất kỳ ai có tên bắt đầu bằng chữ A, phần còn lại là gì ko care
--        Name LIKE 'A_', bất kì ai có 2 kí tự, trong đó kí tự đầu phải là A  
--1. In ra danh sách nhân viên
SELECT * FROM Employees

--2. Nhân viên nào có tên bắt đầu bằng chữ A
SELECT * FROM Employees WHERE FirstName = 'A%'  -- 0 vì toán tử ss bằng A%, có ai tên là A 

SELECT * FROM Employees WHERE FirstName LIKE 'A%'

-- 2.1 Nhân viên nào đó có tên bắt đầu bằng chữ A, In ra cả fullname được ghép đầy đủ
SELECT  EmployeeID,LastName +' '+ FirstName AS FullName FROM Employees WHERE FirstName LIKE 'A%'

SELECT EmployeeID, CONCAT(LastName,' ', FirstName) AS FUllName FROM Employees WHERE FirstName LIKE 'A%'

-- 3 Nhân viên nào có chữ A cuối cùng
SELECT  EmployeeID,LastName +' '+ FirstName AS FullName FROM Employees WHERE FirstName LIKE '%A'


-- 4. Nhân viên nào tên có 4 kí tự 
-- Dùng hàm kiểm tra độ dài của tên = 4 hay ko 
-- hàm kiểm tra độ dài LEN()
SELECT FirstName FROM Employees WHERE LEN(FirstName) = 4

SELECT * FROM Employees WHERE FirstName LIKE '____'
--5. Xem danh sách các sản phẩm/món đồ đang có- Product

SELECT * FROM Products -- 77

--6. Những sản phẩm nào tên bắt đầu bằng CH
SELECT * FROM Products WHERE ProductName LIKE 'CH%'

SELECT * FROM Products WHERE ProductName LIKE '%CH%' -- 14
-- trong tên có chứa Ch, ko quan tâm vị trí xuất hiện

-- 7. Những sản phẩm có 5 kí tự
SELECT * FROM Products WHERE ProductName LIKE '_____'

-- 7. Những sản phẩm tên từ cuối cùng là 5 kí tự
SELECT * FROM Products WHERE ProductName LIKE '%_____' --tên có từ 5 kí tự trở lên 

SELECT *FROM Products WHERE ProductName LIKE '% _____' OR ProductName LIKE '_____'--tên có it nhất 2 từ từ cuối cùng 5 kí tự là đúng

-- BTVN 
 
-- Liệt kê các nhân viên trẻ tuổi hơn nhân viên Janet

-- 1 Liệt kê danh sách các công ty vận chuyển hàng
SELECT * FROM Shippers
-- 2.Liệt kê danh sách các đơn hàng được vận chuyện bởi công ty giao vận
-- có mã số 1
SELECT *  FROM Orders WHERE ShipVia = 1
-- 3.Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận
-- có tên Speedy Expresss và trọng lượng từ 50 - 100
SELECT ShipperID FROM Shippers WHERE CompanyName = 'Speedy Express'
SELECT OrderID FROM Orders WHERE ShipVia = (
											SELECT ShipperID FROM Shippers WHERE CompanyName = 'Speedy Express'
											) AND Freight BETWEEN 50 AND 100
-- 4 Liệt kê các mặt hàng cùng chủng loại với mặt hàng Filo Mix

SELECT * FROM  Products 

SELECT CategoryID  FROM Products WHERE ProductName = 'Filo Mix'

SELECT * FROM Products WHERE CategoryID = (
				 						SELECT CategoryID  FROM Products WHERE ProductName = 'Filo Mix'
										  )

-- Liệt kê các nhân viên trẻ tuổi hơn nhân viên Janet

SELECT * FROM Employees

SELECT YEAR (BirthDate) FROM Employees WHERE FirstName = 'Janet'

SELECT EmployeeID, LastName, FirstName, Title, BirthDate FROM Employees WHERE YEAR(BirthDate) > (
																	  SELECT YEAR (BirthDate) FROM Employees WHERE FirstName = 'Janet'
															  )
select * from Employees where FirstName like '%i'
-- In là so sánh =, thay cho 1 đống OR																	  
Select * from Employees where len(LastName) = 4
select * from Employees where LastName like '_____'
select * from Products where ProductName like 'CH%'
select * from Products Where ProductName like '%CH%'
                                              
 