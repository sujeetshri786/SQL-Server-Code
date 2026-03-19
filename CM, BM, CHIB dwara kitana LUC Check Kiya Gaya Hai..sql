--CM, BM, CHIB dwara kitana LUC Check Kiya Gaya Hai Appcashpor

select LEFT(ClientLoanID,5)as BID,
(select branchname from Branches b where b.branchid=LEFT(ClientLoanID,5))as BranchName
,COUNT(ClientLoanID ) as TotalDisb, ISNULL(sum(case when cm_reviewDate is not null then 1 end ),0)as CMReview,
ISNULL(sum(case when bm_reviewDate  is not null then 1 end ),0)as BMReview,
ISNULL(sum(case when Am_reviewDate  is not null then 1 end ),0)as CHIBReview,
ISNULL(sum(case when aro_reviewdate  is not null then 1 end ),0)as AROReview,
(ISNULL(sum(case when CM_reviewDate  is not null then 1 end ),0)*100/COUNT(ClientLoanID )) as CMPercent,
(ISNULL(sum(case when bm_reviewDate  is not null then 1 end ),0)*100/COUNT(ClientLoanID )) as BMPercent,
(ISNULL(sum(case when Am_reviewDate  is not null then 1 end ),0)*100/COUNT(ClientLoanID )) as CHIBPercent,
(ISNULL(sum(case when aro_reviewdate  is not null then 1 end ),0)*100/COUNT(ClientLoanID )) as AROPercent
from Loan_Utilisation where 
--CONVERT(varchar (10),loandisbursementdate ,23)<= CONVERT(varchar(10),GETDATE()-15,23) and 
 ClientLoanID in ( select ClientLoanID  from ClientLoanProposal where PrincipalOutstanding >1)
  and loandisbursementdate between '2025-08-01' and '2025-11-30'
  and LEFT(clientloanid,2)='05'
   --and substring(clientloanid,16,2) not IN(select productid from products where (type  like'%SIDBI%' or Name  like'%Flex%' or name  like'%bridge%'))
group by LEFT(ClientLoanID,5)
order by LEFT(ClientLoanID,5)
