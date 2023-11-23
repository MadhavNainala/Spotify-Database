BEGIN
    InsertCustomer('JohnDoe1', 'pass123', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'M', 'Y');
    InsertCustomer('JaneDoe2', 'pass234', TO_DATE('1985-02-02', 'YYYY-MM-DD'), 'F', 'N');
    InsertCustomer('JimDoe3', 'pass345', TO_DATE('1992-03-03', 'YYYY-MM-DD'), 'M', 'Y');
    InsertCustomer('JillDoe4', 'pass456', TO_DATE('1988-04-04', 'YYYY-MM-DD'), 'F', 'N');
    InsertCustomer('JackDoe5', 'pass567', TO_DATE('1995-05-05', 'YYYY-MM-DD'), 'M', 'Y');
    InsertCustomer('UserDoe6', 'pass678', TO_DATE('1993-06-06', 'YYYY-MM-DD'), 'F', 'Y');
    InsertCustomer('UserDoe7', 'pass789', TO_DATE('1991-07-07', 'YYYY-MM-DD'), 'M', 'N');
    InsertCustomer('UserDoe8', 'pass890', TO_DATE('1989-08-08', 'YYYY-MM-DD'), 'F', 'Y');
    InsertCustomer('UserDoe9', 'pass901', TO_DATE('1994-09-09', 'YYYY-MM-DD'), 'M', 'N');
    InsertCustomer('UserDoe10', 'pass012', TO_DATE('1996-10-10', 'YYYY-MM-DD'), 'F', 'Y');
END;
/



BEGIN
    InsertBankAccount(123456789, 'John Doe', 987654321, 'Checking');
    InsertBankAccount(123456790, 'Jane Smith', 987654322, 'Savings');
    InsertBankAccount(123456791, 'Emily Johnson', 987654323, 'Checking');
    InsertBankAccount(123456792, 'Michael Brown', 987654324, 'Savings');
    InsertBankAccount(123456793, 'Chris Davis', 987654325, 'Checking');
    InsertBankAccount(123456794, 'Alex Martinez', 987654326, 'Savings');
    InsertBankAccount(123456795, 'Taylor White', 987654327, 'Checking');
    InsertBankAccount(123456796, 'Morgan Lewis', 987654328, 'Savings');
    InsertBankAccount(123456797, 'Jamie Clark', 987654329, 'Checking');
    InsertBankAccount(123456798, 'Casey Robinson', 987654330, 'Savings');
END;
/


BEGIN
    InsertCard(1111222233334444, 'John', 'Doe', TO_DATE('2025-12', 'YYYY-MM'), 123, '10001');
    InsertCard(1111222233334445, 'Jane', 'Smith', TO_DATE('2024-11', 'YYYY-MM'), 456, '10002');
    InsertCard(1111222233334446, 'Emily', 'Johnson', TO_DATE('2026-10', 'YYYY-MM'), 789, '10003');
    InsertCard(1111222233334447, 'Michael', 'Brown', TO_DATE('2023-09', 'YYYY-MM'), 101, '10004');
    InsertCard(1111222233334448, 'Chris', 'Davis', TO_DATE('2027-08', 'YYYY-MM'), 202, '10005');
    InsertCard(1111222233334449, 'Alex', 'Martinez', TO_DATE('2028-07', 'YYYY-MM'), 303, '10006');
    InsertCard(1111222233334450, 'Taylor', 'White', TO_DATE('2022-06', 'YYYY-MM'), 404, '10007');
    InsertCard(1111222233334451, 'Morgan', 'Lewis', TO_DATE('2021-05', 'YYYY-MM'), 505, '10008');
    InsertCard(1111222233334452, 'Jamie', 'Clark', TO_DATE('2029-04', 'YYYY-MM'), 606, '10009');
    InsertCard(1111222233334453, 'Casey', 'Robinson', TO_DATE('2030-03', 'YYYY-MM'), 707, '10010');
END;
/





BEGIN
    InsertPromocode('NEWYEAR2024', 15, TO_DATE('2024-01-31', 'YYYY-MM-DD'));
    InsertPromocode('SPRINGSALE', 20, TO_DATE('2023-05-31', 'YYYY-MM-DD'));
    InsertPromocode('SUMMER2023', 25, TO_DATE('2023-08-31', 'YYYY-MM-DD'));
    InsertPromocode('FALLFLAT10', 10, TO_DATE('2023-11-30', 'YYYY-MM-DD'));
    InsertPromocode('HOLIDAY2023', 30, TO_DATE('2023-12-25', 'YYYY-MM-DD'));
    InsertPromocode('WINTERWARMER', 15, TO_DATE('2023-02-28', 'YYYY-MM-DD'));
    InsertPromocode('SPRINGBLOOM', 10, TO_DATE('2023-04-30', 'YYYY-MM-DD'));
    InsertPromocode('SUMMEREND', 20, TO_DATE('2023-09-30', 'YYYY-MM-DD'));
    InsertPromocode('AUTUMN2023', 10, TO_DATE('2023-10-31', 'YYYY-MM-DD'));
    InsertPromocode('CYBERMONDAY', 35, TO_DATE('2023-11-27', 'YYYY-MM-DD'));
END;
/


