--BC OWN IGL Proposal Details Appcashpor
select LEFT(ClientID,5) as Branchid,ClientID,Targetname,Targetage,Husbandname,ProposalDate,LoanDescription,ClientRequestedAmount,LoanAmountApproved,NumberOfInstallments,
FinalReviewDate,ProductCategory,ProductID,Case When CC.ReportingDay=1 Then 'Monday'
       When CC.ReportingDay=2 Then 'Tuesday'
       When CC.ReportingDay=3 Then 'Wednesday'
       When CC.ReportingDay=4 Then 'Thursday'
       When CC.ReportingDay=5 Then 'Friday'
       When CC.ReportingDay=6 Then 'Saturday' End as MeetingDay,cc.StaffID,f.StaffName from ClientLoanProposal
       inner join Centers as cc on LEFT(ClientLoanProposal.ClientID,8)=cc.CenterID
       inner join FieldStaff as f on cc.StaffID=f.StaffID where LoanDisbursementDate is null and ApprovalRemarks not like'%Ban%'
and PrincipalOutstanding=1 and ProductID in(select ProductID from Products where type like'%BC%') and clientid like'31%'
order by LEFT(ClientID,5)


--OWN Proposal details of BC Branches
select LEFT(ClientLoanProposal.ClientID,5) as Branchid,ClientLoanProposal.ClientID,c.Loancycle,c.JoinDate,Targetname,Targetage,Husbandname,ProposalDate,LoanDescription,ClientRequestedAmount,LoanAmountApproved,NumberOfInstallments,
FinalReviewDate,ProductCategory,ProductID,Case When CC.ReportingDay=1 Then 'Monday'
       When CC.ReportingDay=2 Then 'Tuesday'
       When CC.ReportingDay=3 Then 'Wednesday'
       When CC.ReportingDay=4 Then 'Thursday'
       When CC.ReportingDay=5 Then 'Friday'
       When CC.ReportingDay=6 Then 'Saturday' End as MeetingDay,cc.StaffID,f.StaffName from ClientLoanProposal
       inner join Centers as cc on LEFT(ClientLoanProposal.ClientID,8)=cc.CenterID
       inner join FieldStaff as f on cc.StaffID=f.StaffID 
	   inner join Clients as c on c.clientID=ClientLoanProposal.ClientID where LoanDisbursementDate is null
and PrincipalOutstanding=1 and ProductID in(select ProductID from Products where type like'%OWN%' and name not like'%fl%' and name not like'%Bridge%') and ClientLoanProposal.ClientID like'14%'
And LEFT(ClientLoanProposal.ClientID,5) in (Select BranchID From Branches Where BranchBC Like '%BC%') And c.LoanCycle>'1'
order by LEFT(ClientLoanProposal.ClientID,5)


--All Proposal Entry details Betwween particular Date 
select LEFT(ClientID,5) as Branchid,ClientID,Targetname,Targetage,Husbandname,ProposalDate,LoanDescription,ClientRequestedAmount,LoanAmountApproved,NumberOfInstallments,
FinalReviewDate,ProductCategory,ProductID,Approvalremarks, Case When CC.ReportingDay=1 Then 'Monday'
       When CC.ReportingDay=2 Then 'Tuesday'
       When CC.ReportingDay=3 Then 'Wednesday'
       When CC.ReportingDay=4 Then 'Thursday'
       When CC.ReportingDay=5 Then 'Friday'
       When CC.ReportingDay=6 Then 'Saturday' End as MeetingDay,cc.StaffID,f.StaffName from ClientLoanProposal
       inner join Centers as cc on LEFT(ClientLoanProposal.ClientID,8)=cc.CenterID
       inner join FieldStaff as f on cc.StaffID=f.StaffID where LoanDisbursementDate is null and (ApprovalRemarks  like'%OK%' or ApprovalRemarks  is null)
and PrincipalOutstanding=1 and clientid like'21%' And ProposalDate between '2023-04-12' And '2023-04-12'
order by LEFT(ClientID,5)



