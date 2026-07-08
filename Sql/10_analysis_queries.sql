Select Count(*) as total_transactions
  From transactions;

Select 
Sum(amount) as total_amount,
Count(*) as total_transactions
From transactions;


-- Average Transaction

SELECT
ROUND(AVG(amount),2) AS average_amount
FROM transactions;


-- Minimum and Maximum

SELECT
MIN(amount) AS minimum_amount,
MAX(amount) AS maximum_amount
FROM transactions;


SELECT
a.app_name,
COUNT(*) AS total_transactions
FROM transactions t
JOIN apps a
ON t.app_id = a.app_id
GROUP BY a.app_name
ORDER BY total_transactions DESC;


-- Transactions by Status

SELECT
status,
COUNT(*) AS total_transactions
FROM transactions
GROUP BY status
ORDER BY total_transactions DESC;



-- Total Amount by Wallet

SELECT
a.app_name,
ROUND(SUM(t.amount),2) AS total_amount
FROM transactions t
JOIN apps a
ON t.app_id = a.app_id
GROUP BY a.app_name
ORDER BY total_amount DESC;



-- Average Transaction by Wallet

SELECT
a.app_name,
ROUND(AVG(t.amount),2) AS average_amount
FROM transactions t
JOIN apps a
ON t.app_id = a.app_id
GROUP BY a.app_name
ORDER BY average_amount DESC;



-- Transactions by Payment Method

SELECT
payment_method,
COUNT(*) AS total_transactions
FROM transactions
GROUP BY payment_method
ORDER BY total_transactions DESC;




-- Total Cashback

SELECT
ROUND(SUM(cashback),2) AS total_cashback
FROM transactions;




-- Total Reward Points

SELECT
SUM(reward_points) AS total_reward_points
FROM transactions;



-- Top 10 Merchants

SELECT
m.merchant_name,
COUNT(*) AS total_transactions
FROM transactions t
JOIN merchants m
ON t.merchant_id = m.merchant_id
GROUP BY m.merchant_name
ORDER BY total_transactions DESC
LIMIT 10;



-- Transaction Types

SELECT
transaction_type,
COUNT(*) AS total_transactions
FROM transactions
GROUP BY transaction_type
ORDER BY total_transactions DESC;



-- Highest Transaction

SELECT *
FROM transactions
ORDER BY amount DESC
LIMIT 1;




-- Lowest Transaction

SELECT *
FROM transactions
ORDER BY amount ASC
LIMIT 1;


-- Monthly Transaction Trend

SELECT
DATE_TRUNC('month', transaction_date) AS month,
COUNT(*) AS total_transactions
FROM transactions
GROUP BY month
ORDER BY month;



-- Monthly Revenue

SELECT
DATE_TRUNC('month', transaction_date) AS month,
ROUND(SUM(amount),2) AS total_revenue
FROM transactions
GROUP BY month
ORDER BY month;



-- Wallet Market Share

SELECT
a.app_name,
COUNT(*) AS transactions,
ROUND(
COUNT(*) * 100.0 /
SUM(COUNT(*)) OVER (),
2
) AS market_share_percentage
FROM transactions t
JOIN apps a
ON t.app_id = a.app_id
GROUP BY a.app_name
ORDER BY market_share_percentage DESC;



-- Top 10 Spending Users

SELECT
u.username,
ROUND(SUM(t.amount),2) AS total_spent
FROM transactions t
JOIN users u
ON t.user_id = u.user_id
GROUP BY u.username
ORDER BY total_spent DESC
LIMIT 10;




-- Top Cashback Earners

SELECT
u.username,
ROUND(SUM(t.cashback),2) AS total_cashback
FROM transactions t
JOIN users u
ON t.user_id = u.user_id
GROUP BY u.username
ORDER BY total_cashback DESC
LIMIT 10;



-- Average Spending per Merchant

SELECT
m.merchant_name,
ROUND(AVG(t.amount),2) AS average_spending
FROM transactions t
JOIN merchants m
ON t.merchant_id = m.merchant_id
GROUP BY m.merchant_name
ORDER BY average_spending DESC;




-- Wallet Success Rate

