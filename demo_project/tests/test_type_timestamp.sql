-- Validates that a column is stored as a timestamp or timestamptz in Postgres.
-- This test ensures type consistency across staging and core models, especially
-- when upstream sources may cast or coerce values differently. 
-- Rows failing this test indicate unexpected type drift or ingestion issues.
-- Rows returned indicate type drift or ingestion issues.

select *
from {{ ref('stg_orders') }}   -- or stg_customers, whichever has updated_at
where pg_typeof(updated_at)::text not in ('timestamp', 'timestamptz')
