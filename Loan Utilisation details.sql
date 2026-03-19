----- Loan Utilization Report ek sath CM, BM, CHIB & ARO k liye (APPCASHPOR)

declare @sdate datetime ='2024-04-01'
select LEFT(ClientLoanID,5)as BID,
(select branchname from Branches b where b.branchid=LEFT(ClientLoanID,5))as BranchName
,COUNT( case when  ClientLoanID IS not null and loandisbursementdate between CONVERT(varchar(10),@sdate -25,23)
and  CONVERT(varchar(10),@sdate -15,23) then 1 end   ) as TotalDisb_CM

,COUNT( case when  ClientLoanID IS not null and loandisbursementdate between CONVERT(varchar(10),@sdate -25,23)
and  CONVERT(varchar(10),@sdate -15,23) and cm_reviewDate IS not null  then 1 end   ) as CMReview

,COUNT( case when  ClientLoanID IS not null and loandisbursementdate between CONVERT(varchar(10),@sdate -90,23)
and  CONVERT(varchar(10),@sdate -45,23) then 1 end   ) as TotalDisb_BM

,COUNT( case when  ClientLoanID IS not null and loandisbursementdate between CONVERT(varchar(10),@sdate -90,23)
and  CONVERT(varchar(10),@sdate -45,23) and bm_reviewDate  IS not null  then 1 end   ) as BMReview

,COUNT( case when  ClientLoanID IS not null and loandisbursementdate between CONVERT(varchar(10),@sdate -120,23)
and  CONVERT(varchar(10),@sdate -60,23) then 1 end   ) as TotalDisb_CHIB

,COUNT( case when  ClientLoanID IS not null and loandisbursementdate between CONVERT(varchar(10),@sdate -120,23)
and  CONVERT(varchar(10),@sdate -60,23) and Am_reviewDate  IS not null  then 1 end   ) as CHIBReview

,COUNT( case when  ClientLoanID IS not null and loandisbursementdate between CONVERT(varchar(10),@sdate -120,23)
and  CONVERT(varchar(10),@sdate -60,23) then 1 end   ) as TotalDisb_ARO

,COUNT( case when  ClientLoanID IS not null and loandisbursementdate between CONVERT(varchar(10),@sdate -120,23)
and  CONVERT(varchar(10),@sdate -60,23) and Aro_ReviewDate   IS not null  then 1 end   ) as AROReview
from Loan_Utilisation where
ClientLoanID in ( select ClientLoanID  from ClientLoanProposal where PrincipalOutstanding >1 and LEFT(ClientID,2)='14')
---and LEFT(ProductCategory ,2) not IN('EM','EN','WA','FL'))
group by LEFT(ClientLoanID,5)
order by LEFT(ClientLoanID,5)
