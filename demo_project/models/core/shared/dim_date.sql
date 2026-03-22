-- dim_date is a canonical date dimension table generated using a daily date spine.
-- It provides a continuous sequence of dates along with commonly used calendar
-- attributes such as year, month, day, quarter, month name, and day name.
-- This dimension supports consistent time‑based filtering, grouping, and reporting
-- across all fact and mart models.

{{ config(materialized='table') }}

with spine as (

    -- Generate a continuous sequence of dates from 2020-01-01 through
    -- current_date + 2 years using Postgres's generate_series.
    select
        generate_series(
            date '2020-01-01',
            current_date + interval '2 years',
            interval '1 day'
        )::date as date_day

),

dates as (

    select
        date_day,
        extract(year from date_day) as year,
        extract(month from date_day) as month,
        extract(day from date_day) as day,
        to_char(date_day, 'Day') as day_name,
        to_char(date_day, 'Month') as month_name,
        extract(quarter from date_day) as quarter
    from spine

)

select *
from dates