{{ config(materialized='view') }}

SELECT
    rx_id,
    member_id,
    fill_date,
    extract(year from fill_date) as service_year,
    ndc_code,
    drug_name,
    quantity,
    claim_amount
FROM {{ ref("stg_pharmacy_claims") }}