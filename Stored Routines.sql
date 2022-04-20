###### Stored Routines ######

use employees;

/* Stored Procedures
- we don't use ; to end a stored query 
- use delimmiter // to start using // to end a query
drop procedure if exists procedure name;
delimiter //
create procedure procedure_name(parameter_1, parameter_2) 
begin 
query; 
end //
delimiter ; 
- parameters represent certain values that the procedure will use to
complete the calculation it is supposed to executre
- procedures don't always need parameters
*/

# A non parametric procedure

drop procedure if exists select_employees; 

DELIMITER //

create procedure select_employees()
begin 
select*from employees limit 1000;
end // 

DELIMITER ; 

# To run the procedure "call database_name.procedure_name();"

call employees.select_employees();

# Since we already executed "use employees;" we can use the following shortcut

call select_employees();

/* Exercise 1
Create a procedure that will provide the average salary of all employees
*/

drop procedure if exists ave_salary; 

DELIMITER //

create procedure ave_salary()
begin 
select round(avg(salary),2) from salaries;
end // 

DELIMITER ; 

call ave_salary();

# Stored procedures with an input parameter

drop procedure if exists emp_salary; 

DELIMITER //

create procedure emp_salary(in p_emp_no integer)
begin 
select e.first_name, e.last_name, s.salary, s.from_date, s.to_date
from employees e
join salaries s on e.emp_no = s.emp_no 
where e.emp_no = p_emp_no;
end // 

DELIMITER ; 

# Before you call, make sure you know which employee number you want to put in parenthesis

call emp_salary(11300);

# Procedures with one input parameter can be used with aggregate functions as well 
# Find this employees average salary 

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

drop procedure if exists emp_ave_salary; 

DELIMITER //

create procedure emp_ave_salary(in p_emp_no integer)
begin 
select e.first_name, e.last_name, round(avg(s.salary),2)
from employees e
join salaries s on e.emp_no = s.emp_no 
where e.emp_no = p_emp_no;
end // 

DELIMITER ; 

call emp_ave_salary(11300);

# Stored procedures with an output parameter

drop procedure if exists emp_ave_salary_out; 

DELIMITER //
create procedure emp_ave_salary_out(in p_emp_no integer, out p_ave_salary decimal(10,2))
begin 
select avg(s.salary)
into p_ave_salary
from employees e
join salaries s on e.emp_no = s.emp_no 
where e.emp_no = p_emp_no;
end // 

DELIMITER ; 

# To call it, use the lightening icon 

set @p_ave_salary = 0;
call employees.emp_ave_salary_out(11300, @p_ave_salary);
select @p_ave_salary;

/* Exercise 2
Create a procedure called emp_info that uses as parameters the first name 
and the last name of the individual, and returns their employee number
*/

drop procedure if exists emp_info; 

DELIMITER //
create procedure emp_info(in p_first_name varchar(14), in p_last_name varchar(16), out p_emp_no integer)
begin 
select e.first_name, e.last_name
into p_emp_no
from employees e
where e.emp_no = p_emp_no 
and e.first_name = p_first_name
and e.last_name = p_last_name;
end // 

DELIMITER ;

# Success! Only difference is solution uses varchar(255) which doesn't match what the table says


/* Using SQL variables
- once the structure has been solidified, then it will be applied to the database.
The input values you insert is typically referred to as the 'argument' while the
output value is stored in a 'variable'.
1) create the variable (usually # = 0 for simplicity)
set @variable_name = #
2) extract a value that will be assigned to the newly created variable
3) ask SQL to display the output of the procedure
*/

#1) 
set @v_ave_salary = 0; 

#2)
call employees.emp_ave_salary_out(11300, @v_ave_salary);

#3)
select @v_ave_salary;

/* Exercise 3 
Create a variable called v_emp_no where you will store the output from the last exercise
Call the same procedure using Aruna Journel
*/

set @v_emp_no = 0; 
call emp_info('Aruna', 'Journel', @v_emp_no);
select @v_emp_no;

# My solution is correct but it doesn't work... 

/* User-Defined Functions or Stored Routines
- returns a specific value
delimiter //  
create function function_name (parameter data_type) returns data_type
declare variable_name data_type 
begin 
select ... 
return variable name 
end //
delimiter ; 
- you cannot call a function, you have to select it 
*/

delimiter // 
create function f_emp_avg_salary (p_emp_no integer) returns decimal(10,2)
begin 
declare v_avg_salary decimal(10,2); 
select avg(s.salary) 
into v_avg_salary from employees e 
join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
return v_avg_salary;
end // 
delimiter ; 

# Generates error code 1418 due to the version of SQL being used 
# Add one of the following: DETERMINISTIC, NO SQL, READS SQL DATA
# Add one or more of hese after the data return values 
# Don't separate by commas if using several 

delimiter // 
create function f_emp_avg_salary (p_emp_no integer) returns decimal(10,2)
deterministic
begin 
declare v_avg_salary decimal(10,2); 
select avg(s.salary) 
into v_avg_salary from employees e 
join salaries s on e.emp_no = s.emp_no
where e.emp_no = p_emp_no;
return v_avg_salary;
end // 
delimiter ; 

select f_emp_avg_salary(11300);


/* Exercise 4
Create a function called emp_info that takes for parameters the first and last name of an employee,
and returns the salary from the newest contract of that employee
*/

drop function if exists f_emp_info;
delimiter // 
create function f_emp_info (f_first_name varchar(255), f_last_name varchar(255)) returns decimal(10,2)
deterministic
begin  
declare v_max_from_date date;
declare v_last_salary decimal(10,2);
select max(from_date) into v_max_from_date 
from employees e join salaries s on e.emp_no = s.emp_no
where e.first_name = f_first_name
and e.last_name = f_last_name;
select s.salary 
into v_last_salary from employees e
join salaries s on e.emp_no = s.emp_no 
where e.first_name = f_first_name
and e.last_name = f_last_name
and s.from_date = v_max_from_date;
return v_last_salary;
end // 
delimiter ; 

select f_emp_info('Aruna', 'Journel');

/* Other notes
- if you need to obtain more than one value as a result of a calculation, use a procedure
- if you need just one value returned, use a function 
*/
