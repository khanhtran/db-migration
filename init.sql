-- init.sql
CREATE TABLE my_table (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50)
);

INSERT INTO my_table (id, name) VALUES (1, 'Alice');
INSERT INTO my_table (id, name) VALUES (2, 'Bob');
