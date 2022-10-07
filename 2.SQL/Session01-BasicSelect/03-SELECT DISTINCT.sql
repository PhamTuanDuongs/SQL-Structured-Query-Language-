USE Northwind

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
-- Khi ta SELECT ít cột từ table gốc thì có nguy cơ dữ liệu sẽ bị trùng lại
-- không phải ta bị sai, ko phải người thiết kế table và người nhập liệu bị sai 
-- Do chúng ta có nhiều info trùng nhau/ đặc điểm trùng nhau, nên nếu chỉ tập trung vào data
-- này trùng nhau chắc chắn xảy ra 
-- 100 triệu người dân được quản lý info bao gồm: ID, Tên DOB, ... Tỉnh thành sinh sống


-- Lệnh SELECT hỗ trợ loại trừ dòng trùng nhau / trúngDISTINCT tên - các - cột FROM <Tên - Table>
 -- Lệnh SELECT DI
-- 1 Liệt kê danh sách nhân viên 
SELECT * FROM Employees
-- Phân tích: 9 người chỉ có 4 title.   
SELECT TitleOfCourtesy FROM Employees -- 9 danh xưng 

SELECT DISTINCT EmployeeID,TitleOfCourtesy FROM Employees  -- chỉ là 4 

-- Nếu DISTINCT đi kèm với ID/KEY, nó vô dụng, key sao trùng mà loại trừ 

-- 2 In ra thông tin khách hàng 

SELECT * FROM Customers  -- 92 rows

-- 3. Có bao nhiêu quốc gia xuất hiện trong thông tin k/h, in ra
SELECT Country FROM Customers  -- 93 rows

SELECT DISTINCT Country FROM Customers  -- 22 rows

  