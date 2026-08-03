/*
=========================================================
Student Management Database System
File: 05_window_functions.sql
Description: SQL Window Functions Practice
Author: Muskan
=========================================================
*/

USE StudentManagementDB;
GO

/*=========================================================
TOPIC 1 : OVER()
Description : Perform calculations over a set of rows.
=========================================================*/

-- Q1. Display each student's marks with overall average marks.
SELECT
    StudentID,
    Marks,
    AVG(Marks) OVER() AS OverallAverageMarks
FROM Grades;

-- Q2. Display each payment with overall average payment.
SELECT
    PaymentID,
    Amount,
    AVG(Amount) OVER() AS AveragePayment
FROM Payments;

-- Q3. Display highest marks with every record.
SELECT
    StudentID,
    Marks,
    MAX(Marks) OVER() AS HighestMarks
FROM Grades;

-- Q4. Display total payment beside every payment.
SELECT
    PaymentID,
    Amount,
    SUM(Amount) OVER() AS TotalPayment
FROM Payments;

GO

/*=========================================================
TOPIC 2 : ROW_NUMBER()
=========================================================*/

-- Q1. Number students by StudentID.
SELECT
    ROW_NUMBER() OVER(ORDER BY StudentID) AS RowNo,
    StudentID,
    FirstName,
    LastName
FROM Students;

-- Q2. Number teachers alphabetically.
SELECT
    ROW_NUMBER() OVER(ORDER BY FirstName) AS RowNo,
    TeacherID,
    FirstName,
    LastName
FROM Teachers;

-- Q3. Number payments from highest amount.
SELECT
    ROW_NUMBER() OVER(ORDER BY Amount DESC) AS RowNo,
    PaymentID,
    Amount
FROM Payments;

-- Q4. Number grades by highest marks.
SELECT
    ROW_NUMBER() OVER(ORDER BY Marks DESC) AS RowNo,
    StudentID,
    Marks
FROM Grades;

GO

/*=========================================================
TOPIC 3 : RANK()
=========================================================*/

-- Q1. Rank students by marks.
SELECT
    StudentID,
    Marks,
    RANK() OVER(ORDER BY Marks DESC) AS StudentRank
FROM Grades;

-- Q2. Rank payments.
SELECT
    PaymentID,
    Amount,
    RANK() OVER(ORDER BY Amount DESC) AS PaymentRank
FROM Payments;

-- Q3. Rank courses by credits.
SELECT
    CourseID,
    CourseName,
    Credits,
    RANK() OVER(ORDER BY Credits DESC) AS CreditRank
FROM Courses;

GO

/*=========================================================
TOPIC 4 : DENSE_RANK()
=========================================================*/

-- Q1. Dense Rank students by marks.
SELECT
    StudentID,
    Marks,
    DENSE_RANK() OVER(ORDER BY Marks DESC) AS DenseRank
FROM Grades;

-- Q2. Dense Rank payments.
SELECT
    PaymentID,
    Amount,
    DENSE_RANK() OVER(ORDER BY Amount DESC) AS DensePaymentRank
FROM Payments;

-- Q3. Dense Rank courses.
SELECT
    CourseName,
    Credits,
    DENSE_RANK() OVER(ORDER BY Credits DESC) AS DenseCourseRank
FROM Courses;

GO

/*=========================================================
TOPIC 5 : NTILE()
=========================================================*/

-- Q1. Divide students into 4 groups.
SELECT
    StudentID,
    Marks,
    NTILE(4) OVER(ORDER BY Marks DESC) AS Quartile
FROM Grades;

-- Q2. Divide payments into 3 groups.
SELECT
    PaymentID,
    Amount,
    NTILE(3) OVER(ORDER BY Amount DESC) AS PaymentGroup
FROM Payments;

-- Q3. Divide courses into 2 groups.
SELECT
    CourseName,
    Credits,
    NTILE(2) OVER(ORDER BY Credits DESC) AS CourseGroup
FROM Courses;

GO

/*=========================================================
TOPIC 6 : LEAD()
=========================================================*/

-- Q1. Next student's marks.
SELECT
    StudentID,
    Marks,
    LEAD(Marks) OVER(ORDER BY Marks DESC) AS NextStudentMarks
FROM Grades;

