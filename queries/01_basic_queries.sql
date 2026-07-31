/*
=========================================================
Student Management Database System
File: 01_basic_queries.sql
Description: Basic SQL Queries Practice
Author: Muskan
=========================================================
*/

USE StudentManagementDB;
GO

/*=========================================================
TOPIC 1 : SELECT
Description : Retrieve data from a table.
=========================================================*/

-- Q1. Display all students.
SELECT *
FROM Students;

-- Q2. Display all teachers.
SELECT *
FROM Teachers;

-- Q3. Display all courses.
SELECT *
FROM Courses;

-- Q4. Display only student first name and email.
SELECT FirstName, Email
FROM Students;

-- Q5. Display course name and credits.
SELECT CourseName, Credits
FROM Courses;

GO

/*=========================================================
TOPIC 2 : DISTINCT
Description : Remove duplicate values.
=========================================================*/

-- Q1. Show unique Department IDs from Students.
SELECT DISTINCT DepartmentID
FROM Students;

-- Q2. Show unique Payment Methods.
SELECT DISTINCT PaymentMethod
FROM Payments;

GO

/*=========================================================
TOPIC 3 : WHERE
Description : Filter records.
=========================================================*/

-- Q1. Show female students.
SELECT *
FROM Students
WHERE Gender='Female';

-- Q2. Show students from Department 1.
SELECT *
FROM Students
WHERE DepartmentID=1;

-- Q3. Show courses having 4 credits.
SELECT *
FROM Courses
WHERE Credits=4;

GO

/*=========================================================
TOPIC 4 : Comparison Operators
=========================================================*/

-- Q1. Payments greater than 50000.
SELECT *
FROM Payments
WHERE Amount>50000;

-- Q2. Payments less than 50000.
SELECT *
FROM Payments
WHERE Amount<50000;

-- Q3. Grades greater than or equal to 90.
SELECT *
FROM Grades
WHERE Marks>=90;

-- Q4. Grades not equal to 100.
SELECT *
FROM Grades
WHERE Marks<>100;

GO

/*=========================================================
TOPIC 5 : AND / OR / NOT
=========================================================*/

-- Q1. Female students from Department 1.
SELECT *
FROM Students
WHERE Gender='Female'
AND DepartmentID=1;

-- Q2. Students from Department 1 or 2.
SELECT *
FROM Students
WHERE DepartmentID=1
OR DepartmentID=2;

-- Q3. Students not from Department 3.
SELECT *
FROM Students
WHERE NOT DepartmentID=3;

GO

/*=========================================================
TOPIC 6 : ORDER BY
=========================================================*/

-- Q1. Sort students by First Name.
SELECT *
FROM Students
ORDER BY FirstName ASC;

-- Q2. Sort students by Admission Date.
SELECT *
FROM Students
ORDER BY AdmissionDate DESC;

-- Q3. Sort payments by Amount.
SELECT *
FROM Payments
ORDER BY Amount DESC;

GO

/*=========================================================
TOPIC 7 : TOP
=========================================================*/

-- Q1. Show first 5 students.
SELECT TOP 5 *
FROM Students;

-- Q2. Show top 3 highest payments.
SELECT TOP 3 *
FROM Payments
ORDER BY Amount DESC;

GO

/*=========================================================
TOPIC 8 : BETWEEN
=========================================================*/

-- Q1. Payments between 45000 and 55000.
SELECT *
FROM Payments
WHERE Amount BETWEEN 45000 AND 55000;

-- Q2. Students born between 1999 and 2001.
SELECT *
FROM Students
WHERE DateOfBirth
BETWEEN '1999-01-01'
AND '2001-12-31';

GO

/*=========================================================
TOPIC 9 : IN
=========================================================*/

-- Q1. Students from Departments 1,2,4.
SELECT *
FROM Students
WHERE DepartmentID IN (1,2,4);

-- Q2. Payments made using Cash or UPI.
SELECT *
FROM Payments
WHERE PaymentMethod
IN ('Cash','UPI');

GO

/*=========================================================
TOPIC 10 : LIKE
=========================================================*/

-- Q1. Student name starts with A.
SELECT *
FROM Students
WHERE FirstName LIKE 'A%';

-- Q2. Student name ends with n.
SELECT *
FROM Students
WHERE FirstName LIKE '%n';

-- Q3. Student name contains 'an'.
SELECT *
FROM Students
WHERE FirstName LIKE '%an%';

-- Q4. Second letter is 'a'.
SELECT *
FROM Students
WHERE FirstName LIKE '_a%';

GO

/*=========================================================
TOPIC 11 : IS NULL
=========================================================*/

-- Q1. Students without phone numbers.
SELECT *
FROM Students
WHERE Phone IS NULL;

-- Q2. Students with phone numbers.
SELECT *
FROM Students
WHERE Phone IS NOT NULL;

GO

/*=========================================================
TOPIC 12 : Alias (AS)
=========================================================*/

-- Q1. Rename columns.
SELECT
    FirstName AS StudentName,
    Email AS StudentEmail
FROM Students;

-- Q2. Course aliases.
SELECT
    CourseName AS Subject,
    Credits AS CreditHours
FROM Courses;

GO

/*=========================================================
TOPIC 13 : Arithmetic Expressions
=========================================================*/

-- Q1. Increase payment by ₹1000.
SELECT
    Amount,
    Amount + 1000 AS UpdatedAmount
FROM Payments;

-- Q2. Add 5 bonus marks.
SELECT
    Marks,
    Marks + 5 AS UpdatedMarks
FROM Grades;

GO

/*=========================================================
TOPIC 14 : Built-in Functions
=========================================================*/

-- Q1. Convert names to uppercase.
SELECT
    UPPER(FirstName) AS UpperName
FROM Students;

-- Q2. Convert emails to lowercase.
SELECT
    LOWER(Email) AS LowerEmail
FROM Students;

-- Q3. Find length of student names.
SELECT
    FirstName,
    LEN(FirstName) AS NameLength
FROM Students;

-- Q4. Display current date and time.
SELECT GETDATE() AS CurrentDateTime;

-- Q5. Display admission year.
SELECT
    FirstName,
    YEAR(AdmissionDate) AS AdmissionYear
FROM Students;

-- Q6. Display admission month.
SELECT
    FirstName,
    MONTH(AdmissionDate) AS AdmissionMonth
FROM Students;

-- Q7. Display admission day.
SELECT
    FirstName,
    DAY(AdmissionDate) AS AdmissionDay
FROM Students;

GO