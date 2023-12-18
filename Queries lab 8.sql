-- LAB 8 QUERIES 
-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length, rank() over (order by length) as 'Rank'
from film
where length is not null and length > 0;
-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
select title, length, rating, row_number() over(partition by rating order by length) as 'Rank Row'
from film
where length is not null and length > 0;
-- How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select c.name as category, count(*) as 'Film_count'
from category c
join film_category fc on c.category_id = fc.category_id
group by c.name;
-- (?) Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select a.actor_id, a_first_name, a.last_name, count(*) as 'Film Count'
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a_first_name, a.last_name
order by film_count desc limit 1;
-- Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select c.customer_id, c.first_name, c.last_name, count(*) as rental_count
from customer c
join rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by rental_count desc limit 1;