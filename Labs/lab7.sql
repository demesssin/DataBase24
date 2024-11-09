create database lab7;

create table countries(
    country_id serial primary key,
    name varchar(100)
);

INSERT INTO countries (name) VALUES
    ('Afghanistan'), ('Albania'), ('Algeria'), ('Andorra'), ('Angola'),
    ('Antigua and Barbuda'), ('Argentina'), ('Armenia'), ('Australia'), ('Austria'),
    ('Azerbaijan'), ('Bahamas'), ('Bahrain'), ('Bangladesh'), ('Barbados'),
    ('Belarus'), ('Belgium'), ('Belize'), ('Benin'), ('Bhutan'),
    ('Bolivia'), ('Bosnia and Herzegovina'), ('Botswana'), ('Brazil'), ('Brunei'),
    ('Bulgaria'), ('Burkina Faso'), ('Burundi'), ('Cabo Verde'), ('Cambodia'),
    ('Cameroon'), ('Canada'), ('Central African Republic'), ('Chad'), ('Chile'),
    ('China'), ('Colombia'), ('Comoros'), ('Congo, Democratic Republic of the'),
    ('Congo, Republic of the'), ('Costa Rica'), ('Croatia'), ('Cuba'), ('Cyprus'),
    ('Czech Republic'), ('Denmark'), ('Djibouti'), ('Dominica'), ('Dominican Republic'),
    ('Ecuador'), ('Egypt'), ('El Salvador'), ('Equatorial Guinea'), ('Eritrea'),
    ('Estonia'), ('Eswatini'), ('Ethiopia'), ('Fiji'), ('Finland'), ('France'),
    ('Gabon'), ('Gambia'), ('Georgia'), ('Germany'), ('Ghana'),
    ('Greece'), ('Grenada'), ('Guatemala'), ('Guinea'), ('Guinea-Bissau'),
    ('Guyana'), ('Haiti'), ('Honduras'), ('Hungary'), ('Iceland'),
    ('India'), ('Indonesia'), ('Iran'), ('Iraq'), ('Ireland'),
    ('Israel'), ('Italy'), ('Jamaica'), ('Japan'), ('Jordan'),
    ('Kazakhstan'), ('Kenya'), ('Kiribati'), ('Korea, North'), ('Korea, South'),
    ('Kosovo'), ('Kuwait'), ('Kyrgyzstan'), ('Laos'), ('Latvia'),
    ('Lebanon'), ('Lesotho'), ('Liberia'), ('Libya'), ('Liechtenstein'),
    ('Lithuania'), ('Luxembourg'), ('Madagascar'), ('Malawi'), ('Malaysia'),
    ('Maldives'), ('Mali'), ('Malta'), ('Marshall Islands'), ('Mauritania'),
    ('Mauritius'), ('Mexico'), ('Micronesia'), ('Moldova'), ('Monaco'),
    ('Mongolia'), ('Montenegro'), ('Morocco'), ('Mozambique'), ('Myanmar'),
    ('Namibia'), ('Nauru'), ('Nepal'), ('Netherlands'), ('New Zealand'),
    ('Nicaragua'), ('Niger'), ('Nigeria'), ('North Macedonia'), ('Norway'),
    ('Oman'), ('Pakistan'), ('Palau'), ('Panama'), ('Papua New Guinea'),
    ('Paraguay'), ('Peru'), ('Philippines'), ('Poland'), ('Portugal'),
    ('Qatar'), ('Romania'), ('Russia'), ('Rwanda'), ('Saint Kitts and Nevis'),
    ('Saint Lucia'), ('Saint Vincent and the Grenadines'), ('Samoa'), ('San Marino'),
    ('Sao Tome and Principe'), ('Saudi Arabia'), ('Senegal'), ('Serbia'), ('Seychelles'),
    ('Sierra Leone'), ('Singapore'), ('Slovakia'), ('Slovenia'), ('Solomon Islands'),
    ('Somalia'), ('South Africa'), ('South Sudan'), ('Spain'), ('Sri Lanka'),
    ('Sudan'), ('Suriname'), ('Sweden'), ('Switzerland'), ('Syria'),
    ('Taiwan'), ('Tajikistan'), ('Tanzania'), ('Thailand'), ('Timor-Leste'),
    ('Togo'), ('Tonga'), ('Trinidad and Tobago'), ('Tunisia'), ('Turkey'),
    ('Turkmenistan'), ('Tuvalu'), ('Uganda'), ('Ukraine'), ('United Arab Emirates'),
    ('United Kingdom'), ('United States'), ('Uruguay'), ('Uzbekistan'),
    ('Vanuatu'), ('Vatican City'), ('Venezuela'), ('Vietnam'), ('Yemen'),
    ('Zambia'), ('Zimbabwe');

