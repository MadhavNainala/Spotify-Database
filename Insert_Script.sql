
CREATE OR REPLACE PROCEDURE InsertCustomer(
    p_profile_name VARCHAR2,
    p_password VARCHAR2,
    p_dob DATE,
    p_gender VARCHAR2,
    p_subscription CHAR
) IS
  v_count NUMBER;
BEGIN
    IF p_profile_name IS NULL OR p_password IS NULL OR p_dob IS NULL OR p_gender IS NULL OR p_subscription IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'All parameters must be non-NULL');
    END IF;

  -- Check for unique profile name
  SELECT COUNT(1) INTO v_count FROM Customers WHERE Profile_Name = p_profile_name;
  IF v_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20004, 'Profile name must be unique.');
  END IF;
  
  INSERT INTO Customers(Profile_Name, Password, DOB, Gender, Subscription)
  VALUES (p_profile_name, p_password, p_dob, p_gender, p_subscription);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
        RAISE;
END;
/


CREATE OR REPLACE PROCEDURE InsertPromocode(
    p_promocode_name VARCHAR2,
    p_discount NUMBER,
    p_expiry_date DATE
) IS
    v_existing_count NUMBER;
BEGIN
    -- Check if the promocode already exists
    SELECT COUNT(1) INTO v_existing_count
    FROM Promocodes
    WHERE Promocode_Name = p_promocode_name;

    IF v_existing_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Promocode already exists');
    END IF;

    IF p_promocode_name IS NULL OR p_discount IS NULL OR p_expiry_date IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'All parameters must be non-NULL');
    END IF;

    -- Insert into Promocodes table
    INSERT INTO Promocodes(Promocode_Name, Discount, Expiry_Date)
    VALUES(p_promocode_name, p_discount, p_expiry_date);

    COMMIT;
    DBMS_OUTPUT.put_line('Promocode data inserted successfully');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/




CREATE OR REPLACE PROCEDURE InsertPaymentMethod(
    p_payment_type VARCHAR2,
    p_customer_id NUMBER,
    p_promocode_id NUMBER
) IS
BEGIN
    
    IF p_payment_type IS NULL OR p_customer_id IS NULL OR p_promocode_id IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'All parameters must be non-NULL');
    END IF;

    -- Insert into Payment_Method table
    INSERT INTO Payment_Method(Payment_Type, Customer_Id, Promocode_Id)
    VALUES(p_payment_type, p_customer_id, p_promocode_id);

    COMMIT;
    DBMS_OUTPUT.put_line('Payment Method data inserted successfully');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/


CREATE OR REPLACE PROCEDURE InsertBankAccount(
    p_account_number NUMBER,
    p_full_name VARCHAR2,
    p_routing_number NUMBER,
    p_account_type VARCHAR2,
    p_account_limit NUMBER,
    p_payment_id NUMBER
) IS
BEGIN
    IF p_account_number IS NULL OR p_full_name IS NULL OR p_routing_number IS NULL OR
       p_account_type IS NULL OR p_account_limit IS NULL OR p_payment_id IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'All parameters must be non-NULL');
    END IF;

    -- Insert into Bank_Account table
    INSERT INTO Bank_Account(Account_Number, Full_Name, Routing_Number, Account_Type, Account_Limit, Payment_Id)
    VALUES(p_account_number, p_full_name, p_routing_number, p_account_type, p_account_limit, p_payment_id);

    COMMIT;
    DBMS_OUTPUT.put_line('Bank Account data inserted successfully');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/


