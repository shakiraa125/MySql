use company;
CREATE table Department (
department_id int primary key,
department_name varchar(100) not null,
location varchar(100),
budget decimal(12,2)
);
describe Department;
show tables in company;

CREATE table Project (
project_id int primary key,
project_name varchar(100) not null,
department_id int,
foreign key(department_id) references Department(department_id)
);

describe Project;

#creating tables for employees
CREATE table Employeee(
employee_id int primary key,
e_name varchar(100) not null,
salary decimal(10,2)not null,
hire_date date not null,
job varchar(100) not null,
department_id int,
project_id int,
foreign key(department_id) references Department(department_id),
foreign key(project_id) references Project(project_id)
);

describe Employeee;
show tables in company;

# inserting records into department
insert into Department values
(1,'Engineering','info park kochi',500000.00),
(2,'Marketing','Technopark tvm',300000.00),
(3,'HR','cyberpark kozhikode',200000.00),
(4,'Finance','Smartcity Kochi',400000.00);

# inserting records into projects
INSERT INTO Project (project_id, project_name, department_id) VALUES
(1, 'Project Solar', 1),
(2, 'Project Titan', 2),
(3, 'Project Evolve', 3),
(4, 'Project Nexus', 4);

INSERT INTO Employeee (employee_id, e_name, salary, hire_date, job, department_id, project_id) VALUES
(1, 'Lakshmi Pillai', 60000.00, '2021-01-15', 'Software Engineer', 1, 1),
(2, 'Suhana', 95000.00, '2020-02-20', 'Project Manager', 2, 2),
(3, 'Risana', 45000.00, '2019-03-25', 'Recruitment Specialist', 3, 3),
(4, 'Rakeek', 105000.00, '2018-04-30', 'Finance Manager', 4, 4),
(5, 'Shakira', 50000.00, '2021-06-18', 'Software Engineer', 1, 1),
(6, 'Nafiya', 70000.00, '2019-08-12', 'Marketing Specialist', 2, 2),
(7, 'Ziyad', 85000.00, '2021-03-15', 'DevOps Engineer', 1, 1),
(8, 'Priya Varghese', 78000.00, '2019-04-10', 'Marketing Manager', 2, 2),
(9, 'Nikhil George', 55000.00, '2020-07-18', 'HR Analyst', 3, 3),
(10, 'Afsal', 120000.00, '2018-11-22', 'Chief Financial Officer', 4, 4),
(11, 'Meheza', 60000.00, '2021-09-03', 'Junior Software Engineer', 1, 1),
(12, 'Fawaz', 68000.00, '2020-05-25', 'Content Strategist', 2, 2);

select * from Department;
select * from Project;
select * from Employeee;
describe employeee;
select * from employeee;
select salary,salary*12 from employeee;
select salary from employeee where salary>50000 and salary<90000;
#BETWEEN AND NOT BETWEEN ---used when you have display the records from one range to another
#NOT BEETWEEEN-used when you want to exclude the ranges
#IN BETWEEN as well as not between start range and ending range is must
select * from employeee where salary between 50000 and 60000; #between <= & >=
select * from employeee where hire_date not between '2018-12-31' and '2021-01-01';
#display names of employee who work in either the engineering or finance departments and having a salary greater than 60000

select e_name from employeee where department_id in (1,4) and salary>60000;
#display names and jobs who have hired after january 1,2020 and are working as 'software engineering'
select e_name,job from employeee where hire_date>'2020-01-01' and job='software engineer';
#display all employees who where hired before june 15 2020 and are either software engineer or junior software engineer
select * from employeee where hire_date<'2020-06-15' and job in ('software engineer','junior software engineer');
# display id,name,project_id of employees who was either 'finance manager' or 'HR analyst' but do not work in finance department
select employee_id,e_name,project_id from employeee where job in ('finance manager','HR analyst') and department_id!=4;
#display all the details of the employeee whose annual salary is less than 66890
select *,salary*12 as annual_salary from employeee where salary*12<666890;
#display the names and departments of employees who are either 'project manager' p=or devops engineer' and where hired between january 1,2020 amd decmber 31 2021
select e_name,job from employeee where job in ('project manager','DevOps Engineer') and hire_date between '2020-01-01' and '2021-12-31';

#the like operator is used to search for a specific pattern within a column
#pattern matching operator
#1.%: represent zero or more characters
#2- _: represents a single character

#not like is to exclude the patterns