SELECT
a.app_name,
COUNT(*) FILTER (WHERE status = 'Success') AS successful_transactions,
COUNT(*) AS total_transactions,
ROUND(
COUNT(*) FILTER (WHERE status = 'Success') * 100.0 /
COUNT(*),
2
) AS success_rate
FROM transactions t
JOIN apps a
ON t.app_id = a.app_id
GROUP BY a.app_name
ORDER BY success_rate DESC;



-- Merchant Revenue

SELECT
m.merchant_name,
ROUND(SUM(t.amount),2) AS revenue
FROM transactions t
JOIN merchants m
ON t.merchant_id = m.merchant_id
GROUP BY m.merchant_name
ORDER BY revenue DESC;



-- Daily Transactions

SELECT
transaction_date,
COUNT(*) AS total_transactions
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date;



-- Dashboard KPI

SELECT
COUNT(*) AS total_transactions,
ROUND(SUM(amount),2) AS total_revenue,
ROUND(AVG(amount),2) AS average_transaction,
ROUND(SUM(cashback),2) AS total_cashback
FROM transactions;



-- Wallet Revenue Ranking

SELECT
a.app_name,
ROUND(SUM(t.amount),2) AS revenue,
RANK() OVER (
ORDER BY SUM(t.amount) DESC
) AS revenue_rank
FROM transactions t
JOIN apps a
ON t.app_id = a.app_id
GROUP BY a.app_name;




SELECT
m.merchant_name,
ROUND(SUM(amount),2) AS revenue,
RANK() OVER(
ORDER BY SUM(amount) DESC
) AS merchant_rank
FROM transactions t
JOIN merchants m
ON t.merchant_id = m.merchant_id
GROUP BY m.merchant_name;




SELECT
CASE
WHEN EXTRACT(DOW FROM transaction_date) IN (0,6)
THEN 'Weekend'
ELSE 'Weekday'
END AS day_type,

ROUND(SUM(amount),2) AS total_amount

FROM transactions

GROUP BY day_type;



SELECT
DATE_TRUNC('month',transaction_date) AS month,
ROUND(SUM(cashback),2) AS cashback
FROM transactions
GROUP BY month
ORDER BY month;




SELECT
a.app_name,

COUNT(*) FILTER
(WHERE status='Failed') AS failed,

COUNT(*) AS total,

ROUND(
COUNT(*) FILTER (WHERE status='Failed')
*100.0
/
COUNT(*),2
) AS failure_rate

FROM transactions t

JOIN apps a
ON t.app_id=a.app_id

GROUP BY a.app_name;




SELECT
transaction_date,
ROUND(SUM(amount),2) AS revenue
FROM transactions
GROUP BY transaction_date
ORDER BY revenue DESC
LIMIT 1;




SELECT
a.app_name,

COUNT(*) AS transactions,

ROUND(SUM(amount),2) AS revenue,

ROUND(AVG(amount),2) AS average_amount

FROM transactions t

JOIN apps a
ON t.app_id=a.app_id

GROUP BY a.app_name;





SELECT
a.app_name,
payment_method,
COUNT(*) AS total
FROM transactions t

JOIN apps a
ON t.app_id=a.app_id

GROUP BY
a.app_name,
payment_method

ORDER BY
a.app_name,
total DESC;




SELECT

DATE_TRUNC('month',transaction_date) AS month,

ROUND(

COUNT(*) FILTER
(WHERE status='Success')
*100.0
/
COUNT(*),2

) AS success_rate

FROM transactions

GROUP BY month

ORDER BY month;





SELECT

COUNT(*) AS total_transactions,

ROUND(SUM(amount),2) AS revenue,

ROUND(AVG(amount),2) AS average_transaction,

ROUND(SUM(cashback),2) AS cashback,

SUM(reward_points) AS reward_points

FROM transactions;



-- Users Using Multiple Wallets

SELECT
u.username,
COUNT(DISTINCT a.app_name) AS wallets_used
FROM transactions t
JOIN users u
ON t.user_id = u.user_id
JOIN apps a
ON t.app_id = a.app_id
GROUP BY u.username
HAVING COUNT(DISTINCT a.app_name) > 1
ORDER BY wallets_used DESC;




SELECT
u.username,
a.app_name,
COUNT(*) AS usage_count
FROM transactions t
JOIN users u
ON t.user_id=u.user_id
JOIN apps a
ON t.app_id=a.app_id
GROUP BY
u.username,
a.app_name
ORDER BY
u.username,
usage_count DESC;