BEGIN
    InsertPaymentMethod('Bank_Account', 1);
    InsertPaymentMethod('Card', 2);
    InsertPaymentMethod('Bank_Account', 3);
    InsertPaymentMethod('Card', 4);
    InsertPaymentMethod('Bank_Account', 5);
    InsertPaymentMethod('Card', 6);
    InsertPaymentMethod('Bank_Account', 7);
    InsertPaymentMethod('Card', 8);
    InsertPaymentMethod('Bank_Account', 9);
    InsertPaymentMethod('Card', 10);
END;
/




BEGIN
    InsertTransaction(SYSTIMESTAMP, 15, 1, 'Y', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'), 2);
    InsertTransaction(SYSTIMESTAMP, 20, 2, 'N', TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2023-07-31', 'YYYY-MM-DD'), 3);
    InsertTransaction(SYSTIMESTAMP, 20, 3, 'Y', TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-08-31', 'YYYY-MM-DD'), 1);
    InsertTransaction(SYSTIMESTAMP, 20, 4, 'N', TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2023-12-30', 'YYYY-MM-DD'), 2);
    InsertTransaction(SYSTIMESTAMP, 100, 5, 'Y', TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 3);
    InsertTransaction(SYSTIMESTAMP, 12, 6, 'Y', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2024-01-31', 'YYYY-MM-DD'), 1);
    InsertTransaction(SYSTIMESTAMP, 20, 7, 'N', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2024-02-28', 'YYYY-MM-DD'), 2);
    InsertTransaction(SYSTIMESTAMP, 130, 8, 'Y', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2024-03-31', 'YYYY-MM-DD'), 3);
    InsertTransaction(SYSTIMESTAMP, 220, 9, 'N', TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2024-04-30', 'YYYY-MM-DD'), 1);
    InsertTransaction(SYSTIMESTAMP, 18, 10, 'Y', TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2024-05-31', 'YYYY-MM-DD'), 2);
END;
/


-- Repeat four more times with different parameters

BEGIN
    InsertAlbum('Thriller');
    InsertAlbum('Back in Black');
    InsertAlbum('The Dark Side of the Moon');
    InsertAlbum('The Bodyguard');
    InsertAlbum('Bat Out of Hell');
    InsertAlbum('Their Greatest Hits');
    InsertAlbum('Saturday Night Fever');
    InsertAlbum('Rumours');
    InsertAlbum('The Eagles');
    InsertAlbum('Hotel California');
END;
/

BEGIN
    InsertSong('Shape of You', 'English', 'Pop', 1);
    InsertSong('See You Again', 'English', 'Pop', 2);
    InsertSong('Uptown Funk', 'English', 'Funk', 3);
    InsertSong('Rockstar', 'English', 'Rock', 4);
    InsertSong('Closer', 'English', 'Electronic', 5);
    InsertSong('Dance Monkey', 'English', 'Pop', 6);
    InsertSong('Faded', 'English', 'Electronic', 7);
    InsertSong('One Dance', 'English', 'Pop', 8);
    InsertSong('Sunflower', 'English', 'Pop', 9);
    InsertSong('Senorita', 'English', 'Pop', 10);
END;
/

BEGIN
    InsertPlaylist('My Favorites', 1, 1);
    InsertPlaylist('Morning Vibes', 2, 2);
    InsertPlaylist('Workout Hits', 3, 3);
    InsertPlaylist('Chill Beats', 4, 4);
    InsertPlaylist('Party Mix', 5, 5);
    InsertPlaylist('Rock Classics', 6, 6);
    InsertPlaylist('Jazz Essentials', 7, 7);
    InsertPlaylist('Hip Hop Hits', 8, 8);
    InsertPlaylist('Country Roads', 9, 9);
    InsertPlaylist('Pop Stars', 10, 10);
END;
/

BEGIN
    InsertDownloadedSong(1, 1);
    InsertDownloadedSong(2, 4);
    InsertDownloadedSong(3, 3);
    InsertDownloadedSong(4, 2);
    InsertDownloadedSong(5, 5);
    InsertDownloadedSong(7, 7);
    InsertDownloadedSong(7, 7);
    InsertDownloadedSong(8, 8);
    InsertDownloadedSong(9, 5);
    InsertDownloadedSong(10, 4);
END;
/

BEGIN
    InsertHistory(1, 1, TO_DATE('2023-11-24', 'YYYY-MM-DD'));
    InsertHistory(2, 2, TO_DATE('2023-11-23', 'YYYY-MM-DD'));
    InsertHistory(3, 3, TO_DATE('2023-11-22', 'YYYY-MM-DD'));
    InsertHistory(4, 4, TO_DATE('2023-11-21', 'YYYY-MM-DD'));
    InsertHistory(5, 5, TO_DATE('2023-11-20', 'YYYY-MM-DD'));
    InsertHistory(6, 6, TO_DATE('2023-11-19', 'YYYY-MM-DD'));
    InsertHistory(7, 7, TO_DATE('2023-11-18', 'YYYY-MM-DD'));
    InsertHistory(8, 8, TO_DATE('2023-11-17', 'YYYY-MM-DD'));
    InsertHistory(9, 9, TO_DATE('2023-11-16', 'YYYY-MM-DD'));
    InsertHistory(10, 10, TO_DATE('2023-11-15', 'YYYY-MM-DD'));
END;
/








