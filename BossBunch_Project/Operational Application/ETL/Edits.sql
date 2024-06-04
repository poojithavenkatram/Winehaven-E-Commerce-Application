-- CREATE TABLE Wishlist (
--     WishlistID INT PRIMARY KEY AUTO_INCREMENT,
--     CustomerID INT NOT NULL,
--     WineID VARCHAR(25) NOT NULL,
--     AddedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     CONSTRAINT fk_wishlist_customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
--     CONSTRAINT fk_wishlist_wine FOREIGN KEY (WineID) REFERENCES Wine(WineID)
-- );

-- CREATE TABLE Cart (
--     CartID INT PRIMARY KEY AUTO_INCREMENT,
--     CustomerID INT NOT NULL,
--     WineID VARCHAR(25) NOT NULL,
--     Quantity INT NOT NULL,
--     CONSTRAINT fk_cart_customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
--     CONSTRAINT fk_cart_wine FOREIGN KEY (WineID) REFERENCES Wine(WineID)
-- );

-- CREATE TABLE Inventory (
--     InventoryID INT PRIMARY KEY AUTO_INCREMENT,
--     WineID VARCHAR(25) NOT NULL,
--     Stock INT NOT NULL,
--     CONSTRAINT fk_wine_inventory FOREIGN KEY (WineID) REFERENCES Wine(WineID)
-- );

-- INSERT INTO Inventory (WineID, Stock)
-- VALUES ('WINE001', FLOOR(RAND()*(100-10+1))+10),
--        ('WINE002', FLOOR(RAND()*(100-10+1))+10),
--        ('WINE003', FLOOR(RAND()*(100-10+1))+10),
--        ('WINE004', FLOOR(RAND()*(100-10+1))+10),
--        ('WINE005', FLOOR(RAND()*(100-10+1))+10),
--        ('WINE006', FLOOR(RAND()*(100-10+1))+10),
--        ('WINE007', FLOOR(RAND()*(100-10+1))+10),
--        ('WINE008', FLOOR(RAND()*(100-10+1))+10),
--        ('WINE009', FLOOR(RAND()*(100-10+1))+10),
--        ('WINE010', FLOOR(RAND()*(100-10+1))+10);

-- ALTER TABLE Users
-- ADD SecurityQuestion VARCHAR(255) NOT NULL,
-- ADD SecurityAnswer VARCHAR(255) NOT NULL;

-- UPDATE Users
-- SET SecurityQuestion = CASE CustomerID
--     WHEN 1001 THEN 'What is your favorite color?'
--     WHEN 1002 THEN 'What was the name of your first pet?'
--     WHEN 1003 THEN 'What is your mother\'s maiden name?'
--     WHEN 1004 THEN 'What city were you born in?'
--     WHEN 1005 THEN 'What is your favorite movie?'
--     WHEN 1006 THEN 'What is your favorite food?'
--     WHEN 1007 THEN 'What is your favorite book?'
--     WHEN 1008 THEN 'What is your favorite hobby?'
--     WHEN 1009 THEN 'What is your favorite animal?'
--     WHEN 1010 THEN 'What is your favorite place to travel?'
--     END,
--     SecurityAnswer = CASE CustomerID
--     WHEN 1001 THEN 'Blue'
--     WHEN 1002 THEN 'Fluffy'
--     WHEN 1003 THEN 'Smith'
--     WHEN 1004 THEN 'New York'
--     WHEN 1005 THEN 'The Shawshank Redemption'
--     WHEN 1006 THEN 'Pizza'
--     WHEN 1007 THEN 'To Kill a Mockingbird'
--     WHEN 1008 THEN 'Hiking'
--     WHEN 1009 THEN 'Eagle'
--     WHEN 1010 THEN 'Hawaii'
--     END
-- WHERE CustomerID IN (1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010);


-- SELECT Wine.WineName, Wine.Description, Wine.Vintage, 
--        WineType.WineType AS WineColour, gv.Variety AS GrapeVariety, Wine.WineID
-- FROM Wine, WineType, GrapeVariety AS gv
-- WHERE Wine.WineTypeID = WineType.WineTypeID 
-- AND Wine.VarietyID = gv.VarietyID 
-- GROUP BY Wine.WineID;

