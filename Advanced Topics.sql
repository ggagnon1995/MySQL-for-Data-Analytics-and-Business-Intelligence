###### Advanced SQL Topics ######

/* Local Variables 
- a variable that is visible only in the BEGIN - END block in which it was created
- the variables we already worked with in stored routines 
- declare is a keyword that only works for local variables
*/


/* Session Variables
- A session is a series of information exchange interactions, or a dialogue,
between a computer and a user
- I.e. a dialogue between the MySQL server and MySQL Workbench
- A session begins at a certain point in time and terminates at a later point in time
1) Set up a connection
2) establish a connection 
3) the workbench interface will open immediately
4) end a connection
- there are certain SQL objects that are valid for a specific session only 
- hence a session variable is one that exists only for the session you are operating
*/

set @s_var1 = 3;
select @s_var1;

# If you open a new connection and run select @s_var1 the output will be null 


/* Global Variables
- apply to all connections on one server 
set global var_name = value; 
or 
set @@global.var_name = value;
- only good for system variables 
.max_connection() indicates the max number of connections to a server that can be established
	at a certain point in time 
.max_join_size() sets the maximum memory space allocated for the joing created by a certain connection
*/

set global max_connections = 1000;
# Hard to prove only 1000 connections can exist 

set @@global.max_connections = 1;
# If you try to access the new connection you will get an error 


/* User-Defined vs System Variables
User-Defined: variables set by the user manually 
System: variables that are pre-defined on our system - the MySQL server
- only system variables can be set as global
*/


/* Triggers
- a type of stored program, associated iwth a table, that will be activated 
automatically once a specific event occurs
- must be related to the associated table and represented by one of the following DML statements: 
INSERT, UPDATE, or DELETE
- triggers a specific action or calculation before or after one of the following DML statements are applied
- system functions = built in functions 
*/

use employees;

commit;

# Before INSERT 

delimiter // 
create trigger before_salaries_insert
before insert on salaries
for each row
begin
if new.salary < 0 then 
set new.salary = 0;
end if; 
end // 
delimiter ; 

select*from salaries where emp_no = '10001';

# Now try and insert a negative salary in 

insert into salaries values ('10001', -92891, '2010-06-22', '9999-01-01');
select*from salaries where emp_no = '10001';

# The salary is 0 instead of -$92,891

# Before UPDATE

delimiter // 
create trigger before_salaries_update
before update on salaries
for each row
begin 
if new.salary < 0 
then set new.salary = old.salary;
end if;
end // 
delimiter ; 

# Update the table once 

update salaries 
set salary = 98765
where emp_no = '10001'
and from_date = '2010-06-22';

select*from salaries where emp_no = '10001';

# Update the table a second time to see if the trigger worked 

update salaries 
set salary = -50000
where emp_no = '10001'
and from_date = '2010-06-22';

select*from salaries where emp_no = '10001';

# It wasn't adjusted meaning the trigger worked

/* SYSDATE()
- selecting the time a trigger is imposed for 
select sysdate(); 
select date_format(sysdate(), '%y-%m-%d') as today;
*/


/* 
*/


/* 
*/


/* 
*/


/* 
*/


/* 
*/


/* 
*/