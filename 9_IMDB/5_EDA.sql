/*
0. EDA
- Number of movies released per year
- Average rating
- Distribution of genres
- Most widely released film (Number of countries in which it was released)

*/

-- Number of movies released per year
/*
Methodology :
Group movies by start_year, then count total number of movie for each start_year 
*/

SELECT 
start_year AS released_year,
COUNT(title_id) AS number_of_movie
FROM title_basics
GROUP BY start_year;

-- Average rating
/*
Methodology :
Calculate average vote number.
Filter data that has more than average vote number(3630) for valid analysis.
Calculate average rating (2 decimal) , maximum rating, minimum rating
*/

SELECT AVG(votes_num)
FROM title_rating_alter;

SELECT ROUND(AVG(avg_rating),2) AS avg_rating,
       MAX(avg_rating) AS max_rating, 
       MIN(avg_rating) AS min_rating
FROM title_rating_alter
WHERE votes_num > 3630;

-- Distribution of genres
/*
Methodology :
Create CTE to explode genres to each row and assigned as genre_explode_table.
Count number of each genre and display with genre name, and total number as descending order.

*/

WITH genre_explode_table AS(
SELECT title_id, 
       UNNEST (string_to_array(genres, ',')) AS genre_explode
FROM title_basics
)

SELECT genre_explode,
       COUNT(genre_explode) 
FROM genre_explode_table
GROUP BY genre_explode
ORDER BY COUNT(genre_explode) DESC;


-- Most widely released film (Number of countries in which it was released)
/*
Methodology :
Create CTE to count released countries for each movie and show top 30 movies by count.
To show the title, use left join with title_basics table and display title and total number of release country by descending order
*/

WITH released_country AS(
SELECT title_id, COUNT(region) AS country_count
FROM title_akas_alter
GROUP BY title_id
ORDER BY COUNT(region) DESC
LIMIT 30
)
SELECT title_basics.primary_title AS movie_title,
       released_country.country_count AS released_country_number
FROM released_country
LEFT JOIN title_basics ON released_country.title_id = title_basics.title_id


;