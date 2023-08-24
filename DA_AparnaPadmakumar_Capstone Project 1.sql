-- TASK 1: Full name of Actors
use sakila;
select * from actor;
select concat(first_name,' ',last_name) as full_name from actor;

-- TASK 2i: Number of times each first name appears
select first_name,count(*) as name_count from actor group by first_name order by name_count desc;

-- TASK 2ii: Name of actors with unique first names
select first_name from actor group by first_name having count(*)=1;

-- Count of actors with unique first names
select count(*) from (Select first_name, COUNT(*) as unique_count from actor
Group by first_name
Having unique_count = 1) f;

-- TASK 3i: Number of times each last name appears
select last_name,count(*) as name_count from actor group by last_name order by name_count desc;

-- TASK 3ii: All unique last name
select last_name from actor group by last_name having count(*) =1;

-- TASK 4i: List of records of movies with rating "R"
SELECT * from film;
select * from film where rating= 'R';

-- TASK 4ii: List of records of movies that are not rated "R"
select * from film where rating!= 'R';

-- TASK 4iii: List of records of movies that are suitable for audience below age 13.
select * from film where rating='G' or rating='PG' or rating= 'PG-13';

-- TASK 5i: List of records for the movies where the replacement cost is up to $11.
select * from film where replacement_cost <= 11;

-- TASK 5ii: List of records for the movies where the replacement cost is between $11 and $20.
select * from film where replacement_cost between 11 and 20;

-- TASK 5iii: records of all movies in descending order of their replacement cost.
select * from film order by replacement_cost desc;

-- TASK 6: Top 3 movies with the greatest number of actors.
select * from film;
select * from film_actor;
select film.title, count(actor_id) as no_of_actors 
from film join film_actor 
on film.film_id = film_actor.film_id 
group by film.film_id order by no_of_actors desc limit 3;

-- TASK 7: Titles of movies starting with the letter K and Q.
select title from film where title like 'K%' or title like 'Q%';

-- TASK 8: Names of actors who appeared in the film Agent Truman
select * from film;
select * from film_actor;
select * from actor;
select actor.first_name, actor.last_name from actor join film_actor on actor.actor_id = film_actor.actor_id 
join film on film_actor.film_id = film.film_id 
where film.title = 'Agent Truman';

-- TASK 9: Movies categorized as family film.
select * from film_category;
select * from category;
select film.title from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where category.name='Family';

-- TASK 10i: Maximum, Minimum, and Average rental rates of movies based on their ratings.
select rating, MAX(rental_rate) as max_rental_rate, MIN(rental_rate) as min_rental_rate, AVG(rental_rate) as avg_rental_rate
from film group by rating order by avg_rental_rate desc;

-- TASK 10ii: Movies in descending order of their rental frequencies,
select * from inventory;
select * from rental;
select film.title, count(rental.rental_id) as rental_count from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by film.film_id order by rental_count desc;

-- TASK 11: Count of film categories in which the difference between avg film rental cost and avg film rental rate is greater than 15
select count(*) from (select category.name as category_name, avg(film.replacement_cost) as avg_replacement_cost, avg(film.rental_rate) as avg_rental_rate
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id=category.category_id
group by category.category_id
having (avg(film.replacement_cost)- avg(film.rental_rate))>15) f;

-- Task 11 List of film category along with avg film rental cost and avg film rental rate
select category.name as category_name, avg(film.replacement_cost) as avg_replacement_cost, avg(film.rental_rate) as avg_rental_rate
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id=category.category_id
group by category.category_id
having (avg(film.replacement_cost)- avg(film.rental_rate))>15;

-- TASK 12: Film categories in which number of movies is greater than 70.
select category.name as category_name, count(film.film_id) as movie_count from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id= category.category_id
group by category.category_id
having count(film.film_id) > 70;
