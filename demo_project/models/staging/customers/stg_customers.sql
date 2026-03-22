{{ config(materialized='view') }}

with source as (

    select
        customer_id,
        customer_name,
        city,
        updated_at
    from {{ source('raw', 'raw_customers') }}

)

select
    customer_id,
    customer_name,
    city,
    updated_at
from source