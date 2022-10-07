USE Northwind

--------------------------------------------
-- Lí thuyết 
--  một database là nơi chứa data(bán hàng, thư viện)
--  Data được lưu chữ dưới dạng tables, tách thành nhiều table 
--  
-- dùng cho mục đích nào thì kết quả hiển thị luôn là 1 table
-- Dùng lệnh SELECT để xem/in dữ liệu từ table, cũng hiển thị dưới dạng table
-- Cú pháp chuẩn : SELECT * FROM <Tên tables>
--                        * đại diện cho việc tôi muốn lấy all of columns

-- Cú pháp mở rộng : 
--                   SELECT tên các cột muốn lấy, cách nhau bằng dấu phẩy FROM <Tên - Table>
--					 SELECT có thể dùng các hàm xử lý các cột để độ lại thông tin hiển thị 
--                   FROM <Tên - table>


 -- Data trả về có cell/ ô có NULL, hiểu rẳng chưa xác định value hoặc chưa biết
 -- Từ từ cập nhật sau. Ví dụ sv kí tên vào danh sách thi 
 -- Ngay lúc kí tên gọi là NULL, mang trạng thái  chưa xác định

-- 1. xem thông tin của tất cả khách hàng đang giao dịch với mình 
 SELECT * FROM Customers
 INSERT INTO Customers(CustomerID, CompanyName, ContactName) 
                VALUES('ALFKI', 'FPT University', 'Pham Tuan Duong')
				-- bị chửi vì trùng PK 
 INSERT INTO Customers(CustomerID, CompanyName, ContactName) 
                VALUES('FPTUS', 'FPT University', 'Pham Tuan Duong')
				-- Ngon lành cành đào
-- 2. Xem thông tin nhân viên, xem hết các cột luôn

SELECT * FROM Employees

-- 3. Xem các sản phẩm có trong kho
SELECT * FROM Products

-- 4. Mua hàng, thì thông tin sẽ nằm ở table Orders và OrderDatails
SELECT * FROM Orders  -- 830 bills

-- 5. Xem thông tin công ty giao hàng
SELECT * FROM Shippers
INSERT INTO Shippers(CompanyName, Phone) VALUES('FEDEX VietNam', '(084)90.......')
-- 6. Xem chi tiết đơn hàng
SELECT * FROM Orders  -- Phần trên của Bill siêu thị

SELECT * FROM [Order Details] -- Phần table kẻ giónglề những món hàng đã mua

-- 7 In ra thông tin khách hàng chỉ gồm các cột Id, ComName, ContactName, Country

SELECT CustomerID, CompanyName, ContactName, Country FROM Customers

select CustomerID,CompanyName,ContactName,country from Customers where country is Null
-- 8 In ra thông tin của nhân viên: Chỉ cần cột Id, First, Last, First, Titl, DOB
-- Tên người phải tách thành last & first: dành cho mục tiêu sort theo tiêu chí tên, hộ. In ra 
-- tên theo quy ước mỗi quốc gia 
-- 
SELECT * FROM Employees

SELECT EmployeeID, LastName, FirstName, Title, BirthDate FROM Employees

-- 9 In ra thông tin nhân viên, ghép tên cho đẹp/ gộp cột, tính luôn tuổi
select EmployeeID, FirstName + ' ' + LastName as[Name], year(getDate()) - year(BirthDate) as[age]from Employees order by age asc

SELECT EmployeeID, LastName + '' + FirstName As [Full name], Title, BirthDate FROM Employees 

SELECT EmployeeID, LastName + '' + FirstName As [Full name], Title, BirthDate, YEAR (BirthDate) As [Year] FROM Employees 

SELECT EmployeeID, LastName + ' ' + FirstName As [Full name], Title, BirthDate, YEAR (BirthDate) As [Year], YEAR(GETDATE()) As [Year] , YEAR(GETDATE()) - YEAR(BirthDate) AS [Age]  FROM Employees 


-- 10 In ra thông tin chi tiết mua hàng

SELECT * FROM [Order Details]

SELECT *, UnitPrice * Quantity FROM [Order Details]

-- Công thức tính tổng tiền phải trả từng món, có trừ đi giảm giá, Phần trăm
-- SL * DG - Tiền giảm giá ==> tiền phải trả 
-- SL * DG - (SL * DG * DISCOUNT(%)) ==> Phải trả 
-- SL * DG(1 - Discount %) ==> Tiền phải trả 
SELECT *, UnitPrice * Quantity * (1 - Discount) As [SubTotal]FROM [Order Details]


