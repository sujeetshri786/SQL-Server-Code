--ICICI Proposal And Disbursement Entry staff Wise from date

select bb.DistrictName,BB.BranchName,B.branchId,b.StaffName,B.StaffID,CASE WHEN Designation = '12' THEN 'CM' 
WHEN Designation = '13' THEN 'CM' WHEN Designation = '14' THEN 'PCM' 
WHEN Designation = '15' THEN 'TCM'
WHEN Designation = '46' THEN 'CTPCM'
WHEN Designation = '47' THEN 'CTTCM' END AS 'Position',

(select count(loanproposalid) from clientloanproposal with(nolock) where EntryBy=b.StaffID  and
ProposalDate>='2022-04-01' and productid in
(select ProductID from Products where type like'%ICICI%') and (principaloutstanding=1 or principaloutstanding>1)) as NoOfProposal,

(select ISNULL(Sum(clientrequestedamount),0) from clientloanproposal with(nolock) where EntryBy=b.StaffID  and
ProposalDate>='2022-04-01' and productid in
(select ProductID from Products where type like'%ICICI%') and (principaloutstanding=1 or principaloutstanding>1)) as NoOfProposalAmount,

(select count(loanproposalid) from clientloanproposal with(nolock) where EntryBy=b.StaffID and 
loandisbursementdate>='2022-04-01' and ProposalDate>='2022-04-01' and Principaloutstanding>1 and productid in
(select ProductID from Products where type like'%ICICI%')) NoOfDisbursed,

(select ISNULL(Sum(LoanAmountApproved),0) from clientloanproposal with(nolock) where EntryBy=b.StaffID and 
loandisbursementdate>='2022-04-01' and ProposalDate>='2022-04-01' and Principaloutstanding>1 and productid in
(select ProductID from Products where type like'%ICICI%')) DisbursedAmount

from FieldStaff b inner join branches bb on b.branchid=bb.Branchid 
where ExitDate is null and left(b.branchid,2) in('14') and b.designation in('12','13','14','15','46','47')
and staffname not like'%Dummy%' and bb.DissolvedDate is null
order by b.branchid
