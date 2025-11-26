SELECT 
  "rx_id",
  "member_id",
  "fill_date",
  "ndc_code",
  "drug_name",
  "quantity",
  "claim_amount"
FROM 
    {{ source("medadvantage", "pharmacy_claims") }}