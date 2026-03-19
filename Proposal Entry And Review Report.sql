------Proposal Entry And Review Report

select left(Clientid,5) as BranchID,b.BranchName,count(ClientRequestedAmount) as TotalNoProposal,Sum(ClientRequestedAmount) as TotalProposalAmount,
count(FinalReviewDate) as NumOfReviewProposal,Sum(LoanAmountApproved) as ReviewAmount
from clientloanproposal as clp With (nolock) 
inner join branches as b on b.BranchID=left(Clientid,5)
Where ClientID like '05%' and proposaldate between '2025-10-14' and '2025-10-14'
group by left(Clientid,5),b.BranchName
order by left(Clientid,5),b.BranchName