CREATE OR REPLACE PROCEDURE InsertCard(
    p_card_number NUMBER,
    p_first_name VARCHAR2,
    p_last_name VARCHAR2,
    p_expiry_date DATE,
    p_cvv_code NUMBER,
    p_zip VARCHAR2,
    p_payment_id NUMBER
) IS
BEGIN
    
    IF p_card_number IS NULL OR p_first_name IS NULL OR p_last_name IS NULL OR
       p_expiry_date IS NULL OR p_cvv_code IS NULL OR p_zip IS NULL OR p_payment_id IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'All parameters must be non-NULL');
    END IF;

    -- Insert into Card table
    INSERT INTO Card(Card_Number, First_Name, Last_Name, Expiry_Date, CVV_Code, Zip, Payment_Id)
    VALUES(p_card_number, p_first_name, p_last_name, p_expiry_date, p_cvv_code, p_zip, p_payment_id);

    COMMIT;
    DBMS_OUTPUT.put_line('Card data inserted successfully');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/



CREATE OR REPLACE PROCEDURE InsertTransaction(
    p_transaction_time TIMESTAMP,
    p_price NUMBER,
    p_customer_id NUMBER,
    p_active VARCHAR2,
    p_start_date DATE,
    p_end_date DATE
) IS
BEGIN
    
    IF p_transaction_time IS NULL OR p_price IS NULL OR p_customer_id IS NULL OR
       p_active IS NULL OR p_start_date IS NULL OR p_end_date IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'All parameters must be non-NULL');
    END IF;

    -- Insert into Transaction table
    INSERT INTO Transaction(Transaction_Time, Price, Customer_Id, Active, Start_Date, End_Date)
    VALUES(p_transaction_time, p_price, p_customer_id, p_active, p_start_date, p_end_date);

    COMMIT;
    DBMS_OUTPUT.put_line('Transaction data inserted successfully');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/



CREATE OR REPLACE PROCEDURE InsertAlbum(
    p_album_name VARCHAR2
) IS
BEGIN
    
    IF p_album_name IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'Album name must be non-NULL');
    END IF;

    -- Insert into Album table
    INSERT INTO Album(Album_Name)
    VALUES(p_album_name);

    COMMIT;
    DBMS_OUTPUT.put_line('Album data inserted successfully');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/


CREATE OR REPLACE PROCEDURE InsertSong(
    p_song_name VARCHAR2,
    p_language VARCHAR2,
    p_genre VARCHAR2,
    p_album_id NUMBER
) IS
BEGIN
    
    IF p_song_name IS NULL OR p_language IS NULL OR p_genre IS NULL OR p_album_id IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'All parameters must be non-NULL');
    END IF;

    -- Insert into Songs table
    INSERT INTO Songs(Song_Name, Language, Genre, Album_Id)
    VALUES(p_song_name, p_language, p_genre, p_album_id);

    COMMIT;
    DBMS_OUTPUT.put_line('Song data inserted successfully');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/



CREATE OR REPLACE PROCEDURE InsertPlaylist(
    p_playlist_name VARCHAR2,
    p_customer_id NUMBER,
    p_song_id NUMBER
) IS
    v_customer_count NUMBER;
    v_song_count NUMBER;
BEGIN
    -- Check if all parameters are non-NULL
    IF p_playlist_name IS NULL OR p_customer_id IS NULL OR p_song_id IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'All parameters must be non-NULL');
    END IF;

    -- Check if the provided Customer_Id exists in the Customers table
    SELECT COUNT(1) INTO v_customer_count FROM Customers WHERE Customer_Id = p_customer_id;

    IF v_customer_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Invalid Customer_Id');
    END IF;

    -- Check if the provided Song_Id exists in the Songs table
    SELECT COUNT(1) INTO v_song_count FROM Songs WHERE Song_Id = p_song_id;

    IF v_song_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Invalid Song_Id');
    END IF;

    -- Insert into Playlists table
    INSERT INTO Playlists(Playlist_Name, Customer_Id, Song_Id)
    VALUES(p_playlist_name, p_customer_id, p_song_id);

    COMMIT;
    DBMS_OUTPUT.put_line('Playlist data inserted successfully');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/




