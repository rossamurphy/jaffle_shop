{{
config(materialized='table')
}}

with sales as (
    select
        order_date,
        sum(credit_card_amount + coupon_amount + bank_transfer_amount + gift_card_amount) as total_sales
    from {{ ref('orders') }}
    group by order_date
)

select * from sales