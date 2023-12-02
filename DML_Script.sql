CREATE OR REPLACE PACKAGE UserInsertPackage AS

  PROCEDURE InsertCustomer(
      p_profile_name VARCHAR2,
      p_password VARCHAR2,
      p_dob DATE,
      p_gender VARCHAR2
  );

  PROCEDURE InsertBankAccount(
      p_account_number NUMBER,
      p_full_name VARCHAR2,
      p_routing_number NUMBER,
      p_account_type VARCHAR2
  );

  PROCEDURE InsertCard(
      p_card_number NUMBER,
      p_first_name VARCHAR2,
      p_last_name VARCHAR2,
      p_expiry_date DATE,
      p_cvv_code NUMBER,
      p_zip VARCHAR2
  );


  PROCEDURE InsertPlaylist(
        p_playlist_name VARCHAR2,
        p_customer_id NUMBER
  );
  
  PROCEDURE AddSongToPlaylist(
    p_playlist_id NUMBER,
    p_song_id NUMBER
  );  
    
  PROCEDURE InsertDownloadedSong(
      p_customer_id NUMBER,
      p_song_id NUMBER
  );

  PROCEDURE InsertHistory(
      p_song_id NUMBER,
      p_customer_id NUMBER,
      p_history_date DATE
  );

  
END UserInsertPackage;
/




