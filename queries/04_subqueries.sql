/*
=========================================================
Student Management Database System
File: 04_subqueries.sql
Description: SQL Subqueries Practice
Author: Muskan
=========================================================
*/

USE StudentManagementDB;
GO

/*=========================================================
TOPIC 1 : Single Row Subqueries
=========================================================*/

-- Q1. Student(s) having the highest marks.
SELECT *
FROM Grades
WHERE Marks = (
    SELECT MAX(Marks)
    FROM Grades
);

-- Q2. Student(s) having the lowest marks.
SELECT *
FROM Grades
WHERE Marks = (
    SELECT MIN(Marks)
    FROM Grades
);

-- Q3. Payment(s) with the highest amount.
SELECT *
FROM Payments
WHERE Amount = (
    SELECT MAX(Amount)
    FROM Payments
);

-- Q4. Payment(s) with the lowest amount.
SELECT *
FROM Payments
WHERE Amount = (
    SELECT MIN(Amount)
    FROM Payments
);

GO

/*=========================================================
TOPIC 2 : Average Value Subqueries
=========================================================*/

-- Q1. Students scoring above average marks.
SELECT *
FROM Grades
WHERE Marks >
(
    SELECT AVG(Marks)
    FROM Grades
);

-- Q2. Payments greater than average payment.
SELECT *
FROM Payments
WHERE Amount >
(
    SELECT AVG(Amount)
    FROM Payments
);

GO

/*=========================================================
TOPIC 3 : IN Subqueries
=========================================================*/

-- Q1. Students enrolled in any course.
SELECT *
FROM Students
WHERE StudentID IN
(
    SELECT StudentID
    FROM Enrollment
);

-- Q2. Students who made payments.
SELECT *
FROM Students
WHERE StudentID IN
(
    SELECT StudentID
    FROM Payments
);

-- Q3. Teachers teaching any course.
SELECT *
FROM Teachers
WHERE TeacherID IN
(
    SELECT TeacherID
    FROM Courses
);

GO

/*=========================================================
TOPIC 4 : NOT IN Subqueries
=========================================================*/

-- Q1. Students who have not enrolled in any course.
SELECT *
FROM Students
WHERE StudentID NOT IN
(
    SELECT StudentID
    FROM Enrollment
);

-- Q2. Students who have not made any payment.
SELECT *
FROM Students
WHERE StudentID NOT IN
(
    SELECT StudentID
    FROM Payments
);

GO

/*=========================================================
TOPIC 5 : EXISTS
=========================================================*/

-- Q1. Students who have attendance records.
SELECT *
FROM Students s
WHERE EXISTS
(
    SELECT 1
    FROM Attendance a
    WHERE a.StudentID = s.StudentID
);

-- Q2. Teachers who teach at least one course.
SELECT *
FROM Teachers t
WHERE EXISTS
(
    SELECT 1
    FROM Courses c
    WHERE c.TeacherID = t.TeacherID
);

GO

/*=========================================================
TOPIC 6 : NOT EXISTS
=========================================================*/

-- Q1. Students without attendance.
SELECT *
FROM Students s
WHERE NOT EXISTS
(
    SELECT 1
    FROM Attendance a
    WHERE a.StudentID = s.StudentID
);

-- Q2. Teachers not assigned any course.
SELECT *
FROM Teachers t
WHERE NOT EXISTS
(
    SELECT 1
    FROM Courses c
    WHERE c.TeacherID = t.TeacherID
);

GO

/*=========================================================
TOPIC 7 : Correlated Subqueries
=========================================================*/

-- Q1. Students whose payment is above the overall average.
SELECT
    s.StudentID,
    s.FirstName,
    p.Amount
FROM Students s
INNER JOIN Payments p
ON s.StudentID = p.StudentID
WHERE p.Amount >
(
    SELECT AVG(Amount)
    FROM Payments
);

-- Q2. Students whose marks are above the overall average.
SELECT
    s.StudentID,
    s.FirstName,
    g.Marks
FROM Students s
INNER JOIN Grades g
ON s.StudentID = g.StudentID
WHERE g.Marks >
(
    SELECT AVG(Marks)
    FROM Grades
);

GO

/*=========================================================
TOPIC 8 : Nested Subqueries
=========================================================*/

-- Q1. Find department of the student named 'Muskan'.
SELECT *
FROM Departments
WHERE DepartmentID =
(
    SELECT DepartmentID
    FROM Students
    WHERE FirstName = 'Muskan'
);

-- Q2. Find teacher of the course 'Database Management'.
SELECT *
FROM Teachers
WHERE TeacherID =
(
    SELECT TeacherID
    FROM Courses
    WHERE CourseName = 'Database Management'
);

GO

/*=========================================================
TOPIC 9 : Subquery with JOIN
=========================================================*/

-- Q1. Students having maximum marks.
SELECT
    s.StudentID,
    s.FirstName,
    g.Marks
FROM Students s
INNER JOIN Grades g
ON s.StudentID = g.StudentID
WHERE g.Marks =
(
    SELECT MAX(Marks)
    FROM Grades
);

-- Q2. Students having minimum marks.
SELECT
    s.StudentID,
    s.FirstName,
    g.Marks
FROM Students s
INNER JOIN Grades g
ON s.StudentID = g.StudentID
WHERE g.Marks =
(
    SELECT MIN(Marks)
    FROM Grades
);

GO

/*=========================================================
TOPIC 10 : Business Reports
=========================================================*/

-- Report 1 : Highest paying student.
SELECT
    s.FirstName,
    p.Amount
FROM Students s
INNER JOIN Payments p
ON s.StudentID = p.StudentID
WHERE p.Amount =
(
    SELECT MAX(Amount)
    FROM Payments
);

-- Report 2 : Highest scoring student.
SELECT
    s.FirstName,
    g.Marks
FROM Students s
INNER JOIN Grades g
ON s.StudentID = g.StudentID
WHERE g.Marks =
(
    SELECT MAX(Marks)
    FROM Grades
);

-- Report 3 : Students above average marks.
SELECT
    s.FirstName,
    g.Marks
FROM Students s
INNER JOIN Grades g
ON s.StudentID = g.StudentID
WHERE g.Marks >
(
    SELECT AVG(Marks)
    FROM Grades
)
ORDER BY g.Marks DESC;

-- Report 4 : Students paying above average fees.
SELECT
    s.FirstName,
    p.Amount
FROM Students s
INNER JOIN Payments p
ON s.StudentID = p.StudentID
WHERE p.Amount >
(
    SELECT AVG(Amount)
    FROM Payments
)
ORDER BY p.Amount DESC;

GO