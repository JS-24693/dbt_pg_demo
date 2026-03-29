-- Calculates total sales by summing a specified numeric column from a given
-- relation. Supports an optional `where_clause` to filter rows before
-- aggregation. Because this macro performs a read-only aggregation, it does
-- not modify or recalculate historical data unless the underlying source
-- relation itself has changed. Useful for building flexible, parameterized
-- metrics across staging, core, and mart models.

{% macro 
dynamic_total_sales(source_relation, amount_column, where_clause=None) %}
    select
        sum({{ amount_column }}) as total_sales
    from {{ source_relation }}
    {% if where_clause is not none %}
        where {{ where_clause }}
    {% endif %}

{% endmacro %}
