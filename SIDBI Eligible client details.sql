--SIDBI Eligible client details

Select B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,StaffName,CC.CenterID,CC.CenterName,Case When CC.ReportingDay=1 Then 'Monday'
       When CC.ReportingDay=2 Then 'Tuesday'
       When CC.ReportingDay=3 Then 'Wednesday'
       When CC.ReportingDay=4 Then 'Thursday'
       When CC.ReportingDay=5 Then 'Friday'
       When CC.ReportingDay=6 Then 'Saturday' End as MeetingDay,
C.ClientID,caa.clientLoanid,T.TargetName As ClientName,caa.Targetname as Adharname,T.TargetAge As ClientAge,T.HusbandName,T.HusbandAge,
Convert(varchar(10),C.JoinDate,23) As ClientJoinDate,C.LoanCycle,c.EligibleLoanAmount,caa.PrincipalOutstanding,caa.productcategory from Clients as C With (Nolock) 
inner join Targets as T With (Nolock) ON C.TargetID=T.TargetID
and C.DropOutStatus=0 and DropOutDate is null and  c.eligibleloanamount>'100000' and c.HotListDate is null and loancycle>'3'
inner join centers as CC With (Nolock) ON T.CenterID=CC.CenterID and CC.DissolvedDate is null
inner join FieldStaff as FS With (Nolock) on CC.StaffID=FS.StaffID and FS.ExitDate is null
inner join Branches as B With (Nolock) ON T.BranchID=B.BranchID and B.DissolvedDate is null
inner join clientloanproposal as caa with(Nolock) on c.clientid=caa.clientid
where caa.productcategory not like '%SIDBI%' and  PrincipalOutstanding>0 and b.RegionID='24'
group by B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,StaffName,CC.CenterID,CC.CenterName,CC.ReportingDay,FS.StaffID,StaffName,C.ClientID,T.TargetName,
T.TargetAge,T.HusbandName,T.HusbandAge,C.JoinDate,C.LoanCycle ,caa.targetname,c.EligibleLoanAmount,caa.PrincipalOutstanding,caa.clientLoanid,caa.productcategory
order by B.BranchID,FS.StaffID,CC.CenterID,C.ClientID
