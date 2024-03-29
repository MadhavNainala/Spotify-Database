SET SERVEROUTPUT ON;

DECLARE 
  ncount NUMBER;
BEGIN
  -- Check if the user 'DATABASE_ADMIN' exists
  SELECT COUNT(1) INTO ncount FROM all_users WHERE UPPER(username) = 'DATABASE_ADMIN';

  -- If the user exists, output a message
  IF ncount > 0 THEN
    dbms_output.put_line('USER DATABASE_ADMIN ALREADY EXISTS.');
  ELSE
    -- Create the user 'DATABASE_ADMIN'
    EXECUTE IMMEDIATE 'CREATE USER DATABASE_ADMIN IDENTIFIED BY Password123#';
    dbms_output.put_line('USER DATABASE_ADMIN CREATED');
  END IF;

  -- Grant privileges (executed regardless of whether the user was just created or already existed)
  EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO DATABASE_ADMIN WITH ADMIN OPTION';
  EXECUTE IMMEDIATE 'GRANT UNLIMITED TABLESPACE TO DATABASE_ADMIN WITH ADMIN OPTION';
  EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO DATABASE_ADMIN WITH ADMIN OPTION';
  EXECUTE IMMEDIATE 'GRANT CREATE VIEW, CREATE PROCEDURE, CREATE SEQUENCE, CREATE USER, DROP USER TO DATABASE_ADMIN WITH ADMIN OPTION';
  EXECUTE IMMEDIATE 'GRANT CREATE SESSION,CONNECT TO DATABASE_ADMIN with admin option';
  EXECUTE IMMEDIATE 'GRANT SELECT ON DBA_ROLES TO DATABASE_ADMIN';
  EXECUTE IMMEDIATE 'GRANT CREATE ROLE TO DATABASE_ADMIN with admin option';



  dbms_output.put_line('Privileges granted to DATABASE_ADMIN.');

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('ERROR: ' || SQLERRM);
END;
/






