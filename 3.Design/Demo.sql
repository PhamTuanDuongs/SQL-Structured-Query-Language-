CREATE TABLE Major (
  MajorID   char(2) NOT NULL, 
  MajorName varchar(40) NOT NULL, 
  PRIMARY KEY (MajorID));
CREATE TABLE Students (
  StudentID char(8) NOT NULL, 
  FirstName varchar(10) NOT NULL, 
  LastName  varchar(40) NOT NULL, 
  MajorID   char(2) NOT NULL, 
  PRIMARY KEY (StudentID));


ALTER TABLE Students ADD CONSTRAINT FKStudents874676 
									FOREIGN KEY (MajorID) 
									REFERENCES Major (MajorID) 
									ON UPDATE Cascade 
									ON DELETE Set null;


