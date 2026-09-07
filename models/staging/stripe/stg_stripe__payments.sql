select

    orderid as order_id,
    paymentmethod as payment_method,
    status,
    amount,
    created as date
    

from dbt-tutorial.stripe.payment