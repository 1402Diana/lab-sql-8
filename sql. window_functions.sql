--  Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

select title, length,
rank() over (partition by length) as length_rank
from film 
where length > 0
order by length desc;


--  Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

select title, length, rating,
rank() over (partition by length) as length_rank
from film 
where length > 0
order by length_rank, rating desc;

--  How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".

select c.category_id, fc.film_id, c.name,
count(fc.film_id) over (partition by c.name) as number_films
from category c
join film_category fc on c.category_id=fc.category_id
order by number_films desc;


--  Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select a.actor_id, a.first_name, a.last_name, fa.film_id,
count(a.actor_id) over (partition by fa.film_id) as prolific_actor
from actor a
join film_actor fa on fa.actor_id = a.actor_id
order by fa.film_id desc
limit 1;


--   Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select c.customer_id, c.first_name, c.last_name, 
count(r.rental_id) over(partition by c.customer_id) as most_number_films
from customer c
join rental r on r.customer_id = c.customer_id
order by c.customer_id desc
limit 1;


--  Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).

--- This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.

-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.

select f.film_id, f.title,
count(r.rental_id) over(partition by f.film_id) as most_rented
from film f
join inventory i on i.film_id=f.film_id
join rental r  on r.inventory_id = i.inventory_id
order by  most_rented desc
limit 1;
