-- created an incremental table, that adds deltas rather than complete rebuild. The condition is part of the final select statement
-- unique_key is added if we need to manage duplicates / merging of records
-- incremental_strategy is used to define what type of incremental shall be used (default is insert). Important if updates and expected.
{{
    config(
        materialized='incremental'
    )
}}

with payments as (

select * from {{ ref('stg_stripe__payment') }}

),

orders as (

select * from {{ ref('stg_jaffle_shop__orders') }}

),

final as (

    select
        orders.order_id,
        orders.order_date,
        orders.customer_id,
        payments.amount

    from orders

    left join payments using (order_id)

)

select * from final
{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where order_date > (select max(order_date) from {{ this }}) 
{% endif %}
order by order_date desc