
DROP ROLE USER_ROLE;

DROP USER Pavan;

DECLARE
   ncount NUMBER;
BEGIN
   -- Check if the USER_ROLE already exists
   SELECT COUNT(1) INTO ncount FROM DBA_ROLES WHERE role = 'USER_ROLE';

   IF (ncount > 0) THEN
      DBMS_OUTPUT.PUT_LINE('USER_ROLE ALREADY EXISTS');
   ELSE
      -- Create the USER_ROLE if it doesn't exist
      EXECUTE IMMEDIATE 'CREATE ROLE USER_ROLE';

      -- Grant necessary permissions to USER_ROLE
      EXECUTE IMMEDIATE 'GRANT CREATE SESSION, CONNECT TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT EXECUTE ON DATABASE_ADMIN.UserInsertPackage TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT EXECUTE ON DATABASE_ADMIN.UserUpdatePackage TO USER_ROLE';

      -- Grant SELECT permission on each table to USER_ROLE
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.Customers_View TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.Promocodes_View TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.Bank_Account_View TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.Card_View TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.Album_View TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.Songs_View TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.Playlists_View TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.Songs_Playlist_View TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.Downloaded_Songs_View TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.History_View TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.Payment_Method_View TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.Transaction_View TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.User_Recommendation TO USER_ROLE';
      EXECUTE IMMEDIATE 'GRANT SELECT ON DATABASE_ADMIN.Promocodes_Expiring_Soon TO USER_ROLE';


      DBMS_OUTPUT.PUT_LINE('USER_ROLE is created');
   END IF;

   -- Check if the user 'Pavan' already exists
   ncount := 0; -- Reset the counter
   SELECT COUNT(1) INTO ncount FROM ALL_USERS WHERE USERNAME = 'Pavan';

   IF (ncount > 0) THEN
      DBMS_OUTPUT.PUT_LINE('User Pavan ALREADY EXISTS');
   ELSE
      -- Create the user 'Pavan' if it doesn't exist
      BEGIN
         EXECUTE IMMEDIATE 'CREATE USER Pavan IDENTIFIED BY Password#123';
         DATABASE_ADMIN.UserInsertPackage.InsertCustomer('Pavan', 'Password123', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 'M');
         EXECUTE IMMEDIATE 'GRANT USER_ROLE TO Pavan';
         DBMS_OUTPUT.PUT_LINE('User Pavan is created successfully');
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
      END;
   END IF;
END;
/

------Insert script

BEGIN
  DATABASE_ADMIN.UserInsertPackage.InsertCustomer('Sai', 'pass123', TO_DATE('1988-03-18', 'YYYY-MM-DD'), 'M');
  DATABASE_ADMIN.UserInsertPackage.InsertCustomer('Madhav', 'pass123', TO_DATE('2000-03-18', 'YYYY-MM-DD'), 'M');
END;
/

BEGIN
  DATABASE_ADMIN.UserInsertPackage.InsertBankAccount(123412789, 'Pavan Madhav', 987654321, 'Checking');
  DATABASE_ADMIN.UserInsertPackage.InsertBankAccount(990654321, 'Srikanth', 123456789, 'Savings');
END;
/
  
BEGIN
  DATABASE_ADMIN.UserInsertPackage.InsertCard(1133222233334444, 'Alice', 'Smith', TO_DATE('2025-05', 'YYYY-MM'), 321, '54321');
  DATABASE_ADMIN.UserInsertPackage.InsertCard(4224333322221111, 'Bob', 'Johnson', TO_DATE('2026-06', 'YYYY-MM'), 123, '98765');  
END;
/  

BEGIN
    DATABASE_ADMIN.UserInsertPackage.InsertPlaylist('Playlist1', 3);
    DATABASE_ADMIN.UserInsertPackage.InsertPlaylist('Playlsit2', 2);
END;
/

BEGIN
  DATABASE_ADMIN.UserInsertPackage.AddSongToPlaylist(3, 1);
  DATABASE_ADMIN.UserInsertPackage.AddSongToPlaylist(5, 5);
END;
/
  
BEGIN
    DATABASE_ADMIN.UserInsertPackage.InsertDownloadedSong(1, 1);
    DATABASE_ADMIN.UserInsertPackage.InsertDownloadedSong(5, 2);
END;
/

BEGIN
    DATABASE_ADMIN.UserInsertPackage.InsertHistory(2, 1, TO_DATE('2023-12-02', 'YYYY-MM-DD'));
    DATABASE_ADMIN.UserInsertPackage.InsertHistory(1, 1, TO_DATE('2023-12-02', 'YYYY-MM-DD'));
END;
/



-- Select statement for Customers_View in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.Customers_View;

-- Select statement for Promocodes_View in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.Promocodes_View;

-- Select statement for Bank_Account_View in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.Bank_Account_View;

-- Select statement for Card_View in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.Card_View;

-- Select statement for Album_View in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.Album_View;

-- Select statement for Songs_View in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.Songs_View;

-- Select statement for Playlists_View in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.Playlists_View;

-- Select statement for Songs_Playlist_View in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.Songs_Playlist_View;

-- Select statement for Downloaded_Songs_View in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.Downloaded_Songs_View;

-- Select statement for History_View in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.History_View;

-- Select statement for Payment_Method_View in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.Payment_Method_View;

-- Select statement for Transaction_View in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.Transaction_View;


-- Select statement for User_Recommendation view in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.User_Recommendation;

-- Select statement for Promocodes_Expiring_Soon view in DATABASE_ADMIN schema
SELECT * FROM DATABASE_ADMIN.Promocodes_Expiring_Soon;

