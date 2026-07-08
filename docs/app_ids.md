# WalletWatch App IDs

This document stores the official Google Play App IDs used for downloading reviews for the WalletWatch project.

---

## Google Play App IDs

| Wallet | Google Play App ID | Status | Notes |
|--------|---------------------|--------|-------|
| Touch 'n Go eWallet | `my.com.tngdigital.ewallet` | ✅ Verified | Downloaded successfully |
| Boost | `my.com.myboost` | ⏳ Pending | Not downloaded yet |
| GrabPay | `com.grabtaxi.passenger` | ⏳ Pending | Filter only GrabPay-related reviews |
| ShopeePay | `com.shopee.my` | ⏳ Pending | Filter only ShopeePay-related reviews |
| MAE | `com.maybank2u.life` | ⏳ Pending | Not downloaded yet |
| BigPay | `com.tpaay.bigpay` | ⏳ Pending | Not downloaded yet |
| CIMB OCTO | `com.cimb.cimbocto` | ⏳ Pending | Not downloaded yet |
| Setel | `com.setel.mobile` | ⏳ Pending | Not downloaded yet |



# Apple App Store IDs

| Wallet | Apple App Store ID | Status |
|--------|---------------------|--------|
| Touch 'n Go eWallet | | 1344696702|
| Boost | | 1235987570 |
| GrabPay | | 647268330 |
| ShopeePay | | 6497068994 |
| MAE | | 1481028763|
| BigPay | | 1243379690 |
| CIMB OCTO | | 1591184221 |
| Setel | | 1441424081|

---

## Notes

### Google Play
- Uses package names (e.g. `my.com.tngdigital.ewallet`).

### Apple App Store
- Uses numeric App IDs (e.g. `1344696702`).

---

## Review Collection Notes

### Touch 'n Go
- Download all reviews.
- No filtering required.

### Boost
- Download all reviews.
- No filtering required.

### MAE
- Download all reviews.
- No filtering required.

### BigPay
- Download all reviews.
- No filtering required.

### CIMB OCTO
- Download all reviews.
- No filtering required.

### Setel
- Download all reviews.
- No filtering required.

### GrabPay
Download all reviews first, then filter to keep only reviews related to:
- GrabPay
- Wallet
- QR Payments
- Top Up
- Transfers
- Cashless Payments

Remove reviews related to:
- GrabFood
- GrabCar
- GrabMart
- Drivers
- Deliveries
- Restaurants
- Ride Booking

### ShopeePay
Download all reviews first, then filter to keep only reviews related to:
- ShopeePay
- Wallet
- QR Payments
- Balance
- Transfers
- Top Up
- Cashback

Remove reviews related to:
- Shopping
- Sellers
- Products
- Parcels
- Delivery
- Shopee Live
- Orders

---

## Download Order

1. ✅ Touch 'n Go
2. ⏳ Boost
3. ⏳ BigPay
4. ⏳ MAE
5. ⏳ CIMB OCTO
6. ⏳ Setel
7. ⏳ GrabPay
8. ⏳ ShopeePay

---

## Project Rule

Always keep the raw downloaded reviews unchanged.

Pipeline:

Raw Reviews
↓
Cleaning Script
↓
Filtered Dataset
↓
PostgreSQL
↓
Power BI Dashboard