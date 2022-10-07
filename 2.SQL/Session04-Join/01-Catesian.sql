
CREATE DATABASE Cartesian
USE Cartesian
-- Database Kho tủ thùng chứa Data bên trong
-- Data bên trong cất dưới dạng kệ có ngăn - Table
CREATE TABLE Endict      -- DDL(Một nhánh của SQL)
(						 -- Data Definition Language (Ngôn ngữ định nghĩa ra Data)
   Nmbr int, 
   EnDesc varchar(30)
)
 -- Từ điển tiếng Anh số đếm
-- 1 One
-- 2 two
 SELECT * FROM Endict    
-- DML Data manipulation language(Ngôn ngữ thao tác dữ liệu)
INSERT INTO Endict VALUES(1, 'One') 
INSERT INTO Endict VALUES(2, 'two')

INSERT INTO Endict VALUES(3, 'three')
-- Phần này thêm cho OUTER JOIN

INSERT INTO Endict VALUES(4, 'Four')
CREATE TABLE Vndict      -- DDL(Một nhánh của SQL)
(						 -- Data Definition Language (Ngôn ngữ định nghĩa ra Data)
   Nmbr int, 
   VnDesc nvarchar(30)		-- nvarchar() String lưu tiếng việt
							-- varchar() String lưu tiếng Anh
)
SELECT * FROM Vndict     
-- DML Data manipulation language(Ngôn ngữ thao tác dữ liệu)
INSERT INTO Vndict VALUES(1, N'Một')
INSERT INTO Vndict VALUES(2, N'Hai')
INSERT INTO Vndict VALUES(3, N'Ba')
INSERT INTO Vndict VALUES(5,N'Năm')
SELECT * FROM Endict
SELECT * FROM Vndict
-- Bôi đen cả 2 lệnh này chạy, thì nó không phải là join, Nó là hai câu 
-- riêng biệt chạy cùng lúc, cho 2 tập kết quả riêng biệt
-- join là gộp chung thành 1 bảng tạm trong ram, không ảnh hưởng dữ liệu gốc của 
-- mỗi table
-- Join là select cùng lúc nhiều table
SELECT * FROM Vndict, Endict -- Sinh ra table mới, tạm thời lúc chạy
                             -- Số cột = tổng 2 bên 
							 -- số dòng = tích 2 bên
SELECT * FROM Vndict, Endict ORDER BY EnDesc
--SELECT * FROM Vndict, Endict ORDER BY Nmbr -- Bối rối trùng tên

-- Ghép Table, JOIN bị trùng tên cột, Dùng ALIAS(AS), Đặt tên giả để tham chiếu
-- Chỉ định cột thuộc table nào để tránh nhầm

SELECT * FROM Vndict, Endict ORDER BY Vndict.Nmbr -- tham chiếu cột qua tên table
SELECT * FROM Vndict, Endict
SELECT * FROM VnDict vn, Endict en ORDER BY en.Nmbr -- đặt tên ngắn/ giả cho table
												    -- Dùng tham chiếu cho các cột
SELECT vn.Nmbr, vn.VnDesc,en.EnDesc FROM VnDict vn, Endict en ORDER BY en.Nmbr


SELECT vn.*,en.EnDesc FROM VnDict vn, Endict en ORDER BY en.Nmbr

SELECT vn.*,en.* FROM VnDict vn, Endict en ORDER BY en.Nmbr

-- Cú pháp thứ 2
SELECT vn.*,en.* FROM VnDict vn CROSS JOIN Endict en ORDER BY en.Nmbr

-- Tui biết rằng có cặp xài được, vì có tương hợp trong cell nào đó, Here 
-- Cross Join

SELECT * FROM VnDict vn, Endict en WHERE vn.Nmbr = en.Nmbr  -- rút từ 3 x 3 = 9 xuống còn 3
--- Ghép có chọn lọc khi tìm tương quan cột/Cell để ghép -> Inner Join/Outer
										-- EQUI JOIN
										-- Đa phần ghép theo toán tử
										-- Có thể ghép theo > >= < <= != <>

-- Thí nghiệm thêm cho INNER JOIN, Ghép ngang có xem xét môn đăng hộ đối hay ko ???

SELECT * FROM Endict  
SELECT * FROM Vndict

SELECT * FROM Endict e, Vndict v WHERE e.Nmbr > v.Nmbr  -- Ghép có chọn lọc nhưng không xài dấu =
														-- Mà dùng dấu > >= < <= !=
														-- Vẫn không là ghép bừa bãi
SELECT * FROM Endict e, Vndict v      -- Thực dụng 
						WHERE e.Nmbr != v.Nmbr 

SELECT * FROM Endict e JOIN Vndict v   -- Chuẩn mực
						ON e.Nmbr != v.Nmbr
-- Riêng Cross Join không được dùng WHERE
-- Tôi muốn lấy tiếng anh làm chuẩn, tìm các nghĩa tiếng việt tương đương
-- Nếu không có tương đương vẫn phải hiện ra
SELECT * FROM Endict e LEFT JOIN  Vndict v ON e.Nmbr = v.Nmbr

SELECT * FROM Endict e LEFT OUTER JOIN  Vndict v ON e.Nmbr = v.Nmbr

-- 4 Tôi muốn lấy tiếng việt làm đầu !!!
SELECT * FROM Vndict v LEFT OUTER JOIN Endict e ON v.Nmbr = e.Nmbr

-- 5 vẫn lấy tiếng việt làm đầu, nhưng để tiếng việt để bên tay phải kia
SELECT * FROM Endict e RIGHT OUTER JOIN Vndict v ON e.Nmbr = v.Nmbr

-- Dù chung và riêng của mỗi bên lấy tất chấp nhận FA ở 1 về 
SELECT * FROM Endict e FULL  JOIN Vndict v ON e.Nmbr = v.Nmbr


-- FULL OUTER JOIN, thứ tự table không quan trọng, viết trước sau đều được 
-- LEFT, RIGHT JOIN thứ tự table là có chuyện khác nhau 

SELECT * FROM Endict e LEFT OUTER JOIN Vndict v ON v.Nmbr = e.Nmbr -- Show 4 NULL

SELECT * FROM  Vndict v LEFT OUTER JOIN Endict e ON v.Nmbr = e.Nmbr -- Show 5 - năm

-- OUTER JOIN sinh ra để đảm bảo việc kết nối ghép bảng 
-- Ko bị mất data !!!!
-- Do INNER JOIN, JOIN: nó chỉ tìm cái chung của cả 2 bên 

-- Sau khi tìm ra được Data bao gồm phần trung và riêng ta vẫn có quyền Filter tiếp 
-- Chính là WHERE như bình thường

-- 6. In ra bộ từ điển Anh - Việt (Anh làm chuẩn của những con số từ 3 trở lên)

SELECT * FROM Endict e LEFT OUTER JOIN Vndict v
									   ON e.Nmbr = v.Nmbr 
									   WHERE e.Nmbr >= 3 -- có 2 

SELECT * FROM Endict e LEFT OUTER JOIN Vndict v
									   ON e.Nmbr = v.Nmbr 
									   WHERE v.Nmbr >= 3  -- Chỉ có 1
-- 7. In ra bộ từ điển Anh - Việt (Anh làm chuẩn của những con số từ 3 trở lên)

SELECT *FROM  Endict e FULL JOIN Vndict v ON e.Nmbr = v.Nmbr WHERE v.Nmbr >= 3 -- toang mất số 5  của VN


SELECT *FROM  Endict e FULL JOIN Vndict v ON e.Nmbr = v.Nmbr WHERE e.Nmbr >= 3 OR v.Nmbr >= 3
