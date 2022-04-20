# Loading the employees database 
# From GitHub download from this link https://www.dropbox.com/s/znmjrtlae6vt4zi/employees.sql?dl=0
# Open as you would open a script file
# Run the script before using it 

###### SELECT Statement ######
# Allows you to extract a portion of the data set 

-- select column1, column2, columnN from tablename;

SELECT 
    first_name, last_name
FROM
    employees;

SELECT 
    *
FROM
    employees;

/* Exercise 1
a. Select the information from the “dept_no” column of the “departments” table.
b. Select all data from the “departments” table. */

# a 
SELECT 
    dept_no
FROM
    departments;

# b 
SELECT 
    *
FROM
    departments;

## WHERE clause ##
# to specify what part of the data we want to retrieve from the database 

-- select column1 from tablename where condition 
# the condition can be a mathematical statement, for example

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis';
    
/* Exercise 2
Select all people from the “employees” table whose first name is “Elvis”. */

select*from employees where first_name = 'Elvis';

/* Operators that can be used with the WHERE clause
- AND
- OR
- IN
- NOT IN
- LIKE
- NOT LIKE
- BETWEEN ... AND
- EXISTS
- NOT EXISTS
- IS NULL
- IS NOT NULL 
- other comparison operators exist
*/

## AND operator ##

-- WHERE condition1 AND condition2

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis' AND gender = 'M';

/* Exercise 3
Retrieve a list with all female employees whose first name is Kellie.
*/ 

select*from employees where first_name = 'Kellie' and gender = 'F';

## OR operator ##

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis'
        OR first_name = 'Elvis';

# Order of operators -> SQL recognizes AND before OR 
# use parenthesis 

SELECT
    *
FROM
    employees
WHERE
    gender = 'F' AND (first_name = 'Kellie' OR first_name = 'Aruna');
    
## IN or NOT IN clauses ##

/* Exercise 4
Use the IN operator to select all individuals from the “employees” table, 
whose first name is either “Denis”, or “Elvis”.
*/ 

SELECT 
    *
FROM
    employees
WHERE
    first_name IN ('Denis' , 'Elvis');

/* Exercise 5
Extract all records from the ‘employees’ table, 
aside from those with employees named John, Mark, or Jacob.
*/ 

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('John' , 'Mark', 'Jacob');

## LIKE or NOT LIKE clause
# Looking for a pattern, or sequence of characters
 
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Ar%');
# Retrieves first names that begin with Ar

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%Ar%');
# Retrieves first names that contain Ar

/* Exercise 6
Working with the “employees” table, use the LIKE operator to select the data about all individuals, 
whose first name starts with “Mark”; 
specify that the name can be succeeded by any sequence of characters.
Retrieve a list with all employees who have been hired in the year 2000.
Retrieve a list with all employees whose employee number is written with 5 characters, and starts with “1000”. 
*/ 

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mark%');
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('%2000%');
    
# this one doesn't work but it is the solution
SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');
    
# * delivers a list of all columns, or can be used to count all rows

## BETWEEN and AND clause 

SELECT 
    *
FROM
    employees
WHERE
    hire_date BETWEEN '1990-01-01' AND '2001-01-01';

/* Exercise 7
Select all the information from the “salaries” table regarding contracts from 66,000 to 70,000 dollars per year.
Retrieve a list with all individuals whose employee number is not between ‘10004’ and ‘10012’.
Select the names of all departments with numbers between ‘d003’ and ‘d006’.
*/ 

SELECT
    *
FROM
    salaries;
    
SELECT
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;
    
SELECT
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN '10004' AND '10012';

   

SELECT
    dept_name
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';

# IS NOT NULL and IS NULL operators 
# select column1, column2, columnN
# from table_name
# where column_name IS NOT NULL

/* Exercise 8
Select the names of all departments whose department number value is not null.
*/ 

SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no IS NOT NULL;

## Other comparison operators use =. <, >, <=, >=, 
# not equal != and <>

/* Exercise 9
Retrieve a list with data about all female employees who were hired in the year 2000 or after.
Hint: If you solve the task correctly, SQL should return 7 rows.
Extract a list with all employees’ salaries higher than $150,000 per annum.
*/ 

SELECT
    *
FROM
    employees
WHERE
    hire_date >= '2000-01-01'
        AND gender = 'F';
        
SELECT
    *
FROM
    salaries
WHERE
    salary > 150000;


## SELECT DISTINCT clause
# If you want the select statement to only retrieve distinct values (no repeats)


/* Exercise 10
Obtain a list with all different “hire dates” from the “employees” table.
Expand this list and click on “Limit to 1000 rows”. 
This way you will set the limit of output rows displayed back to the default of 1000.
In the next lecture, we will show you how to manipulate the limit rows count.
*/ 
select distinct hire_date from employees;

## Aggregate functions min(), max(), count(), avg(), sum()

/* Exercise 11
How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?
How many managers do we have in the “employees” database? Use the star symbol (*) in your code to solve this exercise.
*/ 

SELECT
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000;

#Ans: 32
    
SELECT
    COUNT(*)
FROM
    dept_manager;
    
#Ans: 24

## ORDER BY function

/* Exercise 12
Select all data from the “employees” table, ordering it by “hire date” in descending order.
*/ 

SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

## GROUP BY function *** Very important!

## Using Aliasis (AS) used to rename a selection from your query 

/* Exercise 13
Write a query that obtains two columns. The first column must contain annual salaries higher than 80,000 dollars. 
The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary. 
Lastly, sort the output by the first column.
*/ 

SELECT
  salary, COUNT(emp_no) AS emps_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;

## HAVING clause, usually used with GROUP BY 
# Needs to be in between the GROUP BY and ORDER BY clauses 

/* Exercise 14
Select all employees whose average salary is higher than $120,000 per annum.
Hint: You should obtain 101 records.
Compare the output you obtained with the output of the following two queries:

SELECT
    *, AVG(salary)
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY emp_no;

SELECT
    *, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;
*/ 

SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;

/* Note on WHERE vs HAVING
When using WHERE instead of HAVING, the output is larger because in the output we include 
individual contracts higher than $120,000 per year. The output does not contain average salary values.
Finally, using the star symbol instead of “emp_no” extracts a list that contains 
all columns from the “salaries” table.

Rule: use GROUP BY and HAVING with aggregate functions
Rule: use WHERE for general conditions
*/


/* Exercise 15
Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000.
Hint: To solve this exercise, use the “dept_emp” table.
*/ 

SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

## LIMIT clause 

/* Exercise 16
Select the first 100 rows from the ‘dept_emp’ table. 
*/ 

SELECT 
    *
FROM
    dept_emp
LIMIT 100;