-- Q2. Next payment.
SELECT
    PaymentID,
    Amount,
    LEAD(Amount) OVER(ORDER BY Amount DESC) AS NextPayment
FROM Payments;

-- Q3. Next course credits.
SELECT
    CourseName,
    Credits,
    LEAD(Credits) OVER(ORDER BY Credits DESC) AS NextCredits
FROM Courses;

GO

/*=========================================================
TOPIC 7 : LAG()
=========================================================*/

-- Q1. Previous student's marks.
SELECT
    StudentID,
    Marks,
    LAG(Marks) OVER(ORDER BY Marks DESC) AS PreviousMarks
FROM Grades;

-- Q2. Previous payment.
SELECT
    PaymentID,
    Amount,
    LAG(Amount) OVER(ORDER BY Amount DESC) AS PreviousPayment
FROM Payments;

-- Q3. Previous course credits.
SELECT
    CourseName,
    Credits,
    LAG(Credits) OVER(ORDER BY Credits DESC) AS PreviousCredits
FROM Courses;

GO

/*=========================================================
TOPIC 8 : PARTITION BY
=========================================================*/

-- Q1. Rank students within each department.
SELECT
    s.StudentID,
    s.FirstName,
    s.DepartmentID,
    g.Marks,
    RANK() OVER
    (
        PARTITION BY s.DepartmentID
        ORDER BY g.Marks DESC
    ) AS DepartmentRank
FROM Students s
INNER JOIN Grades g
ON s.StudentID=g.StudentID;

-- Q2. Average payment within each payment method.
SELECT
    PaymentMethod,
    Amount,
    AVG(Amount) OVER
    (
        PARTITION BY PaymentMethod
    ) AS AveragePayment
FROM Payments;

-- Q3. Total payment by payment method.
SELECT
    PaymentMethod,
    Amount,
    SUM(Amount) OVER
    (
        PARTITION BY PaymentMethod
    ) AS TotalPayment
FROM Payments;

GO

/*=========================================================
TOPIC 9 : Window Functions with JOIN
=========================================================*/

-- Q1. Student Rank with Department.
SELECT
    s.FirstName,
    d.DepartmentName,
    g.Marks,
    RANK() OVER(ORDER BY g.Marks DESC) AS StudentRank
FROM Students s
INNER JOIN Grades g
ON s.StudentID=g.StudentID
INNER JOIN Departments d
ON s.DepartmentID=d.DepartmentID;

-- Q2. Payment Rank with Student.
SELECT
    s.FirstName,
    p.Amount,
    ROW_NUMBER() OVER(ORDER BY p.Amount DESC) AS PaymentRow
FROM Students s
INNER JOIN Payments p
ON s.StudentID=p.StudentID;

-- Q3. Course Rank by Credits.
SELECT
    c.CourseName,
    d.DepartmentName,
    RANK() OVER(ORDER BY Credits DESC) AS CourseRank
FROM Courses c
INNER JOIN Departments d
ON c.DepartmentID=d.DepartmentID;

GO

/*=========================================================
TOPIC 10 : Business Reports
=========================================================*/

-- Report 1. Top Scoring Student.
SELECT TOP 1
    s.FirstName,
    g.Marks
FROM Students s
INNER JOIN Grades g
ON s.StudentID=g.StudentID
ORDER BY Marks DESC;

-- Report 2. Highest Fee Paid.
SELECT TOP 1
    s.FirstName,
    p.Amount
FROM Students s
INNER JOIN Payments p
ON s.StudentID=p.StudentID
ORDER BY Amount DESC;

-- Report 3. Department-wise Student Ranking.
SELECT
    s.FirstName,
    d.DepartmentName,
    g.Marks,
    ROW_NUMBER() OVER
    (
        PARTITION BY d.DepartmentName
        ORDER BY g.Marks DESC
    ) AS RankInDepartment
FROM Students s
INNER JOIN Departments d
ON s.DepartmentID=d.DepartmentID
INNER JOIN Grades g
ON s.StudentID=g.StudentID;

-- Report 4. Overall Student Merit List.
SELECT
    s.FirstName,
    g.Marks,
    RANK() OVER(ORDER BY Marks DESC) AS MeritRank
FROM Students s
INNER JOIN Grades g
ON s.StudentID=g.StudentID
ORDER BY MeritRank;

GO