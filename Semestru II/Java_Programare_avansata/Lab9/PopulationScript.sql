DROP TABLE persons CASCADE CONSTRAINTS;

DROP TABLE movies CASCADE CONSTRAINTS;

CREATE TABLE persons (
    id NUMBER(5) NOT NULL PRIMARY KEY,
    name VARCHAR2(25) NOT NULL
);

CREATE TABLE movies (
    id NUMBER(5) NOT NULL PRIMARY KEY,
    name VARCHAR2(25) NOT NULL,
    id_director NUMBER(5) NOT NULL,
    CONSTRAINT fk_id_director FOREIGN KEY (id_director) REFERENCES persons(id)
);

SELECT table_name FROM user_tables;

SELECT * FROM persons;

SELECT * FROM movies;