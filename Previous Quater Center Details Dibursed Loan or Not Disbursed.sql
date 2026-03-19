-------------Previous Quater Center Details Dibursed Loan or Not Disbursed


select b.DistrictName,B.BranchID,B.branchName,F.StaffID,F.StaffName,C.CenterID,C.CenterName,Case when C.ReportingDay=1 then 'Monday'
when C.ReportingDay=2 then 'Tuesday'
when C.ReportingDay=3 then 'Wednesday'
when C.ReportingDay=4 then 'Thursday'
when C.ReportingDay=5 then 'Friday'
when C.ReportingDay=6 then 'Saturday' end as ReportingDay,C.CenterMeetingTime,count(distinct LEFT(ClientLoanID,14)) as NumLoanClients,
Count(Distinct case when cls.numinstallmentsinarrears between '1' and '4' and CurrentinstallmentPeriod<=Loandurationinweeks then LEFT(ClientLoanID,14) end) as NoOfArrears,
Count(Distinct case when cls.numinstallmentsinarrears>='5' and CurrentinstallmentPeriod<=Loandurationinweeks then LEFT(ClientLoanID,14) end) as NoOfRisk,
Count(Distinct case when cls.CurrentinstallmentPeriod>Loandurationinweeks then LEFT(ClientLoanID,14) end) as NoOfDefaulter,
(case when c.centerid in(select centerid from clientloansubscription with(nolock) where disbursementdate>='2023-10-01') then 'Yes' 
 when c.centerid not in(select centerid from clientloansubscription with(nolock) where disbursementdate>='2023-10-01') then 'No' end) as 'DisbStatusFrm01OctY/N'
from centers as C with(nolock)
inner join FieldStaff as F with(nolock) On
C.StaffID=F.StaffID
inner join Branches as B with(nolock)
On F.BranchID=B.branchId
inner join clientloansubscription cls with(nolock) on cls.centerid=c.centerid
where c.DissolvedDate is null and  c.RegionID in('05') and actualpaidupdate is null
group by b.DistrictName,B.BranchID,B.branchName,F.StaffID,F.StaffName,C.CenterID,C.CenterName,c.ReportingDay,C.CenterMeetingTime
order by C.ReportingDay,b.BranchID