CREATE OR REPLACE PACKAGE BODY UserInsertPackage AS


  PROCEDURE InsertCustomer(
      p_profile_name VARCHAR2,
      p_password VARCHAR2,
      p_dob DATE,
      p_gender VARCHAR2
  ) IS
  v_count NUMBER;
  BEGIN
    SELECT COUNT(1) INTO v_count FROM Customers WHERE Profile_Name = p_profile_name;
    IF v_count > 0 THEN
      RETURN;
    END IF;

    INSERT INTO Customers(Profile_Name, Password, DOB, Gender, Subscription)
    VALUES (p_profile_name, p_password, p_dob, p_gender, NULL); -- Insert NULL for Subscription

  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END InsertCustomer;
 

  PROCEDURE InsertBankAccount(
      p_account_number NUMBER,
      p_full_name VARCHAR2,
      p_routing_number NUMBER,
      p_account_type VARCHAR2
  ) IS
      v_count NUMBER;
  BEGIN
      SELECT COUNT(1) INTO v_count FROM Bank_Account WHERE Account_Number = p_account_number;
      IF v_count > 0 THEN
          DBMS_OUTPUT.PUT_LINE('Duplicate Bank Account Number: ' || p_account_number);
          RETURN;
      END IF;
      INSERT INTO Bank_Account(Account_Number, Full_Name, Routing_Number, Account_Type)
      VALUES (p_account_number, p_full_name, p_routing_number, p_account_type);
  EXCEPTION
      WHEN OTHERS THEN
          RAISE;
  END InsertBankAccount;

  PROCEDURE InsertCard(
      p_card_number NUMBER,
      p_first_name VARCHAR2,
      p_last_name VARCHAR2,
      p_expiry_date DATE,
      p_cvv_code NUMBER,
      p_zip VARCHAR2
  ) IS
      v_count NUMBER;
  BEGIN
      SELECT COUNT(1) INTO v_count FROM Card WHERE Card_Number = p_card_number;
      IF v_count > 0 THEN
          DBMS_OUTPUT.PUT_LINE('Duplicate Card Number: ' || p_card_number);
          RETURN;
      END IF;
      INSERT INTO Card(Card_Number, First_Name, Last_Name, Expiry_Date, CVV_Code, Zip)
      VALUES (p_card_number, p_first_name, p_last_name, p_expiry_date, p_cvv_code, p_zip);
  EXCEPTION
      WHEN OTHERS THEN
          RAISE;
  END InsertCard;


  PROCEDURE InsertPlaylist(
    p_playlist_name VARCHAR2,
    p_customer_id NUMBER
  ) IS
    v_count NUMBER;
  BEGIN
    -- Check if the playlist name for the user already exists
    SELECT COUNT(*)
    INTO v_count
    FROM Playlist
    WHERE Playlist_Name = p_playlist_name
    AND Customer_Id = p_customer_id;

    -- Only insert if the playlist does not exist
    IF v_count = 0 THEN
        INSERT INTO Playlist (Playlist_Name, Customer_Id)
        VALUES (p_playlist_name, p_customer_id);
    ELSE
        -- Print a message if the playlist already exists
        DBMS_OUTPUT.PUT_LINE('Playlist already exists for this user.');
    END IF;
   END InsertPlaylist;
   
   PROCEDURE AddSongToPlaylist(
    p_playlist_id NUMBER,
    p_song_id NUMBER
   ) IS
    v_count NUMBER;
   BEGIN
    -- Check if the song is already in the playlist
    SELECT COUNT(*)
    INTO v_count
    FROM Songs_Playlist
    WHERE Playlist_Id = p_playlist_id
    AND Song_Id = p_song_id;

    -- Only insert if the song is not already in the playlist
    IF v_count = 0 THEN
        INSERT INTO Songs_Playlist (Playlist_Id, Song_Id)
        VALUES (p_playlist_id, p_song_id);
    ELSE
        -- Print a message if the song is already in the playlist
        DBMS_OUTPUT.PUT_LINE('Song already exists in this playlist.');
    END IF;
   END AddSongToPlaylist;

  
  PROCEDURE InsertDownloadedSong(
    p_customer_id NUMBER,
    p_song_id NUMBER
  ) IS
    v_subscription CHAR;
    v_download_count NUMBER;
    v_customer_exists NUMBER;
    v_song_exists NUMBER;
  BEGIN
    -- Check if customer exists
    SELECT COUNT(*)
    INTO v_customer_exists
    FROM Customers
    WHERE Customer_Id = p_customer_id;

    IF v_customer_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Customer ID ' || p_customer_id || ' does not exist.');
        RETURN;
    END IF;

    -- Check if song exists
    SELECT COUNT(*)
    INTO v_song_exists
    FROM Songs
    WHERE Song_Id = p_song_id;

    IF v_song_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Song ID ' || p_song_id || ' does not exist.');
        RETURN;
    END IF;

    -- Check customer's subscription status
    SELECT Subscription INTO v_subscription FROM Customers WHERE Customer_Id = p_customer_id;
    IF v_subscription IS NULL OR v_subscription = 'N' THEN
        DBMS_OUTPUT.PUT_LINE('Customer ID ' || p_customer_id || ' does not have an active subscription.');
        RETURN;
    END IF;

    -- Check if the song has already been downloaded
    SELECT COUNT(*)
    INTO v_download_count
    FROM Downloaded_Songs
    WHERE Customer_Id = p_customer_id AND Song_Id = p_song_id;

    IF v_download_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Song ID ' || p_song_id || ' has already been downloaded by Customer ID ' || p_customer_id || '.');
        RETURN;
    END IF;

    -- Insert the record with the current date
    INSERT INTO Downloaded_Songs(Customer_Id, Song_Id, Download_Date)
    VALUES (p_customer_id, p_song_id, SYSDATE);
  EXCEPTION
    WHEN OTHERS THEN
        RAISE;
  END InsertDownloadedSong;



  PROCEDURE InsertHistory(
    p_song_id NUMBER,
    p_customer_id NUMBER,
    p_history_date DATE
  ) IS
    v_customer_exists NUMBER;
    v_song_exists NUMBER;
    v_entry_exists NUMBER;
  BEGIN
    -- Check if customer exists
    SELECT COUNT(*)
    INTO v_customer_exists
    FROM Customers
    WHERE Customer_Id = p_customer_id;

    IF v_customer_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Customer ID ' || p_customer_id || ' does not exist.');
        RETURN;
    END IF;

    -- Check if song exists
    SELECT COUNT(*)
    INTO v_song_exists
    FROM Songs
    WHERE Song_Id = p_song_id;

    IF v_song_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Song ID ' || p_song_id || ' does not exist.');
        RETURN;
    END IF;

    -- Check if the song has already been inserted for the specified date
    SELECT COUNT(*)
    INTO v_entry_exists
    FROM History
    WHERE Song_Id = p_song_id AND Customer_Id = p_customer_id AND History_Date = p_history_date;

    IF v_entry_exists > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Entry for Song ID ' || p_song_id || ' and Customer ID ' || p_customer_id || ' already exists for date ' || p_history_date);
        RETURN;
    END IF;

    -- Insert logic for new entry
    INSERT INTO History(Song_Id, Customer_Id, History_Date)
    VALUES (p_song_id, p_customer_id, p_history_date);

  EXCEPTION
    WHEN OTHERS THEN
        RAISE;
  END InsertHistory;

END UserInsertPackage;
/

