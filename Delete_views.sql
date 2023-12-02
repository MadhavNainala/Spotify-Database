-- drop all views
CREATE OR REPLACE PROCEDURE DropAllUserViews(DATABASE_ADMIN VARCHAR2) IS
BEGIN
    FOR view_rec IN (SELECT view_name FROM all_views WHERE owner = DATABASE_ADMIN) LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP VIEW ' || DATABASE_ADMIN || '.' || view_rec.view_name;
            DBMS_OUTPUT.PUT_LINE('Dropped view: ' || DATABASE_ADMIN || '.' || view_rec.view_name);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error dropping view: ' || DATABASE_ADMIN || '.' || view_rec.view_name || ' - ' || SQLERRM);
        END;
    END LOOP;
END DropAllUserViews;
/

BEGIN
    DropAllUserViews('DATABASE_ADMIN');
END;
/
