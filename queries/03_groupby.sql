/*
=========================================================
Student Management Database System
File: 03_groupby.sql
Description: Aggregate Functions, GROUP BY and HAVING
Author: Muskan
=========================================================
*/

USE StudentManagementDB;
GO

/*=========================================================
TOPIC 1 : COUNT()
Description : Count total records.
=========================================================*/

-- Q1. Count total students.
SELECT COUNT(*) AS TotalStudents
FROM Students;

-- Q2. Count total teachers.
SELECT COUNT(*) AS TotalTeachers
FROM Teachers;

-- Q3. Count total courses.
SELECT COUNT(*) AS TotalCourses
FROM Courses;

-- Q4. Count total payments.
SELECT COUNT(*) AS TotalPayments
FROM Payments;

GO

/*=========================================================
TOPIC 2 : SUM()
Description : Calculate total values.
=========================================================*/

-- Q1. Total fee collected.
SELECT SUM(Amount) AS TotalFeeCollected
FROM Payments;

-- Q2. Total marks obtained.
SELECT SUM(Marks) AS TotalMarks
FROM Grades;

GO

/*=========================================================
TOPIC 3 : AVG()
Description : Calculate average values.
=========================================================*/

-- Q1. Average marks.
SELECT AVG(Marks) AS AverageMarks
FROM Grades;

-- Q2. Average payment amount.
SELECT AVG(Amount) AS AveragePayment
FROM Payments;

GO

/*=========================================================
TOPIC 4 : MIN()
=========================================================*/

-- Q1. Lowest marks.
SELECT MIN(Marks) AS LowestMarks
FROM Grades;

-- Q2. Lowest payment.
SELECT MIN(Amount) AS LowestPayment
FROM Payments;

GO

/*=========================================================
TOPIC 5 : MAX()
=========================================================*/

-- Q1. Highest marks.
SELECT MAX(Marks) AS HighestMarks
FROM Grades;

-- Q2. Highest payment.
SELECT MAX(Amount) AS HighestPayment
FROM Payments;

GO

/*=========================================================
TOPIC 6 : GROUP BY
=========================================================*/

-- Q1. Count students in each department.
SELECT
    DepartmentID,
    COUNT(*) AS TotalStudents
FROM Students
GROUP BY DepartmentID;

-- Q2. Count teachers in each department.
SELECT
    DepartmentID,
    COUNT(*) AS TotalTeachers
FROM Teachers
GROUP BY DepartmentID;

-- Q3. Count courses in each department.
SELECT
    DepartmentID,
    COUNT(*) AS TotalCourses
FROM Courses
GROUP BY DepartmentID;

-- Q4. Total payment by payment method.
SELECT
    PaymentMethod,
    SUM(Amount) AS TotalAmount
FROM Payments
GROUP BY PaymentMethod;

-- Q5. Average payment by payment method.
SELECT
    PaymentMethod,
    AVG(Amount) AS AveragePayment
FROM Payments
GROUP BY PaymentMethod;

-- Q6. Maximum payment by payment method.
SELECT
    PaymentMethod,
    MAX(Amount) AS HighestPayment
FROM Payments
GROUP BY PaymentMethod;

-- Q7. Minimum payment by payment method.
SELECT
    PaymentMethod,
    MIN(Amount) AS LowestPayment
FROM Payments
GROUP BY PaymentMethod;

-- Q8. Count attendance status.
SELECT
    Status,
    COUNT(*) AS TotalStatus
FROM Attendance
GROUP BY Status;

GO

/*=========================================================
TOPIC 7 : GROUP BY with JOIN
=========================================================*/

-- Q1. Students in each department.
SELECT
    d.DepartmentName,
    COUNT(s.StudentID) AS TotalStudents
FROM Departments d
INNER JOIN Students s
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName;

-- Q2. Teachers in each department.
SELECT
    d.DepartmentName,
    COUNT(t.TeacherID) AS TotalTeachers
FROM Departments d
INNER JOIN Teachers t
ON d.DepartmentID = t.DepartmentID
GROUP BY d.DepartmentName;

-- Q3. Courses in each department.
SELECT
    d.DepartmentName,
    COUNT(c.CourseID) AS TotalCourses
FROM Departments d
INNER JOIN Courses c
ON d.DepartmentID = c.DepartmentID
GROUP BY d.DepartmentName;

-- Q4. Average marks by student.
SELECT
    s.FirstName,
    AVG(g.Marks) AS AverageMarks
FROM Students s
INNER JOIN Grades g
ON s.StudentID = g.StudentID
GROUP BY s.FirstName;

-- Q5. Total payment by student.
SELECT
    s.FirstName,
    SUM(p.Amount) AS TotalPayment
FROM Students s
INNER JOIN Payments p
ON s.StudentID = p.StudentID
GROUP BY s.FirstName;

GO

/*=========================================================
TOPIC 8 : HAVING
Description : Filter grouped data.
=========================================================*/

-- Q1. Departments having more than one student.
SELECT
    DepartmentID,
    COUNT(*) AS TotalStudents
FROM Students
GROUP BY DepartmentID
HAVING COUNT(*) > 1;

-- Q2. Payment methods having total payment greater than 50000.
SELECT
    PaymentMethod,
    SUM(Amount) AS TotalPayment
FROM Payments
GROUP BY PaymentMethod
HAVING SUM(Amount) > 50000;

-- Q3. Students having average marks greater than 80.
SELECT
    StudentID,
    AVG(Marks) AS AverageMarks
FROM Grades
GROUP BY StudentID
HAVING AVG(Marks) > 80;

GO

/*=========================================================
TOPIC 9 : GROUP BY + ORDER BY
=========================================================*/

-- Q1. Departments sorted by student count.
SELECT
    DepartmentID,
    COUNT(*) AS TotalStudents
FROM Students
GROUP BY DepartmentID
ORDER BY TotalStudents DESC;

-- Q2. Payment methods sorted by total amount.
SELECT
    PaymentMethod,
    SUM(Amount) AS TotalAmount
FROM Payments
GROUP BY PaymentMethod
ORDER BY TotalAmount DESC;

GO

/*=========================================================
TOPIC 10 : Business Reports
=========================================================*/

-- Report 1 : Department-wise Student Count.
SELECT
    d.DepartmentName,
    COUNT(s.StudentID) AS TotalStudents
FROM Departments d
INNER JOIN Students s
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalStudents DESC;

-- Report 2 : Department-wise Teacher Count.
SELECT
    d.DepartmentName,
    COUNT(t.TeacherID) AS TotalTeachers
FROM Departments d
INNER JOIN Teachers t
ON d.DepartmentID = t.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalTeachers DESC;

-- Report 3 : Payment Summary.
SELECT
    PaymentMethod,
    COUNT(*) AS Transactions,
    SUM(Amount) AS TotalCollected,
    AVG(Amount) AS AveragePayment,
    MIN(Amount) AS LowestPayment,
    MAX(Amount) AS HighestPayment
FROM Payments
GROUP BY PaymentMethod
ORDER BY TotalCollected DESC;

-- Report 4 : Student Marks Summary.
SELECT
    StudentID,
    COUNT(*) AS TotalAssignments,
    AVG(Marks) AS AverageMarks,
    MAX(Marks) AS HighestMarks,
    MIN(Marks) AS LowestMarks
FROM Grades
GROUP BY StudentID
ORDER BY AverageMarks DESC;

GO