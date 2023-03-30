with product as (
    select * from {{ ref('stg_product') }}
),

inventory as (
    select * from {{ ref('stg_productinventory') }}
),

product_inventory as (
    select
        product.productmodelid,
        inventory.quantity
    from product inner join inventory on product.productid = inventory.productid
)

select
    productmodelid,
    sum(quantity) as totalinventory
from product_inventory
group by productmodelid
