

-- Initial complex query with WHERE filter for demonstration
SELECT 
    booking.booking_id,
    booking.start_date,
    booking.end_date,
    booking.total_price,
    booking.status,
    user.user_id,
    user.name AS user_name,
    user.email AS user_email,
    property.property_id,
    property.name AS property_name,
    property.location AS property_location,
    payment.payment_id,
    payment.amount,
    payment.payment_date
FROM 
    booking
INNER JOIN 
    user ON booking.user_id = user.user_id
INNER JOIN 
    property ON booking.property_id = property.property_id
LEFT JOIN 
    payment ON booking.booking_id = payment.booking_id
WHERE 
    booking.status = 'confirmed' AND payment.amount > 100;
