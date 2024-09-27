CREATE DATABASE lab1;

CREATE TABLE IF NOT EXISTS users(
    id serial,
    firstname varchar(50),
    lastname varchar(50)
);

ALTER TABLE users
ADD COLUMN isadmin int;

ALTER TABLE users
ALTER COLUMN isadmin TYPE BOOLEAN USING isadmin::boolean;

ALTER TABLE users
ALTER COLUMN isadmin SET DEFAULT FALSE;

ALTER TABLE users
ADD CONSTRAINT users_pkey PRIMARY KEY (id);

CREATE TABLE tasks(
    id serial,
    name VARCHAR(50),
    user_id INT
);

SELECT * FROM users;


