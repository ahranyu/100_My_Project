/*
4. Director
- Top directors by rating
- Directors and genres : Which genre they are famous for?
- Movies by the same director : Compare rating and genre
*/

-- Top directors by rating

/*
Methodology :
From title_crew table, unnest directors.
Join with title_rating using title_id to find out average rating for each directors.
Use vote number > 3630, and display top 50 directors.
Limit the directors who have more than 5 movies.
*/

WITH director_table AS(
SELECT title_crew_alter.title_id,title_rating_alter.avg_rating,
       UNNEST (string_to_array(directors, ',')) AS director_explode
FROM title_crew_alter
INNER JOIN title_rating_alter ON title_crew_alter.title_id= title_rating_alter.title_id
WHERE votes_num> 3630
)
SELECT  ROUND(AVG(avg_rating),2) AS avg_movies_rate, 
        primary_name AS director_name,
        COUNT(director_explode) AS movie_count
FROM director_table
LEFT JOIN name_basics ON director_table.director_explode=name_basics.name_id
GROUP BY primary_name
HAVING COUNT(director_explode) >5
ORDER BY avg_movies_rate DESC
LIMIT 50;

-- Directors and genres : Which genre are they famous for?
/*
Methodology :
FInd out the number of genres by each director, filtered for directors who have made more than 5 movies.
Create a CTE 'director_table' to unnest the 'directors' column, then left join with title_basic table to connect genres.
Create a second CTE 'director_count' to filter directors who made more than 5 movies.
Create a third CTE 'explode_table' to unnest genres. Also filter the table using the second CTE.
Finally, display the director's name, genres, and the total number of movies.
*/
WITH director_table AS(
SELECT crew.title_id, genres, UNNEST (string_to_array(directors, ',')) AS director_explode
FROM title_crew_alter AS crew 
LEFT JOIN title_basics AS basic ON crew.title_id = basic.title_id
WHERE genres IS NOT NULL

), director_count AS(
SELECT director_explode, COUNT(DISTINCT title_id)
FROM director_table
GROUP BY director_explode
HAVING COUNT(DISTINCT title_id) >5

), explode_table AS(
SELECT title_id, dcount.director_explode, UNNEST (string_to_array(genres, ',')) AS genre_explode
FROM director_table
INNER JOIN director_count AS dcount ON dcount.director_explode = director_table.director_explode

)
SELECT primary_name,genre_explode, COUNT (genre_explode) AS genre_count
FROM explode_table
INNER JOIN name_basics ON name_basics.name_id = explode_table.director_explode
GROUP BY primary_name,genre_explode
ORDER BY primary_name




-- Movies by the same director : Compare rating and genre

/*
Methodology :
Create a CTE 'director_table' to unnest the 'directors' column, then left join with title_basic table to connect genres.
Create a second CTE 'director_count' to filter directors who have made more than 5 movies.
Create a third CTE 'explode_table' to unnest genres. Also filter the table using second CTE.
Finally, perform inner join with the rating table to calculate the average rating per genre.
Display the director's name, genres, and the average rating of that genre.
*/
WITH director_table AS(
SELECT crew.title_id, genres, UNNEST (string_to_array(directors, ',')) AS director_explode
FROM title_crew_alter AS crew 
LEFT JOIN title_basics AS basic ON crew.title_id = basic.title_id
WHERE genres IS NOT NULL
), director_count AS(

SELECT director_explode, COUNT(DISTINCT title_id)
FROM director_table
GROUP BY director_explode
HAVING COUNT(DISTINCT title_id) >5
), explode_table AS(

SELECT title_id, dcount.director_explode, UNNEST (string_to_array(genres, ',')) AS genre_explode
FROM director_table
INNER JOIN director_count AS dcount ON dcount.director_explode = director_table.director_explode
)

SELECT name.primary_name, genre_explode, ROUND( AVG(avg_rating),2) AS avg_rating
FROM explode_table
INNER JOIN title_rating_alter AS rating ON rating.title_id = explode_table.title_id
INNER JOIN name_basics AS name ON name.name_id = explode_table.director_explode
GROUP BY name.primary_name, genre_explode
ORDER BY name.primary_name