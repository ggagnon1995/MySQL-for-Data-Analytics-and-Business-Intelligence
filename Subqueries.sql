###### Subqueries ######

/* SQL Subqueries
- aka inner queries asa nested queries
- are apart of another query 
- usually employed in the where clause of a select statements
outer query(inner query) 
1. SQL runs the inner query
2. Then it uses the returned output to run the outer query
- it can return a single value, a single row, a single column, or an entire table
*/

select*from dept_manager;

# Select the first and last name from the 'Employees' table for the same
# Employee numbers that can be found in the managers table 

select e.first_name, e.last_name, e.emp_no
from employees e 
where e.emp_no in (select 
dm.emp_no from dept_manager dm);

# 24 records, so 24 people are in the managers database 


/* Exercise 1 
Extract the information about all department managers who were hired between 
the 1st of january 1990 and 1st of january 1995
*/

select*from employees;
select*from dept_manager;

select e.first_name, e.last_name 
from employees e
where e.emp_no in (select dm.emp_no from dept_manager dm
where from_date >= '1990-01-01' and from_date <= '1995-01-01');

# Answer is as follows

select e.first_name, e.last_name, dm.* 
from dept_manager dm
join employees e on e.emp_no = dm.emp_no
where e.hire_date between '1990-01-01' and '1995-01-01';

# My output gave me the names of the managers who became managers between that time frame
# But I still don't like the output the answer gives, I would like to see names instead 

select e.first_name, e.last_name 
from employees e
where e.emp_no in (select dm.emp_no from dept_manager dm
where e.hire_date between '1990-01-01' and'1995-01-01');

# Much better!

/* Using EXISTS and NOT EXISTS inside WHERE
EXISTS
- checks whether certain row values are found within a subquery
- conducted row by row
- returns a Boolean value (True or False)
- If true, the value is also returned 
Note: IN searches for values and doesn't test them 
*/

select e.first_name, e.last_name
from employees e 
where exists (select*from dept_manager dm where dm.emp_no = e.emp_no);

/* Exercise 2
Select the entire information for all employees whose job title is "Assistant Engineer"
*/

select*from employees;

select*from employees e
where exists (select*from titles t where t.emp_no = e.emp_no and t.title = 'Assistant Engineer');

/* Subqueries nested in SELECT and FROM 

*/

# Assign employee number 110022 as a manager to all employees from 10001 to 10020, 
# and employee number 110039 as a manager to all employees from 10021 to 10040
# there are two subsets of employees (10001 - 10020 and 10021 - 10040) we can connect with union

# Subset A 

select A.*
from
(select e.emp_no as employee_ID, 
min(de.dept_no) as department_code,
(select emp_no from dept_manager where emp_no = 110022) as manager_ID
from employees e
join dept_emp de on e.emp_no = de.emp_no 
where e.emp_no <= 10020
group by e.emp_no 
order by e.emp_no) as A;

# Subset B

select B.*
from
(select e.emp_no as employee_ID, 
min(de.dept_no) as department_code,
(select emp_no from dept_manager where emp_no = 110039) as manager_ID
from employees e
join dept_emp de on e.emp_no = de.emp_no 
where e.emp_no between 10021 and 10040
group by e.emp_no 
order by e.emp_no) as B;

# Now we can join them 

select A.*
from
(select e.emp_no as employee_ID, 
min(de.dept_no) as department_code,
(select emp_no from dept_manager where emp_no = 110022) as manager_ID
from employees e
join dept_emp de on e.emp_no = de.emp_no 
where e.emp_no <= 10020
group by e.emp_no 
order by e.emp_no) as A

union select B.*
from
(select e.emp_no as employee_ID, 
min(de.dept_no) as department_code,
(select emp_no from dept_manager where emp_no = 110039) as manager_ID
from employees e
join dept_emp de on e.emp_no = de.emp_no 
where e.emp_no between 10021 and 10040
group by e.emp_no 
order by e.emp_no) as B;


/* Exercise 3: Part 1
Starting your code with drop table, create a table called emp_manager
emp_no integer of 11 and not null
dept_no char of 4 and null 
manager_no integer of 11 and not null 
*/


drop table if exists emp_manager;
create table emp_manager (
emp_no int(11) not null, 
dept_no char(4) null, 
manager_no int(11) not null);

select*from emp_manager;

/* Exercise 3: Part 2
Fill emp_manager with data about employees, the number of department they are in, and their managers
Skeleton: 
Insert into emp_manager select U.* from 
A union B union C union D as U;
A and B are the same as before, 
Use the same structure for C where 110039 manages 110022
Use the same structure for D where 110022 manages 110039
Output should have 42 rows 
*/

insert into emp_manager select U.* from 

(((select A.*
from
(select e.emp_no, 
min(de.dept_no),
(select emp_no from dept_manager where emp_no = 110022) as manager_no
from employees e
join dept_emp de on e.emp_no = de.emp_no 
where e.emp_no <= 10020
group by e.emp_no 
order by e.emp_no) as A

union select B.*
from
(select e.emp_no, 
min(de.dept_no),
(select emp_no from dept_manager where emp_no = 110039) as manager_no
from employees e
join dept_emp de on e.emp_no = de.emp_no 
where e.emp_no between 10021 and 10040
group by e.emp_no 
order by e.emp_no) as B)

union select C.*
from
(select e.emp_no, 
min(de.dept_no),
(select emp_no from dept_manager where emp_no = 110039) as manager_no
from employees e
join dept_emp de on e.emp_no = de.emp_no 
where e.emp_no = 110022
group by e.emp_no 
order by e.emp_no) as C)

union select D.*
from
(select e.emp_no, 
min(de.dept_no),
(select emp_no from dept_manager where emp_no = 110022) as manager_no
from employees e
join dept_emp de on e.emp_no = de.emp_no 
where e.emp_no = 110039
group by e.emp_no 
order by e.emp_no) as D)
as U;

select*from emp_manager;

# Success!

/* Self Join
- applied when a table must join itself
- if you'd like to combine certain rows of a table with other rows of the same table
- it is appropriate to use when a column in a table is references in the same table
- use two virtual tables and alias names for them
*/

# from the emp_manager table, extract the record data only of those employees who are managers as well

select*from emp_manager order by emp_manager.emp_no;

select e1.* 
from emp_manager e1
join emp_manager e2 
on e1.emp_no = e2.manager_no;

# Doesn't give us what we want, but we can use the distinct clause

select distinct e1.* 
from emp_manager e1
join emp_manager e2 
on e1.emp_no = e2.manager_no;

# A more sophisticated way 

select e1.* 
from emp_manager e1
join emp_manager e2 
on e1.emp_no = e2.manager_no
where e2.emp_no in (
select manager_no from emp_manager);

