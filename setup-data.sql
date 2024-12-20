BEGIN
    DBMS_OUTPUT.PUT_LINE('Begin init');
END;
/

CREATE USER app IDENTIFIED BY app;

GRANT CONNECT, RESOURCE TO app;

CREATE USER ggadmin IDENTIFIED BY ggadmin;

GRANT CONNECT, RESOURCE TO ggadmin;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Creating table');
END;
/

CREATE TABLE app.employee (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    salary NUMBER,
    created_at DATE DEFAULT SYSDATE
);

BEGIN
    DBMS_OUTPUT.PUT_LINE('Grant access to ggadmin');
END;
/

BEGIN
    FOR obj IN (SELECT OBJECT_NAME FROM ALL_OBJECTS WHERE OWNER = 'APP' AND OBJECT_TYPE = 'TABLE') LOOP
        EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON app.' || obj.OBJECT_NAME || ' TO ggadmin';
    END LOOP;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'GRANT CREATE ANY TABLE TO ggadmin';
    EXECUTE IMMEDIATE 'GRANT CREATE ANY VIEW TO ggadmin';
    EXECUTE IMMEDIATE 'GRANT CREATE ANY PROCEDURE TO ggadmin';
    EXECUTE IMMEDIATE 'GRANT CREATE ANY INDEX TO ggadmin';
    EXECUTE IMMEDIATE 'GRANT CREATE ANY SEQUENCE TO ggadmin';
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('End init');
END;
/
