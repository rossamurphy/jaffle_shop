{{
    config(
        materialized='table'
    )
}}

with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

joined as (
    select
        o.order_id,
        o.customer_id,
        o.order_date,
        o.status,
        p.payment_method,
        p.amount
    from orders o
    join payments p on o.order_id = p.order_id
),

sales as (
    select
        order_id,
        customer_id,
        order_date,
        status,
        payment_method,
        sum(amount) as total_sales
    from joined
    group by order_id, customer_id, order_date, status, payment_method
)

select * from sales