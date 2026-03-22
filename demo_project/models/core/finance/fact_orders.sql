-- Creating dbt incremental model to load new rows only, avoid full refreshes, and keep fact table lean

{{ config(
    materialized = 'incremental',
    unique_key   = 'order_id'
) }}

select
    order_id,
    order_date,
    customer_id,
    order_amount,
    status,
    updated_at
from {{ ref('stg_orders') }}

{% if is_incremental() %}
-- On incremental runs, only select new orders with order_id greater than the max in the existing fact table.
-- This logic assumes order_id is monotonically increasing and does not handle late-arriving or updated records.
where order_id > (
    select coalesce(max(order_id), 0)
    from {{ this }}
)
{% endif %}