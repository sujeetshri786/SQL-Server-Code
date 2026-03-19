--Center Meeting Scedule (Local)

select B.BranchID,B.branchName,F.StaffID,F.StaffName,C.CenterID,C.CenterName,Case when C.ReportingDay=1 then 'Monday'
when C.ReportingDay=2 then 'Tuesday'
when C.ReportingDay=3 then 'Wednesday'
when C.ReportingDay=4 then 'Thursday'
when C.ReportingDay=5 then 'Friday'
when C.ReportingDay=6 then 'Saturday' end as CenterMeetingDay,C.CenterMeetingTime,NumMembers,
(select count(distinct LEFT(ClientLoanID,14)) as NoOfLoanClients from clientloansubscription with(nolock) where c.CenterID=LEFT(ClientLoanID,8) and actualpaidupdate is null) as NumLoanClients
from centers as C
inner join FieldStaff as F On
C.StaffID=F.StaffID
inner join Branches as B
On F.BranchID=B.branchId
where c.DissolvedDate is null --and F.ExitDate is null 
 order by B.BranchID,C.CenterMeetingDay,F.StaffID,C.CenterID

 --Select * from Centers

 -----New

select B.BranchID,B.BranchName,F.StaffID,F.StaffName,C.CenterID,C.CenterName,Case when C.ReportingDay=1 then 'Monday'
when C.ReportingDay=2 then 'Tuesday'
when C.ReportingDay=3 then 'Wednesday'
when C.ReportingDay=4 then 'Thursday'
when C.ReportingDay=5 then 'Friday'
when C.ReportingDay=6 then 'Saturday' end as CenterMeetingDay,C.CenterMeetingTime,NumMembers,
(select count(distinct LEFT(ClientLoanID,14)) as NoOfLoanClients from clientloansubscription with(nolock) where c.CenterID=LEFT(ClientLoanID,8) and PrincipalOutstanding > '0') as NumLoanClients
from centers as C
inner join FieldStaff as F On
C.StaffID=F.StaffID
inner join Branches as B
On F.BranchID=B.branchId
where c.DissolvedDate is null and reportingday in ('6') and c.RegionID = '05'
 order by B.BranchID,C.CenterMeetingDay,F.StaffID,C.CenterID


--Staff Handling Details
select B.BranchID,B.branchName,F.StaffID,F.StaffName,C.CenterID,C.CenterName,Case when C.ReportingDay=1 then 'Monday'
when C.ReportingDay=2 then 'Tuesday'
when C.ReportingDay=3 then 'Wednesday'
when C.ReportingDay=4 then 'Thursday'
when C.ReportingDay=5 then 'Friday'
when C.ReportingDay=6 then 'Saturday' end as CenterMeetingDay,C.CenterMeetingTime,NumMembers,
(select count(distinct LEFT(ClientLoanID,14)) as NoOfLoanClients from clientloansubscription with(nolock) where c.CenterID=LEFT(ClientLoanID,8) and actualpaidupdate is null) as NumLoanClients
from centers as C
inner join FieldStaff as F On
C.StaffID=F.StaffID
inner join Branches as B
On F.BranchID=B.branchId
where c.DissolvedDate is null and F.ExitDate is null And f.staffID IN ('18450','18730','19725')
 order by B.BranchID,C.CenterMeetingDay,F.StaffID,C.CenterID


---Center Meeting Shift Check for Sidbi Loan
 select DISTINCT  CENTERID    from clientloansubscription
with (nolock)  where ActualPaidUpDate  is null and bcidno='5' and left (clientloanid ,8) in
(

)
