
CREATE TABLE public.job_list
(   
    job_title TEXT,
    commpany_name TEXT,
    salary NUMERIC,
    rating NUMERIC,
    skills TEXT,
    job_location TEXT,
    Industry TEXT,
    sector TEXT,
    revenue TEXT,
    employee_size TEXT,
    ownership_type TEXT
);


-- Set ownership of the tables to the postgres user
ALTER TABLE public.job_list OWNER to postgres;

DROP TABLE job_list

-- Creat index row as primary key
ALTER TABLE public.job_list
ADD COLUMN job_index SERIAL;

ALTER TABLE public.job_list
ADD CONSTRAINT job_list_pkey PRIMARY KEY (job_index);


SELECT*
FROM job_list