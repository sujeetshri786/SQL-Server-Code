-------CENTER VISIT BY BM



select B.BranchID,B.BranchName,c.CenterID,c.CenterName,t.Staffid,f.StaffName,cast(t.Datestamp as date) as VisitDate,t.Lattitude,t.Longitude from trackvisit as t with (NoLock)
inner join fieldstaff as f on f.StaffID=t.Staffid
inner join branches as b on b.BranchID=left(t.Location_id,5)
inner join centers as c on c. CenterID = t.Location_id
where t.Location_id like '05%' and t.LocationType = 'R' and t.Datestamp between '2025-12-01' and '2025-12-31' and f.Designation = '16'


----BY Akshay
select Branchid,CenterID ,CenterName ,case when ReportingDay =1 then 'Mon'
when ReportingDay =2 then 'Tus' when ReportingDay =3 then 'Wed'when ReportingDay =4 then 'Thu' when ReportingDay =5 then 'Fri'
when ReportingDay =6 then 'Sat' end as 'ReportingDay'
from Centers where DissolvedDate is null and centerid  in ('10:01:07') and CenterID  in ( select Location_id  from TrackVisit 
where DateStamp BETWEEN '2025-04-01' AND '2025-06-25' and StaffID in 
( select StaffID from FieldStaff where Designation  in ('16' )))

----BY Nikhil sir
select Location_id,
case when LocationType='R' then 'Center'when LocationType='C' then 'CHC' end as LocationType,Staffid,
(select staffname from FieldStaff where staffid=trackvisit.Staffid ) 'StaffNAME', 

(select designationname from designationmaster with (nolock) where designationid in (select designation from fieldstaff where staffid=trackvisit.Staffid )) Position ,
cast (Datestamp as date) Datestamp from trackvisit 
 where Location_id like '10%' 
 and cast (Datestamp as date) >='2025-04-01'
order by Location_id,Datestamp
