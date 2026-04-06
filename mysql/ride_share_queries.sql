CREATE DATABASE ride_sharing_prj;
USE ride_sharing_prj;

CREATE TABLE rides(
trip_id INT,
pickup_datetime DATETIME,
dropoff_datetime DATETIME,
pickup_location VARCHAR(50),
dropoff_location VARCHAR(50),
fare_amount DECIMAL(10,2),
distance_km FLOAT,
driver_id INT,
customer_id INT,
ride_status VARCHAR(20),
payment_type VARCHAR(20),
vehicle_type VARCHAR(20),
surge_multiplier FLOAT,
rating FLOAT,
weather_condition VARCHAR(20),
trip_duration FLOAT,
hour INT,
day VARCHAR(20),
MONTH INT,
is__weekend INT,
revenue FLOAT,
revenue_per_km FLOAT
);
DESC rides;

DROP TABLE rides;
SHOW TABLES;
SELECT *FROM rides LIMIT 23;


-- total rides
SELECT COUNT(trip_id) FROM rides;
SELECT COUNT(*) AS total_rides FROM rides;

-- total revenue
SELECT ROUND(SUM(revenue),3) AS total_revenue FROM rides;
SELECT SUM(revenue) AS total_revenue FROM rides;

-- average trip duration
SELECT AVG(trip_duration) AS average_duration FROM rides;
SELECT ROUND(AVG(trip_duration),4) AS avg_trip_duration FROM rides;

-- average fare
SELECT AVG(fare_amount) AS fare FROM rides;
SELECT ROUND(AVG(fare_amount),2) AS avg_fare FROM rides;

-- average distance
SELECT AVG(distance_km) FROM rides;
SELECT ROUND(AVG(distance_km),3) AS avg_distance FROM rides;

-- rides by hour, peak hours
SELECT hour, COUNT(trip_id) AS total_rides FROM rides GROUP BY hour ORDER BY total_rides DESC;
SELECT hour, COUNT(*) AS rides
FROM rides
GROUP BY hour
ORDER BY rides DESC;

-- total rides by day
SELECT day, COUNT(trip_id) AS total_rides FROM rides GROUP BY day ORDER BY total_rides DESC;
SELECT day, COUNT(*) AS rides
FROM rides
GROUP BY day
ORDER BY rides DESC;

-- weekday vs weekend
SELECT is__weekend, COUNT(trip_id) AS total_rides FROM rides GROUP BY is__weekend; 
SELECT is__weekend, COUNT(*) AS rides
FROM rides
GROUP BY is__weekend;

-- monthly trend
SELECT MONTH, COUNT(trip_id) FROM rides GROUP BY MONTH ORDER BY COUNT(trip_id) DESC;
SELECT month, COUNT(*) AS rides
FROM rides
GROUP BY month
ORDER BY month;

-- location wise analysis
SELECT pickup_location, COUNT(trip_id) AS total_trips FROM rides GROUP BY pickup_location;
SELECT pickup_location, COUNT(*) AS rides
FROM rides
GROUP BY pickup_location
ORDER BY rides DESC;

-- revenue by city
SELECT pickup_location, ROUND(SUM(revenue),2) AS revenue FROM rides GROUP BY pickup_location 
ORDER BY revenue DESC;
SELECT pickup_location, SUM(revenue) AS revenue
FROM rides
GROUP BY pickup_location
ORDER BY revenue DESC;

-- average fare by city
SELECT pickup_location, AVG(fare_amount) AS fare_amount FROM rides GROUP BY pickup_location
ORDER BY fare_amount DESC;
SELECT pickup_location, AVG(fare_amount) AS avg_fare
FROM rides
GROUP BY pickup_location;

-- ride status distribution
SELECT ride_status, COUNT(trip_id) AS total_trips FROM rides GROUP BY ride_status 
ORDER BY total_trips DESC;
SELECT ride_status, COUNT(*) AS total
FROM rides
GROUP BY ride_status;

-- cancelation rate
SELECT 
    ROUND(SUM(CASE WHEN ride_status='cancelled' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS cancellation_rate
FROM rides;

-- revenue by payment-type
SELECT payment_type, ROUND(SUM(revenue),3) FROM rides GROUP BY payment_type ORDER BY SUM(revenue) DESC;
SELECT payment_type, SUM(revenue) AS revenue
FROM rides
GROUP BY payment_type;

-- vehicle-type performance
SELECT vehicle_type, ROUND(SUM(revenue),3), COUNT(trip_id) AS total_trip FROM rides 
GROUP BY vehicle_type ORDER BY total_trip DESC;
SELECT vehicle_type,
       COUNT(*) AS rides,
       SUM(revenue) AS revenue
FROM rides
GROUP BY vehicle_type;

-- driver performance
SELECT driver_id, COUNT(trip_id) AS total_trips, ROUND(SUM(revenue),2) AS revenue, 
ROUND(AVG(rating),2) AS rating FROM rides GROUP BY driver_id ORDER BY revenue DESC LIMIT 12;
SELECT COUNT(DISTINCT driver_id) AS total_drivers FROM rides;

SELECT driver_id,
       COUNT(*) AS total_rides,
       ROUND(AVG(rating),2) AS avg_rating
FROM rides
GROUP BY driver_id
HAVING total_rides > 7
ORDER BY avg_rating DESC;

-- surge pricing impact
SELECT surge_multiplier,
       COUNT(*) AS rides,
       ROUND(AVG(revenue),2) AS avg_revenue
FROM rides
GROUP BY surge_multiplier;

-- Revenue per KM by Vehicle
SELECT vehicle_type, SUM(revenue_per_km) FROM rides GROUP BY vehicle_type;
SELECT vehicle_type,
       ROUND(AVG(revenue_per_km),2) AS avg_revenue_per_km
FROM rides
GROUP BY vehicle_type;

-- weather condition impact on rides
SELECT weather_condition, COUNT(trip_id) AS total_trip FROM rides GROUP BY weather_condition
ORDER BY total_trip; 

SELECT weather_condition,
       COUNT(*) AS rides
FROM rides
GROUP BY weather_condition;

-- weather condition impact on revenue
SELECT weather_condition, ROUND(SUM(revenue),3) AS revenue FROM rides GROUP BY weather_condition;
SELECT weather_condition,
       SUM(revenue) AS revenue
FROM rides
GROUP BY weather_condition;

-- peak demand day,hour
SELECT day, hour, COUNT(trip_id) AS total_trips FROM rides GROUP BY day,hour ORDER BY total_trips;
SELECT day, hour, COUNT(*) AS rides
FROM rides
GROUP BY day, hour
ORDER BY rides DESC;

-- top 10 high revenue trips
SELECT trip_id, revenue FROM rides ORDER BY revenue DESC LIMIT 10;
SELECT trip_id, revenue
FROM rides
ORDER BY revenue DESC
LIMIT 10;