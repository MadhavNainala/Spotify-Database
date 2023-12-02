BEGIN
  UserInsertPackage.InsertCustomer('Alice', 'alice123', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 'F');
  UserInsertPackage.InsertCustomer('Bob', 'bob123', TO_DATE('1990-08-20', 'YYYY-MM-DD'), 'M');
  UserInsertPackage.InsertCustomer('Charlie', 'charlie123', TO_DATE('1992-03-22', 'YYYY-MM-DD'), 'M');
  UserInsertPackage.InsertCustomer('Diana', 'diana456', TO_DATE('1988-11-05', 'YYYY-MM-DD'), 'F');
  UserInsertPackage.InsertCustomer('Ethan', 'ethan789', TO_DATE('1975-01-15', 'YYYY-MM-DD'), 'M');
  UserInsertPackage.InsertCustomer('Fiona', 'fiona321', TO_DATE('2000-07-21', 'YYYY-MM-DD'), 'F');
  UserInsertPackage.InsertCustomer('George', 'george654', TO_DATE('1983-09-30', 'YYYY-MM-DD'), 'M');
  UserInsertPackage.InsertCustomer('Hannah', 'hannah890', TO_DATE('1995-12-12', 'YYYY-MM-DD'), 'F');
  UserInsertPackage.InsertCustomer('Ian', 'ian123', TO_DATE('1980-04-27', 'YYYY-MM-DD'), 'M');
  UserInsertPackage.InsertCustomer('Julia', 'julia456', TO_DATE('1998-02-08', 'YYYY-MM-DD'), 'F');
END;
/


BEGIN
  UserInsertPackage.InsertBankAccount(123456789, 'Alice Smith', 987654321, 'Checking');
  UserInsertPackage.InsertBankAccount(987654321, 'Bob Johnson', 123456789, 'Savings');
  UserInsertPackage.InsertBankAccount(456789123, 'Carol White', 567891234, 'Checking');
  UserInsertPackage.InsertBankAccount(321987654, 'David Brown', 654321987, 'Savings');
  UserInsertPackage.InsertBankAccount(789123456, 'Eve Martinez', 891234567, 'Checking');
  UserInsertPackage.InsertBankAccount(654789321, 'Frank Wilson', 432198765, 'Savings');
  UserInsertPackage.InsertBankAccount(987321654, 'Grace Lee', 789654123, 'Checking');
  UserInsertPackage.InsertBankAccount(123654789, 'Henry Garcia', 321456987, 'Savings');
  UserInsertPackage.InsertBankAccount(654123987, 'Ivy Hall', 987654321, 'Checking');
END;
/



BEGIN
  UserInsertPackage.InsertCard(1111222233334444, 'Alice', 'Smith', TO_DATE('2025-05', 'YYYY-MM'), 321, '54321');
  UserInsertPackage.InsertCard(4444333322221111, 'Bob', 'Johnson', TO_DATE('2026-06', 'YYYY-MM'), 123, '98765');
  UserInsertPackage.InsertCard(5555666677778888, 'Carol', 'White', TO_DATE('2024-07', 'YYYY-MM'), 456, '67890');
  UserInsertPackage.InsertCard(8888777766665555, 'David', 'Brown', TO_DATE('2027-08', 'YYYY-MM'), 789, '12345');
  UserInsertPackage.InsertCard(2222999988887777, 'Eve', 'Martinez', TO_DATE('2024-09', 'YYYY-MM'), 234, '56789');
  UserInsertPackage.InsertCard(7777888899992222, 'Frank', 'Wilson', TO_DATE('2028-10', 'YYYY-MM'), 567, '23456');
  UserInsertPackage.InsertCard(3333111144449999, 'Grace', 'Lee', TO_DATE('2024-11', 'YYYY-MM'), 890, '34567');
  UserInsertPackage.InsertCard(9999000011113333, 'Henry', 'Garcia', TO_DATE('2029-12', 'YYYY-MM'), 123, '45678');
  UserInsertPackage.InsertCard(6666777788880000, 'Ivy', 'Hall', TO_DATE('2025-01', 'YYYY-MM'), 345, '78901');
  UserInsertPackage.InsertCard(4444555566667777, 'Jack', 'Davis', TO_DATE('2026-02', 'YYYY-MM'), 678, '89012');
