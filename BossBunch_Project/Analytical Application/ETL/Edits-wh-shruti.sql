-- CREATE TABLE Admin (
--   Username VARCHAR(255) NOT NULL,
--   Password VARCHAR(255) NOT NULL,
--   SecurityQuestion VARCHAR(255) NOT NULL,
--   SecurityAnswer VARCHAR(255) NOT NULL,
--   EmpID INT NOT NULL,
--   PRIMARY KEY (Username)
-- );

-- ALTER TABLE Admin
-- MODIFY EmpID VARCHAR(10);

-- INSERT INTO Admin (Username, Password, SecurityQuestion, SecurityAnswer, EmpID) 
-- VALUES 
-- ('admin1', 'password1', 'What is your favorite color?', 'blue', 'EMP01'),
-- ('admin2', 'password2', 'What is your pet\'s name?', 'fluffy', 'EMP02'),
-- ('admin3', 'password3', 'What is your mother\'s maiden name?', 'Smith', 'EMP03'),
-- ('admin4', 'password4', 'What is the name of the street you grew up on?', 'Maple', 'EMP04'),
-- ('admin5', 'password5', 'What is your favorite food?', 'pizza', 'EMP05'),
-- ('admin6', 'password6', 'What is your favorite hobby?', 'reading', 'EMP06'),
-- ('admin7', 'password7', 'What is your favorite animal?', 'cat', 'EMP07'),
-- ('admin8', 'password8', 'What is your favorite movie?', 'Star Wars', 'EMP08'),
-- ('admin9', 'password9', 'What is your favorite song?', 'Bohemian Rhapsody', 'EMP09'),
-- ('admin10', 'password10', 'What is your favorite book?', 'To Kill a Mockingbird', 'EMP10');

-- Remove existing primary key constraint
-- ALTER TABLE MarketingEvent DROP EventKey;

-- Add new primary key constraint
-- ALTER TABLE MarketingEvent
-- ADD COLUMN EventKey INT AUTO_INCREMENT PRIMARY KEY FIRST;

-- ALTER TABLE MarketingEvent
-- MODIFY COLUMN Quarter VARCHAR(2);

-- ALTER TABLE Employee
-- MODIFY COLUMN EmployeeID VARCHAR(10);

-- ALTER TABLE Employee
-- MODIFY COLUMN EmployeePhone VARCHAR(20);

-- INSERT INTO Employee (EmployeeKey, EmployeeID, EmployeeName, EmployeeRating, EmployeePhone)
-- VALUES
--     (1, 'EMP01', 'John Smith', 4.5, '+1 (212) 555-1234'),
--     (2, 'EMP02', 'Jane Doe', 4.2, '+1 (213) 555-5678'),
--     (3, 'EMP03', 'Mike Johnson', 3.8, '+1 (310) 555-9012'),
--     (4, 'EMP04', 'Sarah Lee', 4.7, '+1 (415) 555-3456'),
--     (5, 'EMP05', 'David Kim', 3.9, '+1 (312) 555-7890'),
--     (6, 'EMP06', 'Karen Chen', 4.1, '+1 (650) 555-2345'),
--     (7, 'EMP07', 'Mark Davis', 4.4, '+1 (202) 555-6789'),
--     (8, 'EMP08', 'Emily Brown', 3.7, '+1 (617) 555-0123'),
--     (9, 'EMP09', 'Kevin Park', 4.0, '+1 (347) 555-4567'),
--     (10, 'EMP10', 'Grace Kim', 4.3, '+1 (305) 555-8901');

-- CREATE TABLE RevenuePerEvent (
--   Revenue DECIMAL(10,2),
--   EventKey INT,
--   EmployeeKey INT,
--   CONSTRAINT fk_EventKey FOREIGN KEY (EventKey) REFERENCES MarketingEvent(EventKey),
--   CONSTRAINT fk_EmployeeKey FOREIGN KEY (EmployeeKey) REFERENCES Employee(EmployeeKey)
-- );

