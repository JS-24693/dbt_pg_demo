-- This model calculates the total sales from the stg_orders table
{{ dynamic_total_sales(
    source_relation = ref('fact_orders'), 
    amount_column = 'order_amount'
) }}