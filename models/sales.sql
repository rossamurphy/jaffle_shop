{{
    config(materialized='table')
}}

with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

joined_data as (
    select
        o.order_id,
        o.customer_id,
        o.order_date,
        o.status,
        p.payment_id,
        p.payment_method,
        p.amount
    from orders o
    join payments p on o.order_id = p.order_id
),

sales_data as (
    select
        order_id,
        sum(amount) as sales
    from joined_data
    group by order_id
)

select * from sales_data