 --Proposal entry details with status count and CM And BM Review.
 select B.branchId,B.BranchName,
(select top 1 staffid from fieldstaff with(nolock) where designation='16' and exitdate is null and Branchid=b.Branchid) as BMId,
(select top 1 StaffName from fieldstaff with(nolock) where designation='16' and exitdate is null and Branchid=b.Branchid) as BMName,

(select count(loanproposalid) from clientloanproposal with(nolock) where left(clientid,5)=b.branchid  and
loandisbursementdate is null and Principaloutstanding=1 and ProposalDate>='2023-07-24') as NoOfProposal,

(select Sum(clientrequestedamount) from clientloanproposal with(nolock) where left(clientid,5)=b.branchid  and
loandisbursementdate is null and Principaloutstanding=1 and ProposalDate>='2023-07-24') as NoOfProposalAmount,

(select count(loanproposalid) from clientloanproposal with(nolock) where left(clientid,5)=b.branchid and finalreviewdate is not null and
loandisbursementdate is null and Principaloutstanding=1 and finalreviewdate>='2023-07-24') NoOfReviewed,

(select Sum(LoanAmountApproved) from clientloanproposal with(nolock) where left(clientid,5)=b.branchid and finalreviewdate is not null and
loandisbursementdate is null and Principaloutstanding=1 and finalreviewdate>='2023-07-24') NoOfReviewedAmount

from branches b where dissolveddate is null and left(b.branchid,2) in('16')
order by b.branchid
