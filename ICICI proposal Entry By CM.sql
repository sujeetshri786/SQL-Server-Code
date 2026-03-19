--ICICI proposal Entry By CM 
select b.Zone,b.DistrictName as Region,b.BranchName,b.BranchID,a.ClientID,a.targetname,a.ClientRequestedAmount,
a.LoanAmountApproved,a.proposaldate,a.productcategory,a.Productid,a.loanproposalid,a.ProposalDate,a.FinalReviewDate,a.LoanAmountDisbursed from 
ClientLoanProposal a inner join Branches b on left(a.clientid,5)=b.BranchID
and productid in(select productid from products where type like '%ICICI%')
where b.DissolvedDate is null and a.ProposalDate>='2022-09-10' and b.branchid like '14%' 
--and a.productid in('i9','i0')
and a.loanamountdisbursed=0
