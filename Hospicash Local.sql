--Hospicash Local

select b.DistrictName ,b.branchid,b.branchname,count(cls.clientloanid) as ALC,sum(cls.HealthInsurance) as AmountClient,sum(cls.HealthInsurancespouse) as AmountSpouse
from clientloansubscription as cls inner join Clients as c on c.clientid=left(cls.clientloanid,14)
inner join targets as t on t.targetid=c.targetid 
inner join Branches  as b on b.branchid=t.branchid
where Actualpaidupdate is null and 
(HealthInsurance>0 or HealthInsuranceSpouse>0) and HealthInsuranceDate between '2023-04-01' and '2024-03-31' and cls.RegionID ='24'
group by b.DistrictName,b.Branchid,b.Branchname
order by b.DistrictName,b.Branchid,b.Branchname






--select * from clientloansubscription where HealthInsuranceDate between '2024-01-01' and '2024-01-31' and RegionID ='14'