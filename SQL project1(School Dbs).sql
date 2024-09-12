create database school;
use school;
-- Create the Students table
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    enrollment_date DATE NOT NULL
);

-- Create the Courses table
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    credits INT NOT NULL
);

-- Create the Enrollments table
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
# Inserting Records into Student
INSERT INTO Students (first_name, last_name, email, enrollment_date) VALUES
('John', 'Doe', 'john.doe@example.com', '2023-01-15'),
('Jane', 'Smith', 'jane.smith@example.com', '2023-02-10'),
('Michael', 'Johnson', 'michael.johnson@example.com', '2023-03-05'),
('Emily', 'Davis', 'emily.davis@example.com', '2023-04-20'),
('Daniel', 'Brown', 'daniel.brown@example.com', '2023-05-22'),
('Sophia', 'Wilson', 'sophia.wilson@example.com', '2023-06-30'),
('David', 'Martinez', 'david.martinez@example.com', '2023-07-12'),
('Olivia', 'Garcia', 'olivia.garcia@example.com', '2023-08-18'),
('James', 'Anderson', 'james.anderson@example.com', '2023-09-25'),
('Emma', 'Thomas', 'emma.thomas@example.com', '2023-10-10');


#inserting records into Courses
INSERT INTO Courses (course_name, course_code, credits) VALUES
('Mathematics 101', 'MATH101', 3),
('English Literature', 'ENG101', 3),
('Physics I', 'PHY101', 4),
('Chemistry Basics', 'CHEM101', 4),
('Introduction to Programming', 'CS101', 3),
('World History', 'HIST101', 3),
('Biology Fundamentals', 'BIO101', 4),
('Art Appreciation', 'ART101', 2),
('Calculus I', 'MATH102', 4),
('Economics Principles', 'ECON101', 3);
 
# Inserting into Enrollments
INSERT INTO Enrollments (student_id, course_id, enrollment_date, grade) VALUES
(1, 1, '2023-01-20', 'A'),
(1, 3, '2023-01-21', 'B'),
(2, 2, '2023-02-15', 'A'),
(2, 5, '2023-02-17', 'C'),
(3, 4, '2023-03-10', 'B'),
(4, 1, '2023-04-22', 'A'),
(4, 7, '2023-04-25', 'B'),
(5, 6, '2023-05-25', 'B'),
(6, 5, '2023-06-10', 'C'),
(6, 9, '2023-06-15', 'A'),
(7, 8, '2023-07-20', 'B'),
(8, 10, '2023-08-25', 'A'),
(9, 2, '2023-09-30', 'C'),
(9, 3, '2023-10-01', 'B'),
(10, 4, '2023-10-15', 'A');

select * from Students;

select * from Courses;

select * from Enrollments;

# Data Manipulation Operations
# Update the email address of a student in the Students table whose student_id is 3 to mike.j@example.com.
update Students set email='mike.j@example.com' where student_id =3;

#Write an SQL query to delete records from the Enrollments table where the grade is 'C'.
set sql_safe_updates=0;
delete from Enrollments where grade='C';

#Increase the credits of all courses in the Courses table by 1.
UPDATE Courses 
SET credits = credits + 1;

#Write a query to fetch all students who enrolled in the course with course_code='CS101'.
SELECT s.* 
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_code = 'CS101';

#Write a query to find the average credits of all courses in the Courses table.
SELECT AVG(credits) AS average_credits
FROM Courses;

#List the students who have a grade 'A' in any course.
SELECT DISTINCT s.*
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.grade = 'A';

# Find the courses that have more than 3 credits.
SELECT *
FROM Courses
WHERE credits > 3;

#Retrieve the names of students who have never enrolled in any course.
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

#Update the credits of the course 'World History' to 4.
UPDATE Courses
SET credits = 4
WHERE course_name = 'World History';

#Insert a new course 'Psychology Basics' with code 'PSY101' and 3 credits.
INSERT INTO Courses (course_name, course_code, credits)
VALUES ('Psychology Basics', 'PSY101', 3);

