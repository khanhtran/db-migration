-- Step 1: Create user 'c##app'
CREATE USER c##app IDENTIFIED BY c##app;

-- Grant basic privileges to 'c##app' user
GRANT CONNECT, RESOURCE TO c##app;

-- Step 2: Create user 'c##ggadmin'
CREATE USER c##ggadmin IDENTIFIED BY c##ggadmin
DEFAULT TABLESPACE users 
QUOTA UNLIMITED ON users;

-- Grant basic privileges to 'c##ggadmin' user
GRANT CONNECT TO c##ggadmin;

-- Step 3: Create a table in the 'c##app' schema
-- Run this as a privileged user or while connected as the 'c##app' user
CREATE TABLE c##app.employee (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    salary NUMBER,
    created_at DATE DEFAULT SYSDATE
);

-- Step 4: Insert a row into the 'c##app.employee' table
-- Run this as a privileged user or while connected as the 'c##app' user
--INSERT INTO c##app.employee (id, name, salary) 
--VALUES (1, 'John Doe', 75000);
--COMMIT;

-- Step 5: Grant 'c##ggadmin' access to all tables in 'c##app'
-- Grant SELECT, INSERT, UPDATE, DELETE on all tables in 'c##app' to 'c##ggadmin'
BEGIN
    FOR obj IN (SELECT OBJECT_NAME FROM ALL_OBJECTS WHERE OWNER = 'C##APP' AND OBJECT_TYPE = 'TABLE') LOOP
        EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON c##app.' || obj.OBJECT_NAME || ' TO c##ggadmin';
    END LOOP;
END;

-- Step 6: Grant 'c##ggadmin' the ability to create any object in 'c##app'
BEGIN
    EXECUTE IMMEDIATE 'GRANT CREATE ANY TABLE TO c##ggadmin';
    EXECUTE IMMEDIATE 'GRANT CREATE ANY VIEW TO c##ggadmin';
    EXECUTE IMMEDIATE 'GRANT CREATE ANY PROCEDURE TO c##ggadmin';
    EXECUTE IMMEDIATE 'GRANT CREATE ANY INDEX TO c##ggadmin';
    EXECUTE IMMEDIATE 'GRANT CREATE ANY SEQUENCE TO c##ggadmin';
END;

