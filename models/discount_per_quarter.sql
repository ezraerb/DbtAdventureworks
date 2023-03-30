-- Need to aggregate by quarter, so truncate transaction date to nearest
-- quarter boundry
with transactions as (
    select
        productid,
        totaldiscount,
        date_trunc('quarter', transactiondate) as quarter_date
    from {{ ref('stg_discount_per_transaction') }}
)

select
    productid,
    quarter_date,
    sum(totaldiscount) as totaldiscount
from transactions
group by productid, quarter_date
