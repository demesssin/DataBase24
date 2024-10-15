CREATE TABLE film (
    film_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    -- description TEXT,
    -- short_desc TEXT,
    release_year INTEGER,
    length INTEGER,  -- Длина фильма в минутах
    rental_duration INTEGER,  -- Продолжительность аренды
    rental_rate DECIMAL(4, 2),  -- Стоимость аренды
    language_id INTEGER,  -- Язык фильма
    original_language_id INTEGER  -- Оригинальный язык фильма (nullable)
    --special_features TEXT[]  -- Специальные функции фильма (массив строк)
);

INSERT INTO film (title, release_year, length, rental_duration, rental_rate, language_id, original_language_id)
VALUES
    ('The Matrix', 1999, 136, 5, 2.99, 5, null),
    ('Finding Nemo', 2003, 100, 4, 2.50, 3, null),
    ('Pulp Fiction', 1994, 154, 7, 3.99, 5, 1),
    ('Inception', 2010, 148, 5, 3.00, 1, null),
    ('Toy Story', 1995, 81, 6, 2.50, 1, null),
    ('Casablanca', 1942, 102, 5, 2.99, 2, 3),
    ('The Godfather', 1972, 175, 5, 4.00, 1, 2),
    ('Avengers: Endgame', 2019, 181, 4, 3.99, 1, 2);

drop table film cascade;

CREATE TABLE actor (
    actor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE test (
    value1 INTEGER,
    value2 VARCHAR(255)
);

INSERT INTO test (value1, value2)
VALUES
    (1, 'First test'),
    (2, 'Second test'),
    (3, 'Third test'),
    (4, 'Fourth test'),
    (5, 'Fifth test');


INSERT INTO actor (first_name, last_name)
VALUES
    ('Keanu', 'Reeves'),
    ('Tom', 'Hanks'),
    ('Samuel', 'Jackson'),
    ('Leonardo', 'DiCaprio'),
    ('Robin', 'Williams'),
    ('Marlon', 'Brando'),
    ('Robert', 'De Niro'),
    ('Chris', 'Evans');

drop table film_actor;

CREATE TABLE film_actor (
    film_id INTEGER REFERENCES film(film_id),
    actor_id INTEGER REFERENCES actor(actor_id),
    PRIMARY KEY (film_id, actor_id)
);

INSERT INTO film_actor (film_id, actor_id)
VALUES
    (1, 1),  -- The Matrix, Keanu Reeves
    (2, 2),  -- Finding Nemo, Tom Hanks
    (3, 3),  -- Pulp Fiction, Samuel Jackson
    (4, 4),  -- Inception, Leonardo DiCaprio
    (5, 5),  -- Toy Story, Robin Williams
    (6, 6),  -- Casablanca, Marlon Brando
    (7, 7),  -- The Godfather, Robert De Niro
    (8, 2), -- -- Avengers: Endgame, Chris Evans
    (1,2);

select *
from film
where not ((length > 100
    and rental_duration < 5)
    or (length < 50 and rental_duration > 7));

select *
from film
where language_id <> 5;

select * from film
where length between 100 and 136;

select * from film
where length >= 100 and length <= 136;

select * from film
where length not between 100 and 136;

select * from film
where length < 100 or length > 136;

select * from film
where original_language_id IS NULL;

select * from film
where length is not distinct from 50;

select ceil(4.35); -- округляет в большую сторону
select floor(4.35); -- округляет в меньшую сторону
select round(4.35, 1); -- выполняет округление числа 4.35 до одного знака после запятой.
select trunc(4.1234, 2); -- оставляет нужное число после запятой не округляя, то есть он срезал 2 числа с конца

select setseed(0.1);
select floor(random() * 16);

select 'The film: ' || title || ' Was released in: ' || release_year
from film;

select bit_length('Demessin');
select octet_length('Demessin  ');
select char_length('Demessin')

select * from test;

select char_length(value2), octet_length(value2)
from test;

select title,
       overlay(title placing 'asd' from 3 for 5), -- вставляет строку начиная с 3 го символа до 5-го
       position('ab' in title), -- находит позицию строки
       substring(title from 3 for 5), -- режет строку с 3 символа по 5-ый
       substr(title, 3, 5), -- укороченная версия substring
       trim(both 'Ao' from title) -- удаляет буква А с начала если она есть и букву о

from film;

select format('The film: %s was released in %s', title, release_year)
from film;


select *
from actor
where first_name like '_e%n_';

select *
from actor
where first_name like '%C%';

select to_char(4.1234, '999D9999S');
select to_char(444.124, '999D99999S');

select to_date('05 12 2020', 'DD MM YYYY');

select length,
       case
           when length < 60 then 'Short film'
           when length between 60 and 100 then 'Medium film'
           else 'Long film'
           end
from film;


select rental_duration,
       case rental_duration
           when 3 then 'Short'
           when 4 then 'Medium'
           else 'Long'
           end
from film;

select coalesce(null, 1, 2, 3, null); -- выводит первое ненулевое значение

select coalesce(original_language_id, -1) -- вставляет -1 вместо строк равныз Null
from film;

select nullif(1, 1); -- если два значения равны выводит нулл, если нет то первое значение

select nullif(coalesce(original_language_id, -1), -1)
from film; -- вставляет null вместо строк где мы поставили -1

select greatest(1, 4, 5, 10, 1), -- тут идет поиск по строке
       least(1, 4, 5, 10, 1), -- тут тоже самое
       max(length), -- тут идет агрегирование по столцу то есть сверху вниз
       min(length) -- тут идентично как с max
from film;

select length,
       rental_duration * 20,
       rental_rate * 20,
       greatest(length, rental_duration * 20, rental_rate * 20),
       least(length, rental_duration * 20, rental_rate * 20)
from film;

select max(length), min(length)
from film;

select length
from film;

create table test2
(
    asd int[]
);

SELECT t.num, word
FROM unnest(array [[1, 2, 3, 10], [1, 2, 3, 10]], array ['asd', 'qwe', '123']) AS t(num, word);
-- этот запрос выведет все элементы массива построчно

select max(length),
       min(length),
       sum(length),
       count(*),
       avg(length),
       array_agg(title),
       json_agg(title),
       string_agg(title, ';')
from film;

select *
from actor a
where exists(select fa.actor_id
             from film_actor fa
             where a.actor_id = fa.actor_id
             group by fa.actor_id
             having count(*) > 1); -- показывает актеров снявшихся в больше чем одном фильме

select * from actor a
where actor_id not in(
    select fa.actor_id
             from film_actor fa
             where a.actor_id = fa.actor_id
             group by fa.actor_id
             having count(*) > 1
    );


select *
from actor
where actor_id <= some (select actor_id
                       from film_actor
                       group by actor_id
                       having count(*) > 1);

create table my_toys(
    toy_id serial primary key,
    my_toy integer
);

create table friends_toys(
    toy_id serial primary key,
    friends_toy integer
);

insert into my_toys(my_toy)
values (4),
       (6),
       (8);

insert into friends_toys(friends_toy)
values (2),
       (3),
       (7);

select * from friends_toys
where friends_toy > 5;

select * from my_toys
where my_toy < some (
    select friends_toys.friends_toy
    from friends_toys
    );

select * from my_toys
where my_toy > some (
    select friends_toys.friends_toy
    from friends_toys
    );

select *
from actor
where actor_id > all (select actor_id
                      from film_actor
                      group by actor_id
                      having count(*) > 1);

select *
from actor
where actor_id < all (select actor_id
                      from film_actor
                      group by actor_id
                      having count(*) > 1);