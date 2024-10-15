CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    cust_name TEXT,
    city TEXT,
    grade INTEGER,
    salesman_id INTEGER
);
CREATE TABLE orders (
    ord_no INTEGER PRIMARY KEY,
    purch_amt NUMERIC,
    ord_date DATE,
    customer_id INTEGER REFERENCES customers(customer_id),
    salesman_id INTEGER
);
CREATE TABLE salesman (
    salesman_id INTEGER PRIMARY KEY,
    name TEXT,
    city TEXT,
    commission NUMERIC
);


INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 100, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001);

INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'London', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

select sum(orders.purch_amt) as total_purchase_amount
from orders;

select avg(orders.purch_amt) as average_of_purchase_amount
from orders;

select count(cust_name) as listed_names
from customers
where cust_name IS NOT NULL;

select min(orders.purch_amt) as minimum_purchase_amount
from orders;

select *
from customers
where cust_name like '%s';

select * from orders
where orders.customer_id IN (
    select customers.customer_id from customers
    where city = 'New York'
    );

select * from customers
where customer_id IN (
    select orders.customer_id from orders
    where purch_amt > 200
    );

select salesman_id, sum(customers.grade) from customers
GROUP BY salesman_id;

SELECT SUM(customers.grade) FROM customers;

select cust_name as listed_names
from customers
where cust_name IS NOT NULL;

select max(customers.grade) from customers;