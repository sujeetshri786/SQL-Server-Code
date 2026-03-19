select LEFT(ClientID,5) as Branchid,ClientID,Targetname,Targetage,Husbandname,ProposalDate,LoanDescription,ClientRequestedAmount,LoanAmountApproved,NumberOfInstallments,
FinalReviewDate,ProductCategory,ProductID,Approvalremarks, Case When CC.ReportingDay=1 Then 'Monday'
       When CC.ReportingDay=2 Then 'Tuesday'
       When CC.ReportingDay=3 Then 'Wednesday'
       When CC.ReportingDay=4 Then 'Thursday'
       When CC.ReportingDay=5 Then 'Friday'
       When CC.ReportingDay=6 Then 'Saturday' End as MeetingDay,cc.StaffID,f.StaffName,BMID,
	   (Select staffname from FieldStaff Where staffid =BMID) as BMName,
	   (Select Designation From FieldStaff Where StaffId = Bmid) as Designation
	   from ClientLoanProposal
       inner join Centers as cc on LEFT(ClientLoanProposal.ClientID,8)=cc.CenterID
       inner join FieldStaff as f on cc.StaffID=f.StaffID where LoanDisbursementDate is null and (ApprovalRemarks  like'%OK%' or ApprovalRemarks  is null)
and PrincipalOutstanding=1 and clientid like'21%' And ProposalDate between '2023-04-12' And '2023-04-12'
order by LEFT(ClientID,5)
