USE Northwind

-- Lí thuyết 
-- DB Engine hỗ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột, gom data tính toán
-- trên đám data gom này - nhóm hàng gom nhóm - Agrregate Functions, Aggregation
-- COUNT() SUM() MIN() MAX() AVG()
-- * Cú pháp
-- SELECT Cột...., Hàm Gom nhóm(), .... FROM <Table>

-- Cú pháp mở rộng
-- SELECT Cột...., Hàm Gom nhóm(), .... FROM <Table>..WHERE... GROUP BY (Gom theo cụm cột nào)

-- SELECT Cột...., Hàm Gom nhóm(), .... FROM <Table>.. GROUP BY (Gom theo cụm cột nào).. HAVING....

--* Hàm Count() đếm số lần xuất hiện của 1 cái gì đó ???
--			Count(*) Đếm số dòng trong table, đếm tất cả các dòng ko Care tiêu chí nào cả
--          Count(*) FROM ...WHERE...
--				Chọn ra những dòng thỏa tiêu chí WHERE nào đó trước đã, rồi mới đến
--				Filter rồi đếm


--			Count(Cột nào đó): 
--1. In ra danh sách các nhân viên 
SELECT * FROM Employees

-- 2 Đếm xem có bao nhiêu nhân viên 
SELECT COUNT(*) as [Number of employess] FROM Employees 

-- 3 Có bao nhiêu nhân viên ở London
SELECT COUNT(*) as [No emps in London]FROM Employees WHERE City = 'London'

-- 4 Có nhiêu lượt thành phố xuất hiện - Cứ xuất hiện tên tp là đếm, ko care lặp lại hay ko

SELECT COUNT(City) FROM Employees
-- 5. Đếm xem có bao nhiêu Region
SELECT COUNT(Region) FROM Employees

-- Phát hiện ra hàm COUNT(Cột), Nếu Cell của cột chứa NULL, ko tính, ko đếm

-- Đếm xem có bao nhiêu khu vực NULL, có bao nhiêu dòng region null

SELECT COUNT(*) FROM Employees WHERE Region IS NULL -- Đếm sự xuất hiện của 1 dòng và chứ Region is NULL

SELECT COUNT(Region) FROM Employees WHERE Region IS NULL -- Này là sai vì Null ko đếm được, ko có bộ mặt ko có value

-- 6 Có bao nhiêu thành phố trong table 
SELECT   City FROM Employees -- 9 
SELECT DISTINCT City FROM Employees -- 5

-- Tui coi kết quả trên là 1 table, mất quá trời công sức lọc ra 5 thành phố

-- Sub Query mới, coi 1 câu SELECT là table, Biến Table này vào trong mệnh đề FROM

SELECT * FROM (SELECT DISTINCT City FROM Employees) As Cities


SELECT COUNT(*) FROM (SELECT DISTINCT City FROM Employees) As Cities -- 5 City

SELECT COUNT(*) FROM Employees --9 Nhân viên
SELECT COUNT(City) FROM Employees -- 9 City
SELECT COUNT(DISTINCT City) FROM Employees -- 5 City

-- 8. Đếm xem mỗi thành phố có bao nhiêu nhân viên
-- Khi câu hỏi có tính toán gom Data (Hàm Aggregate) mà lại chứa từ Khóa "MỖI"...
-- Gặp từ "Mỗi" Chia để đếm, Chia để trị, chịa cụm để gom đếm
SELECT * FROM Employees

-- Sự xuất hiện của nhóm
-- Đếm theo sự xuất hiện của nhóm
-- Đếm theo sự xuất hiện của nhóm, count++ trong nhóm thôi, sau đó reset ở nhóm mới
 SELECT COUNT (City) FROM Employees GROUP BY City -- Đếm VALUE Của City, nhưng đếm theo nhóm
												  -- Chia City thành nhóm, rồi đếm trong nhóm

SELECT City, COUNT (City) AS [No employess]FROM Employees GROUP BY City

SELECT EmployeeID,City, COUNT (City) AS [No employess]FROM Employees GROUP BY City, EmployeeID
-- vô nghĩa, chia nhóm theo key, mssv vô nghĩa

-- Chốt hạ khi dùng hàm gom nhóm, bạnc có quyền liệt kê tên cột lẻ ở SELECT
-- Nhưng cột lẻ đó phải bắt buộc xuất hiện trong mệnh đề GROUP BY
-- Để đảm bảo Logic: cột hiển thị | Số lượng đi kèm, để gom theo cột hiển thị mới logic
-- Cứ theo cột City mà gom, Cột City nằm ở SELECT hợp lý
-- Muốn hiển thị số lượng của ai đó, gì đó, gom theo cái gì đó

-- Nếu bạn gom theo Key/PK, vô nghĩa nhé
-- In ra mã nhân viên
-- 
--1
--2
--3
--4
--5
SELECT City, COUNT (City) AS [No employess]FROM Employees GROUP BY City