-- ALTER TABLE Customer
-- DROP COLUMN MiddleName;

-- UPDATE Customer
-- SET State = 
--   CASE State
--     WHEN 'CA' THEN 'California'
--     WHEN 'IL' THEN 'Illinois'
--     WHEN 'TX' THEN 'Texas'
--     WHEN 'NY' THEN 'New York'
--     WHEN 'GA' THEN 'Georgia'
--     WHEN 'MA' THEN 'Massachusetts'
--     ELSE State
--   END
-- WHERE CustomerID > 0;

-- ALTER TABLE Customer
-- ADD COLUMN Email VARCHAR(50),
-- ADD COLUMN Street VARCHAR(100);

-- ALTER TABLE Customer
-- MODIFY COLUMN FirstName VARCHAR(50) AFTER CustomerID,
-- MODIFY COLUMN LastName VARCHAR(50) AFTER FirstName,
-- MODIFY COLUMN BirthDate DATE AFTER LastName,
-- MODIFY COLUMN Age INT AFTER BirthDate,
-- MODIFY COLUMN CountryCode VARCHAR(25) AFTER Age,
-- MODIFY COLUMN State VARCHAR(20) AFTER CountryCode,
-- MODIFY COLUMN City VARCHAR(50) AFTER State,
-- MODIFY COLUMN Street VARCHAR(100) AFTER City,
-- MODIFY COLUMN ZipCode VARCHAR(10) AFTER Street,
-- MODIFY COLUMN Email VARCHAR(50) AFTER ZipCode;

-- UPDATE Customer
-- SET Email = CONCAT(LOWER(FirstName), '.', LOWER(LastName), '@example.com')
-- WHERE CustomerID IN (1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010);

-- UPDATE Customer
-- SET 
--   Street = CASE 
--             WHEN CustomerID = 1001 THEN '123 Main St.'
--             WHEN CustomerID = 1002 THEN '456 Elm St.'
--             WHEN CustomerID = 1003 THEN '789 Oak St.'
--             WHEN CustomerID = 1004 THEN '321 Maple St.'
--             WHEN CustomerID = 1005 THEN '654 Pine St.'
--             WHEN CustomerID = 1006 THEN '987 Cedar St.'
--             WHEN CustomerID = 1007 THEN '654 Birch St.'
--             WHEN CustomerID = 1008 THEN '321 Spruce St.'
--             WHEN CustomerID = 1009 THEN '789 Hickory St.'
--             WHEN CustomerID = 1010 THEN '246 Juniper St.'
--           END,
--   ZipCode = CASE 
--               WHEN CustomerID IN (1001, 1005, 1010) THEN '90001'
--               WHEN CustomerID IN (1002, 1009) THEN '60601'
--               WHEN CustomerID = 1003 THEN '75001'
--               WHEN CustomerID = 1004 THEN '10001'
--               WHEN CustomerID = 1006 THEN '30301'
--               WHEN CustomerID = 1007 THEN '75201'
--               WHEN CustomerID = 1008 THEN '02101'
--             END
-- WHERE CustomerID IN (1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010);

-- UPDATE Customer
-- SET State = 
--   CASE CountryCode 
--     WHEN 'US' THEN 'California'
--     WHEN 'RU' THEN 'Moscow'
--     WHEN 'IN' THEN 'Delhi'
--     WHEN 'UK' THEN 'London'
--     WHEN 'GE' THEN 'Berlin'
--     WHEN 'PR' THEN 'San Juan'
--     WHEN 'IT' THEN 'Rome'
--     WHEN 'SW' THEN 'Stockholm'
--     WHEN 'FR' THEN 'Paris'
--   END
-- WHERE CustomerID IN (1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010);

