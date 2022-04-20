###### INSERT Statement ######

use employees;

# Adding records to tables 

SELECT 
    *
FROM
    employees
LIMIT 10;

/* INSERT INTO table_name (column1, column2, columnN)
VALUES (value1, value2, valueN);

- type integers as plain numbers without using quotes
- we must put the VALUES in the exact order we have listed to column names
- specify as many data values as there are columns in the data table 
- add them in the same order in which they appear in the table
- make sure data types match for the value function 
*/

# Create a new record for John Smith

insert into  employees
( 
emp_no, 
birth_date, 
first_name, 
last_name, 
gender, 
hire_date
) values 
(
999901,
'1986-04-21',
'John',
'Smith',
'M', 
'2011-01-01'
);

INSERT INTO employees
VALUES
(
    999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
    );
    
# you don't need to specify columns when all columns are being updated

/* Exercise 1
Select ten records from the “titles” table to get a better idea about its content.
Then, in the same table, insert information about employee number 999903.
State that he/she is a “Senior Engineer”, who has started working in this position on October 1st, 1997.
At the end, sort the records from the “titles” table in descending order 
to check if you have successfully inserted the new record.
Hint: To solve this exercise, you’ll need to insert data in only 3 columns!
Don’t forget, we assume that, apart from the code related to the exercises, 
you always execute all code provided in the lectures.
This is particularly important for this exercise. If you have not run the code from the previous lecture, called
‘The INSERT Statement – Part II’, where you have to insert information about employee 999903,
you might have trouble solving this exercise!

*/ 

# view the table 

select*from titles limit 10;

# we want to update columns emp_no, title, from_date

insert into titles 
(
emp_no, 
title, 
from_date
) values 
(
999903,
'Senior Engineer', 
'1997-10-01'
); 

/* Exercise 2
Insert information about the same individual in exercise 1 into the dept_emp table.
They work in department 5 as of October 1 1997,
The contract length is indefinite (hint: use 9999-01-01 as the end date)
*/ 

# view the table 
select*from dept_emp limit 10; 
# we want to update all the columns 

insert into dept_emp values
(
999903,
'd005',
'1997-10-01',
'9999-01-01'
);

## Inserting data into a new table 

/* insert into new_table_name (column_i, ... , column_N)
select (column_i, ... , column_N)
from table_choice
where condition;
*/

select*from departments limit 10;
# dept_no and dept_name 

# create a replica of the departments table 

CREATE TABLE departments_dup 
(
    dept_no CHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL
); 

insert into departments_dup (dept_no, dept_name)
select*from departments;

# always remember to insert data that complies with the existing constraints 

/* Exercise 3
Create a new department called "Business Analysis". Register it under deparment 10. 
*/ 

insert into departments values
( 'd010',
'Business Analysis'
);

insert into departments_dup values
( 'd010',
'Business Analysis'
);

## Using the COMMIT statement
/* 
- saves the transaction in the database
- changes cannot be undone
- used to save the state of the data in the database at the moment of its execution
*/

## Using the ROLLBACK clause 
/* 
- allows you to take a step back 
- the last change(s) made will not cunt
- reverts to the last non-committed state
- it will refer to the state corresponding to the last time you executed the COMMIT statement
- you cannot keep rolling back to get to previous commits, it always remains at the last one executed
*/ 