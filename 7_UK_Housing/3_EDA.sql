--EDA

/* Questions to Answer: Manchester rent
 * 1. Student housing prices by property type
 * 2. Average number of days until move-in availability
 * 3. Average price by property type and the most frequently listed property type
 * 4. Is there a popular area based on postal codes?
 * 5. Gender preference in housing?
 * 
 * */


SELECT *
FROM manchester_rent
;
 -- 1. Student housing prices by property type


SELECT 
ROUND(AVG(price),2) AS avg_rent, 
property_type
FROM manchester_rent
WHERE occupation = 'Student'
GROUP BY property_type;

-- 2. Average number of days until move-in availability


SELECT 
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY till_move_in_day) AS avg_days_left

FROM manchester_rent

WHERE till_move_in_day  != 0
;


-- 3. Average price by property type and the most frequently listed property type

SELECT
ROUND(AVG(price),2) AS avg_rent,
property_type,
COUNT(property_id) AS post_count
FROM manchester_rent
GROUP BY property_type 
ORDER BY avg_rent DESC

;


-- 4. Is there a popular area based on postal codes?

SELECT
ROUND(AVG(price),2) AS avg_rent,
postal_code,
COUNT(postal_code) AS area_count
FROM manchester_rent
GROUP BY postal_code
ORDER BY area_count DESC

;

-- 5. Gender preference in housing?
 SELECT 
 gender,
 Count(property_id )
 FROM manchester_rent
 GROUP BY gender 
