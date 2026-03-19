/*Select left(cls.clientloanid,14) From ClientLoanSubscription as cls
inner join clientloanproposal as clp on clp.clientid=left(cls.clientloanid,14)
inner join clients as c on c.clientid=left(cls.clientloanid,14)
Where cls.ActualPaidUpdate is not NULL and clp.principaloutstanding='0' and c.dropoutstatus='0' and c.riskfund<>'2' and c.hotlistremark='0'
and cls.actualpaidupdate between '2022-04-01' and '2022-07-25'
Group by left(cls.clientloanid,14)*/

------------------- DORMANT CLIENTS report In Region ------------------

Select B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,StaffName,CC.CenterID,CC.CenterName,
Case When CC.ReportingDay=1 Then 'Monday'
                When CC.ReportingDay=2 Then 'Tuesday'
                When CC.ReportingDay=3 Then 'Wednesday'
                When CC.ReportingDay=4 Then 'Thursday'
                When CC.ReportingDay=5 Then 'Friday'
                When CC.ReportingDay=6 Then 'Saturday' End as MeetingDay,
C.ClientID,T.TargetName As ClientName,T.MobileNumber,T.TargetAge As ClientAge,T.HusbandName,T.HusbandAge,
Convert(varchar(10),C.JoinDate,23) As ClientJoinDate,C.LoanCycle from Clients as C With (Nolock) 
inner join Targets as T With (Nolock) ON C.TargetID=T.TargetID
and C.DropOutStatus=0 and DropOutDate is null and C.ClientID not in (
Select Distinct(LEFT(ClientLoanID,14)) from ClientLoanSubscription With (Nolock) where ActualPaidUpDate is null and PrincipalOutstanding>0)
and C.ClientID not in (select ClientID from ClientLoanProposal With (Nolock) where LoanDisbursementDate is null and PrincipalOutstanding=1)
inner join centers as CC With (Nolock) ON T.CenterID=CC.CenterID and CC.DissolvedDate is null
inner join FieldStaff as FS With (Nolock) on CC.StaffID=FS.StaffID and FS.ExitDate is null
inner join Branches as B With (Nolock) ON T.BranchID=B.BranchID and B.DissolvedDate is null
inner join ClientLoanSubscription  as cls With (NoLock) on C.clientID = left(cls.clientLoanID,14) Where ActualPaidUpDate between '2025-04-01' and '2026-03-07' and cls.RegionID = '05'
group by B.DistrictName,B.BranchID,B.BranchName,FS.StaffID,StaffName,CC.CenterID,CC.CenterName,CC.ReportingDay,FS.StaffID,StaffName,C.ClientID,T.TargetName,T.MobileNumber,
T.TargetAge,T.HusbandName,T.HusbandAge,C.JoinDate,C.LoanCycle
order by B.BranchID,FS.StaffID,CC.CenterID,C.ClientID

