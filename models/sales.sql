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
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        customers.first_name,
        customers.last_name,
        payments.payment_id,
        payments.payment_method,
        payments.amount
    from orders
    join customers on orders.customer_id = customers.customer_id
    join payments on orders.order_id = payments.order_id