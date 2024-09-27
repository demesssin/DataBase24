
 CREATE TABLE countries(
    country_id serial PRIMARY KEY,
    country_name varchar(200),
    region_id integer,
    poplation integer
);

INSERT INTO countries(country_name, region_id, poplation)
VALUES ('France',1, 66000000 );

SELECT * FROM countries;

INSERT INTO countries(country_id, country_name)
values (2, 'Italy');

UPDATE countries SET region_id = NULL;

UPDATE countries
SET country_id = DEFAULT;

INSERT INTO countries(COUNTRY_NAME, REGION_ID, POPLATION)
VALUES ('Russia', 1, 146000000),
       ('Turkiye,', 36, 85000000),
       ('Mongolia', 18, 3500000);

ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

INSERT INTO countries(region_id, poplation)
VALUES (58,4600000);

SELECT * FROM countries;

ALTER TABLE countries
ALTER COLUMN region_id SET DEFAULT 888,
ALTER COLUMN poplation SET DEFAULT 777;

CREATE TABLE countries_new (LIKE countries);

INSERT INTO countries_new (COUNTRY_ID, COUNTRY_NAME, REGION_ID, POPLATION)
SELECT country_id, country_name, region_id, poplation
FROM countries;

SELECT * FROM countries_new;

UPDATE countries_new SET region_id = 1
WHERE region_id IS NULL;

UPDATE countries_new SET poplation = poplation * 1.1;

SELECT country_name,
       poplation AS "NEW POPULATION"
FROM countries;

DELETE FROM countries
WHERE poplation < 100000;

DELETE FROM countries_new AS cn
USING countries AS c
WHERE cn.country_id = c.country_id
RETURNING *;

DELETE FROM countries
RETURNING *;
