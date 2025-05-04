/*
 1. Runtime
- Runtime by genre
- Runtime over the years
- Is there a relationship between runtime and rating?

*/

-- Runtime by genre

/*
Methodology :
Create a CTE to split genres into individual rows using UNNEST and assigned as genre_explode_table.
Calculated the average of runtime by genre, and display genre name with its corresponding average runtime
*/

WITH genre_explode_table AS(
SELECT title_id, runtime_min,
       UNNEST (string_to_array(genres, ',')) AS genre_explode
FROM title_basics
)

SELECT genre_explode,
       ROUND(AVG(runtime_min),2) AS average_runtime
FROM genre_explode_table
GROUP BY genre_explode
ORDER BY average_runtime DESC;

-- Runtime over the years

/*
Methodology :
Grouped movies by year and calculated the average runtime for each year
*/

SELECT start_year,
       percentile_cont(0.5) WITHIN GROUP (ORDER BY runtime_min) AS avg_runtime
FROM title_basics
WHERE runtime_min IS NOT NULL
GROUP BY start_year


-- Is there a relationship between runtime and rating?
/*
Methodology :
Filtered where runtime is not null and number of votes is greater than 3630.
Joined the ratings and runtime tables on title_id, and created a CTE as runtime_rating.
Calculated the average rating for each runtime

*/

WITH runtime_rating AS(
SELECT title_basics.title_id,
        runtime_min,
        title_rating_alter.avg_rating
FROM title_basics
INNER JOIN title_rating_alter ON title_basics.title_id = title_rating_alter.title_id
WHERE runtime_min IS NOT NULL AND (title_rating_alter.votes_num >3630)
)

SELECT runtime_min, percentile_cont(0.5) WITHIN GROUP(ORDER BY avg_rating) AS average_rating 
FROM runtime_rating
GROUP BY runtime_min