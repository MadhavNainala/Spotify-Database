BEGIN
  MusicServicePackage.InsertCustomer('Alice', 'alice123', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 'F', 'Y');
  MusicServicePackage.InsertCustomer('Bob', 'bob123', TO_DATE('1990-08-20', 'YYYY-MM-DD'), 'M', 'N');
  MusicServicePackage.InsertCustomer('Charlie', 'charlie123', TO_DATE('1992-03-22', 'YYYY-MM-DD'), 'M', 'Y');
  MusicServicePackage.InsertCustomer('Diana', 'diana456', TO_DATE('1988-11-05', 'YYYY-MM-DD'), 'F', 'Y');
  MusicServicePackage.InsertCustomer('Ethan', 'ethan789', TO_DATE('1975-01-15', 'YYYY-MM-DD'), 'M', 'N');
  MusicServicePackage.InsertCustomer('Fiona', 'fiona321', TO_DATE('2000-07-21', 'YYYY-MM-DD'), 'F', 'Y');
  MusicServicePackage.InsertCustomer('George', 'george654', TO_DATE('1983-09-30', 'YYYY-MM-DD'), 'M', 'N');
  MusicServicePackage.InsertCustomer('Hannah', 'hannah890', TO_DATE('1995-12-12', 'YYYY-MM-DD'), 'F', 'Y');
  MusicServicePackage.InsertCustomer('Ian', 'ian123', TO_DATE('1980-04-27', 'YYYY-MM-DD'), 'M', 'N');
  MusicServicePackage.InsertCustomer('Julia', 'julia456', TO_DATE('1998-02-08', 'YYYY-MM-DD'), 'F', 'Y');
  MusicServicePackage.InsertCustomer('Katherine', 'katherine789', TO_DATE('1987-06-10', 'YYYY-MM-DD'), 'F', 'N');
  MusicServicePackage.InsertCustomer('Liam', 'liam012', TO_DATE('1993-09-18', 'YYYY-MM-DD'), 'M', 'Y');
  MusicServicePackage.InsertCustomer('Mia', 'mia345', TO_DATE('1982-12-25', 'YYYY-MM-DD'), 'F', 'Y');
  MusicServicePackage.InsertCustomer('Nathan', 'nathan678', TO_DATE('1978-03-08', 'YYYY-MM-DD'), 'M', 'N');
  MusicServicePackage.InsertCustomer('Olivia', 'olivia901', TO_DATE('1996-05-20', 'YYYY-MM-DD'), 'F', 'Y');
  MusicServicePackage.InsertCustomer('Paul', 'paul234', TO_DATE('1989-07-15', 'YYYY-MM-DD'), 'M', 'N');
  MusicServicePackage.InsertCustomer('Quinn', 'quinn567', TO_DATE('1984-10-29', 'YYYY-MM-DD'), 'F', 'Y');
  MusicServicePackage.InsertCustomer('Ryan', 'ryan890', TO_DATE('1991-02-14', 'YYYY-MM-DD'), 'M', 'N');
  MusicServicePackage.InsertCustomer('Sophia', 'sophia123', TO_DATE('1973-04-02', 'YYYY-MM-DD'), 'F', 'Y');
  MusicServicePackage.InsertCustomer('Travis', 'travis456', TO_DATE('2002-08-07', 'YYYY-MM-DD'), 'M', 'Y');
END;
/


