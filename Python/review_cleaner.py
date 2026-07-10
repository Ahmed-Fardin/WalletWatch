"""
WalletWatch

Purpose:
Clean raw review datasets by removing unnecessary columns,
renaming fields, standardizing formats, and preparing data
for PostgreSQL import.

Input:
Data/Raw/

Output:
Data/Clean/

Author:
Fardin Ahmed
"""


import pandas as pd

# ==========================================
# CONFIGURATION
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

positive_keywords = [
    "good",
    "great",
    "excellent",
    "easy",
    "fast",
    "love",
    "best",
    "smooth",
    "secure",
    "convenient"
]

negative_keywords = [
    "bad",
    "error",
    "slow",
    "problem",
    "issue",
    "crash",
    "bug",
    "failed",
    "worst",
    "refund"
]


# ==========================================
# GRABPAY FILTERING
# ==========================================

grab_exclude_keywords = [
    "grabfood",
    "grab food",
    "grabcar",
    "grab car",
    "grabexpress",
    "grab express",
    "grabmart",
    "grab mart",
    "restaurant",
    "driver",
    "ride",
    "delivery",
    "parcel",
    "food order",
    "merchant delivery"
]

# ==========================================
# SHOPEEPAY FILTERING
# ==========================================
shopee_exclude_keywords = [
    "seller",
    "shopping",
    "parcel",
    "delivery",
    "shipping",
    "product",
    "products",
    "order",
    "orders",
    "shop",
    "live stream",
    "shopee live",
    "courier",
    "logistics",
    "wishlist"
]

# ==========================================
# CLEAN EACH WALLET
# ==========================================

for wallet in WALLETS:

    print("=" * 60)
    print(f"Cleaning {wallet}...")
    print("=" * 60)

    # -----------------------------
    # Load Dataset
    # -----------------------------

    df = pd.read_csv(
        f"Data/Raw/{wallet.lower()}_google_play_raw.csv"
    )


    df["content"] = df["content"].fillna("")
    df=df[df["content"].str.strip() != ""]



    # -----------------------------
# GrabPay Filtering
# -----------------------------

    if wallet == "GrabPay":

     df = df[
        ~df["content"].str.lower().apply(
            lambda x: any(word in x for word in grab_exclude_keywords)
        )
    ]

# -----------------------------
# ShopeePay Filtering
# -----------------------------

    if wallet == "ShopeePay":

     df = df[
        ~df["content"].str.lower().apply(
            lambda x: any(word in x for word in shopee_exclude_keywords)
        )
    ]

    # -----------------------------
    # Dataset Information
    # -----------------------------

    

    print("\nRows:", len(df))
    print("Columns:", len(df.columns))

        

    print("\nMissing Values:")
    print(df.isnull().sum())

    print("\nDuplicate Rows:")
    print(df.duplicated().sum())

    print("\nEmpty Review Text:")
    print((df["content"].str.strip() == "").sum())

    # -----------------------------
    # Cleaning
    # -----------------------------

    df = df.drop(columns=["userImage"])

    df = df.rename(
        columns={
            "reviewId": "review_id",
            "userName": "user_name",
            "content": "review_text",
            "score": "rating",
            "thumbsUpCount": "thumbs_up_count",
            "reviewCreatedVersion": "app_version",
            "at": "review_date",
            "replyContent": "developer_reply_text",
            "repliedAt": "developer_reply_date"
        }
    )

    df["review_date"] = pd.to_datetime(df["review_date"])

    
    df["developer_reply"] = df["developer_reply_text"].notna()

    if "appVersion" in df.columns:
        df = df.drop(columns=["appVersion"])

    # -----------------------------
    # Statistics
    # -----------------------------

    

    print("\nAverage Rating:")
    print(round(df["rating"].mean(), 2))

    df["review_length"] = df["review_text"].str.len()

    print("\nAverage Review Length:")
    print(round(df["review_length"].mean(), 2))

    longest_review = df.loc[df["review_length"].idxmax()]

    rating_counts = df["rating"].value_counts().sort_index()

   
    # -----------------------------
    # Sentiment Flags
    # -----------------------------

    df["positive_review"] = df["review_text"].fillna("").str.lower().apply(
    lambda x: any(word in x for word in positive_keywords)
)

    df["negative_review"] = df["review_text"].fillna("").str.lower().apply(
    lambda x: any(word in x for word in negative_keywords)
)

    print("\nPositive Review Count:")
    print(df["positive_review"].sum())

    print("\nNegative Review Count:")
    print(df["negative_review"].sum())

    # -----------------------------
    # Save Clean Dataset
    # -----------------------------

    output_file = f"Data/Clean/{wallet.lower()}_google_play_clean.csv"
 
    print("Saving:", output_file)
    print("Rows to save:", len(df))

    df.to_csv(
        output_file,
        index=False,
        encoding="utf-8-sig"
    )


print("\n====================================")
print("All wallets cleaned successfully!")
print("====================================")

print(f"Saved to: {output_file}\n")