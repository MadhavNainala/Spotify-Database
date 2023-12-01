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
END;
/



BEGIN
  MusicServicePackage.InsertPaymentMethod('Card', 1);
  MusicServicePackage.InsertPaymentMethod('Bank_Account', 2);
  MusicServicePackage.InsertPaymentMethod('Card', 3);
  MusicServicePackage.InsertPaymentMethod('Bank_Account', 4);
  MusicServicePackage.InsertPaymentMethod('Card', 5);
  MusicServicePackage.InsertPaymentMethod('Bank_Account', 6);
  MusicServicePackage.InsertPaymentMethod('Card', 7);
  MusicServicePackage.InsertPaymentMethod('Bank_Account', 8);
  MusicServicePackage.InsertPaymentMethod('Card', 9);
  MusicServicePackage.InsertPaymentMethod('Bank_Account', 10);
END;
/

BEGIN
  MusicServicePackage.InsertPromocode('SAVE10', 10, TO_DATE('2023-12-31', 'YYYY-MM-DD'));
  MusicServicePackage.InsertPromocode('WELCOME20', 20, TO_DATE('2024-01-31', 'YYYY-MM-DD'));
  MusicServicePackage.InsertPromocode('HAPPY15', 15, TO_DATE('2024-05-15', 'YYYY-MM-DD'));
  MusicServicePackage.InsertPromocode('SUMMER25', 25, TO_DATE('2024-07-01', 'YYYY-MM-DD'));
  MusicServicePackage.InsertPromocode('FALL30', 30, TO_DATE('2024-10-31', 'YYYY-MM-DD'));
  MusicServicePackage.InsertPromocode('WINTER35', 35, TO_DATE('2024-12-01', 'YYYY-MM-DD'));
  MusicServicePackage.InsertPromocode('SPRING20', 20, TO_DATE('2024-03-20', 'YYYY-MM-DD'));
  MusicServicePackage.InsertPromocode('NEWYEAR40', 40, TO_DATE('2024-01-01', 'YYYY-MM-DD'));
  MusicServicePackage.InsertPromocode('MUSIC10', 10, TO_DATE('2024-06-30', 'YYYY-MM-DD'));
  MusicServicePackage.InsertPromocode('DISCOUNT50', 50, TO_DATE('2024-11-15', 'YYYY-MM-DD'));
END;
/



BEGIN
  MusicServicePackage.InsertTransaction(CURRENT_TIMESTAMP, 11.99, 1, 'Y', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-02-01', 'YYYY-MM-DD'), 1);
  MusicServicePackage.InsertTransaction(CURRENT_TIMESTAMP, 10.99, 2, 'N', TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2023-04-01', 'YYYY-MM-DD'), 1);
  MusicServicePackage.InsertTransaction(CURRENT_TIMESTAMP, 15.99, 3, 'Y', TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2023-06-01', 'YYYY-MM-DD'), 2);
  MusicServicePackage.InsertTransaction(CURRENT_TIMESTAMP, 10.99, 4, 'N', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-08-01', 'YYYY-MM-DD'), 2);
  MusicServicePackage.InsertTransaction(CURRENT_TIMESTAMP, 10, 5, 'Y', TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2024-10-01', 'YYYY-MM-DD'), 3);
END;
/


BEGIN
  MusicServicePackage.InsertAlbum('Greatest Hits');
  MusicServicePackage.InsertAlbum('Summer Vibes');
  MusicServicePackage.InsertAlbum('Winter Melodies');
  MusicServicePackage.InsertAlbum('Rock Legends');
  MusicServicePackage.InsertAlbum('Classical Masterpieces');
  MusicServicePackage.InsertAlbum('Electronic Beats');
  MusicServicePackage.InsertAlbum('Jazz Classics');
  MusicServicePackage.InsertAlbum('Hip Hop Hits');
  MusicServicePackage.InsertAlbum('Country Roads');
  MusicServicePackage.InsertAlbum('Indie Favorites');
END;
/

BEGIN
  MusicServicePackage.InsertSong('Lovely Day', 'English', 'Pop', 1);
  MusicServicePackage.InsertSong('Good Morning', 'English', 'Jazz', 2);
  MusicServicePackage.InsertSong('Night Sky', 'English', 'Rock', 3);
  MusicServicePackage.InsertSong('Sunny Afternoon', 'Spanish', 'Latin', 4);
  MusicServicePackage.InsertSong('Rainy Mood', 'French', 'Blues', 5);
  MusicServicePackage.InsertSong('City Lights', 'German', 'Electronic', 6);
  MusicServicePackage.InsertSong('Mountain Breeze', 'Italian', 'Classical', 7);
  MusicServicePackage.InsertSong('Desert Road', 'Japanese', 'Ambient', 8);
  MusicServicePackage.InsertSong('Forest Whisper', 'Russian', 'Folk', 10);
END;
/

BEGIN
  MusicServicePackage.InsertPlaylist('Morning Playlist', 1, 1);
  MusicServicePackage.InsertPlaylist('Evening Tunes', 2, 2);
  MusicServicePackage.InsertPlaylist('Workout Energy', 3, 3);
  MusicServicePackage.InsertPlaylist('Relaxing Vibes', 4, 4);
  MusicServicePackage.InsertPlaylist('Party Mix', 5, 5);
  MusicServicePackage.InsertPlaylist('Classical Moods', 6, 6);
  MusicServicePackage.InsertPlaylist('Jazz Nights', 7, 7);
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
END;
/

BEGIN
  MusicServicePackage.InsertHistory(1, 1, TO_DATE('2023-01-01', 'YYYY-MM-DD'));
  MusicServicePackage.InsertHistory(2, 2, TO_DATE('2023-01-02', 'YYYY-MM-DD'));
  MusicServicePackage.InsertHistory(3, 3, TO_DATE('2023-01-03', 'YYYY-MM-DD'));
  MusicServicePackage.InsertHistory(4, 4, TO_DATE('2023-01-04', 'YYYY-MM-DD'));
  MusicServicePackage.InsertHistory(5, 5, TO_DATE('2023-01-05', 'YYYY-MM-DD'));
  MusicServicePackage.InsertHistory(6, 6, TO_DATE('2023-01-06', 'YYYY-MM-DD'));
  MusicServicePackage.InsertHistory(7, 7, TO_DATE('2023-01-07', 'YYYY-MM-DD'));
  MusicServicePackage.InsertHistory(8, 8, TO_DATE('2023-01-08', 'YYYY-MM-DD'));
  MusicServicePackage.InsertHistory(9, 9, TO_DATE('2023-01-09', 'YYYY-MM-DD'));
END;
/

