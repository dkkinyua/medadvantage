{{ config(materialized='table') }}

with members as (
    select
        *
    from 
        {{ ref("core_members") }}
),

hccs as (
    select
        member_id, service_year, sum(hcc_weight) as hcc_risk
    from
        {{ ref("members_hccs") }}
    group by 1, 2
),

rxhccs as (
    select 
        member_id, service_year, sum(rxhcc_weight) as rxhcc_risk
    from 
        {{ ref("members_rxhcc") }}
    group by 1, 2
)

select 
    m.member_id,
    m.first_name,
    m.last_name,
    m.gender,
    m.age,
    m.plan_id,

    coalesce(h.hcc_risk, 0) as hcc_risk,
    coalesce(r.rxhcc_risk, 0) as rxhcc_risk,
    coalesce(h.hcc_risk, 0) + coalesce(r.rxhcc_risk, 0) as risk_score
from 
    members m
left join hccs h using (member_id, service_year)
left join rxhccs r using (member_id, service_year)