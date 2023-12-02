
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

CREATE VIEW GenreSongCount AS 
SELECT Genre, COUNT(*) AS NumberOfSongs 
FROM Songs 
GROUP BY Genre;
/

SELECT * FROM GenreSongCount;

CREATE OR REPLACE VIEW Most_Used_Promocodes AS
SELECT p.Promocode_Id, p.Promocode_Name, COUNT(*) AS Usage_Count
FROM Promocodes p
JOIN Transaction t ON p.Promocode_Id = t.Promocode_Id
GROUP BY p.Promocode_Id, p.Promocode_Name
ORDER BY Usage_Count DESC;
/

SELECT * FROM Most_Used_Promocodes;

CREATE OR REPLACE VIEW Transaction_Payment_Type_Count AS
SELECT 
    PM.Payment_Type, 
    COUNT(*) AS Transaction_Count
FROM 
    Transaction T
JOIN 
    Payment_Method PM ON T.Payment_Id = PM.Payment_Id
GROUP BY 
    PM.Payment_Type;


SELECT * FROM Transaction_Payment_Type_Count;


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


CREATE OR REPLACE VIEW Promocodes_Expiring_Soon AS
SELECT Promocode_Id, Promocode_Name, Discount, Expiry_Date
FROM Promocodes
WHERE Expiry_Date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '10' DAY;
/

SELECT * FROM Promocodes_Expiring_Soon;

CREATE OR REPLACE VIEW Playlist_Summary AS
SELECT 
    p.Customer_Id,
    p.Playlist_Name,
    COUNT(sp.Song_Id) AS NumberOfSongs
FROM 
    Playlist p
JOIN 
    Songs_Playlist sp ON p.Playlist_Id = sp.Playlist_Id
GROUP BY 
    p.Customer_Id, p.Playlist_Name;


SELECT * FROM Playlist_Summary;


CREATE OR REPLACE VIEW User_Recommendations AS
SELECT DISTINCT s.Song_Id, s.Song_Name, s.Genre
FROM Songs s
WHERE s.Genre IN (
    SELECT DISTINCT s.Genre
    FROM Songs s
    JOIN History h ON h.Song_Id = s.Song_Id
    UNION
    SELECT DISTINCT s.Genre
    FROM Songs s
    JOIN Downloaded_Songs ds ON ds.Song_Id = s.Song_Id
)
AND s.Song_Id NOT IN (
    SELECT h.Song_Id
    FROM History h
    UNION
    SELECT ds.Song_Id
    FROM Downloaded_Songs ds
);
/


SELECT * FROM User_Recommendations;


CREATE OR REPLACE VIEW User_Recommendation AS
WITH UserHistory AS (
    SELECT DISTINCT s.Genre
    FROM Songs s
    JOIN History h ON h.Song_Id = s.Song_Id
    WHERE h.Customer_Id = 4
),
UserDownloads AS (
    SELECT DISTINCT s.Genre
    FROM Songs s
    JOIN Downloaded_Songs ds ON ds.Song_Id = s.Song_Id
    WHERE ds.Customer_Id = 4
),
AllGenres AS (
    SELECT DISTINCT Genre
    FROM Songs
)
SELECT DISTINCT s.Song_Id, s.Song_Name, s.Genre
FROM Songs s
WHERE s.Genre IN (
    SELECT DISTINCT Genre
    FROM UserHistory
    UNION
    SELECT DISTINCT Genre
    FROM UserDownloads
)
AND s.Song_Id NOT IN (
    SELECT DISTINCT h.Song_Id
    FROM History h
    WHERE h.Customer_Id = 4
    UNION
    SELECT DISTINCT ds.Song_Id
    FROM Downloaded_Songs ds
    WHERE ds.Customer_Id = 4
)
OR NOT EXISTS (
    SELECT 1
    FROM UserHistory
    UNION
    SELECT 1
    FROM UserDownloads
)
;

-- Replace 4 with the actual customer ID you want to recommend songs for.

SELECT * FROM User_Recommendation;

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
SELECT * FROM Playlist;

CREATE OR REPLACE VIEW Downloaded_Songs_View AS
SELECT * FROM Downloaded_Songs;

CREATE OR REPLACE VIEW History_View AS
SELECT * FROM History;

SELECT * FROM History_View;

CREATE OR REPLACE VIEW Songs_Playlist_View AS
SELECT * FROM Songs_Playlist;