BEGIN
  MusicServicePackage.InsertBankAccount(123456789, 'Alice Smith', 987654321, 'Checking');
  MusicServicePackage.InsertBankAccount(987654321, 'Bob Johnson', 123456789, 'Savings');
  MusicServicePackage.InsertBankAccount(456789123, 'Carol White', 567891234, 'Checking');
  MusicServicePackage.InsertBankAccount(321987654, 'David Brown', 654321987, 'Savings');
  MusicServicePackage.InsertBankAccount(789123456, 'Eve Martinez', 891234567, 'Checking');
  MusicServicePackage.InsertBankAccount(654789321, 'Frank Wilson', 432198765, 'Savings');
  MusicServicePackage.InsertBankAccount(987321654, 'Grace Lee', 789654123, 'Checking');
  MusicServicePackage.InsertBankAccount(123654789, 'Henry Garcia', 321456987, 'Savings');
  MusicServicePackage.InsertBankAccount(654123987, 'Ivy Hall', 987654321, 'Checking');
  MusicServicePackage.InsertBankAccount(321456789, 'Jack Davis', 123789654, 'Savings');
  MusicServicePackage.InsertBankAccount(111222333, 'Katherine Smith', 444555666, 'Checking');
  MusicServicePackage.InsertBankAccount(555444333, 'Liam Johnson', 666777888, 'Savings');
  MusicServicePackage.InsertBankAccount(999888777, 'Mia White', 111222333, 'Checking');
  MusicServicePackage.InsertBankAccount(777999888, 'Nathan Brown', 888777999, 'Savings');
  MusicServicePackage.InsertBankAccount(333666999, 'Olivia Martinez', 555666777, 'Checking');
  MusicServicePackage.InsertBankAccount(888777666, 'Paul Wilson', 222333444, 'Savings');
  MusicServicePackage.InsertBankAccount(222444666, 'Quinn Lee', 777888999, 'Checking');
  MusicServicePackage.InsertBankAccount(666333222, 'Ryan Garcia', 444555666, 'Savings');
  MusicServicePackage.InsertBankAccount(444111222, 'Sophia Hall', 999888777, 'Checking');
  MusicServicePackage.InsertBankAccount(777888111, 'Travis Davis', 666999888, 'Savings');
END;
/



BEGIN
  MusicServicePackage.InsertCard(1111222233334444, 'Alice', 'Smith', TO_DATE('2025-05', 'YYYY-MM'), 321, '54321');
  MusicServicePackage.InsertCard(4444333322221111, 'Bob', 'Johnson', TO_DATE('2026-06', 'YYYY-MM'), 123, '98765');
  MusicServicePackage.InsertCard(5555666677778888, 'Carol', 'White', TO_DATE('2024-07', 'YYYY-MM'), 456, '67890');
  MusicServicePackage.InsertCard(8888777766665555, 'David', 'Brown', TO_DATE('2027-08', 'YYYY-MM'), 789, '12345');
  MusicServicePackage.InsertCard(2222999988887777, 'Eve', 'Martinez', TO_DATE('2023-09', 'YYYY-MM'), 234, '56789');
  MusicServicePackage.InsertCard(7777888899992222, 'Frank', 'Wilson', TO_DATE('2028-10', 'YYYY-MM'), 567, '23456');
  MusicServicePackage.InsertCard(3333111144449999, 'Grace', 'Lee', TO_DATE('2022-11', 'YYYY-MM'), 890, '34567');
  MusicServicePackage.InsertCard(9999000011113333, 'Henry', 'Garcia', TO_DATE('2029-12', 'YYYY-MM'), 123, '45678');
  MusicServicePackage.InsertCard(6666777788880000, 'Ivy', 'Hall', TO_DATE('2025-01', 'YYYY-MM'), 345, '78901');
  MusicServicePackage.InsertCard(4444555566667777, 'Jack', 'Davis', TO_DATE('2026-02', 'YYYY-MM'), 678, '89012');
  MusicServicePackage.InsertCard(9876123456788765, 'Katherine', 'Smith', TO_DATE('2026-03', 'YYYY-MM'), 789, '45678');
  MusicServicePackage.InsertCard(8765234567897654, 'Liam', 'Johnson', TO_DATE('2024-04', 'YYYY-MM'), 654, '12345');
  MusicServicePackage.InsertCard(7654345678906543, 'Mia', 'White', TO_DATE('2025-05', 'YYYY-MM'), 321, '78901');
  MusicServicePackage.InsertCard(6543456789015432, 'Nathan', 'Brown', TO_DATE('2027-06', 'YYYY-MM'), 987, '23456');
  MusicServicePackage.InsertCard(5432567890124321, 'Olivia', 'Martinez', TO_DATE('2023-07', 'YYYY-MM'), 012, '56789');
  MusicServicePackage.InsertCard(4321678901233210, 'Paul', 'Wilson', TO_DATE('2028-08', 'YYYY-MM'), 890, '23456');
  MusicServicePackage.InsertCard(3210789012342109, 'Quinn', 'Lee', TO_DATE('2022-09', 'YYYY-MM'), 345, '78901');
  MusicServicePackage.InsertCard(2109890123451098, 'Ryan', 'Garcia', TO_DATE('2029-10', 'YYYY-MM'), 678, '12345');
  MusicServicePackage.InsertCard(1098901234560109, 'Sophia', 'Hall', TO_DATE('2025-11', 'YYYY-MM'), 901, '23456');
