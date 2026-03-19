--PROPOSAL ENTRY AND PROPOSAL REVIEW DETAILS YESTERDAY APPCASHPOR STAFFWISE

select b.branchId,clp.entryby as StaffID,count(clp.ClientId) as CmEntry,sum(CLP.ClientRequestedAmount) AS LoanAmount,clp.BMID,count(FinalReviewDate) as ProposalReviewd,
sum(LoanAmountBM) as LoanAmountReviewed
from clientloanproposal as clp
inner join branches as b on b.branchid=left(clp.ClientId,5)
where clp.ClientID like '14%' and clp.proposaldate = '2023-07-24' 
group by clp.entryby,b.branchId,clp.BMID
order by b.branchId,clp.entryby



--select * from clientloanproposal as clp where clp.ClientID like '16%' and clp.proposaldate = '2023-07-24' order by clp.entryby