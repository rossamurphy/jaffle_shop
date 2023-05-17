
with daily_sales as (
    select
        order_date,
        count(*) as num_orders
    from {{ ref('orders') }}
    group by order_date
)

select
    avg(num_orders) as avg_sales_per_day
from daily_sales
