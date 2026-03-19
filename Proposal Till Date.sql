------------ Proposal entry till date -------------Appcashpor

select left(Clientid,5) as BranchID, b.branchname as BranchName, Count(LoanProposalID) as TotalNoProposal, sum(ClientRequestedAmount) as TotalProposalAmount from ClientLoanProposal as clp
inner join branches as b on b.branchid=left(clp.Clientid,5)
where ClientID like '28%' and ProposalDate between '2025-04-01' and '2025-05-14' and LoanAmountDisbursed='0' and PrincipalOutstanding='1'And 
LoanDisbursementDate is NULL
Group By left(Clientid,5), b.branchname

-------------------------New PRoposal Query ----------------------

Select left(ClientID,5) as BranchID, ClientID,Targetname, HusbandName, Targetage, Nominee, ProposalDate, ClientRequestedAmount, LoanAmountDisbursed, LoanDisbursementDate, ProductCategory, AccountNumber, IFSCCode
from ClientLoanProposal where ClientID like '14%' and LoanDisbursementDate='2023-11-11' and LoanAmountDisbursed is not null

------------Not Review by BM----------
select left(Clientid,5) as BranchID, b.branchname as BranchName, Count(LoanProposalID) as TotalNoProposal, sum(ClientRequestedAmount) as TotalProposalAmount from ClientLoanProposal as clp
inner join branches as b on b.branchid=left(clp.Clientid,5)
where ClientID like '14%' and ProposalDate between '2022-04-01' and '2023-03-21' AND FinalReviewDate is null
Group By left(Clientid,5), b.branchname

-------------review by bm-------------
select left(Clientid,5) as BranchID, b.branchname as BranchName, Count(LoanProposalID) as TotalNoProposal, sum(loanamountapproved) as TotalProposalAmount from ClientLoanProposal as clp
inner join branches as b on b.branchid=left(clp.Clientid,5)
where ClientID like '14%' and ProposalDate between '2022-10-20' and '2022-10-20' AND FinalReviewDate is not null
Group By left(Clientid,5), b.branchname

-------------local ----------- Disbursment Record-------------
select left(ClientLoanid,5) as BranchID, b.branchname as BranchName, count(left(ClientLoanid,16)) as NumberOfCLients, sum(LoanAmountDisbursed) as DisbursedAmount
from ClientLoanSubscription as cls
inner join branches as b on b.branchid=left(cls.ClientLoanid,5)
where Actualpaidupdate is null and DisbursementDate>='2022-07-23'
Group by left(ClientLoanid,5), b.branchname
order by left(ClientLoanid,5), b.branchname

--Proposal Entry Own And BC
select B.Branchname,B.BranchId,count(loanproposalid) NoOfCM,Sum(clientrequestedAmount) TotalAmountCM,count(case when finalreviewdate is not null then 1 end) as NoOfBMReview,
ISNULL(Sum(case when finalreviewdate is not null then LoanAmountApproved end),0) as NoOfBMReviewAmt from clientloanproposal clp
inner join branches b on b.branchid=left(clientid,5)
where clientid like'14:13%' and principaloutstanding=1 and Loandisbursementdate is null and ApprovalRemarks not like'%Ban%' and ApprovalRemarks not like'%Deact%' and
LoanProposalID not in(select LoanProposalID from cds2 where ClientLoan1AmtDueDisbursed>0) 
and proposaldate>='2023-11-01'
group by B.Branchname,B.BranchId
order by B.BranchId


--EKYC done but proposal not entry and proposal entry but not reviewed by BM
Select left(e.clientId,5) as Branchid,b.BranchName,e.clientID,e.Name,e.Datestamp as EKYC_Entry_Date From EKYCdetail as e
inner Join Branches as b on b.BranchID=left(e.clientId,5)
Where e.Clientid like '14%' And e.ClientId not In (Select clientId From ClientloanProposal)
