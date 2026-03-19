

---(1)================== RATIO CALCULATION REPORT=========== (APPCASHPOR) ==============================

select left(clientid,2) as RegionID, (Select DISTINCT(DistrictName) From Branches Where Dissolveddate is null and LEFT(BranchID,2)=left(b.clientid,2) )'RegionName', (Select  Count(ClientLoan1AmtDueDisbursed) From Cds2 Where ClientLoan1AmtDueDisbursed>0 And left(clientid,2)=left(b.clientid,2) )'#Loans',
SUM(ClientLoan1AmtDueDisbursed) as #Due,  (Select  Count(ClientLoan1AmountDisbursed) From Cds2 Where ClientLoan1AmountDisbursed>0 And left(clientid,2)=left(b.clientid,2) )'#LoansDisburse',  SUM(ClientLoan1AmountDisbursed) as #DueDisburse,
(Select  Count(ClientLoan1AmtDueDisbursed) From Cds2 Where ClientLoan1AmtDueDisbursed>0 And left(clientid,2)=left(b.clientid,2) and  substring(ClientLoan1ID,16,2) in (Select ProductId From Products Where loan_category=0 and  BCIDNO<>'0' and BCIDNO<>'5') )'#BCDueLoans',
(Select  ISNULL(Sum(ClientLoan1AmtDueDisbursed),0) From Cds2 Where ClientLoan1AmtDueDisbursed>0 And left(clientid,2)=left(b.clientid,2) and  substring(ClientLoan1ID,16,2) in (Select ProductId From Products Where loan_category=0 and  BCIDNO<>'0' and BCIDNO<>'5') )'#BCDueAmount',
(Select  Count(ClientLoan1AmountDisbursed) From Cds2 Where ClientLoan1AmountDisbursed>0 And left(clientid,2)=left(b.clientid,2) and  substring(ClientLoan1ID,16,2) in (Select ProductId From Products Where loan_category=0 and  BCIDNO<>'0' and BCIDNO<>'5') )'#BCLoans',
(Select  ISNULL(Sum(ClientLoan1AmountDisbursed),0) From Cds2 Where ClientLoan1AmountDisbursed>0 And left(clientid,2)=left(b.clientid,2) and  substring(ClientLoan1ID,16,2) in (Select ProductId From Products Where loan_category=0 and  BCIDNO<>'0' and BCIDNO<>'5') )'#BCAmount',
(Select  Count(ClientLoan1AmtDueDisbursed) From Cds2 Where ClientLoan1AmtDueDisbursed>0 And left(clientid,2)=left(b.clientid,2) and  substring(ClientLoan1ID,16,2) in (Select ProductId From Products Where loan_category=0 and   BCIDNO='5') )'#SidbiDueLoans',
(Select  ISNULL(Sum(ClientLoan1AmtDueDisbursed),0) From Cds2 Where ClientLoan1AmtDueDisbursed>0 And left(clientid,2)=left(b.clientid,2) and  substring(ClientLoan1ID,16,2) in (Select ProductId From Products Where loan_category=0 and BCIDNO='5') )'#SidbiDueAmount',
(Select  Count(ClientLoan1AmountDisbursed) From Cds2 Where ClientLoan1AmountDisbursed>0 And left(clientid,2)=left(b.clientid,2) and  substring(ClientLoan1ID,16,2) in (Select ProductId From Products Where loan_category=0 and BCIDNO='5') )'#SIDBI',
(Select  ISNULL(Sum(ClientLoan1AmountDisbursed),0) From Cds2 Where ClientLoan1AmountDisbursed>0 And left(clientid,2)=left(b.clientid,2) and  substring(ClientLoan1ID,16,2) in (Select ProductId From Products Where loan_category=0 and BCIDNO='5') )'#SIDBIAmount'
from Prevcds2 as b  where left(clientid,2) in('14','07','11','13','17','16') and ClientLoan1AmtDueDisbursed>0
--and substring(ClientLoan1ID,16,2) in (Select ProductId From Products Where loan_category=0)
 group by left(clientid,2) order by left(clientid,2) Asc

 ----(2) BRANCH WISE  (APPCASHPOR) 

select (Select CHID from Branches Where Branchid=LEFT(clientid,5))'CHID', left(clientid,5) as BranchID,
(Select  Count(ClientLoan1AmtDueDisbursed) From Cds2 Where ClientLoan1AmtDueDisbursed>0 And left(clientid,5)=left(b.clientid,5) )'#DueAlc',
SUM(ClientLoan1AmtDueDisbursed) as #DueAmt,  (Select  Count(ClientLoan1AmountDisbursed) From Cds2 Where ClientLoan1AmountDisbursed>0 And left(clientid,5)=left(b.clientid,5) )'#DisAlc',
SUM(ClientLoan1AmountDisbursed) as #DisAmt
from Prevcds2 as b  where left(clientid,2) in ('14','07','11','13','17','16','38') group by left(clientid,2),left(clientid,5) order by left(clientid,2),CHID,left(clientid,5)


