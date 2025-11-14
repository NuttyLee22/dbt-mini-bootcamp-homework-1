with
    source as (
        select
            created_at
            , description
            , difficulty_level
            , haunted_house_id
            , image_url
            , is_active
            , is_featured
            , marketing_name
            , marketing_tagline
            , recommended_for
            , updated_at
        from {{ source('park_assets', 'marketing_haunted_houses') }}
    )

select *
from source