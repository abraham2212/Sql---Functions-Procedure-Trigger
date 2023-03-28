CREATE DATABASE Course
USE Course
CREATE TABLE Students(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Age INT,
	Email NVARCHAR(50),
	Address NVARCHAR(100)
)

CREATE TABLE StudentArchives(
	Id INT PRIMARY KEY IDENTITY,
	StuId INT,
	Operation NVARCHAR(10),
	Date DATETIME
)

INSERT INTO Students(FirstName,LastName,Age,Email,Address) VALUES 
('Leyla','Agayeva',21,'leyla@code.edu.az','Ecemi'),
('Elmir','Azizov',22,'elmir@code.edu.az','28may'),
('zakir','alizade',23,'zalir@code.edu.az','Sumqayit')


CREATE TRIGGER trg_deleteStudent ON Students 
AFTER DELETE
AS
BEGIN
	INSERT INTO StudentArchives(StuId,Operation,Date)
	SELECT Id,'Delete',GETDATE() FROM DELETED
END

CREATE PROCEDURE usp_deleteStudentById
@id INT
AS
BEGIN
	DELETE FROM Students WHERE Id = @id
END

EXEC usp_deleteStudentById 2