------(A)----SIDBI ---- (1ST TIME RATIO)  (APPCASHPOR) 

	Select LEFT(ClientId,2) as RID,LEFT(ClientId,5) as BranchID,ClientId,
(Select UPPER(TargetName) From ClientLoanProposal Where LoanProposalID=b.LoanProposalID)'ClientName',
ClientLoan1ProductName as ProductName,ClientLoan1AmtDueDisbursed as DueDisbursed,ClientLoan1AmountDisbursed as AMTDisbursed,
CASE WHEN ClientLoan1AmountDisbursed>0 THEN 'LOAN Disbursed' ELSE 'Loan NOT Disbursed' END as Remarks
  from Cds2 as b Where   substring(ClientLoan1ID,16,2) in (Select ProductId From Products Where loan_category=0 and BCIDNO='5') 
And  ClientLoan1AmtDueDisbursed>0 and  left(clientid,2) in ('14','07','11','13','17','16')
Order by RID desc,BranchID


----(3)-- ZONE REPORT CURRENT proposal REVIEW REPORT  (APPCASHPOR) 

declare @date date=(convert(nvarchar(10),getdate(),23))
Select CHID as [CHIB id], BRANCHID,
(Select Count(Clientid) from ClientLoanProposal With(NoLock) Where ProposalDate=@date and  ProductCategory in ('IGL', 'IGL BADA LOAN','BC', 'BC BADA LOAN','SIDBI','OWN FLEXI','BC FLEXI','BRIDGE') and LEFT(Clientid,5)=B.BranchID)'NUM_Loan',
(Select ISNULL(SUM(ClientRequestedAmount),0) from ClientLoanProposal With(NoLock) Where ProposalDate=@date and  ProductCategory in ('IGL', 'IGL BADA LOAN','BC', 'BC BADA LOAN','SIDBI','OWN FLEXI','BC FLEXI','BRIDGE') and LEFT(Clientid,5)=B.BranchID)'Loan_Amount',
(Select Count(Clientid) from ClientLoanProposal With(NoLock) Where FinalReviewDate=@date and  ProductCategory in ('IGL', 'IGL BADA LOAN','BC', 'BC BADA LOAN','SIDBI','OWN FLEXI','BC FLEXI','BRIDGE') and LEFT(Clientid,5)=B.BranchID)'BMReview_Loan',
(Select ISNULL(SUM(LoanAmountApproved),0) from ClientLoanProposal With(NoLock) Where FinalReviewDate=@date and  ProductCategory in ('IGL', 'IGL BADA LOAN','BC', 'BC BADA LOAN','SIDBI','OWN FLEXI','BC FLEXI','BRIDGE') and LEFT(Clientid,5)=B.BranchID)'BMReview_Amount'
from Branches b With(NoLock) Where DissolvedDate is null and LEFT(b.Branchid,2) in ('05') and CHName !='0' Order by LEFT(b.Branchid,2),ChId,BRANCHID


--Proposal Entry Report
----------------------------------------------------------------------------------------------------------------------------
Select CHID as [CHIB id], BRANCHID,
(Select Count(Clientid) from ClientLoanProposal With(NoLock) Where ProposalDate='2024-08-10' and  ProductCategory in ('IGL', 'IGL BADA LOAN','BC', 'BC BADA LOAN','SIDBI','OWN FLEXI','BC FLEXI','BRIDGE') and LEFT(Clientid,5)=B.BranchID)'NUM_Loan',
(Select ISNULL(SUM(ClientRequestedAmount),0) from ClientLoanProposal With(NoLock) Where ProposalDate='2024-08-10' and  ProductCategory in ('IGL', 'IGL BADA LOAN','BC', 'BC BADA LOAN','SIDBI','OWN FLEXI','BC FLEXI','BRIDGE') and LEFT(Clientid,5)=B.BranchID)'Loan_Amount',
(Select Count(Clientid) from ClientLoanProposal With(NoLock) Where FinalReviewDate='2024-08-10' and  ProductCategory in ('IGL', 'IGL BADA LOAN','BC', 'BC BADA LOAN','SIDBI','OWN FLEXI','BC FLEXI','BRIDGE') and LEFT(Clientid,5)=B.BranchID)'BMReview_Loan',
(Select ISNULL(SUM(LoanAmountApproved),0) from ClientLoanProposal With(NoLock) Where FinalReviewDate='2024-08-10' and  ProductCategory in ('IGL', 'IGL BADA LOAN','BC', 'BC BADA LOAN','SIDBI','OWN FLEXI','BC FLEXI','BRIDGE') and LEFT(Clientid,5)=B.BranchID)'BMReview_Amount'
from Branches b With(NoLock) Where DissolvedDate is null and LEFT(b.Branchid,2) in ('05') and CHName !='0' Order by LEFT(b.Branchid,2),ChId,BRANCHID
----------------------------------------------------------------------------------------------------------------------------

