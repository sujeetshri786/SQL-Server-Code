--Invalid Flexi Duration Week proposal cmc_server

Select b.zone,b.branchId,b.branchname,clp.clientId,clp.targetname as Clientname,clp.proposaldate,clp.loanproposalid,clp.productId,
clp.productCategory,clp.FinalReviewDate,clp.NumberOfInstallments,clp.LoanAmountApproved,cls.CurrentInstallmentPeriod,cls.LoanDurationInWeeks
from ClientLoanProposal as clp With (Nolock) 
inner join branches as b on b.branchId = left(clp.clientId,5)
Inner join ClientloanSubscription as cls on left(cls.ClientLoanID,14)=clp.ClientId
inner join products as p on p.productId = substring(cls.clientloanid,16,2)
Where ClientId Like '05%' and clp.LoanDisbursementDate IS NULL and clp.PrincipalOutstanding = '1' and 
clp.ProductCategory Like '%Flexi%%' and clp.NumberOfInstallments>(cls.LoanDurationInWeeks-cls.CurrentInstallmentPeriod) and cls.ActualPaidUpDate IS
NULL and p.Loan_category not in ('7') order by clp.clientID
