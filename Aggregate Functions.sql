###### Aggregate Functions ######


/* Aggregate Functions aka Summarizing Functios
- they gather data from many rows in a table, 
then aggregates it into a single value 
- INPUT refers to the information contained in multiple rows
- OUTPUT is the single value provided
*/ 

/* COUNT()
- applicable to both numeric and non numeric data 
- rejects null values
- use count(distinct column_name) to find the number of times unique values are encountered in a column
- use count(* column_name) to return the number of all rows of the table inclusive of NULL values
*/ 

select*from salaries
order by salary desc
limit 10;

select count(from_date) from salaries;

# How many employee start dates are in the database? 

select count(distinct from_date) from salaries;

/* Exercise 1
How many departments are there in the employees data base? 
Ans: 9
*/ 

select count(distinct dept_no) from dept_emp;

/* SUM()
- only works with numeric data 
*/ 

# How much money did the company spend on salaries? 

select sum(salary) from salaries;

/* Exercise 2
What is the total amount of money spent on salaries for all contracts starting affter 
the first of January 1997? 
*/ 

select*from salaries limit 10;

select sum(salary) from salaries where from_date > '1997-01-01';

/* MIN () and MAX()
- pretty straightforward like the rest
- only works with numeric data
*/ 

select max(salary) from salaries;
select min(salary) from salaries;

/* Exercise 3
1. Which is the lowest employee number in the database? 
2. Which is the highest employee number in the database? 
*/ 

select*from employees limit 10;
select max(emp_no) from employees;
select min(emp_no) from employees;

/* AVG()
- extracts the average calue of all non-null values in a field
*/ 

# What is the average annual salary? 

select avg(salary) from salaries;

/* Exercise 4
What is the average salary paid to employees who started after the first of january 1997? 
*/ 

select avg(salary) from salaries where from_date > '1997-01-01';

/* Notes
- Aggregate functions are often used with the group by clause
- More sophisticated examples to come 
- You can also round the values  

*/ 

/* ROUND(function(), decmal_places)
- precedes the aggregate function
*/

select ROUND(AVG(salary), 2) from salaries;

/* Exercise 5
Round the average amount of money spent on salaries for contracts that started after Jan 1 1997
to a precision of cents
*/

select round(avg(salary), 2) from salaries where from_date > '1997-01-01';

### Set up for the next section ###
# we need to alter the departments_dup table to allow for null values

alter table departments_dup
change column dept_name dept_name varchar(40) null;
insert into departments_dup(dept_no) values ('d010'), ('d011');
alter table employees.departments_dup add column dept_manager varchar(255) null after dept_name;

# check to see if it worked
select*from departments_dup order by dept_no asc;
commit;

/* IFNULL(expression_1, espression_2)
- returns the first of the two indicated values if the data vale found in the table is not null, 
and returns the second vaues is there is a null value
- cannot have more than 2 arguments
- use coalesce
*/

select dept_no, IFNULL(dept_name, 'Department name not provided') 
from departments_dup;

# but this renames the entire column 'Department name not provided', which we don't want 

select dept_no, IFNULL(dept_name, 'Department name not provided') as dept_name
from departments_dup;

/* COALESCE()
COALESCE(expression_1, ..., expression_N) 
- it is IFNULL() with more than 2 parameters
- it will always return a single value of the ones we have within parenthesiss, 
and this value will be the first non-null value of this list, reading left to right
*/

select dept_no, COALESCE(dept_name, 'Department name not provided') as dept_name
from departments_dup;

# now try with 3 arguments 

select dept_no, 
dept_name, 
coalesce(dept_manager, dept_name, 'N/A') as dept_manager
from departments_dup
order by dept_no asc;

/* Exercise 6
Select the deparment number and mae from the departments_dup table and add a third column 
where you name the department number as 'dept_info' instead. If dept_no does not have a value,
use dept_name
*/

commit;

select dept_no, 
dept_name, 
coalesce(dept_no, dept_name) as dept_info
from departments_dup
order by dept_no asc;

/* Exercise 7
Modift te code obtained from the previous exercise as follows: 
- Apply the ifnull() function to the valyes to the first and second column so it displays N/A
whenever the deparment number has no values
- If there is no value for dept_name use 'Department name not provided'
*/

select
ifnull(dept_no, 'N/A') as dept_no, 
ifnull(dept_name, 'Department name not provided') as dept_name,
coalesce(dept_no, dept_name) as dept_info
from departments_dup
order by dept_no asc;