--9. Hãy cho tui biết TP nào có từ 2 nhân viên trở lên 
-- 2 Chặng làm
-- 9.1 Các tp có bao nhiêu nhân viên 
--9.2 Đếm xong mỗi thành phố ta bắt đầu lọc lại kết quả sau đếm
-- Filter sau đếm WHERE sau đếmk
SELECT City, COUNT (City) AS [No employess]FROM Employees GROUP BY City
SELECT City, COUNT (*) AS [No employess]FROM Employees GROUP BY City HAVING COUNT(*) >= 2

--10. Đếm số nhân viên của 2 thành phố Seatle và London
SELECT City, COUNT(*) FROM Employees WHERE City IN('Seattle' , 'London' ) GROUP BY City


--10. Đếm số nhân viên của 2 thành phố Seatle và London trong hai thành phố
-- thành phố nào có nhiều hơn 3 nhân viên
SELECT City, COUNT(*) FROM Employees
					 WHERE City IN('Seattle', 'London')
					 GROUP BY City 
					 HAVING COUNT(*) >= 3

--12. Đếm xem có bao nhiêu đơn hàng đã bán ra
SELECT COUNT(*) as [No orders] FROM Orders
-- 830 mã đơn khác nhau, đếm mã đơn, hay đếm cả cái đơn là như nhau
-- Nếu cột có value NULL ăn hành!!!

-- 12.1 Nước mĩ có bao nhiêu đơn hàng
SELECT ShipCountry, COUNT(*) AS [USA Orders] FROM Orders WHERE ShipCountry = 'USA'
-- Đi tìm Mĩ mà đếm , lọc Mĩ rồi tính tiếp, WHERE Mĩ
-- Không phải là câu gom chia nhóm, không có mỗi quốc gia bao nhiêu đơn 
-- Nếu mà là Mỗi quốc gia có bao nhiêu đơn, Count theo quốc gia, GROUP BY theo quốc gia

-- 12.3 Mĩ Anh Pháp chiếm tổng cộng bao nhiêu đơn hàng
SELECT COUNT(*) As [Total] FROM Orders WHERE ShipCountry IN('USA', 'UK', 'FRANCE')


-- 12.2 Mĩ Anh Pháp, mỗi quốc gia có bao nhiêu đơn hàng
SELECT ShipCountry, COUNT(*) As [No orders] 
							FROM Orders 
							WHERE ShipCountry IN( 'FRANCE','USA', 'UK') 
							GROUP BY ShipCountry
-- 12.4 Trong 3 quốc gia A P M, quốc gia nào có nhiều đơn hàng nhất
SELECT ShipCountry, COUNT(*) As [No orders] 
							FROM Orders 
							WHERE ShipCountry IN( 'FRANCE','USA', 'UK') 
							GROUP BY ShipCountry HAVING COUNT(*) >= ALL(SELECT COUNT(*) As [No orders] 
							FROM Orders 
							WHERE ShipCountry IN( 'FRANCE','USA', 'UK') 
							GROUP BY ShipCountry)
-- 12.5 Trong 3 quốc gia A P M, quốc gia nào đơn hàng nào từ 100 đơn hàng đổ lên
SELECT ShipCountry, COUNT(*) As [No orders] 
							FROM Orders 
							WHERE ShipCountry IN( 'FRANCE','USA', 'UK') 
							GROUP BY ShipCountry HAVING COUNT(*) >= 100
--13. Đếm xem có bao nhiêu mặt hàng có trong kho


--14. Đếm xem có bao nhiêu lượt quốc gia đã mua hàng
SELECT COUNT(ShipCountry) FROM Orders
 
--15. Đếm xem có bao nhiêu quốc gia đã mua hàng (Mỗi quốc gia đếm 1 lần)

SELECT COUNT(DISTINCT ShipCountry) FROM Orders

--16. Đếm số lượng đơn hàng của mỗi quốc gia

SELECT ShipCountry,COUNT(*) As [No orders]FROM Orders GROUP BY ShipCountry

--17. Quốc gia nào có từ 10 đơn hàng trở lên
SELECT ShipCountry, COUNT(*) FROM Orders GROUP BY ShipCountry HAVING COUNT(*) >= 10
--18. Đếm xem mỗi chủng loại hàng có bao nhiêu mặt hàng(Bia có 5 sp, hải sản có 4)
SELECT* FROM Products 

SELECT CategoryID, COUNT(*) FROM Products  GROUP BY CategoryID 
 
--BTVN
--10.Thành phố nào nhiều nhân viên nhất
SELECT City, COUNT(*) FROM Employees GROUP BY  City HAVING COUNT(*) >=  
													ALL(SELECT COUNT(*) FROM Employees GROUP BY  City)
--17. Quốc gia nào có nhiều đơn hàng nhất
SELECT ShipCountry, COUNT(*) As [No orders] FROM Orders GROUP BY ShipCountry HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM Orders GROUP BY ShipCountry)
 