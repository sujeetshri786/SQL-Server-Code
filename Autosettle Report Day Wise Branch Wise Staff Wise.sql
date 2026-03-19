
--Autosettle Report Day Wise Branch Wise Staff Wise Local

Select B.DistrictName As RegionName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,Cent.CenterID,Cent.CenterName,Case When Cent.ReportingDay=1 Then 'Monday'
       When Cent.ReportingDay=2 Then 'Tuesday'
       When Cent.ReportingDay=3 Then 'Wednesday'
       When Cent.ReportingDay=4 Then 'Thursday'
       When Cent.ReportingDay=5 Then 'Friday'
       When Cent.ReportingDay=6 Then 'Saturday' End as MeetingDay,
       CC.ClientID,TT.TargetName AS ClientName,TT.HusbandName,CLS.ClientLoanID,CLP.ProductCategory,
CLS.LoanAmountDisbursed,CLS.DisbursementDate,
CLS.PrincipalOutstanding,CLS.CurrentInstallmentPeriod,CLS.LoanDurationInWeeks,CLS.ExpectedPaidUpDate from ClientLoanSubscription  AS CLS WITH (NOLOCK)
inner join ClientLoanProposal  As CLP WITH (NOLOCK) ON CLS.LoanProposalID=CLP.LoanProposalID and CLS.ActualPaidUpDate is null 
And clp.ProductID IN(select ProductId from  Products Where Loan_Category='0')
and CLS.ExpectedPaidUpDate between '2025-03-01' and '2025-03-31' and CLS.PrincipalOutstanding>0
Inner join Clients AS CC WITH (NOLOCK) On CLP.ClientID=CC.ClientID and CC.DropOutStatus='0'
inner join Targets AS TT WITH (NOLOCK) on CC.TargetID=TT.TargetID
inner join Centers AS Cent With (NOLOCK) on TT.CenterID=Cent.CenterID and Cent.DissolvedDate is null
inner join FieldStaff As FS With (NOLOCK) on Cent.StaffId=FS.StaffId and FS.ExitDate is null
inner join Branches AS B With (Nolock) on Cent.BranchID=B.BranchID and B.DissolvedDate is null
where CLS.RegionID = '14'
group by B.DistrictName,B.BranchID,B.BranchName,CC.ClientID,CLS.ClientLoanID,CLP.ProductCategory,TT.TargetName,TT.HusbandName,FS.StaffId,FS.StaffName,Cent.CenterID,Cent.CenterName,
ReportingDay,CLS.LoanAmountDisbursed,CLS.DisbursementDate,CLS.PrincipalOutstanding,CLS.CurrentInstallmentPeriod,CLS.LoanDurationInWeeks,CLS.ExpectedPaidUpDate
order by B.BranchID,FS.StaffID,Cent.CenterID,CC.ClientID




--Only sidbi Autosette
Select B.DistrictName As RegionName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,Cent.CenterID,Cent.CenterName,Case When Cent.ReportingDay=1 Then 'Monday'
       When Cent.ReportingDay=2 Then 'Tuesday'
       When Cent.ReportingDay=3 Then 'Wednesday'
       When Cent.ReportingDay=4 Then 'Thursday'
       When Cent.ReportingDay=5 Then 'Friday'
       When Cent.ReportingDay=6 Then 'Saturday' End as MeetingDay,
       CC.ClientID,TT.TargetName AS ClientName,TT.HusbandName,CLS.ClientLoanID,CLP.ProductCategory,
