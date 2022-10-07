USE Northwind

-- Lí thuyết chuẩn của lệnh SELECT
--SELECT * FROM <Table> WHERE...

-- WHERE Cột = Value nào đó
-- WHERE Cột  IN(tập hợp nào đó)
-- Ví dụ: City IN('London', 'Berlin', 'Network') -- thay thế bằng OR OR OR
---

-- Nếu có 1 câu SQL mà trả về được 1 cột nhưng mà nhiều dòng
-- Một cột và nhiều dòng thì ta có thể xem nó tương đương một tập hợp
-- SELECT City FROM Employees, Bạn có được 1 loạt các t/p
-- Ta có thể nhét/lồng câu 1 cột/ nhiều dòng vào trong mệnh đề IN của câu SQL bên ngoài 
-- Cú pháp
-- WHERE Cột IN (Một câu SELECT trả về 1 cột nhiều dòng - Nhiều Value cùng kiểu - Tập Hợp)
-------

-- Thực hành 
-- 1.Liệt kê các nhóm hàng
SELECT * FROM Categories

-- 2. In ra các món hàng thuộc nhóm 1,6,8

SELECT * FROM Products WHERE CategoryID IN(1,6,8)

SELECT * FROM Products WHERE CategoryID = 1 OR CategoryID = 6 OR CategoryID = 8 

-- 3. In ra các món hàng thuộc nhóm bia/rượu, thịt và hải sản


SELECT CategoryID FROM  Categories WHERE CategoryName IN('Seafood', 'Beverages', 'Meat/Poultry')

SELECT * FROM Products WHERE CategoryID IN(
										SELECT CategoryID FROM  Categories WHERE CategoryName IN('Seafood', 'Beverages', 'Meat/Poultry')
										 )

-- 4. Nhân viên ở London phụ trách những đơn hàng nào
SELECT * FROM Orders
SELECT EmployeeID FROM Employees WHERE City = 'London'

SELECT * FROM Orders WHERE EmployeeID IN(
										SELECT EmployeeID FROM Employees WHERE City = 'London'
										)
-- BTVN
-- 2. Các nhà cung cấp đến từ Mĩ cung cấp nhưng nhóm hàng nào 

-- 1. Các nhà cung cấp đến từ Mĩ cung cấp những mặt hàng nào

SELECT * FROM Products WHERE SupplierID IN (
								SELECT SupplierID FROM Suppliers WHERE Country = 'USA'
								)
-- 2. Các nhà cung cấp đến từ Mĩ cung cấp nhưng nhóm hàng nào 
SELECT * FROM Categories WHERE CategoryID IN (
                                                       SELECT  CategoryID  FROM Products WHERE SupplierID IN(					
													   SELECT SupplierID FROM Suppliers WHERE Country = 'USA'
                                                        )
														)

														SELECT * FROM Products
														SELECT * FROM Categories

-- 3. Các đơn hàng vận chuyển tới thành phố Sao Paulo được vận chuyển bởi những hãng nào
-- Các cty đã vận chuyển hàng tới Sao Paulo

SELECT * FROM Orders 
SELECT * FROM Shippers WHERE ShipperID IN (
										  SELECT ShipVia FROM Orders WHERE OrderID IN (
										  SELECT OrderID FROM Orders WHERE ShipCity = 'Sao Paulo'
																						)
										  )


--4. Khách hàng đến từ thành phố Berlin, London, Madrid có những đơn hàng nào
-- Liệt kê các đơn hàng của khách hàng đến từ Berlin, London, Madrid

SELECT * FROM Orders WHERE CustomerID IN(
									  SELECT CustomerID FROM Customers WHERE City IN ('Berlin', 'London', 'Madrid')
									  )
