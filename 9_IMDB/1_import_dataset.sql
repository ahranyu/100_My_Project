COPY name_basics
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\9_IMDB\name.basics.tsv'
WITH (HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

COPY title_akas
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\9_IMDB\title.akas.tsv'
WITH (HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

COPY title_basics
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\9_IMDB\title.basics.tsv'
WITH (HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

COPY title_crew
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\9_IMDB\title.crew.tsv'
WITH (HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

COPY title_episode
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\9_IMDB\title.episode.tsv'
WITH (HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

COPY title_principal
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\9_IMDB\title.principals.tsv'
WITH (HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

COPY title_rating
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\9_IMDB\title.ratings.tsv'
WITH (HEADER true, DELIMITER E'\t', ENCODING 'UTF8');

