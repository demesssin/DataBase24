create database lab8;

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

CREATE ROLE junior_dev;
drop role junior_dev;

create user nur with password 'demesinov';

select * from orders;

select rolname from pg_roles;
select * from pg_roles;

create view salesmen_ny as
select *
from salesman
where city = 'New York';

select * from salesmen_ny;

create view order_details as
select
    o.ord_no,
    o.purch_amt,
    o.ord_date,
    c.cust_name as customer_name,
    s.name as salesman_name
from orders o
join customers c on o.customer_id = c.customer_id
join salesman s on o.salesman_id = s.salesman_id;

select * from order_details;

grant all privileges on table order_details to junior_dev;

CREATE VIEW top_grade_customers AS
SELECT *
FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

select * from top_grade_customers;

GRANT SELECT ON TABLE top_grade_customers TO junior_dev;

select * from pg_roles;

CREATE VIEW salesman_count_by_city AS
SELECT
    city,
    COUNT(*) AS total_salesmen
FROM salesman
GROUP BY city;

CREATE VIEW salesmen_multiple_customers AS
SELECT
    s.salesman_id,
    s.name AS salesman_name,
    COUNT(c.customer_id) AS customer_count
FROM salesman s
JOIN customers c ON s.salesman_id = c.salesman_id
GROUP BY s.salesman_id, s.name
HAVING COUNT(c.customer_id) > 1;

select * from salesmen_multiple_customers;

CREATE ROLE intern;

GRANT junior_dev TO intern;




