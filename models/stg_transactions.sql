select
    productid,
    transactiondate,
    quantity,
    actualcost
from production.transactionhistory
where transactiontype = 'S'
