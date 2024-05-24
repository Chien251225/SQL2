create database thisql;

use thisql;

-- create table
CREATE TABLE Teachers( 
TeacherID int IDENTITY (1,1) PRIMARY KEY NOT NULL, 
 FirstName varchar(255) NOT NULL,
 LastName varchar(255) NOT NULL,
 Subjects varchar(255) NOT NULL,);

 go 
CREATE TABLE Classes (
   ClassID int  IDENTITY (1,1) PRIMARY KEY NOT NULL,
   ClassName varchar(255) NOT NULL,
   TeacherID int NOT NULL,
   CONSTRAINT TeacherID_DK FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID),
);
go
CREATE TABLE Students (
   StudentID int  IDENTITY (1,1) PRIMARY KEY NOT NULL,
   FirstName varchar(255) NOT NULL,
   LastName varchar(255) NOT NULL,
   ClassID int NOT NULL,
   BirthDate date NOT NULL,
   CONSTRAINT ClassID_DK FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)); 

 --  insert data
 insert into Teachers (FirstName, LastName, Subjects) values 
('Alex ', 'Morden','English'),
('Philip ', 'Nguyen','Art'),
('Tran Van ', 'Luong','Math'),
('Tran Thi ', 'Huong','Music');

 INSERT INTO Classes (ClassID, ClassName, TeacherID) VALUES
(1, 'Mathematics', 1),
(2, 'Science', 2),
(3, 'Art', 3),
(4, 'English', 3),
(5, 'History', 2);

 insert into Students (FirstName, LastName, ClassID,BirthDate) values 
 (1, 'Alice', 'Smith', 1, '2001-06-10'),
(2, 'Join' , 'Mary', 2, '2004-01-11'),
(3, 'David', 'Salah', 3, '1999-04-21'),
(4, 'Michael', 'James', 4,'1998-02-30'),
(5,'Robert', 'Lewando', 5, '2005-01-12'),
(6,'Cristian', 'Ronaldo', 1, '2002-03-24'),
(7,'Lee', 'Nguyen', 2, '2003-01-23'),
(8,'Amanda', 'Sali', 3, '2005-0421'),
(9,'Samantha', 'Ahhi', 4, '2001-05-15'),
(10,'William', 'Saliba', 5, '2003-03-18');


-- 3. Data Query
SELECT s.FirstName, s.LastName, c.ClassName, t.FirstName AS TeacherFirstName, t.LastName AS TeacherLastName
FROM Students s
JOIN Classes c ON s.ClassID = c.ClassID
JOIN Teachers t ON c.TeacherID = t.TeacherID;

-- 4. Query Conditions
SELECT * FROM Students WHERE BirthDate >= '2000-01-01';

-- 5. JOIN Query
SELECT s.FirstName, s.LastName, c.ClassName, t.FirstName AS TeacherFirstName, t.LastName AS TeacherLastName
FROM Students s
JOIN Classes c ON s.ClassID = c.ClassID
JOIN Teachers t ON c.TeacherID = t.TeacherID
ORDER BY s.FirstName, s.LastName;

-- 6. Updating Data
UPDATE Students SET FirstName = 'John', LastName = 'Doe' WHERE StudentID = 3;

-- 7. Delete Data
DELETE FROM Students WHERE StudentID = 7;

-- 8. Procedure
DELIMITER //
CREATE PROCEDURE GetStudentsByClassAndSubject(IN class_id INT, IN subject_name VARCHAR(255))
BEGIN
  SELECT s.*
  FROM Students s
  JOIN Classes c ON s.ClassID = c.ClassID
  JOIN Teachers t ON c.TeacherID = t.TeacherID
  WHERE c.ClassID = class_id AND t.Subject = subject_name;
END //
DELIMITER ;

-- 9. View
CREATE VIEW StudentsWithClassAndTeacher AS
SELECT s.StudentID, s.FirstName, s.LastName, c.ClassName, t.FirstName AS TeacherFirstName, t.LastName AS TeacherLastName
FROM Students s
JOIN Classes c ON s.ClassID = c.ClassID
JOIN Teachers t ON c.TeacherID = t.TeacherID;

-- Bonus: Add constraints and indexes
ALTER TABLE Students ADD CONSTRAINT chk_birthdate CHECK (BirthDate <= CURDATE());
CREATE INDEX idx_studentname ON Students (FirstName, LastName);