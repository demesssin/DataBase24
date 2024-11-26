
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    commission NUMERIC(4, 2)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    grade INT,
    salesman_id INT REFERENCES salesman(salesman_id)
);

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt NUMERIC(10, 2),
    ord_date DATE,
    customer_id INT REFERENCES customers(customer_id),
    salesman_id INT REFERENCES salesman(salesman_id)
);

-- Заполнение таблицы "salesman"
INSERT INTO salesman (salesman_id, name, city, commission)
VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knit', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'New York', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

-- Заполнение таблицы "customers"
INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

-- Заполнение таблицы "orders"
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760.0, '2012-09-10', 3002, 5001);



create function inc(a integer) returns integer as
    $$
    begin
        return a + 1;
    end;
    $$ language plpgsql;

select inc(5); -- выведет 6
select inc(inc(5)); -- выведет 7 так как это двойной вызов

create or replace function get_sum(in a numeric, b numeric) returns numeric as
                                    -- разницы писать in тут нет или нет бессмысленно
                                    -- выйдет все равно одно и то же
    $$
    begin
        return a + b;
    end;
    $$ language plpgsql;

select * from get_sum(5, 6);
select get_sum(5, 6);

create or replace  function get_sum(in a numeric, b numeric) returns numeric as
    $$
    begin
        return (a + b) * 2;
    end;
    $$ language plpgsql;

select get_sum(5, 6); -- из за replace мы можем пересоздать функцию, и при вызове гет_сум выводится результат
-- последней созданной функции


create or replace function hi_lo(a numeric, b numeric, c numeric, out hi numeric, out lo numeric)
as                                                              -- out означает что мы как будто создаем переменную
                                                                -- которая будет выводить значение с типом numeric

    $$
    begin
        hi := greatest(a, b, c);
        lo := least(a, b ,c );
    end;
    $$ language plpgsql;

select hi_lo(57, 98, 144);
select * from hi_lo(45454545, 2146214612642, 448946516);


create function square(inout a numeric) as
    $$
    begin
        a = a * a;
    end;
    $$ language plpgsql;

drop function square(a numeric);

select *
from square(14);

select * from square(square(14)); -- делает двойной квадрат во вложенном случае

create or replace function sum_avg(variadic list numeric[], out total numeric, out average numeric)
as
$$
BEGIN
    select into total sum(unnest) from unnest(list);
    select into average avg(unnest) from unnest(list);
END;
$$
    language plpgsql;

DROP FUNCTION sum_avg(VARIADIC numeric[]);


select sum_avg(5,6,1,11,115,55);

create or replace function sum_avg(variadic list numeric[], out total numeric, out average numeric)
as
    $$
    begin
        select into total sum(list[i]) from generate_subscripts(list, 1) g(i); -- с помощью generate мы создаем индексы
        select into average avg(list[i]) from generate_subscripts(list, 1) g(i); -- для элементов массива
    end;
    $$ language plpgsql;

select * from sum_avg(5, 6, 1, 8, 9, 10, 12, 20);

select sum(unnest)
from unnest(array[1, 5, 8, 9]);

select *
from generate_subscripts(array[44,78,999], 1) g(i);


create or replace function get_total_purchases(p_customer_id int)
returns numeric(10,2 ) as
    $$
    declare
    total_purchases numeric(10, 2);
        begin
        -- Рассчитываем общую сумму покупок для указанного клиента
        select into total_purchases sum(purch_amt)
        from orders
        where customer_id = p_customer_id;

        if total_purchases is null then
            total_purchases := 0;
        end if;
        return total_purchases;
    end;
    $$ language plpgsql;

select * from get_total_purchases(3009);

create or replace function get_city(c_pattern varchar)
returns table(
    c_city varchar,
    c_grade integer
             )
as
    $$
    begin
        return query select customers.city, customers.grade
        from customers
        where city ilike c_pattern;
    end;
    $$ language plpgsql;

drop function get_city(c_pattern varchar);

select * from get_city('%n%');

do $$
    <<first_block>>
    declare
        counter integer := 0;
    begin
        counter := counter + 1;
        raise notice 'The current value of counter is %', counter;
    end first_block $$;

do $$
    <<outer_block>>
    declare
        counter integer := 0;
    begin
        counter := counter + 1;
        raise notice 'The current value of counter is %', counter;

        declare
            counter integer := 0;
        begin
            counter := counter + 10;
            raise notice 'The current value of counter in the subblock is %', counter;
            raise notice 'The current value of counter in the outer block is %', outer_block.counter;
        end;
        raise notice 'The current value of counter in the outer block is %', counter;
    end outer_block $$;

CREATE TABLE actor (
    actor_id SERIAL PRIMARY KEY, -- Уникальный идентификатор актёра
    first_name VARCHAR(500) NOT NULL, -- Имя актёра
    last_name VARCHAR(500) NOT NULL, -- Фамилия актёра
    birth_date DATE, -- Дата рождения
    nationality VARCHAR(100), -- Национальность
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Дата добавления записи
);

create table actors_history(
    actor_id integer references actor,
    old_first_name varchar(500),
    new_first_name varchar(500),
    changed_at timestamp
);

INSERT INTO actor (first_name, last_name, birth_date)
VALUES
('Robert', 'Downey Jr.', '1965-04-04'),
('Scarlett', 'Johansson', '1984-11-22'),
('Chris', 'Hemsworth', '1983-08-11');


create function actors_fname_change()
returns trigger
as
    $$
    begin
        if old.first_name <> new.first_name then
            insert into actors_history(actor_id, old_first_name, new_first_name, changed_at)
            values (old.actor_id, old.first_name, new.first_name, clock_timestamp());
        end if;
        return new;
    end;
    $$ language plpgsql;

drop function actors_fname_change() cascade;

create trigger actors_trigger
    after update
    on actor
    for each row
execute procedure actors_fname_change();

drop trigger actors_trigger on actor;

select * from actor;

update actor
set first_name = 'Emil'
where actor_id in (2, 3);

update actor
set last_name = 'NewLast'
where actor_id in (1);

select * from actors_history;