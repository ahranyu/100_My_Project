-- replace value to monthly rent

UPDATE properties 
SET price=monthly
WHERE monthly IS NOT NULL;

-- drop columns that used for monthly rent calculation
ALTER TABLE properties 
DROP column per;

ALTER TABLE properties 
DROP column  monthly;
-------------------------------------

SELECT *
FROM properties;

-- change date for calculation of remaining date before move-in

UPDATE properties
SET available = '16/04/2023'
WHERE available = '0';

------------------
CREATE VIEW cleaned_pro AS

SELECT 
price,
property_type ,
postal_code,
available,
available::date - '2023-04-16' AS till_move_in_day,
minimum_term ,
maximum_term,
furnishings,
occupation,
gender,
min_age ,
max_age,
property_id 

FROM properties

