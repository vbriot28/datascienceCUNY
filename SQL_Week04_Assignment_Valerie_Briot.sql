# SQL - Week 04 Assigment - Employees

# 1. Create New Schema: employees

CREATE SCHEMA  IF NOT EXISTS `employees`;

USE `employees`;

# 2. Create Tables 

# Create employees table: tblemployees
create table if not exists tblemployees (
  employee_id  int NOT NULL
, first_name varchar(50) NOT NULL
, last_name varchar(50) NOT NULL
, title varchar(50) NOT NULL
, phone_number char(12) NULL
, employee_type char(1) NOT NULL
, pay_grade int NOT NULL
, manager_id int NULL
, PRIMARY KEY (employee_id)
, foreign key fk1_employee (manager_id)
  references tblemployees (employee_id)
  ON UPDATE CASCADE
  ON DELETE SET NULL 
);

# 3. Data Entry 
# insert data into table: tblemployees 
# Please refer to data set for values in document SQL_Week04_Assignment_Valerie_Briot.doc
# Please note: ONLY data for the first 3 levels (or so) of Organization Chart will be entered
# (the rest of data could be entered with similar SQL statements)

  INSERT IGNORE into tblemployees (employee_id, first_name, last_name, title, phone_number, employee_type, pay_grade, manager_id)
  values ( 1, "Annie", "Leclaire", "Chief Information Officer", "212-812-1234", "P", 1, NULL)
		,( 2, "Liz", "McTigue", "Executive Assistant", "212-812-1235", "P", 7, 1)
        , (3, "John", "Mitten", "VP Entreprise Application Development", "212-812-1236", "P", 2, 1)
        , (4, "Jeanne", "Owlen", "VP IT Operations", "212-812-1237", "P", 2, 1)
        , (5, "Micheal", "Gillen", "VP Systems and IT infrastructure", "212-812-1238", "P", 2, 1)
        , (6, "Kai", "Pascuali", "System Architect", "212-812-1239", "P", 2, 1)
        , (7, "Vielka", "Shoang", "New Projects Manager", "212-812-1240", "P", 3, 3)
        , (8, "Vladimir", "Trenton", "Production Support Manager", "212-812-1241", "P", 3, 3)
        , (9, "Johanne", "Grams", "Data Center Manager", "212-812-1245", "P", 4, 4)
        , (10, "Andre", "Swenson", "Change Management Manager", "212-812-1244", "P", 3, 4)
        , (11, "Randy", "Gilbert", "Telecom Specialist", "212-812-1246", "C", 20, 5)
        ;
        
# Select Statement to validate Data Entry
Select * from tblemployees;

# 4. Query to display data
# 4.i Who report to whom

Select e.first_name
     , e.last_name
     , e.title
     , case 
       when e.manager_id IS NULL then " "
       else concat(m.first_name, " ", m.last_name) 
       end as manager
	, case
	  when e.manager_id IS NULL then " " 
	  else m.title
      end as 'manager title'
from tblemployees e
left join tblemployees m 
on e.manager_id = m.employee_id 
order by manager