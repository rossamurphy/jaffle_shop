
{{ config(materialized='table') }}
SELECT *
FROM {{ ref('orders') }} o
JOIN {{ ref('stg_payments') }} p
ON o.order_id = p.order_id
