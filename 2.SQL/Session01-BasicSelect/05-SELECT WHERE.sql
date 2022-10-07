USE Northwind

-- Lí thuyết
-- Cú pháp mở rộng lệnh SELECT 
-- mệnh đề WHERE: Dùng làm bộ lọc/Filter ra những dữ liệu ta cần theo 1 tiêu chí nào đó 
-- Ví dụ: Lọc ra những sinh viên quê ở  Bình Dương
--        Lọc ra những sinh viên ở Tiền Giang và điểm tb > 8 


-- Cú pháp dùng bộ lọc 
-- SELECT * (Cột bạn muốn in ra) From <Tên - table> WHERE <Điều Kiện Lọc>
-- * Điều kiện lọc: Tìm đường, với cái cột có giá trị cần lọc 
--                  Lọc theo tên cột với value như thế nào, lấy tên cột, xem value trong cell

-- Để viết điều kiện lọc ta cần
-- Tên cột

-- value của cột (cell)
-- toán tử (operator) > >= < <= =(chỉ một dấu bằng, không giống như C and Java), !=, <> (!= hoặc <> có ý nghĩa như nhau)
-- nhiều điều kiện lọc đi kèm, dùng thêm logic operators, AND, OR, NOT
-- Ví dụ: Tìm những ai đó ở bình dương
-- Where City = N 'Bình Dương'

-- Where City = N 'Bình Dương AND Gpa >= 8


-- Lọc liên quan đến giá trị/value/Cell chứa gì, ta phải quan tâm đến Data type
-- Số nguyên/thực, ghi số ra như truyền thống 5, 10, 3.14, 9.8
-- Chuỗi/kí tự: 'A'


-- Thực hành
-- 1.In ra các danh sách khách hàng

SELECT * FROM Customers  -- 92 rows

-- 2.In ra danh sách khách hàng đến từ Ý

SELECT * FROM Customers WHERE Country = 'Italy' -- 3

SELECT * FROM Customers WHERE Country = 'Germany'


-- 3. In ra danh sách đến từ Mỹ 

SELECT * FROM Customers WHERE Country = 'USA' -- 13


-- 4. In ra k/h đến từ Mĩ, Ý

SELECT * FROM Customers WHERE Country = 'USA'  OR Country = 'Italy'  ORDER BY Country 

-- 5. In ra khách hàng đến từ thủ đô của Nước Đức

SELECT * FROM Customers  WHERE Country = 'Germany' AND City = 'Berlin'

-- 6. In ra thông tin của nhân viên

SELECT * FROM Employees

-- 7. In ra các nhân viên có năm sinh từ 1960 trở lại đây 

SELECT * FROM Employees WHERE YEAR(BirthDate) >= 1960

-- 8. In ra các thông tin nhân viên có tuổi từ 60 trở lên
SELECT YEAR(GETDATE()) - YEAR(BirthDate) AS Age, * FROM Employees WHERE  YEAR(GETDATE()) - YEAR(BirthDate) >= 60

-- 9. Những nhân viên nào ở London 

SELECT * FROM Employees WHERE City = 'London'

-- 10. Những nhân viên không ở london
SELECT * FROM Employees WHERE City != 'London'
SELECT * FROM Employees WHERE City <> 'London'

-- Vi diệu 
-- Đảo mệnh đề !!!!
SELECT * FROM Employees WHERE NOT(City = 'London')


-- 11 In ra hồ sơ của nhân viên có mã hồ sơ là 1

SELECT *,LastName FROM Employees WHERE EmployeeID = 1
-- WHERE trên key chỉ ra 1 mà thôi 
-- SELECT mà có WHERE Key chỉ 1 dòng trả về, DISTICT là vô nghĩa

 SELECT DISTINCT EmployeeID, City FROM Employees WHERE EmployeeID = 1 ORDER BY EmployeeID


 -- Công thức Full không che của SELECT 
 -- SELECT.... From ... where .. Group by... having.. order by
 --        Distinct         1, N table      
 --        Hàm()
 --        Nested Query/Sub Query

 -- 12 Xem thông tin của bên đơn hàng
 SELECT * FROM Orders  --- 830 rows

-- 13 In ra đơn hàng sắp xếp giảm dần theo trọng lượng 

   SELECT * FROM Orders  ORDER BY Freight DESC
-- 14 In ra đơn hàng có trọng lượng lớn hơn 500
   SELECT * FROM Orders  WHERE Freight <= 500 AND ShipVia = 1

-- 15 In ra đơn hàng có trọng lượng từ 100 -> 500 và ship bởi công ty giao vận số  1
   SELECT * FROM Orders  WHERE Freight >= 100 AND Freight <= 500 AND ShipVia = 1

-- 16 In ra đơn hàng từ 100 -> 500 và sắp xếp theo ShipVia 

   SELECT * FROM Orders  WHERE Freight >= 100 AND Freight <= 500 ORDER BY ShipVia

-- Rất cẩn thận khi trong câu lệnh WHERE lại có AND OR trộn với nhau, ta phải xài thêm ()
-- Phân tách thứ tự Filter..(SS AND OR khác nữa) AND (SS khác)

-- 17 Và không Ship tới City
   SELECT * FROM Orders  WHERE Freight >= 100 AND Freight <= 500 AND ShipVia = 1 AND ShipCity <> 'London'
   
   SELECT * FROM Orders  WHERE Freight >= 100 AND Freight <= 500 AND ShipVia = 1 AND NOT(ShipCity = 'London')

-- 18  Liệt kê danh sách khách hàng đến từ USA hoặc Mexico 
SELECT * FROM Customers WHERE Country = 'USA' OR Country = 'Mexico'
-- 19 Liệt kê danh sách khách hàng không đến từ USA hoặc Mexico 

SELECT * FROM Customers WHERE NOT(Country = 'USA' OR Country = 'Mexico')

SELECT * FROM Customers WHERE  Country != 'USA' AND Country != 'Mexico'

-- Liệt kê các nhân viên sinh ra trong đoạn [1960 1970]

SELECT * FROM Employees WHERE YEAR(BirthDate) >= 1960 AND YEAR(BirthDate) <= 1970 ORDER BY BirthDate DESC

select * from Customers where  Country = 'Uk' OR Country = 'Mexico'