explain analyze
select name from countries
where name = 'Sierra Leone';

create index need_country_name on countries using hash(name);
drop index need_country_name;

create table employees(
    id serial primary key,
    name varchar(50),
    surname varchar(50),
    salary int
);

INSERT INTO employees (name, surname, salary) VALUES
    ('John', 'Smith', 50000),
    ('Jane', 'Johnson', 67000),
    ('Alice', 'Williams', 75000),
    ('Bob', 'Brown', 43000),
    ('Charlie', 'Jones', 52000),
    ('David', 'Miller', 94000),
    ('Emma', 'Davis', 81000),
    ('Frank', 'Garcia', 36000),
    ('Grace', 'Rodriguez', 43000),
    ('Helen', 'Wilson', 89000),
    ('Isaac', 'Martinez', 71000),
    ('Jack', 'Anderson', 54000),
    ('Karen', 'Taylor', 66000),
    ('Liam', 'Thomas', 37000),
    ('Mia', 'Hernandez', 92000),
    ('Nina', 'Moore', 45000),
    ('Oscar', 'Martin', 76000),
    ('Paul', 'Jackson', 67000),
    ('Quincy', 'Lee', 34000),
    ('Rachel', 'Perez', 51000),
    ('Steve', 'White', 88000),
    ('Tina', 'Harris', 74000),
    ('Uma', 'Clark', 47000),
    ('Victor', 'Lewis', 82000),
    ('Wendy', 'Walker', 60000),
    ('Xander', 'Hall', 33000),
    ('Yara', 'Allen', 91000),
    ('Zane', 'Young', 66000),
    ('Amelia', 'Scott', 78000),
    ('Brian', 'Green', 55000),
    ('Catherine', 'Adams', 42000),
    ('Derek', 'Baker', 85000),
    ('Elena', 'Gonzalez', 93000),
    ('Finn', 'Nelson', 68000),
    ('Gina', 'Carter', 41000),
    ('Harry', 'Mitchell', 36000),
    ('Irene', 'Perez', 52000),
    ('Jake', 'Roberts', 77000),
    ('Kara', 'Phillips', 59000),
    ('Leo', 'Campbell', 46000),
    ('Maria', 'Parker', 64000),
    ('Nick', 'Evans', 87000),
    ('Olivia', 'Edwards', 39000),
    ('Pete', 'Collins', 79000),
    ('Queenie', 'Stewart', 51000),
    ('Ron', 'Sanchez', 84000),
    ('Sara', 'Morris', 73000),
    ('Tom', 'Rogers', 49000),
    ('Ursula', 'Reed', 65000),
    ('Vince', 'Cook', 57000),
    ('Willow', 'Morgan', 85000),
    ('Ximena', 'Bell', 39000),
    ('Yusuf', 'Murphy', 91000),
    ('Zara', 'Bailey', 60000),
    ('Aaron', 'Rivera', 44000),
    ('Bella', 'Cooper', 81000),
    ('Carl', 'Richardson', 35000),
    ('Dana', 'Cox', 73000),
    ('Evan', 'Howard', 42000),
    ('Fiona', 'Ward', 90000),
    ('George', 'Torres', 56000),
    ('Holly', 'Peterson', 47000),
    ('Ian', 'Gray', 88000),
    ('Judy', 'Ramirez', 33000),
    ('Kyle', 'James', 69000),
    ('Linda', 'Watson', 54000),
    ('Mason', 'Brooks', 76000),
    ('Nina', 'Kelly', 37000),
    ('Oliver', 'Sanders', 80000),
    ('Paula', 'Price', 41000),
    ('Quinn', 'Bennett', 70000),
    ('Ray', 'Wood', 67000),
    ('Stella', 'Barnes', 38000),
    ('Tim', 'Ross', 91000),
    ('Ulysses', 'Henderson', 35000),
    ('Vivian', 'Coleman', 94000),
    ('Wes', 'Jenkins', 81000),
    ('Xena', 'Perry', 68000),
    ('Yvonne', 'Powell', 48000),
    ('Zack', 'Long', 75000),
    ('Ava', 'Patterson', 53000),
    ('Ben', 'Hughes', 77000),
    ('Chloe', 'Flores', 34000),
    ('Dylan', 'Washington', 63000),
    ('Eva', 'Butler', 85000),
    ('Fred', 'Simmons', 72000),
    ('Gwen', 'Foster', 39000),
    ('Hank', 'Gonzales', 69000),
    ('Ivy', 'Bryant', 43000),
    ('Jon', 'Alexander', 88000),
    ('Kelsey', 'Russell', 35000),
    ('Luke', 'Griffin', 94000),
    ('Megan', 'Diaz', 60000),
    ('Nathan', 'Hayes', 55000),
    ('Olga', 'Myers', 47000),
    ('Pat', 'Ford', 66000),
    ('Quentin', 'Hamilton', 79000),
    ('Rose', 'Graham', 36000),
    ('Sam', 'Sullivan', 89000),
    ('Tara', 'Wallace', 52000),
    ('Uriel', 'Woods', 58000),
    ('Vera', 'Cole', 82000),
    ('Walt', 'West', 64000),
    ('Xavier', 'Jordan', 44000),
    ('Yasmine', 'Owens', 70000),
    ('Zoe', 'Reynolds', 78000);


