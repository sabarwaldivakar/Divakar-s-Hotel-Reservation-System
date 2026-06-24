/* CREATION OF DATABASE */

CREATE SCHEMA IF NOT EXISTS HotelReservationSystem;
USE HotelReservationSystem;

/* SECTION 1 CREATING TABLES */ 

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(150)
);

CREATE TABLE RoomTypes (
	room_type_id INT AUTO_INCREMENT PRIMARY KEY,
	type_name VARCHAR(50) NOT NULL UNIQUE,
	description VARCHAR(100) NOT NULL,
	price_per_night DECIMAL(10,2) NOT NULL,
	capacity INT NOT NULL
);

CREATE TABLE Rooms ( 
	room_id INT AUTO_INCREMENT PRIMARY KEY,
	room_number INT NOT NULL UNIQUE,
	room_type_id INT NOT NULL,
	status VARCHAR(50) DEFAULT 'Available',
	floor_number INT NOT NULL, 
	FOREIGN KEY (room_type_id) references RoomTypes(room_type_id)
);

CREATE TABLE Bookings(
	booking_id INT AUTO_INCREMENT PRIMARY KEY,
	booking_date DATE NOT NULL,
	check_in_date DATE NOT NULL,
	check_out_date DATE NOT NULL,
	booking_status VARCHAR(50) DEFAULT 'Confirmed',
	customer_id INT NOT NULL,
	room_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
	FOREIGN KEY (room_id) REFERENCES Rooms(room_id),
	CONSTRAINT chk_booking_dates
	CHECK (check_out_date > check_in_date)
);

CREATE TABLE Payments(
	payment_id INT AUTO_INCREMENT PRIMARY KEY,
	payment_date DATE NOT NULL,
	payment_method VARCHAR(50) NOT NULL,
	amount DECIMAL (10,2) NOT NULL,
	payment_status VARCHAR(50) DEFAULT 'Completed',
	booking_id INT NOT NULL,
	FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

CREATE TABLE Services(
	service_id INT AUTO_INCREMENT PRIMARY KEY,
	service_name VARCHAR(50) NOT NULL UNIQUE,
	service_price DECIMAL (10,2) NOT NULL ,
	description VARCHAR (100) NOT NULL
);

CREATE TABLE BookingServices (
	bs_id INT AUTO_INCREMENT PRIMARY KEY,
	booking_id INT NOT NULL,
	service_id INT NOT NULL,
	usage_count INT NOT NULL DEFAULT 1, 
	FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id),
	FOREIGN KEY (service_id) REFERENCES Services(service_id),
	UNIQUE (booking_id, service_id)
);

/* SECTION 2 INSERTING SAMPLE DATA */

INSERT INTO RoomTypes  ( type_name, description, price_per_night, capacity ) 
VALUES 
( 'Standard', '1 King Bed', 89.99, 2 ),
( 'Luxury', '2 Queen Beds', 149.99, 4 ),
( 'Family', '2 Queen & 1 King Bed with Balcony and Garden View', 199.99, 4 ),
( 'Suite', '2 Queen & 1 King Bed with Balcony, City View and Living Area', 249.99, 4 );

INSERT INTO Rooms (room_number, room_type_id, floor_number)
VALUES
( 101, 1, 1 ),
( 102, 1, 1 ),
( 103, 1, 1 ),
( 104, 1, 1 ),

( 201, 2, 2 ),
( 202, 2, 2 ),
( 203, 2, 2 ),
( 204, 2, 2 ),

( 301, 3, 3 ),
( 302, 3, 3 ),
( 303, 3, 3 ),
( 304, 3, 3 ),

( 401, 4, 4 ),
( 402, 4, 4 ),
( 403, 4, 4 ),
( 404, 4, 4 );

INSERT INTO Services
(service_name, service_price, description)
VALUES
('Breakfast', 15.99, 'Buffet breakfast served daily'),
('Lunch', 24.99, 'Lunch menu with multiple cuisines'),
('Dinner', 34.99, 'Evening dining experience'),
('Gym Access', 9.99, 'Access to hotel fitness center'),
('Spa Access', 49.99, 'Access to spa facilities'),
('Massage', 79.99, 'Professional massage service'),
('Airport Shuttle', 29.99, 'Transportation to or from airport'),
('Pool Access', 12.99, 'Access to swimming pool facilities');

