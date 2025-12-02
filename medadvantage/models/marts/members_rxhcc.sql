{{ config(materialized='view') }}

with pharm as (
    select 
        *
    from {{ ref("core_pharmacy_claims") }}
),

rx_map as (
    select 
        *
    from {{ source("medadvantage", "ndc_to_rxhcc") }}
)

select 
    p.member_id,
    p.service_year,
    r.rxhcc_code,
    r.rxhcc_desc,
    r.weight as rxhcc_weight
from pharm p
join rx_map r
    on p.ndc_code = r.ndc_code