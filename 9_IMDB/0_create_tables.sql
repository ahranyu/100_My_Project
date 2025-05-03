
CREATE TABLE public.name_basics
(   name_id TEXT PRIMARY KEY,
    primary_name TEXT,
    birth_y INTEGER,
    death_y INTEGER,
    profession TEXT,
    known_title TEXT
    
);


CREATE TABLE public.title_akas
(   title_id TEXT,
    order_num INTEGER,
    title TEXT,
    region TEXT,
    language TEXT,
    types TEXT,
    attributes TEXT,
    original_title BOOLEAN
    
);




CREATE TABLE public.title_basics
(   title_id TEXT PRIMARY KEY,
    title_types TEXT,
    primary_title TEXT,
    original_title TEXT,
    adult BOOLEAN,
    start_year INTEGER,
    end_year INTEGER NULL,
    runtime_min NUMERIC,
    genres TEXT
    
);
CREATE TABLE public.title_crew
(   title_id TEXT PRIMARY KEY,
    directors TEXT,
    writers TEXT
    
);

CREATE TABLE public.title_episode
(   episode_id TEXT PRIMARY KEY,
    parent_tv_id TEXT,
    season_num INTEGER,
    ep_num INTEGER
    
);

CREATE TABLE public.title_principal
(   title_id TEXT,
    order_num INTEGER,
    name_id TEXT,
    category TEXT,
    job_title TEXT,
    characters TEXT
);

CREATE TABLE public.title_rating
(   title_id TEXT PRIMARY KEY,
    avg_rating NUMERIC,
    votes_num NUMERIC
);

-- Set ownership of the tables to the postgres user
ALTER TABLE public.name_basics OWNER to postgres;
ALTER TABLE public.title_akas OWNER to postgres;
ALTER TABLE public.title_basics OWNER to postgres;
ALTER TABLE public.title_crew OWNER to postgres;
ALTER TABLE public.title_episode OWNER to postgres;
ALTER TABLE public.title_principal OWNER to postgres;
ALTER TABLE public.title_rating OWNER to postgres;
