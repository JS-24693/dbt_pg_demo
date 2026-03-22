-- stg_orders provides a cleaned, standardized, and deduplicated version of the raw order data.
-- This model applies consistent naming conventions, casts data types, normalizes status values, and removes duplicate records based on the latest updated_at timestamp.
-- It serves as the single trusted input for downstream fact and reporting models, ensuring that all business logic is built on top of clean, reliable data.

{{ config(materialized='view') }}

with source as (

    select
        order_id,
        customer_id,
        cast(order_date as date) as order_date,
        cast(order_amount as numeric(10,2)) as order_amount,
        lower(status) as status,
        updated_at
    from {{ source('raw', 'raw_orders') }}

),

deduped as (

    select
        *,
        row_number() over (partition by order_id order by updated_at desc) as rn
    from source

)

select
    order_id,
    customer_id,
    order_date,
    order_amount,
    status,
    updated_at
from deduped
where rn = 1