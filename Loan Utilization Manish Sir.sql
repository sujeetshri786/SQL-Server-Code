--Manish sir
-----------Loan Utilization check on month-----------

select LEFT(ClientLoanID ,5) as BID,(select BranchName  from Branches with(nolock) 
where BranchID =LEFT(ClientLoanID ,5)) as 'BranchName',
--DATENAME (MONTH ,loandisbursementdate )as Month,COUNT(ClientLoanID )as TotalDisb,
ISNULL( sum ( case when cm_reviewDate IS not null then 1 end  ),0) as CmReview,
ISNULL( sum ( case when bm_reviewDate  IS not null then 1 end  ),0) as BMReview,
isnull(sum ( case when Am_reviewDate  IS not null then 1 end  ),0) as CHIBReview,
isnull(sum ( case when Aro_ReviewDate  IS not null then 1 end  ),0) as AROReview
from Loan_Utilisation where Aro_ReviewDate between '2022-04-01' and '2022-12-01' 
  and ClientLoanID like '14%'
group by LEFT(ClientLoanID ,5) 
order by LEFT(ClientLoanID ,5)

------------------LOAN UTILIZATION QUERY-------------

select LEFT(ClientLoanID ,5) as BID,(select BranchName  from Branches with(nolock) 
where BranchID =LEFT(ClientLoanID ,5)) as 'BranchName',DATEPART (YEAR ,loandisbursementdate )as Year ,
DATENAME (MONTH ,loandisbursementdate )as Month,COUNT(ClientLoanID )as TotalDisb,
ISNULL( sum ( case when cm_reviewDate IS not null then 1 end  ),0) as CmReview,
ISNULL( sum ( case when bm_reviewDate  IS not null then 1 end  ),0) as BMReview,
isnull(sum ( case when Am_reviewDate  IS not null then 1 end  ),0) as CHIBReview,
isnull(sum ( case when Aro_ReviewDate  IS not null then 1 end  ),0) as AROReview
from Loan_Utilisation where loandisbursementdate between '2022-04-01' and '2022-12-01' and ClientLoanID like '14%'
group by LEFT(ClientLoanID ,5) ,DATEPART (YEAR ,loandisbursementdate ), DATENAME (MONTH ,loandisbursementdate ),DATEPART (MONTH  ,loandisbursementdate )
order by LEFT(ClientLoanID ,5),DATEPART (YEAR ,loandisbursementdate ),DATEPART (MONTH  ,loandisbursementdate )

