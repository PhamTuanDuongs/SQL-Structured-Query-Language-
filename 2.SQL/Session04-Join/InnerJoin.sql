  
 SELECT * FROM VnDict, EnDict   -- Tích Đề - Các

 SELECT vn.*,en.* FROM VnDict vn CROSS JOIN Endict en

 SELECT * FROM VnDict vn, Endict en WHERE vn.Nmbr = en.Nmbr

  SELECT * FROM VnDict , Endict WHERE VnDict.Nmbr = Endict.Nmbr
						-- Nên đặt ALIAS thì giúp ngắn gọn câu lệnh

-- chuẩn thế giới 
SELECT * FROM VnDict INNER JOIN EnDict --Nhìn sâu vào table rồi ghép, ko ghép bừa 
									ON VnDict.Nmbr = EnDict.Nmbr -- Ghép có tương quan bên trong

SELECT * FROM VnDict JOIN EnDict --Nhìn sâu vào table rồi ghép, ko ghép bừa 
									ON VnDict.Nmbr = EnDict.Nmbr

						-- Có thể dùng thêm WHERE đc hay không ??? Khi xài INNER, JOIN
						-- JOIN chỉ là thêm Data để tính toán, Gộp Data lại nhiều hơn, sau đó áp dụng
						-- toàn bộ kiến thức đã học 