CREATE OR REPLACE PROCEDURE InsertDownloadedSong(
    p_customer_id NUMBER,
    p_song_id NUMBER
) IS
BEGIN
    
    IF p_customer_id IS NULL OR p_song_id IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'All parameters must be non-NULL');
    END IF;

    -- Insert into Downloaded_Songs table
    INSERT INTO Downloaded_Songs(Customer_Id, Song_Id)
    VALUES(p_customer_id, p_song_id);

    COMMIT;
    DBMS_OUTPUT.put_line('Downloaded Song data inserted successfully');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/




CREATE OR REPLACE PROCEDURE InsertHistory(
    p_song_id NUMBER,
    p_customer_id NUMBER,
    p_history_date DATE
) IS
BEGIN
    
    IF p_song_id IS NULL OR p_customer_id IS NULL OR p_history_date IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'All parameters must be non-NULL');
    END IF;

    -- Insert into History table
    INSERT INTO History(Song_Id, Customer_Id, History_Date)
    VALUES(p_song_id, p_customer_id, p_history_date);

    COMMIT;
    DBMS_OUTPUT.put_line('History data inserted successfully');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/




CREATE OR REPLACE TRIGGER UpdateSubscriptionStatus
AFTER INSERT ON Transaction
FOR EACH ROW
DECLARE
  v_today DATE := SYSDATE;
BEGIN
  IF :NEW.End_Date <= v_today THEN
    UPDATE Customers SET Subscription = 'N' WHERE Customer_Id = :NEW.Customer_Id;
  END IF;
END;
/



BEGIN
    -- Customer 1
    InsertCustomer('JohnDoe', 'password1', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'Male', 'S');

    -- Customer 2
    InsertCustomer('JaneSmith', 'password2', TO_DATE('1988-11-30', 'YYYY-MM-DD'), 'Female', 'P');

    -- Customer 3
    InsertCustomer('BobJohnson', 'password3', TO_DATE('1995-03-22', 'YYYY-MM-DD'), 'Male', 'S');

    -- Customer 4
    InsertCustomer('AliceWilliams', 'password4', TO_DATE('1985-07-10', 'YYYY-MM-DD'), 'Female', 'S');

    -- Customer 5
    InsertCustomer('CharlieBrown', 'password5', TO_DATE('1992-09-18', 'YYYY-MM-DD'), 'Male', 'P');

    -- Customer 6
    InsertCustomer('EvaMartinez', 'password6', TO_DATE('1987-12-05', 'YYYY-MM-DD'), 'Female', 'S');

    -- Customer 7
    InsertCustomer('DavidSmithson', 'password7', TO_DATE('1998-02-28', 'YYYY-MM-DD'), 'Male', 'S');

    -- Customer 8
    InsertCustomer('GraceTurner', 'password8', TO_DATE('1993-06-25', 'YYYY-MM-DD'), 'Female', 'S');

    -- Customer 9
    InsertCustomer('FrankMiller', 'password9', TO_DATE('1989-04-14', 'YYYY-MM-DD'), 'Male', 'S');

    -- Customer 10
    InsertCustomer('HelenJohnson', 'password10', TO_DATE('1996-08-08', 'YYYY-MM-DD'), 'Female', 'S');

    COMMIT;
END;
/