select * from employeee where e_name like 'p%';
# names ending with letter a
select * from employeee where e_name like '%a';
# names of employee whose name is not ending with 'a'
select * from employeee where e_name not like '%a'; 
#names of employees whose names start with  s and end with a
select * from employeee where e_name like 's%a';
#names of employees whose having character 'i' in thier names
select * from employeee where e_name like '%i%';
#display job of employees who are having 'i' appearing twice in names
select job,e_name from employeee where e_name like '%i%i%';
#names with 2 consecutive 'e'
select * from employeee where e_name like '%ee%';
select * from employeee where e_name like 'a%s%';

#display te names of employee who are hired in the year '2019'
select e_name from employeee where hire_date like '2019%';

#display the names of emp with 5 charcters
select e_name from employeee where e_name like '_';

#display of emp whose secnd chrcter is i
select * from employeee where e_name like '_i%';

#display employees whose job is engineer
select * from employeee where job like '%engineer';

#display employees whose last 3rd charctr 
select * from employeee where e_name like '%a__';

#display the employees whose names having vowels
select * from employeee where e_name like '%a%' or '%e%' or '%i%' or '%o%' or '%u%';

#checking null values in the table

select * from employeee WHERE e_name IS NULL;

select * from employeee where employee_id is not null;
#display the employees whose name is not null and who have a salary greater than 60000
select * from employeee where e_name is not null and salary>60000;

#display employees whose job is not null and the job title contains the word 'engineer' 

#modify the data/table/databases
#updating a column entry
#update tablename set columnname=newvalue where 
update employeee set salary=56000 where employee_id=3;
select * from employeee;

#adding new column 
alter table employeee add column gender varchar(10);
select * from employeee;
update employeee set gender='female' where employee_id in (1,2,3,5,6,8,11); 
select * from employeee;
update employeee set gender='male' where employee_id in (4,7,9,10,12);
select * from employeee;
#modifynng the column 
#syntax -- alter table tablename modify column columnname datatype constraints
alter table employeee modify column gender varchar(10) not null;
describe employeee;

#change the column name
# syntax- alter table tablename change column oldcolumn new column datatype
alter table employeee change column salary sal decimal(10,2);
select * from employeee;

#rename the table
alter table employeee rename to emp;
select * from emp;
 
#deleting row
delete from emp where employee_id=1;
select * from emp;

#deleting column
#s= alter table tablename drop columnname
alter table emp drop gender;
select * from emp;

#deleting the table
#s-drop table tablename
#drop table tablename

/*--- -- Functions
-- it is a set of instructions that are written to reduce the task
-- SQL functions can be broadly categorized into two types based on the number of rows they operate on: 
     -- single-row functions and multi-row functions.

-- Single-row functions operate on each row individually and return a single result per row. 
-- These functions are applied to each row in the result set and return a value for each row.

---Types of single-
---string functions
-- concat()- concatinate 2 or more strings
-- SUBSTRING(str, pos, len): Extracts a substring starting at position pos for len characters.
-- LENGTH(str): Returns the length of a string in bytes.

-- UPPER(str): Converts a string to uppercase.
-- LOWER(str): Converts a string to lowercase.
-- TRIM(str): Removes leading and trailing spaces from a string.
-- REPLACE:
-- reVERSE:

-- Multi-row functions, also known as aggregate functions, operate on a set of rows and return a 
-- single result for the entire set. These functions are typically used with the GROUP BY clause 
-- to group rows that share a common attribute and perform operations on these groups.

-- Types of Multi-Row Functions:

-- 1. COUNT(): Counts the number of rows in a set.

-- 2. SUM(): Calculates the sum of a numeric column.

-- 3. AVG(): Calculates the average of a numeric column.

-- 4. MAX(): Finds the maximum value in a set.

-- 5. MIN(): Finds the minimum value in a set.*/
select count(e_name) from emp;
select count(sal) from emp;
select count(*) from emp;

select count(*)as count_no_of_records from emp;
select sum(sal) from emp;
select round(avg(sal),3) from emp;
select max(sal) from emp;
select min(sal) from emp;
#multivalued function is the first argumnet after the select clause
#we cannot use multirow functions in where clause
# we cannot use any col name with multirow function in select clause

# display the no of employees having charatcer i in the second place
select count(e_name) from emp where e_name like '_i%';

#display the minimum salary given to 3 rd departmnt
select min(sal) from emp where department_id=3;

