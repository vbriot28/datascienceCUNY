# SQL - Final Project 

# 1 Create New Schema: BuildingsEnergy
CREATE SCHEMA  IF NOT EXISTS `BuildingsEnergy`;

USE `BuildingsEnergy`;

# 2 Drop all tables if exists (childrens first because of foreign key constraints)

DROP table IF EXISTS Buildings_EnergyTypes_Usage;
DROP table IF EXISTS EnergyTypes;
DROP table IF EXISTS EnergyCategories;
DROP table IF EXISTS Buildings;
DROP table IF EXISTS Cities;
DROP table IF EXISTS Countries;

# 3 Create new tables 

CREATE table EnergyCategories (
  energy_category_id  int NOT NULL
, energy_category_code char(1) NOT NULL
, energy_category_description varchar(50) NOT NULL
, PRIMARY KEY (energy_category_id)
);

CREATE table EnergyTypes (
  energy_type_id  int NOT NULL
, energy_type_code char(2) NOT NULL
, energy_type_description varchar(25) NOT NULL
, energy_category_id int NULL
, PRIMARY KEY (energy_type_id)
, foreign key fk_EnergyTypes (energy_category_id)
  references EnergyCategories (energy_category_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE 
);

CREATE table Countries (
  country_id  int NOT NULL
, country_code char(2) NOT NULL
, country_name varchar(50) NOT NULL
, country_sequencing int NOT NULL
, PRIMARY KEY (country_id)
);

CREATE table Cities (
  city_id  int NOT NULL
, city_name varchar(50) NOT NULL
, country_id int NOT NULL
, PRIMARY KEY (city_id)
, foreign key fk_Cities (country_id)
  references Countries (country_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE 
);

CREATE table Buildings (
  building_id  int NOT NULL
, building_name varchar(50) NOT NULL
, city_id int NOT NULL
, PRIMARY KEY (building_id)
, FOREIGN KEY fk_Buildings (city_id)
  references Cities (city_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE table Buildings_EnergyTypes_Usage (
  building_energy_type_usage_id  int NOT NULL
, building_id int NOT NULL
, energy_type_id int NOT NULL
, PRIMARY KEY (building_energy_type_usage_id)
, FOREIGN KEY fk1_Building_EnergyTypes_Usage (building_id)
  references Buildings (building_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
, FOREIGN KEY fk2_Building_EnergyTypes_Usage (energy_type_id)
  references EnergyTypes (energy_type_id)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

# 4 Insert Data into the tables
# Refers to word document: SQLFinal.docx, for complete data sets

# i EnergyCategories/EnergyTypes

INSERT IGNORE into EnergyCategories (energy_category_id, energy_category_code, energy_category_description)
							  values (1, "F", "Fossil") 
									,(2, "R", "Renewable")
                                    ;
                                    

INSERT IGNORE into EnergyTypes (energy_type_id, energy_type_code, energy_type_description, energy_category_id)
							  values (1, "EL", "Electricity", 1) 
									,(2, "FO", "Fuel Oil", 1)
                                    ,(3, "GS", "Gas", 1)
                                    ,(4, "SL", "Solar", 2)
                                    ,(5, "ST", "Steam", 1)
                                    ,(6, "WD", "Wind", 2)
                                    ,(7, "GT", "Geothermal", 2)
                                    ;
                                    

# ii Countries/Cities, currently we are only considering city of New York in use

INSERT IGNORE into Countries (country_id, country_code, country_name, country_sequencing)
                      values (1, "US", "United States of America", 1)
					         ;
                             
INSERT IGNORE into Cities (city_id, city_name, country_id)
				   values (1, "New York", 1)
                          ;
                          
# iii Buildings

INSERT IGNORE into Buildings (building_id, building_name, city_id)
                    values (1, "Borough of Manhattan Community College", 1)
						  ,(2, "Chrysler Building", 1)
                          ,(3, "Empire State Building", 1)
                          ,(4, "Bronx Lions House", 1)
                          ,(5, "Brooklyn Childrens Museum", 1)
                          ;

# iv Building_EnergyTypes_Usage

INSERT IGNORE into Buildings_EnergyTypes_Usage (building_energy_type_usage_id, building_id, energy_type_id)
                                          values (1, 1, 4)
											    ,(2, 1, 1)
                                                ,(3, 1, 5)
                                                ,(4, 2, 5)
                                                ,(5, 2, 1)
                                                ,(6, 3, 1)
                                                ,(7, 3, 5)
                                                ,(8, 3, 3)
                                                ,(9, 4, 7)
                                                ,(10, 5, 1)
                                                ,(11, 5, 7)
                                                ;
 
 # 5 SQL Statements and Queries
 
 # i.  Write a JOIN statement that shows the energy categories and associated energy types
 
 SELECT ec.energy_category_description, et.energy_type_description from EnergyCategories ec
 inner join EnergyTypes et
 on ec.energy_category_id = et.energy_category_id;
 
 # ii. Write a JOIN statement that shows the buildings and associated energy types for each building
 
 SELECT b.building_name, et.energy_type_description 
 from Buildings b
 inner join Buildings_EnergyTypes_Usage betu
 on b.building_id = betu.building_id
 inner join EnergyTypes et
 on betu.energy_type_id = et.energy_type_id
 order by b.building_name, et.energy_type_description
 ; 
 
 # iii. Write a SQL query that displays all of the buildings that use Renewable Energies
 
 SELECT b.building_name, et.energy_type_description, ec.energy_category_description
 from Buildings b
 inner join Buildings_EnergyTypes_Usage betu
 on b.building_id = betu.building_id
 inner join EnergyTypes et
 on betu.energy_type_id = et.energy_type_id
 inner join energycategories ec
 on et.energy_category_id = ec.energy_category_id
 where ec.energy_category_code = "R"
 order by b.building_name, et.energy_type_description
 ; 
 
 # iv. Write a SQL query that shows the frequency with which energy types are used in various buildings
 
 SELECT et.energy_type_description, count(betu.building_id) as Totalcount 
 from EnergyTypes et
 inner join Buildings_EnergyTypes_Usage betu
 on et.energy_type_id = betu.energy_type_id
 group by et.energy_type_id 
 order by Totalcount desc, et.energy_type_description
 ; 