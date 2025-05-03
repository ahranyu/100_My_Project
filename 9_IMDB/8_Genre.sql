/*

 3. Genre
- Top movies by genre
- Genre distribution by year

*/

-- Top movies by genre
/*
Methodology :
To find out the top-rated movies for each genre, created a new column called genre_explode.
To narrow down the number of movies, I limited year between 1980 and 2030.
Then I joined with the rating table to discover top-rated movies.
Display the result with title, genre, rating and year.
Use only more than 3630 votes rating.

*/

WITH genre_explode_table AS(
SELECT title_id, primary_title,start_year,
       UNNEST (string_to_array(genres, ',')) AS genre_explode
FROM title_basics
WHERE start_year BETWEEN 1980 AND 2030
)
SELECT  primary_title, genre_explode,start_year,
        MAX(avg_rating) OVER(PARTITION BY genre_explode) AS rating
FROM genre_explode_table AS gr_explode
INNER JOIN title_rating_alter AS rating ON rating.title_id = gr_explode.title_id
WHERE votes_num> 3630
ORDER BY genre_explode , start_year ;


-- Genre distribution by year
/*
Methodology :
Unnested genre and group them by year and genre. 
Display the total count of movies for each genre and year
*/


WITH genre_explode_table AS(
SELECT title_id, primary_title,start_year,
       UNNEST (string_to_array(genres, ',')) AS genre_explode
FROM title_basics
)
SELECT start_year, genre_explode,
        COUNT(genre_explode)
FROM genre_explode_table
WHERE start_year IS NOT NULL
GROUP BY start_year, genre_explode
ORDER BY genre_explode, start_year