-- UPDATE Customer
-- SET
--   City =
--     CASE 
--       WHEN State = 'California' THEN 'Los Angeles'
--       WHEN State = 'Illinois' THEN 'Chicago'
--       WHEN State = 'Texas' THEN 'Houston'
--       WHEN State = 'New York' THEN 'New York City'
--       WHEN State = 'Georgia' THEN 'Atlanta'
--       WHEN State = 'Moscow' THEN 'Moscow'
--       WHEN State = 'Delhi' THEN 'New Delhi'
--       WHEN State = 'London' THEN 'London'
--       WHEN State = 'Berlin' THEN 'Berlin'
--       WHEN State = 'San Juan' THEN 'San Juan'
--       WHEN State = 'Rome' THEN 'Rome'
--       WHEN State = 'Stockholm' THEN 'Stockholm'
--       WHEN State = 'Paris' THEN 'Paris'
--     END
-- WHERE CustomerID IN (1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010);

-- ALTER TABLE Wine ADD Price DECIMAL(10, 2);

-- This query uses the RAND() function in MySQL to generate a random number between 0 and 1, 
-- which is then multiplied by the range of prices (1000-200+1) and added to the minimum price (200) 
-- to get a random price in the range of 200-1000 dollars. The FLOOR() function is used to round down 
-- the price to the nearest integer. The WHERE clause is used to specify which WineID the price should be inserted for.

-- UPDATE Wine SET Price = FLOOR(RAND()*(1000-200+1)+200) WHERE WineID = 'WINE001';
-- UPDATE Wine SET Price = FLOOR(RAND()*(1000-200+1)+200) WHERE WineID = 'WINE002';
-- UPDATE Wine SET Price = FLOOR(RAND()*(1000-200+1)+200) WHERE WineID = 'WINE003';
-- UPDATE Wine SET Price = FLOOR(RAND()*(1000-200+1)+200) WHERE WineID = 'WINE004';
-- UPDATE Wine SET Price = FLOOR(RAND()*(1000-200+1)+200) WHERE WineID = 'WINE005';
-- UPDATE Wine SET Price = FLOOR(RAND()*(1000-200+1)+200) WHERE WineID = 'WINE006';
-- UPDATE Wine SET Price = FLOOR(RAND()*(1000-200+1)+200) WHERE WineID = 'WINE007';
-- UPDATE Wine SET Price = FLOOR(RAND()*(1000-200+1)+200) WHERE WineID = 'WINE008';
-- UPDATE Wine SET Price = FLOOR(RAND()*(1000-200+1)+200) WHERE WineID = 'WINE009';
-- UPDATE Wine SET Price = FLOOR(RAND()*(1000-200+1)+200) WHERE WineID = 'WINE010';

-- Deleted after testing
-- DELETE FROM Customer_Phone
-- WHERE CustomerID = 1012;

-- UPDATE Wine
-- SET ImageURL = 'https://i.pinimg.com/564x/b6/3a/b6/b63ab635edc162ef104c4d41533e120b.jpg'
-- WHERE WineID = 'WINE001';

-- UPDATE Wine
-- SET ImageURL = 'https://images.rawpixel.com/image_png_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjExMDEtZS04Mi5wbmc.png'
-- WHERE WineID = 'WINE002';

-- UPDATE Wine
-- SET ImageURL = 'https://i.pinimg.com/564x/5e/99/d9/5e99d9feb937167b756ec1f5293f97f5.jpg'
-- WHERE WineID = 'WINE003';

-- UPDATE Wine
-- SET ImageURL = 'https://i.pinimg.com/564x/15/bd/3f/15bd3f854f41a9be8f96c01ea79c36e5.jpg'
-- WHERE WineID = 'WINE004';

-- UPDATE Wine
-- SET ImageURL = 'https://i.pinimg.com/564x/ce/75/23/ce75236d958f6a707c100d53896b7717.jpg'
-- WHERE WineID IN ('WINE005', 'WINE007');

-- UPDATE Wine
-- SET ImageURL = 'https://images.rawpixel.com/image_png_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvcm00NDItMDYtMDEtbW9ja3VwLnBuZw.png'
-- WHERE WineID = 'WINE006';

-- UPDATE Wine
-- SET ImageURL = 'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTEyL3JtNDQyLTA2LTA0YS1tb2NrdXAtam9iMTQwNC5qcGc.jpg'
-- WHERE WineID = 'WINE008';

