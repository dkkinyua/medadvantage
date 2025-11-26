SELECT
    claim_id,
    member_id,
    claim_date,
    icd10_code,
    claim_amount,
    provider_id
FROM 
    {{ source("medadvantage", "medical_claims") }}