BEGIN
    -- Promocode 1
    InsertPromocode('SUMMER2023', 10, TO_DATE('2023-08-31', 'YYYY-MM-DD'));

    -- Promocode 2
    InsertPromocode('FALLSALE', 15, TO_DATE('2023-11-30', 'YYYY-MM-DD'));

    -- Promocode 3
    InsertPromocode('HOLIDAY25', 25, TO_DATE('2023-12-25', 'YYYY-MM-DD'));

    -- Promocode 4
    InsertPromocode('NEWYEAR2024', 30, TO_DATE('2024-01-31', 'YYYY-MM-DD'));

    -- Promocode 5
    InsertPromocode('SPRING40', 40, TO_DATE('2024-04-30', 'YYYY-MM-DD'));

    -- Promocode 6
    InsertPromocode('MEMORIAL15', 15, TO_DATE('2024-05-31', 'YYYY-MM-DD'));

    -- Promocode 7
    InsertPromocode('FATHERSDAY', 20, TO_DATE('2024-06-30', 'YYYY-MM-DD'));

    -- Promocode 8
    InsertPromocode('BACKTOSCHOOL', 10, TO_DATE('2024-09-30', 'YYYY-MM-DD'));

    -- Promocode 9
    InsertPromocode('HALLOWEEN20', 20, TO_DATE('2024-10-31', 'YYYY-MM-DD'));

    -- Promocode 10
    InsertPromocode('BLACKFRIDAY50', 50, TO_DATE('2024-11-30', 'YYYY-MM-DD'));

    COMMIT;
END;
/



BEGIN
    -- Payment Method 1
    InsertPaymentMethod('Card', 1, 1);

    -- Payment Method 2
    InsertPaymentMethod('Bank Account', 2, 2);

    -- Payment Method 3
    InsertPaymentMethod('Card', 3, 3);

    -- Payment Method 4
    InsertPaymentMethod('Bank Account', 4, 4);

    -- Payment Method 5
    InsertPaymentMethod('Card', 5, 5);

    -- Payment Method 6
    InsertPaymentMethod('Bank Account', 6, 6);

    -- Payment Method 7
    InsertPaymentMethod('Card', 7, 7);

    -- Payment Method 8
    InsertPaymentMethod('Bank Account', 8, 8);

    -- Payment Method 9
    InsertPaymentMethod('Card', 9, 9);

    -- Payment Method 10
    InsertPaymentMethod('Bank Account', 10, 10);

    COMMIT;
END;
/


BEGIN
    
    InsertBankAccount(987654321, 'William Brown', 123456789, 'Savings', 5000, 1); 
    InsertBankAccount(876543210, 'Emma Johnson', 234567890, 'Checking', 7000, 2);
    InsertBankAccount(765432109, 'Christopher Lee', 345678901, 'Savings', 6000, 3);
    InsertBankAccount(654321098, 'Olivia Davis', 456789012, 'Checking', 8000, 4);
    InsertBankAccount(543210987, 'Michael Wilson', 567890123, 'Savings', 5500, 5);
    InsertBankAccount(432109876, 'Sophia Smith', 678901234, 'Checking', 7200, 6);
    InsertBankAccount(321098765, 'Matthew Taylor', 789012345, 'Savings', 6500, 7);
    InsertBankAccount(210987654, 'Ava Brown', 890123456, 'Checking', 9000, 8);
    InsertBankAccount(109876543, 'Ethan Davis', 901234567, 'Savings', 7500, 9);
    InsertBankAccount(9876543210, 'Emily Martinez', 123456780, 'Checking', 8500, 10);

    COMMIT;
END;
/



BEGIN
    
    InsertCard(1234567812345678, 'John', 'Doe', TO_DATE('2024-12-31', 'YYYY-MM-DD'), 123, '12345', 1);
    InsertCard(2345678923456789, 'Jane', 'Smith', TO_DATE('2023-11-30', 'YYYY-MM-DD'), 456, '67890', 2);
    InsertCard(3456789034567890, 'Bob', 'Johnson', TO_DATE('2025-02-28', 'YYYY-MM-DD'), 789, '54321', 3);
    InsertCard(4567890145678901, 'Alice', 'Williams', TO_DATE('2024-08-31', 'YYYY-MM-DD'), 321, '98765', 4);
    InsertCard(5678901256789012, 'Charlie', 'Brown', TO_DATE('2023-10-31', 'YYYY-MM-DD'), 654, '23456', 5);
    InsertCard(6789012367890123, 'Eva', 'Miller', TO_DATE('2025-01-31', 'YYYY-MM-DD'), 987, '87654', 6);
    InsertCard(7890123478901234, 'David', 'Jones', TO_DATE('2024-04-30', 'YYYY-MM-DD'), 159, '32198', 7);
    InsertCard(8901234589012345, 'Sophia', 'Davis', TO_DATE('2023-12-31', 'YYYY-MM-DD'), 753, '65432', 8);
    InsertCard(9012345690123456, 'Mason', 'White', TO_DATE('2024-06-30', 'YYYY-MM-DD'), 246, '78901', 9);
    InsertCard(1234567812345670, 'Olivia', 'Martinez', TO_DATE('2025-03-31', 'YYYY-MM-DD'), 852, '10293', 10);

    COMMIT;
