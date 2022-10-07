USE Northwind

-- Lí thuyết
-- Cú pháp mở rộng lệnh SELECT 
-- Khi cần lọc dữ liệu trong 1 đoạn cho trước, thay vì dùng >=..., ta có thể thay thế
-- Bằng mệnh đề between, In 
-- * Cú pháp: Cột Between Value-1 AND Value-2
                          -- >>> BETWEEN thay thế cho 2 mệnh đề >= <= AND
-- * Cú pháp: Cột In (Một tập các giá trị được liệt kê được cách nhau băng dấu 'Phẩy')
--                 >> In thay thế cho 1 loạt OR
-- 1. liệt kê danh sách nhân viên sinh trong đoạn từ 1960 - 1970 

SELECT * FROM Employees WHERE YEAR(BirthDate) >= 1960 AND YEAR(BirthDate) <= 1970 
           ORDER BY BirthDate DESC

SELECT * FROM Employees WHERE YEAR(BirthDate) BETWEEN 1960 AND 1970 ORDER BY BirthDate DESC

-- 2. Liệt kê các đơn hàng có trọng lượng từ 100..500

SELECT * FROM Orders WHERE Freight BETWEEN 100 AND 500
-- 3. Liệt kê các đơn hàng gửi tới USA OR FRANCE OR UK

SELECT * FROM Orders WHERE ShipCountry = 'USA' OR ShipCountry = 'UK' OR ShipCountry = 'FRANCE'  -- 255


SELECT * FROM Orders WHERE ShipCountry IN('USA', 'FRANCE', 'UK')
-- 4. Liệt kê đơn hàng nào không gửi tới USA, France, UK

SELECT * FROM Orders WHERE NOT(ShipCountry = 'USA' OR ShipCountry = 'UK' OR ShipCountry = 'FRANCE')  -- 255

SELECT * FROM Orders WHERE ShipCountry  NOT IN('USA', 'FRANCE', 'UK')

-- 5. Liệt kê đơn hàng nào trong năm 1996 loại trừ các tháng 6 7 8 9
SELECT * FROM Orders WHERE YEAR(OrderDate) = 1960
                     AND MONTH(OrderDate) NOT IN (6,7,8,9)

-- Lưu ý IN: Chỉ khi ta liệt kê được tập giá trị thì mới chơi IN 
-- Khoảng số thực thì không làm được


-- 6. Liệt kê các đơn hàng có trọng lượn từ 100... 110


SELECT * FROM Orders WHERE Freight >= 100 AND Freight <= 110 ORDER BY Freight DESC

SELECT * FROM Orders WHERE Freight BETWEEN 100 AND 110 ORDER BY Freight DESC

