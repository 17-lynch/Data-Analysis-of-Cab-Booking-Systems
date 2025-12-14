CREATE DATABASE cab_booking ;               -- created a Database
USE cab_booking ;                           -- activate a database

                                            -- creating a table as [bookings] with attributes
CREATE TABLE bookings (
  id VARCHAR(50),
  vendor_id INT,
  pickup_datetime DATETIME,
  dropoff_datetime DATETIME,
  passenger_count INT,
  pickup_longitude FLOAT,
  pickup_latitude FLOAT,
  dropoff_longitude FLOAT,
  dropoff_latitude FLOAT,
  store_and_fwd_flag CHAR(1),
  trip_duration INT
);

											-- this is because importing issues and safe mode 
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';
SHOW VARIABLES LIKE 'secure_file_priv';
LOAD DATA LOCAL INFILE 'C:/SQL/Dataset_For_Cab_Booking_System.csv'
INTO TABLE bookings
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT COUNT(*) FROM bookings;
SELECT * FROM bookings LIMIT 5;                -- This lets you see if the columns look fine (dates, numbers,)
SHOW WARNINGS LIMIT 20;


ALTER TABLE bookings                           -- adding a new columns because we dont have some columns for analysis 
  ADD COLUMN customer_id INT,
  ADD COLUMN driver_id INT,
  ADD COLUMN cab_id INT,
  ADD COLUMN vehicle_type VARCHAR(20),
  ADD COLUMN fare DECIMAL(10,2),
  ADD COLUMN status VARCHAR(20),
  ADD COLUMN cancellation_reason VARCHAR(50),
  ADD COLUMN rating INT;
  
  
-- data is to huge thats why we process a data bathchwise , running a part by part 
                                          -- because of lost connection error 
                                          
 -- (customer_id , driver_id , cab_id)    ----------------------------------------------------------------------------------------------------------------------------                                     
UPDATE bookings
SET customer_id = FLOOR(1 + (RAND() * 100000)),
    driver_id   = FLOOR(1 + (RAND() * 10000)),
    cab_id      = FLOOR(1 + (RAND() * 5000))
LIMIT 100000;

UPDATE bookings 
SET customer_id = FLOOR(1 + (RAND() * 100000)),
    driver_id   = FLOOR(1 + (RAND() * 10000)),
    cab_id      = FLOOR(1 + (RAND() * 5000))
LIMIT 400000;

UPDATE bookings 
SET customer_id = FLOOR(1 + (RAND() * 100000)),
    driver_id   = FLOOR(1 + (RAND() * 10000)),
    cab_id      = FLOOR(1 + (RAND() * 5000))
LIMIT 60000;


SELECT COUNT(*) AS missing_rows  FROM bookings                                           -- checking if null rows occured or not
WHERE customer_id IS NULL OR driver_id IS NULL OR cab_id IS NULL;

-- Add a new integer column 'row_num' that auto-increments
-- and make it the PRIMARY KEY
ALTER TABLE bookings ADD COLUMN row_num INT AUTO_INCREMENT PRIMARY KEY;
DESCRIBE bookings;



--  (vehicle_type) -----------------------------------------------------------------------------------------------------------------------------------------------------

-- Batch 1
UPDATE bookings
SET vehicle_type = CASE
    WHEN RAND() < 0.6 THEN 'Sedan'
    WHEN RAND() < 0.9 THEN 'SUV'
    ELSE 'Mini'
END
WHERE row_num BETWEEN 1 AND 200000;

-- Batch 2
UPDATE bookings
SET vehicle_type = CASE
    WHEN RAND() < 0.6 THEN 'Sedan'
    WHEN RAND() < 0.9 THEN 'SUV'
    ELSE 'Mini'
END
WHERE row_num BETWEEN 200001 AND 400000;

-- Batch 3
UPDATE bookings
SET vehicle_type = CASE
    WHEN RAND() < 0.6 THEN 'Sedan'
    WHEN RAND() < 0.9 THEN 'SUV'
    ELSE 'Mini'
END
WHERE row_num BETWEEN 400001 AND 600000;

