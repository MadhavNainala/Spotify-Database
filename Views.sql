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
