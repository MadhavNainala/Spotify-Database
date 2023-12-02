--views 
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

CREATE OR REPLACE VIEW Most_Downloaded_Song_And_Album AS
SELECT s.Song_Name, a.Album_Name
FROM Songs s
JOIN Album a ON s.Album_Id = a.Album_Id
JOIN Downloaded_Songs ds ON s.Song_Id = ds.Song_Id
GROUP BY s.Song_Name, a.Album_Name
ORDER BY COUNT(*) DESC
FETCH FIRST 5 ROW ONLY;
/

CREATE OR REPLACE VIEW Most_Used_Promocodes AS
SELECT p.Promocode_Name, COUNT(*) AS Usage_Count
FROM Promocodes p
JOIN Transaction t ON p.Promocode_Id = t.Promocode_Id
GROUP BY p.Promocode_Name
ORDER BY Usage_Count DESC
FETCH FIRST 5 ROW ONLY;
/

CREATE OR REPLACE VIEW Most_Listened_Genre_By_Customer AS
SELECT s.Genre, COUNT(*) AS Listen_Count
FROM History h
JOIN Songs s ON h.Song_Id = s.Song_Id
GROUP BY s.Genre
ORDER BY Listen_Count DESC;
/

CREATE OR REPLACE VIEW Most_Used_Payment_Type AS
SELECT pm.Payment_Type, COUNT(*) AS Usage_Count
FROM Payment_Method pm
GROUP BY pm.Payment_Type
ORDER BY Usage_Count DESC;
/

CREATE OR REPLACE VIEW Avg_Transaction_Price_Per_Customer AS
SELECT Customer_Id, AVG(Price) AS Avg_Price
FROM Transaction
GROUP BY Customer_Id;
/

CREATE OR REPLACE VIEW Song_Count_By_Genre AS
SELECT Genre, COUNT(*) AS Song_Count
FROM Songs
GROUP BY Genre;
/

CREATE OR REPLACE VIEW Revenue_Per_Transaction AS
SELECT Transaction_Id, SUM(Price) AS Total_Revenue, AVG(Price) AS Avg_Price
FROM Transaction
GROUP BY Transaction_Id;
/

CREATE OR REPLACE VIEW Most_Active_Customers AS
SELECT Customer_Id, COUNT(*) AS Transaction_Count
FROM Transaction
GROUP BY Customer_Id
ORDER BY Transaction_Count DESC
FETCH FIRST 5 ROW ONLY;
/

CREATE OR REPLACE VIEW Revenue_By_Payment_Type AS
SELECT pm.Payment_Type, SUM(t.Price) AS Total_Revenue
FROM Payment_Method pm
JOIN Transaction t ON pm.Customer_Id = t.Customer_Id
GROUP BY pm.Payment_Type;
/

CREATE OR REPLACE VIEW Transactions_Per_Customer_Per_Month AS
SELECT
    Customer_Id,
    TO_CHAR(Transaction_Time, 'YYYY-MM') AS Month,
    COUNT(*) AS Transaction_Count
FROM Transaction
GROUP BY Customer_Id, TO_CHAR(Transaction_Time, 'YYYY-MM');
/

CREATE OR REPLACE VIEW Avg_Promocode_Discount AS
SELECT
    Promocode_Id,
    AVG(Discount) AS Avg_Discount
FROM Promocodes
GROUP BY Promocode_Id;
/

CREATE OR REPLACE VIEW Most_Popular_Genre_Active_Subscribers AS
SELECT
    s.Genre,
    COUNT(*) AS Subscriber_Count
FROM
    History h
JOIN
    Songs s ON h.Song_Id = s.Song_Id
JOIN
    Customers c ON h.Customer_Id = c.Customer_Id
WHERE
    c.Subscription = 'Y'
GROUP BY
    s.Genre
ORDER BY
    Subscriber_Count DESC;
/

CREATE OR REPLACE VIEW Total_Revenue_Per_Customer AS
SELECT
    Customer_Id,
    SUM(Price) AS Total_Revenue
FROM
    Transaction
GROUP BY
    Customer_Id;
/

CREATE OR REPLACE VIEW Avg_Downloads_Per_Song AS
SELECT
    Song_Id,
    AVG(Download_Count) AS Avg_Downloads
FROM (
    SELECT
        Song_Id,
        COUNT(*) AS Download_Count
    FROM
        Downloaded_Songs
    GROUP BY
        Song_Id
) ds
GROUP BY
    Song_Id;
/

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
--display views
select * from Most_Listened_Song_Of_The_Month;
select * from Most_Downloaded_Song_And_Album;
select * from Most_Used_Promocodes;
select * from Most_Listened_Genre_By_Customer;
select * from Most_Used_Payment_Type;
select * from Avg_Transaction_Price_Per_Customer;
select * from Song_Count_By_Genre;
select * from Revenue_Per_Transaction;
select * from Most_Active_Customers;
select * from Revenue_By_Payment_Type;
select * from Transactions_Per_Customer_Per_Month;
select * from Avg_Promocode_Discount;
select * from Most_Popular_Genre_Active_Subscribers;
select * from Total_Revenue_Per_Customer;
select * from Avg_Downloads_Per_Song;
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

/*
SELECT * FROM Customers;

SELECT * FROM Promocodes;

SELECT * FROM Payment_Method;

SELECT * FROM Bank_Account;

SELECT * FROM Card;

SELECT * FROM Transaction;

SELECT * FROM Album;

SELECT * FROM Songs;

SELECT * FROM Playlists;

SELECT * FROM Downloaded_Songs;

SELECT * FROM History;
*/
