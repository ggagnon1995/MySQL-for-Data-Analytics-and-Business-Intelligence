###### DELETE Statement ######

use employees;

# apply commit first before applying a delete statement incase you need to rollback
commit; 

# pull out information on the employee
select*from employees where emp_no = 999903; 
select*from titles where emp_no = 999903;

delete from employees where emp_no = 999903;

# check to see if it worked
select*from employees where emp_no = 999903;

# can we see if this is still in the titles table too? 
select*from titles where emp_no = 999903;

# everthing is deleted because of the foreign key constraint! 

/* ON DELETE CASCADE
if a specific value from the parent table's primary key has been deleted,
all the records from the child table referring to this value will be removed as well
*/

# since we applied commit, we can use rollback in the case that we accidentally deleted the wrong employee

rollback; 

# check to see if the employee is registered again in both tables
select*from employees where emp_no = 999903; 
select*from titles where emp_no = 999903;


/* Exercise 1
Remove the department number 10 record from the departments table
*/ 

delete from departments where dept_no = 'd010';

# check to see if it worked 

select*from departments where dept_no = 'd010';

## DROP vs. TRUNCATE vs. DELETE ##

/* DROP 
- means you won't be able to roll back to its initial state, or to the last commit state 
- Use drop table only when you're sure you won't be using the table again */

/* TRUNCATE 
- is DELETE without the where statement
- it deletes all the record in the table but keeps the tables structure
- when truncating, auto-increment values will be reset 
*/

/* DELETE 
- removes records row by row 
*/

/* TRUNCATE vs DELETE without WHERE
- the SQL optimizer will implement different programmatic approaches when we are using truncate or delete
- truncate delivers output much quicker than delete
- auto-increment values are not reset with delete 
- more detailed explanation is beyond the scope of this course 
*/ 
