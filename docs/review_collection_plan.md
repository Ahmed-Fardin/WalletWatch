# WalletWatch Review Collection Plan

## Project Objective

The objective of this review dataset is to analyze customer opinions, ratings, complaints, feature requests, and user satisfaction for the most popular e-wallets in Malaysia. The dataset will later be cleaned, stored in PostgreSQL, analyzed using SQL, and visualized in Power BI.

---

# Primary Focus

Malaysia

---

# Target E-Wallets

- Touch 'n Go eWallet
- GrabPay
- ShopeePay
- Boost
- MAE
- BigPay
- CIMB OCTO
- Setel

---

# Future Expansion

After completing the Malaysian dataset, the project will expand to selected Southeast Asian countries for comparison.

- Singapore
- Indonesia
- Thailand
- Philippines
- Vietnam

The comparison will focus on regional wallet adoption, customer sentiment, and feature differences.

---

# Target Dataset Size

Target Review Count

| Wallet | Reviews |
|----------|---------:|
| Touch 'n Go eWallet | 1,500 |
| GrabPay | 1,500 |
| ShopeePay | 1,500 |
| Boost | 1,000 |
| MAE | 1,000 |
| BigPay | 800 |
| CIMB OCTO | 600 |
| Setel | 600 |

Estimated Total

8,500 Reviews

---

# Review Sources

## Google Play Store

Google Play Store will be the primary review source because reviews are easier to collect while preserving their original content and metadata.

The project will collect:

- Rating
- Review Text
- Review Date
- App Version (when available)
- Developer Reply (when available)
- Helpful Votes (when available)

Reviews will be stored exactly as collected before any cleaning process.

---

## Apple App Store

Apple App Store reviews will be collected separately.

If an official export or structured retrieval method is available, reviews will be collected together with available metadata.

If certain metadata is unavailable, only verified fields such as rating, review text, and review date will be included.

The same cleaning and filtering process used for Google Play reviews will also be applied to Apple App Store reviews.

---

## Apple App Store Reviews

- Download using Python.
- Store raw data separately from Google Play.
- Clean using the same standardized schema.
- Merge with Google Play reviews after cleaning.


# Collection Strategy

The project follows a hybrid approach.

## Step 1

Collect reviews from official application marketplaces.

## Step 2

Store all reviews in their original form.

## Step 3

Clean the dataset using Python.

## Step 4

Manually verify the cleaned reviews.

## Step 5

Import the cleaned dataset into PostgreSQL.

## Step 6

Perform SQL analysis.

## Step 7

Build Power BI dashboards.

---

# Review Inclusion Criteria

Only reviews directly related to wallet functionality will be included.

Examples include:

- QR Payments
- Wallet Top-Up
- Transfers
- Bill Payments
- Cashback
- Rewards
- Login
- OTP
- Verification
- Security
- Performance
- User Interface
- Customer Support

---

# Review Exclusion Criteria

## GrabPay

The following reviews will be excluded:

- GrabFood
- GrabCar
- GrabExpress
- GrabMart
- Delivery Issues
- Driver Complaints
- Restaurant Reviews
- Ride Experience

Only reviews discussing GrabPay wallet features will be retained.

---

## ShopeePay

The following reviews will be excluded:

- Seller Complaints
- Product Reviews
- Parcel Delivery
- Shipping
- Shopping Experience
- Order Issues
- Product Refunds unrelated to ShopeePay

Only ShopeePay wallet-related reviews will be retained.

---

# Supported Languages

- English
- Bahasa Malaysia

Additional languages may be included in future Southeast Asia expansion.

---

# Data Cleaning

Python will be used to:

- Remove duplicate reviews
- Remove empty reviews
- Standardize ratings
- Standardize dates
- Clean unnecessary symbols
- Normalize text formatting
- Filter unrelated GrabPay reviews
- Filter unrelated ShopeePay reviews
- Categorize complaints
- Generate sentiment labels

---

# Dataset Columns

Each review record will contain the following fields where available:

- review_id
- app_id
- rating
- review_text
- review_date
- review_source
- language
- sentiment
- complaint_category
- developer_reply
- developer_reply_text
- helpful_votes

---



---

# Apple App Store Review Collection Plan

## Objective

Collect Apple App Store reviews for every WalletWatch application to complement the Google Play dataset.

## Target Wallets

- Touch 'n Go eWallet
- Boost
- BigPay
- MAE
- CIMB OCTO
- Setel
- GrabPay
- ShopeePay

## Collection Method

- Download reviews using a Python App Store scraper.
- Save raw Apple reviews separately from Google Play reviews.
- Apply the same cleaning pipeline used for Google Play.
- Merge both platforms after cleaning.

## Output Structure

Data/

Raw/

- touch_n_go_google_play_raw.csv
- touch_n_go_apple_raw.csv

Clean/

- touch_n_go_google_play_clean.csv
- touch_n_go_apple_clean.csv

## Quality Rules

- Keep raw datasets unchanged.
- Perform all cleaning on copied datasets.
- Maintain identical column names across Google Play and Apple App Store datasets.
- Remove duplicate reviews only after datasets are merged.

## GrabPay & ShopeePay

Apply keyword filtering after cleaning to remove reviews related to:

- Ride Hailing
- Food Delivery
- Shopping
- Parcels
- Merchants

Keep only reviews related to:

- Digital Wallet
- QR Payments
- Top Up
- Balance
- Transfers
- Cashback



## Platform Differences

During project planning, platform availability was verified separately for Android (Google Play) and iOS (Apple App Store).

### ShopeePay

**Google Play (Android)**
- No standalone ShopeePay application was identified.
- ShopeePay functionality is integrated into the main Shopee application.
- Reviews will be collected from the Shopee app and filtered to retain only ShopeePay-related reviews.

**Apple App Store (iOS)**
- A standalone ShopeePay application is available.
- Reviews will be collected directly from the standalone ShopeePay app.
- No shopping-related filtering should be required unless future verification suggests otherwise.

> **Note:** This decision is based on the current availability of applications during the project development period. Future app store changes may require updating the collection strategy.




---

# Apple App Store Downloader Notes

## Library Evaluation

During development, the project initially tested the Python package:

- app-store-scraper (v0.3.5)

### Result

The package failed to execute in the current Python environment because of dependency compatibility issues involving urllib3.

Example error:

ModuleNotFoundError:
No module named 'urllib3.packages.six.moves'

### Decision

Instead of downgrading project dependencies or using an outdated package, the Apple review collection strategy will use a more reliable and actively maintained approach.

Reason:

- Maintain project stability.
- Avoid dependency conflicts.
- Keep the review pipeline maintainable.
- Ensure compatibility with modern Python environments.

This decision was made before implementing the Apple review downloader to prevent future maintenance issues.

# Final Objective

The cleaned review dataset will be integrated with the WalletWatch PostgreSQL database and analyzed together with transaction data.

The final Power BI dashboard will provide insights into:

- Customer Satisfaction
- Wallet Ratings
- Common Complaints
- Feature Requests
- Sentiment Distribution
- Wallet Comparison
- Cross-country Comparison (Future Phase)