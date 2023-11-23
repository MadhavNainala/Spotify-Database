CREATE OR REPLACE PROCEDURE InsertCustomer(
    p_profile_name VARCHAR2,
    p_password VARCHAR2,
    p_dob DATE,
    p_gender VARCHAR2,
    p_subscription CHAR
) IS
  v_count NUMBER;
  v_actual_subscription CHAR := p_subscription; -- Local variable for handling NULL
BEGIN
  -- Check for unique profile name
  SELECT COUNT(1) INTO v_count FROM Customers WHERE Profile_Name = p_profile_name;
  IF v_count > 0 THEN
    -- Profile name already exists, so skip the insertion
    RETURN;
  END IF;

  -- If subscription is null, consider it as 'no'
  IF v_actual_subscription IS NULL THEN
    v_actual_subscription := 'N';
  END IF;

  -- Insert customer
  INSERT INTO Customers(Profile_Name, Password, DOB, Gender, Subscription)
  VALUES (p_profile_name, p_password, p_dob, p_gender, v_actual_subscription);

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/



CREATE OR REPLACE PROCEDURE InsertPaymentMethod(
    p_payment_type VARCHAR2,
    p_customer_id NUMBER
) IS
    TYPE t_allowed_types IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    v_allowed_types t_allowed_types;
    v_type_exists BOOLEAN := FALSE;
BEGIN
    v_allowed_types(1) := 'Card';
    v_allowed_types(2) := 'Bank_Account';

    -- Check if the type exists in the array
    FOR i IN 1 .. v_allowed_types.COUNT LOOP
        IF v_allowed_types(i) = p_payment_type THEN
            v_type_exists := TRUE;
            EXIT;
        END IF;
    END LOOP;

    IF v_type_exists THEN
        INSERT INTO Payment_Method(Payment_Type, Customer_Id)
        VALUES (p_payment_type, p_customer_id);
    ELSE
        RAISE_APPLICATION_ERROR(-20002, 'Invalid payment type.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE PROCEDURE InsertTransaction(
    p_transaction_time TIMESTAMP,
    p_price NUMBER,
    p_customer_id NUMBER,
    p_active VARCHAR2,
    p_start_date DATE,
    p_end_date DATE,
    p_promocode_id NUMBER
) IS
    v_active VARCHAR2(1);
    v_exist_active NUMBER;
    v_discount NUMBER;
