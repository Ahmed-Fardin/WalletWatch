Import Issue #1 (Resolved)

Problem:
pgAdmin reused an old column mapping during CSV import, causing values to shift into the wrong columns (e.g., app_version imported into app_id).

Solution:
Before importing, open the Columns tab in pgAdmin's Import dialog and ensure the selected columns exactly match the CSV. Remove review_id and created_at id if it is not present in the CSV.