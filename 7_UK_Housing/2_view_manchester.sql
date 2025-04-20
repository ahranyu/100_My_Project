CREATE VIEW manchester_rent AS

WITH manchester AS(

SELECT 
CASE 
	WHEN postal_code LIKE'%M%' THEN 'Manchester'
	ELSE 'elsewhere'
END AS location,
*
FROM cleaned_pro
)

SELECT *
FROM manchester 
WHERE LOCATION = 'Manchester'