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
    "Setel"
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

    # -----------------------------
    # Dataset Information
    # -----------------------------

    print(df.head())

    print("\nRows:", len(df))
    print("Columns:", len(df.columns))

    print("\nColumn Names:")
    print(df.columns)

    print("\nMissing Values:")
    print(df.isnull().sum())

    print("\nDuplicate Rows:")
    print(df.duplicated().sum())

    print("\nEmpty Review Text:")
    print((df["content"].str.strip() == "").sum())

    print("\nRating Distribution:")
    print(df["score"].value_counts().sort_index())

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

    print("\nUpdated Columns:")
    print(df.columns)

    print("\nData Types:")
    print(df.dtypes)

    print("\nAverage Rating:")
    print(round(df["rating"].mean(), 2))

    df["review_length"] = df["review_text"].str.len()

    print("\nAverage Review Length:")
    print(round(df["review_length"].mean(), 2))

    longest_review = df.loc[df["review_length"].idxmax()]

    print("\nLongest Review:")
    print(longest_review["review_text"])

    shortest_review = df.loc[df["review_length"].idxmin()]

    print("\nShortest Review:")
    print(shortest_review["review_text"])

    rating_counts = df["rating"].value_counts().sort_index()

    print("\nRating Counts:")
    print(rating_counts)

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

    df.to_csv(
        output_file,
        index=False,
        encoding="utf-8-sig"
    )

    print(f"\n✅ {wallet} cleaned successfully!")
    print(f"Saved to: {output_file}\n")