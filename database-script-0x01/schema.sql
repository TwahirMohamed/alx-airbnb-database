-- Objective: Write SQL queries to define the database schema (create tables, set constraints).

-- Instructions:

-- Based on the provided database specification, create SQL CREATE TABLE statements for each entity.

-- Ensure proper data types, primary keys, foreign keys, and constraints.

-- Create necessary indexes on columns for optimal performance.
CREATE TABLE User (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50),
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Property (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_host FOREIGN KEY (host_id) 
        REFERENCES "User"(user_id)
);

CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    
    CONSTRAINT fk_user FOREIGN KEY (user_id) 
        REFERENCES `User`(user_id) 
        ON DELETE CASCADE,
    CONSTRAINT fk_property FOREIGN KEY (property_id) 
        REFERENCES `Property`(property_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM ('credit_card', 'paypal', 'stripe') NOT NULL,

    CONSTRAINT fk_booking FOREIGN KEY (booking_id) 
        REFERENCES `Booking`(booking_id)
        ON UPDATE CASCADE 
);

CREATE TABLE Review (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_property FOREIGN KEY (property_id)
        REFERENCES `Property`(property_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_user FOREIGN KEY (user_id)
        REFERENCES `User`(user_id)
        ON DELETE CASCADE

);
CREATE TABLE Message (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_sender FOREIGN KEY (sender_id)
        REFERENCES `User`(user_id)
    CONSTRAINT fk_recipient  FOREIGN KEY (recipient_id)
        REFERENCES `User`(user_id)

)

-- Index (MySQL also automatically indexes PKs, but explicit if needed)
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_property_host ON properties(host_id);
CREATE INDEX idx_booking_property ON bookings(property_id);
CREATE INDEX idx_booking_user ON bookings(user_id);
CREATE INDEX idx_payment_booking ON payments(booking_id);
CREATE INDEX idx_review_property ON reviews(property_id);
CREATE INDEX idx_review_user ON reviews(user_id);
CREATE INDEX idx_review_id ON Review (review_id);

