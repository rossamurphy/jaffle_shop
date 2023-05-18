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
)

select
    o.*,
    p.*
from orders o
join payments p
    on o.order_id = p.order_id