create database lab9;

CREATE OR REPLACE FUNCTION increase_value(val INTEGER)
RETURNS INTEGER AS $$
BEGIN
    RETURN val + 10;
END;
$$ LANGUAGE plpgsql;

select increase_value(70);


CREATE OR REPLACE FUNCTION compare_numbers(num1 INTEGER, num2 INTEGER)
RETURNS TEXT AS $$
BEGIN
    IF num1 > num2 THEN
        RETURN 'Greater';
    ELSIF num1 = num2 THEN
        RETURN 'Equal';
    ELSE
        RETURN 'Lesser';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT compare_numbers(78, 98);

CREATE OR REPLACE FUNCTION number_series(n INTEGER)
RETURNS TABLE(series INTEGER) AS $$
BEGIN
    RETURN QUERY
    SELECT generate_series(1, n);
END;
$$ LANGUAGE plpgsql;

select number_series(10);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    salary NUMERIC(10, 2) NOT NULL
);

INSERT INTO employees (name, department, salary) VALUES
('Alice Johnson', 'HR', 55000.00),
('Bob Smith', 'Engineering', 75000.00),
('Charlie Brown', 'Marketing', 60000.00),
('David Wilson', 'Engineering', 82000.00),
('Eve Davis', 'HR', 48000.00);


CREATE OR REPLACE FUNCTION find_employee(emp_name VARCHAR)
RETURNS TABLE(employee_id INTEGER, name VARCHAR, department VARCHAR, salary NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT id, employees.name, employees.department, employees.salary
    FROM employees
    WHERE employees.name = emp_name;
END;
$$ LANGUAGE plpgsql;


SELECT * from find_employee('Alice Johnson');

drop function find_employee(emp_name VARCHAR);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,       -- Уникальный идентификатор продукта
    name VARCHAR(100) NOT NULL,  -- Название продукта
    category VARCHAR(50) NOT NULL, -- Категория продукта
    price NUMERIC(10, 2) NOT NULL -- Цена продукта
);

INSERT INTO products (name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Smartphone', 'Electronics', 800.00),
('Tablet', 'Electronics', 600.00),
('Desk Chair', 'Furniture', 150.00),
('Office Desk', 'Furniture', 300.00),
('Notebook', 'Stationery', 2.50),
('Pen', 'Stationery', 1.00);



CREATE OR REPLACE FUNCTION list_products(category_name VARCHAR)
RETURNS TABLE(product_id INTEGER, product_name VARCHAR, price NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT products.id, products.name, products.price
    FROM products
    WHERE products.category = category_name;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM list_products('Electronics');



CREATE OR REPLACE FUNCTION calculate_bonus(salary NUMERIC, bonus_rate NUMERIC)
RETURNS NUMERIC AS $$
BEGIN
    RETURN salary * bonus_rate;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_salary(emp_id INTEGER, bonus_rate NUMERIC)
RETURNS VOID AS $$
DECLARE
    current_salary NUMERIC;
    new_salary NUMERIC;
BEGIN
    SELECT salary INTO current_salary
    FROM employees
    WHERE id = emp_id;

    new_salary := current_salary + calculate_bonus(current_salary, bonus_rate);

    UPDATE employees
    SET salary = new_salary
    WHERE id = emp_id;
END;
$$ LANGUAGE plpgsql;

SELECT calculate_bonus(50000, 0.1);
SELECT update_salary(1, 0.1);

SELECT * FROM employees WHERE ID = 1;


CREATE OR REPLACE FUNCTION complex_calculation(val1 INTEGER, val2 VARCHAR)
RETURNS TEXT AS $$
DECLARE
    num_result INTEGER;
    str_result VARCHAR;
BEGIN
    <<main_block>>
    BEGIN
        <<numeric_block>>
        BEGIN
            num_result := val1 * 10;
        END numeric_block;

        <<string_block>>
        BEGIN
            str_result := CONCAT(val2, ' processed');
        END string_block;
        RETURN 'Numeric: ' || num_result || ', String: ' || str_result;
    END main_block;
END;
$$ LANGUAGE plpgsql;

SELECT complex_calculation(5, 'example');

create or replace function varchar_length(stroka varchar)
returns varchar as $$
    declare
    str_result integer;
    begin
        str_result := length(stroka);
        return str_result;
    end;
    $$ language plpgsql;

drop function varchar_length(stroka varchar);

select varchar_length('Nurkhat');