#display the no of unique salaries in the table
select count(distinct sal) from emp;
select * from emp;
 
 # display the max salary givem in job softw
 select max(sal) from emp where job in ('software engineer','HR analyst');
 
 /*group by clause
 ---used to group the records
 ---we can pass column name as argument
 ---we can write group by column along with the multirow func in select clause*/
 #in each- groupby
 #display the number of employees in each department
 select department_id,count(*) from emp group by department_id;
 
 #display no of employees as well as depts ,who are earnig more than 70000 in each dept 
select department_id,count(*) from emp where sal>70000 group by department_id; #from,where ,gropu by,select
select department_id,count(*) as no_of_emp from emp where sal>70000 group by department_id;

#display the no of employees as well as dept,who are earning sal greater than 7000 in each dept as well as project
select department_id,project_id,count(*) from emp where sal>70000 group by department_id,project_id;

#display the total salary given in each dept
select sum(sal) from emp group by department_id;

#display the no of employees having character 'a' in each job
select count(employee_id) from emp where job like '%a%' group by job;

#count the number of employees who have a salary between 50,00 and 100,000 grouped by department
select count(employee_id) from emp where sal between 50000 and 100000 group by department_id;

#find the total salary of employee who are hired after 2020 and whose name contain letter a groupby dept
select department_id,sum(sal) from emp where hire_date>2020 and e_name like '%a%' group by department_id;

#calculate the average salary and total no of employees in each dept,display both results
select department_id,round(avg(sal),2),count(*) from emp group by department_id;

#display the no of depts present in the emp table
select count(distinct department_id) from emp;

#calculate the total salry of employees working in dept 1 and 3,where the job title start with savepoint
select sum(sal) from emp where department_id in (1,3) and job like 's%';

/* HAVING CLAUSE 
--- used to filter out the groups 
---it executes group by group
---we can pass one condition or multiple condition ,multiple conditions are seperated using and ,or
---it executes only after the execution of group by clause*/

#display the no of employees and thier departments where there is atleast 3 employees in each dept
select department_id,count(*) from emp group by department_id having count(department_id)>=3;

#display the no of employees who are working as solar project and has max salary >70000
select * from project;
select count(*),max(sal) from emp where project_id=1 having max(sal)>70000;

#display the no of employees and depts if there are atleat 3 employees in each dept whose name has character a or s
select department_id,count(*) from emp where e_name like '%a%' or '%s%' group by department_id having count(department_id)>=3;

#calculate the difference between max and min salary for each department where the job title contains 'engineer'
select max(sal)-min(sal) from emp where job like '%engineer%' group by department_id;

#list the projects where the maximum salary of employees working on the project is greater than 85000 and theu total salary is lass than 250000
select project_id,max(sal),sum(sal) from emp group by project_id having max(sal)>85000 and sum(sal)<250000;

#calculate the average salary for employees hired before january 1,2020 grouped by department but exclude with ids greater than 2
select department_id,avg(sal) from emp where hire_date<'2020-01-01' and department_id<=2 group by department_id;

/* ORDER BY CLAUSE
--- used to arrange the data in ascending or descending order 
---by default arranges in ascending order
---to arrange in descending order make use of keywrd desc*/
select * from emp order by e_name; # by default asc
select * from emp order by e_name desc;
select * from emp order by e_name asc;

#display slaries of the employees in ascending order
select sal from emp order by sal ;

#display all the emp sorted by hiredate in ascending and salary in desc
select * from emp order by hire_date asc,sal desc;

update emp set hire_date='2018-04-30' where employee_id=10;
select * from emp;

#retrieve the total number of employees in each department whose salary is grater than 60000 .only include departments with more than 3 employees.sort the results by the total number of employees in descending order
select department_id,count(*) from emp where sal>60000 group by department_id having count(department_id)>=3 order by count(*) desc;

#list the departments where the sum of salaries in between 200000 and 500000 for employees who jlined before 2021 .order the departments by the sum of salaries in desc order
select department_id,sum(sal) from emp where hire_date<'2021-01-01' group by department_id having sum(sal) between 200000 and 500000 order by sum(sal) desc;

select CONCAT(e_name,job) as full_name_job from emp;
select e_name,job,CONCAT(e_name,job) as full_name_job from emp;
select CONCAT(e_name," ",job) as full_name_job from emp;

alter table emp add column gender varchar(10);
select * from emp;
update emp set gender='female' where employee_id in (1,2,3,5,6,8,11); 
select * from emp;
update emp set gender='male' where employee_id in (4,7,9,10,12);
select * from emp;

select e_name,if(gender='female',concat('ms.',e_name),concat('mr.',e_name)) as concat from emp;
select e_name,concat('employee:',e_name) as full_name from emp;

