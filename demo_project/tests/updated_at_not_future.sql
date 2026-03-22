-- Ensures that the `updated_at` column never contains future timestamps.
-- This protects incremental models, freshness checks, and SCD logic from
-- invalid or corrupted data that could break ordering, deduplication, or
-- snapshot comparisons. Rows returned here indicate data quality issues
-- in the upstream source system.
select *
from {{ this }}
where updated_at > current_timestamp