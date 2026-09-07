select

    orderid as order_id,
    paymentmethod as payment_method,
    status,
    amount,
    created as date
    

from {{ source('stripe', 'payment') }}