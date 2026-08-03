/*
=========================================================
Student Management Database System
File: 04_indexes.sql
Description: Creates indexes to improve query performance.
Author: Muskan
=========================================================
*/

USE StudentManagementDB;
GO

/*=========================================================
TOPIC 1 : NONCLUSTERED INDEX
Description : Speeds up searching on frequently queried columns.
=========================================================*/

-- Index on Student Email
CREATE NONCLUSTERED INDEX IX_Students_Email
ON Students (Email);
GO

-- Index on Student Department
CREATE NONCLUSTERED INDEX IX_Students_DepartmentID
ON Students (DepartmentID);
GO

-- Index on Teacher Email
CREATE NONCLUSTERED INDEX IX_Teachers_Email
ON Teachers (Email);
GO

-- Index on Teacher Department
CREATE NONCLUSTERED INDEX IX_Teachers_DepartmentID
ON Teachers (DepartmentID);
GO

-- Index on Course Department
CREATE NONCLUSTERED INDEX IX_Courses_DepartmentID
ON Courses (DepartmentID);
GO

-- Index on Course Teacher
CREATE NONCLUSTERED INDEX IX_Courses_TeacherID
ON Courses (TeacherID);
GO

/*=========================================================
TOPIC 2 : COMPOSITE INDEX
Description : Index on multiple columns.
=========================================================*/

-- Enrollment Student + Course
CREATE NONCLUSTERED INDEX IX_Enrollment_Student_Course
ON Enrollments (StudentID, CourseID);
GO

-- Attendance Student + Date
CREATE NONCLUSTERED INDEX IX_Attendance_Student_Date
ON Attendance (StudentID, AttendanceDate);
GO

-- Payment Student + Date
CREATE NONCLUSTERED INDEX IX_Payments_Student_Date
ON Payments (StudentID, PaymentDate);
GO

/*=========================================================
TOPIC 3 : UNIQUE INDEX
Description : Prevent duplicate values.
=========================================================*/

-- Unique Phone Number for Students
CREATE UNIQUE INDEX IX_Students_Phone
ON Students (Phone);
GO

-- Unique Phone Number for Teachers
CREATE UNIQUE INDEX IX_Teachers_Phone
ON Teachers (Phone);
GO

/*=========================================================
TOPIC 4 : INDEXED SEARCH EXAMPLES
=========================================================*/

-- Search student by email
SELECT *
FROM Students
WHERE Email = 'muskan@gmail.com';
GO

-- Search teacher by email
SELECT *
FROM Teachers
WHERE Email = 'amit.sharma@college.com';
GO

-- Students in a department
SELECT *
FROM Students
WHERE DepartmentID = 1;
GO

-- Courses by teacher
SELECT *
FROM Courses
WHERE TeacherID = 1;
GO

-- Payments by student
SELECT *
FROM Payments
WHERE StudentID = 1;
GO

/*=========================================================
TOPIC 5 : COMPOSITE INDEX USAGE
=========================================================*/

-- Enrollment search
SELECT *
FROM Enrollments
WHERE StudentID = 1
AND CourseID = 1;
GO

-- Attendance search
SELECT *
FROM Attendance
WHERE StudentID = 1
AND AttendanceDate = '2026-07-15';
GO

/*=========================================================
TOPIC 6 : VIEW EXISTING INDEXES
=========================================================*/

SELECT
    name AS IndexName,
    OBJECT_NAME(object_id) AS TableName,
    type_desc AS IndexType
FROM sys.indexes
WHERE OBJECT_NAME(object_id) IS NOT NULL
ORDER BY TableName;
GO

/*=========================================================
TOPIC 7 : BUSINESS EXAMPLES
=========================================================*/

-- Frequently searched students by department
SELECT
    StudentID,
    FirstName,
    LastName
FROM Students
WHERE DepartmentID = 2;
GO

-- Frequently searched payments
SELECT
    StudentID,
    Amount
FROM Payments
WHERE StudentID = 3;
GO

-- Frequently searched attendance
SELECT
    StudentID,
    AttendanceDate,
    Status
FROM Attendance
WHERE StudentID = 2;
GO

/*=========================================================
TOPIC 8 : DROP INDEX (Practice Only)
=========================================================*/

-- Uncomment only if you want to remove an index

-- DROP INDEX IX_Students_Email
-- ON Students;

-- DROP INDEX IX_Teachers_Email
-- ON Teachers;