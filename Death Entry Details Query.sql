---======DEATH ENTRY REPORT==========---------
Select LEFT(ClientLoanID,5) as Branchid,
(Select  UPPER(BranchName)  from Branches Where Branchid=LEFT(b.ClientLoanID,5))'BranchName',
ClientLoanID,
(Select UPPER(Targetname) From ClientLoanProposal Where LoanProposalID=b.LoanProposalID)'ClientName',
(Select UPPER(Husbandname) From ClientLoanProposal Where LoanProposalID=b.LoanProposalID)'Husbandname',
LoanProposalID,DisbursementDate,LoanAmountDisbursed,
RiskFund as Insurance,CASE When DeathPerson='1' Then UPPER('Client') Else UPPER('Husband') END as DeathPerson,Principaloutstanding,
(Select ProductCategory from Clientloanproposal Where LoanProposalID=b.LoanProposalID)'ProductCategory',
DeathDate,DeathEntryDate,(Select KYCNo From ClientLoanProposal Where LoanProposalID=B.LoanProposalID)'KYCNo'
from ClientLoanSubscription as b Where DeathDate is not null and ActualPaidUpDate is null
And DeathEntryDate Between'2021-03-22' and '2022-04-19'
order by ClientLoanID
