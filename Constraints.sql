/* Section 1: Creating databases and tables */
CREATE DATABASE IF NOT EXISTS sales;
CREATE SCHEMA IF NOT EXISTS sales;
USE sales;

CREATE TABLE sales
(
purchase_number INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
date_of_purchase DATE NOT NULL, 
customer_id INT,
item_code VARCHAR(10) NOT NULL
);
/* use not NULL for fields that must always have a record */
/* use AUTO_INCREMENT if you want each field to automatically fill in n+1 
It only works for primary keys and indices */

CREATE TABLE customers
(
customer_id INT, 
first_name VARCHAR(255),
last_name VARCHAR(255),
email VARCHAR(255),
number_of_complaints INT 
);

SELECT * FROM customers;
/* using above line equires the USE sales; statement*/
SELECT * FROM sales.customers;
/* using above line does not require it*/
/* SELECT * FROM database.table*/

/* prep for the following lecture*/ 

DROP TABLE sales;

/* Section 2: Constraints */
/* contraints are specific rules/limits that we define in our tables */
/* recreate the sales table with slightly different code */

USE sales;
CREATE TABLE sales

(
purchase_number INT AUTO_INCREMENT,
date_of_purchase DATE NOT NULL, 
customer_id INT,
PRIMARY KEY (purchase_number)
);

/* excersize */

drop table customers;

CREATE TABLE customers                                                             

(  
    customer_id INT,  
    first_name varchar(255),  
    last_name varchar(255),  
    email_address varchar(255),  
    number_of_complaints int,  
primary key (customer_id)  

);  

create table items
(
item_code varchar(255),
item varchar(255),
unit_price numeric(10,2),
company_id varchar(255),
primary key (item_code)
);

/* unit_price can be 10 digits in total with 2 digits right of the decimal */

create table companies
(
company_id varchar(255),
company_name varchar(255),
headquarters_phone INT(12),
primary key (company_id)
);

/* foreign key constraint 
on delete cascade means if an entry is deleted in the parent table it will delete all records in the child table */
alter table sales
add foreign key (customer_id) references customers(customer_id) on delete cascade;

DROP TABLE sales;
DROP TABLE customers;
DROP TABLE items;
DROP TABLE companies;

/* headquarters phone number must be 10 numbers long */

/* unique constraint
makes sure all values in a column are different 
first way creation of new table
second way adding to preexisting table 
*/
/* first way */

CREATE TABLE customers                                                             

(  
    customer_id INT,  
    first_name varchar(255),  
    last_name varchar(255),  
    email_address varchar(255),  
    number_of_complaints int,  
primary key (customer_id),  
unique key (email_address) 
);  

drop table customers; 

/* second way */
CREATE TABLE customers (
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
    PRIMARY KEY (customer_id)
);  

alter table customers 
add unique key (email_address);

/* drop the unique key */ 

alter table customers 
drop index email_address; 

/* drop syntax doesn't need parenthesis */ 

/* exercise */ 

drop table customers;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
PRIMARY KEY (customer_id)
);

ALTER TABLE customers
ADD COLUMN gender ENUM('M', 'F') AFTER last_name;
INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0)
;

/* default constraint */ 

drop table companies;

CREATE TABLE companies (
    company_id VARCHAR(255),
    company_name VARCHAR(255) DEFAULT 'X',
    headquarters_phone_number VARCHAR(255),
PRIMARY KEY (company_id),
UNIQUE KEY (headquarters_phone_number)
);

/* not null constraint */

ALTER TABLE companies
MODIFY headquarters_phone_number VARCHAR(255) NULL;
ALTER TABLE companies
CHANGE COLUMN headquarters_phone_number headquarters_phone_number VARCHAR(255) NOT NULL; 




