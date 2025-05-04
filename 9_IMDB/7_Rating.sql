/*
2. Rating
- Rating by genre
- Rating over the years
- Top-rated movies by year
- Top-rated movies by decade
- Worst movies by year
- Most rated movies : Explore rating and vote numbers

*/

-- Rating by genre
/*
Methodology :
To group by genre, first I unnested the genre column and created a CTE.
Using the CTE, join with the rating table on title_id to get ratings.
Group by genre, then calculate the average rating and show with 2 decimals.
For validity, filtered titles with more than 3630 votes. 

*/

WITH genre_explode_table AS(
SELECT title_id, 
       UNNEST (string_to_array(genres, ',')) AS genre_explode
FROM title_basics
)

SELECT  gr_explode.genre_explode AS Genre,
        ROUND(AVG(rating.avg_rating),2) AS Avg_Rating
FROM genre_explode_table AS gr_explode
LEFT JOIN title_rating_alter as rating
        ON gr_explode.title_id = rating.title_id
WHERE votes_num> 3630
GROUP BY Genre
ORDER BY Avg_Rating DESC;


-- Rating over the years
/*
Methodology :
Grouped movies by start_year and joined them with the rating table.
Calculate the average rating per year and show with 2 decimals.
For validity, filtered titles that has more than 3630 votes. 

*/

SELECT start_year AS released_year,
       ROUND(AVG(avg_rating),2) AS avg_rating
FROM title_basics
INNER JOIN title_rating_alter AS rating
            on title_basics.title_id = rating.title_id
WHERE votes_num> 3630
GROUP BY start_year;


-- Top-rated movies by year

/*
Methodology :
Join rating table with the year and title table.
Use a window function to select the maximum rating in the year.
Display title, year and top rating.
For further use, created View as top_rate_year

*/
CREATE VIEW top_rated_year AS 

SELECT primary_title, start_year, 
        MAX(avg_rating) OVER(PARTITION BY start_year) AS max_rating
FROM title_rating_alter AS rating
iNNER JOIN title_basics 
            ON rating.title_id = title_basics.title_id
WHERE votes_num>3630;

-- Top-rated movies by decade

/*
Methodology :
In this query I'll go through from 1980's to 2020's.
Created a 'decade' column to group movies by decade and named CTE as decade_rating.
From the CTE, find out the top rating movie for each decade by using window function.

*/

WITH decade_rating AS(
SELECT  *,
CASE
    WHEN start_year BETWEEN 1980 AND 1990 THEN '1980s'
    WHEN start_year BETWEEN 1990 AND 2000 THEN '1990s'
    WHEN start_year BETWEEN 2000 AND 2010 THEN '2000s' 
    WHEN start_year BETWEEN 2010 AND 2020 THEN '2010s'
    WHEN start_year BETWEEN 2020 AND 2030 THEN '2020s'
END AS decade
FROM top_rated_year
)

SELECT primary_title, decade,
        MAX(max_rating) OVER(PARTITION BY decade) AS rating
FROM decade_rating
WHERE decade IS NOT NULL;

-- Worst movies by year
/*
Methodology :
Join rating table with the year and title table.
Use a window function to select the minimum rating in the year.
Display title, year and lowest rating.

*/
SELECT primary_title, start_year, 
        MIN(avg_rating) OVER(PARTITION BY start_year) AS min_rating
FROM title_rating_alter AS rating
iNNER JOIN title_basics 
            ON rating.title_id = title_basics.title_id
WHERE votes_num>3630;
