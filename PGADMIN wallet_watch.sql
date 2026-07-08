DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS merchants CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS apps CASCADE;
DROP TABLE IF EXISTS companies CASCADE;































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
    company_id INT NOT NULL REFERENCES companies(company_id),
    category TEXT NOT NULL,
    launch_year INT 
);


create table users(
    user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username TEXT NOT NULL,
    email TEXT NOT NULL,
    password TEXT NOT NULL,
    created_at TIMESTAMP ,
    country TEXT NOT NULL
);

create table reviews(
    review_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT NOT NULL References users(user_id),
    app_version INT NOT NULL,
    rating INT NOT NULL,
    review_text TEXT,
    created_at TIMESTAMP
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

Alter Table users
Add Constraint users_email_unique
unique(email);


INSERT INTO companies
(company_name, country, founded_year, website)

VALUES
('Google', 'United States', 1998, 'https://google.com');
Delete from companies;


INSERT INTO companies
(company_name, country, founded_year, website)

VALUES
('Touch ''n Go Digital', 'Malaysia', 2017, 'https://www.touchngo.com.my'),
('Grab Holdings', 'Singapore', 2012, 'https://www.grab.com'),
('Sea Limited', 'Singapore', 2009, 'https://www.sea.com'),
('Boost Holdings', 'Malaysia', 2017, 'https://www.myboost.com.my'),
('BigPay', 'Malaysia', 2017, 'https://bigpayme.com'),
('Maybank', 'Malaysia', 1960, 'https://www.maybank.com'),
('CIMB Group', 'Malaysia', 1924, 'https://www.cimb.com'),
('Setel Ventures', 'Malaysia', 2018, 'https://www.setel.com'),
('AEON Bank', 'Malaysia', 2024, 'https://www.aeonbank.com.my');


Select *
From Companies;



Delete from companies;

Select* 
from companies;


INSERT INTO companies
(company_name, country, founded_year, website)

VALUES
('Touch ''n Go Digital', 'Malaysia', 2017, 'https://www.touchngo.com.my'),
('Grab Holdings', 'Singapore', 2012, 'https://www.grab.com'),
('Sea Limited', 'Singapore', 2009, 'https://www.sea.com'),
('Boost Holdings', 'Malaysia', 2017, 'https://www.myboost.com.my'),
('BigPay', 'Malaysia', 2017, 'https://bigpayme.com'),
('Maybank', 'Malaysia', 1960, 'https://www.maybank.com'),
('CIMB Group', 'Malaysia', 1924, 'https://www.cimb.com'),
('Setel Ventures', 'Malaysia', 2018, 'https://www.setel.com'),
('GoTo Group', 'Indonesia', 2021, 'https://www.gotocompany.com'),
('Lippo Group', 'Indonesia', 1950, 'https://www.lippogroup.com'),
('Ant Group', 'China', 2014, 'https://www.antgroup.com'),
('Tencent', 'China', 1998, 'https://www.tencent.com');


Select *
From companies;


TRUNCATE TABLE companies RESTART IDENTITY CASCADE;

select*
From companies;


INSERT INTO companies
(company_name, country, founded_year, website)

VALUES
('Touch ''n Go Digital', 'Malaysia', 2017, 'https://www.touchngo.com.my'),
('Grab Holdings', 'Singapore', 2012, 'https://www.grab.com'),
('Sea Limited', 'Singapore', 2009, 'https://www.sea.com'),
('Boost Holdings', 'Malaysia', 2017, 'https://www.myboost.com.my'),
('BigPay', 'Malaysia', 2017, 'https://bigpayme.com'),
('Maybank', 'Malaysia', 1960, 'https://www.maybank.com'),
('CIMB Group', 'Malaysia', 1924, 'https://www.cimb.com'),
('Setel Ventures', 'Malaysia', 2018, 'https://www.setel.com'),
('GoTo Group', 'Indonesia', 2021, 'https://www.gotocompany.com'),
('Lippo Group', 'Indonesia', 1950, 'https://www.lippogroup.com'),
('Ant Group', 'China', 2014, 'https://www.antgroup.com'),
('Tencent', 'China', 1998, 'https://www.tencent.com');


Select * 
From companies
order by company_id;



INSERT INTO apps
(app_name, company_id, category, launch_year)

VALUES
('Touch ''n Go eWallet', 1, 'Digital Wallet', 2017),
('GrabPay', 2, 'Digital Wallet', 2017),
('ShopeePay', 3, 'Digital Wallet', 2019),
('Boost', 4, 'Digital Wallet', 2017),
('BigPay', 5, 'Digital Wallet', 2018),
('MAE', 6, 'Digital Wallet', 2020),
('CIMB OCTO', 7, 'Digital Wallet', 2021),
('Setel', 8, 'Fuel & Digital Wallet', 2018);


Select*
From apps;



INSERT INTO users
(username, email, password, created_at, country)



VALUES
('john_doe', 'john@example.com', 'hashed_password_1', '2023-01-15', 'Malaysia'),

('nur_aisyah', 'aisyah@example.com', 'hashed_password_2', '2023-03-10', 'Malaysia'),

('wei_ming', 'weiming@example.com', 'hashed_password_3', '2022-11-08', 'Singapore'),

('budi_setiawan', 'budi@example.com', 'hashed_password_4', '2023-02-18', 'Indonesia'),

('somchai', 'somchai@example.com', 'hashed_password_5', '2022-12-20', 'Thailand'),

('maria_santos', 'maria@example.com', 'hashed_password_6', '2023-05-01', 'Philippines'),

('nguyen_anh', 'anh@example.com', 'hashed_password_7', '2023-06-11', 'Vietnam');


Select* 
From users;




INSERT INTO merchants
(merchant_name, contact_email, contact_phone, category, country, city)

VALUES
('McDonald''s Malaysia', 'contact@mcdonalds.com.my', '+60312345678', 'Food & Beverage', 'Malaysia', 'Kuala Lumpur'),

('Tealive', 'support@tealive.com.my', '+60322334455', 'Beverage', 'Malaysia', 'Subang Jaya'),

('Petronas', 'care@petronas.com', '+60320515000', 'Fuel Station', 'Malaysia', 'Kuala Lumpur'),

('7-Eleven Malaysia', 'support@7eleven.com.my', '+60321456789', 'Convenience Store', 'Malaysia', 'Petaling Jaya'),

('Watsons Malaysia', 'customer@watsons.com.my', '+60377223344', 'Health & Beauty', 'Malaysia', 'Shah Alam'),

('Lotus''s Malaysia', 'support@lotuss.com.my', '+60377889900', 'Supermarket', 'Malaysia', 'Subang Jaya'),

('Sunway Pyramid', 'info@sunway.com.my', '+60374943100', 'Shopping Mall', 'Malaysia', 'Subang Jaya'),

('GrabFood Merchant', 'merchant@grab.com', '+6561234567', 'Food Delivery', 'Singapore', 'Singapore');


Select* 
From Merchants;
