-- Создать таблицу студентов
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    enrollment_year INT
);

-- Создать таблицу курсов
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    department VARCHAR(50)
);

-- Создать таблицу оценок
CREATE TABLE grades (
    grade_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    grade CHAR(1), -- Оценка (например: A, B, C, D, F)
    semester VARCHAR(20)
);

    -- Вставить данные в таблицу студентов
    INSERT INTO students (first_name, last_name, enrollment_year) VALUES
    ('Alice', 'Johnson', 2022),
    ('Bob', 'Smith', 2021),
    ('Carol', 'Davis', 2023),
    ('Dave', 'Wilson', 2022);

    -- Вставить данные в таблицу курсов
    INSERT INTO courses (course_name, department) VALUES
    ('Mathematics', 'Science'),
    ('History', 'Arts'),
    ('Computer Science', 'Engineering'),
    ('Physics', 'Science');

    -- Вставить данные в таблицу оценок
    INSERT INTO grades (student_id, course_id, grade, semester) VALUES
    (1, 1, 'A', 'Fall 2023'),
    (1, 3, 'B', 'Fall 2023'),
    (2, 2, 'C', 'Spring 2023'),
    (2, 3, 'A', 'Spring 2023'),
    (3, 1, 'B', 'Fall 2023'),
    (4, 4, 'A', 'Fall 2023');

explain analyze
select  * from students;

create view vista as select 'Hello World!';
select * from vista;

create view students_view as
select students.student_id, students.first_name, students.last_name
from students
where enrollment_year = 2022;

select *
from students_view;

drop view students_view;

create table films(
    id serial primary key,
    title varchar(10),
    kind varchar(20),
    classification varchar(10)
);

insert into films(title, kind, classification) VALUES ('Film1', 'Drama', 'PG'),
                                                      ('Film2', 'Comedy', 'U'),
                                                      ('Film3', 'Comedy', 'PG'),
                                                      ('Film4', 'Fantasy', 'D');

select * from films;

create view comedies as
    select * from films
    where kind = 'Comedy';

select * from comedies;

create view universal_comedies as
    select *
    from comedies
    where classification = 'U'
    with local check option;

select * from universal_comedies;

insert into universal_comedies(title, classification) values ('New Comedy', 'U');
INSERT INTO universal_comedies(title, classification) values('Other Comedy', 'D'); -- не сработает
-- потому что с помощью with local check option мы обьявили то что все новые данные в view должны быть c
-- classfiication 'U'

drop view total_second_course;

create view total_second_course as
    select last_name, first_name
    from students
    where enrollment_year = 2022;

select * from total_second_course;

create materialized view about_grade as
    select *
    from grades
    where grade = 'A'
    with data;              -- метод with data заполняет представления данными сразу после заполнения

select * from about_grade; -- тут мы спокойно вызывает представления

create materialized view about_course as
    select *
    from courses
    where department = 'Science'    -- тут оно создает пустое представление пока что
    with no data;

refresh materialized view about_course; -- что бы вывести представление в консоли мы должны актуализировать
select * from about_course;           -- данными с помощью команды refresh и только потом вызывать

create index concurrently on about_course(course_id);
refresh materialized view concurrently about_course;

explain analyze
select * from about_course;

create materialized view example_view as
    select s.enrollment_year, sum(s.enrollment_year), avg(s.enrollment_year), max(s.enrollment_year)
    from students s
    join grades g on s.student_id = g.student_id
    group by enrollment_year
    with no data;

refresh materialized view example_view;
select *
from example_view;

create or replace view total_second_course as
    select students.last_name, students.first_name
    from students
    where student_id IN (
        select grades.student_id
        from grades
        where grade = 'A'
        );

select * from total_second_course;

alter view total_second_course
rename to renamed_total_second_course;

select * from renamed_total_second_course;

create role ali_role;
drop role ali_role;

select rolname from pg_roles;

create role user1 login;
create user user2;

create role user3 superuser;
drop role user3;

create role nurik createdb;
drop role nurik;

create role alish createrole;
drop role alish;

create role replicator REPLICATION LOGIN;
drop role replicator;
select rolname from pg_roles;

create role soulbirkez password 'Qazalinsk2';

alter role soulbirkez with createdb;
alter role soulbirkez with createrole;

select * from pg_roles
where rolname = 'soulbirkez';

create role tempo;
alter role tempo with createdb;

create role arsen createdb;
create role abok login;
create role zhorik createrole;

create group atyrau;
grant atyrau to arsen, abok, zhorik;
create group aktau;
grant aktau to tempo, alish, nurik;

revoke atyrau from arsen, abok, zhorik;
revoke aktau from tempo, alish, nurik;

drop role atyrau;
drop role aktau;

create role aibek;

alter table students owner to aibek;

reassign owned by aibek to alish;
drop owned by aibek;
drop role aibek;