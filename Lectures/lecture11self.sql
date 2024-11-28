create table employees(
    emp_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    salary integer not null
);

insert into employees(first_name, last_name, salary)
values ('Nurkhat', 'Demessin', 750000),
       ('Aidana', 'Sarsenbay', 1000000),
       ('Ayaulym', 'Sarsenbay', 1500000);

drop table employees;

BEGIN;
-- Проверяем исходное значение
SELECT *
FROM employees
WHERE first_name = 'Nurkhat';
-- Обновляем значение
UPDATE employees
SET salary = salary * 1.5
WHERE first_name = 'Nurkhat';
-- Проверяем, изменилось ли значение
SELECT *
FROM employees
WHERE first_name = 'Nurkhat';
-- Откатываем изменения
ROLLBACK;

-- Проверяем, что значение вернулось к исходному
SELECT *
FROM employees
WHERE first_name = 'Nurkhat';

begin;
select * from employees;
update employees
set first_name = 'Baktygali'
where first_name = 'Abzal';
select * from employees;
rollback;
select * from employees;
update employees
set salary = salary * 1.1
where first_name = 'Abzal';
select * from employees;
commit;

select * from employees;

begin;
savepoint savepoint_1;
insert into employees (first_name, last_name, salary)
values ('Azamat', 'Serik', 500000);
savepoint savepoint_2;
update employees
set salary = -1000
where first_name = 'Azamat';
rollback to savepoint_2;
insert into employees(first_name, last_name, salary)
values ('Aidyn', 'Yesenzhan', 750000);
commit;

select * from employees;

begin transaction isolation level read uncommitted;
select * from employees where first_name = 'Aidana';
update employees set first_name = 'Elmira' where first_name = 'Aidana';
select * from employees;
select * from employees where first_name='Aidyn';
commit;

select * from employees;

begin transaction isolation level read committed read only; -- в read only мы можем только читать, ничего изменить нельзя
select * from actor where actor_id=135;
update actor set first_name='New name' where actor_id=135;
select * from actor where actor_id=135;
commit;

BEGIN; -- Начинаем транзакцию
SAVEPOINT my_savepoint;
-- Изменяем данные
UPDATE employees SET salary = salary + 1000 WHERE emp_id = 1;
-- Удаляем точку сохранения
RELEASE SAVEPOINT my_savepoint; -- просто удаляет savepoint
-- Пытаемся откатиться (выдаст ошибку, так как точка сохранения уже удалена)
ROLLBACK TO SAVEPOINT my_savepoint; -- ERROR
-- Завершаем транзакцию, изменения фиксируются
COMMIT;


