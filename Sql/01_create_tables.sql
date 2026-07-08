-- ===========================
-- Wallet Watch Project
-- File: 01_create_tables.sql
-- Purpose: Create all database tables
-- Author: Fardin Ahmed
-- ============================


create table companies(
        
    company_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    company_name TEXT NOT NULL,
    country TEXT NOT NULL,
    founded_year INT NOT NULL,
    website TEXT NOT NULL
);

CREATE TABLE apps (
    app_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    app_name TEXT NOT NULL,
    company_id INT NOT NULL,
    category TEXT NOT NULL,
    launch_year INT,
    app_version TEXT NOT NULL
);


create table users(
    user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username TEXT NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP ,
    last_login TIMESTAMP,
    is_verified BOOLEAN NOT NULL,
    country TEXT NOT NULL
);


CREATE TABLE review_users (

    review_user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    username TEXT NOT NULL UNIQUE

);


CREATE TABLE review_users (

    review_user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    username TEXT NOT NULL

);

CREATE TABLE reviews(
    review_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    review_user_id INT NOT NULL,

    app_id INT NOT NULL,

    app_version text,

    rating INT NOT NULL,

    review_text TEXT NOT NULL,

    review_source VARCHAR(50),

    language VARCHAR(30),

    sentiment VARCHAR(20),

    complaint_category VARCHAR(50),

    developer_reply BOOLEAN DEFAULT FALSE,

    thumbs_up_count INT DEFAULT 0,

    review_date TIMESTAMP,

    developer_reply_date TIMESTAMP,

    positive_review BOOLEAN,

    negative_review BOOLEAN,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (review_user_id)
    REFERENCES review_users(review_user_id),

    FOREIGN KEY (app_id)
    REFERENCES apps(app_id)
);

create table merchants(
    merchant_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    merchant_name TEXT NOT NULL,
    contact_email TEXT NOT NULL,
    contact_phone TEXT NOT NULL,
    category TEXT NOT NULL,
    country TEXT NOT NULL,
    city TEXT NOT NULL
);

    
create table transactions(
    transaction_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    app_id INT NOT NULL REFERENCES apps(app_id),
    merchant_id INT NOT NULL REFERENCES merchants(merchant_id),
    transaction_date TIMESTAMP NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    currency TEXT NOT NULL,
    transaction_type TEXT NOT NULL,
    payment_method TEXT NOT NULL,
    status TEXT NOT NULL,
    cashback DECIMAL(10,2),
    reward_points INT
);
    
