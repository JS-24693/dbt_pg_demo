-- Creating dbt incremental model to load new rows only, avoid full refreshes, and keep fact table lean
{{  config(
     materialized = 'incremental',
     unique_key   = 'order_id'
) }}
select
    order_id,
    order_date,
    customer_id,
    order_amount,
    status
from public.raw_orders

{% if is_incremental() %}
-- On incremental run, only take rows with order_id greater than the max already loaded
where order_id > (
   select coalesce(max(order_id), 0) 
   from {{ this }}
)
{% endif %}