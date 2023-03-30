-- Find all transactions for which no rate exists
select
    productid,
    transactiondate
from {{ ref('stg_transactions') }} as st where
    not exists (
        select * from {{ ref ('stg_productlistpricehistory') }} as plph where
            st.productid = plph.productid
            and st.transactiondate >= plph.startdate
            and (st.transactiondate < plph.enddate or plph.enddate is null)
    )
