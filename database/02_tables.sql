/*
=========================================================
Student Management Database System
File: 02_tables.sql
Description: Creates all tables for the database.
Author: Muskan
=========================================================
*/

USE StudentManagementDB;
GO

-- =========================================================
-- Table: Departments
-- =========================================================
CREATE TABLE Departments
(
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    DepartmentCode VARCHAR(10) NOT NULL
);
GO

-- =========================================================
-- Table: Teachers
-- =========================================================
CREATE TABLE Teachers
(
    TeacherID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    DepartmentID INT NOT NULL
);
GO

-- =========================================================
-- Table: Students
-- =========================================================
CREATE TABLE Students
(
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    AdmissionDate DATE NOT NULL,
    DepartmentID INT NOT NULL
);
GO

-- =========================================================
-- Table: Courses
-- =========================================================
CREATE TABLE Courses
(
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
    Duration VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    TeacherID INT NOT NULL
);
GO

-- =========================================================
-- Table: Enrollments
-- =========================================================
CREATE TABLE Enrollments
(
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL
);
GO

-- =========================================================
-- Table: Attendance
-- =========================================================
CREATE TABLE Attendance
(
    AttendanceID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    AttendanceDate DATE NOT NULL,
    Status VARCHAR(20) NOT NULL
);
GO

-- =========================================================
-- Table: Assignments
-- =========================================================
CREATE TABLE Assignments
(
    AssignmentID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT NOT NULL,
    Title VARCHAR(200) NOT NULL,
    DueDate DATE NOT NULL
);
GO

-- =========================================================
-- Table: Grades
-- =========================================================
CREATE TABLE Grades
(
    GradeID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    AssignmentID INT NOT NULL,
    Marks DECIMAL(5,2) NOT NULL
);
GO

-- =========================================================
-- Table: Payments
-- =========================================================
CREATE TABLE Payments
(
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL
);
GO