#Delete all students who have never enrolled in any course.
DELETE FROM Students
WHERE student_id NOT IN (SELECT DISTINCT student_id FROM Enrollments);

#List the students who have enrolled in 'Physics I' course.
SELECT s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Physics I';

#Change the email of 'John Doe' to 'john.new@example.com'.
UPDATE Students
SET email = 'john.new@example.com'
WHERE first_name = 'John' AND last_name = 'Doe';

#Find the total number of enrollments in each course.
SELECT c.course_name, COUNT(e.enrollment_id) AS total_enrollments
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

#*****************************************
#Data Definition Language (DDL) Operations

#Add a new column 'phone_number' to the Students table.
ALTER TABLE Students
ADD phone_number VARCHAR(15);

#Remove the 'grade' column from the Enrollments table.
ALTER TABLE Enrollments
DROP COLUMN grade;

# Rename the 'Courses' table to 'Course_List'.
RENAME TABLE Courses TO Course_List;

# Modify the 'credits' column in the Courses table to allow NULL values.
ALTER TABLE Courses
MODIFY credits INT NULL;

#Change the data type of 'email' column in Students table to TEXT.
ALTER TABLE Students
MODIFY email TEXT;

#Add a primary key constraint on the 'course_code' column in Courses table.
ALTER TABLE Courses
ADD CONSTRAINT pk_course_code PRIMARY KEY (course_code);

#Drop the 'phone_number' column from the Students table.
ALTER TABLE Students
DROP COLUMN phone_number;

# Change the name of 'Enrollments' table to 'Student_Courses'.
RENAME TABLE Enrollments TO Student_Courses;

#Create an index on the 'course_name' column in the Courses table.
CREATE INDEX idx_course_name
ON Courses(course_name);

#Clauses Operations
#******************************
#Write a query to get the details of students who have enrolled in more than 2 courses.
SELECT s.student_id, s.first_name, s.last_name, COUNT(e.course_id) AS number_of_courses
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING COUNT(e.course_id) > 2;

#Retrieve all courses that have 4 or more credits, sorted by course_name.
SELECT *
FROM Courses
WHERE credits >= 4
ORDER BY course_name;

#Fetch all students who have enrolled in 'Mathematics 101' but have a grade other than 'A'.
SELECT s.*
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Mathematics';
select * from Students;
select * from Courses;
select * from Enrollments;


 #List all students who have enrolled in the course 'Mathematics 101' or 'English Literature'.
 SELECT DISTINCT s.*
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name IN ('Mathematics 101', 'English Literature');

#Find courses with a name that starts with 'Intro'.
SELECT *
FROM Courses
WHERE course_name LIKE 'Intro%';

#Retrieve students who have a last name that contains 'Smith'.
SELECT *
FROM Students
WHERE last_name LIKE '%Smith%';

#Show all students who have enrolled in more than one course, ordered by their last name.
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING COUNT(e.course_id) > 1
ORDER BY s.last_name;

#Get the course names and credits for courses that have 4 credits, sorted by course_name.
SELECT course_name, credits
FROM Courses
WHERE credits = 4
ORDER BY course_name;

#List all students with their enrollment dates in the 'Introduction to Programming' course.
SELECT s.first_name, s.last_name, e.enrollment_date
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Introduction to Programming';

 #Find the total number of students enrolled in the 'Physics I' course.
 SELECT COUNT(e.student_id) AS total_students
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Physics I';

# Retrieve courses with credits less than or equal to 3, sorted by credits in descending order.
SELECT *
FROM Courses
WHERE credits <= 3
ORDER BY credits DESC;

#Find students who have been enrolled in courses since 2023, excluding those who have a grade of 'B'.
SELECT DISTINCT s.*
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_date >= '2023-01-01' AND e.grade != 'B';

#Join Operations
#************************
#Find all courses along with the names of students who have enrolled in them.
SELECT c.course_name, s.first_name, s.last_name
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Students s ON e.student_id = s.student_id;

#List all courses that do not have any students enrolled.
SELECT c.course_name
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
WHERE e.course_id IS NULL;

#Retrieve the details of students who are enrolled in 'Introduction to Programming'.
SELECT s.*
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Introduction to Programming';

