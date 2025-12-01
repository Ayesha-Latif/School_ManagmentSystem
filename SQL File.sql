CREATE DATABASE School_ManagmentSystem;

USE School_ManagmentSystem;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
USE School_ManagmentSystem;
INSERT INTO departments VALUES
(200, 'Bioinformatics'),
(201, 'Artificial Intelligence'),
(202, 'Computer Science'),
(203, 'Information and Technology'),
(204, 'Cyber Security'),
(205, 'Software Engineering');

USE School_ManagmentSystem;
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
USE School_ManagmentSystem;
INSERT INTO courses VALUES
(301, 'Introduction to Programming',200),
(302, 'Artificial Intelligence',201),
(303, 'Database Systems',202),
(304, 'Networks',204),
(305, 'Cyber Security Fundamentals', 204);

USE School_ManagmentSystem;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    contact VARCHAR(20),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
USE School_ManagmentSystem;
INSERT INTO students
(student_id, first_name, last_name, email, contact, department_id)
VALUES
(2504492, 'Ayesha ', 'Latif', '2504492@students.au.edu.pk', '03011234567', 200),
(2540987, 'Ahmed', 'Ali', '2540987@students.au.edu.pk', '03015678901', 202),
(2400876, 'Zainab', 'Hassan', '2400876@students.au.edu.pk', '03211239876', 205);

USE School_ManagmentSystem;
CREATE TABLE student_courses (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
USE School_ManagmentSystem;
INSERT INTO student_courses VALUES
(2504492, 303),
(2540987, 301),
(2400876, 302);

USE School_ManagmentSystem;
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    course_id INT,
    department_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
USE School_ManagmentSystem;
INSERT INTO teachers VALUES
(101, 'Maryam', 'Nisar', 'maryamnisar@au.edu.pk', 301, 200),
(102, 'Ayesha', 'Khan', 'ayeshas.khan@au.edu.pk', 303, 202),
(103, 'Ali', 'Raza', 'ali.raza@au.edu.pk', 304, 204);

USE School_ManagmentSystem;
CREATE TABLE teacher_courses (
    teacher_course_id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_id INT,
    course_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
USE School_ManagmentSystem;
INSERT INTO teacher_courses (teacher_id, course_id)
VALUES
(101, 301),
(102, 302),
(103, 303);

SELECT s.student_id, s.first_name, s.last_name,
       d.department_name
FROM students s
JOIN departments d ON s.department_id = d.department_id;
SELECT t.teacher_id, t.first_name, t.last_name,
       d.department_name
FROM teachers t
JOIN departments d ON t.department_id = d.department_id;
SELECT s.student_id, s.first_name, s.last_name,
       c.course_name
FROM student_courses sc
JOIN students s ON sc.student_id = s.student_id
JOIN courses c ON sc.course_id = c.course_id;
SELECT t.teacher_id, t.first_name, t.last_name,
       c.course_name
FROM teacher_courses tc
JOIN teachers t ON tc.teacher_id = t.teacher_id
JOIN courses c ON tc.course_id = c.course_id;
SELECT 
    s.student_id,
    s.first_name AS student_first,
    s.last_name AS student_last,
    d.department_name,
    c.course_name,
    t.first_name AS teacher_first,
    t.last_name AS teacher_last

FROM student_courses sc
JOIN students s ON sc.student_id = s.student_id
JOIN departments d ON s.department_id = d.department_id
JOIN courses c ON sc.course_id = c.course_id
LEFT JOIN teacher_courses tc ON c.course_id = tc.course_id
LEFT JOIN teachers t ON tc.teacher_id = t.teacher_id;



