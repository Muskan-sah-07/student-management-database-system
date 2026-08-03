/*
=========================================================
Student Management Database System
File: 06_reports.sql
Description: Business Reports using SQL
Author: Muskan
=========================================================
*/

USE StudentManagementDB;
GO

/*=========================================================
REPORT 1 : Student Directory
=========================================================*/

SELECT
    s.StudentID,
    s.FirstName,
    s.LastName,
    d.DepartmentName,
    s.Email,
    s.Phone
FROM Students s
INNER JOIN Departments d
ON s.DepartmentID = d.DepartmentID;

GO

/*=========================================================
REPORT 2 : Teacher Directory
=========================================================*/

SELECT
    t.TeacherID,
    t.FirstName,
    t.LastName,
    d.DepartmentName,
    t.Email
FROM Teachers t
INNER JOIN Departments d
ON t.DepartmentID = d.DepartmentID;

GO

/*=========================================================
REPORT 3 : Course Information
=========================================================*/

SELECT
    c.CourseName,
    d.DepartmentName,
    CONCAT(t.FirstName,' ',t.LastName) AS Teacher
FROM Courses c
INNER JOIN Departments d
ON c.DepartmentID=d.DepartmentID
INNER JOIN Teachers t
ON c.TeacherID=t.TeacherID;

GO

/*=========================================================
REPORT 4 : Student Enrollment Report
=========================================================*/

SELECT
    CONCAT(s.FirstName,' ',s.LastName) AS Student,
    c.CourseName,
    e.EnrollmentDate
FROM Enrollments e
INNER JOIN Students s
ON e.StudentID=s.StudentID
INNER JOIN Courses c
ON e.CourseID=c.CourseID;

GO

/*=========================================================
REPORT 5 : Attendance Report
=========================================================*/

SELECT
    CONCAT(s.FirstName,' ',s.LastName) AS Student,
    c.CourseName,
    a.AttendanceDate,
    a.Status
FROM Attendance a
INNER JOIN Students s
ON a.StudentID=s.StudentID
INNER JOIN Courses c
ON a.CourseID=c.CourseID;

GO

/*=========================================================
REPORT 6 : Student Marks Report
=========================================================*/

SELECT
    CONCAT(s.FirstName,' ',s.LastName) AS Student,
    ass.Title,
    g.Marks
FROM Grades g
INNER JOIN Students s
ON g.StudentID=s.StudentID
INNER JOIN Assignments ass
ON g.AssignmentID=ass.AssignmentID;

GO

/*=========================================================
REPORT 7 : Payment Report
=========================================================*/

SELECT
    CONCAT(s.FirstName,' ',s.LastName) AS Student,
    p.Amount,
    p.PaymentMethod,
    p.PaymentDate
FROM Payments p
INNER JOIN Students s
ON p.StudentID=s.StudentID;

GO

/*=========================================================
REPORT 8 : Department-wise Student Count
=========================================================*/

SELECT
    d.DepartmentName,
    COUNT(s.StudentID) AS TotalStudents
FROM Departments d
LEFT JOIN Students s
ON d.DepartmentID=s.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalStudents DESC;

GO

/*=========================================================
REPORT 9 : Department-wise Teacher Count
=========================================================*/

SELECT
    d.DepartmentName,
    COUNT(t.TeacherID) AS TotalTeachers
FROM Departments d
LEFT JOIN Teachers t
ON d.DepartmentID=t.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalTeachers DESC;

GO

/*=========================================================
REPORT 10 : Department-wise Course Count
=========================================================*/

SELECT
    d.DepartmentName,
    COUNT(c.CourseID) AS TotalCourses
FROM Departments d
LEFT JOIN Courses c
ON d.DepartmentID=c.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalCourses DESC;

GO

/*=========================================================
REPORT 11 : Student Performance Summary
=========================================================*/

SELECT
    CONCAT(s.FirstName,' ',s.LastName) AS Student,
    AVG(g.Marks) AS AverageMarks,
    MAX(g.Marks) AS HighestMarks,
    MIN(g.Marks) AS LowestMarks
