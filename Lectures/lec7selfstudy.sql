
create table language(
    language_id SERIAL primary key,
    name varchar(50) not null,
    last_update timestamp not null default current_timestamp
);

create table film(
    film_id serial primary key,
    title varchar(255) not null,
    description text,
    release_year integer,
    language_id integer references language(language_id),
    length integer,
    last_update timestamp not null default current_timestamp
);

create table country(
    country_id serial primary key,
    country_name varchar(50) not null,
    last_update timestamp not null default current_timestamp
);

create table city(
    city_id serial primary key,
    city_name varchar(50) not null,
    country_id integer references country(country_id),
    last_update timestamp not null default current_timestamp
);

INSERT INTO language (name) VALUES
('English'),
('Spanish'),
('French'),
('German'),
('Italian');

INSERT INTO film (title, description, release_year, language_id, length) VALUES
('Inception', 'A mind-bending thriller', 2010, 1, 148),
('Parasite', 'A dark comedy thriller', 2019, 3, 132),
('The Godfather', 'Crime family saga', 1972, 1, 175),
('Amelie', 'A whimsical French tale', 2001, 3, 122),
('Life is Beautiful', 'Heartwarming WWII story', 1997, 5, 116);

INSERT INTO country (country_name) VALUES
('USA'),
('France'),
('Germany'),
('Italy'),
('Spain');

INSERT INTO city (city_name, country_id) VALUES
('New York', 1),
('Los Angeles', 1),
('Paris', 2),
('Berlin', 3),
('Rome', 4),
('Madrid', 5);


select * from language;
select * from film;
select * from country;
select * from city;

select * from film
cross join language; -- делает Декартово произведение двух таблиц
-- Это означает, что каждая строка первой таблицы соединяется с каждой строкой второй таблицы,
-- создавая комбинацию всех возможных строк.

select *
from film
         inner join language on true; -- этот запрос логически повторяет то же самое что и cross join

select *
from film f
         join language l on f.language_id = l.language_id;
   -- and f.last_update = l.last_update;

drop table language cascade;
drop table city;
drop table country;
drop table film;

select *
from film
natural join language;

select distinct * from film;
select distinct * from language;

select *
from city c
         left join country cc on c.country_id = cc.country_id;

select * from city c
left join country cc using(country_id);

select *
from city c
         right join country cc on c.country_id = cc.country_id;

select * from city c
full join country cc on c.country_id = cc.country_id;

select *
from film f
inner join language l on f.language_id = l.language_id and length < 130;

select * from film f
inner join language l on f.language_id = l.language_id where length < 130;

select * from film f
left join language l on f.language_id = l.language_id and length < 130;

select * from film f
left join language l on f.language_id = l.language_id where length < 130;