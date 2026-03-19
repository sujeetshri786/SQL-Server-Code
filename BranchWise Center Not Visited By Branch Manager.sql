--Branch Wise Center Visit have not been visited by the branch manager Appcashpor >='2022-04-01'

select branchid,CenterID ,CenterName ,case when ReportingDay =1 then 'Mon'
when ReportingDay =2 then 'Tus' when ReportingDay =3 then 'Wed'when ReportingDay =4 then 'Thu' when ReportingDay =5 then 'Fri'
when ReportingDay =6 then 'Sat' end as 'ReportingDay'
from Centers where DissolvedDate is null and branchid like '21%' and CenterID not  in ( select Location_id  from TrackVisit 
where DateStamp Between '2025-08-01' And '2025-08-31' and StaffID in ( select StaffID from FieldStaff where Designation ='16' and ExitDate is null) )
