# Database Design

## Project Overview

The Student Management Database System is a relational database designed to manage students, teachers, courses, departments, enrollments, and attendance records.

The database was designed using SQL Server with primary keys, foreign keys, unique constraints, indexes, views, triggers, and relational queries.

## Database Tables

### Departments
Stores department information.

### Teachers
Stores teacher information and their associated departments.

### Students
Stores student information and their associated department.

### Courses
Stores course information, including the department and teacher responsible for the course.

### Enrollments
Stores the relationship between students and the courses they are enrolled in.

### Attendance
Stores student attendance records for courses.

## Relationships

- A department can have multiple teachers.
- A department can offer multiple courses.
- A department can have multiple students.
- A teacher can teach multiple courses.
- A student can enroll in multiple courses.
- A course can have multiple enrolled students.
- Attendance records are associated with students and courses.

## Database Design Principles

The database uses relational database principles to reduce data duplication and maintain data integrity.

Primary keys uniquely identify records, while foreign keys maintain relationships between related tables.