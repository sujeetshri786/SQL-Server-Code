----Sidbi Loan Proposal Pendency report


select b.BranchID,b.BranchName,B.BranchBC,b.CHID,b.CHName,c.ClientID,clp.Loanproposalid,t.TargetName,t.HusbandName,
cc.CenterID,cast(clp.ProposalDate as date) as ProposalDate,clp.entryby,fs.staffName,
clp.ClientRequestedAmount,cast(clp.FinalReviewDate as date) as Finalreviewdate,clp.productcategory,
case when  LoanAmountBM IS null then 'Not Review by BM/CHIB'
when LoanAmountAM is null then 'Not Review by CHIB'
when FSMID is null then 'Not Review by RM/DRM'
end as ReviewStatus,
case when c.Loancycle='0' and c.URNID=c.URNNumber and c.Amgrtdate IS not null
--and c.clientid in (select clientid from totalcreditneedsassessment with(nolock)
-- where remarks like 'worth%' and loanproposalid is null) 
then 'NEW CLIENT'
when c.Loancycle='0' and c.URNID=c.URNNumber and c.Amgrtdate IS null
--and c.clientid in (select clientid from totalcreditneedsassessment with(nolock)
-- where remarks like 'worth%' and loanproposalid is null) 
then 'NEW CLIENT'
else 'OLD CLIENT' end as ClientTYPE,clp.ApprovalRemarks,t.status,clp.productcategory
from ClientLoanProposal  as clp with(nolock) inner join clients as c on 
clp.ClientID=c.ClientID
inner join targets as t on t.TargetID=c.TargetID
inner join Branches as b on b.BranchID=t.BranchID
inner join centers as cc on t.CenterID=cc.centerid
inner join fieldstaff as fs on fs.staffid=clp.entryby
where  clp.ClientID like '35%' and PrincipalOutstanding='1' 
and LoanDisbursementDate is null and FinalReviewDate is null 
--and left(c.clientid,5) in (select branchid from branches where branchbc like '%BC%')
and c.DropOutStatus='0' 
and clp.productid in ('w6')
order by B.Branchid


----Sidbi Loan Proposal Pendency report


select b.BranchID,b.BranchName,B.BranchBC,b.CHID,b.CHName,c.ClientID,clp.Loanproposalid,t.TargetName,t.HusbandName,
cc.CenterID,cast(clp.ProposalDate as date) as ProposalDate,clp.entryby,fs.staffName,
clp.ClientRequestedAmount,cast(clp.FinalReviewDate as date) as Finalreviewdate,clp.productID,clp.productcategory,
case when  LoanAmountBM IS null then 'Not Review by BM/CHIB'
when LoanAmountAM is null then 'Not Review by CHIB'
when FSMID is null then 'Not Review by RM/DRM'
end as ReviewStatus,
case when c.Loancycle='0' and c.URNID=c.URNNumber and c.Amgrtdate IS not null
--and c.clientid in (select clientid from totalcreditneedsassessment with(nolock)
-- where remarks like 'worth%' and loanproposalid is null) 
then 'NEW CLIENT'
when c.Loancycle='0' and c.URNID=c.URNNumber and c.Amgrtdate IS null
--and c.clientid in (select clientid from totalcreditneedsassessment with(nolock)
-- where remarks like 'worth%' and loanproposalid is null) 
then 'NEW CLIENT'
else 'OLD CLIENT' end as ClientTYPE,clp.ApprovalRemarks,t.status,clp.productcategory
from ClientLoanProposal  as clp with(nolock) inner join clients as c on 
clp.ClientID=c.ClientID
inner join targets as t on t.TargetID=c.TargetID
inner join Branches as b on b.BranchID=t.BranchID
inner join centers as cc on t.CenterID=cc.centerid
inner join fieldstaff as fs on fs.staffid=clp.entryby
inner join products as p on p.productid=clp.ProductID
where  clp.ClientID like '05%' and PrincipalOutstanding='1' 
and LoanDisbursementDate is null and FinalReviewDate is null and Proposaldate >='2023-04-01'
--and left(c.clientid,5) in (select branchid from branches where branchbc like '%BC%')
and c.DropOutStatus='0' 
and p.Type like '%%SIDBI%%'
order by B.Branchid


Select * from ClientLoanProposal