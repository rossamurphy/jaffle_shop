{{
    config(materialized='table')
}}

with source as (
    select * from {{ ref('stg_payments') }}
)

select * from source