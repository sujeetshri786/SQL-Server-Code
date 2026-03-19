--------Adding pending by BM--------
select Branches.BranchID,branches.BranchName,clients.ClientID,targets.TargetName,targets.HusbandName,
targets.CenterID,Centers.CenterName,Case When Centers.ReportingDay=1 Then 'Monday'
       When Centers.ReportingDay=2 Then 'Tuesday'
       When Centers.ReportingDay=3 Then 'Wednesday'
       When Centers.ReportingDay=4 Then 'Thursday'
       When Centers.ReportingDay=5 Then 'Friday'
       When Centers.ReportingDay=6 Then 'Saturday' End as MeetingDay,
clients.JoinDate,targets.entryby,fs.StaffName,clients.Amid as BMID,clients.Amgrtdate as BMGRtDate 
from clients with(nolock) inner join targets with(nolock) on clients.TargetID=targets.TargetID and clients.DropOutStatus='0'
inner join Branches with(nolock) on branches.BranchID=targets.BranchID
inner join centers with(nolock) on centers.CenterID=targets.CenterID
inner join FieldStaff as fs with(nolock) on fs.staffid=centers.StaffID
where cast(clients.JoinDate as date) >='2024-04-01'
and branches.BranchID like '14%'
--and branches.amid='1254'
and clients.amgrtdate is  null
--and clientid in (select clientid from CreditNeedAssessmenttrn)
and clientid in (select clientid from clientloanproposal where principaloutstanding='1' and finalreviewdate is null)
order by Branches.BranchID

-----------Adding pending by CM---------------------
select Branches.BranchID,branches.BranchName,clients.ClientID,targets.TargetName,targets.HusbandName,
targets.CenterID,Centers.CenterName,Case When Centers.ReportingDay=1 Then 'Monday'
       When Centers.ReportingDay=2 Then 'Tuesday'
       When Centers.ReportingDay=3 Then 'Wednesday'
       When Centers.ReportingDay=4 Then 'Thursday'
       When Centers.ReportingDay=5 Then 'Friday'
       When Centers.ReportingDay=6 Then 'Saturday' End as MeetingDay,
clients.JoinDate,targets.entryby,fs.StaffName,clients.Amid as BMID,clients.Amgrtdate as BMGRtDate 
from clients  with(nolock) inner join targets  with(nolock) on clients.TargetID=targets.TargetID and clients.DropOutStatus='0'
inner join Branches  with(nolock) on branches.BranchID=targets.BranchID
inner join centers  with(nolock) on centers.CenterID=targets.CenterID
inner join FieldStaff as fs  with(nolock) on fs.staffid=centers.StaffID
where cast(clients.JoinDate as date) >='2024-04-01'
and branches.BranchID like '14%'
--and branches.amid='1254'
and clients.amgrtdate is  null
and clientid not in (select clientid from clientloanproposal  with(nolock) where principaloutstanding='1' and finalreviewdate is null)
order by Branches.BranchID
