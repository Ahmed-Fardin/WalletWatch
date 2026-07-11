"""
WalletWatch

Purpose:
Prepare cleaned review datasets for PostgreSQL by generating
review_user_id values, mapping app IDs, and exporting
import-ready CSV files.

Input:
Data/Clean/

Output:
Data/Import/

Author:
Fardin Ahmed
"""

import pandas as pd

# ==========================================
# WALLETWATCH REVIEW IMPORT PREPARER
# ==========================================

WALLETS = [
    "Touch_n_Go",
    "Boost",
    "BigPay",
    "MAE",
    "CIMB_OCTO",
    "Setel",
    "GrabPay",
    "ShopeePay"
]

APP_IDS = {
    "Touch_n_Go": 1,
    "Boost": 2,
    "BigPay": 3,
    "MAE": 4,
    "CIMB_OCTO": 5,
    "Setel": 6,
    "GrabPay": 7,
    "ShopeePay": 8
}
review_user_counter = 1

review_user_mapping = {}


def classify_complaint(review):

    if pd.isna(review):
        return "None"

    review = review.lower()

    complaint_keywords = {

        "Account Access": [
            "login", "log in", "logged in", "can't login", "cannot login",
            "unable to login", "unable to log in", "password", "pin",
            "otp", "verification code", "verify account",
            "fingerprint", "face id", "biometric", "authentication",
            "can't access", "cannot access", "account locked",
            "sign in", "sign-in", "login failed"
        ],

        "Payment Issues": [
            "payment", "pay", "cannot pay", "can't pay",
            "payment failed", "payment pending",
            "money deducted", "charged", "double charged",
            "qr", "qr payment", "merchant", "checkout",
            "bill payment", "purchase failed"
        ],

        "Transfer Issues": [
            "transfer", "bank transfer", "send money",
            "receive money", "transaction failed",
            "transaction pending", "instant transfer",
            "fund transfer", "cannot transfer"
        ],

        "Performance": [
            "slow", "lag", "laggy", "freeze", "freezing",
            "crash", "crashes", "crashing",
            "stuck", "loading", "buffering",
            "hang", "hanging", "black screen",
            "white screen", "error", "bug", "glitch"
        ],

        "Cashback": [
            "cashback", "cash back",
            "cashback missing",
            "cashback not received",
            "cashback not credited"
        ],

        "Rewards": [
            "reward", "reward points",
            "points", "voucher",
            "bonus", "redeem"
        ],

        "Verification": [
            "verify", "verification",
            "kyc", "identity",
            "documents", "document verification"
        ],

        "Security": [
            "fraud", "hack", "hacked",
            "scam", "unsafe",
            "security", "stolen"
        ],

        "Customer Support": [
            "customer service",
            "customer support",
            "support",
            "help centre",
            "help center",
            "hotline",
            "email support",
            "no response",
            "no reply"
        ],

        "UI / UX": [
            "interface",
            "ui",
            "ux",
            "layout",
            "design",
            "navigation"
        ]
    }

    for category, keywords in complaint_keywords.items():

        if any(keyword in review for keyword in keywords):

            return category

    return "Other"




for wallet in WALLETS:

    print(f"\nPreparing {wallet} for PostgreSQL...")

    df = pd.read_csv(
        f"Data/Clean/{wallet.lower()}_google_play_clean.csv"
    )

    df["app_id"] = APP_IDS[wallet]

    df["review_source"] = "Google Play"

    df["language"] = "English"

    df["sentiment"] = "Neutral"

    df.loc[df["positive_review"], "sentiment"] = "Positive"

    df.loc[df["negative_review"], "sentiment"] = "Negative"

    df["complaint_category"] = "None"

    negative_mask = df["sentiment"] == "Negative"

    df.loc[
        negative_mask,
        "complaint_category"
    ] = df.loc[
        negative_mask,
        "review_text"
    ].apply(classify_complaint)

    review_user_ids = []

    for username in df["user_name"]:

        if username not in review_user_mapping:
            review_user_mapping[username] = review_user_counter
            review_user_counter += 1

        review_user_ids.append(review_user_mapping[username])

    df["review_user_id"] = review_user_ids



    # ==========================================
# Keep only PostgreSQL columns
# ==========================================

    df = df[
        [
            "review_user_id",
            "app_id",
            "app_version",
            "rating",
            "review_text",
            "review_source",
            "language",
            "sentiment",
            "complaint_category",
            "developer_reply",
            "thumbs_up_count",
            "review_date",
            "developer_reply_date",
            "positive_review",
            "negative_review"
        ]
    ]


    output_file = f"Data/Import/{wallet.lower()}_reviews_import.csv"

    df.to_csv(
        output_file,
        index=False,
        encoding="utf-8-sig"
    )



    print(f"Saved: {output_file}")


review_users_df = pd.DataFrame(
    review_user_mapping.items(),
    columns=["username", "review_user_id"]
)

review_users_df = review_users_df[
    ["review_user_id", "username"]
]

review_users_df.to_csv(
    "Data/Import/review_users.csv",
    index=False,
    encoding="utf-8-sig"
)

print("\nReview Users CSV created successfully!")

