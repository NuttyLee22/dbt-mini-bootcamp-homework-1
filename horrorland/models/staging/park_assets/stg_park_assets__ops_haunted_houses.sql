with
    source as (
        select
            accessibility_friendly
            , created_at
            , duration_minutes
            , emergency_exits
            , fear_level
            , haunted_house_id
            , house_name
            , house_size_sqft
            , house_status
            , max_capacity_per_group
            , max_daily_capacity
            , min_age_requirement
            , opening_year
            , park_area
            , safety_rating
            , staff_required
            , theme
            , updated_at
        from {{ source('park_assets', 'ops_haunted_houses') }}
    )

select *
from source