END;
/



BEGIN
    AdminInsertPackage.InsertPromocode('NEWYEAR2024', 15, TO_DATE('2024-01-31', 'YYYY-MM-DD'));
    AdminInsertPackage.InsertPromocode('SPRINGSALE', 5, TO_DATE('2023-12-13', 'YYYY-MM-DD'));
    AdminInsertPackage.InsertPromocode('SUMMER2023', 25, TO_DATE('2023-12-31', 'YYYY-MM-DD'));
    AdminInsertPackage.InsertPromocode('FALLFLAT10', 10, TO_DATE('2023-12-30', 'YYYY-MM-DD'));
    AdminInsertPackage.InsertPromocode('HOLIDAY2023', 10, TO_DATE('2023-12-12', 'YYYY-MM-DD'));
    AdminInsertPackage.InsertPromocode('WINTERWARMER', 15, TO_DATE('2023-02-28', 'YYYY-MM-DD'));
    AdminInsertPackage.InsertPromocode('SPRINGBLOOM', 10, TO_DATE('2024-12-15', 'YYYY-MM-DD'));
    AdminInsertPackage.InsertPromocode('SUMMEREND', 20, TO_DATE('2023-09-30', 'YYYY-MM-DD'));
    AdminInsertPackage.InsertPromocode('AUTUMN2023', 10, TO_DATE('2023-12-31', 'YYYY-MM-DD'));
    AdminInsertPackage.InsertPromocode('CYBERMONDAY', 35, TO_DATE('2023-11-27', 'YYYY-MM-DD'));
    AdminInsertPackage.InsertPromocode('JANSAVINGS', 15, TO_DATE('2024-01-31', 'YYYY-MM-DD'));
    AdminInsertPackage.InsertPromocode('LOVE2024', 20, TO_DATE('2024-02-14', 'YYYY-MM-DD'));
    AdminInsertPackage.InsertPromocode('SPRING2024', 5, TO_DATE('2023-12-10', 'YYYY-MM-DD'));
END;
/


BEGIN
    AdminInsertPackage.InsertPaymentMethod('Bank_Account', 1);
    AdminInsertPackage.InsertPaymentMethod('Card', 2);
    AdminInsertPackage.InsertPaymentMethod('Bank_Account', 3);
    AdminInsertPackage.InsertPaymentMethod('Card', 4);
    AdminInsertPackage.InsertPaymentMethod('Bank_Account', 5);
    AdminInsertPackage.InsertPaymentMethod('Card', 6);
    AdminInsertPackage.InsertPaymentMethod('Bank_Account', 7);
    AdminInsertPackage.InsertPaymentMethod('Card', 8);
    AdminInsertPackage.InsertPaymentMethod('Bank_Account', 9);
    AdminInsertPackage.InsertPaymentMethod('Card', 10);
END;
/



BEGIN
    AdminInsertPackage.InsertTransaction(SYSTIMESTAMP, 5, 1,  1, 1);
    AdminInsertPackage.InsertTransaction(SYSTIMESTAMP, 10, 2,  2, 2);
    AdminInsertPackage.InsertTransaction(SYSTIMESTAMP, 20, 3,  NULL, 3);
    AdminInsertPackage.InsertTransaction(SYSTIMESTAMP, 5, 4,  1, 4);
    AdminInsertPackage.InsertTransaction(SYSTIMESTAMP, 12, 5,  4, 5);
    AdminInsertPackage.InsertTransaction(SYSTIMESTAMP, 17, 6,  5, 4);
    AdminInsertPackage.InsertTransaction(SYSTIMESTAMP, 20, 7,  NULL, 4);
    AdminInsertPackage.InsertTransaction(SYSTIMESTAMP, 15, 8,  6, 6);
    AdminInsertPackage.InsertTransaction(SYSTIMESTAMP, 21, 9, 7, 8);
    AdminInsertPackage.InsertTransaction(SYSTIMESTAMP, 18, 10,  8, 9);
    
END;
/    