--Proposal Entry Report
----------------------------------------------------------------------------------------------------------------------------
select 		
	distinct(b.DistrictName) as [Region Name], b.CHID as [CHIB ID],b.BranchID as [Branch ID], b.BranchName as [Branch Name],	
	isnull(count(case when clp.ProposalDate = cast(getdate() as date) then clp.ClientID end), 0) as [Num Loans],	
	isnull(sum(case when clp.ProposalDate = cast(getdate() as date) then clp.ClientRequestedAmount end), 0) as [Loan Amount],	
	isnull(count(case when clp.ProposalDate = cast(getdate() as date) and clp.BMID > '0' then clp.ClientID end), 0) as [BmReview_Loan],	
	isnull(sum(case when clp.ProposalDate = cast(getdate() as date) and clp.BMID > '0' then clp.LoanAmountApproved end), 0) as [Loan Amount]	
From 		
	Branches b with(nolock) 	
		inner join ClientLoanProposal clp with(nolock) on left(clp.ClientID, 5) = b.BranchID
Where		
	b.DissolvedDate is null and b.Zone in ('Ballia ZONE') and b.CHNAME <> '0' and B.BranchID like '05%'	
Group By		
	b.DistrictName, b.CHID, b.BranchID, b.BranchName	
Order By		
	b.DistrictName, b.CHID, b.BranchName	
---------------------------------------------------------------------------------------------------------------------------


-----------CURRENT proposal Entry and REVIEW REPORT  (APPCASHPOR)

select B.CHID,left(clp.clientid,5) as BranchID,count(clp.proposaldate) as StaffProposalEntry,isnull(sum(clp.ClientRequestedAmount),0) as EntryAmount, 
count(clp.Finalreviewdate) as BmReview,IsnUll(sum(clp.LoanAmountApproved),0) as BMReviewAmount from clientloanproposal as clp
inner join branches as b on b. branchid = left(clp.clientid,5)
where clp.proposaldate = cast (getdate() as date)  and clp.clientid like '05%' and B.ChName != '0'
group by B.CHID,left(clp.clientid,5)
Order by B.CHID,left(clp.clientid,5)


/*
	Select LEFT(ClientId,2) as RID,LEFT(ClientId,5) as BranchID,ClientId,
(Select UPPER(TargetName) From ClientLoanProposal Where LoanProposalID=b.LoanProposalID)'ClientName',
ClientLoan1ProductName as ProductName,ClientLoan1AmtDueDisbursed as DueDisbursed,
CASE WHEN ClientLoan1AmountDisbursed>0 THEN 'LOAN Disbursed' ELSE 'Loan NOT Disbursed' END as Remarks
  from Cds2 as b Where   substring(ClientLoan1ID,16,2) in (Select ProductId From Products Where loan_category=0 and BCIDNO='5') 
And  ClientLoan1AmtDueDisbursed>0 and ClientLoan1AmountDisbursed='0' and  left(clientid,2) in ('14','07','11','13','17','16')
Order by RID desc,BranchID



--select left(clientid,2) as RegionID, (Select DISTINCT(DistrictName) From Branches Where Dissolveddate is null and LEFT(BranchID,2)=left(b.clientid,2) )'RegionName', (Select  Count(ClientLoan1AmtDueDisbursed) From Cds2 Where ClientLoan1AmtDueDisbursed>0 And left(clientid,2)=left(b.clientid,2) )'#Loans',
--SUM(ClientLoan1AmtDueDisbursed) as #Due,  (Select  Count(ClientLoan1AmountDisbursed) From Cds2 Where ClientLoan1AmountDisbursed>0 And left(clientid,2)=left(b.clientid,2) )'#LoansDisburse',  SUM(ClientLoan1AmountDisbursed) as #DueDisburse
-- from Prevcds2 as b  where left(clientid,2) in('14','07','11','13','17','16') group by left(clientid,2) order by left(clientid,2) Asc

*/