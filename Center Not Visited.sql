--Center Not Visited

select branchid,CenterID ,CenterName ,case when ReportingDay =1 then 'Mon'
when ReportingDay =2 then 'Tus' when ReportingDay =3 then 'Wed'when ReportingDay =4 then 'Thu' when ReportingDay =5 then 'Fri'
when ReportingDay =6 then 'Sat' end as 'ReportingDay'
from Centers where DissolvedDate is null and branchid like'05:21%' and CenterID not  in ( select Location_id  from TrackVisit 
where DateStamp>='2026-01-01' and StaffID in ( select StaffID from FieldStaff where Designation ='16' and Designation ='27') )



select Branchid,CenterID ,CenterName ,case when ReportingDay =1 then 'Mon'
when ReportingDay =2 then 'Tus' when ReportingDay =3 then 'Wed'when ReportingDay =4 then 'Thu' when ReportingDay =5 then 'Fri'
when ReportingDay =6 then 'Sat' end as 'ReportingDay'
from Centers where DissolvedDate is null and branchid like '05:21%' and CenterID not  in ( select Location_id  from TrackVisit 
where DateStamp BETWEEN '2026-01-01' AND '2026-03-19' and StaffID in ( select StaffID from FieldStaff where Designation ='16') )


----visit pending report

select Branchid,(select Branchname from Branches where branches.branchid=centers.BranchID)BName, Centerid,CenterName ,case when ReportingDay =1 then 'Mon'
when ReportingDay =2 then 'Tus' when ReportingDay =3 then 'Wed'when ReportingDay =4 then 'Thu' when ReportingDay =5 then 'Fri'
when ReportingDay =6 then 'Sat' end as 'ReportingDay'
from Centers where DissolvedDate is null and left(branchid,2) in ('14') and CenterID not  in ( select Location_id  from TrackVisit 
where DateStamp between '2025-10-01'  and '2026-01-17' and StaffID in ( select StaffID from FieldStaff where Designation ='16') ) 
order by branchid,CenterID
