{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

with orders as (
    select * from {{ ref('orders') }}
),

sales_by_date as (
    select
        order_date,
        sum(amount) as sales
    from orders
    group by order_date
)

select * from sales_by_date
