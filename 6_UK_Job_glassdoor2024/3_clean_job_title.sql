SELECT cleaned_job_title, job_title
FROM job_list

-- clean job title
-- junior, senior, data jobs only +software engineer



ALTER TABLE job_list
ADD COLUMN cleaned_job_title TEXT;


UPDATE job_list
SET cleaned_job_title = INITCAP(
    TRIM(
        CONCAT(
            -- Add prefix if found
            CASE
                WHEN job_title ILIKE '%senior%' THEN 'Senior '
                WHEN job_title ILIKE '%junior%' THEN 'Junior '
                ELSE ''
            END,
            -- Standardize base title
              CASE
                WHEN job_title ILIKE '%data%' AND job_title ILIKE '%analyst%' THEN 'Data Analyst'
                WHEN job_title ILIKE '%data%' AND job_title ILIKE '%engineer%' THEN 'Data Engineer'

                WHEN job_title ILIKE '%data%' AND job_title ILIKE '%scientist%' THEN 'Data Scientist'
            
                WHEN job_title ILIKE '%data%' AND job_title ILIKE '%specialist%' THEN 'Data Specialist'
                WHEN job_title ILIKE '%software%' AND job_title ILIKE '%engineer%' THEN 'Software Engineer'
                ELSE ' '
            END
        )
    )
);