BEGIN
    AdminInsertPackage.InsertAlbum('Thriller');
    AdminInsertPackage.InsertAlbum('Back in Black');
    AdminInsertPackage.InsertAlbum('The Dark Side of the Moon');
    AdminInsertPackage.InsertAlbum('The Bodyguard');
    AdminInsertPackage.InsertAlbum('Bat Out of Hell');
    AdminInsertPackage.InsertAlbum('Their Greatest Hits');
    AdminInsertPackage.InsertAlbum('Saturday Night Fever');
    AdminInsertPackage.InsertAlbum('Rumours');
END;
/

BEGIN
    AdminInsertPackage.InsertSong('Shape of You', 'English', 'Pop', 1);
    AdminInsertPackage.InsertSong('See You Again', 'English', 'Pop', 2);
    AdminInsertPackage.InsertSong('Uptown Funk', 'English', 'Funk', 3);
    AdminInsertPackage.InsertSong('Rockstar', 'English', 'Rock', 4);
    AdminInsertPackage.InsertSong('Closer', 'English', 'Electronic', 5);
    AdminInsertPackage.InsertSong('Dance Monkey', 'English', 'Pop', 6);
    AdminInsertPackage.InsertSong('Faded', 'English', 'Electronic', 2);
    AdminInsertPackage.InsertSong('One Dance', 'English', 'Pop', 2);
    AdminInsertPackage.InsertSong('Sunflower', 'English', 'Pop', 3);
    AdminInsertPackage.InsertSong('Senorita', 'English', 'Pop', 5);
END;
/

BEGIN
    UserInsertPackage.InsertPlaylist('My Favorites', 1);
    UserInsertPackage.InsertPlaylist('Morning Vibes', 2);
    UserInsertPackage.InsertPlaylist('Workout Hits', 3);
    UserInsertPackage.InsertPlaylist('Chill Beats', 4);
    UserInsertPackage.InsertPlaylist('Party Mix', 2);
    UserInsertPackage.InsertPlaylist('Rock Classics', 3);
    UserInsertPackage.InsertPlaylist('Jazz Essentials', 7);
    UserInsertPackage.InsertPlaylist('Hip Hop Hits', 8);
END;
/

BEGIN
  UserInsertPackage.AddSongToPlaylist(1, 1);
  UserInsertPackage.AddSongToPlaylist(1, 5);
  UserInsertPackage.AddSongToPlaylist(1, 4);
  UserInsertPackage.AddSongToPlaylist(3, 2);
  UserInsertPackage.AddSongToPlaylist(4, 4);
  UserInsertPackage.AddSongToPlaylist(4, 1);
  UserInsertPackage.AddSongToPlaylist(5, 2);
  UserInsertPackage.AddSongToPlaylist(4, 3);
END;
/



BEGIN
    UserInsertPackage.InsertDownloadedSong(1, 1);
    UserInsertPackage.InsertDownloadedSong(2, 2);
    UserInsertPackage.InsertDownloadedSong(3, 2);
    UserInsertPackage.InsertDownloadedSong(4, 2);
    UserInsertPackage.InsertDownloadedSong(5, 6);
    UserInsertPackage.InsertDownloadedSong(6, 6);
    UserInsertPackage.InsertDownloadedSong(7, 5);
    UserInsertPackage.InsertDownloadedSong(8, 3);
    UserInsertPackage.InsertDownloadedSong(9, 4);
END;
/


BEGIN
    UserInsertPackage.InsertHistory(1, 1, TO_DATE('2023-12-02', 'YYYY-MM-DD'));
    UserInsertPackage.InsertHistory(1, 1, TO_DATE('2023-12-02', 'YYYY-MM-DD'));
    UserInsertPackage.InsertHistory(3, 3, TO_DATE('2023-12-12', 'YYYY-MM-DD'));
    UserInsertPackage.InsertHistory(4, 2, TO_DATE('2023-12-18', 'YYYY-MM-DD'));
    UserInsertPackage.InsertHistory(5, 4, TO_DATE('2023-12-25', 'YYYY-MM-DD'));
    UserInsertPackage.InsertHistory(6, 6, TO_DATE('2023-12-14', 'YYYY-MM-DD'));
    UserInsertPackage.InsertHistory(4, 5, TO_DATE('2023-12-21', 'YYYY-MM-DD'));
    UserInsertPackage.InsertHistory(8, 9, TO_DATE('2023-12-03', 'YYYY-MM-DD'));
END;
/




