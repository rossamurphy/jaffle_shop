{{
config(materialized='table')
}}

with sales_data as (
    select
        order_date,
        sum(amount) as total_sales
    from {{ ref('orders') }}
    group by order_date
)

select * from sales_data