FROM Students s
INNER JOIN Grades g
ON s.StudentID=g.StudentID
GROUP BY
s.FirstName,
s.LastName
ORDER BY AverageMarks DESC;

GO

/*=========================================================
REPORT 12 : Fee Collection Summary
=========================================================*/

SELECT
    PaymentMethod,
    COUNT(*) AS Transactions,
    SUM(Amount) AS TotalCollection,
    AVG(Amount) AS AverageCollection
FROM Payments
GROUP BY PaymentMethod;

GO

/*=========================================================
REPORT 13 : Top 5 Students
=========================================================*/

SELECT TOP 5
    CONCAT(s.FirstName,' ',s.LastName) AS Student,
    AVG(g.Marks) AS AverageMarks
FROM Students s
INNER JOIN Grades g
ON s.StudentID=g.StudentID
GROUP BY
s.FirstName,
s.LastName
ORDER BY AverageMarks DESC;

GO

/*=========================================================
REPORT 14 : Top Paying Students
=========================================================*/

SELECT TOP 5
    CONCAT(s.FirstName,' ',s.LastName) AS Student,
    p.Amount
FROM Students s
INNER JOIN Payments p
ON s.StudentID=p.StudentID
ORDER BY p.Amount DESC;

GO

/*=========================================================
REPORT 15 : Attendance Summary
=========================================================*/

SELECT
    Status,
    COUNT(*) AS TotalRecords
FROM Attendance
GROUP BY Status;

GO

/*=========================================================
REPORT 16 : Monthly Admissions
=========================================================*/

SELECT
    YEAR(AdmissionDate) AS AdmissionYear,
    MONTH(AdmissionDate) AS AdmissionMonth,
    COUNT(*) AS TotalAdmissions
FROM Students
GROUP BY
YEAR(AdmissionDate),
MONTH(AdmissionDate)
ORDER BY
AdmissionYear,
AdmissionMonth;

GO

/*=========================================================
REPORT 17 : Highest Fee Paid
=========================================================*/

SELECT TOP 1
    CONCAT(s.FirstName,' ',s.LastName) AS Student,
    p.Amount
FROM Students s
INNER JOIN Payments p
ON s.StudentID=p.StudentID
ORDER BY p.Amount DESC;

GO

/*=========================================================
REPORT 18 : Highest Marks
=========================================================*/

SELECT TOP 1
    CONCAT(s.FirstName,' ',s.LastName) AS Student,
    g.Marks
FROM Students s
INNER JOIN Grades g
ON s.StudentID=g.StudentID
ORDER BY g.Marks DESC;

GO

/*=========================================================
REPORT 19 : Students Above Average Marks
=========================================================*/

SELECT
    CONCAT(s.FirstName,' ',s.LastName) AS Student,
    g.Marks
FROM Students s
INNER JOIN Grades g
ON s.StudentID=s.StudentID
WHERE g.Marks >
(
SELECT AVG(Marks)
FROM Grades
)
ORDER BY g.Marks DESC;

GO

/*=========================================================
REPORT 20 : Complete Student Dashboard
=========================================================*/

SELECT
    s.StudentID,
    CONCAT(s.FirstName,' ',s.LastName) AS Student,
    d.DepartmentName,
    c.CourseName,
    t.FirstName AS Teacher,
    p.Amount,
    a.Status,
    g.Marks
FROM Students s
INNER JOIN Departments d
ON s.DepartmentID=d.DepartmentID
INNER JOIN Enrollments e
ON s.StudentID=e.StudentID
INNER JOIN Courses c
ON e.CourseID=c.CourseID
INNER JOIN Teachers t
ON c.TeacherID=t.TeacherID
INNER JOIN Payments p
ON s.StudentID=p.StudentID
INNER JOIN Attendance a
ON s.StudentID=a.StudentID
AND c.CourseID=a.CourseID
INNER JOIN Grades g
ON s.StudentID=g.StudentID;

GO