CREATE OR REPLACE PACKAGE AdminInsertPackage AS

  
  PROCEDURE InsertPaymentMethod(
      p_payment_type VARCHAR2,
      p_customer_id NUMBER
  );

  PROCEDURE InsertTransaction(
      p_transaction_time TIMESTAMP,
      p_price NUMBER,
      p_customer_id NUMBER,
      p_promocode_id NUMBER,
      p_payment_id NUMBER
  );


  PROCEDURE InsertSong(
      p_song_name VARCHAR2,
      p_language VARCHAR2,
      p_genre VARCHAR2,
      p_album_id NUMBER
  );


  PROCEDURE InsertPromocode(
      p_promocode_name VARCHAR2,
      p_discount NUMBER,
      p_expiry_date DATE
  );

  PROCEDURE InsertAlbum (
    p_album_name VARCHAR2
  );

  
  FUNCTION CalculateTotalPrice(
        p_price NUMBER,
        p_promocode_id NUMBER
    ) RETURN NUMBER;

END AdminInsertPackage;
/




CREATE OR REPLACE PACKAGE BODY AdminInsertPackage AS

  FUNCTION CalculateTotalPrice(
    p_price NUMBER,
    p_promocode_id NUMBER
  ) RETURN NUMBER IS
    v_discount NUMBER := 0;
  BEGIN
    IF p_promocode_id IS NOT NULL THEN
        SELECT Discount
        INTO v_discount
        FROM Promocodes
        WHERE Promocode_Id = p_promocode_id;
    END IF;
    
    RETURN p_price + v_discount;
  END CalculateTotalPrice;


  PROCEDURE InsertPaymentMethod(
      p_payment_type VARCHAR2,
      p_customer_id NUMBER
  ) IS
    TYPE t_allowed_types IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    v_allowed_types t_allowed_types;
    v_type_exists BOOLEAN := FALSE;
  BEGIN
    v_allowed_types(1) := 'Card';
    v_allowed_types(2) := 'Bank_Account';
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
        DBMS_OUTPUT.PUT_LINE('Invalid payment type.');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END InsertPaymentMethod;
  
    
  

  PROCEDURE InsertTransaction(
    p_transaction_time TIMESTAMP,
    p_price NUMBER,
    p_customer_id NUMBER,
    p_promocode_id NUMBER,
    p_payment_id NUMBER -- Added payment ID parameter
  ) IS
    v_active VARCHAR2(1);
    v_promocode_exists NUMBER;
    v_total_price NUMBER;
  BEGIN
    -- Check if promocode is provided and exists
    IF p_promocode_id IS NOT NULL THEN
        SELECT COUNT(*)
        INTO v_promocode_exists
        FROM Promocodes
        WHERE Promocode_Id = p_promocode_id;

        IF v_promocode_exists = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Promocode does not exist.');
            RETURN;
        END IF;
    END IF;

    -- Calculate total price using the CalculateTotalPrice function
    v_total_price := CalculateTotalPrice(p_price, p_promocode_id);

    -- Check if total price is not greater than 20
    IF v_total_price > 20 THEN
        DBMS_OUTPUT.PUT_LINE('Total price including discount cannot be greater than 20.');
        RETURN;
    END IF;

    -- Determine if the transaction should be active
    IF v_total_price = 20 THEN
        v_active := 'Y';
    ELSE
        v_active := 'N';
    END IF;

    -- Insert the transaction
    INSERT INTO Transaction (Transaction_Time, Price, Customer_Id, Active, Start_Date, End_Date, Promocode_Id, Payment_Id)
    VALUES (p_transaction_time, p_price, p_customer_id, v_active, SYSDATE, ADD_MONTHS(SYSDATE, 1), p_promocode_id, p_payment_id);
    DBMS_OUTPUT.PUT_LINE('Transaction successfully inserted.');

  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        RAISE;
  END InsertTransaction;



 
  PROCEDURE InsertSong(
      p_song_name VARCHAR2,
      p_language VARCHAR2,
      p_genre VARCHAR2,
      p_album_id NUMBER
  ) IS
      v_count NUMBER;
  BEGIN
      SELECT COUNT(1) INTO v_count FROM Songs WHERE Song_Name = p_song_name AND Album_Id = p_album_id;
      IF v_count > 0 THEN
          DBMS_OUTPUT.PUT_LINE('Duplicate Song Name in the Album: ' || p_song_name);
          RETURN;
      END IF;
      INSERT INTO Songs(Song_Name, Language, Genre, Album_Id)
      VALUES (p_song_name, p_language, p_genre, p_album_id);
  EXCEPTION
      WHEN OTHERS THEN
          RAISE;
  END InsertSong;

  
  PROCEDURE InsertPromocode(
      p_promocode_name VARCHAR2,
      p_discount NUMBER,
      p_expiry_date DATE
  ) IS
      v_count NUMBER;
  BEGIN
      IF p_expiry_date < SYSDATE THEN
          DBMS_OUTPUT.PUT_LINE('Promocode with an expiry date before today cannot be inserted.');
          RETURN;
      END IF;

      IF p_discount >= 20 THEN
          DBMS_OUTPUT.PUT_LINE('Discount must be less than 20. Given discount: ' || p_discount);
          RETURN;
      END IF;

      SELECT COUNT(1) INTO v_count FROM Promocodes WHERE Promocode_Name = p_promocode_name;
      IF v_count > 0 THEN
          DBMS_OUTPUT.PUT_LINE('Duplicate Promocode Name: ' || p_promocode_name);
          RETURN;
      END IF;

      INSERT INTO Promocodes(Promocode_Name, Discount, Expiry_Date)
      VALUES (p_promocode_name, p_discount, p_expiry_date);
  EXCEPTION
      WHEN OTHERS THEN
          RAISE;
  END InsertPromocode;


  PROCEDURE InsertAlbum (
    p_album_name VARCHAR2
  ) IS
  BEGIN
    INSERT INTO Album (Album_Name)
    VALUES (p_album_name);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END InsertAlbum;

