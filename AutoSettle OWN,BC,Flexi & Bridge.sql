Select B.DistrictName As RegionName,B.BranchID,B.BranchName,FS.StaffID,FS.StaffName,Cent.CenterID,Cent.CenterName,Case When Cent.ReportingDay=1 Then 'Monday'
When Cent.ReportingDay=2 Then 'Tuesday'
When Cent.ReportingDay=3 Then 'Wednesday'
When Cent.ReportingDay=4 Then 'Thursday'
When Cent.ReportingDay=5 Then 'Friday'
When Cent.ReportingDay=6 Then 'Saturday' End as MeetingDay,
CC.ClientID,TT.TargetName AS ClientName,TT.HusbandName,CLS.ClientLoanID,CLP.ProductCategory,
CLS.LoanAmountDisbursed,CLS.DisbursementDate,
CLS.PrincipalOutstanding,CLS.CurrentInstallmentPeriod,CLS.LoanDurationInWeeks,CLS.ExpectedPaidUpDate,CLP.KYCName,CLP.KYCNo from ClientLoanSubscription  AS CLS WITH (NOLOCK)
inner join ClientLoanProposal  As CLP WITH (NOLOCK) ON CLS.LoanProposalID=CLP.LoanProposalID and CLS.ActualPaidUpDate is null
and CLS.ExpectedPaidUpDate between '2026-03-01' and '2026-03-31' and CLS.PrincipalOutstanding>0
Inner join Clients AS CC WITH (NOLOCK) On CLP.ClientID=CC.ClientID and CC.DropOutStatus='0'
inner join Targets AS TT WITH (NOLOCK) on CC.TargetID=TT.TargetID
inner join Centers AS Cent With (NOLOCK) on TT.CenterID=Cent.CenterID and Cent.DissolvedDate is null
inner join FieldStaff As FS With (NOLOCK) on Cent.StaffId=FS.StaffId and FS.ExitDate is null
inner join Branches AS B With (Nolock) on Cent.BranchID=B.BranchID and B.DissolvedDate is null
inner join Products as P With (Nolock) on SUBSTRING(cls.ClientLoanID,16,2)=P.ProductID --and P.Loan_Category NOT IN ('5','7')--Own&BC--P.Loan_Category IN ('5','7')--Flexi&Bridge
Where cls.RegionID = '05'
group by B.DistrictName,B.BranchID,B.BranchName,CC.ClientID,CLS.ClientLoanID,CLP.ProductCategory,TT.TargetName,TT.HusbandName,FS.StaffId,FS.StaffName,Cent.CenterID,Cent.CenterName,
ReportingDay,CLS.LoanAmountDisbursed,CLS.DisbursementDate,CLS.PrincipalOutstanding,CLS.CurrentInstallmentPeriod,CLS.LoanDurationInWeeks,CLS.ExpectedPaidUpDate,CLP.KYCName,CLP.KYCNo
order by B.BranchID,FS.StaffID,Cent.CenterID,CC.ClientID

 