END;
/



BEGIN
    -- Transaction 1
    InsertTransaction(SYSTIMESTAMP, 20.50, 1, 'Yes', TO_DATE('01-11-2023', 'DD-MM-YYYY'), TO_DATE('01-12-2023', 'DD-MM-YYYY'));

    -- Transaction 2
    InsertTransaction(SYSTIMESTAMP, 15.75, 2, 'Yes', TO_DATE('02-11-2023', 'DD-MM-YYYY'), TO_DATE('02-12-2023', 'DD-MM-YYYY'));

    -- Transaction 3
    InsertTransaction(SYSTIMESTAMP, 30.00, 3, 'Yes', TO_DATE('03-11-2023', 'DD-MM-YYYY'), TO_DATE('03-12-2023', 'DD-MM-YYYY'));

    -- Transaction 4
    InsertTransaction(SYSTIMESTAMP, 25.90, 4, 'No', TO_DATE('04-11-2023', 'DD-MM-YYYY'), TO_DATE('04-12-2023', 'DD-MM-YYYY'));

    -- Transaction 5
    InsertTransaction(SYSTIMESTAMP, 18.60, 5, 'Yes', TO_DATE('05-11-2023', 'DD-MM-YYYY'), TO_DATE('05-12-2023', 'DD-MM-YYYY'));

    -- Transaction 6
    InsertTransaction(SYSTIMESTAMP, 22.75, 6, 'No', TO_DATE('06-11-2023', 'DD-MM-YYYY'), TO_DATE('06-12-2023', 'DD-MM-YYYY'));

    -- Transaction 7
    InsertTransaction(SYSTIMESTAMP, 35.20, 7, 'Yes', TO_DATE('07-11-2023', 'DD-MM-YYYY'), TO_DATE('07-12-2023', 'DD-MM-YYYY'));

    -- Transaction 8
    InsertTransaction(SYSTIMESTAMP, 28.45, 8, 'No', TO_DATE('08-11-2023', 'DD-MM-YYYY'), TO_DATE('08-12-2023', 'DD-MM-YYYY'));

    -- Transaction 9
    InsertTransaction(SYSTIMESTAMP, 32.80, 9, 'Yes', TO_DATE('09-11-2023', 'DD-MM-YYYY'), TO_DATE('09-12-2023', 'DD-MM-YYYY'));

    -- Transaction 10
    InsertTransaction(SYSTIMESTAMP, 19.99, 10, 'Yes', TO_DATE('10-11-2023', 'DD-MM-YYYY'), TO_DATE('10-12-2023', 'DD-MM-YYYY'));

    COMMIT;
END;
/



BEGIN
    -- Album 1
    InsertAlbum('Harmony Heights');

    -- Album 2
    InsertAlbum('Echoes of Eternity');

    -- Album 3
    InsertAlbum('Serendipity Sounds');

    -- Album 4
    InsertAlbum('Urban Rhapsody');

    -- Album 5
    InsertAlbum('Melodic Memoirs');

    -- Album 6
    InsertAlbum('Celestial Serenade');

    -- Album 7
    InsertAlbum('Whispering Winds');

    -- Album 8
    InsertAlbum('Radiant Reflections');

    -- Album 9
    InsertAlbum('Mystic Melodies');

    -- Album 10
    InsertAlbum('Enchanted Euphony');

    COMMIT;
