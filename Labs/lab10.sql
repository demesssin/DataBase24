create database lab10;

create table books(
    book_id integer primary key,
    title varchar(100),
    author varchar(100),
    price decimal(5,2),
    quantity integer
);
drop table books cascade;

create table orders(
    order_id integer primary key,
    book_id integer references books(book_id),
    customer_id integer,
    order_date date,
    quantity integer
);

create table customers(
    customer_id integer,
    name varchar(50),
    email varchar(50)
);

insert into books(book_id, title, author, price, quantity)
values (1, 'Database 101', 'A. Smith',40.00, 10),
       (2, 'Learn SQL', 'B. Johnson', 35.00, 15),
       (3, 'Advanced DB', 'C. Lee', 50.00, 5);

insert into customers(customer_id, name, email)
values (101, 'John Doe', 'johndoe@example.com'),
       (102, 'Jane Doe', 'janedoe@example.com');


begin;
insert into orders(order_id, book_id, customer_id, order_date, quantity)
values (1,1, 101, current_date, 2);
update books
set quantity = quantity - 2
where book_id = 1;
commit;

select * from books;

begin;
update books
set quantity = quantity - 10
where book_id = 3;
rollback;

select books.quantity from books;


SET TRANSACTION ISOLATION LEVEL READ COMMITTED READ WRITE ;
BEGIN;
UPDATE books
SET price = 99.00
WHERE book_id = 2;
COMMIT;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED READ WRITE ;
BEGIN;
SELECT price FROM books WHERE book_id = 2;
COMMIT;


BEGIN;
UPDATE customers
SET email = 'nurik@outlook.com'
where customer_id = 101;
commit;

select * from customers;
