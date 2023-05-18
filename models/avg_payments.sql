with source as (
    select * from {{ ref('stg_payments') }}
),

grouped_payments as (
    select
        payment_method,
        avg(amount) as average_payment_amount
    from source
    group by payment_method
)

select * from grouped_payments