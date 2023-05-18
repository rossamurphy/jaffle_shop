{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

with sales as (
    select * from {{ ref('orders') }}
)

select * from sales