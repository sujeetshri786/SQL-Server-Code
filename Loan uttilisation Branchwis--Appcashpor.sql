--Loan uttilisation Branchwise--Appcashpor

select LEFT(ClientLoanID,5)as BID,
(select branchname from Branches b where b.branchid=LEFT(ClientLoanID,5))as BranchName
,COUNT(ClientLoanID ) as TotalDisb, sum(case when cm_reviewDate is not null then 1 end )as CMReview,
sum(case when bm_reviewDate  is not null then 1 end )as BMReview,
sum(case when Am_reviewDate  is not null then 1 end )as CHIBReview,
sum(case when aro_reviewdate  is not null then 1 end )as AROReview
from Loan_Utilisation where 
/*--CONVERT(varchar (10),loandisbursementdate ,23)<= CONVERT(varchar(10),GETDATE()-15,23) and */
 ClientLoanID in ( select ClientLoanID  from ClientLoanProposal where PrincipalOutstanding >1)
  and loandisbursementdate between '2025-04-01' and '2026-03-03'
  and LEFT(clientloanid,2)='05'
	/*--and LEFT(ProductCategory ,2) not IN('EM','EN','WA','FL'))*/
group by LEFT(ClientLoanID,5)
order by LEFT(ClientLoanID,5)
