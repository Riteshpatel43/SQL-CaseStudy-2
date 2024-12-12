use case_studies; -- remove it if getting error 

DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  runner_id INTEGER,
  registration_date DATE
);
INSERT INTO runners
  (runner_id, registration_date)
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');


DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  order_id INTEGER,
  customer_id INTEGER,
  pizza_id INTEGER,
  exclusions VARCHAR(4),
  extras VARCHAR(4),
  order_time TIMESTAMP
);

INSERT INTO customer_orders
  (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  order_id INTEGER,
  runner_id INTEGER,
  pickup_time VARCHAR(19),
  distance VARCHAR(7),
  duration VARCHAR(10),
  cancellation VARCHAR(23)
);

INSERT INTO runner_orders
  (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  pizza_id INTEGER,
  pizza_name TEXT
);
INSERT INTO pizza_names
  (pizza_id, pizza_name)
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  pizza_id INTEGER,
  toppings TEXT
);
INSERT INTO pizza_recipes
  (pizza_id, toppings)
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');


DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  topping_id INTEGER,
  topping_name TEXT
);
INSERT INTO pizza_toppings
  (topping_id, topping_name)
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');
  
  
select * from runners;
select * from customer_orders;
select * from runner_orders;
select * from pizza_names;
select * from pizza_recipes;
select * from pizza_toppings;


-- Case Study Questions: 
-- This case study has LOTS of questions - they are broken up by area of focus including:

-- Pizza Metrics
-- Runner and Customer Experience
-- Ingredient Optimisation
-- Pricing and Ratings
 
-- Each of the following case study questions can be answered using a single SQL statement.

-- Again, there are many questions in this case study - please feel free to pick and choose which ones you’d like to try!

-- Before you start writing your SQL queries however - you might want to investigate the data, you may want to do something with some of those null values and data types in the customer_orders and runner_orders tables!

-- 		A. Pizza Metrics
-- 1.How many pizzas were ordered?
-- 2.How many unique customer orders were made?
-- 3.How many successful orders were delivered by each runner?
-- 4.How many of each type of pizza was delivered?
-- 5.How many Vegetarian and Meatlovers were ordered by each customer?
-- 6.What was the maximum number of pizzas delivered in a single order?
-- 7.For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
-- 8.How many pizzas were delivered that had both exclusions and extras?
-- 9.What was the total volume of pizzas ordered for each hour of the day?
-- 10.What was the volume of orders for each day of the week?


-- 		B. Runner and Customer Experience
-- 1.How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
-- 2.What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
-- 3.Is there any relationship between the number of pizzas and how long the order takes to prepare?
-- 4.What was the average distance travelled for each customer?
-- 5.What was the difference between the longest and shortest delivery times for all orders?
-- 6.What was the average speed for each runner for each delivery and do you notice any trend for these values?
-- 7.What is the successful delivery percentage for each runner?
 
 
 
-- DATA CLEANING  STEPS : ================
SET SQL_SAFE_UPDATES = 0;

-- (i) Fill the null values and empty

update customer_orders
set extras = NULL 
where extras = '' or extras = 'null';
 
update customer_orders
set exclusions = NULL 
where exclusions in ('','null');


update runner_orders
set cancellation = NULL 
where cancellation in ('','null');
select * from runner_orders;

update runner_orders
set distance = TRIM(REPLACE(distance,'km',''));

update runner_orders
set distance = NULL 
where distance in ('','null');
select * from runner_orders;

alter table runner_orders
rename column `distance` to `distance_km`; 
 
 update runner_orders
set pickup_time = NULL 
where pickup_time in ('','null');
select * from runner_orders;
 
  update runner_orders
set duration = NULL 
where duration in ('','null');
select * from runne	r_orders;

update runner_orders
set duration = trim(replace(duration,'minutes',''));

 update runner_orders
set duration = trim(replace(duration,'mins',''));

 update runner_orders
set duration = trim(replace(duration,'minute',''));

alter table runner_orders
rename column `duration` to `duration_min`; 

alter table runner_orders
modify distance_km float;

alter table runner_orders
modify duration_min int;
select * from runners;
select * from customer_orders;
select * from runner_orders;
select * from pizza_names;
select * from pizza_recipes;
select * from pizza_toppings;
-- SOLUTIONS ==================================================================

-- 		A. Pizza Metrics

-- Q1.How many pizzas were ordered?

select count(*) from customer_orders;

-- Q2.How many unique customer orders were made?

SELECT COUNT(DISTINCT order_id) FROM customer_orders;

