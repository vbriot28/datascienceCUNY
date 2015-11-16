# SQL - Week 03 Assigment - Key Card System

# 1. Create New Schema: key_card_system

CREATE SCHEMA  IF NOT EXISTS `key_card_system`;

USE `key_card_system`;

# 2. Create Tables 
# Create  groups table: tblgroups
create table if not exists tblgroups (
  group_id  int NOT NULL
, group_name varchar(25) NOT NULL
, PRIMARY KEY (group_id)
);

# Create user table: tblusers
create table if not exists tblusers (
  user_id  int NOT NULL
, user_name varchar(25) NOT NULL
, group_id int NULL
, PRIMARY KEY (user_id)
, foreign key fk1_group (group_id)
  references tblgroups (group_id)
  ON UPDATE NO ACTION
  ON DELETE SET NULL 
);

# Create rooms table: tblrooms
create table if not exists tblrooms (
  room_id  int NOT NULL
, room_name varchar(25) NOT NULL
, PRIMARY KEY (room_id)
);

# Create groups_rooms_access association table: tblgroups_rooms_access
create table if not exists tblgroups_rooms_access (
  group_room_access_id  int NOT NULL
, group_id int NOT NULL
, room_id int NOT NULL
, PRIMARY KEY (group_room_access_id)
, foreign key fk2_group (group_id)
  references tblgroups (group_id)
  ON UPDATE NO ACTION
  ON DELETE CASCADE
, foreign key fk1_room (room_id)
  references tblrooms (room_id)
  ON UPDATE NO ACTION
  ON DELETE CASCADE
);

# 3. Data Entry 
# insert data into tables: tblgroups, tblusers, tblrooms, and tblgroups_rooms_access 
# Please refer to data set for values in document SQL_Week03_Assignment_Valerie_Briot.doc

# i. Data for tblgroups
insert into tblgroups
(group_id, group_name)
values (1, "IT");

insert into tblgroups
(group_id, group_name)
values (2, "Sales");

insert into tblgroups
(group_id, group_name)
values (3, "Administration");

insert into tblgroups
(group_id, group_name)
values (4, "Operations");

# SQL statement to validate data entry, 
# Expected results: 4 records IT, Sales, Administration, Operations:
select * from tblgroups;

# ii. Data for tblusers 
insert into tblusers
(user_id, user_name, group_id)
values (1, "Modesto", 1);

insert into tblusers
(user_id, user_name, group_id)
values (2, "Ayine", 1);

insert into tblusers
(user_id, user_name, group_id)
values (3, "Christopher", 2);

insert into tblusers
(user_id, user_name, group_id)
values (4, "Cheong woo", 2);

insert into tblusers
(user_id, user_name, group_id)
values (5, "Saulat", 3);

insert into tblusers
(user_id, user_name, group_id)
values (6, "Heidy", NULL);

# SQL statement to validate data entry, 
# Expected results: 6 records, Modesto, Ayine both in group 1; Christopher, Cheong woo in group 2; 
# Saulat in group 3; and Heidy with no group association:

select * from tblusers;

# iii. Data entry for tblrooms
insert into tblrooms
(room_id, room_name)
values (1, "101");

insert into tblrooms
(room_id, room_name)
values (2, "102");

insert into tblrooms
(room_id, room_name)
values (3, "Auditorium A");

insert into tblrooms
(room_id, room_name)
values (4, "Auditorium B");

# SQL statement to validate data entry, 
# Expected results: 4 records, 101, 102, Auditorium A, Auditorium B

select * from tblrooms;

# iv. Data entry for tblgroups_room_access
insert into tblgroups_rooms_access
(group_room_access_id, group_id, room_id)
values (1, 1, 1);

insert into tblgroups_rooms_access
(group_room_access_id, group_id, room_id)
values (2, 1, 2);

insert into tblgroups_rooms_access
(group_room_access_id, group_id, room_id)
values (3, 2, 2);

insert into tblgroups_rooms_access
(group_room_access_id, group_id, room_id)
values (4, 2, 3);

# SQL statement to validate data entry, 
# Expected results: 4 records; Group IT has access to rooms 101, 102
#                              Group Sales has access to rooms 102, Auditorium A

select tg.group_name, tr.room_name from tblgroups_rooms_access tgra
inner join tblgroups tg
on tgra.group_id = tg.group_id
inner join tblrooms tr
on tgra.room_id = tr.room_id;

# 4. Queries and Reporting
# i. All groups and users in each group.  Group should show even if no users assigned to the group
#    Please note: *BLANK will be shown when no user assigned to group for user_name (not NULL)

select tg.group_name as group_name
	  , case              # user_name: if user does not belong to group, display *BLANK for user_name (not NULL)
       when tu.group_id iS NULL then " " 
       else tu.user_name 
       end as user_name
       from tblgroups tg 
left join tblusers tu
on tg.group_id = tu.group_id;

# ii. All rooms, and the groups assigned to each room. 
#     The rooms should appear even if no groups have bpeen assigned to them
#     Please note: *BLANK will be shown when no group associated with rooms for group_name (not NULL)

select tr.room_name as room_name, 
case                        # group_name: if room has no group associated with it, display *BLANK for group_name (not NULL)
when tgra.group_id IS NULL then " "
else tg.group_name 
end as group_name
from tblgroups_rooms_access tgra
inner join tblgroups tg
on tg.group_id = tgra.group_id
right join tblrooms tr
on tgra.room_id = tr.room_id;

# iii. A list of users, the groups that they belong to, and the rooms to which they are assigned. 
#      This should be sorted alphabetically by user, then by group, then by room.
#     Please note: *BLANK will be shown for group_name when user does not belong to group (not NULL) and 
#                                           room_name of group is not associated with rooms (not NULL)
select tu.user_name as user_name
    ,  case                 # group_name: if user not belonging, display *BLANK for group_name (not NULL)
       when tu.group_id IS NULL then " " 
       else tg.group_name
       end as group_name
	,  case                 # room_name: if group has no room associated, display *BLANK for room_name (not NULL)
	   when tgra.group_id IS NULL then " "
       else tr.room_name
       end as room_name
from tblusers tu
left join tblgroups tg
on tu.group_id = tg.group_id
left join tblgroups_rooms_access tgra
on tu.group_id = tgra.group_id
left join tblrooms tr
on tgra.room_id = tr.room_id 
order by 1, 2, 3;