END AdminInsertPackage;
/


CREATE OR REPLACE TRIGGER UpdateCustomerSubscription
AFTER INSERT OR UPDATE OF Active ON Transaction
DECLARE
    -- Cursor to fetch all customer IDs
    CURSOR c_all_customers IS
        SELECT Customer_Id
        FROM Customers;

    v_transaction_count NUMBER;
    v_active_count NUMBER;
BEGIN
    FOR rec IN c_all_customers LOOP
        -- Count all transactions for the customer
        SELECT COUNT(*)
        INTO v_transaction_count
        FROM Transaction
        WHERE Customer_Id = rec.Customer_Id;

        -- Count only active transactions for the customer
        SELECT COUNT(*)
        INTO v_active_count
        FROM Transaction
        WHERE Customer_Id = rec.Customer_Id AND Active = 'Y';

        IF v_transaction_count = 0 THEN
            -- No transactions, set Subscription to 'N'
            UPDATE Customers SET Subscription = 'N' WHERE Customer_Id = rec.Customer_Id;
        ELSIF v_active_count > 0 THEN
            -- Active transactions exist, set Subscription to 'Y'
            UPDATE Customers SET Subscription = 'Y' WHERE Customer_Id = rec.Customer_Id;
        ELSE
            -- Transactions exist but none are active, set Subscription to 'N'
            UPDATE Customers SET Subscription = 'N' WHERE Customer_Id = rec.Customer_Id;
        END IF;
    END LOOP;
END;
/


CREATE OR REPLACE TRIGGER trg_update_active_status
BEFORE INSERT OR UPDATE ON Transaction
FOR EACH ROW
BEGIN
    IF :NEW.End_Date < SYSDATE AND :NEW.Active = 'Y' THEN
        :NEW.Active := 'N';
    END IF;
END;
/







 



CREATE OR REPLACE PACKAGE UserUpdatePackage AS

  PROCEDURE UpdateCustomer(
      p_customer_id NUMBER,
      p_profile_name VARCHAR2,
      p_password VARCHAR2,
      p_dob DATE,
      p_gender VARCHAR2
  );


  PROCEDURE UpdateBankAccount(
      p_account_id NUMBER,
      p_account_number NUMBER,
      p_full_name VARCHAR2,
      p_routing_number NUMBER,
      p_account_type VARCHAR2
  );

  PROCEDURE UpdateCard(
      p_card_id NUMBER,
      p_card_number NUMBER,
      p_first_name VARCHAR2,
      p_last_name VARCHAR2,
      p_expiry_date DATE,
      p_cvv_code NUMBER,
      p_zip VARCHAR2
  );

  PROCEDURE UpdatePlaylist(
    p_playlist_id NUMBER,
    p_playlist_name VARCHAR2,
    p_customer_id NUMBER
  );    
      
 
    

END UserUpdatePackage;
/