-- Q3.How many successful orders were delivered by each runner?

select runner_id,count(*) as delivered from runner_orders where cancellation is NULL group by runner_id; 

-- Q4.How many of each type of pizza was delivered?


 select p.pizza_name,count(c.pizza_id) AS delivered 
 from pizza_names p 
 join customer_orders c 
 on p.pizza_id = c.pizza_id 
 join runner_orders r 
 on c.order_id = r.order_id 
 where r.cancellation is null group by p.pizza_name;

-- Q5.How many Vegetarian and Meatlovers were ordered by each customer?
 
select c.customer_id,p.pizza_name,count(c.order_id) as pizzas_ordered
from customer_orders c
join pizza_names p 
on c.pizza_id = p.pizza_id
group by p.pizza_name,c.customer_id;

-- Q6.What was the maximum number of pizzas delivered in a single order?

select MAX(pizzas_delivered) as max_pizzas_in_single_order 
from (
		select c.order_id,count(c.pizza_id) as pizzas_delivered
		from customer_orders c
		join runner_orders r
		on c.order_id = r.order_id
		where cancellation is null
		group by c.order_id)as pizzas_per_order;


-- Q7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

select c.customer_id,count(c.pizza_id) as pizzas_delivered ,
sum(case
	when c.exclusions is not null or c.extras is not null
    then 1
    else 0
end) as atleast_1_change,
sum(case
	when c.exclusions is null and c.extras is null
    then 1
    else 0
end) as no_change
from customer_orders c
join runner_orders r
on c.order_id = r.order_id
where cancellation is null
group by c.customer_id
;


-- Q8. How many pizzas were delivered that had both exclusions and extras?

select c.customer_id,count(c.pizza_id) as pizzas_delivered ,
sum(case
	when c.exclusions is not null AND c.extras is not null
    then 1
    else 0
end) as both_exclusions_and_extras
from customer_orders c
join runner_orders r
on c.order_id = r.order_id
where cancellation is null
group by c.customer_id
;

-- Q9.What was the total volume of pizzas ordered for each hour of the day?

select hour(order_time),count(customer_id) from customer_orders group by hour(order_time) order by hour(order_time);

-- Q10.What was the volume of orders for each day of the week?

select dayname(order_time),count(customer_id) from customer_orders group by dayname(order_time) order by dayname(order_time);


-- 	B. Runner and Customer Experience =====================================

-- 1.How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

 SELECT 
    YEAR(registration_date) AS year,
    WEEK(registration_date, 1) AS week,
    COUNT(runner_id) AS runner_count
FROM runners
GROUP BY YEAR(registration_date), WEEK(registration_date, 1)
ORDER BY year, week;



-- 2.What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

SELECT 
    r.runner_id, 
    AVG(TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time)) AS avg_time
FROM 
    runner_orders r
JOIN 
    customer_orders c ON r.order_id = c.order_id
WHERE
    r.pickup_time IS NOT NULL
GROUP BY 
    r.runner_id;


-- 3.Is there any relationship between the number of pizzas and how long the order takes to prepare?
-- (order_id,pizza_count in each order , time taken between order and pickup)
with cte as (
select c.order_id,count(c.pizza_id) as pizzas_per_order, TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time)  AS time_taken
 from customer_orders c 
 join runner_orders r 
 on c.order_id = r.order_id 
 where   cancellation is null  
 group by c.order_id,TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time))
 select pizzas_per_order,avg(time_taken) as avg_time_per_pizza
 from cte 
 group by pizzas_per_order;


-- 4.What was the average distance travelled for each customer?

select c.customer_id,avg(distance_km) from customer_orders c join runner_orders r on c.order_id = r.order_id WHERE r.distance_km IS NOT NULL group by c.customer_id;
 

-- 5.What was the difference between the longest and shortest delivery times for all orders?

select max(duration )-min(duration ) as time_taken from runner_orders where duration is not null ;
 

 
-- 6.What was the average speed for each runner for each delivery and do you notice any trend for these values?

select runner_id,sum(distance_km) as kms,round(avg(distance_km/duration_min)*60,2) as avg_speed 
from runner_orders 
where duration_min is not null 
group by runner_id order by kms;

-- 7.What is the successful delivery percentage for each runner?
  SELECT 
    runner_id,
    COUNT(CASE WHEN duration_min IS NOT NULL THEN 1 END) * 100.0 / COUNT(*) AS successful_delivery_percentage
FROM 
    runner_orders
GROUP BY 
    runner_id;