-- UPDATE Wine
-- SET ImageURL = 'https://images.rawpixel.com/image_png_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvcGYtaWNvbi0yOTQ0LWNoaW0tbC1rYXJuLWpvYjEwOC5wbmc.png'
-- WHERE WineID = 'WINE009';

-- UPDATE Wine
-- SET ImageURL = 'https://images.rawpixel.com/image_png_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjEwNjUtMDA2XzEucG5n.png'
-- WHERE WineID = 'WINE010';


-- WINERIES UPDATE
-- WINERY01 - Barefoot Wineyards
-- WINERY02 - Chateau d'Esclans
-- WINERY03 - Caymus Wineyards
-- WINERY04 - Bogle Wine
-- WINERY05 - Apothic

-- INSERT INTO GrapeVariety (VarietyID, Variety)
-- VALUES ('V11', 'Mixed Grape Blend');

-- INSERT INTO WineType (WineTypeID, WineType)
-- VALUES ('WT007', 'Mix of Wines');

-- UPDATE Winery
-- SET WineryName = 'Barefoot Wineyards'
-- WHERE WineryID = 'WINERY01';

-- UPDATE Winery
-- SET WineryName = 'Chateau d''Esclans'
-- WHERE WineryID = 'WINERY02';

-- UPDATE Winery
-- SET WineryName = 'Caymus Wineyards'
-- WHERE WineryID = 'WINERY03';

-- UPDATE Winery
-- SET WineryName = 'Bogle Wine'
-- WHERE WineryID = 'WINERY04';

-- UPDATE Winery
-- SET WineryName = 'Apothic'
-- WHERE WineryID = 'WINERY05';

-- ALTER TABLE Wine
-- ADD ABV DECIMAL(4,2);

-- UPDATE Wine
-- SET WineName = 'Barefoot Pinot Grigio',
--     Vintage = 2020,
--     Description = 'Barefoot Pinot Grigio is a refreshing and zesty white wine that will transport your taste buds to a sunny afternoon in California. This light-bodied wine features flavors of crisp green apple and citrus, with a tart and refreshing finish that is perfect for a warm day.',
--     WineTypeID = 'WT001',
--     WineryID = 'WINERY01',
--     VarietyID = 'V09',
--     ABV = 12.50,
--     ImageURL = 'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/barefoot_pinot_grigio_2_2_900x.jpg?v=1603743968'
-- WHERE WineID = 'WINE001';

-- UPDATE Wine
-- SET WineName = 'Caymus Cabernet Sauvignon', 
--     Vintage = 2005, 
--     Description = 'From the first pour, you will be greeted with a beautiful deep, rich red color that promises to be an experience for the senses. The nose offers a complex bouquet of dark fruits, with blackberry, cassis, and black cherry intermingling with subtle hints of vanilla and mocha.',
--     WineTypeID = 'WT004',
--     WineryID = 'WINERY02',
--     VarietyID = 'V04',
--     ABV = 14.60,
--     ImageURL = 'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/CaymusCabernetSauvignon2020b_900x.jpg?v=1682785999'
-- WHERE WineID = 'WINE002';


-- UPDATE Wine
-- SET 
--     WineName = 'Chateau d''Esclans Whispering Angel Rose',
--     Vintage = 2020,
--     Description = 'With a reputation for excellence, Chateau d''Esclans Whispering Angel Rose is a wine you can drink from mid-day to midnight. Its pleasing pale color and full, lush taste profile make it an excellent choice for any occasion. Enjoy a glass of this premium rose wine with your favorite foods or on its own, and experience the exquisite taste that has made Whispering Angel a worldwide reference for Provence Rose.',
--     WineTypeID = 'WT003',
--     WineryID = 'WINERY03',
--     VarietyID = 'V02',
--     ABV = 13,
--     ImageURL = 'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Chateau_d_Esclans_Whispering_Angel_Rose_2018_Bottle_1_900x.jpg?v=1672849818'
-- WHERE 
--     WineID = 'WINE003';


