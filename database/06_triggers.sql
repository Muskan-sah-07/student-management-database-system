/*
=========================================================
Student Management Database System
File: 06_triggers.sql
Description: SQL Server Triggers
Author: Muskan
=========================================================
*/

USE StudentManagementDB;
GO

/*=========================================================
STEP 1 : CREATE AUDIT TABLE
=========================================================*/

CREATE TABLE StudentAudit
(
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    ActionType VARCHAR(20),
    ActionDate DATETIME DEFAULT GETDATE()
);
GO

/*=========================================================
TRIGGER 1 : AFTER INSERT
Logs every newly inserted student.
=========================================================*/

CREATE TRIGGER TRG_Student_Insert
ON Students
AFTER INSERT
AS
BEGIN

    INSERT INTO StudentAudit
    (
        StudentID,
        FirstName,
        LastName,
        ActionType
    )

    SELECT
        StudentID,
        FirstName,
        LastName,
        'INSERT'
    FROM inserted;

END;
GO

/*=========================================================
TRIGGER 2 : AFTER UPDATE
Logs updated students.
=========================================================*/

CREATE TRIGGER TRG_Student_Update
ON Students
AFTER UPDATE
AS
BEGIN

    INSERT INTO StudentAudit
    (
        StudentID,
        FirstName,
        LastName,
        ActionType
    )

    SELECT
        StudentID,
        FirstName,
        LastName,
        'UPDATE'
    FROM inserted;

END;
GO

/*=========================================================
TRIGGER 3 : AFTER DELETE
Logs deleted students.
=========================================================*/

CREATE TRIGGER TRG_Student_Delete
ON Students
AFTER DELETE
AS
BEGIN

    INSERT INTO StudentAudit
    (
        StudentID,
        FirstName,
        LastName,
        ActionType
    )

    SELECT
        StudentID,
        FirstName,
        LastName,
        'DELETE'
    FROM deleted;

END;
GO

/*=========================================================
TRIGGER 4 : Payment Insert Trigger
=========================================================*/

CREATE TRIGGER TRG_Payment_Insert
ON Payments
AFTER INSERT
AS
BEGIN

    PRINT 'New Payment Successfully Added.';

END;
GO

/*=========================================================
TRIGGER 5 : Attendance Insert Trigger
=========================================================*/

CREATE TRIGGER TRG_Attendance_Insert
ON Attendance
AFTER INSERT
AS
BEGIN

    PRINT 'Attendance Recorded Successfully.';

END;
GO

/*=========================================================
TRIGGER 6 : Grade Update Trigger
=========================================================*/

CREATE TRIGGER TRG_Grade_Update
ON Grades
AFTER UPDATE
AS
BEGIN

    PRINT 'Student Grade Updated Successfully.';

END;
GO

/*=========================================================
TESTING THE TRIGGERS
=========================================================*/

----------------------------------------------------------
-- Test INSERT Trigger
----------------------------------------------------------

INSERT INTO Students
(
    FirstName,
    LastName,
    Gender,
    DateOfBirth,
    Email,
    Phone,
    Address,
    AdmissionDate,
    DepartmentID
)
VALUES
(
    'Test',
    'Student',
    'Male',
    '2001-05-10',
    'teststudent@gmail.com',
    '9999999999',
    'Delhi',
    GETDATE(),
    1
);
GO

----------------------------------------------------------
-- Test UPDATE Trigger
----------------------------------------------------------

UPDATE Students
SET Phone='8888888888'
WHERE Email='teststudent@gmail.com';
GO

----------------------------------------------------------
-- Test DELETE Trigger
----------------------------------------------------------

DELETE
FROM Students
WHERE Email='teststudent@gmail.com';
GO

----------------------------------------------------------
-- Check Audit Log
----------------------------------------------------------

SELECT *
FROM StudentAudit;
GO

/*=========================================================
VIEW ALL TRIGGERS
=========================================================*/

SELECT
    name AS TriggerName,
    OBJECT_NAME(parent_id) AS TableName
FROM sys.triggers;
GO

/*=========================================================
DISABLE TRIGGER (Practice)
=========================================================*/

-- DISABLE TRIGGER TRG_Student_Insert
-- ON Students;
GO

/*=========================================================
ENABLE TRIGGER (Practice)
=========================================================*/

-- ENABLE TRIGGER TRG_Student_Insert
-- ON Students;
GO

/*=========================================================
DROP TRIGGER (Practice)
=========================================================*/

-- DROP TRIGGER TRG_Student_Insert;
GO