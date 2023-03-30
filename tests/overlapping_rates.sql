--Find all rates where the active dates overlap.
select
    a.productid,
    a.startdate,
    a.enddate,
    b.startdate,
    b.enddate
from dbt.stg_productlistpricehistory as a
join dbt.stg_productlistpricehistory as b on
    a.productid = b.productid and
    (a.startdate, a.enddate) OVERLAPS (b.startdate, b.enddate)
where
    (a.startdate, a.enddate) != (b.startdate, b.enddate)