CLS.LoanAmountDisbursed,CLS.DisbursementDate,
CLS.PrincipalOutstanding,CLS.CurrentInstallmentPeriod,CLS.LoanDurationInWeeks,CLS.ExpectedPaidUpDate from ClientLoanSubscription  AS CLS WITH (NOLOCK)
inner join ClientLoanProposal  As CLP WITH (NOLOCK) ON CLS.LoanProposalID=CLP.LoanProposalID and CLS.ActualPaidUpDate is null 
And clp.ProductID IN(select ProductId from  Products Where type Like '%OWN%')
and CLS.DisbursementDate <= '2022-03-31' and CLS.PrincipalOutstanding>0
Inner join Clients AS CC WITH (NOLOCK) On CLP.ClientID=CC.ClientID and CC.DropOutStatus='0'
inner join Targets AS TT WITH (NOLOCK) on CC.TargetID=TT.TargetID
inner join Centers AS Cent With (NOLOCK) on TT.CenterID=Cent.CenterID and Cent.DissolvedDate is null
inner join FieldStaff As FS With (NOLOCK) on Cent.StaffId=FS.StaffId and FS.ExitDate is null
inner join Branches AS B With (Nolock) on Cent.BranchID=B.BranchID and B.DissolvedDate is null
where CLS.RegionID = '05'
group by B.DistrictName,B.BranchID,B.BranchName,CC.ClientID,CLS.ClientLoanID,CLP.ProductCategory,TT.TargetName,TT.HusbandName,FS.StaffId,FS.StaffName,Cent.CenterID,Cent.CenterName,
ReportingDay,CLS.LoanAmountDisbursed,CLS.DisbursementDate,CLS.PrincipalOutstanding,CLS.CurrentInstallmentPeriod,CLS.LoanDurationInWeeks,CLS.ExpectedPaidUpDate
order by B.BranchID,FS.StaffID,Cent.CenterID,CC.ClientID


--Select * From ClientLoanSubscription With (NoLock) Where 
--substring(clientloanid,16,2) IN(select ProductId from  Products Where type Like '%Sidbi%') And ActualPaidUpdate IS NULL
--and ClientLoanID like '14:07%' order by ExpectedPaidUpDate
Select * From products where Type like '%%SIDBI%%'



--Only sidbi Autosette
Select B.DistrictName As RegionName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,Cent.CenterID,Cent.CenterName,Case When Cent.ReportingDay=1 Then 'Monday'
       When Cent.ReportingDay=2 Then 'Tuesday'
       When Cent.ReportingDay=3 Then 'Wednesday'
       When Cent.ReportingDay=4 Then 'Thursday'
       When Cent.ReportingDay=5 Then 'Friday'
       When Cent.ReportingDay=6 Then 'Saturday' End as MeetingDay,
       CC.ClientID,TT.TargetName AS ClientName,TT.HusbandName,CLS.ClientLoanID,CLP.ProductCategory,
CLS.LoanAmountDisbursed,CLS.DisbursementDate,
CLS.PrincipalOutstanding,CLS.CurrentInstallmentPeriod,CLS.LoanDurationInWeeks,CLS.ExpectedPaidUpDate from ClientLoanSubscription  AS CLS WITH (NOLOCK)
inner join ClientLoanProposal  As CLP WITH (NOLOCK) ON CLS.LoanProposalID=CLP.LoanProposalID and CLS.ActualPaidUpDate is null 
And clp.ProductID IN ('5X','6X','H6','H8','W6')
and CLS.ExpectedPaidUpDate between '2024-10-05' and '2024-12-31' and CLS.PrincipalOutstanding>0
Inner join Clients AS CC WITH (NOLOCK) On CLP.ClientID=CC.ClientID and CC.DropOutStatus='0'
inner join Targets AS TT WITH (NOLOCK) on CC.TargetID=TT.TargetID
inner join Centers AS Cent With (NOLOCK) on TT.CenterID=Cent.CenterID and Cent.DissolvedDate is null
inner join FieldStaff As FS With (NOLOCK) on Cent.StaffId=FS.StaffId and FS.ExitDate is null
inner join Branches AS B With (Nolock) on Cent.BranchID=B.BranchID and B.DissolvedDate is null
where CLS.RegionID = '05'
group by B.DistrictName,B.BranchID,B.BranchName,CC.ClientID,CLS.ClientLoanID,CLP.ProductCategory,TT.TargetName,TT.HusbandName,FS.StaffId,FS.StaffName,Cent.CenterID,Cent.CenterName,
ReportingDay,CLS.LoanAmountDisbursed,CLS.DisbursementDate,CLS.PrincipalOutstanding,CLS.CurrentInstallmentPeriod,CLS.LoanDurationInWeeks,CLS.ExpectedPaidUpDate
order by B.BranchID,FS.StaffID,Cent.CenterID,CC.ClientID