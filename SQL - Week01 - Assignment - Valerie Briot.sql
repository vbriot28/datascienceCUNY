# SQL - Week01 - Assignment - Valerie Briot

# Question #1: which destination is furthest away
# query to get maximum distance
select max(distance) from flights;

# quesry to find distinct destination where distance is equal to max distance
select distinct dest from flights where distance = (select max(f2.distance) from flights f2);

# Answer = HNL

# Question# 2: What are the different # of engines in plane table and for each number of engines which aircrafts have the most number of seats
# What are the different # of engines

select engines, max(seats) from planes
group by engines 
order by 2 desc;

# Answer:
# engines   max(seats)
#   4         450
#   2         400
#   3         379
#   1          16

# For each number of engines, which planes (as manufacturer, model) as the most seats
select distinct manufacturer, model, engines, seats from planes p1 
where p1.seats = (select max(seats) from planes p2 where p1.engines = p2.engines)
order by engines, seats, manufacturer, model;

# Answer:
# manufactur    model        engines    seats
# DEHAVILLAND   OTTER-DHC-3   1          16
# BOEING        777-200       2          400
# BOEING        777-222       2          400
# BOEING        777-224       2          400
# BOEING        777-232       2          400
# AIRBUS        A330-223      3          379
# BOEING        747-451       4          450

 # Question# 3: What is the total number of flights
 select count(*) from flights;
 
 # Answer: 336776 
 
# Question# 4: Show the total number of flights by Airline carrier
select carrier, count(*) from flights
group by carrier
order by carrier;

# Answer: 
# carrier  count(*)
# 9E        18450
# AA        32729
# AS          714
# B6        54635
# DL        48110
# EV        54173
# F9          685
# FL         3260
# HA          342
# MQ        26397
# OO           32
# UA        58665
# US        20536
# VX         5162
# WN        12275
# YV          601

# Question# 5: Show of the airlines, ordered by number of flights in descending order
select carrier, count(*) as number_of_flight from flights
group by carrier
order by 2 desc

# carrier, number_of_flight
#'UA', '58665'
#'B6', '54635'
#'EV', '54173'
#'DL', '48110'
#'AA', '32729'
#'MQ', '26397'
#'US', '20536'
#'9E', '18460'
#'WN', '12275'
#'VX', '5162'
#'FL', '3260'
#'AS', '714'
#'F9', '685'
#'YV', '601'
#'HA', '342'
#'OO', '32'

# Question# 6: Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order
select carrier, count(*) as number_of_flight from flights
group by carrier
order by 2 desc limit 5;

# Answer:
# carrier, number_of_flight
#'UA', '58665'
#'B6', '54635'
#'EV', '54173'
#'DL', '48110'
#'AA', '32729'

# Question# 6: Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater,
# ordered by number of flights in descending order.

select carrier, count(*) as number_of_flight from flights
where distance >= 1000 
group by carrier
order by 2 desc limit 5;

# Answer:
# carrier, number_of_flight
#'UA', '41135'
#'B6', '30022'
#'DL', '28096'
#'AA', '23583'
#'EV', '6248'

# Question# 8: Show all carriers (and month) that have 10 or more delays in departure time of 30 minutes or more in a month
Select carrier, year, month, count(dep_delay) from flights
where dep_delay >= 30
group by carrier, year, month
having count(dep_delay) >= 10;