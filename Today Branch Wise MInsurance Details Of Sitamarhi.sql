--Minsurance----Appcashpor----Sourabh Sir

select b.Zone,b.DistrictName As Regionname,b.branchid,count(m.clientid) as NO_ALC,sum(collamount) as Amount from    minsuresurvey m inner join branches b  on m.branchid=b.branchid 
 where  b.zone='hot-north east zone' and b.branchid like'14%' and PaymentMode='By cashpor' and cast(m.CollDate as date )='2025-11-19' 
 and rejecteddate is null   
 group by b.HandleBy,b.Zone,b.DistrictName,b.branchid
order by b.HandleBy,b.Zone,b.DistrictName,b.branchid

select b.Zone,b.DistrictName As Regionname,b.branchid,count(m.clientid) as NO_ALC,sum(collamount) as Amount from    minsuresurvey m inner join branches b  on m.branchid=b.branchid 
 where b.zone='hot-north east zone' and b.branchid like'14%' and PaymentMode='By self' and cast(m.CollDate as date )>='2025-11-19' and rejecteddate is null
group by b.HandleBy,b.Zone,b.DistrictName,b.branchid
order by b.HandleBy,b.Zone,b.DistrictName,b.branchid

--same

----------------M Insurance Collection Detail Branch Wise-----Durgesh----Appcashpor
select b.Zone,b.DistrictName As Regionname,b.Branchid,b.Branchname,PaymentMode,count(m.clientid) as NO_ALC,sum(collamount) as Amount
from minsuresurvey m inner join branches b  on m.branchid=b.branchid 
 where   cast(m.CollDate as date) between '2025-11-28' and '2025-11-28'  and b.BranchID like '14%'  and PaymentMode='By self' and rejecteddate is null
group by b.HandleBy,b.Zone,b.DistrictName,b.Branchid,b.Branchname,PaymentMode
order by b.HandleBy,b.Zone,b.DistrictName,b.Branchname

select b.Zone,b.DistrictName As Regionname,b.Branchid,b.Branchname,count(m.clientid) as NO_ALC,sum(collamount) as Amount,PaymentMode 
from    minsuresurvey m inner join branches b  on m.branchid=b.branchid 
 where   cast(m.entrydate as date) between '2025-11-19' and '2025-11-19'  and b.DistrictName like 'Siwan%'  and PaymentMode='By cashpor' and rejecteddate is null
group by b.HandleBy,b.Zone,b.DistrictName,b.Branchid,b.Branchname,PaymentMode
order by b.HandleBy,b.Zone,b.DistrictName,b.Branchid,b.Branchname
