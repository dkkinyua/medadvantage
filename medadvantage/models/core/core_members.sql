{{ config(materialized='view') }}

SELECT
    member_id,
    first_name,
    last_name,
    email,
    gender,
    age,
    plan_id,
    enrollment_start,
    enrollment_end,
    extract(year from enrollment_start) as service_year
FROM {{ ref('stg_members') }}