alter table emp add name_with_mr_ms varchar(100);
update emp set name_with_mr_ms=if(gender='female',concat('ms.',e_name),concat('mr.',e_name));
select * from emp;

select lower('SHAKIRA');
SELECT *,LOWER(job) as job_titile_uppercase from emp;

#3.upper(); coverts a strong to uppercase
select e_name,upper(job) as job_title_uppercase from emp;

#4.length(): returns the length of the string
select e_name,length(e_name) as name_length from emp;

#display all the employees whose name as atleast 5 charchters
select e_name,length(e_name) from emp where length(e_name)>=5;

#5.substring (colname,pos,len) :extracts a substring from a string
select SUBSTRING('hello world',2,4);
select * from emp;
SELECT e_name,substring(e_name,1,3) from emp;
 
 #6.TRIM(): Remove leading and trailing space from a string:
 select TRIM('HELLO WORLD') AS trimmed_string;
 select trim(e_name) as trimmed_name from emp;
 
# LTRIM():- Remove traiking spaces:
select ltrim('helo') as no_leading_spaces;

#RTRIM():- remove trailing spaces
select rtrim('hello world hi') as trimmed;

#7 replace(columnname,orginal_string,replacing string):-replaces occurences
select e_name,replace(job,'Manager','Leader') as new_job_title from emp;

 #8.INSTR(columnname,charector):-rewturns the position of the first occurence
 # stand for IN string
 select e_name,INSTR(e_name,'a') as position_of_a from emp;
 
#9reverse();-reversing the string
select e_name,reverse(e_name) as reversed_name from emp;

#10 LPAD():-pads a string on the left side with specified string
select e_name,lpad(e_name,15,'**') as padded_name from emp;

#11 RPAD():- pads a string on the right side with a specified string
select e_name,rpad(e_name,15,'_') as padded_name from emp;

##ote:- lpad() and rpad() adds charector to the left and right of string to reach a certain 

##Display the names of emp in uppercase if their salary is grater than 70000,orherwise display names in lowercase
select e_name,if(sal>70000,upper(e_name),lower(e_name)) from emp;

# show the details of employees whose name  contains the substring 'an' startig from the 4th charector
SELECT * from emp where substring(e_name,4,2)='an';

#display the salary of employees whose name contains 'i' starting from second position
SELECT * from emp where substring(e_name,2,1)='i';

##NUMERIC FUNCTION
#1.CEIL() or CEILING(): returns the gratest integer value grater than or equal to a number
select ceil(34.3);
select e_name,ceil(sal/1000)*1000 as rounded_up_salary from emp;
select e_name,ceil(sal/55)*2 as rounded_up_salary from emp;

#2.floor()
select floor(56.9);
select e_name,floor(sal/1000)*1000 as rounded_up_salary from emp;
select floor(56.145);
select e_name,floor(sal/55)*2 as rounded_up_salary from emp;

#3.ROUND():-rounds a number  to a specified onumber of decimal places
select round(34.65);
select e_name,round(sal/8,2) as rounded_up_salary from emp;
select round(36.67565,2);
select round(36.67565);

#4.SQRT():- Returns the sqrt of number
select sqrt(5);
select sal,sqrt(sal) from emp;

#5.POWER():-returns the value of number raised to power of another number
select power(4,3);

#6.MOD();Returns The remainder of a division operation
select mod(5,2);
select sal,mod(sal,2) from emp;

# DATE_TIME()
#1.curdate() returns current date
select curdate() as current_date_of_system;

 #2.curtime():returns the current time
 select curtime();
 
  #3.now();-current date and time
  select now() as current_date_time_of_system;
  
  #4.DATE();- extracts the date part of date or datetime expression
 # eg: 2023-08-22 14:30:00
 select e_name,date(hire_date) as hire_date_only from emp;
#5.TIME():-extracts only the part of time
select time(now());
   
#6.YEAR():Returns the year from a date.
select e_name,year(hire_date) as hire_year from emp;

#7.#6.MONTH():Returns the  of the month from a date.
select e_name,month(hire_date) as hire_month from emp;

#7.#6.MONTH():Returns the  of the day of the month from a date.
select e_name,date(hire_date) as hire_date from emp;

#8.DAYNAME:-returns day name
select dayname(now());
select e_name,dayname(hire_date) as day_name from emp;

#9.DATE_FORMAT():-formates a date according to a specified formate
select e_name,DATE_FORMAT(hire_date,'%m-%d-%y') as formated_hire_date from emp;

