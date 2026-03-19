--Loan Settle But proposal Not Done.
--Local

Select Zone,Districtname,branches.Branchid,Branchname,centers.StaffId,fieldstaff.StaffName,clp.ClientId,cls.ClientLoanID,Targetname,Husbandname,DisbursementDate,
cls.LoanAmountDisbursed,ActualPaidUpDate,cls.CurrentinstallmentPeriod,cls.LoanDurationinWeeks,sum(l.PrincipalCollected+InterestCollected) SettleAmt
from ClientLoanSubscription cls with(nolock)
join branches with(nolock) on branches.branchid=left(clientloanid,5)
Join ClientLoanProposal clp on clp.LoanProposalID=cls.LoanProposalID
join products with(nolock) on products.ProductID=clp.ProductID
join centers with(nolock) on centers.centerid=left(cls.clientloanid,8)
join fieldstaff with(nolock) on fieldstaff.staffid=centers.staffid
inner join loanledger l on l.clientloanid=cls.clientloanid 
where actualpaidupdate>='2022-08-01' and Loan_Category=0 and  
 not exists(
Select clientid from ClientLoanProposal with(nolock)
join products with(nolock) on products.ProductID=ClientLoanProposal.ProductID
where (LoanDisbursementDate >='2022-08-01' or PrincipalOutstanding=1) and ClientLoanProposal.ClientID=clp.ClientID and Loan_Category=0)
and l.weeklytransactiondate=cls.actualpaidupdate
group by Zone,Districtname,branches.Branchid,Branchname,centers.StaffId,fieldstaff.StaffName,clp.ClientId,cls.ClientLoanID,Targetname,Husbandname,KYCName,KYCNo,DisbursementDate,
cls.LoanAmountDisbursed,ActualPaidUpDate,cls.CurrentinstallmentPeriod,cls.LoanDurationinWeeks
order by branches.branchid
