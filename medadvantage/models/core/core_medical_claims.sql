{{ config(materialized='view') }} 

SELECT
    claim_id,
    member_id,
    claim_date,
    extract(year from claim_date) as service_year,
    icd10_code,
    claim_amount,
    provider_id
FROM {{ ref("stg_medical_claims") }}