# add a columname colled formatted_date and update all the record,with the(month,date,year) formate
alter table emp add column formatted_date varchar(20);
set sql_safe_updates=0;
update emp set formatted_date=DATE_FORMAT(hire_date,'%M-%d-%y');
select * from emp;

#4)CONTROL FLOW FUNCTIONS
#1.IF(): evaluates an expression and returns one value if the expression is true and another value if it is false
# syntax if(exprssion,true valie,false value)
select e_name,if(sal>90000,'high','false') as salary_level from emp;

#2,CASE() :provides a way to perform conditional logic in sql queries,its similar to if but mulltyiple conditions
/*syntax: CASE
              WHEN condition1 then result 1
              when condition2 then result 2
              else result_default
			end */
select e_name,
       case
       when sal> 90000 then 'very high'
       when sal> 60000 then 'high'
       else 'low'
       end as salary_rating from emp;
       
#categorise employees based on their job titles into three categories
 #'managemnet' for project manager and finance manager
 #'technical for software engineer,and others for all other job
select job,case when job in ('project manager','finance manager') then 'management' when job='software engineer' then 'technical' else 'others' end as job_finl from emp;

#conversion functions
/* 1)CAST() AND CONVERT() EXPRESSIONSB allow you to change the dtatatype of a column in the result 
cast() IS GENERALLY USED TO CONVERT EXRESSIONS FROM ONE TYPE TO ANOTHER
COnVERT() CAN BE MORE FLEXIBLE IN SOME CASES AND IT FUNCTIONALLY SIMILAR TO CAST()*/
select cast(1235.56 as signed) as integ_val;
select cast(1235.56 as unsigned) as integ_val;
/*1) signed: converts the value to a signed integer (allowing for negative and positive)
 2) unsigned: convets the value to an unsigned integer (only positive values)*/
 select cast(1234.565 as decimal(10,2)) as decimal_value;
 select cast(1234 as decimal(10,2)) as float_value;
 select cast(true AS SIGNED) as boolean_as_integer;
select e_name,cast(sal as signed) as sal_int from emp;
select e_name,convert(hire_date,signed) as hire_date_int from emp;
select e_name,convert(sal,decimal(10,3)) as sal_dec from emp;
 #
 #display the salries of the employee which are divisible by 3
 select sal,mod(sal,3) from emp;
 #display the count of numbr of employees hired each year
select count(*),year(hire_date) from emp group by year(hire_date) ;

#LIMIT
 # display the first 5 records
 select * from emp limit 5;
 
 #display the first 7 names and jobs from table
 select e_name,job from emp limit 7;
 
 #skip the first 3 records the isplay the next 4 records
 select * from emp limit 3,4;

#display the last 3 records 
select * from emp order by employee_id desc limit 3;

/*offset 
 the ofset i sthe keyword used to skip a specified number of rows before starting to return ythe rows from the query
 it is often used together with limit to control the range of rows returned
*/
#returns 4 rows ,starting after skipping the first 2 rows
select * from emp limit 4 offset 2; 

#display the records from 3 to 8 using offset and limit
select * from emp limit 6 offset 1;

#display the first 5 employees ordred by thier salary in desc order
select * from emp order by sal desc limit 5;

-- display the first 5 employees ordered by their salary in descending order.
-- Skip the first 3 employees and display the next 5 employees ordered by hire date in ascending order.
-- Find the average salary of employees grouped by department, and display the first 3 departments with the highest average salary.
-- dislay 5 employees whose job has "Software Engineer" ordered by their salary in ascending order...
-- display the first 3 employees who were hired before 2020, have a salary greater than 60,000, and are in department 1, ordered by their hire date.
-- display the first 5 employees ordered by the length of their names (from shortest to longest).
select * from emp order by hire_date asc limit 3,5;

select department_id,avg(sal) from emp group by department_id order by avg(sal) desc limit 3;

select * from emp where job like '%software engineer' order by sal asc limit 5;

select * from emp where hire_date<'2020-01-01' and sal>60000 and department_id=1 order by hire_date limit 3; 
select * from emp order by length(e_name) asc limit 5;
 
#display only 5th reocrd
select * from emp limit 1 offset 3;

select * from emp limit 6 offset 5;

#subquery- a query within another query,nested query
#the output of outer query is input of inner query
#whenever we have unknown values
#when data is to be found another table

#display the eployees who are working in dept as that of lakshmi pillao
select * from emp where department_id=(select department_id from emp where e_name='Suhana');

