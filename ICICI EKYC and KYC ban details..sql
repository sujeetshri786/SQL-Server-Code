  select B.branchId,B.BranchName,
(select top 1 staffid from fieldstaff with(nolock) where designation='16' and exitdate is null and Branchid=b.Branchid) as BMId,
(select top 1 StaffName from fieldstaff with(nolock) where designation='16' and exitdate is null and Branchid=b.Branchid) as BMName,

(select count(Clientid) NoOfEKYC from Ekycdetail where left(centerid,5)=b.branchid and Datestamp>='2022-11-03') NoOfEKYC,

(select count(Clientid) NoOfEKYC from Ekycdetail e
inner join CCRMFISUMMARY c on e.Clientid=c.REFERENCENUMBER where left(centerid,5)=b.branchid and Datestamp>='2022-11-03' and CBRStatus in('2','10')
and DATEOFISSUE>='2022-11-03') BanEkyc,

(select count(loanproposalid) from clientloanproposal with(nolock) where left(clientid,5)=b.branchid  and
loandisbursementdate is null and Principaloutstanding=1 and ProposalDate>='2022-11-03'
and ProductID  in(select ProductID from products where type like'%ICICI%')) as NoOfProposal,

(select ISNULL(Sum(clientrequestedamount),0) from clientloanproposal with(nolock) where left(clientid,5)=b.branchid  and
loandisbursementdate is null and Principaloutstanding=1 and ProposalDate>='2022-11-03'
and ProductID  in(select ProductID from products where type like'%ICICI%')) as NoOfProposalAmount,

(select count(loanproposalid) from clientloanproposal with(nolock) where left(clientid,5)=b.branchid and finalreviewdate is not null and
loandisbursementdate is null and Principaloutstanding=1 and ProposalDate>='2022-11-03'
and ProductID  in(select ProductID from products where type like'%ICICI%')) NoOfReviewed,

(select ISNULL(Sum(LoanAmountApproved),0) from clientloanproposal with(nolock) where left(clientid,5)=b.branchid and finalreviewdate is not null and
loandisbursementdate is null and Principaloutstanding=1 and ProposalDate>='2022-11-03'
and ProductID  in(select ProductID from products where type like'%ICICI%')) NoOfReviewedAmount

from branches b where dissolveddate is null and left(b.branchid,2) in('31')
order by b.branchid
