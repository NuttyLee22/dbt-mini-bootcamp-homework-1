with
    source as (
        select
            base_inventory_level
            , base_price
            , category
            , colors
            , cost_price
            , created_at
            , current_inventory
            , description
            , is_active
            , launch_date
            , limited_edition
            , material
            , product_id
            , product_name
            , profit_margin_percent
            , reorder_point
            , seasonal
            , size_options
            , supplier
            , updated_at
        from {{ source('park_assets', 'merchandise_products') }}
    )

select *
from source