explain analyze
select * from employees where name = 'Ulysses' and surname = 'Henderson';

create index emp_name_surname on employees(name, surname);

drop table employees;

explain analyze
select * from employees where salary > 40000 and salary < 92000;

create index emp_salary on employees(salary);

CREATE TABLE employees2 (
    name VARCHAR(100),
    surname VARCHAR(100)
);

INSERT INTO employees2 (name, surname) VALUES
('abcd1234', 'Smith'),
('abcd5678', 'Johnson'),
('xyzabcd', 'Brown'),
('abcdefgh', 'Taylor');

explain analyze
select * from employees2 where substring(name from 1 for 4) = 'abcd';

create index emp_substr on employees2 using hash(name);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    budget DECIMAL
);

CREATE TABLE employees3 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    surname VARCHAR(100),
    department_id INT,
    salary DECIMAL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments (department_id, department_name, budget) VALUES
(1, 'HR', 50000),
(2, 'IT', 100000),
(3, 'Sales', 75000),
(4, 'Marketing', 60000);

INSERT INTO employees3 (employee_id, name, surname, department_id, salary) VALUES
(1, 'John', 'Doe', 1, 4000),
(2, 'Jane', 'Smith', 2, 5500),
(3, 'Emily', 'Jones', 3, 3500),
(4, 'Michael', 'Brown', 2, 6000),
(5, 'Sarah', 'Taylor', 4, 4500),
(6, 'David', 'White', 1, 3000),
(7, 'Laura', 'Green', 3, 5000),
(8, 'James', 'Black', 4, 3500);

explain analyze
SELECT * FROM employees3 e3 JOIN departments d
ON d.department_id = e3.department_id WHERE
d.budget > 3500 AND e3.salary < 5000;

create index emp_dep_join on employees3(department_id);

drop index emp_dep_join;

create index emp_dep_join_salary on employees3(salary, department_id);






