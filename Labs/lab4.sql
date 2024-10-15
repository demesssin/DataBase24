CREATE DATABASE lab4;

CREATE TABLE Warehouse(
    code serial,
    location character varying(255),
    capacity integer
);

INSERT INTO Warehouse(location, capacity)
VALUES ('Chicago', 3),
       ('Chicago', 4),
       ('New York', 7),
       ('Los Angeles', 2),
       ('San Francisco', 8);

drop table warehouse;
drop table Boxes;

CREATE TABLE Boxes(
    code character(4),
    contents character varying(255),
    value real,
    warehouse integer
);

INSERT INTO Boxes (code,contents, value, warehouse)
VALUES ('0MN7', 'Rocks', 180, 3),
    ('4H8P', 'Rocks', 250, 1),
    ('4RT3', 'Scissors', 190, 4),
    ('7G3H', 'Rocks', 200, 1),
    ('8JN6', 'Papers', 75, 1),
    ('8Y6U', 'Papers', 50, 3),
    ('9J6F', 'Papers', 175, 2),
    ('LL08', 'Rocks', 140, 4),
    ('POH6', 'Scissors', 125, 1),
    ('P2T6', 'Scissors', 150, 2),
    ('TU55', 'Papers', 90, 5);

SELECT * FROM Warehouse;

SELECT * FROM Boxes
WHERE value > 150;

SELECT DISTINCT(contents) FROM Boxes;

SELECT warehouse, count(*) as boxcount
FROM Boxes
GROUP BY warehouse;

SELECT contents, avg(Boxes.value)
FROM Boxes
GROUP BY contents;


SELECT warehouse, count(*) as boxcount2
FROM boxes
GROUP BY warehouse
HAVING count(*) > 2;

INSERT INTO warehouse(location, capacity)
VALUES ('New York', 3);

SELECT * FROM warehouse;

INSERT INTO Boxes(code, contents, value, warehouse)
VALUES ('H5RT', 'Papers',200, 2);

SELECT *
FROM Boxes
ORDER BY value DESC
LIMIT 1 OFFSET 2;

UPDATE Boxes
SET value = value * 0.85
WHERE code IN (
    SELECT code
    FROM Boxes
    ORDER BY value DESC
    LIMIT 2 OFFSET 2
    );

select * from boxes;

DELETE FROM Boxes
WHERE value < 150
returning *;

DELETE FROM Boxes
WHERE Warehouse IN (
    SELECT code
    from Warehouse
    where location = 'New York'
    )
RETURNING *;

SELECT code
FROM Warehouse
WHERE location = 'New York';

SELECT *
FROM Boxes
WHERE warehouse IN (
    SELECT code
    FROM Warehouse
    WHERE location = 'New York'
);