{{
  config(
    materialized='table'
  )
}}

with orders as (
    select
        order_id,
        customer_id,
        order_date
    from {{ ref('stg_orders') }}
),

payments as (
    select
        order_id,
        payment_method,
        amount
    from {{ ref('stg_payments') }}
),

sales as (
    select
        o.order_id,
        o.customer_id,
        o.order_date,
        sum(case when p.payment_method = 'credit_card' then p.amount else 0 end) as credit_card_amount,
        sum(case when p.payment_method = 'coupon' then p.amount else 0 end) as coupon_amount,
        sum(case when p.payment_method = 'bank_transfer' then p.amount else 0 end) as bank_transfer_amount,
        sum(case when p.payment_method = 'gift_card' then p.amount else 0 end) as gift_card_amount
    from orders o
    join payments p on o.order_id = p.order_id
    group by o.order_id, o.customer_id, o.order_date
)

select
    order_id,
    customer_id,
    order_date,
    sum(credit_card_amount) + sum(coupon_amount) + sum(bank_transfer_amount) + sum(gift_card_amount) as total_amount
from sales
group by order_id, customer_id, order_date