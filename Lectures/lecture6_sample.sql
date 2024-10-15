create database lecture_6;


drop table products;
create table products
(
    id    serial,
    name  varchar(200),
    price integer check ( price > 0 ) default 100
);


insert into products (name, price)
VALUES ('Coke', 100);
insert into products (name, price)
VALUES ('Coke', 0);
insert into products (name, price)
VALUES ('Pepsi', 100);

select *
from products;

select *
from pg_constraint;


drop table products;
create table products
(
    id    serial,
    name  varchar(200) check ( char_length(name) > 3 ),
    price integer check ( price > 0 ) default 100
);


insert into products (name, price)
VALUES ('Coke', 100);
insert into products (name, price)
VALUES ('asdd', 100);


drop table products;
create table products
(
    id             serial,
    name           varchar(200) check ( char_length(name) > 3 ), -- если ограничитель проверяет лишь одним столбец
    -- правильнее будет ставить его только возле нужного столбца как тут
    price          integer check ( price > 0 ) default 100,
    discount_price integer,
    check (price > discount_price) -- ограничитель CHECK проверяет столбец на условие заданное внутри ограничителя
    -- ограничитель можно поставить в самом конце инициализации столбцов если оно касается нескольких столбцом
);


insert into products (name, price, discount_price)
VALUES ('Coke', 100, 100);

insert into products (name, price, discount_price)
VALUES ('Coke', 100, 90);



drop table products;
create table products
(
    id             serial,
    name           varchar(200) not null,
    price          integer,
    discount_price integer
);



select *
from pg_constraint;



drop table products;
create table products
(
    id             serial,
    name           varchar(200) not null unique,
    price          integer unique,
    discount_price integer
);



insert into products (name, price, discount_price)
VALUES ('Coke', 100, 90);

insert into products (name, price, discount_price)
VALUES ('Coke2', 100, 90); -- выдаст ошибку потому что мы поставили ограничитель который
-- проверяет ненулевное и уникальное значение я столбца



drop table products;
create table products
(
    id             serial,
    name           varchar(200) not null,
    price          integer,
    discount_price integer,
    unique (name, price)
);


insert into products (name, price, discount_price)
VALUES ('Coke', 100, 90);

insert into products (name, price, discount_price)
VALUES ('Coke', 101, 90);

insert into products (name, price, discount_price)
VALUES ('Coke', 100, 90);

insert into products (name, price, discount_price)
VALUES ('Coke2', 100, 90);

select *
from products;



drop table products;
create table products
(
    id             serial,
    name           varchar(200) not null,
    price          integer,
    discount_price integer,
    primary key (name, price) -- Ограничители UNIQUE NOT NULL и PRIMARY KEY - Выполняют по своей сути одно и то же
);



select *
from pg_constraint;



drop table products CASCADE;
create table products
(
    id    serial primary key,
    name  varchar(200) not null,
    price integer
);

create table orders
(
    id         serial primary key,
    product_id integer references products (id),
    quantity   integer
);


insert into products (name, price)
VALUES ('Coke', 100),
       ('Pepsi', 150),
       ('Fanta', 200);


select *
from products;

insert into orders (product_id, quantity)
values (1, 10),
       (2, 5),
       (3, 7);

insert into orders (product_id, quantity)
values (null, 10);

select *
from orders;

select *
from pg_constraint;



create table category
(
    id        serial primary key,
    name      varchar,
    parent_id integer references category (id)
);

DROP TABLE orders;

CREATE TABLE products(
    id integer PRIMARY KEY,
    name text,
    price numeric
);

create table orders(
    order_id integer PRIMARY KEY,
    id integer references products(id),
    quantity integer
);

insert into products VALUES (1, 'Fanta', 450),
                            (2, 'Saryagash', 250),
                            (3, 'Coffee', 960);

select * from products;

insert into orders values (1, 3, 10), -- в чем суть внешнего ключа?
                          -- если бы значения product_id были числами которые не равны ни одному значения
                          -- id из products, то код бы вывел ошибку, так как id из orders ссылается на id из products
                          (2, 1, 7),
                          (3, 2, 15);

create table c(
    c1 integer,
    c2 integer,
    c3 integer,
    primary key (c1, c2) -- Составной ключ для выдачий первичного ключа сразу нескольим столбцам
);

drop table c;

create table t1(
    a integer primary key,
    b integer,
    c integer,
    foreign key (b, c) references c(c1, c2) -- то же самое что мы делали в таблице orders
    -- мы тут просто добавили несколько столбцов, в таких случае мы не должны забывать приписывать FOREIGN KEY
);

insert into c values (1, 3, 5),
                     (2, 4, 6),
                     (3, 7, 9);

insert into t1 values (13, 1, 3), -- если вместо тройки поставить другое число код не сработает, то же самое
                      -- будет и с остальными таблицами потому что значение c не будет удовлетворять ссылке на с2,
                      -- а если быть точнеее, то b = c1 && c == c2
                      (99, 2, 4),
                      (66, 3, 7);

drop table t1;

/*
 Таблица может содержать более одного ограничения по внешнему ключу.
• Это используется для реализации связей "многие ко многим
" между таблицами.
• Допустим, у вас есть таблицы о продуктах и заказах, но теперь
вы хотите разрешить одному заказу содержать, возможно, много
продуктов
 */

drop table products cascade;
drop table orders;

create table products(
    id integer PRIMARY KEY,
    name text,
    price numeric
);

create table orders(
    order_id integer primary key,
    shipping_address text,
    status integer
);

create table order_items(
    id integer references products,
    order_id integer references orders,
    quantity integer,
    primary key (id, order_id)
);

insert into products values (1,'Macbook', 739990),
                            (2, 'Processor Core I9',179990 ),
                            (3, 'RTX 3080', 790990);

insert into orders(order_id, shipping_address, status)
values (1, 'Palo Alto', 1),
       (2, 'New York', 2);

insert into order_items(id, order_id, quantity)
values (1, 1, 2),
       (2, 1,1),
       (3, 2, 4);

select o.order_id, o.shipping_address, p.name, oi.quantity
from order_items oi
join orders o on oi.order_id = o.order_id
join products p on oi.id = p.id;