CREATE OR REPLACE PACKAGE BODY UserUpdatePackage AS



  PROCEDURE UpdateCustomer(
    p_customer_id NUMBER,
    p_profile_name VARCHAR2,
    p_password VARCHAR2,
    p_dob DATE,
    p_gender VARCHAR2
  ) IS
    v_count NUMBER;
  BEGIN
  -- Check if customer ID exists
    SELECT COUNT(1) INTO v_count FROM Customers WHERE Customer_Id = p_customer_id;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Customer ID does not exist.');
        RETURN;
    END IF;
  
  -- Perform the update
    UPDATE Customers
    SET Profile_Name = p_profile_name,
        Password = p_password,
        DOB = p_dob,
        Gender = p_gender
    WHERE Customer_Id = p_customer_id;

  EXCEPTION
    WHEN OTHERS THEN
        RAISE;
  END UpdateCustomer;

  

  PROCEDURE UpdateBankAccount(
    p_account_id NUMBER,
    p_account_number NUMBER,
    p_full_name VARCHAR2,
    p_routing_number NUMBER,
    p_account_type VARCHAR2
  ) IS
    v_count NUMBER;
  BEGIN
    -- Check if the bank account ID exists
    SELECT COUNT(1) INTO v_count FROM Bank_Account WHERE Account_Id = p_account_id;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Bank Account ID does not exist: ' || p_account_id);
        RETURN;
    END IF;

    -- Check for duplicate account numbers
    SELECT COUNT(1) INTO v_count FROM Bank_Account WHERE Account_Number = p_account_number AND Account_Id != p_account_id;
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate Bank Account Number: ' || p_account_number);
        RETURN;
    END IF;

    -- Perform the update
    UPDATE Bank_Account
    SET Account_Number = p_account_number,
        Full_Name = p_full_name,
        Routing_Number = p_routing_number,
        Account_Type = p_account_type
    WHERE Account_Id = p_account_id;

  EXCEPTION
    WHEN OTHERS THEN
        RAISE;
  END UpdateBankAccount;

  PROCEDURE UpdateCard(
    p_card_id NUMBER,
    p_card_number NUMBER,
    p_first_name VARCHAR2,
    p_last_name VARCHAR2,
    p_expiry_date DATE,
    p_cvv_code NUMBER,
    p_zip VARCHAR2
  ) IS
    v_count NUMBER;
  BEGIN
    -- Check if card ID exists
    SELECT COUNT(1) INTO v_count FROM Card WHERE Card_Id = p_card_id;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Card ID does not exist: ' || p_card_id);
        RETURN;
    END IF;

    -- Check for duplicate card number
    SELECT COUNT(1) INTO v_count FROM Card WHERE Card_Number = p_card_number AND Card_Id != p_card_id;
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate Card Number: ' || p_card_number);
        RETURN;
    END IF;
    
    -- Perform the update
    UPDATE Card
    SET Card_Number = p_card_number,
        First_Name = p_first_name,
        Last_Name = p_last_name,
        Expiry_Date = p_expiry_date,
        CVV_Code = p_cvv_code,
        Zip = p_zip
    WHERE Card_Id = p_card_id;
  EXCEPTION
    WHEN OTHERS THEN
        RAISE;
  END UpdateCard;

 

  
  PROCEDURE UpdatePlaylist(
    p_playlist_id NUMBER,
    p_playlist_name VARCHAR2,
    p_customer_id NUMBER
  ) IS
    v_count NUMBER;
    v_count_dup NUMBER;
  BEGIN
    -- Check if the playlist ID exists for the customer
    SELECT COUNT(*)
    INTO v_count
    FROM Playlist
    WHERE Playlist_Id = p_playlist_id
    AND Customer_Id = p_customer_id;

    IF v_count = 0 THEN
        -- Print a message if the playlist does not exist for this user
        DBMS_OUTPUT.PUT_LINE('Playlist does not exist for this user.');
        RETURN;
    END IF;

    -- Check if the new playlist name already exists for the user
    SELECT COUNT(*)
    INTO v_count_dup
    FROM Playlist
    WHERE Playlist_Name = p_playlist_name
    AND Customer_Id = p_customer_id
    AND Playlist_Id != p_playlist_id;

    IF v_count_dup > 0 THEN
        -- Print a message if the new playlist name already exists for this user
        DBMS_OUTPUT.PUT_LINE('Another playlist with the same name already exists for this user.');
        RETURN;
    END IF;

    -- Perform the update
    UPDATE Playlist
    SET Playlist_Name = p_playlist_name
    WHERE Playlist_Id = p_playlist_id
    AND Customer_Id = p_customer_id;
  EXCEPTION
    WHEN OTHERS THEN
        RAISE;
  END UpdatePlaylist;
  
  
END UserUpdatePackage;
/








   





