-- import data

COPY job_list
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\6_UK_Job_python\job_list.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


COPY job_list
FROM 'C:\Users\Dell\DA_FILE\100_My_Project\6_UK_Job_python\job_list.csv'
DELIMITER ',' CSV HEADER;


/*
\copy skills_job_dim 
FROM '[Insert File Path]/skills_job_dim.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/