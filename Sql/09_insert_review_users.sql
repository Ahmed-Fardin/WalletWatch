-- ==========================================
-- WalletWatch
-- Import Review Users
-- ==========================================

TRUNCATE TABLE review_users RESTART IDENTITY CASCADE;

COPY review_users
(
    review_user_id,
    username
)
FROM 'E:/Projects/Wallet-Watch/Data/Import/review_users.csv'
DELIMITER ','
CSV HEADER;