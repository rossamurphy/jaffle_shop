{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

sales as (
    select
        orders.*,
        sum(payments.amount) as total_amount
    from orders
    join payments
        on orders.order_id = payments.order_id
    group by orders.order_id, orders.customer_id, orders.order_date, orders.status
)

select * from sales