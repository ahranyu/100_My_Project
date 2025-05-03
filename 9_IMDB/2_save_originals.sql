-- Save original tables
-- title_episode table will not be used to focus on movie dataset

CREATE TABLE name_basics_backup AS
SELECT * FROM name_basics;

CREATE TABLE title_akas_backup AS
SELECT * FROM title_akas;

CREATE TABLE title_basics_backup AS
SELECT * FROM title_basics;

CREATE TABLE title_crew_backup AS
SELECT * FROM title_crew;

CREATE TABLE title_principal_backup AS
SELECT * FROM title_principal;

CREATE TABLE title_rating_backup AS
SELECT * FROM title_rating;


SELECT*
FROM name_basics
LIMIT 100;

SELECT*
FROM title_akas_alter
LIMIT 100;

SELECT*
FROM title_basics
LIMIT 100;


SELECT*
FROM title_crew_alter
LIMIT 100;

SELECT*
FROM title_principal_alter
LIMIT 100;

SELECT*
FROM title_rating_alter
LIMIT 100;