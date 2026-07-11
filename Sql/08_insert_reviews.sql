-- ==========================================
-- WalletWatch
-- Import All Review CSV Files
-- ==========================================
-- ==========================================
-- Remove existing reviews
-- ==========================================

TRUNCATE TABLE reviews RESTART IDENTITY;



COPY reviews
(
    review_user_id,
    app_id,
    app_version,
    rating,
    review_text,
    review_source,
    language,
    sentiment,
    complaint_category,
    developer_reply,
    thumbs_up_count,
    review_date,
    developer_reply_date,
    positive_review,
    negative_review
)
FROM 'E:/Projects/Wallet-Watch/Data/Import/touch_n_go_reviews_import.csv'
DELIMITER ','
CSV HEADER;

COPY reviews
(
    review_user_id,
    app_id,
    app_version,
    rating,
    review_text,
    review_source,
    language,
    sentiment,
    complaint_category,
    developer_reply,
    thumbs_up_count,
    review_date,
    developer_reply_date,
    positive_review,
    negative_review
)
FROM 'E:/Projects/Wallet-Watch/Data/Import/boost_reviews_import.csv'
DELIMITER ','
CSV HEADER;

COPY reviews
(
    review_user_id,
    app_id,
    app_version,
    rating,
    review_text,
    review_source,
    language,
    sentiment,
    complaint_category,
    developer_reply,
    thumbs_up_count,
    review_date,
    developer_reply_date,
    positive_review,
    negative_review
)
FROM 'E:/Projects/Wallet-Watch/Data/Import/bigpay_reviews_import.csv'
DELIMITER ','
CSV HEADER;

COPY reviews
(
    review_user_id,
    app_id,
    app_version,
    rating,
    review_text,
    review_source,
    language,
    sentiment,
    complaint_category,
    developer_reply,
    thumbs_up_count,
    review_date,
    developer_reply_date,
    positive_review,
    negative_review
)
FROM 'E:/Projects/Wallet-Watch/Data/Import/mae_reviews_import.csv'
DELIMITER ','
CSV HEADER;

COPY reviews
(
    review_user_id,
    app_id,
    app_version,
    rating,
    review_text,
    review_source,
    language,
    sentiment,
    complaint_category,
    developer_reply,
    thumbs_up_count,
    review_date,
    developer_reply_date,
    positive_review,
    negative_review
)
FROM 'E:/Projects/Wallet-Watch/Data/Import/cimb_octo_reviews_import.csv'
DELIMITER ','
CSV HEADER;

COPY reviews
(
    review_user_id,
    app_id,
    app_version,
    rating,
    review_text,
    review_source,
    language,
    sentiment,
    complaint_category,
    developer_reply,
    thumbs_up_count,
    review_date,
    developer_reply_date,
    positive_review,
    negative_review
)
FROM 'E:/Projects/Wallet-Watch/Data/Import/setel_reviews_import.csv'
DELIMITER ','
CSV HEADER;

COPY reviews
(
    review_user_id,
    app_id,
    app_version,
    rating,
    review_text,
    review_source,
    language,
    sentiment,
    complaint_category,
    developer_reply,
    thumbs_up_count,
    review_date,
    developer_reply_date,
    positive_review,
    negative_review
)
FROM 'E:/Projects/Wallet-Watch/Data/Import/grabpay_reviews_import.csv'
DELIMITER ','
CSV HEADER;

COPY reviews
(
    review_user_id,
    app_id,
    app_version,
    rating,
    review_text,
    review_source,
    language,
    sentiment,
    complaint_category,
    developer_reply,
    thumbs_up_count,
    review_date,
    developer_reply_date,
    positive_review,
    negative_review
)
FROM 'E:/Projects/Wallet-Watch/Data/Import/shopeepay_reviews_import.csv'
DELIMITER ','
CSV HEADER;