-- Batch 4
UPDATE bookings
SET vehicle_type = CASE
    WHEN RAND() < 0.6 THEN 'Sedan'
    WHEN RAND() < 0.9 THEN 'SUV'
    ELSE 'Mini'
END
WHERE row_num BETWEEN 600001 AND 800000;

-- Batch 5
UPDATE bookings
SET vehicle_type = CASE
    WHEN RAND() < 0.6 THEN 'Sedan'
    WHEN RAND() < 0.9 THEN 'SUV'
    ELSE 'Mini'
END
WHERE row_num BETWEEN 800001 AND 1048575;


-- because of null rows 
UPDATE bookings
SET vehicle_type = CASE
    WHEN RAND() < 0.6 THEN 'Sedan'
    WHEN RAND() < 0.9 THEN 'SUV'
    ELSE 'Mini'
END
WHERE vehicle_type IS NULL;




--  (fare) -------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Batch 1
UPDATE bookings
SET fare = GREATEST(30, ROUND(50 + (trip_duration/60.0)*5 + (RAND()*40 - 20), 2))
WHERE row_num BETWEEN 1 AND 200000;

-- Batch 2
UPDATE bookings
SET fare = GREATEST(30, ROUND(50 + (trip_duration/60.0)*5 + (RAND()*40 - 20), 2))
WHERE row_num BETWEEN 200001 AND 400000;

-- Batch 3
UPDATE bookings
SET fare = GREATEST(30, ROUND(50 + (trip_duration/60.0)*5 + (RAND()*40 - 20), 2))
WHERE row_num BETWEEN 400001 AND 600000;

-- Batch 4
UPDATE bookings
SET fare = GREATEST(30, ROUND(50 + (trip_duration/60.0)*5 + (RAND()*40 - 20), 2))
WHERE row_num BETWEEN 600001 AND 800000;

-- Batch 5
UPDATE bookings
SET fare = GREATEST(30, ROUND(50 + (trip_duration/60.0)*5 + (RAND()*40 - 20), 2))
WHERE row_num BETWEEN 800001 AND 1048575;


SELECT MIN(fare) AS min_fare,
       MAX(fare) AS max_fare,
       AVG(fare) AS avg_fare
FROM bookings;

-- because of null rows 
UPDATE bookings
SET fare = GREATEST(30, ROUND(50 + (trip_duration/60.0)*5 + (RAND()*40 - 20), 2))
WHERE fare IS NULL;


--  (status)  ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Batch 1
UPDATE bookings
SET status = CASE
    WHEN RAND() < 0.1 THEN 'cancelled'
    ELSE 'completed'
END
WHERE row_num BETWEEN 1 AND 200000;

-- Batch 2
UPDATE bookings
SET status = CASE
    WHEN RAND() < 0.1 THEN 'cancelled'
    ELSE 'completed'
END
WHERE row_num BETWEEN 200001 AND 400000;

-- Batch 3
UPDATE bookings
SET status = CASE
    WHEN RAND() < 0.1 THEN 'cancelled'
    ELSE 'completed'
END
WHERE row_num BETWEEN 400001 AND 600000;

-- Batch 4
UPDATE bookings
SET status = CASE
    WHEN RAND() < 0.1 THEN 'cancelled'
    ELSE 'completed'
END
WHERE row_num BETWEEN 600001 AND 800000;

-- Batch 5
UPDATE bookings
SET status = CASE
    WHEN RAND() < 0.1 THEN 'cancelled'
    ELSE 'completed'
END
WHERE row_num BETWEEN 800001 AND 1048575;


-- This will fill only rows where status is NULL, without touching already-filled ones
-- Batch 1
UPDATE bookings
SET status = CASE
    WHEN RAND() < 0.1 THEN 'cancelled'
    ELSE 'completed'
END
WHERE status IS NULL AND row_num BETWEEN 1 AND 200000;

-- Batch 2
UPDATE bookings
SET status = CASE
    WHEN RAND() < 0.1 THEN 'cancelled'
    ELSE 'completed'
END
WHERE status IS NULL AND row_num BETWEEN 200001 AND 400000;

