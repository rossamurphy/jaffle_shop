with sales as (
    select
        o.*,
        p.AMOUNT
    from {{ ref('orders') }} as o
    join {{ ref('stg_payments') }} as p
        on o.ORDER_ID = p.ORDER_ID
)

select * from sales
