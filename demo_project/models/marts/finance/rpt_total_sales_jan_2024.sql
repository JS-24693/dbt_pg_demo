{{ dynamic_total_sales(
    source_relation = ref('fact_orders'),
    amount_column   = 'order_amount',
    where_clause    = "order_date >= '2024-01-01' AND order_date < '2024-02-01'"
) }}