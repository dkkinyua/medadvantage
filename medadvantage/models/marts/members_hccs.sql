{{ config(materialized='view') }}

with claims as (
    select 
        *
    from {{ ref('core_medical_claims') }}
),

hcc as (
    select 
        *
    from 
        {{ source('medadvantage', "icd_to_hcc") }}
)

select
    c.member_id,
    c.service_year,
    h.hcc_code,
    h.hcc_desc,
    h.weight as hcc_weight
from 
    hcc h
join claims c
    on c.icd10_code = h.icd10_code