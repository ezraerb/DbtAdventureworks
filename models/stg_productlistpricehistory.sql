--End date in the DB is inclusuive, which causes problems with timestampss at
--the end of a period. Add one day so it becomes exclusive
select
    productid,
    startdate,
    enddate + INTERVAL '1 day' as enddate,
    listprice
from production.productlistpricehistory
--After a product's sales officually ended, remaining inventory was still sold.
--Add a price row derived from the product row to handle these sales
union all
select
    productid,
    sellenddate::DATE + INTERVAL '1 day' as startdate,
    NULL as enddate,
    listprice
from production.product
where sellenddate is not null
