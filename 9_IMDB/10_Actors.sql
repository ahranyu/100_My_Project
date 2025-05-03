/*
 5. Actor
- Most frequently appearing actors
- Actors work with specific genres or directors?
- Distribution of actors who have experience as directors
*/

-- Most frequently appearing actors
/*
Methodology :
Find out most frequently appearing actors in movies.
From title_principal table, I filtered the category to include 'actor' and 'actress'.
Then counted the number of movies for each actor and display the results along with the actor names.
*/

SELECT primary_name , COUNT(DISTINCT title_id) AS movie_count
FROM title_principal_alter
LEFT JOIN name_basics ON name_basics.name_id = title_principal_alter.name_id
WHERE category IN ('actor','actress')
GROUP BY primary_name
ORDER BY movie_count DESC
LIMIT 10000;

-- Actors working with specific genres or directors?
/*
Methodology :
Find the connection between directors and actors.
First, I created a CTE as 'actor_table' which includes only actors,
and second CTE as 'director_table' which includes only directors.
Then created third CTE to show their connections.
Finally, in the 4th CTE 'collab_table', count number of movies they worked on together.
Filtered to more than 4 collaborations, and show their names and the number of movies they collaborated on.

*/

WITH actor_table AS (
SELECT title_id, name_id, category 
FROM title_principal_alter
WHERE category IN ('actor','actress')

), director_table AS(
SELECT title_id, name_id, category 
FROM title_principal_alter
WHERE category ='director'

), actor_director AS(
SELECT actor.title_id, actor.name_id AS actor_name, director.name_id AS director_name
FROM actor_table AS actor
INNER JOIN director_table AS director ON actor.title_id = director.title_id

), collab_table AS(
SELECT name.primary_name AS actor,director_name, COUNT(*) AS collaboration
FROM actor_director
LEFT JOIN name_basics AS name ON name.name_id=actor_director.actor_name
GROUP BY name.primary_name,director_name
ORDER BY collaboration DESC
)

SELECT actor, name.primary_name AS director , collaboration
FROM collab_table AS col
LEFT JOIN name_basics AS name ON name.name_id=col.director_name
WHERE collaboration >4
ORDER BY collaboration DESC

-- Distribution of actors who have experience as directors
/*
Methodology :
Filter for professions that include actor or director then counted the number of people with those professions.
*/


SELECT COUNT(name_id) AS total_actors
FROM name_basics
WHERE profession LIKE '%actor%' OR profession LIKE '%actress%'
-- Total number of actors : 5,315,614

SELECT COUNT(name_id) AS actor_director
FROM name_basics
WHERE (profession LIKE '%actor%' OR profession LIKE '%actress%') AND (profession LIKE '%director%')
-- Total number of actor-directors : 237,544