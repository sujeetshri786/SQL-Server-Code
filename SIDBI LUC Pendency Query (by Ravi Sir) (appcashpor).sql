-----------SIDBI LUC Pendency Query (by Ravi Sir) (appcashpor)-----------

------------ BM Review ------------
Select B.DistrictName,B.BranchID,B.BranchName,CC.CenterID,CC.CenterName,C.ClientID,T.TargetName As ClientName,LU.ClientLoanID,LU.loanamountdisbursed,
isNULL(lu.BM_Purpose,0) as Bm_purpose,isNULL(LU.BM_Income_Other,0) as Bm_income_other,isNULL(Lu.BM_NonIncome,0) as Bm_nonincome,isNULL(Lu.BM_Unutilised,0) as Bm_unutilised,
CONVERT(varchar(10),LU.loandisbursementdate,103) As loandisbursementdate,CONVERT(varchar(10),LU.bm_reviewDate,103) As BMReviewDate,
Case When LU.bm_reviewDate IS NULL Then 'Not Reviewed' Else 'Reviewed' End As BMReviewStatus from Loan_Utilisation as LU With (Nolock)
inner join Targets As T With (Nolock) On LU.targetID=T.TargetID and LEFT(LU.ClientLoanID,2) in ('05') 
and CONVERT(varchar(10),LU.loandisbursementdate,23)>='2023-04-01' and substring(clientloanid,16,2) in
(select productid from products where type like'%BC Sidbi%') and LU.BM_reviewDate IS NULL
inner Join Branches As B With (Nolock) On T.BranchID=B.BranchID and B.DissolvedDate is null 
inner join Clients AS C With (Nolock) On T.TargetID=C.TargetID and C.DropOutStatus=0
inner join Centers As CC With (Nolock) On T.CenterID=CC.CenterID and CC.DissolvedDate is null
inner join FieldStaff as Fs With (Nolock) On CC.StaffID=Fs.StaffID and Fs.ExitDate is null
inner join clientloanproposal clp With (Nolock) on LU.ClientLoanId=clp.clientloanid and principaloutstanding>1
group by B.DistrictName,B.BranchID,B.BranchName,CC.CenterID,CC.CenterName,C.ClientID,T.TargetName,LU.ClientLoanID,LU.loanamountdisbursed,
lu.bm_purpose,LU.bm_income_other,Lu.bm_nonincome,Lu.bm_unutilised,
LU.loandisbursementdate,LU.bm_reviewDate
order by B.BranchID,CC.CenterID,C.ClientID,LU.ClientLoanID,LU.loandisbursementdate

------------------------- AM Review ------------------------------------------
Select B.DistrictName,B.BranchID,B.BranchName,CC.CenterID,CC.CenterName,C.ClientID,T.TargetName As ClientName,LU.ClientLoanID,LU.loanamountdisbursed,
isNULL(lu.Am_purpose,0) as Am_purpose,isNULL(LU.Am_income_other,0) as Am_income_other,isNULL(Lu.Am_nonincome,0) as Am_nonincome,isNULL(Lu.Am_unutilised,0)
as Am_unutilised,
CONVERT(varchar(10),LU.loandisbursementdate,103) As loandisbursementdate,CONVERT(varchar(10),LU.Am_reviewDate,103) As AMReviewDate,
Case When LU.Am_reviewDate IS NULL Then 'Not Reviewed' Else 'Reviewed' End As AMReviewStatus from Loan_Utilisation as LU With (Nolock)
inner join Targets As T With (Nolock) On LU.targetID=T.TargetID and LEFT(LU.ClientLoanID,2) in ('05') and CONVERT(varchar(10),LU.loandisbursementdate,23) >=
'2025-04-01' and substring(clientloanid,16,2) in
(select productid from products where type like'%BC Sidbi%') and LU.am_reviewDate IS NULL
inner Join Branches As B With (Nolock) On T.BranchID=B.BranchID and B.DissolvedDate is null  
inner join Clients AS C With (Nolock) On T.TargetID=C.TargetID and C.DropOutStatus=0
inner join Centers As CC With (Nolock) On T.CenterID=CC.CenterID and CC.DissolvedDate is null
inner join clientloanproposal clp With (Nolock) on LU.ClientLoanId=clp.clientloanid and principaloutstanding>1
group by B.DistrictName,B.BranchID,B.BranchName,CC.CenterID,CC.CenterName,C.ClientID,T.TargetName,LU.ClientLoanID,LU.loanamountdisbursed,
lu.Am_purpose,LU.Am_income_other,Lu.Am_nonincome,Lu.Am_unutilised,
LU.loandisbursementdate,LU.Am_reviewDate
