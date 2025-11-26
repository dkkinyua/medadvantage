SELECT
    member_id,
    first_name,
    last_name,
    email,
    gender,
    age,
    plan_id,
    enrollment_start,
    enrollment_end
FROM
    {{ source("medadvantage", "members") }}