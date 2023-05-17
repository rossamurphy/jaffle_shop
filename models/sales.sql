{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

with orders as (
    select * from {{ ref('orders') }}
),

sales_agg as (
    select
        order_date,
        sum(amount) as total_amount
    from orders
    group by order_date
)

select * from sales_agg