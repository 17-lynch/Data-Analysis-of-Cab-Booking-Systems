-- [1] Total number of bookings
SELECT COUNT(*) AS total_bookings FROM bookings;

-- [2] Completed vs Cancelled trips
SELECT status, COUNT(*) AS total
FROM bookings
GROUP BY status;

-- [3] Cancellation reasons
SELECT cancellation_reason, COUNT(*) AS total
FROM bookings
WHERE status = 'cancelled'
GROUP BY cancellation_reason;

-- [4] Average fare per vehicle type
SELECT vehicle_type, ROUND(AVG(fare),2) AS avg_fare
FROM bookings
GROUP BY vehicle_type;

-- [5] Total revenue (sum of fares)
SELECT ROUND(SUM(fare),2) AS total_revenue FROM bookings;

-- [6] Top 10 customers by number of rides
SELECT customer_id, COUNT(*) AS rides
FROM bookings
GROUP BY customer_id
ORDER BY rides DESC
LIMIT 10;

-- [7] Top 10 drivers by completed trips
SELECT driver_id, COUNT(*) AS completed_trips
FROM bookings
WHERE status = 'completed'
GROUP BY driver_id
ORDER BY completed_trips DESC
LIMIT 10;

-- [8] Driver ratings (average per driver)
SELECT driver_id, ROUND(AVG(rating),2) AS avg_rating, COUNT(*) AS trips
FROM bookings
GROUP BY driver_id
ORDER BY avg_rating DESC
LIMIT 10;

-- [9] Busiest pickup locations (top 5)
SELECT pickup_latitude, pickup_longitude, COUNT(*) AS trips
FROM bookings
GROUP BY pickup_latitude, pickup_longitude
ORDER BY trips DESC
LIMIT 5;

-- [10] Average trip duration per vehicle type
SELECT vehicle_type, ROUND(AVG(trip_duration)/60,2) AS avg_duration_minutes
FROM bookings
GROUP BY vehicle_type;


describe bookings;