BEGIN
    -- Check if there's already an active transaction for this customer
    SELECT COUNT(*)
    INTO v_exist_active
    FROM Transaction
    WHERE Customer_Id = p_customer_id AND Active = 'Y';

    IF v_exist_active = 0 THEN
        -- Check if Promocode_Id is null or not
        IF p_promocode_id IS NULL THEN
            v_discount := 0; -- No discount if Promocode_Id is null
        ELSE
            -- Retrieve the discount value from the Promocode table based on Promocode_Id
            SELECT Discount
            INTO v_discount
            FROM Promocodes
            WHERE Promocode_Id = p_promocode_id;
        END IF;

        -- Determine if the current date is within the start and end dates
        IF SYSDATE BETWEEN p_start_date AND p_end_date THEN
            -- Check if Price + Discount is equal to 10
            IF (p_price + v_discount) >= 10 THEN
                v_active := 'Y';
            ELSE
                v_active := 'N';
            END IF;
        ELSE
            v_active := 'N'; -- Set Active to 'N' if the current date is past the end date
        END IF;

        -- Insert the transaction
        INSERT INTO Transaction (Transaction_Time, Price, Customer_Id, Active, Start_Date, End_Date, Promocode_Id)
        VALUES (p_transaction_time, p_price, p_customer_id, v_active, p_start_date, p_end_date, p_promocode_id);
        DBMS_OUTPUT.PUT_LINE('Transaction successfully inserted.');
    ELSE
        -- Output a message indicating that a new transaction cannot be inserted
        DBMS_OUTPUT.PUT_LINE('Cannot insert transaction: active transaction already exists for this customer.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        -- Output the error message
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        -- Optionally re-raise the error
        RAISE;
END;
/




CREATE OR REPLACE PROCEDURE InsertBankAccount(
    p_account_number NUMBER,
    p_full_name VARCHAR2,
    p_routing_number NUMBER,
    p_account_type VARCHAR2
) IS
    v_count NUMBER;
BEGIN
    -- Check if the account number already exists
    SELECT COUNT(1) INTO v_count FROM Bank_Account WHERE Account_Number = p_account_number;

    -- If the account number exists, handle accordingly
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate Bank Account Number: ' || p_account_number);
        -- Optionally, you can return, raise a custom exception, or handle it differently
        RETURN;
    END IF;

    -- If the account number does not exist, proceed with the insertion
    INSERT INTO Bank_Account(Account_Number, Full_Name, Routing_Number, Account_Type)
    VALUES (p_account_number, p_full_name, p_routing_number, p_account_type);

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
/



CREATE OR REPLACE PROCEDURE InsertCard(
    p_card_number NUMBER,
    p_first_name VARCHAR2,
    p_last_name VARCHAR2,
    p_expiry_date DATE,
    p_cvv_code NUMBER,
    p_zip VARCHAR2
) IS
    v_count NUMBER;
BEGIN
    -- Check if the card number already exists
    SELECT COUNT(1) INTO v_count FROM Card WHERE Card_Number = p_card_number;

    -- If the card number exists, handle accordingly
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate Card Number: ' || p_card_number);
        -- Optionally, you can return, raise a custom exception, or handle it differently
        RETURN;
    END IF;

    -- If the card number does not exist, proceed with the insertion
    INSERT INTO Card(Card_Number, First_Name, Last_Name, Expiry_Date, CVV_Code, Zip)
    VALUES (p_card_number, p_first_name, p_last_name, p_expiry_date, p_cvv_code, p_zip);

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
/



CREATE OR REPLACE PROCEDURE InsertSong(
    p_song_name VARCHAR2,
    p_language VARCHAR2,
    p_genre VARCHAR2,
    p_album_id NUMBER
) IS
    v_count NUMBER;
BEGIN
    -- Check if the same song name exists in the specified album
    SELECT COUNT(1) INTO v_count FROM Songs WHERE Song_Name = p_song_name AND Album_Id = p_album_id;

    -- If the song name already exists in the album, handle accordingly
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate Song Name in the Album: ' || p_song_name);
        -- Optionally, you can return, raise a custom exception, or handle it differently
        RETURN;
    END IF;

    -- If the song name does not exist in the album, proceed with the insertion
    INSERT INTO Songs(Song_Name, Language, Genre, Album_Id)
    VALUES (p_song_name, p_language, p_genre, p_album_id);

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
/




CREATE OR REPLACE PROCEDURE InsertPlaylist (
    p_playlist_name VARCHAR2,
    p_customer_id NUMBER,
    p_song_id NUMBER
) IS
    v_count NUMBER;
BEGIN
    -- Check if the playlist name already exists
    SELECT COUNT(1) INTO v_count FROM Playlists WHERE Playlist_Name = p_playlist_name;

    -- If the playlist name exists, handle accordingly
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate Playlist Name: ' || p_playlist_name);
        -- Optionally, you can return, raise a custom exception, or handle it differently
        RETURN;
    END IF;

    -- If the playlist name does not exist, proceed with the insertion
    INSERT INTO Playlists(Playlist_Name, Customer_Id, Song_Id)
    VALUES (p_playlist_name, p_customer_id, p_song_id);

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
/


CREATE OR REPLACE PROCEDURE InsertDownloadedSong(
    p_customer_id NUMBER,
    p_song_id NUMBER
) IS
  v_subscription CHAR;
  v_download_count NUMBER;
BEGIN
  -- Check if the customer has an active subscription
  SELECT Subscription INTO v_subscription FROM Customers WHERE Customer_Id = p_customer_id;
  
  IF v_subscription IS NULL OR v_subscription = 'N' THEN
    -- Customer does not have an active subscription, print message
    DBMS_OUTPUT.PUT_LINE('Customer ID ' || p_customer_id || ' does not have an active subscription.');
    RETURN;
  END IF;

  -- Check if the song has already been downloaded by the customer
  SELECT COUNT(*)
  INTO v_download_count
  FROM Downloaded_Songs
  WHERE Customer_Id = p_customer_id AND Song_Id = p_song_id;

  IF v_download_count > 0 THEN
    -- Song has already been downloaded, print message
    DBMS_OUTPUT.PUT_LINE('Song ID ' || p_song_id || ' has already been downloaded by Customer ID ' || p_customer_id || '.');
    RETURN;
  END IF;

  -- Insert into Downloaded_Songs table
  INSERT INTO Downloaded_Songs(Customer_Id, Song_Id)
  VALUES (p_customer_id, p_song_id);

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Customer ID ' || p_customer_id || ' not found.');
  WHEN OTHERS THEN
    RAISE;
END;
/




CREATE OR REPLACE PROCEDURE InsertHistory(
    p_song_id NUMBER,
    p_customer_id NUMBER,
    p_history_date DATE
) IS
BEGIN
  INSERT INTO History(Song_Id, Customer_Id, History_Date)
  VALUES (p_song_id, p_customer_id, p_history_date);
EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/

CREATE OR REPLACE PROCEDURE InsertPromocode(
    p_promocode_name VARCHAR2,
    p_discount NUMBER,
    p_expiry_date DATE
) IS
    v_count NUMBER;
BEGIN
    -- Check if the discount is less than 20%
    IF p_discount >= 20 THEN
        DBMS_OUTPUT.PUT_LINE('Discount must be less than 20. Given discount: ' || p_discount);
        RETURN;
    END IF;

    -- Check if the promocode name already exists
    SELECT COUNT(1) INTO v_count FROM Promocodes WHERE Promocode_Name = p_promocode_name;

    -- If the promocode name exists, handle accordingly
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate Promocode Name: ' || p_promocode_name);
        -- Optionally, you can return, raise a custom exception, or handle it differently
        RETURN;
    END IF;

    -- If the promocode name does not exist and discount is valid, proceed with the insertion
    INSERT INTO Promocodes(Promocode_Name, Discount, Expiry_Date)
    VALUES (p_promocode_name, p_discount, p_expiry_date);

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
/



CREATE OR REPLACE PROCEDURE InsertAlbum (
  p_album_name VARCHAR2
) IS
BEGIN
  INSERT INTO Album (Album_Name)
  VALUES (p_album_name);
EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/



CREATE OR REPLACE TRIGGER UpdateCustomerSubscription
AFTER INSERT OR UPDATE OF Active ON Transaction
DECLARE
    CURSOR c_active_transactions IS
        SELECT Customer_Id
        FROM Transaction
        WHERE Active = 'Y'
        GROUP BY Customer_Id;

    v_active_count NUMBER;
BEGIN
    FOR rec IN c_active_transactions LOOP
        SELECT COUNT(*)
        INTO v_active_count
        FROM Transaction
        WHERE Customer_Id = rec.Customer_Id AND Active = 'Y';

        IF v_active_count > 0 THEN
            -- Set subscription flag to true for the customer
            UPDATE Customers SET Subscription = 'Y' WHERE Customer_Id = rec.Customer_Id;
        ELSE
            -- Set subscription flag to false as there are no active transactions left
            UPDATE Customers SET Subscription = 'N' WHERE Customer_Id = rec.Customer_Id;
        END IF;
    END LOOP;
END;
/


------------Update tables procedures


CREATE OR REPLACE PROCEDURE UpdateCustomer(
    p_customer_id NUMBER,
    p_new_profile_name VARCHAR2,
    p_password VARCHAR2,
    p_dob DATE,
    p_gender VARCHAR2,
    p_subscription CHAR
) IS
  v_count NUMBER;
BEGIN
  -- Check for unique profile name
  SELECT COUNT(1) INTO v_count FROM Customers WHERE Profile_Name = p_new_profile_name AND Customer_Id != p_customer_id;
  IF v_count > 0 THEN
    -- Instead of raising an error, print a message
    DBMS_OUTPUT.PUT_LINE('Profile name already exists: ' || p_new_profile_name);
    RETURN; -- Exit the procedure
  END IF;

  -- Update customer details
  UPDATE Customers
  SET Profile_Name = p_new_profile_name,
      Password = p_password,
      DOB = p_dob,
      Gender = p_gender,
      Subscription = NVL(p_subscription, 'N')
  WHERE Customer_Id = p_customer_id;

  -- Print success message
  DBMS_OUTPUT.PUT_LINE('Customer updated successfully.');

EXCEPTION
  WHEN OTHERS THEN
    -- Handle other exceptions
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
    -- Optionally re-raise the error
    -- RAISE;
END;
/


CREATE OR REPLACE PROCEDURE UpdatePaymentMethod(
    p_payment_id NUMBER,
    p_new_payment_type VARCHAR2,
    p_customer_id NUMBER
) IS
    TYPE t_allowed_types IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    v_allowed_types t_allowed_types;
    v_type_exists BOOLEAN := FALSE;
BEGIN
    v_allowed_types(1) := 'Card';
    v_allowed_types(2) := 'Bank_Account';

    -- Check if the new type exists in the array
    FOR i IN 1 .. v_allowed_types.COUNT LOOP
        IF v_allowed_types(i) = p_new_payment_type THEN
            v_type_exists := TRUE;
            EXIT;
        END IF;
    END LOOP;

    IF NOT v_type_exists THEN
        DBMS_OUTPUT.PUT_LINE('Invalid payment type: ' || p_new_payment_type);
        RETURN;
    END IF;

    -- Update payment method
    UPDATE Payment_Method
    SET Payment_Type = p_new_payment_type,
        Customer_Id = p_customer_id
    WHERE Payment_Id = p_payment_id;

    DBMS_OUTPUT.PUT_LINE('Payment method updated successfully.');

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE UpdateTransaction(
    p_transaction_id NUMBER,
    p_transaction_time TIMESTAMP,
    p_price NUMBER,
    p_customer_id NUMBER,
    p_active VARCHAR2,
    p_start_date DATE,
    p_end_date DATE,
    p_promocode_id NUMBER
) IS
    v_exist_active NUMBER;
BEGIN
    -- Check for active transaction
    SELECT COUNT(*)
    INTO v_exist_active
    FROM Transaction
    WHERE Customer_Id = p_customer_id AND Active = 'Y' AND Transaction_Id != p_transaction_id;

    IF v_exist_active > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Active transaction already exists for this customer.');
        RETURN;
    END IF;

    -- Check promo code logic as per your business rules...

    -- Update the transaction
    UPDATE Transaction
    SET Transaction_Time = p_transaction_time,
        Price = p_price,
        Customer_Id = p_customer_id,
        Active = p_active,
        Start_Date = p_start_date,
        End_Date = p_end_date,
        Promocode_Id = p_promocode_id
    WHERE Transaction_Id = p_transaction_id;

    DBMS_OUTPUT.PUT_LINE('Transaction updated successfully.');

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/



CREATE OR REPLACE PROCEDURE UpdateBankAccount(
    p_account_id NUMBER,
    p_new_account_number NUMBER,
    p_full_name VARCHAR2,
    p_routing_number NUMBER,
    p_account_type VARCHAR2
) IS
    v_count NUMBER;
BEGIN
    -- Check if the new account number already exists
    SELECT COUNT(1) INTO v_count FROM Bank_Account WHERE Account_Number = p_new_account_number AND Account_Id != p_account_id;
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate Bank Account Number: ' || p_new_account_number);
        RETURN;
    END IF;

    -- Update bank account details
    UPDATE Bank_Account
    SET Account_Number = p_new_account_number,
        Full_Name = p_full_name,
        Routing_Number = p_routing_number,
        Account_Type = p_account_type
    WHERE Account_Id = p_account_id;

    DBMS_OUTPUT.PUT_LINE('Bank account updated successfully.');

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE UpdateCard(
    p_card_id NUMBER,
    p_new_card_number NUMBER,
    p_first_name VARCHAR2,
    p_last_name VARCHAR2,
    p_expiry_date DATE,
    p_cvv_code NUMBER,
    p_zip VARCHAR2
) IS
    v_count NUMBER;
BEGIN
    -- Check if the new card number already exists
    SELECT COUNT(1) INTO v_count FROM Card WHERE Card_Number = p_new_card_number AND Card_Id != p_card_id;
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate Card Number: ' || p_new_card_number);
        RETURN;
    END IF;

    -- Update card details
    UPDATE Card
    SET Card_Number = p_new_card_number,
        First_Name = p_first_name,
        Last_Name = p_last_name,
        Expiry_Date = p_expiry_date,
        CVV_Code = p_cvv_code,
        Zip = p_zip
    WHERE Card_Id = p_card_id;

    DBMS_OUTPUT.PUT_LINE('Card updated successfully.');

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE UpdateSong(
    p_song_id NUMBER,
    p_new_song_name VARCHAR2,
    p_language VARCHAR2,
    p_genre VARCHAR2,
    p_album_id NUMBER
) IS
    v_count NUMBER;
BEGIN
    -- Check if the same song name exists in the specified album
    SELECT COUNT(1) INTO v_count FROM Songs WHERE Song_Name = p_new_song_name AND Album_Id = p_album_id AND Song_Id != p_song_id;
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate Song Name in the Album: ' || p_new_song_name);
        RETURN;
    END IF;

    -- Update song details
    UPDATE Songs
    SET Song_Name = p_new_song_name,
        Language = p_language,
        Genre = p_genre,
        Album_Id = p_album_id
    WHERE Song_Id = p_song_id;

    DBMS_OUTPUT.PUT_LINE('Song updated successfully.');

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE UpdatePlaylist(
    p_playlist_id NUMBER,
    p_new_playlist_name VARCHAR2,
    p_customer_id NUMBER,
    p_song_id NUMBER
) IS
    v_count NUMBER;
BEGIN
    -- Check if the new playlist name already exists
    SELECT COUNT(1) INTO v_count FROM Playlists WHERE Playlist_Name = p_new_playlist_name AND Playlist_Id != p_playlist_id;
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate Playlist Name: ' || p_new_playlist_name);
        RETURN;
    END IF;

    -- Update playlist details
    UPDATE Playlists
    SET Playlist_Name = p_new_playlist_name,
        Customer_Id = p_customer_id,
        Song_Id = p_song_id
    WHERE Playlist_Id = p_playlist_id;

    DBMS_OUTPUT.PUT_LINE('Playlist updated successfully.');

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UpdateDownloadedSong(
    p_old_customer_id NUMBER,
    p_old_song_id NUMBER,
    p_new_customer_id NUMBER,
    p_new_song_id NUMBER
) IS
  v_subscription CHAR;
  v_download_count NUMBER;
BEGIN
  -- Check new customer's subscription status
  SELECT Subscription INTO v_subscription FROM Customers WHERE Customer_Id = p_new_customer_id;
  IF v_subscription IS NULL OR v_subscription = 'N' THEN
    DBMS_OUTPUT.PUT_LINE('Customer ID ' || p_new_customer_id || ' does not have an active subscription.');
    RETURN;
  END IF;

  -- Check if the new song has already been downloaded by the new customer
  SELECT COUNT(*)
  INTO v_download_count
  FROM Downloaded_Songs
  WHERE Customer_Id = p_new_customer_id AND Song_Id = p_new_song_id;

  IF v_download_count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('Song ID ' || p_new_song_id || ' has already been downloaded by Customer ID ' || p_new_customer_id || '.');
    RETURN;
  END IF;

  -- Update the downloaded song
  UPDATE Downloaded_Songs
  SET Customer_Id = p_new_customer_id, Song_Id = p_new_song_id
  WHERE Customer_Id = p_old_customer_id AND Song_Id = p_old_song_id;

  DBMS_OUTPUT.PUT_LINE('Downloaded song updated successfully.');

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Customer ID ' || p_new_customer_id || ' or Song ID ' || p_new_song_id || ' not found.');
  WHEN OTHERS THEN
    RAISE;
END;
/


CREATE OR REPLACE PROCEDURE UpdateHistory(
    p_old_song_id NUMBER,
    p_old_customer_id NUMBER,
    p_old_history_date DATE,
    p_new_song_id NUMBER,
    p_new_customer_id NUMBER,
    p_new_history_date DATE
) IS
BEGIN
  UPDATE History
  SET Song_Id = p_new_song_id,
      Customer_Id = p_new_customer_id,
      History_Date = p_new_history_date
  WHERE Song_Id = p_old_song_id 
    AND Customer_Id = p_old_customer_id 
    AND History_Date = p_old_history_date;

  DBMS_OUTPUT.PUT_LINE('History record updated successfully.');

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/



CREATE OR REPLACE PROCEDURE UpdatePromocode(
    p_promocode_id NUMBER,
    p_new_promocode_name VARCHAR2,
    p_discount NUMBER,
    p_expiry_date DATE
) IS
    v_count NUMBER;
BEGIN
    -- Check if discount is within limits
    IF p_discount >= 20 THEN
        DBMS_OUTPUT.PUT_LINE('Discount must be less than 20. Given discount: ' || p_discount);
        RETURN;
    END IF;

    -- Check if the promocode name already exists
    SELECT COUNT(1) INTO v_count FROM Promocodes WHERE Promocode_Name = p_new_promocode_name AND Promocode_Id != p_promocode_id;
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate Promocode Name: ' || p_new_promocode_name);
        RETURN;
    END IF;

    -- Update promocode details
    UPDATE Promocodes
    SET Promocode_Name = p_new_promocode_name, Discount = p_discount, Expiry_Date = p_expiry_date
    WHERE Promocode_Id = p_promocode_id;

    DBMS_OUTPUT.PUT_LINE('Promocode updated successfully.');

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE UpdateAlbum(
  p_album_id NUMBER,
  p_new_album_name VARCHAR2
) IS
BEGIN
  -- Update album name
  UPDATE Album
  SET Album_Name = p_new_album_name
  WHERE Album_Id = p_album_id;

  DBMS_OUTPUT.PUT_LINE('Album updated successfully.');

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;
/

-----------------DELETE TABLE PROCEDURES

CREATE OR REPLACE PROCEDURE DeleteCustomer(
    p_customer_id NUMBER
) IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM Customers WHERE Customer_Id = p_customer_id;
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Customer does not exist: ' || p_customer_id);
    RETURN;
  END IF;

  DELETE FROM Customers WHERE Customer_Id = p_customer_id;
  DBMS_OUTPUT.PUT_LINE('Customer deleted successfully.');

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/


CREATE OR REPLACE PROCEDURE DeleteSong(
    p_song_id NUMBER
) IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM Songs WHERE Song_Id = p_song_id;
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Song does not exist: ' || p_song_id);
    RETURN;
  END IF;

  DELETE FROM Songs WHERE Song_Id = p_song_id;
  DBMS_OUTPUT.PUT_LINE('Song deleted successfully.');

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/

CREATE OR REPLACE PROCEDURE DeletePaymentMethod(
    p_payment_id NUMBER
) IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM Payment_Method WHERE Payment_Id = p_payment_id;
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Payment method does not exist: ' || p_payment_id);
    RETURN;
  END IF;

  DELETE FROM Payment_Method WHERE Payment_Id = p_payment_id;
  DBMS_OUTPUT.PUT_LINE('Payment method deleted successfully.');

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/


CREATE OR REPLACE PROCEDURE DeleteDownloadedSong(
    p_customer_id NUMBER,
    p_song_id NUMBER
) IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM Downloaded_Songs WHERE Customer_Id = p_customer_id AND Song_Id = p_song_id;
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Downloaded song record does not exist for Customer ID: ' || p_customer_id || ' and Song ID: ' || p_song_id);
    RETURN;
  END IF;

  DELETE FROM Downloaded_Songs WHERE Customer_Id = p_customer_id AND Song_Id = p_song_id;
  DBMS_OUTPUT.PUT_LINE('Downloaded song record deleted successfully.');

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/


CREATE OR REPLACE PROCEDURE DeleteHistory(
    p_customer_id NUMBER,
    p_song_id NUMBER,
    p_history_date DATE
) IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM History WHERE Customer_Id = p_customer_id AND Song_Id = p_song_id AND History_Date = p_history_date;
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('History record does not exist for Customer ID: ' || p_customer_id || ', Song ID: ' || p_song_id || ' and Date: ' || p_history_date);
    RETURN;
  END IF;

  DELETE FROM History WHERE Customer_Id = p_customer_id AND Song_Id = p_song_id AND History_Date = p_history_date;
  DBMS_OUTPUT.PUT_LINE('History record deleted successfully.');

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/

CREATE OR REPLACE PROCEDURE DeletePlaylist(
    p_playlist_id NUMBER
) IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM Playlists WHERE Playlist_Id = p_playlist_id;
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Playlist does not exist: ' || p_playlist_id);
    RETURN;
  END IF;

  DELETE FROM Playlists WHERE Playlist_Id = p_playlist_id;
  DBMS_OUTPUT.PUT_LINE('Playlist deleted successfully.');

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/

CREATE OR REPLACE PROCEDURE DeleteBankAccount(
    p_account_id NUMBER
) IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM Bank_Account WHERE Account_Id = p_account_id;
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Bank account does not exist: ' || p_account_id);
    RETURN;
  END IF;

  DELETE FROM Bank_Account WHERE Account_Id = p_account_id;
  DBMS_OUTPUT.PUT_LINE('Bank account deleted successfully.');

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/

CREATE OR REPLACE PROCEDURE DeleteCard(
    p_card_id NUMBER
) IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM Card WHERE Card_Id = p_card_id;
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Card does not exist: ' || p_card_id);
    RETURN;
  END IF;

  DELETE FROM Card WHERE Card_Id = p_card_id;
  DBMS_OUTPUT.PUT_LINE('Card deleted successfully.');

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/


CREATE OR REPLACE PROCEDURE DeletePromocode(
    p_promocode_id NUMBER
) IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM Promocodes WHERE Promocode_Id = p_promocode_id;
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Promocode does not exist: ' || p_promocode_id);
    RETURN;
  END IF;

  DELETE FROM Promocodes WHERE Promocode_Id = p_promocode_id;
  DBMS_OUTPUT.PUT_LINE('Promocode deleted successfully.');

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/


CREATE OR REPLACE PROCEDURE DeleteAlbum(
    p_album_id NUMBER
) IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM Album WHERE Album_Id = p_album_id;
  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Album does not exist: ' || p_album_id);
    RETURN;
  END IF;

  DELETE FROM Album WHERE Album_Id = p_album_id;
  DBMS_OUTPUT.PUT_LINE('Album deleted successfully.');

EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/


CREATE OR REPLACE PROCEDURE DeleteTransaction(
    p_transaction_id NUMBER
) IS
  v_count NUMBER;
BEGIN
  -- Check if the transaction record exists
  SELECT COUNT(*) INTO v_count FROM Transaction WHERE Transaction_Id = p_transaction_id;
  IF v_count = 0 THEN
    -- Print message if the transaction does not exist
    DBMS_OUTPUT.PUT_LINE('Transaction does not exist: ' || p_transaction_id);
    RETURN;
  END IF;

  -- Delete the transaction record
  DELETE FROM Transaction WHERE Transaction_Id = p_transaction_id;
  DBMS_OUTPUT.PUT_LINE('Transaction deleted successfully.');

EXCEPTION
  -- Handle any exceptions that might occur
  WHEN OTHERS THEN
    RAISE;
END;
/









