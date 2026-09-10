{{ config(
    database='dbt-datalake',
    schema='bronze_jaffle_orders'
) }}

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from {{ source('jaffle_shop', 'orders') }}