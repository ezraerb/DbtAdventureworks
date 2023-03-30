with product as (
    select * from {{ ref('stg_product') }}
),

inventory as (
    select * from {{ ref('stg_productinventory') }}
),

inventory_cost as (
    select
        inventory.locationid,
        inventory.quantity * product.standardcost as totalcost
    from product inner join inventory on product.productid = inventory.productid
)

select
    locationid,
    sum(totalcost) as totalcost
from inventory_cost
group by locationid
