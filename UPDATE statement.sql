###### UPDATE Statements ######

/* UPDATE 
Used to update the values of existing record in a table 
update table_name 
set column_i = value_i, ... , column_N = volue_N
where conditions;
# the where clause is crucial
# you don't have to update every record in the table's row
*/

use employees;

update employees
set 
first_name = 'Stella',
last_name = 'Parkinson',
birth_date = '1990-12-31',
gender = 'F'
where
emp_no = 999901;

# check to make sure it worked

select*from employees where emp_no = 999901;

## Applying the commit command

select*from departments_dup order by dept_no;

commit;

update departments_dup
set 
dept_no = 'd011',
dept_name = 'Quality Control';

# doesn't work since I am in safe mode and there are no restrictions (ie., doesn't use where clause)
# went into preferences and removed this 
# still didn't work ... anyways this destroys the table and use rollback

rollback;
commit;

/* Exercise 1
Change the "Business Analysis" department name to "Data Analysis"
*/ 

update departments
set dept_name = 'Data Analysis'
where dept_name = 'Business Analysis';

# check to see if it worked
 select*from departments order by dept_name;
 
 # slightly incorrect, the answer key says where dept_no = 'd010'; which is the foreign key 
