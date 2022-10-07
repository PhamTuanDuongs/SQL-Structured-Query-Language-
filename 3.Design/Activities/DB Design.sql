-- Mỗi giảng viên có thể tổ chức nhiều seminar/ buổi phụ đạo khác nhau
-- chỉ do một giảng viên phụ trách
-- thông tin lưu trữ bao gôm: mã số giảng viên, tên giảng viên,
-- email, phone, bộ môn(SE, CF, ITS, Incubator),
-- ngày giờ seminar/phụ đạo, loại hình tổ chức
-- seminar, phụ đạo, workshop, chủ đề, tóm tắt nội dung
-- phòng học (nếu tiến hành offline), online-link
-- nếu tiến hành online, sĩ số dự kiến
-- xem: Đa trị, composite, look up, lặp lại trên 1 nhóm cụ 
-- tách thêm dòng tốt hơn tách thêm cột (khi cần data)


CREATE DATABASE DBDESIGN_ACTIVITIES
-- Đây mới chỉ là thiết kế theo dạng version 1 là kiểu loại version gom tất
-- cả vào trong 1 table 
USE DBDESIGN_ACTIVITIES
 CREATE TABLE ACTIVITY_1
(
	LecturerID char(8),
	LectureName nvarchar(30),  -- composite, tách khi nào, tách khi tao muốn sort, thành firstName, LastName
	Email varchar(50),
	Phone char(11),
	Major varchar(30),
	StartDate datetime, -- ngày giờ bắt đầu
	ActType nvarchar(30), -- workshop, seminar, phụ đạo
	Topic nvarchar(30),
	Intro nvarchar(250),
	Room nvarchar(50), --lưu hyperlink của Zoom, Meet, phòng hội trường
	Seat int

	)

	SELECT * FROM ACTIVITY_1
	INSERT INTO ACTIVITY_1
		   VALUES('00000001', N'Dương.PT', 'duongbeu777@', '090x','CF', '2021-11-3', 'seminar', N'Nhập môn Machine Learning', N'...', N'Phòng seminar Thư viện ĐH FPT HCM', 100)

    INSERT INTO ACTIVITY_1
		   VALUES('00000001', N'Dương.PT', 'duongbeu777@', '090x','CF', '2021-11-3 08:00:00', 'Seminar', N'Giới thiệu về YOLO V4 (part 2)', N'...', N'Phòng seminar Thư viện FUHCM', 100)

 -- Ưu điểm và nhược điểm 

 -- Tách thành 1 bảng chỉ chứa thông tin cá nhân của giảng viên 
 -- tránh trường hợp lắp đi lặp lại thônng tin cá nhân khi ta cho hết vào cùng 1 tables
 CREATE TABLE Lecture_2
 (
 LectureID char(8) PRIMARY KEY,
 LectName nvarchar(30),
 Email varchar(50),
 Phone char(11),
 Major varchar(30)
 )

  CREATE TABLE ACTIVITY_2
(   
	SEQ int IDENTITY PRIMARY KEY,
	StartDate datetime, -- ngày giờ bắt đầu
	ActType nvarchar(30), -- workshop, seminar, phụ đạo, coi chừng gõ workshop ko ai cấm gõ TRAINING
	Topic nvarchar(30),  
	Intro nvarchar(250),
	Room nvarchar(50), --lưu hyperlink của Zoom, Meet, phòng hội trường
	Seat int,
	LecturerID char(8) REFERENCES Lecture_2(LectureID)
)
   INSERT INTO Lecture_2 VALUES('00000001', N'Dương', 'duongbeu777@', '0971597955', 'CF')
   INSERT INTO Lecture_2 VALUES('00000002', N'Hùng', 'duongbeu778@', '0971597957', 'NF')

  SELECT * FROM Lecture_2
	INSERT INTO ACTIVITY_2
		   VALUES('2021-11-3 14:30:00', 'seminar', N'Nhập môn Machine Learning', N'...', N'Phòng seminar Thư viện ĐH FPT HCM', 100, '00000001')

    INSERT INTO ACTIVITY_2
		   VALUES('2021-11-3 08:00:00', 'Seminar', N'Giới thiệu về YOLO V4 (part 2)', N'...', N'Phòng seminar Thư viện FUHCM',100,'00000001')

    INSERT INTO ACTIVITY_2
		   VALUES('2021-11-3 08:30:00', 'workshop', N'Giới thiệu về YOLO V4 (part 3)', N'...', N'Phòng seminar Thư viện FUHCM',100,'00000001')
 SELECT * FROM Lecture_2
 SELECT *FROM ACTIVITY_2

 SELECT * FROM Lecture_2, ACTIVITY_2