CREATE OR REPLACE PACKAGE AdminUpdatePackage AS

  
  PROCEDURE UpdatePaymentMethod(
      p_Payment_Id NUMBER,
      p_payment_type VARCHAR2,
      p_customer_id NUMBER
  );

  PROCEDURE UpdateTransaction(
    p_transaction_id NUMBER,
    p_transaction_time TIMESTAMP,
    p_price NUMBER,
    p_customer_id NUMBER,
    p_promocode_id NUMBER,
    p_payment_id NUMBER 
  );

 

  PROCEDURE UpdateSong(
      p_song_id NUMBER,
      p_song_name VARCHAR2,
      p_language VARCHAR2,
      p_genre VARCHAR2,
      p_album_id NUMBER
  );

  
  
  PROCEDURE UpdatePromocode(
      p_promocode_id NUMBER,
      p_promocode_name VARCHAR2,
      p_discount NUMBER,
      p_expiry_date DATE
  );

  PROCEDURE UpdateAlbum (
      p_album_id NUMBER,
      p_album_name VARCHAR2
  );
  
 
  
  FUNCTION CalculateTotalPrice(
        p_price NUMBER,
        p_promocode_id NUMBER
  ) RETURN NUMBER;

    

END AdminUpdatePackage;
/


CREATE OR REPLACE PACKAGE BODY AdminUpdatePackage AS


  FUNCTION CalculateTotalPrice(
    p_price NUMBER,
    p_promocode_id NUMBER
  ) RETURN NUMBER IS
    v_discount NUMBER := 0;
  BEGIN
    IF p_promocode_id IS NOT NULL THEN
        SELECT Discount
        INTO v_discount
        FROM Promocodes
        WHERE Promocode_Id = p_promocode_id;
    END IF;
    
    RETURN p_price + v_discount;
  END CalculateTotalPrice; 


  PROCEDURE UpdatePaymentMethod(
    p_Payment_Id NUMBER,
    p_payment_type VARCHAR2,
    p_customer_id NUMBER
  ) IS
    TYPE t_allowed_types IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
    v_allowed_types t_allowed_types;
    v_type_exists BOOLEAN := FALSE;
    v_count NUMBER;
  BEGIN
  -- Define allowed payment types
    v_allowed_types(1) := 'Card';
    v_allowed_types(2) := 'Bank_Account';

  -- Check if the provided payment type is valid
      FOR i IN 1 .. v_allowed_types.COUNT LOOP
          IF v_allowed_types(i) = p_payment_type THEN
              v_type_exists := TRUE;
              EXIT;
          END IF;
      END LOOP;

      IF NOT v_type_exists THEN
        DBMS_OUTPUT.PUT_LINE('Invalid payment type.');
        RETURN;
      END IF;

  -- Check if the payment method ID exists
      SELECT COUNT(1) INTO v_count FROM Payment_Method WHERE Payment_Id = p_Payment_Id;
      IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Payment method ID does not exist.');
        RETURN;
      END IF;
  
  -- Perform the update
      UPDATE Payment_Method
      SET Payment_Type = p_payment_type,
          Customer_Id = p_customer_id
      WHERE Payment_Id = p_Payment_Id;
    
    EXCEPTION
      WHEN OTHERS THEN
        RAISE;
    END UpdatePaymentMethod;


  PROCEDURE UpdateTransaction(
    p_transaction_id NUMBER,
    p_transaction_time TIMESTAMP,
    p_price NUMBER,
    p_customer_id NUMBER,
    p_promocode_id NUMBER,
    p_payment_id NUMBER -- Added payment ID parameter
  ) IS
    v_active VARCHAR2(1);
    v_promocode_exists NUMBER;
    v_total_price NUMBER;
    v_count NUMBER;
  BEGIN
    -- Check if transaction ID exists
    SELECT COUNT(1) INTO v_count FROM Transaction WHERE Transaction_Id = p_transaction_id;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Transaction ID does not exist.');
        RETURN;
    END IF;

    -- Check if promocode is provided and exists
    IF p_promocode_id IS NOT NULL THEN
        SELECT COUNT(*)
        INTO v_promocode_exists
        FROM Promocodes
        WHERE Promocode_Id = p_promocode_id;

        IF v_promocode_exists = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Promocode does not exist.');
            RETURN;
        END IF;
    END IF;

    -- Calculate total price using the CalculateTotalPrice function
    v_total_price := CalculateTotalPrice(p_price, p_promocode_id);

    -- Check if total price is not greater than 20
    IF v_total_price > 20 THEN
        DBMS_OUTPUT.PUT_LINE('Total price including discount cannot be greater than 20.');
        RETURN;
    END IF;

    -- Determine if the transaction should be active
    IF v_total_price = 20 THEN
        v_active := 'Y';
    ELSE
        v_active := 'N';
    END IF;

    -- Update the transaction
    UPDATE Transaction
    SET Transaction_Time = p_transaction_time,
        Price = p_price,
        Customer_Id = p_customer_id,
        Active = v_active,
        Promocode_Id = p_promocode_id,
        Payment_Id = p_payment_id
    WHERE Transaction_Id = p_transaction_id;

    DBMS_OUTPUT.PUT_LINE('Transaction successfully updated.');

  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        RAISE;
  END UpdateTransaction;

  
  

  PROCEDURE UpdateSong(
      p_song_id NUMBER,
      p_song_name VARCHAR2,
      p_language VARCHAR2,
      p_genre VARCHAR2,
      p_album_id NUMBER
  ) IS
    v_count NUMBER;
    v_count_dup NUMBER;
  BEGIN
    -- Check if song ID exists
    SELECT COUNT(1) INTO v_count FROM Songs WHERE Song_Id = p_song_id;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Song ID does not exist.');
      RETURN;
    END IF;

    -- Check for duplicate song name in the specified album
    SELECT COUNT(1) INTO v_count_dup FROM Songs WHERE Song_Name = p_song_name AND Album_Id = p_album_id AND Song_Id != p_song_id;
    IF v_count_dup > 0 THEN
      DBMS_OUTPUT.PUT_LINE('Duplicate Song Name in the Album: ' || p_song_name);
      RETURN;
    END IF;

    -- Perform the update
    UPDATE Songs
    SET Song_Name = p_song_name,
        Language = p_language,
        Genre = p_genre,
        Album_Id = p_album_id
    WHERE Song_Id = p_song_id;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END UpdateSong;

  
  

  PROCEDURE UpdatePromocode(
      p_promocode_id NUMBER,
      p_promocode_name VARCHAR2,
      p_discount NUMBER,
      p_expiry_date DATE
  ) IS
    v_count NUMBER;
    v_existing_name_count NUMBER;
  BEGIN
    -- Check if promocode ID exists
    SELECT COUNT(1) INTO v_count FROM Promocodes WHERE Promocode_Id = p_promocode_id;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Promocode ID does not exist.');
      RETURN;
    END IF;

    -- Check for expiry date
    IF p_expiry_date < SYSDATE THEN
      DBMS_OUTPUT.PUT_LINE('Promocode with an expiry date before today cannot be updated.');
      RETURN;
    END IF;

    -- Check for discount limit
    IF p_discount >= 20 THEN
      DBMS_OUTPUT.PUT_LINE('Discount must be less than 20. Given discount: ' || p_discount);
      RETURN;
    END IF;

    -- Check for duplicate promocode name
    SELECT COUNT(1) INTO v_existing_name_count FROM Promocodes WHERE Promocode_Name = p_promocode_name AND Promocode_Id != p_promocode_id;
    IF v_existing_name_count > 0 THEN
      DBMS_OUTPUT.PUT_LINE('Duplicate Promocode Name: ' || p_promocode_name);
      RETURN;
    END IF;

    -- Perform the update
    UPDATE Promocodes
    SET Promocode_Name = p_promocode_name,
        Discount = p_discount,
        Expiry_Date = p_expiry_date
    WHERE Promocode_Id = p_promocode_id;

  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END UpdatePromocode;


  PROCEDURE UpdateAlbum (
      p_album_id NUMBER,
      p_album_name VARCHAR2
  ) IS
    v_count NUMBER;
  BEGIN
    -- Check if album ID exists
    SELECT COUNT(1) INTO v_count FROM Album WHERE Album_Id = p_album_id;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Album ID does not exist.');
    END IF;
    
    -- Perform the update
    UPDATE Album
    SET Album_Name = p_album_name
    WHERE Album_Id = p_album_id;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END UpdateAlbum;
  
  
  