INSERT INTO Customers
(full_name, email, phone, address)
VALUES
('Max Müller', 'max.mueller@email.com', '+4915112345678', 'Berlin, Germany'),
('Anna Schmidt', 'anna.schmidt@email.com', '+4915112345679', 'Munich, Germany'),
('Lukas Weber', 'lukas.weber@email.com', '+4915112345680', 'Hamburg, Germany'),
('Sophie Fischer', 'sophie.fischer@email.com', '+4915112345681', 'Frankfurt, Germany'),
('Leon Wagner', 'leon.wagner@email.com', '+4915112345682', 'Cologne, Germany'),
('Emma Becker', 'emma.becker@email.com', '+4915112345683', 'Stuttgart, Germany'),
('Noah Hoffmann', 'noah.hoffmann@email.com', '+4915112345684', 'Düsseldorf, Germany'),
('Mia Schneider', 'mia.schneider@email.com', '+4915112345685', 'Leipzig, Germany'),

('James Wilson', 'james.wilson@email.com', '+447700123456', 'London, United Kingdom'),
('Pierre Martin', 'pierre.martin@email.com', '+33612345678', 'Paris, France'),
('Marco Rossi', 'marco.rossi@email.com', '+393331234567', 'Rome, Italy'),
('Carlos Garcia', 'carlos.garcia@email.com', '+34612345678', 'Madrid, Spain'),

('Priya Sharma', 'priya.sharma@email.com', '+919876543210', 'Mumbai, India'),
('Li Wei', 'li.wei@email.com', '+8613812345678', 'Shanghai, China'),
('Ahmed Hassan', 'ahmed.hassan@email.com', '+201001234567', 'Cairo, Egypt');

INSERT INTO Bookings
(booking_date, check_in_date, check_out_date, customer_id, room_id)
VALUES
('2026-02-20', '2026-03-01', '2026-03-04', 1, 1),
('2026-02-25', '2026-03-05', '2026-03-08', 2, 5),
('2026-03-01', '2026-03-10', '2026-03-14', 3, 9),
('2026-03-05', '2026-03-15', '2026-03-20', 4, 13),
('2026-03-10', '2026-03-22', '2026-03-25', 5, 2),

('2026-03-15', '2026-04-01', '2026-04-05', 6, 6),
('2026-03-20', '2026-04-08', '2026-04-12', 7, 10),
('2026-03-25', '2026-04-15', '2026-04-20', 8, 14),
('2026-04-01', '2026-04-22', '2026-04-25', 9, 3),
('2026-04-05', '2026-04-28', '2026-05-02', 10, 7),

('2026-04-10', '2026-05-05', '2026-05-09', 11, 11),
('2026-04-15', '2026-05-12', '2026-05-17', 12, 15),
('2026-04-20', '2026-05-20', '2026-05-24', 13, 4),
('2026-04-25', '2026-05-27', '2026-05-31', 14, 8),
('2026-05-01', '2026-06-05', '2026-06-10', 15, 16);

INSERT INTO Payments
(payment_date, payment_method, amount, booking_id)
VALUES
('2026-02-20', 'Credit Card', 361.93, 1),
('2026-02-25', 'Debit Card', 533.91, 2),
('2026-03-01', 'PayPal', 926.89, 3),
('2026-03-05', 'Credit Card', 1429.92, 4),
('2026-03-10', 'Cash', 301.95, 5),

('2026-03-15', 'Debit Card', 739.92, 6),
('2026-03-20', 'Credit Card', 819.94, 7),
('2026-03-25', 'PayPal', 1279.94, 8),
('2026-04-01', 'Cash', 285.96, 9),
('2026-04-05', 'Credit Card', 649.95, 10),

('2026-04-10', 'Debit Card', 959.94, 11),
('2026-04-15', 'Credit Card', 1301.91, 12),
('2026-04-20', 'PayPal', 409.94, 13),
('2026-04-25', 'Credit Card', 669.94, 14),
('2026-05-01', 'Debit Card', 1309.93, 15);

