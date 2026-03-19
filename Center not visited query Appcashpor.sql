--Center not visited query Appcashpor

select Branches.DistrictName,Centers.branchid,CenterID ,CenterName ,case when ReportingDay =1 then 'Mon'
when ReportingDay =2 then 'Tus' when ReportingDay =3 then 'Wed'when ReportingDay =4 then 'Thu' when ReportingDay =5 then 'Fri'
when ReportingDay =6 then 'Sat' end as 'ReportingDay'
from Centers inner join
Branches on branches.branchid=centers.branchid  
where centers.DissolvedDate is null and left(centers.branchid,2) in('21') and CenterID not  in ( select Location_id  from TrackVisit 
where DateStamp between '2025-10-01' and '2025-12-16' and StaffID in ( select StaffID from FieldStaff where Designation ='16' and ExitDate is null) and LocationType='R' )
order by Centers.branchid