END AdminUpdatePackage;
/


CREATE OR REPLACE PACKAGE MusicServiceDeletePackage AS

  PROCEDURE DeleteCustomer(p_customer_id NUMBER);

  PROCEDURE DeletePaymentMethod(p_Payment_Id NUMBER);

  PROCEDURE DeleteTransaction(p_transaction_id NUMBER);

  PROCEDURE DeleteBankAccount(p_account_id NUMBER);

  PROCEDURE DeleteCard(p_card_id NUMBER);

  PROCEDURE DeleteSong(p_song_id NUMBER);

  PROCEDURE DeletePlaylist(p_playlist_id NUMBER);
  
  PROCEDURE DeleteSongsPlaylist(p_playlist_id NUMBER, p_song_id NUMBER);

  PROCEDURE DeleteDownloadedSong(p_customer_id NUMBER, p_song_id NUMBER) ;

  PROCEDURE DeleteHistory(p_customer_id NUMBER, p_song_id NUMBER);

  PROCEDURE DeletePromocode(p_promocode_id NUMBER);

  PROCEDURE DeleteAlbum(p_album_id NUMBER);

END MusicServiceDeletePackage;
/


CREATE OR REPLACE PACKAGE BODY MusicServiceDeletePackage AS

  PROCEDURE DeleteCustomer(p_customer_id NUMBER) IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(1) INTO v_count FROM Customers WHERE Customer_Id = p_customer_id;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Customer ID does not exist.');
    ELSE
      DELETE FROM Customers WHERE Customer_Id = p_customer_id;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END DeleteCustomer;

  PROCEDURE DeletePaymentMethod(p_Payment_Id NUMBER) IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(1) INTO v_count FROM Payment_Method WHERE Payment_Id = p_Payment_Id;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Payment Method ID does not exist.');
    ELSE
      DELETE FROM Payment_Method WHERE Payment_Id = p_Payment_Id;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END DeletePaymentMethod;

  -- Similar structure for other procedures...

  PROCEDURE DeleteTransaction(p_transaction_id NUMBER) IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(1) INTO v_count FROM Transaction WHERE Transaction_Id = p_transaction_id;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Transaction ID does not exist.');
    ELSE
      DELETE FROM Transaction WHERE Transaction_Id = p_transaction_id;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END DeleteTransaction;

  PROCEDURE DeleteBankAccount(p_account_id NUMBER) IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(1) INTO v_count FROM Bank_Account WHERE Account_Id = p_account_id;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Bank Account ID does not exist.');
    ELSE
      DELETE FROM Bank_Account WHERE Account_Id = p_account_id;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END DeleteBankAccount;

  PROCEDURE DeleteCard(p_card_id NUMBER) IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(1) INTO v_count FROM Card WHERE Card_Id = p_card_id;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Card ID does not exist.');
    ELSE
      DELETE FROM Card WHERE Card_Id = p_card_id;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END DeleteCard;

  PROCEDURE DeleteSong(p_song_id NUMBER) IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(1) INTO v_count FROM Songs WHERE Song_Id = p_song_id;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Song ID does not exist.');
    ELSE
      DELETE FROM Songs WHERE Song_Id = p_song_id;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END DeleteSong;

  PROCEDURE DeletePlaylist(p_playlist_id NUMBER) IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(1) INTO v_count FROM Playlist WHERE Playlist_Id = p_playlist_id;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Playlist ID does not exist.');
    ELSE
      DELETE FROM Playlist WHERE Playlist_Id = p_playlist_id;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END DeletePlaylist;

  PROCEDURE DeleteDownloadedSong(p_customer_id NUMBER, p_song_id NUMBER) IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(1) INTO v_count FROM Downloaded_Songs WHERE Customer_Id = p_customer_id AND Song_Id = p_song_id;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Downloaded Song Record does not exist.');
    ELSE
        DELETE FROM Downloaded_Songs WHERE Customer_Id = p_customer_id AND Song_Id = p_song_id;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
        RAISE;
  END DeleteDownloadedSong;

  PROCEDURE DeleteHistory(p_customer_id NUMBER, p_song_id NUMBER) IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(1) INTO v_count FROM History WHERE Customer_Id = p_customer_id AND Song_Id = p_song_id;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('History Record does not exist.');
    ELSE
        DELETE FROM History WHERE Customer_Id = p_customer_id AND Song_Id = p_song_id;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
        RAISE;
  END DeleteHistory;

  PROCEDURE DeletePromocode(p_promocode_id NUMBER) IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(1) INTO v_count FROM Promocodes WHERE Promocode_Id = p_promocode_id;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Promocode ID does not exist.');
    ELSE
      DELETE FROM Promocodes WHERE Promocode_Id = p_promocode_id;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END DeletePromocode;

  PROCEDURE DeleteAlbum(p_album_id NUMBER) IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(1) INTO v_count FROM Album WHERE Album_Id = p_album_id;
    IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Album ID does not exist.');
    ELSE
      DELETE FROM Album WHERE Album_Id = p_album_id;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END DeleteAlbum;
  
  PROCEDURE DeleteSongsPlaylist(p_playlist_id NUMBER, p_song_id NUMBER) IS
    v_count NUMBER;
  BEGIN
    -- Check if the song exists in the playlist
    SELECT COUNT(1) INTO v_count FROM Songs_Playlist WHERE Playlist_Id = p_playlist_id AND Song_Id = p_song_id;

    -- Conditional logic based on the existence of the song in the playlist
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Song Record does not exist in the playlist.');
    ELSE
        -- Delete the song from the playlist
        DELETE FROM Songs_Playlist WHERE Playlist_Id = p_playlist_id AND Song_Id = p_song_id;
    END IF;
  EXCEPTION
    -- Exception handling
    WHEN OTHERS THEN
        RAISE;
  END DeleteSongsPlaylist;


END MusicServiceDeletePackage;
/






 
  