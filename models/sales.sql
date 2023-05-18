{{
    config(materialized='table')
}}

with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
)

select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    c.first_name,
    c.last_name,
    p.payment_id,
    p.payment_method,
    p.amount

from orders o
join customers c on o.customer_id = c.customer_id
join payments p on o.order_id = p.order_id