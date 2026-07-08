ALTER TABLE users
ADD CONSTRAINT users_email_unique
UNIQUE(email);


ALTER TABLE companies
ADD CONSTRAINT companies_name_unique
UNIQUE(company_name);

ALTER TABLE merchants
ADD CONSTRAINT merchants_email_unique
UNIQUE(contact_email);


ALTER TABLE transactions
ADD CONSTRAINT transactions_amount_check
CHECK (amount > 0);


ALTER TABLE reviews
ADD CONSTRAINT reviews_rating_check
CHECK (rating >= 1 AND rating <= 5);


ALTER TABLE apps
ADD CONSTRAINT apps_launch_year_check
CHECK (launch_year >= 2000);