-- UPDATE Wine
-- SET
-- WineName = 'Barefoot Moscato',
-- Vintage = 2011,
-- Description = 'Barefoot Moscato is a crisp and refreshing white wine that''s perfect for any occasion. This blend boasts the delicious flavors of juicy peaches and ripe apricots, along with hints of citrus and lemon. It has a bright and crisp finish that leaves a lasting impression on your palate. Crafted with care, Barefoot Moscato has a low alcohol content, making it a great choice for light drinking. The wine''s fruity and bright character pairs well with spicy Asian cuisine, artisanal cheeses, and light desserts.',
-- WineTypeID = 'WT001',
-- WineryID = 'WINERY01',
-- VarietyID = 'V05',
-- ABV = 8.50,
-- ImageURL = 'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/barefoot_moscato_2_900x.jpg?v=1603744478'
-- WHERE WineID = 'WINE004'

-- UPDATE Wine
-- SET WineName = 'Bogle Chardonnay',
--     Vintage = 2021,
--     Description = 'Pairing well with grilled fish, roasted chicken, fresh green salads, and soft, mild cheeses, the Bogle Chardonnay 2021 is a versatile wine that is perfect for any occasion. So, whether you are looking to impress your dinner guests or unwind after a long day, this wine is sure to please. Order your bottle today and experience the delightful taste of Bogle Chardonnay 2021 for yourself.',
--     WineTypeID = 'WT001',
--     WineryID = 'WINERY04',
--     VarietyID = 'V01',
--     ABV = 14.50,
--     ImageURL = 'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Bogle_Chardonnay_900x.jpg?v=1678221059'
-- WHERE WineID = 'WINE005';

-- UPDATE Wine
-- SET 
--     WineName = 'Apothic Red Blend',
--     Vintage = 2021,
--     Description = 'Apothic Red Blend Winemaker''s Blend Wine 2021 is a bold and intriguing wine that masterfully blends together rich Zinfandel, smooth Merlot, flavorful Syrah, and Cabernet Sauvignon grapes. The resulting wine is complex, with layers of flavor that tantalize the senses. Notes of black cherry and dark red fruit are complemented by hints of vanilla and mocha, delivering a unique flavor experience.',
--     WineTypeID = 'WT007',
--     WineryID = 'WINERY05',
--     VarietyID = 'V11',
--     ABV = 13.50,
--     ImageURL = 'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Apothic_Red_Blend_Bottle_1_1_900x.jpg?v=1603744755'
-- WHERE 
--     WineID = 'WINE006';

-- UPDATE Wine
-- SET WineName = 'Barefoot White Zinfandel',
--     Vintage = 2020,
--     Description = 'Barefoot White Zinfandel is the perfect balance of fruity flavors, refreshing sweetness, and crisp acidity, making it an ideal choice for any occasion. The wine opens up with sun-kissed strawberry notes, followed by juicy pear, sweet pineapple, and ripe Georgia peach flavors, making for a delightful drinking experience.',
--     WineTypeID = 'WT006',
--     WineryID = 'WINERY02',
--     VarietyID = 'V06',
--     ABV = 9,
--     ImageURL = 'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Barefoot_White_Zinfandel_1_900x.jpg?v=1603744810'
-- WHERE WineID = 'WINE007';

-- UPDATE Wine
-- SET WineName = 'Emmolo Sauvignon Blanc', 
--     Vintage = 2022,
--     Description = 'Emmolo Sauvignon Blanc Napa Valley 2022 isa wine that embodies the spirit of simplicity and balance. From the moment you pour a glass, you are met with fresh aromas of citrus and green apple. On the palate, the wine is dry, crisp, and refreshing, with flavors of grapefruit, lemon, and lime. The bright minerality adds complexity and depth to the wine, while the low alcohol and bright acidity make it an easy-drinking delight.',
--     WineTypeID = 'WT001',
--     WineryID = 'WINERY03',
--     VarietyID = 'V03',
--     ABV = 12.60,
--     ImageURL = 'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/EmmoloSauvignonBlancNapaValley2021b_900x.webp?v=1657551331'
-- WHERE WineID = 'WINE008';

