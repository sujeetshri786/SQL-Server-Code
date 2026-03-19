select left(ClientID,5) branchid,clientid,targetname,Targetage,ProposalDate,LoanAmountApproved,NumberOfInstallments,FinalReviewDate,ProductCategory,
ApprovalRemarks
from clientloanproposal where clientid like '21%' and LoanDisbursementDate is null and PrincipalOutstanding = '1'
order by left(ClientID,5)
