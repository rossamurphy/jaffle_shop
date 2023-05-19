{% set order_count_query %}
SELECT COUNT(order_id) as order_count
FROM {{ ref('orders') }}
{% endset %}
SELECT * FROM ({{ order_count_query }}) as order_count_subquery