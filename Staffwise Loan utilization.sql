--StaffWise LUC 
  set transaction isolation level read uncommitted
select LEFT(ClientLoanID,5)as RID,
(select branchname  from Branches b where b.branchid=LEFT(ClientLoanID,5))as BranchName,
COUNT(ClientLoanID ) as TotalDisb, sum(case when cm_reviewDate is not null then 1 end )as CMReview,
sum(case when bm_reviewDate  is not null then 1 end )as BMReview,
sum(case when Am_reviewDate  is not null then 1 end )as CHIBReview
from Loan_Utilisation where CONVERT(varchar (21),loandisbursementdate ,23)<= CONVERT(varchar(21),GETDATE()-15,23) and 
 ClientLoanID in ( select ClientLoanID  from ClientLoanProposal where PrincipalOutstanding >1 and   
 loandisbursementdate>='2021-04-01' and loandisbursementdate<='2022-03-31' 
 and LEFT(ClientID,2) in('31')
and LEFT(ProductCategory,2) not IN('EM','EN','WA','FL'))
group by LEFT(ClientLoanID,5) 
order by LEFT(ClientLoanID,5)