#find the employees who have the same job titlle as the employee with the name 'nikil'
select * from emp where job=(select job from emp where e_name='Nikhil George');

#display all employees whose salary is higher than the vaerage salary acrross all departments
select * from emp where sal > (select avg(sal) from emp);

#find the employee whose job title contains the world 'Engineer' and who have a salary higher than average salary of all engineer..
select * from emp where job like '%Engineer' and sal > (select avg(sal) from emp);
select * from emp;

#display the names of employees who have the  same hire date as the employees with the name 'priya'
select * from emp where hire_date=(select hire_date from emp where e_name ='Afsal');
select * from emp;

#dispaly the names of the emp who arwe in the same department as the emhza and earn more than her
select e_name from emp where department_id=(select department_id from emp where e_name ='meheza') and sal>(select sal  from emp where e_name ='meheza');

#second highest salary
select max(sal) from emp where sal <(select max(sal) from emp);

#third minimum salary
select min(sal) from emp where sal >(select min(sal) from emp where sal >(select min(sal) from emp));

#third highest
select max(sal) from emp where sal <(select max(sal) from emp where sal >(select min(sal) from emp));

#third highest
select sal from emp order by sal desc limit 1 offset 3;

#third minimum salary
select sal from emp order by sal asc limit 1 offset 2;

#fourth minimum salary
select sal from emp order by sal asc limit 1 offset 3;

#find the employees whon where hired recently
select max(hire_date) from emp;
select * from emp order by hire_date desc limit 1 offset 1;

# display the all employees who  belong to the department that have fewer than 3 employees
 select * from emp where department_id in(select department_id  from emp group by department_id having count(e_name)<3);

#display the names of the employees who where hired lastr and have the highest salary
select e_name from emp where e_name=(select max(hire_date) from emp) and (select max(sal) from emp);

#find the employees who have been working in the company the longest
select * from emp order by hire_date asc limit 1 offset 1;

#display the employees with lowest salary in the 4th department
select min(sal) from emp where department_id=4;

#display the names of the employees who where hired lastr and have the highest salary
select * from emp where hire_date=(select max(hire_date) from emp) and (select max(sal) from emp);

# display the all employees who  belong to the department that have fewer than 3 employees
select * from emp where department_id in(select department_id from emp group by department_id having count(e_name)<3);

#display the names of employees who have the  same hire date as the employees with the name 'priya'
select * from emp where hire_date=(select hire_date from emp where e_name like '%Afsal');

#second highest salary
select max(sal) from emp where sal<(select max(sal) from emp);

# third highest salary
select max(sal) from emp where sal<(select max(sal) from emp where sal< (select max(sal) from emp));

#third minimus salary
select min(sal) from emp where sal>(select min(sal) from emp where sal>(select min(sal) from emp ));
 
 #dispaly the names of the emp who arwe in the same department as the emhza and earn more than her
 select * from emp where department_id=(select department_id from emp where e_name='Meheza') and sal>(select sal from emp where e_name='Meheza');

#SUB QUERY :-ANY ,ALL
#find the names and salaries of the employees who earn more than any of the department 2
select * from emp where sal > any(select sal from emp where department_id=2);

#display names and salaries of employee who are earning less than all the employe in the designation engneer
select * from emp where sal < all(select sal from emp where job like '%Engineer');

#display the employees whos salry is not eaQUALTO any saLRY IN MANAGER
select * from emp where sal != any (select sal from emp where job like '%Manager');

#case2::when the data to be found is another table
#find the employees with the lowest salry in the 'marketing' department
select * from emp where sal=(select min(sal) from emp where department_id=(select department_id from department where department_name='marketing'));
select * from department;

# names of employee who are in the finance department
select * from emp where department_id=(select department_id from department where department_name='finance');

 #display the project name where the wmployees earn more than 80000
 select project_name from project where project_id in (select project_id from emp where sal>80000);
 
 -- display the employees who work on projects with budget more than 300000
 select * from emp where department_id in (select department_id from department where budget>300000);
 
-- display the employyes whose sal is greater than average sal in the HR dept
select * from emp where sal>(select avg(sal) from emp where department_id=(select department_id from department where department_name='HR'));

-- display the employyes who are working in infopark kochi
select * from emp where department_id=(select department_id from department where location='info park kochi');
select * from project;

#-- display location of employyess whose is working in project nexus
select location from department where department_id=(select department_id from project where project_name='Project Nexus');


 
 




 