-- UPDATE Wine
-- SET WineName = 'Apothic Inferno Red Blend',
--     Vintage = 2019,
--     Description = 'Apothic Inferno Red Wine Blend 2019 is a unique and bold wine that offers a rich and complex flavor profile. This limited release red blend is aged in whiskey barrels for 60 days, imparting a distinctive smoky flavor that sets it apart from other wines. The palate is smooth and rich, with notes of ripe red and dark fruit, like blackberry and plum, complemented by layers of maple, vanilla, and charred spice. The finish is long and clean, leaving behind a delightful aftertaste that lingers on the tongue.',
--     WineTypeID = 'WT002',
--     WineryID = 'WINERY05',
--     VarietyID = 'V07',
--     ABV = 15.9,
--     ImageURL = 'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Apothic_Inferno_Red_Blend_2017_bottle_1_900x.jpg?v=1605564155'
-- WHERE WineID = 'WINE009';

-- UPDATE Wine
-- SET 
--     WineName = 'Barefoot Merlot',
--     Vintage = 2004,
--     Description = 'Barefoot Merlot is a crowd-pleasing red wine with an approachable style that makes it a perfect choice for any occasion. This classic Merlot is bursting with flavors of juicy plum, cherry, boysenberry, and chocolate, creating a deliciously rich taste experience.',
--     WineTypeID = 'WT002',
--     WineryID = 'WINERY01',
--     VarietyID = 'V05',
--     ABV = 13,
--     ImageURL = 'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Barefoot_Merlot_2_2_900x.jpg?v=1603744905'
-- WHERE 
--     WineID = 'WINE010';

-- INSERT INTO Wine (WineID, WineName, Vintage, Description, WineTypeID, WineryID, VarietyID, ABV, ImageURL, Price)
-- VALUES ('WINE011', 'Bogle Sauvignon Blanc', 2021, 'Experience the refreshing taste of Bogle Sauvignon Blanc 2021, crafted using classic winemaking techniques. On the nose, this wine exudes beautiful aromas of lime, boxwood, and freshly cut grass, providing a refreshing and invigorating experience. The palate is further enriched with delicious flavors of pineapple and passion fruit, culminating in a long, textured finish that leaves a pleasant aftertaste. The grapes are carefully selected and picked a touch early in the ripening season to preserve their crisp and vibrant character. The cold fermentation in stainless steel tanks and reductive winemaking process enhance the wine''s natural acidity, resulting in a mouthwatering sensation on the palate.', 'WT004', 'WINERY05', 'V03', 13, 'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Bogle_Sauvignon_Blanc_2019_bottle_1_900x.jpg?v=1603747705', 419.00);

-- INSERT INTO Wine (WineID, WineName, Vintage, Description, WineTypeID, WineryID, VarietyID, ABV, ImageURL, Price)
-- VALUES ('WINE012', 'Bogle Vineyards Petite Sirah', 2020, 'Bogle Vineyards Petite Sirah 2020 is a rich and luxurious wine that will tantalize your taste buds with its deep purple color and complex aromas. On the nose, you''ll be greeted with the delightful scent of freshly baked berry cobbler, alongside hints of vanilla wafer and anise. On the palate, the wine offers a soft, supple entry that gives way to plush blue fruits, boysenberry, black plum, and nutmeg spice. The ripe, textured tannins are a testament to the wine''s aging process of 12 months in American oak, which has softened them beautifully.', 'WT002', 'WINERY05', 'V08', 13.5, 'https://cdn.shopify.com/s/files/1/0113/3314/0561/products/Bogle_Vineyards_petite_sirah_2017_bottle_2_900x.png?v=1603915727', 399.00);

-- ALTER TABLE Wine
-- MODIFY WineName VARCHAR(200);

-- INSERT INTO Inventory (InventoryID, WineID, Stock) 
-- VALUES 
--     ('11', 'WINE011', 10), 
--     ('12', 'WINE012', 5);

-- UPDATE Wine
-- SET WineName = 'Chateau d Esclans Whispering Angel Rose'
-- WHERE WineID = 'WINE003';

-- UPDATE Wine
-- SET WineryID = 'WINERY04'
-- WHERE WineID IN ('WINE011', 'WINE012');


A-- LTER TABLE reservations ADD COLUMN winery_name VARCHAR(50);








