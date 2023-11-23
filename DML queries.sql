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
