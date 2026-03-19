--SIDBI LUC Pending and Done

select B.Zone,b.DistrictName, B.Branchid,b.BranchName,clientloanid,Targetname,HusbandName,loanDisbursementdate,CM_reviewdate,BM_reviewdate,AM_reviewdate,
Aro_ReviewDate,Fcreviewdate

from Loan_Utilisation  l (nolock) inner join Targets t (nolock) on t.targetid=l.targetid
inner join Branches b (nolock) on b.Branchid=left(clientloanid,5)
where loandisbursementdate>='2023-04-01' and SUBSTRING(clientloanid,16,2) in('5X','6D','6E','6F','6G','6H','6I','6J','6X','6Y','H6','H8','Q0','Q1','Q2','Q3','Q4','Q5','Q6','W6')
and left(clientloanid,2) in('05','14')
order by b.Branchid,loanDisbursementdate


--Select * from Loan_Utilisation

---------------------------
select B.Zone,b.DistrictName, B.Branchid,b.BranchName,clientloanid,Targetname,HusbandName,
loanDisbursementdate,CM_reviewdate,BM_reviewdate,AM_reviewdate,Aro_ReviewDate,Fcreviewdate
from Loan_Utilisation  l (nolock) inner join Targets t (nolock) on t.targetid=l.targetid
inner join Branches b (nolock) on b.Branchid=left(clientloanid,5)
where loandisbursementdate Between'2024-04-01' and '2024-06-30' and SUBSTRING(clientloanid,16,2) 
in('5X','6X','6Y','H6','H8','W6')and left(clientloanid,2) in('05')
order by b.Branchid,loanDisbursementdate

--------------------------
select B.Zone,b.DistrictName, B.Branchid,b.BranchName,clientloanid,Targetname,HusbandName,
loanDisbursementdate,CM_reviewdate,BM_reviewdate,AM_reviewdate,Aro_ReviewDate,Fcreviewdate
from Loan_Utilisation  l (nolock) inner join Targets t (nolock) on t.targetid=l.targetid
inner join Branches b (nolock) on b.Branchid=left(clientloanid,5)
where loandisbursementdate Between'2024-04-01' and '2026-01-06' and SUBSTRING(clientloanid,16,2) 
in('5X','6D','6E','6F','6G','6H','6I','6J','6X','6Y','H6','H8','Q0','Q1','Q2','Q3','Q4','Q5','Q6','W6')and left(clientloanid,2) in('05')
order by b.Branchid,loanDisbursementdate


------------------------
select B.Zone,b.DistrictName, B.Branchid,b.BranchName,clientloanid,Targetname,HusbandName,
loanDisbursementdate,CM_reviewdate,BM_reviewdate,AM_reviewdate CHIBReviewDate,Aro_ReviewDate,Fcreviewdate
from Loan_Utilisation  l (nolock) inner join Targets t (nolock) on t.targetid=l.targetid
inner join Branches b (nolock) on b.Branchid=left(clientloanid,5)
inner join Products p on p.ProductID=SUBSTRING(l.clientloanid,16,2)
where loandisbursementdate Between'2025-04-01' and '2026-03-07' and  p.type Like '%SIDBI%' and left(clientloanid,2) in('05')
order by b.Branchid,loanDisbursementdate