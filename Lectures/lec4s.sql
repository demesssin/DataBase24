SELECT 1+3, 3*4;

CREATE TABLE actor(
    actor_id serial PRIMARY KEY,
    actor_name varchar(100),
    actor_region varchar(100)
);

SELECT * FROM actor;

INSERT INTO actor(actor_name, actor_region)
VALUES ('Peter Parker','Queens');

SELECT * FROM actor;

SELECT lower('HELLO'), upper('hello');

SELECT upper(actor_name) FROM actor;

SELECT actor_id, actor_name, 1+1,1+2 from actor;

SELECT ALL * FROM public.actor; /* public означает название схемы, должно было стоять lab3 но я создал все в Public схеме */

CREATE TABLE films(
    film_id serial,
    title varchar(50),
    length integer
);

INSERT INTO films(title, length)
VALUES ('Zharaly sezim', 84);

SELECT ALL * FROM films;

SELECT title, length + 10 AS "Length_Plus_Ten"
FROM films AS f;

INSERT INTO films(title, length)
VALUES ('Avengers', 120),
       ('Avengers', 120),
       ('Matrix Inception', 100),
       ('Zharaly sezim', 84);

SELECT DISTINCT ON (title) * FROM films;

SELECT DISTINCT * FROM films;

INSERT INTO actor(actor_name, actor_region)
VALUES ('Peter Parker', 'Queens'),
       ('Nurkhat', 'Aktau'),
       ('Nurkhat', 'Aktau'),
       ('Brad Pitt', 'Hollywood');

SELECT * FROM actor;

SELECT DISTINCT ON(actor_name, actor_region) * FROM actor;

SELECT DISTINCT ON(title) * FROM films
WHERE length < 120;

ALTER TABLE films
ADD COLUMN year integer;

UPDATE films SET year = 2012
WHERE title = 'Avengers';

UPDATE films SET year = 2007
WHERE title = 'Zharaly sezim';

UPDATE films SET year = 1999
WHERE title = 'Matrix Inception';

SELECT * FROM films;

SELECT DISTINCT ON (title) * FROM films
WHERE year < 2010;

CREATE TABLE films2(
    film_id serial,
    title varchar(100),
    rental_duration integer,
    length integer
);

INSERT INTO films2(TITLE, RENTAL_DURATION, LENGTH)
VALUES ('Film A', 3, 100),
       ('Film B', 3, 120),
       ('Film C', 5, 90),
       ('Film D', 5, 110),
       ('Film E', 3, 130);

SELECT * FROM films2;

SELECT rental_duration, max(length), sum(length)
FROM films2
GROUP BY rental_duration; /* Тут воедино объединили столбцы rental_duration с одинаковым значением
                             Также вывели максимальную длину среди значений в rental_duration и сумму их длин*/

ALTER TABLE films2
ADD COLUMN rate float;

UPDATE films2
SET rate = 3.7
WHERE rental_duration = 3;

UPDATE films2
SET rate = 4.99
WHERE rental_duration = 5;

SELECT rental_duration,  max(length), sum(length), sum(rate)
FROM films2
GROUP BY rental_duration;

SELECT sum(length)
FROM films2
WHERE rental_duration = 5;

INSERT INTO films2(title, rental_duration, length)
VALUES ('Film F', 7, 108),
       ('Film G', 7, 112);

UPDATE films2
SET rate = 3.88
WHERE rental_duration = 7;

SELECT * FROM films2;

SELECT rental_duration, max(length), sum(length), avg(rate), min(length)
FROM films2
group by rental_duration
having sum(length) > 200;

SELECT * FROM films2
WHERE length > 80
UNION
SELECT * FROM films2
WHERE length <= 110;

SELECT * FROM films2
WHERE length > 80 and length < 120;

SELECT * FROM films2
WHERE length > 80
INTERSECT ALL
SELECT * FROM films2
WHERE length < 110;

SELECT * FROM films2
WHERE length > 100
EXCEPT ALL              /* В этот запрос попадают все данные которые НЕ УДОВЛЕТВОРЯЮТ условию больше 100 но не меньше 120*/
SELECT * FROM films2
WHERE length < 120;

SELECT * FROM films2
WHERE length > 100 and not length < 120;

SELECT * FROM films2
ORDER BY length asc; /* cортирует по возрастанию */

SELECT * FROM films2
ORDER BY length desc; /* сортирует по убыванию */

SELECT * FROM films2
ORDER BY length asc, rental_duration desc, rate;

CREATE TABLE addres(
    address_id serial,
    address varchar(50),
    address2 varchar(50)
);

INSERT INTO addres(address, address2)
VALUES ( 'Street 2', 'Jan 15'),
    ('Ozal 3', 'Sep 1'),
    ('Karimov 70', 'Sept 3'),
    ('Kamysty 22', 'Apr 23'),
    ('Ducat 17', 'Dec 29');

SELECT * FROM addres;

select * from addres
order by address2 asc;

UPDATE addres
SET address2 = 'NULL'
WHERE address2 IN('Sep 1', 'Sept 3');

select * from addres
order by address2 ASC NULLS FIRST;

select * from films2
order by length desc
limit 2 offset 3;   /* Запрос выведет только 2 строки после 3-ей строки */

select * from films2
where length =
      ( select length
        from films2
        order by length desc
        limit 1 offset 2);