SELECT
u.username,
COUNT(DISTINCT payment_method) AS payment_methods_used
FROM transactions t
JOIN users u
ON t.user_id=u.user_id
GROUP BY u.username
ORDER BY payment_methods_used DESC;





SELECT
m.merchant_name,
COUNT(DISTINCT a.app_name) AS wallets_supported
FROM transactions t
JOIN merchants m
ON t.merchant_id=m.merchant_id
JOIN apps a
ON t.app_id=a.app_id
GROUP BY m.merchant_name
ORDER BY wallets_supported DESC;




SELECT
u.username,
COUNT(*) AS failed_transactions
FROM transactions t
JOIN users u
ON t.user_id=u.user_id
WHERE status='Failed'
GROUP BY u.username
ORDER BY failed_transactions DESC;




SELECT
a.app_name,
payment_method,
COUNT(*) AS usage
FROM transactions t
JOIN apps a
ON t.app_id=a.app_id
GROUP BY
a.app_name,
payment_method
ORDER BY
a.app_name,
usage DESC;



SELECT
a.app_name,
ROUND(AVG(cashback),2) AS average_cashback
FROM transactions t
JOIN apps a
ON t.app_id=a.app_id
GROUP BY a.app_name
ORDER BY average_cashback DESC;



SELECT
u.username,
COUNT(*) AS total_transactions
FROM transactions t
JOIN users u
ON t.user_id=u.user_id
GROUP BY u.username
ORDER BY total_transactions DESC
LIMIT 10;




SELECT
m.merchant_name,
STRING_AGG(DISTINCT a.app_name, ', ') AS wallets
FROM transactions t
JOIN merchants m
ON t.merchant_id=m.merchant_id
JOIN apps a
ON t.app_id=a.app_id
GROUP BY m.merchant_name;




SELECT
u.username,

COUNT(DISTINCT app_id) AS wallet_diversity,

COUNT(DISTINCT payment_method) AS payment_diversity,

COUNT(*) AS total_transactions

FROM transactions t

JOIN users u
ON t.user_id=u.user_id

GROUP BY u.username

ORDER BY wallet_diversity DESC,
payment_diversity DESC;



-- User Loyalty Score

SELECT
u.username,
COUNT(*) AS total_transactions,
ROUND(SUM(amount),2) AS total_spent,
ROUND(AVG(amount),2) AS average_spent
FROM transactions t
JOIN users u
ON t.user_id=u.user_id
GROUP BY u.username
ORDER BY total_transactions DESC;



SELECT

a.app_name,

COUNT(*) AS transactions,

ROUND(

COUNT(*)*100.0/

SUM(COUNT(*)) OVER(),

2

) AS percentage

FROM transactions t

JOIN apps a
ON t.app_id=a.app_id

GROUP BY a.app_name

ORDER BY percentage DESC;




SELECT

m.merchant_name,

ROUND(SUM(amount),2) AS revenue,

COUNT(*) AS transactions,

ROUND(AVG(amount),2) AS average_sale

FROM transactions t

JOIN merchants m
ON t.merchant_id=m.merchant_id

GROUP BY m.merchant_name

ORDER BY revenue DESC;




SELECT

a.app_name,

transaction_type,

COUNT(*) AS usage

FROM transactions t

JOIN apps a
ON t.app_id=a.app_id

GROUP BY

a.app_name,

transaction_type

ORDER BY

a.app_name,

usage DESC;



SELECT

COUNT(*) AS transactions,

COUNT(DISTINCT user_id)
AS users,

COUNT(DISTINCT app_id)
AS wallets,

COUNT(DISTINCT merchant_id)
AS merchants,

ROUND(SUM(amount),2)
AS revenue

FROM transactions;




SELECT

a.app_name,

COUNT(*) AS transactions,

ROUND(SUM(amount),2) AS revenue,

ROUND(AVG(amount),2) AS average_transaction,

ROUND(SUM(cashback),2) AS cashback,

COUNT(DISTINCT user_id) AS active_users,

COUNT(DISTINCT merchant_id) AS active_merchants

FROM transactions t

JOIN apps a

ON t.app_id=a.app_id

GROUP BY a.app_name

