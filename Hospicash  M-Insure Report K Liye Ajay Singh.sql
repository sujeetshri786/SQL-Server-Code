-------HOSPICASH REPORT CLIENT WISE NICHE DATABASE MEI--------------------------
select b.BranchId,BranchName,clp.ClientId,Cls.ClientLoanid,TargetName,HusbandName,HealthInsuranceDate,HealthInsurance,HealthInsuranceSpouse 
from clientloansubscription as cls with(nolock) join clientloanproposal clp with(nolock) on cls.loanproposalid=clp.loanproposalid
join branches as b with(nolock) on b.branchid=left(clp.Loanproposalid,5)
  where cls.clientloanid like '14:05%' and cast(actualdisbursementdate as date)>='2022-04-01'
and (healthinsurance>0 or healthinsurancespouse>0)
order by Cls.ClientLoanid,HealthInsuranceDate


-------M-INSURE REPORT CLIENT WISE UPAR DATABASE MEI--------------------------
select b.branchid,BranchName,Staffname,c.StaffID,ClientID,Clientname,DueAmount,CollAmount,a.entrydate as minsureregistrationdate,a.CollDate as enrollmentdate,a.ServiceExpiryDate,PaymentMode 
from MInsureSurvey a inner join Branches b on b.BranchID=a.BranchID Inner join centers c on c.centerID=a.CenterID Inner Join FieldStaff f on f.staffID=c.staffID 
where clientid like '28%' and CollDate between '2025-01-01' and '2025-03-31'
order by BranchID


-------HOSPICASH REPORT BRANCH WISE NICHE DATABASE MEI--------------------------
select b.BranchId,BranchName,count(cls.ClientloanId) as No_Of_Clients,sum(HealthInsurance)as client_HealthInsurance,sum(HealthInsuranceSpouse) as Spouse_HealthInsurance
from clientloansubscription as cls with(nolock) join clientloanproposal clp with(nolock) on cls.loanproposalid=clp.loanproposalid
join branches as b with(nolock) on b.branchid=left(clp.Loanproposalid,5)
where cls.clientloanid like '14%' and cast(actualdisbursementdate as date) between '2023-01-01' and '2023-01-31'
and (healthinsurance>0 or healthinsurancespouse>0)
group by b.BranchId,BranchName
order by b.BranchId,BranchName

-------M-INSURE REPORT BRANCH WISE UPAR DATABASE MEI--------------------------
--use appcashpor
select BranchID,count(ClientID) as TotalClients,sum(collamount) as TotalAmount,
COUNT(case when PaymentMode='By self'  then ClientID end) as 'TotalBySelf',
  sum(case when PaymentMode='By self'  then collamount end) as 'TotalAmtBySelf',
  COUNT(case when PaymentMode='By cashpor'  then ClientID end) as 'TotalByCashpor',
   isnull(sum(case when PaymentMode='By cashpor'  then collamount end),0) as 'TotalAmtByCashpor'
from MInsureSurvey where clientid like '10%' and CollDate between '2025-08-01' and '2025-08-31'
group by branchid
order by branchid

