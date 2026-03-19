--IDBI,SIDBI and ICICI proposal details till date

select LEFT(ClientID,5) as Branchid,ClientID,Targetname,Targetage,Husbandname,ProposalDate,LoanDescription,ClientRequestedAmount,LoanAmountApproved,NumberOfInstallments,
FinalReviewDate,ClientLoanProposal.ProductCategory,ClientLoanProposal.ProductID,P.Type as BC_Type,ApprovalRemarks,Case When CC.ReportingDay=1 Then 'Monday'
       When CC.ReportingDay=2 Then 'Tuesday'
       When CC.ReportingDay=3 Then 'Wednesday'
       When CC.ReportingDay=4 Then 'Thursday'
       When CC.ReportingDay=5 Then 'Friday'
       When CC.ReportingDay=6 Then 'Saturday' End as MeetingDay,cc.StaffID,f.StaffName from ClientLoanProposal
       inner join Centers as cc on LEFT(ClientLoanProposal.ClientID,8)=cc.CenterID
       inner join FieldStaff as f on cc.StaffID=f.StaffID
       inner join products p on ClientLoanProposal.productid=p.productid where LoanDisbursementDate is null 
 and PrincipalOutstanding=1 and P.Type like'%BC%' and clientid like'14%'
order by LEFT(ClientID,5)