-- Batch 3
UPDATE bookings
SET status = CASE
    WHEN RAND() < 0.1 THEN 'cancelled'
    ELSE 'completed'
END
WHERE status IS NULL AND row_num BETWEEN 400001 AND 600000;

-- Batch 4
UPDATE bookings
SET status = CASE
    WHEN RAND() < 0.1 THEN 'cancelled'
    ELSE 'completed'
END
WHERE status IS NULL AND row_num BETWEEN 600001 AND 800000;

-- Batch 5
UPDATE bookings
SET status = CASE
    WHEN RAND() < 0.1 THEN 'cancelled'
    ELSE 'completed'
END
WHERE status IS NULL AND row_num BETWEEN 800001 AND 1048575;


SELECT status, COUNT(*) FROM bookings GROUP BY status;



--  (cancellation_reason)  --------------------------------------------------------------------------------------------------------------------------------------------------
-- cancellation_reason, but only for rows where status = 'cancelled'.
-- Batch 1      : Update cancellation_reason in batches
UPDATE bookings
SET cancellation_reason = ELT(FLOOR(1 + RAND()*3), 'Traffic','No-show','Personal')
WHERE status = 'cancelled' AND row_num BETWEEN 1 AND 200000;

-- Batch 2
UPDATE bookings
SET cancellation_reason = ELT(FLOOR(1 + RAND()*3), 'Traffic','No-show','Personal')
WHERE status = 'cancelled' AND row_num BETWEEN 200001 AND 400000;

-- Batch 3
UPDATE bookings
SET cancellation_reason = ELT(FLOOR(1 + RAND()*3), 'Traffic','No-show','Personal')
WHERE status = 'cancelled' AND row_num BETWEEN 400001 AND 600000;

-- Batch 4
UPDATE bookings
SET cancellation_reason = ELT(FLOOR(1 + RAND()*3), 'Traffic','No-show','Personal')
WHERE status = 'cancelled' AND row_num BETWEEN 600001 AND 800000;

-- Batch 5
UPDATE bookings
SET cancellation_reason = ELT(FLOOR(1 + RAND()*3), 'Traffic','No-show','Personal')
WHERE status = 'cancelled' AND row_num BETWEEN 800001 AND 1048575;

SELECT cancellation_reason, COUNT(*)
FROM bookings
GROUP BY cancellation_reason;


-- (rating)  ----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- We’ll use a skewed distribution (most ratings are 4 or 5, fewer are 1–3).
-- First half (rows 1 to 500k)
UPDATE bookings
SET rating = CASE
    WHEN RAND() < 0.05 THEN 1
    WHEN RAND() < 0.15 THEN 2
    WHEN RAND() < 0.30 THEN 3
    WHEN RAND() < 0.70 THEN 4
    ELSE 5
END
WHERE row_num <= 500000;

-- Second half (rows 500001 to end)
UPDATE bookings
SET rating = CASE
    WHEN RAND() < 0.05 THEN 1
    WHEN RAND() < 0.15 THEN 2
    WHEN RAND() < 0.30 THEN 3
    WHEN RAND() < 0.70 THEN 4
    ELSE 5
END
WHERE row_num > 500000;

SELECT rating, COUNT(*) 
FROM bookings 
GROUP BY rating 
ORDER BY rating;



--   verifying is containing a null or not 
SELECT 
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(driver_id IS NULL) AS missing_driver_id,
    SUM(cab_id IS NULL) AS missing_cab_id,
    SUM(vehicle_type IS NULL) AS missing_vehicle_type,
    SUM(fare IS NULL) AS missing_fare,
    SUM(status IS NULL) AS missing_status,
    SUM(cancellation_reason IS NULL) AS missing_cancellation_reason,
    SUM(rating IS NULL) AS missing_rating
FROM bookings;

-- (cancellation_reason) : are rows empty Because completed trips don’t need cancellation reason



-- Verify (row_num) and (id) is unique
SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT row_num) AS unique_row_nums
FROM bookings;

SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT id) AS unique_ids
FROM bookings;
