/*
=========================================================
Student Management Database System
File: 03_constraints.sql
Description: Adds constraints to all tables.
Author: Muskan
=========================================================
*/

USE StudentManagementDB;
GO

---------------------------------------------------------
-- UNIQUE Constraints
---------------------------------------------------------

ALTER TABLE Departments
ADD CONSTRAINT UQ_Departments_DepartmentCode
UNIQUE (DepartmentCode);
GO

ALTER TABLE Teachers
ADD CONSTRAINT UQ_Teachers_Email
UNIQUE (Email);
GO

ALTER TABLE Students
ADD CONSTRAINT UQ_Students_Email
UNIQUE (Email);
GO

---------------------------------------------------------
-- CHECK Constraints
---------------------------------------------------------

ALTER TABLE Students
ADD CONSTRAINT CHK_Students_Gender
CHECK (Gender IN ('Male', 'Female', 'Other'));
GO

ALTER TABLE Courses
ADD CONSTRAINT CHK_Courses_Credits
CHECK (Credits > 0);
GO

ALTER TABLE Grades
ADD CONSTRAINT CHK_Grades_Marks
CHECK (Marks >= 0 AND Marks <= 100);
GO

ALTER TABLE Payments
ADD CONSTRAINT CHK_Payments_Amount
CHECK (Amount >= 0);
GO

ALTER TABLE Attendance
ADD CONSTRAINT CHK_Attendance_Status
CHECK (Status IN ('Present', 'Absent', 'Late'));
GO

---------------------------------------------------------
-- DEFAULT Constraints
---------------------------------------------------------

ALTER TABLE Attendance
ADD CONSTRAINT DF_Attendance_Status
DEFAULT 'Present' FOR Status;
GO

ALTER TABLE Enrollments
ADD CONSTRAINT DF_Enrollment_Date
DEFAULT GETDATE() FOR EnrollmentDate;
GO

ALTER TABLE Payments
ADD CONSTRAINT DF_Payment_Date
DEFAULT GETDATE() FOR PaymentDate;
GO

---------------------------------------------------------
-- FOREIGN KEY Constraints
---------------------------------------------------------

ALTER TABLE Teachers
ADD CONSTRAINT FK_Teachers_Departments
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID);
GO

ALTER TABLE Students
ADD CONSTRAINT FK_Students_Departments
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID);
GO

ALTER TABLE Courses
ADD CONSTRAINT FK_Courses_Departments
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID);
GO

ALTER TABLE Courses
ADD CONSTRAINT FK_Courses_Teachers
FOREIGN KEY (TeacherID)
REFERENCES Teachers(TeacherID);
GO

ALTER TABLE Enrollments
ADD CONSTRAINT FK_Enrollment_Students
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID);
GO

ALTER TABLE Enrollments
ADD CONSTRAINT FK_Enrollment_Courses
FOREIGN KEY (CourseID)
REFERENCES Courses(CourseID);
GO

ALTER TABLE Attendance
ADD CONSTRAINT FK_Attendance_Students
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID);
GO

ALTER TABLE Attendance
ADD CONSTRAINT FK_Attendance_Courses
FOREIGN KEY (CourseID)
REFERENCES Courses(CourseID);
GO

ALTER TABLE Assignments
ADD CONSTRAINT FK_Assignments_Courses
FOREIGN KEY (CourseID)
REFERENCES Courses(CourseID);
GO

ALTER TABLE Grades
ADD CONSTRAINT FK_Grades_Students
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID);
GO

ALTER TABLE Grades
ADD CONSTRAINT FK_Grades_Assignments
FOREIGN KEY (AssignmentID)
REFERENCES Assignments(AssignmentID);
GO

ALTER TABLE Payments
ADD CONSTRAINT FK_Payments_Students
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID);
GO