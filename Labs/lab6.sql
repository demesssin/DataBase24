create database lab6;

drop table locations cascade;
drop table employees cascade;
drop table departments cascade;

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

delete from locations;
delete from employees;
delete from departments;

DO $$
DECLARE
    i INTEGER := 1;
BEGIN
    WHILE i <= 10000 LOOP
        INSERT INTO locations (street_address, postal_code, city, state_province)
        VALUES (
            md5(random()::text || clock_timestamp()::text)::varchar(25),
            LPAD((floor(random() * 999999)::text), 6, '0'),
            md5(random()::text || clock_timestamp()::text)::varchar(30),
            md5(random()::text || clock_timestamp()::text)::varchar(12)
        );
        i := i + 1;
    END LOOP;
END $$;

DO $$
DECLARE
    i INTEGER := 1;
    location_count INTEGER;
BEGIN
    -- Получим количество записей в таблице locations для создания случайных ссылок
    SELECT COUNT(*) INTO location_count FROM locations;

    WHILE i <= 10000 LOOP
        INSERT INTO departments (department_name, budget, location_id)
        VALUES (
            'Department-' || i,
            floor(random() * 100000 + 50000)::INTEGER,
            floor(random() * location_count + 1)::INTEGER
        );
        i := i + 1;
    END LOOP;
END $$;

DO $$
DECLARE
    i INTEGER := 1;
    department_count INTEGER;
BEGIN
    -- Получим количество записей в таблице departments для создания случайных ссылок
    SELECT COUNT(*) INTO department_count FROM departments;

    WHILE i <= 10000 LOOP
        INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id)
        VALUES (
            initcap(md5(random()::text)::varchar(50)),  -- генерируем случайное имя
            initcap(md5(random()::text)::varchar(50)),  -- генерируем случайную фамилию
            md5(random()::text || clock_timestamp()::text)::varchar(50) || '@example.com',
            '+1-' || LPAD((floor(random() * 9999999)::text), 7, '0'),
            floor(random() * 80000 + 20000)::INTEGER,
            floor(random() * department_count + 1)::INTEGER
        );
        i := i + 1;
    END LOOP;
END $$;

explain analyze
select employees.first_name, employees.last_name, employees.department_id, departments.department_name
from employees
join departments on employees.department_id = departments.department_id;

create index emp_dep on employees(department_id);

explain analyze
select employees.first_name, employees.last_name, employees.department_id, departments.department_name
from employees
join departments on employees.department_id = departments.department_id
where employees.department_id = 1 or employees.department_id = 3;

explain analyze
select employees.first_name, employees.last_name, employees.department_id, locations.city, locations.state_province
from employees
join departments on employees.department_id = departments.department_id
join locations on departments.location_id = locations.location_id;

explain analyze
select * from departments
left join employees on departments.department_id = employees.department_id;

explain analyze
select employees.first_name, employees.last_name, employees.department_id, departments.department_name
from employees
left join departments on departments.department_id = employees.department_id;

explain analyze
select employees.first_name, employees.last_name, employees.salary
from employees
where salary > 60000;

create index employees_salary on employees(salary);
drop index employees_salary;

EXPLAIN ANALYZE
SELECT first_name, last_name, salary
FROM employees
WHERE salary BETWEEN 55000 AND 75000;

explain analyze
select employees.first_name, employees.last_name, employees.department_id
from employees
where department_id < 3;

create index emp_dep_id on employees using hash(department_id);

select l.state_province, sum(departments.budget) as total_budget
from departments
join locations l on departments.location_id = l.location_id
group by state_province
order by total_budget asc
limit 1;

select location_id from departments
group by location_id having count(location_id) > 1;

