-- Before begin the analysis, remove unnecessary columns based on analysis plan
ALTER TABLE name_basics
DROP COLUMN birth_y,
DROP COLUMN death_y;

ALTER TABLE title_akas
DROP COLUMN language,
DROP COLUMN types,
DROP COLUMN attributes,
DROP COLUMN original_title;

ALTER TABLE title_basics
DROP COLUMN adult;

ALTER TABLE title_principal
DROP COLUMN job_title,
DROP COLUMN characters;

ALTER TABLE title_crew
DROP COLUMN writers;

-- Focus on movie dataset, drop other types

DELETE FROM title_basics
WHERE title_types!='movie';

DELETE FROM title_basics
WHERE genres LIKE '%Adult%';

CREATE TABLE title_akas_alter AS
SELECT title_akas.*
FROM title_akas
INNER JOIN title_basics on title_basics.title_id=title_akas.title_id;

CREATE TABLE title_crew_alter AS
SELECT title_crew.*
FROM title_crew
INNER JOIN title_basics on title_basics.title_id=title_crew.title_id;


CREATE TABLE title_principal_alter AS
SELECT title_principal.*
FROM title_principal
INNER JOIN title_basics on title_basics.title_id=title_principal.title_id;

CREATE TABLE title_rating_alter AS
SELECT title_rating.*
FROM title_rating
INNER JOIN title_basics on title_basics.title_id=title_rating.title_id;
