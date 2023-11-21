SET SERVEROUTPUT ON;

-- Procedure to drop a table if it exists
CREATE OR REPLACE PROCEDURE DropTableIfExists(p_table_name IN VARCHAR2) IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(1) INTO v_count FROM user_tables WHERE table_name = UPPER(p_table_name);
  IF v_count = 1 THEN
    EXECUTE IMMEDIATE 'DROP TABLE ' || p_table_name || ' CASCADE CONSTRAINTS';
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('Failed to drop table ' || p_table_name);
END;
/

-- Procedure to drop a sequence if it exists
CREATE OR REPLACE PROCEDURE DropSequenceIfExists(p_seq_name IN VARCHAR2) IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(1) INTO v_count FROM user_sequences WHERE sequence_name = UPPER(p_seq_name);
  IF v_count = 1 THEN
    EXECUTE IMMEDIATE 'DROP SEQUENCE ' || p_seq_name;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('Failed to drop sequence ' || p_seq_name);
END;
/

-- Main execution block
BEGIN
  -- Dropping existing table and sequence if they exist
  DropTableIfExists('Customers');
  DropSequenceIfExists('customer_id_seq');

  -- Creating the sequence
  EXECUTE IMMEDIATE 'CREATE SEQUENCE customer_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999';

  -- Creating the Customers table
  EXECUTE IMMEDIATE 'CREATE TABLE Customers (
    Customer_Id NUMBER DEFAULT customer_id_seq.NEXTVAL PRIMARY KEY, 
    Profile_Name VARCHAR2(100),
    Password VARCHAR2(100),
    DOB DATE,
    Gender VARCHAR2(10),
    Subscription CHAR(1)
  )';
  DBMS_OUTPUT.put_line('Customers table created successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
END;
/


BEGIN
  DropTableIfExists('Payment_Method');
  DropSequenceIfExists('payment_id_seq');

  EXECUTE IMMEDIATE 'CREATE SEQUENCE payment_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999';

  EXECUTE IMMEDIATE 'CREATE TABLE Payment_Method (
    Payment_Id NUMBER DEFAULT payment_id_seq.NEXTVAL PRIMARY KEY, 
    Payment_Type VARCHAR2(50) CHECK (Payment_Type IN (''Card'', ''Bank Account'')),
    Customer_Id NUMBER,
    Promocode_Id NUMBER,
    CONSTRAINT fk_Payment_Method_Customer_Id FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id),
    CONSTRAINT fk_Payment_Method_Promocode_Id FOREIGN KEY (Promocode_Id) REFERENCES Promocodes(Promocode_Id)
  )';
  DBMS_OUTPUT.put_line('Payment Method table created successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
END;
/


BEGIN
  DropTableIfExists('Bank_Account');
  DropSequenceIfExists('account_id_seq');

  EXECUTE IMMEDIATE 'CREATE SEQUENCE account_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999';

  EXECUTE IMMEDIATE 'CREATE TABLE Bank_Account (
    Account_Id NUMBER DEFAULT account_id_seq.NEXTVAL PRIMARY KEY,
    Account_Number NUMBER , 
    Full_Name VARCHAR2(100),
    Routing_Number NUMBER,
    Account_Type VARCHAR2(50),
    Account_Limit NUMBER,
    Payment_Id NUMBER,
    CONSTRAINT fk_Bank_Account_Payment_Id FOREIGN KEY (Payment_Id) REFERENCES Payment_Method(Payment_Id)
  )';
  DBMS_OUTPUT.put_line('Bank Account table created successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
END;
/


BEGIN
  DropTableIfExists('Card');
  DropSequenceIfExists('card_id_seq');

  EXECUTE IMMEDIATE 'CREATE SEQUENCE card_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999';

  EXECUTE IMMEDIATE 'CREATE TABLE Card (
    Card_Id NUMBER DEFAULT card_id_seq.NEXTVAL PRIMARY KEY,
    Card_Number NUMBER , 
    First_Name VARCHAR2(50),
    Last_Name VARCHAR2(50),
    Expiry_Date DATE,
    CVV_Code NUMBER,
    Zip VARCHAR2(10),
    Payment_Id NUMBER,
    CONSTRAINT fk_Card_Payment_Id FOREIGN KEY (Payment_Id) REFERENCES Payment_Method(Payment_Id)
  )';
  DBMS_OUTPUT.put_line('Card table created successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
END;
/

BEGIN
  DropTableIfExists('Transaction');
  DropSequenceIfExists('transaction_id_seq');

  EXECUTE IMMEDIATE 'CREATE SEQUENCE transaction_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999';

  EXECUTE IMMEDIATE 'CREATE TABLE Transaction (
    Transaction_Id NUMBER DEFAULT transaction_id_seq.NEXTVAL PRIMARY KEY, 
    Transaction_Time TIMESTAMP,
    Price NUMBER,
    Customer_Id NUMBER,
    Active VARCHAR2(10),
    Start_Date DATE,
    End_Date DATE,
    CONSTRAINT fk_Transaction_Customer_Id FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id)
  )';
  DBMS_OUTPUT.put_line('Transaction table created successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
END;
/


BEGIN
  DropTableIfExists('Promocodes');
  DropSequenceIfExists('promocode_id_seq');

  EXECUTE IMMEDIATE 'CREATE SEQUENCE promocode_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999';

  EXECUTE IMMEDIATE 'CREATE TABLE Promocodes (
    Promocode_Id NUMBER DEFAULT promocode_id_seq.NEXTVAL PRIMARY KEY, 
    Promocode_Name VARCHAR2(100),
    Discount NUMBER,
    Expiry_Date DATE
  )';
  DBMS_OUTPUT.put_line('Promocodes table created successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
END;
/

BEGIN
  DropTableIfExists('Album');
  DropSequenceIfExists('album_id_seq');

  EXECUTE IMMEDIATE 'CREATE SEQUENCE album_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999';

  EXECUTE IMMEDIATE 'CREATE TABLE Album (
    Album_Id NUMBER DEFAULT album_id_seq.NEXTVAL PRIMARY KEY, 
    Album_Name VARCHAR2(100)
  )';
  DBMS_OUTPUT.put_line('Album table created successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
END;
/


BEGIN
  DropTableIfExists('Songs');
  DropSequenceIfExists('song_id_seq');

  EXECUTE IMMEDIATE 'CREATE SEQUENCE song_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999';

  EXECUTE IMMEDIATE 'CREATE TABLE Songs (
    Song_Id NUMBER DEFAULT song_id_seq.NEXTVAL PRIMARY KEY, 
    Song_Name VARCHAR2(100),
    Language VARCHAR2(50),
    Genre VARCHAR2(50),
    Album_Id NUMBER,
    CONSTRAINT fk_Songs_Album_Id FOREIGN KEY (Album_Id) REFERENCES Album(Album_Id)
  )';
  DBMS_OUTPUT.put_line('Songs table created successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
END;
/

BEGIN
  DropTableIfExists('Playlists');
  DropSequenceIfExists('playlist_id_seq');

  EXECUTE IMMEDIATE 'CREATE SEQUENCE playlist_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999';

  EXECUTE IMMEDIATE 'CREATE TABLE Playlists (
    Playlist_Id NUMBER DEFAULT playlist_id_seq.NEXTVAL PRIMARY KEY, 
    Playlist_Name VARCHAR2(100),
    Customer_Id NUMBER,
    CONSTRAINT fk_Playlists_Customer_Id FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id)
  )';
  DBMS_OUTPUT.put_line('Playlists table created successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
END;
/

BEGIN
  DropTableIfExists('Downloaded_Songs');


  EXECUTE IMMEDIATE 'CREATE TABLE Downloaded_Songs (
    Customer_Id NUMBER,
    Song_Id NUMBER,
    CONSTRAINT fk_Downloaded_Songs_Customer_Id FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id),
    CONSTRAINT fk_downloaded_songs_Song_Id FOREIGN KEY (Song_Id) REFERENCES Songs(Song_Id)

  )';
  DBMS_OUTPUT.put_line('Downloaded Songs table created successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
END;
/


BEGIN
  DropTableIfExists('History');

  EXECUTE IMMEDIATE 'CREATE TABLE History (
    Song_Id NUMBER,
    Customer_Id NUMBER,
    History_Date DATE,
    CONSTRAINT fk_History_Customer_Id FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id),
    CONSTRAINT fk_History_Song_Id FOREIGN KEY (Song_Id) REFERENCES Songs(Song_Id)
  )';
  DBMS_OUTPUT.put_line('History table created successfully');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('Error occurred: ' || SQLERRM);
END;
/


