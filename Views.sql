--Views
CREATE OR REPLACE VIEW Most_Downloaded_Songs AS
SELECT s.Song_Id, s.Song_Name, a.Album_Name, COUNT(*) AS Download_Count
FROM Songs s
JOIN Downloaded_Songs ds ON s.Song_Id = ds.Song_Id
JOIN Album a ON s.Album_Id = a.Album_Id
GROUP BY s.Song_Id, s.Song_Name, a.Album_Name
ORDER BY Download_Count DESC;
/


SELECT * FROM Most_Downloaded_Songs;

CREATE OR REPLACE VIEW Most_Listened_Song_And_Album AS
SELECT s.Song_Id, s.Song_Name, a.Album_Name, COUNT(*) AS Listen_Count
FROM Songs s
JOIN History h ON s.Song_Id = h.Song_Id
JOIN Album a ON s.Album_Id = a.Album_Id
GROUP BY s.Song_Id, s.Song_Name, a.Album_Name
ORDER BY Listen_Count DESC;
/


SELECT * FROM Most_Listened_Song_And_Album;


CREATE OR REPLACE VIEW Most_Used_Promocodes AS
SELECT p.Promocode_Id, p.Promocode_Name, COUNT(*) AS Usage_Count
FROM Promocodes p
JOIN Transaction t ON p.Promocode_Id = t.Promocode_Id
GROUP BY p.Promocode_Id, p.Promocode_Name
ORDER BY Usage_Count DESC;
/

SELECT * FROM Most_Used_Promocodes;

CREATE OR REPLACE VIEW Transaction_Counts_By_Payment_Type AS
SELECT 
    (SELECT COUNT(*) FROM Transaction t
     JOIN Payment_Method pm ON t.Customer_Id = pm.Customer_Id
     WHERE pm.Payment_Type = 'Bank_Account') AS Bank_Account_Transactions,

    (SELECT COUNT(*) FROM Transaction t
     JOIN Payment_Method pm ON t.Customer_Id = pm.Customer_Id
     WHERE pm.Payment_Type = 'Card') AS Card_Transactions
FROM dual;
/

SELECT * FROM Transaction_Counts_By_Payment_Type;


CREATE OR REPLACE VIEW Transaction_Outcomes AS
SELECT 
    COUNT(CASE WHEN (t.Price + NVL(p.Discount, 0)) = 20 THEN 1 END) AS Succeeded_Transactions,
    COUNT(CASE WHEN (t.Price + NVL(p.Discount, 0)) != 20 THEN 1 END) AS Failed_Transactions
FROM Transaction t
LEFT JOIN Promocodes p ON t.Promocode_Id = p.Promocode_Id;
/

SELECT * FROM Transaction_Outcomes;

CREATE OR REPLACE VIEW Subscription_Status_Count AS
SELECT 
    COUNT(CASE WHEN Subscription = 'Y' THEN 1 END) AS Customers_With_Subscription,
    COUNT(CASE WHEN Subscription = 'N' THEN 1 END) AS Customers_Without_Subscription
FROM Customers;
/

SELECT * FROM Subscription_Status_Count;
/

CREATE OR REPLACE VIEW Most_Listened_Song_Of_The_Month AS
SELECT s.Song_Id, s.Song_Name, COUNT(*) AS Listen_Count
FROM Songs s
JOIN History h ON s.Song_Id = h.Song_Id
WHERE EXTRACT(MONTH FROM h.History_Date) = EXTRACT(MONTH FROM CURRENT_DATE)
AND EXTRACT(YEAR FROM h.History_Date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY s.Song_Id, s.Song_Name
ORDER BY Listen_Count DESC
FETCH FIRST 5 ROW ONLY;
/

SELECT * FROM Most_Listened_Song_Of_The_Month;

CREATE OR REPLACE VIEW Most_Used_Payment_Type AS
SELECT pm.Payment_Type, COUNT(*) AS Usage_Count
FROM Payment_Method pm
GROUP BY pm.Payment_Type
ORDER BY Usage_Count DESC;
/

SELECT * FROM Most_Used_Payment_Type;

CREATE OR REPLACE VIEW Song_Count_By_Genre AS
SELECT Genre, COUNT(*) AS Song_Count
FROM Songs
GROUP BY Genre;
/

SELECT * FROM Song_Count_By_Genre;

CREATE OR REPLACE VIEW Revenue_By_Payment_Type AS
SELECT pm.Payment_Type, SUM(t.Price) AS Total_Revenue
FROM Payment_Method pm
JOIN Transaction t ON pm.Customer_Id = t.Customer_Id
GROUP BY pm.Payment_Type;
/

SELECT * FROM Revenue_By_Payment_Type;

CREATE OR REPLACE VIEW Customers_View AS
SELECT * FROM Customers;

CREATE OR REPLACE VIEW Promocodes_View AS
SELECT * FROM Promocodes;

CREATE OR REPLACE VIEW Payment_Method_View AS
SELECT * FROM Payment_Method;

CREATE OR REPLACE VIEW Bank_Account_View AS
SELECT * FROM Bank_Account;

CREATE OR REPLACE VIEW Card_View AS
SELECT * FROM Card;

CREATE OR REPLACE VIEW Transaction_View AS
SELECT * FROM Transaction;

CREATE OR REPLACE VIEW Album_View AS
SELECT * FROM Album;

CREATE OR REPLACE VIEW Songs_View AS
SELECT * FROM Songs;

CREATE OR REPLACE VIEW Playlists_View AS
SELECT * FROM Playlists;

CREATE OR REPLACE VIEW Downloaded_Songs_View AS
SELECT * FROM Downloaded_Songs;

CREATE OR REPLACE VIEW History_View AS
SELECT * FROM History;

/*
SELECT * FROM Customers_View;
SELECT * FROM Promocodes_View;
SELECT * FROM Payment_Method_View;
SELECT * FROM Bank_Account_View;
SELECT * FROM Card_View;
SELECT * FROM Transaction_View;
SELECT * FROM Album_View;
SELECT * FROM Songs_View;
SELECT * FROM Playlists_View;
SELECT * FROM Downloaded_Songs_View;
SELECT * FROM History_View;
*/