ORDER BY revenue DESC;



-- ==========================================
-- REVIEW ANALYSIS
-- ==========================================


-- Total Reviews

SELECT
COUNT(*) AS total_reviews
FROM reviews;


-- Average Rating

SELECT
ROUND(AVG(rating),2) AS average_rating
FROM reviews;



-- Reviews by Wallet

SELECT
a.app_name,
COUNT(*) AS total_reviews
FROM reviews r

JOIN apps a
ON r.app_id = a.app_id

GROUP BY a.app_name

ORDER BY total_reviews DESC;




-- Average Rating by Wallet

SELECT
a.app_name,

ROUND(
AVG(r.rating),
2
) AS average_rating

FROM reviews r

JOIN apps a
ON r.app_id = a.app_id

GROUP BY a.app_name

ORDER BY average_rating DESC;



-- Rating Distribution

SELECT
rating,
COUNT(*) AS total_reviews
FROM reviews
GROUP BY rating
ORDER BY rating;



-- Positive vs Negative Reviews

SELECT

SUM(
CASE
WHEN positive_review THEN 1
ELSE 0
END
) AS positive_reviews,

SUM(
CASE
WHEN negative_review THEN 1
ELSE 0
END
) AS negative_reviews

FROM reviews;



-- Sentiment Distribution

SELECT

sentiment,

COUNT(*) AS total_reviews

FROM reviews

GROUP BY sentiment

ORDER BY total_reviews DESC;



-- Developer Reply Rate

SELECT

COUNT(*) FILTER
(WHERE developer_reply = TRUE)
AS replied_reviews,

COUNT(*) AS total_reviews,

ROUND(

COUNT(*) FILTER
(WHERE developer_reply = TRUE)
*100.0
/
COUNT(*),

2

) AS reply_rate

FROM reviews;


-- Developer Reply Rate by Wallet

SELECT

a.app_name,

COUNT(*) FILTER
(WHERE developer_reply = TRUE)
AS replied_reviews,

COUNT(*) AS total_reviews,

ROUND(

COUNT(*) FILTER
(WHERE developer_reply = TRUE)
*100.0
/
COUNT(*),

2

) AS reply_rate

FROM reviews r

JOIN apps a
ON r.app_id = a.app_id

GROUP BY a.app_name

ORDER BY reply_rate DESC;



-- Complaint Categories

SELECT
complaint_category,
COUNT(*) AS total_reviews
FROM reviews
GROUP BY complaint_category
ORDER BY total_reviews DESC;



-- Average Rating by Complaint Category

SELECT
complaint_category,
ROUND(AVG(rating),2) AS average_rating,
COUNT(*) AS total_reviews
FROM reviews
GROUP BY complaint_category
ORDER BY average_rating DESC;




-- Monthly Review Trend

SELECT
DATE_TRUNC('month', review_date) AS month,
COUNT(*) AS total_reviews
FROM reviews
GROUP BY month
ORDER BY month;



-- Monthly Average Rating

SELECT
DATE_TRUNC('month', review_date) AS month,
ROUND(AVG(rating),2) AS average_rating
FROM reviews
GROUP BY month
ORDER BY month;



-- Review Dashboard KPIs

SELECT
COUNT(*) AS total_reviews,
ROUND(AVG(rating),2) AS average_rating,
COUNT(*) FILTER (WHERE positive_review = TRUE) AS positive_reviews,
COUNT(*) FILTER (WHERE negative_review = TRUE) AS negative_reviews,
COUNT(*) FILTER (WHERE developer_reply = TRUE) AS replied_reviews
FROM reviews;


-- Highest Rated Wallet

SELECT
a.app_name,
ROUND(AVG(r.rating),2) AS average_rating,
COUNT(*) AS total_reviews
FROM reviews r
JOIN apps a
ON r.app_id = a.app_id
GROUP BY a.app_name
ORDER BY average_rating DESC
LIMIT 1;


-- Lowest Rated Wallet

SELECT
a.app_name,
ROUND(AVG(r.rating),2) AS average_rating,
COUNT(*) AS total_reviews
FROM reviews r
JOIN apps a
ON r.app_id = a.app_id
GROUP BY a.app_name
ORDER BY average_rating ASC
LIMIT 1;


-- Rating Breakdown by Wallet

