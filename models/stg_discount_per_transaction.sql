with transactions as (
    select * from {{ ref('stg_transactions') }}
),

productlistpricehistory as (
    select * from {{ ref('stg_productlistpricehistory') }}
),

transaction_with_list_price as (
    select
        transactions.productid,
        transactions.transactiondate,
        transactions.quantity,
        transactions.actualcost,
        productlistpricehistory.listprice
    from transactions
    inner join
        productlistpricehistory
        on
            transactions.productid = productlistpricehistory.productid
            and transactions.transactiondate
            >= productlistpricehistory.startdate
            and (
                transactions.transactiondate < productlistpricehistory.enddate
                or productlistpricehistory.enddate is null
            )
)

select
    productid,
    transactiondate,
    quantity * (listprice - actualcost) as totaldiscount
from transaction_with_list_price
