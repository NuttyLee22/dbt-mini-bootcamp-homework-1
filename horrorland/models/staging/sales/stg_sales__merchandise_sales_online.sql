with
    source as (
        select
            category
            , created_at
            , customer_id
            , discount_applied
            , haunted_house_id
            , payment_method
            , product_id
            , product_name
            , quantity
            , sale_date
            , sale_id
            , sale_timestamp
            , staff_member
            , {{ cents_to_dollars('total_price') }} AS total_price
            , {{ cents_to_dollars('unit_price') }} AS unit_price
        from {{ source('sales', 'merchandise_sales_online') }}
    )

select *
from source