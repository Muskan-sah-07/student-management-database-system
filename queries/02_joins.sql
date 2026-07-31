/*
=========================================================
Student Management Database System
File: 02_joins.sql
Description: SQL JOIN Practice
Author: Muskan
=========================================================
*/

USE StudentManagementDB;
GO

/*=========================================================
TOPIC 1 : INNER JOIN
Description : Returns only matching records from both tables.
=========================================================*/

-- Q1. Display students with their department.
SELECT
    s.StudentID,
    s.FirstName,
    s.LastName,
    d.DepartmentName
FROM Students s
INNER JOIN Departments d
ON s.DepartmentID = d.DepartmentID;

-- Q2. Display teachers with their department.
SELECT
    t.TeacherID,
    t.FirstName,
    t.LastName,
    d.DepartmentName
FROM Teachers t
INNER JOIN Departments d
ON t.DepartmentID = d.DepartmentID;

-- Q3. Display courses with teacher names.
SELECT
    c.CourseName,
    t.FirstName,
    t.LastName
FROM Courses c
INNER JOIN Teachers t
ON c.TeacherID = t.TeacherID;

-- Q4. Display courses with department names.
SELECT
    c.CourseName,
    d.DepartmentName
FROM Courses c
INNER JOIN Departments d
ON c.DepartmentID = d.DepartmentID;

-- Q5. Display students with enrolled courses.
SELECT
    s.FirstName,
    s.LastName,
    c.CourseName
FROM Enrollments e
INNER JOIN Students s
ON e.StudentID = s.StudentID
INNER JOIN Courses c
ON e.CourseID = c.CourseID;

GO

/*=========================================================
TOPIC 2 : LEFT JOIN
Description : Returns all rows from left table.
=========================================================*/

-- Q1. Display all students and payment details.
SELECT
    s.FirstName,
    s.LastName,
    p.Amount,
    p.PaymentMethod
FROM Students s
LEFT JOIN Payments p
ON s.StudentID = p.StudentID;

-- Q2. Display all students with attendance.
SELECT
    s.FirstName,
    a.AttendanceDate,
    a.Status
FROM Students s
LEFT JOIN Attendance a
ON s.StudentID = a.StudentID;

-- Q3. Display all courses with assignments.
SELECT
    c.CourseName,
    a.Title
FROM Courses c
LEFT JOIN Assignments a
ON c.CourseID = a.CourseID;

GO

/*=========================================================
TOPIC 3 : RIGHT JOIN
Description : Returns all rows from right table.
=========================================================*/

-- Q1. Display payment records with student names.
SELECT
    s.FirstName,
    p.Amount
FROM Students s
RIGHT JOIN Payments p
ON s.StudentID = p.StudentID;

-- Q2. Display attendance with student names.
SELECT
    s.FirstName,
    a.Status
FROM Students s
RIGHT JOIN Attendance a
ON s.StudentID = a.StudentID;

GO

/*=========================================================
TOPIC 4 : FULL OUTER JOIN
Description : Returns all matching and non-matching rows.
=========================================================*/

-- Q1. Students and payments.
SELECT
    s.FirstName,
    p.Amount
FROM Students s
FULL OUTER JOIN Payments p
ON s.StudentID = p.StudentID;

-- Q2. Courses and assignments.
SELECT
    c.CourseName,
    a.Title
FROM Courses c
FULL OUTER JOIN Assignments a
ON c.CourseID = a.CourseID;

GO

/*=========================================================
TOPIC 5 : MULTIPLE JOINS
=========================================================*/

-- Q1. Student → Department → Course
SELECT
    s.FirstName,
    d.DepartmentName,
    c.CourseName
FROM Students s
INNER JOIN Departments d
ON s.DepartmentID = d.DepartmentID
INNER JOIN Courses c
ON d.DepartmentID = c.DepartmentID;

-- Q2. Student → Enrollment → Course
SELECT
    s.FirstName,
    c.CourseName,
    e.EnrollmentDate
FROM Enrollments e
INNER JOIN Students s
ON e.StudentID = s.StudentID
INNER JOIN Courses c
ON e.CourseID = c.CourseID;


-- Q3. Student → Attendance → Course
SELECT
    s.FirstName,
    c.CourseName,
    a.AttendanceDate,
    a.Status
FROM Attendance a
INNER JOIN Students s
ON a.StudentID = s.StudentID
INNER JOIN Courses c
ON a.CourseID = c.CourseID;

-- Q4. Student → Grade → Assignment
SELECT
    s.FirstName,
    ass.Title,
    g.Marks
FROM Grades g
INNER JOIN Students s
ON g.StudentID = s.StudentID
INNER JOIN Assignments ass
ON g.AssignmentID = ass.AssignmentID;

-- Q5. Student → Payment
SELECT
    s.FirstName,
    p.Amount,
    p.PaymentMethod
FROM Students s
INNER JOIN Payments p
ON s.StudentID = p.StudentID;

GO

/*=========================================================
TOPIC 6 : JOIN + WHERE
=========================================================*/

-- Q1. Students from Computer Science.
SELECT
    s.FirstName,
    d.DepartmentName
FROM Students s
INNER JOIN Departments d
ON s.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';

-- Q2. Payments greater than 50000.
SELECT
    s.FirstName,
    p.Amount
FROM Students s
INNER JOIN Payments p
ON s.StudentID = p.StudentID
WHERE p.Amount > 50000;

-- Q3. Courses having 4 credits.
SELECT
    c.CourseName,
    t.FirstName
FROM Courses c
INNER JOIN Teachers t
ON c.TeacherID = t.TeacherID
WHERE c.Credits = 4;

GO

/*=========================================================
TOPIC 7 : JOIN + ORDER BY
=========================================================*/

-- Q1. Students ordered by department.
SELECT
    s.FirstName,
    d.DepartmentName
FROM Students s
INNER JOIN Departments d
ON s.DepartmentID = d.DepartmentID
ORDER BY d.DepartmentName;

-- Q2. Highest payment first.
SELECT
    s.FirstName,
    p.Amount
FROM Students s
INNER JOIN Payments p
ON s.StudentID = p.StudentID
ORDER BY p.Amount DESC;

GO

/*=========================================================
TOPIC 8 : JOIN + ALIAS
=========================================================*/

-- Q1. Student and Course aliases.
SELECT
    s.FirstName AS StudentName,
    c.CourseName AS Course
FROM Enrollments e
INNER JOIN Students s
ON e.StudentID = s.StudentID
INNER JOIN Courses c
ON e.CourseID = c.CourseID;

GO