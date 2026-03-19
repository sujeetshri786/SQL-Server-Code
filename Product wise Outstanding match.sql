--Product wise Outstanding match
select a.PID, a.Outstanding, b.PID, b.Outstanding, isnull(isnull(a.Outstanding,0)-ISNULL(b.Outstanding,0),0) Difference from 

(
select SUBSTRING(clientloanid,16,2) PID, sum(cast(principaloutstanding as bigint)) Outstanding 
from ClientLoanSubscription where ActualPaidUpDate is null and RegionID='14'
group by SUBSTRING(clientloanid,16,2)
)a left join 
(
select txtField2 PID, Type, sum(cast(dblField1 as bigint)) Outstanding from ConsolidatedActivity c
inner join products p on p.ProductID=c.txtField2
where dtField1='2023-11-30' and txtField1 like '14%'
group by txtField2, type
) b on b.pid=a.pid
