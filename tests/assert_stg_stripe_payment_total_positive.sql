-- An example (bad) of a singular test, as it is the success / fail status that implies negative transactions not the amount
select 
     order_id,
     sum(amount) as total_amount

from {{ref('stg_stripe__payment')}}
group by 1
having sum(amount) < 0 