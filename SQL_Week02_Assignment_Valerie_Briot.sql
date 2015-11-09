# SQL - Week 02 Assignment - Videos

# Create a new Schema for videos database, created via MySQL SQL Workbench graphical user interface,
# CREATE SCHEMA `videos` ;

# ensure that following statements are on new schema
use videos;

# 1. Create Videos
create table tblvideos (
  video_id  int NOT NULL AUTO_INCREMENT
, tittle varchar(255) NOT NULL
, length int NOT NULL
, video_URL varchar(255) NOT NULL
, PRIMARY KEY (video_id)
);

# 2. Create Review table, with foreign key=video_id with constraint, 
# no review will be accepted for non-existent video

create table tblreviews (
  review_id int NOT NULL AUTO_INCREMENT
, user_name varchar(50) NOT NULL
, rating int NULL
, review_text varchar(255) NOT NULL
, create_datetime datetime NOT NULL
, video_id int NOT NULL
, check (rating between 0 and 5)
, primary key (review_id)
, foreign key fk_videos (video_id)
  references tblvideos (video_id)
  ON UPDATE NO ACTION
  ON DELETE CASCADE 
); 

# 3. Insert Data into tblvideos, use Table Data Import Wizard and use videos_initial.csv file
#    Mapp fields to Title, tblvideos, length, video_URL... and leave id blank as it is auto incremented.
#    Once data is imported check the record with select below, 8 records should have been created.

# 4. View newly created data entry in tblvideos

Select * from tblvideos;

# 5. Insert Data into tblreviews, use Table Data Import Wizard and use reviews_initital.csv file
#    Mapp fields user_name, rating, review_text, create_datetime, video_id... review_id is auto generated
#    Once data is imported check the record with select below, 12 records should have been created.

# 6. View newly created data entries in tblreviews... Only 10 records were created (the one wiht NULL rating where not).

select * from tblreviews;

# 7. Insert the 2 records with NULL rating with statements

insert into tblreviews
(user_name, rating, review_text, create_datetime, video_id)
values ("Caramel", NULL, "Love the whole series… Great Job", "2015-03-16 22:14:20", 6);

insert into tblreviews
(user_name, rating, review_text, create_datetime, video_id)
values ("ArielleP.", NULL, "Thank you big time, save me a lot of time!", "2015-06-18 17:49:55", 7);

# 8. View newly created data entries in tblreviews

select * from tblreviews;

# 9. videos name and rating of 4 or 5 with number of reviews with the rating

select tv.tittle, tr.rating, count(*) as number_reviews from tblvideos tv
inner join tblreviews tr
on tv.video_id = tr.video_id
where rating in (4, 5) 
group by tv.tittle, tr.rating
order by tr.rating desc, tv.tittle;