-- INSERT INTO MarketingEvent (EventKey, EventName, Date, Year, Quarter, Attendees, RSVPs, FreeTastings)
-- VALUES
--     (1, 'Wine Wonderland', '2018-03-10', 2018, 'Q1', 200, 180, 50),
--     (2, 'Grape Escape', '2018-06-15', 2018, 'Q2', 150, 130, 30),
--     (3, 'Bottles & Bites', '2018-09-22', 2018, 'Q3', 100, 90, 20),
--     (4, 'Harvest Fest', '2018-11-17', 2018, 'Q4', 180, 160, 40),
--     (5, 'Wine Wonderland', '2019-03-09', 2019, 'Q1', 220, 200, 60),
--     (6, 'Grape Escape', '2019-06-14', 2019, 'Q2', 170, 150, 35),
--     (7, 'Bottles & Bites', '2019-09-21', 2019, 'Q3', 120, 100, 25),
--     (8, 'Harvest Fest', '2019-11-16', 2019, 'Q4', 200, 180, 50),
--     (9, 'Wine Wonderland', '2020-03-14', 2020, 'Q1', 180, 160, 40),
--     (10, 'Grape Escape', '2020-06-19', 2020, 'Q2', 130, 110, 30),
--     (11, 'Bottles & Bites', '2020-09-26', 2020, 'Q3', 90, 70, 15),
--     (12, 'Harvest Fest', '2020-11-21', 2020, 'Q4', 170, 150, 35),
--     (13, 'Wine Wonderland', '2021-03-13', 2021, 'Q1', 240, 220, 70),
--     (14, 'Grape Escape', '2021-06-18', 2021, 'Q2', 180, 160, 40),
--     (15, 'Bottles & Bites', '2021-09-25', 2021, 'Q3', 130, 110, 30),
--     (16, 'Harvest Fest', '2021-11-20', 2021, 'Q4', 200, 180, 50),
--     (17, 'Wine Wonderland', '2022-03-12', 2022, 'Q1', 200, 180, 50),
--     (18, 'Grape Escape', '2022-06-17', 2022, 'Q2', 150, 130, 30),
--     (19, 'Bottles & Bites', '2022-09-24', 2022, 'Q3', 100, 90, 20),
--     (20, 'Harvest Fest', '2022-11-19', 2022, 'Q4', 180, 160, 40),
-- 	(21, 'Wine Wonderland', '2023-03-11', 2023, 'Q1', 220, 200, 60),
-- 	(22, 'Grape Escape', '2023-06-16', 2023, 'Q2', 170, 150, 35),
-- 	(23, 'Bottles & Bites', '2023-09-23', 2023, 'Q3', 120, 100, 25),
-- 	(24, 'Harvest Fest', '2023-11-18', 2023, 'Q4', 200, 180, 50),
-- 	(25, 'Wine & Dine', '2018-04-14', 2018, 'Q2', 100, 90, 20),
-- 	(26, 'Vino Fiesta', '2018-07-21', 2018, 'Q3', 150, 130, 30),
-- 	(27, 'Sip & Savor', '2018-10-27', 2018, 'Q4', 200, 180, 50),
-- 	(28, 'Wine & Dine', '2019-04-13', 2019, 'Q2', 120, 100, 25),
-- 	(29, 'Vino Fiesta', '2019-07-20', 2019, 'Q3', 170, 150, 35),
-- 	(30, 'Sip & Savor', '2019-10-26', 2019, 'Q4', 220, 200, 60);

-- INSERT INTO RevenuePerEvent (EventKey, EmployeeKey, Revenue)
-- VALUES
--     (1, 1, 40000.00),
--     (2, 2, 25000.00),
--     (3, 3, 15000.00),
--     (4, 4, 35000.00),
--     (5, 1, 45000.00),
--     (6, 2, 28000.00),
--     (7, 3, 18000.00),
--     (8, 4, 40000.00),
--     (9, 1, 42000.00),
--     (10, 2, 27000.00),
--     (11, 3, 16000.00),
--     (12, 4, 32000.00),
--     (13, 1, 50000.00),
--     (14, 2, 30000.00),
--     (15, 3, 20000.00),
--     (16, 4, 40000.00),
--     (17, 1, 48000.00),
--     (18, 2, 25000.00),
--     (19, 3, 14000.00),
--     (20, 4, 35000.00),
--     (21, 1, 50000.00),
--     (22, 2, 28000.00),
--     (23, 3, 17000.00),
--     (24, 4, 42000.00),
--     (25, 5, 15000.00),
--     (26, 6, 28000.00),
--     (27, 7, 35000.00),
--     (28, 5, 18000.00),
--     (29, 6, 30000.00),
--     (30, 7, 45000.00);

-- ALTER TABLE Admin
-- ADD CONSTRAINT fk_Admin_EmployeeID
-- FOREIGN KEY (EmployeeID)
-- REFERENCES Employee(EmployeeID);

-- ALTER TABLE Employee ADD INDEX idx1_EmployeeID (EmployeeID);


