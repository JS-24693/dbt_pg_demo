-- Snapshot of customer records using timestamp strategy to track historical changes
-- Captures new versions of a customer whenever the `updated_at` field changes

{% snapshot dim_customers %}

{{
    config(
        target_schema ='snapshots',
        unique_key ='customer_id',
        strategy ='timestamp',
        updated_at ='updated_at'
    )
}}
    
SELECT
    customer_id,
    customer_name,
    city,
    updated_at
FROM {{ ref('stg_customers') }}

{% endsnapshot %}