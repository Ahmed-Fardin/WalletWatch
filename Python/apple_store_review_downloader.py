from app_store_scraper import AppStore

import pandas as pd

# ===========================================
# WALLETWATCH APPLE REVIEW DOWNLOADER
# ===========================================

APPLE_APPS = {
    "Touch_n_Go": 1344696702,
    "Boost": 1235987570,
    "GrabPay": 647268330,
    "ShopeePay": 6497068994,
    "MAE": 1481028763,
    "BigPay": 1243379690,
    "CIMB_OCTO": 1591184221,
    "Setel": 1441424081
}

app = AppStore(
    country="my",
    app_name="touch-n-go-ewallet",
    app_id=1344696702
)

app.review(
    how_many=10
)

print(len(app.reviews))

print(app.reviews[0])




REVIEW_LIMIT = 500

COUNTRY = "my"


#for wallet, app_id in APPLE_APPS.items():

    #print("=" * 50)
    #print(f"Downloading Apple reviews for {wallet}...")
    #pprint("=" * 50)
