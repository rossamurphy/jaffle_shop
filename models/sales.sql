{{
    config(
        materialized='view'
    )
}}

with payments as (
    select * from {{ ref('stg_payments') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
)

select
    payments.payment_id,
    payments.order_id,
    payments.payment_method,
    payments.amount,
    orders.customer_id,
    orders.order_date,
    orders.status
from payments
join orders
    on payments.order_id = orders.order_id