SELECT
a.app_name,
r.rating,
COUNT(*) AS total_reviews
FROM reviews r
JOIN apps a
ON r.app_id = a.app_id
GROUP BY
a.app_name,
r.rating
ORDER BY
a.app_name,
r.rating;


-- Top 10 Most Active Reviewers

SELECT
ru.username,
COUNT(*) AS total_reviews
FROM reviews r
JOIN review_users ru
ON r.review_user_id = ru.review_user_id
GROUP BY ru.username
ORDER BY total_reviews DESC
LIMIT 10;



-- Review Summary by Wallet

SELECT
a.app_name,
COUNT(*) AS total_reviews,
ROUND(AVG(r.rating),2) AS average_rating,
COUNT(*) FILTER (WHERE positive_review = TRUE) AS positive_reviews,
COUNT(*) FILTER (WHERE negative_review = TRUE) AS negative_reviews,
COUNT(*) FILTER (WHERE developer_reply = TRUE) AS developer_replies
FROM reviews r
JOIN apps a
ON r.app_id = a.app_id
GROUP BY a.app_name
ORDER BY average_rating DESC;



-- Sentiment by Wallet

SELECT
    a.app_name,
    r.sentiment,
    COUNT(*) AS total_reviews
FROM reviews r
JOIN apps a
ON r.app_id = a.app_id
GROUP BY
    a.app_name,
    r.sentiment
ORDER BY
    a.app_name,
    total_reviews DESC;


-- Review Source Distribution

SELECT
    review_source,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY review_source
ORDER BY total_reviews DESC;


-- Top Reviewed Wallet

SELECT
    a.app_name,
    COUNT(*) AS total_reviews
FROM reviews r
JOIN apps a
ON r.app_id = a.app_id
GROUP BY a.app_name
ORDER BY total_reviews DESC
LIMIT 1;


-- Review Percentage by Wallet

SELECT
    a.app_name,
    COUNT(*) AS total_reviews,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS review_percentage
FROM reviews r
JOIN apps a
ON r.app_id = a.app_id
GROUP BY a.app_name
ORDER BY review_percentage DESC;



-- Complete Review Statistics by Wallet

SELECT
    a.app_name,
    COUNT(*) AS total_reviews,
    ROUND(AVG(r.rating),2) AS average_rating,
    MIN(r.rating) AS minimum_rating,
    MAX(r.rating) AS maximum_rating,
    COUNT(*) FILTER (WHERE developer_reply = TRUE) AS developer_replies
FROM reviews r
JOIN apps a
ON r.app_id = a.app_id
GROUP BY a.app_name
ORDER BY average_rating DESC;


-- Wallet Rating Ranking

SELECT

a.app_name,

ROUND(AVG(r.rating),2) AS average_rating,

RANK() OVER(
ORDER BY AVG(r.rating) DESC
) AS rating_rank

FROM reviews r

JOIN apps a
ON r.app_id=a.app_id

GROUP BY a.app_name;

-- Most Positive Wallet

SELECT

a.app_name,

COUNT(*) FILTER
(WHERE positive_review=TRUE)
AS positive_reviews

FROM reviews r

JOIN apps a
ON r.app_id=a.app_id

GROUP BY a.app_name

ORDER BY positive_reviews DESC;


-- Most Negative Wallet

SELECT

a.app_name,

COUNT(*) FILTER
(WHERE negative_review=TRUE)
AS negative_reviews

FROM reviews r

JOIN apps a
ON r.app_id=a.app_id

GROUP BY a.app_name

ORDER BY negative_reviews DESC;


-- Daily Review Activity

SELECT

review_date,

COUNT(*) AS total_reviews

FROM reviews

GROUP BY review_date

ORDER BY review_date;


-- Complete Review Overview

SELECT

COUNT(*) AS total_reviews,

ROUND(AVG(rating),2) AS average_rating,

COUNT(DISTINCT app_id) AS wallets,

COUNT(DISTINCT review_user_id) AS review_users,

COUNT(*) FILTER
(WHERE developer_reply=TRUE)
AS replied_reviews,

COUNT(*) FILTER
(WHERE positive_review=TRUE)
AS positive_reviews,

COUNT(*) FILTER
(WHERE negative_review=TRUE)
AS negative_reviews

FROM reviews;