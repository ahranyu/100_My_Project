DROP TABLE properties;

CREATE TABLE properties (
    
    price DECIMAL,
    per TEXT,
    monthly DECIMAL,
    property_type VARCHAR(100),
    postal_code VARCHAR(50),
    available TEXT,
    minimum_term INT,
    maximum_term INT,
    furnishings VARCHAR(50),
    parking TEXT,
    garage TEXT,
    garden_terrace TEXT,
    balcony_patio TEXT,
    disabled_access TEXT,
    living_room TEXT,
    broadband TEXT,
    couples TEXT,
    smoking TEXT,
    pets TEXT,
    occupation VARCHAR(100),
    reference TEXT,
    gender VARCHAR(50),
    vegetarian TEXT,
    min_age TEXT,
    max_age TEXT 
)
;
ALTER TABLE public.properties  OWNER to postgres;



ALTER TABLE public.properties
ADD COLUMN property_id SERIAL;

ALTER TABLE public.properties
ADD CONSTRAINT property_id_pkey PRIMARY KEY (property_id);