# Get a list of all students and their corresponding grades in 'Physics I'.
SELECT s.first_name, s.last_name, e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Physics I';

#Find the names of students who are enrolled in both 'Mathematics 101' and 'Physics I'
SELECT s.first_name, s.last_name
FROM Students s
JOIN Enrollments e1 ON s.student_id = e1.student_id
JOIN Courses c1 ON e1.course_id = c1.course_id
JOIN Enrollments e2 ON s.student_id = e2.student_id
JOIN Courses c2 ON e2.course_id = c2.course_id
WHERE c1.course_name = 'Mathematics 101' AND c2.course_name = 'Physics I';

# Show the names of all courses along with the count of students enrolled in each course.
SELECT c.course_name, COUNT(e.student_id) AS num_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

#List all students who have enrolled in 'Chemistry Basics' after '2023-03-01'
SELECT s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Chemistry Basics' AND e.enrollment_date > '2023-03-01';

#Find the students who have enrolled in any course with 4 credits.
SELECT DISTINCT s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.credits = 4;

#Subqueries Operations
#**************************
#Find the names of students who are enrolled in the course with the highest number of credits.
SELECT s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.course_id = (
    SELECT course_id
    FROM Courses
    ORDER BY credits DESC
    LIMIT 1
);

# Retrieve the details of students who are enrolled in any course that starts with 'Math'.
SELECT *
FROM Students
WHERE student_id IN (
    SELECT e.student_id
    FROM Enrollments e
    JOIN Courses c ON e.course_id = c.course_id
    WHERE c.course_name LIKE 'Math%'
);

#Find the course name with the least number of enrollments.
SELECT course_name
FROM Courses
WHERE course_id = (
    SELECT course_id
    FROM Enrollments
    GROUP BY course_id
    ORDER BY COUNT(student_id) ASC
    LIMIT 1
);

#Get the details of courses that no students are enrolled in.
SELECT *
FROM Courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id
    FROM Enrollments
);

#List the names of students who have received a grade higher than any other student in 'Calculus I'.
SELECT first_name, last_name
FROM Students
WHERE student_id IN (
    SELECT student_id
    FROM Enrollments
    WHERE course_id = (
        SELECT course_id
        FROM Courses
        WHERE course_name = 'Calculus I'
    ) AND grade < (
        SELECT MIN(grade)
        FROM Enrollments
        WHERE course_id = (
            SELECT course_id
            FROM Courses
            WHERE course_name = 'Calculus I'
        )
    )
);

#Find the email addresses of students enrolled in courses with more than 4 credits.
SELECT email
FROM Students
WHERE student_id IN (
    SELECT e.student_id
    FROM Enrollments e
    JOIN Courses c ON e.course_id = c.course_id
    WHERE c.credits > 4
);
#Retrieve the details of the course(s) with the same number of credits as 'Physics I'.
SELECT *
FROM Courses
WHERE credits = (
    SELECT credits
    FROM Courses
    WHERE course_name = 'Physics I'
);

#Get the names of students who have not enrolled in any course with the course code 'ENG101'.
SELECT first_name, last_name
FROM Students
WHERE student_id NOT IN (
    SELECT e.student_id
    FROM Enrollments e
    JOIN Courses c ON e.course_id = c.course_id
    WHERE c.course_code = 'ENG101'
);

#Find courses that have the same number of students enrolled as 'Mathematics 101'.
SELECT course_name
FROM Courses
WHERE course_id IN (
    SELECT course_id
    FROM Enrollments
    GROUP BY course_id
    HAVING COUNT(student_id) = (
        SELECT COUNT(student_id)
        FROM Enrollments
        WHERE course_id = (
            SELECT course_id
            FROM Courses
            WHERE course_name = 'Mathematics 101'
        )
    )
);

#List the details of students who enrolled on the earliest enrollment date in the Enrollments table.
SELECT *
FROM Students
WHERE student_id IN (
    SELECT student_id
    FROM Enrollments
    WHERE enrollment_date = (
        SELECT MIN(enrollment_date)
        FROM Enrollments
    )
);



















