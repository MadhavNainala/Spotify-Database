SET SERVEROUTPUT ON;

-- Dropping existing tables and sequences in one PL/SQL block
BEGIN
    -- Drop Tables
    FOR r IN (SELECT table_name FROM user_tables) LOOP
        EXECUTE IMMEDIATE ('DROP TABLE ' || r.table_name || ' CASCADE CONSTRAINTS');
    END LOOP;

    -- Drop Sequences
    FOR s IN (SELECT sequence_name FROM user_sequences) LOOP
        EXECUTE IMMEDIATE ('DROP SEQUENCE ' || s.sequence_name);
    END LOOP;
EXCEPTION WHEN OTHERS THEN
    -- Ignore errors for non-existing tables or sequences
    NULL;
END;
/

-- Creating sequences
CREATE SEQUENCE customer_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999;
/
CREATE SEQUENCE payment_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999;
/
CREATE SEQUENCE account_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999;
/
CREATE SEQUENCE card_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999;
/
CREATE SEQUENCE transaction_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999;
/
CREATE SEQUENCE promocode_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999;
/
CREATE SEQUENCE album_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999;
/
CREATE SEQUENCE song_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999;
/
CREATE SEQUENCE playlist_id_seq START WITH 1 INCREMENT BY 1 MAXVALUE 999999999999999999999999999;
/

-- Customers Table
CREATE TABLE Customers (
  Customer_Id NUMBER DEFAULT customer_id_seq.NEXTVAL PRIMARY KEY, 
  Profile_Name VARCHAR2(100) NOT NULL,
  Password VARCHAR2(100) NOT NULL,
  DOB DATE NOT NULL,
  Gender VARCHAR2(10) NOT NULL,
  Subscription CHAR(1) NOT NULL
);
/

-- Promocodes Table
CREATE TABLE Promocodes (
  Promocode_Id NUMBER DEFAULT promocode_id_seq.NEXTVAL PRIMARY KEY, 
  Promocode_Name VARCHAR2(100) NOT NULL,
  Discount NUMBER NOT NULL,
  Expiry_Date DATE NOT NULL
);
/

-- Payment_Method Table
CREATE TABLE Payment_Method (
  Payment_Id NUMBER DEFAULT payment_id_seq.NEXTVAL PRIMARY KEY, 
  Payment_Type VARCHAR2(50) NOT NULL CHECK (Payment_Type IN ('Card', 'Bank Account')),
  Customer_Id NUMBER NOT NULL,
  Promocode_Id NUMBER NOT NULL,
  CONSTRAINT fk_Payment_Method_Customer_Id FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id),
  CONSTRAINT fk_Payment_Method_Promocode_Id FOREIGN KEY (Promocode_Id) REFERENCES Promocodes(Promocode_Id)
);
/

-- Bank_Account Table
CREATE TABLE Bank_Account (
  Account_Id NUMBER DEFAULT account_id_seq.NEXTVAL PRIMARY KEY,
  Account_Number NUMBER NOT NULL, 
  Full_Name VARCHAR2(100) NOT NULL,
  Routing_Number NUMBER NOT NULL,
  Account_Type VARCHAR2(50) NOT NULL,
  Account_Limit NUMBER NOT NULL,
  Payment_Id NUMBER NOT NULL,
  CONSTRAINT fk_Bank_Account_Payment_Id FOREIGN KEY (Payment_Id) REFERENCES Payment_Method(Payment_Id)
);
/

-- Card Table
CREATE TABLE Card (
  Card_Id NUMBER DEFAULT card_id_seq.NEXTVAL PRIMARY KEY,
  Card_Number NUMBER NOT NULL, 
  First_Name VARCHAR2(50) NOT NULL,
  Last_Name VARCHAR2(50) NOT NULL,
  Expiry_Date DATE NOT NULL,
  CVV_Code NUMBER NOT NULL,
  Zip VARCHAR2(10) NOT NULL,
  Payment_Id NUMBER NOT NULL,
  CONSTRAINT fk_Card_Payment_Id FOREIGN KEY (Payment_Id) REFERENCES Payment_Method(Payment_Id)
);
/

-- Transaction Table
CREATE TABLE Transaction (
  Transaction_Id NUMBER DEFAULT transaction_id_seq.NEXTVAL PRIMARY KEY, 
  Transaction_Time TIMESTAMP NOT NULL,
  Price NUMBER NOT NULL,
  Customer_Id NUMBER NOT NULL,
  Active VARCHAR2(10) NOT NULL,
  Start_Date DATE NOT NULL,
  End_Date DATE NOT NULL,
  CONSTRAINT fk_Transaction_Customer_Id FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id)
);
/

-- Album Table
CREATE TABLE Album (
  Album_Id NUMBER DEFAULT album_id_seq.NEXTVAL PRIMARY KEY, 
  Album_Name VARCHAR2(100) NOT NULL
);
/

-- Songs Table
CREATE TABLE Songs (
  Song_Id NUMBER DEFAULT song_id_seq.NEXTVAL PRIMARY KEY, 
  Song_Name VARCHAR2(100) NOT NULL,
  Language VARCHAR2(50) NOT NULL,
  Genre VARCHAR2(50) NOT NULL,
  Album_Id NUMBER NOT NULL,
  CONSTRAINT fk_Songs_Album_Id FOREIGN KEY (Album_Id) REFERENCES Album(Album_Id)
);
/

-- Playlists Table
CREATE TABLE Playlists (
  Playlist_Id NUMBER DEFAULT playlist_id_seq.NEXTVAL PRIMARY KEY, 
  Playlist_Name VARCHAR2(100) NOT NULL,
  Customer_Id NUMBER NOT NULL,
  CONSTRAINT fk_Playlists_Customer_Id FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id)
);
/

-- Downloaded_Songs Table
CREATE TABLE Downloaded_Songs (
  Customer_Id NUMBER NOT NULL,
  Song_Id NUMBER NOT NULL,
  CONSTRAINT fk_Downloaded_Songs_Customer_Id FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id),
  CONSTRAINT fk_Downloaded_Songs_Song_Id FOREIGN KEY (Song_Id) REFERENCES Songs(Song_Id)
);
/

-- History Table
CREATE TABLE History (
  Song_Id NUMBER NOT NULL,
  Customer_Id NUMBER NOT NULL,
  History_Date DATE NOT NULL,
  CONSTRAINT fk_History_Customer_Id FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id),
  CONSTRAINT fk_History_Song_Id FOREIGN KEY (Song_Id) REFERENCES Songs(Song_Id)
);
/