END;
/



BEGIN
    -- Song 1
    InsertSong('Melodic Sunset', 'English', 'Pop', 1);

    -- Song 2
    InsertSong('Celestial Echo', 'English', 'Rock', 2);

    -- Song 3
    InsertSong('Serendipitous Serenade', 'English', 'Hip Hop', 3);

    -- Song 4
    InsertSong('City Lights Sonata', 'English', 'R&B', 4);

    -- Song 5
    InsertSong('Nostalgic Notes', 'English', 'Country', 5);

    -- Song 6
    InsertSong('Stellar Sonata', 'English', 'Electronic', 6);

    -- Song 7
    InsertSong('Whispers in the Wind', 'English', 'Blues', 7);

    -- Song 8
    InsertSong('Reflective Rhythms', 'English', 'Jazz', 8);

    -- Song 9
    InsertSong('Mystical Groove', 'English', 'Indie', 9);

    -- Song 10
    InsertSong('Enchanted Melody', 'English', 'Alternative', 10);

    COMMIT;
END;
/



BEGIN
    -- Playlist 1
    InsertPlaylist('Chill Vibes', 1, 2);

    -- Playlist 2
    InsertPlaylist('Feel Good Mix', 2, 3);

    -- Playlist 3
    InsertPlaylist('Road Trip Jams', 3, 4);

    -- Playlist 4
    InsertPlaylist('Study Beats', 4, 6);

    -- Playlist 5
    InsertPlaylist('Party Anthems', 5, 10);

    -- Playlist 6
    InsertPlaylist('Epic Soundscapes', 6, 1);

    -- Playlist 7
    InsertPlaylist('Soulful Tunes', 7, 5);

    -- Playlist 8
    InsertPlaylist('Jazz Classics', 8, 7);

    -- Playlist 9
    InsertPlaylist('Indie Vibes', 9, 8);

    -- Playlist 10
    InsertPlaylist('Alternative Grooves', 10, 9);

    COMMIT;
END;
/



BEGIN
    -- Customer 1 Downloads
    InsertDownloadedSong(1, 1);
    InsertDownloadedSong(1, 4);
    InsertDownloadedSong(1, 7);

    -- Customer 2 Downloads
    InsertDownloadedSong(2, 2);
    InsertDownloadedSong(2, 5);
    InsertDownloadedSong(2, 8);

    -- Customer 3 Downloads
    InsertDownloadedSong(3, 3);
    InsertDownloadedSong(3, 6);
    InsertDownloadedSong(3, 9);

    -- Customer 4 Downloads
    InsertDownloadedSong(4, 10);

    COMMIT;
END;
/



BEGIN
    -- Customer 1 History
    InsertHistory(1, 1, TO_DATE('2023-11-01', 'YYYY-MM-DD'));
    InsertHistory(1, 4, TO_DATE('2023-11-05', 'YYYY-MM-DD'));
    InsertHistory(1, 7, TO_DATE('2023-11-10', 'YYYY-MM-DD'));

    -- Customer 2 History
    InsertHistory(2, 2, TO_DATE('2023-11-02', 'YYYY-MM-DD'));
    InsertHistory(2, 5, TO_DATE('2023-11-06', 'YYYY-MM-DD'));
    InsertHistory(2, 8, TO_DATE('2023-11-11', 'YYYY-MM-DD'));

    -- Customer 3 History
    InsertHistory(3, 3, TO_DATE('2023-11-03', 'YYYY-MM-DD'));
    InsertHistory(3, 6, TO_DATE('2023-11-07', 'YYYY-MM-DD'));
    InsertHistory(3, 9, TO_DATE('2023-11-12', 'YYYY-MM-DD'));

    -- Customer 4 History
    InsertHistory(4, 10, TO_DATE('2023-11-08', 'YYYY-MM-DD'));

    COMMIT;
END;
/
