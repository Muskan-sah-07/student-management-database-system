/*
=========================================================
Student Management Database System
File: 05_views.sql
Description: Creates SQL Views for reporting and analysis.
Author: Muskan
=========================================================
*/

USE StudentManagementDB;
GO

/*=========================================================
TOPIC 1 : Student Details View
=========================================================*/

CREATE VIEW vw_StudentDetails
AS
SELECT
    s.StudentID,
    s.FirstName,
    s.LastName,
    s.Gender,
    s.DateOfBirth,
    s.Email,
    s.Phone,
    s.Address,
    s.AdmissionDate,
    d.DepartmentName
FROM Students s
INNER JOIN Departments d
ON s.DepartmentID = d.DepartmentID;
GO

/*=========================================================
TOPIC 2 : Teacher Details View
=========================================================*/

CREATE VIEW vw_TeacherDetails
AS
SELECT
    t.TeacherID,
    t.FirstName,
    t.LastName,
    t.Email,
    t.Phone,
    d.DepartmentName
FROM Teachers t
INNER JOIN Departments d
ON t.DepartmentID = d.DepartmentID;
GO

/*=========================================================
TOPIC 3 : Course Details View
=========================================================*/

CREATE VIEW vw_CourseDetails
AS
SELECT
    c.CourseID,
    c.CourseName,
    c.Credits,
    c.Duration,
    d.DepartmentName,
    CONCAT(t.FirstName,' ',t.LastName) AS TeacherName
FROM Courses c
INNER JOIN Departments d
ON c.DepartmentID = d.DepartmentID
INNER JOIN Teachers t
ON c.TeacherID = t.TeacherID;
GO

/*=========================================================
TOPIC 4 : Student Enrollment View
=========================================================*/

CREATE VIEW vw_StudentEnrollment
AS
SELECT
    s.StudentID,
    CONCAT(s.FirstName,' ',s.LastName) AS StudentName,
    c.CourseName,
    e.EnrollmentDate
FROM Enrollments e
INNER JOIN Students s
ON e.StudentID = s.StudentID
INNER JOIN Courses c
ON e.CourseID = c.CourseID;
GO

/*=========================================================
TOPIC 5 : Attendance View
=========================================================*/

CREATE VIEW vw_Attendance
AS
SELECT
    s.StudentID,
    CONCAT(s.FirstName,' ',s.LastName) AS StudentName,
    c.CourseName,
    a.AttendanceDate,
    a.Status
FROM Attendance a
INNER JOIN Students s
ON a.StudentID = s.StudentID
INNER JOIN Courses c
ON a.CourseID = c.CourseID;
GO

/*=========================================================
TOPIC 6 : Grades View
=========================================================*/

CREATE VIEW vw_Grades
AS
SELECT
    s.StudentID,
    CONCAT(s.FirstName,' ',s.LastName) AS StudentName,
    ass.Title AS Assignment,
    g.Marks
FROM Grades g
INNER JOIN Students s
ON g.StudentID = s.StudentID
INNER JOIN Assignments ass
ON g.AssignmentID = ass.AssignmentID;
GO

/*=========================================================
TOPIC 7 : Payment View
=========================================================*/

CREATE VIEW vw_PaymentDetails
AS
SELECT
    s.StudentID,
    CONCAT(s.FirstName,' ',s.LastName) AS StudentName,
    p.Amount,
    p.PaymentDate,
    p.PaymentMethod
FROM Payments p
INNER JOIN Students s
ON p.StudentID = s.StudentID;
GO

/*=========================================================
TOPIC 8 : Department Summary View
=========================================================*/

CREATE VIEW vw_DepartmentSummary
AS
SELECT
    d.DepartmentName,
    COUNT(s.StudentID) AS TotalStudents,
    COUNT(DISTINCT t.TeacherID) AS TotalTeachers
FROM Departments d
LEFT JOIN Students s
ON d.DepartmentID = s.DepartmentID
LEFT JOIN Teachers t
ON d.DepartmentID = t.DepartmentID
GROUP BY d.DepartmentName;
GO

/*=========================================================
TOPIC 9 : Student Performance View
=========================================================*/

CREATE VIEW vw_StudentPerformance
AS
SELECT
    s.StudentID,
    CONCAT(s.FirstName,' ',s.LastName) AS StudentName,
    AVG(g.Marks) AS AverageMarks
FROM Students s
INNER JOIN Grades g
ON s.StudentID = g.StudentID
GROUP BY
    s.StudentID,
    s.FirstName,
    s.LastName;
GO

/*=========================================================
TOPIC 10 : Payment Summary View
=========================================================*/

CREATE VIEW vw_PaymentSummary
AS
SELECT
    PaymentMethod,
    COUNT(*) AS TotalTransactions,
    SUM(Amount) AS TotalCollection,
    AVG(Amount) AS AveragePayment
FROM Payments
GROUP BY PaymentMethod;
GO

/*=========================================================
TOPIC 11 : Using the Views
=========================================================*/

SELECT * FROM vw_StudentDetails;
GO

SELECT * FROM vw_TeacherDetails;
GO

SELECT * FROM vw_CourseDetails;
GO

SELECT * FROM vw_StudentEnrollment;
GO

SELECT * FROM vw_Attendance;
GO

SELECT * FROM vw_Grades;
GO

SELECT * FROM vw_PaymentDetails;
GO

SELECT * FROM vw_DepartmentSummary;
GO

SELECT * FROM vw_StudentPerformance;
GO

SELECT * FROM vw_PaymentSummary;
GO