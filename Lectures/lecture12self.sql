create table employee(
    employee_id varchar(10),
    name varchar(50),
    job_code varchar(10),
    job varchar(50),
    state_code integer not null,
    home_state varchar(50)
);

insert into employee(employee_id, name, job_code, job, state_code, home_state)
values ('E001', 'Alice', 'J01', 'Chef', 26, 'Michigan'),
       ('E001', 'Alice', 'J02', 'Waiter', 26, 'Michigan'),
       ('E002', 'Bob', 'J02', 'Waiter', 56, 'Wyoming'),
       ('E002', 'Bob', 'J03', 'Bartender', 56, 'Wyoming'),
       ('E003', 'Alice', 'J01', 'Chef', 56, 'Wyoming');

select * from employee; -- Here employee table is in 1NF
-- because, All the entries are atomic and there is a composite primary key (employee_id, job_code);


create table employee_roles(
    employee_id varchar(10),
    job_code varchar(10),
    primary key (employee_id, job_code)
);

create table employees(
    employee_id varchar(10) primary key,
    name varchar(50),
    state_code integer,
    home_state integer
);
drop table employees;

create table jobs(
    job_code varchar(10) primary key,
    job varchar(50)
);
-- home_state is now dependent on state_code. So, if you know the state_code, then you can find the home_state value.
-- To take this a step further, we should separate them again to a different table to make it 3NF.

-- Remaking this into the 3NF
create table employee_roles2(
    employee_id varchar(10),
    job_code varchar(10),
    primary key(employee_id, job_code)
);

create table employees2(
    employee_id varchar(10) primary key,
    name varchar(50),
    state_code integer
);

create table jobs2(
    job_code varchar(10) primary key,
    job varchar(50)
);

create table states(
    state_code integer primary key,
    home_state varchar(50)
);

-- now table is in the 3NF