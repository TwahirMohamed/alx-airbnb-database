-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT booking.booking_id,
    booking.property_id,
    booking.start_date,
    booking.end_date,
    booking.total_price,
    booking.status,
    users.id AS user_id,
    users.username,
    users.email

FROM booking  INNER JOIN users

ON booking.user_id = users.id;

-- Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT 
    properties.id AS property_id,
    reviews.id AS review_id,
    reviews.content
FROM 
    properties
LEFT JOIN 
    reviews 
ON 
    properties.id = reviews.property_id
ORDER BY 
    properties.id, reviews.id;

-- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT users.id AS user_id, bookings.id AS booking_id
FROM users FULL OUTER JOIN bookings ON users.id = bookings.user_id;