--proposal entry but pending by idbi bank.

select LEFT(ClientLoanProposal.ClientID,5) as Branchid,ClientLoanProposal.ClientID, c.Loancycle,Targetname,Targetage,Husbandname,ProposalDate,LoanDescription,ClientRequestedAmount,ClientLoanProposal.LoanAmountApproved,NumberOfInstallments,
FinalReviewDate, ir.verifydate, ProductCategory,ProductID,Case When CC.ReportingDay=1 Then 'Monday'
       When CC.ReportingDay=2 Then 'Tuesday'
       When CC.ReportingDay=3 Then 'Wednesday'
       When CC.ReportingDay=4 Then 'Thursday'
       When CC.ReportingDay=5 Then 'Friday'
       When CC.ReportingDay=6 Then 'Saturday' End as MeetingDay,cc.StaffID,f.StaffName from ClientLoanProposal
       inner join Centers as cc on LEFT(ClientLoanProposal.ClientID,8)=cc.CenterID
          inner join clients as c on c.clientid=ClientLoanProposal.clientid
full join idbireview as ir on ir.loanproposalid=ClientLoanProposal.loanproposalid
       inner join FieldStaff as f on cc.StaffID=f.StaffID where LoanDisbursementDate is null 
 and PrincipalOutstanding=1 and ProductID in(select ProductID from Products where type like'%BC IDBI%') and ClientLoanProposal.clientid like'14%'
and ClientLoanProposal.loanproposalid not in (select loanproposalid from bcloanfundreleased)
order by LEFT(ClientLoanProposal.ClientID,5)
