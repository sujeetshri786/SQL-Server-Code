---Proposal Review Pendency Appcashpor

select b.BranchID,b.BranchName,B.BranchBC,b.CHID,b.CHName,c.ClientID,Clp.LoanProposalID,t.TargetName,t.HusbandName,
cc.CenterID,cast(clp.ProposalDate as date) as ProposalDate,clp.entryby,fs.staffName,
clp.ClientRequestedAmount,cast(clp.FinalReviewDate as date) as Finalreviewdate,clp.productcategory,
case when  LoanAmountBM IS not null 
then 'Not Review Pending by CHIB' else 'Not Review by BM' end as ReviewStatus,
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
where  clp.ClientID like '28%' and PrincipalOutstanding='1' 
and LoanDisbursementDate is null and FinalReviewDate is null 
--and left(c.clientid,5) in (select branchid from branches where branchbc like '%BC%')
and c.DropOutStatus='0' 
--and clp.productid in ('O0','O1')
order by B.Branchid,clp.clientid


--select * from Branches
--select * from clients