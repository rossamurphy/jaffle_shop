{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

sales as (
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        payments.payment_method,
        payments.amount,
        sum(payments.amount) over (partition by orders.order_id) as total_amount
    from orders
    join payments
        on orders.order_id = payments.order_id
)

select * from sales