create database lab6;

create table locations(
    location_id SERIAL PRIMARY KEY,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

create table departments(
    department_id SERIAL PRIMARY KEY,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);

create table employees(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);

INSERT INTO locations (street_address, postal_code, city, state_province) VALUES
('123 Elm St', '10001', 'New York', 'NY'),
('456 Oak Ave', '90001', 'Los Angeles', 'CA'),
('789 Pine Rd', '60601', 'Chicago', 'IL');

INSERT INTO departments (department_name, budget, location_id) VALUES
('Sales', 100000, 1),
('Engineering', 200000, 2),
('Human Resources', 50000, 3);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
('John', 'Doe', 'johndoe@example.com', '555-1234', 60000, 1),
('Jane', 'Smith', 'janesmith@example.com', '555-5678', 75000, 2),
('Alice', 'Johnson', 'alicej@example.com', '555-8765', 55000, 3),
('Bob', 'Brown', 'bobb@example.com', '555-4321', 70000, 2);


select employees.first_name, employees.last_name, employees.department_id, departments.department_name
from employees
join departments on employees.department_id = departments.department_id;

select employees.first_name, employees.last_name, employees.department_id, departments.department_name
from employees
join departments on employees.department_id = departments.department_id
where employees.department_id = 1 or employees.department_id = 3;

select employees.first_name, employees.last_name, employees.department_id, locations.city, locations.state_province
from employees
join departments on employees.department_id = departments.department_id
join locations on departments.location_id = locations.location_id;

select * from departments
left join employees on departments.department_id = employees.department_id;

select employees.first_name, employees.last_name, employees.department_id, departments.department_name
from employees
left join departments on departments.department_id = employees.department_id