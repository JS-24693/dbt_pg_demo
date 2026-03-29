{% test updated_at_validation(model, column_name) %}

-- Fail if the column is not a timestamp
select *
from {{ model }}
where pg_typeof({{ column_name }})::text not in (
    'timestamp without time zone',
    'timestamp with time zone'
)

union all

-- Fail if the timestamp is in the future
select *
from {{ model }}
where {{ column_name }} > current_timestamp

{% endtest %}