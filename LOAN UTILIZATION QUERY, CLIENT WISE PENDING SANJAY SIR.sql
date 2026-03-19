
------------------LOAN UTILIZATION QUERY-------------
select ((select UPPER(DistrictName)  from Branches with(nolock) 
where BranchID =LEFT(ClientLoanID ,5))) as 'RegionName',
CONCAT(LEFT(ClientLoanID ,5) ,' / ',(select UPPER(BranchName)  from Branches with(nolock) 
where BranchID =LEFT(ClientLoanID ,5))) as 'BranchName',UPPER(FORMAT(LoanDisbursementDate, 'MMM-yyyy')) AS MonthYear
,COUNT(ClientLoanID )as TotalDisb,
ISNULL( sum ( case when cm_reviewDate IS not null then 1 end  ),0) as CmReview,
ISNULL( sum ( case when bm_reviewDate  IS not null then 1 end  ),0) as BMReview,
isnull(sum ( case when Am_reviewDate  IS not null then 1 end  ),0) as CHIBReview,
isnull(sum ( case when Aro_ReviewDate  IS not null then 1 end  ),0) as AROReview
from Loan_Utilisation where loandisbursementdate between '2025-10-01' and '2025-12-31' and LEFT(ClientLoanID,2) in ('22','10','21') 
group by LEFT(ClientLoanID ,5) ,FORMAT(LoanDisbursementDate, 'MMM-yyyy'),LEFT(ClientLoanID,2)
order by LEFT(ClientLoanID ,5),FORMAT(LoanDisbursementDate, 'MMM-yyyy') 

----==========CLIENT WISE PENDING========================================================================================================================================================

select b.DistrictName RegionName,Left(ClientLoanID,5) BranchId, Upper(b.BranchName) BranchName, ClientLoanID, Upper(Targets.targetName) ClientName,
FORMAT(CAST(loandisbursementdate AS date), 'MMM-yyyy') AS [MonthYear], 
loandisbursementdate,loanamountdisbursed,  
case when cm_reviewDate is not null then 'LUC Done BY CM' 
when bm_reviewDate is not null then 'LUC Done BY BM' 
when Am_reviewDate is not null then 'LUC Done BY CHIB' 
when Aro_ReviewDate is not null then 'LUC Done BY ARO' else 'LUC PENDING' End 
  Remarks,cm_reviewDate , bm_reviewDate  ,Am_reviewDate,Aro_ReviewDate
from Loan_Utilisation inner join Targets on                Targets.targetID=Loan_Utilisation.targetID
inner join Branches b on b.BranchId=Left(ClientLoanID,5)
where loandisbursementdate between '2025-04-01' and '2026-01-17' and 
 LEFT(ClientLoanID,2) in ('22','10','21') and
(cm_reviewDate is null and  bm_reviewDate is null and Am_reviewDate is null and Aro_ReviewDate is null)
order by ClientLoanID 

