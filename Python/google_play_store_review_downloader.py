"""
WalletWatch

Purpose:
Download Google Play reviews for supported Malaysian e-wallet apps.

Input:
Google Play Store

Output:
CSV files saved in Data/Raw/

Author:
Fardin Ahmed
"""


from google_play_scraper import reviews
import pandas as pd
import os

# Wallet App IDs

WALLETS = {
    "Touch_n_Go": "my.com.tngdigital.ewallet",
    "Boost": "my.com.myboost",
    "GrabPay": "com.grabtaxi.passenger",
    "ShopeePay": "com.shopee.my",
    "MAE": "com.maybank2u.life",
    "BigPay": "com.tpaay.bigpay",
    "CIMB_OCTO": "com.cimb.cimbocto",
    "Setel": "com.setel.mobile"
}


TARGET_WALLET = "Touch_n_Go"

LANGUAGE = "en"
COUNTRY = "my"

# Number of reviews to download

REVIEW_LIMIT = 500# Number of reviews to download

REVIEW_LIMIT = 500

for wallet_name, app_id in WALLETS.items():

    print(f"\nDownloading {wallet_name}...")

    result, continuation_token = reviews(
        app_id,
        lang=LANGUAGE,
        country=COUNTRY,
        count=REVIEW_LIMIT
    )

    df = pd.DataFrame(result)

    filename = f"Data/Raw/{wallet_name.lower()}_google_play_raw.csv"

    df.to_csv(
        filename,
        index=False,
        encoding="utf-8-sig"
    )

    print(f"Saved {len(df)} reviews to {filename}")


df = pd.DataFrame(result)

print(df.head())
print(df.tail())

print(df.columns)

print(f"\nTotal Reviews Downloaded: {len(df)}")

# Create folder if it doesn't exist
os.makedirs(f"../Data/Raw/_Raw_Reviews/{TARGET_WALLET}", exist_ok=True)

# Save CSV
df.to_csv(
    f"Data/Raw/{TARGET_WALLET.lower()}_google_play_raw.csv",
    index=False,
    encoding="utf-8-sig"
)

print("\nCSV saved successfully!")