-- pulls the latest version of each customer from the dim_customers table, where dbt_valid_to is null

select
    customer_id,
    customer_name,
    city,
    updated_at
from {{ ref('dim_customers') }}
where dbt_valid_to is null