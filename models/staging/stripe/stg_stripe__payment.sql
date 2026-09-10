{{ config(
    database='dbt-datalake',
    schema='bronze_stripe_payments'
) }}

with source as (

    select * from {{ source('stripe', 'payment') }}

),

renamed as (

    select
        id,
        orderid as order_id,
        paymentmethod as payment_method,
        status,
        amount / 100 as amount,
        created as created_at,
        _batched_at

    from source

)

select * from renamed