CREATE VIEW Most_Listened_Song_Of_The_Month AS
SELECT s.Song_Id, s.Song_Name, COUNT(*) AS Listen_Count
FROM Songs s
JOIN History h ON s.Song_Id = h.Song_Id
WHERE EXTRACT(MONTH FROM h.History_Date) = EXTRACT(MONTH FROM CURRENT_DATE)
AND EXTRACT(YEAR FROM h.History_Date) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY s.Song_Id, s.Song_Name
ORDER BY Listen_Count DESC
FETCH FIRST 1 ROW ONLY;

CREATE VIEW Most_Downloaded_Song_And_Album AS
SELECT s.Song_Name, a.Album_Name
FROM Songs s
JOIN Album a ON s.Album_Id = a.Album_Id
JOIN Downloaded_Songs ds ON s.Song_Id = ds.Song_Id
GROUP BY s.Song_Name, a.Album_Name
ORDER BY COUNT(*) DESC
FETCH FIRST 1 ROW ONLY;

CREATE VIEW Most_Used_Promocodes AS
SELECT p.Promocode_Id, p.Promocode_Name, COUNT(*) AS Usage_Count
FROM Promocodes p
JOIN Payment_Method pm ON p.Promocode_Id = pm.Promocode_Id
GROUP BY p.Promocode_Id, p.Promocode_Name
ORDER BY Usage_Count DESC
FETCH FIRST 1 ROW ONLY;

CREATE VIEW Most_Listened_Genre_By_Customer AS
SELECT h.Customer_Id, s.Genre, COUNT(*) AS Listen_Count
FROM History h
JOIN Songs s ON h.Song_Id = s.Song_Id
GROUP BY h.Customer_Id, s.Genre
ORDER BY h.Customer_Id, Listen_Count DESC;

