CREATE OR REPLACE PROCEDURE InsertCustomer(
    p_profile_name VARCHAR2,
    p_password VARCHAR2,
    p_dob DATE,
    p_gender VARCHAR2,
    p_subscription CHAR
) IS
  v_count NUMBER;
BEGIN
  IF p_profile_name IS NULL OR p_dob IS NULL THEN
    RAISE_APPLICATION_ERROR(-20001, 'Profile name and date of birth are mandatory.');
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
    RAISE;
END;
/


CREATE OR REPLACE PROCEDURE InsertPaymentMethod(
    p_payment_type VARCHAR2,
    p_customer_id NUMBER
) IS
BEGIN
  INSERT INTO Payment_Method(Payment_Type, Customer_Id)
  VALUES (p_payment_type, p_customer_id);
EXCEPTION
  WHEN OTHERS THEN
    RAISE;
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
  INSERT INTO Bank_Account(Account_Number, Full_Name, Routing_Number, Account_Type, Account_Limit, Payment_Id)
  VALUES (p_account_number, p_full_name, p_routing_number, p_account_type, p_account_limit, p_payment_id);
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
    p_zip VARCHAR2,
    p_payment_id NUMBER
) IS
BEGIN
  INSERT INTO Card(Card_Number, First_Name, Last_Name, Expiry_Date, CVV_Code, Zip, Payment_Id)
  VALUES (p_card_number, p_first_name, p_last_name, p_expiry_date, p_cvv_code, p_zip, p_payment_id);
EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END;
/