INSERT INTO BookingServices
(booking_id, service_id, usage_count)
VALUES
( 1, 1, 2),
( 1, 7, 2),
( 2, 1, 4),
( 2, 4, 2),
( 3, 2, 3),
( 3, 8, 4),
( 4, 5, 2),
( 4, 6, 1),
( 5, 1, 2),
( 6, 3, 4),
( 7, 4, 2),
( 8, 7, 1),
( 9, 1, 1),
(10, 5, 1),
(11, 6, 2),
(12, 8, 4),
(13, 2, 2),
(14, 3, 2),
(15, 7, 2); 


/* SECTION 3 QUERIES */

-- 1. Query to enter a new customer --
INSERT INTO Customers (full_name, email, phone, address )
VALUES 
('Divakar', 'divakar@gmail.com', '+918968822744', 'Punjab, India' );

-- 2. Query to verify any updation to the records --
SELECT *
FROM Customers 
WHERE email = 'divakar@gmail.com';

-- 3. Query to update previous records --
UPDATE Customers 
SET phone = '+4917662875541'
WHERE email  = 'divakar@gmail.com';

-- 4. Query to check customer without booking --
SELECT c.full_name
FROM Customers c
LEFT JOIN Bookings b
ON c.customer_id = b.customer_id
WHERE b.booking_id IS NULL ;

-- 5. Query to delete a record -- 
DELETE FROM Customers 
WHERE email= 'divakar@gmail.com';

-- 6. Query for booking details -- 
SELECT b.booking_id, c.full_name, r.room_number, rt.type_name, b.check_in_date, b.check_out_date    
FROM Bookings b  
JOIN Customers c ON c.customer_id = b.customer_id 
JOIN Rooms r ON  r.room_id = b.room_id 
JOIN RoomTypes rt ON rt.room_type_id = r.room_type_id 
ORDER BY b.booking_id ; 

-- 7. Query for Total Bookings -- 
SELECT COUNT(*) AS Total_Bookings
FROM Bookings b ;

-- 8. Query for Revenue by Payment Method -- 
SELECT p.payment_method, SUM(p.amount) AS Total_Revenue_by_Payment_method
FROM Payments p 
GROUP BY p.payment_method ;

--  9.Query to find Average -- 
SELECT AVG(p.amount) AS Average_Booking_Payment
FROM Payments p ;

-- 10. Query for Revenue from services -- 
SELECT s.service_id, s.service_name , SUM (s.service_price * bs.usage_count ) AS Total_service_revenue
FROM BookingServices bs  
JOIN Services s on s.service_id = bs.service_id 
GROUP BY s.service_name ;

-- 11. Query for Revenue from Rooms --
SELECT b.booking_id, c.full_name, DATEDIFF(b.check_out_date,  b.check_in_date ) * rt.price_per_night AS Total_Room_Revenue
From Bookings b
JOIN Customers c ON c.customer_id = b.customer_id
JOIN Rooms r ON r.room_id = b.room_id 
JOIN RoomTypes rt ON rt.room_type_id = r.room_type_id ; 

-- 12. Query for Payment method Having more than 3 transactions --
SELECT payment_method, COUNT(*) AS Total_Payments
FROM Payments
GROUP BY payment_method
HAVING COUNT(*) > 3;

-- 13. Query to find all Suite rooms --
SELECT *
FROM Rooms
WHERE room_type_id = (SELECT room_type_id 
FROM RoomTypes
WHERE type_name = 'Suite');

-- 14. Query for TOTAL REVENUE --
SELECT SUM( p.amount) AS Total_Hotel_Revenue
FROM Payments p 



-- Wrong Query for total booking revenue -- 
SELECT c.customer_id, s.service_price * bs.usage_count + DATEDIFF(b.check_out_date, b.check_in_date) * rt.price_per_night AS Total_Booking_Revenue
FROM BookingServices bs 
JOIN Bookings b ON b.booking_id = bs.booking_id 
JOIN Services s ON s.service_id = bs.service_id
JOIN Customers c ON c.customer_id = b.customer_id
JOIN Rooms r ON r.room_id  = b.room_id 
JOIN RoomTypes rt  ON rt.room_type_id = r.room_type_id  
ORDER BY c.customer_id ;


