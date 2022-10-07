USE Northwind

-- Lí thuyết 
-- DB Engine hỗ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột, gom data tính toán
-- trên đám data gom này - nhóm hàng gom nhóm - Agrregate Functions, Aggregation
-- COUNT() SUM() MIN() MAX() AVG()
-- * Cú pháp
-- SELECT Cột...., Hàm Gom nhóm(), .... FROM <Table>
-- SELECT Cột...., Hàm Gom nhóm(),.....FROM<Table> WHERE.... GROUP BY,... HAVING

-- Thực hành
-- 1. Liệt kê danh sách nhân viên 
SELECT * FROM Employees
-- 2. Năm sinh nào là bé nhất
SELECT YEAR(BirthDate) FROM Employees WHERE YEAR(BirthDate) >= ALL(SELECT YEAR(BirthDate) FROM Employees)
SELECT MAX(BirthDate) FROM Employees
SELECT MIN(BirthDate) FROM Employees


-- 3 Ai sinh năm bé nhất, ai lớn tuổi nhất, in ra information
SELECT * FROM Employees WHERE BirthDate = (SELECT MIN(BirthDate) FROM Employees)
SELECT * FROM Employees WHERE BirthDate <= ALL(SELECT MIN(BirthDate) FROM Employees)
SELECT * FROM Employees WHERE BirthDate <= ALL(SELECT BirthDate FROM Employees)

-- 4. Trong các đơn hàng, đơn hàng nào có trọng lượng nặng nhất/nhỏ nhất
-- 4.1 Trong lượng nào là lớn nhất trong các đơn hàng đã bán
SELECT Freight FROM Orders ORDER BY Freight DESC
SELECT MAX(Freight) FROM Orders
--4.2 Trong các đơn hàng, đơn hàng nào có trọng lượng nặng nhất/nhỏ nhất
SELECT * FROM Orders WHERE Freight >= ALL(SELECT Freight FROM Orders)
									  OR Freight <= ALL(SELECT Freight FROM Orders)

--5. Tính tổng khối lượng của các đơn hàng đã vận chuyển 
-- 830 đơn hàng
SELECT COUNT(*) FROM Orders
SELECT SUM(Freight) As [freight in total] FROM Orders

--6. Trung bình các đơn hàng nặng bao nhiêu
SELECT AVG(Freight) FROM Orders -- 78.2442
--7. Liệt kê các đơn hàng có trọng lượng nặng hơn trọng lượng trung bình
SELECT Freight FROM Orders WHERE Freight >= (SELECT AVG(Freight) FROM Orders )

-- 8. Có bao nhiêu đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả
SELECT COUNT(*) FROM (
					SELECT Freight FROM Orders WHERE Freight >= (SELECT AVG(Freight) FROM Orders )
					 ) AS [AVG]

SELECT COUNT(Freight) FROM Orders WHERE Freight >= (SELECT AVG(Freight) FROM Orders )
-- Chỉ những thằng lớn hơn trung bình thì mới đếm, Không chia nhóm gì cả 
-- Nhắc lại cột xuất hiện trong SELECT hàm ý đếm theo cột này
-- Tỉnh, <Đếm cái gì đó của tỉnh> --> Rõ ràng phải chia theo tỉnh mà đếm
								 -- Group by  Tỉnh
-- Chuyên ngành, <Đếm của chuyên ngành> -> chia theo Chuyên nghành mà đếm
										--GROUP BY Chuyên ngành 
-- MÃ Chuyên Ngành, Tên Chuyên Ngành <SL SV> - GROUP BY MÃ CN, TÊN CN

-- Ôn tập thêm 
-- 1. In danh sách nhân viên
SELECT * FROM Employees
--2. Đếm xem mỗi khu vực có bao nhiêu nhân viên

SELECT Region, COUNT(*) FROM Employees GROUP BY Region -- Đúng vì đếm theo hàng
--

SELECT Region, COUNT(Region) FROM Employees GROUP BY Region -- NULL : 0
															-- WA : 5 Vì đếm theo giá trị trong cột thì giá trị null ko đc đếm
-- Sai vì đếm null
SELECT Region FROM Employees ORDER BY Region ASC 
-- 3 Khảo sát đơn hàng 
SELECT * FROM Orders
-- Mỗi quốc gia có bao nhiêu đơn hàng
SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders GROUP BY ShipCountry
-- 4. Quốc gia nào nhiều đơn hàng nhất
SELECT MAX([No orders]) FROM (SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders GROUP BY ShipCountry) AS Crc

SELECT ShipCountry,COUNT(*) FROM Orders GROUP BY ShipCountry HAVING COUNT(*) >=(
																				SELECT MAX([No orders]) FROM
																				(SELECT ShipCountry, COUNT(*) AS [No orders] FROM Orders GROUP BY ShipCountry) AS Crc  
																				)

SELECT  ShipCountry, COUNT(*) FROM Orders GROUP BY ShipCountry HAVING COUNT(*) >= ALL(
																				    SELECT COUNT(*) FROM Orders GROUP BY ShipCountry
                                                                                     )
-- 6. Liệt kê các đơn hàng của khách hàng mã số VINET

SELECT * FROM Orders WHERE CustomerID = 'VINET'
-- 7. Khách hàng VINET đã mua bao nhiêu lần ??
SELECT   CustomerID, COUNT(*)FROM Orders WHERE CustomerID = 'VINET'  GROUP BY CustomerID


