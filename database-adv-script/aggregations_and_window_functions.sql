-- Objective: Use SQL aggregation and window functions to analyze data.

--     Instructions:

--     Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.

SELECT user_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id;

--     Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.

SELECT p.*, COUNT(b.id) AS total_bookings,
       RANK() OVER (ORDER BY COUNT(b.id) DESC) AS booking_rank
FROM properties p
LEFT JOIN bookings b ON p.id = b.property_id
GROUP BY p.id;