END;
/


BEGIN
    MusicServicePackage.InsertPromocode('NEWYEAR2024', 15, TO_DATE('2024-01-31', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('SPRINGSALE', 20, TO_DATE('2023-05-31', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('SUMMER2023', 25, TO_DATE('2023-08-31', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('FALLFLAT10', 10, TO_DATE('2023-11-30', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('HOLIDAY2023', 30, TO_DATE('2023-12-25', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('WINTERWARMER', 15, TO_DATE('2023-02-28', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('SPRINGBLOOM', 10, TO_DATE('2023-04-30', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('SUMMEREND', 20, TO_DATE('2023-09-30', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('AUTUMN2023', 10, TO_DATE('2023-10-31', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('CYBERMONDAY', 35, TO_DATE('2023-11-27', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('JANSAVINGS', 15, TO_DATE('2024-01-31', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('LOVE2024', 20, TO_DATE('2024-02-14', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('SPRING2024', 25, TO_DATE('2024-05-31', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('SUMMERFUN', 10, TO_DATE('2024-08-31', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('BACKTOSCHOOL', 30, TO_DATE('2024-09-15', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('FALLSAVINGS', 15, TO_DATE('2024-11-30', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('HOLIDAYCHEER', 25, TO_DATE('2024-12-25', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('WINTERSALE', 10, TO_DATE('2025-02-28', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('SPRINGSTART', 20, TO_DATE('2025-03-20', 'YYYY-MM-DD'));
    MusicServicePackage.InsertPromocode('SUMMERSIZZLE', 15, TO_DATE('2025-06-21', 'YYYY-MM-DD'));
END;
/


BEGIN
    MusicServicePackage.InsertPaymentMethod('Bank_Account', 1);
    MusicServicePackage.InsertPaymentMethod('Card', 2);
    MusicServicePackage.InsertPaymentMethod('Bank_Account', 3);
    MusicServicePackage.InsertPaymentMethod('Card', 4);
    MusicServicePackage.InsertPaymentMethod('Bank_Account', 5);
    MusicServicePackage.InsertPaymentMethod('Card', 6);
    MusicServicePackage.InsertPaymentMethod('Bank_Account', 7);
    MusicServicePackage.InsertPaymentMethod('Card', 8);
    MusicServicePackage.InsertPaymentMethod('Bank_Account', 9);
    MusicServicePackage.InsertPaymentMethod('Card', 10);
    MusicServicePackage.InsertPaymentMethod('Card', 11);
    MusicServicePackage.InsertPaymentMethod('Bank_Account', 12);
    MusicServicePackage.InsertPaymentMethod('Card', 13);
    MusicServicePackage.InsertPaymentMethod('Bank_Account', 14);
    MusicServicePackage.InsertPaymentMethod('Card', 15);
    MusicServicePackage.InsertPaymentMethod('Bank_Account', 16);
    MusicServicePackage.InsertPaymentMethod('Card', 17);
    MusicServicePackage.InsertPaymentMethod('Bank_Account', 18);
    MusicServicePackage.InsertPaymentMethod('Card', 19);
    MusicServicePackage.InsertPaymentMethod('Bank_Account', 20);
END;
/




BEGIN
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 15, 1, 'Y', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'), 2);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 20, 2, 'N', TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2023-07-31', 'YYYY-MM-DD'), 3);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 20, 3, 'Y', TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-08-31', 'YYYY-MM-DD'), 1);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 20, 4, 'N', TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2023-12-30', 'YYYY-MM-DD'), 2);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 100, 5, 'Y', TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 3);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 12, 6, 'Y', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2024-01-31', 'YYYY-MM-DD'), 1);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 20, 7, 'N', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2024-02-28', 'YYYY-MM-DD'), 2);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 130, 8, 'Y', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2024-03-31', 'YYYY-MM-DD'), 3);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 220, 9, 'N', TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2024-04-30', 'YYYY-MM-DD'), 1);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 18, 10, 'Y', TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2024-05-31', 'YYYY-MM-DD'), 2);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 25, 11, 'Y', TO_DATE('2023-11-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 3);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 30, 12, 'N', TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_DATE('2024-07-31', 'YYYY-MM-DD'), 1);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 35, 13, 'Y', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'), 2);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 40, 14, 'N', TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-12-30', 'YYYY-MM-DD'), 3);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 45, 15, 'Y', TO_DATE('2024-03-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 1);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 50, 16, 'Y', TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2025-01-31', 'YYYY-MM-DD'), 2);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 55, 17, 'N', TO_DATE('2024-05-01', 'YYYY-MM-DD'), TO_DATE('2025-02-28', 'YYYY-MM-DD'), 3);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 60, 18, 'Y', TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2025-03-31', 'YYYY-MM-DD'), 1);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 65, 19, 'N', TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2025-04-30', 'YYYY-MM-DD'), 2);
    MusicServicePackage.InsertTransaction(SYSTIMESTAMP, 70, 20, 'Y', TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2025-05-31', 'YYYY-MM-DD'), 3);
END;
/


BEGIN
    MusicServicePackage.InsertAlbum('Thriller');
    MusicServicePackage.InsertAlbum('Back in Black');
    MusicServicePackage.InsertAlbum('The Dark Side of the Moon');
    MusicServicePackage.InsertAlbum('The Bodyguard');
    MusicServicePackage.InsertAlbum('Bat Out of Hell');
    MusicServicePackage.InsertAlbum('Their Greatest Hits');
    MusicServicePackage.InsertAlbum('Saturday Night Fever');
    MusicServicePackage.InsertAlbum('Rumours');
    MusicServicePackage.InsertAlbum('The Eagles');
    MusicServicePackage.InsertAlbum('Hotel California');
    MusicServicePackage.InsertAlbum('Sgt. Pepper''s Lonely Hearts Club Band');
    MusicServicePackage.InsertAlbum('Dark Side of the Moon');
    MusicServicePackage.InsertAlbum('Hotel California');
    MusicServicePackage.InsertAlbum('Thriller');
    MusicServicePackage.InsertAlbum('A Night at the Opera');
    MusicServicePackage.InsertAlbum('Rumours');
    MusicServicePackage.InsertAlbum('The Joshua Tree');
    MusicServicePackage.InsertAlbum('Achtung Baby');
    MusicServicePackage.InsertAlbum('The Wall');
    MusicServicePackage.InsertAlbum('Back in Black');
END;
/

BEGIN
    MusicServicePackage.InsertSong('Shape of You', 'English', 'Pop', 1);
    MusicServicePackage.InsertSong('See You Again', 'English', 'Pop', 2);
    MusicServicePackage.InsertSong('Uptown Funk', 'English', 'Funk', 3);
    MusicServicePackage.InsertSong('Rockstar', 'English', 'Rock', 4);
    MusicServicePackage.InsertSong('Closer', 'English', 'Electronic', 5);
    MusicServicePackage.InsertSong('Dance Monkey', 'English', 'Pop', 6);
    MusicServicePackage.InsertSong('Faded', 'English', 'Electronic', 7);
    MusicServicePackage.InsertSong('One Dance', 'English', 'Pop', 8);
    MusicServicePackage.InsertSong('Sunflower', 'English', 'Pop', 9);
    MusicServicePackage.InsertSong('Senorita', 'English', 'Pop', 10);
    MusicServicePackage.InsertSong('Blinding Lights', 'English', 'Pop', 1);
    MusicServicePackage.InsertSong('Watermelon Sugar', 'English', 'Pop', 2);
    MusicServicePackage.InsertSong('Someone You Loved', 'English', 'Pop', 3);
    MusicServicePackage.InsertSong('Sicko Mode', 'English', 'Hip Hop', 4);
    MusicServicePackage.InsertSong('Bad Guy', 'English', 'Pop', 5);
    MusicServicePackage.InsertSong('Old Town Road', 'English', 'Country', 6);
    MusicServicePackage.InsertSong('Believer', 'English', 'Pop', 7);
    MusicServicePackage.InsertSong('Shape of You', 'English', 'Pop', 8);
    MusicServicePackage.InsertSong('Havana', 'English', 'Pop', 9);
    MusicServicePackage.InsertSong('Dynamite', 'English', 'Pop', 10);
END;
/

BEGIN
    MusicServicePackage.InsertPlaylist('My Favorites', 1, 1);
    MusicServicePackage.InsertPlaylist('Morning Vibes', 2, 2);
    MusicServicePackage.InsertPlaylist('Workout Hits', 3, 3);
    MusicServicePackage.InsertPlaylist('Chill Beats', 4, 4);
    MusicServicePackage.InsertPlaylist('Party Mix', 5, 5);
    MusicServicePackage.InsertPlaylist('Rock Classics', 6, 6);
    MusicServicePackage.InsertPlaylist('Jazz Essentials', 7, 7);
    MusicServicePackage.InsertPlaylist('Hip Hop Hits', 8, 8);
    MusicServicePackage.InsertPlaylist('Country Roads', 9, 9);
    MusicServicePackage.InsertPlaylist('Pop Stars', 10, 10);
    MusicServicePackage.InsertPlaylist('RandB Soul', 11, 11);
    MusicServicePackage.InsertPlaylist('Indie Vibes', 12, 12);
    MusicServicePackage.InsertPlaylist('Electronic Beats', 13, 13);
    MusicServicePackage.InsertPlaylist('Acoustic Serenity', 14, 14);
    MusicServicePackage.InsertPlaylist('Latin Grooves', 15, 15);
    MusicServicePackage.InsertPlaylist('Classical Masterpieces', 16, 16);
    MusicServicePackage.InsertPlaylist('Reggae Rhythms', 17, 17);
    MusicServicePackage.InsertPlaylist('Metal Mayhem', 18, 18);
    MusicServicePackage.InsertPlaylist('K-Pop Craze', 19, 19);
    MusicServicePackage.InsertPlaylist('Throwback Hits', 20, 20);
END;
/


BEGIN
    MusicServicePackage.InsertDownloadedSong(1, 1);
    MusicServicePackage.InsertDownloadedSong(2, 2);
    MusicServicePackage.InsertDownloadedSong(3, 3);
    MusicServicePackage.InsertDownloadedSong(4, 4);
    MusicServicePackage.InsertDownloadedSong(5, 5);
    MusicServicePackage.InsertDownloadedSong(6, 6);
    MusicServicePackage.InsertDownloadedSong(7, 7);
    MusicServicePackage.InsertDownloadedSong(8, 8);
    MusicServicePackage.InsertDownloadedSong(9, 9);
    MusicServicePackage.InsertDownloadedSong(10, 10);
    MusicServicePackage.InsertDownloadedSong(11, 11);
    MusicServicePackage.InsertDownloadedSong(12, 12);
    MusicServicePackage.InsertDownloadedSong(13, 13);
    MusicServicePackage.InsertDownloadedSong(14, 14);
    MusicServicePackage.InsertDownloadedSong(15, 15);
    MusicServicePackage.InsertDownloadedSong(16, 16);
    MusicServicePackage.InsertDownloadedSong(17, 17);
    MusicServicePackage.InsertDownloadedSong(18, 18);
    MusicServicePackage.InsertDownloadedSong(19, 19);
    MusicServicePackage.InsertDownloadedSong(20, 20);
END;
/


BEGIN
    MusicServicePackage.InsertHistory(1, 1, TO_DATE('2023-11-24', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(2, 2, TO_DATE('2023-11-23', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(3, 3, TO_DATE('2023-11-22', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(4, 4, TO_DATE('2023-11-21', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(5, 5, TO_DATE('2023-11-20', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(6, 6, TO_DATE('2023-11-19', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(7, 7, TO_DATE('2023-11-18', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(8, 8, TO_DATE('2023-11-17', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(9, 9, TO_DATE('2023-11-16', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(10, 10, TO_DATE('2023-11-15', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(11, 11, TO_DATE('2023-11-14', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(12, 12, TO_DATE('2023-11-13', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(13, 13, TO_DATE('2023-11-12', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(14, 14, TO_DATE('2023-11-11', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(15, 15, TO_DATE('2023-11-10', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(16, 16, TO_DATE('2023-11-09', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(17, 17, TO_DATE('2023-11-08', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(18, 18, TO_DATE('2023-11-07', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(19, 19, TO_DATE('2023-11-06', 'YYYY-MM-DD'));
    MusicServicePackage.InsertHistory(20, 20, TO_DATE('2023-11-05', 'YYYY-MM-DD'));
END;
/
