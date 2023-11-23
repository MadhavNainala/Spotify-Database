---To drop this user run below query in DBA Admin
SET SERVEROUTPUT ON;
DECLARE
c number;
BEGIN
select count(*) into c from all_users where username='DATABASE_ADMIN';
IF c>0 then
EXECUTE IMMEDIATE 'DROP USER DATABASE_ADMIN CASCADE';
dbms_output.put_line('Dropped USER DATABASE_ADMIN');
ELSE
dbms_output.put_line('DATABASE_ADMIN already dropped');
END IF;
END;
