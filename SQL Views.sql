###### SQL Views ######

/* SQL View
- a virtual table whose contents are obtained from an existing table
(called base tables)
- a view into the base table 
- the view simply shows the base table data
- acts as a shortcut for writing the same select statement everytime a new request is made
- ie saves alot of time when there are multiple users
- also when you update the base table, the view also automatially updates
create or replace view view_name as 
select column_1, ... , column_N
from table_name;
OR
create view view_name as 
select column_1, ... , column_N
from table_name;
*/

select*from dept_emp;

# Thousands of entries, due to several start and end dates from employees switching teams
# Further verifying this is the case

select emp_no, from_date, to_date, count(emp_no) as Num
from dept_emp
group by emp_no
having Num > 1;

# Lets pull out a table that shows each employee once with their latest start and end date

create or replace view v_dept_enp_latest_date as 
select emp_no, max(from_date) as from_date, max(to_date) as to_date
from dept_emp
group by emp_no;

# You can see in the schemas it was saved 

/* Exercise 1
Create a view that will extract the average salary of all managers, rounded to the nearest cent
Answer should be: $66,924.27
*/

create or replace view v_manager_ave_salary as
select round(avg(salary), 2) as ave_salary 
from salaries s
where s.emp_no in (select 
dm.emp_no from dept_manager dm);

# Solution uses join instead (which makes more sense syntax wise) 

create or replace view v_manager_ave_salary as
select round(avg(salary), 2) as ave_salary 
from salaries s
join dept_manager dm on s.emp_no = dm.emp_no;


/* 
*/